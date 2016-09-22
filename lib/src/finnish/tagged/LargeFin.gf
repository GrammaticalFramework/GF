--# -path=.:..:../../abstract:../../common:../../api

--1 LargeFinAbs: large-scale parsing of Finnish with tagged lexicon

concrete LargeFin of LargeFinAbs = 
  NounFin,
  VerbFin, 
  AdjectiveFin,
  AdverbFin,
  NumeralFin,
  SentenceFin, 
  QuestionFin,
  RelativeFin,
  ConjunctionFin,
  PhraseFin,
  StructuralFin,
  IdiomFin,
  TenseX,
  ExtraFin,
  WordsFin ** open TagFin, StemFin in {

lincat
  Top = {s : Str} ;
  Punct = {s : Str} ;
lin
  PhrPunctTop phr pu = {s = phr.s ++ pu.s} ;
  PhrTop phr = phr ;
  
  fullstopPunct = {s = tagPOS "PUNCT" "."} ;
}