concrete ConjunctionSlv of Conjunction = 
  CatSlv ** open ResSlv, Prelude in {

  lin
    ConjNP conj xs = {
      s = \\c => xs.s1 ! c ++ conj.s ++ xs.s2 ! c ;
      a = {g = xs.a.g; n = conjNumber conj.n xs.a.n; p = xs.a.p} ;
      isPron = False
    } ;
    ConjAP conj xs = {
      s = \\sp,g,c,n => xs.s1 ! sp ! g ! c ! n ++ conj.s ++ xs.s2 ! sp ! g ! c ! n
    } ;

-- These fun's are generated from the list cat's.

    BaseNP x y = {
      s1 = x.s ;
      s2 = y.s ;
      a  = conjAgr x.a y.a
    } ;
    ConsNP x xs = {
      s1 = \\c => x.s ! c ++ "," ++ xs.s1 ! c ;
      s2 = xs.s2 ;
      a  = conjAgr x.a xs.a
    } ;
    BaseAP x y  = { s1 = x.s; s2 = y.s } ;
    ConsAP x xs = {
      s1 = \\sp,g,c,n => x.s ! sp ! g ! c ! n ++ xs.s1 ! sp ! g ! c ! n ;
      s2 = xs.s2
    } ;

  lincat
    [NP] = {s1,s2 : Case => Str; a : Agr} ;
    [AP] = {s1,s2 : Species => AGender => Case => Number => Str} ;

}
