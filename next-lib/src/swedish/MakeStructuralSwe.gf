--# -path=.:../scandinavian:../common:../abstract

resource MakeStructuralSwe = open CatSwe, ParadigmsSwe, MorphoSwe, Prelude in {

oper 
  mkConj : Str -> Str -> Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;
  mkSubj : Str -> Subj = \x -> 
    {s = x ; lock_Subj = <>} ;

}
