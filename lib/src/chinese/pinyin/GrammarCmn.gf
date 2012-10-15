--# -path=.:../abstract:../common:prelude

concrete GrammarCmn of Grammar = 
  NounCmn, 
  VerbCmn, 
  AdjectiveCmn,
  AdverbCmn,
  NumeralCmn,
  SentenceCmn,
  QuestionCmn,
  RelativeCmn,
  ConjunctionCmn,
  PhraseCmn,
  TextCmn,
  StructuralCmn,
  IdiomCmn,
  TenseCmn
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
