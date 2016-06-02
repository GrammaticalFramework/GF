---# -path=.:../../gf/lib/src/abstract:../common:../prelude
--# -path=../abstract:../common:../prelude

concrete LangGrc of Lang = 
  GrammarGrc, 
  LexiconGrc -- use AllGrc to have Extra and BornemannGrc-words
--  ,ConstructionGrc  -- too much to be added ad-hoc HL
--  ,DocumentationGrc --# notpresent
  ** {

flags startcat = Phr ; 
      unlexer = text ; lexer = text ;
      -- unlexer = unlexgreek ; lexer = lexgreek ; -- effect?
} ;
