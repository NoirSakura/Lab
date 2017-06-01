%{
	#include <stdio.h>
	#include "lab2aux.h"
	
	#define INPUT_FILE_NAME "bin/lab2.in"
	#define OUTPUT_FILE_NAME "lab2.out"
	
	extern FILE * yyin;
	extern int yylineno;
	extern int yylex();
	extern void yyerror(char*);
	
	int temp = 0;
	int gen_label = 0;
	
	int initQueue(Queue *queue){
		queue->data = (struct Node**)malloc(QUEUE_INIT_SIZE*sizeof(struct Node*));
		if(!queue->data) 
			return OVERFLOW;
		queue->tail = -1;
		queue->head = queue->tail;
		queue->length = 0;
		return OK;
	}

	int destroyQueue(Queue *queue){
		queue->head = queue->tail;
		queue->length = 0;
		free(queue->data);
		return OK;
	}

	int clearQueue(Queue *queue){
		queue->head = queue->tail;
		queue->length = 0;
		return OK;
	}

	int push(Queue *queue, struct Node* node){
		if(queue->length == QUEUE_INIT_SIZE)
			return FULL;
		queue->data[++queue->head]=node;
		++queue->length;
		return OK;  
	}

	struct Node* pop(Queue *queue){
		if(queue->length == 0)
			return NULL;
		--queue->length;
		struct Node* node = queue->data[0];
		for(int i = 0; i < queue->length; i++)
		{
			queue->data[i]=queue->data[i+1];
		}
		queue->head--;
		return node;
	}
	
	void createAST(struct Node* root, FILE *fp){
		Queue queue,child_queue;
		if(initQueue(&queue)==OVERFLOW || initQueue(&child_queue)==OVERFLOW)
		{
			fprintf(fp,"No Enough Space!");
			exit(-1);
		}
		push(&queue,root);
		int depth = 0;
		fprintf(fp,"%d\t:\t%s\n",depth++,root->expr);
		while(depth){
			fprintf(fp,"%d\t:\t",depth);
			while(queue.length!=0)
			{
				struct Node* node = pop(&queue);
				for(int i = 0;i < node->child_num; i++)
				{	
					push(&child_queue,node->child[i]);
					fprintf(fp,"%s ",node->child[i]->expr);
				}
				if(node->child_num!=0)
					fprintf(fp,"\t");
			}
			if(child_queue.length==0)
				break;
			fprintf(fp,"\n");
			while(child_queue.length!=0)
				push(&queue,pop(&child_queue));	
			depth++;
		};
		destroyQueue(&queue);
	}
	
	int gen(struct Node* node, FILE *fp, int label)
	{
		if(strcmp(node->data,"L") == 0)
		{
			return gen(node->child[0],fp,label);
		}
		else if(strcmp(node->data,"LP") == 0)
		{
			return gen(node->child[1],fp,
			gen(node->child[0],fp,label));
		}
		else if(strcmp(node->data,"S;") == 0)
		{
			return gen(node->child[0],fp,label);
		}
		else if(strcmp(node->data,"while C do S") == 0)
		{
			if(gen_label==0)
				fprintf(fp,"L%d:",label);
			gen_label=1;
			fprintf(fp,"goto L%d\n\tgoto L%d\nL%d:",label+1,gen(node->child[1],fp,label),label+1);
			gen_label=1;
			gen(node->child[3],fp,label+1);
			fprintf(fp,"\tgoto L%d\n",label);
			if(gen_label == 0)
				fprintf(fp,"L%d:",label - 1);
		}
		else if(strcmp(node->data,"if C then S") == 0)
		{
			if(gen_label == 0)
				fprintf(fp,"L%d:",label);
			gen(node->child[1],fp,label);
			fprintf(fp,"goto L%d\n",label+1);
			fprintf(fp,"\tgoto L%d\n",label-1);
			fprintf(fp,"L%d:",label+1);
			gen_label = 1;
			int next = gen(node->child[3],fp,label+1);
			if(gen_label == 0)
				fprintf(fp,"\tgoto L%d\n",next);
			gen_label = 0;
		}
		else if(strcmp(node->data,"if C then S else S") == 0)
		{
			if(gen_label == 0)
				fprintf(fp,"L%d:",label);
			gen(node->child[1],fp,label);
			fprintf(fp,"goto L%d\n",label+1);
			fprintf(fp,"\tgoto L%d\n",label+2);
			fprintf(fp,"L%d:",label+1);
			gen_label = 1;
			fprintf(fp,"\tgoto L%d\n",gen(node->child[3],fp,label+1));
			fprintf(fp,"L%d:",label+2);
			gen_label = 1;
			int next = gen(node->child[5],fp,label+2);
			if(gen_label == 0)
				fprintf(fp,"\tgoto L%d\n",next);
			gen_label = 0;
		}
		else if(strcmp(node->data,"E = E") == 0 
			|| strcmp(node->data,"E > E") == 0
			|| strcmp(node->data,"E < E") == 0
			)
		{
			int pri = 0,suf = 0;
			gen(node->child[0],fp,label);
			gen(node->child[2],fp,label);
			if(node->child[0]->data[0] == '#')
				pri++;
			if(node->child[2]->data[0] == '#')
				suf++;
			fprintf(fp,"\tif %s %s %s ",node->child[0]->data + pri,node->child[1]->data,node->child[2]->data + suf);
		}
		else if(strcmp(node->data,"IDN = E") == 0)
		{
			int suf = 0;
			gen(node->child[2],fp,label);
			if(node->child[2]->data[0] == '#')
				suf++;
			fprintf(fp,"\t%s := %s\n",node->child[0]->data,node->child[2]->data + suf);
			return label++;
		}
		else if(strcmp(node->expr,"E") == 0)
		{
			if(node->child_num != 1)
			{
				int pri = 0,suf = 0;
				gen(node->child[0],fp,label);
				gen(node->child[2],fp,label);
				if(node->child[0]->data[0] == '#')
					pri = 1;
				if(node->child[2]->data[0] == '#')
					suf = 1;
				fprintf(fp,"\t%s := %s %s %s\n",node->data + 1,node->child[0]->data + pri,node->child[1]->data,node->child[2]->data + suf);
			}
			else if (strcmp(node->child[0]->expr,"T") ==0)
				gen(node->child[0],fp,label);
		}
		else if(strcmp(node->expr,"T") ==0)
		{
			if(node->child_num != 1)
			{
				int pri = 0,suf = 0;
				if(node->child[0]->child_num != 1)
				{
					gen(node->child[0],fp,label);
					pri++;
				}
				if(node->child[2]->child_num != 1)
				{
					gen(node->child[2],fp,label);
					suf++;
				}
				fprintf(fp,"\t%s := %s %s %s\n",node->data + 1,node->child[0]->data + pri,node->child[1]->data, node->child[2]->data + suf);
			}
			else if(strcmp(node->child[0]->expr,"F") == 0 && node->child[0]->child_num == 3)
				gen(node->child[0]->child[1],fp,label);
		}
		else fprintf(fp,"SB\n");
		return 0;
	}
	
	void createAddressCode(struct Node* root, FILE *fp)
	{
		fprintf(fp,"\n");
		gen(root,fp,1);
	}
%}

%union {
	struct Node* NODE;
}

%token 	<NODE> IF THEN ELSE WHILE DO INT10 INT8 INT16 IDN SEM REAL10 REAL8 REAL16
%left 	<NODE> EQUAL
%left 	<NODE> LT GT
%left 	<NODE> PLUS MINUS
%left 	<NODE> MULTI DIV
%left 	<NODE> L_BRACKET R_BRACKET

%type <NODE> P L S C E T F

%nonassoc THEN
%nonassoc ELSE
	
%start BEGIN
	
%%
BEGIN	:	P 	{
					printf ("Analyze Success!\n");
					FILE *fp;
					fp=fopen(OUTPUT_FILE_NAME,"w");
					createAST($1,fp);
					createAddressCode($1,fp);
					free($1);
					$1=NULL;
					fclose(fp);
				}
		;
P	:	L 		{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="L";
					new_node->expr="P";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	L P 	{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="LP";
					new_node->expr="P";
					new_node->child=(struct Node**)malloc(2*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child_num=2;
					
					$$ = new_node;
				}
	;
L	:	S SEM	{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="S;";
					new_node->expr="L";
					new_node->child=(struct Node**)malloc(2*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child_num=2;
					
					$$ = new_node;
				}
	;
S	:	IDN EQUAL E 
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="IDN = E";
					new_node->expr="S";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;				}
	|	IF C THEN S 
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="if C then S";
					new_node->expr="S";
					new_node->child=(struct Node**)malloc(4*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child[3]=$4;
					new_node->child_num=4;
					
					$$ = new_node;
				}
	|	IF C THEN S ELSE S
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="if C then S else S";
					new_node->expr="S";
					new_node->child=(struct Node**)malloc(6*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child[3]=$4;
					new_node->child[4]=$5;
					new_node->child[5]=$6;
					new_node->child_num=6;
					
					$$ = new_node;
				}
	|	WHILE C DO S
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="while C do S";
					new_node->expr="S";
					new_node->child=(struct Node**)malloc(4*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child[3]=$4;
					new_node->child_num=4;
					
					$$ = new_node;
				}
	;
C	:	E GT E
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="E > E";
					new_node->expr="C";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
				}
	|	E LT E 
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="E < E";
					new_node->expr="C";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
				}
	|	E EQUAL E 
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data="E = E";
					new_node->expr="C";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
				}
	;
E	:	E PLUS T 
				{
					char *temp_str=(char*)malloc(4*sizeof(char));
					sprintf(temp_str,"#t%d",++temp);
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=temp_str;
					new_node->expr="E";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
				}
	|	E MINUS T
				{
					char *temp_str=(char*)malloc(4*sizeof(char));
					sprintf(temp_str,"#t%d",++temp);
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=temp_str;
					new_node->expr="E";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
				}
	|	T 		{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="E";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	;
T	:	F 		{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="T";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	T MULTI F 
				{
					char *temp_str=(char*)malloc(4*sizeof(char));
					sprintf(temp_str,"#t%d",++temp);
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=temp_str;
					new_node->expr="T";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
				}
	|	T DIV F
				{	
					char *temp_str=(char*)malloc(4*sizeof(char));
					sprintf(temp_str,"#t%d",++temp);
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=temp_str;
					new_node->expr="T";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
				} 
	;
F	:	L_BRACKET E R_BRACKET
				{
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$2->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(3*sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child[1]=$2;
					new_node->child[2]=$3;
					new_node->child_num=3;
					
					$$ = new_node;
					printf("%s\n",new_node->data);
				}
	|	IDN   	{ 
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	INT8  	{ 
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	INT10 	{ 
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	INT16 	{ 
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	REAL8 	{ 
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	REAL10 	{ 
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	|	REAL16 	{ 
					struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
					new_node->data=$1->data;
					new_node->expr="F";
					new_node->child=(struct Node**)malloc(sizeof(struct Node*));
					new_node->child[0]=$1;
					new_node->child_num=1;
					
					$$ = new_node;
				}
	;

%%
int main(int argc, char **argv)   
{
	yyin = fopen(INPUT_FILE_NAME, "r");
	while(yyparse()){}
	return 0;
}
void yyerror(char* s)
{
	fprintf(stderr,"Error: %s at line %d\n",s,yylineno);
}
