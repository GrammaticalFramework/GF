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
  almost_AdA, almost_AdN = ssp "ADV" "melkein" ;
  although_Subj = ssp "CONJ" "vaikka" ;
  always_AdV = ssp "ADV" "aina" ;
  and_Conj = {s1 = [] ; s2 = tagPOS "CONJ" "ja" ; n = Pl} ;
  because_Subj = ssp "CONJ" "koska" ;
  before_Prep = prePrep partitive "ennen" ;
  behind_Prep = postGenPrep "takana" ;
  between_Prep = postGenPrep "välissä" ;
  both7and_DConj = sd2 (tagPOS "CONJ" "sekä") (tagPOS "CONJ" "että") ** {n = Pl} ;
  but_PConj = ssp "CONJ" "mutta" ;
  by8agent_Prep = postGenPrep "toimesta" ;
  by8means_Prep = casePrep adessive ;
  can8know_VV = mkVV (mkV "osata" "osasi") ;
  can_VV = mkVV (mkV "voida" "voi") ;
  during_Prep = postGenPrep "aikana" ;
  either7or_DConj = sd2 (tagPOS "CONJ" "joko") (tagPOS "CONJ" "tai") ** {n = Sg} ;
  everybody_NP = lin NP (makeNP (((mkN "jokainen"))) Sg) ; --UD
  every_Det = MorphoFin.mkDet Sg (snoun2nounBind (mkN "jokainen")) ; --UD
  everything_NP = makeNP ((((mkN "kaikki" "kaiken" "kaikkena")))) Sg ;
  everywhere_Adv = mkAdv "kaikkialla" ; --UD
  few_Det  = MorphoFin.mkDet Sg (snoun2nounBind (mkN "harva")) ; --UD
---  first_Ord = {s = \\n,c => (mkN "ensimmäinen").s ! NCase n c} ;
  for_Prep = casePrep allative ;
  from_Prep = casePrep elative ;
  he_Pron = mkPersonPronoun "hän" "hänen" "häntä"  "hänenä" "häneen" Sg P3 ;
  here_Adv = mkAdv "täällä" ;
  here7to_Adv = mkAdv "tänne" ;
  here7from_Adv = mkAdv "täältä" ;
  how_IAdv = ssp "ADV" "miten" ;
  how8much_IAdv = ssp "ADV" ("kuinka" ++ tagPOS "ADV" "paljon") ;
  how8many_IDet = 
    {s = \\c => "kuinka" ++ (snoun2nounBind (mkN "moni" "monia")).s ! NCase Sg c ; n = Sg ; isNum = False} ;
  if_Subj = ssp "CONJ" "jos" ;
  in8front_Prep = postGenPrep "edessä" ;
  i_Pron  = mkPersonPronoun "minä" "minun" "minua" "minuna" "minuun" Sg P1 ;
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
  much_Det = MorphoFin.mkDet Sg (snoun2nounBind (exceptNomN (mkN "paljo") "paljon")) ** {isNum = True} ; --Harmony not relevant, it's just a CommonNoun
  must_VV = mkVV (caseV genitive (mkV "täytyä")) ;
  no_Utt = ssp "INTERJ" "ei" ;
  on_Prep = casePrep adessive ;
---  one_Quant = MorphoFin.mkDet Sg  DEPREC
  only_Predet = {s = \\_,_ => "vain"} ;
  or_Conj = {s1 = [] ; s2 = tagPOS "CONJ" "tai" ; n = Sg} ;
  otherwise_PConj = ssp "ADV" "muuten" ;
  part_Prep = casePrep partitive ;
  please_Voc = ss ["ole hyvä"] ; --- number
  possess_Prep = casePrep genitive ;
  quite_Adv = ssp "ADV" "melko" ;
  she_Pron = mkPersonPronoun "hän" "hänen" "häntä"  "hänenä" "häneen" Sg P3 ;
  so_AdA = ssp "ADV" "niin" ;
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
  somewhere_Adv = ssp "ADV" "jossain" ;
  that_Quant = heavyQuant {
    s1 = table (MorphoFin.Number) {
          Sg => table (MorphoFin.Case) {
            c => (mkPersonPronoun "tuo" "tuon" "tuota" "tuona" "tuohon" Sg P3).s ! NPCase c
            } ;
          Pl => table (MorphoFin.Case) {
            c => (mkPersonPronoun "nuo" "noiden" "noita" "noina" "noihin" Sg P3).s ! NPCase c
            }
          } ;
    s2 = \\_ => [] ; isNum,isPoss = False ; isDef = True  ; isNeg = False 
    } ;
  that_Subj = ssp "CONJ" "että" ;
  there_Adv = ssp "ADV" "siellä" ; --- tuolla
  there7to_Adv = ssp "ADV" "sinne" ;
  there7from_Adv = ssp "ADV" "sieltä" ;
  therefore_PConj = ssp "ADV" "siksi" ;
  they_Pron = mkPersonPronoun "he" "heidän" "heitä" "heinä" "heihin"  Pl P3 ; --- ne
  this_Quant = heavyQuant {
    s1 = table (MorphoFin.Number) {
          Sg => table (MorphoFin.Case) {
            c => (mkPersonPronoun "tämä" "tämän" "tätä" "tänä" "tähän" Sg P3).s ! NPCase c
            } ;
          Pl => table (MorphoFin.Case) {
            c => (mkPersonPronoun "nämä" "näiden" "näitä" "näinä" "näihin" Sg P3).s ! NPCase c
            }
          } ;
    s2 = \\_ => [] ; isNum,isPoss = False ; isDef = True  ; isNeg = False
    } ;
  through_Prep = postGenPrep "kautta" ;
  too_AdA = ssp "ADV" "liian" ;
  to_Prep = casePrep illative ; --- allative
  under_Prep = postGenPrep "alla" ;
  very_AdA = ssp "ADV" "erittäin" ;
  want_VV = mkVV (mkV "tahtoa") ;
  we_Pron = mkPersonPronoun "me" "meidän" "meitä" "meinä" "meihin" Pl P1 ;
  whatPl_IP = {
    s = table {NPAcc => "mitkä" ; c => mikaInt ! Pl ! npform2case Pl c} ;
    n = Pl
    } ;
  whatSg_IP = {
    s = \\c => mikaInt ! Sg ! npform2case Sg c ;
    n = Sg
    } ;
  when_IAdv = ssp "ADV" "milloin" ;
  when_Subj = ssp "CONJ" "kun" ;
  where_IAdv = ssp "ADV" "missä" ;
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
  why_IAdv = ssp "ADV" "miksi" ;
  without_Prep = prePrep partitive "ilman" ;
  with_Prep = postGenPrep "kanssa" ;
  yes_Utt = ssp "INTERJ" "kyllä" ;
  youSg_Pron = mkPersonPronoun "sinä" "sinun" "sinua" "sinuna" "sinuun"  Sg P2 ;
  youPl_Pron = mkPersonPronoun "te" "teidän" "teitä" "teinä" "teihin"  Pl P2 ;
  youPol_Pron = 
    let p = mkPersonPronoun "te" "teidän" "teitä" "teinä" "teihin"  Pl P2 in
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

  at_least_AdN = ssp "ADV" "vähintään" ;
  at_most_AdN = ssp "ADV" "enintään" ;

  as_CAdv = X.mkCAdv "yhtä" "kuin" ;

  except_Prep = postPrep partitive "lukuunottamatta" ;

  have_V2 = mkV2 (caseV adessive vOlla) ;

  lin language_title_Utt = ss "suomi" ;

oper
  ssp : Str -> Str -> {s : Str} = \p,s -> ss (tagPOS p s) ; -- used in tagged/ for Omorfi, otherwise =ss

  mkPersonPronoun : (_,_,_,_,_ : Str) ->  Number -> Person -> Pron = \a,b,c,d,e,n,p ->
    lin Pron (MorphoFin.mkPronoun a b c d e n p) ;
}

