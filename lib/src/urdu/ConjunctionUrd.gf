--concrete ConjunctionUrd of Conjunction = 
--  CatUrdu ** open ResUrdu, Coordination, Prelude in {

concrete ConjunctionUrd of Conjunction = 
  CatUrd ** open ResUrd, Coordination, Prelude in {


  flags optimize=all_subs ;

  lin

    ConjS  = conjunctDistrSS  ;

    ConjAdv = conjunctDistrSS ;

    ConjNP conj ss = conjunctDistrTable NPCase conj ss ** {
      a = conjAgr (agrP3 Masc conj.n) ss.a
      } ;

    ConjAP conj ss = conjunctDistrTable4 Number Gender Case Degree conj ss ; -- ** {
--      isPre = ss.isPre
--      } ;

---- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable NPCase x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable NPCase comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = twoTable4 Number Gender Case Degree x y ; -- ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable4 Number Gender Case Degree comma xs x ;-- ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPCase => Str ; a : Agr} ;
    [AP] = {s1,s2 : Number => Gender => Case => Degree => Str} ;

}
