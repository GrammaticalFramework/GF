--# -path=.:../abstract:../common:prelude

concrete GrammarEng of Grammar = 
  NounEng, 
  VerbEng, 
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
  SentenceEng,
  QuestionEng,
  RelativeEng,
  ConjunctionEng,
  PhraseEng,
  TextX - [Pol,PPos,PNeg,SC,CAdv],
  StructuralEng,
  IdiomEng,
  TenseX - [Pol,PPos,PNeg,SC,CAdv]
  ** open ResEng, Prelude in {

flags startcat = Phr ; unlexer = text ; lexer = text ;

lin
  PPos = {s = [] ; p = CPos} ;
  PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't


} ;
