-- LangMlt.gf: common syntax and lexicon
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

concrete LangMlt of Lang =
  GrammarMlt,
  LexiconMlt
  ** {

  flags
    coding = utf8 ;
    startcat = Phr ;
    unlexer = text ;
    lexer = text ;

}
