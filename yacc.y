%{
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
%token IF ELSE WHILE
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
line  : expr '\n'      {printf("Result: %f\n", $1);}
      | ID '\n'            {printf("Result: %s\n", $1);}
      ;
expr  : expr '+' expr  {$$ = $1 + $3;}
      | expr '-' expr  {$$ = $1 - $3;}
      | expr '*' expr  {$$ = $1 * $3;}
      | expr '/' expr  {$$ = $1 / $3;}
      | '(' expr ')'   {$$ = $2;}
      | NUM            {$$ = $1;}
      | '-' expr %prec UMINUS {$$ = -$2;}
      ;

%%

#include "lex.yy.c"