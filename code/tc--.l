%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "tc--.tab.h"

%}

%%
\/\*.*\*\/				/* ingore comments*/;
null					{ return T_NULL; }
let						{ return T_LET; }
end						{ return T_END; }
in 						{ return T_IN; }
var						{ return T_VAR; }
while					{ return T_WHILE; }
do						{ return T_DO; }
if						{ return T_IF; }
then					{ return T_THEN; }
else					{ return T_ELSE; }
;						{ return T_DOTCOM; }
,						{ return T_COM;}
:=						{ return T_ATTRIBUTION; }
[ \t]+                  /* ignore whitespace */;
\(						{ return T_BRACEO; }
\)						{ return T_BRACEC; }
\*						|
\/						|
\+						|
-						{ return T_ARITH; }
=						|
\<\>					|
\>						|
\<						|
\>=						|
\<=						{ return T_COMP; }
&						|
\|						{ return T_LOGIC; }
\n 						/**/
getint					|
printf					{ return T_FUNCTION; }
[a-zA-Z][a-zA-Z0-9_]* 	{ return T_ID; }
\"[^\"]*\"				{ return T_STRING; }
-[0-9]+                 { return T_NINT; }
[0-9]+                  { return T_INT; }

%%