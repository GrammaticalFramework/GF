concrete StructuralAfr of Structural = CatAfr, Prelude ** 

  open ParadigmsAfr, ResAfr, (X = ConstructX) in
{


  flags optimize=all ;

  lin

  above_Prep = mkPrep "bo" ;
  after_Prep = mkPrep "na" ;
  all_Predet = mkPredet "alle" "alle" ; ----
  almost_AdA, almost_AdN = ss "byna" ;
  although_Subj = ss "hoewel" ;
  always_AdV = ss "altyd" ;
  and_Conj = {s1 = [] ; s2 = "en" ; n = Pl} ;
  because_Subj = ss "omdat" ; ---- doordat
  before_Prep = mkPrep "voor" ;
  behind_Prep = mkPrep "agter" ;
  between_Prep = mkPrep "tussen" ;
  both7and_DConj = {s1 = "sowel" ; s2 = "as" ; n = Pl} ;
  but_PConj = ss "maar" ;
  by8agent_Prep = mkPrep "deur" ;
  by8means_Prep = mkPrep "met" ;
  can8know_VV, can_VV = auxVV (mkV "kan" "kon") ;
  during_Prep = mkPrep "tydens" ;
  either7or_DConj = {s1 = "òf" ; s2 = "òf" ; n = Pl} ;
  everybody_NP = mkNP "almal" Neutr Pl ; ----
  every_Det = mkDet "elke" "elk" Sg ; ----
  everything_NP = mkNP "alles" Neutr Sg ; ----
  everywhere_Adv = ss "oral" ;
  few_Det = mkDet "min" "min" Pl ;
  for_Prep = mkPrep "voor" ;
  from_Prep = mkPrep "uit" ;
  he_Pron = mkPronoun "hy" "hom" "sy" "hy" "hom" "sy" "syne" Neutr Sg P3 ;	--afr
  here7to_Adv = ss ["hier"] ;
  here7from_Adv = ss ["van hier"] ; ----
  here_Adv = ss "hier" ;
  how_IAdv = ss "hoe" ;
  how8much_IAdv = ss "hoeveel" ;
  how8many_IDet = mkDet "hoeveel" "hoeveel" Pl ;
  if_Subj = ss "as" ;
  in8front_Prep = mkPrep "voor" ;
  i_Pron = mkPronoun "ek" "my" "my" "ek" "my" "my" "myne" Neutr Sg P1 ;
  in_Prep = ss "in" ;
  it_Pron = mkPronoun "dit" "dit" "sy" "dit" "dit" "sy" "syne" Neutr Sg P3 ;

  less_CAdv = X.mkCAdv "minder" "as" ;
  many_Det = mkDet "baie" "baie" Pl ;
  more_CAdv = X.mkCAdv "meer" "as" ;
  most_Predet = mkPredet "meeste" "meeste" ;
  much_Det = mkDet "baie" "baie" Sg ;

  must_VV = auxVV (mkV "moet" "moes" "gemoeten") ;	--afr

  only_Predet = {s = \\_,_ => "slegs"} ;
  no_Utt = ss "neen" ;
  on_Prep = mkPrep "op" ;
  or_Conj = {s1 = [] ; s2 = "of" ; n = Sg} ;
  otherwise_PConj = ss "anders" ;
  part_Prep = mkPrep "van" ;
  please_Voc = ss "asseblief" ;
  possess_Prep = mkPrep "van" ;
  quite_Adv = ss "heel" ;
  she_Pron = mkPronoun "sy" "haar" "haar" "sy" "haar" "haar" "hare" Neutr Sg P3 ;

  so_AdA = ss "so" ;
  somebody_NP = mkNP "iemand" Neutr Sg ;
  somePl_Det = mkDet "sommige" "sommige" Pl ;
  someSg_Det = mkDet "sommige" "sommige" Sg ;
  something_NP = mkNP "iets" Neutr Sg ;
  somewhere_Adv = ss "êrens" ;
  that_Quant = mkQuant "daardie" "daardie" ;
  that_Subj = ss "dat" ;
  there_Adv = ss "daar" ;
  there7to_Adv = ss "daar" ;
  there7from_Adv = ss "van daar" ;
  therefore_PConj = ss "daarom" ;

  they_Pron = mkPronoun "hulle" "hulle" "hulle" "hulle" "hulle" "hulle" "hulle s'n" Neutr Pl P3 ; ----

  this_Quant = mkQuant "hierdie" "hierdie" ;
  through_Prep = mkPrep "deur" ;
  too_AdA = ss "te" ;
  to_Prep = mkPrep "na" ;
  under_Prep = mkPrep "onder" ;
  very_AdA = ss "baie" ;
  want_VV = auxVV (mkV "wil" "wou" "gewil") ;

  we_Pron = mkPronoun "ons" "ons" "ons" "ons" "ons" "ons" "ons s'n" Neutr Pl P3 ; ----

  whatSg_IP = {s = \\_ => "wat" ; n = Sg} ;
  whatPl_IP = {s = \\_ => "wat" ; n = Pl} ;

  when_IAdv = ss "wanneer" ;
  when_Subj = ss "as" ;
  where_IAdv = ss "waar" ;
  which_IQuant = mkPredet "watter" "watter" ;

  whoSg_IP = {s = \\_ => "wie" ; n = Sg} ;
  whoPl_IP = {s = \\_ => "wie" ; n = Pl} ;
  why_IAdv = ss "waarom" ;
  without_Prep = mkPrep "sonder" ;
  with_Prep = mkPrep "met" ;
  youSg_Pron = mkPronoun "jy" "jou" "jou" "jy" "jou" "je" "joune" Neutr Sg P2 ;  --- Neutr as hack for familiarity
  youPl_Pron = mkPronoun "julle" "julle" "julle" "julle" "julle" "julle" "julle s'n" Neutr Pl P2 ;
  youPol_Pron = mkPronoun "u" "u" "u" "u" "u" "u" "u s'n" Neutr Sg P2 ;
  yes_Utt = ss "ja" ;

  not_Predet = mkPredet "nie" "nie" ;
  no_Quant = mkQuant "geen" "geen" ;
  if_then_Conj = {s1 = "as" ; s2 = "dan" ; n = Sg ; lock_Conj = <>} ;
  nobody_NP = mkNP "niemand" Neutr Sg ;
  nothing_NP = mkNP "niks" Neutr Sg ;
  at_least_AdN = ss "ten minste" ;
  at_most_AdN = ss "hoogstens" ;
  except_Prep = mkPrep "behalwe" ;

  as_CAdv = X.mkCAdv "so" "soos" ;	--afr
  have_V2 = mkV2 ParadigmsAfr.hebben_V ;

  lin language_title_Utt = ss "afrikaans" ;

}
