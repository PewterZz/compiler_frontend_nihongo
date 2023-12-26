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

%token SEMICOLON EQUALITY IF ELSE YIELD PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN ELIF FOR WHILE DEF CLASS TRY EXCEPT FINALLY RETURN RAISE FROM IMPORT AS PASS BREAK CONTINUE GLOBAL NONLOCAL ASSERT DEL ASYNC AWAIT TRUE FALSE NONE

%left EQUALITY
%left PLUS MINUS
%left MULTIPLY DIVIDE

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start program

%%

program:
       | program statement
       ;

statement: IF LPAREN expression RPAREN statement ELSE statement
            {
                if ($3) {
                    // Execute the 'if' statement block
                    printf("If block executed.\n");
                } else {
                    // Execute the 'else' statement block
                    printf("Else block executed.\n");
                }
            }
         | YIELD expression SEMICOLON
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
          | expression EQUALITY expression
             {
                 $$ = ($1 == $3); 
             }
          | LPAREN expression RPAREN
            {
                 $$ = $2;     
             }
          | NUMBER
             {
                 $$ = $1;      
             }
          ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Parser error: %s\n", s);
}