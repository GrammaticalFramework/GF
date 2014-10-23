--# -path=.:../abstract:../common:../hindustani:../api

concrete LangHin of Lang = 
  GrammarHin,
  LexiconHin
 ,DocumentationHin --# notpresent
 ,ConstructionHin
  ** {

flags startcat = Phr ; unlexer=unwords ; lexer=words ;

}
