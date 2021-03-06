%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "AnalizadorSemantico.tab.h"
    #include "funciones.h"
    
%}
%option yylineno

CARACT_SIMPLES "+"|"-"|"*"|"/"|"^"|"("|")"|","|";"|"="|"<"|">"|"%"|"&"|"|"|"~"|"!"|"?"|":"|"["|"]"|"{"|"}"|"."

DECIMAL        [0-9]
OCTAL          [0-7]
HEXA           [a-fA-F0-9]
LETRA          [a-zA-Z]

CONST_DECIMAL  [1-9]{DECIMAL}*
CONST_OCTAL    0{OCTAL}*
CONST_HEXA     0[xX]{HEXA}+
CONST_REAL     {DECIMAL}+"."{DECIMAL}+([eE](\+|\-)?{DECIMAL}+)?
CONST_CHAR     \'.\'
LITERAL_CADENA \".+\"

TIPOS_DATO    "void"|"char"|"short"|"int"|"long"|"float"|"double"|"signed"|"unsigned"
CLASE_ALM     "typedef"|"static"|"auto"|"register"|"extern"
CALIF_TIPO    "const"|"volatile"
STRUCT_UNION  "struct"|"union"

IDENTIFICADOR ({LETRA}|_)({LETRA}|{DECIMAL}|_)*

COMENTARIO_LINEA "//".*
COMENTARIO_BLOQUE "/*"([^*]|\*+[^/])*\*+\/

INCLUDE #include(" ")+(\".+\"|<.+>)
DEFINE #define(" ")+[^" "|"\n"]+(" ")*.*

ESPACIOS       " "|"\t"
COMODIN        .

%%

{CONST_DECIMAL}    {yylval.valorEntero = atoi(yytext);  return NUM_ENTERO;}
{CONST_HEXA}       {yylval.valorEntero = strtoll(yytext, NULL, 16);  return NUM_ENTERO;}
{CONST_OCTAL}      {yylval.valorEntero = strtoll(yytext, NULL, 8);  return NUM_ENTERO;}
{CONST_REAL}       {yylval.valorReal   = atof(yytext);  return NUM_REAL;}
{CARACT_SIMPLES}   { return yytext[0];}
"continue"         {yylval.valorString = strdup(yytext);  return CONTINUE;}
"break"            {yylval.valorString = strdup(yytext);  return BREAK;}
{INCLUDE}          {}
{DEFINE}           {}
"if"               {yylval.valorString = strdup(yytext);  return IF;}
"else"             {yylval.valorString = strdup(yytext);  return ELSE;}
"switch"           {yylval.valorString = strdup(yytext);  return SWITCH;}
"while"            {yylval.valorString = strdup(yytext);  return WHILE;}
"do"               {yylval.valorString = strdup(yytext);  return DO;}
"for"              {yylval.valorString = strdup(yytext);  return FOR;}
"case"             {yylval.valorString = strdup(yytext);  return CASE;}
"default"          {yylval.valorString = strdup(yytext);  return DEFAULT;}
"return"           {yylval.valorString = strdup(yytext);  return RETURN;}
"goto"             {yylval.valorString = strdup(yytext);  return GOTO;}
{TIPOS_DATO}       {yylval.valorString = strdup(yytext);  return TIPO_DATO;}
{CLASE_ALM}        {yylval.valorString = strdup(yytext);  return CLASE_ALM;}
{CALIF_TIPO}       {yylval.valorString = strdup(yytext);  return CALIF_TIPO;}
{STRUCT_UNION}     {yylval.valorString = strdup(yytext);  return STRUCT_UNION;}
"sizeof"           {yylval.valorString = strdup(yytext);  return SIZEOF;}
"enum"             {yylval.valorString = strdup(yytext);  return ENUM;}
{IDENTIFICADOR}    {yylval.valorString = strdup(yytext);  return ID;}
{COMENTARIO_LINEA} {}
{COMENTARIO_BLOQUE} {}
"\n"               {}
{ESPACIOS}+        {} 
{CONST_CHAR}       {yylval.valorString = strdup(yytext);  return CHAR;}
{LITERAL_CADENA}   {yylval.valorString = strdup(yytext);  return STRING;}

"*="               { return ASIG_MULT;}
"/="               { return ASIG_DIV;}
"%="               { return ASIG_MOD;}
"+="               { return ASIG_SUMA;}
"-="               { return ASIG_RESTA;}
"<<="              { return ASIG_DESP_IZQ;}
">>="              { return ASIG_DESP_DER;}
"&="               { return ASIG_AND_BIN;}
"^="               { return ASIG_XOR_BIN;}
"|="               { return ASIG_OR_BIN;}
"++"               { return OP_INC;}
"--"               { return OP_DEC;}
"=="               { return OP_IGUALDAD;}
"!="               { return OP_DESIGUALDAD;}
"&&"               { return OP_AND;}
"||"               { return OP_OR;}
"<="               { return OP_MENOR_IGUAL;}
">="               { return OP_MAYOR_IGUAL;}
"<<"               { return OP_DESP_IZQ;}
">>"               { return OP_DESP_DER;}
"->"               { return OP_MIEMBRO_PUNT;}
{COMODIN}          {agregarError("*No se reconoce el lexema","LEXICO",yylineno);} //tirate un make caro
%%