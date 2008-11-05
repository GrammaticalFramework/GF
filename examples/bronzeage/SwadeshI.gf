incomplete concrete SwadeshI of Swadesh = open Syntax, (L = Lexicon) in {

  lincat
    V = Syntax.V ;
    V2 = Syntax.V2 ;
    V3 = Syntax.V3 ;
    A = Syntax.A ;
    N = Syntax.N ;
    Pron = Syntax.Pron ;
    Det = Syntax.Det ;
    Card = Syntax.Card ;
    Prep = Syntax.Prep ;
    IAdv = Syntax.IAdv ;
    IP = Syntax.IP ;
    NP = Syntax.NP ;
    Adv = Syntax.Adv ;
    Conj = Syntax.Conj ;
    Ord = Syntax.Ord ;

    MassN = Syntax.N ;

  lin

    -- Pronouns

    i_NP = mkNP i_Pron ;
    youSg_NP = mkNP youSg_Pron ;
    he_NP = mkNP he_Pron ;
    we_NP = mkNP we_Pron ;
    youPl_NP = mkNP youPl_Pron ;
    they_NP = mkNP they_Pron ;
    whoPl_IP = whoPl_IP ;
    whoSg_IP = whoSg_IP ;
    whatPl_IP = whatPl_IP ;
    whatSg_IP = whatSg_IP ;

    -- Determiners

    this_Det = mkDet this_Quant ;
    that_Det = mkDet that_Quant ;
    many_Det = many_Det ;
    some_Det = someSg_Det ;
----    few_Det =  few_Det ;

--   left_Ord = Syntax.left_Ord ;
--   right_Ord = Syntax.right_Ord ;
    -- Adverbs
    here_Adv = Syntax.here_Adv;
    there_Adv = Syntax.there_Adv;
    where_IAdv = Syntax.where_IAdv;
    when_IAdv = Syntax.when_IAdv;
    how_IAdv = Syntax.how_IAdv;
    far_Adv = L.far_Adv ;
    -- not : Adv ; -- ?
    -- Conjunctions
    and_Conj = and_Conj ;
    -- Prepositions
    in_Prep = Syntax.in_Prep ;
    with_Prep = Syntax.with_Prep ;
    -- Numerals
    one_Det = mkCard n1_Numeral ;
    two_Num = mkCard n2_Numeral ;
    three_Num = mkCard n3_Numeral ;
    four_Num = mkCard n4_Numeral ;
    five_Num = mkCard n5_Numeral ;

    -- Adjectives
    bad_A = L.bad_A ;
    big_A = L.big_A ;
    black_A = L.black_A ;
    cold_A = L.cold_A ;
   correct_A = L.correct_A ;
    dirty_A = L.dirty_A ;
   dry_A = L.dry_A ;
   dull_A = L.dull_A ;
   full_A = L.full_A ;
    good_A = L.good_A ;
    green_A = L.green_A ;
   heavy_A = L.heavy_A ;
    long_A = L.long_A ;
    narrow_A = L.narrow_A ;
   near_A = L.near_A ;
    new_A = L.new_A ;
    old_A = L.old_A ;
---- other_A = L.other_A ;
    red_A = L.red_A ;
   rotten_A = L.rotten_A ;
   round_A = L.round_A ;
   sharp_A = L.sharp_A ;
    short_A = L.short_A ;
    small_A = L.small_A ;
   smooth_A = L.smooth_A ;
   straight_A = L.straight_A ;
    thick_A = L.thick_A ;
    thin_A = L.thin_A ;
    warm_A = L.warm_A ;
   wet_A = L.wet_A ;
    white_A = L.white_A ;
   wide_A = L.wide_A ;
    yellow_A = L.yellow_A ;
    -- Nouns
   animal_N = L.animal_N ;
   ashes_N = L.ashes_N ;
   back_N = L.back_N ;
   bark_N = L.bark_N ;
   belly_N = L.belly_N ;
    bird_N = L.bird_N;
   blood_N = L.blood_N ;
   bone_N = L.bone_N ;
   breast_N = L.breast_N ;
    child_N = L.child_N ;
   cloud_N = L.cloud_N ;
   day_N = L.day_N ;
    dog_N = L.dog_N ;
   dust_N = L.dust_N ;
   ear_N = L.ear_N ;
   earth_N = L.earth_N ;
   egg_N = L.egg_N ;
   eye_N = L.eye_N ;
   fat_N = L.fat_N ;
   feather_N = L.feather_N ;
   fingernail_N = L.fingernail_N ;
   fire_N = L.fire_N ;
    fish_N = L.fish_N ;
   flower_N = L.flower_N ;
   fog_N = L.fog_N ;
   foot_N = L.foot_N ;
   forest_N = L.forest_N ;
    fruit_N = L.fruit_N ;
   grass_N = L.grass_N ;
   guts_N = L.guts_N ;
   hair_N = L.hair_N ;
   hand_N = L.hand_N ;
   head_N = L.head_N ;
   heart_N = L.heart_N ;
   horn_N = L.horn_N ;
    husband_N = L.man_N ; --- aviomies
   ice_N = L.ice_N ;
   knee_N = L.knee_N ;
    lake_N = L.lake_N ;
   leaf_N = L.leaf_N ;
   leg_N = L.leg_N ;
   liver_N = L.liver_N ;
   louse_N = L.louse_N ;
    man_N = L.man_N ;
    meat_N = L.meat_N ;
    moon_N = L.moon_N ;
----   mother_N = L.mother_N ;
    mountain_N = L.mountain_N ;
   mouth_N = L.mouth_N ;
   name_N = L.name_N ;
   neck_N = L.neck_N ;
   night_N = L.night_N ;
   nose_N = L.nose_N ;
   person_N = L.person_N ;
   rain_N = L.rain_N ;
    river_N = L.river_N ;
   road_N = L.road_N ;
   root_N = L.root_N ;
   rope_N = L.rope_N ;
   salt_N = L.salt_N ;
   sand_N = L.sand_N ;
    sea_N = L.sea_N ;
   seed_N = L.seed_N ;
   skin_N = L.skin_N ;
   sky_N = L.sky_N ;
   smoke_N = L.smoke_N ;
    snake_N = L.snake_N ;
   snow_N = L.snow_N ;
    star_N = L.star_N ;
   stick_N = L.stick_N ;
    stone_N = L.stone_N ;
    sun_N = L.sun_N ;
   tail_N = L.tail_N ;
   tongue_N = L.tongue_N ;
   tooth_N = L.tooth_N ;
    tree_N = L.tree_N ;
    water_N = L.water_N ;
   wife_N = L.wife_N ;
   wind_N = L.wind_N ;
   wing_N = L.wing_N ;
    woman_N = L.woman_N ;
   worm_N = L.worm_N ;
   year_N = L.year_N ;
    -- Verbs
   bite_V2 = L.bite_V2 ;
   blow_V = L.blow_V ;
   breathe_V = L.breathe_V ;
   burn_V = L.burn_V ;
    come_V = L.come_V ;
   count_V2 = L.count_V2 ;
   cut_V2 = L.cut_V2 ;
   die_V = L.die_V ;
   dig_V = L.dig_V ;
   drink_V2 = L.drink_V2 ;
   eat_V2 = L.eat_V2 ;
   fall_V = L.fall_V ;
   fear_V2 = L.fear_V2 ;
   fight_V2 = L.fight_V2 ;
   float_V = L.float_V ;
   flow_V = L.flow_V ;
   fly_V = L.fly_V ;
   freeze_V = L.freeze_V ;
   give_V3 = L.give_V3 ;
   hear_V2 = L.hear_V2 ;
   hit_V2 = L.hit_V2 ;
   hold_V2 = L.hold_V2 ;
   hunt_V2 = L.hunt_V2 ;
   kill_V2 = L.kill_V2 ;
   know_V2 = L.know_V2 ;
   laugh_V = L.laugh_V ;
   lie_V = L.lie_V ;
    live_V = L.live_V ;
--    play_V = L. play_V2 ;
   pull_V2 = L.pull_V2 ;
   push_V2 = L.push_V2 ;
   rub_V2 = L.rub_V2 ;
--   say_V = L.say_VS ;
   scratch_V2 = L.scratch_V2 ;
    see_V2 = L.see_V2 ;
   sew_V = L.sew_V ;
   sing_V = L.sing_V ;
   sit_V = L.sit_V ;
    sleep_V = L.sleep_V ;
   smell_V = L.smell_V ;
   spit_V = L.spit_V ;
   split_V2 = L.split_V2 ;
   squeeze_V2 = L.squeeze_V2 ;
   stab_V2 = L.stab_V2 ;
   stand_V = L.stand_V ;
   suck_V2 = L.suck_V2 ;
   swell_V = L.swell_V ;
   swim_V = L.swim_V ;
   think_V = L.think_V ;
   throw_V2 = L.throw_V2 ;
   tie_V2 = L.tie_V2 ;
   turn_V = L.turn_V ;
   vomit_V = L.vomit_V ;
    walk_V = L.walk_V ;
   wash_V2 = L.wash_V2 ;
   wipe_V2 = L.wipe_V2 ;

}
