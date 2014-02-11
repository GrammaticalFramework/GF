--# -path=.:../abstract:../common:../api

concrete LangEng of Lang = 
  GrammarEng,
  LexiconEng
  ,ConstructionEng
  ,DocumentationEng
  ,MarkupEng - [stringMark]
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
