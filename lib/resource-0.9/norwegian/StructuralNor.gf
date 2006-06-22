--# -path=.:../scandinavian:../abstract:../../prelude

--1 The Top-Level Norwegian Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2004
--
concrete StructuralNor of Structural = 
  CategoriesNor, NumeralsNor ** open Prelude, MorphoNor, SyntaxNor in {

  lin
  UseNumeral i = {s = \\g => table {Nom => i.s ! g ; Gen => i.s ! g ++ "s"} ; n = i.n} ;

  above_Prep = ss "ovenfor" ;
  after_Prep = ss "etter" ;
  by8agent_Prep = ss "av" ;
  all8mass_Det = mkDeterminerSgGender2 "all" "alt" IndefP ;
  all_NDet = mkDeterminerPlNum "alle" IndefP ;
  almost_Adv = ss "nesten" ;
  although_Subj = ss ["selv om"] ;
  and_Conj = ss "og" ** {n = Pl} ;
  because_Subj = ss ["fordi"] ;
  before_Prep = ss "før" ;
  behind_Prep = ss "bakom" ;
  between_Prep = ss "mellom" ;
  both_AndConjD = sd2 "både" "og" ** {n = Pl} ;
  by8means_Prep = ss "med" ;
  can8know_VV = mkVerb "kunne" "kan" nonExist "kunne" "kunnet"  nonExist **
    {s1 = [] ; isAux = True} ;
  can_VV = mkVerb "kunne" "kan" nonExist "kunne" "kunnet" nonExist ** 
    {s1 = [] ; isAux = True} ;
  during_Prep = ss "under" ;
  either8or_ConjD = sd2 "enten" "eller" ** {n = Sg} ;
  everybody_NP = let alla = table {Nom => "alle" ; Gen => "alles"} in
    {s = \\c => alla ! npCase c ; g = Utr Masc ; n = Pl ; p = P3} ;
  every_Det = varjeDet ;
  everything_NP = nameNounPhrase (mkProperName "alt" NNeutr) ;
  everywhere_Adv = advPost "overalt" ;
  from_Prep = ss "fra" ;
  he_NP = pronNounPhrase han_34 ;
  how_IAdv = ss "hvor" ;
  how8many_IDet = mkDeterminerPl ["hvor mange"] IndefP ;
  if_Subj = ss "hvis" ;
  in8front_Prep = ss "foran" ;
  i_NP = pronNounPhrase jag_32 ;
  in_Prep = ss "i" ;
  it_NP = pronNounPhrase det_40 ; ----
  many_Det = mkDeterminerPl "mange" IndefP ;
  most_Det = mkDeterminerSgGender2 ["den meste"] ["det meste"] (DefP Def) ;
  most8many_Det = flestaDet ;
  much_Det = mkDeterminerSg (detSgInvar "mye") IndefP ;
  must_VV = mkVerb "måtte" "må" "mås" "måtte" "måttet" "mått" **
   {s1 = [] ; isAux = True} ;
  on_Prep = ss "på" ;
  or_Conj = ss "eller" ** {n = Sg} ;
  otherwise_Adv = ss "annerledes" ; ---- ?
  part_Prep = ss "av" ;
  no_Phr = ss ["Nei ."] ;
  yes_Phr = ss ["Ja ."] ;
  possess_Prep = ss "av" ;
  quite_Adv = ss "temmelig" ;
  she_NP = pronNounPhrase hon_35 ;
  so_Adv = ss "så" ;
  somebody_NP = nameNounPhrase (mkProperName "noen" (NUtr Masc)) ;
  some_Det = mkDeterminerSgGender2 "noen" "noe" IndefP ;
  some_NDet = mkDeterminerPlNum "noen" IndefP ;
  something_NP = nameNounPhrase (mkProperName "noe" NNeutr) ;
  somewhere_Adv = advPost ["et eller annet sted"] ; ---- ?
  that_Det = mkDeterminerSgGender2 ["den der"] ["det der"] (DefP Def) ;
  that_NP = regNameNounPhrase ["det"] NNeutr ;
  therefore_Adv = ss "derfor" ;
  these_NDet = mkDeterminerPlNum ["disse"] (DefP Def) ;
  they8fem_NP = pronNounPhrase de_38 ;
  they_NP = pronNounPhrase de_38 ;
  this_Det = mkDeterminerSgGender2 ["denne"] ["dette"] (DefP Def) ;
  this_NP = regNameNounPhrase ["dette"] NNeutr ;
  those_NDet = mkDeterminerPlNum ["de der"] (DefP Def) ;
  thou_NP = pronNounPhrase du_33 ;
  through_Prep = ss "gjennom" ;
  too_Adv = ss "for" ;
  to_Prep = ss "til" ;
  under_Prep = ss "under" ;
  very_Adv = ss "meget" ;
  want_VV = mkVerb "ville" "vil" nonExist "ville" "villet" "vill" ** 
    {s1 = [] ; isAux = True} ;
  we_NP = pronNounPhrase (vi_36) ;
  what8many_IP = intPronWhat plural ;
  what8one_IP = intPronWhat singular ;
  when_IAdv = ss "når" ;
  when_Subj = ss "når" ;
  where_IAdv = ss "hver" ;
  which8one_IDet = vilkenDet ;
  which8many_IDet = mkDeterminerPl "hvilke" IndefP ;
  who8many_IP = intPronWho plural ;
  who8one_IP = intPronWho singular ;
  why_IAdv = ss "hvorfor" ;
  without_Prep = ss "uten" ;
  with_Prep = ss "med" ;
  ye_NP = pronNounPhrase (ni_37) ;
  you_NP = pronNounPhrase De_38 ;
}
