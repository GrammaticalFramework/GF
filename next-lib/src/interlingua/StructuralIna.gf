concrete StructuralIna of Structural = CatIna ** 
  open MorphoIna, (P = ParadigmsIna), Prelude in {

  flags optimize=all ;

  oper
    mkPrep = P.mkPrep;
    pp : Str -> Prep = \s-> mkPrep s Acc;
  lin
    above_Prep = pp "supra";
    after_Prep = pp "post" ;
    all_Predet = ss "omne" ;
    almost_AdA, almost_AdN = ss "quasi" ;
    although_Subj = ss "quamquam" ;
    always_AdV = ss "sempre" ;
    and_Conj = {s1 = [] ; s2 = "e" ; n = Pl} ;
    because_Subj = ss "proque" ;
    before_Prep = pp "ante";
    behind_Prep = pp "detra" ;
    between_Prep = pp "inter" ;
    both7and_DConj = sd2 "e" "e" ** {n = Pl} ;
    but_PConj = ss "sed" ;
    by8agent_Prep = pp "per" ;
    by8means_Prep = pp "per" ;
    can_VV = P.regV "poter";
    can8know_VV = P.regV "saper";
    during_Prep = pp "durante" ;
    either7or_DConj = sd2 "o" "o" ** {n = Sg} ;
    everybody_NP = regNP "totos" ;
    every_Det = mkDeterminer Sg "tote" ;
    everything_NP = regNP "toto" ;
    everywhere_Adv = ss "ubique" ;
    few_Det = mkDeterminer Pl "qualque" ;
    for_Prep = pp "por" ;
    from_Prep = pp "ex" ;
    he_Pron = mkPron "ille" "le" "su" Sp3;
    here_Adv = ss "hic" ;
    here7to_Adv = ss "hac" ;
    here7from_Adv = mkPrep ["de ci"] Dat;
    how_IAdv = ss "como" ;
    how8many_IDet = mkIDeterminer Pl ["quante"] ;
    if_Subj = ss "ii" ;
    in8front_Prep = pp "avante";
    i_Pron  = mkPron "io" "me" "mi" Sp1;
    in_Prep = pp "in" ;
    it_Pron  = mkPron "illo" "lo" "su" Sp3;
    less_CAdv = {s = "minus" ; p = "que"} ;
    many_Det = mkDeterminer Pl "multe" ;
    more_CAdv = {s = "plus" ; p = "que"} ;
    most_Predet = ss ("le"++"plus");
    much_Det = mkDeterminer Sg "tanto" ;
    must_VV = P.regV "deber";
    no_Utt = ss "no" ;
    on_Prep = mkPrep "super" Acc;
    only_Predet = ss "unic" ;
    or_Conj = {s1 = [] ; s2 = "o" ; n = Sg} ;
    otherwise_PConj = ss "alias" ;
    part_Prep = mkPrep [] Abl; -- de ...
    please_Voc = ss ("per"++"favor") ;
    possess_Prep = mkPrep [] Gen; -- the possesive preposition can not generate clitics, and fuses with the definite determiner "le". Pronoun form: "mie", "sue", etc.
    quite_Adv = ss "assi" ;
    she_Pron = mkPron "illa" "la" "su" Sp3;
    so_AdA = ss "tam" ;
    somebody_NP = regNP (variants {"alicuno"; "alcuno"}) ;
    someSg_Det = mkDeterminer Sg (variants {"alicun"; "alcun"});
    somePl_Det = mkDeterminer Pl (variants {"alicun"; "alcun"});
    something_NP = regNP ("alcun"++"cosa") ; -- very many variants
    somewhere_Adv = ss "alicubi" ; -- variants
    that_Quant = mkQuant "ille" "ille" ;
--    that_NP = regNP "illo" ; -- Also exsits gender variants!
    there_Adv = ss "ibi"; -- la
    there7to_Adv = ss "ibi" ;
    there7from_Adv = ss "ibi";
    therefore_PConj = ss "ergo" ;
--    these_NP = regNP "istes" ;
    they_Pron = mkPron "illos" "los" "lor" Pp3; 
    this_Quant = mkQuant "iste" "istes" ;
--    this_NP = regNP "isto" ;
--    those_NP = regNP "illos" ; -- Also exsits gender variants!
    through_Prep =  mkPrep "per" Acc;
    too_AdA = ss "alsi" ;
    to_Prep = mkPrep "" Dat;
    under_Prep = pp "infra" ;
    very_AdA = ss "multo" ;
    want_VV = P.regV "want" ;
    we_Pron = mkPron "nos" "nos" "nostre" Pp1;
    whatPl_IP = mkIP "que" Pl ;
    whatSg_IP = mkIP "que" Sg ;
    when_IAdv = ss "quando" ;
    when_Subj = ss "quando" ;
    where_IAdv = ss "ubi" ;
    which_IQuant = {s = table {
      Pl => "qual" ;
      Sg => "quales"
      }
    } ;
    whoSg_IP = mkIP "qui" Sg ;
    whoPl_IP = mkIP "qui" Pl ;
    why_IAdv = ss "proque" ;
    without_Prep = mkPrep "sin" Acc;
    with_Prep = mkPrep "con" Acc ;
    yes_Utt = ss "itaque" ; -- ita?
    youSg_Pron = mkPron "tu" "te" "tu" Sp2;
    youPl_Pron = mkPron "vos" "vos" "vostre" Pp2;
    youPol_Pron = mkPron "vos" "vos" "vostre" Pp2;

    -- have_V2 = dirV2 (R.haberV ** {lock_V = <>});

oper
  mkQuant : Str -> Str -> {s : Number => Case => Str} = \x,y -> {
    s = \\n,c=> case n of {
      Sg => x;
      Pl => y
      }} ;

}

