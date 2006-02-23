--# -path=.:../abstract:../common:../english:../../prelude

concrete SwadeshEng of Swadesh = CatEng 
  ** open MorphoEng, LangEng, ParadigmsEng, IrregEng, Prelude in {

  lin

    -- Pronouns

    i_NP = i_Pron ;
    youSg_NP = youSg_Pron ;
    he_NP = he_Pron ;
    we_NP = we_Pron ;
    youPl_NP = youPl_Pron ;
    they_NP = they_Pron ;
    whoPl_IP = whoPl_IP ;
    whoSg_IP = whoSg_IP ;
    whatPl_IP = whatPl_IP ;
    whatSg_IP = whatSg_IP ;

    -- Determiners

    this_Det = DetSg (SgQuant this_Quant) NoOrd ;
    that_Det = DetSg (SgQuant that_Quant) NoOrd ;
    all_Det = mkDeterminer Pl "all" ;
    many_Det = many_Det ;
    some_Det = someSg_Det ;
    few_Det = mkDeterminer Pl "few" ;
    other_Det = mkDeterminer Pl "other" ;


    -- Adverbs

    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;
    far_Adv = mkAdv "far" ;

    -- not : Adv ; -- ?

    -- Conjunctions

    and_Conj = and_Conj ;

    -- Prepositions

    at_Prep = ss "at" ;
    in_Prep = ss "in" ;
    with_Prep = ss "with" ;

    -- Numerals

    one_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 pot01)))) ;
    two_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n2))))) ;
    three_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n3))))) ;
    four_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n4))))) ;
    five_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n5))))) ;

    -- Adjectives

    bad_A = bad_A ;
    big_A = big_A ;
    black_A = black_A ;
    cold_A = cold_A ;
    correct_A = (regA "correct") ;
    dirty_A = dirty_A ;
    dry_A = regA "dry" ;
    dull_A = regA "dull" ;
    full_A = regA "full" ;
    good_A = good_A ;
    green_A = green_A ;
    heavy_A = regA "heavy" ;
    long_A = long_A ;
    narrow_A = narrow_A ;
    near_A = regA "near" ;
    new_A = new_A ;
    old_A = old_A ;
    red_A = red_A ;
    rotten_A = (regA "rotten") ;
    round_A = regA "round" ;
    sharp_A = regA "sharp" ;
    short_A = short_A ;
    small_A = small_A ;
    smooth_A = regA "smooth" ;
    straight_A = regA "straight" ;
    thick_A = thick_A ;
    thin_A = thin_A ;
    warm_A = warm_A ;
    wet_A = regA "wet" ; ----
    white_A = white_A ;
    wide_A = regA "wide" ;
    yellow_A = yellow_A ;

    left_A = regA "left" ;
    right_A = regA "right" ;

    -- Nouns

    animal_N = regN "animal" ;
    ashes_N = regN "ash" ; -- FIXME: plural only?
    back_N = regN "back" ;
    bark_N = regN "bark" ;
    belly_N = regN "belly" ;
    bird_N = bird_N;
    blood_N = regN "blood" ;
    bone_N = regN "bone" ;
    breast_N = regN "breast" ;
    child_N = child_N ;
    cloud_N = regN "cloud" ;
    day_N = regN "day" ;
    dog_N = dog_N ;
    dust_N = regN "dust" ;
    ear_N = regN "ear" ;
    earth_N = regN "earth" ;
    egg_N = regN "egg" ;
    eye_N = regN "eye" ;
    fat_N = regN "fat" ;
    father_N = UseN2 father_N2 ;
    feather_N = regN "feather" ;
    fingernail_N = regN "fingernail" ;
    fire_N = regN "fire" ;
    fish_N = fish_N ;
    flower_N = regN "flower" ;
    fog_N = regN "fog" ;
    foot_N = mk2N "foot" "feet" ;
    forest_N = regN "forest" ;
    fruit_N = fruit_N ;
    grass_N = regN "grass" ;
    guts_N = regN "gut" ; -- FIXME: no singular
    hair_N = regN "hair" ;
    hand_N = regN "hand" ;
    head_N = regN "head" ;
    heart_N = regN "heart" ;
    horn_N = regN "horn" ;
    husband_N = genderN masculine (regN "husband") ;
    ice_N = regN "ice" ;
    knee_N = regN "knee" ;
    lake_N = lake_N ;
    leaf_N = mk2N "leaf" "leaves" ;
    leg_N = regN "leg" ;
    liver_N = regN "liver" ;
    louse_N = mk2N "louse" "lice" ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
    mother_N = UseN2 mother_N2 ;
    mountain_N = mountain_N ;
    mouth_N = regN "mouth" ;
    name_N = regN "name" ;
    neck_N = regN "neck" ;
    night_N = regN "night" ;
    nose_N = regN "nose" ;
    person_N = genderN human (regN "person") ;
    rain_N = regN "rain" ;
    river_N = river_N ;
    road_N = regN "road" ;
    root_N = regN "root" ;
    rope_N = regN "rope" ;
    salt_N = regN "salt" ;
    sand_N = regN "sand" ;
    sea_N = sea_N ;
    seed_N = regN "seed" ;
    skin_N = regN "skin" ;
    sky_N = regN "sky" ; 
    smoke_N = regN "smoke" ;
    snake_N = snake_N ;
    snow_N = regN "snow" ;
    star_N = star_N ;
    stick_N = regN "stick" ;
    stone_N = stone_N ;
    sun_N = sun_N ;
    tail_N = regN "tail" ;
    tongue_N = regN "tongue" ;
    tooth_N = mk2N "tooth" "teeth" ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = genderN feminine (mk2N "wife" "wives") ;
    wind_N = regN "wind" ;
    wing_N = regN "wing" ;
    woman_N = woman_N ;
    worm_N = regN "worm" ;
    year_N = regN "year" ;

    -- Verbs

    bite_V = dirV2 bite_V ;
    blow_V = blow_V ;
    breathe_V = dirV2 (regV "breathe") ;
    burn_V = burn_V ;
    come_V = come_V ;
    count_V = dirV2 (regV "count") ;
    cut_V = dirV2 cut_V ;
    die_V = die_V ;
    dig_V = dig_V ;
    drink_V = dirV2 drink_V ;
    eat_V = dirV2 eat_V ;
    fall_V = fall_V ;
    fear_V = dirV2 (regV "fear") ;
    fight_V = dirV2 fight_V ;
    float_V = regV "float" ;
    flow_V = regV "flow" ;
    fly_V = fly_V ;
    freeze_V = freeze_V ;
    give_V = dirdirV3 give_V ;
    hear_V = dirV2 hear_V ;
    hit_V = dirV2 hit_V ;
    hold_V = dirV2 hold_V ;
    hunt_V = dirV2 (regV "hunt") ;
    kill_V = dirV2 (regV "kill") ;
    know_V = dirV2 know_V ;
    laugh_V = regV "laugh" ;
    lie_V = lie_V ;
    live_V = live_V ;
    play_V = regV "play" ;
    pull_V = dirV2 (regV "pull") ;
    push_V = dirV2 (regV "push") ;
    rub_V = dirV2 (regDuplV "rub") ;
    say_V = say_V ;
    scratch_V = dirV2 (regV "scratch") ;
    see_V = dirV2 see_V ;
    sew_V = sew_V ;
    sing_V = sing_V ;
    sit_V = sit_V ;
    sleep_V = sleep_V ;
    smell_V = dirV2 (regV "smell") ;
    spit_V = spit_V ;
    split_V = dirV2 split_V ;
    squeeze_V = dirV2 (regV "squeeze") ;
    stab_V = dirV2 (regDuplV "stab") ;
    stand_V = stand_V ;
    suck_V = dirV2 (regV "suck") ;
    swell_V = swell_V ;
    swim_V = swim_V ;
    think_V = think_V ;
    throw_V = dirV2 throw_V ;
    tie_V = dirV2 (regV "tie") ;
    turn_V = regV "turn" ;
    vomit_V = regV "vomit" ;
    walk_V = walk_V ;
    wash_V = dirV2 (regV "wash") ;
    wipe_V = dirV2 (regV "wipe") ;

}