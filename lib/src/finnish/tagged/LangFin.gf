--# -path=.:..:../../abstract:../../common:../../api

concrete LangFin of Lang = 
  GrammarFin, 
  LexiconFin
  , ConstructionFin
  , DocumentationFin --# notpresent
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
