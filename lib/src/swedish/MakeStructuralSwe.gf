--# -path=.:../scandinavian:../common:../abstract

resource MakeStructuralSwe = open CatSwe, 
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

  mkPredet = overload {
    mkPredet : Str -> Str -> Str -> Predet = \a,b,c ->
      lin Predet {
        s = detForms a b c ; 
        p = [] ;
        a = PNoAg
        } ;     
    mkPredet : Str -> Str -> Str -> Number -> Predet = \a,b,p,n ->
      lin Predet {
        s = table {Utr => \\_ => a ; _ => \\_ => b} ; 
        p = p ;
        a = PAg n ;
        }      
      } ;
}
