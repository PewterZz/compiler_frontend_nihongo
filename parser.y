// parser.y

%{
#include <stdio.h>
#include <stdlib.h>

#define MAX_SYMBOLS 256 

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
int symbols[MAX_SYMBOLS];
int get_symbol(char* s);
void set_symbol(char* s, int value);

%}

%union {
    int num;
    char* str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%type <num> expression
%type <num> assignment_expression

%token SEMICOLON IF ELSE YIELD EQUAL PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN ELIF FOR WHILE DEF CLASS TRY EXCEPT FINALLY RETURN RAISE FROM IMPORT AS PASS BREAK CONTINUE GLOBAL NONLOCAL ASSERT DEL ASYNC AWAIT TRUE FALSE NONE
%token EQUALS_TO NOT_EQUALS_TO

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

assignment_expression: IDENTIFIER EQUAL expression
        {
            set_symbol($1, $3);
            $$ = $3;
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
          | assignment_expression
          | IDENTIFIER
          ;

%%

int get_symbol(char* s) {
    // For simplicity, this function just converts the first character of the string to an index
    // In a real implementation, a proper hash function or a search in a more complex structure is needed
    return symbols[s[0] % MAX_SYMBOLS];
}

void set_symbol(char* s, int value) {
    symbols[s[0] % MAX_SYMBOLS] = value;
}


void yyerror(const char* s) {
    fprintf(stderr, "Parser error: %s\n", s);
}