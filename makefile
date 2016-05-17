all: MiniJava.tab.o lex.yy.o
	gcc -o MiniJava lex.yy.o MiniJava.tab.o
lex.yy.o: lex.yy.c MiniJava.tab.h
	gcc -c lex.yy.c
lex.yy.c: MiniJava.lex
	flex MiniJava.lex
MiniJava.tab.o: MiniJava.tab.c
	gcc -c MiniJava.tab.c
MiniJava.tab.c MiniJava.tab.h: MiniJava.y 
	bison -vd MiniJava.y
