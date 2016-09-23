--1 LargeFinAbs: large-scale parsing of Finnish with tagged lexicon

abstract LargeFinAbs = 
  Noun,
  Verb, 
  Adjective,
  Adverb,
--  Numeral,
  Sentence, 
  Question,
  Relative,
  Conjunction,
  Phrase,
  Idiom,
--  Structural,
  Tense
----  ,ExtraFinAbs
--  ,WordsFinAbs
  ** {

flags startcat = Top ;

cat
  Top ;
  Punct ;
fun
  PhrPunctTop : Phr -> Punct -> Top ;
  PhrTop : Phr -> Top ;
  thePunct : Punct ;
fun
  theN : N ;
  theA : A ;
  theV : V ;
  theAdv : Adv ;

  theV2 : V2 ;

  sg1Pron : Pron ;
  sg2Pron : Pron ;
  sg3Pron : Pron ;
  pl1Pron : Pron ;
  pl2Pron : Pron ;
  pl3Pron : Pron ;

  theConj : Conj ;
  theDistrConj : Conj ;
  theSubj : Subj ;

  theSgDet : Det ;
  thePlDet : Det ;

}


