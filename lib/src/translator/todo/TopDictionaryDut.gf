---- checked by EdG till spread_V in the BNC order
concrete TopDictionaryDut of TopDictionary = CatDut
** open ParadigmsDut, (L = LexiconDut), (S = SyntaxDut), IrregDut, (I = IrregDut), (R = ResDut), Prelude in {

---- these should be somewhere else, in a library module
oper mkInterj : Str -> Interj = \s -> lin Interj {s = s} ;
oper mkDet : Str -> Det = \s -> lin Det (R.mkDet s s R.Sg) ; ---- R.mkDet needs to be used for many
oper mkConj : Str -> Conj = \s -> lin Conj {s1 = [] ; s2 = s ; n = R.Pl} ;
oper reflMkV : Str -> V = \s -> reflV (mkV s) ;
oper mkSubj : Str -> Subj = \s -> lin Subj {s = s} ;
mkPredet : Str -> Predet = \s -> lin Predet {s = \\_,_ => s} ;

lin of_Prep = mkPrep "van" ;
lin and_Conj = S.and_Conj ;
lin in_Prep = S.in_Prep ;
lin have_VV = mkVV (mkV "hebben") ; ---- subcat
lin have_V2 = S.have_V2 ;
lin have_V = mkV "hebben" ;
lin it_Pron = S.it_Pron ;
lin to_Prep = S.to_Prep ;
lin for_Prep = S.for_Prep ;
lin i_Pron = S.i_Pron ;
lin iFem_Pron = S.i_Pron ;
lin that_Subj = S.that_Subj ;
lin he_Pron = S.he_Pron ;
lin on_Prep = S.on_Prep ;
lin with_Prep = S.with_Prep ;
lin do_V2 = mkV2 doen_V ;
lin at_Prep = mkPrep "bij" ;
lin by_Prep = mkPrep "bij" ; --- split mkPrep "tegen" by 6 o'clock, --- split mkPrep "door" decision by
lin but_Conj = mkConj "maar" ;
lin from_Prep = S.from_Prep ;
lin they_Pron = S.they_Pron ;
lin theyFem_Pron = S.they_Pron ;
lin she_Pron = S.she_Pron ;
lin or_Conj = S.or_Conj ;
lin as_Subj = mkSubj "zoals" ;
lin we_Pron = S.we_Pron ;
lin weFem_Pron = S.we_Pron ;
lin say_VS = L.say_VS ;
lin say_V2 = mkV2 (mkV "zeggen") ;
lin say_V = mkV "zeggen" ;
lin if_Subj = S.if_Subj ;
lin go_VV = mkVV (L.go_V) ;
lin go_VA = mkVA (L.go_V) ; -- only in expressions?
lin go_V = L.go_V ;
lin get_VV = mkVV (mkV "hebben") ; ---- subcat, tocheck all of get_
lin get_V2V = mkV2V (mkV "op" schieten_V) | mkV2V (mkV "overeen" LexiconDut.come_V) ;
lin make_V2V = mkV2V (mkV "dwingen") to_Prep ; ---- subcat to make someone do something, unusual translation
lin make_V2A = mkV2A (mkV "maken") ;
lin make_V2 = mkV2 (mkV "maken") ;
lin make_V = mkV "maken" | mkV "doen";
lin as_Prep = mkPrep "als" ;
lin out_Adv = mkAdv "uit" ;
lin up_Adv = mkAdv "omhoog" | mkAdv "op" | mkAdv "opwaarts" ; -- tocheck order
lin see_VS = mkVS (zien_V) ;
lin see_VQ = mkVQ (zien_V) ; ---- subcat
lin see_V2V = mkV2V (zien_V) ;
lin see_V2 = L.see_V2 ;
lin see_V = zien_V | mkV "aanschouwen" | no_geV (mkV "bekijken") | mkV "bezien" ; --- "het snappen", to understand/see, does this need disambiguation?
lin know_VS = L.know_VS ;
lin know_VQ = L.know_VQ ;
lin know_V2 = L.know_V2 ;
lin know_V = mkV "weten" | mkV "kennen" ; ---- subcat
lin time_N = mkN "tijd";
lin time_2_N = mkN "tijd" ;
lin time_1_N = mkN "keer" ;
lin take_V2 = mkV2 I.nemen_V ;
lin so_Adv = mkAdv "zo" | mkAdv "zodanig" ; -- not for intensifiers
lin year_N = L.year_N ;
lin into_Prep = mkPrep "in" ; --- split mkPrep "tegen" driving into, but this could also be "in" depending on sense
lin then_Adv = mkAdv "toen" ; --- split mkAdv "dan" if->then
lin think_VS = mkVS (denken_V) ;
lin think_V2 = mkV2 (denken_V) ;
lin think_V = L.think_V ;
lin come_V = L.come_V ;
lin than_Subj = mkSubj "dan" ;
lin more_Adv = mkAdv "meer" ;
lin about_Prep = mkPrep "over" ; --- split mkPrep "om" care about, split mkPrep "ongeveer" about this tall
lin now_Adv = L.now_Adv ;
lin last_A = mkA "laatste" ;
lin last_1_A = mkA "laatste" ;
lin last_2_A = mkA "vorige" ;
lin other_A = mkA "ander" ;
lin give_V3 = L.give_V3 ;
lin give_V2 = mkV2 (geven_V) | mkV2 (no_geV (mkV "overhandigen")) ;
lin give_V = geven_V ;
lin just_Adv = mkAdv "net" | mkAdv "zojuist" | mkAdv "nog net" | mkAdv "op een haar na" ; --- mkAdv "slechts" | mkAdv "maar" just two, I think just has many more senses than one
lin people_N = mkN "mensen" | mkN "volk" neuter | mkN "personen" | mkN "lui" ;
lin also_Adv = mkAdv "ook" | mkAdv "eveneens" | mkAdv "tevens" ;
lin well_Adv = mkAdv "goed" | mkAdv "wel" ;
lin only_Adv = mkAdv "slechts" | mkAdv "alleen" | mkAdv "pas" ;
lin new_A = L.new_A ;
lin when_Subj = S.when_Subj ;
lin way_N = mkN "weg" ;
lin way_2_N = mkN "weg" | mkN "richting" | mkN "route" ;
lin way_1_N = mkN "manier" ;
lin look_VA = mkVA look_V ;
lin look_V2 = mkV2 look_V ; ---- subcat
lin look_V = mkV "kijken" "keek" "keken" "gekeken" ;
lin like_Prep = mkPrep "als" | mkPrep "zoals" ;
lin use_VV = mkVV (mkV "gebruiken") ; ---- subcat, not to be used as "used to ...", that is not translatable
lin use_V2 = mkV2 (mkV "gebruiken") ; -- status=guess, src=wikt
lin use_V = mkV "gebruiken" ;
lin because_Subj = S.because_Subj ;
lin good_A = L.good_A ;
lin find_VS = mkVS (vinden_V) ; ---- split senses 'to be of opinion of' and 'to locate'. V2V is only applicable with the first sense, and there is a synonym for the first one (van mening zijn dat).
lin find_V2A = mkV2A (vinden_V) ;
lin find_V2 = L.find_V2 ;
lin find_V = vinden_V ;
lin man_N = L.man_N ;
lin want_VV = S.want_VV ; --- I can not find SyntaxDut.gf, but I suspect that the irregular forms are not added there
lin want_V2V = mkV2V want_V ;
lin want_V2 = mkV2 want_V ;
lin want_V = mkV "willen" | mkV "willen" "wou" "wouden" "gewild" ;
lin day_N = L.day_N ;
lin between_Prep = S.between_Prep ;
lin even_Adv = mkAdv "nog" ; ---- mkAdv "zelfs" even he can do that
lin there_Adv = S.there_Adv ;
lin many_Det = S.many_Det ;
lin after_Prep = S.after_Prep ;
lin down_Adv = mkAdv "omlaag" | mkAdv "naar beneden" | mkAdv "neer" ;
lin yeah_Interj = mkInterj "ja" | mkInterj "yeah" ;
lin so_Subj = mkSubj "zodat" ;
lin thing_N = mkN "ding" neuter | mkN "zaak" ;
lin tell_VS = mkVS (mkV "vertellen") ;
lin tell_V3 = mkV3 (mkV "vertellen") ;
lin tell_1_V3 = variants{} ; -- 
lin tell_2_V3 = variants{} ; -- 
lin tell_V2V = mkV2V (mkV "vertellen") ;
lin tell_V2S = mkV2S (mkV "vertellen") ;
lin tell_V2 = mkV2 (mkV "vertellen") ;
lin tell_V = mkV "vertellen" ;
lin through_Prep = S.through_Prep ;
lin back_Adv = mkAdv "terug" ;
lin still_Adv = mkAdv "toch" ; -- mkAdv "nog" some walk, more run, still more sprint
lin child_N = L.child_N ;
lin here_Adv = mkAdv "hier" ;
lin over_Prep = mkPrep "over" ; -- mkPrep "boven" over your head
lin too_Adv = mkAdv "ook" | mkAdv "eveneens" ;
lin put_V2 = L.put_V2 ;
lin on_Adv = mkAdv "aan" ; ---- mkAdv "verder" and so on
lin no_Interj = mkInterj "nee" ;
lin work_V2 = mkV2 ("bewerken") ;
lin work_V = mkV "werken" ;
lin work_2_V = mkV "werken" ;
lin work_1_V = mkV "werken" ;
lin become_VA = L.become_VA ;
lin become_V2 = mkV2 (worden_V) ;
lin become_V = worden_V ;
lin old_A = L.old_A ;
lin government_N = mkN "regering" | mkN "overheid" ;
lin mean_VV = mkVV (mkV "bedoelen") ;
lin mean_VS = mkVS (mkV "bedoelen") ; ---- subcat
lin mean_V2V = mkV2V (mkV "bedoelen") ;
lin mean_V2 = mkV2 (mkV "bedoelen") ; --- mkV "betekenen"
lin part_N = mkN "deel" neuter | mkN "gedeelte" neuter ;
lin leave_V2V = mkV2V (mkV "laten") ;
lin leave_V2 = L.leave_V2 ;
lin leave_V = mkV "verlaten" "verliet" "verlieten" "verlaten" ;
lin life_N = mkN "leven" neuter ;
lin great_A = mkA "groot" ;
lin case_N = mkN "kist" ;
lin woman_N = L.woman_N ;
lin over_Adv = mkAdv "overnieuw" | mkAdv "opnieuw" ;
lin seem_VV = mkVV (lijken_V) | mkVV (schijnen_V) ;
lin seem_VS = mkVS (schijnen_V) | mkVS (lijken_V) ;
lin seem_VA = mkVA (lijken_V) | mkVA (schijnen_V) ;
lin work_N = mkN "werk" neuter | mkN "arbeid" ;
lin need_VV = mkVV (moeten_V) ;
lin need_VV = mkVV (moeten_V) ;
lin need_V2 = mkV2 (moeten_V) ;
lin need_V = moeten_V ;
lin feel_VS = mkVS (mkV "voelen") ;
lin feel_VA = mkVA (reflV (mkV "voelen")) ;
lin feel_V2 = mkV2 (mkV "voelen") ;
lin feel_V = mkV "voelen" ;
lin system_N = mkN "systeem" neuter | mkN "stelsel" neuter ;
lin each_Det = mkDet "elk" | mkDet "ieder" ;
lin may_2_VV = mkVV (mkV "mogen") ;
lin may_1_VV = mkVV (mkV "kunnen") ;
lin much_Adv = mkAdv "veel" ;
lin ask_VQ = mkVQ (mkV "vragen") ;
lin ask_V2V = mkV2V (mkV "vragen") ; ---- subcat
lin ask_V2 = mkV2 (mkV "vragen") ; ---- subcat
lin ask_V = mkV "vragen" ;
lin group_N = mkN "groep" ;
lin number_N = L.number_N ;
lin number_3_N = mkN "nummer" ;
lin number_2_N = mkN "aantal" ;
lin number_1_N = mkN "nummer" ;
lin yes_Interj = mkInterj "ja" ;
lin however_Adv = mkAdv "daarentegen" | mkAdv "echter" ;
lin another_Det = mkDet "een andere" ;
lin again_Adv = mkAdv "opnieuw" | mkAdv "nogmaals" | mkAdv "alweer" | mkAdv "weer" | mkAdv "wederom" ;
lin world_N = mkN "wereld" ;
lin area_N = mkN "gebied" neuter | mkN "oppervlakte" ;
lin area_6_N = mkN "oppervlakte" ;
lin area_5_N = mkN "ruimte" | mkN "omgeving" | mkN "oppervlak" neuter ;
lin area_4_N = mkN "gebied" neuter ;
lin area_3_N = mkN "streek" | mkN "gebied" neuter ;
lin area_2_N = mkN "gebied" neuter ;
lin area_1_N = mkN "gebied" neuter | mkN "streek" ;
lin show_VS = mkVS (mkV (mkV "laten") "zien") ;
lin show_VQ = mkVQ (mkV (mkV "laten") "zien") ;
lin show_V2 = mkV2 (mkV (mkV "laten") "zien") | mkV2 (mkV "tonen") | mkV2 (mkV "vertonen") ;
lin show_V = mkV (mkV "laten") "zien" | mkV "tonen" | mkV "vertonen" ;
lin course_N = mkN "koers" ; --- mkN "cursus" school course
lin company_2_N = mkN "gezelschap" ;
lin company_1_N = mkN "bedrijf" neuter ;
lin under_Prep = S.under_Prep ;
lin problem_N = mkN "probleem" neuter ;
lin against_Prep = mkPrep "tegen" ;
lin never_Adv = mkAdv "nooit" ;
lin most_Adv = mkAdv "meest" ;
lin service_N = mkN "dienst" | mkN "bediening" ;
lin try_VV = mkVV (mkV "proberen") ;
lin try_V2 = mkV2 (mkV "proberen") ;
lin try_V = mkV "proberen" | mkV "uitproberen" ;
lin call_V2 = mkV2 (mkV "roepen") ;
lin call_V = mkV "bellen" ; --- mkV "roepen" call for help, mkV "noemen" call me Erik
lin hand_N = L.hand_N ;
lin party_N = mkN "feest" neuter | mkN "partij" | mkN "fuif" ;
lin party_2_N = mkN "partij" ;
lin party_1_N = mkN "feest" neuter | mkN "fuif" ;
lin high_A = mkA "hoog" ;
lin about_Adv = mkAdv "rond" ;
lin something_NP = S.something_NP ;
lin school_N = L.school_N ;
lin in_Adv = mkAdv "in" ;
lin in_1_Adv = mkAdv "binnen" | mkAdv "in" ;
lin in_2_Adv = mkAdv "in" ;
lin small_A = L.small_A ;
lin place_N = mkN "plek" | mkN "plaats" ;
lin before_Prep = S.before_Prep ;
lin while_Subj = mkSubj "terwijl" | mkSubj "zolang" ;
lin away_Adv = mkAdv "weg" ;
lin away_2_Adv = mkAdv "weg" ;
lin away_1_Adv = mkAdv "weg" ;
lin keep_VV = mkVV (mkV "blijven") ;
lin keep_V2A = mkV2A (mkV "houden") ;
lin keep_V2 = mkV2 (mkV "houden") ;
lin keep_V = mkV "houden" ;
lin point_N = mkN "punt" neuter ;
lin point_2_N = mkN "punt" ;
lin point_1_N = mkN "moment" | mkN "punt" ;
lin house_N = L.house_N ;
lin different_A = mkA "verschillend" | mkA "anders" | mkA "ongelijk" ;
lin country_N = L.country_N ;
lin really_Adv = mkAdv "echt" | mkAdv "werkelijk" ;
lin provide_V2 = mkV2 (mkV "voorzien") ;
lin provide_V = mkV "voorzien" | mkV "verstrekken" ;
lin week_N = mkN "week" ;
lin hold_VS = mkVS (hold_V) ;
lin hold_V2 = L.hold_V2 ;
lin hold_V = mkV "houden" "hield" "hielden" "gehouden" ;
lin large_A = mkA "groot" ;
lin member_N = mkN "lid" neuter | mkN "ledemaat" ;
lin off_Adv = mkAdv "weg" | mkAdv "vanaf" | mkAdv "af" ;
lin always_Adv = mkAdv "altijd" ;
lin follow_VS = mkVS (mkV "volgen") ; ---- subcat
lin follow_V2 = mkV2 (mkV "volgen") ;
lin follow_V = mkV "volgen" ;
lin without_Prep = S.without_Prep ;
lin turn_VA = mkVA (turn_V) ;
lin turn_V2 = mkV2 (turn_V) ;
lin turn_V = L.turn_V ;
lin end_N = mkN "einde" neuter ;
lin end_2_N = mkN "kant" ;
lin end_1_N = mkN "einde" ;
lin within_Prep = mkPrep "binnenin" | mkPrep "in" | mkPrep "binnen";
lin local_A = mkA "lokaal" | mkA "plaatselijk" ;
lin where_Subj = mkSubj "waar";
lin during_Prep = S.during_Prep ;
lin bring_V3 = mkV3 (mkV "brengen");
lin bring_V2 = mkV2 (mkV "brengen") ;
lin most_Det = mkDet "meeste" ;
lin word_N = mkN "woord" ;
lin begin_V2 = mkV2 (beginnen_V) | mkV2 (mkV "aanvangen") ;
lin begin_V = beginnen_V | mkV "aanvangen" ;
lin although_Subj = S.although_Subj ;
lin example_N = mkN "voorbeeld" neuter ;
lin next_Adv = mkAdv "volgend" | mkAdv "nabij" | mkAdv "bij" | mkAdv "vlakbij" ;
lin family_N = mkN "familie" feminine ; --- mkN "gezin" neuter family one lives with
lin rather_Adv = mkAdv "liever" ;
lin fact_N = mkN "feit" neuter ;
lin like_VV = mkVV (mkV (mkV "houden") "van") | mkVV (mkV "leuk" (mkV "vinden")) ;
lin like_VS = mkVS (mkV (mkV "houden") "van") | mkVV (mkV "leuk" (mkV "vinden")) ; ---- subcat
lin like_V2 = L.like_V2 ;
lin social_A = mkA "sociaal" | mkA "maatschappelijk" ;
lin write_VS = mkVS (write_V) ; ---- subcat
lin write_V2 = L.write_V2 ;
lin write_V = mkV "schrijven" | mkV "opschrijven" | mkV "neerschrijven" ;
lin state_N = mkN "staat" ;
lin state_2_N = mkN "staat" ;
lin state_1_N = mkN "staat" ;
lin percent_N = mkN "procent" neuter ;
lin quite_Adv = S.quite_Adv ;
lin both_Det = mkDet "beide" | mkDet "allebei" | mkDet "alletwee" | mkDet "allebeide" ;
lin start_V2 = mkV2 (mkV "starten") | mkV2 (beginnen_V) | mkV2 (mkV "aanvangen") ;
lin start_V = mkV "starten" | beginnen_V | mkV "aanvangen" ;
lin run_V2 = mkV2 (mkV "rennen") | mkV2 (lopen_V) ;
lin run_V = L.run_V ;
lin long_A = L.long_A ;
lin right_Adv = mkAdv "juist" | mkAdv "rechts" ;
lin right_2_Adv = mkAdv "rechts" ;
lin right_1_Adv = mkAdv "juist" ;
lin set_V2 = mkV2 (mkV "zetten") ;
lin help_V2V = mkV2V (helpen_V) ;
lin help_V2 = mkV2 (helpen_V) ;
lin help_V = helpen_V ;
lin every_Det = S.every_Det ;
lin home_N = mkN "thuis" neuter ;
lin month_N = mkN "maand" ;
lin side_N = mkN "zijde" | mkN "kant";
lin night_N = L.night_N ;
lin important_A = L.important_A ;
lin eye_N = L.eye_N ;
lin head_N = L.head_N ;
lin information_N = mkN "informatie" ;
lin question_N = L.question_N ;
lin business_N = mkN "bedrijf" neuter | mkN "zaak" ;
lin play_V2 = L.play_V2 ;
lin play_V = L.play_V ;
lin play_3_V2 = mkV2 (mkV "spelen") ;
lin play_3_V = mkV "spelen" ;
lin play_2_V2 = mkV2 (mkV "spelen") ;
lin play_2_V = mkV "spelen" ;
lin play_1_V2 = mkV2 (mkV "spelen");
lin play_1_V = mkV "spelen" ;
lin power_N = mkN "macht" | mkN "kracht" ;
lin money_N = mkN "geld" neuter ;
lin change_N = mkN "wisselgeld" | mkN "muntgeld" ; --- mkN "verandering" a change
lin move_V2 = mkV2 (mkV "bewegen" "bewoog" "bewogen" "bewogen" | mkV "verplaatsen") ;
lin move_V = mkV "bewegen" "bewoog" "bewogen" "bewogen" | mkV "verplaatsen";
lin move_2_V = mkV "verhuizen" ;
lin move_1_V = mkV "bewegen" "bewoog" "bewogen" "bewogen" | mkV "verplaatsen";
lin interest_N = mkN "interesse" | mkN "belangstelling" | mkN "rente" ;
lin interest_4_N = mkN "belang" neuter | mkN "aandeel" neuter; -- interest, stake, legal share of something
lin interest_2_N = mkN "rente" ;
lin interest_1_N = mkN "interesse" ;
lin order_N = mkN "volgorde";
lin book_N = L.book_N ;
lin often_Adv = mkAdv "vaak" | mkAdv "dikwijls" ;
lin development_N = mkN "ontwikkeling" ;
lin young_A = L.young_A ;
lin national_A = mkA "nationaal" | mkA "landelijk" ;
lin pay_V3 = mkV3 (mkV "betalen") ;
lin pay_V2V = mkV2V (mkV "betalen") ; ---- subcat
lin pay_V2 = mkV2 (mkV "betalen") ;
lin pay_V = mkV "betalen" ;
lin hear_VS = mkVS (mkV "horen") ;
lin hear_V2V = mkV2V (mkV "horen") ;
lin hear_V2 = L.hear_V2 ;
lin hear_V = mkV "horen" ;
lin room_N = mkN "kamer" feminine | mkN "ruimte" feminine | mkN "zaal" masculine | mkN "vertrek" neuter ;
lin room_1_N = mkN "kamer" feminine | mkN "ruimte" feminine | mkN "zaal" masculine | mkN "vertrek" neuter ;
lin room_2_N = mkN "plek" | mkN "ruimte" ;
lin whether_Subj = mkSubj "of" ;
lin water_N = L.water_N ;
lin form_N = mkN "vorm" masculine ;
lin car_N = L.car_N ;
lin other_N = mkN "andere" | mkN "ander" ;
lin yet_Adv = mkAdv "nog" | mkAdv "nog steeds" | mkAdv "toch" ;
lin yet_2_Adv = mkAdv "toch" ;
lin yet_1_Adv = mkAdv "nog" | mkAdv "nog steeds";
lin perhaps_Adv = mkAdv "misschien" | mkAdv "wellicht" ;
lin meet_V2 = mkV2 (mkV "ontmoeten") | mkV2 (mkV (mkV "leren") "kennen") ; ---- subcat
lin meet_V = mkV "ontmoeten" | mkV (mkV "leren") "kennen" ;
lin level_N = mkN "verdieping" ;
lin level_2_N = mkN "verdieping" ;
lin level_1_N = mkN "niveau" | mkN "level" ;
lin until_Subj = mkSubj "tot" | mkSubj "totdat" ;
lin though_Subj = mkSubj "echter" | mkSubj "hoewel" ;
lin policy_N = mkN "beleid" neuter | mkN "politiek" ;
lin include_V2 = mkV2 (mkV "invoegen") | mkV2 (mkV "bijvoegen") ; ---- subcat , only one-place in Dutch
lin include_V = mkV "inhouden" | mkV "bijvoegen" | mkV "invoegen" ;
lin believe_VS = mkVS (mkV "geloven") ;
lin believe_V2 = mkV2 (mkV "geloven") ;
lin believe_V = mkV "geloven" ;
lin council_N = mkN "raad" masculine ;
lin already_Adv = L.already_Adv ;
lin possible_A = mkA "mogelijk" ;
lin nothing_NP = S.nothing_NP ;
lin line_N = mkN "lijn" | mkN "verbinding" feminine ;
lin allow_V2V = mkV2V I.laten_V ;
lin allow_V2 = mkV2 I.laten_V ;
lin need_N = mkN "behoefte" feminine | mkN "noodzaak" | mkN "nood" ;
lin effect_N = mkN "effect" neuter ;
lin big_A = L.big_A ;
lin use_N = mkN "gebruik" neuter ;
lin lead_V2V = mkV2V (mkV "leiden") ;
lin lead_V2 = mkV2 (mkV "leiden") ;
lin lead_V = mkV "leiden" ;
lin stand_V2 = mkV2 stand_V ;
lin stand_V = L.stand_V ;
lin idea_N = mkN "idee" neuter | mkN "ingeving" feminine | mkN "gedachte" feminine ;
lin study_N = mkN "studie"; ---- mkN "studiezaal" the room one studies in
lin lot_N = mkN "hoop" | mkN "zootje" ; -- "zootje" can only be used in diminutive form
lin live_V = L.live_V ;
lin job_N = mkN "werk" neuter | mkN "baan" masculine feminine | mkN "beroep" neuter | mkN "job" feminine ;
lin since_Subj = mkSubj "sinds" ;
lin name_N = L.name_N ;
lin result_N = mkN "resultaat" neuter | mkN "opbrengst" | mkN "uitkomst" | mkN "vrucht" ;
lin body_N = mkN "lichaam" neuter;
lin happen_VV = mkVV (mkV "gebeuren") ;
lin happen_V = mkV "gebeuren" ;
lin friend_N = L.friend_N ;
lin right_N = mkN "recht" ;
lin least_Adv = mkAdv "minst" ;
lin right_A = mkA "rechts" ;
lin right_2_A = mkA "rechts" ;
lin right_1_A = mkA "juist" ;
lin almost_Adv = mkAdv "bijna" | mkAdv "nagenoeg" | mkAdv "vrijwel" | mkAdv "zo goed als" ;
lin much_Det = S.much_Det ;
lin carry_V2 = mkV2 carry_V;
lin carry_V = mkV "dragen" "droeg" "droegen" "gedragen";
lin authority_N = mkN "autoriteit" feminine ;
lin authority_2_N = mkN "autoriteit" ;
lin authority_1_N = mkN "autoriteit" ;
lin long_Adv = mkAdv "lang" ;
lin early_A = mkA "vroeg" ;
lin view_N = mkN "uitkijk" | mkN "kijk";
lin view_2_N = mkN "uitkijk" ;
lin view_1_N = mkN "kijk" | mkN "uitkijk" ;
lin public_A = mkA "openbaar" | mkA "publiek" ;
lin together_Adv = mkAdv "samen" | mkAdv "tezamen" ;
lin talk_V2 = mkV2 (mkV "praten") | mkV2 (spreken_V) | mkV2 (mkV "overleggen") ;
lin talk_V = mkV "praten" | spreken_V | mkV "overleggen" ;
lin report_N = mkN "rapport" neuter | mkN "verslag" neuter ;
lin after_Subj = mkSubj "nadat" | mkSubj "na" ;
lin only_Predet = S.only_Predet ;
lin before_Subj = mkSubj "voordat" | mkSubj "voor" ;
lin bit_N = mkN "bit" masculine ; --- mkN "stukje" a piece/bit of
lin face_N = mkN "gezicht" neuter ;
lin sit_V2 = mkV2 L.sit_V ;
lin sit_V = L.sit_V ;
lin market_N = mkN "markt" masculine | mkN "beurs" ;
lin market_1_N = mkN "markt" ;
lin market_2_N = mkN "beurs" ; -- as in 'stock market', this comprises the complete word however, not a proper translation
lin appear_VV = mkVV (blijken_V) ;
lin appear_VS = mkVS (blijken_V) ; -- it appears that ...
lin appear_VA = mkVA (mkV "uit" see_V) ; -- needs preposition 'er' (ziet er goed uit/appears well)
lin appear_V = mkV "verschijnen" "verscheen" "verschenen" ;
lin continue_VV = mkVV continue_V;
lin continue_V2 = mkV2 continue_V;
lin continue_V = mkV "door" go_V | mkV "verder" go_V | mkV "voort" (mkV "zetten") ;
lin able_A = mkA "competent";
lin political_A = mkA "politiek" ;
lin later_Adv = mkAdv "later" ;
lin hour_N = mkN "uur" neuter | mkN "stonde" feminine ;
lin rate_N = mkN "verhouding" feminine ; --- split mkN "snelheid" the speed of something
lin law_N = mkN "wet" | mkN "recht" neuter ;
lin law_2_N = mkN "recht" neuter ;
lin law_1_N = mkN "wet" ;
lin door_N = L.door_N ;
lin court_N = mkN "hof" neuter | mkN "hofhouding" feminine ;
lin court_2_N = mkN "hof" neuter ;
lin court_1_N = mkN "hof" neuter | mkN "hofhouding" feminine ;
lin office_N = mkN "kantoor" neuter | mkN "bureau" neuter | mkN "dienst" masculine | mkN "overheidsdienst" masculine ;
lin let_V2V = mkV2V I.laten_V ;
lin war_N = L.war_N ;
lin produce_V2 = mkV2 produce_V;
lin produce_V = mkV "produceren";
lin reason_N = L.reason_N ;
lin less_Adv = mkAdv "minder" ;
lin minister_N = mkN "minister" | mkN "dominee" masculine ;
lin minister_2_N = mkN "dominee" ;
lin minister_1_N = mkN "minister" ;
lin subject_N = mkN "subject" neuter | mkN "onderwerp" neuter ;
lin subject_2_N = mkN "subject" neuter | mkN "onderwerp" neuter ;
lin subject_1_N = mkN "onderwerp" neuter ;
lin person_N = L.person_N ;
lin term_N = mkN "termijn" ;
lin particular_A = mkA "specifiek" | mkA "bepaald" | mkA "nauwkeurig" | mkA "nauwgezet" | mkA "precies" ;
lin full_A = L.full_A ;
lin involve_VS = mkVS involve_V ; ---- translating involve directly is awkward
lin involve_V2 = mkV2 involve_V ; -- tocheck
lin involve_V = mkV "in" (mkV "houden" "hield") ; -- tocheck
lin sort_N = mkN "soort" neuter ;
lin require_VS = mkVS require_V ;
lin require_V2V = mkV2V require_V ;
lin require_V2 = mkV2 require_V ;
lin require_V = mkV "nodig" have_V | no_geV (mkV "vereisen");
lin suggest_VS = mkVS suggest_V;
lin suggest_V2 = mkV2 suggest_V;
lin suggest_V = mkV "voor" "stellen" | mkV "suggereren";
lin far_A = mkA "ver" ;
lin towards_Prep = mkPrep "richting" ;
lin anything_NP = S.mkNP (mkN "iets") ; ---- pronoun
lin period_N = mkN "periode" feminine ;
lin period_3_N = mkN "periode" ;
lin period_2_N = mkN "punt" | mkN "komma" ; ---- things lost in translation
lin period_1_N = mkN "periode" ;
lin consider_VV = mkVV consider_V ;
lin consider_VS = mkVS consider_V ;
lin consider_V3 = mkV3 consider_V ;
lin consider_V2V = mkV2V consider_V ; ---- subcat
lin consider_V2A = mkV2A consider_V ;
lin consider_V2 = mkV2 consider_V ;
lin consider_V = mkV "overwegen" "overwoog" "overwogen" | no_geV (mkV "beschouwen") | vinden_V ;
lin read_VS = lin mkVS read_V2 ;
lin read_V2 = L.read_V2 ;
lin read_V = L.read_V2 ;
lin change_V2 = mkV2 (no_geV (mkV "veranderen")) | mkV2 (mkV "aan" (mkV "passen")) ;
lin change_V = no_geV (mkV "veranderen") | reflV (mkV "aan" (mkV "passen"));
lin society_N = mkN "maatschappij" | mkN "samenleving" ; --- split mkN "societeit" corps society
lin process_N = mkN "proces" | mkN "bewerking" | mkN "ontwikkelingsgang" | mkN "verloop" ;
lin mother_N = mkN "moeder" feminine ;
lin offer_VV = mkVV (mkV "aan" I.bieden_V) ;
lin offer_V2 = mkV2 (mkV "aan" I.bieden_V) ;
lin late_A = mkA "laat" ;
lin voice_N = mkN "stem" masculine feminine ;
lin both_Adv = mkAdv "allebei" | mkAdv "beiden" | mkAdv "alletwee" ;
lin once_Adv = mkAdv "eens" | mkAdv "een keer" ;
lin police_N = mkN "politie" feminine ;
lin kind_N = mkN "kind" "kinderen" masculine | mkN "kind" "kinders" masculine ;
lin lose_V2 = L.lose_V2 ;
lin lose_V = verliezen_V ;
lin add_VS = mkVS add_V ;
lin add_V2 = mkV2 add_V ;
lin add_V = mkV "toe" (mkV "voegen") ;
lin probably_Adv = mkAdv "waarschijnlijk" ;
lin expect_VV = mkVV expect_V ;
lin expect_VS = mkVS expect_V ;
lin expect_V2V = mkV2V expect_V ;
lin expect_V2 = mkV2 expect_V ;
lin expect_V = no_geV (mkV "verwachten") ;
lin ever_Adv = mkAdv "ooit" | mkAdv "altijd" ;
lin available_A = mkA "beschikbaar" ;
lin price_N = mkN "prijs" masculine ;
lin little_A = mkA "klein" ;
lin action_N = mkN "actie" feminine ;
lin issue_N = mkN "probleem" neuter ;
lin issue_2_N = mkN "uitgave" ;
lin issue_1_N = mkN "probleem" neuter | mkN "issue" ;
lin far_Adv = L.far_Adv ;
lin remember_VS = mkVS remember_V | mkVS (reflV (no_geV (mkV "herinneren"))) ;
lin remember_V2 = mkV2 remember_V | mkV2 (reflV (no_geV (mkV "herinneren"))) ; --- split required, herinneren means to recall, onthouden is to remember a factoid
lin remember_V = no_geV (mkV "onthouden" "onthield" "onthouden") ;
lin position_N = mkN "positie" feminine | mkN "plek" ;
lin low_A = mkA "laag" ;
lin cost_N = mkN "prijs" | mkN "kosten" ; -- kosten is plural, but cost_N is always translated with the plural
lin little_Det = mkDet "weinig" ;
lin matter_N = mkN "materie" feminine | problem_N ;
lin matter_1_N = mkN "materie" feminine ;
lin matter_2_N = problem_N ;
lin community_N = mkN "gemeenschap" feminine ;
lin remain_VV = mkVV (blijven_V) ;
lin remain_VA = mkVA (blijven_V) | mkVA (mkV "resteren"); --- split, resteren is for objects
lin remain_V2 = mkV2 (blijven_V) | mkV2 (mkV "resteren") ;
lin remain_V = blijven_V ;
lin figure_N = mkN "figuur" neuter | mkN "cijfer" ; --- split mkN "afbeelding" look at figure A
lin figure_2_N = mkN "cijfer" ; -- as in, the convincing number
lin figure_1_N = mkN "figuur" neuter ;
lin type_N = mkN "type" neuter ;
lin research_N = mkN "onderzoek" neuter | mkN "speurwerk" neuter ;
lin actually_Adv = mkAdv "eigenlijk" | mkAdv "in werkelijkheid" | mkAdv "feitelijk" ;
lin education_N = mkN "onderwijs" neuter | mkN "opvoeding" ;
lin fall_V = mkV "vallen" "viel" "gevallen" | mkV "in" (mkV "storten") ; -- instorten means falling down
lin speak_V2 = L.speak_V2 ;
lin speak_V = spreken_V ;
lin few_N = mkN "paar" ;
lin today_Adv = L.today_Adv ;
lin enough_Adv = mkAdv "genoeg" ;
lin open_V2 = L.open_V2 ;
lin open_V = mkV "open" (mkV "gaan") ;
lin bad_A = L.bad_A ;
lin buy_V2 = L.buy_V2 ;
lin buy_V = kopen_V ;
lin programme_N = mkN "programma" neuter ;
lin minute_N = mkN "minuut" ;
lin moment_N = mkN "moment" neuter | mkN "tijdstip" neuter | mkN "wijl" feminine | mkN "wijle" feminine | mkN "stond" masculine ;
lin girl_N = L.girl_N ;
lin age_N = mkN "leeftijd" ; --- split mkN "generatie" feminine ; the age of..
lin centre_N = mkN "midden" neuter | mkN "centrum" neuter ; --- possible split, centrum is for locations
lin stop_VV = mkVV stop_V ; --- stoppen met, but mkVV has no V -> Prep -> VV at the moment
lin stop_V2 = mkV2 (mkV "stoppen") ;
lin stop_V = L.stop_V ;
lin control_N = mkN "controle" | mkN "beheersing" feminine ;
lin value_N = mkN "waarde" ;
lin send_V2V = mkV2V send_V ; ---- subcat
lin send_V2 = mkV2 send_V ;
lin send_V = zenden_V | no_geV (mkV "verzenden") | mkV "sturen" | mkV "op" (mkV "sturen"); --- split send_V3?
lin health_N = mkN "gezondheid" feminine | mkN "welzijn" neuter ;
lin decide_VV = mkVV decide_V ; ---- subcat
lin decide_VS = mkVS decide_V ;
lin decide_V2 = mkV2 decide_V ;
lin decide_V = no_geV (mkV "beslissen") | no_geV (mkV "besluiten") ;
lin main_A = mkA "voornaamst" | mkA "hoofdzakelijk" | mkA "belangrijkst" ;
lin win_V2 = L.win_V2 ;
lin win_V = winnen_V | mkV "over" winnen_V ;
lin understand_VS = mkVS understand_V ;
lin understand_V2 = L.understand_V2 ;
lin understand_V = no_geV (mkV "begrijpen" "begreep" "begrepen") | no_geV (mkV "verstaan" "verstond" "verstaan") ;
lin decision_N = mkN "beslissing" feminine | mkN "besluit" neuter ;
lin develop_V2 = mkV2 (mkV "ontwikkelen") ;
lin develop_V = no_geV (mkV "ontwikkelen") ;
lin class_N = mkN "klas" feminine ; --- split mkN "klasse" having class, being classy
lin industry_N = L.industry_N ;
lin receive_V2 = mkV2 (receive_V) ;
lin receive_V = no_geV (mkV "ontvangen" "ontving" "ontvangen") ;
lin back_N = L.back_N ;
lin several_Det = mkDet "verscheidene" | mkDet "divers" ;
lin return_V2 = mkV2 (mkV "retourneren") ;
lin return_V = mkV "terug" (mkV "keren") | mkV "retourneren" ;
lin build_V2 = mkV2 (mkV "bouwen") ;
lin build_V = mkV "bouwen" ;
lin spend_V2 = mkV2 spend_V ;
lin spend_V = mkV "uit" give_V ; --- split mkV "door" (mkV "brengen") spend some time
lin force_N = mkN "kracht";
lin condition_N = mkN "conditie" | mkN "toestand" | mkN "voorwaarde" ;
lin condition_1_N = mkN "voorwaarde" ;
lin condition_2_N = mkN "toestand" | mkN "voorwaarde" ;
lin paper_N = L.paper_N ;
lin off_Prep = mkPrep "van" ; --- split mkPrep "vanaf" This can be split into van and af
lin major_A = mkA "belangrijk" ;
lin describe_VS = mkVS (fixprefixV "be" write_V) | mkVS (fixprefixV "om" write_V) ; ---- subcat
lin describe_V2 = mkV2 (fixprefixV "be" write_V) | mkV2 (fixprefixV "om" write_V) ;
lin agree_VV = mkVV agree_V ;
lin agree_VS = mkVS agree_V ;
lin agree_V = mkV "in" (mkV "stemmen");
lin economic_A = mkA "economisch" ;
lin increase_V2 = mkV2 (increase_V) ;
lin increase_V = mkV "toe" (mkV "take_V") ;
lin upon_Prep = mkPrep "op" ;
lin learn_VV = mkVV learn_V;
lin learn_VS = lin vs learn_V2 ;
lin learn_V2 = L.learn_V2 ;
lin learn_V = lin v learn_V2 ;
lin general_A = mkA "algemeen" ;
lin century_N = mkN "eeuw" ;
lin therefore_Adv = mkAdv "daarom" | mkAdv "bijgevolg" | mkAdv "daardoor" | mkAdv "waardoor" ;
lin father_N = mkN "vader" masculine ;
lin section_N = mkN "sectie" | mkN "gedeelte" ;
lin patient_N = mkN "patient" masculine | mkN "patiente" feminine ;
lin around_Adv = mkAdv "rond" | mkAdv "cirka" ;
lin activity_N = mkN "activiteit" feminine ;
lin road_N = L.road_N ;
lin table_N = L.table_N ;
lin including_Prep = mkPrep "inclusief" ;
lin church_N = L.church_N ;
lin reach_V2 = mkV2 reach_V ;
lin reach_V = no_geV (mkV "bereiken") ;
lin real_A = mkA "echt" | mkA "reëel" ;
lin lie_VS = mkVS lie_2_V ;
lin lie_2_V = liegen_V ;
lin lie_1_V = liggen_V ;
lin mind_N = mkN "brein" neuter | mkN "verstand" | mkN "geest" | mkN "psyche" | mkN "denkvermogen" | mkN "rede" utrum ;
lin likely_A = mkA "waarschijnlijk" | mkA "vermoedelijk" ;
lin among_Prep = mkPrep "onder" | mkPrep "tussen" ;
lin team_N = mkN "team" | mkN "ploeg" ;
lin experience_N = mkN "ervaring" feminine ;
lin death_N = mkN "dood" ;
lin soon_Adv = mkAdv "zo" | mkAdv "spoedig" | mkAdv "binnenkort" ;
lin act_N = mkN "handeling" feminine | mkN "daad" ;
lin sense_N = mkN "zintuig" neuter | mkN "gevoel" neuter | mkN "gewaarwording" feminine ;
lin staff_N = mkN "personeel" neuter | mkN "medewerkers" ;
lin staff_2_N = mkN "staf" ;
lin staff_1_N = mkN "personeel" neuter | mkN "medewerkers" ;
lin certain_A = mkA "zeker" ;
lin certain_2_A = mkA "zeker" ;
lin certain_1_A = mkA "zeker" ;
lin studentMasc_N = L.student_N ;
lin half_Predet = mkPredet "helft" | mkPredet "half" ;
lin half_Predet = mkPredet "helft" | mkPredet "half" ;
lin around_Prep = mkPrep "rond" ;
lin language_N = L.language_N ;
lin walk_V2 = mkV2 walk_V; ---- subcat
lin walk_V = L.walk_V ;
lin die_V = L.die_V ;
lin special_A = mkA "speciaal" ;
lin difficult_A = mkA "lastig" | mkA "moeilijk" ;
lin international_A = mkA "internationaal" ;
lin particularly_Adv = mkAdv "specifiek" ;
lin department_N = mkN "afdeling" | mkN "departement" ;
lin management_N = mkN "management" | mkN "administratie" feminine | mkN "beheer" neuter | mkN "bestuur" neuter | mkN "directie" feminine ;
lin morning_N = mkN "ochtend" | mkN "morgen" ;
lin draw_V2 = mkV2 (mkV (mkV "opzien") "baren") | mkV2 (mkV (mkV "aandacht") "trekken") ; -- status=guess, src=wikt status=guess, src=wikt
lin draw_1_V2 = mkV2 trekken_V ;
lin draw_2_V2 = mkV2 nemen_V ;
lin draw_V = mkV (mkV "opzien") "baren" | mkV (mkV "aandacht") "trekken" ; -- status=guess, src=wikt status=guess, src=wikt
lin hope_VV = mkVV (mkV "hopen") ;
lin hope_VS = L.hope_VS ;
lin hope_V = mkV "hopen" ;
lin across_Prep = mkPrep "door" ; --- split mkPrep "over"
lin plan_N = mkN "plan" neuter ;
lin product_N = mkN "product" neuter | mkN "produkt" neuter ;
lin city_N = L.city_N ;
lin early_Adv = mkAdv "vroeg" ;
lin committee_N = mkN "comité" neuter | mkN "commissie" ;
lin ground_N = ground_1_N ;
lin ground_2_N = mkN "grond" ;
lin ground_1_N = mkN "grond" ;
lin letter_N = letter_1_N ;
lin letter_2_N = mkN "letter" ;
lin letter_1_N = mkN "brief" ;
lin create_V2 = mkV2 create_V ;
lin create_V = mkV "creëren" | scheppen_V | fixprefixV "ont" werpen_V ;
lin evidence_N = mkN "bewijs" neuter ;
lin evidence_2_N = mkN "bewijs" neuter ;
lin evidence_1_N = mkN "bewijs" neuter ;
lin foot_N = L.foot_N ;
lin clear_A = mkA "helder" | mkA "klaar" ;
lin boy_N = L.boy_N ;
lin game_N = game_2_N | game_1_N ;
lin game_3_N = mkN "wedstrijd" ;
lin game_2_N = mkN "spel" neuter ;
lin game_1_N = mkN "spel" neuter ;
lin food_N = mkN "voedsel" neuter | mkN "eten" neuter ;
lin role_N = role_1_N | role_2_N ;
lin role_2_N = mkN "rol" ; -- character, role, part, persona
lin role_1_N = mkN "functie" | mkN "rol" ; -- function, office, part, role
lin practice_N = mkN "oefening" ;
lin bank_N = L.bank_N ;
lin else_Adv = mkAdv "anders" | mkAdv "zoniet" | mkAdv "in het andere geval" ;
lin support_N = mkN "hulp" | mkN "ondersteuning" | mkN "advies" neuter ;
lin sell_V2 = mkV2 sell_V ;
lin sell_V = fixprefixV "ver" kopen_V ;
lin event_N = mkN "gebeurtenis" | mkN "evenement" neuter ;
lin building_N = mkN "gebouw" neuter | mkN "bouw" masculine ;
lin range_N = mkN "afstand" ; ---split mkN "terrein" neuter shooting range
lin behind_Prep = S.behind_Prep ;
lin sure_A = mkA "zeker" ;
lin report_VS = mkVS report_V;
lin report_V2 = mkV2 report_V;
lin report_V = mkV "aan" (mkV "melden") | mkV "rapporteren" | verschijnen_V ;
lin pass_V = mkV "over" gaan_V ; --- split mkV "over" slaan_V to skip on something
lin black_A = L.black_A ;
lin stage_N = mkN "toneel" neuter | mkN "podium" neuter ; --- split mkN "stadium" neuter the stage something is in
lin meeting_N = mkN "afspraak" ;
lin meeting_N = mkN "afspraak" ;
lin sometimes_Adv = mkAdv "soms" ;
lin thus_Adv = mkAdv "dus" | mkAdv "bijgevolg" | mkAdv "aldus" ;
lin accept_VS = mkVS (mkV "aanvaarden") | mkVS (mkV "accepteren") ;
lin accept_V2 = mkV2 (mkV "aanvaarden") | mkV2 (mkV "accepteren") ;
lin accept_V = mkV "accepteren" | mkV "aanvaarden";
lin town_N = mkN "dorp" neuter | mkN "gemeente" feminine | mkN "stad" feminine | mkN "nederzetting" feminine ;
lin art_N = L.art_N ;
lin further_Adv = mkAdv "verder" ;
lin club_N = club_1_N | club_2_N ;
lin club_2_N = mkN "knuppel" ;
lin club_1_N = mkN "club" feminine ;
lin cause_V2V = mkV2V (mkV "veroorzaken") ;
lin cause_V2 = mkV2 (mkV "veroorzaken") ;
lin arm_N = mkN "arm" ;
lin arm_1_N = mkN "arm" ;
lin arm_2_N = mkN "wapen" ;
lin history_N = mkN "geschiedenis" feminine | mkN "verleden" neuter ; ---- the latter means 'past'
lin parent_N = mkN "ouder" masculine ;
lin land_N = mkN "land" neuter ;
lin trade_N = mkN "handel" masculine | mkN "ruil" ;
lin watch_VS = mkVS (mkV "oppassen") ; -- status=guess, src=wikt
lin watch_V2V = mkV2V (mkV "oppassen") ; -- status=guess, src=wikt
lin watch_V2 = L.watch_V2 ;
lin watch_1_V2 = mkV2 kijken_V ;
lin watch_2_V2 = mkV2 (mkV "op" (mkV "letten")) ;
lin watch_V = mkV "op" (mkV "letten") ;
lin white_A = L.white_A ;
lin situation_N = mkN "situatie" feminine | mkN "toestand" masculine ;
lin ago_Adv = mkAdv "geleden" ;
lin teacherMasc_N = L.teacher_N ;
lin record_N = mkN "record" masculine ;
lin record_3_N = mkN "record" ; ---- no exact translation, though the English word can be used in some cases
lin record_2_N = mkN "opname" ;
lin record_1_N = mkN "record" ;
lin manager_N = mkN "directeur" masculine | mkN "manager" ;
lin relation_N = mkN "relatie" | mkN "verband" | mkN "verhouding" ; ---- note that 'een verhouding hebben' means having an affair
lin common_A = mkA "veelvoorkomend" ;
lin common_2_A = mkA "gewoon" ;
lin common_1_A = mkA "veelvoorkomend" ;
lin strong_A = mkA "sterk" | mkA "krachtig" ;
lin whole_A = mkA "heel" ;
lin field_N = field_1_N | field_4_N ;
lin field_4_N = mkN "vak" neuter ;
lin field_3_N = mkN "veld" neuter ;
lin field_2_N = mkN "veld" neuter ;
lin field_1_N = mkN "veld" neuter ;
lin free_A = mkA "vrij" | mkA "los" ;
lin break_V2 = L.break_V2 ;
lin break_V = lin v break_V2 ;
lin yesterday_Adv = mkAdv "gisteren" | mkAdv "gister" ;
lin support_V2 = mkV2 (mkV "steunen") | mkV2 (fixprefixV "onder" (mkV "steunen")) ;
lin window_N = L.window_N ;
lin account_N = mkN "rekening" ;
lin explain_VS = mkVS (mkV "verklaren") ;
lin explain_V2 = mkV2 (mkV "verklaren") | mkV2 (mkV "uit" "leggen") ;
lin stay_VA = mkVA (blijven_V) | mkVA (fixprefixV "ver" blijven_V) ;
lin stay_V = blijven_V | fixprefixV "ver" blijven_V ;
lin few_Det = S.few_Det ;
lin wait_VV = mkVV (mkV "wachten") | mkVV (mkV "af" "wachten") ;
lin wait_V2 = L.wait_V2 ;
lin wait_V = mkV "wachten" | mkV "af" "wachten" ;
lin usually_Adv = mkAdv "gewoonlijk" ;
lin difference_N = mkN "verschil" neuter ;
lin material_N = mkN "materiaal" neuter ;
lin air_N = mkN "lucht" ;
lin wife_N = L.wife_N ;
lin cover_V2 = mkV2 (fixprefixV "be" (mkV "dekken")) | mkV2 (mkV "dekken") ;
lin apply_VV = mkVV (mkV "toe" "passen") ;
lin apply_V2V = mkV2V (mkV "toe" "passen") | mkV2V (mkV "aan" "melden"); ---- subcat
lin apply_V2 = mkV2 (mkV "toe" "passen") ;
lin apply_1_V2 = mkV2 (mkV "toe" "passen") ;
lin apply_2_V2 = mkV2 (mkV "aan" "melden") ; ---- applying for a job is "solliciteren". "aanmelden" is applying for a post or event
lin apply_V = gelden_V | reflV (mkV "toe" "passen") ;
lin project_N = mkN "project" neuter ;
lin raise_V2 = mkV2 (mkV "op" heffen_V) ;
lin sale_N = mkN "verkoop" masculine | mkN "veiling" feminine | mkN "veilingverkoop" masculine ;
lin relationship_N = mkN "relatie" ;
lin indeed_Adv = mkAdv "inderdaad" | mkAdv "daadwerkelijk" ;
lin light_N = mkN "licht" neuter ;
lin claim_VS = mkVS (mkV "op" "eisen") | mkVS (mkV "claimen") ;
lin claim_V2 = mkV2 (mkV "op" "eisen") | mkV2 (mkV "claimen") ;
lin claim_V = mkV "op" "eisen" | mkV "claimen" ;
lin form_V2 = mkV2 (mkV "vormen") | mkV2 (mkV "vorm" geven_V) ;
lin form_V = mkV "vormen" | mkV "vorm" geven_V ;
lin base_V2 = mkV2 (mkV "baseren") ;
lin base_V = mkV "baseren" ; ---- subcat
lin care_N = mkN "zorg" ;
lin someone_NP = S.mkNP (mkN "iemand") ;
lin everything_NP = S.everything_NP ;
lin certainly_Adv = mkAdv "beslist" | mkAdv "zeker" ;
lin rule_N = L.rule_N ;
lin home_Adv = mkAdv "thuis" ;
lin cut_V2 = L.cut_V2 ;
lin cut_V = snijden_V ;
lin grow_VA = mkVA (mkV "groeien") | mkVA (spruiten_V) ;
lin grow_V2 = mkV2 (mkV "groeien") | mkV2 (spruiten_V) ;
lin grow_V = mkV "groeien" | spruiten_V ;
lin similar_A = mkA "gelijkend" | mkA "lijkend" ;
lin story_N = mkN "verhaal" neuter ;
lin quality_N = mkN "kwaliteit" | mkN "klasse" feminine ;
lin tax_N = mkN "belasting" | mkN "taks" masculine feminine ;
lin worker_N = mkN "arbeider" masculine | mkN "arbeidskracht" utrum ;
lin nature_N = mkN "natuur" feminine ;
lin structure_N = mkN "structuur" feminine ; --- split mkN "gebouw" building
lin data_N = mkN "data" | mkN "gegeven" ;
lin necessary_A = mkA "nodig" | mkA "noodzakelijk" ;
lin pound_N = mkN "pond" ;
lin method_N = mkN "methode" feminine ;
lin unit_N = unit_1_N ;
lin unit_6_N = unit_1_N ; ---- the team is a unit
lin unit_5_N = unit_1_N ; ---- building block
lin unit_4_N = mkN "object" neuter ; ---- single undivided whole
lin unit_3_N = unit_1_N ; ---- organization as part of a group
lin unit_2_N = unit_1_N ; ---- structural whole
lin unit_1_N = mkN "eenheid" "eenheden" utrum; ---- unit of measurement
lin central_A = mkA "centraal" ;
lin bed_N = mkN "bed" neuter ;
lin union_N = mkN "vereniging" | mkN "unie" ;
lin movement_N = mkN "beweging" feminine ;
lin board_N = board_1_N | board_2_N ;
lin board_2_N = mkN "bestuur" neuter ;
lin board_1_N = mkN "bord" neuter ;
lin true_A = mkA "waar" | mkA "echt" ;
lin well_Interj = mkInterj "nou" ;
lin simply_Adv = mkAdv "simpelweg" | mkAdv "gewoon" ;
lin contain_V2 = mkV2 (mkV "in" houden_V) | mkV2 (mkV "bevatten") ;
lin especially_Adv = mkAdv "vooral" ;
lin open_A = mkA "open" ;
lin short_A = L.short_A ;
lin personal_A = mkA "persoonlijk" ;
lin detail_N = mkN "detail" ;
lin model_N = mkN "model" neuter ;
lin bear_V2 = mkV2 bear_V ;
lin bear_V = dragen_V ;
lin single_A = single_2_A | single_1_A ;
lin single_2_A = mkA "alleenstaand" ;
lin single_1_A = mkA "enkel" ;
lin join_V2 = mkV2 join_V ;
lin join_V = mkV "lid" worden_V ;
lin reduce_V2 = mkV2 (mkV "verminderen") | mkV2 (mkV "reduceren") ;
lin reduce_V = mkV "verminderen" | mkV "reduceren" ;
lin establish_V2 = mkV2 (mkV "op" "richten") | mkV2 (mkV "stichten") ;
lin wall_N = mkN "muur" ;
lin face_V2 = mkV2 face_V;
lin face_V = mkV "tegemoet" gaan_V ;
lin easy_A = mkA "makkelijk" | mkA "simpel" ;
lin private_A = mkA "persoonlijk" | mkA "privé" ;
lin computer_N = L.computer_N ;
lin hospital_N = mkN "ziekenhuis" neuter | mkN "hospitaal" neuter ;
lin chapter_N = mkN "hoofdstuk" neuter ;
lin scheme_N = mkN "plan" neuter ;
lin theory_N = mkN "theorie" ;
lin choose_VV = mkVV (kiezen_V) ;
lin choose_V2 = mkV2 (kiezen_V) ;
lin wish_VV = mkVV (mkV "wensen") ;
lin wish_VS = mkVS (mkV "wensen") ;
lin wish_V2V = mkV2V (mkV "wensen") ;
lin wish_V2 = mkV2 (mkV "wensen") ;
lin wish_V = mkV "wensen" ;
lin property_N = property_1_N | property_2_N ;
lin property_2_N = mkN "eigendom" ;
lin property_1_N = mkN "kenmerk" neuter | mkN "karakteristiek" | mkN "eigenschap" ;
lin achieve_V2 = mkV2 (mkV "bereiken") | mkV2 (mkV "realiseren") ;
lin financial_A = mkA "financieel" ;
lin poor_A = poor_1_A | poor_2_A | poor_3_A ;
lin poor_3_A = mkA "slecht" ;
lin poor_2_A = mkA "arm" ;
lin poor_1_A = mkA "arm" ;
lin officer_N = officer_1_N ;
lin officer_3_N = mkN "officier" masculine;
lin officer_2_N = mkN "officier" masculine ;
lin officer_1_N = mkN "officier" masculine ;
lin up_Prep = mkPrep "op" | mkPrep "omhoog" ;
lin charge_N = charge_1_N | charge_2_N ;
lin charge_2_N = mkN "aanklacht" ;
lin charge_1_N = mkN "lading" ;
lin director_N = mkN "directeur" masculine feminine | mkN "regisseur" masculine ;
lin drive_V2V = mkV2V drive_V ;
lin drive_V2 = mkV2 drive_V ;
lin drive_V = rijden_V ; --- split mkV "aan" drijven_V to drive machinery
lin deal_V2 = mkV2 deal_V ;
lin deal_V = fixprefixV "ver" (mkV "delen") ; --- split mkV "handelen" dealing as in trading ---- possibly also fixprefixV "uit" (mkV "delen"), to distribute ---- "I don't want to deal with this" idiomatic? ---- also "this paper deals with"
lin place_V2 = mkV2 (mkV "plaatsen") ;
lin approach_N = mkN "aanpak" masculine ;
lin chance_N = mkN "kans" feminine | mkN "gelegenheid" feminine | mkN "mogelijkheid" feminine ;
lin application_N = mkN "toepassing" feminine | mkN "programma" neuter | mkN "applicatie" feminine ; --- split mkN "aanmelding" | mkN "aanbrenging" application of make-up
lin seek_VV = mkVV (zoeken_V) | mkVV (mkV "na" "streven") ;
lin seek_V2 = L.seek_V2 ;
lin foreign_A = foreign_1_A | foreign_2_A ;
lin foreign_2_A = mkA "vreemd" ;
lin foreign_1_A = mkA "buitenlands" | mkA "allochtoon" ;
lin along_Prep = mkPrep "langs" ;
lin top_N = mkN "top" ;
lin amount_N = mkN "hoeveelheid" feminine ;
lin son_N = mkN "zoon" masculine ;
lin operation_N = mkN "operatie" feminine ;
lin fail_VV = mkVV fail_V ;
lin fail_V2 = mkV2 fail_V ;
lin fail_V = mkV "falen" ;
lin human_A = mkA "menselijk" ;
lin opportunity_N = mkN "kans" feminine | mkN "mogelijkheid" ;
lin simple_A = mkA "simpel" ;
lin leader_N = mkN "leider" masculine | mkN "leidster" feminine | mkN "aanvoerder" masculine | mkN "aanvoerster" feminine ;
lin look_N = mkN "blik" masculine ;
lin share_N = mkN "aandeel" neuter | mkN "deel" neuter ;
lin production_N = mkN "productie" feminine ;
lin recent_A = mkA "recent" ;
lin firm_N = mkN "bedrijf" neuter ;
lin picture_N = mkN "plaatje" neuter | mkN "foto" | mkN "beeld" neuter ;
lin source_N = mkN "bron" ;
lin security_N = mkN "veiligheid" feminine ;
lin serve_V2 = mkV2 serve_V ;
lin serve_V = mkV "verdienen" ;
lin according_to_Prep = mkPrep "volgens" ;
lin end_V2 = mkV2 end_V ;
lin end_V = mkV "beëindigen" | mkV "eindigen" | mkV "afsluiten" ;
lin contract_N = mkN "contract" neuter ;
lin wide_A = L.wide_A ;
lin occur_V = mkV "voor" L.come_V | mkV "plaats" vinden_V ;
lin agreement_N = mkN "afspraak" | mkN "overeenkomst" | mkN "goedkeuring" feminine ;
lin better_Adv = mkAdv "beter" ;
lin kill_V2 = L.kill_V2 ;
lin kill_V = mkV "doden" | mkV "vermoorden" ;
lin act_V2 = mkV2 act_V ; ---- subcat
lin act_V = mkV "gedragen" | mkV "op" (mkV "treden") ;
lin site_N = mkN "plek" ;
lin either_Adv = mkAdv "beide" ; ---- no proper translation
lin labour_N = mkN "werk" neuter ; --- split mkN "bevalling" process of having a baby
lin plan_VV = mkVV plan_V ;
lin plan_VS = mkVS plan_V ;
lin plan_V2V = mkV2V plan_V ;
lin plan_V2 = mkV2 plan_V ;
lin plan_V = mkV "plannen" ;
lin various_A = mkA "verscheiden" | mkA "uiteenlopend" | mkA "verschillend" ;
lin since_Prep = mkPrep "sinds" | mkPrep "sedert" ;
lin test_N = mkN "test" masculine | mkN "examen" neuter ;
lin eat_V2 = L.eat_V2 ;
lin eat_V = eten_V | vreten_V | mkV "op" vreten_V ;
lin loss_N = mkN "verlies" neuter ;
lin close_V2 = L.close_V2 ;
lin close_V = sluiten_V ;
lin represent_V2 = mkV2 (mkV "voorstellen") ; -- status=guess, src=wikt
lin represent_V = mkV "vertegenwoordigen" | mkV "representeren" | mkV "voor" (mkV "stellen") ;
lin love_VV = mkVV (lin V love_V2) ;
lin love_V2 = L.love_V2 ;
lin colour_N = mkN "kleur" ;
lin clearly_Adv = mkAdv "duidelijk" ;
lin shop_N = L.shop_N ;
lin benefit_N = mkN "voordeel" neuter ;
lin animal_N = L.animal_N ;
lin heart_N = L.heart_N ;
lin election_N = mkN "verkiezing" feminine ;
lin purpose_N = mkN "doel" neuter | mkN "bedoeling" ;
lin standard_N = mkN "standaard" utrum ;
lin due_A = mkA "door" ; ---- no proper translation, 'door' can be used in 'the effect is due to the attraction of the sun'
lin secretary_N = mkN "secretaris" masculine | mkN "secretaresse" feminine ;
lin rise_V2 = mkV2 rise_V ;
lin rise_V = rijzen_V | mkV "op" stijgen_V ;
lin date_N = date_1_N ;
lin date_7_N = mkN "dadel" ;
lin date_3_N = variants{} ; -- 
lin date_3_N = variants{} ; -- 
lin date_1_N = mkN "datum" ;
lin hard_A = hard_1_A | hard_2_A ;
lin hard_2_A = mkA "lastig" ;
lin hard_1_A = mkA "hard" ;
lin music_N = L.music_N ;
lin hair_N = L.hair_N ;
lin prepare_VV = mkVV prepare_V ;
lin prepare_V2V = mkV2V prepare_V ;
lin prepare_V2 = mkV2 prepare_V ;
lin prepare_V = mkV "voor" (mkV "bereiden") | mkV "prepareren" ;
lin factor_N = mkN "factor" ;
lin other_A = mkA "ander" ;
lin anyone_NP = S.mkNP (mkN "iedereen") | S.mkNP (mkN "iemand") ;
lin pattern_N = mkN "patroon" neuter ; -- status=guess
lin manage_VV = mkVV manage_V ; ---- no proper translation
lin manage_V2 = mkV2 manage_V ;
lin manage_V = mkV "beheren" | mkV "leiden" | mkV "managen" ;--- split mkV "er in" (mkV "slagen") ; to succeed
lin piece_N = mkN "stuk" neuter | mkN "pion" masculine ;
lin discuss_VS = mkVS (mkV "overleggen") | mkVS (mkV "discussiëren") | mkVS (mkV "debatteren") | mkVS (mkV "bediscussiëren") | mkVS (mkV "bepraten");
lin discuss_V2 = mkV2 (mkV "overleggen") | mkV2 (mkV "discussiëren") | mkV2 (mkV "debatteren") | mkV2 (mkV "bediscussiëren") | mkV2 (mkV "bepraten") ;
lin prove_VS = mkVS prove_V ;
lin prove_VA = mkVA prove_V ;
lin prove_V2 = mkV2 prove_V ;
lin prove_V = fixprefixV "be" wijzen_V | mkV "aan" (mkV "tonen") ;
lin front_N = mkN "voorkant" | mkN "voorzijde" ;
lin evening_N = mkN "avond" ;
lin royal_A = mkA "koninklijk" ;
lin tree_N = L.tree_N ;
lin population_N = mkN "bevolking" feminine | mkN "populatie" ;
lin fine_A = mkA "goed" | mkA "prima" ;
lin plant_N = mkN "plant" masculine ;
lin pressure_N = mkN "druk" ;
lin response_N = mkN "antwoord" neuter | mkN "respons" ;
lin catch_V2 = mkV2 vangen_V ;
lin street_N = mkN "straat" ;
lin pick_V2 = mkV2 (kiezen_V) ;
lin pick_V = kiezen_V ; ---- subcat?
lin performance_N = performance_1_N | performance_2_N ;
lin performance_2_N = mkN "voorstelling" | mkN "opvoering" feminine ;
lin performance_1_N = mkN "prestatie" ;
lin knowledge_N = mkN "kennis" | mkN "wetenschap" ;
lin despite_Prep = mkPrep "ondanks" ;
lin design_N = mkN "vormgeving" | mkN "design" neuter ;
lin page_N = mkN "pagina" ;
lin enjoy_VV = mkVV (genieten_V) ;
lin enjoy_V2 = mkV2 (genieten_V) ;
lin individual_N = mkN "individu" neuter | mkN "enkeling" masculine ;
lin suppose_VS = mkVS (mkV "aan" nemen_V) ;
lin suppose_V2 = mkV2 (mkV "aan" nemen_V) ;
lin rest_N = mkN "rust" ;
lin instead_Adv = mkAdv "in plaats van" ;
lin wear_V2 = mkV2 wear_V ;
lin wear_V = dragen_V | mkV "aan" hebben_V ;
lin basis_N = mkN "basis" feminine ;
lin size_N = mkN "maat" feminine | mkN "grootte" feminine ;
lin environment_N = mkN "omgeving" utrum ; --- split mkN "milieu" ;
lin per_Prep = mkPrep "per" ;
lin fire_N = L.fire_N ;
lin fire_2_N = mkN "vuur" neuter ; ---- hold you fire
lin fire_1_N = mkN "vuur" neuter ; ---- they lost everything in the fire
lin series_N = mkN "reeks" feminine | mkN "serie" feminine ;
lin success_N = mkN "succes" neuter | mkN "welgang" masculine ;
lin natural_A = mkA "normaal" | mkA "natuurlijk" ;
lin wrong_A = mkA "slecht" | mkA "fout" | mkA "verkeerd" ;
lin near_Prep = mkPrep "dichtbij" ;
lin round_Adv = mkAdv "rond" ;
lin thought_N = mkN "gedachte" feminine | mkN "idee" neuter ;
lin list_N = mkN "lijst" feminine ;
lin argue_VS = mkVS argue_V ;
lin argue_V2 = mkV2 argue_V ;
lin argue_V = mkV "argumenteren" | mkV "redetwisten" ; --- split mkV "betogen" | mkV "beweren" ; implemented sense is a form of discussing, to split sense is argueing a stance (in a monologue)
lin final_A = mkA "laatste" | mkA "finaal" | mkA "ultiem" | mkA "definitief" ;
lin future_N = mkN "toekomst" feminine ;
lin future_3_N = mkN "toekomst" feminine ; ---- ?
lin future_1_N = mkN "toekomst" feminine ; ---- time to come
lin introduce_V2 = mkV2 (mkV "introduceren") | mkV2 (mkV "voor" "stellen") ; ---- voorstellen can only be used with people
lin analysis_N = mkN "analyse" feminine ;
lin enter_V2 = mkV2 enter_V ;
lin enter_V = mkV "binnen" gaan_V ;
lin space_N = mkN "ruimte" ;
lin arrive_V = mkV "aan" LexiconDut.come_V | mkV "arriveren" ;
lin ensure_VS = mkVS (mkV "verzekeren") ;
lin ensure_V2 = mkV2 (mkV "verzekeren") ;
lin ensure_V = mkV "verzekeren" ;
lin demand_N = mkN "eis" ;
lin statement_N = mkN "verklaring" feminine ;
lin to_Adv = mkAdv "toe" | mkAdv "dicht" ;
lin attention_N = mkN "aandacht" feminine ;
lin love_N = L.love_N ;
lin principle_N = mkN "principe" neuter | mkN "beginsel" neuter ;
lin pull_V2 = L.pull_V2 ;
lin pull_V = trekken_V ;
lin set_N = mkN "set" masculine ;
lin set_2_N = mkN "set" masculine ;
lin set_1_N = mkN "set" masculine ;
lin doctor_N = L.doctor_N ;
lin choice_N = mkN "keuze" feminine | mkN "keuzemogelijkeheid" feminine ;
lin refer_V2 = mkV2 (mkV "verwijzen") ;
lin refer_V = mkV "verwijzen" ;
lin feature_N = mkN "kenmerk" neuter | mkN "eigenschap" feminine ;
lin couple_N = mkN "paar" neuter | mkN "koppel" neuter ;
lin step_N = mkN "stap" masculine ;
lin following_A = mkA "volgende" ;
lin thank_V2 = mkV2 (mkV "bedanken") | mkV2 (mkV "danken") ;
lin machine_N = mkN "machine" feminine ;
lin income_N = mkN "inkomen" neuter ;
lin training_N = mkN "opleiding" feminine | mkN "training" ;
lin present_V2 = mkV2 (mkV "presenteren") ;
lin association_N = mkN "vereniging" | mkN "associatie" ;
lin film_N = mkN "film" ;
lin film_2_N = mkN "dunne laag" ;
lin film_1_N = mkN "film" ;
lin region_N = mkN "streek" feminine | mkN "regio" | mkN "gebied" neuter ;
lin effort_N = mkN "inspanning" ;
lin player_N = mkN "speler" masculine ;
lin everyone_NP = S.mkNP (mkN "iedereen") ;
lin present_A = mkA "present" | mkA "aanwezig" | mkA "tegenwoordig" ;
lin award_N = mkN "onderscheiding" | mkN "toekenning" ;
lin village_N = L.village_N ;
lin control_V2 = mkV2 (mkV "controleren") ;
lin organisation_N = mkN "organisatie" ;
lin whatever_Det = mkDet "wat dan ook voor" ; ---- rather strange translation
lin news_N = mkN "nieuws" neuter ;
lin nice_A = mkA "leuk" | mkA "aardig" | mkA "vriendelijk" ;
lin difficulty_N = mkN "moeilijkheid" ; --- split mkN "obstakel" neuter | mkN "hindernis" ; an obstacle that hinders achievement of a goal
lin modern_A = mkA "modern" ;
lin cell_N = mkN "cel" feminine ;
lin close_A = mkA "dichtbij" | mkA "nabij" ;
lin current_A = mkA "huidig" | mkA "actueel" ;
lin legal_A = mkA "wettelijk" | mkA "legaal" | mkA "wettig" ;
lin energy_N = mkN "energie" feminine ;
lin finally_Adv = mkAdv "eindelijk" | mkAdv "uiteindelijk" ;
lin degree_N = mkN "graden celsius m plural" ; -- status=guess
lin degree_3_N = mkN "graad" ;
lin degree_2_N = mkN "diploma" neuter | mkN "graad" ;
lin degree_1_N = mkN "graad" ;
lin mile_N = mkN "mijl" masculine ;
lin means_N = mkN "middel" neuter ;
lin growth_N = mkN "groei" ;
lin treatment_N = mkN "behandeling" ;
lin sound_N = mkN "geluid" neuter | mkN "klank" ;
lin above_Prep = S.above_Prep ;
lin task_N = mkN "task" | mkN "opgave" feminine ;
lin provision_N = mkN "voorziening" | mkN "provisie" ;
lin affect_V2 = mkV2 (mkV "beinvloeden") | mkV2 (mkV "aan" (mkV "tasten")) ; --- split mkV2 (mkV "beroeren")) ; being deeply affected by something
lin please_Adv = mkAdv "alsjeblieft" | mkAdv "alstublieft" | mkAdv "gelieve" ; ---- the last one is quite formal and only occurs as first word in a sentence
lin red_A = L.red_A ;
lin happy_A = mkA "gelukkig" | mkA "blij" ;
lin behaviour_N = mkN "gedrag" neuter | mkN "houding" ;
lin concerned_A = mkA "ongerust" ; --- split mkA "bewuste" | split mkA "in kwestie" ; the people concerned were punished...
lin point_V2 = mkV2 (wijzen_V) ; --- mkV2 (mkV "richten") ; ---- to point a gun, would be bitransitive
lin point_V = wijzen_V ;
lin function_N = mkN "functie" feminine ;
lin identify_V2 = mkV2 (mkV "identificeren") ;
lin identify_V = reflMkV "identificeren" ;
lin resource_N = mkN "middel" ; --- split mkN "bron" ; a natural resource
lin defence_N = mkN "verdediging" feminine | mkN "verweer" neuter ;
lin garden_N = L.garden_N ;
lin floor_N = L.floor_N ;
lin technology_N = mkN "technologie" ;
lin style_N = mkN "stijl" masculine ;
lin feeling_N = mkN "gevoel" neuter | mkN "emotie" feminine ;
lin science_N = L.science_N ;
lin relate_V2 = mkV2 (mkV "relateren") | mkV2 (mkV "ver" houden_V) ; ---split mkV2 (mkV "verhalen") ; to relate a story
lin relate_V = mkV "relateren" ;
lin doubt_N = mkN "twijfel" feminine ;
lin horse_N = L.horse_N ;
lin force_VS = mkVS (mkV "af" dwingen_V) ;
lin force_V2V = mkV2V force_V ;
lin force_V2 = mkV2 force_V ; --- split mkV2 (mkV "verkrachten") ; to force yourself upon someone, to rape
lin force_V = dwingen_V | mkV "verplichten" | mkV "af" dwingen_V | mkV "forceren" ;
lin answer_N = mkN "antwoord" neuter ;
lin compare_V = mkV "vergelijken" ;
lin suffer_V2 = mkV2 suffer_V ;
lin suffer_V = lijden_V | mkV "onder" gaan_V ;
lin individual_A = mkA "individueel" | mkA "afzonderlijk" ;
lin forward_Adv = mkAdv "vooruit" | mkAdv "voorwaarts" ; ---- can not translate 'from this day forward'
lin announce_VS = mkVS (mkV "aan" (mkV "kondigen")) | mkVS (mkV "verkondigen") ;
lin announce_V2 = mkV2 (mkV "aan" (mkV "kondigen")) | mkV2 (mkV "verkondigen") ;
lin userMasc_N = mkN "gebruiker" masculine ;
lin fund_N = mkN "fonds" ;
lin character_2_N = mkN "karakter" neuter | mkN "teken" neuter ;
lin character_1_N = mkN "karakter" neuter | mkN "persoonlijkheid" ; --- split mkN "karakter" ; character on a show
lin risk_N = mkN "risico" neuter ;
lin normal_A = mkA "normaal" ;
lin nor_Conj = mkConj "noch" | mkConj "evenmin" ;
lin dog_N = L.dog_N ;
lin obtain_V2 = mkV2 (mkV "ver" krijgen_V) | mkV2 "behalen" ;
lin obtain_V = mkV "ver" krijgen_V | mkV "behalen" ; ---- subcat
lin quickly_Adv = mkAdv "snel" | mkAdv "vlug" | mkAdv "gauw" | mkAdv "spoedig" | mkAdv "rap" | mkAdv "gezwind" ;
lin army_N = mkN "leger" neuter | mkN "horde" | mkN "menigte" ;
lin indicate_VS = mkVS (mkV "aan" wijzen_V) | mkVS (mkV "aan" (mkV "duiden")) ;
lin indicate_V2 = mkV2 (mkV "aan" wijzen_V) | mkV2 (mkV "aan" (mkV "duiden")) ;
lin forget_VS = mkVS forget_V ;
lin forget_V2 = L.forget_V2 ;
lin forget_V = lin v L.forget_V2 ;
lin station_N = mkN "station" | mkN "halte" feminine ;
lin glass_N = mkN "glas" neuter ;
lin cup_N = mkN "kop" ;
lin previous_A = mkA "vorig" | mkA "eerder" ;
lin husband_N = L.husband_N ;
lin recently_Adv = mkAdv "onlangs" | mkAdv "recentelijk" | mkAdv "laatst" | mkAdv "overlaatst" ;
lin publish_V2 = mkV2 publish_V ;
lin publish_V = mkV "publiceren" | mkV "uit" geven_V ;
lin serious_A = mkA "serieus" ;
lin anyway_Adv = mkAdv "hoe dan ook" ;
lin visit_V2 = mkV2 visit_V ;
lin visit_V = mkV "be" zoeken_V | mkV "op" zoeken_V ;
lin capital_N = capital_1_N | capital_2_N | capital_3_N ;
lin capital_3_N = mkN "hoofdletter" ;
lin capital_2_N = mkN "vermogen" neuter | mkN "kapitaal" neuter ;
lin capital_1_N = mkN "hoofdstad" masculine feminine ;
lin either_Det = mkDet "beide" ; ---- strange
lin note_N = note_1_N | note_2_N | note_3_N ;
lin note_3_N = mkN "noot" ;
lin note_2_N = mkN "notitie" ;
lin note_1_N = mkN "aantekening" | mkN "notitie" ;
lin season_N = mkN "seizoen" neuter ;
lin argument_N = mkN "argument" neuter ;
lin listen_V = mkV "luisteren" ;
lin show_N = mkN "show" | mkN "voorstelling" ;
lin responsibility_N = mkN "verantwoordelijkheid" feminine ;
lin significant_A = mkA "significant" | mkA "beduidend" | mkA "waarneembaar" ;
lin deal_N = mkN "afspraak" | mkN "transactie" ;
lin prime_A = mkA "eerste" | mkA "uitstekend" | mkA "prima" ;
lin economy_N = mkN "economie" feminine ;
lin economy_2_N = mkN "economie" ; ---- I am not sure about this sense, 'saving money'?
lin economy_1_N = mkN "economie" feminine ;
lin element_N = mkN "element" neuter ;
lin finish_V2 = mkV2 finish_V ;
lin finish_V = mkV "eindigen" | mkV "op" houden_V ;
lin duty_N = mkN "dienst";
lin fight_V2 = L.fight_V2 ;
lin fight_V = vechten_V ;
lin train_V2V = mkV2V (mkV "trainen") ;
lin train_V2 = mkV2 (mkV "trainen") ;
lin train_V = mkV "trainen" | mkV "oefenen" ;
lin maintain_VS = mkVS maintain_V ;
lin maintain_V2 = mkV2 maintain_V ;
lin maintain_V = mkV "handhaven" | mkV "onder" houden_V;
lin attempt_N = mkN "poging" ;
lin leg_N = L.leg_N ;
lin investment_N = mkN "investering" ;
lin save_V2 = mkV2 (mkV "redden") | mkV2 (mkV "sparen") ;
lin save_V = mkV "sparen" ; --- split mkV "redden" to save someone
lin throughout_Prep = mkPrep "door" ; ---- no proper translation
lin design_V2 = mkV2 design_V ;
lin design_V = mkV "ontwerpen" ;
lin suddenly_Adv = mkAdv "plotseling" | mkAdv "plots" | mkAdv "plotsklaps" | mkAdv "ineens" | mkAdv "pardoes" ;
lin brother_N = mkN "broer" masculine | mkN "broeder" masculine ;
lin improve_V2 = mkV2 improve_V ;
lin improve_V = mkV "verbeteren" | mkV "beteren" ; ---- note that: hij verbeterde zijn huiswerk, hij beterde zijn leven
lin avoid_VV = mkVV (fixprefixV "ver" mijden_V) | mkVV mijden_V ;
lin avoid_V2 = mkV2 (fixprefixV "ver" mijden_V) | mkV2 mijden_V ;
lin wonder_VQ = L.wonder_VQ ;
lin wonder_V = reflV (mkV "af" vragen_V) ;
lin tend_VV = mkVV (mkV "de neiging" hebben_V) ; ---- strange
lin tend_V2 = mkV2 (mkV "de neiging" hebben_V) ;
lin title_N = mkN "titel" ;
lin hotel_N = mkN "hotel" neuter ;
lin aspect_N = mkN "aspect" neuter ;
lin increase_N = mkN "toename" ;
lin help_N = mkN "hulp" ;
lin industrial_A = mkA "industrieel" ;
lin express_V2 = mkV2 (mkV "uit" (mkV "drukken")) ;
lin summer_N = mkN "zomer" masculine ;
lin determine_VV = mkVV determine_V ;
lin determine_VS = mkVS determine_V ;
lin determine_V2V = mkV2V determine_V ; ---- subcat
lin determine_V2 = mkV2 determine_V ;
lin determine_V = mkV "vast" (mkV "stellen") | mkV "bepalen" ;
lin generally_Adv = mkAdv "in het algemeen" | mkAdv "gewoonlijk" ;
lin daughter_N = mkN "dochter" feminine ;
lin exist_V = mkV "be" staan_V ;
lin share_V2 = mkV2 (mkV "delen") ;
lin share_V = mkV "delen" ;
lin baby_N = L.baby_N ;
lin nearly_Adv = mkAdv "bijna" ;
lin smile_V = mkV "glimlachen" | mkV "lachen" ;
lin sorry_A = mkA "armzalig" | mkA "treurig" ; ---- improper translations; I am sorry -> het spijt me (it regrets me)
lin sea_N = L.sea_N ;
lin skill_N = mkN "bekwaamheid" feminine | mkN "vaardigheid" feminine ;
lin claim_N = mkN "aanspraak" feminine ;
lin treat_V2 = mkV2 (mkV "behandelen") ;
lin treat_V = mkV "behandelen" ;
lin remove_V2 = mkV2 remove_V ;
lin remove_V = mkV "verwijderen" | mkV "weg" (mkV "halen") ;
lin concern_N = mkN "onderneming" feminine ; --- split mkN "zorg" | mkN "belangstelling" ; some concern on my part
lin university_N = L.university_N ;
lin left_A = mkA "links" ;
lin dead_A = mkA "dood" | mkA "overleden" | mkA "gestorven" ;
lin discussion_N = mkN "discussie" feminine | mkN "bespreking" feminine ;
lin specific_A = mkA "specifiek" ;
lin customerMasc_N = mkN "klant" masculine ;
lin box_N = mkN "doos" ;
lin outside_Prep = mkPrep "buiten" ;
lin state_VS = mkVS (mkV "verklaren") ;
lin state_V2 = mkV2 (mkV "verklaren") ;
lin conference_N = mkN "conferentie" feminine ;
lin whole_N = mkN "geheel" neuter ;
lin total_A = mkA "compleet" | mkA "volledig" | mkA "geheel" ;
lin profit_N = mkN "winst" feminine | mkN "profijt" neuter ;
lin division_N = division_1_N | division_2_N | division_3_N ;
lin division_3_N = mkN "deling" ;
lin division_2_N = mkN "divisie" | mkN "afdeling" ;
lin division_1_N = mkN "afdeling" ;
lin throw_V2 = L.throw_V2 ;
lin throw_V = lin V throw_V2;
lin procedure_N = mkN "procedure" feminine ;
lin fill_V2 = mkV2 fill_V ;
lin fill_V = mkV "op" (mkV "vullen") | mkV "aan" (mkV "vullen") ;
lin king_N = L.king_N ;
lin assume_VS = mkVS (mkV "aan" nemen_V) ;
lin assume_V2 = mkV2 (mkV "aan" nemen_V) ;
lin image_N = mkN "beeld" neuter | mkN "foto" ; ---split mkN "imago" neuter ; North-Korea has a bad image
lin oil_N = L.oil_N ;
lin obviously_Adv = mkAdv "overduidelijk" | mkAdv "vanzelfsprekend" ;
lin unless_Subj = mkSubj "nutteloos" ;
lin appropriate_A = mkA "aangewezen" | mkA "geschikt" ;
lin circumstance_N = mkN "omstandigheid" ;
lin military_A = mkA "militair" ;
lin proposal_N = mkN "voorstel" neuter ;
lin mention_VS = mkVS mention_V ;
lin mention_V2 = mkV2 mention_V ;
lin mention_V = mkV "noemen" | mkV "vermelden" ;
lin client_N = mkN "klant" masculine feminine | mkN "cliënt" masculine feminine ;
lin sector_N = mkN "sector" ;
lin direction_N = mkN "richting" ;
lin admit_VS = mkVS admit_V ;
lin admit_V2 = mkV2 admit_V ;
lin admit_V = mkV "toe" geven_V ;
lin though_Adv = mkAdv "echter" ;
lin replace_V2 = mkV2 (mkV "vervangen") ;
lin basic_A = mkA "basis" ; ---- strange
lin hard_Adv = mkAdv "hard" | mkAdv "lastig" ;
lin instance_N = mkN "voorbeeld" neuter | mkN "instantie" ;
lin sign_N = mkN "teken" neuter ;
lin original_A = mkA "origineel" | mkA "oorspronkelijk" ;
lin successful_A = mkA "succesvol" | mkA "geslaagd" | mkA "gelukt" ;
lin okay_Adv = mkAdv "oké" | mkAdv "okee" ;
lin reflect_V2 = mkV2 (mkV "weerkaatsen") | mkV2 (mkV "weerspiegelen") ;
lin reflect_V = mkV "weerkaatsen" | mkV "weerspiegelen" ;
lin aware_A = mkA "op de hoogte" ;
lin measure_N = mkN "maat" ;
lin attitude_N = mkN "houding" feminine | mkN "gedrag" neuter ;
lin disease_N = mkN "ziekte" feminine ;
lin exactly_Adv = mkAdv "precies" | mkAdv "exact" ;
lin above_Adv = mkAdv "bovenal" | mkAdv "vooral" | mkAdv "voornamelijk" ;
lin commission_N = mkN "commissie" feminine ;
lin intend_VV = mkVV (zijnV (mkV "van plan")) | mkVV (mkV "bedoelen") | mkVV (mkV "menen") ; ---- no exact translation
lin beyond_Prep = mkPrep "voorbij" ;
lin seat_N = mkN "zitplek" ;
lin presidentMasc_N = mkN "president" masculine ;
lin encourage_V2V = mkV2V (mkV "bevorderen") | mkV2V (mkV "patroneren") | mkV2V (mkV "steunen") ;
lin encourage_V2 = mkV2 (mkV "bevorderen") | mkV2 (mkV "patroneren") | mkV2 (mkV "steunen") ;
lin addition_N = mkN "toevoeging" feminine ;
lin goal_N = mkN "doel" neuter | mkN "goal" ;
lin round_Prep = mkPrep "rond" ;
lin miss_V2 = mkV2 miss_V ;
lin miss_V = mkV "missen" ;
lin popular_A = mkA "populair" | mkA "geliefd" | mkA "gewild" | mkA "in trek" ;
lin affair_N = mkN "affaire" ;
lin technique_N = mkN "techniek" feminine ;
lin respect_N = mkN "respect" masculine | mkN "achting" feminine | mkN "eerbied" feminine ;
lin drop_V2 = mkV2 drop_V ;
lin drop_V = mkV "laten" vallen_V ; ---- let fall
lin professional_A = mkA "deskundig" ;
lin less_Det = mkDet "minder" ;
lin once_Subj = mkSubj "zodra" ;
lin item_N = mkN "exemplaar" neuter | mkN "artikel" neuter | mkN "stuk" neuter | mkN "object" neuter ;
lin fly_V2 = mkV2 (mkV "besturen") | mkV2 vliegen_V ;
lin fly_V = L.fly_V ;
lin reveal_VS = mkVS (mkV "onthullen") ;
lin reveal_V2 = mkV2 (mkV "onthullen") ;
lin version_N = mkN "versie" ;
lin maybe_Adv = mkAdv "misschien" | mkAdv "mogelijk" ;
lin ability_N = mkN "vaardigheid" | mkN "vermogen" neuter ;
lin operate_V2 = mkV2 operate_V ;
lin operate_V = mkV "aan" drijven_V | mkV "opereren" ;
lin good_N = mkN "goed" | mkN "goede" ;
lin campaign_N = mkN "campagne" feminine | mkN "veldtocht" masculine ;
lin heavy_A = L.heavy_A ;
lin advice_N = mkN "advies" neuter ;
lin institution_N = mkN "instelling" ;
lin discover_VS = mkVS discover_V ;
lin discover_V2 = mkV2 discover_V ;
lin discover_V = mkV "ontdekken" ;
lin surface_N = mkN "oppervlak" neuter ;
lin library_N = mkN "bibliotheek" feminine ;
lin pupil_N = mkN "leerling" ; --- split mkN "pupil" ; pupil of your eye, the other one is a student
lin record_V2 = mkV2 (mkV "op" nemen_V) ;
lin refuse_VV = mkVV (mkV "weigeren") ;
lin refuse_V2 = mkV2 (mkV "weigeren") ;
lin refuse_V = mkV "weigeren" ;
lin prevent_V2 = mkV2 (mkV "verhinderen") ;
lin advantage_N = mkN "voordeel" neuter ;
lin dark_A = mkA "donker" | mkA "duister" ;
lin teach_V2V = mkV2V teach_V;
lin teach_V2 = L.teach_V2 ;
lin teach_V = lin V L.teach_V2 ;
lin memory_N = mkN "geheugen" neuter ;
lin culture_N = mkN "cultuur" feminine ;
lin blood_N = L.blood_N ;
lin cost_V2 = mkV2 (mkV "kosten") ;
lin cost_V = mkV "kosten" ;
lin majority_N = mkN "meerderheid" feminine | mkN "merendeel" neuter ;
lin answer_V2 = mkV2 (mkV "antwoorden") | mkV2 (mkV "beantwoorden") ;
lin answer_V = mkV "antwoorden" ;
lin variety_N = variety_1_N ;
lin variety_2_N = mkN "soort" ;
lin variety_1_N = mkN "verscheidenheid" feminine ;
lin press_N = mkN "pers" ; --- split mkN "drukmachine" ; something that presses paper
lin depend_V = mkV "af" hangen_V ;
lin bill_N = mkN "rekening" ; --- split mkN "wetsontwerp" ; congress proposed a new bill ---split mkN "briefje" neuter ; a 100 dollar bill
lin competition_N = mkN "concurrentie" feminine | mkN "competitie" ;
lin ready_A = mkA "klaar" | mkA "gereed" ;
lin general_N = mkN "generaal" masculine ;
lin access_N = mkN "toegang" ;
lin hit_V2 = L.hit_V2 ;
lin hit_V = lin V L.hit_V2 ;
lin stone_N = L.stone_N ;
lin useful_A = mkA "nuttig" | mkA "bruikbaar" ;
lin extent_N = mkN "mate" masculine feminine | mkN "bereik" neuter ;
lin employment_N = mkN "werk" neuter | mkN "dienst" ;
lin regard_V2 = mkV2 (mkV "beschouwen") ;
lin regard_V = reflV (mkV "beschouwen") ;
lin apart_Adv = mkAdv "apart" ;
lin present_N = mkN "heden" neuter | mkN "huidige tijd" utrum ;
lin appeal_N = mkN "beroep" neuter ;
lin text_N = mkN "tekst" masculine ;
lin parliament_N = mkN "parlement" neuter ;
lin cause_N = mkN "aanleiding" ;
lin terms_N = mkN "voorwaarden" ;
lin bar_N = bar_1_N | bar_2_N ;
lin bar_2_N = mkN "tralies" ;
lin bar_1_N = mkN "bar" | mkN "café" neuter | mkN "kroeg" ;
lin attack_N = mkN "aanval" masculine ;
lin effective_A = mkA "efficiënt" | mkA "werkzaam" ;
lin mouth_N = L.mouth_N ;
lin down_Prep = mkPrep "af" | mkPrep "naar beneden" ;
lin result_V = mkV "op" (mkV "leveren") | mkV "resulteren" | mkV "uit" LexiconDut.come_V ;
lin fish_N = L.fish_N ;
lin future_A = mkA "toekomstig" ;
lin visit_N = mkN "bezoek" neuter | mkN "visite" feminine ;
lin little_Adv = mkAdv "weinig" ;
lin easily_Adv = mkAdv "makkelijk" ;
lin attempt_VV = mkVV (mkV "pogen") | mkVV (mkV "proberen") ;
lin attempt_V2 = mkV2 (mkV "pogen") | mkV2 (mkV "proberen") ;
lin enable_VS = mkVS (mkV "in staat" (mkV "stellen")) ;
lin enable_V2V = mkV2V (mkV "in staat" (mkV "stellen")) ;
lin enable_V2 = mkV2 (mkV "in staat" (mkV "stellen")) ;
lin trouble_N = mkN "moeilijkheid" | mkN "last" | mkN "zorg" | mkN "probleem" neuter ;
lin traditional_A = mkA "traditioneel" ;
lin payment_N = mkN "uitbetaling" feminine | mkN "betaling" feminine ;
lin best_Adv = mkAdv "best" ;
lin post_N = mkN "post" | mkN "posterij" feminine ; --- split mkN "post" ; he is at his post
lin county_N = mkN "graafschap" neuter ;
lin lady_N = mkN "dame" feminine ;
lin holiday_N = mkN "vakantie" | mkN "feestdag" masculine ; ---- possibly split on single day vs. longer period
lin realize_VS = mkVS (mkV "beseffen") | mkVS (mkV "realiseren") | mkVS (mkV "in" zien_V) ;
lin realize_V2 = mkV2 (mkV "beseffen") | mkV2 (mkV "realiseren") | mkV2 (mkV "in" zien_V) ;
lin importance_N = mkN "belang" neuter | mkN "belangrijkheid" feminine ;
lin chair_N = L.chair_N ;
lin facility_N = mkN "faciliteit" ;
lin complete_V2 = mkV2 complete_V ;
lin complete_V = mkV "af" (mkV "maken") | mkV "voltooien" ;
lin article_N = mkN "artikel" neuter ;
lin object_N = mkN "object" | mkN "voorwerp" neuter ;
lin context_N = mkN "context" masculine ;
lin survey_N = mkN "enquête" | mkN "enquete" ;
lin notice_VS = mkVS (mkV "op" (mkV "merken")) ;
lin notice_V2 = mkV2 (mkV "op" (mkV "merken")) ;
lin complete_A = mkA "volledig" | mkA "compleet" | mkA "allesomvattend" | mkA "algeheel" ;
lin turn_N = mkN "beurt" ;
lin direct_A = mkA "direct" | mkA "direkt" ;
lin immediately_Adv = mkAdv "meteen" | mkAdv "direct" | mkAdv "onmiddellijk" ;
lin collection_N = mkN "collectie" feminine | mkN "verzameling" ;
lin reference_N = mkN "referentie" feminine ;
lin card_N = mkN "kaart" utrum ;
lin interesting_A = mkA "interessant" | mkA "belangwekkend" ;
lin considerable_A = mkA "aanzienlijk" ;
lin television_N = L.television_N ;
lin extend_V2 = mkV2 extend_V ;
lin extend_V = mkV "uit" (mkV "breiden") ;
lin communication_N = mkN "communicatie" ;
lin agency_N = mkN "agentschap" | mkN "agentuur" ;
lin physical_A = mkA "fysisch" | mkA "fysiek" ;
lin except_Conj = mkConj "behalve" ;
lin check_V2 = mkV2 check_V ;
lin check_V = mkV "controleren" ;
lin sun_N = L.sun_N ;
lin species_N = mkN "soort" feminine ;
lin possibility_N = mkN "mogelijkheid" feminine ;
lin officialMasc_N = mkN "beambte" masculine | mkN "functionaris" masculine ;
lin chairman_N = mkN "voorzitter" masculine ;
lin speaker_N = mkN "box" | mkN "luidspreker" | mkN "speaker" ; --- split mkN "spreker" ; speaker at a congress
lin second_N = mkN "seconde" masculine ;
lin career_N = mkN "carrière" feminine | mkN "loopbaan" ;
lin laugh_VS = mkVS laugh_V ;
lin laugh_V2 = mkV2 laugh_V ;
lin laugh_V = L.laugh_V ;
lin weight_N = mkN "gewicht" neuter ;
lin sound_VS = mkVS sound_V ;
lin sound_VA = mkVA sound_V ;
lin sound_V2 = mkV2 sound_V ;
lin sound_V = klinken_V ;
lin responsible_A = mkA "verantwoordelijk" ;
lin base_N = mkN "basis" ; --- split mkN "honk" ; base in baseball
lin document_N = mkN "document" neuter ;
lin solution_N = mkN "oplossing" feminine ;
lin return_N = mkN "retour" neuter ;
lin medical_A = mkA "medisch" ;
lin hot_A = L.hot_A ;
lin recognize_VS = mkVS (mkV "erkennen") ;
lin recognize_4_V2 = mkV2 (mkV "herkennen") ;
lin recognize_1_V2 = mkV2 (mkV "erkennen") ; ---- acknowledge
lin talk_N = mkN "praatje" neuter | mkN "gesprek" neuter | mkN "conversatie" feminine ;
lin budget_N = mkN "budget" neuter | mkN "begroting" feminine ;
lin river_N = L.river_N ;
lin fit_V2 = mkV2 (mkV "passen") ;
lin fit_V = mkV "passen" ;
lin organization_N = mkN "organisatie" feminine ;
lin existing_A = mkA "bestaand" ;
lin start_N = mkN "start" | mkN "begin" neuter | mkN "aanvangst" ;
lin push_VS = mkVS push_V ;
lin push_V2V = mkV2V push_V ;
lin push_V2 = L.push_V2 ;
lin push_V = lin V L.push_V2 ;
lin tomorrow_Adv = mkAdv "morgen" ;
lin requirement_N = mkN "voorwaarde" feminine ;
lin cold_A = L.cold_A ;
lin edge_N = mkN "voorsprong" ;
lin opposition_N = mkN "oppositie" feminine ;
lin opinion_N = mkN "mening" feminine | mkN "opinie" feminine | mkN "visie" feminine ;
lin drug_N = mkN "drug" | mkN "medicijn" ; --- split
lin quarter_N = mkN "kwart" ; --- split mkN "kwartje" ; a coin
lin option_N = mkN "optie" feminine ;
lin sign_V2 = mkV2 sign_V ;
lin sign_V = mkV "ondertekenen" | mkV "tekenen" ;
lin worth_Prep = mkPrep "waard" ;
lin call_N = mkN "telefoongesprek" neuter | mkN "belletje" neuter ;
lin define_V2 = mkV2 (mkV "definiëren") ;
lin define_V = mkV "definiëren" ;
lin stock_N = mkN "aandeel" ;
lin influence_N = mkN "invloed" ;
lin occasion_N = mkN "gelegenheid" feminine ;
lin eventually_Adv = mkAdv "uiteindelijk" ;
lin software_N = mkN "software" masculine | mkN "programmatuur" masculine ;
lin highly_Adv = mkAdv "hoog" | mkAdv "zeer" ;
lin exchange_N = mkN "uitwisseling" ;
lin lack_N = mkN "gebrek" neuter ;
lin shake_V2 = mkV2 (mkV "schudden") ;
lin shake_V = mkV "schudden" ;
lin study_V2 = mkV2 (mkV "studeren") | mkV2 (mkV "leren") ;
lin study_V = mkV "studeren" | mkV "leren" ;
lin concept_N = mkN "concept" neuter | mkN "opvatting" feminine | mkN "begrip" neuter ;
lin blue_A = L.blue_A ;
lin star_N = L.star_N ;
lin radio_N = L.radio_N ;
lin arrangement_N = mkN "regeling" feminine ;
lin examine_V2 = mkV2 (mkV "examineren") ;
lin bird_N = L.bird_N ;
lin green_A = L.green_A ;
lin band_N = mkN "band" ;
lin sex_N = mkN "seks" masculine | mkN "geslachtsgemeenschap" masculine | mkN "vrijen" neuter ;
lin finger_N = mkN "vinger" masculine ;
lin past_N = mkN "verleden" neuter ; --- split mkN "verleden tijd" ; linguistic tense
lin independent_A = mkA "onafhankelijk" ;
lin independent_2_A = mkA "onafhankelijk" ;
lin independent_1_A = mkA "onafhankelijk" ;
lin equipment_N = mkN "uitrusting" feminine ;
lin north_N = mkN "noorden" neuter ;
lin mind_VS = mkVS mind_V ;
lin mind_V2 = mkV2 mind_V ;
lin mind_V = mkV "erg" vinden_V | mkV "uit" (mkV "maken") ;
lin move_N = mkN "stap" masculine | mkN "beweging" ;
lin message_N = mkN "bericht" neuter | mkN "boodschap" feminine ;
lin fear_N = mkN "angst" feminine | mkN "schrik" feminine ;
lin afternoon_N = mkN "namiddag" masculine | mkN "middag" ;
lin drink_V2 = L.drink_V2 ;
lin drink_V = drinken_V ;
lin fully_Adv = mkAdv "volledig" ;
lin race_N = race_2_N | race_1_N ;
lin race_2_N = mkN "ras" neuter ;
lin race_1_N = mkN "race" ;
lin gain_V2 = mkV2 gain_V ;
lin gain_V = fixprefixV "ver" krijgen_V | winnen_V | mkV "bekomen" ;
lin strategy_N = mkN "strategie" ;
lin extra_A = mkA "extra" ;
lin scene_N = mkN "scène" ;
lin slightly_Adv = mkAdv "lichtelijk" | mkAdv "tikkeltje" ;
lin kitchen_N = mkN "keuken" ;
lin speech_N = mkN "toespraak" | mkN "speech" | mkN "redevoering" feminine ;
lin arise_V = mkV "op" staan_V | mkV "op" komen_V | mkV "ont" staan_V | fixprefixV "ver" schijnen_V ;
lin network_N = mkN "netwerk" neuter ;
lin tea_N = mkN "thee" ;
lin peace_N = L.peace_N ;
lin failure_N = mkN "mislukking" feminine | mkN "mislukkeling" masculine feminine ;
lin employee_N = mkN "werknemer" masculine | mkN "medewerker" masculine ;
lin ahead_Adv = mkAdv "vooruit" | mkAdv "voorop" | mkAdv "voor ons" ;
lin scale_N = mkN "schaal" feminine ;
lin hardly_Adv = mkAdv "nauwelijks" ;
lin attend_V2 = mkV2 attend_V ;
lin attend_V = mkV "bij" (mkV "wonen") ;
lin shoulder_N = mkN "schouder" ;
lin otherwise_Adv = mkAdv "anders" | mkAdv "anderszins" ;
lin railway_N = mkN "spoorweg" masculine | mkN "spoor" neuter ;
lin directly_Adv = mkAdv "direct" | mkAdv "rechtstreeks" ;
lin supply_N = mkN "toevoer" masculine | mkN "levering" feminine ;
lin expression_N = mkN "uitdrukking" feminine | mkN "spreekwijze" feminine ;
lin owner_N = mkN "eigenaar" masculine | mkN "eigenares" feminine | mkN "bezitter" masculine | mkN "bezitster" feminine ;
lin associate_V2 = mkV2 (mkV "associëren") ;
lin associate_V = mkV "associëren" ;
lin corner_N = mkN "hoek" masculine ;
lin past_A = mkA "voorbij" ;
lin match_N = match_1_N | match_2_N | match_3_N ;
lin match_3_N = mkN "match" | mkN "overeenstemming" | mkN "gelijke" ;
lin match_2_N = mkN "lucifer" ;
lin match_1_N = mkN "wedstrijd" ;
lin sport_N = mkN "sport" masculine ;
lin status_N = mkN "status" ;
lin beautiful_A = L.beautiful_A ;
lin offer_N = mkN "bod" neuter | mkN "aanbod" neuter ;
lin marriage_N = mkN "huwelijk" feminine ;
lin hang_V2 = mkV2 hangen_V ;
lin hang_V = hangen_V ;
lin civil_A = mkA "burgerlijk" | mkA "civiel" ;
lin perform_V2 = mkV2 perform_V ;
lin perform_V = mkV "op" (mkV "voeren") | mkV "uit" (mkV "voeren") ;
lin sentence_N = mkN "vonnis" neuter | mkN "uitspraak" feminine | mkN "oordeel" neuter ; --- split mkN "zin" ; linguistic sentence
lin crime_N = mkN "misdaad" feminine ;
lin ball_N = mkN "bal" ;
lin marry_V2 = mkV2 (mkV "trouwen") | mkV2 (mkV "huwen") | mkV2 (reflMkV "in de echt verbinden") ;
lin marry_V = mkV "trouwen" | mkV "huwen" | reflMkV "in de echt verbinden" ;
lin wind_N = L.wind_N ;
lin truth_N = mkN "waarheid" feminine ;
lin protect_V2 = mkV2 (mkV "beschermen") | mkV2 (mkV "beveiligen") ;
lin protect_V = mkV "beschermen" | mkV "beveiligen" ;
lin safety_N = mkN "veiligheid" ;
lin partner_N = mkN "partner" ;
lin completely_Adv = mkAdv "compleet" | mkAdv "volledig" | mkAdv "volkomen" ;
lin copy_N = mkN "kopie" feminine | mkN "namaak" | mkN "nabootsing" ;
lin balance_N = mkN "balans" | mkN "evenwicht" neuter ;
lin sister_N = L.sister_N ;
lin reader_N = mkN "lezer" masculine ;
lin below_Adv = mkAdv "onder" ;
lin trial_N = mkN "poging" ; --- split mkN "rechtzaak" ; trial in court
lin rock_N = L.rock_N ;
lin damage_N = mkN "schade" ;
lin adopt_V2 = mkV2 (mkV "adopteren") ; --- split to adopt a new strategy
lin newspaper_N = L.newspaper_N ;
lin meaning_N = mkN "betekenis" masculine ;
lin light_A = mkA "licht" ;
lin essential_A = mkA "essentieel" | mkA "wezenlijk" | mkA "echt" ;
lin obvious_A = mkA "overduidelijk" ;
lin nation_N = mkN "natie" feminine ;
lin confirm_VS = mkVS (mkV "bevestigen") | mkVS (mkV "beamen") ;
lin confirm_V2 = mkV2 (mkV "bevestigen") | mkV2 (mkV "beamen") ;
lin south_N = mkN "zuiden" neuter ;
lin length_N = mkN "lengte" feminine ;
lin branch_N = mkN "branch" | mkN "bedrijfstak" | mkN "vakgebied" ; --- split mkN "tak" ; branch of a tree
lin deep_A = mkA "diep" ;
lin none_NP = S.mkNP (mkN "geen") | S.mkNP (mkN "geen enkele") ; ---- tocheck
lin planning_N = mkN ("planning") ;
lin trust_N = mkN "vertrouwen" ;
lin working_A = mkA "werkende" ;
lin pain_N = mkN "pijn" masculine feminine ;
lin studio_N = mkN "atelier" neuter | mkN "studio" ;
lin positive_A = mkA "positief" ;
lin spirit_N = mkN "geest" ;
lin college_N = mkN "college" ;
lin accident_N = mkN "ongeluk" neuter ;
lin star_V2 = mkV2 (mkV "schitteren") ;
lin hope_N = mkN "hoop" ;
lin mark_V3 = mkV3 (mkV "markeren") ;
lin mark_V2 = mkV2 (mkV "aan" geven_V) ;
lin works_N = mkN "werken" | mkN "oevre" neuter ; ---- tocheck
lin league_N = league_2_N ;
lin league_2_N = mkN "liga" | mkN "league" ;
lin league_1_N = mkN "bende" ; ---- tocheck
lin clear_V2 = mkV2 clear_V ;
lin clear_V = mkV "op" (mkV "klaren") ;
lin imagine_VS = mkVS imagine_V ;
lin imagine_V2 = mkV2 imagine_V ;
lin imagine_V = mkV "voor" (mkV "stellen") | mkV "in" (mkV "beelden") ;
lin through_Adv = mkAdv "door" ;
lin cash_N = mkN "geld" | mkN "cash" ;
lin normally_Adv = mkAdv "normaal" | mkAdv "gewoonlijk" | mkAdv "normaal" ;
lin play_N = mkN "spel" neuter ;
lin strength_N = mkN "kracht" feminine | mkN "sterkte" feminine ;
lin train_N = L.train_N ;
lin travel_V2 = mkV2 travel_V ;
lin travel_V = L.travel_V ;
lin target_N = mkN "doel" neuter ;
lin very_A = mkA "erg" | mkA "heel" ;
lin pair_N = mkN "paar" neuter ;
lin male_A = mkA "mannelijk" ;
lin gas_N = mkN "gas" utrum ;
lin issue_V2 = mkV2 issue_V ;
lin issue_V = mkV "uit" geven_V ; --- split mkV "af" (mkV "kondigen") ; to issue a new law
lin contribution_N = mkN "bijdrage" feminine | mkN "bijdrage" feminine ;
lin complex_A = mkA "complex" ;
lin supply_V2 = mkV2 (mkV "leveren") | mkV2 (mkV "aan" (mkV "leveren")) ;
lin beat_V2 = mkV2 beat_V ;
lin beat_V = slaan_V | mkV "kloppen" ;
lin artist_N = mkN "kunstenaar" masculine | mkN "kunstenares" feminine | mkN "artiest" masculine | mkN "artieste" feminine ;
lin agentMasc_N = mkN "agent" masculine ;
lin presence_N = mkN "aanwezigheid" feminine ;
lin along_Adv = mkAdv "langs" | mkAdv "naar" ;
lin environmental_A = mkA "milieu" ;
lin strike_V2 = mkV2 (mkV "doorstrepen") | mkV2 (mkV "uitwissen") | mkV2 (mkV "wissen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin strike_V = mkV "door" (mkV "strepen") | mkV "uit" (mkV "wissen") | mkV "wissen" ; --- split mkV "staken" ; hunger strike
lin contact_N = mkN "contact" neuter ;
lin protection_N = mkN "bescherming" feminine ;
lin beginning_N = mkN "begin" neuter | mkN "start" neuter ;
lin demand_VS = mkVS (mkV "eisen") | mkVS (mkV "op" (mkV "eisen")) ;
lin demand_V2 = mkV2 (mkV "eisen") | mkV2 (mkV "op" (mkV "eisen")) ;
lin media_N = mkN "media" ;
lin relevant_A = mkA "relevant" ;
lin employ_V2 = mkV2 (mkV "tewerkstellen") | mkV2 (mkV "aannemen") ;
lin shoot_V2 = mkV2 schieten_V ;
lin shoot_V = schieten_V ;
lin executive_N = mkN "leidinggevend" masculine | mkN "uitvoerend" ;
lin slowly_Adv = mkAdv "traag" | mkAdv "langzaam" | mkAdv "langzaamaan" ;
lin relatively_Adv = mkAdv "relatief" ;
lin aid_N = mkN "hulp" | mkN "assistentie" ;
lin huge_A = mkA "enorm" | mkA "reusachtig" | mkA "gigantisch" ;
lin late_Adv = mkAdv "laat" ;
lin speed_N = mkN "snelheid" ;
lin review_N = mkN "recensie" ;
lin test_V2 = mkV2 (mkV "testen") ;
lin order_VS = mkVS order_V ;
lin order_V2V = mkV2V order_V ;
lin order_V2 = mkV2 order_V ;
lin order_V = bevelen_V ; --- split mkV "bestellen" ; to order food
lin route_N = mkN "route" | mkN "traject" neuter ;
lin consequence_N = mkN "gevolg" neuter | mkN "consequentie" ;
lin telephone_N = mkN "telefoon" masculine ;
lin release_V2 = mkV2 (mkV "vrij" (mkV "laten")) ; --- split mkV "los" (mkV "laten") ; --- let go; --- split mkV "uit" geven_V ; --- to release a cd
lin proportion_N = mkN "proportie" | mkN "deel" ;
lin primary_A = mkA "voornaamst" | mkA "primair" ;
lin consideration_N = mkN "overweging" ; ---- 'thanks for your consideration' can not really be translated
lin reform_N = mkN "hervorming" ;
lin driverMasc_N = mkN "bestuurder" masculine | mkN "chauffeur" masculine ;
lin annual_A = mkA "jaarlijks" ;
lin nuclear_A = mkA "nucleair" ;
lin latter_A = mkA "jongstleden" | mkA "dichtsbijzijnde" ; ---- strange
lin practical_A = mkA "praktisch" ;
lin commercial_A = mkA "commercieel" ;
lin rich_A = mkA "rijk" ;
lin emerge_V = mkV "op" komen_V ;
lin apparently_Adv = mkAdv "blijkbaar" | mkAdv "kennelijk" ;
lin ring_V = mkV "bellen" ;
lin ring_6_V2 = mkV2 (mkV "ringen") ;
lin ring_4_V2 = mkV2 (mkV "bellen") ;
lin distance_N = mkN "afstand" masculine | mkN "eind" neuter ;
lin exercise_N = mkN "oefening" ;
lin key_A = mkA "sleutel" ;
lin close_Adv = mkAdv "dicht" | mkAdv "nader" ;
lin skin_N = L.skin_N ;
lin island_N = mkN "eiland" neuter ;
lin separate_A = mkA "afzonderlijk" | mkA "gescheiden" | mkA "afgezonderd" ;
lin aim_VV = mkVV (mkV "richten") ;
lin aim_V2 = mkV2 (mkV "richten") ;
lin aim_V = mkV "richten" ;
lin danger_N = mkN "gevaar" neuter ;
lin credit_N = mkN "saldo" neuter ;
lin usual_A = mkA "gewoon" ;
lin link_V2 = mkV2 (fixprefixV "ver" binden_V) | mkV2 (mkV "linken") ;
lin link_V = fixprefixV "ver" binden_V | mkV "linken" ;
lin candidateMasc_N = mkN "kandidaat" masculine ;
lin track_N = mkN "spoor" neuter | mkN "baan" ;
lin safe_A = mkA "veilig" ;
lin interested_A = mkA "geïnteresseerd" ;
lin assessment_N = mkN "afweging" feminine | mkN "assessement" neuter ;
lin path_N = mkN "pad" neuter | mkN "route" | mkN "weg" masculine ;
lin merely_Adv = mkAdv "louter" | mkAdv "alleen" ;
lin plus_Prep = mkPrep "plus" ;
lin district_N = mkN "wijk" | mkN "district" neuter ;
lin regular_A = mkA "regelmatig" | mkA "geregeld" ; ---- gives strange translations
lin reaction_N = mkN "reactie" feminine ;
lin impact_N = mkN "impact" | mkN "inslag" ;
lin collect_V2 = mkV2 (mkV "verzamelen") ;
lin collect_V = mkV "verzamelen" ;
lin debate_N = mkN "debat" neuter ;
lin lay_V2 = mkV2 (mkV "leggen") ;
lin lay_V = mkV "leggen" ;
lin rise_N = mkN "stijging" ;
lin belief_N = mkN "geloof" neuter ;
lin conclusion_N = mkN "conclusie" | mkN "besluit" neuter;
lin shape_N = mkN "vorm" ;
lin vote_N = mkN "stem" feminine ;
lin aim_N = mkN "doel" neuter | mkN "bedoeling" | mkN "oogmerk" neuter ;
lin politics_N = mkN "politiek" feminine ;
lin reply_VS = mkVS reply_V ;
lin reply_V = mkV "antwoorden" | mkV "beantwoorden" ;
lin press_V2V = mkV2V press_V ;
lin press_V2 = mkV2 press_V ;
lin press_V = mkV "drukken" ;
lin approach_V2 = mkV2 (mkV "benaderen") | mkV2 (mkV "naderen") ;
lin approach_V = mkV "benaderen" | mkV "naderen" ;
lin file_N = mkN "bestand" ;
lin western_A = mkA "westers" | mkA "westelijk" ;
lin earth_N = L.earth_N ;
lin public_N = mkN "publiek" neuter ;
lin survive_V2 = mkV2 (mkV "overleven") ;
lin survive_V = mkV "overleven" ;
lin estate_N = mkN "landgoed" neuter ;
lin boat_N = L.boat_N ;
lin prison_N = mkN "gevangenis" feminine ;
lin additional_A = mkA "bijkomend" ;
lin settle_V2 = mkV2 (mkV "beslechten") ; ---- settle a discussion
lin settle_V = mkV "vestigen" ;
lin largely_Adv = mkAdv "grotendeels" ;
lin wine_N = L.wine_N ;
lin observe_VS = mkVS (mkV "waar" nemen_V) | mkVS (mkV "observeren") ;
lin observe_V2 = mkV2 (mkV "waar" nemen_V) | mkV2 (mkV "observeren") ;
lin limit_V2V = mkV2V (mkV "beperken") | mkV2V (mkV "begrenzen") ;
lin limit_V2 = mkV2 (mkV "beperken") | mkV2 (mkV "begrenzen") ;
lin deny_V3 = mkV3 (mkV "ontkennen") ;
lin deny_V2 = mkV2 (mkV "ontkennen") ;
lin for_PConj = S.mkPConj (mkConj "omdat") | S.mkPConj (mkConj "sinds") ;
lin straight_Adv = mkAdv "recht" ;
lin somebody_NP = S.somebody_NP ;
lin writer_N = mkN "schrijver" masculine | mkN "schrijfster" feminine | mkN "auteur" masculine feminine ;
lin weekend_N = mkN "weekend" neuter | mkN "weekeinde" neuter ;
lin clothes_N = mkN "kleren" ;
lin active_A = mkA "actief" ;
lin sight_N = mkN "zicht" neuter | mkN "zichtsvermogen" neuter ;
lin video_N = mkN "video" | mkN "film" | mkN "videocassette" feminine ;
lin reality_N = mkN "realiteit" feminine | mkN "feitelijkheid" feminine ;
lin hall_N = mkN "gang" | mkN "hal" ;
lin nevertheless_Adv = mkAdv "desondanks" | mkAdv "desalniettemin" | mkAdv "niettemin" | mkAdv "niettegenstaande" | mkAdv "toch" ;
lin regional_A = mkA "regionaal" | mkA "gewestelijk" ;
lin vehicle_N = mkN "voertuig" neuter ;
lin worry_VS = mkVS worry_V ;
lin worry_V2 = mkV2 worry_V ;
lin worry_V = zijnV (mkV "bezorgd") | reflV (mkV "zorgen" (mkV "maken")) ;
lin powerful_A = mkA "machtig" ;
lin possibly_Adv = mkAdv "mogelijk" ;
lin cross_V2 = mkV2 cross_V ;
lin cross_V = mkV "door" (mkV "kruisen") ; --- split mkV "over" steken_V ; to cross a street or river
lin colleague_N = mkN "collega" ;
lin charge_V2 = mkV2 (mkV "laden") ;
lin charge_V = mkV "laden" ;
lin lead_N = mkN "leiding" feminine | mkN "begeleiding" feminine ;
lin farm_N = mkN "boerderij" feminine ;
lin respond_VS = mkVS respond_V ;
lin respond_V = mkV "reageren" ;
lin employer_N = mkN "werkgever" masculine | mkN "werkgeefster" feminine ;
lin carefully_Adv = mkAdv "voorzichtig" ;
lin understanding_N = mkN "begrip" neuter | mkN "overeenkomst" | mkN "verstandhouding" ;
lin connection_N = mkN "verbinding" feminine | mkN "connectie" feminine ;
lin comment_N = mkN "opmerking" | mkN "commentaar" neuter ;
lin grant_V3 = mkV3 (mkV "verlenen") | mkV3 (mkV "toe" (mkV "kennen")) ;
lin grant_V2 = mkV2 (mkV "verlenen") | mkV2 (mkV "toe" (mkV "kennen")) ;
lin concentrate_V2 = mkV2 (reflV (mkV "concentreren")) ;
lin concentrate_V = reflV (mkV "concentreren") ;
lin ignore_V2 = mkV2 (mkV "negeren") ;
lin ignore_V = mkV "negeren" ;
lin phone_N = mkN "telefoon" masculine ;
lin hole_N = mkN "gat" neuter | mkN "opening" feminine ;
lin insurance_N = mkN "verzekering" ;
lin content_N = mkN "inhoud" masculine | mkN "content" ;
lin confidence_N = mkN "betrouwbaarheid" ;
lin sample_N = mkN "monster" neuter | mkN "sample" neuter ;
lin transport_N = mkN "vervoer" neuter | mkN "transport" neuter ;
lin objective_N = mkN "doel" neuter | mkN "doelstelling" feminine | mkN "streefdoel" neuter ;
lin alone_A = mkA "alleen" ;
lin flower_N = L.flower_N ;
lin injury_N = mkN "verwonding" feminine ;
lin lift_V2 = mkV2 lift_V ;
lin lift_V = mkV "op" (mkV "tillen") | mkV "op" (mkV "heffen") ;
lin stick_V2 = mkV2 stick_V ;
lin stick_V = mkV "kleven" | mkV "plakken" ;
lin front_A = mkA "voor" ;
lin mainly_Adv = mkAdv "voornamelijk" ;
lin battle_N = mkN "strijd" | mkN "gevecht" neuter ;
lin generation_N = mkN "generatie" ;
lin currently_Adv = mkAdv "momenteel" ;
lin winter_N = mkN "winter" masculine ;
lin inside_Prep = mkPrep "binnen" | mkPrep "in" ;
lin impossible_A = mkA "onmogelijk" ;
lin somewhere_Adv = S.somewhere_Adv ;
lin arrange_V2 = mkV2 arrange_V ;
lin arrange_V = mkV "regelen" ; --- split mkV "schikken" ; arranging flowers
lin will_N = mkN "wil" masculine ;
lin sleep_V = L.sleep_V ;
lin progress_N = mkN "vordering" feminine | mkN "voortgang" masculine | mkN "vooruitgang" masculine ;
lin volume_N = mkN "jaargang" masculine ;
lin ship_N = L.ship_N ;
lin legislation_N = mkN "wet" feminine | mkN "legislatie" ;
lin commitment_N = mkN "verplichting" feminine | mkN "verbintenis" feminine ;
lin enough_Predet = mkPredet "genoeg" | mkPredet "voldoende" ;
lin conflict_N = mkN "conflict" neuter | mkN "geschil" neuter ;
lin bag_N = mkN "tas" feminine | mkN "zak" masculine ;
lin fresh_A = mkA "vers" | mkA "nieuw" ;
lin entry_N = entry_1_N | entry_2_N ;
lin entry_2_N = mkN "invoer" ;
lin entry_1_N = mkN "toegang" ;
lin smile_N = mkN "glimlach" masculine | mkN "lach" ;
lin fair_A = mkA "redelijk" | mkA "schappelijk" | mkA "doenbaar" ;
lin promise_VV = mkVV promise_V ;
lin promise_VS = mkVS promise_V ;
lin promise_V2 = mkV2 promise_V ;
lin promise_V = mkV "beloven" | mkV "toe" zeggen_V ;
lin introduction_N = mkN "inleiding" | mkN "introductie" ;
lin senior_A = mkA "ouder" ; ---- strange-ish
lin manner_N = mkN "wijze" | mkN "manier" ;
lin background_N = mkN "achtergrond" ;
lin key_N = key_1_N | key_2_N ;
lin key_2_N = mkN "toets" ;
lin key_1_N = mkN "sleutel" ;
lin touch_V2 = mkV2 touch_V ;
lin touch_V = mkV "aan" (mkV "raken") | mkV "raken" | mkV "roeren" ;
lin vary_V2 = mkV2 (mkV "variëren") ;
lin vary_V = mkV "variëren" ;
lin sexual_A = mkA "seksueel" ;
lin ordinary_A = mkA "gewoon" ;
lin cabinet_N = mkN "kabinet" neuter ; --- split mkN "kastje" ; cupboard
lin painting_N = mkN "schilderij" neuter | mkN "schilderwerk" neuter ;
lin entirely_Adv = mkAdv "geheel" | mkAdv "volledig" ;
lin engine_N = mkN "motor" | mkN "machine" ;
lin previously_Adv = mkAdv "eerder" | mkAdv "tevoren" | mkAdv "vroeger" ;
lin administration_N = mkN "administratie" feminine ;
lin tonight_Adv = mkAdv "vanavond" ;
lin adult_N = mkN "volwassene" ;
lin prefer_VV = mkVV (mkV "voorkeur" geven_V) | mkVV (mkV "voorkeur" hebben_V) ;
lin prefer_V2 = mkV2 (mkV "voorkeur" geven_V) | mkV2 (mkV "voorkeur" hebben_V) ;
lin author_N = mkN "auteur" masculine | mkN "schrijver" masculine | mkN "schrijfster" feminine ;
lin actual_A = mkA "eigenlijk" | mkA "feitelijk" ;
lin song_N = L.song_N ;
lin investigation_N = mkN "onderzoek" neuter ;
lin debt_N = mkN "schuld" feminine | mkN "verplichting" ;
lin visitor_N = mkN "bezoeker" masculine ;
lin forest_N = mkN "bos" neuter | mkN "woud" neuter ;
lin repeat_VS = mkVS repeat_V ;
lin repeat_V2 = mkV2 repeat_V ;
lin repeat_V = mkV "herhalen" | mkV "herdoen" ; --- possibly split; herdoen is for actions, herhalen for speech
lin wood_N = L.wood_N ;
lin contrast_N = mkN "contrast" neuter ;
lin extremely_Adv = mkAdv "uitermate" ;
lin wage_N = mkN "loon" neuter | mkN "salaris" neuter ;
lin domestic_A = mkA "huiselijk" ; --- mkA "binnenlands" ; inside the country
lin commit_V2 = mkV2 (mkV "plegen") ;
lin threat_N = mkN "bedreiging" feminine ;
lin bus_N = mkN "bus" masculine | mkN "autobus" masculine ;
lin warm_A = L.warm_A ;
lin sir_N = mkN "meneer" masculine ;
lin regulation_N = mkN "regeling" feminine | mkN "verordening" feminine ;
lin drink_N = mkN "drinken" neuter | mkN "drankje" neuter ;
lin relief_N = mkN "opluchting" | mkN "verlichting" ;
lin internal_A = mkA "intern" | mkA "inwendig" ;
lin strange_A = mkA "vreemd" | mkA "raar" ;
lin excellent_A = mkA "uitstekend" | mkA "uitmuntend" | mkA "excellent" | mkA "voortreffelijk" ;
lin run_N = mkN "loop" masculine ;
lin fairly_Adv = mkAdv "tamelijk" | mkAdv "behoorlijk" ; --- split mkAdv "eerlijk" ; in a fair manner
lin technical_A = mkA "technisch" ;
lin tradition_N = mkN "traditie" feminine ;
lin measure_V2 = mkV2 (meten_V) ;
lin measure_V = meten_V ;
lin insist_VS = mkVS insist_V ;
lin insist_V2 = mkV2 insist_V ;
lin insist_V = mkV "aan" dringen_V | mkV "vol" houden_V ;
lin farmer_N = mkN "boer" masculine | mkN "boerin" feminine | mkN "agrariër" | mkN "landbouwer" masculine | mkN "veehouder" masculine ;
lin until_Prep = mkPrep "tot" | mkPrep "totdat" ;
lin traffic_N = mkN "verkeer" neuter ;
lin dinner_N = mkN "avondeten" neuter | mkN "dinee" neuter ;
lin consumer_N = mkN "consument" masculine | mkN "verbruiker" masculine ;
lin meal_N = mkN "maaltijd" | mkN "maal" neuter ;
lin warn_VS = mkVS (mkV "waarschuwen") | mkVS (mkV "verwittigen") | mkVS (mkV "waarnen") ;
lin warn_V2V = mkV2V (mkV "waarschuwen") | mkV2V (mkV "verwittigen") | mkV2V (mkV "waarnen") ;
lin warn_V2 = mkV2 (mkV "waarschuwen") | mkV2 (mkV "verwittigen") | mkV2 (mkV "waarnen") ;
lin warn_V = mkV "waarschuwen" | mkV "verwittigen" | mkV "waarnen" ;
lin living_A = mkA "levend" ;
lin package_N = mkN "verpakking" | mkN "pakketje" neuter ;
lin half_N = mkN "helft" ;
lin increasingly_Adv = mkAdv "toenemend" | mkAdv "groeiend" ;
lin description_N = mkN "beschrijving" feminine ;
lin soft_A = mkA "zacht" ;
lin stuff_N = mkN "spul" | mkN "waar" masculine | mkN "stof" masculine ;
lin award_V3 = mkV3 (mkV "toe" (mkV "kennen")) ;
lin award_V2 = mkV2 (mkV "toe" (mkV "kennen")) ;
lin existence_N = mkN "bestaan" neuter ;
lin improvement_N = mkN "verbetering" feminine ;
lin coffee_N = mkN "koffie" masculine ;
lin appearance_N = mkN "verschijning" | mkN "uiterlijk" | mkN "voorkomen" | mkN "aanblik" ;
lin standard_A = mkA "standaard" ;
lin attack_V2 = mkV2 (mkV "aan" vallen_V) ;
lin sheet_N = mkN "vel" neuter | mkN "blad" neuter | mkN "plaat" ;
lin category_N = mkN "categorie" feminine ;
lin distribution_N = mkN "verdeling" feminine | mkN "distributie" | mkN "uitdeling" ;
lin equally_Adv = mkAdv "gelijk" | mkAdv "even" | mkAdv "gelijkwaardig" ;
lin session_N = mkN "zitting" feminine | mkN "sessie" ;
lin cultural_A = mkA "cultureel" ;
lin loan_N = mkN "lening" feminine ;
lin bind_V2 = mkV2 bind_V ;
lin bind_V = binden_V | mkV "ver" binden_V | mkV "koppelen" ;
lin museum_N = mkN "museum" neuter ;
lin conversation_N = mkN "gesprek" neuter | mkN "conversatie" ;
lin threaten_VV = mkVV (mkV "bedreigen") | mkVV (mkV "dreigen") ;
lin threaten_VS = mkVS (mkV "bedreigen") | mkVS (mkV "dreigen") ;
lin threaten_V2 = mkV2 (mkV "bedreigen") | mkV2 (mkV "dreigen") ;
lin threaten_V = mkV "bedreigen" | mkV "dreigen" ;
lin link_N = mkN "verbinding" feminine | mkN "link";
lin launch_V2 = mkV2 (mkV "lanceren") ;
lin launch_V = mkV "lanceren" ;
lin proper_A = mkA "eigen" | mkA "proper" ; ---- strange
lin victim_N = mkN "slachtoffer" neuter ;
lin audience_N = mkN "toehoorders" | mkN "gehoor" ; ---- strange
lin famous_A = mkA "beroemd" | mkA "bekend" ;
lin master_N = mkN "meester" masculine ;
lin master_2_N = mkN "meester" ;
lin master_1_N = mkN "meester" ;
lin lip_N = mkN "lip" ;
lin religious_A = mkA "religieus" | mkA "godsdienstig" ;
lin joint_A = mkA "gezamenlijk" ;
lin cry_V2 = mkV2 cry_V ;
lin cry_V = mkV "huilen" | mkV "schreeuwen" | mkV "gillen" | mkV "krijsen" ;
lin potential_A = mkA "potentieel" | mkA "mogelijk" ;
lin broad_A = L.broad_A ;
lin exhibition_N = mkN "tentoonstelling" feminine | mkN "exhibitie" ;
lin experience_V2 = mkV2 (mkV "ervaren") | mkV2 (mkV "mee" (mkV "maken")) | mkV2 (mkV "beleven") | mkV2 (mkV "onder" gaan_V) | mkV2 (mkV "onder" vinden_V) ;
lin judge_N = mkN "rechter" masculine feminine ;
lin formal_A = mkA "formeel" ;
lin housing_N = mkN "huisvesting" | mkN "behuizing" ;
lin past_Prep = mkPrep "langs" | mkPrep "voorbij" ;
lin concern_V2 = mkV2 (mkV "betreffen") ;
lin freedom_N = mkN "vrijheid" feminine ;
lin gentleman_N = mkN "heer" masculine ;
lin attract_V2 = mkV2 (mkV "aandacht" trekken_V) | mkV2 trekken_V ;
lin explanation_N = mkN "uitleg" masculine ;
lin appoint_V3 = mkV3 (mkV "aan" (mkV "stellen")) | mkV3 (mkV "benoemen") ; ---- subcat
lin appoint_V2V = mkV2V (mkV "aan" (mkV "stellen")) | mkV2V (mkV "benoemen") ;
lin appoint_V2 = mkV2 (mkV "aan" (mkV "stellen")) | mkV2 (mkV "benoemen") ;
lin note_VS = mkVS note_V ;
lin note_V2 = mkV2 note_V ;
lin note_V = mkV "noteren" | mkV "op" (mkV "merken") ;
lin chief_A = mkA "hoofd" | mkA "chef" ;
lin total_N = mkN "totaal" neuter ;
lin lovely_A = mkA "heerlijk" | mkA "liefelijk" | mkA "lieflijk" | mkA "beminnelijk" ;
lin official_A = mkA "officieel" | mkA "ambtelijk" ;
lin date_V2 = mkV2 (mkV "dateren") ;
lin date_V = mkV "dateren" ; --- split mkV "daten" | mkV "uit" gaan_V ; to go on dates with someone
lin demonstrate_VS = mkVS demonstrate_V ;
lin demonstrate_V2 = mkV2 demonstrate_V ;
lin demonstrate_V = mkV "demonstreren" | mkV "laten" zien_V ;
lin construction_N = mkN "constructie" | mkN "bouw" ; --- possibly split this so you can include 'gebouw', a building
lin middle_N = mkN "midden" neuter | mkN "centrum" neuter ;
lin yard_N = mkN "erf" neuter ; --- possibly split for the distance measure, though there is no Dutch word for that
lin unable_A = mkA "onbekwaam" ;
lin acquire_V2 = mkV2 (fixprefixV "ver" werven_V) | mkV2 (fixprefixV "ver" krijgen_V) | mkV2 (mkV "op" doen_V) ;
lin surely_Adv = mkAdv "zeker" | mkAdv "vast" ;
lin crisis_N = mkN "crisis" feminine ;
lin propose_VV = mkVV propose_V ;
lin propose_VS = mkVS propose_V ;
lin propose_V2 = mkV2 propose_V ;
lin propose_V = mkV "voor" (mkV "stellen") ; ---- should this include proposing for marriage?
lin west_N = mkN "westen" neuter ;
lin impose_V2 = mkV2 impose_V ;
lin impose_V = mkV "op" (mkV "leggen") ;
lin market_V2 = mkV2 market_V ;
lin market_V = mkV "markten" | fixprefixV "ver" kopen_V ;
lin care_V = mkV "zorgen" ;
lin god_N = mkN "god" masculine | mkN "godheid" feminine ;
lin favour_N = mkN "gunst" ;
lin before_Adv = mkAdv "voor" | mkAdv "tevoren" | mkAdv "voorheen" ;
lin name_V3 = mkV3 (mkV "noemen") ;
lin name_V2 = mkV2 (mkV "noemen") ;
lin equal_A = mkA "gelijk" |mkA "identiek";
lin capacity_N = mkN "capaciteit" feminine ;
lin flat_N = mkN "flat" | mkN "appartement" ;
lin selection_N = mkN "selectie" | mkN "keuze" ;
lin alone_Adv = mkAdv "alleen" ;
lin football_N = mkN "voetbal" | mkN "voetbal" neuter ; ---- neuter when talking about the sport, utrum when talking about the ball, split?
lin victory_N = mkN "overwinning" feminine | mkN "zege" feminine ;
lin factory_N = L.factory_N ;
lin rural_A = mkA "landelijk" | mkA "plattelands" ;
lin twice_Adv = mkAdv "twee keer" | mkAdv "tweemaal" | mkAdv "twee maal";
lin sing_V2 = mkV2 (zingen_V) ;
lin sing_V = L.sing_V ;
lin whereas_Subj = mkSubj "overwegende" ; ---- no proper translation
lin own_V2 = mkV2 (fixprefixV "be" zitten_V) ;
lin head_V2 = mkV2 head_V ;
lin head_V = mkV "leiden" | mkV "koppen" ;
lin examination_N = mkN "examen" neuter | mkN "toets" masculine | mkN "proefwerk" neuter ; --- split mkN "onderzoek" ; investigation/research
lin deliver_V2 = mkV2 (mkV "af" (mkV "leveren")) ;
lin deliver_V = mkV "af" (mkV "leveren") ;
lin nobody_NP = S.nobody_NP ;
lin substantial_A = mkA "substantieel" ;
lin invite_V2V = mkV2V (mkV "uit" (mkV "nodigen")) ;
lin invite_V2 = mkV2 (mkV "uit" (mkV "nodigen")) ;
lin intention_N = mkN "opzet" neuter | mkN "voornemen" neuter ;
lin egg_N = L.egg_N ;
lin reasonable_A = mkA "redelijk" ;
lin onto_Prep = mkPrep "naar" ;
lin retain_V2 = mkV2 (fixprefixV "be" houden_V) ;
lin aircraft_N = mkN "vliegtuig" neuter ;
lin decade_N = mkN "decennium" neuter ;
lin cheap_A = mkA "goedkoop" | mkA "betaalbaar" ;
lin quiet_A = mkA "stil" | mkA "muisstil" ;
lin bright_A = mkA "helder" ;
lin contribute_V2 = mkV2 (mkV "bij" dragen_V) ;
lin contribute_V = mkV "bij" dragen_V ;
lin row_N = mkN "rij" feminine ;
lin search_N = mkN "zoektocht" | mkN "zoekactie" ;
lin limit_N = mkN "grens" ;
lin definition_N = mkN "definitie" ;
lin unemployment_N = mkN "werkloosheid" feminine ;
lin spread_V2 = mkV2 spread_V ;
lin spread_V = mkV "spreiden" | mkV "verspreiden" ; ---- END edits by EdG
lin mark_N = mkN "punt" neuter | mkN "score" feminine ; -- status=guess status=guess
lin flight_N = mkN "vlucht" feminine | mkN "vliegen" neuter ; -- status=guess status=guess
lin account_V2 = variants{} ; -- 
lin account_V = variants{} ; -- 
lin output_N = mkN "uitvoer" ; -- status=guess
lin last_V = mkV "duren" ; -- status=guess, src=wikt
lin tour_N = mkN "krachtdaad" utrum ; -- status=guess
lin address_N = mkN "adresbalk" masculine ; -- status=guess
lin immediate_A = mkA "direct" | mkA "onmiddellijk" ; -- status=guess status=guess
lin reduction_N = mkN "korting" | mkN "reductie" | mkN "vermindering" ; -- status=guess status=guess status=guess
lin interview_N = mkN "interview" neuter | mkN "vraaggesprek" ; -- status=guess status=guess
lin assess_V2 = mkV2 (mkV "beoordelen") | mkV2 (mkV "evalueren") ; -- status=guess, src=wikt status=guess, src=wikt
lin promote_V2 = mkV2 (mkV "promoten") | mkV2 (mkV (mkV "bekend") "maken") ; -- status=guess, src=wikt status=guess, src=wikt
lin promote_V = mkV "promoten" | mkV (mkV "bekend") "maken" ; -- status=guess, src=wikt status=guess, src=wikt
lin everybody_NP = S.everybody_NP ;
lin suitable_A = mkA "geschikt" ; -- status=guess
lin growing_A = mkA "groeiend" ; -- status=guess
lin nod_V = mkV "knikkebollen" ; -- status=guess, src=wikt
lin reject_V2 = mkV2 (mkV "verwerpen") ; -- status=guess, src=wikt
lin while_N = mkN "tijdje" neuter | mkN "momentje" neuter | mkN "een hele tijd" masculine | mkN "poosje" neuter ; -- status=guess status=guess status=guess status=guess
lin high_Adv = variants{} ; -- 
lin dream_N = mkN "droom" masculine | mkN "hoop" neuter ; -- status=guess status=guess
lin vote_VV = mkVV (mkV "stemmen") ; -- status=guess, src=wikt
lin vote_V3 = variants{}; -- mkV2 (mkV "stemmen") ; -- status=guess, src=wikt
lin vote_V2 = mkV2 (mkV "stemmen") ; -- status=guess, src=wikt
lin vote_V = mkV "stemmen" ; -- status=guess, src=wikt
lin divide_V2 = mkV2 (mkV (mkV "divide") "et impera") | mkV2 (mkV (mkV "deel") "en heers") | mkV2 (mkV (mkV "verdeel") "en heers") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin divide_V = mkV (mkV "divide") "et impera" | mkV (mkV "deel") "en heers" | mkV (mkV "verdeel") "en heers" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin declare_VS = mkVS (mkV "aangeven") ; -- status=guess, src=wikt
lin declare_V2 = mkV2 (mkV "aangeven") ; -- status=guess, src=wikt
lin declare_V = mkV "aangeven" ; -- status=guess, src=wikt
lin handle_V2 = mkV2 (mkV "omgaan") | mkV2 (reflMkV "bezighouden met") ; -- status=guess, src=wikt status=guess, src=wikt
lin handle_V = mkV "omgaan" | reflMkV "bezighouden met" ; -- status=guess, src=wikt status=guess, src=wikt
lin detailed_A = mkA "gedetailleerd" ; -- status=guess
lin challenge_N = mkN "uitdaging" ; -- status=guess
lin notice_N = variants{} ; -- 
lin rain_N = L.rain_N ;
lin destroy_V2 = mkV2 (mkV "vernielen") ; -- status=guess, src=wikt
lin mountain_N = L.mountain_N ;
lin concentration_N = mkN "concentratie" ; -- status=guess
lin limited_A = variants{} ; -- 
lin finance_N = mkN "financiering" feminine ; -- status=guess
lin pension_N = mkN "pensioen" ;
lin influence_V2 = mkV2 (mkV (mkV "invloed") "uitoefenen") ; -- status=guess, src=wikt
lin afraid_A = mkA "bang" | mkA "bevreesd" ; -- status=guess status=guess
lin murder_N = mkN "moord" feminine ; -- status=guess
lin neck_N = L.neck_N ;
lin weapon_N = mkN "wapen" neuter ; -- status=guess
lin hide_V2 = mkV2 (reflMkV "verbergen") | mkV2 (reflMkV "verstoppen") | mkV2 (reflMkV "wegstoppen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hide_V = reflMkV "verbergen" | reflMkV "verstoppen" | reflMkV "wegstoppen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin offence_N = variants{} ; -- 
lin absence_N = mkN "verstrooidheid" feminine ; -- status=guess
lin error_N = mkN "fout" | mkN "afwijking" ; -- status=guess status=guess
lin representativeMasc_N = mkN "vertegenwoordiger" masculine ; -- status=guess
lin enterprise_N = mkN "onderneming" feminine ; -- status=guess
lin criticism_N = mkN "kritiek" ; -- status=guess
lin average_A = mkA "gemiddelde" ; -- status=guess
lin quick_A = mkA "snel" | mkA "vlug" | mkA "rap" ; -- status=guess status=guess status=guess
lin sufficient_A = mkA "voldoende" ; -- status=guess
lin appointment_N = mkN "aanstelling" feminine ; -- status=guess
lin match_V2 = mkV2 (mkV "evenaren") ; -- status=guess, src=wikt
lin transfer_V = mkV "overplaatsen" | mkV "verplaatsen" ; -- status=guess, src=wikt status=guess, src=wikt
lin acid_N = mkN "zuur" neuter ; -- status=guess
lin spring_N = mkN "voorjaarsschoonmaak" ; -- status=guess
lin birth_N = mkN "geboorte" feminine ; -- status=guess
lin ear_N = L.ear_N ;
lin recognize_VS = mkVS (mkV "erkennen") ;
lin recognize_4_V2 = mkV2 (mkV "herkennen") ;
lin recognize_1_V2 = mkV2 (mkV "erkennen") ; ---- acknowledge
lin recommend_V2V = mkV2V (mkV (mkV "bevelen") "in ...") | mkV2V (mkV "aanbevelen") | mkV2V (mkV (mkV "overdragen") "aan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin recommend_V2 = mkV2 (mkV (mkV "bevelen") "in ...") | mkV2 (mkV "aanbevelen") | mkV2 (mkV (mkV "overdragen") "aan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin module_N = variants{} ; -- 
lin instruction_N = mkN "onderwijs" neuter ; -- status=guess
lin democratic_A = mkA "democratisch" ; -- status=guess
lin park_N = mkN "park" masculine ; -- status=guess
lin weather_N = mkN "weerballon" masculine ; -- status=guess
lin bottle_N = mkN "glasbak" masculine ; -- status=guess
lin address_V2 = mkV2 (mkV "tutoyeren") | mkV2 (mkV "jijen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bedroom_N = mkN "slaapkamer" feminine ; -- status=guess
lin kid_N = variants{} ; -- 
lin pleasure_N = mkN "genoegen" neuter | mkN "welbehagen" neuter | mkN "plezier" neuter ; -- status=guess status=guess status=guess
lin realize_VS = mkVS (mkV "beseffen") | mkVS (mkV "realiseren") | mkVS (mkV "in" zien_V) ;
lin realize_V2 = mkV2 (mkV "beseffen") | mkV2 (mkV "realiseren") | mkV2 (mkV "in" zien_V) ;
lin assembly_N = mkN "lopende band" masculine ; -- status=guess
lin expensive_A = mkA "duur" ; -- status=guess
lin select_VV = mkVV (mkV "uitkiezen") ; -- status=guess, src=wikt
lin select_V2V = mkV2V (mkV "uitkiezen") ; -- status=guess, src=wikt
lin select_V2 = mkV2 (mkV "uitkiezen") ; -- status=guess, src=wikt
lin select_V = mkV "uitkiezen" ; -- status=guess, src=wikt
lin teaching_N = mkN "onderwijzing" feminine ; -- status=guess
lin desire_N = mkN "verlangen" neuter | mkN "wens" masculine ; -- status=guess status=guess
lin whilst_Subj = variants{} ; -- 
lin contact_V2 = mkV2 (mkV "contacteren") ; -- status=guess, src=wikt
lin implication_N = mkN "implicatie" ; -- status=guess
lin combine_VV = mkVV (mkV "combineren") ; -- status=guess, src=wikt
lin combine_V2 = mkV2 (mkV "combineren") ; -- status=guess, src=wikt
lin combine_V = mkV "combineren" ; -- status=guess, src=wikt
lin temperature_N = mkN "temperatuur" feminine ; -- status=guess
lin wave_N = mkN "wave" masculine ; -- status=guess
lin magazine_N = mkN "magazijn" neuter ; -- status=guess
lin totally_Adv = mkAdv "volledig" | mkAdv "helemaal" | mkAdv "totaal" ; -- status=guess status=guess status=guess
lin mental_A = mkA "geestelijk" | mkA "mentaal" ; -- status=guess status=guess
lin used_A = mkA "gewend te" ; -- status=guess
lin store_N = mkN "magazijn" neuter ; -- status=guess
lin scientific_A = mkA "wetenschappelijk" ; -- status=guess
lin frequently_Adv = variants{} ; -- 
lin thanks_N = mkN "bedankt" ; -- status=guess
lin beside_Prep = variants{} ; -- 
lin settlement_N = mkN "nederzetting" feminine ; -- status=guess
lin absolutely_Adv = mkAdv "absoluut" ; -- status=guess
lin critical_A = mkA "kritiek" ; -- status=guess
lin critical_2_A = variants{} ; -- 
lin critical_1_A = variants{} ; -- 
lin recognition_N = mkN "erkenning" feminine ; -- status=guess
lin touch_N = mkN "detail" neuter ; -- status=guess
lin consist_V = mkV (mkV "bestaan") "uit" ; -- status=guess, src=wikt
lin below_Prep = variants{} ; -- 
lin silence_N = mkN "stilzwijgen" neuter ; -- status=guess
lin expenditure_N = variants{} ; -- 
lin institute_N = mkN "instituut" neuter ; -- status=guess
lin dress_V2 = mkV2 (mkV "kleden") | mkV2 (mkV "aankleden") ; -- status=guess, src=wikt status=guess, src=wikt
lin dress_V = mkV "kleden" | mkV "aankleden" ; -- status=guess, src=wikt status=guess, src=wikt
lin dangerous_A = mkA "gevaarlijk" | mkA "gevaarlijke" ; -- status=guess status=guess
lin familiar_A = mkA "vertrouwd" ; -- status=guess
lin asset_N = mkN "activa {p}" ; -- status=guess
lin educational_A = mkA "opvoedkundig" | mkA "onderwijskundig" ; -- status=guess status=guess
lin sum_N = mkN "rekensom" feminine | mkN "som" feminine ; -- status=guess status=guess
lin publication_N = mkN "publicatie" ; -- status=guess
lin partly_Adv = mkAdv "deels" | mkAdv "gedeeltelijk" ; -- status=guess status=guess
lin block_N = mkN "blok" neuter ; -- status=guess
lin seriously_Adv = variants{} ; -- 
lin youth_N = mkN "jeugdherberg" ; -- status=guess
lin tape_N = mkN "plakband" neuter ; -- status=guess
lin elsewhere_Adv = mkAdv "elders" | mkAdv "ergens anders" ; -- status=guess status=guess
lin cover_N = mkN "entree" | mkN "inkom" ; -- status=guess status=guess
lin fee_N = mkN "prijs" masculine | mkN "honorarium" neuter ; -- status=guess status=guess
lin program_N = mkN "programmablad" neuter | mkN "programmagids" masculine ; -- status=guess status=guess
lin treaty_N = mkN "verdrag" | mkN "overeenkomst" | mkN "traktaat" ; -- status=guess status=guess status=guess
lin necessarily_Adv = mkAdv "nodig" | mkAdv "noodzakelijk" | mkAdv "noodzakelijkerwijs" ; -- status=guess status=guess status=guess
lin unlikely_A = mkA "onwaarschijnlijk" ; -- status=guess
lin properly_Adv = variants{} ; -- 
lin guest_N = mkN "gast" masculine ; -- status=guess
lin code_N = mkN "wetboek" neuter ; -- status=guess
lin hill_N = L.hill_N ;
lin screen_N = mkN "beeldscherm" neuter ; -- status=guess
lin household_N = mkN "huisgod" masculine ; -- status=guess
lin sequence_N = variants{} ; -- 
lin correct_A = L.correct_A ;
lin female_A = mkA "vrouwelijk" ; -- status=guess
lin phase_N = mkN "fase" feminine ; -- status=guess
lin crowd_N = mkN "menigte" feminine | mkN "schare" masculine feminine | mkN "massa" ; -- status=guess status=guess status=guess
lin welcome_V2 = mkV2 (mkV "verwelkomen") | mkV2 (mkV (mkV "welkom") "heten") ; -- status=guess, src=wikt status=guess, src=wikt
lin metal_N = mkN "metaal" neuter ; -- status=guess
lin human_N = mkN "mens" masculine ; -- status=guess
lin widely_Adv = variants{} ; -- 
lin undertake_V2 = mkV2 (mkV "ondernemen") ; -- status=guess, src=wikt
lin cut_N = mkN "snit" ; -- status=guess
lin sky_N = L.sky_N ;
lin brain_N = mkN "verstand" masculine | mkN "intellect" neuter ; -- status=guess status=guess
lin expert_N = mkN "expert" ; -- status=guess
lin experiment_N = mkN "experiment" neuter | mkN "proef" feminine ; -- status=guess status=guess
lin tiny_A = mkA "klein" | mkA "minuscuul" ; -- status=guess status=guess
lin perfect_A = mkA "perfect" | mkA "perfecte" ; -- status=guess status=guess
lin disappear_V = mkV (mkV "laten") "verdwijnen" ; -- status=guess, src=wikt
lin initiative_N = mkN "initiatief" ; -- status=guess
lin assumption_N = mkN "Mariahemelvaart" masculine | mkN "hemelvaart" masculine ; -- status=guess status=guess
lin photograph_N = mkN "foto" feminine ; -- status=guess
lin ministry_N = mkN "ministerie" neuter | mkN "kabinet" neuter | mkN "regering" | mkN "gouvernement" neuter ; -- status=guess status=guess status=guess status=guess
lin congress_N = mkN "congres" neuter | mkN "conferentie" ; -- status=guess status=guess
lin transfer_N = mkN "overdracht" feminine ; -- status=guess
lin reading_N = mkN "lezing" feminine ; -- status=guess
lin scientist_N = mkN "wetenschapper" masculine ; -- status=guess
lin fast_Adv = mkAdv "snel" | mkAdv "vlug" ; -- status=guess status=guess
lin fast_A = mkA "snel" | mkA "vlug" | mkA "rap" | mkA "kwiek" | mkA "gezwind" ; -- status=guess status=guess status=guess status=guess status=guess
lin closely_Adv = mkAdv "dichtbij" ; -- status=guess
lin thin_A = L.thin_A ;
lin solicitorMasc_N = mkN "rechtskundig adviseur" masculine ; -- status=guess
lin secure_V2 = variants{} ; -- 
lin plate_N = mkN "plaat" feminine ; -- status=guess
lin pool_N = mkN "bekken" neuter ; -- status=guess
lin gold_N = L.gold_N ;
lin emphasis_N = mkN "klemtoon" masculine | mkN "beklemtoning" ; -- status=guess status=guess
lin recall_VS = mkVS (mkV "herinneren") ; -- status=guess, src=wikt
lin recall_V2 = mkV2 (mkV "herinneren") ; -- status=guess, src=wikt
lin shout_V2 = mkV2 (mkV "schreeuwen") ; -- status=guess, src=wikt
lin shout_V = mkV "schreeuwen" ; -- status=guess, src=wikt
lin generate_V2 = variants{} ; -- 
lin location_N = mkN "plaats" feminine | mkN "locatie" feminine ; -- status=guess status=guess
lin display_VS = variants{} ; -- 
lin display_V2 = variants{} ; -- 
lin heat_N = mkN "pikantheid" utrum ; -- status=guess
lin gun_N = mkN "vuurwapen" neuter | mkN "geweer" neuter ; -- status=guess status=guess
lin shut_V2 = mkV2 (sluiten_V) | mkV2 (mkV "dichtklappen") ; -- status=guess, src=wikt status=guess, src=wikt
lin journey_N = mkN "trip" feminine | mkN "trektocht" feminine | mkN "reis" feminine ; -- status=guess status=guess status=guess
lin imply_VS = mkVS (mkV "impliceren") | mkVS (mkV "inhouden") ; -- status=guess, src=wikt status=guess, src=wikt
lin imply_V2 = mkV2 (mkV "impliceren") | mkV2 (mkV "inhouden") ; -- status=guess, src=wikt status=guess, src=wikt
lin imply_V = mkV "impliceren" | mkV "inhouden" ; -- status=guess, src=wikt status=guess, src=wikt
lin violence_N = mkN "geweld" neuter ; -- status=guess
lin dry_A = L.dry_A ;
lin historical_A = mkA "geschiedkundig" | mkA "historisch" ; -- status=guess status=guess
lin step_V2 = mkV2 (gaan_V) ; -- status=guess, src=wikt
lin step_V = gaan_V ; -- status=guess, src=wikt
lin curriculum_N = mkN "curriculum" neuter | mkN "levensloop" masculine ; -- status=guess status=guess
lin noise_N = mkN "geluidsoverlast" feminine | mkN "geluidshinder" masculine | mkN "geluidsvervuiling" feminine ; -- status=guess status=guess status=guess
lin lunch_N = mkN "lunch" | mkN "middageten" neuter | mkN "middagmaal" neuter ; -- status=guess status=guess status=guess
lin fear_VS = L.fear_VS ;
lin fear_V2 = L.fear_V2 ;
lin fear_V = mkV "vrezen" ; -- status=guess, src=wikt
lin succeed_V2 = mkV2 (mkV "navolgen") | mkV2 (mkV "slagen") | mkV2 (mkV "lukken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin succeed_V = mkV "navolgen" | mkV "slagen" | mkV "lukken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fall_N = mkN "val" masculine ; -- status=guess
lin fall_2_N = variants{} ; -- 
lin fall_1_N = variants{} ; -- 
lin bottom_N = mkN "bil" ; -- status=guess
lin initial_A = mkA "initieel" | mkA "aanvankelijk" | mkA "begin-" | mkA "vroeg" ; -- status=guess status=guess status=guess status=guess
lin theme_N = mkN "thema" neuter ; -- status=guess
lin characteristic_N = mkN "trekje" neuter | mkN "karakteristiek" feminine ; -- status=guess status=guess
lin pretty_Adv = mkAdv "tamelijk" | mkAdv "nogal" | mkAdv "aardig" ; -- status=guess status=guess status=guess
lin empty_A = L.empty_A ;
lin display_N = variants{} ; -- 
lin combination_N = mkN "combinatie" feminine | mkN "verbinding" ; -- status=guess status=guess
lin interpretation_N = variants{} ; -- 
lin rely_V2 = variants{}; -- mkV (mkV "rekenen") "op" ; -- status=guess, src=wikt
lin rely_V = mkV (mkV "rekenen") "op" ; -- status=guess, src=wikt
lin escape_VS = mkVS (mkV (mkV "er") "vanaf komen") ; -- status=guess, src=wikt
lin escape_V2 = mkV2 (mkV (mkV "er") "vanaf komen") ; -- status=guess, src=wikt
lin escape_V = mkV (mkV "er") "vanaf komen" ; -- status=guess, src=wikt
lin score_V2 = mkV2 (mkV "scoren") ; -- status=guess, src=wikt
lin score_V = mkV "scoren" ; -- status=guess, src=wikt
lin justice_N = mkN "raadsheer" ; -- status=guess
lin upper_A = mkA "hoger" ; -- status=guess
lin tooth_N = L.tooth_N ;
lin organize_V2V = mkV2V (mkV "organiseren") ; -- status=guess, src=wikt
lin organize_V2 = mkV2 (mkV "organiseren") ; -- status=guess, src=wikt
lin cat_N = L.cat_N ;
lin tool_N = mkN "gereedschap" neuter | mkN "instrument" neuter ; -- status=guess status=guess
lin spot_N = mkN "spot" masculine | mkN "reclamespot" masculine ; -- status=guess status=guess
lin bridge_N = mkN "bridge" ; -- status=guess
lin double_A = variants{} ; -- 
lin direct_V2 = variants{} ; -- 
lin direct_V = variants{} ; -- 
lin conclude_VS = mkVS (mkV "besluiten") | mkVS (mkV "concluderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin conclude_V2 = mkV2 (mkV "besluiten") | mkV2 (mkV "concluderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin conclude_V = mkV "besluiten" | mkV "concluderen" ; -- status=guess, src=wikt status=guess, src=wikt
lin relative_A = mkA "relatief" ; -- status=guess
lin soldier_N = mkN "heilsoldaat" masculine | mkN "heilsoldate" feminine ; -- status=guess status=guess
lin climb_V2 = mkV2 (klimmen_V) ; -- status=guess, src=wikt
lin climb_V = klimmen_V ; -- status=guess, src=wikt
lin breath_N = mkN "adempauze" feminine | mkN "pauze" feminine ; -- status=guess status=guess
lin afford_V2V = variants{} ; -- 
lin afford_V2 = variants{} ; -- 
lin urban_A = mkA "stedelijk" | mkA "urbaan" | mkA "stads-" ; -- status=guess status=guess status=guess
lin nurse_N = mkN "verpleegster" feminine ; -- status=guess
lin narrow_A = L.narrow_A ;
lin liberal_A = mkA "vrijzinnig" ; -- status=guess
lin coal_N = mkN "kool" feminine ; -- status=guess
lin priority_N = variants{} ; -- 
lin wild_A = mkA "wild" ; -- status=guess
lin revenue_N = mkN "staatsinkomsten {p}" | mkN "overheidsinkomsten {p}" ; -- status=guess status=guess
lin membership_N = mkN "lidmaatschap" neuter ; -- status=guess
lin grant_N = mkN "toelage" ; -- status=guess
lin approve_V2 = mkV2 (mkV (mkV "instemmen") "met") ; -- status=guess, src=wikt
lin approve_V = mkV (mkV "instemmen") "met" ; -- status=guess, src=wikt
lin tall_A = mkA "hoog" ; -- status=guess
lin apparent_A = mkA "ogenschijnlijk" | mkA "klaar" | mkA "duidelijk" ; -- status=guess status=guess status=guess
lin faith_N = mkN "vertrouwen" neuter | mkN "geloof" neuter ; -- status=guess status=guess
lin under_Adv = variants{}; -- S.under_Prep ;
lin fix_V2 = variants{} ; -- 
lin fix_V = variants{} ; -- 
lin slow_A = mkA "traag" | mkA "langzaam" | mkA "sloom" ; -- status=guess status=guess status=guess
lin troop_N = variants{} ; -- 
lin motion_N = mkN "motie" feminine ; -- status=guess
lin leading_A = variants{} ; -- 
lin component_N = mkN "onderdeel" neuter ; -- status=guess
lin bloody_A = mkA "bloederig" | mkA "bloederige" ; -- status=guess status=guess
lin literature_N = mkN "literatuur" ; -- status=guess
lin conservative_A = variants{} ; -- 
lin variation_N = variants{} ; -- 
lin remind_V2 = mkV2 (mkV "herinneren") ; -- status=guess, src=wikt
lin inform_V2 = mkV2 (mkV "verklikken") ; -- status=guess, src=wikt
lin inform_V = mkV "verklikken" ; -- status=guess, src=wikt
lin alternative_N = variants{} ; -- 
lin neither_Adv = mkAdv "ook niet" | mkAdv "evenmin" ; -- status=guess status=guess
lin outside_Adv = mkAdv "buiten" ; -- status=guess
lin mass_N = mkN "massa" feminine | mkN "hoeveelheid" feminine ; -- status=guess status=guess
lin busy_A = mkA "druk" ; -- status=guess
lin chemical_N = mkN "verslavend middel" neuter ; -- status=guess
lin careful_A = mkA "voorzichtig" | mkA "behoedzaam" | mkA "omzichtig" | mkA "prudent" ; -- status=guess status=guess status=guess status=guess
lin investigate_V2 = mkV2 (mkV (mkV "een") "onderzoek voeren") ; -- status=guess, src=wikt
lin investigate_V = mkV (mkV "een") "onderzoek voeren" ; -- status=guess, src=wikt
lin roll_V2 = mkV2 (mkV (mkV "overkop") "gaan") ; -- status=guess, src=wikt
lin roll_V = mkV (mkV "overkop") "gaan" ; -- status=guess, src=wikt
lin instrument_N = mkN "instrument" neuter | mkN "meetinstrument" neuter | mkN "meter" masculine ; -- status=guess status=guess status=guess
lin guide_N = mkN "gids" ; -- status=guess
lin criterion_N = mkN "criterium" neuter ; -- status=guess
lin pocket_N = mkN "zak" masculine ; -- status=guess
lin suggestion_N = mkN "voorstel" neuter ; -- status=guess
lin aye_Interj = variants{} ; -- 
lin entitle_VS = variants{} ; -- 
lin entitle_V2V = variants{} ; -- 
lin tone_N = mkN "toon" | mkN "timbre" ; -- status=guess status=guess
lin attractive_A = variants{} ; -- 
lin wing_N = L.wing_N ;
lin surprise_N = mkN "verrassings-" | mkN "verrassend" | mkN "onverwacht" ; -- status=guess status=guess status=guess
lin male_N = mkN "mannetje" neuter | mkN "mannetjesdier" ; -- status=guess status=guess
lin ring_N = mkN "ring" masculine ; -- status=guess
lin pub_N = mkN "kroeg" feminine ; -- status=guess
lin fruit_N = L.fruit_N ;
lin passage_N = variants{} ; -- 
lin illustrate_VS = variants{} ; -- 
lin illustrate_V2 = variants{} ; -- 
lin illustrate_V = variants{} ; -- 
lin pay_N = mkN "beloning" feminine ; -- status=guess
lin ride_V2 = mkV2 (mkV (mkV "met") "de voeten treden") ; -- status=guess, src=wikt
lin ride_V = mkV (mkV "met") "de voeten treden" ; -- status=guess, src=wikt
lin foundation_N = mkN "stichting" feminine ; -- status=guess
lin restaurant_N = L.restaurant_N ;
lin vital_A = mkA "essentieel" ; -- status=guess
lin alternative_A = mkA "alternatief" ; -- status=guess
lin burn_V2 = mkV2 (mkV "branden") | mkV2 (mkV "verbranden") | mkV2 (mkV "verteren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin burn_V = L.burn_V ;
lin map_N = mkN "stadsplan" neuter ; -- status=guess
lin united_A = mkA "verenigd" ; -- status=guess
lin device_N = mkN "toestel" | mkN "apparaat" ; -- status=guess status=guess
lin jump_V2 = mkV2 (springen_V) ; -- status=guess, src=wikt
lin jump_V = L.jump_V ;
lin estimate_VS = mkVS (mkV "schatten") ; -- status=guess, src=wikt
lin estimate_V2V = mkV2V (mkV "schatten") ; -- status=guess, src=wikt
lin estimate_V2 = mkV2 (mkV "schatten") ; -- status=guess, src=wikt
lin estimate_V = mkV "schatten" ; -- status=guess, src=wikt
lin conduct_V2 = mkV2 (mkV "geleiden") ; -- status=guess, src=wikt
lin conduct_V = mkV "geleiden" ; -- status=guess, src=wikt
lin derive_V2 = mkV2 (mkV "afleiden") ; -- status=guess, src=wikt
lin derive_V = mkV "afleiden" ; -- status=guess, src=wikt
lin comment_VS = mkVS (mkV "becommentariëren") ; -- status=guess, src=wikt
lin comment_V2 = mkV2 (mkV "becommentariëren") ; -- status=guess, src=wikt
lin comment_V = mkV "becommentariëren" ; -- status=guess, src=wikt
lin east_N = mkN "oosten" neuter ; -- status=guess
lin advise_VS = mkVS (mkV "adviseren") | mkVS (mkV "raadgeven") | mkVS (mkV (mkV "advies") "geven") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin advise_V2 = mkV2 (mkV "adviseren") | mkV2 (mkV "raadgeven") | mkV2 (mkV (mkV "advies") "geven") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin advise_V = mkV "adviseren" | mkV "raadgeven" | mkV (mkV "advies") "geven" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin advance_N = mkN "voorschot" neuter | mkN "vooruitbetaling" feminine | mkN "voorschot" neuter ; -- status=guess status=guess status=guess
lin motor_N = mkN "motor" masculine ; -- status=guess
lin satisfy_V2 = mkV2 (mkV "voldoen") | mkV2 (mkV (mkV "voldoende") "zijn") | mkV2 (mkV "bevredigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hell_N = mkN "hel" ; -- status=guess
lin winner_N = mkN "winnaar" masculine | mkN "winnares" feminine ; -- status=guess status=guess
lin effectively_Adv = variants{} ; -- 
lin mistake_N = mkN "fout" feminine | mkN "misverstand" neuter | mkN "blunder" masculine | mkN "vergissing" feminine | mkN "onjuistheid" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin incident_N = mkN "incident" neuter | mkN "voorval" neuter ; -- status=guess status=guess
lin focus_V2 = variants{} ; -- 
lin focus_V = variants{} ; -- 
lin exercise_VV = variants{} ; -- 
lin exercise_V2 = variants{} ; -- 
lin exercise_V = variants{} ; -- 
lin representation_N = mkN "weergave" ; -- status=guess
lin release_N = variants{} ; -- 
lin leaf_N = L.leaf_N ;
lin border_N = mkN "border" masculine ; -- status=guess
lin wash_V2 = L.wash_V2 ;
lin wash_V = wassen_V ; -- status=guess, src=wikt
lin prospect_N = mkN "vooruitzicht" neuter ; -- status=guess
lin blow_V2 = mkV2 (mkV (mkV "stoom") "afblazen") ; -- status=guess, src=wikt
lin blow_V = L.blow_V ;
lin trip_N = mkN "tocht" masculine ; -- status=guess
lin observation_N = mkN "waarneming" feminine ; -- status=guess
lin gather_V2 = mkV2 (mkV "verzamelen") | mkV2 (mkV "bijeenkomen") ; -- status=guess, src=wikt status=guess, src=wikt
lin gather_V = mkV "verzamelen" | mkV "bijeenkomen" ; -- status=guess, src=wikt status=guess, src=wikt
lin ancient_A = mkA "eeuwenoud" | mkA "oeroud" | mkA "eertijds" | mkA "weleers" ; -- status=guess status=guess status=guess status=guess
lin brief_A = mkA "kort" | mkA "bondig" | mkA "samengevat" ; -- status=guess status=guess status=guess
lin gate_N = mkN "poort" utrum ; -- status=guess
lin elderly_A = mkA "bejaard" ; -- status=guess
lin persuade_V2V = mkV2V (mkV "overtuigen") | mkV2V (mkV "overhalen") | mkV2V (mkV "overreden") | mkV2V (mkV "persuaderen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin persuade_V2 = mkV2 (mkV "overtuigen") | mkV2 (mkV "overhalen") | mkV2 (mkV "overreden") | mkV2 (mkV "persuaderen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin overall_A = mkA "globaal" ; -- status=guess
lin rare_A = mkA "bloedig" | mkA "bloedige" | mkA "saignant" ; -- status=guess status=guess status=guess
lin index_N = mkN "inhoud" masculine | mkN "index" masculine | mkN "register" neuter ; -- status=guess status=guess status=guess
lin hand_V2 = mkV2 (mkV "overleveren") ; -- status=guess, src=wikt
lin circle_N = mkN "kring" ; -- status=guess
lin creation_N = mkN "creatie" feminine | mkN "schepping" feminine ; -- status=guess status=guess
lin drawing_N = mkN "tekenen" neuter ; -- status=guess
lin anybody_NP = variants{} ; -- 
lin flow_N = mkN "een zijn met" ; -- status=guess
lin matter_V = mkV (mkV "belangrijk") "zijn" | mkV (mkV "er") "toe doen" ; -- status=guess, src=wikt status=guess, src=wikt
lin external_A = mkA "uiterlijk" | mkA "uitwendig" ; -- status=guess status=guess
lin capable_A = mkA "bekwaam" ; -- status=guess
lin recover_V = mkV "herstellen" | mkV (mkV "beter") "worden" | genezen_V | mkV "recupereren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shot_N = mkN "kogel" masculine ; -- status=guess
lin request_N = mkN "verzoek" neuter | mkN "vraag" feminine ; -- status=guess status=guess
lin impression_N = mkN "impressie" | mkN "uitbeelding" | mkN "verbeelding" ; -- status=guess status=guess status=guess
lin neighbour_N = mkN "buur" | mkN "buurman" masculine | mkN "buurvrouw" feminine | mkN "buren {p}" ; -- status=guess status=guess status=guess status=guess
lin theatre_N = variants{} ; -- 
lin beneath_Prep = variants{} ; -- 
lin hurt_V2 = mkV2 (mkV (mkV "pijn") "doen") | mkV2 (mkV (mkV "zeer") "doen") ; -- status=guess, src=wikt status=guess, src=wikt
lin hurt_V = mkV (mkV "pijn") "doen" | mkV (mkV "zeer") "doen" ; -- status=guess, src=wikt status=guess, src=wikt
lin mechanism_N = mkN "mechanisme" neuter ; -- status=guess
lin potential_N = variants{} ; -- 
lin lean_V2 = mkV2 (mkV "leunen") ; -- status=guess, src=wikt
lin lean_V = mkV "leunen" ; -- status=guess, src=wikt
lin defendant_N = variants{} ; -- 
lin atmosphere_N = mkN "atmosfeer" masculine ; -- status=guess
lin slip_V2 = mkV2 (mkV "falen") ; -- status=guess, src=wikt
lin slip_V = mkV "falen" ; -- status=guess, src=wikt
lin chain_N = mkN "kettingbrief" masculine ; -- status=guess
lin accompany_V2 = mkV2 (mkV "samenwonen") ; -- status=guess, src=wikt
lin wonderful_A = mkA "fantastisch" | mkA "heerlijk" ; -- status=guess status=guess
lin earn_V2 = variants{} ; -- 
lin earn_V = variants{} ; -- 
lin enemy_N = L.enemy_N ;
lin desk_N = mkN "bureau" neuter | mkN "schrijftafel" feminine | mkN "schrijfberd" neuter ; -- status=guess status=guess status=guess
lin engineering_N = mkN "ingenieurswetenschap" feminine ; -- status=guess
lin panel_N = mkN "forum" ; -- status=guess
lin distinction_N = variants{} ; -- 
lin deputy_N = mkN "adjudant" masculine | mkN "adjudante" feminine ; -- status=guess status=guess
lin discipline_N = mkN "discipline" | mkN "branche" | mkN "tak" ; -- status=guess status=guess status=guess
lin strike_N = mkN "staking" ; -- status=guess
lin strike_2_N = variants{} ; -- 
lin strike_1_N = variants{} ; -- 
lin married_A = mkA "getrouwd" ; -- status=guess
lin plenty_NP = variants{} ; -- 
lin establishment_N = mkN "vestiging" | mkN "bestel" neuter ; -- status=guess status=guess
lin fashion_N = mkN "mode" ; -- status=guess
lin roof_N = L.roof_N ;
lin milk_N = L.milk_N ;
lin entire_A = variants{} ; -- 
lin tear_N = mkN "traan" ; -- status=guess
lin secondary_A = mkA "plaatsvervangend" | mkA "plaatsvervangende" ; -- status=guess status=guess
lin finding_N = mkN "vinding" feminine ; -- status=guess
lin welfare_N = variants{} ; -- 
lin increased_A = variants{} ; -- 
lin attach_V2 = mkV2 (mkV "vastmaken") ; -- status=guess, src=wikt
lin attach_V = mkV "vastmaken" ; -- status=guess, src=wikt
lin typical_A = mkA "typisch" ; -- status=guess
lin typical_3_A = variants{} ; -- 
lin typical_2_A = variants{} ; -- 
lin typical_1_A = variants{} ; -- 
lin meanwhile_Adv = mkAdv "intussen" ; -- status=guess
lin leadership_N = mkN "voorzitterschap" neuter ; -- status=guess
lin walk_N = mkN "wandeling" feminine ; -- status=guess
lin negotiation_N = mkN "onderhandeling" feminine ; -- status=guess
lin clean_A = L.clean_A ;
lin religion_N = L.religion_N ;
lin count_V2 = L.count_V2 ;
lin count_V = mkV "tellen" ; -- status=guess, src=wikt
lin grey_A = mkA "grijsharig" ; -- status=guess
lin hence_Adv = mkAdv "derhalve" | mkAdv "dus" | mkAdv "bijgevolg" ; -- status=guess status=guess status=guess
lin alright_Adv = variants{} ; -- 
lin first_A = mkA "eerst" ; -- status=guess
lin fuel_N = mkN "brandstof" masculine feminine ; -- status=guess
lin mine_N = mkN "mijn" feminine ; -- status=guess
lin appeal_V2 = mkV2 (mkV (mkV "in") "beroep gaan") | mkV2 (mkV (mkV "in") "hoger beroep gaan") ; -- status=guess, src=wikt status=guess, src=wikt
lin appeal_V = mkV (mkV "in") "beroep gaan" | mkV (mkV "in") "hoger beroep gaan" ; -- status=guess, src=wikt status=guess, src=wikt
lin servantMasc_N = mkN "hulp" | mkN "hulpje" | mkN "huishoudhulp" | mkN "bediende" | mkN "knecht" masculine | mkN "meid" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin liability_N = mkN "aansprakelijkheid" feminine ; -- status=guess
lin constant_A = mkA "constant" ; -- status=guess
lin hate_VV = mkVV (mkV "haten") ; -- status=guess, src=wikt
lin hate_V2 = L.hate_V2 ;
lin shoe_N = L.shoe_N ;
lin expense_N = variants{} ; -- 
lin vast_A = mkA "enorm" ; -- status=guess
lin soil_N = mkN "grond" ; -- status=guess
lin writing_N = mkN "schrijfsel" neuter | mkN "werk" neuter | mkN "oeuvre" neuter ; -- status=guess status=guess status=guess
lin nose_N = L.nose_N ;
lin origin_N = mkN "oorsprong" masculine | mkN "afkomst" feminine | mkN "herkomst" feminine ; -- status=guess status=guess status=guess
lin lord_N = mkN "landheer" masculine ; -- status=guess
lin rest_V2 = mkV2 (mkV (mkV "daarbij") "laten") ; -- status=guess, src=wikt
lin drive_N = variants{} ; -- 
lin ticket_N = mkN "kaartje" | mkN "ticket" ; -- status=guess status=guess
lin editor_N = mkN "redacteur" masculine | mkN "krantenredacteur" masculine ; -- status=guess status=guess
lin switch_V2 = mkV2 (mkV "uitzetten") ; -- status=guess, src=wikt
lin switch_V = mkV "uitzetten" ; -- status=guess, src=wikt
lin provided_Subj = variants{} ; -- 
lin northern_A = mkA "noordelijk" ; -- status=guess
lin significance_N = mkN "betekenis" | mkN "belang" feminine | mkN "importantie" feminine ; -- status=guess status=guess status=guess
lin channel_N = mkN "kanaal" neuter | mkN "zender" masculine ; -- status=guess status=guess
lin convention_N = mkN "conventie" feminine | mkN "overeenkomst" ; -- status=guess status=guess
lin damage_V2 = mkV2 (mkV "beschadigen") ; -- status=guess, src=wikt
lin funny_A = mkA "grappig" ; -- status=guess
lin bone_N = L.bone_N ;
lin severe_A = mkA "streng" ; -- status=guess
lin search_V2 = mkV2 (mkV "afzoeken") | mkV2 (mkV "doorzoeken") | mkV2 (zoeken_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin search_V = mkV "afzoeken" | mkV "doorzoeken" | zoeken_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin iron_N = L.iron_N ;
lin vision_N = mkN "visioen" neuter ; -- status=guess
lin via_Prep = variants{} ; -- 
lin somewhat_Adv = mkAdv "ietwat" | mkAdv "een beetje" | mkAdv "enigszins" ; -- status=guess status=guess status=guess
lin inside_Adv = mkAdv "binnenstebuiten" ; -- status=guess
lin trend_N = mkN "trend" | mkN "rage" ; -- status=guess status=guess
lin revolution_N = mkN "revolutie" feminine ; -- status=guess
lin terrible_A = mkA "afschuwelijk" ; -- status=guess
lin knee_N = L.knee_N ;
lin dress_N = mkN "kledij" feminine | mkN "kleding" feminine ; -- status=guess status=guess
lin unfortunately_Adv = mkAdv "helaas" | mkAdv "jammer genoeg" ; -- status=guess status=guess
lin steal_V2 = mkV2 (stelen_V) ; -- status=guess, src=wikt
lin steal_V = stelen_V ; -- status=guess, src=wikt
lin criminal_A = mkA "misdadig" | mkA "crimineel" ; -- status=guess status=guess
lin signal_N = mkN "sein" neuter ; -- status=guess
lin notion_N = mkN "notie" feminine | mkN "besef" ; -- status=guess status=guess
lin comparison_N = mkN "vergelijking" feminine ; -- status=guess
lin academic_A = mkA "academisch" | mkA "universitair" ; -- status=guess status=guess
lin outcome_N = mkN "uitkomst" feminine ; -- status=guess
lin lawyer_N = mkN "pleiter" masculine | mkN "raadsman" masculine | mkN "informally also advocaat" masculine ; -- status=guess status=guess status=guess
lin strongly_Adv = variants{} ; -- 
lin surround_V2 = mkV2 (mkV "omgeven") | mkV2 (mkV "omringen") | mkV2 (mkV "omcirkelen") | mkV2 (mkV "omsingelen") | mkV2 (mkV "insluiten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin explore_VS = mkVS (mkV "verkennen") | mkVS (mkV "exploreren") ; -- status=guess, src=wikt status=guess, src=wikt
lin explore_V2 = mkV2 (mkV "verkennen") | mkV2 (mkV "exploreren") ; -- status=guess, src=wikt status=guess, src=wikt
lin achievement_N = mkN "prestatie" feminine ; -- status=guess
lin odd_A = mkA "bij benadering" | mkA "ongeveer" ; -- status=guess status=guess
lin expectation_N = mkN "verwachting" feminine | mkN "afwachting" feminine ; -- status=guess status=guess
lin corporate_A = variants{} ; -- 
lin prisoner_N = mkN "gevangene" masculine feminine ; -- status=guess
lin question_V2 = mkV2 (mkV "ondervragen") ; -- status=guess, src=wikt
lin rapidly_Adv = variants{} ; -- 
lin deep_Adv = variants{} ; -- 
lin southern_A = mkA "zuiders" ; -- status=guess
lin amongst_Prep = variants{} ; -- 
lin withdraw_V2 = mkV2 (mkV "afhalen") | mkV2 (mkV "pinnen") | mkV2 (mkV "opnemen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin withdraw_V = mkV "afhalen" | mkV "pinnen" | mkV "opnemen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin afterwards_Adv = mkAdv "nadien" | mkAdv "achteraf" ; -- status=guess status=guess
lin paint_V2 = mkV2 (mkV "verven") | mkV2 (mkV "schilderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin paint_V = mkV "verven" | mkV "schilderen" ; -- status=guess, src=wikt status=guess, src=wikt
lin judge_VS = mkVS (mkV "oordelen") | mkVS (mkV "bemiddelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin judge_V2 = mkV2 (mkV "oordelen") | mkV2 (mkV "bemiddelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin judge_V = mkV "oordelen" | mkV "bemiddelen" ; -- status=guess, src=wikt status=guess, src=wikt
lin citizenMasc_N = mkN "burger" masculine | mkN "particulier" masculine ; -- status=guess status=guess
lin permanent_A = mkA "bestendig" | mkA "voorgoed" | mkA "eeuwig" | mkA "permanent" ; -- status=guess status=guess status=guess status=guess
lin weak_A = mkA "flauw" ; -- status=guess
lin separate_V2 = mkV2 (scheiden_V) ; -- status=guess, src=wikt
lin separate_V = scheiden_V ; -- status=guess, src=wikt
lin plastic_N = L.plastic_N ;
lin connect_V2 = mkV2 (mkV "aansluiten") | mkV2 (mkV "verbinden") ; -- status=guess, src=wikt status=guess, src=wikt
lin connect_V = mkV "aansluiten" | mkV "verbinden" ; -- status=guess, src=wikt status=guess, src=wikt
lin fundamental_A = mkA "fundamenteel" ; -- status=guess
lin plane_N = mkN "schaaf" ; -- status=guess
lin height_N = mkN "hoogte" ; -- status=guess
lin opening_N = mkN "openingsceremonie" ; -- status=guess
lin lesson_N = mkN "les" ; -- status=guess
lin similarly_Adv = variants{} ; -- 
lin shock_N = mkN "schok" ; -- status=guess
lin rail_N = mkN "rail" utrum ; -- status=guess
lin tenant_N = mkN "bewoner" masculine | mkN "huurder" masculine ; -- status=guess status=guess
lin owe_V2 = mkV2 (mkV (mkV "schuldig") "zijn") ; -- status=guess, src=wikt
lin owe_V = mkV (mkV "schuldig") "zijn" ; -- status=guess, src=wikt
lin originally_Adv = mkAdv "indertijd" ; -- status=guess
lin middle_A = mkA "midden" ; -- status=guess
lin somehow_Adv = mkAdv "op een of andere manier" | mkAdv "eenderhoe" ; -- status=guess status=guess
lin minor_A = mkA "onbelangrijk" ; -- status=guess
lin negative_A = mkA "negatief" | mkA "min" ; -- status=guess status=guess
lin knock_V2 = mkV2 (mkV "rondzwerven") ; -- status=guess, src=wikt
lin knock_V = mkV "rondzwerven" ; -- status=guess, src=wikt
lin root_N = L.root_N ;
lin pursue_V2 = mkV2 (mkV "najagen") ; -- status=guess, src=wikt
lin pursue_V = mkV "najagen" ; -- status=guess, src=wikt
lin inner_A = variants{} ; -- 
lin crucial_A = variants{} ; -- 
lin occupy_V2 = mkV2 (mkV "bezetten") ; -- status=guess, src=wikt
lin occupy_V = mkV "bezetten" ; -- status=guess, src=wikt
lin that_AdA = variants{} ; -- 
lin independence_N = mkN "zelfstandigheid" feminine | mkN "onafhankelijkheid" feminine ; -- status=guess status=guess
lin column_N = mkN "colonne" feminine ; -- status=guess
lin proceeding_N = variants{} ; -- 
lin female_N = mkN "vrouw" feminine ; -- status=guess
lin beauty_N = mkN "schoonheid" | mkN "schone" feminine ; -- status=guess status=guess
lin perfectly_Adv = mkAdv "perfect" ; -- status=guess
lin struggle_N = mkN "gevecht" | mkN "strijd" ; -- status=guess status=guess
lin gap_N = variants{} ; -- 
lin house_V2 = mkV2 (mkV "onderbrengen") ; -- status=guess, src=wikt
lin database_N = mkN "database" | mkN "databank" feminine ; -- status=guess status=guess
lin stretch_V2 = mkV2 (mkV "rekken") ; -- status=guess, src=wikt
lin stretch_V = mkV "rekken" ; -- status=guess, src=wikt
lin stress_N = mkN "spanning" | mkN "zenuwen" ; -- status=guess status=guess
lin passenger_N = mkN "passagier" masculine feminine ; -- status=guess
lin boundary_N = mkN "grens" ; -- status=guess
lin easy_Adv = variants{} ; -- 
lin view_V2 = mkV2 (mkV "bekijken") | mkV2 (mkV (mkV "kijken") "naar") ; -- status=guess, src=wikt status=guess, src=wikt
lin manufacturer_N = mkN "fabrikant" ; -- status=guess
lin sharp_A = L.sharp_A ;
lin formation_N = mkN "rotsformatie" feminine ; -- status=guess
lin queen_N = L.queen_N ;
lin waste_N = mkN "wegkwijning" | mkN "verval" ; -- status=guess status=guess
lin virtually_Adv = mkAdv "praktisch" ; -- status=guess
lin expand_V2 = mkV2 (mkV (mkV "uitbonden") "worden") ; -- status=guess, src=wikt
lin expand_V = mkV (mkV "uitbonden") "worden" ; -- status=guess, src=wikt
lin contemporary_A = mkA "gelijktijdig" | mkA "eigentijds" | mkA "contemporain" ; -- status=guess status=guess status=guess
lin politician_N = mkN "politicus" masculine | mkN "politica" feminine ; -- status=guess status=guess
lin back_V = reflV (mkV "terugtrekken") ;
lin territory_N = mkN "grondgebied" neuter | mkN "territorium" neuter ; -- status=guess status=guess
lin championship_N = mkN "kampioenschap" neuter ; -- status=guess
lin exception_N = mkN "uitzondering" ; -- status=guess
lin thick_A = L.thick_A ;
lin inquiry_N = variants{} ; -- 
lin topic_N = mkN "onderwerp" ; -- status=guess
lin resident_N = variants{} ; -- 
lin transaction_N = mkN "transactie" ; -- status=guess
lin parish_N = mkN "parochianen" ; -- status=guess
lin supporter_N = variants{} ; -- 
lin massive_A = mkA "massief" ; -- status=guess
lin light_V2 = mkV2 (mkV "lichten") | mkV2 (mkV "bijlichten") ; -- status=guess, src=wikt status=guess, src=wikt
lin light_V = mkV "lichten" | mkV "bijlichten" ; -- status=guess, src=wikt status=guess, src=wikt
lin unique_A = mkA "uniek" ; -- status=guess
lin challenge_V2 = mkV2 (mkV "uitdagen") ; -- status=guess, src=wikt
lin challenge_V = mkV "uitdagen" ; -- status=guess, src=wikt
lin inflation_N = mkN "opblazen" neuter ; -- status=guess
lin assistance_N = mkN "hulp" feminine | mkN "assistentie" feminine ; -- status=guess status=guess
lin list_V2V = variants{} ; -- 
lin list_V2 = variants{} ; -- 
lin list_V = variants{} ; -- 
lin identity_N = mkN "identiteit" feminine ; -- status=guess
lin suit_V2 = variants{} ; -- 
lin suit_V = variants{} ; -- 
lin parliamentary_A = variants{} ; -- 
lin unknown_A = mkA "onbekend" | mkA "ongekend" | mkA "ongeweten" ; -- status=guess status=guess status=guess
lin preparation_N = mkN "voorbereiding" feminine ; -- status=guess
lin elect_V3 = variants{} ; -- 
lin elect_V2V = variants{} ; -- 
lin elect_V2 = variants{} ; -- 
lin elect_V = variants{} ; -- 
lin badly_Adv = variants{} ; -- 
lin moreover_Adv = mkAdv "bovendien" ; -- status=guess
lin tie_V2 = L.tie_V2 ;
lin tie_V = mkV "knopen" | mkV "vastknopen" | binden_V | mkV "strikken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cancer_N = mkN "kanker" ; -- status=guess
lin champion_N = mkN "voorvechter" masculine ; -- status=guess
lin exclude_V2 = variants{} ; -- 
lin review_V2 = variants{} ; -- 
lin review_V = variants{} ; -- 
lin licence_N = variants{} ; -- 
lin breakfast_N = mkN "ontbijt" neuter ; -- status=guess
lin minority_N = mkN "minderheidsregering" feminine | mkN "minderheidskabinet" neuter ; -- status=guess status=guess
lin appreciate_V2 = mkV2 (mkV "beseffen") ; -- status=guess, src=wikt
lin appreciate_V = mkV "beseffen" ; -- status=guess, src=wikt
lin fan_N = mkN "fan" masculine feminine | mkN "bewonderaar" masculine | mkN "bewonderaarster" feminine | mkN "liefhebber" ; -- status=guess status=guess status=guess status=guess
lin fan_3_N = variants{} ; -- 
lin fan_2_N = variants{} ; -- 
lin fan_1_N = variants{} ; -- 
lin chief_N = mkN "oppergod" masculine ; -- status=guess
lin accommodation_N = mkN "accommodatie" feminine ; -- status=guess
lin subsequent_A = mkA "volgend" | mkA "subsequent" ;
lin democracy_N = mkN "democratie" feminine ; -- status=guess
lin brown_A = L.brown_A ;
lin taste_N = mkN "smaak" masculine ; -- status=guess
lin crown_N = mkN "kroon" ; -- status=guess
lin permit_V2V = variants{} ; -- 
lin permit_V2 = variants{} ; -- 
lin permit_V = variants{} ; -- 
lin buyerMasc_N = mkN "koper" masculine | mkN "aankoper" masculine | mkN "inkoper" masculine | mkN "klant" masculine feminine ; -- status=guess status=guess status=guess status=guess
lin gift_N = mkN "gave" feminine ; -- status=guess
lin resolution_N = mkN "resolutie" feminine | mkN "beeldkwaliteit" | mkN "beeldscherpte" ; -- status=guess status=guess status=guess
lin angry_A = mkA "kwaad" | mkA "boos" ; -- status=guess status=guess
lin metre_N = mkN "meter" masculine ; -- status=guess
lin wheel_N = mkN "wiel" neuter ; -- status=guess
lin clause_N = mkN "bijzin" masculine ; -- status=guess
lin break_N = mkN "inbraak" utrum ; -- status=guess
lin tank_N = mkN "vat" neuter | mkN "tank" masculine ; -- status=guess status=guess
lin benefit_V2 = variants{} ; -- 
lin benefit_V = variants{} ; -- 
lin engage_V2 = mkV2 (mkV "verloven") ; -- status=guess, src=wikt
lin engage_V = mkV "verloven" ; -- status=guess, src=wikt
lin alive_A = mkA "levend" ; -- status=guess
lin complaint_N = mkN "klacht" masculine ; -- status=guess
lin inch_N = mkN "duim" masculine ; -- status=guess
lin firm_A = variants{} ; -- 
lin abandon_V2 = mkV2 (mkV "verzaken") | mkV2 (mkV "verlaten") | mkV2 (mkV "begeven") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin blame_V2 = mkV2 (mkV "beschuldigen") | mkV2 (mkV "verwijten") | mkV2 (wijten_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin blame_V = mkV "beschuldigen" | mkV "verwijten" | wijten_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin clean_V2 = mkV2 (mkV "poetsen") | mkV2 (mkV "schoonmaken") ; -- status=guess, src=wikt status=guess, src=wikt
lin clean_V = mkV "poetsen" | mkV "schoonmaken" ; -- status=guess, src=wikt status=guess, src=wikt
lin quote_V2 = mkV2 (mkV "quoteren") ; -- status=guess, src=wikt
lin quote_V = mkV "quoteren" ; -- status=guess, src=wikt
lin quantity_N = mkN "hoeveelheid" feminine | mkN "kwantiteit" feminine ; -- status=guess status=guess
lin rule_VS = mkVS (mkV "regeren") ; -- status=guess, src=wikt
lin rule_V2 = mkV2 (mkV "regeren") ; -- status=guess, src=wikt
lin rule_V = mkV "regeren" ; -- status=guess, src=wikt
lin guilty_A = variants{} ; -- 
lin prior_A = variants{} ; -- 
lin round_A = L.round_A ;
lin eastern_A = mkA "oostelijk" ; -- status=guess
lin coat_N = L.coat_N ;
lin involvement_N = mkN "betrokkenheid" ; -- status=guess
lin tension_N = mkN "spanning" feminine ; -- status=guess
lin diet_N = mkN "dieet" neuter ; -- status=guess
lin enormous_A = mkA "enorm" | mkA "gigantisch" ; -- status=guess status=guess
lin score_N = mkN "partituur" feminine ; -- status=guess
lin rarely_Adv = mkAdv "zelden" ; -- status=guess
lin prize_N = mkN "buit" feminine ; -- status=guess
lin remaining_A = variants{} ; -- 
lin significantly_Adv = variants{} ; -- 
lin glance_V2 = variants{} ; -- 
lin glance_V = variants{} ; -- 
lin dominate_V2 = variants{} ; -- 
lin dominate_V = variants{} ; -- 
lin trust_VS = mkVS (mkV "vertrouwen") ; -- status=guess, src=wikt
lin trust_V2 = mkV2 (mkV "vertrouwen") ; -- status=guess, src=wikt
lin naturally_Adv = mkAdv "natuurlijk" ; -- status=guess
lin interpret_V2 = mkV2 (mkV "vertalen") | mkV2 (mkV "tolken") ; -- status=guess, src=wikt status=guess, src=wikt
lin interpret_V = mkV "vertalen" | mkV "tolken" ; -- status=guess, src=wikt status=guess, src=wikt
lin land_V2 = mkV2 (mkV (mkV "doen") "landen") | mkV2 (mkV (mkV "aan") "de grond zetten") ; -- status=guess, src=wikt status=guess, src=wikt
lin land_V = mkV (mkV "doen") "landen" | mkV (mkV "aan") "de grond zetten" ; -- status=guess, src=wikt status=guess, src=wikt
lin frame_N = mkN "frame" ; -- status=guess
lin extension_N = mkN "uitbreiding" feminine ; -- status=guess
lin mix_V2 = mkV2 (mkV "vermengen") ; -- status=guess, src=wikt
lin mix_V = mkV "vermengen" ; -- status=guess, src=wikt
lin spokesman_N = mkN "woordvoerder" masculine | mkN "woordvoerster" feminine | mkN "zegsman" masculine ; -- status=guess status=guess status=guess
lin friendly_A = mkA "vriendelijk" | mkA "sympathiek" | mkA "aangenaam" | mkA "vriendschappelijk" ; -- status=guess status=guess status=guess status=guess
lin acknowledge_VS = mkVS (mkV "erkennen") ; -- status=guess, src=wikt
lin acknowledge_V2 = mkV2 (mkV "erkennen") ; -- status=guess, src=wikt
lin register_V2 = mkV2 (mkV "inschrijven") ; -- status=guess, src=wikt
lin register_V = mkV "inschrijven" ; -- status=guess, src=wikt
lin regime_N = mkN "regime" ; -- status=guess
lin regime_2_N = variants{} ; -- 
lin regime_1_N = variants{} ; -- 
lin fault_N = mkN "breuk" utrum ; -- status=guess
lin dispute_N = variants{} ; -- 
lin grass_N = L.grass_N ;
lin quietly_Adv = variants{} ; -- 
lin decline_N = mkN "terugval" masculine | mkN "achteruitgang" masculine | mkN "verval" neuter | mkN "afname" feminine ; -- status=guess status=guess status=guess status=guess
lin dismiss_V2 = variants{} ; -- 
lin delivery_N = mkN "levering" feminine ; -- status=guess
lin complain_VS = mkVS (mkV "klagen") ; -- status=guess, src=wikt
lin complain_V = mkV "klagen" ; -- status=guess, src=wikt
lin conservative_N = variants{} ; -- 
lin shift_V2 = variants{} ; -- 
lin shift_V = variants{} ; -- 
lin port_N = mkN "poort" ; -- status=guess
lin beach_N = mkN "strand" neuter ; -- status=guess
lin string_N = mkN "draad" masculine ; -- status=guess
lin depth_N = mkN "diepte" feminine ; -- status=guess
lin unusual_A = mkA "ongebruikelijk" | mkA "ongewoon" ; -- status=guess status=guess
lin travel_N = mkN "reis" ; -- status=guess
lin pilot_N = mkN "piloot" masculine | mkN "vliegenier" ; -- status=guess status=guess
lin obligation_N = mkN "verplichting" feminine ; -- status=guess
lin gene_N = mkN "gen" ; -- status=guess
lin yellow_A = L.yellow_A ;
lin republic_N = mkN "republiek" feminine ; -- status=guess
lin shadow_N = mkN "schaduw" masculine ; -- status=guess
lin dear_A = mkA "beste" | mkA "lieve" | mkA "waarde" ; -- status=guess status=guess status=guess
lin analyse_V2 = variants{} ; -- 
lin anywhere_Adv = mkAdv "overal" | mkAdv "eender waar" ; -- status=guess status=guess
lin average_N = mkN "gemiddelde" neuter ; -- status=guess
lin phrase_N = mkN "taalgids" masculine ; -- status=guess
lin long_term_A = variants{} ; -- 
lin crew_N = mkN "bemanning" feminine | mkN "ploeg" feminine ; -- status=guess status=guess
lin lucky_A = mkA "gelukkig" | mkA "boffend" ; -- status=guess status=guess
lin restore_V2 = mkV2 (mkV "restaureren") | mkV2 (mkV "terugzetten") ; -- status=guess, src=wikt status=guess, src=wikt
lin convince_V2V = mkV2V (mkV "overtuigen") ; -- status=guess, src=wikt
lin convince_V2 = mkV2 (mkV "overtuigen") ; -- status=guess, src=wikt
lin coast_N = mkN "kust" | mkN "kustlijn" | mkN "zeekant" | mkN "zeekust" ; -- status=guess status=guess status=guess status=guess
lin engineer_N = mkN "ingenieur" masculine feminine | mkN "probleemoplosser" masculine ; -- status=guess status=guess
lin heavily_Adv = variants{} ; -- 
lin extensive_A = mkA "uitgebreid" ; -- status=guess
lin glad_A = mkA "blij" | mkA "verheugd" ; -- status=guess status=guess
lin charity_N = mkN "naastenliefde" feminine ; -- status=guess
lin oppose_V2 = mkV2 (mkV "tegenhouden") ; -- status=guess, src=wikt
lin oppose_V = mkV "tegenhouden" ; -- status=guess, src=wikt
lin defend_V2 = variants{} ; -- 
lin alter_V2 = variants{} ; -- 
lin alter_V = variants{} ; -- 
lin warning_N = mkN "waarschuwing" feminine | mkN "waarning" feminine | mkN "verwittiging" feminine ; -- status=guess status=guess status=guess
lin arrest_V2 = mkV2 (mkV "vatten") | mkV2 (grijpen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin framework_N = mkN "framework" neuter | mkN "kader" neuter ; -- status=guess status=guess
lin approval_N = mkN "goedkeuring" feminine ; -- status=guess
lin bother_VV = mkVV (mkV (mkV "moeite") "doen") ; -- status=guess, src=wikt
lin bother_V2V = mkV2V (mkV (mkV "moeite") "doen") ; -- status=guess, src=wikt
lin bother_V2 = mkV2 (mkV (mkV "moeite") "doen") ; -- status=guess, src=wikt
lin bother_V = mkV (mkV "moeite") "doen" ; -- status=guess, src=wikt
lin novel_N = mkN "roman" masculine ; -- status=guess
lin accuse_V2 = mkV2 (mkV "beschuldigen") ; -- status=guess, src=wikt
lin surprised_A = mkA "verbaasd" ; -- status=guess
lin currency_N = mkN "munteenheid" feminine | mkN "valuta" ; -- status=guess status=guess
lin restrict_V2 = mkV2 (mkV "beperken") ; -- status=guess, src=wikt
lin restrict_V = mkV "beperken" ; -- status=guess, src=wikt
lin possess_V2 = mkV2 (mkV "bezitten") ; -- status=guess, src=wikt
lin moral_A = variants{} ; -- 
lin protein_N = mkN "proteïne" feminine | mkN "eiwit" neuter ; -- status=guess status=guess
lin distinguish_V2 = mkV2 (mkV "onderscheiden") ; -- status=guess, src=wikt
lin distinguish_V = mkV "onderscheiden" ; -- status=guess, src=wikt
lin gently_Adv = mkAdv "zachtjes" | mkAdv "voorzichtig" | mkAdv "zachtaardig" ; -- status=guess status=guess status=guess
lin reckon_VS = mkVS (mkV "veronderstellen") ; -- status=guess, src=wikt
lin incorporate_V2 = mkV2 (mkV "inbouwen") | mkV2 (mkV "inlijven") ; -- status=guess, src=wikt status=guess, src=wikt
lin proceed_V = mkV "voortkomen" | mkV (mkV "afkomstig") "zijn van" ; -- status=guess, src=wikt status=guess, src=wikt
lin assist_V2 = mkV2 (mkV "assisteren") | mkV2 (mkV "bijstaan") ; -- status=guess, src=wikt status=guess, src=wikt
lin assist_V = mkV "assisteren" | mkV "bijstaan" ; -- status=guess, src=wikt status=guess, src=wikt
lin sure_Adv = variants{} ; -- 
lin stress_VS = variants{} ; -- 
lin stress_V2 = variants{} ; -- 
lin justify_VV = mkVV (mkV "uitlijnen") ; -- status=guess, src=wikt
lin justify_V2 = mkV2 (mkV "uitlijnen") ; -- status=guess, src=wikt
lin behalf_N = variants{} ; -- 
lin councillor_N = variants{} ; -- 
lin setting_N = mkN "context" masculine ; -- status=guess
lin command_N = mkN "opdracht" utrum ; -- status=guess
lin command_2_N = variants{} ; -- 
lin command_1_N = variants{} ; -- 
lin maintenance_N = mkN "onderhoud" neuter | mkN "handhaving" feminine ; -- status=guess status=guess
lin stair_N = mkN "trap" ; -- status=guess
lin poem_N = mkN "gedicht" neuter | mkN "vers" neuter ; -- status=guess status=guess
lin chest_N = mkN "komode" feminine ; -- status=guess
lin like_Adv = mkAdv "zoals" ; -- status=guess
lin secret_N = mkN "geheim" neuter ; -- status=guess
lin restriction_N = mkN "beperking" feminine ; -- status=guess
lin efficient_A = mkA "efficiënt" ; -- status=guess
lin suspect_VS = mkVS (mkV "verdenken") ; -- status=guess, src=wikt
lin suspect_V2 = mkV2 (mkV "verdenken") ; -- status=guess, src=wikt
lin hat_N = L.hat_N ;
lin tough_A = variants{} ; -- 
lin firmly_Adv = mkAdv "stevig" ; -- status=guess
lin willing_A = mkA "bereid" ; -- status=guess
lin healthy_A = mkA "gezond" ; -- status=guess
lin focus_N = mkN "focus" masculine ; -- status=guess
lin construct_V2 = variants{} ; -- 
lin occasionally_Adv = mkAdv "af en toe" | mkAdv "wel eens" | mkAdv "nu en dan" | mkAdv "soms" ; -- status=guess status=guess status=guess status=guess
lin mode_N = mkN "modus" masculine ; -- status=guess
lin saving_N = variants{} ; -- 
lin comfortable_A = mkA "comfortabel" | mkA "gemakkelijk" ; -- status=guess status=guess
lin camp_N = variants{} ; -- 
lin trade_V2 = variants{} ; -- 
lin trade_V = variants{} ; -- 
lin export_N = variants{} ; -- 
lin wake_V2 = mkV2 (mkV "wekken") | mkV2 (mkV (mkV "wakker") "maken") ; -- status=guess, src=wikt status=guess, src=wikt
lin wake_V = mkV "wekken" | mkV (mkV "wakker") "maken" ; -- status=guess, src=wikt status=guess, src=wikt
lin partnership_N = mkN "maatschap" | mkN "partnerschap" ; -- status=guess status=guess
lin daily_A = mkA "dagelijks" ; -- status=guess
lin abroad_Adv = mkAdv "in het buitenland" | mkAdv "naar het buitenland" ; -- status=guess status=guess
lin profession_N = mkN "beroep" neuter ; -- status=guess
lin load_N = mkN "hoop" | mkN "heel wat" ; -- status=guess status=guess
lin countryside_N = mkN "platteland" neuter ; -- status=guess
lin boot_N = L.boot_N ;
lin mostly_Adv = mkAdv "meestal" | mkAdv "overwegend" ; -- status=guess status=guess
lin sudden_A = mkA "plotseling" | mkA "plotselinge" ; -- status=guess status=guess
lin implement_V2 = mkV2 (mkV "implementeren") | mkV2 (mkV "toepassen") | mkV2 (mkV "uitwerken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reputation_N = mkN "faam" masculine | mkN "naam" masculine | mkN "reputatie" feminine ; -- status=guess status=guess status=guess
lin print_V2 = mkV2 (mkV "drukken") | mkV2 (mkV "afdrukken") | mkV2 (mkV "printen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin print_V = mkV "drukken" | mkV "afdrukken" | mkV "printen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin calculate_VS = mkVS (mkV "rekenen") | mkVS (mkV "uitwerken") ; -- status=guess, src=wikt status=guess, src=wikt
lin calculate_V2 = mkV2 (mkV "rekenen") | mkV2 (mkV "uitwerken") ; -- status=guess, src=wikt status=guess, src=wikt
lin calculate_V = mkV "rekenen" | mkV "uitwerken" ; -- status=guess, src=wikt status=guess, src=wikt
lin keen_A = variants{} ; -- 
lin guess_VS = mkVS (mkV "veronderstellen") | mkVS (mkV "gissen") ; -- status=guess, src=wikt status=guess, src=wikt
lin guess_V2 = mkV2 (mkV "veronderstellen") | mkV2 (mkV "gissen") ; -- status=guess, src=wikt status=guess, src=wikt
lin guess_V = mkV "veronderstellen" | mkV "gissen" ; -- status=guess, src=wikt status=guess, src=wikt
lin recommendation_N = mkN "aanbeveling" feminine ; -- status=guess
lin autumn_N = mkN "herfst" masculine | mkN "najaar" neuter ; -- status=guess status=guess
lin conventional_A = variants{} ; -- 
lin cope_V = mkV (mkV "mee") "omgaan" ; -- status=guess, src=wikt
lin constitute_V2 = variants{} ; -- 
lin poll_N = variants{} ; -- 
lin voluntary_A = mkA "vrijwillig" ; -- status=guess
lin valuable_A = mkA "waardevol" ; -- status=guess
lin recovery_N = mkN "terugwinning" feminine ; -- status=guess
lin cast_V2 = mkV2 (mkV (mkV "met") "modder gooien naar") ; -- status=guess, src=wikt
lin cast_V = mkV (mkV "met") "modder gooien naar" ; -- status=guess, src=wikt
lin premise_N = mkN "voorwaarde" feminine ; -- status=guess
lin resolve_V2 = mkV2 (mkV "oplossen") ; -- status=guess, src=wikt
lin resolve_V = mkV "oplossen" ; -- status=guess, src=wikt
lin regularly_Adv = variants{} ; -- 
lin solve_V2 = mkV2 (mkV "oplossen") ; -- status=guess, src=wikt
lin plaintiff_N = mkN "eiser" | mkN "aanklager" ; -- status=guess status=guess
lin critic_N = mkN "criticus" masculine ; -- status=guess
lin agriculture_N = mkN "landbouw" feminine ; -- status=guess
lin ice_N = L.ice_N ;
lin constitution_N = mkN "grondwet " masculine ; -- status=guess
lin communist_N = mkN "communist" masculine | mkN "communiste" feminine ; -- status=guess status=guess
lin layer_N = mkN "laag" feminine ; -- status=guess
lin recession_N = mkN "recessie" ; -- status=guess
lin slight_A = mkA "onbeduidend" ; -- status=guess
lin dramatic_A = variants{} ; -- 
lin golden_A = variants{} ; -- 
lin temporary_A = mkA "tijdelijk" ; -- status=guess
lin suit_N = mkN "kleur" ; -- status=guess
lin shortly_Adv = variants{} ; -- 
lin initially_Adv = variants{} ; -- 
lin arrival_N = mkN "komst" feminine | mkN "aankomst" feminine ; -- status=guess status=guess
lin protest_N = mkN "protest" neuter ; -- status=guess
lin resistance_N = mkN "weerstand" masculine ; -- status=guess
lin silent_A = variants{} ; -- 
lin presentation_N = mkN "presentatie" feminine | mkN "or less accurately voorstelling" feminine | mkN "voordracht" ; -- status=guess status=guess status=guess
lin soul_N = mkN "ziel" feminine ; -- status=guess
lin self_N = mkN "zelf" neuter ; -- status=guess
lin judgment_N = variants{} ; -- 
lin feed_V2 = mkV2 (reflMkV "voeden met") ; -- status=guess, src=wikt
lin feed_V = reflMkV "voeden met" ; -- status=guess, src=wikt
lin muscle_N = mkN "spier" ; -- status=guess
lin shareholder_N = variants{} ; -- 
lin opposite_A = mkA "tegenoverliggend" | mkA "tegenovergesteld" ; -- status=guess status=guess
lin pollution_N = mkN "bezoedeling" feminine | mkN "milieuverontreiniging" feminine | mkN "pollutie" feminine | mkN "smet" masculine ; -- status=guess status=guess status=guess status=guess
lin wealth_N = mkN "rijkdom" masculine ; -- status=guess
lin video_taped_A = variants{} ; -- 
lin kingdom_N = mkN "rijk" neuter | mkN "plantenrijk" neuter | mkN "dierenrijk" neuter ; -- status=guess status=guess status=guess
lin bread_N = L.bread_N ;
lin perspective_N = mkN "perspectief" neuter | mkN "dieptezicht" ; -- status=guess status=guess
lin camera_N = L.camera_N ;
lin prince_N = mkN "Prins-bisschop" masculine | mkN "Vorst-bisschop" masculine ; -- status=guess status=guess
lin illness_N = mkN "ziekte" feminine ; -- status=guess
lin cake_N = mkN "stuk" neuter | mkN "blok" masculine ; -- status=guess status=guess
lin meat_N = L.meat_N ;
lin submit_V2 = mkV2 (mkV "voorleggen") | mkV2 (mkV "verzenden") | mkV2 (mkV "voordragen") | mkV2 (mkV "indienen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin submit_V = mkV "voorleggen" | mkV "verzenden" | mkV "voordragen" | mkV "indienen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin ideal_A = mkA "ideaal" | mkA "optimaal" ; -- status=guess status=guess
lin relax_V2 = mkV2 (mkV "ontspannen") | mkV2 (mkV (mkV "losser") "worden") ; -- status=guess, src=wikt status=guess, src=wikt
lin relax_V = mkV "ontspannen" | mkV (mkV "losser") "worden" ; -- status=guess, src=wikt status=guess, src=wikt
lin penalty_N = mkN "strafschopgebied" | mkN "zestienmetergebied" ; -- status=guess status=guess
lin purchase_V2 = mkV2 (kopen_V) | mkV2 (mkV (mkV "waard") "zijn") ; -- status=guess, src=wikt status=guess, src=wikt
lin tired_A = mkA "moe" | mkA "vermoeid" ; -- status=guess status=guess
lin beer_N = L.beer_N ;
lin specify_VS = mkVS (mkV "specifieren") ; -- status=guess, src=wikt
lin specify_V2 = mkV2 (mkV "specifieren") ; -- status=guess, src=wikt
lin specify_V = mkV "specifieren" ; -- status=guess, src=wikt
lin short_Adv = variants{} ; -- 
lin monitor_V2 = mkV2 (mkV "controleren") | mkV2 (mkV "surveilleren") | mkV2 (mkV (mkV "toezicht") "houden") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin monitor_V = mkV "controleren" | mkV "surveilleren" | mkV (mkV "toezicht") "houden" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin electricity_N = mkN "elektriciteit" feminine | mkN "stroom" masculine ; -- status=guess status=guess
lin specifically_Adv = variants{} ; -- 
lin bond_N = mkN "binding" ; -- status=guess
lin statutory_A = mkA "statutair" ; -- status=guess
lin laboratory_N = mkN "laboratorium" neuter ; -- status=guess
lin federal_A = variants{} ; -- 
lin captain_N = mkN "kapitein" masculine ; -- status=guess
lin deeply_Adv = variants{} ; -- 
lin pour_V2 = mkV2 (gieten_V) | mkV2 (mkV "uitstorten") ; -- status=guess, src=wikt status=guess, src=wikt
lin pour_V = gieten_V | mkV "uitstorten" ; -- status=guess, src=wikt status=guess, src=wikt
lin boss_N = L.boss_N ;
lin creature_N = mkN "schepsel" | mkN "creatuur" | mkN "wezen" neuter ; -- status=guess status=guess status=guess
lin urge_VS = mkVS (mkV "aansporen") ; -- status=guess, src=wikt
lin urge_V2V = mkV2V (mkV "aansporen") ; -- status=guess, src=wikt
lin urge_V2 = mkV2 (mkV "aansporen") ; -- status=guess, src=wikt
lin locate_V2 = variants{} ; -- 
lin locate_V = variants{} ; -- 
lin being_N = mkN "wezen" neuter ; -- status=guess
lin struggle_VV = mkVV (vechten_V) | mkVV (mkV "worstelen") | mkVV (mkV (mkV "moeite") "hebben met") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin struggle_V = vechten_V | mkV "worstelen" | mkV (mkV "moeite") "hebben met" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lifespan_N = variants{} ; -- 
lin flat_A = mkA "vlak" | mkA "plat" ; -- status=guess status=guess
lin valley_N = mkN "vallei" utrum | mkN "dal" neuter ; -- status=guess status=guess
lin like_A = mkA "zoals" | mkA "gelijk" ; -- status=guess status=guess
lin guard_N = mkN "wacht" masculine | mkN "bewaker" masculine | mkN "lijfwacht" ; -- status=guess status=guess status=guess
lin emergency_N = mkN "nood" masculine ; -- status=guess
lin dark_N = mkN "donker" neuter ; -- status=guess
lin bomb_N = mkN "wrak" neuter ; -- status=guess
lin dollar_N = mkN "dollar" masculine ; -- status=guess
lin efficiency_N = mkN "rendement" neuter ; -- status=guess
lin mood_N = mkN "humeur" | mkN "bui" ; -- status=guess status=guess
lin convert_V2 = mkV2 (mkV "bekeren") ; -- status=guess, src=wikt
lin convert_V = mkV "bekeren" ; -- status=guess, src=wikt
lin possession_N = mkN "bezit" neuter | mkN "bezittingen {p}" ; -- status=guess status=guess
lin marketing_N = variants{} ; -- 
lin please_VV = mkVV (mkV "bevallen") | mkVV (mkV "behagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2V = mkV2V (mkV "bevallen") | mkV2V (mkV "behagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2 = mkV2 (mkV "bevallen") | mkV2 (mkV "behagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V = mkV "bevallen" | mkV "behagen" ; -- status=guess, src=wikt status=guess, src=wikt
lin habit_N = mkN "gewoonte" feminine | mkN "tic" masculine | mkN "automatisme" neuter ; -- status=guess status=guess status=guess
lin subsequently_Adv = mkAdv "hierop" | mkAdv "vervolgens" ; -- status=guess status=guess
lin round_N = mkN "ronde" feminine ; -- status=guess
lin purchase_N = mkN "verwerving" masculine | mkN "aanschaf" masculine ; -- status=guess status=guess
lin sort_V2 = mkV2 (mkV "rangschikken") ; -- status=guess, src=wikt
lin sort_V = mkV "rangschikken" ; -- status=guess, src=wikt
lin outside_A = mkA "buitenste" ; -- status=guess
lin gradually_Adv = mkAdv "geleidelijk" | mkAdv "allengs" | mkAdv "gaandeweg" ; -- status=guess status=guess status=guess
lin expansion_N = variants{} ; -- 
lin competitive_A = variants{} ; -- 
lin cooperation_N = mkN "samenwerking" feminine ; -- status=guess
lin acceptable_A = mkA "aanvaardbaar" | mkA "acceptabel" ; -- status=guess status=guess
lin angle_N = mkN "hoekanker" neuter ; -- status=guess
lin cook_V2 = mkV2 (mkV "koken") ; -- status=guess, src=wikt
lin cook_V = mkV "koken" ; -- status=guess, src=wikt
lin net_A = mkA "uiteindelijk" | mkA "finaal" ; -- status=guess status=guess
lin sensitive_A = mkA "gevoelig" ; -- status=guess
lin ratio_N = variants{} ; -- 
lin kiss_V2 = mkV2 (mkV (mkV "elkaar") "kussen") | mkV2 (mkV (mkV "elkaar") "zoenen") ; -- status=guess, src=wikt status=guess, src=wikt
lin amount_V = mkV "bedragen" | mkV (mkV "komen") "op" | mkV (mkV "uitkomen") "op" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sleep_N = mkN "slaap" masculine ; -- status=guess
lin finance_V2 = mkV2 (mkV "financieren") ; -- status=guess, src=wikt
lin essentially_Adv = mkAdv "essentieel" ; -- status=guess
lin fund_V2 = mkV2 (mkV "financieren") ; -- status=guess, src=wikt
lin preserve_V2 = mkV2 (mkV "bewaren") | mkV2 (mkV (mkV "in") "stand houden") ; -- status=guess, src=wikt status=guess, src=wikt
lin wedding_N = mkN "bruiloft" ; -- status=guess
lin personality_N = mkN "persoonlijkheid" feminine ; -- status=guess
lin bishop_N = mkN "loper" masculine ; -- status=guess
lin dependent_A = mkA "afhankelijk" ; -- status=guess
lin landscape_N = mkN "landschap" neuter ; -- status=guess
lin pure_A = mkA "puur" | mkA "rein" ; -- status=guess status=guess
lin mirror_N = mkN "spiegel" ; -- status=guess
lin lock_V2 = mkV2 (mkV "blokkeren") | mkV2 (mkV "vastlopen") ; -- status=guess, src=wikt status=guess, src=wikt
lin lock_V = mkV "blokkeren" | mkV "vastlopen" ; -- status=guess, src=wikt status=guess, src=wikt
lin symptom_N = mkN "symptoom" neuter | mkN "verschijnsel" neuter ; -- status=guess status=guess
lin promotion_N = mkN "promotie" feminine | mkN "bevordering" feminine ; -- status=guess status=guess
lin global_A = mkA "globaal" | mkA "wereldwijd" | mkA "wereld-" | mkA "mondiaal" ; -- status=guess status=guess status=guess status=guess
lin aside_Adv = variants{} ; -- 
lin tendency_N = mkN "neiging" feminine ; -- status=guess
lin conservation_N = mkN "natuurbescherming" ; -- status=guess
lin reply_N = mkN "antwoord" neuter | mkN "respons" feminine ; -- status=guess status=guess
lin estimate_N = mkN "schatting" feminine ; -- status=guess
lin qualification_N = variants{} ; -- 
lin pack_V2 = variants{} ; -- 
lin pack_V = variants{} ; -- 
lin governor_N = mkN "regelaar" ; -- status=guess
lin expected_A = variants{} ; -- 
lin invest_V2 = variants{} ; -- 
lin invest_V = variants{} ; -- 
lin cycle_N = mkN "cyclus" masculine ; -- status=guess
lin alright_A = variants{} ; -- 
lin philosophy_N = mkN "filosofie" feminine | mkN "wijsbegeerte" feminine ; -- status=guess status=guess
lin gallery_N = mkN "galerij" feminine ; -- status=guess
lin sad_A = mkA "triest" ; -- status=guess
lin intervention_N = mkN "tussenkomst" feminine ; -- status=guess
lin emotional_A = variants{} ; -- 
lin advertising_N = variants{} ; -- 
lin regard_N = mkN "respect" | mkN "achting" ; -- status=guess status=guess
lin dance_V2 = mkV2 (mkV "dansen") ; -- status=guess, src=wikt
lin dance_V = mkV "dansen" ; -- status=guess, src=wikt
lin cigarette_N = mkN "sigaret" masculine feminine | mkN "saffiaantje" ; -- status=guess status=guess
lin predict_VS = mkVS (mkV "voorspellen") ; -- status=guess, src=wikt
lin predict_V2 = mkV2 (mkV "voorspellen") ; -- status=guess, src=wikt
lin adequate_A = mkA "adequaat" | mkA "voldoende" | mkA "deugdelijk" ; -- status=guess status=guess status=guess
lin variable_N = mkN "grijskap-mierklauwier" ; -- status=guess
lin net_N = mkN "netto" neuter ; -- status=guess
lin retire_V2 = mkV2 (mkV (mkV "met") "pensioen gaan") ; -- status=guess, src=wikt
lin retire_V = mkV (mkV "met") "pensioen gaan" ; -- status=guess, src=wikt
lin sugar_N = mkN "suikerbiet" ; -- status=guess
lin pale_A = mkA "bleek" ; -- status=guess
lin frequency_N = mkN "frequentiemodulatie" ; -- status=guess
lin guy_N = mkN "gasten" masculine | mkN "jongens" masculine ; -- status=guess status=guess
lin feature_V2 = mkV2 (mkV "oplichten") | mkV2 (mkV "benadrukken") ; -- status=guess, src=wikt status=guess, src=wikt
lin furniture_N = mkN "meubel" neuter | mkN "meubelstuk" neuter ; -- status=guess status=guess
lin administrative_A = mkA "bestuurlijk" | mkA "administratief" ; -- status=guess status=guess
lin wooden_A = mkA "houterig" ; -- status=guess
lin input_N = mkN "invoer" ; -- status=guess
lin phenomenon_N = mkN "fenomeen" neuter ; -- status=guess
lin surprising_A = mkA "verrassend" ; -- status=guess
lin jacket_N = mkN "jas" masculine ; -- status=guess
lin actor_N = mkN "acteur" masculine | mkN "actrice" feminine | mkN "toneelspeler" masculine | mkN "toneelspeelster" feminine ; -- status=guess status=guess status=guess status=guess
lin actor_2_N = variants{} ; -- 
lin actor_1_N = variants{} ; -- 
lin kick_V2 = mkV2 (mkV "schoppen") | mkV2 (mkV "stampen") | mkV2 (mkV "trappen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin kick_V = mkV "schoppen" | mkV "stampen" | mkV "trappen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin producer_N = mkN "producent" masculine | mkN "producer" masculine ; -- status=guess status=guess
lin hearing_N = variants{} ; -- 
lin chip_N = mkN "fiche" neuter ; -- status=guess
lin equation_N = mkN "vergelijking" ; -- status=guess
lin certificate_N = mkN "certificaat" | mkN "attest" neuter ; -- status=guess status=guess
lin hello_Interj = mkInterj "hallo!" ; -- status=guess
lin remarkable_A = mkA "opmerkelijk" | mkA "markant" | mkA "opvallend" ; -- status=guess status=guess status=guess
lin alliance_N = mkN "alliantie" feminine ; -- status=guess
lin smoke_V2 = mkV2 (mkV "roken") ; -- status=guess, src=wikt
lin smoke_V = mkV "roken" ; -- status=guess, src=wikt
lin awareness_N = mkN "besef" | mkN "bewustzijn" ; -- status=guess status=guess
lin throat_N = mkN "keel" ; -- status=guess
lin discovery_N = mkN "ontdekking" feminine | mkN "vinding" feminine ; -- status=guess status=guess
lin festival_N = mkN "festival" neuter ; -- status=guess
lin dance_N = mkN "dans" ; -- status=guess
lin promise_N = mkN "belofte" feminine ; -- status=guess
lin rose_N = mkN "roze" neuter ; -- status=guess
lin principal_A = mkA "voornaamste" ; -- status=guess
lin brilliant_A = mkA "briljant" | mkA "geniaal" ; -- status=guess status=guess
lin proposed_A = variants{} ; -- 
lin coach_N = mkN "reisbus" masculine ; -- status=guess
lin coach_3_N = variants{} ; -- 
lin coach_2_N = variants{} ; -- 
lin coach_1_N = variants{} ; -- 
lin absolute_A = mkA "absoluut" ; -- status=guess
lin drama_N = mkN "drama" neuter ; -- status=guess
lin recording_N = variants{} ; -- 
lin precisely_Adv = mkAdv "precies" ; -- status=guess
lin bath_N = mkN "bad" neuter ; -- status=guess
lin celebrate_V2 = mkV2 (mkV "vieren") ; -- status=guess, src=wikt
lin substance_N = mkN "drugsmisbruik" neuter ; -- status=guess
lin swing_V2 = mkV2 (mkV "schommelen") | mkV2 (mkV "zwaaien") ; -- status=guess, src=wikt status=guess, src=wikt
lin swing_V = mkV "schommelen" | mkV "zwaaien" ; -- status=guess, src=wikt status=guess, src=wikt
lin for_Adv = mkAdv "bijvoorbeeld" ; -- status=guess
lin rapid_A = mkA "snel" | mkA "snelle" ; -- status=guess status=guess
lin rough_A = mkA "ruw" | mkA "ruig" ; -- status=guess status=guess
lin investor_N = mkN "investeerder" masculine ; -- status=guess
lin fire_V2 = mkV2 (mkV "vuren") | mkV2 (schieten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin fire_V = mkV "vuren" | schieten_V ; -- status=guess, src=wikt status=guess, src=wikt
lin rank_N = mkN "register" neuter | mkN "werk" neuter ; -- status=guess status=guess
lin compete_V = mkV "wedijveren" ; -- status=guess, src=wikt
lin sweet_A = mkA "zoetzuur" ; -- status=guess
lin decline_VV = mkVV (mkV "verbuigen") ; -- status=guess, src=wikt
lin decline_V2 = mkV2 (mkV "verbuigen") ; -- status=guess, src=wikt
lin decline_V = mkV "verbuigen" ; -- status=guess, src=wikt
lin rent_N = mkN "scheiding" | mkN "schisma" ; -- status=guess status=guess
lin dealer_N = mkN "dealer" masculine ; -- status=guess
lin bend_V2 = mkV2 (mkV "bukken") ; -- status=guess, src=wikt
lin bend_V = mkV "bukken" ; -- status=guess, src=wikt
lin solid_A = mkA "zwaar" ; -- status=guess
lin cloud_N = L.cloud_N ;
lin across_Adv = mkAdv "horizontaal" ; -- status=guess
lin level_A = mkA "geëqualiseerd" ; -- status=guess
lin enquiry_N = variants{} ; -- 
lin fight_N = mkN "gevecht" neuter | mkN "strijd" masculine ; -- status=guess status=guess
lin abuse_N = mkN "misbruik" neuter ; -- status=guess
lin golf_N = mkN "golf" ; -- status=guess
lin guitar_N = mkN "gitaar" feminine ; -- status=guess
lin electronic_A = mkA "elektronisch" ; -- status=guess
lin cottage_N = mkN "huttenkaas" masculine | mkN "hüttenkäse" masculine | mkN "cottage cheese" masculine | mkN "kwark" masculine ; -- status=guess status=guess status=guess status=guess
lin scope_N = mkN "domein" | mkN "bereik" | mkN "reikwijdte" ; -- status=guess status=guess status=guess
lin pause_VS = mkVS (mkV "pauzeren") ; -- status=guess, src=wikt
lin pause_V2V = mkV2V (mkV "pauzeren") ; -- status=guess, src=wikt
lin pause_V = mkV "pauzeren" ; -- status=guess, src=wikt
lin mixture_N = mkN "mengsel" ; -- status=guess
lin emotion_N = mkN "emotie" feminine ; -- status=guess
lin comprehensive_A = mkA "omvattend" | mkA "alomvattend" | mkA "uitgebreid" | mkA "diepgaand" ; -- status=guess status=guess status=guess status=guess
lin shirt_N = L.shirt_N ;
lin allowance_N = mkN "toestemming" ; -- status=guess
lin retirement_N = mkN "pensionering" feminine ; -- status=guess
lin breach_N = variants{} ; -- 
lin infection_N = mkN "infectie" feminine ; -- status=guess
lin resist_VV = variants{} ; -- 
lin resist_V2 = variants{} ; -- 
lin resist_V = variants{} ; -- 
lin qualify_V2 = variants{} ; -- 
lin qualify_V = variants{} ; -- 
lin paragraph_N = mkN "alinea" feminine | mkN "paragraaf" masculine ; -- status=guess status=guess
lin sick_A = mkA "ziek" | mkA "zieke" ; -- status=guess status=guess
lin near_A = L.near_A ;
lin researcherMasc_N = mkN "onderzoeker" ; -- status=guess
lin consent_N = mkN "toestemming" feminine | mkN "instemming" feminine ; -- status=guess status=guess
lin written_A = mkA "geschreven" ; -- status=guess
lin literary_A = mkA "literair" ; -- status=guess
lin ill_A = mkA "misselijk" ; -- status=guess
lin wet_A = L.wet_A ;
lin lake_N = L.lake_N ;
lin entrance_N = mkN "ingang" masculine ; -- status=guess
lin peak_N = mkN "piek" ; -- status=guess
lin successfully_Adv = mkAdv "met succes" ; -- status=guess
lin sand_N = L.sand_N ;
lin breathe_V2 = mkV2 (mkV (mkV "iemand") "in zijn") ; -- status=guess, src=wikt
lin breathe_V = L.breathe_V ;
lin cold_N = mkN "koude kernfusie" feminine ; -- status=guess
lin cheek_N = mkN "bil" feminine ; -- status=guess
lin platform_N = mkN "platformschoen" neuter ; -- status=guess
lin interaction_N = mkN "interactie" feminine ; -- status=guess
lin watch_N = mkN "wacht" ; -- status=guess
lin borrow_VV = mkVV (mkV "lenen") | mkVV (mkV "ontlenen") ; -- status=guess, src=wikt status=guess, src=wikt
lin borrow_V2 = mkV2 (mkV "lenen") | mkV2 (mkV "ontlenen") ; -- status=guess, src=wikt status=guess, src=wikt
lin borrow_V = mkV "lenen" | mkV "ontlenen" ; -- status=guess, src=wikt status=guess, src=wikt
lin birthday_N = mkN "verjaardag" masculine ; -- status=guess
lin knife_N = mkN "mes" | mkN "lemmet" ; -- status=guess status=guess
lin extreme_A = mkA "ultiem" | mkA "ultieme" ; -- status=guess status=guess
lin core_N = mkN "kern" masculine ; -- status=guess
lin peasantMasc_N = mkN "boer" masculine | mkN "plattelander" masculine | mkN "landman" masculine ; -- status=guess status=guess status=guess
lin armed_A = mkA "gewapend" ; -- status=guess
lin permission_N = mkN "toestemming" feminine | mkN "toelating" feminine ; -- status=guess status=guess
lin supreme_A = mkA "opperst" | mkA "opperste" | mkA "oppermachtige" ; -- status=guess status=guess status=guess
lin overcome_V2 = mkV2 (mkV "overwinnen") ; -- status=guess, src=wikt
lin overcome_V = mkV "overwinnen" ; -- status=guess, src=wikt
lin greatly_Adv = variants{} ; -- 
lin visual_A = mkA "visueel" ; -- status=guess
lin lad_N = mkN "jongen" masculine ; -- status=guess
lin genuine_A = mkA "echt" | mkA "authentiek" | mkA "origineel" ; -- status=guess status=guess status=guess
lin personnel_N = mkN "personeel" | mkN "medewerkers" ; -- status=guess status=guess
lin judgement_N = mkN "dag des oordeels" masculine feminine ; -- status=guess
lin exciting_A = mkA "spannend" ; -- status=guess
lin stream_N = mkN "stroom" masculine ; -- status=guess
lin perception_N = mkN "scherpzinnigheid" ; -- status=guess
lin guarantee_VS = mkVS (mkV "garanderen") ; -- status=guess, src=wikt
lin guarantee_V2 = mkV2 (mkV "garanderen") ; -- status=guess, src=wikt
lin guarantee_V = mkV "garanderen" ; -- status=guess, src=wikt
lin disaster_N = mkN "ramp" utrum ; -- status=guess
lin darkness_N = mkN "schemering" feminine ; -- status=guess
lin bid_N = mkN "bod" neuter ; -- status=guess
lin sake_N = mkN "sake" masculine ; -- status=guess
lin sake_2_N = variants{} ; -- 
lin sake_1_N = variants{} ; -- 
lin organize_V2V = mkV2V (mkV "organiseren") ; -- status=guess, src=wikt
lin organize_V2 = mkV2 (mkV "organiseren") ; -- status=guess, src=wikt
lin tourist_N = mkN "toerist" masculine | mkN "toeriste" feminine ; -- status=guess status=guess
lin policeman_N = L.policeman_N ;
lin castle_N = mkN "kasteel" neuter | mkN "fort" neuter | mkN "burcht" feminine | mkN "slot" neuter ; -- status=guess status=guess status=guess status=guess
lin figure_VS = mkVS (mkV "uitvogelen") | mkVS (mkV (mkV "er") "achter komen") | mkVS (mkV "ontcijferen") | mkVS (mkV "doorhebben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin figure_V = mkV "uitvogelen" | mkV (mkV "er") "achter komen" | mkV "ontcijferen" | mkV "doorhebben" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin race_VV = mkVV (mkV "razen") ; -- status=guess, src=wikt
lin race_V2V = mkV2V (mkV "razen") ; -- status=guess, src=wikt
lin race_V2 = mkV2 (mkV "razen") ; -- status=guess, src=wikt
lin race_V = mkV "razen" ; -- status=guess, src=wikt
lin demonstration_N = mkN "demonstratie" feminine ; -- status=guess
lin anger_N = mkN "boosheid" | mkN "woede" ; -- status=guess status=guess
lin briefly_Adv = variants{} ; -- 
lin presumably_Adv = mkAdv "vermoedelijk" | mkAdv "waarschijnlijk" ; -- status=guess status=guess
lin clock_N = mkN "wijzerplaat" ; -- status=guess
lin hero_N = mkN "held" masculine | mkN "hoofdrolspeler" masculine ; -- status=guess status=guess
lin expose_V2 = mkV2 (mkV "blootstellen") ; -- status=guess, src=wikt
lin expose_V = mkV "blootstellen" ; -- status=guess, src=wikt
lin custom_N = mkN "aangepast" | mkN "aangepast" ; -- status=guess status=guess
lin maximum_A = variants{} ; -- 
lin wish_N = mkN "wens" ; -- status=guess
lin earning_N = variants{} ; -- 
lin priest_N = L.priest_N ;
lin resign_V2 = mkV2 (mkV (mkV "ontslag") "nemen") ; -- status=guess, src=wikt
lin resign_V = mkV (mkV "ontslag") "nemen" ; -- status=guess, src=wikt
lin store_V2 = mkV2 (mkV "opslaan") ; -- status=guess, src=wikt
lin widespread_A = mkA "wijdverspreid" ; -- status=guess
lin comprise_V2 = mkV2 (mkV "bevatten") | mkV2 (mkV "omvatten") ; -- status=guess, src=wikt status=guess, src=wikt
lin chamber_N = mkN "slaapkamer" ; -- status=guess
lin acquisition_N = mkN "verwerving" feminine ; -- status=guess
lin involved_A = variants{} ; -- 
lin confident_A = variants{} ; -- 
lin circuit_N = mkN "zekering" feminine ; -- status=guess
lin radical_A = mkA "3] radicaal" ; -- status=guess status=guess
lin detect_V2 = mkV2 (mkV "detecteren") ; -- status=guess, src=wikt
lin stupid_A = L.stupid_A ;
lin grand_A = mkA "groots" ; -- status=guess
lin consumption_N = mkN "consumptie" feminine | mkN "verbruik" neuter ; -- status=guess status=guess
lin hold_N = mkN "ruim" neuter | mkN "scheepsruim" neuter ; -- status=guess status=guess
lin zone_N = mkN "zone" masculine ; -- status=guess
lin mean_A = mkA "gemeen" ; -- status=guess
lin altogether_Adv = mkAdv "al met al" | mkAdv "kortom" ; -- status=guess status=guess
lin rush_VV = mkVV (mkV "afraffelen") ; -- status=guess, src=wikt
lin rush_V2 = mkV2 (mkV "afraffelen") ; -- status=guess, src=wikt
lin rush_V = mkV "afraffelen" ; -- status=guess, src=wikt
lin numerous_A = mkA "talrijk" | mkA "ontelbaar" | mkA "numereus" ; -- status=guess status=guess status=guess
lin sink_V2 = mkV2 (zinken_V) ; -- status=guess, src=wikt
lin sink_V = zinken_V ; -- status=guess, src=wikt
lin everywhere_Adv = S.everywhere_Adv ;
lin classical_A = variants{} ; -- 
lin respectively_Adv = mkAdv "respectievelijk" ; -- status=guess
lin distinct_A = variants{} ; -- 
lin mad_A = mkA "boos" | mkA "kwaad" ; -- status=guess status=guess
lin honour_N = mkN "eer" masculine ; -- status=guess
lin statistics_N = mkN "statistiek" feminine ; -- status=guess
lin false_A = mkA "vals" | mkA "onecht" ; -- status=guess status=guess
lin square_N = mkN "veld" ; -- status=guess
lin differ_V = mkV "verschillen" | mkV "afwijken" ; -- status=guess, src=wikt status=guess, src=wikt
lin disk_N = mkN "harde schijf" | mkN "schijf" feminine ; -- status=guess status=guess
lin truly_Adv = mkAdv "waarlijk" | mkAdv "oprecht" ; -- status=guess status=guess
lin survival_N = variants{} ; -- 
lin proud_A = mkA "trots" | mkA "fier" ; -- status=guess status=guess
lin tower_N = mkN "toren" ; -- status=guess
lin deposit_N = mkN "storting" feminine ; -- status=guess
lin pace_N = mkN "tempo" neuter ; -- status=guess
lin compensation_N = mkN "compensatie" feminine ; -- status=guess
lin adviserMasc_N = mkN "adviseur" masculine ; -- status=guess
lin consultant_N = variants{} ; -- 
lin drag_V2 = mkV2 (mkV "slepen") ; -- status=guess, src=wikt
lin drag_V = mkV "slepen" ; -- status=guess, src=wikt
lin advanced_A = mkA "gevorderd" ; -- status=guess
lin landlord_N = mkN "herbergier" | mkN "kastelein" masculine | mkN "kroegbaas" masculine ; -- status=guess status=guess status=guess
lin whenever_Adv = mkAdv "wanneer ook" ; -- status=guess
lin delay_N = mkN "vertraging" feminine ; -- status=guess
lin green_N = mkN "groenwier" neuter ; -- status=guess
lin car_V = variants{} ; -- 
lin holder_N = mkN "houder" masculine ; -- status=guess
lin secret_A = mkA "geheim" ; -- status=guess
lin edition_N = mkN "editie" feminine ; -- status=guess
lin occupation_N = mkN "bezigheid" feminine ; -- status=guess
lin agricultural_A = variants{} ; -- 
lin intelligence_N = mkN "inlichtingendienst" masculine ; -- status=guess
lin intelligence_2_N = variants{} ; -- 
lin intelligence_1_N = variants{} ; -- 
lin empire_N = mkN "imperium" ; -- status=guess
lin definitely_Adv = mkAdv "zeker" | mkAdv "zeker weten" | mkAdv "zonder twijfel" ; -- status=guess status=guess status=guess
lin negotiate_VV = mkVV (mkV "onderhandelen") ; -- status=guess, src=wikt
lin negotiate_V2 = mkV2 (mkV "onderhandelen") ; -- status=guess, src=wikt
lin negotiate_V = mkV "onderhandelen" ; -- status=guess, src=wikt
lin host_N = mkN "gastheer" masculine ; -- status=guess
lin relative_N = mkN "familielid" neuter | mkN "bloedverwant" masculine ; -- status=guess status=guess
lin mass_A = variants{} ; -- 
lin helpful_A = mkA "behulpzaam" ; -- status=guess
lin fellow_N = variants{} ; -- 
lin sweep_V2 = mkV2 (mkV (mkV "iets") "onder het tapijt vegen") ; -- status=guess, src=wikt
lin sweep_V = mkV (mkV "iets") "onder het tapijt vegen" ; -- status=guess, src=wikt
lin poet_N = mkN "dichter" masculine ; -- status=guess
lin journalist_N = mkN "dagboekschrijver" masculine ; -- status=guess
lin defeat_N = mkN "nederlaag" ; -- status=guess
lin unlike_Prep = variants{} ; -- 
lin primarily_Adv = variants{} ; -- 
lin tight_A = variants{} ; -- 
lin indication_N = mkN "aanwijzing" feminine ; -- status=guess
lin dry_V2 = mkV2 (mkV (mkV "droog") "worden") ; -- status=guess, src=wikt
lin dry_V = mkV (mkV "droog") "worden" ; -- status=guess, src=wikt
lin cricket_N = mkN "fair-play" ; -- status=guess
lin whisper_V2 = mkV2 (mkV "fluisteren") ; -- status=guess, src=wikt
lin whisper_V = mkV "fluisteren" ; -- status=guess, src=wikt
lin routine_N = variants{} ; -- 
lin print_N = mkN "afdruk" ; -- status=guess
lin anxiety_N = mkN "bezorgdheid" feminine | mkN "ongerustheid" feminine ; -- status=guess status=guess
lin witness_N = mkN "getuigenis" ; -- status=guess
lin concerning_Prep = variants{} ; -- 
lin mill_N = mkN "fabriek" feminine | mkN "papierfabriek" feminine | mkN "staalfabriek" | mkN "textielfabriek" ; -- status=guess status=guess status=guess status=guess
lin gentle_A = variants{} ; -- 
lin curtain_N = mkN "gordijn" neuter ; -- status=guess
lin mission_N = mkN "missie" feminine | mkN "zending" feminine ; -- status=guess status=guess
lin supplier_N = mkN "leverancier" masculine ; -- status=guess
lin basically_Adv = variants{} ; -- 
lin assure_V2S = mkV2S (mkV "verzekeren") ; -- status=guess, src=wikt
lin assure_V2 = mkV2 (mkV "verzekeren") ; -- status=guess, src=wikt
lin poverty_N = mkN "armoede" feminine ; -- status=guess
lin snow_N = L.snow_N ;
lin prayer_N = mkN "bede" ; -- status=guess
lin pipe_N = mkN "pijpewisser" masculine ; -- status=guess
lin deserve_VV = mkVV (mkV "verdienen") ; -- status=guess, src=wikt
lin deserve_V2 = mkV2 (mkV "verdienen") ; -- status=guess, src=wikt
lin deserve_V = mkV "verdienen" ; -- status=guess, src=wikt
lin shift_N = variants{} ; -- 
lin split_V2 = L.split_V2 ;
lin split_V = mkV "splitsen" | mkV "opsplitsen" ; -- status=guess, src=wikt status=guess, src=wikt
lin near_Adv = mkAdv "nabij" | mkAdv "bij" | mkAdv "naverwant" | mkAdv "dierbaar" ; -- status=guess status=guess status=guess status=guess
lin consistent_A = mkA "consequent" | mkA "consistent" ; -- status=guess status=guess
lin carpet_N = L.carpet_N ;
lin ownership_N = variants{} ; -- 
lin joke_N = mkN "mop" masculine | mkN "grap" feminine | mkN "grol" feminine ; -- status=guess status=guess status=guess
lin fewer_Det = mkDet "minder" ; -- status=guess
lin workshop_N = mkN "workshop" ; -- status=guess
lin salt_N = L.salt_N ;
lin aged_Prep = variants{} ; -- 
lin symbol_N = mkN "symbool" ; -- status=guess
lin slide_V2 = mkV2 (mkV "slepen") | mkV2 (schuiven_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin slide_V = mkV "slepen" | schuiven_V ; -- status=guess, src=wikt status=guess, src=wikt
lin cross_N = mkN "kruis" neuter ; -- status=guess
lin anxious_A = mkA "bezorgd" ; -- status=guess
lin tale_N = mkN "vertelsel" neuter | mkN "verhaaltje" neuter ; -- status=guess status=guess
lin preference_N = variants{} ; -- 
lin inevitably_Adv = variants{} ; -- 
lin mere_A = mkA "schamel" | mkA "luttel" ; -- status=guess status=guess
lin behave_V = reflMkV "gedragen" ; -- status=guess, src=wikt
lin gain_N = mkN "winst" feminine ; -- status=guess
lin nervous_A = mkA "nerveus" ; -- status=guess
lin guide_V2 = variants{} ; -- 
lin remark_N = mkN "opmerking" feminine ; -- status=guess
lin pleased_A = variants{} ; -- 
lin province_N = mkN "provincie" feminine ; -- status=guess
lin steel_N = L.steel_N ;
lin practise_V2 = variants{} ; -- 
lin practise_V = variants{} ; -- 
lin flow_V = L.flow_V ;
lin holy_A = mkA "heilig" ; -- status=guess
lin dose_N = mkN "doos" ; -- status=guess
lin alcohol_N = mkN "alcohol" masculine | mkN "alcoholische drank" masculine | mkN "sterke drank" masculine ; -- status=guess status=guess status=guess
lin guidance_N = variants{} ; -- 
lin constantly_Adv = variants{} ; -- 
lin climate_N = mkN "klimaat" neuter ; -- status=guess
lin enhance_V2 = mkV2 (mkV "vergroten") | mkV2 (mkV "uitbreiden") ; -- status=guess, src=wikt status=guess, src=wikt
lin reasonably_Adv = mkAdv "redelijk" ; -- status=guess
lin waste_V2 = mkV2 (mkV "wegkwijnen") ; -- status=guess, src=wikt
lin waste_V = mkV "wegkwijnen" ; -- status=guess, src=wikt
lin smooth_A = L.smooth_A ;
lin dominant_A = variants{} ; -- 
lin conscious_A = mkA "bij bewustzijn" | mkA "alert" | mkA "wakker" ; -- status=guess status=guess status=guess
lin formula_N = mkN "formule" feminine ; -- status=guess
lin tail_N = L.tail_N ;
lin ha_Interj = variants{} ; -- 
lin electric_A = variants{} ; -- 
lin sheep_N = L.sheep_N ;
lin medicine_N = mkN "geneeskunde" feminine | mkN "artsenij" feminine ; -- status=guess status=guess
lin strategic_A = mkA "strategisch" ; -- status=guess
lin disabled_A = mkA "gehandicapt" | mkA "invalide" | mkA "mindervalide" ; -- status=guess status=guess status=guess
lin smell_N = mkN "geur" masculine | mkN "reuk" masculine | mkN "stank" masculine ; -- status=guess status=guess status=guess
lin operator_N = mkN "bediener" masculine ; -- status=guess
lin mount_V2 = mkV2 (mkV "monteren") | mkV2 (mkV "bevestigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin mount_V = mkV "monteren" | mkV "bevestigen" ; -- status=guess, src=wikt status=guess, src=wikt
lin advance_V2 = mkV2 (mkV "voorschieten") ; -- status=guess, src=wikt
lin advance_V = mkV "voorschieten" ; -- status=guess, src=wikt
lin remote_A = mkA "verwijderd" | mkA "afgelegen" | mkA "van op afstand" | mkA "veraf" ; -- status=guess status=guess status=guess status=guess
lin measurement_N = variants{} ; -- 
lin favour_VS = variants{} ; -- 
lin favour_V2 = variants{} ; -- 
lin favour_V = variants{} ; -- 
lin neither_Det = mkDet "geen van beide" ; -- status=guess
lin architecture_N = mkN "architectuur" feminine ; -- status=guess
lin worth_N = mkN "waarde" feminine ; -- status=guess
lin tie_N = mkN "boog" ; -- status=guess
lin barrier_N = mkN "barrière" utrum ; -- status=guess
lin practitioner_N = mkN "beoefenaar" masculine ; -- status=guess
lin outstanding_A = mkA "bijzonder" | mkA "vooraanstaand" ; -- status=guess status=guess
lin enthusiasm_N = mkN "enthousiasme" neuter | mkN "geestdrift" ; -- status=guess status=guess
lin theoretical_A = mkA "theoretisch" ; -- status=guess
lin implementation_N = mkN "implementatie" feminine ; -- status=guess
lin worried_A = mkA "ongerust" | mkA "bezorgd" ; -- status=guess status=guess
lin pitch_N = mkN "pek" feminine ; -- status=guess
lin drop_N = mkN "val" masculine ; -- status=guess
lin phone_V2 = mkV2 (mkV "telefoneren") ; -- status=guess, src=wikt
lin phone_V = mkV "telefoneren" ; -- status=guess, src=wikt
lin shape_VV = mkVV (mkV (mkV "de") "vorm aannemen") ; -- status=guess, src=wikt
lin shape_V2 = mkV2 (mkV (mkV "de") "vorm aannemen") ; -- status=guess, src=wikt
lin shape_V = mkV (mkV "de") "vorm aannemen" ; -- status=guess, src=wikt
lin clinical_A = mkA "klinisch" ; -- status=guess
lin lane_N = mkN "rijvak" neuter | mkN "rijstrook" masculine ; -- status=guess status=guess
lin apple_N = L.apple_N ;
lin catalogue_N = mkN "catalogus" masculine | mkN "cataloog" | mkN "inventaris" masculine ; -- status=guess status=guess status=guess
lin tip_N = mkN "stort " neuter | mkN "stortplaats" | mkN "vuilnisbelt" masculine feminine ; -- status=guess status=guess status=guess
lin publisher_N = mkN "uitgever" masculine | mkN "uitgeverij" ; -- status=guess status=guess
lin opponentMasc_N = mkN "opponent" | mkN "tegenstander" ; -- status=guess status=guess
lin live_A = mkA "scherp" | mkA "scherpe" ; -- status=guess status=guess
lin burden_N = mkN "last" masculine ; -- status=guess
lin tackle_V2 = mkV2 (mkV "aanpakken") ; -- status=guess, src=wikt
lin tackle_V = mkV "aanpakken" ; -- status=guess, src=wikt
lin historian_N = mkN "historicus" masculine | mkN "geschiedkundige" masculine feminine ; -- status=guess status=guess
lin bury_V2 = mkV2 (mkV "begraven") ; -- status=guess, src=wikt
lin bury_V = mkV "begraven" ; -- status=guess, src=wikt
lin stomach_N = mkN "buik" ; -- status=guess
lin percentage_N = variants{} ; -- 
lin evaluation_N = mkN "beoordeling" feminine | mkN "evaluatie" feminine ; -- status=guess status=guess
lin outline_V2 = variants{} ; -- 
lin talent_N = mkN "talent" ; -- status=guess
lin lend_V2 = mkV2 (mkV "lenen") | mkV2 (mkV "uitlenen") ; -- status=guess, src=wikt status=guess, src=wikt
lin lend_V = mkV "lenen" | mkV "uitlenen" ; -- status=guess, src=wikt status=guess, src=wikt
lin silver_N = L.silver_N ;
lin pack_N = variants{} ; -- 
lin fun_N = mkN "lol" masculine | mkN "plezier" neuter | mkN "pret" feminine ; -- status=guess status=guess status=guess
lin democrat_N = mkN "democraat" masculine ; -- status=guess
lin fortune_N = mkN "kans" utrum | mkN "geluk" neuter ; -- status=guess status=guess
lin storage_N = mkN "opslag" masculine ; -- status=guess
lin professional_N = mkN "deskundige" | mkN "expert" masculine ; -- status=guess status=guess
lin reserve_N = mkN "reserve" masculine feminine ; -- status=guess
lin interval_N = mkN "interval" neuter ; -- status=guess
lin dimension_N = mkN "dimensie" feminine ; -- status=guess
lin honest_A = mkA "eerlijk" ; -- status=guess
lin awful_A = mkA "vreselijk" ; -- status=guess
lin manufacture_V2 = mkV2 (mkV "vervaardigen") ; -- status=guess, src=wikt
lin confusion_N = mkN "verwarring" ; -- status=guess
lin pink_A = variants{} ; -- 
lin impressive_A = mkA "onder de indruk" ; -- status=guess
lin satisfaction_N = mkN "voldoening" feminine | mkN "bevrediging" feminine ; -- status=guess status=guess
lin visible_A = mkA "zichtbaar" | mkA "zichtbare" ; -- status=guess status=guess
lin vessel_N = mkN "vat" neuter | mkN "hulsel" neuter ; -- status=guess status=guess
lin stand_N = mkN "positie" feminine ; -- status=guess
lin curve_N = mkN "curve" feminine | mkN "kromming" feminine | mkN "bocht" masculine ; -- status=guess status=guess status=guess
lin pot_N = mkN "wiet" ; -- status=guess
lin replacement_N = mkN "vervanger" masculine | mkN "plaatsvervanger" masculine | mkN "vervanging" feminine ; -- status=guess status=guess status=guess
lin accurate_A = mkA "accuraat" | mkA "precies" | mkA "exact" | mkA "trefzeker" | mkA "nauwkeurig" ; -- status=guess status=guess status=guess status=guess status=guess
lin mortgage_N = mkN "hypotheek" masculine ; -- status=guess
lin salary_N = mkN "salaris" neuter | mkN "loon" neuter ; -- status=guess status=guess
lin impress_V2 = mkV2 (mkV "ronselen") ; -- status=guess, src=wikt
lin impress_V = mkV "ronselen" ; -- status=guess, src=wikt
lin constitutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (mkV "benadrukken") ; -- status=guess, src=wikt
lin emphasize_V2 = mkV2 (mkV "benadrukken") ; -- status=guess, src=wikt
lin developing_A = variants{} ; -- 
lin proof_N = mkN "bewijs" neuter ; -- status=guess
lin furthermore_Adv = mkAdv "daarenboven" | mkAdv "bovendien" ; -- status=guess status=guess
lin dish_N = mkN "bord" neuter | mkN "gerecht" neuter ; -- status=guess status=guess
lin interview_V2 = mkV2 (mkV "interviewen") ; -- status=guess, src=wikt
lin considerably_Adv = mkAdv "aanzienlijk" ; -- status=guess
lin distant_A = mkA "afstandelijk" ; -- status=guess
lin lower_V2 = variants{} ; -- 
lin lower_V = variants{} ; -- 
lin favouriteMasc_N = variants{} ; -- 
lin tear_V2 = mkV2 (mkV "scheuren") ; -- status=guess, src=wikt
lin tear_V = mkV "scheuren" ; -- status=guess, src=wikt
lin fixed_A = variants{} ; -- 
lin by_Adv = mkAdv "langs" ; -- status=guess
lin luck_N = mkN "geluk" neuter ; -- status=guess
lin count_N = mkN "aftelling" feminine ; -- status=guess
lin precise_A = mkA "nauwkeurig" | mkA "precies" ; -- status=guess status=guess
lin determination_N = variants{} ; -- 
lin bite_V2 = L.bite_V2 ;
lin bite_V = mkV (mkV "te") "veel hooi op de vork nemen" ; -- status=guess, src=wikt
lin dear_Interj = variants{} ; -- 
lin consultation_N = mkN "consultatie" feminine ; -- status=guess
lin range_V = variants{} ; -- 
lin residential_A = variants{} ; -- 
lin conduct_N = variants{} ; -- 
lin capture_V2 = variants{} ; -- 
lin ultimately_Adv = variants{} ; -- 
lin cheque_N = mkN "cheque" masculine ; -- status=guess
lin economics_N = mkN "economie" feminine ; -- status=guess
lin sustain_V2 = mkV2 (mkV (mkV "in") "stand houden") ; -- status=guess, src=wikt
lin secondly_Adv = variants{} ; -- 
lin silly_A = mkA "ondoordacht" ; -- status=guess
lin merchant_N = mkN "koopman" masculine ; -- status=guess
lin lecture_N = mkN "lezing" feminine | mkN "college" ; -- status=guess status=guess
lin musical_A = mkA "muzikaal" ; -- status=guess
lin leisure_N = mkN "vrije tijd" masculine ; -- status=guess
lin check_N = mkN "rekening" feminine ; -- status=guess
lin cheese_N = L.cheese_N ;
lin lift_N = mkN "lift" masculine ; -- status=guess
lin participate_V2 = mkV2 (mkV "meedoen") | mkV2 (mkV "deelnemen") | mkV2 (mkV "participeren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin participate_V = mkV "meedoen" | mkV "deelnemen" | mkV "participeren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fabric_N = mkN "weefsel" neuter ; -- status=guess
lin distribute_V2 = mkV2 (mkV "verdelen") ; -- status=guess, src=wikt
lin lover_N = mkN "minnaar" masculine | mkN "minnares" feminine ; -- status=guess status=guess
lin childhood_N = mkN "kinderjaren" neuter | mkN "kindertijd" masculine ; -- status=guess status=guess
lin cool_A = mkA "koel" | mkA "verkoelend" | mkA "verkwikkend" ; -- status=guess status=guess status=guess
lin ban_V2 = variants{} ; -- 
lin supposed_A = mkA "vermeend" ; -- status=guess
lin mouse_N = mkN "grijze mierklauwier" ; -- status=guess
lin strain_N = mkN "rekstrookje" neuter ; -- status=guess
lin specialist_A = variants{} ; -- 
lin consult_V2 = mkV2 (mkV "raadplegen") ; -- status=guess, src=wikt
lin consult_V = mkV "raadplegen" ; -- status=guess, src=wikt
lin minimum_A = variants{} ; -- 
lin approximately_Adv = mkAdv "ongeveer" ; -- status=guess
lin participant_N = mkN "deelnemer" masculine ; -- status=guess
lin monetary_A = variants{} ; -- 
lin confuse_V2 = mkV2 (mkV "verwarren") | mkV2 (mkV (mkV "in") "de war brengen") | mkV2 (mkV "dooreenhalen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dare_VV = mkVV (mkV "riskeren") | mkVV (mkV "wagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin dare_V2 = mkV2 (mkV "riskeren") | mkV2 (mkV "wagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin smoke_N = L.smoke_N ;
lin movie_N = mkN "film" masculine ; -- status=guess
lin seed_N = L.seed_N ;
lin cease_V2 = mkV2 (mkV (mkV "houd") "op en doe van afstand") ; -- status=guess, src=wikt
lin cease_V = mkV (mkV "houd") "op en doe van afstand" ; -- status=guess, src=wikt
lin open_Adv = variants{} ; -- 
lin journal_N = variants{} ; -- 
lin shopping_N = mkN "winkelen {p}" | mkN "boodschappen doen" ; -- status=guess status=guess
lin equivalent_N = variants{} ; -- 
lin palace_N = mkN "paleis" neuter ; -- status=guess
lin exceed_V2 = mkV2 (mkV "overstijgen") | mkV2 (mkV "overtreffen") ; -- status=guess, src=wikt status=guess, src=wikt
lin isolated_A = mkA "geïsoleerd" ; -- status=guess
lin poetry_N = mkN "poëzie" | mkN "dichtwerk" neuter ; -- status=guess status=guess
lin perceive_VS = variants{} ; -- 
lin perceive_V2V = variants{} ; -- 
lin perceive_V2 = variants{} ; -- 
lin lack_V2 = mkV2 (mkV "derven") | mkV2 (mkV "ontberen") | mkV2 (mkV "missen") | mkV2 (mkV (mkV "]]") "gebrek hebben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lack_V = mkV "derven" | mkV "ontberen" | mkV "missen" | mkV (mkV "]]") "gebrek hebben" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin strengthen_V2 = mkV2 (mkV "bezielen") | mkV2 (mkV (mkV "tot") "leven wekken") ; -- status=guess, src=wikt status=guess, src=wikt
lin snap_V2 = mkV2 (mkV "snauwen") ; -- status=guess, src=wikt
lin snap_V = mkV "snauwen" ; -- status=guess, src=wikt
lin readily_Adv = mkAdv "direct" ; -- status=guess
lin spite_N = mkN "boosaardigheid" masculine | mkN "wrok" masculine ; -- status=guess status=guess
lin conviction_N = mkN "overtuiging" ; -- status=guess
lin corridor_N = mkN "luchtweg" | mkN "corridor" ; -- status=guess status=guess
lin behind_Adv = variants{}; -- S.behind_Prep ;
lin ward_N = variants{} ; -- 
lin profile_N = variants{} ; -- 
lin fat_A = mkA "vet" ; -- status=guess
lin comfort_N = mkN "troost" | mkN "gemak" neuter ; -- status=guess status=guess
lin bathroom_N = mkN "badkamer" feminine ; -- status=guess
lin shell_N = mkN "schelp" feminine ; -- status=guess
lin reward_N = mkN "beloning" feminine | mkN "prijs" ; -- status=guess status=guess
lin deliberately_Adv = mkAdv "bewust" | mkAdv "expres" | mkAdv "opzettelijk" | mkAdv "met opzet" ; -- status=guess status=guess status=guess status=guess
lin automatically_Adv = mkAdv "automatisch" ; -- status=guess
lin vegetable_N = mkN "plant" masculine ; -- status=guess
lin imagination_N = mkN "verbeelding" feminine ; -- status=guess
lin junior_A = variants{} ; -- 
lin unemployed_A = mkA "werkloos" ; -- status=guess
lin mystery_N = mkN "mysterie" neuter ; -- status=guess
lin pose_V2 = mkV2 (mkV "poseren") ; -- status=guess, src=wikt
lin pose_V = mkV "poseren" ; -- status=guess, src=wikt
lin violent_A = mkA "gewelddadig" ; -- status=guess
lin march_N = variants{} ; -- 
lin found_V2 = mkV2 (mkV "stichten") ; -- status=guess, src=wikt
lin dig_V2 = mkV2 (graven_V) | mkV2 (mkV "delven") ; -- status=guess, src=wikt status=guess, src=wikt
lin dig_V = L.dig_V ;
lin dirty_A = L.dirty_A ;
lin straight_A = L.straight_A ;
lin psychological_A = variants{} ; -- 
lin grab_V2 = mkV2 (grijpen_V) ; -- status=guess, src=wikt
lin grab_V = grijpen_V ; -- status=guess, src=wikt
lin pleasant_A = mkA "aangenaam" | mkA "behaagelijk" | mkA "plezierig" | mkA "fijn" ; -- status=guess status=guess status=guess status=guess
lin surgery_N = mkN "spreekkamer" ; -- status=guess
lin inevitable_A = mkA "onvermijdelijk" | mkA "onafwendbaar" ; -- status=guess status=guess
lin transform_V2 = variants{} ; -- 
lin bell_N = mkN "belboei" ; -- status=guess
lin announcement_N = mkN "aankondiging" feminine ; -- status=guess
lin draft_N = mkN "slok" masculine ; -- status=guess
lin unity_N = mkN "eenheid" feminine ; -- status=guess
lin airport_N = mkN "luchthaven" feminine | mkN "vlieghaven" feminine ; -- status=guess status=guess
lin upset_V2 = mkV2 (mkV "verstoren") | mkV2 (mkV "verwarren") ; -- status=guess, src=wikt status=guess, src=wikt
lin upset_V = mkV "verstoren" | mkV "verwarren" ; -- status=guess, src=wikt status=guess, src=wikt
lin pretend_VS = mkVS (mkV "voorwenden") | mkVS (mkV (mkV "doen") "alsof") ; -- status=guess, src=wikt status=guess, src=wikt
lin pretend_V2 = mkV2 (mkV "voorwenden") | mkV2 (mkV (mkV "doen") "alsof") ; -- status=guess, src=wikt status=guess, src=wikt
lin pretend_V = mkV "voorwenden" | mkV (mkV "doen") "alsof" ; -- status=guess, src=wikt status=guess, src=wikt
lin plant_V2 = mkV2 (mkV "planten") | mkV2 (mkV "poten") ; -- status=guess, src=wikt status=guess, src=wikt
lin till_Prep = variants{} ; -- 
lin known_A = variants{} ; -- 
lin admission_N = variants{} ; -- 
lin tissue_N = mkN "weefsel" neuter ; -- status=guess
lin magistrate_N = variants{} ; -- 
lin joy_N = mkN "vreugde" feminine ; -- status=guess
lin free_V2V = mkV2V (mkV "bevrijden") | mkV2V (mkV "loslaten") | mkV2V (mkV (mkV "laten") "gaan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin free_V2 = mkV2 (mkV "bevrijden") | mkV2 (mkV "loslaten") | mkV2 (mkV (mkV "laten") "gaan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pretty_A = mkA "mooi" ; -- status=guess
lin operating_N = mkN "operatiekamer" utrum ; -- status=guess
lin headquarters_N = mkN "hoofdkwartier" neuter ; -- status=guess
lin grateful_A = mkA "dankbaar" ; -- status=guess
lin classroom_N = mkN "klaslokaal" neuter ; -- status=guess
lin turnover_N = mkN "omzet" | mkN "verloop" neuter ; -- status=guess status=guess
lin project_VS = variants{} ; -- 
lin project_V2V = variants{} ; -- 
lin project_V2 = variants{} ; -- 
lin project_V = variants{} ; -- 
lin shrug_V2 = variants{} ; -- 
lin sensible_A = mkA "gevoelig" ; -- status=guess
lin limitation_N = mkN "grens" | mkN "beperking" ; -- status=guess status=guess
lin specialist_N = mkN "specialist" masculine feminine ; -- status=guess
lin newly_Adv = variants{} ; -- 
lin tongue_N = L.tongue_N ;
lin refugee_N = mkN "vluchtelingenkamp" neuter ; -- status=guess
lin delay_V2 = mkV2 (mkV "uitstellen") ; -- status=guess, src=wikt
lin delay_V = mkV "uitstellen" ; -- status=guess, src=wikt
lin dream_V2 = mkV2 (mkV "dromen") ; -- status=guess, src=wikt
lin dream_V = mkV "dromen" ; -- status=guess, src=wikt
lin composition_N = mkN "combinatie" ; -- status=guess
lin alongside_Prep = variants{} ; -- 
lin ceiling_N = L.ceiling_N ;
lin highlight_V2 = variants{} ; -- 
lin stick_N = L.stick_N ;
lin favourite_A = variants{} ; -- 
lin tap_V2 = mkV2 (mkV "draadtappen") ; -- status=guess, src=wikt
lin tap_V = mkV "draadtappen" ; -- status=guess, src=wikt
lin universe_N = mkN "heelal" neuter | mkN "universum" neuter ; -- status=guess status=guess
lin request_VS = mkVS (mkV "verzoeken") ; -- status=guess, src=wikt
lin request_V2 = mkV2 (mkV "verzoeken") ; -- status=guess, src=wikt
lin label_N = mkN "platenmaatschappij" feminine | mkN "label" neuter ; -- status=guess status=guess
lin confine_V2 = mkV2 (mkV "begrenzen") | mkV2 (mkV "inperken") | mkV2 (mkV "beperken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin scream_VS = mkVS (mkV "schreeuwen") ; -- status=guess, src=wikt
lin scream_V2 = mkV2 (mkV "schreeuwen") ; -- status=guess, src=wikt
lin scream_V = mkV "schreeuwen" ; -- status=guess, src=wikt
lin rid_V2 = mkV2 (mkV "kwijt") ; -- status=guess, src=wikt
lin acceptance_N = variants{} ; -- 
lin detective_N = mkN "detective" masculine | mkN "speurder" masculine ; -- status=guess status=guess
lin sail_V = mkV "zeilen" ; -- status=guess, src=wikt
lin adjust_V2 = mkV2 (mkV "aanpassen") | mkV2 (mkV "herzien") | mkV2 (mkV "verbeteren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin adjust_V = mkV "aanpassen" | mkV "herzien" | mkV "verbeteren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin designer_N = mkN "ontwerper" masculine | mkN "designer" masculine ; -- status=guess status=guess
lin running_A = variants{} ; -- 
lin summit_N = mkN "top" masculine | mkN "bergtop" masculine | mkN "piek" feminine | mkN "spits" feminine ; -- status=guess status=guess status=guess status=guess
lin participation_N = mkN "deelname" feminine | mkN "deelneming" feminine ; -- status=guess status=guess
lin weakness_N = mkN "zwakte" ; -- status=guess
lin block_V2 = mkV2 (mkV "verhinderen") | mkV2 (mkV "tegenhouden") ; -- status=guess, src=wikt status=guess, src=wikt
lin socalled_A = variants{} ; -- 
lin adapt_V2 = mkV2 (mkV "aanpassen") | mkV2 (mkV "bewerken") ; -- status=guess, src=wikt status=guess, src=wikt
lin adapt_V = mkV "aanpassen" | mkV "bewerken" ; -- status=guess, src=wikt status=guess, src=wikt
lin absorb_V2 = mkV2 (mkV "absorberen") | mkV2 (mkV "imeä") ; -- status=guess, src=wikt status=guess, src=wikt
lin encounter_V2 = mkV2 (mkV "ontmoeten") | mkV2 (mkV (mkV "oog") "in oog staan") ; -- status=guess, src=wikt status=guess, src=wikt
lin defeat_V2 = mkV2 (mkV "verslaan") | mkV2 (mkV "overwinnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin excitement_N = variants{} ; -- 
lin brick_N = mkN "baksteen" | mkN "bakstenen" ; -- status=guess status=guess
lin blind_A = mkA "blind" ; -- status=guess
lin wire_N = mkN "draad" masculine ; -- status=guess
lin crop_N = mkN "rijzweepje" neuter ; -- status=guess
lin square_A = mkA "met rechte hoek" ; -- status=guess
lin transition_N = mkN "overgang" masculine ; -- status=guess
lin thereby_Adv = mkAdv "daarbij" ; -- status=guess
lin protest_V2 = mkV2 (mkV "protesteren") ; -- status=guess, src=wikt
lin protest_V = mkV "protesteren" ; -- status=guess, src=wikt
lin roll_N = mkN "rol" ; -- status=guess
lin stop_N = mkN "occlusief" masculine ; -- status=guess
lin assistant_N = mkN "assistent" masculine ; -- status=guess
lin deaf_A = mkA "doof" | mkA "dove" ; -- status=guess status=guess
lin constituency_N = mkN "kiesdistrict" ; -- status=guess
lin continuous_A = mkA "continu" ; -- status=guess
lin concert_N = mkN "concert" neuter ; -- status=guess
lin breast_N = L.breast_N ;
lin extraordinary_A = mkA "buitengewoon" ; -- status=guess
lin squad_N = variants{} ; -- 
lin wonder_N = mkN "wonder" neuter ; -- status=guess
lin cream_N = mkN "crème" feminine ; -- status=guess
lin tennis_N = mkN "tennis" ; -- status=guess
lin personally_Adv = mkAdv "eigenhandig" ; -- status=guess
lin communicate_V2 = mkV2 (mkV "communiceren") ; -- status=guess, src=wikt
lin communicate_V = mkV "communiceren" ; -- status=guess, src=wikt
lin pride_N = mkN "troep" ; -- status=guess
lin bowl_N = mkN "schaal" utrum | mkN "kom {p}" ; -- status=guess status=guess
lin file_V2 = mkV2 (mkV "archiveren") ; -- status=guess, src=wikt
lin file_V = mkV "archiveren" ; -- status=guess, src=wikt
lin expertise_N = variants{} ; -- 
lin govern_V2 = mkV2 (mkV "beheersen") ; -- status=guess, src=wikt
lin govern_V = mkV "beheersen" ; -- status=guess, src=wikt
lin leather_N = L.leather_N ;
lin observer_N = mkN "observator" masculine ; -- status=guess
lin margin_N = mkN "kantlijn" utrum | mkN "marge" utrum ; -- status=guess status=guess
lin uncertainty_N = mkN "onzekerheid" feminine ; -- status=guess
lin reinforce_V2 = mkV2 (mkV "benadrukken") ; -- status=guess, src=wikt
lin ideal_N = mkN "ideaal" neuter | mkN "perfectie" feminine | mkN "streefdoel" neuter ; -- status=guess status=guess status=guess
lin injure_V2 = variants{} ; -- 
lin holding_N = variants{} ; -- 
lin universal_A = mkA "universeel" ; -- status=guess
lin evident_A = variants{} ; -- 
lin dust_N = L.dust_N ;
lin overseas_A = mkA "overzees" ; -- status=guess
lin desperate_A = mkA "wanhopig" | mkA "vertwijfeld" | mkA "radeloos" | mkA "hopeloos" | mkA "desperaat" ; -- status=guess status=guess status=guess status=guess status=guess
lin swim_V2 = mkV2 (zwemmen_V) ; -- status=guess, src=wikt
lin swim_V = L.swim_V ;
lin occasional_A = mkA "toevallig" | mkA "nu en dan" | mkA "af en toe" ; -- status=guess status=guess status=guess
lin trouser_N = mkN "broekpers" | mkN "broekenpers" ; -- status=guess status=guess
lin surprisingly_Adv = mkAdv "verrassend" ; -- status=guess
lin register_N = variants{} ; -- 
lin album_N = mkN "album" neuter ; -- status=guess
lin guideline_N = variants{} ; -- 
lin disturb_V2 = mkV2 (mkV "storen") | mkV2 (mkV "verstoren") ; -- status=guess, src=wikt status=guess, src=wikt
lin amendment_N = variants{} ; -- 
lin architectMasc_N = mkN "architect" masculine | mkN "bouwmeester" masculine ; -- status=guess status=guess
lin objection_N = mkN "bezwaar" neuter ; -- status=guess
lin chart_N = variants{} ; -- 
lin cattle_N = mkN "vee" neuter ; -- status=guess
lin doubt_VS = mkVS (mkV "twijfelen") | mkVS (mkV "betwijfelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin doubt_V2 = mkV2 (mkV "twijfelen") | mkV2 (mkV "betwijfelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin react_V = mkV "reageren" ; -- status=guess, src=wikt
lin consciousness_N = mkN "bewustzijn" neuter ; -- status=guess
lin right_Interj = mkInterj "toch" ; -- status=guess
lin purely_Adv = variants{} ; -- 
lin tin_N = mkN "blik" neuter | mkN "conservenblik" neuter ; -- status=guess status=guess
lin tube_N = mkN "buis" feminine ; -- status=guess
lin fulfil_V2 = variants{} ; -- 
lin commonly_Adv = variants{} ; -- 
lin sufficiently_Adv = variants{} ; -- 
lin coin_N = mkN "munt" masculine | mkN "muntstuk" neuter | mkN "geldstuk" neuter ; -- status=guess status=guess status=guess
lin frighten_V2 = mkV2 (mkV (mkV "bang") "maken") | mkV2 (mkV "beangstigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin grammar_N = L.grammar_N ;
lin diary_N = mkN "dagboek" ; -- status=guess
lin flesh_N = mkN "vlees" neuter ; -- status=guess
lin summary_N = mkN "samenvatting" feminine | mkN "overzicht" neuter | mkN "opsomming" feminine ; -- status=guess status=guess status=guess
lin infant_N = mkN "zuigeling" masculine feminine ; -- status=guess
lin stir_V2 = mkV2 (mkV "roeren") ; -- status=guess, src=wikt
lin stir_V = mkV "roeren" ; -- status=guess, src=wikt
lin storm_N = mkN "bui" feminine | mkN "onweer" neuter | mkN "onweersbui" feminine ; -- status=guess status=guess status=guess
lin mail_N = mkN "post" feminine ; -- status=guess
lin rugby_N = mkN "rugby" neuter ; -- status=guess
lin virtue_N = mkN "deugd" feminine ; -- status=guess
lin specimen_N = mkN "specimen" neuter ; -- status=guess
lin psychology_N = mkN "psychologie" feminine | mkN "zielkunde" feminine ; -- status=guess status=guess
lin paint_N = mkN "verf" feminine | mkN "tjet" masculine ; -- status=guess status=guess
lin constraint_N = mkN "beperking" feminine | mkN "randvoorwaarde" feminine ; -- status=guess status=guess
lin trace_V2 = mkV2 (mkV "overtrekken") | mkV2 (mkV "calqueren") ; -- status=guess, src=wikt status=guess, src=wikt
lin trace_V = mkV "overtrekken" | mkV "calqueren" ; -- status=guess, src=wikt status=guess, src=wikt
lin privilege_N = mkN "voorrecht" neuter ; -- status=guess
lin completion_N = mkN "vervollediging" feminine | mkN "afronding" feminine | mkN "afwerking" feminine | mkN "voltooiing" feminine ; -- status=guess status=guess status=guess status=guess
lin progress_V2 = variants{} ; -- 
lin progress_V = variants{} ; -- 
lin grade_N = variants{} ; -- 
lin exploit_V2 = mkV2 (mkV "exploiteren") | mkV2 (mkV "uitbuiten") ; -- status=guess, src=wikt status=guess, src=wikt
lin import_N = mkN "invoervergunning" ; -- status=guess
lin potato_N = mkN "aardappel" feminine | mkN "pieper" masculine | mkN "patat" feminine ; -- status=guess status=guess status=guess
lin repair_N = mkN "herstelling" feminine ; -- status=guess
lin passion_N = mkN "passie" feminine ; -- status=guess
lin seize_V2 = mkV2 (grijpen_V) | mkV2 (vangen_V) | mkV2 (mkV "pakken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin seize_V = grijpen_V | vangen_V | mkV "pakken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin low_Adv = variants{} ; -- 
lin underlying_A = mkA "achterliggend" ; -- status=guess
lin heaven_N = mkN "hemel" masculine | mkN "paradijs" neuter | mkN "hof van Eden" neuter | mkN "tuin der lusten" masculine ; -- status=guess status=guess status=guess status=guess
lin nerve_N = mkN "zenuw" feminine | mkN "neuronenbundel" ; -- status=guess status=guess
lin park_V2 = mkV2 (mkV "parkeren") ; -- status=guess, src=wikt
lin park_V = mkV "parkeren" ; -- status=guess, src=wikt
lin collapse_V2 = mkV2 (mkV "instorten") ; -- status=guess, src=wikt
lin collapse_V = mkV "instorten" ; -- status=guess, src=wikt
lin win_N = mkN "overwinning" feminine ; -- status=guess
lin printer_N = mkN "printer" ; -- status=guess
lin coalition_N = mkN "coalitie" feminine ; -- status=guess
lin button_N = mkN "badge" feminine ; -- status=guess
lin pray_V2 = mkV2 (mkV "smeken") ; -- status=guess, src=wikt
lin pray_V = mkV "smeken" ; -- status=guess, src=wikt
lin ultimate_A = mkA "definitief" ; -- status=guess
lin venture_N = mkN "risicovolle onderneming of reis" ; -- status=guess
lin timber_N = mkN "dakbalk" masculine | mkN "balk" masculine ; -- status=guess status=guess
lin companion_N = mkN "metgezel" masculine ; -- status=guess
lin horror_N = variants{} ; -- 
lin gesture_N = mkN "gebaar" neuter ; -- status=guess
lin moon_N = L.moon_N ;
lin remark_VS = mkVS (mkV "opmerken") | mkVS (mkV "bemerken") ; -- status=guess, src=wikt status=guess, src=wikt
lin remark_V = mkV "opmerken" | mkV "bemerken" ; -- status=guess, src=wikt status=guess, src=wikt
lin clever_A = L.clever_A ;
lin van_N = mkN "bestelwagen" masculine ; -- status=guess
lin consequently_Adv = mkAdv "bijgevolg" ; -- status=guess
lin raw_A = mkA "pril" | mkA "prille" ; -- status=guess status=guess
lin glance_N = variants{} ; -- 
lin broken_A = mkA "gebroken" | mkA "gekraakt" ; -- status=guess status=guess
lin jury_N = variants{} ; -- 
lin gaze_V = mkV "staren" | mkV "turen" ; -- status=guess, src=wikt status=guess, src=wikt
lin burst_V2 = mkV2 (barsten_V) ; -- status=guess, src=wikt
lin burst_V = barsten_V ; -- status=guess, src=wikt
lin charter_N = variants{} ; -- 
lin feministMasc_N = mkN "feminist" masculine | mkN "feministe" feminine ; -- status=guess status=guess
lin discourse_N = mkN "betoog" neuter | mkN "discussie" | mkN "gesprek" neuter | mkN "conversatie" | mkN "uiting" ; -- status=guess status=guess status=guess status=guess status=guess
lin reflection_N = mkN "reflectie" feminine | mkN "weerspiegeling" feminine | mkN "weerbeeld" neuter ; -- status=guess status=guess status=guess
lin carbon_N = mkN "koolstof" neuter | mkN "carboun" | mkN "carbong" ; -- status=guess status=guess status=guess
lin sophisticated_A = mkA "geperfectioneerd" ; -- status=guess
lin ban_N = variants{} ; -- 
lin taxation_N = variants{} ; -- 
lin prosecution_N = variants{} ; -- 
lin softly_Adv = mkAdv "zacht" ; -- status=guess
lin asleep_A = mkA "slapend" ; -- status=guess
lin aids_N = variants{} ; -- 
lin publicity_N = mkN "publiciteit" ; -- status=guess
lin departure_N = mkN "overlijden" neuter ; -- status=guess
lin welcome_A = mkA "welkom" | mkA "welkome" | mkA "graag gezien" ; -- status=guess status=guess status=guess
lin sharply_Adv = variants{} ; -- 
lin reception_N = mkN "ontvangst" ; -- status=guess
lin cousin_N = L.cousin_N ;
lin relieve_V2 = variants{} ; -- 
lin linguistic_A = variants{} ; -- 
lin vat_N = variants{} ; -- 
lin forward_A = variants{} ; -- 
lin blue_N = mkN "blauw" neuter ; -- status=guess
lin multiple_A = mkA "meerdere" ; -- status=guess
lin pass_N = mkN "passage" feminine ; -- status=guess
lin outer_A = variants{} ; -- 
lin vulnerable_A = mkA "kwetsbaar" ; -- status=guess
lin patient_A = mkA "geduldig" ; -- status=guess
lin evolution_N = mkN "evolutie" feminine ; -- status=guess
lin allocate_V2 = variants{} ; -- 
lin allocate_V = variants{} ; -- 
lin creative_A = mkA "creatief" ; -- status=guess
lin potentially_Adv = mkAdv "potentieel" ; -- status=guess
lin just_A = mkA "zowat" ; -- status=guess
lin out_Prep = variants{} ; -- 
lin judicial_A = mkA "gerechtelijk" ; -- status=guess
lin risk_VV = mkVV (mkV (mkV "risico") "nemen") | mkVV (mkV "riskeren") ; -- status=guess, src=wikt status=guess, src=wikt
lin risk_V2 = mkV2 (mkV (mkV "risico") "nemen") | mkV2 (mkV "riskeren") ; -- status=guess, src=wikt status=guess, src=wikt
lin ideology_N = mkN "ideologie" ; -- status=guess
lin smell_VA = mkVA (ruiken_V) | mkVA (mkV "geuren") | mkVA (stinken_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin smell_V2 = mkV2 (ruiken_V) | mkV2 (mkV "geuren") | mkV2 (stinken_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin smell_V = L.smell_V ;
lin agenda_N = mkN "agenda" masculine | mkN "programma" neuter ; -- status=guess status=guess
lin transport_V2 = mkV2 (mkV "overbrengen") | mkV2 (mkV "voeren") | mkV2 (mkV "vervoeren") | mkV2 (mkV "transporteren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin illegal_A = mkA "strafbaar" | mkA "illegaal" | mkA "onwettig" ; -- status=guess status=guess status=guess
lin chicken_N = mkN "kip" feminine | mkN "hen" feminine | mkN "hoen" neuter ; -- status=guess status=guess status=guess
lin plain_A = mkA "kaal" ; -- status=guess
lin innovation_N = mkN "innovatie" feminine ; -- status=guess
lin opera_N = mkN "opera" masculine ; -- status=guess
lin lock_N = mkN "haan" masculine ; -- status=guess
lin grin_V = mkV "grijnzen" ; -- status=guess, src=wikt
lin shelf_N = mkN "schap" neuter | mkN "rek" neuter ; -- status=guess status=guess
lin pole_N = mkN "pool" ; -- status=guess
lin punishment_N = mkN "afstraffing" feminine | mkN "beproeving" feminine | mkN "vergelding" feminine ; -- status=guess status=guess status=guess
lin strict_A = mkA "streng" ; -- status=guess
lin wave_V2 = mkV2 (mkV "zwaaien") | mkV2 (mkV "zwenken") | mkV2 (mkV "wapperen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wave_V = mkV "zwaaien" | mkV "zwenken" | mkV "wapperen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin inside_N = mkN "binnenkant" masculine ; -- status=guess
lin carriage_N = mkN "wagon" masculine ; -- status=guess
lin fit_A = mkA "fit" ; -- status=guess
lin conversion_N = mkN "omzetting" feminine ; -- status=guess
lin hurry_V = variants{} ; -- 
lin essay_N = mkN "poging" feminine ; -- status=guess
lin integration_N = mkN "integratie" feminine ; -- status=guess
lin resignation_N = mkN "aftreding" feminine ; -- status=guess
lin treasury_N = variants{} ; -- 
lin traveller_N = mkN "reiziger" masculine ; -- status=guess
lin chocolate_N = mkN "chocoladevlok" masculine feminine ; -- status=guess
lin assault_N = mkN "aanranding" feminine ; -- status=guess
lin schedule_N = mkN "programma" neuter ; -- status=guess
lin undoubtedly_Adv = mkAdv "ongetwijfeld" | mkAdv "zonder twijfel" ; -- status=guess status=guess
lin twin_N = mkN "tweeling" masculine ; -- status=guess
lin format_N = mkN "bestandstype" neuter | mkN "bestandsformaat" neuter ; -- status=guess status=guess
lin murder_V2 = mkV2 (mkV (mkV "de") "grond in boren") ; -- status=guess, src=wikt
lin sigh_VS = mkVS (mkV "zuchten") ; -- status=guess, src=wikt
lin sigh_V2 = mkV2 (mkV "zuchten") ; -- status=guess, src=wikt
lin sigh_V = mkV "zuchten" ; -- status=guess, src=wikt
lin sellerMasc_N = mkN "verkoper" masculine | mkN "verkoopster" feminine ; -- status=guess status=guess
lin lease_N = variants{} ; -- 
lin bitter_A = mkA "verbitterd" ; -- status=guess
lin double_V2 = mkV2 (mkV "dubbelklikken") ; -- status=guess, src=wikt
lin double_V = mkV "dubbelklikken" ; -- status=guess, src=wikt
lin ally_N = mkN "bondgenoot" masculine | mkN "bondgenote" feminine ; -- status=guess status=guess
lin stake_N = mkN "staak" ; -- status=guess
lin processing_N = variants{} ; -- 
lin informal_A = variants{} ; -- 
lin flexible_A = mkA "flexibel" ; -- status=guess
lin cap_N = L.cap_N ;
lin stable_A = mkA "stabiel" ; -- status=guess
lin till_Subj = variants{} ; -- 
lin sympathy_N = mkN "medelijden" ; -- status=guess
lin tunnel_N = mkN "tunnel" masculine ; -- status=guess
lin pen_N = L.pen_N ;
lin instal_V = variants{} ; -- 
lin suspend_V2 = mkV2 (mkV "suspenderen") ; -- status=guess, src=wikt
lin suspend_V = mkV "suspenderen" ; -- status=guess, src=wikt
lin blow_N = mkN "slag" masculine ; -- status=guess
lin wander_V = mkV "afdwalen" ; -- status=guess, src=wikt
lin notably_Adv = variants{} ; -- 
lin disappoint_V2 = mkV2 (mkV "teleurstellen") ; -- status=guess, src=wikt
lin wipe_V2 = L.wipe_V2 ;
lin wipe_V = mkV "wissen" ; -- status=guess, src=wikt
lin folk_N = mkN "volk" ; -- status=guess
lin attraction_N = mkN "attractie" feminine | mkN "trekpleister" masculine ; -- status=guess status=guess
lin disc_N = mkN "schijf" feminine ; -- status=guess
lin inspire_V2V = mkV2V (mkV "beademen") ; -- status=guess, src=wikt
lin inspire_V2 = mkV2 (mkV "beademen") ; -- status=guess, src=wikt
lin machinery_N = mkN "machinerie" feminine ; -- status=guess
lin undergo_V2 = mkV2 (mkV "ondergaan") ; -- status=guess, src=wikt
lin nowhere_Adv = mkAdv "nergens" ; -- status=guess
lin inspector_N = variants{} ; -- 
lin wise_A = mkA "wijs" ; -- status=guess
lin balance_V2 = variants{} ; -- 
lin balance_V = variants{} ; -- 
lin purchaser_N = mkN "koper" ; -- status=guess
lin resort_N = mkN "vakantieoord" ; -- status=guess
lin pop_N = mkN "pap" ; -- status=guess
lin organ_N = mkN "orgaan" neuter ; -- status=guess
lin ease_V2 = variants{} ; -- 
lin ease_V = variants{} ; -- 
lin friendship_N = mkN "vriendschap" feminine ; -- status=guess
lin deficit_N = mkN "tekort" | mkN "gat in de begroting" feminine ; -- status=guess status=guess
lin dear_N = mkN "lieverd" | mkN "schat" ; -- status=guess status=guess
lin convey_V2 = mkV2 (mkV "overdragen") ; -- status=guess, src=wikt
lin reserve_V2 = mkV2 (mkV "reserveren") ; -- status=guess, src=wikt
lin reserve_V = mkV "reserveren" ; -- status=guess, src=wikt
lin planet_N = L.planet_N ;
lin frequent_A = mkA "veelvuldig" | mkA "frequent" ; -- status=guess status=guess
lin loose_A = mkA "los" | mkA "mul" ; -- status=guess status=guess
lin intense_A = variants{} ; -- 
lin retail_A = variants{} ; -- 
lin wind_V = mkV "terugspoelen" ; -- status=guess, src=wikt
lin lost_A = mkA "verloren" | mkA "verdwaald" ; -- status=guess status=guess
lin grain_N = mkN "graan" neuter ; -- status=guess
lin particle_N = mkN "deeltjesversneller" masculine ; -- status=guess
lin destruction_N = mkN "vernietiging" feminine ; -- status=guess
lin witness_V2 = variants{} ; -- 
lin witness_V = variants{} ; -- 
lin pit_N = mkN "pit" masculine ; -- status=guess
lin registration_N = mkN "registratie" feminine ; -- status=guess
lin conception_N = variants{} ; -- 
lin steady_A = variants{} ; -- 
lin rival_N = mkN "tegenstander" | mkN "rivaal" | mkN "concurent" | mkN "vijand" ; -- status=guess status=guess status=guess status=guess
lin steam_N = mkN "stoommachine" feminine ; -- status=guess
lin back_A = mkA "achteraf" ; -- status=guess
lin chancellor_N = mkN "kanselier" ; -- status=guess
lin crash_V = mkV "vastlopen" ; -- status=guess, src=wikt
lin belt_N = mkN "gordel" masculine | mkN "riem" masculine | mkN "veiligheidsgordel" masculine ; -- status=guess status=guess status=guess
lin logic_N = mkN "logica" feminine ; -- status=guess
lin premium_N = variants{} ; -- 
lin confront_V2 = mkV2 (mkV "confronteren") ; -- status=guess, src=wikt
lin precede_V2 = mkV2 (mkV (mkV "vooraf") "gaan") ; -- status=guess, src=wikt
lin experimental_A = variants{} ; -- 
lin alarm_N = mkN "wekker" masculine ; -- status=guess
lin rational_A = mkA "rationeel" | mkA "rationele" ; -- status=guess status=guess
lin incentive_N = variants{} ; -- 
lin roughly_Adv = mkAdv "grofweg" ; -- status=guess
lin bench_N = mkN "bank" feminine | mkN "zitbank" feminine ; -- status=guess status=guess
lin wrap_V2 = mkV2 (mkV "inpakken") ; -- status=guess, src=wikt
lin wrap_V = mkV "inpakken" ; -- status=guess, src=wikt
lin regarding_Prep = variants{} ; -- 
lin inadequate_A = mkA "onvoldoende" ; -- status=guess
lin ambition_N = variants{} ; -- 
lin since_Adv = variants{}; -- mkPrep "sinds" | mkPrep "sedert" ;
lin fate_N = mkN "vertrouwen" neuter ; -- status=guess
lin vendor_N = mkN "leverancier" masculine feminine ; -- status=guess
lin stranger_N = mkN "vreemde" masculine ; -- status=guess
lin spiritual_A = mkA "geestelijk" | mkA "spiritueel" ; -- status=guess status=guess
lin increasing_A = variants{} ; -- 
lin anticipate_VV = variants{} ; -- 
lin anticipate_VS = variants{} ; -- 
lin anticipate_V2 = variants{} ; -- 
lin anticipate_V = variants{} ; -- 
lin logical_A = mkA "logisch" ; -- status=guess
lin fibre_N = mkN "draad" masculine ; -- status=guess
lin attribute_V2 = mkV2 (mkV "toeschrijven") ; -- status=guess, src=wikt
lin sense_VS = mkVS (mkV "gewaarworden") | mkVS (mkV "waarnemen") ; -- status=guess, src=wikt status=guess, src=wikt
lin sense_V2 = mkV2 (mkV "gewaarworden") | mkV2 (mkV "waarnemen") ; -- status=guess, src=wikt status=guess, src=wikt
lin black_N = mkN "zwarte" masculine | mkN "neger" masculine | mkN "negerin" feminine ; -- status=guess status=guess status=guess
lin petrol_N = variants{} ; -- 
lin maker_N = mkN "maker" masculine ; -- status=guess
lin generous_A = mkA "gul" | mkA "genereus" ; -- status=guess status=guess
lin allocation_N = mkN "allocatie" | mkN "toewijzing" ; -- status=guess status=guess
lin depression_N = mkN "depressie" feminine ; -- status=guess
lin declaration_N = mkN "verklaring" feminine | mkN "declaratie" feminine ; -- status=guess status=guess
lin spot_VS = mkVS (mkV "lenen") | mkVS (mkV "matsen") ; -- status=guess, src=wikt status=guess, src=wikt
lin spot_V2 = mkV2 (mkV "lenen") | mkV2 (mkV "matsen") ; -- status=guess, src=wikt status=guess, src=wikt
lin spot_V = mkV "lenen" | mkV "matsen" ; -- status=guess, src=wikt status=guess, src=wikt
lin modest_A = mkA "bescheiden" | mkA "ingetogen" ; -- status=guess status=guess
lin bottom_A = variants{} ; -- 
lin dividend_N = mkN "deeltal" neuter ; -- status=guess
lin devote_V2 = mkV2 (mkV "wijden") | mkV2 (mkV "toewijden") ; -- status=guess, src=wikt status=guess, src=wikt
lin condemn_V2 = mkV2 (mkV "veroordelen") ; -- status=guess, src=wikt
lin integrate_V2 = variants{} ; -- 
lin integrate_V = variants{} ; -- 
lin pile_N = mkN "stapel" ; -- status=guess
lin identification_N = mkN "identificatie" ; -- status=guess
lin acute_A = mkA "scherp" ; -- status=guess
lin barely_Adv = mkAdv "nauwelijks" ; -- status=guess
lin providing_Subj = variants{} ; -- 
lin directive_N = mkN "richtlijn" feminine ; -- status=guess
lin bet_VS = mkVS (mkV (mkV "er") "op kunnen rekenen") | mkVS (mkV (mkV "er") "van op aan kunnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bet_V2 = mkV2 (mkV (mkV "er") "op kunnen rekenen") | mkV2 (mkV (mkV "er") "van op aan kunnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bet_V = mkV (mkV "er") "op kunnen rekenen" | mkV (mkV "er") "van op aan kunnen" ; -- status=guess, src=wikt status=guess, src=wikt
lin modify_V2 = mkV2 (mkV "modificeren") | mkV2 (mkV "veranderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bare_A = mkA "kaal" ; -- status=guess
lin swear_VV = mkVV (mkV "vloeken") ; -- status=guess, src=wikt
lin swear_V2 = mkV2 (mkV "vloeken") ; -- status=guess, src=wikt
lin swear_V = mkV "vloeken" ; -- status=guess, src=wikt
lin final_N = mkN "finale" feminine ; -- status=guess
lin accordingly_Adv = variants{} ; -- 
lin valid_A = mkA "geldig" ; -- status=guess
lin wherever_Adv = mkAdv "waar toch" ; -- status=guess
lin mortality_N = mkN "sterfelijkheid" feminine | mkN "mortaliteit" feminine ; -- status=guess status=guess
lin medium_N = mkN "medium" ; -- status=guess
lin silk_N = mkN "zijde" feminine | mkN "zijdedoek" masculine ; -- status=guess status=guess
lin funeral_N = mkN "begrafenis" feminine ; -- status=guess
lin depending_A = variants{} ; -- 
lin cow_N = L.cow_N ;
lin correspond_V2 = variants{}; -- mkV "corresponderen" ; -- status=guess, src=wikt
lin correspond_V = mkV "corresponderen" ; -- status=guess, src=wikt
lin cite_V2 = variants{} ; -- 
lin classic_A = variants{} ; -- 
lin inspection_N = mkN "inspectie" feminine | mkN "keuring" feminine ; -- status=guess status=guess
lin calculation_N = variants{} ; -- 
lin rubbish_N = mkN "vuilnis" neuter | mkN "afval" neuter ; -- status=guess status=guess
lin minimum_N = variants{} ; -- 
lin hypothesis_N = mkN "hypothese" ; -- status=guess
lin youngster_N = mkN "jongere" masculine feminine ; -- status=guess
lin slope_N = mkN "helling" feminine ; -- status=guess
lin patch_N = variants{} ; -- 
lin invitation_N = mkN "uitnodiging" feminine ; -- status=guess
lin ethnic_A = mkA "etnisch" | mkA "exotisch" | mkA "vreemd" ; -- status=guess status=guess status=guess
lin federation_N = mkN "federatie" feminine | mkN "bondstaat" masculine ; -- status=guess status=guess
lin duke_N = mkN "hertog" masculine ; -- status=guess
lin wholly_Adv = variants{} ; -- 
lin closure_N = mkN "beëindiging" | mkN "afsluiting" | mkN "sluiting" ; -- status=guess status=guess status=guess
lin dictionary_N = mkN "woordenboek" neuter ; -- status=guess
lin withdrawal_N = variants{} ; -- 
lin automatic_A = mkA "automatisch" | mkA "gedachtenloos" | mkA "mechanisch" ; -- status=guess status=guess status=guess
lin liable_A = mkA "aansprakelijk" | mkA "verantwoordelijk" ; -- status=guess status=guess
lin cry_N = variants{} ; -- 
lin slow_V2 = mkV2 (mkV "vertragen") | mkV2 (mkV "ophouden") ; -- status=guess, src=wikt status=guess, src=wikt
lin slow_V = mkV "vertragen" | mkV "ophouden" ; -- status=guess, src=wikt status=guess, src=wikt
lin borough_N = mkN "deelraad" ; -- status=guess
lin well_A = mkA "gezond" ; -- status=guess
lin suspicion_N = mkN "verdenking" feminine ; -- status=guess
lin portrait_N = mkN "portret" neuter ; -- status=guess
lin local_N = mkN "stamcafé" neuter | mkN "stamkroeg" masculine feminine ; -- status=guess status=guess
lin jew_N = variants{} ; -- 
lin fragment_N = mkN "fragment" neuter ; -- status=guess
lin revolutionary_A = mkA "baanbrekend" ; -- status=guess
lin evaluate_V2 = variants{} ; -- 
lin evaluate_V = variants{} ; -- 
lin competitor_N = mkN "concurrent" masculine feminine ; -- status=guess
lin sole_A = mkA "enig" ; -- status=guess
lin reliable_A = mkA "betrouwbaar" | mkA "zeker" ; -- status=guess status=guess
lin weigh_V2 = mkV2 (wegen_V) ; -- status=guess, src=wikt
lin weigh_V = wegen_V ; -- status=guess, src=wikt
lin medieval_A = mkA "middeleeuws" | mkA "mediëvaal" ; -- status=guess status=guess
lin clinic_N = variants{} ; -- 
lin shine_V2 = mkV2 (mkV (mkV "voor") "de hand liggen") ; -- status=guess, src=wikt
lin shine_V = mkV (mkV "voor") "de hand liggen" ; -- status=guess, src=wikt
lin knit_V2 = mkV2 (mkV "aaneengroeien") ; -- status=guess, src=wikt
lin knit_V = mkV "aaneengroeien" ; -- status=guess, src=wikt
lin complexity_N = mkN "gecompliceerdheid" feminine | mkN "verwikkeling" feminine | mkN "complexiteit" feminine ; -- status=guess status=guess status=guess
lin remedy_N = mkN "remedie " neuter ; -- status=guess
lin fence_N = mkN "hek" neuter | mkN "omheining" feminine ; -- status=guess status=guess
lin bike_N = L.bike_N ;
lin freeze_V2 = mkV2 (mkV "verstijven") ; -- status=guess, src=wikt
lin freeze_V = L.freeze_V ;
lin eliminate_V2 = variants{} ; -- 
lin interior_N = mkN "interieur" neuter ; -- status=guess
lin intellectual_A = mkA "verstandelijk" ; -- status=guess
lin established_A = variants{} ; -- 
lin voter_N = mkN "stemmer" ; -- status=guess
lin garage_N = mkN "vrijmarkt" masculine feminine ; -- status=guess
lin era_N = mkN "tijdperk" neuter | mkN "periode" feminine | mkN "era" masculine | mkN "tijdrekening" feminine ; -- status=guess status=guess status=guess status=guess
lin pregnant_A = mkA "zwanger" | mkA "drachtig" | mkA "pregnant" ; -- status=guess status=guess status=guess
lin plot_N = mkN "perceel" neuter ; -- status=guess
lin greet_V2 = mkV2 (mkV "groeten") ; -- status=guess, src=wikt
lin electrical_A = variants{} ; -- 
lin lie_N = mkN "ligging" feminine | mkN "terreinligging" feminine ; -- status=guess status=guess
lin disorder_N = mkN "stoornis" feminine ; -- status=guess
lin formally_Adv = mkAdv "formeel" ; -- status=guess
lin excuse_N = mkN "uitvlucht" masculine feminine | mkN "excuus" neuter ; -- status=guess status=guess
lin socialist_A = mkA "socialistisch" | mkA "socialistische" ; -- status=guess status=guess
lin cancel_V2 = mkV2 (mkV "doorhalen") ; -- status=guess, src=wikt
lin cancel_V = mkV "doorhalen" ; -- status=guess, src=wikt
lin harm_N = mkN "schade" masculine ; -- status=guess
lin excess_N = mkN "overtreffen" ; -- status=guess
lin exact_A = mkA "exact" | mkA "precies" ; -- status=guess status=guess
lin oblige_V2V = mkV2V (mkV "verplichten") ; -- status=guess, src=wikt
lin oblige_V2 = mkV2 (mkV "verplichten") ; -- status=guess, src=wikt
lin accountant_N = mkN "boekhouder" masculine | mkN "accountant" masculine ; -- status=guess status=guess
lin mutual_A = mkA "wederzijds" ; -- status=guess
lin fat_N = L.fat_N ;
lin volunteerMasc_N = mkN "vrijwilliger" masculine ; -- status=guess
lin laughter_N = mkN "gelach" neuter | mkN "lachen" neuter ; -- status=guess status=guess
lin trick_N = variants{} ; -- 
lin load_V2 = mkV2 (laden_V) ; -- status=guess, src=wikt
lin load_V = laden_V ; -- status=guess, src=wikt
lin disposal_N = variants{} ; -- 
lin taxi_N = mkN "taxi" ; -- status=guess
lin murmur_V2 = variants{} ; -- 
lin murmur_V = variants{} ; -- 
lin tonne_N = variants{} ; -- 
lin spell_V2 = mkV2 (mkV "spellen") ; -- status=guess, src=wikt
lin spell_V = mkV "spellen" ; -- status=guess, src=wikt
lin clerk_N = mkN "klerk" masculine ; -- status=guess
lin curious_A = mkA "nieuwsgierig" ; -- status=guess
lin satisfactory_A = mkA "bevredigend" ; -- status=guess
lin identical_A = mkA "identiek" | mkA "identieke" ; -- status=guess status=guess
lin applicant_N = mkN "aanvrager" ; -- status=guess
lin removal_N = mkN "verwijdering" ; -- status=guess
lin processor_N = mkN "processor" masculine | mkN "centrale verwerkingseenheid" | mkN "CVE" | mkN "CPU" ; -- status=guess status=guess status=guess status=guess
lin cotton_N = mkN "katoen" neuter ; -- status=guess
lin reverse_V2 = variants{} ; -- 
lin reverse_V = variants{} ; -- 
lin hesitate_VV = mkVV (mkV "aarzelen") ; -- status=guess, src=wikt
lin hesitate_V = mkV "aarzelen" ; -- status=guess, src=wikt
lin professor_N = mkN "hoogleraar" masculine | mkN "professor" masculine feminine | mkN "prof" masculine feminine ; -- status=guess status=guess status=guess
lin admire_V2 = mkV2 (mkV "bewonderen") | mkV2 (mkV "aanbidden") ; -- status=guess, src=wikt status=guess, src=wikt
lin namely_Adv = mkAdv "namelijk" ; -- status=guess
lin electoral_A = variants{} ; -- 
lin delight_N = mkN "vreugde" feminine | mkN "plezier" neuter ; -- status=guess status=guess
lin urgent_A = mkA "dringend" ; -- status=guess
lin prompt_V2V = mkV2V (mkV "aansporen") | mkV2V (mkV "aanmoedigen") | mkV2V (mkV "aanzetten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prompt_V2 = mkV2 (mkV "aansporen") | mkV2 (mkV "aanmoedigen") | mkV2 (mkV "aanzetten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mate_N = mkN "maat " neuter | mkN "kameraad" masculine | mkN "makker" masculine | mkN "gabber" masculine ; -- status=guess status=guess status=guess status=guess
lin mate_2_N = variants{} ; -- 
lin mate_1_N = variants{} ; -- 
lin exposure_N = mkN "blootstelling" feminine | mkN "contact" neuter ; -- status=guess status=guess
lin server_N = mkN "server" ; -- status=guess
lin distinctive_A = variants{} ; -- 
lin marginal_A = mkA "marginaal" ; -- status=guess
lin structural_A = mkA "structureel" ; -- status=guess
lin rope_N = L.rope_N ;
lin miner_N = mkN "mijnwerker" masculine ; -- status=guess
lin entertainment_N = variants{} ; -- 
lin acre_N = variants{} ; -- 
lin pig_N = mkN "pig Latin" | mkN "potjeslatijn" ; -- status=guess status=guess
lin encouraging_A = variants{} ; -- 
lin guarantee_N = mkN "garantie" ; -- status=guess
lin gear_N = mkN "overbrenging" feminine ; -- status=guess
lin anniversary_N = mkN "jubileum" neuter ; -- status=guess
lin past_Adv = mkAdv "voorbij" ; -- status=guess
lin ceremony_N = mkN "ceremonie" feminine | mkN "plechtigheid" feminine ; -- status=guess status=guess
lin rub_V2 = L.rub_V2 ;
lin rub_V = wrijven_V ; -- status=guess, src=wikt
lin monopoly_N = mkN "monopolie" neuter | mkN "alleenbezit" neuter ; -- status=guess status=guess
lin left_N = mkN "linkerkant" masculine | mkN "links" neuter ; -- status=guess status=guess
lin flee_V2 = mkV2 (mkV "vervliegen") | mkV2 (mkV "vlieden") ; -- status=guess, src=wikt status=guess, src=wikt
lin flee_V = mkV "vervliegen" | mkV "vlieden" ; -- status=guess, src=wikt status=guess, src=wikt
lin yield_V2 = mkV2 (mkV "zwichten") ; -- status=guess, src=wikt
lin discount_N = mkN "korting" utrum ; -- status=guess
lin above_A = mkA "bovengemiddeld" ; -- status=guess
lin uncle_N = mkN "pandjesbaas" masculine ; -- status=guess
lin audit_N = variants{} ; -- 
lin advertisement_N = mkN "reclame " masculine | mkN "advertentie" feminine ; -- status=guess status=guess
lin explosion_N = mkN "explosie" ; -- status=guess
lin contrary_A = variants{} ; -- 
lin tribunal_N = variants{} ; -- 
lin swallow_V2 = mkV2 (mkV "slikken") ; -- status=guess, src=wikt
lin swallow_V = mkV "slikken" ; -- status=guess, src=wikt
lin typically_Adv = variants{} ; -- 
lin fun_A = mkA "plezierig" | mkA "leuk" | mkA "lollig" | mkA "plezant" ; -- status=guess status=guess status=guess status=guess
lin rat_N = mkN "rat" feminine | mkN "bruine rat" feminine | mkN "rioolrat" feminine | mkN "zwarte rat" feminine ; -- status=guess status=guess status=guess status=guess
lin cloth_N = mkN "vod" feminine ; -- status=guess
lin cable_N = mkN "kabel" masculine ; -- status=guess
lin interrupt_V2 = mkV2 (mkV "onderbreken") ; -- status=guess, src=wikt
lin interrupt_V = mkV "onderbreken" ; -- status=guess, src=wikt
lin crash_N = mkN "crash" masculine | mkN "computercrash" masculine ; -- status=guess status=guess
lin flame_N = mkN "vlam" feminine | mkN "laai" feminine ; -- status=guess status=guess
lin controversy_N = mkN "controverse" ; -- status=guess
lin rabbit_N = mkN "konijn" neuter ; -- status=guess
lin everyday_A = mkA "alledaags" ; -- status=guess
lin allegation_N = variants{} ; -- 
lin strip_N = mkN "koopgoot" ; -- status=guess
lin stability_N = mkN "stabiliteit" feminine ; -- status=guess
lin tide_N = mkN "getijde" neuter | mkN "tij" neuter ; -- status=guess status=guess
lin illustration_N = mkN "illustratie" feminine ; -- status=guess
lin insect_N = mkN "insect" neuter ; -- status=guess
lin correspondent_N = mkN "correspondent" masculine ; -- status=guess
lin devise_V2 = variants{} ; -- 
lin determined_A = variants{} ; -- 
lin brush_V2 = mkV2 (mkV "aanbrengen") ; -- status=guess, src=wikt
lin brush_V = mkV "aanbrengen" ; -- status=guess, src=wikt
lin adjustment_N = mkN "aanpassing" utrum | mkN "bijstelling" utrum ; -- status=guess status=guess
lin controversial_A = mkA "omstreden" ; -- status=guess
lin organic_A = mkA "organisch" | mkA "organische" ; -- status=guess status=guess
lin escape_N = mkN "ontsnappen" ; -- status=guess
lin thoroughly_Adv = variants{} ; -- 
lin interface_N = mkN "interface" masculine ; -- status=guess
lin historic_A = mkA "historisch" ; -- status=guess
lin collapse_N = mkN "ineenstorting" feminine | mkN "instorten" neuter ; -- status=guess status=guess
lin temple_N = mkN "slaap" masculine ; -- status=guess
lin shade_N = mkN "spook" neuter | mkN "geest" masculine | mkN "schaduw" utrum ; -- status=guess status=guess status=guess
lin craft_N = mkN "ambacht" neuter | mkN "ambachtslui {p}" | mkN "vaklui {p}" | mkN "stielmannen {p}" ; -- status=guess status=guess status=guess status=guess
lin nursery_N = mkN "kleuterschool" | mkN "peuterspeelzaal" ; -- status=guess status=guess
lin piano_N = mkN "piano" masculine ; -- status=guess
lin desirable_A = mkA "wenselijk" ; -- status=guess
lin assurance_N = variants{} ; -- 
lin jurisdiction_N = variants{} ; -- 
lin advertise_V2 = variants{} ; -- 
lin advertise_V = variants{} ; -- 
lin bay_N = mkN "baai" feminine ; -- status=guess
lin specification_N = variants{} ; -- 
lin disability_N = variants{} ; -- 
lin presidential_A = variants{} ; -- 
lin arrest_N = mkN "arrestatie" | mkN "aanhouding" feminine ; -- status=guess status=guess
lin unexpected_A = mkA "onverwacht" ; -- status=guess
lin switch_N = mkN "schakelaar" masculine ; -- status=guess
lin penny_N = mkN "hoge bi" masculine feminine ; -- status=guess
lin respect_V2 = mkV2 (mkV "respecteren") ; -- status=guess, src=wikt
lin celebration_N = mkN "gedachtenis" | mkN "herdenking" | mkN "viering" feminine ; -- status=guess status=guess status=guess
lin gross_A = mkA "walgelijk" ; -- status=guess
lin aid_V2 = mkV2 (helpen_V) | mkV2 (mkV "bijstaan") ; -- status=guess, src=wikt status=guess, src=wikt
lin aid_V = helpen_V | mkV "bijstaan" ; -- status=guess, src=wikt status=guess, src=wikt
lin superb_A = mkA "eersteklas" ; -- status=guess
lin process_V2 = variants{} ; -- 
lin process_V = variants{} ; -- 
lin innocent_A = variants{} ; -- 
lin leap_V2 = mkV2 (springen_V) | mkV2 (mkV "wippen") | mkV2 (mkV "huppen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin leap_V = springen_V | mkV "wippen" | mkV "huppen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin colony_N = mkN "kolonie" feminine ; -- status=guess
lin wound_N = mkN "verwonding" feminine ; -- status=guess
lin hardware_N = mkN "ijzerwinkel" masculine | mkN "ijzerwarenwinkel" masculine ; -- status=guess status=guess
lin satellite_N = mkN "satelliet" masculine | mkN "kunstmaan " masculine ; -- status=guess status=guess
lin float_V = L.float_V ;
lin bible_N = mkN "bijbel" ; -- status=guess
lin statistical_A = variants{} ; -- 
lin marked_A = variants{} ; -- 
lin hire_V2V = mkV2V (mkV (mkV "werk") "aannemen") ; -- status=guess, src=wikt
lin hire_V2 = mkV2 (mkV (mkV "werk") "aannemen") ; -- status=guess, src=wikt
lin cathedral_N = mkN "kathedraal" feminine ; -- status=guess
lin motive_N = mkN "motief" neuter ; -- status=guess
lin correct_VS = mkVS (mkV "corrigeren") | mkVS (mkV "verbeteren") ; -- status=guess, src=wikt status=guess, src=wikt
lin correct_V2 = mkV2 (mkV "corrigeren") | mkV2 (mkV "verbeteren") ; -- status=guess, src=wikt status=guess, src=wikt
lin correct_V = mkV "corrigeren" | mkV "verbeteren" ; -- status=guess, src=wikt status=guess, src=wikt
lin gastric_A = variants{} ; -- 
lin raid_N = variants{} ; -- 
lin comply_V2 = mkV2 (mkV "voldoen") ; -- status=guess, src=wikt
lin comply_V = mkV "voldoen" ; -- status=guess, src=wikt
lin accommodate_V2 = mkV2 (mkV "aanpassen") | mkV2 (mkV "accommoderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin accommodate_V = mkV "aanpassen" | mkV "accommoderen" ; -- status=guess, src=wikt status=guess, src=wikt
lin mutter_V2 = mkV2 (mkV "mompelen") ; -- status=guess, src=wikt
lin mutter_V = mkV "mompelen" ; -- status=guess, src=wikt
lin induce_V2 = mkV2 (mkV "opwekken") | mkV2 (mkV "veroorzaken") | mkV2 (mkV "overhalen") | mkV2 (mkV "forceren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin trap_V2 = mkV2 (vangen_V) ; -- status=guess, src=wikt
lin trap_V = vangen_V ; -- status=guess, src=wikt
lin invasion_N = variants{} ; -- 
lin humour_N = mkN "stemming" | mkN "humeur" neuter ; -- status=guess status=guess
lin bulk_N = variants{} ; -- 
lin traditionally_Adv = mkAdv "traditioneel" ; -- status=guess
lin commission_V2V = variants{} ; -- 
lin commission_V2 = variants{} ; -- 
lin upstairs_Adv = mkAdv "boven" ; -- status=guess
lin translate_V2 = mkV2 (mkV "vertalen") | mkV2 (mkV "overzetten") ; -- status=guess, src=wikt status=guess, src=wikt
lin translate_V = mkV "vertalen" | mkV "overzetten" ; -- status=guess, src=wikt status=guess, src=wikt
lin rhythm_N = mkN "ritme" neuter ; -- status=guess
lin emission_N = mkN "uitstoot" | mkN "emissie" ; -- status=guess status=guess
lin collective_A = mkA "collectief" ; -- status=guess
lin transformation_N = mkN "transformatie" feminine ; -- status=guess
lin battery_N = mkN "batterij" feminine ; -- status=guess
lin stimulus_N = mkN "stimulans" masculine | mkN "stimulus" ; -- status=guess status=guess
lin naked_A = mkA "naakt" | mkA "onopgesmukt" ; -- status=guess status=guess
lin white_N = mkN "blanke" masculine feminine ; -- status=guess
lin menu_N = mkN "menu" neuter ; -- status=guess
lin toilet_N = mkN "badkamer" utrum ; -- status=guess
lin butter_N = L.butter_N ;
lin surprise_V2V = mkV2V (mkV "verbazen") | mkV2V (mkV "verrassen") ; -- status=guess, src=wikt status=guess, src=wikt
lin surprise_V2 = mkV2 (mkV "verbazen") | mkV2 (mkV "verrassen") ; -- status=guess, src=wikt status=guess, src=wikt
lin needle_N = mkN "naald" feminine ; -- status=guess
lin effectiveness_N = mkN "effectiviteit" feminine ; -- status=guess
lin accordance_N = mkN "overeenstemming" feminine ; -- status=guess
lin molecule_N = mkN "molecuul" neuter ; -- status=guess
lin fiction_N = mkN "fictie" feminine ; -- status=guess
lin learning_N = mkN "kennis" feminine | mkN "geleerdheid" feminine | mkN "geleerde" neuter | mkN "geleerde" masculine feminine ; -- status=guess status=guess status=guess status=guess
lin statute_N = variants{} ; -- 
lin reluctant_A = mkA "aarzelend" ; -- status=guess
lin overlook_V2 = mkV2 (mkV (mkV "over") "het hoofd zien") ; -- status=guess, src=wikt
lin junction_N = mkN "knooppunt verbindingspunt" neuter | mkN "aansluiting" feminine | mkN "samenkomst" feminine ; -- status=guess status=guess status=guess
lin necessity_N = variants{} ; -- 
lin nearby_A = mkA "dichtbij" ; -- status=guess
lin experienced_A = mkA "ervaren" ; -- status=guess
lin lorry_N = variants{} ; -- 
lin exclusive_A = variants{} ; -- 
lin graphics_N = mkN "grafische kaart" utrum | mkN "videokaart" utrum ; -- status=guess status=guess
lin stimulate_V2 = mkV2 (mkV "stimuleren") | mkV2 (mkV "prikkelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin warmth_N = variants{} ; -- 
lin therapy_N = mkN "therapie" ; -- status=guess
lin convenient_A = variants{} ; -- 
lin cinema_N = mkN "film" masculine ; -- status=guess
lin domain_N = mkN "domein" neuter ; -- status=guess
lin tournament_N = mkN "toernooi" neuter | mkN "tornooi" neuter ; -- status=guess status=guess
lin doctrine_N = variants{} ; -- 
lin sheer_A = mkA "puur" | mkA "klaar" | mkA "klinkklaar" ; -- status=guess status=guess status=guess
lin proposition_N = mkN "propositie" ; -- status=guess
lin grip_N = mkN "handvat" neuter ; -- status=guess
lin widow_N = mkN "weduwe" feminine ; -- status=guess
lin discrimination_N = variants{} ; -- 
lin bloody_Adv = mkAdv "verdomd" ; -- status=guess
lin ruling_A = variants{} ; -- 
lin fit_N = variants{} ; -- 
lin nonetheless_Adv = mkAdv "niettemin" ; -- status=guess
lin myth_N = mkN "mythe " masculine ; -- status=guess
lin episode_N = mkN "gebeuren" neuter | mkN "episode" ; -- status=guess status=guess
lin drift_V2 = mkV2 (trekken_V) ; -- status=guess, src=wikt
lin drift_V = trekken_V ; -- status=guess, src=wikt
lin assert_VS = mkVS (mkV "behouden") | mkVS (mkV "verdedigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin assert_V2 = mkV2 (mkV "behouden") | mkV2 (mkV "verdedigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin assert_V = mkV "behouden" | mkV "verdedigen" ; -- status=guess, src=wikt status=guess, src=wikt
lin terrace_N = mkN "terras" neuter | mkN "terrassen {p}" ; -- status=guess status=guess
lin uncertain_A = variants{} ; -- 
lin twist_V2 = mkV2 (mkV "draaien") ; -- status=guess, src=wikt
lin insight_N = mkN "inzicht" neuter ; -- status=guess
lin undermine_V2 = mkV2 (mkV "ondermijnen") | mkV2 (mkV "ontwrichten") ; -- status=guess, src=wikt status=guess, src=wikt
lin tragedy_N = mkN "tragedie" ; -- status=guess
lin enforce_V2 = mkV2 (mkV "handhaven") ; -- status=guess, src=wikt
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin march_V2 = mkV2 (mkV "marcheren") ; -- status=guess, src=wikt
lin march_V = mkV "marcheren" ; -- status=guess, src=wikt
lin leaflet_N = mkN "folder" masculine ; -- status=guess
lin fellow_A = variants{} ; -- 
lin object_V2 = mkV2 (mkV "protesteren") | mkV2 (mkV (mkV "ertegen") "zijn") ; -- status=guess, src=wikt status=guess, src=wikt
lin object_V = mkV "protesteren" | mkV (mkV "ertegen") "zijn" ; -- status=guess, src=wikt status=guess, src=wikt
lin pond_N = mkN "De Atlantische Oceaan" ; -- status=guess
lin adventure_N = mkN "avontuur" neuter ; -- status=guess
lin diplomatic_A = mkA "diplomatiek" ; -- status=guess
lin mixed_A = mkA "gemengdbloedig" | mkA "onzuiver" ; -- status=guess status=guess
lin rebel_N = mkN "rebel" | mkN "opstandeling" masculine ; -- status=guess status=guess
lin equity_N = mkN "aandeel" ; -- status=guess
lin literally_Adv = mkAdv "letterlijk" ; -- status=guess
lin magnificent_A = mkA "prachtig" ; -- status=guess
lin loyalty_N = variants{} ; -- 
lin tremendous_A = mkA "ontzagwekkend" ; -- status=guess
lin airline_N = mkN "luchtvaartmaatschappij" feminine ; -- status=guess
lin shore_N = mkN "kust" | mkN "oever" masculine ; -- status=guess status=guess
lin restoration_N = mkN "restauratie" feminine ; -- status=guess
lin physically_Adv = mkAdv "lichamelijk" ; -- status=guess
lin render_V2 = mkV2 (mkV "veroorzaken") ; -- status=guess, src=wikt
lin institutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (mkV "benadrukken") ; -- status=guess, src=wikt
lin emphasize_V2 = mkV2 (mkV "benadrukken") ; -- status=guess, src=wikt
lin mess_N = mkN "dienst" masculine | mkN "gebedsdienst" masculine | mkN "mis" masculine feminine ; -- status=guess status=guess status=guess
lin commander_N = mkN "commandant" masculine ; -- status=guess
lin straightforward_A = variants{} ; -- 
lin singer_N = mkN "zanger" masculine | mkN "zangeres" feminine ; -- status=guess status=guess
lin squeeze_V2 = L.squeeze_V2 ;
lin squeeze_V = mkV "uitknijpen" | mkV "uitpersen" ; -- status=guess, src=wikt status=guess, src=wikt
lin full_time_A = variants{} ; -- 
lin breed_V2 = mkV2 (mkV "fokken") ; -- status=guess, src=wikt
lin breed_V = mkV "fokken" ; -- status=guess, src=wikt
lin successor_N = mkN "opvolger" masculine | mkN "opvolgster" feminine ; -- status=guess status=guess
lin triumph_N = mkN "triomf" ; -- status=guess
lin heading_N = variants{} ; -- 
lin mathematics_N = mkN "wiskunde" feminine ; -- status=guess
lin laugh_N = mkN "lach" masculine ; -- status=guess
lin clue_N = variants{} ; -- 
lin still_A = mkA "stil" ; -- status=guess
lin ease_N = variants{} ; -- 
lin specially_Adv = variants{} ; -- 
lin biological_A = mkA "biologisch" | mkA "biologische" ; -- status=guess status=guess
lin forgive_V2 = mkV2 (mkV "vergeven") ; -- status=guess, src=wikt
lin forgive_V = mkV "vergeven" ; -- status=guess, src=wikt
lin trustee_N = variants{} ; -- 
lin photo_N = mkN "foto" ; -- status=guess
lin fraction_N = mkN "breuk" utrum ; -- status=guess
lin chase_V2 = mkV2 (mkV "achtervolgen") | mkV2 (mkV "achternazitten") | mkV2 (mkV "achternajagen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin chase_V = mkV "achtervolgen" | mkV "achternazitten" | mkV "achternajagen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin whereby_Adv = mkAdv "waarbij" ; -- status=guess
lin mud_N = mkN "moddergevecht" neuter | mkN "moddergooien" neuter ; -- status=guess status=guess
lin pensioner_N = mkN "gepensioneerde" masculine feminine ; -- status=guess
lin functional_A = mkA "functionerend" | mkA "operationeel" | mkA "werkend" ; -- status=guess status=guess status=guess
lin copy_V2 = mkV2 (mkV "nabootsen") | mkV2 (mkV "nadoen") | mkV2 (mkV "naäpen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin copy_V = mkV "nabootsen" | mkV "nadoen" | mkV "naäpen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin strictly_Adv = variants{} ; -- 
lin desperately_Adv = mkAdv "wanhopig" ; -- status=guess
lin await_V2 = mkV2 (mkV (mkV "wachten") "op") ; -- status=guess, src=wikt
lin coverage_N = mkN "dekking" feminine ; -- status=guess
lin wildlife_N = mkN "wildleven" neuter ; -- status=guess
lin indicator_N = variants{} ; -- 
lin lightly_Adv = variants{} ; -- 
lin hierarchy_N = mkN "hiërarchie" feminine ; -- status=guess
lin evolve_V2 = mkV2 (mkV "ontwikkelen") ; -- status=guess, src=wikt
lin evolve_V = mkV "ontwikkelen" ; -- status=guess, src=wikt
lin mechanical_A = mkA "mechanisch" ; -- status=guess
lin expert_A = variants{} ; -- 
lin creditor_N = variants{} ; -- 
lin capitalist_N = mkN "kapitalist" masculine ; -- status=guess
lin essence_N = mkN "essence" | mkN "aftreksel" ; -- status=guess status=guess
lin compose_V2 = mkV2 (mkV "composeren") ; -- status=guess, src=wikt
lin compose_V = mkV "composeren" ; -- status=guess, src=wikt
lin mentally_Adv = variants{} ; -- 
lin gaze_N = variants{} ; -- 
lin seminar_N = variants{} ; -- 
lin target_V2V = variants{} ; -- 
lin target_V2 = variants{} ; -- 
lin label_V3 = mkV3 (mkV "bestempelen") | mkV3 (mkV "categoriseren") ; -- status=guess, src=wikt status=guess, src=wikt
lin label_V2 = mkV2 (mkV "bestempelen") | mkV2 (mkV "categoriseren") ; -- status=guess, src=wikt status=guess, src=wikt
lin label_V = mkV "bestempelen" | mkV "categoriseren" ; -- status=guess, src=wikt status=guess, src=wikt
lin fig_N = mkN "vijg" feminine ; -- status=guess
lin continent_N = mkN "werelddeel" neuter | mkN "continent" neuter ; -- status=guess status=guess
lin chap_N = variants{} ; -- 
lin flexibility_N = variants{} ; -- 
lin verse_N = mkN "couplet" neuter ; -- status=guess
lin minute_A = mkA "minuscuul" | mkA "minuscule" | mkA "onbeduidend" | mkA "onbeduidende" | mkA "nietig" | mkA "nietige" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin whisky_N = variants{} ; -- 
lin equivalent_A = mkA "gelijkwaardig" ; -- status=guess
lin recruit_V2 = variants{} ; -- 
lin recruit_V = variants{} ; -- 
lin echo_V2 = mkV2 (mkV "echoën") ; -- status=guess, src=wikt
lin echo_V = mkV "echoën" ; -- status=guess, src=wikt
lin unfair_A = variants{} ; -- 
lin launch_N = mkN "worp" masculine | mkN "lancering" feminine ; -- status=guess status=guess
lin cupboard_N = mkN "kast" feminine ; -- status=guess
lin bush_N = mkN "bush" ; -- status=guess
lin shortage_N = mkN "krapte" feminine | mkN "tekort" neuter ; -- status=guess status=guess
lin prominent_A = mkA "prominent" | mkA "vooraanstaand" ; -- status=guess status=guess
lin merger_N = mkN "opslorping" | mkN "amalgamatie" feminine ; -- status=guess status=guess
lin command_V2 = mkV2 (bevelen_V) | mkV2 (mkV "commanderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin command_V = bevelen_V | mkV "commanderen" ; -- status=guess, src=wikt status=guess, src=wikt
lin subtle_A = mkA "subtiel" ; -- status=guess
lin capital_A = mkA "uitstekend" | mkA "excellent" ; -- status=guess status=guess
lin gang_N = mkN "bende" feminine | mkN "gang" ; -- status=guess status=guess
lin fish_V2 = mkV2 (mkV "vissen") | mkV2 (mkV "hengelen") | mkV2 (mkV "snoeken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fish_V = mkV "vissen" | mkV "hengelen" | mkV "snoeken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin unhappy_A = variants{} ; -- 
lin lifetime_N = variants{} ; -- 
lin elite_N = mkN "elite" feminine ; -- status=guess
lin refusal_N = mkN "weigering" feminine ; -- status=guess
lin finish_N = mkN "eindstreep" feminine | mkN "finish" feminine | mkN "meet" feminine ; -- status=guess status=guess status=guess
lin aggressive_A = mkA "agressief" ; -- status=guess
lin superior_A = mkA "superieur" ; -- status=guess
lin landing_N = mkN "steiger" masculine | mkN "aanlegplaats" feminine ; -- status=guess status=guess
lin exchange_V2 = mkV2 (mkV "ruilen") | mkV2 (mkV "omruilen") | mkV2 (mkV "wisselen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin debate_V2 = mkV2 (mkV "debatteren") | mkV2 (mkV "uitpraten") | mkV2 (mkV "bespreken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin debate_V = mkV "debatteren" | mkV "uitpraten" | mkV "bespreken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin educate_V2 = mkV2 (mkV "opleiden") ; -- status=guess, src=wikt
lin separation_N = mkN "scheiding" feminine ; -- status=guess
lin productivity_N = variants{} ; -- 
lin initiate_V2 = mkV2 (beginnen_V) | mkV2 (mkV "starten") | mkV2 (mkV "aanvangen") | mkV2 (mkV "initiëren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin probability_N = mkN "waarschijnlijkheid" feminine ; -- status=guess
lin virus_N = variants{} ; -- 
lin reporterMasc_N = mkN "verslaggever" masculine ; -- status=guess
lin fool_N = mkN "dwaas" ; -- status=guess
lin pop_V2 = mkV2 (mkV "uithuwelijken") | mkV2 (mkV (mkV "om") "iemands hand vragen") ; -- status=guess, src=wikt status=guess, src=wikt
lin capitalism_N = mkN "kapitalisme" neuter ; -- status=guess
lin painful_A = mkA "pijnlijk" | mkA "smartelijk" ; -- status=guess status=guess
lin correctly_Adv = mkAdv "correct" | mkAdv "juist" | mkAdv "goed" ; -- status=guess status=guess status=guess
lin complex_N = mkN "complex" neuter ; -- status=guess
lin rumour_N = variants{} ; -- 
lin imperial_A = mkA "keizerlijk" ; -- status=guess
lin justification_N = mkN "rechtvaardiging" feminine ; -- status=guess
lin availability_N = mkN "beschikbaarheid" feminine ; -- status=guess
lin spectacular_A = variants{} ; -- 
lin remain_N = variants{} ; -- 
lin ocean_N = mkN "oceaan" masculine | mkN "wereldzee" feminine ; -- status=guess status=guess
lin cliff_N = mkN "klip" feminine | mkN "klif" feminine ; -- status=guess status=guess
lin sociology_N = mkN "sociologie" feminine ; -- status=guess
lin sadly_Adv = variants{} ; -- 
lin missile_N = mkN "raket" ; -- status=guess
lin situate_V2 = mkV2 (mkV "situeren") ; -- status=guess, src=wikt
lin artificial_A = mkA "kunstmatig" | mkA "nagemaakt" | mkA "artificieel" ; -- status=guess status=guess status=guess
lin apartment_N = L.apartment_N ;
lin provoke_V2 = mkV2 (mkV "uitlokken") ; -- status=guess, src=wikt
lin oral_A = mkA "mondelijk" ; -- status=guess
lin maximum_N = variants{} ; -- 
lin angel_N = mkN "engel" ; -- status=guess
lin spare_A = variants{} ; -- 
lin shame_N = mkN "schande" feminine ; -- status=guess
lin intelligent_A = mkA "intelligent" ; -- status=guess
lin discretion_N = mkN "discretie" feminine ; -- status=guess
lin businessman_N = mkN "zakenman" masculine ; -- status=guess
lin explicit_A = mkA "expliciet" ; -- status=guess
lin book_V2 = mkV2 (mkV "beboeten") ; -- status=guess, src=wikt
lin uniform_N = mkN "uniform" neuter ; -- status=guess
lin push_N = mkN "duw" masculine ; -- status=guess
lin counter_N = mkN "tegenaanval" ; -- status=guess
lin subject_A = variants{} ; -- 
lin objective_A = mkA "objectief" | mkA "objectieve" ; -- status=guess status=guess
lin hungry_A = mkA "hongerig" ; -- status=guess
lin clothing_N = mkN "kleding" feminine | mkN "kledij" feminine ; -- status=guess status=guess
lin ride_N = variants{} ; -- 
lin romantic_A = variants{} ; -- 
lin attendance_N = variants{} ; -- 
lin part_time_A = variants{} ; -- 
lin trace_N = mkN "opsporen" | mkN "nazoeken" ; -- status=guess status=guess
lin backing_N = variants{} ; -- 
lin sensation_N = variants{} ; -- 
lin carrier_N = mkN "postduif " masculine ; -- status=guess
lin interest_V2 = mkV2 (mkV "interesseren") ; -- status=guess, src=wikt
lin interest_V = mkV "interesseren" ; -- status=guess, src=wikt
lin classification_N = mkN "classificatie" feminine ; -- status=guess
lin classic_N = variants{} ; -- 
lin beg_V2 = mkV2 (mkV "bedelen") ; -- status=guess, src=wikt
lin beg_V = mkV "bedelen" ; -- status=guess, src=wikt
lin appendix_N = mkN "aanhangsel" | mkN "appendix" ; -- status=guess status=guess
lin doorway_N = variants{} ; -- 
lin density_N = mkN "dichtheid" feminine ; -- status=guess
lin working_class_A = variants{} ; -- 
lin legislative_A = variants{} ; -- 
lin hint_N = mkN "aanwijzing" feminine ; -- status=guess
lin shower_N = mkN "regenbui" feminine | mkN "bui" feminine | mkN "schoer" masculine ; -- status=guess status=guess status=guess
lin current_N = mkN "zichtrekening" feminine | mkN "lopende rekening" ; -- status=guess status=guess
lin succession_N = mkN "opeenvolging" ; -- status=guess
lin nasty_A = variants{} ; -- 
lin duration_N = mkN "tijdsduur" masculine | mkN "duur" masculine ; -- status=guess status=guess
lin desert_N = variants{} ; -- 
lin receipt_N = mkN "ontvangst" | mkN "ontvangen" neuter ; -- status=guess status=guess
lin native_A = mkA "moeder-" | mkA "geboorte-" | mkA "aangeboren" ; -- status=guess status=guess status=guess
lin chapel_N = mkN "kapel" masculine feminine ; -- status=guess
lin amazing_A = mkA "wonderbaarlijk" | mkA "prachtig" | mkA "verbluffend" ; -- status=guess status=guess status=guess
lin hopefully_Adv = mkAdv "hoopvol" ; -- status=guess
lin fleet_N = mkN "vloot" masculine feminine ; -- status=guess
lin comparable_A = mkA "vergelijkbaar" ; -- status=guess
lin oxygen_N = mkN "zuurstof" feminine ; -- status=guess
lin installation_N = variants{} ; -- 
lin developer_N = mkN "ontwikkelaar" masculine ; -- status=guess
lin disadvantage_N = variants{} ; -- 
lin recipe_N = mkN "recept" neuter ; -- status=guess
lin crystal_N = mkN "kristal" neuter ; -- status=guess
lin modification_N = mkN "modificatie" feminine ; -- status=guess
lin schedule_V2V = variants{} ; -- 
lin schedule_V2 = variants{} ; -- 
lin schedule_V = variants{} ; -- 
lin midnight_N = mkN "middernacht" masculine ; -- status=guess
lin successive_A = variants{} ; -- 
lin formerly_Adv = variants{} ; -- 
lin loud_A = mkA "luidruchtig" | mkA "luidruchtige" ; -- status=guess status=guess
lin value_V2 = variants{} ; -- 
lin value_V = variants{} ; -- 
lin physics_N = mkN "natuurkunde" feminine | mkN "fysica" feminine ; -- status=guess status=guess
lin truck_N = mkN "vrachtauto" masculine | mkN "vrachtwagen" masculine ; -- status=guess status=guess
lin stroke_N = mkN "slag" masculine ; -- status=guess
lin kiss_N = mkN "kus" | mkN "zoen" ; -- status=guess status=guess
lin envelope_N = mkN "omslag" masculine ; -- status=guess
lin speculation_N = mkN "speculatie" feminine ; -- status=guess
lin canal_N = mkN "kanaal" neuter ; -- status=guess
lin unionist_N = variants{} ; -- 
lin directory_N = mkN "gids" masculine | mkN "repertorium" neuter | mkN "telefoongids" | mkN "Gouden gids" | mkN "Witte gids" ; -- status=guess status=guess status=guess status=guess status=guess
lin receiver_N = mkN "hoorn" ; -- status=guess
lin isolation_N = variants{} ; -- 
lin fade_V2 = mkV2 (mkV "verzwakken") | mkV2 (mkV "verslappen") | mkV2 (mkV "verwelken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fade_V = mkV "verzwakken" | mkV "verslappen" | mkV "verwelken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin chemistry_N = mkN "chemie" feminine | mkN "scheikunde" feminine ; -- status=guess status=guess
lin unnecessary_A = mkA "onnodig" ; -- status=guess
lin hit_N = mkN "aanslag" masculine ; -- status=guess
lin defenderMasc_N = mkN "verdediger" masculine ; -- status=guess
lin stance_N = mkN "houding" feminine ; -- status=guess
lin sin_N = mkN "zonde" ; -- status=guess
lin realistic_A = mkA "realistisch" ; -- status=guess
lin socialist_N = mkN "socialist" masculine | mkN "socialiste" feminine ; -- status=guess status=guess
lin subsidy_N = mkN "subsidie" feminine ; -- status=guess
lin content_A = mkA "tevreden" ; -- status=guess
lin toy_N = mkN "speelgoed" neuter ; -- status=guess
lin darling_N = mkN "schat" | mkN "geliefde" | mkN "lieverd" | mkN "lieve" | mkN "schatje" neuter | mkN "liefje" neuter ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin decent_A = mkA "redelijk" ; -- status=guess
lin liberty_N = mkN "vrijheid" feminine ; -- status=guess
lin forever_Adv = mkAdv "eeuwig" | mkAdv "altijd" ; -- status=guess status=guess
lin skirt_N = mkN "rok" masculine ; -- status=guess
lin coordinate_V2 = mkV2 (mkV (mkV "doen") "bijeen passen") | mkV2 (mkV (mkV "zorgen") "dat het bijeenpast") ; -- status=guess, src=wikt status=guess, src=wikt
lin coordinate_V = mkV (mkV "doen") "bijeen passen" | mkV (mkV "zorgen") "dat het bijeenpast" ; -- status=guess, src=wikt status=guess, src=wikt
lin tactic_N = mkN "tactiek" feminine | mkN "gevechtsleer" feminine | mkN "krijgskunde" feminine ; -- status=guess status=guess status=guess
lin influential_A = mkA "invloedrijk" ; -- status=guess
lin import_V2 = mkV2 (mkV "invoeren") | mkV2 (mkV "importeren") ; -- status=guess, src=wikt status=guess, src=wikt
lin accent_N = mkN "accent" neuter ; -- status=guess
lin compound_N = mkN "samenstelling" ; -- status=guess
lin bastard_N = mkN "bastaard" masculine | mkN "hoerenjong" neuter ; -- status=guess status=guess
lin ingredient_N = mkN "ingrediënt" neuter | mkN "bestanddeel" neuter ; -- status=guess status=guess
lin dull_A = L.dull_A ;
lin cater_V = variants{} ; -- 
lin scholar_N = mkN "herdersmat" ; -- status=guess
lin faint_A = mkA "zwak" ; -- status=guess
lin ghost_N = mkN "artefact" neuter ; -- status=guess
lin sculpture_N = mkN "beeldhouwen" ; -- status=guess
lin ridiculous_A = mkA "belachelijk" ; -- status=guess
lin diagnosis_N = mkN "diagnose" feminine ; -- status=guess
lin delegate_N = mkN "afgevaardigde" masculine | mkN "gedelegeerde" masculine ; -- status=guess status=guess
lin neat_A = mkA "net" | mkA "puur" ; -- status=guess status=guess
lin kit_N = mkN "set" ; -- status=guess
lin lion_N = mkN "leeuw" masculine ; -- status=guess
lin dialogue_N = mkN "dialoogvenster" neuter ; -- status=guess
lin repair_V2 = mkV2 (mkV "herstellen") ; -- status=guess, src=wikt
lin repair_V = mkV "herstellen" ; -- status=guess, src=wikt
lin tray_N = variants{} ; -- 
lin fantasy_N = mkN "fantasie" ; -- status=guess
lin leave_N = mkN "verlof" ; -- status=guess
lin export_V2 = mkV2 (mkV "exporteren") ; -- status=guess, src=wikt
lin export_V = mkV "exporteren" ; -- status=guess, src=wikt
lin forth_Adv = mkAdv "voort" ; -- status=guess
lin lamp_N = L.lamp_N ;
lin allege_VS = variants{} ; -- 
lin allege_V2 = variants{} ; -- 
lin pavement_N = mkN "stoep" | mkN "trottoir" neuter ; -- status=guess status=guess
lin brand_N = mkN "merk" neuter ; -- status=guess
lin constable_N = variants{} ; -- 
lin compromise_N = mkN "compromis" neuter ; -- status=guess
lin flag_N = mkN "optie" feminine | mkN "vlag" feminine ; -- status=guess status=guess
lin filter_N = mkN "filter" masculine ; -- status=guess
lin reign_N = mkN "troon" masculine | mkN "heerschap" neuter | mkN "bestuur" neuter | mkN "heerschappij" feminine ; -- status=guess status=guess status=guess status=guess
lin execute_V2 = mkV2 (mkV "uitvoeren") ; -- status=guess, src=wikt
lin pity_N = mkN "medelijden" neuter | mkN "deernis" feminine ; -- status=guess status=guess
lin merit_N = mkN "verdienste" feminine ; -- status=guess
lin diagram_N = mkN "diagram" neuter ; -- status=guess
lin wool_N = mkN "wol" ; -- status=guess
lin organism_N = mkN "organisme" neuter ; -- status=guess
lin elegant_A = mkA "elegant" | mkA "sierlijk" | mkA "gracieus" ; -- status=guess status=guess status=guess
lin red_N = mkN "rood" ; -- status=guess
lin undertaking_N = variants{} ; -- 
lin lesser_A = variants{} ; -- 
lin reach_N = variants{} ; -- 
lin marvellous_A = variants{} ; -- 
lin improved_A = variants{} ; -- 
lin locally_Adv = variants{} ; -- 
lin entity_N = variants{} ; -- 
lin rape_N = mkN "verkrachting" feminine ; -- status=guess
lin secure_A = variants{} ; -- 
lin descend_V2 = mkV2 (mkV "afdalen") ; -- status=guess, src=wikt
lin descend_V = mkV "afdalen" ; -- status=guess, src=wikt
lin backwards_Adv = mkAdv "achterwaarts" ; -- status=guess
lin peer_V = variants{} ; -- 
lin excuse_V2 = mkV2 (mkV "verontschuldigen") | mkV2 (mkV "excuseren") ; -- status=guess, src=wikt status=guess, src=wikt
lin genetic_A = mkA "genetisch" | mkA "erfelijk" ; -- status=guess status=guess
lin fold_V2 = mkV2 (vouwen_V) ; -- status=guess, src=wikt
lin fold_V = vouwen_V ; -- status=guess, src=wikt
lin portfolio_N = variants{} ; -- 
lin consensus_N = mkN "consensus" masculine | mkN "eensgezindheid" | mkN "overeenstemming" ; -- status=guess status=guess status=guess
lin thesis_N = mkN "these" ; -- status=guess
lin shop_V = mkV "winkelen" | mkV (mkV "inkopen") "doen" | mkV "shoppen" | mkV (mkV "boodschappen") "doen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin nest_N = mkN "nest" neuter ; -- status=guess
lin frown_V = mkV "fronsen" ; -- status=guess, src=wikt
lin builder_N = mkN "bouwer" ; -- status=guess
lin administer_V2 = mkV2 (mkV "toedienen") ; -- status=guess, src=wikt
lin administer_V = mkV "toedienen" ; -- status=guess, src=wikt
lin tip_V2 = mkV2 (mkV "tippen") ; -- status=guess, src=wikt
lin tip_V = mkV "tippen" ; -- status=guess, src=wikt
lin lung_N = mkN "long" feminine ; -- status=guess
lin delegation_N = variants{} ; -- 
lin outside_N = mkN "buitenkant" masculine ; -- status=guess
lin heating_N = mkN "verwarming" feminine ; -- status=guess
lin like_Subj = variants{} ; -- 
lin instinct_N = mkN "instinct" neuter ; -- status=guess
lin teenager_N = mkN "tiener" ; -- status=guess
lin lonely_A = mkA "eenzaam" ; -- status=guess
lin residence_N = mkN "residentie" ; -- status=guess
lin radiation_N = mkN "straling" feminine ; -- status=guess
lin extract_V2 = variants{} ; -- 
lin concession_N = variants{} ; -- 
lin autonomy_N = mkN "autonomie" feminine ; -- status=guess
lin norm_N = variants{} ; -- 
lin musicianMasc_N = mkN "muzikant" masculine | mkN "muzikante" feminine | mkN "musicus" masculine feminine ; -- status=guess status=guess status=guess
lin graduate_N = mkN "abituriënt" masculine ; -- status=guess
lin glory_N = mkN "glorie" feminine | mkN "luister" masculine | mkN "pracht" masculine feminine ; -- status=guess status=guess status=guess
lin bear_N = mkN "beer" masculine ; -- status=guess
lin persist_V = mkV "volharden" ; -- status=guess, src=wikt
lin rescue_V2 = mkV2 (mkV "ontzetten") ; -- status=guess, src=wikt
lin equip_V2 = mkV2 (mkV "uitrusten") ; -- status=guess, src=wikt
lin partial_A = mkA "partijdig" ; -- status=guess
lin officially_Adv = mkAdv "officieel" ; -- status=guess
lin capability_N = variants{} ; -- 
lin worry_N = variants{} ; -- 
lin liberation_N = mkN "bevrijding" feminine ; -- status=guess
lin hunt_V2 = L.hunt_V2 ;
lin hunt_V = jagen_V ; -- status=guess, src=wikt
lin daily_Adv = mkAdv "dagelijks" ; -- status=guess
lin heel_N = mkN "korst" masculine ; -- status=guess
lin contract_V2V = variants{} ; -- 
lin contract_V2 = variants{} ; -- 
lin contract_V = variants{} ; -- 
lin update_V2 = mkV2 (mkV "bijwerken") | mkV2 (mkV (mkV "op") "punt stellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin assign_V2V = mkV2V (mkV "toewijzen") ; -- status=guess, src=wikt
lin assign_V2 = mkV2 (mkV "toewijzen") ; -- status=guess, src=wikt
lin spring_V2 = mkV2 (springen_V) ; -- status=guess, src=wikt
lin spring_V = springen_V ; -- status=guess, src=wikt
lin single_N = mkN "vrijgezel" ; -- status=guess
lin commons_N = mkN "volksplaats" ; -- status=guess
lin weekly_A = mkA "wekelijks" | mkA "wekelijkse" ; -- status=guess status=guess
lin stretch_N = mkN "rek" masculine ; -- status=guess
lin pregnancy_N = mkN "zwangerschap" feminine ; -- status=guess
lin happily_Adv = mkAdv "en ze leefden nog lang en gelukkig" ; -- status=guess
lin spectrum_N = variants{} ; -- 
lin interfere_V = mkV "hinderen" | mkV (mkV "moeilijk") "maken" ; -- status=guess, src=wikt status=guess, src=wikt
lin suicide_N = mkN "zelfmoordbrief" masculine ; -- status=guess
lin panic_N = mkN "paniek" feminine ; -- status=guess
lin invent_V2 = mkV2 (mkV "uitdenken") | mkV2 (mkV "uitvinden") | mkV2 (mkV "bedenken") | mkV2 (mkV "verzinnen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin invent_V = mkV "uitdenken" | mkV "uitvinden" | mkV "bedenken" | mkV "verzinnen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin intensive_A = variants{} ; -- 
lin damp_A = mkA "klam" ; -- status=guess
lin simultaneously_Adv = mkAdv "tegelijkertijd" | mkAdv "tegelijk" | mkAdv "simultaan" | mkAdv "gelijktijdig" ; -- status=guess status=guess status=guess status=guess
lin giant_N = mkN "reus" masculine ; -- status=guess
lin casual_A = variants{} ; -- 
lin sphere_N = mkN "bol" masculine | mkN "sfeer" masculine feminine ; -- status=guess status=guess
lin precious_A = mkA "kostbaar" | mkA "waardevol" ; -- status=guess status=guess
lin sword_N = mkN "zwaard" neuter ; -- status=guess
lin envisage_V2 = variants{} ; -- 
lin bean_N = mkN "boon" feminine ; -- status=guess
lin time_V2 = mkV2 (mkV "klokken") | mkV2 (mkV "timen") | mkV2 (mkV "chronometreren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin crazy_A = mkA "gek" ; -- status=guess
lin changing_A = variants{} ; -- 
lin primary_N = mkN "basisschool" utrum | mkN "lagere school" utrum ; -- status=guess status=guess
lin concede_VS = mkVS (mkV "toegeven") ; -- status=guess, src=wikt
lin concede_V2 = mkV2 (mkV "toegeven") ; -- status=guess, src=wikt
lin concede_V = mkV "toegeven" ; -- status=guess, src=wikt
lin besides_Adv = mkAdv "behalve" ; -- status=guess
lin unite_V2 = mkV2 (mkV "verenigen") ; -- status=guess, src=wikt
lin unite_V = mkV "verenigen" ; -- status=guess, src=wikt
lin severely_Adv = variants{} ; -- 
lin separately_Adv = variants{} ; -- 
lin instruct_V2 = mkV2 (mkV "instrueren") ; -- status=guess, src=wikt
lin insert_V2 = mkV2 (mkV "invoegen") ; -- status=guess, src=wikt
lin go_N = mkN "go" neuter ; -- status=guess
lin exhibit_V2 = mkV2 (mkV "vertonen") | mkV2 (mkV "tonen") ; -- status=guess, src=wikt status=guess, src=wikt
lin brave_A = mkA "moedig" ; -- status=guess
lin tutor_N = mkN "studiebegeleider" | mkN "mentor" | mkN "privé-leraar" ; -- status=guess status=guess status=guess
lin tune_N = mkN "deun" masculine | mkN "wijs " masculine ; -- status=guess status=guess
lin debut_N = mkN "debuut" neuter ; -- status=guess
lin debut_2_N = variants{} ; -- 
lin debut_1_N = variants{} ; -- 
lin continued_A = variants{} ; -- 
lin bid_V2 = mkV2 (bieden_V) ; -- status=guess, src=wikt
lin bid_V = bieden_V ; -- status=guess, src=wikt
lin incidence_N = variants{} ; -- 
lin downstairs_Adv = mkAdv "beneden" ; -- status=guess
lin cafe_N = variants{} ; -- 
lin regret_VS = mkVS (mkV "betreuren") | mkVS (spijten_V) | mkVS (mkV "berouwen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin regret_V2 = mkV2 (mkV "betreuren") | mkV2 (spijten_V) | mkV2 (mkV "berouwen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin killer_N = mkN "doder" masculine | mkN "moordenaar" masculine ; -- status=guess status=guess
lin delicate_A = variants{} ; -- 
lin subsidiary_N = mkN "dochterbedrijf" neuter | mkN "filiaal" feminine ; -- status=guess status=guess
lin gender_N = mkN "geslacht" neuter ; -- status=guess
lin entertain_V2 = mkV2 (mkV "vermaken") | mkV2 (mkV "amuseren") ; -- status=guess, src=wikt status=guess, src=wikt
lin cling_V = mkV "klampen" ; -- status=guess, src=wikt
lin vertical_A = mkA "verticaal" ; -- status=guess
lin fetch_V2 = mkV2 (mkV "halen") ; -- status=guess, src=wikt
lin strip_V2 = mkV2 (mkV "asfalt") | mkV2 (mkV "strook") ; -- status=guess, src=wikt status=guess, src=wikt
lin strip_V = mkV "asfalt" | mkV "strook" ; -- status=guess, src=wikt status=guess, src=wikt
lin plead_VS = mkVS (mkV "pleiten") | mkVS (mkV "bepleiten") ; -- status=guess, src=wikt status=guess, src=wikt
lin plead_V2 = mkV2 (mkV "pleiten") | mkV2 (mkV "bepleiten") ; -- status=guess, src=wikt status=guess, src=wikt
lin plead_V = mkV "pleiten" | mkV "bepleiten" ; -- status=guess, src=wikt status=guess, src=wikt
lin duck_N = mkN "eend" feminine ; -- status=guess
lin breed_N = mkN "variëteit" feminine ; -- status=guess
lin assistant_A = variants{} ; -- 
lin pint_N = variants{} ; -- 
lin abolish_V2 = mkV2 (mkV "vernietigen") ; -- status=guess, src=wikt
lin translation_N = mkN "vertaling" feminine ; -- status=guess
lin princess_N = mkN "prinses" feminine ; -- status=guess
lin line_V2 = mkV2 (mkV "voeren") | mkV2 (mkV "bedekken") | mkV2 (mkV "bekleden") | mkV2 (mkV "bekleden") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin line_V = mkV "voeren" | mkV "bedekken" | mkV "bekleden" | mkV "bekleden" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin excessive_A = mkA "overmatig" ; -- status=guess
lin digital_A = mkA "vinger-" ; -- status=guess
lin steep_A = mkA "steil" ; -- status=guess
lin jet_N = mkN "straalvliegtuig" neuter | mkN "straaljager" ; -- status=guess status=guess
lin hey_Interj = mkInterj "he" | mkInterj "he daar" ; -- status=guess status=guess
lin grave_N = mkN "graf" neuter ; -- status=guess
lin exceptional_A = variants{} ; -- 
lin boost_V2 = mkV2 (mkV (mkV "een") "zetje geven") | mkV2 (mkV (mkV "een") "duwtje geven") | mkV2 (mkV (mkV "een") "duwtje in de rug geven") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin random_A = mkA "willekeurig" | mkA "toevallig" | mkA "lukraak" ; -- status=guess status=guess status=guess
lin correlation_N = mkN "correlatie" feminine ; -- status=guess
lin outline_N = mkN "omtrek" ; -- status=guess
lin intervene_V2V = mkV2V (mkV "tussenkomen") | mkV2V (mkV "ingrijpen") | mkV2V (mkV "interveniëren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin intervene_V = mkV "tussenkomen" | mkV "ingrijpen" | mkV "interveniëren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin packet_N = variants{} ; -- 
lin motivation_N = variants{} ; -- 
lin safely_Adv = mkAdv "veilig" ; -- status=guess
lin harsh_A = mkA "ruw" | mkA "grof" ; -- status=guess status=guess
lin spell_N = mkN "betovering" feminine ; -- status=guess
lin spread_N = variants{} ; -- 
lin draw_N = mkN "trekking" feminine ; -- status=guess
lin concrete_A = mkA "betonnen" ; -- status=guess
lin complicated_A = mkA "ingewikkeld" | mkA "gecompliceerd" ; -- status=guess status=guess
lin alleged_A = mkA "verondersteld" ; -- status=guess
lin redundancy_N = mkN "herhaling" masculine ; -- status=guess
lin progressive_A = mkA "progressief" ; -- status=guess
lin intensity_N = variants{} ; -- 
lin crack_N = mkN "spleet" ; -- status=guess
lin fly_N = mkN "vlucht" ; -- status=guess
lin fancy_V2 = mkV2 (reflMkV "aangetrokken voelen tot iemand") ; -- status=guess, src=wikt
lin alternatively_Adv = variants{} ; -- 
lin waiting_A = variants{} ; -- 
lin scandal_N = mkN "schande" | mkN "oneer" ; -- status=guess status=guess
lin resemble_V2 = mkV2 (mkV (mkV "gelijken") "op") | mkV2 (mkV (mkV "lijken") "op") ; -- status=guess, src=wikt status=guess, src=wikt
lin parameter_N = variants{} ; -- 
lin fierce_A = variants{} ; -- 
lin tropical_A = mkA "tropisch" ; -- status=guess
lin colour_V2A = variants{} ; -- 
lin colour_V2 = variants{} ; -- 
lin colour_V = variants{} ; -- 
lin engagement_N = mkN "verlovingsring" masculine ; -- status=guess
lin contest_N = mkN "wedstrijd" ; -- status=guess
lin edit_V2 = mkV2 (mkV "bewerken") | mkV2 (mkV "wijzigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin courage_N = mkN "moed" masculine | mkN "dapperheid" feminine ; -- status=guess status=guess
lin hip_N = mkN "heup" feminine ; -- status=guess
lin delighted_A = variants{} ; -- 
lin sponsor_V2 = mkV2 (mkV "sponsoren") ; -- status=guess, src=wikt
lin carer_N = mkN "verzorger" ; -- status=guess
lin crack_V2 = mkV2 (mkV "kraken") ; -- status=guess, src=wikt
lin substantially_Adv = variants{} ; -- 
lin occupational_A = variants{} ; -- 
lin trainer_N = mkN "trainer" masculine | mkN "trainster" feminine ; -- status=guess status=guess
lin remainder_N = mkN "overschot" neuter | mkN "overstock" masculine | mkN "onverkochte" ; -- status=guess status=guess status=guess
lin related_A = mkA "verwant" ; -- status=guess
lin inherit_V2 = mkV2 (mkV "erven") ; -- status=guess, src=wikt
lin inherit_V = mkV "erven" ; -- status=guess, src=wikt
lin resume_V2 = mkV2 (mkV "hervatten") | mkV2 (mkV "voortzetten") ; -- status=guess, src=wikt status=guess, src=wikt
lin resume_V = mkV "hervatten" | mkV "voortzetten" ; -- status=guess, src=wikt status=guess, src=wikt
lin assignment_N = mkN "toewijzen" neuter ; -- status=guess
lin conceal_V2 = mkV2 (mkV "verbergen") | mkV2 (mkV "verstoppen") ; -- status=guess, src=wikt status=guess, src=wikt
lin disclose_VS = mkVS (mkV "onthullen") | mkVS (mkV "ontsluieren") | mkVS (mkV "bekendmaken") | mkVS (mkV "vrijgeven") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V2 = mkV2 (mkV "onthullen") | mkV2 (mkV "ontsluieren") | mkV2 (mkV "bekendmaken") | mkV2 (mkV "vrijgeven") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V = mkV "onthullen" | mkV "ontsluieren" | mkV "bekendmaken" | mkV "vrijgeven" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exclusively_Adv = mkAdv "uitsluitend" | mkAdv "exclusief" ; -- status=guess status=guess
lin working_N = mkN "werkdag" ; -- status=guess
lin mild_A = mkA "mild" | mkA "zacht" ; -- status=guess status=guess
lin chronic_A = mkA "chronisch" ; -- status=guess
lin splendid_A = mkA "schitterend" | mkA "prachtig" ; -- status=guess status=guess
lin function_V = mkV "functioneren" ; -- status=guess, src=wikt
lin riderMasc_N = mkN "ruiter" masculine feminine | mkN "motorrijder" masculine feminine ; -- status=guess status=guess
lin clay_N = mkN "klei" masculine ; -- status=guess
lin firstly_Adv = variants{} ; -- 
lin conceive_V2 = mkV2 (mkV (mkV "zwanger") "worden") ; -- status=guess, src=wikt
lin conceive_V = mkV (mkV "zwanger") "worden" ; -- status=guess, src=wikt
lin politically_Adv = mkAdv "staatkundig" ; -- status=guess
lin terminal_N = mkN "terminaal haar" neuter ; -- status=guess
lin accuracy_N = mkN "nauwkeurigheid" | mkN "precisie" ; -- status=guess status=guess
lin coup_N = mkN "coup" ; -- status=guess
lin ambulance_N = mkN "ziekenwagen" masculine | mkN "ambulance" masculine ; -- status=guess status=guess
lin living_N = mkN "ondode" masculine | mkN "levende dode" masculine | mkN "zombie" masculine ; -- status=guess status=guess status=guess
lin offenderMasc_N = mkN "schuldige" masculine feminine ; -- status=guess
lin similarity_N = mkN "gelijkenis" feminine ; -- status=guess
lin orchestra_N = mkN "orkest" neuter ; -- status=guess
lin brush_N = mkN "borstel" masculine ; -- status=guess
lin systematic_A = variants{} ; -- 
lin striker_N = variants{} ; -- 
lin guard_V2 = mkV2 (mkV "bewaken") ; -- status=guess, src=wikt
lin guard_V = mkV "bewaken" ; -- status=guess, src=wikt
lin casualty_N = mkN "slachtoffer" ; -- status=guess
lin steadily_Adv = variants{} ; -- 
lin painter_N = mkN "schilder" masculine | mkN "kunstschilder" masculine ; -- status=guess status=guess
lin opt_VV = variants{} ; -- 
lin opt_V = variants{} ; -- 
lin handsome_A = mkA "knap" ; -- status=guess
lin banking_N = variants{} ; -- 
lin sensitivity_N = mkN "gevoeligheid" feminine ; -- status=guess
lin navy_N = mkN "marineblauw" masculine ; -- status=guess
lin fascinating_A = variants{} ; -- 
lin disappointment_N = mkN "tegenvaller" | mkN "tegenslag" ; -- status=guess status=guess
lin auditor_N = variants{} ; -- 
lin hostility_N = mkN "vijandigheid" feminine | mkN "vijandelijkheid" feminine ; -- status=guess status=guess
lin spending_N = variants{} ; -- 
lin scarcely_Adv = mkAdv "amper" | mkAdv "nauwelijks" ; -- status=guess status=guess
lin compulsory_A = mkA "verplicht" ; -- status=guess
lin photographer_N = mkN "fotograaf" masculine ; -- status=guess
lin ok_Interj = variants{} ; -- 
lin neighbourhood_N = mkN "buurt" feminine | mkN "kwartier" neuter | mkN "wijk" ; -- status=guess status=guess status=guess
lin ideological_A = mkA "ideologisch" ; -- status=guess
lin wide_Adv = variants{} ; -- 
lin pardon_N = variants{} ; -- 
lin double_N = mkN "koeterwaals" neuter | mkN "wartaal" ; -- status=guess status=guess
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin supervision_N = mkN "supervisie" feminine | mkN "toezicht" neuter ; -- status=guess status=guess
lin guilt_N = mkN "schuldgevoel" neuter ; -- status=guess
lin deck_N = mkN "dek" neuter ; -- status=guess
lin payable_A = variants{} ; -- 
lin execution_N = mkN "uitvoering" feminine ; -- status=guess
lin suite_N = variants{} ; -- 
lin elected_A = variants{} ; -- 
lin solely_Adv = variants{} ; -- 
lin moral_N = mkN "moreel wangedrag" | mkN "moreel risico" ; -- status=guess status=guess
lin collector_N = mkN "verzamelaar" masculine ; -- status=guess
lin questionnaire_N = variants{} ; -- 
lin flavour_N = mkN "smaakstof" ; -- status=guess
lin couple_V2 = mkV2 (mkV "koppelen") ; -- status=guess, src=wikt
lin couple_V = mkV "koppelen" ; -- status=guess, src=wikt
lin faculty_N = mkN "faculteit" ; -- status=guess
lin tour_V2 = mkV2 (tour_V) ;
lin tour_V = mkV "reizen" ;
lin basket_N = mkN "gescoorde korf" ; -- status=guess
lin mention_N = mkN "vermelding" feminine ; -- status=guess
lin kick_N = mkN "schop" | mkN "stamp" masculine ; -- status=guess status=guess
lin horizon_N = mkN "horizon" masculine | mkN "horizont" masculine ; -- status=guess status=guess
lin drain_V2 = mkV2 (mkV (mkV "leeg") "laten lopen") ; -- status=guess, src=wikt
lin drain_V = mkV (mkV "leeg") "laten lopen" ; -- status=guess, src=wikt
lin happiness_N = mkN "blijheid" feminine | mkN "blijdschap" | mkN "geluk" neuter ; -- status=guess status=guess status=guess
lin fighter_N = mkN "gevechtsvliegtuig" neuter | mkN "straaljager" ; -- status=guess status=guess
lin estimated_A = variants{} ; -- 
lin copper_N = mkN "koper" neuter ; -- status=guess
lin legend_N = mkN "legende" feminine ; -- status=guess
lin relevance_N = variants{} ; -- 
lin decorate_V2 = mkV2 (mkV "sieren") | mkV2 (mkV "opsmukken") | mkV2 (mkV "decoreren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin continental_A = variants{} ; -- 
lin ship_V2 = mkV2 (mkV "doorgeven") ; -- status=guess, src=wikt
lin ship_V = mkV "doorgeven" ; -- status=guess, src=wikt
lin operational_A = variants{} ; -- 
lin incur_V2 = mkV2 (reflMkV "blootstellen aan") ; -- status=guess, src=wikt
lin parallel_A = mkA "evenwijdig" | mkA "parallel" ; -- status=guess status=guess
lin divorce_N = mkN "echtscheiding" feminine ; -- status=guess
lin opposed_A = variants{} ; -- 
lin equilibrium_N = mkN "evenwicht" neuter ; -- status=guess
lin trader_N = mkN "handelaar" masculine ; -- status=guess
lin ton_N = mkN "ton" ; -- status=guess
lin can_N = mkN "blik" neuter ; -- status=guess
lin juice_N = mkN "sap" neuter ; -- status=guess
lin forum_N = variants{} ; -- 
lin spin_V2 = mkV2 (spinnen_V) ; -- status=guess, src=wikt
lin spin_V = spinnen_V ; -- status=guess, src=wikt
lin research_V2 = mkV2 (mkV "onderzoeken") | mkV2 (mkV "uitvissen") | mkV2 (mkV "uitzoeken") | mkV2 (mkV "nagaan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin research_V = mkV "onderzoeken" | mkV "uitvissen" | mkV "uitzoeken" | mkV "nagaan" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hostile_A = mkA "vijandig" ; -- status=guess
lin consistently_Adv = variants{} ; -- 
lin technological_A = variants{} ; -- 
lin nightmare_N = mkN "nachtmerrie" feminine ; -- status=guess
lin medal_N = mkN "medaille" masculine feminine | mkN "erepenning" feminine ; -- status=guess status=guess
lin diamond_N = mkN "diamant" masculine ; -- status=guess
lin speed_V2 = mkV2 (mkV "snellen") ; -- status=guess, src=wikt
lin speed_V = mkV "snellen" ; -- status=guess, src=wikt
lin peaceful_A = mkA "vredig" | mkA "vreedzaam" ; -- status=guess status=guess
lin accounting_A = variants{} ; -- 
lin scatter_V2 = mkV2 (mkV "verstrooien") ; -- status=guess, src=wikt
lin scatter_V = mkV "verstrooien" ; -- status=guess, src=wikt
lin monster_N = mkN "monstertje" neuter ; -- status=guess
lin horrible_A = variants{} ; -- 
lin nonsense_N = mkN "nonsens" masculine | mkN "onzin" masculine | mkN "flauwekul" masculine ; -- status=guess status=guess status=guess
lin chaos_N = mkN "chaos" masculine | mkN "baaierd" masculine ; -- status=guess status=guess
lin accessible_A = variants{} ; -- 
lin humanity_N = mkN "mensheid" feminine | mkN "mensdom" neuter | mkN "mensengeslacht" neuter ; -- status=guess status=guess status=guess
lin frustration_N = mkN "frustratie" feminine ; -- status=guess
lin chin_N = mkN "kin" ; -- status=guess
lin bureau_N = mkN "kledingkast " masculine | mkN "kast " masculine ; -- status=guess status=guess
lin advocate_VS = mkVS (mkV "bepleiten") ; -- status=guess, src=wikt
lin advocate_V2 = mkV2 (mkV "bepleiten") ; -- status=guess, src=wikt
lin polytechnic_N = variants{} ; -- 
lin inhabitant_N = mkN "bewoner" masculine | mkN "inwoner" ; -- status=guess status=guess
lin evil_A = mkA "kwaadaardig" | mkA "boosaardig" | mkA "kwaad" | mkA "slecht" | mkA "euvel" ; -- status=guess status=guess status=guess status=guess status=guess
lin slave_N = mkN "slaaf" ; -- status=guess
lin reservation_N = mkN "reservatie" feminine ; -- status=guess
lin slam_V2 = mkV2 (mkV "toeslagen") ; -- status=guess, src=wikt
lin slam_V = mkV "toeslagen" ; -- status=guess, src=wikt
lin handle_N = mkN "handvat" neuter | mkN "handgreep" feminine | mkN "hengsel" neuter | mkN "heft" neuter ; -- status=guess status=guess status=guess status=guess
lin provincial_A = mkA "provinciaal" ; -- status=guess
lin fishing_N = mkN "vissersboot" utrum ; -- status=guess
lin facilitate_V2 = variants{} ; -- 
lin yield_N = variants{} ; -- 
lin elbow_N = mkN "elleboog" masculine ; -- status=guess
lin bye_Interj = mkInterj "dag" | mkInterj "doei" | mkInterj "tot ziens" | mkInterj "hoie" | mkInterj "houdoe" | mkInterj "doeg" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin warm_V2 = mkV2 (mkV "warmlopen") ; -- status=guess, src=wikt
lin warm_V = mkV "warmlopen" ; -- status=guess, src=wikt
lin sleeve_N = mkN "mouw" ; -- status=guess
lin exploration_N = mkN "verkenning" feminine | mkN "exploratie" ; -- status=guess status=guess
lin creep_V = mkV "opschuiven" ; -- status=guess, src=wikt
lin adjacent_A = mkA "aanpalend" | mkA "tegenoverstaand" ; -- status=guess status=guess
lin theft_N = mkN "diefstal" feminine ; -- status=guess
lin round_V2 = mkV2 (mkV "uitwerken") ; -- status=guess, src=wikt
lin round_V = mkV "uitwerken" ; -- status=guess, src=wikt
lin grace_N = mkN "gratie" feminine | mkN "elegantie" feminine ; -- status=guess status=guess
lin predecessor_N = variants{} ; -- 
lin supermarket_N = mkN "supermarktketen" ; -- status=guess
lin smart_A = mkA "slim" ; -- status=guess
lin sergeant_N = mkN "sergeant" ; -- status=guess
lin regulate_V2 = mkV2 (mkV "regelen") ; -- status=guess, src=wikt
lin clash_N = variants{} ; -- 
lin assemble_V2 = mkV2 (mkV "samenkomen") | mkV2 (reflMkV "verzamelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin assemble_V = mkV "samenkomen" | reflMkV "verzamelen" ; -- status=guess, src=wikt status=guess, src=wikt
lin arrow_N = mkN "pijl" masculine ; -- status=guess
lin nowadays_Adv = mkAdv "heden" | mkAdv "momenteel" | mkAdv "nu" ; -- status=guess status=guess status=guess
lin giant_A = mkA "reusachtig" | mkA "reuzen-" ; -- status=guess status=guess
lin waiting_N = mkN "bedienen" ; -- status=guess
lin tap_N = mkN "kraan" feminine ; -- status=guess
lin shit_N = mkN "diarree" | mkN "racekak" ; -- status=guess status=guess
lin sandwich_N = mkN "boterham" masculine | mkN "sandwich" masculine ; -- status=guess status=guess
lin vanish_V = verdwijnen_V ; -- status=guess, src=wikt
lin commerce_N = mkN "handel" masculine | mkN "commercie" feminine ; -- status=guess status=guess
lin pursuit_N = variants{} ; -- 
lin post_war_A = variants{} ; -- 
lin will_V2 = mkV2 (mkV "zullen") ; -- status=guess, src=wikt
lin will_V = mkV "zullen" ; -- status=guess, src=wikt
lin waste_A = mkA "woest" | mkA "braakliggend" ; -- status=guess status=guess
lin collar_N = mkN "boord" | mkN "gordel" | mkN "rand" | mkN "ring" ; -- status=guess status=guess status=guess status=guess
lin socialism_N = mkN "socialisme" neuter ; -- status=guess
lin skill_V = variants{} ; -- 
lin rice_N = mkN "rijst" masculine ; -- status=guess
lin exclusion_N = variants{} ; -- 
lin upwards_Adv = mkAdv "opwaarts" ; -- status=guess
lin transmission_N = variants{} ; -- 
lin instantly_Adv = variants{} ; -- 
lin forthcoming_A = variants{} ; -- 
lin appointed_A = variants{} ; -- 
lin geographical_A = variants{} ; -- 
lin fist_N = mkN "vuist" feminine ; -- status=guess
lin abstract_A = mkA "afwezig" | mkA "verstrooid" ; -- status=guess status=guess
lin embrace_V2 = mkV2 (mkV "omarmen") | mkV2 (mkV "omhelzen") | mkV2 (mkV "knuffelen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin embrace_V = mkV "omarmen" | mkV "omhelzen" | mkV "knuffelen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dynamic_A = mkA "dynamisch" | mkA "dynamische" ; -- status=guess status=guess
lin drawer_N = mkN "tekenaar" masculine | mkN "tekenares" feminine ; -- status=guess status=guess
lin dismissal_N = mkN "ontslag" neuter ; -- status=guess
lin magic_N = mkN "toverij" feminine ; -- status=guess
lin endless_A = mkA "eindeloos" ; -- status=guess
lin definite_A = variants{} ; -- 
lin broadly_Adv = variants{} ; -- 
lin affection_N = mkN "genegenheid" ; -- status=guess
lin dawn_N = mkN "dageraad" masculine | mkN "opgang" masculine ; -- status=guess status=guess
lin principal_N = mkN "schoolhoofd" | mkN "rector" ; -- status=guess status=guess
lin bloke_N = variants{} ; -- 
lin trap_N = mkN "waterslot" neuter | mkN "zwanenhals" masculine ; -- status=guess status=guess
lin communist_A = mkA "communistisch" ; -- status=guess
lin competence_N = mkN "competentie" | mkN "bekwaamheid" ; -- status=guess status=guess
lin complicate_V2 = mkV2 (mkV "compliceren") ; -- status=guess, src=wikt
lin neutral_A = mkA "neutraal" ; -- status=guess
lin fortunately_Adv = mkAdv "gelukkig" | mkAdv "gelukkigerwijs" ; -- status=guess status=guess
lin commonwealth_N = mkN "gemenebest" neuter ; -- status=guess
lin breakdown_N = mkN "defect" neuter | mkN "mankement" neuter | mkN "panne" feminine | mkN "stilstand" masculine ; -- status=guess status=guess status=guess status=guess
lin combined_A = variants{} ; -- 
lin candle_N = mkN "kaars" feminine ; -- status=guess
lin venue_N = variants{} ; -- 
lin supper_N = mkN "avondeten" ; -- status=guess
lin analyst_N = mkN "analist" masculine | mkN "analiste" feminine ; -- status=guess status=guess
lin vague_A = mkA "vaag" ; -- status=guess
lin publicly_Adv = variants{} ; -- 
lin marine_A = mkA "marien" | mkA "maritiem" ; -- status=guess status=guess
lin fair_Adv = variants{} ; -- 
lin pause_N = mkN "pauze" utrum ; -- status=guess
lin notable_A = mkA "waarneembaar" ; -- status=guess
lin freely_Adv = variants{} ; -- 
lin counterpart_N = mkN "complement" neuter | mkN "pendant" masculine | mkN "tegenhanger" masculine ; -- status=guess status=guess status=guess
lin lively_A = mkA "levendig" ; -- status=guess
lin script_N = mkN "geschrift" neuter ; -- status=guess
lin sue_V2V = mkV2V (mkV "aanklagen") ; -- status=guess, src=wikt
lin sue_V2 = mkV2 (mkV "aanklagen") ; -- status=guess, src=wikt
lin sue_V = mkV "aanklagen" ; -- status=guess, src=wikt
lin legitimate_A = variants{} ; -- 
lin geography_N = mkN "geografie" feminine | mkN "aardrijkskunde" feminine ; -- status=guess status=guess
lin reproduce_V2 = mkV2 (mkV "voortpanten") ; -- status=guess, src=wikt
lin reproduce_V = mkV "voortpanten" ; -- status=guess, src=wikt
lin moving_A = mkA "ontroerend" | mkA "ontroerende" ; -- status=guess status=guess
lin lamb_N = mkN "lam" neuter | mkN "lamsvlees" neuter ; -- status=guess status=guess
lin gay_A = mkA "verwijfd" ; -- status=guess
lin contemplate_VS = variants{} ; -- 
lin contemplate_V2 = variants{} ; -- 
lin contemplate_V = variants{} ; -- 
lin terror_N = mkN "verschrikking" feminine ; -- status=guess
lin stable_N = mkN "stal" ; -- status=guess
lin founder_N = mkN "stichter" masculine | mkN "grondlegger" masculine | mkN "oprichter" masculine ; -- status=guess status=guess status=guess
lin utility_N = mkN "voorziening" feminine ; -- status=guess
lin signal_VS = variants{} ; -- 
lin signal_V2 = variants{} ; -- 
lin shelter_N = mkN "onderdak" neuter ; -- status=guess
lin poster_N = variants{} ; -- 
lin hitherto_Adv = mkAdv "tot dan toe" | mkAdv "tot hiertoe" | mkAdv "tot dusver" ; -- status=guess status=guess status=guess
lin mature_A = mkA "volwassen" ; -- status=guess
lin cooking_N = variants{} ; -- 
lin head_A = variants{} ; -- 
lin wealthy_A = variants{} ; -- 
lin fucking_A = mkA "fucking" | mkA "focking" | mkA "fakking" | mkA "kanker" ; -- status=guess status=guess status=guess status=guess
lin confess_VS = mkVS (mkV "bekennen") ; -- status=guess, src=wikt
lin confess_V2 = mkV2 (mkV "bekennen") ; -- status=guess, src=wikt
lin confess_V = mkV "bekennen" ; -- status=guess, src=wikt
lin age_V = mkV (mkV "oud") "worden" | mkV "verouderen" ; -- status=guess, src=wikt status=guess, src=wikt
lin miracle_N = mkN "wonder" neuter | mkN "mirakel" neuter ; -- status=guess status=guess
lin magic_A = mkA "magisch" | mkA "goochel-" ; -- status=guess status=guess
lin jaw_N = mkN "kaak" feminine ; -- status=guess
lin pan_N = mkN "panarabisme" ; -- status=guess
lin coloured_A = variants{} ; -- 
lin tent_N = mkN "tent" masculine ; -- status=guess
lin telephone_V2 = mkV2 (mkV "telefoneren") ; -- status=guess, src=wikt
lin telephone_V = mkV "telefoneren" ; -- status=guess, src=wikt
lin reduced_A = mkA "afgeprijsd" | mkA "gesoldeerd" | mkA "gebradeerd" | mkA "in aanbieding" ; -- status=guess status=guess status=guess status=guess
lin tumour_N = variants{} ; -- 
lin super_A = mkA "super" ; -- status=guess
lin funding_N = mkN "financiering" ; -- status=guess
lin dump_V2 = mkV2 (mkV "dumpen") ; -- status=guess, src=wikt
lin dump_V = mkV "dumpen" ; -- status=guess, src=wikt
lin stitch_N = variants{} ; -- 
lin shared_A = mkA "gedeeld" | mkA "gezamenlijk" | mkA "verdeeld" ; -- status=guess status=guess status=guess
lin ladder_N = mkN "ladder" feminine ; -- status=guess
lin keeper_N = mkN "bewaker" masculine | mkN "conservator" masculine ; -- status=guess status=guess
lin endorse_V2 = mkV2 (mkV "ondersteunen") | mkV2 (mkV "aanbevelen") | mkV2 (mkV "goedkeuren") | mkV2 (mkV "bevestigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin invariably_Adv = mkAdv "onveranderlijk steevast" ; -- status=guess
lin smash_V2 = variants{} ; -- 
lin smash_V = variants{} ; -- 
lin shield_N = mkN "bescherming" feminine | mkN "scherm" neuter ; -- status=guess status=guess
lin heat_V2 = mkV2 (mkV "opwinden") | mkV2 (mkV (mkV "heet") "worden") ; -- status=guess, src=wikt status=guess, src=wikt
lin heat_V = mkV "opwinden" | mkV (mkV "heet") "worden" ; -- status=guess, src=wikt status=guess, src=wikt
lin surgeon_N = mkN "chirurg" ; -- status=guess
lin centre_V2 = variants{} ; -- 
lin centre_V = variants{} ; -- 
lin orange_N = mkN "oranje" neuter ; -- status=guess
lin orange_2_N = variants{} ; -- 
lin orange_1_N = variants{} ; -- 
lin explode_V = mkV "opblazen" ; -- status=guess, src=wikt
lin comedy_N = mkN "komedie" feminine | mkN "blijspel" neuter ; -- status=guess status=guess
lin classify_V2 = mkV2 (mkV "rangschikken") | mkV2 (mkV "classificeren") ; -- status=guess, src=wikt status=guess, src=wikt
lin artistic_A = mkA "kunstzinnig" | mkA "artistiek" ; -- status=guess status=guess
lin ruler_N = mkN "meetlat" | mkN "liniaal" ; -- status=guess status=guess
lin biscuit_N = mkN "koekje" | mkN "biscuit" ; -- status=guess status=guess
lin workstation_N = variants{} ; -- 
lin prey_N = mkN "prooi" ; -- status=guess
lin manual_N = mkN "handleiding" feminine | mkN "handboek" neuter ; -- status=guess status=guess
lin cure_N = mkN "remedie" feminine ; -- status=guess
lin cure_2_N = variants{} ; -- 
lin cure_1_N = variants{} ; -- 
lin overall_N = variants{} ; -- 
lin tighten_V2 = variants{} ; -- 
lin tighten_V = variants{} ; -- 
lin tax_V2 = variants{} ; -- 
lin pope_N = mkN "paus" masculine ; -- status=guess
lin manufacturing_A = variants{} ; -- 
lin adult_A = variants{} ; -- 
lin rush_N = mkN "bies" ; -- status=guess
lin blanket_N = mkN "deken" masculine feminine ; -- status=guess
lin republican_N = mkN "republikein" ; -- status=guess
lin referendum_N = mkN "referendum" neuter ; -- status=guess
lin palm_N = mkN "palm" masculine | mkN "handpalm" masculine ; -- status=guess status=guess
lin nearby_Adv = mkAdv "dichtbij" | mkAdv "nabij" ; -- status=guess status=guess
lin mix_N = variants{} ; -- 
lin devil_N = mkN "duivel" masculine ; -- status=guess
lin adoption_N = variants{} ; -- 
lin workforce_N = variants{} ; -- 
lin segment_N = mkN "segment" ; -- status=guess
lin regardless_Adv = variants{} ; -- 
lin contractor_N = mkN "uitvoerder" ; -- status=guess
lin portion_N = mkN "deel" neuter | mkN "portie" feminine ; -- status=guess status=guess
lin differently_Adv = variants{} ; -- 
lin deposit_V2 = mkV2 (mkV "storten") ; -- status=guess, src=wikt
lin cook_N = mkN "kok" masculine | mkN "kokkin" feminine ; -- status=guess status=guess
lin prediction_N = mkN "voorspelling" feminine ; -- status=guess
lin oven_N = mkN "oven" masculine ; -- status=guess
lin matrix_N = mkN "matrix" masculine ; -- status=guess
lin liver_N = L.liver_N ;
lin fraud_N = mkN "fraude" utrum | mkN "flessentrekkerij" feminine | mkN "bedrog" neuter | mkN "oplichterij" feminine | mkN "oplichting" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin beam_N = mkN "balk" ; -- status=guess
lin signature_N = mkN "handtekening" ; -- status=guess
lin limb_N = variants{} ; -- 
lin verdict_N = mkN "uitspraak" ; -- status=guess
lin dramatically_Adv = variants{} ; -- 
lin container_N = mkN "statiegeld" ; -- status=guess
lin aunt_N = mkN "tante" feminine ; -- status=guess
lin dock_N = mkN "dok" neuter ; -- status=guess
lin submission_N = mkN "inzending" feminine ; -- status=guess
lin arm_V2 = mkV2 (mkV "bewapenen") ; -- status=guess, src=wikt
lin arm_V = mkV "bewapenen" ; -- status=guess, src=wikt
lin odd_N = variants{} ; -- 
lin certainty_N = mkN "zekerheid" feminine ; -- status=guess
lin boring_A = mkA "saai" ; -- status=guess
lin electron_N = mkN "elektron" neuter ; -- status=guess
lin drum_N = mkN "drum and bass" utrum ; -- status=guess
lin wisdom_N = mkN "wijsheid" utrum ; -- status=guess
lin antibody_N = mkN "antilichaam" neuter | mkN "antideeltje" neuter ; -- status=guess status=guess
lin unlike_A = variants{} ; -- 
lin terrorist_N = mkN "terrorist" masculine ; -- status=guess
lin post_V2 = variants{} ; -- 
lin post_V = variants{} ; -- 
lin circulation_N = mkN "oplage" ; -- status=guess
lin alteration_N = variants{} ; -- 
lin fluid_N = mkN "vloeistof" feminine ; -- status=guess
lin ambitious_A = mkA "eerzuchtig" | mkA "ambitieus" ; -- status=guess status=guess
lin socially_Adv = variants{} ; -- 
lin riot_N = mkN "rel" masculine ; -- status=guess
lin petition_N = mkN "verzoekschrift" neuter | mkN "petitie" feminine ; -- status=guess status=guess
lin fox_N = mkN "vos" masculine ; -- status=guess
lin recruitment_N = variants{} ; -- 
lin well_known_A = variants{} ; -- 
lin top_V2 = mkV2 (mkV "uitmunten") ; -- status=guess, src=wikt
lin service_V2 = variants{} ; -- 
lin flood_V2 = mkV2 (mkV "overstromen") ; -- status=guess, src=wikt
lin flood_V = mkV "overstromen" ; -- status=guess, src=wikt
lin taste_V2 = mkV2 (mkV "smaken") ; -- status=guess, src=wikt
lin taste_V = mkV "smaken" ; -- status=guess, src=wikt
lin memorial_N = mkN "herdenkingsplaats" masculine ; -- status=guess
lin helicopter_N = mkN "helikopter" masculine ; -- status=guess
lin correspondence_N = mkN "correspondentie" feminine ; -- status=guess
lin beef_N = mkN "bief" | mkN "biefstuk" | mkN "rundvlees" neuter ; -- status=guess status=guess status=guess
lin overall_Adv = mkAdv "globaal" ; -- status=guess
lin lighting_N = variants{} ; -- 
lin harbour_N = L.harbour_N ;
lin empirical_A = variants{} ; -- 
lin shallow_A = mkA "oppervlakkig" ; -- status=guess
lin seal_V2 = mkV2 (mkV "verzegelen") ; -- status=guess, src=wikt
lin seal_V = mkV "verzegelen" ; -- status=guess, src=wikt
lin decrease_V2 = mkV2 (mkV "afnemen") ; -- status=guess, src=wikt
lin decrease_V = mkV "afnemen" ; -- status=guess, src=wikt
lin constituent_N = variants{} ; -- 
lin exam_N = variants{} ; -- 
lin toe_N = mkN "teen" masculine ; -- status=guess
lin reward_V2 = mkV2 (mkV "belonen") ; -- status=guess, src=wikt
lin thrust_V2 = mkV2 (mkV "vooruitstuwen") ; -- status=guess, src=wikt
lin thrust_V = mkV "vooruitstuwen" ; -- status=guess, src=wikt
lin bureaucracy_N = mkN "bureaucratie" feminine ; -- status=guess
lin wrist_N = mkN "pols" masculine ; -- status=guess
lin nut_N = mkN "noot" feminine ; -- status=guess
lin plain_N = mkN "vlakte" ; -- status=guess
lin magnetic_A = mkA "magnetisch" ; -- status=guess
lin evil_N = mkN "kwade" neuter | mkN "kwaad" neuter | mkN "slechte" neuter | mkN "euvel" neuter ; -- status=guess status=guess status=guess status=guess
lin widen_V2 = variants{} ; -- 
lin hazard_N = mkN "toeval" ; -- status=guess
lin dispose_V2 = variants{} ; -- 
lin dispose_V = variants{} ; -- 
lin dealing_N = variants{} ; -- 
lin absent_A = mkA "afwezig" | mkA "weg" ; -- status=guess status=guess
lin reassure_V2S = variants{} ; -- 
lin reassure_V2 = variants{} ; -- 
lin model_V2 = mkV2 (mkV (mkV "model") "staan") ; -- status=guess, src=wikt
lin model_V = mkV (mkV "model") "staan" ; -- status=guess, src=wikt
lin inn_N = mkN "herberg" masculine ; -- status=guess
lin initial_N = mkN "beginletter" | mkN "initiaal" | mkN "voorletter" ; -- status=guess status=guess status=guess
lin suspension_N = mkN "voorhouding" feminine ; -- status=guess
lin respondent_N = variants{} ; -- 
lin over_N = variants{} ; -- 
lin naval_A = variants{} ; -- 
lin monthly_A = variants{} ; -- 
lin log_N = mkN "houtblok" masculine ; -- status=guess
lin advisory_A = variants{} ; -- 
lin fitness_N = variants{} ; -- 
lin blank_A = variants{} ; -- 
lin indirect_A = mkA "onrechtstreeks" | mkA "indirect" ; -- status=guess status=guess
lin tile_N = mkN "tegel" masculine | mkN "vloertegel" feminine | mkN "muurtegel" masculine | mkN "pan" feminine | mkN "dakpan" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin rally_N = variants{} ; -- 
lin economist_N = mkN "econoom" utrum ; -- status=guess
lin vein_N = mkN "ader" masculine ; -- status=guess
lin strand_N = variants{} ; -- 
lin disturbance_N = mkN "storing" feminine | mkN "verstoring" feminine ; -- status=guess status=guess
lin stuff_V2 = mkV2 (mkV "vullen") ; -- status=guess, src=wikt
lin seldom_Adv = mkAdv "zelden" ; -- status=guess
lin coming_A = variants{} ; -- 
lin cab_N = variants{} ; -- 
lin grandfather_N = mkN "grootvader" masculine | mkN "opa" masculine | mkN "bompa" masculine ; -- status=guess status=guess status=guess
lin flash_V = variants{} ; -- 
lin destination_N = mkN "bestemming" ; -- status=guess
lin actively_Adv = variants{} ; -- 
lin regiment_N = variants{} ; -- 
lin closed_A = mkA "gesloten" ; -- status=guess
lin boom_N = mkN "hausse" | mkN "hoogconjunctuur" ; -- status=guess status=guess
lin handful_N = mkN "handvol" neuter ; -- status=guess
lin remarkably_Adv = mkAdv "opmerkelijk" ; -- status=guess
lin encouragement_N = mkN "aanmoediging" feminine | mkN "bemoediging" feminine ; -- status=guess status=guess
lin awkward_A = mkA "onhandig" ; -- status=guess
lin required_A = variants{} ; -- 
lin flood_N = mkN "overstroming" feminine | mkN "vloed" masculine ; -- status=guess status=guess
lin defect_N = variants{} ; -- 
lin surplus_N = mkN "overschot" neuter ; -- status=guess
lin champagne_N = variants{} ; -- 
lin liquid_N = mkN "vloeiklank" masculine ; -- status=guess
lin shed_V2 = mkV2 (mkV "storten") ; -- status=guess, src=wikt
lin welcome_N = mkN "verwelkoming" feminine | mkN "begroeting" feminine | mkN "ontvangst" feminine ; -- status=guess status=guess status=guess
lin rejection_N = variants{} ; -- 
lin discipline_V2 = mkV2 (mkV "disciplineren") | mkV2 (mkV "temmen") ; -- status=guess, src=wikt status=guess, src=wikt
lin halt_V2 = variants{} ; -- 
lin halt_V = variants{} ; -- 
lin electronics_N = mkN "elektronica" masculine ; -- status=guess
lin administratorMasc_N = mkN "beheerder" masculine ; -- status=guess
lin sentence_V2 = mkV2 (mkV "straffen") | mkV2 (mkV (mkV "veroordelen") "tot") ; -- status=guess, src=wikt status=guess, src=wikt
lin sentence_V = mkV "straffen" | mkV (mkV "veroordelen") "tot" ; -- status=guess, src=wikt status=guess, src=wikt
lin ill_Adv = variants{} ; -- 
lin contradiction_N = mkN "contradictie" | mkN "tegenspraak" ; -- status=guess status=guess
lin nail_N = mkN "nagelvijl" masculine feminine ; -- status=guess
lin senior_N = mkN "senior" masculine feminine ; -- status=guess
lin lacking_A = variants{} ; -- 
lin colonial_A = variants{} ; -- 
lin primitive_A = mkA "primitief" ; -- status=guess
lin whoever_NP = variants{} ; -- 
lin lap_N = mkN "schoot" masculine ; -- status=guess
lin commodity_N = variants{} ; -- 
lin planned_A = variants{} ; -- 
lin intellectual_N = variants{} ; -- 
lin imprisonment_N = mkN "gevangenschap" neuter ; -- status=guess
lin coincide_V = mkV "samenvallen" | mkV "coïncideren" ; -- status=guess, src=wikt status=guess, src=wikt
lin sympathetic_A = mkA "sympathiek" ; -- status=guess
lin atom_N = mkN "atoom" neuter ; -- status=guess
lin tempt_V2V = mkV2V (mkV "lokken") | mkV2V (mkV "verlokken") ; -- status=guess, src=wikt status=guess, src=wikt
lin tempt_V2 = mkV2 (mkV "lokken") | mkV2 (mkV "verlokken") ; -- status=guess, src=wikt status=guess, src=wikt
lin sanction_N = variants{} ; -- 
lin praise_V2 = mkV2 (mkV "loven") | mkV2 (prijzen_V) | mkV2 (mkV "eren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin favourable_A = variants{} ; -- 
lin dissolve_V2 = mkV2 (mkV "oplossen") ; -- status=guess, src=wikt
lin dissolve_V = mkV "oplossen" ; -- status=guess, src=wikt
lin tightly_Adv = variants{} ; -- 
lin surrounding_N = variants{} ; -- 
lin soup_N = mkN "soep" feminine ; -- status=guess
lin encounter_N = mkN "botsing" | mkN "confrontatie" | mkN "treffen" neuter ; -- status=guess status=guess status=guess
lin abortion_N = mkN "abortie" masculine | mkN "abortus" masculine ; -- status=guess status=guess
lin grasp_V2 = mkV2 (grijpen_V) | mkV2 (mkV "vastpakken") ; -- status=guess, src=wikt status=guess, src=wikt
lin grasp_V = grijpen_V | mkV "vastpakken" ; -- status=guess, src=wikt status=guess, src=wikt
lin custody_N = variants{} ; -- 
lin composer_N = mkN "bedarer" masculine ; -- status=guess
lin charm_N = mkN "charme" ; -- status=guess
lin short_term_A = variants{} ; -- 
lin metropolitan_A = variants{} ; -- 
lin waist_N = mkN "middel" neuter ; -- status=guess
lin equality_N = mkN "gelijkberechtiging" ; -- status=guess
lin tribute_N = mkN "afdracht" feminine ; -- status=guess
lin bearing_N = mkN "lager" ; -- status=guess
lin auction_N = mkN "veiling" feminine ; -- status=guess
lin standing_N = mkN "domiciliëring" feminine ; -- status=guess
lin manufacture_N = variants{} ; -- 
lin horn_N = L.horn_N ;
lin barn_N = mkN "kerkuil" masculine ; -- status=guess
lin mayor_N = mkN "burgemeester" masculine ; -- status=guess
lin emperor_N = mkN "keizer" masculine ; -- status=guess
lin rescue_N = mkN "redding" ; -- status=guess
lin integrated_A = variants{} ; -- 
lin conscience_N = mkN "geweten" neuter ; -- status=guess
lin commence_V2 = mkV2 (mkV "aanvangen") ; -- status=guess, src=wikt
lin commence_V = mkV "aanvangen" ; -- status=guess, src=wikt
lin grandmother_N = mkN "grootmoeder" | mkN "oma" ; -- status=guess status=guess
lin discharge_V2 = mkV2 (mkV "voltooien") ; -- status=guess, src=wikt
lin discharge_V = mkV "voltooien" ; -- status=guess, src=wikt
lin profound_A = mkA "diepgaand" ; -- status=guess
lin takeover_N = variants{} ; -- 
lin nationalist_N = mkN "nationalist" masculine feminine ; -- status=guess
lin effect_V2 = mkV2 (mkV "bewerkstelligen") ; -- status=guess, src=wikt
lin dolphin_N = mkN "dolfijn" masculine ; -- status=guess
lin fortnight_N = variants{} ; -- 
lin elephant_N = mkN "olifant" masculine | mkN "elpendier" neuter | mkN "elp" masculine ; -- status=guess status=guess status=guess
lin seal_N = mkN "zegel" ; -- status=guess
lin spoil_V2 = mkV2 (bederven_V) ; -- status=guess, src=wikt
lin spoil_V = bederven_V ; -- status=guess, src=wikt
lin plea_N = mkN "pleidooi" neuter | mkN "smeekbede" feminine ; -- status=guess status=guess
lin forwards_Adv = mkAdv "voorwaarts" ; -- status=guess
lin breeze_N = mkN "kinderspel" neuter | mkN "eitje" ; -- status=guess status=guess
lin prevention_N = variants{} ; -- 
lin mineral_N = mkN "mineraal" neuter ; -- status=guess
lin runner_N = mkN "renner" ; -- status=guess
lin pin_V2 = variants{} ; -- 
lin integrity_N = variants{} ; -- 
lin thereafter_Adv = mkAdv "daarna" ; -- status=guess
lin quid_N = variants{} ; -- 
lin owl_N = mkN "uil" masculine ; -- status=guess
lin rigid_A = mkA "stevig" | mkA "stabiel" ; -- status=guess status=guess
lin orange_A = mkA "oranje" | mkA "brandgeel" | mkA "geelrood" ; -- status=guess status=guess status=guess
lin draft_V2 = mkV2 (mkV "oproepen") | mkV2 (mkV "ronselen") ; -- status=guess, src=wikt status=guess, src=wikt
lin reportedly_Adv = variants{} ; -- 
lin hedge_N = mkN "haag" masculine ; -- status=guess
lin formulate_V2 = mkV2 (mkV "verwoorden") | mkV2 (mkV "formuleren") ; -- status=guess, src=wikt status=guess, src=wikt
lin associated_A = variants{} ; -- 
lin position_V2 = variants{} ; -- 
lin thief_N = mkN "dief" masculine | mkN "dievegge" feminine ; -- status=guess status=guess
lin tomato_N = mkN "tomaat" feminine ; -- status=guess
lin exhaust_V2 = mkV2 (mkV "uitputten") | mkV2 (mkV "verminderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin evidently_Adv = mkAdv "duidelijk" | mkAdv "klaarblijkelijk" ; -- status=guess status=guess
lin eagle_N = mkN "arend" | mkN "adelaar" ; -- status=guess status=guess
lin specified_A = variants{} ; -- 
lin resulting_A = variants{} ; -- 
lin blade_N = mkN "blad" neuter ; -- status=guess
lin peculiar_A = mkA "karakteristiek" ; -- status=guess
lin killing_N = variants{} ; -- 
lin desktop_N = mkN "desktop" masculine ; -- status=guess
lin bowel_N = mkN "ingewande" ; -- status=guess
lin long_V = mkV "verlangen" ; -- status=guess, src=wikt
lin ugly_A = L.ugly_A ;
lin expedition_N = mkN "expeditie" feminine ; -- status=guess
lin saint_N = mkN "heilige" masculine feminine ; -- status=guess
lin variable_A = mkA "veranderlijk" | mkA "variabel" | mkA "regelbaar" ; -- status=guess status=guess status=guess
lin supplement_V2 = mkV2 (mkV "aanvullen") ; -- status=guess, src=wikt
lin stamp_N = variants{} ; -- 
lin slide_N = mkN "glijbaan" feminine | mkN "schuifaf" feminine ; -- status=guess status=guess
lin faction_N = mkN "fractie" ; -- status=guess
lin enthusiastic_A = mkA "enthousiast" ; -- status=guess
lin enquire_V2 = variants{} ; -- 
lin enquire_V = variants{} ; -- 
lin brass_N = mkN "messing" neuter | mkN "geelkoper" neuter ; -- status=guess status=guess
lin inequality_N = mkN "ongelijkheid" ; -- status=guess
lin eager_A = mkA "begerig" ; -- status=guess
lin bold_A = mkA "moedig" ; -- status=guess
lin neglect_V2 = mkV2 (mkV "verwaarlozen") | mkV2 (mkV "negeren") | mkV2 (mkV (mkV "uit") "het oog verliezen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin saying_N = mkN "gezegde" neuter | mkN "spreekwoord" neuter ; -- status=guess status=guess
lin ridge_N = mkN "heuvelkam" masculine ; -- status=guess
lin earl_N = mkN "graaf" masculine ; -- status=guess
lin yacht_N = mkN "jacht" feminine ; -- status=guess
lin suck_V2 = L.suck_V2 ;
lin suck_V = zuigen_V ; -- status=guess, src=wikt
lin missing_A = variants{} ; -- 
lin extended_A = variants{} ; -- 
lin valuation_N = variants{} ; -- 
lin delight_V2 = mkV2 (mkV "bevallen") | mkV2 (mkV "behagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin delight_V = mkV "bevallen" | mkV "behagen" ; -- status=guess, src=wikt status=guess, src=wikt
lin beat_N = mkN "zweving" feminine ; -- status=guess
lin worship_N = variants{} ; -- 
lin fossil_N = mkN "fossiel" neuter ; -- status=guess
lin diminish_V2 = mkV2 (mkV "afnemen") | mkV2 (mkV "verkleinen") ; -- status=guess, src=wikt status=guess, src=wikt
lin diminish_V = mkV "afnemen" | mkV "verkleinen" ; -- status=guess, src=wikt status=guess, src=wikt
lin taxpayer_N = variants{} ; -- 
lin corruption_N = mkN "corruptie" feminine ; -- status=guess
lin accurately_Adv = mkAdv "trefzeker" ; -- status=guess
lin honour_V2 = mkV2 (mkV "eren") | mkV2 (mkV "huldigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin depict_V2 = variants{} ; -- 
lin pencil_N = mkN "potlood" neuter ; -- status=guess
lin drown_V2 = mkV2 (mkV "overstemmen") ; -- status=guess, src=wikt
lin drown_V = mkV "overstemmen" ; -- status=guess, src=wikt
lin stem_N = mkN "stam" masculine | mkN "stengel" masculine | mkN "steel" masculine ; -- status=guess status=guess status=guess
lin lump_N = mkN "klont" ; -- status=guess
lin applicable_A = mkA "toepasselijk" ; -- status=guess
lin rate_V2 = variants{} ; -- 
lin rate_V = variants{} ; -- 
lin mobility_N = variants{} ; -- 
lin immense_A = mkA "immens" ; -- status=guess
lin goodness_N = mkN "goedheid" feminine ; -- status=guess
lin price_V2V = mkV2V (mkV "schatten") | mkV2V (prijzen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V2 = mkV2 (mkV "schatten") | mkV2 (prijzen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V = mkV "schatten" | prijzen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin preliminary_A = mkA "voorbereidend" ; -- status=guess
lin graph_N = mkN "graaf" ; -- status=guess
lin referee_N = mkN "arbiter" ; -- status=guess
lin calm_A = mkA "vredig" | mkA "kalm" ; -- status=guess status=guess
lin onwards_Adv = variants{} ; -- 
lin omit_V2 = mkV2 (mkV "weglaten") ; -- status=guess, src=wikt
lin genuinely_Adv = variants{} ; -- 
lin excite_V2 = mkV2 (mkV "stimuleren") | mkV2 (mkV "prikkelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin dreadful_A = mkA "vervaarlijk" ; -- status=guess
lin cave_N = mkN "hol" neuter | mkN "grot" feminine ; -- status=guess status=guess
lin revelation_N = mkN "revelatie" feminine | mkN "openbaring" feminine ; -- status=guess status=guess
lin grief_N = mkN "harteleed" ; -- status=guess
lin erect_V2 = variants{} ; -- 
lin tuck_V2 = variants{} ; -- 
lin tuck_V = variants{} ; -- 
lin meantime_N = mkN "ondertussen" ; -- status=guess
lin barrel_N = mkN "ton" | mkN "vat" neuter ; -- status=guess status=guess
lin lawn_N = mkN "gazon" neuter | mkN "grasperk" neuter ; -- status=guess status=guess
lin hut_N = mkN "hut" feminine ; -- status=guess
lin swing_N = mkN "schommel" masculine ; -- status=guess
lin subject_V2 = mkV2 (mkV "onderwerpen") ; -- status=guess, src=wikt
lin ruin_V2 = mkV2 (mkV "ruïneren") ; -- status=guess, src=wikt
lin slice_N = mkN "plak" neuter | mkN "schijf" neuter ; -- status=guess status=guess
lin transmit_V2 = mkV2 (mkV "doorgeven") ; -- status=guess, src=wikt
lin thigh_N = mkN "dij" feminine | mkN "bovenbeen" neuter ; -- status=guess status=guess
lin practically_Adv = variants{} ; -- 
lin dedicate_V2 = mkV2 (mkV "opdragen") ; -- status=guess, src=wikt
lin mistake_V2 = mkV2 (mkV (mkV "een") "fout maken") | mkV2 (mkV (mkV "in") "de fout gaan") ; -- status=guess, src=wikt status=guess, src=wikt
lin mistake_V = mkV (mkV "een") "fout maken" | mkV (mkV "in") "de fout gaan" ; -- status=guess, src=wikt status=guess, src=wikt
lin corresponding_A = mkA "corresponderend" | mkA "overeenkomstig" ; -- status=guess status=guess
lin albeit_Subj = variants{} ; -- 
lin sound_A = mkA "degelijk" ; -- status=guess
lin nurse_V2 = mkV2 (mkV "borstvoeden") | mkV2 (mkV "zogen") ; -- status=guess, src=wikt status=guess, src=wikt
lin discharge_N = variants{} ; -- 
lin comparative_A = variants{} ; -- 
lin cluster_N = variants{} ; -- 
lin propose_VV = mkVV propose_V ;
lin propose_VS = mkVS propose_V ;
lin propose_V2 = mkV2 propose_V ;
lin propose_V = mkV "voor" (mkV "stellen") ; ---- should this include proposing for marriage?
lin obstacle_N = mkN "obstakel" neuter ; -- status=guess
lin motorway_N = mkN "snelweg" ; -- status=guess
lin heritage_N = mkN "erfenis" feminine ; -- status=guess
lin counselling_N = variants{} ; -- 
lin breeding_N = variants{} ; -- 
lin characteristic_A = mkA "kenmerkend" | mkA "karakteristiek" | mkA "idiosyncratisch" ; -- status=guess status=guess status=guess
lin bucket_N = mkN "emmer" masculine ; -- status=guess
lin migration_N = variants{} ; -- 
lin campaign_V = variants{} ; -- 
lin ritual_N = mkN "ritueel" neuter ; -- status=guess
lin originate_V2 = mkV2 (mkV "voortkomen") ; -- status=guess, src=wikt
lin originate_V = mkV "voortkomen" ; -- status=guess, src=wikt
lin hunting_N = variants{} ; -- 
lin crude_A = mkA "ruw" | mkA "onbewerkt" | mkA "ongeraffineerd" ; -- status=guess status=guess status=guess
lin protocol_N = variants{} ; -- 
lin prejudice_N = mkN "bevooroordelen" ; -- status=guess
lin inspiration_N = mkN "adem" masculine | mkN "ademhaling" feminine ; -- status=guess status=guess
lin dioxide_N = mkN "dioxide" neuter ; -- status=guess
lin chemical_A = mkA "chemisch" | mkA "scheikundig" ; -- status=guess status=guess
lin uncomfortable_A = mkA "ongemakkelijk" ; -- status=guess
lin worthy_A = mkA "waardig" ; -- status=guess
lin inspect_V2 = variants{} ; -- 
lin summon_V2 = mkV2 (mkV "ontbieden") ; -- status=guess, src=wikt
lin parallel_N = mkN "breedtegraad" masculine ; -- status=guess
lin outlet_N = mkN "stopcontact" neuter ; -- status=guess
lin okay_A = variants{} ; -- 
lin collaboration_N = mkN "samenwerking" feminine | mkN "het samenwerken" ; -- status=guess status=guess
lin booking_N = mkN "boeking" | mkN "reservatie" ; -- status=guess status=guess
lin salad_N = mkN "salade" ; -- status=guess
lin productive_A = variants{} ; -- 
lin charming_A = variants{} ; -- 
lin polish_A = variants{} ; -- 
lin oak_N = mkN "eik" masculine | mkN "eikenboom" masculine ; -- status=guess status=guess
lin access_V2 = mkV2 (mkV (mkV "toegang") "hebben") ; -- status=guess, src=wikt
lin tourism_N = mkN "toerisme" neuter ; -- status=guess
lin independently_Adv = mkAdv "onafhankelijk" ; -- status=guess
lin cruel_A = mkA "wreed" | mkA "wrede" | mkA "gemeen" | mkA "gemene" ; -- status=guess status=guess status=guess status=guess
lin diversity_N = mkN "verscheidenheid" ; -- status=guess
lin accused_A = variants{} ; -- 
lin supplement_N = mkN "aanvulling" feminine | mkN "bijlage" masculine feminine ; -- status=guess status=guess
lin fucking_Adv = variants{} ; -- 
lin forecast_N = mkN "voorspelling" feminine ; -- status=guess
lin amend_V2V = mkV2V (mkV "verbeteren") ; -- status=guess, src=wikt
lin amend_V2 = mkV2 (mkV "verbeteren") ; -- status=guess, src=wikt
lin amend_V = mkV "verbeteren" ; -- status=guess, src=wikt
lin soap_N = mkN "zeep" ; -- status=guess
lin ruling_N = variants{} ; -- 
lin interference_N = mkN "bemoeien" ; -- status=guess
lin executive_A = variants{} ; -- 
lin mining_N = variants{} ; -- 
lin minimal_A = mkA "minimal" ; -- status=guess
lin clarify_V2 = mkV2 (mkV "verduidelijken") ; -- status=guess, src=wikt
lin clarify_V = mkV "verduidelijken" ; -- status=guess, src=wikt
lin strain_V2 = mkV2 (mkV "forceren") ; -- status=guess, src=wikt
lin novel_A = mkA "nieuw" ; -- status=guess
lin try_N = variants{} ; -- 
lin coastal_A = variants{} ; -- 
lin rising_A = variants{} ; -- 
lin quota_N = variants{} ; -- 
lin minus_Prep = variants{} ; -- 
lin kilometre_N = mkN "kilometer" ; -- status=guess
lin characterize_V2 = variants{} ; -- 
lin suspicious_A = mkA "achterdochtig" ; -- status=guess
lin pet_N = mkN "huisdier" ; -- status=guess
lin beneficial_A = mkA "gunstig" ; -- status=guess
lin fling_V2 = mkV2 (smijten_V) ; -- status=guess, src=wikt
lin fling_V = smijten_V ; -- status=guess, src=wikt
lin deprive_V2 = mkV2 (mkV "ontnemen") ; -- status=guess, src=wikt
lin covenant_N = variants{} ; -- 
lin bias_N = mkN "vooroordeel" | mkN "vooringenomenheid" ; -- status=guess status=guess
lin trophy_N = variants{} ; -- 
lin verb_N = mkN "werkwoord" neuter ; -- status=guess
lin honestly_Adv = variants{} ; -- 
lin extract_N = variants{} ; -- 
lin straw_N = mkN "stro" neuter ; -- status=guess
lin stem_V2 = mkV2 (mkV "stoppen") | mkV2 (mkV "hinderen") | mkV2 (mkV "stelpen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin stem_V = mkV "stoppen" | mkV "hinderen" | mkV "stelpen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin eyebrow_N = mkN "wenkbrauw" masculine feminine ; -- status=guess
lin noble_A = mkA "edel" | mkA "adellijk" | mkA "eervol" | mkA "fatsoenlijk" | mkA "nobel" ; -- status=guess status=guess status=guess status=guess status=guess
lin mask_N = variants{} ; -- 
lin lecturer_N = variants{} ; -- 
lin girlfriend_N = mkN "vriendin" ; -- status=guess
lin forehead_N = mkN "voorhoofd" neuter ; -- status=guess
lin timetable_N = variants{} ; -- 
lin symbolic_A = mkA "symbolisch" ; -- status=guess
lin farming_N = variants{} ; -- 
lin lid_N = mkN "deksel" neuter ; -- status=guess
lin librarian_N = mkN "bibliothecaris" masculine ; -- status=guess
lin injection_N = mkN "injectie" | mkN "spuitje" ; -- status=guess status=guess
lin sexuality_N = mkN "sexualiteit" feminine ; -- status=guess
lin irrelevant_A = mkA "irrelevant" ; -- status=guess
lin bonus_N = mkN "bonus" masculine | mkN "premie" ; -- status=guess status=guess
lin abuse_V2 = mkV2 (mkV "mishandelen") ; -- status=guess, src=wikt
lin thumb_N = mkN "duim" masculine ; -- status=guess
lin survey_V2 = mkV2 (mkV "onderzoeken") | mkV2 (mkV "rapporteren") ; -- status=guess, src=wikt status=guess, src=wikt
lin ankle_N = mkN "enkel" masculine ; -- status=guess
lin psychologist_N = mkN "psycholoog" masculine ; -- status=guess
lin occurrence_N = mkN "voorval" masculine ; -- status=guess
lin profitable_A = mkA "winstgevend" ; -- status=guess
lin deliberate_A = mkA "doordacht" | mkA "doordachte" | mkA "weloverwogen" ; -- status=guess status=guess status=guess
lin bow_V2 = mkV2 (buigen_V) ; -- status=guess, src=wikt
lin bow_V = buigen_V ; -- status=guess, src=wikt
lin tribe_N = mkN "stam" masculine ; -- status=guess
lin rightly_Adv = variants{} ; -- 
lin representative_A = mkA "representatief" ; -- status=guess
lin code_V2 = mkV2 (mkV "coderen") ; -- status=guess, src=wikt
lin validity_N = mkN "geldigheid" feminine ; -- status=guess
lin marble_N = mkN "marmer" neuter ; -- status=guess
lin bow_N = mkN "pijl en boog" ; -- status=guess
lin plunge_V2 = variants{} ; -- 
lin plunge_V = variants{} ; -- 
lin maturity_N = mkN "vervaldag" | mkN "betaaldatum" ; -- status=guess status=guess
lin maturity_3_N = variants{} ; -- 
lin maturity_2_N = variants{} ; -- 
lin maturity_1_N = variants{} ; -- 
lin hidden_A = mkA "verborgen" ; -- status=guess
lin contrast_V2 = variants{} ; -- 
lin contrast_V = variants{} ; -- 
lin tobacco_N = mkN "tabaksplant" ; -- status=guess
lin middle_class_A = variants{} ; -- 
lin grip_V2 = mkV2 (grijpen_V) ; -- status=guess, src=wikt
lin clergy_N = variants{} ; -- 
lin trading_A = variants{} ; -- 
lin passive_A = mkA "passief" ; -- status=guess
lin decoration_N = mkN "versieren" neuter | mkN "decoratie" feminine ; -- status=guess status=guess
lin racial_A = variants{} ; -- 
lin well_N = mkN "bron" feminine | mkN "put" masculine ; -- status=guess status=guess
lin embarrassment_N = mkN "verlegenheid" feminine ; -- status=guess
lin sauce_N = mkN "onbeleefde opmerkingen" ; -- status=guess
lin fatal_A = mkA "fataal" | mkA "fatale" ; -- status=guess status=guess
lin banker_N = mkN "bankier" masculine ; -- status=guess
lin compensate_V2 = mkV2 (mkV "compenseren") ; -- status=guess, src=wikt
lin compensate_V = mkV "compenseren" ; -- status=guess, src=wikt
lin make_up_N = variants{} ; -- 
lin popularity_N = variants{} ; -- 
lin interior_A = variants{} ; -- 
lin eligible_A = variants{} ; -- 
lin continuity_N = mkN "continuïteit" feminine ; -- status=guess
lin bunch_N = mkN "tros" masculine | mkN "bos" masculine ; -- status=guess status=guess
lin hook_N = mkN "haak" ; -- status=guess
lin wicket_N = variants{} ; -- 
lin pronounce_V2 = mkV2 (reflMkV "uitspreken") ; -- status=guess, src=wikt
lin pronounce_V = reflMkV "uitspreken" ; -- status=guess, src=wikt
lin ballet_N = mkN "ballet" ; -- status=guess
lin heir_N = mkN "opvolger" ; -- status=guess
lin positively_Adv = variants{} ; -- 
lin insufficient_A = variants{} ; -- 
lin substitute_V2 = mkV2 (mkV "vervangen") | mkV2 (mkV "substitueren") ; -- status=guess, src=wikt status=guess, src=wikt
lin substitute_V = mkV "vervangen" | mkV "substitueren" ; -- status=guess, src=wikt status=guess, src=wikt
lin mysterious_A = mkA "geheimzinnig" ; -- status=guess
lin dancer_N = mkN "exotisch danser" masculine | mkN "karakterdanser" masculine | mkN "stripdanser" masculine ; -- status=guess status=guess status=guess
lin trail_N = mkN "studentenhaver" masculine | mkN "elitehaver" masculine ; -- status=guess status=guess
lin caution_N = mkN "voorzichtigheid" feminine | mkN "voorzorg " masculine | mkN "omzichtigheid" feminine ; -- status=guess status=guess status=guess
lin donation_N = mkN "schenking" feminine ; -- status=guess
lin added_A = variants{} ; -- 
lin weaken_V2 = mkV2 (mkV "verzwakken") ; -- status=guess, src=wikt
lin weaken_V = mkV "verzwakken" ; -- status=guess, src=wikt
lin tyre_N = mkN "band" masculine ; -- status=guess
lin sufferer_N = variants{} ; -- 
lin managerial_A = variants{} ; -- 
lin elaborate_A = mkA "gedetailleerd" | mkA "diepgaand" ; -- status=guess status=guess
lin restraint_N = variants{} ; -- 
lin renew_V2 = mkV2 (mkV "hernieuwen") | mkV2 (mkV "vernieuwen") ; -- status=guess, src=wikt status=guess, src=wikt
lin gardenerMasc_N = mkN "hovenier" masculine | mkN "tuinier" masculine | mkN "tuinman" masculine | mkN "tuinlieden {p}" ; -- status=guess status=guess status=guess status=guess
lin dilemma_N = mkN "dilemma" neuter ; -- status=guess
lin configuration_N = variants{} ; -- 
lin rear_A = mkA "achter" ; -- status=guess
lin embark_V2 = mkV2 (beginnen_V) ; -- status=guess, src=wikt
lin embark_V = beginnen_V ; -- status=guess, src=wikt
lin misery_N = mkN "ellende" feminine ; -- status=guess
lin importantly_Adv = variants{} ; -- 
lin continually_Adv = variants{} ; -- 
lin appreciation_N = variants{} ; -- 
lin radical_N = variants{} ; -- 
lin diverse_A = mkA "divers" ; -- status=guess
lin revive_V2 = mkV2 (mkV (mkV "doen") "herleven") | mkV2 (mkV (mkV "nieuw") "leven inblazen") ; -- status=guess, src=wikt status=guess, src=wikt
lin revive_V = mkV (mkV "doen") "herleven" | mkV (mkV "nieuw") "leven inblazen" ; -- status=guess, src=wikt status=guess, src=wikt
lin trip_V = mkV "struikelen" ; -- status=guess, src=wikt
lin lounge_N = variants{} ; -- 
lin dwelling_N = mkN "woning" ; -- status=guess
lin parental_A = mkA "ouderlijk" ; -- status=guess
lin loyal_A = variants{} ; -- 
lin privatisation_N = variants{} ; -- 
lin outsider_N = variants{} ; -- 
lin forbid_V2 = mkV2 (mkV "verbieden") ; -- status=guess, src=wikt
lin yep_Interj = variants{} ; -- 
lin prospective_A = variants{} ; -- 
lin manuscript_N = mkN "manuscript" neuter | mkN "kopij" feminine ; -- status=guess status=guess
lin inherent_A = mkA "inherent" | mkA "samengaand" ; -- status=guess status=guess
lin deem_V2V = mkV2V (mkV "beschouwen") ; -- status=guess, src=wikt
lin deem_V2A = mkV2A (mkV "beschouwen") ; -- status=guess, src=wikt
lin deem_V2 = mkV2 (mkV "beschouwen") ; -- status=guess, src=wikt
lin telecommunication_N = variants{} ; -- 
lin intermediate_A = variants{} ; -- 
lin worthwhile_A = mkA "de moeite lonend" | mkA "de moeite waard" | mkA "waardevol" ; -- status=guess status=guess status=guess
lin calendar_N = mkN "agenda" masculine | mkN "schema" neuter | mkN "kalender" utrum ; -- status=guess status=guess status=guess
lin basin_N = mkN "stroomgebied" neuter | mkN "bekken" neuter ; -- status=guess status=guess
lin utterly_Adv = variants{} ; -- 
lin rebuild_V2 = mkV2 (mkV "heropbouwen") ; -- status=guess, src=wikt
lin pulse_N = mkN "pols" masculine ; -- status=guess
lin suppress_V2 = mkV2 (mkV "onderdrukken") ; -- status=guess, src=wikt
lin predator_N = mkN "roofdier" neuter ; -- status=guess
lin width_N = mkN "breedte" feminine ; -- status=guess
lin stiff_A = mkA "stevig" ; -- status=guess
lin spine_N = mkN "ruggengraat" ; -- status=guess
lin betray_V2 = mkV2 (mkV "verraden") ; -- status=guess, src=wikt
lin punish_V2 = mkV2 (mkV "straffen") | mkV2 (mkV "afstraffen") | mkV2 (mkV "bestraffen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin stall_N = mkN "cabine" feminine ; -- status=guess
lin lifestyle_N = mkN "levensstijl" masculine ; -- status=guess
lin compile_V2 = mkV2 (mkV "samenstellen") ; -- status=guess, src=wikt
lin arouse_V2V = mkV2V (mkV "opwinden") ; -- status=guess, src=wikt
lin arouse_V2 = mkV2 (mkV "opwinden") ; -- status=guess, src=wikt
lin partially_Adv = mkAdv "gedeeltelijk" | mkAdv "deels" ; -- status=guess status=guess
lin headline_N = mkN "kop" masculine ; -- status=guess
lin divine_A = variants{} ; -- 
lin unpleasant_A = variants{} ; -- 
lin sacred_A = mkA "heilig" | mkA "zalig" | mkA "gezegend" ; -- status=guess status=guess status=guess
lin useless_A = mkA "nutteloos" | mkA "onbruikbaar" ; -- status=guess status=guess
lin cool_V2 = mkV2 (mkV "afkoelen") | mkV2 (mkV "koelen") | mkV2 (mkV "bekoelen") | mkV2 (mkV "verfrissen") | mkV2 (mkV "verkillen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cool_V = mkV "afkoelen" | mkV "koelen" | mkV "bekoelen" | mkV "verfrissen" | mkV "verkillen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin tremble_V = mkV "beven" ; -- status=guess, src=wikt
lin statue_N = mkN "standbeeld" neuter ; -- status=guess
lin obey_V2 = mkV2 (mkV "gehoorzamen") ; -- status=guess, src=wikt
lin obey_V = mkV "gehoorzamen" ; -- status=guess, src=wikt
lin drunk_A = mkA "dronken" | mkA "zat" | mkA "bezopen" | mkA "blauw" | mkA "beschonken" ; -- status=guess status=guess status=guess status=guess status=guess
lin tender_A = mkA "zacht" | mkA "lief" ; -- status=guess status=guess
lin molecular_A = variants{} ; -- 
lin circulate_V2 = variants{} ; -- 
lin circulate_V = variants{} ; -- 
lin exploitation_N = mkN "uitbuiting" feminine | mkN "exploitatie" feminine | mkN "uitbaten" neuter ; -- status=guess status=guess status=guess
lin explicitly_Adv = variants{} ; -- 
lin utterance_N = mkN "uiting" feminine | mkN "taaluiting" feminine ; -- status=guess status=guess
lin linear_A = variants{} ; -- 
lin chat_V = mkV "kletsen" | mkV "babbelen" ; -- status=guess, src=wikt status=guess, src=wikt
lin revision_N = mkN "herziening" ; -- status=guess
lin distress_N = mkN "druk" masculine | mkN "stress" feminine ; -- status=guess status=guess
lin spill_V2 = mkV2 (mkV "morsen") ; -- status=guess, src=wikt
lin spill_V = mkV "morsen" ; -- status=guess, src=wikt
lin steward_N = mkN "steward" ; -- status=guess
lin knight_N = mkN "paard" neuter ; -- status=guess
lin sum_V2 = mkV2 (mkV "optellen") | mkV2 (mkV "bijeentellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin sum_V = mkV "optellen" | mkV "bijeentellen" ; -- status=guess, src=wikt status=guess, src=wikt
lin semantic_A = mkA "semantisch" ; -- status=guess
lin selective_A = variants{} ; -- 
lin learner_N = variants{} ; -- 
lin dignity_N = mkN "plechtigheid" utrum ; -- status=guess
lin senate_N = mkN "senaat" masculine ; -- status=guess
lin grid_N = mkN "net" | mkN "elektriciteitsnet" ; -- status=guess status=guess
lin fiscal_A = mkA "fiscaal" ; -- status=guess
lin activate_V2 = mkV2 (mkV "activeren") ; -- status=guess, src=wikt
lin rival_A = variants{} ; -- 
lin fortunate_A = variants{} ; -- 
lin jeans_N = mkN "jeansbroek" masculine feminine | mkN "jeans" | mkN "spijkerbroek" masculine feminine ; -- status=guess status=guess status=guess
lin select_A = variants{} ; -- 
lin fitting_N = variants{} ; -- 
lin commentator_N = variants{} ; -- 
lin weep_V2 = mkV2 (mkV "huilen") | mkV2 (mkV "wenen") | mkV2 (mkV "schreien") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin weep_V = mkV "huilen" | mkV "wenen" | mkV "schreien" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin handicap_N = mkN "handicap" masculine ; -- status=guess
lin crush_V2 = mkV2 (mkV "verdrukken") ; -- status=guess, src=wikt
lin crush_V = mkV "verdrukken" ; -- status=guess, src=wikt
lin towel_N = mkN "handdoek" masculine ; -- status=guess
lin stay_N = mkN "verblijf" neuter ; -- status=guess
lin skilled_A = mkA "bedreven" ; -- status=guess
lin repeatedly_Adv = mkAdv "herhaaldelijk" | mkAdv "meermaals" | mkAdv "telkens" ; -- status=guess status=guess status=guess
lin defensive_A = variants{} ; -- 
lin calm_V2 = mkV2 (mkV "afkoelen") | mkV2 (mkV "kalmeren") ; -- status=guess, src=wikt status=guess, src=wikt
lin calm_V = mkV "afkoelen" | mkV "kalmeren" ; -- status=guess, src=wikt status=guess, src=wikt
lin temporarily_Adv = mkAdv "tijdelijk" ; -- status=guess
lin rain_V2 = mkV2 (mkV "regenen") ; -- status=guess, src=wikt
lin rain_V = mkV "regenen" ; -- status=guess, src=wikt
lin pin_N = mkN "speldje" neuter ; -- status=guess
lin villa_N = variants{} ; -- 
lin rod_N = mkN "roede" ; -- status=guess
lin frontier_N = mkN "grens" ; -- status=guess
lin enforcement_N = mkN "handhaving" feminine ; -- status=guess
lin protective_A = variants{} ; -- 
lin philosophical_A = mkA "wijsgerig" | mkA "filosofisch" ; -- status=guess status=guess
lin lordship_N = variants{} ; -- 
lin disagree_VS = mkVS (mkV (mkV "niet") "overeenkomen") | mkVS (mkV (mkV "niet") "overeenstemmen") ; -- status=guess, src=wikt status=guess, src=wikt
lin disagree_V2 = mkV2 (mkV (mkV "niet") "overeenkomen") | mkV2 (mkV (mkV "niet") "overeenstemmen") ; -- status=guess, src=wikt status=guess, src=wikt
lin disagree_V = mkV (mkV "niet") "overeenkomen" | mkV (mkV "niet") "overeenstemmen" ; -- status=guess, src=wikt status=guess, src=wikt
lin boyfriend_N = mkN "vriend" masculine | mkN "lief" neuter ; -- status=guess status=guess
lin activistMasc_N = variants{} ; -- 
lin viewer_N = mkN "kijker" masculine ; -- status=guess
lin slim_A = mkA "slank" | mkA "dun" ; -- status=guess status=guess
lin textile_N = mkN "textiel" neuter ; -- status=guess
lin mist_N = mkN "waas" ; -- status=guess
lin harmony_N = mkN "samenklank" masculine | mkN "eendracht" feminine | mkN "overeenstemming" feminine ; -- status=guess status=guess status=guess
lin deed_N = mkN "daad" feminine ; -- status=guess
lin merge_V2 = mkV2 (mkV "samenkomen") | mkV2 (mkV "samenvloeien") | mkV2 (mkV "fusioneren") | mkV2 (mkV "samengaan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin merge_V = mkV "samenkomen" | mkV "samenvloeien" | mkV "fusioneren" | mkV "samengaan" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin invention_N = mkN "uitvinding" feminine ; -- status=guess
lin commissioner_N = mkN "commissaris" masculine ; -- status=guess
lin caravan_N = mkN "karavaan" feminine ; -- status=guess
lin bolt_N = mkN "grendel" masculine ; -- status=guess
lin ending_N = mkN "uitgang" masculine ; -- status=guess
lin publishing_N = variants{} ; -- 
lin gut_N = mkN "buik" masculine ; -- status=guess
lin stamp_V2 = mkV2 (mkV "stampen") ; -- status=guess, src=wikt
lin stamp_V = mkV "stampen" ; -- status=guess, src=wikt
lin map_V2 = variants{} ; -- 
lin loud_Adv = variants{} ; -- 
lin stroke_V2 = mkV2 (mkV "strelen") | mkV2 (strijken_V) | mkV2 (mkV "aaien") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shock_V2 = variants{} ; -- 
lin rug_N = mkN "tapijt" ; -- status=guess
lin picture_V2 = mkV2 (reflMkV "verbeelden") ; -- status=guess, src=wikt
lin slip_N = mkN "slip" masculine ; -- status=guess
lin praise_N = mkN "lof" masculine ; -- status=guess
lin fine_N = mkN "boete" ; -- status=guess
lin monument_N = mkN "monument" neuter ; -- status=guess
lin material_A = mkA "materieel" | mkA "materiële" ; -- status=guess status=guess
lin garment_N = mkN "kledingstuk" neuter ; -- status=guess
lin toward_Prep = variants{} ; -- 
lin realm_N = mkN "domein" ; -- status=guess
lin melt_V2 = mkV2 (smelten_V) ; -- status=guess, src=wikt
lin melt_V = smelten_V ; -- status=guess, src=wikt
lin reproduction_N = variants{} ; -- 
lin reactor_N = mkN "reactor" ; -- status=guess
lin furious_A = variants{} ; -- 
lin distinguished_A = variants{} ; -- 
lin characterize_V2 = variants{} ; -- 
lin alike_Adv = variants{} ; -- 
lin pump_N = mkN "pomp" feminine ; -- status=guess
lin probe_N = mkN "sonde" masculine feminine ; -- status=guess
lin feedback_N = variants{} ; -- 
lin aspiration_N = variants{} ; -- 
lin suspect_N = mkN "verdachte" masculine feminine ; -- status=guess
lin solar_A = variants{} ; -- 
lin fare_N = mkN "zwartrijder" masculine | mkN "blinde passagier" ; -- status=guess status=guess
lin carve_V2 = variants{} ; -- 
lin carve_V = variants{} ; -- 
lin qualified_A = variants{} ; -- 
lin membrane_N = mkN "membraan" neuter ; -- status=guess
lin dependence_N = mkN "verslaving" feminine | mkN "afhankelijkheid" feminine ; -- status=guess status=guess
lin convict_V2 = mkV2 (mkV "veroordelen") ; -- status=guess, src=wikt
lin bacteria_N = mkN "bacteriën" ; -- status=guess
lin trading_N = mkN "handelspost" utrum ; -- status=guess
lin ambassador_N = mkN "ambassadeur" masculine ; -- status=guess
lin wound_V2 = mkV2 (mkV "kwetsen") ; -- status=guess, src=wikt
lin drug_V2 = mkV2 (mkV "drogeren") ; -- status=guess, src=wikt
lin conjunction_N = mkN "voegwoord" neuter ; -- status=guess
lin cabin_N = variants{} ; -- 
lin trail_V2 = variants{} ; -- 
lin trail_V = variants{} ; -- 
lin shaft_N = mkN "schacht" ; -- status=guess
lin treasure_N = mkN "schat" feminine ; -- status=guess
lin inappropriate_A = mkA "ongepast" ; -- status=guess
lin half_Adv = mkAdv "half" ; -- status=guess
lin attribute_N = mkN "attribuut" neuter ; -- status=guess
lin liquid_A = mkA "vloeibaar" ; -- status=guess
lin embassy_N = mkN "ambassade" feminine ; -- status=guess
lin terribly_Adv = variants{} ; -- 
lin exemption_N = mkN "vrijstelling" | mkN "ontheffing" ; -- status=guess status=guess
lin array_N = mkN "array" masculine ; -- status=guess
lin tablet_N = mkN "kleitablet" feminine ; -- status=guess
lin sack_V2 = mkV2 (mkV "plunderen") ; -- status=guess, src=wikt
lin erosion_N = variants{} ; -- 
lin bull_N = mkN "stier" masculine ; -- status=guess
lin warehouse_N = mkN "pakhuis" neuter ; -- status=guess
lin unfortunate_A = variants{} ; -- 
lin promoter_N = variants{} ; -- 
lin compel_VV = mkVV (mkV "bijeendrijven") | mkVV (mkV "samendrijven") ; -- status=guess, src=wikt status=guess, src=wikt
lin compel_V2V = mkV2V (mkV "bijeendrijven") | mkV2V (mkV "samendrijven") ; -- status=guess, src=wikt status=guess, src=wikt
lin compel_V2 = mkV2 (mkV "bijeendrijven") | mkV2 (mkV "samendrijven") ; -- status=guess, src=wikt status=guess, src=wikt
lin motivate_V2V = mkV2V (mkV "motiveren") ; -- status=guess, src=wikt
lin motivate_V2 = mkV2 (mkV "motiveren") ; -- status=guess, src=wikt
lin burning_A = variants{} ; -- 
lin vitamin_N = mkN "vitamine" utrum ; -- status=guess
lin sail_N = mkN "zeil" neuter ; -- status=guess
lin lemon_N = mkN "citroenmelisse" feminine | mkN "citronella" masculine | mkN "bijenkruid" neuter | mkN "vrouwenkruid" neuter ; -- status=guess status=guess status=guess status=guess
lin foreigner_N = mkN "buitenlander" masculine | mkN "buitenlandse" feminine | mkN "vreemdeling" masculine | mkN "vreemdelinge" feminine ; -- status=guess status=guess status=guess status=guess
lin powder_N = mkN "poeder" masculine ; -- status=guess
lin persistent_A = mkA "hardnekkig" ; -- status=guess
lin bat_N = mkN "knuppel" masculine | mkN "slaghout" neuter ; -- status=guess status=guess
lin ancestor_N = mkN "voorloper" masculine ; -- status=guess
lin predominantly_Adv = variants{} ; -- 
lin mathematical_A = mkA "wiskundig" ; -- status=guess
lin compliance_N = variants{} ; -- 
lin arch_N = mkN "boog" masculine ; -- status=guess
lin woodland_N = variants{} ; -- 
lin serum_N = variants{} ; -- 
lin overnight_Adv = mkAdv "van de ene dag op de andere" ; -- status=guess
lin doubtful_A = variants{} ; -- 
lin doing_N = mkN "toedoen" neuter ; -- status=guess
lin coach_V2 = mkV2 (mkV "opleiden") ; -- status=guess, src=wikt
lin coach_V = mkV "opleiden" ; -- status=guess, src=wikt
lin binding_A = variants{} ; -- 
lin surrounding_A = variants{} ; -- 
lin peer_N = mkN "edelman" masculine | mkN "edele" masculine ; -- status=guess status=guess
lin ozone_N = mkN "ozon" ; -- status=guess
lin mid_A = mkA "midden" ; -- status=guess
lin invisible_A = mkA "onzichtbaar" | mkA "onzichtbare" ; -- status=guess status=guess
lin depart_V = mkV "heengaan" ; -- status=guess, src=wikt
lin brigade_N = variants{} ; -- 
lin manipulate_V2 = mkV2 (mkV "manipuleren") | mkV2 (mkV "beïnvloeden") ; -- status=guess, src=wikt status=guess, src=wikt
lin consume_V2 = mkV2 (mkV "verteren") | mkV2 (mkV "consumeren") ; -- status=guess, src=wikt status=guess, src=wikt
lin consume_V = mkV "verteren" | mkV "consumeren" ; -- status=guess, src=wikt status=guess, src=wikt
lin temptation_N = mkN "verleiding" | mkN "verzoeking" | mkN "beproeving" ; -- status=guess status=guess status=guess
lin intact_A = variants{} ; -- 
lin glove_N = L.glove_N ;
lin aggression_N = mkN "agressie" ; -- status=guess
lin emergence_N = mkN "emergentie" feminine ; -- status=guess
lin stag_V = variants{} ; -- 
lin coffin_N = mkN "doodskist" | mkN "kist" feminine ; -- status=guess status=guess
lin beautifully_Adv = variants{} ; -- 
lin clutch_V2 = variants{} ; -- 
lin clutch_V = variants{} ; -- 
lin wit_N = variants{} ; -- 
lin underline_V2 = variants{} ; -- 
lin trainee_N = variants{} ; -- 
lin scrutiny_N = mkN "nauwkeurig onderzoek" | mkN "kritisch onderzoek" ; -- status=guess status=guess
lin neatly_Adv = variants{} ; -- 
lin follower_N = mkN "imitator" masculine | mkN "navolger" masculine ; -- status=guess status=guess
lin sterling_A = variants{} ; -- 
lin tariff_N = mkN "tarief" neuter ; -- status=guess
lin bee_N = mkN "bij" feminine | mkN "honingbij" feminine | mkN "imme" feminine ; -- status=guess status=guess status=guess
lin relaxation_N = variants{} ; -- 
lin negligence_N = mkN "nalatigheid" feminine | mkN "achteloosheid" feminine ; -- status=guess status=guess
lin sunlight_N = mkN "zonlicht" ; -- status=guess
lin penetrate_V2 = mkV2 (mkV "penetreren") ; -- status=guess, src=wikt
lin penetrate_V = mkV "penetreren" ; -- status=guess, src=wikt
lin knot_N = mkN "de knoop" masculine | mkN "knoei" ; -- status=guess status=guess
lin temper_N = mkN "uitharden" ; -- status=guess
lin skull_N = mkN "schedel" masculine | mkN "doodshoofd" neuter | mkN "doodskop" masculine | mkN "cranium" neuter ; -- status=guess status=guess status=guess status=guess
lin openly_Adv = variants{} ; -- 
lin grind_V2 = mkV2 (malen_V) | mkV2 (mkV "vermalen") | mkV2 (mkV "verpulveren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grind_V = malen_V | mkV "vermalen" | mkV "verpulveren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin whale_N = mkN "walvis" masculine ; -- status=guess
lin throne_N = mkN "gemak" neuter ; -- status=guess
lin supervise_V2 = variants{} ; -- 
lin supervise_V = variants{} ; -- 
lin sickness_N = mkN "ziekte de" ; -- status=guess
lin package_V2 = variants{} ; -- 
lin intake_N = variants{} ; -- 
lin within_Adv = variants{}; -- mkPrep "binnenin" | mkPrep "in" | mkPrep "binnen";
lin inland_A = variants{} ; -- 
lin beast_N = mkN "beest" neuter | mkN "wild dier" | mkN "dier" neuter ; -- status=guess status=guess status=guess
lin rear_N = mkN "achterste" neuter | mkN "achterkant" masculine ; -- status=guess status=guess
lin morality_N = mkN "ethiek" ; -- status=guess
lin competent_A = mkA "bekwaam" | mkA "bevoegd" | mkA "capabel" | mkA "competent" ; -- status=guess status=guess status=guess status=guess
lin sink_N = mkN "gootsteen" masculine | mkN "afwasbak" masculine ; -- status=guess status=guess
lin uniform_A = mkA "uniform" | mkA "consistent" ; -- status=guess status=guess
lin reminder_N = mkN "geheugensteuntje" neuter ; -- status=guess
lin permanently_Adv = variants{} ; -- 
lin optimistic_A = mkA "optimistisch" ; -- status=guess
lin bargain_N = variants{} ; -- 
lin seemingly_Adv = variants{} ; -- 
lin respective_A = variants{} ; -- 
lin horizontal_A = mkA "horizontaal" ; -- status=guess
lin decisive_A = mkA "beslissend" | mkA "afdoend" | mkA "doorslaggevend" ; -- status=guess status=guess status=guess
lin bless_V2 = mkV2 (mkV "zegenen") ; -- status=guess, src=wikt
lin bile_N = mkN "gal" masculine feminine ; -- status=guess
lin spatial_A = mkA "ruimtelijk" ; -- status=guess
lin bullet_N = mkN "kogel" masculine ; -- status=guess
lin respectable_A = variants{} ; -- 
lin overseas_Adv = mkAdv "Buitenlands" ; -- status=guess
lin convincing_A = variants{} ; -- 
lin unacceptable_A = mkA "onaanvaardbaar" ; -- status=guess
lin confrontation_N = mkN "confrontatie" feminine ; -- status=guess
lin swiftly_Adv = variants{} ; -- 
lin paid_A = variants{} ; -- 
lin joke_V = mkV "grappen" | mkV "grappenmaken" ; -- status=guess, src=wikt status=guess, src=wikt
lin instant_A = mkA "onmiddelijk" | mkA "ogenblikkelijk" ; -- status=guess status=guess
lin illusion_N = mkN "illusie" feminine | mkN "zinsbegoocheling" feminine ; -- status=guess status=guess
lin cheer_V2 = variants{} ; -- 
lin cheer_V = variants{} ; -- 
lin congregation_N = mkN "congregatie" | mkN "bijeenkomst" | mkN "menigte" | mkN "samenscholing" | mkN "vergadering" ; -- status=guess status=guess status=guess status=guess status=guess
lin worldwide_Adv = mkAdv "wereldwijd" | mkAdv "over de hele wereld" ; -- status=guess status=guess
lin winning_A = variants{} ; -- 
lin wake_N = mkN "kielzog" neuter ; -- status=guess
lin toss_V2 = mkV2 (mkV "woelen") ; -- status=guess, src=wikt
lin toss_V = mkV "woelen" ; -- status=guess, src=wikt
lin medium_A = variants{} ; -- 
lin jewellery_N = variants{} ; -- 
lin fond_A = variants{} ; -- 
lin alarm_V2 = mkV2 (mkV (mkV "te") "wapen roepen") ; -- status=guess, src=wikt
lin guerrilla_N = variants{} ; -- 
lin dive_V = duiken_V | mkV (mkV "een") "duikvlucht maken" ; -- status=guess, src=wikt status=guess, src=wikt
lin desire_V2 = variants{} ; -- 
lin cooperation_N = mkN "samenwerking" feminine ; -- status=guess
lin thread_N = mkN "onderwerp" neuter | mkN "rode draad" masculine ; -- status=guess status=guess
lin prescribe_V2 = variants{} ; -- 
lin prescribe_V = variants{} ; -- 
lin calcium_N = mkN "calcium" neuter ; -- status=guess
lin redundant_A = mkA "overbodig" | mkA "overtollig" | mkA "achterhaald" ; -- status=guess status=guess status=guess
lin marker_N = mkN "fiche" masculine ; -- status=guess
lin chemistMasc_N = mkN "scheikundige" masculine feminine | mkN "chemicus" masculine ; -- status=guess status=guess
lin mammal_N = mkN "zoogdier" neuter ; -- status=guess
lin legacy_N = mkN "erfgoed" | mkN "erfenis" ; -- status=guess status=guess
lin debtor_N = mkN "debiteur" ; -- status=guess
lin testament_N = mkN "testament" neuter ; -- status=guess
lin tragic_A = mkA "tragisch" ; -- status=guess
lin silver_A = mkA "zilveren" ; -- status=guess
lin grin_N = mkN "grijns" masculine feminine ; -- status=guess
lin spectacle_N = mkN "spektakel" neuter ; -- status=guess
lin inheritance_N = mkN "erfbelasting" utrum ; -- status=guess
lin heal_V2 = mkV2 (genezen_V) | mkV2 (mkV "helen") | mkV2 (mkV (mkV "beter") "maken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin heal_V = genezen_V | mkV "helen" | mkV (mkV "beter") "maken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sovereignty_N = mkN "soevereiniteit" feminine ; -- status=guess
lin enzyme_N = variants{} ; -- 
lin host_V2 = mkV2 (mkV "hosten") ; -- status=guess, src=wikt
lin neighbouring_A = mkA "naburig" | mkA "naburige" | mkA "aanpalend" | mkA "aanpalende" | mkA "buur-" ; -- status=guess status=guess status=guess status=guess status=guess
lin corn_N = mkN "veldsla" ; -- status=guess
lin layout_N = mkN "indelen" neuter ; -- status=guess
lin dictate_VS = variants{} ; -- 
lin dictate_V2 = variants{} ; -- 
lin dictate_V = variants{} ; -- 
lin rip_V2 = mkV2 (mkV "scheuren") ; -- status=guess, src=wikt
lin rip_V = mkV "scheuren" ; -- status=guess, src=wikt
lin regain_V2 = mkV2 (mkV "herkrijgen") ; -- status=guess, src=wikt
lin probable_A = mkA "waarschijnlijk" ; -- status=guess
lin inclusion_N = mkN "insluiting" feminine ; -- status=guess
lin booklet_N = mkN "boekje" neuter | mkN "pamflet" neuter ; -- status=guess status=guess
lin bar_V2 = mkV2 (mkV "blokkeren") | mkV2 (mkV "barreren") | mkV2 (mkV "vergrendelen") | mkV2 (mkV "versperren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin privately_Adv = variants{} ; -- 
lin laser_N = mkN "laser" ; -- status=guess
lin fame_N = mkN "bekendheid" feminine ; -- status=guess
lin bronze_N = mkN "brons" neuter ; -- status=guess
lin mobile_A = mkA "beweeglijk" | mkA "mobiel" ; -- status=guess status=guess
lin metaphor_N = mkN "metafoor" masculine ; -- status=guess
lin complication_N = variants{} ; -- 
lin narrow_V2 = variants{} ; -- 
lin narrow_V = variants{} ; -- 
lin old_fashioned_A = variants{} ; -- 
lin chop_V2 = variants{} ; -- 
lin chop_V = variants{} ; -- 
lin synthesis_N = variants{} ; -- 
lin diameter_N = mkN "diameter" masculine | mkN "doorsnede" masculine feminine ; -- status=guess status=guess
lin bomb_V2 = mkV2 (mkV "bombarderen") ; -- status=guess, src=wikt
lin bomb_V = mkV "bombarderen" ; -- status=guess, src=wikt
lin silently_Adv = mkAdv "stilletjes" ; -- status=guess
lin shed_N = mkN "loods" | mkN "schuur" ; -- status=guess status=guess
lin fusion_N = mkN "smelten" neuter ; -- status=guess
lin trigger_V2 = mkV2 (mkV "afvuren") | mkV2 (mkV "vuren") ; -- status=guess, src=wikt status=guess, src=wikt
lin printing_N = variants{} ; -- 
lin onion_N = mkN "ui" masculine | mkN "ajuin" masculine ; -- status=guess status=guess
lin dislike_V2 = mkV2 (mkV (mkV "een") "hekel hebben aan") | mkV2 (mkV (mkV "het") "land hebben aan") ; -- status=guess, src=wikt status=guess, src=wikt
lin embody_V2 = variants{} ; -- 
lin curl_V = variants{} ; -- 
lin sunshine_N = mkN "zonneschijn" masculine ; -- status=guess
lin sponsorship_N = variants{} ; -- 
lin rage_N = mkN "furie" feminine | mkN "razernij" | mkN "toorn" ; -- status=guess status=guess status=guess
lin loop_N = mkN "lus" utrum | mkN "herhaling" feminine | mkN "repetitie" feminine ; -- status=guess status=guess status=guess
lin halt_N = variants{} ; -- 
lin cop_V2 = variants{} ; -- 
lin bang_V2 = variants{} ; -- 
lin bang_V = variants{} ; -- 
lin toxic_A = mkA "giftig" ; -- status=guess
lin thinking_A = variants{} ; -- 
lin orientation_N = mkN "oriënteringsvermogen" ; -- status=guess
lin likelihood_N = mkN "waarschijnlijkheid" ; -- status=guess
lin wee_A = mkA "klein" | mkA "petieterig" | mkA "pietepeuterig" ; -- status=guess status=guess status=guess
lin up_to_date_A = variants{} ; -- 
lin polite_A = mkA "beleefd" ; -- status=guess
lin apology_N = mkN "verontschuldiging" feminine ; -- status=guess
lin exile_N = mkN "banneling" masculine ; -- status=guess
lin brow_N = mkN "wenkbrauw" utrum ; -- status=guess
lin miserable_A = variants{} ; -- 
lin outbreak_N = mkN "uitbarsting" | mkN "explosie" ; -- status=guess status=guess
lin comparatively_Adv = mkAdv "relatief" | mkAdv "betrekkelijk" ; -- status=guess status=guess
lin pump_V2 = mkV2 (mkV "pompen") ; -- status=guess, src=wikt
lin pump_V = mkV "pompen" ; -- status=guess, src=wikt
lin fuck_V2 = mkV2 (mkV "aankloten") ; -- status=guess, src=wikt
lin fuck_V = mkV "aankloten" ; -- status=guess, src=wikt
lin forecast_VS = mkVS (mkV "voorspellen") ; -- status=guess, src=wikt
lin forecast_V2 = mkV2 (mkV "voorspellen") ; -- status=guess, src=wikt
lin forecast_V = mkV "voorspellen" ; -- status=guess, src=wikt
lin timing_N = variants{} ; -- 
lin headmaster_N = variants{} ; -- 
lin terrify_V2 = variants{} ; -- 
lin sigh_N = mkN "zucht" masculine ; -- status=guess
lin premier_A = variants{} ; -- 
lin joint_N = mkN "zaak" ; -- status=guess
lin incredible_A = mkA "ongelofelijk" ; -- status=guess
lin gravity_N = mkN "zwaartekracht" feminine ; -- status=guess
lin regulatory_A = variants{} ; -- 
lin cylinder_N = mkN "cilinder" masculine ; -- status=guess
lin curiosity_N = mkN "nieuwsgierigheid" ; -- status=guess
lin resident_A = variants{} ; -- 
lin narrative_N = mkN "verhaal" neuter | mkN "vertelling" feminine | mkN "verslag" neuter ; -- status=guess status=guess status=guess
lin cognitive_A = mkA "cognitief" ; -- status=guess
lin lengthy_A = variants{} ; -- 
lin gothic_A = variants{} ; -- 
lin dip_V2 = variants{} ; -- 
lin dip_V = variants{} ; -- 
lin adverse_A = variants{} ; -- 
lin accountability_N = mkN "verantwoordelijkheid" neuter ; -- status=guess
lin hydrogen_N = mkN "waterstof" neuter ; -- status=guess
lin gravel_N = variants{} ; -- 
lin willingness_N = variants{} ; -- 
lin inhibit_V2 = mkV2 (mkV "remmen") ; -- status=guess, src=wikt
lin attain_V2 = mkV2 (mkV "bereiken") | mkV2 (mkV "realiseren") ; -- status=guess, src=wikt status=guess, src=wikt
lin attain_V = mkV "bereiken" | mkV "realiseren" ; -- status=guess, src=wikt status=guess, src=wikt
lin specialize_V2 = variants{} ; -- 
lin specialize_V = variants{} ; -- 
lin steer_V2 = mkV2 (mkV "besturen") ; -- status=guess, src=wikt
lin steer_V = mkV "besturen" ; -- status=guess, src=wikt
lin selected_A = variants{} ; -- 
lin like_N = mkN "evenknie" masculine | mkN "dat soort dingen {p}" | mkN "gelijkaardige dingen {p}" | mkN "gelijkaardigheden {p}" ; -- status=guess status=guess status=guess status=guess
lin confer_V = mkV "overleggen" | mkV "consulteren" ; -- status=guess, src=wikt status=guess, src=wikt
lin usage_N = mkN "gebruik" ; -- status=guess
lin portray_V2 = variants{} ; -- 
lin planner_N = variants{} ; -- 
lin manual_A = mkA "handmatig" | mkA "met de hand" | mkA "manueel" ; -- status=guess status=guess status=guess
lin boast_VS = mkVS (reflMkV "bogen") ; -- status=guess, src=wikt
lin boast_V2 = mkV2 (reflMkV "bogen") ; -- status=guess, src=wikt
lin boast_V = reflMkV "bogen" ; -- status=guess, src=wikt
lin unconscious_A = mkA "bewusteloos" ; -- status=guess
lin jail_N = variants{} ; -- 
lin fertility_N = mkN "vruchtbaarheid" ; -- status=guess
lin documentation_N = mkN "documentatie" utrum ; -- status=guess
lin wolf_N = mkN "wolf" masculine ; -- status=guess
lin patent_N = mkN "patent" neuter | mkN "octrooi" neuter ; -- status=guess status=guess
lin exit_N = mkN "uitgang" masculine ; -- status=guess
lin corps_N = variants{} ; -- 
lin proclaim_VS = mkVS (mkV "uitroepen") ; -- status=guess, src=wikt
lin proclaim_V2 = mkV2 (mkV "uitroepen") ; -- status=guess, src=wikt
lin multiply_V2 = mkV2 (mkV "vermenigvuldigen") ; -- status=guess, src=wikt
lin multiply_V = mkV "vermenigvuldigen" ; -- status=guess, src=wikt
lin brochure_N = mkN "brochure" ; -- status=guess
lin screen_V2 = variants{} ; -- 
lin screen_V = variants{} ; -- 
lin orthodox_A = mkA "orthodox" ; -- status=guess
lin locomotive_N = mkN "locomotief" | mkN "lokomotief" ; -- status=guess status=guess
lin considering_Prep = variants{} ; -- 
lin unaware_A = variants{} ; -- 
lin syndrome_N = mkN "syndroom" neuter ; -- status=guess
lin reform_V2 = variants{} ; -- 
lin reform_V = variants{} ; -- 
lin confirmation_N = mkN "vormsel" ; -- status=guess
lin printed_A = variants{} ; -- 
lin curve_V2 = mkV2 (mkV "krommen") | mkV2 (mkV "plooien") | mkV2 (buigen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin curve_V = mkV "krommen" | mkV "plooien" | buigen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin costly_A = variants{} ; -- 
lin underground_A = mkA "ondergronds" ; -- status=guess
lin territorial_A = mkA "territoriaal" ; -- status=guess
lin designate_VS = variants{} ; -- 
lin designate_V2V = variants{} ; -- 
lin designate_V2 = variants{} ; -- 
lin designate_V = variants{} ; -- 
lin comfort_V2 = mkV2 (mkV (mkV "comfort") "verschaffen") | mkV2 (mkV (mkV "het") "gemakkelijk maken") ; -- status=guess, src=wikt status=guess, src=wikt
lin plot_V2 = mkV2 (mkV "plotten") ; -- status=guess, src=wikt
lin plot_V = mkV "plotten" ; -- status=guess, src=wikt
lin misleading_A = mkA "misleidend" ; -- status=guess
lin weave_V2 = mkV2 (weven_V) ; -- status=guess, src=wikt
lin weave_V = weven_V ; -- status=guess, src=wikt
lin scratch_V2 = L.scratch_V2 ;
lin scratch_V = mkV "krassen" | mkV "krabben" ; -- status=guess, src=wikt status=guess, src=wikt
lin echo_N = mkN "echo" masculine ; -- status=guess
lin ideally_Adv = variants{} ; -- 
lin endure_V2 = mkV2 (mkV "voortduren") ; -- status=guess, src=wikt
lin endure_V = mkV "voortduren" ; -- status=guess, src=wikt
lin verbal_A = mkA "werkwoordelijk" ; -- status=guess
lin stride_V = mkV "schrijden" ; -- status=guess, src=wikt
lin nursing_N = mkN "verpleging" feminine ; -- status=guess
lin exert_V2 = mkV2 (mkV "uitoefenen") ; -- status=guess, src=wikt
lin compatible_A = mkA "verenigbaar" ; -- status=guess
lin causal_A = variants{} ; -- 
lin mosaic_N = mkN "mozaïek" ; -- status=guess
lin manor_N = variants{} ; -- 
lin implicit_A = mkA "impliciet" ; -- status=guess
lin following_Prep = variants{} ; -- 
lin fashionable_A = mkA "modieus" ; -- status=guess
lin valve_N = variants{} ; -- 
lin proceed_N = variants{} ; -- 
lin sofa_N = mkN "bank in Holland" | mkN "zetel" masculine | mkN "sofa" masculine ; -- status=guess status=guess status=guess
lin snatch_V2 = mkV2 (mkV "afpakken") | mkV2 (mkV "wegpikken") | mkV2 (mkV "graaien") | mkV2 (mkV "weggraaien") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin snatch_V = mkV "afpakken" | mkV "wegpikken" | mkV "graaien" | mkV "weggraaien" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin jazz_N = mkN "jazz" masculine ; -- status=guess
lin patron_N = mkN "bouwheer" masculine | mkN "eigenaar" masculine | mkN "bevorderaar" masculine ; -- status=guess status=guess status=guess
lin provider_N = mkN "verlener" masculine ; -- status=guess
lin interim_A = mkA "tussentijds" ; -- status=guess
lin intent_N = variants{} ; -- 
lin chosen_A = variants{} ; -- 
lin applied_A = mkA "aangewend" ; -- status=guess
lin shiver_V = mkV "rillen" | mkV "bibberen" ; -- status=guess, src=wikt status=guess, src=wikt
lin pie_N = mkN "taart" feminine | mkN "pastei" feminine ; -- status=guess status=guess
lin fury_N = mkN "razernij" feminine ; -- status=guess
lin abolition_N = variants{} ; -- 
lin soccer_N = mkN "voetbal" neuter ; -- status=guess
lin corpse_N = mkN "lijk" neuter ; -- status=guess
lin accusation_N = variants{} ; -- 
lin kind_A = mkA "aardig" | mkA "leuk" | mkA "lief" | mkA "mooi" | mkA "prettig" ; -- status=guess status=guess status=guess status=guess status=guess
lin dead_Adv = mkAdv "bloed-" | mkAdv "oer-" | mkAdv "dood-" | mkAdv "Ze is bloedmooi" | mkAdv "Hij is oerdom" | mkAdv "Ik ben doodmoe" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin nursing_A = variants{} ; -- 
lin contempt_N = mkN "minachting" feminine ; -- status=guess
lin prevail_V = mkV "overheersen" ; -- status=guess, src=wikt
lin murderer_N = mkN "moordenaar" masculine ; -- status=guess
lin liberal_N = variants{} ; -- 
lin gathering_N = mkN "katern" ; -- status=guess
lin adequately_Adv = variants{} ; -- 
lin subjective_A = mkA "subjectief" ; -- status=guess
lin disagreement_N = mkN "niet in overeenstemming" ; -- status=guess
lin cleaner_N = variants{} ; -- 
lin boil_V2 = mkV2 (mkV "koken") ; -- status=guess, src=wikt
lin boil_V = mkV "koken" ; -- status=guess, src=wikt
lin static_A = variants{} ; -- 
lin scent_N = mkN "geur" masculine | mkN "reuk" feminine ; -- status=guess status=guess
lin civilian_N = mkN "burger" masculine ; -- status=guess
lin monk_N = mkN "monnik" ; -- status=guess
lin abruptly_Adv = mkAdv "abrupt" | mkAdv "bruusk" ; -- status=guess status=guess
lin keyboard_N = mkN "klavier" neuter | mkN "keyboard" neuter ; -- status=guess status=guess
lin hammer_N = mkN "hamer en sikkel" ; -- status=guess
lin despair_N = variants{} ; -- 
lin controller_N = variants{} ; -- 
lin yell_V2 = mkV2 (mkV "schreeuwen") ; -- status=guess, src=wikt
lin yell_V = mkV "schreeuwen" ; -- status=guess, src=wikt
lin entail_V2 = variants{} ; -- 
lin cheerful_A = variants{} ; -- 
lin reconstruction_N = mkN "wederopbouw" masculine ; -- status=guess
lin patience_N = mkN "geduld" neuter ; -- status=guess
lin legally_Adv = variants{} ; -- 
lin habitat_N = mkN "woonplaats" masculine feminine | mkN "habitat" neuter ; -- status=guess status=guess
lin queue_N = mkN "rij" ; -- status=guess
lin spectatorMasc_N = mkN "toeschouwer" masculine ; -- status=guess
lin given_A = variants{} ; -- 
lin purple_A = mkA "paars" | mkA "purperen" ; -- status=guess status=guess
lin outlook_N = variants{} ; -- 
lin genius_N = mkN "genialiteit" feminine ; -- status=guess
lin dual_A = mkA "dubbel-" ; -- status=guess
lin canvas_N = mkN "canvas" neuter | mkN "doek" neuter | mkN "linnen" neuter | mkN "schilderslinnen" neuter ; -- status=guess status=guess status=guess status=guess
lin grave_A = variants{} ; -- 
lin pepper_N = mkN "chilipeper" ; -- status=guess
lin conform_V2 = mkV2 (mkV "conform") ; -- status=guess, src=wikt
lin conform_V = mkV "conform" ; -- status=guess, src=wikt
lin cautious_A = mkA "voorzichtig" ; -- status=guess
lin dot_N = mkN "punt" masculine ; -- status=guess
lin conspiracy_N = mkN "samenzwering" feminine | mkN "complot" neuter ; -- status=guess status=guess
lin butterfly_N = mkN "vlinder" masculine ; -- status=guess
lin sponsor_N = variants{} ; -- 
lin sincerely_Adv = variants{} ; -- 
lin rating_N = variants{} ; -- 
lin weird_A = mkA "vreemd" | mkA "raar" | mkA "ongewoon" | mkA "bizar" | mkA "eigenaardig" | mkA "merkwaardig" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin teenage_A = variants{} ; -- 
lin salmon_N = mkN "zalmkleur" feminine ; -- status=guess
lin recorder_N = mkN "blokfluit" ; -- status=guess
lin postpone_V2 = mkV2 (mkV "uitstellen") | mkV2 (mkV "verschuiven") | mkV2 (mkV "achterstellen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin maid_N = mkN "meid" feminine | mkN "dienstmeid" feminine ; -- status=guess status=guess
lin furnish_V2 = mkV2 (mkV "meubileren") | mkV2 (mkV "bemeubelen") | mkV2 (mkV "meubelen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin ethical_A = variants{} ; -- 
lin bicycle_N = mkN "fiets" masculine | mkN "cyclo-" | mkN "rijwiel" neuter ; -- status=guess status=guess status=guess
lin sick_N = mkN "zieke" masculine feminine | mkN "zieken {p}" ; -- status=guess status=guess
lin sack_N = mkN "zak" masculine ; -- status=guess
lin renaissance_N = variants{} ; -- 
lin luxury_N = mkN "luxe" masculine ; -- status=guess
lin gasp_V2 = mkV2 (mkV "hijgen") | mkV2 (mkV "snakken") ; -- status=guess, src=wikt status=guess, src=wikt
lin gasp_V = mkV "hijgen" | mkV "snakken" ; -- status=guess, src=wikt status=guess, src=wikt
lin wardrobe_N = mkN "shrank" ; -- status=guess
lin native_N = mkN "inlandse taal" ; -- status=guess
lin fringe_N = mkN "franje" masculine feminine ; -- status=guess
lin adaptation_N = mkN "aanpassing" feminine ; -- status=guess
lin quotation_N = mkN "citaat" neuter ; -- status=guess
lin hunger_N = mkN "honger" masculine | mkN "trek" ; -- status=guess status=guess
lin enclose_V2 = mkV2 (mkV "omheinen") ; -- status=guess, src=wikt
lin disastrous_A = mkA "onheilspellend" | mkA "sinister" ; -- status=guess status=guess
lin choir_N = mkN "koor" neuter ; -- status=guess
lin overwhelming_A = mkA "overweldigend" ; -- status=guess
lin glimpse_N = mkN "glimp" masculine ; -- status=guess
lin divorce_V2 = variants{} ; -- 
lin circular_A = variants{} ; -- 
lin locality_N = variants{} ; -- 
lin ferry_N = mkN "veer" neuter | mkN "veerpont" ; -- status=guess status=guess
lin balcony_N = mkN "balkon" neuter ; -- status=guess
lin sailor_N = mkN "matroos" masculine ; -- status=guess
lin precision_N = variants{} ; -- 
lin desert_V2 = mkV2 (mkV "achterlaten") | mkV2 (mkV "verlaten") | mkV2 (mkV (mkV "aan") "m 'n lot overlaten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin desert_V = mkV "achterlaten" | mkV "verlaten" | mkV (mkV "aan") "m 'n lot overlaten" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dancing_N = mkN "dansen" neuter ; -- status=guess
lin alert_V2 = variants{} ; -- 
lin surrender_V2 = mkV2 (reflMkV "overgeven") ; -- status=guess, src=wikt
lin surrender_V = reflMkV "overgeven" ; -- status=guess, src=wikt
lin archive_N = mkN "archief" neuter ; -- status=guess
lin jump_N = mkN "sprong" masculine ; -- status=guess
lin philosopher_N = mkN "filosoof" masculine | mkN "filosofe" feminine | mkN "wijsgeer" masculine ; -- status=guess status=guess status=guess
lin revival_N = mkN "heropleving" feminine ; -- status=guess
lin presume_VS = mkVS (mkV "aannemen") | mkVS (mkV "veronderstellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin presume_V2 = mkV2 (mkV "aannemen") | mkV2 (mkV "veronderstellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin presume_V = mkV "aannemen" | mkV "veronderstellen" ; -- status=guess, src=wikt status=guess, src=wikt
lin node_N = variants{} ; -- 
lin fantastic_A = mkA "fantastisch" | mkA "grandioos" ; -- status=guess status=guess
lin herb_N = mkN "kruid" ; -- status=guess
lin assertion_N = mkN "bevestiging" ; -- status=guess
lin thorough_A = mkA "grondig" | mkA "diepgaand" ; -- status=guess status=guess
lin quit_V2 = mkV2 (mkV (mkV "ophouden") "met") | mkV2 (mkV "stoppen") | mkV2 (mkV "opgeven") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin quit_V = mkV (mkV "ophouden") "met" | mkV "stoppen" | mkV "opgeven" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grim_A = variants{} ; -- 
lin fair_N = mkN "jaarmarkt" masculine | mkN "kermis" masculine | mkN "braderie" feminine ; -- status=guess status=guess status=guess
lin broadcast_V2 = mkV2 (mkV "omroepen") ; -- status=guess, src=wikt
lin broadcast_V = mkV "omroepen" ; -- status=guess, src=wikt
lin annoy_V2 = mkV2 (mkV "ergeren") | mkV2 (mkV "vervelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin divert_V = variants{} ; -- 
lin accelerate_V2 = mkV2 (mkV "versnellen") | mkV2 (mkV (mkV "sneller") "gaan") ; -- status=guess, src=wikt status=guess, src=wikt
lin accelerate_V = mkV "versnellen" | mkV (mkV "sneller") "gaan" ; -- status=guess, src=wikt status=guess, src=wikt
lin polymer_N = mkN "polymeer" neuter ; -- status=guess
lin sweat_N = mkN "zweet" neuter | mkN "transpiratievocht" neuter ; -- status=guess status=guess
lin survivor_N = variants{} ; -- 
lin subscription_N = variants{} ; -- 
lin repayment_N = variants{} ; -- 
lin anonymous_A = mkA "naamloos" | mkA "anoniem" ; -- status=guess status=guess
lin summarize_V2 = mkV2 (mkV "samenvatten") | mkV2 (mkV "opsommen") ; -- status=guess, src=wikt status=guess, src=wikt
lin punch_N = mkN "punch" masculine ; -- status=guess
lin lodge_V2 = mkV2 (mkV "herbergen") ; -- status=guess, src=wikt
lin lodge_V = mkV "herbergen" ; -- status=guess, src=wikt
lin landowner_N = mkN "grootgrondbezitter" masculine ; -- status=guess
lin ignorance_N = mkN "onwetendheid" feminine | mkN "ignorantie" feminine ; -- status=guess status=guess
lin discourage_V2 = mkV2 (mkV "ontmoedigen") ; -- status=guess, src=wikt
lin bride_N = mkN "bruid" feminine ; -- status=guess
lin likewise_Adv = mkAdv "evenzo" | mkAdv "eveneens" | mkAdv "op gelijkaardige wijze" ; -- status=guess status=guess status=guess
lin depressed_A = variants{} ; -- 
lin abbey_N = mkN "abdijkerk" feminine ; -- status=guess
lin quarry_N = mkN "prooi" masculine feminine | mkN "prooidier" neuter ; -- status=guess status=guess
lin archbishop_N = mkN "aartsbisschop" masculine ; -- status=guess
lin sock_N = L.sock_N ;
lin large_scale_A = variants{} ; -- 
lin glare_V2 = variants{} ; -- 
lin glare_V = variants{} ; -- 
lin descent_N = mkN "afdaling" feminine ; -- status=guess
lin stumble_V = mkV "struikelen" | mkV "strompelen" ; -- status=guess, src=wikt status=guess, src=wikt
lin mistress_N = mkN "minnares" feminine ; -- status=guess
lin empty_V2 = mkV2 (mkV "leegmaken") | mkV2 (mkV "legen") ; -- status=guess, src=wikt status=guess, src=wikt
lin empty_V = mkV "leegmaken" | mkV "legen" ; -- status=guess, src=wikt status=guess, src=wikt
lin prosperity_N = mkN "voorspoed" ; -- status=guess
lin harm_V2 = mkV2 (mkV "schaden") | mkV2 (mkV "beschadigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin formulation_N = variants{} ; -- 
lin atomic_A = mkA "atomisch" ; -- status=guess
lin agreed_A = variants{} ; -- 
lin wicked_A = mkA "kwaadaardig" ; -- status=guess
lin threshold_N = mkN "dorpel" | mkN "drempel" ; -- status=guess status=guess
lin lobby_N = variants{} ; -- 
lin repay_V2 = mkV2 (mkV "terugbetalen") ; -- status=guess, src=wikt
lin repay_V = mkV "terugbetalen" ; -- status=guess, src=wikt
lin varying_A = variants{} ; -- 
lin track_V2 = variants{} ; -- 
lin track_V = variants{} ; -- 
lin crawl_V = kruipen_V ; -- status=guess, src=wikt
lin tolerate_V2 = mkV2 (mkV "verdragen") | mkV2 (mkV "tolereren") | mkV2 (mkV "toelaten") | mkV2 (mkV "dulden") | mkV2 (mkV "gedogen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin salvation_N = mkN "verlossing" feminine ; -- status=guess
lin pudding_N = mkN "pudding" masculine ; -- status=guess
lin counter_VS = variants{} ; -- 
lin counter_V = variants{} ; -- 
lin propaganda_N = mkN "propaganda" feminine ; -- status=guess
lin cage_N = mkN "kooi" utrum ; -- status=guess
lin broker_N = mkN "tussenpersoon" masculine ; -- status=guess
lin ashamed_A = mkA "beschaamd" ; -- status=guess
lin scan_V2 = mkV2 (mkV "scannen") ; -- status=guess, src=wikt
lin scan_V = mkV "scannen" ; -- status=guess, src=wikt
lin document_V2 = mkV2 (mkV "documenteren") ; -- status=guess, src=wikt
lin apparatus_N = mkN "apparaat" ; -- status=guess
lin theology_N = mkN "theologie" feminine | mkN "godgeleerdheid" feminine ; -- status=guess status=guess
lin analogy_N = mkN "analogie" feminine ; -- status=guess
lin efficiently_Adv = variants{} ; -- 
lin bitterly_Adv = variants{} ; -- 
lin performer_N = mkN "uitvoerder" masculine ; -- status=guess
lin individually_Adv = variants{} ; -- 
lin amid_Prep = variants{} ; -- 
lin squadron_N = mkN "eskader" neuter ; -- status=guess
lin sentiment_N = variants{} ; -- 
lin making_N = variants{} ; -- 
lin exotic_A = mkA "exotisch" | mkA "exotische" ; -- status=guess status=guess
lin dominance_N = mkN "overheersing" ; -- status=guess
lin coherent_A = mkA "samenhangend" | mkA "coherent" ; -- status=guess status=guess
lin placement_N = variants{} ; -- 
lin flick_V2 = variants{} ; -- 
lin colourful_A = variants{} ; -- 
lin mercy_N = mkN "genade" feminine | mkN "erbarmen" neuter | mkN "vergeving" feminine | mkN "vergiffenis" feminine ; -- status=guess status=guess status=guess status=guess
lin angrily_Adv = variants{} ; -- 
lin amuse_V2 = mkV2 (mkV "amuseren") ; -- status=guess, src=wikt
lin mainstream_N = variants{} ; -- 
lin appraisal_N = mkN "schatting" feminine | mkN "taxatie" feminine | mkN "raming" masculine ; -- status=guess status=guess status=guess
lin annually_Adv = mkAdv "jaarlijks" ; -- status=guess
lin torch_N = mkN "zaklamp" ; -- status=guess
lin intimate_A = mkA "innig" ; -- status=guess
lin gold_A = variants{} ; -- 
lin arbitrary_A = mkA "willekeurig" ; -- status=guess
lin venture_VS = mkVS (mkV "riskeren") | mkVS (mkV "wagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin venture_V2 = mkV2 (mkV "riskeren") | mkV2 (mkV "wagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin venture_V = mkV "riskeren" | mkV "wagen" ; -- status=guess, src=wikt status=guess, src=wikt
lin preservation_N = variants{} ; -- 
lin shy_A = mkA "verstandig" | mkA "voorzichtig" ; -- status=guess status=guess
lin disclosure_N = variants{} ; -- 
lin lace_N = mkN "veter" masculine ; -- status=guess
lin inability_N = variants{} ; -- 
lin motif_N = variants{} ; -- 
lin listenerMasc_N = mkN "luisteraar" masculine ; -- status=guess
lin hunt_N = mkN "jacht" masculine ; -- status=guess
lin delicious_A = mkA "heerlijk" | mkA "lekker" | mkA "smakelijk" ; -- status=guess status=guess status=guess
lin term_VS = variants{} ; -- 
lin term_V2 = variants{} ; -- 
lin substitute_N = mkN "vervanger" masculine | mkN "plaatsvervanger" masculine | mkN "vervanging" feminine ; -- status=guess status=guess status=guess
lin highway_N = mkN "autosnelweg" masculine | mkN "autostrade" feminine | mkN "snelweg" masculine ; -- status=guess status=guess status=guess
lin haul_V2 = variants{} ; -- 
lin haul_V = variants{} ; -- 
lin dragon_N = mkN "drakenboot" ; -- status=guess
lin chair_V2 = variants{} ; -- 
lin accumulate_V2 = mkV2 (reflMkV "opstapelen") | mkV2 (mkV "vermeerderen") | mkV2 (mkV "accumuleren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accumulate_V = reflMkV "opstapelen" | mkV "vermeerderen" | mkV "accumuleren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin unchanged_A = variants{} ; -- 
lin sediment_N = variants{} ; -- 
lin sample_V2 = variants{} ; -- 
lin exclaim_V2 = variants{} ; -- 
lin fan_V2 = variants{} ; -- 
lin fan_V = variants{} ; -- 
lin volunteer_V2 = variants{} ; -- 
lin volunteer_V = variants{} ; -- 
lin root_V2 = mkV2 (mkV "juichen") | mkV2 (mkV "aanvuren") | mkV2 (mkV "supporteren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin root_V = mkV "juichen" | mkV "aanvuren" | mkV "supporteren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin parcel_N = variants{} ; -- 
lin psychiatric_A = mkA "psychiatrisch" ; -- status=guess
lin delightful_A = variants{} ; -- 
lin confidential_A = mkA "vertrouwelijk" ; -- status=guess
lin calorie_N = mkN "calorie" feminine ; -- status=guess
lin flash_N = mkN "flits" feminine ; -- status=guess
lin crowd_V2 = variants{} ; -- 
lin crowd_V = variants{} ; -- 
lin aggregate_A = variants{} ; -- 
lin scholarship_N = mkN "studiebeurs or" masculine ; -- status=guess
lin monitor_N = mkN "monitor" | mkN "beeldscherm" ; -- status=guess status=guess
lin disciplinary_A = variants{} ; -- 
lin rock_V2 = mkV2 (mkV "schudden") ; -- status=guess, src=wikt
lin rock_V = mkV "schudden" ; -- status=guess, src=wikt
lin hatred_N = mkN "haat" masculine ; -- status=guess
lin pill_N = mkN "pil" ; -- status=guess
lin noisy_A = mkA "lawaaierig" ; -- status=guess
lin feather_N = L.feather_N ;
lin lexical_A = variants{} ; -- 
lin staircase_N = mkN "trap" masculine ; -- status=guess
lin autonomous_A = mkA "autonoom" ; -- status=guess
lin viewpoint_N = variants{} ; -- 
lin projection_N = variants{} ; -- 
lin offensive_A = mkA "weerzinwekkend" | mkA "walgelijk" | mkA "beledigend" ; -- status=guess status=guess status=guess
lin controlled_A = variants{} ; -- 
lin flush_V2 = mkV2 (mkV "blozen") ; -- status=guess, src=wikt
lin flush_V = mkV "blozen" ; -- status=guess, src=wikt
lin racism_N = mkN "racisme" neuter ; -- status=guess
lin flourish_V = mkV "floreren" ; -- status=guess, src=wikt
lin resentment_N = mkN "misnoegen" ; -- status=guess
lin pillow_N = mkN "kussen" neuter ; -- status=guess
lin courtesy_N = mkN "hoffelijkheid" feminine ; -- status=guess
lin photography_N = mkN "fotografie" feminine ; -- status=guess
lin monkey_N = mkN "apenjong" | mkN "brutale aap" ; -- status=guess status=guess
lin glorious_A = mkA "roemruchtig" ; -- status=guess
lin evolutionary_A = mkA "evolutionair" ; -- status=guess
lin gradual_A = mkA "geleidelijk" ; -- status=guess
lin bankruptcy_N = mkN "bankroet" neuter | mkN "failliet" neuter | mkN "faling" feminine | mkN "surseance van betaling" masculine feminine ; -- status=guess status=guess status=guess status=guess
lin sacrifice_N = mkN "offer" | mkN "opoffering" feminine ; -- status=guess status=guess
lin uphold_V2 = mkV2 (mkV "ondersteunen") | mkV2 (mkV (mkV "staande") "houden") ; -- status=guess, src=wikt status=guess, src=wikt
lin sketch_N = mkN "schets" utrum ; -- status=guess
lin presidency_N = variants{} ; -- 
lin formidable_A = mkA "ontzagwekkend" ; -- status=guess
lin differentiate_V2 = mkV2 (mkV "differentiëren") ; -- status=guess, src=wikt
lin differentiate_V = mkV "differentiëren" ; -- status=guess, src=wikt
lin continuing_A = variants{} ; -- 
lin cart_N = variants{} ; -- 
lin stadium_N = mkN "stadion" neuter ; -- status=guess
lin dense_A = variants{} ; -- 
lin catch_N = mkN "haak" masculine ; -- status=guess
lin beyond_Adv = variants{}; -- mkPrep "voorbij" ;
lin immigration_N = mkN "inwijking" feminine | mkN "immigratie" feminine ; -- status=guess status=guess
lin clarity_N = mkN "helderheid" feminine | mkN "klaarheid" feminine ; -- status=guess status=guess
lin worm_N = L.worm_N ;
lin slot_N = mkN "gokmachine" | mkN "jackpot" ; -- status=guess status=guess
lin rifle_N = mkN "geweer" neuter | mkN "karabijn" feminine ; -- status=guess status=guess
lin screw_V2 = mkV2 (mkV "schroeven") | mkV2 (mkV "vijzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin screw_V = mkV "schroeven" | mkV "vijzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin harvest_N = mkN "oogstfeest" neuter ; -- status=guess
lin foster_V2 = variants{} ; -- 
lin academic_N = mkN "academicus" masculine ; -- status=guess
lin impulse_N = variants{} ; -- 
lin guardian_N = mkN "beschermengel" ; -- status=guess
lin ambiguity_N = mkN "dubbelzinnigheid" feminine | mkN "ambiguïteit" feminine ; -- status=guess status=guess
lin triangle_N = mkN "triangel" masculine ; -- status=guess
lin terminate_V2 = mkV2 (mkV "beëindigen") | mkV2 (mkV "termineren") ; -- status=guess, src=wikt status=guess, src=wikt
lin terminate_V = mkV "beëindigen" | mkV "termineren" ; -- status=guess, src=wikt status=guess, src=wikt
lin retreat_V = reflMkV "terugtrekken" ; -- status=guess, src=wikt
lin pony_N = mkN "pony" masculine ; -- status=guess
lin outdoor_A = variants{} ; -- 
lin deficiency_N = mkN "tekort" neuter ; -- status=guess
lin decree_N = variants{} ; -- 
lin apologize_V = mkV "verantwoorden" ; -- status=guess, src=wikt
lin yarn_N = mkN "garen" neuter ; -- status=guess
lin staff_V2 = variants{} ; -- 
lin renewal_N = variants{} ; -- 
lin rebellion_N = mkN "oproer" | mkN "opstand" masculine | mkN "rebellie" feminine | mkN "verzet" neuter ; -- status=guess status=guess status=guess status=guess
lin incidentally_Adv = variants{} ; -- 
lin flour_N = mkN "meel" | mkN "bloem" ; -- status=guess status=guess
lin developed_A = variants{} ; -- 
lin chorus_N = mkN "koor" neuter ; -- status=guess
lin ballot_N = variants{} ; -- 
lin appetite_N = mkN "honger" | mkN "trek" | mkN "appetijt" | mkN "eetlust" ; -- status=guess status=guess status=guess status=guess
lin stain_V2 = mkV2 (mkV "beitsen") ; -- status=guess, src=wikt
lin stain_V = mkV "beitsen" ; -- status=guess, src=wikt
lin notebook_N = mkN "schrift" neuter | mkN "cahier" neuter ; -- status=guess status=guess
lin loudly_Adv = variants{} ; -- 
lin homeless_A = mkA "dakloos" ; -- status=guess
lin census_N = mkN "volkstelling" feminine ; -- status=guess
lin bizarre_A = mkA "bizar" ; -- status=guess
lin striking_A = mkA "opvallend" | mkA "treffend" ; -- status=guess status=guess
lin greenhouse_N = mkN "kas" feminine ; -- status=guess
lin part_V2 = variants{} ; -- 
lin part_V = variants{} ; -- 
lin burial_N = variants{} ; -- 
lin embarrassed_A = mkA "in verlegenheid gebracht" ; -- status=guess
lin ash_N = mkN "as" feminine | mkN "asse" feminine ; -- status=guess status=guess
lin actress_N = mkN "actrice" feminine ; -- status=guess
lin cassette_N = mkN "cassette" ; -- status=guess
lin privacy_N = mkN "afzondering" feminine | mkN "privacy" feminine ; -- status=guess status=guess
lin fridge_N = L.fridge_N ;
lin feed_N = mkN "festijn" neuter ; -- status=guess
lin excess_A = variants{} ; -- 
lin calf_N = mkN "kuit" masculine ; -- status=guess
lin associate_N = variants{} ; -- 
lin ruin_N = mkN "ruïne" feminine ; -- status=guess
lin jointly_Adv = mkAdv "gezamenlijk" ; -- status=guess
lin drill_V2 = mkV2 (graven_V) ; -- status=guess, src=wikt
lin drill_V = graven_V ; -- status=guess, src=wikt
lin photograph_V2 = mkV2 (mkV "fotograferen") | mkV2 (mkV (mkV "een") "foto nemen") ; -- status=guess, src=wikt status=guess, src=wikt
lin devoted_A = variants{} ; -- 
lin indirectly_Adv = mkAdv "onrechtstreeks" ; -- status=guess
lin driving_A = variants{} ; -- 
lin memorandum_N = variants{} ; -- 
lin default_N = variants{} ; -- 
lin costume_N = mkN "kostuum" neuter | mkN "vermomming" ; -- status=guess status=guess
lin variant_N = mkN "variant" ; -- status=guess
lin shatter_V2 = mkV2 (mkV "verbrijzelen") ; -- status=guess, src=wikt
lin shatter_V = mkV "verbrijzelen" ; -- status=guess, src=wikt
lin methodology_N = variants{} ; -- 
lin frame_V2 = variants{} ; -- 
lin frame_V = variants{} ; -- 
lin allegedly_Adv = variants{} ; -- 
lin swell_V2 = mkV2 (zwellen_V) | mkV2 (mkV "opzwellen") | mkV2 (mkV "aanzwellen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin swell_V = L.swell_V ;
lin investigator_N = mkN "onderzoeker" masculine ; -- status=guess
lin imaginative_A = variants{} ; -- 
lin bored_A = mkA "verveeld" ; -- status=guess
lin bin_N = mkN "vuilnisbak" | mkN "afvalbak" ; -- status=guess status=guess
lin awake_A = mkA "wakker" | mkA "ontwaakt" ; -- status=guess status=guess
lin recycle_V2 = mkV2 (mkV "recycleren") | mkV2 (mkV "hergebruiken") ; -- status=guess, src=wikt status=guess, src=wikt
lin group_V2 = mkV2 (mkV "groeperen") ; -- status=guess, src=wikt
lin group_V = mkV "groeperen" ; -- status=guess, src=wikt
lin enjoyment_N = variants{} ; -- 
lin contemporary_N = mkN "tijdgenoot" masculine | mkN "tijdgenote" feminine ; -- status=guess status=guess
lin texture_N = mkN "textuur" ; -- status=guess
lin donor_N = variants{} ; -- 
lin bacon_N = mkN "bacon" masculine ; -- status=guess
lin sunny_A = mkA "zonnig" ; -- status=guess
lin stool_N = mkN "kruk" feminine | mkN "barkruk" feminine ; -- status=guess status=guess
lin prosecute_V2 = variants{} ; -- 
lin commentary_N = variants{} ; -- 
lin bass_N = mkN "bassleutel" ; -- status=guess
lin sniff_V2 = mkV2 (mkV "snuffelen") | mkV2 (snuiven_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin sniff_V = mkV "snuffelen" | snuiven_V ; -- status=guess, src=wikt status=guess, src=wikt
lin repetition_N = mkN "herhaling" feminine ; -- status=guess
lin eventual_A = mkA "uiteindelijk" ; -- status=guess
lin credit_V2 = mkV2 (mkV "toeschrijven") | mkV2 (mkV "toedenken") ; -- status=guess, src=wikt status=guess, src=wikt
lin suburb_N = mkN "voorstad" masculine feminine ; -- status=guess
lin newcomer_N = mkN "nieuwkomer" masculine ; -- status=guess
lin romance_N = variants{} ; -- 
lin film_V2 = variants{} ; -- 
lin film_V = variants{} ; -- 
lin experiment_V2 = mkV2 (mkV "experimenteren") ; -- status=guess, src=wikt
lin experiment_V = mkV "experimenteren" ; -- status=guess, src=wikt
lin daylight_N = mkN "daglicht" neuter ; -- status=guess
lin warrant_N = variants{} ; -- 
lin fur_N = mkN "voering" ; -- status=guess
lin parking_N = mkN "parkeergarage" feminine ; -- status=guess
lin nuisance_N = mkN "overlast" masculine ; -- status=guess
lin civilian_A = mkA "burger-" ; -- status=guess
lin foolish_A = mkA "onverstandig" | mkA "dom" ; -- status=guess status=guess
lin bulb_N = variants{} ; -- 
lin balloon_N = mkN "ballon" masculine ; -- status=guess
lin vivid_A = mkA "helder" | mkA "intens" | mkA "kleurrijklevendig" ; -- status=guess status=guess status=guess
lin surveyor_N = variants{} ; -- 
lin spontaneous_A = mkA "spontaan" ; -- status=guess
lin biology_N = mkN "biologie" ; -- status=guess
lin injunction_N = mkN "injunctie" feminine | mkN "dwangbevel" neuter | mkN "gerechtelijk bevel" neuter ; -- status=guess status=guess status=guess
lin appalling_A = mkA "ontzettend" ; -- status=guess
lin amusement_N = mkN "amusement" neuter | mkN "vertier" neuter ; -- status=guess status=guess
lin aesthetic_A = mkA "esthetisch" ; -- status=guess
lin vegetation_N = variants{} ; -- 
lin stab_V2 = L.stab_V2 ;
lin stab_V = steken_V ; -- status=guess, src=wikt
lin rude_A = mkA "grof" ; -- status=guess
lin offset_V2 = variants{} ; -- 
lin thinking_N = variants{} ; -- 
lin mainframe_N = variants{} ; -- 
lin flock_N = mkN "kudde" masculine ; -- status=guess
lin amateur_A = variants{} ; -- 
lin academy_N = mkN "academie" feminine | mkN "universiteit" | mkN "college" ; -- status=guess status=guess status=guess
lin shilling_N = variants{} ; -- 
lin reluctance_N = mkN "tegenzin" masculine ; -- status=guess
lin velocity_N = mkN "snelheid" ; -- status=guess
lin spare_V2 = mkV2 (mkV "sparen") ; -- status=guess, src=wikt
lin spare_V = mkV "sparen" ; -- status=guess, src=wikt
lin wartime_N = variants{} ; -- 
lin soak_V2 = mkV2 (mkV "weken") ; -- status=guess, src=wikt
lin soak_V = mkV "weken" ; -- status=guess, src=wikt
lin rib_N = mkN "rib" feminine ; -- status=guess
lin mighty_A = mkA "machtig" ; -- status=guess
lin shocked_A = variants{} ; -- 
lin vocational_A = mkA "met betrekking tot een roeping" ; -- status=guess
lin spit_V2 = mkV2 (mkV "spuwen") | mkV2 (mkV "spugen") ; -- status=guess, src=wikt status=guess, src=wikt
lin spit_V = L.spit_V ;
lin gall_N = mkN "gal" masculine ; -- status=guess
lin bowl_V2 = variants{} ; -- 
lin bowl_V = variants{} ; -- 
lin prescription_N = mkN "uitvaardigen" ; -- status=guess
lin fever_N = mkN "verhoging" feminine | mkN "koorts" feminine ; -- status=guess status=guess
lin axis_N = mkN "as" ; -- status=guess
lin reservoir_N = mkN "stuwmeer" neuter ; -- status=guess
lin magnitude_N = mkN "grootte" feminine ; -- status=guess
lin rape_V2 = mkV2 (mkV "verkrachten") | mkV2 (schenden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin cutting_N = mkN "stek" utrum ; -- status=guess
lin bracket_N = mkN "haakje" neuter ; -- status=guess
lin agony_N = mkN "ondraaglijke pijn" ; -- status=guess
lin strive_VV = mkVV (mkV "streven") ; -- status=guess, src=wikt
lin strive_V = mkV "streven" ; -- status=guess, src=wikt
lin strangely_Adv = variants{} ; -- 
lin pledge_VS = variants{} ; -- 
lin pledge_V2V = variants{} ; -- 
lin pledge_V2 = variants{} ; -- 
lin recipient_N = mkN "ontvanger" masculine ; -- status=guess
lin moor_N = mkN "veen" neuter ; -- status=guess
lin invade_V2 = variants{} ; -- 
lin dairy_N = mkN "zuivel" masculine ; -- status=guess
lin chord_N = mkN "akkoord" neuter ; -- status=guess
lin shrink_V2 = mkV2 (krimpen_V) ; -- status=guess, src=wikt
lin shrink_V = krimpen_V ; -- status=guess, src=wikt
lin poison_N = mkN "gif" neuter | mkN "vergif" neuter | mkN "vergift" neuter ; -- status=guess status=guess status=guess
lin pillar_N = mkN "pijler" | mkN "zuil" | mkN "pilaar" ; -- status=guess status=guess status=guess
lin washing_N = variants{} ; -- 
lin warrior_N = mkN "krijger" masculine ; -- status=guess
lin supervisor_N = variants{} ; -- 
lin outfit_N = variants{} ; -- 
lin innovative_A = variants{} ; -- 
lin dressing_N = variants{} ; -- 
lin dispute_V2 = variants{} ; -- 
lin dispute_V = variants{} ; -- 
lin jungle_N = mkN "oerwoud" | mkN "jungle" feminine ; -- status=guess status=guess
lin brewery_N = mkN "brouwerij" feminine ; -- status=guess
lin adjective_N = mkN "bijvoeglijk naamwoord" neuter | mkN "adjectief" neuter ; -- status=guess status=guess
lin straighten_V2 = mkV2 (reflMkV "rechten") | mkV2 (mkV (mkV "recht") "worden") ; -- status=guess, src=wikt status=guess, src=wikt
lin straighten_V = reflMkV "rechten" | mkV (mkV "recht") "worden" ; -- status=guess, src=wikt status=guess, src=wikt
lin restrain_V2 = variants{} ; -- 
lin monarchy_N = mkN "monarchie" feminine ; -- status=guess
lin trunk_N = mkN "slurf" masculine ; -- status=guess
lin herd_N = mkN "kudde" feminine ; -- status=guess
lin deadline_N = variants{} ; -- 
lin tiger_N = mkN "tijger" masculine ; -- status=guess
lin supporting_A = variants{} ; -- 
lin moderate_A = mkA "gematigd" ; -- status=guess
lin kneel_V = mkV "knielen" ; -- status=guess, src=wikt
lin ego_N = variants{} ; -- 
lin sexually_Adv = variants{} ; -- 
lin ministerial_A = variants{} ; -- 
lin bitch_N = mkN "slet" feminine | mkN "bitch" feminine | mkN "poot" masculine ; -- status=guess status=guess status=guess
lin wheat_N = mkN "tarwe" masculine ; -- status=guess
lin stagger_V = mkV "twijfelen" ; -- status=guess, src=wikt
lin snake_N = L.snake_N ;
lin ribbon_N = mkN "lint" neuter ; -- status=guess
lin mainland_N = mkN "vasteland" neuter ; -- status=guess
lin fisherman_N = variants{} ; -- 
lin economically_Adv = variants{} ; -- 
lin unwilling_A = variants{} ; -- 
lin nationalism_N = mkN "nationalisme" ; -- status=guess
lin knitting_N = variants{} ; -- 
lin irony_N = mkN "ironie" feminine | mkN "het ironische" neuter ; -- status=guess status=guess
lin handling_N = variants{} ; -- 
lin desired_A = variants{} ; -- 
lin bomber_N = mkN "bommenwerper" masculine ; -- status=guess
lin voltage_N = mkN "spanning" ; -- status=guess
lin unusually_Adv = variants{} ; -- 
lin toast_N = mkN "toost" | mkN "heildronk" ; -- status=guess status=guess
lin feel_N = variants{} ; -- 
lin suffering_N = mkN "lijden" neuter ; -- status=guess
lin polish_V2 = mkV2 (mkV "polijsten") | mkV2 (mkV "poetsen") | mkV2 (mkV "oppoetsen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin polish_V = mkV "polijsten" | mkV "poetsen" | mkV "oppoetsen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin technically_Adv = mkAdv "technisch gesproken" | mkAdv "strikt genomen" ; -- status=guess status=guess
lin meaningful_A = mkA "zinvol" ; -- status=guess
lin aloud_Adv = variants{} ; -- 
lin waiter_N = mkN "ober" masculine | mkN "kelner" masculine ; -- status=guess status=guess
lin tease_V2 = mkV2 (mkV "plagen") ; -- status=guess, src=wikt
lin opposite_Adv = mkAdv "tegenover" ; -- status=guess
lin goat_N = mkN "geit" feminine | mkN "bok" masculine ; -- status=guess status=guess
lin conceptual_A = mkA "conceptueel" ; -- status=guess
lin ant_N = mkN "mier" feminine ; -- status=guess
lin inflict_V2 = variants{} ; -- 
lin bowler_N = variants{} ; -- 
lin roar_V2 = mkV2 (mkV "brullen") ; -- status=guess, src=wikt
lin roar_V = mkV "brullen" ; -- status=guess, src=wikt
lin drain_N = mkN "afvoer" ; -- status=guess
lin wrong_N = mkN "verkeerde" neuter | mkN "kwaad" neuter | mkN "onrecht" neuter ; -- status=guess status=guess status=guess
lin galaxy_N = mkN "sterrenstelsel" neuter ; -- status=guess
lin aluminium_N = mkN "aluminium" neuter ; -- status=guess
lin receptor_N = variants{} ; -- 
lin preach_V2 = mkV2 (mkV "verkondigen") | mkV2 (mkV "preken") | mkV2 (mkV "prediken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin preach_V = mkV "verkondigen" | mkV "preken" | mkV "prediken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin parade_N = mkN "parade" feminine | mkN "optocht" masculine | mkN "defilé" neuter ; -- status=guess status=guess status=guess
lin opposite_N = mkN "tegenovergestelde" neuter ; -- status=guess
lin critique_N = variants{} ; -- 
lin query_N = mkN "verzoek" neuter ; -- status=guess
lin outset_N = variants{} ; -- 
lin integral_A = mkA "integraal" ; -- status=guess
lin grammatical_A = mkA "grammaticaal" ; -- status=guess
lin testing_N = variants{} ; -- 
lin patrol_N = mkN "patrouillewagen" masculine ; -- status=guess
lin pad_N = variants{} ; -- 
lin unreasonable_A = variants{} ; -- 
lin sausage_N = mkN "worst" masculine ; -- status=guess
lin criminal_N = mkN "misdadiger" masculine | mkN "crimineel" masculine ; -- status=guess status=guess
lin constructive_A = variants{} ; -- 
lin worldwide_A = mkA "wereldwijd" | mkA "wereldwijde" ; -- status=guess status=guess
lin highlight_N = variants{} ; -- 
lin doll_N = mkN "pop" feminine ; -- status=guess
lin frightened_A = variants{} ; -- 
lin biography_N = variants{} ; -- 
lin vocabulary_N = mkN "woordenlijst " masculine ; -- status=guess
lin offend_V2 = mkV2 (mkV "ergeren") | mkV2 (mkV "kwellen") | mkV2 (mkV "irriteren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin offend_V = mkV "ergeren" | mkV "kwellen" | mkV "irriteren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accumulation_N = mkN "accumulatie" feminine | mkN "opstapeling" feminine | mkN "opeenhoping" feminine ; -- status=guess status=guess status=guess
lin linen_N = mkN "linnen" neuter | mkN "doek" neuter ; -- status=guess status=guess
lin fairy_N = mkN "fee" feminine ; -- status=guess
lin disco_N = variants{} ; -- 
lin hint_VS = variants{} ; -- 
lin hint_V2 = variants{} ; -- 
lin hint_V = variants{} ; -- 
lin versus_Prep = variants{} ; -- 
lin ray_N = mkN "straal" feminine ; -- status=guess
lin pottery_N = mkN "aardewerk" neuter | mkN "vaatwerk" neuter | mkN "keramiek" feminine ; -- status=guess status=guess status=guess
lin immune_A = variants{} ; -- 
lin retreat_N = mkN "retraite" utrum ; -- status=guess
lin master_V2 = mkV2 (mkV "controleren") ; -- status=guess, src=wikt
lin injured_A = variants{} ; -- 
lin holly_N = mkN "hulst" masculine ; -- status=guess
lin battle_V2 = mkV2 (strijden_V) | mkV2 (vechten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin battle_V = strijden_V | vechten_V ; -- status=guess, src=wikt status=guess, src=wikt
lin solidarity_N = mkN "solidariteit" ; -- status=guess
lin embarrassing_A = mkA "gênant" ; -- status=guess
lin cargo_N = mkN "vracht" feminine ; -- status=guess
lin theorist_N = mkN "theoreticus" masculine ; -- status=guess
lin reluctantly_Adv = mkAdv "met tegenzin" ; -- status=guess
lin preferred_A = variants{} ; -- 
lin dash_V = mkV (mkV "snel") "afhaspelen" | mkV (mkV "snel") "afmaken" ; -- status=guess, src=wikt status=guess, src=wikt
lin total_V2 = mkV2 (mkV "bijeentellen") | mkV2 (mkV "optellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin total_V = mkV "bijeentellen" | mkV "optellen" ; -- status=guess, src=wikt status=guess, src=wikt
lin reconcile_V2 = mkV2 (mkV "verzoenen") ; -- status=guess, src=wikt
lin drill_N = mkN "boorkop" masculine ; -- status=guess
lin credibility_N = mkN "geloofwaardigheid" feminine ; -- status=guess
lin copyright_N = mkN "auteursrecht" neuter ; -- status=guess
lin beard_N = mkN "baard" masculine ; -- status=guess
lin bang_N = mkN "klap" | mkN "slag" ; -- status=guess status=guess
lin vigorous_A = mkA "krachtig" | mkA "sterk" ; -- status=guess status=guess
lin vaguely_Adv = mkAdv "vaag" ; -- status=guess
lin punch_V2 = variants{} ; -- 
lin prevalence_N = variants{} ; -- 
lin uneasy_A = variants{} ; -- 
lin boost_N = mkN "zetje" neuter | mkN "duwtje" neuter | mkN "duwtje in de rug" neuter ; -- status=guess status=guess status=guess
lin scrap_N = mkN "restje" neuter ; -- status=guess
lin ironically_Adv = mkAdv "ironisch" ; -- status=guess
lin fog_N = L.fog_N ;
lin faithful_A = mkA "getrouw" ; -- status=guess
lin bounce_V2 = mkV2 (mkV "stuiteren") ; -- status=guess, src=wikt
lin bounce_V = mkV "stuiteren" ; -- status=guess, src=wikt
lin batch_N = mkN "lot" neuter ; -- status=guess
lin smooth_V2 = mkV2 (mkV (mkV "glad") "maken") | mkV2 (mkV "gladstrijken") ; -- status=guess, src=wikt status=guess, src=wikt
lin smooth_V = mkV (mkV "glad") "maken" | mkV "gladstrijken" ; -- status=guess, src=wikt status=guess, src=wikt
lin sleeping_A = variants{} ; -- 
lin poorly_Adv = variants{} ; -- 
lin accord_V = variants{} ; -- 
lin vice_president_N = variants{} ; -- 
lin duly_Adv = variants{} ; -- 
lin blast_N = mkN "ontploffing" ; -- status=guess
lin square_V2 = mkV2 (mkV "kwadrateren") | mkV2 (mkV (mkV "tot") "de tweede macht verheffen") ; -- status=guess, src=wikt status=guess, src=wikt
lin square_V = mkV "kwadrateren" | mkV (mkV "tot") "de tweede macht verheffen" ; -- status=guess, src=wikt status=guess, src=wikt
lin prohibit_V2 = mkV2 (mkV "verbieden") ; -- status=guess, src=wikt
lin prohibit_V = mkV "verbieden" ; -- status=guess, src=wikt
lin brake_N = mkN "rem" | mkN "remmen {p}" | mkN "remmer" masculine ; -- status=guess status=guess status=guess
lin asylum_N = mkN "psychiatrische instelling" feminine ; -- status=guess
lin obscure_V2 = variants{} ; -- 
lin nun_N = mkN "noen" ; -- status=guess
lin heap_N = mkN "hoop" masculine ; -- status=guess
lin smoothly_Adv = variants{} ; -- 
lin rhetoric_N = mkN "redekunde" feminine | mkN "retorica" feminine | mkN "retoriek" feminine ; -- status=guess status=guess status=guess
lin privileged_A = variants{} ; -- 
lin liaison_N = variants{} ; -- 
lin jockey_N = variants{} ; -- 
lin concrete_N = mkN "beton" neuter ; -- status=guess
lin allied_A = variants{} ; -- 
lin rob_V2 = mkV2 (mkV "beroven") | mkV2 (mkV "bestelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin indulge_V2 = mkV2 (mkV (mkV "uitstel") "van betaling toestaan") ; -- status=guess, src=wikt
lin indulge_V = mkV (mkV "uitstel") "van betaling toestaan" ; -- status=guess, src=wikt
lin except_Prep = S.except_Prep ;
lin distort_V2 = mkV2 (mkV "vervormen") ; -- status=guess, src=wikt
lin whatsoever_Adv = variants{} ; -- 
lin viable_A = mkA "levensvatbaar" ; -- status=guess
lin nucleus_N = mkN "kern" masculine ; -- status=guess
lin exaggerate_V2 = mkV2 (mkV "overdrijven") ; -- status=guess, src=wikt
lin exaggerate_V = mkV "overdrijven" ; -- status=guess, src=wikt
lin compact_N = mkN "cd" masculine ; -- status=guess
lin nationality_N = mkN "nationaliteit" feminine | mkN "staatsburgerschap" neuter ; -- status=guess status=guess
lin direct_Adv = variants{} ; -- 
lin cast_N = mkN "rolverdeling" feminine | mkN "casten" neuter | mkN "casting" feminine ; -- status=guess status=guess status=guess
lin altar_N = mkN "altaar" neuter ; -- status=guess
lin refuge_N = mkN "schuilplaats" ; -- status=guess
lin presently_Adv = mkAdv "aldra" ; -- status=guess
lin mandatory_A = mkA "verplicht" | mkA "nodig" ; -- status=guess status=guess
lin authorize_V2V = mkV2V (mkV "machtigen") | mkV2V (mkV "vergunnen") | mkV2V (mkV "authoriseren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin authorize_V2 = mkV2 (mkV "machtigen") | mkV2 (mkV "vergunnen") | mkV2 (mkV "authoriseren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accomplish_V2 = mkV2 (mkV "volbrengen") ; -- status=guess, src=wikt
lin startle_V2 = mkV2 (mkV (mkV "laten") "schrikken") ; -- status=guess, src=wikt
lin indigenous_A = mkA "inheems" | mkA "autochtoon" | mkA "oorspronkelijk" ; -- status=guess status=guess status=guess
lin worse_Adv = variants{} ; -- 
lin retailer_N = mkN "middenstander" masculine ; -- status=guess
lin compound_V2 = variants{} ; -- 
lin compound_V = variants{} ; -- 
lin admiration_N = mkN "bewondering" feminine ; -- status=guess
lin absurd_A = mkA "absurd" ; -- status=guess
lin coincidence_N = variants{} ; -- 
lin principally_Adv = variants{} ; -- 
lin passport_N = mkN "paspoort" neuter ; -- status=guess
lin depot_N = variants{} ; -- 
lin soften_V2 = mkV2 (mkV "verzachten") ; -- status=guess, src=wikt
lin soften_V = mkV "verzachten" ; -- status=guess, src=wikt
lin secretion_N = variants{} ; -- 
lin invoke_V2 = mkV2 (mkV "inroepen") ; -- status=guess, src=wikt
lin dirt_N = variants{} ; -- 
lin scared_A = mkA "bang" ; -- status=guess
lin mug_N = mkN "beker" masculine | mkN "mok" feminine ; -- status=guess status=guess
lin convenience_N = variants{} ; -- 
lin calm_N = mkN "stilte voor de storm" ; -- status=guess
lin optional_A = variants{} ; -- 
lin unsuccessful_A = variants{} ; -- 
lin consistency_N = mkN "samenhang" masculine ; -- status=guess
lin umbrella_N = mkN "paraplu" | mkN "regenscherm" ; -- status=guess status=guess
lin solo_N = mkN "solo" ; -- status=guess
lin hemisphere_N = mkN "halfrond" neuter | mkN "hemisfeer" masculine ; -- status=guess status=guess
lin extreme_N = mkN "uiterste" neuter ; -- status=guess
lin brandy_N = mkN "brandewijn" ; -- status=guess
lin belly_N = L.belly_N ;
lin attachment_N = mkN "gehechtheid" feminine ; -- status=guess
lin wash_N = variants{} ; -- 
lin uncover_V2 = variants{} ; -- 
lin treat_N = variants{} ; -- 
lin repeated_A = variants{} ; -- 
lin pine_N = mkN "pijnboom" utrum | mkN "den" ; -- status=guess status=guess
lin offspring_N = mkN "voortbrengst" | mkN "productie" ; -- status=guess status=guess
lin communism_N = mkN "communisme" neuter ; -- status=guess
lin nominate_V2 = variants{} ; -- 
lin soar_V2 = mkV2 (mkV "zweven") ; -- status=guess, src=wikt
lin soar_V = mkV "zweven" ; -- status=guess, src=wikt
lin geological_A = variants{} ; -- 
lin frog_N = mkN "kikker" masculine | mkN "kikvors" masculine ; -- status=guess status=guess
lin donate_V2 = variants{} ; -- 
lin donate_V = variants{} ; -- 
lin cooperative_A = mkA "samenwerkend" ; -- status=guess
lin nicely_Adv = variants{} ; -- 
lin innocence_N = mkN "onschuld" ; -- status=guess
lin housewife_N = mkN "huisvrouw" feminine ; -- status=guess
lin disguise_V2 = mkV2 (mkV "vermommen") | mkV2 (mkV "verhullen") ; -- status=guess, src=wikt status=guess, src=wikt
lin demolish_V2 = mkV2 (mkV "slopen") ; -- status=guess, src=wikt
lin counsel_N = variants{} ; -- 
lin cord_N = mkN "touw" neuter | mkN "koord" feminine | mkN "zeel" neuter ; -- status=guess status=guess status=guess
lin semi_final_N = variants{} ; -- 
lin reasoning_N = mkN "redenering" feminine ; -- status=guess
lin litre_N = mkN "liter" ; -- status=guess
lin inclined_A = variants{} ; -- 
lin evoke_V2 = mkV2 (mkV "oproepen") ; -- status=guess, src=wikt
lin courtyard_N = mkN "binnenplaats" ; -- status=guess
lin arena_N = variants{} ; -- 
lin simplicity_N = variants{} ; -- 
lin inhibition_N = mkN "remming" feminine ; -- status=guess
lin frozen_A = mkA "bevroren" ; -- status=guess
lin vacuum_N = mkN "vacuüm" neuter ; -- status=guess
lin immigrant_N = mkN "inwijkeling" masculine | mkN "ingewekene" | mkN "immigrant" masculine ; -- status=guess status=guess status=guess
lin bet_N = mkN "waarschijnlijkheid" feminine ; -- status=guess
lin revenge_N = mkN "wraak" feminine ; -- status=guess
lin jail_V2 = variants{} ; -- 
lin helmet_N = mkN "helm" masculine ; -- status=guess
lin unclear_A = mkA "onduidelijk" ; -- status=guess
lin jerk_V2 = mkV2 (mkV "rukken") ; -- status=guess, src=wikt
lin jerk_V = mkV "rukken" ; -- status=guess, src=wikt
lin disruption_N = mkN "onderbreking" feminine | mkN "ontregeling" feminine ; -- status=guess status=guess
lin attainment_N = variants{} ; -- 
lin sip_V2 = variants{} ; -- 
lin sip_V = variants{} ; -- 
lin program_V2V = mkV2V (mkV "programmeren") ; -- status=guess, src=wikt
lin program_V2 = mkV2 (mkV "programmeren") ; -- status=guess, src=wikt
lin lunchtime_N = variants{} ; -- 
lin cult_N = variants{} ; -- 
lin chat_N = mkN "tapuit" masculine ; -- status=guess
lin accord_N = mkN "akkoord" neuter ; -- status=guess
lin supposedly_Adv = variants{} ; -- 
lin offering_N = variants{} ; -- 
lin broadcast_N = mkN "uitzending" ; -- status=guess
lin secular_A = mkA "seculier" ; -- status=guess
lin overwhelm_V2 = mkV2 (mkV "overweldigen") ; -- status=guess, src=wikt
lin momentum_N = mkN "vaart" masculine feminine ; -- status=guess
lin infinite_A = mkA "oneindig" | mkA "eindeloos" ; -- status=guess status=guess
lin manipulation_N = mkN "manipulatie" feminine | mkN "misbruik" neuter ; -- status=guess status=guess
lin inquest_N = variants{} ; -- 
lin decrease_N = variants{} ; -- 
lin cellar_N = mkN "kelderdeur" ; -- status=guess
lin counsellor_N = variants{} ; -- 
lin avenue_N = mkN "weg" | mkN "laan" ; -- status=guess status=guess
lin rubber_A = variants{} ; -- 
lin labourer_N = variants{} ; -- 
lin lab_N = variants{} ; -- 
lin damn_V2 = variants{} ; -- 
lin comfortably_Adv = variants{} ; -- 
lin tense_A = mkA "gespannen" | mkA "strak" ; -- status=guess status=guess
lin socket_N = mkN "kas" masculine | mkN "kom" masculine ; -- status=guess status=guess
lin par_N = variants{} ; -- 
lin thrust_N = mkN "steek" masculine ; -- status=guess
lin scenario_N = mkN "scenario" ; -- status=guess
lin frankly_Adv = mkAdv "ronduit" ; -- status=guess
lin slap_V2 = mkV2 (mkV "neerkwakken") ; -- status=guess, src=wikt
lin recreation_N = mkN "recreatie" feminine | mkN "ontspanning" feminine ; -- status=guess status=guess
lin rank_V2 = variants{} ; -- 
lin rank_V = variants{} ; -- 
lin spy_N = mkN "spion" masculine | mkN "spionne" feminine ; -- status=guess status=guess
lin filter_V2 = mkV2 (mkV "sijpelen") | mkV2 (mkV "druppelen") ; -- status=guess, src=wikt status=guess, src=wikt
lin filter_V = mkV "sijpelen" | mkV "druppelen" ; -- status=guess, src=wikt status=guess, src=wikt
lin clearance_N = variants{} ; -- 
lin blessing_N = mkN "zegen" feminine ; -- status=guess
lin embryo_N = mkN "kiemplant" ; -- status=guess
lin varied_A = variants{} ; -- 
lin predictable_A = mkA "voorspelbaar" ; -- status=guess
lin mutation_N = variants{} ; -- 
lin equal_V2 = mkV2 (mkV (mkV "gelijk") "zijn aan") ; -- status=guess, src=wikt
lin can_1_VV = S.can_VV ;
lin can_2_VV = S.can8know_VV ;
lin can_V2 = mkV2 (mkV "mogen") ; -- status=guess, src=wikt
lin burst_N = variants{} ; -- 
lin retrieve_V2 = mkV2 (mkV "redden") ; -- status=guess, src=wikt
lin retrieve_V = mkV "redden" ; -- status=guess, src=wikt
lin elder_N = mkN "ouderling" masculine ; -- status=guess
lin rehearsal_N = mkN "repetitie" ; -- status=guess
lin optical_A = mkA "optisch" ; -- status=guess
lin hurry_N = variants{} ; -- 
lin conflict_V = mkV "conflicteren" | mkV "confligeren" | mkV (mkV "strijdig") "zijn" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin combat_V2 = mkV2 (vechten_V) ; -- status=guess, src=wikt
lin combat_V = vechten_V ; -- status=guess, src=wikt
lin absorption_N = mkN "absorptie" feminine ; -- status=guess
lin ion_N = mkN "ion" ; -- status=guess
lin wrong_Adv = mkAdv "fout" | mkAdv "foutief" | mkAdv "verkeerd" | mkAdv "onjuist" ; -- status=guess status=guess status=guess status=guess
lin heroin_N = mkN "heroïne" feminine ; -- status=guess
lin bake_V2 = mkV2 (bakken_V) ; -- status=guess, src=wikt
lin bake_V = bakken_V ; -- status=guess, src=wikt
lin x_ray_N = variants{} ; -- 
lin vector_N = mkN "koers" feminine ; -- status=guess
lin stolen_A = variants{} ; -- 
lin sacrifice_V2 = mkV2 (mkV "offeren") ; -- status=guess, src=wikt
lin sacrifice_V = mkV "offeren" ; -- status=guess, src=wikt
lin robbery_N = variants{} ; -- 
lin probe_V2 = variants{} ; -- 
lin probe_V = variants{} ; -- 
lin organizational_A = variants{} ; -- 
lin chalk_N = mkN "krijt" neuter | mkN "krijtje" neuter ; -- status=guess status=guess
lin bourgeois_A = variants{} ; -- 
lin villager_N = variants{} ; -- 
lin morale_N = variants{} ; -- 
lin express_A = mkA "snel" ; -- status=guess
lin climb_N = variants{} ; -- 
lin notify_V2 = mkV2 (mkV "mededelen") | mkV2 (mkV "waarschuwen") | mkV2 (mkV "notificeren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin jam_N = mkN "opstopping" feminine ; -- status=guess
lin bureaucratic_A = variants{} ; -- 
lin literacy_N = mkN "alfabetisering" | mkN "alfabetisme" ; -- status=guess status=guess
lin frustrate_V2 = mkV2 (mkV "frustreren") ; -- status=guess, src=wikt
lin freight_N = mkN "vracht" masculine | mkN "cargo" masculine ; -- status=guess status=guess
lin clearing_N = variants{} ; -- 
lin aviation_N = mkN "luchtvaart" feminine ; -- status=guess
lin legislature_N = mkN "wetgevende macht " masculine ; -- status=guess
lin curiously_Adv = variants{} ; -- 
lin banana_N = mkN "bananengeel" neuter ; -- status=guess
lin deploy_V2 = variants{} ; -- 
lin deploy_V = variants{} ; -- 
lin passionate_A = variants{} ; -- 
lin monastery_N = mkN "klooster" neuter ; -- status=guess
lin kettle_N = mkN "ketel" utrum ; -- status=guess
lin enjoyable_A = variants{} ; -- 
lin diagnose_V2 = variants{} ; -- 
lin quantitative_A = variants{} ; -- 
lin distortion_N = variants{} ; -- 
lin monarch_N = mkN "monarch" masculine ; -- status=guess
lin kindly_Adv = mkAdv "vriendelijk" | mkAdv "beminnelijk" ; -- status=guess status=guess
lin glow_V = mkV "gloeien" ; -- status=guess, src=wikt
lin acquaintance_N = mkN "kennis" masculine | mkN "bekende" masculine ; -- status=guess status=guess
lin unexpectedly_Adv = mkAdv "onverwachts" ; -- status=guess
lin handy_A = mkA "handig" ; -- status=guess
lin deprivation_N = mkN "ontberingen" ; -- status=guess
lin attacker_N = mkN "aanvaller" masculine ; -- status=guess
lin assault_V2 = mkV2 (mkV "aanranden") | mkV2 (mkV "vergrijpen") ; -- status=guess, src=wikt status=guess, src=wikt
lin screening_N = variants{} ; -- 
lin retired_A = variants{} ; -- 
lin quick_Adv = variants{} ; -- 
lin portable_A = mkA "draagbaar" ; -- status=guess
lin hostage_N = mkN "gijzelaar" masculine ; -- status=guess
lin underneath_Prep = variants{} ; -- 
lin jealous_A = mkA "jaloers" ; -- status=guess
lin proportional_A = mkA "evenredig" ; -- status=guess
lin gown_N = mkN "toga" feminine ; -- status=guess
lin chimney_N = mkN "schoorsteen" masculine ; -- status=guess
lin bleak_A = mkA "vreugdeloos" ; -- status=guess
lin seasonal_A = variants{} ; -- 
lin plasma_N = mkN "plasma" neuter ; -- status=guess
lin stunning_A = variants{} ; -- 
lin spray_N = variants{} ; -- 
lin referral_N = mkN "verwijzing" ; -- status=guess
lin promptly_Adv = variants{} ; -- 
lin fluctuation_N = mkN "schommeling" feminine ; -- status=guess
lin decorative_A = mkA "decoratief" ; -- status=guess
lin unrest_N = mkN "onrust" utrum ; -- status=guess
lin resent_VS = mkVS (mkV (mkV "zijn") "ongenoegen uiten") | mkVS (reflMkV "storen aan") ; -- status=guess, src=wikt status=guess, src=wikt
lin resent_V2 = mkV2 (mkV (mkV "zijn") "ongenoegen uiten") | mkV2 (reflMkV "storen aan") ; -- status=guess, src=wikt status=guess, src=wikt
lin plaster_N = variants{} ; -- 
lin chew_V2 = mkV2 (mkV "kauwen") ; -- status=guess, src=wikt
lin chew_V = mkV "kauwen" ; -- status=guess, src=wikt
lin grouping_N = variants{} ; -- 
lin gospel_N = mkN "evangelie" neuter ; -- status=guess
lin distributor_N = mkN "verspreider" masculine ; -- status=guess
lin differentiation_N = variants{} ; -- 
lin blonde_A = variants{} ; -- 
lin aquarium_N = variants{} ; -- 
lin witch_N = mkN "heks" feminine | mkN "kol" feminine ; -- status=guess status=guess
lin renewed_A = variants{} ; -- 
lin jar_N = variants{} ; -- 
lin approved_A = variants{} ; -- 
lin advocateMasc_N = mkN "advocaat" masculine | mkN "advocate" feminine | mkN "verdediger" masculine | mkN "verdedigster" feminine ; -- status=guess status=guess status=guess status=guess
lin worrying_A = variants{} ; -- 
lin minimize_V2 = variants{} ; -- 
lin footstep_N = mkN "pas" masculine ; -- status=guess
lin delete_V2 = variants{} ; -- 
lin underneath_Adv = variants{} ; -- 
lin lone_A = mkA "alleen" ; -- status=guess
lin level_V2 = mkV2 (mkV "egaliseren") ; -- status=guess, src=wikt
lin level_V = mkV "egaliseren" ; -- status=guess, src=wikt
lin exceptionally_Adv = variants{} ; -- 
lin drift_N = variants{} ; -- 
lin spider_N = mkN "spin" feminine | mkN "kobbe" feminine ; -- status=guess status=guess
lin hectare_N = mkN "hectare" | mkN "bunder" ; -- status=guess status=guess
lin colonel_N = mkN "kolonel" masculine ; -- status=guess
lin swimming_N = mkN "zwemmen" ; -- status=guess
lin realism_N = mkN "realisme" ; -- status=guess
lin insider_N = variants{} ; -- 
lin hobby_N = mkN "hobby" feminine | mkN "vrijetijdsbesteding" feminine ; -- status=guess status=guess
lin computing_N = mkN "computeren" | mkN "computergebruik" neuter ; -- status=guess status=guess
lin infrastructure_N = variants{} ; -- 
lin cooperate_V = mkV "samenwerken" ; -- status=guess, src=wikt
lin burn_N = mkN "brandwond" feminine | mkN "verbranding" feminine ; -- status=guess status=guess
lin cereal_N = variants{} ; -- 
lin fold_N = mkN "plooi" masculine feminine ; -- status=guess
lin compromise_V2 = mkV2 (mkV "compromitteren") ; -- status=guess, src=wikt
lin compromise_V = mkV "compromitteren" ; -- status=guess, src=wikt
lin boxing_N = mkN "boksen" ; -- status=guess
lin rear_V2 = mkV2 (mkV "kweken") ; -- status=guess, src=wikt
lin rear_V = mkV "kweken" ; -- status=guess, src=wikt
lin lick_V2 = mkV2 (mkV "likken") ; -- status=guess, src=wikt
lin constrain_V2 = variants{} ; -- 
lin clerical_A = variants{} ; -- 
lin hire_N = mkN "werknemer" | mkN "werknemer" masculine ; -- status=guess status=guess
lin contend_VS = variants{} ; -- 
lin contend_V = variants{} ; -- 
lin amateurMasc_N = mkN "niet-professioneel" ; -- status=guess
lin instrumental_A = mkA "instrumentaal" ; -- status=guess
lin terminal_A = variants{} ; -- 
lin electorate_N = mkN "keurvorstendom" neuter ; -- status=guess
lin congratulate_V2 = mkV2 (mkV "feliciteren") | mkV2 (mkV "gelukwensen") ; -- status=guess, src=wikt status=guess, src=wikt
lin balanced_A = variants{} ; -- 
lin manufacturing_N = variants{} ; -- 
lin split_N = mkN "grand écart" masculine | mkN "spagaat" | mkN "split" masculine ; -- status=guess status=guess status=guess
lin domination_N = mkN "overheersing" feminine ; -- status=guess
lin blink_V2 = mkV2 (mkV "knipperen") ; -- status=guess, src=wikt
lin blink_V = mkV "knipperen" ; -- status=guess, src=wikt
lin bleed_VS = mkVS (mkV "bloeden") ; -- status=guess, src=wikt
lin bleed_V2 = mkV2 (mkV "bloeden") ; -- status=guess, src=wikt
lin bleed_V = mkV "bloeden" ; -- status=guess, src=wikt
lin unlawful_A = mkA "verboden" | mkA "illegaal" | mkA "onwettig" | mkA "wederrechtelijk" ; -- status=guess status=guess status=guess status=guess
lin precedent_N = mkN "precedent" ; -- status=guess
lin notorious_A = mkA "berucht" | mkA "beruchte" | mkA "notoir" ; -- status=guess status=guess status=guess
lin indoor_A = variants{} ; -- 
lin upgrade_V2 = mkV2 (mkV "upgraden") ; -- status=guess, src=wikt
lin trench_N = mkN "lange jas" ; -- status=guess
lin therapist_N = mkN "therapeut" ; -- status=guess
lin illuminate_V2 = mkV2 (mkV "verhelderen") ; -- status=guess, src=wikt
lin bargain_V2 = variants{} ; -- 
lin bargain_V = variants{} ; -- 
lin warranty_N = mkN "garantie" ; -- status=guess
lin scar_V2 = variants{} ; -- 
lin scar_V = variants{} ; -- 
lin consortium_N = mkN "consortium" neuter ; -- status=guess
lin anger_V2 = variants{} ; -- 
lin insure_VS = mkVS (mkV "verzekeren") | mkVS (mkV (mkV "borgen") "voor") ; -- status=guess, src=wikt status=guess, src=wikt
lin insure_V2 = mkV2 (mkV "verzekeren") | mkV2 (mkV (mkV "borgen") "voor") ; -- status=guess, src=wikt status=guess, src=wikt
lin insure_V = mkV "verzekeren" | mkV (mkV "borgen") "voor" ; -- status=guess, src=wikt status=guess, src=wikt
lin extensively_Adv = mkAdv "uitvoerig" | mkAdv "uitgebreid" ; -- status=guess status=guess
lin appropriately_Adv = variants{} ; -- 
lin spoon_N = mkN "lepel" masculine ; -- status=guess
lin sideways_Adv = mkAdv "zijwaarts" ; -- status=guess
lin enhanced_A = mkA "versterkt" ; -- status=guess
lin disrupt_V2 = mkV2 (mkV "onderbreken") ; -- status=guess, src=wikt
lin disrupt_V = mkV "onderbreken" ; -- status=guess, src=wikt
lin satisfied_A = mkA "voldaan" | mkA "tevreden" ; -- status=guess status=guess
lin precaution_N = mkN "voorzorg" | mkN "voorzorgsmaatregel" ; -- status=guess status=guess
lin kite_N = mkN "vlieger" ; -- status=guess
lin instant_N = mkN "koffiepoeder" masculine ; -- status=guess
lin gig_N = mkN "optreden" neuter | mkN "schnabbel" masculine | mkN "concert" neuter ; -- status=guess status=guess status=guess
lin continuously_Adv = mkAdv "continu" ; -- status=guess
lin consolidate_V2 = variants{} ; -- 
lin consolidate_V = variants{} ; -- 
lin fountain_N = mkN "fontein" feminine ; -- status=guess
lin graduate_V2 = mkV2 (mkV "promoveren") | mkV2 (mkV "afstuderen") ; -- status=guess, src=wikt status=guess, src=wikt
lin graduate_V = mkV "promoveren" | mkV "afstuderen" ; -- status=guess, src=wikt status=guess, src=wikt
lin gloom_N = mkN "duisternis" feminine ; -- status=guess
lin bite_N = mkN "bijten" neuter ; -- status=guess
lin structure_V2 = mkV2 (mkV "structureren") ; -- status=guess, src=wikt
lin noun_N = mkN "zelfstandig naamwoord" neuter | mkN "substantief" neuter ; -- status=guess status=guess
lin nomination_N = mkN "nominatie" feminine ; -- status=guess
lin armchair_N = mkN "fauteuil" masculine ; -- status=guess
lin virtual_A = mkA "virtueel" ; -- status=guess
lin unprecedented_A = mkA "zonder precedent" ; -- status=guess
lin tumble_V2 = mkV2 (mkV "tuimelen") ; -- status=guess, src=wikt
lin tumble_V = mkV "tuimelen" ; -- status=guess, src=wikt
lin ski_N = mkN "ski" masculine ; -- status=guess
lin architectural_A = variants{} ; -- 
lin violation_N = mkN "overtreding" feminine | mkN "schending" feminine ; -- status=guess status=guess
lin rocket_N = mkN "raket" ; -- status=guess
lin inject_V2 = mkV2 (mkV "injecteren") | mkV2 (mkV "inspuiten") ; -- status=guess, src=wikt status=guess, src=wikt
lin departmental_A = variants{} ; -- 
lin row_V2 = mkV2 (mkV "roeien") ; -- status=guess, src=wikt
lin row_V = mkV "roeien" ; -- status=guess, src=wikt
lin luxury_A = variants{} ; -- 
lin fax_N = mkN "fax" masculine ; -- status=guess
lin deer_N = mkN "hert" neuter ; -- status=guess
lin climber_N = mkN "klimmer" masculine | mkN "beklimmer" masculine ; -- status=guess status=guess
lin photographic_A = mkA "fotografisch" ; -- status=guess
lin haunt_V2 = mkV2 (mkV "rondspoken") ; -- status=guess, src=wikt
lin fiercely_Adv = variants{} ; -- 
lin dining_N = mkN "eetkamer de" ; -- status=guess
lin sodium_N = mkN "natrium" neuter ; -- status=guess
lin gossip_N = mkN "kletspraatje" | mkN "roddel" ; -- status=guess status=guess
lin bundle_N = mkN "spierbundel" neuter ; -- status=guess
lin bend_N = mkN "bocht" masculine ; -- status=guess
lin recruit_N = mkN "rekruut" ; -- status=guess
lin hen_N = mkN "wijfje" neuter | mkN "hen" feminine ; -- status=guess status=guess
lin fragile_A = mkA "broos" ; -- status=guess
lin deteriorate_V2 = mkV2 (mkV "verslechteren") ; -- status=guess, src=wikt
lin deteriorate_V = mkV "verslechteren" ; -- status=guess, src=wikt
lin dependency_N = mkN "kolonie" feminine | mkN "schutgebied" neuter ; -- status=guess status=guess
lin swift_A = variants{} ; -- 
lin scramble_V2 = variants{} ; -- 
lin scramble_V = variants{} ; -- 
lin overview_N = mkN "overzicht" ; -- status=guess
lin imprison_V2 = variants{} ; -- 
lin trolley_N = mkN "trolleybus" masculine ; -- status=guess
lin rotation_N = mkN "draaiing" feminine ; -- status=guess
lin denial_N = variants{} ; -- 
lin boiler_N = variants{} ; -- 
lin amp_N = variants{} ; -- 
lin trivial_A = mkA "onbeduidend" ; -- status=guess
lin shout_N = mkN "schreeuw" masculine ; -- status=guess
lin overtake_V2 = mkV2 (mkV "inhalen") ; -- status=guess, src=wikt
lin make_N = mkN "merk" neuter ; -- status=guess
lin hunter_N = mkN "jachthond" masculine ; -- status=guess
lin guess_N = mkN "gok" masculine | mkN "gissing" feminine | mkN "veronderstelling" feminine | mkN "raden" | mkN "denk" ; -- status=guess status=guess status=guess status=guess status=guess
lin doubtless_Adv = variants{} ; -- 
lin syllable_N = mkN "lettergreep" feminine ; -- status=guess
lin obscure_A = mkA "duister" ; -- status=guess
lin mould_N = variants{} ; -- 
lin limestone_N = mkN "kalksteen" ; -- status=guess
lin leak_V2 = mkV2 (mkV "lekken") ; -- status=guess, src=wikt
lin leak_V = mkV "lekken" ; -- status=guess, src=wikt
lin beneficiary_N = mkN "begunstigde" masculine feminine ; -- status=guess
lin veteran_N = mkN "veteraan" masculine | mkN "oud-strijder" masculine ; -- status=guess status=guess
lin surplus_A = variants{} ; -- 
lin manifestation_N = mkN "manifestatie" ; -- status=guess
lin vicar_N = mkN "pastoor" masculine ; -- status=guess
lin textbook_N = mkN "studieboek" ; -- status=guess
lin novelist_N = mkN "romancier" masculine | mkN "romanschrijver" masculine ; -- status=guess status=guess
lin halfway_Adv = mkAdv "halfweg" ; -- status=guess
lin contractual_A = variants{} ; -- 
lin swap_V2 = variants{} ; -- 
lin swap_V = variants{} ; -- 
lin guild_N = mkN "gilde" neuter ; -- status=guess
lin ulcer_N = mkN "zweer" feminine ; -- status=guess
lin slab_N = variants{} ; -- 
lin detector_N = variants{} ; -- 
lin detection_N = variants{} ; -- 
lin cough_V = mkV "hoesten" | mkV "kuchen" ; -- status=guess, src=wikt status=guess, src=wikt
lin whichever_Quant = variants{} ; -- 
lin spelling_N = mkN "spelling" feminine ; -- status=guess
lin lender_N = variants{} ; -- 
lin glow_N = mkN "gloed" masculine ; -- status=guess
lin raised_A = variants{} ; -- 
lin prolonged_A = variants{} ; -- 
lin voucher_N = mkN "bon" masculine ; -- status=guess
lin t_shirt_N = variants{} ; -- 
lin linger_V = mkV "weifelen" ; -- status=guess, src=wikt
lin humble_A = mkA "bescheiden" | mkA "modest" ; -- status=guess status=guess
lin honey_N = mkN "honingdas" masculine ; -- status=guess
lin scream_N = mkN "schreeuw" masculine ; -- status=guess
lin postcard_N = mkN "briefkaart" ; -- status=guess
lin managing_A = variants{} ; -- 
lin alien_A = variants{} ; -- 
lin trouble_V2 = variants{} ; -- 
lin reverse_N = mkN "achteruit" ; -- status=guess
lin odour_N = mkN "reuk" feminine ; -- status=guess
lin fundamentally_Adv = variants{} ; -- 
lin discount_V2 = variants{} ; -- 
lin discount_V = variants{} ; -- 
lin blast_V2 = variants{} ; -- 
lin blast_V = variants{} ; -- 
lin syntactic_A = mkA "syntactisch" ; -- status=guess
lin scrape_V2 = variants{} ; -- 
lin scrape_V = variants{} ; -- 
lin residue_N = variants{} ; -- 
lin procession_N = mkN "processie" feminine | mkN "stoet" feminine ; -- status=guess status=guess
lin pioneer_N = mkN "pioneer" masculine ; -- status=guess
lin intercourse_N = mkN "betrekkingen {p}" ; -- status=guess
lin deter_V2 = mkV2 (mkV "ontmoedigen") ; -- status=guess, src=wikt
lin deadly_A = mkA "dodelijk" ; -- status=guess
lin complement_V2 = mkV2 (mkV "aanvullen") | mkV2 (mkV "volmaken") ; -- status=guess, src=wikt status=guess, src=wikt
lin restrictive_A = mkA "beperkend" ; -- status=guess
lin nitrogen_N = mkN "stikstof" feminine ; -- status=guess
lin citizenship_N = mkN "burgerschap" neuter ; -- status=guess
lin pedestrian_N = mkN "voetganger" masculine ; -- status=guess
lin detention_N = mkN "hechtenis" feminine ; -- status=guess
lin wagon_N = mkN "wagen" ; -- status=guess
lin microphone_N = mkN "microfoon" masculine ; -- status=guess
lin hastily_Adv = variants{} ; -- 
lin fixture_N = variants{} ; -- 
lin choke_V2 = mkV2 (mkV "verstikken") ; -- status=guess, src=wikt
lin choke_V = mkV "verstikken" ; -- status=guess, src=wikt
lin wet_V2 = mkV2 (mkV "natmaken") ; -- status=guess, src=wikt
lin weed_N = mkN "kroos" ; -- status=guess
lin programming_N = mkN "programmeren" ; -- status=guess
lin power_V2 = mkV2 (mkV "voeden") ; -- status=guess, src=wikt
lin nationally_Adv = variants{} ; -- 
lin dozen_N = mkN "tientallen {p}" ; -- status=guess
lin carrot_N = mkN "wortel" masculine | mkN "peen" masculine ; -- status=guess status=guess
lin bulletin_N = mkN "bulletin board system" neuter ; -- status=guess
lin wording_N = mkN "woordkeuze" | mkN "verwoording" feminine | mkN "formulering" feminine ; -- status=guess status=guess status=guess
lin vicious_A = variants{} ; -- 
lin urgency_N = variants{} ; -- 
lin spoken_A = mkA "gesproken" ; -- status=guess
lin skeleton_N = mkN "skelet" neuter | mkN "geraamte" neuter ; -- status=guess status=guess
lin motorist_N = mkN "automobilist" masculine ; -- status=guess
lin interactive_A = variants{} ; -- 
lin compute_V2 = mkV2 (mkV "uitrekenen") | mkV2 (mkV "berekenen") ; -- status=guess, src=wikt status=guess, src=wikt
lin compute_V = mkV "uitrekenen" | mkV "berekenen" ; -- status=guess, src=wikt status=guess, src=wikt
lin whip_N = mkN "zweep" ; -- status=guess
lin urgently_Adv = variants{} ; -- 
lin telly_N = variants{} ; -- 
lin shrub_N = mkN "struik" | mkN "heester" feminine ; -- status=guess status=guess
lin porter_N = variants{} ; -- 
lin ethics_N = mkN "zedenkunde" feminine | mkN "ethiek" feminine ; -- status=guess status=guess
lin banner_N = mkN "vlag" neuter | mkN "banier" neuter ; -- status=guess status=guess
lin velvet_N = mkN "fluweel" ; -- status=guess
lin omission_N = mkN "weglating" feminine ; -- status=guess
lin hook_V2 = mkV2 (mkV "verslaven") ; -- status=guess, src=wikt
lin hook_V = mkV "verslaven" ; -- status=guess, src=wikt
lin gallon_N = variants{} ; -- 
lin financially_Adv = variants{} ; -- 
lin superintendent_N = mkN "hoofdopzichter" masculine ; -- status=guess
lin plug_V2 = variants{} ; -- 
lin plug_V = variants{} ; -- 
lin continuation_N = mkN "voortzetting" feminine ; -- status=guess
lin reliance_N = variants{} ; -- 
lin justified_A = variants{} ; -- 
lin fool_V2 = mkV2 (bedriegen_V) | mkV2 (mkV (mkV "in") "de maling nemen") ; -- status=guess, src=wikt status=guess, src=wikt
lin detain_V2 = mkV2 (mkV "detineren") ; -- status=guess, src=wikt
lin damaging_A = variants{} ; -- 
lin orbit_N = mkN "baan" feminine ; -- status=guess
lin mains_N = variants{} ; -- 
lin discard_V2 = variants{} ; -- 
lin dine_V = mkV "dineren" ; -- status=guess, src=wikt
lin compartment_N = variants{} ; -- 
lin revised_A = variants{} ; -- 
lin privatization_N = mkN "privatisering" feminine ; -- status=guess
lin memorable_A = mkA "memorabel" | mkA "gedenkwaardig" ; -- status=guess status=guess
lin lately_Adv = variants{} ; -- 
lin distributed_A = variants{} ; -- 
lin disperse_V2 = mkV2 (mkV "verbreiden") ; -- status=guess, src=wikt
lin disperse_V = mkV "verbreiden" ; -- status=guess, src=wikt
lin blame_N = mkN "schuld" feminine ; -- status=guess
lin basement_N = mkN "kelder" masculine ; -- status=guess
lin slump_V2 = variants{} ; -- 
lin slump_V = variants{} ; -- 
lin puzzle_V2 = mkV2 (mkV "verbijsteren") ; -- status=guess, src=wikt
lin monitoring_N = mkN "controleren" | mkN "toezicht houden" | mkN "volgen" ; -- status=guess status=guess status=guess
lin talented_A = mkA "getalenteerd" ; -- status=guess
lin nominal_A = variants{} ; -- 
lin mushroom_N = mkN "paddenstoel" masculine | mkN "zwam" masculine ; -- status=guess status=guess
lin instructor_N = mkN "leermeester" masculine ; -- status=guess
lin fork_N = mkN "afsplitsing" feminine | mkN "fork" feminine ; -- status=guess status=guess
lin fork_4_N = variants{} ; -- 
lin fork_3_N = variants{} ; -- 
lin fork_1_N = variants{} ; -- 
lin board_V2 = mkV2 (mkV "enteren") ; -- status=guess, src=wikt
lin want_N = mkN "tekort" neuter ; -- status=guess
lin disposition_N = mkN "gezindheid" feminine ; -- status=guess
lin cemetery_N = variants{} ; -- 
lin attempted_A = variants{} ; -- 
lin nephew_N = mkN "neef" masculine ; -- status=guess
lin magical_A = mkA "betoverend" | mkA "magisch" ; -- status=guess status=guess
lin ivory_N = mkN "ivoorkleur" feminine ; -- status=guess
lin hospitality_N = mkN "gastvrijheid" ; -- status=guess
lin besides_Prep = variants{} ; -- 
lin astonishing_A = variants{} ; -- 
lin tract_N = mkN "kanaal" neuter | mkN "stelsel" neuter ; -- status=guess status=guess
lin proprietor_N = mkN "mede-eigenaar" masculine | mkN "partner" masculine ; -- status=guess status=guess
lin license_V2 = mkV2 (mkV "licentiëren") | mkV2 (mkV (mkV "vergunning") "toekennen") ; -- status=guess, src=wikt status=guess, src=wikt
lin differential_A = variants{} ; -- 
lin affinity_N = mkN "welgezindheid" feminine | mkN "affiniteit" ; -- status=guess status=guess
lin talking_N = variants{} ; -- 
lin royalty_N = variants{} ; -- 
lin neglect_N = mkN "verwaarlozing" feminine | mkN "nalatigheid" | mkN "onzorgvuldigheid" ; -- status=guess status=guess status=guess
lin irrespective_A = mkA "ongeacht" ; -- status=guess
lin whip_V2 = mkV2 (mkV "geselen") ; -- status=guess, src=wikt
lin whip_V = mkV "geselen" ; -- status=guess, src=wikt
lin sticky_A = variants{} ; -- 
lin regret_N = mkN "spijt" feminine | mkN "berouw" neuter ; -- status=guess status=guess
lin incapable_A = variants{} ; -- 
lin franchise_N = variants{} ; -- 
lin dentist_N = mkN "tandarts" ; -- status=guess
lin contrary_N = variants{} ; -- 
lin profitability_N = variants{} ; -- 
lin enthusiast_N = variants{} ; -- 
lin crop_V2 = mkV2 (mkV "bijknippen") | mkV2 (mkV "bijsnijden") ; -- status=guess, src=wikt status=guess, src=wikt
lin crop_V = mkV "bijknippen" | mkV "bijsnijden" ; -- status=guess, src=wikt status=guess, src=wikt
lin utter_V2 = mkV2 (mkV "produceren") | mkV2 (mkV "voortbrengen") ; -- status=guess, src=wikt status=guess, src=wikt
lin pile_V2 = mkV2 (mkV "stapelen") ; -- status=guess, src=wikt
lin pile_V = mkV "stapelen" ; -- status=guess, src=wikt
lin pier_N = mkN "pier" masculine ; -- status=guess
lin dome_N = variants{} ; -- 
lin bubble_N = mkN "bel" feminine ; -- status=guess
lin treasurer_N = mkN "penningmeester" ; -- status=guess
lin stocking_N = mkN "kous" feminine ; -- status=guess
lin sanctuary_N = variants{} ; -- 
lin ascertain_V2 = mkV2 (mkV "constateren") | mkV2 (mkV "vaststellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin arc_N = mkN "boog" masculine ; -- status=guess
lin quest_N = mkN "zoektocht" masculine | mkN "streeftocht" masculine ; -- status=guess status=guess
lin mole_N = mkN "mol" masculine ; -- status=guess
lin marathon_N = mkN "marathon" masculine ; -- status=guess
lin feast_N = mkN "feestmaaltijd" neuter ; -- status=guess
lin crouch_V = variants{} ; -- 
lin storm_V2 = variants{} ; -- 
lin storm_V = variants{} ; -- 
lin hardship_N = mkN "ellende" feminine ; -- status=guess
lin entitlement_N = mkN "uitkering" ; -- status=guess
lin circular_N = mkN "cirkelredenering" feminine ; -- status=guess
lin walking_A = variants{} ; -- 
lin strap_N = variants{} ; -- 
lin sore_A = mkA "pijnlijk" ; -- status=guess
lin complementary_A = variants{} ; -- 
lin understandable_A = mkA "begrijpelijk" ; -- status=guess
lin noticeable_A = mkA "opmerkenswaardig" | mkA "opmerkelijk" ; -- status=guess status=guess
lin mankind_N = mkN "mensheid" feminine ; -- status=guess
lin majesty_N = variants{} ; -- 
lin pigeon_N = mkN "duif " masculine | mkN "doffer" masculine | mkN "mannetjesduif" masculine | mkN "duivin" feminine | mkN "vrouwtjesduif" feminine | mkN "duifje" neuter ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin goalkeeper_N = mkN "keeper" masculine feminine | mkN "doelwachter" masculine | mkN "doelwachtster" feminine | mkN "doelman" masculine ; -- status=guess status=guess status=guess status=guess
lin ambiguous_A = mkA "dubbelzinnig" | mkA "ambigu" ; -- status=guess status=guess
lin walker_N = variants{} ; -- 
lin virgin_N = mkN "maagd" feminine | mkN "jufrouw" feminine ; -- status=guess status=guess
lin prestige_N = mkN "aanzien" neuter | mkN "prestige" neuter ; -- status=guess status=guess
lin preoccupation_N = variants{} ; -- 
lin upset_A = mkA "ontdaan" | mkA "geschokt" | mkA "van streek" | mkA "overstuur" ; -- status=guess status=guess status=guess status=guess
lin municipal_A = mkA "gemeentelijk" ; -- status=guess
lin groan_V2 = mkV2 (mkV "zuchten") ; -- status=guess, src=wikt
lin groan_V = mkV "zuchten" ; -- status=guess, src=wikt
lin craftsman_N = mkN "vakman" masculine ; -- status=guess
lin anticipation_N = variants{} ; -- 
lin revise_V2 = mkV2 (mkV "herzien") ; -- status=guess, src=wikt
lin revise_V = mkV "herzien" ; -- status=guess, src=wikt
lin knock_N = mkN "kloppen" neuter | mkN "aankloppen" neuter ; -- status=guess status=guess
lin infect_V2 = mkV2 (mkV "infecteren") ; -- status=guess, src=wikt
lin infect_V = mkV "infecteren" ; -- status=guess, src=wikt
lin denounce_V2 = mkV2 (mkV "opzeggen") ; -- status=guess, src=wikt
lin confession_N = mkN "biecht" ; -- status=guess
lin turkey_N = mkN "kalkoen" masculine ; -- status=guess
lin toll_N = mkN "tolhuis" neuter ; -- status=guess
lin pal_N = variants{} ; -- 
lin transcription_N = variants{} ; -- 
lin sulphur_N = variants{} ; -- 
lin provisional_A = variants{} ; -- 
lin hug_V2 = mkV2 (mkV "knuffelen") ; -- status=guess, src=wikt
lin particular_N = variants{} ; -- 
lin intent_A = variants{} ; -- 
lin fascinate_V2 = variants{} ; -- 
lin conductor_N = mkN "dirigent" masculine ; -- status=guess
lin feasible_A = mkA "mogelijk" | mkA "haalbaar" ; -- status=guess status=guess
lin vacant_A = mkA "leeg" ; -- status=guess
lin trait_N = mkN "karaktereigenschap" ; -- status=guess
lin meadow_N = mkN "weide" ; -- status=guess
lin creed_N = mkN "geloofsbelijdenis" feminine | mkN "credo" neuter ; -- status=guess status=guess
lin unfamiliar_A = variants{} ; -- 
lin optimism_N = variants{} ; -- 
lin wary_A = variants{} ; -- 
lin twist_N = mkN "boorijzer" neuter ; -- status=guess
lin sweet_N = mkN "snoep " neuter | mkN "snoepje" neuter ; -- status=guess status=guess
lin substantive_A = variants{} ; -- 
lin excavation_N = mkN "afgraving" feminine ; -- status=guess
lin destiny_N = mkN "lot" neuter ; -- status=guess
lin thick_Adv = mkAdv "dik" ; -- status=guess
lin pasture_N = mkN "weiland" ; -- status=guess
lin archaeological_A = variants{} ; -- 
lin tick_V2 = mkV2 (mkV "tikken") ; -- status=guess, src=wikt
lin tick_V = mkV "tikken" ; -- status=guess, src=wikt
lin profit_V2 = mkV2 (mkV "verdienen") | mkV2 (mkV (mkV "winst") "maken") | mkV2 (mkV "profiteren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin profit_V = mkV "verdienen" | mkV (mkV "winst") "maken" | mkV "profiteren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pat_V2 = variants{} ; -- 
lin pat_V = variants{} ; -- 
lin papal_A = mkA "pauselijk" ; -- status=guess
lin cultivate_V2 = mkV2 (mkV "telen") | mkV2 (mkV "verbouwen") ; -- status=guess, src=wikt status=guess, src=wikt
lin awake_V = mkV "wekken" ; -- status=guess, src=wikt
lin trained_A = variants{} ; -- 
lin civic_A = mkA "stedelijk" ; -- status=guess
lin voyage_N = mkN "reis" ; -- status=guess
lin siege_N = mkN "belegering" feminine | mkN "beleg" neuter ; -- status=guess status=guess
lin enormously_Adv = variants{} ; -- 
lin distract_V2 = variants{} ; -- 
lin distract_V = variants{} ; -- 
lin stroll_V = mkV "slenteren" | mkV "wandelen" ; -- status=guess, src=wikt status=guess, src=wikt
lin jewel_N = mkN "juweel" neuter ; -- status=guess
lin honourable_A = variants{} ; -- 
lin helpless_A = mkA "hulpeloos" ; -- status=guess
lin hay_N = mkN "hooi" neuter ; -- status=guess
lin expel_V2 = mkV2 (mkV "verdrijven") | mkV2 (mkV "verjagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin eternal_A = mkA "eeuwig" | mkA "eindeloos" ; -- status=guess status=guess
lin demonstrator_N = mkN "betoger" masculine ; -- status=guess
lin correction_N = mkN "verbetering" feminine | mkN "correctie" feminine ; -- status=guess status=guess
lin civilization_N = mkN "civilisatie" ; -- status=guess
lin ample_A = mkA "overvloedig" | mkA "abondant" | mkA "rijkelijk voorhanden" ; -- status=guess status=guess status=guess
lin retention_N = mkN "herinnering" | mkN "memorie" ; -- status=guess status=guess
lin rehabilitation_N = variants{} ; -- 
lin premature_A = variants{} ; -- 
lin encompass_V2 = mkV2 (mkV "bevatten") ; -- status=guess, src=wikt
lin distinctly_Adv = variants{} ; -- 
lin diplomat_N = mkN "diplomaat" masculine ; -- status=guess
lin articulate_V2 = mkV2 (mkV "articuleren") ; -- status=guess, src=wikt
lin articulate_V = mkV "articuleren" ; -- status=guess, src=wikt
lin restricted_A = variants{} ; -- 
lin prop_V2 = variants{} ; -- 
lin intensify_V2 = mkV2 (mkV "intensiveren") ; -- status=guess, src=wikt
lin intensify_V = mkV "intensiveren" ; -- status=guess, src=wikt
lin deviation_N = mkN "afwijken" ; -- status=guess
lin contest_V2 = variants{} ; -- 
lin contest_V = variants{} ; -- 
lin workplace_N = variants{} ; -- 
lin lazy_A = mkA "lui" ; -- status=guess
lin kidney_N = mkN "nier" ; -- status=guess
lin insistence_N = variants{} ; -- 
lin whisper_N = mkN "gefluister" neuter ; -- status=guess
lin multimedia_N = variants{} ; -- 
lin forestry_N = mkN "bosbouw" masculine | mkN "bosbedrijf" neuter ; -- status=guess status=guess
lin excited_A = mkA "opgewonden" ; -- status=guess
lin decay_N = variants{} ; -- 
lin screw_N = mkN "schroef" feminine | mkN "vijs" ; -- status=guess status=guess
lin rally_V2V = mkV2V (mkV "verzamelen") ; -- status=guess, src=wikt
lin rally_V2 = mkV2 (mkV "verzamelen") ; -- status=guess, src=wikt
lin rally_V = mkV "verzamelen" ; -- status=guess, src=wikt
lin pest_N = mkN "pest" | mkN "plaag" ; -- status=guess status=guess
lin invaluable_A = variants{} ; -- 
lin homework_N = mkN "huiswerk" ; -- status=guess
lin harmful_A = mkA "schadelijk" ; -- status=guess
lin bump_V2 = variants{} ; -- 
lin bump_V = variants{} ; -- 
lin bodily_A = variants{} ; -- 
lin grasp_N = mkN "grip" masculine ; -- status=guess
lin finished_A = variants{} ; -- 
lin facade_N = variants{} ; -- 
lin cushion_N = mkN "kussen" neuter ; -- status=guess
lin conversely_Adv = variants{} ; -- 
lin urge_N = mkN "drang" masculine | mkN "aandrang" masculine | mkN "aandrift" feminine ; -- status=guess status=guess status=guess
lin tune_V2 = mkV2 (mkV "afstemmen") | mkV2 (mkV "stemmen") ; -- status=guess, src=wikt status=guess, src=wikt
lin tune_V = mkV "afstemmen" | mkV "stemmen" ; -- status=guess, src=wikt status=guess, src=wikt
lin solvent_N = mkN "oplosmiddel" ; -- status=guess
lin slogan_N = mkN "slagzin" masculine ; -- status=guess
lin petty_A = mkA "onbeduidend" ; -- status=guess
lin perceived_A = variants{} ; -- 
lin install_V2 = mkV2 (reflMkV "installeren") ; -- status=guess, src=wikt
lin install_V = reflMkV "installeren" ; -- status=guess, src=wikt
lin fuss_N = variants{} ; -- 
lin rack_N = mkN "rek" ; -- status=guess
lin imminent_A = mkA "imminent" | mkA "dreigend" ; -- status=guess status=guess
lin short_N = mkN "kortsluiting" feminine ; -- status=guess
lin revert_V = variants{} ; -- 
lin ram_N = mkN "ram" masculine ; -- status=guess
lin contraction_N = variants{} ; -- 
lin tread_V2 = mkV2 (mkV "stampen") | mkV2 (mkV "vertrappen") ; -- status=guess, src=wikt status=guess, src=wikt
lin tread_V = mkV "stampen" | mkV "vertrappen" ; -- status=guess, src=wikt status=guess, src=wikt
lin supplementary_A = variants{} ; -- 
lin ham_N = mkN "knieboog" masculine ; -- status=guess
lin defy_V2V = mkV2V (mkV "uitdagen") | mkV2V (mkV (mkV "het") "hoofd bieden") ; -- status=guess, src=wikt status=guess, src=wikt
lin defy_V2 = mkV2 (mkV "uitdagen") | mkV2 (mkV (mkV "het") "hoofd bieden") ; -- status=guess, src=wikt status=guess, src=wikt
lin athlete_N = mkN "atleet" ; -- status=guess
lin sociological_A = variants{} ; -- 
lin physician_N = mkN "dokter" masculine ; -- status=guess
lin crossing_N = mkN "kruising" feminine ; -- status=guess
lin bail_N = mkN "borgtocht" masculine ; -- status=guess
lin unwanted_A = variants{} ; -- 
lin tight_Adv = variants{} ; -- 
lin plausible_A = mkA "aannemelijk" | mkA "aanneembaar" ; -- status=guess status=guess
lin midfield_N = variants{} ; -- 
lin alert_A = variants{} ; -- 
lin feminine_A = variants{} ; -- 
lin drainage_N = mkN "drainage" | mkN "afwatering" ; -- status=guess status=guess
lin cruelty_N = mkN "wreedheid" feminine ; -- status=guess
lin abnormal_A = mkA "abnormaal" ; -- status=guess
lin relate_N = variants{} ; -- 
lin poison_V2 = mkV2 (mkV "vergiftigen") ; -- status=guess, src=wikt
lin symmetry_N = mkN "symmetrie" utrum ; -- status=guess
lin stake_V2 = mkV2 (mkV "afbakenen") ; -- status=guess, src=wikt
lin rotten_A = L.rotten_A ;
lin prone_A = variants{} ; -- 
lin marsh_N = mkN "moeras" neuter ; -- status=guess
lin litigation_N = mkN "procesvoering" feminine | mkN "proces" neuter | mkN "geding" neuter | mkN "rechtszaak" feminine ; -- status=guess status=guess status=guess status=guess
lin curl_N = mkN "rotatie" ; -- status=guess
lin urine_N = mkN "urine" ; -- status=guess
lin latin_A = variants{} ; -- 
lin hover_V = variants{} ; -- 
lin greeting_N = mkN "begroeting" feminine | mkN "groet" masculine ; -- status=guess status=guess
lin chase_N = mkN "achtervolging" feminine | mkN "jacht" masculine ; -- status=guess status=guess
lin spouseMasc_N = mkN "echtgenoot" | mkN "eega" | mkN "gade" ; -- status=guess status=guess status=guess
lin produce_N = mkN "waar" feminine | mkN "waren {p}" ; -- status=guess status=guess
lin forge_V2 = mkV2 (mkV "vervalsen") ; -- status=guess, src=wikt
lin forge_V = mkV "vervalsen" ; -- status=guess, src=wikt
lin salon_N = variants{} ; -- 
lin handicapped_A = mkA "gehandicapt" | mkA "behinderd" | mkA "invalide" | mkA "andersvalide" | mkA "mindervalide" | mkA "gebrekkig" | mkA "beperkt" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin sway_V2 = mkV2 (mkV "zwaaien") ; -- status=guess, src=wikt
lin sway_V = mkV "zwaaien" ; -- status=guess, src=wikt
lin homosexual_A = mkA "homoseksueel" | mkA "van de verkeerde kant" ; -- status=guess status=guess
lin handicap_V2 = variants{} ; -- 
lin colon_N = mkN "karteldarm" masculine ; -- status=guess
lin upstairs_N = variants{} ; -- 
lin stimulation_N = mkN "stimulatie" feminine ; -- status=guess
lin spray_V2 = variants{} ; -- 
lin original_N = mkN "origineel" neuter ; -- status=guess
lin lay_A = mkA "leken-" | mkA "wereldlijk" ; -- status=guess status=guess
lin garlic_N = mkN "knoflook" masculine feminine ; -- status=guess
lin suitcase_N = mkN "valies" feminine | mkN "koffer" utrum ; -- status=guess status=guess
lin skipper_N = variants{} ; -- 
lin moan_VS = mkVS (mkV "klagen") ; -- status=guess, src=wikt
lin moan_V = mkV "klagen" ; -- status=guess, src=wikt
lin manpower_N = variants{} ; -- 
lin manifest_V2 = mkV2 (mkV "manifesteren") ; -- status=guess, src=wikt
lin incredibly_Adv = variants{} ; -- 
lin historically_Adv = variants{} ; -- 
lin decision_making_N = variants{} ; -- 
lin wildly_Adv = variants{} ; -- 
lin reformer_N = mkN "hervormer" masculine | mkN "hervormster" feminine ; -- status=guess status=guess
lin quantum_N = mkN "kwantummechanica" feminine ; -- status=guess
lin considering_Subj = variants{} ; -- 
}
