concrete LexiconEus of Lexicon = CatEus **
  open ParadigmsEus, Prelude, (R=ResEus) in {

----
-- A

lin add_V3 = mkV3 "gehitu" ; -- | mkV3 "erantsi" | mkV3 "gaineratu" ; --Apertium
lin airplane_N = mkN "hegazkin" ;
--lin alas_Interj = mkInterj "" ;
lin already_Adv = mkAdv "dagoeneko" ; --Google translate
lin animal_N = mkN "animalia" ;
lin answer_V2S = mkV2S "erantzun" ; 
lin apartment_N = mkN "pisu" ; -- | mkN "apartamentu" ; --Apertium
lin apple_N = mkN "sagar" ;
lin art_N = mkN "arte" ;
--lin ashes_N = mkN 
lin ask_V2Q = mkV2Q "galdetu" ;

----
-- B

lin baby_N = mkN "haur" ; -- | mkN "ume" | mkN "kreatura" ; --Apertium
lin back_N = mkN "bizkar" ;
lin bad_A = mkA "txar" ;
lin bank_N = mkN "banku" ; --| mkN "erribera" | mkN "ertz" ; --Apertium
lin bark_N = mkN "azal" ; --Apertium
lin beautiful_A = mkA "polit" ;
lin become_VA = mkVA "bihurtu" ;
lin beer_N = mkN "garagardo" ;
lin beg_V2V = mkV2V "eskatu" ;
lin belly_N = mkN "urdail" ; --| mkN "sabel" ; --Apertium
lin big_A = mkA "handi" ;
lin bike_N = mkN "bizikleta" ;
lin bird_N = mkN "txori" ; -- | mkN "hegazti" ; --Apertium
lin bite_V2 = mkV2 "ausiki" ; -- mkV2 (mkV "kosk" egin_V) --Apertium
lin black_A = mkA "beltz" ;
lin blood_N = mkN "odol" ;
lin blow_V = mkV "putz" egin_V ;
lin blue_A = mkA "urdin" ;
lin boat_N = mkN "itsasontzi" ;
lin bone_N = mkN "hezur" ; --Apertium
lin boot_N = mkN "bota" ; --Apertium
lin boss_N = mkN "nagusi" ; --Apertium
lin book_N = mkN "liburu" ;
lin boy_N  = mkN "mutil" ;
lin bread_N = mkN "ogi" ; --Apertium
lin break_V2 = mkV2 "izorratu" ; --Apertium
lin breast_N = mkN "bular" ; --Apertium
lin breathe_V = mkV "arnastu" ; --Apertium
lin broad_A = mkA "zabal" ; --Apertium
lin brother_N2 = mkN2 "anaia" ;
lin brown_A = mkA "marroi" ; --Apertium
lin burn_V = mkV "erre" ; -- | mkV "kiskali" ; --Apertium
lin butter_N = mkN "gurin" ; --Apertium
lin buy_V2 = mkV2 "erosi" ;

----
-- C

lin camera_N = mkN "kamera" ; -- | mkN "ganbera" ; --Apertium
lin cap_N = mkN "txapel" ; -- | mkN "tapoi" ; --Apertium
lin car_N = mkN "auto" ; --| mkN "automobil" ; --Apertium
lin carpet_N = mkN "alfonbra" ; --Apertium
lin cat_N = mkN "katu" ;
lin ceiling_N = mkN "sabai" ; --Apertium
lin chair_N = mkN "aulki" ; --Apertium
lin cheese_N = mkN "gazta" ; --Apertium
lin child_N = mkN "ume" ; --| mkN "umetxo" ; --Apertium
lin church_N = mkN "eliza" ; --Apertium
lin city_N = mkN "hiri" ; --Apertium
lin clean_A = mkA "garbi" ; --Apertium
lin clever_A = mkA "azkar" ; --Apertium
lin close_V2 = mkV2 "gerturatu" ; -- | mkV2 "itxi" | mkV2 "zarratu" ; --Apertium
lin cloud_N = mkN "hodei" ; --Apertium
lin coat_N = mkN "beroki" ; -- | mkN "kapa" ; --Apertium
lin cold_A = mkA "hotz" ;
lin come_V = etorri_V ;
lin computer_N = mkN "ordenagailu" ; --| mkN "ordenatzaile" ; --Apertium
lin correct_A = mkA "zuzen" ; --Apertium
lin count_V2 = mkV2 "kontatu" ; -- | mkV2 "zenbatu" ; --Apertium
lin country_N = mkN "herri" ; --Apertium
lin cousin_N = mkN "lehengusu" ; --Apertium
lin cow_N = mkN "behi" ; --Apertium
lin cut_V2 = mkV2 "ebaki" ; -- | mkV2 "moztu" ; --Apertium

----
-- D

lin day_N = mkN "egun" ; --Apertium
lin die_V = izanV "hil" ; -- | mkV "zendu" ; --Apertium
lin dig_V = mkV "zulatu" ; --Apertium
lin dirty_A = mkA "likits" ; --| mkA "zikin" ; --Apertium
-- lin distance_N3 = mkN3 (mkN "distantzia") fromP toP ; --Apertium
lin do_V2 = lin V2 egin_V ;
lin doctor_N = mkN "mediku" ; --| mkN "doktore" ; --Apertium
lin dog_N = mkN "txakur" ;
lin door_N = mkN "ate" ;
lin drink_V2 = mkV2 "edan" ;
lin dry_A = mkA "lehor" ; --Apertium
lin dull_A = mkA "aspergarri" ; --Apertium
lin dust_N = mkN "hauts" ; --Apertium

----
-- E

lin ear_N = mkN "belarri" ; --Apertium
lin earth_N = mkN "lur" ; --Apertium
lin eat_V2 = mkV2 "jan" ; -- | mkV2 "bazkaldu" ; --Apertium
lin egg_N = mkN "arrautza" ; --Apertium
lin empty_A = mkA "huts" ; --| mkA "bakarti" ; --Apertium
lin enemy_N = mkN "etsai" ; --| mkN "arerio" ; --Apertium
lin eye_N = mkN "begi" ;

----
-- F

lin factory_N = mkN "fabrika" ; --| mkN "lantegi" ; --Apertium
lin fall_V = mkV "amildu" ; -- | mkV "erori" ; --Apertium
lin far_Adv = mkAdv "urrun" ;
lin fat_N = mkN "gantz" ; --| mkN "koipe" ; --Apertium
lin father_N2 = mkN2 "aita" ; --genitive
lin fear_V2 = ukanV "beldur" ; -- beldur nauzu `you are afraid of me'
lin fear_VS = izanV "beldur" ; -- beldur naiz [ez datorrela] `I'm afraid s/he won't come'
lin feather_N = mkN "luma" ; --Apertium
lin fight_V2 = mkV2 "borrokatu" ; --Apertium
lin find_V2 = mkV2 "aurkitu" ; -- | mkV2 "topatu" ; --Apertium
lin fingernail_N = mkN "azazkal" ; --Apertium
lin fire_N = mkN "su" ; --Apertium
lin fish_N = mkN "arrain" ; --Apertium
lin float_V = mkV "flotatu" ; --Apertium
lin floor_N = mkN "lurzoru" ; -- | mkN "solairu" ; --Apertium
lin flow_V = mkV "jariatu" ; --Apertium
lin flower_N = mkN "lore" ; --Apertium
lin fly_V = mkV "hegan" egin_V ; -- | mkV "pilotatu" ; --Apertium
lin fog_N = mkN "laino" ; --Apertium
lin foot_N = mkN "oin" ; --Apertium
lin forest_N = mkN "baso" ; --Apertium
lin forget_V2 = mkV2 "ahaztu" ; --Apertium
lin freeze_V = mkV "izoztu" ; --Apertium
lin fridge_N = mkN "elurtegi" ; --Apertium
lin friend_N = mkN "lagun" ; --| mkN "adiskide" ; --Apertium
lin fruit_N = mkN "fruta" ; --Apertium
lin full_A = mkA "bete" ; --Apertium
--lin fun_AV

----
-- G

lin garden_N = mkN "lorategi" ; --Apertium
lin girl_N  = mkN "neska" ;
lin give_V3 = mkV3 "eman" ; --Apertium
lin glove_N = mkN "eskularru" | mkN "eskularru" ; --Apertium
lin go_V = joan_V ; 
lin gold_N = mkN "urre" ; --Apertium
lin good_A = mkA "ongi" (mkA "on") ; -- Irregular adverb form
lin grammar_N = mkN "gramatika" ; --Apertium
lin grass_N = mkN "belar" ; --Apertium
lin green_A = mkA "berde" ; --Apertium

----
-- H

lin hair_N = mkN "ile" ; -- | mkN "adats" ; --Apertium
lin hand_N = mkN "esku" ; --Apertium
lin harbour_N = mkN "portu" ; --| mkN "kai" | mkN "mendate" ; --Apertium
lin hat_N = mkN "kapela" ; --Apertium
lin hate_V2 = mkV2 "gorrotatu" ; --Apertium
lin head_N = mkN "buru" ; --Apertium
lin hear_V2 = mkV2 "entzun" ; --Apertium
lin heart_N = mkN "bihotz" ; --Apertium
lin heavy_A = mkA "astun" ; --Apertium
lin hill_N = mkN "muino" ; --Apertium
lin hit_V2 = mkV2 "jo" ; --Apertium
lin hold_V2 = mkV2 "eutsi" ; --Apertium
lin hope_VS = lin VS (egonV "zain") ; --Apertium
lin horn_N = mkN "adar" ; --Apertium
lin horse_N = mkN "zaldi" ; --Apertium
lin hot_A = mkA "bero" ; --Apertium
lin house_N = mkN "etxe" ; --Apertium
lin hunt_V2 = mkV2 "ehizatu" ;
lin husband_N = mkN "senar" ; --Apertium

----
-- I

lin ice_N = mkN "izotz" ; --Apertium ; --Apertium
lin industry_N = mkN "industria" ; --Apertium
lin iron_N = mkN "burdina" ; -- | mkN "plantxa" ; --Apertium

--------
-- J - K

lin jump_V = mkV "jauzi" egin_V ; --Apertium
lin kill_V2 = mkV2 "hil" ; --Apertium
lin king_N = mkN "errege" ; --Apertium
lin knee_N = mkN "belaun" ; --Apertium
lin know_V2 = lin V2 jakin_V2 ; -- synthetic verb
lin know_VQ = lin VQ jakin_V2 ; -- synthetic verb

lin know_VS = ukanV "uste" ;


----
-- L

lin lake_N = mkN "aintzira" ; --Apertium
lin lamp_N = mkN "lanpara" ; --Apertium
lin language_N = mkN "hizkuntza" ; --Apertium
lin laugh_V = mkV "barre" egin_V ; --Apertium
lin leaf_N = mkN "orri" ; -- | mkN "hosto" ; --Apertium
lin learn_V2 = mkV2 "ikasi" ; --Apertium
lin leather_N = mkN "larru" ; --Apertium
lin leave_V2 = mkV2 "utzi" ; --| mkV2 "laga" ; --Apertium
lin leg_N = mkN "hanka" ; --Apertium
-- lin lie_V = mkV2 "gezur8erran" ; --Apertium
-- lin lie_V = mkV2 "gezurra8esan" ; --Apertium
--lin like_V2 = mkV2 "gustatu" ; --Apertium -- NOR-NORI
-- lin like_V2 = mkV2 "atsegin_izan" ; --Apertium
-- lin like_V2 = mkV2 "atsegin8izan<per>" ; --Apertium
-- lin like_V2 = mkV2 "gogoko8izan<per>" ; --Apertium
lin listen_V2 = mkV2 "entzun" ; --Apertium
lin live_V  = izanV "bizi" ;
lin liver_N = mkN "gibel" ; --Apertium
lin long_A = mkA "luze" ; --Apertium
lin lose_V2 = mkV2 "galdu" ; --Apertium
lin louse_N = mkN "zorri" ; --Apertium
lin love_N = mkN "maitasun" ; -- | mkN "amodio" ; --Apertium
lin love_V2 = ukanV "maite" ; 
lin man_N = mkN "gizon" animate ; --Apertium
lin meat_N = mkN "haragi" ; -- | mkN "mami" ; --Apertium
lin milk_N = mkN "esne" ; --Apertium
lin moon_N = mkN "ilargi" ; --Apertium
lin mother_N2 = mkN2 "ama" ;
lin mountain_N = mkN "mendi" ; --Apertium
lin mouth_N = mkN "aho" ; --Apertium
lin music_N = mkN "musika" ; --Apertium

----
-- N

lin name_N = mkN "izen" ; --Apertium
lin narrow_A = mkA "estu" ; --Apertium
lin near_A = mkA "hurbil" ; --Apertium
lin neck_N = mkN "lepo" ; --Apertium
lin new_A = mkA "berri" ; --Apertium
lin newspaper_N = mkN "egunkari" ; -- | mkN "kazeta" ; --Apertium
lin night_N = mkN "gau" ; --Apertium
lin nose_N = mkN "sudur" ; --Apertium
lin now_Adv = mkAdv "orain" ;
lin number_N = mkN "zenbaki" ; --Apertium

--------
-- O - P


lin oil_N = mkN "olio" ; --Apertium
lin old_A = mkA "zahar" ; --Apertium
lin open_V2 = mkV2 "ireki" ; -- | mkV2 "zabaldu" ; --Apertium
lin paint_V2A = mkV2A "margotu" ; -- | mkV2A "pintatu" ; --Apertium
lin paper_N = mkN "paper" ; --Apertium
lin paris_PN = mkPN "Paris" ; 
lin peace_N = mkN "bake" ; -- | mkN "sosegu" ; --Apertium
lin pen_N = mkN "boligrafo" ; --Apertium
lin person_N = mkN "pertsona" ; --| mkN "gizakume" | mkN "jende" ; --Apertium
lin planet_N = mkN "planeta" ; --Apertium
lin plastic_N = mkN "plastiko" ; --Apertium
lin play_V = mkV "jokatu" ; -- | mkV "jolastu" ; --Apertium
lin policeman_N = mkN "ertzain" ; --Apertium
lin priest_N = mkN "apaiz" ; -- | mkN "artzain" ; --Apertium -- FIXME: split 
lin pull_V2 = mkV2 "tenkatu" ; -- | mkV2 "tiratu" ; --Apertium
lin push_V2 = mkV2 "bultzatu" ; -- | mkV2 "estutu" ; --Apertium
lin put_V2 = mkV2 "ezarri" ; -- |  mkV2 "jarri" ; --Apertium

--------
-- Q - R

lin queen_N = mkN "erregina" ; --Apertium
lin question_N = mkN "galdera" ; --Apertium
lin radio_N = mkN "erradio" ; --| mkN "irrati" ; --Apertium
lin rain_N = mkN "euri" ; --Apertium
lin rain_V0 = mkV "euria ari" (mkV "edun") ; --Apertium
lin read_V2 = mkV2 "irakurri" ; --Apertium
lin ready_A = mkA "prest" ; --Apertium
lin reason_N = mkN "arrazoi" ; --| mkN "motibo" | mkN "zergati" ; --Apertium
lin red_A = mkA "gorri" ; --Apertium
lin religion_N = mkN "erlijio" ; --Apertium
lin restaurant_N = mkN "janetxe" ; --| mkN "jatetxe" ; --Apertium
lin river_N = mkN "ibai" ; --Apertium
lin road_N = mkN "kale" ; --| mkN "errepide" ; --Apertium
lin rock_N = mkN "harri" ; --| mkN "arroka" ; --Apertium
lin roof_N = mkN "teilatu" ; --| mkN "sabai" ; --Apertium
lin root_N = mkN "erro" ; --Apertium
lin rope_N = mkN "korda" ; --| mkN "soka" ; --Apertium
lin rotten_A = mkA "ustel" ; --Apertium
lin round_A = mkA "biribil" ; --Apertium
lin rub_V2 = mkV2 "igurtzi" ; --Apertium
lin rubber_N = mkN "goma" ; --Apertium
lin rule_N = mkN "arautegi" ; --| mkN "erregela" ; --Apertium
lin run_V = mkV "korritu" ; --Apertium

----
-- S 

lin salt_N = mkN "gatz" ; --Apertium
lin sand_N = mkN "harea" ; --Apertium
lin say_VS = mkVS "esan" ; --Apertium
lin school_N = mkN "eskola" ; --| mkN "ikastola" ; --Apertium
lin science_N = mkN "zientzia" ; --Apertium
lin scratch_V2 = mkV2 "urratu" ; --Apertium
lin sea_N = mkN "itsaso" ;
lin see_V2  = mkV2 "ikusi" ;
lin seed_N = mkN "hazi" ; --Apertium
lin seek_V2 = mkV2 "bilatu" ; --Apertium
lin sell_V3 = mkV3 "saldu" ; --Apertium
lin send_V3 = mkV3 "bidali" ; --| mkV3 "igorri" ; --Apertium
lin sew_V = mkV "josi" ; --Apertium
lin sharp_A = mkA "zorrotz" ; -- | mkA "sarkor" | mkA "zoli" ; --Apertium
lin sheep_N = mkN "ardi" ; --Apertium
lin ship_N = mkN "ontzi" ; --| mkN "itsasontzi" ; --Apertium
lin shirt_N = mkN "alkandora" ; --Apertium
lin shoe_N = mkN "zapata" ; --Apertium
lin shop_N = mkN "denda" ; --| mkN "saltoki" ; --Apertium
lin short_A = mkA "apal" ; --| mkA "baxu" | mkA "labur" | mkA "motz" ; --Apertium
lin silver_N = mkN "zilar" ; --Apertium
lin sing_V = mkV "kantatu" ; --Apertium
lin sister_N = mkN "aizpa" ; --| mkN "arreba" ; --Apertium -- FIXME: Depends on gender of 'possessor' 
lin sit_V = mkV "eseri" ; --| mkV "jarri" ; --Apertium
lin skin_N = mkN "larru" ; --Apertium
lin sky_N = mkN "zeru" ; --Apertium
lin sleep_V = mkV "lo" egin_V ;
lin small_A = mkA "txiki" ; --| mkA "apur" | mkA "xume" ; --Apertium
lin smell_V = izanV "usain" ; --Apertium
lin smoke_N = mkN "ke" ; --Apertium
lin smooth_A = mkA "leun" ; --| mkA "liso" ; --Apertium
lin snake_N = mkN "suge" ; --Apertium
lin snow_N = mkN "elur" ; --Apertium
lin sock_N = mkN "galtzetin" ; --Apertium
lin song_N = mkN "abesti" ; --| mkN "kanta" | mkN "kantu" ; --Apertium
lin speak_V2 = lin V2 (mkV "hitz" egin_V) ; --Apertium
lin spit_V = mkV "txistua bota" ; --Apertium
lin split_V2 = mkV2 "pitzatu" ; --| mkV2 "zatitu" ; --Apertium
lin squeeze_V2 = mkV2 "estutu" ; --Apertium
lin stab_V2 = mkV2 "sastatu" ; --Apertium
lin stand_V = mkV "egon" ; --| mkV "eutsi" | mkV "jarri" ; --Apertium
lin star_N = mkN "izar" ; --Apertium
lin steel_N = mkN "altzairu" ; --Apertium
lin stick_N = mkN "palo" ; --Apertium
lin stone_N = mkN "harri" ; --| mkN "hezur" ; --Apertium
lin stop_V =  mkV "gelditu" ; --| mkV "geratu" | mkV "atxilotu" | mkV "geldiarazi" ; --Apertium
lin stove_N = mkN "berogailu" ; --| mkN "sukalde" ; --Apertium
lin straight_A = mkA "zuzen" ; --Apertium
lin student_N = mkN "ikasle" ; --Apertium
lin stupid_A = mkA "ergel" ; -- | mkA "tonto" ; --Apertium
lin suck_V2 = mkV2 "edoski" ; --|  mkV2 "xurgatu" | mkV2 "zupatu" ; --Apertium
lin sun_N = mkN "eguzki" ; --Apertium
lin swell_V = mkV "handitu" ; --Apertium
lin swim_V = mkV "igeri" egin_V ; --Apertium

----
-- T


lin table_N = mkN "mahai" ; --| mkN "taula" ; --Apertium
lin tail_N = mkN "buztan" ; --| mkN "kola" ; --Apertium
lin talk_V3 = mkV3 "mintzatu" ; --Apertium
lin teach_V2 = mkV2 "erakutsi" ; --| mkV2 "irakatsi" ; --Apertium
lin teacher_N = mkN "irakasle" ; --Apertium 
lin television_N = mkN "telebista" ; --Apertium
lin thick_A = mkA "lodi" ; --Apertium
lin thin_A = mkA "argal" ; -- | mkA "mehe" ; --Apertium
lin think_V = mkV "iritzi" ; --| mkV "pentsatu" ; --Apertium
lin throw_V2 = mkV2 "aurtiki" ; -- | mkV2 "jaurti" | mkV2 "tiratu" ; --Apertium
lin tie_V2 = mkV2 "lotu" ; --Apertium
lin today_Adv = mkAdv "gaur" ;
lin tongue_N = mkN "mihi" ; --| mkN "mizto" ; --Apertium
lin tooth_N = mkN "hortz" ; --Apertium
lin train_N = mkN "tren" ; --Apertium
lin travel_V = mkV "bidaiatu" ; --Apertium
lin tree_N = mkN "zuhaitz" ; --Apertium
lin turn_V = mkV "biratu" ; --| mkV "jiratu" ; --Apertium

--------
-- U - V

lin ugly_A = mkA "itsusi" ; --Apertium
lin uncertain_A = mkA "gezur" ; --Apertium
lin understand_V2 = mkV2 "aditu" ; --| mkV2 "ulertu" ; --Apertium
lin university_N = mkN "unibertsitate" ; --Apertium
lin village_N = mkN "herrixka" ; --Apertium
lin vomit_V = mkV2 "oka" egin_V ; --Apertium

--------
-- W - Y

lin wait_V2 = mkV2 "itxaron" ; --| mkV2 "zain egon" ; --Apertium
lin walk_V = ibili_V ; --Apertium
lin war_N = mkN "gerra" ; --Apertium
lin warm_A = mkA "bero" ; --Apertium
lin wash_V2 = mkV2 "garbitu" ; --Apertium
lin watch_V2 = mkV2 "begiratu" ; --Apertium
lin water_N = mkN "ura" ; --Definite form is ura, not urra ('hazelnut')
lin wet_A = mkA "busti" ; --Apertium
lin white_A = mkA "zuri" ; --| mkA "txuri" ; --Apertium
lin wide_A = mkA "zabal" ; --Apertium
lin wife_N = mkN "emazte" ; --Apertium
lin win_V2 = mkV2 "garaitu" ; --| mkV2 "irabazi" ; --Apertium
lin wind_N = mkN "haize" ; --Apertium
lin window_N = mkN "leiho" ;
lin wine_N = mkN "ardo" ; --Apertium
lin wing_N = mkN "hegal" ; --Apertium
lin wipe_V2 = mkV2 "garbitu" ; --Apertium
lin woman_N = mkN "emakume" animate ;
lin wonder_VQ = mkVQ "galdetu" ; -- galdetu = ask
lin wood_N = mkN "zur" ; --| mkN "baso" ; --Apertium -- leña, bosque 
lin worm_N = mkN "har" ; --| mkN "zizare" ; --Apertium
lin write_V2 = mkV2 "idatzi" ; --Apertium
lin year_N = mkN "urte" ; --| mkN "urtebete" ; --Apertium
lin yellow_A = mkA "hori" ; --Apertium
lin young_A = mkA "gazte" ; --Apertium




oper

  egin_V : V = mkV "egin" ;

  -- Some synthetic verbs
  etorri_V : R.Verb = R.syntVerbDa "etorri" R.Etorri ;

  ibili_V : R.Verb = R.syntVerbDa "ibili" R.Ibili ;

  jakin_V2 : R.Verb = R.syntVerbDu "jakin" R.Jakin ;

  joan_V : R.Verb = R.syntVerbDa "joan" R.Joan ;
}