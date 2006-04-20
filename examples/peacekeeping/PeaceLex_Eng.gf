concrete PeaceLex_Eng of PeaceLex = CatEng ** open LangEng, ParadigmsEng in {

  lincat
    MassN = N ;

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
    dangerous_A = regA "dangerous" ;
    dead_A = regA "dead" ;
    green_A = green_A ;
    hot_A = hot_A ;
    hungry_A = regA "hungry" ;
    large_A = regA "large" ;
    red_A = red_A ;
    sick_A = regA "sick" ;
    small_A = small_A ;
    white_A = white_A ;
    yellow_A = yellow_A ;

    -- Nouns
    air_N = regN "air" ;
    airplane_N = airplane_N ;
    animal_N = animal_N ;
    arm_N = regN "arm" ;
    blood_N = blood_N ;
    boat_N = boat_N ;
    boy_N = boy_N ;
    building_N = regN "building" ;
    car_N = regN "car" ;
    child_N = child_N ;
    doctor_N = regN "doctor";
    enemy_N = regN "enemy";
    factory_N = factory_N ;
    food_N = regN "food";
    foot_N = foot_N ;
    friend_N = regN "friend";
    girl_N = girl_N ;
    hand_N = hand_N ;
    head_N = head_N ;
    house_N = house_N ;
    landmine_N = regN "landmine" ;
    leg_N = leg_N ;
    man_N = man_N ;
    medicine_N = regN "medicine" ;
    road_N = road_N ;
    soldier_N = regN "soldier" ;
    water_N = water_N ;
    weapon_N = regN "weapon";
    woman_N = woman_N ;

    -- Verbs
    cough_V = regV "cough" ;
    drink_V2 = drink_V2 ;
    eat_V2 = eat_V2 ;
    give_V3 = give_V3;
    have_V2 = have_V2;
    need_V2 = dirV2 (regV "need");
    see_V2 = see_V2 ;
    show_V3 = dirdirV3 (regV "show");
    walk_V = walk_V ;

}
