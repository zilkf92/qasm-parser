%{
    #define YYSTYPE double
    #include <math.h>

%}

%token NUM

%%

input:  /* empty */
    | input line
;

line:   '\n'
    | exp '\n' { printf ("\t%.10g\n", $1); }
;

exp:    NUM { $$ = $1; }
    | exp exp "+" { $$ = $1 + $2; }
    | exp exp "-" { $$ = $1 - $2; }
    | exp exp "*" { $$ = $1 * $2; }
    | exp exp "/" { $$ = $1 / $2; }
    /* Exponentiation */
    | exp exp "^" { $$ = pow ($1, $2); }
    /* Unary minus */
    | exp "n" { $$ = -$1; }
;
%%

#include <ctype.h>
#include <stdio.h>

yylex ()
{
    int c;

    while ((c = getchar ()) == ' ' || c == '\t')
    ;

    if (c == '.' || isdigit (c))
        {
            ungetc (c, stdin);
            scanf ("%lf", &yylval);
            return NUM;
        }
    if (c == EOF)
        return 0;
    return c;
}

main ()
{
    yyparse ();
}

yyerror (s)
    char *s;
{
    printf ("%s\n", s);
}