--# -path=.:../abstract:../common:../prelude

concrete DictLangRon of DictLang = 
  GrammarRon,
  ExtensionRon
  ** {

flags  unlexer = text ; lexer = text ;

} ;
