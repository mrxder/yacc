%option noyywrap
%{
#include <stdlib.h>
#include <string.h>
%}

DIGIT    [0-9]
NUM      {DIGIT}+(\.{DIGIT}+)?

LETTER   [a-zA-Z]
ID       {LETTER}({LETTER}|{DIGIT})*
VAR      ${LETTER}({LETTER}|{DIGIT})*


%%

[ ]     { /* skip blanks */ }

"if"    {return IF;}
"else"  {return ELSE;}
"while" {return WHILE;}
"pi"    {return PI;}
"e"     {return E;}
"pow"   {return POW;}
"sqrt"  {return SQRT;}
"sin"   {return SIN;}
"cos"   {return COS;}
"tan"   {return TAN;}
"ln"    {return LN;}
"log"   {return LOG;}

{VAR}   {yylval.lexeme = strdup(yytext);
          return VAR;}
{NUM}    {yylval.value = atof(yytext);
          return NUM;}
{ID}     {yylval.lexeme = strdup(yytext);
          return ID;}

"+"     {return '+';}
"-"     {return '-';}
"*"     {return '*';}
"/"     {return '/';}
";"     {return ';';}
"("     {return '(';}
")"     {return ')';}
"{"     {return '{';}
"}"     {return '}';}
","     {return ',';}
\n      {return '\n';}
.       { }
  


%%

int
main()
{
  printf("> "); 
  return yyparse();
}
