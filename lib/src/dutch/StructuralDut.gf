concrete StructuralDut of Structural = CatDut, Prelude ** 

  open ParadigmsDut, ResDut, (X = ConstructX) in
{


  flags optimize=all ;

  lin

  above_Prep = mkPrep "boven" ;
  after_Prep = mkPrep "na" ;
  all_Predet = mkPredet "alle" "alle" ; ----
  almost_AdA, almost_AdN = ss "bijna" ;
  although_Subj = ss "hoewel" ;
  always_AdV = ss "altijd" ;
  and_Conj = {s1 = [] ; s2 = "en" ; n = Pl} ;
  because_Subj = ss "omdat" ; ---- doordat
  before_Prep = mkPrep "voor" ;
  behind_Prep = mkPrep "achter" ;
  between_Prep = mkPrep "tussen" ;
  both7and_DConj = {s1 = "zowel" ; s2 = "als" ; n = Pl} ;
  but_PConj = ss "maar" ;
  by8agent_Prep = mkPrep "door" ;
  by8means_Prep = mkPrep "met" ;
  can8know_VV, can_VV = auxVV kunnen_V ;
  during_Prep = mkPrep "tijdens" ;
  either7or_DConj = {s1 = "ofwel" ; s2 = "of" ; n = Pl} ;
  everybody_NP = mkNP "alle" Utr Pl ; ----
  every_Det = mkDet "elke" "elk" Sg ; ----
  everything_NP = mkNP "alles" Neutr Sg ; ----
  everywhere_Adv = ss "overal" ;
  few_Det = mkDet "weinig" "weinig" Pl ;
  for_Prep = mkPrep "voor" ;
  from_Prep = mkPrep "uit" ;
  he_Pron = mkPronoun "hij" "hem" "zijn" "hij" "hem" "zijn" "zijne" Utr Sg P3 ;
  here7to_Adv = ss ["hier"] ;
  here7from_Adv = ss ["van hier"] ; ----
  here_Adv = ss "hier" ;
  how_IAdv = ss "hoe" ;
  how8much_IAdv = ss "hoeveel" ;
  how8many_IDet = mkDet "hoeveel" "hoeveel" Pl ;
  if_Subj = ss "als" ;
  in8front_Prep = mkPrep "voor" ;
  i_Pron = mkPronoun "ik" "me" "mijn" "ik" "mij" "mijn" "mijne" Utr Sg P1 ;
  in_Prep = ss "in" ;
  it_Pron = mkPronoun "het" "het" "zijn" "het" "het" "zijn" "zijne" Neutr Sg P3 ;

  less_CAdv = X.mkCAdv "minder" "dan" ;
  many_Det = mkDet "veel" "veel" Pl ;
  more_CAdv = X.mkCAdv "meer" "dan" ;
  most_Predet = mkPredet "meeste" "meeste" ;
  much_Det = mkDet "veel" "veel" Sg ;

  must_VV = auxVV (mkV "moeten" "moest" "gemoeten") ;

  only_Predet = {s = \\_,_ => "slechts"} ;
  no_Utt = ss "neen" ;
  on_Prep = mkPrep "op" ;
  or_Conj = {s1 = [] ; s2 = "of" ; n = Sg} ;
  otherwise_PConj = ss "anders" ;
  part_Prep = mkPrep "van" ;
  please_Voc = ss "alsjeblieft" ;
  possess_Prep = mkPrep "van" ;
  quite_Adv = ss "heel" ;
  she_Pron = mkPronoun "ze" "haar" "haar" "zij" "haar" "haar" "hare" Utr Sg P3 ;

  so_AdA = ss "zo" ;
  somebody_NP = mkNP "iemand" Utr Sg ;
  somePl_Det = mkDet "sommige" "sommige" Pl ;
  someSg_Det = mkDet "sommige" "sommige" Sg ;
  something_NP = mkNP "iets" Utr Sg ;
  somewhere_Adv = ss "ergens" ;
  that_Quant = mkQuant "die" "dat" ;
  that_Subj = ss "dat" ;
  there_Adv = ss "daar" ;
  there7to_Adv = ss "daar" ;
  there7from_Adv = ss "van daar" ;
  therefore_PConj = ss "daarom" ;

  they_Pron = mkPronoun "ze" "ze" "hun" "zij" "hen" "hun" "hunne" Utr Pl P3 ; ----

  this_Quant = mkQuant "deze" "dit" ;
  through_Prep = mkPrep "door" ;
  too_AdA = ss "te" ;
  to_Prep = mkPrep "naar" ;
  under_Prep = mkPrep "onder" ;
  very_AdA = ss "erg" ;
  want_VV = auxVV (mkV "wil" "wil" "willen" "wou" "wouden" "gewild") ;

  we_Pron = mkPronoun "we" "ons" "ons" "wij" "ons" "onze" "onze" Utr Pl P3 ; ----

  whatSg_IP = {s = \\_ => "wat" ; n = Sg} ;
  whatPl_IP = {s = \\_ => "wat" ; n = Pl} ;

  when_IAdv = ss "wanneer" ;
  when_Subj = ss "als" ;
  where_IAdv = ss "waar" ;
  which_IQuant = mkPredet "welke" "welk" ;

  whoSg_IP = {s = \\_ => "wie" ; n = Sg} ;
  whoPl_IP = {s = \\_ => "wie" ; n = Pl} ;
  why_IAdv = ss "waarom" ;
  without_Prep = mkPrep "zonder" ;
  with_Prep = mkPrep "met" ;
  youSg_Pron = mkPronoun "je" "je" "je" "jij" "jou" "je" "jouwe" Utr Sg P2 ;
  youPl_Pron = mkPronoun "jullie" "jullie" "je" "jullie" "jullie" "jullie" "uwe" Utr Pl P2 ;
  youPol_Pron = mkPronoun "u" "u" "uw" "u" "u" "uw" "uwe" Utr Sg P2 ;
  yes_Utt = ss "ja" ;

  not_Predet = mkPredet "niet" "niet" ;
  no_Quant = mkQuant "geen" "geen" ;
  if_then_Conj = {s1 = "als" ; s2 = "dan" ; n = Sg ; lock_Conj = <>} ;
  nobody_NP = mkNP "niemand" Utr Sg ;
  nothing_NP = mkNP "niets" Neutr Sg ;
  at_least_AdN = ss "ten minste" ;
  at_most_AdN = ss "hooguit" ;
  except_Prep = mkPrep "met uitzondering van" ;

  as_CAdv = X.mkCAdv "zo" "als" ;
  have_V2 = mkV2 ParadigmsDut.hebben_V ;

  lin language_title_Utt = ss "nederlands" ;

}
