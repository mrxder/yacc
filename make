flex -l lex.l
yacc -vd yacc.y
gcc y.tab.c -ly -ll -lm