%{
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
%}


%union {
       char* lexeme;			//identifier
       double value;			//value of an identifier of type NUM
       }

%token <value>  NUM
%token IF ELSE WHILE PI E POW SQRT SIN COS TAN LN LOG
%token <lexeme> ID
%token <lexeme> VAR

%type <value> expr
 /* %type <value> line */

%left '-' '+'
%left '*' '/'
%right UMINUS

%start lines

%%
lines : lines line | line;
line  : expr '\n'      {printf("Result: %f\n> ", $1);}
      | ID '\n'            {printf("Result: %s\n> ", $1);}
      ;
expr  : expr '+' expr  {$$ = $1 + $3;}
      | expr '-' expr  {$$ = $1 - $3;}
      | expr '*' expr  {$$ = $1 * $3;}
      | expr '/' expr  {$$ = $1 / $3;}
      | PI '*' expr    {$$ = 3.1415 * $3;}
      | E '*' expr              {$$ = 2.718281 * $3;}
      | POW  '(' expr ',' expr ')' {$$ = pow($3,$5);}       //use -lm to compile
      | SQRT '(' expr ')'          {$$ = sqrt($3);}
      | SIN '(' expr ')'           {$$ = sin($3);}
      | COS '(' expr ')'           {$$ = cos($3);}
      | TAN '(' expr ')'           {$$ = tan($3);}
      | LN '(' expr ')'            {$$ = log($3);}
      | LOG '(' expr ')'           {$$ = log10($3);}
      | NUM            {$$ = $1;}
      | '-' expr %prec UMINUS {$$ = -$2;}
      ;

%%

#include "lex.yy.c"
