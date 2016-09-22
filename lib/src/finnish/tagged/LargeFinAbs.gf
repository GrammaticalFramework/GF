--1 LargeFinAbs: large-scale parsing of Finnish with tagged lexicon

abstract LargeFinAbs = 
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
  Idiom,
  Structural,
  Tense,
  ExtraFinAbs,
  WordsFinAbs ** {

flags startcat = Top ;

cat
  Top ;
  Punct ;
fun
  PhrPunctTop : Phr -> Punct -> Top ;
  PhrTop : Phr -> Top ;
  fullstopPunct : Punct ;
  
}


