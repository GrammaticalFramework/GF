concrete ConjunctionFin of Conjunction = 
  CatFin ** open ResFin, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS = conjunctDistrSS ;

    ConjAdv = conjunctDistrSS ;

    ConjNP conj ss = conjunctDistrTable NPForm conj ss ** {
      a = {n = conjNumber conj.n ss.a.n ; p = ss.a.p} ;
      isPron = False
      } ;

    ConjAP conj ss = conjunctDistrTable2 Bool AForm conj ss ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable NPForm x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable NPForm comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = twoTable2 Bool AForm x y ;
    ConsAP xs x = consrTable2 Bool AForm comma xs x ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPForm => Str ; a : Agr} ;
    [AP] = {s1,s2 : Bool => AForm => Str} ;

}
