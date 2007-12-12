concrete LexGer of Lex = CatGer ** open ResGer, Prelude in {

  flags optimize = values ;

  lin
    walk_V = 
      mkV 
        "gehen" "gehe" "gehst" "geht" "geht" "geh" 
        "ging" "gingst" "gingt" "gingen"
        "ginge" "gegangen" "aus" VSein ;
    help_V2 = 
      mkV 
        "helfen" "helfe" "hilfst" "hilft" "helft" "hilf" 
        "half" "halfst" "halft" "halfen" 
        "hälfe" "geholfen" [] VHaben ** 
      {c2 = {s = [] ; c = Dat}} ;
    show_V3 = 
      regV "zeigen" ** 
      {c2 = {s = [] ; c = Acc} ; c3 = {s = [] ; c = Dat}} ;
    want_VV = auxVV 
      (mkV 
        "wollen" "will" "willst" "will" "wollt" "woll" 
        "wollte" "wolltest" "wollten" "wolltet"
        "wollte" "gewollen" [] 
        VHaben) ;
    claim_VS = 
      mkV
        "behaupten" "behaupte" "bahauptest" "behauptet" "behauptet" "behaupte"
        "behauptete" "behauptetest" "behauptetet" "behaupteten"
        "behauptete" "behauptet" [] VHaben ;
    ask_VQ = 
      regV "fragen" ;

    dog_N  = mkN4 "Hund" "Hundes" "Hunde" "Hunden" Masc ;
    son_N2 = mkN4 "Sohn" "Sohnes" "Söhne" "Söhnen" Masc ** 
             {c2 = {s = "von" ; c = Dat}} ;
    way_N3 = mkN4 "Weg" "Weges" "Wege" "Wegen" Masc ** 
             {c2 = {s = "von" ; c = Dat} ; c3 = {s = "nach" ; c = Dat}} ;

    warm_A = mkA "warm" "warm" "wärmer" "wärmst" ;
    close_A2 = regA "eng" ** {c2 = {s = "bei" ; c = Dat}} ;

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
    forty_Numeral = {
      s = table {
        NCard => "vierzig" ; 
        NOrd af => (regA "vierzigt").s ! Posit ! af
        } ;
      n = Pl
      } ;

    in_Prep = {s = "in" ; c = Dat} ;
    of_Prep = {s = "von" ; c = Dat} ;

    and_Conj = {s = "und" ; n = Pl} ;
    either7or_DConj = {s1 = "entweder" ; s2 = "oder" ; n = Sg} ;

    if_Subj = ss "wenn" ;
    because_Subj = ss "weil" ;

    but_PConj = {s = "aber"} ;
   
    please_Voc = {s = "," ++ "bitte"} ;

    more_CAdv = ss "mehr" ;
    less_CAdv = ss "weniger" ;

}
