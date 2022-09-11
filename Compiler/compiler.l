/*recognize tokens and print them out*/
%{
# include "compiler.tab.h"
%}

%%
"rz"     { return RZ; }
"rx"     { return RX; }
"h"     { return HAD; }
"cz"     { return CZ; }
"q"     { return QUBIT; }
[0-9]+  { return NUMBER; }
"["     { return LEFTBRACK; }
"]"     { return RIGHTBRACK; }
"("     { return LEFTPARENTH; }
")"     { return RIGHTPARENTH; }
","     { return COMMA; }
\n      { return EOL; }
[ \t]   { /* ignore whitespace */ }
.       { printf("Mystery character"); }

