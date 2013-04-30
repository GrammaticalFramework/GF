-- ConjunctionMlt.gf: co-ordination
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete ConjunctionMlt of Conjunction =
  CatMlt ** open ResMlt, Coordination, Prelude in {

  lin
    -- Conj -> [S] -> S     -- "he walks and she runs"
    ConjS = conjunctDistrSS ;

    -- Conj -> [Adv] -> Adv   -- "here or there"
    ConjAdv = conjunctDistrSS ;

    -- Conj -> [IAdv] -> IAdv -- "where and with whom"
    ConjIAdv = conjunctDistrSS ;

    -- Conj -> [NP] -> NP     -- "either her or me"
    ConjNP conj ss = {
      s = \\npcase => conj.s1 ++ ss.np1.s ! npcase ++ conj.s2 ++ ss.np2.s ! npcase ;
      a = ss.np2.a ;
      isPron = andB ss.np1.isPron ss.np2.isPron ;
      isDefn = andB ss.np1.isDefn ss.np2.isDefn ;
      } ;

    -- Conj -> [AP] -> AP     -- "cold and warm"
    ConjAP conj ss = conjunctDistrTable GenNum conj ss ** {
      isPre = ss.isPre
      } ;

    -- Conj -> [RS] -> RS     -- "who walks and whose mother runs"
    ConjRS conj ss = conjunctDistrTable Agr conj ss ** {
      c = ss.c
      } ;

    -- Conj -> [CN] -> CN     -- "man and woman"
    ConjCN conj ss = {
      s = \\num => conj.s1 ++ ss.n1.s ! num ++ conj.s2 ++ ss.n2.s ! num ;
      g = conjGender ss.n1.g ss.n2.g ;
      hasColl = False ;
      hasDual = False ;
      takesPron = False ;
      } ;

-- These fun's are generated from the list cat's.

    BaseS = twoSS ;
    ConsS = consrSS comma ;

    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;

    BaseIAdv = twoSS ;
    ConsIAdv = consrSS comma ;

    BaseNP x y = { np1 = x ; np2 = y } ;
    ConsNP xs x = {
      np1 = {
        s = \\npcase => x.np1.s ! npcase ++ comma ++ x.np2.s ! npcase ;
        a = conjAgr x.np1.a x.np2.a ;
        isPron = andB x.np1.isPron x.np2.isPron ;
        isDefn = andB x.np1.isDefn x.np2.isDefn ;
        } ;
      np2 = xs ;
      } ;

    BaseAP x y = twoTable GenNum x y ** {isPre = andB x.isPre y.isPre} ;
    ConsAP xs x = consrTable GenNum comma xs x ** {isPre = andB xs.isPre x.isPre} ;

    BaseRS x y = twoTable Agr x y ** {c = y.c} ;
    ConsRS xs x = consrTable Agr comma xs x ** {c = xs.c} ;

    BaseCN x y = { n1 = x ; n2 = y } ;
    ConsCN xs x = {
      n1 = {
        s = \\num => x.n1.s ! num ++ comma ++ x.n2.s ! num ;
        g = x.n2.g ;
        hasColl = False ;
        hasDual = False ;
        takesPron = False ;
        } ;
      n2 = xs ;
      } ;

  lincat
    -- These basically match the lincat's in CommonX/CatMlt
    [S]    = {s1,s2 : Str} ;
    [Adv]  = {s1,s2 : Str} ;
    [IAdv] = {s1,s2 : Str} ;
    [NP]   = {np1,np2 : NounPhrase} ;
    [AP]   = {s1,s2 : GenNum => Str ; isPre : Bool} ;
    [RS]   = {s1,s2 : Agr => Str} ;
    [CN]   = {n1,n2 : Noun} ;

}
