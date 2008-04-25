concrete StructuralEng of Structural = CatEng ** 
  open MorphoEng, (P = ParadigmsEng), Prelude in {

  flags optimize=all ;

  lin
  above_Prep = ss "above" ;
  after_Prep = ss "after" ;
  all_Predet = ss "all" ;
  almost_AdA, almost_AdN = ss "almost" ;
  although_Subj = ss "although" ;
  always_AdV = ss "always" ;
  and_Conj = sd2 [] "and" ** {n = Pl} ;
---b  and_Conj = ss "and" ** {n = Pl} ;
  because_Subj = ss "because" ;
  before_Prep = ss "before" ;
  behind_Prep = ss "behind" ;
  between_Prep = ss "between" ;
  both7and_DConj = sd2 "both" "and" ** {n = Pl} ;
  but_PConj = ss "but" ;
  by8agent_Prep = ss "by" ;
  by8means_Prep = ss "by" ;
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
  during_Prep = ss "during" ;
  either7or_DConj = sd2 "either" "or" ** {n = Sg} ;
  everybody_NP = regNP "everybody" Sg ;
  every_Det = mkDeterminer Sg "every" ;
  everything_NP = regNP "everything" Sg ;
  everywhere_Adv = ss "everywhere" ;
  few_Det = mkDeterminer Pl "few" ;
---  first_Ord = ss "first" ; DEPRECATED
  for_Prep = ss "for" ;
  from_Prep = ss "from" ;
  he_Pron = mkNP "he" "him" "his" Sg P3 Masc ;
  here_Adv = ss "here" ;
  here7to_Adv = ss ["to here"] ;
  here7from_Adv = ss ["from here"] ;
  how_IAdv = ss "how" ;
  how8many_IDet = mkDeterminer Pl ["how many"] ;
  if_Subj = ss "if" ;
  in8front_Prep = ss ["in front of"] ;
  i_Pron  = mkNP "I" "me" "my"  Sg P1 Masc ;
  in_Prep = ss "in" ;
  it_Pron  = mkNP "it" "it" "its" Sg P3 Neutr ;
  less_CAdv = ss "less" ;
  many_Det = mkDeterminer Pl "many" ;
  more_CAdv = ss "more" ;
  most_Predet = ss "most" ;
  much_Det = mkDeterminer Sg "much" ;
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
  no_Phr = ss "no" ;
  on_Prep = ss "on" ;
----  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = ss "only" ;
  or_Conj = sd2 [] "or" ** {n = Sg} ;
  otherwise_PConj = ss "otherwise" ;
  part_Prep = ss "of" ;
  please_Voc = ss "please" ;
  possess_Prep = ss "of" ;
  quite_Adv = ss "quite" ;
  she_Pron = mkNP "she" "her" "her" Sg P3 Fem ;
  so_AdA = ss "so" ;
  somebody_NP = regNP "somebody" Sg ;
  someSg_Det = mkDeterminer Sg "some" ;
  somePl_Det = mkDeterminer Pl "some" ;
  something_NP = regNP "something" Sg ;
  somewhere_Adv = ss "somewhere" ;
  that_Quant = mkQuant "that" "those" ;
  there_Adv = ss "there" ;
  there7to_Adv = ss "there" ;
  there7from_Adv = ss ["from there"] ;
  therefore_PConj = ss "therefore" ;
  they_Pron = mkNP "they" "them" "their" Pl P3 Masc ; ---- 
  this_Quant = mkQuant "this" "these" ;
  through_Prep = ss "through" ;
  too_AdA = ss "too" ;
  to_Prep = ss "to" ;
  under_Prep = ss "under" ;
  very_AdA = ss "very" ;
  want_VV = P.mkVV (P.regV "want") ;
  we_Pron = mkNP "we" "us" "our" Pl P1 Masc ;
  whatPl_IP = mkIP "what" "what" "what's" Sg ;
  whatSg_IP = mkIP "what" "what" "what's" Sg ;
  when_IAdv = ss "when" ;
  when_Subj = ss "when" ;
  where_IAdv = ss "where" ;
  which_IQuant = {s = \\_ => "which"} ;
---b  whichPl_IDet = mkDeterminer Pl ["which"] ;
---b  whichSg_IDet = mkDeterminer Sg ["which"] ;
  whoSg_IP = mkIP "who" "whom" "whose" Sg ;
  whoPl_IP = mkIP "who" "whom" "whose" Pl ;
  why_IAdv = ss "why" ;
  without_Prep = ss "without" ;
  with_Prep = ss "with" ;
  yes_Phr = ss "yes" ;
  youSg_Pron = mkNP "you" "you" "your" Sg P2 Masc ;
  youPl_Pron = mkNP "you" "you" "your" Pl P2 Masc ;
  youPol_Pron = mkNP "you" "you" "your" Sg P2 Masc ;


oper
  mkQuant : Str -> Str -> {s : Number => Str} = \x,y -> {
    s = table Number [x ; y]
    } ;

}

