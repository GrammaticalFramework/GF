incomplete concrete PeaceLexCommonI of PeaceLexCommon = PeaceCatI ** open Lang in {

  lin

    -- Pronouns

    i_Pron = i_Pron ;
    youSg_Pron = youSg_Pron ;
    he_Pron = he_Pron ;
    we_Pron = we_Pron ;
    youPl_Pron = youPl_Pron ;
    they_Pron = they_Pron ;
    whoPl_IP = whoPl_IP ;
    whoSg_IP = whoSg_IP ;
    whatPl_IP = whatPl_IP ;
    whatSg_IP = whatSg_IP ;

    this_NP = this_NP ;
    that_NP = that_NP ;

    -- Determiners

    aSg_Det =  DetSg (SgQuant IndefArt) NoOrd;
    aPl_Det =  DetPl (PlQuant IndefArt) NoNum NoOrd;
    theSg_Det = DetSg (SgQuant DefArt) NoOrd ;
    thePl_Det = DetPl (PlQuant DefArt) NoNum NoOrd ;
    that_Det = DetSg (SgQuant that_Quant) NoOrd ;
    those_Det = DetPl (PlQuant that_Quant) NoNum NoOrd ;
    this_Det = DetSg (SgQuant this_Quant) NoOrd ;
    these_Det = DetPl (PlQuant this_Quant) NoNum NoOrd ;

 
    -- Adverbs
    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
 
    -- Numerals
    one_Det = DetSg one_Quant NoOrd ;
    two_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n2))))) ;
    three_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n3))))) ;
    four_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n4))))) ;
    five_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n5))))) ;
 
    -- Adjectives
    black_A = black_A ;
    blue_A = blue_A ;
    cold_A = cold_A ;
    green_A = green_A ;
    hot_A = hot_A ;
    red_A = red_A ;
    small_A = small_A ;
    white_A = white_A ;
    yellow_A = yellow_A ;

    -- Nouns
    airplane_N = airplane_N ;
    animal_N = animal_N ;
    blood_N = blood_N ;
    boat_N = boat_N ;
    boy_N = boy_N ;
    child_N = child_N ;
    factory_N = factory_N ;
    foot_N = foot_N ;
    girl_N = girl_N ;
    hand_N = hand_N ;
    head_N = head_N ;
    house_N = house_N ;
    leg_N = leg_N ;
    man_N = man_N ;
    road_N = road_N ;
    water_N = water_N ;
    woman_N = woman_N ;

    -- Verbs
    breathe_V = breathe_V ;
    drink_V2 = drink_V2 ;
    eat_V2 = eat_V2 ;
    give_V3 = give_V3;
    have_V2 = have_V2;
    see_V2 = see_V2 ;
    sleep_V = sleep_V ;
    walk_V = walk_V ;

}
