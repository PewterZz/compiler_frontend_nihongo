#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

extern FILE *yyin;

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Cannot open file %s\n", argv[1]);
        return 1;
    }
    yyin = file;

    yyparse();

    fclose(file);

    return 0;
}
