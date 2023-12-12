# Nihongo Compiler

## Program manual
In order to generate the lexer and parser, use the following commands
```
flex lexer.l
bison -d parser.y
gcc lex.yy.c parser.tab.c -o my_parser -lfl
```