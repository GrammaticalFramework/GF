--# -path=.:../scandinavian:../common:../abstract

resource MakeStructuralSwe = open CatSwe, ParadigmsSwe, 
  (P=ParadigmsSwe), MorphoSwe, Prelude in {

oper 
  mkConj : Str -> Str -> P.Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;
  mkSubj : Str -> Subj = \x -> 
    {s = x ; lock_Subj = <>} ;
  mkIQuant : Str -> Str -> Str -> DetSpecies -> IQuant = \vilken,vilket,vilka,d ->
    {s = table (P.Number) 
           [table (P.Gender) [vilken;vilket] ; table (P.Gender) [vilka;vilka]] ; 
     det = d ; lock_IQuant = <>} ;

  dDefIndef : DetSpecies = DDef Indef ;
  ---- other DetSpecies

}
