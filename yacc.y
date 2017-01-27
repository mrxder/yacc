%{
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <stdbool.h>
#include "variableList.c"
%}

%union {
       char* lexeme;			//identifier
       double value;			//value of an identifier of type NUM
       bool check;
       }

%token <value>  NUM
%token IF ELSE WHILE PI E POW SQRT SIN COS TAN LN LOG EQ LT GT LEQT GEQT EQEQ NEQ
%token <lexeme> ID 
%token <lexeme> VAR

%type <value> expr
%type <value> state
%type <value> line
%type <check> cond
%type <check> bool_exp

%type <value> flow

%left '-' '+'
%left '*' '/'
%right UMINUS EQ

%start lines

%%
lines : lines line '\n'       
      | line '\n';
line  : ID                                            {printf("Echo: %s\n> ", $1);}
      | expr                                          {printf("Result: %f\n> ", $1);}
      | bool_exp                                      {printf("%s\n> ", $1 ?"true":"false");}
      | VAR EQ expr                                   {setVarDouble($1, $3); printf("Set Var to: %f\n> ", getDoubleValue($1));}
      | flow                                          {if($1==999999){printf("False condition \n> ");} else {printf("Result: %f\n> ", $1);}}

flow : IF '(' cond ')' '{' state '}'     
            {if($3==true) {$$=$6;} 
            else { $$=999999;}}
      | IF '(' cond ')' '{' state '}' ELSE '{' state '}'    
            {if($3==true){$$=$6;} 
            else {$$=$10;}} 

state : expr {$$=$1;}
      | VAR EQ expr {setVarDouble($1, $3); $$= getDoubleValue($1);}
      | flow {$$=$1;}
      ;

expr  : expr '+' expr  {$$ = $1 + $3;}
      | expr '-' expr  {$$ = $1 - $3;}
      | expr '*' expr  {$$ = $1 * $3;}
      | expr '/' expr  {$$ = $1 / $3;}
      | PI             {$$ = 3.14159265;}
      | E              {$$ = 2.718281;}
      | POW  '(' expr ',' expr ')' {$$ = pow($3,$5);}       //use -lm to compile
      | SQRT '(' expr ')'          {$$ = sqrt($3);}
      | SIN '(' expr ')'           {$$ = sin($3);}
      | COS '(' expr ')'           {$$ = cos($3);}
      | TAN '(' expr ')'           {$$ = tan($3);}
      | LN '(' expr ')'            {$$ = log($3);}
      | LOG '(' expr ')'           {$$ = log10($3);}
      | NUM            {$$ = $1;}
      | VAR              {if(getVarDouble($1) == NULL) {printf("not assigned\n> ");} else {$$ = getDoubleValue($1);}}
      | '-' expr %prec UMINUS {$$ = -$2;}
      ;

bool_exp : cond   {$$ = $1;}
      ;

cond  : expr LT expr          { if($1 < $3){$$=true;}else{$$=false;}}
      | expr GT expr          { if($1 > $3){$$=true;}else{$$=false;}}
      | expr LEQT expr        { if($1 <= $3){$$=true;}else{$$=false;}}
      | expr GEQT expr        { if($1 >= $3){$$=true;}else{$$=false;}}
      | expr EQEQ expr          { if($1 == $3){$$=true;}else{$$=false;}}
      | expr NEQ expr         { if($1 != $3){$$=true;}else{$$=false;}}
      ;


%%

#include "lex.yy.c"

