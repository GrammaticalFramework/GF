--# -path=.:../abstract:../common:../../prelude

concrete LexiconRus of Lexicon = CatRus ** open ParadigmsRus, Prelude, MorphoRus in {

flags 
  optimize=values ;
  coding=utf8 ;
lin
  airplane_N = nTelefon "самолет" ;
  answer_V2S = tvDir (mkRegVerb imperfective  first "о�веч�°" "ю" "о�вечал" "о�вечай" "о�веча�ь" );
  apartment_N = nMashina "квар�и�" ;
  apple_N = nChislo "яблок" ; 
  art_N = nChislo "и�к�с�тв" ;
  ask_V2Q = tvDir (mkRegVerb imperfective  first "спра�ива" "ю" "спра�ива�»" "спра�ива�¹" "спра�иват�") ;
  baby_N = nMalush "малы�";
  bad_A = AKakoj_Nibud  "плох" "" "х�же";
  bank_N = nBank "бан�º" ;
  beautiful_A =  AStaruyj "к�а�ив" "к�а�иве�µ";
  become_VA = mkRegVerb perfective second "с�ано�²" "л�" "с�ал" "с�ань" "с�а�ь" ;
  beer_N = nChislo "пив" ;
  beg_V2V = tvDir (mkRegVerb imperfective  second "п��¾" "ш�" "п�о�ил" "п�о��¸" "п�о�и�ь" );
  big_A = AKakoj_Nibud  "боль�" "" "боль��µ" ;
  bike_N = nTelefon "вело�ипе�´" ;
  bird_N = nEdinica "п�и�" ;
  black_A = AStaruyj  "ч�рн" "чернее";
  blue_A =  AMolodoj  "голуб" "голубе�µ";
  boat_N = nMashina "лод�º" ;
  book_N = nMashina "кни�³" ;
  boot_N = nBank "сапог" ;
  boss_N = nStomatolog "начальник" ;
  boy_N = nStomatolog "маль�ик" ;
  bread_N = nAdres "хле�±" ;
  break_V2 = tvDir (mkRegVerb imperfective first "п�е�ыва" "ю" "п�е�ыва�»" "п�е�ыва�¹" "п�е�ыват�" );
  broad_A = AMalenkij  "широк" "шир�µ";
  brother_N2 = mkN2  (nBrat ",б�а�") ;
  brown_A = AStaruyj  "кори�нев" "кори�невее";
  butter_N = nChislo "мас�»";
  buy_V2 = tvDir (mkRegVerb imperfective first "покупа" "ю" "покупа�»" "покупа�¹" "покупат�" );
  camera_N = nMashina "kamer" ;
  cap_N = nNoga "чаш�º" ; -- чаш-ек Pl-Gen
  car_N = nMashina "машин" ;
  carpet_N =  mkN "ковё�" "ковра" "ковр�" "ковё�" "ковром" "ковре" "ковр�" "ковров" "коврам" "ковр�" "коврам�¸" "коврах" masculine inanimate;
  cat_N = nMashina "кош�º" ;
ceiling_N =  nPotolok "потол" ; 
  chair_N = nStul "с�ул"  ;
cheese_N = nTelefon "с�р" ;
child_N = mkN "ребёно�º" "ребёнк�°" "ребёнку" "ребёнк�°" "ребёнком" "ребёнк�µ" "дет�¸"  "детей" "детям" "детей" "детьми"  "детя�" masculine animate ;
  church_N = mkN "церковь" "церкви" "церкви" "церковь" "церковь�" "церкви" "церкви" "церкве�¹" "церквя�¼" "церкви" "церквями" "церквях" masculine inanimate;
  city_N = nAdres "город" ;
  clean_A =  AStaruyj  "чист" "чищ�µ"; 
  clever_A =  AStaruyj "умн" "умнее";
  close_V2= tvDir (mkRegVerb imperfective first "закр�ва" "ю" "закр�вал" "закр�вай" "закр�вать" );
  coat_N = mkIndeclinableNoun "паль��¾" masculine inanimate ;
  cold_A =  AStaruyj  "холодн" "холоднее";
  come_V = mkRegVerb imperfective first "п�и��¾" "ж�" "п�и�оди�»" "п�и�оди" "п�и�одит�" ;
  computer_N = nTelefon  "комп�ю�е�" ;
  country_N = nMashina "с�ран" ;
cousin_N = nTelefon "к�зен" ;
cow_N = nMashina "коров" ;
die_V = mkRegVerb imperfective first "умира" "ю" "умирал" "умрай" "умирать" ;
dirty_A =  AStaruyj  "г�язн" "г�язнее" ;
doctor_N = nAdres "доктор" ;
dog_N = nNoga "собак" ;
door_N = nBol "двер" ;
drink_V2 = tvDir (mkRegVerb imperfective firstE "п�" "ю" "пил" "пей" "пить" );
eat_V2 = tvDir (mkRegVerb imperfective first "к�ша" "ю" "к�шал" "к�шай" "к�шать" );
enemy_N = nStomatolog "в�аг" ;
factory_N = nNoga "фабрик" ;
father_N2 = mkN2 (mkN "о�е�" "о�ца" "о�ц�" "о�ца" "о�цом" "о�це" "о�ц�" "о�цов" "о�цам" "о�цов" "о�цам�¸" "о�цах" masculine animate);
fear_VS= mkRegVerb imperfective second "бо" "ю" "боя�»" "бой" "боят�" ;
find_V2 = tvDir (mkRegVerb imperfective second "нах�¾" "ж�" "находи�»" "находи" "находит�" );
fish_N = nMashina "р��±" ;
floor_N = nTelefon "пол" ;
forget_V2= tvDir (mkRegVerb imperfective first "забыва" "ю" "забыва�»" "забыва�¹" "забыват�" );
fridge_N = nBank "холодил�ник" ;
friend_N = mkN "д�уг" "д�уга" "д�угу" "д�уга" "д�уго�¼" "д�уге" "д�узья" "д�узе�¹" "д�узьям" "д�узе�¹" "д�з�ями" "д�узья�" masculine animate;
fruit_N = nTelefon "ф�укт" ;
garden_N = nTelefon  "сад" ;
girl_N = nNoga "дево��º" ;
glove_N = nNoga "перчат�º" ;
gold_N = nChislo "золо�" ;
good_A = AKhoroshij "хоро�" "л�ч��µ" ; 
go_V= mkRegVerb imperfective second "хо" "ж�" "ходил" "ход�¸" "ходи�ь" ;
green_A = AStaruyj  "зелен" "зелене�µ" ;
harbour_N = nTelefon "залив" ;
hate_V2= tvDir (mkRegVerb imperfective second "ненави" "ж�" "ненавидел" "ненавид�" "ненавидеть" );
hat_N = nMashina "шля�¿" ;
have_V2= tvDir (mkRegVerb imperfective first "име" "ю" "име�»" "име�¹" "имет�" );
hear_V2= tvDir (mkRegVerb imperfective first "слуша" "ю" "слушал" "слушай" "слушать" );
hill_N = nTelefon  "хол�¼" ;
hope_VS= mkRegVerb imperfective first "над�µ" "ю" "наде��»" "надей" "наде�т�" ;
horse_N = nBol "лошад" ;
hot_A = AKhoroshij "горя�" "горя�ее" ;
house_N = nAdres "дом" ;
important_A = AStaruyj  "важ�½" "важнее" ;
industry_N = nChislo "п�оизводс��²" ;
iron_N = nChislo "желез" ;
king_N = mkN "король" "короля" "королю" "короля" "короле�¼" "короле" "короли" "короле�¹" "короля�¼" "короле�¹" "королями" "королях" masculine animate;
know_V2= tvDir (mkRegVerb imperfective first "зна" "ю" "зна�»" "зна�¹" "знат�" );
lake_N = nChislo "озер" ;
lamp_N = nMashina "лам�¿" ;
learn_V2= tvDir (mkRegVerb imperfective second "у�" "у" "у�ил" "у��¸" "у�и�ь" );
leather_N = nEdinica "кож" ;
leave_V2= tvDir (mkRegVerb imperfective second "у�ож" "у" "у�оди�»" "у�оди" "у�одит�" );
like_V2= tvDir (mkRegVerb imperfective second "н�ав" "л�" "н�ави�»" "н�авь" "н�авит�" );
listen_V2= tvDir (mkRegVerb imperfective first "слуша" "ю" "слушал" "слушай" "слушать" );
live_V= mkRegVerb imperfective firstE "жив" "у" "жил" "жив�¸" "жить" ;
long_A = AStaruyj  "длинн" "длинне�µ" ;
lose_V2 = tvDir (mkRegVerb imperfective first "теря" "ю" "терял" "теряй" "теря�ь" );
love_N = nBol "л�бов" ;
love_V2= tvDir (mkRegVerb imperfective second "л��±" "л�" "л�бил" "л�би" "л�бить" );
man_N = nStomatolog "челове�º" ;
meat_N =nChislo "м�с" ;
milk_N = nChislo "молок" ;
moon_N = nMashina  "л��½" ;
mother_N2 = mkN2 ( nMashina "мам") ;
mountain_N = nMashina "гор" ;
music_N = nNoga "м�з��º" ;
narrow_A =  AStaruyj  "узк" "уже" ;
new_A =  AStaruyj  "нов" "новее" ;
newspaper_N = nMashina "газе�" ;
oil_N = nBol "нефт�" ;
old_A =  AStaruyj  "с�а�" "с�а�ше" ;
open_V2= tvDir (mkRegVerb imperfective first "о�к�ыва" "ю" "о�к�ыва�»" "о�к�ыва�¹" "о�к�ыват�" );
paper_N = nNoga "б�маг" ;
peace_N = nTelefon "мир" ;
pen_N = nNoga "р�чк" ;
planet_N = nMashina "планет" ;
plastic_N = nMashina "плас�масс" ;
play_V2 = tvDir (mkRegVerb imperfective first "игр�°" "ю" "играл" "играй" "игра�ь" );
policeman_N = nTelefon "мили�ионе�" ;
priest_N = nStomatolog "священник" ;
queen_N = nMashina "короле�²" ;
radio_N = mkIndeclinableNoun "радио" neuter inanimate;
read_V2 = tvDir (mkRegVerb imperfective first "чит�°" "ю" "читал" "читай" "чита�ь" );
red_A =  AStaruyj  "к�а��½" "к�а�нее" ;
religion_N = nMalyariya "религи" ;
restaurant_N = nTelefon "ресторан" ;
river_N = nNoga "рек" ;
rock_N = nUroven "кам" ;
roof_N = nEdinica "к�ы�" ;
rubber_N = nMashina "резин" ;
run_V = mkRegVerb imperfective first "бег�°" "ю" "бегал" "бегай" "бега�ь" ;
say_VS = mkRegVerb imperfective second "гово�" "ю" "гово�ил" "гово��¸" "гово�и�ь" ;
school_N = nMashina "шко�»" ;
science_N = nEdinica "нау�º" ;
sea_N = nProizvedenie "мор" ;
seek_V2 = tvDir (mkRegVerb imperfective first "и�" "у" "и�кал" "и��¸" "и�кать" );
see_V2 = tvDir (mkRegVerb imperfective second "виж" "у" "видел" "видь" "виде�ь" );
sell_V3 = tvDirDir (mkRegVerb imperfective firstE "п�ода" "ю" "п�одавал" "п�одавай" "п�одавать" );
send_V3 = tvDirDir (mkRegVerb imperfective first "посыла" "ю" "посыла�»" "посыла�¹" "посылат�" );
sheep_N = nMashina "овц" ;
ship_N = nNol "корабл" ;
shirt_N = nNoga "р�баш�º" ;
shoe_N =  mkN "т�фля" "т�фли" "т�фле" "т�флю" "т�фле�¹" "т�фле" "т�фли" "т�фель" "т�фля�¼" "т�фли" "т�флями" "т�флях" masculine inanimate;
shop_N = nTelefon "магази�½" ;
short_A = AMalenkij  "коро��º" "коро��µ" ;
silver_N = nChislo "серебр" ;
sister_N = nMashina "сест�" ;
sleep_V = mkRegVerb imperfective second "сп" "л�" "спа�»" "спи" "спат�" ;
small_A = AMalenkij  "малень�º" "мень��µ" ;
snake_N = nTetya"зме" ;
sock_N = nPotolok "нос" ;
speak_V2 = tvDir (mkRegVerb imperfective second "гово�" "ю" "гово�ил" "гово��¸" "гово�и�ь" );
star_N = nMashina "звезд" ;
steel_N = nBol "с�ал" ;
stone_N = nNol "камен" ;
stove_N = nBol "печ" ;
student_N = nTelefon "с�уден�" ;
stupid_A =  AMolodoj  "т�пой" "т�пее" ;
sun_N =  mkN "солн��µ" "солн��°" "солн�у" "солн��µ" "солн�ем" "солн��µ" "солн��°" "солн�" "солн�ам" "солн��°" "солн�ами" "солн�а�" neuter inanimate;
switch8off_V2 = tvDir (mkRegVerb imperfective first "в�ключа" "ю" "в�ключал" "в�ключай" "в�ключать") ;
switch8on_V2 = tvDir (mkRegVerb imperfective first "вклю��°" "ю" "вклю�ал" "вклю�ай" "вклю�а�ь") ;
table_N = nTelefon "с�ол" ;
teacher_N = nNol "у�и�ел" ;
teach_V2 = tvDir (mkRegVerb imperfective second "у�" "у" "у�ил" "у��¸" "у�и�ь" );
television_N = nProizvedenie "телевиден�¸" ;
thick_A = AStaruyj  "толс�" "толще" ;
thin_A = AMalenkij  "тон�º" "тонь��µ" ;
train_N = nAdres "поезд" ;
travel_V = mkRegVerb imperfective first "п�теше�тву" "ю" "п�теше�твовал" "п�теше�тву�¹" "п�теше�твовать" ;
tree_N = nChislo "дерев" ;
--trousers_N =  mkN "" "" "" "" "" "" "ш�аны" "ш�ано�²" "ш�ана�¼" "ш�аны" "ш�анами" "ш�анах" masculine inanimate;
ugly_A = AStaruyj  "некрасив" "некрасиве�µ" ;
understand_V2 = tvDir (mkRegVerb imperfective first "понима" "ю" "понима�»" "понима�¹" "понимат�" );
university_N = nTelefon "университе�" ;
village_N = nMalyariya "деревн" ;
wait_V2 = tvDir (mkRegVerb imperfective firstE "жд" "у" "жда�»" "жди" "ждат�" );
walk_V = mkRegVerb imperfective first "г�л�" "ю" "г�л��»" "г�л��¹" "г�л�т�" ;
warm_A = AStaruyj  "т�пл" "теплее" ;
war_N = nMashina "вой�½" ;
watch_V2 = tvDir (mkRegVerb imperfective second "смот�" "ю" "смот�ел" "смот��¸" "смот�е�ь" );
water_N = nMashina "вод" ;
white_A = AStaruyj  "бел" "белее" ;
window_N = nChislo "окн" ;
wine_N = nChislo "вин" ;
win_V2 = tvDir (mkRegVerb imperfective first "в�игрыва" "ю" "в�игрыва�»" "в�игрыва�¹" "в�игрыват�" );
woman_N = nZhenchina "женщин" ;
wood_N = nChislo "дерев" ;
write_V2 = tvDir (mkRegVerb imperfective first "пиш" "у" "писал" "пиш�¸" "писа�ь" );
yellow_A = AStaruyj  "ж�л�" "желтее" ;
young_A = AMolodoj  "молод" "моложе";

  do_V2 = tvDir (mkRegVerb imperfective first "дел�°" "ю" "делал" "делай" "дела�ь" );
  now_Adv  = mkAdv "сейчас" ;
  already_Adv  = mkAdv "уже" ;
  song_N =  nTetya "пес�½" ;
  add_V3 = mkV3 (mkRegVerb imperfective first "складыва" "ю" "складывал" "складывай" "складывать" ) "" "�²" accusative accusative;
  number_N  = nChislo  "чис�»" ;
  put_V2 = tvDir (mkRegVerb imperfective firstE "кла�´" "у" "кла�»" "клади" "клас�ь" );
  stop_V = mkRegVerb imperfective first "о�танавлива" "ю" "о�танавлива�»" "о�танавлива�¹" "о�танавливат�";
  jump_V = mkRegVerb imperfective first "п�ыга" "ю" "п�ыга�»" "п�ыга�¹" "п�ыгат�" ;

---- distance_N3 = mkN3 (nProizvedenie "расс�о��½") from_Prep to_Prep ;

-- in Russian combinations with verbs are expressed with adverbs:
-- "легко поня�ь" ("easy to understand"), which is different from 
-- adjective expression "легкий для понимания" ("easy for understanding")
-- So the next to words are adjectives, since there are such adjectives
-- in Russian, but to use them with verb would be wrong in Russian:
fun_AV = AStaruyj "весёл" "веселе�µ";
easy_A2V = mkA2 (AMalenkij "лег�º" "легче") "для" genitive ;

empty_A =  AMolodoj "п�с�" "п�с�ее";
married_A2 = mkA2 (adjInvar "замуже�¼") "за" instructive ;
paint_V2A = tvDir (mkRegVerb imperfective first "рису" "ю" "рисова�»" "рисуй"  "рисоват�" ) ;
  probable_AS = AStaruyj "возможн��¹" "возможнее";
--  rain_V0  No such verb in Russian!
talk_V3 = mkV3 (mkRegVerb imperfective second "гово�" "ю" "гово�ил" "гово��¸" "гово�и�ь" ) "с" "�¾" instructive prepositional;
wonder_VQ = mkRegVerb imperfective first "инте�е�у" "ю" "инте�е�ова�»" "инте�е�уй" "инте�е�оват�";  

    -- Nouns

    animal_N = nZhivotnoe "живо��½" ;
    ashes_N = nPepel "пеп" ;
    back_N = nMashina "спи�½" ;
    bark_N = mkN "лай" "лая" "лаю" "лай" "лае�¼" "лае" "лаи" "лае�²" "лая�¼" "лаи" "лаями" "лаях" masculine inanimate;
    belly_N = nTelefon "живо�" ;
    bird_N = nEdinica "п�и�" ;
    blood_N = nBol "к�ов" ;
    bone_N = nBol "кост" ;
    breast_N = nBol "г�удь" ;
    
    cloud_N = nChislo "облак" ;
    day_N = mkN "день" "дня" "дню" "день" "днё�¼" "дне" "дни" "дне�¹" "дня�¼" "дни" "днями" "днях" masculine inanimate ;

    dust_N = nBol "п��»" ;
   ear_N = nChislo "у��¾" ;
   earth_N = nTetya "зем�»" ;
    egg_N = nChislo "яйц" ;
    eye_N = nAdres "гла�·" ;
    fat_N = nBank "жир" ;

--    father_N = UseN2 father_N2 ;
    feather_N = mkN "пер�¾" "пер�°" "перу" "пер�°" "пером" "пер�µ" "перь�" "перьев" "перь��¼" "перьев" "перь�ми" "перь�х" neuter inanimate ;
   fingernail_N = mkN "ного�ь" "ногт�" "ногт�" "ногт�" "ногтем" "ногте" "ногти" "ногтей" "ногт��¼" "ногтей" "ногт�ми" "ногт�х" masculine inanimate ;
    fire_N = mkN "огон�" "огня" "огню" "огня" "огнём" "огн�µ" "огн�¸" "огней" "огням" "огней" "огнями" "огня�" masculine inanimate ;
    fish_N = nMashina "р��±" ;
    flower_N = mkN "о�е�" "о�ца" "о�ц�" "о�ца" "о�цом" "о�це" "о�ц�" "о�цов" "о�цам" "о�цов" "о�цам�¸" "о�цах" masculine animate ;
    fog_N = nTelefon "т�ман" ;
    foot_N = nTetya "с�упн" ;
    forest_N = nAdres "лес" ;
    fruit_N = nTelefon "ф�укт";
    grass_N = nMashina "т�ав" ;
    guts_N =  nBol "внут�енно�т" ;
    hair_N = nTelefon "воло�" ;
   hand_N =  nNoga "р��º" ;
   head_N = nMashina "голов" ;
   heart_N = mkN "серд��µ" "серд��°" "серд�у" "серд��°" "серд�ем" "серд��µ" "серд��°" "сердец" "серд�ам" "сердец" "серд�ами" "серд�а�" neuter inanimate;
   horn_N = nAdres "рог" ;
   husband_N = mkN "м��¶" "м�жа" "м�ж�" "м�жа" "м�жем" "м�же" "м�ж�я" "м�жей" "м�ж�ям" "м�жей" "м�ж�ями" "м�ж�я�" masculine animate ;
   ice_N = mkN "л��´" "л�да" "л�д�" "л�да" "л�дом" "л�де" "л�д�" "л�дов" "л�дам" "л�дов" "л�дам�¸" "л�дах" masculine inanimate ;
   knee_N = mkN "колено" "колена" "колену" "колена" "колено�¼" "колене" "колени" "колен" "колена�¼" "колен" "коленями" "коленях" neuter inanimate ;
    lake_N = nChislo "озер" ;
   leaf_N = nStul "лист" ;
   leg_N = nNoga "ног" ;
  liver_N = nBol "печен" ;
  louse_N = mkN "вошь" "в��¸" "в��¸" "вошь" "вошь�" "в��µ" "в��¸" "в�ей" "в�ам" "в�ей" "в�ами" "в�а�" feminine animate ;
   
    meat_N = nChislo "м�с" ;
    moon_N = nMashina "л��½" ;
    

    mountain_N = nMashina "гор" ;
   mouth_N =  mkN "рот" "р��°" "р�у" "рот" "р�ом" "р��µ" "р�ы" "р�ов" "р�ам" "р�ы" "р�ами" "р�а�" masculine inanimate;
  name_N = mkN "имя" "имени" "имени" "имя" "именем" "имени" "имена" "имё�½" "именам" "имена" "именам�¸" "именах" neuter inanimate;
  neck_N = nTetya "ше"  ;
  night_N = nBol "ноч" ;
  nose_N = nTelefon "нос" ;
  person_N = nBol "личност�" ;
  rain_N = nNol "дож�´" ;
   
  road_N = nNoga "дорог" ;
   root_N = nUroven "кор" ;
   rope_N =  nNoga "веревк" ;
   salt_N = nBol "сол" ;
   sand_N = mkN "песок" "песка" "песк�" "песок" "песком" "песке" "пески" "песков" "пескам" "песков" "пескам�¸" "песках" masculine inanimate ;
    sea_N = nProizvedenie "мор" ;
    seed_N = mkN "семя" "семени" "семени�¸" "семя" "семене�¼" "семени" "семена" "семян" "семена�¼" "семена" "семенами" "семенах" neuter inanimate ;
   skin_N =  nEdinica "кож" ;
   sky_N = mkN "неб�¾" "неб�°" "небу" "неб�¾" "небом" "неб�µ" "небе��°" "небе�" "небе�ам" "небе�" "небе�ами" "небе�а�" neuter inanimate ; 
   smoke_N =  nTelefon "д��¼" ;
    snake_N = nTetya "зме" ;
   snow_N = nAdres "сне�³" ;
    star_N = nMashina "звезд" ;
    stick_N = nNoga "пал�º" ;

    
   tail_N = nTelefon "хвос�" ;
   tongue_N = nBank "язы�º" ;
   tooth_N = nTelefon "з��±" ;
    tree_N = nChislo "дерев" ;
    water_N = nMashina "вод" ;
    wife_N = nMashina "жен" ;
    wind_N = mkN "вете�" "ветра" "ветр�" "вете�" "ветром" "ветра" "ветров" "ветра" "ветрам" "ветров" "ветрам�¸" "ветрах" masculine inanimate ;
    wing_N = mkN "к�ыло" "к�ыла" "к�ылу" "к�ыло" "к�ыло�¼" "к�ыле" "к�ылья" "к�ыльев" "к�ыльям" "к�ылья" "к�ыльями" "к�ылья�" neuter inanimate ;
    
   worm_N = nNol "чер�²" ;
   year_N = nAdres "год" ;


-- Verbs

    bite_V2 = tvDir (mkRegVerb imperfective  first "к�са" "ю" "к�сал" "к�сай" "к�сать");
    blow_V = mkRegVerb imperfective  first "д�" "ю" "д��»" "д��¹" "д�т�"  ;
   breathe_V = mkRegVerb imperfective  second "д�ш" "у" "д�шал" "д�ши" "д�шать"  ;
   burn_V = mkRegVerb imperfective  second "гор" "ю" "горел" "гор�¸" "горе�ь"  ;
   count_V2 = tvDir (mkRegVerb imperfective  first "с�и��°" "ю" "с�и�ал" "с�и�ай" "с�и�а�ь"  ) ;
    cut_V2 = tvDir (mkRegVerb imperfective  first "реж" "у" "резал" "режь" "реза�ь" ) ;
    dig_V = mkRegVerb imperfective  first "коп�°" "ю" "копал" "копай" "копа�ь"  ;
   
    
    fall_V = mkRegVerb imperfective  first "пад�°" "ю" "падал" "падай" "пада�ь"  ;
    
    fight_V2 = tvDir (mkRegVerb imperfective  firstE "дер" "у" "д�ал" "дер�¸" "д�а�ь" ) ;
    float_V = mkRegVerb imperfective  firstE "плы�²" "у" "плы�»" "плыви" "плыт�"  ;
    flow_V = mkRegVerb imperfective  firstE "тек" "у" "т��º" "тек�¸" "течь"  ;
    fly_V = mkRegVerb imperfective  second "лет�°" "ю" "летал" "летай" "лета�ь"  ;
    freeze_V = mkRegVerb imperfective  first "заме�за" "ю" "заме�зал" "заме�зай" "заме�зать"  ;
    give_V3 = tvDirDir (mkRegVerb imperfective  firstE "да" "ю" "давал" "давай" "дава�ь" ) ;
    
    hit_V2 = tvDir (mkRegVerb imperfective  first "удар�" "ю" "удар��»" "удар��¹" "удар�т�"  );
    hold_V2 = tvDir (mkRegVerb imperfective  second "дер�¶" "у" "держал" "держи" "держать"  );
    hunt_V2 = tvDir (mkRegVerb imperfective  second "о�о�" "у" "о�о�ил" "о�о�ь" "о�о�и�ь" ) ;
    kill_V2 = tvDir (mkRegVerb imperfective  first "убива" "ю" "убивал" "убивай" "убивать" ) ;
    
    laugh_V = mkRegVerb imperfective  firstE "сме" "ю" "смеял" "сме�¹" "смея�ь"  ;
    lie_V = mkRegVerb imperfective  firstE "лг" "у" "лга�»" "лги" "лгат�"  ;
    play_V = mkRegVerb imperfective  first "игр�°" "ю" "играл" "играй" "игра�ь"  ;
    pull_V2 = tvDir (mkRegVerb imperfective  first "т��½" "у" "т�н��»" "т�ни" "т�н�т�" ) ;
    push_V2 = tvDir (mkRegVerb imperfective  first "толка" "ю" "толкал" "толкай" "толкать"  );
    rub_V2 = tvDir (mkRegVerb imperfective  firstE "т�" "у" "т�р" "т��¸" "тере�ь"  );
    
    scratch_V2 = tvDir (mkRegVerb imperfective  first "чеш" "у" "чесал" "чеш�¸" "чеса�ь" ) ;    

    sew_V = mkRegVerb imperfective  firstE "ш�" "ю" "шил" "шей" "шить"  ;
    sing_V = mkRegVerb imperfective  firstE "по" "ю" "пел" "пой" "петь"  ;
    sit_V = mkVerbum imperfective  "сижу" "сиди�ь" "сиди�" "сидим" "сиди��µ" "сидя�" "сидел" "сид�¸" "сиде�ь"  ;
    smell_V = mkRegVerb imperfective  first "пах�½" "у" "пахн��»" "пахни" "пахн�т�"  ;
    spit_V = mkRegVerb imperfective  firstE "плю" "ю" "плевал" "плю�¹" "плевать"  ;
    split_V2 = tvDir (mkRegVerb imperfective  first "разбив�°" "ю" "разбивал" "разбей" "разбива�ь" ) ;
    squeeze_V2 = tvDir (mkRegVerb imperfective  first "сжима" "ю" "сжимал" "сжимай" "сжимать" ) ;
    stab_V2 = tvDir (mkRegVerb imperfective  first "кол" "ю" "колол" "кол�¸" "коло�ь" ) ;
    stand_V = mkRegVerb imperfective second "с��¾" "ю" "с�о��»" "с�ой" "с�о�т�"  ;
    suck_V2 = tvDir (mkRegVerb imperfective  firstE "сос" "у" "сосал" "сос�¸" "соса�ь")  ;
    swell_V = mkRegVerb imperfective  first "опуха" "ю" "опухал" "опухай" "опухать"  ;
    swim_V = mkRegVerb imperfective  first "плава" "ю" "плавал" "плавай" "плавать"  ;
    think_V = mkRegVerb imperfective  first "д�ма" "ю" "д�мал" "д�май" "д�мать"  ;
    throw_V2 = tvDir (mkRegVerb imperfective  first "б�о��°" "ю" "б�о�ал" "б�о�ай" "б�о�а�ь" ) ;
    tie_V2 = tvDir (mkRegVerb imperfective  first "в��¶" "у" "в�зал" "в�жи" "в�зать")  ;
    turn_V = mkRegVerb imperfective  first "пово�а�ива" "ю" "пово�а�ива�»" "пово�а�ива�¹" "пово�а�иват�"  ;
    vomit_V = mkRegVerb imperfective  firstE "рв" "у" "рва�»" "рви" "рват�"  ;
    wash_V2 = tvDir (mkRegVerb imperfective  first "мо" "ю" "м��»" "мой" "м�т�" ) ;
    wipe_V2 = tvDir (mkRegVerb imperfective  first "в�тир�°" "ю" "в�тирал" "в�тирай" "в�тира�ь"  );


    correct_A = AStaruyj "п�авил��½" "п�авил�нее"; 
    dry_A = AMolodoj "с�х" "с�ше";
   
    dull_A = AStaruyj "скучн" "скучне�µ";
    far_Adv = mkAdv "далеко";
    full_A = AStaruyj "пол�½" "полнее";
    heavy_A = AStaruyj "т�жел" "т�желее";
    left_Ord = (uy_j_EndDecl   "лев" ) ** {lock_A = <>}; 
    near_A = AMalenkij "близк" "ближе";
    right_Ord = (uy_j_EndDecl  "п�ав") ** {lock_A = <>} ;
    rotten_A = AMolodoj "гни�»" "гнилее";
    round_A = AStaruyj "к�угл" "к�углее";
    sharp_A = AStaruyj "о�т�" "о�т�ее";
    smooth_A = AMalenkij "гладк" "глаже";
    straight_A = AMolodoj "п�ям" "п�яме�µ";
    wet_A = AStaruyj "мокр" "мокрее";
    wide_A = AMalenkij "широк" "шир�µ";

fear_V2 =tvDir (mkRegVerb imperfective first "бо" "ю" "боя�»" "бой" "боят�" );

paris_PN = mkPN   "Париж"  Masc  Inanimate ;
--rain_V0 Does not exist in Russian


} 

