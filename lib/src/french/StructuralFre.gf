--# -path=.:../abstract:../romance:../common:prelude

concrete StructuralFre of Structural = CatFre ** 
  open PhonoFre, MorphoFre, ParadigmsFre, IrregFre, (X = ConstructX), 
  MakeStructuralFre,
  Prelude in {

  flags optimize=all ; coding=utf8 ;

lin

  above_Prep = {s = ["au dessus"] ; c = MorphoFre.genitive ; isDir = False} ;
  after_Prep = mkPreposition "après" ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "tout" "toute" "tous" "toutes" ! a ;
    c = Nom ;
    a = PNoAg
    } ;
  almost_AdA, almost_AdN = ss "presque" ;
  always_AdV = ss "toujours" ;
  although_Subj = ss ("bien" ++ elisQue) ** {m = Conjunct} ;
  and_Conj = {s1 = [] ; s2 = "et" ; n = Pl} ;
  because_Subj = ss ("parce" ++ elisQue) ** {m = Indic} ;
  before_Prep = mkPreposition "avant" ;
  behind_Prep = mkPreposition "derrière" ;
  between_Prep = mkPreposition "entre" ;
  both7and_DConj = {s1,s2 = "et" ; n = Pl} ;
  but_PConj = ss "mais" ;
  by8agent_Prep = mkPreposition "par" ;
  by8means_Prep = mkPreposition "par" ;
  can8know_VV = mkVV (savoir_V2 ** {lock_V = <>}) ;
  can_VV = mkVV pouvoir_V ;
  during_Prep = mkPreposition "pendant" ;
  either7or_DConj = {s1,s2 = "ou" ; n = Pl} ;
  everybody_NP = pn2np (mkPN ["tout le monde"] Masc) ;
  every_Det = {
    s  = \\_,_ => "chaque" ;
    sp = \\g,c => prepCase c ++ genForms "chacun" "chacune" ! g ;
    n = Sg ; 
    s2 = []
    } ;
  everything_NP = pn2np (mkPN ["tout"] Masc) ;
  everywhere_Adv = ss "partout" ;
  few_Det  = {s,sp = \\g,c => prepCase c ++ "peu" ++ elisDe ; n = Pl ; s2 = []} ;
--- DEPREC first_Ord = {s = \\ag => (regA "premier").s ! Posit ! AF ag.g ag.n} ;
  for_Prep = mkPreposition "pour" ;
  from_Prep = complGen ; ---
  he_Pron = 
    mkPronoun
      "il" (elision "l") "lui" "lui" "son" (elisPoss "s") "ses"
      Masc Sg P3 ;
  here7from_Adv = ss "d'ici" ;
  here7to_Adv = ss "ici" ;
  here_Adv = ss "ici" ;
  how_IAdv = ss "comment" ;
  how8much_IAdv = ss "combien" ;
  how8many_IDet = {s = \\_,c => prepCase c ++ "combien" ++ elisDe ; n = Pl} ;
  if_Subj = ss elisSi ** {m = Indic} ;
  in8front_Prep = mkPreposition "devant" ;
  i_Pron = 
    mkPronoun
      (elision "j") (elision "m") (elision "m") "moi" "mon" (elisPoss "m") "mes"
      Masc Sg P1 ;
  in_Prep = mkPreposition "dans" ;
  it_Pron = 
    mkPronoun
      "il" (elision "l") "lui" "lui" "son" (elisPoss "s") "ses"
      Masc Sg P3 ;
  less_CAdv = X.mkCAdv "moins" conjThan ;
  many_Det = {s,sp = \\_,c => prepCase c ++ "plusieurs" ; n = Pl ; s2 = []} ;
  more_CAdv = X.mkCAdv "plus" conjThan ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la plupart"] ; c = CPrep P_de ; a = PNoAg} ;
  much_Det = {s,sp = \\_,c => prepCase c ++ "beaucoup" ++ elisDe ; n = Pl ; s2 = []} ;
  must_VV = mkVV (devoir_V2 ** {lock_V = <>}) ;
---b  no_Phr = ss "non" ;
  no_Utt = ss "non" ;
  on_Prep = mkPreposition "sur" ;
--- DEPREC   one_Quant = {s = \\g,c => prepCase c ++ genForms "un" "une" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "seulement" ; c = Nom ; a = PNoAg} ; --- seul(e)(s)
  or_Conj = {s1 = [] ; s2 = "ou" ; n = Sg} ;
  otherwise_PConj = ss "autrement" ;
  part_Prep = complGen ;
  please_Voc = ss ["s'il vous plaît"] ;
  possess_Prep = complGen ;
  quite_Adv = ss "assez" ;
  she_Pron = 
    mkPronoun
      "elle" elisLa "lui" "elle" "son" (elisPoss "s") "ses"
      Fem Sg P3 ;

  so_AdA = ss "si" ;
  somebody_NP = pn2np (mkPN ["quelqu'un"] Masc) ;
  somePl_Det = {s,sp = \\_,c => prepCase c ++ "quelques" ; n = Pl ; s2 = []} ; ---- sp
  someSg_Det = {s,sp = \\_,c => prepCase c ++ elision "quelqu" ; n = Sg ; s2 = []} ; ----sp
  something_NP = pn2np (mkPN ["quelque chose"] Masc) ;
  somewhere_Adv = ss ["quelque part"] ; --- ne - pas

  that_Quant = {
    s = \\_ => table {
      Sg => \\g,c => prepCase c ++ 
                     genForms (pre {"ce" ; "cet" / voyelle}) "cette" ! g ;
      Pl => \\_,c => prepCase c ++ "ces"
      } ;
    sp = table {
      Sg => \\g,c => prepCase c ++ genForms "celui-là" "celle-là" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "celui-là" "celle-là" ! g
      } ;
    s2 = [] ---- "-là"
    } ;

---b  that_NP = makeNP ["cela"] Masc Sg ;
  there7from_Adv = ss ["de là"] ;
  there7to_Adv = ss "là" ; --- y
  there_Adv = ss "là" ;
  therefore_PConj = ss "donc" ;
---b  these_NP = makeNP ["ceux-ci"] Masc Pl ;
  they_Pron = mkPronoun
    "ils" "les" "leur" "eux" "leur" "leur" "leurs"
    Masc Pl P3 ;

  this_Quant = {
    s = \\_ => table {
      Sg => \\g,c => prepCase c ++ 
                     genForms (pre {"ce" ; "cet" / voyelle}) "cette" ! g ;
      Pl => \\_,c => prepCase c ++ "ces"
      } ;
    sp = table {
      Sg => \\g,c => prepCase c ++ genForms "celui-ci" "celle-ci" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "celui-ci" "celle-ci" ! g
      } ;
    s2 = [] ---- "-ci"
    } ;

---b  this_NP = pn2np (mkPN ["ceci"] Masc) ;
---b  those_NP = makeNP ["ceux-là"] Masc Pl ;
  through_Prep = mkPreposition "par" ;
  too_AdA = ss "trop" ;
  to_Prep = complDat ;
  under_Prep = mkPreposition "sous" ;
  very_AdA = ss "très" ;
  want_VV = mkVV (vouloir_V2 ** {lock_V = <>}) ;
  we_Pron = 
    mkPronoun "nous" "nous" "nous" "nous" "notre" "notre" "nos"
    Masc Pl P1 ;
  whatSg_IP = 
    {s = \\c => prepCase c ++ "quoi" ; a = a}
    where {a = aagr Masc Sg} ;
  whatPl_IP = 
    {s = \\c => prepCase c ++ "quoi" ; a = a}
    where {a = aagr Masc Pl} ;
  when_IAdv = ss "quand" ;
  when_Subj = ss "quand" ** {m = Indic} ;
  where_IAdv = ss "où" ;
  which_IQuant = {
    s = \\n,g,c => 
        prepCase c ++ aagrForms "quel" "quelle" "quels" "quelles" ! aagr g n
    } ;

  whoPl_IP = {s = \\c => prepCase c ++ "qui" ; a = aagr Masc Pl} ;
  whoSg_IP = {s = \\c => prepCase c ++ "qui" ; a = aagr Masc Sg} ;
  why_IAdv = ss "pourquoi" ;
  without_Prep = mkPreposition "sans" ;
  with_Prep = mkPreposition "avec" ;
  yes_Utt = ss "oui" ; --- si

  youSg_Pron = mkPronoun 
    "tu" (elision "t") (elision "t") "toi" "ton" (elisPoss "t") "tes"
    Masc Sg P2 ;
  youPl_Pron, youPol_Pron = 
    mkPronoun
      "vous" "vous" "vous" "vous" "votre" "votre" "vos"
       Masc Pl P2 ;

  not_Predet = {s = \\a,c => prepCase c ++ "pas" ; c = Nom ; a = PNoAg} ;

  no_Quant = 
    let aucun : ParadigmsFre.Number => ParadigmsFre.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms "aucun" "aucune" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "aucuns" "aucunes" ! g ---- 
      }
    in {
    s = \\_ => aucun ;
    sp = aucun ;
    s2 = []
    } ;
  if_then_Conj = {s1 = "si" ; s2 = "alors" ; n = Sg ; lock_Conj = <>} ;
  nobody_NP = pn2np (mkPN ["personne"] Fem) ;
 
  nothing_NP = pn2np (mkPN "rien" Masc) ;
  at_least_AdN = ss "au moins" ;
  at_most_AdN = ss "au plus" ;

  except_Prep = mkPreposition "excepté" ;

  as_CAdv = X.mkCAdv "aussi" conjThan ;

  have_V2 = avoir_V2 ;
  that_Subj = ss elisQue ** {m = Conjunct} ;

  lin language_title_Utt = ss "français" ;

}

