-- Swadesh 207
abstract SwadeshLex = Categories ** {
  fun

    -- Pronouns

    i_NP : NP ;
    thou_NP : NP ;
    he_NP : NP ;
    we_NP : NP ;
    you_NP : NP ;
    they_NP : NP ;
    who8many_IP : IP ; -- only one who in Swadesh 207
    who8one_IP : IP ;
    what8many_IP : IP ; -- only one what in Swadesh 207
    what8one_IP : IP ;

    -- Determiners

    that_Det : Det ;
    this_Det : Det ;
    all_NDet : NDet ;
    many_Det : Det ;
    some_Det : Det ;
    few_Det : Det ;
    other_Det : Det ;

    -- Adverbs

    here_Adv : Adv ;
    there_Adv : Adv ;
    where_IAdv : IAdv ;
    when_IAdv : IAdv ;
    how_IAdv : IAdv ;

    -- not : Adv ; -- ?

    -- Numerals

    one_Num : Num ;
    two_Num : Num ;
    three_Num : Num ;
    four_Num : Num ;
    five_Num : Num ;

    -- Adjectives

    bad_ADeg : ADeg ;
    big_ADeg : ADeg ;
    black_ADeg : ADeg ;
    cold_ADeg : ADeg ;
    correct_ADeg : ADeg ;
    dirty_ADeg : ADeg ;
    dry_ADeg : ADeg ;
    dull_ADeg : ADeg ;
    far_ADeg : ADeg ;
    full_ADeg : ADeg ;
    good_ADeg : ADeg ;
    green_ADeg : ADeg ;
    heavy_ADeg : ADeg ;
    long_ADeg : ADeg ;
    narrow_ADeg : ADeg ;
    near_ADeg : ADeg ;
    new_ADeg : ADeg ;
    old_ADeg : ADeg ;
    red_ADeg : ADeg ;
    rotten_ADeg : ADeg ;
    round_ADeg : ADeg ;
    sharp_ADeg : ADeg ;
    short_ADeg : ADeg ;
    small_ADeg : ADeg ;
    smooth_ADeg : ADeg ;
    straight_ADeg : ADeg ;
    thick_ADeg : ADeg ;
    thin_ADeg : ADeg ;
    warm_ADeg : ADeg ;
    wet_ADeg : ADeg ;
    white_ADeg : ADeg ;
    wide_ADeg : ADeg ;
    yellow_ADeg : ADeg ;

    left_A : A ;
    right_A : A ;

    -- Nouns

    animal_N : N ;
    ashes_N : N ;
    back_N : N ;
    bark_N : N ;
    belly_N : N ;
    bird_N : N ;
    blood_N : N ;
    bone_N : N ;
    breast_N : N ;
    child_N : N ;
    cloud_N : N ;
    day_N : N ;
    dog_N : N ;
    dust_N : N ;
    ear_N : N ;
    earth_N : N ;
    egg_N : N ;
    eye_N : N ;
    fat_N : N ;
    father_N : N ;
    feather_N : N ;
    fingernail_N : N ;
    fire_N : N ;
    fish_N : N ;
    flower_N : N ;
    fog_N : N ;
    foot_N : N ;
    forest_N : N ;
    fruit_N : N ;
    grass_N : N ;
    guts_N : N ;
    hair_N : N ;
    hand_N : N ;
    head_N : N ;
    heart_N : N ;
    horn_N : N ;
    husband_N : N ;
    ice_N : N ;
    knee_N : N ;
    lake_N : N ;
    leaf_N : N ;
    leg_N : N ;
    liver_N : N ;
    louse_N : N ;
    man_N : N ;
    meat_N : N ;
    moon_N : N ;
    mother_N : N ;
    mountain_N : N ;
    mouth_N : N ;
    name_N : N ;
    neck_N : N ;
    night_N : N ;
    nose_N : N ;
    person_N : N ;
    rain_N : N ;
    river_N : N ;
    road_N : N ;
    root_N : N ;
    rope_N : N ;
    salt_N : N ;
    sand_N : N ;
    sea_N : N ;
    seed_N : N ;
    skin_N : N ;
    sky_N : N ;
    smoke_N : N ;
    snake_N : N ;
    snow_N : N ;
    star_N : N ;
    stick_N : N ;
    stone_N : N ;
    sun_N : N ;
    tail_N : N ;
    tongue_N : N ;
    tooth_N : N ;
    tree_N : N ;
    water_N : N ;
    wife_N : N ;
    wind_N : N ;
    wing_N : N ;
    woman_N : N ;
    worm_N : N ;
    year_N : N ;

    -- Verbs

    bite_V : V ;
    blow_V : V ;
    breathe_V : V ;
    burn_V : V ;
    come_V : V ;
    count_V : V ;
    cut_V : V ;
    die_V : V ;
    dig_V : V ;
    drink_V : V ;
    eat_V : V ;
    fall_V : V ;
    fear_V : V ;
    fight_V : V ;
    float_V : V ;
    flow_V : V ;
    fly_V : V ;
    freeze_V : V ;
    give_V : V ;
    hear_V : V ;
    hit_V : V ;
    hold_V : V ;
    hunt_V : V ;
    kill_V : V ;
    know_V : V ;
    laugh_V : V ;
    lie_V : V ;
    live_V : V ;
    play_V : V ;
    pull_V : V ;
    push_V : V ;
    rub_V : V ;
    say_V : V ;
    scratch_V : V ;
    see_V : V ;
    sew_V : V ;
    sing_V : V ;
    sit_V : V ;
    sleep_V : V ;
    smell_V : V ;
    spit_V : V ;
    split_V : V ;
    squeeze_V : V ;
    stab_V : V ;
    stand_V : V ;
    suck_V : V ;
    swell_V : V ;
    swim_V : V ;
    think_V : V ;
    throw_V : V ;
    tie_V : V ;
    turn_V : V ;
    vomit_V : V ;
    walk_V : V ;
    wash_V : V ;
    wipe_V : V ;

}