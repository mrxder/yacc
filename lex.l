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
\n      {return '\n';}
.       { }
  


%%
