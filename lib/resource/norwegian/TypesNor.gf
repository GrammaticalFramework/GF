--1 Norwegian Word Classes and Morphological Parameters
--
-- This is a resource module for Italian morphology, defining the
-- morphological parameters and word classes of Italian. 
-- The morphology is so far only
-- complete w.r.t. the syntax part of the resource grammar.
-- It does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.

instance TypesNor of TypesScand = {

param
  Gender     = Utr Sex | Neutr ;
  NounGender = NUtr Sex | NNeutr ;

oper
  utrum : Gender = Utr Masc ;  --- where it doesn't matter
  neutrum : Gender = Neutr ;

oper
  genNoun = \s -> case s of {NUtr x => Utr x ; NNeutr => Neutr} ;
  sexNoun _ = NoMasc ;
  gen2nounGen = \s -> case s of {Utr x => NUtr x ; Neutr => NNeutr} ;

param
  AdjFormPos = Strong GenNum | Weak ;

  VFin = 
   Pres Mode Voice
 | Pret Mode Voice
 | Imper ;         --- no passive
 
  VInf =
   Inf Voice
 | Supin Voice
 | PtPret Case ;  ---- number and gender

}
