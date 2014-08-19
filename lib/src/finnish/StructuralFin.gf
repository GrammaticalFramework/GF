concrete StructuralFin of Structural = CatFin ** 
  open MorphoFin, ParadigmsFin, (X = ConstructX), StemFin, Prelude in {

  flags optimize=all ;
    coding=utf8 ;

  lin
  above_Prep = postGenPrep "yläpuolella" ;
  after_Prep = postGenPrep "jälkeen" ;

  all_Predet = {s = \\n,c => 
    let
      kaiket = caseTable n (snoun2nounBind (mkN "kaikki" "kaiken" "kaikkena"))
    in
    case npform2case n c of {
      Nom => "kaikki" ;
      k => kaiket ! k
      }
    } ;
  almost_AdA, almost_AdN = ss "melkein" ;
  although_Subj = ss "vaikka" ;
  always_AdV = ss "aina" ;
  and_Conj = {s1 = [] ; s2 = "ja" ; n = Pl} ;
  because_Subj = ss "koska" ;
  before_Prep = prePrep partitive "ennen" ;
  behind_Prep = postGenPrep "takana" ;
  between_Prep = postGenPrep "välissä" ;
  both7and_DConj = sd2 "sekä" "että" ** {n = Pl} ;
  but_PConj = ss "mutta" ;
  by8agent_Prep = postGenPrep "toimesta" ;
  by8means_Prep = casePrep adessive ;
  can8know_VV = mkVV (mkV "osata" "osasi") ;
  can_VV = mkVV (mkV "voida" "voi") ;
  during_Prep = postGenPrep "aikana" ;
  either7or_DConj = sd2 "joko" "tai" ** {n = Sg} ;
  everybody_NP = lin NP (makeNP (((mkN "jokainen"))) Sg) ;
  every_Det = MorphoFin.mkDet Sg (snoun2nounBind (mkN "jokainen")) ;
  everything_NP = makeNP ((((mkN "kaikki" "kaiken" "kaikkena")))) Sg ;
  everywhere_Adv = ss "kaikkialla" ;
  few_Det  = MorphoFin.mkDet Sg (snoun2nounBind (mkN "harva")) ;
---  first_Ord = {s = \\n,c => (mkN "ensimmäinen").s ! NCase n c} ;
  for_Prep = casePrep allative ;
  from_Prep = casePrep elative ;
  he_Pron = mkPronoun "hän" "hänen" "häntä"  "hänenä" "häneen" Sg P3 ;
  here_Adv = ss "täällä" ;
  here7to_Adv = ss "tänne" ;
  here7from_Adv = ss "täältä" ;
  how_IAdv = ss "miten" ;
  how8much_IAdv = ss "kuinka paljon" ;
  how8many_IDet = 
    {s = \\c => "kuinka" ++ (snoun2nounBind (mkN "moni" "monia")).s ! NCase Sg c ; n = Sg ; isNum = False} ;
  if_Subj = ss "jos" ;
  in8front_Prep = postGenPrep "edessä" ;
  i_Pron  = mkPronoun "minä" "minun" "minua" "minuna" "minuun" Sg P1 ;
  in_Prep = casePrep inessive ;
  it_Pron = {
    s = \\c => pronSe.s ! npform2case Sg c ; 
    a = agrP3 Sg ; 
    hasPoss = False ;
    poss = "sen" ;
    } ;
  less_CAdv = X.mkCAdv "vähemmän" "kuin" ;
  many_Det = MorphoFin.mkDet Sg (snoun2nounBind (mkN "moni" "monia")) ;
  more_CAdv = X.mkCAdv "enemmän" "kuin" ;
  most_Predet = {s = \\n,c => (nForms2N (dSuurin "useinta")).s ! NCase n (npform2case n c)} ;
  much_Det = MorphoFin.mkDet Sg {s = \\_ => "paljon" ; h = Back} ; --Harmony not relevant, it's just a CommonNoun
  must_VV = mkVV (caseV genitive (mkV "täytyä")) ;
  no_Utt = ss "ei" ;
  on_Prep = casePrep adessive ;
---  one_Quant = MorphoFin.mkDet Sg  DEPREC
  only_Predet = {s = \\_,_ => "vain"} ;
  or_Conj = {s1 = [] ; s2 = "tai" ; n = Sg} ;
  otherwise_PConj = ss "muuten" ;
  part_Prep = casePrep partitive ;
  please_Voc = ss ["ole hyvä"] ; --- number
  possess_Prep = casePrep genitive ;
  quite_Adv = ss "melko" ;
  she_Pron = mkPronoun "hän" "hänen" "häntä"  "hänenä" "häneen" Sg P3 ;
  so_AdA = ss "niin" ;
  somebody_NP = {
    s = \\c => jokuPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ; 
    isPron = False ; isNeg = False
    } ;
  someSg_Det = heavyDet {
    s1 = jokuPron ! Sg ;
    s2 = \\_ => [] ;
    isNum,isPoss = False ; isDef = True ; isNeg = False ; n = Sg
    } ;
  somePl_Det = heavyDet {
    s1 = jokuPron ! Pl ;
    s2 = \\_ => [] ; isNum,isPoss = False ; isNeg = False ; isDef = True ; 
    n = Pl ; isNeg = False
    } ;
  something_NP = {
    s = \\c => jokinPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ; 
    isPron = False ; isNeg = False ; isNeg = False
    } ;
  somewhere_Adv = ss "jossain" ;
  that_Quant = heavyQuant {
    s1 = table (MorphoFin.Number) {
          Sg => table (MorphoFin.Case) {
            c => (mkPronoun "tuo" "tuon" "tuota" "tuona" "tuohon" Sg P3).s ! NPCase c
            } ;
          Pl => table (MorphoFin.Case) {
            c => (mkPronoun "nuo" "noiden" "noita" "noina" "noihin" Sg P3).s ! NPCase c
            }
          } ;
    s2 = \\_ => [] ; isNum,isPoss = False ; isDef = True  ; isNeg = False 
    } ;
  that_Subj = ss "että" ;
  there_Adv = ss "siellä" ; --- tuolla
  there7to_Adv = ss "sinne" ;
  there7from_Adv = ss "sieltä" ;
  therefore_PConj = ss "siksi" ;
  they_Pron = mkPronoun "he" "heidän" "heitä" "heinä" "heihin"  Pl P3 ; --- ne
  this_Quant = heavyQuant {
    s1 = table (MorphoFin.Number) {
          Sg => table (MorphoFin.Case) {
            c => (mkPronoun "tämä" "tämän" "tätä" "tänä" "tähän" Sg P3).s ! NPCase c
            } ;
          Pl => table (MorphoFin.Case) {
            c => (mkPronoun "nämä" "näiden" "näitä" "näinä" "näihin" Sg P3).s ! NPCase c
            }
          } ;
    s2 = \\_ => [] ; isNum,isPoss = False ; isDef = True  ; isNeg = False
    } ;
  through_Prep = postGenPrep "kautta" ;
  too_AdA = ss "liian" ;
  to_Prep = casePrep illative ; --- allative
  under_Prep = postGenPrep "alla" ;
  very_AdA = ss "erittäin" ;
  want_VV = mkVV (mkV "tahtoa") ;
  we_Pron = mkPronoun "me" "meidän" "meitä" "meinä" "meihin" Pl P1 ;
  whatPl_IP = {
    s = table {NPAcc => "mitkä" ; c => mikaInt ! Pl ! npform2case Pl c} ;
    n = Pl
    } ;
  whatSg_IP = {
    s = \\c => mikaInt ! Sg ! npform2case Sg c ;
    n = Sg
    } ;
  when_IAdv = ss "milloin" ;
  when_Subj = ss "kun" ;
  where_IAdv = ss "missä" ;
  which_IQuant = {
    s = mikaInt
    } ;
  whoSg_IP = {
    s = table {NPAcc => "kenet" ; c => kukaInt ! Sg ! npform2case Sg c} ;
    n = Sg
    } ;
  whoPl_IP = {
    s = table {NPAcc => "ketkä" ; c => kukaInt ! Pl ! npform2case Pl c} ;
    n = Pl
    } ;
  why_IAdv = ss "miksi" ;
  without_Prep = prePrep partitive "ilman" ;
  with_Prep = postGenPrep "kanssa" ;
  yes_Utt = ss "kyllä" ;
  youSg_Pron = mkPronoun "sinä" "sinun" "sinua" "sinuna" "sinuun"  Sg P2 ;
  youPl_Pron = mkPronoun "te" "teidän" "teitä" "teinä" "teihin"  Pl P2 ;
  youPol_Pron = 
    let p = mkPronoun "te" "teidän" "teitä" "teinä" "teihin"  Pl P2 in
    {s = p.s ; a = AgPol ; hasPoss = True ; poss = p.poss} ;

oper
  jokuPron : MorphoFin.Number => (MorphoFin.Case) => Str =
    let 
      kui = snoun2nounBind (mkN "kuu") 
    in
    table {
      Sg => table {
        Nom => "joku" ;
        Gen => "jonkun" ;
        c => relPron ! Sg ! c + "ku" + Predef.drop 3 (kui.s ! NCase Sg c)
       } ; 
      Pl => table {
        Nom => "jotkut" ;
        c => relPron ! Pl ! c + kui.s ! NCase Pl c
        }
      } ;

  jokinPron : MorphoFin.Number => (MorphoFin.Case) => Str =
    table {
      Sg => table {
        Nom => "jokin" ;
        Gen => "jonkin" ;
        c => relPron ! Sg ! c + "kin"
       } ; 
      Pl => table {
        Nom => "jotkin" ;
        c => relPron ! Pl ! c + "kin"
        }
      } ;

  mikaInt : MorphoFin.Number => (MorphoFin.Case) => Str = 
    let {
      mi  = snoun2nounBind (mkN "mi")
    } in
    table {
      Sg => table {
        Nom => "mikä" ;
        Gen => "minkä" ;
        Part => "mitä" ;
        Illat => "mihin" ;
        c   => mi.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "mitkä" ;
        Gen => "minkä" ;
        Part => "mitä" ;
        Illat => "mihin" ;
        c   => mi.s ! NCase Sg c
        }
      } ;

  kukaInt : MorphoFin.Number => (MorphoFin.Case) => Str = 
    let 
      kuka = snoun2nounBind (mkN "kuka" "kenen" "ketä" "kenä" "keneen" 
                 "keiden" "keitä" "keinä" "keissä" "keihin") ;
    in
    table {
      Sg => table {
        c   => kuka.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "ketkä" ;
        c   => kuka.s ! NCase Pl c
        }
      } ;
  mikaanPron : MorphoFin.Number => (MorphoFin.Case) => Str = \\n,c =>
    case <n,c> of {
        <Sg,Nom> => "mikään" ;
        <_,Part> => "mitään" ;
        <Sg,Gen> => "minkään" ;
        <Pl,Nom> => "mitkään" ;
        <Pl,Gen> => "mittenkään" ;
        <_,Ess>  => "minään" ;
        <_,Iness> => "missään" ;
        <_,Elat> => "mistään" ;
        <_,Adess> => "millään" ;
        <_,Ablat> => "miltään" ;
        _   => mikaInt ! n ! c + "kään"
       } ; 

  kukaanPron : MorphoFin.Number => (MorphoFin.Case) => Str =
    table {
      Sg => table {
        Nom => "kukaan" ;
        Part => "ketään" ;
        Ess => "kenään" ;
        Iness => "kessään" ;
        Elat  => "kestään" ;
        Illat => "kehenkään" ;
        Adess => "kellään" ;
        Ablat => "keltään" ;
        c   => kukaInt ! Sg ! c + "kään"
       } ; 
      Pl => table {
        Nom => "ketkään" ;
        Part => "keitään" ;
        Ess => "keinään" ;
        Iness => "keissään" ;
        Elat => "keistään" ;
        Adess => "keillään" ;
        Ablat => "keiltään" ;
        c   => kukaInt ! Pl ! c + "kään"
        }
      } ;

oper
  makeNP  : SNoun -> MorphoFin.Number -> CatFin.NP ; 
  makeNP noun num = {
    s = \\c => (snoun2nounBind noun).s ! NCase num (npform2case num c) ; 
    a = agrP3 num ;
    isPron, isNeg = False ;
    lock_NP = <>
    } ;

lin
  not_Predet = {s = \\_,_ => "ei"} ;

  no_Quant = heavyQuant {
    s1 = \\n,c => mikaanPron ! n ! c ;  -- requires negative or question polarity
    s2 = \\_ => [] ; isNum,isPoss = False ; isDef = True ; isNeg = True
    } ;

  if_then_Conj = {s1 = "jos" ; s2 = "niin" ; n = Sg} ;
  nobody_NP = {
    s = \\c => kukaanPron ! Sg ! npform2case Sg c ; --- requires negative polarity
    a = agrP3 Sg ; 
    isPron = False ; isNeg = True
    } ;

  nothing_NP = {
    s = \\c => mikaanPron ! Sg ! npform2case Sg c ; --- requires negative polarity
    a = agrP3 Sg ; 
    isPron = False ; isNeg = True
    } ;

  at_least_AdN = ss "vähintään" ;
  at_most_AdN = ss "enintään" ;

  as_CAdv = X.mkCAdv "yhtä" "kuin" ;

  except_Prep = postPrep partitive "lukuunottamatta" ;

  have_V2 = mkV2 (caseV adessive vOlla) ;

  lin language_title_Utt = ss "suomi" ;

}

