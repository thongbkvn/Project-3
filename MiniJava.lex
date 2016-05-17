%{
  #include "MiniJava.tab.h"
  #include <string.h>
  #include <stdlib.h>
  #include <stdio.h>
  #define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;

%}
%option noyywrap
%option yylineno
DIGIT [0-9]
ID [A-Za-z][A-Za-z0-9]*
%%
class 			 {return KW_CLASS;}
extends			 {return KW_EXTENDS;}
public			 {return KW_PUBLIC;}
static			 {return KW_STATIC;}
boolean			 {return KW_BOOLEAN;}
string			 {return KW_STRING;}
float			 {return KW_FLOAT;}
int			 {return KW_INT;}
if			 {return KW_IF;}
else			 {return KW_ELSE;}
while			 {return KW_WHILE;}
break			 {return KW_BREAK;}
continue		 {return KW_CONTINUE;}
switch		 	 {return KW_SWITCH;}
case		 	 {return KW_CASE;}
default		 	 {return KW_DEFAULT;}
return	 		 {return KW_RETURN;}
new	 		 {return KW_NEW;}
this	 		 {return KW_THIS;}
null	 		 {return KW_NULL;}
true	 		 {return KW_TRUE;}
false	 		 {return KW_FALSE;}
"System.out.println"	 {return KW_PRINTLN;}
"+"	 		 {return OP_ADD;}
"-"	 		 {return OP_MINUS;}
"*"	 		 {return OP_MULT;}
"/"	 		 {return OP_DIV;}
"%"	 		 {return OP_MOD;}
">="	 		 {return CMP_GTE;}
">"	 		 {return CMP_GT;}
"<="	 		 {return CMP_LTE;}
"<"	 		 {return CMP_LT;}
"&&"	 		 {return OP_AND;}
"||"	 		 {return OP_OR;}
"=="	 		 {return CMP_EQ;}
"!="	 		 {return CMP_NEQ;}
"="		 	 {return OP_ASSIGN;}
{DIGIT}+		 {return INT_LITERAL;}
"-"{DIGIT}+		 {return INT_LITERAL;}
{DIGIT}+"."{DIGIT}*	 {return FLOAT_LITERAL;}
"-"{DIGIT}+"."{DIGIT}*	 {return FLOAT_LITERAL;}
\".*\"			 {return STRING_LITERAL;}
{ID}			 {return IDENT;}
[ \t\n]+
.			 {return yytext[0];}
%%
/*int main(int argc, char** argv)
{
	extern FILE *yyin;
	++argv; --argc;
	if (argc)
	   yyin = fopen(argv[0], "r");
	else
	   return 0;
	int a;
	while (a=yylex())
	{
		printf("%d\n", a);
	}
	return 0;
}*/