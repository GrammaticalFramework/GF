--# -path=alltenses:../common:../abstract

concrete ExtendDut of Extend =
  CatDut ** ExtendFunctor
--   - []                   -- put the names of your own definitions here
  with
    (Grammar = GrammarDut) **
  open
    GrammarDut,
    ResDut,
    Coordination,
    Prelude,
    ParadigmsDut in {
    -- put your own definitions here
    
    }