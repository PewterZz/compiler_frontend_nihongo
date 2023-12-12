%{
#include "parser.tab.h"
%}

%option noyywrap

DIGIT [0-9]
ID [a-zA-Z][a-zA-Z0-9_]*

%%
"イフ"      { return IF; }
"else"     { return ELSE; }
"ヤールド"   { return YIELD; }
"="        { return EQUAL; }
"+"        { return PLUS; }
"-"        { return MINUS; }
"*"        { return MULTIPLY; }
"/"        { return DIVIDE; }
"("        { return LPAREN; }
")"        { return RPAREN; }
{DIGIT}+   { yylval.num = atoi(yytext); return NUMBER; }
{ID}       { yylval.str = strdup(yytext); return IDENTIFIER; }
[ \t\n]    ; // Ignore whitespace
.         { fprintf(stderr, "Unexpected character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
