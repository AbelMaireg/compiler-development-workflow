%{
#include "grammar-out.tab.h"
%}

digit   [0-9]+

%%

{digit} {
    yylval = atoi(yytext);
    return NUMBER;
}

[\t ]+  /* Ignore whitespace */
\n      return '\n';

.       return yytext[0];  /* Return any other character as is */

%%

int yywrap() {
    return 1;
}
