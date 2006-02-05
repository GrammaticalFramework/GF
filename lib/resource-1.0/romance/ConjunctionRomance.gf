incomplete concrete ConjunctionRomance of Conjunction = 
  CatRomance ** open CommonRomance, ResRomance, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS conj ss =  conjunctTable Mood conj ss ;
    DConjS conj ss = conjunctDistrTable Mood conj ss ;

    ConjAdv conj ss = conjunctSS conj ss ;
    DConjAdv conj ss = conjunctDistrSS conj ss ;

    ConjNP conj ss = conjunctTable NPForm conj ss ** {
      a = {g = ss.a.g ; n = conjNumber conj.n ss.a.n ; p = ss.a.p} ; 
      c = Clit0
      } ;
    DConjNP conj ss = conjunctDistrTable NPForm conj ss ** {
      a = {g = ss.a.g ; n = conjNumber conj.n ss.a.n ; p = ss.a.p} ;
      c = Clit0
      } ;

    ConjAP conj ss = conjunctTable AForm conj ss ** {
      isPre = ss.isPre
      } ;
    DConjAP conj ss = conjunctDistrTable AForm conj ss ** {
      isPre = ss.isPre
      } ;

-- These fun's are generated from the list cat's.

    BaseS = twoTable Mood ;
    ConsS = consrTable Mood comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseNP x y = {
      s1 = \\c => x.s ! c ; 
      s2 = \\c => y.s ! (conjunctCase c) ; 
      a = conjAgr x.a y.a
      } ;
    ConsNP x xs = {
      s1 = \\c => x.s ! c ++ comma ++ xs.s1 ! (conjunctCase c) ; 
      s2 = \\c => xs.s2 ! (conjunctCase c) ; 
      a = conjAgr x.a xs.a
      } ;
    BaseAP x y = twoTable AForm x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable AForm comma xs x ** {isPre = andB xs.isPre x.isPre} ;

  lincat
    [S] = {s1,s2 : Mood => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPForm => Str ; a : Agr} ;
    [AP] = {s1,s2 : AForm  => Str ; isPre : Bool} ;

}
