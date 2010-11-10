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
  airplane_N = mkN "!wr/pl!n" ;
  answer_V2S = mkV3mls"???";--answer_V2S = mkV2  (compoundV "????" (mkV "????")) ;
  apartment_N = mkN "!p!rt!m!" ;
  apple_N = mkN "b'l'?" ;
  art_N = mkN "Tb'b" ;
  ask_V2Q = mkV3mls "???";--ask_V2Q = mkV2 (mkV "??????") ;
  baby_N = mkN "hS!n" ;
  bad_A = mkA "m'Tf/" ;
  bank_N = mkN "b!nk" ;
  beautiful_A = mkA "q/nj/" ;
  become_VA = mkV2nr"??";--become_VA = mkV "????";
  beer_N = mkN "b#r!" ;
  beg_V2V =  mkV3mls "???";-- beg_V2V =  mkV2V (compoundV "?????" (mkV "????")) "??" "??" False;
  big_A = mkA "tlq" ;
  bike_N = mkN "b#?kl%t";
  bird_N = mkN "w'f" feminine ;
  black_A =  mkA "Tq&r" ;
  bless_V = mkV3brk "???";
  blue_A = mkA "?m!y!w#" ;
  boat_N = mkN "j'lb!" feminine ;
  book_N = mkN "m'Sh!f"  ;
  boot_N = mkN "b/t#" ;
  boss_N = mkN "!l'q!" ;
  boy_N = mkN "lj" ;
  bread_N = mkN "?b/" ;
  break_V2 = mkV3gdl"???";
  broad_A = mkA "?f#" ;
  brother_N =  mkN "w'ndm";
  brown_A = mkA "b&n#" ;
  butter_N = mkN "qb%" ;
  buy_V2 = mkV2bl "??";--buy_V2 = mkV2 (mkV "??????");
  camera_N = mkN "k!m%r!" ;
  cap_N = mkN "b!rn%T!" ;
  car_N = mkN "m'k#n!" ;
  carpet_N = mkN "mnT!f" ;
  cat_N = mkN "?m't" feminine ;
  ceiling_N = mkN "T!r!";
  chair_N = mkN "w'nb'r" ;
  cheese_N = mkN "!yb";
  child_N = mkN "hS!n"  ;
  church_N = mkN (mkN "b%t'") (mkN "kr?ty!n" feminine);
  city_N = mkN "k't'm!" feminine ;
  clean_A = mkA "nS&h" ;
  clever_A = mkA "blh" ;  
  close_V2 =  mkV2bl "??";--close_V2 =  mkV2 (compoundV "???" do_V2); 
  coat_N = mkN "k/t" ;
  cold_A = mkA "q'zq!z!" ;
  come_V = mkV2bl "??" ;
  computer_N = mkN "k/mp#wt'r" ;
  country_N = mkN "h!g'r" feminine ;
 -- cousin_N = mkN "y'!k?t" (mkN "lj"); --cousin_N = mkCmpdNoun "???" (mkN "???") ; -- a compund noun made of two nouns
  cow_N = mkN "l!m" feminine ;
  die_V = mkV2nr "??" ;
  dirty_A = mkA "q/x!x!" ;
  distance_N3 = mkN3 (mkN (mkN "y!l'w") (mkN "rq't")) (mkPrep "k'" "" True) (mkPrep "w'd'" "" True);
  doctor_N = mkN "h!k#m" ;
  dog_N = mkN "wx!" ;
  door_N = mkN "b'r" ;
  drink_V2 = mkV2bl "??";
  --easy_A2V = mkA2V "q'l!l";
  eat_V2 = mkV2bl "??";
  empty_A = mkA "b!d/" ;
  enemy_N = mkN "T'l!t" ;
  factory_N = mkN "f!br#k!" ;
  father_N2 = mkN2 (mkN "!b!t") (mkPrep "y'" "" True) ;
  fear_VS = mkV2bl "??";
  --find_V2 = mkV2 (mkV "????") ;
  fish_N = mkN "!?" ;
  floor_N = mkN "w'l'l" ;
  forget_V2 = mkV2bl"??";--forget_V2 = mkV2 (mkV "??????")  ;
  fridge_N = mkN "m!q'zq'Z!" ;
  friend_N = mkN "g7d'N!";
  fruit_N = mkN "fr!fr%" ;
--  fun_AV = mkAV (regA "???") ;
  garden_N = mkN "m!?" ;
  girl_N = mkN "lj#t" feminine ;
  glove_N = mkN "g&w!nt" ;
  gold_N = mkN "w'rq" ;
  good_A = mkA "Tr&" ;
  --go_V = mkV "????" ;
  green_A = mkA "!r'ng&Ad%" ;
  harbour_N = mkN "w'd'b" ; --harbour_N = mkCmpdNoun "????" (mkN "???") ;
  hate_V2 = mkV2bl "??";--hate_V2 = mkV2 (compoundV "????" do_V2) ;
  hat_N = mkN "b!rn%T!" ;
--  have_V2 = dirV2 (mk5V "????" "???" "???" "???" "??????") ;
  hear_V2 = mkV2bl "??";--hear_V2 = mkV2 (mkV "????") ;
  hill_N = mkN "!q'b't" ;
  --hope_VS = (compoundV "????" do_V2); -- 
  horse_N = mkN "f'r'?" ;
  hot_A = mkA "tk&?" ;
  house_N = mkN "b%t" ;
  important_A = mkA "T'q!m#" ;
  industry_N = mkN "#nd&?tr#" ;
  iron_N = mkN "br't" ;
  king_N = mkN "ng&?" ;
  --know_V2 = mkV2 (mkV "?????") ;
  --know_VS = mkV "?????";
  lake_N = mkN "h!yq"  ;
  lamp_N = mkN "k&r!z" ;
  --learn_V2 = mkV3brk "???"; --learn_V2 = mkV2 (mkV "??????") ;
  leather_N = mkN "q/d!" ;
  leave_V2 = mkV3gdl "???";--leave_V2 = mkV2 (mkV "????") ;
  like_V2 = mkV3gdl "???";--like_V2 = mkV2 (compoundV "????" do_V2);
  --listen_V2 = mkV2 (mkV "????") ;
  live_V = mkV2nr "??" ; ---- touch
  long_A = mkA "r'jm" ;
  lose_V2 = mkV2bl "??";--lose_V2 = mkV2 (compoundV "???" do_V2) ;
  love_N = mkN "fqr" ;
  --love_V2 = mkV2 (compoundV "????" do_V2) "??";
  man_N = mkN "?w" ; -- not correct according to rules should be discussed
  --married_A2 = mkA "?????????" "??" ;
  meat_N = mkN "?g!" ;
  milk_N = mkN "w't't" ;
  moon_N = mkN "C'r'q!" feminine ;
  mother_N = mkN "(n!t" feminine;   -- not covered need to be discussed
  mountain_N = mkN "t'r!r!" ;
  music_N = mkN "m&z#q!" feminine ;
  narrow_A = mkA "T'b!b" ;
  new_A = mkA "!d#?" ;
  newspaper_N = mkN "g!z%T!" ;
  oil_N = mkN "z'yt" ;
  old_A = mkA "!r/g%" ;
  open_V2 = mkV3gdl "???";--open_V2 = mkV2 (mkV "??????") ;
  paint_V2A = mkV2bl "??";--paint_V2A = mkV2 (compoundV "???" do_V2) ;
  paper_N = mkN "w'r'q't" ;
  paris_PN = mkPN "p!r#?" Fem ;
  peace_N = mkN "?l!m";
  pen_N = mkN "b(r" ;
  planet_N = mkN "pl!n%t" ;
  plastic_N = mkN "pl!?t#k" ;
  --play_V2 = mkV2 (mkV "??????") ;
  policeman_N = mkN "p/l#?" ; 
  priest_N = (mkN "q%?") ;
--  probable_AS = mkAS (regA "????????") ;
  queen_N = mkN "ng?t" feminine ;
  radio_N = mkN "r!d#y/" ;
  --rain_V0 = compoundV "????" (mkV "????" ) ;
  --read_V2 = mkV2 (mkV "?????");
  red_A = mkA "q'y" ;
  religion_N = mkN "(mn't" ;
  restaurant_N = mkN (mkN "mgb") (mkN "b%t");
  river_N = mkN "w'nz";
  rock_N = mkN "!l't" ;
  roof_N = mkN "T!ry!";
  rubber_N = mkN "g/m!" ;
  run_V = mkV2nr "??" ; 
  --say_V = mkV "";--say_VS = mkV "????" ;
  school_N = mkN (mkN "tmhrt") (mkN "b%t") ; -- will 
  science_N = mkN "?yn?" ;
  sea_N = mkN "b!hr" ;
  --seek_V2 = mkV2 (compoundV "????" do_V2) ;
  --see_V2 = mkV2 (mkV "??????") ;
  --sell_V3 = mkV3 (mkV "?????") "??" "";
  send_V3 = mkV2yz "??";--send_V3 = mkV2yz "??";
  sheep_N = mkN "b'g";
  ship_N = mkN "m'rk'b" feminine ;
  shirt_N = mkN "x'm#z";
  shoe_N = mkN "C!m!" ;
  shop_N = mkN "?q";
  short_A = mkA "!Cr" ;
  silver_N = mkN "br" ;
  sister_N = mkN "(ht";
  sleep_V = mkV2bl "??" ;
  small_A = mkA "tnx" ;
  snake_N = mkN "(b!b" ;
  sock_N = mkN "k!l?"  ;
  --speak_V2 = mkV2 (mkV "?????");
  star_N = mkN "k/k'b" feminine ;
  steel_N = mkN "br't" ;
  stone_N = mkN "dng!y" ;
  stove_N = mkN "mdj!" ;
  student_N =mkN "t'm!r#" ;
  stupid_A = mkA "b!l'g%" ;
  sun_N = mkN "S'h!y" feminine ;
  switch8off_V2 = mkV2bl "??" ;--switch8off_V2 = mkV2 (mkV "?????") ; -- ADRAGI
  switch8on_V2 = mkV2bl "??";--switch8on_V2 = mkV2 (compoundV "???" do_V2) ; -- ADRAGI -- abra
  table_N = mkN "T'r'P%z!";
  --talk_V3 = mkV3 (mkV "?????") "??" "???????????";
  teacher_N = mkN "!?t'm!r#" ;
  --teach_V2 = mkV2 (mkV "?????") ;
  television_N = mkN "t%l%v#Zn" ;
  thick_A = mkA "w'fr!m" ;
  thin_A = mkA "q'Cn" ;
  train_N = mkN "b!b&r" ;
  --travel_V = mkV "????" ;
  tree_N = mkN "z!f";
  ugly_A = mkA "f&ng!" ;
  --understand_V2 = mkV2 (mkV "??????") ;
  university_N = mkN "y&nv'r?t#" ;
  village_N = mkN "m'nd'r" feminine ;
  wait_V2 = mkV3mls "???"; --wait_V2 = mkV2 (compoundV "??????" do_V2) ;
 
  --walk_V = mkV "????" ;
  warm_A = mkA "m&q" ;
  war_N = mkN "T/rn't" ;
  --watch_V2 = mkV2 (mkV "??????") ;
  water_N = mkN "wh!" feminine ; -- not covered masculine ending with y
  white_A = mkA "n'C" ;
  window_N = mkN "m'?k/t" ;
  wine_N = mkN "w'yn"  ;
  want_V = mkV3mls"???";
  
  --win_V2 = mkV2 (mkV "?????") ;
  woman_N = mkN "?t" feminine;
  --wonder_VQ = compoundV "?????" (mkV "????") ;
  wood_N = mkN "(nC't" ;
  write_V2 = mkV3gdl "???";--write_V2 = mkV2 (mkV "?????") ;
  yellow_A = mkA "b#C!" ;
  young_A = mkA "w'T!t" ;
  --do_V2 = mkV2 (mkV "????")  ;
  now_Adv = mkAdv "!h&n" ;
  --already_Adv = mkAdv "?" ;
  song_N = mkN "z'f'n" ;
  add_V3 = mkV3mls "???";--add_V3 = mkV3 (compoundV "?????" do_V2) "" "" ;
  number_N = mkN "q&Tr" ;
  --put_V2 = mkV2 (mkV "?????") ;
  stop_V = mkV2nr "??"  ; -- some times  A - qm  ( later)
  jump_V = mkV3gdl "???" ;
  --left_Ord = {s = "gr!" ; n = singular};
  --right_Ord = {s= "q'N" ; n = singular};
  far_Adv = mkAdv "r&q" ;
  correct_A = mkA "tkkl" ;
  dry_A = mkA "d'r'q" ;
  dull_A = mkA "d&ld&m" ;
  full_A = mkA "m&l&" ;
  heavy_A = mkA "k'b!d" ;
  near_A = mkA "qrb" ;
  rotten_A = mkA "gm" ;
  round_A = mkA "kb" ;
  sharp_A = mkA "x&l" ;
  smooth_A = mkA "l'?l!?" ;
  straight_A = mkA "q'Tt!" ;
  wet_A = mkA "rTb" ; ----
  wide_A = mkA "?f#" ;
  animal_N = mkN "(n??" ;
  ashes_N = mkN "!m'd" ; 
  back_N = mkN "j'rb!" ;
  bark_N = mkN "qrf#" ;
  belly_N = mkN "h/d" ;
  blood_N = mkN "d'm" ;
  bone_N = mkN "!Tnt" ;
  breast_N = mkN "T&t" ;
  cloud_N = mkN "d'm'n!" ;
  day_N = mkN "q'n" ;
  dust_N = mkN "!b&w!r!" ;
  ear_N = mkN "j/r/" ;
  earth_N = mkN "m'r%t" feminine ;
  egg_N = mkN "(nq&l!l" ;
  eye_N = mkN "!yn"  ;
  fat_N = mkN "w'fr!m" ;
  feather_N = mkN "l!b!" ;
  fingernail_N = mkN "Tfr" ;
  fire_N = mkN "(?t" ;
  flower_N = mkN "!b'b!" ;
  fog_N = mkN "Cg!g";
  foot_N = mkN "(gr" ; -- not properly covered need to be discussed
  forest_N = mkN "C!k!" ;
  grass_N = mkN "?r"  ;
  guts_N = mkN "" ; 
  hair_N = mkN "S'g&r" ;
  hand_N = mkN "(j" ;
  head_N = mkN "Cnql!t" ;
  heart_N = mkN "lb" ;
  horn_N = mkN "q'nd" ;
  husband_N = mkN "b!l" ;
  ice_N = mkN "b'r'd/";
  knee_N = mkN "g&lb't" ;
  leaf_N = mkN "qT'l" ;
  leg_N = mkN "(gr" ;
  liver_N = mkN "g&b't" ;
  louse_N = mkN "qm!l" feminine ;
  mouth_N = mkN "!f" ;
  name_N = mkN "?m" ;
  neck_N = mkN "!ng't";
  night_N = mkN "mxt";
  nose_N = mkN "!fnC!" ;
  person_N = mkN "?w" ;
  rain_N = mkN "zn!b";
  road_N = mkN "m'ng'd" ;
  root_N = mkN "?r"  ;
  rope_N = mkN "g'm'd" ;
  salt_N = mkN "C'w"  ;
  sand_N = mkN "!x'w!"  ;
  seed_N = mkN "z'r"  ;
  skin_N = mkN "q/d!"  ;
  sky_N = mkN "?m!y" ;
  smoke_N = mkN "C?"; -- singular masc nouns ending with aN,wN yet to be implemented
  snow_N = mkN "b'r'd/";
  stick_N = mkN "b'tr" ;
  tail_N = mkN "Cr!" ;
  tongue_N = mkN "ml!?";
  tooth_N = mkN "Tr?";
  wife_N = mkN "m#?t" feminine ;
  wind_N = mkN "n'f!?" ;
  wing_N = mkN "knf" ;
  worm_N = mkN "tl" feminine;
  year_N = mkN "!m't" ;
  blow_V = mkV2bl "??" ;--blow_V3 = mkbela "??" ;
  breathe_V = mkV4dbdb "????";--breathe_V = compoundV "????" (mkV "????" ) ;
  --burn_V = mkV "????" ;
 -- dig_V = mkV "???" ;
  fall_V = mkV3gdl "???" ;
  float_V = mkV3gdl "???" ; -- test!! WRONG
  flow_V = mkV3gdl"???" ;
  fly_V = mkV3gdl "???" ;
  
  freeze_V = mkV4dbdb "????";
  give_V3 = mkV2sT "??";--give_V3 = mkV3 (mkV "????") "??" "";
  laugh_V = mkV2yz "??" ;
--  lie_N = mkN "????" masculine ;
    lie_V = mkV2wN "??" ;
  --play_V = mkV "??????" ;
    sew_V = mkV2bl "??" ;
    sing_V = mkV3mls"???" ;
  --sit_V = mkV "??????" ;
  --smell_V = mkV "??????" ;
    spit_V = mkV2bl "??" ;
  stand_V = mkV2nr "??";--stand_V = compoundV "????" (mkV "????" );
    --swell_V = mkV "???" ;
    swim_V = mkV2wN "??" ;
  --think_V = mkV2sT "??" ;
    turn_V = mkV3tTb "???";
  --vomit_V = compoundV "????" (mkV "????") ;
    bite_V2 = mkV3gdl "???";--bite_V2 = mkV2 (mkV "?????") ;
  count_V2 = mkV3qTr"???";
  cut_V2 = mkV3qTr"???";
  fear_V2 = mkV2bl "??";--fear_V2 = mkV2 (mkV "????") ;
  fight_V2 = mkV4dbdb "????";--fight_V2 = mkV2 (mkV "????") ;
  hit_V2 = mkV2bl "??";--hit_V2 = mkV2 (compoundV "?????" (mkV "?????" ));
  hold_V2 = mkV2yz "??";--hold_V2 = mkV2 (mkV "?????") ;
  --hunt_V2 = mkV2 (compoundV "????" do_V2);
  kill_V2 =  mkV3gdl "???";--kill_V2 =  mkV2 (compoundV "???" (mkV "?????" )) ;
  pull_V2 = mkV2yz "??";--pull_V2 = mkV2 (mkV "??????");
  push_V2 = mkV2bl "??";--push_V2 = mkV2 (mkV "???????") "??" ;
  rub_V2 = mkV3gdl "???";--rub_V2 = mkV2 (mkV "?????") ;
  scratch_V2 = mkV2yz "??";--scratch_V2 = mkV2 (mkV "??????") "??" ;
  split_V2 = mkV3gdl "???";--split_V2 = mkV2 (mkV "?????") "??" ;
    squeeze_V2 = mkV3gdl "???"; 
  --squeeze_V2 = dirV2 (regV "???????") ;
  stab_V2 = mkV2bl "??";--stab_V2 = dirV2 (regDuplV "????") ;
  suck_V2 = mkV4dbdb "????";--suck_V2 = mkV2 (mkV "?????") ;
  throw_V2 = mkV4dbdb "????";--throw_V2 = mkV2 (mkV "???????") ;
  --tie_V2 = mkV2 (mkV "???????") ;
  --wash_V2 = mkV2 (mkV "?????") ;
  wipe_V2 = mkV3gdl "???";--wipe_V2 = mkV2 (compoundV "???" (mkV "????" ));

  other_A = mkA "l%l!" ;

  grammar_N = mkN "?w!?w" ;
  language_N = mkN "?n?"  ;
  rule_N = mkN "hg" ;

---- added 4/6/2007
    john_PN = mkPN "y/h!n?" Masc ;
    question_N = mkN "Ty!q%" ;
    ready_A = mkA "zgj&" ;
    reason_N = mkN "m?l%" ;
    today_Adv = mkAdv "z!r%" ;
    --uncertain_A = mkA "y!lt'r'g!g'T'";

    ------------------------
     
    
} 
