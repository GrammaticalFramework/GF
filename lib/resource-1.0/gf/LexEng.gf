concrete LexEng of Lex = CatEng ** open ResEng, Prelude in {

  lin
    walk_V  = regV "walk" ;
    help_V2 = regV "help" ** {c2 = []} ;
    show_V3 = regV "show" ** {c2 = [] ; c3 = "to"} ;
    want_VV = regV "want" ** {c2 = "to"} ;
    claim_VS = regV "claim" ;
    ask_VQ = regV "ask" ;

    dog_N  = regN "dog" ;
    son_N2 = regN "son" ** {c2 = "of"} ;
    way_N3 = regN "way" ** {c2 = "from" ; c3 = "to"} ;

    warm_A = regA "warm" ;
    close_A2 = regA "close" ** {c2 = "to"} ;

    here_Adv = {s = "here"} ;
    very_AdA = {s = "very"} ;

    only_Predet = {s = "only"} ;
    all_Predet = {s = "only"} ;
    this_Quant = {s = "this" ; n = Sg} ;
    these_Quant = {s = "these" ; n = Pl} ;
    
    i_Pron  = mkNP "I"  "me"  "my"  Sg P1 ;
    he_Pron = mkNP "he" "him" "his" Sg P3 ;
    we_Pron = mkNP "we" "us"  "our" Pl P1 ;

    whoSg_IP = mkIP "who" "whom" "whose" Sg ;
    whoPl_IP = mkIP "who" "whom" "whose" Pl ;

    when_IAdv = {s = "when"} ;
    where_IAdv = {s = "where"} ;
    why_IAdv = {s = "why"} ;

    whichSg_IDet = {s = "which" ; n = Sg} ;
    whichPl_IDet = {s = "which" ; n = Pl} ;

    one_Numeral = {s = table {NCard => "one" ; NOrd => "first"} ; n = Sg} ;
    forty_Numeral = {s = table {NCard => "forty" ; NOrd => "fortieth"} ; n = Pl} ;

    in_Prep = {s = "in"} ;
    of_Prep = {s = "of"} ;

}
