concrete TopDictionarySpa of TopDictionary = CatSpa
** open ParadigmsSpa, MorphoSpa, IrregSpa, (L=LexiconSpa), (S=StructuralSpa), (E = ExtraSpa), Prelude in {
---- checked by IL till science_N in the BNC order
oper  mkInterj : Str -> Interj 
    = \s -> lin Interj (ss s) ;
oper  mkDet : Str -> Det = \s -> lin Det {s,sp 
    = \\_,c => prepCase c ++ s ; n = Sg ; s2 = [] ; isNeg = False} ;
oper  mkConj : Str -> Conj 
    = \s -> lin Conj {s1 = [] ; s2 = s ; n = Pl} ;
oper optProDrop : Pron -> Pron = \p -> p | E.ProDrop p ;

lin of_Prep = ParadigmsSpa.genitive ;
lin and_Conj = S.and_Conj ;
lin in_Prep = S.in_Prep ;
lin have_VV = mkVV tener_V ; ---- subcat
lin have_VS = mkVS tener_V ;
lin have_V2V = mkV2V tener_V ;
lin have_V2 = S.have_V2 ;
lin have_V = tener_V ;
lin it_Pron = optProDrop S.it_Pron ;
lin to_Prep = S.to_Prep ;
lin for_Prep = S.for_Prep ;
lin i_Pron = optProDrop S.i_Pron ;
lin iFem_Pron = optProDrop E.i8fem_Pron ;
lin that_Subj = S.that_Subj ;
lin he_Pron = optProDrop S.he_Pron ;
lin on_Prep = S.on_Prep ;
lin with_Prep = S.with_Prep ;
lin do_V2 = mkV2 hacer_V ;
lin do_V = hacer_V ;
lin at_Prep = ParadigmsSpa.dative ;
lin by_Prep = mkPrep "por" ;
lin but_Conj = mkConj "pero" ;
lin from_Prep = S.from_Prep ;
lin they_Pron = optProDrop S.they_Pron ;
lin theyFem_Pron = optProDrop E.they8fem_Pron ;
lin she_Pron = optProDrop S.she_Pron ;
lin or_Conj = S.or_Conj ;
lin as_Subj = ss "como" ** {m = Indic} ;
lin we_Pron = optProDrop S.we_Pron ;
lin weFem_Pron = optProDrop E.we8fem_Pron ;
lin say_VV = mkVV decir_V ;
lin say_VS = L.say_VS ;
lin say_VA = mkVA decir_V ;
lin say_V2 = mkV2 decir_V ;
lin say_V = decir_V ;
lin if_Subj = S.if_Subj ;
lin go_VV = mkVV L.go_V ;
lin go_VS = mkVS L.go_V ;
lin go_VA = mkVA L.go_V ;
lin go_V2 = mkV2 L.go_V ;
lin go_V = L.go_V ;
lin get_VV = mkVV obtener_V ;
lin get_VS = mkVS obtener_V ;
lin get_VA = mkVA obtener_V ;
lin get_V2V = mkV2V obtener_V ;
lin get_V2 = mkV2 obtener_V ;
lin get_V = obtener_V ;
lin make_VV = mkVV hacer_V ;
lin make_VS = mkVS hacer_V ;
lin make_VA = mkVA hacer_V ;
lin make_V3 = mkV3 hacer_V ;
lin make_V2V = mkV2V hacer_V ;
lin make_V2A = mkV2A hacer_V ;
lin make_V2 = mkV2 hacer_V ;
lin make_V = hacer_V ;
lin as_Prep = mkPrep "como" ;
lin out_Adv = mkAdv "lejos" ;
lin up_Adv = mkAdv "arriba" ;
lin see_VS = mkVS (ver_V) ;
lin see_VQ = mkVQ (ver_V) ;
lin see_VA = mkVA (ver_V) ;
lin see_V2V = mkV2V (ver_V) ;
lin see_V2 = L.see_V2 ;
lin see_V = ver_V ;
lin know_VS = L.know_VS ;
lin know_VQ = L.know_VQ ;
lin know_V2V = mkV2V (conocer_V) ;
lin know_V2 = L.know_V2 ;
lin know_V = conocer_V ;
lin time_N = mkN "tiempo" ;
lin time_2_N = mkN "vez" "veces" feminine ;
lin time_1_N = mkN "tiempo" ;
lin take_VA = mkVA (mkV "tomar") | mkVA (mkV "coger") | mkVA (mkV "sacar") | mkVA prender_V ; ---- subcat
lin take_V2V = mkV2V (mkV "tomar") | mkV2V (mkV "coger") | mkV2V (mkV "sacar") | mkV2V prender_V ; ---- subcat
lin take_V2A = mkV2A (mkV "tomar") | mkV2A (mkV "coger") | mkV2A (mkV "sacar") | mkV2A prender_V ; ---- subcat
lin take_V2 = mkV2 (mkV "tomar") | mkV2 (mkV "coger") | mkV2 (mkV "sacar") | mkV2 prender_V ;
lin take_V = mkV "tomar" | mkV "coger" | mkV "sacar" | prender_V ;
lin so_Adv = mkAdv "si" ;
lin year_N = L.year_N ;
lin into_Prep = mkPrep "en" ;
lin then_Adv = mkAdv "entonces" ;
lin think_VS = mkVS (mkV "pensar") ;
lin think_V2A = mkV2A (mkV "pensar") ;
lin think_V2 = mkV2 (mkV "pensar") ;
lin think_V = L.think_V ;
lin come_VV = mkVV venir_V ;
lin come_VS = mkVS venir_V ;
lin come_VA = mkVA venir_V ;
lin come_V2 = mkV2 venir_V ;
lin come_V = L.come_V ;
lin than_Subj = ss "que" ** {m = Indic} ; ---- why is this a Subj?
lin more_Adv = mkAdv "más" ;
lin about_Prep = S.on_Prep | ParadigmsSpa.genitive ;
lin now_Adv = L.now_Adv ;
lin last_A = mkA "último" ;
lin last_1_A = mkA "último" ;
lin last_2_A = mkA "último" ;
lin other_A = mkA "otro" ;
lin give_V3 = L.give_V3 ;
lin give_V2 = mkV2 dar_V | mkV2 (mkV "entregar") ;
lin give_V = dar_V | mkV "entregar" ;
lin just_Adv = mkAdv "por si acaso" | mkAdv "por si las moscas" ;
lin people_N = mkN "gente" feminine ;
lin also_Adv = mkAdv "también" | mkAdv "además" ;
lin well_Adv = mkAdv "bueno" ;
lin only_Adv = mkAdv "solo" | mkAdv "apenas" ;
lin new_A = L.new_A ;
lin when_Subj = S.when_Subj ;
lin way_N = mkN "manera" | mkN "medio" | mkN "forma" ;
lin way_2_N = mkN "manera" | mkN "medio" | mkN "forma" ;
lin way_1_N = mkN "camino" ;
lin look_VV = deVV (mkV "cuidar") ;
lin look_VA = mkVA (mkV "parecer") ;
lin look_V2V = mkV2V (mkV "mirar") ;
lin look_V2 = mkV2 "mirar" ;
lin look_V = mkV "mirar" ;
lin like_Prep = mkPrep "como" ;
lin use_VV = mkVV (mkV "usar") | mkVV (mkV "utilizar") ;
lin use_V2V = mkV2V (mkV "usar") | mkV2V (mkV "utilizar") ;
lin use_V2 = mkV2 (mkV "usar") | mkV2 (mkV "utilizar") ;
lin use_V = mkV "usar" | mkV "utilizar" ;
lin because_Subj = S.because_Subj ;
lin good_A = mkA "bueno" ;
lin find_VS = mkVS (creer_V) | mkVS (encontrar_V) ;
lin find_V2V = mkV2V (creer_V) | mkV2V (encontrar_V) ;
lin find_V2A = mkV2A (creer_V) | mkV2A (encontrar_V) ;
lin find_V2 = L.find_V2 ;
lin find_V = encontrar_V | creer_V ; --- split
lin man_N = L.man_N ;
lin want_VV = S.want_VV ;
lin want_VS = mkVS (querer_V) | mkVS (mkV "desear") ;
lin want_V2V = mkV2V (querer_V) | mkV2V (mkV "desear") ;
lin want_V2 = mkV2 (querer_V) | mkV2 (mkV "desear") ;
lin want_V = querer_V | mkV "desear" ;
lin day_N = L.day_N ;
lin between_Prep = S.between_Prep ;
lin even_Adv = mkAdv "aún" | mkAdv "incluso" | mkAdv "hasta" ;
lin there_Adv = S.there_Adv ;
lin many_Det = S.many_Det ;
lin after_Prep = S.after_Prep ;
lin down_Adv = mkAdv "abajo" ;
lin yeah_Interj = ss "sí" ;
lin so_Subj = ss "así que" ** {m = Indic} ;
lin thing_N = mkN "cosa" ;
lin tell_VV = mkVV (mkV "mandar") ;
lin tell_VS = mkVS (mkV "contar") ;
lin tell_V3 = mkV3 (mkV "contar") ;
lin tell_1_V3 = variants{} ; -- 
lin tell_2_V3 = variants{} ; -- 
lin tell_V2V = mkV2V (mkV "contar") ;
lin tell_V2S = mkV2S (mkV "contar") ;
lin tell_V2Q = mkV2Q (mkV "contar") on_Prep ;
lin tell_V2 = mkV2 (mkV "contar") ;
lin tell_V = mkV "contar" ;
lin through_Prep = S.through_Prep ;
lin back_Adv = mkAdv "atrás" ;
lin still_Adv = mkAdv "sin embargo" | mkAdv "no obstante" ;
lin child_N = L.child_N ;
lin here_Adv = mkAdv "aquí" | mkAdv "acá" ;
lin over_Prep = mkPrep "a través de" ; --- split mkPrep "encima de"
lin too_Adv = mkAdv "también" ;
lin put_VS = mkVS (poner_V) | mkVS (mkV "colocar") | mkVS (mkV "situar") ;
lin put_V2V = mkV2V (poner_V) | mkV2V (mkV "colocar") | mkV2V (mkV "situar") ;
lin put_V2 = L.put_V2 ;
lin put_V = poner_V | mkV "colocar" | mkV "situar" ;
lin on_Adv = mkAdv "sobre" ;
lin no_Interj = mkInterj "no" ;
lin work_VV = mkVV (mkV "trabajar") ;
lin work_V2 = mkV2 (mkV "trabajar") ;
lin work_V = mkV "trabajar" ;
lin work_2_V = mkV "funcionar" ;
lin work_1_V = mkV "trabajar" ;
lin become_VS = mkVS (mkV "volverse") | mkVS (mkV "hacerse") | mkVS (mkV "convertirse") | mkVS (mkV (mkV "llegar") "a ser") ;
lin become_VA = L.become_VA ;
lin become_V2 = mkV2 (mkV "volverse") | mkV2 (mkV "hacerse") | mkV2 (mkV "convertirse") | mkV2 (mkV (mkV "llegar") "a ser") ;
lin become_V = mkV "volverse" | mkV "hacerse" | mkV "convertirse" | mkV (mkV "llegar") "a ser" ;
lin old_A = L.old_A ;
lin government_N = mkN "gobierno" ;
lin mean_VV = mkVV (mkV "significar") | mkVV (mkV querer_V "decir") ;
lin mean_VS = mkVS (mkV "significar") | mkVS (mkV querer_V "decir") ;
lin mean_VA = mkVA (mkV "significar") | mkVA (mkV querer_V "decir") ;
lin mean_V2V = mkV2V (mkV "significar") | mkV2V (mkV querer_V "decir") ;
lin mean_V2 = mkV2 (mkV "significar") | mkV2 (mkV querer_V "decir") ;
lin mean_V = mkV "significar" | mkV querer_V "decir" ;
lin part_N = mkN "parte" feminine ;
lin leave_VV = mkVV (mkV "dejar") ;
lin leave_VS = mkVS (mkV "dejar") ;
lin leave_V2V = mkV2V (mkV "dejar") ;
lin leave_V2 = L.leave_V2 ;
lin leave_V = mkV "dejar" ;
lin life_N = mkN "vida" feminine ;
lin great_A = mkA "grande" ;
lin case_N = mkN "caso" ;
lin woman_N = L.woman_N ;
lin over_Adv = mkAdv "por encima" | mkAdv "encima" | mkAdv "arriba" ;
lin seem_VV = mkVV (parecer_V) ;
lin seem_VS = mkVS (parecer_V) ;
lin seem_VA = mkVA (parecer_V) ;
lin seem_V2 = mkV2 (parecer_V) ;
lin seem_V = parecer_V ;
lin work_N = mkN "trabajo" masculine ;
lin need_VV = mkVV (mkV "necesitar") ;
lin need_VV = mkVV (mkV "necesitar") ;
lin need_VS = mkVS (mkV "necesitar") ;
lin need_V2V = mkV2V (mkV "necesitar") ;
lin need_V2 = mkV2 (mkV "necesitar") ;
lin need_V = mkV "necesitar" ;
lin feel_VS = mkVS (parecer_V) ;
lin feel_VA = mkVA (parecer_V) ;
lin feel_V2 = mkV2 (mkV "sentir") | mkV2 (parecer_V) ;
lin feel_V = mkV "sentir" | parecer_V ;
lin system_N = mkN "sistema" masculine ;
lin each_Det = mkDet "cada" ;
lin may_2_VV = mkVV (mkV "poder" "puedo") ;
lin may_1_VV = mkVV (mkV "poder" "puedo") ;
lin much_Adv = mkAdv "mucho" ;
lin ask_VV = mkVV (pedir_V) | mkVV (mkV "preguntar") ;
lin ask_VS = mkVS (mkV "preguntar") | mkVS (pedir_V) ;
lin ask_VQ = mkVQ (mkV "preguntar") | mkVQ (pedir_V) ;
lin ask_V2V = mkV2V (pedir_V) ;
lin ask_V2 = mkV2 (mkV "preguntar") | mkV2 (pedir_V) ;
lin ask_V = mkV "preguntar" | pedir_V ;
lin group_N = mkN "grupo" ;
lin number_N = L.number_N ;
lin number_3_N = mkN "número" | compN (mkN "número") "gramatical" ;
lin number_2_N = mkN "cantidad" feminine ;
lin number_1_N = mkN "número" | mkN "cifra" ;
lin yes_Interj = mkInterj "sí" ;
lin however_Adv = mkAdv "sin embargo" | mkAdv "por más que" ;
lin another_Det = mkDeterminer "otro" "otra" Sg False ;
lin again_Adv = mkAdv "otra vez" | mkAdv "de nuevo" | mkAdv "nuevamente" ;
lin world_N = mkN "mundial" ;
lin area_N = mkN "área" ;
lin area_6_N = mkN "superficie" feminine ;
lin area_5_N = mkN "zona" ; --- ?
lin area_4_N = mkN "esfera" ; --- ?
lin area_3_N = mkN "zona" ;
lin area_2_N = mkN "rama" ;
lin area_1_N = mkN "zona" | mkN "región" feminine ;
lin show_VS = mkVS (mostrar_V) ;
lin show_VQ = mkVQ (mostrar_V) ;
lin show_V2V = mkV2V (mostrar_V) ;
lin show_V2 = mkV2 (mostrar_V) ;
lin show_V = mostrar_V ;
lin course_N = mkN "curso" ; --- split mkN "rumbo" ;
lin company_2_N = mkN "compañía" ;
lin company_1_N = mkN "empresa" ;
lin under_Prep = S.under_Prep ;
lin problem_N = mkN "problema" masculine | mkN "dificultad" feminine ;
lin against_Prep = mkPrep "contra" ;
lin never_Adv = mkAdv "nunca" | mkAdv "jamás" ;
lin most_Adv = mkAdv "lo más" ;
lin service_N = mkN "servicio" ;
lin try_VV = mkVV (probar_V) ;
lin try_V2V = mkV2V (probar_V) ;
lin try_V2 = mkV2 (probar_V) ;
lin try_V = probar_V ;
lin call_V3 = mkV3 (mkV "llamar") ;
lin call_V2V = mkV2V (mkV "llamar") ;
lin call_V2A = mkV2A (mkV "llamar") ;
lin call_V2 = mkV2 (mkV "llamar") ;
lin call_V = mkV "llamar" ;
lin hand_N = L.hand_N ;
lin party_N = mkN "partido" ;
lin party_2_N = mkN "partido" ;
lin party_1_N = mkN "fiesta" ;
lin high_A = mkA "alto" ;
lin about_Adv = mkAdv "alrededor" ;
lin something_NP = S.something_NP ;
lin school_N = L.school_N ;
lin in_Adv = mkAdv "en resumen" ;
lin in_1_Adv = mkAdv "dentro" ;
lin in_2_Adv = mkAdv "adentro" ;
lin small_A = L.small_A ;
lin place_N = mkN "casa" ;
lin before_Prep = S.before_Prep ;
lin while_Subj = ss "mientras" ** {m = Indic} ;
lin away_Adv = mkAdv "lejos" | mkAdv "ausente" ;
lin away_2_Adv = mkAdv "fuera" | mkAdv "afuera" ;
lin away_1_Adv = mkAdv "lejos" | mkAdv "ausente" | mkAdv "fuera" ;
lin keep_VV = mkVV (mkV "continuar") ;
lin keep_VS = mkVS mantener_V ;
lin keep_VA = mkVA (reflV mantener_V) ;
lin keep_V2A = mkV2A mantener_V ;
lin keep_V2 = mkV2 mantener_V ;
lin keep_V = mantener_V ;
lin point_N = mkN "punto" ;
lin point_2_N = mkN "punto" ;
lin point_1_N = mkN "momento" ;
lin house_N = L.house_N ;
lin different_A = mkA "diferente" | mkA "distinto" ;
lin country_N = L.country_N ;
lin really_Adv = mkAdv "realmente" | mkAdv "de verdad" ;
lin provide_VS = mkVS (proveer_V) | mkVS disponer_V ;
lin provide_V2 = mkV2 (proveer_V) | mkV2 disponer_V ;
lin provide_V = proveer_V | disponer_V ;
lin week_N = mkN "semana" ;
lin hold_VS = mkVS (mkV "guardar") | mkVS (mkV "conservar") | mkVS mantener_V ;
lin hold_V3 = mkV3 (mkV "guardar") | mkV3 (mkV "conservar") | mkV3 mantener_V ;
lin hold_V2V = mkV2V (mkV "guardar") | mkV2V (mkV "conservar") | mkV2V mantener_V ;
lin hold_V2 = L.hold_V2 ;
lin hold_V = mkV "guardar" | mkV "conservar" | reflV mantener_V ;
lin large_A = mkA "grande" ;
lin member_N = mkN "miembro" ;
lin off_Adv = mkAdv "fuera" ;
lin always_Adv = mkAdv "siempre" ;
lin follow_VS = mkVS (seguir_V) ;
lin follow_V2 = mkV2 (seguir_V) ;
lin follow_V = seguir_V ;
lin without_Prep = S.without_Prep ;
lin turn_VA = mkVA (mkV "ponerse") ;
lin turn_V2A = mkV2A (mkV "convertir") ;
lin turn_V2 = mkV2 turn_V ;
lin turn_V = L.turn_V ;
lin end_N = mkN "fin" | mkN "final" ;
lin end_2_N = mkN "extremo" ;
lin end_1_N = end_N ;
lin within_Prep = mkPrep "dentro de" ;
lin local_A = mkA "local" ;
lin where_Subj = ss "donde" ** {m = Indic} ;
lin during_Prep = S.during_Prep ;
lin bring_V3 = mkV3 traer_V ;
lin bring_V2V = mkV2V traer_V ;
lin bring_V2 = mkV2 traer_V ;
lin most_Det = mkDet "la mayoría de" ;
lin word_N = mkN "palabra" ;
lin begin_V2 = mkV2 (comenzar_V) | mkV2 (mkV "iniciar") | mkV2 (empezar_V) ;
lin begin_V = comenzar_V | mkV "iniciar" | empezar_V ;
lin although_Subj = S.although_Subj ;
lin example_N = mkN "ejemplo" ;
lin next_Adv = mkAdv "después" | mkAdv "luego" ;
lin family_N = mkN "familia" ;
lin rather_Adv = mkAdv "más bien" ;
lin fact_N = mkN "hecho" ;
lin like_VV = mkVV (mkV "gustar") ; ---- with dative
lin like_VS = mkVS (mkV "gustar") ; ---- with dative
lin like_V2V = mkV2V (mkV "gustar") ; ---- with dative
lin like_V2 = L.like_V2 ;
lin social_A = mkA "social" ;
lin write_VV = mkVV (mkV "escribir") ;
lin write_VS = mkVS (mkV "escribir") ;
lin write_V2 = L.write_V2 ;
lin write_V = mkV "escribir" | mkV "apuntar" ;
lin state_N = mkN "estado" ;
lin state_2_N = mkN "estado" | mkN "estatus" ;
lin state_1_N = mkN "estado" ;
lin percent_N = mkN "por ciento" ;
lin quite_Adv = S.quite_Adv ;
lin both_Det = mkDeterminer "ambos" "ambas" Pl False | mkDet "los dos" ;
lin start_V2 = mkV2 comenzar_V ;
lin start_V = comenzar_V ;
lin run_VS = mkVS run_V ;
lin run_V2 = mkV2 run_V ;
lin run_V = L.run_V ;
lin long_A = L.long_A ;
lin right_Adv = mkAdv "correctemente" ;
lin right_2_Adv = mkAdv "a la derecha" ;
lin right_1_Adv = mkAdv "correctemente" ;
lin set_VV = aVV comenzar_V | mkVV (mkV "establecer") ; ---- ?
lin set_VS = mkVS suponer_V ; ---- subcat
lin set_V2 = mkV2 poner_V ;
lin set_V = poner_V ;
lin help_VV = mkVV (mkV "ayudar") ;
lin help_VS = mkVS (mkV "ayudar") ;
lin help_V2V = mkV2V (mkV "ayudar") ;
lin help_V2 = mkV2 (mkV "ayudar") ;
lin help_V = mkV "ayudar" ;
lin every_Det = S.every_Det ;
lin home_N = mkN "hogar" ;
lin month_N = mkN "mes" masculine ;
lin side_N = mkN "lado" ;
lin night_N = L.night_N ;
lin important_A = L.important_A ;
lin eye_N = L.eye_N ;
lin head_N = L.head_N ;
lin information_N = mkN "información" feminine ;
lin question_N = L.question_N ;
lin business_N = mkN "negocio" | mkN "empresa" ; ---- negocios
lin play_VV = mkVV (jugar_V) ;
lin play_V2 = L.play_V2 ;
lin play_V = L.play_V ;
lin play_3_V2 = mkV2 (mkV "tocar") ;
lin play_3_V = mkV "tocar" ;
lin play_2_V2 = mkV2 jugar_V ;
lin play_2_V = jugar_V ;
lin play_1_V2 = mkV2 jugar_V ;
lin play_1_V = jugar_V ;
lin power_N = mkN "poder" ; --- split mkN "electricidad" ;
lin money_N = mkN "dinero" ;
lin change_N = mkN "cambio" ;
lin move_VV = mkVV (mkV "mover" "muevo") ;
lin move_V2V = mkV2V (mkV "mover" "muevo") ;
lin move_V2A = mkV2A (mkV "mover" "muevo") ;
lin move_V2 = mkV2 (mkV "mover" "muevo") ;
lin move_V = mkV "mover" "muevo" ;
lin move_2_V = mkV "mudarse" ;
lin move_1_V = mkV "mover" "muevo" ;
lin interest_N = mkN "interés" masculine ;
lin interest_4_N = mkN "interés" masculine ;
lin interest_2_N = mkN "interés" masculine ;
lin interest_1_N = mkN "interés" masculine ;
lin order_N = mkN "orden" feminine ;
lin book_N = L.book_N ;
lin often_Adv = mkAdv "a menudo" | mkAdv "frecuentemente" | mkAdv "seguido" ;
lin development_N = mkN "desarrollo" ;
lin young_A = L.young_A ;
lin national_A = mkA "nacional" ;
lin pay_V3 = mkV3 (mkV "pagar") ;
lin pay_V2V = mkV2V (mkV "pagar") ;
lin pay_V2 = mkV2 (mkV "pagar") ;
lin pay_V = mkV "pagar" ;
lin hear_VS = mkVS (oír_V) ;
lin hear_V2V = mkV2V (oír_V) ;
lin hear_V2 = L.hear_V2 ;
lin hear_V = oír_V ;
lin room_N = mkN "cuarto" | mkN "habitación" | mkN "pieza" | mkN "sala" | mkN "recámara" ;
lin room_1_N = mkN "cuarto" | mkN "habitación" ;
lin room_2_N = mkN "sitio" ;
lin whether_Subj = ss "si" ** {m = Indic} ;
lin water_N = L.water_N ;
lin form_N = mkN "formulario" | mkN "forma" ; --- split
lin car_N = L.car_N ;
lin other_N = mkN "otro" | mkN "otra" ;
lin yet_Adv = mkAdv "todavía" ;
lin yet_2_Adv = mkAdv "aún" ;
lin yet_1_Adv = mkAdv "todavía" ;
lin perhaps_Adv = mkAdv "quizá" | mkAdv "quizás" | mkAdv "tal vez" ;
lin meet_V2V = mkV2V (conocer_V) ;
lin meet_V2 = mkV2 (conocer_V) ;
lin meet_V = conocer_V ;
lin level_N = mkN "nivel" ;
lin level_2_N = mkN "planta" ;
lin level_1_N = mkN "nivel" ;
lin until_Subj = ss "hasta que" ** {m = Conjunct} ;
lin though_Subj = ss "aunque" ** {m = Conjunct} ;
lin policy_N = mkN "política" ;
lin include_VV = mkVV (incluir_V) ;
lin include_V2 = mkV2 (incluir_V) ;
lin include_V = incluir_V ;
lin believe_VS = mkVS (creer_V) ;
lin believe_V2V = mkV2V (creer_V) ;
lin believe_V2 = mkV2 (creer_V) ;
lin believe_V = creer_V ;
lin council_N = mkN "concejo" ;
lin already_Adv = L.already_Adv ;
lin possible_A = mkA "posible" ;
lin nothing_NP = S.nothing_NP ;
lin line_N = mkN "línea" ;
lin allow_VS = mkVS (mkV "permitir") | mkVS (mkV "conceder") ;
lin allow_V2V = mkV2V (mkV "permitir") | mkV2V (mkV "conceder") ;
lin allow_V2 = mkV2 (mkV "permitir") | mkV2 (mkV "conceder") ;
lin allow_V = mkV "permitir" | mkV "conceder" ;
lin need_N = mkN "necesidad" feminine ;
lin effect_N = mkN "efecto" ;
lin big_A = L.big_A ;
lin use_N = mkN "uso" ;
lin lead_VS = mkVS (mkV (mkV "llevar") "a") ; ---- ?
lin lead_V2V = mkV2V (mkV "llevar") ;
lin lead_V2 = mkV2 (mkV "dirigir") | mkV2 conducir_V ;
lin lead_V = mkV "dirigir" | conducir_V ;
lin stand_VV = mkVV (mkV "tolerar") | mkVV (mkV "aguantar") ; --can't stand
lin stand_VS = mkVS (reflV mantener_V) | mkVS (mkV "tolerar") ; ---- subcat
lin stand_V2 = mkV2 mantener_V | mkV2 (mkV "aguantar") | mkV2 (mkV "tolerar") ;
lin stand_V = L.stand_V ;
lin idea_N = mkN "idea" ;
lin study_N = mkN "estudio" ;
lin lot_N = mkN "grupo" | compN (mkN "billete") "de lotería" ; --- split
lin live_VV = mkVV (mkV "vivir") ;
lin live_V2 = mkV2 (mkV "vivir") ;
lin live_V = L.live_V ;
lin job_N = mkN "trabajo" ;
lin since_Subj = ss "desde que" ** {m = Indic} ;
lin name_N = L.name_N ;
lin result_N = mkN "resultado" ;
lin body_N = mkN "cuerpo" ;
lin happen_VV = mkVV (mkV "suceder") | mkVV (mkV "ocurrir") | mkVV (mkV "pasar") ;
lin happen_V2 = mkV2 (mkV "suceder") | mkV2 (mkV "ocurrir") | mkV2 (mkV "pasar") ;
lin happen_V = mkV "suceder" | mkV "ocurrir" | mkV "pasar" ;
lin friend_N = L.friend_N ;
lin right_N = mkN "derecho" ; --- split
lin least_Adv = mkAdv "lo menos" ;
lin right_A = mkA "correcto" ;
lin right_2_A = mkA "correcto" ;
lin right_1_A = mkA "derecho" ;
lin almost_Adv = mkAdv "casi" ;
lin much_Det = S.much_Det ;
lin carry_V2 = mkV2 (mkV "llevar") | mkV2 (mkV "cargar") ;
lin carry_V = mkV "llevar" | mkV "cargar" ;
lin authority_N = mkN "autoridad" feminine ;
lin authority_2_N = mkN "autoridad" feminine ;
lin authority_1_N = mkN "autoridad" feminine ;
lin long_Adv = mkAdv "mucho tiempo" ;
lin early_A = mkA "prematuro" | mkA "temprano" ;
lin view_N = mkN "visión" feminine ;
lin view_2_N = mkN "opinión" | compN (mkN "punto") "de vista" ;
lin view_1_N = mkN "vista" ;
lin public_A = mkA "público" ;
lin together_Adv = mkAdv "juntos" | mkAdv "junto" ;
lin talk_V2 = mkV2 (mkV "hablar") | mkV2 (mkV "conversar") ;
lin talk_V = mkV "hablar" | mkV "conversar" ;
lin report_N = mkN "informe" masculine ;
lin after_Subj = ss "después de que" ** {m = Conjunct} ;
lin only_Predet = S.only_Predet ;
lin before_Subj = ss "antés de que" ** {m = Conjunct} ;
lin bit_N = mkN "bocado" ; --- split mkN "bit"
lin face_N = mkN "cara" | mkN "rostro" | mkN "mueca" ;
lin sit_VA = mkVA (reflV (mkV "sentar" "siento")) ;
lin sit_V2 = mkV2 (reflV (mkV "sentar" "siento")) ;
lin sit_V = L.sit_V ;
lin market_N = mkN "mercado" ;
lin market_1_N = mkN "mercado" ;
lin market_2_N = mkN "mercado" | mkN "bolsa" ;
lin appear_VV = mkVV (aparecer_V) ;
lin appear_VS = mkVS (aparecer_V) ;
lin appear_VA = mkVA (aparecer_V) ;
lin appear_V2 = mkV2 (aparecer_V) ;
lin appear_V = aparecer_V ;
lin continue_VV = mkVV (mkV "continuar") ;
lin continue_VS = mkVS (mkV "continuar") ;
lin continue_V2 = mkV2 (mkV "continuar") ;
lin continue_V = mkV "continuar" ;
lin able_A = mkA "competente" ;
lin political_A = mkA "político" ;
lin later_Adv = mkAdv "más tarde" | mkAdv "después" ;
lin hour_N = mkN "hora" ;
lin rate_N = mkN "proporción" | mkN "nivel" | mkN "tasa" | mkN "precio" ; --- split
lin law_N = mkN "ley" feminine ;
lin law_2_N = mkN "derecho" ;
lin law_1_N = mkN "ley" feminine ;
lin door_N = L.door_N ;
lin court_N = mkN "corte" masculine ;
lin court_2_N = mkN "tribunal" ;
lin court_1_N = mkN "corte" ;
lin office_N = mkN "oficina" ;
lin let_VS = mkVS (mkV "dejar") ;
lin let_V2V = mkV2V (mkV "dejar") ;
lin let_V2 = mkV2 (mkV "dejar") ;
lin let_V = mkV "dejar" ;
lin war_N = L.war_N ;
lin produce_V2 = mkV2 (producir_V) ;
lin produce_V = producir_V ;
lin reason_N = L.reason_N ;
lin less_Adv = mkAdv "menos" ;
lin minister_N = mkN "ministro" ;
lin minister_2_N = mkN "pastor" ;
lin minister_1_N = mkN "ministro" ;
lin subject_N = mkN "sujeto" ;
lin subject_2_N = mkN "sujeto" ;
lin subject_1_N = mkN "asunto" | mkN "tema" masculine ;
lin person_N = L.person_N ;
lin term_N = mkN "término" ;
lin particular_A = mkA "particular" ;
lin full_A = L.full_A ;
lin involve_VS = mkVS (mkV "implicar") | mkVS (mkV "involucrar") ;
lin involve_V2 = mkV2 (mkV "involucrar") ;
lin involve_V = reflV (mkV "involucrar") ;
lin sort_N = mkN "ordenar" ;
lin require_VV = mkVV (requerir_V) | mkVV (mkV "necesitar") ;
lin require_VS = mkVS (requerir_V) | mkVS (mkV "necesitar") ;
lin require_V2V = mkV2V (requerir_V) | mkV2V (mkV "necesitar") ;
lin require_V2 = mkV2 (requerir_V) | mkV2 (mkV "necesitar") ;
lin require_V = requerir_V | mkV "necesitar" ;
lin suggest_VS = mkVS (sugerir_V) ;
lin suggest_V2 = mkV2 (sugerir_V) ;
lin suggest_V = sugerir_V ;
lin far_A = mkA "lejano" ;
lin towards_Prep = mkPrep "hacia" ;
lin anything_NP = makeNP "cualquier cosa" Fem Sg ;
lin period_N = mkN "período" ;
lin period_3_N = mkN "menstruación" ;
lin period_2_N = mkN "punto" ;
lin period_1_N = mkN "período" ;
lin consider_VV = mkVV (mkV "considerar") ;
lin consider_VS = mkVS (mkV "considerar") ;
lin consider_V3 = mkV3 (mkV "considerar") ;
lin consider_V2V = mkV2V (mkV "considerar") ;
lin consider_V2A = mkV2A (mkV "considerar") ;
lin consider_V2 = mkV2 (mkV "considerar") ;
lin consider_V = mkV "considerar" ;
lin read_VS = mkVS (leer_V) ;
lin read_VA = mkVA (leer_V) ;
lin read_V2 = L.read_V2 ;
lin read_V = leer_V ;
lin change_V2 = mkV2 (mkV "cambiar") ;
lin change_V = mkV "cambiar" ;
lin society_N = mkN "sociedad" feminine ;
lin process_N = mkN "proceso" ;
lin mother_N = mkN "madre" feminine ;
lin offer_VV = mkVV (ofrecer_V) ;
lin offer_VS = mkVS (ofrecer_V) ;
lin offer_V3 = mkV3 (ofrecer_V) ;
lin offer_V2V = mkV2V (ofrecer_V) ;
lin offer_V2 = mkV2 (ofrecer_V) ;
lin offer_V = ofrecer_V ;
lin late_A = mkA "tarde" ; --- split mkA "difunto" ;
lin voice_N = mkN "voz" feminine ;
lin both_Adv = mkAdv "ambos" | mkAdv "los dos" ;
lin once_Adv = mkAdv "una vez más" ;
lin police_N = mkN "policía" ;
lin kind_N = mkN "género" | mkN "tipo" | mkN "forma" | mkN "clase" feminine ;
lin lose_V2 = L.lose_V2 ;
lin lose_V = perder_V ;
lin add_VS = mkVS (mkV "añadir") | mkVS incluir_V ;
lin add_V2 = mkV2 (mkV "añadir") | mkV2 (mkV "agregar") ;
lin add_V = mkV "añadir" ;
lin probably_Adv = mkAdv "probablemente" ;
lin expect_VV = mkVV (mkV "esperar") | mkVV (mkV "aguardar") ;
lin expect_VS = mkVS (mkV "esperar") | mkVS suponer_V | mkVS (mkV "aguardar") ;
lin expect_V2V = mkV2V (mkV "esperar") | mkV2V suponer_V | mkV2V (mkV "aguardar") ;
lin expect_V2 = mkV2 (mkV "esperar") | mkV2 suponer_V | mkV2 (mkV "aguardar") ;
lin expect_V = mkV "esperar" | suponer_V | mkV "aguardar" ;
lin ever_Adv = mkAdv "nunca" | mkAdv "alguna vez" ; ---- negative in other langs
lin available_A = mkA "disponible" ;
lin price_N = mkN "precio" ;
lin little_A = mkA "poco" | mkA "menor" ;
lin action_N = mkN "acción" feminine ;
lin issue_N = mkN "asunto" ;
lin issue_2_N = mkN "número" | mkN "edición" | mkN "emisión" ;
lin issue_1_N = mkN "problema" masculine | mkN "cuestión" ;
lin far_Adv = L.far_Adv ;
lin remember_VS = mkVS (mkV "recordar" "recuerdo") ;
lin remember_V2 = mkV2 (mkV "recordar" "recuerdo") | mkV2 (reflV (mkV "acordar" "acuerdo")) of_Prep ;
lin remember_V = mkV "recordar" "recuerdo" | reflV (mkV "acordar" "acuerdo") ;
lin position_N = mkN "posición" feminine ;
lin low_A = mkA "bajo" ;
lin cost_N = mkN "costo" ;
lin little_Det = mkDeterminer "poco" "poca" Sg False ;
lin matter_N = mkN "materia" ;
lin matter_1_N = mkN "materia" | mkN "sustancia" ;
lin matter_2_N = mkN "asunto" ;
lin community_N = mkN "comunidad" feminine ;
lin remain_VV = mkVV (permanecer_V) | mkVV (mkV "quedar") ;
lin remain_VS = mkVS (permanecer_V) ;
lin remain_VA = mkVA (permanecer_V) | mkVA (mkV "quedar") ;
lin remain_V2 = mkV2 (permanecer_V) ;
lin remain_V = permanecer_V | reflV (mkV "quedar") ;
lin figure_N = mkN "figura" ;
lin figure_2_N = mkN "cifra" ;
lin figure_1_N = mkN "figura" ;
lin type_N = mkN "tipo" ;
lin research_N = mkN "investigación" feminine ;
lin actually_Adv = mkAdv "realmente" ;
lin education_N = mkN "educación" feminine ;
lin fall_VA = mkVA caer_V ;
lin fall_V2 = mkV2 caer_V ; ---- subcat
lin fall_V = caer_V | morir_V ;
lin speak_V2 = L.speak_V2 ;
lin speak_V = mkV "hablar" ;
lin few_N = mkN "poco" ; ---- plural
lin today_Adv = L.today_Adv ;
lin enough_Adv = mkAdv "suficientemente" | mkAdv "bastante" ;
lin open_V2 = L.open_V2 ;
lin open_V = abrir_V ;
lin bad_A = L.bad_A ;
lin buy_V2 = L.buy_V2 ;
lin buy_V = mkV "comprar" ;
lin programme_N = mkN "programa" masculine ;
lin minute_N = mkN "minuto" ;
lin moment_N = mkN "momento" ;
lin girl_N = L.girl_N ;
lin age_N = mkN "edad" feminine ;
lin centre_N = mkN "centro" ;
lin stop_VV = mkVV (mkV "parar") ;
lin stop_V2 = mkV2 (mkV "parar") ;
lin stop_V = L.stop_V ;
lin control_N = mkN "control" ;
lin value_N = mkN "valor" ;
lin send_VS = mkVS (mkV "enviar") | mkVS (mkV "mandar") ;
lin send_V2V = mkV2V (mkV "enviar") | mkV2V (mkV "mandar") ;
lin send_V2 = mkV2 (mkV "enviar") | mkV2 (mkV "mandar") ;
lin send_V = mkV "enviar" | mkV "mandar" ;
lin health_N = mkN "salud" feminine ;
lin decide_VV = mkVV (mkV "decidir") ;
lin decide_VS = mkVS (mkV "decidir") ;
lin decide_V2 = mkV2 (mkV "decidir") ;
lin decide_V = mkV "decidir" ;
lin main_A = mkA "principal" ;
lin win_V2 = L.win_V2 ;
lin win_V = mkV "ganar" ;
lin understand_VS = mkVS (entender_V) ;
lin understand_V2V = mkV2V (entender_V) ;
lin understand_V2 = L.understand_V2 ;
lin understand_V = entender_V ;
lin decision_N = mkN "decisión" feminine ;
lin develop_V2 = mkV2 (mkV "desarrollar") ;
lin develop_V = mkV "desarrollar" ;
lin class_N = mkN "clase" feminine ;
lin industry_N = L.industry_N ;
lin receive_V2 = mkV2 (mkV "recibir") ;
lin receive_V = mkV "recibir" ;
lin back_N = L.back_N ;
lin several_Det = mkDeterminer "varios" "varias" Pl False ;
lin return_V2V = mkV2V (volver_V) | mkV2V (mkV "regresar") ;
lin return_V2 = mkV2 (volver_V) | mkV2 (mkV "regresar") ;
lin return_V = volver_V | mkV "regresar" ;
lin build_V2 = mkV2 (construir_V) | mkV2 (mkV "edificar") ;
lin build_V = construir_V | mkV "edificar" ;
lin spend_V2 = mkV2 (mkV "gastar") ;
lin spend_V = mkV "gastar" ;
lin force_N = mkN "fuerza" ;
lin condition_N = mkN "condición" feminine ;
lin condition_1_N = mkN "condición" ;
lin condition_2_N = mkN "condición" | mkN "estado" ;
lin paper_N = L.paper_N ;
lin off_Prep = mkPrep "de" ;
lin major_A = mkA "mayor" ;
lin describe_VS = mkVS (describir_V) ;
lin describe_V2 = mkV2 (describir_V) ;
lin describe_V = describir_V ;
lin agree_VV = mkVV (concordar_V) ;
lin agree_VS = mkVS (concordar_V) ;
lin agree_V2 = mkV2 (concordar_V) ;
lin agree_V = concordar_V ;
lin economic_A = mkA "económico" ;
lin increase_V2 = mkV2 (mkV "aumentar") ;
lin increase_V = mkV "aumentar" ;
lin upon_Prep = mkPrep "sobre" ;
lin learn_VV = mkVV (mkV "aprender") ;
lin learn_VS = mkVS (mkV "aprender") ;
lin learn_V2 = L.learn_V2 ;
lin learn_V = mkV "aprender" ;
lin general_A = mkA "general" ;
lin century_N = mkN "siglo" | mkN "centuria" ;
lin therefore_Adv = mkAdv "por eso" ;
lin father_N = mkN "padre" masculine ;
lin section_N = mkN "sección" feminine ;
lin patient_N = mkN "paciente" masculine ;
lin around_Adv = mkAdv "por aquí" | mkAdv "por acá" ;
lin activity_N = mkN "actividad" feminine ;
lin road_N = L.road_N ;
lin table_N = L.table_N ;
lin including_Prep = mkPrep "incluso" | mkPrep "incluyendo" ;
lin church_N = L.church_N ;
lin reach_VA = mkVA (mkV "alcanzar") ;
lin reach_V2V = mkV2V (mkV "alcanzar") ;
lin reach_V2 = mkV2 (mkV "alcanzar") | mkV2 (mkV "llegar") to_Prep ;
lin reach_V = mkV "alcanzar" ;
lin real_A = mkA "real" | mkA "auténtico" ;
lin lie_VS = mkVS mentir_V ;
lin lie_2_V = mentir_V ;
lin lie_1_V = yacer_V ;
lin mind_N = mkN "mente" feminine ;
lin likely_A = mkA "probable" | mkA "verosímil" ;
lin among_Prep = mkPrep "entre" ;
lin team_N = mkN "equipo" ;
lin experience_N = mkN "experiencia" ;
lin death_N = mkN "muerte" feminine ;
lin soon_Adv = mkAdv "pronto" ;
lin act_N = mkN "acto" ;
lin sense_N = mkN "sentido" | mkN "sensación" feminine ;
lin staff_N = mkN "personal" masculine | mkN "equipo" | mkN "empleado" ;
lin staff_2_N = mkN "bastón" masculine ;
lin staff_1_N = mkN "personal" masculine ;
lin certain_A = mkA "cierto" ;
lin certain_2_A = mkA "cierto" ;
lin certain_1_A = mkA "cierto" | mkA "seguro" ;
lin student_N = L.student_N ;
lin half_Predet = {s = \\a,c => prepCase c ++ "medio" ; c = Nom ; a = PNoAg} ;
lin half_Predet = {s = \\a,c => prepCase c ++ "medio" ; c = Nom ; a = PNoAg} ;
lin around_Prep = mkPrep "alrededor de" ;
lin language_N = L.language_N ;
lin walk_V2 = mkV2 (mkV "caminar") ;
lin walk_V = L.walk_V ;
lin die_V2 = mkV2 morir_V ; ---- subcat
lin die_V = L.die_V ;
lin special_A = mkA "especial" ;
lin difficult_A = mkA "difícil" ;
lin international_A = mkA "internacional" ;
lin particularly_Adv = mkAdv "en particular" | mkAdv "particularmente" ;
lin department_N = mkN "departamento" | mkN "sección" feminine ;
lin management_N = mkN "administración" feminine | mkN "dirección" ;
lin morning_N = mkN "mañana" ;
lin draw_V2V = mkV2V (mkV "sacar") ;
lin draw_V2 = mkV2 (mkV "dibujar") ;
lin draw_1_V2 = mkV2 (mkV "sacar") | mkV2 atraer_V ;
lin draw_2_V2 = mkV2 (mkV "dibujar") ;
lin draw_V = mkV "dibujar" ;
lin hope_VV = mkVV (mkV "esperar") ;
lin hope_VS = L.hope_VS ;
lin hope_V = mkV "esperar" ;
lin across_Prep = mkPrep "a través de" ;
lin plan_N = mkN "plan" masculine ;
lin product_N = mkN "producto" ;
lin city_N = L.city_N ;
lin early_Adv = mkAdv "temprano" ;
lin committee_N = mkN "comité" masculine | mkN "comisión" ;
lin ground_N = mkN "fondo" | mkN "fundamento" | mkN "base" feminine ;
lin ground_2_N = mkN "base" feminine | mkN "razón" feminine ;
lin ground_1_N = mkN "zona" ;
lin letter_N = mkN "carta" ;
lin letter_2_N = mkN "letra" ; ---- to check, which is which? senses-in-Dictionary doesn't tell
lin letter_1_N = mkN "carta" ;
lin create_VV = mkVV (mkV "crear") ;
lin create_V2 = mkV2 (mkV "crear") ;
lin create_V = mkV "crear" ;
lin evidence_N = mkN "evidencia" | mkN "prueba" ;
lin evidence_2_N = mkN "evidencia" | mkN "prueba" ;
lin evidence_1_N = mkN "evidencia" | mkN "prueba" ;
lin foot_N = L.foot_N ;
lin clear_A = mkA "claro" ;
lin boy_N = L.boy_N ;
lin game_N = mkN "juego" ;
lin game_3_N = mkN "caza" ;
lin game_2_N = mkN "juego" ;
lin game_1_N = mkN "juego" ;
lin food_N = mkN "comida" | mkN "alimento" ;
lin role_N = mkN "papel" masculine ;
lin role_2_N = mkN "papel" masculine ; ---- what's the difference in senses?
lin role_1_N = mkN "papel" masculine ; ---- what's the difference in senses?
lin practice_N = mkN "práctica" ;
lin bank_N = L.bank_N ;
lin else_Adv = mkAdv "de otro caso" ;
lin support_N = mkN "apoyo" | mkN "respaldo" ;
lin sell_VS = mkVS (mkV "vender") ;
lin sell_VA = mkVA (mkV "vender") ;
lin sell_V2 = mkV2 (mkV "vender") ;
lin sell_V = mkV "vender" ;
lin event_N = mkN "evento" ;
lin building_N = mkN "edificio" | mkN "construcción" feminine ;
lin range_N = mkN "intervalo" ; --- split
lin behind_Prep = S.behind_Prep ;
lin sure_A = mkA "seguro" ;
lin report_VS = mkVS (mkV "informar") | mkVS (mkV "presentarse") ;
lin report_V2V = mkV2V (mkV "informar") | mkV2V (mkV "presentar") ;
lin report_V2 = mkV2 (mkV "informar") | mkV2 (mkV "presentar") ;
lin report_V = mkV "presentarse" | mkV "informar" ;
lin pass_V2 = mkV2 (mkV "pasar") ;
lin pass_V = mkV "pasar" ;
lin black_A = L.black_A ;
lin stage_N = mkN "escena" | mkN "etapa" ; --- split
lin meeting_N = mkN "reunión" feminine ;
lin meeting_N = mkN "reunión" feminine ;
lin sometimes_Adv = mkAdv "a veces" | mkAdv "algunas veces" ;
lin thus_Adv = mkAdv "así" ;
lin accept_VS = mkVS (mkV "aceptar") ;
lin accept_V2 = mkV2 (mkV "aceptar") ;
lin accept_V = mkV "aceptar" ;
lin town_N = mkN "ciudad" | mkN "pueblo" ;
lin art_N = L.art_N ;
lin further_Adv = mkAdv "además" | mkAdv "más allá" | mkAdv "más lejos" ;
lin club_N = mkN "club" masculine ;
lin club_2_N = mkN "palo" ;
lin club_1_N = mkN "club" masculine ;
lin cause_VS = mkVS (mkV "causar") ;
lin cause_V2V = mkV2V (mkV "causar") ;
lin cause_V2 = mkV2 (mkV "causar") ;
lin arm_N = mkN "brazo" ;
lin arm_1_N = mkN "brazo" ;
lin arm_2_N = mkN "arma" ;
lin history_N = mkN "historia" ;
lin parent_N = mkN "padre" ;
lin land_N = mkN "tierra" | mkN "país" ; --- split
lin trade_N = mkN "comercio" | mkN "negocio" ;
lin watch_VS = mkVS (mkV "mirar") ;
lin watch_V2V = mkV2V (mkV "mirar") ;
lin watch_V2 = L.watch_V2 ;
lin watch_1_V2 = mkV2 (mkV "mirar") ;
lin watch_2_V2 = mkV2 (mkV "vigilar") ;
lin watch_V = mkV "mirar" ;
lin white_A = L.white_A ;
lin situation_N = mkN "situación" ;
lin ago_Adv = mkAdv "hace" | mkAdv "atrás" ;
lin teacher_N = L.teacher_N ;
lin record_N = mkN "registro" ;
lin record_3_N = mkN "registro" ;
lin record_2_N = mkN "disco" ;
lin record_1_N = mkN "récord" ;
lin manager_N = mkN "director" | mkN "representante" masculine ;
lin relation_N = mkN "relación" feminine ;
lin common_A = mkA "común" ;
lin common_2_A = mkA "común" ;
lin common_1_A = mkA "común" | mkA "corriente" ;
lin strong_A = mkA "fuerte" ;
lin whole_A = mkA "entero" ;
lin field_N = mkN "campo" | mkN "terreno" ;
lin field_4_N = mkN "cuerpo" ;
lin field_3_N = mkN "campo" ;
lin field_2_N = mkN "campo" ;
lin field_1_N = mkN "campo" ;
lin free_A = mkA "libre" ;
lin break_V2 = L.break_V2 ;
lin break_V = mkV "romper" ;
lin yesterday_Adv = mkAdv "ayer" ;
lin support_VV = mkVV (mkV "apoyar") | mkVV (mkV "respaldar") ;
lin support_V2 = mkV2 (mkV "apoyar") | mkV2 (mkV "respaldar") ;
lin window_N = L.window_N ;
lin account_N = mkN "cuenta" ;
lin explain_VS = mkVS (mkV "explicar") ;
lin explain_V2 = mkV2 (mkV "explicar") ;
lin stay_VS = mkVS (reflV mantener_V) ;
lin stay_VA = mkVA (reflV mantener_V) ;
lin stay_V2 = mkV2 (reflV mantener_V) ;
lin stay_V = reflV mantener_V ;
lin few_Det = S.few_Det ;
lin wait_VV = mkVV (mkV "esperar") | mkVV (mkV "aguardar") ;
lin wait_V2 = L.wait_V2 ;
lin wait_V = mkV "esperar" | mkV "aguardar" ;
lin usually_Adv = mkAdv "en general" | mkAdv "normalmente" ;
lin difference_N = mkN "diferencia" ;
lin material_N = mkN "material" masculine ;
lin air_N = mkN "aire" ;
lin wife_N = L.wife_N ;
lin cover_VS = mkVS (cubrir_V) ;
lin cover_V2 = mkV2 (cubrir_V) ;
lin apply_VV = mkVV (mkV "aplicar") ;
lin apply_V2V = mkV2V (mkV "aplicar") ;
lin apply_V2 = mkV2 (mkV "aplicar") ;
lin apply_1_V2 = mkV2 (mkV "aplicar") ;
lin apply_2_V2 = mkV2 (mkV "solicitar") ;
lin apply_V = mkV "aplicar" ;
lin project_N = mkN "proyecto" ;
lin raise_V2V = mkV2V (mkV "levantar") | mkV2V (mkV "alzar") ;
lin raise_V2 = mkV2 (mkV "levantar") | mkV2 (mkV "alzar") ;
lin sale_N = mkN "venta" ;
lin relationship_N = mkN "relación" feminine ;
lin indeed_Adv = mkAdv "de hecho" | mkAdv "realmente" | mkAdv "efectivamente" | mkAdv "verdaderamente" ;
lin light_N = mkN "luz" ; --- split? mkN "bombilla" ;
lin claim_VV = mkVV (mkV "reclamar") ;
lin claim_VS = mkVS (mkV "reclamar") ;
lin claim_V2 = mkV2 (mkV "reclamar") ;
lin claim_V = mkV "reclamar" ;
lin form_V2 = mkV2 (mkV "formar") ;
lin form_V = mkV "formar" ;
lin base_V2 = mkV2 (mkV "basar") ;
lin base_V = mkV "basar" | mkV "basarse" ;
lin care_N = mkN "atención" | mkN "cuidado" | mkN "esmero" ;
lin someone_NP = S.somebody_NP ;
lin everything_NP = S.everything_NP ;
lin certainly_Adv = mkAdv "ciertamente" | mkAdv "por cierto" ;
lin rule_N = L.rule_N ;
lin home_Adv = mkAdv "a casa" ;
lin cut_V2A = mkV2A (mkV "cortar") ;
lin cut_V2 = L.cut_V2 ;
lin cut_V = mkV "cortar" ;
lin grow_VS = mkVS (crecer_V) ;
lin grow_VA = mkVA (crecer_V) ;
lin grow_V2V = mkV2V (crecer_V) ;
lin grow_V2 = mkV2 (crecer_V) ;
lin grow_V = crecer_V ;
lin similar_A = mkA "similar" | mkA "semejante" | mkA "parecido" ;
lin story_N = mkN "cuento" | mkN "historia" ;
lin quality_N = mkN "cualidad" feminine ;
lin tax_N = mkN "impuesto" | mkN "tasa" ;
lin worker_N = mkN "obrero" | mkN "trabajador" ;
lin nature_N = mkN "naturaleza" ;
lin structure_N = mkN "estructura" ;
lin data_N = mkN "información" | mkN "dato" ; ---- datos plurale tantum
lin necessary_A = mkA "necesario" ;
lin pound_N = mkN "libra" ;
lin method_N = mkN "método" ;
lin unit_N = mkN "unidad" feminine ;
lin unit_6_N = mkN "unidad" feminine ;
lin unit_5_N = mkN "unidad" feminine ;
lin unit_4_N = mkN "unidad" feminine ;
lin unit_3_N = mkN "unidad" feminine ;
lin unit_2_N = mkN "unidad" feminine ;
lin unit_1_N = mkN "unidad" feminine ;
lin central_A = mkA "central" ;
lin bed_N = mkN "cama" ;
lin union_N = mkN "unión" feminine ;
lin movement_N = mkN "movimiento" ;
lin board_N = mkN "pizarra" | mkN "pizarrón" masculine ;
lin board_2_N = mkN "junta" ;
lin board_1_N = mkN "pizarra" | mkN "pizarrón" masculine ;
lin true_A = mkA "auténtico" ;
lin well_Interj = mkInterj "pues" | mkInterj "bueno" ;
lin simply_Adv = mkAdv "simplemente" ;
lin contain_V2 = mkV2 (contener_V) ;
lin especially_Adv = mkAdv "especialmente" ;
lin open_A = mkA "abierto" ;
lin short_A = L.short_A ;
lin personal_A = mkA "personal" ;
lin detail_N = mkN "detalle" ;
lin model_N = mkN "modelo" | mkN "muestra" | mkN "maqueta" ;
lin bear_V2 = mkV2 (mkV "llevar") | mkV2 (mkV "portar") ;
lin bear_V = mkV "llevar" | mkV "portar" ;
lin single_A = mkA "solo" | mkA "único" ;
lin single_2_A = mkA "soltero" ;
lin single_1_A = mkA "solo" | mkA "único" ;
lin join_V2 = mkV2 (mkV "unir") | mkV2 (mkV "unirse") | mkV2 (mkV "unirse") to_Prep | mkV2 (reflV reunir_V) with_Prep ;
lin join_V = mkV "unirse" | reflV reunir_V ;
lin reduce_V2 = mkV2 (reducir_V) ;
lin reduce_V = reducir_V ;
lin establish_V2 = mkV2 (mkV "establecer") ;
lin wall_N = mkN "pared" feminine ;
lin face_V2 = mkV2 (mkV "enfrentar") | mkV2 (mkV "encarar") ;
lin face_V = mkV "enfrentar" | mkV "encarar" ;
lin easy_A = mkA "fácil" ;
lin private_A = mkA "privado" ;
lin computer_N = L.computer_N ;
lin hospital_N = mkN "hospital" masculine ;
lin chapter_N = mkN "capítulo" ;
lin scheme_N = mkN "esquema" masculine ;
lin theory_N = mkN "teoría" ;
lin choose_VV = mkVV (escoger_V) | mkVV (elegir_V) ;
lin choose_VS = mkVS (escoger_V) | mkVS (elegir_V) ;
lin choose_V2V = mkV2V (escoger_V) | mkV2V (elegir_V) ;
lin choose_V2 = mkV2 (escoger_V) | mkV2 (elegir_V) ;
lin choose_V = escoger_V | elegir_V ;
lin wish_VV = mkVV (mkV "desear") ;
lin wish_VS = mkVS (mkV "desear") ;
lin wish_V2V = mkV2V (mkV "desear") ;
lin wish_V2 = mkV2 (mkV "desear") ;
lin wish_V = mkV "desear" ;
lin property_N = mkN "propiedad" feminine ;
lin property_2_N = mkN "propiedad" feminine ;
lin property_1_N = mkN "característica" ;
lin achieve_V2 = mkV2 (conseguir_V) | mkV2 (mkV "lograr") ;
lin financial_A = mkA "financiero" ;
lin poor_A = mkA "pobre" ;
lin poor_3_A = mkA "pobre" | mkA "mediocre" ;
lin poor_2_A = mkA "pobre" ;
lin poor_1_A = mkA "pobre" ;
lin officer_N = mkN "oficial" feminine ;
lin officer_3_N = mkN "oficial" | mkN "agente" ;
lin officer_2_N = mkN "oficial" ;
lin officer_1_N = mkN "oficial" ;
lin up_Prep = mkPrep "encima de" ;
lin charge_N = mkN "carga" ;
lin charge_2_N = mkN "acusación" ;
lin charge_1_N = mkN "carga" ;
lin director_N = mkN "director" masculine | mkN "directora" ;
lin drive_VS = mkVS (mkV "conducir") ;
lin drive_V2V = mkV2V (mkV "conducir") ;
lin drive_V2 = mkV2 (mkV "conducir") ;
lin drive_V = mkV "conducir" ;
lin deal_V2 = mkV2 (mkV "repartir") | mkV2 (mkV "asignar") ;
lin deal_V = mkV "repartir" | mkV "asignar" ;
lin place_V2 = mkV2 (mkV "colocar") | mkV2 (mkV "colocarse") ;
lin approach_N = mkN "enfoque" masculine | mkN "planteamiento" ;
lin chance_N = mkN "oportunidad" feminine | mkN "posibilidad" feminine ;
lin application_N = mkN "aplicación" feminine ;
lin seek_VV = mkVV (mkV "buscar") ;
lin seek_V2 = L.seek_V2 ;
lin foreign_A = mkA "extranjero" | mkA "forastero" ;
lin foreign_2_A = mkA "extraño" ;
lin foreign_1_A = mkA "extranjero" ;
lin along_Prep = mkPrep "por" | mkPrep "a lo largo de" ;
lin top_N = mkN "cima" ; --- split
lin amount_N = mkN "cantidad" feminine ;
lin son_N = mkN "hijo" ;
lin operation_N = mkN "operación" feminine ;
lin fail_VV = mkVV (mkV "fallar") ; ---- subcat
lin fail_V2V = mkV2V (mkV "fallar") ;
lin fail_V2 = mkV2 (mkV "fracasar") | mkV2 (mkV "fallar") ;
lin fail_V = mkV "fracasar" | mkV "fallar" ;
lin human_A = mkA "humano" ;
lin opportunity_N = mkN "oportunidad" feminine ;
lin simple_A = mkA "simple" | mkA "sencillo" ;
lin leader_N = mkN "líder" masculine | mkN "dirigente" masculine ;
lin look_N = mkN "vistazo" | mkN "ojeada" | mkN "mirada" ;
lin share_N = mkN "cuota" ;
lin production_N = mkN "producción" feminine ;
lin recent_A = mkA "reciente" ;
lin firm_N = mkN "firma" | mkN "empresa" ; --- split
lin picture_N = mkN "imagen" feminine ;
lin source_N = mkN "fuente" ;
lin security_N = mkN "seguridad" feminine | mkN "confianza" ;
lin serve_VV = mkVV servir_V ;
lin serve_VS = mkVS servir_V ;
lin serve_V2 = mkV2 servir_V ;
lin serve_V = servir_V ;
lin according_to_Prep = mkPrep "según" ;
lin end_VA = mkVA (mkV "acabarse") ;
lin end_V2 = mkV2 (mkV "acabar") ;
lin end_V = mkV "acabarse" ;
lin contract_N = mkN "contrato" ;
lin wide_A = L.wide_A ;
lin occur_V = mkV "ocurrir" ;
lin agreement_N = mkN "acuerdo" | mkN "convenio" ;
lin better_Adv = mkAdv "mejor" ;
lin kill_V2 = L.kill_V2 ;
lin kill_V = mkV "matar" ;
lin act_VA = mkVA (mkV "comportarse") ;
lin act_V2V = mkV2V (mkV "actuar") ; ---- subcat
lin act_V2 = mkV2 (mkV "actuar") ;
lin act_V = mkV "actuar" | mkV "comportarse" ;
lin site_N = mkN "sitio" ;
lin either_Adv = mkAdv "tampoco" ;
lin labour_N = mkN "parto" ;
lin plan_VV = mkVV (mkV "planear") ;
lin plan_VS = mkVS (mkV "planear") ;
lin plan_V2V = mkV2V (mkV "planear") ;
lin plan_V2 = mkV2 (mkV "planear") ;
lin plan_V = mkV "planear" ;
lin various_A = mkA "vario" | mkA "diverso" ;
lin since_Prep = mkPrep "desde" ;
lin test_N = mkN "examen" masculine | mkN "test" masculine ;
lin eat_V2 = L.eat_V2 ;
lin eat_V = mkV "comer" ;
lin loss_N = mkN "pérdida" ;
lin close_VS = mkVS (cerrar_V) ;
lin close_VA = mkVA (cerrar_V) ;
lin close_V2V = mkV2V (cerrar_V) ;
lin close_V2 = L.close_V2 ;
lin close_V = cerrar_V ;
lin represent_V2 = mkV2 (mkV "representar") ;
lin represent_V = mkV "representar" ;
lin love_VV = mkVV (mkV "encantar") | mkVV (mkV "gustar") | mkVV (mkV "adorar") ;
lin love_V2V = mkV2V (mkV "encantar") | mkV2V (mkV "gustar") | mkV2V (mkV "adorar") ;
lin love_V2 = L.love_V2 ;
lin colour_N = mkN "color" ;
lin clearly_Adv = mkAdv "claramente" ;
lin shop_N = L.shop_N ;
lin benefit_N = mkN "beneficio" | mkN "ventaja" ;
lin animal_N = L.animal_N ;
lin heart_N = L.heart_N ;
lin election_N = mkN "elección" feminine ;
lin purpose_N = mkN "propósito" ;
lin standard_N = mkN "estándar" masculine ;
lin due_A = mkA "debido" ;
lin secretary_N = mkN "secretario" ;
lin rise_VA = mkVA (mkV "levantarse") ;
lin rise_V2 = mkV2 (mkV "levantarse") ;
lin rise_V = mkV "levantarse" ;
lin date_N = mkN "cita" ;
lin date_7_N = mkN "dátil" ;
lin date_3_N = mkN "cita" ;
lin date_3_N = mkN "cita" ;
lin date_1_N = mkN "fecha" ;
lin hard_A = mkA "duro" | mkA "fuerte" ;
lin hard_2_A = mkA "difícil" | mkA "arduo" ;
lin hard_1_A = mkA "duro" ;
lin music_N = L.music_N ;
lin hair_N = L.hair_N ;
lin prepare_VV = aVV (mkV "preparar") ;
lin prepare_VS = mkVS (mkV "preparar") ;
lin prepare_V2V = mkV2V (mkV "preparar") ;
lin prepare_V2 = mkV2 (mkV "preparar") ;
lin prepare_V = mkV "preparar" ;
lin factor_N = mkN "factor" ;
lin other_A = mkA "otro" ;
lin anyone_NP = makeNP "cualquiera" Masc Sg ;
lin pattern_N = mkN "patrón" | mkN "diseño" ;
lin manage_VV = mkVV (mkV "lograr") ; --manage to do sth
lin manage_V2 = mkV2 (mkV "manejar") | mkV2 (mkV "administrar") ;
lin manage_V = mkV "manejar" | mkV "administrar" ;
lin piece_N = mkN "pieza" ;
lin discuss_VS = mkVS (mkV "conversar") | mkVS (mkV "discutir") ;
lin discuss_V2 = mkV2 (mkV "conversar") | mkV2 (mkV "discutir") ;
lin prove_VS = mkVS (mkV "demostrar") | mkVS (probar_V) ;
lin prove_VA = mkVA (mkV "resultar") ; --it proved right
lin prove_V2V = mkV2V (mkV "demostrar") | mkV2V (probar_V) ;
lin prove_V2 = mkV2 (mkV "demostrar") | mkV2 (probar_V) ;
lin prove_V = probar_V | mkV "resultar" ;
lin front_N = mkN "frente" masculine ;
lin evening_N = mkN "tarde" feminine ;
lin royal_A = mkA "real" ;
lin tree_N = L.tree_N ;
lin population_N = mkN "población" feminine ;
lin fine_A = mkA "fino" ;
lin plant_N = mkN "planta" ; --- split mkN "fábrica"
lin pressure_N = mkN "presión" feminine ;
lin response_N = mkN "respuesta" ;
lin catch_VS = mkVS (mkV "atrapar") ; ---- subcat
lin catch_V2 = mkV2 (mkV "atrapar") ;
lin catch_V = mkV "atrapar" ;
lin street_N = mkN "calle" feminine ;
lin pick_V2 = mkV2 (coger_V) | mkV2 recoger_V ;
lin pick_V = coger_V | recoger_V ;
lin performance_N = mkN "rendimiento" | mkN "desempeño" ;
lin performance_2_N = mkN "actuación" ;
lin performance_1_N = mkN "rendimiento" | mkN "desempeño" ;
lin knowledge_N = mkN "conocimiento" ;
lin despite_Prep = mkPrep "a pesar de" ;
lin design_N = mkN "diseño" ;
lin page_N = mkN "página" ;
lin enjoy_VV = mkVV (reflV divertir_V) ;
lin enjoy_V2 = mkV2 (mkV "disfrutar") | mkV2 (reflV divertir_V) ;
lin individual_N = mkN "individuo" ;
lin suppose_VS = mkVS (suponer_V) ;
lin suppose_V2V = mkV2V (suponer_V) ;
lin suppose_V2 = mkV2 (suponer_V) ;
lin rest_N = mkN "resto" ;
lin instead_Adv = mkAdv "en vez de" ;
lin wear_V2 = mkV2 (mkV "llevar") ; --wear clothes
lin wear_V = mkV "desgastarse" ; --wear out
lin basis_N = mkN "base" feminine ;
lin size_N = mkN "talla" ;
lin environment_N = mkN "ambiente" | mkN "medio" | mkN "entorno" ;
lin per_Prep = mkPrep "por" ;
lin fire_N = L.fire_N ;
lin fire_2_N = L.fire_N ; --- info missing in senses-in-Dictionary
lin fire_1_N = L.fire_N ; --- info missing in senses-in-Dictionary
lin series_N = mkN "serie" feminine ;
lin success_N = mkN "éxito" | mkN "acierto" ;
lin natural_A = mkA "natural" ;
lin wrong_A = mkA "malo" | mkA "incorrecto" ; --- split ? morally wrong / wrong answer in an exam
lin near_Prep = mkPrep "cerca de" ;
lin round_Adv = mkAdv "alrededor" ;
lin thought_N = mkN "pensamiento" ;
lin list_N = mkN "lista" ;
lin argue_VS = mkVS (mkV "argumentar") | mkVS (mkV "debatir") ; --- split
lin argue_V2 = mkV2 (mkV "argumentar") | mkV2 (mkV "debatir") ;
lin argue_V = mkV "argumentar" | mkV "debatir" ;
lin final_A = mkA "final" | mkA "último" ;
lin future_N = mkN "futuro" | mkN "porvenir" ;
lin future_3_N = future_N ; --- info missing in senses-in-Dictionary
lin future_1_N = future_N ; --- info missing in senses-in-Dictionary
lin introduce_V2 = mkV2 introducir_V | mkV2 (mkV "presentar") ;
lin analysis_N = mkN "análisis" masculine ;
lin enter_V2 = mkV2 (mkV "entrar") ;
lin enter_V = mkV "entrar" ;
lin space_N = mkN "espacio" ;
lin arrive_V2 = mkV2 (mkV "llegar") | mkV2 (mkV "arribar") ;
lin arrive_V = mkV "llegar" | mkV "arribar" ;
lin ensure_VS = mkVS (mkV "asegurar") | mkVS (mkV "asegurarse") ;
lin ensure_V2 = mkV2 (mkV "asegurar") | mkV2 (mkV "asegurarse") ;
lin ensure_V = mkV "asegurar" | mkV "asegurarse" ;
lin demand_N = mkN "demanda" | mkN "exigencia" ;
lin statement_N = mkN "declaración" feminine ;
lin to_Adv = mkAdv "a" ; ---- what is this?
lin attention_N = mkN "atención" ;
lin love_N = L.love_N ;
lin principle_N = mkN "principio" ;
lin pull_V2 = L.pull_V2 ;
lin pull_V = mkV "tirar" ;
lin set_N = mkN "conjunto" ;
lin set_2_N = mkN "conjunto" ;
lin set_1_N = mkN "equipo" ;
lin doctor_N = L.doctor_N ;
lin choice_N = mkN "selección" feminine | mkN "decisión" feminine | mkN "opción" feminine ;
lin refer_V2 = mkV2 (reflV referir_V) to_Prep | mkV2 referir_V to_Prep ;
lin refer_V = reflV referir_V ;
lin feature_N = mkN "característica" ;
lin couple_N = mkN "pareja" ;
lin step_N = mkN "paso" ;
lin following_A = mkA "siguiente" ;
lin thank_V2 = mkV2 agradecer_V | mkV2 agradecer_V to_Prep ;
lin machine_N = mkN "máquina" ;
lin income_N = mkN "ingreso" | mkN "renta" ; --- ingresos in plural
lin training_N = mkN "formación" | mkN "entrenamiento" ;
lin present_V2 = mkV2 (mkV "presentar") ;
lin association_N = mkN "asociación" feminine ;
lin film_N = mkN "película" ;
lin film_2_N = mkN "capa" ;
lin film_1_N = mkN "película" ;
lin region_N = mkN "región" feminine ;
lin effort_N = mkN "esfuerzo" ;
lin player_N = mkN "jugador" | mkN "jugadora" ;
lin everyone_NP = makeNP "todo el mundo" Masc Sg | makeNP "todos" Masc Pl ;
lin present_A = mkA "presente" ;
lin award_N = mkN "premio" ;
lin village_N = L.village_N ;
lin control_V2 = mkV2 (mkV "controlar") ;
lin control_V = mkV "controlar" ;
lin organisation_N = mkN "organización" ;
lin whatever_Det = mkDet "cualquier" ;
lin news_N = mkN "agencia de información" | mkN "agencia de noticias" ;
lin nice_A = mkA "bonito" | mkA "bello" | mkA "lindo" ;
lin difficulty_N = mkN "dificultad" feminine ;
lin modern_A = mkA "moderno" ;
lin cell_N = mkN "célula" ; --- split
lin close_A = mkA "cercano" ;
lin current_A = mkA "actual" ;
lin legal_A = mkA "legal" ;
lin energy_N = mkN "energía" ;
lin finally_Adv = mkAdv "finalmente" ;
lin degree_N = mkN "grado" ;
lin degree_3_N = mkN "grado" ;
lin degree_2_N = mkN "licenciatura" ;
lin degree_1_N = mkN "grado" | mkN "nivel" ;
lin mile_N = mkN "milla" ;
lin means_N = mkN "medio" | mkN "manera" ;
lin growth_N = mkN "crecimiento" ;
lin treatment_N = mkN "tratamiento" ;
lin sound_N = mkN "sonido" ;
lin above_Prep = S.above_Prep ;
lin task_N = mkN "tarea" ;
lin provision_N = mkN "provisión" ;
lin affect_V2 = mkV2 (mkV "afectar") ;
lin please_Adv = mkAdv "por favor" ;
lin red_A = L.red_A ;
lin happy_A = mkA "feliz" ;
lin behaviour_N = mkN "comportamiento" ;
lin concerned_A = mkA "preocupado" ;
lin point_V2 = mkV2 (mkV "indicar") | mkV2 (mkV "apuntar") | mkV2 (mkV "señalar");
lin point_V = mkV "indicar" | mkV "apuntar" ;
lin function_N = mkN "función" feminine ;
lin identify_V2 = mkV2 (mkV "identificar") ;
lin identify_V = mkV "identificar" | mkV "identificarse" ;
lin resource_N = mkN "recurso" | mkN "medio" ;
lin defence_N = mkN "defensa" ;
lin garden_N = L.garden_N ;
lin floor_N = L.floor_N ;
lin technology_N = mkN "tecnología" ;
lin style_N = mkN "estilo" ;
lin feeling_N = mkN "sentimiento" | mkN "emoción" feminine ;
lin science_N = L.science_N ;
lin relate_V2 = variants{} ; -- 
lin relate_V = variants{} ; -- 
lin doubt_N = mkN "duda" | mkN "incertidumbre" feminine ; -- status=guess
lin horse_N = L.horse_N ;
lin force_VS = mkVS (forzar_V) ; -- status=guess
lin force_V2V = mkV2V (forzar_V) ; -- status=guess
lin force_V2 = mkV2 (forzar_V) ; -- status=guess
lin force_V = forzar_V ; -- status=guess
lin answer_N = mkN "contestación" feminine ; -- status=guess
lin compare_V2 = mkV2 (mkV "comparar") ; -- status=guess
lin compare_V = mkV "comparar" ; -- status=guess
lin suffer_V2 = mkV2 (mkV "empeorar") ; -- status=guess
lin suffer_V = mkV "empeorar" ; -- status=guess
lin individual_A = mkA "individual" ; -- status=guess
lin forward_Adv = mkAdv "adelante" | mkAdv "avante" ; -- status=guess
lin announce_VS = mkVS (mkV "anunciar") ; -- status=guess
lin announce_V2 = mkV2 (mkV "anunciar") ; -- status=guess
lin user_N = variants{} ; -- 
lin fund_N = mkN "fondo" ; -- status=guess
lin character_2_N = variants{} ; -- 
lin character_1_N = variants{} ; -- 
lin risk_N = mkN "riesgo" ; -- status=guess
lin normal_A = mkA "normal" ; -- status=guess
lin nor_Conj = mkConj "ni" ; -- status=guess
lin dog_N = L.dog_N ;
lin obtain_V2 = mkV2 (obtener_V) ; -- status=guess
lin obtain_V = obtener_V ; -- status=guess
lin quickly_Adv = variants{} ; -- 
lin army_N = mkN "multitud" feminine ; -- status=guess
lin indicate_VS = mkVS (mkV "indicar") ; -- status=guess
lin indicate_V2 = mkV2 (mkV "indicar") ; -- status=guess
lin indicate_V = mkV "indicar" ; -- status=guess
lin forget_VS = mkVS (mkV "olvídalo") ; -- status=guess
lin forget_V2 = L.forget_V2 ;
lin forget_V = mkV "olvídalo" ; -- status=guess
lin station_N = mkN "estación" feminine ; -- status=guess
lin glass_N = mkN "vidrio" feminine ; -- status=guess
lin cup_N = mkN "copa" ; -- status=guess
lin previous_A = mkA "previo" | mkA "anterior" ; -- status=guess
lin husband_N = L.husband_N ;
lin recently_Adv = variants{} ; -- 
lin publish_V2 = mkV2 (mkV "publicar") | mkV2 (mkV "divulgar") ; -- status=guess
lin publish_V = mkV "publicar" | mkV "divulgar" ; -- status=guess
lin serious_A = mkA "serio" ; -- status=guess
lin anyway_Adv = mkAdv "en fin" | mkAdv "de todos modos" ; -- status=guess
lin visit_V2V = mkV2V (mkV "visitar") ; -- status=guess
lin visit_V2 = mkV2 (mkV "visitar") ; -- status=guess
lin visit_V = mkV "visitar" ; -- status=guess
lin capital_N = mkN "capital" masculine ; -- status=guess
lin capital_3_N = variants{} ; -- 
lin capital_2_N = variants{} ; -- 
lin capital_1_N = variants{} ; -- 
lin either_Det = mkDet "cada" ; -- status=guess
lin note_N = mkN "nota" ; -- status=guess
lin note_3_N = variants{} ; -- 
lin note_2_N = variants{} ; -- 
lin note_1_N = variants{} ; -- 
lin season_N = mkN "temporada" ; -- status=guess
lin argument_N = mkN "argumento" ; -- status=guess
lin listen_V = mkV "escuchar" ; -- status=guess
lin show_N = mkN "programa" masculine ; -- status=guess
lin responsibility_N = mkN "responsabilidad" feminine ; -- status=guess
lin significant_A = mkA "significativo" ; -- status=guess
lin deal_N = mkN "acuerdo" ; -- status=guess
lin prime_A = mkA "primo" | mkA "primoroso" | mkA "excelente" ; -- status=guess
lin economy_N = mkN "economía" ; -- status=guess
lin economy_2_N = variants{} ; -- 
lin economy_1_N = variants{} ; -- 
lin element_N = mkN "elemento" feminine ; -- status=guess
lin finish_VA = mkVA (mkV "terminar") ; -- status=guess
lin finish_V2 = mkV2 (mkV "terminar") ; -- status=guess
lin finish_V = mkV "terminar" ; -- status=guess
lin duty_N = mkN "arancel" masculine ; -- status=guess
lin fight_V2V = mkV2V (mkV "pelear") | mkV2V (mkV "luchar") ; -- status=guess
lin fight_V2 = L.fight_V2 ;
lin fight_V = mkV "pelear" | mkV "luchar" ; -- status=guess
lin train_V2V = mkV2V (mkV "entrenar") ; -- status=guess
lin train_V2 = mkV2 (mkV "entrenar") ; -- status=guess
lin train_V = mkV "entrenar" ; -- status=guess
lin maintain_VS = mkVS (mantener_V) ; -- status=guess
lin maintain_V2 = mkV2 (mantener_V) ; -- status=guess
lin maintain_V = mantener_V ; -- status=guess
lin attempt_N = mkN "atentado" ; -- status=guess
lin leg_N = L.leg_N ;
lin investment_N = mkN "inversión" feminine ; -- status=guess
lin save_V2 = mkV2 (mkV "ahorrar") ; -- status=guess
lin save_V = mkV "ahorrar" ; -- status=guess
lin throughout_Prep = variants{} ; -- 
lin design_V2V = mkV2V (mkV "diseñar") ; -- status=guess
lin design_V2 = mkV2 (mkV "diseñar") ; -- status=guess
lin design_V = mkV "diseñar" ; -- status=guess
lin suddenly_Adv = variants{} ; -- 
lin brother_N = mkN "cuñado" ; -- status=guess
lin improve_V2 = mkV2 (mkV "mejorar") ; -- status=guess
lin improve_V = mkV "mejorar" ; -- status=guess
lin avoid_VV = mkVV (mkV "evitar") ; -- status=guess
lin avoid_V2 = mkV2 (mkV "evitar") ; -- status=guess
lin wonder_VQ = L.wonder_VQ ;
lin wonder_V2 = mkV2 (mkV "preguntarse") | mkV2 (mkV "ponderar") ; -- status=guess
lin wonder_V = mkV "preguntarse" | mkV "ponderar" ; -- status=guess
lin tend_VV = mkVV (tender_V) ; -- status=guess
lin tend_V2 = mkV2 (tender_V) ; -- status=guess
lin tend_V = tender_V ; -- status=guess
lin title_N = mkN "escritura de propiedad" | mkN "título traslativo de dominio" ; -- status=guess
lin hotel_N = mkN "hotel" | mkN "albergue" masculine ; -- status=guess
lin aspect_N = mkN "aspecto" ; -- status=guess
lin increase_N = variants{} ; -- 
lin help_N = mkN "ayuda" | mkN "socorro" | mkN "auxilio" ; -- status=guess
lin industrial_A = mkA "industrial" ; -- status=guess
lin express_V2 = mkV2 (mkV "expresar") ; -- status=guess
lin summer_N = mkN "verano" ; -- status=guess
lin determine_VV = mkVV (mkV "determinar") ; -- status=guess
lin determine_VS = mkVS (mkV "determinar") ; -- status=guess
lin determine_V2V = mkV2V (mkV "determinar") ; -- status=guess
lin determine_V2 = mkV2 (mkV "determinar") ; -- status=guess
lin determine_V = mkV "determinar" ; -- status=guess
lin generally_Adv = variants{} ; -- 
lin daughter_N = mkN "hija" ; -- status=guess
lin exist_V2V = mkV2V (mkV "existir") ; -- status=guess
lin exist_V = mkV "existir" ; -- status=guess
lin share_V2 = mkV2 (mkV "dividir") ; -- status=guess
lin share_V = mkV "dividir" ; -- status=guess
lin baby_N = L.baby_N ;
lin nearly_Adv = variants{} ; -- 
lin smile_V2 = mkV2 (sonreír_V) ; -- status=guess
lin smile_V = sonreír_V ; -- status=guess
lin sorry_A = mkA "lo siento" | mkA "pobre" ; -- status=guess
lin sea_N = L.sea_N ;
lin skill_N = mkN "habilidad" feminine | mkN "talento" | mkN "destreza" | mkN "maña" ; -- status=guess
lin claim_N = mkN "concesión" feminine ; -- status=guess
lin treat_V2 = mkV2 (mkV "tratar") ; -- status=guess
lin treat_V = mkV "tratar" ; -- status=guess
lin remove_V2 = mkV2 (mkV "quitar") | mkV2 (remover_V) ; -- status=guess
lin remove_V = mkV "quitar" | remover_V ; -- status=guess
lin concern_N = mkN "preocupación" feminine ; -- status=guess
lin university_N = L.university_N ;
lin left_A = mkA "zurdo" ; -- status=guess
lin dead_A = mkA "muerto" ; -- status=guess
lin discussion_N = mkN "discusión" feminine ; -- status=guess
lin specific_A = mkA "específico" ; -- status=guess
lin customer_N = variants{} ; -- 
lin box_N = mkN "boj" masculine ; -- status=guess
lin outside_Prep = variants{} ; -- 
lin state_VS = mkVS (mkV "declarar") ; -- status=guess
lin state_V2 = mkV2 (mkV "declarar") ; -- status=guess
lin conference_N = mkN "conferencia" ; -- status=guess
lin whole_N = mkN "totalidad" feminine ; -- status=guess
lin total_A = mkA "total" ; -- status=guess
lin profit_N = mkN "ganancia" | mkN "beneficio" ; -- status=guess
lin division_N = mkN "división" feminine ; -- status=guess
lin division_3_N = variants{} ; -- 
lin division_2_N = variants{} ; -- 
lin division_1_N = variants{} ; -- 
lin throw_V2 = L.throw_V2 ;
lin throw_V = mkV "tirar" | mkV "echar" | mkV "desechar" ; -- status=guess
lin procedure_N = mkN "procedimiento" ; -- status=guess
lin fill_V2 = mkV2 (mkV "llenar") ; -- status=guess
lin fill_V = mkV "llenar" ; -- status=guess
lin king_N = L.king_N ;
lin assume_VS = mkVS (mkV "asumir") ; -- status=guess
lin assume_V2 = mkV2 (mkV "asumir") ; -- status=guess
lin assume_V = mkV "asumir" ; -- status=guess
lin image_N = mkN "imagen" feminine ; -- status=guess
lin oil_N = L.oil_N ;
lin obviously_Adv = variants{} ; -- 
lin unless_Subj = variants{} ; -- 
lin appropriate_A = mkA "apropiado" ; -- status=guess
lin circumstance_N = mkN "circunstancia" ; -- status=guess
lin military_A = mkA "militar" ; -- status=guess
lin proposal_N = mkN "propuesta" ; -- status=guess
lin mention_VS = mkVS (mkV "mencionar") ; -- status=guess
lin mention_V2 = mkV2 (mkV "mencionar") ; -- status=guess
lin mention_V = mkV "mencionar" ; -- status=guess
lin client_N = mkN "cliente" masculine ; -- status=guess
lin sector_N = mkN "sector" masculine ; -- status=guess
lin direction_N = mkN "dirección" feminine ; -- status=guess
lin admit_VS = mkVS (mkV (mkV "dejar") "entrar") ; -- status=guess
lin admit_V2 = mkV2 (mkV (mkV "dejar") "entrar") ; -- status=guess
lin admit_V = mkV (mkV "dejar") "entrar" ; -- status=guess
lin though_Adv = mkAdv "no obstante" ; -- status=guess
lin replace_VV = mkVV (mkV "reemplazar") ; -- status=guess
lin replace_V2 = mkV2 (mkV "reemplazar") ; -- status=guess
lin basic_A = mkA "básico" ; -- status=guess
lin hard_Adv = variants{} ; -- 
lin instance_N = mkN "caso" ; -- status=guess
lin sign_N = mkN "símbolo" ; -- status=guess
lin original_A = mkA "original" ; -- status=guess
lin successful_A = mkA "exitoso" | mkA "triunfador" ; -- status=guess
lin okay_Adv = variants{} ; -- 
lin reflect_V2 = mkV2 (mkV "reflejar") ; -- status=guess
lin reflect_V = mkV "reflejar" ; -- status=guess
lin aware_A = mkA "consciente" ; -- status=guess
lin measure_N = mkN "medición" feminine ; -- status=guess
lin attitude_N = mkN "actitud" feminine ; -- status=guess
lin disease_N = mkN "enfermedad" feminine ; -- status=guess
lin exactly_Adv = variants{} ; -- 
lin above_Adv = mkAdv "sobre todo" ; -- status=guess
lin commission_N = mkN "comisión" feminine ; -- status=guess
lin intend_VV = mkVV (mkV "intentar") ; -- status=guess
lin intend_V2V = mkV2V (mkV "intentar") ; -- status=guess
lin intend_V2 = mkV2 (mkV "intentar") ; -- status=guess
lin intend_V = mkV "intentar" ; -- status=guess
lin beyond_Prep = variants{} ; -- 
lin seat_N = mkN "asiento" ; -- status=guess
lin president_N = variants{} ; -- 
lin encourage_V2V = mkV2V (mkV "animar") | mkV2V (alentar_V) ; -- status=guess
lin encourage_V2 = mkV2 (mkV "animar") | mkV2 (alentar_V) ; -- status=guess
lin addition_N = mkN "adición" feminine | mkN "añadidura" ; -- status=guess
lin goal_N = mkN "portería" ; -- status=guess
lin round_Prep = variants{} ; -- 
lin miss_V2 = mkV2 (perder_V) ; -- status=guess
lin miss_V = perder_V ; -- status=guess
lin popular_A = mkA "popular" ; -- status=guess
lin affair_N = mkN "amorío" | mkN "aventura" ; -- status=guess
lin technique_N = mkN "técnica" ; -- status=guess
lin respect_N = mkN "respeto" ; -- status=guess
lin drop_V2 = mkV2 (regar_V) | mkV2 (mkV "esparcir") ; -- status=guess
lin drop_V = regar_V | mkV "esparcir" ; -- status=guess
lin professional_A = mkA "profesional" ; -- status=guess
lin less_Det = variants{} ; -- 
lin once_Subj = variants{} ; -- 
lin item_N = mkN "ítem" ; -- status=guess
lin fly_VS = mkVS (mkV (mkV "perder") "los estribos") ; -- status=guess
lin fly_V2 = mkV2 (mkV (mkV "perder") "los estribos") ; -- status=guess
lin fly_V = L.fly_V ;
lin reveal_VS = mkVS (mkV "revelar") | mkVS (mkV "propalar") ; -- status=guess
lin reveal_V2 = mkV2 (mkV "revelar") | mkV2 (mkV "propalar") ; -- status=guess
lin version_N = mkN "versión" feminine ; -- status=guess
lin maybe_Adv = mkAdv "es posible" ; -- status=guess
lin ability_N = mkN "capacidad" feminine ; -- status=guess
lin operate_V2 = mkV2 (mkV "operar") ; -- status=guess
lin operate_V = mkV "operar" ; -- status=guess
lin good_N = mkN "bien" masculine ; -- status=guess
lin campaign_N = mkN "campaña" ; -- status=guess
lin heavy_A = L.heavy_A ;
lin advice_N = mkN "aviso" ; -- status=guess
lin institution_N = mkN "institución" feminine ; -- status=guess
lin discover_VS = mkVS (descubrir_V) | mkVS (mkV "destapar") ; -- status=guess
lin discover_V2V = mkV2V (descubrir_V) | mkV2V (mkV "destapar") ; -- status=guess
lin discover_V2 = mkV2 (descubrir_V) | mkV2 (mkV "destapar") ; -- status=guess
lin discover_V = descubrir_V | mkV "destapar" ; -- status=guess
lin surface_N = mkN "superficie" feminine ; -- status=guess
lin library_N = mkN "biblioteca" masculine | mkN "librería" ; -- status=guess
lin pupil_N = mkN "alumno" | mkN "alumna" ; -- status=guess
lin record_V2 = mkV2 (mkV "registrar") | mkV2 (mkV "anotar") ; -- status=guess
lin refuse_VV = mkVV (mkV "rehusar") ; -- status=guess
lin refuse_V2 = mkV2 (mkV "rehusar") ; -- status=guess
lin refuse_V = mkV "rehusar" ; -- status=guess
lin prevent_V2 = mkV2 (impedir_V) | mkV2 (prevenir_V) ; -- status=guess
lin advantage_N = mkN "ventaja" ; -- status=guess
lin dark_A = mkA "oscuro" ; -- status=guess
lin teach_V2V = mkV2V (mkV "enseñar") ; -- status=guess
lin teach_V2 = L.teach_V2 ;
lin teach_V = mkV "enseñar" ; -- status=guess
lin memory_N = mkN "memoria" ; -- status=guess
lin culture_N = mkN "cultura" masculine ; -- status=guess
lin blood_N = L.blood_N ;
lin cost_V2 = mkV2 (costar_V) ; -- status=guess
lin cost_V = costar_V ; -- status=guess
lin majority_N = mkN "mayoría" ; -- status=guess
lin answer_V2 = mkV2 (mkV "responder") | mkV2 (mkV "contestar") ; -- status=guess
lin answer_V = mkV "responder" | mkV "contestar" ; -- status=guess
lin variety_N = mkN "variedad" feminine ; -- status=guess
lin variety_2_N = variants{} ; -- 
lin variety_1_N = variants{} ; -- 
lin press_N = mkN "rueda de prensa" ; -- status=guess
lin depend_V = variants{} ; -- 
lin bill_N = mkN "pico" feminine ; -- status=guess
lin competition_N = mkN "competición" feminine ; -- status=guess
lin ready_A = mkA "preparado" | mkA "listo" ; -- status=guess
lin general_N = mkN "general" masculine ; -- status=guess
lin access_N = mkN "código de acceso" ; -- status=guess
lin hit_V2 = L.hit_V2 ;
lin hit_V = mkV "simpatizar" ; -- status=guess
lin stone_N = L.stone_N ;
lin useful_A = mkA "útil" ; -- status=guess
lin extent_N = variants{} ; -- 
lin employment_N = mkN "agencia de empleo" ; -- status=guess
lin regard_V2 = variants{} ; -- 
lin regard_V = variants{} ; -- 
lin apart_Adv = mkAdv "aparte" ; -- status=guess
lin present_N = mkN "presente" masculine | mkN "actual" | mkN "ahora" masculine ; -- status=guess
lin appeal_N = mkN "apelación" feminine ; -- status=guess
lin text_N = mkN "texto" ; -- status=guess
lin parliament_N = mkN "parlamento" ; -- status=guess
lin cause_N = mkN "causa" ; -- status=guess
lin terms_N = variants{} ; -- 
lin bar_N = mkN "bar" masculine ; -- status=guess
lin bar_2_N = variants{} ; -- 
lin bar_1_N = variants{} ; -- 
lin attack_N = mkN "ataque" masculine ; -- status=guess
lin effective_A = mkA "efectivo" | mkA "eficaz" ; -- status=guess
lin mouth_N = L.mouth_N ;
lin down_Prep = variants{} ; -- 
lin result_V = mkV "resultar" ; -- status=guess
lin fish_N = L.fish_N ;
lin future_A = mkA "futuro" ; -- status=guess
lin visit_N = mkN "visita" ; -- status=guess
lin little_Adv = variants{} ; -- 
lin easily_Adv = variants{} ; -- 
lin attempt_VV = mkVV (mkV "intentar") | mkVV (mkV (mkV "tratar") "de") ; -- status=guess
lin attempt_V2 = mkV2 (mkV "intentar") | mkV2 (mkV (mkV "tratar") "de") ; -- status=guess
lin enable_VS = mkVS (mkV "habilitar") ; -- status=guess
lin enable_V2V = mkV2V (mkV "habilitar") ; -- status=guess
lin enable_V2 = mkV2 (mkV "habilitar") ; -- status=guess
lin trouble_N = mkN "problema" masculine | mkN "pena" ; -- status=guess
lin traditional_A = mkA "tradicional" ; -- status=guess
lin payment_N = mkN "pago" ; -- status=guess
lin best_Adv = variants{} ; -- 
lin post_N = mkN "poste" | mkN "estaca" ; -- status=guess
lin county_N = mkN "condado" ; -- status=guess
lin lady_N = mkN "ama" ; -- status=guess
lin holiday_N = mkN "día feriado" ; -- status=guess
lin realize_VS = mkVS (mkV (mkV "darse") "cuenta") | mkVS (mkV "comprender") ; -- status=guess
lin realize_V2 = mkV2 (mkV (mkV "darse") "cuenta") | mkV2 (mkV "comprender") ; -- status=guess
lin importance_N = mkN "importancia" ; -- status=guess
lin chair_N = L.chair_N ;
lin facility_N = mkN "facilidad" feminine ; -- status=guess
lin complete_V2 = mkV2 (mkV "terminar") ; -- status=guess
lin complete_V = mkV "terminar" ; -- status=guess
lin article_N = mkN "artículo" ; -- status=guess
lin object_N = mkN "complemento" | mkN "objeto" ; -- status=guess
lin context_N = mkN "contexto" | mkN "marco" ; -- status=guess
lin survey_N = mkN "encuesta" ; -- status=guess
lin notice_VS = mkVS (mkV (mkV "darse") "cuenta") ; -- status=guess
lin notice_V2 = mkV2 (mkV (mkV "darse") "cuenta") ; -- status=guess
lin notice_V = mkV (mkV "darse") "cuenta" ; -- status=guess
lin complete_A = mkA "completo" ; -- status=guess
lin turn_N = mkN "turno" ; -- status=guess
lin direct_A = mkA "directo" ; -- status=guess
lin immediately_Adv = variants{} ; -- 
lin collection_N = mkN "recogida" | mkN "recolección" feminine ; -- status=guess
lin reference_N = mkN "referencia" ; -- status=guess
lin card_N = mkN "carta" | mkN "tarjeta" ; -- status=guess
lin interesting_A = mkA "interesante" ; -- status=guess
lin considerable_A = mkA "considerable" ; -- status=guess
lin television_N = L.television_N ;
lin extend_V2 = mkV2 (extender_V) | mkV2 (mkV "ampliar") ; -- status=guess
lin extend_V = extender_V | mkV "ampliar" ; -- status=guess
lin communication_N = mkN "comunicación" feminine ; -- status=guess
lin agency_N = mkN "albedrío" | mkN "agency" | mkN "agencia" ; -- status=guess
lin physical_A = mkA "físico" ; -- status=guess
lin except_Conj = variants{} ; -- 
lin check_V2 = mkV2 (mkV "registrarse") ; -- status=guess
lin check_V = mkV "registrarse" ; -- status=guess
lin sun_N = L.sun_N ;
lin species_N = mkN "especie" feminine ; -- status=guess
lin possibility_N = mkN "posibilidad" feminine ; -- status=guess
lin official_N = variants{} ; -- 
lin chairman_N = mkN "presidente" masculine ; -- status=guess
lin speaker_N = mkN "altavoz" masculine ; -- status=guess
lin second_N = mkN "segundo" ; -- status=guess
lin career_N = mkN "carrera" ; -- status=guess
lin laugh_VS = mkVS (mkV (mkV "reírse") "de") ; -- status=guess
lin laugh_V2 = mkV2 (mkV (mkV "reírse") "de") ; -- status=guess
lin laugh_V = L.laugh_V ;
lin weight_N = mkN "masa" ; -- status=guess
lin sound_VS = mkVS (mkV "sondear") ; -- status=guess
lin sound_VA = mkVA (mkV "sondear") ; -- status=guess
lin sound_V2 = mkV2 (mkV "sondear") ; -- status=guess
lin sound_V = mkV "sondear" ; -- status=guess
lin responsible_A = mkA "responsable" ; -- status=guess
lin base_N = mkN "base" feminine ; -- status=guess
lin document_N = mkN "documento" ; -- status=guess
lin solution_N = mkN "solución" feminine ; -- status=guess
lin return_N = mkN "regresar" | mkN "retornar" | mkN "volver" ; -- status=guess
lin medical_A = variants{} ; -- 
lin hot_A = L.hot_A ;
lin recognize_VS = mkVS (reconocer_V) ; -- status=guess
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin talk_N = mkN "conversación" feminine ; -- status=guess
lin budget_N = mkN "presupuesto" ; -- status=guess
lin river_N = L.river_N ;
lin fit_V2 = mkV2 (mkV (mkV "hacer") "juego") ; -- status=guess
lin fit_V = mkV (mkV "hacer") "juego" ; -- status=guess
lin organization_N = mkN "organización" feminine ; -- status=guess
lin existing_A = variants{} ; -- 
lin start_N = mkN "inicio" | mkN "comienzo" ; -- status=guess
lin push_VS = mkVS (mkV "pujar") ; -- status=guess
lin push_V2V = mkV2V (mkV "pujar") ; -- status=guess
lin push_V2 = L.push_V2 ;
lin push_V = mkV "pujar" ; -- status=guess
lin tomorrow_Adv = mkAdv "mañana" ; -- status=guess
lin requirement_N = mkN "exigencia" | mkN "requisito" ; -- status=guess
lin cold_A = L.cold_A ;
lin edge_N = mkN "ventaja" ; -- status=guess
lin opposition_N = variants{} ; -- 
lin opinion_N = mkN "opinión" feminine ; -- status=guess
lin drug_N = mkN "drogadicto" | mkN "toxicómano" | mkN "pichicatero" ; -- status=guess
lin quarter_N = mkN "cora" | mkN "cuarto" ; -- status=guess
lin option_N = mkN "opción financiera" | mkN "opciones" feminine ; -- status=guess
lin sign_V2V = mkV2V (mkV (mkV "hablar") "a señas") ; -- status=guess
lin sign_V2 = mkV2 (mkV (mkV "hablar") "a señas") ; -- status=guess
lin sign_V = mkV (mkV "hablar") "a señas" ; -- status=guess
lin worth_Prep = variants{} ; -- 
lin call_N = mkN "convocatoria" ; -- status=guess
lin define_V2 = mkV2 (mkV "delimitar") | mkV2 (mkV "demarcar") | mkV2 (mkV "definir") ; -- status=guess
lin define_V = mkV "delimitar" | mkV "demarcar" | mkV "definir" ; -- status=guess
lin stock_N = mkN "caldo" ; -- status=guess
lin influence_N = mkN "influencia" ; -- status=guess
lin occasion_N = mkN "ocasión" feminine ; -- status=guess
lin eventually_Adv = variants{} ; -- 
lin software_N = mkN "software" | mkN "programa" masculine ; -- status=guess
lin highly_Adv = variants{} ; -- 
lin exchange_N = mkN "intercambio" ; -- status=guess
lin lack_N = mkN "falta" | mkN "carencia" ; -- status=guess
lin shake_V2 = mkV2 (mkV "agitar") ; -- status=guess
lin shake_V = mkV "agitar" ; -- status=guess
lin study_V2 = mkV2 (mkV "estudiar") | mkV2 (mkV "examinar") ; -- status=guess
lin study_V = mkV "estudiar" | mkV "examinar" ; -- status=guess
lin concept_N = mkN "concepto" ; -- status=guess
lin blue_A = L.blue_A ;
lin star_N = L.star_N ;
lin radio_N = L.radio_N ;
lin arrangement_N = mkN "arreglo" ; -- status=guess
lin examine_V2 = variants{} ; -- 
lin bird_N = L.bird_N ;
lin green_A = L.green_A ;
lin band_N = mkN "curita" | mkN " parche curita" | mkN "tirita" | mkN "apósito" | mkN "esparadrapo" ; -- status=guess
lin sex_N = mkN "sexo" ; -- status=guess
lin finger_N = mkN "dedo" feminine ; -- status=guess
lin past_N = mkN "pretérito" ; -- status=guess
lin independent_A = mkA "independiente" ; -- status=guess
lin independent_2_A = variants{} ; -- 
lin independent_1_A = variants{} ; -- 
lin equipment_N = mkN "equipamiento" | mkN "equipo" ; -- status=guess
lin north_N = mkN "norte" masculine ; -- status=guess
lin mind_VS = variants{} ; -- 
lin mind_V2 = variants{} ; -- 
lin mind_V = variants{} ; -- 
lin move_N = mkN "mudanza" ; -- status=guess
lin message_N = mkN "mensaje" | mkN "recado" ; -- status=guess
lin fear_N = mkN "miedo" ; -- status=guess
lin afternoon_N = mkN "tarde" feminine ; -- status=guess
lin drink_V2 = L.drink_V2 ;
lin drink_V = mkV "beber" | mkV "tomar" ; -- status=guess
lin fully_Adv = variants{} ; -- 
lin race_N = mkN "raza" ; -- status=guess
lin race_2_N = variants{} ; -- 
lin race_1_N = variants{} ; -- 
lin gain_V2 = mkV2 (mkV "ganar") ; -- status=guess
lin gain_V = mkV "ganar" ; -- status=guess
lin strategy_N = mkN "estrategia" ; -- status=guess
lin extra_A = mkA "exceso" ; -- status=guess
lin scene_N = mkN "escena" ; -- status=guess
lin slightly_Adv = variants{} ; -- 
lin kitchen_N = mkN "cocina" masculine ; -- status=guess
lin speech_N = mkN "discurso" ; -- status=guess
lin arise_VS = mkVS (surgir_V) | mkVS (mkV "levantarse") ; -- status=guess
lin arise_V = surgir_V | mkV "levantarse" ; -- status=guess
lin network_N = mkN "red" feminine ; -- status=guess
lin tea_N = mkN "taza de té" ; -- status=guess
lin peace_N = L.peace_N ;
lin failure_N = mkN "fracasado" ; -- status=guess
lin employee_N = mkN "empleado" | mkN "empleada" ; -- status=guess
lin ahead_Adv = mkAdv "enfrente de" ; -- status=guess
lin scale_N = mkN "escala" ; -- status=guess
lin hardly_Adv = variants{} ; -- 
lin attend_V2 = mkV2 (mkV "asistir") ; -- status=guess
lin attend_V = mkV "asistir" ; -- status=guess
lin shoulder_N = mkN "omóplato" | mkN "escápula" ; -- status=guess
lin otherwise_Adv = mkAdv "de otra manera" ; -- status=guess
lin railway_N = mkN "estación de ferrocarril" | mkN "estación" feminine ; -- status=guess
lin directly_Adv = variants{} ; -- 
lin supply_N = mkN "abasto" | mkN "abastecimiento" | mkN "suministro" ; -- status=guess
lin expression_N = mkN "expresión" feminine ; -- status=guess
lin owner_N = mkN "propietario" | mkN "dueño" | mkN "poseedor" masculine ; -- status=guess
lin associate_V2 = mkV2 (mkV "asociar") ; -- status=guess
lin associate_V = mkV "asociar" ; -- status=guess
lin corner_N = mkN "ángulo" | mkN "rincón" masculine ; -- status=guess
lin past_A = variants{} ; -- 
lin match_N = mkN "igual" ; -- status=guess
lin match_3_N = variants{} ; -- 
lin match_2_N = variants{} ; -- 
lin match_1_N = variants{} ; -- 
lin sport_N = mkN "espécimen raro" ; -- status=guess
lin status_N = mkN "estado" ; -- status=guess
lin beautiful_A = L.beautiful_A ;
lin offer_N = mkN "oferta" ; -- status=guess
lin marriage_N = mkN "agencia matrimonial" ; -- status=guess
lin hang_V2 = mkV2 (mkV "aguantar") ; -- status=guess
lin hang_V = mkV "aguantar" ; -- status=guess
lin civil_A = mkA "civil" ; -- status=guess
lin perform_V2 = mkV2 (hacer_V) ; -- status=guess
lin perform_V = hacer_V ; -- status=guess
lin sentence_N = mkN "sentencia" | mkN "condena" ; -- status=guess
lin crime_N = mkN "delito" ; -- status=guess
lin ball_N = mkN "bala" ; -- status=guess
lin marry_V2 = mkV2 (mkV "casar") | mkV2 (mkV "casarse") ; -- status=guess
lin marry_V = mkV "casar" | mkV "casarse" ; -- status=guess
lin wind_N = L.wind_N ;
lin truth_N = mkN "verdad" feminine ; -- status=guess
lin protect_V2 = mkV2 (proteger_V) ; -- status=guess
lin protect_V = proteger_V ; -- status=guess
lin safety_N = mkN "cinturón de seguridad" ; -- status=guess
lin partner_N = mkN "compañero" ; -- status=guess
lin completely_Adv = variants{} ; -- 
lin copy_N = mkN "corrector" masculine ; -- status=guess
lin balance_N = mkN "equilibrio" ; -- status=guess
lin sister_N = L.sister_N ;
lin reader_N = mkN "lector" | mkN "lectora" ; -- status=guess
lin below_Adv = mkAdv "abajo" ; -- status=guess
lin trial_N = mkN "ensayo y error" | mkN "tanteo" ; -- status=guess
lin rock_N = L.rock_N ;
lin damage_N = mkN "daño" ; -- status=guess
lin adopt_V2 = mkV2 (mkV "adoptar") | mkV2 (mkV "ahijar") ; -- status=guess
lin newspaper_N = L.newspaper_N ;
lin meaning_N = mkN "significado" ; -- status=guess
lin light_A = mkA "con leche" ; -- status=guess
lin essential_A = mkA "esencial" ; -- status=guess
lin obvious_A = mkA "obvio" ; -- status=guess
lin nation_N = mkN "nación" feminine ; -- status=guess
lin confirm_VS = mkVS (mkV "confirmar") ; -- status=guess
lin confirm_V2 = mkV2 (mkV "confirmar") ; -- status=guess
lin south_N = mkN "sur" masculine ; -- status=guess
lin length_N = mkN "largo" | mkN "eslora" | mkN "longitud" feminine ; -- status=guess
lin branch_N = mkN "sucursal" feminine ; -- status=guess
lin deep_A = mkA "profundo" ; -- status=guess
lin none_NP = variants{} ; -- 
lin planning_N = variants{} ; -- 
lin trust_N = mkN "consorcio" ; -- status=guess
lin working_A = variants{} ; -- 
lin pain_N = mkN "dolor" masculine ; -- status=guess
lin studio_N = mkN "estudio" ; -- status=guess
lin positive_A = mkA "positivo" ; -- status=guess
lin spirit_N = mkN "alcohol" masculine | mkN "bebida espirituosa" ; -- status=guess
lin college_N = mkN "facultad" feminine ; -- status=guess
lin accident_N = mkN "accidente" masculine ; -- status=guess
lin star_V2 = mkV2 (mkV "estelarizar") | mkV2 (mkV "protagonizar") ; -- status=guess
lin star_V = mkV "estelarizar" | mkV "protagonizar" ; -- status=guess
lin hope_N = mkN "esperanza" ; -- status=guess
lin mark_V3 = mkV3 (mkV "marcar") ; -- status=guess
lin mark_V2 = mkV2 (mkV "marcar") ; -- status=guess
lin works_N = variants{} ; -- 
lin league_N = mkN "alianza" | mkN "liga" ; -- status=guess
lin league_2_N = variants{} ; -- 
lin league_1_N = variants{} ; -- 
lin clear_V2V = mkV2V (mkV "carraspear") ; -- status=guess
lin clear_V2 = mkV2 (mkV "carraspear") ; -- status=guess
lin clear_V = mkV "carraspear" ; -- status=guess
lin imagine_VS = mkVS (mkV "imaginar") ; -- status=guess
lin imagine_V2 = mkV2 (mkV "imaginar") ; -- status=guess
lin imagine_V = mkV "imaginar" ; -- status=guess
lin through_Adv = variants{}; -- S.through_Prep ;
lin cash_N = mkN "fuente de ingresos" | mkN "mina" ; -- status=guess
lin normally_Adv = variants{} ; -- 
lin play_N = mkN "juego" ; -- status=guess
lin strength_N = mkN "fuerza" ; -- status=guess
lin train_N = L.train_N ;
lin travel_V2 = mkV2 (mkV "viajar") ; -- status=guess
lin travel_V = L.travel_V ;
lin target_N = mkN "blanco" ; -- status=guess
lin very_A = variants{} ; -- 
lin pair_N = mkN "par" masculine ; -- status=guess
lin male_A = mkA "masculino" | mkA "macho" ; -- status=guess
lin gas_N = mkN "gas" masculine ; -- status=guess
lin issue_V2 = mkV2 (mkV "proceder") | mkV2 (crecer_V) | mkV2 (mkV "recibir") | mkV2 (mkV "lucrar") | mkV2 (mkV "natar") ; -- status=guess
lin issue_V = mkV "proceder" | crecer_V | mkV "recibir" | mkV "lucrar" | mkV "natar" ; -- status=guess
lin contribution_N = mkN "contribución" | mkN "aporte" masculine ; -- status=guess
lin complex_A = mkA "complexo" ; -- status=guess
lin supply_V2 = mkV2 (mkV "suplir") ; -- status=guess
lin beat_V2 = mkV2 (mkV (mkV "irse") "por los cerros de Úbeda") | mkV2 (mkV (mkV "andarse") "por las ramas") | mkV2 (mkV (mkV "darle") "vueltas al asunto") ; -- status=guess
lin beat_V = mkV (mkV "irse") "por los cerros de Úbeda" | mkV (mkV "andarse") "por las ramas" | mkV (mkV "darle") "vueltas al asunto" ; -- status=guess
lin artist_N = mkN "artista" masculine ; -- status=guess
lin agent_N = variants{} ; -- 
lin presence_N = mkN "presencia" ; -- status=guess
lin along_Adv = mkAdv "a lo largo de" ; -- status=guess
lin environmental_A = mkA "ambiental" ; -- status=guess
lin strike_V2 = mkV2 (mkV "ponchar") ; -- status=guess
lin strike_V = mkV "ponchar" ; -- status=guess
lin contact_N = mkN "contacto" ; -- status=guess
lin protection_N = mkN "protección" feminine ; -- status=guess
lin beginning_N = mkN "comienzo" | mkN "principio" | mkN "inicio" ; -- status=guess
lin demand_VS = mkVS (exigir_V) ; -- status=guess
lin demand_V2 = mkV2 (exigir_V) ; -- status=guess
lin media_N = mkN "medios" masculine ; -- status=guess
lin relevant_A = mkA "pertinente" ; -- status=guess
lin employ_V2 = mkV2 (mkV "contratar") | mkV2 (mkV "emplear") ; -- status=guess
lin shoot_V2 = mkV2 (mkV (mkV "tirar") "piedras al propio tejado") ; -- status=guess
lin shoot_V = mkV (mkV "tirar") "piedras al propio tejado" ; -- status=guess
lin executive_N = variants{} ; -- 
lin slowly_Adv = variants{} ; -- 
lin relatively_Adv = variants{} ; -- 
lin aid_N = mkN "ayudante" masculine | mkN "asistente" masculine ; -- status=guess
lin huge_A = mkA "enorme" | mkA "grandote" ; -- status=guess
lin late_Adv = mkAdv "tarde" ; -- status=guess
lin speed_N = variants{} ; -- 
lin review_N = mkN "crítica" ; -- status=guess
lin test_V2 = mkV2 (probar_V) | mkV2 (mkV "testear") ; -- status=guess
lin order_VV = mkVV (mkV "ordenar") | mkVV (mkV "mandar") ; -- status=guess
lin order_VS = mkVS (mkV "ordenar") | mkVS (mkV "mandar") ; -- status=guess
lin order_V2V = mkV2V (mkV "ordenar") | mkV2V (mkV "mandar") ; -- status=guess
lin order_V2 = mkV2 (mkV "ordenar") | mkV2 (mkV "mandar") ; -- status=guess
lin order_V = mkV "ordenar" | mkV "mandar" ; -- status=guess
lin route_N = mkN "ruta" masculine ; -- status=guess
lin consequence_N = mkN "consecuencia" ; -- status=guess
lin telephone_N = mkN "teléfono" ; -- status=guess
lin release_V2 = mkV2 (mkV "liberar") ; -- status=guess
lin proportion_N = mkN "proporción" feminine ; -- status=guess
lin primary_A = mkA "primario" ; -- status=guess
lin consideration_N = mkN "consideración" feminine ; -- status=guess
lin reform_N = mkN "reforma" ; -- status=guess
lin driver_N = mkN "conductor" masculine | mkN "conductora" ; -- status=guess
lin annual_A = mkA "anual" | mkA "añal" ; -- status=guess
lin nuclear_A = mkA "nuclear" ; -- status=guess
lin latter_A = mkA "último" ; -- status=guess
lin practical_A = mkA "práctico" | mkA "práctica" ; -- status=guess
lin commercial_A = variants{} ; -- 
lin rich_A = mkA "rico" ; -- status=guess
lin emerge_VS = mkVS (emerger_V) ; -- status=guess
lin emerge_V2V = mkV2V (emerger_V) ; -- status=guess
lin emerge_V2 = mkV2 (emerger_V) ; -- status=guess
lin emerge_V = emerger_V ; -- status=guess
lin apparently_Adv = variants{} ; -- 
lin ring_V = mkV (mkV "sonarle") "a alguien" ; -- status=guess
lin ring_6_V2 = variants{} ; -- 
lin ring_4_V2 = variants{} ; -- 
lin distance_N = mkN "distancia" ; -- status=guess
lin exercise_N = mkN "ejercicio" ; -- status=guess
lin key_A = mkA "clave" ; -- status=guess
lin close_Adv = variants{} ; -- 
lin skin_N = L.skin_N ;
lin island_N = mkN "isla" ; -- status=guess
lin separate_A = mkA "separado" ; -- status=guess
lin aim_VV = mkVV (mkV "apuntar") | mkVV (mkV "pretender") ; -- status=guess
lin aim_V2 = mkV2 (mkV "apuntar") | mkV2 (mkV "pretender") ; -- status=guess
lin aim_V = mkV "apuntar" | mkV "pretender" ; -- status=guess
lin danger_N = mkN "peligro" ; -- status=guess
lin credit_N = mkN "crédito" ; -- status=guess
lin usual_A = mkA "usual" ; -- status=guess
lin link_V2 = variants{} ; -- 
lin link_V = variants{} ; -- 
lin candidate_N = variants{} ; -- 
lin track_N = mkN "pista" ; -- status=guess
lin safe_A = mkA "sano y salvo" ; -- status=guess
lin interested_A = mkA "interesado" ; -- status=guess
lin assessment_N = mkN "evaluación" feminine | mkN "valoración" feminine ; -- status=guess
lin path_N = mkN "senda" | mkN "sendero" ; -- status=guess
lin merely_Adv = variants{} ; -- 
lin plus_Prep = variants{} ; -- 
lin district_N = mkN "distrito" ; -- status=guess
lin regular_A = mkA "regular" ; -- status=guess
lin reaction_N = mkN "reacción" feminine ; -- status=guess
lin impact_N = mkN "impacto" ; -- status=guess
lin collect_V2 = mkV2 (mkV "coleccionar") ; -- status=guess
lin collect_V = mkV "coleccionar" ; -- status=guess
lin debate_N = mkN "debate" masculine ; -- status=guess
lin lay_VS = mkVS (mkV "ordenar") | mkVS (mkV "organizar") ; -- status=guess
lin lay_V2 = mkV2 (mkV "ordenar") | mkV2 (mkV "organizar") ; -- status=guess
lin lay_V = mkV "ordenar" | mkV "organizar" ; -- status=guess
lin rise_N = mkN "subida" ; -- status=guess
lin belief_N = mkN "creencia" ; -- status=guess
lin conclusion_N = mkN "conclusión" feminine ; -- status=guess
lin shape_N = mkN "forma" ; -- status=guess
lin vote_N = mkN "voto" ; -- status=guess
lin aim_N = mkN "objetivo" | mkN "intención" feminine ; -- status=guess
lin politics_N = mkN "política" ; -- status=guess
lin reply_VS = mkVS (mkV "responder") ; -- status=guess
lin reply_V2 = mkV2 (mkV "responder") ; -- status=guess
lin reply_V = mkV "responder" ; -- status=guess
lin press_V2V = mkV2V (mkV "prensar") | mkV2V (mkV "presionar") ; -- status=guess
lin press_V2 = mkV2 (mkV "prensar") | mkV2 (mkV "presionar") ; -- status=guess
lin press_V = mkV "prensar" | mkV "presionar" ; -- status=guess
lin approach_V2 = mkV2 (mkV (mkV "acercarse") "a") | mkV2 (mkV (mkV "aproximarse") "a") ; -- status=guess
lin approach_V = mkV (mkV "acercarse") "a" | mkV (mkV "aproximarse") "a" ; -- status=guess
lin file_N = mkN "archivo" | mkN "fichero" ; -- status=guess
lin western_A = mkA "occidental" ; -- status=guess
lin earth_N = L.earth_N ;
lin public_N = mkN "público" ; -- status=guess
lin survive_V2 = mkV2 (mkV "sobrevivir") ; -- status=guess
lin survive_V = mkV "sobrevivir" ; -- status=guess
lin estate_N = mkN "finca" ; -- status=guess
lin boat_N = L.boat_N ;
lin prison_N = mkN "cárcel" | mkN "prisión" | mkN "penitenciaría" ; -- status=guess
lin additional_A = mkA "adicional" | mkA "extra" | mkA "de más" ; -- status=guess
lin settle_VA = mkVA (resolver_V) ; -- status=guess
lin settle_V2 = mkV2 (resolver_V) ; -- status=guess
lin settle_V = resolver_V ; -- status=guess
lin largely_Adv = variants{} ; -- 
lin wine_N = L.wine_N ;
lin observe_VS = mkVS (mkV "observar") ; -- status=guess
lin observe_V2 = mkV2 (mkV "observar") ; -- status=guess
lin observe_V = mkV "observar" ; -- status=guess
lin limit_V2V = mkV2V (mkV "limitar") ; -- status=guess
lin limit_V2 = mkV2 (mkV "limitar") ; -- status=guess
lin deny_VS = mkVS (negar_V) ; -- status=guess
lin deny_V3 = mkV3 (negar_V) ; -- status=guess
lin deny_V2 = mkV2 (negar_V) ; -- status=guess
lin for_PConj = variants{} ; -- 
lin straight_Adv = mkAdv "derecho" ; -- status=guess
lin somebody_NP = S.somebody_NP ;
lin writer_N = mkN "escritor" | mkN "escritora" ; -- status=guess
lin weekend_N = mkN "fin de semana" ; -- status=guess
lin clothes_N = variants{} ; -- 
lin active_A = variants{} ; -- 
lin sight_N = mkN "visión" feminine | mkN "vista" masculine ; -- status=guess
lin video_N = mkN "videocámara" ; -- status=guess
lin reality_N = mkN "realidad" feminine ; -- status=guess
lin hall_N = mkN "salón" masculine ; -- status=guess
lin nevertheless_Adv = mkAdv "no obstante" | mkAdv "sin embargo" ; -- status=guess
lin regional_A = mkA "regional" ; -- status=guess
lin vehicle_N = mkN "vehículo" ; -- status=guess
lin worry_VS = mkVS (mkV "inquietarse") | mkVS (mkV "preocuparse") | mkVS (mkV (mkV "estar") "preocupado") ; -- status=guess
lin worry_V2 = mkV2 (mkV "inquietarse") | mkV2 (mkV "preocuparse") | mkV2 (mkV (mkV "estar") "preocupado") ; -- status=guess
lin worry_V = mkV "inquietarse" | mkV "preocuparse" | mkV (mkV "estar") "preocupado" ; -- status=guess
lin powerful_A = mkA "poderoso" ; -- status=guess
lin possibly_Adv = variants{} ; -- 
lin cross_V2 = mkV2 (atravesar_V) ; -- status=guess
lin cross_V = atravesar_V ; -- status=guess
lin colleague_N = mkN "colega" masculine | mkN "compañero" ; -- status=guess
lin charge_VS = mkVS (mkV "atacar") ; -- status=guess
lin charge_V2 = mkV2 (mkV "atacar") ; -- status=guess
lin charge_V = mkV "atacar" ; -- status=guess
lin lead_N = mkN "balas" masculine ; -- status=guess
lin farm_N = mkN "finca" | mkN "granja" ; -- status=guess
lin respond_VS = mkVS (mkV "responder") ; -- status=guess
lin respond_V2 = mkV2 (mkV "responder") ; -- status=guess
lin respond_V = mkV "responder" ; -- status=guess
lin employer_N = mkN "empleador" masculine ; -- status=guess
lin carefully_Adv = variants{} ; -- 
lin understanding_N = mkN "comprensión" feminine ; -- status=guess
lin connection_N = mkN "vinculación" feminine | mkN "conexión" feminine ; -- status=guess
lin comment_N = mkN "comentario" ; -- status=guess
lin grant_V3 = variants{} ; -- 
lin grant_V2 = variants{} ; -- 
lin concentrate_V2 = mkV2 (mkV "concentrarse") ; -- status=guess
lin concentrate_V = mkV "concentrarse" ; -- status=guess
lin ignore_V2 = mkV2 (mkV "ignorar") | mkV2 (desoír_V) ; -- status=guess
lin ignore_V = mkV "ignorar" | desoír_V ; -- status=guess
lin phone_N = mkN "teléfono" ; -- status=guess
lin hole_N = mkN "hueco" ; -- status=guess
lin insurance_N = mkN "seguro" ; -- status=guess
lin content_N = mkN "contenido" ; -- status=guess
lin confidence_N = mkN "certidumbre" feminine ; -- status=guess
lin sample_N = mkN "muestra" | mkN "ejemplar" masculine ; -- status=guess
lin transport_N = mkN "transporte" masculine ; -- status=guess
lin objective_N = mkN "objetivo" ; -- status=guess
lin alone_A = variants{} ; -- 
lin flower_N = L.flower_N ;
lin injury_N = mkN "herida" | mkN "lesión" feminine ; -- status=guess
lin lift_V2 = mkV2 (mkV "levantar") | mkV2 (mkV "subir") ; -- status=guess
lin lift_V = mkV "levantar" | mkV "subir" ; -- status=guess
lin stick_V2 = mkV2 (sobresalir_V) ; -- status=guess
lin stick_V = sobresalir_V ; -- status=guess
lin front_A = variants{} ; -- 
lin mainly_Adv = variants{} ; -- 
lin battle_N = mkN "batalla" masculine | mkN "lucha" ; -- status=guess
lin generation_N = mkN "espacio generacional" ; -- status=guess
lin currently_Adv = variants{} ; -- 
lin winter_N = mkN "invierno" ; -- status=guess
lin inside_Prep = variants{} ; -- 
lin impossible_A = mkA "imposible" ; -- status=guess
lin somewhere_Adv = S.somewhere_Adv ;
lin arrange_V2 = mkV2 (mkV (mkV "poner") "en orden") | mkV2 (mkV "arreglar") ; -- status=guess
lin arrange_V = mkV (mkV "poner") "en orden" | mkV "arreglar" ; -- status=guess
lin will_N = mkN "litigación sobre un testamento" ; -- status=guess
lin sleep_V2 = mkV2 (dormir_V) ; -- status=guess
lin sleep_V = L.sleep_V ;
lin progress_N = mkN "progreso" ; -- status=guess
lin volume_N = mkN "volumen" masculine ; -- status=guess
lin ship_N = L.ship_N ;
lin legislation_N = mkN "legislación" feminine ; -- status=guess
lin commitment_N = mkN "compromiso" ; -- status=guess
lin enough_Predet = variants{} ; -- 
lin conflict_N = mkN "conflicto" ; -- status=guess
lin bag_N = mkN "bolsa" | mkN "saco" ; -- status=guess
lin fresh_A = mkA "nuevo" ; -- status=guess
lin entry_N = mkN "entrada" masculine ; -- status=guess
lin entry_2_N = variants{} ; -- 
lin entry_1_N = variants{} ; -- 
lin smile_N = mkN "sonrisa" ; -- status=guess
lin fair_A = mkA "razonable" ; -- status=guess
lin promise_VV = mkVV (mkV "prometer") ; -- status=guess
lin promise_VS = mkVS (mkV "prometer") ; -- status=guess
lin promise_V2 = mkV2 (mkV "prometer") ; -- status=guess
lin promise_V = mkV "prometer" ; -- status=guess
lin introduction_N = mkN "introducción" feminine ; -- status=guess
lin senior_A = variants{} ; -- 
lin manner_N = mkN "manera" ; -- status=guess
lin background_N = mkN "segundo plano" ; -- status=guess
lin key_N = mkN "tecla" ; -- status=guess
lin key_2_N = variants{} ; -- 
lin key_1_N = variants{} ; -- 
lin touch_V2 = mkV2 (mkV "tocar") ; -- status=guess
lin touch_V = mkV "tocar" ; -- status=guess
lin vary_V2 = mkV2 (mkV "variar") ; -- status=guess
lin vary_V = mkV "variar" ; -- status=guess
lin sexual_A = mkA "sexual" ; -- status=guess
lin ordinary_A = mkA "ordinario" ; -- status=guess
lin cabinet_N = mkN "armario" ; -- status=guess
lin painting_N = mkN "cuadro" | mkN "pintura" ; -- status=guess
lin entirely_Adv = variants{} ; -- 
lin engine_N = mkN "locomotora" masculine ; -- status=guess
lin previously_Adv = variants{} ; -- 
lin administration_N = mkN "administración" feminine ; -- status=guess
lin tonight_Adv = mkAdv "esta noche" | mkAdv "de noche" ; -- status=guess
lin adult_N = mkN "adulto" | mkN "adulta" ; -- status=guess
lin prefer_VV = mkVV (preferir_V) ; -- status=guess
lin prefer_VS = mkVS (preferir_V) ; -- status=guess
lin prefer_V2V = mkV2V (preferir_V) ; -- status=guess
lin prefer_V2 = mkV2 (preferir_V) ; -- status=guess
lin author_N = mkN "autor" masculine | mkN "autora" | mkN "escritor" | mkN "escritora" ; -- status=guess
lin actual_A = mkA "real" | mkA "existente" | mkA "verdadero" ; -- status=guess
lin song_N = L.song_N ;
lin investigation_N = mkN "investigación" feminine ; -- status=guess
lin debt_N = mkN "deuda" ; -- status=guess
lin visitor_N = mkN "visita" ; -- status=guess
lin forest_N = mkN "bosque" masculine | mkN "floresta" | mkN "selva" ; -- status=guess
lin repeat_VS = mkVS (repetir_V) ; -- status=guess
lin repeat_V2 = mkV2 (repetir_V) ; -- status=guess
lin repeat_V = repetir_V ; -- status=guess
lin wood_N = L.wood_N ;
lin contrast_N = mkN "contraste" masculine ; -- status=guess
lin extremely_Adv = variants{} ; -- 
lin wage_N = mkN "salario" | mkN "sueldo" ; -- status=guess
lin domestic_A = variants{} ; -- 
lin commit_V2V = mkV2V (mkV "cometer") ; -- status=guess
lin commit_V2 = mkV2 (mkV "cometer") ; -- status=guess
lin threat_N = mkN "amenaza" ; -- status=guess
lin bus_N = mkN "ensanchamiento para autobús" ; -- status=guess
lin warm_A = L.warm_A ;
lin sir_N = mkN "señor" masculine ; -- status=guess
lin regulation_N = mkN "reglamento" ; -- status=guess
lin drink_N = mkN "beber" ; -- status=guess
lin relief_N = mkN "ayuda humanitaria" ; -- status=guess
lin internal_A = mkA "interior" | mkA "interno" ; -- status=guess
lin strange_A = mkA "extraño" ; -- status=guess
lin excellent_A = mkA "excelente" ; -- status=guess
lin run_N = mkN "correr" ; -- status=guess
lin fairly_Adv = variants{} ; -- 
lin technical_A = mkA "técnico" ; -- status=guess
lin tradition_N = mkN "tradición" feminine ; -- status=guess
lin measure_V2 = mkV2 (medir_V) ; -- status=guess
lin measure_V = medir_V ; -- status=guess
lin insist_VS = mkVS (mkV "insistir") | mkVS (mkV "empeñarse") ; -- status=guess
lin insist_V2 = mkV2 (mkV "insistir") | mkV2 (mkV "empeñarse") ; -- status=guess
lin insist_V = mkV "insistir" | mkV "empeñarse" ; -- status=guess
lin farmer_N = mkN "granjero" | mkN "granjera" ; -- status=guess
lin until_Prep = mkPrep "hasta" ; -- status=guess
lin traffic_N = mkN "glorieta" | mkN "redondel" | mkN "rotonda" ; -- status=guess
lin dinner_N = mkN "cena" ; -- status=guess
lin consumer_N = mkN "consumidor" masculine ; -- status=guess
lin meal_N = mkN "harina" ; -- status=guess
lin warn_VS = mkVS (mkV "alertar") | mkVS (mkV "avisar") | mkVS (advertir_V) ; -- status=guess
lin warn_V2V = mkV2V (mkV "alertar") | mkV2V (mkV "avisar") | mkV2V (advertir_V) ; -- status=guess
lin warn_V2 = mkV2 (mkV "alertar") | mkV2 (mkV "avisar") | mkV2 (advertir_V) ; -- status=guess
lin warn_V = mkV "alertar" | mkV "avisar" | advertir_V ; -- status=guess
lin living_A = mkA "vivo" | mkA "viviente" ; -- status=guess
lin package_N = mkN " paquete" ; -- status=guess
lin half_N = mkN "medio hermano" ; -- status=guess
lin increasingly_Adv = variants{} ; -- 
lin description_N = mkN "descripción" feminine ; -- status=guess
lin soft_A = mkA "suave" | mkA "ligero" | mkA "tenue" ; -- status=guess
lin stuff_N = mkN "cosa" ; -- status=guess
lin award_V3 = mkV3 (mkV "fallar") | mkV3 (mkV "decretar") | mkV3 (mkV "sentenciar") ; -- status=guess
lin award_V2 = mkV2 (mkV "fallar") | mkV2 (mkV "decretar") | mkV2 (mkV "sentenciar") ; -- status=guess
lin existence_N = mkN "existencia" ; -- status=guess
lin improvement_N = mkN "mejora" | mkN "mejoramiento" | mkN "enmienda" | mkN "mejoría" ; -- status=guess
lin coffee_N = mkN "grano de café" | mkN "café" feminine ; -- status=guess
lin appearance_N = mkN "aparición" feminine ; -- status=guess
lin standard_A = mkA "estándar" ; -- status=guess
lin attack_V2 = mkV2 (mkV "atacar") ; -- status=guess
lin sheet_N = mkN "capa" ; -- status=guess
lin category_N = mkN "categoría" ; -- status=guess
lin distribution_N = mkN "distribución" masculine ; -- status=guess
lin equally_Adv = variants{} ; -- 
lin session_N = mkN "sesión" feminine ; -- status=guess
lin cultural_A = mkA "cultural" ; -- status=guess
lin loan_N = mkN "préstamo" ; -- status=guess
lin bind_V2 = mkV2 (mkV "atar") | mkV2 (mkV "empastar") ; -- status=guess
lin bind_V = mkV "atar" | mkV "empastar" ; -- status=guess
lin museum_N = mkN "museo" ; -- status=guess
lin conversation_N = mkN "conversación" feminine ; -- status=guess
lin threaten_VV = mkVV (mkV "amenazar") ; -- status=guess
lin threaten_VS = mkVS (mkV "amenazar") ; -- status=guess
lin threaten_V2 = mkV2 (mkV "amenazar") ; -- status=guess
lin threaten_V = mkV "amenazar" ; -- status=guess
lin link_N = mkN "enlace" masculine | mkN "hipervínculo" ; -- status=guess
lin launch_V2 = mkV2 (mkV "botar") ; -- status=guess
lin launch_V = mkV "botar" ; -- status=guess
lin proper_A = mkA "adecuado" | mkA "adecuada" ; -- status=guess
lin victim_N = mkN "víctima" ; -- status=guess
lin audience_N = mkN "audiencia" ; -- status=guess
lin famous_A = mkA "famoso" ; -- status=guess
lin master_N = mkN "capitán" masculine | mkN "maestre" masculine ; -- status=guess
lin master_2_N = variants{} ; -- 
lin master_1_N = variants{} ; -- 
lin lip_N = mkN "labio" ; -- status=guess
lin religious_A = mkA "religioso" ; -- status=guess
lin joint_A = variants{} ; -- 
lin cry_V2 = mkV2 (mkV "llorar") ; -- status=guess
lin cry_V = mkV "llorar" ; -- status=guess
lin potential_A = variants{} ; -- 
lin broad_A = L.broad_A ;
lin exhibition_N = mkN "exhibición" feminine ; -- status=guess
lin experience_V2 = mkV2 (mkV "experimentar") | mkV2 (mkV "vivir") ; -- status=guess
lin judge_N = mkN "juez" masculine ; -- status=guess
lin formal_A = mkA "formal" ; -- status=guess
lin housing_N = mkN "vivienda" ; -- status=guess
lin past_Prep = variants{} ; -- 
lin concern_VS = mkVS (mkV (mkV "referirse") "a") ; -- status=guess
lin concern_V2 = mkV2 (mkV (mkV "referirse") "a") ; -- status=guess
lin concern_V = mkV (mkV "referirse") "a" ; -- status=guess
lin freedom_N = mkN "libertad" feminine ; -- status=guess
lin gentleman_N = mkN "caballero" feminine ; -- status=guess
lin attract_V2 = mkV2 (mkV "llamar") ; -- status=guess
lin explanation_N = mkN "explicación" feminine ; -- status=guess
lin appoint_VS = mkVS (mkV "designar") | mkVS (mkV "nombrar") ; -- status=guess
lin appoint_V3 = mkV3 (mkV "designar") | mkV3 (mkV "nombrar") ; -- status=guess
lin appoint_V2V = mkV2V (mkV "designar") | mkV2V (mkV "nombrar") ; -- status=guess
lin appoint_V2 = mkV2 (mkV "designar") | mkV2 (mkV "nombrar") ; -- status=guess
lin note_VS = mkVS (mkV "anotar") ; -- status=guess
lin note_V2 = mkV2 (mkV "anotar") ; -- status=guess
lin note_V = mkV "anotar" ; -- status=guess
lin chief_A = variants{} ; -- 
lin total_N = mkN "total" masculine ; -- status=guess
lin lovely_A = variants{} ; -- 
lin official_A = mkA "oficial" ; -- status=guess
lin date_V2 = mkV2 (mkV "fechar") ; -- status=guess
lin date_V = mkV "fechar" ; -- status=guess
lin demonstrate_VS = mkVS (demostrar_V) ; -- status=guess
lin demonstrate_V2 = mkV2 (demostrar_V) ; -- status=guess
lin demonstrate_V = demostrar_V ; -- status=guess
lin construction_N = mkN "construcción" feminine ; -- status=guess
lin middle_N = mkN "mediana edad" ; -- status=guess
lin yard_N = mkN "patio" ; -- status=guess
lin unable_A = mkA "incapaz" | mkA "impotente" ; -- status=guess
lin acquire_V2 = mkV2 (adquirir_V) ; -- status=guess
lin surely_Adv = variants{} ; -- 
lin crisis_N = mkN "crisis" feminine ; -- status=guess
lin propose_VV = mkVV (mkV (mkV "pedir") "la mano") ; -- status=guess
lin propose_VS = mkVS (mkV (mkV "pedir") "la mano") ; -- status=guess
lin propose_V2 = mkV2 (mkV (mkV "pedir") "la mano") ; -- status=guess
lin propose_V = mkV (mkV "pedir") "la mano" ; -- status=guess
lin west_N = mkN "oeste" masculine ; -- status=guess
lin impose_V2 = variants{} ; -- 
lin impose_V = variants{} ; -- 
lin market_V2 = mkV2 (mkV (mkV "poner") "al mercado") ; -- status=guess
lin market_V = mkV (mkV "poner") "al mercado" ; -- status=guess
lin care_V = mkV "importar" | mkV "interesar" ; -- status=guess
lin god_N = mkN "dios" masculine ; -- status=guess
lin favour_N = variants{} ; -- 
lin before_Adv = mkAdv "antes de" ; -- status=guess
lin name_V3 = mkV3 (mkV "nombrar") ; -- status=guess
lin name_V2V = mkV2V (mkV "nombrar") ; -- status=guess
lin name_V2 = mkV2 (mkV "nombrar") ; -- status=guess
lin equal_A = mkA "igual" ; -- status=guess
lin capacity_N = mkN "capacidad" feminine ; -- status=guess
lin flat_N = mkN "gato de cabeza plana" ; -- status=guess
lin selection_N = mkN "selección" feminine ; -- status=guess
lin alone_Adv = variants{} ; -- 
lin football_N = mkN "fútbol" | mkN "futbol " | mkN "balompié" | mkN "pambol " ; -- status=guess
lin victory_N = mkN "victoria" ; -- status=guess
lin factory_N = L.factory_N ;
lin rural_A = mkA "rural" ; -- status=guess
lin twice_Adv = mkAdv "dos veces" ; -- status=guess
lin sing_V2 = mkV2 (mkV "cantar") ; -- status=guess
lin sing_V = L.sing_V ;
lin whereas_Subj = variants{} ; -- 
lin own_V2 = mkV2 (reconocer_V) | mkV2 (mkV "admitir") ; -- status=guess
lin own_V = reconocer_V | mkV "admitir" ; -- status=guess
lin head_V2 = mkV2 (mkV (mkV "echarse") "a andar") ; -- status=guess
lin head_V = mkV (mkV "echarse") "a andar" ; -- status=guess
lin examination_N = mkN "examen" masculine ; -- status=guess
lin deliver_V2 = mkV2 (mkV "entregar") ; -- status=guess
lin deliver_V = mkV "entregar" ; -- status=guess
lin nobody_NP = S.nobody_NP ;
lin substantial_A = mkA "substancial" ; -- status=guess
lin invite_V2V = mkV2V (mkV "invitar") | mkV2V (mkV "convidar") ; -- status=guess
lin invite_V2 = mkV2 (mkV "invitar") | mkV2 (mkV "convidar") ; -- status=guess
lin intention_N = mkN "intención" feminine ; -- status=guess
lin egg_N = L.egg_N ;
lin reasonable_A = mkA "razonable" ; -- status=guess
lin onto_Prep = variants{} ; -- 
lin retain_V2V = mkV2V (mkV "detentar") ; -- status=guess
lin retain_V2 = mkV2 (mkV "detentar") ; -- status=guess
lin aircraft_N = mkN "aeronave" feminine ; -- status=guess
lin decade_N = mkN "década" | mkN "decenio" ; -- status=guess
lin cheap_A = mkA "barato" | mkA "económico" ; -- status=guess
lin quiet_A = mkA "tranquilo" | mkA "detenido" | mkA "quieto" | mkA "calmo" ; -- status=guess
lin bright_A = mkA "alegre" ; -- status=guess
lin contribute_V2V = mkV2V (contribuir_V) ; -- status=guess
lin contribute_V2 = mkV2 (contribuir_V) ; -- status=guess
lin contribute_V = contribuir_V ; -- status=guess
lin row_N = mkN "remo" | mkN "remado" ; -- status=guess
lin search_N = mkN "búsqueda" ; -- status=guess
lin limit_N = mkN "límite" masculine ; -- status=guess
lin definition_N = mkN "definición" feminine ; -- status=guess
lin unemployment_N = mkN "desempleo" | mkN "paro" ; -- status=guess
lin spread_VS = mkVS (mkV (mkV "correr") "como la pólvora") ; -- status=guess
lin spread_V2V = mkV2V (mkV (mkV "correr") "como la pólvora") ; -- status=guess
lin spread_V2 = mkV2 (mkV (mkV "correr") "como la pólvora") ; -- status=guess
lin spread_V = mkV (mkV "correr") "como la pólvora" ; -- status=guess
lin mark_N = mkN "nota" | mkN "calificación" feminine ; -- status=guess
lin flight_N = mkN "fuga" | mkN "huida" ; -- status=guess
lin account_V2 = variants{} ; -- 
lin account_V = variants{} ; -- 
lin output_N = variants{} ; -- 
lin last_V2 = mkV2 (mkV "durar") ; -- status=guess
lin last_V = mkV "durar" ; -- status=guess
lin tour_N = mkN "gira" ; -- status=guess
lin address_N = mkN "dirección" feminine ; -- status=guess
lin immediate_A = mkA "inmediato" ; -- status=guess
lin reduction_N = mkN "reducción" feminine ; -- status=guess
lin interview_N = mkN "entrevista" ; -- status=guess
lin assess_V2 = mkV2 (mkV "evaluar") | mkV2 (mkV "estimar") ; -- status=guess
lin promote_V2 = mkV2 (promover_V) ; -- status=guess
lin promote_V = promover_V ; -- status=guess
lin everybody_NP = S.everybody_NP ;
lin suitable_A = mkA "apropiado" | mkA "indicado" ; -- status=guess
lin growing_A = variants{} ; -- 
lin nod_V2 = mkV2 (mkV "cabecear") ; -- status=guess
lin nod_V = mkV "cabecear" ; -- status=guess
lin reject_V2 = mkV2 (mkV "rechazar") ; -- status=guess
lin while_N = mkN "rato" ; -- status=guess
lin high_Adv = variants{} ; -- 
lin dream_N = mkN "sueño hecho realidad" ; -- status=guess
lin vote_VV = mkVV (mkV "votar") ; -- status=guess
lin vote_V3 = variants{}; -- mkV2 (mkV "votar") ;
lin vote_V2 = mkV2 (mkV "votar") ; -- status=guess
lin vote_V = mkV "votar" ; -- status=guess
lin divide_V2 = mkV2 (mkV (mkV "divide") "y conquista") | mkV2 (mkV (mkV "divide") "y vencerás") ; -- status=guess
lin divide_V = mkV (mkV "divide") "y conquista" | mkV (mkV "divide") "y vencerás" ; -- status=guess
lin declare_VS = mkVS (mkV "declarar") ; -- status=guess
lin declare_V2V = mkV2V (mkV "declarar") ; -- status=guess
lin declare_V2 = mkV2 (mkV "declarar") ; -- status=guess
lin declare_V = mkV "declarar" ; -- status=guess
lin handle_V2 = variants{} ; -- 
lin handle_V = variants{} ; -- 
lin detailed_A = variants{} ; -- 
lin challenge_N = mkN "desafío" ; -- status=guess
lin notice_N = mkN "comunicación" feminine | mkN "notificación" feminine ; -- status=guess
lin rain_N = L.rain_N ;
lin destroy_V2 = mkV2 (destruir_V) | mkV2 (romper_V) ; -- status=guess
lin mountain_N = L.mountain_N ;
lin concentration_N = mkN "concentración" feminine ; -- status=guess
lin limited_A = variants{} ; -- 
lin finance_N = variants{} ; -- 
lin pension_N = mkN "pensión" feminine ; -- status=guess
lin influence_V2 = mkV2 (influir_V) ; -- status=guess
lin afraid_A = mkA "temerse que" ; -- status=guess
lin murder_N = mkN "asesinato" ; -- status=guess
lin neck_N = L.neck_N ;
lin weapon_N = mkN "arma" ; -- status=guess
lin hide_V2 = mkV2 (mkV "esconderse") ; -- status=guess
lin hide_V = mkV "esconderse" ; -- status=guess
lin offence_N = variants{} ; -- 
lin absence_N = mkN "ausencia" ; -- status=guess
lin error_N = mkN "error" masculine ; -- status=guess
lin representative_N = variants{} ; -- 
lin enterprise_N = mkN "empresa" ; -- status=guess
lin criticism_N = variants{} ; -- 
lin average_A = mkA "medio" ; -- status=guess
lin quick_A = mkA "rápido" ; -- status=guess
lin sufficient_A = mkA "suficiente" ; -- status=guess
lin appointment_N = mkN "nombramiento" ; -- status=guess
lin match_V2 = mkV2 (mkV "emparejar") ; -- status=guess
lin match_V = mkV "emparejar" ; -- status=guess
lin transfer_V2 = mkV2 (transferir_V) ; -- status=guess
lin transfer_V = transferir_V ; -- status=guess
lin acid_N = mkN "ácido" ; -- status=guess
lin spring_N = mkN "resorte" | mkN "muelle" masculine ; -- status=guess
lin birth_N = mkN "nacimiento" feminine ; -- status=guess
lin ear_N = L.ear_N ;
lin recognize_VS = mkVS (reconocer_V) ; -- status=guess
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin recommend_V2V = mkV2V (recomendar_V) ; -- status=guess
lin recommend_V2 = mkV2 (recomendar_V) ; -- status=guess
lin module_N = variants{} ; -- 
lin instruction_N = mkN "instrucción" feminine ; -- status=guess
lin democratic_A = mkA "democrático" ; -- status=guess
lin park_N = mkN "coto" ; -- status=guess
lin weather_N = mkN "pronóstico del tiempo" ; -- status=guess
lin bottle_N = mkN "botella" masculine | mkN "frasco" ; -- status=guess
lin address_V2 = mkV2 (dirigir_V) ; -- status=guess
lin bedroom_N = mkN "alcoba" ; -- status=guess
lin kid_N = mkN "niño" ; -- status=guess
lin pleasure_N = mkN "placer" masculine ; -- status=guess
lin realize_VS = mkVS (mkV (mkV "darse") "cuenta") | mkVS (mkV "comprender") ; -- status=guess
lin realize_V2 = mkV2 (mkV (mkV "darse") "cuenta") | mkV2 (mkV "comprender") ; -- status=guess
lin assembly_N = mkN "asamblea" ; -- status=guess
lin expensive_A = mkA "caro" | mkA "costoso" | mkA "dispendioso" ; -- status=guess
lin select_VV = mkVV (mkV "seleccionar") ; -- status=guess
lin select_V2V = mkV2V (mkV "seleccionar") ; -- status=guess
lin select_V2 = mkV2 (mkV "seleccionar") ; -- status=guess
lin select_V = mkV "seleccionar" ; -- status=guess
lin teaching_N = mkN "enseñanza" ; -- status=guess
lin desire_N = mkN "deseo" | mkN "gana" ; -- status=guess
lin whilst_Subj = variants{} ; -- 
lin contact_V2 = mkV2 (mkV "contactar") | mkV2 (mkV (mkV "entrar") "en contacto con") ; -- status=guess
lin implication_N = variants{} ; -- 
lin combine_VV = mkVV (mkV "combinar") | mkVV (mkV "juntar") | mkVV (mkV "unir") ; -- status=guess
lin combine_V2V = mkV2V (mkV "combinar") | mkV2V (mkV "juntar") | mkV2V (mkV "unir") ; -- status=guess
lin combine_V2 = mkV2 (mkV "combinar") | mkV2 (mkV "juntar") | mkV2 (mkV "unir") ; -- status=guess
lin combine_V = mkV "combinar" | mkV "juntar" | mkV "unir" ; -- status=guess
lin temperature_N = mkN "temperatura" ; -- status=guess
lin wave_N = mkN "onda" | mkN "ola" ; -- status=guess
lin magazine_N = mkN "cargador" masculine ; -- status=guess
lin totally_Adv = variants{} ; -- 
lin mental_A = mkA "mental" ; -- status=guess
lin used_A = variants{} ; -- 
lin store_N = mkN "depósito" ; -- status=guess
lin scientific_A = mkA "científico" ; -- status=guess
lin frequently_Adv = variants{} ; -- 
lin thanks_N = variants{} ; -- 
lin beside_Prep = variants{} ; -- 
lin settlement_N = mkN "poblado" | mkN "asentamiento" feminine ; -- status=guess
lin absolutely_Adv = variants{} ; -- 
lin critical_A = mkA "crítico" | mkA "crítica" ; -- status=guess
lin critical_2_A = variants{} ; -- 
lin critical_1_A = variants{} ; -- 
lin recognition_N = variants{} ; -- 
lin touch_N = mkN "toque" masculine ; -- status=guess
lin consist_V = variants{} ; -- 
lin below_Prep = variants{} ; -- 
lin silence_N = mkN "silencio" ; -- status=guess
lin expenditure_N = mkN "gasto" ; -- status=guess
lin institute_N = mkN "instituto" ; -- status=guess
lin dress_V2 = mkV2 (vestir_V) ; -- status=guess
lin dress_V = vestir_V ; -- status=guess
lin dangerous_A = mkA "peligroso" ; -- status=guess
lin familiar_A = variants{} ; -- 
lin asset_N = mkN "bien" masculine | mkN "valor" masculine | mkN "activo" ; -- status=guess
lin belong_V = mkV (mkV "pertenecer") "a" ; -- status=guess
lin educational_A = mkA "educativo" ; -- status=guess
lin sum_N = mkN "suma" | mkN "adición" feminine ; -- status=guess
lin publication_N = mkN "publicación" feminine ; -- status=guess
lin partly_Adv = variants{} ; -- 
lin block_N = mkN "manzana" | mkN "cuadra" ; -- status=guess
lin seriously_Adv = variants{} ; -- 
lin youth_N = mkN "albergue juvenil" ; -- status=guess
lin tape_N = mkN "cinta adhesiva" | mkN "celo" feminine ; -- status=guess
lin elsewhere_Adv = mkAdv "en otra parte" | mkAdv "en otro lugar" ; -- status=guess
lin cover_N = mkN "tapa" | mkN "cubierta" | mkN "portada" ; -- status=guess
lin fee_N = mkN "honorario" | mkN "tarifa" | mkN "cuota" ; -- status=guess
lin program_N = mkN "programa" masculine ; -- status=guess
lin treaty_N = mkN "tratado" ; -- status=guess
lin necessarily_Adv = variants{} ; -- 
lin unlikely_A = mkA "improbable" ; -- status=guess
lin properly_Adv = variants{} ; -- 
lin guest_N = mkN "huésped" masculine ; -- status=guess
lin code_N = mkN "código" feminine ; -- status=guess
lin hill_N = L.hill_N ;
lin screen_N = mkN "tamiz" masculine | mkN "malla" ; -- status=guess
lin household_N = mkN "familia" masculine | mkN "casa" | mkN "hogareños" | mkN "huéspedes" | mkN "séquito" ; -- status=guess
lin sequence_N = mkN "secuencia" ; -- status=guess
lin correct_A = L.correct_A ;
lin female_A = mkA "femenino" | mkA "hembra" ; -- status=guess
lin phase_N = mkN "fase" feminine ; -- status=guess
lin crowd_N = mkN "muchedumbre" | mkN "turba" | mkN "multitud" feminine | mkN "montón" masculine | mkN "vulgo" feminine ; -- status=guess
lin welcome_V2 = mkV2 (mkV (mkV "dar") "la bienvenida") ; -- status=guess
lin metal_N = mkN "metal" masculine ; -- status=guess
lin human_N = mkN "humano" | mkN "humana" | mkN "ser humano" ; -- status=guess
lin widely_Adv = variants{} ; -- 
lin undertake_V2 = mkV2 (mkV (mkV "comprometerse") "a") ; -- status=guess
lin cut_N = mkN "corte" masculine ; -- status=guess
lin sky_N = L.sky_N ;
lin brain_N = mkN "cerebro" ; -- status=guess
lin expert_N = mkN "perito" | mkN "experto" ; -- status=guess
lin experiment_N = mkN "experimento" ; -- status=guess
lin tiny_A = mkA "diminuto" | mkA "minúsculo" | mkA "pequeñito" ; -- status=guess
lin perfect_A = mkA "perfecto" ; -- status=guess
lin disappear_V = desaparecer_V ; -- status=guess
lin initiative_N = mkN "iniciativa" ; -- status=guess
lin assumption_N = mkN "asunción" feminine ; -- status=guess
lin photograph_N = mkN "fotografía" | mkN "foto" feminine ; -- status=guess
lin ministry_N = mkN "ministerio" ; -- status=guess
lin congress_N = variants{} ; -- 
lin transfer_N = mkN "ARN de transferencia" ; -- status=guess
lin reading_N = mkN "lectura" ; -- status=guess
lin scientist_N = mkN "científico" ; -- status=guess
lin fast_Adv = mkAdv "rápidamente" ; -- status=guess
lin fast_A = mkA "rápido" ; -- status=guess
lin closely_Adv = variants{} ; -- 
lin thin_A = L.thin_A ;
lin solicitor_N = variants{} ; -- 
lin secure_V2 = variants{} ; -- 
lin plate_N = mkN "plato" ; -- status=guess
lin pool_N = mkN "estanque" masculine | mkN "pileta" ; -- status=guess
lin gold_N = L.gold_N ;
lin emphasis_N = mkN "énfasis" masculine ; -- status=guess
lin recall_VS = mkVS (mkV "evocar") ; -- status=guess
lin recall_V2 = mkV2 (mkV "evocar") ; -- status=guess
lin shout_V2 = mkV2 (mkV "gritar") ; -- status=guess
lin shout_V = mkV "gritar" ; -- status=guess
lin generate_V2 = mkV2 (mkV "generar") ; -- status=guess
lin location_N = mkN "ubicación" feminine ; -- status=guess
lin display_VS = mkVS (mkV "exhibir") ; -- status=guess
lin display_V2 = mkV2 (mkV "exhibir") ; -- status=guess
lin heat_N = mkN "picante" feminine | mkN "picor" masculine ; -- status=guess
lin gun_N = mkN "escopeta" | mkN "rifle" masculine ; -- status=guess
lin shut_V2 = mkV2 (cerrar_V) ; -- status=guess
lin shut_V = cerrar_V ; -- status=guess
lin journey_N = mkN "viaje" masculine | mkN "jornada" ; -- status=guess
lin imply_VS = mkVS (mkV "insinuar") ; -- status=guess
lin imply_V2 = mkV2 (mkV "insinuar") ; -- status=guess
lin imply_V = mkV "insinuar" ; -- status=guess
lin violence_N = mkN "violencia" ; -- status=guess
lin dry_A = L.dry_A ;
lin historical_A = mkA "histórico" ; -- status=guess
lin step_V2 = mkV2 (mkV "caminar") ; -- status=guess
lin step_V = mkV "caminar" ; -- status=guess
lin curriculum_N = mkN "currículo" ; -- status=guess
lin noise_N = mkN "contaminación acústica" ; -- status=guess
lin lunch_N = mkN "almuerzo" | mkN "comida" ; -- status=guess
lin fear_VS = L.fear_VS ;
lin fear_V2 = L.fear_V2 ;
lin fear_V = mkV "temer" | mkV (mkV "tener") "miedo de" ; -- status=guess
lin succeed_V2 = mkV2 (mkV "suceder") ; -- status=guess
lin succeed_V = mkV "suceder" ; -- status=guess
lin fall_N = mkN "caída" ; -- status=guess
lin fall_2_N = variants{} ; -- 
lin fall_1_N = variants{} ; -- 
lin bottom_N = mkN "pasivo" ; -- status=guess
lin initial_A = mkA "inicial" ; -- status=guess
lin theme_N = mkN "tema" masculine ; -- status=guess
lin characteristic_N = mkN "característica" ; -- status=guess
lin pretty_Adv = variants{} ; -- 
lin empty_A = L.empty_A ;
lin display_N = mkN "monitor" masculine ; -- status=guess
lin combination_N = mkN "combinación" feminine ; -- status=guess
lin interpretation_N = mkN "apreciación" feminine ; -- status=guess
lin rely_V2 = variants{}; -- mkV (mkV "contar") "con" | mkV "atenerse" ;
lin rely_V = mkV (mkV "contar") "con" | mkV "atenerse" ; -- status=guess
lin escape_VS = mkVS (mkV "escapar") | mkVS (mkV "salvarse") | mkVS (mkV "evadir") ; -- status=guess
lin escape_V2 = mkV2 (mkV "escapar") | mkV2 (mkV "salvarse") | mkV2 (mkV "evadir") ; -- status=guess
lin escape_V = mkV "escapar" | mkV "salvarse" | mkV "evadir" ; -- status=guess
lin score_V2 = mkV2 (mkV "anotar") | mkV2 (mkV "puntuar") ; -- status=guess
lin score_V = mkV "anotar" | mkV "puntuar" ; -- status=guess
lin justice_N = mkN "justicia" | mkN "justedad" | mkN "justeza" ; -- status=guess
lin upper_A = mkA "superior" ; -- status=guess
lin tooth_N = L.tooth_N ;
lin organize_V2V = mkV2V (mkV "organizar") ; -- status=guess
lin organize_V2 = mkV2 (mkV "organizar") ; -- status=guess
lin cat_N = L.cat_N ;
lin tool_N = mkN "herramienta" | mkN "utensilio" ; -- status=guess
lin spot_N = mkN "mancha" ; -- status=guess
lin bridge_N = mkN "bridge" masculine ; -- status=guess
lin double_A = mkA "doble" ; -- status=guess
lin direct_VS = mkVS (dirigir_V) ; -- status=guess
lin direct_V2 = mkV2 (dirigir_V) ; -- status=guess
lin direct_V = dirigir_V ; -- status=guess
lin conclude_VS = mkVS (concluir_V) ; -- status=guess
lin conclude_V2 = mkV2 (concluir_V) ; -- status=guess
lin conclude_V = concluir_V ; -- status=guess
lin relative_A = mkA "relativo" ; -- status=guess
lin soldier_N = mkN "soldado" ; -- status=guess
lin climb_V2 = mkV2 (mkV "escalar") ; -- status=guess
lin climb_V = mkV "escalar" ; -- status=guess
lin breath_N = mkN "respiro" ; -- status=guess
lin afford_V2V = variants{} ; -- 
lin afford_V2 = variants{} ; -- 
lin urban_A = mkA "urbano" ; -- status=guess
lin nurse_N = mkN "enfermera" | mkN "enfermero" ; -- status=guess
lin narrow_A = L.narrow_A ;
lin liberal_A = variants{} ; -- 
lin coal_N = mkN "carbón" masculine ; -- status=guess
lin priority_N = mkN "prioridad" feminine ; -- status=guess
lin wild_A = mkA "salvaje" | mkA "montaraz" ; -- status=guess
lin revenue_N = mkN "recaudación" ; -- status=guess
lin membership_N = variants{} ; -- 
lin grant_N = mkN "patrocinio" feminine ; -- status=guess
lin approve_V2 = mkV2 (aprobar_V) ; -- status=guess
lin approve_V = aprobar_V ; -- status=guess
lin tall_A = mkA "alto" ; -- status=guess
lin apparent_A = mkA "claro" | mkA "evidente" | mkA "manifiesto" ; -- status=guess
lin faith_N = mkN "fe" feminine ; -- status=guess
lin under_Adv = mkAdv "en voz baja" | mkAdv "entredientes" ; -- status=guess
lin fix_V2 = mkV2 (mkV "fijar") ; -- status=guess
lin fix_V = mkV "fijar" ; -- status=guess
lin slow_A = mkA "atrasado" ; -- status=guess
lin troop_N = variants{} ; -- 
lin motion_N = mkN "moción" feminine ; -- status=guess
lin leading_A = variants{} ; -- 
lin component_N = mkN "componente" masculine ; -- status=guess
lin bloody_A = mkA "sangriento" | mkA "cruento" | mkA "sanguinolento" ; -- status=guess
lin literature_N = mkN "literatura" ; -- status=guess
lin conservative_A = mkA "conservador" ; -- status=guess
lin variation_N = mkN "variación" feminine ; -- status=guess
lin remind_V2 = mkV2 (recordar_V) ; -- status=guess
lin inform_V2 = mkV2 (mkV "delatar") | mkV2 (mkV "enterar") | mkV2 (mkV "impregnar") | mkV2 (mkV "informar") | mkV2 (mkV "reportar") ; -- status=guess
lin inform_V = mkV "delatar" | mkV "enterar" | mkV "impregnar" | mkV "informar" | mkV "reportar" ; -- status=guess
lin alternative_N = mkN "alternativo" ; -- status=guess
lin neither_Adv = mkAdv "tampoco" ; -- status=guess
lin outside_Adv = mkAdv "fuera" | mkAdv "afuera" ; -- status=guess
lin mass_N = mkN "medios de comunicación" ; -- status=guess
lin busy_A = mkA "complicado" ; -- status=guess
lin chemical_N = mkN "producto químico" ; -- status=guess
lin careful_A = mkA "cauto" | mkA "cuidadoso" ; -- status=guess
lin investigate_V2 = mkV2 (mkV "examinar") ; -- status=guess
lin investigate_V = mkV "examinar" ; -- status=guess
lin roll_V2 = mkV2 (rodar_V) ; -- status=guess
lin roll_V = rodar_V ; -- status=guess
lin instrument_N = mkN "instrumento" ; -- status=guess
lin guide_N = mkN "guía turística" | mkN "guía de viaje" ; -- status=guess
lin criterion_N = mkN "criterio" ; -- status=guess
lin pocket_N = mkN "bolsillo" | mkN "bolsa" ; -- status=guess
lin suggestion_N = mkN "sugestión" feminine ; -- status=guess
lin aye_Interj = variants{} ; -- 
lin entitle_VS = variants{} ; -- 
lin entitle_V2V = variants{} ; -- 
lin entitle_V2 = variants{} ; -- 
lin tone_N = mkN "tono" ; -- status=guess
lin attractive_A = mkA "atractivo" ; -- status=guess
lin wing_N = L.wing_N ;
lin surprise_N = mkN "sorpresa" ; -- status=guess
lin male_N = mkN "macho" ; -- status=guess
lin ring_N = mkN "anillo" ; -- status=guess
lin pub_N = mkN "pub" | mkN "bar" masculine | mkN "taberna" ; -- status=guess
lin fruit_N = L.fruit_N ;
lin passage_N = mkN "pasaje" masculine ; -- status=guess
lin illustrate_VS = mkVS (mkV "ilustrar") ; -- status=guess
lin illustrate_V2 = mkV2 (mkV "ilustrar") ; -- status=guess
lin illustrate_V = mkV "ilustrar" ; -- status=guess
lin pay_N = mkN "pago" | mkN "paga" ; -- status=guess
lin ride_V2 = mkV2 (mkV (mkV "pasear") "en coche") | mkV2 (conducir_V) ; -- status=guess
lin ride_V = mkV (mkV "pasear") "en coche" | conducir_V ; -- status=guess
lin foundation_N = mkN "fundación" feminine ; -- status=guess
lin restaurant_N = L.restaurant_N ;
lin vital_A = mkA "vital" ; -- status=guess
lin alternative_A = mkA "alternativo" ; -- status=guess
lin burn_V2 = mkV2 (mkV "arder") | mkV2 (mkV "quemar") ; -- status=guess
lin burn_V = L.burn_V ;
lin map_N = mkN "plano" feminine ; -- status=guess
lin united_A = variants{} ; -- 
lin device_N = mkN "dispositivo" | mkN "mecanismo" ; -- status=guess
lin jump_VV = mkVV (mkV "apresurarse") | mkVV (mkV "aprovechar") ; -- status=guess
lin jump_V2V = mkV2V (mkV "apresurarse") | mkV2V (mkV "aprovechar") ; -- status=guess
lin jump_V2 = mkV2 (mkV "apresurarse") | mkV2 (mkV "aprovechar") ; -- status=guess
lin jump_V = L.jump_V ;
lin estimate_VS = mkVS (mkV "estimar") ; -- status=guess
lin estimate_V2V = mkV2V (mkV "estimar") ; -- status=guess
lin estimate_V2 = mkV2 (mkV "estimar") ; -- status=guess
lin estimate_V = mkV "estimar" ; -- status=guess
lin conduct_V2 = mkV2 (conducir_V) ; -- status=guess
lin conduct_V = conducir_V ; -- status=guess
lin derive_V2 = mkV2 (mkV "derivar") ; -- status=guess
lin derive_V = mkV "derivar" ; -- status=guess
lin comment_VS = mkVS (mkV "comentar") ; -- status=guess
lin comment_V2 = mkV2 (mkV "comentar") ; -- status=guess
lin comment_V = mkV "comentar" ; -- status=guess
lin east_N = mkN "este" | mkN "oriente" | mkN "levante" masculine ; -- status=guess
lin advise_VS = mkVS (mkV "aconsejar") | mkVS (mkV "asesorar") ; -- status=guess
lin advise_V2 = mkV2 (mkV "aconsejar") | mkV2 (mkV "asesorar") ; -- status=guess
lin advise_V = mkV "aconsejar" | mkV "asesorar" ; -- status=guess
lin advance_N = mkN "adelanto" | mkN "avance" masculine ; -- status=guess
lin motor_N = mkN "motor" masculine ; -- status=guess
lin satisfy_V2 = mkV2 (satisfacer_V) ; -- status=guess
lin satisfy_V = satisfacer_V ; -- status=guess
lin hell_N = mkN "infierno" ; -- status=guess
lin winner_N = mkN "ganador" | mkN "ganadora" | mkN "vencedor" masculine ; -- status=guess
lin effectively_Adv = variants{} ; -- 
lin mistake_N = mkN "error" masculine | mkN "equivocación" feminine ; -- status=guess
lin incident_N = mkN "incidente" masculine ; -- status=guess
lin focus_V2 = mkV2 (mkV "enfocar") ; -- status=guess
lin focus_V = mkV "enfocar" ; -- status=guess
lin exercise_VV = mkVV (mkV (mkV "hacer") "ejercicio") ; -- status=guess
lin exercise_V2 = mkV2 (mkV (mkV "hacer") "ejercicio") ; -- status=guess
lin exercise_V = mkV (mkV "hacer") "ejercicio" ; -- status=guess
lin representation_N = mkN "representación" feminine ; -- status=guess
lin release_N = mkN "nota de entrega" ; -- status=guess
lin leaf_N = L.leaf_N ;
lin border_N = mkN "cenefa" | mkN "orla" ; -- status=guess
lin wash_V2 = L.wash_V2 ;
lin wash_V = mkV (mkV "lavarse") "las manos" ; -- status=guess
lin prospect_N = mkN "expectativa" | mkN "prospectiva" ; -- status=guess
lin blow_V2 = mkV2 (mkV "sonarse") ; -- status=guess
lin blow_V = L.blow_V ;
lin trip_N = mkN "viaje" masculine ; -- status=guess
lin observation_N = mkN "observación" feminine | mkN "vigilancia" | mkN "observancia" ; -- status=guess
lin gather_V2 = mkV2 (mkV "juntar") | mkV2 (recoger_V) ; -- status=guess
lin gather_V = mkV "juntar" | recoger_V ; -- status=guess
lin ancient_A = mkA "antiguo" ; -- status=guess
lin brief_A = mkA "conciso" | mkA "sucinto" ; -- status=guess
lin gate_N = mkN "compuerta" ; -- status=guess
lin elderly_A = mkA "anciano" ; -- status=guess
lin persuade_V2V = mkV2V (mkV "persuadir") ; -- status=guess
lin persuade_V2 = mkV2 (mkV "persuadir") ; -- status=guess
lin overall_A = variants{} ; -- 
lin rare_A = mkA "crudo" | mkA "poco hecho" ; -- status=guess
lin index_N = mkN "índice" masculine ; -- status=guess
lin hand_V2 = mkV2 (mkV "entregar") ; -- status=guess
lin circle_N = mkN "curva" ; -- status=guess
lin creation_N = mkN "creación" feminine ; -- status=guess
lin drawing_N = mkN "dibujar" ; -- status=guess
lin anybody_NP = variants{} ; -- 
lin flow_N = mkN "diagrama de flujo" ; -- status=guess
lin matter_V = mkV "importar" ; -- status=guess
lin external_A = mkA "externo" ; -- status=guess
lin capable_A = mkA "capaz" ; -- status=guess
lin recover_V2V = mkV2V (mkV "recuperar") ; -- status=guess
lin recover_V2 = mkV2 (mkV "recuperar") ; -- status=guess
lin recover_V = mkV "recuperar" ; -- status=guess
lin shot_N = mkN "chupito" ; -- status=guess
lin request_N = mkN "solicitud" feminine ; -- status=guess
lin impression_N = variants{} ; -- 
lin neighbour_N = mkN "vecino" | mkN "vecina" ; -- status=guess
lin theatre_N = variants{} ; -- 
lin beneath_Prep = variants{} ; -- 
lin hurt_VS = mkVS (doler_V) ; -- status=guess
lin hurt_V2 = mkV2 (doler_V) ; -- status=guess
lin hurt_V = doler_V ; -- status=guess
lin mechanism_N = mkN "mecanismo" ; -- status=guess
lin potential_N = variants{} ; -- 
lin lean_V2 = mkV2 (mkV "declinarse") ; -- status=guess
lin lean_V = mkV "declinarse" ; -- status=guess
lin defendant_N = mkN "acusado" ; -- status=guess
lin atmosphere_N = mkN "atmósfera" ; -- status=guess
lin slip_V2 = mkV2 (tropezar_V) ; -- status=guess
lin slip_V = tropezar_V ; -- status=guess
lin chain_N = mkN "cadena titulativa" ; -- status=guess
lin accompany_V2 = mkV2 (mkV "acompañar") ; -- status=guess
lin wonderful_A = mkA "maravilloso" ; -- status=guess
lin earn_VA = mkVA (mkV "granjear") | mkVA (merecer_V) ; -- status=guess
lin earn_V2 = mkV2 (mkV "granjear") | mkV2 (merecer_V) ; -- status=guess
lin earn_V = mkV "granjear" | merecer_V ; -- status=guess
lin enemy_N = L.enemy_N ;
lin desk_N = mkN "escritorio" | mkN "pupitre" masculine ; -- status=guess
lin engineering_N = mkN "ingeniería" ; -- status=guess
lin panel_N = mkN "panel" masculine ; -- status=guess
lin distinction_N = variants{} ; -- 
lin deputy_N = mkN "diputado" ; -- status=guess
lin discipline_N = mkN "disciplina" ; -- status=guess
lin strike_N = variants{} ; -- 
lin strike_2_N = variants{} ; -- 
lin strike_1_N = variants{} ; -- 
lin married_A = variants{} ; -- 
lin plenty_NP = variants{} ; -- 
lin establishment_N = mkN "establecimiento" ; -- status=guess
lin fashion_N = mkN "moda" ; -- status=guess
lin roof_N = L.roof_N ;
lin milk_N = L.milk_N ;
lin entire_A = mkA "entero" ; -- status=guess
lin tear_N = mkN "lágrima" ; -- status=guess
lin secondary_A = variants{} ; -- 
lin finding_N = variants{} ; -- 
lin welfare_N = variants{} ; -- 
lin increased_A = variants{} ; -- 
lin attach_V2 = mkV2 (mkV "anexar") | mkV2 (mkV "adjuntar") ; -- status=guess
lin attach_V = mkV "anexar" | mkV "adjuntar" ; -- status=guess
lin typical_A = variants{} ; -- 
lin typical_3_A = variants{} ; -- 
lin typical_2_A = variants{} ; -- 
lin typical_1_A = variants{} ; -- 
lin meanwhile_Adv = mkAdv "mientras tanto" ; -- status=guess
lin leadership_N = mkN "jefatura" ; -- status=guess
lin walk_N = mkN "trecho" | mkN "trayecto" ; -- status=guess
lin negotiation_N = mkN "negociación" feminine ; -- status=guess
lin clean_A = L.clean_A ;
lin religion_N = L.religion_N ;
lin count_V2 = L.count_V2 ;
lin count_V = contar_V ; -- status=guess
lin grey_A = variants{} ; -- 
lin hence_Adv = mkAdv "por lo tanto" | mkAdv "por eso" ; -- status=guess
lin alright_Adv = variants{} ; -- 
lin first_A = variants{} ; -- 
lin fuel_N = mkN "pila de combustible" | mkN "célula de combustible" ; -- status=guess
lin mine_N = mkN "mina" ; -- status=guess
lin appeal_V2V = mkV2V (mkV "apelar") ; -- status=guess
lin appeal_V2 = mkV2 (mkV "apelar") ; -- status=guess
lin appeal_V = mkV "apelar" ; -- status=guess
lin servant_N = variants{} ; -- 
lin liability_N = mkN "responsabilidad" feminine ; -- status=guess
lin constant_A = mkA "constante" ; -- status=guess
lin hate_VV = mkVV (mkV "odiar") ; -- status=guess
lin hate_V2V = mkV2V (mkV "odiar") ; -- status=guess
lin hate_V2 = L.hate_V2 ;
lin shoe_N = L.shoe_N ;
lin expense_N = variants{} ; -- 
lin vast_A = mkA "vasto" ; -- status=guess
lin soil_N = mkN "tierra" masculine ; -- status=guess
lin writing_N = mkN "escrito" | mkN "escritura" ; -- status=guess
lin nose_N = L.nose_N ;
lin origin_N = mkN "origen" masculine ; -- status=guess
lin lord_N = mkN "castellano" ; -- status=guess
lin rest_VA = mkVA (mkV "desistir") ; -- status=guess
lin rest_V2 = mkV2 (mkV "desistir") ; -- status=guess
lin rest_V = mkV "desistir" ; -- status=guess
lin drive_N = variants{} ; -- 
lin ticket_N = mkN "entrada" masculine ; -- status=guess
lin editor_N = mkN "jefe de redacción" ; -- status=guess
lin switch_V2 = mkV2 (mkV "intercambiar") | mkV2 (mkV "cambiar") ; -- status=guess
lin switch_V = mkV "intercambiar" | mkV "cambiar" ; -- status=guess
lin provided_Subj = variants{} ; -- 
lin northern_A = mkA "septentrional" | mkA "norteño" ; -- status=guess
lin significance_N = mkN "significado" ; -- status=guess
lin channel_N = mkN "canal" masculine ; -- status=guess
lin convention_N = mkN "convenio" ; -- status=guess
lin damage_V2 = mkV2 (mkV "dañar") ; -- status=guess
lin funny_A = mkA "divertido" | mkA "cómico" | mkA "gracioso" | mkA "chistoso" ; -- status=guess
lin bone_N = L.bone_N ;
lin severe_A = mkA "severo" | mkA "austero" ; -- status=guess
lin search_V2 = mkV2 (mkV "buscar") ; -- status=guess
lin search_V = mkV "buscar" ; -- status=guess
lin iron_N = L.iron_N ;
lin vision_N = mkN "visión" feminine ; -- status=guess
lin via_Prep = variants{} ; -- 
lin somewhat_Adv = mkAdv "algo" | mkAdv "un poco" ; -- status=guess
lin inside_Adv = mkAdv "de cabo a rabo" ; -- status=guess
lin trend_N = mkN "moda" ; -- status=guess
lin revolution_N = mkN "revolución" feminine ; -- status=guess
lin terrible_A = mkA "terrible" ; -- status=guess
lin knee_N = L.knee_N ;
lin dress_N = mkN "vestido" | mkN "traje" masculine ; -- status=guess
lin unfortunately_Adv = variants{} ; -- 
lin steal_V2 = mkV2 (mkV "robar") ; -- status=guess
lin steal_V = mkV "robar" ; -- status=guess
lin criminal_A = mkA "criminal" ; -- status=guess
lin signal_N = mkN "señal" masculine ; -- status=guess
lin notion_N = mkN "ganas" feminine | mkN "intención" feminine ; -- status=guess
lin comparison_N = mkN "comparación" masculine ; -- status=guess
lin academic_A = mkA "académico" ; -- status=guess
lin outcome_N = mkN "objetivos" masculine ; -- status=guess
lin lawyer_N = mkN "abogado" | mkN "abogada" | mkN "notario" ; -- status=guess
lin strongly_Adv = variants{} ; -- 
lin surround_V2 = mkV2 (mkV "circundar") | mkV2 (envolver_V) | mkV2 (mkV "cercar") ; -- status=guess
lin explore_VS = mkVS (mkV "explorar") ; -- status=guess
lin explore_V2 = mkV2 (mkV "explorar") ; -- status=guess
lin achievement_N = mkN "realización" feminine | mkN "logro" ; -- status=guess
lin odd_A = mkA "aproximadamente" ; -- status=guess
lin expectation_N = mkN "expectación" feminine ; -- status=guess
lin corporate_A = variants{} ; -- 
lin prisoner_N = mkN "prisionero" | mkN "preso" ; -- status=guess
lin question_V2 = mkV2 (mkV "preguntar") | mkV2 (mkV "consultar") | mkV2 (mkV "cuestionar") | mkV2 (mkV "interrogar") ; -- status=guess
lin rapidly_Adv = variants{} ; -- 
lin deep_Adv = variants{} ; -- 
lin southern_A = mkA "meridional" | mkA "del sur" | mkA "sureño" ; -- status=guess
lin amongst_Prep = variants{} ; -- 
lin withdraw_V2 = mkV2 (mkV "sacar") ; -- status=guess
lin withdraw_V = mkV "sacar" ; -- status=guess
lin afterwards_Adv = mkAdv "después" ; -- status=guess
lin paint_V2 = mkV2 (mkV "pintar") ; -- status=guess
lin paint_V = mkV "pintar" ; -- status=guess
lin judge_VS = mkVS (mkV "opinar") ; -- status=guess
lin judge_V2V = mkV2V (mkV "opinar") ; -- status=guess
lin judge_V2 = mkV2 (mkV "opinar") ; -- status=guess
lin judge_V = mkV "opinar" ; -- status=guess
lin citizen_N = variants{} ; -- 
lin permanent_A = mkA "permanente" ; -- status=guess
lin weak_A = mkA "débil" | mkA "feble" | mkA "flaco" | mkA "flojo" ; -- status=guess
lin separate_V2 = mkV2 (mkV "separar") | mkV2 (mkV "disgregar") ; -- status=guess
lin separate_V = mkV "separar" | mkV "disgregar" ; -- status=guess
lin plastic_N = L.plastic_N ;
lin connect_V2 = mkV2 (mkV "conectar") ; -- status=guess
lin connect_V = mkV "conectar" ; -- status=guess
lin fundamental_A = mkA "fundamental" ; -- status=guess
lin plane_N = mkN "cepillo" ; -- status=guess
lin height_N = mkN "altura" ; -- status=guess
lin opening_N = mkN "apertura" masculine ; -- status=guess
lin lesson_N = mkN "lección" feminine ; -- status=guess
lin similarly_Adv = variants{} ; -- 
lin shock_N = mkN "amortiguador" ; -- status=guess
lin rail_N = mkN "rascón" masculine ; -- status=guess
lin tenant_N = mkN "inquilino" | mkN "arrendatario" ; -- status=guess
lin owe_V2 = mkV2 (mkV (mkV "estar") "en deuda") | mkV2 (mkV "deber") | mkV2 (mkV "adeudar") ; -- status=guess
lin owe_V = mkV (mkV "estar") "en deuda" | mkV "deber" | mkV "adeudar" ; -- status=guess
lin originally_Adv = variants{} ; -- 
lin middle_A = mkA "medio" ; -- status=guess
lin somehow_Adv = mkAdv "de algún modo" | mkAdv "de alguna manera" ; -- status=guess
lin minor_A = variants{} ; -- 
lin negative_A = mkA "negativo" ; -- status=guess
lin knock_V2 = mkV2 (mkV (mkV "tocar") "madera") ; -- status=guess
lin knock_V = mkV (mkV "tocar") "madera" ; -- status=guess
lin root_N = L.root_N ;
lin pursue_V2 = mkV2 (perseguir_V) ; -- status=guess
lin pursue_V = perseguir_V ; -- status=guess
lin inner_A = variants{} ; -- 
lin crucial_A = mkA "crucial" ; -- status=guess
lin occupy_V2 = mkV2 (mkV "ocupar") ; -- status=guess
lin occupy_V = mkV "ocupar" ; -- status=guess
lin that_AdA = variants{} ; -- 
lin independence_N = mkN "independencia" ; -- status=guess
lin column_N = mkN "columna" ; -- status=guess
lin proceeding_N = variants{} ; -- 
lin female_N = mkN "hembra" ; -- status=guess
lin beauty_N = mkN "guapa" ; -- status=guess
lin perfectly_Adv = variants{} ; -- 
lin struggle_N = mkN "lucha" ; -- status=guess
lin gap_N = mkN "brecha" ; -- status=guess
lin house_V2 = mkV2 (mkV "alojar") | mkV2 (mkV "hospedar") | mkV2 (mkV "albergar") ; -- status=guess
lin database_N = mkN "administrador de base de datos" ; -- status=guess
lin stretch_V2 = mkV2 (mkV "extenderse") ; -- status=guess
lin stretch_V = mkV "extenderse" ; -- status=guess
lin stress_N = mkN "estrés" masculine ; -- status=guess
lin passenger_N = mkN "pasajero" ; -- status=guess
lin boundary_N = mkN "frontera" | mkN "límite" masculine ; -- status=guess
lin easy_Adv = variants{} ; -- 
lin view_V2 = mkV2 (ver_V) ; -- status=guess
lin manufacturer_N = mkN "fabricante" masculine ; -- status=guess
lin sharp_A = L.sharp_A ;
lin formation_N = variants{} ; -- 
lin queen_N = L.queen_N ;
lin waste_N = mkN "desechos" masculine | mkN "detrito" | mkN "basura" masculine ; -- status=guess
lin virtually_Adv = variants{} ; -- 
lin expand_V2V = variants{} ; -- 
lin expand_V2 = variants{} ; -- 
lin expand_V = variants{} ; -- 
lin contemporary_A = mkA "contemporario" | mkA "contemporáneo" ; -- status=guess
lin politician_N = mkN "político" | mkN "política" ; -- status=guess
lin back_V2 = variants{} ; -- 
lin back_V = variants{} ; -- 
lin territory_N = mkN "territorio" ; -- status=guess
lin championship_N = mkN "campeonato" ; -- status=guess
lin exception_N = mkN "excepción" feminine ; -- status=guess
lin thick_A = L.thick_A ;
lin inquiry_N = mkN "inquisición" | mkN "indagatoria" ; -- status=guess
lin topic_N = mkN "tema" masculine ; -- status=guess
lin resident_N = mkN "residente" | mkN "habitante" ; -- status=guess
lin transaction_N = mkN "transacción" feminine ; -- status=guess
lin parish_N = mkN "feligreses" masculine | mkN "feligreses" masculine ; -- status=guess
lin supporter_N = variants{} ; -- 
lin massive_A = mkA "masivo" ; -- status=guess
lin light_V2 = mkV2 (mkV "iluminar") ; -- status=guess
lin light_V = mkV "iluminar" ; -- status=guess
lin unique_A = mkA "único" | mkA "única" ; -- status=guess
lin challenge_V2 = mkV2 (mkV "retar") ; -- status=guess
lin challenge_V = mkV "retar" ; -- status=guess
lin inflation_N = mkN "inflación" feminine ; -- status=guess
lin assistance_N = mkN "asistencia" ; -- status=guess
lin list_V2V = mkV2V (mkV (mkV "hacer") "una lista") | mkV2V (mkV (mkV "leer") "una lista") ; -- status=guess
lin list_V2 = mkV2 (mkV (mkV "hacer") "una lista") | mkV2 (mkV (mkV "leer") "una lista") ; -- status=guess
lin list_V = mkV (mkV "hacer") "una lista" | mkV (mkV "leer") "una lista" ; -- status=guess
lin identity_N = mkN "elemento neutro" | mkN "elemento neutro por la izquierda" | mkN "elemento neutro por la derecha" ; -- status=guess
lin suit_V2 = mkV2 (convenir_V) ; -- status=guess
lin suit_V = convenir_V ; -- status=guess
lin parliamentary_A = mkA "parlamentario" ; -- status=guess
lin unknown_A = mkA "ignoto" | mkA "desconocido" ; -- status=guess
lin preparation_N = mkN "preparación" feminine ; -- status=guess
lin elect_V3 = mkV3 (elegir_V) ; -- status=guess
lin elect_V2V = mkV2V (elegir_V) ; -- status=guess
lin elect_V2 = mkV2 (elegir_V) ; -- status=guess
lin elect_V = elegir_V ; -- status=guess
lin badly_Adv = variants{} ; -- 
lin moreover_Adv = mkAdv "además" | mkAdv "adicionalmente" ; -- status=guess
lin tie_V2 = L.tie_V2 ;
lin tie_V = mkV "atar" | mkV "ligar" | mkV "amarrar" ; -- status=guess
lin cancer_N = mkN "cáncer" masculine ; -- status=guess
lin champion_N = mkN "campeón" masculine ; -- status=guess
lin exclude_V2 = mkV2 (excluir_V) ; -- status=guess
lin review_V2 = mkV2 (mkV "revisar") ; -- status=guess
lin review_V = mkV "revisar" ; -- status=guess
lin licence_N = variants{} ; -- 
lin breakfast_N = mkN "desayuno" ; -- status=guess
lin minority_N = mkN "minoría" ; -- status=guess
lin appreciate_V2 = mkV2 (mkV "comprender") | mkV2 (mkV (mkV "hacerse") "cargo de") ; -- status=guess
lin appreciate_V = mkV "comprender" | mkV (mkV "hacerse") "cargo de" ; -- status=guess
lin fan_N = variants{} ; -- 
lin fan_3_N = variants{} ; -- 
lin fan_2_N = variants{} ; -- 
lin fan_1_N = variants{} ; -- 
lin chief_N = mkN "jefe" masculine ; -- status=guess
lin accommodation_N = mkN "alojamiento" | mkN "hospedaje" masculine ; -- status=guess
lin subsequent_A = mkA "subsiguiente" ; -- status=guess
lin democracy_N = mkN "democracia" ; -- status=guess
lin brown_A = L.brown_A ;
lin taste_N = mkN "gusto" ; -- status=guess
lin crown_N = mkN "mudar" ; -- status=guess
lin permit_V2V = mkV2V (mkV "permitir") ; -- status=guess
lin permit_V2 = mkV2 (mkV "permitir") ; -- status=guess
lin permit_V = mkV "permitir" ; -- status=guess
lin buyer_N = variants{} ; -- 
lin gift_N = mkN "don" | mkN "talento" ; -- status=guess
lin resolution_N = mkN "resolución" feminine ; -- status=guess
lin angry_A = mkA "enojado" | mkA "enfadado" ; -- status=guess
lin metre_N = mkN "metro" ; -- status=guess
lin wheel_N = mkN "rueda" ; -- status=guess
lin clause_N = mkN "cláusula" ; -- status=guess
lin break_N = mkN "quebrar" ; -- status=guess
lin tank_N = mkN "tanque" masculine ; -- status=guess
lin benefit_V2 = mkV2 (mkV "beneficiar") ; -- status=guess
lin benefit_V = mkV "beneficiar" ; -- status=guess
lin engage_V2 = mkV2 (mkV "embragar") ; -- status=guess
lin engage_V = mkV "embragar" ; -- status=guess
lin alive_A = mkA "vivo" ; -- status=guess
lin complaint_N = mkN "problema" masculine ; -- status=guess
lin inch_N = mkN "pulgada" ; -- status=guess
lin firm_A = variants{} ; -- 
lin abandon_V2 = mkV2 (mkV "expulsar") ; -- status=guess
lin blame_V2 = mkV2 (mkV "culpar") | mkV2 (mkV "reprochar") ; -- status=guess
lin blame_V = mkV "culpar" | mkV "reprochar" ; -- status=guess
lin clean_V2 = mkV2 (mkV "limpiar") ; -- status=guess
lin clean_V = mkV "limpiar" ; -- status=guess
lin quote_V2 = mkV2 (mkV "cotizar") ; -- status=guess
lin quote_V = mkV "cotizar" ; -- status=guess
lin quantity_N = mkN "cantidad" feminine ; -- status=guess
lin rule_VS = mkVS (mkV "mandar") | mkVS (gobernar_V) ; -- status=guess
lin rule_V2 = mkV2 (mkV "mandar") | mkV2 (gobernar_V) ; -- status=guess
lin rule_V = mkV "mandar" | gobernar_V ; -- status=guess
lin guilty_A = mkA "culpable" ; -- status=guess
lin prior_A = mkA "previo" ; -- status=guess
lin round_A = L.round_A ;
lin eastern_A = mkA "oriental" ; -- status=guess
lin coat_N = L.coat_N ;
lin involvement_N = variants{} ; -- 
lin tension_N = variants{} ; -- 
lin diet_N = variants{} ; -- 
lin enormous_A = mkA "enorme" ; -- status=guess
lin score_N = mkN "partitura" ; -- status=guess
lin rarely_Adv = variants{} ; -- 
lin prize_N = mkN "premio" ; -- status=guess
lin remaining_A = variants{} ; -- 
lin significantly_Adv = variants{} ; -- 
lin glance_V2 = mkV2 (mkV "ojear") | mkV2 (mkV (mkV "echar") "un vistazo") | mkV2 (mkV "mirar") | mkV2 (mkV "pispear") ; -- status=guess
lin glance_V = mkV "ojear" | mkV (mkV "echar") "un vistazo" | mkV "mirar" | mkV "pispear" ; -- status=guess
lin dominate_V2 = variants{} ; -- 
lin dominate_V = variants{} ; -- 
lin trust_VS = mkVS (mkV "confiar") ; -- status=guess
lin trust_V2V = mkV2V (mkV "confiar") ; -- status=guess
lin trust_V2 = mkV2 (mkV "confiar") ; -- status=guess
lin trust_V = mkV "confiar" ; -- status=guess
lin naturally_Adv = variants{} ; -- 
lin interpret_V2 = variants{} ; -- 
lin interpret_V = variants{} ; -- 
lin land_V2 = mkV2 (mkV "aterrizar") ; -- status=guess
lin land_V = mkV "aterrizar" ; -- status=guess
lin frame_N = mkN "lote" masculine ; -- status=guess
lin extension_N = mkN "extensión" feminine ; -- status=guess
lin mix_V2 = mkV2 (mkV "mezclar") ; -- status=guess
lin mix_V = mkV "mezclar" ; -- status=guess
lin spokesman_N = mkN "portavoz" masculine | mkN "vocero" ; -- status=guess
lin friendly_A = mkA "amistoso" ; -- status=guess
lin acknowledge_VS = variants{} ; -- 
lin acknowledge_V2 = variants{} ; -- 
lin acknowledge_V = variants{} ; -- 
lin register_V2 = mkV2 (mkV "registrar") | mkV2 (mkV "registrarse") ; -- status=guess
lin register_V = mkV "registrar" | mkV "registrarse" ; -- status=guess
lin regime_N = variants{} ; -- 
lin regime_2_N = variants{} ; -- 
lin regime_1_N = variants{} ; -- 
lin fault_N = mkN "defecto" | mkN "falla" ; -- status=guess
lin dispute_N = variants{} ; -- 
lin grass_N = L.grass_N ;
lin quietly_Adv = variants{} ; -- 
lin decline_N = mkN "declinación" feminine ; -- status=guess
lin dismiss_V2 = mkV2 (despedir_V) | mkV2 (mkV "echar") ; -- status=guess
lin delivery_N = mkN "entrega" ; -- status=guess
lin complain_VS = mkVS (mkV "quejarse") ; -- status=guess
lin complain_V = mkV "quejarse" ; -- status=guess
lin conservative_N = mkN "conservador" masculine ; -- status=guess
lin shift_V2 = mkV2 (mkV "cambiar") ; -- status=guess
lin shift_V = mkV "cambiar" ; -- status=guess
lin port_N = mkN "puerto" ; -- status=guess
lin beach_N = mkN "playa" ; -- status=guess
lin string_N = mkN "cadena" masculine ; -- status=guess
lin depth_N = mkN "profundidad" feminine ; -- status=guess
lin unusual_A = variants{} ; -- 
lin travel_N = mkN "viaje" masculine ; -- status=guess
lin pilot_N = mkN "piloto" ; -- status=guess
lin obligation_N = mkN "comprometerse" ; -- status=guess
lin gene_N = mkN "gen" | mkN "gene" masculine ; -- status=guess
lin yellow_A = L.yellow_A ;
lin republic_N = mkN "república" ; -- status=guess
lin shadow_N = mkN "sombra" ; -- status=guess
lin dear_A = mkA "señor mío" | mkA "señora mía" | mkA "estimado" | mkA "estimada" ; -- status=guess
lin analyse_V2 = variants{} ; -- 
lin anywhere_Adv = mkAdv "en cualquier parte" | mkAdv "dondequiera" ; -- status=guess
lin average_N = mkN "promedio" ; -- status=guess
lin phrase_N = mkN "libro de frases" ; -- status=guess
lin long_term_A = variants{} ; -- 
lin crew_N = mkN "corte militar" ; -- status=guess
lin lucky_A = mkA "fortunado" | mkA "afortunado" ; -- status=guess
lin restore_V2 = mkV2 (mkV "restaurar") ; -- status=guess
lin convince_V2V = mkV2V (convencer_V) ; -- status=guess
lin convince_V2 = mkV2 (convencer_V) ; -- status=guess
lin coast_N = mkN "costa" | mkN "litoral" masculine ; -- status=guess
lin engineer_N = mkN "ingeniero" ; -- status=guess
lin heavily_Adv = variants{} ; -- 
lin extensive_A = mkA "extenso" ; -- status=guess
lin glad_A = mkA "contento" ; -- status=guess
lin charity_N = mkN "caridad" feminine | mkN "amor al prójimo" ; -- status=guess
lin oppose_VS = mkVS (oponer_V) ; -- status=guess
lin oppose_V2 = mkV2 (oponer_V) ; -- status=guess
lin oppose_V = oponer_V ; -- status=guess
lin defend_V2 = mkV2 (defender_V) ; -- status=guess
lin defend_V = defender_V ; -- status=guess
lin alter_V2 = mkV2 (mkV "alterar") | mkV2 (mkV "cambiar") | mkV2 (mkV "modificar") ; -- status=guess
lin alter_V = mkV "alterar" | mkV "cambiar" | mkV "modificar" ; -- status=guess
lin warning_N = variants{} ; -- 
lin arrest_V2 = mkV2 (mkV "parar") ; -- status=guess
lin framework_N = mkN "infraestructura" ; -- status=guess
lin approval_N = mkN "aprobación" feminine ; -- status=guess
lin bother_VV = mkVV (mkV "molestar") | mkVV (mkV "agobiar") ; -- status=guess
lin bother_V2V = mkV2V (mkV "molestar") | mkV2V (mkV "agobiar") ; -- status=guess
lin bother_V2 = mkV2 (mkV "molestar") | mkV2 (mkV "agobiar") ; -- status=guess
lin bother_V = mkV "molestar" | mkV "agobiar" ; -- status=guess
lin novel_N = mkN "novela" ; -- status=guess
lin accuse_V2 = mkV2 (mkV "acusar") | mkV2 (mkV "denunciar") ; -- status=guess
lin surprised_A = variants{} ; -- 
lin currency_N = mkN "moneda" ; -- status=guess
lin restrict_V2 = mkV2 (restringir_V) ; -- status=guess
lin restrict_V = restringir_V ; -- status=guess
lin possess_V2 = mkV2 (poseer_V) ; -- status=guess
lin moral_A = variants{} ; -- 
lin protein_N = mkN "proteína" ; -- status=guess
lin distinguish_V2 = mkV2 (distinguir_V) ; -- status=guess
lin distinguish_V = distinguir_V ; -- status=guess
lin gently_Adv = mkAdv "mansamente" | mkAdv "suave" ; -- status=guess
lin reckon_VS = mkVS (atribuir_V) | mkVS (mkV "adjudicar") ; -- status=guess
lin reckon_V2 = mkV2 (atribuir_V) | mkV2 (mkV "adjudicar") ; -- status=guess
lin reckon_V = atribuir_V | mkV "adjudicar" ; -- status=guess
lin incorporate_V2 = variants{} ; -- 
lin incorporate_V = variants{} ; -- 
lin proceed_VV = mkVV (mkV "proceder") ; -- status=guess
lin proceed_V2 = mkV2 (mkV "proceder") ; -- status=guess
lin proceed_V = mkV "proceder" ; -- status=guess
lin assist_V2 = mkV2 (mkV "ayudar") ; -- status=guess
lin assist_V = mkV "ayudar" ; -- status=guess
lin sure_Adv = variants{} ; -- 
lin stress_VS = mkVS (mkV "estresar") ; -- status=guess
lin stress_V2 = mkV2 (mkV "estresar") ; -- status=guess
lin justify_VV = mkVV (mkV "justificar") ; -- status=guess
lin justify_V2 = mkV2 (mkV "justificar") ; -- status=guess
lin behalf_N = variants{} ; -- 
lin councillor_N = variants{} ; -- 
lin setting_N = variants{} ; -- 
lin command_N = mkN "orden" feminine | mkN "mandato" ; -- status=guess
lin command_2_N = variants{} ; -- 
lin command_1_N = variants{} ; -- 
lin maintenance_N = mkN "mantenimiento" ; -- status=guess
lin stair_N = mkN "escalera" ; -- status=guess
lin poem_N = mkN "poema" masculine | mkN "poesía" | mkN "oda" ; -- status=guess
lin chest_N = mkN "cómoda" ; -- status=guess
lin like_Adv = mkAdv "como" ; -- status=guess
lin secret_N = mkN "secreto" ; -- status=guess
lin restriction_N = mkN "restricción" feminine ; -- status=guess
lin efficient_A = mkA "eficiente" ; -- status=guess
lin suspect_VS = mkVS (mkV "sospechar") ; -- status=guess
lin suspect_V2 = mkV2 (mkV "sospechar") ; -- status=guess
lin hat_N = L.hat_N ;
lin tough_A = mkA "severo" ; -- status=guess
lin firmly_Adv = variants{} ; -- 
lin willing_A = mkA "dispuesto" ; -- status=guess
lin healthy_A = mkA "saludable" | mkA "sano" ; -- status=guess
lin focus_N = mkN "foco de atención" ; -- status=guess
lin construct_V2 = mkV2 (construir_V) ; -- status=guess
lin occasionally_Adv = variants{} ; -- 
lin mode_N = mkN "moda" ; -- status=guess
lin saving_N = variants{} ; -- 
lin comfortable_A = mkA "confortable" ; -- status=guess
lin camp_N = mkN "facción" feminine | mkN "bando" ; -- status=guess
lin trade_V2 = mkV2 (mkV "comerciar") ; -- status=guess
lin trade_V = mkV "comerciar" ; -- status=guess
lin export_N = variants{} ; -- 
lin wake_V2 = mkV2 (despertar_V) ; -- status=guess
lin wake_V = despertar_V ; -- status=guess
lin partnership_N = variants{} ; -- 
lin daily_A = mkA "diario" | mkA "cotidiano" ; -- status=guess
lin abroad_Adv = mkAdv "por todas partes" | mkAdv "en todas direciones" ; -- status=guess
lin profession_N = mkN "profesión" feminine ; -- status=guess
lin load_N = mkN "carga" | mkN "cargamento" ; -- status=guess
lin countryside_N = mkN "campo" ; -- status=guess
lin boot_N = L.boot_N ;
lin mostly_Adv = mkAdv "principalmente" ; -- status=guess
lin sudden_A = mkA "repentino" ; -- status=guess
lin implement_V2 = mkV2 (mkV "implementar") ; -- status=guess
lin reputation_N = mkN "reputación" feminine ; -- status=guess
lin print_V2 = mkV2 (imprimir_V) ; -- status=guess
lin print_V = imprimir_V ; -- status=guess
lin calculate_VS = mkVS (mkV "calcular") ; -- status=guess
lin calculate_V2 = mkV2 (mkV "calcular") ; -- status=guess
lin calculate_V = mkV "calcular" ; -- status=guess
lin keen_A = mkA "entusiasta" | mkA "con perspicaz" | mkA "fijo" ; -- status=guess
lin guess_VS = mkVS (mkV "adivinar") | mkVS (mkV "conjeturar") ; -- status=guess
lin guess_V2 = mkV2 (mkV "adivinar") | mkV2 (mkV "conjeturar") ; -- status=guess
lin guess_V = mkV "adivinar" | mkV "conjeturar" ; -- status=guess
lin recommendation_N = mkN "recomendación" feminine ; -- status=guess
lin autumn_N = mkN "otoño" ; -- status=guess
lin conventional_A = mkA "convencional" ; -- status=guess
lin cope_V = mkV "afrontar" ; -- status=guess
lin constitute_V2 = variants{} ; -- 
lin poll_N = mkN "encuesta" ; -- status=guess
lin voluntary_A = mkA "voluntario" ; -- status=guess
lin valuable_A = mkA "valioso" ; -- status=guess
lin recovery_N = mkN "recuperación" feminine ; -- status=guess
lin cast_V2 = mkV2 (mkV (mkV "poner") "en duda") ; -- status=guess
lin cast_V = mkV (mkV "poner") "en duda" ; -- status=guess
lin premise_N = mkN "premisa" ; -- status=guess
lin resolve_VV = mkVV (resolver_V) ; -- status=guess
lin resolve_V2 = mkV2 (resolver_V) ; -- status=guess
lin resolve_V = resolver_V ; -- status=guess
lin regularly_Adv = variants{} ; -- 
lin solve_V2 = mkV2 (resolver_V) | mkV2 (mkV "solucionar") ; -- status=guess
lin plaintiff_N = mkN "demandante" | mkN "querellante." ; -- status=guess
lin critic_N = mkN "crítico" ; -- status=guess
lin agriculture_N = mkN "agricultura" ; -- status=guess
lin ice_N = L.ice_N ;
lin constitution_N = mkN "constitución" feminine | mkN "constituciones" ; -- status=guess
lin communist_N = mkN "comunista" masculine ; -- status=guess
lin layer_N = mkN "gallina ponedora" | mkN "onedora" ; -- status=guess
lin recession_N = mkN "recesión" feminine ; -- status=guess
lin slight_A = mkA "insignificante" | mkA "leve" ; -- status=guess
lin dramatic_A = mkA "dramático" ; -- status=guess
lin golden_A = mkA "dorado" ; -- status=guess
lin temporary_A = mkA "temporal" ; -- status=guess
lin suit_N = mkN "proceso ." | mkN "pleito" | mkN "litigio" | mkN "acción" feminine ; -- status=guess
lin shortly_Adv = variants{} ; -- 
lin initially_Adv = variants{} ; -- 
lin arrival_N = mkN "llegada" | mkN "venida" | mkN "arribo" ; -- status=guess
lin protest_N = mkN "protesta" ; -- status=guess
lin resistance_N = mkN "resistencia" ; -- status=guess
lin silent_A = mkA "silencioso" ; -- status=guess
lin presentation_N = mkN "presentación" feminine ; -- status=guess
lin soul_N = mkN "barbilla de labio inferior" | mkN "barbillita" ; -- status=guess
lin self_N = mkN "yo" ; -- status=guess
lin judgment_N = mkN "juicio" ; -- status=guess
lin feed_V2 = mkV2 (mkV "alimentar") | mkV2 (mkV (mkV "dar") "de comer") ; -- status=guess
lin feed_V = mkV "alimentar" | mkV (mkV "dar") "de comer" ; -- status=guess
lin muscle_N = mkN "músculo" ; -- status=guess
lin shareholder_N = mkN "accionista" masculine ; -- status=guess
lin opposite_A = mkA "opuesto" ; -- status=guess
lin pollution_N = mkN "polución" | mkN "contaminación" feminine ; -- status=guess
lin wealth_N = mkN "prosperidad" feminine | mkN "riqueza" ; -- status=guess
lin video_taped_A = variants{} ; -- 
lin kingdom_N = variants{} ; -- 
lin bread_N = L.bread_N ;
lin perspective_N = mkN "perspectiva" ; -- status=guess
lin camera_N = L.camera_N ;
lin prince_N = mkN "príncipe" masculine | mkN "conde" masculine ; -- status=guess
lin illness_N = mkN "enfermedad" feminine ; -- status=guess
lin cake_N = variants{} ; -- 
lin meat_N = L.meat_N ;
lin submit_V2 = mkV2 (mkV "someter") | mkV2 (mkV "presentar") | mkV2 (mkV "entregar") ; -- status=guess
lin submit_V = mkV "someter" | mkV "presentar" | mkV "entregar" ; -- status=guess
lin ideal_A = mkA "ideal" ; -- status=guess
lin relax_V2 = mkV2 (mkV "relajar") ; -- status=guess
lin relax_V = mkV "relajar" ; -- status=guess
lin penalty_N = mkN "penalti" masculine ; -- status=guess
lin purchase_V2 = mkV2 (mkV "comprar") ; -- status=guess
lin tired_A = variants{} ; -- 
lin beer_N = L.beer_N ;
lin specify_VS = mkVS (mkV "especificar") ; -- status=guess
lin specify_V2 = mkV2 (mkV "especificar") ; -- status=guess
lin specify_V = mkV "especificar" ; -- status=guess
lin short_Adv = variants{} ; -- 
lin monitor_V2 = mkV2 (mkV "controlar") ; -- status=guess
lin monitor_V = mkV "controlar" ; -- status=guess
lin electricity_N = mkN "electricidad" feminine ; -- status=guess
lin specifically_Adv = variants{} ; -- 
lin bond_N = mkN "enlace" masculine ; -- status=guess
lin statutory_A = mkA "reglamentario" ; -- status=guess
lin laboratory_N = mkN "laboratorio" ; -- status=guess
lin federal_A = mkA "federal" ; -- status=guess
lin captain_N = mkN "capitán" masculine ; -- status=guess
lin deeply_Adv = variants{} ; -- 
lin pour_V2 = mkV2 (verter_V) ; -- status=guess
lin pour_V = verter_V ; -- status=guess
lin boss_N = L.boss_N ;
lin creature_N = mkN "criatura" ; -- status=guess
lin urge_VS = mkVS (mkV "impulsar") | mkVS (urgir_V) | mkVS (mkV "aguijonear") | mkVS (mkV "apresurar") | mkVS (mkV "presionar") | mkVS (mkV "empujar") | mkVS (mkV "aguijar") | mkVS (mkV "jalear") ; -- status=guess
lin urge_V2V = mkV2V (mkV "impulsar") | mkV2V (urgir_V) | mkV2V (mkV "aguijonear") | mkV2V (mkV "apresurar") | mkV2V (mkV "presionar") | mkV2V (mkV "empujar") | mkV2V (mkV "aguijar") | mkV2V (mkV "jalear") ; -- status=guess
lin urge_V2 = mkV2 (mkV "impulsar") | mkV2 (urgir_V) | mkV2 (mkV "aguijonear") | mkV2 (mkV "apresurar") | mkV2 (mkV "presionar") | mkV2 (mkV "empujar") | mkV2 (mkV "aguijar") | mkV2 (mkV "jalear") ; -- status=guess
lin locate_V2 = mkV2 (mkV "ubicar") ; -- status=guess
lin locate_V = mkV "ubicar" ; -- status=guess
lin being_N = mkN "ser" masculine | mkN "criatura" ; -- status=guess
lin struggle_VV = mkVV (mkV "luchar") | mkVV (mkV (mkV "esforzarse") "con denuedo") ; -- status=guess
lin struggle_VS = mkVS (mkV "luchar") | mkVS (mkV (mkV "esforzarse") "con denuedo") ; -- status=guess
lin struggle_V = mkV "luchar" | mkV (mkV "esforzarse") "con denuedo" ; -- status=guess
lin lifespan_N = variants{} ; -- 
lin flat_A = mkA "llano" | mkA "plano" ; -- status=guess
lin valley_N = mkN "valle" feminine ; -- status=guess
lin like_A = mkA "semejante" | mkA "similar" ; -- status=guess
lin guard_N = mkN "vanguardia" ; -- status=guess
lin emergency_N = mkN "emergencia" | mkN "urgencia" ; -- status=guess
lin dark_N = mkN "oscuridad" feminine ; -- status=guess
lin bomb_N = mkN "bomba" ; -- status=guess
lin dollar_N = mkN "dólar" masculine ; -- status=guess
lin efficiency_N = mkN "eficiencia" ; -- status=guess
lin mood_N = mkN "mal humor" | mkN " mal genio" ; -- status=guess
lin convert_V2 = mkV2 (mkV "convertir") ; -- status=guess
lin convert_V = mkV "convertirse" ; -- status=guess
lin possession_N = mkN "posesión" feminine ; -- status=guess
lin marketing_N = mkN "mercadotecnia" ; -- status=guess
lin please_VV = mkVV (mkV "gustar") | mkVV (mkV "agradar") ; -- status=guess
lin please_V2V = mkV2V (mkV "gustar") | mkV2V (mkV "agradar") ; -- status=guess
lin please_V2 = mkV2 (mkV "gustar") | mkV2 (mkV "agradar") ; -- status=guess
lin please_V = mkV "gustar" | mkV "agradar" ; -- status=guess
lin habit_N = mkN "hábito" ; -- status=guess
lin subsequently_Adv = variants{} ; -- 
lin round_N = mkN "ángulo redondo" ; -- status=guess
lin purchase_N = mkN "adquisición" feminine ; -- status=guess
lin sort_V2 = mkV2 (mkV "ordenar") ; -- status=guess
lin sort_V = mkV "ordenar" ; -- status=guess
lin outside_A = variants{} ; -- 
lin gradually_Adv = variants{} ; -- 
lin expansion_N = mkN "expansión" feminine ; -- status=guess
lin competitive_A = mkA "competitivo" ; -- status=guess
lin cooperation_N = mkN "cooperación" ; -- status=guess
lin acceptable_A = mkA "aceptable" ; -- status=guess
lin angle_N = mkN "bisectriz" feminine ; -- status=guess
lin cook_V2 = mkV2 (mkV "cocinar") | mkV2 (cocer_V) ; -- status=guess
lin cook_V = mkV "cocinar" | cocer_V ; -- status=guess
lin net_A = mkA "neto" ; -- status=guess
lin sensitive_A = mkA "sensible" | mkA "susceptible" ; -- status=guess
lin ratio_N = mkN "razón" feminine | mkN "cociente" masculine | mkN "relación" feminine | mkN "proporción" feminine ; -- status=guess
lin kiss_V2 = mkV2 (mkV "besarse") ; -- status=guess
lin kiss_V = mkV "besarse" ; -- status=guess
lin amount_V = variants{} ; -- 
lin sleep_N = mkN "sueño" | mkN "dormir" masculine ; -- status=guess
lin finance_V2 = mkV2 (mkV "financiar") ; -- status=guess
lin essentially_Adv = variants{} ; -- 
lin fund_V2 = mkV2 (mkV "financiar") | mkV2 (mkV "sufragar") | mkV2 (mkV "patrocinar") ; -- status=guess
lin preserve_V2 = mkV2 (mkV "preservar") ; -- status=guess
lin wedding_N = mkN "boda" | mkN "nupcias" feminine | mkN "casamiento" ; -- status=guess
lin personality_N = mkN "personalidad" feminine ; -- status=guess
lin bishop_N = mkN "alfil" | mkN "arfil" masculine ; -- status=guess
lin dependent_A = mkA "dependiente" ; -- status=guess
lin landscape_N = mkN "apaisado" ; -- status=guess
lin pure_A = mkA "puro" ; -- status=guess
lin mirror_N = mkN "espejo" ; -- status=guess
lin lock_V2 = mkV2 (mkV (mkV "cerrar") "con llave") | mkV2 (mkV "acerrojar") | mkV2 (mkV "candar") ; -- status=guess
lin lock_V = mkV (mkV "cerrar") "con llave" | mkV "acerrojar" | mkV "candar" ; -- status=guess
lin symptom_N = mkN "síntoma" masculine ; -- status=guess
lin promotion_N = mkN "ascenso" feminine ; -- status=guess
lin global_A = mkA "mundial" | mkA "global" ; -- status=guess
lin aside_Adv = variants{} ; -- 
lin tendency_N = mkN "tendencia" ; -- status=guess
lin conservation_N = variants{} ; -- 
lin reply_N = mkN "respuesta" ; -- status=guess
lin estimate_N = mkN "presupuesto" | mkN "estimación" masculine ; -- status=guess
lin qualification_N = mkN "calificación" feminine ; -- status=guess
lin pack_V2 = variants{} ; -- 
lin pack_V = variants{} ; -- 
lin governor_N = mkN "gobernador general" ; -- status=guess
lin expected_A = variants{} ; -- 
lin invest_V2 = mkV2 (invertir_V) | mkV2 (investir_V) ; -- status=guess
lin invest_V = invertir_V | investir_V ; -- status=guess
lin cycle_N = mkN "ciclo" ; -- status=guess
lin alright_A = variants{} ; -- 
lin philosophy_N = mkN "filosofía" ; -- status=guess
lin gallery_N = variants{} ; -- 
lin sad_A = mkA "triste" ; -- status=guess
lin intervention_N = mkN "intervención" ; -- status=guess
lin emotional_A = mkA "emocional" ; -- status=guess
lin advertising_N = mkN "publicidad" feminine ; -- status=guess
lin regard_N = variants{} ; -- 
lin dance_V2 = mkV2 (mkV "bailar") | mkV2 (mkV "danzar") ; -- status=guess
lin dance_V = mkV "bailar" | mkV "danzar" ; -- status=guess
lin cigarette_N = mkN "cigarrillo" ; -- status=guess
lin predict_VS = mkVS (predecir_V) ; -- status=guess
lin predict_V2 = mkV2 (predecir_V) ; -- status=guess
lin adequate_A = mkA "adecuado" ; -- status=guess
lin variable_N = mkN "batará variable" ; -- status=guess
lin net_N = mkN "red" feminine ; -- status=guess
lin retire_V2 = mkV2 (mkV "jubilar") ; -- status=guess
lin retire_V = mkV "jubilar" ; -- status=guess
lin sugar_N = mkN "azúcar" masculine ; -- status=guess
lin pale_A = mkA "pálido" ; -- status=guess
lin frequency_N = mkN "modulación de la frecuencia" ; -- status=guess
lin guy_N = mkN "tipo" ; -- status=guess
lin feature_V2 = mkV2 (mkV "priorizar") ; -- status=guess
lin furniture_N = mkN "mobiliario" | mkN "mueble" ; -- status=guess
lin administrative_A = mkA "administrativo" ; -- status=guess
lin wooden_A = variants{} ; -- 
lin input_N = mkN "insumo" ; -- status=guess
lin phenomenon_N = mkN "fenómeno" ; -- status=guess
lin surprising_A = mkA "sorprendente" ; -- status=guess
lin jacket_N = mkN "chaqueta" ; -- status=guess
lin actor_N = mkN "actor" | mkN "actriz" feminine ; -- status=guess
lin actor_2_N = variants{} ; -- 
lin actor_1_N = variants{} ; -- 
lin kick_V2 = mkV2 (mkV (mkV "dar") "una patada a") | mkV2 (mkV (mkV "dar") "un puntapié a") | mkV2 (mkV "patear") ; -- status=guess
lin kick_V = mkV (mkV "dar") "una patada a" | mkV (mkV "dar") "un puntapié a" | mkV "patear" ; -- status=guess
lin producer_N = mkN "productor" ; -- status=guess
lin hearing_N = mkN "audición" feminine ; -- status=guess
lin chip_N = mkN "chip" masculine ; -- status=guess
lin equation_N = mkN "ecuación" feminine ; -- status=guess
lin certificate_N = mkN "certificado" ; -- status=guess
lin hello_Interj = mkInterj "hola" | mkInterj "buenos días" | mkInterj "qué tal" ; -- status=guess
lin remarkable_A = mkA "notable" ; -- status=guess
lin alliance_N = mkN "alianza" ; -- status=guess
lin smoke_V2 = mkV2 (mkV (mkV "fumar") "como un carretero") ; -- status=guess
lin smoke_V = mkV (mkV "fumar") "como un carretero" ; -- status=guess
lin awareness_N = mkN "conciencia" ; -- status=guess
lin throat_N = mkN "garganta" ; -- status=guess
lin discovery_N = mkN "descubrimiento" ; -- status=guess
lin festival_N = mkN "festival" masculine ; -- status=guess
lin dance_N = mkN "baile" masculine | mkN "danza" ; -- status=guess
lin promise_N = mkN "promesa" ; -- status=guess
lin rose_N = mkN "rosado" ; -- status=guess
lin principal_A = mkA "principal" ; -- status=guess
lin brilliant_A = mkA "brillante" ; -- status=guess
lin proposed_A = variants{} ; -- 
lin coach_N = mkN "autocar" masculine ; -- status=guess
lin coach_3_N = variants{} ; -- 
lin coach_2_N = variants{} ; -- 
lin coach_1_N = variants{} ; -- 
lin absolute_A = mkA "completo" | mkA "pleno" ; -- status=guess
lin drama_N = mkN "drama" masculine ; -- status=guess
lin recording_N = mkN "grabación" feminine ; -- status=guess
lin precisely_Adv = variants{} ; -- 
lin bath_N = mkN "baño" feminine ; -- status=guess
lin celebrate_V2 = mkV2 (mkV "celebrar") | mkV2 (mkV "reverenciar") ; -- status=guess
lin substance_N = mkN "sustancia" ; -- status=guess
lin swing_V2 = mkV2 (mkV "columpiar") ; -- status=guess
lin swing_V = mkV "columpiarse" ; -- status=guess
lin for_Adv = variants{}; -- S.for_Prep ;
lin rapid_A = mkA "rápido" ; -- status=guess
lin rough_A = mkA "aproximado" | mkA "aproximativo" | mkA "casi" ; -- status=guess
lin investor_N = mkN "inversionista" | mkN "inversor" ; -- status=guess
lin fire_V2 = mkV2 (mkV "disparar") | mkV2 (mkV "descargar") ; -- status=guess
lin fire_V = mkV "disparar" | mkV "descargar" ; -- status=guess
lin rank_N = mkN "columna" ; -- status=guess
lin compete_V = competir_V ; -- status=guess
lin sweet_A = mkA "azucarado" ; -- status=guess
lin decline_VV = mkVV (mkV "rechazar") ; -- status=guess
lin decline_VS = mkVS (mkV "rechazar") ; -- status=guess
lin decline_V2 = mkV2 (mkV "rechazar") ; -- status=guess
lin decline_V = mkV "rechazar" ; -- status=guess
lin rent_N = mkN "rasgadura" ; -- status=guess
lin dealer_N = mkN "concesionario" ; -- status=guess
lin bend_V2 = mkV2 (mkV "inclinarse") ; -- status=guess
lin bend_V = mkV "inclinarse" ; -- status=guess
lin solid_A = mkA "sólido" ; -- status=guess
lin cloud_N = L.cloud_N ;
lin across_Adv = variants{}; -- mkPrep "a través de" ;
lin level_A = mkA "nivelado" ; -- status=guess
lin enquiry_N = variants{} ; -- 
lin fight_N = mkN "lucha" | mkN "lucha" ; -- status=guess
lin abuse_N = mkN "abuso" ; -- status=guess
lin golf_N = mkN "golf" masculine ; -- status=guess
lin guitar_N = mkN "guitarra" masculine ; -- status=guess
lin electronic_A = mkA "electrónico" ; -- status=guess
lin cottage_N = mkN "chalet" ; -- status=guess
lin scope_N = mkN "ámbito" ; -- status=guess
lin pause_VS = mkVS (mkV "pausar") | mkVS (mkV "interrumpir") | mkVS (mkV "suspender") ; -- status=guess
lin pause_V2V = mkV2V (mkV "pausar") | mkV2V (mkV "interrumpir") | mkV2V (mkV "suspender") ; -- status=guess
lin pause_V = mkV "pausar" | mkV "interrumpir" | mkV "suspender" ; -- status=guess
lin mixture_N = mkN "mezcla" ; -- status=guess
lin emotion_N = mkN "afecto" | mkN "emoción" feminine ; -- status=guess
lin comprehensive_A = mkA "completo" | mkA "exhaustivo" ; -- status=guess
lin shirt_N = L.shirt_N ;
lin allowance_N = variants{} ; -- 
lin retirement_N = mkN "jubilación" | mkN "retirada" ; -- status=guess
lin breach_N = mkN "brecha" ; -- status=guess
lin infection_N = mkN "infección" feminine ; -- status=guess
lin resist_VV = variants{} ; -- 
lin resist_V2 = variants{} ; -- 
lin resist_V = variants{} ; -- 
lin qualify_V2 = mkV2 (mkV "calificar") ; -- status=guess
lin qualify_V = mkV "calificar" ; -- status=guess
lin paragraph_N = mkN "párrafo" ; -- status=guess
lin sick_A = mkA "enfermo" | mkA "enferma" | mkA "mareado" ; -- status=guess
lin near_A = L.near_A ;
lin researcher_N = variants{} ; -- 
lin consent_N = mkN "consenso" ; -- status=guess
lin written_A = variants{} ; -- 
lin literary_A = mkA "literario" ; -- status=guess
lin ill_A = mkA "mal" | mkA "mareado" ; -- status=guess
lin wet_A = L.wet_A ;
lin lake_N = L.lake_N ;
lin entrance_N = mkN "entrada" masculine ; -- status=guess
lin peak_N = mkN "medidor de flujo espiratorio" ; -- status=guess
lin successfully_Adv = variants{} ; -- 
lin sand_N = L.sand_N ;
lin breathe_V2 = mkV2 (mkV "respirar") ; -- status=guess
lin breathe_V = L.breathe_V ;
lin cold_N = mkN "puerta fría" ; -- status=guess
lin cheek_N = mkN "nalga" | mkN "glúteo" ; -- status=guess
lin platform_N = mkN "plataforma" ; -- status=guess
lin interaction_N = mkN "interacción" feminine ; -- status=guess
lin watch_N = mkN "reloj" masculine ; -- status=guess
lin borrow_VV = mkVV (mkV (mkV "tomar") "prestado") ; -- status=guess
lin borrow_V2 = mkV2 (mkV (mkV "tomar") "prestado") ; -- status=guess
lin borrow_V = mkV (mkV "tomar") "prestado" ; -- status=guess
lin birthday_N = mkN "cumpleaños" | mkN "natalicio" ; -- status=guess
lin knife_N = mkN "cuchillo" ; -- status=guess
lin extreme_A = mkA "extremo" ; -- status=guess
lin core_N = mkN "corazón" masculine ; -- status=guess
lin peasant_N = variants{} ; -- 
lin armed_A = variants{} ; -- 
lin permission_N = mkN "permiso" ; -- status=guess
lin supreme_A = mkA "supremo" | mkA "suprema" ; -- status=guess
lin overcome_V2 = mkV2 (vencer_V) | mkV2 (mkV "superar") ; -- status=guess
lin overcome_V = vencer_V | mkV "superar" ; -- status=guess
lin greatly_Adv = variants{} ; -- 
lin visual_A = mkA "visual" ; -- status=guess
lin lad_N = mkN "niño" | mkN "chico" ; -- status=guess
lin genuine_A = mkA "genuino" | mkA "auténtico" | mkA "legítimo" | mkA "verdadero" ; -- status=guess
lin personnel_N = mkN "personal" feminine ; -- status=guess
lin judgement_N = mkN "día del Juicio Final" ; -- status=guess
lin exciting_A = mkA "emocionante" ; -- status=guess
lin stream_N = mkN "corriente" feminine | mkN "flujo" ; -- status=guess
lin perception_N = mkN "percepción" feminine ; -- status=guess
lin guarantee_VS = mkVS (mkV "garantizar") ; -- status=guess
lin guarantee_V2 = mkV2 (mkV "garantizar") ; -- status=guess
lin guarantee_V = mkV "garantizar" ; -- status=guess
lin disaster_N = mkN "desastre" masculine ; -- status=guess
lin darkness_N = mkN "oscuridad" feminine ; -- status=guess
lin bid_N = mkN "licitación" feminine ; -- status=guess
lin sake_N = mkN "sake" ; -- status=guess
lin sake_2_N = variants{} ; -- 
lin sake_1_N = variants{} ; -- 
lin organize_V2V = mkV2V (mkV "organizar") ; -- status=guess
lin organize_V2 = mkV2 (mkV "organizar") ; -- status=guess
lin tourist_N = mkN "turista" masculine ; -- status=guess
lin policeman_N = L.policeman_N ;
lin castle_N = mkN "castillo" | mkN "castro" ; -- status=guess
lin figure_VS = mkVS (mkV "ocurrírsele") ; -- status=guess
lin figure_V2V = mkV2V (mkV "ocurrírsele") ; -- status=guess
lin figure_V2 = mkV2 (mkV "ocurrírsele") ; -- status=guess
lin figure_V = mkV "ocurrírsele" ; -- status=guess
lin race_VV = mkVV (mkV "correr") ; -- status=guess
lin race_V2V = mkV2V (mkV "correr") ; -- status=guess
lin race_V2 = mkV2 (mkV "correr") ; -- status=guess
lin race_V = mkV "correr" ; -- status=guess
lin demonstration_N = mkN "demostración" feminine ; -- status=guess
lin anger_N = mkN "ira" | mkN "enfado" | mkN "enojo" | mkN "rabia" | mkN "bravura" ; -- status=guess
lin briefly_Adv = variants{} ; -- 
lin presumably_Adv = variants{} ; -- 
lin clock_N = mkN "reloj" masculine ; -- status=guess
lin hero_N = mkN "héroe" masculine ; -- status=guess
lin expose_V2 = mkV2 (exponer_V) ; -- status=guess
lin expose_V = exponer_V ; -- status=guess
lin custom_N = mkN "a medida" | mkN "a órden" | mkN "especializado" | mkN "único" | mkN "personalizado" | mkN "encargo" | mkN "al pedido" | mkN "con especificaciones" ; -- status=guess
lin maximum_A = mkA "máximo" ; -- status=guess
lin wish_N = mkN "deseo" ; -- status=guess
lin earning_N = variants{} ; -- 
lin priest_N = L.priest_N ;
lin resign_VV = mkVV (mkV "renunciar") | mkVV (mkV "dimitir") ; -- status=guess
lin resign_VS = mkVS (mkV "renunciar") | mkVS (mkV "dimitir") ; -- status=guess
lin resign_V2V = mkV2V (mkV "renunciar") | mkV2V (mkV "dimitir") ; -- status=guess
lin resign_V2 = mkV2 (mkV "renunciar") | mkV2 (mkV "dimitir") ; -- status=guess
lin resign_V = mkV "renunciar" | mkV "dimitir" ; -- status=guess
lin store_V2 = mkV2 (mkV "almacenar") ; -- status=guess
lin widespread_A = mkA "extenso" ; -- status=guess
lin comprise_V2 = variants{} ; -- 
lin chamber_N = mkN "cámara" masculine ; -- status=guess
lin acquisition_N = mkN "adquisición" feminine ; -- status=guess
lin involved_A = variants{} ; -- 
lin confident_A = variants{} ; -- 
lin circuit_N = mkN "disjuntor" ; -- status=guess
lin radical_A = variants{} ; -- 
lin detect_V2 = mkV2 (mkV "detectar") ; -- status=guess
lin stupid_A = L.stupid_A ;
lin grand_A = mkA "grande" ; -- status=guess
lin consumption_N = mkN "consumo" ; -- status=guess
lin hold_N = variants{} ; -- 
lin zone_N = mkN "zona" ; -- status=guess
lin mean_A = mkA "formidable" ; -- status=guess
lin altogether_Adv = mkAdv "en general" | mkAdv "en suma" ; -- status=guess
lin rush_VV = mkVV (mkV "correr") | mkVV (mkV "apurarse") ; -- status=guess
lin rush_V2V = mkV2V (mkV "correr") | mkV2V (mkV "apurarse") ; -- status=guess
lin rush_V2 = mkV2 (mkV "correr") | mkV2 (mkV "apurarse") ; -- status=guess
lin rush_V = mkV "correr" | mkV "apurarse" ; -- status=guess
lin numerous_A = mkA "numeroso" | mkA "numerosa" ; -- status=guess
lin sink_V2 = mkV2 (mkV "hundir") ; -- status=guess
lin sink_V = mkV "hundir" ; -- status=guess
lin everywhere_Adv = S.everywhere_Adv ;
lin classical_A = mkA "clásico" ; -- status=guess
lin respectively_Adv = variants{} ; -- 
lin distinct_A = mkA "distinto" ; -- status=guess
lin mad_A = mkA "enfadado" | mkA "enojado" ; -- status=guess
lin honour_N = mkN "crimen de honor" ; -- status=guess
lin statistics_N = mkN "estadística" ; -- status=guess
lin false_A = mkA "postizo" ; -- status=guess
lin square_N = mkN "casilla" ; -- status=guess
lin differ_V = variants{} ; -- 
lin disk_N = mkN "disco duro" ; -- status=guess
lin truly_Adv = variants{} ; -- 
lin survival_N = mkN "supervivencia" ; -- status=guess
lin proud_A = mkA "orgulloso" ; -- status=guess
lin tower_N = mkN "la casa de dios" ; -- status=guess
lin deposit_N = mkN "depósito" ; -- status=guess
lin pace_N = mkN "paso" | mkN "ritmo" ; -- status=guess
lin compensation_N = variants{} ; -- 
lin adviser_N = variants{} ; -- 
lin consultant_N = mkN "consultor" masculine ; -- status=guess
lin drag_V2 = mkV2 (mkV "arrastrar") ; -- status=guess
lin drag_V = mkV "arrastrar" ; -- status=guess
lin advanced_A = variants{} ; -- 
lin landlord_N = mkN "casero" | mkN "arrendatario" | mkN "terrateniente" masculine ; -- status=guess
lin whenever_Adv = mkAdv "cuando quiera" ; -- status=guess
lin delay_N = mkN "retraso" | mkN "demora" ; -- status=guess
lin green_N = mkN "picaflor" masculine | mkN "colibrí" ; -- status=guess
lin car_V = variants{} ; -- 
lin holder_N = variants{} ; -- 
lin secret_A = mkA "secreto" ; -- status=guess
lin edition_N = mkN "edición" feminine ; -- status=guess
lin occupation_N = mkN "ocupación" masculine ; -- status=guess
lin agricultural_A = mkA "agrícola" ; -- status=guess
lin intelligence_N = variants{} ; -- 
lin intelligence_2_N = variants{} ; -- 
lin intelligence_1_N = variants{} ; -- 
lin empire_N = mkN "imperio" ; -- status=guess
lin definitely_Adv = variants{} ; -- 
lin negotiate_VV = variants{} ; -- 
lin negotiate_V2 = variants{} ; -- 
lin negotiate_V = variants{} ; -- 
lin host_N = mkN "hospedante" | mkN "hospedador" masculine | mkN "huésped" masculine ; -- status=guess
lin relative_N = mkN "pariente" masculine ; -- status=guess
lin mass_A = variants{} ; -- 
lin helpful_A = mkA "servicial" | mkA "útil" ; -- status=guess
lin fellow_N = variants{} ; -- 
lin sweep_V2 = mkV2 (mkV (mkV "tratar") "de tapar algo ilícito") ; -- status=guess
lin sweep_V = mkV (mkV "tratar") "de tapar algo ilícito" ; -- status=guess
lin poet_N = mkN "poeta" masculine | mkN "poetisa" ; -- status=guess
lin journalist_N = mkN "periodista" masculine ; -- status=guess
lin defeat_N = mkN "vencimiento" | mkN "derrota" ; -- status=guess
lin unlike_Prep = variants{} ; -- 
lin primarily_Adv = variants{} ; -- 
lin tight_A = variants{} ; -- 
lin indication_N = variants{} ; -- 
lin dry_V2 = mkV2 (mkV "secarse") ; -- status=guess
lin dry_V = mkV "secarse" ; -- status=guess
lin cricket_N = mkN "críquet" masculine | mkN "cricket" masculine ; -- status=guess
lin whisper_V2 = mkV2 (mkV "susurrar") ; -- status=guess
lin whisper_V = mkV "susurrar" ; -- status=guess
lin routine_N = variants{} ; -- 
lin print_N = variants{} ; -- 
lin anxiety_N = mkN "zozobra" | mkN "ansiedad" feminine ; -- status=guess
lin witness_N = mkN "testimonio" ; -- status=guess
lin concerning_Prep = variants{} ; -- 
lin mill_N = mkN "fábrica" ; -- status=guess
lin gentle_A = mkA "tranquilo" ; -- status=guess
lin curtain_N = mkN "cortina" ; -- status=guess
lin mission_N = mkN "misión" feminine ; -- status=guess
lin supplier_N = mkN "proveedor" | mkN "proveedora" ; -- status=guess
lin basically_Adv = mkAdv "básicamente" ; -- status=guess
lin assure_V2S = mkV2S (mkV "asegurar") ; -- status=guess
lin assure_V2 = mkV2 (mkV "asegurar") ; -- status=guess
lin poverty_N = mkN "pobreza" ; -- status=guess
lin snow_N = L.snow_N ;
lin prayer_N = mkN "rosario" ; -- status=guess
lin pipe_N = mkN "tubería" | mkN "tubería informática" ; -- status=guess
lin deserve_VV = mkVV (merecer_V) ; -- status=guess
lin deserve_V2 = mkV2 (merecer_V) ; -- status=guess
lin deserve_V = merecer_V ; -- status=guess
lin shift_N = mkN "cambio" | mkN "desviación" feminine | mkN "deslizamiento" | mkN "desplazamiento" ; -- status=guess
lin split_V2 = L.split_V2 ;
lin split_V = mkV "partir" | mkV "dividir" | mkV "escindir" ; -- status=guess
lin near_Adv = mkAdv "cerca" ; -- status=guess
lin consistent_A = mkA "consistente" ; -- status=guess
lin carpet_N = L.carpet_N ;
lin ownership_N = mkN "posesión" feminine | mkN "propiedad" masculine ; -- status=guess
lin joke_N = mkN "broma" | mkN "chiste" masculine ; -- status=guess
lin fewer_Det = variants{} ; -- 
lin workshop_N = mkN "taller" masculine ; -- status=guess
lin salt_N = L.salt_N ;
lin aged_Prep = variants{} ; -- 
lin symbol_N = mkN "símbolo" ; -- status=guess
lin slide_V2 = mkV2 (mkV "deslizar") ; -- status=guess
lin slide_V = mkV "deslizar" ; -- status=guess
lin cross_N = mkN "cruce" masculine ; -- status=guess
lin anxious_A = mkA "ansioso" | mkA "deseoso" ; -- status=guess
lin tale_N = mkN "cuento" | mkN "historia" ; -- status=guess
lin preference_N = mkN "preferencia" ; -- status=guess
lin inevitably_Adv = variants{} ; -- 
lin mere_A = mkA "mero" ; -- status=guess
lin behave_V = mkV "comportarse" ; -- status=guess
lin gain_N = mkN "ganancia" ; -- status=guess
lin nervous_A = mkA "nervioso" ; -- status=guess
lin guide_V2 = mkV2 (mkV "guiar") ; -- status=guess
lin remark_N = mkN "observación" feminine ; -- status=guess
lin pleased_A = variants{} ; -- 
lin province_N = mkN "provincia" ; -- status=guess
lin steel_N = L.steel_N ;
lin practise_V2 = variants{} ; -- 
lin practise_V = variants{} ; -- 
lin flow_V = L.flow_V ;
lin holy_A = mkA "santo" | mkA "sagrado" ; -- status=guess
lin dose_N = mkN "dosis" feminine ; -- status=guess
lin alcohol_N = mkN "alcohol" masculine ; -- status=guess
lin guidance_N = variants{} ; -- 
lin constantly_Adv = variants{} ; -- 
lin climate_N = mkN "clima" masculine ; -- status=guess
lin enhance_V2 = mkV2 (mkV "aumentar") ; -- status=guess
lin reasonably_Adv = variants{} ; -- 
lin waste_V2 = mkV2 (mkV "malgastar") | mkV2 (mkV "desperdiciar") ; -- status=guess
lin waste_V = mkV "malgastar" | mkV "desperdiciar" ; -- status=guess
lin smooth_A = L.smooth_A ;
lin dominant_A = variants{} ; -- 
lin conscious_A = mkA "consciente" ; -- status=guess
lin formula_N = mkN "fórmula" ; -- status=guess
lin tail_N = L.tail_N ;
lin ha_Interj = variants{} ; -- 
lin electric_A = mkA "eléctrico" ; -- status=guess
lin sheep_N = L.sheep_N ;
lin medicine_N = mkN "balón de medicina" | mkN "balón de gimnacia" ; -- status=guess
lin strategic_A = mkA "estratégico" ; -- status=guess
lin disabled_A = variants{} ; -- 
lin smell_N = mkN "olor" masculine ; -- status=guess
lin operator_N = variants{} ; -- 
lin mount_VS = mkVS (mkV "montar") | mkVS (mkV "configurar") | mkVS (mkV "instalar") ; -- status=guess
lin mount_V2 = mkV2 (mkV "montar") | mkV2 (mkV "configurar") | mkV2 (mkV "instalar") ; -- status=guess
lin mount_V = mkV "montar" | mkV "configurar" | mkV "instalar" ; -- status=guess
lin advance_V2 = variants{} ; -- 
lin advance_V = variants{} ; -- 
lin remote_A = mkA "remoto" ; -- status=guess
lin measurement_N = mkN "medida" | mkN "medición" feminine | mkN "medidas" feminine | mkN "mediciones" masculine ; -- status=guess
lin favour_VS = variants{} ; -- 
lin favour_V2 = variants{} ; -- 
lin favour_V = variants{} ; -- 
lin neither_Det = variants{} ; -- 
lin architecture_N = mkN "arquitectura" ; -- status=guess
lin worth_N = mkN "valor" masculine ; -- status=guess
lin tie_N = mkN "lazo" | mkN "vínculo" ; -- status=guess
lin barrier_N = mkN "límite" masculine ; -- status=guess
lin practitioner_N = variants{} ; -- 
lin outstanding_A = mkA "destacado" | mkA "excepcional" | mkA "distinguido" ; -- status=guess
lin enthusiasm_N = mkN "entusiasmo" ; -- status=guess
lin theoretical_A = mkA "teórico" ; -- status=guess
lin implementation_N = mkN "puesta en práctica" ; -- status=guess
lin worried_A = variants{} ; -- 
lin pitch_N = mkN "pez" feminine ; -- status=guess
lin drop_N = mkN "gota" ; -- status=guess
lin phone_V2 = mkV2 (mkV "telefonear") | mkV2 (mkV (mkV "llamar") "por teléfono") ; -- status=guess
lin phone_V = mkV "telefonear" | mkV (mkV "llamar") "por teléfono" ; -- status=guess
lin shape_VV = variants{} ; -- 
lin shape_V2 = variants{} ; -- 
lin shape_V = variants{} ; -- 
lin clinical_A = mkA "clínico" ; -- status=guess
lin lane_N = mkN "carrera" ; -- status=guess
lin apple_N = L.apple_N ;
lin catalogue_N = mkN "catálogo" ; -- status=guess
lin tip_N = mkN "propina" ; -- status=guess
lin publisher_N = mkN "editor" ; -- status=guess
lin opponent_N = variants{} ; -- 
lin live_A = mkA "vivo" ; -- status=guess
lin burden_N = mkN "preocupación" feminine ; -- status=guess
lin tackle_V2 = mkV2 (mkV "taclear") ; -- status=guess
lin tackle_V = mkV "taclear" ; -- status=guess
lin historian_N = mkN "historiador" | mkN "historiadora" ; -- status=guess
lin bury_V2 = mkV2 (enterrar_V) ; -- status=guess
lin bury_V = enterrar_V ; -- status=guess
lin stomach_N = mkN "barriga" masculine | mkN "vientre" masculine ; -- status=guess
lin percentage_N = mkN "porcentaje" masculine ; -- status=guess
lin evaluation_N = mkN "evaluación" feminine ; -- status=guess
lin outline_V2 = variants{} ; -- 
lin talent_N = mkN "talento" ; -- status=guess
lin lend_V2 = mkV2 (mkV "prestar") ; -- status=guess
lin lend_V = mkV "prestar" ; -- status=guess
lin silver_N = L.silver_N ;
lin pack_N = mkN "jauría" ; -- status=guess
lin fun_N = mkN "diversión" feminine ; -- status=guess
lin democrat_N = mkN "demócrata" masculine ; -- status=guess
lin fortune_N = mkN "fortuna" ; -- status=guess
lin storage_N = mkN "almacén" masculine | mkN "depósito" | mkN "bodega" ; -- status=guess
lin professional_N = mkN "profesional" masculine | mkN "profesionista " ; -- status=guess
lin reserve_N = mkN "reserva" ; -- status=guess
lin interval_N = variants{} ; -- 
lin dimension_N = mkN "dimensión" feminine ; -- status=guess
lin honest_A = mkA "honesto" | mkA "sincero" ; -- status=guess
lin awful_A = mkA "horrible" | mkA "terrible" | mkA "atroz" ; -- status=guess
lin manufacture_V2 = mkV2 (mkV "fabricar") ; -- status=guess
lin confusion_N = mkN "confusión" ; -- status=guess
lin pink_A = variants{} ; -- 
lin impressive_A = mkA "halagüeño" ; -- status=guess
lin satisfaction_N = mkN "satisfacción" feminine ; -- status=guess
lin visible_A = mkA "visible" ; -- status=guess
lin vessel_N = mkN "recipiente" masculine | mkN "receptáculo" | mkN "vaso" | mkN "vasija" | mkN "recinto" ; -- status=guess
lin stand_N = mkN "postura" ; -- status=guess
lin curve_N = mkN "curva" ; -- status=guess
lin pot_N = mkN "marihuana" ; -- status=guess
lin replacement_N = mkN "substituto" | mkN "sustituto" ; -- status=guess
lin accurate_A = mkA "preciso" | mkA "exacto" | mkA "justo" | mkA "correcto" ; -- status=guess
lin mortgage_N = mkN "hipoteca" ; -- status=guess
lin salary_N = mkN "salario" | mkN "sueldo" ; -- status=guess
lin impress_V2 = mkV2 (mkV "impresionar") ; -- status=guess
lin impress_V = mkV "impresionarse" ; -- status=guess
lin constitutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (mkV "subrayar") | mkVS (mkV "enfatizar") ; -- status=guess
lin emphasize_V2 = mkV2 (mkV "subrayar") | mkV2 (mkV "enfatizar") ; -- status=guess
lin developing_A = variants{} ; -- 
lin proof_N = mkN "prueba" ; -- status=guess
lin furthermore_Adv = mkAdv "más" | mkAdv "es más" | mkAdv "además" ; -- status=guess
lin dish_N = mkN "plato" ; -- status=guess
lin interview_V2 = mkV2 (mkV "entrevistar") ; -- status=guess
lin considerably_Adv = variants{} ; -- 
lin distant_A = mkA "distante" ; -- status=guess
lin lower_V2 = mkV2 (mkV "bajar") ; -- status=guess
lin lower_V = mkV "bajar" ; -- status=guess
lin favourite_N = variants{} ; -- 
lin tear_V2 = mkV2 (mkV "desgarrarse") ; -- status=guess
lin tear_V = mkV "desgarrarse" ; -- status=guess
lin fixed_A = variants{} ; -- 
lin by_Adv = mkAdv "por" ; -- status=guess
lin luck_N = mkN "suerte" feminine ; -- status=guess
lin count_N = mkN "punto" | mkN "cargo" ; -- status=guess
lin precise_A = mkA "preciso" ; -- status=guess
lin determination_N = mkN "ahínco" ; -- status=guess
lin bite_V2 = L.bite_V2 ;
lin bite_V = mkV (mkV "abarcar") "más de lo que se puede" ; -- status=guess
lin dear_Interj = variants{} ; -- 
lin consultation_N = mkN "consulta" ; -- status=guess
lin range_V2 = variants{} ; -- 
lin range_V = variants{} ; -- 
lin residential_A = variants{} ; -- 
lin conduct_N = mkN "conducción" feminine ; -- status=guess
lin capture_V2 = mkV2 (mkV "capturar") ; -- status=guess
lin ultimately_Adv = variants{} ; -- 
lin cheque_N = mkN "cheque" | mkN "talón" masculine ; -- status=guess
lin economics_N = mkN "economía" ; -- status=guess
lin sustain_V2 = mkV2 (sostener_V) ; -- status=guess
lin secondly_Adv = variants{} ; -- 
lin silly_A = mkA "niñito" ; -- status=guess
lin merchant_N = mkN "comerciante" masculine | mkN "mercader" feminine ; -- status=guess
lin lecture_N = mkN "conferencia" ; -- status=guess
lin musical_A = mkA "musical" ; -- status=guess
lin leisure_N = mkN "ocio" ; -- status=guess
lin check_N = mkN "cuenta" ; -- status=guess
lin cheese_N = L.cheese_N ;
lin lift_N = mkN "ascensor" ; -- status=guess
lin participate_V2 = mkV2 (mkV "participar") ; -- status=guess
lin participate_V = mkV "participar" ; -- status=guess
lin fabric_N = mkN "tela" | mkN "tejido" | mkN "género" ; -- status=guess
lin distribute_V2 = mkV2 (distribuir_V) ; -- status=guess
lin lover_N = mkN "amante" masculine | mkN "enamorado" | mkN "enamorada" ; -- status=guess
lin childhood_N = mkN "infancia" ; -- status=guess
lin cool_A = mkA "frío" ; -- status=guess
lin ban_V2 = mkV2 (prohibir_V) ; -- status=guess
lin supposed_A = mkA "supuesto" ; -- status=guess
lin mouse_N = mkN "batará murino" ; -- status=guess
lin strain_N = mkN "trazas" feminine ; -- status=guess
lin specialist_A = variants{} ; -- 
lin consult_V2 = mkV2 (mkV "consultar") ; -- status=guess
lin consult_V = mkV "consultar" ; -- status=guess
lin minimum_A = variants{} ; -- 
lin approximately_Adv = variants{} ; -- 
lin participant_N = mkN "participante" masculine ; -- status=guess
lin monetary_A = mkA "monetario" ; -- status=guess
lin confuse_V2 = mkV2 (mkV "confundir") ; -- status=guess
lin dare_VV = mkVV (mkV "afrontar") | mkVV (mkV "enfrentar") ; -- status=guess
lin dare_V2 = mkV2 (mkV "afrontar") | mkV2 (mkV "enfrentar") ; -- status=guess
lin dare_V = mkV "afrontar" | mkV "enfrentar" ; -- status=guess
lin smoke_N = L.smoke_N ;
lin movie_N = mkN "película" | mkN "cine" masculine ; -- status=guess
lin seed_N = L.seed_N ;
lin cease_V2V = mkV2V (mkV (mkV "cese") "y renuncia") ; -- status=guess
lin cease_V2 = mkV2 (mkV (mkV "cese") "y renuncia") ; -- status=guess
lin cease_V = mkV (mkV "cese") "y renuncia" ; -- status=guess
lin open_Adv = variants{} ; -- 
lin journal_N = mkN "bitácora" ; -- status=guess
lin shopping_N = mkN "cesta de la compra" ; -- status=guess
lin equivalent_N = mkN "equivalente" masculine ; -- status=guess
lin palace_N = mkN "palacio" ; -- status=guess
lin exceed_V2 = mkV2 (mkV "exceder") ; -- status=guess
lin isolated_A = variants{} ; -- 
lin poetry_N = mkN "poesía" ; -- status=guess
lin perceive_VS = mkVS (mkV "percibir") | mkVS (entender_V) ; -- status=guess
lin perceive_V2V = mkV2V (mkV "percibir") | mkV2V (entender_V) ; -- status=guess
lin perceive_V2 = mkV2 (mkV "percibir") | mkV2 (entender_V) ; -- status=guess
lin lack_V2 = mkV2 (mkV "faltar") | mkV2 (carecer_V) ; -- status=guess
lin lack_V = mkV "faltar" | carecer_V ; -- status=guess
lin strengthen_V2 = mkV2 (mkV "animar") ; -- status=guess
lin strengthen_V = mkV "animar" ; -- status=guess
lin snap_VS = mkVS (mkV "chasquear") ; -- status=guess
lin snap_V2 = mkV2 (mkV "chasquear") ; -- status=guess
lin snap_V = mkV "chasquear" ; -- status=guess
lin readily_Adv = variants{} ; -- 
lin spite_N = mkN "despecho" | mkN "rencor" masculine | mkN "malicia" ; -- status=guess
lin conviction_N = variants{} ; -- 
lin corridor_N = mkN "pasillo" | mkN "corredor" masculine ; -- status=guess
lin behind_Adv = variants{}; -- S.behind_Prep ;
lin ward_N = mkN "guardia" masculine ; -- status=guess
lin profile_N = mkN "perfil" masculine ; -- status=guess
lin fat_A = mkA "gordo" ; -- status=guess
lin comfort_N = mkN "consuelo" ; -- status=guess
lin bathroom_N = mkN "cuarto de baño" | mkN "baño" feminine | mkN "servicio" ; -- status=guess
lin shell_N = mkN "crustáceo" | mkN "marisco" ; -- status=guess
lin reward_N = mkN "recompensa" ; -- status=guess
lin deliberately_Adv = variants{} ; -- 
lin automatically_Adv = mkAdv "automáticamente" ; -- status=guess
lin vegetable_N = mkN "vegetal" masculine ; -- status=guess
lin imagination_N = mkN "imaginación" feminine ; -- status=guess
lin junior_A = variants{} ; -- 
lin unemployed_A = mkA "desempleado" | mkA "cesante" ; -- status=guess
lin mystery_N = mkN "misterio" ; -- status=guess
lin pose_V2 = mkV2 (mkV "posar") ; -- status=guess
lin pose_V = mkV "posar" ; -- status=guess
lin violent_A = mkA "violento" ; -- status=guess
lin march_N = mkN "marcha" ; -- status=guess
lin found_V2 = mkV2 (mkV "fundar") ; -- status=guess
lin dig_V2 = mkV2 (mkV "adentrarse") ; -- status=guess
lin dig_V = L.dig_V ;
lin dirty_A = L.dirty_A ;
lin straight_A = L.straight_A ;
lin psychological_A = mkA "psicológico" ; -- status=guess
lin grab_V2 = mkV2 (mkV "agarrar") ; -- status=guess
lin grab_V = mkV "agarrar" ; -- status=guess
lin pleasant_A = mkA "agradable" | mkA "placentero" ; -- status=guess
lin surgery_N = mkN "cirugía" ; -- status=guess
lin inevitable_A = mkA "inevitable" ; -- status=guess
lin transform_V2 = mkV2 (mkV "trasformar") ; -- status=guess
lin bell_N = mkN "campana" | mkN "campanilla" ; -- status=guess
lin announcement_N = mkN "anuncio" ; -- status=guess
lin draft_N = mkN "reclutamiento" | mkN "leva" | mkN "conscripción" masculine ; -- status=guess
lin unity_N = mkN "unidad" feminine ; -- status=guess
lin airport_N = mkN "aeropuerto" ; -- status=guess
lin upset_V2 = variants{} ; -- 
lin upset_V = variants{} ; -- 
lin pretend_VS = mkVS (fingir_V) ; -- status=guess
lin pretend_V2 = mkV2 (fingir_V) ; -- status=guess
lin pretend_V = fingir_V ; -- status=guess
lin plant_V2 = mkV2 (mkV "plantar") | mkV2 (sembrar_V) ; -- status=guess
lin till_Prep = variants{} ; -- 
lin known_A = variants{} ; -- 
lin admission_N = mkN "admisión" ; -- status=guess
lin tissue_N = mkN "tejido" ; -- status=guess
lin magistrate_N = mkN "magistrado" ; -- status=guess
lin joy_N = mkN "alegría" | mkN "gozo" | mkN "felicidad" feminine | mkN "júbilo" | mkN "regocijo" ; -- status=guess
lin free_V2V = mkV2V (mkV "librar") ; -- status=guess
lin free_V2 = mkV2 (mkV "librar") ; -- status=guess
lin pretty_A = mkA "ingenioso" | mkA "listo" ; -- status=guess
lin operating_N = variants{} ; -- 
lin headquarters_N = variants{} ; -- 
lin grateful_A = mkA "complacido" ; -- status=guess
lin classroom_N = mkN "aula" ; -- status=guess
lin turnover_N = mkN "movimiento de mercancías" | mkN "rotación" masculine ; -- status=guess
lin project_VS = mkVS (mkV "proyectar") ; -- status=guess
lin project_V2V = mkV2V (mkV "proyectar") ; -- status=guess
lin project_V2 = mkV2 (mkV "proyectar") ; -- status=guess
lin project_V = mkV "proyectar" ; -- status=guess
lin shrug_VS = mkVS (mkV (mkV "encogerse") "de hombros") ; -- status=guess
lin shrug_V2 = mkV2 (mkV (mkV "encogerse") "de hombros") ; -- status=guess
lin sensible_A = mkA "razonable" | mkA "sensato" ; -- status=guess
lin limitation_N = variants{} ; -- 
lin specialist_N = mkN "especialista" masculine ; -- status=guess
lin newly_Adv = variants{} ; -- 
lin tongue_N = L.tongue_N ;
lin refugee_N = mkN "refugiado" ; -- status=guess
lin delay_V2 = mkV2 (mkV "retrasar") | mkV2 (mkV "demorar") ; -- status=guess
lin delay_V = mkV "retrasar" | mkV "demorar" ; -- status=guess
lin dream_V2 = mkV2 (soñar_V) ; -- status=guess
lin dream_V = soñar_V ; -- status=guess
lin composition_N = mkN "redacción" feminine ; -- status=guess
lin alongside_Prep = variants{} ; -- 
lin ceiling_N = L.ceiling_N ;
lin highlight_V2 = mkV2 (mkV "marcar") ; -- status=guess
lin stick_N = L.stick_N ;
lin favourite_A = variants{} ; -- 
lin tap_V2 = mkV2 (intervenir_V) ; -- status=guess
lin tap_V = intervenir_V ; -- status=guess
lin universe_N = mkN "universo" ; -- status=guess
lin request_VS = mkVS (pedir_V) ; -- status=guess
lin request_V2 = mkV2 (pedir_V) ; -- status=guess
lin label_N = mkN "etiqueta" | mkN "rótulo" ; -- status=guess
lin confine_V2 = mkV2 (mkV "confinar") ; -- status=guess
lin scream_VS = mkVS (mkV "gritar") ; -- status=guess
lin scream_V2 = mkV2 (mkV "gritar") ; -- status=guess
lin scream_V = mkV "gritar" ; -- status=guess
lin rid_V2 = mkV2 (mkV "liberar") ; -- status=guess
lin rid_V = mkV "liberar" ; -- status=guess
lin acceptance_N = mkN "aceptación" | mkN "aprobación" feminine ; -- status=guess
lin detective_N = mkN "detective" masculine ; -- status=guess
lin sail_V2 = mkV2 (mkV "navegar") ; -- status=guess
lin sail_V = mkV "navegar" ; -- status=guess
lin adjust_V2V = mkV2V (mkV "adaptar") ; -- status=guess
lin adjust_V2 = mkV2 (mkV "adaptar") ; -- status=guess
lin adjust_V = mkV "adaptar" ; -- status=guess
lin designer_N = mkN "diseñador" | mkN "diseñadora" ; -- status=guess
lin running_A = variants{} ; -- 
lin summit_N = mkN "cumbre" feminine ; -- status=guess
lin participation_N = mkN "participación" feminine ; -- status=guess
lin weakness_N = mkN "debilidad" feminine ; -- status=guess
lin block_V2 = mkV2 (mkV "bloquear") | mkV2 (impedir_V) | mkV2 (obstruir_V) | mkV2 (atorar_V) ; -- status=guess
lin socalled_A = variants{} ; -- 
lin adapt_V2 = mkV2 (mkV "adaptar") | mkV2 (mkV "ajustar") ; -- status=guess
lin adapt_V = mkV "adaptar" | mkV "ajustar" ; -- status=guess
lin absorb_V2 = mkV2 (mkV "absorber") ; -- status=guess
lin encounter_V2 = variants{} ; -- 
lin defeat_V2 = mkV2 (mkV "arruinar") ; -- status=guess
lin excitement_N = mkN "entusiasmo" ; -- status=guess
lin brick_N = mkN "ladrillo" ; -- status=guess
lin blind_A = mkA "ciego" ; -- status=guess
lin wire_N = mkN "alambre" | mkN "hilo" ; -- status=guess
lin crop_N = mkN "fusta" ; -- status=guess
lin square_A = mkA "perpendicular" ; -- status=guess
lin transition_N = mkN "transición" feminine ; -- status=guess
lin thereby_Adv = variants{} ; -- 
lin protest_V2 = mkV2 (mkV "protestar") ; -- status=guess
lin protest_V = mkV "protestar" ; -- status=guess
lin roll_N = mkN "rollo" ; -- status=guess
lin stop_N = mkN "parada" | mkN "paradero" ; -- status=guess
lin assistant_N = mkN "ayudante" masculine | mkN "asistente" masculine ; -- status=guess
lin deaf_A = mkA "sordo" ; -- status=guess
lin constituency_N = variants{} ; -- 
lin continuous_A = mkA "continuo" ; -- status=guess
lin concert_N = mkN "concierto" ; -- status=guess
lin breast_N = L.breast_N ;
lin extraordinary_A = mkA "extraordinario" ; -- status=guess
lin squad_N = mkN "escuadra" | mkN "cuadrilla" | mkN "escuadrón" masculine ; -- status=guess
lin wonder_N = mkN "pensamiento" ; -- status=guess
lin cream_N = mkN "crema" ; -- status=guess
lin tennis_N = mkN "tenis" feminine ; -- status=guess
lin personally_Adv = variants{} ; -- 
lin communicate_V2 = mkV2 (mkV "comunicar") ; -- status=guess
lin communicate_V = mkV "comunicar" ; -- status=guess
lin pride_N = mkN "manada" ; -- status=guess
lin bowl_N = mkN "tazón" | mkN "cuenco" ; -- status=guess
lin file_V2 = mkV2 (mkV "limar") ; -- status=guess
lin file_V = mkV "limar" ; -- status=guess
lin expertise_N = mkN "pericia" ; -- status=guess
lin govern_V2 = mkV2 (gobernar_V) ; -- status=guess
lin govern_V = gobernar_V ; -- status=guess
lin leather_N = L.leather_N ;
lin observer_N = mkN "observador" masculine ; -- status=guess
lin margin_N = mkN "margen" masculine ; -- status=guess
lin uncertainty_N = mkN "incertidumbre" feminine ; -- status=guess
lin reinforce_V2 = mkV2 (reforzar_V) ; -- status=guess
lin ideal_N = mkN "ideal" masculine ; -- status=guess
lin injure_V2 = mkV2 (herir_V) ; -- status=guess
lin holding_N = variants{} ; -- 
lin universal_A = mkA "universal" ; -- status=guess
lin evident_A = mkA "evidente" ; -- status=guess
lin dust_N = L.dust_N ;
lin overseas_A = mkA "ultramar" ; -- status=guess
lin desperate_A = mkA "desesperado" ; -- status=guess
lin swim_V2 = mkV2 (mkV "nadar") ; -- status=guess
lin swim_V = L.swim_V ;
lin occasional_A = mkA "ocasional" ; -- status=guess
lin trouser_N = variants{} ; -- 
lin surprisingly_Adv = variants{} ; -- 
lin register_N = variants{} ; -- 
lin album_N = mkN "álbum" masculine ; -- status=guess
lin guideline_N = mkN "directriz" | mkN "pauta" ; -- status=guess
lin disturb_V2 = mkV2 (mkV "perturbar") | mkV2 (mkV "molestar") ; -- status=guess
lin amendment_N = mkN "enmienda" ; -- status=guess
lin architect_N = variants{} ; -- 
lin objection_N = mkN "protesta" ; -- status=guess
lin chart_N = variants{} ; -- 
lin cattle_N = mkN "ganado" ; -- status=guess
lin doubt_VS = mkVS (mkV "dudar") ; -- status=guess
lin doubt_V2 = mkV2 (mkV "dudar") ; -- status=guess
lin react_V = mkV "reaccionar" ; -- status=guess
lin consciousness_N = mkN "conciencia" ; -- status=guess
lin right_Interj = variants{} ; -- 
lin purely_Adv = variants{} ; -- 
lin tin_N = mkN "lata" ; -- status=guess
lin tube_N = mkN "tubo" | mkN "canuto" ; -- status=guess
lin fulfil_V2 = mkV2 (satisfacer_V) | mkV2 (mkV "cumplir") ; -- status=guess
lin commonly_Adv = variants{} ; -- 
lin sufficiently_Adv = variants{} ; -- 
lin coin_N = mkN "moneda" ; -- status=guess
lin frighten_V2 = mkV2 (mkV "atemorizar") ; -- status=guess
lin grammar_N = L.grammar_N ;
lin diary_N = mkN "diario" ; -- status=guess
lin flesh_N = mkN "carne" feminine ; -- status=guess
lin summary_N = mkN "resumen" masculine | mkN "sumario" ; -- status=guess
lin infant_N = mkN "nene" masculine | mkN "infante" masculine ; -- status=guess
lin stir_V2 = mkV2 (sofreír_V) ; -- status=guess
lin stir_V = sofreír_V ; -- status=guess
lin storm_N = mkN "sótano para tormentas" ; -- status=guess
lin mail_N = mkN "correo electrónico" | mkN "mail" masculine ; -- status=guess
lin rugby_N = variants{} ; -- 
lin virtue_N = mkN "virtud" feminine ; -- status=guess
lin specimen_N = mkN "espécimen" masculine ; -- status=guess
lin psychology_N = mkN "psicología" ; -- status=guess
lin paint_N = mkN "pintura" ; -- status=guess
lin constraint_N = mkN "restricción" feminine ; -- status=guess
lin trace_V2 = mkV2 (mkV "calcar") ; -- status=guess
lin trace_V = mkV "calcar" ; -- status=guess
lin privilege_N = mkN "privilegio" ; -- status=guess
lin completion_N = mkN "conclusión" feminine ; -- status=guess
lin progress_V2 = mkV2 (mkV "progresar") ; -- status=guess
lin progress_V = mkV "progresar" ; -- status=guess
lin grade_N = mkN "nivel" masculine ; -- status=guess
lin exploit_V2 = mkV2 (mkV "explotar") | mkV2 (mkV "aprovechar") ; -- status=guess
lin import_N = mkN "importación" feminine ; -- status=guess
lin potato_N = mkN "patata" ; -- status=guess
lin repair_N = mkN "reparación" feminine ; -- status=guess
lin passion_N = mkN "pasión" feminine ; -- status=guess
lin seize_V2 = mkV2 (mkV "agarrar") | mkV2 (mkV (mkV "apoderarse") "de") | mkV2 (mkV "apresar") | mkV2 (aferrar_V) ; -- status=guess
lin seize_V = mkV "agarrar" | mkV (mkV "apoderarse") "de" | mkV "apresar" | aferrar_V ; -- status=guess
lin low_Adv = mkAdv "bajo" ; -- status=guess
lin underlying_A = variants{} ; -- 
lin heaven_N = mkN "cielo" | mkN "paraíso" ; -- status=guess
lin nerve_N = mkN "nervio" ; -- status=guess
lin park_V2 = mkV2 (mkV "estacionar") | mkV2 (mkV "aparcar") ; -- status=guess
lin park_V = mkV "estacionar" | mkV "aparcar" ; -- status=guess
lin collapse_V2 = mkV2 (mkV "derrumbarse") | mkV2 (mkV "desplomarse") ; -- status=guess
lin collapse_V = mkV "derrumbarse" | mkV "desplomarse" ; -- status=guess
lin win_N = variants{} ; -- 
lin printer_N = mkN "impresora" ; -- status=guess
lin coalition_N = mkN "coalición" feminine ; -- status=guess
lin button_N = mkN "botón" masculine | mkN "prendedor" masculine ; -- status=guess
lin pray_V2 = mkV2 (rogar_V) ; -- status=guess
lin pray_V = rogar_V ; -- status=guess
lin ultimate_A = mkA "máximo" | mkA "extremo" | mkA "mayor" ; -- status=guess
lin venture_N = mkN "aventura" ; -- status=guess
lin timber_N = mkN "viga" | mkN "polín" masculine ; -- status=guess
lin companion_N = mkN "compañero" | mkN "compañera" ; -- status=guess
lin horror_N = variants{} ; -- 
lin gesture_N = mkN "gesto" ; -- status=guess
lin moon_N = L.moon_N ;
lin remark_VS = variants{} ; -- 
lin remark_V2 = variants{} ; -- 
lin remark_V = variants{} ; -- 
lin clever_A = L.clever_A ;
lin van_N = variants{} ; -- 
lin consequently_Adv = variants{} ; -- 
lin raw_A = mkA "crudo" ; -- status=guess
lin glance_N = mkN "vistazo" ; -- status=guess
lin broken_A = variants{} ; -- 
lin jury_N = mkN "jurado" ; -- status=guess
lin gaze_V = mkV "observar" | mkV (mkV "mirar") "fijamente" ; -- status=guess
lin burst_V2 = mkV2 (mkV (mkV "reirse") "a carcajadas") ; -- status=guess
lin burst_V = mkV (mkV "reirse") "a carcajadas" ; -- status=guess
lin charter_N = mkN "carta fundacional" ; -- status=guess
lin feminist_N = variants{} ; -- 
lin discourse_N = mkN "discurso" ; -- status=guess
lin reflection_N = mkN "reflexión" feminine ; -- status=guess
lin carbon_N = mkN "negro de carbón" ; -- status=guess
lin sophisticated_A = mkA "refinado" | mkA "elegante" | mkA "sofisticado" ; -- status=guess
lin ban_N = mkN "prohibición" feminine ; -- status=guess
lin taxation_N = mkN "tasación" feminine ; -- status=guess
lin prosecution_N = variants{} ; -- 
lin softly_Adv = variants{} ; -- 
lin asleep_A = mkA "dormido" ; -- status=guess
lin aids_N = variants{} ; -- 
lin publicity_N = mkN "publicidad" feminine ; -- status=guess
lin departure_N = mkN "salida" masculine | mkN "despedida" ; -- status=guess
lin welcome_A = mkA "bienvenido" | mkA "agradable" ; -- status=guess
lin sharply_Adv = variants{} ; -- 
lin reception_N = mkN "recepción" feminine ; -- status=guess
lin cousin_N = L.cousin_N ;
lin relieve_V2 = mkV2 (mkV "aliviar") ; -- status=guess
lin linguistic_A = mkA "lingüístico" ; -- status=guess
lin vat_N = mkN "cuba" | mkN "tina" ; -- status=guess
lin forward_A = variants{} ; -- 
lin blue_N = mkN "azul" feminine ; -- status=guess
lin multiple_A = mkA "multiple" ; -- status=guess
lin pass_N = variants{} ; -- 
lin outer_A = variants{} ; -- 
lin vulnerable_A = mkA "vulnerable" ; -- status=guess
lin patient_A = mkA "paciente" ; -- status=guess
lin evolution_N = mkN "evolución" feminine ; -- status=guess
lin allocate_V2 = mkV2 (mkV "asignar") | mkV2 (mkV "adjudicar") ; -- status=guess
lin allocate_V = mkV "asignar" | mkV "adjudicar" ; -- status=guess
lin creative_A = mkA "creativo" ; -- status=guess
lin potentially_Adv = variants{} ; -- 
lin just_A = mkA "casi" | mkA "por poco" ; -- status=guess
lin out_Prep = variants{} ; -- 
lin judicial_A = mkA "judicial" ; -- status=guess
lin risk_VV = mkVV (mkV "arriesgar") ; -- status=guess
lin risk_V2 = mkV2 (mkV "arriesgar") ; -- status=guess
lin ideology_N = mkN "ideología" ; -- status=guess
lin smell_VA = mkVA (mkV (mkV "oler") "a gato encerrado") ; -- status=guess
lin smell_V2 = mkV2 (mkV (mkV "oler") "a gato encerrado") ; -- status=guess
lin smell_V = L.smell_V ;
lin agenda_N = mkN "agenda" | mkN "orden del dia" ; -- status=guess
lin transport_V2 = mkV2 (mkV "transportar") ; -- status=guess
lin illegal_A = mkA "ilegal" ; -- status=guess
lin chicken_N = mkN "pollo" | mkN "gallina" masculine ; -- status=guess
lin plain_A = mkA "con caracteres normales" | mkA "libre de caracteres especiales" | mkA "sin caracteres especiales" ; -- status=guess
lin innovation_N = mkN "innovación" feminine ; -- status=guess
lin opera_N = mkN "ópera" ; -- status=guess
lin lock_N = mkN "llave" feminine ; -- status=guess
lin grin_V2 = variants{} ; -- 
lin grin_V = variants{} ; -- 
lin shelf_N = mkN "estantería" ; -- status=guess
lin pole_N = mkN "polo" ; -- status=guess
lin punishment_N = mkN "castigo" ; -- status=guess
lin strict_A = mkA "estricto" ; -- status=guess
lin wave_V2 = mkV2 (mkV "abanicar") ; -- status=guess
lin wave_V = mkV "abanicar" ; -- status=guess
lin inside_N = mkN "interior" masculine ; -- status=guess
lin carriage_N = mkN "coche" masculine | mkN "vagón" masculine ; -- status=guess
lin fit_A = mkA "en forma" ; -- status=guess
lin conversion_N = mkN "conversión" feminine ; -- status=guess
lin hurry_V2V = mkV2V (mkV "apresurarse") | mkV2V (mkV "apurarse") | mkV2V (mkV (mkV "darse") "prisa") ; -- status=guess
lin hurry_V2 = mkV2 (mkV "apresurarse") | mkV2 (mkV "apurarse") | mkV2 (mkV (mkV "darse") "prisa") ; -- status=guess
lin hurry_V = mkV "apresurarse" | mkV "apurarse" | mkV (mkV "darse") "prisa" ; -- status=guess
lin essay_N = mkN "ensayo" ; -- status=guess
lin integration_N = mkN "integración" feminine ; -- status=guess
lin resignation_N = variants{} ; -- 
lin treasury_N = mkN "tesoro" ; -- status=guess
lin traveller_N = mkN "viajero" ; -- status=guess
lin chocolate_N = mkN "chocolatina" ; -- status=guess
lin assault_N = mkN "asalto" | mkN "acometimiento" ; -- status=guess
lin schedule_N = mkN "horario" | mkN "itinerario" ; -- status=guess
lin undoubtedly_Adv = variants{} ; -- 
lin twin_N = mkN "gemelo" ; -- status=guess
lin format_N = mkN "formato" ; -- status=guess
lin murder_V2 = mkV2 (mkV "asesinar") ; -- status=guess
lin sigh_VS = mkVS (mkV "suspirar") ; -- status=guess
lin sigh_V2 = mkV2 (mkV "suspirar") ; -- status=guess
lin sigh_V = mkV "suspirar" ; -- status=guess
lin seller_N = variants{} ; -- 
lin lease_N = variants{} ; -- 
lin bitter_A = mkA "amargado" ; -- status=guess
lin double_V2 = mkV2 (mkV "doblar") ; -- status=guess
lin double_V = mkV "doblar" ; -- status=guess
lin ally_N = mkN "aliado" ; -- status=guess
lin stake_N = mkN "estaca" ; -- status=guess
lin processing_N = variants{} ; -- 
lin informal_A = mkA "informal" ; -- status=guess
lin flexible_A = mkA "flexible" ; -- status=guess
lin cap_N = L.cap_N ;
lin stable_A = mkA "estable" ; -- status=guess
lin till_Subj = variants{} ; -- 
lin sympathy_N = mkN "empatía" ; -- status=guess
lin tunnel_N = mkN "túnel" masculine ; -- status=guess
lin pen_N = L.pen_N ;
lin instal_V = variants{} ; -- 
lin suspend_V2 = variants{} ; -- 
lin suspend_V = variants{} ; -- 
lin blow_N = mkN "golpe" masculine ; -- status=guess
lin wander_V2 = mkV2 (mkV "divagar") | mkV2 (mkV "pajarear") | mkV2 (mkV "pajaronear") ; -- status=guess
lin wander_V = mkV "divagar" | mkV "pajarear" | mkV "pajaronear" ; -- status=guess
lin notably_Adv = variants{} ; -- 
lin disappoint_V2 = mkV2 (mkV "decepcionar") ; -- status=guess
lin wipe_V2 = L.wipe_V2 ;
lin wipe_V = mkV "formatear" ; -- status=guess
lin folk_N = mkN "etimología popular" ; -- status=guess
lin attraction_N = mkN "atracción" feminine ; -- status=guess
lin disc_N = mkN "disco" ; -- status=guess
lin inspire_V2V = mkV2V (mkV "inspirar") ; -- status=guess
lin inspire_V2 = mkV2 (mkV "inspirar") ; -- status=guess
lin machinery_N = mkN "maquinaria" ; -- status=guess
lin undergo_V2 = mkV2 (mkV "experimentar") ; -- status=guess
lin nowhere_Adv = mkAdv "en ninguna parte" ; -- status=guess
lin inspector_N = variants{} ; -- 
lin wise_A = mkA "sabio" | mkA "juicioso" ; -- status=guess
lin balance_V2 = mkV2 (mkV "balancear") ; -- status=guess
lin balance_V = mkV "balancear" ; -- status=guess
lin purchaser_N = variants{} ; -- 
lin resort_N = mkN "estación turística" ; -- status=guess
lin pop_N = mkN "grupo de pop" ; -- status=guess
lin organ_N = mkN "órgano" ; -- status=guess
lin ease_V2 = variants{} ; -- 
lin ease_V = variants{} ; -- 
lin friendship_N = mkN "amistad" feminine ; -- status=guess
lin deficit_N = mkN "déficit" masculine ; -- status=guess
lin dear_N = variants{} ; -- 
lin convey_V2 = mkV2 (mkV "transportar") | mkV2 (mkV "trasladar") ; -- status=guess
lin reserve_V2 = mkV2 (mkV "reservar") ; -- status=guess
lin reserve_V = mkV "reservar" ; -- status=guess
lin planet_N = L.planet_N ;
lin frequent_A = mkA "frecuente" ; -- status=guess
lin loose_A = mkA "indiscreto" ; -- status=guess
lin intense_A = mkA "intenso" ; -- status=guess
lin retail_A = variants{} ; -- 
lin wind_V2 = mkV2 (mkV "rebobinar") ; -- status=guess
lin wind_V = mkV "rebobinar" ; -- status=guess
lin lost_A = variants{} ; -- 
lin grain_N = mkN "grano" ; -- status=guess
lin particle_N = mkN "acelerador de partículas" ; -- status=guess
lin destruction_N = mkN "destrucción" ; -- status=guess
lin witness_V2 = variants{} ; -- 
lin witness_V = variants{} ; -- 
lin pit_N = mkN "foso" | mkN "excavación" feminine ; -- status=guess
lin registration_N = mkN "registración" | mkN "inscripción" feminine | mkN "matriculación" | mkN "registro" ; -- status=guess
lin conception_N = mkN "concepción" feminine ; -- status=guess
lin steady_A = mkA "firme" | mkA "fijo" ; -- status=guess
lin rival_N = variants{} ; -- 
lin steam_N = mkN "máquina de vapor" ; -- status=guess
lin back_A = variants{} ; -- 
lin chancellor_N = mkN "canciller" ; -- status=guess
lin crash_V2 = mkV2 (mkV "chocar") ; -- status=guess
lin crash_V = mkV "chocar" ; -- status=guess
lin belt_N = mkN "cinturón" | mkN "cinturón de seguridad" ; -- status=guess
lin logic_N = mkN "lógica" ; -- status=guess
lin premium_N = variants{} ; -- 
lin confront_V2 = mkV2 (mkV "enfrentar") ; -- status=guess
lin precede_V2 = mkV2 (mkV "preceder") | mkV2 (mkV "anteceder") ; -- status=guess
lin precede_V = mkV "preceder" | mkV "anteceder" ; -- status=guess
lin experimental_A = mkA "experimental" ; -- status=guess
lin alarm_N = mkN "despertador" masculine ; -- status=guess
lin rational_A = variants{} ; -- 
lin incentive_N = mkN "incentivo" ; -- status=guess
lin roughly_Adv = variants{} ; -- 
lin bench_N = mkN "banco" ; -- status=guess
lin wrap_V2 = mkV2 (envolver_V) | mkV2 (mkV "fajar") ; -- status=guess
lin wrap_V = envolver_V | mkV "fajar" ; -- status=guess
lin regarding_Prep = variants{} ; -- 
lin inadequate_A = mkA "inadecuado" ; -- status=guess
lin ambition_N = variants{} ; -- 
lin since_Adv = variants{}; -- mkPrep "desde" ;
lin fate_N = mkN "destino" | mkN "azar" masculine ; -- status=guess
lin vendor_N = mkN "vendedor" masculine ; -- status=guess
lin stranger_N = mkN "forastero" | mkN "extranjero" ; -- status=guess
lin spiritual_A = mkA "espiritual" ; -- status=guess
lin increasing_A = variants{} ; -- 
lin anticipate_VV = mkVV (mkV "anticipar") | mkVV (prever_V) ; -- status=guess
lin anticipate_VS = mkVS (mkV "anticipar") | mkVS (prever_V) ; -- status=guess
lin anticipate_V2 = mkV2 (mkV "anticipar") | mkV2 (prever_V) ; -- status=guess
lin anticipate_V = mkV "anticipar" | prever_V ; -- status=guess
lin logical_A = mkA "lógico" ; -- status=guess
lin fibre_N = mkN "fibra" ; -- status=guess
lin attribute_V2 = mkV2 (atribuir_V) ; -- status=guess
lin sense_VS = mkVS (mkV (mkV "dar") "sentido") ; -- status=guess
lin sense_V2 = mkV2 (mkV (mkV "dar") "sentido") ; -- status=guess
lin black_N = mkN "negro" | mkN "negra" masculine ; -- status=guess
lin petrol_N = variants{} ; -- 
lin maker_N = variants{} ; -- 
lin generous_A = mkA "generoso" ; -- status=guess
lin allocation_N = mkN "asignación" feminine | mkN "reparto" | mkN "distribución" masculine ; -- status=guess
lin depression_N = mkN "depresión" feminine ; -- status=guess
lin declaration_N = mkN "declaración" feminine ; -- status=guess
lin spot_VS = mkVS (mkV "divisar") | mkVS (mkV "detectar") | mkVS (mkV "localizar") | mkVS (mkV "ubicar") | mkVS (mkV "avistar") ; -- status=guess
lin spot_V2 = mkV2 (mkV "divisar") | mkV2 (mkV "detectar") | mkV2 (mkV "localizar") | mkV2 (mkV "ubicar") | mkV2 (mkV "avistar") ; -- status=guess
lin spot_V = mkV "divisar" | mkV "detectar" | mkV "localizar" | mkV "ubicar" | mkV "avistar" ; -- status=guess
lin modest_A = mkA "modesto" ; -- status=guess
lin bottom_A = variants{} ; -- 
lin dividend_N = mkN "dividendo" ; -- status=guess
lin devote_V2 = variants{} ; -- 
lin condemn_V2 = mkV2 (mkV "condenar") ; -- status=guess
lin integrate_V2 = variants{} ; -- 
lin integrate_V = variants{} ; -- 
lin pile_N = mkN "montón" masculine ; -- status=guess
lin identification_N = variants{} ; -- 
lin acute_A = mkA "agudo" ; -- status=guess
lin barely_Adv = variants{} ; -- 
lin providing_Subj = variants{} ; -- 
lin directive_N = variants{} ; -- 
lin bet_VS = mkVS (apostar_V) ; -- status=guess
lin bet_V2 = mkV2 (apostar_V) ; -- status=guess
lin bet_V = apostar_V ; -- status=guess
lin modify_V2 = mkV2 (mkV "modificar") ; -- status=guess
lin bare_A = mkA "desnudo" ; -- status=guess
lin swear_VV = mkVV (mkV "blasfemar") | mkVV (renegar_V) | mkVV (mkV "jurar") | mkVV (mkV (mkV "echar") "ternos") ; -- status=guess
lin swear_V2V = mkV2V (mkV "blasfemar") | mkV2V (renegar_V) | mkV2V (mkV "jurar") | mkV2V (mkV (mkV "echar") "ternos") ; -- status=guess
lin swear_V2 = mkV2 (mkV "blasfemar") | mkV2 (renegar_V) | mkV2 (mkV "jurar") | mkV2 (mkV (mkV "echar") "ternos") ; -- status=guess
lin swear_V = mkV "blasfemar" | renegar_V | mkV "jurar" | mkV (mkV "echar") "ternos" ; -- status=guess
lin final_N = mkN "último" | mkN "última" | mkN "última" ; -- status=guess
lin accordingly_Adv = mkAdv "en consecuencia" ; -- status=guess
lin valid_A = mkA "válido" ; -- status=guess
lin wherever_Adv = variants{} ; -- 
lin mortality_N = mkN "mortalidad" feminine ; -- status=guess
lin medium_N = mkN "médium" ; -- status=guess
lin silk_N = mkN "ceiba" | mkN "kapok" | mkN "capoc" masculine ; -- status=guess
lin funeral_N = mkN "funeral" | mkN "entierro" ; -- status=guess
lin depending_A = variants{} ; -- 
lin cow_N = L.cow_N ;
lin correspond_V2 = variants{}; -- mkV "corresponder" ;
lin correspond_V = mkV "corresponder" ; -- status=guess
lin cite_V2 = variants{} ; -- 
lin classic_A = mkA "clásico" ; -- status=guess
lin inspection_N = mkN "inspección" feminine ; -- status=guess
lin calculation_N = mkN "cálculo" feminine ; -- status=guess
lin rubbish_N = mkN "desperdicios" masculine ; -- status=guess
lin minimum_N = mkN "mínimo" ; -- status=guess
lin hypothesis_N = mkN "hipótesis" feminine ; -- status=guess
lin youngster_N = mkN "jovenzuelo" ; -- status=guess
lin slope_N = mkN "pendiente" masculine | mkN "cuesta" ; -- status=guess
lin patch_N = mkN "parche" masculine ; -- status=guess
lin invitation_N = mkN "invitación" feminine ; -- status=guess
lin ethnic_A = mkA "étnico" ; -- status=guess
lin federation_N = mkN "federación" feminine ; -- status=guess
lin duke_N = mkN "duque" masculine ; -- status=guess
lin wholly_Adv = variants{} ; -- 
lin closure_N = mkN "cierre" feminine ; -- status=guess
lin dictionary_N = mkN "diccionario" ; -- status=guess
lin withdrawal_N = mkN "coitus interruptus" ; -- status=guess
lin automatic_A = mkA "automático" ; -- status=guess
lin liable_A = variants{} ; -- 
lin cry_N = mkN "llanto" ; -- status=guess
lin slow_V2 = mkV2 (mkV "desacelerar") ; -- status=guess
lin slow_V = mkV "desacelerar" ; -- status=guess
lin borough_N = mkN "municipio" | mkN "concejo" ; -- status=guess
lin well_A = mkA "bien" ; -- status=guess
lin suspicion_N = mkN "sospecha" ; -- status=guess
lin portrait_N = mkN "retrato" ; -- status=guess
lin local_N = mkN "vecino" | mkN "vecina" ; -- status=guess
lin jew_N = variants{} ; -- 
lin fragment_N = mkN "fragmento" ; -- status=guess
lin revolutionary_A = mkA "revolucionario" | mkA "revolucionaria" ; -- status=guess
lin evaluate_V2 = mkV2 (mkV "evaluar") ; -- status=guess
lin evaluate_V = mkV "evaluar" ; -- status=guess
lin competitor_N = mkN "competidor" masculine ; -- status=guess
lin sole_A = mkA "solo" ; -- status=guess
lin reliable_A = mkA "fiable" | mkA "confiable" ; -- status=guess
lin weigh_V2 = mkV2 (mkV (mkV "levar") "anclas") | mkV2 (mkV "levar") ; -- status=guess
lin weigh_V = mkV (mkV "levar") "anclas" | mkV "levar" ; -- status=guess
lin medieval_A = mkA "medieval" ; -- status=guess
lin clinic_N = mkN "clínica" ; -- status=guess
lin shine_V2 = mkV2 (mkV "brillar") | mkV2 (lucir_V) ; -- status=guess
lin shine_V = mkV "brillar" | lucir_V ; -- status=guess
lin knit_V2 = mkV2 (mkV "soldarse") ; -- status=guess
lin knit_V = mkV "soldarse" ; -- status=guess
lin complexity_N = mkN "complejidad" feminine ; -- status=guess
lin remedy_N = mkN "recurso" ; -- status=guess
lin fence_N = mkN "cerca" | mkN "cerramiento" | mkN "barda " | mkN "valla" | mkN "seto" ; -- status=guess
lin bike_N = L.bike_N ;
lin freeze_V2 = mkV2 (helar_V) ; -- status=guess
lin freeze_V = L.freeze_V ;
lin eliminate_V2 = mkV2 (mkV "eliminar") ; -- status=guess
lin interior_N = mkN "interior" masculine ; -- status=guess
lin intellectual_A = variants{} ; -- 
lin established_A = variants{} ; -- 
lin voter_N = mkN "votante" masculine ; -- status=guess
lin garage_N = mkN "garaje" masculine ; -- status=guess
lin era_N = mkN "época" masculine | mkN "era" | mkN "período" ; -- status=guess
lin pregnant_A = mkA "embarazada" | mkA "embarazado" | mkA "preñada" | mkA "preñado" | mkA "encinta" | mkA "preñada" | mkA "preñado" ; -- status=guess
lin plot_N = mkN "plano" feminine | mkN "lote" masculine ; -- status=guess
lin greet_V2 = mkV2 (mkV "saludar") ; -- status=guess
lin electrical_A = mkA "eléctrico" ; -- status=guess
lin lie_N = mkN "mentira" ; -- status=guess
lin disorder_N = mkN "desorden" masculine ; -- status=guess
lin formally_Adv = variants{} ; -- 
lin excuse_N = mkN "excusa" ; -- status=guess
lin socialist_A = mkA "socialista" ; -- status=guess
lin cancel_V2 = mkV2 (mkV "cancelar") ; -- status=guess
lin cancel_V = mkV "cancelar" ; -- status=guess
lin harm_N = mkN "daño" ; -- status=guess
lin excess_N = mkN "deducible" masculine | mkN "franquicia" ; -- status=guess
lin exact_A = mkA "exacto" ; -- status=guess
lin oblige_V2V = variants{} ; -- 
lin oblige_V2 = variants{} ; -- 
lin accountant_N = mkN "contador" | mkN "contadora" | mkN "contable" ; -- status=guess
lin mutual_A = mkA "mutuo" ; -- status=guess
lin fat_N = L.fat_N ;
lin volunteer_N = variants{} ; -- 
lin laughter_N = mkN "risa" ; -- status=guess
lin trick_N = mkN "truco" | mkN "artimaña" ; -- status=guess
lin load_V2 = mkV2 (mkV "cargar") ; -- status=guess
lin load_V = mkV "cargar" ; -- status=guess
lin disposal_N = variants{} ; -- 
lin taxi_N = mkN "taxi" feminine ; -- status=guess
lin murmur_V2 = mkV2 (mkV "murmurar") ; -- status=guess
lin murmur_V = mkV "murmurar" ; -- status=guess
lin tonne_N = mkN "tonelada" | mkN "tonelada métrica" ; -- status=guess
lin spell_V2 = mkV2 (mkV "descifrar") ; -- status=guess
lin spell_V = mkV "descifrar" ; -- status=guess
lin clerk_N = mkN "oficinista" masculine | mkN "secretario" | mkN "escribiente" masculine ; -- status=guess
lin curious_A = mkA "curioso" ; -- status=guess
lin satisfactory_A = mkA "satisfactorio" ; -- status=guess
lin identical_A = mkA "idéntico" ; -- status=guess
lin applicant_N = mkN "solicitante" masculine ; -- status=guess
lin removal_N = mkN "mudanza" ; -- status=guess
lin processor_N = variants{} ; -- 
lin cotton_N = mkN "algodón" masculine ; -- status=guess
lin reverse_V2 = variants{} ; -- 
lin reverse_V = variants{} ; -- 
lin hesitate_VV = mkVV (mkV "vacilar") | mkVV (mkV "dudar") ; -- status=guess
lin hesitate_V = mkV "vacilar" | mkV "dudar" ; -- status=guess
lin professor_N = mkN "profesor" | mkN "profesora" ; -- status=guess
lin admire_V2 = mkV2 (mkV "admirar") ; -- status=guess
lin namely_Adv = mkAdv "específicamente" | mkAdv "a saber" ; -- status=guess
lin electoral_A = mkA "electoral" ; -- status=guess
lin delight_N = mkN "deleite" | mkN "regocijo" | mkN "delicia" | mkN "placer" masculine | mkN "delectación" feminine | mkN "gozo" ; -- status=guess
lin urgent_A = mkA "urgente" | mkA "acuciante" ; -- status=guess
lin prompt_V2V = mkV2V (mkV "incitar") ; -- status=guess
lin prompt_V2 = mkV2 (mkV "incitar") ; -- status=guess
lin mate_N = mkN "pareja" masculine ; -- status=guess
lin mate_2_N = variants{} ; -- 
lin mate_1_N = variants{} ; -- 
lin exposure_N = mkN "exposición" feminine | mkN "publicidad" feminine | mkN "denuncia" ; -- status=guess
lin server_N = mkN "servidor" masculine ; -- status=guess
lin distinctive_A = variants{} ; -- 
lin marginal_A = mkA "marginal" ; -- status=guess
lin structural_A = mkA "estructural" ; -- status=guess
lin rope_N = L.rope_N ;
lin miner_N = mkN "minero" ; -- status=guess
lin entertainment_N = mkN "entretenimiento" ; -- status=guess
lin acre_N = mkN "acre" masculine ; -- status=guess
lin pig_N = mkN "jeringoso" ; -- status=guess
lin encouraging_A = mkA "alentador" | mkA "esperanzador" ; -- status=guess
lin guarantee_N = mkN "garantía" masculine ; -- status=guess
lin gear_N = mkN "marcha" | mkN "velocidad" feminine ; -- status=guess
lin anniversary_N = mkN "aniversario" ; -- status=guess
lin past_Adv = variants{} ; -- 
lin ceremony_N = mkN "ceremonia" ; -- status=guess
lin rub_V2 = L.rub_V2 ;
lin rub_V = mkV "frotar" ; -- status=guess
lin monopoly_N = mkN "monopolio" ; -- status=guess
lin left_N = mkN "zurdo" | mkN "zurda" ; -- status=guess
lin flee_V2 = mkV2 (mkV "desvanecerse") ; -- status=guess
lin flee_V = mkV "desvanecerse" ; -- status=guess
lin yield_V2 = mkV2 (mkV "ceder") ; -- status=guess
lin yield_V = mkV "ceder" ; -- status=guess
lin discount_N = mkN "descuento" | mkN "rebaja" ; -- status=guess
lin above_A = variants{} ; -- 
lin uncle_N = mkN "tío" ; -- status=guess
lin audit_N = mkN "auditoría" ; -- status=guess
lin advertisement_N = mkN "anuncio" | mkN "publicidad" feminine | mkN "reclamo" ; -- status=guess
lin explosion_N = variants{} ; -- 
lin contrary_A = variants{} ; -- 
lin tribunal_N = mkN "tribunal" masculine ; -- status=guess
lin swallow_V2 = mkV2 (mkV "tragar") | mkV2 (engullir_V) | mkV2 (mkV "deglutir") | mkV2 (mkV "ingurgitar") ; -- status=guess
lin swallow_V = mkV "tragar" | engullir_V | mkV "deglutir" | mkV "ingurgitar" ; -- status=guess
lin typically_Adv = variants{} ; -- 
lin fun_A = variants{} ; -- 
lin rat_N = mkN "rata" ; -- status=guess
lin cloth_N = mkN "trapo" ; -- status=guess
lin cable_N = mkN "teleférico" ; -- status=guess
lin interrupt_V2 = mkV2 (mkV "interrumpir") ; -- status=guess
lin interrupt_V = mkV "interrumpir" ; -- status=guess
lin crash_N = mkN "choque" masculine ; -- status=guess
lin flame_N = mkN "flama" | mkN "llama" ; -- status=guess
lin controversy_N = mkN "controversia" ; -- status=guess
lin rabbit_N = mkN "conejo" ; -- status=guess
lin everyday_A = variants{} ; -- 
lin allegation_N = mkN "alegato" | mkN "acusación" feminine ; -- status=guess
lin strip_N = mkN "tira" ; -- status=guess
lin stability_N = mkN "estabilidad" feminine ; -- status=guess
lin tide_N = mkN "marea" ; -- status=guess
lin illustration_N = mkN "ilustración" feminine ; -- status=guess
lin insect_N = mkN "insecto" ; -- status=guess
lin correspondent_N = mkN "corresponsal" masculine ; -- status=guess
lin devise_V2 = variants{} ; -- 
lin determined_A = variants{} ; -- 
lin brush_V2 = mkV2 (mkV "aplicar") ; -- status=guess
lin brush_V = mkV "aplicar" ; -- status=guess
lin adjustment_N = mkN "ajuste" | mkN "modificación" feminine ; -- status=guess
lin controversial_A = mkA "controversial" | mkA "controvertido" ; -- status=guess
lin organic_A = mkA "orgánico" ; -- status=guess
lin escape_N = mkN "escapada" masculine | mkN "fuga" | mkN "escape" masculine | mkN "escapatorio" | mkN "liberación" feminine ; -- status=guess
lin thoroughly_Adv = variants{} ; -- 
lin interface_N = mkN "interfaz" feminine ; -- status=guess
lin historic_A = mkA "histórico" ; -- status=guess
lin collapse_N = mkN "colapso" ; -- status=guess
lin temple_N = mkN "sien" feminine ; -- status=guess
lin shade_N = mkN "sombra" ; -- status=guess
lin craft_N = mkN "pericia" ; -- status=guess
lin nursery_N = mkN "criadero" ; -- status=guess
lin piano_N = mkN "piano" ; -- status=guess
lin desirable_A = mkA "deseable" | mkA "conveniente" ; -- status=guess
lin assurance_N = mkN "confianza" ; -- status=guess
lin jurisdiction_N = mkN "jurisdicción" feminine ; -- status=guess
lin advertise_V2 = mkV2 (mkV (mkV "hacer") "publicidad") ; -- status=guess
lin advertise_V = mkV (mkV "hacer") "publicidad" ; -- status=guess
lin bay_N = mkN "bahía" ; -- status=guess
lin specification_N = mkN "especificación" feminine ; -- status=guess
lin disability_N = mkN "discapacidad" feminine ; -- status=guess
lin presidential_A = mkA "presidencial" ; -- status=guess
lin arrest_N = mkN "arresto" ; -- status=guess
lin unexpected_A = mkA "inesperado" ; -- status=guess
lin switch_N = mkN "interruptor" masculine ; -- status=guess
lin penny_N = mkN "velocípedo" ; -- status=guess
lin respect_V2 = mkV2 (mkV "respetar") ; -- status=guess
lin celebration_N = mkN "celebración" feminine ; -- status=guess
lin gross_A = mkA "repulsivo" ; -- status=guess
lin aid_V2 = mkV2 (mkV "ayudar") ; -- status=guess
lin aid_V = mkV "ayudar" ; -- status=guess
lin superb_A = mkA "excepcional" ; -- status=guess
lin process_V2 = variants{} ; -- 
lin process_V = variants{} ; -- 
lin innocent_A = mkA "inocente" ; -- status=guess
lin leap_V2 = mkV2 (mkV "saltar") ; -- status=guess
lin leap_V = mkV "saltar" ; -- status=guess
lin colony_N = mkN "colonia" ; -- status=guess
lin wound_N = mkN "herida" | mkN "llaga" ; -- status=guess
lin hardware_N = mkN "hardware" masculine ; -- status=guess
lin satellite_N = mkN "satélite" masculine ; -- status=guess
lin float_VA = mkVA (mkV "flotar") ; -- status=guess
lin float_V2 = mkV2 (mkV "flotar") ; -- status=guess
lin float_V = L.float_V ;
lin bible_N = variants{} ; -- 
lin statistical_A = mkA "estadístico" ; -- status=guess
lin marked_A = variants{} ; -- 
lin hire_VS = mkVS (mkV "contratar") ; -- status=guess
lin hire_V2V = mkV2V (mkV "contratar") ; -- status=guess
lin hire_V2 = mkV2 (mkV "contratar") ; -- status=guess
lin hire_V = mkV "contratar" ; -- status=guess
lin cathedral_N = mkN "catedral" feminine ; -- status=guess
lin motive_N = mkN "fuerza motriz" ; -- status=guess
lin correct_VS = mkVS (corregir_V) ; -- status=guess
lin correct_V2 = mkV2 (corregir_V) ; -- status=guess
lin correct_V = corregir_V ; -- status=guess
lin gastric_A = mkA "gástrico" ; -- status=guess
lin raid_N = mkN "invasión" feminine | mkN "ataque" masculine | mkN "asedio" | mkN "redada" ; -- status=guess
lin comply_V2 = mkV2 (mkV "cumplir") | mkV2 (mkV (mkV "acceder") "a") ; -- status=guess
lin comply_V = mkV "cumplir" | mkV (mkV "acceder") "a" ; -- status=guess
lin accommodate_V2 = mkV2 (mkV "acomodar") | mkV2 (mkV "adaptar") ; -- status=guess
lin accommodate_V = mkV "acomodar" | mkV "adaptar" ; -- status=guess
lin mutter_V2 = variants{} ; -- 
lin mutter_V = variants{} ; -- 
lin induce_V2V = mkV2V (inducir_V) ; -- status=guess
lin induce_V2 = mkV2 (inducir_V) ; -- status=guess
lin trap_V2 = mkV2 (mkV "atrapar") ; -- status=guess
lin trap_V = mkV "atrapar" ; -- status=guess
lin invasion_N = mkN "invasión" feminine ; -- status=guess
lin humour_N = mkN "humor" masculine ; -- status=guess
lin bulk_N = mkN "grueso" ; -- status=guess
lin traditionally_Adv = variants{} ; -- 
lin commission_V2V = mkV2V (mkV "encargar") ; -- status=guess
lin commission_V2 = mkV2 (mkV "encargar") ; -- status=guess
lin upstairs_Adv = mkAdv "arriba" ; -- status=guess
lin translate_V2 = mkV2 (traducir_V) | mkV2 (mkV "trasladar") ; -- status=guess
lin translate_V = traducir_V | mkV "trasladar" ; -- status=guess
lin rhythm_N = mkN "ritmo" ; -- status=guess
lin emission_N = mkN "emisión" feminine ; -- status=guess
lin collective_A = mkA "colectivo" ; -- status=guess
lin transformation_N = mkN "transformación" feminine ; -- status=guess
lin battery_N = mkN "batería" ; -- status=guess
lin stimulus_N = mkN "estímulo" ; -- status=guess
lin naked_A = mkA "como dios lo trajo al mundo" ; -- status=guess
lin white_N = mkN "blanco" | mkN "blanca" ; -- status=guess
lin menu_N = mkN "menú" masculine | mkN "carta" ; -- status=guess
lin toilet_N = mkN "baño" feminine | mkN "sanitario" ; -- status=guess
lin butter_N = L.butter_N ;
lin surprise_V2V = mkV2V (mkV "sorprender") ; -- status=guess
lin surprise_V2 = mkV2 (mkV "sorprender") ; -- status=guess
lin needle_N = mkN "aguja" ; -- status=guess
lin effectiveness_N = variants{} ; -- 
lin accordance_N = mkN "acuerdo" | mkN "conformidad" feminine ; -- status=guess
lin molecule_N = mkN "molécula" ; -- status=guess
lin fiction_N = mkN "ficción" feminine ; -- status=guess
lin learning_N = mkN "conocimiento" ; -- status=guess
lin statute_N = variants{} ; -- 
lin reluctant_A = mkA "renuente" | mkA "reacio" ; -- status=guess
lin overlook_V2 = mkV2 (mkV (mkV "pasar") "por alto") ; -- status=guess
lin junction_N = variants{} ; -- 
lin necessity_N = mkN "necesidad" feminine ; -- status=guess
lin nearby_A = mkA "cercano" | mkA "cercana" | mkA "próximo" ; -- status=guess
lin experienced_A = variants{} ; -- 
lin lorry_N = variants{} ; -- 
lin exclusive_A = variants{} ; -- 
lin graphics_N = variants{} ; -- 
lin stimulate_V2 = mkV2 (mkV "estimular") ; -- status=guess
lin warmth_N = mkN "calor" masculine ; -- status=guess
lin therapy_N = variants{} ; -- 
lin convenient_A = mkA "conveniente" | mkA "cómodo" ; -- status=guess
lin cinema_N = mkN "cine" masculine ; -- status=guess
lin domain_N = mkN "dominio" ; -- status=guess
lin tournament_N = mkN "torneo" | mkN "campeonato" ; -- status=guess
lin doctrine_N = mkN "doctrina" ; -- status=guess
lin sheer_A = variants{} ; -- 
lin proposition_N = mkN "proposición" feminine ; -- status=guess
lin grip_N = variants{} ; -- 
lin widow_N = mkN "viuda" ; -- status=guess
lin discrimination_N = mkN "discriminación" feminine ; -- status=guess
lin bloody_Adv = variants{} ; -- 
lin ruling_A = variants{} ; -- 
lin fit_N = mkN "convulción" feminine ; -- status=guess
lin nonetheless_Adv = variants{} ; -- 
lin myth_N = mkN "mito" ; -- status=guess
lin episode_N = mkN "episodio" ; -- status=guess
lin drift_V2 = mkV2 (errar_V) ; -- status=guess
lin drift_V = errar_V ; -- status=guess
lin assert_VS = mkVS (mkV "asegurar") | mkVS (mkV "afirmar") ; -- status=guess
lin assert_V2 = mkV2 (mkV "asegurar") | mkV2 (mkV "afirmar") ; -- status=guess
lin assert_V = mkV "asegurar" | mkV "afirmar" ; -- status=guess
lin terrace_N = mkN "terraza" | mkN "terrado" ; -- status=guess
lin uncertain_A = mkA "incierto" ; -- status=guess
lin twist_V2 = mkV2 (torcer_V) ; -- status=guess
lin twist_V = torcer_V ; -- status=guess
lin insight_N = mkN "introspección" feminine ; -- status=guess
lin undermine_V2 = mkV2 (mkV "socavar") ; -- status=guess
lin tragedy_N = mkN "tragedia" ; -- status=guess
lin enforce_V2 = mkV2 (imponer_V) ; -- status=guess
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin march_V2 = mkV2 (mkV "marchar") ; -- status=guess
lin march_V = mkV "marchar" ; -- status=guess
lin leaflet_N = mkN "folíolo" ; -- status=guess
lin fellow_A = variants{} ; -- 
lin object_V2 = mkV2 (mkV "objetar") ; -- status=guess
lin object_V = mkV "objetar" ; -- status=guess
lin pond_N = mkN "charco" ; -- status=guess
lin adventure_N = mkN "aventura" ; -- status=guess
lin diplomatic_A = mkA "diplomático" ; -- status=guess
lin mixed_A = variants{} ; -- 
lin rebel_N = mkN "rebelde" masculine ; -- status=guess
lin equity_N = mkN "equidad" feminine ; -- status=guess
lin literally_Adv = variants{} ; -- 
lin magnificent_A = mkA "magnífico" | mkA "macanudo" ; -- status=guess
lin loyalty_N = mkN "lealtad" feminine ; -- status=guess
lin tremendous_A = mkA "tremendo" ; -- status=guess
lin airline_N = mkN "aerolínea" ; -- status=guess
lin shore_N = mkN "costa" | mkN "orilla" ; -- status=guess
lin restoration_N = mkN "restauración" feminine ; -- status=guess
lin physically_Adv = variants{} ; -- 
lin render_V2 = mkV2 (dar_V) | mkV2 (devolver_V) ; -- status=guess
lin institutional_A = mkA "institucional" ; -- status=guess
lin emphasize_VS = mkVS (mkV "subrayar") | mkVS (mkV "enfatizar") ; -- status=guess
lin emphasize_V2 = mkV2 (mkV "subrayar") | mkV2 (mkV "enfatizar") ; -- status=guess
lin mess_N = mkN "comedor militar" | mkN "cantina" | mkN "comedor" masculine ; -- status=guess
lin commander_N = mkN "comandante" masculine ; -- status=guess
lin straightforward_A = mkA "franco" | mkA "sencillo" ; -- status=guess
lin singer_N = mkN "cantante" masculine | mkN "cantor" | mkN "cantora" ; -- status=guess
lin squeeze_V2 = L.squeeze_V2 ;
lin squeeze_V = mkV "exprimir" | apretar_V ; -- status=guess
lin full_time_A = variants{} ; -- 
lin breed_V2 = mkV2 (mkV "criar") ; -- status=guess
lin breed_V = mkV "criar" ; -- status=guess
lin successor_N = variants{} ; -- 
lin triumph_N = mkN "triunfo" ; -- status=guess
lin heading_N = variants{} ; -- 
lin mathematics_N = mkN "matemáticas" feminine ; -- status=guess
lin laugh_N = mkN "risa" ; -- status=guess
lin clue_N = mkN "pista" | mkN "indicio" ; -- status=guess
lin still_A = mkA "quieto" | mkA "quieta" ; -- status=guess
lin ease_N = variants{} ; -- 
lin specially_Adv = variants{} ; -- 
lin biological_A = mkA "biológico" | mkA "consanguíneo" ; -- status=guess
lin forgive_V2 = mkV2 (mkV "perdonar") ; -- status=guess
lin forgive_V = mkV "perdonar" ; -- status=guess
lin trustee_N = mkN "fiduciario" | mkN "fiduciaria" ; -- status=guess
lin photo_N = mkN "foto" feminine | mkN "fotografía" ; -- status=guess
lin fraction_N = mkN "fracción" feminine | mkN "quebrado" ; -- status=guess
lin chase_V2 = mkV2 (perseguir_V) ; -- status=guess
lin chase_V = perseguir_V ; -- status=guess
lin whereby_Adv = mkAdv "por el cual" | mkAdv "por la cual" ; -- status=guess
lin mud_N = mkN "lodo" | mkN "barro" | mkN "fango" ; -- status=guess
lin pensioner_N = mkN "pensionista" ; -- status=guess
lin functional_A = mkA "funcional" ; -- status=guess
lin copy_V2 = mkV2 (mkV "imitar") | mkV2 (mkV "copiar") ; -- status=guess
lin copy_V = mkV "imitar" | mkV "copiar" ; -- status=guess
lin strictly_Adv = variants{} ; -- 
lin desperately_Adv = variants{} ; -- 
lin await_V2 = mkV2 (mkV "esperar") ; -- status=guess
lin coverage_N = mkN "cobertura" masculine ; -- status=guess
lin wildlife_N = mkN "vida silvestre" ; -- status=guess
lin indicator_N = mkN "indicador" masculine ; -- status=guess
lin lightly_Adv = variants{} ; -- 
lin hierarchy_N = mkN "jerarquía" ; -- status=guess
lin evolve_V2 = mkV2 (mkV "desarrollar") ; -- status=guess
lin evolve_V = mkV "desarrollar" ; -- status=guess
lin mechanical_A = mkA "mecánico" ; -- status=guess
lin expert_A = mkA "experto" ; -- status=guess
lin creditor_N = mkN "acreedor" masculine ; -- status=guess
lin capitalist_N = variants{} ; -- 
lin essence_N = mkN "esencia" | mkN "extracto" ; -- status=guess
lin compose_V2 = mkV2 (componer_V) ; -- status=guess
lin compose_V = componer_V ; -- status=guess
lin mentally_Adv = variants{} ; -- 
lin gaze_N = variants{} ; -- 
lin seminar_N = mkN "seminario" ; -- status=guess
lin target_V2V = variants{} ; -- 
lin target_V2 = variants{} ; -- 
lin label_V3 = mkV3 (mkV "rotular") ; -- status=guess
lin label_V2A = mkV2A (mkV "rotular") ; -- status=guess
lin label_V2 = mkV2 (mkV "rotular") ; -- status=guess
lin label_V = mkV "rotular" ; -- status=guess
lin fig_N = mkN "higo" | mkN "breva" ; -- status=guess
lin continent_N = mkN "continente" masculine ; -- status=guess
lin chap_N = mkN "tipo" ; -- status=guess
lin flexibility_N = mkN "flexibilidad" feminine ; -- status=guess
lin verse_N = mkN "estrofa" ; -- status=guess
lin minute_A = mkA "minucioso" ; -- status=guess
lin whisky_N = variants{} ; -- 
lin equivalent_A = mkA "equivalente" ; -- status=guess
lin recruit_V2 = mkV2 (mkV "reclutar") ; -- status=guess
lin recruit_V = mkV "reclutar" ; -- status=guess
lin echo_V2 = mkV2 (mkV "repercutir") | mkV2 (repetir_V) ; -- status=guess
lin echo_V = mkV "repercutir" | repetir_V ; -- status=guess
lin unfair_A = variants{} ; -- 
lin launch_N = mkN "lancha" ; -- status=guess
lin cupboard_N = mkN "armario" | mkN "vitrina" | mkN "alacena" ; -- status=guess
lin bush_N = mkN "arbusto" ; -- status=guess
lin shortage_N = mkN "falta" | mkN "carestía" ; -- status=guess
lin prominent_A = mkA "prominente" ; -- status=guess
lin merger_N = mkN "fusión" feminine | mkN "unión" feminine ; -- status=guess
lin command_V2 = variants{} ; -- 
lin command_V = variants{} ; -- 
lin subtle_A = mkA "sutil" ; -- status=guess
lin capital_A = mkA "excelente" ; -- status=guess
lin gang_N = mkN "grupo" | mkN "pandilla" ; -- status=guess
lin fish_V2 = mkV2 (mkV "pescar") ; -- status=guess
lin fish_V = mkV "pescar" ; -- status=guess
lin unhappy_A = mkA "infeliz" ; -- status=guess
lin lifetime_N = mkN "vida" masculine | mkN "toda la vida" ; -- status=guess
lin elite_N = mkN "élite" feminine ; -- status=guess
lin refusal_N = variants{} ; -- 
lin finish_N = mkN "meta" | mkN "fin" masculine ; -- status=guess
lin aggressive_A = mkA "agresivo" ; -- status=guess
lin superior_A = mkA "superior" ; -- status=guess
lin landing_N = mkN "muelle" masculine ; -- status=guess
lin exchange_V2 = mkV2 (mkV "cambiar") ; -- status=guess
lin debate_V2 = mkV2 (mkV "debatir") ; -- status=guess
lin debate_V = mkV "debatir" ; -- status=guess
lin educate_V2 = mkV2 (mkV "educar") | mkV2 (instruir_V) ; -- status=guess
lin separation_N = variants{} ; -- 
lin productivity_N = variants{} ; -- 
lin initiate_V2 = variants{} ; -- 
lin probability_N = mkN "probabilidad" feminine ; -- status=guess
lin virus_N = variants{} ; -- 
lin reporter_N = variants{} ; -- 
lin fool_N = mkN "el loco" | mkN "el bufón" ; -- status=guess
lin pop_V2 = mkV2 (mkV "aparecerse") ; -- status=guess
lin pop_V = mkV "aparecerse" ; -- status=guess
lin capitalism_N = mkN "capitalismo" ; -- status=guess
lin painful_A = mkA "doloroso" ; -- status=guess
lin correctly_Adv = variants{} ; -- 
lin complex_N = mkN "análisis complejo" ; -- status=guess
lin rumour_N = variants{} ; -- 
lin imperial_A = variants{} ; -- 
lin justification_N = mkN "justificación" feminine ; -- status=guess
lin availability_N = mkN "disponibilidad" feminine ; -- status=guess
lin spectacular_A = mkA "espectacular" ; -- status=guess
lin remain_N = variants{} ; -- 
lin ocean_N = mkN "océano" ; -- status=guess
lin cliff_N = mkN "acantilado" | mkN "precipicio" | mkN "risco" ; -- status=guess
lin sociology_N = mkN "sociología" ; -- status=guess
lin sadly_Adv = variants{} ; -- 
lin missile_N = mkN "proyectil" masculine ; -- status=guess
lin situate_V2 = mkV2 (mkV "situar") ; -- status=guess
lin artificial_A = mkA "artificial" ; -- status=guess
lin apartment_N = L.apartment_N ;
lin provoke_V2 = mkV2 (mkV "provocar") ; -- status=guess
lin oral_A = mkA "oral" ; -- status=guess
lin maximum_N = mkN "máximo" ; -- status=guess
lin angel_N = mkN "ángel" masculine ; -- status=guess
lin spare_A = variants{} ; -- 
lin shame_N = mkN "vergüenza" | mkN "pena" ; -- status=guess
lin intelligent_A = mkA "inteligente" ; -- status=guess
lin discretion_N = variants{} ; -- 
lin businessman_N = mkN "hombre de negocios" | mkN "empresario" ; -- status=guess
lin explicit_A = mkA "vulgar" ; -- status=guess
lin book_V2 = mkV2 (mkV "multar") ; -- status=guess
lin uniform_N = mkN "uniforme" masculine ; -- status=guess
lin push_N = mkN "empujón" masculine ; -- status=guess
lin counter_N = mkN "contraataque" masculine ; -- status=guess
lin subject_A = mkA "sujeto" ; -- status=guess
lin objective_A = mkA "objetivo" ; -- status=guess
lin hungry_A = mkA "hambriento" ; -- status=guess
lin clothing_N = mkN "ropa" ; -- status=guess
lin ride_N = mkN "rait" | mkN "autoestop" masculine ; -- status=guess
lin romantic_A = mkA "romántico" ; -- status=guess
lin attendance_N = variants{} ; -- 
lin part_time_A = variants{} ; -- 
lin trace_N = mkN "oligoelemento" | mkN "microelemento" ; -- status=guess
lin backing_N = variants{} ; -- 
lin sensation_N = mkN "sensación" feminine ; -- status=guess
lin carrier_N = mkN "compañía de transportes" | mkN "empresa de transportes" ; -- status=guess
lin interest_V2 = mkV2 (mkV "interesar") ; -- status=guess
lin interest_V = mkV "interesar" ; -- status=guess
lin classification_N = mkN "clasificación" feminine ; -- status=guess
lin classic_N = variants{} ; -- 
lin beg_V2 = mkV2 (mkV "mendigar") ; -- status=guess
lin beg_V = mkV "mendigar" ; -- status=guess
lin appendix_N = mkN "apéndice" masculine ; -- status=guess
lin doorway_N = mkN "entrada" masculine ; -- status=guess
lin density_N = variants{} ; -- 
lin working_class_A = variants{} ; -- 
lin legislative_A = mkA "legislativo" ; -- status=guess
lin hint_N = variants{} ; -- 
lin shower_N = mkN "llovizna" ; -- status=guess
lin current_N = mkN "cuenta corriente" ; -- status=guess
lin succession_N = variants{} ; -- 
lin nasty_A = variants{} ; -- 
lin duration_N = mkN "duración" feminine ; -- status=guess
lin desert_N = mkN "merecido" ; -- status=guess
lin receipt_N = mkN "receta" ; -- status=guess
lin native_A = mkA "natal" ; -- status=guess
lin chapel_N = mkN "capilla" masculine ; -- status=guess
lin amazing_A = mkA "asombroso" | mkA "sorprendente" ; -- status=guess
lin hopefully_Adv = variants{} ; -- 
lin fleet_N = mkN "flota" ; -- status=guess
lin comparable_A = mkA "comparable" ; -- status=guess
lin oxygen_N = mkN "oxígeno" ; -- status=guess
lin installation_N = mkN "instalación" feminine ; -- status=guess
lin developer_N = mkN "promotor" masculine ; -- status=guess
lin disadvantage_N = mkN "desventaja" ; -- status=guess
lin recipe_N = mkN "receta" ; -- status=guess
lin crystal_N = mkN "cristal" feminine ; -- status=guess
lin modification_N = mkN "modificación" feminine ; -- status=guess
lin schedule_V2V = mkV2V (mkV "programar") ; -- status=guess
lin schedule_V2 = mkV2 (mkV "programar") ; -- status=guess
lin schedule_V = mkV "programar" ; -- status=guess
lin midnight_N = mkN "medianoche" feminine ; -- status=guess
lin successive_A = mkA "sucesivo" ; -- status=guess
lin formerly_Adv = variants{} ; -- 
lin loud_A = mkA "ruidoso" ; -- status=guess
lin value_V2 = mkV2 (mkV "valorar") ; -- status=guess
lin value_V = mkV "valorar" ; -- status=guess
lin physics_N = mkN "física" ; -- status=guess
lin truck_N = mkN "camión" masculine | mkN "camioneta" | mkN "pickup)" ; -- status=guess
lin stroke_N = mkN "caricia" ; -- status=guess
lin kiss_N = mkN "beso" ; -- status=guess
lin envelope_N = mkN "sobre" masculine ; -- status=guess
lin speculation_N = mkN "especulación" feminine ; -- status=guess
lin canal_N = mkN "canal" masculine ; -- status=guess
lin unionist_N = variants{} ; -- 
lin directory_N = mkN "directorio" ; -- status=guess
lin receiver_N = variants{} ; -- 
lin isolation_N = mkN "aislamiento" ; -- status=guess
lin fade_V2 = mkV2 (evanescer_V) | mkV2 (desvanecer_V) ; -- status=guess
lin fade_V = evanescer_V | desvanecer_V ; -- status=guess
lin chemistry_N = mkN "química" ; -- status=guess
lin unnecessary_A = mkA "innecesario" ; -- status=guess
lin hit_N = mkN "delito de fuga" ; -- status=guess
lin defender_N = variants{} ; -- 
lin stance_N = mkN "postura" ; -- status=guess
lin sin_N = mkN "pecado" ; -- status=guess
lin realistic_A = mkA "realista" | mkA "realístico" ; -- status=guess
lin socialist_N = variants{} ; -- 
lin subsidy_N = mkN "subvención" | mkN "subsidio" ; -- status=guess
lin content_A = mkA "contento" ; -- status=guess
lin toy_N = mkN "juguete" masculine ; -- status=guess
lin darling_N = mkN "querido" | mkN "querida" | mkN "amado" | mkN "amada" ; -- status=guess
lin decent_A = mkA "decente" ; -- status=guess
lin liberty_N = mkN "libertad" feminine ; -- status=guess
lin forever_Adv = mkAdv "para siempre" ; -- status=guess
lin skirt_N = mkN "falda" | mkN "enaguas" ; -- status=guess
lin coordinate_V2 = mkV2 (mkV "coordinar") ; -- status=guess
lin coordinate_V = mkV "coordinar" ; -- status=guess
lin tactic_N = mkN "táctica" ; -- status=guess
lin influential_A = mkA "influyente" ; -- status=guess
lin import_V2 = mkV2 (mkV "importar") ; -- status=guess
lin accent_N = mkN "acento" | mkN "tilde" masculine ; -- status=guess
lin compound_N = mkN "compuesto" ; -- status=guess
lin bastard_N = mkN "desgraciado" | mkN "hijo de puta" ; -- status=guess
lin ingredient_N = mkN "ingrediente" masculine ; -- status=guess
lin dull_A = L.dull_A ;
lin cater_V = atender_V ; -- status=guess
lin scholar_N = mkN "erudito" | mkN "docto" | mkN "sabio" ; -- status=guess
lin faint_A = mkA "tenue" ; -- status=guess
lin ghost_N = mkN "fantasma" masculine | mkN "espectro" | mkN "espíritu" masculine | mkN "aparecido" | mkN "aparición" feminine | mkN "sombra" | mkN "alma" masculine ; -- status=guess
lin sculpture_N = mkN "escultura" ; -- status=guess
lin ridiculous_A = mkA "ridículo" ; -- status=guess
lin diagnosis_N = mkN "diagnóstico" | mkN "diagnosis" feminine ; -- status=guess
lin delegate_N = mkN "delegado" | mkN "delegada" ; -- status=guess
lin neat_A = mkA "puro" | mkA "pura" ; -- status=guess
lin kit_N = mkN "juego" | mkN "kit" | mkN "ensello" | mkN "equipo" ; -- status=guess
lin lion_N = mkN "león" masculine ; -- status=guess
lin dialogue_N = mkN "diálogo" ; -- status=guess
lin repair_V2 = mkV2 (mkV "reparar") ; -- status=guess
lin repair_V = mkV "reparar" ; -- status=guess
lin tray_N = mkN "bandeja" | mkN "charola " ; -- status=guess
lin fantasy_N = variants{} ; -- 
lin leave_N = mkN "permiso" ; -- status=guess
lin export_V2 = mkV2 (mkV "exportar") ; -- status=guess
lin export_V = mkV "exportar" ; -- status=guess
lin forth_Adv = variants{} ; -- 
lin lamp_N = L.lamp_N ;
lin allege_VS = mkVS (mkV "alegar") ; -- status=guess
lin allege_V2V = mkV2V (mkV "alegar") ; -- status=guess
lin allege_V2 = mkV2 (mkV "alegar") ; -- status=guess
lin pavement_N = mkN "acera" ; -- status=guess
lin brand_N = mkN "marca" masculine ; -- status=guess
lin constable_N = variants{} ; -- 
lin compromise_N = mkN "acuerdo" | mkN "arreglo" | mkN "compromiso" ; -- status=guess
lin flag_N = mkN "losa" | mkN "piedra" ; -- status=guess
lin filter_N = mkN "filtro" ; -- status=guess
lin reign_N = mkN "reinado" ; -- status=guess
lin execute_V2 = mkV2 (mkV "ejecutar") ; -- status=guess
lin pity_N = mkN "compasión" feminine | mkN "piedad" feminine | mkN "lástima" ; -- status=guess
lin merit_N = mkN "mérito" ; -- status=guess
lin diagram_N = mkN "diagrama" masculine ; -- status=guess
lin wool_N = mkN "lana" ; -- status=guess
lin organism_N = mkN "organismo" ; -- status=guess
lin elegant_A = mkA "elegante" | mkA "chic" ; -- status=guess
lin red_N = mkN "aguilucho" | mkN "aguila parda" | mkN "águila de pecho blanco" | mkN "pihuel" ; -- status=guess
lin undertaking_N = variants{} ; -- 
lin lesser_A = mkA "menor" ; -- status=guess
lin reach_N = mkN "alcance" masculine | mkN "influencia" ; -- status=guess
lin marvellous_A = variants{} ; -- 
lin improved_A = variants{} ; -- 
lin locally_Adv = variants{} ; -- 
lin entity_N = mkN "entidad" ; -- status=guess
lin rape_N = mkN "violación" feminine ; -- status=guess
lin secure_A = mkA "seguro" | mkA "aplomado" ; -- status=guess
lin descend_V2 = mkV2 (descender_V) | mkV2 (mkV "bajar") ; -- status=guess
lin descend_V = descender_V | mkV "bajar" ; -- status=guess
lin backwards_Adv = mkAdv "hacia atrás" ; -- status=guess
lin peer_V = variants{} ; -- 
lin excuse_V2 = mkV2 (mkV "excusar") | mkV2 (mkV "perdonar") ; -- status=guess
lin genetic_A = mkA "genético" ; -- status=guess
lin fold_V2 = mkV2 (plegar_V) | mkV2 (mkV "doblar") ; -- status=guess
lin fold_V = plegar_V | mkV "doblar" ; -- status=guess
lin portfolio_N = mkN "portafolio" | mkN "portafolios" masculine ; -- status=guess
lin consensus_N = mkN "consenso" ; -- status=guess
lin thesis_N = mkN "tesis" feminine ; -- status=guess
lin shop_V = mkV (mkV "ir") "de compras" ; -- status=guess
lin nest_N = mkN "nido" ; -- status=guess
lin frown_V = mkV (mkV "fruncir") "el ceño" ; -- status=guess
lin builder_N = mkN "constructor" ; -- status=guess
lin administer_V2 = mkV2 (mkV "administrar") ; -- status=guess
lin administer_V = mkV "administrar" ; -- status=guess
lin tip_V2 = mkV2 (mkV (mkV "dar") "propina") ; -- status=guess
lin tip_V = mkV (mkV "dar") "propina" ; -- status=guess
lin lung_N = mkN "pulmón" masculine ; -- status=guess
lin delegation_N = mkN "delegación" feminine ; -- status=guess
lin outside_N = mkN "exterior" masculine ; -- status=guess
lin heating_N = mkN "calefacción" feminine ; -- status=guess
lin like_Subj = variants{} ; -- 
lin instinct_N = mkN "instinto" ; -- status=guess
lin teenager_N = mkN "adolescente" masculine ; -- status=guess
lin lonely_A = mkA "solitario" ; -- status=guess
lin residence_N = mkN "residencia" ; -- status=guess
lin radiation_N = variants{} ; -- 
lin extract_V2 = mkV2 (extraer_V) | mkV2 (mkV "sacar") ; -- status=guess
lin concession_N = variants{} ; -- 
lin autonomy_N = mkN "autonomía" ; -- status=guess
lin norm_N = mkN "norma" ; -- status=guess
lin musician_N = variants{} ; -- 
lin graduate_N = mkN "graduado" | mkN "graduada" | mkN "graduados" ; -- status=guess
lin glory_N = mkN "gloria" ; -- status=guess
lin bear_N = mkN "osezno" ; -- status=guess
lin persist_V = mkV "persistir" ; -- status=guess
lin rescue_V2 = mkV2 (mkV "rescatar") ; -- status=guess
lin equip_V2 = variants{} ; -- 
lin partial_A = mkA "parcial" ; -- status=guess
lin officially_Adv = variants{} ; -- 
lin capability_N = mkN "capacidad" feminine ; -- status=guess
lin worry_N = mkN "preocupación" feminine | mkN "zozobra" ; -- status=guess
lin liberation_N = mkN "liberación" feminine ; -- status=guess
lin hunt_V2 = L.hunt_V2 ;
lin hunt_V = mkV "cazar" ; -- status=guess
lin daily_Adv = mkAdv "diariamente" | mkAdv "cotidianamente" ; -- status=guess
lin heel_N = mkN "cuscurro" | mkN "mendrugo" ; -- status=guess
lin contract_V2V = mkV2V (contraer_V) ; -- status=guess
lin contract_V2 = mkV2 (contraer_V) ; -- status=guess
lin contract_V = contraer_V ; -- status=guess
lin update_V2 = mkV2 (mkV "actualizar") ; -- status=guess
lin assign_V2V = mkV2V (mkV "asignar") ; -- status=guess
lin assign_V2 = mkV2 (mkV "asignar") ; -- status=guess
lin spring_V2 = mkV2 (mkV "saltar") ; -- status=guess
lin spring_V = mkV "saltar" ; -- status=guess
lin single_N = mkN "soltero" | mkN "soltera" ; -- status=guess
lin commons_N = mkN "Procomún" ; -- status=guess
lin weekly_A = mkA "semanal" ; -- status=guess
lin stretch_N = mkN "elasticidad" feminine ; -- status=guess
lin pregnancy_N = mkN "embarazo" ; -- status=guess
lin happily_Adv = variants{} ; -- 
lin spectrum_N = mkN "espectro" ; -- status=guess
lin interfere_V = interferir_V ; -- status=guess
lin suicide_N = mkN "hombre bomba" | mkN "terrorista suicida" ; -- status=guess
lin panic_N = mkN "pánico" ; -- status=guess
lin invent_V2 = mkV2 (mkV "inventar") ; -- status=guess
lin invent_V = mkV "inventar" ; -- status=guess
lin intensive_A = variants{} ; -- 
lin damp_A = mkA "húmedo" ; -- status=guess
lin simultaneously_Adv = variants{} ; -- 
lin giant_N = mkN "gigante" masculine ; -- status=guess
lin casual_A = mkA "deportivo" ; -- status=guess
lin sphere_N = mkN "esfera" ; -- status=guess
lin precious_A = mkA "precioso" ; -- status=guess
lin sword_N = mkN "espada" ; -- status=guess
lin envisage_V2 = mkV2 (prever_V) ; -- status=guess
lin bean_N = mkN "ánsar campestre" | mkN "ganso de las habas" ; -- status=guess
lin time_V2 = mkV2 (mkV "cronometrar") ; -- status=guess
lin crazy_A = mkA "loco" ; -- status=guess
lin changing_A = variants{} ; -- 
lin primary_N = mkN "básico" ; -- status=guess
lin concede_VS = mkVS (mkV "conceder") | mkVS (mkV "ceder") ; -- status=guess
lin concede_V2 = mkV2 (mkV "conceder") | mkV2 (mkV "ceder") ; -- status=guess
lin concede_V = mkV "conceder" | mkV "ceder" ; -- status=guess
lin besides_Adv = mkAdv "además" | mkAdv "aparte" ; -- status=guess
lin unite_V2 = mkV2 (mkV "unir") | mkV2 (mkV "juntar") | mkV2 (mkV "combinar") ; -- status=guess
lin unite_V = mkV "unir" | mkV "juntar" | mkV "combinar" ; -- status=guess
lin severely_Adv = variants{} ; -- 
lin separately_Adv = variants{} ; -- 
lin instruct_V2 = variants{} ; -- 
lin insert_V2 = mkV2 (mkV "insertar") ; -- status=guess
lin go_N = mkN "intento" ; -- status=guess
lin exhibit_V2 = mkV2 (exponer_V) ; -- status=guess
lin brave_A = mkA "valiente" ; -- status=guess
lin tutor_N = mkN "tutor" ; -- status=guess
lin tune_N = mkN "melodía" ; -- status=guess
lin debut_N = mkN "debut" ; -- status=guess
lin debut_2_N = variants{} ; -- 
lin debut_1_N = variants{} ; -- 
lin continued_A = variants{} ; -- 
lin bid_V2 = variants{} ; -- 
lin bid_V = variants{} ; -- 
lin incidence_N = variants{} ; -- 
lin downstairs_Adv = variants{} ; -- 
lin cafe_N = variants{} ; -- 
lin regret_VS = mkVS (mkV "lamentar") | mkVS (sentir_V) | mkVS (mkV "arrepentir") ; -- status=guess
lin regret_V2 = mkV2 (mkV "lamentar") | mkV2 (sentir_V) | mkV2 (mkV "arrepentir") ; -- status=guess
lin killer_N = mkN "asesino" | mkN "asesina" ; -- status=guess
lin delicate_A = mkA "delicado" ; -- status=guess
lin subsidiary_N = variants{} ; -- 
lin gender_N = mkN "sexo" | mkN "género" ; -- status=guess
lin entertain_V2 = mkV2 (divertir_V) | mkV2 (entretener_V) ; -- status=guess
lin cling_V = sostener_V | mkV "aferrarse" | mkV "sujetar" | mkV "agarrarse" ; -- status=guess
lin vertical_A = mkA "vertical" ; -- status=guess
lin fetch_V2 = mkV2 (mkV "venderse") ; -- status=guess
lin fetch_V = mkV "venderse" ; -- status=guess
lin strip_V2 = mkV2 (remover_V) ; -- status=guess
lin strip_V = remover_V ; -- status=guess
lin plead_VS = variants{} ; -- 
lin plead_VA = variants{} ; -- 
lin plead_V2 = variants{} ; -- 
lin plead_V = variants{} ; -- 
lin duck_N = mkN "cero" ; -- status=guess
lin breed_N = mkN "raza" | mkN "variedad" feminine ; -- status=guess
lin assistant_A = variants{} ; -- 
lin pint_N = mkN "pinta" ; -- status=guess
lin abolish_V2 = mkV2 (mkV "destrozar") ; -- status=guess
lin translation_N = mkN "traducción" feminine ; -- status=guess
lin princess_N = mkN "princesa" | mkN "infanta" ; -- status=guess
lin line_V2 = mkV2 (mkV (mkV "hacer") "una cola") ; -- status=guess
lin line_V = mkV (mkV "hacer") "una cola" ; -- status=guess
lin excessive_A = mkA "excesivo" ; -- status=guess
lin digital_A = mkA "digital" | mkA "dactilar" ; -- status=guess
lin steep_A = mkA "inclinado" | mkA "escarpado" | mkA "empinado" | mkA "acantilado" | mkA "precipitoso" | mkA "abrupto" ; -- status=guess
lin jet_N = mkN "jet" masculine ; -- status=guess
lin hey_Interj = mkInterj "oye" | mkInterj "hey" | mkInterj "eh" ; -- status=guess
lin grave_N = mkN "acento grave" ; -- status=guess
lin exceptional_A = mkA "excepcional" ; -- status=guess
lin boost_V2 = mkV2 (mkV "impulsar") | mkV2 (mkV "empujar") ; -- status=guess
lin random_A = mkA "aleatorio" ; -- status=guess
lin correlation_N = mkN "correlación" ; -- status=guess
lin outline_N = mkN "contorno" ; -- status=guess
lin intervene_V2V = mkV2V (intervenir_V) ; -- status=guess
lin intervene_V = intervenir_V ; -- status=guess
lin packet_N = mkN "paquete" masculine ; -- status=guess
lin motivation_N = mkN "motivación" feminine ; -- status=guess
lin safely_Adv = variants{} ; -- 
lin harsh_A = mkA "áspero" ; -- status=guess
lin spell_N = mkN "corrector ortográfico" ; -- status=guess
lin spread_N = variants{} ; -- 
lin draw_N = mkN "proyecto" ; -- status=guess
lin concrete_A = mkA "de concreto" | mkA "de hormigón" ; -- status=guess
lin complicated_A = variants{} ; -- 
lin alleged_A = variants{} ; -- 
lin redundancy_N = mkN "redundancia" ; -- status=guess
lin progressive_A = variants{} ; -- 
lin intensity_N = mkN "intensidad" ; -- status=guess
lin crack_N = mkN "rendija" ; -- status=guess
lin fly_N = mkN "vuelo" ; -- status=guess
lin fancy_V3 = variants{} ; -- 
lin fancy_V2 = variants{} ; -- 
lin alternatively_Adv = variants{} ; -- 
lin waiting_A = variants{} ; -- 
lin scandal_N = mkN "escándalo" ; -- status=guess
lin resemble_V2 = mkV2 (mkV (mkV "asemejarse") "a") | mkV2 (mkV "semejar") | mkV2 (mkV "parecerse") ; -- status=guess
lin parameter_N = mkN "parámetro" ; -- status=guess
lin fierce_A = mkA "fiero" | mkA "feroz" ; -- status=guess
lin tropical_A = mkA "tropical" ; -- status=guess
lin colour_V2A = variants{} ; -- 
lin colour_V2 = variants{} ; -- 
lin colour_V = variants{} ; -- 
lin engagement_N = mkN "anillo de compromiso" ; -- status=guess
lin contest_N = mkN "concurso" | mkN "competencia" | mkN "competición" feminine ; -- status=guess
lin edit_V2 = mkV2 (mkV "editar") ; -- status=guess
lin courage_N = mkN "valor" masculine ; -- status=guess
lin hip_N = mkN "cadera" ; -- status=guess
lin delighted_A = variants{} ; -- 
lin sponsor_V2 = mkV2 (mkV "patrocinar") ; -- status=guess
lin carer_N = variants{} ; -- 
lin crack_V2 = mkV2 (mkV "agrietarse") ; -- status=guess
lin crack_V = mkV "agrietarse" ; -- status=guess
lin substantially_Adv = variants{} ; -- 
lin occupational_A = variants{} ; -- 
lin trainer_N = mkN "entrenador" | mkN "amaestrador" masculine ; -- status=guess
lin remainder_N = mkN "saldo" ; -- status=guess
lin related_A = variants{} ; -- 
lin inherit_V2 = mkV2 (mkV "heredar") ; -- status=guess
lin inherit_V = mkV "heredar" ; -- status=guess
lin resume_VS = mkVS (mkV "reanudar") | mkVS (mkV "continuar") | mkVS (mkV "reanudarse") ; -- status=guess
lin resume_V2 = mkV2 (mkV "reanudar") | mkV2 (mkV "continuar") | mkV2 (mkV "reanudarse") ; -- status=guess
lin resume_V = mkV "reanudar" | mkV "continuar" | mkV "reanudarse" ; -- status=guess
lin assignment_N = mkN "tarea" ; -- status=guess
lin conceal_V2 = mkV2 (mkV "esconder") | mkV2 (mkV "ocultar") ; -- status=guess
lin disclose_VS = mkVS (mkV "divulgar") ; -- status=guess
lin disclose_V2 = mkV2 (mkV "divulgar") ; -- status=guess
lin disclose_V = mkV "divulgar" ; -- status=guess
lin exclusively_Adv = variants{} ; -- 
lin working_N = mkN "clase obrera" ; -- status=guess
lin mild_A = mkA "suave" | mkA "leve" ; -- status=guess
lin chronic_A = mkA "crónico" ; -- status=guess
lin splendid_A = mkA "espléndido" ; -- status=guess
lin function_V = mkV "funcionar" ; -- status=guess
lin rider_N = variants{} ; -- 
lin clay_N = mkN "arcilla" | mkN "barro" ; -- status=guess
lin firstly_Adv = variants{} ; -- 
lin conceive_V2 = mkV2 (concebir_V) ; -- status=guess
lin conceive_V = concebir_V ; -- status=guess
lin politically_Adv = variants{} ; -- 
lin terminal_N = variants{} ; -- 
lin accuracy_N = mkN "exactitud" | mkN "precisión" feminine ; -- status=guess
lin coup_N = mkN "golpe de estado" ; -- status=guess
lin ambulance_N = mkN "ambulancia" ; -- status=guess
lin living_N = mkN "muertos vivientes" | mkN "zombis" ; -- status=guess
lin offender_N = variants{} ; -- 
lin similarity_N = mkN "semejanza" | mkN "similitud" feminine ; -- status=guess
lin orchestra_N = mkN "orquesta" ; -- status=guess
lin brush_N = mkN "cepillado" ; -- status=guess
lin systematic_A = variants{} ; -- 
lin striker_N = mkN "huelguista" masculine ; -- status=guess
lin guard_V2 = mkV2 (mkV "vigilar") | mkV2 (mkV "custodiar") | mkV2 (mkV "guardar") ; -- status=guess
lin guard_V = mkV "vigilar" | mkV "custodiar" | mkV "guardar" ; -- status=guess
lin casualty_N = mkN "baja" ; -- status=guess
lin steadily_Adv = variants{} ; -- 
lin painter_N = mkN "pintor" | mkN "pintora" ; -- status=guess
lin opt_VV = variants{} ; -- 
lin opt_V2V = variants{} ; -- 
lin opt_V = variants{} ; -- 
lin handsome_A = mkA "apuesto" | mkA "guapo" ; -- status=guess
lin banking_N = variants{} ; -- 
lin sensitivity_N = mkN "sensibilidad" feminine ; -- status=guess
lin navy_N = mkN "azul marino" ; -- status=guess
lin fascinating_A = mkA "fascinante" ; -- status=guess
lin disappointment_N = mkN "decepción" feminine ; -- status=guess
lin auditor_N = mkN "auditor" | mkN "auditora" ; -- status=guess
lin hostility_N = mkN "hostilidad" feminine ; -- status=guess
lin spending_N = variants{} ; -- 
lin scarcely_Adv = variants{} ; -- 
lin compulsory_A = mkA "obligatorio" ; -- status=guess
lin photographer_N = mkN "fotógrafo" ; -- status=guess
lin ok_Interj = variants{} ; -- 
lin neighbourhood_N = mkN "vecindad" | mkN "barrio" feminine | mkN " colonia" ; -- status=guess
lin ideological_A = mkA "ideológico" ; -- status=guess
lin wide_Adv = variants{} ; -- 
lin pardon_N = mkN "perdón" masculine ; -- status=guess
lin double_N = mkN "doble" feminine ; -- status=guess
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin supervision_N = variants{} ; -- 
lin guilt_N = mkN "culpa" ; -- status=guess
lin deck_N = mkN "piso" feminine | mkN "plataforma" | mkN "balcón" masculine | mkN "terraza" ; -- status=guess
lin payable_A = variants{} ; -- 
lin execution_N = mkN "ejecución" feminine ; -- status=guess
lin suite_N = variants{} ; -- 
lin elected_A = variants{} ; -- 
lin solely_Adv = variants{} ; -- 
lin moral_N = mkN "pánico moral" ; -- status=guess
lin collector_N = mkN "coleccionista" masculine ; -- status=guess
lin questionnaire_N = mkN "cuestionario" | mkN "encuesta" ; -- status=guess
lin flavour_N = mkN "sabor" masculine ; -- status=guess
lin couple_V2 = mkV2 (mkV "acoplar") ; -- status=guess
lin couple_V = mkV "acoplar" ; -- status=guess
lin faculty_N = mkN "facultad" feminine ; -- status=guess
lin tour_V2 = mkV2 (mkV "recorrer") ; -- status=guess
lin tour_V = mkV "recorrer" ; -- status=guess
lin basket_N = mkN "canasta" ; -- status=guess
lin mention_N = mkN "mención" feminine ; -- status=guess
lin kick_N = mkN "patada" | mkN "puntapié" | mkN "coz" feminine ; -- status=guess
lin horizon_N = mkN "horizonte" masculine ; -- status=guess
lin drain_V2 = mkV2 (mkV "desaguar") ; -- status=guess
lin drain_V = mkV "desaguar" ; -- status=guess
lin happiness_N = mkN "felicidad" feminine ; -- status=guess
lin fighter_N = mkN "caza" ; -- status=guess
lin estimated_A = variants{} ; -- 
lin copper_N = mkN "cobre" masculine ; -- status=guess
lin legend_N = mkN "leyenda" ; -- status=guess
lin relevance_N = mkN "relevancia" ; -- status=guess
lin decorate_V2 = mkV2 (mkV "decorar") ; -- status=guess
lin continental_A = mkA "continental" ; -- status=guess
lin ship_V2 = mkV2 (mkV "enviar") ; -- status=guess
lin ship_V = mkV "enviar" ; -- status=guess
lin operational_A = variants{} ; -- 
lin incur_V2 = mkV2 (mkV "incurrir") ; -- status=guess
lin parallel_A = mkA "paralelo" ; -- status=guess
lin divorce_N = mkN "divorcio" ; -- status=guess
lin opposed_A = variants{} ; -- 
lin equilibrium_N = mkN "equilibrio" ; -- status=guess
lin trader_N = variants{} ; -- 
lin ton_N = mkN "tonelada" ; -- status=guess
lin can_N = mkN "regadera" ; -- status=guess
lin juice_N = mkN "jugo" | mkN "zumo" ; -- status=guess
lin forum_N = mkN "foro" ; -- status=guess
lin spin_V2 = mkV2 (mkV "hilar") ; -- status=guess
lin spin_V = mkV "hilar" ; -- status=guess
lin research_V2 = mkV2 (mkV "investigar") ; -- status=guess
lin research_V = mkV "investigar" ; -- status=guess
lin hostile_A = mkA "hostil" ; -- status=guess
lin consistently_Adv = variants{} ; -- 
lin technological_A = mkA "tecnológico" ; -- status=guess
lin nightmare_N = mkN "pesadilla" ; -- status=guess
lin medal_N = mkN "medalla" ; -- status=guess
lin diamond_N = mkN "diamante" masculine | mkN "gema" ; -- status=guess
lin speed_V2 = variants{} ; -- 
lin speed_V = variants{} ; -- 
lin peaceful_A = mkA "tranquilo" | mkA "plácido" ; -- status=guess
lin accounting_A = variants{} ; -- 
lin scatter_V2 = mkV2 (mkV "desviar") ; -- status=guess
lin scatter_V = mkV "desviar" ; -- status=guess
lin monster_N = mkN "monstruo" ; -- status=guess
lin horrible_A = mkA "horrible" | mkA "horrendo" ; -- status=guess
lin nonsense_N = mkN "tonterías" feminine | mkN "disparate" masculine ; -- status=guess
lin chaos_N = mkN "caos" masculine ; -- status=guess
lin accessible_A = mkA "accesible" | mkA "asequible" ; -- status=guess
lin humanity_N = mkN "humanidad" feminine ; -- status=guess
lin frustration_N = mkN "frustración" feminine ; -- status=guess
lin chin_N = mkN "barbilla" | mkN "mentón" masculine | mkN "pera" ; -- status=guess
lin bureau_N = mkN "cómoda" ; -- status=guess
lin advocate_VS = mkVS (recomendar_V) ; -- status=guess
lin advocate_V2 = mkV2 (recomendar_V) ; -- status=guess
lin polytechnic_N = mkN "politécnica" ; -- status=guess
lin inhabitant_N = mkN "habitante" | mkN "residente" | mkN "lugareño" ; -- status=guess
lin evil_A = mkA "mal" | mkA "malo" | mkA "malvado" | mkA "malévolo" | mkA "maléfico" | mkA "malvado" | mkA "perverso" ; -- status=guess
lin slave_N = mkN "esclava" ; -- status=guess
lin reservation_N = mkN "reserva" | mkN "reservación" feminine ; -- status=guess
lin slam_V2 = variants{} ; -- 
lin slam_V = variants{} ; -- 
lin handle_N = mkN "asa" ; -- status=guess
lin provincial_A = mkA "provincial" ; -- status=guess
lin fishing_N = mkN "barco pesquero" ; -- status=guess
lin facilitate_V2 = mkV2 (mkV "facilitar") ; -- status=guess
lin yield_N = mkN "rendimiento" ; -- status=guess
lin elbow_N = mkN "codo" ; -- status=guess
lin bye_Interj = mkInterj "adiós" | mkInterj "chau" | mkInterj "chao" ; -- status=guess
lin warm_V2 = mkV2 (calentar_V) ; -- status=guess
lin warm_V = calentar_V ; -- status=guess
lin sleeve_N = mkN "funda" ; -- status=guess
lin exploration_N = mkN "exploración" feminine ; -- status=guess
lin creep_V = variants{} ; -- 
lin adjacent_A = mkA "adyacente" | mkA "colindante" | mkA "contiguo" ; -- status=guess
lin theft_N = mkN "robo" | mkN "hurto" ; -- status=guess
lin round_V2 = mkV2 (mkV "redondear") ; -- status=guess
lin round_V = mkV "redondear" ; -- status=guess
lin grace_N = mkN "gracia" ; -- status=guess
lin predecessor_N = mkN "predecesor" masculine | mkN "antecesor" masculine ; -- status=guess
lin supermarket_N = mkN "supermercado" ; -- status=guess
lin smart_A = mkA "listo" | mkA "intelectual" ; -- status=guess
lin sergeant_N = mkN "sargento" ; -- status=guess
lin regulate_V2 = mkV2 (mkV "regular") ; -- status=guess
lin clash_N = mkN "colision" ; -- status=guess
lin assemble_V2 = mkV2 (reunir_V) | mkV2 (mkV "juntar") ; -- status=guess
lin assemble_V = reunir_V | mkV "juntar" ; -- status=guess
lin arrow_N = mkN "flecha" ; -- status=guess
lin nowadays_Adv = mkAdv "actualmente" ; -- status=guess
lin giant_A = variants{} ; -- 
lin waiting_N = variants{} ; -- 
lin tap_N = mkN "machuelo" ; -- status=guess
lin shit_N = mkN "cagón" | mkN "cagóncito" ; -- status=guess
lin sandwich_N = mkN "sándwich" | mkN "bocadillo" ; -- status=guess
lin vanish_V = mkV "desvanecerse" | desaparecer_V ; -- status=guess
lin commerce_N = mkN "comercio" ; -- status=guess
lin pursuit_N = mkN "persecución" feminine ; -- status=guess
lin post_war_A = variants{} ; -- 
lin will_V2 = mkV2 (mkV "legar") ; -- status=guess
lin will_V = mkV "legar" ; -- status=guess
lin waste_A = variants{} ; -- 
lin collar_N = mkN "collar" masculine ; -- status=guess
lin socialism_N = mkN "socialismo" ; -- status=guess
lin skill_V = variants{} ; -- 
lin rice_N = mkN "leche de arroz" ; -- status=guess
lin exclusion_N = variants{} ; -- 
lin upwards_Adv = variants{} ; -- 
lin transmission_N = mkN "caja de cambios" ; -- status=guess
lin instantly_Adv = variants{} ; -- 
lin forthcoming_A = variants{} ; -- 
lin appointed_A = variants{} ; -- 
lin geographical_A = variants{} ; -- 
lin fist_N = mkN "puño" ; -- status=guess
lin abstract_A = mkA "abstracto" ; -- status=guess
lin embrace_V2 = mkV2 (mkV "abrazar") ; -- status=guess
lin embrace_V = mkV "abrazar" ; -- status=guess
lin dynamic_A = mkA "dinámico" ; -- status=guess
lin drawer_N = mkN "cajón" masculine ; -- status=guess
lin dismissal_N = variants{} ; -- 
lin magic_N = mkN "magia" ; -- status=guess
lin endless_A = mkA "interminable" | mkA "sin fin" | mkA "infinito" ; -- status=guess
lin definite_A = mkA "indudable" ; -- status=guess
lin broadly_Adv = variants{} ; -- 
lin affection_N = mkN "cariño" ; -- status=guess
lin dawn_N = mkN "alba" | mkN "amanecer" masculine | mkN "aurora" | mkN "madrugada" ; -- status=guess
lin principal_N = mkN "director" masculine | mkN "principal de escuela" | mkN "jefe de estudios" ; -- status=guess
lin bloke_N = mkN "tío" | mkN "tipo" ; -- status=guess
lin trap_N = mkN "sifón" masculine ; -- status=guess
lin communist_A = mkA "comunista" ; -- status=guess
lin competence_N = variants{} ; -- 
lin complicate_V2 = mkV2 (mkV "complicar") ; -- status=guess
lin neutral_A = mkA "neutral" ; -- status=guess
lin fortunately_Adv = variants{} ; -- 
lin commonwealth_N = mkN "comunidad" feminine | mkN "mancomunidad" feminine ; -- status=guess
lin breakdown_N = mkN "avería" | mkN "pana" ; -- status=guess
lin combined_A = variants{} ; -- 
lin candle_N = mkN "vela" | mkN "candela" | mkN "cirio" ; -- status=guess
lin venue_N = variants{} ; -- 
lin supper_N = mkN "cena" ; -- status=guess
lin analyst_N = mkN "analista" masculine ; -- status=guess
lin vague_A = mkA "vago" | mkA "impreciso" ; -- status=guess
lin publicly_Adv = variants{} ; -- 
lin marine_A = mkA "marítimo" | mkA "marino" ; -- status=guess
lin fair_Adv = variants{} ; -- 
lin pause_N = mkN "pausa" ; -- status=guess
lin notable_A = mkA "notable" | mkA "destacable" ; -- status=guess
lin freely_Adv = variants{} ; -- 
lin counterpart_N = mkN "homólogo" | mkN "homóloga" ; -- status=guess
lin lively_A = mkA "burbujeante" | mkA "espumosa" ; -- status=guess
lin script_N = mkN "escritura" ; -- status=guess
lin sue_V2V = mkV2V (mkV "demandar") ; -- status=guess
lin sue_V2 = mkV2 (mkV "demandar") ; -- status=guess
lin sue_V = mkV "demandar" ; -- status=guess
lin legitimate_A = variants{} ; -- 
lin geography_N = mkN "geografía" ; -- status=guess
lin reproduce_V2 = mkV2 (mkV "proliferar") | mkV2 (mkV "reproducirse") | mkV2 (mkV "procrear") ; -- status=guess
lin reproduce_V = mkV "proliferar" | mkV "reproducirse" | mkV "procrear" ; -- status=guess
lin moving_A = variants{} ; -- 
lin lamb_N = mkN "cordero" ; -- status=guess
lin gay_A = mkA "amujerado" | mkA "afeminado" ; -- status=guess
lin contemplate_VS = mkVS (mkV "contemplar") ; -- status=guess
lin contemplate_V2 = mkV2 (mkV "contemplar") ; -- status=guess
lin contemplate_V = mkV "contemplar" ; -- status=guess
lin terror_N = mkN "terror" masculine ; -- status=guess
lin stable_N = mkN "establo" | mkN "caballeriza" ; -- status=guess
lin founder_N = mkN "fundador" masculine ; -- status=guess
lin utility_N = mkN "proveedor de servicios" ; -- status=guess
lin signal_VS = mkVS (mkV "señalar") ; -- status=guess
lin signal_V2 = mkV2 (mkV "señalar") ; -- status=guess
lin signal_V = mkV "señalar" ; -- status=guess
lin shelter_N = mkN "refugio" ; -- status=guess
lin poster_N = mkN "cartel" masculine ; -- status=guess
lin hitherto_Adv = mkAdv "hasta ahora" | mkAdv "hasta aquí" | mkAdv "hasta este momento" | mkAdv "en ese entonces" ; -- status=guess
lin mature_A = mkA "maduro" ; -- status=guess
lin cooking_N = variants{} ; -- 
lin head_A = variants{} ; -- 
lin wealthy_A = mkA "adinerado" | mkA "rico" | mkA "próspero" | mkA "acomodado" ; -- status=guess
lin fucking_A = variants{} ; -- 
lin confess_VS = variants{} ; -- 
lin confess_V2 = variants{} ; -- 
lin confess_V = variants{} ; -- 
lin age_V2 = mkV2 (mkV "envejecerse") ; -- status=guess
lin age_V = mkV "envejecerse" ; -- status=guess
lin miracle_N = mkN "milagro" ; -- status=guess
lin magic_A = mkA "mágico" ; -- status=guess
lin jaw_N = mkN "mandíbula" ; -- status=guess
lin pan_N = mkN "panarabismo" ; -- status=guess
lin coloured_A = variants{} ; -- 
lin tent_N = mkN "tienda" | mkN "toldo" | mkN "carpa" ; -- status=guess
lin telephone_V2 = mkV2 (mkV "telefonear") | mkV2 (mkV (mkV "llamar") "por teléfono") ; -- status=guess
lin telephone_V = mkV "telefonear" | mkV (mkV "llamar") "por teléfono" ; -- status=guess
lin reduced_A = variants{} ; -- 
lin tumour_N = variants{} ; -- 
lin super_A = mkA "súper" ; -- status=guess
lin funding_N = variants{} ; -- 
lin dump_V2 = mkV2 (mkV (mkV "volcar") "en memoria") ; -- status=guess
lin dump_V = mkV (mkV "volcar") "en memoria" ; -- status=guess
lin stitch_N = mkN "puntada" ; -- status=guess
lin shared_A = variants{} ; -- 
lin ladder_N = mkN "escalera" ; -- status=guess
lin keeper_N = mkN "guardián" masculine | mkN "custodio" ; -- status=guess
lin endorse_V2 = mkV2 (mkV "endosar") ; -- status=guess
lin invariably_Adv = variants{} ; -- 
lin smash_V2 = mkV2 (mkV "golpear") | mkV2 (mkV "machucar") ; -- status=guess
lin smash_V = mkV "golpear" | mkV "machucar" ; -- status=guess
lin shield_N = mkN "escudo" ; -- status=guess
lin heat_V2 = mkV2 (calentar_V) | mkV2 (mkV "excitar") | mkV2 (mkV "estimular") | mkV2 (mkV "cachondear") ; -- status=guess
lin heat_V = calentar_V | mkV "excitar" | mkV "estimular" | mkV "cachondear" ; -- status=guess
lin surgeon_N = mkN "cirujano" | mkN "cirujana" ; -- status=guess
lin centre_V2 = variants{} ; -- 
lin centre_V = variants{} ; -- 
lin orange_N = variants{} ; -- 
lin orange_2_N = variants{} ; -- 
lin orange_1_N = variants{} ; -- 
lin explode_V2 = mkV2 (mkV "explosionar") | mkV2 (mkV "explotar") | mkV2 (reventar_V) ; -- status=guess
lin explode_V = mkV "explosionar" | mkV "explotar" | reventar_V ; -- status=guess
lin comedy_N = mkN "comedia" ; -- status=guess
lin classify_V2 = mkV2 (mkV "clasificar") ; -- status=guess
lin artistic_A = mkA "artístico" ; -- status=guess
lin ruler_N = mkN "regla" ; -- status=guess
lin biscuit_N = mkN "galleta" ; -- status=guess
lin workstation_N = mkN "estación de trabajo" ; -- status=guess
lin prey_N = mkN "botín" masculine ; -- status=guess
lin manual_N = mkN "manual" masculine ; -- status=guess
lin cure_N = variants{} ; -- 
lin cure_2_N = variants{} ; -- 
lin cure_1_N = variants{} ; -- 
lin overall_N = mkN "braga" | mkN "mono" ; -- status=guess
lin tighten_V2 = mkV2 (mkV "tensarse") ; -- status=guess
lin tighten_V = mkV "tensarse" ; -- status=guess
lin tax_V2 = variants{} ; -- 
lin pope_N = mkN "Papa" masculine ; -- status=guess
lin manufacturing_A = variants{} ; -- 
lin adult_A = mkA "adulto" ; -- status=guess
lin rush_N = mkN "hora punta" ; -- status=guess
lin blanket_N = mkN "manta" ; -- status=guess
lin republican_N = variants{} ; -- 
lin referendum_N = mkN "referéndum" masculine ; -- status=guess
lin palm_N = mkN "palma" | mkN "palma de la mano" ; -- status=guess
lin nearby_Adv = mkAdv "cerca" ; -- status=guess
lin mix_N = mkN "mezcla" ; -- status=guess
lin devil_N = mkN "diablo" ; -- status=guess
lin adoption_N = mkN "adopción" feminine ; -- status=guess
lin workforce_N = variants{} ; -- 
lin segment_N = mkN "segmento" ; -- status=guess
lin regardless_Adv = variants{} ; -- 
lin contractor_N = mkN "contratista" masculine ; -- status=guess
lin portion_N = mkN "porción" | mkN "ración" feminine ; -- status=guess
lin differently_Adv = variants{} ; -- 
lin deposit_V2 = mkV2 (mkV "depositar") ; -- status=guess
lin cook_N = mkN "cocinero" | mkN "cocinera" ; -- status=guess
lin prediction_N = mkN "predicción" feminine ; -- status=guess
lin oven_N = mkN "horno" ; -- status=guess
lin matrix_N = mkN "matriz" feminine ; -- status=guess
lin liver_N = L.liver_N ;
lin fraud_N = mkN "fraude" masculine ; -- status=guess
lin beam_N = mkN "viga" ; -- status=guess
lin signature_N = mkN "firma" ; -- status=guess
lin limb_N = mkN "miembro" | mkN "extremidad" feminine ; -- status=guess
lin verdict_N = mkN "veredicto" ; -- status=guess
lin dramatically_Adv = mkAdv "dramáticamente" ; -- status=guess
lin container_N = mkN "contenedor" masculine ; -- status=guess
lin aunt_N = mkN "tía" ; -- status=guess
lin dock_N = mkN "acoplamiento" ; -- status=guess
lin submission_N = variants{} ; -- 
lin arm_V2 = mkV2 (mkV "armar") ; -- status=guess
lin arm_V = mkV "armar" ; -- status=guess
lin odd_N = variants{} ; -- 
lin certainty_N = mkN "certeza" ; -- status=guess
lin boring_A = mkA "aburrido" ; -- status=guess
lin electron_N = mkN "electrón" masculine ; -- status=guess
lin drum_N = mkN "barril" masculine | mkN "bidón" masculine ; -- status=guess
lin wisdom_N = mkN "sabiduría" ; -- status=guess
lin antibody_N = mkN "anticuerpo" ; -- status=guess
lin unlike_A = variants{} ; -- 
lin terrorist_N = mkN "terrorista" masculine ; -- status=guess
lin post_V2 = variants{} ; -- 
lin post_V = variants{} ; -- 
lin circulation_N = mkN "circulación" feminine ; -- status=guess
lin alteration_N = mkN "alteración" | mkN "cambio" | mkN "modificación" feminine ; -- status=guess
lin fluid_N = mkN "fluido" ; -- status=guess
lin ambitious_A = mkA "ambicioso" ; -- status=guess
lin socially_Adv = variants{} ; -- 
lin riot_N = mkN "tumulto" | mkN "alboroto" ; -- status=guess
lin petition_N = variants{} ; -- 
lin fox_N = mkN "zorro" | mkN "zorra" ; -- status=guess
lin recruitment_N = mkN "reclutamiento" ; -- status=guess
lin well_known_A = variants{} ; -- 
lin top_V2 = mkV2 (mkV (mkV "ser") "exitoso") | mkV2 (mkV (mkV "ser") "un éxito") | mkV2 (rendir_V) | mkV2 (sobresalir_V) | mkV2 (mkV "rematar") ; -- status=guess
lin service_V2 = mkV2 (servir_V) ; -- status=guess
lin flood_V2 = variants{} ; -- 
lin flood_V = variants{} ; -- 
lin taste_V2 = mkV2 (mkV "gustar") | mkV2 (probar_V) | mkV2 (mkV "catar") ; -- status=guess
lin taste_V = mkV "gustar" | probar_V | mkV "catar" ; -- status=guess
lin memorial_N = variants{} ; -- 
lin helicopter_N = mkN "helicóptero" | mkN "autogiro" ; -- status=guess
lin correspondence_N = variants{} ; -- 
lin beef_N = mkN "vacuno" ; -- status=guess
lin overall_Adv = variants{} ; -- 
lin lighting_N = variants{} ; -- 
lin harbour_N = L.harbour_N ;
lin empirical_A = mkA "empírico" ; -- status=guess
lin shallow_A = mkA "superficial" ; -- status=guess
lin seal_V2A = variants{} ; -- 
lin seal_V2 = variants{} ; -- 
lin seal_V = variants{} ; -- 
lin decrease_V2 = mkV2 (disminuir_V) ; -- status=guess
lin decrease_V = disminuir_V ; -- status=guess
lin constituent_N = variants{} ; -- 
lin exam_N = variants{} ; -- 
lin toe_N = mkN "dedo del pie" ; -- status=guess
lin reward_V2 = mkV2 (mkV "recompensar") ; -- status=guess
lin thrust_V2 = mkV2 (asestar_V) | mkV2 (forzar_V) ; -- status=guess
lin thrust_V = asestar_V | forzar_V ; -- status=guess
lin bureaucracy_N = mkN "burocracia" ; -- status=guess
lin wrist_N = mkN "muñeca" ; -- status=guess
lin nut_N = mkN "nuez" feminine | mkN "fruta seca" ; -- status=guess
lin plain_N = mkN "llanura" | mkN "planicie" feminine ; -- status=guess
lin magnetic_A = mkA "magnético" ; -- status=guess
lin evil_N = mkN "mal" masculine ; -- status=guess
lin widen_V2 = variants{} ; -- 
lin widen_V = variants{} ; -- 
lin hazard_N = mkN "riesgo" ; -- status=guess
lin dispose_V2 = mkV2 (mkV "deshacerse") ; -- status=guess
lin dispose_V = mkV "deshacerse" ; -- status=guess
lin dealing_N = variants{} ; -- 
lin absent_A = mkA "ausente" ; -- status=guess
lin reassure_V2S = mkV2S (mkV "tranquilizar") ; -- status=guess
lin reassure_V2 = mkV2 (mkV "tranquilizar") ; -- status=guess
lin model_V2 = mkV2 (mkV "modelar") ; -- status=guess
lin model_V = mkV "modelar" ; -- status=guess
lin inn_N = mkN "posada" ; -- status=guess
lin initial_N = variants{} ; -- 
lin suspension_N = mkN "suspensión" feminine ; -- status=guess
lin respondent_N = variants{} ; -- 
lin over_N = variants{} ; -- 
lin naval_A = mkA "naval" ; -- status=guess
lin monthly_A = mkA "mensual" ; -- status=guess
lin log_N = mkN "leño" ; -- status=guess
lin advisory_A = mkA "consultivo" ; -- status=guess
lin fitness_N = mkN "capacidad" feminine | mkN "nivel físico" ; -- status=guess
lin blank_A = mkA "blanco" ; -- status=guess
lin indirect_A = mkA "indirecto" ; -- status=guess
lin tile_N = mkN "azulejo" | mkN "alicatado" | mkN "baldosa" | mkN "teja" ; -- status=guess
lin rally_N = mkN "concentración" feminine ; -- status=guess
lin economist_N = mkN "economista" masculine ; -- status=guess
lin vein_N = mkN "vena" ; -- status=guess
lin strand_N = mkN "playa" ; -- status=guess
lin disturbance_N = mkN "disturbio" | mkN "estorbo" | mkN "perturbación" feminine ; -- status=guess
lin stuff_V2 = mkV2 (mkV "disecar") ; -- status=guess
lin seldom_Adv = mkAdv "raramente" | mkAdv "rara vez" ; -- status=guess
lin coming_A = variants{} ; -- 
lin cab_N = variants{} ; -- 
lin grandfather_N = mkN "reloj de pie" | mkN "reloj de pared" ; -- status=guess
lin flash_V2 = variants{} ; -- 
lin flash_V = variants{} ; -- 
lin destination_N = mkN "destino" ; -- status=guess
lin actively_Adv = variants{} ; -- 
lin regiment_N = mkN "regimiento" ; -- status=guess
lin closed_A = variants{} ; -- 
lin boom_N = mkN "bum" masculine ; -- status=guess
lin handful_N = mkN "manojo" | mkN "puñado" ; -- status=guess
lin remarkably_Adv = variants{} ; -- 
lin encouragement_N = mkN "apoyo" ; -- status=guess
lin awkward_A = mkA "torpe" | mkA "desmañado" ; -- status=guess
lin required_A = variants{} ; -- 
lin flood_N = mkN "diluvio" ; -- status=guess
lin defect_N = mkN "falla" | mkN "tacha" | mkN "defecto" ; -- status=guess
lin surplus_N = mkN "sobra" ; -- status=guess
lin champagne_N = mkN "champaña" | mkN "champán" masculine ; -- status=guess
lin liquid_N = mkN "líquido" ; -- status=guess
lin shed_V2 = mkV2 (mkV "derramar") ; -- status=guess
lin welcome_N = mkN "acogida" | mkN "bienvenida" ; -- status=guess
lin rejection_N = mkN "rechazo" ; -- status=guess
lin discipline_V2 = variants{} ; -- 
lin halt_V2 = mkV2 (mkV "parar") ; -- status=guess
lin halt_V = mkV "parar" ; -- status=guess
lin electronics_N = mkN "electrónica" ; -- status=guess
lin administrator_N = variants{} ; -- 
lin sentence_V2 = mkV2 (mkV "sentenciar") | mkV2 (mkV "condenar") ; -- status=guess
lin sentence_V = mkV "sentenciar" | mkV "condenar" ; -- status=guess
lin ill_Adv = mkAdv "mal" ; -- status=guess
lin contradiction_N = mkN "contradicción" feminine ; -- status=guess
lin nail_N = mkN "cortaúñas" ; -- status=guess
lin senior_N = mkN "señor" masculine ; -- status=guess
lin lacking_A = variants{} ; -- 
lin colonial_A = mkA "colonial" ; -- status=guess
lin primitive_A = mkA "primitivo" ; -- status=guess
lin whoever_NP = variants{} ; -- 
lin lap_N = mkN "vuelta" ; -- status=guess
lin commodity_N = mkN "bien" masculine | mkN "artículo de consumo" ; -- status=guess
lin planned_A = variants{} ; -- 
lin intellectual_N = mkN "propiedad intelectual" ; -- status=guess
lin imprisonment_N = mkN "encarcelamiento" ; -- status=guess
lin coincide_V = mkV "coincidir" ; -- status=guess
lin sympathetic_A = mkA "compasivo" | mkA "comprensivo" | mkA "amable" ; -- status=guess
lin atom_N = mkN "átomo" ; -- status=guess
lin tempt_V2V = mkV2V (tentar_V) ; -- status=guess
lin tempt_V2 = mkV2 (tentar_V) ; -- status=guess
lin sanction_N = variants{} ; -- 
lin praise_V2 = mkV2 (mkV "alabar") ; -- status=guess
lin favourable_A = variants{} ; -- 
lin dissolve_V2 = mkV2 (disolver_V) ; -- status=guess
lin dissolve_V = disolver_V ; -- status=guess
lin tightly_Adv = variants{} ; -- 
lin surrounding_N = variants{} ; -- 
lin soup_N = mkN "sopa" | mkN "caldo" ; -- status=guess
lin encounter_N = variants{} ; -- 
lin abortion_N = mkN "aborto" ; -- status=guess
lin grasp_V2 = mkV2 (mkV "agarrar") | mkV2 (asir_V) ; -- status=guess
lin grasp_V = mkV "agarrar" | asir_V ; -- status=guess
lin custody_N = mkN "custodia" | mkN "tutela" ; -- status=guess
lin composer_N = mkN "compositor" | mkN "compositora" ; -- status=guess
lin charm_N = mkN "encanto" ; -- status=guess
lin short_term_A = variants{} ; -- 
lin metropolitan_A = mkA "metropolitano" ; -- status=guess
lin waist_N = mkN "cintura" ; -- status=guess
lin equality_N = mkN "igualdad" | mkN "equidad" feminine ; -- status=guess
lin tribute_N = mkN "tributo" ; -- status=guess
lin bearing_N = mkN "rodamiento" | mkN " balero" | mkN "cojinete" masculine ; -- status=guess
lin auction_N = mkN "subasta" | mkN "remate" ; -- status=guess
lin standing_N = variants{} ; -- 
lin manufacture_N = variants{} ; -- 
lin horn_N = L.horn_N ;
lin barn_N = mkN "granero" | mkN "establo" | mkN "galpón" masculine ; -- status=guess
lin mayor_N = mkN "alcalde" | mkN "intendente" ; -- status=guess
lin emperor_N = mkN "emperador" masculine ; -- status=guess
lin rescue_N = mkN "rescate" masculine ; -- status=guess
lin integrated_A = variants{} ; -- 
lin conscience_N = mkN "conciencia" ; -- status=guess
lin commence_V2 = mkV2 (comenzar_V) ; -- status=guess
lin commence_V = comenzar_V ; -- status=guess
lin grandmother_N = mkN "abuela" ; -- status=guess
lin discharge_V2 = mkV2 (mkV "cumplir") | mkV2 (mkV "completar") ; -- status=guess
lin discharge_V = mkV "cumplir" | mkV "completar" ; -- status=guess
lin profound_A = mkA "profundo" ; -- status=guess
lin takeover_N = variants{} ; -- 
lin nationalist_N = mkN "nacionalista" masculine ; -- status=guess
lin effect_V2 = mkV2 (mkV "efectuar") ; -- status=guess
lin dolphin_N = mkN "delfín" masculine ; -- status=guess
lin fortnight_N = variants{} ; -- 
lin elephant_N = mkN "elefante" masculine ; -- status=guess
lin seal_N = mkN "sello" ; -- status=guess
lin spoil_V2 = mkV2 (mkV "agriar") | mkV2 (mkV "descomponerse") | mkV2 (mkV (mkV "echarse") "a perder") ; -- status=guess
lin spoil_V = mkV "agriar" | mkV "descomponerse" | mkV (mkV "echarse") "a perder" ; -- status=guess
lin plea_N = mkN "alegato" ; -- status=guess
lin forwards_Adv = variants{} ; -- 
lin breeze_N = mkN "brisa" ; -- status=guess
lin prevention_N = mkN "prevención" feminine ; -- status=guess
lin mineral_N = mkN "mineral" masculine ; -- status=guess
lin runner_N = mkN "corredor" masculine ; -- status=guess
lin pin_V2 = mkV2 (mkV "clavar") ; -- status=guess
lin integrity_N = mkN "integridad" feminine ; -- status=guess
lin thereafter_Adv = variants{} ; -- 
lin quid_N = variants{} ; -- 
lin owl_N = mkN "búho" | mkN "lechuza" ; -- status=guess
lin rigid_A = mkA "rígido" ; -- status=guess
lin orange_A = mkA "anaranjado" | mkA "naranja" ; -- status=guess
lin draft_V2 = mkV2 (mkV "reclutar") ; -- status=guess
lin reportedly_Adv = variants{} ; -- 
lin hedge_N = mkN "seto" | mkN "seto vivo" | mkN "cerco vivo" ; -- status=guess
lin formulate_V2 = mkV2 (mkV "formular") ; -- status=guess
lin associated_A = variants{} ; -- 
lin position_V2V = variants{} ; -- 
lin position_V2 = variants{} ; -- 
lin thief_N = mkN "ladrón" masculine ; -- status=guess
lin tomato_N = mkN "tomate" masculine ; -- status=guess
lin exhaust_V2 = mkV2 (mkV "agotar") ; -- status=guess
lin evidently_Adv = variants{} ; -- 
lin eagle_N = mkN "águila" ; -- status=guess
lin specified_A = variants{} ; -- 
lin resulting_A = variants{} ; -- 
lin blade_N = mkN "hoja" | mkN "lámina" | mkN "limbo" ; -- status=guess
lin peculiar_A = mkA "peculiar" | mkA "específico" ; -- status=guess
lin killing_N = variants{} ; -- 
lin desktop_N = mkN "escritorio" ; -- status=guess
lin bowel_N = mkN "entrañas" feminine ; -- status=guess
lin long_V = mkV "desear" | mkV "anhelar" ; -- status=guess
lin ugly_A = L.ugly_A ;
lin expedition_N = mkN "expedición" feminine ; -- status=guess
lin saint_N = mkN "santo" | mkN "santa" ; -- status=guess
lin variable_A = mkA "variable" ; -- status=guess
lin supplement_V2 = variants{} ; -- 
lin stamp_N = mkN "estampado" ; -- status=guess
lin slide_N = mkN "deslizamiento" ; -- status=guess
lin faction_N = mkN "facción" feminine ; -- status=guess
lin enthusiastic_A = mkA "entusiasmado" | mkA "entusiástico" ; -- status=guess
lin enquire_V2 = variants{} ; -- 
lin enquire_V = variants{} ; -- 
lin brass_N = mkN "latón" masculine ; -- status=guess
lin inequality_N = mkN "inecuación" feminine ; -- status=guess
lin eager_A = mkA "impaciente" | mkA "ilusionado" | mkA "entusiasmado" | mkA "ávido" | mkA "anhelante" ; -- status=guess
lin bold_A = mkA "audaz" | mkA "intrépido" | mkA "atrevido" ; -- status=guess
lin neglect_V2 = mkV2 (mkV "descuidar") ; -- status=guess
lin saying_N = mkN "dicho" | mkN "proverbio" | mkN "refrán" masculine ; -- status=guess
lin ridge_N = mkN "cordillera" | mkN "sierra" ; -- status=guess
lin earl_N = mkN "conde" masculine ; -- status=guess
lin yacht_N = mkN "yate" masculine ; -- status=guess
lin suck_V2 = L.suck_V2 ;
lin suck_V = mkV "chupar" | mkV "sorber" ; -- status=guess
lin missing_A = variants{} ; -- 
lin extended_A = variants{} ; -- 
lin valuation_N = variants{} ; -- 
lin delight_VS = mkVS (mkV "regocijar") | mkVS (complacer_V) ; -- status=guess
lin delight_V2 = mkV2 (mkV "regocijar") | mkV2 (complacer_V) ; -- status=guess
lin delight_V = mkV "regocijar" | complacer_V ; -- status=guess
lin beat_N = variants{} ; -- 
lin worship_N = mkN "adoración" feminine ; -- status=guess
lin fossil_N = mkN "fósil" masculine ; -- status=guess
lin diminish_V2 = mkV2 (disminuir_V) ; -- status=guess
lin diminish_V = disminuir_V ; -- status=guess
lin taxpayer_N = mkN "contribuyente de impuestos" ; -- status=guess
lin corruption_N = mkN "corrupción" feminine ; -- status=guess
lin accurately_Adv = variants{} ; -- 
lin honour_V2 = mkV2 (mkV "honrar") ; -- status=guess
lin depict_V2 = mkV2 (mkV "representar") ; -- status=guess
lin pencil_N = mkN "lápiz" masculine ; -- status=guess
lin drown_V2 = mkV2 (mkV "ahogarse") ; -- status=guess
lin drown_V = mkV "ahogarse" ; -- status=guess
lin stem_N = mkN "tallo" ; -- status=guess
lin lump_N = mkN "terrón" masculine ; -- status=guess
lin applicable_A = mkA "aplicable" | mkA "pertinente" ; -- status=guess
lin rate_VS = variants{} ; -- 
lin rate_VA = variants{} ; -- 
lin rate_V2 = variants{} ; -- 
lin rate_V = variants{} ; -- 
lin mobility_N = variants{} ; -- 
lin immense_A = mkA "inmenso" ; -- status=guess
lin goodness_N = mkN "bondad" feminine ; -- status=guess
lin price_V2V = variants{} ; -- 
lin price_V2 = variants{} ; -- 
lin price_V = variants{} ; -- 
lin preliminary_A = variants{} ; -- 
lin graph_N = mkN "grafo" ; -- status=guess
lin referee_N = mkN "árbitro" | mkN "revisor" masculine ; -- status=guess
lin calm_A = mkA "calmado" ; -- status=guess
lin onwards_Adv = variants{} ; -- 
lin omit_V2 = mkV2 (mkV "omitir") | mkV2 (mkV (mkV "dejar") "de lado") ; -- status=guess
lin genuinely_Adv = variants{} ; -- 
lin excite_V2 = mkV2 (mkV "excitar") ; -- status=guess
lin dreadful_A = variants{} ; -- 
lin cave_N = mkN "cueva" ; -- status=guess
lin revelation_N = mkN "revelación" feminine ; -- status=guess
lin grief_N = mkN "pesar" | mkN "dolor" masculine ; -- status=guess
lin erect_V2 = variants{} ; -- 
lin tuck_V2 = mkV2 (mkV "meter") ; -- status=guess
lin tuck_V = mkV "meter" ; -- status=guess
lin meantime_N = mkN "entretanto" ; -- status=guess
lin barrel_N = mkN "cañón" masculine ; -- status=guess
lin lawn_N = mkN "césped" masculine ; -- status=guess
lin hut_N = mkN "choza" ; -- status=guess
lin swing_N = mkN "columpio" ; -- status=guess
lin subject_V2 = mkV2 (mkV "someter") ; -- status=guess
lin ruin_V2 = mkV2 (mkV "desbaratar") | mkV2 (mkV "arruinar") ; -- status=guess
lin slice_N = mkN "rebanada" ; -- status=guess
lin transmit_V2 = mkV2 (mkV "transmitir") ; -- status=guess
lin thigh_N = mkN "muslo" ; -- status=guess
lin practically_Adv = variants{} ; -- 
lin dedicate_V2 = variants{} ; -- 
lin mistake_V2 = mkV2 (mkV (mkV "entender") "mal") ; -- status=guess
lin mistake_V = mkV (mkV "entender") "mal" ; -- status=guess
lin corresponding_A = variants{} ; -- 
lin albeit_Subj = variants{} ; -- 
lin sound_A = mkA "sano" ; -- status=guess
lin nurse_V2 = variants{} ; -- 
lin discharge_N = mkN "caudal" masculine ; -- status=guess
lin comparative_A = mkA "comparativo" ; -- status=guess
lin cluster_N = mkN "bomba de racimo" ; -- status=guess
lin propose_VV = mkVV (mkV (mkV "pedir") "la mano") ; -- status=guess
lin propose_VS = mkVS (mkV (mkV "pedir") "la mano") ; -- status=guess
lin propose_V2 = mkV2 (mkV (mkV "pedir") "la mano") ; -- status=guess
lin propose_V = mkV (mkV "pedir") "la mano" ; -- status=guess
lin obstacle_N = mkN "obstáculo" ; -- status=guess
lin motorway_N = variants{} ; -- 
lin heritage_N = mkN "herencia" ; -- status=guess
lin counselling_N = variants{} ; -- 
lin breeding_N = variants{} ; -- 
lin characteristic_A = mkA "característico" ; -- status=guess
lin bucket_N = mkN "balde" ; -- status=guess
lin migration_N = mkN "migración" feminine ; -- status=guess
lin campaign_V = variants{} ; -- 
lin ritual_N = mkN "ritual" masculine ; -- status=guess
lin originate_V2 = mkV2 (mkV "originar") ; -- status=guess
lin originate_V = mkV "originar" ; -- status=guess
lin hunting_N = variants{} ; -- 
lin crude_A = mkA "crudo" | mkA "rudimentario" ; -- status=guess
lin protocol_N = variants{} ; -- 
lin prejudice_N = mkN "prejuicio" ; -- status=guess
lin inspiration_N = mkN "inspiración" feminine ; -- status=guess
lin dioxide_N = mkN "dióxido" ; -- status=guess
lin chemical_A = mkA "químico" ; -- status=guess
lin uncomfortable_A = mkA "incómodo" ; -- status=guess
lin worthy_A = mkA "digno" ; -- status=guess
lin inspect_V2 = mkV2 (mkV "inspeccionar") ; -- status=guess
lin summon_V2 = mkV2 (mkV "citar") ; -- status=guess
lin parallel_N = variants{} ; -- 
lin outlet_N = mkN "desahogo" ; -- status=guess
lin okay_A = variants{} ; -- 
lin collaboration_N = mkN "colaboración" feminine ; -- status=guess
lin booking_N = mkN "reserva" ; -- status=guess
lin salad_N = mkN "ensalada" ; -- status=guess
lin productive_A = mkA "productivo" ; -- status=guess
lin charming_A = variants{} ; -- 
lin polish_A = variants{} ; -- 
lin oak_N = mkN "roble" masculine ; -- status=guess
lin access_V2 = mkV2 (mkV "acceder") ; -- status=guess
lin tourism_N = mkN "turismo" ; -- status=guess
lin independently_Adv = variants{} ; -- 
lin cruel_A = mkA "cruel" ; -- status=guess
lin diversity_N = mkN "diversidad" feminine ; -- status=guess
lin accused_A = variants{} ; -- 
lin supplement_N = mkN "suplemento" ; -- status=guess
lin fucking_Adv = mkAdv "jodidamente" ; -- status=guess
lin forecast_N = mkN "pronóstico" | mkN "previsión" feminine ; -- status=guess
lin amend_V2V = mkV2V (enmendar_V) ; -- status=guess
lin amend_V2 = mkV2 (enmendar_V) ; -- status=guess
lin amend_V = enmendar_V ; -- status=guess
lin soap_N = mkN "jabón" masculine ; -- status=guess
lin ruling_N = mkN "decisión" feminine ; -- status=guess
lin interference_N = variants{} ; -- 
lin executive_A = mkA "ejecutivo" ; -- status=guess
lin mining_N = mkN "minería" ; -- status=guess
lin minimal_A = mkA "mínimo" ; -- status=guess
lin clarify_V2 = mkV2 (mkV "clarificar") | mkV2 (mkV "aclarar") ; -- status=guess
lin clarify_V = mkV "clarificar" | mkV "aclarar" ; -- status=guess
lin strain_V2 = mkV2 (colar_V) | mkV2 (mkV "tamizar") ; -- status=guess
lin strain_V = colar_V | mkV "tamizar" ; -- status=guess
lin novel_A = mkA "novedoso" | mkA "novedosa" ; -- status=guess
lin try_N = mkN "try" | mkN "ensayo" ; -- status=guess
lin coastal_A = mkA "costero" | mkA "costanero" | mkA "costeño" ; -- status=guess
lin rising_A = variants{} ; -- 
lin quota_N = mkN "cuota" ; -- status=guess
lin minus_Prep = variants{} ; -- 
lin kilometre_N = mkN "kilómetro" ; -- status=guess
lin characterize_V2 = mkV2 (mkV "caracterizar") ; -- status=guess
lin suspicious_A = mkA "sospechoso" ; -- status=guess
lin pet_N = mkN "mascota" ; -- status=guess
lin beneficial_A = mkA "beneficioso" ; -- status=guess
lin fling_V2 = mkV2 (aventar_V) | mkV2 (mkV "lanzar") ; -- status=guess
lin fling_V = aventar_V | mkV "lanzar" ; -- status=guess
lin deprive_V2 = mkV2 (desproveer_V) | mkV2 (mkV "privar") ; -- status=guess
lin covenant_N = mkN "convenio" | mkN "contrato" | mkN "alianza" | mkN "pacto" ; -- status=guess
lin bias_N = mkN "inclinación" feminine | mkN "predisposición" feminine | mkN "parcialidad" feminine | mkN "prejuicio" | mkN "sesgo" | mkN "preferencia" | mkN "predilección" feminine | mkN "tendencia" ; -- status=guess
lin trophy_N = mkN "trofeo" ; -- status=guess
lin verb_N = mkN "verbo" ; -- status=guess
lin honestly_Adv = variants{} ; -- 
lin extract_N = mkN "extracto" | mkN "pasaje" masculine | mkN "fragmento" ; -- status=guess
lin straw_N = mkN "paja" masculine ; -- status=guess
lin stem_V2 = mkV2 (mkV "arrancar") | mkV2 (mkV (mkV "venir") "de") | mkV2 (mkV (mkV "proceder") "de") ; -- status=guess
lin stem_V = mkV "arrancar" | mkV (mkV "venir") "de" | mkV (mkV "proceder") "de" ; -- status=guess
lin eyebrow_N = mkN "ceja" ; -- status=guess
lin noble_A = mkA "noble" ; -- status=guess
lin mask_N = mkN "máscara" ; -- status=guess
lin lecturer_N = mkN "docente" masculine ; -- status=guess
lin girlfriend_N = mkN "amiga" ; -- status=guess
lin forehead_N = mkN "frente" masculine ; -- status=guess
lin timetable_N = mkN "horario" ; -- status=guess
lin symbolic_A = mkA "simbólico" ; -- status=guess
lin farming_N = variants{} ; -- 
lin lid_N = mkN "tapa" ; -- status=guess
lin librarian_N = mkN "bibliotecario" ; -- status=guess
lin injection_N = mkN "inyección" feminine ; -- status=guess
lin sexuality_N = mkN "sexualidad" feminine ; -- status=guess
lin irrelevant_A = variants{} ; -- 
lin bonus_N = mkN "bonificación" feminine ; -- status=guess
lin abuse_V2 = mkV2 (mkV "abusar") ; -- status=guess
lin thumb_N = mkN "pulgar" masculine ; -- status=guess
lin survey_V2 = mkV2 (mkV "inspeccionar") ; -- status=guess
lin ankle_N = mkN "tobillo" ; -- status=guess
lin psychologist_N = mkN "psicólogo" | mkN "psicóloga" | mkN "sicólogo" | mkN "sicóloga" ; -- status=guess
lin occurrence_N = mkN "acontecimiento" ; -- status=guess
lin profitable_A = mkA "lucrativo" | mkA "ventajoso" ; -- status=guess
lin deliberate_A = mkA "deliberado" | mkA "a propósito" ; -- status=guess
lin bow_V2 = mkV2 (mkV "arquearse") ; -- status=guess
lin bow_V = mkV "arquearse" ; -- status=guess
lin tribe_N = mkN "tribu" feminine ; -- status=guess
lin rightly_Adv = variants{} ; -- 
lin representative_A = mkA "representante" ; -- status=guess
lin code_V2 = mkV2 (mkV "codificar") ; -- status=guess
lin validity_N = mkN "validez" feminine ; -- status=guess
lin marble_N = mkN "mármol" masculine ; -- status=guess
lin bow_N = mkN "proa" masculine ; -- status=guess
lin plunge_V2 = mkV2 (mkV "submergir") ; -- status=guess
lin plunge_V = mkV "submergir" ; -- status=guess
lin maturity_N = variants{} ; -- 
lin maturity_3_N = variants{} ; -- 
lin maturity_2_N = variants{} ; -- 
lin maturity_1_N = variants{} ; -- 
lin hidden_A = variants{} ; -- 
lin contrast_V2 = mkV2 (mkV "contrastar") ; -- status=guess
lin contrast_V = mkV "contrastar" ; -- status=guess
lin tobacco_N = mkN "tabaco" ; -- status=guess
lin middle_class_A = variants{} ; -- 
lin grip_V2 = mkV2 (mkV "agarrar") ; -- status=guess
lin grip_V = mkV "agarrar" ; -- status=guess
lin clergy_N = mkN "clero" ; -- status=guess
lin trading_A = variants{} ; -- 
lin passive_A = mkA "pasivo" ; -- status=guess
lin decoration_N = mkN "condecoración" feminine ; -- status=guess
lin racial_A = mkA "racial" ; -- status=guess
lin well_N = mkN "aljibe" | mkN "pozo" | mkN "gas" masculine | mkN "etc.)" masculine ; -- status=guess
lin embarrassment_N = mkN "vergüenza" | mkN "corte" ; -- status=guess
lin sauce_N = mkN " chupe" ; -- status=guess
lin fatal_A = mkA "fatal" ; -- status=guess
lin banker_N = mkN "banquero" | mkN "banquera" ; -- status=guess
lin compensate_V2 = variants{} ; -- 
lin compensate_V = variants{} ; -- 
lin make_up_N = variants{} ; -- 
lin seat_V2 = variants{} ; -- 
lin popularity_N = mkN "popularidad" feminine ; -- status=guess
lin interior_A = mkA "interior" ; -- status=guess
lin eligible_A = mkA "elegible" ; -- status=guess
lin continuity_N = mkN "continuidad" feminine ; -- status=guess
lin bunch_N = mkN "montón" masculine ; -- status=guess
lin hook_N = mkN "anzuelo" ; -- status=guess
lin wicket_N = variants{} ; -- 
lin pronounce_VS = mkVS (mkV "pronunciar") ; -- status=guess
lin pronounce_V2 = mkV2 (mkV "pronunciar") ; -- status=guess
lin pronounce_V = mkV "pronunciar" ; -- status=guess
lin ballet_N = mkN "ballet" | mkN "baile" masculine ; -- status=guess
lin heir_N = mkN "heredero forzoso" | mkN "heredera forzosa" ; -- status=guess
lin positively_Adv = variants{} ; -- 
lin insufficient_A = mkA "insuficiente" ; -- status=guess
lin substitute_V2 = mkV2 (sustituir_V) | mkV2 (substituir_V) ; -- status=guess
lin substitute_V = sustituir_V | substituir_V ; -- status=guess
lin mysterious_A = mkA "misterioso" ; -- status=guess
lin dancer_N = mkN "bailarín" | mkN "bailarina" | mkN "bailador" masculine ; -- status=guess
lin trail_N = mkN "sendero" ; -- status=guess
lin caution_N = mkN "precaución" feminine | mkN "cuidado" | mkN "cautela" ; -- status=guess
lin donation_N = mkN "donación" feminine | mkN "donativo" ; -- status=guess
lin added_A = variants{} ; -- 
lin weaken_V2 = mkV2 (mkV "debilitarse") ; -- status=guess
lin weaken_V = mkV "debilitarse" ; -- status=guess
lin tyre_N = mkN "neumático" | mkN "rueda" ; -- status=guess
lin sufferer_N = mkN "sufridor" masculine ; -- status=guess
lin managerial_A = variants{} ; -- 
lin elaborate_A = variants{} ; -- 
lin restraint_N = variants{} ; -- 
lin renew_V2 = mkV2 (mkV "reiniciar") | mkV2 (recomenzar_V) ; -- status=guess
lin gardener_N = variants{} ; -- 
lin dilemma_N = mkN "dilema" masculine ; -- status=guess
lin configuration_N = mkN "configuración" feminine ; -- status=guess
lin rear_A = variants{} ; -- 
lin embark_V2 = mkV2 (mkV "embarcar") ; -- status=guess
lin embark_V = mkV "embarcar" ; -- status=guess
lin misery_N = mkN "miseria" ; -- status=guess
lin importantly_Adv = variants{} ; -- 
lin continually_Adv = variants{} ; -- 
lin appreciation_N = mkN "apreciación" feminine ; -- status=guess
lin radical_N = variants{} ; -- 
lin diverse_A = mkA "diferente" ; -- status=guess
lin revive_V2 = mkV2 (mkV "revivir") ; -- status=guess
lin revive_V = mkV "revivir" ; -- status=guess
lin trip_V2 = mkV2 (tropezar_V) ; -- status=guess
lin trip_V = tropezar_V ; -- status=guess
lin lounge_N = mkN "sala de estar" | mkN "estancia" ; -- status=guess
lin dwelling_N = mkN "domicilio" | mkN "morada" | mkN "residencia" | mkN "vasa." ; -- status=guess
lin parental_A = variants{} ; -- 
lin loyal_A = mkA "leal" ; -- status=guess
lin privatisation_N = variants{} ; -- 
lin outsider_N = mkN "lego" | mkN "novato" ; -- status=guess
lin forbid_V2 = mkV2 (prohibir_V) | mkV2 (mkV "vedar") | mkV2 (mkV "vetar") ; -- status=guess
lin yep_Interj = variants{} ; -- 
lin prospective_A = variants{} ; -- 
lin manuscript_N = mkN "manuscrito" ; -- status=guess
lin inherent_A = mkA "inherente" ; -- status=guess
lin deem_V2V = mkV2V (mkV "estimar") ; -- status=guess
lin deem_V2A = mkV2A (mkV "estimar") ; -- status=guess
lin deem_V2 = mkV2 (mkV "estimar") ; -- status=guess
lin telecommunication_N = variants{} ; -- 
lin intermediate_A = mkA "intermedio" ; -- status=guess
lin worthwhile_A = mkA "de valor" | mkA "que vale la pena" | mkA "que merece la pena" | mkA "que compensa el esfuerzo" ; -- status=guess
lin calendar_N = mkN "agenda" ; -- status=guess
lin basin_N = mkN "cuenca" ; -- status=guess
lin utterly_Adv = variants{} ; -- 
lin rebuild_V2 = mkV2 (reconstruir_V) ; -- status=guess
lin pulse_N = mkN "pulso" ; -- status=guess
lin suppress_V2 = mkV2 (mkV "suprimir") ; -- status=guess
lin predator_N = mkN "predador" masculine ; -- status=guess
lin width_N = mkN "anchura" ; -- status=guess
lin stiff_A = mkA "rigidez" ; -- status=guess
lin spine_N = mkN "espinazo" ; -- status=guess
lin betray_V2 = mkV2 (mkV "traicionar") ; -- status=guess
lin punish_V2 = mkV2 (mkV "castigar") ; -- status=guess
lin stall_N = mkN "puesto" ; -- status=guess
lin lifestyle_N = variants{} ; -- 
lin compile_V2 = mkV2 (mkV "compilar") ; -- status=guess
lin arouse_V2V = mkV2V (despertar_V) ; -- status=guess
lin arouse_V2 = mkV2 (despertar_V) ; -- status=guess
lin partially_Adv = variants{} ; -- 
lin headline_N = variants{} ; -- 
lin divine_A = mkA "divino" ; -- status=guess
lin unpleasant_A = mkA "desagradable" ; -- status=guess
lin sacred_A = mkA "sagrado" ; -- status=guess
lin useless_A = mkA "inútil" | mkA "bueno para nada" | mkA "buena para nada" ; -- status=guess
lin cool_V2 = variants{} ; -- 
lin cool_V = variants{} ; -- 
lin tremble_V = temblar_V ; -- status=guess
lin statue_N = mkN "estatua" ; -- status=guess
lin obey_V2 = mkV2 (obedecer_V) ; -- status=guess
lin obey_V = obedecer_V ; -- status=guess
lin drunk_A = mkA "borracho" | mkA "ebrio" ; -- status=guess
lin tender_A = mkA "tierno" | mkA "cariñoso" ; -- status=guess
lin molecular_A = mkA "molecular" ; -- status=guess
lin circulate_V2 = mkV2 (mkV "circular") ; -- status=guess
lin circulate_V = mkV "circular" ; -- status=guess
lin exploitation_N = mkN "explotación" feminine ; -- status=guess
lin explicitly_Adv = variants{} ; -- 
lin utterance_N = mkN "elocuencia" ; -- status=guess
lin linear_A = mkA "lineal" ; -- status=guess
lin chat_V2 = mkV2 (mkV "charlar") | mkV2 (mkV "platicar") ; -- status=guess
lin chat_V = mkV "charlar" | mkV "platicar" ; -- status=guess
lin revision_N = variants{} ; -- 
lin distress_N = mkN "inconforme" | mkN "en serio peligro" ; -- status=guess
lin spill_V2 = mkV2 (mkV "derramar") ; -- status=guess
lin spill_V = mkV "derramar" ; -- status=guess
lin steward_N = mkN "azafato" | mkN "mozo" | mkN "aeromozo" ; -- status=guess
lin knight_N = mkN "caballo" feminine ; -- status=guess
lin sum_V2 = mkV2 (mkV "sumar") ; -- status=guess
lin sum_V = mkV "sumar" ; -- status=guess
lin semantic_A = mkA "semántico" ; -- status=guess
lin selective_A = mkA "selectivo" ; -- status=guess
lin learner_N = mkN "aprendiz" masculine ; -- status=guess
lin dignity_N = mkN "dignidad" feminine ; -- status=guess
lin senate_N = mkN "senado" ; -- status=guess
lin grid_N = mkN "red" feminine ; -- status=guess
lin fiscal_A = variants{} ; -- 
lin activate_V2 = mkV2 (mkV "activar") ; -- status=guess
lin rival_A = variants{} ; -- 
lin fortunate_A = mkA "afortunado" ; -- status=guess
lin jeans_N = variants{} ; -- 
lin select_A = variants{} ; -- 
lin fitting_N = variants{} ; -- 
lin commentator_N = variants{} ; -- 
lin weep_V2 = mkV2 (mkV "llorar") ; -- status=guess
lin weep_V = mkV "llorar" ; -- status=guess
lin handicap_N = mkN "minusvalía" ; -- status=guess
lin crush_V2 = variants{} ; -- 
lin crush_V = variants{} ; -- 
lin towel_N = mkN "toalla" ; -- status=guess
lin stay_N = mkN "estadía" ; -- status=guess
lin skilled_A = mkA "hábil" ; -- status=guess
lin repeatedly_Adv = mkAdv "reiteradamente" ; -- status=guess
lin defensive_A = mkA "defensivo" ; -- status=guess
lin calm_V2 = mkV2 (mkV "calmarse") | mkV2 (mkV "tranquilizarse") ; -- status=guess
lin calm_V = mkV "calmarse" | mkV "tranquilizarse" ; -- status=guess
lin temporarily_Adv = variants{} ; -- 
lin rain_V2 = mkV2 (mkV (mkV "llover") "a cántaros") ; -- status=guess
lin rain_V = mkV (mkV "llover") "a cántaros" ; -- status=guess
lin pin_N = mkN "pin" ; -- status=guess
lin villa_N = mkN "villa" ; -- status=guess
lin rod_N = mkN "bastón" masculine ; -- status=guess
lin frontier_N = mkN "frontera" ; -- status=guess
lin enforcement_N = mkN "compulsión" feminine | mkN "coerción" feminine ; -- status=guess
lin protective_A = mkA "protector" ; -- status=guess
lin philosophical_A = mkA "filosófico" ; -- status=guess
lin lordship_N = mkN "domino" | mkN "esfera" | mkN "señorío" ; -- status=guess
lin disagree_VS = mkVS (mkV "discrepar") ; -- status=guess
lin disagree_V2 = mkV2 (mkV "discrepar") ; -- status=guess
lin disagree_V = mkV "discrepar" ; -- status=guess
lin boyfriend_N = mkN "amigo" ; -- status=guess
lin activist_N = variants{} ; -- 
lin viewer_N = mkN "telespectador" masculine ; -- status=guess
lin slim_A = mkA "flaco" | mkA "delgado" ; -- status=guess
lin textile_N = variants{} ; -- 
lin mist_N = mkN "niebla" | mkN "neblina" ; -- status=guess
lin harmony_N = mkN "armonía" ; -- status=guess
lin deed_N = mkN "hecho" | mkN "acto" | mkN "acción" feminine | mkN "obra" ; -- status=guess
lin merge_V2 = mkV2 (convergir_V) ; -- status=guess
lin merge_V = convergir_V ; -- status=guess
lin invention_N = mkN "invención" feminine ; -- status=guess
lin commissioner_N = variants{} ; -- 
lin caravan_N = mkN "caravana" masculine ; -- status=guess
lin bolt_N = mkN "tranca" ; -- status=guess
lin ending_N = variants{} ; -- 
lin publishing_N = variants{} ; -- 
lin gut_N = mkN "tripa" | mkN "panza" ; -- status=guess
lin stamp_V2 = mkV2 (mkV "franquear") ; -- status=guess
lin stamp_V = mkV "franquear" ; -- status=guess
lin map_V2 = variants{} ; -- 
lin loud_Adv = variants{} ; -- 
lin stroke_V2 = mkV2 (mkV "acariciar") ; -- status=guess
lin shock_V2 = variants{} ; -- 
lin rug_N = mkN "tapete" | mkN "alfombra" | mkN "alfombrilla" ; -- status=guess
lin picture_V2 = variants{} ; -- 
lin slip_N = mkN "resbalón" masculine ; -- status=guess
lin praise_N = mkN "agradecimiento" ; -- status=guess
lin fine_N = mkN "multa" ; -- status=guess
lin monument_N = mkN "monumento" ; -- status=guess
lin material_A = mkA "material" ; -- status=guess
lin garment_N = mkN "prenda" ; -- status=guess
lin toward_Prep = variants{} ; -- 
lin realm_N = mkN "esfera" ; -- status=guess
lin melt_V2 = mkV2 (derretir_V) | mkV2 (mkV "derretirse") ; -- status=guess
lin melt_V = derretir_V | mkV "derretirse" ; -- status=guess
lin reproduction_N = mkN "reproducción" feminine ; -- status=guess
lin reactor_N = mkN "reactor" masculine ; -- status=guess
lin furious_A = mkA "furioso" ; -- status=guess
lin distinguished_A = variants{} ; -- 
lin characterize_V2 = mkV2 (mkV "caracterizar") ; -- status=guess
lin alike_Adv = variants{} ; -- 
lin pump_N = mkN "bomba" | mkN "surtidor" masculine ; -- status=guess
lin probe_N = mkN "tienta" ; -- status=guess
lin feedback_N = mkN "retroacción" | mkN "realimentación" | mkN "retroalimentación" ; -- status=guess
lin aspiration_N = mkN "aspiración" feminine ; -- status=guess
lin suspect_N = variants{} ; -- 
lin solar_A = mkA "solar" ; -- status=guess
lin fare_N = mkN "polizón" masculine ; -- status=guess
lin carve_V2 = mkV2 (mkV "cortar") ; -- status=guess
lin carve_V = mkV "cortar" ; -- status=guess
lin qualified_A = variants{} ; -- 
lin membrane_N = mkN "membrana" ; -- status=guess
lin dependence_N = mkN "dependencia" ; -- status=guess
lin convict_V2 = variants{} ; -- 
lin bacteria_N = mkN "bacterias" ; -- status=guess
lin trading_N = mkN "cromo" | mkN "lámina" ; -- status=guess
lin ambassador_N = mkN "embajador" masculine ; -- status=guess
lin wound_V2 = mkV2 (herir_V) ; -- status=guess
lin drug_V2 = mkV2 (mkV "drogar") ; -- status=guess
lin conjunction_N = mkN "conjunción" feminine | mkN "unión" feminine ; -- status=guess
lin cabin_N = mkN "cabaña" ; -- status=guess
lin trail_V2 = mkV2 (mkV "arrastrar") ; -- status=guess
lin trail_V = mkV "arrastrar" ; -- status=guess
lin shaft_N = mkN "haz" masculine | mkN "rayo" ; -- status=guess
lin treasure_N = mkN "tesoro" ; -- status=guess
lin inappropriate_A = mkA "inapropiado" ; -- status=guess
lin half_Adv = variants{} ; -- 
lin attribute_N = mkN "atributo" ; -- status=guess
lin liquid_A = mkA "líquido" ; -- status=guess
lin embassy_N = mkN "embajada" ; -- status=guess
lin terribly_Adv = variants{} ; -- 
lin exemption_N = variants{} ; -- 
lin array_N = mkN "vector" masculine | mkN "arreglo" ; -- status=guess
lin tablet_N = mkN "placa" ; -- status=guess
lin sack_V2 = mkV2 (despedir_V) ; -- status=guess
lin erosion_N = mkN "erosión" feminine ; -- status=guess
lin bull_N = mkN "bula" ; -- status=guess
lin warehouse_N = mkN "almacén" masculine | mkN "depósito" ; -- status=guess
lin unfortunate_A = mkA "desafortunado" ; -- status=guess
lin promoter_N = variants{} ; -- 
lin compel_VV = mkVV (mkV "obligar") | mkVV (forzar_V) | mkVV (mkV "compeler") ; -- status=guess
lin compel_V2V = mkV2V (mkV "obligar") | mkV2V (forzar_V) | mkV2V (mkV "compeler") ; -- status=guess
lin compel_V2 = mkV2 (mkV "obligar") | mkV2 (forzar_V) | mkV2 (mkV "compeler") ; -- status=guess
lin motivate_V2V = mkV2V (mkV "motivar") ; -- status=guess
lin motivate_V2 = mkV2 (mkV "motivar") ; -- status=guess
lin burning_A = variants{} ; -- 
lin vitamin_N = mkN "vitamina A" ; -- status=guess
lin sail_N = mkN "vela" ; -- status=guess
lin lemon_N = mkN "melisa" | mkN "toronjil" | mkN "citronela" | mkN "hoja de limón" ; -- status=guess
lin foreigner_N = mkN "extranjero" | mkN "extranjera" ; -- status=guess
lin powder_N = mkN "polvo" feminine ; -- status=guess
lin persistent_A = mkA "persistente" ; -- status=guess
lin bat_N = mkN "bate" masculine | mkN "bat " ; -- status=guess
lin ancestor_N = mkN "ancestro" | mkN "antepasado" ; -- status=guess
lin predominantly_Adv = variants{} ; -- 
lin mathematical_A = mkA "matemático" | mkA "matemática" ; -- status=guess
lin compliance_N = mkN "cumplimiento" ; -- status=guess
lin arch_N = mkN "arco" ; -- status=guess
lin woodland_N = mkN "bosque" masculine | mkN "floresta" ; -- status=guess
lin serum_N = mkN "suero" ; -- status=guess
lin overnight_Adv = mkAdv "de un día para otro" | mkAdv "de la noche a la mañana" ; -- status=guess
lin doubtful_A = mkA "dudoso" ; -- status=guess
lin doing_N = variants{} ; -- 
lin coach_V2 = mkV2 (mkV "entrenar") ; -- status=guess
lin coach_V = mkV "entrenar" ; -- status=guess
lin binding_A = variants{} ; -- 
lin surrounding_A = variants{} ; -- 
lin peer_N = mkN "par" masculine ; -- status=guess
lin ozone_N = mkN "ozono" ; -- status=guess
lin mid_A = variants{} ; -- 
lin invisible_A = mkA "invisible" ; -- status=guess
lin depart_V = mkV (mkV "desviarse") "de" ; -- status=guess
lin brigade_N = variants{} ; -- 
lin manipulate_V2 = mkV2 (mkV "manipular") ; -- status=guess
lin consume_V2 = mkV2 (mkV "consumir") ; -- status=guess
lin consume_V = mkV "consumir" ; -- status=guess
lin temptation_N = mkN "tentación" feminine ; -- status=guess
lin intact_A = mkA "intacto" ; -- status=guess
lin glove_N = L.glove_N ;
lin aggression_N = mkN "agresión" feminine ; -- status=guess
lin emergence_N = mkN "surgimiento" ; -- status=guess
lin stag_V = variants{} ; -- 
lin coffin_N = mkN "ataúd" | mkN "féretro" ; -- status=guess
lin beautifully_Adv = variants{} ; -- 
lin clutch_V2 = mkV2 (aferrar_V) ; -- status=guess
lin clutch_V = aferrar_V ; -- status=guess
lin wit_N = mkN "imaginativo" | mkN "divertido" ; -- status=guess
lin underline_V2 = mkV2 (mkV "subrayar") ; -- status=guess
lin trainee_N = variants{} ; -- 
lin scrutiny_N = mkN "escrutinio" ; -- status=guess
lin neatly_Adv = variants{} ; -- 
lin follower_N = mkN "imitador" ; -- status=guess
lin sterling_A = variants{} ; -- 
lin tariff_N = mkN "tarifa" | mkN "arancel" masculine ; -- status=guess
lin bee_N = mkN "abejaruco" ; -- status=guess
lin relaxation_N = mkN "relax" | mkN "relajación" ; -- status=guess
lin negligence_N = mkN "negligencia" ; -- status=guess
lin sunlight_N = mkN "luz del sol" ; -- status=guess
lin penetrate_V2 = mkV2 (mkV "penetrar") ; -- status=guess
lin penetrate_V = mkV "penetrar" ; -- status=guess
lin knot_N = mkN "nudo" ; -- status=guess
lin temper_N = mkN "temple" masculine ; -- status=guess
lin skull_N = mkN "calavera" ; -- status=guess
lin openly_Adv = variants{} ; -- 
lin grind_V2 = mkV2 (moler_V) ; -- status=guess
lin grind_V = moler_V ; -- status=guess
lin whale_N = mkN "ballena" ; -- status=guess
lin throne_N = mkN "trono" ; -- status=guess
lin supervise_V2 = variants{} ; -- 
lin supervise_V = variants{} ; -- 
lin sickness_N = mkN "enfermedad" feminine ; -- status=guess
lin package_V2 = mkV2 (mkV "empaquetar") ; -- status=guess
lin intake_N = variants{} ; -- 
lin within_Adv = variants{}; -- mkPrep "dentro de" ;
lin inland_A = variants{} ; -- 
lin beast_N = mkN "bestia" ; -- status=guess
lin rear_N = mkN "posterior" masculine ; -- status=guess
lin morality_N = mkN "moralidad" feminine ; -- status=guess
lin competent_A = mkA "competente" | mkA "competentes" ; -- status=guess
lin sink_N = mkN "lavamanos" masculine | mkN "fregadero" ; -- status=guess
lin uniform_A = mkA "uniforme" ; -- status=guess
lin reminder_N = mkN "aviso recordatorio" ; -- status=guess
lin permanently_Adv = variants{} ; -- 
lin optimistic_A = mkA "optimista" ; -- status=guess
lin bargain_N = mkN "trato" | mkN "ganga" | mkN "bicoca" ; -- status=guess
lin seemingly_Adv = variants{} ; -- 
lin respective_A = mkA "respectivo" ; -- status=guess
lin horizontal_A = mkA "horizontal" ; -- status=guess
lin decisive_A = variants{} ; -- 
lin bless_V2 = mkV2 (bendecir_V) ; -- status=guess
lin bile_N = mkN "bilis" feminine ; -- status=guess
lin spatial_A = mkA "espacial" ; -- status=guess
lin bullet_N = mkN "bala" | mkN "proyectil" masculine ; -- status=guess
lin respectable_A = mkA "respetable" ; -- status=guess
lin overseas_Adv = variants{} ; -- 
lin convincing_A = variants{} ; -- 
lin unacceptable_A = mkA "inaceptable" ; -- status=guess
lin confrontation_N = variants{} ; -- 
lin swiftly_Adv = variants{} ; -- 
lin paid_A = variants{} ; -- 
lin joke_VS = mkVS (mkV "bromear") ; -- status=guess
lin joke_V = mkV "bromear" ; -- status=guess
lin instant_A = variants{} ; -- 
lin illusion_N = mkN "ilusión" feminine ; -- status=guess
lin cheer_V2 = mkV2 (mkV "animarse") ; -- status=guess
lin cheer_V = mkV "animarse" ; -- status=guess
lin congregation_N = mkN "congregación" feminine ; -- status=guess
lin worldwide_Adv = variants{} ; -- 
lin winning_A = variants{} ; -- 
lin wake_N = mkN "estela" ; -- status=guess
lin toss_V2 = mkV2 (mkV "tirar") | mkV2 (mkV "desechar") ; -- status=guess
lin toss_V = mkV "tirar" | mkV "desechar" ; -- status=guess
lin medium_A = mkA "mediano" ; -- status=guess
lin jewellery_N = mkN "joyería" | mkN "joyas" feminine | mkN "alhajas" feminine ; -- status=guess
lin fond_A = mkA "tener cariño" | mkA "querer" ; -- status=guess
lin alarm_V2 = variants{} ; -- 
lin guerrilla_N = mkN "guerrilla" | mkN "guerra de guerrillas" ; -- status=guess
lin dive_V = mkV (mkV "hacer") "un clavado" ; -- status=guess
lin desire_V2 = mkV2 (mkV "desear") ; -- status=guess
lin cooperation_N = mkN "cooperación" ; -- status=guess
lin thread_N = mkN "rosca" | mkN "filete" masculine ; -- status=guess
lin prescribe_V2 = mkV2 (prescribir_V) | mkV2 (mkV "recetar") ; -- status=guess
lin prescribe_V = prescribir_V | mkV "recetar" ; -- status=guess
lin calcium_N = mkN "calcio" ; -- status=guess
lin redundant_A = mkA "redundante" ; -- status=guess
lin marker_N = mkN "rotulador" ; -- status=guess
lin chemist_N = variants{} ; -- 
lin mammal_N = mkN "mamífero" ; -- status=guess
lin legacy_N = mkN "legado" ; -- status=guess
lin debtor_N = mkN "deudor" masculine ; -- status=guess
lin testament_N = mkN "testamento" ; -- status=guess
lin tragic_A = mkA "trágico" ; -- status=guess
lin silver_A = mkA "blanco" ; -- status=guess
lin grin_N = mkN "sonrisa abierta" | mkN "sonrisa amplia" ; -- status=guess
lin spectacle_N = mkN "espectáculo" ; -- status=guess
lin inheritance_N = mkN "impuesto sucesorio" ; -- status=guess
lin heal_V2 = mkV2 (mkV "curar") | mkV2 (mkV "sanar") ; -- status=guess
lin heal_V = mkV "curar" | mkV "sanar" ; -- status=guess
lin sovereignty_N = mkN "soberanía" ; -- status=guess
lin enzyme_N = mkN "enzima" ; -- status=guess
lin host_V2 = mkV2 (mkV "alojar") ; -- status=guess
lin neighbouring_A = variants{} ; -- 
lin corn_N = mkN "copos de maíz" ; -- status=guess
lin layout_N = mkN "replanteo" | mkN "plano de replanteo" ; -- status=guess
lin dictate_VS = variants{} ; -- 
lin dictate_V2 = variants{} ; -- 
lin dictate_V = variants{} ; -- 
lin rip_V2 = mkV2 (mkV "arrancar") ; -- status=guess
lin rip_V = mkV "arrancar" ; -- status=guess
lin regain_V2 = variants{} ; -- 
lin probable_A = mkA "probable" ; -- status=guess
lin inclusion_N = mkN "inclusión" feminine ; -- status=guess
lin booklet_N = mkN "libreto" | mkN "folleto" ; -- status=guess
lin bar_V2 = mkV2 (mkV "barrar") ; -- status=guess
lin privately_Adv = variants{} ; -- 
lin laser_N = mkN "láser" masculine ; -- status=guess
lin fame_N = mkN "fama" ; -- status=guess
lin bronze_N = mkN "bronce" masculine ; -- status=guess
lin mobile_A = mkA "móvil" ; -- status=guess
lin metaphor_N = mkN "metáforo" ; -- status=guess
lin complication_N = variants{} ; -- 
lin narrow_V2 = mkV2 (mkV "estrecharse") ; -- status=guess
lin narrow_V = mkV "estrecharse" ; -- status=guess
lin old_fashioned_A = variants{} ; -- 
lin chop_V2 = mkV2 (mkV "cortar") | mkV2 (mkV "picar") | mkV2 (mkV "tajar") ; -- status=guess
lin chop_V = mkV "cortar" | mkV "picar" | mkV "tajar" ; -- status=guess
lin synthesis_N = mkN "síntesis" feminine ; -- status=guess
lin diameter_N = mkN "diámetro" ; -- status=guess
lin bomb_V2 = mkV2 (mkV "bombardear") | mkV2 (mkV "bombear") ; -- status=guess
lin bomb_V = mkV "bombardear" | mkV "bombear" ; -- status=guess
lin silently_Adv = variants{} ; -- 
lin shed_N = mkN "cobertizo" | mkN "galpón" ; -- status=guess
lin fusion_N = mkN "derretimiento fundición" ; -- status=guess
lin trigger_V2 = mkV2 (mkV (mkV "apretar") "el gatillo") ; -- status=guess
lin printing_N = mkN "impresora" ; -- status=guess
lin onion_N = mkN "cebolla" masculine ; -- status=guess
lin dislike_V2 = mkV2 (mkV "desagradar") | mkV2 (mkV (mkV "no") "gustar") | mkV2 (mkV (mkV "tener") "aversión") ; -- status=guess
lin embody_V2 = mkV2 (mkV "personificar") | mkV2 (mkV "encarnar") ; -- status=guess
lin curl_V2 = variants{} ; -- 
lin curl_V = variants{} ; -- 
lin sunshine_N = mkN "sol" feminine | mkN "luz del sol" ; -- status=guess
lin sponsorship_N = variants{} ; -- 
lin rage_N = mkN "rabia" ; -- status=guess
lin loop_N = variants{} ; -- 
lin halt_N = variants{} ; -- 
lin cop_V2 = variants{} ; -- 
lin cop_V = variants{} ; -- 
lin bang_V2 = mkV2 (mkV "chapucear") ; -- status=guess
lin bang_V = mkV "chapucear" ; -- status=guess
lin toxic_A = mkA "tóxico" ; -- status=guess
lin thinking_A = variants{} ; -- 
lin orientation_N = mkN "orientación" feminine ; -- status=guess
lin likelihood_N = mkN "verosimilitud" feminine ; -- status=guess
lin wee_A = mkA "pequeño" ; -- status=guess
lin up_to_date_A = variants{} ; -- 
lin polite_A = mkA "cortés" | mkA "educado" ; -- status=guess
lin apology_N = mkN "disculpa" ; -- status=guess
lin exile_N = mkN "exiliado" | mkN "desterrado" ; -- status=guess
lin brow_N = mkN "frente" masculine ; -- status=guess
lin miserable_A = mkA "miserable" ; -- status=guess
lin outbreak_N = variants{} ; -- 
lin comparatively_Adv = variants{} ; -- 
lin pump_V2 = mkV2 (mkV (mkV "levantar") "pesas") | mkV2 (mkV "culturizar") | mkV2 (mkV (mkV "practicar") "culturismo") ; -- status=guess
lin pump_V = mkV (mkV "levantar") "pesas" | mkV "culturizar" | mkV (mkV "practicar") "culturismo" ; -- status=guess
lin fuck_V2 = mkV2 (mkV "joder") | mkV2 (mkV "molestar") | mkV2 (mkV "huevear") | mkV2 (mkV "fregar") | mkV2 (mkV "mamar") ; -- status=guess
lin fuck_V = mkV "joder" | mkV "molestar" | mkV "huevear" | mkV "fregar" | mkV "mamar" ; -- status=guess
lin forecast_VS = mkVS (mkV (mkV "predecir.") "pronosticar") ; -- status=guess
lin forecast_V2 = mkV2 (mkV (mkV "predecir.") "pronosticar") ; -- status=guess
lin forecast_V = mkV (mkV "predecir.") "pronosticar" ; -- status=guess
lin timing_N = mkN "cronometraje" masculine ; -- status=guess
lin headmaster_N = variants{} ; -- 
lin terrify_V2 = mkV2 (aterrar_V) ; -- status=guess
lin sigh_N = mkN "suspiro" ; -- status=guess
lin premier_A = variants{} ; -- 
lin joint_N = mkN "custodia compartida" ; -- status=guess
lin incredible_A = mkA "increíble" ; -- status=guess
lin gravity_N = mkN "gravedad" feminine ; -- status=guess
lin regulatory_A = variants{} ; -- 
lin cylinder_N = mkN "cilindro" ; -- status=guess
lin curiosity_N = mkN "curiosidad" ; -- status=guess
lin resident_A = variants{} ; -- 
lin narrative_N = mkN "narrativa" ; -- status=guess
lin cognitive_A = mkA "cognitivo" ; -- status=guess
lin lengthy_A = variants{} ; -- 
lin gothic_A = variants{} ; -- 
lin dip_V2 = mkV2 (mkV "mojar") ; -- status=guess
lin dip_V = mkV "mojar" ; -- status=guess
lin adverse_A = mkA "contrario" ; -- status=guess
lin accountability_N = mkN "responsabilidad" feminine ; -- status=guess
lin hydrogen_N = mkN "hidrógeno" ; -- status=guess
lin gravel_N = mkN "grava" | mkN "gravilla" ; -- status=guess
lin willingness_N = variants{} ; -- 
lin inhibit_V2 = mkV2 (mkV "inhibir") ; -- status=guess
lin attain_V2 = mkV2 (mkV "lograr") | mkV2 (conseguir_V) ; -- status=guess
lin attain_V = mkV "lograr" | conseguir_V ; -- status=guess
lin specialize_V2 = variants{} ; -- 
lin specialize_V = variants{} ; -- 
lin steer_V2 = mkV2 (mantener_V) ; -- status=guess
lin steer_V = mantener_V ; -- status=guess
lin selected_A = variants{} ; -- 
lin like_N = mkN "gustos" masculine | mkN "preferencias" feminine ; -- status=guess
lin confer_V2 = mkV2 (conferir_V) ; -- status=guess
lin confer_V = conferir_V ; -- status=guess
lin usage_N = variants{} ; -- 
lin portray_V2 = mkV2 (describir_V) ; -- status=guess
lin planner_N = variants{} ; -- 
lin manual_A = mkA "manual" ; -- status=guess
lin boast_VS = mkVS (mkV "ostentar") ; -- status=guess
lin boast_V2 = mkV2 (mkV "ostentar") ; -- status=guess
lin boast_V = mkV "ostentar" ; -- status=guess
lin unconscious_A = variants{} ; -- 
lin jail_N = variants{} ; -- 
lin fertility_N = variants{} ; -- 
lin documentation_N = mkN "documentación" feminine ; -- status=guess
lin wolf_N = mkN "lobo" ; -- status=guess
lin patent_N = mkN "patente" masculine ; -- status=guess
lin exit_N = mkN "salida" masculine | mkN "partida" ; -- status=guess
lin corps_N = variants{} ; -- 
lin proclaim_VS = mkVS (mkV "proclamar") ; -- status=guess
lin proclaim_V2 = mkV2 (mkV "proclamar") ; -- status=guess
lin multiply_V2 = mkV2 (mkV "multiplicar") ; -- status=guess
lin multiply_V = mkV "multiplicar" ; -- status=guess
lin brochure_N = mkN "folleto" ; -- status=guess
lin screen_V2 = mkV2 (mkV "filtrar") | mkV2 (mkV "tamizar") ; -- status=guess
lin screen_V = mkV "filtrar" | mkV "tamizar" ; -- status=guess
lin orthodox_A = mkA "ortodoxo" ; -- status=guess
lin locomotive_N = mkN "locomotora" masculine ; -- status=guess
lin considering_Prep = variants{} ; -- 
lin unaware_A = mkA "inconsciente" | mkA "desprevenido" ; -- status=guess
lin syndrome_N = mkN "síndrome" masculine ; -- status=guess
lin reform_V2 = mkV2 (mkV "reformar") ; -- status=guess
lin reform_V = mkV "reformar" ; -- status=guess
lin confirmation_N = mkN "confirmación" feminine ; -- status=guess
lin printed_A = variants{} ; -- 
lin curve_V2 = variants{} ; -- 
lin curve_V = variants{} ; -- 
lin costly_A = mkA "costosamente" ; -- status=guess
lin underground_A = mkA "subterráneo" ; -- status=guess
lin territorial_A = mkA "territorial" ; -- status=guess
lin designate_VS = variants{} ; -- 
lin designate_V2V = variants{} ; -- 
lin designate_V2 = variants{} ; -- 
lin designate_V = variants{} ; -- 
lin comfort_V2 = variants{} ; -- 
lin plot_V2 = variants{} ; -- 
lin plot_V = variants{} ; -- 
lin misleading_A = variants{} ; -- 
lin weave_V2 = mkV2 (mkV "tejer") | mkV2 (mkV "entretejer") ; -- status=guess
lin weave_V = mkV "tejer" | mkV "entretejer" ; -- status=guess
lin scratch_V2 = L.scratch_V2 ;
lin scratch_V = mkV "arañar" | mkV "rasguñar" ; -- status=guess
lin echo_N = mkN "eco" ; -- status=guess
lin ideally_Adv = variants{} ; -- 
lin endure_V2 = mkV2 (mkV "aguantar") | mkV2 (mkV "perdurar") ; -- status=guess
lin endure_V = mkV "aguantar" | mkV "perdurar" ; -- status=guess
lin verbal_A = mkA "verbal" ; -- status=guess
lin stride_V2 = variants{} ; -- 
lin stride_V = variants{} ; -- 
lin nursing_N = variants{} ; -- 
lin exert_V2 = mkV2 (ejercer_V) | mkV2 (mkV "aplicar") ; -- status=guess
lin compatible_A = mkA "compatible" ; -- status=guess
lin causal_A = mkA "causal" ; -- status=guess
lin mosaic_N = variants{} ; -- 
lin manor_N = variants{} ; -- 
lin implicit_A = mkA "implícito" ; -- status=guess
lin following_Prep = variants{} ; -- 
lin fashionable_A = variants{} ; -- 
lin valve_N = mkN "válvula" | mkN "llave" feminine ; -- status=guess
lin proceed_N = variants{} ; -- 
lin sofa_N = mkN "sofá" masculine ; -- status=guess
lin snatch_V2 = mkV2 (mkV "raptar") ; -- status=guess
lin snatch_V = mkV "raptar" ; -- status=guess
lin jazz_N = mkN "jazz" masculine ; -- status=guess
lin patron_N = mkN "cliente" masculine ; -- status=guess
lin provider_N = mkN "suministrador" masculine ; -- status=guess
lin interim_A = mkA "interino" ; -- status=guess
lin intent_N = mkN "intención" feminine | mkN "intento" | mkN "propósito" ; -- status=guess
lin chosen_A = variants{} ; -- 
lin applied_A = variants{} ; -- 
lin shiver_V2 = mkV2 (mkV "tiritar") | mkV2 (mkV (mkV "temblar") "de frio") | mkV2 (mkV "escalofrio") ; -- status=guess
lin shiver_V = mkV "tiritar" | mkV (mkV "temblar") "de frio" | mkV "escalofrio" ; -- status=guess
lin pie_N = mkN "pastel" feminine ; -- status=guess
lin fury_N = mkN "furia" | mkN "rabia" | mkN "furor" masculine ; -- status=guess
lin abolition_N = mkN "abolición" feminine ; -- status=guess
lin soccer_N = mkN "fútbol" | mkN " futbol" | mkN "balompié" | mkN "balón-pie" | mkN " pambol" ; -- status=guess
lin corpse_N = mkN "cadáver" masculine ; -- status=guess
lin accusation_N = mkN "acusación" feminine ; -- status=guess
lin kind_A = mkA "amable" | mkA "bondadoso" | mkA "gentil" | mkA "cariñoso" ; -- status=guess
lin dead_Adv = variants{} ; -- 
lin nursing_A = variants{} ; -- 
lin contempt_N = mkN "desgracia" | mkN "deshonra" | mkN "vergüenza" ; -- status=guess
lin prevail_V2 = mkV2 (prevalecer_V) ; -- status=guess
lin prevail_V = prevalecer_V ; -- status=guess
lin murderer_N = mkN "asesino" | mkN "asesina" ; -- status=guess
lin liberal_N = mkN "libertario" | mkN "libertaria" ; -- status=guess
lin gathering_N = variants{} ; -- 
lin adequately_Adv = variants{} ; -- 
lin subjective_A = mkA "subjetivo" ; -- status=guess
lin disagreement_N = variants{} ; -- 
lin cleaner_N = variants{} ; -- 
lin boil_V2 = mkV2 (hervir_V) | mkV2 (bullir_V) ; -- status=guess
lin boil_V = hervir_V | bullir_V ; -- status=guess
lin static_A = mkA "estática" ; -- status=guess
lin scent_N = mkN "olor" masculine ; -- status=guess
lin civilian_N = variants{} ; -- 
lin monk_N = mkN "monje" masculine ; -- status=guess
lin abruptly_Adv = variants{} ; -- 
lin keyboard_N = mkN "teclado" ; -- status=guess
lin hammer_N = mkN "martillo" ; -- status=guess
lin despair_N = mkN "desesperación" feminine ; -- status=guess
lin controller_N = mkN "controlador" masculine ; -- status=guess
lin yell_V2 = mkV2 (mkV "gritar") | mkV2 (mkV (mkV "hablar") "alto") ; -- status=guess
lin yell_V = mkV "gritar" | mkV (mkV "hablar") "alto" ; -- status=guess
lin entail_V2 = mkV2 (mkV "conllevar") ; -- status=guess
lin cheerful_A = mkA "animado" ; -- status=guess
lin reconstruction_N = mkN "reconstrucción" feminine | mkN "restauración" feminine ; -- status=guess
lin patience_N = mkN "paciencia" ; -- status=guess
lin legally_Adv = variants{} ; -- 
lin habitat_N = mkN "habitación" | mkN "habitat" ; -- status=guess
lin queue_N = mkN "coleta" ; -- status=guess
lin spectator_N = variants{} ; -- 
lin given_A = variants{} ; -- 
lin purple_A = mkA "morado" ; -- status=guess
lin outlook_N = variants{} ; -- 
lin genius_N = mkN "genio" ; -- status=guess
lin dual_A = mkA "doble" ; -- status=guess
lin canvas_N = mkN "lienzo" | mkN "tela" ; -- status=guess
lin grave_A = mkA "serio" | mkA "seco" | mkA "solemne" | mkA "reservado" | mkA "sombrío" ; -- status=guess
lin pepper_N = mkN "pimiento" ; -- status=guess
lin conform_V2 = variants{} ; -- 
lin conform_V = variants{} ; -- 
lin cautious_A = mkA "cauto" | mkA "cauteloso" ; -- status=guess
lin dot_N = mkN "punto" ; -- status=guess
lin conspiracy_N = mkN "conspiración" feminine ; -- status=guess
lin butterfly_N = mkN "mariposa" ; -- status=guess
lin sponsor_N = mkN "patrocinador" masculine ; -- status=guess
lin sincerely_Adv = variants{} ; -- 
lin rating_N = mkN "calificación" feminine | mkN "evaluación" feminine ; -- status=guess
lin weird_A = variants{} ; -- 
lin teenage_A = variants{} ; -- 
lin salmon_N = mkN "salmón" masculine ; -- status=guess
lin recorder_N = mkN "flauta dulce" ; -- status=guess
lin postpone_V2 = mkV2 (mkV "aplazar") | mkV2 (mkV "postergar") | mkV2 (mkV "atrasar") | mkV2 (mkV "perecear") | mkV2 (posponer_V) ; -- status=guess
lin maid_N = mkN "criada" | mkN "doméstica" ; -- status=guess
lin furnish_V2 = mkV2 (amoblar_V) | mkV2 (mkV "amueblar") ; -- status=guess
lin ethical_A = mkA "ético" ; -- status=guess
lin bicycle_N = mkN "bicicleta" ; -- status=guess
lin sick_N = mkN "baja médica" | mkN "incapacidad temporal" ; -- status=guess
lin sack_N = mkN "bolsa" | mkN "saco" ; -- status=guess
lin renaissance_N = variants{} ; -- 
lin luxury_N = mkN "lujo" ; -- status=guess
lin gasp_V2 = mkV2 (mkV "jadear") ; -- status=guess
lin gasp_V = mkV "jadear" ; -- status=guess
lin wardrobe_N = mkN "armario" | mkN "ropero" | mkN "clóset" masculine | mkN "escaparate" | mkN "empotrado" | mkN "placard" masculine ; -- status=guess
lin native_N = mkN "indígena" masculine ; -- status=guess
lin fringe_N = mkN "orla" ; -- status=guess
lin adaptation_N = mkN "ajuste" | mkN "modificación" feminine ; -- status=guess
lin quotation_N = mkN "cita" | mkN "citación" feminine ; -- status=guess
lin hunger_N = mkN "hambre" feminine ; -- status=guess
lin enclose_V2 = variants{} ; -- 
lin disastrous_A = mkA "desastroso" ; -- status=guess
lin choir_N = mkN "coro" ; -- status=guess
lin overwhelming_A = variants{} ; -- 
lin glimpse_N = variants{} ; -- 
lin divorce_V2 = variants{} ; -- 
lin circular_A = mkA "circular" ; -- status=guess
lin locality_N = variants{} ; -- 
lin ferry_N = mkN "ferri" masculine | mkN "transbordador" | mkN "ferry" masculine ; -- status=guess
lin balcony_N = mkN "balcón" masculine ; -- status=guess
lin sailor_N = mkN "marinero" ; -- status=guess
lin precision_N = mkN "precisión" feminine ; -- status=guess
lin desert_V2 = mkV2 (mkV "abandonar") ; -- status=guess
lin desert_V = mkV "abandonar" ; -- status=guess
lin dancing_N = variants{} ; -- 
lin alert_V2 = mkV2 (mkV "alertar") ; -- status=guess
lin surrender_V2 = mkV2 (mkV "rendirse") | mkV2 (mkV "capitular") ; -- status=guess
lin surrender_V = mkV "rendirse" | mkV "capitular" ; -- status=guess
lin archive_N = mkN "archivo" ; -- status=guess
lin jump_N = mkN "salto" ; -- status=guess
lin philosopher_N = mkN "filósofo" | mkN "filósofa" ; -- status=guess
lin revival_N = variants{} ; -- 
lin presume_VV = variants{} ; -- 
lin presume_VS = variants{} ; -- 
lin presume_V2 = variants{} ; -- 
lin presume_V = variants{} ; -- 
lin node_N = mkN "nodo" ; -- status=guess
lin fantastic_A = mkA "fantástico" ; -- status=guess
lin herb_N = mkN "hierba" ; -- status=guess
lin assertion_N = mkN "afirmación" feminine | mkN "aserto" ; -- status=guess
lin thorough_A = mkA "minucioso" ; -- status=guess
lin quit_V2 = mkV2 (mkV "dejar") | mkV2 (mkV "parar") ; -- status=guess
lin quit_V = mkV "dejar" | mkV "parar" ; -- status=guess
lin grim_A = variants{} ; -- 
lin fair_N = mkN "feria" ; -- status=guess
lin broadcast_V2 = variants{} ; -- 
lin broadcast_V = variants{} ; -- 
lin annoy_V2 = mkV2 (mkV "molestar") | mkV2 (mkV "agobiar") ; -- status=guess
lin divert_V2 = mkV2 (entretener_V) | mkV2 (distraer_V) | mkV2 (mkV "desviar") ; -- status=guess
lin divert_V = entretener_V | distraer_V | mkV "desviar" ; -- status=guess
lin accelerate_V2 = mkV2 (mkV "acelerarse") ; -- status=guess
lin accelerate_V = mkV "acelerarse" ; -- status=guess
lin polymer_N = mkN "polímero" ; -- status=guess
lin sweat_N = mkN "sudor" masculine ; -- status=guess
lin survivor_N = mkN "sobreviviente" | mkN "superviviente" ; -- status=guess
lin subscription_N = variants{} ; -- 
lin repayment_N = variants{} ; -- 
lin anonymous_A = mkA "anónimo" ; -- status=guess
lin summarize_V2 = mkV2 (mkV "resumir") | mkV2 (mkV "recapitular") ; -- status=guess
lin punch_N = mkN "ponche" masculine ; -- status=guess
lin lodge_V2 = mkV2 (mkV "alojar") | mkV2 (mkV "albergar") ; -- status=guess
lin lodge_V = mkV "alojar" | mkV "albergar" ; -- status=guess
lin landowner_N = mkN "terrateniente" masculine ; -- status=guess
lin ignorance_N = mkN "ignorancia" ; -- status=guess
lin discourage_V2 = mkV2 (mkV (mkV "descorazonar") "acobardar") ; -- status=guess
lin bride_N = mkN "novia" ; -- status=guess
lin likewise_Adv = mkAdv "similarmente" ; -- status=guess
lin depressed_A = variants{} ; -- 
lin abbey_N = mkN "abadía" ; -- status=guess
lin quarry_N = mkN "cantera" ; -- status=guess
lin archbishop_N = mkN "arzobispo" ; -- status=guess
lin sock_N = L.sock_N ;
lin large_scale_A = variants{} ; -- 
lin glare_V2 = variants{} ; -- 
lin glare_V = variants{} ; -- 
lin descent_N = mkN "descenso" feminine ; -- status=guess
lin stumble_V = tropezar_V ; -- status=guess
lin mistress_N = mkN "maestra" ; -- status=guess
lin empty_V2 = mkV2 (mkV "vaciar") ; -- status=guess
lin empty_V = mkV "vaciar" ; -- status=guess
lin prosperity_N = mkN "prosperidad" feminine ; -- status=guess
lin harm_V2 = mkV2 (mkV "dañar") ; -- status=guess
lin formulation_N = variants{} ; -- 
lin atomic_A = mkA "atómico" ; -- status=guess
lin agreed_A = variants{} ; -- 
lin wicked_A = mkA "malvado" ; -- status=guess
lin threshold_N = mkN "umbral" masculine ; -- status=guess
lin lobby_N = variants{} ; -- 
lin repay_V2 = variants{} ; -- 
lin repay_V = variants{} ; -- 
lin varying_A = variants{} ; -- 
lin track_V2 = variants{} ; -- 
lin track_V = variants{} ; -- 
lin crawl_V = mkV "humillarse" | mkV (mkV "humillarse") "ante" | mkV "arrastrarse" ; -- status=guess
lin tolerate_V2 = mkV2 (mkV "tolerar") | mkV2 (mkV "soportar") ; -- status=guess
lin salvation_N = mkN "salvación" feminine ; -- status=guess
lin pudding_N = mkN "pudin" | mkN "pudín" masculine ; -- status=guess
lin counter_VS = mkVS (mkV "contraatacar") ; -- status=guess
lin counter_V2 = mkV2 (mkV "contraatacar") ; -- status=guess
lin counter_V = mkV "contraatacar" ; -- status=guess
lin propaganda_N = mkN "propaganda" ; -- status=guess
lin cage_N = mkN "jaula" ; -- status=guess
lin broker_N = mkN "corredor" masculine | mkN "intermediario" ; -- status=guess
lin ashamed_A = mkA "avergonzado" | mkA "abochornado" | mkA "apenado" ; -- status=guess
lin scan_V2 = mkV2 (mkV "escanear") ; -- status=guess
lin scan_V = mkV "escanear" ; -- status=guess
lin document_V2 = mkV2 (mkV "documentar") ; -- status=guess
lin apparatus_N = mkN "aparato" | mkN "equipo" ; -- status=guess
lin theology_N = mkN "teología" ; -- status=guess
lin analogy_N = mkN "analogía" ; -- status=guess
lin efficiently_Adv = variants{} ; -- 
lin bitterly_Adv = variants{} ; -- 
lin performer_N = mkN "artista" masculine ; -- status=guess
lin individually_Adv = variants{} ; -- 
lin amid_Prep = variants{} ; -- 
lin squadron_N = mkN "cuadrilla" ; -- status=guess
lin sentiment_N = variants{} ; -- 
lin making_N = variants{} ; -- 
lin exotic_A = mkA "exótico" ; -- status=guess
lin dominance_N = variants{} ; -- 
lin coherent_A = mkA "coherente" ; -- status=guess
lin placement_N = variants{} ; -- 
lin flick_V2 = variants{} ; -- 
lin colourful_A = variants{} ; -- 
lin mercy_N = mkN "piedad" feminine ; -- status=guess
lin angrily_Adv = variants{} ; -- 
lin amuse_V2 = mkV2 (divertir_V) ; -- status=guess
lin mainstream_N = mkN "común y corriente" ; -- status=guess
lin appraisal_N = mkN "evaluación" feminine | mkN "valoración" feminine | mkN "tasación" feminine ; -- status=guess
lin annually_Adv = variants{} ; -- 
lin torch_N = mkN "lámpara" | mkN "linterna" ; -- status=guess
lin intimate_A = variants{} ; -- 
lin gold_A = variants{} ; -- 
lin arbitrary_A = mkA "arbitrario" ; -- status=guess
lin venture_VS = mkVS (mkV "arriesgar") ; -- status=guess
lin venture_V2 = mkV2 (mkV "arriesgar") ; -- status=guess
lin venture_V = mkV "arriesgar" ; -- status=guess
lin preservation_N = variants{} ; -- 
lin shy_A = mkA "tímido" ; -- status=guess
lin disclosure_N = mkN "revelación" feminine | mkN "destape " ; -- status=guess
lin lace_N = mkN "cordón" masculine ; -- status=guess
lin inability_N = mkN "incapacidad" feminine ; -- status=guess
lin motif_N = mkN "motivo" ; -- status=guess
lin listener_N = variants{} ; -- 
lin hunt_N = mkN "caza" ; -- status=guess
lin delicious_A = mkA "delicioso" | mkA "sabroso" | mkA "rico" | mkA "gustoso" | mkA "apetitoso" ; -- status=guess
lin term_VS = variants{} ; -- 
lin term_V2 = variants{} ; -- 
lin substitute_N = mkN "sustituto" | mkN "substituto" ; -- status=guess
lin highway_N = mkN "carretera" ; -- status=guess
lin haul_V2 = mkV2 (mkV "empujar") | mkV2 (mkV (mkV "tirar") "fuerte") ; -- status=guess
lin haul_V = mkV "empujar" | mkV (mkV "tirar") "fuerte" ; -- status=guess
lin dragon_N = mkN "dragón" feminine | mkN "guiverno" ; -- status=guess
lin chair_V2 = variants{} ; -- 
lin accumulate_V2 = mkV2 (mkV "acumularse") ; -- status=guess
lin accumulate_V = mkV "acumularse" ; -- status=guess
lin unchanged_A = variants{} ; -- 
lin sediment_N = mkN "sedimento" ; -- status=guess
lin sample_V2 = mkV2 (mkV "samplear") ; -- status=guess
lin exclaim_VQ = mkVQ (mkV "exclamar") ; -- status=guess
lin exclaim_V2 = mkV2 (mkV "exclamar") ; -- status=guess
lin exclaim_V = mkV "exclamar" ; -- status=guess
lin fan_V2 = mkV2 (mkV "abanicar") | mkV2 (mkV "ventilar") ; -- status=guess
lin fan_V = mkV "abanicar" | mkV "ventilar" ; -- status=guess
lin volunteer_VS = variants{} ; -- 
lin volunteer_V2V = variants{} ; -- 
lin volunteer_V2 = variants{} ; -- 
lin volunteer_V = variants{} ; -- 
lin root_V2 = mkV2 (mkV "rebuscar") | mkV2 (mkV "hurgar") ; -- status=guess
lin root_V = mkV "rebuscar" | mkV "hurgar" ; -- status=guess
lin parcel_N = mkN "paquete" masculine ; -- status=guess
lin psychiatric_A = mkA "psiquiátrico" ; -- status=guess
lin delightful_A = mkA "delicioso" ; -- status=guess
lin confidential_A = mkA "confidencial" ; -- status=guess
lin calorie_N = mkN "caloría" ; -- status=guess
lin flash_N = mkN "relámpago" feminine ; -- status=guess
lin crowd_V2 = variants{} ; -- 
lin crowd_V = variants{} ; -- 
lin aggregate_A = mkA "total" | mkA "conjunto" ; -- status=guess
lin scholarship_N = mkN "erudición" feminine | mkN "sabiduría" ; -- status=guess
lin monitor_N = mkN "monitor" masculine ; -- status=guess
lin disciplinary_A = mkA "disciplinario" ; -- status=guess
lin rock_V2 = mkV2 (mecer_V) ; -- status=guess
lin rock_V = mecer_V ; -- status=guess
lin hatred_N = mkN "odio" ; -- status=guess
lin pill_N = mkN "bicho bola" | mkN "bicho bolita" ; -- status=guess
lin noisy_A = mkA "ruidoso" ; -- status=guess
lin feather_N = L.feather_N ;
lin lexical_A = mkA "léxico" ; -- status=guess
lin staircase_N = mkN "escalera" ; -- status=guess
lin autonomous_A = mkA "autónomo" ; -- status=guess
lin viewpoint_N = variants{} ; -- 
lin projection_N = mkN "proyección" feminine ; -- status=guess
lin offensive_A = mkA "ofensivo" | mkA "ofensiva" ; -- status=guess
lin controlled_A = variants{} ; -- 
lin flush_V2 = variants{} ; -- 
lin flush_V = variants{} ; -- 
lin racism_N = mkN "racismo" ; -- status=guess
lin flourish_V2 = mkV2 (mkV "prosperar") ; -- status=guess
lin flourish_V = mkV "prosperar" ; -- status=guess
lin resentment_N = mkN "resentimiento" ; -- status=guess
lin pillow_N = mkN "almohada" ; -- status=guess
lin courtesy_N = mkN "cortesía" ; -- status=guess
lin photography_N = mkN "fotografía" ; -- status=guess
lin monkey_N = mkN "mono" | mkN "chango" ; -- status=guess
lin glorious_A = mkA "glorioso" ; -- status=guess
lin evolutionary_A = mkA "evolutivo" | mkA "evolucionista" | mkA "evolucionario" ; -- status=guess
lin gradual_A = mkA "gradual" | mkA "paulatino" ; -- status=guess
lin bankruptcy_N = mkN "bancarrota" ; -- status=guess
lin sacrifice_N = mkN "sacrificio" ; -- status=guess
lin uphold_V2 = mkV2 (mkV "elevar") ; -- status=guess
lin sketch_N = mkN "esbozo" | mkN "bosquejo" | mkN "esquicio" ; -- status=guess
lin presidency_N = mkN "presidencia" ; -- status=guess
lin formidable_A = variants{} ; -- 
lin differentiate_V2 = mkV2 (mkV "diferenciar") ; -- status=guess
lin differentiate_V = mkV "diferenciar" ; -- status=guess
lin continuing_A = variants{} ; -- 
lin cart_N = mkN "carro" feminine | mkN "carreta" ; -- status=guess
lin stadium_N = mkN "estadio" ; -- status=guess
lin dense_A = mkA "compacto" | mkA "macizo" ; -- status=guess
lin catch_N = mkN "pega" | mkN "traba" | mkN "truco" | mkN "cuestión" feminine | mkN "trampa" ; -- status=guess
lin beyond_Adv = variants{} ; -- 
lin immigration_N = mkN "inmigración" feminine ; -- status=guess
lin clarity_N = mkN "claridad" feminine ; -- status=guess
lin worm_N = L.worm_N ;
lin slot_N = mkN "ranura" ; -- status=guess
lin rifle_N = mkN "fusil" | mkN "rifle" masculine ; -- status=guess
lin screw_V2 = mkV2 (mkV "atornillar") ; -- status=guess
lin screw_V = mkV "atornillar" ; -- status=guess
lin harvest_N = mkN "ácaros de la cosecha" | mkN "ácaros rojos" ; -- status=guess
lin foster_V2 = mkV2 (mkV "fomentar") ; -- status=guess
lin academic_N = mkN "académico" | mkN "escolar" masculine ; -- status=guess
lin impulse_N = mkN "impulso" ; -- status=guess
lin guardian_N = mkN "ángel protector" ; -- status=guess
lin ambiguity_N = mkN "ambigüedad" feminine ; -- status=guess
lin triangle_N = mkN "desigualdad del triángulo" ; -- status=guess
lin terminate_V2 = mkV2 (mkV "terminar") | mkV2 (mkV "acabar") ; -- status=guess
lin terminate_V = mkV "terminar" | mkV "acabar" ; -- status=guess
lin retreat_V2 = mkV2 (mkV "retirarse") ; -- status=guess
lin retreat_V = mkV "retirarse" ; -- status=guess
lin pony_N = mkN "poni" | mkN "caballito" ; -- status=guess
lin outdoor_A = variants{} ; -- 
lin deficiency_N = mkN "deficiencia" | mkN "insuficiencia" ; -- status=guess
lin decree_N = mkN "decreto" ; -- status=guess
lin apologize_V = mkV "disculparse" ; -- status=guess
lin yarn_N = mkN "hilo" | mkN "hilado" ; -- status=guess
lin staff_V2 = variants{} ; -- 
lin renewal_N = variants{} ; -- 
lin rebellion_N = mkN "rebelión" feminine | mkN "insurrección" feminine ; -- status=guess
lin incidentally_Adv = variants{} ; -- 
lin flour_N = mkN "harina" ; -- status=guess
lin developed_A = variants{} ; -- 
lin chorus_N = mkN "coro" ; -- status=guess
lin ballot_N = mkN "candidatura" ; -- status=guess
lin appetite_N = mkN "apetito" | mkN "deseo" | mkN "ganas" feminine ; -- status=guess
lin stain_V2 = mkV2 (mkV "manchar") ; -- status=guess
lin stain_V = mkV "manchar" ; -- status=guess
lin notebook_N = mkN "cuaderno" ; -- status=guess
lin loudly_Adv = variants{} ; -- 
lin homeless_A = mkA "sin hogar" | mkA "desamparado" ; -- status=guess
lin census_N = mkN "censo" ; -- status=guess
lin bizarre_A = mkA "extraño" | mkA "extrañisimo" | mkA "estrafalario" ; -- status=guess
lin striking_A = mkA "llamativo" ; -- status=guess
lin greenhouse_N = mkN "invernadero" ; -- status=guess
lin part_V2 = mkV2 (mkV "partirse") | mkV2 (mkV "apartarse") ; -- status=guess
lin part_V = mkV "partirse" | mkV "apartarse" ; -- status=guess
lin burial_N = mkN "entierro" ; -- status=guess
lin embarrassed_A = variants{} ; -- 
lin ash_N = mkN "ceniza" ; -- status=guess
lin actress_N = mkN "actriz" feminine ; -- status=guess
lin cassette_N = mkN "casete" masculine ; -- status=guess
lin privacy_N = mkN "intimidad" feminine ; -- status=guess
lin fridge_N = L.fridge_N ;
lin feed_N = mkN "alimentar" ; -- status=guess
lin excess_A = variants{} ; -- 
lin calf_N = mkN "pantorrilla" ; -- status=guess
lin associate_N = mkN "asociado" ; -- status=guess
lin ruin_N = mkN "ruina" ; -- status=guess
lin jointly_Adv = variants{} ; -- 
lin drill_V2 = mkV2 (mkV "averiguar") ; -- status=guess
lin drill_V = mkV "averiguar" ; -- status=guess
lin photograph_V2 = mkV2 (mkV "fotografiar") | mkV2 (mkV (mkV "tomar") "una foto") ; -- status=guess
lin devoted_A = variants{} ; -- 
lin indirectly_Adv = variants{} ; -- 
lin driving_A = variants{} ; -- 
lin memorandum_N = mkN "memorándum" masculine ; -- status=guess
lin default_N = mkN "programaciones originales" | mkN "defecto" | mkN "ajustes por defecto" | mkN "configuración predeterminada" ; -- status=guess
lin costume_N = mkN "traje" masculine ; -- status=guess
lin variant_N = mkN "variante" feminine ; -- status=guess
lin shatter_V2 = mkV2 (mkV "astillar") | mkV2 (mkV "estrellar") | mkV2 (mkV (mkV "hacer") "añicos") ; -- status=guess
lin shatter_V = mkV "astillar" | mkV "estrellar" | mkV (mkV "hacer") "añicos" ; -- status=guess
lin methodology_N = variants{} ; -- 
lin frame_V2 = mkV2 (mkV "enmarcar") ; -- status=guess
lin frame_V = mkV "enmarcar" ; -- status=guess
lin allegedly_Adv = variants{} ; -- 
lin swell_V2 = mkV2 (mkV "hincharse") | mkV2 (mkV "inflarse") ; -- status=guess
lin swell_V = L.swell_V ;
lin investigator_N = mkN "investigador" | mkN "investigadora" ; -- status=guess
lin imaginative_A = mkA "imaginativo" ; -- status=guess
lin bored_A = variants{} ; -- 
lin bin_N = mkN "bote de basura" ; -- status=guess
lin awake_A = mkA "listo" | mkA "despierto" ; -- status=guess
lin recycle_V2 = mkV2 (mkV "reciclar") ; -- status=guess
lin group_V2 = mkV2 (mkV "agrupar") ; -- status=guess
lin group_V = mkV "agrupar" ; -- status=guess
lin enjoyment_N = variants{} ; -- 
lin contemporary_N = variants{} ; -- 
lin texture_N = mkN "textura" ; -- status=guess
lin donor_N = mkN "donador" | mkN "donante" masculine ; -- status=guess
lin bacon_N = mkN "tocino" ; -- status=guess
lin sunny_A = mkA "asoleado" | mkA "soleado" ; -- status=guess
lin stool_N = mkN "taburete" masculine | mkN "silla" ; -- status=guess
lin prosecute_V2 = variants{} ; -- 
lin commentary_N = variants{} ; -- 
lin bass_N = mkN "clarinete bajo" ; -- status=guess
lin sniff_VS = mkVS (mkV "olfatear") ; -- status=guess
lin sniff_V2 = mkV2 (mkV "olfatear") ; -- status=guess
lin sniff_V = mkV "olfatear" ; -- status=guess
lin repetition_N = mkN "repetición" feminine ; -- status=guess
lin eventual_A = mkA "eventual" ; -- status=guess
lin credit_V2 = variants{} ; -- 
lin suburb_N = mkN "afueras" feminine | mkN "arrabal" masculine ; -- status=guess
lin newcomer_N = mkN "recién llegado" | mkN "recién llegada" ; -- status=guess
lin romance_N = mkN "romance" masculine ; -- status=guess
lin film_V2 = mkV2 (mkV "filmar") | mkV2 (rodar_V) | mkV2 (mkV "cinematografiar") ; -- status=guess
lin film_V = mkV "filmar" | rodar_V | mkV "cinematografiar" ; -- status=guess
lin experiment_V2 = mkV2 (mkV "experimentar") ; -- status=guess
lin experiment_V = mkV "experimentar" ; -- status=guess
lin daylight_N = mkN "horario de verano" ; -- status=guess
lin warrant_N = mkN "cédula" ; -- status=guess
lin fur_N = mkN "cuero" ; -- status=guess
lin parking_N = mkN "estacionamiento" | mkN "aparcamiento" ; -- status=guess
lin nuisance_N = mkN "molestia" | mkN "engorro" | mkN "incomodidad" feminine ; -- status=guess
lin civilian_A = variants{} ; -- 
lin foolish_A = mkA "tonto" | mkA "necio" | mkA "inprudente" ; -- status=guess
lin bulb_N = mkN "bulbo" ; -- status=guess
lin balloon_N = mkN "globo" ; -- status=guess
lin vivid_A = variants{} ; -- 
lin surveyor_N = mkN "agrimensor" masculine ; -- status=guess
lin spontaneous_A = mkA "espontáneo" ; -- status=guess
lin biology_N = mkN "biología" ; -- status=guess
lin injunction_N = variants{} ; -- 
lin appalling_A = mkA "asombroso" ; -- status=guess
lin amusement_N = mkN "diversión" feminine ; -- status=guess
lin aesthetic_A = mkA "estético" ; -- status=guess
lin vegetation_N = mkN "vegetación" feminine ; -- status=guess
lin stab_V2 = L.stab_V2 ;
lin stab_V = mkV "apuñalar" | mkV "acuchillar" ; -- status=guess
lin rude_A = mkA "rudo" ; -- status=guess
lin offset_V2 = mkV2 (mkV "compensar") ; -- status=guess
lin thinking_N = variants{} ; -- 
lin mainframe_N = variants{} ; -- 
lin flock_N = mkN "bandada" ; -- status=guess
lin amateur_A = variants{} ; -- 
lin academy_N = mkN "academia" ; -- status=guess
lin shilling_N = mkN "chelín" masculine ; -- status=guess
lin reluctance_N = mkN "reluctancia magnética" ; -- status=guess
lin velocity_N = mkN "velocidad" feminine ; -- status=guess
lin spare_V2 = variants{} ; -- 
lin spare_V = variants{} ; -- 
lin wartime_N = mkN "tiempo de guerra" ; -- status=guess
lin soak_V2 = mkV2 (mkV "esponjar") ; -- status=guess
lin soak_V = mkV "esponjar" ; -- status=guess
lin rib_N = mkN "caja toraxica" ; -- status=guess
lin mighty_A = mkA "poderoso" ; -- status=guess
lin shocked_A = variants{} ; -- 
lin vocational_A = variants{} ; -- 
lin spit_V2 = mkV2 (mkV "escupir") ; -- status=guess
lin spit_V = L.spit_V ;
lin gall_N = mkN "hiel" feminine ; -- status=guess
lin bowl_V2 = variants{} ; -- 
lin bowl_V = variants{} ; -- 
lin prescription_N = mkN "receta" ; -- status=guess
lin fever_N = mkN "fiebre" feminine ; -- status=guess
lin axis_N = mkN "eje" masculine ; -- status=guess
lin reservoir_N = mkN "embalse" masculine ; -- status=guess
lin magnitude_N = mkN "magnitud" feminine ; -- status=guess
lin rape_V2 = mkV2 (mkV "violar") ; -- status=guess
lin cutting_N = mkN "esqueje" ; -- status=guess
lin bracket_N = mkN "paréntesis" masculine ; -- status=guess
lin agony_N = mkN "agonía" | mkN "angustia" ; -- status=guess
lin strive_VV = mkVV (mkV "esforzarse") ; -- status=guess
lin strive_V = mkV "esforzarse" ; -- status=guess
lin strangely_Adv = variants{} ; -- 
lin pledge_VS = mkVS (mkV "hipotecar") | mkVS (mkV "empeñar") ; -- status=guess
lin pledge_V2V = mkV2V (mkV "hipotecar") | mkV2V (mkV "empeñar") ; -- status=guess
lin pledge_V2 = mkV2 (mkV "hipotecar") | mkV2 (mkV "empeñar") ; -- status=guess
lin recipient_N = mkN "receptor" masculine ; -- status=guess
lin moor_N = mkN "brezal" | mkN "pantano" | mkN "páramo" ; -- status=guess
lin invade_V2 = mkV2 (mkV "invadir") ; -- status=guess
lin dairy_N = mkN " tiendita" | mkN "minisúper" | mkN "supercito" feminine ; -- status=guess
lin chord_N = mkN "acorde" masculine ; -- status=guess
lin shrink_V2 = mkV2 (mkV "zafarse") | mkV2 (rehuir_V) | mkV2 (mkV "correrse") ; -- status=guess
lin shrink_V = mkV "zafarse" | rehuir_V | mkV "correrse" ; -- status=guess
lin poison_N = mkN "veneno" ; -- status=guess
lin pillar_N = mkN "pilar" masculine ; -- status=guess
lin washing_N = mkN "lavadora" ; -- status=guess
lin warrior_N = mkN "guerrero" ; -- status=guess
lin supervisor_N = mkN "supervisor" masculine | mkN "director" masculine ; -- status=guess
lin outfit_N = mkN "tenida" ; -- status=guess
lin innovative_A = mkA "innovador" ; -- status=guess
lin dressing_N = mkN "vendaje" masculine ; -- status=guess
lin dispute_V2 = variants{} ; -- 
lin dispute_V = variants{} ; -- 
lin jungle_N = mkN "selva" | mkN "jungla" ; -- status=guess
lin brewery_N = mkN "cervecería" ; -- status=guess
lin adjective_N = mkN "adjetivo" ; -- status=guess
lin straighten_V2 = mkV2 (mkV "estirar") ; -- status=guess
lin straighten_V = mkV "estirar" ; -- status=guess
lin restrain_V2 = variants{} ; -- 
lin monarchy_N = mkN "monarquía" ; -- status=guess
lin trunk_N = mkN "trompa" ; -- status=guess
lin herd_N = mkN "rebaño" ; -- status=guess
lin deadline_N = mkN "fecha límite" | mkN "requisito" | mkN "compromiso" ; -- status=guess
lin tiger_N = mkN "tigre" masculine ; -- status=guess
lin supporting_A = variants{} ; -- 
lin moderate_A = mkA "moderado" | mkA "moderada" ; -- status=guess
lin kneel_V = mkV "arrodillarse" ; -- status=guess
lin ego_N = mkN "ego" ; -- status=guess
lin sexually_Adv = variants{} ; -- 
lin ministerial_A = mkA "ministerial" ; -- status=guess
lin bitch_N = mkN "marrón" ; -- status=guess
lin wheat_N = mkN "trigo" ; -- status=guess
lin stagger_V2 = mkV2 (mkV "vacilar") ; -- status=guess
lin stagger_V = mkV "vacilar" ; -- status=guess
lin snake_N = L.snake_N ;
lin ribbon_N = mkN "cinta" ; -- status=guess
lin mainland_N = mkN "continente" masculine ; -- status=guess
lin fisherman_N = mkN "pescador" masculine ; -- status=guess
lin economically_Adv = variants{} ; -- 
lin unwilling_A = mkA "reticente" | mkA "renitente" | mkA "reacio" ; -- status=guess
lin nationalism_N = mkN "nacionalismo" ; -- status=guess
lin knitting_N = mkN "aguja de punto" ; -- status=guess
lin irony_N = mkN "ironía" ; -- status=guess
lin handling_N = mkN "alcahuetería" | mkN "receptación" | mkN "encubrimiento" ; -- status=guess
lin desired_A = variants{} ; -- 
lin bomber_N = mkN "bombardero" ; -- status=guess
lin voltage_N = mkN "voltaje" masculine ; -- status=guess
lin unusually_Adv = variants{} ; -- 
lin toast_N = mkN "brindis" masculine ; -- status=guess
lin feel_N = mkN "caricia" ; -- status=guess
lin suffering_N = mkN "sufrimiento" ; -- status=guess
lin polish_V2 = mkV2 (mkV "pulir") | mkV2 (mkV "acicalar") ; -- status=guess
lin polish_V = mkV "pulir" | mkV "acicalar" ; -- status=guess
lin technically_Adv = variants{} ; -- 
lin meaningful_A = mkA "significativo" | mkA "con sentido" | mkA "con sentimiento" ; -- status=guess
lin aloud_Adv = mkAdv "en voz alta" ; -- status=guess
lin waiter_N = mkN "camarero" | mkN "garzón" ; -- status=guess
lin tease_V2 = mkV2 (mkV "peinar") ; -- status=guess
lin opposite_Adv = variants{} ; -- 
lin goat_N = mkN "cabra" | mkN "chivo" ; -- status=guess
lin conceptual_A = variants{} ; -- 
lin ant_N = mkN "hormiga" ; -- status=guess
lin inflict_V2 = mkV2 (infligir_V) ; -- status=guess
lin bowler_N = mkN "bombín" | mkN "hongo" ; -- status=guess
lin roar_V2 = mkV2 (rugir_V) | mkV2 (mkV "bramar") ; -- status=guess
lin roar_V = rugir_V | mkV "bramar" ; -- status=guess
lin drain_N = mkN "desagüe" ; -- status=guess
lin wrong_N = mkN "crimen" ; -- status=guess
lin galaxy_N = mkN "galaxia" ; -- status=guess
lin aluminium_N = mkN "aluminio" ; -- status=guess
lin receptor_N = variants{} ; -- 
lin preach_V2 = mkV2 (mkV (mkV "hablar") "a Noé de lluvia") ; -- status=guess
lin preach_V = mkV (mkV "hablar") "a Noé de lluvia" ; -- status=guess
lin parade_N = mkN "serie" feminine ; -- status=guess
lin opposite_N = variants{} ; -- 
lin critique_N = variants{} ; -- 
lin query_N = mkN "consulta" ; -- status=guess
lin outset_N = mkN "inicio" ; -- status=guess
lin integral_A = variants{} ; -- 
lin grammatical_A = mkA "gramatical" ; -- status=guess
lin testing_N = variants{} ; -- 
lin patrol_N = mkN "patrulla" ; -- status=guess
lin pad_N = mkN "bloc" masculine ; -- status=guess
lin unreasonable_A = mkA "irrazonable" ; -- status=guess
lin sausage_N = mkN "embutido" | mkN "salchicha" masculine | mkN "salchichón" masculine ; -- status=guess
lin criminal_N = mkN "criminal" feminine ; -- status=guess
lin constructive_A = variants{} ; -- 
lin worldwide_A = mkA "mundial" ; -- status=guess
lin highlight_N = mkN "rizo" ; -- status=guess
lin doll_N = mkN "muñeca" ; -- status=guess
lin frightened_A = variants{} ; -- 
lin biography_N = mkN "biografía" ; -- status=guess
lin vocabulary_N = mkN "vocabulario" ; -- status=guess
lin offend_V2 = mkV2 (mkV "ofender") ; -- status=guess
lin offend_V = mkV "ofender" ; -- status=guess
lin accumulation_N = mkN "acumulación" feminine ; -- status=guess
lin linen_N = mkN "ropa blanca" ; -- status=guess
lin fairy_N = mkN "hada madrina" ; -- status=guess
lin disco_N = variants{} ; -- 
lin hint_VS = mkVS (mkV (mkV "dar") "un indicio") ; -- status=guess
lin hint_V2 = mkV2 (mkV (mkV "dar") "un indicio") ; -- status=guess
lin hint_V = mkV (mkV "dar") "un indicio" ; -- status=guess
lin versus_Prep = variants{} ; -- 
lin ray_N = mkN "rayo" ; -- status=guess
lin pottery_N = mkN "cerámica" | mkN "loza" ; -- status=guess
lin immune_A = mkA "inmune" ; -- status=guess
lin retreat_N = mkN "retirarse" ; -- status=guess
lin master_V2 = variants{} ; -- 
lin injured_A = variants{} ; -- 
lin holly_N = mkN "acebo" ; -- status=guess
lin battle_V2 = mkV2 (mkV "luchar") | mkV2 (mkV "batallar") ; -- status=guess
lin battle_V = mkV "luchar" | mkV "batallar" ; -- status=guess
lin solidarity_N = mkN "solidaridad" feminine ; -- status=guess
lin embarrassing_A = mkA "embarazoso" ; -- status=guess
lin cargo_N = mkN "carga" ; -- status=guess
lin theorist_N = variants{} ; -- 
lin reluctantly_Adv = variants{} ; -- 
lin preferred_A = variants{} ; -- 
lin dash_V2 = mkV2 (mkV (mkV "hacer") "rapidamente") ; -- status=guess
lin dash_V = mkV (mkV "hacer") "rapidamente" ; -- status=guess
lin total_V2 = variants{} ; -- 
lin total_V = variants{} ; -- 
lin reconcile_V2 = variants{} ; -- 
lin drill_N = mkN "dril" masculine ; -- status=guess
lin credibility_N = mkN "credibilidad" feminine ; -- status=guess
lin copyright_N = mkN "derechos de autor" ; -- status=guess
lin beard_N = mkN "barba" ; -- status=guess
lin bang_N = mkN "golpe" masculine | mkN "zumbido" | mkN "percusión" | mkN "zarpazo" ; -- status=guess
lin vigorous_A = mkA "vigoroso" ; -- status=guess
lin vaguely_Adv = variants{} ; -- 
lin punch_V2 = mkV2 (mkV "perforar") ; -- status=guess
lin prevalence_N = variants{} ; -- 
lin uneasy_A = variants{} ; -- 
lin boost_N = mkN "impulso" | mkN "empuje" ; -- status=guess
lin scrap_N = mkN "chatarra" masculine ; -- status=guess
lin ironically_Adv = variants{} ; -- 
lin fog_N = L.fog_N ;
lin faithful_A = mkA "fiel" | mkA "leal" ; -- status=guess
lin bounce_V2 = mkV2 (mkV "rebotar") ; -- status=guess
lin bounce_V = mkV "rebotar" ; -- status=guess
lin batch_N = mkN "lote" masculine | mkN "procesamiento por lotes" ; -- status=guess
lin smooth_V2 = mkV2 (mkV "alisar") ; -- status=guess
lin smooth_V = mkV "alisar" ; -- status=guess
lin sleeping_A = variants{} ; -- 
lin poorly_Adv = variants{} ; -- 
lin accord_V2 = mkV2 (acordar_V) | mkV2 (mkV (mkV "concordar") "con") ; -- status=guess
lin accord_V = acordar_V | mkV (mkV "concordar") "con" ; -- status=guess
lin vice_president_N = variants{} ; -- 
lin duly_Adv = variants{} ; -- 
lin blast_N = variants{} ; -- 
lin square_V2 = mkV2 (mkV (mkV "elevar") "al cuadrado") ; -- status=guess
lin square_V = mkV (mkV "elevar") "al cuadrado" ; -- status=guess
lin prohibit_V2 = mkV2 (prohibir_V) ; -- status=guess
lin prohibit_V = prohibir_V ; -- status=guess
lin brake_N = mkN "freno" ; -- status=guess
lin asylum_N = mkN "manicomio" ; -- status=guess
lin obscure_VA = mkVA (mkV "esconder") | mkVA (mkV "ocultar") ; -- status=guess
lin obscure_V2 = mkV2 (mkV "esconder") | mkV2 (mkV "ocultar") ; -- status=guess
lin nun_N = mkN "monja" ; -- status=guess
lin heap_N = mkN "montículo" ; -- status=guess
lin smoothly_Adv = variants{} ; -- 
lin rhetoric_N = mkN "retórica" ; -- status=guess
lin privileged_A = mkA "privilegiado" ; -- status=guess
lin liaison_N = variants{} ; -- 
lin jockey_N = mkN "jinete" masculine | mkN "yóquey" | mkN "yoqui" masculine ; -- status=guess
lin concrete_N = mkN "hormigón" | mkN "concreto" ; -- status=guess
lin allied_A = variants{} ; -- 
lin rob_V2 = mkV2 (mkV "robar") ; -- status=guess
lin indulge_V2 = mkV2 (mkV "mimar") | mkV2 (consentir_V) ; -- status=guess
lin indulge_V = mkV "mimar" | consentir_V ; -- status=guess
lin except_Prep = S.except_Prep ;
lin distort_V2 = mkV2 (mkV "distorsionar") ; -- status=guess
lin whatsoever_Adv = variants{} ; -- 
lin viable_A = mkA "viable" ; -- status=guess
lin nucleus_N = mkN "núcleo" feminine ; -- status=guess
lin exaggerate_V2 = mkV2 (mkV "exagerar") ; -- status=guess
lin exaggerate_V = mkV "exagerar" ; -- status=guess
lin compact_N = mkN "acuerdo" ; -- status=guess
lin nationality_N = mkN "nacionalidad" feminine ; -- status=guess
lin direct_Adv = variants{} ; -- 
lin cast_N = mkN "reparto" | mkN "elenco" ; -- status=guess
lin altar_N = mkN "altar" masculine ; -- status=guess
lin refuge_N = mkN "refugio" ; -- status=guess
lin presently_Adv = variants{} ; -- 
lin mandatory_A = mkA "obligatorio" | mkA "necesario" ; -- status=guess
lin authorize_V2V = mkV2V (mkV "facultar") ; -- status=guess
lin authorize_V2 = mkV2 (mkV "facultar") ; -- status=guess
lin accomplish_V2 = mkV2 (mkV "completar") ; -- status=guess
lin startle_V2 = mkV2 (mkV "evitar") | mkV2 (impedir_V) ; -- status=guess
lin indigenous_A = mkA "indígena" | mkA "autóctono" | mkA "nativo" ; -- status=guess
lin worse_Adv = variants{} ; -- 
lin retailer_N = variants{} ; -- 
lin compound_V2 = variants{} ; -- 
lin compound_V = variants{} ; -- 
lin admiration_N = mkN "admiración" feminine ; -- status=guess
lin absurd_A = mkA "absurdo" ; -- status=guess
lin coincidence_N = mkN "coincidencia" ; -- status=guess
lin principally_Adv = variants{} ; -- 
lin passport_N = mkN "pasaporte" masculine ; -- status=guess
lin depot_N = variants{} ; -- 
lin soften_V2 = mkV2 (mkV "ablandarse") ; -- status=guess
lin soften_V = mkV "ablandarse" ; -- status=guess
lin secretion_N = mkN "secreción" feminine ; -- status=guess
lin invoke_V2 = mkV2 (mkV "invocar") ; -- status=guess
lin dirt_N = mkN "tierra" masculine ; -- status=guess
lin scared_A = variants{} ; -- 
lin mug_N = mkN "taza" | mkN "jarro" ; -- status=guess
lin convenience_N = mkN "comodidad" feminine | mkN "conveniencia" ; -- status=guess
lin calm_N = mkN "sosiego" | mkN "calma" ; -- status=guess
lin optional_A = mkA "opcional" ; -- status=guess
lin unsuccessful_A = variants{} ; -- 
lin consistency_N = mkN "consistencia" ; -- status=guess
lin umbrella_N = mkN "amparo" ; -- status=guess
lin solo_N = mkN "solitario" ; -- status=guess
lin hemisphere_N = mkN "hemisferio" ; -- status=guess
lin extreme_N = mkN "deporte extremo" ; -- status=guess
lin brandy_N = mkN "brandy" masculine ; -- status=guess
lin belly_N = L.belly_N ;
lin attachment_N = mkN "archivo adjunto" ; -- status=guess
lin wash_N = mkN "enjuague" masculine ; -- status=guess
lin uncover_V2 = mkV2 (mkV "destapar") ; -- status=guess
lin treat_N = mkN "sorpresa" | mkN "sorprender" ; -- status=guess
lin repeated_A = variants{} ; -- 
lin pine_N = mkN "piña" | mkN "estróbilo" | mkN "cono" ; -- status=guess
lin offspring_N = variants{} ; -- 
lin communism_N = mkN "comunismo" ; -- status=guess
lin nominate_V2 = mkV2 (mkV "postular") ; -- status=guess
lin soar_V2 = mkV2 (mkV "planear") ; -- status=guess
lin soar_V = mkV "planear" ; -- status=guess
lin geological_A = variants{} ; -- 
lin frog_N = mkN "rana" masculine ; -- status=guess
lin donate_V2 = mkV2 (mkV "donar") ; -- status=guess
lin donate_V = mkV "donar" ; -- status=guess
lin cooperative_A = mkA "cooperativo" ; -- status=guess
lin nicely_Adv = variants{} ; -- 
lin innocence_N = variants{} ; -- 
lin housewife_N = mkN "ama de casa" ; -- status=guess
lin disguise_V2 = mkV2 (mkV "disfrazar") ; -- status=guess
lin demolish_V2 = mkV2 (demoler_V) ; -- status=guess
lin counsel_N = mkN "consejo" ; -- status=guess
lin cord_N = mkN "cuerda" | mkN "cable" masculine | mkN "hilo" | mkN "cordón" masculine ; -- status=guess
lin semi_final_N = variants{} ; -- 
lin reasoning_N = mkN "razonamiento" ; -- status=guess
lin litre_N = mkN "litro" ; -- status=guess
lin inclined_A = variants{} ; -- 
lin evoke_V2 = mkV2 (mkV "evocar") | mkV2 (mkV "rememorar") ; -- status=guess
lin courtyard_N = mkN "patio" ; -- status=guess
lin arena_N = mkN "arena" masculine | mkN "estadio" ; -- status=guess
lin simplicity_N = mkN "sencillez" ; -- status=guess
lin inhibition_N = mkN "inhibición" feminine ; -- status=guess
lin frozen_A = variants{} ; -- 
lin vacuum_N = mkN "vacío" ; -- status=guess
lin immigrant_N = mkN "inmigrante" masculine ; -- status=guess
lin bet_N = mkN "apuesta" ; -- status=guess
lin revenge_N = mkN "venganza" ; -- status=guess
lin jail_V2 = variants{} ; -- 
lin helmet_N = mkN "casco" | mkN "yelmo" ; -- status=guess
lin unclear_A = variants{} ; -- 
lin jerk_V2 = mkV2 (mkV "pajearse") ; -- status=guess
lin jerk_V = mkV "pajearse" ; -- status=guess
lin disruption_N = mkN "desorden" masculine | mkN "desorganización" feminine ; -- status=guess
lin attainment_N = mkN "logro" | mkN "consecución" | mkN "realización" feminine ; -- status=guess
lin sip_V2 = mkV2 (mkV "sorber") ; -- status=guess
lin sip_V = mkV "sorber" ; -- status=guess
lin program_V2V = mkV2V (mkV "programar") ; -- status=guess
lin program_V2 = mkV2 (mkV "programar") ; -- status=guess
lin lunchtime_N = variants{} ; -- 
lin cult_N = mkN "secta" ; -- status=guess
lin chat_N = mkN "charla" ; -- status=guess
lin accord_N = mkN "acuerdo" | mkN "convenio" ; -- status=guess
lin supposedly_Adv = variants{} ; -- 
lin offering_N = mkN "ofrecimiento" ; -- status=guess
lin broadcast_N = mkN "programa" masculine ; -- status=guess
lin secular_A = mkA "seglar" | mkA "laico" | mkA "mundano" | mkA "secular" ; -- status=guess
lin overwhelm_V2 = mkV2 (mkV "agobiar") ; -- status=guess
lin momentum_N = mkN "cantidad de movimiento" | mkN "ímpetu" ; -- status=guess
lin infinite_A = mkA "infinito" ; -- status=guess
lin manipulation_N = mkN "manipulación" feminine ; -- status=guess
lin inquest_N = variants{} ; -- 
lin decrease_N = mkN "disminución" feminine ; -- status=guess
lin cellar_N = mkN "sótano" ; -- status=guess
lin counsellor_N = variants{} ; -- 
lin avenue_N = mkN "vía" | mkN "camino" feminine ; -- status=guess
lin rubber_A = variants{} ; -- 
lin labourer_N = variants{} ; -- 
lin lab_N = variants{} ; -- 
lin damn_V2 = mkV2 (mkV "maldecir") | mkV2 (mkV "condenar") ; -- status=guess
lin comfortably_Adv = variants{} ; -- 
lin tense_A = mkA "tenso" ; -- status=guess
lin socket_N = mkN "cuenca" ; -- status=guess
lin par_N = variants{} ; -- 
lin thrust_N = mkN "empuje" | mkN "envión" masculine ; -- status=guess
lin scenario_N = mkN "escenario" ; -- status=guess
lin frankly_Adv = variants{} ; -- 
lin slap_V2 = mkV2 (mkV "abofetear") ; -- status=guess
lin recreation_N = mkN "recreación" feminine ; -- status=guess
lin rank_VS = variants{} ; -- 
lin rank_V2 = variants{} ; -- 
lin rank_V = variants{} ; -- 
lin spy_N = mkN "espía" masculine | mkN "chivato" ; -- status=guess
lin filter_V2 = mkV2 (mkV (mkV "quitar") "filtrando") | mkV2 (mkV (mkV "eliminar") "filtrando") | mkV2 (mkV "tamizar") ; -- status=guess
lin filter_V = mkV (mkV "quitar") "filtrando" | mkV (mkV "eliminar") "filtrando" | mkV "tamizar" ; -- status=guess
lin clearance_N = mkN "despeje" masculine ; -- status=guess
lin blessing_N = mkN "bendición" feminine ; -- status=guess
lin embryo_N = mkN "embrión" masculine ; -- status=guess
lin varied_A = variants{} ; -- 
lin predictable_A = mkA "predecible" ; -- status=guess
lin mutation_N = mkN "mutación" feminine ; -- status=guess
lin equal_V2 = mkV2 (mkV "igualar") ; -- status=guess
lin can_1_VV = S.can_VV ;
lin can_2_VV = S.can8know_VV ;
lin can_V2 = mkV2 (poder_V) ; -- status=guess
lin burst_N = mkN "ráfaga" | mkN "estallo" | mkN "reventón" masculine ; -- status=guess
lin retrieve_V2 = mkV2 (mkV "recuperar") ; -- status=guess
lin retrieve_V = mkV "recuperar" ; -- status=guess
lin elder_N = mkN "saúco" feminine ; -- status=guess
lin rehearsal_N = mkN "ensayo" ; -- status=guess
lin optical_A = variants{} ; -- 
lin hurry_N = mkN "prisa" ; -- status=guess
lin conflict_V = mkV (mkV "discrepar") "estar reñido" ; -- status=guess
lin combat_V2 = variants{} ; -- 
lin combat_V = variants{} ; -- 
lin absorption_N = mkN "absorción" feminine ; -- status=guess
lin ion_N = mkN "ion" | mkN "ión" masculine ; -- status=guess
lin wrong_Adv = variants{} ; -- 
lin heroin_N = mkN "heroína" ; -- status=guess
lin bake_V2 = mkV2 (mkV "hornear") ; -- status=guess
lin bake_V = mkV "hornear" ; -- status=guess
lin x_ray_N = variants{} ; -- 
lin vector_N = mkN "vector" masculine ; -- status=guess
lin stolen_A = variants{} ; -- 
lin sacrifice_V2 = mkV2 (mkV "sacrificar") ; -- status=guess
lin sacrifice_V = mkV "sacrificar" ; -- status=guess
lin robbery_N = mkN "robo" ; -- status=guess
lin probe_V2 = mkV2 (mkV "sondar") | mkV2 (mkV "sondear") ; -- status=guess
lin probe_V = mkV "sondar" | mkV "sondear" ; -- status=guess
lin organizational_A = mkA "organizacional" ; -- status=guess
lin chalk_N = mkN "tiza" | mkN "gis " ; -- status=guess
lin bourgeois_A = mkA "burgués" ; -- status=guess
lin villager_N = mkN "aldeano" | mkN "aldeana" ; -- status=guess
lin morale_N = variants{} ; -- 
lin express_A = variants{} ; -- 
lin climb_N = mkN "subida" | mkN "ascenso" feminine ; -- status=guess
lin notify_V2 = mkV2 (mkV "notificar") ; -- status=guess
lin jam_N = mkN "atasco" ; -- status=guess
lin bureaucratic_A = variants{} ; -- 
lin literacy_N = mkN "alfabetismo" ; -- status=guess
lin frustrate_V2 = variants{} ; -- 
lin freight_N = mkN "flete" masculine ; -- status=guess
lin clearing_N = mkN "desmonte" | mkN "claro" ; -- status=guess
lin aviation_N = mkN "aviación" feminine ; -- status=guess
lin legislature_N = variants{} ; -- 
lin curiously_Adv = variants{} ; -- 
lin banana_N = mkN "banana" ; -- status=guess
lin deploy_V2 = mkV2 (desplegar_V) ; -- status=guess
lin deploy_V = desplegar_V ; -- status=guess
lin passionate_A = mkA "apasionado" ; -- status=guess
lin monastery_N = mkN "monasterio" ; -- status=guess
lin kettle_N = mkN "caldera" ; -- status=guess
lin enjoyable_A = variants{} ; -- 
lin diagnose_V2 = mkV2 (mkV "diagnosticar") ; -- status=guess
lin quantitative_A = variants{} ; -- 
lin distortion_N = mkN "distorsión" ; -- status=guess
lin monarch_N = mkN "monarca" masculine ; -- status=guess
lin kindly_Adv = variants{} ; -- 
lin glow_V = fulgir_V | mkV "fulgurar" | mkV "iluminar" | mkV "brillar" | mkV "arder" | resplandecer_V | mkV (mkV "estar") "al rojo vivo" ; -- status=guess
lin acquaintance_N = mkN "conocido" | mkN "conocida" ; -- status=guess
lin unexpectedly_Adv = variants{} ; -- 
lin handy_A = mkA "hábil" | mkA "diestro" ; -- status=guess
lin deprivation_N = variants{} ; -- 
lin attacker_N = mkN "atacante" masculine | mkN "asaltante" masculine ; -- status=guess
lin assault_V2 = mkV2 (mkV "asaltar") | mkV2 (mkV "atacar") ; -- status=guess
lin screening_N = variants{} ; -- 
lin retired_A = variants{} ; -- 
lin quick_Adv = variants{} ; -- 
lin portable_A = mkA "portátil" ; -- status=guess
lin hostage_N = mkN "rehén" masculine ; -- status=guess
lin underneath_Prep = variants{} ; -- 
lin jealous_A = mkA "envidioso" ; -- status=guess
lin proportional_A = mkA "proporcional" ; -- status=guess
lin gown_N = mkN "toga" ; -- status=guess
lin chimney_N = mkN "tubo" ; -- status=guess
lin bleak_A = mkA "sin alegría" | mkA "amargado" ; -- status=guess
lin seasonal_A = mkA "estacional" ; -- status=guess
lin plasma_N = mkN "plasma" ; -- status=guess
lin stunning_A = variants{} ; -- 
lin spray_N = mkN "spray" | mkN "aerosol" masculine | mkN "difusión" feminine ; -- status=guess
lin referral_N = variants{} ; -- 
lin promptly_Adv = variants{} ; -- 
lin fluctuation_N = mkN "fluctuación" feminine ; -- status=guess
lin decorative_A = mkA "decorativo" ; -- status=guess
lin unrest_N = variants{} ; -- 
lin resent_VS = mkVS (mkV "resentir") | mkVS (mkV "resentirse") ; -- status=guess
lin resent_V2 = mkV2 (mkV "resentir") | mkV2 (mkV "resentirse") ; -- status=guess
lin plaster_N = mkN "ungüento" ; -- status=guess
lin chew_V2 = mkV2 (mkV "masticar") ; -- status=guess
lin chew_V = mkV "masticar" ; -- status=guess
lin grouping_N = variants{} ; -- 
lin gospel_N = mkN "evangelio" ; -- status=guess
lin distributor_N = variants{} ; -- 
lin differentiation_N = mkN "diferenciación" feminine ; -- status=guess
lin blonde_A = variants{} ; -- 
lin aquarium_N = mkN "acuario" ; -- status=guess
lin witch_N = mkN "bruja" masculine ; -- status=guess
lin renewed_A = variants{} ; -- 
lin jar_N = mkN "pote" masculine | mkN "bote" masculine ; -- status=guess
lin approved_A = variants{} ; -- 
lin advocate_N = variants{} ; -- 
lin worrying_A = variants{} ; -- 
lin minimize_V2 = mkV2 (mkV "minimizar") ; -- status=guess
lin footstep_N = mkN "paso" ; -- status=guess
lin delete_V2 = mkV2 (mkV "borrar") ; -- status=guess
lin underneath_Adv = mkAdv "abajo" ; -- status=guess
lin lone_A = mkA "solo" ; -- status=guess
lin level_V2 = mkV2 (mkV "avanzar") | mkV2 (mkV (mkV "subir") "de nivel") ; -- status=guess
lin level_V = mkV "avanzar" | mkV (mkV "subir") "de nivel" ; -- status=guess
lin exceptionally_Adv = variants{} ; -- 
lin drift_N = mkN "derrape" ; -- status=guess
lin spider_N = mkN "araña" ; -- status=guess
lin hectare_N = mkN "hectárea" ; -- status=guess
lin colonel_N = mkN "coronel" masculine ; -- status=guess
lin swimming_N = mkN "natación" feminine ; -- status=guess
lin realism_N = mkN "realismo" ; -- status=guess
lin insider_N = variants{} ; -- 
lin hobby_N = mkN "alcotán" masculine ; -- status=guess
lin computing_N = variants{} ; -- 
lin infrastructure_N = mkN "infraestructura" ; -- status=guess
lin cooperate_V = mkV "cooperar" ; -- status=guess
lin burn_N = mkN "quemadura" ; -- status=guess
lin cereal_N = mkN "cereal" masculine ; -- status=guess
lin fold_N = mkN "doblamiento" ; -- status=guess
lin compromise_V2 = mkV2 (mkV "comprometerse") ; -- status=guess
lin compromise_V = mkV "comprometerse" ; -- status=guess
lin boxing_N = mkN "boxeo" ; -- status=guess
lin rear_V2 = mkV2 (mkV "criar") ; -- status=guess
lin rear_V = mkV "criar" ; -- status=guess
lin lick_V2 = mkV2 (mkV "derrotar") ; -- status=guess
lin lick_V = mkV "derrotar" ; -- status=guess
lin constrain_V2 = mkV2 (constreñir_V) | mkV2 (mkV "limitar") | mkV2 (restringir_V) | mkV2 (mkV "obligar") ; -- status=guess
lin clerical_A = variants{} ; -- 
lin hire_N = variants{} ; -- 
lin contend_VS = mkVS (sostener_V) ; -- status=guess
lin contend_V = sostener_V ; -- status=guess
lin amateur_N = variants{} ; -- 
lin instrumental_A = mkA "instrumental" ; -- status=guess
lin terminal_A = variants{} ; -- 
lin electorate_N = mkN "electorado" ; -- status=guess
lin congratulate_V2 = mkV2 (mkV "felicitar") ; -- status=guess
lin balanced_A = variants{} ; -- 
lin manufacturing_N = variants{} ; -- 
lin split_N = mkN "espagat" masculine ; -- status=guess
lin domination_N = variants{} ; -- 
lin blink_V2 = mkV2 (mkV "parpadear") | mkV2 (mkV "guiñar") ; -- status=guess
lin blink_V = mkV "parpadear" | mkV "guiñar" ; -- status=guess
lin bleed_VS = mkVS (mkV "sangrar") ; -- status=guess
lin bleed_V2 = mkV2 (mkV "sangrar") ; -- status=guess
lin bleed_V = mkV "sangrar" ; -- status=guess
lin unlawful_A = mkA "ilegal" ; -- status=guess
lin precedent_N = mkN "precedente" masculine ; -- status=guess
lin notorious_A = mkA "de mala fama" | mkA "notorio" ; -- status=guess
lin indoor_A = variants{} ; -- 
lin upgrade_V2 = mkV2 (mkV "mejorar") ; -- status=guess
lin trench_N = mkN "trinchera" ; -- status=guess
lin therapist_N = mkN "terapeuta" masculine ; -- status=guess
lin illuminate_V2 = mkV2 (mkV "iluminar") ; -- status=guess
lin bargain_V2 = mkV2 (mkV "regatear") ; -- status=guess
lin bargain_V = mkV "regatear" ; -- status=guess
lin warranty_N = mkN "garantía" masculine ; -- status=guess
lin scar_V2 = mkV2 (mkV "cicatrizarse") ; -- status=guess
lin scar_V = mkV "cicatrizarse" ; -- status=guess
lin consortium_N = variants{} ; -- 
lin anger_V2 = mkV2 (mkV "enojarse") ; -- status=guess
lin insure_VS = mkVS (mkV "asegurar") ; -- status=guess
lin insure_V2 = mkV2 (mkV "asegurar") ; -- status=guess
lin insure_V = mkV "asegurar" ; -- status=guess
lin extensively_Adv = variants{} ; -- 
lin appropriately_Adv = variants{} ; -- 
lin spoon_N = mkN "cuchara" ; -- status=guess
lin sideways_Adv = variants{} ; -- 
lin enhanced_A = variants{} ; -- 
lin disrupt_V2 = mkV2 (mkV "interrumpir") ; -- status=guess
lin disrupt_V = mkV "interrumpir" ; -- status=guess
lin satisfied_A = mkA "satisfecho" ; -- status=guess
lin precaution_N = mkN "precaución" feminine ; -- status=guess
lin kite_N = mkN "milano" | mkN "aguililla" ; -- status=guess
lin instant_N = mkN "café instantáneo" ; -- status=guess
lin gig_N = mkN "contrato para tocar" | mkN "empleo" ; -- status=guess
lin continuously_Adv = variants{} ; -- 
lin consolidate_V2 = mkV2 (mkV "consolidar") ; -- status=guess
lin consolidate_V = mkV "consolidar" ; -- status=guess
lin fountain_N = mkN "fuente" masculine ; -- status=guess
lin graduate_V2 = mkV2 (mkV "graduar") ; -- status=guess
lin graduate_V = mkV "graduar" ; -- status=guess
lin gloom_N = variants{} ; -- 
lin bite_N = mkN "mordedura" | mkN "mordisco" | mkN "picadura" ; -- status=guess
lin structure_V2 = variants{} ; -- 
lin noun_N = mkN "sustantivo" | mkN "substantivo" ; -- status=guess
lin nomination_N = variants{} ; -- 
lin armchair_N = mkN "sillón" masculine ; -- status=guess
lin virtual_A = mkA "virtual" ; -- status=guess
lin unprecedented_A = mkA "sin precedente" ; -- status=guess
lin tumble_V2 = mkV2 (caer_V) | mkV2 (mkV "revolverse") ; -- status=guess
lin tumble_V = caer_V | mkV "revolverse" ; -- status=guess
lin ski_N = mkN "esquí" masculine ; -- status=guess
lin architectural_A = mkA "arquitectónico" ; -- status=guess
lin violation_N = mkN "violación" feminine ; -- status=guess
lin rocket_N = mkN "cohete" masculine ; -- status=guess
lin inject_V2 = variants{} ; -- 
lin departmental_A = mkA "departamental" ; -- status=guess
lin row_V2 = mkV2 (mkV "remar") ; -- status=guess
lin row_V = mkV "remar" ; -- status=guess
lin luxury_A = variants{} ; -- 
lin fax_N = variants{} ; -- 
lin deer_N = mkN "ciervo" | mkN "venado" ; -- status=guess
lin climber_N = mkN "trepador" masculine ; -- status=guess
lin photographic_A = mkA "fotográfico" ; -- status=guess
lin haunt_V2 = variants{} ; -- 
lin fiercely_Adv = variants{} ; -- 
lin dining_N = mkN "comedor" masculine ; -- status=guess
lin sodium_N = mkN "sodio" ; -- status=guess
lin gossip_N = mkN "chisme" ; -- status=guess
lin bundle_N = mkN "haz" masculine ; -- status=guess
lin bend_N = variants{} ; -- 
lin recruit_N = mkN "recluta" masculine ; -- status=guess
lin hen_N = mkN "ave hembra" ; -- status=guess
lin fragile_A = mkA "frágil" ; -- status=guess
lin deteriorate_V2 = variants{} ; -- 
lin deteriorate_V = variants{} ; -- 
lin dependency_N = variants{} ; -- 
lin swift_A = mkA "rápido" ; -- status=guess
lin scramble_VV = mkVV (revolver_V) ; -- status=guess
lin scramble_V2V = mkV2V (revolver_V) ; -- status=guess
lin scramble_V2 = mkV2 (revolver_V) ; -- status=guess
lin scramble_V = revolver_V ; -- status=guess
lin overview_N = mkN "descripción" feminine ; -- status=guess
lin imprison_V2 = mkV2 (mkV "encarcelar") | mkV2 (mkV "aprisionar") ; -- status=guess
lin trolley_N = mkN "trolebus" ; -- status=guess
lin rotation_N = mkN "rotación" masculine ; -- status=guess
lin denial_N = mkN "negación" feminine ; -- status=guess
lin boiler_N = mkN "caldera" | mkN "boiler " | mkN "bóiler " | mkN "calentador" masculine ; -- status=guess
lin amp_N = variants{} ; -- 
lin trivial_A = mkA "trivial" ; -- status=guess
lin shout_N = mkN "grito" ; -- status=guess
lin overtake_V2 = mkV2 (mkV "rebasar") | mkV2 (mkV "sobrepasar") | mkV2 (mkV "adelantar") ; -- status=guess
lin make_N = mkN "marca" masculine ; -- status=guess
lin hunter_N = mkN "cazador" masculine ; -- status=guess
lin guess_N = mkN "conjetura" ; -- status=guess
lin doubtless_Adv = variants{} ; -- 
lin syllable_N = mkN "sílaba" ; -- status=guess
lin obscure_A = mkA "obscuro" ; -- status=guess
lin mould_N = variants{} ; -- 
lin limestone_N = mkN "caliza" ; -- status=guess
lin leak_V2 = mkV2 (mkV "filtrar") ; -- status=guess
lin leak_V = mkV "filtrar" ; -- status=guess
lin beneficiary_N = variants{} ; -- 
lin veteran_N = mkN "veterano" ; -- status=guess
lin surplus_A = variants{} ; -- 
lin manifestation_N = mkN "manifestación" feminine ; -- status=guess
lin vicar_N = variants{} ; -- 
lin textbook_N = mkN "libro de texto" | mkN "texto" ; -- status=guess
lin novelist_N = mkN "novelista" masculine ; -- status=guess
lin halfway_Adv = variants{} ; -- 
lin contractual_A = variants{} ; -- 
lin swap_V2 = mkV2 (mkV "intercambiar") ; -- status=guess
lin swap_V = mkV "intercambiar" ; -- status=guess
lin guild_N = variants{} ; -- 
lin ulcer_N = mkN "llaga" | mkN "úlcera" ; -- status=guess
lin slab_N = mkN "plancha" masculine | mkN "tabla" | mkN "lámina" | mkN "tabla" ; -- status=guess
lin detector_N = variants{} ; -- 
lin detection_N = mkN "detección" feminine ; -- status=guess
lin cough_V2 = mkV2 (mkV "toser") ; -- status=guess
lin cough_V = mkV "toser" ; -- status=guess
lin whichever_Quant = variants{} ; -- 
lin spelling_N = mkN "grafía" ; -- status=guess
lin lender_N = mkN "prestador" masculine ; -- status=guess
lin glow_N = mkN "bujía" ; -- status=guess
lin raised_A = variants{} ; -- 
lin prolonged_A = variants{} ; -- 
lin voucher_N = mkN "cupón" | mkN "vale" masculine ; -- status=guess
lin t_shirt_N = variants{} ; -- 
lin linger_V = mkV "pervivir" ; -- status=guess
lin humble_A = mkA "humilde" ; -- status=guess
lin honey_N = mkN "ratel" | mkN "tejón de miel" ; -- status=guess
lin scream_N = mkN "grito" ; -- status=guess
lin postcard_N = mkN "tarjeta postal" | mkN "postal" masculine ; -- status=guess
lin managing_A = variants{} ; -- 
lin alien_A = mkA "extraterrestre" | mkA "alienígena" | mkA "extraño" ; -- status=guess
lin trouble_V2 = mkV2 (mkV "molestar") | mkV2 (mkV "fastidiar") | mkV2 (mkV "agobiar") ; -- status=guess
lin trouble_V = mkV "molestar" | mkV "fastidiar" | mkV "agobiar" ; -- status=guess
lin reverse_N = mkN "reversa" ; -- status=guess
lin odour_N = mkN "olor" masculine ; -- status=guess
lin fundamentally_Adv = variants{} ; -- 
lin discount_V2 = variants{} ; -- 
lin discount_V = variants{} ; -- 
lin blast_V2 = variants{} ; -- 
lin blast_V = variants{} ; -- 
lin syntactic_A = mkA "sintáctico" ; -- status=guess
lin scrape_V2 = mkV2 (mkV "raspar") ; -- status=guess
lin scrape_V = mkV "raspar" ; -- status=guess
lin residue_N = variants{} ; -- 
lin procession_N = mkN "procesión" feminine ; -- status=guess
lin pioneer_N = mkN "pionero" ; -- status=guess
lin intercourse_N = variants{} ; -- 
lin deter_V2 = mkV2 (mkV "disuadir") | mkV2 (desalentar_V) ; -- status=guess
lin deadly_A = mkA "mortal" | mkA "letal" | mkA "mortífero" ; -- status=guess
lin complement_V2 = mkV2 (mkV "complementar") ; -- status=guess
lin restrictive_A = mkA "restrictivo" ; -- status=guess
lin nitrogen_N = mkN "nitrógeno" ; -- status=guess
lin citizenship_N = mkN "ciudadanía" ; -- status=guess
lin pedestrian_N = mkN "peatón" | mkN "viandante" masculine ; -- status=guess
lin detention_N = variants{} ; -- 
lin wagon_N = mkN "carro" feminine | mkN "coche" masculine ; -- status=guess
lin microphone_N = mkN "micrófono" ; -- status=guess
lin hastily_Adv = variants{} ; -- 
lin fixture_N = variants{} ; -- 
lin choke_V2 = mkV2 (mkV "sofocar") | mkV2 (mkV "ahogar") ; -- status=guess
lin choke_V = mkV "sofocar" | mkV "ahogar" ; -- status=guess
lin wet_V2 = mkV2 (mkV "mearse") ; -- status=guess
lin weed_N = mkN "parásito" ; -- status=guess
lin programming_N = mkN "programación" feminine ; -- status=guess
lin power_V2 = variants{} ; -- 
lin nationally_Adv = variants{} ; -- 
lin dozen_N = mkN "docena" ; -- status=guess
lin carrot_N = mkN "zanahoria" ; -- status=guess
lin bulletin_N = variants{} ; -- 
lin wording_N = variants{} ; -- 
lin vicious_A = variants{} ; -- 
lin urgency_N = variants{} ; -- 
lin spoken_A = variants{} ; -- 
lin skeleton_N = mkN "estructura" ; -- status=guess
lin motorist_N = mkN "motorista" masculine ; -- status=guess
lin interactive_A = mkA "interactivo" ; -- status=guess
lin compute_V2 = variants{} ; -- 
lin compute_V = variants{} ; -- 
lin whip_N = mkN "fusta" | mkN "látigo" ; -- status=guess
lin urgently_Adv = variants{} ; -- 
lin telly_N = mkN "tele" feminine ; -- status=guess
lin shrub_N = mkN "mata" | mkN "arbusto" ; -- status=guess
lin porter_N = mkN "mozo" | mkN "cargador" masculine | mkN "changador" | mkN "changarín" | mkN "faquín" | mkN "fardero" | mkN "gallego" | mkN "mecapal" | mkN "porteador" | mkN "soguilla" masculine ; -- status=guess
lin ethics_N = mkN "ética" ; -- status=guess
lin banner_N = mkN "banner publicitario" ; -- status=guess
lin velvet_N = mkN "terciopelo" ; -- status=guess
lin omission_N = mkN "omisión" feminine ; -- status=guess
lin hook_V2 = mkV2 (mkV "enganchar") ; -- status=guess
lin hook_V = mkV "enganchar" ; -- status=guess
lin gallon_N = mkN "galón" masculine ; -- status=guess
lin financially_Adv = variants{} ; -- 
lin superintendent_N = mkN "superintendente -" | mkN "director" masculine | mkN "supervisor" masculine ; -- status=guess
lin plug_V2 = mkV2 (mkV "enchufar") ; -- status=guess
lin plug_V = mkV "enchufar" ; -- status=guess
lin continuation_N = mkN "continuación" feminine ; -- status=guess
lin reliance_N = mkN "dependiente" masculine ; -- status=guess
lin justified_A = variants{} ; -- 
lin fool_V2 = mkV2 (mkV "engañar") | mkV2 (mkV "engrupir") | mkV2 (mkV (mkV "tomar") "el pelo") ; -- status=guess
lin fool_V = mkV "engañar" | mkV "engrupir" | mkV (mkV "tomar") "el pelo" ; -- status=guess
lin detain_V2 = mkV2 (detener_V) | mkV2 (retener_V) ; -- status=guess
lin damaging_A = mkA "lesivo" | mkA "dañino" | mkA "injurioso" ; -- status=guess
lin orbit_N = mkN "órbita" ; -- status=guess
lin mains_N = variants{} ; -- 
lin discard_V2 = mkV2 (mkV "desechar") | mkV2 (mkV "descartar") ; -- status=guess
lin dine_V2 = mkV2 (mkV "cenar") ; -- status=guess
lin dine_V = mkV "cenar" ; -- status=guess
lin compartment_N = mkN "compartimiento" ; -- status=guess
lin revised_A = variants{} ; -- 
lin privatization_N = mkN "privatización" feminine ; -- status=guess
lin memorable_A = mkA "memorable" ; -- status=guess
lin lately_Adv = variants{} ; -- 
lin distributed_A = variants{} ; -- 
lin disperse_V2 = mkV2 (mkV "dispersar") ; -- status=guess
lin disperse_V = mkV "dispersar" ; -- status=guess
lin blame_N = mkN "culpa" ; -- status=guess
lin basement_N = mkN "sótano" ; -- status=guess
lin slump_V2 = mkV2 (desfallecer_V) ; -- status=guess
lin slump_V = desfallecer_V ; -- status=guess
lin puzzle_V2 = variants{} ; -- 
lin puzzle_V = variants{} ; -- 
lin monitoring_N = variants{} ; -- 
lin talented_A = mkA "talentoso" | mkA "talentosa" | mkA "dotado" ; -- status=guess
lin nominal_A = mkA "nominal" ; -- status=guess
lin mushroom_N = mkN "hongo" | mkN "seta" ; -- status=guess
lin instructor_N = mkN "instructor" masculine ; -- status=guess
lin fork_N = variants{} ; -- 
lin fork_4_N = variants{} ; -- 
lin fork_3_N = variants{} ; -- 
lin fork_1_N = variants{} ; -- 
lin board_V2 = mkV2 (mkV "abordar") ; -- status=guess
lin board_V = mkV "abordar" ; -- status=guess
lin want_N = mkN "afán" masculine ; -- status=guess
lin disposition_N = mkN "temperamento" | mkN "carácter" masculine ; -- status=guess
lin cemetery_N = variants{} ; -- 
lin attempted_A = variants{} ; -- 
lin nephew_N = mkN "sobrino" ; -- status=guess
lin magical_A = variants{} ; -- 
lin ivory_N = mkN "ebúrneo" ; -- status=guess
lin hospitality_N = mkN "hospitalidad" feminine ; -- status=guess
lin besides_Prep = variants{} ; -- 
lin astonishing_A = mkA "asombroso" | mkA "sorprendente" ; -- status=guess
lin tract_N = mkN "tratado" ; -- status=guess
lin proprietor_N = mkN "propietario" ; -- status=guess
lin license_V2 = variants{} ; -- 
lin differential_A = mkA "diferencial" ; -- status=guess
lin affinity_N = mkN "afinidad" feminine ; -- status=guess
lin talking_N = variants{} ; -- 
lin royalty_N = variants{} ; -- 
lin neglect_N = mkN "negligencia" ; -- status=guess
lin irrespective_A = mkA "sin considerar" | mkA "independiente de" ; -- status=guess
lin whip_V2 = mkV2 (mkV "azotar") ; -- status=guess
lin whip_V = mkV "azotar" ; -- status=guess
lin sticky_A = mkA "pegajoso" | mkA "adherente" | mkA "adherible" ; -- status=guess
lin regret_N = mkN "pesar" | mkN "arrepentimiento" ; -- status=guess
lin incapable_A = mkA "incapaz" ; -- status=guess
lin franchise_N = mkN "franquicia" ; -- status=guess
lin dentist_N = mkN "dentista" masculine | mkN "odontólogo" ; -- status=guess
lin contrary_N = variants{} ; -- 
lin profitability_N = variants{} ; -- 
lin enthusiast_N = mkN "entusiasta" ; -- status=guess
lin crop_V2 = mkV2 (mkV "recortar") ; -- status=guess
lin crop_V = mkV "recortar" ; -- status=guess
lin utter_V2 = mkV2 (mkV "emitir") ; -- status=guess
lin pile_V2 = mkV2 (mkV "amontonarse") ; -- status=guess
lin pile_V = mkV "amontonarse" ; -- status=guess
lin pier_N = mkN "muelle" masculine | mkN "embarcadero" | mkN "malecón" masculine ; -- status=guess
lin dome_N = mkN "cúpula" ; -- status=guess
lin bubble_N = mkN "culón" ; -- status=guess
lin treasurer_N = mkN "tesorero" ; -- status=guess
lin stocking_N = mkN "media" ; -- status=guess
lin sanctuary_N = variants{} ; -- 
lin ascertain_V2 = mkV2 (mkV "averiguar") | mkV2 (mkV "determinar") | mkV2 (establecer_V) ; -- status=guess
lin arc_N = mkN "curva" ; -- status=guess
lin quest_N = mkN "búsqueda" ; -- status=guess
lin mole_N = mkN "topo" ; -- status=guess
lin marathon_N = mkN "m-f" ; -- status=guess
lin feast_N = mkN "festín" | mkN "fiesta" | mkN "comilona" ; -- status=guess
lin crouch_V2 = mkV2 (mkV "encogerse") | mkV2 (mkV "inclinarse") ; -- status=guess
lin crouch_V = mkV "encogerse" | mkV "inclinarse" ; -- status=guess
lin storm_V2 = mkV2 (mkV "irrumpir") ; -- status=guess
lin storm_V = mkV "irrumpir" ; -- status=guess
lin hardship_N = mkN "sufrimientos" | mkN "apuro" ; -- status=guess
lin entitlement_N = variants{} ; -- 
lin circular_N = mkN "arco" ; -- status=guess
lin walking_A = variants{} ; -- 
lin strap_N = mkN "tirante" masculine ; -- status=guess
lin sore_A = mkA "dolorido" ; -- status=guess
lin complementary_A = mkA "complementario" ; -- status=guess
lin understandable_A = mkA "entendible" ; -- status=guess
lin noticeable_A = variants{} ; -- 
lin mankind_N = mkN "humanidad" feminine ; -- status=guess
lin majesty_N = mkN "majestad" ; -- status=guess
lin pigeon_N = mkN "paloma" ; -- status=guess
lin goalkeeper_N = mkN "arquero" | mkN "guardameta" | mkN "portero" ; -- status=guess
lin ambiguous_A = mkA "ambiguo" ; -- status=guess
lin walker_N = mkN "caminante" masculine ; -- status=guess
lin virgin_N = mkN "virgen" masculine | mkN "doncel" | mkN "doncella" ; -- status=guess
lin prestige_N = mkN "prestigio" ; -- status=guess
lin preoccupation_N = variants{} ; -- 
lin upset_A = variants{} ; -- 
lin municipal_A = mkA "municipal" ; -- status=guess
lin groan_V2 = mkV2 (gemir_V) | mkV2 (gruñir_V) ; -- status=guess
lin groan_V = gemir_V | gruñir_V ; -- status=guess
lin craftsman_N = mkN "artesano" feminine ; -- status=guess
lin anticipation_N = mkN "anticipación" feminine ; -- status=guess
lin revise_V2 = mkV2 (mkV "repasar") ; -- status=guess
lin revise_V = mkV "repasar" ; -- status=guess
lin knock_N = mkN "golpe" masculine ; -- status=guess
lin infect_V2 = mkV2 (mkV "infectar") | mkV2 (mkV "contagiar") ; -- status=guess
lin infect_V = mkV "infectar" | mkV "contagiar" ; -- status=guess
lin denounce_V2 = mkV2 (mkV "denunciar") ; -- status=guess
lin confession_N = mkN "confesión" feminine ; -- status=guess
lin turkey_N = mkN "pavo" ; -- status=guess
lin toll_N = mkN "peaje" masculine ; -- status=guess
lin pal_N = variants{} ; -- 
lin transcription_N = mkN "transcripción" feminine ; -- status=guess
lin sulphur_N = variants{} ; -- 
lin provisional_A = mkA "provisional" ; -- status=guess
lin hug_V2 = mkV2 (mkV "abrazar") ; -- status=guess
lin particular_N = variants{} ; -- 
lin intent_A = mkA "concentrado" ; -- status=guess
lin fascinate_V2 = variants{} ; -- 
lin conductor_N = mkN "director" masculine ; -- status=guess
lin feasible_A = mkA "factible" ; -- status=guess
lin vacant_A = mkA "vacante" ; -- status=guess
lin trait_N = mkN "rasgo" | mkN "característica" ; -- status=guess
lin meadow_N = mkN "prado" | mkN "vega" ; -- status=guess
lin creed_N = mkN "credo" ; -- status=guess
lin unfamiliar_A = variants{} ; -- 
lin optimism_N = mkN "optimismo" ; -- status=guess
lin wary_A = mkA "cauteloso" ; -- status=guess
lin twist_N = variants{} ; -- 
lin sweet_N = mkN "dulce" feminine | mkN "caramelo" feminine | mkN "chuche" ; -- status=guess
lin substantive_A = mkA "sustantivo" | mkA "sustancial" ; -- status=guess
lin excavation_N = variants{} ; -- 
lin destiny_N = mkN "destino" | mkN "azar" masculine ; -- status=guess
lin thick_Adv = variants{} ; -- 
lin pasture_N = mkN "pasto" | mkN "pradera" ; -- status=guess
lin archaeological_A = mkA "arqueológico" ; -- status=guess
lin tick_V2 = mkV2 (mkV "tictaquear") ; -- status=guess
lin tick_V = mkV "tictaquear" ; -- status=guess
lin profit_V2 = mkV2 (mkV "explotar") ; -- status=guess
lin profit_V = mkV "explotar" ; -- status=guess
lin pat_V2 = variants{} ; -- 
lin pat_V = variants{} ; -- 
lin papal_A = mkA "papal" ; -- status=guess
lin cultivate_V2 = mkV2 (mkV "cultivar") ; -- status=guess
lin awake_V = despertar_V ; -- status=guess
lin trained_A = variants{} ; -- 
lin civic_A = mkA "cívico" ; -- status=guess
lin voyage_N = mkN "viaje" masculine ; -- status=guess
lin siege_N = mkN "sitio" | mkN "asedio" ; -- status=guess
lin enormously_Adv = variants{} ; -- 
lin distract_V2 = mkV2 (distraer_V) ; -- status=guess
lin distract_V = distraer_V ; -- status=guess
lin stroll_V = mkV "pasearse" | mkV "pasear" ; -- status=guess
lin jewel_N = mkN "joya" ; -- status=guess
lin honourable_A = variants{} ; -- 
lin helpless_A = mkA "indefenso" ; -- status=guess
lin hay_N = mkN "heno" ; -- status=guess
lin expel_V2 = mkV2 (mkV "expulsar") | mkV2 (mkV "expeler") ; -- status=guess
lin eternal_A = mkA "eterno" | mkA "eternal" ; -- status=guess
lin demonstrator_N = mkN "manifestante" masculine ; -- status=guess
lin correction_N = mkN "corrección" feminine ; -- status=guess
lin civilization_N = mkN "civilización" feminine ; -- status=guess
lin ample_A = mkA "abundante" | mkA "generoso" ; -- status=guess
lin retention_N = mkN "recuerdo" ; -- status=guess
lin rehabilitation_N = variants{} ; -- 
lin premature_A = variants{} ; -- 
lin encompass_V2 = mkV2 (mkV "abarcar") | mkV2 (mkV "englobar") ; -- status=guess
lin distinctly_Adv = variants{} ; -- 
lin diplomat_N = mkN "diplomático" | mkN "diplomática" ; -- status=guess
lin articulate_V2 = mkV2 (mkV "articularse") ; -- status=guess
lin articulate_V = mkV "articularse" ; -- status=guess
lin restricted_A = variants{} ; -- 
lin prop_V2 = variants{} ; -- 
lin intensify_V2 = mkV2 (mkV "intensificar") ; -- status=guess
lin intensify_V = mkV "intensificar" ; -- status=guess
lin deviation_N = variants{} ; -- 
lin contest_V2 = mkV2 (competir_V) ; -- status=guess
lin contest_V = competir_V ; -- status=guess
lin workplace_N = variants{} ; -- 
lin lazy_A = mkA "perezoso" | mkA "flojo" | mkA "locho" | mkA "haragán" | mkA "vago" ; -- status=guess
lin kidney_N = mkN "riñón" masculine ; -- status=guess
lin insistence_N = mkN "insistencia" ; -- status=guess
lin whisper_N = mkN "susurro" ; -- status=guess
lin multimedia_N = mkN "multimedia" masculine ; -- status=guess
lin forestry_N = mkN "silvicultura" ; -- status=guess
lin excited_A = variants{} ; -- 
lin decay_N = variants{} ; -- 
lin screw_N = mkN "tornillo" ; -- status=guess
lin rally_V2V = mkV2V (mkV "reagrupar") | mkV2V (reunir_V) ; -- status=guess
lin rally_V2 = mkV2 (mkV "reagrupar") | mkV2 (reunir_V) ; -- status=guess
lin rally_V = mkV "reagrupar" | reunir_V ; -- status=guess
lin pest_N = mkN "peste" feminine | mkN "pestilencia" | mkN "epidemia" ; -- status=guess
lin invaluable_A = variants{} ; -- 
lin homework_N = mkN "tarea" ; -- status=guess
lin harmful_A = mkA "perjudicial" | mkA "dañino" | mkA "nocivo" ; -- status=guess
lin bump_V2 = variants{} ; -- 
lin bump_V = variants{} ; -- 
lin bodily_A = mkA "corporal" ; -- status=guess
lin grasp_N = mkN "asimiento" ; -- status=guess
lin finished_A = variants{} ; -- 
lin facade_N = variants{} ; -- 
lin cushion_N = mkN "colchón" masculine | mkN "amortiguante" masculine ; -- status=guess
lin conversely_Adv = variants{} ; -- 
lin urge_N = mkN "ansia" masculine | mkN "impulso" ; -- status=guess
lin tune_V2 = mkV2 (mkV "afinar") ; -- status=guess
lin tune_V = mkV "afinar" ; -- status=guess
lin solvent_N = mkN "disolvente" masculine ; -- status=guess
lin slogan_N = mkN "eslogan" | mkN "lema" masculine ; -- status=guess
lin petty_A = mkA "pequeño" | mkA "insignificante" ; -- status=guess
lin perceived_A = variants{} ; -- 
lin install_V2 = mkV2 (mkV "instalar") ; -- status=guess
lin install_V = mkV "instalar" ; -- status=guess
lin fuss_N = mkN "fandango" | mkN "jaleo" | mkN "escándalo" ; -- status=guess
lin rack_N = mkN "estante" ; -- status=guess
lin imminent_A = mkA "inminente" ; -- status=guess
lin short_N = mkN "corto" ; -- status=guess
lin revert_V = revertir_V ; -- status=guess
lin ram_N = mkN "carnero" | mkN "morueco" ; -- status=guess
lin contraction_N = mkN "contracción" feminine ; -- status=guess
lin tread_V2 = mkV2 (mkV "pisar") ; -- status=guess
lin tread_V = mkV "pisar" ; -- status=guess
lin supplementary_A = mkA "suplementario" ; -- status=guess
lin ham_N = mkN "corva" ; -- status=guess
lin defy_V2V = variants{} ; -- 
lin defy_V2 = variants{} ; -- 
lin athlete_N = mkN "atleta" masculine | mkN "deportista" masculine ; -- status=guess
lin sociological_A = mkA "sociológico" ; -- status=guess
lin physician_N = mkN "médico" ; -- status=guess
lin crossing_N = mkN "cruce" masculine ; -- status=guess
lin bail_N = mkN "fianza" ; -- status=guess
lin unwanted_A = variants{} ; -- 
lin tight_Adv = variants{} ; -- 
lin plausible_A = mkA "probable" ; -- status=guess
lin midfield_N = variants{} ; -- 
lin alert_A = mkA "alerto" | mkA "vigilante" ; -- status=guess
lin feminine_A = mkA "femenil" | mkA "de mujeres" ; -- status=guess
lin drainage_N = variants{} ; -- 
lin cruelty_N = mkN "crueldad" feminine ; -- status=guess
lin abnormal_A = mkA "anormal" ; -- status=guess
lin relate_N = variants{} ; -- 
lin poison_V2 = mkV2 (mkV "envenenar") ; -- status=guess
lin symmetry_N = mkN "simetría" ; -- status=guess
lin stake_V2 = mkV2 (mkV "estacar") ; -- status=guess
lin rotten_A = L.rotten_A ;
lin prone_A = mkA "postrado" | mkA "de bruces" ; -- status=guess
lin marsh_N = mkN "ciénaga" | mkN "marisma" | mkN "pantano" ; -- status=guess
lin litigation_N = variants{} ; -- 
lin curl_N = mkN "rizo" | mkN "bucle" masculine ; -- status=guess
lin urine_N = mkN "orina" ; -- status=guess
lin latin_A = variants{} ; -- 
lin hover_V = mkV "revolotear" | mkV "levitar" ; -- status=guess
lin greeting_N = mkN "saludo" ; -- status=guess
lin chase_N = mkN "persecución" feminine ; -- status=guess
lin spouse_N = variants{} ; -- 
lin produce_N = mkN "frutas y verduras" ; -- status=guess
lin forge_V2 = mkV2 (mkV "falsificar") ; -- status=guess
lin forge_V = mkV "falsificar" ; -- status=guess
lin salon_N = mkN "salón" masculine ; -- status=guess
lin handicapped_A = variants{} ; -- 
lin sway_V2 = mkV2 (mkV "balancear") ; -- status=guess
lin sway_V = mkV "balancear" ; -- status=guess
lin homosexual_A = mkA "homosexual" ; -- status=guess
lin handicap_V2 = variants{} ; -- 
lin colon_N = mkN "colon" masculine ; -- status=guess
lin upstairs_N = variants{} ; -- 
lin stimulation_N = mkN "estimulación" feminine ; -- status=guess
lin spray_V2 = mkV2 (mkV "atomizar") | mkV2 (mkV "difundir") | mkV2 (mkV "pulverizar") ; -- status=guess
lin original_N = mkN "original" masculine ; -- status=guess
lin lay_A = mkA "laico" ; -- status=guess
lin garlic_N = mkN "ajo" ; -- status=guess
lin suitcase_N = mkN "maleta" | mkN "petaca" | mkN "valija" ; -- status=guess
lin skipper_N = variants{} ; -- 
lin moan_VS = mkVS (mkV "quejar") ; -- status=guess
lin moan_V2 = mkV2 (mkV "quejar") ; -- status=guess
lin moan_V = mkV "quejar" ; -- status=guess
lin manpower_N = variants{} ; -- 
lin manifest_V2 = mkV2 (manifestar_V) | mkV2 (mostrar_V) | mkV2 (mkV "revelar") ; -- status=guess
lin incredibly_Adv = variants{} ; -- 
lin historically_Adv = variants{} ; -- 
lin decision_making_N = variants{} ; -- 
lin wildly_Adv = variants{} ; -- 
lin reformer_N = variants{} ; -- 
lin quantum_N = mkN "punto cuántico" ; -- status=guess
lin considering_Subj = variants{} ; -- 
}
