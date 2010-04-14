concrete StructuralIta of Structural = CatIta ** 
  open 
  PhonoIta, MorphoIta, MakeStructuralIta,
  ParadigmsIta, BeschIta, (X = ConstructX), Prelude in {

  flags optimize=all ; coding=utf8 ;

lin

  above_Prep = {s = ["sopra"] ; c = MorphoIta.genitive ; isDir = False} ;
  after_Prep = mkPrep "dopo" ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "tutto" "tutta" "tutti" "tutte" ! a ;
    c = Nom ;
    a = PNoAg
    } ;
  almost_AdA, almost_AdN = ss "quasi" ;
  always_AdV = ss "sempre" ;
  although_Subj = ss "benché" ** {m = Conjunct} ;
  and_Conj = {s1 = [] ; s2 = "e" ; n = Pl} ;
  because_Subj = ss "perché" ** {m = Indic} ;
  before_Prep = mkPrep "prima" ;
  behind_Prep = mkPrep "dietro" ;
  between_Prep = mkPrep "fra" ;
  both7and_DConj = {s1,s2 = "e" ; n = Pl} ;
  but_PConj = ss "ma" ;
  by8agent_Prep = {s = [] ; c = CPrep P_da ; isDir = False} ;
  by8means_Prep = mkPrep "per" ;
  can8know_VV = mkVV (verboV (sapere_78 "sapere")) ;
  can_VV = mkVV (verboV (potere_69 "potere")) ;
  during_Prep = mkPrep "durante" ;
  either7or_DConj = {s1,s2 = "o" ; n = Sg} ;
  everybody_NP = makeNP ["tutti"] Masc Pl ;
  every_Det = {s,sp = \\_,_ => "ogni" ; n = Sg ; s2 = []} ;
  everything_NP = pn2np (mkPN ["tutto"] Masc) ;
  everywhere_Adv = ss "dappertutto" ;
  few_Det  = {s,sp = \\g,c => prepCase c ++ genForms "pochi" "poche" ! g ; n = Pl ; s2 = []} ;
----  first_Ord = {s = \\ag => (regA "primo").s ! Posit ! AF ag.g ag.n} ;
  for_Prep = mkPrep "per" ;
  from_Prep = complGen ; ---
  he_Pron = 
    mkPronoun
      "lui" "lo" "gli" "glie" "lui" "suo" "sua" "suoi" "sue"
      Masc Sg P3 ;
  here7from_Adv = ss ["da quÃ¬"] ;
  here7to_Adv = ss "quÃ¬" ;
  here_Adv = ss "quÃ¬" ;
  how_IAdv = ss "come" ;
  how8much_IAdv = ss "quanto" ;
  how8many_IDet = {s = \\g,c => prepCase c ++ genForms "quanti" "quante" ! g ; n = Pl} ;
  if_Subj = ss "se" ** {m = Indic} ;
  in8front_Prep = mkPrep "davanti" ;
  i_Pron = 
    mkPronoun
      "io" "mi" "mi" "me" "me" "mio" "mia" "miei" "mie"
      Masc Sg P1 ;
  in_Prep = {s = [] ; c = CPrep P_in ; isDir = False} ;
  it_Pron = 
    mkPronoun
      "lui" "lo" "gli" "glie" "lui" "suo" "sua" "suoi" "sue"
      Masc Sg P3 ;
  less_CAdv = X.mkCAdv "meno" conjThan ;
  many_Det = {s,sp = \\g,c => prepCase c ++ genForms "molti" "molte" ! g ; n = Pl ; s2 = []} ;
  more_CAdv = X.mkCAdv "più" conjThan ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la maggior parte"] ; c = CPrep P_di ;
    a = PNoAg} ;
  much_Det = {s,sp = \\g,c => prepCase c ++ genForms "molto" "molta" ! g ; n = Sg ; s2 = []} ;
  must_VV = mkVV (verboV (dovere_47 "dovere")) ;
  no_Utt = ss "no" ;
  on_Prep = {s = [] ; c = CPrep P_su ; isDir = False} ;
----  one_Quant = {s = \\g,c => prepCase c ++ genForms "uno" "una" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "soltanto" ; c = Nom ;
    a = PNoAg} ; --- solo|a|i|e
  or_Conj = {s1 = [] ; s2 = "o" ; n = Sg} ;
  otherwise_PConj = ss "altramente" ;
  part_Prep = complGen ;
  please_Voc = ss ["per favore"] ;
  possess_Prep = complGen ;
  quite_Adv = ss "assai" ;
  she_Pron = 
    mkPronoun
      "lei" "la" "le" "glie" "lei" "suo" "sua" "suoi" "sue"
      Fem Sg P3 ;
  so_AdA = ss "cosÃ¬" ;
  somebody_NP = pn2np (mkPN ["qualcuno"] Masc) ;
  somePl_Det = {s,sp = \\_,c => prepCase c ++ "qualche" ; n = Pl ; s2 = []} ;
  someSg_Det = {s,sp = \\_,c => prepCase c ++ "qualche" ; n = Sg ; s2 = []} ;
  something_NP = pn2np (mkPN ["qualche cosa"] Masc) ;
  somewhere_Adv = ss ["qualche parte"] ;
  that_Quant = let
    quello : Str -> Str -> ParadigmsIta.Number => ParadigmsIta.Gender => Case => Str = 
     \quel, quelli -> table {
      Sg => \\g,c => prepCase c ++ genForms quel "quella" ! g ;
      Pl => \\g,c => prepCase c ++ genForms quelli "quelle" ! g ---- quegli
      }
    in {
      s = \\_ => 
        quello (elision "quel" "quell'" "quello") 
               (elision "quei" "quegli" "quegli")  ;
      sp = quello "quello" "quelli" ;
      s2 = []
      } ;

  there7from_Adv = ss ["di là"] ;
  there7to_Adv = ss "là" ; --- ci
  there_Adv = ss "là" ;
  therefore_PConj = ss "quindi" ;
  they_Pron = mkPronoun
    "loro" "loro" "li" "glie" "loro" "loro" "loro" "loro" "loro" 
    Masc Pl P3 ;

  this_Quant = let
    questo : ParadigmsIta.Number => ParadigmsIta.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms "questo" "questa" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "questi" "queste" ! g
      }
    in {
      s = \\_ => questo ;
      sp = questo ;
      s2 = []
      } ;

  through_Prep = mkPrep "per" ;
  too_AdA = ss "troppo" ;
  to_Prep = complDat ;
  under_Prep = mkPrep "sotto" ;
  very_AdA = ss "molto" ;
  want_VV = mkVV (verboV (volere_96 "volere")) ;
  we_Pron = 
    mkPronoun "noi" "ci" "ci" "ce" "noi" "nostro" "nostra" "nostri" "nostre"
    Masc Pl P1 ;
  whatSg_IP = {s = \\c => prepCase c ++ ["che cosa"] ; a = aagr Fem Sg} ;
  whatPl_IP = {s = \\c => prepCase c ++ ["che cose"] ; a = aagr Fem Pl} ; ---
  when_IAdv = ss "quando" ;
  when_Subj = ss "quando" ** {m = Indic} ;
  where_IAdv = ss "dove" ;
  which_IQuant = {s = table {
    Sg => \\g,c => prepCase c ++ genForms "quale" "quale" ! g ;
    Pl => \\g,c => prepCase c ++ genForms "quali" "quali" ! g
    }
  } ;
  whoPl_IP = {s = \\c => prepCase c ++ "chi" ; a = aagr Masc Pl} ;
  whoSg_IP = {s = \\c => prepCase c ++ "chi" ; a = aagr Masc Sg} ;
  why_IAdv = ss "perché" ;
  without_Prep = mkPrep "senza" ;
  with_Prep = {s = [] ; c = CPrep P_con ; isDir = False} ;
  yes_Utt = ss "sì" ;
  youSg_Pron = mkPronoun 
    "tu" "ti" "ti" "te" "te" "tuo" "tua" "tuoi" "tue"
    Masc Sg P2 ;
  youPl_Pron =
    mkPronoun
       "voi" "vi" "vi" "ve" "voi" "vostro" "vostra" "vostri" "vostre"
       Masc Pl P2 ;
  youPol_Pron =
    mkPronoun
      "Lei" "La" "Le" "Glie" "Lei" "Suo" "Sua" "Suoi" "Sue"
      Masc Sg P3 ;
  not_Predet = {s = \\a,c => prepCase c ++ "non" ; c = Nom ;
    a = PNoAg} ;

  no_Quant = 
    let aucun : ParadigmsIta.Number => ParadigmsIta.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms "nessuno" "nessuna" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "nessuni" "nessune" ! g ---- 
      }
    in {
    s = \\_ => aucun ;
    sp = aucun ;
    s2 = []
    } ;
  if_then_Conj = {s1 = "si" ; s2 = "allora" ; n = Sg ; lock_Conj = <>} ;
  nobody_NP = pn2np (mkPN ["nessuno"] Masc) ;
 
  nothing_NP = pn2np (mkPN "niente" Masc) ;
  at_least_AdN = ss "almeno" ;
  at_most_AdN = ss "al massimo" ;

  as_CAdv = X.mkCAdv "così" conjThan ;
  except_Prep = mkPrep "eccetto" ;

  have_V2 = dirV2 (verboV (avere_2 "avere")) ;
  that_Subj = ss "che" ** {m = Conjunct} ;

  lin language_title_Utt = ss "italiano" ;

}

