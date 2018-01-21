--# -path=.:../common:../abstract

resource MakeStructuralGer = open CatGer, (P = ParadigmsGer), MorphoGer, Prelude in {

oper 
  mkConj : Str -> Str -> Number -> Conj = \x,y,n -> 
    {s1 = x ; s2 = y ; n = n ; lock_Conj = <>} ;
  mkSubj : Str -> Subj = \x -> 
    {s = x ; lock_Subj = <>} ;
  mkIQuant : Str -> IQuant = \s ->
    {s = \\_,_,_ => s ; lock_IQuant = <>} ;

  mkPredet = overload {
    mkPredet : A -> Predet = \a ->
      lin Predet {
        s = appAdj a ; 
        c = noCase ;
        a = PAgNone
        } ;     
    mkPredet : A -> Str -> PCase -> Bool -> Number -> Predet = \a,p,c,b,n ->
      lin Predet {
        s = appAdj a ; 
        c = {p = p ; k = PredCase c} ; 
        a = case b of {True => PAg n ; _ => PAgNone}
        }      
      } ;

 -- e.g. das selbe
 mmkQuant : Quant -> A -> Quant = \q,a -> q ** {
   s,sp = \\x,n,g,c => q.s ! x ! n ! g ! c ++ a.s ! Posit ! agrAdj g q.a n ((prepC c).c)   
   } ;
 -- e.g. derjenige
 mmbQuant : Quant -> A -> Quant = \q,a -> q ** {
   s,sp = \\x,n,g,c => q.s ! x ! n ! g ! c + a.s ! Posit ! agrAdj g q.a n ((prepC c).c)   
   } ;

}
