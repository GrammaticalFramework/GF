--# -path=.:../abstract:../common:../prelude


concrete LangChi of Lang = 
  GrammarChi,
  LexiconChi
  ,ConstructionChi
  ,DocumentationChi
  ** {

flags startcat = Phr ; unlexer = concat ; lexer = text ;

} ;
