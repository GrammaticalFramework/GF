--# -path=.:../abstract:../common:../api:../prelude

concrete LangEng of Lang = 
  GrammarEng,
  LexiconEng
  ,ConstructionEng
  ,DocumentationEng --# notpresent
  ,MarkupEng - [stringMark]
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
