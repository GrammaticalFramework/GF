--# -path=.:../italian:../common:../abstract:../../prelude:../romance

concrete SwadeshIta of Swadesh = CatIta
  ** open PhonoIta, MorphoIta, LangIta, ParadigmsIta, BeschIta, Prelude in {

  lincat
    MassN = N ;

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
    all_Det  = {
      s = \\g,c => prepCase c ++ genForms ["tutti i"] ["tutte le"] ! g ;
      n = Pl
      } ;
    many_Det = many_Det ;
    some_Det = someSg_Det ;
    few_Det  = {s = \\g,c => prepCase c ++ genForms "pochi" "poche" ! g ; n = Pl} ;
    other_Det = {
      s = \\g,c => prepCase c ++ genForms "altri" "altre" ! g ;
      n = Pl
      } ;

--    left_Ord = regA "sinistro" ;
--    right_Ord = regA "destro" ;

    -- Adverbs

    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;
    far_Adv = mkAdv "lontano" ;

    -- not : Adv ; -- ?

    -- Conjunctions

    and_Conj = and_Conj ;

    -- Prepositions

    at_Prep = dative ;
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
    correct_A = regA "corretto" ;
    dirty_A = dirty_A ;
    dry_A = regA "secco" ;
    dull_A = regA "noioso" ;
    full_A = regA "pieno" ;
    good_A = good_A ;
    green_A = green_A ;
    heavy_A = regA "pesante" ;
    long_A = long_A ;
    narrow_A = narrow_A ;
    near_A = regA "vicino" ;
    new_A = new_A ;
    old_A = old_A ;
    red_A = red_A ;
    rotten_A = regA "marcio" ;
    round_A = regA "rotondo" ;
    sharp_A = regA "aguzzo" ;
    short_A = short_A ;
    small_A = small_A ;
    smooth_A = regA "liscio" ;
    straight_A = regA "diretto" ;
    thick_A = thick_A ;
    thin_A = thin_A ;
    warm_A = warm_A ;
    wet_A = regA "bagnato" ;
    white_A = white_A ;
    wide_A = regA "largo" ;
    yellow_A = yellow_A ;

    -- Nouns

    animal_N = regN "animale" ;
    ashes_N = regN "cenere" ;
    back_N = regN "schiena" ;
    bark_N = regN "corteccia" ; 
    belly_N = regN "pancia" ;
    bird_N = bird_N;
    blood_N = regN "sangue" ;
    bone_N = regN "osso" ;
    breast_N = regN "seno" ;
    child_N = child_N ;
    cloud_N = regN "nuvola" ;
    day_N = regN "giorno" ;
    dog_N = dog_N ;
    dust_N = regN "polvere" ;
    ear_N = regN "orecchio" ;
    earth_N = regN "terra" ;
    egg_N = mkN "uovo" "uova" masculine ; -- fem in Pl
    eye_N = regN "occhio" ;
    fat_N = regN "grasso" ;
    father_N = UseN2 father_N2 ;
    feather_N = regN "piuma" ;
    fingernail_N = regN "unghia" ;
    fire_N = regN "fuoco" ;
    fish_N = fish_N ;
    flower_N = regN "fiore" ;
    fog_N = regN "nebbia" ;
    foot_N = regN "piede" ;
    forest_N = regN "bosco" ;
    fruit_N = fruit_N ;
    grass_N = regN "erba" ;
    guts_N = regN "intestino" ;
    hair_N = regN "capello" ;
    hand_N = femN (regN "mano") ;
    head_N = regN "testa" ;
    heart_N = regN "cuore" ;
    horn_N = regN "corno" ;
    husband_N = regN "marito" ;
    ice_N = regN "ghiaccio" ;
    knee_N = regN "ginocchio" ;
    lake_N = lake_N ;
    leaf_N = regN "foglia" ;
    leg_N = regN "gamba" ;
    liver_N = regN "fegato" ;
    louse_N = regN "pidocchio" ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
    mother_N = UseN2 mother_N2 ;
    mountain_N = mountain_N ;
    mouth_N = regN "bocca" ;
    name_N = regN "nome" ;
    neck_N = regN "collo" ;
    night_N = femN (regN "notte") ;
    nose_N = regN "naso" ;
    person_N = regN "persona" ;
    rain_N = regN "pioggia" ;
    river_N = river_N ;
    road_N = regN "strada" ;
    root_N = femN (regN "radice") ;
    rope_N = regN "corda" ;
    salt_N = regN "sale" ;
    sand_N = regN "sabbia" ;
    sea_N = sea_N ;
    seed_N = regN "seme" ;
    skin_N = femN (regN "pelle") ;
    sky_N = regN "cielo" ; 
    smoke_N = regN "fumo" ;
    snake_N = snake_N ;
    snow_N = femN (regN "neve") ;
    star_N = star_N ;
    stick_N = regN "bastone" ;
    stone_N = stone_N ;
    sun_N = sun_N ;
    tail_N = regN "coda" ;
    tongue_N = regN "lingua" ;
    tooth_N = regN "dente" ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = regN "donna" ;
    wind_N = regN "vento" ;
    wing_N = regN "ala" ;
    woman_N = woman_N ;
    worm_N = regN "verme" ;
    year_N = regN "anno" ;

    -- Verbs

    bite_V = dirV2 (verboV (esplodere_51 "mordere")) ;
    blow_V = regV "soffiare" ;
    breathe_V = dirV2 (regV "respirare") ;
    burn_V = regV "bruciare" ;
    come_V = come_V ;
    count_V = dirV2 (regV "contare") ;
    cut_V = dirV2 (regV "tagliare") ;
    die_V = die_V ;
    dig_V = regV "scavare" ;
    drink_V = dirV2 (drink_V2) ;
    eat_V = dirV2 (regV "mangiare") ;
    fall_V = essereV (verboV (cadere_28 "cadere")) ;
    fear_V = dirV2 (fear_VS) ;
    fight_V = dirV2 (regV "lottare") ;
    float_V = regV "galleggiare" ;
    flow_V = verboV (finire_100 "fluire") ;
    fly_V = regV "volare" ;
    freeze_V = regV "gelare" ;
    give_V = dirdirV3 (verboV (dare_15 "dare")) ;
    hear_V = dirV2 (hear_V2) ;
    hit_V = dirV2 (regV "colpire") ;
    hold_V = dirV2 (verboV (venire_110 "tenire")) ;
    hunt_V = dirV2 (regV "cacciare") ;
    kill_V = dirV2 (verboV (ridere_74 "uccidere")) ;
    know_V = dirV2 (know_V2) ;
    laugh_V = verboV (ridere_74 "ridere") ;
    lie_V = verboV (piacere_64 "giacere") ;
    live_V = live_V ;
    play_V = regV "giocare" ;
    pull_V = dirV2 (regV "tirare") ;
    push_V = dirV2 (verboV (cingere_31 "spingere")) ;
    rub_V = dirV2 (regV "strofinare") ;
    say_V = say_VS ;
    scratch_V = dirV2 (regV "graffiare") ;
    see_V = dirV2 (see_V2) ;
    sew_V = verboV (cucire_103 "cucire") ;
    sing_V = regV "cantare" ;
    sit_V = reflV (verboV (sedere_84 "sedere")) ;
    sleep_V = sleep_V ;
    smell_V = dirV2 (verboV (sentire_99 "sentire")) ;
    spit_V = regV "sputare" ;
    split_V = dirV2 (verboV (ridere_74 "dividere")) ;
    squeeze_V = dirV2 (verboV (temere_20 "spremere")) ;
    stab_V = dirV2 (regV "pugnalare") ;
    stand_V = verboV (stare_16 "stare") ;   ---- in piedi
    suck_V = dirV2 (regV "succhiare") ;
    swell_V = regV "gonfiare" ;
    swim_V = regV "nuotare" ;
    think_V = regV "pensare" ;
    throw_V = dirV2 (regV "gettare") ;
    tie_V = dirV2 (regV "legare") ;
    turn_V = regV "tornare" ;
    vomit_V = regV "vomitare" ;
    walk_V = regV "camminare" ;
    wash_V = dirV2 (regV "lavare") ;
    wipe_V = dirV2 (regV "asciugare") ;

}
