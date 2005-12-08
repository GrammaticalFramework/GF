concrete StructuralSwe of Structural = CatSwe ** 
  open MorphoSwe, Prelude in {

  flags optimize=all ;

  above_Prep = ss "ovanför" ;
  after_Prep = ss "efter" ;
  by8agent_Prep = ss "av" ;
  all8mass_Det = mkDeterminerSgGender2 "all" "allt" IndefP ;
  all_NDet = mkDeterminerPlNum "alla" IndefP ;
  almost_Adv = ss "nästan" ;
  although_Subj = ss "fast" ;
  and_Conj = ss "och" ** {n = Pl} ;
  because_Subj = ss "eftersom" ;
  before_Prep = ss "före" ;
  behind_Prep = ss "bakom" ;
  between_Prep = ss "mellan" ;
  both_AndConjD = sd2 "både" "och" ** {n = Pl} ;
  by8means_Prep = ss "med" ;
  can8know_VV = mkVerb "kunna" "kan" "kunn" "kunde" "kunnat" "kunnen"
  ** {isAux = True} ;
  can_VV = mkVerb "kunna" "kan" "kunn" "kunde" "kunnat" "kunnen"
  ** {isAux = True} ;
  during_Prep = ss "under" ;
  either8or_ConjD = sd2 "antingen" "eller" ** {n = Sg} ;
  everybody_NP = let alla = table {Nom => "alla" ; Gen => "allas"} in 
    {s = \\c => alla ! npCase c ; g = Utr ; n = Pl ; p = P3} ;
  every_Det = varjeDet ;
  everything_NP = nameNounPhrase (mkProperName "allting" NNeutr) ;
  everywhere_Adv = advPost "varstans" ;
  from_Prep = ss "från" ;
  he_NP = pronNounPhrase han_34 ;
  how_IAdv = ss "hur" ;
  how8many_IDet = mkDeterminerPl ["hur många"] IndefP ;
  if_Subj = ss "om" ;
  in8front_Prep = ss "framför" ;
  i_NP = pronNounPhrase jag_32 ;
  in_Prep = ss "i" ;
  it_NP = pronNounPhrase det_40 ; ----

  many_Det = mkDeterminerPl "många" IndefP ;
  most_Det = mkDeterminerSgGender2 ["den mesta"] ["det mesta"] (DefP Def) ;
  most8many_Det = flestaDet ;
  much_Det = mkDeterminerSg (detSgInvar "mycket") IndefP ;
  must_VV = mkVerb "få" "måste" "få" "fick" "måst" "måst"   ** {isAux = True} ;
  no_Phr = ss ["Nej ."] ;
  on_Prep = ss "på" ;
  or_Conj = ss "eller" ** {n = Sg} ;
  otherwise_Adv = ss "annars" ;
  part_Prep = ss "av" ;
  possess_Prep = ss "av" ;
  quite_Adv = ss "ganska" ;
  she_NP = pronNounPhrase hon_35 ;
  so_Adv = ss "så" ;
  somebody_NP = nameNounPhrase (mkProperName "någon" (NUtr Masc)) ;
  some_Det = mkDeterminerSgGender2 "någon" "något" IndefP ;
  some_NDet = mkDeterminerPlNum "några" IndefP ;
  something_NP = nameNounPhrase (mkProperName "någonting" NNeutr) ;
  somewhere_Adv = advPost "någonstans" ;
  that_Det = mkDeterminerSgGender2 ["den där"] ["det där"] (DefP Def) ;
  that_NP = regNameNounPhrase ["det där"] NNeutr ;
  therefore_Adv = ss "därför" ;
  these_NDet = mkDeterminerPlNum ["de här"] (DefP Def) ;
  they8fem_NP = pronNounPhrase de_38 ;
  they_NP = pronNounPhrase de_38 ;
  this_Det = mkDeterminerSgGender2 ["den här"] ["det här"] (DefP Def) ;
  this_NP = regNameNounPhrase ["det här"] NNeutr ;
  those_NDet = mkDeterminerPlNum ["de där"] (DefP Def) ;
  thou_NP = pronNounPhrase du_33 ;
  through_Prep = ss "genom" ;
  too_Adv = ss "för" ;
  to_Prep = ss "till" ;
  under_Prep = ss "under" ;
  very_Adv = ss "mycket" ;
  want_VV = mkVerb "vilja" "vill" "vilj" "ville" "velat" "velad"   ** {isAux = True} ;
  we_NP = pronNounPhrase (vi_36) ;
  what8many_IP = intPronWhat plural ;
  what8one_IP = intPronWhat singular ;
  when_IAdv = ss "när" ;
  when_Subj = ss "när" ;
  where_IAdv = ss "var" ;
  which8one_IDet = vilkenDet ;
  which8many_IDet = mkDeterminerPl "vilka" IndefP ;
  who8many_IP = intPronWho plural ;
  who8one_IP = intPronWho singular ;
  why_IAdv = ss "varför" ;
  without_Prep = ss "utan" ;
  with_Prep = ss "med" ;
  ye_NP = pronNounPhrase (ni_37) ;
  yes_Phr = ss ["Ja ."] ;
  you_NP = let {ni = pronNounPhrase ni_37 } in {
             s = ni.s ; g = ni.g ; n = Sg ; p = P2} ; ---- gives wrong refl




{-
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
  these_Quant = mkDeterminer Pl "these" ;
  they_Pron = mkNP "they" "them" "their" Pl P3 ; 
  this_Quant = mkDeterminer Sg "this" ;
  this_NP = regNP "this" Sg ;
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
-}
}

