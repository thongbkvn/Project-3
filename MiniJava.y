%start Program
%token KW_CLASS KW_EXTENDS KW_PUBLIC KW_STATIC KW_BOOLEAN KW_STRING KW_FLOAT KW_INT EOF
%token KW_IF KW_WHILE KW_BREAK KW_CONTINUE KW_SWITCH KW_CASE KW_DEFAULT KW_RETURN
%token KW_NEW KW_THIS KW_NULL KW_TRUE KW_FALSE KW_PRINTLN
%token IDENT INT_LITERAL FLOAT_LITERAL STRING_LITERAL
%right "THEN" KW_ELSE
%right "STATEMENTS"

%right OP_ASSIGN
%left OP_OR
%left OP_AND
%nonassoc CMP_EQ CMP_NEQ
%nonassoc CMP_GT CMP_LT CMP_GTE CMP_LTE
%left OP_ADD OP_MINUS
%left OP_MULT OP_DIV OP_MOD
%left OP_UNARY
%right OP_NOT
%left "GROUP" "INDEX"
%left "ACCESS"
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
Statements:		/*empty*/ %prec "STATEMENT"
			| Statements Statement	%prec "STATEMENTS"
			;
Statementp:		Statementp Statement %prec "STATEMENTS"
			| Statement %prec "STATEMENT"
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
Case:		 	KW_CASE INT_LITERAL ':' Statementp
		 	;

BoolExpr:		KW_TRUE
			| KW_FALSE
			| BoolExpr OP_OR BoolExpr
			| BoolExpr OP_AND BoolExpr
			| Expression CMP_EQ Expression
			| Expression CMP_NEQ Expression
			| Expression CMP_GT Expression
			| Expression CMP_GTE Expression
			| Expression CMP_LT Expression
			| Expression CMP_LTE Expression
			| OP_NOT BoolExpr
			| IDENT
			;

Expression:	 	Expression OP_ADD Expression
			| Expression OP_MINUS Expression
			| Expression OP_MULT Expression
			| Expression OP_DIV Expression
			| Expression OP_MOD Expression
			| '-' Expression %prec OP_UNARY
			| Expression '['Expression']' %prec "INDEX"
			| Expression '.'"length" %prec "ACCESS"
			| Expression '.' IDENT '(' ParamList ')' %prec "ACCESS"
			| INT_LITERAL
			| FLOAT_LITERAL
			| STRING_LITERAL
			| KW_NULL
			| IDENT
			| KW_THIS
			| KW_NEW Type '[' Expression ']'
			| KW_NEW IDENT '('')'
			| '(' Expression ')' %prec "GROUP"
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

/* Co 3 conflict RR can xu ly khi bien thuoc kieu bool
   giua BoolExpr va Expresstion */