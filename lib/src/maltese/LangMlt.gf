-- LangMlt.gf: common syntax and lexicon
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2011
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

concrete LangMlt of Lang =
  GrammarMlt,
  LexiconMlt
  ** {

  flags startcat = Phr ; unlexer = text ; lexer = text ; coding = utf8 ;

}
