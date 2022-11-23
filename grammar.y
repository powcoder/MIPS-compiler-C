%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdarg.h>
#include <string.h>
#include <assert.h>

#include "defs.h"
#include "common.h"


/* Global variables */

// à compléter


/* prototypes */
int yylex(void);
extern int yylineno;

void yyerror(char *s);
void analyse_tree(node_t root);

// à compléter

%}

%union {
    int32_t intval;
    char * strval;
    node_t ptr;
};


/* à compléter : définition des tokens et de leur associativité */
%token TOK_VOID		TOK_INT 	TOK_INTVAL 	TOK_BOOL 	TOK_TRUE 	TOK_FALSE
%token TOK_IDENT  	TOK_IF 		TOK_ELSE 	TOK_WHILE 	TOK_FOR 	TOK_PRINT
%token TOK_AFFECT 	TOK_GE 		TOK_LE 		TOK_GT 		TOK_LT 		TOK_EQ
%token TOK_NE     	TOK_PLUS 	TOK_MINUS 	TOK_MUL 	TOK_DIV 	TOK_MOD
%token TOK_UMINUS 	TOK_SEMICOL 	TOK_COMMA 	TOL_LPAR 	TOK_RPAR 	TOK_LACC
%token TOK_RACC   	TOK_STRING 	TOK_DO

%nonassoc TOK_THEN
%nonassoc TOK_ELSE

%right	TOK_AFFECT

%left	TOK_OR
%left	TOK_AND
%left	TOK_BOR
%left	TOK_BXOR
%left	TOK_BAND
%left	TOK_EQ	TOK_NE
%left	TOK_GT	TOK_LT	TOK_GE	TOK_LE
%left	TOK_SRL	TOK_SRA	TOK_SLL

%left	TOK_PLUS TOK_MINUS
%left	TOK_MUL	TOK_DIV	TOK_MOD

%left	TOK_UMINUS TOK_NOT TOK_BNOT

%type	<intval> TOK_INTVAL;
%type	<strval> TOK_IDENT TOK_STRING;

%type	<ptr> program listdecl listdeclnonnull vardecl ident type listtypedecl decl maindecl
%type	<ptr> listinst listinstnonnull inst block expr listparamprint paramprint

%%

/* à compléter : grammaire hors-contexte et construction de l'arbre */

program:
        listdeclnonnull maindecl
        {
            $$ = make_node(NODE_PROGRAM, 2, $1, $2);
            analyse_tree($$);
        }
        | maindecl
        {
            $$ = make_node(NODE_PROGRAM, 2, NULL, $1);
            analyse_tree($$);
        }
        ;

listdecl:
	listdeclnonnull
	|
	;

listdeclnonnull:
	vardecl
	|listdeclnonnull vardecl
	;
	
vardecl:
	type listtypedecl TOK_SEMICOL
	;

type:
	TOK_INT
	|TOK_BOOL
	|TOK_VOID
	;

listtypedecl:
	decl
	|ident TOK_COMMA decl
	;

decl:
	ident
	|ident TOK_AFFECT expr
	;

maindecl:
	type ident TOK_LPAR TOK_RPAR block
	;

listinst:
	listinstnonnull
	|
	;
	
listinstnonnull:
	inst
	|listinstnonnull inst
	;

isnt:
	expr TOK_SEMICOL
	|TOK_IF TOK_LPAR expr TOK_RPAR inst TOK_ELSE inst
	|TOK_IF TOK_LPAR expr TOK_RPAR inst %prec TOK_THEN
	|TOK_WHILE TOK_LPAR expr TOK_RPAR inst
	|TOK_FOR TOK_LPAR expr TOK_SEMICOL expr TOK_SEMICOL expr TOK_RPAR inst
	|TOK_DO inst TOK_WHILE TOK_LPAR expr TOK_RPAR TOK_SEMICOL
	|block
	|TOK_SEMICOL
	|TOK_PRINT TOK_LPAR listparamprint TOK_RPAR TOK_SEMICOL
	; 
		


%%

/* à compléter : fonctions de création des noeuds de l'arbre */



void analyse_tree(node_t root) {
    /* à compléter */
}



void yyerror(char * s) {
    fprintf(stderr, "Error line %d: %s\n", yylineno, s);
    exit(1);
}


