--# -path=.:../abstract:../../prelude

--1 The Top-Level English Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2003
--
concrete StructuralEng of Structural = 
                      CategoriesEng, NumeralsEng ** open Prelude, SyntaxEng in {

  flags optimize=all ;

  lin
  UseNumeral i = {s = table {Nom => i.s ; Gen => i.s ++ "'s"}} ; ---


  above_Prep = ss "above" ;
  after_Prep = ss "after" ;
  all8mass_Det = mkDeterminer Sg "all" ; --- all the missing
  all_NDet = mkDeterminerNum "all" ;
  almost_Adv = ss "almost" ;
  although_Subj = ss "although" ;
  and_Conj = ss "and" ** {n = Pl} ;
  because_Subj = ss "because" ;
  before_Prep = ss "before" ;
  behind_Prep = ss "behind" ;
  between_Prep = ss "between" ;
  both_AndConjD = sd2 "both" "and" ** {n = Pl} ;
  by8agent_Prep = ss "by" ;
  by8means_Prep = ss "by" ;
  can8know_VV = vvCan ;
  can_VV = vvCan ;
  during_Prep = ss "during" ;
  either8or_ConjD = sd2 "either" "or" ** {n = Sg} ;
  everybody_NP = nameNounPhrase (nameReg "everybody" human) ;
  every_Det = everyDet ;
  everything_NP = nameNounPhrase (nameReg "everything" Neutr) ;
  everywhere_Adv = ss "everywhere" ;
  from_Prep = ss "from" ;
  he_NP = pronNounPhrase pronHe ;
  how_IAdv = ss "how" ;
  how8many_IDet = mkDeterminer Pl ["how many"] ;
  if_Subj = ss "if" ;
  in8front_Prep = ss ["in front of"] ;
  i_NP = pronNounPhrase pronI ;
  in_Prep = ss "in" ;
  it_NP = pronNounPhrase pronIt ;
  many_Det = mkDeterminer Pl "many" ;
  most_Det = mkDeterminer Sg "most" ;
  most8many_Det = mostDet ;
  much_Det = mkDeterminer Sg ["a lot of"] ; ---
  must_VV = vvMust ;

  no_Phr = ss "No." ;
  on_Prep = ss "on" ;
  or_Conj = ss "or" ** {n = Sg} ;
  otherwise_Adv = ss "otherwise" ;
  part_Prep = ss "of" ;
  possess_Prep = ss "of" ;
  quite_Adv = ss "quite" ;
  she_NP = pronNounPhrase pronShe ;
  so_Adv = ss "so" ;
  somebody_NP = nameNounPhrase (nameReg "somebody" human) ;
  some_Det = mkDeterminer Sg "some" ;
  some_NDet = mkDeterminerNum "some" ;
  something_NP = nameNounPhrase (nameReg "something" Neutr) ;
  somewhere_Adv = ss "somewhere" ;
  that_Det = mkDeterminer Sg "that" ;
  that_NP = nameNounPhrase (nameReg "that" Neutr) ;
  therefore_Adv = ss "therefore" ;
  these_NDet = mkDeterminerNum "these" ;
  they8fem_NP = pronNounPhrase pronThey ;
  they_NP = pronNounPhrase pronThey ;
  this_Det = mkDeterminer Sg "this" ;
  this_NP = nameNounPhrase (nameReg "this" Neutr) ;
  those_NDet = mkDeterminerNum "those" ;
  thou_NP = pronNounPhrase pronYouSg ;
  through_Prep = ss "through" ;
  too_Adv = ss "too" ;
  to_Prep = ss "to" ;
  under_Prep = ss "under" ;
  very_Adv = ss "very" ;
  want_VV = verbNoPart (regVerbP3 "want") ** {isAux = False} ;
  we_NP = pronNounPhrase pronWe ;
  what8many_IP = intPronWhat plural ;
  what8one_IP = intPronWhat singular ;
  when_IAdv = ss "when" ;
  when_Subj = ss "when" ;
  where_IAdv = ss "where" ;
  which8many_IDet = mkDeterminer Pl ["which"] ;
  which8one_IDet = mkDeterminer Sg ["which"] ;
  who8many_IP = intPronWho plural ;
  who8one_IP = intPronWho singular ;
  why_IAdv = ss "why" ;
  without_Prep = ss "without" ;
  with_Prep = ss "with" ;
  ye_NP = pronNounPhrase pronYouPl ;
  you_NP = pronNounPhrase pronYouSg ;
  yes_Phr = ss "Yes." ;

}
