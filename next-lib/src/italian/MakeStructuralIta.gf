--# -path=.:../romance:../common:../abstract

resource MakeStructuralIta = open CatIta, ParadigmsIta, MorphoIta, Prelude in {

oper 
  mkConj : Str -> Str -> Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;
  mkSubj : Str -> Subj = \x -> 
    {s = x ; m = Indic ; lock_Subj = <>} ;
  mkSubjSubj : Str -> Subj = \x -> 
    {s = x ; m = Conjunct ; lock_Subj = <>} ;

  mkIQuant : Str -> IQuant = \s ->
    {s = \\_,_,c => prepCase c ++ s ; lock_IQuant = <>} ;

}
