concrete KoeFre of Koe = {

flags coding=utf8 ;

param 
  Gen = Masc | Fem ;
  Num = Sg | Pl ;
  Per = P1 | P2 | P3 ;

oper 
  Agr : Type = {g : Gen ; n : Num ; p : Per} ;

  predA : Str -> {s : Agr => Str} = \adj -> 
    {s = \\a => copula a.n a.p ++ regA adj a.g a.n} ;

  copula : Num -> Per -> Str = \n,p -> case <n,p> of {
    <Sg,P1> => "suis" ;
    <Sg,P2> => "es" ;
    <Sg,P3> => "est" ;
    <Pl,P1> => "sommes" ;
    <Pl,P2> => "êtes" ;
    <Pl,P3> => "sont"
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

  Je    = {s = "je"    ; a = {g = Masc ; n = Sg ; p = P1}} ;
  Tu    = {s = "tu"    ; a = {g = Masc ; n = Sg ; p = P2}} ;
  Il    = {s = "il"    ; a = {g = Masc ; n = Sg ; p = P3}} ;
  Elle  = {s = "elle"  ; a = {g = Fem  ; n = Sg ; p = P3}} ;
  Nous  = {s = "nous"  ; a = {g = Masc ; n = Pl ; p = P1}} ;
  Vous  = {s = "vous"  ; a = {g = Masc ; n = Pl ; p = P2}} ;
  Ils   = {s = "ils"   ; a = {g = Masc ; n = Pl ; p = P3}} ;
  Elles = {s = "elles" ; a = {g = Fem  ; n = Pl ; p = P3}} ;

  Strong = predA "fort" ;

}
