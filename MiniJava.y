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
       char* str;
}
%locations
%start Program
%token KW_CLASS KW_EXTENDS KW_PUBLIC KW_STATIC KW_BOOLEAN KW_STRING KW_FLOAT KW_INT END
%token KW_IF KW_WHILE KW_BREAK KW_CONTINUE KW_SWITCH KW_CASE KW_DEFAULT KW_RETURN
%token KW_NEW KW_THIS KW_NULL KW_TRUE KW_FALSE KW_PRINTLN
%token IDENT INT_LITERAL FLOAT_LITERAL STRING_LITERAL

%nonassoc "THEN"
%nonassoc KW_ELSE

%right "STATEMENTS"

%right OP_ASSIGN
%left OP_OR
%left OP_AND
%nonassoc CMP_EQ CMP_NEQ
%nonassoc CMP_GT CMP_LT CMP_GTE CMP_LTE
%left OP_ADD OP_MINUS
%left OP_MULT OP_DIV OP_MOD
%right OP_NOT OP_UNARY "NEW" 
%left "FUNCALL" "SUBSCRIPT"  '.'
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
		
VarDecls:		/*empty*/
			| VarDecls VarDecl
			;
VarDecl:		Type IDENT ';'
	  		| KW_STATIC Type IDENT ';' /*Co the sua thanh AcessModifier Type IDENT*/
			;

MethodDecls:		/*empty*/
			| MethodDecls MethodDecl
			;
MethodDecl:		KW_PUBLIC Type IDENT
			'('MethodParams')'
			'{'VarDecls Statements KW_RETURN Expression ';' '}'
			;
			
MethodParams:		/*empty*/
			| MethodParams ',' MethodParam
			;		
MethodParam:		Type IDENT;

Type :			Type '['']'
     			| KW_BOOLEAN
			| KW_STRING
			| KW_FLOAT
			| KW_INT
		  	| IDENT
			;
Statements:		Statements Statement	%prec "STATEMENTS"
			| /*empty*/ %prec "STATEMENT"
			;
Statementp:		Statements Statement %prec "STATEMENTS"
			;
Statement:		'{'Statements'}'
			| KW_IF '(' Expression ')' Statement %prec "THEN"
			| KW_IF '(' Expression ')' Statement KW_ELSE Statement
			| KW_WHILE '(' Expression ')'Statement
			| KW_PRINTLN '(' Expression ')' ';'
			| IDENT OP_ASSIGN Expression ';'
			| KW_BREAK ';'
			| KW_CONTINUE ';'
			| IDENT %prec "SUBSCRIPT" '['Expression']' '=' Expression ';'
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
			| '-' Expression %prec OP_UNARY {printf("Using Unary\n");}
			| OP_NOT Expression
			| Expression %prec "SUBSCRIPT" '['Expression']' {printf("Using Subscript\n");}
			| Expression '.'"length"
			| Expression '.' IDENT %prec "FUNCALL" '(' ParamList ')' 
			| INT_LITERAL
			| FLOAT_LITERAL
			| STRING_LITERAL
			| KW_NULL
			| KW_TRUE
			| KW_FALSE
			| IDENT
			| KW_THIS
			| KW_NEW Type '[' Expression ']' %prec "NEW"
			| KW_NEW IDENT '('')'	     %prec "NEW"
			| '(' Expression ')'
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