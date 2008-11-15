concrete StructuralSpa of Structural = CatSpa ** 
  open PhonoSpa, MorphoSpa, ParadigmsSpa, BeschSpa, (X = ConstructX), Prelude in {

  flags optimize=all ;

lin

  above_Prep = mkPrep "sobre" ;
  after_Prep = {s = ["despues"] ; c = MorphoSpa.genitive ; isDir = False} ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "todo" "toda" "todos" "todas" ! a ;
    c = Nom
    } ;
  almost_AdA, almost_AdN = ss "casi" ;
  always_AdV = ss "siempre" ;
  although_Subj = ss "benché" ** {m = Conjunct} ;
  and_Conj = {s1 = [] ; s2 = "y" ; n = Pl} ;
  because_Subj = ss "porque" ** {m = Indic} ;
  before_Prep = {s = "antes" ; c = MorphoSpa.genitive ; isDir = False} ;
  behind_Prep = {s = "detrás" ; c = MorphoSpa.genitive ; isDir = False} ;
  between_Prep = mkPrep "entre" ;
  both7and_DConj = {s1,s2 = etConj.s ; n = Pl} ;
  but_PConj = ss "pero" ;
  by8agent_Prep = mkPrep "por" ;
  by8means_Prep = mkPrep "por" ;
  can8know_VV = mkVV (verboV (saber_71 "saber")) ;
  can_VV = mkVV (verboV (poder_58 "poder")) ;
  during_Prep = mkPrep "durante" ; ----
  either7or_DConj = {s1,s2 = "o" ; n = Sg} ;
  everybody_NP = makeNP ["todos"] Masc Pl ;
  every_Det = {s,sp = \\_,_ => "cada" ; n = Sg ; s2 = []} ;
  everything_NP = pn2np (mkPN ["todo"] Masc) ;
  everywhere_Adv = ss ["en todas partes"] ;
  few_Det  = {
    s,sp = \\g,c => prepCase c ++ genForms "pocos" "pocas" ! g ; n = Pl ; s2 = []} ;
---  first_Ord = {s = \\ag => (regA "primero").s ! Posit ! AF ag.g ag.n} ;
  for_Prep = mkPrep "para" ;
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
      Masc Sg P1 ;
  in_Prep = mkPrep "en" ;
  it_Pron = 
    mkPronoun
      "el" "lo" "le" "él"
      "su" "su" "sus" "sus"
      Masc Sg P3 ;
  less_CAdv = X.mkCAdv "menos" conjThan ; ----
  many_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "muchos" "muchas" ! g ; n = Pl ; s2 = []} ;
  more_CAdv = X.mkCAdv "más" conjThan ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la mayor parte"] ; c = CPrep P_de} ;
  much_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "mucho" "mucha" ! g ; n = Sg ; s2 = []} ;
  must_VV = mkVV (verboV (deber_6 "deber")) ;
  no_Utt = ss "no" ;
  on_Prep = mkPrep "sobre" ;
---  one_Quant = {s = \\g,c => prepCase c ++ genForms "uno" "una" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "solamente" ; c = Nom} ;
  or_Conj = {s1 = [] ; s2 = "o" ; n = Sg} ;
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
  somePl_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "algunos" "algunas" ! g ; n = Pl ; s2 = []} ;
  someSg_Det = {
    s,sp = \\g,c => prepCase c ++ genForms "algun" "alguna" ! g ; n = Sg ; s2 = []} ;
  something_NP = pn2np (mkPN ["algo"] Masc) ;
  somewhere_Adv = ss ["en ninguna parte"] ;
  that_Quant =
    let ese : ParadigmsSpa.Number => ParadigmsSpa.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms "ese" "esa" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "esos" "esas" ! g
      }
    in {
    s = \\_ => ese ;
    sp = ese ; 
    s2 = []
    } ;
  there_Adv = mkAdv "allí" ;		-- allá
  there7to_Adv = mkAdv ["para allá"] ;
  there7from_Adv = mkAdv ["de allá"] ;	
  therefore_PConj = ss ["por eso"] ;
  they_Pron = mkPronoun
    "ellos" "los" "les" "ellos"
    "su" "su" "sus" "sus"
    Masc Pl P3 ;
  this_Quant = 
    let este : ParadigmsSpa.Number => ParadigmsSpa.Gender => Case => Str = table {
      Sg => \\g,c => prepCase c ++ genForms "este" "esta" ! g ;
      Pl => \\g,c => prepCase c ++ genForms "estos" "estas" ! g
      }
    in {
    s = \\_ => este ;
    sp = este ; 
    s2 = []
    } ;

  through_Prep = mkPrep "por" ;
  too_AdA = ss "demasiado" ;
  to_Prep = complDat ;
  under_Prep = mkPrep "bajo" ;
  very_AdA = ss "muy" ;
  want_VV = mkVV (verboV (querer_64 "querer")) ;
  we_Pron = 
    mkPronoun 
      "nosotros" "nos" "nos" "nosotros"
      "nuestro" "nuestra" "nuestros" "nuestras"
      Masc Pl P1 ;
  whatSg_IP = {s = \\c => prepCase c ++ ["qué"] ; a = aagr Masc Sg} ;
  whatPl_IP = {s = \\c => prepCase c ++ ["qué"] ; a = aagr Masc Pl} ; ---
  when_IAdv = ss "cuando" ;
  when_Subj = ss "cuando" ** {m = Indic} ;
  where_IAdv = ss "donde" ;
  which_IQuant = {s = table {
    Sg => \\g,c => prepCase c ++ "qué" ; --- cual
    Pl => \\g,c => prepCase c ++ "qué" 
    }
   } ;
  whoPl_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Masc Pl} ;
  whoSg_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Masc Sg} ;
  why_IAdv = ss "porqué" ;
  without_Prep = mkPrep "sin" ;
  with_Prep = mkPrep "con" ;
  yes_Utt = ss "sí" ;
  youSg_Pron = mkPronoun 
    "tu" "te" "te" "tí"
    "tu" "tu" "tus" "tus"
    Masc Sg P2 ;
  youPl_Pron =
    mkPronoun
      "vosotros" "vos" "vos" "vosotros"
      "vuestro" "vuestra" "vuestros" "vuestras"
      Masc Pl P2 ;
  youPol_Pron =
    mkPronoun
      "usted" "la" "le" "usted"
      "su" "su" "sus" "sus"
      Masc Sg P3 ;

oper
  etConj : {s : Str ; n : MorphoSpa.Number} = {s = pre {
    "y" ; 
    "y" / strs {"ya" ; "ye" ; "yo" ; "yu"} ;
    "e" / strs {"i" ; "hi" ; "y"}
    }} ** {n = Pl} ;
lin
  as_CAdv = X.mkCAdv "si" conjThan ; ----

}

