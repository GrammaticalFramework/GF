--1 GF Resource Grammar API for Structural Words
-- 
-- AR 21/11/2003
--
-- Here we have some words belonging to closed classes and appearing
-- in all languages we have considered.
-- Sometimes they are not really meaningful, e.g. $we_NP$ in Spanish
-- should be replaced by masculine and feminine variants.

abstract Structural = Categories, Numerals ** {

  fun

-- First mount the numerals.

  UseNumeral : Numeral-> Num ;

-- Then an alphabetical list of structural words

  above_Prep : Prep ;
  after_Prep : Prep ;
  all8mass_Det : Det ;
  all_NDet : NDet ;
  almost_Adv : AdA ;
  although_Subj : Subj ;
  and_Conj : Conj ;
  because_Subj : Subj ;
  before_Prep : Prep ;
  behind_Prep : Prep ;
  between_Prep : Prep ;
  both_AndConjD : ConjD ;
  by8agent_Prep : Prep ;
  by8means_Prep : Prep ;
  can8know_VV : VV ;
  can_VV : VV ;
  during_Prep : Prep ;
  either8or_ConjD : ConjD ;
  every_Det : Det ;
  everybody_NP : NP ;
  everything_NP : NP ;
  everywhere_Adv : Adv ;
  from_Prep : Prep ;
  he_NP : NP ;
  how_IAdv : IAdv ;
  how8many_IDet : IDet ;
  i_NP : NP ;
  if_Subj : Subj ;
  in8front_Prep : Prep ;
  in_Prep : Prep ;
  it_NP : NP ;
  many_Det : Det ;
  most_Det : Det ;
  most8many_Det : Det ;
  much_Det : Det ;
  must_VV : VV ;
  no_Phr : Phr ;
  on_Prep : Prep ;
  or_Conj : Conj ;
  otherwise_Adv : AdC ;
  part_Prep : Prep ;
  possess_Prep : Prep ;
  quite_Adv : AdA ;
  she_NP : NP ;
  so_Adv : AdA ;
  some_Det : Det ;
  some_NDet : NDet ;
  somebody_NP : NP ;
  something_NP : NP ;
  somewhere_Adv : Adv ;
  that_Det : Det ;
  that_NP : NP ;
  therefore_Adv : AdC ;
  these_NDet : NDet ;
  they8fem_NP : NP ;
  they_NP : NP ;
  this_Det : Det ;
  this_NP : NP ;
  those_NDet : NDet ;
  thou_NP : NP ;
  through_Prep : Prep ;
  to_Prep : Prep ;
  too_Adv : AdA ;
  under_Prep : Prep ;
  very_Adv : AdA ;
  want_VV : VV ;
  we_NP : NP ;
  what8many_IP : IP ;
  what8one_IP : IP ;
  when_IAdv : IAdv ;
  when_Subj : Subj ;
  where_IAdv : IAdv ;
  which8many_IDet : IDet ;
  which8one_IDet : IDet ;
  who8many_IP : IP ;
  who8one_IP : IP ;
  why_IAdv : IAdv ;
  with_Prep : Prep ;
  without_Prep : Prep ;
  ye_NP : NP ;
  yes_Phr : Phr ;
  you_NP : NP ;

}