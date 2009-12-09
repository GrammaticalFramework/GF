--1 The Mathematics API to the Resource Grammar

-- This grammar is a collection of the different modules.
-- It differs from $Lang$ in two main ways:
-- - the combinations in Noun, Verb, Adjective, Adverb, Sentence are not included
-- - instead, Symbol and Predication are used
-- 
-- 
-- In practice, the most important difference is that only present-tense sentences
-- are included, and that symbolic expressions are recognized as NPs.

abstract Mathematical = 
  Noun - [ComplN2], --- to avoid ambiguity
--  Verb, 
  Adjective,
  Adverb,
  Numeral,
--  Sentence, 
  Question,
  Relative,
  Conjunction,
  Phrase,
  Text,
  Idiom,
  Structural,

  Symbol,
  Predication,

  Lexicon
  ** {} ;
