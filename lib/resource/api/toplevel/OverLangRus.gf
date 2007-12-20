--# -path=.:alltenses

concrete OverLangRus of OverLang = 
  OverGrammarRus-[PPos,PNeg,TPres,TPast,TFut,TCond,ASimul,AAnter], 
  LexiconRus-[PPos,PNeg,TPres,TPast,TFut,TCond,ASimul,AAnter] **{flags startcat=Phr;} ;
