concrete ConjunctionLat of Conjunction = 
  CatLat ** open ResLat, StructuralLat, Coordination, Prelude in {
--
--  flags optimize=all_subs ;
--
  lin
--
    ConjS = conjunctDistrSS ;
--
    ConjAdv = conjunctDistrSS ;
--
--    ConjNP conj ss = conjunctDistrTable Case conj ss ** {
--      a = conjAgr (agrP3 conj.n) ss.a
--      } ;
--
    ConjAP conj ss = conjunctDistrTable Agr conj ss ;
--
--{---b
--
--    ConjS = conjunctSS ;
--    DConjS = conjunctDistrSS ;
--
--    ConjAdv = conjunctSS ;
--    DConjAdv = conjunctDistrSS ;
--
--    ConjNP conj ss = conjunctTable Case conj ss ** {
--      a = conjAgr (agrP3 conj.n) ss.a 
--      } ;
--    DConjNP conj ss = conjunctDistrTable Case conj ss ** {
--      a = conjAgr (agrP3 conj.n) ss.a
--      } ;
--
--    ConjAP conj ss = conjunctTable Agr conj ss ;
--
--    DConjAP conj ss = conjunctDistrTable Agr conj ss ** {
--      isPre = ss.isPre
--      } ;
---}
--
---- These fun's are generated from the list cat's.
--
--    BaseS = twoSS ;
--    ConsS = consrSS comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS "et" ;
--    BaseNP x y = twoTable Case x y ** {a = conjAgr x.a y.a} ;
--    ConsNP xs x = consrTable Case comma xs x ** {a = conjAgr xs.a x.a} ;
    BaseAP x y = lin A ( twoTable Agr x y ) ;
    ConsAP xs x = lin A ( consrTable Agr and_Conj.s2 xs x );
--
  lincat
    [S] = {s1,s2 : Str} ;
    [Adv] = {s1,s2 : Str} ;
--    [NP] = {s1,s2 : Case => Str ; a : Agr} ;
    [AP] = {s1,s2 : Agr => Str } ;
--
}
