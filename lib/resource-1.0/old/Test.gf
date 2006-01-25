--1 The Reduced Top Module of the Resource Grammar

-- This grammar is just a collection of the different modules,
-- and one that can be imported when one wants to test a reduced version
-- of the grammar. The complete top module is [Lang Lang.html].

-- The main constructs missing are tenses of sentences, numerals, and 
-- comprehensive lexicon.

abstract Test = 
  Noun,
  Verb, 
  Adjective,
  Adverb,
  Sentence, 
  Question,
  Relative,
  Conjunction,
  Phrase,
  Untensed, 
  -- Tensed,
  -- Structural,
  -- Lexicon,
  -- Numeral,
  Lex 
  ** {} ;
