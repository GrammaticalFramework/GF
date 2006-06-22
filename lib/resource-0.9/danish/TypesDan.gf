--1 Danish Word Classes and Morphological Parameters
--
-- This is a resource module for Italian morphology, defining the
-- morphological parameters and word classes of Italian. 
-- The morphology is so far only
-- complete w.r.t. the syntax part of the resource grammar.
-- It does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.

instance TypesDan of TypesScand = {

param
  Gender  = Utr | Neutr ;
  NounGender = NUtr | NNeutr ;

oper
  genNoun = \s -> case s of {NUtr => Utr ; NNeutr => Neutr} ;
  sexNoun _ = NoMasc ;
  gen2nounGen = \s -> case s of {Utr => NUtr ; Neutr => NNeutr} ;

  utrum = Utr ; neutrum = Neutr ;

param
  AdjFormPos = Strong GenNum | Weak ;

}
