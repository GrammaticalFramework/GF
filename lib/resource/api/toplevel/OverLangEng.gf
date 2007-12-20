--# -path=.:alltenses

concrete OverLangEng of OverLang = 
  OverGrammarEng-[PPos,PNeg,TPres,TPast,TFut,TCond,ASimul,AAnter], 
  LexiconEng-[PPos,PNeg,TPres,TPast,TFut,TCond,ASimul,AAnter] **{flags startcat=Phr;} ;
