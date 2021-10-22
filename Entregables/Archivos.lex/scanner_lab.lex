or		or		
and		and
not		not
true	true|True|TRUE
false	false|False|FALSE

%%
[ \t]	; { /* Espacios en blanco */ }
[()\n]	return yytext[0];
{or}	{ return or; }
{and}	{ return and; }
{not}	{ return not; }
{true}	{ 
			sscanf("1", "%lf", &yylval);	
			return true; 
		}
{false}	{ 
			sscanf("0", "%lf", &yylval);	
			return false; 
		}
.		printf("Error lexico\n");
%%

int yywrap(void)
{
	return 0;
}