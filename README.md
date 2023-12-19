# Nihongo Compiler

## Program manual
In order to generate the lexer and parser, use the following commands

Compile the the generated parser and lexer
```
gcc -c parser.tab.c
gcc -c lex.yy.c
```
Compile main
```
gcc -c main.c
```
Create the compiler
```
gcc -o nihongo main.o parser.tab.o lex.yy.o -lfl
```
After this run the compiler with input
```
./nihongo input.txt
```