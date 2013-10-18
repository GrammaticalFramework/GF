concrete StructuralEst of Structural = CatEst **
  open MorphoEst, ParadigmsEst, (X = ConstructX), MakeStructuralEst, Prelude in {

  flags optimize=all ; coding=utf8 ;

  lin
  above_Prep = postGenPrep "peal" ;
  after_Prep = postGenPrep "järel" ;

  all_Predet = {s = \\n,c =>
    let
      kaiket = caseTable n (mkN "kõik")
    in
    case npform2case n c of {
      Nom => "kõik" ;
      k => kaiket ! k
      }
    } ;
  almost_AdA, almost_AdN = ss "peaaegu" ;
  although_Subj = ss "kuigi" ;
  always_AdV = ss "alati" ;
  and_Conj = {s1 = [] ; s2 = "ja" ; n = Pl} ;
  because_Subj = ss "sellepärast" ;
  before_Prep = prePrep partitive "enne" ;
  behind_Prep = postGenPrep "taga" ;
  between_Prep = postGenPrep "vahel" ;
  both7and_DConj = sd2 "nii" "kui ka" ** {n = Pl} ;
  but_PConj = ss "aga" ;
  by8agent_Prep = postGenPrep "poolt" ;
  by8means_Prep = casePrep adessive ;
  can8know_VV = mkVV (mkV "oskama" "osata") ;
  can_VV = mkVV (mkV "võima" "võida") ;
  during_Prep = postGenPrep "ajal" ;
  either7or_DConj = sd2 "kas" "või" ** {n = Sg} ;
  everybody_NP = makeNP (mkN "igaüks") Sg ;
  every_Det = mkDet Sg (mkN "iga") ;
  everything_NP = makeNP ((mkN "kõik") ** {lock_N = <>}) Sg ;
  everywhere_Adv = ss "kõikjal" ;
  few_Det = mkDet Sg (mkN "mõni") ;
---  first_Ord = {s = \\n,c => (mkN "ensimmäinen").s ! NCase n c} ;
  for_Prep = casePrep allative ;
  from_Prep = casePrep elative ;
  he_Pron = mkPronoun "tema" "tema" "teda" Sg P3 ;
  here_Adv = ss "siin" ;
  here7to_Adv = ss "siia" ;
  here7from_Adv = ss "siit" ;
  how_IAdv = ss "kuidas" ;
  how8much_IAdv = ss "kui palju" ;
  how8many_IDet = {
    s = \\c => "kui" ++ (mkN "mitu" "mitme" "mitut" "TODO" "TODO" "TODO").s ! NCase Sg c ;
    n = Sg ;
    isNum = False
  } ;
  if_Subj = ss "kui" ;
  in8front_Prep = postGenPrep "ees" ;
  i_Pron  = mkPronoun "mina" "minu" "mind" Sg P1 ;
  in_Prep = casePrep inessive ;
  it_Pron = {
    s = \\c => pronSe.s ! npform2case Sg c ;
    a = agrP3 Sg ;
    isPron = False
    } ;
  less_CAdv = X.mkCAdv "vähem" "kui" ;
  many_Det = mkDet Sg (mkN "mitu") ;
  more_CAdv = X.mkCAdv "rohkem" "kui" ;
  most_Predet = {s = \\n,c => (nForms2N (dSuurin "MOST")).s ! NCase n (npform2case n c)} ;
  much_Det = mkDet Sg {s = \\_ => "palju"} ;
  must_VV = mkVVf (mkV "pidama" "pidada" "peab" "peetakse" "pidage" "pidi" "pidanud" "peetud") infMa ;
  no_Utt = ss "ei" ;
  on_Prep = casePrep adessive ;
---  one_Quant = mkDet Sg  DEPREC
  only_Predet = {s = \\_,_ => "ainult"} ;
  or_Conj = {s1 = [] ; s2 = "või" ; n = Pl} ;
  otherwise_PConj = ss "muidu" ;
  part_Prep = casePrep partitive ;
  please_Voc = ss ["palun"] ; --- number
  possess_Prep = casePrep genitive ;
  quite_Adv = ss "üsna" ;
  she_Pron = mkPronoun "tema" "tema" "teda" Sg P3 ;
  so_AdA = ss "nii" ;
  somebody_NP = {
    s = \\c => jokuPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ;
    isPron = False
    } ;
  someSg_Det = heavyDet {
    s = jokuPron ! Sg ;
    isNum = False ; isDef = True ; n = Sg
    } ;
  somePl_Det = heavyDet {
    s = jokuPron ! Pl ;
    isNum = False ; isDef = True ;
    n = Pl
    } ;
  something_NP = {
    s = \\c => mikaInt ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ;
    isPron = False
    } ;
  somewhere_Adv = ss "kuskil" ;
  that_Quant = heavyQuant {
    s = table (MorphoEst.Number) {
          Sg => table (MorphoEst.Case) {
            c => (mkPronoun "too" "tolle" "toda" Sg P3).s ! NPCase c
            } ;
          Pl => table (MorphoEst.Case) {
            c => (mkPronoun "nood" "nonde" "noid" Sg P3).s ! NPCase c
            }
          } ;
    isNum = False ; isDef = True ;
    } ;
  that_Subj = ss "et" ;
  there_Adv = ss "seal" ;
  there7to_Adv = ss "sinna" ;
  there7from_Adv = ss "sealt" ;
  therefore_PConj = ss "sellepärast" ;
  they_Pron = mkPronoun "nemad" "nende" "neid" Pl P3 ;
  this_Quant = heavyQuant {
    s = table (MorphoEst.Number) {
          Sg => table (MorphoEst.Case) {
            c => (mkPronoun "see" "selle" "seda" Sg P3).s ! NPCase c
            } ;
          Pl => table (MorphoEst.Case) {
            c => (mkPronoun "need" "nende" "neid" Sg P3).s ! NPCase c
            }
          } ;
    isNum = False ; isDef = True ;
    } ;
  through_Prep = postGenPrep "kaudu" ;
  too_AdA = ss "liiga" ;
  to_Prep = casePrep allative ;
  under_Prep = postGenPrep "all" ;
  very_AdA = ss "väga" ;
  want_VV = mkVV (mkV "tahtma") ;
  we_Pron = mkPronoun "meie" "meie" "meid" Pl P1 ;
  whatPl_IP = {
    s = table {NPAcc => "mida" ; c => mikaInt ! Pl ! npform2case Pl c} ;
    n = Pl
    } ;
  whatSg_IP = {
    s = \\c => mikaInt ! Sg ! npform2case Sg c ;
    n = Sg
    } ;
  when_IAdv = ss "kui" ;
  when_Subj = ss "kui" ;
  where_IAdv = ss "kus" ;
  which_IQuant = { s = mikaInt } ;
  whoSg_IP = {
    s = table {NPAcc => "keda" ; c => kukaInt ! Sg ! npform2case Sg c} ;
    n = Sg
    } ;
  whoPl_IP = {
    s = table {NPAcc => "keda" ; c => kukaInt ! Pl ! npform2case Pl c} ;
    n = Pl
    } ;
  why_IAdv = ss "miks" ;
  without_Prep = prePrep partitive "ilma" ;
  with_Prep = prePrep comitative "koos" ;
  yes_Utt = ss "jah" ;
  youSg_Pron = mkPronoun "sina" "sinu" "sind" Sg P2 ;
  youPl_Pron = mkPronoun "teie" "teie" "teid" Pl P2 ;
  youPol_Pron =
    let p = mkPronoun "teie" "teie" "teid" Pl P2 in
    {s = p.s ; a = AgPol} ;

oper
  jokuPron : MorphoEst.Number => (MorphoEst.Case) => Str =
    let
      keegi = mkN "keegi" "kellegi" "kedagi" "kellegisse" "kellegi" "kedagi"
    in
    table {
      Sg => table {
        c => keegi.s ! NCase Sg c
       } ;
      Pl => table {
        c => keegi.s ! NCase Sg c
        }
      } ;

  -- TODO: maybe remove
  jokinPron : MorphoEst.Number => (MorphoEst.Case) => Str =
    table {
      Sg => table {
        Nom => "miski" ;
        Iness => "milleski" ;
        Elat => "millestki" ;
        Ablat => "milleltki" ;
        Transl => "millekski" ;
        c => mikaInt ! Sg ! c + "gi"
       } ;
      Pl => table { --TODO correct these plurals
        Nom => "miski" ;
        Iness => "milleski" ;
        Elat => "millestki" ;
        Ablat => "milleltki" ;
        Transl => "millekski" ;
        c => mikaInt ! Pl ! c + "gi"
        }
      } ;

  --TODO does this work?
  mikaInt : MorphoEst.Number => (MorphoEst.Case) => Str =
    let {
      mi  = mkN "mille"
    } in
    table {
      Sg => table {
        Nom => "mis" ;
        Gen => "mille" ;
        Part => "mida" ;
        c   => mi.s ! NCase Sg c
       } ;
      Pl => table {
        Nom => "mis" ;
        Gen => "mille" ;
        Part => "mida" ;
        c   => mi.s ! NCase Pl c
        }
      } ;

  kukaInt : MorphoEst.Number => (MorphoEst.Case) => Str =
    let
      kuka = mkN "kes" "kelle" "keda" "kellesse"
                 "kellede" "keda" ;
    in
    table {
      Sg => table {
        c   => kuka.s ! NCase Sg c
       } ;
      Pl => table {
        Nom => "kes" ;
        c   => kuka.s ! NCase Pl c
        }
      } ;
  mikaanPron : MorphoEst.Number => (MorphoEst.Case) => Str = \\n,c =>
    case <n,c> of {
        <_,Nom> => "ükski" ;
        <_,Part> => "ühtegi" ;
        <_,Gen> => "ühegi" ;
        _   => mikaInt ! n ! c + "gi" ----ki
       } ;

  kukaanPron : MorphoEst.Number => (MorphoEst.Case) => Str =
    table {
      Sg => table {
        Nom => "keegi" ;
        Part => "kedagi" ;
        c   => kukaInt ! Sg ! c + "gi"
       } ;
      Pl => table {
        Nom => "ketkään" ;
        Part => "keitään" ;
        c   => kukaInt ! Pl ! c + "gi"
        }
      } ;


oper
  makeNP  : N -> MorphoEst.Number -> CatEst.NP ;
  makeNP noun num = {
    s = \\c => noun.s ! NCase num (npform2case num c) ;
    a = agrP3 num ;
    isPron = False ;
    lock_NP = <>
    } ;

lin
  not_Predet = {s = \\_,_ => "ei"} ;

  no_Quant = heavyQuant {
    s = \\n,c => "mitte" ++ mikaanPron ! n ! c ;
    isNum = False ; isDef = True ;
    } ;

  if_then_Conj = {s1 = "kui" ; s2 = "siis" ; n = Sg} ;
  nobody_NP = {
    s = \\c => "mitte" ++ kukaanPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ;
    isPron = False
    } ;

  nothing_NP = {
    s = \\c => "mitte" ++ mikaanPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ;
    isPron = False
    } ;

  at_least_AdN = ss "vähemalt" ;
  at_most_AdN = ss "kuni" ;

  as_CAdv = X.mkCAdv "sama palju" "kui" ;

  except_Prep = postPrep partitive "väljaarvatud" ;

  have_V2 = mkV2 (caseV adessive vOlema) ;

  -- Kaarel: TODO: not sure what this is...
  -- Name of the language in that language, s/suomi/eesti/ :--P
  lin language_title_Utt = ss "eesti" ;

}

