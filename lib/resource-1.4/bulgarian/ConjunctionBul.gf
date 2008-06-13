concrete ConjunctionBul of Conjunction = 
  CatBul ** open ResBul, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS = conjunctDistrSS ;

    ConjAdv = conjunctDistrSS ;

    ConjNP conj ss = conjunctDistrTable Role conj ss ** {
      a = {gn = conjGenNum (gennum DMasc conj.n) ss.a.gn; p = ss.a.p}
      } ;

    ConjAP conj ss = {
      s   = \\aform => conj.s1++ ss.s1.s ! aform ++ conj.s2 ++ ss.s2.s ! aform;
      adv = conj.s1++ ss.s1.adv ++ conj.s2 ++ ss.s2.adv;
      isPre = ss.isPre
      } ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;

    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;

    BaseNP x y = twoTable Role x y ** {a = conjAgr x.a y.a} ;
    ConsNP xs x = consrTable Role comma xs x ** {a = conjAgr xs.a x.a} ;

    BaseAP x y =
      {s1 = {s=x.s; adv=x.adv};
       s2 = {s=y.s; adv=y.adv};
       isPre = andB x.isPre y.isPre} ; 
    
    ConsAP x xs =
      {s1    = {s   = \\aform => x.s ! aform ++ comma ++ xs.s1.s ! aform;
                adv = x.adv ++ comma ++ xs.s1.adv};
       s2    = xs.s2;
       isPre = andB x.isPre xs.isPre} ; 

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : Role => Str ; a : Agr} ;
    [AP] = {s1,s2 : {s : AForm => Str; adv : Str}; isPre : Bool} ;
}
