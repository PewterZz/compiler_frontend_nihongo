#include <bits/stdc++.h>
#include "parser.tab.h" 

using namespace std;

int main(int argc, char *argv[]){
    if(argc < 2) {
        cerr << "Usage: " << argv[0] << " <filename>\n";
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if(!file) {
        cerr << "Cannot open file " << argv[1] << "\n";
        return 1;
    }
    yyin = file;

    yyparse();


    fclose(file);

    return 0;
}
