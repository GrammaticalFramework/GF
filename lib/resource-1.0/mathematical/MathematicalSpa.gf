--# -path=.:../spanish:../romance:../abstract:../common:prelude

concrete MathematicalSpa of Mathematical = 
  NounSpa - [ComplN2], --- to avoid ambiguity 
--  VerbSpa, 
  AdjectiveSpa,
  AdverbSpa,
  NumeralSpa,
--  SentenceSpa,
  QuestionSpa,
  RelativeSpa,
  ConjunctionSpa,
  PhraseSpa,
  TextSpa,
  IdiomSpa,
  StructuralSpa,

  SymbolSpa,
  PredicationSpa, --  - [predV3,predV2], --- gf bug

  LexiconSpa
  ** {

flags startcat = Phr ;

} ;
