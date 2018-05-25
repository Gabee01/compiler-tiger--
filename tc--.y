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

%token T_NEWLINE T_QUIT T_WHILE T_DO T_FUNCTION
%token T_LET T_VAR T_ID T_ATTRIBUTION T_OP T_IN T_END
%token T_DOTCOM T_BRACEO T_BRACEC

%start start

%%

start: 
	| start program 
;

program: T_LET let
;

declaration:T_ID T_ATTRIBUTION expression T_DOTCOM
;

expression: value
	|null
	|sequence
	|function
	|arithmetic
	|comparation
	|logic
	|attribution
	|ite
	|it
	|while
	|let
;

number: T_INT
	|'-' T_INT
;

value: number
	|T_STRING
;

null:
;

sequence: T_BRACEO expressionColection T_BRACEC
;

expressionColection: expression 
	| expression T_DOTCOM expressionColection
	| expression T_END
;

function: T_ID T_ATTRIBUTION program
	| T_FUNCTION

arithmetic: T_ID T_OP T_ID
	| number T_OP number
	| number T_OP T_ID
	| T_ID T_OP number
	| T_ID T_OP arithmetic
	| number T_OP arithmetic
;

comparation: value T_OP value
;

logic: T_ID T_OP T_ID
;

attribution: T_VAR T_ID T_ATTRIBUTION value
;

ite:
;

it:
;

while: T_WHILE T_ID T_OP T_ID do
	| T_WHILE T_ID T_OP number do
	| T_WHILE number T_OP T_ID do
	| T_WHILE number T_OP number do
;

do: T_DO T_BRACEO expressionColection T_BRACEC

let: attribution
	|attribution T_DOTCOM let
	|T_IN expressionColection
;
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
