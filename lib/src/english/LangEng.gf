--# -path=.:../abstract:../common:../prelude

concrete LangEng of Lang = 
  GrammarEng,
  LexiconEng,
  ConstructionEng,
  DocumentationEng
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
