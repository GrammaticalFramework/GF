--# -path=.:../abstract:../common:../api:../prelude

-- TODO: include the full GrammarEst
-- The Slash* is currently excluded only for performance reasons.
concrete LangEst of Lang =
  GrammarEst - [Slash2V3,SlashV2A,Slash3V3,SlashV2VNP,SlashVV], ---- to speed up compilation
  LexiconEst
  ,ConstructionEst
  ,DocumentationEst --# notpresent
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
