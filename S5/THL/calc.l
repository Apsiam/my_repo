%option nounput noinput noyywrap

%{
#include <stdio.h>
/* Fill in the blanks */
%}

%%

%{
printf("Please enter a simple arithmetic expression.\n");
int n1 = 0;
int n2 = 0;
char op = 0;
%}

[0-9]+ {
if(n1 == 0)
{
    n1 = yylex();
}
else if (n2 == 0)
{
    n2 = yylex();
    if(op != 0)
    {
        if(op == '+')
        {
            n1 += n2;
        }
        elif(op == '-')
        {
            n1 -= n2;
        }
        else
        {
            printf("Error\n");
        }
        op = 0;
        n2 = 0;
    }
}
else
{
    printf("Erreur\n");
}}
[+-] {if(op != 0)
{
    op = yylex();
}}


%%

int main() 
{
    while (yylex());
    return 0;
}
