%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	char* sval;
}
%token<ival> T_INT
%token<sval> T_STRING

%token T_NEWLINE T_QUIT T_ID T_ATTRIBUTION

%start start

%%

start: 
	|start line
;

line: T_NEWLINE
/*    | expression T_NEWLINE { printf("\tResult: %i\n", $1); } */
    | statement T_NEWLINE
    | T_QUIT T_NEWLINE { printf("bye!\n"); exit(0); }
;

statement: value
	|T_ID T_ATTRIBUTION statement {printf("statement");}
;

value:
	T_INT
	|T_STRING
;

/*expression: T_INT				{ $$ = $1; }
	  | expression T_PLUS expression	{ $$ = $1 + $3; }
	  | expression T_MINUS expression	{ $$ = $1 - $3; }
	  | expression T_MULTIPLY expression	{ $$ = $1 * $3; }
	  | T_LEFTB expression T_RIGHTB		{ $$ = $2; }
;
*/
%%

int main() {
	yyin = stdin;

	do { 
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
