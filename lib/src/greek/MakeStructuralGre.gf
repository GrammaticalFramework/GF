resource MakeStructuralGre = open CatGre, ParadigmsGre, ResGre,  Prelude in {

 
 oper 
  
mkSubj : Str -> Subj = \x -> 
    {s = x ; m = Ind ; lock_Subj = <>} ;
mkConj : Str -> Str -> Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;


} 