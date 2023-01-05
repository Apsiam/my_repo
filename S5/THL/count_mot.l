%option nounput noinput noyywrap

%{
#include <stdio.h>
#include <err.h>
%}

%%

%{
    printf("Please enter a sentence.\n");
    int count = 0;
%}

[a-zA-Z]+ {count++;}
"\n" {printf("count = %d\n", count);count = 0;}
[ \t]* {continue;}
. {printf("Error\n"); return 1;}

%%
int main() 
{
    while (yylex());
    return 0;
}
