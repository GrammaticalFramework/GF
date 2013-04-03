-- AdverbMlt.gf: adverbial phrases
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete AdverbMlt of Adverb = CatMlt ** open ResMlt, Prelude in {

-- AdN
-- Adv

  lin
    -- Prep -> NP -> Adv
    PrepNP prep np = {
      s = case <np.isDefn,prep.takesDet> of {
        <True,True>  => prep.s ! Definite ++ np.s ! CPrep ; -- FIT-TRIQ
        <True,False> => prep.s ! Definite ++ np.s ! Nom ;   -- FUQ IT-TRIQ
        <False,_>    => prep.s ! Indefinite ++ np.s ! Nom   -- FI TRIQ
        }
      } ;
}
