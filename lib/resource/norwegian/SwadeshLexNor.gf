--# -path=.:../abstract:../scandinavian:../../prelude

concrete SwadeshLexNor of SwadeshLex = CategoriesNor 
  ** open ResourceNor, SyntaxNor, ParadigmsNor, VerbsNor, 
          BasicNor, Prelude in {

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
    other_Det = mkDeterminerPl "andre" IndefP ;


    -- Adverbs

    here_Adv = here_Adv ;
    there_Adv = there_Adv ;
    where_IAdv = where_IAdv ;
    when_IAdv = when_IAdv ;
    how_IAdv = how_IAdv ;

    -- not : Adv ; -- ?

    -- Conjunctions

    and_Conj = and_Conj ;

    -- Prepositions

    at_Prep = ss "ved" ;
    in_Prep = ss "i" ;
    with_Prep = ss "med" ;

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
    dry_ADeg = mk2ADeg "tørr" "tørt" ;
    dull_ADeg = regADeg "sløv" ;
    far_ADeg = regADeg "fjern" ;
    full_ADeg = regADeg "full" ;
    good_ADeg = good_ADeg ;
    green_ADeg = green_ADeg ;
    heavy_ADeg = irregADeg "tung" "tyngre" "tyngst" ;
    left_A = mkA "venstre" "venstre" "venstre" ;
    long_ADeg = long_ADeg ;
    narrow_ADeg = narrow_ADeg ;
    near_ADeg = irregADeg "nære" "nærmere" "nærmest" ;
    new_ADeg = new_ADeg ;
    old_ADeg = old_ADeg ;
    red_ADeg = red_ADeg ;
    right_A = mkA "høyre" "høyre" "høyre" ;
    rotten_ADeg = mk3ADeg "råtten" "råttent" "råtne" ;
    round_ADeg = regADeg "rund" ;
    sharp_ADeg = mk2ADeg "kvass" "kvast" ;
    short_ADeg = short_ADeg ;
    small_ADeg = small_ADeg ;
    smooth_ADeg = mk2ADeg "slett" "slett" ;
    straight_ADeg = regADeg "rak" ;
    thick_ADeg = thick_ADeg ;
    thin_ADeg = thin_ADeg ;
    warm_ADeg = warm_ADeg ;
    wet_ADeg = regADeg "våt" ;
    white_ADeg = white_ADeg ;
    wide_ADeg = regADeg "bred" ;
    yellow_ADeg = yellow_ADeg ;


    -- Nouns

    animal_N = mk2N "dyr" "dyret" ;
    ashes_N = mk2N "aske" "aska" ; 
    back_N = mk2N "rygg" "ryggen" ;
    bark_N = mk2N "bark" "barken" ;
    belly_N = mk2N "mage" "magen" ;
    bird_N = bird_N ;
    blood_N = mk2N "blod" "blodet" ;
    bone_N = mk2N "bein" "beinet" ;
    breast_N = mk2N "bryst" "brystet" ;
    child_N = child_N ;
    cloud_N = mk2N "sky" "skya" ;
    day_N = mk2N "dag" "dagen" ;
    dog_N = dog_N ;
    dust_N = mk2N "støv" "støvet" ;
    ear_N = mk2N "øre" "øret" ;
    earth_N = mk2N "jord" "jorda" ;
    egg_N = mk2N "egg" "egget" ;
    eye_N = mkN "øye" "øyet" "øyne" "øynene" ;
    fat_N = mk2N "fett" "fettet" ;
    father_N = mkN "far" "faren" "fedre" "fedrene" ;
--    father_N = UseN2 father_N2 ;
    feather_N = mk2N "fjør" "fjøra" ;
    fingernail_N = mk2N "negl" "neglen" ;
    fire_N = mk2N "ild" "ilden" ;
    fish_N = fish_N ;
    flower_N = mk2N "blomst" "blomsten" ; 
    fog_N = mk2N "tåke" "tåka" ; 
    foot_N = mk2N "fot" "føtter" ;
    forest_N = mk2N "skog" "skogen" ;
    fruit_N = fruit_N ;
    grass_N = mk2N "gras" "graset" ;
    guts_N = mk2N "tarm" "tarmen" ; ---- involler 
    hair_N = mk2N "hår" "håret" ;
    hand_N = mk2N "hånd" "hånden" ;

    head_N = mk2N "hode" "hodet" ;
    heart_N = mk2N "hjerte" "hjertet" ;
    horn_N = mk2N "horn" "hornet" ;
    husband_N = mkN "ektemann" "ektemannen" "ektemenn" "ektemennen" ;
    ice_N = mk2N "is" "isen" ;
    knee_N = mkN "kne" "kneet" "knær" "knæne" ;
    lake_N = lake_N ;
    leaf_N = mk2N "løv" "løvet" ;
    leg_N = mk2N "bein" "beinet" ;
    liver_N = mkN "lever" "leveren" "levrer" "levrene" ;
    louse_N = mk2N "lus" "lusa" ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
    mother_N = mkN "mor" "moren" "mødre" "mødrene" ;
--    mother_N = UseN2 mother_N2 ;
    mountain_N = mountain_N ;
    mouth_N = mk2N "munn" "munnen" ;
    name_N = mk2N "navn" "navnet" ;
    neck_N = mk2N "nakke" "nakken" ;
    night_N = mkN "natt" "natta" "netter" "nettene" ;
    nose_N = mk2N "nese" "nesen" ; 
    person_N = mk2N "person" "personen" ;
    rain_N = mk2N "regn" "regnet" ;
    river_N = river_N ;
    road_N = mk2N "vei" "veien" ;
    root_N = mkN "rot" "rota" "røtter" "røttene" ;
    rope_N = mk2N "tau" "tauet" ;
    salt_N = mk2N "salt" "saltet" ;
    sand_N = mk2N "sand" "sanden" ;
    sea_N = sea_N ;
    seed_N = mk2N "frø" "frøet" ;
    skin_N = mk2N "skinn" "skinnet" ;
    sky_N = mkN "himmel" "himmelen" "himler" "himlene" ; 
    smoke_N = mk2N "røyk" "røyken" ;
    snake_N = snake_N ;
    snow_N = mk2N "snø" "snøen" ;
    star_N = star_N ;
    stick_N = mk2N "pinne" "pinnen" ;
    stone_N = stone_N ;
    sun_N = sun_N ;
    tail_N = mk2N "hale" "halen" ;
    tongue_N = mk2N "tunge" "tunga" ; 
    tooth_N = mkN "tann" "tanna" "tenner" "tennene" ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = mk2N "kone" "kona" ;
    wind_N = mk2N "vind" "vinden" ;
    wing_N = mk2N "vinge" "vingen" ;
    woman_N = woman_N ;
    worm_N = mk2N "mark" "marken" ;
    year_N = mk2N "år" "året" ;

    -- Verbs

    bite_V = VerbsNor.bite_V ;
    blow_V = mk2V "blåse" "blåste" ;
    breathe_V = regV "puste" ;
    burn_V = brenne_V ;
    come_V = komme_V ;
    count_V = regV "regne" ;
    cut_V = skjære_V ;
    die_V = dø_V ;
    dig_V = mk2V "grave" "gravde" ;
    drink_V = drikke_V ;
    eat_V = mk2V "spise" "spiste" ; ---- ete
    fall_V = falle_V ;
    fear_V = regV "frykte" ;
    fight_V = slåss_V ;
    float_V = flyte_V ;
    flow_V = renne_V ;
    fly_V = fly_V ;
    freeze_V = fryse_V ;
    give_V = gi_V ;
    hear_V = mk2V "høre" "hørde" ;
    hit_V = slå_V;
    hold_V = holde_V ;
    hunt_V = regV "jakte" ;
    kill_V = mk2V "drepe" "drepte" ;
    know_V = vite_V ;
    laugh_V = mkV "le" "ler" "les" "lo" "ledd" "le" ;
    lie_V = ligge_V ;
    live_V = mk2V "leve" "levde" ;
    play_V = mk2V "leke" "lekte" ;
    pull_V = dra_V ;
    push_V = irregV "skyve" "skjøv" "skjøvet" ;
    rub_V = gni_V ;
    say_V = si_V ;
    scratch_V = regV "klø" ;
    see_V = se_V ;
    sew_V = mk2V "sy" "sydde" ;
    sing_V = synge_V ;
    sit_V = sitte_V ;
    sleep_V = sove_V ;
    smell_V = regV "lukte" ;
    spit_V = regV "spytte" ;
    split_V = mk2V "kløyve" "kløyvde" ;
    squeeze_V = mk2V "klemme" "klemte" ;
    stab_V = stikke_V ;
    stand_V = stå_V ;
    suck_V = suge_V ;
    swell_V = partV (regV "hovne") "opp" ;
    swim_V = regV "simme" ;
    think_V = mk2V "tenke" "tenkte" ;
    throw_V = regV "kaste" ;
    tie_V = regV "knytte" ;
    turn_V = mk2V "vende" "vendte" ;
    vomit_V = partV (regV "kaste") "opp" ;
    walk_V = gå_V ;
    wash_V = regV "vaske" ;
    wipe_V = regV "tørke" ;

}
