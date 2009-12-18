interface LexLogic = open Syntax, Prelude in {

oper
  case_N : N ; -- it is not the case that
  such_A : A ; -- number such that 
  by_Prep : Prep ; -- by Thm 5
  all_Det : Det ; -- the article with "all"
  axiom_N : N ;
  theorem_N : N ;
  definition_N : N ;
  define_V3 : V3 ;  -- we define a as b
  define_V2V : V2V ;  -- we define x to be f if p
  iff_Subj : Subj ; -- if and only if
oper
  indef : Bool -> CN -> NP = \b -> case b of {
    True => mkNP aPl_Det ;
    False => mkNP aSg_Det
    } ;

}
