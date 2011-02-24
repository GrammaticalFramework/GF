concrete StructuralFin of Structural = CatFin ** 
  open MorphoFin, ParadigmsFin, (X = ConstructX), MakeStructuralFin, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = postGenPrep "yl‰puolella" ;
  after_Prep = postGenPrep "j‰lkeen" ;

  all_Predet = {s = \\n,c => 
    let
      kaiket = caseTable n ((mkN "kaikki" "kaiken" "kaikkena"))
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
  between_Prep = postGenPrep "v‰liss‰" ;
  both7and_DConj = sd2 "sek‰" "ett‰" ** {n = Pl} ;
  but_PConj = ss "mutta" ;
  by8agent_Prep = postGenPrep "toimesta" ;
  by8means_Prep = casePrep adessive ;
  can8know_VV = mkVV (mkV "osata" "osasi") ;
  can_VV = mkVV (mkV "voida" "voi") ;
  during_Prep = postGenPrep "aikana" ;
  either7or_DConj = sd2 "joko" "tai" ** {n = Sg} ;
  everybody_NP = makeNP (mkN "jokainen") Sg ;
  every_Det = mkDet Sg (mkN "jokainen") ;
  everything_NP = makeNP (((mkN "kaikki" "kaiken" "kaikkena")) **
    {lock_N = <>}) Sg ;
  everywhere_Adv = ss "kaikkialla" ;
  few_Det  = mkDet Sg (mkN "harva") ;
---  first_Ord = {s = \\n,c => (mkN "ensimm‰inen").s ! NCase n c} ;
  for_Prep = casePrep allative ;
  from_Prep = casePrep elative ;
  he_Pron = mkPronoun "h‰n" "h‰nen" "h‰nt‰"  "h‰nen‰" "h‰neen" Sg P3 ;
  here_Adv = ss "t‰‰ll‰" ;
  here7to_Adv = ss "t‰nne" ;
  here7from_Adv = ss "t‰‰lt‰" ;
  how_IAdv = ss "miten" ;
  how8much_IAdv = ss "kuinka paljon" ;
  how8many_IDet = 
    {s = \\c => "kuinka" ++ (mkN "moni" "monia").s ! NCase Sg c ; n = Sg ; isNum = False} ;
  if_Subj = ss "jos" ;
  in8front_Prep = postGenPrep "edess‰" ;
  i_Pron  = mkPronoun "min‰" "minun" "minua" "minuna" "minuun" Sg P1 ;
  in_Prep = casePrep inessive ;
  it_Pron = {
    s = \\c => pronSe.s ! npform2case Sg c ; 
    a = agrP3 Sg ; 
    isPron = False
    } ;
  less_CAdv = X.mkCAdv "v‰hemm‰n" "kuin" ;
  many_Det = mkDet Sg (mkN "moni" "monia") ;
  more_CAdv = X.mkCAdv "enemm‰n" "kuin" ;
  most_Predet = {s = \\n,c => (nForms2N (dSuurin "useinta")).s ! NCase n (npform2case n c)} ;
  much_Det = mkDet Sg {s = \\_ => "paljon"} ;
  must_VV = mkVV (caseV genitive (mkV "t‰yty‰")) ;
  no_Utt = ss "ei" ;
  on_Prep = casePrep adessive ;
---  one_Quant = mkDet Sg  DEPREC
  only_Predet = {s = \\_,_ => "vain"} ;
  or_Conj = {s1 = [] ; s2 = "tai" ; n = Pl} ;
  otherwise_PConj = ss "muuten" ;
  part_Prep = casePrep partitive ;
  please_Voc = ss ["ole hyv‰"] ; --- number
  possess_Prep = casePrep genitive ;
  quite_Adv = ss "melko" ;
  she_Pron = mkPronoun "h‰n" "h‰nen" "h‰nt‰"  "h‰nen‰" "h‰neen" Sg P3 ;
  so_AdA = ss "niin" ;
  somebody_NP = {
    s = \\c => jokuPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ; 
    isPron = False
    } ;
  someSg_Det = heavyDet {
    s1 = jokuPron ! Sg ;
    s2 = [] ;
    isNum,isPoss = False ; isDef = True ; n = Sg
    } ;
  somePl_Det = heavyDet {
    s1 = jokuPron ! Pl ;
    s2 = [] ; isNum,isPoss = False ; isDef = True ; 
    n = Pl
    } ;
  something_NP = {
    s = \\c => jokinPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ; 
    isPron = False
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
    s2 = [] ; isNum,isPoss = False ; isDef = True ; 
    } ;
  that_Subj = ss "ett‰" ;
  there_Adv = ss "siell‰" ; --- tuolla
  there7to_Adv = ss "sinne" ;
  there7from_Adv = ss "sielt‰" ;
  therefore_PConj = ss "siksi" ;
  they_Pron = mkPronoun "he" "heid‰n" "heit‰" "hein‰" "heihin"  Pl P3 ; --- ne
  this_Quant = heavyQuant {
    s1 = table (MorphoFin.Number) {
          Sg => table (MorphoFin.Case) {
            c => (mkPronoun "t‰m‰" "t‰m‰n" "t‰t‰" "t‰n‰" "t‰h‰n" Sg P3).s ! NPCase c
            } ;
          Pl => table (MorphoFin.Case) {
            c => (mkPronoun "n‰m‰" "n‰iden" "n‰it‰" "n‰in‰" "n‰ihin" Sg P3).s ! NPCase c
            }
          } ;
    s2 = [] ; isNum,isPoss = False ; isDef = True ; 
    } ;
  through_Prep = postGenPrep "kautta" ;
  too_AdA = ss "liian" ;
  to_Prep = casePrep illative ; --- allative
  under_Prep = postGenPrep "alla" ;
  very_AdA = ss "eritt‰in" ;
  want_VV = mkVV (mkV "tahtoa") ;
  we_Pron = mkPronoun "me" "meid‰n" "meit‰" "mein‰" "meihin" Pl P1 ;
  whatPl_IP = {
    s = table {NPAcc => "mitk‰" ; c => mikaInt ! Pl ! npform2case Pl c} ;
    n = Pl
    } ;
  whatSg_IP = {
    s = \\c => mikaInt ! Sg ! npform2case Sg c ;
    n = Sg
    } ;
  when_IAdv = ss "milloin" ;
  when_Subj = ss "kun" ;
  where_IAdv = ss "miss‰" ;
  which_IQuant = {
    s = mikaInt
    } ;
  whoSg_IP = {
    s = table {NPAcc => "kenet" ; c => kukaInt ! Sg ! npform2case Sg c} ;
    n = Sg
    } ;
  whoPl_IP = {
    s = table {NPAcc => "ketk‰" ; c => kukaInt ! Pl ! npform2case Pl c} ;
    n = Pl
    } ;
  why_IAdv = ss "miksi" ;
  without_Prep = prePrep partitive "ilman" ;
  with_Prep = postGenPrep "kanssa" ;
  yes_Utt = ss "kyll‰" ;
  youSg_Pron = mkPronoun "sin‰" "sinun" "sinua" "sinuna" "sinuun"  Sg P2 ;
  youPl_Pron = mkPronoun "te" "teid‰n" "teit‰" "tein‰" "teihin"  Pl P2 ;
  youPol_Pron = 
    let p = mkPronoun "te" "teid‰n" "teit‰" "tein‰" "teihin"  Pl P2 in
    {s = p.s ; a = AgPol} ;

oper
  jokuPron : MorphoFin.Number => (MorphoFin.Case) => Str =
    let 
      kui = mkN "kuu" 
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
      mi  = mkN "mi"
    } in
    table {
      Sg => table {
        Nom => "mik‰" ;
        Gen => "mink‰" ;
        Part => "mit‰" ;
        c   => mi.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "mitk‰" ;
        Gen => "mink‰" ;
        Part => "mit‰" ;
        c   => mi.s ! NCase Sg c
        }
      } ;

  kukaInt : MorphoFin.Number => (MorphoFin.Case) => Str = 
    let 
      kuka = mkN "kuka" "kenen" "ket‰" "ken‰" "keneen" 
                 "keiden" "keit‰" "kein‰" "keiss‰" "keihin" ;
    in
    table {
      Sg => table {
        c   => kuka.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "ketk‰" ;
        c   => kuka.s ! NCase Pl c
        }
      } ;
  mikaanPron : MorphoFin.Number => (MorphoFin.Case) => Str = \\n,c =>
    case <n,c> of {
        <Sg,Nom> => "mik‰‰n" ;
        <_,Part> => "mit‰‰n" ;
        <Sg,Gen> => "mink‰‰n" ;
        <Pl,Nom> => "mitk‰‰n" ;
        <Pl,Gen> => "mittenk‰‰n" ;
        <_,Ess>  => "min‰‰n" ;
        <_,Iness> => "miss‰‰n" ;
        <_,Elat> => "mist‰‰n" ;
        <_,Adess> => "mill‰‰n" ;
        <_,Ablat> => "milt‰‰n" ;
        _   => mikaInt ! n ! c + "k‰‰n"
       } ; 

  kukaanPron : MorphoFin.Number => (MorphoFin.Case) => Str =
    table {
      Sg => table {
        Nom => "kukaan" ;
        Part => "ket‰‰n" ;
        Ess => "ken‰‰n" ;
        Iness => "kess‰‰n" ;
        Elat  => "kest‰‰n" ;
        Illat => "kehenk‰‰n" ;
        Adess => "kell‰‰n" ;
        Ablat => "kelt‰‰n" ;
        c   => kukaInt ! Sg ! c + "k‰‰n"
       } ; 
      Pl => table {
        Nom => "ketk‰‰n" ;
        Part => "keit‰‰n" ;
        Ess => "kein‰‰n" ;
        Iness => "keiss‰‰n" ;
        Elat => "keist‰‰n" ;
        Adess => "keill‰‰n" ;
        Ablat => "keilt‰‰n" ;
        c   => kukaInt ! Pl ! c + "k‰‰n"
        }
      } ;


oper
  makeNP  : N -> MorphoFin.Number -> CatFin.NP ; 
  makeNP noun num = {
    s = \\c => noun.s ! NCase num (npform2case num c) ; 
    a = agrP3 num ;
    isPron = False ;
    lock_NP = <>
    } ;

lin
  not_Predet = {s = \\_,_ => "ei"} ;

  no_Quant = heavyQuant {
    s1 = \\n,c => "ei" ++ mikaanPron ! n ! c ;
    s2 = [] ; isNum,isPoss = False ; isDef = True ; 
    } ;

  if_then_Conj = {s1 = "jos" ; s2 = "niin" ; n = Sg} ;
  nobody_NP = {
    s = \\c => "ei" ++ kukaanPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ; 
    isPron = False
    } ;

  nothing_NP = {
    s = \\c => "ei" ++ mikaanPron ! Sg ! npform2case Sg c ;
    a = agrP3 Sg ; 
    isPron = False
    } ;

  at_least_AdN = ss "v‰hint‰‰n" ;
  at_most_AdN = ss "enint‰‰n" ;

  as_CAdv = X.mkCAdv "yht‰" "kuin" ;

  except_Prep = postPrep partitive "lukuunottamatta" ;

  have_V2 = mkV2 (caseV adessive vOlla) ;

  lin language_title_Utt = ss "suomi" ;

}

