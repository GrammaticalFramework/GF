--# -path=.:../abstract:../scandinavian:../../prelude

concrete SwadeshLexSwe of SwadeshLex = CategoriesSwe 
  ** open ResourceSwe, SyntaxSwe, ParadigmsSwe, VerbsSwe, 
          BasicSwe in {

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
    few_Det = mkDeterminerPl "få" IndefP ;
    other_Det = mkDeterminerPl "andra" IndefP ;


    -- Adverbs

    here_Adv = here_Adv ;
    there_Adv = there_Adv ;
    where_IAdv = where_IAdv ;
    when_IAdv = when_IAdv ;
    how_IAdv = how_IAdv ;

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
    correct_ADeg = regADeg "riktig" ;
    dirty_ADeg = dirty_ADeg ;
    dry_ADeg = regADeg "torr" ;
    dull_ADeg = regADeg "slö" ;
    far_ADeg = regADeg "avlägsen" ;
    full_ADeg = regADeg "full" ;
    good_ADeg = good_ADeg ;
    green_ADeg = green_ADeg ;
    heavy_ADeg = irregADeg "tung" "tyngre" "tyngst" ;
    long_ADeg = long_ADeg ;
    narrow_ADeg = narrow_ADeg ;
    near_ADeg = mkADeg "nära" "nära" "nära" "nära" 
                       "närmare" "närmast" "närmaste" ;
    new_ADeg = new_ADeg ;
    old_ADeg = old_ADeg ;
    red_ADeg = red_ADeg ;
    rotten_ADeg = mk3ADeg "rutten" "ruttet" "ruttna" ;

    round_ADeg = regADeg "rund" ;
    sharp_ADeg = regADeg "vass" ;
    short_ADeg = short_ADeg ;
    small_ADeg = small_ADeg ;
    smooth_ADeg = regADeg "slät" ;
    straight_ADeg = regADeg "rak" ;
    thick_ADeg = thick_ADeg ;
    thin_ADeg = thin_ADeg ;
    warm_ADeg = warm_ADeg ;
    wet_ADeg = regADeg "våt" ;
    white_ADeg = white_ADeg ;
    wide_ADeg = mk2ADeg "bred" "brett" ;
    yellow_ADeg = yellow_ADeg ;

    left_A = mkA "vänstra" "vänstra" "vänstra" ;
    right_A = mkA "högra" "högra" "högra" ;

    -- Nouns

    animal_N = regN "djur" neutrum ;
    ashes_N = regN "aska" utrum ;
    back_N = regN "rygg" utrum ;
    bark_N = regN "bark" utrum ;
    belly_N = regN "mage" utrum ;
    bird_N = bird_N;
    blood_N = regN "blod" neutrum ;
    bone_N = regN "ben" neutrum ;
    breast_N = regN "bröst" neutrum ;
    child_N = child_N ;
    cloud_N = regN "moln" neutrum ;
    day_N = regN "dag" utrum ;
    dog_N = dog_N ;
    dust_N = regN "damm" neutrum ;
    ear_N = regN "öra" neutrum ;
    earth_N = regN "jord" utrum ;
    egg_N = regN "ägg" neutrum ;
    eye_N = regN "öga" neutrum;
    fat_N = regN "fett" neutrum ;
--    father_N = UseN2 father_N2 ;
    feather_N = regN "fjäder" utrum ;
    fingernail_N = regN "nagel" utrum ;
    fire_N = regN "eld" utrum ;
    fish_N = fish_N ;
    flower_N = regN "blomma" utrum ;
    fog_N = regN "dimma" utrum ;
    foot_N = mk2N "fot" "fötter" ;
    forest_N = regN "skog" utrum ;
    fruit_N = fruit_N ;
    grass_N = regN "gräs" neutrum ;
    guts_N = regN "inälva" utrum ; -- FIXME: plural only?
    hair_N = regN "hår" neutrum ;
    hand_N = regN "hand" utrum ;
    head_N = regN "huvud" neutrum ;
    heart_N = regN "hjärta" neutrum ;
    horn_N = regN "horn" neutrum ;
    husband_N = mascN (regN "make" utrum) ;
    ice_N = regN "is" utrum ;
    knee_N = regN "knä" neutrum ;
    lake_N = lake_N ;
    leaf_N = mk2N "löv" "löv" ;
    leg_N = mk2N "ben" "ben" ;
    liver_N = regN "lever" utrum ;
    louse_N = mk2N "lus" "löss" ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
--    mother_N = UseN2 mother_N2 ;
    mountain_N = mountain_N ;
    mouth_N = mk2N "mun" "munnar" ;
    name_N = mk2N "namn" "namn" ;
    neck_N = regN "nacke" utrum ;
    night_N = regN "natt" utrum ;
    nose_N = regN "näsa" utrum ;
    person_N = regN "person" utrum;
    rain_N = regN "regn" neutrum ;
    river_N = river_N ;
    road_N = regN "väg" utrum ;
    root_N = regN "rot" utrum ;
    rope_N = regN "rep" neutrum ;
    salt_N = regN "salt" neutrum ;
    sand_N = regN "sand" utrum ;
    sea_N = sea_N ;
    seed_N = regN "frö" neutrum ;
    skin_N = regN "skinn" neutrum ;
    sky_N = mk2N "himmel" "himlar" ; 
    smoke_N = regN "rök" utrum ;
    snake_N = snake_N ;
    snow_N = regN "snö" utrum ;
    star_N = star_N ;
    stick_N = regN "pinne" utrum ;
    stone_N = stone_N ;
    sun_N = sun_N ;
    tail_N = regN "svans" utrum ;
    tongue_N = regN "tunga" utrum ;
    tooth_N = mk2N "tand" "tänder" ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = regN "fru" utrum ;
    wind_N = regN "vind" utrum ;
    wing_N = regN "vinge" utrum ;
    woman_N = woman_N ;
    worm_N = regN "mask" utrum ;
    year_N = regN "år" neutrum ;

--    name_N2 = mkN2 (regN "namn") "på" ;
    mother_N2 = mother_N2 ;
    father_N2 = father_N2 ;

    -- Verbs

    bite_V = bita_V ;
    blow_V = regV "blåsa" ;
--    breathe_V = -- FIXME
    burn_V = brinna_V ; -- FIXME: bränna?
    come_V = komma_V ;
    count_V = regV "räkna" ;
    cut_V = skära_V ;
    die_V = dö_V ;
    dig_V = mk2V "gräva" "gräver" ;
    drink_V = dricka_V ;
    eat_V = äta_V ;
    fall_V = falla_V ;
    fear_V = regV "frukta" ;
--    fight_V = _V ; -- FIXME
    float_V = flyta_V ;
    flow_V = rinna_V ;
    fly_V = flyga_V ;
    freeze_V = frysa_V ;
    give_V = giva_V ;
    hear_V = mk2V "höra" "hör" ;
    hit_V = slå_V;
    hold_V = hålla_V ;
    hunt_V = regV "jaga" ;
    kill_V = regV "döda" ;
    know_V = kunna_V ; -- FIXME: känna? veta?
    laugh_V = regV "skratta" ;
    lie_V = ljuga_V ;
    live_V = mk2V "leva" "levde" ;
    play_V = mk2V "leka" "lekte" ;
    pull_V = draga_V ;
    push_V = mk2V "trycka" "tryckte" ;
    rub_V = smörja_V ;
    say_V = säga_V ;
    scratch_V = regV "klia" ;
    see_V = se_V ;
    sew_V = sy_V ;
    sing_V = sjunga_V ;
    sit_V = sitta_V ;
    sleep_V = sova_V ;
    smell_V = regV "lukta" ;
    spit_V = regV "spotta" ;
    split_V = klyva_V ;
    squeeze_V = regV "krama" ;
    stab_V = hugga_V ;
    stand_V = stå_V ;
    suck_V = suga_V ;
    swell_V = mk2V "svälla" "svällde" ;
    swim_V = regV "simma" ;
    think_V = mk2V "tänka" "tänkte" ;
    throw_V = regV "kasta" ;
    tie_V = knyta_V ;
    turn_V = mk2V "vända" "vände" ;
    vomit_V = mk2V "spy" "spydde" ;
    walk_V = gå_V ;
    wash_V = regV "tvätta" ;
    wipe_V = regV "torka" ;

    give_V3 = dirV3 giva_V "to" ;

}