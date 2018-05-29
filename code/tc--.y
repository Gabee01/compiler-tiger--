%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern void printReduce(const char*);
extern void printError(const char*);
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

start: { printReduce("reduced by start0"); }
	| T_LET declarations T_IN expressionColection T_END { printReduce("reduced by start1"); }
;

declarations: { printReduce("reduced by letAttrs0"); }
	| declaration declarations { printReduce("reduced by letAttrs1"); }
;

declaration: T_VAR T_ID T_ATTRIBUTION expression { printReduce("reduced by attribution0"); }

attribution: T_ID T_ATTRIBUTION expression { printReduce("reduced by attribution0"); }
;

value: number { printReduce("reduced by value0"); }
	| T_STRING { printReduce("reduced by value1"); }
	| T_ID { printReduce("reduced by value2"); }
	| T_NULL { printReduce("reduced by value3"); }
;

number: T_INT { printReduce("reduced by number0"); }
	|T_NINT { printReduce("reduced by number1"); }
;

expressionColection: { printReduce("reduced by expressionColection0"); }
	| expression expressionColection { printReduce("reduced by expressionColection1"); }
;

while: T_WHILE compareCollection T_DO sequence { printReduce("reduced by while"); }
	| T_WHILE compareCollection sequence { printError("esperado `do` após while"); return yyerrok; }
	| T_WHILE T_DO sequence { printError("while sem comparações"); }
;

expression: expression T_DOTCOM { printReduce("reduced by expression3"); }
	|attribution { printReduce("reduced by expression2"); }
	|value { printReduce("reduced by expression0"); }
	|arithmetic { printReduce("reduced by expression1"); }
	|function { printReduce("reduced by expression4"); }
	|compareCollection { printReduce("reduced by expression5"); }
	|T_IF ite { printReduce("reduced by expression6"); }
	|while { printReduce("reduced by expression8"); }
;

arithmetic: T_ID T_ARITH T_ID { printReduce("reduced by arith0"); }
	| number T_ARITH number { printReduce("reduced by arith1"); }
	| number T_ARITH T_ID { printReduce("reduced by arith2"); }
	| T_ID T_ARITH number { printReduce("reduced by arith3"); }
	| T_ID T_ARITH arithmetic { printReduce("reduced by arith4"); }
	| number T_ARITH arithmetic { printReduce("reduced by arith5"); }
;

function: T_FUNCTION params { printReduce("reduced by function0"); }
;

sequence: | T_BRACEO T_BRACEC { printError("sequencia vazia"); return yyerrok; }
	| T_BRACEO sequence T_BRACEC { printReduce("reduced by sequence0"); }
	| expression { printReduce("reduced by sequence2"); }
	| expression sequence { printReduce("reduced by sequence1"); }
;

params: | T_BRACEO T_BRACEC
	| T_BRACEO params { printReduce("reduced by sequence0"); }
	| value T_BRACEC { printReduce("reduced by sequence2"); }
	| value T_COM params { printReduce("reduced by sequence1"); }
;

ite: compareCollection T_THEN sequence ite { printReduce("reduced by it"); }
	| T_ELSE sequence { printReduce("reduced by ite"); }
	| compareCollection sequence { printError("esparado then"); return yyerrok; }
	| 
;

compareCollection: compare { printReduce("reduced by compareCollection1"); }
	| compare T_LOGIC compareCollection { printReduce("reduced by compareCollection2"); }
;

compare: T_ID T_COMP T_ID { printReduce("reduced by compare0"); }
	| T_ID T_COMP value { printReduce("reduced by compare2"); }
	| value T_COMP T_ID { printReduce("reduced by compare3"); }
	| value T_COMP value { printReduce("reduced by compare4"); }
;
%%

void printReduce(const char *reduced) {
    //printf("%s\n", reduced);
    return;
}

void printError(const char *reduced) {
    printf("!!!erro: %s\n", reduced);
    return;
}

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
