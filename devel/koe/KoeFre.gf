concrete KoeFre of Koe = {

param 
  Gen = Masc | Fem ;
  Num = Sg | Pl ;

oper 
  Agr : Type = {g : Gen ; n : Num} ;

  predA : Str -> {s : Agr => Str} = \adj -> 
    {s = \\a => copula a.n ++ regA adj a.g a.n} ;

  copula : Num -> Str = \n -> case n of {
    Sg => "est" ;
    Pl => "sont"
  } ;

  regA : Str -> Gen -> Num -> Str = \s,g,n -> case <g,n> of {
    <Masc,Sg> => s ;
    <Masc,Pl> => s + "s" ;
    <Fem,Sg>  => s + "e";
    <Fem,Pl>  => s + "es"
  } ;

lincat
  NP = {s : Str ; a : Agr} ;
  VP = {s : Agr => Str} ;

lin
  Pred np vp = {s = np.s ++ vp.s ! np.a} ;

  He = {s = "il" ; a = {g = Masc ; n = Sg}} ;
  She = {s = "elle" ; a = {g = Fem ; n = Sg}} ;

  Strong = predA "fort" ;

}
