concrete LexEng of Lex = CatEng ** open ResEng in {
  lin
    walk_V  = regV "walk" ;
    kill_V2 = regV "kill" ** {c2 = []} ;
    show_V3 = regV "show" ** {c2 = [] ; c3 = "to"} ;
    want_VV = regV "want" ** {c2 = "to"} ;
    claim_VS = regV "claim" ;
    ask_VQ = regV "ask" ;

    big_AP = {s = "big"} ;
    dog_N  = regN "dog" ;
    son_N2 = regN "son" ** {c2 = "of"} ;
    way_N3 = regN "way" ** {c2 = "from" ; c3 = "to"} ;

    here_Adv = {s = "here"} ;

-- structural
    
    i_Pron  = mkNP "I"  "me"  "my"  Sg P1 ;
    he_Pron = mkNP "he" "him" "his" Sg P3 ;
    we_Pron = mkNP "we" "us"  "our" Pl P1 ;


}
