abstract Lex = Cat ** {

  fun
    walk_V  : V ;
    help_V2 : V2 ;
    show_V3 : V3 ;
    want_VV : VV ;
    claim_VS : VS ;
    ask_VQ : VQ ;

    dog_N : N ;
    son_N2 : N2 ;
    way_N3 : N3 ;

    warm_A : A ;
    close_A2 : A2 ;

-- structural


    only_Predet : Predet ;

    this_Quant  : Quant ;

    
    i_Pron, he_Pron, we_Pron : Pron ;

    whoSg_IP, whoPl_IP, whatSg_IP, whatPl_IP : IP ;

    when_IAdv, where_IAdv, why_IAdv : IAdv ;

    whichSg_IDet, whichPl_IDet : IDet ;

    here_Adv : Adv ;

    very_AdA : AdA ;
}
