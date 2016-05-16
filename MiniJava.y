%start Program
%token KW_CLASS KW_EXTENDS KW_PUBLIC KW_STATIC KW_BOOLEAN KW_STRING KW_FLOAT KW_INT EOF
%token KW_IF KW_WHILE KW_BREAK KW_CONTINUE KW_SWITCH KW_CASE KW_DEFAULT KW_RETURN
%token KW_NEW KW_THIS KW_NULL KW_TRUE KW_FALSE KW_PRINTLN
%token IDENT INT_LIT FLOAT_LIT STRING_LIT
%right "THEN" KW_ELSE


%right OP_ASSIGN
%left OP_OR
%left OP_AND
%nonassoc CMP_EQ CMP_NEQ
%nonassoc CMP_GT CMP_LT CMP_GTE CMP_LTE
%left OP_ADD OP_MINUS
%left OP_MULT OP_DIV OP_MOD
%right OP_NEG OP_UNARY
%%
Program:		ClassDeclp EOF
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
	  		| KW_STATIC Type IDENT ';'
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
Statements:		/*empty*/
			| Statements Statement	%prec "Statements"
			;
Statementp:		Statement
			| Statementp Statement
			;
Statement:		'{'Statements'}'
			| KW_IF '(' BoolExpr ')' Statement %prec "THEN"
			| KW_IF '(' BoolExpr ')' Statement KW_ELSE Statement
			| KW_WHILE '(' BoolExpr ')'Statement
			| KW_PRINTLN '(' Expression ')' ';'
			| IDENT OP_ASSIGN Expression ';'
			| IDENT OP_ASSIGN BoolExpr ';'
			| KW_BREAK ';'
			| KW_CONTINUE ';'
			| IDENT '['Expression']' '=' Expression ';'
			| KW_SWITCH '(' BoolExpr ')' '{'
			  Cases
			  KW_DEFAULT ':' Statementp '}'
			;

Cases:		 	/*empty*/
		 	| Cases Case
		 	;
Case:		 	KW_CASE INT_LIT ':' Statementp
		 	;

BoolExpr:		KW_TRUE
			| KW_FALSE
			| BoolExpr OP_OR BoolExpr
			| BoolExpr OP_AND BoolExpr
			| Expression CMP_EQ Expression
			| Expression CMP_GT Expression
			| Expression CMP_GTE Expression
			| Expression CMP_LT Expression
			| Expression CMP_LTE Expression
			| OP_NEG BoolExpr
			| IDENT
			;

Expression:	 	Expression OP_ADD Expression
			| Expression OP_MINUS Expression
			| Expression OP_MULT Expression
			| Expression OP_DIV Expression
			| Expression OP_MOD Expression
			| Expression '['Expression']'
			| Expression '.'"length"
			| Expression '.' IDENT '(' ParamList ')'
			| INT_LIT
			| FLOAT_LIT
			| STRING_LIT
			| KW_NULL
			| IDENT
			| KW_THIS
			| KW_NEW Type '[' Expression ']'
			| KW_NEW IDENT '('')'
			| '(' Expression ')'
			;


ParamList:		/*empty*/
			| ParamList ',' Param
			;
Param:			Expression
			| BoolExpr
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