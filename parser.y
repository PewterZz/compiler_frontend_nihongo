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
%type <num> expression

%token SEMICOLON IF ELSE YIELD EQUAL PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN ELIF FOR WHILE DEF CLASS TRY EXCEPT FINALLY RETURN RAISE FROM IMPORT AS PASS BREAK CONTINUE GLOBAL NONLOCAL ASSERT DEL ASYNC AWAIT TRUE FALSE NONE


%left PLUS MINUS
%left MULTIPLY DIVIDE

%start program

%%

program:
       | program statement
       ;

statement: IF LPAREN expression RPAREN statement ELSE statement
         | YIELD expression SEMICOLON
         | IDENTIFIER EQUAL expression SEMICOLON
         | expression SEMICOLON 
          {
                 printf("%d\n", $1);
             }
         ;

expression: expression PLUS expression
            {
                 $$ = $1 + $3;
             }
          | expression MINUS expression
             {
                 $$ = $1 - $3; 
             }
          | expression MULTIPLY expression
             {
                 $$ = $1 * $3; 
             }
          | expression DIVIDE expression
            {
                 $$ = $1 / $3; 
             }
          | LPAREN expression RPAREN
            {
                 $$ = $2;     
             }
          | NUMBER
             {
                 $$ = $1;      
             }
          | IDENTIFIER
          ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Parser error: %s\n", s);
}