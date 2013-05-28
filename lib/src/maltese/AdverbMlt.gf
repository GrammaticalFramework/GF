-- AdverbMlt.gf: adverbial phrases
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete AdverbMlt of Adverb = CatMlt ** open ResMlt, Prelude in {

  lin

    -- A -> Adv
    -- warmly
    PositAdvAdj a = {
      s = "b'mod" ++ a.s ! APosit (GSg Masc) ;
      joinsVerb = False ;
      a = agrP3 Sg Masc ; -- ignored when joinsVerb = False
      } ;

    -- CAdv -> A -> NP -> Adv
    -- more warmly than John
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! APosit (GSg Masc) ++ cadv.p ++ np.s ! npNom ;
      joinsVerb = False ;
      a = np.a ; -- ignored when joinsVerb = False
      } ;

    -- CAdv -> A -> S  -> Adv
    -- more warmly than he runs
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! APosit (GSg Masc) ++ cadv.p ++ s.s ;
      joinsVerb = False ;
      a = agrP3 Sg Masc ; -- ignored when joinsVerb = False
      } ;

    -- Prep -> NP -> Adv
    -- in the house
    PrepNP prep np = {
      s = prepNP prep np ;
      joinsVerb = prep.joinsVerb ;
      a = np.a ;
      };

    -- AdA -> Adv -> Adv
    -- very quickly
    AdAdv a b = cc2 a b ** {
      joinsVerb = False ;
      a = agrP3 Sg Masc ; -- ignored when joinsVerb = False
      } ;

    -- A -> AdA
    -- extremely
    PositAdAAdj a = {
      s = a.s ! APosit (GSg Masc) ++ "ħafna" ;
      joinsVerb = False ;
      a = agrP3 Sg Masc ; -- ignored when joinsVerb = False
      } ;

    -- Subj -> S -> Adv
    -- when she sleeps
    SubjS s r = cc2 s r ** {
      joinsVerb = False ;
      a = agrP3 Sg Masc ; -- ignored when joinsVerb = False
      } ;

    -- CAdv -> AdN
    -- less (than five)
    AdnCAdv cadv = {
      s = cadv.s ++ cadv.p ;
      joinsVerb = False ;
      a = agrP3 Sg Masc ; -- ignored when joinsVerb = False
      } ;

}
