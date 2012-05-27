incomplete concrete ConjunctionRomance of Conjunction = 
  CatRomance ** open CommonRomance, ResRomance, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS conj ss = conjunctDistrTable Mood conj ss ;

    ConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = heavyNP (conjunctDistrTable Case conj ss ** {
      a = conjAgr (Ag Masc conj.n P3) ss.a ;
      hasClit = False ; isNeg = ss.isNeg
      }) ;
    ConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre
      } ;
    ConjRS conj ss = conjunctDistrTable2 Mood Agr conj ss ** {
      c = ss.c
      } ;

    ConjIAdv = conjunctDistrSS ;

    ConjCN co ns = conjunctDistrTable Number co ns ** {g = ns.g} ;

-- These fun's are generated from the list cat's.

    BaseS = twoTable Mood ;
    ConsS = consrTable Mood comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = {
      s1 = \\c => (x.s ! c).ton ; 
      s2 = \\c => (y.s ! conjunctCase c).ton ; ----e (conjunctCase c) ; 
      a = conjAgr x.a y.a ; isNeg = orB x.isNeg y.isNeg
      } ;
    ConsNP x xs = {
      s1 = \\c => (x.s ! c).ton ++ comma ++ xs.s1 ! conjunctCase c ; ----e (conjunctCase c) ; 
      s2 = \\c => xs.s2 ! c ; ----e (conjunctCase c) ; 
      a = conjAgr x.a xs.a ; isNeg = orB x.isNeg xs.isNeg
      } ;
    BaseAP x y = twoTable AForm x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AForm comma xs x ** {isPre = andB xs.isPre x.isPre} ;
    BaseRS x y = twoTable2 Mood Agr x y ** {c = y.c} ;
    ConsRS xs x = consrTable2 Mood Agr comma xs x ** {c = xs.c} ;
    BaseIAdv = twoSS ;
    ConsIAdv = consrSS comma ;
    BaseCN x y = twoTable Number x y ** {g = conjGender x.g y.g} ;
    ConsCN x xs = consrTable Number comma x xs ** {g = conjGender x.g xs.g} ;

  lincat
    [S] = {s1,s2 : Mood => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [IAdv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : Case => Str ; a : Agr ; isNeg : Bool} ;
    [AP] = {s1,s2 : AForm  => Str ; isPre : Bool} ;
    [RS] = {s1,s2 : Mood => Agr => Str ; c : Case} ;
    [CN] = {s1,s2 : Number => Str ; g : Gender} ;

}
