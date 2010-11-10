--# -path=.:prelude
-- (c) 2010 Markos KG
-- Licensed under LGPL

concrete LexiconAmh of Lexicon = CatAmh ** open 

  ParadigmsAmh, ResAmh, Prelude in { 

 --
 flags 
    optimize=values ;
    coding = utf8;

  lin

  airplane_N = mkN "አውሮፕላን" ;
  answer_V2 = mkV2 (mkV3mls"mls") (mkPrep "" "" True);--answer_V2S = mkV2  (compoundV "جواب" (mkV "دینا")) ;
  apartment_N = mkN "አፓርታማ" ;
  apple_N = mkN "በለስ" ;
  art_N = mkN "ጥበብ" ;
  ask_V2Q = mkV3mls "Tyq";--ask_V2Q = mkV2 (mkV "پوچھنا") ;
  baby_N = mkN "ህጻን" ;
  bad_A = mkA "መጥፎ" ;
  bank_N = mkN "ባንክ" ;
  beautiful_A = mkA "ቆንጆ" ;
  become_VA = mkV2nr"hn";--become_VA = mkV "بننا";
  beer_N = mkN "ቢራ" ;
  beg_V2V =  mkV3mls "lmn";-- beg_V2V =  mkV2V (compoundV "التجا" (mkV "كرنا")) "سے" "كہ" False;
  big_A = mkA "ትልቅ" ;
  bike_N = mkN "ቢስክሌት";
  bird_N = mkN "ወፍ" feminine ;
  black_A =  mkA "ጥቁር" ;
  bless_V = mkV3brk "brk";
  blue_A = mkA "ሰማያዊ" ;
  boat_N = mkN "ጀልባ" feminine ;
  book_N = mkN "መጽሃፍ"  ;
  boot_N = mkN "ቦቲ" ;
  boss_N = mkN "አለቃ" ;
  boy_N = mkN "ልጅ" ;
  bread_N = mkN "ዻቦ" ;
  break_V2 = mkV2 (mkV3gdl"sbr") (mkPrep "" "" True);
  broad_A = mkA "ሰፊ" ;
  brother_N =  mkN "ወንድም";
  brown_A = mkA "ቡኒ" ;
  butter_N = mkN "ቅቤ" ;
  buy_V2 = mkV2 (mkV2bl "gz")(mkPrep "ከ" "" True);--buy_V2 = mkV2 (mkV "خریدنا");
  camera_N = mkN "ካሜራ" ;
  cap_N = mkN "ባርኔጣ" ;
  car_N = mkN "መኪና" ;
  carpet_N = mkN "ምንጣፍ" ;
  cat_N = mkN "ዽመት" feminine ;
  ceiling_N = mkN "ጣራ";
  chair_N = mkN "ወንበር" ;
  cheese_N = mkN "አይብ";
  child_N = mkN "ህጻን"  ;
  church_N = mkN (mkN "ቤተ") (mkN "ክርስትያን" feminine);
  city_N = mkN "ከተማ" feminine ;
  clean_A = mkA "ንጹህ" ;
  clever_A = mkA "ብልህ" ;  
  close_V2 = mkV2 (mkV2bl "zg") (mkPrep "" "" True);--close_V2 =  mkV2 (compoundV "بند" do_V2); 
  coat_N = mkN "ኮት" ;
  cold_A = mkA "ቀዝቃዛ" ;
  come_V = mkV2bl "mT" ;
  computer_N = mkN "ኮምፒውተር" ;
  country_N = mkN "ሃገር" feminine ;
  cousin_N = mkN( mkN "አክስት") (mkN "ልጅ"); --cousin_N = mkCmpdNoun "چچا" (mkN "زاد") ; -- a compund noun made of two nouns
  cow_N = mkN "ላም" feminine ;
  die_V = mkV2nr "mt" ;
  dirty_A = mkA "ቆሻሻ" ;
  -- distance_N3 = mkN3 (mkN (mkN "ያለው") (mkN "ርቀት")) (mkPrep "ከ" "" True) (mkPrep "ወደ" "" True);
  doctor_N = mkN "ሃኪም" ;
  dog_N = mkN "ውሻ" ;
  door_N = mkN "በር" ;
  drink_V2 = mkV2 (mkV2bl "TT") (mkPrep "" "" True);
  -- easy_A2V = mkA "ቀላል";
  eat_V2 = mkV2 (mkV2bl "bl" ) (mkPrep "" "" True);
  empty_A = mkA "ባዶ" ;
  enemy_N = mkN "ጠላት" ;
  factory_N = mkN "ፋብሪካ" ;
  father_N2 = mkN2 (mkN "አባት") (mkPrep "የ" "" True) ;
  fear_VS = mkV2bl "fr";
  find_V2 = mkV2( mkV3asr "'gN" ) (mkPrep "" "" True);
  fish_N = mkN "አሳ" ;
  floor_N = mkN "ወለል" ;
   forget_V2 = mkV2 (mkV2bl"rs") (mkPrep "" "" True);--forget_V2 = mkV2 (mkV "بھولنا")  ;
  fridge_N = mkN "ማቀዝቀዣ" ;
  friend_N = mkN "ጓደኛ";
  fruit_N = mkN "ፍራፍሬ" ;
--  fun_AV = mkAV (regA "فuن") ;
  garden_N = mkN "ማሳ" ;
  girl_N = mkN "ልጃገረድ" feminine ;
  glove_N = mkN "ጉዋንት" ;
  gold_N = mkN "ወርቅ" ;
  good_A = mkA "ጥሩ" ;
  --go_V = mkV "جانا" ;
  green_A = mkA "አረንጉኣዴ" ;
  harbour_N = mkN "ወደብ" ; --harbour_N = mkCmpdNoun "بندر" (mkN "گاہ") ;
  hate_V2 = mkV2 (mkV2bl "Tl") (mkPrep "" "" True);--hate_V2 = mkV2 (compoundV "نفرت" do_V2) ;
  hat_N = mkN "ባርኔጣ" ;
 -- have_V2 = mkV2 (mkV2sT "!l") (mkPrep "" "" True);
   hear_V2 = mkV2 (mkV2bl "sm") (mkPrep "" "" True);--hear_V2 = mkV2 (mkV "سننا") ;
  hill_N = mkN "አቀበት" ;
  --hope_VS = (compoundV "امید" do_V2); -- 
  horse_N = mkN "ፈረስ" ;
  hot_A = mkA "ትኩስ" ;
  house_N = mkN "ቤት" ;
  important_A = mkA "ጠቃሚ" ;
  industry_N = mkN "ኢንዱስትሪ" ;
  iron_N = mkN "ብረት" ;
  king_N = mkN "ንጉስ" ;
  know_V2 = mkV2 (mkV3asr "wq") (mkPrep "" "" True);
  --know_VS = mkV "جاننا";
  lake_N = mkN "ሃይቅ"  ;
  lamp_N = mkN "ኩራዝ" ;
--learn_V2 = mkV2 (mkV3brk "tmr") (mkPrep "" "" True); --learn_V2 = mkV2 (mkV "سیكھنا") ;
 leather_N = mkN "ቆዳ" ;
   leave_V2 = mkV2 (mkV3gdl "lqq") (mkPrep "" "" True); --leave_V2 = mkV2 (mkV "جانا") ;
  like_V2 = mkV2 (mkV3gdl "wdd" ) (mkPrep "" "" True);--like_V2 = mkV2 (compoundV "پسند" do_V2);
  listen_V2 = mkV2 (mkV3brk "dmT") (mkPrep "" "" True);
  live_V = mkV2nr "nr" ; ---- touch
  long_A = mkA "ረጅም" ;
  lose_V2 = mkV2 (mkV2bl "Tf" ) (mkPrep "" "" True);--lose_V2 = mkV2 (compoundV "كھو" do_V2) ;
  love_N = mkN "ፍቅር" ;
  love_V2 = mkV2 (mkV3gdl "wdd") (mkPrep "" "" True);
  man_N = mkN "ሰው" ; -- not correct according to rules should be discussed
  --married_A2 = mkA "شادی كرنا" "سے" ;
  meat_N = mkN "ስጋ" ;
  milk_N = mkN "ወተት" ;
  moon_N = mkN "ጨረቃ" feminine ;
  mother_N = mkN "እናት" feminine;   -- not covered need to be discussed
  mountain_N = mkN "ተራራ" ;
  music_N = mkN "ሙዚቃ" feminine ;
  narrow_A = mkA "ጠባብ" ;
  new_A = mkA "አዲስ" ;
  newspaper_N = mkN "ጋዜጣ" ;
  oil_N = mkN "ዘይት" ;
  old_A = mkA "አሮጌ" ;
  open_V2 = mkV2 (mkV3gdl "kft") (mkPrep "" "" True);--open_V2 = mkV2 (mkV "كھولنا") ;
  paint_V2 = mkV2 (mkV2bl "qb") (mkPrep "" "" True);--paint_V2A = mkV2 (compoundV "رنگ" do_V2) ;
  paper_N = mkN "ወረቀት" ;
  paris_PN = mkPN "ፓሪስ" Fem ;
  peace_N = mkN "ሰላም";
  pen_N = mkN "ብእር" ;
  planet_N = mkN "ፕላኔት" ;
  plastic_N = mkN "ፕላስቲክ" ;
  play_V2 = mkV2 (mkV4dbdb "Cwt") (mkPrep "" "" True);  ----
  policeman_N = mkN "ፖሊስ" ; 
  priest_N = (mkN "ቄስ") ;
--  probable_AS = mkAS (regA "پرoبابلع") ;
  queen_N = mkN "ንግስት" feminine ;
  radio_N = mkN "ራዲዮ" ;
  --rain_V0 = compoundV "بارش" (mkV "ہونا" ) ;
  --read_V2 = mkV2 (mkV "پڑھنا");
  red_A = mkA "ቀይ" ;
  religion_N = mkN "እምነት" ;
  restaurant_N = mkN (mkN "ምግብ") (mkN "ቤት");
  river_N = mkN "ወንዝ";
  rock_N = mkN "አለት" ;
  roof_N = mkN "ጣርያ";
  rubber_N = mkN "ጎማ" ;
  run_V = mkV2nr "rT" ; 
  say_VS = mkV2sT "'l";--say_VS = mkV "كہنا" ;
  school_N = mkN (mkN "ትምህርት") (mkN "ቤት") ; -- will 
  science_N = mkN "ሳይንስ" ;
  sea_N = mkN "ባህር" ;
  --seek_V2 = mkV2 () ;
  see_V2 = mkV2 (mkV2sT "äy")(mkPrep "" "" True);
  sell_V3 = mkV3 (mkV2sT "xT" ) (mkPrep "ለ" "" True)  (mkPrep "" "" True);
  send_V3 = mkV3 (mkV2yz "lk" ) (mkPrep "ለ" "" True)  (mkPrep "" "" True);--send_V3 = mkV2yz "lk";
  sheep_N = mkN "በግ";
  ship_N = mkN "መርከብ" feminine ;
  shirt_N = mkN "ሸሚዝ";
  shoe_N = mkN "ጫማ" ;
  shop_N = mkN "ሱቅ";
  short_A = mkA "አጭር" ;
  silver_N = mkN "ብር" ;
  sister_N = mkN "እህት";
  sleep_V = mkV2bl "tN" ;
  small_A = mkA "ትንሽ" ;
  snake_N = mkN "እባብ" ;
  sock_N = mkN "ካልሲ"  ;
  speak_V2 = mkV2 ( mkV3brk ("ngr"))(mkPrep "" "" True);
  star_N = mkN "ኮከብ" feminine ;
  steel_N = mkN "ብረት" ;
  stone_N = mkN "ድንጋይ" ;
  stove_N = mkN "ምድጃ" ;
  student_N =mkN "ተማሪ" ;
  stupid_A = mkA "ባለጌ" ;
  sun_N = mkN "ጸሃይ" feminine ;
  switch8off_V2 = mkV2 (mkV2bl "Tf" )(mkPrep "" "" True) ;--switch8off_V2 = mkV2 (mkV "چلانا") ; -- ADRAGI
  switch8on_V2 = mkV2 (mkV2bl "br")(mkPrep "" "" True) ;--switch8on_V2 = mkV2 (compoundV "بند" do_V2) ; -- ADRAGI -- abra
  table_N = mkN "ጠረጴዛ";
  talk_V3 = mkV3 (mkV3asr "'wr" ) (mkPrep "ለ" "" True)  (mkPrep "" "" True);
  teacher_N = mkN "አስተማሪ" ;
  --teach_V2 = mkV2 (mkV "پڑھنا") ;
  television_N = mkN "ቴሌቪዥን" ;
  thick_A = mkA "ወፍራም" ;
  thin_A = mkA "ቀጭን" ;
  train_N = mkN "ባቡር" ;
  --travel_V = mkV "gwz" ;
  tree_N = mkN "ዛፍ";
  ugly_A = mkA "ፉንጋ" ;
  understand_V2 = mkV2 (mkV2bl"trd")(mkPrep "" "" True)  ;
  university_N = mkN "ዩንቨርሲቲ" ;
  village_N = mkN "መንደር" feminine ;
   wait_V2 = mkV2 (mkV3mls "Tbq")(mkPrep "" "" True) ;--wait_V2 = mkV2 (compoundV "انتظار" do_V2) ;
 
  walk_V = mkV3tTb "rmd" ;
  warm_A = mkA "ሙቅ" ;
  war_N = mkN "ጦርነት" ;
  watch_V2 = mkV2 (mkV4dbdb ("mlkt"))(mkPrep "" "" True) ; 
  water_N = mkN "ውሃ" feminine ; -- not covered masculine ending with y
  white_A = mkA "ነጭ" ;
  window_N = mkN "መስኮት" ;
  wine_N = mkN "ወይን"  ;
  want_V = mkV3mls"flg";
  
  --win_V2 = mkV2 (mkV "جیتنا") ;
  woman_N = mkN "ሴት" feminine;
  --wonder_VQ = compoundV "حعران" (mkV "ہونا") ;
  wood_N = mkN "እንጨት" ;
  write_V2 = mkV2 (mkV3gdl "ktb")(mkPrep "" "" True) ;--write_V2 = mkV2 (mkV "لكھنا") ;
  yellow_A = mkA "ቢጫ" ;
  young_A = mkA "ወጣት" ;
  do_V2 = mkV2 (mkV2bl "sr")(mkPrep "" "" True)  ;
  now_Adv = ss "አሁን" ;
  --already_Adv = mkAdv "ی" ;
  song_N = mkN "ዘፈን" ;
  add_V3 = mkV3(mkV3mls "Cmr" ) (mkPrep "" "" True) (mkPrep "" "" True);--add_V3 = mkV3 (compoundV "اضافہ" do_V2) "" "" ;
  number_N = mkN "ቁጥር" ;
  --put_V2 = mkV2 (mkV "ڈالنا") ;
  stop_V = mkV2nr "qm"  ; -- some times  A - qm  ( later)
  jump_V = mkV3gdl "zll" ;
  left_Ord = mkA"ግራ" ;
  right_Ord =mkA"ቀኝ" ;
  far_Adv = ss "ሩቅ" ;
  correct_A = mkA "ትክክል" ;
  dry_A = mkA "ደረቅ" ;
  dull_A = mkA "ዱልዱም" ;
  full_A = mkA "ሙሉ" ;
  heavy_A = mkA "ከባድ" ;
  near_A = mkA "ቅርብ" ;
  rotten_A = mkA "ግም" ;
  round_A = mkA "ክብ" ;
  sharp_A = mkA "ሹል" ;
  smooth_A = mkA "ለስላሳ" ;
  straight_A = mkA "ቀጥታ" ;
  wet_A = mkA "ርጥብ" ; ----
  wide_A = mkA "ሰፊ" ;
  animal_N = mkN "እንስሳ" ;
  ashes_N = mkN "አመድ" ; 
  back_N = mkN "ጀርባ" ;
  bark_N = mkN "ቅርፊት" ;
  belly_N = mkN "ሆድ" ;
  blood_N = mkN "ደም" ;
  bone_N = mkN "አጥንት" ;
  breast_N = mkN "ጡት" ;
  cloud_N = mkN "ደመና" ;
  day_N = mkN "ቀን" ;
  dust_N = mkN "አቡዋራ" ;
  ear_N = mkN "ጆሮ" ;
  earth_N = mkN "መሬት" feminine ;
  egg_N = mkN "እንቁላል" ;
  eye_N = mkN "አይን"  ;
  fat_N = mkN "ወፍራም" ;
  feather_N = mkN "ላባ" ;
  fingernail_N = mkN "ጥፍር" ;
  fire_N = mkN "እሳት" ;
  flower_N = mkN "አበባ" ;
  fog_N = mkN "ጭጋግ";
  foot_N = mkN "እግር" ; -- not properly covered need to be discussed
  forest_N = mkN "ጫካ" ;
  grass_N = mkN "ሳር"  ;
  guts_N = mkN "" ; 
  hair_N = mkN "ጸጉር" ;
  hand_N = mkN "እጅ" ;
  head_N = mkN "ጭንቅላት" ;
  heart_N = mkN "ልብ" ;
  horn_N = mkN "ቀንድ" ;
  husband_N = mkN "ባል" ;
  ice_N = mkN "በረዶ";
  knee_N = mkN "ጉልበት" ;
  leaf_N = mkN "ቅጠል" ;
  leg_N = mkN "እግር" ;
  liver_N = mkN "ጉበት" ;
  louse_N = mkN "ቅማል" feminine ;
  mouth_N = mkN "አፍ" ;
  name_N = mkN "ስም" ;
  neck_N = mkN "አንገት";
  night_N = mkN "ምሽት";
  nose_N = mkN "አፍንጫ" ;
  person_N = mkN "ሰው" ;
  rain_N = mkN "ዝናብ";
  road_N = mkN "መንገድ" ;
  root_N = mkN "ስር"  ;
  rope_N = mkN "ገመድ" ;
  salt_N = mkN "ጨው"  ;
  sand_N = mkN "አሸዋ"  ;
  seed_N = mkN "ዘር"  ;
  skin_N = mkN "ቆዳ"  ;
  sky_N = mkN "ሰማይ" ;
  smoke_N = mkN "ጭስ"; -- singular masc nouns ending with aN,wN yet to be implemented
  snow_N = mkN "በረዶ";
  stick_N = mkN "በትር" ;
  tail_N = mkN "ጭራ" ;
  tongue_N = mkN "ምላስ";
  tooth_N = mkN "ጥርስ";
  wife_N = mkN "ሚስት" feminine ;
  wind_N = mkN "ነፋስ" ;
  wing_N = mkN "ክንፍ" ;
  worm_N = mkN "ትል" feminine;
  year_N = mkN "አመት" ;
  blow_V = mkV2bl "nf" ;--blow_V3 = mkbela "nf" ;
  breathe_V = mkV4dbdb "tnfs";--breathe_V = compoundV "سانس" (mkV "لینا" ) ;
  burn_V = mkV3brk "qTl" ;
  dig_V = mkV3qTr "qfr" ;
  fall_V = mkV3gdl "wdq" ;
  float_V = mkV3gdl "kbr" ; -- test!! WRONG
  flow_V = mkV3gdl"fss" ;
  fly_V = mkV3gdl "brr" ;
  
  freeze_V = mkV4dbdb "qzqz";
  give_V3 = mkV3 (mkV2sT "sT" ) (mkPrep "ለ" "" True)  (mkPrep "" "" True);--give_V3 = mkV3 (mkV "دینا") "كو" "";
  laugh_V = mkV2yz "sq" ;
   -- lie_N = mkN "ሃሰት"  ;
    lie_V = mkV2wN "wx" ;
  play_V = mkV3brk "Cwt" ;
    sew_V = mkV2bl "sf" ;
    sing_V = mkV3mls"zmr" ;
  sit_V = mkV3gdl "qmT" ;
  smell_V = mkV3gdl "xtt" ;
    spit_V = mkV2bl "tf" ;
  stand_V = mkV2nr "qm";--stand_V = compoundV "كھڑے" (mkV "ہونا" );
    --swell_V = mkV "äbT" ;
    swim_V = mkV2wN "wN" ;
  think_V = mkV3asr "'sb" ;
    turn_V = mkV3tTb "tTf";
  --vomit_V = compoundV "التی" (mkV "كرنا") ;
    bite_V2 = mkV2 (mkV3gdl "nks") (mkPrep "" "" True);--bite_V2 = mkV2 (mkV "كاتنا") ;
  count_V2 = mkV2 (mkV3qTr"qTr") (mkPrep "" "" True);
  cut_V2 = mkV2 (mkV3qTr"qrT") (mkPrep "" "" True);
  fear_V2 = mkV2 (mkV2bl "fr") (mkPrep "" "" True);--fear_V2 = mkV2 (mkV "ڈرنا") ;
  fight_V2 = mkV2 (mkV4dbdb "dbdb") (mkPrep "" "" True);--fight_V2 = mkV2 (mkV "لڑنا") ;
  hit_V2 = mkV2 (mkV2sT "gC") (mkPrep "" "" True);--hit_V2 = mkV2 (compoundV "تھوكر" (mkV "مارنا" ));
  hold_V2 = mkV2 (mkV2yz "yz") (mkPrep "" "" True);--hold_V2 = mkV2 (mkV "پكڑنا") ;
  hunt_V2 = mkV2 (mkV3asr  "'dn" )(mkPrep "" "" True);
  kill_V2 =  mkV2 (mkV3gdl "gdl") (mkPrep "" "" True);--kill_V2 =  mkV2 (compoundV "مار" (mkV "ڈالنا" )) ;
  pull_V2 = mkV2 (mkV2yz "sb") (mkPrep "" "" True);--pull_V2 = mkV2 (mkV "كھنچنا");
  push_V2 = mkV2 (mkV2bl "gf") (mkPrep "" "" True);--push_V2 = mkV2 (mkV "دھكیلنا") "كو" ;
  rub_V2 = mkV2 (mkV3gdl "Trg") (mkPrep "" "" True);--rub_V2 = mkV2 (mkV "رگڑنا") ;
  scratch_V2 = mkV2 (mkV2yz "fq") (mkPrep "" "" True);--scratch_V2 = mkV2 (mkV "كھرچنا") "كو" ;
  split_V2 = mkV2 (mkV3gdl "kfl") (mkPrep "" "" True);--split_V2 = mkV2 (mkV "بانتا") "كو" ;
    squeeze_V2 = mkV2 (mkV3gdl "Cmq") (mkPrep "" "" True); 

  stab_V2 = mkV2 (mkV2bl "wg") (mkPrep "" "" True);--stab_V2 = dirV2 (regDuplV "ستاب") ;
  suck_V2 = mkV2 (mkV4dbdb "mgmg") (mkPrep "" "" True);--suck_V2 = mkV2 (mkV "چوسنا") ;
  throw_V2 = mkV2 (mkV4dbdb "wrwr") (mkPrep "" "" True);--throw_V2 = mkV2 (mkV "پھینكنا") ;
  tie_V2 = mkV2 (mkV3asr "'sr")(mkPrep "" "" True);
  wash_V2 = mkV2 (mkV3asr "'Tb")(mkPrep "" "" True);
  wipe_V2 = mkV2 (mkV3gdl "Trg") (mkPrep "" "" True);--wipe_V2 = mkV2 (compoundV "صاف" (mkV "كرنا" ));

  other_A = mkA "ሌላ" ;

  grammar_N = mkN "ስዋሰው" ;
  language_N = mkN "ቋንቋ"  ;
  rule_N = mkN "ህግ" ;

---- added 4/6/2007
    john_PN = mkPN "ዮሃንስ" Masc ;
    question_N = mkN "ጥያቄ" ;
    ready_A = mkA "ዝግጁ" ;
    reason_N = mkN "ምክንያት" ;
    today_Adv = ss "ዛሬ" ;
    --uncertain_A = mkA "ያልተረጋገጠ";

   
    
} 
