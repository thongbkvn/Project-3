%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "MiniJava.tab.h"
extern int yylex();
void yyerror(const char*);
%}
%union {
       int num;
       float real;
       char* str;
}
%locations
%start Program
%token KW_CLASS KW_EXTENDS KW_PUBLIC KW_STATIC KW_BOOLEAN KW_STRING KW_FLOAT KW_INT
%token KW_IF KW_WHILE KW_BREAK KW_CONTINUE KW_SWITCH KW_CASE KW_DEFAULT KW_RETURN
%token KW_NEW KW_THIS KW_NULL KW_TRUE KW_FALSE KW_PRINTLN
%token IDENT INT_LITERAL FLOAT_LITERAL STRING_LITERAL

%nonassoc "THEN"
%nonassoc KW_ELSE


%right OP_ASSIGN
%left OP_OR
%left OP_AND
%nonassoc CMP_EQ CMP_NEQ
%nonassoc CMP_GT CMP_LT CMP_GTE CMP_LTE
%left OP_ADD OP_MINUS
%left OP_MULT OP_DIV OP_MOD
%right OP_NOT OP_UNARY
%left  '['  '.'
%nonassoc '('
%nonassoc ')'
%%
Program:		ClassDeclp
			;

ClassDeclp:		ClassDecl
			| ClassDeclp ClassDecl
			;
ClassDecl:		KW_CLASS IDENT ExtendsFrom
	  	  	'{' VarDecls MethodDecls '}'
			;
ExtendsFrom:		/*empty*/
		    	| KW_EXTENDS IDENT
			;
		
VarDecls:		VarDecls VarDecl 
			| /*empty*/
			;
VarDecl:		Type IDENT ';'
	  		| KW_STATIC Type IDENT ';' /*Co the sua thanh AcessModifier Type IDENT*/
			;

MethodDecls:		/*empty*/
			| MethodDecls MethodDecl
			;
MethodDecl:		KW_PUBLIC Type MethodSignature
			'{'VarDecls Statements KW_RETURN Expression ';' '}'
			;
MethodSignature:	IDENT '('MethodParams')' 
			;
			
MethodParams:		/*empty*/ 
			| ListParam 
			;
ListParam:		SingleParam
			| SingleParam ',' ListParam
			;
SingleParam:		Type IDENT
			;

Type :			Type '['']'
     			| KW_BOOLEAN
			| KW_STRING
			| KW_FLOAT
			| KW_INT
		  	| IDENT
			;
Statements:		Statementp
			| /*empty */
			;
Statementp:		Statementp Statement
			| Statement
			;
Statement:		'{'Statements'}'
			| KW_IF '(' Expression ')' Statement %prec "THEN"
			| KW_IF '(' Expression ')' Statement KW_ELSE Statement
			| KW_WHILE '(' Expression ')'Statement
			| KW_PRINTLN '(' Expression ')' ';'
			| ArrayAccess OP_ASSIGN Expression ';'
			| IDENT OP_ASSIGN Expression ';'     
			| KW_BREAK ';'
			| KW_CONTINUE ';'
			| KW_SWITCH '(' Expression ')' '{'
			  Cases
			  KW_DEFAULT ':' Statementp '}'
			;

Cases:		 	Cases Case
		 	| /*empty*/
		 	;
Case:		 	KW_CASE INT_LITERAL ':' Statementp
		 	;


Expression:		Expression OP_OR Expression
			| Expression OP_AND Expression
			| Expression CMP_EQ Expression
			| Expression CMP_NEQ Expression
			| Expression CMP_GT Expression
			| Expression CMP_GTE Expression
			| Expression CMP_LT Expression
			| Expression CMP_LTE Expression
			| Expression OP_ADD Expression
			| Expression OP_MINUS Expression
			| Expression OP_MULT Expression
			| Expression OP_DIV Expression
			| Expression OP_MOD Expression
			| '-' Expression %prec OP_UNARY
			| OP_NOT Expression
			| ArrayAccess
			| LengthAccess
			| Expression '.' Funcall
			| INT_LITERAL
			| FLOAT_LITERAL
			| STRING_LITERAL
			| KW_NULL
			| KW_TRUE
			| KW_FALSE
			| IDENT
			| KW_THIS
			| KW_NEW Type '[' Expression ']'
			| KW_NEW IDENT '('')'	    
			| '(' Expression ')'
			;

LengthAccess:		Expression '.'"length"
			;
ArrayAccess:		IDENT '['Expression']'
			;
Funcall:		IDENT '(' ParamList ')'
			;
ParamList:		/*empty*/
			| ParamList ',' Expression
			| Expression
			;
%%
int main(int argc, char** argv)
{
	extern FILE *yyin;
	++argv; --argc;
	if (argc)
	   yyin = fopen(argv[0], "r");
	else
	{
		printf("No input file\n");
		return 0;
	}
	yyparse();
	return 0;
}


void yyerror(const char *s)
{
  fprintf(stderr, "ERROR line %d: %s\n", yylloc.first_line,  s);
}