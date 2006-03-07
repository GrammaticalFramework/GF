incomplete concrete SwadeshI of Swadesh = open Lang in {

  lincat
    MassN = Lang.N ;

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
    many_Det = many_Det ;
    some_Det = someSg_Det ;
----    few_Det =  few_Det ;

   left_Ord = left_Ord ;
   right_Ord = right_Ord ;
    -- Adverbs
    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;
   far_Adv = far_Adv ;
    -- not : Adv ; -- ?
    -- Conjunctions
    and_Conj = and_Conj ;
    -- Prepositions
    in_Prep = in_Prep ;
    with_Prep = with_Prep ;
    -- Numerals
    one_Det = DetSg one_Quant NoOrd ;
    two_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n2))))) ;
    three_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n3))))) ;
    four_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n4))))) ;
    five_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n5))))) ;
    -- Adjectives
    bad_A = bad_A ;
    big_A = big_A ;
    black_A = black_A ;
    cold_A = cold_A ;
   correct_A = correct_A ;
    dirty_A = dirty_A ;
   dry_A = dry_A ;
   dull_A = dull_A ;
   full_A = full_A ;
    good_A = good_A ;
    green_A = green_A ;
   heavy_A = heavy_A ;
    long_A = long_A ;
    narrow_A = narrow_A ;
   near_A = near_A ;
    new_A = new_A ;
    old_A = old_A ;
---- other_A = other_A ;
    red_A = red_A ;
   rotten_A = rotten_A ;
   round_A = round_A ;
   sharp_A = sharp_A ;
    short_A = short_A ;
    small_A = small_A ;
   smooth_A = smooth_A ;
   straight_A = straight_A ;
    thick_A = thick_A ;
    thin_A = thin_A ;
    warm_A = warm_A ;
   wet_A = wet_A ;
    white_A = white_A ;
   wide_A = wide_A ;
    yellow_A = yellow_A ;
    -- Nouns
   animal_N = animal_N ;
   ashes_N = ashes_N ;
   back_N = back_N ;
   bark_N = bark_N ;
   belly_N = belly_N ;
    bird_N = bird_N;
   blood_N = blood_N ;
   bone_N = bone_N ;
   breast_N = breast_N ;
    child_N = child_N ;
   cloud_N = cloud_N ;
   day_N = day_N ;
    dog_N = dog_N ;
   dust_N = dust_N ;
   ear_N = ear_N ;
   earth_N = earth_N ;
   egg_N = egg_N ;
   eye_N = eye_N ;
   fat_N = fat_N ;
   feather_N = feather_N ;
   fingernail_N = fingernail_N ;
   fire_N = fire_N ;
    fish_N = fish_N ;
   flower_N = flower_N ;
   fog_N = fog_N ;
   foot_N = foot_N ;
   forest_N = forest_N ;
    fruit_N = fruit_N ;
   grass_N = grass_N ;
   guts_N = guts_N ;
   hair_N = hair_N ;
   hand_N = hand_N ;
   head_N = head_N ;
   heart_N = heart_N ;
   horn_N = horn_N ;
    husband_N = man_N ; --- aviomies
   ice_N = ice_N ;
   knee_N = knee_N ;
    lake_N = lake_N ;
   leaf_N = leaf_N ;
   leg_N = leg_N ;
   liver_N = liver_N ;
   louse_N = louse_N ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
----   mother_N = mother_N ;
    mountain_N = mountain_N ;
   mouth_N = mouth_N ;
   name_N = name_N ;
   neck_N = neck_N ;
   night_N = night_N ;
   nose_N = nose_N ;
   person_N = person_N ;
   rain_N = rain_N ;
    river_N = river_N ;
   road_N = road_N ;
   root_N = root_N ;
   rope_N = rope_N ;
   salt_N = salt_N ;
   sand_N = sand_N ;
    sea_N = sea_N ;
   seed_N = seed_N ;
   skin_N = skin_N ;
   sky_N = sky_N ;
   smoke_N = smoke_N ;
    snake_N = snake_N ;
   snow_N = snow_N ;
    star_N = star_N ;
   stick_N = stick_N ;
    stone_N = stone_N ;
    sun_N = sun_N ;
   tail_N = tail_N ;
   tongue_N = tongue_N ;
   tooth_N = tooth_N ;
    tree_N = tree_N ;
    water_N = water_N ;
   wife_N = wife_N ;
   wind_N = wind_N ;
   wing_N = wing_N ;
    woman_N = woman_N ;
   worm_N = worm_N ;
   year_N = year_N ;
    -- Verbs
   bite_V2 = bite_V2 ;
   blow_V = blow_V ;
   breathe_V = breathe_V ;
   burn_V = burn_V ;
    come_V = come_V ;
   count_V2 = count_V2 ;
   cut_V2 = cut_V2 ;
   die_V = die_V ;
   dig_V = dig_V ;
    drink_V2 =  ( drink_V2) ;
    eat_V2 =  ( eat_V2) ;
   fall_V = fall_V ;
   fear_V2 = fear_V2 ;
   fight_V2 = fight_V2 ;
   float_V = float_V ;
   flow_V = flow_V ;
   fly_V = fly_V ;
   freeze_V = freeze_V ;
   give_V3 = give_V3 ;
    hear_V2 = hear_V2 ;
   hit_V2 = hit_V2 ;
   hold_V2 = hold_V2 ;
   hunt_V2 = hunt_V2 ;
   kill_V2 = kill_V2 ;
   know_V2 = know_V2 ;
   laugh_V = laugh_V ;
   lie_V = lie_V ;
    live_V = live_V ;
    play_V =  play_V2 ;
   pull_V2 = pull_V2 ;
   push_V2 = push_V2 ;
   rub_V2 = rub_V2 ;
   say_V = say_VS ;
   scratch_V2 = scratch_V2 ;
    see_V2 = ( see_V2) ;
   sew_V = sew_V ;
   sing_V = sing_V ;
   sit_V = sit_V ;
    sleep_V = sleep_V ;
   smell_V = smell_V ;
   spit_V = spit_V ;
   split_V2 = split_V2 ;
   squeeze_V2 = squeeze_V2 ;
   stab_V2 = stab_V2 ;
   stand_V = stand_V ;
   suck_V2 = suck_V2 ;
   swell_V = swell_V ;
   swim_V = swim_V ;
   think_V = think_V ;
   throw_V2 = throw_V2 ;
   tie_V2 = tie_V2 ;
   turn_V = turn_V ;
   vomit_V = vomit_V ;
    walk_V = walk_V ;
   wash_V2 = wash_V2 ;
   wipe_V2 = wipe_V2 ;



}
