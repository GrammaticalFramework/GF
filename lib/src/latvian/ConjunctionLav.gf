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

  ConjRS conj ss = conjunctDistrTable Agreement conj ss ;

  ConjAP conj ss = conjunctDistrTable4 Definiteness Gender Number Case conj ss ;

  -- Conj -> [NP] -> NP
  -- e.g. "she or we"
  ConjNP conj ss = conjunctDistrTable Case conj ss ** {
    agr    = toAgr (fromAgr ss.agr).pers (conjNumber (fromAgr ss.agr).num conj.num) (fromAgr ss.agr).gend;
    pol    = Pos ;
    isRel  = False ;
    isPron = False
  } ;

  -- Conj -> [Adv] -> Adv
  -- e.g. "here or there"
  ConjAdv or xs = (conjunctDistrSS or xs) ** {isPron = False};

  -- These fun's are generated from the list cat's:
  BaseS = twoSS ;
  ConsS = consrSS comma ;
  BaseAdv = twoSS ;
  ConsAdv = consrSS comma ;

  BaseNP x y = twoTable Case x y ** { agr = conjAgr x.agr y.agr } ;
  ConsNP xs x = consrTable Case comma xs x ** { agr = conjAgr xs.agr x.agr } ;

  BaseAP x y = twoTable4 Definiteness Gender Number Case x y ;
  ConsAP xs x = consrTable4 Definiteness Gender Number Case comma xs x ;

  BaseRS x y = twoTable Agreement x y ;
  ConsRS xs x = consrTable Agreement comma xs x  ;

lincat

  [S]   = {s1, s2 : Str} ;
  [RS]  = {s1, s2 : Agreement => Str} ;
  [NP]  = {s1, s2 : Case => Str ; agr : Agreement} ;
  [AP]  = {s1, s2 : Definiteness => Gender => Number => Case => Str} ;
  [Adv] = {s1, s2 : Str} ;
  -- TODO: [AdV]{2}
  -- TODO: [IAdv]{2}
  -- TODO: [CN] {2}

}
