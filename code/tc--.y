%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern void printRule(const char*, const char*);
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	char* sval;
}

%token<ival> T_INT T_NINT
%token<sval> T_STRING

%token T_NEWLINE T_QUIT T_FUNCTION
%token T_LET T_VAR T_ID T_ATTRIBUTION T_IN T_END T_NULL
%token T_WHILE T_DO
%token T_IF T_THEN T_ELSE
%token T_ARITH T_COMP T_LOGIC
%token T_COM T_DOTCOM T_BRACEO T_BRACEC

%start start

%%

start: { puts("reduced by start0"); }
	| T_LET letAttrs T_IN expressionColection T_END { puts("reduced by start1"); }
;

letAttrs: { puts("reduced by letAttrs0"); }
	| letAttribution letAttrs { puts("reduced by letAttrs1"); }
;

letAttribution: T_VAR T_ID T_ATTRIBUTION expression { puts("reduced by attribution0"); }

attribution: T_ID T_ATTRIBUTION expression { puts("reduced by attribution0"); }
;

value: number { puts("reduced by value0"); }
	| T_STRING { puts("reduced by value1"); }
	| T_ID { puts("reduced by value2"); }
	| T_NULL { puts("reduced by value3"); }
;

number: T_INT { puts("reduced by number0"); }
	|T_NINT { puts("reduced by number1"); }
;

expressionColection: { puts("reduced by expressionColection0"); }
	| expression expressionColection { puts("reduced by expressionColection1"); }
;

while: T_WHILE compareCollection T_DO sequence { puts("reduced by while"); }
;

expression: expression T_DOTCOM { puts("reduced by expression3"); }
	|attribution { puts("reduced by expression2"); }
	|value { puts("reduced by expression0"); }
	|arithmetic { puts("reduced by expression1"); }
	|function { puts("reduced by expression4"); }
	|compareCollection { puts("reduced by expression5"); }
	|T_IF ite { puts("reduced by expression6"); }
	|while { puts("reduced by expression8"); }
;

arithmetic: T_ID T_ARITH T_ID { puts("reduced by arith0"); }
	| number T_ARITH number { puts("reduced by arith1"); }
	| number T_ARITH T_ID { puts("reduced by arith2"); }
	| T_ID T_ARITH number { puts("reduced by arith3"); }
	| T_ID T_ARITH arithmetic { puts("reduced by arith4"); }
	| number T_ARITH arithmetic { puts("reduced by arith5"); }
;

function: T_FUNCTION params { puts("reduced by function0"); }
;

sequence: | T_BRACEO T_BRACEC
	| T_BRACEO sequence { puts("reduced by sequence0"); }
	| expression T_BRACEC { puts("reduced by sequence2"); }
	| expression sequence { puts("reduced by sequence1"); }
;

params: | T_BRACEO T_BRACEC
	| T_BRACEO params { puts("reduced by sequence0"); }
	| value T_BRACEC { puts("reduced by sequence2"); }
	| value T_COM params { puts("reduced by sequence1"); }
;

ite: compareCollection T_THEN sequence ite { puts("reduced by it"); }
	| T_ELSE sequence { puts("reduced by ite"); }
	|
;

compareCollection: compare { puts("reduced by compareCollection1"); }
	| compare T_LOGIC compareCollection { puts("reduced by compareCollection2"); }
;

compare: T_ID T_COMP T_ID { puts("reduced by compare0"); }
	| T_ID T_COMP value { puts("reduced by compare2"); }
	| value T_COMP T_ID { puts("reduced by compare3"); }
	| value T_COMP value { puts("reduced by compare4"); }
;
%%

void printRule(const char *lhs, const char *rhs) {
    printf("%s -> %s\n", lhs, rhs);
    return;
}

int main() {

	yyin = stdin;

	do { 
		printf("pey in: %s\n", yyin);
		printf("pey val: %s\n", yylval);
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
