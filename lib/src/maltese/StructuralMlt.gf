-- StructuralMlt.gf: lexicon of structural words
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete StructuralMlt of Structural = CatMlt **
  open MorphoMlt, ResMlt, ParadigmsMlt, (C = ConstructX), Prelude in {

  flags
    optimize=all ;
    coding=utf8 ;

  lin

    {- Pronoun -------------------------------------------------------------- -}

    i_Pron      = mkPron "jien"  "i"   singular P1 masculine ; --- also JIENA
    youSg_Pron  = mkPron "int"   "ek"  singular P2 masculine ; --- also INTI
    he_Pron     = mkPron "hu"    "u"   singular P3 masculine ; --- also HUWA
    she_Pron    = mkPron "hi"    "ha"  singular P3 feminine  ; --- also HIJA
    we_Pron     = mkPron "aħna"  "na"  plural   P1 masculine ;
    youPl_Pron  = mkPron "intom" "kom" plural   P2 masculine ;
    they_Pron   = mkPron "huma"  "hom" plural   P3 masculine ;
    youPol_Pron = youSg_Pron ;
    it_Pron     = he_Pron ;

    whatPl_IP = mkIP ("x'" ++ BIND) plural ;
    whatSg_IP = mkIP ("x'" ++ BIND) singular ;
    whoPl_IP  = mkIP "min" plural ;
    whoSg_IP  = mkIP "min" singular ;

    {- Determiner ----------------------------------------------------------- -}

    all_Predet  = ss "kollha" ;
    every_Det   = mkDeterminer singular "kull" ; --- KULĦADD
    few_Det     = mkDeterminer plural "ftit" ;
    many_Det    = mkDeterminer plural "ħafna" ;
    most_Predet = ss "il-maġġoranza ta'" ; --- TAL-, TAN-
    much_Det    = mkDeterminer singular "ħafna" ;
    only_Predet = ss "biss" ;
    someSg_Det  = mkDeterminer singular "xi" ;
    somePl_Det  = mkDeterminer plural "xi" ;
    not_Predet  = ss "mhux" ;

    how8many_IDet = {
      s = "kemm" ; -- KEMM IL-...
      n = plural
      } ;

    {- Quantifier ----------------------------------------------------------- -}

    that_Quant = mkQuant "dak" "dik" "dawk" True ;
    this_Quant = mkQuant "dan" "din" "dawn" True ;
    no_Quant = let l_ebda = artDef ++ "ebda" in
      mkQuant l_ebda l_ebda l_ebda False ;

    which_IQuant = ss "liema" ;

    {- Conjunction ---------------------------------------------------------- -}

    and_Conj        = mkConj "u" ;
    both7and_DConj  = mkConj "kemm" "u";
    but_PConj       = ss "imma" ;
    either7or_DConj = mkConj "jew" "inkella" ;
    or_Conj         = mkConj "jew" ;
    otherwise_PConj = ss "inkella" ;
    therefore_PConj = ss "allura" ;
    if_then_Conj    = mkConj "jekk" ;

    {- Preposition ---------------------------------------------------------- -}

    above_Prep    = mkPrep "fuq" ;
    after_Prep    = mkPrep "wara" ;
    before_Prep   = mkPrep "qabel"
                           "qabli" "qablek" "qablu" "qabilha" "qabilna" "qabilkom" "qabilhom" ;
    behind_Prep   = after_Prep ;
    between_Prep  = mkPrep "bejn" ;
    by8agent_Prep = mkPrep "minn" "mill-" "mit-" ;
    by8means_Prep = mkPrep "bi" "b'" "bil-" "bit-" "bl-" ;
    during_Prep   = mkPrep "waqt" ;
    for_Prep      = mkPrep "għal" "għall-" "għall-" "għat-" "għall-"
                           "għalija" "għalik" "għalih" "għaliha" "għalina" "għalikom" "għalihom"
                           True ;
    from_Prep     = mkPrep "mingħand" ;
    in8front_Prep = mkPrep "quddiem" ;
    in_Prep       = mkPrep "fi" "f'" "fil-" "fit-" "fl-" ;
    on_Prep       = mkPrep "fuq" ;
    part_Prep     = possess_Prep ;
    possess_Prep  = mkPrep "ta'" "t'" "tal-" "tat-" "tal-" ;
    through_Prep  = mkPrep "minn ġo" "minn ġol-" "minn ġol-" "minn ġot-" "minn ġol-"
                           "minn ġo fija" "minn ġo fik" "minn ġo fih" "minn ġo fiha" "minn ġo fina" "minn ġo fikom" "minn ġo fihom"
                           False ;
    to_Prep       = mkPrep "lil" "lill-" "lit-" ;
    under_Prep    = mkPrep "taħt" ;
    without_Prep  = mkPrep "mingħajr" ;
    with_Prep     = mkPrep "ma'" "m'" "mal-" "mat-" "mal-" ;
    except_Prep   = mkPrep "apparti" ; --- special case..

    {- Noun phrase ---------------------------------------------------------- -}

    everybody_NP  = regNP "kulħadd" ;
    everything_NP = regNP "kollox" ;
    somebody_NP   = regNP "xi ħadd" ;
    something_NP  = regNP "xi ħaġa" ;
    nobody_NP     = regNP "ħadd" ;
    nothing_NP    = regNP "xejn" ;

    {- Subjunction ---------------------------------------------------------- -}

    although_Subj = ss "avolja" ;
    because_Subj  = ss "għax" ;
    if_Subj       = ss "jekk" ;
    when_Subj     = ss "meta" ;
    that_Subj     = ss "li" ;

    {- Adverb --------------------------------------------------------------- -}

    almost_AdA     = mkAdA "kważi" ;
    almost_AdN     = mkAdN "kważi" ;
    always_AdV     = mkAdV "dejjem" ;
    at_least_AdN   = mkAdN "mill-inqas" ;
    at_most_AdN    = mkAdN "l-iktar" ;
    everywhere_Adv = mkAdv "kullimkien" ;
    here_Adv       = mkAdv "hawn" ;
    here7to_Adv    = mkAdv ["s'hawnhekk"] ;
    here7from_Adv  = mkAdv ["minn hawnhekk"] ;
    less_CAdv      = C.mkCAdv "inqas" "minn" ; --- INQAS MILL-IEĦOR
    more_CAdv      = C.mkCAdv "iktar" "minn" ; --- IKTAR MIT-TNEJN
    quite_Adv      = mkAdv "pjuttost" ;
    so_AdA         = mkAdA "allura" ;
    somewhere_Adv  = mkAdv "x'imkien" ;
    there_Adv      = mkAdv "hemmhekk" ;
    there7to_Adv   = mkAdv "s'hemmhekk" ;
    there7from_Adv = mkAdv ["minn hemmhekk"] ;
    too_AdA        = mkAdA "ukoll" ;
    very_AdA       = mkAdA "ħafna" ;
    as_CAdv        = C.mkCAdv "" "daqs" ; -- "as good as gold"

    how_IAdv      = ss "kif" ;
    how8much_IAdv = ss "kemm" ;
    when_IAdv     = ss "meta" ;
    where_IAdv    = ss "fejn" ;
    why_IAdv      = ss "għalfejn" ;

    {- Verb ----------------------------------------------------------------- -}

    can8know_VV = af_V ;
    can_VV      = sata'_V ;
    must_VV     = kellu_V ;
    want_VV     = ried_V ;
    have_V2     = dirV2 (kellu_V) ;

  oper
    af_V = irregularV form1 (ResMlt.mkRoot "'-'-f") (ResMlt.mkPattern "a" [])
      "kont naf" "kont taf" "kien jaf" "kienet taf" "konna nafu" "kontu tafu" "kienu jafu" --- will fail for negative
      "naf" "taf" "jaf" "taf" "nafu" "tafu" "jafu"
      "kun af" "kunu afu"
      ;
    sata'_V = mkV "sata'" (ResMlt.mkRoot "s-t-għ") ;
    ried_V = mkV "ried" (ResMlt.mkRoot "r-j-d") ;
    kellu_V = irregularV form1 (ResMlt.mkRoot) (ResMlt.mkPattern)
      "kelli" "kellek" "kellu" "kellha" "kellna" "kellkom" "kellhom"
      "għandi" "għandek" "għandu" "għandha" "għandna" "għandkom" "għandhom"
      "kollok" "kollkom"
      ;

    {- Others --------------------------------------------------------------- -}
  lin

    please_Voc = ss "jekk jgħoġbok" ; --- JEKK JGĦOĠOBKOM

    no_Utt = ss "le" ;
    yes_Utt = ss "iva" ;

    language_title_Utt = ss "Malti" ;

}
