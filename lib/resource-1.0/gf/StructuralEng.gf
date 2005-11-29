concrete StructuralEng of Structural = CatEng ** open ResEng, Prelude in {

  lin

    here_Adv = {s = "here"} ;
    very_AdA = {s = "very"} ;
    always_AdV = {s = "always"} ;

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

    and_Conj = {s = "and" ; n = Pl} ;
    either7or_DConj = {s1 = "either" ; s2 = "or" ; n = Sg} ;

    if_Subj = ss "if" ;
    because_Subj = ss "because" ;

    but_PConj = {s = "but"} ;
   
    please_Voc = {s = "," ++ "please"} ;

    more_CAdv = ss "more" ;
    less_CAdv = ss "less" ;

}
