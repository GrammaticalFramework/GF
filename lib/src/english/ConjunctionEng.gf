concrete ConjunctionEng of Conjunction = 
  CatEng ** open ResEng, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS = conjunctDistrSS ;

    ConjAdv = conjunctDistrSS ;

    ConjNP conj ss = conjunctDistrTable NPCase conj ss ** {
      a = conjAgr (agrP3 conj.n) ss.a
      } ;

    ConjAP conj ss = conjunctDistrTable Agr conj ss ** {
      isPre = ss.isPre
      } ;

    ConjRS conj ss = conjunctDistrTable Agr conj ss ** {
      c = ss.c
      } ;

    ConjIAdv = conjunctDistrSS ;   

    ConjCN co ns = conjunctDistrTable2 Number Case co ns ** {g = Neutr} ; --- gender?

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = twoTable NPCase x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable NPCase comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = twoTable Agr x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable Agr comma xs x ** {isPre = andB xs.isPre x.isPre} ;
    BaseRS x y = twoTable Agr x y ** {c = y.c} ;
    ConsRS xs x = consrTable Agr comma xs x ** {c = xs.c} ;
    BaseIAdv = twoSS ;
    ConsIAdv = consrSS comma ;
    BaseCN = twoTable2 Number Case ;
    ConsCN = consrTable2 Number Case comma ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [IAdv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPCase => Str ; a : Agr} ;
    [AP] = {s1,s2 : Agr => Str ; isPre : Bool} ;
    [RS] = {s1,s2 : Agr => Str ; c : NPCase} ;
    [CN] = {s1,s2 : Number => Case => Str} ;

}
