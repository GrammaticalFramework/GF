incomplete concrete ConjunctionScand of Conjunction = 
  CatScand ** open CommonScand, ResScand, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS conj ss =  conjunctTable Order conj ss ;
    DConjS conj ss = conjunctDistrTable Order conj ss ;

    ConjAdv conj ss = conjunctSS conj ss ;
    DConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = conjunctTable NPForm conj ss ** {
      a = {gn = conjGenNum (gennum utrum conj.n) ss.a.gn ; p = ss.a.p}
      } ;
    DConjNP conj ss = conjunctDistrTable NPForm conj ss ** {
      a = {gn = conjGenNum (gennum utrum conj.n) ss.a.gn ; p = ss.a.p}
      } ;

    ConjAP conj ss = conjunctTable AFormPos conj ss ** {
      isPre = ss.isPre
      } ;
    DConjAP conj ss = conjunctDistrTable AFormPos conj ss ** {
      isPre = ss.isPre
      } ;

-- These fun's are generated from the list cat's.

    BaseS = twoTable Order ;
    ConsS = consrTable Order comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable NPForm x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable NPForm comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = twoTable AFormPos x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AFormPos comma xs x ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Order => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPForm => Str ; a : Agr} ;
    [AP] = {s1,s2 : AFormPos => Str ; isPre : Bool} ;

}
