--# -path=.:alltenses

concrete DemoJEng of Demo = DemoJ with 
  (Noun = NounEng),
  (Clause = ClauseEng), --
  (Adjective = AdjectiveEng),
  (Adverb = AdverbEng),
  (Numeral = NumeralEng),
----  Sentence,
  (Question )- [QuestVP,QuestSlash],
----  Relative,
----  Conjunction,
----  Phrase,
----  TextX,
----  Idiom,
  Structural - [everybody_NP,everything_NP,something_NP],
  Lexicon
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
