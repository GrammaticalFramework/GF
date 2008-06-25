concrete ConjunctionBul of Conjunction = 
  CatBul ** open ResBul, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS = conjunctSS ;
    DConjS = conjunctDistrSS ;

    ConjAdv = conjunctSS ;
    DConjAdv = conjunctDistrSS ;

    ConjNP conj ss = conjunctTable Role conj ss ** {
      a = {gn = conjGenNum (gennum DMasc conj.n) ss.a.gn; p = ss.a.p}
      } ;
    DConjNP conj ss = conjunctDistrTable Role conj ss ** {
      a = {gn = conjGenNum (gennum DMasc conj.n) ss.a.gn; p = ss.a.p}
      } ;

    ConjAP conj ss = conjunctTable AForm conj ss ** {
      isPre = ss.isPre
      } ;
    DConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre
      } ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;

    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;

    BaseNP x y = twoTable Role x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable Role comma xs x ** {a = conjAgr xs.a x.a} ;

    BaseAP x y = twoTable AForm x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AForm comma xs x ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : Role => Str ; a : Agr} ;
    [AP] = {s1,s2 : AForm => Str ; isPre : Bool} ;
}
