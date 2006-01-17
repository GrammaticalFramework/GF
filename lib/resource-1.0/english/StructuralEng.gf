concrete StructuralEng of Structural = CatEng ** 
  open MorphoEng, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = ss "above" ;
  after_Prep = ss "after" ;
  all_Predet = ss "all" ;
  almost_AdA, almost_AdN = ss "almost" ;
  although_Subj = ss "although" ;
  always_AdV = ss "always" ;
  and_Conj = ss "and" ** {n = Pl} ;
  because_Subj = ss "because" ;
  before_Prep = ss "before" ;
  behind_Prep = ss "behind" ;
  between_Prep = ss "between" ;
  both7and_DConj = sd2 "both" "and" ** {n = Pl} ;
  but_PConj = ss "but" ;
  by8agent_Prep = ss "by" ;
  by8means_Prep = ss "by" ;
  can8know_VV = verbPart (mkVerbIrreg "know" "knew" "known") "how"** {c2 = "to"} ;---
  can_VV = verbGen "manage" ** {c2 = "to"} ; ---
  during_Prep = ss "during" ;
  either7or_DConj = sd2 "either" "or" ** {n = Sg} ;
  everybody_NP = regNP "everybody" Sg ;
  every_Det = mkDeterminer Sg "every" ;
  everything_NP = regNP "everything" Sg ;
  everywhere_Adv = ss "everywhere" ;
  first_Ord = ss "first" ;
  from_Prep = ss "from" ;
  he_Pron = mkNP "he" "him" "his" Sg P3 ;
  here_Adv = ss "here" ;
  here7to_Adv = ss ["to here"] ;
  here7from_Adv = ss ["from here"] ;
  how_IAdv = ss "how" ;
  how8many_IDet = mkDeterminer Pl ["how many"] ;
  if_Subj = ss "if" ;
  in8front_Prep = ss ["in front of"] ;
  i_Pron  = mkNP "I" "me" "my"  Sg P1 ;
  in_Prep = ss "in" ;
  it_Pron  = mkNP "it" "it" "its" Sg P3 ;
  less_CAdv = ss "less" ;
  many_Det = mkDeterminer Pl "many" ;
  more_CAdv = ss "more" ;
  most_Predet = ss "most" ;
  much_Det = mkDeterminer Sg "much" ;
  must_VV = mkVerb4 "have" "has" "had" "had" ** {c2 = "to"} ; ---
  no_Phr = ss "no" ;
  on_Prep = ss "on" ;
  one_Quant = mkDeterminer Sg "one" ;
  only_Predet = ss "only" ;
  or_Conj = ss "or" ** {n = Sg} ;
  otherwise_PConj = ss "otherwise" ;
  part_Prep = ss "of" ;
  please_Voc = ss "please" ;
  possess_Prep = ss "of" ;
  quite_Adv = ss "quite" ;
  she_Pron = mkNP "she" "her" "her" Sg P3 ;
  so_AdA = ss "so" ;
  somebody_NP = regNP "somebody" Sg ;
  someSg_Det = mkDeterminer Sg "some" ;
  somePl_Det = mkDeterminer Pl "some" ;
  something_NP = regNP "something" Sg ;
  somewhere_Adv = ss "somewhere" ;
  that_Quant = mkDeterminer Sg "that" ;
  that_NP = regNP "that" Sg ;
  there_Adv = ss "there" ;
  there7to_Adv = ss "there" ;
  there7from_Adv = ss ["from there"] ;
  therefore_PConj = ss "therefore" ;
  these_NP = regNP "these" Pl ;
  these_Quant = mkDeterminer Pl "these" ;
  they_Pron = mkNP "they" "them" "their" Pl P3 ; 
  this_Quant = mkDeterminer Sg "this" ;
  this_NP = regNP "this" Sg ;
  those_NP = regNP "those" Pl ;
  those_Quant = mkDeterminer Pl "those" ;
  thou_Pron = mkNP "you" "you" "your" Sg P2 ;
  through_Prep = ss "through" ;
  too_AdA = ss "too" ;
  to_Prep = ss "to" ;
  under_Prep = ss "under" ;
  very_AdA = ss "very" ;
  want_VV = verbGen "want" ** {c2 = "to"} ;
  we_Pron = mkNP "we" "us"  "our" Pl P1 ;
  whatPl_IP = mkIP "what" "what" "what's" Sg ;
  whatSg_IP = mkIP "what" "what" "what's" Sg ;
  when_IAdv = ss "when" ;
  when_Subj = ss "when" ;
  where_IAdv = ss "where" ;
  whichPl_IDet = mkDeterminer Pl ["which"] ;
  whichSg_IDet = mkDeterminer Sg ["which"] ;
  whoSg_IP = mkIP "who" "whom" "whose" Sg ;
  whoPl_IP = mkIP "who" "whom" "whose" Pl ;
  why_IAdv = ss "why" ;
  without_Prep = ss "without" ;
  with_Prep = ss "with" ;
  ye_Pron = mkNP "you" "you" "your" Pl P2 ;
  you_Pron = mkNP "you" "you" "your" Sg P2 ;
  yes_Phr = ss "yes" ;

}

