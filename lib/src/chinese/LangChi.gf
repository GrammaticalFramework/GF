--# -path=.:../abstract:../common:../prelude


concrete LangChi of Lang = 
  GrammarChi,
  LexiconChi
  ,ConstructionChi
  ,DocumentationChi --# notpresent
  ** {

flags startcat = Phr ; unlexer = concat ; lexer = text ;

} ;
