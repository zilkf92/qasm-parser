/*recognize tokens and print them out*/
%{
    enum yytokentype {
        NUMBER = 250,
        RZ = 260,
        RX = 261,
        HAD = 262,
        CZ = 263,
        QUBIT = 270,
        EOL = 285,
        LEFTBRACK = 280,
        RIGHTBRACK = 281,
        COMMA = 282,
        LEFTPARENTH = 283,
        RIGHTPARENTH = 284
    };

    int yylval;
%}

%%
"rz"     { return RZ; }
"rx"     { return RX; }
"h"     { return HAD; }
"cz"     { return CZ; }
"q"     { return QUBIT; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
"["     { return LEFTBRACK; }
"]"     { return RIGHTBRACK; }
"("     { return LEFTPARENTH; }
")"     { return RIGHTPARENTH; }
","     { return COMMA; }
\n      { return EOL; }
[ \t]   { /* ignore whitespace */ }
.       { printf("Mystery character %c\n", *yytext); }

%%
main(int argc, char **argv)
{
    int tok;

    while(tok = yylex()) {
        printf("%d", tok);
        printf(" = %d\n", yylval);
    }
}