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

%token IF ELSE YIELD EQUAL PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN

%left PLUS MINUS
%left MULTIPLY DIVIDE

%start program

%%

program: statement
       | program statement
       ;

statement: IF LPAREN expression RPAREN statement ELSE statement
         | YIELD expression
         | IDENTIFIER EQUAL expression
         ;

expression: expression PLUS expression
          | expression MINUS expression
          | expression MULTIPLY expression
          | expression DIVIDE expression
          | LPAREN expression RPAREN
          | NUMBER
          | IDENTIFIER
          ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Parser error: %s\n", s);
}

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    yyin = input_file;
    yyparse();

    fclose(input_file);
    return 0;
}
