#!/bin/bash
cd Parser
bison -d MiniJava.y;
gcc -c MiniJava.tab.c;
flex MiniJava.lex;
gcc -c lex.yy.c;
gcc -o ../MiniJava lex.yy.o MiniJava.tab.o;
cd ..
./MiniJava test.java;
