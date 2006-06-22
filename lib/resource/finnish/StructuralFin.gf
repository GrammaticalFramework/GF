concrete StructuralFin of Structural = CatFin ** 
  open MorphoFin, ParadigmsFin, Prelude in {

  flags optimize=all ;

  lin
  above_Prep = postGenPrep "yl‰puolella" ;
  after_Prep = postGenPrep "j‰lkeen" ;

  all_Predet = {s = \\n,c => 
    let
      kaiket = caseTable n (nhn (sKorpi "kaikki" "kaiken" "kaikkena"))
    in
    case npform2case n c of {
      Nom => "kaikki" ;
      k => kaiket ! k
      }
    } ;
  almost_AdA, almost_AdN = ss "melkein" ;
  although_Subj = ss "vaikka" ;
  always_AdV = ss "aina" ;
  and_Conj = ss "ja" ** {n = Pl} ;
  because_Subj = ss "koska" ;
  before_Prep = prePrep partitive "ennen" ;
  behind_Prep = postGenPrep "takana" ;
  between_Prep = postGenPrep "v‰liss‰" ;
  both7and_DConj = sd2 "sek‰" "ett‰" ** {n = Pl} ;
  but_PConj = ss "mutta" ;
  by8agent_Prep = postGenPrep "toimesta" ;
  by8means_Prep = casePrep adessive ;
  can8know_VV = reg2V "osata" "osasi" ;
  can_VV = reg2V "voida" "voi" ;
  during_Prep = postGenPrep "aikana" ;
  either7or_DConj = sd2 "joko" "tai" ** {n = Sg} ;
  everybody_NP = mkNP (regN "jokainen") Sg ;
  every_Det = mkDet Sg (regN "jokainen") ;
  everything_NP = mkNP ((nhn (sKorpi "kaikki" "kaiken" "kaikkena")) **
    {lock_N = <>}) Sg ;
  everywhere_Adv = ss "kaikkialla" ;
  few_Det  = mkDet Sg (regN "harva") ;
  first_Ord = {s = \\n,c => (regN "ensimm‰inen").s ! NCase n c} ;
  from_Prep = casePrep elative ;
  he_Pron = mkPronoun "h‰n" "h‰nen" "h‰nt‰"  "h‰nen‰" "h‰neen" Sg P3 ;
  here_Adv = ss "t‰‰ll‰" ;
  here7to_Adv = ss "t‰nne" ;
  here7from_Adv = ss "t‰‰lt‰" ;
  how_IAdv = ss "miten" ;
  how8many_IDet = 
    {s = \\c => "kuinka" ++ (reg2N "moni" "monia").s ! NCase Sg c ; n = Sg} ;
  if_Subj = ss "jos" ;
  in8front_Prep = postGenPrep "edess‰" ;
  i_Pron  = mkPronoun "min‰" "minun" "minua" "minuna" "minuun" Sg P1 ;
  in_Prep = casePrep inessive ;
  it_Pron = {
    s = \\c => pronSe.s ! npform2case Sg c ; 
    a = agrP3 Sg ; 
    isPron = False
    } ;
  less_CAdv = ss "v‰hemm‰n" ;
  many_Det = mkDet Sg (reg2N "moni" "monia") ;
  more_CAdv = ss "enemm‰n" ;
  most_Predet = {s = \\n,c => (nhn (sSuurin "useinta")).s ! NCase n (npform2case n c)} ;
  much_Det = mkDet Sg {s = \\_ => "paljon"} ;
  must_VV = subjcaseV (regV "t‰yty‰") genitive ;
  no_Phr = ss "ei" ;
  on_Prep = casePrep adessive ;
  one_Quant = mkDet Sg 
     (nhn (mkSubst "‰" "yksi" "yhde" "yhte" "yht‰" "yhteen" "yksi" "yksi" 
      "yksien" "yksi‰" "yksiin")) ;
  only_Predet = {s = \\_,_ => "vain"} ;
  or_Conj = ss "tai" ** {n = Sg} ;
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
  someSg_Det = {
    s1 = jokuPron ! Sg ;
    s2 = [] ;
    isNum,isPoss = False ; isDef = True ; n = Sg
    } ;
  somePl_Det = {
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
  that_Quant = {
    s1 = table Number [
          table Case {
            c => (mkPronoun "tuo" "tuon" "tuota" "tuona" "tuohon" Sg P3).s ! NPCase c
            } ;
          table Case {
            c => (mkPronoun "nuo" "noiden" "noita" "noina" "noihin" Sg P3).s ! NPCase c
            }
          ] ;
    s2 = [] ; isNum,isPoss = False ; isDef = True ; 
    } ;
  that_NP = 
    mkDemPronoun "tuo" "tuon" "tuota" "tuona" "tuohon"  Sg **
    {isPron = False} ;
  there_Adv = ss "siell‰" ; --- tuolla
  there7to_Adv = ss "sinne" ;
  there7from_Adv = ss "sielt‰" ;
  therefore_PConj = ss "siksi" ;
  these_NP = 
    mkDemPronoun "n‰m‰" "n‰iden" "n‰it‰" "n‰in‰" "n‰ihin"  Pl **
    {isPron = False} ;
  they_Pron = mkPronoun "he" "heid‰n" "heit‰" "hein‰" "heihin"  Pl P3 ; --- ne
  this_Quant = {
    s1 = table Number [
          table Case {
            c => (mkPronoun "t‰m‰" "t‰m‰n" "t‰t‰" "t‰n‰" "t‰h‰n" Sg P3).s ! NPCase c
            } ;
          table Case {
            c => (mkPronoun "nuo" "noiden" "noita" "noina" "noihin" Sg P3).s ! NPCase c
            }
          ] ;
    s2 = [] ; isNum,isPoss = False ; isDef = True ; 
    } ;
  this_NP = 
    mkDemPronoun "t‰m‰" "t‰m‰n" "t‰t‰" "t‰n‰" "t‰h‰n"  Sg **
    {isPron = False} ;
  those_NP = 
    mkDemPronoun "nuo" "noiden" "noita" "noina" "noihin"  Pl **
    {isPron = False} ;
  through_Prep = postGenPrep "kautta" ;
  too_AdA = ss "liian" ;
  to_Prep = casePrep illative ; --- allative
  under_Prep = postGenPrep "alla" ;
  very_AdA = ss "eritt‰in" ;
  want_VV = regV "tahtoa" ;
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
  whichPl_IDet = {
    s = mikaInt ! Pl ;
    n = Pl
    } ;
  whichSg_IDet = {
    s = mikaInt ! Sg ;
    n = Sg
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
  yes_Phr = ss "kyll‰" ;
  youSg_Pron = mkPronoun "sin‰" "sinun" "sinua" "sinuna" "sinuun"  Sg P2 ;
  youPl_Pron = mkPronoun "te" "teid‰n" "teit‰" "tein‰" "teihin"  Pl P2 ;
  youPol_Pron = mkPronoun "te" "teid‰n" "teit‰" "tein‰" "teihin"  Pl P2 ; --- Sg


oper
  jokuPron : Number => Case => Str =
    let 
      ku = nhn (sPuu "ku") ;
      kui = nhn (sPuu "kuu") 
    in
    table {
      Sg => table {
        Nom => "joku" ;
        Gen => "jonkun" ;
        c => relPron ! Sg ! c + ku.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "jotkut" ;
        c => relPron ! Pl ! c + kui.s ! NCase Pl c
        }
      } ;

  jokinPron : Number => Case => Str =
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

  mikaInt : Number => Case => Str = 
    let {
      mi  = nhn (sSuo "mi")
    } in
    table {
      Sg => table {
        Nom => "mik‰" ;
        Gen => "mink‰" ;
        c   => mi.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "mitk‰" ;
        Gen => "mittenk‰" ;
        c   => mi.s ! NCase Sg c
        }
      } ;

  kukaInt : Number => Case => Str = 
    let {
      ku = nhn (sRae "kuka" "kenen‰") ;
      ket = nhn (sRae "kuka" "kein‰")} in
    table {
      Sg => table {
        Nom => "kuka" ;
        Part => "ket‰" ;
        Illat => "keneen" ;
        c   => ku.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "ketk‰" ;
        Illat => "keihin" ;
        c   => ket.s ! NCase Pl c
        }
      } ;
  mikaanPron : Number => Case => Str = \\n,c =>
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

  kukaanPron : Number => Case => Str =
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

  pronSe : ProperName  = {
    s = table {
      Nom    => "se" ;
      Gen    => "sen" ;
      Part   => "sit‰" ;
      Transl => "siksi" ;
      Ess    => "sin‰" ;
      Iness  => "siin‰" ;
      Elat   => "siit‰" ;
      Illat  => "siihen" ;
      Adess  => "sill‰" ;
      Ablat  => "silt‰" ;
      Allat  => "sille" ;
      Abess  => "sitt‰"
      } ;
    } ;


}

