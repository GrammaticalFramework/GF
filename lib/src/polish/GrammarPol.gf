--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete GrammarPol of Grammar = 
  NounPol, 
  VerbPol, 
  AdjectivePol,
  AdverbPol,
  NumeralPol,
  SentencePol,
  QuestionPol,
  RelativePol,
  ConjunctionPol,
  PhrasePol,
  TextPol,
  StructuralPol,
  IdiomPol
   ** { flags  startcat = Phr ; unlexer = text ; lexer = text ;} ;
