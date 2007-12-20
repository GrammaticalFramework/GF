--# -path=.:alltenses

concrete OverLangSwe of OverLang = 
  OverGrammarSwe-[PPos,PNeg,TPres,TPast,TFut,TCond,ASimul,AAnter], 
  LexiconSwe-[PPos,PNeg,TPres,TPast,TFut,TCond,ASimul,AAnter] **{flags startcat=Phr;} ;
