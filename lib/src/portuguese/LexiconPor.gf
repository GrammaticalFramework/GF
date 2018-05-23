--# -path=.:../romance:../common:../abstract:../../prelude

concrete LexiconPor of Lexicon = CatPor ** open
  (M=MorphoPor), ParadigmsPor, BeschPor, Prelude in {

flags
  optimize=values ;
  coding=utf8 ;

lin
   easy_A2V = mkA2V (mkA "fácil") dative genitive ;
   married_A2 = mkA2 (mkA "casado") dative ;
   probable_AS = mkAS (mkA "provável") ;
   fun_AV = mkAV (mkA "divertido") genitive ;
   -- A
   bad_A       = prefA (mkA (mkA "mau") (mkA "pior")) ;
   beautiful_A = prefA (mkA "belo") ;    -- bela
   big_A       = prefA (mkA "grande") ;
   black_A     = mkA "preto" ;	-- preta
   blue_A      = mkA "azul" ;
   broad_A     = mkA "largo" ;
   brown_A     = mkA "marrom" ; --- *
   clean_A     = mkA "limpo" ;
   clever_A    = mkA "inteligente" ;
   cold_A      = mkA "frio" ;		-- fria
   correct_A   = mkA "correto" | mkA "correcto" ;
   dirty_A     = mkA "sujo" ;
   dry_A       = mkA "seco" ;
   dull_A      = mkA "desafilado" ;
   empty_A     = mkA "vazio" ;
   full_A      = mkA "cheio" ;
   good_A      = prefA (mkA (mkA "bom") (mkA "melhor")) ; ---- adv?
   green_A     = mkA "verde" ;
   heavy_A     = mkA "pesado" ;
   hot_A       = mkA "quente" ;
   important_A = mkA "importante" ;
   long_A      = mkA "longo" ;
   narrow_A    = mkA "estreito" ;
   near_A      = mkA "perto" ;
   new_A       = prefA (mkA "novo") ;
   old_A       =  prefA (mkA "velho") ;
   ready_A     = mkA "pronto" ;
   red_A       = mkA "vermelho" ;
   rotten_A    = mkA "podre" ;
   round_A     = mkA "redondo" ;
   sharp_A     = mkA "afiado" ; -- pontiagudo
   short_A     = mkA "curto" ; --- breve, pequeno, baixo
   small_A     = prefA (mkA "pequeno") ;
   smooth_A    = mkA "liso" ;     -- suave
   straight_A  = mkA "direto" | mkA "directo" ; -- reto
   stupid_A    = mkA "estúpido" ;
   thick_A     = mkA "grosso" ;
   thin_A      = mkA "fino" ; -- delgado, magro
   ugly_A      = mkA "feio" ;
   uncertain_A = mkA "incerto" ;
   warm_A      = mkA "quente" ;
   wet_A       = mkA "molhado" ;
   white_A     = compADeg (mkA "branco") ;
   wide_A      = mkA "largo" ; -- extenso
   yellow_A    = mkA "amarelo" ;
   young_A     = prefA (mkA "jovem" "jovem" "jovens" "jovens" "juvenilmente") ;
   already_Adv = mkAdv "já" ;
   far_Adv = mkAdv "longe" ; ----?
   now_Adv = mkAdv "agora" ;
   today_Adv = mkAdv "hoje" ;
   brother_N2 = deN2 (mkN "irmão") ;
   father_N2 = deN2 (mkN "pai") ;
   mother_N2 = deN2 (mkN "mãe" feminine) ;
   distance_N3 = mkN3 (mkN "distância") genitive dative ;
   -- N
   airplane_N   = mkN "avião" masculine ; -- is masculine
   animal_N     = mkN "animal" ; -- masc (sometimes fem when adj)
   apartment_N  = mkN "apartamento" ;
   apple_N      = mkN "maçã" "maçãs" ;
   art_N        = mkN "arte" feminine ;
   ashes_N      = mkN "cinza" ;
   baby_N       = mkN "bebê" ;		-- can be used for both fem. & masc.
   back_N       = mkN "costas" "costas" feminine ;
   bank_N       = mkN "banco" ;
   bark_N       = mkN "casca" ;
   beer_N       = mkN "cerveja" ;
   belly_N      = mkN "barriga" ;
   bike_N       = mkN "bicicleta" ;
   bird_N       = mkN "pássaro" ;
   blood_N      = mkN "sangue" nonExist ;
   boat_N       = mkN "bote" ;
   bone_N       = mkN "osso" ;
   book_N       = mkN "livro" ;
   boot_N       = mkN "bota" ;
   boss_N       = mkN "chefe"; -- Fem can be both "chefa" or "chefe" ;
   boy_N        = mkN "menino" ;
   bread_N      = mkN "pão" "pães" masculine ;
   breast_N     = mkN "seio" ;             -- pecho
   butter_N     = mkN "manteiga" ;
   camera_N     = mkN "câmera" ; -- ["máquina fotográfica"]
   cap_N        = mkN "gorro" ;
   car_N        = mkN "carro" ;
   carpet_N     = mkN "tapete" ;
   cat_N        = mkN "gato" ;		-- gata
   ceiling_N    = mkN "teto" ;
   chair_N      = mkN "cadeira" ;
   cheese_N     = mkN "queijo" ;
   child_N      = mkN "criança" ;
   church_N     = mkN "igreja" ;
   city_N       = mkN "cidade" feminine ;
   cloud_N      = mkN "nuvem" feminine ;
   coat_N       = mkN "abrigo" ;
   computer_N   = mkN "computador" ;
   country_N    = mkN "país" ;		-- masc
   cousin_N     = mkN "primo" ;
   cow_N        = mkN "vaca" ;
   day_N        = mkN "dia" masculine ;
   doctor_N     = mkN "médico" ;		-- médica
   dog_N        = mkN "cachorro" ;		-- cadela
   door_N       = mkN "porta" ;
   dust_N       = mkN "poeira" nonExist ;
   ear_N        = mkN "orelha" ;
   earth_N      = mkN "terra" ;
   egg_N        = mkN "ovo" ;
   enemy_N      = mkN "inimigo" ;		-- inimiga
   eye_N        = mkN "olho" ;
   factory_N    = mkN "fábrica" ;
   fat_N        = mkN "gordura" ;
   feather_N    = mkN "pena" ;
   fingernail_N = mkN "unha" ;
   fire_N       = mkN "fogo" ;
   fish_N       = mkN "peixe" ;
   floor_N      = mkN "chão" nonExist ; -- piso
   flower_N     = mkN "flor" feminine ;
   fog_N        = mkN "névoa" ;
   foot_N       = mkN "pé" ;
   forest_N     = mkN "floresta" ;
   fridge_N     = mkN "geladeira" ;
   friend_N     = mkN "amigo" ;		-- amiga
   fruit_N      = mkN "fruta" ;
   garden_N     = mkN "jardim" ;
   girl_N       = mkN "menina" ;
   glove_N      = mkN "luva" ;
   gold_N       = mkN "ouro" nonExist ;
   grammar_N    = mkN "gramática" ;
   grass_N      = mkN "grama" nonExist ;
   guts_N       = mkN "tripa" ;
   hair_N       = mkN "cabelo" nonExist ;
   hand_N       = mkN "mão" "mãos" feminine ;
   harbour_N    = mkN "porto" ;
   hat_N        = mkN "chapéu" ;
   head_N       = mkN "cabeça" ;
   heart_N      = mkN "coração" masculine ;
   hill_N       = mkN "morro" ; -- colina
   horn_N       = mkN "chifre" ;
   horse_N      = mkN "cavalo" ;
   house_N      = mkN "casa" ;
   husband_N    = mkN "marido" ;  -- esposo
   ice_N        = mkN "gelo" ;
   industry_N   = mkN "indústria" ;
   iron_N       = mkN "ferro" ;
   king_N       = mkN "rei" ;
   knee_N       = mkN "joelho" ;
   lake_N       = mkN "lago" ;
   lamp_N       = mkN "lâmpada" ;
   language_N   = mkN "linguagem" ;
   leaf_N       = mkN "folha" ;
   leather_N    = mkN "couro" nonExist ;
   leg_N        = mkN "perna" ;
   liver_N      = mkN "fígado" ;
   louse_N      = mkN "piolho" ;
   love_N       = mkN "amor" ;
   man_N        = mkN "homem" ;		-- masc
   meat_N       = mkN "carne" feminine ;
   milk_N       = mkN "leite" ;
   moon_N       = mkN "lua" ;
   mountain_N   = mkN "montanha" ;
   mouth_N      = mkN "boca" ;
   music_N      = mkN "música" ;
   name_N       = mkN "nome" ;
   neck_N       = mkN "pescoço" ;
   newspaper_N  = mkN "jornal" ;
   night_N      = mkN "noite" feminine ;
   nose_N       = mkN "nariz" ;
   number_N     = mkN "número" ;
   oil_N        = mkN "óleo" ;
   paper_N      = mkN "papel" ;
   peace_N      = mkN "paz" feminine ;
   pen_N        = mkN "caneta" ;
   person_N     = mkN "pessoa" ;
   planet_N     = mkN "planeta" masculine ;
   plastic_N    = mkN "plástico" ;
   policeman_N  = mkN "policial" ;
   priest_N     = mkN "padre" ;		-- masc
   queen_N      = mkN "rainha" ;
   question_N   = mkN "pergunta" ;
   radio_N      = mkN "rádio" ;
   rain_N       = mkN "chuva" ;
   reason_N     = mkN "razão" ;
   religion_N   = mkN "religião" ;
   restaurant_N = mkN "restaurante" ;
   river_N      = mkN "rio" ;
   road_N       = mkN "estrada" ;
   rock_N       = mkN "rocha" ;
   roof_N       = mkN "telhado" ;
   root_N       = mkN "raiz" feminine ;
   rope_N       = mkN "corda" ;
   rubber_N     = mkN "borracha" ;
   rule_N       = mkN "regra" ;
   salt_N       = mkN "sal" ;
   sand_N       = mkN "areia" nonExist ;
   school_N     = mkN "escola" ;
   science_N    = mkN "ciência" ;
   sea_N        = mkN "mar" ;
   seed_N       = mkN "semente" ;
   sheep_N      = mkN "ovelha" ;
   ship_N       = mkN "navio" ;
   shirt_N      = mkN "camisa" ;
   shoe_N       = mkN "sapato" ;
   shop_N       = mkN "loja" ;
   silver_N     = mkN "prata" nonExist ;
   sister_N     = mkN "irmã" ;
   skin_N       = mkN "pele" feminine ;
   sky_N        = mkN "céu" ;
   smoke_N      = mkN "fumaça" nonExist ;
   snake_N      = mkN "cobra" ;
   snow_N       = mkN "neve" nonExist feminine ;
   sock_N       = mkN "meia" ;
   song_N       = mkN "canção" "canções" feminine ;
   star_N       = mkN "estrela" ;
   steel_N      = mkN "aço" nonExist ;
   stick_N      = mkN "bastão" "bastões" ;
   stone_N      = mkN "pedra" ;
   stove_N      = mkN "forno" ;
   student_N    = mkN "estudante" ;	-- used both for fem & masc
   sun_N        = mkN "sol" ;
   table_N      = mkN "mesa" ;
   tail_N       = mkN "rabo" ;
   teacher_N    = mkN "professor" ;
   television_N = mkN "televisão" ;
   tongue_N     = mkN "língua" ;
   tooth_N      = mkN "dente" ;
   train_N      = mkN "trem" ;
   tree_N       = mkN "árvore" feminine ;
   university_N = mkN "universidade" ;
   village_N    = mkN "vila" ;
   war_N        = mkN "guerra" ;
   water_N      = mkN "água" ;
   wife_N       = mkN "esposa" ;
   wind_N       = mkN "vento" ;
   window_N     = mkN "janela" ;
   wine_N       = mkN "vinho" ;
   wing_N       = mkN "asa" ;
   woman_N      = mkN "mulher" feminine ;
   wood_N       = mkN "madeira" ;
   worm_N       = mkN "verme" ;             -- lombriga (Fem)
   year_N       = mkN "ano" ;
   left_Ord = M.mkOrd (regA "esquerda") ;
   right_Ord = M.mkOrd (regA "direita") ;
   john_PN = mkPN "João" masculine ;
   paris_PN = mkPN "Paris" feminine ;
   -- V
   rain_V0 = mkV0 (mkV (chover_Besch "chover")) ;
   paint_V2A = mkV2A (mkV "pintar") accusative (mkPrep "em") ;
   ask_V2Q = mkV2Q (mkV "perguntar") dative ;
   answer_V2S = mkV2S (mkV "responder") dative ;
   beg_V2V = mkV2V (mkV "rogar") accusative dative ;   -- pedir
   bite_V2       = dirV2 (mkV "morder") ;
   break_V2      = dirV2 (mkV "quebrar") ;
   buy_V2        = dirV2 (mkV "comprar") ;
   close_V2      = dirV2 (mkV "fechar") ;
   count_V2      = dirV2 (mkV "contar") ;
   cut_V2        = dirV2 (mkV "cortar") ;
   do_V2         =  dirV2 (mkV (fazer_Besch "fazer")) ;
   drink_V2      = dirV2 (mkV "beber") ;
   eat_V2        = dirV2 (mkV "comer") ;
   fear_V2       = dirV2 (mkV "temer") ;
   fight_V2      = dirV2 (mkV "lutar") ;
   find_V2       = dirV2 (mkV "encontrar") ;
   forget_V2     = dirV2 (mkV "esquecer") ;
   hate_V2       = dirV2 (mkV (odiar_Besch "odiar")) ;
   hear_V2       = dirV2 (mkV "ouvir") ;
   hit_V2        = dirV2 (mkV "bater") ;
   hold_V2       = dirV2 (mkV (ter_Besch "ter")) ;
   hunt_V2       = dirV2 (mkV "caçar") ;
   kill_V2       = dirV2 (mkV "matar") ;
   know_V2       = mkV2 (mkV "conhecer") ;
   learn_V2      = dirV2 (mkV "aprender") ;
   leave_V2      = dirV2 (mkV "partir") ;
   like_V2       = mkV2 (mkV "gostar") genitive ;
   listen_V2     = dirV2 (mkV "escutar") ;
   lose_V2       = dirV2 (mkV (perder_Besch "perder")) ;
   love_V2       = dirV2 (mkV "amar") ;
   open_V2       = dirV2 (special_ppV (mkV "abrir") "aberto") ;
   play_V2       = dirV2 (mkV "jogar") ;
   pull_V2       = dirV2 (mkV "tirar") ;
   push_V2       = dirV2 (mkV "empurrar") ;
   put_V2        = dirV2 (mkV (pôr_Besch "pôr")) ;
   read_V2       = dirV2 (mkV (ler_Besch "ler")) ;
   rub_V2        = dirV2 (mkV "esfregar") ;
   scratch_V2    = dirV2 (mkV "coçar") ;
   see_V2        = dirV2 (mkV (ver_Besch "ver")) ;
   seek_V2       = dirV2 (mkV "buscar") ;
   speak_V2      = dirV2 (mkV "falar") ;
   split_V2      = dirV2 (mkV "separar") ; -- dividir,) ;
   squeeze_V2    = dirV2 (mkV "apertar") ;
   stab_V2       = dirV2 (mkV "esfaquear") ;
   suck_V2       = dirV2 (mkV "chupar") ;
   switch8off_V2 = dirV2 (mkV "apagar") ;
   switch8on_V2  = dirV2 (mkV "ligar") ; -- acender
   teach_V2      = dirV2 (mkV "ensinar") ;
   throw_V2      = dirV2 (mkV "jogar") ;
   tie_V2        = dirV2 (mkV "atar") ;
   understand_V2 = dirV2 (mkV "entender") ;
   wait_V2       = mkV2 (mkV "esperar") dative ;
   wash_V2       = dirV2 (mkV "lavar") ;
   watch_V2      = dirV2 (mkV "ver") ;		-- ver
   win_V2        = dirV2 (mkV "ganhar") ;
   wipe_V2       = dirV2 (mkV "remover") ;
   write_V2      = dirV2 (special_ppV (mkV "escrever") "escrito") ;
   add_V3 = dirV3 (mkV "somar") dative ;
   give_V3 = dirdirV3 (mkV (dar_Besch "dar")) ;
   sell_V3 = dirV3 (mkV "vender") dative ;
   send_V3 = dirV3 (mkV "enviar") dative ; -- mandar
   talk_V3 = mkV3 (mkV "falar") dative genitive ;
   become_VA = reflV (mkV "virar") ;  --- convertirse en, volverse, ponerse
   know_VQ = mkVQ (mkV "saber") ;
   wonder_VQ = mkVQ (reflV (mkV "perguntar")) ;
   fear_VS = mkVS (mkV "temer") ;
   hope_VS = mkVS (mkV "esperar") ;
   know_VS = mkVS (mkV "saber") ;
   say_VS = mkVS (mkV "dizer") ;
   -- V
   blow_V    = mkV "assoprar" ;
   breathe_V = mkV "respirar" ;
   burn_V    = mkV "queimar" ;
   come_V    = mkV (vir_Besch "vir") ;
   die_V     = mkV "morrer" ;
   dig_V     = mkV "escavar" ;
   fall_V    = mkV "cair" ;
   float_V   = mkV "flutuar" ;
   flow_V    = mkV "fluir" ; -- circular
   fly_V     = mkV "voar" ;
   freeze_V  = mkV "congelar" ;
   go_V      = (mkV "ir") ;
   jump_V    = mkV "saltar" ;
   laugh_V   = mkV (rir_Besch "rir") ;
   lie_V     = reflV (mkV "mentir") ;
   live_V    = mkV "viver" ;
   play_V    = mkV "jogar" ;
   run_V     = mkV "correr" ;
   sew_V     = mkV "costurar" ;
   sing_V    = mkV "cantar" ;
   sit_V     = reflV (mkV "sentar") ;
   sleep_V   = mkV "dormir" ;
   smell_V   = mkV "cheirar" ;
   spit_V    = mkV "cuspir" ;
   stand_V   = mkV (estar_Besch "estar") ; ---- "estar de pé" ;
   stop_V    = mkV "parar" ;
   swell_V   = mkV "tragar" ;
   swim_V    = mkV "nadar" ;
   think_V   = mkV "pensar" ;
   travel_V  = mkV "viajar" ;
   turn_V    = mkV "virar" ;
   vomit_V   = mkV "vomitar" ;
   walk_V    = mkV "caminhar" ;
   -- interj
   alas_Interj = ss "infelizmente" ;
} ;
