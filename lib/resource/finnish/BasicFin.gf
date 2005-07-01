--# -path=.:../abstract:../../prelude
--# -val

concrete BasicFin of Basic = CategoriesFin ** open ParadigmsFin in {

flags 
  startcat=Phr ; lexer=textlit ; unlexer=text ;
  optimize=values ;

lin

  airplane_N = regN "lentokone" ;
  answer_V2S = mkV2S (caseV2 (regV "vastata") allative) ;
  apartment_N = regN "asunto" ;
  apple_N = regN "omena" ; --- omenia, not omenoita
  art_N = regN "taide" ;
  ask_V2Q = mkV2Q (caseV2 (regV "kysy‰") ablative) ;
  baby_N = regN "vauva" ;
  bad_ADeg = mkADeg (regN "paha") "pahempi" "pahin" ;
  bank_N = regN "pankki" ;
  beautiful_ADeg = mkADeg (regN "kaunis") "kauniimpi" "kaunein" ;
  become_VA = mkVA (regV "tulla") translative ;
  beer_N = regN "olut" ;
  beg_V2V = mkV2V (caseV2 (reg2V "pyyt‰‰" "pyysi") partitive) ;
  big_ADeg = mkADeg (reg2N "suuri" "suuria") "suurempi" "suurin" ;
  bike_N = nLukko "polkupyˆr‰" ; --- for correct vowel harmony
  bird_N = regN "lintu" ;
  black_ADeg = mkADeg (regN "musta") "mustempi" "mustin" ;
  blue_ADeg = mkADeg (regN "sininen") "sinisempi" "sinisin" ;
  boat_N = regN "vene" ;
  book_N = regN "kirja" ;
  boot_N = regN "saapas" ;
  boss_N = regN "pomo" ;
  boy_N = reg3N "poika" "pojan" "poikia" ;
  bread_N = regN "leip‰" ;
  break_V2 = dirV2 (regV "rikkoa") ;
  broad_ADeg = mkADeg (regN "leve‰") "leve‰mpi" "levein" ;
  brother_N2 = genN2 (reg3N "veli" "veljen" "velji‰") ; ---- errors in Pl
  brown_ADeg = mkADeg (regN "ruskea") "ruskeampi" "ruskein" ;
  butter_N = reg3N "voi" "voin" "voita" ;  ---- errors in Part
  buy_V2 = dirV2 (regV "ostaa") ;
  camera_N = regN "kamera" ;
  cap_N = regN "lakki" ;
  car_N = reg3N "auto" "auton" "autoja" ; -- regN: audon
  carpet_N = regN "matto" ;
  cat_N = regN "kissa" ;
  ceiling_N = regN "katto" ;
  chair_N = regN "tuoli" ;
  cheese_N = regN "juusto" ;
  child_N = mkN "lapsi" "lapsen" "lapsena" "lasta" "lapseen" 
            "lapsina" "lapsissa" "lasten" "lapsia" "lapsiin" human ;
  church_N = regN "kirkko" ;
  city_N = regN "kaupunki" ;
  clean_ADeg = regADeg "puhdas" ;
  clever_ADeg = regADeg "viisas" ;
  close_V2 = dirV2 (regV "sulkea") ;
  coat_N = regN "takki" ;
  cold_ADeg = mkADeg (regN "kylm‰") "kylmempi" "kylmin" ;
  come_V = regV "tulla" ;
  computer_N = regN "tietokone" ;
  country_N = regN "maa" ;
  cousin_N = regN "serkku" ;
  cow_N = regN "lehm‰" ;
  die_V = regV "kuolla" ;
  dirty_ADeg = mkADeg (regN "likainen") "likaisempi" "likaisin" ;
  distance_N3 = mkN3 (regN "et‰isyys") elative illative ;
  doctor_N = reg2N "tohtori" "tohtoreita" ;
  dog_N = regN "koira" ;
  door_N = reg2N "ovi" "ovia" ;
  drink_V2 = dirV2 (regV "juoda") ;
  easy_A2V = mkA2V (mkA2 (mkA (regN "helppo")) allative) ;
  eat_V2 = dirV2 (regV "syˆd‰") ;
  empty_ADeg = mkADeg (regN "tyhj‰") "tyhjempi" "tyhjin" ;
  enemy_N = regN "vihollinen" ;
  factory_N = regN "tehdas" ;
  father_N2 = genN2 (regN "is‰") ;
  fear_VS = mkVS (reg2V "pel‰t‰" "pelk‰si") ;
  find_V2 = dirV2 (reg2V "lˆyt‰‰" "lˆysi") ;
  fish_N = regN "kala" ;
  floor_N = reg2N "lattia" "lattioita" ;
  forget_V2 = dirV2 (regV "unohtaa") ;
  fridge_N = regN "j‰‰kaappi" ;
  friend_N = regN "yst‰v‰" ;
  fruit_N = regN "hedelm‰" ;
  fun_AV = mkAV (mkA (regN "hauska")) ;
  garden_N = regN "puutarha" ;
  girl_N = regN "tyttˆ" ;
  glove_N = regN "k‰sine" ;
  gold_N = regN "kulta" ;
  good_ADeg = mkADeg (regN "hyv‰") "parempi" "parhain" ; --- paras
  go_V = regV "menn‰" ;
  green_ADeg = mkADeg (regN "vihre‰") "vihre‰mpi" "vihrein" ;
  harbour_N = reg3N "satama" "sataman" "satamia" ;
  hate_V2 = dirV2 (regV "vihata") ;
  hat_N = regN "hattu" ;
  have_V2 = dirV2 (caseV adessive vOlla) ;
  hear_V2 = dirV2 (regV "kuulla") ;
  hill_N = regN "kukkula" ;
  hope_VS = mkVS (regV "toivoa") ;
  horse_N = regN "hevonen" ;
  hot_ADeg = mkADeg (regN "kuuma") "kuumempi" "kuumin" ;
  house_N = regN "talo" ;
  important_ADeg = mkADeg (regN "t‰rke‰") "t‰rke‰mpi" "t‰rkein" ;
  industry_N = regN "teollisuus" ;
  iron_N = regN "rauta" ;
  king_N = regN "kuningas" ;
  know_V2 = dirV2 (reg2V "tiet‰‰" "tiesi") ; --- tuntea; gives tiet‰nyt
  lake_N = reg2N "j‰rvi" "j‰rvi‰" ;
  lamp_N = regN "lamppu" ;
  learn_V2 = 
    dirV2 (mkV "oppia" "oppii" "opin" "oppivat" "oppikaa" "opitaan"
      "oppi" "opin" "oppisi" "oppinut" "opittu" "opitun") ;
  leather_N = regN "nahka" ; --- nahan
  leave_V2 = dirV2 (regV "j‰tt‰‰") ;
  like_V2 = caseV2 (regV "pit‰‰") elative ;
  listen_V2 = caseV2 (reg3V "kuunnella" "kuuntelen" "kuunteli") partitive ;
  live_V = regV "el‰‰" ;
  long_ADeg = mkADeg (regN "pitk‰") "pitempi" "pisin" ;
  lose_V2 = dirV2 (regV "h‰vit‰") ; --- hukata
  love_N = reg3N "rakkaus" "rakkauden" "rakkauksia" ;
  love_V2 = caseV2 (regV "rakastaa") partitive ;
  man_N = mkN "mies" "miehen" "miehen‰" "miest‰" "mieheen" 
            "miehin‰" "miehiss‰" "miesten" "miehi‰" "miehiin" human ;
----  married_A2 = mkA2 (regA "married") "to" ;
  meat_N = regN "liha" ;
  milk_N = regN "maito" ;
  moon_N = regN "kuu" ;
  mother_N2 = genN2 (regN "‰iti") ;
  mountain_N = reg2N "vuori" "vuoria" ;
  music_N = regN "musiikki" ;
  narrow_ADeg = mkADeg (regN "kapea") "kapeampi" "kapein" ;
  new_ADeg = mkADeg (reg3N "uusi" "uuden" "uusia") "uudempi" "uusin" ;
  newspaper_N = nSylki "sanomalehti" ; --- for correct vowel harmony
  oil_N = regN "ˆljy" ;
  old_ADeg = mkADeg (regN "vanha") "vanhempi" "vanhin" ;
  open_V2 = dirV2 (regV "avata") ;
  paint_V2A = mkV2A (dirV2 (regV "maalata")) translative ;
  paper_N = reg2N "paperi" "papereita" ;
  peace_N = regN "rauha" ;
  pen_N = regN "kyn‰" ;
  planet_N = regN "planeetta" ;
  plastic_N = regN "muovi" ;
  play_V2 = dirV2 (regV "pelata") ; --- leikki‰, soittaa
  policeman_N = regN "poliisi" ;
  priest_N = regN "pappi" ;
  probable_AS = mkAS (mkA (nNainen "todenn‰kˆist‰")) ; --- for vowel harmony
  queen_N = regN "kuningatar" ;
  radio_N = reg2N "radio" "radioita" ;
  rain_V0 = mkV0 (reg2V "sataa" "satoi") ;
  read_V2 = dirV2 (regV "lukea") ;
  red_ADeg = regADeg "punainen" ;
  religion_N = regN "uskonto" ;
  restaurant_N = regN "ravintola" ;
  river_N = nArpi "joki" ;
  rock_N = reg2N "kallio" "kallioita" ;
  roof_N = regN "katto" ;
  rubber_N = regN "kumi" ;
  run_V = reg2V "juosta" "juoksi" ;
  say_VS = mkVS (regV "sanoa") ;
  school_N = regN "koulu" ;
  science_N = regN "tiede" ;
  sea_N = nMeri "meri" ;
  seek_V2 = dirV2 (regV "etsi‰") ;
  see_V2 = dirV2 (
    mkV "n‰hd‰" "n‰kee" "n‰en" "n‰kev‰t" "n‰hk‰‰" "n‰hd‰‰n"
      "n‰ki" "n‰in" "n‰kisi" "n‰hnyt" "n‰hty" "n‰hdyn") ; 
  sell_V3 = dirV3 (regV "myyd‰") allative ;
  send_V3 = dirV3 (regV "l‰hett‰‰") allative ;
  sheep_N = regN "lammas" ;
  ship_N = regN "laiva" ;
  shirt_N = regN "paita" ;
  shoe_N = regN "kenk‰" ;
  shop_N = regN "kauppa" ;
  short_ADeg = regADeg "lyhyt" ;
  silver_N = regN "hopea" ;
  sister_N = regN "sisko" ;
  sleep_V = regV "nukkua" ;
  small_ADeg = mkADeg (reg3N "pieni" "pienen" "pieni‰") "pienempi" "pienin" ;
  snake_N = regN "k‰‰rme" ;
  sock_N = regN "sukka" ;
  speak_V2 = dirV2 (regV "puhua") ;
  star_N = reg2N "t‰hti" "t‰hti‰" ;
  steel_N = regN "ter‰s" ;
  stone_N = reg2N "kivi" "kivi‰" ;
  stove_N = reg3N "liesi" "lieden" "liesi‰" ;
  student_N = reg2N "opiskelija" "opiskelijoita" ;
  stupid_ADeg = regADeg "tyhm‰" ;
  sun_N = regN "aurinko" ;
  switch8off_V2 = dirV2 (regV "sammuttaa") ; ---
  switch8on_V2 = dirV2 (regV "sytytt‰‰") ; ---
  table_N = regN "pˆyt‰" ;
  talk_V3 = mkV3 (regV "puhua") (caseP allative) (caseP elative) ;
  teacher_N = regN "opettaja" ;
  teach_V2 = dirV2 (regV "opettaa") ;
  television_N = reg2N "televisio" "telievisioita" ;
  thick_ADeg = regADeg "paksu" ;
  thin_ADeg = regADeg "ohut" ;
  train_N = regN "juna" ;
  travel_V = regV "matkustaa" ;
  tree_N = regN "puu" ;
 ---- trousers_N = regN "trousers" ;
  ugly_ADeg = mkADeg (regN "ruma") "rumempi" "rumin" ;
  understand_V2 = dirV2 (reg3V "ymm‰rt‰‰" "ymm‰rr‰n" "ymm‰rsi") ;
  university_N = regN "yliopisto" ;
  village_N = regN "kyl‰" ;
  wait_V2 = caseV2 (regV "odottaa") partitive ;
  walk_V = regV "k‰vell‰" ;
  warm_ADeg = mkADeg 
    (mkN "l‰mmin" "l‰mpim‰n" "l‰mpim‰n‰" "l‰mmint‰" "l‰mpim‰‰n" 
         "l‰mpimin‰" "l‰mpimiss‰" "l‰mpimien" "l‰mpimi‰" "l‰mpimiin"
	 nonhuman) 
    "l‰mpim‰mpi" "l‰mpimin" ;
  war_N = regN "sota" ;
  watch_V2 = dirV2 (regV "katsella") ;
  water_N = reg3N "vesi" "veden" "vesi‰" ;
  white_ADeg = regADeg "valkoinen" ;
  window_N = reg2N "ikkuna" "ikkunoita" ;
  wine_N = regN "viini" ;
  win_V2 = dirV2 (regV "voittaa") ;
  woman_N = regN "nainen" ;
  wonder_VQ = mkVQ (regV "ihmetell‰") ;
  wood_N = regN "puu" ;
  write_V2 = dirV2 (regV "kirjoittaa") ;
  yellow_ADeg = regADeg "keltainen" ;
  young_ADeg = mkADeg (reg2N "nuori" "nuoria") "nuorempi" "nuorin" ;

  do_V2 = dirV2 (
    mkV "tehd‰" "tekee" "teen" "tekev‰t" "tehk‰‰" "tehd‰‰n"
      "teki" "tein" "tekisi" "tehnyt" "tehty" "tehdyn") ; 

  now_Adv = mkAdv "nyt" ;
  already_Adv = mkAdv "jo" ;
  song_N = regN "laulu" ;
  add_V3 = dirV3 (regV "lis‰t‰") illative ;
  number_N = reg2N "numero" "numeroita" ;
  put_V2 = dirV2 (regV "panna") ;
  stop_V = regV "pys‰hty‰" ;
  jump_V = regV "hyp‰t‰" ;
  here_Adv = mkAdv "t‰‰ll‰" ;
  here7to_Adv = mkAdv "t‰nne" ;
  here7from_Adv = mkAdv "t‰‰lt‰" ;
  there_Adv = mkAdv "siell‰" ; --- tuolla
  there7to_Adv = mkAdv "sinne" ;
  there7from_Adv = mkAdv "sielt‰" ;

} ;
