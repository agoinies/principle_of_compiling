%{
#include "string.h"
#include "def.h"

extern int yycolumn;

#define YYSTYPE yylval
extern "C"
{	
	int yywrap(void);
	int yylex(void);
}

void flexout(std::string name,std::string value){
  std::cout<<name<<"\t:"<<value<<std::endl;
}
//flex为bison提供行号信息
%}
%option yylineno 


ID          [A-Za-z][A-Za-z0-9]*

INT	        [-]?[1-9][0-9]*|0
HEX         0[Xx][0-9a-fA-F]*
OCT         0[0-7]*

ILHEX       0[Xx][0-9a-fA-F]*[G-Zg-z]+[A-Za-z0-9]*
ILOCT       0[0-7]*[8-9A-Za-z]+[A-Za-z0-9]*

FLOAT       [-]?[0-9]*\.[0-9]+
SCIEN       [-]?[0-9]?[\.[0-9]*]?[Ee]{1}[-+]?[0-9]+

%%


"int"        {flexout("TYPE","int");}
"float"      {flexout("TYPE","float");}
"char"      {flexout("TYPE","char");}
">"|">="|"<"|"<="|"=="|"!="   {flexout("RELOP",yytext);}

"++"          {flexout("PLUSPLUS","++");}
"--"          {flexout("MINUSMINUS","--");}
"+="          {flexout("PLUSASS","+=");}
"-="          {flexout("MINUSASS","-=");}

"+"           {flexout("PLUS","+");}
"-"           {flexout("MINUS","-");}
"*"           {flexout("star","*");}
"/"           {flexout("DIV","/");}
"="           {flexout("ASSIGNOP","=");}
","           {flexout("COMMA",",");}
";"           {flexout("SEMI",";");}
"."           {flexout("DOT",".");}


"&&"          {flexout("AND","&&");}
"||"          {flexout("OR","||");}
"!"           {flexout("NOT","!");}


"("           {flexout("LP","(");}
")"           {flexout("RP",")");}

"{"           {flexout("LC","{");}
"}"           {flexout("RC","}");}

"["           {flexout("LB","[");}
"]"           {flexout("RB","]");}

"struct"    {flexout("STRUCT","struct");}
"return"    {flexout("RETURN","return");}
"if"        {flexout("IF","if");}
"else"      {flexout("ELSE","else");}
"while"     {flexout("WHILE","while");}


{ID}      {flexout("ID",yytext);}
{INT}     {flexout("INT",yytext);}
{OCT}     {flexout("INT",yytext);}
{HEX}     {flexout("INT",yytext);}
{FLOAT}   {flexout("FLOAT",yytext);}
{SCIEN}   {flexout("FLOAT",yytext);}

[\n]		{yycolumn=1; }
[ \r\t]		{/*printf("过滤空格等字符\n");*/}
{ILHEX}     { printf("Error type A at Line %d: Illegal hexadecimal number \'%s\'\n", yylineno, yytext); }
{ILOCT}     { printf("Error type A at Line %d: Illegal octal number \'%s\'\n", yylineno, yytext); }

.			{ printf("Error type A at Line %d: Mysterious characters \'%s\'\n", yylineno, yytext); }

%%

int yywrap()
{
    return 1;
}
