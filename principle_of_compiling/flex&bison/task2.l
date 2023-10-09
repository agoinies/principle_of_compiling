%{
  //Add a head file here
%}
DIGIT [0-9]
ID [a-z][a-z0-9]*


%%
{DIGIT}+                 {printf( "An integer: %s (%d)\n", yytext,atoi( yytext ) );}             //整数，输出 An integer:
{DIGIT}+"."{DIGIT}*      {printf( "A float: %s (%g)\n", yytext,atof( yytext ) );                 //小数，输出 A float:
}
if|then|begin|end|procedure|function {printf( "A keyword: %s\n", yytext );}                         //如果关键字是其中的一个，输出 A keyword:
{ID} printf( "An identifier: %s\n", yytext );                                                       //输入的字符串不是关键字，输出该字符 An identifier:
"+"|"-"|"*"|"/"         printf( "An operator: %s\n", yytext );                                      //四则运算符中任意一个，输出该运算符 An operator:
"{"[^}\n]*"}" 	/* eat up one-line comments */                                                         //
[ \t\n]+ 		/* eat up whitespace */
.       printf( "Unrecognized character: %s\n", yytext );
%%


int main( argc, argv )
int argc;
char **argv;
{
++argv, --argc; /* skip over program name */
if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
else
        yyin = stdin;
        yylex();
}       