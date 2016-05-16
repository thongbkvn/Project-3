%start Program
%token KW_CLASS KW_EXTENDS KW_PUBLIC KW_STATIC KW_BOOL KW_STRING KW_FLOAT KW_INT
%token KW_IF KW_ELSE KW_WHILE KW_BREAK KW_CONTINUE KW_SWITCH KW_CASE KW_DEFAULT KW_RETURN
%token KW_NEW KW_THIS KW_NULL KW_TRUE KW_FALSE KW_PRINTLN
%token IDENT INT_LIT FLOAT_LIT STRING_LIT
%left OP_ADD OP_MINUS OP_MULT OP_DIV OP_MOD OP_GT OP_LT OP_GTE OP_LTE OP_LAND OP_LOR
%left CMP_EQ CMP_NEQ
%left UMINUS
%right OP_ASSIGN OP_UNARY
%%
Program :	ClassDecls
		;

ClassDecls :	ClassDecls ClassDecls
		| KW_CLASS IDENT ExtendsFrom
	  	  '{' VarDecls MethodDecls '}'
		;
	  
ExtendsFrom:	/*empty*/
	     	| KW_EXTENDS IDENT
		;
		
VarDecls:    	/*empty*/
		| VarDecl
		| VarDecls VarDecl
		;
VarDecl:	Type IDENT ';'
	  	| KW_STATIC Type IDENT ';'
		;

MethodDecls:	/*empty*/
		| MethodDecls MethodDecl
		;
MethodDecl:	KW_PUBLIC Type IDENT
		'('MethodParams')'
		'{'VarDecls Statements KW_RETURN Expression ';' '}'
		;
MethodParams:	/*empty*/
		| Type IDENT
		| MethodParams ',' Type IDENT
		;

Type :		Type '['']'
     		| KW_BOOL
		| KW_STRING
		| KW_FLOAT
		| KW_INT
		| IDENT
		;

Statements:	/*empty*/
		| Statements Statement
		;
Statement:	'{' Statements '}'
		| KW_IF '(' Expression ')' Statement KW_ELSE Statement
		| KW_IF '(' Expression ')' Statement
		| KW_WHILE '(' Expression ')' Statement
		| KW_PRINTLN '(' Expression ')' ';'
		| IDENT '=' Expression ';'
		| KW_BREAK ';'
		| KW_CONTINUE ';'
		| IDENT '['Expression']' '=' Expression ';'
		| KW_SWITCH '('Expression ')' '{'
		  Cases
		  KW_DEFAULT ':' Statements Statement '}'
		 ;

Cases:		 /*empty*/
		 | KW_CASE INT_LIT ':' Statement Statements
		 ;

Expression:	Expression Opgroup1 Expression
		| Expression Opgroup2 Expression
		| Expression CmpOp Expression
		| Expression Opgroup3 Expression
		| Expression Opgroup4 Expression
		| '-' Expression %prec UMINUS
		| Expression '[' Expression ']'
		| Expression '.' "length"
		| Expression '.' IDENT '(' ParamList ')'
		| INT_LIT
		| FLOAT_LIT
		| STRING_LIT
		| KW_NULL
		| KW_TRUE
		| KW_FALSE
		| IDENT
		| KW_THIS
		| KW_NEW Type '[' Expression']'
		| KW_NEW IDENT '('')'
		| '(' Expression ')'
		;
Opgroup1:	OP_LOR | OP_LAND;
Opgroup2:	OP_GT | OP_GTE | OP_LT | OP_LTE;
Opgroup3:	OP_ADD | OP_MINUS;
Opgroup4:	OP_MULT | OP_DIV | OP_MOD;
CmpOp:		CMP_EQ | CMP_NEQ;

ParamList:	/*empty*/
		| Expression
		| ParamList ',' Expression
		;
%%
main(int argc, char** argv[])
{
	extern FILE *yyin;
	++argv; --argc;
	yyin = fopen(argv[0], "r");
	yydebug = 1;
	errors = 0;
	yyparse();
}

yyerror(char *s)
{
	printf("%s\n", s);
}