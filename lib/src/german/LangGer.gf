--# -path=.:../abstract:../common:../prelude

concrete LangGer of Lang = 
  GrammarGer,
  LexiconGer,
  ConstructionGer,
  DocumentationGer
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
