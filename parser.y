%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

typedef struct Node {
    int type;
    int value;
    struct Node* left;
    struct Node* right;
} Node;

Node* createNode(int type, int value, Node* left, Node* right) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->type = type;
    node->value = value;
    node->left = left;
    node->right = right;
    return node;
}

%}

%union {
    int num;
    char* str;
    Node* node;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%type <node> expression
%type <node> statement
%type <node> if_statement

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
             printf("%d\n", ($3)->value);
         }
         ;

if_statement: IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE
             {
                 if (($3)->value) {
                     // Execute the 'if' statement block
                     $$ = createNode(IF, 0, $3, $5);
                 } else {
                     // Skip the 'else' statement block
                     $$ = NULL;
                 }
             }
           | IF LPAREN expression RPAREN statement ELSE statement
             {
                 // Create an if-else node
                 $$ = createNode(IF, 0, $3, createNode(ELSE, 0, $5, $7));
             }
           | IF LPAREN expression RPAREN statement ELIF LPAREN expression RPAREN statement
             {
                 // Create an if-elif node
                 $$ = createNode(IF, 0, $3, createNode(ELIF, 0, $8, $10));
             }

expression: expression PLUS expression
           {
                $$ = createNode(PLUS, 0, $1, $3);
           }
          | expression MINUS expression
           {
                $$ = createNode(MINUS, 0, $1, $3);
           }
          | expression MULTIPLY expression
           {
                $$ = createNode(MULTIPLY, 0, $1, $3);
           }
          | expression DIVIDE expression
           {
                $$ = createNode(DIVIDE, 0, $1, $3);
           }
          | LPAREN expression RPAREN
           {
                $$ = $2;
           }
          | NUMBER
           {
                $$ = createNode(NUMBER, $1, NULL, NULL);
           }
          ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Parser error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
