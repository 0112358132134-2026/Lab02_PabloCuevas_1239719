%{
	#include <ctype.h>
	#include <stdio.h>
	#define YYSTYPE double /* double type for Yacc stack */
	
	extern int yylex();
	void yyerror(char *msg);
%}

%token or
%token and
%token not
%token true
%token false

%%
lines	: lines bexpr '\n' { if($2 == 1){printf("TRUE(1)\n");}else{printf("FALSE (0)\n");} }
		| lines '\n'
		| /* empty */
		;

bexpr	: bexpr or bterm { if(($1 == 0) && ($3 == 0)){$$ = 0;}else{$$ = 1;} }
		| bterm { $$ = $1}
		;

bterm	: bterm and bfactor { if(($1 == 1) && ($3 == 1)){$$ = 1;}else{$$ = 0;} }
		| bfactor { $$ = $1}
		;
		
bfactor	: not bfactor { if($2 == 1){$$ = 0;}else{$$ = 1;} }
		| '(' bexpr ')' { $$ = $2}
		| true { $$ = $1}
		| false { $$ = $1}
		;
%%

#include "lex.yy.c"

void yyerror(char *msg){
	printf("Error de sintaxis");
	exit(0);
}

int main(){
	yyparse();
	return 0;
}