concrete StructuralSpa of Structural = CatSpa ** 
  open PhonoSpa, MorphoSpa, ParadigmsSpa, BeschSpa, 
       MakeStructuralSpa, (X = ConstructX), Prelude in {

  flags optimize=all ;

lin
  -- have_V3
  -- have_not_V3

  above_Prep = mkPrep "sobre" ;
  after_Prep = {s = ["despues"] ; c = MorphoSpa.genitive ; isDir = False} ;
  all_Predet = {
    s = \\a,c => prepCase c ++ aagrForms "todo" "toda" "todos" "todas" ! a ;
    c = Nom ;
    a = PNoAg
    } ;
  almost_AdA, almost_AdN = ss "casi" ;
  always_AdV = ss "siempre" ;
  although_Subj = ss "aunque" ** {m = Conjunct} ;
  and_Conj = {s1 = [] ; s2 = etConj.s ; n = Pl} ;
  at_least_AdN = ss "al menos" ;
  at_most_AdN = ss "a lo más" ;
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
  during_Prep = mkPrep "durante" ; 
  either7or_DConj = {s1,s2 = "o" ; n = Sg} ;
  everybody_NP = makeNP ["todos"] Masc Pl ;
  every_Det = mkDeterminer "cada" "cada" Sg False ;
  everything_NP = pn2np (mkPN ["todo"] Masc) ;
  everywhere_Adv = ss ["en todas partes"] ;
  except_Prep = mkPrep "excepto" ;
  few_Det = mkDeterminer "pocos" "pocas" Pl False ;
---  first_Ord = {s = \\ag => (regA "primero").s ! Posit ! AF ag.g ag.n} ;
  for_Prep = mkPrep "para" ;
  from_Prep = complGen ; ---
  he_Pron = 
    mkPronoun 
     "él" "lo" "le" "él"
     "su" "su" "sus" "sus"
      Masc Sg P3 ;
  here_Adv = mkAdv "aquí" ;
  here7to_Adv = mkAdv ["para aquí"] ;
  here7from_Adv = mkAdv ["de aquí"] ;
  how_IAdv = ss "como" ;
  how8many_IDet = mkIDet "cuántos" "cuántas" Pl ;
  how8much_IAdv = ss "cuánto" ;
  if_Subj = ss "si" ** {m = Indic} ;
  if_then_Conj = {s1 = "si" ; s2 = "entonces" ; n = Sg ; lock_Conj = <>} ;
  in8front_Prep = {s = "delante" ; c = MorphoSpa.genitive ; isDir = False} ;
  i_Pron = 
    mkPronoun
      "yo" "me" "me" "mí"
      "mi" "mi" "mis" "mis"
      Masc Sg P1 ;
  in_Prep = mkPrep "en" ;
  it_Pron = 
    mkPronoun
      "él" "lo" "le" "él"
      "su" "su" "sus" "sus"
      Masc Sg P3 ;
  less_CAdv = X.mkCAdv "menos" conjThan ; ----
  many_Det = mkDeterminer "muchos" "muchas" Pl False ;
  more_CAdv = X.mkCAdv "más" conjThan ;
  most_Predet = {s = \\_,c => prepCase c ++ ["la mayor parte"] ; c = CPrep P_de ;
    a = PNoAg} ;
  much_Det = mkDeterminer "mucho" "mucha" Sg False ;
  must_VV = mkVV (verboV (deber_6 "deber")) ;
  no_Quant =
    let
      ningun : ParadigmsSpa.Number => ParadigmsSpa.Gender => Case => Str = table {
        Sg => \\g,c => prepCase c ++ genForms "ningún" "ninguna" ! g ;
        Pl => \\g,c => prepCase c ++ genForms "ningunos" "ningunas" ! g
        }
    in {
      s = \\_ => ningun ;
      sp = ningun ;
      s2 = [] ; isNeg = True
    } ;
  no_Utt = ss "no" ;
  not_Predet = {s = \\a,c => prepCase c ++ "no" ; c = Nom ; a = PNoAg} ;
  nobody_NP = pn2npNeg (mkPN "nadie") ;
  nothing_NP = pn2npNeg (mkPN "nada") ;

  on_Prep = mkPrep "sobre" ;
---  one_Quant = {s = \\g,c => prepCase c ++ genForms "uno" "una" ! g} ;
  only_Predet = {s = \\_,c => prepCase c ++ "solamente" ; c = Nom ;
    a = PNoAg} ;
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
  somebody_NP = pn2np (mkPN "alguien" Masc) ;
  somePl_Det = mkDeterminer "algunos" "algunas" Pl False ;
  someSg_Det = mkDeterminer "algún" "alguna" Sg False ; 
  something_NP = pn2np (mkPN ["algo"] Masc) ;
  somewhere_Adv = ss ["en alguna parte"] ;
  that_Quant = mkQuantifier "ese" "esa" "esos" "esas" ;
  there_Adv = mkAdv "allí" ; -- allá
  there7to_Adv = mkAdv ["para allí"] ;
  there7from_Adv = mkAdv ["de allí"] ;
  therefore_PConj = ss ["por eso"] ;
  they_Pron = mkPronoun
    "ellos" "los" "les" "ellos"
    "su" "su" "sus" "sus"
    Masc Pl P3 ;
  this_Quant = mkQuantifier "este" "esta" "estos" "estas" ;
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
  when_IAdv = ss "cuándo" ;
  when_Subj = ss "cuando" ** {m = Indic} ;
  where_IAdv = ss "dónde" ;
  which_IQuant = {s = table {
    Sg => \\g,c => prepCase c ++ "qué" ; --- cual
    Pl => \\g,c => prepCase c ++ "qué" 
    }
   } ;
  whoPl_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Masc Pl} ;
  whoSg_IP = {s = \\c => prepCase c ++ "quién" ; a = aagr Masc Sg} ;
  why_IAdv = ss ["por qué"] ;
  without_Prep = mkPrep "sin" ;
  with_Prep = mkPrep "con" ;
  yes_Utt = ss "sí" ;
  youSg_Pron = mkPronoun 
    "tú" "te" "te" "ti"
    "tu" "tu" "tus" "tus"
    Masc Sg P2 ;
  youPl_Pron =
    mkPronoun
      "vosotros" "os" "os" "vosotros"
      "vuestro" "vuestra" "vuestros" "vuestras"
      Masc Pl P2 ;
  youPol_Pron =
    mkPronoun
      "usted" "lo" "le" "usted"
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
   have_V2 = dirV2 (verboV (tener_4 "tener")) ;

  that_Subj = {s = "que" ; m = Conjunct} ;

  lin language_title_Utt = ss "español" ;
}

