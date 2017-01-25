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
COMMENT  #.*\n

%%

[ ]     { /* skip blanks */ }

[iI][fF]              {return IF;}
[eE][lL][sS][eE]      {return ELSE;}
[wW][hH][iI][lL][eE]  {return WHILE;}
[pP][iI]              {return PI;}
[eE]                  {return E;}
[pP][oO][wW]          {return POW;}
[sS][qQ][rR][tT]      {return SQRT;}
[sS][iI][nN]          {return SIN;}
[cC][oO][sS]          {return COS;}
[tT][aA][nN]          {return TAN;}
[lL][nN]              {return LN;}
[lL][oO][gG]          {return LOG;}

{VAR}   {yylval.lexeme = strdup(yytext);
          return VAR;}
{NUM}    {yylval.value = atof(yytext);
          return NUM;}
{ID}     {yylval.lexeme = strdup(yytext);
          return ID;}
{COMMENT}     { }

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
"="     {return EQ;}
\n      {return '\n';}

"<"     {return LT;}
">"     {return GT;}
"<="    {return LEQT;}
">="    {return GEQT;}
"=="    {return EQEQ;}
"!="    {return NEQ;}
.       { }
  


%%

int
main()
{
  printf("> "); 
  return yyparse();
}
