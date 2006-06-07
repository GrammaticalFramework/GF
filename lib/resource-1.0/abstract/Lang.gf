--1 The Main Module of the Resource Grammar

-- This grammar is just a collection of the different modules,
-- and the one that can be imported when one wants to test the
-- grammar. A module without a lexicon is [Grammar Grammar.html],
-- which may be more suitable to open in applications.

abstract Lang = 
  Grammar,
  Lexicon
  ** {} ;
