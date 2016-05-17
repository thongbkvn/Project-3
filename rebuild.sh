#!/bin/bash
bison -vd MiniJava.y;
gcc -c MiniJava.tab.c;
flex MiniJava.lex;
gcc -c lex.yy.c;
gcc -o MiniJava lex.yy.o MiniJava.tab.o;
