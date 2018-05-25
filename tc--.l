%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "tc--.tab.h"

%}

%%

var						{ return T_VAR; }
let						{ return T_LET; }
in 						{ return T_IN; }
while					{ return T_WHILE; }
[a-zA-Z][a-zA-Z0-9_]* 	{ return T_ID; }
[0-9]+                  { return T_INT; }
end						{ return T_END; }
do						{ return T_DO; }
\"[^\"]*\"				{ return T_STRING; }
[ \t]+                  /* ignore whitespace */;
\/\*.*\*\/				/* ingore comments*/;
":="					{ return T_ATTRIBUTION; }
\(						{ return T_BRACEO; }
\)						{ return T_BRACEC; }
getint\(\)				|
printf\(\"[^\"]*\"\)	{ return T_FUNCTION; }
\*						|
\/						|
\+						|
-						|
=						|
\<\>					|
\>						|
\<						|
\>=						|
\<=						|
&						|
\|						{ return T_OP; }
\n 						/**/
\;						{ return T_DOTCOM; }

%%
