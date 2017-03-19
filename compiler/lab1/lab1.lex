%{
#include <stdio.h>
#include <stdlib.h>

#define END 0
#define IF 1
#define THEN 2
#define ELSE 3
#define WHILE 4
#define DO 5
#define PLUS 6
#define MINUS 7
#define MULTI 8
#define RDIV 9
#define LT 10
#define GT 11
#define EQUAL 12
#define LR_BRAC 13
#define RR_BRAC 14
#define SEMIC 15
#define INT10 16
#define INT8 17
#define INT16 18
#define REAL10 19
#define REAL8 20
#define REAL16 21
#define IDN 22

int dec_num;

%}
DELIM [" "\n\t]
WHITESPACE {DELIM}+
LETTER	[a-zA-Z]
DIGIT	[0-9]
IDN		{LETTER}({LETTER}|{DIGIT})*
INT10	0|[1-9]{DIGIT}*	
INT8	0[0-7]+
INT16	0("x"|"X")({DIGIT}|[a-fA-F])+
REAL10	{INT10}"."{DIGIT}+
REAL8	{INT8}"."[0-7][0-7]+
REAL16	{INT16}"."({DIGIT}|[a-fA-F])({DIGIT}|[a-fA-F])+
%%
{WHITESPACE} {}
"if"  {return IF;} 
"then"  {return THEN;} 
"else"  {return ELSE;} 
"while"  {return WHILE;} 
"do"  {return DO;} 
"+"  {return PLUS;} 
"-"  {return MINUS;} 
"*"  {return MULTI;} 
"/"  {return RDIV;} 
"<"  {return LT;} 
">"  {return GT;} 
"("  {return LR_BRAC;} 
")"  {return RR_BRAC;} 
";"	{return SEMIC;}
"=" {return EQUAL;}

{INT10}   {return INT10;} 
{INT8}   {return INT8;} 
{INT16}   {return INT16;} 
{REAL8}  {return REAL8;} 
{REAL10}  {return REAL10;} 
{REAL16}  {return REAL16;} 
{IDN} {return IDN;}

%%
void main()   
{  
	int flag = 1;
    yyin=fopen("example.txt","r");   
	while(flag)
	{
		switch(yylex())
		{
			case IF:
				printf("IF\t_\n");
				break;
			case THEN:
				printf("THEN\t_\n");
				break;
			case ELSE:
				printf("ELSE\t_\n");
				break;
			case WHILE:
				printf("WHILE\t_\n");
				break;
			case DO:
				printf("DO\t_\n");
				break;
			case PLUS:
				printf("+\t_\n");
				break;
			case MINUS:
				printf("-\t_\n");
				break;
			case MULTI:
				printf("*\t_\n");
				break;
			case RDIV:
				printf("/t_\n");
				break;
			case LT:
				printf("<\t_\n");
				break;
			case GT:
				printf(">\t_\n");
				break;
			case EQUAL:
				printf("=\t_\n");
				break;
			case LR_BRAC:
				printf("(\t_\n");
				break;
			case RR_BRAC:
				printf(")\t_\n");
				break;
			case SEMIC:
				printf(";\t_\n");
				break;
			case INT10:
				printf("INT10\t%d\n",atoi(yytext));
				break;
			case INT8:
				printf("INT8\t%d\n",strtol(yytext,NULL,8));
				break;
			case INT16:
				printf("INT16\t%d\n",strtol(yytext,NULL,16));
				break;
			case REAL10:
				printf("REAL10\t%f\n",atof(yytext));
				break;
			case REAL8:
				printf("REAL8\t%f\n",strtof(yytext,NULL));
				break;
			case REAL16:
				printf("REAL16\t%f\n",strtof(yytext,NULL));
				break;
			case IDN:
				printf("IDN\t%s\n",yytext);
				break;
			case END:
				flag = 0;
				break;
		}
	}
    fclose(yyin);
	system("pause");
} 
  
int yywrap(){return 1;}

