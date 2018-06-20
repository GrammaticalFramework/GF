concrete NounPor of Noun = CatPor ** NounRomance with
  (ResRomance = ResPor) ** open Prelude, PhonoPor in {

  lin
    -- not implemented for romance languages, maybe because it can't
    -- be done elegantly?
    CountNP det np = heavyNPpol np.isNeg
      {s = \\c => det.s ! np.a.g ! c ++ (np.s ! c).ton ;
       a = np.a ** {n = det.n} } ;

} ;
