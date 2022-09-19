/*recognize tokens and print them out*/
%{
# include "compiler.tab.h"
%}

%%
"rz"    { return RZ; }
"rx"    { return RX; }
"h"     { return HAD; }
"cz"    { return CZ; }
"q"     { return QUBIT; }
[0-9]+  { return INT; }
"pi"    { return PI; }
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"."     { return DEC; }
"["     { return LEFTBRACK; }
"]"     { return RIGHTBRACK; }
"("     { return LEFTPARENTH; }
")"     { return RIGHTPARENTH; }
","     { return COMMA; }
";"     { return SEMICOLON; }
\n      { return EOL; }
[ \t]   { /* ignore whitespace */ }
.       { printf("Unknown character \n"); }

