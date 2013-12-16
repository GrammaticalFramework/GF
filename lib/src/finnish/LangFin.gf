--# -path=.:../abstract:../common:../api

concrete LangFin of Lang = 
  GrammarFin, 
  LexiconFin
  , ConstructionFin
  , DocumentationFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
