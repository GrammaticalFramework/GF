abstract PeaceLex = Cat ** {

  cat
    MassN ;

  fun

    -- Pronouns

    i_Pron : Pron ;
    youSg_Pron : Pron ;
    he_Pron : Pron ;
    we_Pron : Pron ;
    youPl_Pron : Pron ;
    they_Pron : Pron ;
    whoPl_IP : IP ;
    whoSg_IP : IP ;
    whatPl_IP : IP ;
    whatSg_IP : IP ;

    -- Determiners

    aSg_Det : Det ;
    aPl_Det : Det ;
    theSg_Det : Det ;
    thePl_Det : Det ;
    that_Det : Det ;
    those_Det : Det ;
    this_Det : Det ;
    these_Det : Det ;

    -- Adverbs

    here_Adv : Adv ;
    there_Adv : Adv ;
    where_IAdv : IAdv ;
    when_IAdv : IAdv ;

    -- Numerals

    one_Det : Det ;
    two_Num : Num ;
    three_Num : Num ;
    four_Num : Num ;
    five_Num : Num ;

    -- Adjectives

    black_A : A ;
    blue_A : A ;
    cold_A : A ;
    dangerous_A : A ;
    dead_A : A ;
    green_A : A ;
    hot_A : A ;
    hungry_A : A ;
    large_A : A ;
    red_A : A ;
    sick_A : A ;
    small_A : A ;
    white_A : A ;
    yellow_A : A ;

    -- Nouns

    air_N : MassN ;
    airplane_N : N ;
    arm_N : N ;
    animal_N : N ;
    blood_N : MassN ;
    boat_N : N ;
    boy_N : N ;
    child_N : N ;
    corpse_N : N ;
    building_N : N ;
    car_N : N ;
    doctor_N : N ;
    enemy_N : N ;
    factory_N : N ;
    food_N : MassN ;
    foot_N : N ;
    friend_N : N ;
    girl_N : N ;
    hand_N : N ;
    head_N : N ;
    house_N : N ;
    landmine_N : N ;
    leg_N : N ;
    medicine_N : MassN ;
    man_N : N ;
    road_N : N ;
    skin_N : MassN ;
    soldier_N : N ;
    water_N : MassN ;
    weapon_N : N ;
    woman_N : N;

    -- Verbs
    cough_V : V ;
    eat_V2 : V2 ;
    drink_V2 : V2 ;
    give_V3 : V3 ;
    have_V2 : V2;
    need_V2 : V2;
    own_V2 : V2 ;
    see_V2 : V2 ;
    show_V3 : V3 ;
    sleep_V : V ;
    walk_V : V ;

}