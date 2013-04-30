-- AdverbMlt.gf: adverbial phrases
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete AdverbMlt of Adverb = CatMlt ** open ResMlt, Prelude in {

  lin

    -- A -> Adv ;                 -- warmly
    PositAdvAdj a = {
      s = "b'mod" ++ a.s ! APosit (GSg Masc)
      } ;

    -- CAdv -> A -> NP -> Adv ; -- more warmly than John
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! APosit (GSg Masc) ++ cadv.p ++ np.s ! npNom
      } ;

    -- CAdv -> A -> S  -> Adv ; -- more warmly than he runs
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! APosit (GSg Masc) ++ cadv.p ++ s.s
      } ;

    -- Prep -> NP -> Adv ;        -- in the house
    PrepNP prep np = {
      s = prepNP prep np
      };

    -- AdA -> Adv -> Adv ;             -- very quickly
    AdAdv = cc2 ;

    -- A -> AdA ;                 -- extremely
    PositAdAAdj a = {
      s = a.s ! APosit (GSg Masc) ++ "ħafna" ;
      } ;

    -- Subj -> S -> Adv ;              -- when she sleeps
    SubjS = cc2 ;

    -- CAdv -> AdN ;                  -- less (than five)
    AdnCAdv cadv = {
      s = cadv.s ++ cadv.p
      } ;

}
