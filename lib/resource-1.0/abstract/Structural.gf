--1 GF Resource Grammar API for Structural Words
-- 
-- AR 21/11/2003 -- 30/11/2005
--
-- Here we have some words belonging to closed classes and appearing
-- in all languages we have considered.
-- Sometimes they are not really meaningful, e.g. $we_NP$ in Spanish
-- should be replaced by masculine and feminine variants.

abstract Structural = Cat ** {

  fun

-- This is an alphabetical list of structural words

  above_Prep : Prep ;
  after_Prep : Prep ;
--  all8mass_Det : Det ;
--  all_NDet : NDet ;
  all_Predet : Predet ; --
  almost_AdA : AdA ;    -- Adv
  almost_AdN : AdN ;    --
  although_Subj : Subj ;
  always_AdV : AdV ; --
  and_Conj : Conj ;
  because_Subj : Subj ;
  before_Prep : Prep ;
  behind_Prep : Prep ;
  between_Prep : Prep ;
  both7and_DConj : DConj ; -- ConjD
  but_PConj : PConj ; --
  by8agent_Prep : Prep ;
  by8means_Prep : Prep ;
  can8know_VV : VV ;
  can_VV : VV ;
  during_Prep : Prep ;
  either7or_DConj : DConj ; -- ConjD
  every_Det : Det ;
  everybody_NP : NP ;
  everything_NP : NP ;
  everywhere_Adv : Adv ;
  first_Ord : Ord ;
  from_Prep : Prep ;
  he_Pron : Pron ; -- NP
  here_Adv : Adv ; --
  here7to_Adv : Adv ;
  here7from_Adv : Adv ;
  how_IAdv : IAdv ;
  how8many_IDet : IDet ;
  i_Pron : Pron ; -- NP
  if_Subj : Subj ;
  in8front_Prep : Prep ;
  in_Prep : Prep ;
  it_Pron : Pron ;
  less_CAdv : CAdv ; --
  many_Det : Det ;
  more_CAdv : CAdv ; --
  most_Predet : Predet ; -- Det
--  most8many_Det : Det ;
  much_Det : Det ;
  must_VV : VV ;
  no_Phr : Phr ;
  on_Prep : Prep ;
  one_Quant : QuantSg ;
  only_Predet : Predet ; --
  or_Conj : Conj ;
  otherwise_PConj : PConj ;  -- AdC
  part_Prep : Prep ;
  please_Voc : Voc ;
  possess_Prep : Prep ;
  quite_Adv : AdA ;
  she_Pron : Pron ;
  so_AdA : AdA ; -- Adv
  someSg_Det : Det ; -- some_Det
  somePl_Det : Det ; -- NDet
  somebody_NP : NP ;
  something_NP : NP ;
  somewhere_Adv : Adv ;
  that_Quant : QuantSg ; -- Det
  that_NP : NP ;
  there_Adv : Adv ; --
  there7to_Adv : Adv ; --
  there7from_Adv : Adv ; --
  therefore_PConj : PConj ; -- AdC
  these_NP : NP ; --
  these_Quant : QuantPl ; -- NDet
--  they8fem_NP : NP ;
  they_Pron : Pron ; -- NP
  this_Quant : QuantSg ; -- NDet
  this_NP : NP ;
  those_NP : NP ; --
  those_Quant : QuantPl ; -- NDet
  thou_Pron : Pron ; -- NP
  through_Prep : Prep ;
  to_Prep : Prep ;
  too_AdA : AdA ;  -- Adv
  under_Prep : Prep ;
  very_AdA : AdA ; -- Adv
  want_VV : VV ;
  we_Pron : Pron ; -- NP
  whatPl_IP : IP ; -- many
  whatSg_IP : IP ; -- one
  when_IAdv : IAdv ;
  when_Subj : Subj ;
  where_IAdv : IAdv ;
  whichPl_IDet : IDet ; -- many
  whichSg_IDet : IDet ; -- one
  whoPl_IP : IP ;  -- many
  whoSg_IP : IP ;  -- one
  why_IAdv : IAdv ;
  with_Prep : Prep ;
  without_Prep : Prep ;
  ye_Pron : Pron ; -- NP
  yes_Phr : Phr ;
  you_Pron : Pron ; -- NP

}
