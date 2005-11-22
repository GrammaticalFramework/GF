concrete LexEng of Lex = CatEng ** open ResEng in {
  lin
    walk_V  = regV "walk" ;
    kill_V2 = regV "kill" ** {s2 = []} ;
    want_VV = regV "want" ** {s2 = "to"} ;

    big_AP  = {s = "big"} ;
    
    i_NP  = mkNP "I"  "me"  "my"  Sg P1 ;
    he_NP = mkNP "he" "him" "his" Sg P3 ;
    we_NP = mkNP "we" "us"  "our" Pl P1 ;

    here_Adv = {s = "here"} ;
}
