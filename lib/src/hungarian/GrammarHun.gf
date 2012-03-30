--# -path=.:../abstract:../common:prelude

concrete GrammarHun of Grammar = 
  NounHun, 
  VerbHun, 
  AdjectiveHun,
  AdverbHun,
  NumeralHun,
  SentenceHun,
  QuestionHun,
  RelativeHun,
  ConjunctionHun,
  PhraseHun,
  TextX - [Pol,PPos,PNeg],
  StructuralHun,
  IdiomHun,
  TenseX - [Pol,PPos,PNeg]
  ** open ResHun, Prelude in 
{
--{
--
--flags startcat = Phr ; unlexer = text ; lexer = text ;
--
--lin
--  PPos = {s = [] ; p = CPos} ;
--  PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't
--
--
--} ;

}
