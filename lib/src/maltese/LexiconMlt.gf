-- LexiconMlt.gf: test lexicon of 300 content words
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2012
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

concrete LexiconMlt of Lexicon = CatMlt **
  open Prelude, ParadigmsMlt, IrregMlt in {

  flags
    optimize=values ;
    coding=utf8 ;

  lin
--    add_V3
--    alas_Interj
--    already_Adv
    animal_N = mkN "annimal" ;
--    answer_V2S
    apartment_N = mkN "appartament" ;
    art_N = mkNNoPlural "arti" feminine ;
--    ashes_N = mkN "rmied" ;
--    ask_V2Q
    baby_N = mkN "tarbija" "trabi" ;
    back_N = mkN "dahar" "dhur" ; -- pronSuffix
    bad_A = brokenA "ħażin" "hżiena" "agħar" ;
    bank_N = mkN "bank" "bankijiet" ; -- BANEK is for lotto booths!
    bark_N = mkN "qoxra" "qoxriet" ;
    beautiful_A = brokenA "sabiħ" "sbieħ" "isbaħ" ;
--    become_VA
    beer_N = mkN "birra" "birer" ;
--    beg_V2V
    belly_N = mkN "żaqq" "żquq" ; -- pronSuffix
    big_A = brokenA "kbir" "kbar" "ikbar" ;
    bike_N = mkN "rota" ;
    bird_N = mkN "għasfur" "għasafar" ; -- what about GĦASFURA?
--    bite_V2
    black_A = mkA "iswed" "sewda" "suwed" ;
    blood_N = mkN [] "demm" [] "dmija" [] ; -- pronSuffix
--    blow_V
    blue_A = sameA "blu" ;
    boat_N = mkN "dgħajsa" "dgħajjes" ;
    bone_N = mkNColl "għadam" ;
    book_N = mkN "ktieb" "kotba" ;
    boot_N = mkN "żarbun" "żraben" ; -- what about ŻARBUNA?
    boss_N = mkN "mgħallem" "mgħallmin" ;
    boy_N = mkN "tifel" "tfal" ;
    bread_N = mkNColl "ħobż" ;
--    break_V2
    breast_N = mkN "sider" "sdur" ; -- also ISDRA -- pronSuffix
--    breathe_V
    broad_A = mkA "wiesgħa" "wiesgħa" "wiesgħin" ;
    brother_N2 = mkN2 (mkN "ħu" "aħwa") (mkPrep "ta'") ; -- pronSuffix
    brown_A = sameA "kannella" ;
--    burn_V
    butter_N = mkN [] "butir" [] "butirijiet" [] ;
--    buy_V2
    camera_N = mkN "kamera" "kameras" ;
    cap_N = mkN "beritta" ;
    car_N = mkN "karozza" ;
    carpet_N = mkN "tapit" ; -- TAPITI or TWAPET ?
    cat_N = mkN "qattus" "qtates" ; -- what about QATTUSA ?
    ceiling_N = mkN "saqaf" "soqfa";
    chair_N = mkN "siġġu" "siġġijiet" ;
    cheese_N = mkNColl "ġobon" ;
--    child_N = mkN "tfajjel" ; -- Not an easy one...
    church_N = mkN "knisja" "knejjes" ;
    city_N = mkN "belt" "bliet" feminine ; -- pronSuffix
    clean_A = brokenA "nadif" "nodfa" ;
    clever_A = regA "bravu" ;
--    close_V2
    cloud_N = mkNColl "sħab" ;
    coat_N = mkN "kowt" "kowtijiet" ;
    cold_A = mkA "kiesaħ" "kiesħa" "kesħin" ;
--    come_V
    computer_N = mkN "kompjuter" "kompjuters" ;
    correct_A = regA "korrett" ;
--    count_V2
    country_N = mkN "pajjiż" ; -- pronSuffix
    cousin_N = mkN "kuġin" ; -- pronSuffix
    cow_N = mkN "baqra" "baqar" "baqartejn" [] [] ;
--    cut_V2
    day_N = mkN "ġurnata" "ġranet" ;
--    dig_V
    dirty_A = regA "maħmuġ" ;
    distance_N3 = mkN "distanza" ;
--    do_V2
    doctor_N = mkN "tabib" "tobba" ; -- what about TABIBA ?
    dog_N = mkN "kelb" "klieb" ;
    door_N = mkN "bieb" "bibien" ; -- what about BIEBA ?
--    drink_V2
    dry_A = regA "niexef" ;
    dull_A = sameA "tad-dwejjaq" ;
    dust_N = mkNColl "trab" ; -- not sure but sounds right
    ear_N = mkNDual "widna" ; -- pronSuffix
    earth_N = mkN "art" "artijiet" feminine ;
--    easy_A2V
--    eat_V2
    egg_N = mkNColl "bajd" ;
    empty_A = mkA "vojt" "vojta" "vojta" ;
    enemy_N = mkN "għadu" "għedewwa" ;
    eye_N = mk5N "għajn" [] "għajnejn" "għajnejn" "għejun" feminine ; -- pronSuffix
    factory_N = mkN "fabbrika" ;
--    fall_V
--    far_Adv
    fat_N = mkNColl "xaħam" ;
    father_N2 = mkN2 (mkN "missier" "missierijiet") (mkPrep "ta'") ; -- pronSuffix
--    fear_V2
--    fear_VS
    feather_N = mkNColl "rix" ;
--    fight_V2
--    find_V2
    fingernail_N = mkN "difer" [] "difrejn" "dwiefer" [] ; -- pronSuffix
    fire_N = mkN "nar" "nirien" ;
    fish_N = mkNColl "ħut" ;
--    float_V
    earth_N = mkN "art" "artijiet" feminine ;
--    flow_V
    flower_N = mkN "fjura" ;
--    fly_V
    fog_N = mkN [] "ċpar" [] [] [] ;
    foot_N = mk5N "sieq" [] "saqajn" "saqajn" [] feminine ; -- pronSuffix
    forest_N = mkN "foresta" ; -- also MASĠAR
--    forget_V2
--    freeze_V
    fridge_N = mkN "friġġ" "friġġijiet" ;
    friend_N = mkN "ħabib" "ħbieb" ; -- pronSuffix
    fruit_N = mkNColl "frott" ;
    full_A = regA "mimli" ;
--    fun_AV
    garden_N = mkN "ġnien" "ġonna" ;
    girl_N = mkN "tifla" "tfal" ;
--    give_V3
    glove_N = mkN "ingwanta" ;
--    go_V
    gold_N = mkN [] "deheb" [] "dehbijiet" [] ;
    good_A = mkA "tajjeb" "tajba" "tajbin" ;
    grammar_N = mkN "grammatika" ;
    grass_N = mk5N "ħaxixa" "ħaxix" [] [] "ħxejjex" masculine ; -- Dict says ĦAXIX = n.koll.m.s., f. -a, pl.ind. ĦXEJJEX
    green_A = mkA "aħdar" "ħadra" "ħodor" ;
    guts_N = mkN "musrana" [] [] "musraniet" "msaren" ; -- pronSuffix
    hair_N = mkN "xagħar" [] [] "xagħariet" "xgħur" ; -- pronSuffix
    hand_N = mk5N "id" [] "idejn" "idejn" [] feminine ; -- pronSuffix
    harbour_N = mkN "port" "portijiet" ;
    hat_N = mkN "kappell" "kpiepel" ;
--    hate_V2
    head_N = mkN "ras" "rjus" feminine ; -- pronSuffix
--    hear_V2
    heart_N = mkN "qalb" "qlub" feminine ; -- pronSuffix
    heavy_A = brokenA "tqil" "tqal" "itqal" ;
    hill_N = mkN "għolja" "għoljiet" ;
--    hit_V2
--    hold_V2
--    hope_VS
    horn_N = mkN "ħorn" "ħornijiet" ;
    horse_N = mkN "żiemel" "żwiemel" ;
    hot_A = brokenA "sħun" "sħan" ;
    house_N = mkN "dar" "djar" feminine ;
--    hunt_V2
    husband_N = mkN "raġel" "rġiel" ; -- pronSuffix ŻEWĠI
    ice_N = mkN "silġ" "silġiet" ;
    important_A = sameA "importanti" ;
    industry_N = mkN "industrija" ;
    iron_N = mk5N "ħadida" "ħadid" [] "ħadidiet" "ħdejjed" masculine ;
--    john_PN
--    jump_V
--    kill_V2
    king_N = mkN "re" "rejjiet" ;
    knee_N = mkN "rkoppa" [] "rkopptejn" "rkoppiet" [] ; -- TODO use mkNDual  -- pronSuffix
--    know_V2
--    know_VQ
--    know_VS
    lake_N = mkN "għadira" "għadajjar" ;
    lamp_N = mkN "lampa" ;
    language_N = mkN "lingwa" ; -- lsien?
--    laugh_V
    leaf_N = mkN "werqa" "weraq" "werqtejn" "werqiet" [] ;
--    learn_V2
    leather_N = mkN "ġilda" "ġild" [] "ġildiet" "ġlud" ; -- mkNColl "ġild" ;
--    leave_V2
--    left_Ord
    leg_N = mkN "riġel" [] "riġlejn" [] [] ; -- sieq?  -- pronSuffix
--    lie_V
--    like_V2
--    listen_V2
--    live_V
    liver_N = mkN "fwied" [] [] [] "ifdwa" ; -- pronSuffix
    long_A = brokenA "twil" "twal" "itwal" ;
--    lose_V2
    louse_N = mkN "qamla" "qamliet" ;
    love_N = mkN "mħabba" "mħabbiet" ; -- hmmm
--    love_V2
    man_N = mkN "raġel" "rġiel" ;
--    married_A2
    meat_N = mkN "laħam" [] [] "laħmiet" "laħmijiet" ;
    milk_N = mkN [] "ħalib" [] "ħalibijiet" "ħlejjeb" ;
    moon_N = mkN "qamar" "oqmra" ; -- qmura?
    mother_N2 = mkN2 (mkN "omm" "ommijiet" feminine) (mkPrep "ta'") ; -- pronSuffix
    mountain_N = mkN "muntanja" ;
    mouth_N = mkN "ħalq" "ħluq" ; -- pronSuffix
    music_N = mkN "musika" ; -- plural?
    name_N = mkN "isem" "ismijiet" ; -- pronSuffix
    narrow_A = mkA "dejjaq" "dejqa" "dojoq" "idjaq" ;
    near_A = regA "viċin" ;
    neck_N = mkN "għonq" "għenuq" ; -- pronSuffix
    new_A = brokenA "ġdid" "ġodda" ;
    newspaper_N = mkN "gazzetta" ;
    night_N = mkN "lejl" "ljieli" ;
    nose_N = mkN "mnieħer" "mniħrijiet" ; -- pronSuffix
--    now_Adv
    number_N = mkN "numru" ;
    oil_N = mkN "żejt" "żjut" ;
    old_A = brokenA "qadim" "qodma" "eqdem" ;
--    open_V2
--    paint_V2A
    paper_N = mkN "karta" ;
--    paris_PN
    peace_N = mkN "paċi" "paċijiet" feminine ;
    pen_N = mkN "pinna" "pinen" ;
    person_N = mk5N [] "persuna" [] "persuni" [] masculine ;
    planet_N = mkN "pjaneta" ;
    plastic_N = mkNNoPlural "plastik" ;
--    play_V
--    play_V2
    policeman_N = mkNNoPlural "pulizija" ;
    priest_N = mkN "qassis" "qassisin" ;
--    probable_AS
--    pull_V2
--    push_V2
--    put_V2
    queen_N = mkN "reġina" "rġejjen" ;
    question_N = mkN "mistoqsija" "mistoqsijiet" ; -- domanda?
    radio_N = mkN "radju" "radjijiet" ;
    rain_N = mkNNoPlural "xita" ;
--    rain_V0
--    read_V2
    ready_A = regA "lest" ;
    reason_N = mkN "raġun" "raġunijiet" ;
    red_A = mkA "aħmar" "ħamra" "ħomor" ;
    religion_N = mkN "reliġjon" "reliġjonijiet" ;
    restaurant_N = mkN "restorant" ;
--    right_Ord
    river_N = mkN "xmara" "xmajjar" ;
    road_N = mk5N "triq" [] [] "triqat" "toroq" feminine ;
    rock_N = mkN "blata" "blat" [] "blatiet" "blajjiet" ; -- in dictionary BLAT and BLATA are separate!
    roof_N = mkN "saqaf" "soqfa" ;
    root_N = mkN "qħerq" "qħeruq" ;
    rope_N = mkN "ħabel" "ħbula" ;
    rotten_A = mkA "mħassar" "mħassra" "mħassrin" ;
    round_A = regA "tond" ;
--    rub_V2
    rubber_N = mkN "gomma" "gomom" ;
    rule_N = mkN "regola" ;
--    run_V
    salt_N = mkN "melħ" "melħiet" ;
    sand_N = mkN "ramla" "ramel" [] "ramliet" "rmiel" ;
--    say_VS
    school_N = mkN "skola" "skejjel" ;
    science_N = mkN "xjenza" ;
--    scratch_V2
    sea_N = mkN "baħar" [] "baħrejn" "ibħra" [] ;
--    see_V2
    seed_N = mkN "żerriegħa" "żerrigħat" ;
--    seek_V2
--    sell_V3
--    send_V3
--    sew_V
    sharp_A = mkA "jaqta" "taqta" "jaqtgħu" ; -- TODO: apostrophe?
    sheep_N = mkN "nagħġa" "nagħaġ" [] "nagħġiet" [] ;
    ship_N = mkN "vapur" ;
    shirt_N = mkN "qmis" "qomos" feminine ;
    shoe_N = mkN "żarbun" "żraben" ;
    shop_N = mkN "ħanut" "ħwienet" ;
    short_A = brokenA "qasir" "qosra" "iqsar" ;
    silver_N = mkN "fidda" "fided" ;
--    sing_V
    sister_N = mkN "oħt" "aħwa" feminine ; -- pronSuffix
--    sit_V
    skin_N = mkN "ġilda" "ġildiet" ;
    sky_N = mkN "sema" "smewwiet" masculine ;
--    sleep_V
    small_A = brokenA "zgħir" "zgħar" "iżgħar" ;
--    smell_V
    smoke_N = mkN "duħħan" "dħaħen" ;
    smooth_A = regA "lixx" ;
    snake_N = mkN "serp" "sriep" ;
    snow_N = mkN [] "borra" [] [] [] ;
    sock_N = mkN "kalzetta" ;
    song_N = mkN "kanzunetta" ;
--    speak_V2
--    spit_V
--    split_V2
--    squeeze_V2
--    stab_V2
--    stand_V
    star_N = mkN "stilla" "stilel" ;
    steel_N = mkNNoPlural "azzar" ;
    stick_N = mkN "lasta" ;
    stone_N = mkN "ġebla" "ġebel" [] "ġebliet" "ġbiel" ;
--    stop_V
    stove_N = mkN "kuker" "kukers" ; -- fuklar?
    straight_A = regA "dritt" ;
    student_N = mkN "student" ;
    stupid_A = mkA "iblah" "belha" "boloh" ; -- these are really nouns...
--    suck_V2
    sun_N = mkN "xemx" "xmux" feminine ;
--    swell_V
--    swim_V
--    switch8off_V2
--    switch8on_V2
    table_N = mkN "mejda" "mwejjed" ;
    tail_N = mkN "denb" "dnieb" ; -- pronSuffix
--    talk_V3
--    teach_V2
    teacher_N = mkN "għalliem" "għalliema" ; -- għalliema ?
    television_N = mkN "televixin" "televixins" ;
    thick_A = mkA "oħxon" "ħoxna" "ħoxnin" "eħxen" ;
    thin_A = brokenA "rqiq" "rqaq" "rqaq" ;
--    think_V
--    throw_V2
--    tie_V2
--    today_Adv
    tongue_N = mkN "lsien" "ilsna" ; -- pronSuffix
    tooth_N = mkN "sinna" [] [] "sinniet" "snien" ; -- darsa? -- pronSuffix
    train_N = mkN "ferrovija" ;
--    travel_V
    tree_N = mkN "siġra" "siġar" [] "siġriet" [] ;
--    turn_V
    ugly_A = mkA "ikrah" "kerha" "koroh" ; -- ikreh?
    uncertain_A = regA "inċert" ;
--    understand_V2
    university_N = mkN "università" "universitàjiet" ;
    village_N = mkN "raħal" "rħula" ; -- villaġġ ? -- pronSuffix
--    vomit_V
--    wait_V2
--    walk_V
    war_N = mkN "gwerra" "gwerrer" ;
    warm_A = hot_A ;
--    wash_V2
--    watch_V2
    water_N = mkN "ilma" "ilmijiet" masculine ;
    wet_A = mkA "mxarrab" "mxarrba" "mxarrbin" ;
    white_A = mkA "abjad" "bajda" "bojod" ;
    wide_A = broad_A ;
    wife_N = mkN "mara" "nisa" ; -- pronSuffix MARTI
--    win_V2
    wind_N = mkN "riħ" [] [] "rjieħ" "rjiħat" ;
    window_N = mkN "tieqa" "twieqi" ;
    wine_N = mkN [] "nbid" [] [] "nbejjed" ;
    wing_N = mkN "ġewnaħ" "ġwienaħ" ;
--    wipe_V2
    woman_N = mkN "mara" "nisa" ;
--    wonder_VQ
    wood_N = mkN "injam" "injamiet" ;
    worm_N = mkN "dudu" "dud" [] "dudiet" "dwied" ; -- duda
--    write_V2
    year_N = mkN "sena" [] "sentejn" "snin" [] ;  -- pronSuffix SNINI (only plural though!)
    yellow_A = mkA "isfar" "safra" "sofor" ;
    young_A = small_A ;

} ;
