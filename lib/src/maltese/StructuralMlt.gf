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

    {- Others --------------------------------------------------------------- -}

    -- above_Prep = mkPrep "above" ;
    -- after_Prep = mkPrep "after" ;
    -- almost_AdA = mkAdA "almost" ;
    -- almost_AdN = mkAdN "almost" ;
    -- although_Subj = ss "although" ;
    -- always_AdV = mkAdV "always" ;
    -- and_Conj = mkConj "and" ;
    -- because_Subj = ss "because" ;
    -- before_Prep = mkPrep "before" ;
    -- behind_Prep = mkPrep "behind" ;
    -- between_Prep = mkPrep "between" ;
    -- both7and_DConj = mkConj "both" "and";
    -- but_PConj = ss "but" ;
    -- by8agent_Prep = mkPrep "by" ;
    -- by8means_Prep = mkPrep "by" ;
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
    -- during_Prep = mkPrep "during" ;
    -- either7or_DConj = mkConj "either" "or" singular ;
    -- everybody_NP = regNP "everybody" singular ;
    -- everything_NP = regNP "everything" singular ;
    -- everywhere_Adv = mkAdv "everywhere" ;
    -- for_Prep = mkPrep "for" ;
    -- from_Prep = mkPrep "from" ;
    -- here_Adv = mkAdv "here" ;
    -- here7to_Adv = mkAdv ["to here"] ;
    -- here7from_Adv = mkAdv ["from here"] ;
    -- how_IAdv = ss "how" ;
    -- how8much_IAdv = ss "how much" ;
    -- how8many_IDet = mkDeterminer plural ["how many"] ;
    -- if_Subj = ss "if" ;
    -- in8front_Prep = mkPrep ["in front of"] ;
    -- in_Prep = mkPrep "in" ;
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
    -- on_Prep = mkPrep "on" ;
    -- or_Conj = mkConj "or" singular ;
    -- otherwise_PConj = ss "otherwise" ;
    -- part_Prep = mkPrep "of" ;
    -- please_Voc = ss "please" ;
    -- possess_Prep = mkPrep "of" ;
    -- quite_Adv = mkAdv "quite" ;
    -- so_AdA = mkAdA "so" ;
    -- somebody_NP = regNP "somebody" singular ;
    -- something_NP = regNP "something" singular ;
    -- somewhere_Adv = mkAdv "somewhere" ;
    -- there_Adv = mkAdv "there" ;
    -- there7to_Adv = mkAdv "there" ;
    -- there7from_Adv = mkAdv ["from there"] ;
    -- therefore_PConj = ss "therefore" ;
    -- through_Prep = mkPrep "through" ;
    -- too_AdA = mkAdA "too" ;
    -- to_Prep = mkPrep "to" ;
    -- under_Prep = mkPrep "under" ;
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
    -- without_Prep = mkPrep "without" ;
    -- with_Prep = mkPrep "with" ;
    -- yes_Utt = ss "yes" ;
    
    -- if_then_Conj = mkConj "if" "then" singular ;
    -- nobody_NP = regNP "nobody" singular ;
    -- nothing_NP = regNP "nothing" singular ;
    
    -- at_least_AdN = mkAdN "at least" ;
    -- at_most_AdN = mkAdN "at most" ;
    
    -- except_Prep = mkPrep "except" ;
    
    -- as_CAdv = C.mkCAdv "as" "as" ;
    
    -- have_V2 = dirV2 (mk5V "have" "has" "had" "had" "having") ;
    -- that_Subj = ss "that" ;

  lin language_title_Utt = ss "Malti" ;

}
