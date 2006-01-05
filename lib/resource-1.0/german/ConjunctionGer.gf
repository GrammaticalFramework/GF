concrete ConjunctionGer of Conjunction = 
  CatGer ** open ResGer, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS conj ss =  conjunctTable Order conj ss ;
    DConjS conj ss = conjunctDistrTable Order conj ss ;

    ConjAdv conj ss = conjunctSS conj ss ;
    DConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = conjunctTable Case conj ss ** {
      a = {n = conjNumber conj.n ss.a.n ; p = ss.a.p}
      } ;
    DConjNP conj ss = conjunctDistrTable Case conj ss ** {
      a = {n = conjNumber conj.n ss.a.n ; p = ss.a.p}
      } ;

    ConjAP conj ss = conjunctTable AForm conj ss ** {
      isPre = ss.isPre
      } ;
    DConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre
      } ;

-- These fun's are generated from the list cat's.

    BaseS = twoTable Order ;
    ConsS = consrTable Order comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable Case x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable Case comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = twoTable AForm x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AForm comma xs x ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Order => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : Case => Str ; a : Agr} ;
    [AP] = {s1,s2 : AForm => Str ; isPre : Bool} ;

}
