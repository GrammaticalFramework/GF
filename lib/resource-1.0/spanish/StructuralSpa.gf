concrete StructuralSpa of Structural = CatSpa ** 
  open PhonoSpa, MorphoSpa, ParadigmsSpa, BeschSpa, Prelude in {

  flags optimize=all ;

lin

  above_Prep = mkPreposition "sobre" ;
  after_Prep = {s = ["despues"] ; c = MorphoSpa.genitive ; isDir = False} ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "todo" "toda" "todos" "todas" ! a ;
    c = Nom
    } ;
  almost_AdA, almost_AdN = ss "casi" ;
  always_AdV = ss "siempre" ;
  although_Subj = ss "benché" ** {m = Conjunct} ;
  and_Conj = etConj ;
  because_Subj = ss "porque" ** {m = Indic} ;
  before_Prep = {s = "antes" ; c = MorphoSpa.genitive ; isDir = False} ;
  behind_Prep = {s = "detrás" ; c = MorphoSpa.genitive ; isDir = False} ;
  between_Prep = mkPreposition "entre" ;
  both7and_DConj = {s1,s2 = etConj.s ; n = Pl} ;
  but_PConj = ss "mas" ;
  by8agent_Prep = mkPreposition "por" ;
  by8means_Prep = mkPreposition "por" ;
  can8know_VV = mkVV (verboV (saber_71 "saber")) ;
  can_VV = mkVV (verboV (poder_58 "poder")) ;
  during_Prep = mkPreposition "durante" ; ----
  either7or_DConj = {s1,s2 = "o" ; n = Sg} ;
  everybody_NP = mkNP ["todos"] Masc Pl ;
  every_Det = {s = \\_,_ => "cada" ; n = Sg} ;
  everything_NP = pn2np (mkPN ["todo"] Masc) ;
  everywhere_Adv = ss ["en todas partes"] ;
  first_Ord = {s = \\ag => (regA "primero").s ! Posit ! AF ag.g ag.n} ;
  from_Prep = complGen ; ---
  he_Pron = 
    mkPronoun 
     "el" "lo" "le" "él"
     "su" "su" "sus" "sus"
      Masc Sg P3 ;
  here_Adv = mkAdv "aquí" ;		-- acá
  here7to_Adv = mkAdv ["para acá"] ;
  here7from_Adv = mkAdv ["de acá"] ;
  how_IAdv = ss "como" ;
  how8many_IDet = 
    {s = \\g,c => prepCase c ++ genForms "cuantos" "cuantas" ! g ; n = Pl} ;
  if_Subj = ss "si" ** {m = Indic} ;
  in8front_Prep = {s = "delante" ; c = MorphoSpa.genitive ; isDir = False} ;
  i_Pron = 
    mkPronoun
      "yo" "me" "me" "mí"
      "mi" "mi" "mis" "mis"
      Fem Sg P1 ;
  in_Prep = mkPreposition "en" ;
  it_Pron = 
    mkPronoun
      "el" "lo" "le" "él"
      "su" "su" "sus" "sus"
      Masc Sg P3 ;
  less_CAdv = ss "meno" ; ----
  many_Det = {s = \\g,c => prepCase c ++ genForms "muchos" "muchas" ! g ; n = Pl} ;
  more_CAdv = ss "mas" ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la mayor parte"] ; c = CPrep P_de} ;
  much_Det = {s = \\g,c => prepCase c ++ genForms "mucho" "mucha" ! g ; n = Sg} ;
  must_VV = mkVV (verboV (deber_6 "deber")) ;
  no_Phr = ss "no" ;
  on_Prep = mkPreposition "sobre" ;
  one_Quant = {s = \\g,c => prepCase c ++ genForms "uno" "una" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "solamente" ; c = Nom} ;
  or_Conj = {s = "o" ; n = Sg} ;
  otherwise_PConj = ss "otramente" ;
  part_Prep = complGen ;
  please_Voc = ss ["por favor"] ;
  possess_Prep = complGen ;
  quite_Adv = ss "bastante" ;
  she_Pron = 
    mkPronoun
      "ella" "la" "le" "ella"
      "su" "su" "sus" "sus"
      Fem Sg P3 ;
  so_AdA = ss "tanto" ;
  somebody_NP = pn2np (mkPN ["algún"] Masc) ;
  somePl_Det = {s = \\g,c => prepCase c ++ genForms "algunos" "algunas" ! g ; n = Pl} ;
  someSg_Det = {s = \\g,c => prepCase c ++ "algun" ; n = Sg} ;
  something_NP = pn2np (mkPN ["algo"] Masc) ;
  somewhere_Adv = ss ["en ninguna parte"] ;
  that_Quant = {
    s = \\_ => table {
      Sg => \\g,c => prepCase c ++ genForms "ese" "esa" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "esos" "esas" ! g
      }
    } ;
  that_NP = mkNP ["eso"] Masc Sg ;
  there_Adv = mkAdv "allí" ;		-- allá
  there7to_Adv = mkAdv ["para allá"] ;
  there7from_Adv = mkAdv ["de allá"] ;	
  therefore_PConj = ss ["por eso"] ;
  these_NP = mkNP ["estas"] Fem Pl ;
  they_Pron = mkPronoun
    "ellas" "las" "les" "ellas"
    "su" "su" "sus" "sus"
    Fem Pl P3 ;
  this_Quant = {
    s = \\_ => table {
      Sg => \\g,c => prepCase c ++ genForms "este" "esta" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "estos" "estas" ! g
      }
    } ;
  this_NP = pn2np (mkPN ["esto"] Masc) ;
  those_NP = mkNP ["esas"] Fem Pl ;
  through_Prep = mkPreposition "por" ;
  too_AdA = ss "demasiado" ;
  to_Prep = complDat ;
  under_Prep = mkPreposition "bajo" ;
  very_AdA = ss "muy" ;
  want_VV = mkVV (verboV (querer_64 "querer")) ;
  we_Pron = 
    mkPronoun 
      "nosotras" "nos" "nos" "nosotras"
      "nuestro" "nuestra" "nuestros" "nuestras"
      Fem Pl P1 ;
  whatSg_IP = {s = \\c => prepCase c ++ ["qué"] ; a = aagr Masc Sg} ;
  whatPl_IP = {s = \\c => prepCase c ++ ["qué"] ; a = aagr Masc Pl} ; ---
  when_IAdv = ss "cuando" ;
  when_Subj = ss "cuando" ** {m = Indic} ;
  where_IAdv = ss "donde" ;
  whichPl_IDet = {s = \\g,c => prepCase c ++ "cuale" ; n = Sg} ;
  whichSg_IDet = {s = \\g,c => prepCase c ++ "cuali" ; n = Pl} ;
  whoPl_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Fem Pl} ;
  whoSg_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Fem Sg} ;
  why_IAdv = ss "porqué" ;
  without_Prep = mkPreposition "sin" ;
  with_Prep = mkPreposition "con" ;
  yes_Phr = ss "sí" ;
  youSg_Pron = mkPronoun 
    "tu" "te" "te" "tí"
    "tu" "tu" "tus" "tus"
    Fem Sg P2 ;
  youPl_Pron =
    mkPronoun
      "vosotras" "vos" "vos" "vosotras"
      "vuestro" "vuestra" "vuestros" "vuestras"
      Fem Pl P2 ;
  youPol_Pron =
    mkPronoun
      "usted" "la" "le" "usted"
      "su" "su" "sus" "sus"
      Fem Pl P2 ;

oper
  etConj : {s : Str ; n : Number} = {s = pre {
    "y" ; 
    "y" / strs {"ya" ; "ye" ; "yo" ; "yu"} ;
    "e" / strs {"i" ; "hi" ; "y"}
    }} ** {n = Pl} ;

}

