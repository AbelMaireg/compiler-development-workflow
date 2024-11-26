%%
[0-9]+    { yylval = atoi(yytext); return NUM; }  // Return NUM token
[ \t\n]   { /* Ignore whitespace */ }
.         { return yytext[0]; }
%%
int yylex(void);
