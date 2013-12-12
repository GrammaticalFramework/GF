--# -path=.:../abstract:../common:../prelude

concrete LangFin of Lang = 
  GrammarFin, 
  LexiconFin,
  ConstructionFin,
  DocumentationFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
