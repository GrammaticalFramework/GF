--# -path=.:../abstract:../common:../prelude 

-- Ilona Nowak, Wintersemester 2007/08

-- Adam Slaski, 2009, 2010 <adam.slaski@gmail.com>

  concrete LexiconPol of Lexicon = CatPol, LexiconNounPol **  
    open Prelude, MorphoPol, (PP = ParadigmsPol) in { 

    flags  
      optimize =values ; coding =utf8 ; 

lin  
  bad_A = mkRegAdj "zły" "gorszy" "źle" "gorzej"; 
  beautiful_A = mkRegAdj "piękny" "piękniejszy" "pięknie" "piękniej"; 
  big_A = mkRegAdj "duży" "większy" "dużo" "więcej"; 
  black_A = mkRegAdj  "czarny" "czarniejszy" "czarno" "czarniej";
  blue_A = mkCompAdj "niebieski" "niebiesko"; 
  broad_A = mkRegAdj "szeroki" "szerszy" "szeroko" "szerzej"; 
  brown_A = mkCompAdj "brązowy" "brązowo"; 
  correct_A = mkCompAdj "poprawny" "poprawnie";  
  clean_A = mkRegAdj "czysty" "czystszy" "czysto" "czyściej";  
  clever_A = mkRegAdj "mądry" "mądrzejszy" "mądrze" "mądrzej"; 
  cold_A = mkRegAdj "zimny" "zimniejszy" "zimno" "zimniej"; 
  dirty_A = mkRegAdj  "brudny" "brudniejszy" "brudno" "brudniej"; 
  dry_A = mkRegAdj "suchy" "suchszy" "sucho" "suszej"; 
  dull_A = mkRegAdj "tępy" "tępszy" "tępo" "tępiej"; 
  far_Adv = mkAdv "daleko"; 
  full_A = mkRegAdj "pełny" "pełniejszy" "pełno" "pełniej"; 
  good_A = mkRegAdj "dobry" "lepszy" "dobrze" "lepiej";  
  green_A = mkRegAdj "zielony" "zieleńszy" "zielono" "zieleniej"; 
  hot_A = mkRegAdj "gorący" "gorętszy" "gorąco" "goręcej"; 
  important_A = mkRegAdj "ważny" "ważniejszy" "ważnie" "ważniej"; 
  long_A = mkRegAdj "długi" "dłuższy" "długo" "dłużej";
  narrow_A =  mkRegAdj "wąski" "węższy" "wąsko" "węziej";  
  new_A =  mkRegAdj  "nowy" "nowszy" "nowo" "nowiej"; 
  old_A = mkRegAdj "stary" "starszy" "staro" "starzej"; 
  red_A =  mkRegAdj  "czerwony" "czerwieńszy" "czerwono" "czerwieniej"; 
  short_A = mkRegAdj "krótki" "krótszy" "krótko" "krócej"; 
  small_A = mkRegAdj "mały" "mniejszy" "mało" "mniej"; 
  stupid_A = mkRegAdj "głupi" "głupszy" "głupio" "głupiej"; 
  thick_A = mkRegAdj "gruby" "grubszy" "grubo" "grubiej"; 
  thin_A = mkRegAdj "cienki" "cieńszy" "cienko" "cieniej"; 
  today_Adv = mkAdv "dziś";
  ugly_A = mkRegAdj  "brzydki" "brzydszy" "brzydko" "brzydziej"; 
  warm_A = mkRegAdj  "ciepły" "cieplejszy" "ciepło" "cieplej"; 
  white_A = mkRegAdj  "biały" "bielszy" "biało" "bielej";  
  yellow_A = mkRegAdj "żółty" "żółtszy" "żółto" "żółciej"; 
  young_A = mkRegAdj "młody" "młodszy" "młodo" "młodziej"; 
  now_Adv = mkAdv "teraz"; 
  already_Adv = mkAdv "właśnie"; 
--   fun_AV = mkRegAdj "wesoły"; 
-- --   easy_A2V = mkRegAdj2 (mkRegAdj "łatwy") "dla" Gen ; 
  empty_A = mkRegAdj "pusty" "puściejszy" "pusto" "puściej";
  married_A2 = addComplToAdj ( mkCompAdj "zaślubiony" ) "" Dat;
  probable_AS = mkRegAdj "możliwy" "możliwszy" "możliwie" "możliwiej"; 
  ready_A = mkCompAdj "gotowy";
  uncertain_A = mkCompAdj "niepewny" "niepewnie";
  heavy_A = mkRegAdj "ciężki" "cięższy" "ciężko" "ciężej"; 
  near_A = mkRegAdj "bliski" "bliższy" "blisko" "bliżej"; 
  rotten_A = mkCompAdj "zepsuty"; 
  round_A = mkRegAdj "okrągły" "okrąglejszy" "okrągło" "okręglej";
  sharp_A = mkRegAdj "ostry" "ostrzejszy" "ostro" "ostrzej"; 
  smooth_A = mkRegAdj "gładki" "gładszy" "gładko" "gładziej"; 
  straight_A = mkRegAdj "prosty" "prostszy" "prosto" "prościej"; 
  wet_A = mkCompAdj "mokry" "mokro";
  wide_A = mkRegAdj "szeroki" "szerszy" "szeroko" "szerzej"; 

  distance_N3 = mkN3 distance_N zGenPrep doPrep ;
  mother_N2 = mkN2 mother_N;   
  brother_N2 = mkN2 brother_N; 
  father_N2 = mkN2 father_N; 

  right_Ord = { s = mkAtable (guess_model "prawy") }; 
  left_Ord = { s = mkAtable (guess_model "lewy") };  
  
  rain_V0  = mkItVerb (mkMonoVerb "padać" conj98 Imperfective);
  wonder_VQ = mkItVerb (mkReflVerb (mkV "zastanawiać" conj98 "zastanowić" conj77a));
  fear_VS = mkReflVerb (mkMonoVerb "bać" conjbac Imperfective);
  hope_VS = mkItVerb (mkComplicatedVerb (mkMonoVerb "mieć" conj100 Imperfective) "nadzieję");
  know_VQ = mkMonoVerb "wiedzieć" conj103 Imperfective;
  know_VS = mkMonoVerb "wiedzieć" conj103 Imperfective;
  say_VS = mkV "mówić" conj72  "powiedzieć" conj103; 
  become_VA =  (mkReflVerb (mkV "stawać" conj57 "stać" conj3)) ** {c={c=Nom;s="";adv=False}};
  answer_V2S = mkV2 (mkV "odpowiadać" conj98 "odpowiedzieć" conj103) "" Dat;
  ask_V2Q = dirV2 (mkV "pytać" conj98 "spytać" conj98);
--     beg_V2V = mkV2 (mkV "prosić" conj83 Imperfective) "" "o" Acc Acc; -- no such verb in Polish; beg is V2S
  paint_V2A = (mkV1 "malować" conj53 "pomalować" conj53) ** ({c={c=Nom;s="na";adv=True}; c2={c=AccNoPrep;s=""}});

  add_V3 = mkV3 (mkV "dodawać" conj57 "dodać" conj99) "" "do" Acc Gen;
  sell_V3 = dirV3 (mkV "sprzedawać" conj57 "sprzedać" conj99);
  send_V3 = mkV3 (mkV "wysyłać" conj98 "wysłać" conj67 ) "" "do" Acc Gen ;
  talk_V3 = mkV3 (mkV "rozmawiać" conj98 "porozmawiać" conj98) "z" "о" Instr Loc; 
  give_V3 = mkV3 (mkV "dawać" conj57 "dać" conj99) "" "" Acc Dat;
                        
  fear_V2 = mkV2 (mkReflVerb (mkMonoVerb "bać" conjbac Imperfective)) "" Gen;
  hit_V2 = dirV2 (mkV "bić" conj51 "pobić" conj51); 
  cut_V2 = dirV2 (mkV "ciąć" conj23 "pociąć" conj23); 
  pull_V2 = dirV2 (mkV "ciągnąć" conj5  "pociągnąć" conj5); 
  wait_V2 = mkV2 (mkItVerb (mkV "czekać" conj98 "poczekać" conj98)) "na" Acc; 
  read_V2 = dirV2 (mkV "czytać" conj98 "przeczytać" conj98); 
  scratch_V2 = dirV2 (mkV "drapać" conj70 "podrapać" conj70);
  split_V2 = dirV2 (mkV "dzielić" conj75 "podzielić" conj75);
  stab_V2 = dirV2 (mkV "dźgać" conj98 "dźgnąć" conj5); 
  play_V2 = {-variants {-} mkV2 (mkItVerb (mkV "grać" conj98 "zagrać" conj98)) "w" Acc; 
--                          mkV2 (mkItVerb (mkV "grać" conj98 "zagrać" conj98)) "na" Loc } ;
  bite_V2 = dirV2 (mkV "gryźć" conj26a "ugryźć" conj26a); 
  lose_V2 = dirV2 (mkV "gubić" conj72 "zgubić" conj72); 
  eat_V2 = dirV2 (mkV "jeść" conj102 "zjeść" conj102); 
  put_V2 = dirV2 (mkV "kłaść" conj25 "położyć" conj88a); 
  love_V2 = dirV2 (mkMonoVerb "kochać" conj98 Imperfective); 
  buy_V2 = dirV2 (mkV "kupić" conj72 "kupować" conj53); 
  count_V2 = dirV2 (mkV "liczyć" conj87 "policzyć" conj87);
  like_V2 = dirV2 (mkV "lubić" conj72em "polubić" conj72); 
  break_V2 = dirV2 (mkV "łamać" conj70 "złamać" conj70); 
  wash_V2 = dirV2 (mkV "myć" conj51 "umyć" conj51); 
  hate_V2 = dirV2 (mkV "nienawidzić" conj80 "znienwidzić" conj80);
  watch_V2 = dirV2 (mkV "oglądać" conj98 "obejrzeć" conj94a); 
  leave_V2 = dirV2 (mkV "opuszczać" conj98 "opuścić" conj84); 
  open_V2 = dirV2 (mkV "otwierać" conj98 "otworzyć" conj88); 
  push_V2 = dirV2 (mkV "pchać" conj98 "pchnąć" conj5); 
  drink_V2 = dirV2 (mkV "pić" conj51 "wypić" conj51); 
  write_V2 = dirV2 (mkV "pisać" conj60 "napisać" conj60); 
  hunt_V2 = mkV2 (mkItVerb (mkMonoVerb "polować" conj53 Imperfective)) "na" Acc; 
  do_V2 = dirV2 (mkV "robić" conj77 "zrobić" conj77);
  speak_V2 = mkV2 (mkMonoVerb "rozmawiać" conj98 Imperfective) "z" Instr;
  understand_V2 = dirV2 (mkV "rozumieć" conj101 "zrozumieć" conj101); 
  throw_V2 = dirV2 (mkV "rzucać" conj98 "rzucić" conj81); 
  listen_V2 = dirV2 (mkV "słuchać" conj98 "posłuchać" conj98); 
  hear_V2 = dirV2 (mkV "słyszeć" conj94 "usłyszeć" conj94); 
  suck_V2 = dirV2 (mkMonoVerb "ssać" conj65 Imperfective);     
  seek_V2 = dirV2 (mkMonoVerb "szukać" conj98 Imperfective); 
  wipe_V2 = dirV2 (mkV "wycierać" conj98 "trzeć" conj43); -- strange?!?!
  squeeze_V2 = dirV2 (mkV "ściskać" conj98 "ścisnąć" conj6); 
  rub_V2 = dirV2 (mkMonoVerb "trzeć" conj43 Imperfective); 
  hold_V2 = dirV2 (mkMonoVerb "trzymać" conj98 Imperfective);
  learn_V2 = dirV2 (mkReflVerb (mkV "uczyć" conj87 "nauczyć" conj87)); 
  teach_V2 = dirV2 (mkV "uczyć" conj87 "nauczyć" conj87); 
  fight_V2 = mkV2 (mkItVerb (mkMonoVerb "walczyć" conj87 Imperfective)) "z" Instr;
  tie_V2 = dirV2 (mkMonoVerb "wiązać" conj59 Imperfective); 
  see_V2 = dirV2 (mkV "widzieć" conj92 "zobaczyć" conj87); 
  know_V2 = dirV2 (mkMonoVerb "wiedzieć" conj103 Imperfective); 
  switch8on_V2 = dirV2 (mkV "włączać" conj98 "włączyć" conj87); 
  win_V2 = dirV2 (mkV "wygrywać" conj98 "wygrać" conj98); 
  switch8off_V2 = dirV2 (mkV "wyłączać" conj98 "wyłączyć" conj87); 
  kill_V2 = dirV2 (mkV "zabijać" conj98 "zabić" conj51); 
  close_V2 = dirV2 (mkV "zamknąć" conj5 "zamykać" conj98);
  forget_V2 = dirV2 (mkV "zapominać" conj98 "zapomnieć" conj91); 
  find_V2 = dirV2 (mkV "znaleźć" conj40 "znajdywać" conj54); 
  
  
  run_V = mkV1 "biec" conj15 "pobiec" conj15; 
  smell_V = mkV1 "czuć" conj51 "poczuć" conj51;
  blow_V = mkV1 "dmuchać" conj98 "dmuchnąć" conj5; 
  float_V = mkV1 "dryfować" conj53 "zdryfować" conj53;
  play_V = mkV1 "grać" conj98 "zagrać" conj98;
  go_V = mkV1 "iść" conj41a "pójść" conj42; 
  lie_V = mkV1 "kłamać" conj70 "skłamać" conj70; 
  dig_V = mkV1 "wykopywać" conj54 "wykopać" conj70; --
  fly_V = mkMonoVerb "latać" conj98 Imperfective;
  think_V = mkV1 "myśleć" conj90 "pomyśleć" conj90;
  turn_V = mkReflVerb (mkV1 "obracać" conj98 "obrócić" conj81);
  breathe_V = mkV1 "oddychać" conj98 "odetchnąć" conj5; 
  burn_V = mkMonoVerb "palić" conj75 Imperfective;
  spit_V = mkV1 "pluć" conj51 "plunąć" conj4; 
  flow_V = mkMonoVerb "płynąć" conj4 Imperfective; 
  swim_V = mkMonoVerb "pływać" conj98 Imperfective; 
  travel_V = mkMonoVerb "podróżować" conj53 Imperfective; 
  come_V = mkV1 "przyjść" conj41 "przychodzić" conj80;
  swell_V = mkV1 "puchnąć" conj7 "spuchnąć" conj7; 
  vomit_V = mkV1 "rzygać" conj98 "rzygnąć" conj5; 
  sit_V = mkMonoVerb "siedzieć" conj92 Imperfective;
  jump_V = mkV1 "skakać" conj61 "skoczyć" conj87; 
  walk_V = mkV1 "spacerować" conj53 "pospacerować" conj53; 
  sleep_V = mkMonoVerb "spać" conj96 Imperfective;
  fall_V = mkV1 "spaść" conj17 "spadać" conj98; 
  laugh_V = mkReflVerb (mkV1 "śmiać" conj52 "roześmiać" conj52); 
  sing_V = mkV1 "śpiewać" conj98 "zaśpiewać" conj98; 
  stand_V = mkMonoVerb "stać" conj95 Imperfective; 
  sew_V = mkV1 "szyć" conj51 "uszyć" conj51; 
  die_V = mkV1 "umierać" conj98 "umrzeć" conj43; 
  freeze_V = mkV1 "zamarzać" conj98 "zamarznąć" conj7; 
  stop_V = mkV1 "zatrzymywać" conj54 "zatrzymać" conj98; 
  live_V = mkV1 "żyć" conj51 "pożyć" conj51;
} ;
