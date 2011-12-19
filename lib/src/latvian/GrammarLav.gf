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
  TextX - [CAdv],
  StructuralLav,
  IdiomLav,
  TenseX - [CAdv]
  ** {

flags
  startcat = Phr ;
  unlexer = text ;
  lexer = text ;

}
