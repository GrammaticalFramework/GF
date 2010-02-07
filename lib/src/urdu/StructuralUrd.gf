concrete StructuralUrd of Structural = CatUrd ** 
  open MorphoUrd, ParadigmsUrd, Prelude in {

  flags optimize=all ;

  lin
--  above_Prep = ss "awpr" ;
--  after_Prep = ss "after" ;
  all_Predet = ss "tmam" ;
  almost_AdA, almost_AdN = ss "tqryba" ;
  although_Subj = ss "agrch-" ;
  always_AdV = ss "hmyXh" ;
  and_Conj = sd2 [] "awr" ** {n = Pl} ;
-----b  and_Conj = ss "and" ** {n = Pl} ;
  because_Subj = ss "kywnkh-" ;
--  before_Prep = ss "before" ;
--  behind_Prep = ss "behind" ;
--  between_Prep = ss "between" ;
  both7and_DConj = sd2 "dwnwN" "awr" ** {n = Pl} ;
  but_PConj = ss "lykn" ;
--  by8agent_Prep = ss "by" ;
--  by8means_Prep = ss "by" ;
can_VV = mkV "skna" ** { isAux = True} ;
--  can8know_VV, can_VV = {
--    s = table { 
--      VVF VInf => ["be able to"] ;
--      VVF VPres => "can" ;
--      VVF VPPart => ["been able to"] ;
--      VVF VPresPart => ["being able to"] ;
--      VVF VPast => "could" ;      --# notpresent
--      VVPastNeg => "couldn't" ;   --# notpresent
--      VVPresNeg => "can't"
--      } ;
--    isAux = True
--    } ;
--  during_Prep = ss "during" ;
  either7or_DConj = sd2 "kwy ayk" "or" ** {n = Sg} ;
--  everybody_NP = regNP "everybody" Sg ;
    every_Det = mkDet "hr" "hr" "hr" "hr" Sg;
--  everything_NP = regNP "everything" Sg ;
  everywhere_Adv = ss "hr jgh" ;
  few_Det = mkDet "cnd" "cnd" "cnd" "cnd" Pl ;
  first_Ord = ss "pehla" ; --DEPRECATED
--  for_Prep = ss "for" ;
--  from_Prep = ss "from" ;
--  he_Pron = personalPronoun P3 Sg ** {a = Ag Masc Sg P3} ;
  here_Adv = ss "yhaN" ;
  here7to_Adv = ss ["yhaN pr"] ;
  here7from_Adv = ss ["yhaN sE"] ;
  how_IAdv = ss "how" ;
  how8many_IDet = makeIDet "ktnE" "ktny" Pl ;
  if_Subj = ss "if" ;
--  in8front_Prep = ss ["in front of"] ;
    i_Pron = personalPN "myN";
--  i_Pron = personalPronoun P1 Sg ** {a = Ag Masc Sg P1} ;
--  in_Prep = ss "meN" ;
--  it_Pron  = mkNP "it" "it" "its" Sg P3 Neutr ;
  less_CAdv = {s = "km" ; p = ""} ;
  many_Det = mkDet "bht zyadh" "bht zyadh" "bht zyadh" "bht zyadh" Pl ;
--  more_CAdv = ss "zyadh-" ;
  most_Predet = ss "zyadh tr" ;
  much_Det = mkDet "bht" "bht" "bht" "bht" Sg  ;
--  must_VV = {
--    s = table {
--      VVF VInf => ["have to"] ;
--      VVF VPres => "must" ;
--      VVF VPPart => ["had to"] ;
--      VVF VPresPart => ["having to"] ;
--      VVF VPast => ["had to"] ;      --# notpresent
--      VVPastNeg => ["hadn't to"] ;      --# notpresent
--      VVPresNeg => "mustn't"
--      } ;
--    isAux = True
--    } ;
-----b  no_Phr = ss "no" ;
  no_Utt = ss "nhyN" ;
--  on_Prep = ss "on" ;
------  one_Quant = mkDeterminer Sg "one" ; -- DEPRECATED
  only_Predet = ss "srf" ;
--  or_Conj = sd2 [] "or" ** {n = Sg} ;
--  otherwise_PConj = ss "othewise" ;
--  part_Prep = ss "of" ;
  please_Voc = ss "mhrbani" ;
--  possess_Prep = ss "of" ;
  quite_Adv = ss "khamosh" ;
--  she_Pron = mkNP "she" "her" "her" Sg P3 Fem ;
  so_AdA = ss "so" ;
--  somebody_NP = regNP "somebody" Sg ;
  someSg_Det = mkDet "kch-" "kch-" "kch-" "kch-" Sg ;
  somePl_Det = mkDet "kch-" "kch-" "kch-" "kch-" Pl ;
--  something_NP = regNP "something" Sg ;
  somewhere_Adv = ss "khin pr" ;
--  that_Quant = mkQuant "that" "those" ;
  there_Adv = ss "whaN" ;
  there7to_Adv = ss "whaN pr" ;
--  there7from_Adv = ss ["from there"] ;
--  therefore_PConj = ss "therefore" ;
--  they_Pron = mkNP "they" "them" "their" Pl P3 Masc ; ---- 
  this_Quant = demoPN "yh" "as" "an";      
  that_Quant = demoPN "wh" "us" "un";
--  this_Quant = mkQuant "this" "these" ;
--  through_Prep = ss "through" ;
  too_AdA = ss "bht" ;
--  to_Prep = ss "to" ;
--  under_Prep = ss "under" ;
  very_AdA = ss "bht" ;
  want_VV = mkV "cahna" ** { isAux = True} ;
--  want_VV = P.mkVV (P.regV "want") ;
--  we_Pron = personalPronoun P1 Pl ** {a = Ag Masc Pl P1} ;
-- whatPl_IP = makeIntPronForm;
  whatSg_IP = mkIP "kya" "kis" "kis" Sg Masc ;
  whatPl_IP = mkIP "kya" "kin" "kin" Pl Masc ;
--  when_IAdv = ss "when" ;
--  when_Subj = ss "when" ;
  where_IAdv = ss "khaN" ;
  which_IQuant = {s = \\_ => "kwn sy"} ;
--  whichPl_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
--  whichSg_IDet = makeDet "kwn sa" "kwn sy" "kwn sE" "kwn sy" ;
  whoSg_IP = mkIP "kwn" "kis" "kis" Sg Masc  ;
  whoPl_IP = mkIP "kwn" "kn" "knhwN" Pl Masc ;
--  why_IAdv = ss "why" ;
--  without_Prep = ss "without" ;
  with_Prep = makePrep "kE sath-" "kE sath-" "kE sath-" "kE sath-" Sg ;
-----b  yes_Phr = ss "yes" ;
  yes_Utt = ss "haN" ;
--  youSg_Pron = mkNP "you" "you" "your" Sg P2 Masc ;
--  youPl_Pron = mkNP "you" "you" "your" Pl P2 Masc ;
--  youPol_Pron = mkNP "you" "you" "your" Sg P2 Masc ;
--
--
 oper
  mkQuant : Str -> Str -> {s : Number => Str} = \x,y -> {
    s = table Number [x ; y]
    } ;

}

