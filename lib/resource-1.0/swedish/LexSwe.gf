concrete LexSwe of Lex = CatSwe ** open ResSwe, Prelude in {

  lin
    walk_V = 
      mkVerb "gå" "går" "gå" "gick" "gått" "gången" "gånget" "gångna" ;
    help_V2 = 
      mkVerb "hjälpa" "hjälper" "hjälp" "hjälpte" "hjälpt" "hjälpt" "hjälpt" "hjälpta"
      ** {c2 = []} ;
    show_V3 = 
      mkVerb "visa" "visar" "visa" "visade" "visat" "visad" "visat" "visade"
      ** {c2 = [] ; c3 = "to"} ;
    want_VV = 
      mkVerb "vilja" "vill" "vilj" "ville" "velat" "velad" "velat" "velade" --- 
      ** {c2 = []} ;
    claim_VS = 
      mkVerb "hävda" "hävdar" "hävda" "hävdade" "hävdat" "hävdad" "hävdat" "hävdade" ;
    ask_VQ = 
      mkVerb "fråga" "frågar" "fråga" "frågade" "frågat" "frågad" "frågat" "frågade" ;

    dog_N  = mkNoun "hund" "hunden" "hundar" "hundarna" utrum ;
    son_N2 = mkNoun "son" "sonen" "söner" "sönerna" utrum ** {c2 = "till"} ;
    way_N3 = mkNoun "väg" "vägen" "vägar" "vägarna" utrum ** {c2 = "från" ; c3 = "till"} ;

    warm_A = 
      mkAdjective "varm" "varmt" "varma" "varma" "varmare" "varmast" "varmaste" ;
    close_A2 = 
      mkAdjective "nära" "nära" "nära" "nära" "närmare" "närmast" "närmaste"
      ** {c2 = "to"} ;

    here_Adv = {s = "här"} ;
    very_AdA = {s = "mycket"} ;
    always_AdV = {s = "alltid"} ;

    only_Predet = {s = \\_ => "bara"} ;
    all_Predet = {s = gennumForms "all" "allt" "alla"} ;
--    this_Quant = {s = "this" ; n = Sg} ;
--    these_Quant = {s = "these" ; n = Pl} ;
--    
    i_Pron  = mkNP "jag"  "mig"  "min" "mitt" "mina"  SgUtr P1 ;
    he_Pron = mkNP "han"  "honom"  "hans" "hans" "hans"  SgUtr P3 ;
    we_Pron = mkNP "vi"  "oss"  "vår" "vårt" "våra"  SgUtr P1 ;
--
--    whoSg_IP = mkIP "who" "whom" "whose" Sg ;
--    whoPl_IP = mkIP "who" "whom" "whose" Pl ;
--
    when_IAdv = {s = "när"} ;
    where_IAdv = {s = "var"} ;
    why_IAdv = {s = "varför"} ;
--
--    whichSg_IDet = {s = "which" ; n = Sg} ;
--    whichPl_IDet = {s = "which" ; n = Pl} ;
--
--    one_Numeral = {s = table {NCard => "one" ; NOrd => "first"} ; n = Sg} ;
--    forty_Numeral = {s = table {NCard => "forty" ; NOrd => "fortieth"} ; n = Pl} ;

    in_Prep = {s = "i"} ;
    of_Prep = {s = "av"} ;

    and_Conj = {s = "och" ; n = Pl} ;
    either7or_DConj = {s1 = "antingen" ; s2 = "eller" ; n = Sg} ;

    if_Subj = ss "om" ;
    because_Subj = ss "eftersom" ;

    but_PConj = {s = "men"} ;
   
    please_Voc = {s = "," ++ "tack"} ;

    more_CAdv = ss "mera" ;
    less_CAdv = ss "mindre" ;

}
