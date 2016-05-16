%{
  #include "MiniJava.tab.h"
  #include <string.h>
  #include <stdlib.h>
  #include <stdio.h>
%}
DIGIT [0-9]
ID [A-Za-z][A-Za-z0-9]*
%%
class 			 {return KW_CLASS;}
extends			 {return KW_EXTENDS;}
public			 {return KW_PUBLIC;}
static			 {return KW_STATIC;}
boolean			 {return KW_BOOL;}
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
">="	 		 {return OP_GTE;}
">"	 		 {return OP_GT;}
"<="	 		 {return OP_LTE;}
"<"	 		 {return OP_LT;}
"&&"	 		 {return OP_LAND;}
"||"	 		 {return OP_LOR;}
"=="	 		 {return CMP_EQ;}
"!="	 		 {return CMP_NEQ;}
"="		 	 {return OP_ASSIGN;}
[ \t\n]+
.			 {return yytext[0];}
{DIGIT}+		 {return INT_LIT;}
"-"{DIGIT}+		 {return INT_LIT;}
{DIGIT}+"."{DIGIT}*	 {return FLOAT_LIT;}
"-"{DIGIT}+"."{DIGIT}*	 {return FLOAT_LIT;}
\".*\"			 {return STRING_LIT;}
{ID}			 {return IDENT;}
%%
int main(int argc, char** argv)
{
	++argv; --argc;
	if (arg)
	   yyin = argv[0];
	yylex();
	return 0;
}