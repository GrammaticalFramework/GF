interface LexQuery = open Syntax in {

oper
  located_A : A ;
  giveMe : NP -> VP ;
  know_V2 : V2 ;

-- structural words
  about_Prep : Prep ;
  all_NP : NP ;
  also_AdV : AdV ;
  also_AdA : AdA ;
  as_Prep : Prep ;
  at_Prep : Prep ;
  that_RP : RP ;

  called_A : A ;

  participlePropCN : Prop -> CN -> CN ;

  vpAP : VP -> AP ;

  information_N : N ;
  other_A : A ;
  otherwise_AdV : AdV ;
  otherwise_AdA : AdA ;
  what_IQuant : IQuant ;

-- lincats
  Fun = {cn : CN ; prep : Prep} ;
  Prop = {ap : AP ; vp : VP} ;
  Rel = {ap : AP ; vp : VP ; prep : Prep} ;



}
