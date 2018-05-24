%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "tiger.tab.h"

%}

%%

[a-zA-Z][a-zA-Z0-9_]* 	{ return T_ID; }
[0-9]+                  { return T_INT; }
\"[^\"]*\"				{ return T_STRING; }
":="					{ return T_ATTRIBUTION; }
\n                      { return T_NEWLINE; }
[ \t]+                  /* ignore whitespace */;
\/\*.*\*\/				/* ingore comments*/;
[exit quit]				{ return T_QUIT; }

%%
