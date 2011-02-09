--# -path=.:../abstract:../common:../prelude

concrete LangFin of Lang = 
--  GrammarFin - [SlashV2VNP,SlashVV], ---- to speed up compilation
  GrammarFin, 
  LexiconFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
