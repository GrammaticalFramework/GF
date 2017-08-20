--# -path=alltenses:../common:../abstract

concrete ExtendSpa of Extend =
  CatSpa ** ExtendFunctor
--   - []                   -- put the names of your own definitions here
  with
    (Grammar = GrammarSpa) **
  open
    GrammarSpa,
    ResSpa,
    Coordination,
    Prelude,
    ParadigmsSpa in {
    -- put your own definitions here
    
    }