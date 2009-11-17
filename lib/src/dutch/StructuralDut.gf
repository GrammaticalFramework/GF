concrete StructuralDut of Structural = CatDut, Prelude ** 

  open ParadigmsDut, ResDut in
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
  both7and_DConj = {s1 = "zowel" ; s2 = "en" ; n = Pl} ;
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
  how8many_IDet = mkDet "hoeveel" "hoeveel" Pl ;
  if_Subj = ss "als" ;
  in8front_Prep = mkPrep "voor" ;
  i_Pron = mkPronoun "ik" "me" "m'n" "ik" "mij" "mijn" "mijne" Utr Sg P1 ;
  in_Prep = ss "in" ;
  it_Pron = mkPronoun "het" "het" "zijn" "het" "het" "zijn" "zijne" Neutr Sg P3 ;

--  less_CAdv = X.mkCAdv "weniger" "als" ;
--  many_Det = detLikeAdj Pl "viel" ;
--  more_CAdv = X.mkCAdv "mehr" "als" ;
--  most_Predet = {s = appAdj (regA "meist") ; c = NoCase} ;
--  much_Det = detLikeAdj Sg "viel" ;

  must_VV = auxVV (mkV "moeten" "moest" "gemoete") ;

  only_Predet = {s = \\_,_ => "slechts"} ;
  no_Utt = ss "neen" ;
  on_Prep = mkPrep "op" ;
  or_Conj = {s1 = [] ; s2 = "of" ; n = Sg} ;
--  otherwise_PConj = ss "sonst" ;
  part_Prep = mkPrep "van" ;
--  please_Voc = ss "bitte" ;
  possess_Prep = mkPrep "van" ;
--  quite_Adv = ss "ziemlich" ;
  she_Pron = mkPronoun "ze" "haar" "haar" "zij" "haar" "haar" "haare" Utr Sg P3 ;

  so_AdA = ss "zo" ;
--  somebody_NP = nameNounPhrase {s = caselist "jemand" "jemanden" "jemandem" "jemands"} ;
--  somePl_Det = detLikeAdj Pl "einig" ;
--  someSg_Det = {
--      s,sp = \\g,c => "ein" + pronEnding ! GSg g ! c ;  ---- einer,eines
--      n = Sg ;
--      a = Strong
--      } ;
--  something_NP = nameNounPhrase {s = \\_ => "etwas"} ;
--  somewhere_Adv = ss "irgendwo" ;
  that_Quant = mkQuant "die" "dat" ;
--     jener : Number => Gender => Case => Str = \\n => (detLikeAdj n "jen").s in 
--     {s = \\_ => jener ; sp = jener ; a = Weak} ;

--  there_Adv = ss "da" ;
--  there7to_Adv = ss "dahin" ;
--  there7from_Adv = ss ["daher"] ;
--  therefore_PConj = ss "deshalb" ;

  they_Pron = mkPronoun "ze" "ze" "hun" "zij" "hen" "hun" "hunne" Utr Pl P3 ; ----

  this_Quant = mkQuant "deze" "dit" ;
  through_Prep = mkPrep "door" ;
--  too_AdA = ss "zu" ;
  to_Prep = mkPrep "te" ;
  under_Prep = mkPrep "onder" ;
  very_AdA = ss "erg" ;
  want_VV = auxVV (mkV "wil" "wil" "willen" "wou" "wouden" "gewild") ;

  we_Pron = mkPronoun "we" "ons" "ons" "wij" "ons" "onze" "onze" Utr Sg P3 ; ----

  whatSg_IP = {s = \\_ => "wat" ; n = Sg} ;
  whatPl_IP = {s = \\_ => "wat" ; n = Pl} ;

  when_IAdv = ss "wanneer" ;
--  when_Subj = ss "wenn" ;
  where_IAdv = ss "waar" ;
  which_IQuant = mkPredet "welke" "welk" ;

  whoSg_IP = {s = \\_ => "wie" ; n = Sg} ;
  whoPl_IP = {s = \\_ => "wie" ; n = Pl} ;
  why_IAdv = ss "waarom" ;
  without_Prep = mkPrep "zonder" ;
  with_Prep = mkPrep "met" ;
  youSg_Pron = mkPronoun "je" "je" "je" "jij" "jou" "je" "jouwe" Utr Sg P2 ;
--  youPl_Pron = mkPronPers "ihr" "euch" "euch" "eurer" "euer" Fem Pl P2 ; ---- poss
--  youPol_Pron = mkPronPers "Sie" "Sie" "Ihnen" "Ihrer" "Ihr" Fem Pl P3 ;
--  yes_Utt = ss "ja" ;
--
--  not_Predet = {s = \\_,_,_ => "nicht" ; c = NoCase} ;
--  no_Quant = let 
--     keiner : Number => Gender => Case => Str = table {
--       Sg => \\g,c => "kein" + pronEnding ! GSg g ! c ;
--       Pl => (detLikeAdj Pl "kein").s
--       }
--     in 
--     {s = \\_ => keiner ; sp = keiner ; a = Strong} ;   ---- sp
--  if_then_Conj = {s1 = "wenn" ; s2 = "dann" ; n = Sg ; lock_Conj = <>} ;
--  nobody_NP = 
--    nameNounPhrase {s = caselist "niemand" "niemanden" "niemandem" "niemands"} ;
--  nothing_NP = 
--    nameNounPhrase {s = \\_ => "nichts"} ;
--  at_least_AdN = ss "wenigstens" ;
--  at_most_AdN = ss "höchstens" ;
--  except_Prep = mkPrep "außer" Dat ;
--
--  as_CAdv = X.mkCAdv "ebenso" "wie" ;
  have_V2 = mkV2 hebben_V ;
--
--  lin language_title_Utt = ss "Deutsch" ;
--
--}

}
