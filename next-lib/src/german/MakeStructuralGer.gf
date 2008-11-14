--# -path=.:../common:../abstract

resource MakeStructuralGer = open CatGer, ParadigmsGer, MorphoGer, Prelude in {

oper 
  mkConj : Str -> Str -> Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;
  mkSubj : Str -> Subj = \x -> 
    {s = x ; lock_Subj = <>} ;

}
