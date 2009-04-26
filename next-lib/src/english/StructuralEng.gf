concrete StructuralEng of Structural = CatEng ** 
  open MorphoEng, ResEng, ParadigmsEng, MakeStructuralEng, 
  (C = ConstructX), Prelude in {

  flags optimize=all ;

  lin
  above_Prep = mkPrep "above" ;
  after_Prep = mkPrep "after" ;
  all_Predet = ss "all" ;
  almost_AdA = mkAdA "almost" ;
  almost_AdN = mkAdN "almost" ;
  although_Subj = ss "although" ;
  always_AdV = mkAdV "always" ;
  and_Conj = mkConj "and" ;
  because_Subj = ss "because" ;
  before_Prep = mkPrep "before" ;
  behind_Prep = mkPrep "behind" ;
  between_Prep = mkPrep "between" ;
  both7and_DConj = mkConj "both" "and";
  but_PConj = ss "but" ;
  by8agent_Prep = mkPrep "by" ;
  by8means_Prep = mkPrep "by" ;
  can8know_VV, can_VV = {
    s = table { 
      VVF VInf => ["be able to"] ;
      VVF VPres => "can" ;
      VVF VPPart => ["been able to"] ;
      VVF VPresPart => ["being able to"] ;
      VVF VPast => "could" ;      --# notpresent
      VVPastNeg => "couldn't" ;   --# notpresent
      VVPresNeg => "can't"
      } ;
    isAux = True
    } ;
  during_Prep = mkPrep "during" ;
  either7or_DConj = mkConj "either" "or" singular ;
  everybody_NP = regNP "everybody" singular ;
  every_Det = mkDeterminer singular "every" ;
  everything_NP = regNP "everything" singular ;
  everywhere_Adv = mkAdv "everywhere" ;
  few_Det = mkDeterminer plural "few" ;
---  first_Ord = ss "first" ; DEPRECATED
  for_Prep = mkPrep "for" ;
  from_Prep = mkPrep "from" ;
  he_Pron = mkPron "he" "him" "his" "his" singular P3 masculine ;
  here_Adv = mkAdv "here" ;
  here7to_Adv = mkAdv ["to here"] ;
  here7from_Adv = mkAdv ["from here"] ;
  how_IAdv = ss "how" ;
  how8many_IDet = mkDeterminer plural ["how many"] ;
  if_Subj = ss "if" ;
  in8front_Prep = mkPrep ["in front of"] ;
  i_Pron  = mkPron "I" "me" "my" "mine" singular P1 human ;
  in_Prep = mkPrep "in" ;
  it_Pron  = mkPron "it" "it" "its" "its" singular P3 nonhuman ;
  less_CAdv = C.mkCAdv "less" "than" ;
  many_Det = mkDeterminer plural "many" ;
  more_CAdv = C.mkCAdv "more" "than" ;
  most_Predet = ss "most" ;
  much_Det = mkDeterminer singular "much" ;
  must_VV = {
    s = table {
      VVF VInf => ["have to"] ;
      VVF VPres => "must" ;
      VVF VPPart => ["had to"] ;
      VVF VPresPart => ["having to"] ;
      VVF VPast => ["had to"] ;      --# notpresent
      VVPastNeg => ["hadn't to"] ;      --# notpresent
      VVPresNeg => "mustn't"
      } ;
    isAux = True
    } ;
---b  no_Phr = ss "no" ;
  no_Utt = ss "no" ;
  on_Prep = mkPrep "on" ;
----  one_Quant = mkDeterminer singular "one" ; -- DEPRECATED
  only_Predet = ss "only" ;
  or_Conj = mkConj "or" singular ;
  otherwise_PConj = ss "otherwise" ;
  part_Prep = mkPrep "of" ;
  please_Voc = ss "please" ;
  possess_Prep = mkPrep "of" ;
  quite_Adv = mkAdv "quite" ;
  she_Pron = mkPron "she" "her" "her" "hers" singular P3 feminine ;
  so_AdA = mkAdA "so" ;
  somebody_NP = regNP "somebody" singular ;
  someSg_Det = mkDeterminer singular "some" ;
  somePl_Det = mkDeterminer plural "some" ;
  something_NP = regNP "something" singular ;
  somewhere_Adv = mkAdv "somewhere" ;
  that_Quant = mkQuant "that" "those" ;
  there_Adv = mkAdv "there" ;
  there7to_Adv = mkAdv "there" ;
  there7from_Adv = mkAdv ["from there"] ;
  therefore_PConj = ss "therefore" ;
  they_Pron = mkPron "they" "them" "their" "theirs" plural P3 human ;
  this_Quant = mkQuant "this" "these" ;
  through_Prep = mkPrep "through" ;
  too_AdA = mkAdA "too" ;
  to_Prep = mkPrep "to" ;
  under_Prep = mkPrep "under" ;
  very_AdA = mkAdA "very" ;
  want_VV = mkVV (regV "want") ;
  we_Pron = mkPron "we" "us" "our" "ours" plural P1 human ;
  whatPl_IP = mkIP "what" "what" "what's" plural ;
  whatSg_IP = mkIP "what" "what" "what's" singular ;
  when_IAdv = ss "when" ;
  when_Subj = ss "when" ;
  where_IAdv = ss "where" ;
  which_IQuant = {s = \\_ => "which"} ;
---b  whichPl_IDet = mkDeterminer plural ["which"] ;
---b  whichSg_IDet = mkDeterminer singular ["which"] ;
  whoPl_IP = mkIP "who" "whom" "whose" plural ;
  whoSg_IP = mkIP "who" "whom" "whose" singular ;
  why_IAdv = ss "why" ;
  without_Prep = mkPrep "without" ;
  with_Prep = mkPrep "with" ;
---b  yes_Phr = ss "yes" ;
  yes_Utt = ss "yes" ;
  youSg_Pron = mkPron "you" "you" "your" "yours" singular P2 human ;
  youPl_Pron = mkPron "you" "you" "your" "yours" plural P2 human ;
  youPol_Pron = mkPron "you" "you" "your" "yours" singular P2 human ;

  not_Predet = {s = "not" ; lock_Predet = <>} ;
  no_Quant = mkQuant "no" "no" "none" "none" ;
  if_then_Conj = mkConj "if" "then" singular ;
  nobody_NP = regNP "nobody" singular ;
  nothing_NP = regNP "nothing" singular ;

  at_least_AdN = mkAdN "at least" ;
  at_most_AdN = mkAdN "at most" ;

  except_Prep = mkPrep "except" ;

  as_CAdv = C.mkCAdv "as" "as" ;

  have_V2 = dirV2 (mk5V "have" "has" "had" "had" "having") ;

}

