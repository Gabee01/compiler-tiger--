all: tc--

tc--.tab.c tc--.tab.h:	tc--.y
	bison -d tc--.y # -d usado para criar tc--.tab.h com as defs dos tokens

lex.yy.c: tc--.l tc--.tab.h
	flex tc--.l

tc--: lex.yy.c tc--.tab.c tc--.tab.h
	gcc -o tc-- tc--.tab.c lex.yy.c

clean:
	rm tc-- tc--.tab.c lex.yy.c tc--.tab.h
