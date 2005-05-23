--# -path=.:../abstract:../../prelude:../romance

concrete SwadeshLexSpa of SwadeshLex = CategoriesSpa 
  ** open StructuralSpa, RulesSpa, SyntaxSpa, ParadigmsSpa,
          BasicSpa, BeschSpa, Prelude in {

-- words contributed by Ana Bove, May 2005

  lin

    -- Pronouns

    i_NP = i_NP ;
    thou_NP = thou_NP ;
    he_NP = he_NP ;
    we_NP = we_NP ;
    you_NP = you_NP ;
    they_NP = they_NP ;
    who8many_IP = who8many_IP ;
    who8one_IP = who8one_IP ;
    what8many_IP = what8many_IP ;
    what8one_IP = what8one_IP ;

    -- Determiners

    this_Det = this_Det ;
    that_Det = that_Det ;
    all_NDet = all_NDet ;
    many_Det = many_Det ;
    some_Det = some_Det ;
    few_Det = mkDeterminer Pl "pocos" "pocas" ;
    other_Det = mkDeterminer Pl "otros" "otras" ;


    -- Adverbs

    here_Adv = here_Adv;
    there_Adv = there_Adv;
    where_IAdv = where_IAdv;
    when_IAdv = when_IAdv;
    how_IAdv = how_IAdv;

    -- not : Adv ; -- ?

    -- Conjunctions

    and_Conj = and_Conj ;

    -- Prepositions

    at_Prep = justCase dative.p1 ;
    in_Prep = StructuralSpa.in_Prep ;
    with_Prep = StructuralSpa.with_Prep ;

    -- Numerals

    one_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 pot01)))) ;
    two_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n2))))) ;
    three_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n3))))) ;
    four_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n4))))) ;
    five_Num = UseNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n5))))) ;


    -- Adjectives

     bad_ADeg = bad_ADeg ;
     big_ADeg = big_ADeg ;
     black_ADeg = black_ADeg ;
     cold_ADeg = cold_ADeg ;
     correct_ADeg = regADeg "correcto" ;
     dirty_ADeg = dirty_ADeg ;
     dry_ADeg = regADeg "seco" ;
     dull_ADeg = regADeg "desafilado" ;
     far_ADeg = regADeg "lejos" ; ----?
     full_ADeg = regADeg "lleno" ;
     good_ADeg = good_ADeg ;
     green_ADeg = green_ADeg ;
     heavy_ADeg = regADeg "pesado" ;
     long_ADeg = long_ADeg ;
     narrow_ADeg = narrow_ADeg ;
     near_ADeg = regADeg "cerca" ;
     new_ADeg = new_ADeg ;
     old_ADeg = old_ADeg ;
     red_ADeg = red_ADeg ;
     rotten_ADeg = regADeg "podrido" ;
     round_ADeg = regADeg "redondo" ;
     sharp_ADeg = regADeg "filoso" ; -- afilado, puntiagudo
     short_ADeg = short_ADeg ;
     small_ADeg = small_ADeg ;
     smooth_ADeg = regADeg "liso" ;	-- suave
     straight_ADeg = regADeg "directo" ;
     thick_ADeg = thick_ADeg ;
     thin_ADeg = thin_ADeg ;
     warm_ADeg = warm_ADeg ;
     wet_ADeg = regADeg "mojado" ;
     white_ADeg = white_ADeg ;
     wide_ADeg = regADeg "ancho" ;	-- extenso
     yellow_ADeg = yellow_ADeg ;

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
     heart_N = regN "corazón" ;
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
     stick_N = regN "bastón" ;		-- palo
     stone_N = stone_N ;
     sun_N = sun_N ;
     tail_N = regN "cola" ;
     tongue_N = regN "lengua" ;
     tooth_N = regN "diente" ;
     tree_N = tree_N ;
     water_N = water_N ;
     wife_N = regN "esposa" ;
     wind_N = regN "viento" ;
     wing_N = mascN (regN "ala") ;		-- masc, pl is fem
     woman_N = woman_N ;
     worm_N = regN "gusano" ;		-- lombriz (fem)
     year_N = regN "año" ;

     -- Verbs

     bite_V = verboV (morder_50b "morder") ;
     blow_V = regV "soplar" ;
     breathe_V = regV "respirar" ;
     burn_V = regV "quemar" ;
     come_V = BasicSpa.come_V ;
     count_V = regV "contar" ;
     cut_V = regV "cortar" ;
     die_V = BasicSpa.die_V ;
     dig_V = regV "escarbar" ;
     drink_V = regV "tomar" ;
     eat_V = regV "comer" ;
     fall_V = verboV (caer_20 "caer") ;
     fear_V = fear_VS ;
     fight_V = regV "pelear" ;
     float_V = regV "flotar" ;
     flow_V = verboV (influir_45 "fluir") ;		-- circular
     fly_V = regV "volar" ;
     freeze_V = regV "congelar" ;
     give_V = verboV (dar_27 "dar") ;
     hear_V = hear_V2 ;
     hit_V = regV "golpear" ;		-- pegar
     hold_V = verboV (tener_4 "tener") ;	-- agarrar
     hunt_V = regV "cazar" ;
     kill_V = regV "matar" ;
     know_V = know_V2 ;
     laugh_V = regV "reir" ; ----V reír_67 
     lie_V = regV "mentir" ; --  "acostarse"
     live_V = live_V ;
     play_V = regV "jugar" ;
     pull_V = regV "tirar" ;
     push_V = regV "empujar" ;
     rub_V = regV "resfregar" ;				-- frotar
     say_V = say_VS ;
     scratch_V = regV "rascar" ;
     see_V = see_V2 ;
     sew_V = regV "coser" ;
     sing_V = regV "cantar" ;
     sit_V = regV "sentar" ; ----V verboV (sedere_84 "sentarse") ;
     sleep_V = sleep_V ;
     smell_V = verboV (oler_52 "oler") ;
     spit_V = regV "escupir" ;
     split_V = regV "separar" ;	-- dividir, partir
     squeeze_V = regV "exprimir" ;
     stab_V = regV "apuñalar" ;	
     stand_V = verboV (estar_2 "estar") ; ---- "estar de pie" ;  
     suck_V = regV "chupar" ;
     swell_V = regV "tragar" ;
     swim_V = regV "nadar" ;
     think_V = regV "pensar" ;
     throw_V = regV "tirar" ;
     tie_V = regV "atar" ;
     turn_V = regV "doblar" ;
     vomit_V = regV "vomitar" ;
     walk_V = regV "caminar" ;
     wash_V = regV "lavar" ;
     wipe_V = regV "secar" ;
}
