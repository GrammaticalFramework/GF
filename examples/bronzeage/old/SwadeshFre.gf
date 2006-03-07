--# -path=.:../french:../common:../abstract:../../prelude:../romance

concrete SwadeshFre of Swadesh = CatFre
  ** open PhonoFre, MorphoFre, LangFre, ParadigmsFre, IrregFre, Prelude in {

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
      s = \\g,c => prepCase c ++ genForms "tous" "toutes" ! g ++ "les" ;
      n = Pl
      } ;
    many_Det = many_Det ;
    some_Det = someSg_Det ;
    few_Det  = {s = \\g,c => prepCase c ++ "peu" ++ elisDe ; n = Pl} ;
    other_Det = {
      s = \\g,c => prepCase c ++ "d'autres" ;   -- de d'autres
      n = Pl
      } ;

    left_Ord = mkOrd (regA "gauche") ;
    right_Ord = mkOrd (regA "droite") ;

  oper
    mkOrd : A -> Ord ;
    mkOrd x = {s = \\ag => x.s ! Posit ! AF ag.g ag.n; lock_Ord = <> } ;

  lin

    -- Adverbs

    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;
    far_Adv = mkAdv "loin" ;

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
    correct_A = regA "correct" ;
    dirty_A = dirty_A ;
    dry_A = (mkA "sec" "sèche" "secs" "sèches") ;
    dull_A = regA "émoussé" ;
    full_A = regA "plein" ;
    good_A = good_A ;
    green_A = green_A ;
    heavy_A = regA "lourd" ;
    long_A = long_A ;
    narrow_A = narrow_A ;
    near_A = regA "proche" ;
    new_A = new_A ;
    old_A = old_A ;
    red_A = red_A ;
    rotten_A = regA "pourri" ;
    round_A = regA "rond" ;
    sharp_A = regA "tranchant" ;
    short_A = short_A ;
    small_A = small_A ;
    smooth_A = regA "lisse" ;
    straight_A = regA "droite" ;
    thick_A = thick_A ;
    thin_A = thin_A ;
    warm_A = warm_A ;
    wet_A = regA "mouillé" ;
    white_A = white_A ;
    wide_A = regA "large" ;
    yellow_A = yellow_A ;

    -- Nouns

    animal_N = regN "animal" ;
    ashes_N = regGenN "cendre" masculine ;
    back_N = regN "dos" ;
    bark_N = regN "écorce" ; 
    belly_N = regGenN "ventre"  masculine ;
    bird_N = bird_N;
    blood_N = regN "sang" ;
    bone_N = regN "os" ;
    breast_N = regN "sein" ; --- poitrine
    child_N = child_N ;
    cloud_N = regGenN "nuage"  masculine ;
    day_N = regN "jour" ;
    dog_N = dog_N ;
    dust_N = regN "poussière" ;
    ear_N = regN "oreille" ;
    earth_N = regN "terre" ;
    egg_N = regN "oeuf" ;
    eye_N = mkN "oeil" "yeux" masculine ;
    fat_N = regN "graisse" ;
    father_N = UseN2 father_N2 ;
    feather_N = regN "plume" ;
    fingernail_N = regGenN "ongle" masculine ;
    fire_N = regN "feu" ;
    fish_N = fish_N ;
    flower_N = regGenN "fleur" feminine ;
    fog_N = regN "brouillard" ;
    foot_N = regN "pied" ;
    forest_N = regGenN "forêt" feminine ;
    fruit_N = fruit_N ;
    grass_N = regN "herbe" ;
    guts_N = regN "entraille" ;
    hair_N = regN "cheveu" ;
    hand_N = regGenN "main" feminine ;
    head_N = regN "tête" ;
    heart_N = regN "coeur" ;
    horn_N = regGenN "corne"  masculine ;
    husband_N = regN "mari" ;
    ice_N = regN "glace" ;
    knee_N = regN "genou" ;
    lake_N = lake_N ;
    leaf_N = regN "feuille" ;
    leg_N = regN "jambe" ;
    liver_N = regGenN "foie"  masculine ;
    louse_N = regN "pou" ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
    mother_N = UseN2 mother_N2 ;
    mountain_N = mountain_N ;
    mouth_N = regN "bouche" ;
    name_N = regN "nom" ;
    neck_N = mkN "cou" "cous" masculine ;
    night_N = regGenN "nuit" feminine ;
    nose_N = regN "nez" ;
    person_N = regN "personne" ;
    rain_N = regN "pluie" ;
    river_N = river_N ;
    road_N = regN "route" ;
    root_N = regN "racine" ;
    rope_N = regN "corde" ;
    salt_N = regN "sel" ;
    sand_N = regGenN "sable"  masculine ;
    sea_N = sea_N ;
    seed_N = regN "graine" ;
    skin_N = regN "peau" ;
    sky_N = mkN "ciel" "cieux" masculine ; 
    smoke_N = regN "fumée" ;
    snake_N = snake_N ;
    snow_N = regN "neige" ;
    star_N = star_N ;
    stick_N = regN "bâton" ;
    stone_N = stone_N ;
    sun_N = sun_N ;
    tail_N = regN "queue" ;
    tongue_N = regN "langue" ;
    tooth_N = regGenN "dent" feminine ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = regN "femme" ;
    wind_N = regN "vent" ;
    wing_N = regN "aile" ;
    woman_N = woman_N ;
    worm_N = regN "ver" ; 
    year_N = regN "an" ; --- année

    -- Verbs

    bite_V = ( mordre_V2) ;
    blow_V = regV "souffler" ;
    breathe_V2 = dirV2 (regV "respirer") ;
    burn_V = regV "brûler" ;
    come_V = venir_V ;
    count_V2 = dirV2 (regV "conter") ;
    cut_V2 = dirV2 (regV "tailler") ;
    die_V = mourir_V ;
    dig_V = regV "creuser" ;
    drink_V = ( boire_V2) ;
    eat_V2 = dirV2 (regV "manger") ;
    fall_V = regV "tomber" ;
    fear_V = ( craindre_V2) ;
    fight_V2 = dirV2 (regV "lutter") ;
    float_V = regV "flotter" ;
    flow_V = regV "couler" ;
    fly_V = regV "voler" ;
    freeze_V = reg3V "geler" "gèle" "gèlera" ;
    give_V = dirdirV3 (regV "donner") ;
    hear_V = ( entendre_V2) ;
    hit_V2 = dirV2 (regV "frapper") ;
    hold_V = ( tenir_V2) ;
    hunt_V2 = dirV2 (regV "chasser") ;
    kill_V2 = dirV2 (regV "tuer") ;
    know_V = ( connaître_V2) ;
    laugh_V =  rire_V2 ;
    lie_V = reflV étendre_V2 ;
    live_V = vivre_V2 ;
    play_V = regV "jouer" ;
    pull_V2 = dirV2 (regV "tirer") ;
    push_V2 = dirV2 (regV "pousser") ;
    rub_V2 = dirV2 (regV "frotter") ;
    say_V = dire_V2 ;
    scratch_V2 = dirV2 (regV "gratter") ;
    see_V = ( voir_V2) ;
    sew_V = coudre_V2 ;
    sing_V = regV "chanter" ;
    sit_V = reflV asseoir_V2 ;
    sleep_V = dormir_V2 ;
    smell_V = v2V ( sentir_V2) ;
    spit_V = regV "cracher" ;
    split_V = ( fendre_V2) ;
    squeeze_V2 = dirV2 (regV "serrer") ;
    stab_V2 = dirV2 (regV "poignarder") ;
    stand_V = reflV (reg3V "lever" "lève" "lèvera") ;
    suck_V2 = dirV2 (regV "sucer") ;
    swell_V = regV "gonfler" ;
    swim_V = regV "nager" ;
    think_V = regV "penser" ;
    throw_V2 = dirV2 (regV "jeter") ;
    tie_V2 = dirV2 (regV "lier") ;
    turn_V = regV "tourner" ;
    vomit_V = regV "vomir" ;
    walk_V = regV "marcher" ;
    wash_V2 = dirV2 (regV "laver") ;
    wipe_V2 = dirV2 (regV "essuyer") ;

}
