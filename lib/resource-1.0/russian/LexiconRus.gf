--# -path=.:../abstract:../common:../../prelude

--
concrete LexiconRus of Lexicon = CatRus ** 
  open ParadigmsRus, Prelude, StructuralRus, MorphoRus in {
--, IrregRus
flags 
  optimize=values ;
  coding=utf8 ;
lin
  airplane_N = nTelefon "самолет" ;
  answer_V2S = dirV2 (regV imperfective  first "отвеча" "ю" "отвечал" "отвечай" "отвечать" );
  apartment_N = nMashina "квартир" ;
  apple_N = nChislo "яблок" ; 
  art_N = nChislo "искусств" ;
  ask_V2Q = dirV2 (regV imperfective  first "спрашива" "ю" "спрашивал" "спрашивай" "спрашивать") ;
  baby_N = nMalush "малыш";
  bad_A = AKakoj_Nibud  "плох" "" "хуже";
  bank_N = nBank "банк" ;
  beautiful_A =  AStaruyj "красив" "красивее";
  become_VA = regV perfective second "станов" "лю" "стал" "стань" "стать" ;
  beer_N = nChislo "пив" ;
  beg_V2V = dirV2 (mkVerbum  imperfective  "прошу" "просишь" "просит" "просим" "просите" "просят" "просил" "проси" "просить" );
  big_A = AKakoj_Nibud  "больш" "" "больше" ;
  bike_N = nTelefon "велосипед" ;
  bird_N = nEdinica "птиц" ;
  black_A = AStaruyj  "чёрн" "чернее";
  blue_A =  AMolodoj  "голуб" "голубее";
  boat_N = nMashina "лодк" ;
  book_N = nNoga "книг" ;
  boot_N = nBank "сапог" ;
  boss_N = nStomatolog "начальник" ;
  boy_N = nStomatolog "мальчик" ;
  bread_N = nAdres "хлеб" ;
  break_V2 = dirV2 (regV imperfective first "прерыва" "ю" "прерывал" "прерывай" "прерывать" );
  broad_A = AMalenkij  "широк" "шире";
  brother_N2 = mkN2  (nBrat "брат") ;
  brown_A = AStaruyj  "коричнев" "коричневее";
  butter_N = nChislo "масл";
  buy_V2 = dirV2 (regV imperfective first "покупа" "ю" "покупал" "покупай" "покупать" );
  camera_N = nMashina "kamer" ;
  cap_N = nNoga "чашк" ; -- чаш-ек Pl-Gen
  car_N = nMashina "машин" ;
  carpet_N =  mkN "ковёр" "ковра" "ковру" "ковёр" "ковром" "ковре" "ковры" "ковров" "коврам" "ковры" "коврами" "коврах" masculine inanimate;
  cat_N = nMashina "кошк" ;
ceiling_N =  nPotolok "потол" ; 
  chair_N = nStul "стул"  ;
cheese_N = nTelefon "сыр" ;
child_N = mkN "ребёнок" "ребёнка" "ребёнку" "ребёнка" "ребёнком" "ребёнке" "дети"  "детей" "детям" "детей" "детьми"  "детях" masculine animate ;
  church_N = mkN "церковь" "церкви" "церкви" "церковь" "церковью" "церкви" "церкви" "церквей" "церквям" "церкви" "церквями" "церквях" masculine inanimate;
  city_N = nAdres "город" ;
  clean_A =  AStaruyj  "чист" "чище"; 
  clever_A =  AStaruyj "умн" "умнее";
  close_V2= dirV2 (regV imperfective first "закрыва" "ю" "закрывал" "закрывай" "закрывать" );
  coat_N = mkIndeclinableNoun "пальто" masculine inanimate ;
  cold_A =  AStaruyj  "холодн" "холоднее";
  come_V = regV imperfective first "прихо" "жу" "приходил" "приходи" "приходить" ;
  computer_N = nTelefon  "компьютер" ;
  country_N = nMashina "стран" ;
cousin_N = nTelefon "кузен" ;
cow_N = nMashina "коров" ;
die_V = regV imperfective first "умира" "ю" "умирал" "умирай" "умирать" ;
dirty_A =  AStaruyj  "грязн" "грязнее" ;
doctor_N = nAdres "доктор" ;
dog_N = nNoga "собак" ;
door_N = nBol "двер" ;
drink_V2 = dirV2 (regV imperfective firstE "пь" "ю" "пил" "пей" "пить" );
eat_V2 = dirV2 (regV imperfective first "куша" "ю" "кушал" "кушай" "кушать" );
enemy_N = nStomatolog "враг" ;
factory_N = nNoga "фабрик" ;
father_N2 = mkN2 (mkN "отец" "отца" "отцу" "отца" "отцом" "отце" "отцы" "отцов" "отцам" "отцов" "отцами" "отцах" masculine animate);
fear_VS= regV imperfective second "бо" "ю" "боял" "бой" "боять" ;
find_V2 = dirV2 (mkVerbum imperfective   "нахожу" "находишь" "находит" "находим" "находите" "находят" "находил" "находи" "находить" );
fish_N = nMashina "рыб" ;
floor_N = nTelefon "пол" ;
forget_V2= dirV2 (regV imperfective first "забыва" "ю" "забывал" "забывай" "забывать" );
fridge_N = nBank "холодильник" ;
friend_N = mkN "друг" "друга" "другу" "друга" "другом" "друге" "друзья" "друзей" "друзьям" "друзей" "дузьями" "друзьях" masculine animate;
fruit_N = nTelefon "фрукт" ;
garden_N = nTelefon  "сад" ;
girl_N = nNoga "девочк" ;
glove_N = nNoga "перчатк" ;
gold_N = nChislo "золот" ;
good_A = AKhoroshij "хорош" "лучше" ; 
go_V= regV imperfective second "хо" "жу" "ходил" "ходи" "ходить" ;
green_A = AStaruyj  "зелен" "зеленее" ;
harbour_N = nTelefon "залив" ;
hate_V2= dirV2 (regV imperfective second "ненави" "жу" "ненавидел" "ненавидь" "ненавидеть" );
hat_N = nMashina "шляп" ;
have_V2= dirV2 (regV imperfective first "име" "ю" "имел" "имей" "иметь" );
hear_V2= dirV2 (regV imperfective first "слуша" "ю" "слушал" "слушай" "слушать" );
hill_N = nTelefon  "холм" ;
hope_VS= regV imperfective first "наде" "ю" "надеял" "надей" "надеять" ;
horse_N = nBol "лошад" ;
hot_A = AKhoroshij "горяч" "горячее" ;
house_N = nAdres "дом" ;
important_A = AStaruyj  "важн" "важнее" ;
industry_N = nChislo "производств" ;
iron_N = nChislo "желез" ;
king_N = mkN "король" "короля" "королю" "короля" "королем" "короле" "короли" "королей" "королям" "королей" "королями" "королях" masculine animate;
know_V2= dirV2 (regV imperfective first "зна" "ю" "знал" "знай" "знать" );
lake_N = nChislo "озер" ;
lamp_N = nMashina "ламп" ;
learn_V2= dirV2 (regV imperfective second "уч" "у" "учил" "учи" "учить" );
leather_N = nEdinica "кож" ;
leave_V2= dirV2 (regV imperfective second "ухож" "у" "уходил" "уходи" "уходить" );
like_V2= dirV2 (regV imperfective second "нрав" "лю" "нравил" "нравь" "нравить" );
listen_V2= dirV2 (regV imperfective first "слуша" "ю" "слушал" "слушай" "слушать" );
live_V= regV imperfective firstE "жив" "у" "жил" "живи" "жить" ;
long_A = AStaruyj  "длинн" "длиннее" ;
lose_V2 = dirV2 (regV imperfective first "теря" "ю" "терял" "теряй" "терять" );
love_N = nBol "любов" ;
love_V2= dirV2 (regV imperfective second "люб" "лю" "любил" "люби" "любить" );
man_N = nStomatolog "человек" ;
meat_N =nChislo "мяс" ;
milk_N = nChislo "молок" ;
moon_N = nMashina  "лун" ;
mother_N2 = mkN2 ( nMashina "мам") ;
mountain_N = nMashina "гор" ;
music_N = nNoga "музык" ;
narrow_A =  AStaruyj  "узк" "уже" ;
new_A =  AStaruyj  "нов" "новее" ;
newspaper_N = nMashina "газет" ;
oil_N = nBol "нефть" ;
old_A =  AStaruyj  "стар" "старше" ;
open_V2= dirV2 (regV imperfective first "открыва" "ю" "открывал" "открывай" "открывать" );
paper_N = nNoga "бумаг" ;
peace_N = nTelefon "мир" ;
pen_N = nNoga "ручк" ;
planet_N = nMashina "планет" ;
plastic_N = nMashina "пластмасс" ;
play_V2 = mkV2 (regV imperfective first "игра" "ю" "играл" "играй" "играть" ) "c" instructive;
policeman_N = nTelefon "милиционер" ;
priest_N = nStomatolog "священник" ;
queen_N = nMashina "королев" ;
radio_N = mkIndeclinableNoun "радио" neuter inanimate;
read_V2 = dirV2 (regV imperfective first "чита" "ю" "читал" "читай" "читать" );
red_A =  AStaruyj  "красн" "краснее" ;
religion_N = nMalyariya "религи" ;
restaurant_N = nTelefon "ресторан" ;
river_N = nNoga "рек" ;
rock_N = nUroven "кам" ;
roof_N = nEdinica "крыш" ;
rubber_N = nMashina "резин" ;
run_V = regV imperfective first "бега" "ю" "бегал" "бегай" "бегать" ;
say_VS = regV imperfective second "говор" "ю" "говорил" "говори" "говорить" ;
school_N = nMashina "школ" ;
science_N = nNoga "наук" ;
sea_N = nProizvedenie "мор" ;
seek_V2 = dirV2 (regV imperfective first "ищ" "у" "искал" "ищи" "искать" );
see_V2 = dirV2 (regV imperfective second "виж" "у" "видел" "видь" "видеть" );
sell_V3 = tvDirDir (regV imperfective firstE "прода" "ю" "продавал" "продавай" "продавать" );
send_V3 = tvDirDir (regV imperfective first "посыла" "ю" "посылал" "посылай" "посылать" );
sheep_N = nMashina "овц" ;
ship_N = nNol "корабл" ;
shirt_N = nNoga "рубашк" ;
shoe_N =  mkN "туфля" "туфли" "туфле" "туфлю" "туфлей" "туфле" "туфли" "туфель" "туфлям" "туфли" "туфлями" "туфлях" masculine inanimate;
shop_N = nTelefon "магазин" ;
short_A = AMalenkij  "коротк" "короче" ;
silver_N = nChislo "серебр" ;
sister_N = nMashina "сестр" ;
sleep_V = regV imperfective second "сп" "лю" "спал" "спи" "спать" ;
small_A = AMalenkij  "маленьк" "меньше" ;
snake_N = nTetya"зме" ;
sock_N = nPotolok "нос" ;
speak_V2 = dirV2 (regV imperfective second "говор" "ю" "говорил" "говори" "говорить" );
star_N = nMashina "звезд" ;
steel_N = nBol "стал" ;
stone_N = nNol "камен" ;
stove_N = nBol "печ" ;
student_N = nTelefon "студент" ;
stupid_A =  AMolodoj  "тупой" "тупее" ;
sun_N =  mkN "солнце" "солнца" "солнцу" "солнце" "солнцем" "солнце" "солнца" "солнц" "солнцам" "солнца" "солнцами" "солнцах" neuter inanimate;
switch8off_V2 = dirV2 (regV imperfective first "выключа" "ю" "выключал" "выключай" "выключать") ;
switch8on_V2 = dirV2 (regV imperfective first "включа" "ю" "включал" "включай" "включать") ;
table_N = nTelefon "стол" ;
teacher_N = nNol "учител" ;
teach_V2 = dirV2 (regV imperfective second "уч" "у" "учил" "учи" "учить" );
television_N = nProizvedenie "телевидени" ;
thick_A = AStaruyj  "толст" "толще" ;
thin_A = AMalenkij  "тонк" "тоньше" ;
train_N = nAdres "поезд" ;
travel_V = regV imperfective first "путешеству" "ю" "путешествовал" "путешествуй" "путешествовать" ;
tree_N = nChislo "дерев" ;
--trousers_N =  mkN "" "" "" "" "" "" "штаны" "штанов" "штанам" "штаны" "штанами" "штанах" masculine inanimate;
ugly_A = AStaruyj  "некрасив" "некрасивее" ;
understand_V2 = dirV2 (regV imperfective first "понима" "ю" "понимал" "понимай" "понимать" );
university_N = nTelefon "университет" ;
village_N = nMalyariya "деревн" ;
wait_V2 = dirV2 (regV imperfective firstE "жд" "у" "ждал" "жди" "ждать" );
walk_V = regV imperfective first "гуля" "ю" "гулял" "гуляй" "гулять" ;
warm_A = AStaruyj  "тёпл" "теплее" ;
war_N = nMashina "войн" ;
watch_V2 = dirV2 (regV imperfective second "смотр" "ю" "смотрел" "смотри" "смотреть" );
water_N = nMashina "вод" ;
white_A = AStaruyj  "бел" "белее" ;
window_N = nChislo "окн" ;
wine_N = nChislo "вин" ;
win_V2 = dirV2 (regV imperfective first "выигрыва" "ю" "выигрывал" "выигрывай" "выигрывать" );
woman_N = nZhenchina "женщин" ;
wood_N = nChislo "дерев" ;
write_V2 = dirV2 (regV imperfective first "пиш" "у" "писал" "пиши" "писать" );
yellow_A = AStaruyj  "жёлт" "желтее" ;
young_A = AMolodoj  "молод" "моложе";

  do_V2 = dirV2 (regV imperfective first "дела" "ю" "делал" "делай" "делать" );
  now_Adv  = mkAdv "сейчас" ;
  already_Adv  = mkAdv "уже" ;
  song_N =  nTetya "песн" ;
  add_V3 = mkV3 (regV imperfective first "складыва" "ю" "складывал" "складывай" "складывать" ) "" "в" accusative accusative;
  number_N  = nChislo  "числ" ;
  put_V2 = dirV2 (regV imperfective firstE "клад" "у" "клал" "клади" "класть" );
  stop_V = regV imperfective first "останавлива" "ю" "останавливал" "останавливай" "останавливать";
  jump_V = regV imperfective first "прыга" "ю" "прыгал" "прыгай" "прыгать" ;

distance_N3 = mkN3 (nProizvedenie "расстояни") from_Prep to_Prep ;

-- in Russian combinations with verbs are expressed with adverbs:
-- "легко понять" ("easy to understand"), which is different from 
-- adjective expression "легкий для понимания" ("easy for understanding")
-- So the next to words are adjectives, since there are such adjectives
-- in Russian, but to use them with verb would be wrong in Russian:
fun_AV = AStaruyj "весёл" "веселее";
easy_A2V = mkA2 (AMalenkij "лёгк" "легче") "для" genitive ;

empty_A =  AMolodoj "пуст" "пустее";
married_A2 = mkA2 (adjInvar "замужем") "за" instructive ;
paint_V2A = dirV2 (regV imperfective first "рису" "ю" "рисовал" "рисуй"  "рисовать" ) ;
  probable_AS = AStaruyj "возможн" "возможнее";
 rain_V0  = idetDozhd verbIdti; --  No such verb in Russian!
talk_V3 = mkV3 (regV imperfective second "говор" "ю" "говорил" "говори" "говорить" ) "с" "о" instructive prepositional;
wonder_VQ = regV imperfective first "интересу" "ю" "интересовал" "интересуй" "интересовать";  

    -- Nouns

    animal_N = nZhivotnoe "животн" ;
    ashes_N = nPepel "пеп" ;
    back_N = nMashina "спин" ;
    bark_N = mkN "лай" "лая" "лаю" "лай" "лаем" "лае" "лаи" "лаев" "лаям" "лаи" "лаями" "лаях" masculine inanimate;
    belly_N = nTelefon "живот" ;
    bird_N = nEdinica "птиц" ;
    blood_N = nBol "кров" ;
    bone_N = nBol "кост" ;
    breast_N = nBol "грудь" ;
    
    cloud_N = nChislo "облак" ;
    day_N = mkN "день" "дня" "дню" "день" "днём" "дне" "дни" "дней" "дням" "дни" "днями" "днях" masculine inanimate ;

    dust_N = nBol "пыл" ;
   ear_N = nChislo "ухо" ;
   earth_N = nTetya "земл" ;
    egg_N = nChislo "яйц" ;
    eye_N = nAdres "глаз" ;
    fat_N = nBank "жир" ;

--    father_N = UseN2 father_N2 ;
    feather_N = mkN "перо" "пера" "перу" "пера" "пером" "пере" "перья" "перьев" "перьям" "перьев" "перьями" "перьях" neuter inanimate ;
   fingernail_N = mkN "ноготь" "ногтя" "ногтю" "ногтя" "ногтем" "ногте" "ногти" "ногтей" "ногтям" "ногтей" "ногтями" "ногтях" masculine inanimate ;
    fire_N = mkN "огонь" "огня" "огню" "огня" "огнём" "огне" "огни" "огней" "огням" "огней" "огнями" "огнях" masculine inanimate ;
    fish_N = nMashina "рыб" ;
    flower_N = mkN "отец" "отца" "отцу" "отца" "отцом" "отце" "отцы" "отцов" "отцам" "отцов" "отцами" "отцах" masculine animate ;
    fog_N = nTelefon "туман" ;
    foot_N = nTetya "ступн" ;
    forest_N = nAdres "лес" ;
    fruit_N = nTelefon "фрукт";
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
    lake_N = nChislo "озер" ;
   leaf_N = nStul "лист" ;
   leg_N = nNoga "ног" ;
  liver_N = nBol "печен" ;
  louse_N = mkN "вошь" "вши" "вши" "вошь" "вошью" "вше" "вши" "вшей" "вшам" "вшей" "вшами" "вшах" feminine animate ;
   
    meat_N = nChislo "мяс" ;
    moon_N = nMashina "лун" ;
    

    mountain_N = nMashina "гор" ;
   mouth_N =  mkN "рот" "рта" "рту" "рот" "ртом" "рте" "рты" "ртов" "ртам" "рты" "ртами" "ртах" masculine inanimate;
  name_N = mkN "имя" "имени" "имени" "имя" "именем" "имени" "имена" "имён" "именам" "имена" "именами" "именах" neuter inanimate;
  neck_N = nTetya "ше"  ;
  night_N = nBol "ноч" ;
  nose_N = nTelefon "нос" ;
  person_N = nBol "личность" ;
  rain_N = nNol "дожд" ;
   
  road_N = nNoga "дорог" ;
   root_N = nUroven "кор" ;
   rope_N =  nNoga "веревк" ;
   salt_N = nBol "сол" ;
   sand_N = mkN "песок" "песка" "песку" "песок" "песком" "песке" "пески" "песков" "пескам" "песков" "песками" "песках" masculine inanimate ;
    sea_N = nProizvedenie "мор" ;
    seed_N = mkN "семя" "семени" "семении" "семя" "семенем" "семени" "семена" "семян" "семенам" "семена" "семенами" "семенах" neuter inanimate ;
   skin_N =  nEdinica "кож" ;
   sky_N = mkN "небо" "неба" "небу" "небо" "небом" "небе" "небеса" "небес" "небесам" "небес" "небесами" "небесах" neuter inanimate ; 
   smoke_N =  nTelefon "дым" ;
    snake_N = nTetya "зме" ;
   snow_N = nAdres "снег" ;
    star_N = nMashina "звезд" ;
    stick_N = nNoga "палк" ;

    
   tail_N = nTelefon "хвост" ;
   tongue_N = nBank "язык" ;
   tooth_N = nTelefon "зуб" ;
    tree_N = nChislo "дерев" ;
    water_N = nMashina "вод" ;
    wife_N = nMashina "жен" ;
    wind_N = mkN "ветер" "ветра" "ветру" "ветер" "ветром" "ветра" "ветров" "ветра" "ветрам" "ветров" "ветрами" "ветрах" masculine inanimate ;
    wing_N = mkN "крыло" "крыла" "крылу" "крыло" "крылом" "крыле" "крылья" "крыльев" "крыльям" "крылья" "крыльями" "крыльях" neuter inanimate ;
    
   worm_N = nNol "черв" ;
   year_N = nAdres "год" ;


-- Verbs

    bite_V2 = dirV2 (regV imperfective  first "куса" "ю" "кусал" "кусай" "кусать");
    blow_V = regV imperfective  first "ду" "ю" "дул" "дуй" "дуть"  ;
   breathe_V = regV imperfective  second "дыш" "у" "дышал" "дыши" "дышать"  ;
   burn_V = regV imperfective  second "гор" "ю" "горел" "гори" "гореть"  ;
   count_V2 = dirV2 (regV imperfective  first "счита" "ю" "считал" "считай" "считать"  ) ;
    cut_V2 = dirV2 (regV imperfective  first "реж" "у" "резал" "режь" "резать" ) ;
    dig_V = regV imperfective  first "копа" "ю" "копал" "копай" "копать"  ;
   
    
    fall_V = regV imperfective  first "пада" "ю" "падал" "падай" "падать"  ;
    
    fight_V2 = dirV2 (regV imperfective  firstE "дер" "у" "драл" "дери" "драть" ) ;
    float_V = regV imperfective  firstE "плыв" "у" "плыл" "плыви" "плыть"  ;
    flow_V = regV imperfective  firstE "тек" "у" "тёк" "теки" "течь"  ;
    fly_V = regV imperfective  second "лета" "ю" "летал" "летай" "летать"  ;
    freeze_V = regV imperfective  first "замерза" "ю" "замерзал" "замерзай" "замерзать"  ;
    give_V3 = tvDirDir (regV imperfective  firstE "да" "ю" "давал" "давай" "давать" ) ;
    
    hit_V2 = dirV2 (regV imperfective  first "ударя" "ю" "ударял" "ударяй" "ударять"  );
    hold_V2 = dirV2 (regV imperfective  second "держ" "у" "держал" "держи" "держать"  );
    hunt_V2 = dirV2 (regV imperfective  second "охоч" "у" "охотил" "охоть" "охотить" ) ;
    kill_V2 = dirV2 (regV imperfective  first "убива" "ю" "убивал" "убивай" "убивать" ) ;
    
    laugh_V = regV imperfective  firstE "сме" "ю" "смеял" "смей" "смеять"  ;
    lie_V = regV imperfective  firstE "лг" "у" "лгал" "лги" "лгать"  ;
    play_V = regV imperfective  first "игра" "ю" "играл" "играй" "играть"  ;
    pull_V2 = dirV2 (regV imperfective  first "тян" "у" "тянул" "тяни" "тянуть" ) ;
    push_V2 = dirV2 (regV imperfective  first "толка" "ю" "толкал" "толкай" "толкать"  );
    rub_V2 = dirV2 (regV imperfective  firstE "тр" "у" "тёр" "три" "тереть"  );
    
    scratch_V2 = dirV2 (regV imperfective  first "чеш" "у" "чесал" "чеши" "чесать" ) ;    

    sew_V = regV imperfective  firstE "шь" "ю" "шил" "шей" "шить"  ;
    sing_V = regV imperfective  firstE "по" "ю" "пел" "пой" "петь"  ;
    sit_V = mkVerbum imperfective  "сижу" "сидишь" "сидит" "сидим" "сидите" "сидят" "сидел" "сиди" "сидеть"  ;
    smell_V = regV imperfective  first "пахн" "у" "пахнул" "пахни" "пахнуть"  ;
    spit_V = regV imperfective  firstE "плю" "ю" "плевал" "плюй" "плевать"  ;
    split_V2 = dirV2 (regV imperfective  first "разбива" "ю" "разбивал" "разбей" "разбивать" ) ;
    squeeze_V2 = dirV2 (regV imperfective  first "сжима" "ю" "сжимал" "сжимай" "сжимать" ) ;
    stab_V2 = dirV2 (regV imperfective  first "кол" "ю" "колол" "коли" "колоть" ) ;
    stand_V = regV imperfective second "сто" "ю" "стоял" "стой" "стоять"  ;
    suck_V2 = dirV2 (regV imperfective  firstE "сос" "у" "сосал" "соси" "сосать")  ;
    swell_V = regV imperfective  first "опуха" "ю" "опухал" "опухай" "опухать"  ;
    swim_V = regV imperfective  first "плава" "ю" "плавал" "плавай" "плавать"  ;
    think_V = regV imperfective  first "дума" "ю" "думал" "думай" "думать"  ;
    throw_V2 = dirV2 (regV imperfective  first "броса" "ю" "бросал" "бросай" "бросать" ) ;
    tie_V2 = dirV2 (regV imperfective  first "вяж" "у" "вязал" "вяжи" "вязать")  ;
    turn_V = regV imperfective  first "поворачива" "ю" "поворачивал" "поворачивай" "поворачивать"  ;
    vomit_V = regV imperfective  firstE "рв" "у" "рвал" "рви" "рвать"  ;
    wash_V2 = dirV2 (regV imperfective  first "мо" "ю" "мыл" "мой" "мыть" ) ;
    wipe_V2 = dirV2 (regV imperfective  first "вытира" "ю" "вытирал" "вытирай" "вытирать"  );


    correct_A = AStaruyj "правильн" "правильнее"; 
    dry_A = AMolodoj "сух" "суше";
   
    dull_A = AStaruyj "скучн" "скучнее";
    far_Adv = mkAdv "далеко";
    full_A = AStaruyj "полн" "полнее";
    heavy_A = AStaruyj "тяжел" "тяжелее";
    left_Ord = (uy_j_EndDecl   "лев" ) ** {lock_A = <>}; 
    near_A = AMalenkij "близк" "ближе";
    right_Ord = (uy_j_EndDecl  "прав") ** {lock_A = <>} ;
    rotten_A = AMolodoj "гнил" "гнилее";
    round_A = AStaruyj "кругл" "круглее";
    sharp_A = AStaruyj "остр" "острее";
    smooth_A = AMalenkij "гладк" "глаже";
    straight_A = AMolodoj "прям" "прямее";
    wet_A = AStaruyj "мокр" "мокрее";
    wide_A = AMalenkij "широк" "шире";

fear_V2 =dirV2 (regV imperfective first "бо" "ю" "боял" "бой" "боять" );
paris_PN = mkPN   "Париж"  Masc  Inanimate ;





   grammar_N = nNoga "грамматик";
   language_N = nBank "язык" ;
   rule_N = nChislo "правил" ;

}

