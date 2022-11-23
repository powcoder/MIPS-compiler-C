%{
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include "defs.h"
#include "common.h"

#include "y.tab.h"

void yyerror(char *);
int yyparse(void);
int fileno(FILE * stream);

/* à compléter : variables globales éventuelles */
char * infile = NULL;
%}

%option yylineno

/* à compléter : définitions */
LETTRE 		[a-zA-Z]
CHIFFRE		[0-9]
IDF		{lettre}({lettre}|{chiffre}|{'_'})*
CHIFFRE_NON_NUL	[1-9]
%%

/* à compléter : règles */
"void"          return TOK_VOID;
"int"		return TOK_INT;
""     		return TOK_INTVAL;/*0*/
"bool"		return TOK_BOOL;
"true"		return TOK_TRUE;
"false"		return TOK_FALSE;
"idf"		return TOK_IDENT;/*0*/
"if"		return TOK_IF;
"else"		return TOK_ELSE;
"while"		return TOK_WHILE;
"for"		return TOK_FOR;
"print"		return TOK_PRINT;
"="		return TOK_AFFECT;
">="		return TOK_GE;
"<="		return TOK_LE;
">"		return TOK_GT;
"<"		return TOK_LT;
"=="		return TOK_EQ;
"!="		return TOK_NE;
"+"		return TOK_PLUS;
"-"		return TOK_MINUS;
"*"		return TOK_MUL;
"/"		return TOK_DIV;
"%"		return TOK_MOD;
""		return TOK_UMINUS;/* 0*/	
";"		return TOK_SEMICOL;
","		return TOK_COMMA;
"("		return TOL_LPAR;
")"		return TOK_RPAR;
"{"		return TOK_LACC;
"}"		return TOK_RACC;
"string"	return TOK_STRING;
"do"		return TOK_DO;

{IDF} {
                yylval.strval = strdup(yytext);
                return TOK_IDENT;
}


[ \t\n]+

. {
                fprintf(stderr, "Error line %d: Lexical error\n", yylineno);
                exit(1);
}


%%

int yywrap(void) {
    return 1;
}



int main(int argc, char ** argv) {
    /* à compléter */
    // ...

    yyin = fopen(infile, "r");
    yyparse();
    fclose(yyin);
    yylex_destroy();
    return 0;
}




