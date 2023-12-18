// parser.y

%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

%}

%union {
    int num;
    char* str;
}

%token <num> NUMBER
%token <str> IDENTIFIER

%token IF ELSE YIELD EQUAL PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN ELIF FOR WHILE DEF CLASS TRY EXCEPT FINALLY RETURN RAISE FROM IMPORT AS PASS BREAK CONTINUE GLOBAL NONLOCAL ASSERT DEL ASYNC AWAIT TRUE FALSE NONE

%left PLUS MINUS
%left MULTIPLY DIVIDE

%start program

%%

program:
       | program statement
       ;

statement: IF LPAREN expression RPAREN statement ELSE statement
         | YIELD expression ';'
         | IDENTIFIER EQUAL expression ';'
         | expression ';'
         | IDENTIFIER EQUAL NUMBER ';'   /* Variable assignment with a number */
         ;

expression: expression PLUS expression
          | expression MINUS expression
          | expression MULTIPLY expression
          | expression DIVIDE expression
          | LPAREN expression RPAREN
          | NUMBER
          | IDENTIFIER
          | IDENTIFIER PLUS NUMBER       /* Variable usage in an expression */
          ;

%%
