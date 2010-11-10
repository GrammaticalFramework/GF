--# -path=.:../abstract:../common:../prelude

--(c) 2010 Markos KG
-- Licensed under LGPL

concrete LangAmh of Lang = 
  GrammarAmh,
  LexiconAmh
  ** {

  flags startcat = Phr ; unlexer = text ; lexer = text ; coding = utf8 ;

}


