concrete ConjunctionGer of Conjunction = 
  CatGer ** open ResGer, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS conj ss = conjunctDistrTable Order conj ss ;

    ConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = heavyNP (conjunctDistrTable PCase conj ss ** {
      a = Ag Fem (conjNumber conj.n (numberAgr ss.a)) (personAgr ss.a)
      }) ;

    ConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre
      } ;

    ConjRS conj ss = conjunctDistrTable GenNum conj ss ** {
      c = ss.c
      } ;


-- These fun's are generated from the list cat's.

    BaseS = twoTable Order ;
    ConsS = consrTable Order comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable PCase x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable PCase comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = twoTable AForm x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AForm comma xs x ** {isPre = andB xs.isPre x.isPre} ;
    BaseRS x y = twoTable GenNum x y ** {c = y.c} ;
    ConsRS xs x = consrTable GenNum comma xs x ** {c = xs.c} ;

  lincat
    [S] = {s1,s2 : Order => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : PCase => Str ; a : Agr} ;
    [AP] = {s1,s2 : AForm => Str ; isPre : Bool} ;
    [RS] = {s1,s2 : GenNum => Str ; c : Case} ;

}
