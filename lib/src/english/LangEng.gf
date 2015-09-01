--# -path=.:../abstract:../common:../api

concrete LangEng of Lang = 
  GrammarEng,
  LexiconEng
  ,ConstructionEng
  ,DocumentationEng --# notpresent
  ,MarkupEng - [stringMark]
  ** {



} ;
