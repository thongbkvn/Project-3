/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_MINIJAVA_TAB_H_INCLUDED
# define YY_YY_MINIJAVA_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    KW_CLASS = 258,
    KW_EXTENDS = 259,
    KW_PUBLIC = 260,
    KW_STATIC = 261,
    KW_BOOLEAN = 262,
    KW_STRING = 263,
    KW_FLOAT = 264,
    KW_INT = 265,
    KW_IF = 266,
    KW_WHILE = 267,
    KW_BREAK = 268,
    KW_CONTINUE = 269,
    KW_SWITCH = 270,
    KW_CASE = 271,
    KW_DEFAULT = 272,
    KW_RETURN = 273,
    KW_NEW = 274,
    KW_THIS = 275,
    KW_NULL = 276,
    KW_TRUE = 277,
    KW_FALSE = 278,
    KW_PRINTLN = 279,
    IDENT = 280,
    INT_LITERAL = 281,
    FLOAT_LITERAL = 282,
    STRING_LITERAL = 283,
    KW_ELSE = 285,
    OP_ASSIGN = 286,
    OP_OR = 287,
    OP_AND = 288,
    CMP_EQ = 289,
    CMP_NEQ = 290,
    CMP_GT = 291,
    CMP_LT = 292,
    CMP_GTE = 293,
    CMP_LTE = 294,
    OP_ADD = 295,
    OP_MINUS = 296,
    OP_MULT = 297,
    OP_DIV = 298,
    OP_MOD = 299,
    OP_NOT = 300,
    OP_UNARY = 301
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 9 "MiniJava.y" /* yacc.c:1909  */

       int num;
       float real;
       char* str;

#line 106 "MiniJava.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_MINIJAVA_TAB_H_INCLUDED  */
