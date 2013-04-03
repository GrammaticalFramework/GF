-- StructuralMlt.gf: lexicon of structural words
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete StructuralMlt of Structural = CatMlt **
  open MorphoMlt, ResMlt, ParadigmsMlt, Prelude in {

  flags
    optimize=all ;  
    coding=utf8 ;

  lin
    
    {- Pronoun -------------------------------------------------------------- -}
    
    i_Pron      = mkPron "jien"  "i"   "ni" "li"  singular P1 masculine ; --- also JIENA
    youSg_Pron  = mkPron "int"   "ek"  "ek" "lek" singular P2 masculine ; --- also INTI
    he_Pron     = mkPron "hu"    "u"   "u"  "lu"  singular P3 masculine ; --- also HUWA
    she_Pron    = mkPron "hi"    "ha"             singular P3 feminine  ; --- also HIJA
    we_Pron     = mkPron "aħna"  "na"             plural   P1 masculine ;
    youPl_Pron  = mkPron "intom" "kom"            plural   P2 masculine ;
    they_Pron   = mkPron "huma"  "hom"            plural   P3 masculine ;
    youPol_Pron = youSg_Pron ;
    -- it_Pron  = mkPron "it" "it" "its" "its" singular P3 nonhuman ;

    {- Determiner ----------------------------------------------------------- -}

    all_Predet = ss "kollha" ;
    -- every_Det = mkDeterminerSpec singular "every" "everyone" False ;
    few_Det = mkDeterminer plural "ftit" ;
    many_Det = mkDeterminer plural "ħafna" ; -- bosta
    -- most_Predet = ss "most" ;
    -- much_Det = mkDeterminer singular "much" ;
    only_Predet = ss "biss" ;
    someSg_Det = mkDeterminer singular "xi" ;
    somePl_Det = mkDeterminer plural "xi" ;
    -- not_predet = {s = "not" ; lock_Predet = <>} ;
    
    {- Quantifier ----------------------------------------------------------- -}

    that_Quant = mkQuant "dak" "dik" "dawk" True ;
    this_Quant = mkQuant "dan" "din" "dawn" True ;
    no_Quant = let l_ebda = artDef ++ "ebda" in
      mkQuant l_ebda l_ebda l_ebda False ;

    -- which_IQuant = {s = \\_ => "which"} ;

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
    before_Prep   = mkPrep "qabel" ;
    behind_Prep   = mkPrep "wara" ;
    between_Prep  = mkPrep "bejn" ;
    by8agent_Prep = mkPrep "minn" "mill-" "mit-" ;
    by8means_Prep = mkPrep "bi" "b'" "bil-" "bit-" "bl-" ;
    during_Prep   = mkPrep "waqt" ;
    for_Prep      = mkPrep "għal" "għall-" "għat-" ;
    from_Prep     = mkPrep "minn" "mill-" "mit-" ;
    in8front_Prep = mkPrep "quddiem" ;
    in_Prep       = mkPrep "fi" "f'" "fil-" "fit-" "fl-" ;
    on_Prep       = mkPrep "fuq" ;
    part_Prep     = mkPrep "ta'" "t'" "tal-" "tat-" "tal-" ;
    possess_Prep  = mkPrep "ta'" "t'" "tal-" "tat-" "tal-" ;
    through_Prep  = mkPrep "ġo" "ġol-" "ġot-" ;
    to_Prep       = mkPrep "lil" "lill-" "lit-" ;
    under_Prep    = mkPrep "taħt" ;
    without_Prep  = mkPrep "mingħajr" ;
    with_Prep     = mkPrep "ma'" "m'" "mal-" "mat-" "mal-" ;
    except_Prep   = mkPrep "apparti" ;

    {- Others --------------------------------------------------------------- -}

    -- almost_AdA = mkAdA "almost" ;
    -- almost_AdN = mkAdN "almost" ;
    -- although_Subj = ss "although" ;
    -- always_AdV = mkAdV "always" ;
    -- because_Subj = ss "because" ;
    -- can8know_VV, can_VV = {
    --   s = table { 
    --     VVF VInf => ["be able to"] ;
    --     VVF VPres => "can" ;
    --     VVF VPPart => ["been able to"] ;
    --     VVF VPresPart => ["being able to"] ;
    --     VVF VPast => "could" ;      --# notpresent
    --     VVPastNeg => "couldn't" ;   --# notpresent
    --     VVPresNeg => "can't"
    --     } ;
    --   typ = VVAux
    --   } ;
    -- everybody_NP = regNP "everybody" singular ;
    -- everything_NP = regNP "everything" singular ;
    -- everywhere_Adv = mkAdv "everywhere" ;
    -- here_Adv = mkAdv "here" ;
    -- here7to_Adv = mkAdv ["to here"] ;
    -- here7from_Adv = mkAdv ["from here"] ;
    -- how_IAdv = ss "how" ;
    -- how8much_IAdv = ss "how much" ;
    -- how8many_IDet = mkDeterminer plural ["how many"] ;
    -- if_Subj = ss "if" ;
    -- less_CAdv = C.mkCAdv "less" "than" ;
    -- more_CAdv = C.mkCAdv "more" "than" ;
    -- most_Predet = ss "most" ;
    -- must_VV = {
    --   s = table {
    --     VVF VInf => ["have to"] ;
    --     VVF VPres => "must" ;
    --     VVF VPPart => ["had to"] ;
    --     VVF VPresPart => ["having to"] ;
    --     VVF VPast => ["had to"] ;      --# notpresent
    --     VVPastNeg => ["hadn't to"] ;      --# notpresent
    --     VVPresNeg => "mustn't"
    --     } ;
    --   typ = VVAux
    --   } ;
    -- no_Utt = ss "no" ;
    -- please_Voc = ss "please" ;
    -- quite_Adv = mkAdv "quite" ;
    -- so_AdA = mkAdA "so" ;
    -- somebody_NP = regNP "somebody" singular ;
    -- something_NP = regNP "something" singular ;
    -- somewhere_Adv = mkAdv "somewhere" ;
    -- there_Adv = mkAdv "there" ;
    -- there7to_Adv = mkAdv "there" ;
    -- there7from_Adv = mkAdv ["from there"] ;
    -- too_AdA = mkAdA "too" ;
    -- very_AdA = mkAdA "very" ;
    -- want_VV = mkVV (regV "want") ;
    -- whatPl_IP = mkIP "what" "what" "what's" plural ;
    -- whatSg_IP = mkIP "what" "what" "what's" singular ;
    -- when_IAdv = ss "when" ;
    -- when_Subj = ss "when" ;
    -- where_IAdv = ss "where" ;
    -- whoPl_IP = mkIP "who" "whom" "whose" plural ;
    -- whoSg_IP = mkIP "who" "whom" "whose" singular ;
    -- why_IAdv = ss "why" ;
    -- yes_Utt = ss "yes" ;
    
    -- nobody_NP = regNP "nobody" singular ;
    -- nothing_NP = regNP "nothing" singular ;
    
    -- at_least_AdN = mkAdN "at least" ;
    -- at_most_AdN = mkAdN "at most" ;
    
    
    -- as_CAdv = C.mkCAdv "as" "as" ;
    
    have_V2 = dirV2 (
      irregularV form1 (ResMlt.mkRoot) (ResMlt.mkPattern)
        "kelli" "kellek" "kellu" "kellha" "kellna" "kellkom" "kellhom"
        "għandi" "għandek" "għandu" "għandha" "għandna" "għandkom" "għandhom"
        "kollok" "kollkom"
      ) ;

    -- that_Subj = ss "that" ;

  lin language_title_Utt = ss "Malti" ;

}
