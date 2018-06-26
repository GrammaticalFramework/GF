concrete ConjunctionEng of Conjunction = 
  CatEng ** open ResEng, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjS = conjunctDistrSS ;

    ConjAdv = conjunctDistrSS ;
    ConjAdV = conjunctDistrSS ;

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

    ConjDet c xs = let cxs = (conjunctDistrSS c xs).s in {s = cxs ; sp = \\_,_,_ => cxs ++ "one" ; hasNum = False ; n = xs.n} ;   

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    BaseAdV = twoSS ;
    ConsAdV = consrSS comma ;
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
    BaseDAP x y = twoSS x y ** {n = y.n} ; --- the last number decides: one big and two small cars
    ConsDAP x xs = consrSS comma x xs ** {n = xs.n} ;

  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
    [AdV] = {s1,s2 : Str} ;
    [IAdv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : NPCase => Str ; a : Agr} ;
    [AP] = {s1,s2 : Agr => Str ; isPre : Bool} ;
    [RS] = {s1,s2 : Agr => Str ; c : NPCase} ;
    [CN] = {s1,s2 : Number => Case => Str} ;
    [DAP] = {s1,s2 : Str ; n : Number} ;


}
