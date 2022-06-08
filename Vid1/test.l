%{
    ****** C stuff (headers, declarations, variables, etc.) ******
    #include <stdio.h>
    #include "test.tab.h"
    void showError();
}

****** regular expressions ******
numbers     ([0-9])+
alpha       ([a-zA-Z])+

%%
****** token specifications ******
"hello"     {return (STRING);}
{alpha}     {sscanf(yytext, "%s", yylval.name); return (STRING);}
{numbers}   {yylval.number = atoi(yytext); return(NUM);}
";"         {return (SEMICOLON);}
.           {showError(); return(OTHER);}

%%

****** C functions (can be main or others) ******
void showError(){
    printf("Other input");
}