--# -path=.:../abstract:../../prelude

concrete SwadeshLexEng of SwadeshLex = CategoriesEng 
  ** open ResourceEng, SyntaxEng, ParadigmsEng, VerbsEng, 
          BasicEng in {

  lin

    -- Pronouns

    i_NP = i_NP ;
    thou_NP = thou_NP ;
    he_NP = he_NP ;
    we_NP = we_NP ;
    you_NP = you_NP ;
    they_NP = they_NP ;
    who8many_IP = who8many_IP ;
    who8one_IP = who8one_IP ;
    what8many_IP = what8many_IP ;
    what8one_IP = what8one_IP ;

    -- Determiners

    this_Det = this_Det ;
    that_Det = that_Det ;
    all_NDet = all_NDet ;
    many_Det = many_Det ;
    some_Det = some_Det ;
    few_Det = mkDeterminer Pl "few" ;
    other_Det = mkDeterminer Pl "other" ;


    -- Adverbs

    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;

    -- not : Adv ; -- ?


    -- Numerals

    one_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 pot01)))) ;
    two_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n2))))) ;
    three_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n3))))) ;
    four_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n4))))) ;
    five_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n5))))) ;

    -- Adjectives

    bad_ADeg = bad_ADeg ;
    big_ADeg = big_ADeg ;
    black_ADeg = black_ADeg ;
    cold_ADeg = cold_ADeg ;
    correct_ADeg = compoundADeg (regA "correct") ;
    dirty_ADeg = dirty_ADeg ;
    dry_ADeg = regADeg "dry" ;
    dull_ADeg = regADeg "dull" ;
    far_ADeg = mkADeg "far" (variants { "further"; "farther" }) 
                      (variants { "furthest"; "farthest" }) "far" ;
    full_ADeg = regADeg "full" ;
    good_ADeg = good_ADeg ;
    green_ADeg = green_ADeg ;
    heavy_ADeg = regADeg "heavy" ;
    long_ADeg = long_ADeg ;
    narrow_ADeg = narrow_ADeg ;
    near_ADeg = regADeg "near" ;
    new_ADeg = new_ADeg ;
    old_ADeg = old_ADeg ;
    red_ADeg = red_ADeg ;
    rotten_ADeg = compoundADeg (regA "rotten") ;
    round_ADeg = regADeg "round" ;
    sharp_ADeg = regADeg "sharp" ;
    short_ADeg = short_ADeg ;
    small_ADeg = small_ADeg ;
    smooth_ADeg = regADeg "smooth" ;
    straight_ADeg = regADeg "straight" ;
    thick_ADeg = thick_ADeg ;
    thin_ADeg = thin_ADeg ;
    warm_ADeg = warm_ADeg ;
    wet_ADeg = duplADeg "wet" ;
    white_ADeg = white_ADeg ;
    wide_ADeg = regADeg "wide" ;
    yellow_ADeg = yellow_ADeg ;

    left_A = regA "left" ;
    right_A = regA "right" ;

    -- Nouns

    animal_N = regN "animal" ;
    ashes_N = regN "ashes" ; -- FIXME: plural only?
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
    guts_N = regN "guts" ; -- FIXME: plural only?
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

    bite_V = bite_V ;
    blow_V = blow_V ;
    breathe_V = regV "breathe" ;
    burn_V = burn_V ;
    come_V = come_V ;
    count_V = regV "count" ;
    cut_V = cut_V ;
    die_V = die_V ;
    dig_V = dig_V ;
    drink_V = drink_V ;
    eat_V = eat_V ;
    fall_V = fall_V ;
    fear_V = regV "fear" ;
    fight_V = fight_V ;
    float_V = regV "float" ;
    flow_V = regV "flow" ;
    fly_V = fly_V ;
    freeze_V = freeze_V ;
    give_V = give_V ;
    hear_V = hear_V ;
    hit_V = hit_V ;
    hold_V = hold_V ;
    hunt_V = regV "hunt" ;
    kill_V = regV "kill" ;
    know_V = know_V ;
    laugh_V = regV "laugh" ;
    lie_V = lie_V ;
    live_V = live_V ;
    play_V = UseV2 play_V2 ;
    pull_V = regV "pull" ;
    push_V = regV "push" ;
    rub_V = regDuplV "rub" ;
    say_V = say_V ;
    scratch_V = regV "scratch" ;
    see_V = see_V ;
    sew_V = sew_V ;
    sing_V = sing_V ;
    sit_V = sit_V ;
    sleep_V = sleep_V ;
    smell_V = regV "smell" ;
    spit_V = spit_V ;
    split_V = split_V ;
    squeeze_V = regV "squeeze" ;
    stab_V = regDuplV "stab" ;
    stand_V = stand_V ;
    suck_V = regV "suck" ;
    swell_V = swell_V ;
    swim_V = swim_V ;
    think_V = think_V ;
    throw_V = throw_V ;
    tie_V = regV "tie" ;
    turn_V = regV "turn" ;
    vomit_V = regV "vomit" ;
    walk_V = walk_V ;
    wash_V = regV "wash" ;
    wipe_V = regV "wipe" ;

}