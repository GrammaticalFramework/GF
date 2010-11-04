--# -path=.:prelude
concrete CatPnb of Cat = open ResPnb, Prelude in { 
	flags coding=utf8 ; optimize=all_subs; 

  lincat
    N = Noun ;
    PN = {s:Str} ;
    V1 = Verb1 ;
    V4 = Verb4 ;
    Adj1 = Adjective1 ;
    Adj2 = Adjective2 ;
    Adj3 = {s:Str} ;
    Adv = {s:Str} ;
    SMonth = {s:Str} ;
    

}
