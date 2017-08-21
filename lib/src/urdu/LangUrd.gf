--# -path=.:../abstract:../common:../hindustani

concrete LangUrd of Lang = 
  GrammarUrd,
  LexiconUrd
 ,DocumentationUrd --# notpresent
 ,ConstructionUrd

  ** {

flags startcat = Phr ; unlexer=unwords ; lexer=words ;

}
