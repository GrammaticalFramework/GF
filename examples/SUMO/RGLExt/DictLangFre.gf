--# -path=.:../abstract:../common:../prelude:../romance:

concrete DictLangFre of DictLang = 
  GrammarFre,
  ExtensionFre
  ** {

flags  unlexer = text ; lexer = text ;

} ;
