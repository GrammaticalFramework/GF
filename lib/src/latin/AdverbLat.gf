concrete AdverbLat of Adverb = CatLat ** open ResLat, Prelude in
  {

  lin
--    PositAdvAdj a = {s = a.s ! AAdv} ;
--    ComparAdvAdj cadv a np = {
--      s = cadv.s ++ a.s ! AAdv ++ "than" ++ np.s ! Nom
--      } ;
--    ComparAdvAdjS cadv a s = {
--      s = cadv.s ++ a.s ! AAdv ++ "than" ++ s.s
--      } ;

--  PrepNP : Prep -> NP -> Adv ;        -- in the house
    PrepNP prep np = {s = prep.s ++ np.s ! prep.c } ;

--    AdAdv = cc2 ;

-- Subordinate clauses can function as adverbs.

--  SubjS  : Subj -> S -> Adv ;              -- when she sleeps
    SubjS = cc2 ;
    
-----b    AdvSC s = s ; --- this rule give stack overflow in ordinary parsing
--
--    AdnCAdv cadv = {s = cadv.s ++ "than"} ;
--
}
