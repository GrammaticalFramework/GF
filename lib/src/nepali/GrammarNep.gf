--# -path=.:../abstract:../common:../prelude

 concrete GrammarNep of Grammar = 
  NounNep,
  VerbNep, 
  AdjectiveNep,    
  AdverbNep,
  NumeralNep,  
  SentenceNep,  
  QuestionNep,
  RelativeNep,
  ConjunctionNep,  
  PhraseNep,
  TextX - [Adv],  
  StructuralNep,  
  TenseX - [Adv],
  IdiomNep
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


