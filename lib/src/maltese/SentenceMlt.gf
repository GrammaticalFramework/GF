-- SentenceMlt.gf: clauses and sentences
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2012
-- Licensed under LGPL

--# -path=.:abstract:common:prelude

concrete SentenceMlt of Sentence = CatMlt ** open
  Prelude,
  ResMlt,
  ParamX,
  CommonX in {

  flags optimize=all_subs ;

  lin
    -- NP -> VP -> Cl
    -- John walks
    PredVP np vp = {
      s = \\tense,ant,pol => (s ++ v ++ o)
        where {
          s = case np.isPron of {
            True => [] ; -- omit subject pronouns
            False => np.s ! Nom
            } ;
          v = joinVParts (vp.s ! VPIndicat tense (toVAgr np.a) ! ant ! pol) ;
          o = vp.s2 ! np.a ;
          -- s = if_then_Str np.isPron [] (np.s ! Nom) ; -- omit subject pronouns
          -- v = joinVParts (vp.s ! VPIndicat tense (toVAgr np.a) ! ant ! pol) ;
          -- o = vp.s2 ! np.a ;
        } ;
      } ;

-- Cl
-- Imp
-- QS
-- RS
-- S
-- SC
-- SSlash

}
