-- LexiconMlt.gf: test lexicon of 300 content words
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
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
    animal_N       = mkN "annimal" ;
    answer_V2S     = mkV_III "wieġeb" (mkRoot "w-ġ-b") ;
    apartment_N    = mkN "appartament" ;
    art_N          = mkNNoPlural "arti" feminine ;
--    ashes_N      = mkN "rmied" ;
    ask_V2Q        = mkV "saqsa" (mkRoot "s-q-s-j") ;
    baby_N         = mkN "tarbija" "trabi" ;
    back_N         = possN (mkN "dahar" "dhur") ;
    bad_A          = brokenA "ħażin" "hżiena" "agħar" ;
    bank_N         = mkN "bank" "bankijiet" ; -- BANEK is for lotto booths!
    bark_N         = mkN "qoxra" "qoxriet" ;
    beautiful_A    = brokenA "sabiħ" "sbieħ" "isbaħ" ;
--    become_VA
    beer_N         = mkN "birra" "birer" ;
--    beg_V2V
    belly_N        = possN (mkN "żaqq" "żquq") ;
    big_A          = brokenA "kbir" "kbar" "ikbar" ;
    bike_N         = mkN "rota" ;
    bird_N         = mkN "għasfur" "għasafar" ; -- feminine: GĦASFURA
    bite_V2        = mkV "gidem" (mkRoot "g-d-m") ;
    black_A        = mkA "iswed" "sewda" "suwed" ;
    blood_N        = possN (mkN [] "demm" [] "dmija" []) ;
    blow_V         = mkV "nefaħ" (mkRoot "n-f-ħ") ;
    blue_A         = sameA "blu" ;
    boat_N         = mkN "dgħajsa" "dgħajjes" ;
    bone_N         = mkNColl "għadam" ;
    book_N         = mkN "ktieb" "kotba" ;
    boot_N         = mkN "żarbuna" "żarbun" [] "żraben" [] ;
    boss_N         = mkN "mgħallem" "mgħallmin" ;
    boy_N          = mkN "tifel" "tfal" ;
    bread_N        = mkNColl "ħobż" ;
    break_V2       = mkV "kiser" (mkRoot "k-s-r") ;
    breast_N       = possN (mkN "sider" "sdur") ; -- also ISDRA
--    breathe_V
    broad_A        = mkA "wiesgħa" "wiesgħa" "wiesgħin" ;
    brother_N2     = mkN2 (possN (mkN "ħu" "aħwa")) ;
    brown_A        = sameA "kannella" ;
    burn_V         = mkV "ħaraq" (mkRoot "ħ-r-q") ;
    butter_N       = mkN [] "butir" [] "butirijiet" [] ;
    buy_V2         = mkV_VIII "xtara" (mkRoot "x-r-j") ;
    camera_N       = mkN "kamera" "kameras" ;
    cap_N          = mkN "beritta" ;
    car_N          = mkN "karozza" ;
    carpet_N       = mkN "tapit" "twapet" ; -- TAPITI
    cat_N          = mkN "qattus" "qtates" ; -- feminine: QATTUSA
    ceiling_N      = mkN "saqaf" "soqfa";
    chair_N        = mkN "siġġu" "siġġijiet" ;
    cheese_N       = mkNColl "ġobon" ;
--    child_N      = mkN "tfajjel" ; -- Not an easy one...
    church_N       = mkN "knisja" "knejjes" ;
    city_N         = mkN "belt" "bliet" feminine ;
    clean_A        = brokenA "nadif" "nodfa" ;
    clever_A       = regA "bravu" ;
    close_V2       = mkV "għalaq" (mkRoot "għ-l-q") ;
    cloud_N        = mkNColl "sħab" ;
    coat_N         = mkN "kowt" "kowtijiet" ;
    cold_A         = mkA "kiesaħ" "kiesħa" "kesħin" ;
--    come_V
    computer_N     = mkN "kompjuter" "kompjuters" ;
    correct_A      = regA "korrett" ;
    count_V2       = mkV "għadd" (mkRoot "għ-d-d") ;
    country_N      = possN (mkN "pajjiż") ;
    cousin_N       = possN (mkN "kuġin") ; -- feminine: KUĠINA
    cow_N          = mkN "baqra" "baqar" "baqartejn" [] [] ;
    cut_V2         = mkV "qata'" (mkRoot "q-t-għ") ;
    day_N          = mkN "ġurnata" "ġranet" ;
    dig_V          = mkV "ħafer" (mkRoot "ħ-f-r") ;
    dirty_A        = regA "maħmuġ" ;
    distance_N3    = mkN "distanza" ;
    do_V2          = mkV "għamel" (mkRoot "għ-m-l") ;
    doctor_N       = mkN "tabib" "tobba" ; -- feminine: TABIBA
    dog_N          = mkN "kelb" "klieb" ;
    door_N         = mkN "bieb" "bibien" ;
    drink_V2       = mkV "xorob" (mkRoot "x-r-b") ;
    dry_A          = regA "niexef" ;
    dull_A         = sameA "tad-dwejjaq" ;
    dust_N         = mkNColl "trab" ; -- not sure but sounds right
    ear_N          = possN (mkNDual "widna") ;
    earth_N        = mkN "art" "artijiet" feminine ;
--    easy_A2V
--    eat_V2
    egg_N          = mkNColl "bajd" ;
    empty_A        = mkA "vojt" "vojta" "vojta" ;
    enemy_N        = mkN "għadu" "għedewwa" ;
    eye_N          = possN (mk5N "għajn" [] "għajnejn" "għajnejn" "għejun" feminine) ;
    factory_N      = mkN "fabbrika" ;
    fall_V         = mkV "waqa'" (mkRoot "w-q-għ") ;
--    far_Adv
    fat_N          = mkNColl "xaħam" ;
    father_N2      = mkN2 (possN (mkN "missier" "missierijiet")) ;
--    fear_V2
--    fear_VS
    feather_N      = mkNColl "rix" ;
    fight_V2       = mkV_VI "ġġieled" (mkRoot "ġ-l-d") ;
    find_V2        = mkV "sab" (mkRoot "s-j-b") ;
    fingernail_N   = possN (mkN "difer" [] "difrejn" "dwiefer" []) ;
    fire_N         = mkN "nar" "nirien" ;
    fish_N         = mkNColl "ħut" ;
--    float_V
    earth_N        = mkN "art" "artijiet" feminine ;
--    flow_V
    flower_N       = mkN "fjura" ;
    fly_V          = mkV "tar" (mkRoot "t-j-r") ;
    fog_N          = mkN [] "ċpar" [] [] [] ;
    foot_N         = possN (mk5N "sieq" [] "saqajn" "saqajn" [] feminine) ;
    forest_N       = mkN "foresta" ; -- also MASĠAR
    forget_V2      = mkV "nesa" (mkRoot "n-s-j") ;
--    freeze_V
    fridge_N       = mkN "friġġ" "friġġijiet" ;
    friend_N       = possN (mkN "ħabib" "ħbieb") ; -- feminine: ĦABIBA
    fruit_N        = mkNColl "frott" ;
    full_A         = regA "mimli" ;
--    fun_AV
    garden_N       = mkN "ġnien" "ġonna" ;
    girl_N         = mkN "tifla" "tfal" ;
--    give_V3
    glove_N        = mkN "ingwanta" ;
    go_V           = mkV "mar" (mkRoot "m-w-r") ;
    gold_N         = mkN [] "deheb" [] "dehbijiet" [] ;
    good_A         = mkA "tajjeb" "tajba" "tajbin" ;
    grammar_N      = mkN "grammatika" ;
    grass_N        = mk5N "ħaxixa" "ħaxix" [] [] "ħxejjex" masculine ; -- Dict says ĦAXIX = n.koll.m.s., f. -a, pl.ind. ĦXEJJEX
    green_A        = mkA "aħdar" "ħadra" "ħodor" ;
    guts_N         = possN (mkN "musrana" [] [] "musraniet" "msaren") ;
    hair_N         = possN (mkN "xagħar" [] [] "xagħariet" "xgħur") ;
    hand_N         = possN (mk5N "id" [] "idejn" "idejn" [] feminine) ;
    harbour_N      = mkN "port" "portijiet" ;
    hat_N          = mkN "kappell" "kpiepel" ;
--    hate_V2
    head_N         = possN (mkN "ras" "rjus" feminine) ;
    hear_V2        = mkV "sema'" (mkRoot "s-m-għ") ;
    heart_N        = possN (mkN "qalb" "qlub" feminine) ;
    heavy_A        = brokenA "tqil" "tqal" "itqal" ;
    hill_N         = mkN "għolja" "għoljiet" ;
    hit_V2         = mkV "laqat" (mkRoot "l-q-t") ;
--    hold_V2
    hope_VS        = mkV_VIII "xtaq" (mkRoot "x-w-q") ;
    horn_N         = mkN "ħorn" "ħornijiet" ;
    horse_N        = mkN "żiemel" "żwiemel" ;
    hot_A          = brokenA "sħun" "sħan" ;
    house_N        = mkN "dar" "djar" feminine ;
--    hunt_V2
    husband_N      = mkN "raġel" "rġiel" ;
    ice_N          = mkN "silġ" "silġiet" ;
    important_A    = sameA "importanti" ;
    industry_N     = mkN "industrija" ;
    iron_N         = mk5N "ħadida" "ħadid" [] "ħadidiet" "ħdejjed" masculine ;
    john_PN        = mkPN "Ġanni" masculine singular ;
    jump_V         = mkV "qabeż" (mkRoot "q-b-ż") ;
    kill_V2        = mkV "qatel" "oqtol" (mkRoot "q-t-l") ;
    king_N         = mkN "re" "rejjiet" ;
    knee_N         = possN (mkN "rkoppa" [] "rkopptejn" "rkoppiet" []) ; -- TODO use mkNDual
--    know_V2
--    know_VQ
--    know_VS
    lake_N         = mkN "għadira" "għadajjar" ;
    lamp_N         = mkN "lampa" ;
    language_N     = mkN "lingwa" ; -- lsien?
    laugh_V        = mkV "daħak" (mkRoot "d-ħ-k") ;
    leaf_N         = mkN "werqa" "weraq" "werqtejn" "werqiet" [] ;
    learn_V2       = mkV_V "tgħallem" (mkRoot "għ-l-m") ;
    leather_N      = mkN "ġilda" "ġild" [] "ġildiet" "ġlud" ; -- mkNColl "ġild" ;
    leave_V2       = mkV "telaq" (mkRoot "t-l-q") ;
--    left_Ord
    leg_N          = possN (mkN "riġel" [] "riġlejn" [] []) ; -- SIEQ
    lie_V          = mkV_VIII "mtedd" (mkRoot "m-d-d") ;
--    like_V2
    listen_V2      = mkV "sema'" (mkRoot "s-m-għ") ;
    live_V         = mkV "għex" (mkRoot "għ-j-x") ;
    liver_N        = mkN "fwied" [] [] [] "ifdwa" ;
    long_A         = brokenA "twil" "twal" "itwal" ;
    lose_V2        = mkV "tilef" (mkRoot "t-l-f") ;
    louse_N        = mkN "qamla" "qamliet" ;
    love_N         = mkN "mħabba" "mħabbiet" ;
    love_V2        = mkV "ħabb" (mkRoot "ħ-b-b") ;
    man_N          = mkN "raġel" "rġiel" ;
--    married_A2
    meat_N         = mkN "laħam" [] [] "laħmiet" "laħmijiet" ;
    milk_N         = mkN [] "ħalib" [] "ħalibijiet" "ħlejjeb" ;
    moon_N         = mkN "qamar" "oqmra" ; -- QMURA
    mother_N2      = mkN2 (possN (mkN "omm" "ommijiet" feminine)) ;
    mountain_N     = mkN "muntanja" ;
    mouth_N        = possN (mkN "ħalq" "ħluq") ;
    music_N        = mkNNoPlural "musika" ;
    name_N         = possN (mkN "isem" "ismijiet") ;
    narrow_A       = mkA "dejjaq" "dejqa" "dojoq" "idjaq" ;
    near_A         = regA "viċin" ;
    neck_N         = possN (mkN "għonq" "għenuq") ;
    new_A          = brokenA "ġdid" "ġodda" ;
    newspaper_N    = mkN "gazzetta" ;
    night_N        = mkN "lejl" "ljieli" ;
    nose_N         = possN (mkN "mnieħer" "mniħrijiet") ;
--    now_Adv
    number_N       = mkN "numru" ;
    oil_N          = mkN "żejt" "żjut" ;
    old_A          = brokenA "qadim" "qodma" "eqdem" ;
    open_V2        = mkV "fetaħ" (mkRoot "f-t-ħ") ;
--    paint_V2A
    paper_N        = mkN "karta" ;
    paris_PN       = mkPN "Pariġi" feminine singular ;
    peace_N        = mkN "paċi" "paċijiet" feminine ;
    pen_N          = mkN "pinna" "pinen" ;
    person_N       = mk5N [] "persuna" [] "persuni" [] masculine ;
    planet_N       = mkN "pjaneta" ;
    plastic_N      = mkNNoPlural "plastik" ;
    play_V         = mkV "lagħab" (mkRoot "l-għ-b") ;
    play_V         = mkV "lagħab" (mkRoot "l-għ-b") ;
    policeman_N    = mkNNoPlural "pulizija" ;
    priest_N       = mkN "qassis" "qassisin" ;
--    probable_AS
    pull_V2        = mkV "ġibed" (mkRoot "ġ-b-d") ;
--    push_V2
    put_V2         = mkV_III "qiegħed" (mkRoot "q-għ-d") ;
    queen_N        = mkN "reġina" "rġejjen" ;
    question_N     = mkN "mistoqsija" "mistoqsijiet" ; -- DOMANDA
    radio_N        = mkN "radju" "radjijiet" ;
    rain_N         = mkNNoPlural "xita" ;
--    rain_V0
    read_V2        = mkV "qara" (mkRoot "q-r-j") ;
    ready_A        = regA "lest" ;
    reason_N       = mkN "raġun" "raġunijiet" ;
    red_A          = mkA "aħmar" "ħamra" "ħomor" ;
    religion_N     = mkN "reliġjon" "reliġjonijiet" ;
    restaurant_N   = mkN "restorant" ;
--    right_Ord
    river_N        = mkN "xmara" "xmajjar" ;
    road_N         = mk5N "triq" [] [] "triqat" "toroq" feminine ;
    rock_N         = mkN "blata" "blat" [] "blatiet" "blajjiet" ; -- in dictionary BLAT and BLATA are separate!
    roof_N         = mkN "saqaf" "soqfa" ;
    root_N         = mkN "qħerq" "qħeruq" ;
    rope_N         = mkN "ħabel" "ħbula" ;
    rotten_A       = mkA "mħassar" "mħassra" "mħassrin" ;
    round_A        = regA "tond" ;
--    rub_V2
    rubber_N       = mkN "gomma" "gomom" ;
    rule_N         = mkN "regola" ;
    run_V          = mkV "ġera" (mkRoot "ġ-r-j") ;
    salt_N         = mkN "melħ" "melħiet" ;
    sand_N         = mkN "ramla" "ramel" [] "ramliet" "rmiel" ;
--    say_VS
    school_N       = mkN "skola" "skejjel" ;
    science_N      = mkN "xjenza" ;
    scratch_V2     = mkV "barax" (mkRoot "b-r-x") ;
    sea_N          = mkN "baħar" [] "baħrejn" "ibħra" [] ;
--    see_V2
    seed_N         = mkN "żerriegħa" "żerrigħat" ;
    seek_V2        = mkV_II "fittex" (mkRoot "f-t-x") ;
    sell_V3        = mkV "biegħ" (mkRoot "b-j-għ") ;
    send_V3        = mkV "bagħat" (mkRoot "b-għ-t") ;
    sew_V          = mkV "ħat" (mkRoot "ħ-j-t") ;
    sharp_A        = mkA "jaqta'" "taqta'" "jaqtgħu" ;
    sheep_N        = mkN "nagħġa" "nagħaġ" [] "nagħġiet" [] ;
    ship_N         = mkN "vapur" ;
    shirt_N        = mkN "qmis" "qomos" feminine ;
    shoe_N         = mkN "żarbun" "żraben" ;
    shop_N         = mkN "ħanut" "ħwienet" ;
    short_A        = brokenA "qasir" "qosra" "iqsar" ;
    silver_N       = mkN "fidda" "fided" ;
    sing_V         = mkV "kanta" (mkRoot "k-n-t-j") ;
    sister_N       = possN (mkN "oħt" "aħwa" feminine) ;
    sit_V          = mkV_II "poġġa" (mkRoot "p-ġ-j") ;
    skin_N         = mkN "ġilda" "ġildiet" ;
    sky_N          = mkN "sema" "smewwiet" masculine ;
    sleep_V        = mkV "raqad" (mkRoot "r-q-d") ;
    small_A        = brokenA "zgħir" "zgħar" "iżgħar" ;
    smell_V        = mkV "xamm" (mkRoot "x-m-m") ;
    smoke_N        = mkN "duħħan" "dħaħen" ;
    smooth_A       = regA "lixx" ;
    snake_N        = mkN "serp" "sriep" ;
    snow_N         = mkN [] "borra" [] [] [] ;
    sock_N         = mkN "kalzetta" ;
    song_N         = mkN "kanzunetta" ;
--    speak_V2
    spit_V         = mkV "beżaq" (mkRoot "b-ż-q") ;
    split_V2       = mkV "qasam" (mkRoot "q-s-m") ;
--    squeeze_V2
    stab_V2        = mkV_II "mewwes" (mkRoot "m-w-s") ;
--    stand_V
    star_N         = mkN "stilla" "stilel" ;
    steel_N        = mkNNoPlural "azzar" ;
    stick_N        = mkN "lasta" ;
    stone_N        = mkN "ġebla" "ġebel" [] "ġebliet" "ġbiel" ;
    stop_V         = mkV "waqaf" (mkRoot "w-q-f") ;
    stove_N        = mkN "kuker" "kukers" ; -- FUKLAR
    straight_A     = regA "dritt" ;
    student_N      = mkN "student" ;
    stupid_A       = mkA "iblah" "belha" "boloh" ;
    suck_V2        = mkV "rada'" (mkRoot "r-d-għ") ;
    sun_N          = mkN "xemx" "xmux" feminine ;
    swell_V        = mkV_VIII "ntefaħ" (mkRoot "n-f-ħ") ;
    swim_V         = mkV "għam" (mkRoot "għ-w-m") ;
    switch8off_V2  = mkV "tefa" (mkRoot "t-f-j") ;
    switch8on_V2   = mkV "xegħel" (mkRoot "x-għ-l") ;
    table_N        = mkN "mejda" "mwejjed" ;
    tail_N         = possN (mkN "denb" "dnieb") ;
--    talk_V3
    teach_V2       = mkV_II "għallem" (mkRoot "għ-l-m") ;
    teacher_N      = mkN "għalliem" "għalliema" ; -- feminine: GĦALLIEMA
    television_N   = mkN "televixin" "televixins" ;
    thick_A        = mkA "oħxon" "ħoxna" "ħoxnin" "eħxen" ;
    thin_A         = brokenA "rqiq" "rqaq" "rqaq" ;
    think_V        = mkV "ħaseb" (mkRoot "ħ-s-b") ;
    throw_V2       = mkV_II "waddab" (mkRoot "w-d-b") ;
    tie_V2         = mkV "qafel" (mkRoot "q-f-l") ;
--    today_Adv
    tongue_N       = possN (mkN "lsien" "ilsna") ;
    tooth_N        = possN (mkN "sinna" [] [] "sinniet" "snien") ; -- DARSA
    train_N        = mkN "ferrovija" ;
--    travel_V
    tree_N         = mkN "siġra" "siġar" [] "siġriet" [] ;
    turn_V         = mkV "dar" (mkRoot "d-w-r") ;
    ugly_A         = mkA "ikrah" "kerha" "koroh" ;
    uncertain_A    = regA "inċert" ;
--    understand_V2 --- missing from dict
    university_N   = mkN "università" "universitàjiet" ;
    village_N      = possN (mkN "raħal" "rħula") ; -- VILLAĠĠ
    vomit_V        = mkV "qala'" (mkRoot "q-l-għ") ;
--    wait_V2
    walk_V         = mkV "mexa" (mkRoot "m-x-j") ;
    war_N          = mkN "gwerra" "gwerrer" ;
    warm_A         = hot_A ;
    wash_V2        = mkV "ħasel" (mkRoot "ħ-s-l") ;
--    watch_V2
    water_N        = mkN "ilma" "ilmijiet" masculine ;
    wet_A          = mkA "mxarrab" "mxarrba" "mxarrbin" ;
    white_A        = mkA "abjad" "bajda" "bojod" ;
    wide_A         = broad_A ;
    wife_N         = mkN "mara" "nisa" ;
    win_V2         = mkV "rebaħ" (mkRoot "r-b-ħ") ;
    wind_N         = mkN "riħ" [] [] "rjieħ" "rjiħat" ;
    window_N       = mkN "tieqa" "twieqi" ;
    wine_N         = mkN [] "nbid" [] [] "nbejjed" ;
    wing_N         = mkN "ġewnaħ" "ġwienaħ" ;
    wipe_V2        = mkV "mesaħ" (mkRoot "m-s-ħ") ;
    woman_N        = mkN "mara" "nisa" ;
--    wonder_VQ
    wood_N         = mkN "injam" "injamiet" ;
    worm_N         = mkN "dudu" "dud" [] "dudiet" "dwied" ;
    write_V2       = mkV "kiteb" (mkRoot "k-t-b") ;
    year_N         = mkN "sena" [] "sentejn" "snin" [] ;
    yellow_A       = mkA "isfar" "safra" "sofor" ;
    young_A        = small_A ;

} ;
