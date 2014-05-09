concrete TopDictionaryIta of TopDictionary = CatIta
** open ParadigmsIta, (P = ParadigmsIta), 
        IrregIta, (I=IrregIta), MorphoIta, (L=LexiconIta), (S=StructuralIta), (E=ExtraIta),Prelude in {

oper mkInterj : Str -> Interj
= \s -> lin Interj (ss s) ;
oper mkDet = overload {
  mkDet : Str -> Det = \s -> lin Det {s,sp = \\_,c => prepCase c ++ s ; n = Sg ; s2 = [] ; isNeg = False} ;
  mkDet : Str -> Str -> Number -> Det = 
     \s,t,n -> lin Det {s,sp = \\g,c => prepCase c ++ genForms s t ! g ; n = n ; s2 = [] ; isNeg = False} ;
     } ;
oper mkConj : Str -> Conj
  = \s -> lin Conj {s1 = [] ; s2 = s ; n = Pl} ;
oper mkSubj : Str -> Subj
  = \s -> lin Subj {s = [] ; m = Indic} ; ----
oper subSubj : Str -> Subj
  = \s -> lin Subj {s = [] ; m = Conjunct} ; ----
oper optProDrop : Pron -> Pron = \p -> p | E.ProDrop p ;

lin of_Prep = ParadigmsIta.genitive ;
lin and_Conj = S.and_Conj ;
lin in_Prep = S.in_Prep ;
lin have_VV = mkVV (avere_V) ;
lin have_V2 = S.have_V2 ;
lin have_V = avere_V ;
lin it_Pron = S.it_Pron ;
lin to_Prep = S.to_Prep ;
lin for_Prep = S.for_Prep ;
lin i_Pron = optProDrop S.i_Pron ;
lin iFem_Pron = optProDrop E.i8fem_Pron ;
lin that_Subj = S.that_Subj ;
lin he_Pron = optProDrop S.he_Pron ;
lin on_Prep = S.on_Prep ;
lin with_Prep = S.with_Prep ;
lin do_V2 = mkV2 (fare_V) ;
lin at_Prep = ParadigmsIta.dative ;
lin by_Prep = mkPrep "per" ;
lin but_Conj = mkConj "ma" ;
lin from_Prep = S.from_Prep ;
lin they_Pron = optProDrop S.they_Pron ;
lin theyFem_Pron = optProDrop E.they8fem_Pron ;
lin she_Pron = optProDrop S.she_Pron ;
lin or_Conj = S.or_Conj ;
lin as_Subj = mkSubj "quando" ;
lin we_Pron = optProDrop S.we_Pron ;
lin weFem_Pron = optProDrop E.we8fem_Pron ;
lin say_VS = L.say_VS ;
lin say_V2 = mkV2 dire_V ;
lin say_V = dire_V ;
lin if_Subj = S.if_Subj ;
lin go_VV = mkVV L.go_V ;
lin go_VA = mkVA L.go_V ;
lin go_V = L.go_V ;
lin get_VV = mkVV (mkV "ricevere") ;
lin get_V2V = mkV2V (mkV "ricevere") ;
lin make_V2V = mkV2V I.fare_V ;
lin make_V2A = mkV2A I.fare_V ;
lin make_V2 = mkV2 I.fare_V ;
lin make_V = I.fare_V ;
lin as_Prep = mkPrep "come" ;
lin out_Adv = mkAdv "fuori" ;
lin up_Adv = mkAdv "su" ;
lin see_VS = mkVS vedere_V ;
lin see_VQ = mkVQ vedere_V ;
lin see_V2V = mkV2V vedere_V ;
lin see_V2 = L.see_V2 ;
lin see_V = vedere_V ;
lin know_VS = L.know_VS ;
lin know_VQ = L.know_VQ ;
lin know_V2 = L.know_V2 ;
lin know_V = conoscere_V ; -- status=guess, src=wikt
lin time_N = mkN "tempo" ;
lin time_2_N = mkN "volta" ;
lin time_1_N = mkN "tempo" ;
lin take_V2 = mkV2 prendere_V ;
lin so_Adv = mkAdv "così" ;
lin year_N = L.year_N ;
lin into_Prep = mkPrep "dentro" ;
lin then_Adv = mkAdv "allora" ;
lin think_VS = mkVS (mkV "pensare") ;
lin think_V2 = mkV2 (mkV "pensare") ;
lin think_V = L.think_V ;
lin come_V = L.come_V ;
lin than_Subj = mkSubj "che" ;
lin more_Adv = mkAdv "più" ;
lin about_Prep = ParadigmsIta.genitive ;
lin now_Adv = L.now_Adv ;
lin last_A = mkA "ultimo" ;
lin last_1_A = mkA "ultimo" ;
lin last_2_A = mkA "scorso" ;
lin other_A = mkA "altro" ;
lin give_V3 = L.give_V3 ;
lin give_V2 = mkV2 (dare_V) ;
lin give_V = dare_V ;
lin just_Adv = mkAdv "or ora" ; -- status=guess
lin people_N = mkN "gente" feminine | mkN "popolo" ; --- split -- | many people -- | all peoples
lin also_Adv = mkAdv "anche" ;
lin well_Adv = mkAdv "bene" ;
lin only_Adv = mkAdv "solo" | mkAdv "solamente" ;
lin new_A = L.new_A ;
lin when_Subj = S.when_Subj ;
lin way_N = mkN "maniera" ;
lin way_2_N = mkN "maniera" ;
lin way_1_N = mkN "strada" | mkN "via" ;
lin look_VA = mkVA (mkV "sembrare") ;
lin look_V2 = mkV2 (mkV "guardare") ;
lin look_V = mkV "guardare" | mkV "osservare" ;
lin like_Prep = mkPrep "come" ;
lin use_VV = mkVV (mkV "usare") ;
lin use_V2 = mkV2 (mkV "usare") | mkV2 (mkV "utilizzare") ;
lin use_V = mkV "usare" ;
lin because_Subj = S.because_Subj ;
lin good_A = L.good_A ;
lin find_VS = mkVS (mkV "trovare") ;
lin find_V2A = mkV2A (mkV "trovare") ;
lin find_V2 = L.find_V2 ;
lin find_V = mkV "trovare" ;
lin man_N = L.man_N ;
lin want_VV = S.want_VV ;
lin want_V2V = mkV2V (volere_V) ;
lin want_V2 = mkV2 (volere_V) ;
lin want_V = volere_V ;
lin day_N = L.day_N ;
lin between_Prep = S.between_Prep ;
lin even_Adv = mkAdv "ancora" ;
lin there_Adv = S.there_Adv ;
lin many_Det = S.many_Det ;
lin after_Prep = S.after_Prep ;
lin down_Adv = mkAdv "giù" ;
lin yeah_Interj = lin Interj {s = "sì"} ;
lin so_Subj = subSubj "finché" ;
lin thing_N = mkN "cosa" ; -- status=guess
lin tell_VS = variants{}; -- mkV2 "raccontare" ;
lin tell_V3 = mkV3 (mkV "raccontare") ;
lin tell_1_V3 = variants{} ; -- 
lin tell_2_V3 = variants{} ; -- 
lin tell_V2V = variants{}; -- mkV2 "raccontare" ;
lin tell_V2S = variants{}; -- mkV2 "raccontare" ;
lin tell_V2 = mkV2 "raccontare" ;
lin tell_V = mkV "raccontare" ;
lin through_Prep = S.through_Prep ;
lin back_Adv = mkAdv "indietro" | mkAdv "a posto" ; -- status=guess status=guess
lin still_Adv = mkAdv "ancora" ; -- status=guess
lin child_N = L.child_N ;
lin here_Adv = mkAdv "qui" | mkAdv "qua" ; -- status=guess status=guess
lin over_Prep = mkPrep "sopra" ;
lin too_Adv = mkAdv "anche" | mkAdv "pure" ; -- status=guess status=guess
lin put_V2 = L.put_V2 ;
lin on_Adv = mkAdv "carponi" | mkAdv "a quattro piedi" ; -- status=guess status=guess
lin no_Interj = mkInterj "no comment" ; -- status=guess
lin work_V2 = mkV2 (mkV "lavorare") ; -- status=guess, src=wikt
lin work_V = mkV "lavorare" ; -- status=guess, src=wikt
lin work_2_V = mkV "funzionare" ;
lin work_1_V = mkV "lavorare" ;
lin become_VA = L.become_VA ;
lin become_V2 = mkV2 (mkV "diventare") ; -- status=guess, src=wikt
lin become_V = mkV "diventare" ; -- status=guess, src=wikt
lin old_A = L.old_A ;
lin government_N = mkN "governamento" ;
lin mean_VV = mkVV (mkV "significare") ; -- status=guess, src=wikt
lin mean_VS = mkVS (mkV "significare") ; -- status=guess, src=wikt
lin mean_V2V = mkV2V (mkV "significare") ; -- status=guess, src=wikt
lin mean_V2 = mkV2 (mkV "significare") ; -- status=guess, src=wikt
lin part_N = mkN "parte" feminine ; -- status=guess
lin leave_V2V = mkV2V (mkV "lasciare") | mkV2V (mkV "dimenticare") ; -- status=guess, src=wikt status=guess, src=wikt
lin leave_V2 = L.leave_V2 ;
lin leave_V = mkV "lasciare" | mkV "dimenticare" ; -- status=guess, src=wikt status=guess, src=wikt
lin life_N = mkN "vita" feminine ;
lin great_A = mkA "magno" | mkA "magna" ; -- status=guess status=guess
lin case_N = mkN "cassetta" masculine ; -- status=guess
lin woman_N = L.woman_N ;
lin over_Adv = mkAdv "nuovamente" | mkAdv "ancora" ; -- status=guess status=guess
lin seem_VV = mkVV (mkV "sembrare") | mkVV (parere_V) | mkVV (mkV "apparire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin seem_VS = mkVS (mkV "sembrare") | mkVS (parere_V) | mkVS (mkV "apparire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin seem_VA = mkVA (mkV "sembrare") | mkVA (parere_V) | mkVA (mkV "apparire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin work_N = mkN "lavoro" feminine | mkN "impegno" | mkN "fatica" ; -- status=guess status=guess status=guess
lin need_VV = mkVV (mkV (essere_V) "obbligato a") ; -- status=guess, src=wikt
lin need_VV = mkVV (mkV (essere_V) "obbligato a") ; -- status=guess, src=wikt
lin need_V2 = mkV2 (mkV (essere_V) "obbligato a") ; -- status=guess, src=wikt
lin need_V = mkV (essere_V) "obbligato a" ; -- status=guess, src=wikt
lin feel_VS = mkVS (mkV (avere_V) "voglia di") ; -- status=guess, src=wikt
lin feel_VA = mkVA (mkV (avere_V) "voglia di") ; -- status=guess, src=wikt
lin feel_V2 = mkV2 (mkV (avere_V) "voglia di") ; -- status=guess, src=wikt
lin feel_V = mkV (avere_V) "voglia di" ; -- status=guess, src=wikt
lin system_N = mkN "sistema" masculine ; -- status=guess
lin each_Det = mkDet "ogni" | mkDet "ognuno" | mkDet "ciascuno" ; -- status=guess status=guess status=guess
lin may_2_VV = mkVV potere_V ;
lin may_1_VV = mkVV potere_V ;
lin much_Adv = mkAdv "molto" ; -- status=guess
lin ask_VQ = mkVQ (chiedere_V) | mkVQ (mkV "domandare") ; -- status=guess, src=wikt status=guess, src=wikt
lin ask_V2V = mkV2V (chiedere_V) | mkV2V (mkV "domandare") ; -- status=guess, src=wikt status=guess, src=wikt
lin ask_V2 = mkV2 (chiedere_V) | mkV2 (mkV "domandare") ; -- status=guess, src=wikt status=guess, src=wikt
lin ask_V = chiedere_V | mkV "domandare" ; -- status=guess, src=wikt status=guess, src=wikt
lin group_N = mkN "gruppo" ; -- status=guess
lin number_N = L.number_N ;
lin number_3_N = L.number_N ;
lin number_2_N = L.number_N ;
lin number_1_N = L.number_N ;
lin yes_Interj = mkInterj "sì" ; -- status=guess
lin however_Adv = mkAdv "però" | mkAdv "nonostante" ; -- status=guess status=guess
lin another_Det = mkDet "un altro" "un'altra" singular ;
lin again_Adv = mkAdv "di nuovo" | mkAdv "ancora" ; -- status=guess status=guess
lin world_N = mkN "mondo" ;
lin area_N = mkN "area" ; --
lin area_6_N = mkN "areale" ;
lin area_5_N = mkN "area" ;
lin area_4_N = mkN "area" ;
lin area_3_N = mkN "area" ;
lin area_2_N = mkN "area" ;
lin area_1_N = mkN "regione" ;
lin show_VS = mkVS (mkV "mostrare") ;
lin show_VQ = mkVQ (mkV "mostrare") ;
lin show_V2 = mkV2 (mkV "mostrare") ;
lin show_V = mkV "mostrare" ;
lin course_N = mkN "corso" | mkN "rotta" ;
lin company_2_N = mkN "compagnia" ;
lin company_1_N = mkN "compagnia" ;
lin under_Prep = S.under_Prep ;
lin problem_N = mkN "problema" masculine ;
lin against_Prep = mkPrep "contro" ;
lin never_Adv = mkAdv "mai" ;
lin most_Adv = mkAdv "il più" ;
lin service_N = mkN "servizio" feminine ;
lin try_VV = mkVV (mkV "provare") | mkVV (mkV "cercare") ;
lin try_V2 = mkV2 (mkV "provare") | mkV2 (mkV "misurare") ;
lin try_V = mkV "provare" | mkV "cercare" ;
lin call_V2 = mkV2 (mkV "chiamare") ;
lin call_V = mkV "chiamare" ;
lin hand_N = L.hand_N ;
lin party_N = mkN "partito" ;
lin party_2_N = mkN "partito" ; --
lin party_1_N = mkN "festa" ; --
lin high_A = mkA "alto" | mkA "elevato" ;
lin about_Adv = mkAdv "intorno" ;
lin something_NP = S.something_NP ;
lin school_N = L.school_N ;
lin in_Adv = mkAdv "dentro" ;
lin in_1_Adv = mkAdv "dentro" ;
lin in_2_Adv = mkAdv "dentro" ;
lin small_A = L.small_A ;
lin place_N = mkN "luogo" ;
lin before_Prep = S.before_Prep ;
lin while_Subj = mkSubj "mentre" ;
lin away_Adv = mkAdv "lontano" ;
lin away_2_Adv = mkAdv "lontano" ;
lin away_1_Adv = mkAdv "lontano" ;
lin keep_VV = mkVV tenere_V ;
lin keep_V2A = mkV2A tenere_V ;
lin keep_V2 = mkV2 tenere_V ;
lin keep_V = tenere_V ;
lin point_N = mkN "punto" ;
lin point_2_N = mkN "punto" ;
lin point_1_N = mkN "punto" ;
lin house_N = L.house_N ;
lin different_A = mkA "diverso" | mkA "differente" ;
lin country_N = L.country_N ;
lin really_Adv = mkAdv "davvero" ;
lin provide_V2 = mkV2 (provvedere_V) ;
lin provide_V = provvedere_V ;
lin week_N = mkN "settimana" masculine ;
lin hold_VS = mkVS (tenere_V) ;
lin hold_V2 = L.hold_V2 ;
lin hold_V = tenere_V ;
lin large_A = mkA "largo" ;
lin member_N = mkN "membro" ;
lin off_Adv = mkAdv "via" ;
lin always_Adv = mkAdv "sempre" ;
lin follow_VS = mkVS (mkV "seguire") ;
lin follow_V2 = mkV2 (mkV "seguire") ;
lin follow_V = mkV "seguire" ;
lin without_Prep = S.without_Prep ;
lin turn_VA = mkVA L.turn_V ;
lin turn_V2 = mkV2 L.turn_V ;
lin turn_V = L.turn_V ;
lin end_N = mkN "fine" feminine ;
lin end_2_N = mkN "capo" ; ----
lin end_1_N = mkN "fine" feminine ;
lin within_Prep = mkPrep "dentro" ;
lin local_A = mkA "locale" ;
lin where_Subj = mkSubj "dove" ;
lin during_Prep = S.during_Prep ;
lin bring_V3 = mkV3 (mkV "portare") ;
lin bring_V2 = mkV2 (mkV "portare") ;
lin most_Det = mkDet "la maggior parte di" ; ---- prep
lin word_N = mkN "parola" ;
lin begin_V2 = mkV2 (mkV "cominciare") | mkV2 (mkV "iniziare") ;
lin begin_V = mkV "cominciare" ;
lin although_Subj = S.although_Subj ;
lin example_N = mkN "esempio" ;
lin next_Adv = mkAdv "prossimamente" ; --
lin family_N = mkN "famiglia" ; -- status=guess
lin rather_Adv = mkAdv "piuttosto" | mkAdv "preferibilmente" ;
lin fact_N = mkN "fatto" ;
lin like_VV = mkVV (piacere_V) ; ---- "a [with subject and object reversed]") ; -- status=guess, src=wikt
lin like_VS = mkVS (piacere_V) ; ---- "a [with subject and object reversed]") ; -- status=guess, src=wikt
lin like_V2 = L.like_V2 ;
lin social_A = mkA "sociale" ;
lin write_VS = mkVS (scrivere_V) ;
lin write_V2 = L.write_V2 ;
lin write_V = scrivere_V ; -- status=guess, src=wikt
lin state_N = mkN "stato" ; -- status=guess
lin state_2_N = mkN "stato" ;
lin state_1_N = mkN "stato" ;
lin percent_N = mkN "per cento" ; -- status=guess
lin quite_Adv = S.quite_Adv ;
lin both_Det = mkDet "entrambi" "entrambi" plural ;
lin start_V2 = mkV2 (mkV "cominciare") ; -- status=guess, src=wikt
lin start_V = mkV "cominciare" ; -- status=guess, src=wikt
lin run_V2 = mkV2 L.run_V ;
lin run_V = L.run_V ;
lin long_A = L.long_A ;
lin right_Adv = mkAdv "corretto" ;
lin right_2_Adv = mkAdv "destra" ;
lin right_1_Adv = mkAdv "correttamente" ;
lin set_V2 = mkV2 mettere_V ;
lin help_V2V = mkV2V (mkV "aiutare") ; -- status=guess, src=wikt
lin help_V2 = mkV2 (mkV "aiutare") ; -- status=guess, src=wikt
lin help_V = mkV "aiutare" ; -- status=guess, src=wikt
lin every_Det = S.every_Det ;
lin home_N = mkN "home theater" | mkN "home theatre" | mkN "home cinema" ; -- status=guess status=guess status=guess
lin month_N = mkN "mese" masculine ; -- status=guess
lin side_N = mkN "lato" ; -- status=guess
lin night_N = L.night_N ;
lin important_A = L.important_A ;
lin eye_N = L.eye_N ;
lin head_N = L.head_N ;
lin information_N = mkN "informazione" feminine ; -- status=guess
lin question_N = L.question_N ;
lin business_N = mkN "azienda" ; -- status=guess
lin play_V2 = L.play_V2 ;
lin play_V = lin V L.play_V2 ;
lin play_3_V2 = L.play_V2 ;
lin play_3_V = lin V L.play_V2 ;
lin play_2_V2 = L.play_V2 ;
lin play_2_V = lin V L.play_V2 ;
lin play_1_V2 = L.play_V2 ;
lin play_1_V = lin V L.play_V ;
lin power_N = mkN "potenze celesti" ; -- status=guess
lin money_N = mkN "liquido" ; -- status=guess
lin change_N = mkN "cambio" ; -- status=guess
lin move_V2 = mkV2 (mkV "smuoversi") | mkV2 (mkV (mkV "darsi") "una mossa") | mkV2 (mkV "agire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin move_V = mkV "smuoversi" | mkV (mkV "darsi") "una mossa" | mkV "agire" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin move_2_V = reflV I.muovere_V ;
lin move_1_V = reflV I.muovere_V ;
lin interest_N = mkN "interesse" ;
lin interest_4_N = mkN "interesse" ;
lin interest_2_N = mkN "interesse" ;
lin interest_1_N = mkN "interesse" ;
lin order_N = mkN "ordine" masculine ; -- status=guess
lin book_N = L.book_N ;
lin often_Adv = mkAdv "spesso" ; -- status=guess
lin development_N = mkN "sviluppo" | mkN "potenziamento" ; -- status=guess status=guess
lin young_A = L.young_A ;
lin national_A = mkA "nazionale" ; -- status=guess
lin pay_V3 = mkV3 (mkV "pagare") ; -- status=guess, src=wikt
lin pay_V2V = mkV2V (mkV "pagare") ; -- status=guess, src=wikt
lin pay_V2 = mkV2 (mkV "pagare") ; -- status=guess, src=wikt
lin pay_V = mkV "pagare" ; -- status=guess, src=wikt
lin hear_VS = mkVS (sentire_V) | mkVS (udire_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin hear_V2V = mkV2V (sentire_V) | mkV2V (udire_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin hear_V2 = L.hear_V2 ;
lin hear_V = sentire_V | udire_V ; -- status=guess, src=wikt status=guess, src=wikt
lin room_N = mkN "stanza" | mkN "camera" | mkN "sala" ; -- status=guess status=guess status=guess
lin room_1_N = mkN "stanza" | mkN "camera" ;
lin room_2_N = mkN "spazio" ;
lin whether_Subj = mkSubj "se" ;
lin water_N = L.water_N ;
lin form_N = mkN "formulario" ; --- split -- | geometric form -- | fill a form
lin car_N = L.car_N ;
lin other_N = mkN "altro" ;
lin yet_Adv = mkAdv "ancora" ;
lin yet_2_Adv = mkAdv "però" ;
lin yet_1_Adv = mkAdv "ancora" ;
lin perhaps_Adv = mkAdv "forse" | mkAdv "magari" ; -- status=guess
lin meet_V2 = mkV2 (mkV "ottemperare") | mkV2 (mkV "conformarsi") | mkV2 (soddisfare_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin meet_V = mkV "ottemperare" | mkV "conformarsi" | soddisfare_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin level_N = mkN "livello" ; -- status=guess
lin level_2_N = mkN "livello" ;
lin level_1_N = mkN "livello" ;
lin until_Subj = subSubj "fino a che" ;
lin though_Subj = subSubj "benché" ;
lin policy_N = mkN "polizza" ; -- status=guess
lin include_V2 = mkV2 (mkV "includere") | mkV2 (mkV "inserire") | mkV2 (aggiungere_V) | mkV2 (comprendere_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin include_V = mkV "includere" | mkV "inserire" | aggiungere_V | comprendere_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin believe_VS = mkVS (mkV "credere") ; -- status=guess, src=wikt
lin believe_V2 = mkV2 (mkV "credere") ; -- status=guess, src=wikt
lin believe_V = mkV "credere" ; -- status=guess, src=wikt
lin council_N = mkN "consiglio" ; -- status=guess
lin already_Adv = L.already_Adv ;
lin possible_A = mkA "possibile" ; -- status=guess
lin nothing_NP = S.nothing_NP ;
lin line_N = mkN "partizione" feminine ; -- status=guess
lin allow_V2V = mkV2V (permettere_V) ; -- status=guess, src=wikt
lin allow_V2 = mkV2 (permettere_V) ; -- status=guess, src=wikt
lin need_N = mkN "bisogno" ; -- status=guess
lin effect_N = mkN "effetto" ; -- status=guess
lin big_A = L.big_A ;
lin use_N = mkN "uso" ; -- status=guess
lin lead_V2V = mkV2V (mkV (essere_V) "di mano") ; -- status=guess, src=wikt
lin lead_V2 = mkV2 (mkV (essere_V) "di mano") ; -- status=guess, src=wikt
lin lead_V = mkV (essere_V) "di mano" ; -- status=guess, src=wikt
lin stand_V2 = mkV2 (mkV (I.fare_V) "una pausa") ; -- status=guess, src=wikt
lin stand_V = L.stand_V ;
lin idea_N = mkN "impressione" feminine ; -- status=guess
lin study_N = mkN "studio" ; -- status=guess
lin lot_N = mkN "destino" ; -- status=guess
lin live_V = L.live_V ;
lin job_N = mkN "descrizione di posizione" feminine ; -- status=guess
lin since_Subj = mkSubj "fino da che" ; ----
lin name_N = L.name_N ;
lin result_N = mkN "risultato" ; -- status=guess
lin body_N = mkN "corpo" feminine ; -- status=guess
lin happen_VV = mkVV (accadere_V) | mkVV (succedere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin happen_V = accadere_V | succedere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin friend_N = L.friend_N ;
lin right_N = mkN "angolo retto" ; -- status=guess
lin least_Adv = mkAdv "meno" ; -- status=guess
lin right_A = mkA "destro" ; -- status=guess
lin right_2_A = mkA "destro" ;
lin right_1_A = mkA "corretto" ;
lin almost_Adv = mkAdv "quasi" ; -- status=guess
lin much_Det = S.much_Det ;
lin carry_V2 = mkV2 (mkV "portare") ; -- status=guess, src=wikt
lin carry_V = mkV "portare" ; -- status=guess, src=wikt
lin authority_N = mkN "autorità" feminine ; -- status=guess
lin authority_2_N = mkN "autorità" ;
lin authority_1_N = mkN "autorità" ;
lin long_Adv = mkAdv "lungo tempo" ;
lin early_A = mkA "precoce" ; -- status=guess
lin view_N = mkN "vista" masculine ; -- status=guess
lin view_2_N = mkN "opinione" ;
lin view_1_N = mkN "vista" ;
lin public_A = mkA "pubblico" ; -- status=guess
lin together_Adv = mkAdv "insieme" ; -- status=guess
lin talk_V2 = mkV2 (mkV "parlare") ; -- status=guess, src=wikt
lin talk_V = mkV "parlare" ; -- status=guess, src=wikt
lin report_N = mkN "rapporto" ; -- status=guess
lin after_Subj = mkSubj "dopo" ;
lin only_Predet = S.only_Predet ;
lin before_Subj = subSubj "primo che" ;
lin bit_N = mkN "morso" | mkN "freno" ; -- status=guess status=guess
lin face_N = mkN "faccia" ; -- status=guess
lin sit_V2 = mkV2 (mkV "sedersi") ; -- status=guess, src=wikt
lin sit_V = L.sit_V ;
lin market_N = mkN "mercato" ; -- status=guess
lin market_1_N = mkN "mercato" ;
lin market_2_N = mkN "mercato" ;
lin appear_VV = mkVV (mkV "apparire") ; -- status=guess, src=wikt
lin appear_VS = mkVS (mkV "apparire") ; -- status=guess, src=wikt
lin appear_VA = mkVA (mkV "apparire") ; -- status=guess, src=wikt
lin appear_V = mkV "apparire" ; -- status=guess, src=wikt
lin continue_VV = mkVV (mkV "continuare") ; -- status=guess, src=wikt
lin continue_V2 = mkV2 (mkV "continuare") ; -- status=guess, src=wikt
lin continue_V = mkV "continuare" ; -- status=guess, src=wikt
lin able_A = mkA "capace" ; -- status=guess
lin political_A = mkA "politico" ; -- status=guess
lin later_Adv = mkAdv "più tardi" ; -- status=guess
lin hour_N = mkN "ora" ; -- status=guess
lin rate_N = mkN "proporzione" feminine ; -- status=guess
lin law_N = mkN "diritto" ; -- status=guess
lin law_2_N = mkN "diritto" ;
lin law_1_N = mkN "legge" feminine ;
lin door_N = L.door_N ;
lin court_N = mkN "cortile" masculine ; -- status=guess
lin court_2_N = variants{} ; -- 
lin court_1_N = variants{} ; -- 
lin office_N = mkN "ufficio" ; -- status=guess
lin let_V2V = mkV2V (mkV "lasciare") ;
lin war_N = L.war_N ;
lin produce_V2 = mkV2 (mkV "fornire") ; -- status=guess, src=wikt
lin produce_V = mkV "fornire" ; -- status=guess, src=wikt
lin reason_N = L.reason_N ;
lin less_Adv = mkAdv "meno" ; -- status=guess
lin minister_N = variants{} ; -- 
lin minister_2_N = variants{} ; -- 
lin minister_1_N = variants{} ; -- 
lin subject_N = mkN "suddito" ; -- status=guess
lin subject_2_N = variants{} ; -- 
lin subject_1_N = variants{} ; -- 
lin person_N = L.person_N ;
lin term_N = mkN "termine" masculine ; -- status=guess
lin particular_A = variants{} ; -- 
lin full_A = L.full_A ;
lin involve_VS = variants{} ; -- 
lin involve_V2 = variants{} ; -- 
lin involve_V = variants{} ; -- 
lin sort_N = mkN "tipo" ; -- status=guess
lin require_VS = variants{} ; -- 
lin require_V2V = variants{} ; -- 
lin require_V2 = variants{} ; -- 
lin require_V = variants{} ; -- 
lin suggest_VS = mkVS (proporre_V) | mkVS (mkV "suggerire") ; -- status=guess, src=wikt status=guess, src=wikt
lin suggest_V2 = mkV2 (proporre_V) | mkV2 (mkV "suggerire") ; -- status=guess, src=wikt status=guess, src=wikt
lin suggest_V = proporre_V | mkV "suggerire" ; -- status=guess, src=wikt status=guess, src=wikt
lin far_A = mkA "lontano" ; -- status=guess
lin towards_Prep = variants{} ; -- 
lin anything_NP = variants{} ; -- 
lin period_N = mkN "periodo" ; -- status=guess
lin period_3_N = variants{} ; -- 
lin period_2_N = variants{} ; -- 
lin period_1_N = variants{} ; -- 
lin consider_VV = mkVV (mkV "considerare") ;
lin consider_VS = variants{}; -- mkV2 "considerare" ;
lin consider_V3 = variants{}; -- mkV2 "considerare" ;
lin consider_V2V = variants{}; -- mkVV (mkV "considerare") ;
lin consider_V2A = variants{}; -- mkV2 "considerare" ;
lin consider_V2 = mkV2 "considerare" ;
lin consider_V = mkV "considerare" ;
lin read_VS = mkVS I.leggere_V ;
lin read_V2 = L.read_V2 ;
lin read_V = lin V L.read_V2 ;
lin change_V2 = mkV2 (mkV "cambiare") ; -- status=guess, src=wikt
lin change_V = mkV "cambiare" ; -- status=guess, src=wikt
lin society_N = mkN "società" feminine ; -- status=guess
lin process_N = mkN "processo" | mkN "procedimento" ; -- status=guess status=guess
lin mother_N = mkN "madre" feminine | mkN "mamma" ;
lin offer_VV = mkVV (mkV "offrire") ; -- status=guess, src=wikt
lin offer_V2 = mkV2 (mkV "offrire") ; -- status=guess, src=wikt
lin late_A = mkA "compianto" ; -- status=guess
lin voice_N = mkN "voce" feminine ; -- status=guess
lin both_Adv = variants{} ; -- 
lin once_Adv = mkAdv "un tempo" ; -- status=guess
lin police_N = mkN "polizia" ; -- status=guess
lin kind_N = mkN "genere" masculine | mkN "tipo" ; -- status=guess status=guess
lin lose_V2 = L.lose_V2 ;
lin lose_V = perdere_V ; -- status=guess, src=wikt
lin add_VS = mkVS (aggiungere_V) ; -- status=guess, src=wikt
lin add_V2 = mkV2 (aggiungere_V) ; -- status=guess, src=wikt
lin add_V = aggiungere_V ; -- status=guess, src=wikt
lin probably_Adv = variants{} ; -- 
lin expect_VV = variants{} ; -- 
lin expect_VS = variants{} ; -- 
lin expect_V2V = variants{} ; -- 
lin expect_V2 = variants{} ; -- 
lin expect_V = variants{} ; -- 
lin ever_Adv = variants{} ; -- 
lin available_A = mkA "disponibile" ; -- status=guess
lin price_N = mkN "prezzo" ; -- status=guess
lin little_A = mkA "piccolo" ; -- status=guess
lin action_N = mkN "azione" feminine ; -- status=guess
lin issue_N = mkN "emissione" feminine | mkN "fuoriuscita" ; -- status=guess status=guess
lin issue_2_N = variants{} ; -- 
lin issue_1_N = variants{} ; -- 
lin far_Adv = L.far_Adv ;
lin remember_VS = mkVS (mkV "ricordare") ; -- status=guess, src=wikt
lin remember_V2 = mkV2 (mkV "ricordare") ; -- status=guess, src=wikt
lin remember_V = mkV "ricordare" ; -- status=guess, src=wikt
lin position_N = mkN "posizione" feminine ; -- status=guess
lin low_A = mkA "basso" ; -- status=guess
lin cost_N = mkN "costo" | mkN "spesa" ; -- status=guess status=guess
lin little_Det = variants{} ; -- 
lin matter_N = mkN "materia" ; -- status=guess
lin matter_1_N = variants{} ; -- 
lin matter_2_N = variants{} ; -- 
lin community_N = mkN "comunanza" ; -- status=guess
lin remain_VV = mkVV (rimanere_V) ; -- status=guess, src=wikt
lin remain_VA = mkVA (rimanere_V) ; -- status=guess, src=wikt
lin remain_V2 = mkV2 (rimanere_V) ; -- status=guess, src=wikt
lin remain_V = rimanere_V ; -- status=guess, src=wikt
lin figure_N = mkN "figura" ; -- status=guess
lin figure_2_N = variants{} ; -- 
lin figure_1_N = variants{} ; -- 
lin type_N = mkN "tipo" ; -- status=guess
lin research_N = mkN "ricerca" ; -- status=guess
lin actually_Adv = variants{} ; -- 
lin education_N = mkN "istruzione" feminine | mkN "educazione" feminine ; -- status=guess status=guess
lin fall_V = mkV (cadere_V) "a pezzi" ; -- status=guess, src=wikt
lin speak_V2 = L.speak_V2 ;
lin speak_V = mkV "esternare" ; -- status=guess, src=wikt
lin few_N = variants{} ; -- 
lin today_Adv = L.today_Adv ;
lin enough_Adv = variants{} ; -- 
lin open_V2 = L.open_V2 ;
lin open_V = mkV "toccare" ; -- status=guess, src=wikt
lin bad_A = L.bad_A ;
lin buy_V2 = L.buy_V2 ;
lin buy_V = mkV "comprare" ; -- status=guess, src=wikt
lin programme_N = variants{} ; -- 
lin minute_N = mkN "attimo" | mkN "momento" feminine ; -- status=guess status=guess
lin moment_N = mkN "momento" feminine ; -- status=guess
lin girl_N = L.girl_N ;
lin age_N = mkN "generazione" feminine ; -- status=guess
lin centre_N = mkN "centravanti" ; -- status=guess
lin stop_VV = mkVV (mkV "fermare") ; -- status=guess, src=wikt
lin stop_V2 = mkV2 (mkV "fermare") ; -- status=guess, src=wikt
lin stop_V = L.stop_V ;
lin control_N = variants{} ; -- 
lin value_N = mkN "imposta sul valore aggiunto" ; -- status=guess
lin send_V2V = mkV2V (mkV "inviare") | mkV2V (mkV "mandare") | mkV2V (mkV "rimandare") | mkV2V (mkV "restituire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin send_V2 = mkV2 (mkV "inviare") | mkV2 (mkV "mandare") | mkV2 (mkV "rimandare") | mkV2 (mkV "restituire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin send_V = mkV "inviare" | mkV "mandare" | mkV "rimandare" | mkV "restituire" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin health_N = mkN "salute" | mkN "sanità" feminine ; -- status=guess status=guess
lin decide_VV = variants{} ; -- 
lin decide_VS = variants{} ; -- 
lin decide_V2 = variants{} ; -- 
lin decide_V = variants{} ; -- 
lin main_A = mkA "principale" ; -- status=guess
lin win_V2 = L.win_V2 ;
lin win_V = vincere_V ; -- status=guess, src=wikt
lin understand_VS = mkVS (mkV "capire") | mkVS (comprendere_V) | mkVS (mkV "intendere") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin understand_V2 = L.understand_V2 ;
lin understand_V = mkV "capire" | comprendere_V | mkV "intendere" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin decision_N = mkN "decisione" feminine ; -- status=guess
lin develop_V2 = mkV2 (mkV "sviluppare") ; -- status=guess, src=wikt
lin develop_V = mkV "sviluppare" ; -- status=guess, src=wikt
lin class_N = mkN "classe" feminine ; -- status=guess
lin industry_N = L.industry_N ;
lin receive_V2 = mkV2 (mkV "ricevere") ; -- status=guess, src=wikt
lin receive_V = mkV "ricevere" ; -- status=guess, src=wikt
lin back_N = L.back_N ;
lin several_Det = variants{} ; -- 
lin return_V2 = mkV2 (mkV "tornare") ; -- status=guess, src=wikt
lin return_V = mkV "tornare" ; -- status=guess, src=wikt
lin build_V2 = mkV2 (mkV "costruire") | mkV2 (mkV "edificare") ; -- status=guess, src=wikt status=guess, src=wikt
lin build_V = mkV "costruire" | mkV "edificare" ; -- status=guess, src=wikt status=guess, src=wikt
lin spend_V2 = mkV2 (mkV "spendere") ; -- status=guess, src=wikt
lin spend_V = mkV "spendere" ; -- status=guess, src=wikt
lin force_N = mkN "forza" ; -- status=guess
lin condition_N = mkN "condizioni" feminine ; -- status=guess
lin condition_1_N = variants{} ; -- 
lin condition_2_N = variants{} ; -- 
lin paper_N = L.paper_N ;
lin off_Prep = variants{} ; -- 
lin major_A = mkA "principale" ; -- status=guess
lin describe_VS = mkVS (descrivere_V) ; -- status=guess, src=wikt
lin describe_V2 = mkV2 (descrivere_V) ; -- status=guess, src=wikt
lin agree_VV = mkVV (mkV "concordare") ; -- status=guess, src=wikt
lin agree_VS = mkVS (mkV "concordare") ; -- status=guess, src=wikt
lin agree_V = mkV "concordare" ; -- status=guess, src=wikt
lin economic_A = mkA "economico" | mkA "economo" ; -- status=guess status=guess
lin increase_V2 = mkV2 (mkV "aumentare") ; -- status=guess, src=wikt
lin increase_V = mkV "aumentare" ; -- status=guess, src=wikt
lin upon_Prep = variants{} ; -- 
lin learn_VV = mkVV (mkV "imparare") | mkVV (apprendere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin learn_VS = mkVS (mkV "imparare") | mkVS (apprendere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin learn_V2 = L.learn_V2 ;
lin learn_V = mkV "imparare" | apprendere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin general_A = mkA "generale" ; -- status=guess
lin century_N = mkN "centuria" ; -- status=guess
lin therefore_Adv = mkAdv "quindi" ; -- status=guess
lin father_N = mkN "padre" | mkN "babbo" | mkN "papà" masculine ; -- status=guess status=guess status=guess
lin section_N = mkN "sezione" feminine ; -- status=guess
lin patient_N = mkN "paziente" masculine ; -- status=guess
lin around_Adv = variants{} ; -- 
lin activity_N = mkN "attività" feminine ; -- status=guess
lin road_N = L.road_N ;
lin table_N = L.table_N ;
lin including_Prep = variants{} ; -- 
lin church_N = L.church_N ;
lin reach_V2 = mkV2 (mkV "allungare") | mkV2 (mkV "stendere") | mkV2 (raggiungere_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reach_V = mkV "allungare" | mkV "stendere" | raggiungere_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin real_A = mkA "vero" | mkA "vera" ; -- status=guess status=guess
lin lie_VS = mkVS (mkV (essere_V) "sdraiato") | mkVS (mkV (essere_V) "disteso") | mkVS (mkV "giacere") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lie_2_V = mkV "mentire" ;
lin lie_1_V = L.lie_V ;
lin mind_N = mkN "mente" feminine ; -- status=guess
lin likely_A = mkA "promettente" ; -- status=guess
lin among_Prep = variants{} ; -- 
lin team_N = mkN "squadra" masculine ; -- status=guess
lin experience_N = mkN "esperienza" ; -- status=guess
lin death_N = mkN "la morte" | mkN "l'arcano senza nome" ; -- status=guess status=guess
lin soon_Adv = mkAdv "presto" | mkAdv "a breve" ; -- status=guess status=guess
lin act_N = mkN "atto" ; -- status=guess
lin sense_N = mkN "senso" | mkN "coscienza" | mkN "sensazione" feminine ; -- status=guess status=guess status=guess
lin staff_N = mkN "personale" masculine | mkN "organico" ; -- status=guess status=guess
lin staff_2_N = variants{} ; -- 
lin staff_1_N = variants{} ; -- 
lin certain_A = mkA "certo" ; -- status=guess
lin certain_2_A = variants{} ; -- 
lin certain_1_A = variants{} ; -- 
lin student_N = L.student_N ;
lin half_Predet = variants{} ; -- 
lin half_Predet = variants{} ; -- 
lin around_Prep = variants{} ; -- 
lin language_N = L.language_N ;
lin walk_V2 = mkV2 (mkV (mkV "camminare") "sul filo del rasoio") ; -- status=guess, src=wikt
lin walk_V = L.walk_V ;
lin die_V = L.die_V ;
lin special_A = mkA "speciale" ; -- status=guess
lin difficult_A = mkA "difficile" ; -- status=guess
lin international_A = mkA "internazionale" ; -- status=guess
lin particularly_Adv = variants{} ; -- 
lin department_N = mkN "grande magazzino" | mkN "emporio" ; -- status=guess status=guess
lin management_N = mkN "amministrazione" feminine | mkN "direzione" feminine | mkN "gestione" feminine ; -- status=guess status=guess status=guess
lin morning_N = mkN "mattina" | mkN "mattino" ; -- status=guess status=guess
lin draw_V2 = mkV2 (trarre_V) ; -- status=guess, src=wikt
lin draw_1_V2 = variants{} ; -- 
lin draw_2_V2 = variants{} ; -- 
lin draw_V = trarre_V ; -- status=guess, src=wikt
lin hope_VV = mkVV (mkV "sperare") ; -- status=guess, src=wikt
lin hope_VS = L.hope_VS ;
lin hope_V = mkV "sperare" ; -- status=guess, src=wikt
lin across_Prep = variants{} ; -- 
lin plan_N = mkN "piano" ; -- status=guess
lin product_N = mkN "prodotto" ; -- status=guess
lin city_N = L.city_N ;
lin early_Adv = mkAdv "presto" ; -- status=guess
lin committee_N = mkN "comitato" ; -- status=guess
lin ground_N = mkN "edera terrestre" ; -- status=guess
lin ground_2_N = variants{} ; -- 
lin ground_1_N = variants{} ; -- 
lin letter_N = variants{} ; -- 
lin letter_2_N = variants{} ; -- 
lin letter_1_N = variants{} ; -- 
lin create_V2 = mkV2 (mkV "creare") ; -- status=guess, src=wikt
lin create_V = mkV "creare" ; -- status=guess, src=wikt
lin evidence_N = variants{} ; -- 
lin evidence_2_N = variants{} ; -- 
lin evidence_1_N = variants{} ; -- 
lin foot_N = L.foot_N ;
lin clear_A = mkA "chiaro" ; -- status=guess
lin boy_N = L.boy_N ;
lin game_N = mkN "carniere" ; -- status=guess
lin game_3_N = variants{} ; -- 
lin game_2_N = variants{} ; -- 
lin game_1_N = variants{} ; -- 
lin food_N = mkN "additivo alimentare" ; -- status=guess
lin role_N = mkN "ruolo" ; -- status=guess
lin role_2_N = variants{} ; -- 
lin role_1_N = variants{} ; -- 
lin practice_N = mkN "pratica" ; -- status=guess
lin bank_N = L.bank_N ;
lin else_Adv = mkAdv "altrimenti" ; -- status=guess
lin support_N = mkN "supporto" ; -- status=guess
lin sell_V2 = mkV2 (mkV "vendere") ; -- status=guess, src=wikt
lin sell_V = mkV "vendere" ; -- status=guess, src=wikt
lin event_N = mkN "evento" ; -- status=guess
lin building_N = mkN "costruzione" feminine | mkN "edificazione" feminine ; -- status=guess status=guess
lin range_N = mkN "poligono di tiro" ; -- status=guess
lin behind_Prep = S.behind_Prep ;
lin sure_A = mkA "sicuro" | mkA "sicura" | mkA "certo" | mkA "certa" ; -- status=guess status=guess status=guess status=guess
lin report_VS = mkVS (mkV "riferire") ; -- status=guess, src=wikt
lin report_V2 = mkV2 (mkV "riferire") ; -- status=guess, src=wikt
lin report_V = mkV "riferire" ; -- status=guess, src=wikt
lin pass_V = mkV "passare" ; -- status=guess, src=wikt
lin black_A = L.black_A ;
lin stage_N = mkN "didascalia" ; -- status=guess
lin meeting_N = mkN "riunione" feminine ; -- status=guess
lin meeting_N = mkN "riunione" feminine ; -- status=guess
lin sometimes_Adv = mkAdv "qualche volta" | mkAdv "talvolta" | mkAdv "a volte" ; -- status=guess status=guess status=guess
lin thus_Adv = mkAdv "quindi" | mkAdv "perciò" | mkAdv "dunque" ; -- status=guess status=guess status=guess
lin accept_VS = mkVS (mkV "accettare") | mkVS (ammettere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin accept_V2 = mkV2 (mkV "accettare") | mkV2 (ammettere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin accept_V = mkV "accettare" | ammettere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin town_N = mkN "città" feminine ; -- status=guess
lin art_N = L.art_N ;
lin further_Adv = mkAdv "ulteriormente" ; -- status=guess
lin club_N = mkN "club" | mkN "circolo" ; -- status=guess status=guess
lin club_2_N = variants{} ; -- 
lin club_1_N = variants{} ; -- 
lin cause_V2V = mkV2V (mkV "provocare") ; -- status=guess, src=wikt
lin cause_V2 = mkV2 (mkV "provocare") ; -- status=guess, src=wikt
lin arm_N = mkN "ramo" ; -- status=guess
lin arm_1_N = variants{} ; -- 
lin arm_2_N = variants{} ; -- 
lin history_N = mkN "storia" ; -- status=guess
lin parent_N = mkN "genitore" | mkN "genitrice" feminine ; -- status=guess status=guess
lin land_N = mkN "terra" masculine ; -- status=guess
lin trade_N = mkN "commercio" ; -- status=guess
lin watch_VS = mkVS (mkV "attento!") ; -- status=guess, src=wikt
lin watch_V2V = mkV2V (mkV "attento!") ; -- status=guess, src=wikt
lin watch_V2 = L.watch_V2 ;
lin watch_1_V2 = variants{} ; -- 
lin watch_2_V2 = variants{} ; -- 
lin watch_V = mkV "attento!" ; -- status=guess, src=wikt
lin white_A = L.white_A ;
lin situation_N = mkN "situazione" feminine ; -- status=guess
lin ago_Adv = mkAdv "fa" ; -- status=guess
lin teacher_N = L.teacher_N ;
lin record_N = mkN "primato" ; -- status=guess
lin record_3_N = variants{} ; -- 
lin record_2_N = variants{} ; -- 
lin record_1_N = variants{} ; -- 
lin manager_N = mkN "direttore" masculine ; -- status=guess
lin relation_N = mkN "relazione" feminine ; -- status=guess
lin common_A = mkA "comune" ; -- status=guess
lin common_2_A = variants{} ; -- 
lin common_1_A = variants{} ; -- 
lin strong_A = mkA "forte" ; -- status=guess
lin whole_A = mkA "intero" ; -- status=guess
lin field_N = mkN "campo" ; -- status=guess
lin field_4_N = variants{} ; -- 
lin field_3_N = variants{} ; -- 
lin field_2_N = variants{} ; -- 
lin field_1_N = variants{} ; -- 
lin free_A = mkA "libero" ; -- status=guess
lin break_V2 = L.break_V2 ;
lin break_V = mkV (mkV "infrangere") "la legge" ; -- status=guess, src=wikt
lin yesterday_Adv = mkAdv "ieri" ; -- status=guess
lin support_V2 = mkV2 (mkV "supportare") ; -- status=guess, src=wikt
lin window_N = L.window_N ;
lin account_N = mkN "contabilità" feminine ; -- status=guess
lin explain_VS = mkVS (mkV "spiegare") ; -- status=guess, src=wikt
lin explain_V2 = mkV2 (mkV "spiegare") ; -- status=guess, src=wikt
lin stay_VA = mkVA (mkV "restare") ; -- status=guess, src=wikt
lin stay_V = mkV "restare" ; -- status=guess, src=wikt
lin few_Det = S.few_Det ;
lin wait_VV = mkVV (mkV "aspettare") | mkVV (mkV "attendere") ; -- status=guess, src=wikt status=guess, src=wikt
lin wait_V2 = L.wait_V2 ;
lin wait_V = mkV "aspettare" | mkV "attendere" ; -- status=guess, src=wikt status=guess, src=wikt
lin usually_Adv = variants{} ; -- 
lin difference_N = mkN "differenza" ; -- status=guess
lin material_N = mkN "materiale" ; -- status=guess
lin air_N = mkN "aeroambulanza" ; -- status=guess
lin wife_N = L.wife_N ;
lin cover_V2 = mkV2 (mkV "coprire") ; -- status=guess, src=wikt
lin apply_VV = mkVV (mkV "applicare") ; -- status=guess, src=wikt
lin apply_V2V = mkV2V (mkV "applicare") ; -- status=guess, src=wikt
lin apply_V2 = mkV2 (mkV "applicare") ; -- status=guess, src=wikt
lin apply_1_V2 = variants{} ; -- 
lin apply_2_V2 = variants{} ; -- 
lin apply_V = mkV "applicare" ; -- status=guess, src=wikt
lin project_N = mkN "progetto" | mkN "studio" | mkN "ricerca" ; -- status=guess status=guess status=guess
lin raise_V2 = mkV2 (mkV "alzare") ; -- status=guess, src=wikt
lin sale_N = mkN "vendita" ; -- status=guess
lin relationship_N = mkN "rapporto" ; -- status=guess
lin indeed_Adv = mkAdv "infatti" ; -- status=guess
lin light_N = mkN "lampadina" ; -- status=guess
lin claim_VS = mkVS (mkV "reclamare") | mkVS (mkV "rivendicare") ; -- status=guess, src=wikt status=guess, src=wikt
lin claim_V2 = mkV2 (mkV "reclamare") | mkV2 (mkV "rivendicare") ; -- status=guess, src=wikt status=guess, src=wikt
lin claim_V = mkV "reclamare" | mkV "rivendicare" ; -- status=guess, src=wikt status=guess, src=wikt
lin form_V2 = mkV2 (mkV "formare") ; -- status=guess, src=wikt
lin form_V = mkV "formare" ; -- status=guess, src=wikt
lin base_V2 = variants{} ; -- 
lin base_V = variants{} ; -- 
lin care_N = mkN "cura" | mkN "attenzione" feminine ; -- status=guess status=guess
lin someone_NP = variants{} ; -- 
lin everything_NP = S.everything_NP ;
lin certainly_Adv = variants{} ; -- 
lin rule_N = L.rule_N ;
lin home_Adv = mkAdv "a casa" ; -- status=guess
lin cut_V2 = L.cut_V2 ;
lin cut_V = mkV "alzare" ; -- status=guess, src=wikt
lin grow_VA = mkVA (mkV "diventare") | mkVA (mkV "apparire") ; -- status=guess, src=wikt status=guess, src=wikt
lin grow_V2 = mkV2 (mkV "diventare") | mkV2 (mkV "apparire") ; -- status=guess, src=wikt status=guess, src=wikt
lin grow_V = mkV "diventare" | mkV "apparire" ; -- status=guess, src=wikt status=guess, src=wikt
lin similar_A = mkA "simile" ; -- status=guess
lin story_N = mkN "racconto" | mkN "storia" ; -- status=guess status=guess
lin quality_N = mkN "qualità" feminine ; -- status=guess
lin tax_N = mkN "tassa" | mkN "imposta" ; -- status=guess status=guess
lin worker_N = mkN "lavoratore" | mkN "operaio" ; -- status=guess status=guess
lin nature_N = mkN "natura" ; -- status=guess
lin structure_N = mkN "struttura" ; -- status=guess
lin data_N = mkN "dato" ; -- status=guess
lin necessary_A = mkA "necessario" ; -- status=guess
lin pound_N = mkN "botta" | mkN "colpo forte" | mkN "tonfo" | mkN "martellio" ; -- status=guess status=guess status=guess status=guess
lin method_N = mkN "metodo" ; -- status=guess
lin unit_N = variants{} ; -- 
lin unit_6_N = variants{} ; -- 
lin unit_5_N = variants{} ; -- 
lin unit_4_N = variants{} ; -- 
lin unit_3_N = variants{} ; -- 
lin unit_2_N = variants{} ; -- 
lin unit_1_N = variants{} ; -- 
lin central_A = mkA "centrale" ; -- status=guess
lin bed_N = mkN "letto" feminine | mkN "giaciglio" ; -- status=guess status=guess
lin union_N = mkN "unione" feminine ; -- status=guess
lin movement_N = mkN "movimento" ; -- status=guess
lin board_N = mkN "vitto e alloggio" ; -- status=guess
lin board_2_N = variants{} ; -- 
lin board_1_N = variants{} ; -- 
lin true_A = mkA "vero" ; -- status=guess
lin well_Interj = mkInterj "bè" | mkInterj "beh" ; -- status=guess status=guess
lin simply_Adv = variants{} ; -- 
lin contain_V2 = mkV2 (contenere_V) ; -- status=guess, src=wikt
lin especially_Adv = variants{} ; -- 
lin open_A = mkA "a cielo aperto" ; -- status=guess
lin short_A = L.short_A ;
lin personal_A = mkA "personale" ; -- status=guess
lin detail_N = mkN "minuzia" ; -- status=guess
lin model_N = mkN "modello" | mkN "modellino" ; -- status=guess status=guess
lin bear_V2 = mkV2 (mkV "portare") ; -- status=guess, src=wikt
lin bear_V = mkV "portare" ; -- status=guess, src=wikt
lin single_A = mkA "in solitaria" ; -- status=guess
lin single_2_A = variants{} ; -- 
lin single_1_A = variants{} ; -- 
lin join_V2 = mkV2 (mkV "aderire") | mkV2 (mkV (mkV "entrare") "a far parte") ; -- status=guess, src=wikt status=guess, src=wikt
lin join_V = mkV "aderire" | mkV (mkV "entrare") "a far parte" ; -- status=guess, src=wikt status=guess, src=wikt
lin reduce_V2 = mkV2 (ridurre_V) ; -- status=guess, src=wikt
lin reduce_V = ridurre_V ; -- status=guess, src=wikt
lin establish_V2 = mkV2 (mkV "stabilire") ; -- status=guess, src=wikt
lin wall_N = mkN "parete" feminine ; -- status=guess
lin face_V2 = mkV2 (mkV "fronteggiare") | mkV2 (mkV (porre_V) "mano") | mkV2 (mkV "sistemare") | mkV2 (mkV "confrontarsi") | mkV2 (risolvere_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin face_V = mkV "fronteggiare" | mkV (porre_V) "mano" | mkV "sistemare" | mkV "confrontarsi" | risolvere_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin easy_A = mkA "facile" ; -- status=guess
lin private_A = mkA "personale" | mkA "riservato" ; -- status=guess status=guess
lin computer_N = L.computer_N ;
lin hospital_N = mkN "ospedale" masculine ; -- status=guess
lin chapter_N = mkN "capitolo" ; -- status=guess
lin scheme_N = mkN "schema" masculine | mkN "piano" | mkN "progetto" | mkN "programma" masculine ; -- status=guess status=guess status=guess status=guess
lin theory_N = mkN "teoria" ; -- status=guess
lin choose_VV = mkVV (mkV "decidere") ; -- status=guess, src=wikt
lin choose_V2 = mkV2 (mkV "decidere") ; -- status=guess, src=wikt
lin wish_VV = mkVV (mkV "augurare") ; -- status=guess, src=wikt
lin wish_VS = mkVS (mkV "augurare") ; -- status=guess, src=wikt
lin wish_V2V = mkV2V (mkV "augurare") ; -- status=guess, src=wikt
lin wish_V2 = mkV2 (mkV "augurare") ; -- status=guess, src=wikt
lin wish_V = mkV "augurare" ; -- status=guess, src=wikt
lin property_N = mkN "proprietà" feminine | mkN "qualità" feminine ; -- status=guess status=guess
lin property_2_N = variants{} ; -- 
lin property_1_N = variants{} ; -- 
lin achieve_V2 = mkV2 (mkV "realizzare") ; -- status=guess, src=wikt
lin financial_A = variants{} ; -- 
lin poor_A = mkA "misero" ; -- status=guess
lin poor_3_A = variants{} ; -- 
lin poor_2_A = variants{} ; -- 
lin poor_1_A = variants{} ; -- 
lin officer_N = mkN "funzionario" ; -- status=guess
lin officer_3_N = variants{} ; -- 
lin officer_2_N = variants{} ; -- 
lin officer_1_N = variants{} ; -- 
lin up_Prep = variants{} ; -- 
lin charge_N = mkN "accusa" | mkN "imputazione" feminine ; -- status=guess status=guess
lin charge_2_N = variants{} ; -- 
lin charge_1_N = variants{} ; -- 
lin director_N = variants{} ; -- 
lin drive_V2V = mkV2V (mkV "rendere") ; -- status=guess, src=wikt
lin drive_V2 = mkV2 (mkV "rendere") ; -- status=guess, src=wikt
lin drive_V = mkV "rendere" ; -- status=guess, src=wikt
lin deal_V2 = variants{} ; -- 
lin deal_V = variants{} ; -- 
lin place_V2 = mkV2 (mkV "collocare") | mkV2 (mettere_V) | mkV2 (mkV "posare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin approach_N = variants{} ; -- 
lin chance_N = mkN "possibilità" feminine | mkN "opportunità" feminine | mkN "chance" feminine ; -- status=guess status=guess status=guess
lin application_N = variants{} ; -- 
lin seek_VV = mkVV (mkV "cercare") ; -- status=guess, src=wikt
lin seek_V2 = L.seek_V2 ;
lin foreign_A = mkA "straniero" | mkA "straniera" ; -- status=guess status=guess
lin foreign_2_A = variants{} ; -- 
lin foreign_1_A = variants{} ; -- 
lin along_Prep = variants{} ; -- 
lin top_N = mkN "trottola" ; -- status=guess
lin amount_N = mkN "quantità" feminine ; -- status=guess
lin son_N = mkN "figlio" ; -- status=guess
lin operation_N = mkN "operazione" feminine ; -- status=guess
lin fail_VV = mkVV (mkV "bocciare") | mkVV (mkV "fallire") ; -- status=guess, src=wikt status=guess, src=wikt
lin fail_V2 = mkV2 (mkV "bocciare") | mkV2 (mkV "fallire") ; -- status=guess, src=wikt status=guess, src=wikt
lin fail_V = mkV "bocciare" | mkV "fallire" ; -- status=guess, src=wikt status=guess, src=wikt
lin human_A = mkA "umano" ; -- status=guess
lin opportunity_N = mkN "occasione" feminine ; -- status=guess
lin simple_A = mkA "semplice" ; -- status=guess
lin leader_N = mkN "capo" | mkN "duce" masculine ; -- status=guess status=guess
lin look_N = mkN "occhiata" ; -- status=guess
lin share_N = mkN "parte" feminine ; -- status=guess
lin production_N = mkN "produzione" feminine ; -- status=guess
lin recent_A = mkA "recente" ; -- status=guess
lin firm_N = variants{} ; -- 
lin picture_N = mkN "libro illustrato" ; -- status=guess
lin source_N = mkN "fonte" feminine ; -- status=guess
lin security_N = mkN "sicurezza" ; -- status=guess
lin serve_V2 = mkV2 (mkV (mkV "ti") "sta bene!") ; -- status=guess, src=wikt
lin serve_V = mkV (mkV "ti") "sta bene!" ; -- status=guess, src=wikt
lin according_to_Prep = variants{} ; -- 
lin end_V2 = mkV2 (mkV "finire") ; -- status=guess, src=wikt
lin end_V = mkV "finire" ; -- status=guess, src=wikt
lin contract_N = mkN "contratto" ; -- status=guess
lin wide_A = L.wide_A ;
lin occur_V = variants{} ; -- 
lin agreement_N = mkN "consenso" | mkN "accordo" ; -- status=guess status=guess
lin better_Adv = mkAdv "meglio" ; -- status=guess
lin kill_V2 = L.kill_V2 ;
lin kill_V = mkV "uccidere" | mkV "ammazzare" ; -- status=guess, src=wikt status=guess, src=wikt
lin act_V2 = mkV2 (I.fare_V) | mkV2 (mkV "comportarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin act_V = I.fare_V | mkV "comportarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin site_N = mkN "posto" | mkN "circostanza" ; -- status=guess status=guess
lin either_Adv = mkAdv "neanche" | mkAdv "nemmeno" | mkAdv "neppure" ; -- status=guess status=guess status=guess
lin labour_N = mkN "manodopera" ; -- status=guess
lin plan_VV = mkVV (mkV "progettare") | mkVV (mkV "pianificare") | mkVV (mkV "architettare") | mkVV (mkV "inventare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plan_VS = mkVS (mkV "progettare") | mkVS (mkV "pianificare") | mkVS (mkV "architettare") | mkVS (mkV "inventare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plan_V2V = mkV2V (mkV "progettare") | mkV2V (mkV "pianificare") | mkV2V (mkV "architettare") | mkV2V (mkV "inventare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plan_V2 = mkV2 (mkV "progettare") | mkV2 (mkV "pianificare") | mkV2 (mkV "architettare") | mkV2 (mkV "inventare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plan_V = mkV "progettare" | mkV "pianificare" | mkV "architettare" | mkV "inventare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin various_A = mkA "vario" ; -- status=guess
lin since_Prep = variants{} ; -- 
lin test_N = mkN "esame" masculine ; -- status=guess
lin eat_V2 = L.eat_V2 ;
lin eat_V = mkV "mangiare" ; -- status=guess, src=wikt
lin loss_N = variants{} ; -- 
lin close_V2 = L.close_V2 ;
lin close_V = chiudere_V ; -- status=guess, src=wikt
lin represent_V2 = mkV2 (mkV "rappresentare") ; -- status=guess, src=wikt
lin represent_V = mkV "rappresentare" ; -- status=guess, src=wikt
lin love_VV = mkVV (mkV (mkV "voler") "bene") | mkVV (mkV "amare") ; -- status=guess, src=wikt status=guess, src=wikt
lin love_V2 = L.love_V2 ;
lin colour_N = mkN "televisore a colori" ; -- status=guess
lin clearly_Adv = variants{} ; -- 
lin shop_N = L.shop_N ;
lin benefit_N = mkN "beneficio" ; -- status=guess
lin animal_N = L.animal_N ;
lin heart_N = L.heart_N ;
lin election_N = mkN "elezione" feminine ; -- status=guess
lin purpose_N = mkN "intenzione" feminine ; -- status=guess
lin standard_N = mkN "stendardo" | mkN "bandiera" | mkN "insegna" ; -- status=guess status=guess status=guess
lin due_A = variants{} ; -- 
lin secretary_N = mkN "segretario" ; -- status=guess
lin rise_V2 = mkV2 (salire_V) ; -- status=guess, src=wikt
lin rise_V = salire_V ; -- status=guess, src=wikt
lin date_N = variants{} ; -- 
lin date_7_N = variants{} ; -- 
lin date_3_N = variants{} ; -- 
lin date_3_N = variants{} ; -- 
lin date_1_N = variants{} ; -- 
lin hard_A = mkA "sodo" | mkA "sode" ; -- status=guess status=guess
lin hard_2_A = variants{} ; -- 
lin hard_1_A = variants{} ; -- 
lin music_N = L.music_N ;
lin hair_N = L.hair_N ;
lin prepare_VV = mkVV (mkV "prepararsi") ; -- status=guess, src=wikt
lin prepare_V2V = mkV2V (mkV "prepararsi") ; -- status=guess, src=wikt
lin prepare_V2 = mkV2 (mkV "prepararsi") ; -- status=guess, src=wikt
lin prepare_V = mkV "prepararsi" ; -- status=guess, src=wikt
lin factor_N = mkN "fattore" masculine ; -- status=guess
lin other_A = mkA "altro" ;
lin anyone_NP = variants{} ; -- 
lin pattern_N = mkN "modello" ; -- status=guess
lin manage_VV = mkVV (dirigere_V) ; -- status=guess, src=wikt
lin manage_V2 = mkV2 (dirigere_V) ; -- status=guess, src=wikt
lin manage_V = dirigere_V ; -- status=guess, src=wikt
lin piece_N = mkN "brano" ; -- status=guess
lin discuss_VS = mkVS (mkV "dibattere") ; -- status=guess, src=wikt
lin discuss_V2 = mkV2 (mkV "dibattere") ; -- status=guess, src=wikt
lin prove_VS = mkVS (mkV "provare") | mkVS (mkV "dimostrare") | mkVS (mkV "dimostrarsi") | mkVS (mkV "rivelarsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prove_VA = mkVA (mkV "provare") | mkVA (mkV "dimostrare") | mkVA (mkV "dimostrarsi") | mkVA (mkV "rivelarsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prove_V2 = mkV2 (mkV "provare") | mkV2 (mkV "dimostrare") | mkV2 (mkV "dimostrarsi") | mkV2 (mkV "rivelarsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prove_V = mkV "provare" | mkV "dimostrare" | mkV "dimostrarsi" | mkV "rivelarsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin front_N = mkN "copertina" | mkN "copertine" ; -- status=guess status=guess
lin evening_N = mkN "sera" ; -- status=guess
lin royal_A = mkA "reale" ; -- status=guess
lin tree_N = L.tree_N ;
lin population_N = mkN "popolazione" feminine ; -- status=guess
lin fine_A = mkA "bene" ; -- status=guess
lin plant_N = mkN "pianta" ; -- status=guess
lin pressure_N = mkN "pressione" feminine ; -- status=guess
lin response_N = mkN "responso" ; -- status=guess
lin catch_V2 = mkV2 (mkV "agguantare") ; -- status=guess, src=wikt
lin street_N = mkN "strada" | mkN "via" ; -- status=guess status=guess
lin pick_V2 = mkV2 (mkV "aversela") ; -- status=guess, src=wikt
lin pick_V = mkV "aversela" ; -- status=guess, src=wikt
lin performance_N = mkN "prestazione" feminine | mkN "esibizione" feminine ; -- status=guess status=guess
lin performance_2_N = variants{} ; -- 
lin performance_1_N = variants{} ; -- 
lin knowledge_N = mkN "conoscenza" masculine ; -- status=guess
lin despite_Prep = variants{} ; -- 
lin design_N = mkN "design" masculine ; -- status=guess
lin page_N = mkN "pagina" ; -- status=guess
lin enjoy_VV = mkVV (mkV "divertirsi") ; -- status=guess, src=wikt
lin enjoy_V2 = mkV2 (mkV "divertirsi") ; -- status=guess, src=wikt
lin individual_N = mkN "individuo" ; -- status=guess
lin suppose_VS = mkVS (supporre_V) | mkVS (mkV "immaginare") ; -- status=guess, src=wikt status=guess, src=wikt
lin suppose_V2 = mkV2 (supporre_V) | mkV2 (mkV "immaginare") ; -- status=guess, src=wikt status=guess, src=wikt
lin rest_N = mkN "massa a riposo" | mkN "massa invariante" | mkN "massa intrinseca" ; -- status=guess status=guess status=guess
lin instead_Adv = mkAdv "in luogo di" | mkAdv "invece" ; -- status=guess status=guess
lin wear_V2 = mkV2 (mkV "indossare") | mkV2 (mkV "portare") ; -- status=guess, src=wikt status=guess, src=wikt
lin wear_V = mkV "indossare" | mkV "portare" ; -- status=guess, src=wikt status=guess, src=wikt
lin basis_N = mkN "base" feminine ; -- status=guess
lin size_N = mkN "taglia" ; -- status=guess
lin environment_N = mkN "ambiente" masculine ; -- status=guess
lin per_Prep = variants{} ; -- 
lin fire_N = L.fire_N ;
lin fire_2_N = variants{} ; -- 
lin fire_1_N = variants{} ; -- 
lin series_N = mkN "serie" feminine ; -- status=guess
lin success_N = mkN "successo" ; -- status=guess
lin natural_A = mkA "naturale" ; -- status=guess
lin wrong_A = mkA "sbagliato" | mkA "errato" | mkA "erroneo" | mkA "scorretto" ; -- status=guess status=guess status=guess status=guess
lin near_Prep = variants{} ; -- 
lin round_Adv = variants{} ; -- 
lin thought_N = mkN "esperimento mentale" ; -- status=guess
lin list_N = mkN "lista" ; -- status=guess
lin argue_VS = mkVS (discutere_V) | mkVS (mkV "dibattere") ; -- status=guess, src=wikt status=guess, src=wikt
lin argue_V2 = mkV2 (discutere_V) | mkV2 (mkV "dibattere") ; -- status=guess, src=wikt status=guess, src=wikt
lin argue_V = discutere_V | mkV "dibattere" ; -- status=guess, src=wikt status=guess, src=wikt
lin final_A = mkA "ultimo" ; -- status=guess
lin future_N = variants{} ; -- 
lin future_3_N = variants{} ; -- 
lin future_1_N = variants{} ; -- 
lin introduce_V2 = variants{} ; -- 
lin analysis_N = mkN "analisi" feminine ; -- status=guess
lin enter_V2 = mkV2 (mkV "entrare") ; -- status=guess, src=wikt
lin enter_V = mkV "entrare" ; -- status=guess, src=wikt
lin space_N = mkN "spazio" ; -- status=guess
lin arrive_V = mkV "arrivare" ; -- status=guess, src=wikt
lin ensure_VS = mkVS (mkV "garantire") ; -- status=guess, src=wikt
lin ensure_V2 = mkV2 (mkV "garantire") ; -- status=guess, src=wikt
lin ensure_V = mkV "garantire" ; -- status=guess, src=wikt
lin demand_N = variants{} ; -- 
lin statement_N = mkN "dichiarazione" feminine ; -- status=guess
lin to_Adv = mkAdv "cioè" ; -- status=guess
lin attention_N = mkN "attenzione" feminine ; -- status=guess
lin love_N = L.love_N ;
lin principle_N = mkN "principio" ; -- status=guess
lin pull_V2 = L.pull_V2 ;
lin pull_V = mkV "tirare" ; -- status=guess, src=wikt
lin set_N = mkN "frase fatta" ; -- status=guess
lin set_2_N = variants{} ; -- 
lin set_1_N = variants{} ; -- 
lin doctor_N = L.doctor_N ;
lin choice_N = mkN "ottimo" | mkN "ottima" ; -- status=guess status=guess
lin refer_V2 = mkV2 (mkV "riferire") ; -- status=guess, src=wikt
lin refer_V = mkV "riferire" ; -- status=guess, src=wikt
lin feature_N = mkN "caratteristica" masculine ; -- status=guess
lin couple_N = mkN "paio" ; -- status=guess
lin step_N = mkN "scaletta" | mkN "scaleo" ; -- status=guess status=guess
lin following_A = variants{} ; -- 
lin thank_V2 = mkV2 (mkV "ringraziare") ; -- status=guess, src=wikt
lin machine_N = mkN "macchina" ; -- status=guess
lin income_N = mkN "introiti" ;
lin training_N = mkN "addestramento" ; -- status=guess
lin present_V2 = mkV2 (mkV "presentare") ; -- status=guess, src=wikt
lin association_N = mkN "associazione" feminine ; -- status=guess
lin film_N = mkN "film" | mkN "pellicola" ; -- status=guess status=guess
lin film_2_N = variants{} ; -- 
lin film_1_N = variants{} ; -- 
lin region_N = mkN "regione" feminine ; -- status=guess
lin effort_N = mkN "sforzo" ; -- status=guess
lin player_N = mkN "lettore" masculine ; -- status=guess
lin everyone_NP = variants{} ; -- 
lin present_A = mkA "presente" ; -- status=guess
lin award_N = mkN "sentenza" ; -- status=guess
lin village_N = L.village_N ;
lin control_V2 = mkV2 (mkV "controllare") | mkV2 (mkV "influenzare") ; -- status=guess, src=wikt status=guess, src=wikt
lin organisation_N = variants{} ; -- 
lin whatever_Det = variants{} ; -- 
lin news_N = mkN "novità" feminine | mkN "notizie" feminine ; -- status=guess status=guess
lin nice_A = mkA "bello" | mkA "bella" ; -- status=guess status=guess
lin difficulty_N = mkN "difficoltà" feminine ; -- status=guess
lin modern_A = mkA "moderno" ; -- status=guess
lin cell_N = mkN "cellula" ; -- status=guess
lin close_A = mkA "vicino" | mkA "vicina" ; -- status=guess status=guess
lin current_A = mkA "corrente" | mkA "attuale" ; -- status=guess status=guess
lin legal_A = mkA "legale" ; -- status=guess
lin energy_N = mkN "energia" | mkN "forza" ; -- status=guess status=guess
lin finally_Adv = variants{} ; -- 
lin degree_N = variants{} ; -- 
lin degree_3_N = variants{} ; -- 
lin degree_2_N = variants{} ; -- 
lin degree_1_N = variants{} ; -- 
lin mile_N = mkN "miglio" ; -- status=guess
lin means_N = variants{} ; -- 
lin growth_N = mkN "crescita" ; -- status=guess
lin treatment_N = variants{} ; -- 
lin sound_N = mkN "barriera del suono" | mkN "muro del suono" ; -- status=guess status=guess
lin above_Prep = S.above_Prep ;
lin task_N = mkN "incombenza" ; -- status=guess
lin provision_N = variants{} ; -- 
lin affect_V2 = mkV2 (mkV "fingere") ; -- status=guess, src=wikt
lin please_Adv = mkAdv "per favore" ;
lin red_A = L.red_A ;
lin happy_A = mkA "contento" ; -- status=guess
lin behaviour_N = mkN "comportamento" | mkN "condotta" ; -- status=guess status=guess
lin concerned_A = variants{} ; -- 
lin point_V2 = variants{} ; -- 
lin point_V = variants{} ; -- 
lin function_N = mkN "funzione" feminine ; -- status=guess
lin identify_V2 = variants{} ; -- 
lin identify_V = variants{} ; -- 
lin resource_N = mkN "risorsa" ; -- status=guess
lin defence_N = mkN "difesa" ; -- status=guess
lin garden_N = L.garden_N ;
lin floor_N = L.floor_N ;
lin technology_N = mkN "tecnologia" ; -- status=guess
lin style_N = mkN "stile" masculine ; -- status=guess
lin feeling_N = mkN "sentimento" | mkN "emozione" feminine ; -- status=guess status=guess
lin science_N = L.science_N ;
lin relate_V2 = variants{} ; -- 
lin relate_V = variants{} ; -- 
lin doubt_N = mkN "dubbio" ; -- status=guess
lin horse_N = L.horse_N ;
lin force_VS = mkVS (mkV "forzare") ; -- status=guess, src=wikt
lin force_V2V = mkV2V (mkV "forzare") ; -- status=guess, src=wikt
lin force_V2 = mkV2 (mkV "forzare") ; -- status=guess, src=wikt
lin force_V = mkV "forzare" ; -- status=guess, src=wikt
lin answer_N = mkN "risposta" ; -- status=guess
lin compare_V = mkV "paragonare" ; -- status=guess, src=wikt
lin suffer_V2 = mkV2 (mkV "subire") ; -- status=guess, src=wikt
lin suffer_V = mkV "subire" ; -- status=guess, src=wikt
lin individual_A = variants{} ; -- 
lin forward_Adv = mkAdv "avanti" ; -- status=guess
lin announce_VS = variants{} ; -- 
lin announce_V2 = variants{} ; -- 
lin user_N = variants{} ; -- 
lin fund_N = mkN "fondo" ; -- status=guess
lin character_2_N = variants{} ; -- 
lin character_1_N = variants{} ; -- 
lin risk_N = mkN "rischio" ; -- status=guess
lin normal_A = mkA "normale" ; -- status=guess
lin nor_Conj = variants{} ; -- 
lin dog_N = L.dog_N ;
lin obtain_V2 = mkV2 (mkV "stabilirsi") ; -- status=guess, src=wikt
lin obtain_V = mkV "stabilirsi" ; -- status=guess, src=wikt
lin quickly_Adv = variants{} ; -- 
lin army_N = mkN "esercito" ; -- status=guess
lin indicate_VS = variants{} ; -- 
lin indicate_V2 = variants{} ; -- 
lin forget_VS = mkVS (mkV "dimenticare") ; -- status=guess, src=wikt
lin forget_V2 = L.forget_V2 ;
lin forget_V = mkV "dimenticare" ; -- status=guess, src=wikt
lin station_N = mkN "canale" masculine | mkN "emittente" feminine ; -- status=guess status=guess
lin glass_N = mkN "vetro" ; -- status=guess
lin cup_N = mkN "coppiere" masculine ; -- status=guess
lin previous_A = mkA "previo" ; -- status=guess
lin husband_N = L.husband_N ;
lin recently_Adv = variants{} ; -- 
lin publish_V2 = mkV2 (mkV (mkV "rendere") "noto") | mkV2 (mkV "divulgare") ; -- status=guess, src=wikt status=guess, src=wikt
lin publish_V = mkV (mkV "rendere") "noto" | mkV "divulgare" ; -- status=guess, src=wikt status=guess, src=wikt
lin serious_A = mkA "serio" | mkA "grave" ; -- status=guess status=guess
lin anyway_Adv = mkAdv "comunque" | mkAdv "in ogni modo" ; -- status=guess status=guess
lin visit_V2 = mkV2 (mkV "visitare") ; -- status=guess, src=wikt
lin visit_V = mkV "visitare" ; -- status=guess, src=wikt
lin capital_N = mkN "capitale" ;
lin capital_3_N = variants{} ; -- 
lin capital_2_N = variants{} ; -- 
lin capital_1_N = variants{} ; -- 
lin either_Det = mkDet "ciascuno" ; -- status=guess
lin note_N = mkN "nota" ; -- status=guess
lin note_3_N = variants{} ; -- 
lin note_2_N = variants{} ; -- 
lin note_1_N = variants{} ; -- 
lin season_N = mkN "stagione" feminine ; -- status=guess
lin argument_N = mkN "argomento" ; -- status=guess
lin listen_V = mkV (dare_V) "ascolto" ; -- status=guess, src=wikt
lin show_N = mkN "programma" masculine ; -- status=guess
lin responsibility_N = mkN "responsabilità" feminine ; -- status=guess
lin significant_A = mkA "significativo" | mkA "epocale" | mkA "rimarchevole" ; -- status=guess status=guess status=guess
lin deal_N = mkN "contratto" ; -- status=guess
lin prime_A = mkA "ottimo" | mkA "[meat" | mkA "cuts] di prima scelta" | mkA "[foodstuffs] di prima qualità" | mkA "[livestock] di prima categoria" ; -- status=guess status=guess status=guess status=guess status=guess
lin economy_N = mkN "economia" ; -- status=guess
lin economy_2_N = variants{} ; -- 
lin economy_1_N = variants{} ; -- 
lin element_N = mkN "elemento" ; -- status=guess
lin finish_V2 = mkV2 (mkV "rifinire") ; -- status=guess, src=wikt
lin finish_V = mkV "rifinire" ; -- status=guess, src=wikt
lin duty_N = mkN "tassa" | mkN "dazio" ; -- status=guess status=guess
lin fight_V2 = L.fight_V2 ;
lin fight_V = mkV "lottare" | mkV "azzuffarsi" | mkV "battersi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin train_V2V = mkV2V (mkV "esercitarsi") ; -- status=guess, src=wikt
lin train_V2 = mkV2 (mkV "esercitarsi") ; -- status=guess, src=wikt
lin train_V = mkV "esercitarsi" ; -- status=guess, src=wikt
lin maintain_VS = mkVS (mantenere_V) ; -- status=guess, src=wikt
lin maintain_V2 = mkV2 (mantenere_V) ; -- status=guess, src=wikt
lin maintain_V = mantenere_V ; -- status=guess, src=wikt
lin attempt_N = mkN "attentato" ; -- status=guess
lin leg_N = L.leg_N ;
lin investment_N = mkN "investimento" ; -- status=guess
lin save_V2 = mkV2 (mkV "risparmiare") ; -- status=guess, src=wikt
lin save_V = mkV "risparmiare" ; -- status=guess, src=wikt
lin throughout_Prep = variants{} ; -- 
lin design_V2 = mkV2 (mkV "progettare") ; -- status=guess, src=wikt
lin design_V = mkV "progettare" ; -- status=guess, src=wikt
lin suddenly_Adv = variants{} ; -- 
lin brother_N = mkN "cognato" ; -- status=guess
lin improve_V2 = mkV2 (mkV "migliorare") | mkV2 (mkV (stare_V) "meglio") ; -- status=guess, src=wikt status=guess, src=wikt
lin improve_V = mkV "migliorare" | mkV (stare_V) "meglio" ; -- status=guess, src=wikt status=guess, src=wikt
lin avoid_VV = mkVV (mkV "evitare") ; -- status=guess, src=wikt
lin avoid_V2 = mkV2 (mkV "evitare") ; -- status=guess, src=wikt
lin wonder_VQ = L.wonder_VQ ;
lin wonder_V = mkV "domandarsi" | mkV "chiedersi" ; -- status=guess, src=wikt status=guess, src=wikt
lin tend_VV = mkVV (mkV "tendere") ; -- status=guess, src=wikt
lin tend_V2 = mkV2 (mkV "tendere") ; -- status=guess, src=wikt
lin title_N = mkN "titolo" ; -- status=guess
lin hotel_N = mkN "albergo" | mkN "hotel" masculine ; -- status=guess status=guess
lin aspect_N = mkN "aspetto" ; -- status=guess
lin increase_N = variants{} ; -- 
lin help_N = mkN "aiuto" | mkN "ausilio" ; -- status=guess status=guess
lin industrial_A = variants{} ; -- 
lin express_V2 = mkV2 (esprimere_V) ; -- status=guess, src=wikt
lin summer_N = mkN "estate" masculine ; -- status=guess
lin determine_VV = variants{} ; -- 
lin determine_VS = variants{} ; -- 
lin determine_V2V = variants{} ; -- 
lin determine_V2 = variants{} ; -- 
lin determine_V = variants{} ; -- 
lin generally_Adv = variants{} ; -- 
lin daughter_N = mkN "figlia" ; -- status=guess
lin exist_V = esistere_V ; -- status=guess, src=wikt
lin share_V2 = mkV2 (mkV "condividere") ; -- status=guess, src=wikt
lin share_V = mkV "condividere" ; -- status=guess, src=wikt
lin baby_N = L.baby_N ;
lin nearly_Adv = variants{} ; -- 
lin smile_V = sorridere_V ; -- status=guess, src=wikt
lin sorry_A = mkA "scusa" ; -- status=guess
lin sea_N = L.sea_N ;
lin skill_N = mkN "abilità" feminine | mkN "capacità" feminine ; -- status=guess status=guess
lin claim_N = mkN "reclamo di proprietà" ; -- status=guess
lin treat_V2 = mkV2 (mkV "trattare") ; -- status=guess, src=wikt
lin treat_V = mkV "trattare" ; -- status=guess, src=wikt
lin remove_V2 = mkV2 (rimuovere_V) | mkV2 (mkV "asportare") | mkV2 (mkV "levare") | mkV2 (mkV "togliere") | mkV2 (mkV (mkV "portare") "via") | mkV2 (mkV "estirpare") | mkV2 (mkV "eradicare") | mkV2 (mkV "allontanare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin remove_V = rimuovere_V | mkV "asportare" | mkV "levare" | mkV "togliere" | mkV (mkV "portare") "via" | mkV "estirpare" | mkV "eradicare" | mkV "allontanare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin concern_N = mkN "impresa" ; -- status=guess
lin university_N = L.university_N ;
lin left_A = mkA "sinistro" ; -- status=guess
lin dead_A = mkA "morto" ; -- status=guess
lin discussion_N = mkN "discussione" feminine ; -- status=guess
lin specific_A = mkA "specifico" ; -- status=guess
lin customer_N = variants{} ; -- 
lin box_N = mkN "bosso" ; -- status=guess
lin outside_Prep = variants{} ; -- 
lin state_VS = mkVS (mkV "dichiarare") ; -- status=guess, src=wikt
lin state_V2 = mkV2 (mkV "dichiarare") ; -- status=guess, src=wikt
lin conference_N = variants{} ; -- 
lin whole_N = mkN "tutto" ; -- status=guess
lin total_A = mkA "totale" | mkA "intero" ; -- status=guess status=guess
lin profit_N = mkN "profitto" ; -- status=guess
lin division_N = mkN "divisione" feminine ; -- status=guess
lin division_3_N = variants{} ; -- 
lin division_2_N = variants{} ; -- 
lin division_1_N = variants{} ; -- 
lin throw_V2 = L.throw_V2 ;
lin throw_V = mkV "gettare" | mkV "lanciare" | mkV "tirare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin procedure_N = mkN "procedura" | mkN "iter" | mkN "procedimento" | mkN "metodo" ; -- status=guess status=guess status=guess status=guess
lin fill_V2 = mkV2 (mkV "imbottire") ; -- status=guess, src=wikt
lin fill_V = mkV "imbottire" ; -- status=guess, src=wikt
lin king_N = L.king_N ;
lin assume_VS = mkVS (presupporre_V) | mkVS (ritenere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin assume_V2 = mkV2 (presupporre_V) | mkV2 (ritenere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin image_N = mkN "immagine" feminine ; -- status=guess
lin oil_N = L.oil_N ;
lin obviously_Adv = variants{} ; -- 
lin unless_Subj = variants{} ; -- 
lin appropriate_A = mkA "apposito" ; -- status=guess
lin circumstance_N = mkN "circonlocuzione" feminine ; -- status=guess
lin military_A = mkA "militare" ; -- status=guess
lin proposal_N = mkN "proposta" ; -- status=guess
lin mention_VS = mkVS (mkV "menzionare") ; -- status=guess, src=wikt
lin mention_V2 = mkV2 (mkV "menzionare") ; -- status=guess, src=wikt
lin mention_V = mkV "menzionare" ; -- status=guess, src=wikt
lin client_N = mkN "cliente" masculine ; -- status=guess
lin sector_N = mkN "settore" masculine ; -- status=guess
lin direction_N = variants{} ; -- 
lin admit_VS = mkVS (mkV (mkV "far") "entrare") ; -- status=guess, src=wikt
lin admit_V2 = mkV2 (mkV (mkV "far") "entrare") ; -- status=guess, src=wikt
lin admit_V = mkV (mkV "far") "entrare" ; -- status=guess, src=wikt
lin though_Adv = mkAdv "comunque" | mkAdv "nonostante" | mkAdv "in ogni caso" | mkAdv "ad ogni modo" ; -- status=guess status=guess status=guess status=guess
lin replace_V2 = mkV2 (mkV "sostituire") | mkV2 (mkV "rimpiazzare") | mkV2 (riporre_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin basic_A = mkA "basico" ; -- status=guess
lin hard_Adv = variants{} ; -- 
lin instance_N = variants{} ; -- 
lin sign_N = mkN "simbolo" ; -- status=guess
lin original_A = mkA "originale" ; -- status=guess
lin successful_A = mkA "di successo" | mkA "coronato dal successo" | mkA "riuscito" | mkA "efficace" ; -- status=guess status=guess status=guess status=guess
lin okay_Adv = variants{} ; -- 
lin reflect_V2 = mkV2 (riflettere_V) ; -- status=guess, src=wikt
lin reflect_V = riflettere_V ; -- status=guess, src=wikt
lin aware_A = mkA "all'erta" ; -- status=guess
lin measure_N = mkN "misurazione" feminine | mkN "misura" ; -- status=guess status=guess
lin attitude_N = mkN "atteggiamento" ; -- status=guess
lin disease_N = mkN "malattia" ; -- status=guess
lin exactly_Adv = variants{} ; -- 
lin above_Adv = mkAdv "sopra" ;
lin commission_N = variants{} ; -- 
lin intend_VV = variants{} ; -- 
lin beyond_Prep = variants{} ; -- 
lin seat_N = mkN "sedile" masculine ; -- status=guess
lin president_N = variants{} ; -- 
lin encourage_V2V = mkV2V (mkV "incoraggiare") ; -- status=guess, src=wikt
lin encourage_V2 = mkV2 (mkV "incoraggiare") ; -- status=guess, src=wikt
lin addition_N = mkN "addizione" feminine ; -- status=guess
lin goal_N = mkN "porta" | mkN "rete" feminine ; -- status=guess status=guess
lin round_Prep = variants{} ; -- 
lin miss_V2 = mkV2 (mkV "mancare") ; -- status=guess, src=wikt
lin miss_V = mkV "mancare" ; -- status=guess, src=wikt
lin popular_A = mkA "popolare" ; -- status=guess
lin affair_N = mkN "affare" masculine ; -- status=guess
lin technique_N = mkN "tecnica" ; -- status=guess
lin respect_N = mkN "rispetto" ; -- status=guess
lin drop_V2 = mkV2 (mkV "scaricare") ; -- status=guess, src=wikt
lin drop_V = mkV "scaricare" ; -- status=guess, src=wikt
lin professional_A = mkA "professionale" ; -- status=guess
lin less_Det = variants{} ; -- 
lin once_Subj = variants{} ; -- 
lin item_N = mkN "articolo" | mkN "elemento" ; -- status=guess status=guess
lin fly_V2 = mkV2 (mkV "imbufalire") ; -- status=guess, src=wikt
lin fly_V = L.fly_V ;
lin reveal_VS = mkVS (mkV "rivelare") ; -- status=guess, src=wikt
lin reveal_V2 = mkV2 (mkV "rivelare") ; -- status=guess, src=wikt
lin version_N = mkN "versione" feminine ; -- status=guess
lin maybe_Adv = mkAdv "forse" ;
lin ability_N = mkN "capacità" feminine ; -- status=guess
lin operate_V2 = mkV2 (mkV "operare") | mkV2 (mkV "attivare") ; -- status=guess, src=wikt status=guess, src=wikt
lin operate_V = mkV "operare" | mkV "attivare" ; -- status=guess, src=wikt status=guess, src=wikt
lin good_N = mkN "bene" masculine ; -- status=guess
lin campaign_N = mkN "campagna" ; -- status=guess
lin heavy_A = L.heavy_A ;
lin advice_N = mkN "avviso" ; -- status=guess
lin institution_N = variants{} ; -- 
lin discover_VS = mkVS (mkV "scoprire") | mkVS (mkV "discoprire") ; -- status=guess, src=wikt status=guess, src=wikt
lin discover_V2 = mkV2 (mkV "scoprire") | mkV2 (mkV "discoprire") ; -- status=guess, src=wikt status=guess, src=wikt
lin discover_V = mkV "scoprire" | mkV "discoprire" ; -- status=guess, src=wikt status=guess, src=wikt
lin surface_N = mkN "superficie" feminine ; -- status=guess
lin library_N = mkN "biblioteca" ; -- status=guess
lin pupil_N = mkN "allievo" | mkN "allieva" ; -- status=guess status=guess
lin record_V2 = mkV2 (mkV "registrare") ; -- status=guess, src=wikt
lin refuse_VV = mkVV (mkV "rifiutare") ; -- status=guess, src=wikt
lin refuse_V2 = mkV2 (mkV "rifiutare") ; -- status=guess, src=wikt
lin refuse_V = mkV "rifiutare" ; -- status=guess, src=wikt
lin prevent_V2 = mkV2 (mkV "impedire") | mkV2 (prevenire_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin advantage_N = mkN "vantaggio" ; -- status=guess
lin dark_A = mkA "scuro" | mkA "oscuro" | mkA "fosco" | mkA "tetro" ; -- status=guess status=guess status=guess status=guess
lin teach_V2V = mkV2V (mkV "insegnare") ; -- status=guess, src=wikt
lin teach_V2 = L.teach_V2 ;
lin teach_V = mkV "insegnare" ; -- status=guess, src=wikt
lin memory_N = mkN "memoria" ; -- status=guess
lin culture_N = mkN "cultura" ; -- status=guess
lin blood_N = L.blood_N ;
lin cost_V2 = mkV2 (mkV "costare") ; -- status=guess, src=wikt
lin cost_V = mkV "costare" ; -- status=guess, src=wikt
lin majority_N = mkN "maggiore età" ; -- status=guess
lin answer_V2 = mkV2 (mkV "ribattere") ; -- status=guess, src=wikt
lin answer_V = mkV "ribattere" ; -- status=guess, src=wikt
lin variety_N = mkN "varietà" feminine ; -- status=guess
lin variety_2_N = variants{} ; -- 
lin variety_1_N = variants{} ; -- 
lin press_N = mkN "stampa" ; -- status=guess
lin depend_V = mkV "pendere" ; -- status=guess, src=wikt
lin bill_N = mkN "poster" | mkN "cartello pubblicitario" ; -- status=guess status=guess
lin competition_N = mkN "competizione" feminine | mkN "concorrenza" ; -- status=guess status=guess
lin ready_A = mkA "pronto" | mkA "preparato" ; -- status=guess status=guess
lin general_N = mkN "classifica generale" ; -- status=guess
lin access_N = mkN "accesso" feminine ; -- status=guess
lin hit_V2 = L.hit_V2 ;
lin hit_V = mkV "colpire" | mkV "picchiare" | mkV "battere" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin stone_N = L.stone_N ;
lin useful_A = mkA "utile" ; -- status=guess
lin extent_N = mkN "misura" ; -- status=guess
lin employment_N = mkN "assunzione" feminine ; -- status=guess
lin regard_V2 = variants{} ; -- 
lin regard_V = variants{} ; -- 
lin apart_Adv = variants{} ; -- 
lin present_N = mkN "presente" masculine ; -- status=guess
lin appeal_N = variants{} ; -- 
lin text_N = mkN "testo" ; -- status=guess
lin parliament_N = mkN "parlamento" ; -- status=guess
lin cause_N = mkN "causa" ; -- status=guess
lin terms_N = variants{} ; -- 
lin bar_N = mkN "Ordine Forense" ; -- status=guess
lin bar_2_N = variants{} ; -- 
lin bar_1_N = variants{} ; -- 
lin attack_N = mkN "attacco" ; -- status=guess
lin effective_A = variants{} ; -- 
lin mouth_N = L.mouth_N ;
lin down_Prep = variants{} ; -- 
lin result_V = variants{} ; -- 
lin fish_N = L.fish_N ;
lin future_A = mkA "futuro" ; -- status=guess
lin visit_N = mkN "visita" ; -- status=guess
lin little_Adv = variants{} ; -- 
lin easily_Adv = variants{} ; -- 
lin attempt_VV = mkVV (mkV "tentare") | mkVV (mkV "cercare") | mkVV (mkV "provare") | mkVV (mkV "attentare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin attempt_V2 = mkV2 (mkV "tentare") | mkV2 (mkV "cercare") | mkV2 (mkV "provare") | mkV2 (mkV "attentare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin enable_VS = variants{} ; -- 
lin enable_V2V = variants{} ; -- 
lin enable_V2 = variants{} ; -- 
lin trouble_N = mkN "guaio" feminine ; -- status=guess
lin traditional_A = mkA "tradizionale" ; -- status=guess
lin payment_N = mkN "pagamento" ; -- status=guess
lin best_Adv = variants{} ; -- 
lin post_N = mkN "ufficio postale" | mkN "posta" ; -- status=guess status=guess
lin county_N = mkN "contea" ; -- status=guess
lin lady_N = mkN "signora" | mkN "dama" ; -- status=guess status=guess
lin holiday_N = mkN "giorno festivo" ; -- status=guess
lin realize_VS = mkVS (mkV (mkV "rendersi") "conto") | mkVS (mkV "accorgersi") ; -- status=guess, src=wikt status=guess, src=wikt
lin realize_V2 = mkV2 (mkV (mkV "rendersi") "conto") | mkV2 (mkV "accorgersi") ; -- status=guess, src=wikt status=guess, src=wikt
lin importance_N = mkN "importanza" ; -- status=guess
lin chair_N = L.chair_N ;
lin facility_N = mkN "facilità" feminine ; -- status=guess
lin complete_V2 = mkV2 (mkV "completare") | mkV2 (compiere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin complete_V = mkV "completare" | compiere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin article_N = mkN "articolo" ; -- status=guess
lin object_N = mkN "oggetto" ; -- status=guess
lin context_N = mkN "contesto" ; -- status=guess
lin survey_N = variants{} ; -- 
lin notice_VS = mkVS (mkV "notare") ; -- status=guess, src=wikt
lin notice_V2 = mkV2 (mkV "notare") ; -- status=guess, src=wikt
lin complete_A = mkA "completo" | mkA "completa" ; -- status=guess status=guess
lin turn_N = mkN "turno" ; -- status=guess
lin direct_A = variants{} ; -- 
lin immediately_Adv = variants{} ; -- 
lin collection_N = mkN "raccolta" ; -- status=guess
lin reference_N = variants{} ; -- 
lin card_N = mkN "scheda" | mkN "carta" ; -- status=guess status=guess
lin interesting_A = mkA "interessante" ; -- status=guess
lin considerable_A = variants{} ; -- 
lin television_N = L.television_N ;
lin extend_V2 = variants{} ; -- 
lin extend_V = variants{} ; -- 
lin communication_N = mkN "comunicazione" feminine ; -- status=guess
lin agency_N = variants{} ; -- 
lin physical_A = mkA "fisico" ; -- status=guess
lin except_Conj = variants{} ; -- 
lin check_V2 = mkV2 (mkV "controllare") ; -- status=guess, src=wikt
lin check_V = mkV "controllare" ; -- status=guess, src=wikt
lin sun_N = L.sun_N ;
lin species_N = mkN "specie" feminine ; -- status=guess
lin possibility_N = mkN "possibilità" feminine ; -- status=guess
lin official_N = variants{} ; -- 
lin chairman_N = mkN "presidente" masculine ; -- status=guess
lin speaker_N = mkN "altoparlante" masculine ; -- status=guess
lin second_N = mkN "secondo" ; -- status=guess
lin career_N = mkN "carriera" ; -- status=guess
lin laugh_VS = mkVS (ridere_V) ; -- status=guess, src=wikt
lin laugh_V2 = mkV2 (ridere_V) ; -- status=guess, src=wikt
lin laugh_V = L.laugh_V ;
lin weight_N = mkN "peso" ; -- status=guess
lin sound_VS = mkVS (mkV "suonare") ; -- status=guess, src=wikt
lin sound_VA = mkVA (mkV "suonare") ; -- status=guess, src=wikt
lin sound_V2 = mkV2 (mkV "suonare") ; -- status=guess, src=wikt
lin sound_V = mkV "suonare" ; -- status=guess, src=wikt
lin responsible_A = variants{} ; -- 
lin base_N = mkN "base" feminine ; -- status=guess
lin document_N = mkN "documento" | mkN "carta" ; -- status=guess status=guess
lin solution_N = mkN "soluzione" feminine ; -- status=guess
lin return_N = variants{} ; -- 
lin medical_A = mkA "medico" ; -- status=guess
lin hot_A = L.hot_A ;
lin recognize_VS = mkVS (riconoscere_V) ; -- status=guess, src=wikt
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin talk_N = mkN "conversazione" feminine ; -- status=guess
lin budget_N = mkN "budget" masculine ; -- status=guess
lin river_N = L.river_N ;
lin fit_V2 = mkV2 (mkV "arredare") ; -- status=guess, src=wikt
lin fit_V = mkV "arredare" ; -- status=guess, src=wikt
lin organization_N = mkN "organizzazione" feminine ; -- status=guess
lin existing_A = variants{} ; -- 
lin start_N = mkN "avvio" | mkN "partenza" | mkN "inizio" ; -- status=guess status=guess status=guess
lin push_VS = mkVS (mkV "spingere") ; -- status=guess, src=wikt
lin push_V2V = mkV2V (mkV "spingere") ; -- status=guess, src=wikt
lin push_V2 = L.push_V2 ;
lin push_V = mkV "spingere" ; -- status=guess, src=wikt
lin tomorrow_Adv = mkAdv "domani" ; -- status=guess
lin requirement_N = mkN "requisito" ; -- status=guess
lin cold_A = L.cold_A ;
lin edge_N = mkN "vantaggio" ; -- status=guess
lin opposition_N = mkN "opposizione" feminine ; -- status=guess
lin opinion_N = mkN "opinione" feminine | mkN "concetto" ;
lin drug_N = mkN "droga" | mkN "narcotico" ; -- status=guess status=guess
lin quarter_N = mkN "moneta di venticinque centesimi" ; -- status=guess
lin option_N = mkN "opzione" feminine ; -- status=guess
lin sign_V2 = mkV2 (mkV "firmare") ; -- status=guess, src=wikt
lin sign_V = mkV "firmare" ; -- status=guess, src=wikt
lin worth_Prep = variants{} ; -- 
lin call_N = mkN "richiamo" | mkN "chiamata" | mkN "convocazione" feminine ; -- status=guess status=guess status=guess
lin define_V2 = mkV2 (mkV "definire") | mkV2 (descrivere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin define_V = mkV "definire" | descrivere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin stock_N = mkN "dado" ; -- status=guess
lin influence_N = mkN "influenza" ; -- status=guess
lin occasion_N = mkN "occasione" feminine ; -- status=guess
lin eventually_Adv = variants{} ; -- 
lin software_N = mkN "software" masculine ; -- status=guess
lin highly_Adv = variants{} ; -- 
lin exchange_N = mkN "scambio" | mkN "cambio" ; -- status=guess status=guess
lin lack_N = mkN "mancanza" ; -- status=guess
lin shake_V2 = mkV2 (scuotere_V) ; -- status=guess, src=wikt
lin shake_V = scuotere_V ; -- status=guess, src=wikt
lin study_V2 = mkV2 (mkV "studiare") ; -- status=guess, src=wikt
lin study_V = mkV "studiare" ; -- status=guess, src=wikt
lin concept_N = mkN "concetto" ; -- status=guess
lin blue_A = L.blue_A ;
lin star_N = L.star_N ;
lin radio_N = L.radio_N ;
lin arrangement_N = mkN "arrangiamento" | mkN "sistemazione" feminine ; -- status=guess status=guess
lin examine_V2 = variants{} ; -- 
lin bird_N = L.bird_N ;
lin green_A = L.green_A ;
lin band_N = mkN "cerotto" ; -- status=guess
lin sex_N = mkN "sesso" ; -- status=guess
lin finger_N = mkN "dito" feminine | mkN "dita" ; -- status=guess status=guess
lin past_N = mkN "passato remoto" ; -- status=guess
lin independent_A = mkA "indipendente" ; -- status=guess
lin independent_2_A = variants{} ; -- 
lin independent_1_A = variants{} ; -- 
lin equipment_N = variants{} ; -- 
lin north_N = mkN "nord" | mkN "settentrione" ; -- status=guess status=guess
lin mind_VS = variants{} ; -- 
lin mind_V2 = variants{} ; -- 
lin mind_V = variants{} ; -- 
lin move_N = mkN "passo" ; -- status=guess
lin message_N = mkN "messaggio" ; -- status=guess
lin fear_N = mkN "paura" ; -- status=guess
lin afternoon_N = mkN "pomeriggio" ; -- status=guess
lin drink_V2 = L.drink_V2 ;
lin drink_V = bere_V | mkV (bere_V) "alcolici" ; -- status=guess, src=wikt status=guess, src=wikt
lin fully_Adv = variants{} ; -- 
lin race_N = mkN "razza" ; -- status=guess
lin race_2_N = variants{} ; -- 
lin race_1_N = variants{} ; -- 
lin gain_V2 = mkV2 (mkV "guadagnare") | mkV2 (mkV "acquisire") ; -- status=guess, src=wikt status=guess, src=wikt
lin gain_V = mkV "guadagnare" | mkV "acquisire" ; -- status=guess, src=wikt status=guess, src=wikt
lin strategy_N = mkN "strategia" ; -- status=guess
lin extra_A = mkA "extra" ; -- status=guess
lin scene_N = mkN "scena" ; -- status=guess
lin slightly_Adv = variants{} ; -- 
lin kitchen_N = mkN "cucina" ; -- status=guess
lin speech_N = mkN "discorso" ; -- status=guess
lin arise_V = mkV "sorgere" ; -- status=guess, src=wikt
lin network_N = mkN "rete" feminine | mkN "reti" feminine ; -- status=guess status=guess
lin tea_N = mkN "tè" masculine ; -- status=guess
lin peace_N = L.peace_N ;
lin failure_N = mkN "fallimento" | mkN "insuccesso" | mkN "avaria" ; -- status=guess status=guess status=guess
lin employee_N = mkN "dipendente" ; -- status=guess
lin ahead_Adv = mkAdv "avanti" ; -- status=guess
lin scale_N = mkN "bilancia" ; -- status=guess
lin hardly_Adv = variants{} ; -- 
lin attend_V2 = mkV2 (mkV "partecipare") ; -- status=guess, src=wikt
lin attend_V = mkV "partecipare" ; -- status=guess, src=wikt
lin shoulder_N = mkN "spalla" ; -- status=guess
lin otherwise_Adv = mkAdv "differentemente" ; -- status=guess
lin railway_N = mkN "stazione" feminine | mkN "stazione ferroviaria" ; -- status=guess status=guess
lin directly_Adv = variants{} ; -- 
lin supply_N = mkN "fornitura" ; -- status=guess
lin expression_N = mkN "espressione" feminine ; -- status=guess
lin owner_N = mkN "proprietario" ; -- status=guess
lin associate_V2 = variants{} ; -- 
lin associate_V = variants{} ; -- 
lin corner_N = mkN "angolo" ; -- status=guess
lin past_A = mkA "passato" ; -- status=guess
lin match_N = mkN "pari" | mkN "simile" | mkN "avversario" ; -- status=guess status=guess status=guess
lin match_3_N = variants{} ; -- 
lin match_2_N = variants{} ; -- 
lin match_1_N = variants{} ; -- 
lin sport_N = mkN "sport" masculine ; -- status=guess
lin status_N = mkN "stato" ; -- status=guess
lin beautiful_A = L.beautiful_A ;
lin offer_N = mkN "offerta" ; -- status=guess
lin marriage_N = mkN "connubio" | mkN "unione" feminine ; -- status=guess status=guess
lin hang_V2 = mkV2 (mkV "bloccarsi") ; -- status=guess, src=wikt
lin hang_V = mkV "bloccarsi" ; -- status=guess, src=wikt
lin civil_A = mkA "civile" ; -- status=guess
lin perform_V2 = mkV2 (mkV "eseguire") ; -- status=guess, src=wikt
lin perform_V = mkV "eseguire" ; -- status=guess, src=wikt
lin sentence_N = mkN "condanna" ; -- status=guess
lin crime_N = mkN "crimine" | mkN "delitto" ; -- status=guess status=guess
lin ball_N = mkN "palla" masculine ; -- status=guess
lin marry_V2 = mkV2 (mkV "sposarsi") ; -- status=guess, src=wikt
lin marry_V = mkV "sposarsi" ; -- status=guess, src=wikt
lin wind_N = L.wind_N ;
lin truth_N = mkN "veritate" feminine ; -- status=guess
lin protect_V2 = mkV2 (mkV "proteggere") ; -- status=guess, src=wikt
lin protect_V = mkV "proteggere" ; -- status=guess, src=wikt
lin safety_N = mkN "sicurezza" ; -- status=guess
lin partner_N = variants{} ; -- 
lin completely_Adv = variants{} ; -- 
lin copy_N = mkN "copia" | mkN "replica" ; -- status=guess status=guess
lin balance_N = mkN "equilibrio" ; -- status=guess
lin sister_N = L.sister_N ;
lin reader_N = mkN "lettore" masculine | mkN "lettrice" feminine ; -- status=guess status=guess
lin below_Adv = mkAdv "sotto zero" ; -- status=guess
lin trial_N = mkN "processo" ; -- status=guess
lin rock_N = L.rock_N ;
lin damage_N = mkN "danno" ; -- status=guess
lin adopt_V2 = mkV2 (mkV "adottare") ; -- status=guess, src=wikt
lin newspaper_N = L.newspaper_N ;
lin meaning_N = mkN "significato" ; -- status=guess
lin light_A = mkA "leggero" | mkA "leggera" ; -- status=guess status=guess
lin essential_A = mkA "essenziale" | mkA "indispensabile" ; -- status=guess status=guess
lin obvious_A = mkA "ovvio" ; -- status=guess
lin nation_N = mkN "nation" feminine ; -- status=guess
lin confirm_VS = mkVS (mkV "confermare") | mkVS (mkV "cresimare") ; -- status=guess, src=wikt status=guess, src=wikt
lin confirm_V2 = mkV2 (mkV "confermare") | mkV2 (mkV "cresimare") ; -- status=guess, src=wikt status=guess, src=wikt
lin south_N = mkN "sud" | mkN "mezzogiorno" | mkN "meridione" ; -- status=guess status=guess status=guess
lin length_N = mkN "lunghezza" ; -- status=guess
lin branch_N = mkN "branca" ; -- status=guess
lin deep_A = mkA "profondo" ; -- status=guess
lin none_NP = variants{} ; -- 
lin planning_N = mkN "pianificazione" feminine ; -- status=guess
lin trust_N = mkN "fiducia" ; -- status=guess
lin working_A = variants{} ; -- 
lin pain_N = mkN "dolore" masculine ; -- status=guess
lin studio_N = variants{} ; -- 
lin positive_A = mkA "positivo" ; -- status=guess
lin spirit_N = mkN "spirito" ; -- status=guess
lin college_N = variants{} ; -- 
lin accident_N = mkN "incidente" ; -- status=guess
lin star_V2 = variants{} ; -- 
lin hope_N = mkN "speranza" ; -- status=guess
lin mark_V3 = mkV3 (mkV "macchiare") ; -- status=guess, src=wikt
lin mark_V2 = mkV2 (mkV "macchiare") ; -- status=guess, src=wikt
lin works_N = variants{} ; -- 
lin league_N = variants{} ; -- 
lin league_2_N = variants{} ; -- 
lin league_1_N = variants{} ; -- 
lin clear_V2 = mkV2 (mkV "chiarire") ; -- status=guess, src=wikt
lin clear_V = mkV "chiarire" ; -- status=guess, src=wikt
lin imagine_VS = variants{} ; -- 
lin imagine_V2 = variants{} ; -- 
lin imagine_V = variants{} ; -- 
lin through_Adv = variants{}; -- S.through_Prep ;
lin cash_N = mkN "cassa" ; -- status=guess
lin normally_Adv = variants{} ; -- 
lin play_N = mkN "gioco" ; -- status=guess
lin strength_N = mkN "intensità" feminine | mkN "efficacia" ; -- status=guess status=guess
lin train_N = L.train_N ;
lin travel_V2 = mkV2 (mkV "viaggiare") ; -- status=guess, src=wikt
lin travel_V = L.travel_V ;
lin target_N = mkN "bersaglio" ; -- status=guess
lin very_A = variants{} ; -- 
lin pair_N = mkN "compasso" ; -- status=guess
lin male_A = mkA "maschile" ; -- status=guess
lin gas_N = mkN "camera a gas" ; -- status=guess
lin issue_V2 = variants{} ; -- 
lin issue_V = variants{} ; -- 
lin contribution_N = variants{} ; -- 
lin complex_A = variants{} ; -- 
lin supply_V2 = mkV2 (mkV "supplire") ; -- status=guess, src=wikt
lin beat_V2 = mkV2 (mkV (mkV "menare") "il can per l'aia") ; -- status=guess, src=wikt
lin beat_V = mkV (mkV "menare") "il can per l'aia" ; -- status=guess, src=wikt
lin artist_N = mkN "artista" masculine ; -- status=guess
lin agent_N = variants{} ; -- 
lin presence_N = mkN "presenza" ; -- status=guess
lin along_Adv = variants{} ; -- 
lin environmental_A = mkA "ambientale" ; -- status=guess
lin strike_V2 = mkV2 (mkV (essere_V) "respinto") ; -- status=guess, src=wikt
lin strike_V = mkV (essere_V) "respinto" ; -- status=guess, src=wikt
lin contact_N = mkN "contatto" ; -- status=guess
lin protection_N = mkN "protezione" feminine ; -- status=guess
lin beginning_N = mkN "inizio" ; -- status=guess
lin demand_VS = mkVS (mkV "esigere") | mkVS (mkV "pretendere") ; -- status=guess, src=wikt status=guess, src=wikt
lin demand_V2 = mkV2 (mkV "esigere") | mkV2 (mkV "pretendere") ; -- status=guess, src=wikt status=guess, src=wikt
lin media_N = variants{} ; -- 
lin relevant_A = variants{} ; -- 
lin employ_V2 = mkV2 (mkV "impiegare") | mkV2 (mkV "ingaggiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin shoot_V2 = mkV2 (mkV (mkV "spararne") "di grosse") ; -- status=guess, src=wikt
lin shoot_V = mkV (mkV "spararne") "di grosse" ; -- status=guess, src=wikt
lin executive_N = variants{} ; -- 
lin slowly_Adv = variants{} ; -- 
lin relatively_Adv = variants{} ; -- 
lin aid_N = mkN "aiutante" masculine ; -- status=guess
lin huge_A = mkA "enorme" ; -- status=guess
lin late_Adv = mkAdv "tardi" ; -- status=guess
lin speed_N = mkN "dosso stradale" ; -- status=guess
lin review_N = mkN "recensione" | mkN "critica" ; -- status=guess status=guess
lin test_V2 = mkV2 (mkV "testare") ; -- status=guess, src=wikt
lin order_VS = mkVS (mkV "ordinare") ; -- status=guess, src=wikt
lin order_V2V = mkV2V (mkV "ordinare") ; -- status=guess, src=wikt
lin order_V2 = mkV2 (mkV "ordinare") ; -- status=guess, src=wikt
lin order_V = mkV "ordinare" ; -- status=guess, src=wikt
lin route_N = mkN "percorso" ; -- status=guess
lin consequence_N = variants{} ; -- 
lin telephone_N = mkN "telefono" ; -- status=guess
lin release_V2 = mkV2 (mkV "rilasciare") ; -- status=guess, src=wikt
lin proportion_N = variants{} ; -- 
lin primary_A = mkA "primario" ; -- status=guess
lin consideration_N = variants{} ; -- 
lin reform_N = variants{} ; -- 
lin driver_N = mkN "patente di guida" ; -- status=guess
lin annual_A = mkA "annuale" ; -- status=guess
lin nuclear_A = mkA "nucleare" ; -- status=guess
lin latter_A = variants{} ; -- 
lin practical_A = variants{} ; -- 
lin commercial_A = variants{} ; -- 
lin rich_A = mkA "ricco" | mkA "ricca" ; -- status=guess status=guess
lin emerge_V = variants{} ; -- 
lin apparently_Adv = variants{} ; -- 
lin ring_V = mkV "suonare" ; -- status=guess, src=wikt
lin ring_6_V2 = variants{} ; -- 
lin ring_4_V2 = variants{} ; -- 
lin distance_N = mkN "distanza" ; -- status=guess
lin exercise_N = mkN "cicletta" | mkN "cyclette" ; -- status=guess status=guess
lin key_A = mkA "chiave" ; -- status=guess
lin close_Adv = variants{} ; -- 
lin skin_N = L.skin_N ;
lin island_N = mkN "isola" ; -- status=guess
lin separate_A = mkA "separato" | mkA "separata" ; -- status=guess status=guess
lin aim_VV = mkVV (mkV "puntare") ; -- status=guess, src=wikt
lin aim_V2 = mkV2 (mkV "puntare") ; -- status=guess, src=wikt
lin aim_V = mkV "puntare" ; -- status=guess, src=wikt
lin danger_N = mkN "pericolo" ; -- status=guess
lin credit_N = mkN "credito" ; -- status=guess
lin usual_A = mkA "solito" | mkA "usuale" | mkA "consueto" ; -- status=guess status=guess status=guess
lin link_V2 = mkV2 (mkV "collegare") | mkV2 (mkV "connettere") | mkV2 (mkV "linkare") ;
lin link_V = mkV "collegare" | mkV "connettere" | mkV "linkare" ;
lin candidate_N = variants{} ; -- 
lin track_N = mkN "atletica leggera" ; -- status=guess
lin safe_A = mkA "sicuro" ; -- status=guess
lin interested_A = mkA "interessato" | mkA "interessata" ; -- status=guess status=guess
lin assessment_N = mkN "valutazione" feminine ; -- status=guess
lin path_N = mkN "cammino" ; -- status=guess
lin merely_Adv = variants{} ; -- 
lin plus_Prep = variants{} ; -- 
lin district_N = mkN "distretto" ; -- status=guess
lin regular_A = mkA "regolare" ; -- status=guess
lin reaction_N = mkN "reazione" feminine ; -- status=guess
lin impact_N = mkN "impatto" ; -- status=guess
lin collect_V2 = mkV2 (raccogliere_V) ; -- status=guess, src=wikt
lin collect_V = raccogliere_V ; -- status=guess, src=wikt
lin debate_N = mkN "dibattito" | mkN "dibattimento" ; -- status=guess status=guess
lin lay_V2 = mkV2 (mkV "fancazzista") ; -- status=guess, src=wikt
lin lay_V = mkV "fancazzista" ; -- status=guess, src=wikt
lin rise_N = variants{} ; -- 
lin belief_N = mkN "fiducia" ; -- status=guess
lin conclusion_N = mkN "conclusione" feminine ; -- status=guess
lin shape_N = mkN "forma" | mkN "sagoma" ; -- status=guess status=guess
lin vote_N = mkN "voto" ; -- status=guess
lin aim_N = variants{} ; -- 
lin politics_N = mkN "politica" ; -- status=guess
lin reply_VS = mkVS (rispondere_V) ; -- status=guess, src=wikt
lin reply_V = rispondere_V ; -- status=guess, src=wikt
lin press_V2V = mkV2V (mkV "premere") ; -- status=guess, src=wikt
lin press_V2 = mkV2 (mkV "premere") ; -- status=guess, src=wikt
lin press_V = mkV "premere" ; -- status=guess, src=wikt
lin approach_V2 = mkV2 (mkV (mkV "accostarsi") "a") | mkV2 (mkV (mkV "avvicinarsi") "a") ; -- status=guess, src=wikt status=guess, src=wikt
lin approach_V = mkV (mkV "accostarsi") "a" | mkV (mkV "avvicinarsi") "a" ; -- status=guess, src=wikt status=guess, src=wikt
lin file_N = mkN "archivio" ; -- status=guess
lin western_A = variants{} ; -- 
lin earth_N = L.earth_N ;
lin public_N = mkN "pubblico dominio" ; -- status=guess
lin survive_V2 = mkV2 (sopravvivere_V) ; -- status=guess, src=wikt
lin survive_V = sopravvivere_V ; -- status=guess, src=wikt
lin estate_N = mkN "proprietà" feminine | mkN "tenuta" | mkN "possedimento" ; -- status=guess status=guess status=guess
lin boat_N = L.boat_N ;
lin prison_N = mkN "prigione" feminine | mkN "carcere" masculine ; -- status=guess status=guess
lin additional_A = mkA "addizionale" ; -- status=guess
lin settle_V2 = mkV2 (mkV "calmarsi") ; -- status=guess, src=wikt
lin settle_V = mkV "calmarsi" ; -- status=guess, src=wikt
lin largely_Adv = variants{} ; -- 
lin wine_N = L.wine_N ;
lin observe_VS = mkVS (mkV "osservare") ; -- status=guess, src=wikt
lin observe_V2 = mkV2 (mkV "osservare") ; -- status=guess, src=wikt
lin limit_V2V = variants{} ; -- 
lin limit_V2 = variants{} ; -- 
lin deny_V3 = mkV3 (mkV "negare") | mkV3 (mkV "smentire") ; -- status=guess, src=wikt status=guess, src=wikt
lin deny_V2 = mkV2 (mkV "negare") | mkV2 (mkV "smentire") ; -- status=guess, src=wikt status=guess, src=wikt
lin for_PConj = variants{} ; -- 
lin straight_Adv = variants{} ; -- 
lin somebody_NP = S.somebody_NP ;
lin writer_N = mkN "scrittore" | mkN "scrittrice" feminine ; -- status=guess status=guess
lin weekend_N = mkN "weekend" | mkN "fine settimana" ; -- status=guess status=guess
lin clothes_N = variants{} ; -- 
lin active_A = mkA "attivo" ; -- status=guess
lin sight_N = mkN "vista" masculine ; -- status=guess
lin video_N = mkN "scheda video" ; -- status=guess
lin reality_N = mkN "realtà" ; -- status=guess
lin hall_N = mkN "corridoio" ; -- status=guess
lin nevertheless_Adv = mkAdv "nondimeno" | mkAdv "tuttavia" | mkAdv "eppure" ; -- status=guess status=guess status=guess
lin regional_A = mkA "regionale" ; -- status=guess
lin vehicle_N = mkN "veicolo" ; -- status=guess
lin worry_VS = mkVS (mkV "preoccuparsi") ; -- status=guess, src=wikt
lin worry_V2 = mkV2 (mkV "preoccuparsi") ; -- status=guess, src=wikt
lin worry_V = mkV "preoccuparsi" ; -- status=guess, src=wikt
lin powerful_A = mkA "potente" ; -- status=guess
lin possibly_Adv = variants{} ; -- 
lin cross_V2 = mkV2 (mkV "intralciare") | mkV2 (mkV "ostacolare") ; -- status=guess, src=wikt status=guess, src=wikt
lin cross_V = mkV "intralciare" | mkV "ostacolare" ; -- status=guess, src=wikt status=guess, src=wikt
lin colleague_N = mkN "collega" masculine ; -- status=guess
lin charge_V2 = mkV2 (mkV "caricare") ; -- status=guess, src=wikt
lin charge_V = mkV "caricare" ; -- status=guess, src=wikt
lin lead_N = mkN "guida" ; -- status=guess
lin farm_N = mkN "fattoria" | mkN "podere" masculine ; -- status=guess status=guess
lin respond_VS = mkVS (rispondere_V) ; -- status=guess, src=wikt
lin respond_V = rispondere_V ; -- status=guess, src=wikt
lin employer_N = mkN "datore di lavoro" ; -- status=guess
lin carefully_Adv = variants{} ; -- 
lin understanding_N = variants{} ; -- 
lin connection_N = mkN "connessione" feminine ; -- status=guess
lin comment_N = mkN "commento" ; -- status=guess
lin grant_V3 = variants{} ; -- 
lin grant_V2 = variants{} ; -- 
lin concentrate_V2 = mkV2 (mkV "concentrarsi") ; -- status=guess, src=wikt
lin concentrate_V = mkV "concentrarsi" ; -- status=guess, src=wikt
lin ignore_V2 = mkV2 (mkV "ignorare") ; -- status=guess, src=wikt
lin ignore_V = mkV "ignorare" ; -- status=guess, src=wikt
lin phone_N = mkN "telefono" ; -- status=guess
lin hole_N = mkN "perforatrice" ; -- status=guess
lin insurance_N = mkN "compagnia di assicurazioni" ; -- status=guess
lin content_N = mkN "contenuto" ; -- status=guess
lin confidence_N = mkN "confidenziale" | mkN "riservato" ; -- status=guess status=guess
lin sample_N = mkN "campione" masculine ; -- status=guess
lin transport_N = mkN "trasporto" ; -- status=guess
lin objective_N = mkN "obbiettivo" | mkN "obiettivo" ; -- status=guess status=guess
lin alone_A = mkA "da solo" | mkA "solo" ; -- status=guess status=guess
lin flower_N = L.flower_N ;
lin injury_N = mkN "ferita" | mkN "danno" | mkN "lesione" feminine ; -- status=guess status=guess status=guess
lin lift_V2 = mkV2 (mkV "alzare") | mkV2 (mkV "levare") ; -- status=guess, src=wikt status=guess, src=wikt
lin lift_V = mkV "alzare" | mkV "levare" ; -- status=guess, src=wikt status=guess, src=wikt
lin stick_V2 = mkV2 (mkV "attaccarsi") ; -- status=guess, src=wikt
lin stick_V = mkV "attaccarsi" ; -- status=guess, src=wikt
lin front_A = variants{} ; -- 
lin mainly_Adv = variants{} ; -- 
lin battle_N = mkN "battaglia" masculine ; -- status=guess
lin generation_N = mkN "generazione" feminine ; -- status=guess
lin currently_Adv = variants{} ; -- 
lin winter_N = mkN "inverno" ; -- status=guess
lin inside_Prep = variants{} ; -- 
lin impossible_A = mkA "impossibile" ; -- status=guess
lin somewhere_Adv = S.somewhere_Adv ;
lin arrange_V2 = mkV2 (disporre_V) ; -- status=guess, src=wikt
lin arrange_V = disporre_V ; -- status=guess, src=wikt
lin will_N = mkN "volontà" feminine ; -- status=guess
lin sleep_V = L.sleep_V ;
lin progress_N = mkN "progresso" ; -- status=guess
lin volume_N = mkN "volume" masculine ; -- status=guess
lin ship_N = L.ship_N ;
lin legislation_N = mkN "leggi" feminine ; -- status=guess
lin commitment_N = mkN "impegno" | mkN "dedizione" feminine ; -- status=guess status=guess
lin enough_Predet = variants{} ; -- 
lin conflict_N = mkN "conflitto" ; -- status=guess
lin bag_N = mkN "sacco" | mkN "busta" ; -- status=guess status=guess
lin fresh_A = mkA "nuovo" | mkA "nuova" | mkA "recente" ; -- status=guess status=guess status=guess
lin entry_N = mkN "entrata" | mkN "ingresso" ; -- status=guess status=guess
lin entry_2_N = variants{} ; -- 
lin entry_1_N = variants{} ; -- 
lin smile_N = mkN "sorriso" ; -- status=guess
lin fair_A = mkA "discreto" | mkA "discreta" ; -- status=guess status=guess
lin promise_VV = mkVV (promettere_V) ; -- status=guess, src=wikt
lin promise_VS = mkVS (promettere_V) ; -- status=guess, src=wikt
lin promise_V2 = mkV2 (promettere_V) ; -- status=guess, src=wikt
lin promise_V = promettere_V ; -- status=guess, src=wikt
lin introduction_N = mkN "introduzione" feminine ; -- status=guess
lin senior_A = variants{} ; -- 
lin manner_N = mkN "maniera" | mkN "modo" ; -- status=guess status=guess
lin background_N = mkN "sfondo" ; -- status=guess
lin key_N = mkN "tasto" ; -- status=guess
lin key_2_N = variants{} ; -- 
lin key_1_N = variants{} ; -- 
lin touch_V2 = mkV2 (commuovere_V) ; -- status=guess, src=wikt
lin touch_V = commuovere_V ; -- status=guess, src=wikt
lin vary_V2 = variants{} ; -- 
lin vary_V = variants{} ; -- 
lin sexual_A = mkA "sessuale" ; -- status=guess
lin ordinary_A = mkA "ordinario" | mkA "ordinaria" ; -- status=guess status=guess
lin cabinet_N = mkN "consiglio" ; -- status=guess
lin painting_N = mkN "dipinto" | mkN "pittura" | mkN "quadro" ; -- status=guess status=guess status=guess
lin entirely_Adv = variants{} ; -- 
lin engine_N = mkN "motore" masculine ; -- status=guess
lin previously_Adv = variants{} ; -- 
lin administration_N = mkN "amministrazione" feminine ; -- status=guess
lin tonight_Adv = mkAdv "stasera" ; -- status=guess
lin adult_N = mkN "adulto" | mkN "adulta" ; -- status=guess status=guess
lin prefer_VV = mkVV (mkV "preferire") ; -- status=guess, src=wikt
lin prefer_V2 = mkV2 (mkV "preferire") ; -- status=guess, src=wikt
lin author_N = mkN "autore" | mkN "autrice" feminine ; -- status=guess status=guess
lin actual_A = mkA "reale" | mkA "effettivo" ; -- status=guess status=guess
lin song_N = L.song_N ;
lin investigation_N = mkN "investigazione" feminine ; -- status=guess
lin debt_N = mkN "debito" ; -- status=guess
lin visitor_N = variants{} ; -- 
lin forest_N = mkN "foresta" ; -- status=guess
lin repeat_VS = mkVS (mkV "ripetere") ; -- status=guess, src=wikt
lin repeat_V2 = mkV2 (mkV "ripetere") ; -- status=guess, src=wikt
lin repeat_V = mkV "ripetere" ; -- status=guess, src=wikt
lin wood_N = L.wood_N ;
lin contrast_N = variants{} ; -- 
lin extremely_Adv = variants{} ; -- 
lin wage_N = mkN "salario" ; -- status=guess
lin domestic_A = mkA "domestico" | mkA "domestica" ; -- status=guess status=guess
lin commit_V2 = mkV2 (mkV "affidare") ; -- status=guess, src=wikt
lin threat_N = mkN "minaccia" ; -- status=guess
lin bus_N = mkN "bus" masculine ; -- status=guess
lin warm_A = L.warm_A ;
lin sir_N = mkN "signore" masculine ; -- status=guess
lin regulation_N = mkN "regolamento" ; -- status=guess
lin drink_N = mkN "bevuta" ; -- status=guess
lin relief_N = mkN "rilievo" | mkN "sopraelevazione" feminine ; -- status=guess status=guess
lin internal_A = variants{} ; -- 
lin strange_A = mkA "strano" ; -- status=guess
lin excellent_A = mkA "eccellente" ; -- status=guess
lin run_N = mkN "corsa" ; -- status=guess
lin fairly_Adv = variants{} ; -- 
lin technical_A = variants{} ; -- 
lin tradition_N = mkN "tradizione" feminine ; -- status=guess
lin measure_V2 = mkV2 (mkV "misurare") ; -- status=guess, src=wikt
lin measure_V = mkV "misurare" ; -- status=guess, src=wikt
lin insist_VS = variants{} ; -- 
lin insist_V2 = variants{} ; -- 
lin insist_V = variants{} ; -- 
lin farmer_N = mkN "agricoltore" masculine | mkN "fattore" masculine ; -- status=guess status=guess
lin until_Prep = mkPrep "fine" ;
lin traffic_N = mkN "rotatoria" ; -- status=guess
lin dinner_N = mkN "cena" ; -- status=guess
lin consumer_N = mkN "consumatore" | mkN "consumatrice" feminine ; -- status=guess status=guess
lin meal_N = mkN "mangìme" masculine ; -- status=guess
lin warn_VS = variants{} ; -- 
lin warn_V2V = variants{} ; -- 
lin warn_V2 = variants{} ; -- 
lin warn_V = variants{} ; -- 
lin living_A = variants{} ; -- 
lin package_N = mkN "pacco" ; -- status=guess
lin half_N = mkN "fratello mezzo" ; -- status=guess
lin increasingly_Adv = variants{} ; -- 
lin description_N = mkN "descrizione" feminine ; -- status=guess
lin soft_A = mkA "dolce" ; -- status=guess
lin stuff_N = mkN "cose" | mkN "roba" ; -- status=guess status=guess
lin award_V3 = mkV3 (mkV "sentenziare") ; -- status=guess, src=wikt
lin award_V2 = mkV2 (mkV "sentenziare") ; -- status=guess, src=wikt
lin existence_N = mkN "esistenza" ; -- status=guess
lin improvement_N = mkN "miglioramento" ; -- status=guess
lin coffee_N = mkN "chicco di caffè" ; -- status=guess
lin appearance_N = mkN "apparizione" feminine | mkN "visione" feminine ; -- status=guess status=guess
lin standard_A = mkA "standard" | mkA "regolare" ; -- status=guess status=guess
lin attack_V2 = variants{} ; -- 
lin sheet_N = mkN "spartito" ; -- status=guess
lin category_N = mkN "categoria" ; -- status=guess
lin distribution_N = mkN "distribuzione" feminine ; -- status=guess
lin equally_Adv = variants{} ; -- 
lin session_N = mkN "sessione" feminine ; -- status=guess
lin cultural_A = mkA "culturale" ; -- status=guess
lin loan_N = mkN "prestito" | mkN "mutuo" ; -- status=guess status=guess
lin bind_V2 = mkV2 (mkV "legare") ; -- status=guess, src=wikt
lin bind_V = mkV "legare" ; -- status=guess, src=wikt
lin museum_N = mkN "museo" ; -- status=guess
lin conversation_N = mkN "conversazione" feminine | mkN "dialogo" | mkN "discorso" ; -- status=guess status=guess status=guess
lin threaten_VV = mkVV (mkV "minacciare") ; -- status=guess, src=wikt
lin threaten_VS = mkVS (mkV "minacciare") ; -- status=guess, src=wikt
lin threaten_V2 = mkV2 (mkV "minacciare") ; -- status=guess, src=wikt
lin threaten_V = mkV "minacciare" ; -- status=guess, src=wikt
lin link_N = mkN "connessione" feminine ; -- status=guess
lin launch_V2 = mkV2 (mkV "lanciare") ; -- status=guess, src=wikt
lin launch_V = mkV "lanciare" ; -- status=guess, src=wikt
lin proper_A = mkA "decente" | mkA "proprio" ; -- status=guess status=guess
lin victim_N = mkN "vittima" ; -- status=guess
lin audience_N = mkN "udienza" ; -- status=guess
lin famous_A = mkA "famoso" | mkA "famosa" ; -- status=guess status=guess
lin master_N = mkN "capitano" | mkN "comandante" masculine ; -- status=guess status=guess
lin master_2_N = variants{} ; -- 
lin master_1_N = variants{} ; -- 
lin lip_N = mkN "labbro" ; -- status=guess
lin religious_A = variants{} ; -- 
lin joint_A = variants{} ; -- 
lin cry_V2 = mkV2 (mkV "gridare") | mkV2 (mkV "urlare") | mkV2 (mkV "gridare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cry_V = mkV "gridare" | mkV "urlare" | mkV "gridare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin potential_A = variants{} ; -- 
lin broad_A = L.broad_A ;
lin exhibition_N = variants{} ; -- 
lin experience_V2 = mkV2 (mkV "esperire") ; -- status=guess, src=wikt
lin judge_N = mkN "giudice" ; -- status=guess
lin formal_A = variants{} ; -- 
lin housing_N = mkN "immobili" masculine ; -- status=guess
lin past_Prep = variants{} ; -- 
lin concern_V2 = mkV2 (mkV "interessare") | mkV2 (mkV "concernere") ; -- status=guess, src=wikt status=guess, src=wikt
lin freedom_N = mkN "libertà" feminine ; -- status=guess
lin gentleman_N = mkN "gentiluomo" ; -- status=guess
lin attract_V2 = variants{} ; -- 
lin explanation_N = mkN "spiegazione" feminine ; -- status=guess
lin appoint_V3 = variants{} ; -- 
lin appoint_V2V = variants{} ; -- 
lin appoint_V2 = variants{} ; -- 
lin note_VS = variants{} ; -- 
lin note_V2 = variants{} ; -- 
lin note_V = variants{} ; -- 
lin chief_A = variants{} ; -- 
lin total_N = mkN "totale" masculine ; -- status=guess
lin lovely_A = variants{} ; -- 
lin official_A = variants{} ; -- 
lin date_V2 = mkV2 (mkV "datare") ; -- status=guess, src=wikt
lin date_V = mkV "datare" ; -- status=guess, src=wikt
lin demonstrate_VS = variants{} ; -- 
lin demonstrate_V2 = variants{} ; -- 
lin demonstrate_V = variants{} ; -- 
lin construction_N = variants{} ; -- 
lin middle_N = mkN "mezza età" ; -- status=guess
lin yard_N = mkN "cortile" masculine ; -- status=guess
lin unable_A = variants{} ; -- 
lin acquire_V2 = mkV2 (mkV "acquisire") ; -- status=guess, src=wikt
lin surely_Adv = variants{} ; -- 
lin crisis_N = mkN "crisi" feminine ; -- status=guess
lin propose_VV = mkVV (proporre_V) ; -- status=guess, src=wikt
lin propose_VS = mkVS (proporre_V) ; -- status=guess, src=wikt
lin propose_V2 = mkV2 (proporre_V) ; -- status=guess, src=wikt
lin propose_V = proporre_V ; -- status=guess, src=wikt
lin west_N = mkN "ovest" | mkN "occidente" | mkN "ponente" ; -- status=guess status=guess status=guess
lin impose_V2 = variants{} ; -- 
lin impose_V = variants{} ; -- 
lin market_V2 = variants{} ; -- 
lin market_V = variants{} ; -- 
lin care_V = mkV "curare" ; -- status=guess, src=wikt
lin god_N = mkN "dio" ; -- status=guess
lin favour_N = variants{} ; -- 
lin before_Adv = mkAdv "prima" ; -- status=guess
lin name_V3 = mkV3 (mkV "nominare") ; -- status=guess, src=wikt
lin name_V2 = mkV2 (mkV "nominare") ; -- status=guess, src=wikt
lin equal_A = mkA "uguale" ; -- status=guess
lin capacity_N = variants{} ; -- 
lin flat_N = mkN "gatto dalla testa piatta" ; -- status=guess
lin selection_N = mkN "selezione" feminine ; -- status=guess
lin alone_Adv = variants{} ; -- 
lin football_N = mkN "calcio" ; -- status=guess
lin victory_N = mkN "vittoria" ; -- status=guess
lin factory_N = L.factory_N ;
lin rural_A = mkA "rurale" ; -- status=guess
lin twice_Adv = mkAdv "due volte" ; -- status=guess
lin sing_V2 = mkV2 (mkV "cantare") ; -- status=guess, src=wikt
lin sing_V = L.sing_V ;
lin whereas_Subj = variants{} ; -- 
lin own_V2 = mkV2 (possedere_V) ; -- status=guess, src=wikt
lin head_V2 = variants{} ; -- 
lin head_V = variants{} ; -- 
lin examination_N = mkN "esame" masculine ; -- status=guess
lin deliver_V2 = variants{} ; -- 
lin deliver_V = variants{} ; -- 
lin nobody_NP = S.nobody_NP ;
lin substantial_A = mkA "sostanziale" ; -- status=guess
lin invite_V2V = mkV2V (mkV "invitare") ; -- status=guess, src=wikt
lin invite_V2 = mkV2 (mkV "invitare") ; -- status=guess, src=wikt
lin intention_N = mkN "intenzione" feminine ; -- status=guess
lin egg_N = L.egg_N ;
lin reasonable_A = mkA "moderato" ; -- status=guess
lin onto_Prep = variants{} ; -- 
lin retain_V2 = variants{} ; -- 
lin aircraft_N = mkN "aeromobile" feminine ; -- status=guess
lin decade_N = mkN "decennio" | mkN "decade" feminine ; -- status=guess status=guess
lin cheap_A = mkA "economico" ; -- status=guess
lin quiet_A = mkA "calmo" ; -- status=guess
lin bright_A = mkA "allegro" | mkA "felice" ; -- status=guess status=guess
lin contribute_V2 = mkV2 (mkV "contribuire") ; -- status=guess, src=wikt
lin contribute_V = mkV "contribuire" ; -- status=guess, src=wikt
lin row_N = mkN "riga" ; -- status=guess
lin search_N = mkN "cerca" ; -- status=guess
lin limit_N = mkN "limite" masculine ; -- status=guess
lin definition_N = mkN "definizione" feminine | mkN "il definire" ; -- status=guess status=guess
lin unemployment_N = mkN "disoccupazione" feminine ; -- status=guess
lin spread_V2 = mkV2 (spargere_V) | mkV2 (diffondere_V) | mkV2 (mkV "sparpagliare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin spread_V = spargere_V | diffondere_V | mkV "sparpagliare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mark_N = mkN "voto" ; -- status=guess
lin flight_N = mkN "fuga" ; -- status=guess
lin account_V2 = mkV2 (mkV "reputare") | mkV2 (mkV "considerare") | mkV2 (ritenere_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin account_V = mkV "reputare" | mkV "considerare" | ritenere_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin output_N = variants{} ; -- 
lin last_V = mkV "durare" ; -- status=guess, src=wikt
lin tour_N = mkN "tournée" | mkN "[abbrivation] tour" ; -- status=guess status=guess
lin address_N = mkN "discorso" ; -- status=guess
lin immediate_A = mkA "prossimo" | mkA "stretto" | mkA "diretto" ; -- status=guess status=guess status=guess
lin reduction_N = mkN "sgravio" | mkN "taglio" | mkN "riduzione" feminine ; -- status=guess status=guess status=guess
lin interview_N = mkN "colloquio" ; -- status=guess
lin assess_V2 = mkV2 (mkV "valutare") | mkV2 (mkV "stimare") | mkV2 (mkV "estimare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin promote_V2 = mkV2 (promuovere_V) ; -- status=guess, src=wikt
lin promote_V = promuovere_V ; -- status=guess, src=wikt
lin everybody_NP = S.everybody_NP ;
lin suitable_A = mkA "adatto" | mkA "idoneo" | mkA "rispondente" | mkA "confacente" | mkA "indicato" | mkA "appropriato" | mkA "giusto" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin growing_A = variants{} ; -- 
lin nod_V = mkV (scuotere_V) "la testa" ; -- status=guess, src=wikt
lin reject_V2 = mkV2 (mkV "respingere") | mkV2 (mkV "rifiutare") ; -- status=guess, src=wikt status=guess, src=wikt
lin while_N = variants{} ; -- 
lin high_Adv = variants{} ; -- 
lin dream_N = mkN "sogno" ; -- status=guess
lin vote_VV = mkVV (mkV "votare") ; -- status=guess, src=wikt
lin vote_V3 = variants{}; -- mkV2 (mkV "votare") ; -- status=guess, src=wikt
lin vote_V2 = mkV2 (mkV "votare") ; -- status=guess, src=wikt
lin vote_V = mkV "votare" ; -- status=guess, src=wikt
lin divide_V2 = mkV2 (mkV (mkV "dividi") "e domina") ; -- status=guess, src=wikt
lin divide_V = mkV (mkV "dividi") "e domina" ; -- status=guess, src=wikt
lin declare_VS = mkVS (mkV "dichiarare") ; -- status=guess, src=wikt
lin declare_V2 = mkV2 (mkV "dichiarare") ; -- status=guess, src=wikt
lin declare_V = mkV "dichiarare" ; -- status=guess, src=wikt
lin handle_V2 = variants{} ; -- 
lin handle_V = variants{} ; -- 
lin detailed_A = variants{} ; -- 
lin challenge_N = mkN "sfida" ; -- status=guess
lin notice_N = variants{} ; -- 
lin rain_N = L.rain_N ;
lin destroy_V2 = mkV2 (distruggere_V) ; -- status=guess, src=wikt
lin mountain_N = L.mountain_N ;
lin concentration_N = mkN "concentrazione" feminine ; -- status=guess
lin limited_A = variants{} ; -- 
lin finance_N = variants{} ; -- 
lin pension_N = mkN "pensione" feminine ; -- status=guess
lin influence_V2 = mkV2 (mkV "influire") ; -- status=guess, src=wikt
lin afraid_A = mkA "paura" ; -- status=guess
lin murder_N = mkN "assassinio" | mkN "omicidio" | mkN "delitto" ; -- status=guess status=guess status=guess
lin neck_N = L.neck_N ;
lin weapon_N = mkN "arma" ; -- status=guess
lin hide_V2 = mkV2 (mkV "nascondersi") ; -- status=guess, src=wikt
lin hide_V = mkV "nascondersi" ; -- status=guess, src=wikt
lin offence_N = variants{} ; -- 
lin absence_N = mkN "assenza" ; -- status=guess
lin error_N = mkN "errore" masculine ; -- status=guess
lin representative_N = variants{} ; -- 
lin enterprise_N = mkN "impresa" ; -- status=guess
lin criticism_N = mkN "critica" ; -- status=guess
lin average_A = mkA "medio" | mkA "media" ; -- status=guess status=guess
lin quick_A = mkA "rapido" ; -- status=guess
lin sufficient_A = mkA "sufficiente" ; -- status=guess
lin appointment_N = mkN "appuntamento" ; -- status=guess
lin match_V2 = mkV2 (mkV "incontrarsi") ; -- status=guess, src=wikt
lin transfer_V = mkV "trasferire" ; -- status=guess, src=wikt
lin acid_N = mkN "acido" | mkN "acido lisergico" ; -- status=guess status=guess
lin spring_N = mkN "molla" ; -- status=guess
lin birth_N = mkN "nascita" masculine ; -- status=guess
lin ear_N = L.ear_N ;
lin recognize_VS = mkVS (riconoscere_V) ; -- status=guess, src=wikt
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin recommend_V2V = mkV2V (mkV "raccomandare") ; -- status=guess, src=wikt
lin recommend_V2 = mkV2 (mkV "raccomandare") ; -- status=guess, src=wikt
lin module_N = variants{} ; -- 
lin instruction_N = variants{} ; -- 
lin democratic_A = mkA "democratico" ; -- status=guess
lin park_N = mkN "parco" ; -- status=guess
lin weather_N = mkN "pallone sonda" ; -- status=guess
lin bottle_N = mkN "bottiglia" ; -- status=guess
lin address_V2 = mkV2 (mkV "rivolgersi") ; -- status=guess, src=wikt
lin bedroom_N = mkN "camera da letto" | mkN "camera" ; -- status=guess status=guess
lin kid_N = mkN "pelle di capretto" ; -- status=guess
lin pleasure_N = mkN "piacere" masculine ; -- status=guess
lin realize_VS = mkVS (mkV (mkV "rendersi") "conto") | mkVS (mkV "accorgersi") ; -- status=guess, src=wikt status=guess, src=wikt
lin realize_V2 = mkV2 (mkV (mkV "rendersi") "conto") | mkV2 (mkV "accorgersi") ; -- status=guess, src=wikt status=guess, src=wikt
lin assembly_N = variants{} ; -- 
lin expensive_A = mkA "caro" | mkA "costoso" ; -- status=guess status=guess
lin select_VV = mkVV (scegliere_V) | mkVV (mkV "selezionare") ; -- status=guess, src=wikt status=guess, src=wikt
lin select_V2V = mkV2V (scegliere_V) | mkV2V (mkV "selezionare") ; -- status=guess, src=wikt status=guess, src=wikt
lin select_V2 = mkV2 (scegliere_V) | mkV2 (mkV "selezionare") ; -- status=guess, src=wikt status=guess, src=wikt
lin select_V = scegliere_V | mkV "selezionare" ; -- status=guess, src=wikt status=guess, src=wikt
lin teaching_N = mkN "insegnamento" ; -- status=guess
lin desire_N = mkN "desiderio" ; -- status=guess
lin whilst_Subj = variants{} ; -- 
lin contact_V2 = mkV2 (mkV "contattare") ; -- status=guess, src=wikt
lin implication_N = variants{} ; -- 
lin combine_VV = mkVV (mkV "combinare") ; -- status=guess, src=wikt
lin combine_V2 = mkV2 (mkV "combinare") ; -- status=guess, src=wikt
lin combine_V = mkV "combinare" ; -- status=guess, src=wikt
lin temperature_N = mkN "temperatura" ; -- status=guess
lin wave_N = mkN "onda" ; -- status=guess
lin magazine_N = mkN "caricatore" masculine ; -- status=guess
lin totally_Adv = variants{} ; -- 
lin mental_A = mkA "pazzo" ; -- status=guess
lin used_A = variants{} ; -- 
lin store_N = mkN "magazzino" | mkN "deposito" ; -- status=guess status=guess
lin scientific_A = mkA "scientifico" ; -- status=guess
lin frequently_Adv = variants{} ; -- 
lin thanks_N = variants{} ; -- 
lin beside_Prep = variants{} ; -- 
lin settlement_N = mkN "insediamento" ; -- status=guess
lin absolutely_Adv = variants{} ; -- 
lin critical_A = variants{} ; -- 
lin critical_2_A = variants{} ; -- 
lin critical_1_A = variants{} ; -- 
lin recognition_N = variants{} ; -- 
lin touch_N = mkN "tatto" | mkN "contatto" ; -- status=guess status=guess
lin consist_V = consistere_V ; -- status=guess, src=wikt
lin below_Prep = variants{} ; -- 
lin silence_N = mkN "silenzio" ; -- status=guess
lin expenditure_N = mkN "spendere" masculine ; -- status=guess
lin institute_N = mkN "istituto" ; -- status=guess
lin dress_V2 = mkV2 (mkV "vestire") ; -- status=guess, src=wikt
lin dress_V = mkV "vestire" ; -- status=guess, src=wikt
lin dangerous_A = mkA "pericoloso" | mkA "pericolosa" ; -- status=guess status=guess
lin familiar_A = mkA "familiare" ; -- status=guess
lin asset_N = variants{} ; -- 
lin educational_A = mkA "educativo" ; -- status=guess
lin sum_N = mkN "somma" ; -- status=guess
lin publication_N = mkN "pubblicazione" feminine ; -- status=guess
lin partly_Adv = variants{} ; -- 
lin block_N = mkN "ceppo" ; -- status=guess
lin seriously_Adv = variants{} ; -- 
lin youth_N = mkN "ostello della gioventù" ; -- status=guess
lin tape_N = mkN "tape" ; -- status=guess
lin elsewhere_Adv = mkAdv "altrove" ; -- status=guess
lin cover_N = mkN "pane e coperta" | mkN "coperto" ; -- status=guess status=guess
lin fee_N = mkN "tassa" | mkN "tariffa" | mkN "quota" | mkN "onorario" | mkN "emolumento" ; -- status=guess status=guess status=guess status=guess status=guess
lin program_N = mkN "programma" masculine ; -- status=guess
lin treaty_N = mkN "trattato" ; -- status=guess
lin necessarily_Adv = variants{} ; -- 
lin unlikely_A = mkA "improbabile" ; -- status=guess
lin properly_Adv = variants{} ; -- 
lin guest_N = mkN "ospite" masculine ; -- status=guess
lin code_N = mkN "codice" masculine ; -- status=guess
lin hill_N = L.hill_N ;
lin screen_N = mkN "paravento" ; -- status=guess
lin household_N = mkN "elettrodomestico" ; -- status=guess
lin sequence_N = mkN "successione" feminine ; -- status=guess
lin correct_A = L.correct_A ;
lin female_A = mkA "femminile" ; -- status=guess
lin phase_N = mkN "aspetto" | mkN "faccia" ; -- status=guess status=guess
lin crowd_N = mkN "folla" | mkN "turba" ; -- status=guess status=guess
lin welcome_V2 = mkV2 (accogliere_V) | mkV2 (mkV (dare_V) "il benvenuto") ; -- status=guess, src=wikt status=guess, src=wikt
lin metal_N = mkN "metallo" ; -- status=guess
lin human_N = mkN "umano" ;
lin widely_Adv = variants{} ; -- 
lin undertake_V2 = mkV2 (intraprendere_V) ; -- status=guess, src=wikt
lin cut_N = mkN "taglio" ; -- status=guess
lin sky_N = L.sky_N ;
lin brain_N = mkN "cervello" | mkN "cervella" ;
lin expert_N = variants{} ; -- 
lin experiment_N = variants{} ; -- 
lin tiny_A = mkA "minuscolo" ; -- status=guess
lin perfect_A = mkA "perfetto" ; -- status=guess
lin disappear_V = mkV "sparire" ; -- status=guess, src=wikt
lin initiative_N = mkN "iniziativa" ; -- status=guess
lin assumption_N = mkN "assunzione" feminine ; -- status=guess
lin photograph_N = mkN "fotografia" ; -- status=guess
lin ministry_N = mkN "ministero" ; -- status=guess
lin congress_N = variants{} ; -- 
lin transfer_N = mkN "trasferimento" ; -- status=guess
lin reading_N = mkN "lettura" ; -- status=guess
lin scientist_N = mkN "scienziato" | mkN "scienziata" ; -- status=guess status=guess
lin fast_Adv = mkAdv "in anticipo" ; -- status=guess
lin fast_A = mkA "avanti" ; -- status=guess
lin closely_Adv = variants{} ; -- 
lin thin_A = L.thin_A ;
lin solicitor_N = variants{} ; -- 
lin secure_V2 = variants{} ; -- 
lin plate_N = mkN "piatto" | mkN "portata" ; -- status=guess status=guess
lin pool_N = mkN "bacino" | mkN "invaso" ; -- status=guess status=guess
lin gold_N = L.gold_N ;
lin emphasis_N = variants{} ; -- 
lin recall_VS = mkVS (mkV "ritirare") | mkVS (mkV "revocare") | mkVS (mkV "richiamare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin recall_V2 = mkV2 (mkV "ritirare") | mkV2 (mkV "revocare") | mkV2 (mkV "richiamare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shout_V2 = mkV2 (mkV "offrire") ; -- status=guess, src=wikt
lin shout_V = mkV "offrire" ; -- status=guess, src=wikt
lin generate_V2 = mkV2 (mkV "generare") ; -- status=guess, src=wikt
lin location_N = mkN "posizione" feminine ; -- status=guess
lin display_VS = variants{} ; -- 
lin display_V2 = variants{} ; -- 
lin heat_N = mkN "gusto piccante" | mkN "sapore piccante" ; -- status=guess status=guess
lin gun_N = mkN "fucile" masculine ; -- status=guess
lin shut_V2 = mkV2 (chiudere_V) ; -- status=guess, src=wikt
lin journey_N = mkN "viaggio" ; -- status=guess
lin imply_VS = mkVS (mkV "implicare") ; -- status=guess, src=wikt
lin imply_V2 = mkV2 (mkV "implicare") ; -- status=guess, src=wikt
lin imply_V = mkV "implicare" ; -- status=guess, src=wikt
lin violence_N = variants{} ; -- 
lin dry_A = L.dry_A ;
lin historical_A = mkA "storico" ; -- status=guess
lin step_V2 = variants{} ; -- 
lin step_V = variants{} ; -- 
lin curriculum_N = mkN "curriculum vitae" ; -- status=guess
lin noise_N = mkN "rumore" masculine ; -- status=guess
lin lunch_N = mkN "pranzo" | mkN "seconda colazione" feminine ; -- status=guess status=guess
lin fear_VS = L.fear_VS ;
lin fear_V2 = L.fear_V2 ;
lin fear_V = mkV "temere" | mkV (mkV "aver") "paura di" ; -- status=guess, src=wikt status=guess, src=wikt
lin succeed_V2 = mkV2 (riuscire_V) ; -- status=guess, src=wikt
lin succeed_V = riuscire_V ; -- status=guess, src=wikt
lin fall_N = mkN "caduta" ; -- status=guess
lin fall_2_N = variants{} ; -- 
lin fall_1_N = variants{} ; -- 
lin bottom_N = mkN "sedere" masculine ; -- status=guess
lin initial_A = mkA "iniziale" ; -- status=guess
lin theme_N = mkN "tema" masculine ; -- status=guess
lin characteristic_N = mkN "caratteristica" masculine ; -- status=guess
lin pretty_Adv = variants{} ; -- 
lin empty_A = L.empty_A ;
lin display_N = mkN "schermo" | mkN "video" ; -- status=guess status=guess
lin combination_N = variants{} ; -- 
lin interpretation_N = variants{} ; -- 
lin rely_V2 = variants{}; -- mkV (mkV "contare") "su" | mkV (I.fare_V) "affidamento" | mkV "basarsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rely_V = mkV (mkV "contare") "su" | mkV (I.fare_V) "affidamento" | mkV "basarsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin escape_VS = mkVS (mkV "evitare") ; -- status=guess, src=wikt
lin escape_V2 = mkV2 (mkV "evitare") ; -- status=guess, src=wikt
lin escape_V = mkV "evitare" ; -- status=guess, src=wikt
lin score_V2 = mkV2 (mkV "segnare") | mkV2 (mkV "realizzare") ; -- status=guess, src=wikt status=guess, src=wikt
lin score_V = mkV "segnare" | mkV "realizzare" ; -- status=guess, src=wikt status=guess, src=wikt
lin justice_N = mkN "giustizia" ; -- status=guess
lin upper_A = mkA "superiore" ; -- status=guess
lin tooth_N = L.tooth_N ;
lin organize_V2V = variants{} ; -- 
lin organize_V2 = variants{} ; -- 
lin cat_N = L.cat_N ;
lin tool_N = mkN "attrezzo" | mkN "strumento" ; -- status=guess status=guess
lin spot_N = mkN "macchia" ; -- status=guess
lin bridge_N = mkN "setto nasale" ; -- status=guess
lin double_A = mkA "doppio" | mkA "doppia" ; -- status=guess status=guess
lin direct_V2 = variants{} ; -- 
lin direct_V = variants{} ; -- 
lin conclude_VS = variants{} ; -- 
lin conclude_V2 = variants{} ; -- 
lin conclude_V = variants{} ; -- 
lin relative_A = mkA "relativo" ; -- status=guess
lin soldier_N = mkN "soldato" ; -- status=guess
lin climb_V2 = mkV2 (mkV "arrampicare") | mkV2 (mkV "scalare") ; -- status=guess, src=wikt status=guess, src=wikt
lin climb_V = mkV "arrampicare" | mkV "scalare" ; -- status=guess, src=wikt status=guess, src=wikt
lin breath_N = mkN "respiro" ; -- status=guess
lin afford_V2V = variants{} ; -- 
lin afford_V2 = variants{} ; -- 
lin urban_A = mkA "urbano" ; -- status=guess
lin nurse_N = mkN "infermiere" | mkN "infermiera" ; -- status=guess status=guess
lin narrow_A = L.narrow_A ;
lin liberal_A = variants{} ; -- 
lin coal_N = mkN "carbone" feminine ; -- status=guess
lin priority_N = variants{} ; -- 
lin wild_A = mkA "selvaggio" | mkA "selvatico" ; -- status=guess status=guess
lin revenue_N = mkN "reddito" ; -- status=guess
lin membership_N = variants{} ; -- 
lin grant_N = variants{} ; -- 
lin approve_V2 = mkV2 (mkV "approvare") ; -- status=guess, src=wikt
lin approve_V = mkV "approvare" ; -- status=guess, src=wikt
lin tall_A = mkA "alto" ; -- status=guess
lin apparent_A = mkA "evidente" ; -- status=guess
lin faith_N = mkN "fede" feminine ; -- status=guess
lin under_Adv = mkAdv "sotto voce" | mkAdv "a bassa voce" ; -- status=guess status=guess
lin fix_V2 = mkV2 (mkV "aggiustare") ; -- status=guess, src=wikt
lin fix_V = mkV "aggiustare" ; -- status=guess, src=wikt
lin slow_A = mkA "lento" | mkA "lenta" ; -- status=guess status=guess
lin troop_N = variants{} ; -- 
lin motion_N = mkN "mozione" feminine | mkN "mozioni" feminine ; -- status=guess status=guess
lin leading_A = variants{} ; -- 
lin component_N = mkN "componente" masculine ; -- status=guess
lin bloody_A = mkA "cruento" | mkA "sanguinoso" ; -- status=guess status=guess
lin literature_N = mkN "letteratura" ; -- status=guess
lin conservative_A = variants{} ; -- 
lin variation_N = mkN "variazione" feminine ; -- status=guess
lin remind_V2 = mkV2 (mkV "ricordare") ; -- status=guess, src=wikt
lin inform_V2 = variants{} ; -- 
lin inform_V = variants{} ; -- 
lin alternative_N = mkN "alternativa" ; -- status=guess
lin neither_Adv = mkAdv "né" ; -- status=guess
lin outside_Adv = mkAdv "fuori" ; -- status=guess
lin mass_N = mkN "massa" ; -- status=guess
lin busy_A = mkA "occupato" ; -- status=guess
lin chemical_N = mkN "composto chimico" ; -- status=guess
lin careful_A = mkA "prudente" | mkA "cauto" ; -- status=guess status=guess
lin investigate_V2 = mkV2 (mkV "investigare") ; -- status=guess, src=wikt
lin investigate_V = mkV "investigare" ; -- status=guess, src=wikt
lin roll_V2 = mkV2 (mkV (mkV "offrire") "un trattamento coi fiocchi") ; -- status=guess, src=wikt
lin roll_V = mkV (mkV "offrire") "un trattamento coi fiocchi" ; -- status=guess, src=wikt
lin instrument_N = mkN "strumento" ; -- status=guess
lin guide_N = mkN "guida" ; -- status=guess
lin criterion_N = mkN "criterio" ; -- status=guess
lin pocket_N = mkN "tasca" ; -- status=guess
lin suggestion_N = variants{} ; -- 
lin aye_Interj = variants{} ; -- 
lin entitle_VS = mkVS (mkV "intitolare") ; -- status=guess, src=wikt
lin entitle_V2V = mkV2V (mkV "intitolare") ; -- status=guess, src=wikt
lin tone_N = variants{} ; -- 
lin attractive_A = mkA "attraente" ; -- status=guess
lin wing_N = L.wing_N ;
lin surprise_N = mkN "sorpresa" ; -- status=guess
lin male_N = mkN "maschio" ; -- status=guess
lin ring_N = mkN "anello" ; -- status=guess
lin pub_N = mkN "pub" | mkN "osteria" ; -- status=guess status=guess
lin fruit_N = L.fruit_N ;
lin passage_N = mkN "corridoio" ; -- status=guess
lin illustrate_VS = mkVS (mkV "illustrare") ; -- status=guess, src=wikt
lin illustrate_V2 = mkV2 (mkV "illustrare") ; -- status=guess, src=wikt
lin illustrate_V = mkV "illustrare" ; -- status=guess, src=wikt
lin pay_N = variants{} ; -- 
lin ride_V2 = mkV2 (mkV "guidare") ;
lin ride_V = mkV "guidare" ;
lin foundation_N = mkN "fondazione" feminine ; -- status=guess
lin restaurant_N = L.restaurant_N ;
lin vital_A = mkA "vitale" ; -- status=guess
lin alternative_A = mkA "alternativo" ; -- status=guess
lin burn_V2 = mkV2 (mkV "bruciare") | mkV2 (ardere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin burn_V = L.burn_V ;
lin map_N = mkN "mappa" | mkN "carta" | mkN "carta geografica" ; -- status=guess status=guess status=guess
lin united_A = variants{} ; -- 
lin device_N = mkN "emblema" | mkN "coccarda" | mkN "motto" | mkN "inscrizione" feminine ; -- status=guess status=guess status=guess status=guess
lin jump_V2 = mkV2 (mkV "saltare") ; -- status=guess, src=wikt
lin jump_V = L.jump_V ;
lin estimate_VS = mkVS (mkV "stimare") ; -- status=guess, src=wikt
lin estimate_V2V = mkV2V (mkV "stimare") ; -- status=guess, src=wikt
lin estimate_V2 = mkV2 (mkV "stimare") ; -- status=guess, src=wikt
lin estimate_V = mkV "stimare" ; -- status=guess, src=wikt
lin conduct_V2 = mkV2 (mkV "comportarsi") ; -- status=guess, src=wikt
lin conduct_V = mkV "comportarsi" ; -- status=guess, src=wikt
lin derive_V2 = variants{} ; -- 
lin derive_V = variants{} ; -- 
lin comment_VS = variants{} ; -- 
lin comment_V2 = variants{} ; -- 
lin comment_V = variants{} ; -- 
lin east_N = mkN "est" masculine | mkN "oriente" | mkN "levante" masculine ; -- status=guess status=guess status=guess
lin advise_VS = mkVS (mkV "consigliare") | mkVS (mkV "raccomandare") | mkVS (mkV "consultarsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin advise_V2 = mkV2 (mkV "consigliare") | mkV2 (mkV "raccomandare") | mkV2 (mkV "consultarsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin advise_V = mkV "consigliare" | mkV "raccomandare" | mkV "consultarsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin advance_N = mkN "avanzo" ; -- status=guess
lin motor_N = mkN "motore" | mkN "macchina" ; -- status=guess status=guess
lin satisfy_V2 = mkV2 (soddisfare_V) | mkV2 (mkV "accontentare") ; -- status=guess, src=wikt status=guess, src=wikt
lin hell_N = mkN "inferno" ; -- status=guess
lin winner_N = mkN "vincitore" | mkN "vincitrice" feminine ; -- status=guess status=guess
lin effectively_Adv = variants{} ; -- 
lin mistake_N = mkN "errore" masculine | mkN "sbaglio" ; -- status=guess status=guess
lin incident_N = variants{} ; -- 
lin focus_V2 = mkV2 (mkV "concentrarsi") ; -- status=guess, src=wikt
lin focus_V = mkV "concentrarsi" ; -- status=guess, src=wikt
lin exercise_VV = mkVV (mkV "esercitare") ; -- status=guess, src=wikt
lin exercise_V2 = mkV2 (mkV "esercitare") ; -- status=guess, src=wikt
lin exercise_V = mkV "esercitare" ; -- status=guess, src=wikt
lin representation_N = variants{} ; -- 
lin release_N = mkN "versione" feminine ; -- status=guess
lin leaf_N = L.leaf_N ;
lin border_N = mkN "orlo" ; -- status=guess
lin wash_V2 = L.wash_V2 ;
lin wash_V = mkV (mkV "lavarsene") "le mani" ; -- status=guess, src=wikt
lin prospect_N = variants{} ; -- 
lin blow_V2 = mkV2 (mkV "soffiare") ; -- status=guess, src=wikt
lin blow_V = L.blow_V ;
lin trip_N = mkN "viaggio" | mkN "gita" ; -- status=guess status=guess
lin observation_N = variants{} ; -- 
lin gather_V2 = mkV2 (mkV "raccogliersi") ; -- status=guess, src=wikt
lin gather_V = mkV "raccogliersi" ; -- status=guess, src=wikt
lin ancient_A = mkA "antico" ; -- status=guess
lin brief_A = mkA "breve" ; -- status=guess
lin gate_N = mkN "cancello" ; -- status=guess
lin elderly_A = variants{} ; -- 
lin persuade_V2V = mkV2V (persuadere_V) ; -- status=guess, src=wikt
lin persuade_V2 = mkV2 (persuadere_V) ; -- status=guess, src=wikt
lin overall_A = variants{} ; -- 
lin rare_A = mkA "al sangue" ; -- status=guess
lin index_N = mkN "indice" masculine ; -- status=guess
lin hand_V2 = mkV2 (dare_V) | mkV2 (mkV "passare") ; -- status=guess, src=wikt status=guess, src=wikt
lin circle_N = mkN "curva" ; -- status=guess
lin creation_N = mkN "creazione" feminine ; -- status=guess
lin drawing_N = mkN "disegno" ; -- status=guess
lin anybody_NP = variants{} ; -- 
lin flow_N = mkN "flusso" ; -- status=guess
lin matter_V = mkV "importare" | mkV "contare" ; -- status=guess, src=wikt status=guess, src=wikt
lin external_A = variants{} ; -- 
lin capable_A = mkA "capace" ; -- status=guess
lin recover_V = mkV "ritrovare" ; -- status=guess, src=wikt
lin shot_N = mkN "tiro" ; -- status=guess
lin request_N = mkN "richiesta" ; -- status=guess
lin impression_N = variants{} ; -- 
lin neighbour_N = mkN "vicino" | mkN "vicina" ; -- status=guess status=guess
lin theatre_N = variants{} ; -- 
lin beneath_Prep = variants{} ; -- 
lin hurt_V2 = mkV2 (dolere_V) | mkV2 (mkV (I.fare_V) "male") ; -- status=guess, src=wikt status=guess, src=wikt
lin hurt_V = dolere_V | mkV (I.fare_V) "male" ; -- status=guess, src=wikt status=guess, src=wikt
lin mechanism_N = variants{} ; -- 
lin potential_N = variants{} ; -- 
lin lean_V2 = mkV2 (mkV "sporgersi") ; -- status=guess, src=wikt
lin lean_V = mkV "sporgersi" ; -- status=guess, src=wikt
lin defendant_N = variants{} ; -- 
lin atmosphere_N = variants{} ; -- 
lin slip_V2 = variants{} ; -- 
lin slip_V = variants{} ; -- 
lin chain_N = mkN "cotta di maglia" ; -- status=guess
lin accompany_V2 = mkV2 (mkV "accompagnare") ; -- status=guess, src=wikt
lin wonderful_A = mkA "meraviglioso" ; -- status=guess
lin earn_V2 = mkV2 (mkV "guadagnare") ; -- status=guess, src=wikt
lin earn_V = mkV "guadagnare" ; -- status=guess, src=wikt
lin enemy_N = L.enemy_N ;
lin desk_N = mkN "scrivania" ; -- status=guess
lin engineering_N = mkN "ingegneria" ; -- status=guess
lin panel_N = mkN "pannello" ; -- status=guess
lin distinction_N = mkN "distinzione" ;
lin deputy_N = mkN "deputato" ; -- status=guess
lin discipline_N = mkN "disciplina" ;
lin strike_N = mkN "sciopero" ;
lin strike_2_N = mkN "attacco" ;
lin strike_1_N = mkN "sciopero" ;
lin married_A = mkA "sposato" ;
lin plenty_NP = variants{} ; -- 
lin establishment_N = variants{} ; -- 
lin fashion_N = mkN "moda" | mkN "voga" ; -- status=guess status=guess
lin roof_N = L.roof_N ;
lin milk_N = L.milk_N ;
lin entire_A = mkA "intero" | mkA "intera" ; -- status=guess status=guess
lin tear_N = mkN "lacrima" ; -- status=guess
lin secondary_A = variants{} ; -- 
lin finding_N = mkN "riscontro" | mkN "risultato" ; -- status=guess status=guess
lin welfare_N = variants{} ; -- 
lin increased_A = variants{} ; -- 
lin attach_V2 = mkV2 (mkV "legare") ; -- status=guess, src=wikt
lin attach_V = mkV "legare" ; -- status=guess, src=wikt
lin typical_A = variants{} ; -- 
lin typical_3_A = variants{} ; -- 
lin typical_2_A = variants{} ; -- 
lin typical_1_A = variants{} ; -- 
lin meanwhile_Adv = mkAdv "intanto" | mkAdv "nel frattempo" ; -- status=guess status=guess
lin leadership_N = variants{} ; -- 
lin walk_N = mkN "camminata" ; -- status=guess
lin negotiation_N = mkN "negoziato" | mkN "negoziazione" feminine ; -- status=guess status=guess
lin clean_A = L.clean_A ;
lin religion_N = L.religion_N ;
lin count_V2 = L.count_V2 ;
lin count_V = mkV "contare" ; -- status=guess, src=wikt
lin grey_A = mkA "brizzolato" ; -- status=guess
lin hence_Adv = mkAdv "perciò" | mkAdv "dunque" | mkAdv "quindi" ; -- status=guess status=guess status=guess
lin alright_Adv = variants{} ; -- 
lin first_A = variants{} ; -- 
lin fuel_N = variants{} ; -- 
lin mine_N = mkN "mina" ; -- status=guess
lin appeal_V2 = variants{} ; -- 
lin appeal_V = variants{} ; -- 
lin servant_N = variants{} ; -- 
lin liability_N = mkN "responsabilità" feminine ; -- status=guess
lin constant_A = mkA "costante" ; -- status=guess
lin hate_VV = mkVV (mkV "odiare") ; -- status=guess, src=wikt
lin hate_V2 = L.hate_V2 ;
lin shoe_N = L.shoe_N ;
lin expense_N = variants{} ; -- 
lin vast_A = mkA "ampio" | mkA "ampia" | mkA "vasto" | mkA "esteso" ; -- status=guess status=guess status=guess status=guess
lin soil_N = mkN "terreno" ; -- status=guess
lin writing_N = mkN "blocco" ; -- status=guess
lin nose_N = L.nose_N ;
lin origin_N = mkN "origine" feminine ; -- status=guess
lin lord_N = mkN "signore" masculine ; -- status=guess
lin rest_V2 = mkV2 (mkV "riposarsi") | mkV2 (mkV "riposare") ; -- status=guess, src=wikt status=guess, src=wikt
lin drive_N = variants{} ; -- 
lin ticket_N = mkN "biglietto" ; -- status=guess
lin editor_N = mkN "giuntatrice" feminine ; -- status=guess
lin switch_V2 = variants{} ; -- 
lin switch_V = variants{} ; -- 
lin provided_Subj = variants{} ; -- 
lin northern_A = mkA "settentrionale" | mkA "nordico" ; -- status=guess status=guess
lin significance_N = mkN "significanza" ; -- status=guess
lin channel_N = mkN "canale" masculine ; -- status=guess
lin convention_N = mkN "convenzione" feminine ; -- status=guess
lin damage_V2 = mkV2 (mkV "danneggiare") | mkV2 (mkV "rovinare") | mkV2 (mkV "macchiare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin funny_A = mkA "buffo" | mkA "buffa" | mkA "divertente" | mkA "esilarante" ; -- status=guess status=guess status=guess status=guess
lin bone_N = L.bone_N ;
lin severe_A = mkA "duro" | mkA "severo" | mkA "rigido" ; -- status=guess status=guess status=guess
lin search_V2 = mkV2 (mkV "buscare") | mkV2 (mkV "cercare") ; -- status=guess, src=wikt status=guess, src=wikt
lin search_V = mkV "buscare" | mkV "cercare" ; -- status=guess, src=wikt status=guess, src=wikt
lin iron_N = L.iron_N ;
lin vision_N = mkN "visione" feminine ; -- status=guess
lin via_Prep = variants{} ; -- 
lin somewhat_Adv = variants{} ; -- 
lin inside_Adv = mkAdv "a fondo" ; -- status=guess
lin trend_N = variants{} ; -- 
lin revolution_N = mkN "rivoluzione" feminine ; -- status=guess
lin terrible_A = mkA "terribile" ; -- status=guess
lin knee_N = L.knee_N ;
lin dress_N = mkN "abbigliamento" ; -- status=guess
lin unfortunately_Adv = variants{} ; -- 
lin steal_V2 = mkV2 (mkV (mkV "rubare") "la scena") ; -- status=guess, src=wikt
lin steal_V = mkV (mkV "rubare") "la scena" ; -- status=guess, src=wikt
lin criminal_A = mkA "criminale" | mkA "delittuoso" ; -- status=guess status=guess
lin signal_N = mkN "segnale" masculine ; -- status=guess
lin notion_N = variants{} ; -- 
lin comparison_N = mkN "comparazione" feminine ; -- status=guess
lin academic_A = mkA "accademico" ; -- status=guess
lin outcome_N = variants{} ; -- 
lin lawyer_N = mkN "avvocato" | mkN "legale" feminine ; -- status=guess status=guess
lin strongly_Adv = variants{} ; -- 
lin surround_V2 = mkV2 (mkV "circondare") ; -- status=guess, src=wikt
lin explore_VS = mkVS (mkV "esplorare") ; -- status=guess, src=wikt
lin explore_V2 = mkV2 (mkV "esplorare") ; -- status=guess, src=wikt
lin achievement_N = mkN "realizzazione" feminine ; -- status=guess
lin odd_A = mkA "dispari" ; -- status=guess
lin expectation_N = mkN "attesa" ; -- status=guess
lin corporate_A = variants{} ; -- 
lin prisoner_N = mkN "prigioniero" ; -- status=guess
lin question_V2 = variants{} ; -- 
lin rapidly_Adv = variants{} ; -- 
lin deep_Adv = variants{} ; -- 
lin southern_A = mkA "meridionale" ; -- status=guess
lin amongst_Prep = variants{} ; -- 
lin withdraw_V2 = mkV2 (mkV "prelevare") ; -- status=guess, src=wikt
lin withdraw_V = mkV "prelevare" ; -- status=guess, src=wikt
lin afterwards_Adv = mkAdv "dopo" ; -- status=guess
lin paint_V2 = mkV2 (mkV "verniciare") ; -- status=guess, src=wikt
lin paint_V = mkV "verniciare" ; -- status=guess, src=wikt
lin judge_VS = mkVS (mkV "giudicare") ; -- status=guess, src=wikt
lin judge_V2 = mkV2 (mkV "giudicare") ; -- status=guess, src=wikt
lin judge_V = mkV "giudicare" ; -- status=guess, src=wikt
lin citizen_N = variants{} ; -- 
lin permanent_A = mkA "permanente" ; -- status=guess
lin weak_A = mkA "debole" ; -- status=guess
lin separate_V2 = mkV2 (mkV "separare") ; -- status=guess, src=wikt
lin separate_V = mkV "separare" ; -- status=guess, src=wikt
lin plastic_N = L.plastic_N ;
lin connect_V2 = variants{} ; -- 
lin connect_V = variants{} ; -- 
lin fundamental_A = mkA "fondamentale" ; -- status=guess
lin plane_N = mkN "pialla" | mkN "piallatrice" feminine ; -- status=guess status=guess
lin height_N = mkN "altezza" ; -- status=guess
lin opening_N = mkN "apertura" ; -- status=guess
lin lesson_N = mkN "lezione" feminine ; -- status=guess
lin similarly_Adv = variants{} ; -- 
lin shock_N = mkN "ammortizzatore" ; -- status=guess
lin rail_N = mkN "asta divisoria" | mkN "divisorio" | mkN "barra" ; -- status=guess status=guess status=guess
lin tenant_N = mkN "inquilino" | mkN "locatario" ; -- status=guess status=guess
lin owe_V2 = mkV2 (dovere_V) ; -- status=guess, src=wikt
lin owe_V = dovere_V ; -- status=guess, src=wikt
lin originally_Adv = variants{} ; -- 
lin middle_A = mkA "medio" ; -- status=guess
lin somehow_Adv = variants{} ; -- 
lin minor_A = mkA "minore" ; -- status=guess
lin negative_A = mkA "negativo" ; -- status=guess
lin knock_V2 = mkV2 (mkV "trincare") ; -- status=guess, src=wikt
lin knock_V = mkV "trincare" ; -- status=guess, src=wikt
lin root_N = L.root_N ;
lin pursue_V2 = mkV2 (mkV "perseguitare") | mkV2 (mkV "tormentare") | mkV2 (mkV "inseguire") | mkV2 (mkV "cercare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pursue_V = mkV "perseguitare" | mkV "tormentare" | mkV "inseguire" | mkV "cercare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin inner_A = mkA "interno" ; -- status=guess
lin crucial_A = mkA "cruciforme" ; -- status=guess
lin occupy_V2 = mkV2 (mkV "occupare") ; -- status=guess, src=wikt
lin occupy_V = mkV "occupare" ; -- status=guess, src=wikt
lin that_AdA = variants{} ; -- 
lin independence_N = mkN "indipendenza" ; -- status=guess
lin column_N = mkN "colonna" ; -- status=guess
lin proceeding_N = variants{} ; -- 
lin female_N = mkN "femmina" ; -- status=guess
lin beauty_N = mkN "bellezza" ; -- status=guess
lin perfectly_Adv = variants{} ; -- 
lin struggle_N = mkN "lotta" ; -- status=guess
lin gap_N = variants{} ; -- 
lin house_V2 = mkV2 (mkV "alloggiare") ; -- status=guess, src=wikt
lin database_N = mkN "database" | mkN "base di dati" ; -- status=guess status=guess
lin stretch_V2 = mkV2 (mkV "tendere") ; -- status=guess, src=wikt
lin stretch_V = mkV "tendere" ; -- status=guess, src=wikt
lin stress_N = mkN "stress" | mkN "pressione" feminine ; -- status=guess status=guess
lin passenger_N = mkN "passeggero" ; -- status=guess
lin boundary_N = mkN "confine" masculine | mkN "limite" masculine ; -- status=guess status=guess
lin easy_Adv = variants{} ; -- 
lin view_V2 = mkV2 (mkV "guardare") ; -- status=guess, src=wikt
lin manufacturer_N = variants{} ; -- 
lin sharp_A = L.sharp_A ;
lin formation_N = variants{} ; -- 
lin queen_N = L.queen_N ;
lin waste_N = mkN "decadenza" ; -- status=guess
lin virtually_Adv = variants{} ; -- 
lin expand_V2 = variants{} ; -- 
lin expand_V = variants{} ; -- 
lin contemporary_A = mkA "contemporaneo" ; -- status=guess
lin politician_N = mkN "politico" ; -- status=guess
lin back_V = mkV (I.fare_V) "retromarcia" | mkV (I.fare_V) "marcia indietro" | retrocedere_V | mkV "indietreggiare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin territory_N = mkN "territorio" ; -- status=guess
lin championship_N = mkN "campionato" ; -- status=guess
lin exception_N = mkN "eccezione" feminine ; -- status=guess
lin thick_A = L.thick_A ;
lin inquiry_N = variants{} ; -- 
lin topic_N = mkN "tema" masculine ; -- status=guess
lin resident_N = mkN "residente" masculine ; -- status=guess
lin transaction_N = mkN "transazione" feminine ; -- status=guess
lin parish_N = mkN "comune" masculine ; -- status=guess
lin supporter_N = mkN "promotore" | mkN "fautore" | mkN "aderente" masculine ; -- status=guess status=guess status=guess
lin massive_A = mkA "massiccio" ; -- status=guess
lin light_V2 = mkV2 (mkV "illuminare") ; -- status=guess, src=wikt
lin light_V = mkV "illuminare" ; -- status=guess, src=wikt
lin unique_A = mkA "unico" | mkA "unica" ; -- status=guess status=guess
lin challenge_V2 = variants{} ; -- 
lin challenge_V = variants{} ; -- 
lin inflation_N = mkN "inflazione" feminine ; -- status=guess
lin assistance_N = mkN "assistenza" ; -- status=guess
lin list_V2V = variants{} ; -- 
lin list_V2 = variants{} ; -- 
lin list_V = variants{} ; -- 
lin identity_N = mkN "identità" feminine ; -- status=guess
lin suit_V2 = variants{} ; -- 
lin suit_V = variants{} ; -- 
lin parliamentary_A = variants{} ; -- 
lin unknown_A = mkA "ignoto" | mkA "sconosciuto" ; -- status=guess status=guess
lin preparation_N = mkN "preparazione" feminine ; -- status=guess
lin elect_V3 = mkV3 (eleggere_V) ; -- status=guess, src=wikt
lin elect_V2V = mkV2V (eleggere_V) ; -- status=guess, src=wikt
lin elect_V2 = mkV2 (eleggere_V) ; -- status=guess, src=wikt
lin elect_V = eleggere_V ; -- status=guess, src=wikt
lin badly_Adv = variants{} ; -- 
lin moreover_Adv = mkAdv "inoltre" ; -- status=guess
lin tie_V2 = L.tie_V2 ;
lin tie_V = mkV "legare" ; -- status=guess, src=wikt
lin cancer_N = mkN "cancro" ; -- status=guess
lin champion_N = mkN "campione" masculine | mkN "campionessa" ; -- status=guess status=guess
lin exclude_V2 = variants{} ; -- 
lin review_V2 = mkV2 (mkV "rivisitare") | mkV2 (mkV (dare_V) "uno sguardo") | mkV2 (rivedere_V) | mkV2 (mkV "riguardare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin review_V = mkV "rivisitare" | mkV (dare_V) "uno sguardo" | rivedere_V | mkV "riguardare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin licence_N = variants{} ; -- 
lin breakfast_N = mkN "colazione" feminine | mkN "prima colazione" feminine ; -- status=guess status=guess
lin minority_N = variants{} ; -- 
lin appreciate_V2 = mkV2 (mkV "capire") | mkV2 (mkV (mkV "rendersi") "conto") ; -- status=guess, src=wikt status=guess, src=wikt
lin appreciate_V = mkV "capire" | mkV (mkV "rendersi") "conto" ; -- status=guess, src=wikt status=guess, src=wikt
lin fan_N = variants{} ; -- 
lin fan_3_N = variants{} ; -- 
lin fan_2_N = variants{} ; -- 
lin fan_1_N = variants{} ; -- 
lin chief_N = mkN "amministratore delegato" ; -- status=guess
lin accommodation_N = mkN "sistemazione" feminine | mkN "alloggio" ; -- status=guess status=guess
lin subsequent_A = mkA "successivo" | mkA "ulteriore" | mkA "susseguente" ; -- status=guess status=guess status=guess
lin democracy_N = mkN "democrazia" ; -- status=guess
lin brown_A = L.brown_A ;
lin taste_N = mkN "gusto" | mkN "inclinazione" feminine ; -- status=guess status=guess
lin crown_N = mkN "corona" ; -- status=guess
lin permit_V2V = variants{} ; -- 
lin permit_V2 = variants{} ; -- 
lin permit_V = variants{} ; -- 
lin buyer_N = variants{} ; -- 
lin gift_N = mkN "dono" | mkN "talento" ; -- status=guess status=guess
lin resolution_N = mkN "risoluzione" feminine ; -- status=guess
lin angry_A = mkA "arrabbiato" ; -- status=guess
lin metre_N = mkN "metro" ; -- status=guess
lin wheel_N = mkN "ruota" ; -- status=guess
lin clause_N = variants{} ; -- 
lin break_N = mkN "pausa" ; -- status=guess
lin tank_N = mkN "tanica" | mkN "serbatoio" | mkN "bombola" ; -- status=guess status=guess status=guess
lin benefit_V2 = variants{} ; -- 
lin benefit_V = variants{} ; -- 
lin engage_V2 = variants{} ; -- 
lin engage_V = variants{} ; -- 
lin alive_A = mkA "vivo e vegeto" ; -- status=guess
lin complaint_N = mkN "disturbo" ; -- status=guess
lin inch_N = mkN "pollice" masculine ; -- status=guess
lin firm_A = mkA "ferreo" ; -- status=guess
lin abandon_V2 = mkV2 (mkV "bandire") ; -- status=guess, src=wikt
lin blame_V2 = mkV2 (mkV "incolpare") | mkV2 (mkV "biasimare") ; -- status=guess, src=wikt status=guess, src=wikt
lin blame_V = mkV "incolpare" | mkV "biasimare" ; -- status=guess, src=wikt status=guess, src=wikt
lin clean_V2 = mkV2 (mkV "pulire") ; -- status=guess, src=wikt
lin clean_V = mkV "pulire" ; -- status=guess, src=wikt
lin quote_V2 = variants{} ; -- 
lin quote_V = variants{} ; -- 
lin quantity_N = mkN "grandezza" ; -- status=guess
lin rule_VS = mkVS (mkV "comandare") ; -- status=guess, src=wikt
lin rule_V2 = mkV2 (mkV "comandare") ; -- status=guess, src=wikt
lin rule_V = mkV "comandare" ; -- status=guess, src=wikt
lin guilty_A = mkA "colpevole" ; -- status=guess
lin prior_A = variants{} ; -- 
lin round_A = L.round_A ;
lin eastern_A = variants{} ; -- 
lin coat_N = L.coat_N ;
lin involvement_N = variants{} ; -- 
lin tension_N = mkN "tensione" feminine ; -- status=guess
lin diet_N = mkN "dieta" ; -- status=guess
lin enormous_A = variants{} ; -- 
lin score_N = mkN "spartito" ; -- status=guess
lin rarely_Adv = variants{} ; -- 
lin prize_N = mkN "premio" ; -- status=guess
lin remaining_A = variants{} ; -- 
lin significantly_Adv = variants{} ; -- 
lin glance_V2 = mkV2 (mkV (dare_V) "un'occhiata") ; -- status=guess, src=wikt
lin glance_V = mkV (dare_V) "un'occhiata" ; -- status=guess, src=wikt
lin dominate_V2 = variants{} ; -- 
lin dominate_V = variants{} ; -- 
lin trust_VS = mkVS (mkV "fidare") | mkVS (mkV (avere_V) "fiducia") ; -- status=guess, src=wikt status=guess, src=wikt
lin trust_V2 = mkV2 (mkV "fidare") | mkV2 (mkV (avere_V) "fiducia") ; -- status=guess, src=wikt status=guess, src=wikt
lin naturally_Adv = variants{} ; -- 
lin interpret_V2 = mkV2 (mkV "interpretare") ; -- status=guess, src=wikt
lin interpret_V = mkV "interpretare" ; -- status=guess, src=wikt
lin land_V2 = variants{} ; -- 
lin land_V = variants{} ; -- 
lin frame_N = mkN "contafotogrammi" ; -- status=guess
lin extension_N = variants{} ; -- 
lin mix_V2 = mkV2 (mkV "mixare") ; -- status=guess, src=wikt
lin mix_V = mkV "mixare" ; -- status=guess, src=wikt
lin spokesman_N = mkN "portavoce" masculine ; -- status=guess
lin friendly_A = variants{} ; -- 
lin acknowledge_VS = mkVS (riconoscere_V) | mkVS (ammettere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin acknowledge_V2 = mkV2 (riconoscere_V) | mkV2 (ammettere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin register_V2 = mkV2 (mkV "registrare") ; -- status=guess, src=wikt
lin register_V = mkV "registrare" ; -- status=guess, src=wikt
lin regime_N = variants{} ; -- 
lin regime_2_N = variants{} ; -- 
lin regime_1_N = variants{} ; -- 
lin fault_N = mkN "sbaglio" ; -- status=guess
lin dispute_N = mkN "disputa" | mkN "lite" | mkN "bega" ; -- status=guess status=guess status=guess
lin grass_N = L.grass_N ;
lin quietly_Adv = variants{} ; -- 
lin decline_N = mkN "declino" ; -- status=guess
lin dismiss_V2 = mkV2 (mkV "licenziare") | mkV2 (mkV "congedare") | mkV2 (mkV (mkV "mandare") "via") | mkV2 (dimettere_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin delivery_N = mkN "consegna" ; -- status=guess
lin complain_VS = mkVS (mkV "lamentarsi") | mkVS (mkV "lagnarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin complain_V = mkV "lamentarsi" | mkV "lagnarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin conservative_N = variants{} ; -- 
lin shift_V2 = variants{} ; -- 
lin shift_V = variants{} ; -- 
lin port_N = mkN "porto" ; -- status=guess
lin beach_N = mkN "spiaggia" ; -- status=guess
lin string_N = mkN "corda" ; -- status=guess
lin depth_N = mkN "profondità" feminine ; -- status=guess
lin unusual_A = mkA "insolito" | mkA "particolare" ; -- status=guess status=guess
lin travel_N = mkN "viaggio" ; -- status=guess
lin pilot_N = mkN "pilota" masculine ; -- status=guess
lin obligation_N = mkN "obbligo" ; -- status=guess
lin gene_N = mkN "gene" masculine ; -- status=guess
lin yellow_A = L.yellow_A ;
lin republic_N = mkN "repubblica" ; -- status=guess
lin shadow_N = mkN "ombra" ; -- status=guess
lin dear_A = mkA "caro" | mkA "costoso" ; -- status=guess status=guess
lin analyse_V2 = variants{} ; -- 
lin anywhere_Adv = mkAdv "dovunque" ; -- status=guess
lin average_N = mkN "media" ; -- status=guess
lin phrase_N = mkN "libro di fraseologia" | mkN "frasario" ; -- status=guess status=guess
lin long_term_A = variants{} ; -- 
lin crew_N = mkN "folla" | mkN "gente" feminine ; -- status=guess status=guess
lin lucky_A = mkA "fortunato" | mkA "fortunata" ; -- status=guess status=guess
lin restore_V2 = mkV2 (mkV "riportare") | mkV2 (rimettere_V) | mkV2 (mkV "ristabilire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin convince_V2V = mkV2V (convincere_V) ; -- status=guess, src=wikt
lin convince_V2 = mkV2 (convincere_V) ; -- status=guess, src=wikt
lin coast_N = mkN "costa" | mkN "costiera" | mkN "litorale" ; -- status=guess status=guess status=guess
lin engineer_N = mkN "macchinista" masculine ; -- status=guess
lin heavily_Adv = variants{} ; -- 
lin extensive_A = mkA "vasto" ; -- status=guess
lin glad_A = mkA "fiero" | mkA "soddisfatto" | mkA "lieto" ; -- status=guess status=guess status=guess
lin charity_N = mkN "carità" feminine ; -- status=guess
lin oppose_V2 = mkV2 (opporre_V) ; -- status=guess, src=wikt
lin oppose_V = opporre_V ; -- status=guess, src=wikt
lin defend_V2 = mkV2 (mkV "difendere") ; -- status=guess, src=wikt
lin alter_V2 = mkV2 (mkV "cambiare") ; -- status=guess, src=wikt
lin alter_V = mkV "cambiare" ; -- status=guess, src=wikt
lin warning_N = variants{} ; -- 
lin arrest_V2 = mkV2 (mkV "arrestare") ; -- status=guess, src=wikt
lin framework_N = mkN "infrastruttura" ; -- status=guess
lin approval_N = mkN "approvazione" feminine ; -- status=guess
lin bother_VV = mkVV (mkV "disturbarsi") | mkVV (mkV (mkV "prendersi") "la briga") | mkVV (mkV "preoccuparsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin bother_V2V = mkV2V (mkV "disturbarsi") | mkV2V (mkV (mkV "prendersi") "la briga") | mkV2V (mkV "preoccuparsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin bother_V2 = mkV2 (mkV "disturbarsi") | mkV2 (mkV (mkV "prendersi") "la briga") | mkV2 (mkV "preoccuparsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin bother_V = mkV "disturbarsi" | mkV (mkV "prendersi") "la briga" | mkV "preoccuparsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin novel_N = mkN "romanzo" ; -- status=guess
lin accuse_V2 = mkV2 (mkV "accusare") ; -- status=guess, src=wikt
lin surprised_A = variants{} ; -- 
lin currency_N = mkN "valuta" ; -- status=guess
lin restrict_V2 = mkV2 (restringere_V) ; -- status=guess, src=wikt
lin restrict_V = restringere_V ; -- status=guess, src=wikt
lin possess_V2 = mkV2 (possedere_V) ; -- status=guess, src=wikt
lin moral_A = mkA "morale" ; -- status=guess
lin protein_N = mkN "proteina" ; -- status=guess
lin distinguish_V2 = variants{} ; -- 
lin distinguish_V = variants{} ; -- 
lin gently_Adv = mkAdv "soavemente" | mkAdv "dolcemente" | mkAdv "blandamente" | mkAdv "delicatamente" | mkAdv "gentilmente" | mkAdv "sordamente" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin reckon_VS = variants{} ; -- 
lin incorporate_V2 = mkV2 (mkV "incorporare") ; -- status=guess, src=wikt
lin proceed_V = mkV "procedere" ; -- status=guess, src=wikt
lin assist_V2 = mkV2 (assistere_V) | mkV2 (mkV "aiutare") ; -- status=guess, src=wikt status=guess, src=wikt
lin assist_V = assistere_V | mkV "aiutare" ; -- status=guess, src=wikt status=guess, src=wikt
lin sure_Adv = variants{} ; -- 
lin stress_VS = variants{} ; -- 
lin stress_V2 = variants{} ; -- 
lin justify_VV = mkVV (mkV "giustificare") ; -- status=guess, src=wikt
lin justify_V2 = mkV2 (mkV "giustificare") ; -- status=guess, src=wikt
lin behalf_N = variants{} ; -- 
lin councillor_N = variants{} ; -- 
lin setting_N = mkN "contesto" ; -- status=guess
lin command_N = variants{} ; -- 
lin command_2_N = variants{} ; -- 
lin command_1_N = variants{} ; -- 
lin maintenance_N = mkN "manutenzione" feminine ; -- status=guess
lin stair_N = mkN "scala" ; -- status=guess
lin poem_N = mkN "poema" | mkN "poesia" ; -- status=guess status=guess
lin chest_N = mkN "cassettone" masculine | mkN "comò" ; -- status=guess status=guess
lin like_Adv = variants{}; -- mkPrep "come" ;
lin secret_N = mkN "segreto" ; -- status=guess
lin restriction_N = mkN "restrizione" feminine ; -- status=guess
lin efficient_A = mkA "efficiente" ; -- status=guess
lin suspect_VS = mkVS (mkV "sospettare") ; -- status=guess, src=wikt
lin suspect_V2 = mkV2 (mkV "sospettare") ; -- status=guess, src=wikt
lin hat_N = L.hat_N ;
lin tough_A = mkA "duro" ; -- status=guess
lin firmly_Adv = variants{} ; -- 
lin willing_A = mkA "disposto" ; -- status=guess
lin healthy_A = mkA "sano" ; -- status=guess
lin focus_N = variants{} ; -- 
lin construct_V2 = mkV2 (mkV "costruire") ; -- status=guess, src=wikt
lin occasionally_Adv = variants{} ; -- 
lin mode_N = mkN "moda" ; -- status=guess
lin saving_N = variants{} ; -- 
lin comfortable_A = mkA "comodo" ; -- status=guess
lin camp_N = mkN "campo" | mkN "accampamento" ; -- status=guess status=guess
lin trade_V2 = variants{} ; -- 
lin trade_V = variants{} ; -- 
lin export_N = mkN "esportazione" feminine ; -- status=guess
lin wake_V2 = mkV2 (mkV "risvegliarsi") ; -- status=guess, src=wikt
lin wake_V = mkV "risvegliarsi" ; -- status=guess, src=wikt
lin partnership_N = variants{} ; -- 
lin daily_A = mkA "quotidiano" | mkA "giornaliero" ; -- status=guess status=guess
lin abroad_Adv = mkAdv "all'estero" ; -- status=guess
lin profession_N = mkN "professione" feminine ; -- status=guess
lin load_N = mkN "un sacco m singular" ; -- status=guess
lin countryside_N = mkN "campagna" ; -- status=guess
lin boot_N = L.boot_N ;
lin mostly_Adv = mkAdv "soprattutto" ; -- status=guess
lin sudden_A = mkA "improvviso" | mkA "improvvisa" ; -- status=guess status=guess
lin implement_V2 = mkV2 (mkV (mettere_V) "in pratica") | mkV2 (mkV "attuare") | mkV2 (mkV "implementare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reputation_N = mkN "reputazione" feminine | mkN "rumore" masculine ; -- status=guess status=guess
lin print_V2 = mkV2 (mkV "stampare") ; -- status=guess, src=wikt
lin print_V = mkV "stampare" ; -- status=guess, src=wikt
lin calculate_VS = mkVS (mkV "calcolare") ; -- status=guess, src=wikt
lin calculate_V2 = mkV2 (mkV "calcolare") ; -- status=guess, src=wikt
lin calculate_V = mkV "calcolare" ; -- status=guess, src=wikt
lin keen_A = variants{} ; -- 
lin guess_VS = mkVS (mkV "indovinare") ; -- status=guess, src=wikt
lin guess_V2 = mkV2 (mkV "indovinare") ; -- status=guess, src=wikt
lin guess_V = mkV "indovinare" ; -- status=guess, src=wikt
lin recommendation_N = mkN "raccomandazione" feminine ; -- status=guess
lin autumn_N = mkN "autunno" ; -- status=guess
lin conventional_A = mkA "convenzionale" ; -- status=guess
lin cope_V = variants{} ; -- 
lin constitute_V2 = variants{} ; -- 
lin poll_N = mkN "sondaggio" | mkN "votazione" feminine | mkN "scrutinio" ; -- status=guess status=guess status=guess
lin voluntary_A = variants{} ; -- 
lin valuable_A = mkA "prezioso" ; -- status=guess
lin recovery_N = mkN "recupero" ; -- status=guess
lin cast_V2 = mkV2 (mkV (mkV "prova") "del nove") ; -- status=guess, src=wikt
lin cast_V = mkV (mkV "prova") "del nove" ; -- status=guess, src=wikt
lin premise_N = mkN "premessa" ; -- status=guess
lin resolve_V2 = mkV2 (risolvere_V) ; -- status=guess, src=wikt
lin resolve_V = risolvere_V ; -- status=guess, src=wikt
lin regularly_Adv = variants{} ; -- 
lin solve_V2 = variants{} ; -- 
lin plaintiff_N = variants{} ; -- 
lin critic_N = variants{} ; -- 
lin agriculture_N = mkN "agricoltura" ; -- status=guess
lin ice_N = L.ice_N ;
lin constitution_N = mkN "costituzione" feminine ; -- status=guess
lin communist_N = mkN "comunista and" ; -- status=guess
lin layer_N = mkN "ovaiola" ; -- status=guess
lin recession_N = mkN "recessione" feminine ; -- status=guess
lin slight_A = mkA "insignificante" ; -- status=guess
lin dramatic_A = variants{} ; -- 
lin golden_A = mkA "d'oro" ; -- status=guess
lin temporary_A = mkA "temporaneo" ; -- status=guess
lin suit_N = mkN "seme" masculine ; -- status=guess
lin shortly_Adv = variants{} ; -- 
lin initially_Adv = variants{} ; -- 
lin arrival_N = mkN "arrivo" feminine ; -- status=guess
lin protest_N = mkN "protesta" ; -- status=guess
lin resistance_N = mkN "resistenza" ; -- status=guess
lin silent_A = variants{} ; -- 
lin presentation_N = mkN "presentazione" feminine ; -- status=guess
lin soul_N = mkN "anima" ; -- status=guess
lin self_N = mkN "stesso" ; -- status=guess
lin judgment_N = mkN "giuizio" ; -- status=guess
lin feed_V2 = mkV2 (mkV "nutrirsi") | mkV2 (mkV "cibarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin feed_V = mkV "nutrirsi" | mkV "cibarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin muscle_N = mkN "muscolo" ; -- status=guess
lin shareholder_N = mkN "azionista" ; -- status=guess
lin opposite_A = mkA "opposto" ; -- status=guess
lin pollution_N = mkN "sostanza inquinante" | mkN "inquinante" masculine ; -- status=guess status=guess
lin wealth_N = mkN "abbondanza" ; -- status=guess
lin video_taped_A = variants{} ; -- 
lin kingdom_N = mkN "regno" ; -- status=guess
lin bread_N = L.bread_N ;
lin perspective_N = mkN "prospettiva" ; -- status=guess
lin camera_N = L.camera_N ;
lin prince_N = mkN "principe" masculine ; -- status=guess
lin illness_N = mkN "malattia" ; -- status=guess
lin cake_N = mkN "torta" | mkN "pasticcino" | mkN "dolce" masculine ; --- split
lin meat_N = L.meat_N ;
lin submit_V2 = mkV2 (sottomettere_V) ; -- status=guess, src=wikt
lin submit_V = sottomettere_V ; -- status=guess, src=wikt
lin ideal_A = mkA "ideale" ; -- status=guess
lin relax_V2 = mkV2 (mkV "rilassare") ; -- status=guess, src=wikt
lin relax_V = mkV "rilassare" ; -- status=guess, src=wikt
lin penalty_N = mkN "calcio di rigore" | mkN "rigore" masculine ; -- status=guess status=guess
lin purchase_V2 = mkV2 (mkV "comprare") ; -- status=guess, src=wikt
lin tired_A = variants{} ; -- 
lin beer_N = L.beer_N ;
lin specify_VS = variants{} ; -- 
lin specify_V2 = variants{} ; -- 
lin specify_V = variants{} ; -- 
lin short_Adv = variants{} ; -- 
lin monitor_V2 = mkV2 (mkV "monitorare") | mkV2 (mkV "supervisionare") ; -- status=guess, src=wikt status=guess, src=wikt
lin monitor_V = mkV "monitorare" | mkV "supervisionare" ; -- status=guess, src=wikt status=guess, src=wikt
lin electricity_N = mkN "elettricità" feminine ; -- status=guess
lin specifically_Adv = variants{} ; -- 
lin bond_N = variants{} ; -- 
lin statutory_A = variants{} ; -- 
lin laboratory_N = mkN "laboratorio" ; -- status=guess
lin federal_A = variants{} ; -- 
lin captain_N = mkN "capitano di vascello" ; -- status=guess
lin deeply_Adv = variants{} ; -- 
lin pour_V2 = mkV2 (mkV "versare") ; -- status=guess, src=wikt
lin pour_V = mkV "versare" ; -- status=guess, src=wikt
lin boss_N = L.boss_N ;
lin creature_N = mkN "creatura" ; -- status=guess
lin urge_VS = mkVS (mkV "esortare") ; -- status=guess, src=wikt
lin urge_V2V = mkV2V (mkV "esortare") ; -- status=guess, src=wikt
lin urge_V2 = mkV2 (mkV "esortare") ; -- status=guess, src=wikt
lin locate_V2 = variants{} ; -- 
lin locate_V = variants{} ; -- 
lin being_N = mkN "essere" | mkN "creatura" ; -- status=guess status=guess
lin struggle_VV = mkVV (mkV "lottare") ; -- status=guess, src=wikt
lin struggle_V = mkV "lottare" ; -- status=guess, src=wikt
lin lifespan_N = variants{} ; -- 
lin flat_A = mkA "piano" ; -- status=guess
lin valley_N = mkN "valle" feminine ; -- status=guess
lin like_A = mkA "simile" ; -- status=guess
lin guard_N = mkN "protezione" feminine ; -- status=guess
lin emergency_N = mkN "emergenza" ; -- status=guess
lin dark_N = mkN "oscurità" feminine | mkN "tenebra" ; -- status=guess status=guess
lin bomb_N = mkN "bomba" ; -- status=guess
lin dollar_N = mkN "dollaro" ; -- status=guess
lin efficiency_N = mkN "efficienza" ; -- status=guess
lin mood_N = mkN "cattivo umore" ; -- status=guess
lin convert_V2 = mkV2 (mkV "convertire") ; -- status=guess, src=wikt
lin convert_V = mkV "convertire" ; -- status=guess, src=wikt
lin possession_N = mkN "possesso" ; -- status=guess
lin marketing_N = variants{} ; -- 
lin please_VV = mkVV (mkV "accontentare") | mkVV (piacere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2V = mkV2V (mkV "accontentare") | mkV2V (piacere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2 = mkV2 (mkV "accontentare") | mkV2 (piacere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V = mkV "accontentare" | piacere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin habit_N = mkN "abitudine" feminine ; -- status=guess
lin subsequently_Adv = variants{} ; -- 
lin round_N = mkN "angolo giro" ; -- status=guess
lin purchase_N = mkN "compra" | mkN "acquisto" ; -- status=guess status=guess
lin sort_V2 = mkV2 (mkV (mettere_V) "in ordine") ; -- status=guess, src=wikt
lin sort_V = mkV (mettere_V) "in ordine" ; -- status=guess, src=wikt
lin outside_A = variants{} ; -- 
lin gradually_Adv = variants{} ; -- 
lin expansion_N = mkN "espansione" feminine ; -- status=guess
lin competitive_A = variants{} ; -- 
lin cooperation_N = mkN "cooperazione" feminine ; -- status=guess
lin acceptable_A = mkA "accettabile" ; -- status=guess
lin angle_N = mkN "angolo" ; -- status=guess
lin cook_V2 = mkV2 (cuocere_V) ; -- status=guess, src=wikt
lin cook_V = cuocere_V ; -- status=guess, src=wikt
lin net_A = mkA "finale" ; -- status=guess
lin sensitive_A = mkA "sensibile" ; -- status=guess
lin ratio_N = mkN "ragione" feminine | mkN "rapporto" ; -- status=guess status=guess
lin kiss_V2 = mkV2 (mkV "baciarsi") ; -- status=guess, src=wikt
lin amount_V = mkV "ammontare" ; -- status=guess, src=wikt
lin sleep_N = mkN "apnea notturna" | mkN "apnea nell sonno" ; -- status=guess status=guess
lin finance_V2 = mkV2 (mkV "finanziare") ; -- status=guess, src=wikt
lin essentially_Adv = variants{} ; -- 
lin fund_V2 = mkV2 (mkV "finanziare") ; -- status=guess, src=wikt
lin preserve_V2 = mkV2 (mkV "preservare") ; -- status=guess, src=wikt
lin wedding_N = mkN "matrimonio" | mkN "nozze" feminine | mkN "sposalizio" ; -- status=guess status=guess status=guess
lin personality_N = mkN "personalità" feminine ; -- status=guess
lin bishop_N = mkN "alfiere" masculine ; -- status=guess
lin dependent_A = variants{} ; -- 
lin landscape_N = mkN "orizzontale" ; -- status=guess
lin pure_A = mkA "puro" ; -- status=guess
lin mirror_N = mkN "specchio" ; -- status=guess
lin lock_V2 = mkV2 (mkV "bloccarsi") | mkV2 (mkV "incepparsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin lock_V = mkV "bloccarsi" | mkV "incepparsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin symptom_N = mkN "sintomo" ; -- status=guess
lin promotion_N = variants{} ; -- 
lin global_A = variants{} ; -- 
lin aside_Adv = variants{} ; -- 
lin tendency_N = mkN "tendenza" ; -- status=guess
lin conservation_N = variants{} ; -- 
lin reply_N = mkN "risposta" | mkN "replica" ; -- status=guess status=guess
lin estimate_N = mkN "stima" ; -- status=guess
lin qualification_N = variants{} ; -- 
lin pack_V2 = variants{} ; -- 
lin pack_V = variants{} ; -- 
lin governor_N = mkN "governatore" masculine ; -- status=guess
lin expected_A = variants{} ; -- 
lin invest_V2 = mkV2 (mkV "investire") ; -- status=guess, src=wikt
lin invest_V = mkV "investire" ; -- status=guess, src=wikt
lin cycle_N = mkN "ciclo" ; -- status=guess
lin alright_A = variants{} ; -- 
lin philosophy_N = mkN "filosofia" ; -- status=guess
lin gallery_N = mkN "palchetto" | mkN "balconata" | mkN "galleria" | mkN "loggia" ; -- status=guess status=guess status=guess status=guess
lin sad_A = mkA "triste" ; -- status=guess
lin intervention_N = mkN "intervento" ; -- status=guess
lin emotional_A = mkA "emozionante" | mkA "commovente" ; -- status=guess status=guess
lin advertising_N = variants{} ; -- 
lin regard_N = variants{} ; -- 
lin dance_V2 = mkV2 (mkV "ballare") | mkV2 (mkV "danzare") ; -- status=guess, src=wikt status=guess, src=wikt
lin dance_V = mkV "ballare" | mkV "danzare" ; -- status=guess, src=wikt status=guess, src=wikt
lin cigarette_N = mkN "sigaretta" ; -- status=guess
lin predict_VS = mkVS (predire_V) ; -- status=guess, src=wikt
lin predict_V2 = mkV2 (predire_V) ; -- status=guess, src=wikt
lin adequate_A = mkA "adeguato" ; -- status=guess
lin variable_N = mkN "averla formichiera variabile" ; -- status=guess
lin net_N = mkN "rete" feminine ; -- status=guess
lin retire_V2 = mkV2 (mkV "ritirarsi") ; -- status=guess, src=wikt
lin retire_V = mkV "ritirarsi" ; -- status=guess, src=wikt
lin sugar_N = mkN "barbabietola da zucchero" ; -- status=guess
lin pale_A = mkA "pallido" ; -- status=guess
lin frequency_N = mkN "modulazione di frequenza" ; -- status=guess
lin guy_N = mkN "tipo" ; -- status=guess
lin feature_V2 = variants{} ; -- 
lin furniture_N = mkN "mobilio" ; -- status=guess
lin administrative_A = mkA "amministrativo" ; -- status=guess
lin wooden_A = mkA "di legno" | mkA "ligneo" ; -- status=guess status=guess
lin input_N = variants{} ; -- 
lin phenomenon_N = variants{} ; -- 
lin surprising_A = mkA "sorprendente" ; -- status=guess
lin jacket_N = mkN "giacca" ; -- status=guess
lin actor_N = mkN "attore" | mkN "attrice" feminine ; -- status=guess status=guess
lin actor_2_N = variants{} ; -- 
lin actor_1_N = variants{} ; -- 
lin kick_V2 = mkV2 (mkV "calciare") ; -- status=guess, src=wikt
lin kick_V = mkV "calciare" ; -- status=guess, src=wikt
lin producer_N = mkN "produttore" masculine ; -- status=guess
lin hearing_N = mkN "udienza" ; -- status=guess
lin chip_N = mkN "chip" ; -- status=guess
lin equation_N = mkN "equazione" feminine ; -- status=guess
lin certificate_N = variants{} ; -- 
lin hello_Interj = mkInterj "ciao" | mkInterj "salve" | mkInterj "buongiorno" ; -- status=guess status=guess status=guess
lin remarkable_A = variants{} ; -- 
lin alliance_N = variants{} ; -- 
lin smoke_V2 = mkV2 (mkV "fumare") ; -- status=guess, src=wikt
lin smoke_V = mkV "fumare" ; -- status=guess, src=wikt
lin awareness_N = mkN "coscienza" ; -- status=guess
lin throat_N = mkN "gola" ; -- status=guess
lin discovery_N = mkN "scoperta" ; -- status=guess
lin festival_N = mkN "mostra" | mkN "rassegna" | mkN "festival" ; -- status=guess status=guess status=guess
lin dance_N = mkN "ballo" | mkN "danza" ; -- status=guess status=guess
lin promise_N = mkN "promessa" ; -- status=guess
lin rose_N = mkN "rosa" masculine ; -- status=guess
lin principal_A = mkA "principale" ; -- status=guess
lin brilliant_A = mkA "brillante" ; -- status=guess
lin proposed_A = variants{} ; -- 
lin coach_N = mkN "corriera" ; -- status=guess
lin coach_3_N = variants{} ; -- 
lin coach_2_N = variants{} ; -- 
lin coach_1_N = variants{} ; -- 
lin absolute_A = mkA "assoluto" ; -- status=guess
lin drama_N = variants{} ; -- 
lin recording_N = mkN "registrazione" feminine ; -- status=guess
lin precisely_Adv = variants{} ; -- 
lin bath_N = mkN "bagno" feminine ; -- status=guess
lin celebrate_V2 = mkV2 (mkV "celebrare") ; -- status=guess, src=wikt
lin substance_N = mkN "sostanza" ; -- status=guess
lin swing_V2 = mkV2 (mkV "oscillare") | mkV2 (mkV "ondeggiare") | mkV2 (mkV "altalenare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin swing_V = mkV "oscillare" | mkV "ondeggiare" | mkV "altalenare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin for_Adv = variants{}; -- S.for_Prep ;
lin rapid_A = mkA "rapido" ; -- status=guess
lin rough_A = mkA "approssimato" ; -- status=guess
lin investor_N = mkN "investitore" masculine ; -- status=guess
lin fire_V2 = mkV2 (mkV "sparare") | mkV2 (mkV (I.fare_V) "fuoco") ; -- status=guess, src=wikt status=guess, src=wikt
lin fire_V = mkV "sparare" | mkV (I.fare_V) "fuoco" ; -- status=guess, src=wikt status=guess, src=wikt
lin rank_N = mkN "fila" | mkN "schiera" ; -- status=guess status=guess
lin compete_V = mkV "competere" | mkV "gareggiare" ; -- status=guess, src=wikt status=guess, src=wikt
lin sweet_A = mkA "dolcificato" | mkA "zuccherato" ; -- status=guess status=guess
lin decline_VV = mkVV (mkV "declinare") ; -- status=guess, src=wikt
lin decline_V2 = mkV2 (mkV "declinare") ; -- status=guess, src=wikt
lin decline_V = mkV "declinare" ; -- status=guess, src=wikt
lin rent_N = mkN "strappo" | mkN "squarcio" | mkN "lacerazione" feminine | mkN "scissione" feminine ; -- status=guess status=guess status=guess status=guess
lin dealer_N = mkN "piazzista" ; -- status=guess
lin bend_V2 = mkV2 (mkV "piegarsi") | mkV2 (mkV "curvarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin bend_V = mkV "piegarsi" | mkV "curvarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin solid_A = mkA "solido" ; -- status=guess
lin cloud_N = L.cloud_N ;
lin across_Adv = mkAdv "attraverso" | mkAdv "orizzontale" ; -- status=guess status=guess
lin level_A = mkA "livellato" ; -- status=guess
lin enquiry_N = mkN "domanda" | mkN "richiesta" ; -- status=guess status=guess
lin fight_N = mkN "battaglia" masculine | mkN "combattimento" ; -- status=guess status=guess
lin abuse_N = mkN "abuso" ; -- status=guess
lin golf_N = mkN "golf" masculine ; -- status=guess
lin guitar_N = mkN "chitarra" ; -- status=guess
lin electronic_A = mkA "elettronico" ; -- status=guess
lin cottage_N = mkN "casolare" masculine | mkN "rustico" ; -- status=guess status=guess
lin scope_N = variants{} ; -- 
lin pause_VS = variants{} ; -- 
lin pause_V2V = variants{} ; -- 
lin pause_V = variants{} ; -- 
lin mixture_N = variants{} ; -- 
lin emotion_N = mkN "emozione" feminine ; -- status=guess
lin comprehensive_A = variants{} ; -- 
lin shirt_N = L.shirt_N ;
lin allowance_N = variants{} ; -- 
lin retirement_N = mkN "pensionamento" ; -- status=guess
lin breach_N = mkN "breccia" ; -- status=guess
lin infection_N = mkN "infezione" feminine ; -- status=guess
lin resist_VV = variants{} ; -- 
lin resist_V2 = variants{} ; -- 
lin resist_V = variants{} ; -- 
lin qualify_V2 = variants{} ; -- 
lin qualify_V = variants{} ; -- 
lin paragraph_N = mkN "paragrafo" ; -- status=guess
lin sick_A = mkA "ammalato" | mkA "ammalata" ; -- status=guess status=guess
lin near_A = L.near_A ;
lin researcher_N = variants{} ; -- 
lin consent_N = mkN "consenso" ; -- status=guess
lin written_A = variants{} ; -- 
lin literary_A = mkA "letterario" ; -- status=guess
lin ill_A = mkA "malato" ; -- status=guess
lin wet_A = L.wet_A ;
lin lake_N = L.lake_N ;
lin entrance_N = mkN "entrata" ; -- status=guess
lin peak_N = mkN "cima" ; -- status=guess
lin successfully_Adv = variants{} ; -- 
lin sand_N = L.sand_N ;
lin breathe_V2 = mkV2 (mkV "respirare") ; -- status=guess, src=wikt
lin breathe_V = L.breathe_V ;
lin cold_N = mkN "fusione fredda" ; -- status=guess
lin cheek_N = mkN "chiappa" ; -- status=guess
lin platform_N = mkN "piattaforma" ; -- status=guess
lin interaction_N = mkN "interazione" feminine ; -- status=guess
lin watch_N = mkN "sorveglianza" | mkN "guardia" ; -- status=guess status=guess
lin borrow_VV = mkVV (mkV (prendere_V) "in prestito") ; -- status=guess, src=wikt
lin borrow_V2 = mkV2 (mkV (prendere_V) "in prestito") ; -- status=guess, src=wikt
lin borrow_V = mkV (prendere_V) "in prestito" ; -- status=guess, src=wikt
lin birthday_N = mkN "compleanno" ; -- status=guess
lin knife_N = mkN "lama" masculine ; -- status=guess
lin extreme_A = mkA "profondo" | mkA "profonda" ; -- status=guess status=guess
lin core_N = mkN "caparra" ; -- status=guess
lin peasant_N = variants{} ; -- 
lin armed_A = variants{} ; -- 
lin permission_N = mkN "permesso" ; -- status=guess
lin supreme_A = mkA "supremo" | mkA "suprema" ; -- status=guess status=guess
lin overcome_V2 = mkV2 (vincere_V) ; -- status=guess, src=wikt
lin overcome_V = vincere_V ; -- status=guess, src=wikt
lin greatly_Adv = variants{} ; -- 
lin visual_A = mkA "visuale" ; -- status=guess
lin lad_N = variants{} ; -- 
lin genuine_A = mkA "genuino" ; -- status=guess
lin personnel_N = mkN "personale" masculine ; -- status=guess
lin judgement_N = mkN "il giorno del giudizio universale" ; -- status=guess
lin exciting_A = variants{} ; -- 
lin stream_N = mkN "corrente" feminine | mkN "ruscello" ; -- status=guess status=guess
lin perception_N = mkN "percezione" feminine ; -- status=guess
lin guarantee_VS = mkVS (mkV "garantire") ; -- status=guess, src=wikt
lin guarantee_V2 = mkV2 (mkV "garantire") ; -- status=guess, src=wikt
lin guarantee_V = mkV "garantire" ; -- status=guess, src=wikt
lin disaster_N = mkN "disastro" ; -- status=guess
lin darkness_N = mkN "oscurità" feminine ; -- status=guess
lin bid_N = mkN "offerta" ; -- status=guess
lin sake_N = mkN "sakè" masculine ; -- status=guess
lin sake_2_N = variants{} ; -- 
lin sake_1_N = variants{} ; -- 
lin organize_V2V = variants{} ; -- 
lin organize_V2 = variants{} ; -- 
lin tourist_N = mkN "turista" masculine ; -- status=guess
lin policeman_N = L.policeman_N ;
lin castle_N = mkN "castello" ; -- status=guess
lin figure_VS = mkVS (mkV "scoprire") | mkVS (mkV (mkV "rendersi") "conto") ; -- status=guess, src=wikt status=guess, src=wikt
lin figure_V = mkV "scoprire" | mkV (mkV "rendersi") "conto" ; -- status=guess, src=wikt status=guess, src=wikt
lin race_VV = mkVV (correre_V) ; -- status=guess, src=wikt
lin race_V2V = mkV2V (correre_V) ; -- status=guess, src=wikt
lin race_V2 = mkV2 (correre_V) ; -- status=guess, src=wikt
lin race_V = correre_V ; -- status=guess, src=wikt
lin demonstration_N = mkN "dimostrazione" feminine ; -- status=guess
lin anger_N = mkN "ira" | mkN "rabbia" | mkN "collera" ; -- status=guess status=guess status=guess
lin briefly_Adv = variants{} ; -- 
lin presumably_Adv = variants{} ; -- 
lin clock_N = mkN "orologio" ; -- status=guess
lin hero_N = mkN "eroe" masculine | mkN "eroina" | mkN "protagonista" masculine ; -- status=guess status=guess status=guess
lin expose_V2 = mkV2 (esporre_V) ; -- status=guess, src=wikt
lin expose_V = esporre_V ; -- status=guess, src=wikt
lin custom_N = mkN "dogana" ; -- status=guess
lin maximum_A = mkA "massimo" ; -- status=guess
lin wish_N = mkN "desiderio" ; -- status=guess
lin earning_N = variants{} ; -- 
lin priest_N = L.priest_N ;
lin resign_V2 = mkV2 (mkV "dimettersi") ; -- status=guess, src=wikt
lin resign_V = mkV "dimettersi" ; -- status=guess, src=wikt
lin store_V2 = mkV2 (mkV "registrare") ; -- status=guess, src=wikt
lin widespread_A = mkA "esteso" | mkA "diffuso" ; -- status=guess status=guess
lin comprise_V2 = mkV2 (consistere_V) ; -- status=guess, src=wikt
lin chamber_N = mkN "camera" | mkN "camera da letto" ; -- status=guess status=guess
lin acquisition_N = mkN "acquisizione" feminine ; -- status=guess
lin involved_A = variants{} ; -- 
lin confident_A = mkA "fiducioso" | mkA "sicuro" ; -- status=guess status=guess
lin circuit_N = variants{} ; -- 
lin radical_A = mkA "radicalico" ; -- status=guess
lin detect_V2 = variants{} ; -- 
lin stupid_A = L.stupid_A ;
lin grand_A = variants{} ; -- 
lin consumption_N = variants{} ; -- 
lin hold_N = mkN "autoreggenti" feminine ; -- status=guess
lin zone_N = mkN "poiana codafasciata" ; -- status=guess
lin mean_A = mkA "eccellente" | mkA "fantastico" | mkA "favoloso" | mkA "formidabile" ; -- status=guess status=guess status=guess status=guess
lin altogether_Adv = mkAdv "nel complesso" ; -- status=guess
lin rush_VV = variants{} ; -- 
lin rush_V2 = variants{} ; -- 
lin rush_V = variants{} ; -- 
lin numerous_A = mkA "numeroso" ; -- status=guess
lin sink_V2 = mkV2 (mkV "affondare") ; -- status=guess, src=wikt
lin sink_V = mkV "affondare" ; -- status=guess, src=wikt
lin everywhere_Adv = S.everywhere_Adv ;
lin classical_A = mkA "classico" ; -- status=guess
lin respectively_Adv = variants{} ; -- 
lin distinct_A = mkA "distinto" | mkA "distinta" | mkA "diverso" | mkA "diversa" ; -- status=guess status=guess status=guess status=guess
lin mad_A = mkA "pazzo" | mkA "folle" | mkA "matto" | mkA "insano" ; -- status=guess status=guess status=guess status=guess
lin honour_N = mkN "onore" masculine ; -- status=guess
lin statistics_N = mkN "statistica" ; -- status=guess
lin false_A = mkA "posticcio" | mkA "finto" ; -- status=guess status=guess
lin square_N = mkN "casella" ; -- status=guess
lin differ_V = variants{} ; -- 
lin disk_N = mkN "disco" ; -- status=guess
lin truly_Adv = variants{} ; -- 
lin survival_N = mkN "sopravvivenza" ; -- status=guess
lin proud_A = mkA "orgoglioso" | mkA "fiero" ; -- status=guess status=guess
lin tower_N = mkN "la torre" | mkN "il fulmine" ; -- status=guess status=guess
lin deposit_N = mkN "caparra" ; -- status=guess
lin pace_N = mkN "passo" ; -- status=guess
lin compensation_N = variants{} ; -- 
lin adviser_N = variants{} ; -- 
lin consultant_N = variants{} ; -- 
lin drag_V2 = mkV2 (mkV "trainare") ; -- status=guess, src=wikt
lin drag_V = mkV "trainare" ; -- status=guess, src=wikt
lin advanced_A = variants{} ; -- 
lin landlord_N = variants{} ; -- 
lin whenever_Adv = mkAdv "ogni volta che" ; -- status=guess
lin delay_N = variants{} ; -- 
lin green_N = mkN "fagiolino" ; -- status=guess
lin car_V = variants{} ; -- 
lin holder_N = variants{} ; -- 
lin secret_A = mkA "segreto" ; -- status=guess
lin edition_N = mkN "edizione" feminine ; -- status=guess
lin occupation_N = mkN "occupazione" feminine ; -- status=guess
lin agricultural_A = mkA "agricolo" ; -- status=guess
lin intelligence_N = variants{} ; -- 
lin intelligence_2_N = variants{} ; -- 
lin intelligence_1_N = variants{} ; -- 
lin empire_N = mkN "impero" ; -- status=guess
lin definitely_Adv = variants{} ; -- 
lin negotiate_VV = variants{} ; -- 
lin negotiate_V2 = variants{} ; -- 
lin negotiate_V = variants{} ; -- 
lin host_N = mkN "host" masculine ; -- status=guess
lin relative_N = mkN "parente" masculine | mkN "congiunto" ; -- status=guess status=guess
lin mass_A = variants{} ; -- 
lin helpful_A = mkA "disponibile" ; -- status=guess
lin fellow_N = variants{} ; -- 
lin sweep_V2 = mkV2 (mkV "spazzare") | mkV2 (mkV "scopare") | mkV2 (mkV "ramazzare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sweep_V = mkV "spazzare" | mkV "scopare" | mkV "ramazzare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin poet_N = mkN "poeta" | mkN "poetessa" ; -- status=guess status=guess
lin journalist_N = mkN "giornalista" masculine ; -- status=guess
lin defeat_N = mkN "sconfitta" | mkN "disfatta" | mkN "fallimento" | mkN "insuccesso" ; -- status=guess status=guess status=guess status=guess
lin unlike_Prep = variants{} ; -- 
lin primarily_Adv = variants{} ; -- 
lin tight_A = mkA "teso" | mkA "tesa" | mkA "tirato" ; -- status=guess status=guess status=guess
lin indication_N = variants{} ; -- 
lin dry_V2 = mkV2 (mkV "asciugarsi") ; -- status=guess, src=wikt
lin dry_V = mkV "asciugarsi" ; -- status=guess, src=wikt
lin cricket_N = mkN "fair play" ; -- status=guess
lin whisper_V2 = mkV2 (mkV "sussurrare") ; -- status=guess, src=wikt
lin whisper_V = mkV "sussurrare" ; -- status=guess, src=wikt
lin routine_N = variants{} ; -- 
lin print_N = mkN "stampa" ; -- status=guess
lin anxiety_N = mkN "ansia" | mkN "ansietà" feminine ; -- status=guess status=guess
lin witness_N = mkN "testimonianza" ; -- status=guess
lin concerning_Prep = variants{} ; -- 
lin mill_N = mkN "mulino" ; -- status=guess
lin gentle_A = mkA "gentile" ; -- status=guess
lin curtain_N = mkN "tenda" | mkN "tappezzeria" | mkN "drappo" | mkN "drappeggio" | mkN "tendina" ; -- status=guess status=guess status=guess status=guess status=guess
lin mission_N = mkN "missione" feminine ; -- status=guess
lin supplier_N = variants{} ; -- 
lin basically_Adv = mkAdv "praticamente" | mkAdv "in pratica" | mkAdv "basicamente" ; -- status=guess status=guess status=guess
lin assure_V2S = variants{} ; -- 
lin assure_V2 = variants{} ; -- 
lin poverty_N = mkN "povertà" feminine ; -- status=guess
lin snow_N = L.snow_N ;
lin prayer_N = mkN "pregatore" masculine ; -- status=guess
lin pipe_N = mkN "curapipe" ; -- status=guess
lin deserve_VV = mkVV (mkV "meritare") | mkVV (mkV "meritarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin deserve_V2 = mkV2 (mkV "meritare") | mkV2 (mkV "meritarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin deserve_V = mkV "meritare" | mkV "meritarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin shift_N = mkN "cambio" ; -- status=guess
lin split_V2 = L.split_V2 ;
lin split_V = mkV "fendere" | mkV "dividere" | scindere_V | mkV "spaccare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin near_Adv = mkAdv "circa" ; -- status=guess
lin consistent_A = variants{} ; -- 
lin carpet_N = L.carpet_N ;
lin ownership_N = mkN "possesso" | mkN "proprietà" feminine ; -- status=guess status=guess
lin joke_N = mkN "barzelletta" | mkN "battuta scherzo" ; -- status=guess status=guess
lin fewer_Det = variants{} ; -- 
lin workshop_N = mkN "seminario" ; -- status=guess
lin salt_N = L.salt_N ;
lin aged_Prep = variants{} ; -- 
lin symbol_N = mkN "simbolo" ; -- status=guess
lin slide_V2 = mkV2 (mkV "scivolare") ; -- status=guess, src=wikt
lin slide_V = mkV "scivolare" ; -- status=guess, src=wikt
lin cross_N = mkN "incrocio" ; -- status=guess
lin anxious_A = mkA "preoccupante" ; -- status=guess
lin tale_N = mkN "racconto" ; -- status=guess
lin preference_N = variants{} ; -- 
lin inevitably_Adv = variants{} ; -- 
lin mere_A = variants{} ; -- 
lin behave_V = mkV "comportarsi" ; -- status=guess, src=wikt
lin gain_N = mkN "guadagno" | mkN "profitto" ; -- status=guess status=guess
lin nervous_A = mkA "nervoso" ; -- status=guess
lin guide_V2 = variants{} ; -- 
lin remark_N = mkN "considerazione" feminine | mkN "caveat" ; -- status=guess status=guess
lin pleased_A = variants{} ; -- 
lin province_N = mkN "provincia" ; -- status=guess
lin steel_N = L.steel_N ;
lin practise_V2 = variants{} ; -- 
lin practise_V = variants{} ; -- 
lin flow_V = L.flow_V ;
lin holy_A = mkA "sacro" ; -- status=guess
lin dose_N = mkN "dose" feminine ; -- status=guess
lin alcohol_N = mkN "alcol" masculine ; -- status=guess
lin guidance_N = variants{} ; -- 
lin constantly_Adv = variants{} ; -- 
lin climate_N = mkN "cambiamento climatico" | mkN "mutamento climatico" ; -- status=guess status=guess
lin enhance_V2 = mkV2 (accrescere_V) | mkV2 (mkV "intensificare") ; -- status=guess, src=wikt status=guess, src=wikt
lin reasonably_Adv = variants{} ; -- 
lin waste_V2 = mkV2 (mkV (perdere_V) "tempo") ; -- status=guess, src=wikt
lin waste_V = mkV (perdere_V) "tempo" ; -- status=guess, src=wikt
lin smooth_A = L.smooth_A ;
lin dominant_A = variants{} ; -- 
lin conscious_A = mkA "cosciente" ; -- status=guess
lin formula_N = mkN "formula" ; -- status=guess
lin tail_N = L.tail_N ;
lin ha_Interj = variants{} ; -- 
lin electric_A = mkA "elettrico" ; -- status=guess
lin sheep_N = L.sheep_N ;
lin medicine_N = mkN "medicina" | mkN "clinica" ; -- status=guess status=guess
lin strategic_A = mkA "strategico" ; -- status=guess
lin disabled_A = variants{} ; -- 
lin smell_N = mkN "odore" masculine ; -- status=guess
lin operator_N = mkN "operatore" masculine ; -- status=guess
lin mount_V2 = mkV2 (mkV "montare") ; -- status=guess, src=wikt
lin mount_V = mkV "montare" ; -- status=guess, src=wikt
lin advance_V2 = mkV2 (mkV "avanzare") ; -- status=guess, src=wikt
lin advance_V = mkV "avanzare" ; -- status=guess, src=wikt
lin remote_A = mkA "remoto" ; -- status=guess
lin measurement_N = variants{} ; -- 
lin favour_VS = variants{} ; -- 
lin favour_V2 = variants{} ; -- 
lin favour_V = variants{} ; -- 
lin neither_Det = mkDet "né" ; -- status=guess
lin architecture_N = mkN "architettura" ; -- status=guess
lin worth_N = mkN "valore" masculine ; -- status=guess
lin tie_N = mkN "legame" masculine | mkN "vincolo" ; -- status=guess status=guess
lin barrier_N = mkN "limite" masculine ; -- status=guess
lin practitioner_N = mkN "professionista" ; -- status=guess
lin outstanding_A = mkA "eccezionale" | mkA "notevole" ; -- status=guess status=guess
lin enthusiasm_N = mkN "entusiasmo" | mkN "foga" ; -- status=guess status=guess
lin theoretical_A = mkA "teorico" ; -- status=guess
lin implementation_N = mkN "implementazione" feminine | mkN "attuazione" feminine ; -- status=guess status=guess
lin worried_A = variants{} ; -- 
lin pitch_N = mkN "pece" feminine ; -- status=guess
lin drop_N = mkN "caduta" ; -- status=guess
lin phone_V2 = mkV2 (mkV "telefonare") ; -- status=guess, src=wikt
lin phone_V = mkV "telefonare" ; -- status=guess, src=wikt
lin shape_VV = mkVV (mkV "modellare") ; -- status=guess, src=wikt
lin shape_V2 = mkV2 (mkV "modellare") ; -- status=guess, src=wikt
lin shape_V = mkV "modellare" ; -- status=guess, src=wikt
lin clinical_A = mkA "clinico" ; -- status=guess
lin lane_N = mkN "corsia" ; -- status=guess
lin apple_N = L.apple_N ;
lin catalogue_N = mkN "catalogo" | mkN "cataloghi" masculine ; -- status=guess status=guess
lin tip_N = mkN "punta" ; -- status=guess
lin publisher_N = mkN "editore" masculine ; -- status=guess
lin opponent_N = variants{} ; -- 
lin live_A = mkA "vivo" ; -- status=guess
lin burden_N = mkN "preoccupazione" feminine | mkN "fardello" ; -- status=guess status=guess
lin tackle_V2 = mkV2 (mkV "affrontare") | mkV2 (mkV "contrastare") ; -- status=guess, src=wikt status=guess, src=wikt
lin tackle_V = mkV "affrontare" | mkV "contrastare" ; -- status=guess, src=wikt status=guess, src=wikt
lin historian_N = mkN "storico" ; -- status=guess
lin bury_V2 = mkV2 (mkV "sotterrare") | mkV2 (mkV "nascondere") | mkV2 (mkV "sprofondare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin bury_V = mkV "sotterrare" | mkV "nascondere" | mkV "sprofondare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin stomach_N = mkN "pancia" masculine ; -- status=guess
lin percentage_N = mkN "percentuale" feminine ; -- status=guess
lin evaluation_N = mkN "valutazione" feminine ; -- status=guess
lin outline_V2 = variants{} ; -- 
lin talent_N = mkN "talento" ; -- status=guess
lin lend_V2 = mkV2 (mkV "prestare") ; -- status=guess, src=wikt
lin lend_V = mkV "prestare" ; -- status=guess, src=wikt
lin silver_N = L.silver_N ;
lin pack_N = mkN "mazzo" ; -- status=guess
lin fun_N = mkN "divertimento" ; -- status=guess
lin democrat_N = mkN "democratico" | mkN "democratica" ; -- status=guess status=guess
lin fortune_N = mkN "sorte" feminine | mkN "destino" | mkN "fortuna" ; -- status=guess status=guess status=guess
lin storage_N = mkN "memorizzazione" feminine ; -- status=guess
lin professional_N = variants{} ; -- 
lin reserve_N = mkN "riserva" ; -- status=guess
lin interval_N = mkN "intervallo" ; -- status=guess
lin dimension_N = mkN "dimensione" feminine ; -- status=guess
lin honest_A = mkA "onesto" | mkA "onesta" ; -- status=guess status=guess
lin awful_A = variants{} ; -- 
lin manufacture_V2 = mkV2 (mkV "fabbricare") ; -- status=guess, src=wikt
lin confusion_N = variants{} ; -- 
lin pink_A = variants{} ; -- 
lin impressive_A = mkA "impressionante" ; -- status=guess
lin satisfaction_N = mkN "soddisfazione" feminine ; -- status=guess
lin visible_A = mkA "visibile" ; -- status=guess
lin vessel_N = mkN "recipiente" masculine | mkN "contenitore" masculine ; -- status=guess status=guess
lin stand_N = mkN "cascatore" masculine ; -- status=guess
lin curve_N = mkN "curva" ; -- status=guess
lin pot_N = mkN "piatto" | mkN "posta" ; -- status=guess status=guess
lin replacement_N = mkN "sostituto" | mkN "rimpiazzo" ; -- status=guess status=guess
lin accurate_A = variants{} ; -- 
lin mortgage_N = mkN "ipoteca" ; -- status=guess
lin salary_N = mkN "stipendio" | mkN "salario" ; -- status=guess status=guess
lin impress_V2 = mkV2 (mkV "impressionare") ; -- status=guess, src=wikt
lin impress_V = mkV "impressionare" ; -- status=guess, src=wikt
lin constitutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (mkV "enfatizzare") | mkVS (mkV "sottolineare") | mkVS (mkV "evidenziare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin emphasize_V2 = mkV2 (mkV "enfatizzare") | mkV2 (mkV "sottolineare") | mkV2 (mkV "evidenziare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin developing_A = variants{} ; -- 
lin proof_N = mkN "prova" ; -- status=guess
lin furthermore_Adv = mkAdv "inoltre" ; -- status=guess
lin dish_N = mkN "piatto" ; -- status=guess
lin interview_V2 = variants{} ; -- 
lin considerably_Adv = variants{} ; -- 
lin distant_A = variants{} ; -- 
lin lower_V2 = mkV2 (mkV "abbassare") ; -- status=guess, src=wikt
lin lower_V = mkV "abbassare" ; -- status=guess, src=wikt
lin favourite_N = variants{} ; -- 
lin tear_V2 = mkV2 (mkV "strappare") ; -- status=guess, src=wikt
lin tear_V = mkV "strappare" ; -- status=guess, src=wikt
lin fixed_A = variants{} ; -- 
lin by_Adv = mkAdv "a proposito" ; -- status=guess
lin luck_N = mkN "fortuna" | mkN "sorte" feminine ; -- status=guess status=guess
lin count_N = mkN "conte" masculine ; -- status=guess
lin precise_A = mkA "preciso" | mkA "esatto" | mkA "accurato" ; -- status=guess status=guess status=guess
lin determination_N = variants{} ; -- 
lin bite_V2 = L.bite_V2 ;
lin bite_V = mkV (I.fare_V) "il passo più lungo della gamba" ; -- status=guess, src=wikt
lin dear_Interj = variants{} ; -- 
lin consultation_N = variants{} ; -- 
lin range_V = variants{} ; -- 
lin residential_A = variants{} ; -- 
lin conduct_N = mkN "comportamento" | mkN "condotta" ; -- status=guess status=guess
lin capture_V2 = variants{} ; -- 
lin ultimately_Adv = variants{} ; -- 
lin cheque_N = mkN "assegno" ; -- status=guess
lin economics_N = mkN "economia" ; -- status=guess
lin sustain_V2 = variants{} ; -- 
lin secondly_Adv = variants{} ; -- 
lin silly_A = mkA "sciocco" ; -- status=guess
lin merchant_N = mkN "mercante" | mkN "commerciante" ; -- status=guess status=guess
lin lecture_N = mkN "conferenza" ; -- status=guess
lin musical_A = variants{} ; -- 
lin leisure_N = mkN "svago" ; -- status=guess
lin check_N = mkN "conto" ; -- status=guess
lin cheese_N = L.cheese_N ;
lin lift_N = mkN "ascensore" masculine ; -- status=guess
lin participate_V2 = mkV2 (mkV "partecipare") ; -- status=guess, src=wikt
lin participate_V = mkV "partecipare" ; -- status=guess, src=wikt
lin fabric_N = mkN "struttura" | mkN "tessuto" ; -- status=guess status=guess
lin distribute_V2 = mkV2 (mkV "distribuire") ; -- status=guess, src=wikt
lin lover_N = mkN "amante" masculine ; -- status=guess
lin childhood_N = mkN "infanzia" ; -- status=guess
lin cool_A = mkA "termico" | mkA "fresco" | mkA "leggero" ; -- status=guess status=guess status=guess
lin ban_V2 = mkV2 (espellere_V) | mkV2 (mkV "vietare") | mkV2 (mkV "censurare") | mkV2 (mkV "bandire") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin supposed_A = variants{} ; -- 
lin mouse_N = mkN "averla formichiera grigiotopo" ; -- status=guess
lin strain_N = mkN "disposizione" feminine | mkN "predisposizione" feminine | mkN "carattere ereditario" ; -- status=guess status=guess status=guess
lin specialist_A = variants{} ; -- 
lin consult_V2 = variants{} ; -- 
lin consult_V = variants{} ; -- 
lin minimum_A = variants{} ; -- 
lin approximately_Adv = variants{} ; -- 
lin participant_N = mkN "partecipante" masculine | mkN "che partecipa" ; -- status=guess status=guess
lin monetary_A = variants{} ; -- 
lin confuse_V2 = variants{} ; -- 
lin dare_VV = mkVV (mkV "osare") ; -- status=guess, src=wikt
lin dare_V2 = mkV2 (mkV "osare") ; -- status=guess, src=wikt
lin smoke_N = L.smoke_N ;
lin movie_N = mkN "cinema" masculine | mkN "film" | mkN "pellicola" ; -- status=guess status=guess status=guess
lin seed_N = L.seed_N ;
lin cease_V2 = mkV2 (mkV (mkV "cessi") "e cessi") ; -- status=guess, src=wikt
lin cease_V = mkV (mkV "cessi") "e cessi" ; -- status=guess, src=wikt
lin open_Adv = variants{} ; -- 
lin journal_N = mkN "perno d'albero" ; -- status=guess
lin shopping_N = mkN "carrello della spesa" ; -- status=guess
lin equivalent_N = variants{} ; -- 
lin palace_N = mkN "palazzo" ; -- status=guess
lin exceed_V2 = mkV2 (mkV "eccedere") ; -- status=guess, src=wikt
lin isolated_A = variants{} ; -- 
lin poetry_N = mkN "poesia" ; -- status=guess
lin perceive_VS = mkVS (mkV "percepire") ; -- status=guess, src=wikt
lin perceive_V2V = mkV2V (mkV "percepire") ; -- status=guess, src=wikt
lin perceive_V2 = mkV2 (mkV "percepire") ; -- status=guess, src=wikt
lin lack_V2 = mkV2 (mkV "mancare") ; -- status=guess, src=wikt
lin lack_V = mkV "mancare" ; -- status=guess, src=wikt
lin strengthen_V2 = mkV2 (mkV "rinforzarsi") ; -- status=guess, src=wikt
lin snap_V2 = mkV2 (mkV "sbottare") ; -- status=guess, src=wikt
lin snap_V = mkV "sbottare" ; -- status=guess, src=wikt
lin readily_Adv = variants{} ; -- 
lin spite_N = mkN "rancore" | mkN "malevolenza" ; -- status=guess status=guess
lin conviction_N = mkN "convinzione" feminine ; -- status=guess
lin corridor_N = mkN "corridoio aereo" ; -- status=guess
lin behind_Adv = variants{}; -- S.behind_Prep ;
lin ward_N = mkN "guardiano" ; -- status=guess
lin profile_N = variants{} ; -- 
lin fat_A = mkA "grasso" | mkA "obeso" ; -- status=guess status=guess
lin comfort_N = mkN "benessere" masculine ; -- status=guess
lin bathroom_N = mkN "toiletta" ; -- status=guess
lin shell_N = mkN "guscio" ; -- status=guess
lin reward_N = mkN "ricompensa" ; -- status=guess
lin deliberately_Adv = variants{} ; -- 
lin automatically_Adv = mkAdv "automaticamente" ; -- status=guess
lin vegetable_N = mkN "vegetale" masculine ; -- status=guess
lin imagination_N = variants{} ; -- 
lin junior_A = variants{} ; -- 
lin unemployed_A = mkA "disoccupato" ; -- status=guess
lin mystery_N = mkN "mistero" ; -- status=guess
lin pose_V2 = mkV2 (porre_V) ; -- status=guess, src=wikt
lin pose_V = porre_V ; -- status=guess, src=wikt
lin violent_A = mkA "violento" ; -- status=guess
lin march_N = mkN "marcia" ; -- status=guess
lin found_V2 = mkV2 (mkV "fondare") ; -- status=guess, src=wikt
lin dig_V2 = mkV2 (mkV "scavare") ; -- status=guess, src=wikt
lin dig_V = L.dig_V ;
lin dirty_A = L.dirty_A ;
lin straight_A = L.straight_A ;
lin psychological_A = mkA "psicologico" ; -- status=guess
lin grab_V2 = mkV2 (mkV "afferrare") ; -- status=guess, src=wikt
lin grab_V = mkV "afferrare" ; -- status=guess, src=wikt
lin pleasant_A = mkA "piacevole" ; -- status=guess
lin surgery_N = mkN "chirurgia" ; -- status=guess
lin inevitable_A = mkA "inevitabile" ; -- status=guess
lin transform_V2 = mkV2 (mkV "trasformare") | mkV2 (mkV "modificare") ; -- status=guess, src=wikt status=guess, src=wikt
lin bell_N = mkN "sonagliera" ; -- status=guess
lin announcement_N = mkN "annuncio" ; -- status=guess
lin draft_N = mkN "sorso" ; -- status=guess
lin unity_N = mkN "unità" feminine ; -- status=guess
lin airport_N = mkN "aeroporto" ; -- status=guess
lin upset_V2 = mkV2 (sconvolgere_V) | mkV2 (mkV "angosciare") | mkV2 (mkV "turbare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin upset_V = sconvolgere_V | mkV "angosciare" | mkV "turbare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pretend_VS = mkVS (mkV "fingere") ; -- status=guess, src=wikt
lin pretend_V2 = mkV2 (mkV "fingere") ; -- status=guess, src=wikt
lin pretend_V = mkV "fingere" ; -- status=guess, src=wikt
lin plant_V2 = mkV2 (mkV "piantare") ; -- status=guess, src=wikt
lin till_Prep = variants{} ; -- 
lin known_A = variants{} ; -- 
lin admission_N = mkN "ammissione" feminine ; -- status=guess
lin tissue_N = mkN "tessuto" ; -- status=guess
lin magistrate_N = mkN "magistrato" ; -- status=guess
lin joy_N = mkN "gioia" ; -- status=guess
lin free_V2V = mkV2V (mkV "liberare") ; -- status=guess, src=wikt
lin free_V2 = mkV2 (mkV "liberare") ; -- status=guess, src=wikt
lin pretty_A = mkA "grazioso" | mkA "carino" ; -- status=guess status=guess
lin operating_N = variants{} ; -- 
lin headquarters_N = variants{} ; -- 
lin grateful_A = mkA "grato" ; -- status=guess
lin classroom_N = mkN "classe" feminine | mkN "aula" ; -- status=guess status=guess
lin turnover_N = mkN "movimento degli affari" | mkN "giro d'affari" ; -- status=guess status=guess
lin project_VS = variants{} ; -- 
lin project_V2V = variants{} ; -- 
lin project_V2 = variants{} ; -- 
lin project_V = variants{} ; -- 
lin shrug_V2 = variants{} ; -- 
lin sensible_A = variants{} ; -- 
lin limitation_N = variants{} ; -- 
lin specialist_N = mkN "specialista" ; -- status=guess
lin newly_Adv = variants{} ; -- 
lin tongue_N = L.tongue_N ;
lin refugee_N = mkN "campo per rifugiati" ; -- status=guess
lin delay_V2 = variants{} ; -- 
lin delay_V = variants{} ; -- 
lin dream_V2 = mkV2 (mkV "sognare") ; -- status=guess, src=wikt
lin dream_V = mkV "sognare" ; -- status=guess, src=wikt
lin composition_N = mkN "composizione" feminine ; -- status=guess
lin alongside_Prep = variants{} ; -- 
lin ceiling_N = L.ceiling_N ;
lin highlight_V2 = mkV2 (mkV (mettere_V) "in evidenza") | mkV2 (mkV "enfatizzare") ; -- status=guess, src=wikt status=guess, src=wikt
lin stick_N = L.stick_N ;
lin favourite_A = variants{} ; -- 
lin tap_V2 = variants{} ; -- 
lin tap_V = variants{} ; -- 
lin universe_N = mkN "universo" ; -- status=guess
lin request_VS = mkVS (chiedere_V) ; -- status=guess, src=wikt
lin request_V2 = mkV2 (chiedere_V) ; -- status=guess, src=wikt
lin label_N = mkN "etichetta" ; -- status=guess
lin confine_V2 = variants{} ; -- 
lin scream_VS = mkVS (mkV "gridare") | mkVS (mkV "sbraitare") | mkVS (mkV "urlare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin scream_V2 = mkV2 (mkV "gridare") | mkV2 (mkV "sbraitare") | mkV2 (mkV "urlare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin scream_V = mkV "gridare" | mkV "sbraitare" | mkV "urlare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rid_V2 = variants{} ; -- 
lin acceptance_N = mkN "accettazione" feminine ; -- status=guess
lin detective_N = variants{} ; -- 
lin sail_V = mkV "veleggiare" ; -- status=guess, src=wikt
lin adjust_V2 = mkV2 (mkV "regolare") ; -- status=guess, src=wikt
lin adjust_V = mkV "regolare" ; -- status=guess, src=wikt
lin designer_N = variants{} ; -- 
lin running_A = variants{} ; -- 
lin summit_N = mkN "incontro al vertice" ; -- status=guess
lin participation_N = variants{} ; -- 
lin weakness_N = mkN "debolezza" ; -- status=guess
lin block_V2 = mkV2 (mkV "stoppare") ; -- status=guess, src=wikt
lin socalled_A = variants{} ; -- 
lin adapt_V2 = mkV2 (mkV "adattare") ; -- status=guess, src=wikt
lin adapt_V = mkV "adattare" ; -- status=guess, src=wikt
lin absorb_V2 = mkV2 (mkV "assorbire") ; -- status=guess, src=wikt
lin encounter_V2 = variants{} ; -- 
lin defeat_V2 = mkV2 (sconfiggere_V) | mkV2 (mkV "battere") ; -- status=guess, src=wikt status=guess, src=wikt
lin excitement_N = mkN "eccitamento" | mkN "orgasmo" ; -- status=guess status=guess
lin brick_N = mkN "mattone" ; -- status=guess
lin blind_A = mkA "cieco" ; -- status=guess
lin wire_N = mkN "filo spinato" ; -- status=guess
lin crop_N = mkN "cerchio nel grano" ; -- status=guess
lin square_A = mkA "perpendicolare a" ; -- status=guess
lin transition_N = variants{} ; -- 
lin thereby_Adv = variants{} ; -- 
lin protest_V2 = mkV2 (mkV "protestare") ; -- status=guess, src=wikt
lin protest_V = mkV "protestare" ; -- status=guess, src=wikt
lin roll_N = mkN "rollo" ; -- status=guess
lin stop_N = mkN "occlusiva" ; -- status=guess
lin assistant_N = mkN "assistente" masculine ; -- status=guess
lin deaf_A = mkA "sordo" ; -- status=guess
lin constituency_N = variants{} ; -- 
lin continuous_A = mkA "continuo" ; -- status=guess
lin concert_N = mkN "concerto" ; -- status=guess
lin breast_N = L.breast_N ;
lin extraordinary_A = mkA "straordinario" | mkA "straordinaria" ; -- status=guess status=guess
lin squad_N = variants{} ; -- 
lin wonder_N = mkN "meraviglia" ; -- status=guess
lin cream_N = mkN "crema" masculine ; -- status=guess
lin tennis_N = mkN "tennis" masculine ; -- status=guess
lin personally_Adv = variants{} ; -- 
lin communicate_V2 = variants{} ; -- 
lin communicate_V = variants{} ; -- 
lin pride_N = mkN "superbia" ; -- status=guess
lin bowl_N = mkN "boccia" ; -- status=guess
lin file_V2 = mkV2 (mkV "archiviare") ; -- status=guess, src=wikt
lin file_V = mkV "archiviare" ; -- status=guess, src=wikt
lin expertise_N = variants{} ; -- 
lin govern_V2 = variants{} ; -- 
lin govern_V = variants{} ; -- 
lin leather_N = L.leather_N ;
lin observer_N = variants{} ; -- 
lin margin_N = variants{} ; -- 
lin uncertainty_N = variants{} ; -- 
lin reinforce_V2 = mkV2 (mkV "rinforzare") ; -- status=guess, src=wikt
lin ideal_N = mkN "ideale" masculine ; -- status=guess
lin injure_V2 = mkV2 (mkV "ferire") ; -- status=guess, src=wikt
lin holding_N = variants{} ; -- 
lin universal_A = mkA "universale" ; -- status=guess
lin evident_A = mkA "evidente" ; -- status=guess
lin dust_N = L.dust_N ;
lin overseas_A = mkA "estero" ; -- status=guess
lin desperate_A = mkA "disperato" ; -- status=guess
lin swim_V2 = mkV2 (mkV "nuotare") ; -- status=guess, src=wikt
lin swim_V = L.swim_V ;
lin occasional_A = mkA "occasionale" ; -- status=guess
lin trouser_N = variants{} ; -- 
lin surprisingly_Adv = variants{} ; -- 
lin register_N = mkN "anagrafe" ; -- status=guess
lin album_N = variants{} ; -- 
lin guideline_N = mkN "linea guida" ; -- status=guess
lin disturb_V2 = variants{} ; -- 
lin amendment_N = variants{} ; -- 
lin architect_N = variants{} ; -- 
lin objection_N = mkN "obiezione" feminine ; -- status=guess
lin chart_N = mkN "carta" | mkN "carta nautica" | mkN "carta geografica" ; -- status=guess status=guess status=guess
lin cattle_N = mkN "bestiame" masculine ; -- status=guess
lin doubt_VS = mkVS (mkV "dubitare") ; -- status=guess, src=wikt
lin doubt_V2 = mkV2 (mkV "dubitare") ; -- status=guess, src=wikt
lin react_V = variants{} ; -- 
lin consciousness_N = mkN "conoscenza" masculine | mkN "coscienza" ; -- status=guess status=guess
lin right_Interj = variants{} ; -- 
lin purely_Adv = variants{} ; -- 
lin tin_N = mkN "lattina" | mkN "barattolo" ; -- status=guess status=guess
lin tube_N = mkN "tubo" ; -- status=guess
lin fulfil_V2 = variants{} ; -- 
lin commonly_Adv = variants{} ; -- 
lin sufficiently_Adv = variants{} ; -- 
lin coin_N = mkN "moneta" ; -- status=guess
lin frighten_V2 = variants{} ; -- 
lin grammar_N = L.grammar_N ;
lin diary_N = mkN "diario" ; -- status=guess
lin flesh_N = mkN "carne" feminine ; -- status=guess
lin summary_N = mkN "riassunto" ; -- status=guess
lin infant_N = mkN "minorenne" masculine | mkN "minore" masculine ; -- status=guess status=guess
lin stir_V2 = mkV2 (mkV "agitare") ; -- status=guess, src=wikt
lin stir_V = mkV "agitare" ; -- status=guess, src=wikt
lin storm_N = mkN "tempesta" ; -- status=guess
lin mail_N = mkN "posta" | mkN "posta elettronica" | mkN "e-mail" feminine ; -- status=guess status=guess status=guess
lin rugby_N = mkN "rugby a 15" | mkN "rugby a XV" ; -- status=guess status=guess
lin virtue_N = mkN "virtù" feminine ; -- status=guess
lin specimen_N = mkN "esemplare" ; -- status=guess
lin psychology_N = mkN "psicologia" ; -- status=guess
lin paint_N = mkN "vernice [housepaint]" | mkN "colore" masculine | mkN "pittura [regional]" ; -- status=guess status=guess status=guess
lin constraint_N = mkN "vincolo" ; -- status=guess
lin trace_V2 = variants{} ; -- 
lin trace_V = variants{} ; -- 
lin privilege_N = mkN "privilegio" | mkN "prerogativa" ; -- status=guess status=guess
lin completion_N = mkN "completamento" ; -- status=guess
lin progress_V2 = variants{} ; -- 
lin progress_V = variants{} ; -- 
lin grade_N = variants{} ; -- 
lin exploit_V2 = mkV2 (mkV (mkV "sfruttare") "di") ; -- status=guess, src=wikt
lin import_N = variants{} ; -- 
lin potato_N = mkN "patata" ; -- status=guess
lin repair_N = mkN "riparazione" feminine ; -- status=guess
lin passion_N = mkN "passione" feminine ; -- status=guess
lin seize_V2 = mkV2 (prendere_V) ; -- status=guess, src=wikt
lin seize_V = prendere_V ; -- status=guess, src=wikt
lin low_Adv = variants{} ; -- 
lin underlying_A = variants{} ; -- 
lin heaven_N = mkN "cielo" | mkN "paradiso" ; -- status=guess status=guess
lin nerve_N = mkN "nervi" masculine ; -- status=guess
lin park_V2 = mkV2 (mkV "sostare") | mkV2 (mkV "parcheggiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin park_V = mkV "sostare" | mkV "parcheggiare" ; -- status=guess, src=wikt status=guess, src=wikt
lin collapse_V2 = mkV2 (mkV (mkV "far") "collassare") | mkV2 (mkV (mkV "far") "crollare") ; -- status=guess, src=wikt status=guess, src=wikt
lin collapse_V = mkV (mkV "far") "collassare" | mkV (mkV "far") "crollare" ; -- status=guess, src=wikt status=guess, src=wikt
lin win_N = mkN "vittoria" ; -- status=guess
lin printer_N = mkN "stampante" feminine ; -- status=guess
lin coalition_N = mkN "blocco" ; -- status=guess
lin button_N = mkN "pulsante" masculine ; -- status=guess
lin pray_V2 = mkV2 (mkV "pregare") ; -- status=guess, src=wikt
lin pray_V = mkV "pregare" ; -- status=guess, src=wikt
lin ultimate_A = mkA "definitivo" | mkA "definitiva" | mkA "conclusivo" | mkA "conclusiva" | mkA "ultimativo" | mkA "ultimativa" | mkA "finale" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin venture_N = variants{} ; -- 
lin timber_N = mkN "legno" ; -- status=guess
lin companion_N = variants{} ; -- 
lin horror_N = variants{} ; -- 
lin gesture_N = mkN "gesto" ; -- status=guess
lin moon_N = L.moon_N ;
lin remark_VS = variants{} ; -- 
lin remark_V = variants{} ; -- 
lin clever_A = L.clever_A ;
lin van_N = mkN "furgone" masculine ; -- status=guess
lin consequently_Adv = variants{} ; -- 
lin raw_A = mkA "vergine" ; -- status=guess
lin glance_N = mkN "sguardo" | mkN "occhiata" | mkN "scorsa" ; -- status=guess status=guess status=guess
lin broken_A = variants{} ; -- 
lin jury_N = mkN "giuria" ; -- status=guess
lin gaze_V = mkV "guardare" | mkV (mkV "puntare") "gli occhi" | mkV (volgere_V) "lo sguardo" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin burst_V2 = mkV2 (mkV "scoppiare") | mkV2 (esplodere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin burst_V = mkV "scoppiare" | esplodere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin charter_N = mkN "carta" ; -- status=guess
lin feminist_N = variants{} ; -- 
lin discourse_N = mkN "discorso" ; -- status=guess
lin reflection_N = mkN "riflessione" ; -- status=guess
lin carbon_N = mkN "carbonio" ; -- status=guess
lin sophisticated_A = mkA "sofisticato" ; -- status=guess
lin ban_N = mkN "proibizione" feminine | mkN "divieto" ; -- status=guess status=guess
lin taxation_N = variants{} ; -- 
lin prosecution_N = variants{} ; -- 
lin softly_Adv = variants{} ; -- 
lin asleep_A = mkA "addormentato" ; -- status=guess
lin aids_N = variants{} ; -- 
lin publicity_N = variants{} ; -- 
lin departure_N = mkN "dipartenza" masculine ; -- status=guess
lin welcome_A = mkA "benvenuto" ; -- status=guess
lin sharply_Adv = variants{} ; -- 
lin reception_N = mkN "ricevimento" ; -- status=guess
lin cousin_N = L.cousin_N ;
lin relieve_V2 = variants{} ; -- 
lin linguistic_A = mkA "linguistico" ; -- status=guess
lin vat_N = mkN "tino" ; -- status=guess
lin forward_A = variants{} ; -- 
lin blue_N = mkN "blu" | mkN "azzurro" ; -- status=guess status=guess
lin multiple_A = variants{} ; -- 
lin pass_N = mkN "contromarca" ; -- status=guess
lin outer_A = variants{} ; -- 
lin vulnerable_A = mkA "vulnerabile" ; -- status=guess
lin patient_A = mkA "paziente" ; -- status=guess
lin evolution_N = mkN "evoluzione" feminine ; -- status=guess
lin allocate_V2 = mkV2 (mkV "stanziare") ; -- status=guess, src=wikt
lin allocate_V = mkV "stanziare" ; -- status=guess, src=wikt
lin creative_A = mkA "creativo" ; -- status=guess
lin potentially_Adv = variants{} ; -- 
lin just_A = variants{} ; -- 
lin out_Prep = variants{} ; -- 
lin judicial_A = mkA "giudiziale" | mkA "giudiziario" ; -- status=guess status=guess
lin risk_VV = mkVV (mkV "rischiare") ; -- status=guess, src=wikt
lin risk_V2 = mkV2 (mkV "rischiare") ; -- status=guess, src=wikt
lin ideology_N = mkN "ideologia" ; -- status=guess
lin smell_VA = mkVA (mkV (mkV "la") "gatta ci cova") ; -- status=guess, src=wikt
lin smell_V2 = mkV2 (mkV (mkV "la") "gatta ci cova") ; -- status=guess, src=wikt
lin smell_V = L.smell_V ;
lin agenda_N = variants{} ; -- 
lin transport_V2 = mkV2 (mkV "trasportare") ; -- status=guess, src=wikt
lin illegal_A = variants{} ; -- 
lin chicken_N = mkN "pollo" | mkN "gallo" | mkN "gallina" ; -- status=guess status=guess status=guess
lin plain_A = mkA "semplice" ; -- status=guess
lin innovation_N = mkN "innovazione" feminine ; -- status=guess
lin opera_N = variants{} ; -- 
lin lock_N = mkN "otturatore" masculine ; -- status=guess
lin grin_V = variants{} ; -- 
lin shelf_N = mkN "durata" | mkN "conservazione" feminine ; -- status=guess status=guess
lin pole_N = mkN "palo" | mkN "asta" | mkN "pertica" ; -- status=guess status=guess status=guess
lin punishment_N = mkN "punizione" feminine ; -- status=guess
lin strict_A = mkA "severo" ; -- status=guess
lin wave_V2 = mkV2 (mkV "ondeggiare") ; -- status=guess, src=wikt
lin wave_V = mkV "ondeggiare" ; -- status=guess, src=wikt
lin inside_N = variants{} ; -- 
lin carriage_N = mkN "vagone" | mkN "carrozza" ; -- status=guess status=guess
lin fit_A = mkA "in forma" ; -- status=guess
lin conversion_N = mkN "conversione" feminine ; -- status=guess
lin hurry_V = mkV "affrettarsi" | mkV "precipitarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin essay_N = mkN "tentativo" | mkN "prova" ; -- status=guess status=guess
lin integration_N = mkN "integrazione" feminine ; -- status=guess
lin resignation_N = mkN "dimissioni" feminine ; -- status=guess
lin treasury_N = variants{} ; -- 
lin traveller_N = mkN "viaggiatore" | mkN "viaggiatrice" | mkN "viandante" masculine | mkN "girovago" ; -- status=guess status=guess status=guess status=guess
lin chocolate_N = mkN "cioccolato" | mkN "cioccolata" ; -- status=guess status=guess
lin assault_N = mkN "assalto" | mkN "attacco" | mkN "aggressione" feminine ; -- status=guess status=guess status=guess
lin schedule_N = mkN "programma" masculine | mkN "orario" ; -- status=guess status=guess
lin undoubtedly_Adv = variants{} ; -- 
lin twin_N = mkN "gemello" ; -- status=guess
lin format_N = variants{} ; -- 
lin murder_V2 = mkV2 (mkV "massacrare") ; -- status=guess, src=wikt
lin sigh_VS = mkVS (mkV "sospirare") ; -- status=guess, src=wikt
lin sigh_V2 = mkV2 (mkV "sospirare") ; -- status=guess, src=wikt
lin sigh_V = mkV "sospirare" ; -- status=guess, src=wikt
lin seller_N = variants{} ; -- 
lin lease_N = variants{} ; -- 
lin bitter_A = mkA "aspro" | mkA "aspra" ; -- status=guess status=guess
lin double_V2 = variants{} ; -- 
lin double_V = variants{} ; -- 
lin ally_N = variants{} ; -- 
lin stake_N = mkN "palo" | mkN "paletto" | mkN "picchetto" | mkN "piolo" ; -- status=guess status=guess status=guess status=guess
lin processing_N = variants{} ; -- 
lin informal_A = variants{} ; -- 
lin flexible_A = mkA "flessibile" ; -- status=guess
lin cap_N = L.cap_N ;
lin stable_A = variants{} ; -- 
lin till_Subj = variants{} ; -- 
lin sympathy_N = mkN "empatia" ; -- status=guess
lin tunnel_N = mkN "tunnel" masculine ; -- status=guess
lin pen_N = L.pen_N ;
lin instal_V = variants{} ; -- 
lin suspend_V2 = mkV2 (mkV "sospendere") ; -- status=guess, src=wikt
lin suspend_V = mkV "sospendere" ; -- status=guess, src=wikt
lin blow_N = mkN "botta" | mkN "colpo" ; -- status=guess status=guess
lin wander_V = mkV "divagare" ; -- status=guess, src=wikt
lin notably_Adv = variants{} ; -- 
lin disappoint_V2 = variants{} ; -- 
lin wipe_V2 = L.wipe_V2 ;
lin wipe_V = mkV "asciugare" | mkV "pulire" ; -- status=guess, src=wikt status=guess, src=wikt
lin folk_N = mkN "gente" feminine | mkN "autoctono" | mkN "popolo" | mkN "abitante" masculine ; -- status=guess status=guess status=guess status=guess
lin attraction_N = mkN "attrazione" feminine ; -- status=guess
lin disc_N = mkN "disco" ; -- status=guess
lin inspire_V2V = mkV2V (mkV "ispirare") ; -- status=guess, src=wikt
lin inspire_V2 = mkV2 (mkV "ispirare") ; -- status=guess, src=wikt
lin machinery_N = mkN "macchinario" ; -- status=guess
lin undergo_V2 = variants{} ; -- 
lin nowhere_Adv = mkAdv "in nessun posto" ; -- status=guess
lin inspector_N = variants{} ; -- 
lin wise_A = mkA "saggio" ; -- status=guess
lin balance_V2 = mkV2 (mkV "conguagliare") ; -- status=guess, src=wikt
lin balance_V = mkV "conguagliare" ; -- status=guess, src=wikt
lin purchaser_N = variants{} ; -- 
lin resort_N = variants{} ; -- 
lin pop_N = mkN "musica leggera" ; -- status=guess
lin organ_N = mkN "organo" | mkN "organo francese" | mkN "orgue" | mkN "ribadocchino" ; -- status=guess status=guess status=guess status=guess
lin ease_V2 = variants{} ; -- 
lin ease_V = variants{} ; -- 
lin friendship_N = mkN "amicizia" ; -- status=guess
lin deficit_N = variants{} ; -- 
lin dear_N = variants{} ; -- 
lin convey_V2 = mkV2 (mkV "trasportare") ; -- status=guess, src=wikt
lin reserve_V2 = mkV2 (mkV "riservare") ; -- status=guess, src=wikt
lin reserve_V = mkV "riservare" ; -- status=guess, src=wikt
lin planet_N = L.planet_N ;
lin frequent_A = mkA "frequente" | mkA "assiduo" ; -- status=guess status=guess
lin loose_A = mkA "sciolto" ; -- status=guess
lin intense_A = mkA "intenso" ; -- status=guess
lin retail_A = variants{} ; -- 
lin wind_V = riavvolgere_V ; -- status=guess, src=wikt
lin lost_A = variants{} ; -- 
lin grain_N = mkN "grano" ; -- status=guess
lin particle_N = mkN "particella" | mkN "briciolo" | mkN "granello" | mkN "grano" ; -- status=guess status=guess status=guess status=guess
lin destruction_N = mkN "distruzione" feminine ; -- status=guess
lin witness_V2 = mkV2 (mkV "testimoniare") ; -- status=guess, src=wikt
lin witness_V = mkV "testimoniare" ; -- status=guess, src=wikt
lin pit_N = mkN "box" masculine ; -- status=guess
lin registration_N = variants{} ; -- 
lin conception_N = mkN "concetto" ; -- status=guess
lin steady_A = variants{} ; -- 
lin rival_N = mkN "rivale" | mkN "competitore" | mkN "antagonista" masculine | mkN "avversario" ; -- status=guess status=guess status=guess status=guess
lin steam_N = mkN "piroscissione a vapore" ; -- status=guess
lin back_A = variants{} ; -- 
lin chancellor_N = mkN "cancelliere" ; -- status=guess
lin crash_V = mkV "imbucarsi" ; -- status=guess, src=wikt
lin belt_N = mkN "cintura" ; -- status=guess
lin logic_N = mkN "logica" ; -- status=guess
lin premium_N = variants{} ; -- 
lin confront_V2 = variants{} ; -- 
lin precede_V2 = variants{} ; -- 
lin experimental_A = variants{} ; -- 
lin alarm_N = mkN "sveglia" ; -- status=guess
lin rational_A = mkA "razionale" ; -- status=guess
lin incentive_N = variants{} ; -- 
lin roughly_Adv = variants{} ; -- 
lin bench_N = mkN "banco" | mkN "panca" ; -- status=guess status=guess
lin wrap_V2 = mkV2 (avvolgere_V) | mkV2 (mkV "avviluppare") | mkV2 (mkV "incartare") | mkV2 (mkV "impacchettare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wrap_V = avvolgere_V | mkV "avviluppare" | mkV "incartare" | mkV "impacchettare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin regarding_Prep = variants{} ; -- 
lin inadequate_A = mkA "inadeguato" ; -- status=guess
lin ambition_N = mkN "ambizione" feminine ; -- status=guess
lin since_Adv = variants{} ; -- 
lin fate_N = mkN "destino" | mkN "sorte" feminine | mkN "fato" ; -- status=guess status=guess status=guess
lin vendor_N = mkN "venditore" masculine ; -- status=guess
lin stranger_N = mkN "straniero" | mkN "straniera" ; -- status=guess status=guess
lin spiritual_A = mkA "spirituale" ; -- status=guess
lin increasing_A = variants{} ; -- 
lin anticipate_VV = mkVV (mkV "anticipare") ; -- status=guess, src=wikt
lin anticipate_VS = mkVS (mkV "anticipare") ; -- status=guess, src=wikt
lin anticipate_V2 = mkV2 (mkV "anticipare") ; -- status=guess, src=wikt
lin anticipate_V = mkV "anticipare" ; -- status=guess, src=wikt
lin logical_A = mkA "logico" ; -- status=guess
lin fibre_N = mkN "fibra" ; -- status=guess
lin attribute_V2 = variants{} ; -- 
lin sense_VS = mkVS (sentire_V) ; -- status=guess, src=wikt
lin sense_V2 = mkV2 (sentire_V) ; -- status=guess, src=wikt
lin black_N = mkN "nero" | mkN "nera" ; -- status=guess status=guess
lin petrol_N = variants{} ; -- 
lin maker_N = variants{} ; -- 
lin generous_A = mkA "abbondante" ; -- status=guess
lin allocation_N = variants{} ; -- 
lin depression_N = mkN "depressione" feminine ; -- status=guess
lin declaration_N = mkN "dichiarazione" feminine ; -- status=guess
lin spot_VS = variants{} ; -- 
lin spot_V2 = variants{} ; -- 
lin spot_V = variants{} ; -- 
lin modest_A = mkA "modesto" ; -- status=guess
lin bottom_A = variants{} ; -- 
lin dividend_N = mkN "dividendo" ; -- status=guess
lin devote_V2 = variants{} ; -- 
lin condemn_V2 = variants{} ; -- 
lin integrate_V2 = variants{} ; -- 
lin integrate_V = variants{} ; -- 
lin pile_N = mkN "mucchio" ; -- status=guess
lin identification_N = mkN "identificazione" feminine ; -- status=guess
lin acute_A = mkA "acuto" ; -- status=guess
lin barely_Adv = variants{} ; -- 
lin providing_Subj = variants{} ; -- 
lin directive_N = variants{} ; -- 
lin bet_VS = mkVS (scommettere_V) ; -- status=guess, src=wikt
lin bet_V2 = mkV2 (scommettere_V) ; -- status=guess, src=wikt
lin bet_V = scommettere_V ; -- status=guess, src=wikt
lin modify_V2 = variants{} ; -- 
lin bare_A = mkA "nudo" | mkA "nuda" ; -- status=guess status=guess
lin swear_VV = mkVV (mkV "insultare") | mkVV (mkV "bestemmiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin swear_V2 = mkV2 (mkV "insultare") | mkV2 (mkV "bestemmiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin swear_V = mkV "insultare" | mkV "bestemmiare" ; -- status=guess, src=wikt status=guess, src=wikt
lin final_N = mkN "finale" ; -- status=guess
lin accordingly_Adv = mkAdv "di conseguenza" | mkAdv "in conformità a" | mkAdv "conformemente" ; -- status=guess status=guess status=guess
lin valid_A = mkA "valido" ; -- status=guess
lin wherever_Adv = variants{} ; -- 
lin mortality_N = mkN "mortalità" feminine ; -- status=guess
lin medium_N = mkN "medium" ; -- status=guess
lin silk_N = mkN "seta" masculine ; -- status=guess
lin funeral_N = mkN "funerale" masculine ; -- status=guess
lin depending_A = variants{} ; -- 
lin cow_N = L.cow_N ;
lin correspond_V2 = variants{} ; -- 
lin correspond_V = variants{} ; -- 
lin cite_V2 = variants{} ; -- 
lin classic_A = mkA "classico" ; -- status=guess
lin inspection_N = mkN "ispezione" feminine ; -- status=guess
lin calculation_N = mkN "conto" ; -- status=guess
lin rubbish_N = mkN "immondizia" | mkN "spazzatura" | mkN "rifiuti" masculine ; -- status=guess status=guess status=guess
lin minimum_N = mkN "minimo" ; -- status=guess
lin hypothesis_N = mkN "ipotesi" feminine ; -- status=guess
lin youngster_N = variants{} ; -- 
lin slope_N = mkN "pendio" ; -- status=guess
lin patch_N = mkN "neo finto" ; -- status=guess
lin invitation_N = mkN "invitazione" feminine | mkN "invito" ; -- status=guess status=guess
lin ethnic_A = mkA "etnico" | mkA "etnica" ; -- status=guess status=guess
lin federation_N = mkN "federazione" feminine ; -- status=guess
lin duke_N = mkN "duca" masculine ; -- status=guess
lin wholly_Adv = variants{} ; -- 
lin closure_N = variants{} ; -- 
lin dictionary_N = mkN "dizionario" ; -- status=guess
lin withdrawal_N = mkN "ritiro ritrattazione" feminine ; -- status=guess
lin automatic_A = mkA "automatico" ; -- status=guess
lin liable_A = variants{} ; -- 
lin cry_N = mkN "urlo" ; -- status=guess
lin slow_V2 = mkV2 (mkV "rallentare") ; -- status=guess, src=wikt
lin slow_V = mkV "rallentare" ; -- status=guess, src=wikt
lin borough_N = variants{} ; -- 
lin well_A = mkA "bene" ; -- status=guess
lin suspicion_N = mkN "sospetto" ; -- status=guess
lin portrait_N = mkN "ritratto" ; -- status=guess
lin local_N = mkN "locale" ; -- status=guess
lin jew_N = variants{} ; -- 
lin fragment_N = mkN "frammento" ; -- status=guess
lin revolutionary_A = mkA "rivoluzionario" ; -- status=guess
lin evaluate_V2 = mkV2 (mkV "valutare") ; -- status=guess, src=wikt
lin evaluate_V = mkV "valutare" ; -- status=guess, src=wikt
lin competitor_N = mkN "concorrente" ; -- status=guess
lin sole_A = mkA "unico" | mkA "solo" ; -- status=guess status=guess
lin reliable_A = mkA "affidabile" ; -- status=guess
lin weigh_V2 = mkV2 (mkV "pesare") ; -- status=guess, src=wikt
lin weigh_V = mkV "pesare" ; -- status=guess, src=wikt
lin medieval_A = mkA "medievale" ; -- status=guess
lin clinic_N = mkN "clinica" ; -- status=guess
lin shine_V2 = mkV2 (mkV "brillare") ; -- status=guess, src=wikt
lin shine_V = mkV "brillare" ; -- status=guess, src=wikt
lin knit_V2 = mkV2 (mkV "saldarsi") | mkV2 (mkV "compattare") ; -- status=guess, src=wikt status=guess, src=wikt
lin knit_V = mkV "saldarsi" | mkV "compattare" ; -- status=guess, src=wikt status=guess, src=wikt
lin complexity_N = mkN "complessità" feminine ; -- status=guess
lin remedy_N = mkN "azione giudiziaria" ; -- status=guess
lin fence_N = mkN "recinto" | mkN "steccato" | mkN "palizzata" | mkN "cinta" | mkN "siepe" feminine | mkN "barriera" | mkN "riparo" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin bike_N = L.bike_N ;
lin freeze_V2 = mkV2 (mkV "congelare") ; -- status=guess, src=wikt
lin freeze_V = L.freeze_V ;
lin eliminate_V2 = variants{} ; -- 
lin interior_N = variants{} ; -- 
lin intellectual_A = variants{} ; -- 
lin established_A = variants{} ; -- 
lin voter_N = variants{} ; -- 
lin garage_N = mkN "garage" masculine ; -- status=guess
lin era_N = mkN "era" | mkN "epoca" ; -- status=guess status=guess
lin pregnant_A = mkA "incinta" | mkA "gravida" | mkA "pregna" ; -- status=guess status=guess status=guess
lin plot_N = mkN "lotto" | mkN "parcella" | mkN "appezzamento" | mkN "tratto" | mkN "pezzo" ; -- status=guess status=guess status=guess status=guess status=guess
lin greet_V2 = variants{} ; -- 
lin electrical_A = variants{} ; -- 
lin lie_N = mkN "bugia" | mkN "menzogna" | mkN "frottola" | mkN "baggianata" | mkN "fola" | mkN "balla" | mkN "fandonia" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin disorder_N = mkN "disordine" ; -- status=guess
lin formally_Adv = variants{} ; -- 
lin excuse_N = mkN "scusa" | mkN "pretesto" ; -- status=guess status=guess
lin socialist_A = variants{} ; -- 
lin cancel_V2 = mkV2 (mkV "depennare") | mkV2 (mkV "cancellare") | mkV2 (mkV "eliminare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cancel_V = mkV "depennare" | mkV "cancellare" | mkV "eliminare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin harm_N = mkN "male" masculine | mkN "danno" ; -- status=guess status=guess
lin excess_N = mkN "eccedenza" ; -- status=guess
lin exact_A = mkA "esatto" ; -- status=guess
lin oblige_V2V = variants{} ; -- 
lin oblige_V2 = variants{} ; -- 
lin accountant_N = mkN "contabile" | mkN "ragioniere" masculine ; -- status=guess status=guess
lin mutual_A = mkA "mutuo" | mkA "vicendevole" ; -- status=guess status=guess
lin fat_N = L.fat_N ;
lin volunteer_N = variants{} ; -- 
lin laughter_N = mkN "risata" ; -- status=guess
lin trick_N = variants{} ; -- 
lin load_V2 = variants{} ; -- 
lin load_V = variants{} ; -- 
lin disposal_N = variants{} ; -- 
lin taxi_N = mkN "taxi" | mkN "tassì" masculine ; -- status=guess status=guess
lin murmur_V2 = mkV2 (mkV "mormorare") ; -- status=guess, src=wikt
lin murmur_V = mkV "mormorare" ; -- status=guess, src=wikt
lin tonne_N = variants{} ; -- 
lin spell_V2 = mkV2 (mkV "compitare") | mkV2 (mkV (I.fare_V) "lo spelling") ; -- status=guess, src=wikt status=guess, src=wikt
lin spell_V = mkV "compitare" | mkV (I.fare_V) "lo spelling" ; -- status=guess, src=wikt status=guess, src=wikt
lin clerk_N = mkN "impiegato" ; -- status=guess
lin curious_A = mkA "curioso" ; -- status=guess
lin satisfactory_A = variants{} ; -- 
lin identical_A = mkA "identico" ; -- status=guess
lin applicant_N = variants{} ; -- 
lin removal_N = variants{} ; -- 
lin processor_N = mkN "processore" masculine ; -- status=guess
lin cotton_N = mkN "cotone" masculine ; -- status=guess
lin reverse_V2 = variants{} ; -- 
lin reverse_V = variants{} ; -- 
lin hesitate_VV = variants{} ; -- 
lin hesitate_V = variants{} ; -- 
lin professor_N = mkN "professore" masculine ; -- status=guess
lin admire_V2 = mkV2 (mkV "ammirare") ; -- status=guess, src=wikt
lin namely_Adv = variants{} ; -- 
lin electoral_A = variants{} ; -- 
lin delight_N = mkN "delizia" ; -- status=guess
lin urgent_A = mkA "urgente" ; -- status=guess
lin prompt_V2V = mkV2V (mkV "incitare") ; -- status=guess, src=wikt
lin prompt_V2 = mkV2 (mkV "incitare") ; -- status=guess, src=wikt
lin mate_N = variants{} ; -- 
lin mate_2_N = variants{} ; -- 
lin mate_1_N = variants{} ; -- 
lin exposure_N = mkN "espozione" feminine ; -- status=guess
lin server_N = mkN "server" masculine | mkN "servente" masculine | mkN "servitore" masculine ; -- status=guess status=guess status=guess
lin distinctive_A = variants{} ; -- 
lin marginal_A = variants{} ; -- 
lin structural_A = variants{} ; -- 
lin rope_N = L.rope_N ;
lin miner_N = mkN "minatore" masculine ; -- status=guess
lin entertainment_N = mkN "divertimento" | mkN "intrattenimento" ; -- status=guess status=guess
lin acre_N = variants{} ; -- 
lin pig_N = mkN "porco" | mkN "maiale" masculine ; -- status=guess status=guess
lin encouraging_A = variants{} ; -- 
lin guarantee_N = mkN "garante" ; -- status=guess
lin gear_N = mkN "marcia" ; -- status=guess
lin anniversary_N = mkN "anniversario" ; -- status=guess
lin past_Adv = variants{} ; -- 
lin ceremony_N = mkN "cerimonia" ; -- status=guess
lin rub_V2 = L.rub_V2 ;
lin rub_V = mkV "strofinare" | mkV "fregare" ; -- status=guess, src=wikt status=guess, src=wikt
lin monopoly_N = mkN "monopoli" | mkN "monopolio" ; -- status=guess status=guess
lin left_N = mkN "sinistra" ; -- status=guess
lin flee_V2 = mkV2 (mkV "fuggire") ; -- status=guess, src=wikt
lin flee_V = mkV "fuggire" ; -- status=guess, src=wikt
lin yield_V2 = mkV2 (mkV "cedere") | mkV2 (mkV "arrendersi") | mkV2 (mkV "arrendere") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin discount_N = mkN "sconto" ; -- status=guess
lin above_A = mkA "suddetto" | mkA "succitato" ; -- status=guess status=guess
lin uncle_N = mkN "zio" ; -- status=guess
lin audit_N = variants{} ; -- 
lin advertisement_N = mkN "annuncio" | mkN "pubblicità" feminine ; -- status=guess status=guess
lin explosion_N = mkN "esplosione" feminine ; -- status=guess
lin contrary_A = mkA "contrario" | mkA "opposto" ; -- status=guess status=guess
lin tribunal_N = variants{} ; -- 
lin swallow_V2 = mkV2 (mkV "deglutire") | mkV2 (mkV "inghiottire") ; -- status=guess, src=wikt status=guess, src=wikt
lin swallow_V = mkV "deglutire" | mkV "inghiottire" ; -- status=guess, src=wikt status=guess, src=wikt
lin typically_Adv = variants{} ; -- 
lin fun_A = variants{} ; -- 
lin rat_N = mkN "topo" | mkN "sorcio" | mkN "ratto" ; -- status=guess status=guess status=guess
lin cloth_N = mkN "abbigliamento" | mkN "tonaca" | mkN "abito" | mkN "vestiario" | mkN "tenuta" ; -- status=guess status=guess status=guess status=guess status=guess
lin cable_N = mkN "cavo" ; -- status=guess
lin interrupt_V2 = mkV2 (interrompere_V) ; -- status=guess, src=wikt
lin interrupt_V = interrompere_V ; -- status=guess, src=wikt
lin crash_N = mkN "blocco" ; -- status=guess
lin flame_N = mkN "flame" masculine ; -- status=guess
lin controversy_N = mkN "controversia" ; -- status=guess
lin rabbit_N = mkN "lapin" masculine ; -- status=guess
lin everyday_A = variants{} ; -- 
lin allegation_N = variants{} ; -- 
lin strip_N = mkN "corso" | mkN "via principale" ; -- status=guess status=guess
lin stability_N = mkN "stabilità" feminine ; -- status=guess
lin tide_N = mkN "marea" ; -- status=guess
lin illustration_N = mkN "illustrare" ; -- status=guess
lin insect_N = mkN "insetto" ; -- status=guess
lin correspondent_N = variants{} ; -- 
lin devise_V2 = mkV2 (mkV "architettare") | mkV2 (mkV "congegnare") | mkV2 (mkV "escogitare") | mkV2 (mkV "inventare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin determined_A = variants{} ; -- 
lin brush_V2 = mkV2 (mkV "spennellare") ; -- status=guess, src=wikt
lin brush_V = mkV "spennellare" ; -- status=guess, src=wikt
lin adjustment_N = mkN "adattamento" | mkN "inserimento" ; -- status=guess status=guess
lin controversial_A = variants{} ; -- 
lin organic_A = mkA "organico" ; -- status=guess
lin escape_N = mkN "velocità di fuga" ; -- status=guess
lin thoroughly_Adv = variants{} ; -- 
lin interface_N = mkN "interfacciamento" | mkN "interfaccia" ; -- status=guess status=guess
lin historic_A = mkA "storico" | mkA "storica" ; -- status=guess status=guess
lin collapse_N = mkN "collasso" | mkN "crollo" | mkN "tracollo" ; -- status=guess status=guess status=guess
lin temple_N = mkN "tempiale" masculine ; -- status=guess
lin shade_N = mkN "spettro" | mkN "ombra" | mkN "fantasma" masculine ; -- status=guess status=guess status=guess
lin craft_N = variants{} ; -- 
lin nursery_N = variants{} ; -- 
lin piano_N = mkN "pianoforte" | mkN "piano" ; -- status=guess status=guess
lin desirable_A = mkA "desiderabile" ; -- status=guess
lin assurance_N = variants{} ; -- 
lin jurisdiction_N = mkN "giurisdizione" feminine ; -- status=guess
lin advertise_V2 = mkV2 (mkV "pubblicizzare") ; -- status=guess, src=wikt
lin advertise_V = mkV "pubblicizzare" ; -- status=guess, src=wikt
lin bay_N = mkN "baia" | mkN "golfo" ; -- status=guess status=guess
lin specification_N = mkN "specificazione" feminine | mkN "specifica" ; -- status=guess status=guess
lin disability_N = variants{} ; -- 
lin presidential_A = mkA "presidenziale" ; -- status=guess
lin arrest_N = variants{} ; -- 
lin unexpected_A = mkA "inaspettato" ; -- status=guess
lin switch_N = mkN "interruttore" ; -- status=guess
lin penny_N = variants{} ; -- 
lin respect_V2 = variants{} ; -- 
lin celebration_N = mkN "celebrazione" feminine | mkN "ricorrenza" ; -- status=guess status=guess
lin gross_A = mkA "grasso" ; -- status=guess
lin aid_V2 = mkV2 (mkV "aiutare") ; -- status=guess, src=wikt
lin aid_V = mkV "aiutare" ; -- status=guess, src=wikt
lin superb_A = variants{} ; -- 
lin process_V2 = mkV2 (mkV "elaborare") | mkV2 (mkV "processare") ; -- status=guess, src=wikt status=guess, src=wikt
lin process_V = mkV "elaborare" | mkV "processare" ; -- status=guess, src=wikt status=guess, src=wikt
lin innocent_A = mkA "innocente" ; -- status=guess
lin leap_V2 = mkV2 (mkV "saltare") ; -- status=guess, src=wikt
lin leap_V = mkV "saltare" ; -- status=guess, src=wikt
lin colony_N = mkN "colonia" ; -- status=guess
lin wound_N = mkN "ferita" ; -- status=guess
lin hardware_N = mkN "hardware" masculine ; -- status=guess
lin satellite_N = mkN "satellite" masculine ; -- status=guess
lin float_V = L.float_V ;
lin bible_N = variants{} ; -- 
lin statistical_A = variants{} ; -- 
lin marked_A = variants{} ; -- 
lin hire_V2V = mkV2V (mkV "impiegare") | mkV2V (mkV "ingaggiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin hire_V2 = mkV2 (mkV "impiegare") | mkV2 (mkV "ingaggiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin cathedral_N = mkN "cattedrale" | mkN "duomo" ; -- status=guess status=guess
lin motive_N = mkN "motivo" ; -- status=guess
lin correct_VS = mkVS (mkV "correggere") ; -- status=guess, src=wikt
lin correct_V2 = mkV2 (mkV "correggere") ; -- status=guess, src=wikt
lin correct_V = mkV "correggere" ; -- status=guess, src=wikt
lin gastric_A = mkA "gastrico" ; -- status=guess
lin raid_N = mkN "incursione" | mkN "razzia" | mkN "irruzione" feminine | mkN "rapina" | mkN "attacco" ; -- status=guess status=guess status=guess status=guess status=guess
lin comply_V2 = mkV2 (mkV "attuare") ; -- status=guess, src=wikt
lin comply_V = mkV "attuare" ; -- status=guess, src=wikt
lin accommodate_V2 = variants{} ; -- 
lin accommodate_V = variants{} ; -- 
lin mutter_V2 = variants{} ; -- 
lin mutter_V = variants{} ; -- 
lin induce_V2 = variants{} ; -- 
lin trap_V2 = mkV2 (mkV "intrappolare") ; -- status=guess, src=wikt
lin trap_V = mkV "intrappolare" ; -- status=guess, src=wikt
lin invasion_N = mkN "invasione" | mkN "calata" ; -- status=guess status=guess
lin humour_N = mkN "umore" masculine ; -- status=guess
lin bulk_N = variants{} ; -- 
lin traditionally_Adv = variants{} ; -- 
lin commission_V2V = variants{} ; -- 
lin commission_V2 = variants{} ; -- 
lin upstairs_Adv = mkAdv "di sopra" ; -- status=guess
lin translate_V2 = mkV2 tradurre_V ;
lin translate_V = tradurre_V ;
lin rhythm_N = mkN "ritmo" ; -- status=guess
lin emission_N = variants{} ; -- 
lin collective_A = variants{} ; -- 
lin transformation_N = mkN "trasformazione" feminine ; -- status=guess
lin battery_N = mkN "pila" ; -- status=guess
lin stimulus_N = variants{} ; -- 
lin naked_A = mkA "nudo" ; -- status=guess
lin white_N = mkN "bianco" | mkN "bianca" ; -- status=guess status=guess
lin menu_N = mkN "carta" ; -- status=guess
lin toilet_N = mkN "bagno" feminine | mkN "gabinetto" | mkN "toilette" ;
lin butter_N = L.butter_N ;
lin surprise_V2V = mkV2V (mkV "stupire") | mkV2V (sorprendere_V) | mkV2V (mkV "meravigliare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin surprise_V2 = mkV2 (mkV "stupire") | mkV2 (sorprendere_V) | mkV2 (mkV "meravigliare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin needle_N = mkN "ago" ; -- status=guess
lin effectiveness_N = mkN "efficacia" ; -- status=guess
lin accordance_N = variants{} ; -- 
lin molecule_N = mkN "molecola" ; -- status=guess
lin fiction_N = variants{} ; -- 
lin learning_N = mkN "disturbi specifici di apprendimento" ; -- status=guess
lin statute_N = variants{} ; -- 
lin reluctant_A = mkA "riluttante" ; -- status=guess
lin overlook_V2 = variants{} ; -- 
lin junction_N = variants{} ; -- 
lin necessity_N = mkN "necessità" feminine ; -- status=guess
lin nearby_A = mkA "accanto" ; -- status=guess
lin experienced_A = variants{} ; -- 
lin lorry_N = variants{} ; -- 
lin exclusive_A = variants{} ; -- 
lin graphics_N = mkN "scheda video" ; -- status=guess
lin stimulate_V2 = mkV2 (mkV "stimulare") ; -- status=guess, src=wikt
lin warmth_N = mkN "calore" masculine ; -- status=guess
lin therapy_N = mkN "terapia" ; -- status=guess
lin convenient_A = mkA "conveniente" | mkA "comodo" ; -- status=guess status=guess
lin cinema_N = mkN "cinematografo" | mkN "cinematografia" ; -- status=guess status=guess
lin domain_N = mkN "dominio" ; -- status=guess
lin tournament_N = mkN "torneo" ; -- status=guess
lin doctrine_N = mkN "dottrina" ; -- status=guess
lin sheer_A = variants{} ; -- 
lin proposition_N = mkN "proposizione" feminine ; -- status=guess
lin grip_N = mkN "presa" ; -- status=guess
lin widow_N = mkN "vedova" ; -- status=guess
lin discrimination_N = variants{} ; -- 
lin bloody_Adv = variants{} ; -- 
lin ruling_A = variants{} ; -- 
lin fit_N = variants{} ; -- 
lin nonetheless_Adv = variants{} ; -- 
lin myth_N = mkN "mito" ; -- status=guess
lin episode_N = mkN "episodio" ; -- status=guess
lin drift_V2 = variants{} ; -- 
lin drift_V = variants{} ; -- 
lin assert_VS = mkVS (mkV "asserire") ; -- status=guess, src=wikt
lin assert_V2 = mkV2 (mkV "asserire") ; -- status=guess, src=wikt
lin assert_V = mkV "asserire" ; -- status=guess, src=wikt
lin terrace_N = variants{} ; -- 
lin uncertain_A = variants{} ; -- 
lin twist_V2 = mkV2 (torcere_V) ; -- status=guess, src=wikt
lin insight_N = mkN "introspezione" feminine | mkN "acume" | mkN "intuito" | mkN "discernimento" ; -- status=guess status=guess status=guess status=guess
lin undermine_V2 = mkV2 (mkV "insidiare") ; -- status=guess, src=wikt
lin tragedy_N = mkN "tragedia" ; -- status=guess
lin enforce_V2 = variants{} ; -- 
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin march_V2 = mkV2 (mkV "marciare") ; -- status=guess, src=wikt
lin march_V = mkV "marciare" ; -- status=guess, src=wikt
lin leaflet_N = mkN "fogliolina" ; -- status=guess
lin fellow_A = variants{} ; -- 
lin object_V2 = mkV2 (mkV "obiettare") ; -- status=guess, src=wikt
lin object_V = mkV "obiettare" ; -- status=guess, src=wikt
lin pond_N = mkN "stagno" ; -- status=guess
lin adventure_N = mkN "avventura" ; -- status=guess
lin diplomatic_A = mkA "diplomatico" ; -- status=guess
lin mixed_A = variants{} ; -- 
lin rebel_N = mkN "ribelle" masculine ; -- status=guess
lin equity_N = variants{} ; -- 
lin literally_Adv = variants{} ; -- 
lin magnificent_A = mkA "magnifico" ; -- status=guess
lin loyalty_N = mkN "lealtà" feminine ; -- status=guess
lin tremendous_A = variants{} ; -- 
lin airline_N = variants{} ; -- 
lin shore_N = mkN "riva" ; -- status=guess
lin restoration_N = mkN "restauro" ; -- status=guess
lin physically_Adv = variants{} ; -- 
lin render_V2 = variants{} ; -- 
lin institutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (mkV "enfatizzare") | mkVS (mkV "sottolineare") | mkVS (mkV "evidenziare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin emphasize_V2 = mkV2 (mkV "enfatizzare") | mkV2 (mkV "sottolineare") | mkV2 (mkV "evidenziare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mess_N = mkN "messa" ; -- status=guess
lin commander_N = variants{} ; -- 
lin straightforward_A = variants{} ; -- 
lin singer_N = mkN "cantante" masculine ; -- status=guess
lin squeeze_V2 = L.squeeze_V2 ;
lin squeeze_V = mkV "spremere" | stringere_V | mkV "serrare" | mkV "strizzare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin full_time_A = variants{} ; -- 
lin breed_V2 = mkV2 (mkV "allevare") ; -- status=guess, src=wikt
lin breed_V = mkV "allevare" ; -- status=guess, src=wikt
lin successor_N = mkN "successore" masculine ; -- status=guess
lin triumph_N = mkN "trionfo" ; -- status=guess
lin heading_N = variants{} ; -- 
lin mathematics_N = mkN "matematica" ; -- status=guess
lin laugh_N = mkN "riso" | mkN "risata" ; -- status=guess status=guess
lin clue_N = mkN "indizio" | mkN "pista" masculine ; -- status=guess status=guess
lin still_A = variants{} ; -- 
lin ease_N = mkN "facilità" feminine ; -- status=guess
lin specially_Adv = variants{} ; -- 
lin biological_A = mkA "consanguineo" | mkA "consanguinea" ; -- status=guess status=guess
lin forgive_V2 = mkV2 (mkV "perdonare") ; -- status=guess, src=wikt
lin forgive_V = mkV "perdonare" ; -- status=guess, src=wikt
lin trustee_N = variants{} ; -- 
lin photo_N = mkN "fotografia" | mkN "foto" feminine ; -- status=guess status=guess
lin fraction_N = mkN "frazione" feminine ; -- status=guess
lin chase_V2 = mkV2 (mkV "inseguire") | mkV2 (mkV "cacciare") ; -- status=guess, src=wikt status=guess, src=wikt
lin chase_V = mkV "inseguire" | mkV "cacciare" ; -- status=guess, src=wikt status=guess, src=wikt
lin whereby_Adv = variants{} ; -- 
lin mud_N = mkN "fango" ; -- status=guess
lin pensioner_N = variants{} ; -- 
lin functional_A = mkA "funzionale" ; -- status=guess
lin copy_V2 = mkV2 (mkV "copiaincollare") ; -- status=guess, src=wikt
lin copy_V = mkV "copiaincollare" ; -- status=guess, src=wikt
lin strictly_Adv = variants{} ; -- 
lin desperately_Adv = variants{} ; -- 
lin await_V2 = mkV2 (mkV "aspettare") | mkV2 (mkV "attendere") ; -- status=guess, src=wikt status=guess, src=wikt
lin coverage_N = variants{} ; -- 
lin wildlife_N = mkN "fauna" ; -- status=guess
lin indicator_N = mkN "freccia" ; -- status=guess
lin lightly_Adv = variants{} ; -- 
lin hierarchy_N = mkN "gerarchia" ; -- status=guess
lin evolve_V2 = variants{} ; -- 
lin evolve_V = variants{} ; -- 
lin mechanical_A = variants{} ; -- 
lin expert_A = variants{} ; -- 
lin creditor_N = mkN "creditore" masculine ; -- status=guess
lin capitalist_N = variants{} ; -- 
lin essence_N = mkN "essenza" masculine ; -- status=guess
lin compose_V2 = mkV2 (comporre_V) ; -- status=guess, src=wikt
lin compose_V = comporre_V ; -- status=guess, src=wikt
lin mentally_Adv = variants{} ; -- 
lin gaze_N = mkN "occhiata" ; -- status=guess
lin seminar_N = variants{} ; -- 
lin target_V2V = variants{} ; -- 
lin target_V2 = variants{} ; -- 
lin label_V3 = mkV3 (mkV "etichettare") ; -- status=guess, src=wikt
lin label_V2 = mkV2 (mkV "etichettare") ; -- status=guess, src=wikt
lin label_V = mkV "etichettare" ; -- status=guess, src=wikt
lin fig_N = mkN "fico" ; -- status=guess
lin continent_N = mkN "continente" masculine ; -- status=guess
lin chap_N = mkN "tipo" | mkN "tizio" ; -- status=guess status=guess
lin flexibility_N = mkN "flessibilità" feminine ; -- status=guess
lin verse_N = variants{} ; -- 
lin minute_A = mkA "minuscolo" | mkA "piccolissimo" ; -- status=guess status=guess
lin whisky_N = variants{} ; -- 
lin equivalent_A = variants{} ; -- 
lin recruit_V2 = variants{} ; -- 
lin recruit_V = variants{} ; -- 
lin echo_V2 = variants{} ; -- 
lin echo_V = variants{} ; -- 
lin unfair_A = mkA "scorretto" ; -- status=guess
lin launch_N = variants{} ; -- 
lin cupboard_N = mkN "armadio" | mkN "credenza" ; -- status=guess status=guess
lin bush_N = mkN "arbusto" | mkN "cespuglio" ; -- status=guess status=guess
lin shortage_N = mkN "scarsità" feminine ; -- status=guess
lin prominent_A = mkA "prominente" | mkA "rilevante" ; -- status=guess status=guess
lin merger_N = mkN "fusione" feminine | mkN "unione" feminine ; -- status=guess status=guess
lin command_V2 = variants{} ; -- 
lin command_V = variants{} ; -- 
lin subtle_A = mkA "sottile" ; -- status=guess
lin capital_A = mkA "ottimo" | mkA "magnifico" | mkA "eccellente" | mkA "splendido" ; -- status=guess status=guess status=guess status=guess
lin gang_N = mkN "ghenga" ; -- status=guess
lin fish_V2 = mkV2 (mkV "pescare") ; -- status=guess, src=wikt
lin fish_V = mkV "pescare" ; -- status=guess, src=wikt
lin unhappy_A = variants{} ; -- 
lin lifetime_N = variants{} ; -- 
lin elite_N = mkN "élite" feminine ; -- status=guess
lin refusal_N = mkN "rifiuto" ; -- status=guess
lin finish_N = mkN "fine" feminine ; -- status=guess
lin aggressive_A = mkA "aggressivo" ; -- status=guess
lin superior_A = mkA "superiore" ; -- status=guess
lin landing_N = mkN "imbarcadero" ; -- status=guess
lin exchange_V2 = mkV2 (mkV "cambiare") | mkV2 (mkV "scambiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin debate_V2 = mkV2 (mkV "dibattere") ; -- status=guess, src=wikt
lin debate_V = mkV "dibattere" ; -- status=guess, src=wikt
lin educate_V2 = mkV2 (mkV "istruire") | mkV2 (mkV "educare") ; -- status=guess, src=wikt status=guess, src=wikt
lin separation_N = mkN "separazione" feminine ; -- status=guess
lin productivity_N = mkN "produttività" feminine ; -- status=guess
lin initiate_V2 = mkV2 (mkV "iniziare") | mkV2 (mkV "cominciare") | mkV2 (mkV "presentare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin probability_N = mkN "probabilità" feminine ; -- status=guess
lin virus_N = variants{} ; -- 
lin reporter_N = variants{} ; -- 
lin fool_N = mkN "il matto" | mkN "il folle" ; -- status=guess status=guess
lin pop_V2 = mkV2 (mkV "spuntare") | mkV2 (mkV (mkV "saltare") "fuori") ; -- status=guess, src=wikt status=guess, src=wikt
lin capitalism_N = mkN "capitalismo" ; -- status=guess
lin painful_A = mkA "doloroso" ; -- status=guess
lin correctly_Adv = variants{} ; -- 
lin complex_N = mkN "numero complesso" ; -- status=guess
lin rumour_N = variants{} ; -- 
lin imperial_A = variants{} ; -- 
lin justification_N = mkN "giustificazione" feminine | mkN "ragione" feminine | mkN "spiegazione" feminine | mkN "scusa" ; -- status=guess status=guess status=guess status=guess
lin availability_N = mkN "disponibilità" feminine | mkN "reperibilità" feminine ; -- status=guess status=guess
lin spectacular_A = variants{} ; -- 
lin remain_N = variants{} ; -- 
lin ocean_N = mkN "oceano" ; -- status=guess
lin cliff_N = mkN "rupe" | mkN "scogliera" ; -- status=guess status=guess
lin sociology_N = mkN "sociologia" ; -- status=guess
lin sadly_Adv = variants{} ; -- 
lin missile_N = mkN "missile" ; -- status=guess
lin situate_V2 = variants{} ; -- 
lin artificial_A = mkA "artificioso" | mkA "falso" ; -- status=guess status=guess
lin apartment_N = L.apartment_N ;
lin provoke_V2 = variants{} ; -- 
lin oral_A = mkA "orale" ; -- status=guess
lin maximum_N = mkN "massimo" ; -- status=guess
lin angel_N = mkN "angelo" ; -- status=guess
lin spare_A = variants{} ; -- 
lin shame_N = mkN "vergogna" ; -- status=guess
lin intelligent_A = mkA "intelligente" ; -- status=guess
lin discretion_N = variants{} ; -- 
lin businessman_N = mkN "uomo d'affari" ; -- status=guess
lin explicit_A = variants{} ; -- 
lin book_V2 = mkV2 (mkV "ammonire") ; -- status=guess, src=wikt
lin uniform_N = mkN "uniforme" masculine ; -- status=guess
lin push_N = mkN "flessione" masculine ; -- status=guess
lin counter_N = mkN "contrattacco" ; -- status=guess
lin subject_A = variants{} ; -- 
lin objective_A = mkA "obiettivo" ; -- status=guess
lin hungry_A = mkA "affamato" ; -- status=guess
lin clothing_N = mkN "abbigliamento" ; -- status=guess
lin ride_N = mkN "giostra" ; -- status=guess
lin romantic_A = mkA "romantico" ; -- status=guess
lin attendance_N = variants{} ; -- 
lin part_time_A = variants{} ; -- 
lin trace_N = mkN "orma" ; -- status=guess
lin backing_N = variants{} ; -- 
lin sensation_N = mkN "sensazione" feminine | mkN "senso" | mkN "sensazione" feminine | mkN "impressione" feminine ; -- status=guess status=guess status=guess status=guess
lin carrier_N = mkN "sacco di plastica" ; -- status=guess
lin interest_V2 = variants{} ; -- 
lin interest_V = variants{} ; -- 
lin classification_N = mkN "classificazione" feminine ; -- status=guess
lin classic_N = mkN "classico" ; -- status=guess
lin beg_V2 = mkV2 (mkV "mendicare") | mkV2 (mkV "elemosinare") ; -- status=guess, src=wikt status=guess, src=wikt
lin beg_V = mkV "mendicare" | mkV "elemosinare" ; -- status=guess, src=wikt status=guess, src=wikt
lin appendix_N = mkN "appendice" feminine ; -- status=guess
lin doorway_N = mkN "uscio" | mkN "via di accesso" ; -- status=guess status=guess
lin density_N = mkN "densità" feminine ; -- status=guess
lin working_class_A = variants{} ; -- 
lin legislative_A = mkA "legislativo" ; -- status=guess
lin hint_N = mkN "accenno" | mkN "allusione" feminine | mkN "indizio" | mkN "aiuto" | mkN "dritta" | mkN "suggerimento" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin shower_N = mkN "acquazzone" masculine | mkN "scroscio di pioggia" | mkN "rovescio di pioggia" ; -- status=guess status=guess status=guess
lin current_N = mkN "corrente" feminine ; -- status=guess
lin succession_N = variants{} ; -- 
lin nasty_A = variants{} ; -- 
lin duration_N = mkN "durata" ; -- status=guess
lin desert_N = mkN "isola deserta" ; -- status=guess
lin receipt_N = mkN "ricezione" feminine ; -- status=guess
lin native_A = mkA "nativo" ; -- status=guess
lin chapel_N = mkN "cappella" | mkN "chiesetta" ; -- status=guess status=guess
lin amazing_A = mkA "meraviglioso" | mkA "sorprendente" | mkA "sbalorditivo" ; -- status=guess status=guess status=guess
lin hopefully_Adv = variants{} ; -- 
lin fleet_N = mkN "flotta" ; -- status=guess
lin comparable_A = mkA "comparabile" ; -- status=guess
lin oxygen_N = mkN "ossigeno" ; -- status=guess
lin installation_N = mkN "installazione" feminine ; -- status=guess
lin developer_N = mkN "sviluppatore" masculine ; -- status=guess
lin disadvantage_N = variants{} ; -- 
lin recipe_N = mkN "ricetta" ; -- status=guess
lin crystal_N = mkN "cristallo" ; -- status=guess
lin modification_N = mkN "modificazione" feminine ; -- status=guess
lin schedule_V2V = variants{} ; -- 
lin schedule_V2 = variants{} ; -- 
lin schedule_V = variants{} ; -- 
lin midnight_N = mkN "mezzanotte" feminine ; -- status=guess
lin successive_A = variants{} ; -- 
lin formerly_Adv = variants{} ; -- 
lin loud_A = mkA "rumoroso" ; -- status=guess
lin value_V2 = mkV2 (mkV "valutare") | mkV2 (mkV "stimare") ; -- status=guess, src=wikt status=guess, src=wikt
lin value_V = mkV "valutare" | mkV "stimare" ; -- status=guess, src=wikt status=guess, src=wikt
lin physics_N = mkN "fisica" ; -- status=guess
lin truck_N = mkN "autocarro" | mkN "camion" masculine ; -- status=guess status=guess
lin stroke_N = mkN "colpo" ; -- status=guess
lin kiss_N = mkN "bacio" ; -- status=guess
lin envelope_N = mkN "busta" ; -- status=guess
lin speculation_N = mkN "speculazione" feminine ; -- status=guess
lin canal_N = mkN "canale" masculine ; -- status=guess
lin unionist_N = variants{} ; -- 
lin directory_N = mkN "elenco telefonico" ; -- status=guess
lin receiver_N = mkN "[telephone] cornetta" ; -- status=guess
lin isolation_N = mkN "isolamento" ; -- status=guess
lin fade_V2 = variants{} ; -- 
lin fade_V = variants{} ; -- 
lin chemistry_N = mkN "chimica" ; -- status=guess
lin unnecessary_A = mkA "inutile" ; -- status=guess
lin hit_N = mkN "colpo" ; -- status=guess
lin defender_N = variants{} ; -- 
lin stance_N = mkN "postura" ; -- status=guess
lin sin_N = mkN "peccato" ; -- status=guess
lin realistic_A = mkA "realistico" ; -- status=guess
lin socialist_N = variants{} ; -- 
lin subsidy_N = variants{} ; -- 
lin content_A = mkA "contento" ; -- status=guess
lin toy_N = mkN "giocattolo" | mkN "balocco" ; -- status=guess status=guess
lin darling_N = mkN "tesoro" | mkN "amore" masculine ; -- status=guess status=guess
lin decent_A = mkA "presentabile" ; -- status=guess
lin liberty_N = mkN "libertà" feminine ; -- status=guess
lin forever_Adv = mkAdv "per sempre" ; -- status=guess
lin skirt_N = mkN "gonna" ; -- status=guess
lin coordinate_V2 = mkV2 (mkV "coordinare") ; -- status=guess, src=wikt
lin coordinate_V = mkV "coordinare" ; -- status=guess, src=wikt
lin tactic_N = mkN "tattica" | mkN "stratagemma" masculine | mkN "piano" | mkN "programma" masculine ; -- status=guess status=guess status=guess status=guess
lin influential_A = mkA "autorevole" ; -- status=guess
lin import_V2 = mkV2 (mkV "importare") ; -- status=guess, src=wikt
lin accent_N = mkN "accento" ; -- status=guess
lin compound_N = mkN "composto" | mkN "miscuglio" | mkN "amalgama" masculine ; -- status=guess status=guess status=guess
lin bastard_N = mkN "bastardo" | mkN "figlio di puttana" ; -- status=guess status=guess
lin ingredient_N = mkN "ingrediente" masculine ; -- status=guess
lin dull_A = L.dull_A ;
lin cater_V = variants{} ; -- 
lin scholar_N = mkN "erudito" | mkN "dotto" ; -- status=guess status=guess
lin faint_A = mkA "incerto" | mkA "indistinto" ; -- status=guess status=guess
lin ghost_N = mkN "fantasma" masculine | mkN "spettro" | mkN "spirito" | mkN "larva" | mkN "apparizione" feminine | mkN "ombra" | mkN "anima" | mkN "simulacro" | mkN "fantasima" | mkN "lemure" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin sculpture_N = mkN "scultura" ; -- status=guess
lin ridiculous_A = mkA "ridicolo" ; -- status=guess
lin diagnosis_N = mkN "diagnosi" feminine ; -- status=guess
lin delegate_N = variants{} ; -- 
lin neat_A = mkA "puro" ; -- status=guess
lin kit_N = mkN "corredo" ; -- status=guess
lin lion_N = mkN "leone" feminine ; -- status=guess
lin dialogue_N = mkN "dialogo" ; -- status=guess
lin repair_V2 = mkV2 (mkV "riparare") ; -- status=guess, src=wikt
lin repair_V = mkV "riparare" ; -- status=guess, src=wikt
lin tray_N = mkN "barra" ; -- status=guess
lin fantasy_N = mkN "fantasia" ; -- status=guess
lin leave_N = mkN "partenza" ; -- status=guess
lin export_V2 = mkV2 (mkV "esportare") ; -- status=guess, src=wikt
lin export_V = mkV "esportare" ; -- status=guess, src=wikt
lin forth_Adv = variants{} ; -- 
lin lamp_N = L.lamp_N ;
lin allege_VS = variants{} ; -- 
lin allege_V2 = variants{} ; -- 
lin pavement_N = mkN "marciapiede" masculine ; -- status=guess
lin brand_N = variants{} ; -- 
lin constable_N = mkN "appuntato" | mkN "agente" masculine ; -- status=guess status=guess
lin compromise_N = variants{} ; -- 
lin flag_N = mkN "bandiera" ; -- status=guess
lin filter_N = mkN "filtro" ; -- status=guess
lin reign_N = variants{} ; -- 
lin execute_V2 = variants{} ; -- 
lin pity_N = mkN "pietà" feminine ; -- status=guess
lin merit_N = mkN "merito" ; -- status=guess
lin diagram_N = mkN "diagramma" masculine ; -- status=guess
lin wool_N = mkN "lana" ; -- status=guess
lin organism_N = mkN "organismo" ; -- status=guess
lin elegant_A = mkA "elegante" ; -- status=guess
lin red_N = mkN "rosso" ; -- status=guess
lin undertaking_N = mkN "garanzia" ; -- status=guess
lin lesser_A = variants{} ; -- 
lin reach_N = variants{} ; -- 
lin marvellous_A = variants{} ; -- 
lin improved_A = variants{} ; -- 
lin locally_Adv = variants{} ; -- 
lin entity_N = variants{} ; -- 
lin rape_N = mkN "stupro" | mkN "violento" ; -- status=guess status=guess
lin secure_A = variants{} ; -- 
lin descend_V2 = mkV2 (scendere_V) ; -- status=guess, src=wikt
lin descend_V = scendere_V ; -- status=guess, src=wikt
lin backwards_Adv = variants{} ; -- 
lin peer_V = mkV "scrutare" | mkV "sbirciare" ; -- status=guess, src=wikt status=guess, src=wikt
lin excuse_V2 = mkV2 (mkV "scusare") ; -- status=guess, src=wikt
lin genetic_A = mkA "genetico" ; -- status=guess
lin fold_V2 = mkV2 (mkV "piegare") ; -- status=guess, src=wikt
lin fold_V = mkV "piegare" ; -- status=guess, src=wikt
lin portfolio_N = mkN "cartella" ; -- status=guess
lin consensus_N = mkN "consenso" ; -- status=guess
lin thesis_N = mkN "tesi" feminine ;
lin shop_V = mkV (andare_V) "per negozi" ; -- status=guess, src=wikt
lin nest_N = mkN "nido" ; -- status=guess
lin frown_V = mkV "accigliarsi" | mkV "corrucciarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin builder_N = mkN "costruttore" masculine ; -- status=guess
lin administer_V2 = mkV2 (mkV "amministrare") ; -- status=guess, src=wikt
lin administer_V = mkV "amministrare" ; -- status=guess, src=wikt
lin tip_V2 = mkV2 (mkV (mkV "lasciare") "mancia") ; -- status=guess, src=wikt
lin tip_V = mkV (mkV "lasciare") "mancia" ; -- status=guess, src=wikt
lin lung_N = mkN "polmone" masculine ; -- status=guess
lin delegation_N = variants{} ; -- 
lin outside_N = variants{} ; -- 
lin heating_N = mkN "riscaldamento" ; -- status=guess
lin like_Subj = variants{} ; -- 
lin instinct_N = mkN "istinto" ; -- status=guess
lin teenager_N = mkN "giovincello" | mkN "adolescente" ; -- status=guess status=guess
lin lonely_A = mkA "solo" | mkA "solitario" | mkA "malinconico" ; -- status=guess status=guess status=guess
lin residence_N = mkN "residenza" ; -- status=guess
lin radiation_N = mkN "radiazione" feminine | mkN "irraggiamento" ; -- status=guess status=guess
lin extract_V2 = mkV2 (mkV "cavare") ; -- status=guess, src=wikt
lin concession_N = variants{} ; -- 
lin autonomy_N = mkN "autonomia" ; -- status=guess
lin norm_N = mkN "norma" ; -- status=guess
lin musician_N = variants{} ; -- 
lin graduate_N = mkN "diplomato" | mkN "diplomata" ; -- status=guess status=guess
lin glory_N = mkN "gloria" ; -- status=guess
lin bear_N = mkN "cucciolo di orso" | mkN "orsetto" ; -- status=guess status=guess
lin persist_V = persistere_V ; -- status=guess, src=wikt
lin rescue_V2 = mkV2 (mkV "salvare") ; -- status=guess, src=wikt
lin equip_V2 = variants{} ; -- 
lin partial_A = mkA "parziale" ; -- status=guess
lin officially_Adv = variants{} ; -- 
lin capability_N = variants{} ; -- 
lin worry_N = mkN "preoccupazione" feminine ; -- status=guess
lin liberation_N = mkN "liberazione" feminine ; -- status=guess
lin hunt_V2 = L.hunt_V2 ;
lin hunt_V = mkV "cacciare" ; -- status=guess, src=wikt
lin daily_Adv = mkAdv "quotidianamente" | mkAdv "giornalmente" | mkAdv "ogni giorno" | mkAdv "tutti i giorni" ; -- status=guess status=guess status=guess status=guess
lin heel_N = mkN "cantuccio" ; -- status=guess
lin contract_V2V = mkV2V (contrarre_V) ; -- status=guess, src=wikt
lin contract_V2 = mkV2 (contrarre_V) ; -- status=guess, src=wikt
lin contract_V = contrarre_V ; -- status=guess, src=wikt
lin update_V2 = mkV2 (mkV "aggiornare") ; -- status=guess, src=wikt
lin assign_V2V = mkV2V (mkV "assegnare") ; -- status=guess, src=wikt
lin assign_V2 = mkV2 (mkV "assegnare") ; -- status=guess, src=wikt
lin spring_V2 = mkV2 (mkV "saltare") ; -- status=guess, src=wikt
lin spring_V = mkV "saltare" ; -- status=guess, src=wikt
lin single_N = mkN "celibe" masculine | mkN "nubile" ; -- status=guess status=guess
lin commons_N = variants{} ; -- 
lin weekly_A = mkA "settimanale" ; -- status=guess
lin stretch_N = mkN "smagliatura" ; -- status=guess
lin pregnancy_N = mkN "gravidanza" ; -- status=guess
lin happily_Adv = variants{} ; -- 
lin spectrum_N = mkN "spettro" ; -- status=guess
lin interfere_V = mkV "impedire" ; -- status=guess, src=wikt
lin suicide_N = mkN "suicidio" ; -- status=guess
lin panic_N = mkN "panico" ; -- status=guess
lin invent_V2 = mkV2 (mkV "inventare") ; -- status=guess, src=wikt
lin invent_V = mkV "inventare" ; -- status=guess, src=wikt
lin intensive_A = variants{} ; -- 
lin damp_A = mkA "umidità" | mkA "umido" ; -- status=guess status=guess
lin simultaneously_Adv = variants{} ; -- 
lin giant_N = mkN "gigante" feminine ; -- status=guess
lin casual_A = variants{} ; -- 
lin sphere_N = mkN "sfera" ; -- status=guess
lin precious_A = mkA "prezioso" ; -- status=guess
lin sword_N = mkN "spada" masculine | mkN "brando [poetic]" ; -- status=guess status=guess
lin envisage_V2 = variants{} ; -- 
lin bean_N = mkN "fagiolo" ; -- status=guess
lin time_V2 = mkV2 (mkV "fissare") | mkV2 (mkV "programmare") ; -- status=guess, src=wikt status=guess, src=wikt
lin crazy_A = mkA "pazzo" ; -- status=guess
lin changing_A = variants{} ; -- 
lin primary_N = mkN "alcol primario" ; -- status=guess
lin concede_VS = variants{} ; -- 
lin concede_V2 = variants{} ; -- 
lin concede_V = variants{} ; -- 
lin besides_Adv = mkAdv "inoltre" ; -- status=guess
lin unite_V2 = mkV2 (mkV "unire") ; -- status=guess, src=wikt
lin unite_V = mkV "unire" ; -- status=guess, src=wikt
lin severely_Adv = variants{} ; -- 
lin separately_Adv = variants{} ; -- 
lin instruct_V2 = variants{} ; -- 
lin insert_V2 = mkV2 (mkV "inserire") ; -- status=guess, src=wikt
lin go_N = mkN "approvazione" feminine ; -- status=guess
lin exhibit_V2 = mkV2 (mkV "dimostrare") ; -- status=guess, src=wikt
lin brave_A = mkA "coraggioso" | mkA "ardito" | mkA "baldo" | mkA "audace" | mkA "valoroso" ; -- status=guess status=guess status=guess status=guess status=guess
lin tutor_N = variants{} ; -- 
lin tune_N = variants{} ; -- 
lin debut_N = mkN "debutto" ; -- status=guess
lin debut_2_N = variants{} ; -- 
lin debut_1_N = variants{} ; -- 
lin continued_A = variants{} ; -- 
lin bid_V2 = mkV2 (mkV (I.fare_V) "un'offerta per un'asta") ; -- status=guess, src=wikt
lin bid_V = mkV (I.fare_V) "un'offerta per un'asta" ; -- status=guess, src=wikt
lin incidence_N = variants{} ; -- 
lin downstairs_Adv = mkAdv "giù" ; -- status=guess
lin cafe_N = variants{} ; -- 
lin regret_VS = mkVS (rimpiangere_V) | mkVS (mkV "rammaricarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin regret_V2 = mkV2 (rimpiangere_V) | mkV2 (mkV "rammaricarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin killer_N = mkN "assassino" ; -- status=guess
lin delicate_A = mkA "delicato" ; -- status=guess
lin subsidiary_N = mkN "filiale" feminine ; -- status=guess
lin gender_N = mkN "genere" masculine ; -- status=guess
lin entertain_V2 = mkV2 (mkV "divertire") ; -- status=guess, src=wikt
lin cling_V = mkV "aggrapparsi" | mkV "abbarbicarsi" | mkV "appiccicarsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin vertical_A = mkA "verticale" ; -- status=guess
lin fetch_V2 = mkV2 (valere_V) ; -- status=guess, src=wikt
lin strip_V2 = mkV2 (mkV (mkV "striscia") "d'asfalto") | mkV2 (mkV "strada") ; -- status=guess, src=wikt status=guess, src=wikt
lin strip_V = mkV (mkV "striscia") "d'asfalto" | mkV "strada" ; -- status=guess, src=wikt status=guess, src=wikt
lin plead_VS = variants{} ; -- 
lin plead_V2 = variants{} ; -- 
lin plead_V = variants{} ; -- 
lin duck_N = mkN "anatra" | mkN "papero" ; -- status=guess status=guess
lin breed_N = variants{} ; -- 
lin assistant_A = variants{} ; -- 
lin pint_N = mkN "pinta di latte" ; -- status=guess
lin abolish_V2 = mkV2 (mkV "abolire") ; -- status=guess, src=wikt
lin translation_N = mkN "traduzione" feminine ;
lin princess_N = mkN "principessa" ; -- status=guess
lin line_V2 = mkV2 (mkV "allineare") ; -- status=guess, src=wikt
lin line_V = mkV "allineare" ; -- status=guess, src=wikt
lin excessive_A = mkA "eccessivo" ; -- status=guess
lin digital_A = mkA "digitale" ; -- status=guess
lin steep_A = mkA "scosceso" | mkA "ripido" ; -- status=guess status=guess
lin jet_N = variants{} ; -- 
lin hey_Interj = mkInterj "ehi" ; -- status=guess
lin grave_N = mkN "fossa" ; -- status=guess
lin exceptional_A = mkA "eccezionale" ; -- status=guess
lin boost_V2 = variants{} ; -- 
lin random_A = mkA "casuale" | mkA "fortuito" | mkA "fortuito" ; -- status=guess status=guess status=guess
lin correlation_N = mkN "correlazione" feminine ; -- status=guess
lin outline_N = mkN "contorno" ; -- status=guess
lin intervene_V2V = mkV2V (intervenire_V) | mkV2V (mkV "interferire") ; -- status=guess, src=wikt status=guess, src=wikt
lin intervene_V = intervenire_V | mkV "interferire" ; -- status=guess, src=wikt status=guess, src=wikt
lin packet_N = mkN "pacchetto" ; -- status=guess
lin motivation_N = variants{} ; -- 
lin safely_Adv = variants{} ; -- 
lin harsh_A = mkA "grossolano" | mkA "ruvido" | mkA "rude" | mkA "aspro" | mkA "accidentato" | mkA "gibboso" | mkA "discordante" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin spell_N = mkN "incantesimo" | mkN "formula magica" ; -- status=guess status=guess
lin spread_N = mkN "imbandigione" feminine ; -- status=guess
lin draw_N = mkN "riffa" ; -- status=guess
lin concrete_A = mkA "in di cemento" ; -- status=guess
lin complicated_A = variants{} ; -- 
lin alleged_A = variants{} ; -- 
lin redundancy_N = mkN "ridondanza" ; -- status=guess
lin progressive_A = variants{} ; -- 
lin intensity_N = mkN "intensità" feminine ; -- status=guess
lin crack_N = mkN "stecca" ; -- status=guess
lin fly_N = mkN "mosca" ; -- status=guess
lin fancy_V2 = variants{} ; -- 
lin alternatively_Adv = variants{} ; -- 
lin waiting_A = variants{} ; -- 
lin scandal_N = mkN "scandalo" ; -- status=guess
lin resemble_V2 = mkV2 (mkV "rassomigliare") ; -- status=guess, src=wikt
lin parameter_N = mkN "parametro" ; -- status=guess
lin fierce_A = mkA "feroce" ; -- status=guess
lin tropical_A = mkA "tropicale" ; -- status=guess
lin colour_V2A = variants{} ; -- 
lin colour_V2 = variants{} ; -- 
lin colour_V = variants{} ; -- 
lin engagement_N = variants{} ; -- 
lin contest_N = mkN "concorso" ; -- status=guess
lin edit_V2 = mkV2 (redigere_V) ; -- status=guess, src=wikt
lin courage_N = mkN "coraggio" ; -- status=guess
lin hip_N = mkN "anca" ; -- status=guess
lin delighted_A = variants{} ; -- 
lin sponsor_V2 = variants{} ; -- 
lin carer_N = variants{} ; -- 
lin crack_V2 = mkV2 (mkV "stonare") ; -- status=guess, src=wikt
lin substantially_Adv = variants{} ; -- 
lin occupational_A = variants{} ; -- 
lin trainer_N = mkN "allenatore" masculine ; -- status=guess
lin remainder_N = mkN "resto" | mkN "avanzo" ; -- status=guess status=guess
lin related_A = variants{} ; -- 
lin inherit_V2 = mkV2 (mkV "ereditare") ; -- status=guess, src=wikt
lin inherit_V = mkV "ereditare" ; -- status=guess, src=wikt
lin resume_V2 = variants{} ; -- 
lin resume_V = variants{} ; -- 
lin assignment_N = variants{} ; -- 
lin conceal_V2 = mkV2 (mkV "nascondere") | mkV2 (mkV "celare") ; -- status=guess, src=wikt status=guess, src=wikt
lin disclose_VS = mkVS (mkV "svelare") | mkVS (mkV "scoperchiare") | mkVS (mkV (mkV "far") "noto") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V2 = mkV2 (mkV "svelare") | mkV2 (mkV "scoperchiare") | mkV2 (mkV (mkV "far") "noto") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V = mkV "svelare" | mkV "scoperchiare" | mkV (mkV "far") "noto" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exclusively_Adv = variants{} ; -- 
lin working_N = variants{} ; -- 
lin mild_A = mkA "delicato" | mkA "delicata" | mkA "mite" ; -- status=guess status=guess status=guess
lin chronic_A = mkA "cronico" ; -- status=guess
lin splendid_A = mkA "splendido" ; -- status=guess
lin function_V = mkV "funzionare" ; -- status=guess, src=wikt
lin rider_N = variants{} ; -- 
lin clay_N = mkN "argilla" | mkN "creta" ; -- status=guess status=guess
lin firstly_Adv = variants{} ; -- 
lin conceive_V2 = mkV2 (mkV "concepire") ; -- status=guess, src=wikt
lin conceive_V = mkV "concepire" ; -- status=guess, src=wikt
lin politically_Adv = variants{} ; -- 
lin terminal_N = variants{} ; -- 
lin accuracy_N = mkN "esattezza" | mkN "precisione" feminine | mkN "accuratezza" ; -- status=guess status=guess status=guess
lin coup_N = mkN "colpo di stato" ; -- status=guess
lin ambulance_N = mkN "ambulanza" ; -- status=guess
lin living_N = mkN "soggiorno" | mkN "salotto" ; -- status=guess status=guess
lin offender_N = variants{} ; -- 
lin similarity_N = variants{} ; -- 
lin orchestra_N = mkN "orchestra" ; -- status=guess
lin brush_N = mkN "spazzola" | mkN "pennello" ; -- status=guess status=guess
lin systematic_A = variants{} ; -- 
lin striker_N = variants{} ; -- 
lin guard_V2 = mkV2 (mkV "custodire") | mkV2 (mkV "proteggere") ; -- status=guess, src=wikt status=guess, src=wikt
lin guard_V = mkV "custodire" | mkV "proteggere" ; -- status=guess, src=wikt status=guess, src=wikt
lin casualty_N = mkN "ferito" ; -- status=guess
lin steadily_Adv = variants{} ; -- 
lin painter_N = mkN "pittore" masculine | mkN "pittrice" feminine ; -- status=guess status=guess
lin opt_VV = mkVV (mkV "optare") ; -- status=guess, src=wikt
lin opt_V = mkV "optare" ; -- status=guess, src=wikt
lin handsome_A = mkA "bello" ; -- status=guess
lin banking_N = variants{} ; -- 
lin sensitivity_N = mkN "sensibilità" ; -- status=guess
lin navy_N = mkN "marina" ; -- status=guess
lin fascinating_A = variants{} ; -- 
lin disappointment_N = variants{} ; -- 
lin auditor_N = variants{} ; -- 
lin hostility_N = mkN "ostilità" feminine ; -- status=guess
lin spending_N = variants{} ; -- 
lin scarcely_Adv = variants{} ; -- 
lin compulsory_A = mkA "obbligatorio" ; -- status=guess
lin photographer_N = mkN "fotografo" ; -- status=guess
lin ok_Interj = variants{} ; -- 
lin neighbourhood_N = mkN "vicinato" | mkN "quartiere" masculine ; -- status=guess status=guess
lin ideological_A = mkA "ideologico" ; -- status=guess
lin wide_Adv = mkAdv "largo" ; -- status=guess
lin pardon_N = variants{} ; -- 
lin double_N = mkN "doppio" ; -- status=guess
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin supervision_N = variants{} ; -- 
lin guilt_N = mkN "senso di colpa" ; -- status=guess
lin deck_N = mkN "sdraio" | mkN "sedia a sdraio" ; -- status=guess status=guess
lin payable_A = variants{} ; -- 
lin execution_N = mkN "esecuzione" feminine ; -- status=guess
lin suite_N = variants{} ; -- 
lin elected_A = variants{} ; -- 
lin solely_Adv = variants{} ; -- 
lin moral_N = mkN "panico morale" ; -- status=guess
lin collector_N = mkN "collezionista" masculine ; -- status=guess
lin questionnaire_N = mkN "questionario" ; -- status=guess
lin flavour_N = mkN "sapori" | mkN "fragranza" | mkN "aroma" masculine ; -- status=guess status=guess status=guess
lin couple_V2 = mkV2 (mkV "agganciare") ; -- status=guess, src=wikt
lin couple_V = mkV "agganciare" ; -- status=guess, src=wikt
lin faculty_N = variants{} ; -- 
lin tour_V2 = variants{} ; -- 
lin tour_V = variants{} ; -- 
lin basket_N = mkN "canestro" ; -- status=guess
lin mention_N = variants{} ; -- 
lin kick_N = mkN "calcio" | mkN "piedata" | mkN "colpo di piede" ; -- status=guess status=guess status=guess
lin horizon_N = mkN "orizzonte" ; -- status=guess
lin drain_V2 = mkV2 (mkV "scolo") ; -- status=guess, src=wikt
lin drain_V = mkV "scolo" ; -- status=guess, src=wikt
lin happiness_N = mkN "felicità" feminine | mkN "allegria" ; -- status=guess status=guess
lin fighter_N = mkN "caccia" masculine ; -- status=guess
lin estimated_A = variants{} ; -- 
lin copper_N = mkN "rame" masculine ; -- status=guess
lin legend_N = mkN "legenda" ; -- status=guess
lin relevance_N = variants{} ; -- 
lin decorate_V2 = variants{} ; -- 
lin continental_A = mkA "continentale" ; -- status=guess
lin ship_V2 = mkV2 (mkV "spedire") ; -- status=guess, src=wikt
lin ship_V = mkV "spedire" ; -- status=guess, src=wikt
lin operational_A = variants{} ; -- 
lin incur_V2 = variants{} ; -- 
lin parallel_A = mkA "parallelo" ; -- status=guess
lin divorce_N = mkN "divorzio" ; -- status=guess
lin opposed_A = variants{} ; -- 
lin equilibrium_N = mkN "equilibrio" ; -- status=guess
lin trader_N = variants{} ; -- 
lin ton_N = mkN "tonnellata" ; -- status=guess
lin can_N = mkN "annaffiatoio" ; -- status=guess
lin juice_N = mkN "succo" | mkN "spremuta" ; -- status=guess status=guess
lin forum_N = mkN "forum" masculine ; -- status=guess
lin spin_V2 = mkV2 (mkV "filare") ; -- status=guess, src=wikt
lin spin_V = mkV "filare" ; -- status=guess, src=wikt
lin research_V2 = variants{} ; -- 
lin research_V = variants{} ; -- 
lin hostile_A = variants{} ; -- 
lin consistently_Adv = variants{} ; -- 
lin technological_A = mkA "tecnologico" ; -- status=guess
lin nightmare_N = mkN "incubo" ; -- status=guess
lin medal_N = mkN "medaglia" ; -- status=guess
lin diamond_N = mkN "diamante" masculine ; -- status=guess
lin speed_V2 = variants{} ; -- 
lin speed_V = variants{} ; -- 
lin peaceful_A = mkA "pacifico" | mkA "placido" | mkA "tranquillo" ; -- status=guess status=guess status=guess
lin accounting_A = variants{} ; -- 
lin scatter_V2 = mkV2 (deflettere_V) ; -- status=guess, src=wikt
lin scatter_V = deflettere_V ; -- status=guess, src=wikt
lin monster_N = mkN "mostro" ; -- status=guess
lin horrible_A = mkA "orribile" | mkA "terribile" ; -- status=guess status=guess
lin nonsense_N = mkN "sciocchezza" | mkN "senza senso" | mkN "priva di significato" | mkN "ridicolaggine" feminine ; -- status=guess status=guess status=guess status=guess
lin chaos_N = mkN "caos" masculine ; -- status=guess
lin accessible_A = mkA "accessibile" ; -- status=guess
lin humanity_N = mkN "umanità" feminine ; -- status=guess
lin frustration_N = mkN "frustrazione" feminine ; -- status=guess
lin chin_N = mkN "mento" ; -- status=guess
lin bureau_N = mkN "cassettone" masculine | mkN "comò" ; -- status=guess status=guess
lin advocate_VS = variants{} ; -- 
lin advocate_V2 = variants{} ; -- 
lin polytechnic_N = variants{} ; -- 
lin inhabitant_N = mkN "abitante" masculine ; -- status=guess
lin evil_A = mkA "malvagio" ; -- status=guess
lin slave_N = mkN "schiava" ; -- status=guess
lin reservation_N = mkN "prenotazione" feminine ; -- status=guess
lin slam_V2 = variants{} ; -- 
lin slam_V = variants{} ; -- 
lin handle_N = variants{} ; -- 
lin provincial_A = variants{} ; -- 
lin fishing_N = mkN "pesca" ; -- status=guess
lin facilitate_V2 = variants{} ; -- 
lin yield_N = mkN "raccolto" | mkN "produzione" feminine ; -- status=guess status=guess
lin elbow_N = mkN "gomito" ; -- status=guess
lin bye_Interj = mkInterj "ciao" ; -- status=guess
lin warm_V2 = mkV2 (mkV (mkV "accostarsi") "a") | mkV2 (mkV (mkV "affezionarsi") "a") ; -- status=guess, src=wikt status=guess, src=wikt
lin warm_V = mkV (mkV "accostarsi") "a" | mkV (mkV "affezionarsi") "a" ; -- status=guess, src=wikt status=guess, src=wikt
lin sleeve_N = mkN "stiramaniche" ; -- status=guess
lin exploration_N = mkN "esplorazione" feminine ; -- status=guess
lin creep_V = variants{} ; -- 
lin adjacent_A = mkA "adiacente" ; -- status=guess
lin theft_N = mkN "furto" ; -- status=guess
lin round_V2 = variants{} ; -- 
lin round_V = variants{} ; -- 
lin grace_N = mkN "grazia" | mkN "eleganza" | mkN "garbo" | mkN "leggiadria" ; -- status=guess status=guess status=guess status=guess
lin predecessor_N = mkN "precedente" masculine ; -- status=guess
lin supermarket_N = mkN "supermercato" ; -- status=guess
lin smart_A = variants{} ; -- 
lin sergeant_N = mkN "sergente" ; -- status=guess
lin regulate_V2 = mkV2 (mkV "regolare") ; -- status=guess, src=wikt
lin clash_N = mkN "scontro" | mkN "schermaglia" | mkN "baruffa" | mkN "zuffa" ; -- status=guess status=guess status=guess status=guess
lin assemble_V2 = mkV2 (mkV "riunire") | mkV2 (mkV "riunirsi") | mkV2 (mkV "adunare") | mkV2 (mkV "adunarsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin assemble_V = mkV "riunire" | mkV "riunirsi" | mkV "adunare" | mkV "adunarsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin arrow_N = mkN "freccia" ; -- status=guess
lin nowadays_Adv = mkAdv "oggigiorno" ; -- status=guess
lin giant_A = variants{} ; -- 
lin waiting_N = variants{} ; -- 
lin tap_N = mkN "rubinetto" ; -- status=guess
lin shit_N = mkN "stronzo" ; -- status=guess
lin sandwich_N = mkN "tramezzino" | mkN "panino" ; -- status=guess status=guess
lin vanish_V = mkV "sparire" | mkV "svanire" ; -- status=guess, src=wikt status=guess, src=wikt
lin commerce_N = variants{} ; -- 
lin pursuit_N = mkN "ricerca" ; -- status=guess
lin post_war_A = variants{} ; -- 
lin will_V2 = mkV2 (mkV "legare") | mkV2 (mkV (mkV "lasciare") "in eredità") ; -- status=guess, src=wikt status=guess, src=wikt
lin will_V = mkV "legare" | mkV (mkV "lasciare") "in eredità" ; -- status=guess, src=wikt status=guess, src=wikt
lin waste_A = mkA "incolto" | mkA "deserto" | mkA "arido" ; -- status=guess status=guess status=guess
lin collar_N = mkN "collo" | mkN "anello" | mkN "fascetta" ; -- status=guess status=guess status=guess
lin socialism_N = mkN "socialismo" ; -- status=guess
lin skill_V = variants{} ; -- 
lin rice_N = mkN "risicoltura" ; -- status=guess
lin exclusion_N = mkN "esclusione" feminine ; -- status=guess
lin upwards_Adv = variants{} ; -- 
lin transmission_N = variants{} ; -- 
lin instantly_Adv = variants{} ; -- 
lin forthcoming_A = variants{} ; -- 
lin appointed_A = variants{} ; -- 
lin geographical_A = variants{} ; -- 
lin fist_N = mkN "pugno" ; -- status=guess
lin abstract_A = mkA "astratto" | mkA "teorico" ; -- status=guess status=guess
lin embrace_V2 = variants{} ; -- 
lin embrace_V = variants{} ; -- 
lin dynamic_A = mkA "dinamico" | mkA "dinamica" ; -- status=guess status=guess
lin drawer_N = mkN "disegnatore" masculine ; -- status=guess
lin dismissal_N = variants{} ; -- 
lin magic_N = mkN "magia" ; -- status=guess
lin endless_A = variants{} ; -- 
lin definite_A = mkA "definito" ; -- status=guess
lin broadly_Adv = variants{} ; -- 
lin affection_N = mkN "affetto" ; -- status=guess
lin dawn_N = mkN "albori" masculine | mkN "schiudersi" masculine ; -- status=guess status=guess
lin principal_N = variants{} ; -- 
lin bloke_N = variants{} ; -- 
lin trap_N = mkN "trappola" | mkN "tranello" ; -- status=guess status=guess
lin communist_A = mkA "comunista" ; -- status=guess
lin competence_N = variants{} ; -- 
lin complicate_V2 = mkV2 (mkV "complicare") ; -- status=guess, src=wikt
lin neutral_A = mkA "neutrale" ; -- status=guess
lin fortunately_Adv = variants{} ; -- 
lin commonwealth_N = variants{} ; -- 
lin breakdown_N = mkN "avaria" ; -- status=guess
lin combined_A = variants{} ; -- 
lin candle_N = mkN "candela" ; -- status=guess
lin venue_N = variants{} ; -- 
lin supper_N = mkN "cena" ; -- status=guess
lin analyst_N = mkN "analista" ; -- status=guess
lin vague_A = mkA "vago" ; -- status=guess
lin publicly_Adv = variants{} ; -- 
lin marine_A = variants{} ; -- 
lin fair_Adv = variants{} ; -- 
lin pause_N = mkN "pausa" ; -- status=guess
lin notable_A = mkA "notevole" ; -- status=guess
lin freely_Adv = variants{} ; -- 
lin counterpart_N = variants{} ; -- 
lin lively_A = mkA "vivace" | mkA "brioso" | mkA "briosa" ; -- status=guess status=guess status=guess
lin script_N = variants{} ; -- 
lin sue_V2V = variants{} ; -- 
lin sue_V2 = variants{} ; -- 
lin sue_V = variants{} ; -- 
lin legitimate_A = variants{} ; -- 
lin geography_N = mkN "geografia" ; -- status=guess
lin reproduce_V2 = variants{} ; -- 
lin reproduce_V = variants{} ; -- 
lin moving_A = variants{} ; -- 
lin lamb_N = mkN "agnello" ; -- status=guess
lin gay_A = mkA "effemminato" ; -- status=guess
lin contemplate_VS = variants{} ; -- 
lin contemplate_V2 = variants{} ; -- 
lin contemplate_V = variants{} ; -- 
lin terror_N = mkN "terrore" masculine ; -- status=guess
lin stable_N = mkN "scuderia" | mkN "scuderie" ; -- status=guess status=guess
lin founder_N = variants{} ; -- 
lin utility_N = mkN "fornitore" masculine | mkN "servizio" feminine ; -- status=guess status=guess
lin signal_VS = variants{} ; -- 
lin signal_V2 = variants{} ; -- 
lin shelter_N = mkN "rifugio" ; -- status=guess
lin poster_N = mkN "manifesto" | mkN "locandina" ; -- status=guess status=guess
lin hitherto_Adv = mkAdv "fin qui" | mkAdv "fino a qui" | mkAdv "fino ad ora" | mkAdv "fino allora" | mkAdv "finora" ; -- status=guess status=guess status=guess status=guess status=guess
lin mature_A = mkA "maturo" ; -- status=guess
lin cooking_N = variants{} ; -- 
lin head_A = variants{} ; -- 
lin wealthy_A = mkA "danaroso" ; -- status=guess
lin fucking_A = variants{} ; -- 
lin confess_VS = variants{} ; -- 
lin confess_V2 = variants{} ; -- 
lin confess_V = variants{} ; -- 
lin age_V = variants{} ; -- 
lin miracle_N = mkN "miracolo" ; -- status=guess
lin magic_A = mkA "magico" ; -- status=guess
lin jaw_N = mkN "mandibola" ; -- status=guess
lin pan_N = mkN "panarabismo" ; -- status=guess
lin coloured_A = variants{} ; -- 
lin tent_N = mkN "tenda" ; -- status=guess
lin telephone_V2 = mkV2 (mkV "telefonare") ; -- status=guess, src=wikt
lin telephone_V = mkV "telefonare" ; -- status=guess, src=wikt
lin reduced_A = variants{} ; -- 
lin tumour_N = variants{} ; -- 
lin super_A = mkA "super" | mkA "sopra" ; -- status=guess status=guess
lin funding_N = variants{} ; -- 
lin dump_V2 = mkV2 (mkV "riversare") | mkV2 (mkV (mkV "scaricare") "dati") ; -- status=guess, src=wikt status=guess, src=wikt
lin dump_V = mkV "riversare" | mkV (mkV "scaricare") "dati" ; -- status=guess, src=wikt status=guess, src=wikt
lin stitch_N = mkN "punto" ; -- status=guess
lin shared_A = variants{} ; -- 
lin ladder_N = mkN "scala" ; -- status=guess
lin keeper_N = mkN "portiere" masculine ; -- status=guess
lin endorse_V2 = mkV2 (mkV "approvare") | mkV2 (mkV "appoggiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin invariably_Adv = variants{} ; -- 
lin smash_V2 = variants{} ; -- 
lin smash_V = variants{} ; -- 
lin shield_N = mkN "scudo" | mkN "protezione" feminine | mkN "rifugio" | mkN "riparo" | mkN "copertura" ; -- status=guess status=guess status=guess status=guess status=guess
lin heat_V2 = mkV2 (mkV "scaldare") | mkV2 (mkV "eccitare") ; -- status=guess, src=wikt status=guess, src=wikt
lin heat_V = mkV "scaldare" | mkV "eccitare" ; -- status=guess, src=wikt status=guess, src=wikt
lin surgeon_N = mkN "chirurgo" ; -- status=guess
lin centre_V2 = variants{} ; -- 
lin centre_V = variants{} ; -- 
lin orange_N = variants{} ; -- 
lin orange_2_N = variants{} ; -- 
lin orange_1_N = variants{} ; -- 
lin explode_V = esplodere_V ; -- status=guess, src=wikt
lin comedy_N = mkN "commedia" ; -- status=guess
lin classify_V2 = variants{} ; -- 
lin artistic_A = mkA "artistico" ; -- status=guess
lin ruler_N = mkN "righello" ; -- status=guess
lin biscuit_N = mkN "biscotto" | mkN "biscottino" ; -- status=guess status=guess
lin workstation_N = mkN "postazione" feminine ; -- status=guess
lin prey_N = mkN "preda" ; -- status=guess
lin manual_N = mkN "manuale" masculine ; -- status=guess
lin cure_N = variants{} ; -- 
lin cure_2_N = variants{} ; -- 
lin cure_1_N = variants{} ; -- 
lin overall_N = variants{} ; -- 
lin tighten_V2 = mkV2 (stringere_V) ; -- status=guess, src=wikt
lin tighten_V = stringere_V ; -- status=guess, src=wikt
lin tax_V2 = variants{} ; -- 
lin pope_N = mkN "papa" | mkN "pontefice" masculine ; -- status=guess status=guess
lin manufacturing_A = variants{} ; -- 
lin adult_A = mkA "adulto" | mkA "adulta" ; -- status=guess status=guess
lin rush_N = mkN "giunco" ; -- status=guess
lin blanket_N = mkN "coperta" ; -- status=guess
lin republican_N = variants{} ; -- 
lin referendum_N = mkN "referendum invariable" ; -- status=guess
lin palm_N = mkN "palmare" ; -- status=guess
lin nearby_Adv = mkAdv "vicino" ; -- status=guess
lin mix_N = variants{} ; -- 
lin devil_N = mkN "diavolo" ; -- status=guess
lin adoption_N = mkN "adozione" feminine ; -- status=guess
lin workforce_N = variants{} ; -- 
lin segment_N = variants{} ; -- 
lin regardless_Adv = variants{} ; -- 
lin contractor_N = variants{} ; -- 
lin portion_N = mkN "porzione" feminine ; -- status=guess
lin differently_Adv = variants{} ; -- 
lin deposit_V2 = variants{} ; -- 
lin cook_N = mkN "cuoco" | mkN "cuoca" ; -- status=guess status=guess
lin prediction_N = variants{} ; -- 
lin oven_N = mkN "forno" feminine ; -- status=guess
lin matrix_N = mkN "matrice" feminine ; -- status=guess
lin liver_N = L.liver_N ;
lin fraud_N = mkN "frode" feminine | mkN "frodi" ; -- status=guess status=guess
lin beam_N = mkN "braccio" ; -- status=guess
lin signature_N = mkN "firma" ; -- status=guess
lin limb_N = mkN "lembo bordo margine" ; -- status=guess
lin verdict_N = mkN "verdetto" ; -- status=guess
lin dramatically_Adv = mkAdv "drammaticamente" | mkAdv "sensazionalmente" ; -- status=guess status=guess
lin container_N = mkN "contenitore" masculine | mkN "recipiente" masculine ; -- status=guess status=guess
lin aunt_N = mkN "zia" ; -- status=guess
lin dock_N = variants{} ; -- 
lin submission_N = variants{} ; -- 
lin arm_V2 = mkV2 (mkV "armare") ; -- status=guess, src=wikt
lin arm_V = mkV "armare" ; -- status=guess, src=wikt
lin odd_N = variants{} ; -- 
lin certainty_N = variants{} ; -- 
lin boring_A = mkA "noioso" | mkA "noiosa" ; -- status=guess status=guess
lin electron_N = mkN "elettrone" masculine ; -- status=guess
lin drum_N = mkN "bidone" masculine ; -- status=guess
lin wisdom_N = mkN "saggezza" ; -- status=guess
lin antibody_N = mkN "anticorpo" ; -- status=guess
lin unlike_A = variants{} ; -- 
lin terrorist_N = mkN "terrorista" masculine ; -- status=guess
lin post_V2 = variants{} ; -- 
lin post_V = variants{} ; -- 
lin circulation_N = variants{} ; -- 
lin alteration_N = variants{} ; -- 
lin fluid_N = mkN "fluido" ; -- status=guess
lin ambitious_A = mkA "ambizioso" ; -- status=guess
lin socially_Adv = variants{} ; -- 
lin riot_N = mkN "celere" ; -- status=guess
lin petition_N = variants{} ; -- 
lin fox_N = mkN "volpe" feminine ; -- status=guess
lin recruitment_N = mkN "reclutamento" ; -- status=guess
lin well_known_A = variants{} ; -- 
lin top_V2 = variants{} ; -- 
lin service_V2 = variants{} ; -- 
lin flood_V2 = mkV2 (mkV "allagare") | mkV2 (mkV "inondare") ; -- status=guess, src=wikt status=guess, src=wikt
lin flood_V = mkV "allagare" | mkV "inondare" ; -- status=guess, src=wikt status=guess, src=wikt
lin taste_V2 = mkV2 (mkV "provare") ; -- status=guess, src=wikt
lin taste_V = mkV "provare" ; -- status=guess, src=wikt
lin memorial_N = variants{} ; -- 
lin helicopter_N = mkN "elicottero" ; -- status=guess
lin correspondence_N = mkN "corrispondenza" ; -- status=guess
lin beef_N = mkN "manzo" ; -- status=guess
lin overall_Adv = variants{} ; -- 
lin lighting_N = variants{} ; -- 
lin harbour_N = L.harbour_N ;
lin empirical_A = variants{} ; -- 
lin shallow_A = mkA "superficiale" ; -- status=guess
lin seal_V2 = mkV2 (mkV (chiudere_V) "ermeticamente") ; -- status=guess, src=wikt
lin seal_V = mkV (chiudere_V) "ermeticamente" ; -- status=guess, src=wikt
lin decrease_V2 = mkV2 (mkV "diminuire") | mkV2 (mkV "calare") ; -- status=guess, src=wikt status=guess, src=wikt
lin decrease_V = mkV "diminuire" | mkV "calare" ; -- status=guess, src=wikt status=guess, src=wikt
lin constituent_N = mkN "elemento" ; -- status=guess
lin exam_N = variants{} ; -- 
lin toe_N = mkN "dito della zampa" | mkN "dito del piede" | mkN "dito" feminine ; -- status=guess status=guess status=guess
lin reward_V2 = variants{} ; -- 
lin thrust_V2 = variants{} ; -- 
lin thrust_V = variants{} ; -- 
lin bureaucracy_N = variants{} ; -- 
lin wrist_N = mkN "polso" ; -- status=guess
lin nut_N = mkN "noce" masculine ; -- status=guess
lin plain_N = mkN "pianura" ; -- status=guess
lin magnetic_A = mkA "magnetico" ; -- status=guess
lin evil_N = mkN "male" masculine ; -- status=guess
lin widen_V2 = mkV2 (mkV "allargarsi") ; -- status=guess, src=wikt
lin hazard_N = variants{} ; -- 
lin dispose_V2 = variants{} ; -- 
lin dispose_V = variants{} ; -- 
lin dealing_N = variants{} ; -- 
lin absent_A = mkA "assente" ; -- status=guess
lin reassure_V2S = mkV2S (mkV "rassicurare") | mkV2S (mkV "tranquillizzare") ; -- status=guess, src=wikt status=guess, src=wikt
lin reassure_V2 = mkV2 (mkV "rassicurare") | mkV2 (mkV "tranquillizzare") ; -- status=guess, src=wikt status=guess, src=wikt
lin model_V2 = mkV2 (mkV (I.fare_V) "il modello") | mkV2 (mkV (mkV "la") "modella") ; -- status=guess, src=wikt status=guess, src=wikt
lin model_V = mkV (I.fare_V) "il modello" | mkV (mkV "la") "modella" ; -- status=guess, src=wikt status=guess, src=wikt
lin inn_N = mkN "osteria" | mkN "locanda" ; -- status=guess status=guess
lin initial_N = variants{} ; -- 
lin suspension_N = mkN "sospensione" ; -- status=guess
lin respondent_N = variants{} ; -- 
lin over_N = variants{} ; -- 
lin naval_A = variants{} ; -- 
lin monthly_A = variants{} ; -- 
lin log_N = mkN "tronchetto" ; -- status=guess
lin advisory_A = variants{} ; -- 
lin fitness_N = variants{} ; -- 
lin blank_A = variants{} ; -- 
lin indirect_A = variants{} ; -- 
lin tile_N = mkN "[floor and wall tile] piastrella" | mkN "[roof tile] tegola" | mkN "coppo" ; -- status=guess status=guess status=guess
lin rally_N = variants{} ; -- 
lin economist_N = variants{} ; -- 
lin vein_N = mkN "vena" ; -- status=guess
lin strand_N = mkN "spiaggia" | mkN "battigia" | mkN "bagnasciuga" masculine ; -- status=guess status=guess status=guess
lin disturbance_N = variants{} ; -- 
lin stuff_V2 = mkV2 (mkV (essere_V) "pieno") | mkV2 (mkV (essere_V) "satollo") ; -- status=guess, src=wikt status=guess, src=wikt
lin seldom_Adv = mkAdv "raramente" | mkAdv "di rado" ; -- status=guess status=guess
lin coming_A = variants{} ; -- 
lin cab_N = mkN "cabina" ; -- status=guess
lin grandfather_N = mkN "nonno" ; -- status=guess
lin flash_V = variants{} ; -- 
lin destination_N = mkN "destinazione" feminine ; -- status=guess
lin actively_Adv = variants{} ; -- 
lin regiment_N = variants{} ; -- 
lin closed_A = variants{} ; -- 
lin boom_N = mkN "boma" masculine ; -- status=guess
lin handful_N = mkN "manciata" | mkN "pugno" ; -- status=guess status=guess
lin remarkably_Adv = variants{} ; -- 
lin encouragement_N = mkN "incoraggiamento" ; -- status=guess
lin awkward_A = mkA "maldestro" | mkA "impacciato" | mkA "goffo" ; -- status=guess status=guess status=guess
lin required_A = variants{} ; -- 
lin flood_N = mkN "marea" | mkN "alluvione" masculine ; -- status=guess status=guess
lin defect_N = mkN "difetto" ; -- status=guess
lin surplus_N = mkN "avanzo" ; -- status=guess
lin champagne_N = variants{} ; -- 
lin liquid_N = mkN "liquida" ; -- status=guess
lin shed_V2 = mkV2 (mkV "separare") ; -- status=guess, src=wikt
lin welcome_N = mkN "accoglienza" ; -- status=guess
lin rejection_N = variants{} ; -- 
lin discipline_V2 = variants{} ; -- 
lin halt_V2 = mkV2 (mkV "fermare") ; -- status=guess, src=wikt
lin halt_V = mkV "fermare" ; -- status=guess, src=wikt
lin electronics_N = mkN "elettronica" ; -- status=guess
lin administrator_N = variants{} ; -- 
lin sentence_V2 = mkV2 (mkV "condannare") ; -- status=guess, src=wikt
lin sentence_V = mkV "condannare" ; -- status=guess, src=wikt
lin ill_Adv = variants{} ; -- 
lin contradiction_N = mkN "contraddizione" feminine ; -- status=guess
lin nail_N = mkN "tagliaunghie" ; -- status=guess
lin senior_N = variants{} ; -- 
lin lacking_A = variants{} ; -- 
lin colonial_A = variants{} ; -- 
lin primitive_A = mkA "primitivo" ; -- status=guess
lin whoever_NP = variants{} ; -- 
lin lap_N = mkN "grembo" ; -- status=guess
lin commodity_N = variants{} ; -- 
lin planned_A = variants{} ; -- 
lin intellectual_N = variants{} ; -- 
lin imprisonment_N = variants{} ; -- 
lin coincide_V = mkV "coincidere" ; -- status=guess, src=wikt
lin sympathetic_A = mkA "sensibile" ; -- status=guess
lin atom_N = mkN "atomo" ; -- status=guess
lin tempt_V2V = mkV2V (mkV "tentare") ; -- status=guess, src=wikt
lin tempt_V2 = mkV2 (mkV "tentare") ; -- status=guess, src=wikt
lin sanction_N = variants{} ; -- 
lin praise_V2 = mkV2 (mkV "lodare") ; -- status=guess, src=wikt
lin favourable_A = mkA "favorevole" ; -- status=guess
lin dissolve_V2 = variants{} ; -- 
lin dissolve_V = variants{} ; -- 
lin tightly_Adv = variants{} ; -- 
lin surrounding_N = variants{} ; -- 
lin soup_N = mkN "minestra" masculine ; -- status=guess
lin encounter_N = variants{} ; -- 
lin abortion_N = mkN "aborto" ; -- status=guess
lin grasp_V2 = mkV2 (mkV "afferrare") ; -- status=guess, src=wikt
lin grasp_V = mkV "afferrare" ; -- status=guess, src=wikt
lin custody_N = variants{} ; -- 
lin composer_N = mkN "compositore" masculine ; -- status=guess
lin charm_N = mkN "incanto" | mkN "fascino" | mkN "attrattiva" ; -- status=guess status=guess status=guess
lin short_term_A = variants{} ; -- 
lin metropolitan_A = mkA "metropolitano" ; -- status=guess
lin waist_N = mkN "vita" masculine | mkN "cintura" | mkN "cintola" ; -- status=guess status=guess status=guess
lin equality_N = mkN "egualità" | mkN "ugualità" | mkN "uguaglianza" ; -- status=guess status=guess status=guess
lin tribute_N = mkN "omaggio" ; -- status=guess
lin bearing_N = mkN "cuscinetto" ; -- status=guess
lin auction_N = mkN "asta" | mkN "incanto" ; -- status=guess status=guess
lin standing_N = variants{} ; -- 
lin manufacture_N = variants{} ; -- 
lin horn_N = L.horn_N ;
lin barn_N = mkN "granaio" ; -- status=guess
lin mayor_N = mkN "sindaco" | mkN "primo cittadino" ; -- status=guess status=guess
lin emperor_N = mkN "imperatore" masculine ; -- status=guess
lin rescue_N = variants{} ; -- 
lin integrated_A = variants{} ; -- 
lin conscience_N = mkN "coscienza" ; -- status=guess
lin commence_V2 = mkV2 (mkV "cominciare") ; -- status=guess, src=wikt
lin commence_V = mkV "cominciare" ; -- status=guess, src=wikt
lin grandmother_N = mkN "nonna" ; -- status=guess
lin discharge_V2 = variants{} ; -- 
lin discharge_V = variants{} ; -- 
lin profound_A = mkA "profondo" ; -- status=guess
lin takeover_N = variants{} ; -- 
lin nationalist_N = variants{} ; -- 
lin effect_V2 = variants{} ; -- 
lin dolphin_N = mkN "delfino" ; -- status=guess
lin fortnight_N = variants{} ; -- 
lin elephant_N = mkN "elefante" masculine ; -- status=guess
lin seal_N = mkN "sigillo" | mkN "bollo" | mkN "timbro" ; -- status=guess status=guess status=guess
lin spoil_V2 = mkV2 (mkV (andare_V) "a male") ; -- status=guess, src=wikt
lin spoil_V = mkV (andare_V) "a male" ; -- status=guess, src=wikt
lin plea_N = mkN "supplica" ; -- status=guess
lin forwards_Adv = variants{} ; -- 
lin breeze_N = mkN "brezza" ; -- status=guess
lin prevention_N = variants{} ; -- 
lin mineral_N = mkN "minerale" masculine ; -- status=guess
lin runner_N = mkN "passatoia" ; -- status=guess status=guess
lin pin_V2 = mkV2 (mkV "inchiodare") ; -- status=guess, src=wikt
lin integrity_N = mkN "integrità" feminine ; -- status=guess
lin thereafter_Adv = variants{} ; -- 
lin quid_N = variants{} ; -- 
lin owl_N = mkN "gufo [big]" | mkN "civetta [small]" ; -- status=guess status=guess
lin rigid_A = mkA "rigido" ; -- status=guess
lin orange_A = mkA "arancione" | mkA "arancio" ; -- status=guess status=guess
lin draft_V2 = mkV2 (mkV "arruolare") ; -- status=guess, src=wikt
lin reportedly_Adv = variants{} ; -- 
lin hedge_N = mkN "siepe" feminine ; -- status=guess
lin formulate_V2 = mkV2 (mkV "formulare") ; -- status=guess, src=wikt
lin associated_A = variants{} ; -- 
lin position_V2 = mkV2 (mkV "piazzare") | mkV2 (mkV "posizionD%e") ; -- status=guess, src=wikt status=guess, src=wikt
lin thief_N = mkN "ladro" | mkN "ladra" ; -- status=guess status=guess
lin tomato_N = mkN "pomodoro" ; -- status=guess
lin exhaust_V2 = variants{} ; -- 
lin evidently_Adv = variants{} ; -- 
lin eagle_N = mkN "moneta di dieci dollari" ; -- status=guess
lin specified_A = variants{} ; -- 
lin resulting_A = variants{} ; -- 
lin blade_N = mkN "filo" ; -- status=guess
lin peculiar_A = mkA "peculiare" ; -- status=guess
lin killing_N = variants{} ; -- 
lin desktop_N = variants{} ; -- 
lin bowel_N = mkN "budella" | mkN "viscere" feminine | mkN "intestino" ; -- status=guess status=guess status=guess
lin long_V = mkV "bramare" ; -- status=guess, src=wikt
lin ugly_A = L.ugly_A ;
lin expedition_N = mkN "spedizione" feminine ; -- status=guess
lin saint_N = mkN "santo" | mkN "santa" ; -- status=guess status=guess
lin variable_A = mkA "variabile" | mkA "regolabile" | mkA "flessiblie" | mkA "modificabile" ; -- status=guess status=guess status=guess status=guess
lin supplement_V2 = variants{} ; -- 
lin stamp_N = mkN "conio" ; -- status=guess
lin slide_N = mkN "scivolo" ; -- status=guess
lin faction_N = variants{} ; -- 
lin enthusiastic_A = variants{} ; -- 
lin enquire_V2 = variants{} ; -- 
lin enquire_V = variants{} ; -- 
lin brass_N = mkN "ottone" masculine ; -- status=guess
lin inequality_N = mkN "disequazione disuguaglianza" ; -- status=guess
lin eager_A = mkA "avido" ; -- status=guess
lin bold_A = mkA "sfrontato" | mkA "ardito" | mkA "audace" | mkA "coraggioso" ; -- status=guess status=guess status=guess status=guess
lin neglect_V2 = mkV2 (mkV "tralasciare") ; -- status=guess, src=wikt
lin saying_N = mkN "proverbio" | mkN "detto" | mkN "massima" ; -- status=guess status=guess status=guess
lin ridge_N = mkN "catena" ; -- status=guess
lin earl_N = mkN "conte" masculine ; -- status=guess
lin yacht_N = mkN "panfilo" | mkN "yacht" masculine ; -- status=guess status=guess
lin suck_V2 = L.suck_V2 ;
lin suck_V = mkV (essere_V) "una schiappa" | mkV (I.fare_V) "schifo" ; -- status=guess, src=wikt status=guess, src=wikt
lin missing_A = variants{} ; -- 
lin extended_A = variants{} ; -- 
lin valuation_N = variants{} ; -- 
lin delight_V2 = mkV2 (mkV "deliziare") ; -- status=guess, src=wikt
lin delight_V = mkV "deliziare" ; -- status=guess, src=wikt
lin beat_N = mkN "ritmo" ; -- status=guess
lin worship_N = mkN "culto" ; -- status=guess
lin fossil_N = mkN "fossile" masculine ; -- status=guess
lin diminish_V2 = mkV2 (mkV "diminuire") | mkV2 (ridurre_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin diminish_V = mkV "diminuire" | ridurre_V ; -- status=guess, src=wikt status=guess, src=wikt
lin taxpayer_N = variants{} ; -- 
lin corruption_N = mkN "corruzione" feminine ; -- status=guess
lin accurately_Adv = variants{} ; -- 
lin honour_V2 = mkV2 (mkV "onorare") ; -- status=guess, src=wikt
lin depict_V2 = mkV2 (mkV (mkV "o:") "rappresenta") | mkV2 (mkV "raffigura") ; -- status=guess, src=wikt status=guess, src=wikt
lin pencil_N = mkN "matita" ; -- status=guess
lin drown_V2 = mkV2 (mkV "affogare") | mkV2 (mkV "annegare") ; -- status=guess, src=wikt status=guess, src=wikt
lin drown_V = mkV "affogare" | mkV "annegare" ; -- status=guess, src=wikt status=guess, src=wikt
lin stem_N = mkN "ceppo" | mkN "fusto" | mkN "tronco" ; -- status=guess status=guess status=guess
lin lump_N = mkN "cucchiaino" | mkN "zolla" | mkN "zolletta" | mkN "forfait" masculine ; -- status=guess status=guess status=guess status=guess
lin applicable_A = variants{} ; -- 
lin rate_V2 = variants{} ; -- 
lin rate_V = variants{} ; -- 
lin mobility_N = mkN "mobilità" feminine ; -- status=guess
lin immense_A = mkA "immenso" ; -- status=guess
lin goodness_N = mkN "bontà" feminine ; -- status=guess
lin price_V2V = mkV2V (mkV "stimare") | mkV2V (mkV "valutare") ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V2 = mkV2 (mkV "stimare") | mkV2 (mkV "valutare") ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V = mkV "stimare" | mkV "valutare" ; -- status=guess, src=wikt status=guess, src=wikt
lin preliminary_A = variants{} ; -- 
lin graph_N = mkN "grafo" ; -- status=guess
lin referee_N = mkN "arbitro" ; -- status=guess
lin calm_A = variants{} ; -- 
lin onwards_Adv = variants{} ; -- 
lin omit_V2 = mkV2 (omettere_V) ; -- status=guess, src=wikt
lin genuinely_Adv = variants{} ; -- 
lin excite_V2 = mkV2 (mkV "provocare") | mkV2 (accendere_V) | mkV2 (mkV "stimolare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dreadful_A = variants{} ; -- 
lin cave_N = mkN "caverna" | mkN "grotta" ; -- status=guess status=guess
lin revelation_N = mkN "rivelazione" feminine ; -- status=guess
lin grief_N = variants{} ; -- 
lin erect_V2 = variants{} ; -- 
lin tuck_V2 = mkV2 (mkV "incastrare") ; -- status=guess, src=wikt
lin tuck_V = mkV "incastrare" ; -- status=guess, src=wikt
lin meantime_N = mkN "frattempo" | mkN "attesa" ; -- status=guess status=guess
lin barrel_N = mkN "barile" masculine | mkN "botte" feminine ; -- status=guess status=guess
lin lawn_N = mkN "prato" ; -- status=guess
lin hut_N = mkN "capanna" ; -- status=guess
lin swing_N = mkN "altalena" ; -- status=guess
lin subject_V2 = mkV2 (mkV "assoggettare") | mkV2 (sottomettere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin ruin_V2 = variants{} ; -- 
lin slice_N = mkN "striscia" | mkN "fetta" ; -- status=guess status=guess
lin transmit_V2 = variants{} ; -- 
lin thigh_N = mkN "coscia" ; -- status=guess
lin practically_Adv = variants{} ; -- 
lin dedicate_V2 = variants{} ; -- 
lin mistake_V2 = mkV2 (mkV "sbagliare") ; -- status=guess, src=wikt
lin mistake_V = mkV "sbagliare" ; -- status=guess, src=wikt
lin corresponding_A = variants{} ; -- 
lin albeit_Subj = variants{} ; -- 
lin sound_A = mkA "sano" ; -- status=guess
lin nurse_V2 = variants{} ; -- 
lin discharge_N = variants{} ; -- 
lin comparative_A = mkA "comparativo" ; -- status=guess
lin cluster_N = variants{} ; -- 
lin propose_VV = mkVV (proporre_V) ; -- status=guess, src=wikt
lin propose_VS = mkVS (proporre_V) ; -- status=guess, src=wikt
lin propose_V2 = mkV2 (proporre_V) ; -- status=guess, src=wikt
lin propose_V = proporre_V ; -- status=guess, src=wikt
lin obstacle_N = mkN "ostacolo" ; -- status=guess
lin motorway_N = mkN "autostrada" ; -- status=guess
lin heritage_N = variants{} ; -- 
lin counselling_N = variants{} ; -- 
lin breeding_N = variants{} ; -- 
lin characteristic_A = mkA "caratteristica" ; -- status=guess
lin bucket_N = mkN "secchio" ; -- status=guess
lin migration_N = variants{} ; -- 
lin campaign_V = variants{} ; -- 
lin ritual_N = mkN "rituale" masculine ; -- status=guess
lin originate_V2 = mkV2 (mkV "originare") | mkV2 (mkV (dare_V) "origine") ; -- status=guess, src=wikt status=guess, src=wikt
lin originate_V = mkV "originare" | mkV (dare_V) "origine" ; -- status=guess, src=wikt status=guess, src=wikt
lin hunting_N = mkN "caccia" masculine ; -- status=guess
lin crude_A = mkA "greggio" | mkA "grezzo" ; -- status=guess status=guess
lin protocol_N = variants{} ; -- 
lin prejudice_N = variants{} ; -- 
lin inspiration_N = mkN "inspirazione" feminine ; -- status=guess
lin dioxide_N = mkN "diossido" | mkN "biossido" ; -- status=guess status=guess
lin chemical_A = variants{} ; -- 
lin uncomfortable_A = variants{} ; -- 
lin worthy_A = mkA "degno" ; -- status=guess
lin inspect_V2 = mkV2 (mkV "ispezionare") ; -- status=guess, src=wikt
lin summon_V2 = mkV2 (mkV "convocare") | mkV2 (mkV (mkV "citare") "in giudizio") | mkV2 (mkV "intimare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin parallel_N = variants{} ; -- 
lin outlet_N = variants{} ; -- 
lin okay_A = variants{} ; -- 
lin collaboration_N = mkN "collaborazione" feminine ; -- status=guess
lin booking_N = mkN "prenotazione" feminine ; -- status=guess
lin salad_N = mkN "insalata" ; -- status=guess
lin productive_A = variants{} ; -- 
lin charming_A = variants{} ; -- 
lin polish_A = variants{} ; -- 
lin oak_N = mkN "quercia" masculine | mkN "[Quercus robur] farnia" ; -- status=guess status=guess
lin access_V2 = variants{} ; -- 
lin tourism_N = mkN "turismo" ; -- status=guess
lin independently_Adv = variants{} ; -- 
lin cruel_A = mkA "crudele" ; -- status=guess
lin diversity_N = mkN "diversità" feminine ; -- status=guess
lin accused_A = variants{} ; -- 
lin supplement_N = variants{} ; -- 
lin fucking_Adv = mkAdv "del cazzo" | mkAdv "cazzo di" ; -- status=guess status=guess
lin forecast_N = mkN "previsione" ; -- status=guess
lin amend_V2V = mkV2V (mkV "emendare") ; -- status=guess, src=wikt
lin amend_V2 = mkV2 (mkV "emendare") ; -- status=guess, src=wikt
lin amend_V = mkV "emendare" ; -- status=guess, src=wikt
lin soap_N = mkN "sapone" masculine ; -- status=guess
lin ruling_N = variants{} ; -- 
lin interference_N = variants{} ; -- 
lin executive_A = variants{} ; -- 
lin mining_N = variants{} ; -- 
lin minimal_A = variants{} ; -- 
lin clarify_V2 = variants{} ; -- 
lin clarify_V = variants{} ; -- 
lin strain_V2 = mkV2 (mkV "tendere") | mkV2 (mkV "tirare") | mkV2 (mkV "forzare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin novel_A = mkA "nuovo" | mkA "originale" ; -- status=guess status=guess
lin try_N = mkN "meta" ; -- status=guess
lin coastal_A = variants{} ; -- 
lin rising_A = variants{} ; -- 
lin quota_N = variants{} ; -- 
lin minus_Prep = variants{} ; -- 
lin kilometre_N = mkN "chilometro" ; -- status=guess
lin characterize_V2 = variants{} ; -- 
lin suspicious_A = mkA "diffidente" ; -- status=guess
lin pet_N = variants{} ; -- 
lin beneficial_A = mkA "benefico" ; -- status=guess
lin fling_V2 = variants{} ; -- 
lin fling_V = variants{} ; -- 
lin deprive_V2 = variants{} ; -- 
lin covenant_N = mkN "patto" | mkN "accordo solenne" | mkN "contratto" ; -- status=guess status=guess status=guess
lin bias_N = mkN "polarizzazione" feminine ; -- status=guess
lin trophy_N = mkN "trofeo" ; -- status=guess
lin verb_N = mkN "verbo" ; -- status=guess
lin honestly_Adv = variants{} ; -- 
lin extract_N = variants{} ; -- 
lin straw_N = mkN "festuca" | mkN "pagliuzza" ; -- status=guess status=guess
lin stem_V2 = mkV2 (mkV (aprire_V) "lo spazzaneve") ; -- status=guess, src=wikt
lin stem_V = mkV (aprire_V) "lo spazzaneve" ; -- status=guess, src=wikt
lin eyebrow_N = mkN "sopracciglio" ; -- status=guess
lin noble_A = mkA "nobile" ; -- status=guess
lin mask_N = mkN "maschera" masculine | mkN "mascherina" ; -- status=guess status=guess
lin lecturer_N = mkN "conferenziere" masculine ; -- status=guess
lin girlfriend_N = mkN "amica" | mkN "amica del cuore" ; -- status=guess status=guess
lin forehead_N = mkN "fronte" feminine ; -- status=guess
lin timetable_N = mkN "orario" ; -- status=guess
lin symbolic_A = variants{} ; -- 
lin farming_N = variants{} ; -- 
lin lid_N = mkN "coperchio" ; -- status=guess
lin librarian_N = mkN "bibliotecario" ; -- status=guess
lin injection_N = mkN "iniezione" feminine ; -- status=guess
lin sexuality_N = mkN "sessualità" feminine ; -- status=guess
lin irrelevant_A = mkA "irrilevante" ; -- status=guess
lin bonus_N = variants{} ; -- 
lin abuse_V2 = mkV2 (mkV "abusare") ; -- status=guess, src=wikt
lin thumb_N = mkN "pollice" masculine | mkN "dito grosso" ; -- status=guess status=guess
lin survey_V2 = variants{} ; -- 
lin ankle_N = mkN "caviglia" ; -- status=guess
lin psychologist_N = mkN "psicologo" | mkN "psicologa" ; -- status=guess status=guess
lin occurrence_N = mkN "occorrenza" ; -- status=guess
lin profitable_A = mkA "redditizio" | mkA "fruttifero" | mkA "remunerativo" ; -- status=guess status=guess status=guess
lin deliberate_A = variants{} ; -- 
lin bow_V2 = mkV2 (mkV "curvarsi") | mkV2 (mkV "piegarsi") | mkV2 (mkV "incurvarsi") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin bow_V = mkV "curvarsi" | mkV "piegarsi" | mkV "incurvarsi" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin tribe_N = mkN "tribù" feminine ; -- status=guess
lin rightly_Adv = variants{} ; -- 
lin representative_A = variants{} ; -- 
lin code_V2 = variants{} ; -- 
lin validity_N = variants{} ; -- 
lin marble_N = mkN "marmo" ; -- status=guess
lin bow_N = mkN "arco" ; -- status=guess
lin plunge_V2 = mkV2 (immergere_V) ; -- status=guess, src=wikt
lin plunge_V = immergere_V ; -- status=guess, src=wikt
lin maturity_N = variants{} ; -- 
lin maturity_3_N = variants{} ; -- 
lin maturity_2_N = variants{} ; -- 
lin maturity_1_N = variants{} ; -- 
lin hidden_A = variants{} ; -- 
lin contrast_V2 = variants{} ; -- 
lin contrast_V = variants{} ; -- 
lin tobacco_N = mkN "tabacco" ; -- status=guess
lin middle_class_A = variants{} ; -- 
lin grip_V2 = variants{} ; -- 
lin clergy_N = mkN "clero" ; -- status=guess
lin trading_A = variants{} ; -- 
lin passive_A = mkA "passivo" ; -- status=guess
lin decoration_N = mkN "decorazione" feminine ; -- status=guess
lin racial_A = mkA "razziale" ; -- status=guess
lin well_N = mkN "pozzo" | mkN "puzzo" ; -- status=guess status=guess
lin embarrassment_N = mkN "imbarazzo" ; -- status=guess
lin sauce_N = mkN "salsa" ; -- status=guess
lin fatal_A = mkA "fatale" ; -- status=guess
lin banker_N = variants{} ; -- 
lin compensate_V2 = variants{} ; -- 
lin compensate_V = variants{} ; -- 
lin make_up_N = variants{} ; -- 
lin popularity_N = mkN "popolarità" feminine ; -- status=guess
lin interior_A = variants{} ; -- 
lin eligible_A = variants{} ; -- 
lin continuity_N = mkN "continuità" feminine ; -- status=guess
lin bunch_N = mkN "mucchio" | mkN "mucchio" ; -- status=guess status=guess
lin hook_N = mkN "amo" ; -- status=guess
lin wicket_N = variants{} ; -- 
lin pronounce_V2 = mkV2 (mkV "dichiarare") ; -- status=guess, src=wikt
lin pronounce_V = mkV "dichiarare" ; -- status=guess, src=wikt
lin ballet_N = mkN "balletto" ; -- status=guess
lin heir_N = mkN "erede" masculine ; -- status=guess
lin positively_Adv = variants{} ; -- 
lin insufficient_A = mkA "insufficiente" ; -- status=guess
lin substitute_V2 = mkV2 (mkV "sostituire") ; -- status=guess, src=wikt
lin substitute_V = mkV "sostituire" ; -- status=guess, src=wikt
lin mysterious_A = mkA "misterioso" ; -- status=guess
lin dancer_N = mkN "ballerino" | mkN "ballerina" | mkN "danzatore" | mkN "danzatrice" feminine ; -- status=guess status=guess status=guess status=guess
lin trail_N = mkN "sentiero" | mkN "pista" masculine ; -- status=guess status=guess
lin caution_N = mkN "cautela" ; -- status=guess
lin donation_N = mkN "donazione" feminine ; -- status=guess
lin added_A = variants{} ; -- 
lin weaken_V2 = variants{} ; -- 
lin weaken_V = variants{} ; -- 
lin tyre_N = mkN "gomma" masculine | mkN "pneumatico" ; -- status=guess status=guess
lin sufferer_N = variants{} ; -- 
lin managerial_A = mkA "manageriale" ; -- status=guess
lin elaborate_A = mkA "elaborato" | mkA "elaborata" ; -- status=guess status=guess
lin restraint_N = mkN "ritegno" | mkN "ritegni" masculine ; -- status=guess status=guess
lin renew_V2 = variants{} ; -- 
lin gardener_N = variants{} ; -- 
lin dilemma_N = mkN "dilemma" masculine ; -- status=guess
lin configuration_N = mkN "configurazione" feminine ; -- status=guess
lin rear_A = variants{} ; -- 
lin embark_V2 = mkV2 (mkV "imbarcare") ; -- status=guess, src=wikt
lin embark_V = mkV "imbarcare" ; -- status=guess, src=wikt
lin misery_N = mkN "miseria" ; -- status=guess
lin importantly_Adv = variants{} ; -- 
lin continually_Adv = variants{} ; -- 
lin appreciation_N = variants{} ; -- 
lin radical_N = variants{} ; -- 
lin diverse_A = mkA "diverso" ; -- status=guess
lin revive_V2 = variants{} ; -- 
lin revive_V = variants{} ; -- 
lin trip_V = mkV "inciampare" ; -- status=guess, src=wikt
lin lounge_N = variants{} ; -- 
lin dwelling_N = mkN "abitazione" feminine | mkN "residenza" | mkN "dimora" ; -- status=guess status=guess status=guess
lin parental_A = variants{} ; -- 
lin loyal_A = mkA "leale" ; -- status=guess
lin privatisation_N = variants{} ; -- 
lin outsider_N = variants{} ; -- 
lin forbid_V2 = mkV2 (mkV "proibire") | mkV2 (mkV "vietare") ; -- status=guess, src=wikt status=guess, src=wikt
lin yep_Interj = variants{} ; -- 
lin prospective_A = variants{} ; -- 
lin manuscript_N = mkN "manoscritto" ; -- status=guess
lin inherent_A = variants{} ; -- 
lin deem_V2V = mkV2V (mkV "considerare") | mkV2V (mkV "valutare") | mkV2V (mkV "credere") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin deem_V2A = mkV2A (mkV "considerare") | mkV2A (mkV "valutare") | mkV2A (mkV "credere") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin deem_V2 = mkV2 (mkV "considerare") | mkV2 (mkV "valutare") | mkV2 (mkV "credere") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin telecommunication_N = variants{} ; -- 
lin intermediate_A = variants{} ; -- 
lin worthwhile_A = mkA "che vale la pena" ; -- status=guess
lin calendar_N = mkN "calendario" ; -- status=guess
lin basin_N = mkN "bacino" ; -- status=guess
lin utterly_Adv = variants{} ; -- 
lin rebuild_V2 = mkV2 (mkV "ricostruire") ; -- status=guess, src=wikt
lin pulse_N = mkN "polso" | mkN "battito" ; -- status=guess status=guess
lin suppress_V2 = mkV2 (mkV "sopprimere") ; -- status=guess, src=wikt
lin predator_N = mkN "predatore" masculine ; -- status=guess
lin width_N = mkN "larghezza" ; -- status=guess
lin stiff_A = mkA "duro" | mkA "severo" ; -- status=guess status=guess
lin spine_N = mkN "costa" | mkN "dorso" ; -- status=guess status=guess
lin betray_V2 = mkV2 (mkV "consegnare") ; -- status=guess, src=wikt
lin punish_V2 = mkV2 (mkV "punire") ; -- status=guess, src=wikt
lin stall_N = mkN "stalla" ; -- status=guess
lin lifestyle_N = variants{} ; -- 
lin compile_V2 = mkV2 (mkV "compilare") ; -- status=guess, src=wikt
lin arouse_V2V = mkV2V (mkV "risvegliare") | mkV2V (mkV "svegliare") ; -- status=guess, src=wikt status=guess, src=wikt
lin arouse_V2 = mkV2 (mkV "risvegliare") | mkV2 (mkV "svegliare") ; -- status=guess, src=wikt status=guess, src=wikt
lin partially_Adv = variants{} ; -- 
lin headline_N = variants{} ; -- 
lin divine_A = mkA "divino" | mkA "divina" ; -- status=guess status=guess
lin unpleasant_A = mkA "spiacevole" | mkA "sgradevole" ; -- status=guess status=guess
lin sacred_A = variants{} ; -- 
lin useless_A = mkA "inutile" ; -- status=guess
lin cool_V2 = variants{} ; -- 
lin cool_V = variants{} ; -- 
lin tremble_V = mkV "tremare" | mkV "tremolare" ; -- status=guess, src=wikt status=guess, src=wikt
lin statue_N = mkN "statua" ; -- status=guess
lin obey_V2 = mkV2 (mkV "obbedire") | mkV2 (mkV "ubbidire") ; -- status=guess, src=wikt status=guess, src=wikt
lin obey_V = mkV "obbedire" | mkV "ubbidire" ; -- status=guess, src=wikt status=guess, src=wikt
lin drunk_A = mkA "ubriaco" | mkA "avvinazzato" | mkA "ebbro" | mkA "sborniato" ; -- status=guess status=guess status=guess status=guess
lin tender_A = mkA "tenero" | mkA "tenera" ; -- status=guess status=guess
lin molecular_A = mkA "molecolare" ; -- status=guess
lin circulate_V2 = variants{} ; -- 
lin circulate_V = variants{} ; -- 
lin exploitation_N = variants{} ; -- 
lin explicitly_Adv = variants{} ; -- 
lin utterance_N = variants{} ; -- 
lin linear_A = mkA "lineare" ; -- status=guess
lin chat_V = variants{} ; -- 
lin revision_N = mkN "revisione" feminine ; -- status=guess
lin distress_N = variants{} ; -- 
lin spill_V2 = mkV2 (mkV "rovesciare") | mkV2 (mkV "versare") ; -- status=guess, src=wikt status=guess, src=wikt
lin spill_V = mkV "rovesciare" | mkV "versare" ; -- status=guess, src=wikt status=guess, src=wikt
lin steward_N = variants{} ; -- 
lin knight_N = mkN "cavallo" feminine ; -- status=guess
lin sum_V2 = mkV2 (mkV "sommare") ; -- status=guess, src=wikt
lin sum_V = mkV "sommare" ; -- status=guess, src=wikt
lin semantic_A = variants{} ; -- 
lin selective_A = variants{} ; -- 
lin learner_N = variants{} ; -- 
lin dignity_N = mkN "dignità" feminine ; -- status=guess
lin senate_N = mkN "senato" ; -- status=guess
lin grid_N = mkN "rete elettrica" ; -- status=guess
lin fiscal_A = mkA "fiscale" ; -- status=guess
lin activate_V2 = mkV2 (mkV "attivare") ; -- status=guess, src=wikt
lin rival_A = variants{} ; -- 
lin fortunate_A = variants{} ; -- 
lin jeans_N = variants{} ; -- 
lin select_A = variants{} ; -- 
lin fitting_N = variants{} ; -- 
lin commentator_N = variants{} ; -- 
lin weep_V2 = mkV2 (piangere_V) | mkV2 (mkV (mkV "versare") "lacrime") ; -- status=guess, src=wikt status=guess, src=wikt
lin weep_V = piangere_V | mkV (mkV "versare") "lacrime" ; -- status=guess, src=wikt status=guess, src=wikt
lin handicap_N = variants{} ; -- 
lin crush_V2 = mkV2 (mkV (mkV "prendersi") "una cotta") ; -- status=guess, src=wikt
lin crush_V = mkV (mkV "prendersi") "una cotta" ; -- status=guess, src=wikt
lin towel_N = mkN "asciugamano" ; -- status=guess
lin stay_N = mkN "permanenza" ; -- status=guess
lin skilled_A = variants{} ; -- 
lin repeatedly_Adv = mkAdv "ripetutamente" ; -- status=guess
lin defensive_A = variants{} ; -- 
lin calm_V2 = variants{} ; -- 
lin calm_V = variants{} ; -- 
lin temporarily_Adv = variants{} ; -- 
lin rain_V2 = mkV2 (piovere_V) ; -- status=guess, src=wikt
lin rain_V = piovere_V ; -- status=guess, src=wikt
lin pin_N = mkN "spilla" ; -- status=guess
lin villa_N = variants{} ; -- 
lin rod_N = mkN "pertica" ; -- status=guess
lin frontier_N = mkN "confine" masculine | mkN "frontiera" ; -- status=guess status=guess
lin enforcement_N = variants{} ; -- 
lin protective_A = variants{} ; -- 
lin philosophical_A = mkA "filosofico" ; -- status=guess
lin lordship_N = mkN "dominio" ; -- status=guess
lin disagree_VS = mkVS (mkV "discordare") ; -- status=guess, src=wikt
lin disagree_V2 = mkV2 (mkV "discordare") ; -- status=guess, src=wikt
lin disagree_V = mkV "discordare" ; -- status=guess, src=wikt
lin boyfriend_N = mkN "ragazzo" | mkN "fidanzato" ; -- status=guess status=guess
lin activist_N = variants{} ; -- 
lin viewer_N = mkN "spettatore" masculine ; -- status=guess
lin slim_A = mkA "snello" | mkA "magro" | mkA "affusolato" ; -- status=guess status=guess status=guess
lin textile_N = variants{} ; -- 
lin mist_N = mkN "nebbia" | mkN "foschia" | mkN "bruma" ; -- status=guess status=guess status=guess
lin harmony_N = mkN "armonia" ; -- status=guess
lin deed_N = mkN "fatto" feminine | mkN "gesto" | mkN "gesta" ; -- status=guess status=guess status=guess
lin merge_V2 = mkV2 (mkV "unirsi") ; -- status=guess, src=wikt
lin merge_V = mkV "unirsi" ; -- status=guess, src=wikt
lin invention_N = mkN "inventione" | mkN "invenzione" feminine ; -- status=guess status=guess
lin commissioner_N = variants{} ; -- 
lin caravan_N = variants{} ; -- 
lin bolt_N = mkN "gratile" ; -- status=guess
lin ending_N = variants{} ; -- 
lin publishing_N = variants{} ; -- 
lin gut_N = mkN "epa" | mkN "pancia" masculine ; -- status=guess status=guess
lin stamp_V2 = mkV2 (mkV "affrancare") ; -- status=guess, src=wikt
lin stamp_V = mkV "affrancare" ; -- status=guess, src=wikt
lin map_V2 = mkV2 (mkV "mappare") ; -- status=guess, src=wikt
lin loud_Adv = variants{} ; -- 
lin stroke_V2 = mkV2 (mkV "accarezzare") ; -- status=guess, src=wikt
lin shock_V2 = variants{} ; -- 
lin rug_N = mkN "tappeto" | mkN "tappetino" ; -- status=guess status=guess
lin picture_V2 = variants{} ; -- 
lin slip_N = mkN "sbaglio" | mkN "errore" masculine | mkN "svista" ; -- status=guess status=guess status=guess
lin praise_N = mkN "elogio" ; -- status=guess
lin fine_N = mkN "multa" ; -- status=guess
lin monument_N = variants{} ; -- 
lin material_A = mkA "materiale" ; -- status=guess
lin garment_N = mkN "vestito" ; -- status=guess
lin toward_Prep = variants{} ; -- 
lin realm_N = mkN "reame" masculine | mkN "regno" | mkN "dominio" | mkN "sfera" ; -- status=guess status=guess status=guess status=guess
lin melt_V2 = mkV2 (mkV "sciogliere") | mkV2 (fondere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin melt_V = mkV "sciogliere" | fondere_V ; -- status=guess, src=wikt status=guess, src=wikt
lin reproduction_N = mkN "riproduzione" feminine ; -- status=guess
lin reactor_N = variants{} ; -- 
lin furious_A = mkA "furioso" | mkA "arrabbiato" ; -- status=guess status=guess
lin distinguished_A = variants{} ; -- 
lin characterize_V2 = variants{} ; -- 
lin alike_Adv = variants{} ; -- 
lin pump_N = mkN "pompa" ; -- status=guess
lin probe_N = mkN "inchiesta" | mkN "investigazione" feminine ; -- status=guess status=guess
lin feedback_N = variants{} ; -- 
lin aspiration_N = variants{} ; -- 
lin suspect_N = variants{} ; -- 
lin solar_A = mkA "solare" ; -- status=guess
lin fare_N = mkN "vitto" | mkN "cibo" ; -- status=guess status=guess
lin carve_V2 = variants{} ; -- 
lin carve_V = variants{} ; -- 
lin qualified_A = variants{} ; -- 
lin membrane_N = mkN "membrana" ; -- status=guess
lin dependence_N = mkN "dipendenza" ; -- status=guess
lin convict_V2 = mkV2 (mkV "condannare") ; -- status=guess, src=wikt
lin bacteria_N = mkN "batteri" masculine ; -- status=guess
lin trading_N = mkN "figurina" ; -- status=guess
lin ambassador_N = mkN "ambasciatore" masculine ; -- status=guess
lin wound_V2 = mkV2 (mkV "ferire") | mkV2 (mkV "offendere") ; -- status=guess, src=wikt status=guess, src=wikt
lin drug_V2 = mkV2 (mkV "drogare") ; -- status=guess, src=wikt
lin conjunction_N = mkN "congiunzione" feminine ; -- status=guess
lin cabin_N = mkN "cabina" ; -- status=guess
lin trail_V2 = mkV2 (mkV "trascinare") | mkV2 (mkV "trainare") ; -- status=guess, src=wikt status=guess, src=wikt
lin trail_V = mkV "trascinare" | mkV "trainare" ; -- status=guess, src=wikt status=guess, src=wikt
lin shaft_N = mkN "pozzo" ; -- status=guess
lin treasure_N = mkN "tesoro" ; -- status=guess
lin inappropriate_A = variants{} ; -- 
lin half_Adv = mkAdv "tiepidamente" ; -- status=guess
lin attribute_N = variants{} ; -- 
lin liquid_A = mkA "liquido" | mkA "liquida" ; -- status=guess status=guess
lin embassy_N = mkN "ambasciata" ; -- status=guess
lin terribly_Adv = variants{} ; -- 
lin exemption_N = variants{} ; -- 
lin array_N = variants{} ; -- 
lin tablet_N = variants{} ; -- 
lin sack_V2 = variants{} ; -- 
lin erosion_N = variants{} ; -- 
lin bull_N = mkN "maschio" ; -- status=guess
lin warehouse_N = mkN "magazzino" ; -- status=guess
lin unfortunate_A = mkA "sfortunato" ; -- status=guess
lin promoter_N = variants{} ; -- 
lin compel_VV = variants{} ; -- 
lin compel_V2V = variants{} ; -- 
lin compel_V2 = variants{} ; -- 
lin motivate_V2V = mkV2V (mkV "motivare") ; -- status=guess, src=wikt
lin motivate_V2 = mkV2 (mkV "motivare") ; -- status=guess, src=wikt
lin burning_A = variants{} ; -- 
lin vitamin_N = mkN "vitamina" ; -- status=guess
lin sail_N = mkN "vela" masculine ; -- status=guess
lin lemon_N = mkN "citronella" | mkN "melissa vera" | mkN "melissa" | mkN "cedronella" | mkN "erba limona" ; -- status=guess status=guess status=guess status=guess status=guess
lin foreigner_N = mkN "straniero" | mkN "straniera" ; -- status=guess status=guess
lin powder_N = mkN "polvere" masculine ; -- status=guess
lin persistent_A = variants{} ; -- 
lin bat_N = mkN "pipistrello" ; -- status=guess
lin ancestor_N = mkN "ascendente" | mkN "antenato" ; -- status=guess status=guess
lin predominantly_Adv = variants{} ; -- 
lin mathematical_A = variants{} ; -- 
lin compliance_N = mkN "arrendevolezza" ; -- status=guess
lin arch_N = variants{} ; -- 
lin woodland_N = variants{} ; -- 
lin serum_N = mkN "siero" ; -- status=guess
lin overnight_Adv = variants{} ; -- 
lin doubtful_A = variants{} ; -- 
lin doing_N = variants{} ; -- 
lin coach_V2 = mkV2 (mkV "allenare") | mkV2 (mkV "addestrare") ; -- status=guess, src=wikt status=guess, src=wikt
lin coach_V = mkV "allenare" | mkV "addestrare" ; -- status=guess, src=wikt status=guess, src=wikt
lin binding_A = variants{} ; -- 
lin surrounding_A = variants{} ; -- 
lin peer_N = mkN "pari" | mkN "nobile" masculine ; -- status=guess status=guess
lin ozone_N = mkN "ozono" ; -- status=guess
lin mid_A = variants{} ; -- 
lin invisible_A = mkA "invisibile" ; -- status=guess
lin depart_V = mkV (mkV "deviare") "da" ; -- status=guess, src=wikt
lin brigade_N = variants{} ; -- 
lin manipulate_V2 = mkV2 (mkV "manipolare") ; -- status=guess, src=wikt
lin consume_V2 = mkV2 (mkV "consumare") ; -- status=guess, src=wikt
lin consume_V = mkV "consumare" ; -- status=guess, src=wikt
lin temptation_N = mkN "tentazione" feminine ; -- status=guess
lin intact_A = variants{} ; -- 
lin glove_N = L.glove_N ;
lin aggression_N = mkN "aggressione" feminine ; -- status=guess
lin emergence_N = mkN "emergenza" ; -- status=guess
lin stag_V = variants{} ; -- 
lin coffin_N = mkN "bara" | mkN "cassa da morto" ; -- status=guess status=guess
lin beautifully_Adv = variants{} ; -- 
lin clutch_V2 = variants{} ; -- 
lin clutch_V = variants{} ; -- 
lin wit_N = mkN "arguzia" | mkN "genio" ; -- status=guess status=guess
lin underline_V2 = mkV2 (mkV "sottolineare") ; -- status=guess, src=wikt
lin trainee_N = variants{} ; -- 
lin scrutiny_N = variants{} ; -- 
lin neatly_Adv = variants{} ; -- 
lin follower_N = variants{} ; -- 
lin sterling_A = variants{} ; -- 
lin tariff_N = variants{} ; -- 
lin bee_N = mkN "ape" feminine ; -- status=guess
lin relaxation_N = mkN "rilassamento" ; -- status=guess
lin negligence_N = mkN "negligenza" ; -- status=guess
lin sunlight_N = variants{} ; -- 
lin penetrate_V2 = mkV2 (mkV "penetrare") ; -- status=guess, src=wikt
lin penetrate_V = mkV "penetrare" ; -- status=guess, src=wikt
lin knot_N = mkN "nodo" ; -- status=guess
lin temper_N = variants{} ; -- 
lin skull_N = mkN "cranio" | mkN "teschio" ; -- status=guess status=guess
lin openly_Adv = variants{} ; -- 
lin grind_V2 = mkV2 (mkV "macinare") ; -- status=guess, src=wikt
lin grind_V = mkV "macinare" ; -- status=guess, src=wikt
lin whale_N = mkN "balena" ; -- status=guess
lin throne_N = mkN "trono" ; -- status=guess
lin supervise_V2 = variants{} ; -- 
lin supervise_V = variants{} ; -- 
lin sickness_N = mkN "malattia" ; -- status=guess
lin package_V2 = variants{} ; -- 
lin intake_N = variants{} ; -- 
lin within_Adv = variants{}; -- mkPrep "dentro" ;
lin inland_A = variants{} ; -- 
lin beast_N = mkN "bestia" ; -- status=guess
lin rear_N = mkN "posteriore" masculine ; -- status=guess
lin morality_N = mkN "moralità" feminine ; -- status=guess
lin competent_A = variants{} ; -- 
lin sink_N = mkN "lavandino" | mkN "lavello" | mkN "lavello" ; -- status=guess status=guess status=guess
lin uniform_A = mkA "uniforme" ; -- status=guess
lin reminder_N = variants{} ; -- 
lin permanently_Adv = variants{} ; -- 
lin optimistic_A = mkA "ottimista" ; -- status=guess
lin bargain_N = variants{} ; -- 
lin seemingly_Adv = variants{} ; -- 
lin respective_A = variants{} ; -- 
lin horizontal_A = mkA "orizzontale" ; -- status=guess
lin decisive_A = mkA "decisivo" ; -- status=guess
lin bless_V2 = mkV2 (benedire_V) ; -- status=guess, src=wikt
lin bile_N = mkN "acido biliare" ; -- status=guess
lin spatial_A = mkA "spaziale" ; -- status=guess
lin bullet_N = mkN "proiettile" masculine ; -- status=guess
lin respectable_A = variants{} ; -- 
lin overseas_Adv = mkAdv "all'estero" ; -- status=guess
lin convincing_A = variants{} ; -- 
lin unacceptable_A = variants{} ; -- 
lin confrontation_N = mkN "scontro" ; -- status=guess
lin swiftly_Adv = variants{} ; -- 
lin paid_A = variants{} ; -- 
lin joke_V = mkV "scherzare" ; -- status=guess, src=wikt
lin instant_A = mkA "immediato" ; -- status=guess
lin illusion_N = mkN "illusione" feminine ; -- status=guess
lin cheer_V2 = variants{} ; -- 
lin cheer_V = variants{} ; -- 
lin congregation_N = mkN "congregazione" feminine ; -- status=guess
lin worldwide_Adv = variants{} ; -- 
lin winning_A = variants{} ; -- 
lin wake_N = mkN "scia" ; -- status=guess
lin toss_V2 = mkV2 (mkV "tirare") | mkV2 (mkV (mkV "lanciare") "una moneta") | mkV2 (mkV (I.fare_V) "testa o croce") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin toss_V = mkV "tirare" | mkV (mkV "lanciare") "una moneta" | mkV (I.fare_V) "testa o croce" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin medium_A = mkA "medio" ; -- status=guess
lin jewellery_N = mkN "gioielleria" | mkN "silver and gemstone)" | mkN "bigiotteria" ; -- status=guess status=guess status=guess
lin fond_A = mkA "innamorato" ; ----
lin alarm_V2 = variants{} ; -- 
lin guerrilla_N = variants{} ; -- 
lin dive_V = mkV "tuffarsi" ; -- status=guess, src=wikt
lin desire_V2 = mkV2 (mkV "desiderare") | mkV2 (volere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin cooperation_N = mkN "cooperazione" feminine ; -- status=guess
lin thread_N = mkN "filo" | mkN "filo conduttore" ; -- status=guess status=guess
lin prescribe_V2 = variants{} ; -- 
lin prescribe_V = variants{} ; -- 
lin calcium_N = mkN "calcio" ; -- status=guess
lin redundant_A = variants{} ; -- 
lin marker_N = mkN "marcatore" ; -- status=guess
lin chemist_N = variants{} ; -- 
lin mammal_N = mkN "mammifero" ; -- status=guess
lin legacy_N = mkN "eredità" feminine ; -- status=guess
lin debtor_N = mkN "debitore" | mkN "debitrice" feminine ; -- status=guess status=guess
lin testament_N = mkN "testamento" ; -- status=guess
lin tragic_A = mkA "tragico" ; -- status=guess
lin silver_A = mkA "argenteo" ; -- status=guess
lin grin_N = mkN "sorriso" ; -- status=guess
lin spectacle_N = variants{} ; -- 
lin inheritance_N = mkN "ereditarietà" feminine ; -- status=guess
lin heal_V2 = mkV2 (mkV "guarire") | mkV2 (mkV "sanare") ; -- status=guess, src=wikt status=guess, src=wikt
lin heal_V = mkV "guarire" | mkV "sanare" ; -- status=guess, src=wikt status=guess, src=wikt
lin sovereignty_N = mkN "sovranità" feminine ; -- status=guess
lin enzyme_N = variants{} ; -- 
lin host_V2 = mkV2 (mkV "ospitare") ; -- status=guess, src=wikt
lin neighbouring_A = variants{} ; -- 
lin corn_N = mkN "callo" | mkN "durone" masculine ; -- status=guess status=guess
lin layout_N = variants{} ; -- 
lin dictate_VS = variants{} ; -- 
lin dictate_V2 = variants{} ; -- 
lin dictate_V = variants{} ; -- 
lin rip_V2 = mkV2 (mkV "strappare") ; -- status=guess, src=wikt
lin rip_V = mkV "strappare" ; -- status=guess, src=wikt
lin regain_V2 = variants{} ; -- 
lin probable_A = mkA "probabile" ; -- status=guess
lin inclusion_N = mkN "inclusione" feminine ; -- status=guess
lin booklet_N = mkN "libretto" | mkN "libello" ; -- status=guess status=guess
lin bar_V2 = mkV2 (mkV "vietare") ; -- status=guess, src=wikt
lin privately_Adv = variants{} ; -- 
lin laser_N = mkN "laser" feminine ; -- status=guess
lin fame_N = mkN "fama" ; -- status=guess
lin bronze_N = mkN "bronzo" ; -- status=guess
lin mobile_A = mkA "mobile" ; -- status=guess
lin metaphor_N = mkN "metafora" ; -- status=guess
lin complication_N = variants{} ; -- 
lin narrow_V2 = variants{} ; -- 
lin narrow_V = variants{} ; -- 
lin old_fashioned_A = variants{} ; -- 
lin chop_V2 = mkV2 (mkV "tagliare") ; -- status=guess, src=wikt
lin chop_V = mkV "tagliare" ; -- status=guess, src=wikt
lin synthesis_N = variants{} ; -- 
lin diameter_N = mkN "diametro" ; -- status=guess
lin bomb_V2 = mkV2 (mkV "bombardare") ; -- status=guess, src=wikt
lin bomb_V = mkV "bombardare" ; -- status=guess, src=wikt
lin silently_Adv = variants{} ; -- 
lin shed_N = variants{} ; -- 
lin fusion_N = mkN "fusione" feminine ; -- status=guess
lin trigger_V2 = mkV2 (mkV (mkV "premere") "il grilletto") ; -- status=guess, src=wikt
lin printing_N = variants{} ; -- 
lin onion_N = mkN "cipolla" ; -- status=guess
lin dislike_V2 = mkV2 (mkV (mkV "non") "piacersi") ; -- status=guess, src=wikt
lin embody_V2 = variants{} ; -- 
lin curl_V = variants{} ; -- 
lin sunshine_N = mkN "luce del sole" ; -- status=guess
lin sponsorship_N = variants{} ; -- 
lin rage_N = mkN "rabbia" | mkN "furia" ; -- status=guess status=guess
lin loop_N = mkN "cerchio della morte" | mkN "giro della morte" ; -- status=guess status=guess
lin halt_N = variants{} ; -- 
lin cop_V2 = variants{} ; -- 
lin bang_V2 = variants{} ; -- 
lin bang_V = variants{} ; -- 
lin toxic_A = mkA "tossico" | mkA "tossica" ; -- status=guess status=guess
lin thinking_A = variants{} ; -- 
lin orientation_N = mkN "orientamento" ; -- status=guess
lin likelihood_N = mkN "verosimiglianza" | mkN "verisimiglianza" ; -- status=guess status=guess
lin wee_A = mkA "piccolo" ; -- status=guess
lin up_to_date_A = variants{} ; -- 
lin polite_A = mkA "cortese" | mkA "educato" ; -- status=guess status=guess
lin apology_N = mkN "apologia" ; -- status=guess
lin exile_N = mkN "esiliato" | mkN "esule" ; -- status=guess status=guess
lin brow_N = mkN "fronte" feminine ; -- status=guess
lin miserable_A = variants{} ; -- 
lin outbreak_N = variants{} ; -- 
lin comparatively_Adv = variants{} ; -- 
lin pump_V2 = mkV2 (mkV "pompare") ; -- status=guess, src=wikt
lin pump_V = mkV "pompare" ; -- status=guess, src=wikt
lin fuck_V2 = mkV2 (mkV "cazzeggiare") ; -- status=guess, src=wikt
lin fuck_V = mkV "cazzeggiare" ; -- status=guess, src=wikt
lin forecast_VS = mkVS (prevedere_V) ; -- status=guess, src=wikt
lin forecast_V2 = mkV2 (prevedere_V) ; -- status=guess, src=wikt
lin forecast_V = prevedere_V ; -- status=guess, src=wikt
lin timing_N = variants{} ; -- 
lin headmaster_N = variants{} ; -- 
lin terrify_V2 = variants{} ; -- 
lin sigh_N = mkN "sospiro" ; -- status=guess
lin premier_A = variants{} ; -- 
lin joint_N = mkN "conto congiunto" ; -- status=guess
lin incredible_A = mkA "incredibile" ; -- status=guess
lin gravity_N = mkN "gravità" feminine ; -- status=guess
lin regulatory_A = variants{} ; -- 
lin cylinder_N = mkN "cilindro" ; -- status=guess
lin curiosity_N = mkN "curiosità" ; -- status=guess
lin resident_A = variants{} ; -- 
lin narrative_N = mkN "descrizione" feminine ; -- status=guess
lin cognitive_A = mkA "cognitivo" ; -- status=guess
lin lengthy_A = variants{} ; -- 
lin gothic_A = variants{} ; -- 
lin dip_V2 = variants{} ; -- 
lin dip_V = variants{} ; -- 
lin adverse_A = mkA "ostile" ; -- status=guess
lin accountability_N = mkN "responsabilità" feminine ; -- status=guess
lin hydrogen_N = mkN "idrogeno" ; -- status=guess
lin gravel_N = mkN "ghiaia" ; -- status=guess
lin willingness_N = variants{} ; -- 
lin inhibit_V2 = variants{} ; -- 
lin attain_V2 = mkV2 (raggiungere_V) | mkV2 (ottenere_V) | mkV2 (attenere_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin attain_V = raggiungere_V | ottenere_V | attenere_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin specialize_V2 = variants{} ; -- 
lin specialize_V = variants{} ; -- 
lin steer_V2 = mkV2 (mkV "dirigersi") ; -- status=guess, src=wikt
lin steer_V = mkV "dirigersi" ; -- status=guess, src=wikt
lin selected_A = variants{} ; -- 
lin like_N = mkN "preferenza" ; -- status=guess
lin confer_V = mkV "conferire" ; -- status=guess, src=wikt
lin usage_N = mkN "uso" | mkN "utilizzo" ; -- status=guess status=guess
lin portray_V2 = variants{} ; -- 
lin planner_N = variants{} ; -- 
lin manual_A = mkA "manuale" ; -- status=guess
lin boast_VS = mkVS (mkV "vantarsi") ; -- status=guess, src=wikt
lin boast_V2 = mkV2 (mkV "vantarsi") ; -- status=guess, src=wikt
lin boast_V = mkV "vantarsi" ; -- status=guess, src=wikt
lin unconscious_A = variants{} ; -- 
lin jail_N = variants{} ; -- 
lin fertility_N = mkN "fertilità" ;
lin documentation_N = mkN "documentazione" feminine ; -- status=guess
lin wolf_N = mkN "lupo" ; -- status=guess
lin patent_N = mkN "brevetto" ; -- status=guess
lin exit_N = mkN "uscita" ; -- status=guess
lin corps_N = variants{} ; -- 
lin proclaim_VS = variants{} ; -- 
lin proclaim_V2 = variants{} ; -- 
lin multiply_V2 = mkV2 (mkV "moltiplicare") ; -- status=guess, src=wikt
lin multiply_V = mkV "moltiplicare" ; -- status=guess, src=wikt
lin brochure_N = variants{} ; -- 
lin screen_V2 = variants{} ; -- 
lin screen_V = variants{} ; -- 
lin orthodox_A = mkA "ortodosso" ; -- status=guess
lin locomotive_N = variants{} ; -- 
lin considering_Prep = variants{} ; -- 
lin unaware_A = mkA "ignaro" | mkA "inconsapevole" ; -- status=guess status=guess
lin syndrome_N = mkN "sindrome" feminine ; -- status=guess
lin reform_V2 = variants{} ; -- 
lin reform_V = variants{} ; -- 
lin confirmation_N = mkN "conferma" ; -- status=guess
lin printed_A = variants{} ; -- 
lin curve_V2 = mkV2 (mkV "curvare") ; -- status=guess, src=wikt
lin curve_V = mkV "curvare" ; -- status=guess, src=wikt
lin costly_A = variants{} ; -- 
lin underground_A = mkA "sotterraneo" ; -- status=guess
lin territorial_A = mkA "territoriale" ; -- status=guess
lin designate_VS = variants{} ; -- 
lin designate_V2V = variants{} ; -- 
lin designate_V2 = variants{} ; -- 
lin designate_V = variants{} ; -- 
lin comfort_V2 = variants{} ; -- 
lin plot_V2 = variants{} ; -- 
lin plot_V = variants{} ; -- 
lin misleading_A = variants{} ; -- 
lin weave_V2 = mkV2 (mkV "tessere") ; -- status=guess, src=wikt
lin weave_V = mkV "tessere" ; -- status=guess, src=wikt
lin scratch_V2 = L.scratch_V2 ;
lin scratch_V = mkV "obliterare" ; -- status=guess, src=wikt
lin echo_N = mkN "eco" feminine ; -- status=guess
lin ideally_Adv = variants{} ; -- 
lin endure_V2 = mkV2 (mkV "durare") | mkV2 (mkV "restare") ; -- status=guess, src=wikt status=guess, src=wikt
lin endure_V = mkV "durare" | mkV "restare" ; -- status=guess, src=wikt status=guess, src=wikt
lin verbal_A = mkA "[5] deverbale" ; -- status=guess
lin stride_V = mkV "scavalcare" ; -- status=guess, src=wikt
lin nursing_N = mkN "casa di riposo" ; -- status=guess
lin exert_V2 = variants{} ; -- 
lin compatible_A = mkA "compatibile" ; -- status=guess
lin causal_A = variants{} ; -- 
lin mosaic_N = mkN "mosaico" ; -- status=guess
lin manor_N = variants{} ; -- 
lin implicit_A = mkA "implicito" ; -- status=guess
lin following_Prep = variants{} ; -- 
lin fashionable_A = variants{} ; -- 
lin valve_N = mkN "valvola" ; -- status=guess
lin proceed_N = variants{} ; -- 
lin sofa_N = mkN "divano" | mkN "sofà" masculine ; -- status=guess status=guess
lin snatch_V2 = mkV2 (mkV "strappare") ; -- status=guess, src=wikt
lin snatch_V = mkV "strappare" ; -- status=guess, src=wikt
lin jazz_N = mkN "jazz" masculine ; -- status=guess
lin patron_N = mkN "cliente" masculine ; -- status=guess
lin provider_N = mkN "fornitore" masculine ; -- status=guess
lin interim_A = variants{} ; -- 
lin intent_N = variants{} ; -- 
lin chosen_A = variants{} ; -- 
lin applied_A = variants{} ; -- 
lin shiver_V = mkV "rabbrividire" | mkV "tremare" ; -- status=guess, src=wikt status=guess, src=wikt
lin pie_N = mkN "pasticcio" ; -- status=guess
lin fury_N = mkN "furia" ; -- status=guess
lin abolition_N = mkN "abolizione" feminine ; -- status=guess
lin soccer_N = mkN "calcio" ; -- status=guess
lin corpse_N = variants{} ; -- 
lin accusation_N = mkN "accusa" ; -- status=guess
lin kind_A = mkA "gentile" | mkA "carino" ; -- status=guess status=guess
lin dead_Adv = variants{} ; -- 
lin nursing_A = variants{} ; -- 
lin contempt_N = mkN "disprezzo" ; -- status=guess
lin prevail_V = variants{} ; -- 
lin murderer_N = mkN "assassino" ; -- status=guess
lin liberal_N = variants{} ; -- 
lin gathering_N = mkN "quaderno" ; -- status=guess
lin adequately_Adv = variants{} ; -- 
lin subjective_A = variants{} ; -- 
lin disagreement_N = mkN "disaccordo" ; -- status=guess
lin cleaner_N = variants{} ; -- 
lin boil_V2 = mkV2 (mkV "bollire") ; -- status=guess, src=wikt
lin boil_V = mkV "bollire" ; -- status=guess, src=wikt
lin static_A = variants{} ; -- 
lin scent_N = mkN "odore" masculine | mkN "profumo" ; -- status=guess status=guess
lin civilian_N = mkN "civile" masculine ; -- status=guess
lin monk_N = mkN "monaco" | mkN "frate" masculine ; -- status=guess status=guess
lin abruptly_Adv = variants{} ; -- 
lin keyboard_N = mkN "tastiera" ; -- status=guess
lin hammer_N = mkN "falce e martello" ; -- status=guess
lin despair_N = mkN "disperazione" feminine ; -- status=guess
lin controller_N = mkN "revisore" masculine ; -- status=guess
lin yell_V2 = mkV2 (mkV "urlare") | mkV2 (mkV "gridare") | mkV2 (mkV "strillare") | mkV2 (mkV "sbraitare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin yell_V = mkV "urlare" | mkV "gridare" | mkV "strillare" | mkV "sbraitare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin entail_V2 = mkV2 (mkV "comportare") | mkV2 (mkV "implicare") ; -- status=guess, src=wikt status=guess, src=wikt
lin cheerful_A = mkA "allegro" ; -- status=guess
lin reconstruction_N = mkN "ricostruzione" feminine ; -- status=guess
lin patience_N = mkN "pazienza" ; -- status=guess
lin legally_Adv = variants{} ; -- 
lin habitat_N = variants{} ; -- 
lin queue_N = mkN "coda" ; -- status=guess
lin spectator_N = variants{} ; -- 
lin given_A = variants{} ; -- 
lin purple_A = variants{} ; -- 
lin outlook_N = mkN "punto di vista" ; -- status=guess
lin genius_N = variants{} ; -- 
lin dual_A = variants{} ; -- 
lin canvas_N = mkN "tela" ; -- status=guess
lin grave_A = variants{} ; -- 
lin pepper_N = mkN "[spicy] peperoncino" | mkN "[mild] peperone" ; -- status=guess status=guess
lin conform_V2 = variants{} ; -- 
lin conform_V = variants{} ; -- 
lin cautious_A = mkA "cauto" | mkA "ritenuto" | mkA "oculato" ; -- status=guess status=guess status=guess
lin dot_N = mkN "punto" ; -- status=guess
lin conspiracy_N = mkN "cospirazione" feminine ; -- status=guess
lin butterfly_N = mkN "farfalla" ; -- status=guess
lin sponsor_N = variants{} ; -- 
lin sincerely_Adv = variants{} ; -- 
lin rating_N = mkN "punteggio" | mkN "valutazione" feminine ; -- status=guess status=guess
lin weird_A = mkA "bizzarro" ; -- status=guess
lin teenage_A = variants{} ; -- 
lin salmon_N = mkN "salmone" masculine ; -- status=guess
lin recorder_N = mkN "flauto" ; -- status=guess
lin postpone_V2 = mkV2 (mkV "rimandare") ; -- status=guess, src=wikt
lin maid_N = mkN "cameriera" ; -- status=guess
lin furnish_V2 = mkV2 (mkV "fornire") ; -- status=guess, src=wikt
lin ethical_A = variants{} ; -- 
lin bicycle_N = mkN "bicicletta" | mkN "bici" ; -- status=guess status=guess
lin sick_N = mkN "gli ammalati" ; -- status=guess
lin sack_N = mkN "sacco" ; -- status=guess
lin renaissance_N = variants{} ; -- 
lin luxury_N = mkN "lusso" feminine ; -- status=guess
lin gasp_V2 = mkV2 (mkV "rantolare") | mkV2 (mkV "ansimare") | mkV2 (mkV "boccheggiare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin gasp_V = mkV "rantolare" | mkV "ansimare" | mkV "boccheggiare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wardrobe_N = mkN "armadio" ; -- status=guess
lin native_N = mkN "alluminio nativo" ; -- status=guess
lin fringe_N = mkN "frangia" ; -- status=guess
lin adaptation_N = variants{} ; -- 
lin quotation_N = mkN "preventivo" ; -- status=guess
lin hunger_N = mkN "fame" feminine ; -- status=guess
lin enclose_V2 = mkV2 (mkV "cintare") ; -- status=guess, src=wikt
lin disastrous_A = mkA "disastroso" ; -- status=guess
lin choir_N = mkN "coro" ; -- status=guess
lin overwhelming_A = variants{} ; -- 
lin glimpse_N = variants{} ; -- 
lin divorce_V2 = mkV2 (mkV "divorziare") ; -- status=guess, src=wikt
lin circular_A = variants{} ; -- 
lin locality_N = variants{} ; -- 
lin ferry_N = mkN "traghetto" ; -- status=guess
lin balcony_N = mkN "balcone" masculine ; -- status=guess
lin sailor_N = mkN "marinaio" | mkN "marittimo" | mkN "navigante" masculine ; -- status=guess status=guess status=guess
lin precision_N = mkN "precisione" feminine ; -- status=guess
lin desert_V2 = variants{} ; -- 
lin desert_V = variants{} ; -- 
lin dancing_N = variants{} ; -- 
lin alert_V2 = variants{} ; -- 
lin surrender_V2 = mkV2 (mkV "arrendersi") ; -- status=guess, src=wikt
lin surrender_V = mkV "arrendersi" ; -- status=guess, src=wikt
lin archive_N = mkN "archivio" ; -- status=guess
lin jump_N = mkN "salto" ; -- status=guess
lin philosopher_N = mkN "filosofo" ; -- status=guess
lin revival_N = mkN "rinnovamento" ; -- status=guess
lin presume_VS = variants{} ; -- 
lin presume_V2 = variants{} ; -- 
lin presume_V = variants{} ; -- 
lin node_N = variants{} ; -- 
lin fantastic_A = mkA "fantastico" | mkA "fantastica" ; -- status=guess status=guess
lin herb_N = mkN "erba medicinale" ; -- status=guess
lin assertion_N = mkN "asserzione" feminine ; -- status=guess
lin thorough_A = mkA "minuzioso" | mkA "accurato" ; -- status=guess status=guess
lin quit_V2 = mkV2 (smettere_V) | mkV2 (mkV "abbandonare") ; -- status=guess, src=wikt status=guess, src=wikt
lin quit_V = smettere_V | mkV "abbandonare" ; -- status=guess, src=wikt status=guess, src=wikt
lin grim_A = mkA "arcigno" | mkA "fosco" ; -- status=guess status=guess
lin fair_N = mkN "fiera" ; -- status=guess
lin broadcast_V2 = mkV2 (trasmettere_V) ; -- status=guess, src=wikt
lin broadcast_V = trasmettere_V ; -- status=guess, src=wikt
lin annoy_V2 = mkV2 (mkV "infastidirsi") | mkV2 (mkV "infastidire") | mkV2 (mkV "importunare") | mkV2 (mkV "disturbare") | mkV2 (mkV "irritare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin divert_V = variants{} ; -- 
lin accelerate_V2 = mkV2 (mkV "accelerare") ; -- status=guess, src=wikt
lin accelerate_V = mkV "accelerare" ; -- status=guess, src=wikt
lin polymer_N = mkN "polimero" ; -- status=guess
lin sweat_N = mkN "sudore" masculine ; -- status=guess
lin survivor_N = mkN "superstite" masculine ; -- status=guess
lin subscription_N = variants{} ; -- 
lin repayment_N = variants{} ; -- 
lin anonymous_A = mkA "anonimo" ; -- status=guess
lin summarize_V2 = mkV2 (riassumere_V) ; -- status=guess, src=wikt
lin punch_N = mkN "scheda perforata" ; -- status=guess
lin lodge_V2 = mkV2 (mkV "alloggiare") ; -- status=guess, src=wikt
lin lodge_V = mkV "alloggiare" ; -- status=guess, src=wikt
lin landowner_N = variants{} ; -- 
lin ignorance_N = mkN "ignoranza" ; -- status=guess
lin discourage_V2 = mkV2 (mkV "scoraggiare") ; -- status=guess, src=wikt
lin bride_N = mkN "fidanzata" | mkN "sposa" ; -- status=guess status=guess
lin likewise_Adv = mkAdv "ugualmente" | mkAdv "similarmente" ; -- status=guess status=guess
lin depressed_A = variants{} ; -- 
lin abbey_N = mkN "abbazia" ; -- status=guess
lin quarry_N = mkN "preda" ; -- status=guess
lin archbishop_N = mkN "arcivescovo" ; -- status=guess
lin sock_N = L.sock_N ;
lin large_scale_A = variants{} ; -- 
lin glare_V2 = variants{} ; -- 
lin glare_V = variants{} ; -- 
lin descent_N = mkN "ascendenza" ; -- status=guess
lin stumble_V = mkV "scivolare" ; -- status=guess, src=wikt
lin mistress_N = mkN "dominatrice" | mkN "padrona" ; -- status=guess status=guess
lin empty_V2 = mkV2 (mkV "vuotare") ; -- status=guess, src=wikt
lin empty_V = mkV "vuotare" ; -- status=guess, src=wikt
lin prosperity_N = variants{} ; -- 
lin harm_V2 = mkV2 (mkV "danneggiare") ; -- status=guess, src=wikt
lin formulation_N = variants{} ; -- 
lin atomic_A = mkA "atomico" ; -- status=guess
lin agreed_A = variants{} ; -- 
lin wicked_A = mkA "malvagio" | mkA "malvagia" ; -- status=guess status=guess
lin threshold_N = mkN "soglia" masculine ; -- status=guess
lin lobby_N = mkN "atrio" ; -- status=guess
lin repay_V2 = mkV2 (mkV "ripagare") | mkV2 (mkV "restituire") ; -- status=guess, src=wikt status=guess, src=wikt
lin repay_V = mkV "ripagare" | mkV "restituire" ; -- status=guess, src=wikt status=guess, src=wikt
lin varying_A = variants{} ; -- 
lin track_V2 = variants{} ; -- 
lin track_V = variants{} ; -- 
lin crawl_V = mkV "strisciare" ; -- status=guess, src=wikt
lin tolerate_V2 = mkV2 (mkV "tollerare") ; -- status=guess, src=wikt
lin salvation_N = mkN "salvezza" ; -- status=guess
lin pudding_N = mkN "budino" ; -- status=guess
lin counter_VS = mkVS (contraddire_V) ; -- status=guess, src=wikt
lin counter_V = contraddire_V ; -- status=guess, src=wikt
lin propaganda_N = mkN "propaganda" ; -- status=guess
lin cage_N = mkN "gabbia" ; -- status=guess
lin broker_N = variants{} ; -- 
lin ashamed_A = variants{} ; -- 
lin scan_V2 = mkV2 (mkV "scannerizzare") ; -- status=guess, src=wikt
lin scan_V = mkV "scannerizzare" ; -- status=guess, src=wikt
lin document_V2 = variants{} ; -- 
lin apparatus_N = mkN "apparecchio" ; -- status=guess
lin theology_N = mkN "teologia" ; -- status=guess
lin analogy_N = mkN "analogia" ; -- status=guess
lin efficiently_Adv = variants{} ; -- 
lin bitterly_Adv = variants{} ; -- 
lin performer_N = mkN "esecutore" ; -- status=guess
lin individually_Adv = variants{} ; -- 
lin amid_Prep = variants{} ; -- 
lin squadron_N = variants{} ; -- 
lin sentiment_N = variants{} ; -- 
lin making_N = variants{} ; -- 
lin exotic_A = mkA "esotico" ; -- status=guess
lin dominance_N = variants{} ; -- 
lin coherent_A = mkA "coerente" ; -- status=guess
lin placement_N = mkN "piazzamento" ; -- status=guess
lin flick_V2 = variants{} ; -- 
lin colourful_A = variants{} ; -- 
lin mercy_N = mkN "misericordia" ; -- status=guess
lin angrily_Adv = variants{} ; -- 
lin amuse_V2 = variants{} ; -- 
lin mainstream_N = variants{} ; -- 
lin appraisal_N = variants{} ; -- 
lin annually_Adv = variants{} ; -- 
lin torch_N = mkN "torcia" ; -- status=guess
lin intimate_A = variants{} ; -- 
lin gold_A = variants{} ; -- 
lin arbitrary_A = mkA "arbitrario" | mkA "arbitraria" ; -- status=guess status=guess
lin venture_VS = variants{} ; -- 
lin venture_V2 = variants{} ; -- 
lin venture_V = variants{} ; -- 
lin preservation_N = variants{} ; -- 
lin shy_A = mkA "timido" ; -- status=guess
lin disclosure_N = variants{} ; -- 
lin lace_N = mkN "laccio" | mkN "stringa" ; -- status=guess status=guess
lin inability_N = variants{} ; -- 
lin motif_N = variants{} ; -- 
lin listener_N = variants{} ; -- 
lin hunt_N = mkN "caccia" masculine | mkN "spedizione di caccia" ; -- status=guess status=guess
lin delicious_A = mkA "squisito" | mkA "delizioso" ; -- status=guess status=guess
lin term_VS = variants{} ; -- 
lin term_V2 = variants{} ; -- 
lin substitute_N = mkN "sostituto" | mkN "rimpiazzo" ; -- status=guess status=guess
lin highway_N = mkN "strada maestra" ; -- status=guess
lin haul_V2 = variants{} ; -- 
lin haul_V = variants{} ; -- 
lin dragon_N = mkN "drago" | mkN "dragone" | mkN "viverna" ; -- status=guess status=guess status=guess
lin chair_V2 = variants{} ; -- 
lin accumulate_V2 = mkV2 (mkV "accumularsi") ; -- status=guess, src=wikt
lin accumulate_V = mkV "accumularsi" ; -- status=guess, src=wikt
lin unchanged_A = variants{} ; -- 
lin sediment_N = mkN "deposito" | mkN "sedimento" ; -- status=guess status=guess
lin sample_V2 = variants{} ; -- 
lin exclaim_V2 = variants{} ; -- 
lin fan_V2 = variants{} ; -- 
lin fan_V = variants{} ; -- 
lin volunteer_V2 = variants{} ; -- 
lin volunteer_V = variants{} ; -- 
lin root_V2 = mkV2 (mkV "scopare") | mkV2 (mkV "trombare") | mkV2 (mkV "fottere") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin root_V = mkV "scopare" | mkV "trombare" | mkV "fottere" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin parcel_N = mkN "lotto" | mkN "parcella" ; -- status=guess status=guess
lin psychiatric_A = mkA "psichiatrico" ; -- status=guess
lin delightful_A = variants{} ; -- 
lin confidential_A = mkA "confidenziale" ; -- status=guess
lin calorie_N = mkN "caloria" ; -- status=guess
lin flash_N = mkN "baleno" | mkN "lampo" ; -- status=guess status=guess
lin crowd_V2 = variants{} ; -- 
lin crowd_V = variants{} ; -- 
lin aggregate_A = variants{} ; -- 
lin scholarship_N = mkN "borsa di studi" ; -- status=guess
lin monitor_N = mkN "monitor" masculine ; -- status=guess
lin disciplinary_A = variants{} ; -- 
lin rock_V2 = mkV2 (mkV "cullare") ; -- status=guess, src=wikt
lin rock_V = mkV "cullare" ; -- status=guess, src=wikt
lin hatred_N = mkN "odio" | mkN "risentimento" ; -- status=guess status=guess
lin pill_N = mkN "pillola" ; -- status=guess
lin noisy_A = mkA "chiassoso" ; -- status=guess
lin feather_N = L.feather_N ;
lin lexical_A = mkA "lessicale" ; -- status=guess
lin staircase_N = mkN "scalinata" ; -- status=guess
lin autonomous_A = mkA "autonomo" | mkA "autonoma" ; -- status=guess status=guess
lin viewpoint_N = variants{} ; -- 
lin projection_N = variants{} ; -- 
lin offensive_A = mkA "offensivo" ; -- status=guess
lin controlled_A = variants{} ; -- 
lin flush_V2 = mkV2 (mkV "arrossire") ; -- status=guess, src=wikt
lin flush_V = mkV "arrossire" ; -- status=guess, src=wikt
lin racism_N = mkN "razzismo" ; -- status=guess
lin flourish_V = mkV "fiorire" ; -- status=guess, src=wikt
lin resentment_N = variants{} ; -- 
lin pillow_N = mkN "guanciale" | mkN "cuscino" ; -- status=guess status=guess
lin courtesy_N = mkN "cortesia" ; -- status=guess
lin photography_N = mkN "fotografia" ; -- status=guess
lin monkey_N = mkN "scimmia" ; -- status=guess
lin glorious_A = mkA "glorioso" ; -- status=guess
lin evolutionary_A = variants{} ; -- 
lin gradual_A = variants{} ; -- 
lin bankruptcy_N = mkN "bancarotta" ; -- status=guess
lin sacrifice_N = mkN "sacrificio" ; -- status=guess
lin uphold_V2 = mkV2 (mkV "difendere") | mkV2 (sostenere_V) | mkV2 (mkV (mkV "[law]") "confermare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sketch_N = mkN "schizzo" ; -- status=guess
lin presidency_N = variants{} ; -- 
lin formidable_A = variants{} ; -- 
lin differentiate_V2 = variants{} ; -- 
lin differentiate_V = variants{} ; -- 
lin continuing_A = variants{} ; -- 
lin cart_N = variants{} ; -- 
lin stadium_N = mkN "stadio" ; -- status=guess
lin dense_A = mkA "pastoso" ; -- status=guess
lin catch_N = mkN "fermaglio" | mkN "fermaglio di sicurezza" ; -- status=guess status=guess
lin beyond_Adv = variants{} ; -- 
lin immigration_N = mkN "immigrazione" feminine ; -- status=guess
lin clarity_N = mkN "chiarezza" ; -- status=guess
lin worm_N = L.worm_N ;
lin slot_N = mkN "sbarra" ; -- status=guess
lin rifle_N = mkN "fucile" masculine ; -- status=guess
lin screw_V2 = mkV2 (mkV "truffare") | mkV2 (mkV "fregare") ; -- status=guess, src=wikt status=guess, src=wikt
lin screw_V = mkV "truffare" | mkV "fregare" ; -- status=guess, src=wikt status=guess, src=wikt
lin harvest_N = mkN "festa del raccolto" ; -- status=guess
lin foster_V2 = variants{} ; -- 
lin academic_N = variants{} ; -- 
lin impulse_N = mkN "impulso" ; -- status=guess
lin guardian_N = mkN "angelo custode" ; -- status=guess
lin ambiguity_N = variants{} ; -- 
lin triangle_N = mkN "disuguaglianza triangolare" ; -- status=guess
lin terminate_V2 = variants{} ; -- 
lin terminate_V = variants{} ; -- 
lin retreat_V = mkV "ritirarsi" ; -- status=guess, src=wikt
lin pony_N = variants{} ; -- 
lin outdoor_A = variants{} ; -- 
lin deficiency_N = mkN "deficienza" ; -- status=guess
lin decree_N = mkN "decreto" ; -- status=guess
lin apologize_V = variants{} ; -- 
lin yarn_N = mkN "filo" | mkN "filato" ; -- status=guess status=guess
lin staff_V2 = variants{} ; -- 
lin renewal_N = variants{} ; -- 
lin rebellion_N = mkN "ribellione" feminine ; -- status=guess
lin incidentally_Adv = variants{} ; -- 
lin flour_N = mkN "farina" ; -- status=guess
lin developed_A = variants{} ; -- 
lin chorus_N = mkN "coro" ; -- status=guess
lin ballot_N = mkN "scheda elettorale" ; -- status=guess
lin appetite_N = mkN "appetito" ; -- status=guess
lin stain_V2 = mkV2 (mkV "mordenzare") ; -- status=guess, src=wikt
lin stain_V = mkV "mordenzare" ; -- status=guess, src=wikt
lin notebook_N = mkN "blocco" ; -- status=guess
lin loudly_Adv = variants{} ; -- 
lin homeless_A = variants{} ; -- 
lin census_N = mkN "censo" | mkN "censimento" ; -- status=guess status=guess
lin bizarre_A = mkA "bizzarro" | mkA "bizzarra" ; -- status=guess status=guess
lin striking_A = variants{} ; -- 
lin greenhouse_N = mkN "serra" ; -- status=guess
lin part_V2 = variants{} ; -- 
lin part_V = variants{} ; -- 
lin burial_N = mkN "sepoltura" | mkN "inumazione" feminine ; -- status=guess status=guess
lin embarrassed_A = variants{} ; -- 
lin ash_N = mkN "cenere" feminine ; -- status=guess
lin actress_N = mkN "attrice" feminine ; -- status=guess
lin cassette_N = mkN "cassetta pignoni" | mkN "pacco pignoni" ; -- status=guess status=guess
lin privacy_N = mkN "intimità" feminine | mkN "privacy" feminine ; -- status=guess status=guess
lin fridge_N = L.fridge_N ;
lin feed_N = variants{} ; -- 
lin excess_A = variants{} ; -- 
lin calf_N = mkN "polpaccio" ; -- status=guess
lin associate_N = variants{} ; -- 
lin ruin_N = mkN "rovina" ; -- status=guess
lin jointly_Adv = variants{} ; -- 
lin drill_V2 = mkV2 (mkV "scavare") ; -- status=guess, src=wikt
lin drill_V = mkV "scavare" ; -- status=guess, src=wikt
lin photograph_V2 = mkV2 (mkV "fotografare") ; -- status=guess, src=wikt
lin devoted_A = variants{} ; -- 
lin indirectly_Adv = variants{} ; -- 
lin driving_A = variants{} ; -- 
lin memorandum_N = variants{} ; -- 
lin default_N = mkN "predefinito" ; -- status=guess
lin costume_N = variants{} ; -- 
lin variant_N = mkN "variante" feminine ; -- status=guess
lin shatter_V2 = mkV2 (mkV (ridurre_V) "in mille pezzi") ; -- status=guess, src=wikt
lin shatter_V = mkV (ridurre_V) "in mille pezzi" ; -- status=guess, src=wikt
lin methodology_N = mkN "metodologia" ; -- status=guess
lin frame_V2 = mkV2 (mkV "incorniciare") ; -- status=guess, src=wikt
lin frame_V = mkV "incorniciare" ; -- status=guess, src=wikt
lin allegedly_Adv = variants{} ; -- 
lin swell_V2 = mkV2 (mkV "gonfiare") ; -- status=guess, src=wikt
lin swell_V = L.swell_V ;
lin investigator_N = variants{} ; -- 
lin imaginative_A = variants{} ; -- 
lin bored_A = variants{} ; -- 
lin bin_N = mkN "bidone" masculine ; -- status=guess
lin awake_A = mkA "veglia" ;
lin recycle_V2 = mkV2 (mkV "riciclare") ; -- status=guess, src=wikt
lin group_V2 = mkV2 (mkV "raggruppare") ; -- status=guess, src=wikt
lin group_V = mkV "raggruppare" ; -- status=guess, src=wikt
lin enjoyment_N = variants{} ; -- 
lin contemporary_N = variants{} ; -- 
lin texture_N = mkN "texture" feminine ; -- status=guess
lin donor_N = mkN "donatore" | mkN "offerente" ; -- status=guess status=guess
lin bacon_N = mkN "pancetta" ; -- status=guess
lin sunny_A = mkA "soleggiato" | mkA "soleggiata" ; -- status=guess status=guess
lin stool_N = mkN "sgabello" ; -- status=guess
lin prosecute_V2 = variants{} ; -- 
lin commentary_N = variants{} ; -- 
lin bass_N = mkN "clarinetto basso" ; -- status=guess
lin sniff_V2 = mkV2 (mkV "annusare") ; -- status=guess, src=wikt
lin sniff_V = mkV "annusare" ; -- status=guess, src=wikt
lin repetition_N = mkN "ripetizione" feminine ; -- status=guess
lin eventual_A = variants{} ; -- 
lin credit_V2 = variants{} ; -- 
lin suburb_N = variants{} ; -- 
lin newcomer_N = variants{} ; -- 
lin romance_N = mkN "esagerazione fantasiosa" ; -- status=guess
lin film_V2 = mkV2 (mkV (mkV "girare") "un film") | mkV2 (mkV "filmare") ; -- status=guess, src=wikt status=guess, src=wikt
lin film_V = mkV (mkV "girare") "un film" | mkV "filmare" ; -- status=guess, src=wikt status=guess, src=wikt
lin experiment_V2 = variants{} ; -- 
lin experiment_V = variants{} ; -- 
lin daylight_N = mkN "ora legale" ; -- status=guess
lin warrant_N = variants{} ; -- 
lin fur_N = variants{} ; -- 
lin parking_N = mkN "disco orario" ; -- status=guess
lin nuisance_N = variants{} ; -- 
lin civilian_A = mkA "civile" ; -- status=guess
lin foolish_A = mkA "babbeo" ; -- status=guess
lin bulb_N = mkN "bulbo" ; -- status=guess
lin balloon_N = mkN "palloncino" ; -- status=guess
lin vivid_A = variants{} ; -- 
lin surveyor_N = mkN "geometra" masculine ; -- status=guess
lin spontaneous_A = mkA "spontaneo" ; -- status=guess
lin biology_N = mkN "biologia" ; -- status=guess
lin injunction_N = variants{} ; -- 
lin appalling_A = mkA "terribile" ; -- status=guess
lin amusement_N = mkN "intrattenimento" | mkN "festeggiamento" ; -- status=guess status=guess
lin aesthetic_A = variants{} ; -- 
lin vegetation_N = mkN "vegetazione" feminine ; -- status=guess
lin stab_V2 = L.stab_V2 ;
lin stab_V = mkV "pugnalare" | mkV "accoltellare" ; -- status=guess, src=wikt status=guess, src=wikt
lin rude_A = mkA "rude" ; -- status=guess
lin offset_V2 = variants{} ; -- 
lin thinking_N = variants{} ; -- 
lin mainframe_N = variants{} ; -- 
lin flock_N = mkN "stormo" ; -- status=guess
lin amateur_A = variants{} ; -- 
lin academy_N = mkN "accademia" masculine ; -- status=guess
lin shilling_N = variants{} ; -- 
lin reluctance_N = mkN "riluttanza" ; -- status=guess
lin velocity_N = mkN "velocità" feminine ; -- status=guess
lin spare_V2 = variants{} ; -- 
lin spare_V = variants{} ; -- 
lin wartime_N = variants{} ; -- 
lin soak_V2 = mkV2 (mkV "assorbire") ; -- status=guess, src=wikt
lin soak_V = mkV "assorbire" ; -- status=guess, src=wikt
lin rib_N = mkN "nervatura" ; -- status=guess
lin mighty_A = mkA "potente" | mkA "possente" ; -- status=guess status=guess
lin shocked_A = variants{} ; -- 
lin vocational_A = variants{} ; -- 
lin spit_V2 = mkV2 (mkV "sputare") ; -- status=guess, src=wikt
lin spit_V = L.spit_V ;
lin gall_N = mkN "cistifellea" ; -- status=guess
lin bowl_V2 = variants{} ; -- 
lin bowl_V = variants{} ; -- 
lin prescription_N = mkN "ricetta" ; -- status=guess
lin fever_N = mkN "febbre" feminine ; -- status=guess
lin axis_N = mkN "asse" masculine ; -- status=guess
lin reservoir_N = mkN "invaso" ; -- status=guess
lin magnitude_N = mkN "magnitudine" feminine ; -- status=guess
lin rape_V2 = mkV2 (mkV "stuprare") | mkV2 (mkV "violentare") | mkV2 (mkV "violare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cutting_N = mkN "talea" ; -- status=guess
lin bracket_N = mkN "parentesi" feminine ; -- status=guess
lin agony_N = mkN "dolore" masculine | mkN "angoscia" ; -- status=guess status=guess
lin strive_VV = mkVV (mkV "lottare") | mkVV (mkV "battersi") ; -- status=guess, src=wikt status=guess, src=wikt
lin strive_V = mkV "lottare" | mkV "battersi" ; -- status=guess, src=wikt status=guess, src=wikt
lin strangely_Adv = variants{} ; -- 
lin pledge_VS = mkVS (promettere_V) | mkVS (mkV "impegnarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin pledge_V2V = mkV2V (promettere_V) | mkV2V (mkV "impegnarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin pledge_V2 = mkV2 (promettere_V) | mkV2 (mkV "impegnarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin recipient_N = variants{} ; -- 
lin moor_N = mkN "landa" | mkN "brughiera" ; -- status=guess status=guess
lin invade_V2 = mkV2 (mkV "invadere") ; -- status=guess, src=wikt
lin dairy_N = mkN "alimentari" masculine ; -- status=guess
lin chord_N = mkN "accordo" ; -- status=guess
lin shrink_V2 = mkV2 (mkV "restringersi") | mkV2 (mkV "ritirarsi") ; -- status=guess, src=wikt status=guess, src=wikt
lin shrink_V = mkV "restringersi" | mkV "ritirarsi" ; -- status=guess, src=wikt status=guess, src=wikt
lin poison_N = mkN "veleno" ; -- status=guess
lin pillar_N = mkN "pilastro" ; -- status=guess
lin washing_N = mkN "bucato" ; -- status=guess
lin warrior_N = mkN "guerriero" ; -- status=guess
lin supervisor_N = mkN "supervisore" masculine ; -- status=guess
lin outfit_N = variants{} ; -- 
lin innovative_A = mkA "innovativo" ; -- status=guess
lin dressing_N = mkN "vestaglia" ; -- status=guess
lin dispute_V2 = variants{} ; -- 
lin dispute_V = variants{} ; -- 
lin jungle_N = mkN "giungla" ; -- status=guess
lin brewery_N = mkN "birrificio" ; -- status=guess
lin adjective_N = mkN "aggettivo" ; -- status=guess
lin straighten_V2 = variants{} ; -- 
lin straighten_V = variants{} ; -- 
lin restrain_V2 = mkV2 (mkV "trattenersi") | mkV2 (trattenere_V) | mkV2 (mkV "sorvegliare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin monarchy_N = variants{} ; -- 
lin trunk_N = mkN "proboscide" feminine ; -- status=guess
lin herd_N = mkN "mandria" | mkN "branco" ; -- status=guess status=guess
lin deadline_N = mkN "scadenza" ; -- status=guess
lin tiger_N = mkN "tigre" feminine ; -- status=guess
lin supporting_A = variants{} ; -- 
lin moderate_A = variants{} ; -- 
lin kneel_V = mkV "inginocchiarsi" ; -- status=guess, src=wikt
lin ego_N = variants{} ; -- 
lin sexually_Adv = variants{} ; -- 
lin ministerial_A = mkA "ministeriale" ; -- status=guess
lin bitch_N = mkN "stronza" | mkN "troia" ; -- status=guess status=guess
lin wheat_N = mkN "frumento" | mkN "grano" ; -- status=guess status=guess
lin stagger_V = mkV "tentennare" ; -- status=guess, src=wikt
lin snake_N = L.snake_N ;
lin ribbon_N = mkN "nastro" | mkN "fettuccia" ; -- status=guess status=guess
lin mainland_N = mkN "continente" masculine ; -- status=guess
lin fisherman_N = mkN "pescatore" masculine ; -- status=guess
lin economically_Adv = variants{} ; -- 
lin unwilling_A = variants{} ; -- 
lin nationalism_N = mkN "nazionalismo" ; -- status=guess
lin knitting_N = mkN "ferro da maglia" | mkN "ferro da calza" ; -- status=guess status=guess
lin irony_N = mkN "ironia" ; -- status=guess
lin handling_N = variants{} ; -- 
lin desired_A = variants{} ; -- 
lin bomber_N = variants{} ; -- 
lin voltage_N = mkN "voltaggio" | mkN "tensione" feminine ; -- status=guess status=guess
lin unusually_Adv = variants{} ; -- 
lin toast_N = mkN "brindisi" masculine ; -- status=guess
lin feel_N = variants{} ; -- 
lin suffering_N = mkN "sofferenza" ; -- status=guess
lin polish_V2 = mkV2 (mkV "lustrare") | mkV2 (mkV "lucidare") ; -- status=guess, src=wikt status=guess, src=wikt
lin polish_V = mkV "lustrare" | mkV "lucidare" ; -- status=guess, src=wikt status=guess, src=wikt
lin technically_Adv = variants{} ; -- 
lin meaningful_A = variants{} ; -- 
lin aloud_Adv = mkAdv "a voce alta" | mkAdv "ad alta voce" ; -- status=guess status=guess
lin waiter_N = mkN "cameriere" masculine ; -- status=guess
lin tease_V2 = mkV2 (mkV "pettinare") ; -- status=guess, src=wikt
lin opposite_Adv = variants{} ; -- 
lin goat_N = mkN "capra" ; -- status=guess
lin conceptual_A = variants{} ; -- 
lin ant_N = mkN "formica" ; -- status=guess
lin inflict_V2 = mkV2 (mkV "infliggere") ; -- status=guess, src=wikt
lin bowler_N = mkN "bombetta" ; -- status=guess
lin roar_V2 = mkV2 (mkV "ruggito") | mkV2 (mkV "ruggire") ; -- status=guess, src=wikt status=guess, src=wikt
lin roar_V = mkV "ruggito" | mkV "ruggire" ; -- status=guess, src=wikt status=guess, src=wikt
lin drain_N = mkN "scolo" ; -- status=guess
lin wrong_N = variants{} ; -- 
lin galaxy_N = mkN "galassia" ; -- status=guess
lin aluminium_N = mkN "alluminio" ; -- status=guess
lin receptor_N = mkN "recettore" masculine ; -- status=guess
lin preach_V2 = variants{} ; -- 
lin preach_V = variants{} ; -- 
lin parade_N = mkN "parata" ; -- status=guess
lin opposite_N = variants{} ; -- 
lin critique_N = variants{} ; -- 
lin query_N = variants{} ; -- 
lin outset_N = variants{} ; -- 
lin integral_A = variants{} ; -- 
lin grammatical_A = variants{} ; -- 
lin testing_N = variants{} ; -- 
lin patrol_N = mkN "pattuglia" ; -- status=guess
lin pad_N = variants{} ; -- 
lin unreasonable_A = mkA "irragionevole" ; -- status=guess
lin sausage_N = mkN "salame" masculine | mkN "salume" | mkN "insaccato" ; -- status=guess status=guess status=guess
lin criminal_N = mkN "criminale" ; -- status=guess
lin constructive_A = variants{} ; -- 
lin worldwide_A = mkA "mondiale" ; -- status=guess
lin highlight_N = mkN "risalto" | mkN "evidenza" | mkN "sottolineato" ; -- status=guess status=guess status=guess
lin doll_N = mkN "bambola" ; -- status=guess
lin frightened_A = variants{} ; -- 
lin biography_N = mkN "biografia" ; -- status=guess
lin vocabulary_N = mkN "vocabolario" ; -- status=guess
lin offend_V2 = mkV2 (mkV "offendere") ; -- status=guess, src=wikt
lin offend_V = mkV "offendere" ; -- status=guess, src=wikt
lin accumulation_N = mkN "accumulazione" feminine ; -- status=guess
lin linen_N = mkN "lino" ; -- status=guess
lin fairy_N = mkN "fata" ; -- status=guess
lin disco_N = mkN "discoteca" ; -- status=guess
lin hint_VS = variants{} ; -- 
lin hint_V2 = variants{} ; -- 
lin hint_V = variants{} ; -- 
lin versus_Prep = variants{} ; -- 
lin ray_N = mkN "raggio" ; -- status=guess
lin pottery_N = mkN "terraglia" | mkN "ceramica" | mkN "vasellame" masculine | mkN "stoviglia" ; -- status=guess status=guess status=guess status=guess
lin immune_A = variants{} ; -- 
lin retreat_N = variants{} ; -- 
lin master_V2 = mkV2 (mkV "padroneggiare") ; -- status=guess, src=wikt
lin injured_A = variants{} ; -- 
lin holly_N = mkN "agrifoglio" ; -- status=guess
lin battle_V2 = variants{} ; -- 
lin battle_V = variants{} ; -- 
lin solidarity_N = mkN "solidarietà" feminine ; -- status=guess
lin embarrassing_A = mkA "imbarazzante" ; -- status=guess
lin cargo_N = variants{} ; -- 
lin theorist_N = mkN "teorico" ; -- status=guess
lin reluctantly_Adv = variants{} ; -- 
lin preferred_A = variants{} ; -- 
lin dash_V = variants{} ; -- 
lin total_V2 = variants{} ; -- 
lin total_V = variants{} ; -- 
lin reconcile_V2 = variants{} ; -- 
lin drill_N = mkN "esercitazione" feminine ; -- status=guess
lin credibility_N = variants{} ; -- 
lin copyright_N = variants{} ; -- 
lin beard_N = mkN "barba" ; -- status=guess
lin bang_N = mkN "esplosione" feminine ; -- status=guess
lin vigorous_A = mkA "vigoroso" ; -- status=guess
lin vaguely_Adv = variants{} ; -- 
lin punch_V2 = mkV2 (mkV (dare_V) "un pugno") ; -- status=guess, src=wikt
lin prevalence_N = variants{} ; -- 
lin uneasy_A = variants{} ; -- 
lin boost_N = variants{} ; -- 
lin scrap_N = mkN "ferraglia" ; -- status=guess
lin ironically_Adv = variants{} ; -- 
lin fog_N = L.fog_N ;
lin faithful_A = mkA "fedele" ; -- status=guess
lin bounce_V2 = mkV2 (mkV "rimbalzare") ; -- status=guess, src=wikt
lin bounce_V = mkV "rimbalzare" ; -- status=guess, src=wikt
lin batch_N = mkN "infornata" ; -- status=guess
lin smooth_V2 = variants{} ; -- 
lin smooth_V = variants{} ; -- 
lin sleeping_A = variants{} ; -- 
lin poorly_Adv = variants{} ; -- 
lin accord_V = variants{} ; -- 
lin vice_president_N = variants{} ; -- 
lin duly_Adv = variants{} ; -- 
lin blast_N = mkN "esplosione" feminine | mkN "scoppio" ; -- status=guess status=guess
lin square_V2 = variants{} ; -- 
lin square_V = variants{} ; -- 
lin prohibit_V2 = mkV2 (mkV "proibire") ; -- status=guess, src=wikt
lin prohibit_V = mkV "proibire" ; -- status=guess, src=wikt
lin brake_N = mkN "freno" ; -- status=guess
lin asylum_N = mkN "asilo" ; -- status=guess
lin obscure_V2 = variants{} ; -- 
lin nun_N = mkN "suora" | mkN "monaca" ; -- status=guess status=guess
lin heap_N = mkN "pila" | mkN "cumulo" ; -- status=guess status=guess
lin smoothly_Adv = variants{} ; -- 
lin rhetoric_N = variants{} ; -- 
lin privileged_A = variants{} ; -- 
lin liaison_N = variants{} ; -- 
lin jockey_N = variants{} ; -- 
lin concrete_N = mkN "calcestruzzo" | mkN "cemento" ;
lin allied_A = variants{} ; -- 
lin rob_V2 = mkV2 (mkV "derubare") ; -- status=guess, src=wikt
lin indulge_V2 = variants{} ; -- 
lin indulge_V = variants{} ; -- 
lin except_Prep = S.except_Prep ;
lin distort_V2 = mkV2 (mkV "deformare") ; -- status=guess, src=wikt
lin whatsoever_Adv = variants{} ; -- 
lin viable_A = variants{} ; -- 
lin nucleus_N = mkN "nucleo" ; -- status=guess
lin exaggerate_V2 = mkV2 (mkV "esagerare") ; -- status=guess, src=wikt
lin exaggerate_V = mkV "esagerare" ; -- status=guess, src=wikt
lin compact_N = variants{} ; -- 
lin nationality_N = mkN "nazionalità" feminine ; -- status=guess
lin direct_Adv = variants{} ; -- 
lin cast_N = mkN "cast" masculine ; -- status=guess
lin altar_N = mkN "altare" masculine ; -- status=guess
lin refuge_N = mkN "rifugio" ; -- status=guess
lin presently_Adv = variants{} ; -- 
lin mandatory_A = mkA "obbligatorio" | mkA "richiesto" | mkA "necessario" ; -- status=guess status=guess status=guess
lin authorize_V2V = variants{} ; -- 
lin authorize_V2 = variants{} ; -- 
lin accomplish_V2 = mkV2 (compiere_V) | mkV2 (mkV "realizzare") ; -- status=guess, src=wikt status=guess, src=wikt
lin startle_V2 = mkV2 (mkV "schivare") | mkV2 (mkV "evitare") ; -- status=guess, src=wikt status=guess, src=wikt
lin indigenous_A = mkA "indigeno" ; -- status=guess
lin worse_Adv = variants{} ; -- 
lin retailer_N = mkN "rivenditore" ; -- status=guess
lin compound_V2 = mkV2 (aggiungere_V) ; -- status=guess, src=wikt
lin compound_V = aggiungere_V ; -- status=guess, src=wikt
lin admiration_N = mkN "ammirazione" feminine ; -- status=guess
lin absurd_A = mkA "assurdo" ; -- status=guess
lin coincidence_N = mkN "coincidenza" ; -- status=guess
lin principally_Adv = variants{} ; -- 
lin passport_N = mkN "passaporto" ; -- status=guess
lin depot_N = mkN "deposito" ; -- status=guess
lin soften_V2 = mkV2 (mkV "ammorbidire") ; -- status=guess, src=wikt
lin soften_V = mkV "ammorbidire" ; -- status=guess, src=wikt
lin secretion_N = variants{} ; -- 
lin invoke_V2 = variants{} ; -- 
lin dirt_N = mkN "terra" masculine ; -- status=guess
lin scared_A = variants{} ; -- 
lin mug_N = mkN "boccale" | mkN "gotto" ; -- status=guess status=guess
lin convenience_N = variants{} ; -- 
lin calm_N = mkN "la quiete prima della tempesta" ; -- status=guess
lin optional_A = mkA "facoltativo" | mkA "volontario" | mkA "opzionale" ;
lin unsuccessful_A = variants{} ; -- 
lin consistency_N = variants{} ; -- 
lin umbrella_N = mkN "ombrello" | mkN "parapioggia" ; -- status=guess status=guess
lin solo_N = mkN "solitario" ; -- status=guess
lin hemisphere_N = mkN "emisfero" ; -- status=guess
lin extreme_N = mkN "estremo" ; -- status=guess
lin brandy_N = variants{} ; -- 
lin belly_N = L.belly_N ;
lin attachment_N = mkN "allegato" ; -- status=guess
lin wash_N = variants{} ; -- 
lin uncover_V2 = variants{} ; -- 
lin treat_N = variants{} ; -- 
lin repeated_A = variants{} ; -- 
lin pine_N = mkN "pigna" | mkN "pina" ; -- status=guess status=guess
lin offspring_N = mkN "discendenti" masculine ; -- status=guess
lin communism_N = mkN "comunismo" ; -- status=guess
lin nominate_V2 = variants{} ; -- 
lin soar_V2 = variants{} ; -- 
lin soar_V = variants{} ; -- 
lin geological_A = variants{} ; -- 
lin frog_N = mkN "rana" ; -- status=guess
lin donate_V2 = mkV2 (mkV "donare") ; -- status=guess, src=wikt
lin donate_V = mkV "donare" ; -- status=guess, src=wikt
lin cooperative_A = mkA "cooperativo" ; -- status=guess
lin nicely_Adv = variants{} ; -- 
lin innocence_N = mkN "innocenza" ; -- status=guess
lin housewife_N = mkN "massaia" | mkN "donna di casa" | mkN "padrona di casa" | mkN "casalinga" ; -- status=guess status=guess status=guess status=guess
lin disguise_V2 = variants{} ; -- 
lin demolish_V2 = mkV2 (mkV "demolire") ; -- status=guess, src=wikt
lin counsel_N = variants{} ; -- 
lin cord_N = variants{} ; -- 
lin semi_final_N = variants{} ; -- 
lin reasoning_N = mkN "ragionamento" ; -- status=guess
lin litre_N = mkN "litro" ; -- status=guess
lin inclined_A = variants{} ; -- 
lin evoke_V2 = mkV2 (mkV "evocare") | mkV2 (mkV "rammemorare") | mkV2 (mkV "rammentare") | mkV2 (mkV "rammemorare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin courtyard_N = mkN "cortile" masculine | mkN "corte" feminine ; -- status=guess status=guess
lin arena_N = mkN "arena" ; -- status=guess
lin simplicity_N = mkN "semplicità" ; -- status=guess
lin inhibition_N = variants{} ; -- 
lin frozen_A = variants{} ; -- 
lin vacuum_N = mkN "vuoto" ; -- status=guess
lin immigrant_N = mkN "immigrante" masculine ; -- status=guess
lin bet_N = mkN "scommessa" ; -- status=guess
lin revenge_N = mkN "vendetta" | mkN "rivincita" | mkN "rivalsa" | mkN "ritorsione" feminine ; -- status=guess status=guess status=guess status=guess
lin jail_V2 = variants{} ; -- 
lin helmet_N = mkN "casco" ; -- status=guess
lin unclear_A = variants{} ; -- 
lin jerk_V2 = mkV2 (mkV (mkV "farsi") "una sega") ; -- status=guess, src=wikt
lin jerk_V = mkV (mkV "farsi") "una sega" ; -- status=guess, src=wikt
lin disruption_N = mkN "scompiglio" | mkN "sconvolgimento" ; -- status=guess status=guess
lin attainment_N = variants{} ; -- 
lin sip_V2 = mkV2 (mkV "sorbire") ; -- status=guess, src=wikt
lin sip_V = mkV "sorbire" ; -- status=guess, src=wikt
lin program_V2V = variants{} ; -- 
lin program_V2 = variants{} ; -- 
lin lunchtime_N = variants{} ; -- 
lin cult_N = mkN "culto" ; -- status=guess
lin chat_N = mkN "chiacchiera" ; -- status=guess
lin accord_N = mkN "accordo" ; -- status=guess
lin supposedly_Adv = variants{} ; -- 
lin offering_N = variants{} ; -- 
lin broadcast_N = mkN "trasmissione" ; -- status=guess
lin secular_A = mkA "secolare" ; -- status=guess
lin overwhelm_V2 = mkV2 (sommergere_V) | mkV2 (mkV "seppellire") | mkV2 (mkV "sgominare") | mkV2 (travolgere_V) | mkV2 (sopraffare_V) | mkV2 (confondere_V) | mkV2 (mkV "imbarazzare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin momentum_N = mkN "quantità di moto" | mkN "impulso" | mkN "momento" feminine ; -- status=guess status=guess status=guess
lin infinite_A = variants{} ; -- 
lin manipulation_N = variants{} ; -- 
lin inquest_N = variants{} ; -- 
lin decrease_N = mkN "diminuzione di" | mkN "calo di" | mkN "ribasso di" | mkN "riduzione di" ; -- status=guess status=guess status=guess status=guess
lin cellar_N = variants{} ; -- 
lin counsellor_N = variants{} ; -- 
lin avenue_N = mkN "viale" | mkN "corso" ; -- status=guess status=guess
lin rubber_A = variants{} ; -- 
lin labourer_N = variants{} ; -- 
lin lab_N = variants{} ; -- 
lin damn_V2 = mkV2 (mkV "dannare") ; -- status=guess, src=wikt
lin comfortably_Adv = variants{} ; -- 
lin tense_A = variants{} ; -- 
lin socket_N = mkN "presa" ; -- status=guess
lin par_N = variants{} ; -- 
lin thrust_N = mkN "stoccata" ; -- status=guess
lin scenario_N = mkN "copione" masculine ; -- status=guess
lin frankly_Adv = variants{} ; -- 
lin slap_V2 = mkV2 (mkV "sbattere") ; -- status=guess, src=wikt
lin recreation_N = mkN "ricreazione" feminine ; -- status=guess
lin rank_V2 = variants{} ; -- 
lin rank_V = variants{} ; -- 
lin spy_N = mkN "spia" ; -- status=guess
lin filter_V2 = mkV2 (mkV "filtrare") ; -- status=guess, src=wikt
lin filter_V = mkV "filtrare" ; -- status=guess, src=wikt
lin clearance_N = variants{} ; -- 
lin blessing_N = mkN "benedizione" feminine ; -- status=guess
lin embryo_N = mkN "embrione" masculine ; -- status=guess
lin varied_A = variants{} ; -- 
lin predictable_A = variants{} ; -- 
lin mutation_N = variants{} ; -- 
lin equal_V2 = mkV2 (mkV "eguagliare") ; -- status=guess, src=wikt
lin can_1_VV = S.can_VV ;
lin can_2_VV = S.can8know_VV ;
lin can_V2 = mkV2 (potere_V) ; -- status=guess, src=wikt
lin burst_N = mkN "scoppio" | mkN "esplosione" feminine ; -- status=guess status=guess
lin retrieve_V2 = mkV2 (mkV "recuperare") ; -- status=guess, src=wikt
lin retrieve_V = mkV "recuperare" ; -- status=guess, src=wikt
lin elder_N = mkN "sambuco" ; -- status=guess
lin rehearsal_N = mkN "prova" ; -- status=guess
lin optical_A = variants{} ; -- 
lin hurry_N = mkN "precipitazione" feminine ; -- status=guess
lin conflict_V = variants{} ; -- 
lin combat_V2 = variants{} ; -- 
lin combat_V = variants{} ; -- 
lin absorption_N = mkN "assorbimento" ; -- status=guess
lin ion_N = mkN "ione" masculine ; -- status=guess
lin wrong_Adv = variants{} ; -- 
lin heroin_N = mkN "eroina" ; -- status=guess
lin bake_V2 = mkV2 (mkV "cuocersi") | mkV2 (mkV "infornare") ; -- status=guess, src=wikt status=guess, src=wikt
lin bake_V = mkV "cuocersi" | mkV "infornare" ; -- status=guess, src=wikt status=guess, src=wikt
lin x_ray_N = variants{} ; -- 
lin vector_N = mkN "vettore" masculine ; -- status=guess
lin stolen_A = variants{} ; -- 
lin sacrifice_V2 = mkV2 (mkV "sacrificare") ; -- status=guess, src=wikt
lin sacrifice_V = mkV "sacrificare" ; -- status=guess, src=wikt
lin robbery_N = mkN "furto" | mkN "ruberia" ; -- status=guess status=guess
lin probe_V2 = mkV2 (mkV "investigare") ; -- status=guess, src=wikt
lin probe_V = mkV "investigare" ; -- status=guess, src=wikt
lin organizational_A = variants{} ; -- 
lin chalk_N = mkN "gessetto" ; -- status=guess
lin bourgeois_A = variants{} ; -- 
lin villager_N = variants{} ; -- 
lin morale_N = mkN "morale" masculine ; -- status=guess
lin express_A = variants{} ; -- 
lin climb_N = variants{} ; -- 
lin notify_V2 = mkV2 (mkV "notificare") ; -- status=guess, src=wikt
lin jam_N = mkN "ingorgo" ; -- status=guess
lin bureaucratic_A = variants{} ; -- 
lin literacy_N = mkN "alfabetismo" | mkN "alfabetizzazione" feminine ; -- status=guess status=guess
lin frustrate_V2 = variants{} ; -- 
lin freight_N = variants{} ; -- 
lin clearing_N = mkN "radura" ; -- status=guess
lin aviation_N = mkN "aviazione" feminine ; -- status=guess
lin legislature_N = variants{} ; -- 
lin curiously_Adv = variants{} ; -- 
lin banana_N = mkN "bananiera" ; -- status=guess
lin deploy_V2 = mkV2 (mkV "dispiegare") | mkV2 (mkV "collocare") ; -- status=guess, src=wikt status=guess, src=wikt
lin deploy_V = mkV "dispiegare" | mkV "collocare" ; -- status=guess, src=wikt status=guess, src=wikt
lin passionate_A = mkA "appassionato" ; -- status=guess
lin monastery_N = mkN "monastero" ; -- status=guess
lin kettle_N = mkN "bollitore" masculine ; -- status=guess
lin enjoyable_A = variants{} ; -- 
lin diagnose_V2 = mkV2 (mkV "diagnosticare") ; -- status=guess, src=wikt
lin quantitative_A = mkA "quantitativo" ; -- status=guess
lin distortion_N = variants{} ; -- 
lin monarch_N = mkN "monarca" ; -- status=guess
lin kindly_Adv = variants{} ; -- 
lin glow_V = mkV "brillare" ; -- status=guess, src=wikt
lin acquaintance_N = mkN "conoscenza" masculine ; -- status=guess
lin unexpectedly_Adv = variants{} ; -- 
lin handy_A = mkA "utile" | mkA "pratico" ; -- status=guess status=guess
lin deprivation_N = mkN "privazione" feminine ; -- status=guess
lin attacker_N = variants{} ; -- 
lin assault_V2 = mkV2 (mkV "attaccare") | mkV2 (mkV "aggredire") | mkV2 (assalire_V) | mkV2 (mkV "molestare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin screening_N = variants{} ; -- 
lin retired_A = variants{} ; -- 
lin quick_Adv = variants{} ; -- 
lin portable_A = mkA "portatile" ; -- status=guess
lin hostage_N = mkN "ostaggio" ; -- status=guess
lin underneath_Prep = variants{} ; -- 
lin jealous_A = mkA "geloso" | mkA "gelosa" ; -- status=guess status=guess
lin proportional_A = mkA "proporzionale" ; -- status=guess
lin gown_N = mkN "toga" ; -- status=guess
lin chimney_N = mkN "fumaiolo" ; -- status=guess
lin bleak_A = mkA "desolato" ; -- status=guess
lin seasonal_A = variants{} ; -- 
lin plasma_N = mkN "plasma" masculine ; -- status=guess
lin stunning_A = variants{} ; -- 
lin spray_N = variants{} ; -- 
lin referral_N = variants{} ; -- 
lin promptly_Adv = variants{} ; -- 
lin fluctuation_N = variants{} ; -- 
lin decorative_A = mkA "decorativo" ; -- status=guess
lin unrest_N = variants{} ; -- 
lin resent_VS = variants{} ; -- 
lin resent_V2 = variants{} ; -- 
lin plaster_N = mkN "ingessatura" ; -- status=guess
lin chew_V2 = mkV2 (mkV "masticare") ; -- status=guess, src=wikt
lin chew_V = mkV "masticare" ; -- status=guess, src=wikt
lin grouping_N = variants{} ; -- 
lin gospel_N = mkN "vangelo" ; -- status=guess
lin distributor_N = variants{} ; -- 
lin differentiation_N = mkN "differenziazione" feminine ; -- status=guess
lin blonde_A = variants{} ; -- 
lin aquarium_N = mkN "acquario" ; -- status=guess
lin witch_N = mkN "strega" | mkN "fattucchiera" ; -- status=guess status=guess
lin renewed_A = variants{} ; -- 
lin jar_N = mkN "teglia" | mkN "vaso" | mkN "giara" ; -- status=guess status=guess status=guess
lin approved_A = variants{} ; -- 
lin advocate_N = variants{} ; -- 
lin worrying_A = variants{} ; -- 
lin minimize_V2 = mkV2 (mkV "minimizzare") ; -- status=guess, src=wikt
lin footstep_N = mkN "pedata" ; -- status=guess
lin delete_V2 = mkV2 (mkV "cancellare") | mkV2 (mkV "eliminare") ; -- status=guess, src=wikt status=guess, src=wikt
lin underneath_Adv = variants{} ; -- 
lin lone_A = mkA "solo" ; -- status=guess
lin level_V2 = mkV2 (mkV "livellare") ; -- status=guess, src=wikt
lin level_V = mkV "livellare" ; -- status=guess, src=wikt
lin exceptionally_Adv = variants{} ; -- 
lin drift_N = variants{} ; -- 
lin spider_N = mkN "ragno" ; -- status=guess
lin hectare_N = variants{} ; -- 
lin colonel_N = mkN "colonnello" ; -- status=guess
lin swimming_N = mkN "nuoto" ; -- status=guess
lin realism_N = mkN "realismo" ; -- status=guess
lin insider_N = variants{} ; -- 
lin hobby_N = mkN "falco" | mkN "falcone" masculine ; -- status=guess status=guess
lin computing_N = variants{} ; -- 
lin infrastructure_N = mkN "infrastruttura" ; -- status=guess
lin cooperate_V = mkV "cooperare" ; -- status=guess, src=wikt
lin burn_N = mkN "bruciatura" | mkN "ustione" feminine ; -- status=guess status=guess
lin cereal_N = variants{} ; -- 
lin fold_N = variants{} ; -- 
lin compromise_V2 = variants{} ; -- 
lin compromise_V = variants{} ; -- 
lin boxing_N = mkN "boxe" | mkN "pugilato" ; -- status=guess status=guess
lin rear_V2 = variants{} ; -- 
lin rear_V = variants{} ; -- 
lin lick_V2 = mkV2 (mkV "leccare") ; -- status=guess, src=wikt
lin constrain_V2 = mkV2 (costringere_V) ; -- status=guess, src=wikt
lin clerical_A = variants{} ; -- 
lin hire_N = variants{} ; -- 
lin contend_VS = variants{} ; -- 
lin contend_V = variants{} ; -- 
lin amateur_N = variants{} ; -- 
lin instrumental_A = variants{} ; -- 
lin terminal_A = variants{} ; -- 
lin electorate_N = mkN "elettorato" ; -- status=guess
lin congratulate_V2 = variants{} ; -- 
lin balanced_A = variants{} ; -- 
lin manufacturing_N = variants{} ; -- 
lin split_N = mkN "la spaccata" ;
lin domination_N = mkN "dominazione" feminine ; -- status=guess
lin blink_V2 = mkV2 (mkV (mkV "sbattere") "le ciglia") ; -- status=guess, src=wikt
lin blink_V = mkV (mkV "sbattere") "le ciglia" ; -- status=guess, src=wikt
lin bleed_VS = mkVS (mkV "sanguinare") ; -- status=guess, src=wikt
lin bleed_V2 = mkV2 (mkV "sanguinare") ; -- status=guess, src=wikt
lin bleed_V = mkV "sanguinare" ; -- status=guess, src=wikt
lin unlawful_A = variants{} ; -- 
lin precedent_N = mkN "precedente" masculine ; -- status=guess
lin notorious_A = mkA "famigerato" ; -- status=guess
lin indoor_A = mkA "al chiuso" ; -- status=guess
lin upgrade_V2 = variants{} ; -- 
lin trench_N = mkN "[general] fosso" | mkN "[military] trincea" ; -- status=guess status=guess
lin therapist_N = mkN "terapista" masculine ; -- status=guess
lin illuminate_V2 = mkV2 (mkV "illuminare") | mkV2 (mkV "chiarire") ; -- status=guess, src=wikt status=guess, src=wikt
lin bargain_V2 = variants{} ; -- 
lin bargain_V = variants{} ; -- 
lin warranty_N = mkN "garanzia" ; -- status=guess
lin scar_V2 = variants{} ; -- 
lin scar_V = variants{} ; -- 
lin consortium_N = variants{} ; -- 
lin anger_V2 = variants{} ; -- 
lin insure_VS = variants{} ; -- 
lin insure_V2 = variants{} ; -- 
lin insure_V = variants{} ; -- 
lin extensively_Adv = variants{} ; -- 
lin appropriately_Adv = variants{} ; -- 
lin spoon_N = mkN "cucchiaio" ; -- status=guess
lin sideways_Adv = variants{} ; -- 
lin enhanced_A = variants{} ; -- 
lin disrupt_V2 = mkV2 (interrompere_V) | mkV2 (mkV "impedire") ; -- status=guess, src=wikt status=guess, src=wikt
lin disrupt_V = interrompere_V | mkV "impedire" ; -- status=guess, src=wikt status=guess, src=wikt
lin satisfied_A = mkA "soddisfatto" | mkA "contento" ; -- status=guess status=guess
lin precaution_N = mkN "precauzione" feminine ; -- status=guess
lin kite_N = mkN "nibbio" ; -- status=guess
lin instant_N = mkN "istante" masculine | mkN "attimo" ; -- status=guess status=guess
lin gig_N = mkN "arpione" masculine ; -- status=guess
lin continuously_Adv = variants{} ; -- 
lin consolidate_V2 = variants{} ; -- 
lin consolidate_V = variants{} ; -- 
lin fountain_N = mkN "fontana" ; -- status=guess
lin graduate_V2 = mkV2 (mkV "laurearsi") ; -- status=guess, src=wikt
lin graduate_V = mkV "laurearsi" ; -- status=guess, src=wikt
lin gloom_N = variants{} ; -- 
lin bite_N = mkN "morso" ; -- status=guess
lin structure_V2 = variants{} ; -- 
lin noun_N = mkN "sostantivo" | mkN "nome" masculine ; -- status=guess status=guess
lin nomination_N = variants{} ; -- 
lin armchair_N = mkN "poltrona" ; -- status=guess
lin virtual_A = mkA "virtuale" ; -- status=guess
lin unprecedented_A = variants{} ; -- 
lin tumble_V2 = mkV2 (cadere_V) | mkV2 (mkV "precipitare") | mkV2 (mkV "rovinare") | mkV2 (mkV "crollare") | mkV2 (mkV "ruzzolare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin tumble_V = cadere_V | mkV "precipitare" | mkV "rovinare" | mkV "crollare" | mkV "ruzzolare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin ski_N = mkN "sci" masculine ; -- status=guess
lin architectural_A = variants{} ; -- 
lin violation_N = mkN "violazione" feminine ; -- status=guess
lin rocket_N = mkN "razzo" ; -- status=guess
lin inject_V2 = variants{} ; -- 
lin departmental_A = mkA "ministeriale" | mkA "dipartimentale" | mkA "ripartimentale" ; -- status=guess status=guess status=guess
lin row_V2 = mkV2 (mkV "remare") ; -- status=guess, src=wikt
lin row_V = mkV "remare" ; -- status=guess, src=wikt
lin luxury_A = variants{} ; -- 
lin fax_N = variants{} ; -- 
lin deer_N = mkN "cervo" | mkN "alce" | mkN "renna" | mkN "daino" | mkN "capriolo" ; -- status=guess status=guess status=guess status=guess status=guess
lin climber_N = mkN "arrampicatore" | mkN "scalatore" ; -- status=guess status=guess
lin photographic_A = variants{} ; -- 
lin haunt_V2 = mkV2 (mkV "tormentare") ; -- status=guess, src=wikt
lin fiercely_Adv = variants{} ; -- 
lin dining_N = mkN "vagone ristorante" | mkN "carrozza ristorante" ; -- status=guess status=guess
lin sodium_N = mkN "sodio" ; -- status=guess
lin gossip_N = mkN "pettegolezzo" | mkN "chiacchera" | mkN "diceria" ; -- status=guess status=guess status=guess
lin bundle_N = mkN "insieme" masculine ; -- status=guess
lin bend_N = variants{} ; -- 
lin recruit_N = mkN "recluta" ; -- status=guess
lin hen_N = mkN "gallina |" ; -- status=guess
lin fragile_A = mkA "fragile" ; -- status=guess
lin deteriorate_V2 = mkV2 (mkV "deteriorarsi") ; -- status=guess, src=wikt
lin deteriorate_V = mkV "deteriorarsi" ; -- status=guess, src=wikt
lin dependency_N = variants{} ; -- 
lin swift_A = mkA "rapido" | mkA "veloce" | mkA "pronto" | mkA "agile" | mkA "svelto" | mkA "celere" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin scramble_V2 = variants{} ; -- 
lin scramble_V = variants{} ; -- 
lin overview_N = mkN "visione d'insieme" ; -- status=guess
lin imprison_V2 = mkV2 (mkV "imprigionare") | mkV2 (mkV "incarcerare") ; -- status=guess, src=wikt status=guess, src=wikt
lin trolley_N = mkN "carrello" ; -- status=guess
lin rotation_N = variants{} ; -- 
lin denial_N = mkN "negazione" feminine ; -- status=guess
lin boiler_N = mkN "caldaia" masculine ; -- status=guess
lin amp_N = variants{} ; -- 
lin trivial_A = mkA "banale" | mkA "ordinario" ; -- status=guess status=guess
lin shout_N = mkN "grido" ; -- status=guess
lin overtake_V2 = mkV2 (mkV "superare") ; -- status=guess, src=wikt
lin make_N = mkN "marca" ; -- status=guess
lin hunter_N = mkN "cane da caccia" ; -- status=guess
lin guess_N = mkN "congettura" ; -- status=guess
lin doubtless_Adv = variants{} ; -- 
lin syllable_N = mkN "sillaba" ; -- status=guess
lin obscure_A = mkA "oscuro" ; -- status=guess
lin mould_N = variants{} ; -- 
lin limestone_N = mkN "calcare" masculine ; -- status=guess
lin leak_V2 = mkV2 (perdere_V) ; -- status=guess, src=wikt
lin leak_V = perdere_V ; -- status=guess, src=wikt
lin beneficiary_N = variants{} ; -- 
lin veteran_N = mkN "veterano" ; -- status=guess
lin surplus_A = variants{} ; -- 
lin manifestation_N = mkN "manifestazione" feminine ; -- status=guess
lin vicar_N = mkN "[CofE] pastore" | mkN "[RC] vicario" ; -- status=guess status=guess
lin textbook_N = mkN "libro di testo" ; -- status=guess
lin novelist_N = mkN "romanziere" masculine ; -- status=guess
lin halfway_Adv = variants{} ; -- 
lin contractual_A = variants{} ; -- 
lin swap_V2 = mkV2 (mkV "scambiare") ; -- status=guess, src=wikt
lin swap_V = mkV "scambiare" ; -- status=guess, src=wikt
lin guild_N = mkN "gilda" ; -- status=guess
lin ulcer_N = variants{} ; -- 
lin slab_N = mkN "piastra" | mkN "lastra" | mkN "fetta" | mkN "soletta" ; -- status=guess status=guess status=guess status=guess
lin detector_N = variants{} ; -- 
lin detection_N = variants{} ; -- 
lin cough_V = mkV "tossire" ; -- status=guess, src=wikt
lin whichever_Quant = variants{} ; -- 
lin spelling_N = mkN "ortografia" ; -- status=guess
lin lender_N = variants{} ; -- 
lin glow_N = mkN "calore" masculine | mkN "ardore" | mkN "splendore" masculine ; -- status=guess status=guess status=guess
lin raised_A = variants{} ; -- 
lin prolonged_A = variants{} ; -- 
lin voucher_N = variants{} ; -- 
lin t_shirt_N = variants{} ; -- 
lin linger_V = variants{} ; -- 
lin humble_A = mkA "umile" | mkA "modesto" | mkA "terra terra" ; -- status=guess status=guess status=guess
lin honey_N = mkN "tasso del miele" ; -- status=guess
lin scream_N = mkN "urlo" | mkN "grido" ; -- status=guess status=guess
lin postcard_N = mkN "cartolina" ; -- status=guess
lin managing_A = variants{} ; -- 
lin alien_A = variants{} ; -- 
lin trouble_V2 = mkV2 (mkV "esagitare") | mkV2 (mkV "infastidire") ; -- status=guess, src=wikt status=guess, src=wikt
lin reverse_N = mkN "retromarcia" ; -- status=guess
lin odour_N = mkN "odore" masculine ; -- status=guess
lin fundamentally_Adv = variants{} ; -- 
lin discount_V2 = variants{} ; -- 
lin discount_V = variants{} ; -- 
lin blast_V2 = mkV2 (esplodere_V) ; ----
lin blast_V = esplodere_V ;
lin syntactic_A = variants{} ; -- 
lin scrape_V2 = mkV2 (mkV "grattare") | mkV2 (mkV "raschiare") ; -- status=guess, src=wikt status=guess, src=wikt
lin scrape_V = mkV "grattare" | mkV "raschiare" ; -- status=guess, src=wikt status=guess, src=wikt
lin residue_N = variants{} ; -- 
lin procession_N = mkN "corteo" ; -- status=guess
lin pioneer_N = mkN "pionere" ; -- status=guess
lin intercourse_N = mkN "rapporto sessuale" ; -- status=guess
lin deter_V2 = mkV2 (mkV "scoraggiare") ; -- status=guess, src=wikt
lin deadly_A = variants{} ; -- 
lin complement_V2 = variants{} ; -- 
lin restrictive_A = mkA "restrittivo" ; -- status=guess
lin nitrogen_N = mkN "azoto" ; -- status=guess
lin citizenship_N = mkN "cittadinanza" ; -- status=guess
lin pedestrian_N = mkN "pedone" masculine ; -- status=guess
lin detention_N = variants{} ; -- 
lin wagon_N = mkN "carro" ; -- status=guess
lin microphone_N = mkN "microfono" ; -- status=guess
lin hastily_Adv = variants{} ; -- 
lin fixture_N = variants{} ; -- 
lin choke_V2 = mkV2 (mkV "soffocare") ; -- status=guess, src=wikt
lin choke_V = mkV "soffocare" ; -- status=guess, src=wikt
lin wet_V2 = mkV2 (mkV "bagnare") ; -- status=guess, src=wikt
lin weed_N = mkN "maria" ; -- status=guess
lin programming_N = mkN "programmazione" feminine ; -- status=guess
lin power_V2 = variants{} ; -- 
lin nationally_Adv = variants{} ; -- 
lin dozen_N = mkN "centinaia" | mkN "migliaia" ; -- status=guess status=guess
lin carrot_N = mkN "carota" ; -- status=guess
lin bulletin_N = mkN "bacheca" ; -- status=guess
lin wording_N = mkN "dicitura" ; -- status=guess
lin vicious_A = variants{} ; -- 
lin urgency_N = mkN "urgenza" | mkN "urgenze" feminine ; -- status=guess status=guess
lin spoken_A = variants{} ; -- 
lin skeleton_N = mkN "scheletro" ; -- status=guess
lin motorist_N = variants{} ; -- 
lin interactive_A = variants{} ; -- 
lin compute_V2 = mkV2 (mkV "computare") | mkV2 (mkV "elaborare") ; -- status=guess, src=wikt status=guess, src=wikt
lin compute_V = mkV "computare" | mkV "elaborare" ; -- status=guess, src=wikt status=guess, src=wikt
lin whip_N = mkN "frusta" masculine | mkN "nerbo" ; -- status=guess status=guess
lin urgently_Adv = variants{} ; -- 
lin telly_N = variants{} ; -- 
lin shrub_N = mkN "arbusto" ; -- status=guess
lin porter_N = variants{} ; -- 
lin ethics_N = mkN "etica" ; -- status=guess
lin banner_N = mkN "vessillo" ; -- status=guess
lin velvet_N = mkN "velluto" ; -- status=guess
lin omission_N = mkN "omissione" feminine ; -- status=guess
lin hook_V2 = mkV2 (mkV "agganciare") ; -- status=guess, src=wikt
lin hook_V = mkV "agganciare" ; -- status=guess, src=wikt
lin gallon_N = variants{} ; -- 
lin financially_Adv = variants{} ; -- 
lin superintendent_N = mkN "soprintendente" masculine | mkN "sovrintendente" masculine ; -- status=guess status=guess
lin plug_V2 = mkV2 (mkV (mkV "attaccare") "alla presa") ; -- status=guess, src=wikt
lin plug_V = mkV (mkV "attaccare") "alla presa" ; -- status=guess, src=wikt
lin continuation_N = mkN "continuazione" feminine ; -- status=guess
lin reliance_N = variants{} ; -- 
lin justified_A = variants{} ; -- 
lin fool_V2 = mkV2 (mkV "ingannare") | mkV2 (mkV (mkV "farsi") "beffe di s.o.") | mkV2 (mkV (I.fare_V) "lo sciocco") | mkV2 (mkV "scherzare") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin detain_V2 = mkV2 (detenere_V) | mkV2 (trattenere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin damaging_A = variants{} ; -- 
lin orbit_N = mkN "orbita" ; -- status=guess
lin mains_N = variants{} ; -- 
lin discard_V2 = variants{} ; -- 
lin dine_V = mkV "cenare" ; -- status=guess, src=wikt
lin compartment_N = variants{} ; -- 
lin revised_A = variants{} ; -- 
lin privatization_N = mkN "privatizzazione" feminine ; -- status=guess
lin memorable_A = variants{} ; -- 
lin lately_Adv = variants{} ; -- 
lin distributed_A = variants{} ; -- 
lin disperse_V2 = mkV2 (mkV "disseminarere") ; -- status=guess, src=wikt
lin disperse_V = mkV "disseminarere" ; -- status=guess, src=wikt
lin blame_N = mkN "colpa" masculine ; -- status=guess
lin basement_N = mkN "scantinato" ; -- status=guess
lin slump_V2 = mkV2 (mkV "crollare") ; -- status=guess, src=wikt
lin slump_V = mkV "crollare" ; -- status=guess, src=wikt
lin puzzle_V2 = mkV2 (mkV (mkV "rendere") "perplesso") ; -- status=guess, src=wikt
lin monitoring_N = mkN "monitoraggio" ; -- status=guess
lin talented_A = mkA "dotato" | mkA "talentuoso" ; -- status=guess status=guess
lin nominal_A = variants{} ; -- 
lin mushroom_N = mkN "fungo" ; -- status=guess
lin instructor_N = variants{} ; -- 
lin fork_N = variants{} ; -- 
lin fork_4_N = variants{} ; -- 
lin fork_3_N = variants{} ; -- 
lin fork_1_N = variants{} ; -- 
lin board_V2 = variants{} ; -- 
lin want_N = mkN "mancolista" ; -- status=guess
lin disposition_N = variants{} ; -- 
lin cemetery_N = variants{} ; -- 
lin attempted_A = variants{} ; -- 
lin nephew_N = mkN "nipote" feminine ; -- status=guess
lin magical_A = variants{} ; -- 
lin ivory_N = mkN "avorio" ; -- status=guess
lin hospitality_N = mkN "ospitalità" feminine ; -- status=guess
lin besides_Prep = variants{} ; -- 
lin astonishing_A = variants{} ; -- 
lin tract_N = variants{} ; -- 
lin proprietor_N = mkN "proprietario" ; -- status=guess
lin license_V2 = variants{} ; -- 
lin differential_A = variants{} ; -- 
lin affinity_N = variants{} ; -- 
lin talking_N = variants{} ; -- 
lin royalty_N = variants{} ; -- 
lin neglect_N = mkN "negligenza" ; -- status=guess
lin irrespective_A = variants{} ; -- 
lin whip_V2 = mkV2 (mkV "sferzare") ; -- status=guess, src=wikt
lin whip_V = mkV "sferzare" ; -- status=guess, src=wikt
lin sticky_A = variants{} ; -- 
lin regret_N = mkN "rammarico" | mkN "rimpianto" ; -- status=guess status=guess
lin incapable_A = variants{} ; -- 
lin franchise_N = variants{} ; -- 
lin dentist_N = mkN "dentista" ; -- status=guess
lin contrary_N = variants{} ; -- 
lin profitability_N = variants{} ; -- 
lin enthusiast_N = variants{} ; -- 
lin crop_V2 = variants{} ; -- 
lin crop_V = variants{} ; -- 
lin utter_V2 = mkV2 (emettere_V) ; -- status=guess, src=wikt
lin pile_V2 = variants{} ; -- 
lin pile_V = variants{} ; -- 
lin pier_N = mkN "pontile" masculine | mkN "imbarcadero" | mkN "molo" ; -- status=guess status=guess status=guess
lin dome_N = mkN "cupola" ;
lin bubble_N = mkN "bagnoschiuma" ; -- status=guess
lin treasurer_N = mkN "tesoriere" masculine ; -- status=guess
lin stocking_N = mkN "calza" ; -- status=guess
lin sanctuary_N = mkN "santuario" ; -- status=guess
lin ascertain_V2 = mkV2 (mkV "accertare") ; -- status=guess, src=wikt
lin arc_N = mkN "arco" ; -- status=guess
lin quest_N = variants{} ; -- 
lin mole_N = mkN "talpa" ; -- status=guess
lin marathon_N = mkN "maratona" ; -- status=guess
lin feast_N = mkN "festa" | mkN "banchetto" ; -- status=guess status=guess
lin crouch_V = mkV "accovacciarsi" ; -- status=guess, src=wikt
lin storm_V2 = variants{} ; -- 
lin storm_V = variants{} ; -- 
lin hardship_N = mkN "avversità" feminine | mkN "difficoltà" feminine ; -- status=guess status=guess
lin entitlement_N = variants{} ; -- 
lin circular_N = mkN "sega circolare" ; -- status=guess
lin walking_A = variants{} ; -- 
lin strap_N = mkN "striscia" | mkN "listella" ; -- status=guess status=guess
lin sore_A = mkA "doloroso" | mkA "dolorante" | mkA "infiammato" | mkA "...fa male" ; -- status=guess status=guess status=guess status=guess
lin complementary_A = variants{} ; -- 
lin understandable_A = mkA "perdonabile" | mkA "comprensibile" ; -- status=guess status=guess
lin noticeable_A = variants{} ; -- 
lin mankind_N = mkN "umanità" feminine ; -- status=guess
lin majesty_N = mkN "maestà" ; -- status=guess
lin pigeon_N = mkN "piccione" masculine | mkN "picciona" | mkN "colombo" | mkN "colomba" ; -- status=guess status=guess status=guess status=guess
lin goalkeeper_N = mkN "portiere" masculine ; -- status=guess
lin ambiguous_A = mkA "ambiguo" ; -- status=guess
lin walker_N = variants{} ; -- 
lin virgin_N = mkN "vergine" masculine | mkN "vergine" masculine ; -- status=guess status=guess
lin prestige_N = variants{} ; -- 
lin preoccupation_N = variants{} ; -- 
lin upset_A = variants{} ; -- 
lin municipal_A = mkA "civico" | mkA "comunale" ; -- status=guess status=guess
lin groan_V2 = mkV2 (mkV "gemere") ; -- status=guess, src=wikt
lin groan_V = mkV "gemere" ; -- status=guess, src=wikt
lin craftsman_N = mkN "artéfice" ; -- status=guess
lin anticipation_N = mkN "anticipazione" feminine ; -- status=guess
lin revise_V2 = mkV2 (rivedere_V) ; -- status=guess, src=wikt
lin revise_V = rivedere_V ; -- status=guess, src=wikt
lin knock_N = mkN "autocombustione" feminine ; -- status=guess
lin infect_V2 = variants{} ; -- 
lin infect_V = variants{} ; -- 
lin denounce_V2 = variants{} ; -- 
lin confession_N = mkN "confessione" feminine ; -- status=guess
lin turkey_N = mkN "tacchino" ; -- status=guess
lin toll_N = mkN "pedaggio" | mkN "dazio" ; -- status=guess status=guess
lin pal_N = variants{} ; -- 
lin transcription_N = variants{} ; -- 
lin sulphur_N = variants{} ; -- 
lin provisional_A = mkA "provvisionale" ; -- status=guess
lin hug_V2 = mkV2 (mkV "abbracciare") ; -- status=guess, src=wikt
lin particular_N = variants{} ; -- 
lin intent_A = variants{} ; -- 
lin fascinate_V2 = variants{} ; -- 
lin conductor_N = mkN "direttore d'orchestra" ; -- status=guess
lin feasible_A = mkA "fattibile" | mkA "realizzabile" ; -- status=guess status=guess
lin vacant_A = mkA "vacante" ; -- status=guess
lin trait_N = mkN "caratteristica" masculine | mkN "tratto" ; -- status=guess status=guess
lin meadow_N = mkN "prato" ; -- status=guess
lin creed_N = mkN "credo" ; -- status=guess
lin unfamiliar_A = variants{} ; -- 
lin optimism_N = mkN "ottimismo" ; -- status=guess
lin wary_A = mkA "diffidente" ; -- status=guess
lin twist_N = mkN "distorsione" feminine ; -- status=guess
lin sweet_N = mkN "dolcetto" | mkN "caramella" masculine ; -- status=guess status=guess
lin substantive_A = variants{} ; -- 
lin excavation_N = variants{} ; -- 
lin destiny_N = mkN "destino" | mkN "fato" | mkN "fortuna" ; -- status=guess status=guess status=guess
lin thick_Adv = variants{} ; -- 
lin pasture_N = mkN "pastura" ; -- status=guess
lin archaeological_A = mkA "archeologico" ; -- status=guess
lin tick_V2 = variants{} ; -- 
lin tick_V = variants{} ; -- 
lin profit_V2 = mkV2 (mkV "profittare") ; -- status=guess, src=wikt
lin profit_V = mkV "profittare" ; -- status=guess, src=wikt
lin pat_V2 = variants{} ; -- 
lin pat_V = variants{} ; -- 
lin papal_A = mkA "papale" ; -- status=guess
lin cultivate_V2 = mkV2 (mkV "coltivare") ; -- status=guess, src=wikt
lin awake_V = mkV "svegliare" ; -- status=guess, src=wikt
lin trained_A = variants{} ; -- 
lin civic_A = mkA "civico" ; -- status=guess
lin voyage_N = mkN "viaggio" ; -- status=guess
lin siege_N = mkN "assedio" ; -- status=guess
lin enormously_Adv = variants{} ; -- 
lin distract_V2 = mkV2 (distrarre_V) ; -- status=guess, src=wikt
lin distract_V = distrarre_V ; -- status=guess, src=wikt
lin stroll_V = mkV "passeggiare" | mkV (andare_V) "a spasso" | mkV "girovagare" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin jewel_N = mkN "gemma" ; -- status=guess
lin honourable_A = variants{} ; -- 
lin helpless_A = variants{} ; -- 
lin hay_N = mkN "fieno" ; -- status=guess
lin expel_V2 = mkV2 (espellere_V) ; -- status=guess, src=wikt
lin eternal_A = mkA "eterno" ; -- status=guess
lin demonstrator_N = variants{} ; -- 
lin correction_N = mkN "correzione" feminine ; -- status=guess
lin civilization_N = mkN "civilizzazione" feminine ; -- status=guess
lin ample_A = mkA "abbondante" ; -- status=guess
lin retention_N = mkN "conservazione" feminine ; -- status=guess
lin rehabilitation_N = variants{} ; -- 
lin premature_A = variants{} ; -- 
lin encompass_V2 = mkV2 (mkV "circondare") ; -- status=guess, src=wikt
lin distinctly_Adv = variants{} ; -- 
lin diplomat_N = mkN "diplomatico" ; -- status=guess
lin articulate_V2 = variants{} ; -- 
lin articulate_V = variants{} ; -- 
lin restricted_A = variants{} ; -- 
lin prop_V2 = variants{} ; -- 
lin intensify_V2 = variants{} ; -- 
lin intensify_V = variants{} ; -- 
lin deviation_N = variants{} ; -- 
lin contest_V2 = variants{} ; -- 
lin contest_V = variants{} ; -- 
lin workplace_N = mkN "luogo di lavoro" ; -- status=guess
lin lazy_A = mkA "pigro" ; -- status=guess
lin kidney_N = mkN "rene" masculine ; -- status=guess
lin insistence_N = variants{} ; -- 
lin whisper_N = mkN "sussurro" ; -- status=guess
lin multimedia_N = variants{} ; -- 
lin forestry_N = variants{} ; -- 
lin excited_A = variants{} ; -- 
lin decay_N = variants{} ; -- 
lin screw_N = mkN "scopare" ; -- status=guess
lin rally_V2V = variants{} ; -- 
lin rally_V2 = variants{} ; -- 
lin rally_V = variants{} ; -- 
lin pest_N = variants{} ; -- 
lin invaluable_A = variants{} ; -- 
lin homework_N = mkN "compito" ; -- status=guess
lin harmful_A = mkA "dannoso" ; -- status=guess
lin bump_V2 = variants{} ; -- 
lin bump_V = variants{} ; -- 
lin bodily_A = mkA "corporale" ; -- status=guess
lin grasp_N = mkN "presa" | mkN "stretta" ; -- status=guess status=guess
lin finished_A = variants{} ; -- 
lin facade_N = variants{} ; -- 
lin cushion_N = mkN "sponda" ; -- status=guess
lin conversely_Adv = variants{} ; -- 
lin urge_N = mkN "pulsione" feminine ; -- status=guess
lin tune_V2 = variants{} ; -- 
lin tune_V = variants{} ; -- 
lin solvent_N = mkN "solvente" masculine ; -- status=guess
lin slogan_N = variants{} ; -- 
lin petty_A = mkA "piccolo" ; -- status=guess
lin perceived_A = variants{} ; -- 
lin install_V2 = mkV2 (mkV "installare") ; -- status=guess, src=wikt
lin install_V = mkV "installare" ; -- status=guess, src=wikt
lin fuss_N = mkN "rumore" masculine | mkN "baccano" | mkN "chiasso" ; -- status=guess status=guess status=guess
lin rack_N = mkN "rastrelliera" ; -- status=guess
lin imminent_A = variants{} ; -- 
lin short_N = mkN "racconto" ; -- status=guess
lin revert_V = variants{} ; -- 
lin ram_N = mkN "ariete" masculine | mkN "montone" masculine ; -- status=guess status=guess
lin contraction_N = variants{} ; -- 
lin tread_V2 = mkV2 (mkV "calpestare") ; -- status=guess, src=wikt
lin tread_V = mkV "calpestare" ; -- status=guess, src=wikt
lin supplementary_A = mkA "supplementare" | mkA "addizionale" ; -- status=guess status=guess
lin ham_N = mkN "radioamatore" masculine ; -- status=guess
lin defy_V2V = mkV2V (mkV "sfidare") ; -- status=guess, src=wikt
lin defy_V2 = mkV2 (mkV "sfidare") ; -- status=guess, src=wikt
lin athlete_N = mkN "atleta" masculine ; -- status=guess
lin sociological_A = mkA "sociologico" ; -- status=guess
lin physician_N = mkN "medico" | mkN "dottore" masculine | mkN "dottoressa" ; -- status=guess status=guess status=guess
lin crossing_N = variants{} ; -- 
lin bail_N = mkN "cauzione" feminine ; -- status=guess
lin unwanted_A = variants{} ; -- 
lin tight_Adv = variants{} ; -- 
lin plausible_A = variants{} ; -- 
lin midfield_N = mkN "centrocampo" ; -- status=guess
lin alert_A = mkA "allerta" ; -- status=guess
lin feminine_A = mkA "femminile" ; -- status=guess
lin drainage_N = mkN "bacino idrografico" | mkN "bacino imbrifero" ; -- status=guess status=guess
lin cruelty_N = mkN "crudeltà" feminine ; -- status=guess
lin abnormal_A = mkA "anormale" | mkA "anomalo" ; -- status=guess status=guess
lin relate_N = variants{} ; -- 
lin poison_V2 = mkV2 (mkV "avvelenare") | mkV2 (mkV "intossicare") ; -- status=guess, src=wikt status=guess, src=wikt
lin symmetry_N = mkN "simmetria" ; -- status=guess
lin stake_V2 = mkV2 (mkV "picchettare") | mkV2 (scommettere_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin rotten_A = L.rotten_A ;
lin prone_A = variants{} ; -- 
lin marsh_N = mkN "palude" feminine ; -- status=guess
lin litigation_N = variants{} ; -- 
lin curl_N = mkN "ricciolo" | mkN "rotore" masculine ; -- status=guess status=guess
lin urine_N = mkN "orina" | mkN "urina" ; -- status=guess status=guess
lin latin_A = variants{} ; -- 
lin hover_V = mkV "librarsi" | mkV "volteggiare" ; -- status=guess, src=wikt status=guess, src=wikt
lin greeting_N = mkN "saluto" ; -- status=guess
lin chase_N = mkN "caccia" masculine | mkN "cacciare" ; -- status=guess status=guess
lin spouse_N = variants{} ; -- 
lin produce_N = mkN "prodotto" ; -- status=guess
lin forge_V2 = variants{} ; -- 
lin forge_V = variants{} ; -- 
lin salon_N = mkN "galleria" ; -- status=guess
lin handicapped_A = variants{} ; -- 
lin sway_V2 = variants{} ; -- 
lin sway_V = variants{} ; -- 
lin homosexual_A = mkA "omosessuale" ; -- status=guess
lin handicap_V2 = variants{} ; -- 
lin colon_N = mkN "due punti" ; -- status=guess
lin upstairs_N = variants{} ; -- 
lin stimulation_N = variants{} ; -- 
lin spray_V2 = variants{} ; -- 
lin original_N = mkN "originale" masculine ; -- status=guess
lin lay_A = mkA "laico" | mkA "laica" ; -- status=guess status=guess
lin garlic_N = mkN "aglio" ; -- status=guess
lin suitcase_N = mkN "valigia" ; -- status=guess
lin skipper_N = variants{} ; -- 
lin moan_VS = mkVS (mkV "lamentarsi") ; -- status=guess, src=wikt
lin moan_V = mkV "lamentarsi" ; -- status=guess, src=wikt
lin manpower_N = mkN "manodopera" ; -- status=guess
lin manifest_V2 = variants{} ; -- 
lin incredibly_Adv = variants{} ; -- 
lin historically_Adv = variants{} ; -- 
lin decision_making_N = variants{} ; -- 
lin wildly_Adv = variants{} ; -- 
lin reformer_N = variants{} ; -- 
lin quantum_N = mkN "cromodinamica quantistica" ; -- status=guess
lin considering_Subj = variants{} ; -- 
}
