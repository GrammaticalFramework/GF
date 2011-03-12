concrete ConjunctionAfr of Conjunction = 
  CatAfr ** open ResAfr, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS conj ss = conjunctDistrTable Order conj ss ;

    ConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = heavyNP (conjunctDistrTable NPCase conj ss ** {
      a = {g = Neutr ; n = conjNumber conj.n ss.a.n ; p = ss.a.p}
      }) ;

    ConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre
      } ;

    ConjRS conj ss = conjunctDistrTable2 Gender Number conj ss ;

-- These fun's are generated from the list cat's.

    BaseS = twoTable Order ;
    ConsS = consrTable Order comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable NPCase x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable NPCase comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = twoTable AForm x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AForm comma xs x ** {isPre = andB xs.isPre x.isPre} ;
    BaseRS x y = twoTable2 Gender Number x y ** {c = y.c} ;
    ConsRS xs x = consrTable2 Gender Number comma xs x ;

  lincat
    [S] = {s1,s2 : Order => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPCase => Str ; a : Agr} ;
    [AP] = {s1,s2 : AForm => Str ; isPre : Bool} ;
    [RS] = {s1,s2 : Gender => Number => Str} ;

}
