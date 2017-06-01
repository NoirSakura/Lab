%{
	#include <stdlib.h>
	#include "lab2aux.h"
	#include "lab2syx.h"
	
	void yyerror(char*);
%}

%option yylineno
DELIM 			[" "\n\t\r]
WHITESPACE 		{DELIM}+
LETTER			[a-zA-Z]
DIGIT			[0-9]
IDN				{LETTER}({LETTER}|{DIGIT})*
INT10			0|[1-9]{DIGIT}*	
INT8			0[0-7]+
ILLEGALINT8 	({INT8}|"0")([89a-wyzA-WYZ])({LETTER}|{DIGIT})*
INT16			0[xX](0|([1-9]|[a-fA-F])({DIGIT}|[a-fA-F])*)
ILLEGALINT16 	({INT16}|(0[xX]))[g-zG-Z]({LETTER}|{DIGIT})*
REAL10			{INT10}"."{DIGIT}*
REAL8			{INT8}"."[0-7]*
REAL16			{INT16}"."({DIGIT}|[a-fA-F])*
ILLEGALREAL8 	({ILLEGALINT8}"."({LETTER}|{DIGIT})*)|({REAL8}[89a-wyzA-WYZ]({LETTER}|{DIGIT})*)|({INT8}"."[89a-wyzA-WYZ]({LETTER}|{DIGIT})*)
ILLEGALREAL16 	(({ILLEGALINT16}|(0[xX]))"."({LETTER}|{DIGIT})*)|({REAL16}[g-zG-Z]({LETTER}|{DIGIT})*)|({INT16}"."[g-zG-Z]({LETTER}|{DIGIT})*)

%%
"if"  			{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="if";
					node->expr="if";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return IF;
				} 
"then" 			{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="then";
					node->expr="then";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return THEN;
				} 
"else"  		{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="else";
					node->expr="else";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return ELSE;
				} 
"while" 		{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="while";
					node->expr="while";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return WHILE;
				} 
"do"  			{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="do";
					node->expr="do";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return DO;
				} 
"("				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="(";
					node->expr="(";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return L_BRACKET;
				}
")"				{		
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data=")";
					node->expr=")";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return R_BRACKET;
				}
"+"				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="+";
					node->expr="+";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return PLUS;
				}
"-"				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="-";
					node->expr="-";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return MINUS;
				}
"*"				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="*";
					node->expr="*";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return MULTI;
				}
"/"				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="/";
					node->expr="/";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;return DIV;}
"="				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="=";
					node->expr="=";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;return EQUAL;}
">"				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data=">";
					node->expr=">";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return GT;
				}
"<"				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data="<";
					node->expr="<";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return LT;
				}
";"				{
					struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					node->data=";";
					node->expr=";";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return SEM;
				}
	
{WHITESPACE} 	;
{INT10}   		{	struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					char *text=(char*)malloc(16*sizeof(char));
					strcpy(text,yytext);
					node->data=text;
					node->expr="INT10";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return INT10;} 
{INT8}   		{	struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					char *text=(char*)malloc(16*sizeof(char));
					sprintf(text,"%ld",strtol(yytext,NULL,8));
					node->data=text;
					node->expr="INT8";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return INT8;} 
{INT16}  		{	struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					char *text=(char*)malloc(16*sizeof(char));
					sprintf(text,"%ld",strtol(yytext,NULL,16));
					node->data=text;
					node->expr="INT16";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return INT16;} 
{IDN} 			{	struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					char *text=(char*)malloc(strlen(yytext)*sizeof(char));
					strcpy(text,yytext);
					node->data=text;
					node->expr="IDN";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return IDN;}
{ILLEGALINT8} 	{printf("Error: Illegal INT8 \"%s\" at line %d\n",yytext,yylineno);return INT8;}
{ILLEGALINT16} 	{printf("Error: Illegal INT16 \"%s\" at line %d\n",yytext,yylineno);return INT16;}
{REAL8}  		{	struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					char *text=(char*)malloc(16*sizeof(char));
					sprintf(text,"%.4f",strtof(yytext,NULL));
					node->data=text;
					node->expr="REAL8";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return REAL8;
				} 
{REAL10}  		{	struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					char *text=(char*)malloc(16*sizeof(char));
					sprintf(text,"%.4f",atof(yytext));
					node->data=text;
					node->expr="REAL10";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return REAL10;
					} 
{REAL16} 		{	struct Node* node = (struct Node*)malloc(sizeof(struct Node));
					char *text=(char*)malloc(16*sizeof(char));
					sprintf(text,"%.4f",strtof(yytext,NULL));
					node->data=text;
					node->expr="REAL16";
					node->child=NULL;
					node->child_num=0;
					yylval.NODE = node;
					return REAL16;
				} 
{ILLEGALREAL8} 	{printf("Error: Illegal REAL8 \"%s\" at line %d\n",yytext,yylineno);return REAL8;}
{ILLEGALREAL16} {printf("Error: Illegal REAL16 \"%s\" at line %d\n",yytext,yylineno);return REAL16;}
. 				{printf("Error: Unknown Token \"%s\" at line %d\n",yytext,yylineno);return IDN;}

%%
int yywrap(){return 1;}
