/* Bison program */
/* C code enclosed in %{}% is copied to the beginning of the generated parser */
%{
    #include <stdio.h>
    int yylex();
    int yyerror(char *s);

%}

/* declare tokens */
%token NUMBER
%token RZ, RX, H, CZ
%token QUBIT
%token LEFTBRACK, RIGHTBRACK, COMMA, LEFTPARENTH, RIGHTPARENTH, EOL


%%

/* rules in simplified BNF (Backus-Naur Form) */
/* BNF is a standard way to write context-free grammar (CFG) */
/* CFG describes the rules the parser uses to turn a sequence of tokens into a parse tree */

/* first two rules define the symbol prog */
/* implement loop that reads an expression terminated by a new line and prints its value */

prog: /* nothing */
    | prog stmts EOL { printf("= %d\n", $2); }
;

/* rest of the rules implement translation */
/* syntactic glue to put the grammar together */
stmts:
    | stmt SEMICOLON stmts
;

stmt:
    operation qubit {
        printf("Your entered a stmt - %s", $1);
    }
;

operation:
    RZ arg
    |
    RX arg
    |
    H
    |
    CZ
;

qubit:
    QUBIT alloc
;

alloc:
    LEFTBRACK NUMBER RIGHTBRACK
;

arg:
    LEFTPARENTH NUMBER RIGHTPARENTH
;

%%

int yyerror(char *s)
{
    printf(stderr, "Syntax Error on line %s\n", s);
    return 0;
}

/* main() routine which calls yyparse() */
/* yyparse() is the driver routine for the parser */
int main()
{
    yyparse();
    return 0;
}