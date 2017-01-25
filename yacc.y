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
line  : ID                                            {printf("Result: %s\n> ", $1);}
      | expr                                          {printf("Result: %f\n> ", $1);}
      | bool_exp                                      {printf("%s\n> ", $1 ?"true":"false");}
      | VAR EQ expr      {setVarDouble($1, $3); printf("Result: %f\n> ", getDoubleValue($1));}
      | flow                                          {printf("Result: %f\n> ", $1);}
      
flow : IF '(' cond ')' '{' expr '}'     
            {if($3==true) {$$=$6;} 
            else {printf("False condition\n> ");}}
      | IF '(' cond ')' '{' expr '}' ELSE '{' expr '}'    
            {if($3==true){$$=$6;} 
            else {$$=$10;}} 
      | IF '(' cond ')' '{' VAR EQ expr '}'     
            {if($3==true) {setVarDouble($6, $8); $$= getDoubleValue($6);} 
            else {printf("False condition\n> ");}}
      | IF '(' cond ')' '{' VAR EQ expr '}' ELSE '{' VAR EQ expr '}'    
            {if($3==true){setVarDouble($6, $8); $$= getDoubleValue($6);} 
            else {setVarDouble($12, $14); $$= getDoubleValue($12);}}
      | IF '(' cond ')' '{' VAR EQ expr '}' ELSE '{' expr '}'    
            {if($3==true){setVarDouble($6, $8); $$= getDoubleValue($6);} 
            else {$$=$12;}}
      | IF '(' cond ')' '{' expr '}' ELSE '{' VAR EQ expr '}'    
            {if($3==true){$$=$6;} 
            else {setVarDouble($10, $12); $$= getDoubleValue($10);}}
      | IF '(' cond ')' '{' flow '}'  
            {if($3==true) {$$=$6;} 
            else {printf("False condition\n> ");}}
      | IF '(' cond ')' '{' expr '}' ELSE '{' flow '}'    
            {if($3==true){$$=$6;} 
            else {$$=$10;} }
      | IF '(' cond ')' '{' flow '}' ELSE '{' expr '}'    
            {if($3==true){$$=$6;} 
            else {$$=$10;}} 
     

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
      | VAR              {$$ = getDoubleValue($1);}
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
