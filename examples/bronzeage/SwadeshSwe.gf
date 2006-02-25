--# -path=.:../swedish:../common:../abstract:../scandinavian:../../prelude

concrete SwadeshSwe of Swadesh = CatSwe
  ** open MorphoSwe, LangSwe, ParadigmsSwe, IrregSwe, Prelude in {

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
    all_Det  = {s = \\_,_ => "alla" ; n = Pl ; det = DDef Indef} ;
    many_Det = many_Det ;
    some_Det = someSg_Det ;
    few_Det  = {s = \\_,_ => "få" ; n = Pl ; det = DDef Indef} ;
    other_Det = {s = \\_,_ => "andra" ; n = Pl ; det = DDef Indef} ;


    -- Adverbs

    here_Adv = here_Adv ;
    there_Adv = there_Adv ;
    where_IAdv = where_IAdv ;
    when_IAdv = when_IAdv ;
    how_IAdv = how_IAdv ;
    far_Adv = mkAdv ["långt borta"] ;

    -- not : Adv ; -- ?

    -- Conjunctions

    and_Conj = and_Conj ;

    -- Prepositions

    at_Prep = ss "vid" ;
    in_Prep = ss "i" ;
    with_Prep = ss "med" ;

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
    correct_A = regA "riktig" ;
    dirty_A = dirty_A ;
    dry_A = regA "torr" ;
    dull_A = mk2A "slö" "slött";
    full_A = regA "full" ;
    good_A = good_A ;
    green_A = green_A ;
    heavy_A = irregA "tung" "tyngre" "tyngst" ;
    left_A = regA "vänster" ; ----
    long_A = long_A ;
    narrow_A = narrow_A ;
    near_A = mkA "nära" "nära" "nära" "nära"
                       "närmare" "närmast" "närmaste" ;
    new_A = new_A ;
    old_A = old_A ;
    red_A = red_A ;
    right_A = regA "höger" ; ----
    rotten_A = mk3A "rutten" "ruttet" "ruttna" ;
    round_A = regA "rund" ;
    sharp_A = regA "vass" ;
    short_A = short_A ;
    small_A = small_A ;
    smooth_A = regA "slät" ;
    straight_A = regA "rak" ;
    thick_A = thick_A ;
    thin_A = thin_A ;
    warm_A = warm_A ;
    wet_A = regA "våt" ;
    white_A = white_A ;
    wide_A = mk2A "bred" "brett" ;
    yellow_A = yellow_A ;


    -- Nouns

    animal_N = mk2N "djur" "djur" ;
    ashes_N = mk2N "aska" "askor" ;
    back_N = mk2N "rygg" "ryggar" ;
    bark_N = mk2N "bark" "barkar" ;
    belly_N = mk2N "mage" "magar" ;
    bird_N = bird_N ;
    blood_N = mk2N "blod" "blod" ;
    bone_N = mk2N "ben" "ben" ;
    breast_N = mk2N "bröst" "bröst" ;
    child_N = child_N ;
    cloud_N = mk2N "moln" "moln" ;
    day_N = mk2N "dag" "dagar" ;
    dog_N = dog_N ;
    dust_N = mk2N "damm" "damm" ;
    ear_N = mkN "öra" "örat" "öron" "öronen" ;
    earth_N = mk2N "jord" "jordar" ;
    egg_N = mk2N "ägg" "ägg" ;
    eye_N = mkN "öga" "ögat" "ögon" "ögonen" ;
    fat_N = mk2N "fett" "fett" ;
    father_N = (mkN "far" "fadern" "fäder" "fäderna") ;
--    father_N = UseN2 father_N2 ;
    feather_N = mk2N "fjäder" "fjädrar" ;
    fingernail_N = mkN "nagel" "nageln" "naglar" "naglarna";
    fire_N = mk2N "eld" "eldar" ;
    fish_N = fish_N ;
    flower_N = mk2N "blomma" "blommor" ;
    fog_N = mk2N "dimma" "dimmor" ;
    foot_N = mk2N "fot" "fötter" ;
    forest_N = mk2N "skog" "skogar" ;
    fruit_N = fruit_N ;
    grass_N = mk2N "gräs" "gräs" ;
    guts_N = mk2N "inälva" "inälvor" ;
    hair_N = mk2N "hår" "hår" ;
    hand_N = mk2N "hand" "händer" ;
    head_N = mkN "huvud" "huvudet" "huvuden" "huvudena" ;
    heart_N = mkN "hjärta" "hjärtat" "hjärtan" "hjärtana" ;
    horn_N = mk2N "horn" "horn" ;
    husband_N = (mk2N "make" "makar") ;
    ice_N = mk2N "is" "isar" ;
    knee_N = mkN "knä" "knäet" "knän" "knäna" ;
    lake_N = lake_N ;
    leaf_N = mk2N "löv" "löv" ;
    leg_N = mk2N "ben" "ben" ;
    liver_N = mkN "lever" "levern" "levrar" "levrarna";
    louse_N = mkN "lus" "lusen" "löss" "lössen" ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
    mother_N = mkN "mor" "modern" "mödrar" "mödrarna" ;
--    mother_N = UseN2 mother_N2 ;
    mountain_N = mountain_N ;
    mouth_N = mk2N "mun" "munnar" ;
    name_N = mk2N "namn" "namn" ;
    neck_N = mk2N "nacke" "nackar" ;
    night_N = mk2N "natt" "nätter" ;
    nose_N = mk2N "näsa" "näsor" ;
    person_N = mk2N "person" "personer" ;
    rain_N = mk2N "regn" "regn" ;
    river_N = river_N ;
    road_N = mk2N "väg" "vägar" ;
    root_N = mk2N "rot" "rötter" ;
    rope_N = mk2N "rep" "rep" ;
    salt_N = mk2N "salt" "salter" ;
    sand_N = mk2N "sand" "sander" ;
    sea_N = sea_N ;
    seed_N = mkN "frö" "fröet" "frön" "fröna" ;
    skin_N = mk2N "skinn" "skinn" ;
    sky_N = mk2N "himmel" "himlar" ;
    smoke_N = mk2N "rök" "rökar" ;
    snake_N = snake_N ;
    snow_N = mkN "snö" "snön" "snöer" "snöerna" ;
    star_N = star_N ;
    stick_N = mk2N "pinne" "pinnar" ;
    stone_N = stone_N ;
    sun_N = sun_N ;
    tail_N = mk2N "svans" "svansar" ;
    tongue_N = mk2N "tunga" "tungor" ;
    tooth_N = mk2N "tand" "tänder" ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = mk2N "fru" "fruar" ;
    wind_N = mk2N "vind" "vindar" ;
    wing_N = mk2N "vinge" "vingar" ;
    woman_N = woman_N ;
    worm_N = mk2N "mask" "maskar" ;
    year_N = mk2N "år" "år" ;

    -- Verbs

    bite_V = dirV2 (bita_V) ;
    blow_V = mk2V "blåsa" "blåste" ;
    breathe_V = dirV2 (depV (regV "anda")) ;
    burn_V = brinna_V ; -- FIXME: bränna?
    come_V = komma_V ;
    count_V = dirV2 (regV "räkna") ;
    cut_V = dirV2 (skära_V) ;
    die_V = dö_V ;
    dig_V = mk2V "gräva" "grävde" ;
    drink_V = dirV2 (dricka_V) ;
    eat_V = dirV2 (äta_V) ;
    fall_V = falla_V ;
    fear_V = dirV2 (regV "frukta") ;
      -- FIXME: passive forms are very strange
    fight_V = dirV2 (mkV "slåss" "slåss" "slåss" "slogs" "slagits" "slagen") ;
    float_V = flyta_V ;
    flow_V = rinna_V ;
    fly_V = flyga_V ;
    freeze_V = frysa_V ;
    give_V = dirdirV3 giva_V ; ----
    hear_V = dirV2 (mk2V "höra" "hörde") ;
    hit_V = dirV2 (slå_V) ;
    hold_V = dirV2 (hålla_V) ;
    hunt_V = dirV2 (regV "jaga") ;
    kill_V = dirV2 (regV "döda") ;
    know_V = dirV2 (veta_V) ;
    laugh_V = regV "skratta" ;
    lie_V = ligga_V ;
    live_V = leva_V ;
    play_V = mk2V "leka" "lekte" ;
    pull_V = dirV2 (draga_V) ;
    push_V = dirV2 (mk2V "trycka" "tryckte") ;
    rub_V = dirV2 (gnida_V) ;
    say_V = säga_V ;
    scratch_V = dirV2 (regV "klia") ;
    see_V = dirV2 (se_V) ;
    sew_V = sy_V ;
    sing_V = sjunga_V ;
    sit_V = sitta_V ;
    sleep_V = sova_V ;
    smell_V = dirV2 (regV "lukta") ;
    spit_V = regV "spotta" ;
    split_V = dirV2 (klyva_V) ;
    squeeze_V = dirV2 (klämma_V) ;
    stab_V = dirV2 (sticka_V) ;
    stand_V = stå_V ;
    suck_V = dirV2 (suga_V) ;
    swell_V = svälla_V ;
    swim_V = regV "simma" ;
    think_V = mk2V "tänka" "tänkte" ;
    throw_V = dirV2 (regV "kasta") ;
    tie_V = dirV2 (knyta_V) ;
    turn_V = vända_V ;
    vomit_V = mk2V "spy" "spydde" ;
    walk_V = gå_V ;
    wash_V = dirV2 (regV "tvätta") ;
    wipe_V = dirV2 (regV "torka") ;

}
