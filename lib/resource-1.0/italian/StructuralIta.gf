concrete StructuralIta of Structural = CatIta ** 
  open PhonoIta, MorphoIta, ParadigmsIta, BeschIta, Prelude in {

  flags optimize=all ;

lin

  above_Prep = {s = ["sopra"] ; c = MorphoIta.genitive ; isDir = False} ;
  after_Prep = mkPreposition "dopo" ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "tutto" "tutta" "tutti" "tutte" ! a ;
    c = Nom
    } ;
  almost_AdA, almost_AdN = ss "quasi" ;
  always_AdV = ss "sempre" ;
  although_Subj = ss "benché" ** {m = Conjunct} ;
  and_Conj = ss "e" ** {n = Pl} ;
  because_Subj = ss "perché" ** {m = Indic} ;
  before_Prep = mkPreposition "prima" ;
  behind_Prep = mkPreposition "dietro" ;
  between_Prep = mkPreposition "fra" ;
  both7and_DConj = {s1,s2 = "e" ; n = Pl} ;
  but_PConj = ss "ma" ;
  by8agent_Prep = {s = [] ; c = CPrep P_da} ;
  by8means_Prep = mkPreposition "per" ;
  can8know_VV = mkVV (verboV (sapere_78 "sapere")) ;
  can_VV = mkVV (verboV (potere_69 "potere")) ;
  during_Prep = mkPreposition "durante" ;
  either7or_DConj = {s1,s2 = "o" ; n = Sg} ;
  everybody_NP = mkNP ["tutti"] Masc Pl ;
  every_Det = {s = \\_,_ => "ogni" ; n = Sg} ;
  everything_NP = pn2np (mkPN ["tutto"] Masc) ;
  everywhere_Adv = ss "dappertutto" ;
  first_Ord = {s = \\ag => (regA "primo").s ! Posit ! AF ag.g ag.n} ;
  from_Prep = complGen ; ---
  he_Pron = 
    mkPronoun
      "lui" "lo" "gli" "glie" "lui" "suo" "sua" "suoi" "sue"
      Masc Sg P3 ;
  here7from_Adv = ss ["da quì"] ;
  here7to_Adv = ss "quì" ;
  here_Adv = ss "quì" ;
  how_IAdv = ss "come" ;
  how8many_IDet = {s = \\g,c => prepCase c ++ genForms "quanti" "quante" ! g ; n = Pl} ;
  if_Subj = ss "se" ** {m = Indic} ;
  in8front_Prep = mkPreposition "davanti" ;
  i_Pron = 
    mkPronoun
      "io" "mi" "mi" "me" "me" "mio" "mia" "miei" "mie"
      Fem Sg P1 ;
  in_Prep = {s = [] ; c = CPrep P_in} ;
  it_Pron = 
    mkPronoun
      "lui" "lo" "gli" "glie" "lui" "suo" "sua" "suoi" "sue"
      Masc Sg P3 ;
  less_CAdv = ss "meno" ;
  many_Det = {s = \\g,c => prepCase c ++ genForms "molti" "molte" ! g ; n = Pl} ;
  more_CAdv = ss "più" ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la maggior parte"] ; c = CPrep P_di} ;
  much_Det = {s = \\g,c => prepCase c ++ genForms "molto" "molta" ! g ; n = Sg} ;
  must_VV = mkVV (verboV (dovere_47 "dovere")) ;
  no_Phr = ss "no" ;
  on_Prep = {s = [] ; c = CPrep P_su} ;
  one_Quant = {s = \\g,c => prepCase c ++ genForms "uno" "una" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "soltanto" ; c = Nom} ; --- solo|a|i|e
  or_Conj = {s = "o" ; n = Sg} ;
  otherwise_PConj = ss "altramente" ;
  part_Prep = complGen ;
  please_Voc = ss ["per favore"] ;
  possess_Prep = complGen ;
  quite_Adv = ss "assai" ;
  she_Pron = 
    mkPronoun
      "lei" "la" "le" "glie" "lei" "suo" "sua" "suoi" "sue"
      Fem Sg P3 ;
  so_AdA = ss "così" ;
  somebody_NP = pn2np (mkPN ["qualcuno"] Masc) ;
  somePl_Det = {s = \\_,c => prepCase c ++ "qualche" ; n = Pl} ;
  someSg_Det = {s = \\_,c => prepCase c ++ "qualche" ; n = Sg} ;
  something_NP = pn2np (mkPN ["qualche cosa"] Masc) ;
  somewhere_Adv = ss ["qualche parte"] ;
  that_Quant = {
    s = table {
      Sg => \\g,c => prepCase c ++ genForms "quello" "quella" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "quelli" "quelle" ! g ---- quegli
      }
    } ;
  that_NP = mkNP ["questo"] Masc Sg ;
  there7from_Adv = ss ["di là"] ;
  there7to_Adv = ss "là" ; --- ci
  there_Adv = ss "là" ;
  therefore_PConj = ss "quindi" ;
  these_NP = mkNP ["queste"] Fem Pl ;
  they_Pron = mkPronoun
    "loro" "loro" "li" "glie" "loro" "loro" "loro" "loro" "loro" 
    Fem Pl P3 ;
  this_Quant = {
    s = table {
      Sg => \\g,c => prepCase c ++ genForms "questo" "questa" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "questi" "queste" ! g
      }
    } ;
  this_NP = pn2np (mkPN ["questo"] Masc) ;
  those_NP = mkNP ["quelle"] Fem Pl ;
  through_Prep = mkPreposition "per" ;
  too_AdA = ss "troppo" ;
  to_Prep = complDat ;
  under_Prep = mkPreposition "sotto" ;
  very_AdA = ss "molto" ;
  want_VV = mkVV (verboV (volere_96 "volere")) ;
  we_Pron = 
    mkPronoun "noi" "ci" "ci" "ce" "noi" "nostro" "nostra" "nostri" "nostre"
    Fem Pl P1 ;
  whatSg_IP = {s = \\c => prepCase c ++ ["che cosa"] ; a = aagr Fem Sg} ;
  whatPl_IP = {s = \\c => prepCase c ++ ["che cose"] ; a = aagr Fem Pl} ; ---
  when_IAdv = ss "quando" ;
  when_Subj = ss "quando" ** {m = Indic} ;
  where_IAdv = ss "dove" ;
  whichPl_IDet = {s = \\g,c => prepCase c ++ genForms "quale" "quale" ! g ; n = Sg} ;
  whichSg_IDet = {s = \\g,c => prepCase c ++ genForms "quali" "quali" ! g; n = Pl} ;
  whoPl_IP = {s = \\c => prepCase c ++ "chi" ; a = aagr Fem Pl} ;
  whoSg_IP = {s = \\c => prepCase c ++ "chi" ; a = aagr Fem Sg} ;
  why_IAdv = ss "perché" ;
  without_Prep = mkPreposition "senza" ;
  with_Prep = {s = [] ; c = CPrep P_con} ;
  yes_Phr = ss "sì" ;
  youSg_Pron = mkPronoun 
    "tu" "ti" "ti" "te" "te" "tuo" "tua" "tuoi" "tue"
    Fem Sg P2 ;
  youPl_Pron =
    mkPronoun
       "voi" "vi" "vi" "ve" "voi" "vostro" "vostra" "vostri" "vostre"
       Fem Pl P2 ;
  youPol_Pron =
    mkPronoun
      "Lei" "La" "Le" "Glie" "Lei" "Suo" "Sua" "Suoi" "Sue"
      Fem Sg P3 ;

}

