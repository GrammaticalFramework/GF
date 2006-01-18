--1 The Main Module of the Resource Grammar

-- This grammar is just a collection of the different modules,
-- and the one that can be imported when one wants to test the
-- grammar. A smaller top module is [Test Test.html].

abstract Lang = 
  Noun,
  Verb, 
  Adjective,
  Adverb,
  Numeral,
  Sentence, 
  Question,
  Relative,
  Conjunction,
  Phrase,
  Tensed,
  Structural,
  Basic
  ** {} ;
