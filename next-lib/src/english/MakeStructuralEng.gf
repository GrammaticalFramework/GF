--# -path=.:../common:../abstract

resource MakeStructuralEng = open CatEng, ParadigmsEng, ResEng, MorphoEng, Prelude in {

oper 
  mkConj : Str -> Str -> Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;
  mkSubj : Str -> Subj = \x -> 
    {s = x ; lock_Subj = <>} ;
  mkNP : Str -> Number -> NP = \s,n ->
    regNP s n ** {lock_NP = <>} ;
  mkIDet : Str -> Number -> IDet = \s,n ->
    {s = s ; n = n ; lock_IDet = <>} ;

}
