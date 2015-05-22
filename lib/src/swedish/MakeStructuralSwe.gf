--# -path=.:../scandinavian:../common:../abstract

resource MakeStructuralSwe = open CatSwe, 
  (P=ParadigmsSwe), MorphoSwe, Prelude in {

oper 
  mkConj = overload {
    mkConj : Str -> Conj 
      = \s -> lin Conj {s1 = [] ; s2 = s ; n = P.plural ; isDiscont = False} ;
    mkConj : Str -> Str -> P.Number -> Conj 
      = \x,y,n -> lin Conj {s1 = x ; s2 = y ; n = n ; isDiscont = False} ;
    mkConj : Str -> Str -> P.Number -> Bool -> Conj 
      = \x,y,n,d -> lin Conj {s1 = x ; s2 = y ; n = n ; isDiscont = d} ;
    } ;

  mkSubj : Str -> Subj 
      = \x -> {s = x ; lock_Subj = <>} ;

  mkIQuant : Str -> Str -> Str -> DetSpecies -> IQuant = \vilken,vilket,vilka,d ->
    {s = table (P.Number) 
           [table (P.Gender) [vilken;vilket] ; table (P.Gender) [vilka;vilka]] ; 
     det = d ; lock_IQuant = <>} ;

  mkQuant : Str -> Str -> Str -> Quant = \naagon,naagot,naagra ->
    lin Quant {s,sp = table {
       Sg => \\_,_ => table {Utr => naagon ; Neutr => naagot} ; 
       Pl => \\_,_,_ => naagra
       } ;
     det = DIndef
    } ; 

  mkDet = overload {
    mkDet : Str -> Det 
      = \s -> lin Det {s,sp = \\_,_ => s ; n = P.singular ; det = DDef Indef} ;
    mkDet : Str -> P.Number -> Det 
      = \s,n -> lin Det {s,sp = \\_,_ => s ; n = n ; det = DDef Indef} ;
    mkDet : Str -> Str -> P.Number -> Det 
      = \ingen,inget,n -> lin Det {s,sp = \\_ => table NGender [ingen ; inget] ; n = n ; det = DDef Indef} ;
    } ;

  mkDefDet : Str -> Str -> P.Number -> Det = ---- \s,t,n -> mkDet s t n ** {det = DDef Def} ;
    \ingen,inget,n -> lin Det {s,sp = \\_ => table NGender [ingen ; inget] ; n = n ; det = DDef Def} ;
    
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

    mkNum : Str -> Num = \s -> lin Num {s = table {_ => s} ; isDet = True ; n = Pl} ;

}
