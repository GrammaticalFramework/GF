--# -path=.:../abstract:../common:../prelude

concrete GrammarLav of Grammar =
  NounLav,
  VerbLav,
  AdjectiveLav,
  AdverbLav,
  NumeralLav,
  SentenceLav,
  QuestionLav,
  RelativeLav,
  ConjunctionLav,
  PhraseLav,
  TextX - [Adv,CAdv],
  StructuralLav,
  IdiomLav,
  TenseX - [Adv,CAdv]
  ** {

flags
  startcat = Phr ;
  unlexer = text ;
  lexer = text ;

}
