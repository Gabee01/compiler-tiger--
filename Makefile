all: tiger

tiger.tab.c tiger.tab.h:	tiger.y
	bison -d tiger.y

lex.yy.c: tiger.l tiger.tab.h
	flex tiger.l

tiger: lex.yy.c tiger.tab.c tiger.tab.h
	gcc -o tiger tiger.tab.c lex.yy.c

clean:
	rm tiger tiger.tab.c lex.yy.c tiger.tab.h
