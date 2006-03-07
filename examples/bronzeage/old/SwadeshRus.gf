--# -path=.:../abstract:../../prelude

concrete SwadeshRus of Swadesh = CatRus 
  ** open ResourceRus, SyntaxRus, ParadigmsRus, 
          BasicRus, Prelude in {
flags  coding=utf8 ;

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

    this_Det = this_Det ;
    that_Det = that_Det ;
    all_Det = all_NDet ;
    many_Det = many_Det ;
    some_Det = someSg_Det ;
    few_Det = adjInvar "мало" ** {n = Sg; g = PNoGen; c= Nom} ;
    other_Det = drugojDet ** {n = Sg; g = PNoGen; c= Nom} ;

--    left_Ord = AStaruyj "лев";
--    right_Ord = AStaruyj "прав";

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

    at_Prep = { s2 = "у" ; c = genitive} ;
    in_Prep = { s2 = "в" ; c = prepositional} ;
    with_Prep = { s2 = "с" ; c = instructive} ;

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
    correct_A = mkA (AStaruyj "правильн") "правильнее"; 
    dirty_A = dirty_A ;
    dry_A = mkA (AMolodoj "сух") "суше";
    dull_A = mkA (AStaruyj "скучн") "скучнее";
    far_A = mkA (AKhoroshij "далекий") "дальше";
    full_A = mkA (AStaruyj "полн") "полнее";
    good_A = good_A ;
    green_A = green_A ;
    heavy_A = mkA (AStaruyj "тяжел") "тяжелее";
    long_A = long_A ;
    narrow_A = narrow_A ;
    near_A = mkA (AMalenkij "близк") "ближе";
    new_A = new_A ;
    old_A = old_A ;
    red_A = red_A ;
    rotten_A = mkA (AMolodoj "гнил") "гнилее";
    round_A = mkA (AStaruyj "кругл") "круглее";
    sharp_A = mkA (AStaruyj "остр") "острее";
    short_A = short_A ;
    small_A = small_A ;
    smooth_A = mkA (AMalenkij "гладк") "глаже";
    straight_A = mkA (AMolodoj "прям") "прямее";
    thick_A = thick_A ;
    thin_A = thin_A ;
    warm_A = warm_A ;
    wet_A = mkA (AStaruyj "мокр") "мокрее";
    white_A = white_A ;
    wide_A = mkA (AMalenkij "широк") "шире";
    yellow_A = yellow_A ;


    -- Nouns

    animal_N = nZhivotnoe "животн" ;
    ashes_N = nPepel "пеп" ;
    back_N = nMashina "спин" ;
    bark_N = mkN "лай" "лая" "лаю" "лай" "лаем" "лае" "лаи" "лаев" "лаям" "лаи" "лаями" "лаях" masculine inanimate;
    belly_N = nTelefon "живот" ;
    bird_N = bird_N ;
    blood_N = nBol "кров" ;
    bone_N = nBol "кост" ;
    breast_N = nBol "грудь" ;
    child_N = child_N ;
    cloud_N = nChislo "облак" ;
    day_N = mkN "день" "дня" "дню" "день" "днём" "дне" "дни" "дней" "дням" "дни" "днями" "днях" masculine inanimate ;
    dog_N = dog_N ;
    dust_N = nBol "пыл" ;
   ear_N = nChislo "ухо" ;
   earth_N = nTetya "земл" ;
    egg_N = nChislo "яйц" ;
    eye_N = nAdres "глаз" ;
    fat_N = nBank "жир" ;
    father_N = mkN "отец" "отца" "отцу" "отца" "отцом" "отце" "отцы" "отцов" "отцам" "отцов" "отцами" "отцах" masculine animate ; 
--    father_N = UseN2 father_N2 ;
    feather_N = mkN "перо" "пера" "перу" "пера" "пером" "пере" "перья" "перьев" "перьям" "перьев" "перьями" "перьях" neuter inanimate ;
   fingernail_N = mkN "ноготь" "ногтя" "ногтю" "ногтя" "ногтем" "ногте" "ногти" "ногтей" "ногтям" "ногтей" "ногтями" "ногтях" masculine inanimate ;
    fire_N = mkN "огонь" "огня" "огню" "огня" "огнём" "огне" "огни" "огней" "огням" "огней" "огнями" "огнях" masculine inanimate ;
    fish_N = fish_N ;
    flower_N = mkN "отец" "отца" "отцу" "отца" "отцом" "отце" "отцы" "отцов" "отцам" "отцов" "отцами" "отцах" masculine animate ;
    fog_N = nTelefon "туман" ;
    foot_N = nTetya "ступн" ;
    forest_N = nAdres "лес" ;
    fruit_N = fruit_N ;
    grass_N = nMashina "трав" ;
    guts_N =  nBol "внутренност" ;
    hair_N = nTelefon "волос" ;
   hand_N =  nNoga "рук" ;
   head_N = nMashina "голов" ;
   heart_N = mkN "сердце" "сердца" "сердцу" "сердца" "сердцем" "сердце" "сердца" "сердец" "сердцам" "сердец" "сердцами" "сердцах" neuter inanimate;
   horn_N = nAdres "рог" ;
   husband_N = mkN "муж" "мужа" "мужу" "мужа" "мужем" "муже" "мужья" "мужей" "мужьям" "мужей" "мужьями" "мужьях" masculine animate ;
   ice_N = mkN "лёд" "льда" "льду" "льда" "льдом" "льде" "льды" "льдов" "льдам" "льдов" "льдами" "льдах" masculine inanimate ;
   knee_N = mkN "колено" "колена" "колену" "колена" "коленом" "колене" "колени" "колен" "коленам" "колен" "коленями" "коленях" neuter inanimate ;
    lake_N = lake_N ;
   leaf_N = nStul "лист" ;
   leg_N = nNoga "ног" ;
  liver_N = nBol "печен" ;
  louse_N = mkN "вошь" "вши" "вши" "вошь" "вошью" "вше" "вши" "вшей" "вшам" "вшей" "вшами" "вшах" feminine animate ;
    man_N = man_N ;
    meat_N = meat_N ;
    moon_N = moon_N ;
    mother_N = mkN "мать" "матери" "матери" "мать" "матерью" "матери" "матери" "матерей" "матерям" "матерей" "матерями" "матерях" feminine animate ;
---    mother_N = UseN2 mother_N2 ;
    mountain_N = mountain_N ;
   mouth_N =  mkN "рот" "рта" "рту" "рот" "ртом" "рте" "рты" "ртов" "ртам" "рты" "ртами" "ртах" masculine inanimate;
  name_N = mkN "имя" "имени" "имени" "имя" "именем" "имени" "имена" "имён" "именам" "имена" "именами" "именах" neuter inanimate;
  neck_N = nTetya "ше"  ;
  night_N = nBol "ноч" ;
  nose_N = nTelefon "нос" ;
  person_N = nBol "личность" ;
  rain_N = nNol "дожд" ;
   river_N = river_N ;
  road_N = nNoga "дорог" ;
   root_N = nUroven "кор" ;
   rope_N =  nNoga "веревк" ;
   salt_N = nBol "сол" ;
   sand_N = mkN "песок" "песка" "песку" "песок" "песком" "песке" "пески" "песков" "пескам" "песков" "песками" "песках" masculine inanimate ;
    sea_N = sea_N ;
    seed_N = mkN "семя" "семени" "семении" "семя" "семенем" "семени" "семена" "семян" "семенам" "семена" "семенами" "семенах" neuter inanimate ;
   skin_N =  nEdinica "кож" ;
   sky_N = mkN "небо" "неба" "небу" "небо" "небом" "небе" "небеса" "небес" "небесам" "небес" "небесами" "небесах" neuter inanimate ; 
   smoke_N =  nTelefon "дым" ;
    snake_N = snake_N ;
   snow_N = nAdres "снег" ;
    star_N = star_N ;
    stick_N = nNoga "палк" ;
    stone_N = stone_N ;
    sun_N = sun_N ;
   tail_N = nTelefon "хвост" ;
   tongue_N = nBank "язык" ;
   tooth_N = nTelefon "зуб" ;
    tree_N = tree_N ;
    water_N = water_N ;
    wife_N = nMashina "жен" ;
    wind_N = mkN "ветер" "ветра" "ветру" "ветер" "ветром" "ветра" "ветров" "ветра" "ветрам" "ветров" "ветрами" "ветрах" masculine inanimate ;
    wing_N = mkN "крыло" "крыла" "крылу" "крыло" "крылом" "крыле" "крылья" "крыльев" "крыльям" "крылья" "крыльями" "крыльях" neuter inanimate ;
    woman_N = woman_N ;
   worm_N = nNol "черв" ;
   year_N = nAdres "год" ;

    -- Verbs

    bite_V = mkRegVerb imperfective  first "куса" "ю" "кусал" "кусай" "кусать";
    blow_V = mkRegVerb imperfective  first "ду" "ю" "дул" "дуй" "дуть"  ;
   breathe_V = mkRegVerb imperfective  second "дыш" "у" "дышал" "дыши" "дышать"  ;
   burn_V = mkRegVerb imperfective  second "гор" "ю" "горел" "гори" "гореть"  ;
   come_V = come_V ;
   count_V = mkRegVerb imperfective  first "счита" "ю" "считал" "считай" "считать"   ;
    cut_V = mkRegVerb imperfective  first "реж" "у" "резал" "режь" "резать"  ;
    die_V = die_V ;
    dig_V = mkRegVerb imperfective  first "копа" "ю" "копал" "копай" "копать"  ;
    drink_V =  mkRegVerb imperfective  firstE  "пь" "ю" "пил" "пей" "пить"  ;
    eat_V = mkVerbum imperfective  "ем" "ешь" "ест" "едим" "едите" "едят" "ел" "ешь" "есть"  ; 
    fall_V = mkRegVerb imperfective  first "пада" "ю" "падал" "падай" "падать"  ;
    fear_V = mkRegVerb imperfective  second "бо" "ю" "боял" "бой" "боять"  ;
    fight_V = mkRegVerb imperfective  firstE "дер" "у" "драл" "дери" "драть"  ;
    float_V = mkRegVerb imperfective  firstE "плыв" "у" "плыл" "плыви" "плыть"  ;
    flow_V = mkRegVerb imperfective  firstE "тек" "у" "тёк" "теки" "течь"  ;
    fly_V = mkRegVerb imperfective  second "лета" "ю" "летал" "летай" "летать"  ;
    freeze_V = mkRegVerb imperfective  first "замерза" "ю" "замерзал" "замерзай" "замерзать"  ;
    give_V = mkRegVerb imperfective  firstE "да" "ю" "давал" "давай" "давать"  ;
    hear_V = mkRegVerb imperfective  first "слыш" "у" "слышал" "слышь" "слышать"  ;
    hit_V = mkRegVerb imperfective  first "ударя" "ю" "ударял" "ударяй" "ударять"  ;
    hold_V = mkRegVerb imperfective  second "держ" "у" "держал" "держи" "держать"  ;
    hunt_V = mkRegVerb imperfective  second "охоч" "у" "охотил" "охоть" "охотить"  ;
    kill_V = mkRegVerb imperfective  first "убива" "ю" "убивал" "убивай" "убивать"  ;
    know_V = mkRegVerb imperfective  first "зна" "ю" "знал" "знай" "знать"  ;
    laugh_V = mkRegVerb imperfective  firstE "сме" "ю" "смеял" "смей" "смеять"  ;
    lie_V = mkRegVerb imperfective  firstE "лг" "у" "лгал" "лги" "лгать"  ;
    live_V = live_V ;
    play_V = mkRegVerb imperfective  first "игра" "ю" "играл" "играй" "играть"  ;
    pull_V = mkRegVerb imperfective  first "тян" "у" "тянул" "тяни" "тянуть"  ;
    push_V = mkRegVerb imperfective  first "толка" "ю" "толкал" "толкай" "толкать"  ;
    rub_V = mkRegVerb imperfective  firstE "тр" "у" "тёр" "три" "тереть"  ;
    say_V = mkRegVerb imperfective  second "говор" "ю" "говорил" "говори" "говорить";
    scratch_V = mkRegVerb imperfective  first "чеш" "у" "чесал" "чеши" "чесать"  ;    see_V = mkRegVerb imperfective  second "смотр" "ю" "смотрел" "смотри" "смотреть"  ;
    sew_V = mkRegVerb imperfective  firstE "шь" "ю" "шил" "шей" "шить"  ;
    sing_V = mkRegVerb imperfective  firstE "по" "ю" "пел" "пой" "петь"  ;
    sit_V = mkVerbum imperfective  "сижу" "сидишь" "сидит" "сидим" "сидите" "сидят" "сидел" "сиди" "сидеть"  ;
    sleep_V = sleep_V ;
    smell_V = mkRegVerb imperfective  first "пахн" "у" "пахнул" "пахни" "пахнуть"  ;
    spit_V = mkRegVerb imperfective  firstE "плю" "ю" "плевал" "плюй" "плевать"  ;
    split_V = mkRegVerb imperfective  first "разбива" "ю" "разбивал" "разбей" "разбивать"  ;
    squeeze_V = mkRegVerb imperfective  first "сжима" "ю" "сжимал" "сжимай" "сжимать"  ;
    stab_V = mkRegVerb imperfective  first "кол" "ю" "колол" "коли" "колоть"  ;
    stand_V = mkRegVerb imperfective second "сто" "ю" "стоял" "стой" "стоять"  ;
    suck_V = mkRegVerb imperfective  firstE "сос" "у" "сосал" "соси" "сосать"  ;
    swell_V = mkRegVerb imperfective  first "опуха" "ю" "опухал" "опухай" "опухать"  ;
    swim_V = mkRegVerb imperfective  first "плава" "ю" "плавал" "плавай" "плавать"  ;
    think_V = mkRegVerb imperfective  first "дума" "ю" "думал" "думай" "думать"  ;
    throw_V = mkRegVerb imperfective  first "броса" "ю" "бросал" "бросай" "бросать"  ;
    tie_V = mkRegVerb imperfective  first "вяж" "у" "вязал" "вяжи" "вязать"  ;
    turn_V = mkRegVerb imperfective  first "поворачива" "ю" "поворачивал" "поворачивай" "поворачивать"  ;
    vomit_V = mkRegVerb imperfective  firstE "рв" "у" "рвал" "рви" "рвать"  ;
    walk_V = walk_V ;
    wash_V = mkRegVerb imperfective  first "мо" "ю" "мыл" "мой" "мыть"  ;
    wipe_V = mkRegVerb imperfective  first "вытира" "ю" "вытирал" "вытирай" "вытирать"  ;

};
