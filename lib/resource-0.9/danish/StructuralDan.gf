--# -path=.:../scandinavian:../abstract:../../prelude

--1 The Top-Level Swedish Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2004
--
concrete StructuralDan of Structural = 
  CategoriesDan, NumeralsDan ** open Prelude, MorphoDan, SyntaxDan in {

  flags optimize=values ;

  lin

  UseNumeral i = {
    s = \\g => table {Nom => i.s ! g ; Gen => i.s ! g ++ "s"} ;  ---
    n = i.n
    } ;

  above_Prep = ss "ovenfor" ;
  after_Prep = ss "efter" ;
  by8agent_Prep = ss "af" ;
  all8mass_Det = mkDeterminerSgGender2 "all" "alt" IndefP ;
  all_NDet = mkDeterminerPl "alle" IndefP ;
  almost_Adv = ss "næsten" ;
  although_Subj = ss ["selv om"] ;
  and_Conj = ss "og" ** {n = Pl} ;
  because_Subj = ss ["fordi"] ;
  before_Prep = ss "før" ;
  behind_Prep = ss "bag" ;
  between_Prep = ss "mellem" ;
  both_AndConjD = sd2 "både" "og" ** {n = Pl} ;
  by8means_Prep = ss "med" ;
  can8know_VV = mkVerb "kunne" "kan" nonExist "kunne" "kunnet" nonExist **
    {s1 = [] ; isAux = True} ;
  can_VV = mkVerb "kunne" "kan" nonExist "kunne" "kunnet" nonExist **
    {s1 = [] ; isAux = True} ;
  during_Prep = ss "under" ;
  either8or_ConjD = sd2 "enten" "eller" ** {n = Sg} ;
  everybody_NP = let alla = table {Nom => "alle" ; Gen => "alles"} in
                 {s = \\c => alla ! npCase c ; g = Utr ; n = Pl ; p = P3} ;
  every_Det = varjeDet ;
  everything_NP = nameNounPhrase (mkProperName "alt" NNeutr) ;
  everywhere_Adv = advPost "overalt" ;
  from_Prep = ss "fra" ;
  he_NP = pronNounPhrase han_34 ;
  how_IAdv = ss "hvor" ;
  how8many_IDet = mkDeterminerPl ["hvor mange"] IndefP ;
  if_Subj = ss "hvis" ;
  in8front_Prep = ss "fremfor" ; ---- ?
  i_NP = pronNounPhrase jag_32 ;
  in_Prep = ss "i" ;
  it_NP = pronNounPhrase det_40 ; ----
  many_Det = mkDeterminerPl "mange" IndefP ;
  most_Det = mkDeterminerSgGender2 ["den meste"] ["det meste"] (DefP Def) ;
  most8many_Det = flestaDet ;
  much_Det = mkDeterminerSg (detSgInvar "meget") IndefP ;
  must_VV = mkVerb "måtte" "må" "mås" "måtte" "måttet" "må" **
    {s1 = [] ; isAux = True} ; ---- ?
  on_Prep = ss "på" ;
  or_Conj = ss "eller" ** {n = Sg} ;
  otherwise_Adv = ss "anderledes" ; ---- ?
  part_Prep = ss "af" ;
  no_Phr = ss ["Nej ."] ;
  yes_Phr = ss ["Ja ."] ;
  possess_Prep = ss "af" ;
  quite_Adv = ss "temmelig" ;
  she_NP = pronNounPhrase hon_35 ;
  so_Adv = ss "så" ;
  somebody_NP = nameNounPhrase (mkProperName "nogen" NUtr) ;
  some_Det = mkDeterminerSgGender2 "nogen" "noget" IndefP ;
  some_NDet = mkDeterminerPlNum "nogle" IndefP ;
  something_NP = nameNounPhrase (mkProperName "noget" NNeutr) ;
  somewhere_Adv = advPost ["et eller andet sted"] ; ---- ?
  that_Det = mkDeterminerSgGender2 ["den der"] ["det der"] (DefP Indef) ;
  that_NP = regNameNounPhrase ["det der"] NNeutr ;
  therefore_Adv = ss "derfor" ;
  these_NDet = mkDeterminerPlNum ["de her"] (DefP Indef) ;
  they8fem_NP = pronNounPhrase de_38 ;
  they_NP = pronNounPhrase de_38 ;
  this_Det = mkDeterminerSgGender2 ["den her"] ["det her"] (DefP Indef) ;
  this_NP = regNameNounPhrase ["det her"] NNeutr ;
  those_NDet = mkDeterminerPlNum ["de der"] (DefP Indef) ;
  thou_NP = pronNounPhrase du_33 ;
  through_Prep = ss "igennem" ;
  too_Adv = ss "for" ; ---- ?
  to_Prep = ss "til" ;
  under_Prep = ss "under" ;
  very_Adv = ss "meget" ;
  want_VV = mkVerb "ville" "vil" nonExist "ville" "villet" nonExist **
    {s1 = [] ; isAux = True} ; ---
  we_NP = pronNounPhrase (vi_36) ;
  what8many_IP = intPronWhat plural ;
  what8one_IP = intPronWhat singular ;
  when_IAdv = ss "hvornår" ;
  when_Subj = ss "når" ;
  where_IAdv = ss "hver" ;
  which8one_IDet = vilkenDet ;
  which8many_IDet = mkDeterminerPl "hvilke" IndefP ;
  who8many_IP = intPronWho plural ;
  who8one_IP = intPronWho singular ;
  why_IAdv = ss "hvorfor" ;
  without_Prep = ss "uden" ;
  with_Prep = ss "med" ;
  ye_NP = pronNounPhrase (ni_37) ;
  you_NP = pronNounPhrase De_38 ;

}
