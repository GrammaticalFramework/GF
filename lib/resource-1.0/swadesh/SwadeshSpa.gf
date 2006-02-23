--# -path=.:../spanish:../common:../abstract:../../prelude:../romance

concrete SwadeshSpa of Swadesh = CatSpa
  ** open PhonoSpa, MorphoSpa, LangSpa, ParadigmsSpa, BeschSpa, Prelude in {

-- words contributed by Ana Bove, May 2005

  lin

    -- Pronouns

    i_NP = i_Pron ;
    youSg_NP = youSg_Pron ;
    he_NP = he_Pron ;
    we_NP = we_Pron ;
    youPl_NP = youPl_Pron ;
    they_NP = they_Pron ;
    whoPl_IP = whoPl_IP ;
    whoSg_IP = whoSg_IP ;
    whatPl_IP = whatPl_IP ;
    whatSg_IP = whatSg_IP ;

    -- Determiners

    this_Det = DetSg (SgQuant this_Quant) NoOrd ;
    that_Det = DetSg (SgQuant that_Quant) NoOrd ;
    all_Det  = {
      s = \\g,c => prepCase c ++ genForms ["todos los"] ["todas las"] ! g ;
      n = Pl
      } ;
    many_Det = many_Det ;
    some_Det = someSg_Det ;
    few_Det  = {s = \\g,c => prepCase c ++ genForms "pocos" "pocas" ! g ; n = Pl} ;
    other_Det = {
      s = \\g,c => prepCase c ++ genForms "otros" "otras" ! g ;
      n = Pl
      } ;

    -- Adverbs

    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;
    far_Adv = mkAdv "lejos" ; ----?

    -- not : Adv ; -- ?

    -- Conjunctions

    and_Conj = and_Conj ;

    -- Prepositions

    at_Prep = dative ;
    in_Prep = in_Prep ;
    with_Prep = with_Prep ;

    -- Numerals

    one_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 pot01)))) ;
    two_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n2))))) ;
    three_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n3))))) ;
    four_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n4))))) ;
    five_Num = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n5))))) ;


    -- Adjectives

     bad_A = bad_A ;
     big_A = big_A ;
     black_A = black_A ;
     cold_A = cold_A ;
     correct_A = regA "correcto" ;
     dirty_A = dirty_A ;
     dry_A = regA "seco" ;
     dull_A = regA "desafilado" ;
     full_A = regA "lleno" ;
     good_A = good_A ;
     green_A = green_A ;
     heavy_A = regA "pesado" ;
     long_A = long_A ;
     narrow_A = narrow_A ;
     near_A = regA "cerca" ;
     new_A = new_A ;
     old_A = old_A ;
     red_A = red_A ;
     rotten_A = regA "podrido" ;
     round_A = regA "redondo" ;
     sharp_A = regA "filoso" ; -- afilado, puntiagudo
     short_A = short_A ;
     small_A = small_A ;
     smooth_A = regA "liso" ;	-- suave
     straight_A = regA "directo" ;
     thick_A = thick_A ;
     thin_A = thin_A ;
     warm_A = warm_A ;
     wet_A = regA "mojado" ;
     white_A = white_A ;
     wide_A = regA "ancho" ;	-- extenso
     yellow_A = yellow_A ;

     left_A = regA "izquierda" ;
     right_A = regA "derecha" ;

     -- Nouns

     animal_N = regN "animal" ;		-- masc (sometimes fem when adj)
     ashes_N = regN "ceniza" ;
     back_N = regN "espalda" ;
     bark_N = regN "corteza" ;
     belly_N = regN "panza" ;		-- barriga
     bird_N = bird_N;
     blood_N = femN (regN "sangre") ;
     bone_N = regN "hueso" ;
     breast_N = regN "seno" ;		-- pecho
     child_N = child_N ;
     cloud_N = femN (regN "nube") ;
     day_N = mascN (regN "día") ;
     dog_N = dog_N ;
     dust_N = regN "polvo" ;
     ear_N = regN "oreja" ;
     earth_N = regN "tierra" ;
     egg_N = regN "huevo" ;
     eye_N = regN "ojo" ;
     fat_N = regN "grasa" ;
     father_N = UseN2 father_N2 ;
     feather_N = regN "pluma" ;
     fingernail_N = regN "uña" ;
     fire_N = regN "fuego" ;
     fish_N = fish_N ;
     flower_N = femN (regN "flor") ;
     fog_N = regN "niebla" ;
     foot_N = regN "pie" ;
     forest_N = regN "bosque" ;
     fruit_N = fruit_N ;
     grass_N = regN "pasto" ;		-- hierba, césped (masc)
     guts_N = regN "tripa" ;		-- gut=intestino ---- pl.t. tripas
     hair_N = regN "cabello" ;		-- pelo
     hand_N = femN (regN "mano") ;
     head_N = regN "cabeza" ;
     heart_N = mkN "corazón" "corazones" masculine ;
     horn_N = regN "cuerno" ;
     husband_N = regN "marido" ;	-- esposo
     ice_N = regN "hielo" ;
     knee_N = regN "rodilla" ;
     lake_N = lake_N ;
     leaf_N = regN "hoja" ;
     leg_N = regN "pierna" ;
     liver_N = regN "hígado" ;
     louse_N = regN "piojo" ;
     man_N = man_N ;
     meat_N = meat_N ;
     moon_N = moon_N ;
     mother_N = UseN2 mother_N2 ;
     mountain_N = mountain_N ;
     mouth_N = regN "boca" ;
     name_N = regN "nombre" ;
     neck_N = regN "cuello" ;
     night_N = femN (regN "noche") ;
     nose_N = femN (regN "nariz") ;
     person_N = regN "persona" ;
     rain_N = regN "lluvia" ;
     river_N = river_N ;
     road_N = femN (regN "calle") ;		-- camino
     root_N = femN (regN "raíz") ;
     rope_N = regN "cuerda" ;
     salt_N = femN (regN "sal") ;
     sand_N = regN "arena" ;
     sea_N = sea_N ;
     seed_N = regN "semilla" ;
     skin_N = femN (regN "piel") ;	-- fem
     sky_N = regN "cielo" ;
     smoke_N = regN "humo" ;
     snake_N = snake_N ;
     snow_N = femN (regN "nieve") ;	-- fem
     star_N = star_N ;
     stick_N = mkN "bastón" "bastones" masculine ;		-- palo
     stone_N = stone_N ;
     sun_N = sun_N ;
     tail_N = regN "cola" ;
     tongue_N = regN "lengua" ;
     tooth_N = regN "diente" ;
     tree_N = tree_N ;
     water_N = water_N ;
     wife_N = regN "esposa" ;
     wind_N = regN "viento" ;
     wing_N = regN "ala" ;
     woman_N = woman_N ;
     worm_N = regN "gusano" ;		-- lombriz (fem)
     year_N = regN "año" ;

     -- Verbs

    bite_V = dirV2 (verboV (morder_50b "morder")) ;
     blow_V = regV "soplar" ;
    breathe_V = dirV2 (regV "respirar") ;
     burn_V = regV "quemar" ;
     come_V = come_V ;
    count_V = dirV2 (verboV (contar_38b "contar")) ;
    cut_V = dirV2 (regV "cortar") ;
     die_V = die_V ;
     dig_V = regV "escarbar" ;
    drink_V = dirV2 (regV "tomar") ;
    eat_V = dirV2 (regV "comer") ;
     fall_V = verboV (caer_20 "caer") ;
    fear_V = dirV2 (fear_VS) ;
    fight_V = dirV2 (regV "pelear") ;
     float_V = regV "flotar" ;
     flow_V = verboV (influir_45 "fluir") ;             -- circular
     fly_V = regV "volar" ;
     freeze_V = regV "congelar" ;
     give_V = dirdirV3 (verboV (dar_27 "dar")) ;
    hear_V = dirV2 (hear_V2) ;
    hit_V = dirV2 (regV "golpear") ;
    hold_V = dirV2 (verboV (tener_4 "tener")) ; 
    hunt_V = dirV2 (regV "cazar") ;
    kill_V = dirV2 (regV "matar") ;
    know_V = dirV2 (know_V2) ;
     laugh_V = regV "reir" ; ----V reír_67
     lie_V = reflV (regV "acostar") ; --  "acostarse"
     live_V = live_V ;
     play_V = regV "jugar" ;
    pull_V = dirV2 (regV "tirar") ;
    push_V = dirV2 (regV "empujar") ;
    rub_V = dirV2 (regV "resfregar") ;
     say_V = say_VS ;
    scratch_V = dirV2 (regV "rascar") ;
    see_V = dirV2 (see_V2) ;
     sew_V = regV "coser" ;
     sing_V = regV "cantar" ;
     sit_V = reflV (regV "sentar") ;
     sleep_V = sleep_V ;
    smell_V = dirV2 (verboV (oler_52 "oler")) ;
     spit_V = regV "escupir" ;
    split_V = dirV2 (regV "separar") ; -- dividir,) ;
    squeeze_V = dirV2 (regV "exprimir") ;
    stab_V = dirV2 (regV "apuñalar") ;
     stand_V = verboV (estar_2 "estar") ; ---- "estar de pie" ;
    suck_V = dirV2 (regV "chupar") ;
     swell_V = regV "tragar" ;
     swim_V = regV "nadar" ;
     think_V = regV "pensar" ;
    throw_V = dirV2 (regV "tirar") ;
    tie_V = dirV2 (regV "atar") ;
     turn_V = regV "doblar" ;
     vomit_V = regV "vomitar" ;
     walk_V = regV "caminar" ;
    wash_V = dirV2 (regV "lavar") ;
    wipe_V = dirV2 (regV "secar") ;

}
