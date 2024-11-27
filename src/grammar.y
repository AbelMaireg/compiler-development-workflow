%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%

calculation:
    calculation expression '\n' { printf("Result: %d\n", $2); }
    | /* empty */
    ;

expression:
    expression '+' expression { $$ = $1 + $3; }
    | expression '-' expression { $$ = $1 - $3; }
    | expression '*' expression { $$ = $1 * $3; }
    | expression '/' expression { $$ = $1 / $3; }
    | '(' expression ')' { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%%

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}
