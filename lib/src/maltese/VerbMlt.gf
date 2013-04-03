-- VerbMlt.gf: verb phrases
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

concrete VerbMlt of Verb = CatMlt ** open Prelude, ResMlt in {
  flags optimize=all_subs ;

  lin
    -- V -> VP ;
    UseV = predV ;

    -- V2 -> VPSlash
    SlashV2a = predV ;

    -- VPSlash -> NP -> VP
    ComplSlash vp np =
      case np.isPron of {
        -- Join pron to verb
        True => {
            s = \\vpf,ant,pol =>
              let bits = vp.s ! vpf ! ant ! pol in
              mkVParts (glue bits.stem (np.s ! CPrep)) bits.pol ;
            s2 = \\agr => [] ;
          } ;

        -- Insert obj to VP
        _ => insertObj (\\agr => np.s ! CPrep) vp
      } ;

    -- VP -> Adv -> VP
    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    -- AdV -> VP -> VP
    -- AdVVP adv vp = insertAdV adv.s vp ;

}
