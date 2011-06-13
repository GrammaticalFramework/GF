
concrete ConjunctionPes of Conjunction = 
  CatPes ** open ResPes, Coordination, Prelude in {


  flags optimize=all_subs ;

  lin

    ConjS  = conjunctDistrSS  ;

    ConjAdv = conjunctDistrSS ;
--    ConjAdv conj advs = conjunctDistrTable Gender conj advs ;

    ConjNP conj ss = conjunctDistrTable NPCase conj ss ** {
      a = conjAgrPes (agrPesP3 conj.n) ss.a ;
      animacy = ss.animacy ;
      } ;

    ConjAP conj ss = conjunctDistrTable Ezafa conj ss ** {adv = ss.adv}; 
    ConjRS conj rs = conjunctDistrTable AgrPes conj rs ** { c = rs.c};

---- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
--    BaseAdv x y = twoTable Gender x y  ;
    ConsAdv = consrSS comma ;
--    ConsAdv xs x = consrTable Gender comma xs x ;
    BaseNP x y = twoTable NPCase x y ** {a = conjAgrPes x.a y.a ; animacy = y.animacy } ; -- check animacy 
    BaseRS x y = twoTable AgrPes x y ** {c = x.c};
    ConsNP xs x = consrTable NPCase comma xs x ** {a = conjAgrPes xs.a x.a ; animacy = xs.animacy } ; --  InaandB xs.animacy x.animacy} ;
    ConsRS xs x = consrTable AgrPes comma xs x ** { c = xs.c};
--    BaseAP x y = twoTable3 Number Gender Case x y ; -- ** {isPre = andB x.isPre y.isPre} ;
    BaseAP x y = twoTable Ezafa x y ** {adv = x.adv};
    ConsAP xs x = consrTable Ezafa comma xs x ** {adv = x.adv}; -- Table3 Number Gender Case comma xs x ;-- ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPCase => Str ; a : AgrPes ; animacy : Animacy } ;
    [AP] = {s1,s2 :  Ezafa => Str ; adv : Str} ;
    [RS] = {s1,s2 : AgrPes => Str };

}
