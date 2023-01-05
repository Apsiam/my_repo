%option nounput noinput noyywrap

%{
    #include <stdio.h>
%}

BLANK [ \t]

%%

%{
printf("Looking for a pattern...\n");
%}

"2" {printf("deux");}
"4" {printf("quatre");}
"42" {printf("heloooooooo");}
[0-9]+ {printf("number = %s", yytext);}
"+" {printf("'+'");}
"-" {printf("'-'");}
[ \t\v]+ {printf(" ");}
. {printf(".");}

%%

int main() 
{
    while (yylex());
    return 0;
}
