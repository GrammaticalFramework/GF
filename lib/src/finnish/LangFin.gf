--# -path=.:../abstract:../common:../prelude

concrete LangFin of Lang = 
  GrammarFin, ---  - [SlashV2VNP,SlashVV], ---- to speed up parsing grammar
  LexiconFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
