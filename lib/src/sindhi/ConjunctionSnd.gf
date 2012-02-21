--concrete Conjunctionsnd of Conjunction = 
--  Catsndu ** open Ressnd, Coordination, Prelude in {

concrete ConjunctionSnd of Conjunction = 
  CatSnd ** open ResSnd, Coordination, Prelude in {


  flags optimize=all_subs ;

  lin

    ConjS  = conjunctDistrSS  ;

--    ConjAdv = conjunctDistrSS ;
    ConjAdv conj advs = conjunctDistrTable Gender conj advs ;

    ConjNP conj ss = conjunctDistrTable NPCase conj ss ** {
      a = conjAgr (agrP3 Masc conj.n) ss.a ;
      isPron = ss.isPron ;
      } ;

    ConjAP conj ss = conjunctDistrTable3 Number Gender Case conj ss ; 
    ConjRS conj rs = conjunctDistrTable Agr conj rs ** { c = rs.c};

---- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
--    BaseAdv = twoSS ;
    BaseAdv x y = twoTable Gender x y  ;
--    ConsAdv = consrSS comma ;
    ConsAdv xs x = consrTable Gender comma xs x ;
    BaseNP x y = twoTable NPCase x y ** {a = conjAgr x.a y.a ; isPron = andB x.isPron y.isPron} ;
    BaseRS x y = twoTable Agr x y ** {c = x.c};
    ConsNP xs x = consrTable NPCase comma xs x ** {a = conjAgr xs.a x.a ; isPron = andB xs.isPron x.isPron} ;
    ConsRS xs x = consrTable Agr comma xs x ** { c = xs.c};
    BaseAP x y = twoTable3 Number Gender Case x y ; -- ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable3 Number Gender Case comma xs x ;-- ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Gender => Str} ;
    [NP] = {s1,s2 : NPCase => Str ; a : Agr ; isPron : Bool} ;
    [AP] = {s1,s2 : Number => Gender => Case => Str} ;
    [RS] = {s1,s2 : Agr => Str ; c : Case};

}
