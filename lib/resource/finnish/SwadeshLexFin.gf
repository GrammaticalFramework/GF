--# -path=.:../abstract:../../prelude

concrete SwadeshLexFin of SwadeshLex = CategoriesFin 
  ** open ResourceFin, SyntaxFin, ParadigmsFin, 
          BasicFin, Prelude in {

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
    all_NDet = ResourceFin.all_NDet ;
    many_Det = many_Det ;
    some_Det = some_Det ;
    few_Det = mkDeterminer Pl (\\c => (sTalo "muutama").s ! NCase Pl c) ;
    other_Det = mkDeterminer Pl  (\\c => (sPuu "muu").s ! NCase Pl c) ;


    -- Adverbs

    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;

    -- not : Adv ; -- ?

    -- Conjunctions

    and_Conj = and_Conj ;

    -- Prepositions

    at_Prep = prepCase Adess ;
    in_Prep = prepCase Iness ;
    with_Prep = prepPostpGen "kanssa" ;

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
    correct_ADeg = regADeg "oikea" ;
    dirty_ADeg = dirty_ADeg ;
    dry_ADeg = mkADeg (regN "kuiva") "kuivempi" "kuivin" ;
    dull_ADeg = mkADeg (regN "tylsä") "tylsempi" "tylsin" ;
    far_ADeg = regADeg "kaukainen" ;
    full_ADeg = mkADeg (reg3N "täysi" "täyden" "täysiä") "täydempi" "täysin" ;
    good_ADeg = good_ADeg ;
    green_ADeg = green_ADeg ;
    heavy_ADeg = regADeg "raskas" ;
    long_ADeg = long_ADeg ;
    narrow_ADeg = narrow_ADeg ;
    near_ADeg = regADeg "läheinen" ;
    new_ADeg = new_ADeg ;
    old_ADeg = old_ADeg ;
    red_ADeg = red_ADeg ;
    rotten_ADeg = regADeg "mätä" ;
    round_ADeg = regADeg "pyöreä" ;
    sharp_ADeg = regADeg "terävä" ;
    short_ADeg = short_ADeg ;
    small_ADeg = small_ADeg ;
    smooth_ADeg = regADeg "sileä" ;
    straight_ADeg = mkADeg (regN "suora") "suorempi" "suorin" ;
    thick_ADeg = thick_ADeg ;
    thin_ADeg = thin_ADeg ;
    warm_ADeg = warm_ADeg ;
    wet_ADeg = mkADeg (regN "märkä") "märempi" "märin" ;
    white_ADeg = white_ADeg ;
    wide_ADeg = regADeg "leveä" ;
    yellow_ADeg = yellow_ADeg ;

    left_A = mkA (regN "vasen") ; ----
    right_A = mkA (regN "oikea") ;

    -- Nouns

    animal_N = reg3N "eläin" "eläimen" "eläimiä" ;
    ashes_N = regN "tuhka" ;
    back_N = regN "selkä" ;
    bark_N = regN "kaarna" ;
    belly_N = regN "vatsa" ;
    bird_N = bird_N;
    blood_N = nMeri "veri" ;
    bone_N = regN "luu" ;
    breast_N = regN "rinta" ;
    child_N = child_N ;
    cloud_N = reg2N "pilvi" "pilviä" ;
    day_N = regN "päivä" ;
    dog_N = dog_N ;
    dust_N = regN "pöly" ;
    ear_N = regN "korva" ;
    earth_N = regN "maa" ;
    egg_N = regN "muna" ;
    eye_N = regN "silmä" ;
    fat_N = regN "rasva" ;
    father_N = regN "isä" ;
    feather_N = reg3N "höyhen" "höyhenen" "höyheniä" ;
    fingernail_N = reg3N "kynsi" "kynnen" "kynsiä" ;
    fire_N = reg2N "tuli" "tulia" ;
    fish_N = fish_N ;
    flower_N = regN "kukka" ;
    fog_N = regN "sumu" ;
    foot_N = regN "jalka" ;
    forest_N = regN "metsä" ;
    fruit_N = fruit_N ;
    grass_N = regN "ruoho" ;
    guts_N = regN "sisälmys" ; --- suoli
    hair_N = regN "hius" ;
    hand_N = reg3N "käsi" "käden" "käsiä" ;
    head_N = regN "pää" ;
    heart_N = reg3N "sydän" "sydämen" "sydämiä" ;
    horn_N = reg2N "sarvi" "sarvia" ;
    husband_N = man_N ; --- aviomies
    ice_N = regN "jää" ;
    knee_N = reg2N "polvi" "polvia" ;
    lake_N = lake_N ;
    leaf_N = reg2N "lehti" "lehtiä" ;
    leg_N = regN "jalka" ; --- sääri
    liver_N = regN "maksa" ;
    louse_N = regN "lude" ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
    mother_N = regN "äiti" ;
    mountain_N = mountain_N ;
    mouth_N = regN "suu" ;
    name_N = reg2N "nimi" "nimiä" ;
    neck_N = regN "niska" ;
    night_N = regN "yö" ;
    nose_N = regN "nenä" ;
    person_N = regN "henkilö" ;
    rain_N = regN "sade" ;
    river_N = river_N ;
    road_N = regN "tie" ;
    root_N = reg3N "juuri" "juuren" "juuria" ;
    rope_N = reg3N "köysi" "köyden" "köysiä" ;
    salt_N = regN "suola" ;
    sand_N = regN "hiekka" ;
    sea_N = sea_N ;
    seed_N = regN "siemen" ;
    skin_N = regN "nahka" ;
    sky_N = reg3N "taivas" "taivaan" "taivaita" ;
    smoke_N = regN "savu" ;
    snake_N = snake_N ;
    snow_N = sgpartN (nMeri "lumi") "lunta" ;
    star_N = star_N ;
    stick_N = regN "keppi" ;
    stone_N = stone_N ;
    sun_N = sun_N ;
    tail_N = regN "häntä" ;
    tongue_N = reg2N "kieli" "kieliä" ;
    tooth_N = regN "hammas" ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = regN "vaimo" ;
    wind_N = reg2N "tuuli" "tuulia" ;
    wing_N = reg2N "siipi" "siipiä" ;
    woman_N = woman_N ;
    worm_N = regN "mato" ;
    year_N = reg3N "vuosi" "vuoden" "vuosia" ;

    -- Verbs

    bite_V = regV "purra" ;
    blow_V = regV "puhaltaa" ;
    breathe_V = regV "hengittää" ;
    burn_V = regV "palaa" ;
    come_V = BasicFin.come_V ;
    count_V = regV "laskea" ;
    cut_V = reg3V "leikata" "leikkaan" "leikkasi" ;
    die_V = regV "kuolla";
    dig_V = regV "kaivaa" ;
    drink_V = UseV2 drink_V2 ;
    eat_V = UseV2 eat_V2 ;
    fall_V = reg3V "pudota" "putoan" "putosi" ;
    fear_V = reg3V "pelätä" "pelkään" "pelkäsi" ;
    fight_V = regV "taistella" ;
    float_V = regV "kellua" ;
    flow_V = reg3V "virrata" "virtaan" "virtasi" ;
    fly_V = regV "lentää" ;
    freeze_V = regV "jäätyä" ;
    give_V = regV "antaa" ;
    hear_V = UseV2 hear_V2 ;
    hit_V = regV "syödä" ;
    hold_V = regV "pitää" ;
    hunt_V = regV "metsästää" ;
    kill_V = regV "tappaa" ;
    know_V =reg2V "tietää" "tiesin" ;
    laugh_V = reg3V "nauraa" "nauran" "nauroi" ;
    lie_V = reg3V "maata" "makaan" "makasi" ;
    live_V = live_V ;
    play_V = UseV2 play_V2 ;
    pull_V = regV "vetää" ;
    push_V = regV "työntää" ;
    rub_V = regV "hieroa" ;
    say_V = regV "sanoa" ;
    scratch_V = regV "raapia" ;
    see_V = UseV2 see_V2 ;
    sew_V = regV "kylvää" ;
    sing_V = regV "laulaa" ;
    sit_V = regV "istua" ;
    sleep_V = sleep_V ;
    smell_V = reg2V "haistaa" "haistoi" ;
    spit_V = regV "sylkeä" ;
    split_V = reg2V "halkaista" "halkaisi" ;
    squeeze_V = regV "puristaa" ;
    stab_V = regV "pistää" ;
    stand_V = mkV "seistä" "seisoo" "seison" "seisovat" "seiskää" "seistään"
      "seisoi" "seisoin" "seisoisi" "seissyt" "seisty" "seistyn" ; --- *seisoivät
    suck_V = regV "imeä" ;
    swell_V = mkV "turvota" "turpoaa" "turpoan" "turpoavat" "turvotkaa" "turvotaan"
      "turposi" "turposin" "turpoaisi" "turvonnut" "turvottu" "turvotun" ;
    swim_V = reg3V "uida" "uin" "ui" ;
    think_V = reg3V "ajatella" "ajattelen" "ajatteli" ;
    throw_V = regV "heittää" ;
    tie_V = regV "sitoa" ;
    turn_V = regV "kääntyä" ;
    vomit_V = regV "oksentaa" ;
    walk_V = walk_V ;
    wash_V = regV "pestä" ;
    wipe_V = regV "pyyhkiä" ;

}