--# -path=.:../abstract:../../prelude
--# -val

concrete BasicRus of Basic = CategoriesRus ** open ParadigmsRus in {
flags 
  optimize=values ;
  coding=utf8 ;
lin
  airplane_N = nTelefon "самолет" ;
  answer_V2S = mkV2S (caseV2 (regV "vastata") allative) ;
  apartment_N = nMashina "квартир" ;
  apple_N = nChislo "яблок" ; 
  art_N = nChislo "искусств" ;
  ask_V2Q = mkV2Q (caseV2 (regV "kysyä") ablative) ;
  baby_N = nMalush "малыш";
  bad_ADeg = mkADeg (nLukko "paha") "pahempi" "pahin" ;
  bank_N = nBank "банк" ;
  beautiful_ADeg = mkADeg (regN "kaunis") "kauniimpi" "kaunein" ;
  become_VA = mkVA (regV "tulla") translative ;
  beer_N = nChislo "пив" ;
  beg_V2V = mkV2V (caseV2 (reg2V "pyytää" "pyysi") partitive) ;
  big_ADeg = mkADeg (sgpartN (nArpi "suuri") "suurta") "suurempi" "suurin" ;
  bike_N = nTelefon "велосипед" ; --- for correct vowel harmony
  bird_N = nEdinica "птиц" ;
  black_ADeg = mkADeg (nLukko "musta") "mustempi" "mustin" ;
  blue_ADeg = mkADeg (regN "sininen") "sinisempi" "sinisin" ;
  boat_N = nMashina "лодк" ;
  book_N = nMashina "книг" ;
  boot_N = nBank "сапог" ;
  boss_N = nStomatolog "начальник" ;
  boy_N = nStomatolog "мальчик" ;
  bread_N = nAdres "хлеб" ;
  break_V2 = dirV2 (regV "rikkoa") ;
  broad_ADeg = mkADeg (regN "leveä") "leveämpi" "levein" ;
  brother_N2 = funGen  (nBrat ",брат") ;
  brown_ADeg = mkADeg (regN "ruskea") "ruskeampi" "ruskein" ;
  butter_N = nChislo "масл";
  buy_V2 = dirV2 (regV "ostaa") ;
  camera_N = nMashina "kamer" ;
  cap_N = nNoga "чашк" ; чаш-ек Pl-Gen
  car_N = nMashina "машин" ;
  carpet_N =  mkN "ковёр" "ковра" "ковру" "ковёр" "ковром" "ковре" "ковры" "ковров" "коврам" "ковры" "коврами" "коврах" Masc Inanimate;
  cat_N = nMashina "кошк" ;
  ceiling_N =  nPotolok"потол" ; 
  chair_N = nStul "стул"  ;
  cheese_N = nTelefon "сыр" ;
  
 child_N = mkN "ребёнок" "ребёнка" "ребёнку" "ребёнка" "ребёнком" "ребёнке" "дети" "детей" "детям" "детей" "детьми" "детях" Masc Animate;
  church_N = mkN "церковь" "церкви" "церкви" "церковь" "церковью" "церкви" "церкви" "церквей" "церквям" "церкви" "церквями" "церквях" Masc Inanimate;
  city_N = nAdres "город" ;
  clean_ADeg = regADeg "ren" ;
  clever_ADeg = regADeg "klok" ;
  close_V2 = dirV2 (mk2V "stänga" "stängde") ;
  coat_N = mkIndeclinableNoun "пальто" Masc Inanimate ;
  cold_ADeg = regADeg "kall" ;
  come_V = (mkV "komma" "kommer" "kom" "kom" "kommit" "kommen") ;
  computer_N = nTelefon  "компьютер" ;
  country_N = nMashina "стран" ;
cousin_N = nTelefon "кузен" ;
cow_N = nMashina "коров" ;
die_V = "" ;
dirty_ADeg = "" ;
doctor_N = nAdres "доктор" ;
dog_N = nNoga "собак" ;
door_N = nBol "двер" ;
drink_V2 = "" ;
eat_V2
enemy_N = nStomatolog "враг" ;
factory_N = nNoga "фабрик" ;
father_N = mkN "отец" "отца" "отцу" "отца" "отцом" "отце" "отцы" "отцов" "отцам" "отцов" "отцами" "отцах" Masc Animate;
fear_VS
find_V2
fish_N = nMashina "рыб" ;
floor_N = nTelefon "пол" ;
forget_V2
fridge_N = nBank "холодильник " ;
friend_N = mkN "друг" "друга" "другу" "друга" "другом" "друге" "друзья" "друзей" "друзьям" "друзей" "дузьями" "друзьях" Masc Animate;
fruit_N = nTelefon "фрукт" ;
garden_N = nTelefon  "сад" ;
girl_N = nNoga "девочк" ;
glove_N = nNoga "перчатк" ;
gold_N = nChislo "золот" ;
good_ADeg
go_V
green_ADeg
harbour_N = nTelefon "залив" ;
hate_V2
hat_N = nMashina "шляп" ;
have_V2
hear_V2
hill_N = nTelefon  "холм" ;
hope_VS
horse_N = nBol "лошад" ;
hot_ADeg
house_N = nAdres "дом" ;
important_ADeg
industry_N = nChislo "производств" ;
iron_N = nChislo "желез" ;
king_N = mkN "король" "короля" "королю" "короля" "королем" "короле" "короли" "королей" "королям" "королей" "королями" "королях" Masc Animate;
know_V2
lake_N = nChislo "озер" ;
lamp_N = nMashina "ламп" ;
learn_V2
leather_N = nEdinica "кож" ;
leave_V2
like_V2
listen_V2
live_V
long_ADeg
lose_V2 
love_N = nBol "любов" ;
love_V2
man_N = nStomatolog "человек" ;
meat_N =nChislo "мяс" ;
milk_N = nChislo "молок" ;
moon_N = nMashina  "лун" ;
mother_N = nMashina "мам" ;
mountain_N = nMashina "гор" ;
music_N = nNoga "музык" ;
narrow_ADeg
new_ADeg
newspaper_N = nMashina "газет" ;
oil_N = nBol "нефть" ;
old_ADeg
open_V2
paper_N = nNoga "бумаг" ;
peace_N = nTelefon "мир" ;
pen_N = nNoga "ручк" ;
planet_N = nMashina "планет" ;
plastic_N = nMashina "пластмасс" ;
play_V2
policeman_N = nTelefon "милиционер" ;
priest_N = nStomatolog "священник" ;
queen_N = nMashina "королев" ;
radio_N = mkIndeclinableNoun "радио" ;
read_V2
red_ADeg
religion_N = nMalyariya "религи" ;
restaurant_N = nTelefon "ресторан" ;
river_N = nNog "рек" ;
rock_N = nUroven "кам" ;
roof_N = nEdinica "крыш" ;
rubber_N = nMashina "резин" ;
run_V
say_VS
school_N = nMashina "школ" ;
science_N = nEdinica "наук" ;
sea_N = nProizvedenie "мор" ;
seek_V2
see_V2
sell_V3
send_V3
sheep_N = nMashina "овц" ;
ship_N = nNol "корабл" ;
shirt_N = nNoga "рубашк" ;
shoe_N =  mkN "туфля" "туфли" "туфле" "туфлю" "туфлей" "туфле" "туфли" "туфель" "туфлям" "туфли" "туфлями" "туфлях" Masc Inanimate;
shop_N = nTelefon "магазин" ;
short_ADeg
silver_N = nChislo "серебр" ;
sister_N = nMashina "сестр" ;
sleep_V
small_ADeg
snake_N = nTetya"зме" ;
sock_N = nPotolok "нос" ;
speak_V2
star_N = nMashina "звезд" ;
steel_N = nBol "стал" ;
stone_N = nNol "камен" ;
stove_N = nBol "печ" ;
student_N = nTelefon "студент" ;
stupid_ADeg
sun_N =  mkN "солнце" "солнца" "солнцу" "солнце" "солнцем" "солнце" "солнца" "солнц" "солнцам" "солнца" "солнцами" "солнцах" Neut Inanimate;
switch8off_V
switch8on_V
table_N = nTelefon "стол" ;
teacher_N = nNol "учител" ;
teach_V2
television_N = nProizvedenie "телевидени" ;
thick_ADeg
thin_ADeg
train_N = nAdres "поезд" ;
travel_V
tree_N = nChislo "дерев" ;
trousers_N =  mkN "" "" "" "" "" "" "штаны" "штанов" "штанам" "штаны" "штанами" "штанах" Masc Inanimate;
ugly_ADeg
understand_V2
university_N = nTelefon "университет" ;
village_N = nMalyariya "деревн" ;
wait_V2
walk_V
warm_ADeg
war_N = nMashina "войн" ;
watch_V2
water_N = nMashina "вод" ;
white_ADeg
window_N = nChislo "окн" ;
wine_N = nChislo "вин" ;
win_V2
woman_N = nZhenchina "женщин" ;
wood_N = nChislo "дерев" ;
write_V2
yellow_ADeg
young_ADeg

} ;

