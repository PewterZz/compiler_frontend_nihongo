%{
#include "parser.tab.h"
%}

DIGIT [0-9]
ID [a-zA-Z][a-zA-Z0-9_]*

%%
"イフ"        { return IF; }
"エルイフ"    { return ELIF; }
"エルス"      { return ELSE; }
"フォー"      { return FOR; }
"ホワイル"    { return WHILE; }
"デフ"        { return DEF; }
"クラス"      { return CLASS; }
"トライ"      { return TRY; }
"エクセプト"  { return EXCEPT; }
"ファイナリー" { return FINALLY; }
"リターン"    { return RETURN; }
"レイズ"      { return RAISE; }
"フロム"      { return FROM; }
"インポート"  { return IMPORT; }
"アズ"        { return AS; }
"パス"        { return PASS; }
"ブレーク"    { return BREAK; }
"コンティニュー" { return CONTINUE; }
"グローバル"  { return GLOBAL; }
"ノンローカル" { return NONLOCAL; }
"アサート"    { return ASSERT; }
"デル"        { return DEL; }
"ヤールド"    { return YIELD; }
"アシンク"    { return ASYNC; }
"アウェイト"  { return AWAIT; }
"トゥルー"    { return TRUE; }
"フォルス"    { return FALSE; }
"ナン"        { return NONE; }
[ \t\n]      ; // Ignore whitespace
.           { fprintf(stderr, "Unexpected character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
