%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUM

%%
expr:
    expr '+' expr      { printf("%d\n", $1 + $3); }
  | expr '-' expr      { printf("%d\n", $1 - $3); }
  | NUM                { $$ = $1; }
  ;

%%
int yylex(void);
void yyerror(const char *s) { fprintf(stderr, "%s\n", s); }

int main() {
    printf("Enter an expression: ");
    yyparse();
    return 0;
}
