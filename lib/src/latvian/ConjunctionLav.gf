--# -path=.:../abstract:../common:../prelude

concrete ConjunctionLav of Conjunction = CatLav ** open
  Coordination,
  ResLav,
  Prelude
  in {

flags
  optimize = all_subs ;
  coding = utf8 ;

lin

  ConjS = conjunctDistrSS ;

  ConjAdv = conjunctDistrSS ;

  ConjNP conj ss = conjunctDistrTable Case conj ss ** {
    a = toAgr (conjNumber (fromAgr ss.a).num conj.n) (fromAgr ss.a).pers (fromAgr ss.a).gend ;
    isNeg = False
  } ;

  ConjAP conj ss = conjunctDistrTable4 Definite Gender Number Case conj ss ;

  ConjRS conj ss = conjunctDistrTable Agr conj ss ;

  -- These fun's are generated from the list cat's:
  BaseS = twoSS ;
  ConsS = consrSS comma ;
  BaseAdv = twoSS ;
  ConsAdv = consrSS comma ;

  BaseNP x y = twoTable Case x y ** { a = conjAgr x.a y.a } ;
  ConsNP xs x = consrTable Case comma xs x ** { a = conjAgr xs.a x.a } ;

  BaseAP x y = twoTable4 Definite Gender Number Case x y ;
  ConsAP xs x = consrTable4 Definite Gender Number Case comma xs x ;

  BaseRS x y = twoTable Agr x y ;
  ConsRS xs x = consrTable Agr comma xs x  ;

lincat

  [S] = { s1, s2 : Str } ;
  [Adv] = { s1, s2 : Str } ;
  [NP] = { s1, s2 : Case => Str ; a : Agr } ;
  [AP] = { s1, s2 : Definite => Gender => Number => Case => Str } ;
  [RS] = { s1, s2 : Agr => Str } ;

}
