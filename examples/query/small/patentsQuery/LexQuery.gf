interface LexQuery = open Syntax in {

oper
-- structural words
  about_Prep : Prep ;
  all_NP : NP ;
  also_AdV : AdV ;
  as_Prep : Prep ;
  at_Prep : Prep ;
  called_A : A ;
  give_V3 : V3 ;
  information_N : N ;
  other_A : A ;
  name_N : N ;

  mkName : Str -> NP ;

oper  
  mkRelation : Str -> {cn : CN ; prep : Prep} ;
  that_RP : RP ;

}