concrete StructuralFin of Structural = CatFin ** 
  open MorphoFin, ParadigmsFin, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = postGenPrep "yläpuolella" ;
  after_Prep = postGenPrep "jälkeen" ;

  all_Predet = {s = \\n,c => 
    let
      kaiket = caseTable n (nhn (sKorpi "kaikki" "kaiken" "kaikkena"))
    in
    case c of {
      Nom => "kaikki" ;
      _ => kaiket ! c
      }
    } ;
  almost_AdA, almost_AdN = ss "melkein" ;
  although_Subj = ss "vaikka" ;
  always_AdV = ss "aina" ;
  and_Conj = ss "ja" ** {n = Pl} ;
  because_Subj = ss "koska" ;
  before_Prep = prePrep partitive "ennen" ;
  behind_Prep = postGenPrep "takana" ;
  between_Prep = postGenPrep "välissä" ;
  both7and_DConj = sd2 "sekä" "että" ** {n = Pl} ;
  but_PConj = ss "mutta" ;
  by8agent_Prep = postGenPrep "toimesta" ;
  by8means_Prep = casePrep adessive ;
  can8know_VV = reg2V "osata" "osasi" ;
  can_VV = regV "voida" ;
  during_Prep = postGenPrep "aikana" ;
  either7or_DConj = sd2 "joko" "tai" ** {n = Sg} ;
--  everybody_NP = regNP "everybody" Sg ;
--  every_Det = mkDeterminer Sg "every" ;
--  everything_NP = regNP "everything" Sg ;
  everywhere_Adv = ss "kaikkialla" ;
--  first_Ord = ss "first" ;
  from_Prep = casePrep elative ;
  he_Pron = mkPronoun "hän" "hänen" "häntä"  "hänenä" "häneen" Sg P3 ;
  here_Adv = ss "täällä" ;
  here7to_Adv = ss "tänne" ;
  here7from_Adv = ss "täältä" ;
  how_IAdv = ss "miten" ;
--  how8many_IDet = mkDeterminer Pl ["how many"] ;
  if_Subj = ss "jos" ;
  in8front_Prep = postGenPrep "edessä" ;
  i_Pron  = mkPronoun "minä" "minun" "minua" "minuna" "minuun" Sg P1 ;
  in_Prep = casePrep inessive ;
  it_Pron = {
    s = \\c => MorphoFin.pronSe.s ! npform2case c ; 
    a = agrP3 Sg ; 
    isPron = False
    } ;
  less_CAdv = ss "vähemmän" ;
--  many_Det = mkDeterminer Pl "many" ;
  more_CAdv = ss "enemmän" ;
--  most_Predet = ss "eniten" ;
--  much_Det = mkDeterminer Sg "much" ;
--  must_VV = mkVerb4 "have" "has" "had" "had" ** {c2 = "to"} ; ---
  no_Phr = ss "ei" ;
  on_Prep = casePrep adessive ;
--  one_Quant = mkDeterminer Sg "one" ;
  only_Predet = {s = \\_,_ => "vain"} ;
  or_Conj = ss "tai" ** {n = Sg} ;
  otherwise_PConj = ss "muuten" ;
  part_Prep = casePrep partitive ;
  please_Voc = ss ["ole hyvä"] ; --- number
  possess_Prep = casePrep genitive ;
  quite_Adv = ss "melko" ;
  she_Pron = mkPronoun "hän" "hänen" "häntä"  "hänenä" "häneen" Sg P3 ;
  so_AdA = ss "niin" ;
--  somebody_NP = regNP "somebody" Sg ;
--  someSg_Det = mkDeterminer Sg "some" ;
--  somePl_Det = mkDeterminer Pl "some" ;
--  something_NP = regNP "something" Sg ;
  somewhere_Adv = ss "jossain" ;
--  that_Quant = mkQuant "that" "those" ;
  that_NP = 
    mkPronoun "tuo" "tuon" "tuota" "tuona" "tuohon"  Sg P3 **
    {isPron = False} ;
  there_Adv = ss "siellä" ; --- tuolla
  there7to_Adv = ss "sinne" ;
  there7from_Adv = ss "sieltä" ;
  therefore_PConj = ss "siksi" ;
  they_Pron = mkPronoun "he" "heidän" "heitä" "heinä" "heihin"  Pl P3 ; --- ne
--  this_Quant = mkQuant "this" "these" ;
  this_NP = 
    mkPronoun "tämä" "tämän" "tätä" "tänä" "tähän"  Sg P3 **
    {isPron = False} ;
  those_NP = 
    mkPronoun "nuo" "noiden" "noita" "noina" "noihin"  Pl P3 **
    {isPron = False} ;
  through_Prep = postGenPrep "kautta" ;
  too_AdA = ss "liian" ;
  to_Prep = casePrep illative ; --- allative
  under_Prep = postGenPrep "alla" ;
  very_AdA = ss "erittäin" ;
  want_VV = regV "tahtoa" ;
  we_Pron = mkPronoun "me" "meidän" "meitä" "meinä" "meihin" Pl P1 ;
--  whatPl_IP = mkIP "what" "what" "what's" Sg ;
--  whatSg_IP = mkIP "what" "what" "what's" Sg ;
  when_IAdv = ss "milloin" ;
  when_Subj = ss "kun" ;
  where_IAdv = ss "missä" ;
--  whichPl_IDet = mkDeterminer Pl ["which"] ;
--  whichSg_IDet = mkDeterminer Sg ["which"] ;
--  whoSg_IP = mkIP "who" "whom" "whose" Sg ;
--  whoPl_IP = mkIP "who" "whom" "whose" Pl ;
  why_IAdv = ss "miksi" ;
  without_Prep = prePrep partitive "ilman" ;
  with_Prep = postGenPrep "kanssa" ;
  yes_Phr = ss "kyllä" ;
  youSg_Pron = mkPronoun "sinä" "sinun" "sinua" "sinuna" "sinuun"  Sg P2 ;
  youPl_Pron = mkPronoun "te" "teidän" "teitä" "teinä" "teihin"  Pl P2 ;
  youPol_Pron = mkPronoun "te" "teidän" "teitä" "teinä" "teihin"  Pl P2 ; --- Sg


}

