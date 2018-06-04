concrete NounPor of Noun = CatPor ** NounRomance with
  (ResRomance = ResPor) ** open Prelude, PhonoPor in {

  lin
    -- not implemented for romance languages, maybe because it can't
    -- be done elegantly?
    CountNP det np = heavyNPpol np.isNeg
      {s = \\c => det.s ! np.a.g ! c ++ elisDe ++ (np.s ! c).ton ;
       a = np.a ** {n = det.n} } ;

} ;
{--
      NounPhrase : Type = {
    s : Case => {c1,c2,comp,ton : Str} ;
    a : Agr ;
    hasClit : Bool ;
    isPol : Bool ; --- only needed for French complement agr
    isNeg : Bool --- needed for negative NP's such as "personne"
    } ;

    Det     = {
      s : Gender => Case => Str ;
      n : Number ;
      s2 : Str ;            -- -ci
      sp : Gender => Case => Str ;   -- substantival: mien, mienne
      isNeg : Bool -- negative element, e.g. aucun
      } ;

 Bool -> {s : Case => Str ; a : Agr} -> NounPhrase
--}