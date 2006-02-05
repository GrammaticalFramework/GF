concrete ConjunctionFin of Conjunction = 
  CatFin ** open ResFin, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS = conjunctSS ;
    DConjS = conjunctDistrSS ;

    ConjAdv = conjunctSS ;
    DConjAdv = conjunctDistrSS ;

    ConjNP conj ss = conjunctTable NPForm conj ss ** {
      a = {n = conjNumber conj.n ss.a.n ; p = ss.a.p} ;
      isPron = False
      } ;
    DConjNP conj ss = conjunctDistrTable NPForm conj ss ** {
      a = {n = conjNumber conj.n ss.a.n ; p = ss.a.p} ;
      isPron = False
      } ;

--    ConjAP conj ss = conjunctTable Agr conj ss ;
--    DConjAP conj ss = conjunctDistrTable Agr conj ss ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable NPForm x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable NPForm comma xs x ** {a = conjAgr xs.a x.a} ;
--    BaseAP x y = twoTable Agr x y ** {isPre = andB x.isPre y.isPre} ;
--    ConsAP xs x = consrTable Agr comma xs x ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPForm => Str ; a : Agr} ;
--    [AP] = {s1,s2 : Agr => Str ; isPre : Bool} ;

}
