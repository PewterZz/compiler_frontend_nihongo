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
%type <num> statement
%type <num> if_statement

%token SEMICOLON EQUALITY IF ELSE YIELD PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN ELIF FOR WHILE DEF CLASS TRY EXCEPT FINALLY RETURN RAISE FROM IMPORT AS PASS BREAK CONTINUE GLOBAL NONLOCAL ASSERT DEL ASYNC AWAIT TRUE FALSE NONE PRINT

%left EQUALITY
%left PLUS MINUS
%left MULTIPLY DIVIDE

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

program:
       | program statement
       ;

statement: if_statement
         | PRINT LPAREN expression RPAREN SEMICOLON 
         {
             printf("%d\n", $3);
         }
         ;

if_statement: IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE
             {
                 if ($3) {
                     // Execute the 'if' statement block
                     $$ = $5;
                 } else {
                     // Execute the 'else' statement block
                     $$ = 0; // Change this line to $$ = $6;
                 }
             }
           | IF LPAREN expression RPAREN statement ELSE statement
             {
                 if ($3) {
                     // Execute the 'if' statement block
                     $$ = $5;
                 } else {
                     // Execute the 'else' statement block
                     $$ = $7;
                 }
             }


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