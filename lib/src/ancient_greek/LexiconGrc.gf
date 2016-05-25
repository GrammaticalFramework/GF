--# -path=.:../abstract:../common:../prelude

-- Entries taken from Bornemann/Risch and Woodhouse 
-- English to Attic Greek dictionary:
-- http://www.lib.uchicago.edu/efts/Woodhouse/

-- Author: H.Leiss, CIS, LMU Muenchen 
-- TODO: check the mkN,mkA,mkV on the entries from Woodhouse (Wh) 

concrete LexiconGrc of Lexicon = CatGrc ** open 
  ParadigmsGrc, 
  IrregGrc, -- with additional verbs in IrregGrcAbs.gf
  ResGrc, -- for mkPrep only,
  Prelude in {

flags 
  optimize=values ;

lin
--  add_V3 : V3 ;
  airplane_N = mkN "h(liko'pthr" "h(liko'pteros" masculine ; -- HL
--   alas_Interj : Interj ;
--   already_Adv : Adv ;
  animal_N = mkN "vh'r" "vhro's" masculine ; 
  --  animal_N = mkN "zw|~on" "zw|'oy" neuter ;  -- TODO check
  answer_V2S = mkV2S (mkV "a)pokri'nw") datPrep ; -- medium
  apartment_N = mkN "oi)~kos" ; -- Woodhouse
  apple_N = mkN "mh~lon" ;
  art_N = mkN "te'cnh" ;
  ashes_N = mkN "te'fra" ; -- Woodhouse
  ask_V2Q = mkV2Q (mkV "e)rwta'w") accPrep ;
  baby_N = mkN "tekni'dion" ;
  back_N = mkN "nw~ton" ; -- Woodhouse
  bad_A = mkA "kako's" ;
  bank_N = mkN "tra'peza" ; -- Woodhouse
  bark_N = mkN "ploi~on" ; -- Woodhouse
  beautiful_A = mkA "kalo's" ;
--   become_VA : VA ;
--   beer_N : N ;  "o)i~nos kri_'vinos"  -- Gerstenwein
--   beg_V2V : V2V ; "ai)tei~n" tina ti -- Wh
--   belly_N : N ;  -- h koili'a, -as -- Bauchhoehle
  belly_N = mkN "gasth'r" "gastro's" "gaste'ra" feminine ; -- Wh 
  big_A = mkA "makro's" ;
  bike_N = mkN "dyozy'klon" ; -- HL
  bird_N = mkN "oi)wno's" ;
  black_A = mkA "me'la_s" "me'lanos" ; -- TODO: correct to me'las*, me'laina, me'lan
  blue_A = mkA "kyanoy~s" ; -- Wh
  boat_N = mkN "ploi~on" ;  -- Wh
  book_N = mkN "bi'blos" "bi'bloy" feminine ;
  boot_N = mkN "ko'vornos" ; -- Wh
  boss_N = mkN "o)mfa.lo's" ; -- Wh  mkN human (...)
  boy_N = mkN "pai~s" "paido's" masculine ;
  bread_N = mkN "a)'rtos" ;  
  break_V2 = mkV2 (prefixV "a)po" (mkV "kla'w")) ;
--  broad_A = mkA "ey)ry's" ; -- Wh TODO
  brother_N2 = mkN2 (mkN "a)delfo's") genPrep ;
  brown_A = mkA "xanvo's" ; -- Wh
--  butter_N = mkN "butter" ;
--  buy_V2 = dirV2 (mkV "w)nei~svai") ; -- Aor: pri'asvai, Wh -- TODO Comp.Bug
--  camera_N = mkN "camera" ;
  cap_N = mkN "ky.nh~" ; -- Wh
  car_N = mkN "zey~gos" "zey'goys" neuter ;
--  carpet_N = mkN "da.'pi.s" ; -- Wh BUG mkN does not apply
  cat_N = mkN feminine (mkN "ai)'loyros") ; -- Wh, Masc|Fem
  ceiling_N = mkN "o)rofh'" ; -- Wh
  chair_N = mkN "di'fros" ; -- Wh
  cheese_N = mkN "ty.ro's" ; -- Wh
  child_N = mkN2 (mkN "te'knon") genPrep ;  
--  church_N = mkN "new's" ;  -- TODO to i('dry_ma, -atos ??
  city_N = mkN "po'lis" "po'lews" feminine ;  -- polis
  clean_A = mkA "ka.va.ro's" ; -- Wh
  clever_A = mkA "fro'nimos" "froni'moy" ; -- TODO: froni'moy
  close_V2 = dirV2 (mkV "klh|'w") ; -- Wh
  coat_N = mkN "i(ma'tion" ;
  cold_A = mkA "qycro's" ; -- Wh TODO: correct forms/accents
  come_V = mkV "e)'rcomai" ; -- Wh TODO
--  computer_N = mkN "computer" ;
  country_N = mkN "cw'ra" ;
--  cousin_N = mkN human (mkN "cousin") ;
  cow_N = mkN "boy~s" "boo's" feminine ;     -- TODO: correct dual from boy~ to bo'e
  die_V = prefixV "a)po'" (mkV "vnh'skw") ;  -- TODO: check forms -- teleyta'w
  dirty_A = mkA "volero's" ; -- Wh
  distance_N3 = mkN3 (mkN feminine (mkN "o(do's")) fromP toP ;
  doctor_N = mkN "i)atro's" ; -- TODO check
  dog_N = mkNoun "ky'wn" "kyno's*" "kyni'" "ky'na" "ky'on" 
                 "ky'nes*" "kynw~n" "kysi'" "ky'nas*"      -- BR 55.4
                 "ky'ne" "kynoi~n" masculine ; 
  door_N = mkN "vy'ra" ;
  drink_V2 = dirV2 (mkV "pi_'nw" "pi'omai" "e('pion" "pe'pwka" "pe'pomai" "e)po'vhn" "poto's") ;
--  easy_A2V = mk_A2V (mkA "ra|'dios" "ra|di'oy") ; - Wh TODO
  eat_V2 = mkV2 (mkV "e)svi'w" "fa'gomai" "e)'fagon" "e)dh'dwka" "e)dh'desmai" "e)de'svhn" "e)desto's") ; 
  -- eat_V2 fut: (variants{"e)'domai" ; "fa'gomai"}) -- TODO: correct Fut-forms
  empty_A = mkA "keno's" ; -- Wh
  enemy_N = mkN "pole'mios" "polemi'oi" masculine ; -- ecvro's
  factory_N = mkN "e)rgasth'rion" ; -- Wh
  father_N2 = mkN2 (mkN "path'r" "patro's" "pate'ra" masculine) genPrep ;
  fear_VS = mkVS (mkV "fobe'w") ;  --  fear_N = mkN "fo'bos" "fo'boy" masculine
  find_V2 = dirV2 (mkV "ey(ri'skw") ; -- Wh
  fish_N = mkN "i)cvy~s" "i)cvy'os" masculine ;
  floor_N = mkN neuter (mkN "e)'dafos") ; -- Wh
  forget_V2 = dirV2 (mkV "e)pilanva.'nomai") ; -- Wh TODO
--  fridge_N = mkN "fridge" ;
  friend_N = mkN "fi'los" ;
  fruit_N = mkN "karpo's" ;
--  fun_AV = mkAV (regA "fun") ;
--  garden_N = mkN "paradei~son" ; 
  garden_N = mkN "kh~pos" ; -- Wh
  girl_N = mkN "pai~s" "paido's" feminine ;
--  glove_N = mkN "ceiri's" ; -- Wh TODO
  glove_N = mkN "ceiri's" "ceiri~dos" feminine ; -- HL guessed
  gold_N = mkN "cry's" "cryso's" neuter ; -- TODO check (accents missing in Pl)
  good_A = mkA "a)gavo's" ;
  go_V = mkV "e)'rxomai" ;
--  green_A = mkA "di'kaios" "dikai'a_s" ; -- Testword
  green_A = mkA "clwro's" ; -- Wh 
  harbour_N = mkN "limh'n" "lime'nos" masculine ;
  hate_V2 = dirV2 (mkV "mise'w") ; --  tina', ti' fut mish'sw
  hat_N = mkN "ky.nh~" ; -- Wh
  have_V2 = dirV2 (mkV "e('cw") ; -- Wh TODO
  hear_V2 = dirV2 (mkV "a)koy'w") ;
  hill_N = mkN "lo'fos" ; -- Wh
  hope_VS = mkVS (mkV "e)lpi'zw" "e)lpiw~" "h)'lpisa" "h)'lpika" "h)'lpismai" "h)lpi'svhn" "h)lpisto's") ; -- TODO check aorist
  horse_N = mkN "i('ppos" ; --hippos
  hot_A = mkA "vermo's" ;
  house_N = mkN "oi)~kos" "oi)'koy" masculine ;
  important_A = mkA "a)xio'logos" ;
  industry_N = mkN "filoponi'a_" ; -- Wh -- a_ added HL
  iron_N = mkN "si.'dhros" ; -- Wh 
  king_N = mkN "basiley's" "basile'ws" masculine ; 
  know_V2 = dirV2 (mkV "manva.'nw") ; -- Wh, better: eide'nai
  lake_N = mkN "li'mnh" ;
  lamp_N = mkN "lampvh'r" "lampth~ros" masculine ;
--  lamp_N = mkN "ly'cnos" ; -- Wh 
  learn_V2 = mkV2 "dida'skw" ; -- medium
  leather_N = mkN neuter (mkN "sky~tos") ; -- Wh
  leave_V2 = dirV2 (prefixV "a)po'" (mkV "bai'nw")) ; 
  like_V2 = mkV2 "file'w" ;
--  listen_V2 = mkV2 (prefixV "e)p" (mkV "a.koy'w")) genitive ; -- Wh tinos, ti BUGs
  live_V = mkV "paidey'w" ;  -- TESTWORD
  long_A = mkA "makro's" ; -- Wh
  lose_V2 = dirV2 (mkV "a.)poly.'nomai") ; -- Wh, BUGs
  love_N = mkN "a)ga'ph" ;
  love_V2 = mkV2 "a)gapa'w" ;  -- TODO check
  man_N = let man : N = mkN "a)nh'r" "a)ndro's" "a)'ndra" masculine 
           in { s = table{ Sg => table{ Voc => "a)'ner" ;
                                        c   => man.s ! Sg ! c };
                           n  => man.s ! n } ; 
                g = man.g } ;
  --  man_N = mkN "a)'nvrwpos" "a)nvrw'poy" masculine ; 
  married_A2 = mkA2 (mkA "gegamhme'nos") datPrep ;
  meat_N = mkN "e)nai'monon" "e)naimo'noy" neuter ;  -- e)aimos_A : having blood
  milk_N = mkN "ga'la" "ga'laktos" neuter ; -- TODO: correct Sg Nom|Akk
  moon_N = mkN "seilh~nh" ; -- TODO check
  mother_N2 = mkN2 (mkN "mh'thr" "mhtro's" "mhte'ra" feminine) genPrep ;
  mountain_N = mkN "o)'ros" "o)'roys" neuter ;
  music_N = mkN "moysikh'" ;
  narrow_A = mkA "steno's" ; -- Wh
  new_A = mkA "ne'os" "ne'a_s" ;
--  newspaper_N = mkN "newspaper" ;
  oil_N = mkN neuter (mkN "e)'laion") ; -- Wh
--  old_A = mkA "presby's" "presbei~a" "presby'" ; -- TODO mkA
--  old_A = mkA "presby's" "presby'teros" ; -- fake entry TODO 
  open_V2 = dirV2 (prefixV "a.)n" (mkV "oi'gw")) ; -- Wh
  paint_V2A = mkV2A (mkV "zwgrafe'w") noPrep ; -- TODO noPrep?
  paper_N = mkN "pa'py_ros" ;
--  paris_PN = mkPN (mkN nonhuman (mkN "Paris")) singular ;
  peace_N = mkN "ei)rh'nh" ;
--  pen_N = mkN "grafi's" ; -- Wh TODO: BUG
  planet_N = mkN "pla'nhs" "pla'nhtos" masculine ; -- TODO check accents
  plastic_N = mkN "plastiko'n" ;
--  play_V2 = dirV2 (mkV "y(pokri'nomai")) ; -- Wh (as actor) TODO prefixV
--  policeman_N = mkN masculine (mkN "policeman" "policemen") ;
  priest_N = mkN "i(erey's" "i(ere'ws" masculine;
  --  priest_N = mkN "i(eromnh'mwn" "i(ieromnh'monos" masculine ;
  probable_AS = (mkA "ey)'logos") ; -- Wh TODO mkAS
  queen_N = mkN "basi'lea_" ; 
--  radio_N = mkN "radio" ;
  rain_V0 = mkV "y('w" ; -- Wh TODO V0?
  read_V2 = mkV2 "a)nagignw'skw" ;
  red_A = mkA "a(loyrgo's" ;  -- purpur ; mkA "pyrro's" ; mkA "ko'kkinos" 
--  religion_N = mkN "religion" ;
--  restaurant_N = mkN "restaurant" ;
  river_N = mkN "potamo's" ; 
  rock_N = mkN "li.'vos" ;    -- TODO: check
  roof_N = mkN "o)'rofos" ; -- Wh
--  rubber_N = mkN "rubber" ;
--  run_V = mkV "tre'cw" "dramoy~mai" "e)'dramon" "dedra'mhka" ; -- BR 127 8
  -- TODO: why compiler error NonExist
  say_VS = mkVS (mkV "le'gw") ;
  school_N = mkN "scolh'" ; 
  science_N = mkN "ma'vhsis" "mate'sews" feminine ; -- TODO check
  sea_N = mkN "va'latta" "vala'tths" ; 
--  seek_V2 = dirV2 (irregV "seek" "sought" "sought") ;
--  see_V2 = dirV2 (irregV "see" "saw" "seen") ;
--  sell_V3 = dirV3 (irregV "sell" "sold" "sold") toP ;
--  send_V3 = dirV3 (irregV "send" "sent" "sent") toP ;
--  sheep_N = mkN "o)'is" "oi)o's" "oi)i'" "oi)~n" "oi)~es" "oi)w~n" "oi)si'n" "oi)~s" ; -- TODO
  ship_N = mkN "nay~s" "new's" feminine ;
  shirt_N = mkN "ci.twni'skos" ; -- Wh
  shoe_N = mkN "krhpi's" "krhpi~dos" feminine ;
--  shop_N = mkN "shop" ;
--  short_A = mkA "di'kaios" ; -- TODO accent shift!
--  short_A = mkA "bra.cy.'s" ; -- Wh TODO BUG
  silver_N = mkN "a)'rgyron" ; -- TODO check
  sister_N = mkN2 (mkN "a)delfh'") genPrep ;
  sleep_V = mkV "kavey'dw" ;
  small_A = mkA "mikro's" ;
  snake_N = mkN "dra_'kwn" "dra'kontos" masculine ; -- mkN "o)'fis" "o)'fews" masculine
--  sock_N = mkN "sock" ;
  speak_V2 = mkV2 (mkV "le'gw" "le'xw" "e)'lexa" "le'lega" "le'legmai" "e)le'kthn" "lekto's*") aboutP ;
  star_N = mkN "a)sth'r" "a)ste'ros" masculine ; -- TODO a)stra'si
  steel_N = mkN "si.'dhros" ; -- Wh
  stone_N = mkN "li'vos" ;
  stove_N = mkN "kri_'banos" ;
  student_N = mkN masculine (mkN "mavhth's") ; -- TODO check
  stupid_A = mkA "a)'frwn" "a)'fronos" ;        -- or "mw~ros" 
  sun_N = mkN "h('lios" ; -- TODO check accents?
--  switch8off_V2 = dirV2 (partV (regV "switch") "off") ;
--  switch8on_V2 = dirV2 (partV (regV "switch") "on") ;
  table_N = mkN "tra'peza" ; -- Wh (TODO glyph a.' and i.' in Cardo)
  talk_V3 = mkV3 (mkV "diale'gw") datPrep (mkPrep "pro's" accusative) ;
  teacher_N = mkN "dida'skalos" ;
  teach_V2 = mkV2 "paidey'w" ;  -- "dida'skw" 
--  television_N = mkN "television" ;
  thick_A = mkA "pykno's" ; -- Wh
  thin_A = mkA "mano's" ; -- Wh
--  train_N = mkN "train" ;
  travel_V = mkV "porey'omai" ; -- Wh TODO Part
  tree_N = mkN "de'ndron" ;
---- trousers_N = mkN "trousers" ; 
-- trousers_N = TODO mkN "a)naxyri'des" feminine plural -- Wh
  ugly_A = mkA "ai)scro's" ;
  understand_V2 = mkV2 "gignw'skw" ;
  university_N = mkN "a)kademi'a" "a)kademi'as" ;
  village_N = mkN "xwri'on" ; -- mkN "w'ra"
  wait_V2 = mkV2 "me'nw" ; -- Wh a)na-me'nw
  watch_V2 = dirV2 (mkV "fy.lattw") ; -- Wh fy.lassein
  water_N = mkN "y('dwr" "y('datos" masculine ; -- TODO check
  white_A = mkA "leyko's" ; -- TODO accent?
--  window_N = mkN "vy.ri.'s" ; -- Wh feminine TODO mkN
  window_N = mkN "vy.ri.'s" "vy.ri~dos" feminine ; -- Wh, HL guessed gen
  wine_N = mkN "oi)~nos" ;
--  win_V2 = dirV2 (irregDuplV "win" "won" "won") ;
--  woman_N = mkN "gynai'ka" ; -- "gynh'" "gynaiko's*" ; -- TODO correct BR 55
  woman_N = mkNoun "gynh'" "gynaiko's*" "gynaiki'" "gynai~ka" "gy'nai" 
                   "gynai~kes*" "gynaikw~n" "gynaixi'" "gynai~kas*" 
                   "gynai~ke" "gynaikoi~n" feminine ; --  BR 55
--  wonder_VQ = mkVQ (mkV "vayma'zw") ; -- Wh
  wood_N = mkN "xy'lon" ;
  write_V2 = mkV2 "gra'fw" ;
  yellow_A = mkA "xanvo's" ; -- Wh
  young_A = mkA "ne'os" ;    -- TODO: vowel lengths neo'tatos => new'tatos etc.
-- do_V2 = dirV2 (mkV "dra'w") ;
  do_V2 = dirV2 (mkV "dra'w" "dra_'sw" "e)'dra_sa" "de'dra_ka" "de'dramai" "e)dra'svhn" "drasto's") ;
  now_Adv = mkAdv "ny~n" ;
  already_Adv = mkAdv "h)'dh" ; -- Wh
  song_N = mkN "w)dh'" ;
--  add_V3 = mkV3 (prefixV "syn" (mkV "logi'zw")) accPrep toP ;
  number_N = mkN "a)rivmo's" ; -- ?? guessed 
--  put_V2 = TODO Wh ti.ve'nai 
  stop_V = mkV "pay'w" ;
--  jump_V = regV "jump" ;
--
  left_Ord = { s = (mkA "a.)ristero's").s ! Posit } ; -- Wh
  right_Ord = { s = (mkA "dexio's").s ! Posit } ;
  far_Adv = mkAdv "po'rrw" ; -- BR 63 3
  correct_A = mkA "o)rto's" ; -- Wh
  dry_A = mkA "xhro's" ; -- Wh
  dull_A = mkA "skaio's" ; -- Wh (not intelligent)
--  full_A = mkA "ple'ws" ; -- Wh -- TODO mkA
--  heavy_A = mkA "a)rgyroy~s*" ; -- TESTWORD (silvern) bary's
--  heavy_A = mkA "ba.ry.'s" ; -- Wh -- Bug
--  near_A = mkA "crysoy~s*" ;    -- TESTWORD (golden)
  near_A = mkA "pro'scwros" ; -- Wh
  rotten_A = mkA "savro's" ; -- Wh
--  round_A = mkA "kykloterh's" ; -- Wh -- TODO mkA
--  sharp_A = mkA "o)xy's" "o)xei~a" "o)xy'" ; -- TODO: improve mkA to accept this
  smooth_A = mkA "lei~os" ; -- Wh
--  straight_A = mkA "ey)vy.'s" ; -- Wh -- TODO mkA
  wet_A = mkA "y(gro's" ; -- Wh 
--  wide_A = mkA "ey)ry.'s" ; -- Wh -- TODO mkA

  blood_N = mkN "ai('ma" "ai('matos" neuter ;
  bone_N = mkN "o)stoy~n" ; -- Ok
  --  bone_N = mkN "o)ste'on" ; 
--  breast_N = mkN "breast" ;
  cloud_N = mkN "nefe'lh" ;
  day_N = mkN "h(me'ra_" ;
  dust_N = mkN "koni'a_" ;  -- TODO: check forms 
  ear_N = mkN "oy)~s" "w)to's" neuter ;  -- TODO correct Sg Nom|Acc
  earth_N = mkN "gh~" ;  -- Pl and DL ???
  egg_N = mkN "w|)o'n" ; -- Wh
  eye_N = mkN "o(fvalmo's" ;
  fat_N = mkN "dhmo's" ; -- Wh
  feather_N = mkN "ptero'n" ; -- Wh
  fingernail_N = mkN "o)'nyx" "o)'nycos" masculine ;
  fire_N = mkN "py~r" "pyro's" neuter ; -- TODO correct Pl, BR 55 6: pyrsi > pyrois
  flower_N = mkN "a)'nvos" "a)'nvoys" neuter ; 
  fog_N = mkN "nefe'lh" ; -- Wh ; o)mi'clh
  foot_N = mkN "poy's" "podo's" masculine ; -- BR 44 3
  forest_N = mkN "dry_mo's" ;
  grass_N = mkN "clo'h" ; -- Wh -- TODO mkN "po'a" ; -- Wh
--  guts_N = mkN "spla'gxna" neuter plural ; -- WH pl -- FIXME: no singular
  guts_N = mkN "spla'ngxnon" ; -- Wh with pl only 
  hair_N = mkN "tri'x" "trico's" feminine ; 
  hand_N = mkN "cei~r" "ceiro's" feminine ; -- TODO exception PlDat cersi' 
  head_N = mkN "ke'falos" ; -- TODO check
--  heart_N = mkN "kardi'a" "kardi'as" feminine ; -- TODO mkN does not recognize -as*
  heart_N = mkN "kardi'a_" ; 
  horn_N = mkN "ke'ras" "ke'ratos" neuter ; -- 
  husband_N = mkN "game'ths" ;
--  ice_N = mkN "ice" ;
  knee_N = mkN "go'ny" "go'natos" neuter ;  -- TODO BR 44 3
  leaf_N = mkN "fy'llon" "fy'lloy" neuter ;
  leg_N = mkN neuter (mkN "ske'los") ; -- We
  liver_N = mkN "h(~par" "h('patos" neuter ; -- TODO Sg Nom|Acc
  louse_N = mkN "fvei'r" "fveiro's" masculine ; -- Wh
  mouth_N = mkN "sto'ma" "st'omatos" neuter ; -- TODO check
  name_N = mkN "o)'noma" "o)no'matos" neuter ; -- TODO check
  neck_N = mkN "tra'chlos" ; 
  night_N = mkN "ny'x" "nykto's" feminine ;
--  nose_N = mkN "nose" ; h r(i-s ths r(inos
  nose_N = mkN "ri~s" "ri_no's" feminine ; -- Wh, HL guessed
  person_N = mkN "a)'nvrwpos" "a)nvrw'poy" masculine ; -- HL
  rain_N = mkN "y(eto's" ; -- Wh ; ggf TODO mkN "y('dwr" ;
  road_N = mkN feminine (mkN "o(do's") ; 
--  root_N = mkN "ri'za." ; -- Wh TODO mkN fem
--  rope_N = mkN "ka.'lws" ; -- Wh masculine  TODO mkN
  salt_N = mkN "a('ls" "a(lo's" masculine ;
  sand_N = mkN "a)'mmos" "a)'mmoy" feminine ; -- Wh
  seed_N = mkN "spe'rma" "spe'rmatos" neuter ; -- Wh
  skin_N = mkN "de'rma" "de'rmatos" neuter ; -- TODO check
  sky_N = mkN "oy)ra.no's" ; -- Wh
  smoke_N = mkN "kapno's" ; -- Wh
  snow_N = mkN "nifa's" "nifa'dos" feminine ;
  stick_N = mkN "ra'bdos" "ra'bdoy" feminine ;
  tail_N = mkN "ke'rkos" ; -- Wh ; h( ou)ra'
  tongue_N = mkN "glw~tta" "glw'tths" ; -- ok
  tooth_N = mkN "o)doy's" "o)do'ntos" masculine ;
  wife_N = mkN "gameth'" ; 
  wind_N = mkN "a)'nemos" ; -- TODO check
  wing_N = mkN "pte'ryx" "pte'rycos" feminine ; -- Wh, HL gen
  worm_N = mkN "ey)lh'" ; -- Wh
  year_N = mkN "e)'tos" "e)'toys" neuter ;
--
  blow_V = mkV "pne'w" ;    -- TODO check
  breathe_V = mkV "pne'w" ;
--  burn_V = IrregGrc.burn_V ;
--  dig_V = IrregGrc.dig_V ;
  fall_V = mkV "pi'ptw" "pesoy~mai" "e)'peson" "pe'ptwka" ;  -- GMOLL
--               "pe'ptwmai" "e)pe'pthn" "pepto's" ;         -- HL guessed
--  float_V = regV "float" ;
--  flow_V = regV "flow" ;
--  fly_V = IrregGrc.fly_V ;
--  freeze_V = IrregGrc.freeze_V ;
  give_V3 = dirV3 (mkV "di'dwmi" "dw'sw" "e)'dwka" "de'dwka" 
                       "de'domai" "e)do'vhn" "doto's") datPrep ; -- didwmi_V
  laugh_V = mkV "gela'w" ;        -- TODO: check
--  lie_V = IrregGrc.lie_V ;
--  play_V = regV "play" ;
--  sew_V = IrregGrc.sew_V ;
--  sing_V = IrregGrc.sing_V ;
--  sit_V = IrregGrc.sit_V ;
--  smell_V = regV "smell" ;
--  spit_V = IrregGrc.spit_V ;
--  stand_V = IrregGrc.stand_V ;
--  swell_V = IrregGrc.swell_V ;
--  swim_V = mkV ;
  think_V = mkV "frone'w" ;        -- TODO: check forms
--  turn_V = regV "turn" ;
--  vomit_V = regV "vomit" ;
--
--  bite_V2 = dirV2 IrregGrc.bite_V ;
--  count_V2 = dirV2 (regV "count") ;
  cut_V2 = dirV2 (mkV "te'mnw") ;  -- TODO: correct forms Fut e.a.
--  fear_V2 = dirV2 (regV "fear") ;
--  fight_V2 = dirV2 fight_V ;
--  hit_V2 = dirV2 hit_V ;
--  hold_V2 = dirV2 hold_V ;
--  hunt_V2 = dirV2 (regV "hunt") ;
  kill_V2 = mkV2 (prefixV "a)po" (mkV "ktei'nw")) ; -- TODO: special forms for passive
--  pull_V2 = dirV2 (regV "pull") ;
--  push_V2 = dirV2 (regV "push") ;
--  rub_V2 = dirV2 (regDuplV "rub") ;
--  scratch_V2 = dirV2 (regV "scratch") ;  -- TODO se'scimai => Bug
  split_V2 = dirV2 (mkV "sci'zw" "sci'sw" "e)'scisa" "se'scika" "se'scimmai" "e)sci'svhn" "scisto's") ;
--  squeeze_V2 = dirV2 (regV "squeeze") ;
--  stab_V2 = dirV2 (regDuplV "stab") ;
--  suck_V2 = dirV2 (regV "suck") ;
  throw_V2 = datV2 (mkV "ba'llw") ;
--  tie_V2 = dirV2 (regV "tie") ;
--  wash_V2 = dirV2 (regV "wash") ;
--  wipe_V2 = dirV2 (regV "wipe") ;
--
----  other_A = regA "other" ;

  grammar_N = mkN "grammatikh'" ;
  language_N = mkN "glw~ssa" "glw'sshs" ; -- TODO: accents??
--  rule_N = mkN "rule" ;
--
---- added 4/6/2007
    john_PN = mkPN (mkN masculine (mkN "Ia'nnas")) singular ;
    question_N = mkN "e)rw'thsis" "e)rwth'sews" feminine ; -- Wh 
               -- gen guessed HL -- Wh TODO mkN "e)rw'thma" neuter;
    ready_A = mkA "e(toi~mos" ; -- Wh 
    reason_N = mkN "lo'gos" ;  -- mkN "ai)ti'a" 
--    today_Adv = mkAdv "today" ;
--    uncertain_A = regA "uncertain" ;

oper
  aboutP = mkPrep "peri'" Gen;
  atP = mkPrep "para'" Dat ;
  forP = mkPrep "pro'" Gen ;
  inP = mkPrep "e)n" Dat ;
  onP = mkPrep "e)pi'" Gen ;
  toP = mkPrep "e)pi'" Acc ;  -- mkPrep "para'" Acc ; 
  fromP = mkPrep "e)x" Gen ;
  noPrep = mkPrep [] Acc ;
}
