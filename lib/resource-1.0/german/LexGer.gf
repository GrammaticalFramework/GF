concrete LexGer of Lex = CatGer ** open ResGer, Prelude in {

  flags optimize = values ;

  lin
    walk_V  = mkV "gehen" "geht" "geh" "ging" "ginge" "gegangen" VSein ;
    help_V2 = mkV "helfen" "hilft" "hilf" "half" "hälfe" "geholfen" VHaben ** 
              {c2 = {s = [] ; c = Dat}} ;
    show_V3 = regV "zeigen" ** 
              {c2 = {s = [] ; c = Acc} ; c3 = {s = [] ; c = Dat}} ;
    want_VV = auxVV wollen_V ;
    claim_VS = no_geV (regV "behaupten") ;
    ask_VQ = regV "fragen" ;

    dog_N  = mkN4 "Hund" "Hundes" "Hünde" "Hünden" Masc ;
--    son_N2 = regN "son" ** {c2 = "of"} ;
--    way_N3 = regN "way" ** {c2 = "from" ; c3 = "to"} ;
--
    warm_A = mkA "warm" "warm" "wärmer" "wärmst" ;
--    close_A2 = regA "close" ** {c2 = "to"} ;
--
    here_Adv = {s = "hier"} ;
    very_AdA = {s = "sehr"} ;
    always_AdV = {s = "immer"} ;

    only_Predet = {s = \\_,_,_ => "nur"} ;
    all_Predet = {s = appAdj (regA "all")} ;
    this_Quant = {s = appAdj (regA "dies") ! Sg ; n = Sg ; a = Weak} ;
    these_Quant = {s = appAdj (regA "dies") ! Pl ; n = Pl ; a = Weak} ;
    
    i_Pron  = mkPronPers "ich" "mich" "mir"   "meiner" "mein"  Sg P1 ;
    he_Pron = mkPronPers "er"  "ihn"  "ihm"   "seiner" "sein"  Sg P3 ;
    we_Pron = mkPronPers "wir" "uns"  "uns"   "unser"  "unser" Pl P1 ;

    whoSg_IP = {s = caselist "wer" "wen" "wem" "wessen" ; n = Sg} ;
    whoPl_IP = {s = caselist "wer" "wen" "wem" "wessen" ; n = Pl} ;

    when_IAdv = {s = "wann"} ;
    where_IAdv = {s = "wo"} ;
    why_IAdv = {s = "warum"} ;

    whichSg_IDet = {s = appAdj (regA "welch") ! Sg ; n = Sg} ;
    whichPl_IDet = {s = appAdj (regA "welch") ! Sg ; n = Pl} ;

--    one_Numeral = {s = table {NCard => "one" ; NOrd => "first"} ; n = Sg} ;
--    forty_Numeral = {s = table {NCard => "forty" ; NOrd => "fortieth"} ; n = Pl} ;

    in_Prep = {s = "in" ; c = Dat} ;
    of_Prep = {s = "von" ; c = Dat} ;

--    and_Conj = {s = "and" ; n = Pl} ;
--    either7or_DConj = {s1 = "either" ; s2 = "or" ; n = Sg} ;

    if_Subj = ss "wenn" ;
    because_Subj = ss "weil" ;

    but_PConj = {s = "aber"} ;
   
    please_Voc = {s = "," ++ "bitte"} ;

    more_CAdv = ss "mehr" ;
    less_CAdv = ss "weniger" ;

}
