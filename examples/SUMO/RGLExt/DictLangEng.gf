--# -path=.:../../../lib/src/abstract:../../../lib/src/english:../../../lib/src/common

concrete DictLangEng of DictLang = 
  GrammarEng,
  ExtensionEng ** {

flags  unlexer = text ; lexer = text ;

} ;
