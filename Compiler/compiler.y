/* Bison program */
/* C code enclosed in %{}% is copied to the beginning of the generated parser */
%{
    #include <stdio.h>
    int yylex();
    int yyerror(char *s);

%}

/* declare tokens */
/* This section provides information to Bison about the token types */
/* Each terminal symbol that is not a single-character literal must be declared */
%token INT
%token RZ RX HAD CZ
%token QUBIT
%token ADD SUB MUL DIV DEC PI
%token LEFTBRACK RIGHTBRACK COMMA SEMICOLON LEFTPARENTH RIGHTPARENTH EOL


%%

/* rules in simplified BNF (Backus-Naur Form) */
/* BNF is a standard way to write context-free grammar (CFG) */
/* CFG describes the rules the parser uses to turn a sequence of tokens into a parse tree */

/* first two rules define the symbol prog */
/* implement loop that reads an expression terminated by a new line and prints its value */

prog: /* nothing */
| prog exp EOL { printf("= %d\n", $1); }
;

/* rest of the rules implement translation */
/* syntactic glue to put the grammar together */

exp: singleqbgate {
        printf("You entered a Single Qubit Gate - %s", $1);
    }
| twoqbgate {
    printf("You entered a Two Qubit Gate - %s", $1);
}
;

singleqbgate: RZ arg qubitno {
        printf("You entered a RZ operation \n");
    }
    |
    RX arg qubitno {
        printf("You entered a RX operation \n");
    }
    |
    HAD qubitno {
        printf("You entered a HAD operation \n");
    }
;

twoqbgate: CZ qubitno COMMA qubitno {
        printf("You entered a CZ operation \n");
    }
;

qubitno: QUBIT LEFTBRACK INT RIGHTBRACK {
    printf("You entered qubit no \n", $3);
};

arg: LEFTPARENTH INT RIGHTPARENTH {
        printf("You entered an INT in arg \n");
    }
| LEFTPARENTH float RIGHTPARENTH {
        printf("You entered a float in arg \n");
    }
;

float: INT {
        printf("You entered an INT \n");
    }
| INT DEC INT {
        printf("You entered a float \n");
    }
| PI {
        printf("You entered PI \n");
    }
| float arith float {
        printf("You entered a calculation \n");
    }
;

arith: ADD
| SUB
| MUL
| DIV ;


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