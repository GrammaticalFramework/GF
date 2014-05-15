---- edits by AR till concentrate_V

concrete TopDictionarySwe of TopDictionary = CatSwe ** open ParadigmsSwe, (I = IrregSwe), (C = CommonScand), (R = ResSwe), (L = LexiconSwe), (M = MakeStructuralSwe), (S = SyntaxSwe), Prelude in {

flags
  coding = utf8;

lin of_Prep = mkPrep "av" ;
lin and_Conj = S.and_Conj ;
lin in_Prep = S.in_Prep ;
lin have_VV = auxVV (mkV "böra" "borde" "bort") ;
lin have_V2 = S.have_V2;
lin have_V = lin V S.have_V2 ;
lin it_Pron = S.it_Pron;
lin to_Prep = S.to_Prep;
lin for_Prep = S.for_Prep;
lin i_Pron = S.i_Pron;
lin iFem_Pron = S.i_Pron;
lin that_Subj = S.that_Subj;
lin he_Pron = S.he_Pron;
lin on_Prep = S.on_Prep;
lin with_Prep = S.with_Prep;
lin do_V2 = mkV2 I.göra_V ;
lin at_Prep = mkPrep "vid" ;
lin by_Prep = mkPrep "genom" ;
lin but_Conj = M.mkConj "men" ;
lin from_Prep = S.from_Prep;
lin they_Pron = S.they_Pron;
lin theyFem_Pron = S.they_Pron;
lin she_Pron = S.she_Pron;
lin or_Conj = S.or_Conj;
lin as_Subj = M.mkSubj "när" ;
lin we_Pron = S.we_Pron;
lin weFem_Pron = S.we_Pron;
lin say_VS = L.say_VS ;
lin say_V2 = mkV2 "säga" "sade" "sagt" ;
lin say_V = mkV "säga" "sade" "sagt" ;
lin if_Subj = S.if_Subj;
lin go_VV = mkVV L.go_V ;
lin go_VA = mkVA I.bliva_V ;
lin go_V = L.go_V | mkV "åker" ;
lin get_VV = mkVV I.få_V ;
lin get_V2V = mkV2V I.få_V ;
lin make_V2V = mkV2V I.göra_V ;
lin make_V2A = mkV2A I.göra_V ;
lin make_V2 = mkV2 I.göra_V ;
lin make_V = I.göra_V ;
lin as_Prep = mkPrep "som" ;
lin out_Adv = mkAdv "ute" ;
lin up_Adv = mkAdv "upp" ;
lin see_VS = mkVS (mkV "se" "såg" "sett") ;
lin see_VQ = mkV "se" "såg" "sett" ;
lin see_V2V = mkV2V "se" "såg" "sett" ;
lin see_V2 = L.see_V2 ;
lin see_V = mkV "se" "såg" "sett" ;
lin know_VS = L.know_VS ;
lin know_VQ = L.know_VQ ;
lin know_V2 = L.know_V2 ;
lin know_V = L.know_VS ;
lin time_N = mkN "tid" "tider" ;
lin time_2_N = mkN "gång" "gånger" ;
lin time_1_N = mkN "tid" "tider" ;
lin take_V2 = mkV2 I.taga_V ;
lin so_Adv = mkAdv "så" ;
lin year_N = L.year_N ;
lin into_Prep = mkPrep "in i" ;
lin then_Adv = mkAdv "då" ;
lin think_VS = mkVS (mkV "tänker") ;
lin think_V2 = mkV2 "tänker" ;
lin think_V = L.think_V;
lin come_V = L.come_V;
lin than_Subj = M.mkSubj "än" ;
lin more_Adv = mkAdv "mer" ;
lin about_Prep = mkPrep "om" ;
lin now_Adv = L.now_Adv;
lin last_A = mkA "sista" | mkA "förra" | mkA "förra" ;
lin last_1_A = mkA "sista" ;
lin last_2_A = mkA "förra" ;
lin other_A = compoundA (mkA "annan" "annat" "andra" "andra" "andra") | mkA "övrig" | mkA "ytterligare" ;
lin give_V3 = L.give_V3 ;
lin give_V2 = mkV2 "ge" "ger" "ge" "gav" "gett" "given" | dirV2 (partV (mkV "lämnar")"över") ;
lin give_V = mkV "ge" "ger" "ge" "gav" "gett" "given" ;
lin just_Adv = mkAdv "precis" | mkAdv "just" ;
lin people_N = mkN "folk" neutrum ;
lin also_Adv = mkAdv "också" | mkAdv "även" ;
lin well_Adv = mkAdv "bra" ;
lin only_Adv = mkAdv "bara" | mkAdv "endast" ;
lin new_A = L.new_A ;
lin when_Subj = S.when_Subj;
lin way_N = mkN "väg" ;
lin way_2_N = mkN "sätt" "sätt" ;
lin way_1_N = mkN "väg" ;
lin look_VA = mkVA (partV I.se_V "ut") ;
lin look_V2 = mkV2 (mkV "titta") (mkPrep "på") ;
lin look_V = mkV "titta" ;
lin like_Prep = mkPrep "likt" ;
lin use_VV = mkVV (mkV "bruka") ;
lin use_V2 = dirV2 (mkV "använder") ;
lin use_V = mkV "använder" ;
lin because_Subj = S.because_Subj;
lin good_A = mkA "god" "gott" "goda" "goda" "bättre" "bäst" "bästa" | mkA "bra" "bra" "bra" "goda" "bättre" "bäst" "bästa" ;
lin find_VS = mkVS (mkV "anse" "ansåg" "ansett");
lin find_V2A = mkV2A (mkV "finna" "fann" "funnit") ;
lin find_V2 = L.find_V2;
lin find_V = mkV "hitta" ;
lin man_N = L.man_N ;
lin want_VV = S.want_VV;
lin want_V2V = mkV2V I.vilja_V ;
lin want_V2 = mkV2 I.vilja_V ;
lin want_V = I.vilja_V ;
lin day_N = L.day_N ;
lin between_Prep = S.between_Prep;
lin even_Adv = mkAdv "till och med" ;
lin there_Adv = S.there_Adv;
lin many_Det = S.many_Det;
lin after_Prep = S.after_Prep;
lin down_Adv = mkAdv "ner" ;
lin yeah_Interj = mkInterj "yes" ;
lin so_Subj = lin Subj {s = "så att"};
lin thing_N = mkN "ting" "ting" ;
lin tell_VS = mkVS (mkV "berätta") ;
lin tell_V3 = mkV3 (mkV "berätta") (mkPrep "för") ;
lin tell_1_V3 = variants{} ; -- 
lin tell_2_V3 = variants{} ; -- 
lin tell_V2V = mkV2V (mkV "berätta") (mkPrep []) (mkPrep "för") ;
lin tell_V2S = mkV2S (mkV "berätta") (mkPrep "för") ;
lin tell_V2 = mkV2 "berätta" ;
lin tell_V = mkV "avgöra" "avgjorde" "avgjort" ;
lin through_Prep = S.through_Prep;
lin back_Adv = mkAdv "tillbaka" ;
lin still_Adv = mkAdv "fortfarande" ;
lin child_N = L.child_N ;
lin here_Adv = mkAdv "här" ;
lin over_Prep = mkPrep "över" ;
lin too_Adv = mkAdv "alltför" ;
lin put_V2 = L.put_V2;
lin on_Adv = mkAdv "på" ;
lin no_Interj = mkInterj "nej" ;
lin work_V2 = dirV2 (partV (mkV "ordnar")"om");
lin work_V = mkV "arbetar" ;
lin work_2_V = mkV "fungera" | mkV "funka" ;
lin work_1_V = mkV "arbetar" | mkV "jobbar" ;
lin become_VA = L.become_VA ;
lin become_V2 = mkV2 "bli" "blev" "blivit" ;
lin become_V = mkV "bli" "blev" "blivit" ;
lin old_A = L.old_A ;
lin government_N = mkN "regering" ;
lin mean_VV = mkVV (mkV "mena") ;
lin mean_VS = mkVS (mkV "betyda" "betydde" "betytt") | mkVS (mkV "mena") ;
lin mean_V2V = mkV2V (mkV "betyda" "betydde" "betytt") | mkV2V (mkV "mena") ;
lin mean_V2 = mkV2 "betyda" "betydde" "betytt" | mkV2 "mena"| mkV2 (mkV "innebär" "innebar" "inneburit") ;
lin part_N = mkN "del" ;
lin leave_V2V = mkV2V (mkV "lämna");
lin leave_V2 = L.leave_V2;
lin leave_V = mkV "avgå" "avgick" "avgått" ;
lin life_N = mkN "liv" neutrum ;
lin great_A = mkA "stor" "större" "störst" ;
lin case_N = mkN "fall" neutrum ;
lin woman_N = L.woman_N ;
lin over_Adv = mkAdv "förbi" ;
lin seem_VV = auxVV (mkV "verka") ;
lin seem_VS = mkVS (mkV "förefalla" "föreföll" "förefallit") | mkVS (mkV "verkar") ;
lin seem_VA = mkVA (mkV "förefalla" "föreföll" "förefallit") | mkVA (mkV "verkar") | mkVA (depV (mkV "tycker")) ;
lin work_N = mkN "jobb" neutrum | mkN "arbete" "arbeten" ;
lin need_VV = mkVV (mkV "behöver") ;
lin need_VV = mkVV (mkV "behöver") ;
lin need_V2 = mkV2 "behöver" ;
lin need_V = mkV "behöver" ;
lin feel_VS = mkV "känna" "kände" "känt" ;
lin feel_VA = mkVA (reflV (mkV "känna" "kände" "känt")) ;
lin feel_V2 = mkV2 "känna" "kände" "känt" ;
lin feel_V = mkV "känna" "kände" "känt" ;
lin system_N = mkN "system" neutrum ;
lin each_Det = M.mkDet "varje" singular ;
lin may_2_VV = auxVV (mkV "få" "fick" "fått") ;
lin may_1_VV = S.can_VV ;
lin much_Adv = mkAdv "mycket" ;
lin ask_VQ = mkVQ (mkV "fråga") ;
lin ask_V2V = mkV2V I.bedja_V ;
lin ask_V2 = mkV2 "fråga" ;
lin ask_V = mkV "fråga" ;
lin group_N = mkN "grupp" "grupper" ;
lin number_N = L.number_N ;
lin number_3_N = mkN "numerus" "numerus" ;
lin number_2_N = mkN "antal" "antal" ;
lin number_1_N = L.number_N ;
lin yes_Interj = mkInterj "ja" ;
lin however_Adv = mkAdv "hursomhelst" ;
lin another_Det = M.mkDet "annan" "annat" singular ;
lin again_Adv = mkAdv "igen" ;
lin world_N = mkN "värld" ;
lin area_N = mkN "område" ; ---
lin area_6_N = mkN "yta" ;
lin area_5_N = mkN "yta" ;
lin area_4_N = mkN "yta" ;
lin area_3_N = mkN "yta" ;
lin area_2_N = mkN "område" ;
lin area_1_N = mkN "yta" ;
lin show_VS = mkVS (mkV "visa") ;
lin show_VQ = mkVQ (mkV "visa") ;
lin show_V2 = mkV2 "visa" ;
lin show_V = mkV "visa" ;
lin course_N = mkN "kurs" "kurser" ;
lin company_2_N = mkN "sällskap" neutrum ;
lin company_1_N = mkN "bolag" "bolag" ;
lin under_Prep = S.under_Prep;
lin problem_N = mkN "problem" neutrum | mkN "uppgift" "uppgifter" ;
lin against_Prep = mkPrep "mot" ;
lin never_Adv = mkAdv "aldrig" ;
lin most_Adv = mkAdv "mest" ;
lin service_N = mkN "tjänst" "tjänster" | mkN "service" utrum | mkN "tjänstgöring" ;
lin try_VV = mkVV (mkV "försöker") ;
lin try_V2 = mkV2 "försöker" ;
lin try_V = mkV "försöker" ;
lin call_V2 = mkV2 "kalla" | mkV2 "anropa" | mkV2 (mkV "heter") ; ---- heta = be called
lin call_V = mkV "kalla" | mkV "anropa" ;
lin hand_N = L.hand_N ;
lin party_N = mkN "parti" "partit" "partier" "partierna" | mkN "grupp" "grupper" ; ---
lin party_2_N = mkN "parti" "partiet" "partier" "partierna" ;
lin party_1_N = mkN "kalas" "kalas" ;
lin high_A = mkA "hög" "högre" "högst" ;
lin about_Adv = mkAdv "omkring" ;
lin something_NP = S.something_NP;
lin school_N = L.school_N ;
lin in_Adv = mkAdv "inne" ;
lin in_1_Adv = mkAdv "inne" ;
lin in_2_Adv = mkAdv "in" ;
lin small_A = L.small_A ;
lin place_N = mkN "plats" "platser" ;
lin before_Prep = S.before_Prep;
lin while_Subj = M.mkSubj "medan" ;
lin away_Adv = mkAdv "undan" ;
lin away_2_Adv = mkAdv "bort" ;
lin away_1_Adv = mkAdv "borta" ;
lin keep_VV = mkVV (partV (mkV "hålla" "höll" "hållit") "på") ;
lin keep_V2A = mkV2A (mkV "hålla" "höll" "hållit") ;
lin keep_V2 = mkV2 (mkV "behålla" "behöll" "behållit") ;
lin keep_V = mkV "behålla" "behöll" "behållit" ;
lin point_N = mkN "spets" | mkN "udd" ; ---
lin point_2_N = mkN "poäng" "poängen" "poäng" "poängen" ;
lin point_1_N = mkN "punkt" "punkter" ;
lin house_N = L.house_N ;
lin different_A = mkA "olik" ;
lin country_N = L.country_N ;
lin really_Adv = mkAdv "verkligen" ;
lin provide_V2 = mkV2 "förse" "försåg" "försett" | mkV2 (mkV "erbjuda" "erbjöd" "erbjudit") ;
lin provide_V = mkV "förse" "försåg" "försett" | mkV "tillhandahålla" "tillhandahöll" "tillhandahållit" ;
lin week_N = mkN "vecka" ;
lin hold_VS = mkVS I.hålla_V ;
lin hold_V2 = L.hold_V2;
lin hold_V = mkV "bevara" ;
lin large_A = mkA "stor" "större" "störst" ;
lin member_N = mkN "medlem" "medlemmen" "medlemmar" "medlemmarna" ;
lin off_Adv = mkAdv "bort" ;
lin always_Adv = mkAdv "alltid" ;
lin follow_VS = mkV "följer" ;
lin follow_V2 = mkV2 "följer" ;
lin follow_V = mkV "följer" ;
lin without_Prep = S.without_Prep;
lin turn_VA = mkVA I.bliva_V ;
lin turn_V2 = mkV2 I.vrida_V ;
lin turn_V = L.turn_V ;
lin end_N = mkN "ände" utrum | mkN "ända" ; ---
lin end_2_N = mkN "ände" utrum | mkN "ända" ;
lin end_1_N = mkN "slut" "slut" ;
lin within_Prep = mkPrep "inom" ;
lin local_A = mkA "lokal" ;
lin where_Subj = lin Subj {s = "där"};
lin during_Prep = S.during_Prep;
lin bring_V3 = mkV3 "bringer" ;
lin bring_V2 = mkV2 "bringer" ;
lin most_Det = M.mkDet "de flesta" plural;
lin word_N = mkN "ord" neutrum | mkN "bud" neutrum ;
lin begin_V2 = mkV2 "börjar" ;
lin begin_V = mkV "börjar" ;
lin although_Subj = S.although_Subj;
lin example_N = mkN "exempel" neutrum ;
lin next_Adv = mkAdv "näst" ;
lin family_N = mkN "familj" "familjer" ;
lin rather_Adv = mkAdv "snarare" ;
lin fact_N = mkN "faktum" "faktumet" "fakta" "faktan" ;
lin like_VV = mkVV (mkV (mkV "tycker") "om") | mkVV (mkV "gillar") ;
lin like_VS = mkVS (mkV (mkV "tycker") "om") | mkVS (mkV "gillar") ;
lin like_V2 = L.like_V2;
lin social_A = mkA "social" ;
lin write_VS = mkV "skriva" "skrev" "skrivit" ;
lin write_V2 = L.write_V2 ;
lin write_V = mkV "skriva" "skrev" "skrivit" ;
lin state_N = mkN "tillstånd" neutrum | mkN "stat" "stater" ;
lin state_2_N = mkN "tillstånd" neutrum ;
lin state_1_N = mkN "stat" "stater" ;
lin percent_N = mkN "procent" "procenten" "procent" "procenten" ;
lin quite_Adv = S.quite_Adv;
lin both_Det = M.mkDet "båda" plural ;
lin start_V2 = mkV2 "starta" ;
lin start_V = partV I.sätta_V "igång" ;
lin run_V2 = mkV2 I.driva_V ;
lin run_V = L.run_V ;
lin long_A = L.long_A ;
lin right_Adv = mkAdv "rätt" | mkAdv "just" ; --- sense
lin right_2_Adv = mkAdv "till höger" ;
lin right_1_Adv = mkAdv "rätt" ;
lin set_V2 = mkV2 I.sätta_V ;
lin help_V2V = mkV2V (mkV "hjälper") ;
lin help_V2 = mkV2 "hjälper" ;
lin help_V = mkV "hjälper" ;
lin every_Det = S.every_Det;
lin home_N = mkN "hem" "hemmet" "hem" "hemmen" ;
lin month_N = mkN "månad" "månader" ;
lin side_N = mkN "sida" ;
lin night_N = L.night_N ;
lin important_A = L.important_A ;
lin eye_N = L.eye_N ;
lin head_N = L.head_N ;
lin information_N = mkN "information" "informationer" ;
lin question_N = L.question_N ;
lin business_N = mkN "affär" "affärer" ;
lin play_V2 = L.play_V2;
lin play_V = L.play_V;
lin play_3_V2 = mkV2 "spela" ;
lin play_3_V = mkV "spela" ;
lin play_2_V2 = mkV2 "leker" ;
lin play_2_V = mkV "leker" ;
lin play_1_V2 = mkV2 "spela" ;
lin play_1_V = mkV "spela" ;
lin power_N = mkN "makt" "makter" ;
lin money_N = mkN "peng" ;
lin change_N = mkN "ändring" | mkN "förändring" ;
lin move_V2 = mkV2 "beröra" "berörde" "berört" | mkV2 "flytta" ;
lin move_V = mkV "rör" | mkV "flyttar" ;
lin move_2_V = mkV "flyttar" ;
lin move_1_V = reflV (mkV "rör") ;
lin interest_N = mkN "intresse" | mkN "ränta" ;
lin interest_4_N = mkN "intresse" ;
lin interest_2_N = mkN "ränta" ;
lin interest_1_N = mkN "intresse" ;
lin order_N = mkN "order" ;
lin book_N = L.book_N ;
lin often_Adv = mkAdv "ofta" ;
lin development_N = mkN "utveckling" ;
lin young_A = L.young_A ;
lin national_A = mkA "nationell" ;
lin pay_V3 = mkV3 (mkV "betala") (mkPrep "för") ;
lin pay_V2V = mkV2V (mkV "betala") ;
lin pay_V2 = mkV2 "betala" ;
lin pay_V = reflV (mkV "löna") ;
lin hear_VS = mkVS (mkV "höra" "hörde" "hört") ;
lin hear_V2V = mkV2V "höra" "hörde" "hört" ;
lin hear_V2 = L.hear_V2 ;
lin hear_V = mkV "höra" "hörde" "hört" ;
lin room_N = mkN "rum" "rummet" "rum" "rummen" | mkN "utrymme" ;
lin room_1_N = mkN "rum" "rummet" "rum" "rummen" ;
lin room_2_N = mkN "utrymme" ;
lin whether_Subj = M.mkSubj "huruvida" ;
lin water_N = L.water_N ;
lin form_N = mkN "form" "former" ;
lin car_N = L.car_N ;
lin other_N = mkN "annan" "andra" "andra" "andra" ;
lin yet_Adv = mkAdv "dock" ;
lin yet_2_Adv = mkAdv "dock" ;
lin yet_1_Adv = mkAdv "ännu" ;
lin perhaps_Adv = mkAdv "kanske" ;
lin meet_V2 = mkV2 "möter" ;
lin meet_V = mkV "träffas" ;
lin level_N = mkN "våning" | mkN "plan" "planer" ;
lin level_2_N = mkN "plan" "plan" ;
lin level_1_N = mkN "nivå" "nivåer" ;
lin until_Subj = M.mkSubj "tills" ;
lin though_Subj = lin Subj {s = "fast"} ;
lin policy_N = mkN "policy" "policier" | mkN "politik" ;
lin include_V2 = mkV2 "innehålla" "innehöll" "innehållit" ;
lin include_V = mkV "innehålla" "innehöll" "innehållit" | mkV "inkluderar" ;
lin believe_VS = mkVS (mkV "tro") ;
lin believe_V2 = mkV2 (mkV "tror") ;
lin believe_V = mkV "tror" ;
lin council_N = mkN "råd" neutrum ;
lin already_Adv = L.already_Adv ;
lin possible_A = mkA "möjlig" ;
lin nothing_NP = S.nothing_NP ;
lin line_N = mkN "rad" "rader" ;
lin allow_V2V = mkV2V "tillåta" "tillät" "tillåtit" ;
lin allow_V2 = mkV2 "tillåta" "tillät" "tillåtit" ;
lin need_N = mkN "behov" neutrum ;
lin effect_N = mkN "effekt" "effekter" ;
lin big_A = L.big_A;
lin use_N = mkN "användning" ;
lin lead_V2V = mkV2V "leda" "ledde" "lett" | mkV2V (mkV "leder") ;
lin lead_V2 = mkV2 "leda" "ledde" "lett" | mkV2 (mkV "leder") ;
lin lead_V = mkV "leda" "ledde" "lett" | mkV "leder" ;
lin stand_V2 = dirV2 (partV (mkV "stå" "stod" "stått")"ut") ;
lin stand_V = L.stand_V ;
lin idea_N = mkN "idé" "idéer" ;
lin study_N = mkN "studie" "studiet" "studier" "studierna" ;
lin lot_N = mkN "mängd" "mängder" | mkN "allt" neutrum ;
lin live_V = L.live_V;
lin job_N = mkN "jobb" neutrum | mkN "arbete" ;
lin since_Subj = M.mkSubj "sedan" ;
lin name_N = L.name_N ;
lin result_N = mkN "resultat" neutrum ;
lin body_N = mkN "kropp" ;
lin happen_VV = mkVV (mkV "händer") | mkVV (mkV "ske" "skedde" "skett") | mkVV (mkV "inträffa") ;
lin happen_V = mkV "händer" ;
lin friend_N = L.friend_N ;
lin right_N = mkN "rättighet" "rättigheter" ;
lin least_Adv = mkAdv "minst" ;
lin right_A = mkA "rätt" | mkA "riktig" ;
lin right_2_A = mkA "höger" ;
lin right_1_A = mkA "rätt" ;
lin almost_Adv = mkAdv "nästan" ;
lin much_Det = S.much_Det;
lin carry_V2 = mkV2 I.bära_V ;
lin carry_V = I.bära_V ;
lin authority_N = mkN "auktoritet" "auktoriteter" | mkN "myndighet" "myndigheter" ;
lin authority_2_N = mkN "myndighet" "myndigheter" ;
lin authority_1_N = mkN "auktoritet" "auktoriteter" ;
lin long_Adv = mkAdv "länge" ;
lin early_A = mkA "tidig" ;
lin view_N = mkN "åsikt" "åsikter" | mkN "fotografi" "fotografit" "fotografier" "fotografierna" ;
lin view_2_N = mkN "åsikt" "åsikter" ;
lin view_1_N = mkN "utsikt" "utsikter" | mkN "vy" "vyer" ;
lin public_A = mkA "offentlig" ;
lin together_Adv = mkAdv "tillsammans" ;
lin talk_V2 = dirV2 (partV (mkV "talar")"om") ;
lin talk_V = mkV "diskuterar" ;
lin report_N = mkN "rapport" "rapporter" | mkN "redogörelse" "redogörelser" | mkN "utlåtande" ;
lin after_Subj = M.mkSubj "efter" ;
lin only_Predet = S.only_Predet;
lin before_Subj = lin Subj {s = "innan"};
lin bit_N = mkN "bit" ;
lin face_N = mkN "ansikte" ;
lin sit_V2 = mkV2 "sitta" "satt" "suttit" ;
lin sit_V = L.sit_V ;
lin market_N = mkN "marknad" "marknader" ;
lin market_1_N = mkN "torg" "torg" ;
lin market_2_N = mkN "marknad" "marknader" ;
lin appear_VV = mkVV (mkV "verka") ;
lin appear_VS = mkVS (mkV "verka") ;
lin appear_VA = mkVA (mkV "verka") ;
lin appear_V = partV I.dyka_V "upp" ;
lin continue_VV = mkVV (mkV "fortsätta" "fortsatte" "fortsatt") ;
lin continue_V2 = mkV2 (mkV "fortsätta" "fortsatte" "fortsatt") ;
lin continue_V = mkV "fortsätta" "fortsätter" "fortsätt" "fortsatte" "fortsatt" "fortsatt" ;
lin able_A = mkA "duktig" | mkA "skicklig" ;
lin political_A = mkA "politisk" ;
lin later_Adv = mkAdv "senare" ;
lin hour_N = mkN "timme" utrum ;
lin rate_N = mkN "takt" "takter" | mkN "grad" "grader" ;
lin law_N = mkN "juridik" ;
lin law_2_N = mkN "juridik" "juridiker" ;
lin law_1_N = mkN "lag" ;
lin door_N = L.door_N ;
lin court_N = mkN "hov" | mkN "domstol" ;
lin court_2_N = mkN "domstol" ;
lin court_1_N = mkN "hov" "hov" ;
lin office_N = mkN "kontor" neutrum ;
lin let_V2V = mkV2V (mkV "låta" "lät" "låtit");
lin war_N = L.war_N ;
lin produce_V2 = mkV2 "producera" ;
lin produce_V = mkV "producera" ;
lin reason_N = L.reason_N ;
lin less_Adv = mkAdv "mindre" ;
lin minister_N = mkN "pastor" "pastorer" | mkN "statsråd" neutrum ; ---
lin minister_2_N = mkN "pastor" "pastorer" ;
lin minister_1_N = mkN "minister" | mkN "statsråd" neutrum ;
lin subject_N = mkN "ämne" ; ---
lin subject_2_N = mkN "subjekt" "subjekter" ;
lin subject_1_N = mkN "ämne" ;
lin person_N = L.person_N ;
lin term_N = mkN "term" "termer" | mkN "termin" "terminer" ;
lin particular_A = mkA "särskild" "särskilt" ;
lin full_A = L.full_A ;
lin involve_VS = mkVS (mkV "involvera") ;
lin involve_V2 = mkV2 "involvera" ;
lin involve_V = mkV "involverar" ;
lin sort_N = mkN "sort" "sorter" ;
lin require_VS = mkVS (mkV "kräver");
lin require_V2V = mkV2V (mkV "kräver");
lin require_V2 = mkV2 "kräver" ;
lin require_V = mkV "kräver" ;
lin suggest_VS = mkV "föreslå" "föreslog" "föreslagit" ;
lin suggest_V2 = mkV2 "föreslå" "föreslog" "föreslagit" ;
lin suggest_V = mkV "föreslå" "föreslog" "föreslagit" ;
lin far_A = mkA "avlägsen" "avlägset" | mkA "fjärran" ;
lin towards_Prep = mkPrep "mot" ;
lin anything_NP = S.mkNP (mkPN "vad som helst" neutrum) | S.mkNP (mkPN "något" neutrum) ; --- split pos/neg
lin period_N = mkN "punkt" "punkter" | mkN "skede" ; ---
lin period_3_N = mkN "mens" ;
lin period_2_N = mkN "punkt" "punkter" ;
lin period_1_N = mkN "period" "perioder" ;
lin consider_VV = mkVV (mkV "överväger") ;
lin consider_VS = mkVS (mkV "överväger") ;
lin consider_V3 = mkV3 (mkV "betraktar") (mkPrep "som") ;
lin consider_V2V = mkV2V (mkV "betraktar") ;
lin consider_V2A = mkV2A (mkV "anse" "ansåg" "ansett") ;
lin consider_V2 = mkV2 (mkV "överväger") ;
lin consider_V = mkV "överväger" ;
lin read_VS = mkVS (mkV "läser") ;
lin read_V2 = L.read_V2;
lin read_V = mkV "läser" ;
lin change_V2 = mkV2 "byter" ;
lin change_V = mkV "förändras" ;
lin society_N = mkN "samhälle" ;
lin process_N = mkN "process" "processer" ;
lin mother_N = mkN "mor" "modern" "mödrar" "mödrarna" | mkN "mamma" ;
lin offer_VV = mkVV (mkV "erbjuda" "erbjöd" "erbjudit") ;
lin offer_V2 = mkV2 "erbjuda" "erbjöd" "erbjudit" ;
lin late_A = mkA "sen" ;
lin voice_N = mkN "röst" "röster" ;
lin both_Adv = mkAdv "båda" ;
lin once_Adv = mkAdv "en gång" ;
lin police_N = mkN "polis" "poliser" ;
lin kind_N = mkN "slag" neutrum ;
lin lose_V2 = L.lose_V2 ;
lin lose_V = mkV "förlora" ;
lin add_VS = mkVS (mkV "tillägga" "tillade" "tillagt") ;
lin add_V2 = mkV2 (mkV "tillägga" "tillade" "tillagt") ;
lin add_V = mkV "adderar" ;
lin probably_Adv = mkAdv "sannolikt" ;
lin expect_VV = mkVV (reflV (mkV "vänta")) ;
lin expect_VS = mkVS (mkV "förvänta") ;
lin expect_V2V = mkV2V (mkV "förvänta") ;
lin expect_V2 = mkV2 (reflV (mkV "vänta")) ;
lin expect_V = reflV (mkV "vänta") ;
lin ever_Adv = mkAdv "någonsin" ;
lin available_A = mkA "tillgänglig" ;
lin price_N = mkN "pris" "priset" "priser" "priserna" ;
lin little_A = L.small_A ;
lin action_N = mkN "handling" ;
lin issue_N = mkN "fråga" | mkN "spörsmål" neutrum ; ---
lin issue_2_N = mkN "nummer" "nummer" ;
lin issue_1_N = mkN "fråga" | mkN "spörsmål" neutrum ;
lin far_Adv = mkAdv "långt" ;
lin remember_VS = mkVS (mkV (mkV "komma" "kom" "kommit") "ihåg") | mkVS (depV (mkV "minner")) ;
lin remember_V2 = mkV2 (mkV (mkV "komma" "kom" "kommit") "ihåg") | mkV2 (depV (mkV "minner")) ;
lin remember_V = depV (mkV "minner") ;
lin position_N = mkN "ställning" | mkN "anställning" ;
lin low_A = mkA "låg" "lägre" "lägst" ;
lin cost_N = mkN "kostnad" "kostnader" ;
lin little_Det = M.mkDet "lite" singular ;
lin matter_N = mkN "materia" "materian" "materier" "materierna" | mkN "ärende" ;
lin matter_1_N = mkN "materia" "materian" "materier" "materierna" ;
lin matter_2_N = mkN "ärende" ;
lin community_N = mkN "samhälle" ;
lin remain_VV = mkVV (mkV "kvarstå" "kvarstod" "kvarstått") ;
lin remain_VA = mkVA (mkV "förbli" "förblev" "förblivit") ;
lin remain_V2 = mkV2 (mkV "förbli" "förblev" "förblivit") ;
lin remain_V = mkV "kvarstå" "kvarstod" "kvarstått" ;
lin figure_N = mkN "figur" "figurer" | mkN "uppgift" "uppgifter" ; ---
lin figure_2_N = mkN "siffra" ;
lin figure_1_N = mkN "figur" "figurer" ;
lin type_N = mkN "typ" "typer" ;
lin research_N = mkN "forskning" ;
lin actually_Adv = mkAdv "faktiskt" ;
lin education_N = mkN "utbildning" | mkN "bildning" ;
lin fall_V = mkV "falla" "föll" "fallit" ;
lin speak_V2 = L.speak_V2 ;
lin speak_V = mkV "tala" ;
lin few_N = mkN "fåtal" neutrum ;
lin today_Adv = L.today_Adv ;
lin enough_Adv = mkAdv "tillräckligt" ;
lin open_V2 = L.open_V2 ;
lin open_V = mkV "öppnas" ;
lin bad_A = L.bad_A ;
lin buy_V2 = L.buy_V2 ;
lin buy_V = mkV "köper" ;
lin programme_N = mkN "program" "programmet" "program" "programmen" ;
lin minute_N = mkN "minut" "minuter" ;
lin moment_N = mkN "ögonblick" neutrum ;
lin girl_N = L.girl_N ;
lin age_N = mkN "ålder" "åldrar" ;
lin centre_N = mkN "centrum" "centrumet" "centra" "centran" ;
lin stop_VV = mkVV (mkV "sluta") ;
lin stop_V2 = mkV2 "stoppa" ;
lin stop_V = L.stop_V ;
lin control_N = mkN "kontroll" "kontroller" ;
lin value_N = mkN "värde" ;
lin send_V2V = mkV2V (mkV "skickar") | mkV2V (mkV "sänder") ;
lin send_V2 = mkV2 "skicka" | mkV2 "sänder" ;
lin send_V = mkV "sänder" ;
lin health_N = mkN "hälsa" ;
lin decide_VV = mkVV (mkV "besluta" "beslöt" "beslutit") ;
lin decide_VS = mkV "avgöra" "avgjorde" "avgjort" | mkVS (mkV "bestämmer") ;
lin decide_V2 = mkV2 "avgöra" "avgjorde" "avgjort" | mkV2 (mkV "bestämmer") (mkPrep "om") ;
lin decide_V = mkV "bestämmer" ;
lin main_A = mkA "huvudsaklig" ;
lin win_V2 = L.win_V2 ;
lin win_V = mkV "vinna" "vann" "vunnit" ;
lin understand_VS = mkVS (mkV "förstå" "föstod" "förstått") | mkVS (mkV "begripa" "begrep" "begripit") ;
lin understand_V2 = L.understand_V2 ;
lin understand_V = mkV "begripa" "begrep" "begripit" | mkV "förstå" "förstod" "förstått" ;
lin decision_N = mkN "beslut" neutrum ;
lin develop_V2 = mkV2 "utveckla" ;
lin develop_V = mkV "utvecklar" ;
lin class_N = mkN "klass" "klasser" ;
lin industry_N = L.industry_N ;
lin receive_V2 = mkV2 (mkV "mottaga" "mottog" "mottagit") ;
lin receive_V = mkV "mottaga" "mottog" "mottagit" ;
lin back_N = L.back_N ;
lin several_Det = M.mkDet "flera" plural ;
lin return_V2 = mkV2 "återföra" "återförde" "återfört" | mkV2 (mkV "returnerar") ;
lin return_V = mkV "återvänder" ;
lin build_V2 = mkV2 "bygger" ;
lin build_V = mkV "bygger" ;
lin spend_V2 = mkV2 (mkV "tillbringa") ;
lin spend_V = mkV "spendera" ;
lin force_N = mkN "kraft" "krafter" ;
lin condition_N = mkN "villkor" neutrum | mkN "tillstånd" neutrum ;
lin condition_1_N = mkN "villkor" neutrum ;
lin condition_2_N = mkN "tillstånd" neutrum ;
lin paper_N = L.paper_N ;
lin off_Prep = mkPrep "av" ;
lin major_A = mkA "stor" "större" "störst" | mkA "tung" "tyngre" "tyngst" ;
lin describe_VS = mkVS (mkV "beskriva" "beskrev" "beskrivit") ;
lin describe_V2 = mkV2 "beskriva" "beskrev" "beskrivit" ;
lin agree_VV = mkVV (mkV (mkV "komma" "kom" "kommit") "överens om") ;
lin agree_VS = mkVS (mkV I.hålla_V "med") ;
lin agree_V = mkV I.hålla_V "med" ;
lin economic_A = mkA "ekonomisk" ;
lin increase_V2 = mkV2 "öka" ;
lin increase_V = mkV "öka" ;
lin upon_Prep = mkPrep "på" ;
lin learn_VV = mkVV (lin V L.learn_V2);
lin learn_VS = mkVS (lin V L.learn_V2);
lin learn_V2 = L.learn_V2;
lin learn_V = reflV (mkV "lär") ;
lin general_A = mkA "allmän" "allmänt" "allmänna" "allmänna" "allmännare" "allmännast" "allmännaste" ;
lin century_N = mkN "århundrade" ;
lin therefore_Adv = mkAdv "därför" ;
lin father_N = mkN "far" "fadern" "fäder" "fäderna" | mkN "pappa" ;
lin section_N = mkN "del" "delen" "delar" "delarna" | mkN "område" ;
lin patient_N = mkN "patient" "patienter" ;
lin around_Adv = mkAdv "omkring" ;
lin activity_N = mkN "aktivitet" "aktiviteter" | mkN "verksamhet" "verksamheter" ;
lin road_N = L.road_N ;
lin table_N = L.table_N ;
lin including_Prep = mkPrep "inklusive" ;
lin church_N = L.church_N ;
lin reach_V2 = mkV2 "nå" | mkV2 (reflV (mkV "sträcker")) (mkPrep "till") ;
lin reach_V = mkV "når" ;
lin real_A = mkA "äkta" ;
lin lie_VS = mkV "ljuga" "ljög" "ljugit" ;
lin lie_2_V = mkV "ljuga" "ljög" "ljugit" ;
lin lie_1_V = mkV "lägga" "lade" "lagt" ;
lin mind_N = mkN "sinne" | mkN "ande" utrum ;
lin likely_A = mkA "sannolik" ;
lin among_Prep = mkPrep "bland" ;
lin team_N = mkN "lag" "lag" ;
lin experience_N = mkN "erfarenhet" "erfarenheter" ;
lin death_N = mkN "död" ;
lin soon_Adv = mkAdv "snart" ;
lin act_N = mkN "handling" | mkN "gärning" ;
lin sense_N = mkN "sinne" | mkN "vett" neutrum ;
lin staff_N = mkN "stav" | mkN "personal" "personaler" ; ---
lin staff_2_N = mkN "stav" "stäver" ;
lin staff_1_N = mkN "personal" "personaler" ;
lin certain_A = mkA "säker" | mkA "viss" ; ---
lin certain_2_A = mkA "viss" ;
lin certain_1_A = mkA "säker" ;
lin studentMasc_N = mkN "student" "studenter" ;
lin half_Predet = M.mkPredet "halva" "halva" "halva" ;
lin half_Predet = M.mkPredet "halva" "halva" "halva" ;
lin around_Prep = mkPrep "kring" ;
lin language_N = L.language_N ;
lin walk_V2 = mkV2 (mkV I.gå_V "ut") (mkPrep "med") ;
lin walk_V = L.walk_V;
lin die_V = L.die_V ;
lin special_A = mkA "speciell" ;
lin difficult_A = mkA "svår" ;
lin international_A = mkA "internationell" ;
lin particularly_Adv = mkAdv "i synnerhet" ;
lin department_N = mkN "avdelning" | mkN "institution" "institutioner" ;
lin management_N = mkN "ledning" ;
lin morning_N = mkN "morgon" "morgonen" "morgnar" "morgnarna" ;
lin draw_V2 = mkV2 "dra" "drar" "dra" "drog" "dragit" "dragen" ;
lin draw_1_V2 = mkV2 "dra" "drar" "dra" "drog" "dragit" "dragen" ;
lin draw_2_V2 = mkV2 "rita" | mkV2 "teckna" ;
lin draw_V = mkV "dra" "drar" "dra" "drog" "dragit" "dragen" ;
lin hope_VV = mkVV (mkV "hoppas") ;
lin hope_VS = L.hope_VS ;
lin hope_V = mkV "hoppas" ;
lin across_Prep = mkPrep "över" ;
lin plan_N = mkN "plan" "planer" ;
lin product_N = mkN "produkt" "produkter" ;
lin city_N = L.city_N ;
lin early_Adv = mkAdv "tidigt" ;
lin committee_N = mkN "kommitté" "kommittéer" | mkN "utskott" neutrum ;
lin ground_N = mkN "mark" "marker" | mkN "anledning" ; ---
lin ground_2_N = mkN "anledning" ;
lin ground_1_N = mkN "mark" "marker" ;
lin letter_N = mkN "brev" "brev" ; ---- deprecated
lin letter_2_N = mkN "bokstav" "bokstäver" ;
lin letter_1_N = mkN "brev" "brev" ;
lin create_V2 = mkV2 "skapa" ;
lin create_V = mkV "skapa" ;
lin evidence_N = mkN "tydlighet" "tydligheter" ; ---
lin evidence_2_N = mkN "tydlighet" "tydligheter" ;
lin evidence_1_N = mkN "evidens" "evidenser" ;
lin foot_N = L.foot_N ;
lin clear_A = mkA "tydlig" | mkA "klar" ;
lin boy_N = L.boy_N ;
lin game_N = mkN "lek" utrum | mkN "spel" neutrum | mkN "vilt" neutrum ; ---
lin game_3_N = mkN "vilt" neutrum ;
lin game_2_N = mkN "lek" ;
lin game_1_N = mkN "spel" neutrum ;
lin food_N = mkN "mat" "mater" ;
lin role_N = mkN "roll" "roller" ; ---
lin role_2_N = mkN "roll" "roller" ;
lin role_1_N = mkN "roll" "roller" ;
lin practice_N = mkN "övning" | mkN "praktik" "praktiker" ;
lin bank_N = L.bank_N ;
lin else_Adv = mkAdv "annars" ;
lin support_N = mkN "stöd" "stöd" ;
lin sell_V2 = mkV2 "sälja" "sålde" "sålt" ;
lin sell_V = mkV "sälja" "sålde" "sålt" ;
lin event_N = mkN "händelse" "händelser" ;
lin building_N = mkN "byggnad" "byggnader" ;
lin range_N = mkN "urval" neutrum ;
lin behind_Prep = S.behind_Prep;
lin sure_A = mkA "säker" ;
lin report_VS = mkVS (mkV "rapportera") ;
lin report_V2 = mkV2 "rapportera" ;
lin report_V = mkV "rapportera" ;
lin pass_V = mkV "passera" ;
lin black_A = L.black_A ;
lin stage_N = mkN "stadium" "stadiet" "stadier" "stadierna" | mkN "skede" ;
lin meeting_N = mkN "möte" | mkN "sammanträde" ;
lin meeting_N = mkN "möte" | mkN "sammanträde" ;
lin sometimes_Adv = mkAdv "ibland" ;
lin thus_Adv = mkAdv "därför" ;
lin accept_VS = mkVS (mkV "accepterar") ;
lin accept_V2 = mkV2 (mkV "accepterar") | mkV2 "godkänner" ;
lin accept_V = mkV "accepterar" ;
lin town_N = mkN "stad" "städer" ;
lin art_N = L.art_N ;
lin further_Adv = mkAdv "vidare" ;
lin club_N = mkN "nattklubb" | mkN "klubba" ; ---
lin club_2_N = mkN "klubba" ;
lin club_1_N = mkN "klubb" ;
lin cause_V2V = mkV2V (mkV "orsakar") | mkV2V (mkV "förorsaka") ;
lin cause_V2 = mkV2 "förorsaka" ;
lin arm_N = mkN "arm" | mkN "vapen" "vapnet" "vapen" "vapnen" ;
lin arm_1_N = mkN "arm" ;
lin arm_2_N = mkN "arm" ;
lin history_N = mkN "historia" "historien" "historier" "historierna" ;
lin parent_N = mkN "förälder" ;
lin land_N = mkN "land" neutrum | mkN "mark" "marken" "mark" "marken" | mkN "jord" ;
lin trade_N = mkN "handel" ;
lin watch_VS = mkVS (mkV I.se_V "till") ;
lin watch_V2V = mkV2V I.se_V ;
lin watch_V2 = L.watch_V2;
lin watch_1_V2 = L.watch_V2 ;
lin watch_2_V2 = mkV2 "bevaka" ;
lin watch_V = mkV "bevakar" ;
lin white_A = L.white_A ;
lin situation_N = mkN "situation" "situationer" ;
lin ago_Adv = mkAdv "sedan" ;
lin teacherMasc_N = mkN "lärare" "lärare" ;
lin record_N = mkN "resultat" neutrum | mkN "uppteckning" ; ---
lin record_3_N = mkN "uppteckning" ;
lin record_2_N = mkN "skiva" ;
lin record_1_N = mkN "rekord" "rekord" ;
lin manager_N = mkN "ledare" utrum | mkN "föreståndare" utrum | mkN "manager" "managern" "manager" "managerna" ;
lin relation_N = mkN "relation" "relationer" | mkN "förhållande" ;
lin common_A = mkA "vanlig" | mkA "gemensam" "gemensamt" "gemensamma" "gemensamma" "gemensammare" "gemensammast" "gemensammaste" ; ---
lin common_2_A = mkA "gemensam" "gemensamt" "gemensamma" "gemensammare" "gemensammast" ;
lin common_1_A = mkA "vanlig" ;
lin strong_A = mkA "stark" ;
lin whole_A = mkA "hel" | mkA "välbehållen" "välbehållet" ;
lin field_N = mkN "plan" "planer" | mkN "slagfält" neutrum ; ---
lin field_4_N = mkN "kropp" ;
lin field_3_N = mkN "plan" "planer" ;
lin field_2_N = mkN "fält" "fält" ;
lin field_1_N = mkN "åker" "åkrar" ;
lin free_A = mkA "ledig" | mkA "fri" "fritt" ;
lin break_V2 = L.break_V2 ;
lin break_V = mkV I.gå_V "sönder" ;
lin yesterday_Adv = mkAdv "igår" ;
lin support_V2 = mkV2 "stödjer" | mkV2 "stöttar" ;
lin window_N = L.window_N ;
lin account_N = mkN "redogörelse" "redogörelser" ;
lin explain_VS = mkVS (mkV "förklara") ;
lin explain_V2 = mkV2 (mkV "förklara") ;
lin stay_VA = mkVA (mkV "förbli" "förblev" "förblivit") ;
lin stay_V = mkV "stannar" ;
lin few_Det = M.mkDet "få" plural ;
lin wait_VV = mkVV (reflV (mkV "vänta")) ;
lin wait_V2 = L.wait_V2;
lin wait_V = mkV "vänta" | mkV "dröjer" ;
lin usually_Adv = mkAdv "vanligen" ;
lin difference_N = mkN "skillnad" "skillnader" ;
lin material_N = mkN "material" "material" | mkN "ämne" | mkN "stoff" neutrum ;
lin air_N = mkN "luft" "lufter" ;
lin wife_N = L.wife_N ;
lin cover_V2 = mkV2 "täcker" ;
lin apply_VV = mkVV (mkV "ansöker") ;
lin apply_V2V = mkV2V (mkV "tillämpar") ;
lin apply_V2 = dirV2 (partV (mkV "passar")"på");
lin apply_1_V2 = mkV2 "tillämpa" ;
lin apply_2_V2 = mkV2 (mkV "ansöka") (mkPrep "om") ;
lin apply_V = mkV "passar" ;
lin project_N = mkN "projekt" neutrum ;
lin raise_V2 = mkV2 "lyfter" ;
lin sale_N = mkN "rea" ;
lin relationship_N = mkN "förhållande" "förhållandena" ;
lin indeed_Adv = mkAdv "verkligen" ;
lin light_N = mkN "ljus" "ljus" ;
lin claim_VS = mkVS (mkV "hävda") ;
lin claim_V2 = mkV2 "utkräver" ;
lin claim_V = mkV "utkräver" ;
lin form_V2 = mkV2 "bilda" ;
lin form_V = mkV "bilda" ;
lin base_V2 = mkV2 "baserar" ;
lin base_V = mkV "baseras" ;
lin care_N = mkN "skötsel" | mkN "vård" ;
lin someone_NP = S.mkNP (mkPN "någon" utrum) ;
lin everything_NP = S.everything_NP;
lin certainly_Adv = mkAdv "säkert" ;
lin rule_N = L.rule_N ;
lin home_Adv = mkAdv "hem" ;
lin cut_V2 = L.cut_V2 ;
lin cut_V = mkV "klipper" | I.skära_V ;
lin grow_VA = mkVA (mkV "växer") ;
lin grow_V2 = mkV2 (mkV "växer") ;
lin grow_V = mkV "växer" ;
lin similar_A = mkA "liknande" | mkA "lik" ;
lin story_N = mkN "historia" "historien" "historier" "historierna" | mkN "berättelse" "berättelser" ;
lin quality_N = mkN "kvalitet" "kvaliteter" ;
lin tax_N = mkN "skatt" "skatter" ;
lin worker_N = mkN "arbetare" utrum ;
lin nature_N = mkN "natur" "naturer" ;
lin structure_N = mkN "struktur" "strukturer" ;
lin data_N = mkN "data" ;
lin necessary_A = mkA "nödvändig" ;
lin pound_N = mkN "pund" neutrum ;
lin method_N = mkN "metod" "metoder" ;
lin unit_N = mkN "enhet" "enheter" ;
lin unit_6_N = mkN "enhet" "enheter" ;
lin unit_5_N = mkN "enhet" "enheter" ;
lin unit_4_N = mkN "enhet" "enheter" ;
lin unit_3_N = mkN "enhet" "enheter" ;
lin unit_2_N = mkN "enhet" "enheter" ;
lin unit_1_N = mkN "enhet" "enheter" ;
lin central_A = mkA "central" ;
lin bed_N = mkN "säng" ;
lin union_N = mkN "union" "unioner" ;
lin movement_N = mkN "rörelse" "rörelser" ;
lin board_N = mkN "nämnd" "nämnder" | mkN "styrelse" "styrelser" ; ---
lin board_2_N = mkN "nämnd" "nämnder" | mkN "styrelse" "styrelser" ;
lin board_1_N = mkN "tavla" ;
lin true_A = mkA "sann" "sant" | mkA "äkta" ;
lin well_Interj = mkInterj "nåväl" ;
lin simply_Adv = mkAdv "enkelt" ;
lin contain_V2 = mkV2 "innehålla" "innehöll" "innehållit" ;
lin especially_Adv = mkAdv "i synnerhet" ;
lin open_A = mkA "öppen" "öppet" ;
lin short_A = L.short_A ;
lin personal_A = mkA "personlig" ;
lin detail_N = mkN "detalj" "detaljer" ;
lin model_N = mkN "modell" "modeller" ;
lin bear_V2 = mkV2 "bära" "bar" "burit" ;
lin bear_V = mkV "bära" "bar" "burit" ;
lin single_A = mkA "ogift" "ogift" | mkA "enkel" ; ---
lin single_2_A = mkA "ogift" "ogift" ;
lin single_1_A = mkA "enkel" ;
lin join_V2 = mkV2 (partV I.komma_V "med") (mkPrep "i") ;
lin join_V = partV I.komma_V "med" ;
lin reduce_V2 = mkV2 "sänker" | mkV2 "reducera" ;
lin reduce_V = mkV "minska" ;
lin establish_V2 = mkV2 (mkV "etablerar") ;
lin wall_N = mkN "vägg" ;
lin face_V2 = mkV2 "möter" ;
lin face_V = mkV "vågar" ;
lin easy_A = mkA "lätt" ;
lin private_A = mkA "privat" "privat" ;
lin computer_N = L.computer_N ;
lin hospital_N = mkN "sjukhus" neutrum ;
lin chapter_N = mkN "kapitel" neutrum ;
lin scheme_N = mkN "schema" "schemat" "scheman" "schemana" ;
lin theory_N = mkN "teori" "teorier" | mkN "lära" ;
lin choose_VV = mkVV (mkV "välja" "valde" "valt") ;
lin choose_V2 = mkV2 (mkV "välja" "valde" "valt") ;
lin wish_VV = mkVV (mkV "önska");
lin wish_VS = mkVS (mkV "önska");
lin wish_V2V = mkV2V (mkV "önska");
lin wish_V2 = mkV2 (mkV "önska");
lin wish_V = mkV "önskar" ;
lin property_N = mkN "egendom" | mkN "egenskap" "egenskaper" ;
lin property_2_N = mkN "egendom" ;
lin property_1_N = mkN "egenskap" "egenskaper" ;
lin achieve_V2 = mkV2 (mkV "åstadkomma" "åstadkom" "åstadkommit") | mkV2 (mkV "uppnå") ;
lin financial_A = mkA "finansiell" ;
lin poor_A = mkA "fattig" | mkA "stackars" ; ---
lin poor_3_A = mkA "usel" ;
lin poor_2_A = mkA "stackars" "stackars" "stackars" "mera stackars" "mest stackars" ;
lin poor_1_A = mkA "fattig" ;
lin officer_N = mkN "polis" | mkN "ämbetsman" "ämbetsmannen" "ämbetsmän" "ämbetsmännen" ; ---
lin officer_3_N = mkN "polis" "poliser" ;
lin officer_2_N = mkN "officer" "officern" "officer" "officerna" ;
lin officer_1_N = mkN "ämbetsman" "ämbetsmannen" "ämbetsmän" "ämbetsmännen" ;
lin up_Prep = mkPrep "upp" ;
lin charge_N = mkN "laddning" | mkN "åläggande" ; ---
lin charge_2_N = mkN "åläggande" ;
lin charge_1_N = mkN "laddning" ;
lin director_N = mkN "direktör" "direktörer" ;
lin drive_V2V = mkV2V (mkV "driva" "drev" "drivit") ;
lin drive_V2 = mkV2 (mkV "köra" "körde" "kört") ;
lin drive_V = mkV "köra" "körde" "kört" ;
lin deal_V2 = mkV2 (mkV "handlar") ;
lin deal_V = mkV "handlar" ;
lin place_V2 = mkV2 (mkV "placera") ;
lin approach_N = mkN "tillvägagångssätt" neutrum;
lin chance_N = mkN "slump" | mkN "chans" "chanser" ;
lin application_N = mkN "tillämpning" ;
lin seek_VV = mkVV (mkV "söker") ;
lin seek_V2 = L.seek_V2;
lin foreign_A = mkA "främmande" ;
lin foreign_2_A = mkA "främmande" ;
lin foreign_1_A = mkA "utländsk" ;
lin along_Prep = mkPrep "med" ;
lin top_N = mkN "topp" ;
lin amount_N = mkN "mängd" "mängder" ;
lin son_N = mkN "son" "söner" ;
lin operation_N = mkN "operation" "operationer" ;
lin fail_VV = mkVV (mkV "misslyckas") ;
lin fail_V2 = mkV2 "underkänner" ;
lin fail_V = mkV "misslyckas" ;
lin human_A = mkA "mänsklig" ;
lin opportunity_N = mkN "tillfälle" ;
lin simple_A = mkA "enkel" ;
lin leader_N = mkN "ledare" utrum ;
lin look_N = mkN "utseende" | mkN "blick" ;
lin share_N = mkN "andel" ;
lin production_N = mkN "produktion" "produktioner" | mkN "tillverkning" ;
lin recent_A = mkA "senare" ;
lin firm_N = mkN "firma" ;
lin picture_N = mkN "bild" "bilder" ;
lin source_N = mkN "källa" ;
lin security_N = mkN "säkerhet" "säkerheter" ;
lin serve_V2 = mkV2 "tjäna" ;
lin serve_V = mkV "tjäna" ;
lin according_to_Prep = mkPrep "enligt" ;
lin end_V2 = mkV2 "avsluta" ;
lin end_V = mkV "sluta" ;
lin contract_N = mkN "avtal" neutrum | mkN "kontrakt" neutrum ;
lin wide_A = L.wide_A ;
lin occur_V = mkV "förekomma" "förekom" "förekommit" ;
lin agreement_N = mkN "överenskommelse" "överenskommelser" | mkN "avtal" neutrum ;
lin better_Adv = mkAdv "bättre" ;
lin kill_V2 = L.kill_V2;
lin kill_V = mkV "döda" ;
lin act_V2 = dirV2 (partV (mkV "agerar")"ut");
lin act_V = mkV "agerar" ;
lin site_N = mkN "tomt" "tomter" | mkN "sajt" "sajter" ; --- split
lin either_Adv = mkAdv "heller" ;
lin labour_N = mkN "arbetskraft" | mkN "förlossningsarbete" ; --- split
lin plan_VV = mkVV (mkV "planera");
lin plan_VS = mkVS (mkV "planerar");
lin plan_V2V = mkV2V (mkV "planerar");
lin plan_V2 = mkV2 "planera" ;
lin plan_V = mkV "planera" ;
lin various_A = mkA "varierande" ;
lin since_Prep = mkPrep "sedan" ;
lin test_N = mkN "test" "testet" "tester" "testerna" ;
lin eat_V2 = L.eat_V2 ;
lin eat_V = mkV "äta" "åt" "ätit" ;
lin loss_N = mkN "förlust" "förluster" ;
lin close_V2 = L.close_V2 ;
lin close_V = mkV "stänger" ;
lin represent_V2 = mkV2 "representera" | mkV2 "företräda" "företrädde" "företrätt" ;
lin represent_V = mkV "representera" ;
lin love_VV = mkVV (mkV "älska") ;
lin love_V2 = L.love_V2 ;
lin colour_N = mkN "färg" "färger" ;
lin clearly_Adv = mkAdv "klart" | mkAdv "tydligen" ;
lin shop_N = L.shop_N ;
lin benefit_N = mkN "nytta" ;
lin animal_N = L.animal_N ;
lin heart_N = L.heart_N ;
lin election_N = mkN "val" "val" ;
lin purpose_N = mkN "mål" neutrum | mkN "avsikt" "avsikter" | mkN "ändamål" "ändamål" ;
lin standard_N = mkN "standard" "standarder" ;
lin due_A = mkA "vederbörlig" ;
lin secretary_N = mkN "sekreterare" utrum ;
lin rise_V2 = mkV2 "stiga" "steg" "stigit" ;
lin rise_V = mkV "stiga" "steg" "stigit" ;
lin date_N = mkN "datum" "datum" ; ---- deprecated
lin date_7_N = mkN "dadel" "dadlar" ;
lin date_3_N = mkN "träffkompis" ;
lin date_3_N = mkN "träffkompis" ;
lin date_1_N = mkN "datum" "datum" ;
lin hard_A = mkA "hård" "hårt" | mkA "häftig" ;
lin hard_2_A = mkA "svår" ;
lin hard_1_A = mkA "hård" "hårt" ;
lin music_N = L.music_N ;
lin hair_N = L.hair_N ;
lin prepare_VV = mkVV (reflV (mkV "förbereder")) ;
lin prepare_V2V = mkV2V (mkV "förbereder") ;
lin prepare_V2 = mkV2 (mkV "förbereder") ;
lin prepare_V = reflV (mkV "förbereder") ;
lin factor_N = mkN "faktor" "faktorer" ;
lin other_A = compoundA (mkA "annan" "annat" "andra" "andra" "andra") | mkA "övrig" | mkA "ytterligare" ;
lin anyone_NP = S.mkNP (mkPN "vem som helst" utrum) | S.mkNP (mkPN "någon" utrum) ; --- split pos/neg
lin pattern_N = mkN "mönster" "mönster" ;
lin manage_VV = mkVV (mkV "lyckas") ;
lin manage_V2 = mkV2 "leda" "ledde" "lett" ;
lin manage_V = mkV "klarar" ;
lin piece_N = mkN "stycke" ;
lin discuss_VS = mkVS (mkV "diskuterar") ;
lin discuss_V2 = mkV2 (mkV "diskuterar") ;
lin prove_VS = mkVS (mkV "visar") | mkVS (mkV "bevisar");
lin prove_VA = mkVA (reflV (mkV "visar")) ;
lin prove_V2 = mkV2 "bevisar" ;
lin prove_V = mkV "bevisar" ;
lin front_N = mkN "front" "fronter" ;
lin evening_N = mkN "kväll" ;
lin royal_A = mkA "kunglig" ;
lin tree_N = L.tree_N ;
lin population_N = mkN "befolkning" ;
lin fine_A = mkA "fin" | compoundA (regA "förfinad") ;
lin plant_N = mkN "växt" "växter" | mkN "planta" ;
lin pressure_N = mkN "tryck" neutrum | mkN "påtryckning" ;
lin response_N = mkN "respons" "responser" ;
lin catch_V2 = mkV2 "fånga" ;
lin street_N = mkN "gata" ;
lin pick_V2 = mkV2 "plocka" | mkV2 "välja" "valde" "valt" ;
lin pick_V = mkV "plocka" ;
lin performance_N = mkN "uppträdande" | mkN "utförande" ;
lin performance_2_N = mkN "uppträdande" ;
lin performance_1_N = mkN "prestation" "prestationer" ;
lin knowledge_N = mkN "kunskap" "kunskaper" ;
lin despite_Prep = mkPrep "trots" ;
lin design_N = mkN "design" "designer" ;
lin page_N = mkN "sida" ;
lin enjoy_VV = mkVV (partV I.njuta_V "av") ;
lin enjoy_V2 = mkV2 I.njuta_V (mkPrep "av") ;
lin individual_N = mkN "individ" neutrum ;
lin suppose_VS = mkV "anta" "antar" "anta" "antog" "antagit" "antagen" ;
lin suppose_V2 = mkV2 "anta" "antar" "anta" "antog" "antagit" "antagen" ;
lin rest_N = mkN "vila" ;
lin instead_Adv = mkAdv "i stället" ;
lin wear_V2 = mkV2 (reflV (partV (mkV "klä") "på")) ;
lin wear_V = mkV "föråldras" ; ----
lin basis_N = mkN "grundval" | mkN "basis" ;
lin size_N = mkN "storlek" ;
lin environment_N = mkN "miljö" "miljön" "miljöer" "miljöerna" ;
lin per_Prep = mkPrep "per" ;
lin fire_N = mkN "eld" ;
lin fire_2_N = mkN "brand" "bränder" ;
lin fire_1_N = L.fire_N;
lin series_N = mkN "serie" "serier" ;
lin success_N = mkN "framgång" ;
lin natural_A = mkA "naturlig" ;
lin wrong_A = mkA "fel" "fel" ;
lin near_Prep = mkPrep "nära" ;
lin round_Adv = mkAdv "runt" ;
lin thought_N = mkN "tanke" utrum | mkN "tänkande" ; ---
lin list_N = mkN "lista" ;
lin argue_VS = mkVS (mkV "argumenterar") ;
lin argue_V2 = mkV2 "argumenterar" ;
lin argue_V = mkV "argumenterar" ;
lin final_A = mkA "slutgiltig" ;
lin future_N = mkN "framtid" "framtider" ; ---- was split
lin future_3_N = mkN "framtid" "framtider" ;
lin future_1_N = mkN "framtid" "framtider" ;
lin introduce_V2 = mkV2 "införa" "införde" "infört" | mkV2 "introducera" ;
lin analysis_N = mkN "analys" "analyser" ;
lin enter_V2 = mkV2 "inträda" "inträdde" "inträtt" | mkV2 "inför" ; --- split
lin enter_V = mkV "inträda" "inträdde" "inträtt" ;
lin space_N = mkN "rymd" "rymder" ;
lin arrive_V = mkV "ankomma" "ankom" "ankommit" ;
lin ensure_VS = mkVS (mkV (mkV "se") "till") | mkVS (mkV "säkerställer") ;
lin ensure_V2 = mkV2 (mkV "säkerställer") ;
lin ensure_V = mkV "tillförsäkrar" ;
lin demand_N = mkN "efterfrågan" "efterfrågan" "efterfrågan" "efterfrågan" ;
lin statement_N = mkN "påstående" | mkN "uttalande" ;
lin to_Adv = mkAdv "vid" ;
lin attention_N = mkN "uppmärksamhet" "uppmärksamheter" ;
lin love_N = L.love_N ;
lin principle_N = mkN "princip" "principer" ;
lin pull_V2 = L.pull_V2 ;
lin pull_V = I.draga_V ;
lin set_N = mkN "uppsättning" ; ---- has been split
lin set_2_N = mkN "mängd" "mängder" ;
lin set_1_N = mkN "uppsättning" ;
lin doctor_N = L.doctor_N | mkN "doktor" "doktorer" ;
lin choice_N = mkN "val" "val" | mkN "valmöjlighet" "valmöjligheter" ;
lin refer_V2 = mkV2 (mkV "hänvisa") (mkPrep "till") ;
lin refer_V = mkV "hänvisa" ;
lin feature_N = mkN "drag" "drag" | mkN "särdrag" "särdrag" ;
lin couple_N = mkN "par" neutrum ;
lin step_N = mkN "steg" "steg" ;
lin following_A = mkA "följande" ;
lin thank_V2 = mkV2 (mkV "tackar");
lin machine_N = mkN "maskin" "maskiner" ;
lin income_N = mkN "inkomst" "inkomster" ;
lin training_N = mkN "träning" | mkN "utbildning" ;
lin present_V2 = mkV2 "presentera" ;
lin association_N = mkN "förening" | mkN "association" ; --- split
lin film_N = mkN "film" ; ---- has been split
lin film_2_N = mkN "hinna" ;
lin film_1_N = mkN "film" "filmer" ;
lin region_N = mkN "region" "regioner" ;
lin effort_N = mkN "ansträngning" ;
lin player_N = mkN "spelare" utrum ;
lin everyone_NP = S.everybody_NP ;
lin present_A = mkA "närvarande" ;
lin award_N = mkN "pris" "priset" "priser" "priserna" | mkN "tillerkännande" ;
lin village_N = L.village_N ;
lin control_V2 = mkV2 "kontrollera" | mkV2 "kolla" ;
lin organisation_N = mkN "organisation" "organisationer" ; --- british
lin whatever_Det = M.mkDet "vilken somhelst" "vilket somhelst" singular ;
lin news_N = mkN "nyhet" "nyheter" ;
lin nice_A = mkA "trevlig" | mkA "snäll" | mkA "snygg" ; --- split
lin difficulty_N = mkN "svårighet" "svårigheter" ;
lin modern_A = mkA "modern" ;
lin cell_N = mkN "cell" "celler" ;
lin close_A = mkA "närstående" | mkA "näraliggande" ;
lin current_A = mkA "aktuell" ;
lin legal_A = mkA "laglig" ;
lin energy_N = mkN "energi" "energin" "energier" "energierna" ;
lin finally_Adv = mkAdv "äntligen" ;
lin degree_N = mkN "grad" "grader" ; ---- has been split
lin degree_3_N = mkN "grad" "grader" ;
lin degree_2_N = mkN "examen" "examen" "examina" "examina" ;
lin degree_1_N = mkN "mån" ;
lin mile_N = mkN "mil" "milen" "mil" "milen" ;
lin means_N = mkN "medel" neutrum ;
lin growth_N = mkN "tillväxt" "tillväxter" ;
lin treatment_N = mkN "behandling" ;
lin sound_N = mkN "ljud" "ljud" ;
lin above_Prep = S.above_Prep;
lin task_N = mkN "uppgift" "uppgifter" ;
lin provision_N = mkN "provision" "provisioner" ;
lin affect_V2 = mkV2 "påverka" ;
lin please_Adv = mkAdv "snälla" ;
lin red_A = L.red_A;
lin happy_A = mkA "lycklig" | mkA "glad" ;
lin behaviour_N = mkN "beteende" | mkN "uppförande" ;
lin concerned_A = mkA "orolig" | mkA "involverad" ; --- split
lin point_V2 = dirV2 (partV (mkV "pekar")"ut") ;
lin point_V = mkV "siktar" ;
lin function_N = mkN "funktion" "funktioner" ;
lin identify_V2 = mkV2 "identifiera" ;
lin identify_V = mkV "identifierar" ;
lin resource_N = mkN "resurs" "resurser" | mkN "tillgång" ;
lin defence_N = mkN "försvar" "försvar" ;
lin garden_N = L.garden_N ;
lin floor_N = L.floor_N ;
lin technology_N = mkN "teknologi" "teknologier" ;
lin style_N = mkN "stil" ;
lin feeling_N = mkN "känsla" ;
lin science_N = L.science_N ;
lin relate_V2 = mkV2 "relatera" ;
lin relate_V = mkV "relatera" ;
lin doubt_N = mkN "tvivel" neutrum ;
lin horse_N = L.horse_N ;
lin force_VS = mkVS (mkV "tvingar") ;
lin force_V2V = mkV2V (mkV "tvingar") ;
lin force_V2 = dirV2 (partV (mkV "tvinga")"på") ;
lin force_V = mkV "tvinga" ;
lin answer_N = mkN "svar" neutrum ;
lin compare_V = mkV "jämföra" "jämförde" "jämfört" ;
lin suffer_V2 = mkV2 "lida" "led" "lidit" ;
lin suffer_V = mkV "lida" "led" "lidit" ;
lin individual_A = mkA "individuell" ;
lin forward_Adv = mkAdv "framåt" ;
lin announce_VS = mkVS (mkV "annonserar") ;
lin announce_V2 = mkV2 "utlyser" ;
lin userMasc_N = mkN "användare" "användare" ;
lin fund_N = mkN "fond" "fonder" ;
lin character_2_N = mkN "bokstav" "bokstäver" ;
lin character_1_N = mkN "karaktär" "karaktärer" ;
lin risk_N = mkN "risk" "risker" ;
lin normal_A = mkA "normal" ;
lin nor_Conj = M.mkConj "inte heller" ; ---- not the same as in neither-nor
lin dog_N = L.dog_N ;
lin obtain_V2 = mkV2 (mkV "erhålla" "erhöll" "erhållit") ;
lin obtain_V = mkV "råder" ;
lin quickly_Adv = mkAdv "snabbt" | mkAdv "fort" ;
lin army_N = mkN "armé" "arméer" ;
lin indicate_VS = mkVS (mkV "indikera") | mkVS (mkV "visa") ;
lin indicate_V2 = mkV2 (mkV "indikera") | mkV2 (mkV "visa") ;
lin forget_VS = mkVS (mkV "glömmer") ;
lin forget_V2 = L.forget_V2;
lin forget_V = mkV "glömmer" ;
lin station_N = mkN "station" "stationer" ;
lin glass_N = mkN "glas" "glas" ;
lin cup_N = mkN "kopp" | mkN "bål" neutrum ;
lin previous_A = mkA "föregående" ;
lin husband_N = L.husband_N ;
lin recently_Adv = mkAdv "nyligen" ;
lin publish_V2 = mkV2 "publicera" ;
lin publish_V = mkV "publicerar" ;
lin serious_A = mkA "allvarlig" | mkA "seriös" ;
lin anyway_Adv = mkAdv "i alla fall" ;
lin visit_V2 = mkV2 (mkV "besöker") ;
lin visit_V = mkV "besöker" ;
lin capital_N = mkN "versal" "versaler" | mkN "stor" ; ---- has been split
lin capital_3_N = mkN "versal" "versaler" ;
lin capital_2_N = mkN "kapital" "kapital" ;
lin capital_1_N = mkN "huvudstad" "huvudstäder" ;
lin either_Det = M.mkDet "båda" plural ;
lin note_N = mkN "not" "noter" ; ---- has been split
lin note_3_N = mkN "not" "noter" ;
lin note_2_N = mkN "anmärkning" | mkN "notis" "notiser" ;
lin note_1_N = mkN "anteckning" ;
lin season_N = mkN "årstid" "årstider" ;
lin argument_N = mkN "argument" "argument" ;
lin listen_V = mkV "lyssnar" ;
lin show_N = mkN "show" "shower" ;
lin responsibility_N = mkN "ansvar" neutrum ;
lin significant_A = mkA "signifikant" "signifikant" ;
lin deal_N = mkN "affär" "affärer" ;
lin prime_A = mkA "primär" | mkA "prim" ; --- split -- | prime number
lin economy_N = mkN "sparsamhet" | mkN "besparing" ;
lin economy_2_N = mkN "sparsamhet" | mkN "besparing" ;
lin economy_1_N = mkN "ekonomi" "ekonomin" "ekonomier" "ekonomierna" ;
lin element_N = mkN "element" neutrum | mkN "grundämne" ;
lin finish_V2 = mkV2 "avsluta" ;
lin finish_V = mkV "sluta" ;
lin duty_N = mkN "plikt" "plikter" ;
lin fight_V2 = L.fight_V2;
lin fight_V = mkV "kämper" ;
lin train_V2V = mkV2V (mkV "träna") ;
lin train_V2 = mkV2 (mkV "träna") ;
lin train_V = mkV "träna" ;
lin maintain_VS = mkVS (mkV "påstå" "påstod" "påstått") ;
lin maintain_V2 = mkV2 (mkV "upprätthålla" "upprätthöll" "upprätthållit") ;
lin maintain_V = mkV "underhålla" "underhöll" "underhållit" ;
lin attempt_N = mkN "försök" neutrum;
lin leg_N = L.leg_N ;
lin investment_N = mkN "investering" ;
lin save_V2 = mkV2 "spara" ;
lin save_V = mkV "sparar" ;
lin throughout_Prep = mkPrep "genom" ;
lin design_V2 = mkV2 "designa" ;
lin design_V = mkV "designa" ;
lin suddenly_Adv = mkAdv "plötsligt" ;
lin brother_N = mkN "bror" "brodern" "bröder" "bröderna" | mkN "broder" "brodern" "bröder" "bröderna" ;
lin improve_V2 = mkV2 "förbättra" ;
lin improve_V = mkV "förbättra" ;
lin avoid_VV = mkVV (mkV "undvika" "undvek" "undvikit") ;
lin avoid_V2 = mkV2 "undvika" "undvek" "undvikit" ;
lin wonder_VQ = L.wonder_VQ ;
lin wonder_V = mkV "undrar" ;
lin tend_VV = mkVV (mkV "tendera") ;
lin tend_V2 = mkV2 "spänner" ;
lin title_N = mkN "titel" "titlar" ;
lin hotel_N = mkN "hotell" neutrum ;
lin aspect_N = mkN "aspekt" "aspekter" ;
lin increase_N = mkN "ökning" ;
lin help_N = mkN "hjälp" ;
lin industrial_A = mkA "industriell" ;
lin express_V2 = mkV2 "uttrycker" ;
lin summer_N = mkN "sommar" "sommarn" "somrar" "somrarna" | mkN "sommar" "sommaren" "somrar" "somrarna" ;
lin determine_VV = mkVV (reflV (mkV "bestämmer")) ;
lin determine_VS = mkVS (reflV (mkV "bestämmer")) ;
lin determine_V2V = mkV2V (mkV "bestämmer") ;
lin determine_V2 = mkV2 (mkV "avgöra" "avgjorde" "avgjort") | mkV2 (mkV "bestämmer") ;
lin determine_V = mkV "bestämmer" ;
lin generally_Adv = mkAdv "allmänt" | mkAdv "generellt" ;
lin daughter_N = mkN "dotter" "dottern" "döttrar" "döttrarna" ;
lin exist_V = mkV "existera" ;
lin share_V2 = mkV2 "dela" ;
lin share_V = mkV "delar" ;
lin baby_N = L.baby_N ;
lin nearly_Adv = mkAdv "nästan" ;
lin smile_V = mkV "le" "log" "lett" ;
lin sorry_A = mkA "ledsen" "ledset" ;
lin sea_N = L.sea_N ;
lin skill_N = mkN "färdighet" "färdigheter" ;
lin claim_N = mkN "påstående" ;
lin treat_V2 = mkV2 "betjäna" ; ----
lin treat_V = mkV "serva" ;
lin remove_V2 = mkV2 "avlägsna" ;
lin remove_V = mkV "avlägsna" ;
lin concern_N = mkN "omsorg" "omsorger" | mkN "oro" ; ---- split
lin university_N = L.university_N ;
lin left_A = compoundA (regA "vänster");
lin dead_A = mkA "död" "dött" ;
lin discussion_N = mkN "diskussion" "diskussioner" ;
lin specific_A = mkA "specifik" | mkA "särskild" ;
lin customerMasc_N = mkN "kund" "kunder" ;
lin box_N = mkN "box" | mkN "ruta" ; ---- split
lin outside_Prep = mkPrep "utanför" ;
lin state_VS = mkVS (mkV "förklara") ;
lin state_V2 = mkV2 (mkV "förklara") ;
lin conference_N = mkN "konferens" "konferenser" ;
lin whole_N = mkN "helhet" "helheter" ;
lin total_A = mkA "total" ;
lin profit_N = mkN "vinst" "vinster" ;
lin division_N = mkN "division" "divisioner" | mkN "skiljevägg" ;
lin division_3_N = mkN "division" "divisioner" ;
lin division_2_N = mkN "division" "divisioner" ;
lin division_1_N = mkN "avdelning" ;
lin throw_V2 = L.throw_V2;
lin throw_V = mkV "kasta" | mkV "slänger" ;
lin procedure_N = mkN "procedur" "procedurer" | mkN "tillvägagångssätt" neutrum ;
lin fill_V2 = mkV2 "fyller" ;
lin fill_V = mkV "fyller" ;
lin king_N = L.king_N ;
lin assume_VS = mkVS (mkV "anta" "antar" "anta" "antog" "antagit" "antagen") ;
lin assume_V2 = mkV2 "förutsätta" "förutsatte" "förutsatt" | mkV2 (mkV "anta" "antar" "anta" "antog" "antagit" "antagen") ;
lin image_N = mkN "bild" "bilder" ;
lin oil_N = L.oil_N ;
lin obviously_Adv = mkAdv "tydligen" ;
lin unless_Subj = M.mkSubj "om inte" ;
lin appropriate_A = mkA "lämplig" ;
lin circumstance_N = mkN "förhållande" | mkN "omständighet" "omständigheter" ;
lin military_A = mkA "militär" ;
lin proposal_N = mkN "förslag" neutrum | mkN "ansökan" "ansökan" "ansökningar" "ansökningarna" ; ---- split
lin mention_VS = mkVS (mkV "nämner") ;
lin mention_V2 = mkV2 (mkV "nämner") ;
lin mention_V = mkV "nämner" ;
lin client_N = mkN "klient" "klienter" ;
lin sector_N = mkN "sektor" "sektorer" ;
lin direction_N = mkN "riktning" ;
lin admit_VS = mkV "erkänna" "erkände" "erkänt" ;
lin admit_V2 = mkV2 (mkV "tillåta" "tillät" "tillåtit") ;
lin admit_V = mkV "tillåta" "tillät" "tillåtit" ;
lin though_Adv = mkAdv "ändå" ;
lin replace_V2 = mkV2 "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" ;
lin basic_A = mkA "fundamental" ;
lin hard_Adv = mkAdv "hårt" ;
lin instance_N = mkN "instans" "instanser" ;
lin sign_N = mkN "tecken" "tecknet" "tecken" "tecknen" ;
lin original_A = mkA "ursprunglig" ;
lin successful_A = mkA "framgångsrik" ;
lin okay_Adv = mkAdv "okej" ;
lin reflect_V2 = mkV2 "reflektera" ; ---- split
lin reflect_V = mkV "reflektera" ;
lin aware_A = mkA "medveten" "medvetet" ;
lin measure_N = mkN "mått" neutrum | mkN "åtgärd" "åtgärder" ; ---- split
lin attitude_N = mkN "inställning" | mkN "attityd" "attityder" ;
lin disease_N = mkN "sjukdom" ;
lin exactly_Adv = mkAdv "exakt" ;
lin above_Adv = mkAdv "ovanför" ;
lin commission_N = mkN "kommissionen" "kommissioner" | mkN "provision" "provisioner" ; ---- split
lin intend_VV = mkVV (mkV "tänker") ;
lin beyond_Prep = mkPrep "bortom" ;
lin seat_N = mkN "stol" ;
lin presidentMasc_N = mkN "president" "presidenter" ;
lin encourage_V2V = mkV2V (mkV "uppmuntrar");
lin encourage_V2 = mkV2 (mkV "uppmuntrar") ;
lin addition_N = mkN "tillägg" neutrum | mkN "addition" "additioner" ; ---- split
lin goal_N = mkN "mål" neutrum ; ---- split
lin round_Prep = mkPrep "kring" ;
lin miss_V2 = mkV2 "sakna" | mkV2 "missa" ; ---- split
lin miss_V = mkV "missa" ;
lin popular_A = mkA "populär" ;
lin affair_N = mkN "affär" "affärer" | mkN "händelse" "händelser" ; ---- split
lin technique_N = mkN "teknik" "tekniker" ;
lin respect_N = mkN "respekt" "respekter" ;
lin drop_V2 = mkV2 "tappa" ;
lin drop_V = mkV "tappa" ;
lin professional_A = mkA "professionell" | mkA "proffsig" ;
lin less_Det = M.mkDet "mindre" singular;
lin once_Subj = M.mkSubj "en gång" ;
lin item_N = mkN "sak" "saker" | mkN "artikel" ;
lin fly_V2 = mkV2 "flyga" "flög" "flugit" ;
lin fly_V = L.fly_V ;
lin reveal_VS = mkVS (mkV "avslöja") ;
lin reveal_V2 = mkV2 "avslöja" ;
lin version_N = mkN "version" "versioner" ;
lin maybe_Adv = mkAdv "kanske" ;
lin ability_N = mkN "förmåga" ;
lin operate_V2 = mkV2 "operera" | mkV2 "sköter" ;
lin operate_V = mkV "sköter" ;
lin good_N = mkN "nytta" ;
lin campaign_N = mkN "kampanj" "kampanjer" ;
lin heavy_A = L.heavy_A ;
lin advice_N = mkN "råd" neutrum ;
lin institution_N = mkN "institution" "institutioner" ;
lin discover_VS = mkVS (mkV "upptäcker") ;
lin discover_V2 = mkV2 (mkV "upptäcker") ;
lin discover_V = mkV "upptäcker" ;
lin surface_N = mkN "yta" ;
lin library_N = mkN "bibliotek" neutrum | mkN "bibliotek" neutrum ;
lin pupil_N = mkN "elev" "elever" | mkN "pupill" "pupiller" ; --- split -- | school pupil -- | eye pupil
lin record_V2 = dirV2 (partV (mkV "spela")"in") ;
lin refuse_VV = mkVV (mkV "vägra") ;
lin refuse_V2 = mkV2 (mkV "vägra") ;
lin refuse_V = mkV "avböjer" ;
lin prevent_V2 = mkV2 (mkV "förhindra");
lin advantage_N = mkN "fördel" ;
lin dark_A = mkA "mörk" | mkA "dunkel" ; --- split -- | it is dark in the night -- | dark clothes
lin teach_V2V = mkV2V (mkV "lär") ;
lin teach_V2 = L.teach_V2;
lin teach_V = mkV "undervisar" ;
lin memory_N = mkN "minne" ;
lin culture_N = mkN "kultur" "kulturer" ;
lin blood_N = L.blood_N ;
lin cost_V2 = dirV2 (partV (mkV "kostar")"på");
lin cost_V = mkV "kostar" ;
lin majority_N = mkN "majoritet" "majoriteter" ;
lin answer_V2 = mkV2 (mkV "svara") (mkPrep "på") | mkV2 (mkV "besvara") ;
lin answer_V = mkV "svara" ;
lin variety_N = mkN "omväxling" | mkN "sort" "sorter" ; --- already split
lin variety_2_N = mkN "sort" "sorter" ;
lin variety_1_N = mkN "omväxling" ;
lin press_N = mkN "press" ;
lin depend_V = mkV "bero" ;
lin bill_N = mkN "räkning" | mkN "sedel" ; --- split -- | send me the bill -- | ten-dollar bill
lin competition_N = mkN "tävling" ;
lin ready_A = mkA "färdig" | mkA "beredd" | mkA "rask" ;
lin general_N = mkN "general" "generaler" ;
lin access_N = mkN "tillgång" | mkN "tillträde" ;
lin hit_V2 = L.hit_V2 ; --- split -- | hit the ball -- | hit the target
lin hit_V = mkV "slå" "slog" "slagit" | mkV "träffa" ;
lin stone_N = L.stone_N ;
lin useful_A = mkA "nyttig" ;
lin extent_N = mkN "omfattning" ;
lin employment_N = mkN "anställning" ;
lin regard_V2 = mkV2 "betrakta" ;
lin regard_V = mkV "betraktar" ;
lin apart_Adv = mkAdv "avsides" | mkAdv "separat" ;
lin present_N = mkN "present" "presenter" | mkN "gåva" ;
lin appeal_N = mkN "attraktion" "attraktioner" | mkN "vädjan" "vädjan" "vädjan" "vädjan" ; --- split
lin text_N = mkN "text" "texter" ;
lin parliament_N = mkN "parlament" neutrum | mkN "riksdag" ;
lin cause_N = mkN "orsak" "orsaker" ;
lin terms_N = mkN "term" "termer" ; ---
lin bar_N = mkN "bar" "barer" | mkN "stång" "stänger" ; ---- already split
lin bar_2_N = mkN "stång" "stänger" ;
lin bar_1_N = mkN "bar" "barer" ;
lin attack_N = mkN "anfall" neutrum ;
lin effective_A = mkA "effektiv" | mkA "faktisk" ;
lin mouth_N = L.mouth_N ;
lin down_Prep = mkPrep "ner" | mkPrep "nerför" ;
lin result_V = mkV "resultera" | mkV "utfalla" "utföll" "utfallit" ;
lin fish_N = L.fish_N ;
lin future_A = mkA "framtida" ;
lin visit_N = mkN "besök" neutrum | mkN "visit" "visiter" | mkN "vistelse" "vistelser" ;
lin little_Adv = mkAdv "lite" ;
lin easily_Adv = mkAdv "lätt" ;
lin attempt_VV = mkVV (mkV "försöker") ;
lin attempt_V2 = mkV2 (mkV "försöker") ;
lin enable_VS = mkVS (mkV "möjliggöra" "möjliggjorde" "möjliggjort") ;
lin enable_V2V = mkV2V (mkV "möjliggöra" "möjliggjorde" "möjliggjort") ;
lin enable_V2 = mkV2 (mkV "möjliggöra" "möjliggjorde" "möjliggjort") ;
lin trouble_N = mkN "problem" neutrum | mkN "bekymmer" neutrum ;
lin traditional_A = mkA "traditionell" ;
lin payment_N = mkN "betalning" ;
lin best_Adv = mkAdv "bäst" ;
lin post_N = mkN "post" "poster" ;
lin county_N = mkN "län" neutrum ;
lin lady_N = mkN "dam" "damer" ;
lin holiday_N = mkN "semester" | mkN "lov" "lovet" ;
lin realize_VS = mkVS (mkV "inse" "insåg" "insett") ;
lin realize_V2 = mkV2 (mkV "inse" "insåg" "insett") ;
lin importance_N = mkN "viktighet" "viktigheter" | mkN "vikt" "vikter" ;
lin chair_N = L.chair_N ;
lin facility_N = mkN "facilitet" "faciliteter" | mkN "tillfälle" ;
lin complete_V2 = mkV2 "komplettera" ;
lin complete_V = mkV "kompletterar" ;
lin article_N = mkN "artikel" "artiklar" ; --- split -- | newspaper article -- | definite article
lin object_N = mkN "objekt" neutrum | mkN "sak" "saker" ;
lin context_N = mkN "kontext" "kontexter" | mkN "sammanhang" neutrum ;
lin survey_N = mkN "översikt" "översikter" | mkN "utredning" ; --- split
lin notice_VS = mkVS (mkV "notera") | mkVS (mkV "märker") ;
lin notice_V2 = mkV2 (mkV "notera") | mkV2 (mkV "märker") ;
lin complete_A = mkA "fullständig" | mkA "komplett" ;
lin turn_N = mkN "vändning" | mkN "tur" "turer" ; --- split -- | make a turn -- | your turn
lin direct_A = mkA "direkt" "direkt" ;
lin immediately_Adv = mkAdv "omedelbart" ;
lin collection_N = mkN "samling" ;
lin reference_N = mkN "referens" "referenser" | mkN "hänvisning" ;
lin card_N = mkN "kort" neutrum ;
lin interesting_A = mkA "intressant" "intressant" ;
lin considerable_A = mkA "avsevärd" "avsevärt" | mkA "ansenlig" ;
lin television_N = L.television_N ;
lin extend_V2 = mkV2 "utvidga" ;
lin extend_V = mkV "räcker" ;
lin communication_N = mkN "kommunikation" "kommunikationer" | mkN "överförande" ;
lin agency_N = mkN "kontor" "kontor" | mkN "byrå" "byråer" ;
lin physical_A = mkA "fysisk" ;
lin except_Conj = M.mkConj "förutom" ;
lin check_V2 = mkV2 "kontrollera" | mkV2 "kolla" ;
lin check_V = mkV "kontrollera" | mkV "kolla" ;
lin sun_N = L.sun_N ;
lin species_N = mkN "art" "arter" | mkN "slag" neutrum ;
lin possibility_N = mkN "möjlighet" "möjligheter" | mkN "utsikt" "utsikter" ;
lin officialMasc_N = mkN "myndighet" "myndigheter" ;
lin chairman_N = mkN "ordförande" "ordföranden" "ordförande" "ordförandena" | mkN "talman" "talmannen" "talmän" "talmännen" ;
lin speaker_N = mkN "talare" utrum ;
lin second_N = mkN "sekund" "sekunder" ;
lin career_N = mkN "karriär" "karriärer" ;
lin laugh_VS = mkVS (mkV (mkV "skrattar") "åt") ; ----
lin laugh_V2 = mkV2 (mkV "skratta") (mkPrep "åt") ;
lin laugh_V = L.laugh_V ;
lin weight_N = mkN "vikt" "vikter" ;
lin sound_VS = mkVS I.låta_V ;
lin sound_VA = mkVA I.låta_V ;
lin sound_V2 = mkV2 I.låta_V ;
lin sound_V = I.låta_V ;
lin responsible_A = mkA "ansvarig" ;
lin base_N = mkN "grund" "grunder" ;
lin document_N = mkN "dokument" neutrum ;
lin solution_N = mkN "lösning" ;
lin return_N = mkN "återkomst" "återkomster" | mkN "retur" "returer" ;
lin medical_A = mkA "medicinsk" ;
lin hot_A = L.hot_A ;
lin recognize_VS = mkVS (mkV "erkänner") ;
lin recognize_4_V2 = mkV2 (mkV (mkV "känna" "kände" "känt") "igen") ;
lin recognize_1_V2 = mkV2 (mkV (mkV "känna" "kände" "känt") "igen") ;
lin talk_N = mkN "samtal" neutrum | mkN "snack" neutrum ;
lin budget_N = mkN "budget" ;
lin river_N = L.river_N ;
lin fit_V2 = mkV2 (mkV "passar") ;
lin fit_V = mkV "passa" ;
lin organization_N = mkN "organisation" "organisationer" ;
lin existing_A = mkA "befintlig" | mkA "existerande" ;
lin start_N = mkN "start" "starter" | mkN "början" "början" "början" "början" ;
lin push_VS = mkVS (mkV I.skjuta_V "på") ;
lin push_V2V = mkV2V (mkV I.skjuta_V "på") ;
lin push_V2 = L.push_V2;
lin push_V = I.skjuta_V ;
lin tomorrow_Adv = mkAdv "i morgon" | mkAdv "imorgon" ;
lin requirement_N = mkN "krav" neutrum ;
lin cold_A = L.cold_A ;
lin edge_N = mkN "kant" "kanter" | mkN "skärpa" ; --- split -- | on the edge -- | knife edge
lin opposition_N = mkN "opposition" "oppositioner" ;
lin opinion_N = mkN "åsikt" "åsikter" | mkN "opinion" "opinioner" ;
lin drug_N = mkN "drog" "droger" ;
lin quarter_N = mkN "kvarter" "kvarteret" "kvarter" "kvarteren" | mkN "stadsdel" "stadsdelen" "stadsdelar" "stadsdelarna" | mkN "kvart" "kvarter" | mkN "fjärdedel" ; --- split -- | in our quarter -- | quarter past -- | quarter of
lin option_N = mkN "option" "optioner" | mkN "tillval" ;
lin sign_V2 = mkV2 "underteckna" | mkV2 (mkV I.skriva_V "på") ;
lin sign_V = mkV "undertecknar" ;
lin worth_Prep = mkPrep "värt" ;
lin call_N = mkN "anrop" "anrop" | mkN "kallelse" "kallelser" | mkN "telefonsamtal" neutrum ; --- split -- | function call -- | phone call
lin define_V2 = mkV2 "definiera" ;
lin define_V = mkV "definiera" ;
lin stock_N = mkN "lager" "lager" | mkN "aktie" "aktier" | mkN "fond" "fonder" ; --- split -- | we have it in stock -- | stock market -- | fish stock
lin influence_N = mkN "inflytande" ;
lin occasion_N = mkN "tillfälle" | mkN "evenemang" neutrum ;
lin eventually_Adv = mkAdv "till slutet" ;
lin software_N = mkN "mjukvara" | mkN "programvara" ;
lin highly_Adv = mkAdv "i högsta grad" ;
lin exchange_N = mkN "utbyte" | mkN "växling" ; --- -- | student exchange -- | money exchange
lin lack_N = mkN "brist" "brister" ;
lin shake_V2 = dirV2 (partV (mkV "skaka")"om") ;
lin shake_V = mkV "skaka" ;
lin study_V2 = mkV2 "studera" ;
lin study_V = mkV "studera" ;
lin concept_N = mkN "begrepp" neutrum ;
lin blue_A = L.blue_A;
lin star_N = L.star_N ;
lin radio_N = L.radio_N ;
lin arrangement_N = mkN "arrangemang" neutrum | mkN "åtgärd" "åtgärder" ;
lin examine_V2 = mkV2 (mkV "undersöker") ;
lin bird_N = L.bird_N ;
lin green_A = L.green_A ;
lin band_N = mkN "band" "band" ;
lin sex_N = mkN "sex" neutrum | mkN "kön" neutrum ; --- split -- | sex movie -- | both sexes
lin finger_N = mkN "finger" "fingret" "fingrar" "fingrarna" ;
lin past_N = mkN "förflutet" "förflutet" "förflutet" "förflutet" ; ---- inflection
lin independent_A = mkA "oberoende" | mkA "självständig" | mkA "särskild" "särskilt" ;
lin independent_2_A = mkA "självständig" ;
lin independent_1_A = mkA "oberoende" ;
lin equipment_N = mkN "utrustning" ;
lin north_N = mkN "norr" | mkN "nord" ;
lin mind_VS = mkVS (mkV (reflV (mkV "bry")) "om") ;
lin mind_V2 = mkV2 (reflV (mkV "bry")) (mkPrep "om") ;
lin mind_V = reflV (mkV "bry") ;
lin move_N = mkN "drag" "drag" ;
lin message_N = mkN "meddelande" | mkN "budskap" "budskap" ;
lin fear_N = mkN "rädsla" ;
lin afternoon_N = mkN "eftermiddag" ;
lin drink_V2 = L.drink_V2 ;
lin drink_V = mkV "dricka" "drack" "druckit" | mkV "supa" "söp" "supit" ;
lin fully_Adv = mkAdv "fullt" | mkAdv "fullt ut" ;
lin race_N = mkN "ras" "raser" | mkN "tävling" | mkN "race" ; ---- alreadu split
lin race_2_N = mkN "ras" "ras" ;
lin race_1_N = mkN "tävling" ;
lin gain_V2 = mkV2 "vinna" "vann" "vunnit" ;
lin gain_V = mkV "vinna" "vann" "vunnit" ;
lin strategy_N = mkN "strategi" "strategier" ;
lin extra_A = mkA "extra" ;
lin scene_N = mkN "scen" "scener" ;
lin slightly_Adv = mkAdv "något" ;
lin kitchen_N = mkN "kök" neutrum ;
lin speech_N = mkN "tal" neutrum ;
lin arise_V = mkV "uppstå" "uppstod" "uppstått" ;
lin network_N = mkN "nätverk" neutrum ;
lin tea_N = mkN "te" "teet" "teer" "teerna" ;
lin peace_N = L.peace_N ;
lin failure_N = mkN "misslyckande" ;
lin employee_N = mkN "arbetstagare" utrum | mkN "anställd" "anställda" "anställda" "anställda" ; ---- inflection
lin ahead_Adv = mkAdv "före" ;
lin scale_N = mkN "skala" | mkN "fjäll" "fjäll" ; --- split
lin hardly_Adv = mkAdv "knappast" ;
lin attend_V2 = mkV2 (mkV "delta" "deltar" "delta" "deltog" "deltagit" "deltagen") (mkPrep "i") ;
lin attend_V = mkV "delta" "deltar" "delta" "deltog" "deltagit" "deltagen" ;
lin shoulder_N = mkN "skulder" "skulder" ;
lin otherwise_Adv = mkAdv "annars" ;
lin railway_N = mkN "järnväg" ;
lin directly_Adv = mkAdv "direkt" ;
lin supply_N = mkN "tillgång" ;
lin expression_N = mkN "uttryck" neutrum | mkN "yttrande" ; --- split
lin owner_N = mkN "ägare" utrum ;
lin associate_V2 = mkV2 "associera" ;
lin associate_V = mkV "associera" ;
lin corner_N = mkN "hörna" | mkN "hörn" "hörn" | mkN "vrå" "vrån" "vrår" "vrårna" ;
lin past_A = mkA "förfluten" "förflutet" ;
lin match_N = mkN "tändsticka" ;
lin match_3_N = mkN "överenskommelse" "överenskommelser" ;
lin match_2_N = mkN "tändsticka" ;
lin match_1_N = mkN "match" "matcher" ;
lin sport_N = mkN "sport" "sporter" ;
lin status_N = mkN "status" | mkN "ställning" ;
lin beautiful_A = L.beautiful_A ;
lin offer_N = mkN "erbjudande" ;
lin marriage_N = mkN "äktenskap" neutrum | mkN "giftermål" neutrum ;
lin hang_V2 = mkV2 (mkV "hänger") ;
lin hang_V = mkV "hänger" ;
lin civil_A = mkA "civil" | mkA "medborgerlig" ;
lin perform_V2 = mkV2 "framträda" "framträdde" "framträtt" ;
lin perform_V = mkV "prestera" | mkV "framträda" "framträdde" "framträtt" ; --- split
lin sentence_N = mkN "sats" "satser" | mkN "mening" | mkN "dom" ; --- split
lin crime_N = mkN "brott" neutrum ;
lin ball_N = mkN "boll" | mkN "klot" "klot" ; --- split
lin marry_V2 = mkV2 (mkV "gifter") ;
lin marry_V = depV (mkV "gifter") | reflV (mkV "gifter") ;
lin wind_N = L.wind_N ;
lin truth_N = mkN "sanning" ;
lin protect_V2 = mkV2 (mkV "skyddar") ;
lin protect_V = mkV "skyddar" ;
lin safety_N = mkN "säkerhet" "säkerheter" | mkN "trygghet" "tryggheter" ;
lin partner_N = mkN "partner" "partnern" "partner" "partnerna" ;
lin completely_Adv = mkAdv "fullständigt" ;
lin copy_N = mkN "kopia" | mkN "reproduktion" "reproduktioner" ;
lin balance_N = mkN "balans" "balanser" ;
lin sister_N = L.sister_N ;
lin reader_N = mkN "läsare" utrum ;
lin below_Adv = mkAdv "nedanför" ;
lin trial_N = mkN "prövning" | mkN "rättegång" ;
lin rock_N = L.rock_N ;
lin damage_N = mkN "skada" ;
lin adopt_V2 = mkV2 "adoptera" ;
lin newspaper_N = L.newspaper_N;
lin meaning_N = mkN "mening" | mkN "innebörd" "innebörder" | mkN "betydelse" "betydelser" ;
lin light_A = mkA "lätt" ;
lin essential_A = mkA "väsentlig" ;
lin obvious_A = mkA "uppenbar" | mkA "klar" ;
lin nation_N = mkN "nation" "nationer" ;
lin confirm_VS = mkVS (mkV "bekräfta") | mkVS (mkV "konfirmera") ;
lin confirm_V2 = mkV2 (mkV "bekräfta") | mkV2 (mkV "konfirmera") ;
lin south_N = mkN "söder" | mkN "syd" ;
lin length_N = mkN "längd" "längder" ;
lin branch_N = mkN "gren" "grenen" "grenar" "grenarna" ;
lin deep_A = mkA "djup" ;
lin none_NP = S.mkNP (mkPN "ingen") ; ---- inget
lin planning_N = mkN "planering" ;
lin trust_N = mkN "förtroende" | mkN "tillit" | mkN "förvaltning" ;
lin working_A = mkA "fungerande" | mkA "arbetande" ; ---- split
lin pain_N = mkN "smärta" ;
lin studio_N = mkN "studio" "studior" | mkN "ateljé" "ateljéer" ;
lin positive_A = mkA "positiv" ;
lin spirit_N = mkN "ande" "andar" ;
lin college_N = mkN "college" "colleget" "college" "collegen" ;
lin accident_N = mkN "olycka" ;
lin star_V2 = dirV2 (partV (mkV "agerar")"ut") ; ---- sense
lin hope_N = mkN "hopp" "hoppet" | mkN "förhoppning" ;
lin mark_V3 = mkV3 (mkV "markera");
lin mark_V2 = dirV2 (mkV "markera") ;
lin works_N = mkN "verk" "verk" ;
lin league_N = mkN "serie" "serier" ;
lin league_2_N = mkN "serie" "serier" ;
lin league_1_N = mkN "liga" ;
lin clear_V2 = mkV2 "rensa" ;
lin clear_V = mkV "klarna" ;
lin imagine_VS = mkVS (mkV (mkV "föreställa") "sig");
lin imagine_V2 = mkV2 (mkV (mkV "föreställa") "sig");
lin imagine_V = mkV "inbilla" ;
lin through_Adv = mkAdv "igenom" ;
lin cash_N = mkN "kontant" "kontanter" ;
lin normally_Adv = mkAdv "normalt" ;
lin play_N = mkN "pjäs" "pjäser" ;
lin strength_N = mkN "styrka" ;
lin train_N = L.train_N ;
lin travel_V2 = mkV2 (mkV "reser") (mkPrep "till") ;
lin travel_V = L.travel_V;
lin target_N = mkN "mål" neutrum ;
lin very_A = mkA "exakt" ; ---- cat
lin pair_N = mkN "par" neutrum ;
lin male_A = mkA "manlig" ;
lin gas_N = mkN "gas" "gaser" ;
lin issue_V2 = mkV2 (mkV (mkV "släpper") "ut");
lin issue_V = mkV "utfärdar" ;
lin contribution_N = mkN "bidrag" neutrum ;
lin complex_A = mkA "komplex" ;
lin supply_V2 = dirV2 (mkV "förse" "försåg" "försett") ;
lin beat_V2 = mkV2 "slå" "slog" "slagit" ;
lin beat_V = mkV "slå" "slog" "slagit" ;
lin artist_N = mkN "konstnär" "konstnärer" | mkN "artist" "artister" ;
lin agentMasc_N = mkN "agent" "agenter" ;
lin presence_N = mkN "närvaro" ;
lin along_Adv = mkAdv "med" ;
lin environmental_A = mkA "miljömässig" ;
lin strike_V2 = mkV2 "stryka" "strök" "strukit" ;
lin strike_V = mkV "stryka" "strök" "strukit" | mkV "träffar" ;
lin contact_N = mkN "kontakt" "kontakter" ;
lin protection_N = mkN "skydd" neutrum ;
lin beginning_N = mkN "början" "början" "början" "början" | mkN "begynnelse" "begynnelser" ;
lin demand_VS = mkVS (mkV "kräver");
lin demand_V2 = mkV2 (mkV "kräver");
lin media_N = mkN "media" "median" "medier" "medierna" ;
lin relevant_A = mkA "relevant" "relevant" ;
lin employ_V2 = mkV2 (mkV "anställer");
lin shoot_V2 = mkV2 "skjuta" "sköt" "skjutit" | dirV2 (partV (mkV "störtar")"in") ;
lin shoot_V = mkV "skjuta" "sköt" "skjutit" ;
lin executive_N = mkN "verkställande" ;
lin slowly_Adv = mkAdv "sakta" | mkAdv "långsamt" ;
lin relatively_Adv = mkAdv "relativt" | mkAdv "förhållandevis" ;
lin aid_N = mkN "bistånd" neutrum ;
lin huge_A = mkA "väldig" ;
lin late_Adv = mkAdv "sen" ;
lin speed_N = mkN "hastighet" "hastigheter" | mkN "fart" "farter" ;
lin review_N = mkN "granskning" | mkN "översyn" "översyner" ;
lin test_V2 = mkV2 (mkV "testar") ;
lin order_VS = mkVS (mkV "befaller") ;
lin order_V2V = mkV2V (mkV "befaller") ;
lin order_V2 = mkV2 "beställer" ;
lin order_V = mkV "beställer" ;
lin route_N = mkN "rutt" "rutter" ;
lin consequence_N = mkN "konsekvens" "konsekvenser" | mkN "följd" "följder" ;
lin telephone_N = mkN "telefon" "telefoner" ;
lin release_V2 = mkV2 "släpper" ;
lin proportion_N = mkN "proportion" "proportioner" ;
lin primary_A = mkA "primär" ;
lin consideration_N = mkN "övervägande" ;
lin reform_N = mkN "reform" "reformer" ;
lin driverMasc_N = mkN "förare" utrum ;
lin annual_A = mkA "årlig" ;
lin nuclear_A = mkA "nukleär" ;
lin latter_A = mkA "senare" ;
lin practical_A = mkA "praktisk" ;
lin commercial_A = mkA "kommersiell" ;
lin rich_A = mkA "rik" ;
lin emerge_V = mkV "framträda" "framträdde" "framträtt" ;
lin apparently_Adv = mkAdv "tydligen" ;
lin ring_V = mkV "ringer" ; ---- sense
lin ring_6_V2 = mkV2 "ringa" ; ---- sense
lin ring_4_V2 = dirV2 (partV (mkV "slå" "slog" "slagit") "ut"); ---- sense
lin distance_N = mkN "avstånd" neutrum | mkN "distans" "distanser" ;
lin exercise_N = mkN "övning" | mkN "motion" "motioner" ; ---- split
lin key_A = mkA "huvudsaklig" ; ---- cat
lin close_Adv = mkAdv "nära" ;
lin skin_N = L.skin_N ;
lin island_N = mkN "ö" ;
lin separate_A = mkA "separat" "separat" | mkA "skild" "skilt" ;
lin aim_VV = mkVV (mkV "siktar");
lin aim_V2 = dirV2 (partV (mkV "riktar")"till");
lin aim_V = mkV "siktar" ;
lin danger_N = mkN "fara" ;
lin credit_N = mkN "kredit" "krediter" ;
lin usual_A = mkA "sedvanlig" | mkA "vanlig" ;
lin link_V2 = mkV2 "förbinda" "förband" "förbundit" | mkV2 (mkV "länka") ;
lin link_V = mkV "länka" | mkV "förenar" ;
lin candidateMasc_N = mkN "kandidat" "kandidater" ;
lin track_N = mkN "spår" neutrum | mkN "bana" ;
lin safe_A = mkA "säker" | mkA "välbehållen" "välbehållet" ;
lin interested_A = mkA "intresserad" "intresserat" ;
lin assessment_N = mkN "bedömning" | mkN "värdering" ;
lin path_N = mkN "stig" ;
lin merely_Adv = mkAdv "enbart" ;
lin plus_Prep = mkPrep "plus" ; ---- cat
lin district_N = mkN "distrikt" neutrum ;
lin regular_A = mkA "regelbunden" "regelbundet" | mkA "reguljär" ;
lin reaction_N = mkN "reaktion" "reaktioner" ;
lin impact_N = mkN "påverkan" "påverkan" "påverkan" "påverkan" ;
lin collect_V2 = mkV2 (mkV "samlar");
lin collect_V = mkV "samlar" ;
lin debate_N = mkN "debatt" "debatter" ;
lin lay_V2 = mkV2 "lägga" "lade" "lagt" ;
lin lay_V = mkV "lägga" "lade" "lagt" ;
lin rise_N = mkN "uppgång" | mkN "ökning" ;
lin belief_N = mkN "tro" ;
lin conclusion_N = mkN "slutsats" "slutsatser" ;
lin shape_N = mkN "form" "former" ;
lin vote_N = mkN "röstr" "röster" ;
lin aim_N = mkN "syfte" ;
lin politics_N = mkN "politik" ;
lin reply_VS = mkVS (mkV "svarar");
lin reply_V = mkV "svarar" ;
lin press_V2V = mkV2V (mkV "trycker");
lin press_V2 = dirV2 (partV (mkV "trycker")"på");
lin press_V = mkV "trycker" ;
lin approach_V2 = mkV2 (reflV (mkV "närma")) ;
lin approach_V = reflV (mkV "närma") ;
lin file_N = mkN "fil" "filer" | mkN "register" neutrum ;
lin western_A = mkA "västlig" ;
lin earth_N = L.earth_N;
lin public_N = mkN "allmänhet" "allmänheter" | mkN "publik" "publiker" ;
lin survive_V2 = mkV2 (mkV "överlever");
lin survive_V = mkV "överlever" ;
lin estate_N = mkN "egendom" ;
lin boat_N = L.boat_N ;
lin prison_N = mkN "fängelse" "fängelset" "fängelser" "fängelserna" ;
lin additional_A = mkA "ytterligare" ;
lin settle_V2 = mkV2 I.sätta_V ;
lin settle_V = mkV "sjunka" "sjönk" "sjunkit" ;
lin largely_Adv = mkAdv "i stort" ;
lin wine_N = L.wine_N ;
lin observe_VS = mkVS (mkV "iaktta" "iakttar" "iaktta" "iakttog" "iakttagit" "iakttagen");
lin observe_V2 = dirV2 (mkV "observera") ;
lin limit_V2V = mkV2V (mkV "begränsa");
lin limit_V2 = mkV2 "begränsa" ;
lin deny_V3 = mkV3 (mkV "förneka");
lin deny_V2 = mkV2 (mkV "förneka");
lin for_PConj = lin PConj {s = "för" | "ty"} ;
lin straight_Adv = mkAdv "direkt" ;
lin somebody_NP = S.somebody_NP;
lin writer_N = mkN "författare" utrum ;
lin weekend_N = mkN "veckoslut" neutrum | mkN "veckoslut" neutrum ;
lin clothes_N = mkN "klädsel" ;
lin active_A = mkA "aktiv" ;
lin sight_N = mkN "syn" | mkN "åsyn" | mkN "sevärdhet" ;
lin video_N = mkN "video" "videor" ;
lin reality_N = mkN "verklighet" "verkligheter" ;
lin hall_N = mkN "hall" | mkN "sal" ;
lin nevertheless_Adv = mkAdv "trots allt" | mkAdv "likväl" ;
lin regional_A = mkA "regional" ;
lin vehicle_N = mkN "fordon" neutrum ;
lin worry_VS = mkVS (reflV (mkV "oroa"));
lin worry_V2 = mkV2 (mkV "oroa") ;
lin worry_V = reflV (mkV "oroa") ;
lin powerful_A = mkA "mäktig" ;
lin possibly_Adv = mkAdv "möjligen" ;
lin cross_V2 = mkV2 (partV (mkV "korsar")"över") ;
lin cross_V = mkV "passerar" ;
lin colleague_N = mkN "kollega" ;
lin charge_V2 = mkV2 "ladda" ;
lin charge_V = mkV "ladda" ;
lin lead_N = mkN "ledarskap" neutrum | mkN "sänke" ;
lin farm_N = mkN "gård" | mkN "lantgård" | mkN "lantbruk" neutrum ;
lin respond_VS = mkVS (mkV "svara") ;
lin respond_V = mkV "svarar" ;
lin employer_N = mkN "arbetsgivare" utrum ;
lin carefully_Adv = mkAdv "försiktigt" ;
lin understanding_N = mkN "förståelse" utrum | mkN "förståelse" "förståelser" ;
lin connection_N = mkN "koppling" | mkN "släktskap" ;
lin comment_N = mkN "kommentar" "kommentarer" ;
lin grant_V3 = mkV3 (mkV "bevilja") ;
lin grant_V2 = mkV2 "bevilja" ;
lin concentrate_V2 = mkV2 "koncentrera" ;
lin concentrate_V = reflV (mkV "koncentrerar") ; ---- END edits by AR
lin ignore_V2 = mkV2 (mkV "ignorerar"); -- status=guess, src=wikt
lin ignore_V = mkV "ignorerar" ; -- comment=4
lin phone_N = mkN "telefon" "telefoner" ; -- status=guess
lin hole_N = mkN "röra" | mkN "knipa" ; -- SaldoWN = mkN "röra" ; -- comment=9
lin insurance_N = mkN "försäkring" ; -- SaldoWN
lin content_N = mkN "innehåll" neutrum ; -- status=guess
lin confidence_N = mkN "tillförsikt" ; -- comment=6
lin sample_N = mkN "prov" neutrum | mkN "varuprov" neutrum ; -- SaldoWN = mkN "prov" neutrum ; -- comment=3
lin transport_N = mkN "transport" "transporter" | mkN "transportmedel" neutrum ; -- SaldoWN -- comment=6
lin objective_N = mkN "mål" neutrum; -- comment=2
lin alone_A = mkA "ensam" "ensamt" "ensamma" "ensamma" "ensammare" "ensammast" "ensammaste" ; -- comment=4
lin flower_N = L.flower_N ;
lin injury_N = mkN "skada" ; -- SaldoWN
lin lift_V2 = mkV2 (mkV "lyfta" "lyfter" "lyft" "lyfte" "lyft" "lyft"); -- status=guess, src=wikt
lin lift_V = mkV "upphäver" ; -- comment=14
lin stick_V2 = mkV2 "binda" "band" "bundit" | dirV2 (partV (mkV "stoppar")"till") ; -- SaldoWN -- comment=21
lin stick_V = mkV "binda" "band" "bundit" | mkV "bita" "bet" "bitit" ; -- SaldoWN -- comment=25
lin front_A = mkA "främre" ; -- status=guess
lin mainly_Adv = mkAdv "huvudsakligen" ; -- status=guess
lin battle_N = mkN "kamp" | mkN "slag" neutrum ; -- status=guess
lin generation_N = mkN "generation" "generationer" | mkN "årsmodell" "årsmodeller" ; -- SaldoWN -- comment=7
lin currently_Adv = mkAdv "nuförtiden" ; -- status=guess
lin winter_N = mkN "vinter" ; -- SaldoWN
lin inside_Prep = mkPrep "innanför" ; -- status=guess
lin impossible_A = mkA "omöjlig" ; -- SaldoWN
lin somewhere_Adv = S.somewhere_Adv;
lin arrange_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin arrange_V = mkV "planerar" ; -- comment=12
lin will_N = mkN "vilja" | mkN "kan" "kaner" ; -- SaldoWN -- comment=3
lin sleep_V = L.sleep_V;
lin progress_N = mkN "framsteg" neutrum | mkN "framsteg" neutrum ; -- SaldoWN -- comment=4
lin volume_N = mkN "volym" "volymer" ; -- status=guess
lin ship_N = L.ship_N;
lin legislation_N = mkN "lagstiftning" ; -- SaldoWN
lin commitment_N = mkN "lojalitet" "lojaliteter" | mkN "åtagande" ; -- SaldoWN -- comment=12
lin enough_Predet = M.mkPredet "tillräckligt" "tillräckligt" "tillräckligt" ; -- status=guess
lin conflict_N = mkN "konflikt" "konflikter" ; -- status=guess
lin bag_N = mkN "handväska" | mkN "väska" ; -- SaldoWN -- comment=12
lin fresh_A = mkA "färsk" | mkA "uppfriskande" ; -- SaldoWN -- comment=13
lin entry_N = mkN "ingång" | mkN "uppslagsord" neutrum ; -- SaldoWN -- comment=14
lin entry_2_N = mkN "uppslagsord" neutrum ; -- status=guess
lin entry_1_N = mkN "ingång" ; -- status=guess
lin smile_N = mkN "leende" ; -- SaldoWN
lin fair_A = mkA "rättvis" ; -- comment=13
lin promise_VV = mkVV (mkV "lovar"); -- status=guess, src=wikt
lin promise_VS = mkVS (mkV "lovar"); -- status=guess, src=wikt
lin promise_V2 = mkV2 (mkV "lovar"); -- status=guess, src=wikt
lin promise_V = mkV "lovar" ; -- comment=4
lin introduction_N = mkN "introduktion" "introduktioner" | mkN "introducering" ; -- status=guess
lin senior_A = mkA "senior" | mkA "äldre" ; -- status=guess
lin manner_N = mkN "manér" neutrum | mkN "uppträdande" ; -- SaldoWN -- comment=14
lin background_N = mkN "bakgrund" "bakgrunder" ; -- status=guess
lin key_N = mkN "tonart" "tonarter" ; -- SaldoWN
lin key_2_N = mkN "tonart" "tonarter" ; -- status=guess
lin key_1_N = mkN "nyckel" ; -- status=guess
lin touch_V2 = mkV2 "röra" "rörde" "rört" | dirV2 (partV (mkV "stämplar")"ut") ; -- SaldoWN -- comment=6
lin touch_V = mkV "röra" "rörde" "rört" | mkV "skisserar" ; -- SaldoWN -- comment=17
lin vary_V2 = dirV2 (partV (mkV "växlar")"in"); -- comment=2
lin vary_V = mkV "varierar" ; -- comment=4
lin sexual_A = mkA "sexuell" ; -- SaldoWN
lin ordinary_A = mkA "vanlig" ; -- SaldoWN
lin cabinet_N = mkN "skåp" neutrum ; -- SaldoWN -- comment=9
lin painting_N = mkN "tavla" ; -- comment=5
lin entirely_Adv = mkAdv "helt" ; -- status=guess
lin engine_N = mkN "motor" "motorer" ; -- status=guess
lin previously_Adv = mkAdv "förr" ; -- status=guess
lin administration_N = mkN "förvaltning" ; -- status=guess
lin tonight_Adv = mkAdv "ikväll" | mkAdv "inatt" ; -- status=guess
lin adult_N = mkN "vuxen" ; -- status=guess
lin prefer_VV = mkVV (mkV "föredra" "föredrar" "föredra" "föredrog" "föredragit" "föredragen") ; -- SaldoWN
lin prefer_V2 = mkV2 "föredra" "föredrar" "föredra" "föredrog" "föredragit" "föredragen" ; -- SaldoWN
lin author_N = mkN "upphovsman" "upphovsmannen" "upphovsmän" "upphovsmännen" ; -- status=guess
lin actual_A = mkA "faktisk" ; -- status=guess
lin song_N = L.song_N;
lin investigation_N = mkN "efterforskning" | mkN "undersökning" ; -- SaldoWN -- comment=3
lin debt_N = mkN "skuld" "skulder" ; -- SaldoWN
lin visitor_N = mkN "besökare" utrum | mkN "besökare" utrum ; -- SaldoWN -- comment=5
lin forest_N = mkN "skog" ; -- SaldoWN
lin repeat_VS = mkVS (mkV "repeterar") | mkVS (mkV "upprepar"); -- status=guess, src=wikt status=guess, src=wikt
lin repeat_V2 = mkV2 (mkV "repeterar") | mkV2 (mkV "upprepar"); -- status=guess, src=wikt status=guess, src=wikt
lin repeat_V = mkV "upprepar" ; -- comment=2
lin wood_N = L.wood_N ;
lin contrast_N = mkN "motsats" "motsatser" | mkN "kontrast" "kontraster" ; -- SaldoWN -- comment=2
lin extremely_Adv = mkAdv "extremt" ; -- status=guess
lin wage_N = mkN "lön" "löner" | mkN "driva" ; -- SaldoWN -- comment=4
lin domestic_A = mkA "inhemsk" | mkA "inrikes" ; -- SaldoWN -- comment=4
lin commit_V2 = dirV2 (partV (mkV "skickar")"ut"); -- comment=5
lin threat_N = mkN "hot" ; -- SaldoWN = mkN "hot" neutrum ;
lin bus_N = mkN "buss" ; -- status=guess
lin warm_A = L.warm_A ;
lin sir_N = mkN "magister" ; -- status=guess
lin regulation_N = mkN "bestämmelse" "bestämmelser" | mkN "reglerande" ; -- SaldoWN -- comment=7
lin drink_N = mkN "fylleri" neutrum | mkN "spritdryck" "spritdrycker" ; -- SaldoWN -- comment=15
lin relief_N = mkN "lättnad" "lättnader" | mkN "undsättning" ; -- SaldoWN -- comment=14
lin internal_A = mkA "invärtes" ; -- comment=2
lin strange_A = mkA "säregen" "säreget" | mkA "obekant" "obekant" ; -- SaldoWN -- comment=10
lin excellent_A = mkA "utmärkt" "utmärkt" ; -- comment=12
lin run_N = mkN "springa" | mkN "sats" "satser" ; -- SaldoWN -- comment=37
lin fairly_Adv = mkAdv "någorlunda" ; -- status=guess
lin technical_A = mkA "teknisk" ; -- SaldoWN
lin tradition_N = mkN "tradition" "traditioner" ; -- status=guess
lin measure_V2 = mkV2 (mkV "mäta"); -- status=guess, src=wikt
lin measure_V = mkV "mäter" ; -- comment=4
lin insist_VS = mkVS (mkV "vidhålla" "vidhöll" "vidhållit") | mkVS (mkV "insistera") ; -- status=guess
lin insist_V2 = mkV2 "insistera" ; -- status=guess
lin insist_V = mkV "insistera" | mkV "vidhålla" "vidhöll" "vidhållit" ; -- status=guess
lin farmer_N = mkN "bonde" "bönder" | mkN "lantbrukare" utrum ; -- SaldoWN -- comment=2
lin until_Prep = mkPrep "ända till" ;
lin traffic_N = mkN "trafik" "trafiker" ; -- status=guess
lin dinner_N = mkN "middag" ; -- SaldoWN
lin consumer_N = mkN "konsument" "konsumenter" ; -- SaldoWN
lin meal_N = mkN "måltid" "måltider" ; -- SaldoWN
lin warn_VS = mkVS (mkV "varnar"); -- status=guess, src=wikt
lin warn_V2V = mkV2V (mkV "varnar"); -- status=guess, src=wikt
lin warn_V2 = mkV2 (mkV "varnar"); -- status=guess, src=wikt
lin warn_V = mkV "varnar" ; -- comment=2
lin living_A = mkA "bosatt" | mkA "levande" ; -- SaldoWN
lin package_N = mkN "paket" neutrum | mkN "emballerande" ; -- SaldoWN -- comment=8
lin half_N = mkN "halva" ; -- status=guess
lin increasingly_Adv = mkAdv "alltmer" ; -- status=guess
lin description_N = mkN "slag" neutrum; -- comment=7
lin soft_A = mkA "mjuk" ; -- SaldoWN
lin stuff_N = mkN "material" neutrum; -- comment=5
lin award_V3 = mkV3 (mkV "bevilja"); -- status=guess
lin award_V2 = mkV2 (mkV "bevilja"); -- status=guess
lin existence_N = mkN "existens" "existenser" ; -- status=guess
lin improvement_N = mkN "förbättring" ; -- SaldoWN
lin coffee_N = mkN "kaffe" "kaffet" "kaffe" "kaffen" ; -- status=guess
lin appearance_N = mkN "utseende" ; -- status=guess
lin standard_A = mkA "standard" "standart" ; -- status=guess
lin attack_V2 = mkV2 "anfalla" "anföll" "anfallit" | mkV2 (mkV "attackerar") | mkV2 (mkV "angripa" "angrep" "angripit") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin sheet_N = mkN "segel" neutrum | mkN "tidning" ; -- SaldoWN -- comment=17
lin category_N = mkN "kategori" "kategorier" | mkN "klass" "klasser" ; -- SaldoWN -- comment=3
lin distribution_N = mkN "spridning" ; -- status=guess
lin equally_Adv = mkAdv "likvärdigt" ; -----
lin session_N = mkN "session" "sessioner" | mkN "termin" "terminer" ; -- SaldoWN -- comment=4
lin cultural_A = mkA "kulturell" ; -- status=guess
lin loan_N = mkN "lån" neutrum | mkN "utlåning" ; -- SaldoWN -- comment=2
lin bind_V2 = mkV2 "binda" "band" "bundit" | dirV2 (partV (mkV "kantar")"av") ; -- SaldoWN
lin bind_V = mkV "binda" "band" "bundit" | mkV "kantar" ; -- SaldoWN -- comment=12
lin museum_N = mkN "museum" "museet" "museer" "museerna" ; -- SaldoWN
lin conversation_N = mkN "samtal" neutrum | mkN "samtalsämne" ; -- SaldoWN -- comment=5
lin threaten_VV = mkVV (mkV "hotar"); -- status=guess, src=wikt
lin threaten_VS = mkVS (mkV "hotar"); -- status=guess, src=wikt
lin threaten_V2 = mkV2 (mkV "hotar"); -- status=guess, src=wikt
lin threaten_V = mkV "hotar" ; -- status=guess
lin link_N = mkN "länk" | mkN "före" ; -- status=guess
lin launch_V2 = mkV2 (mkV "sjösätta" "sjösatte" "sjösatt") ; -- status=guess, src=wikt
lin launch_V = mkV "färjar" ; -- comment=3
lin proper_A = mkA "passande" | mkA "rätt" ; -- SaldoWN -- comment=18
lin victim_N = mkN "offer" neutrum | mkN "slaktoffer" neutrum ; -- SaldoWN -- comment=2
lin audience_N = mkN "publik" "publiker" ; -- SaldoWN
lin famous_A = mkA "berömd" "berömt" ; -- status=guess
lin master_N = mkN "mästare" utrum | mkN "styresman" "styresmannen" "styresmän" "styresmännen" ; -- SaldoWN -- comment=21
lin master_2_N = mkN "magister" ; -- status=guess
lin master_1_N = mkN "mästare" utrum ; -- status=guess
lin lip_N = mkN "läpp" | mkN "oförskämdhet" "oförskämdheter" ; -- SaldoWN -- comment=4
lin religious_A = mkA "religiös" ; -- status=guess
lin joint_A = mkA "led" | mkA "samfälld" "samfällt" ; -- SaldoWN -- comment=5
lin cry_V2 = mkV2 "gråta" "grät" "gråtit" | dirV2 (partV (mkV "ropar")"till") ; -- SaldoWN
lin cry_V = mkV "gråta" "grät" "gråtit" | mkV "skrika" "skrek" "skrikit" ; -- SaldoWN -- comment=6
lin potential_A = mkA "potentiell" ; -- SaldoWN
lin broad_A = L.broad_A;
lin exhibition_N = mkN "utställning" ; -- SaldoWN
lin experience_V2 = mkV2 (mkV "upplever"); -- status=guess, src=wikt
lin judge_N = mkN "domare" utrum ; -- SaldoWN -- comment=2
lin formal_A = mkA "formell" ; -- SaldoWN
lin housing_N = mkN "boende" | mkN "skydd" neutrum ; -- SaldoWN = mkN "boende" "boenden" "boende" "boendena" ; -- comment=13
lin past_Prep = mkPrep "förbi" ; -- status=guess
lin concern_V2 = mkV2 "gäller" ; -- status=guess
lin freedom_N = mkN "frihet" "friheter" ; -- SaldoWN
lin gentleman_N = mkN "gentleman" "gentlemannen" "gentlemän" "gentlemännen" | mkN "man" ; -- SaldoWN -- comment=4
lin attract_V2 = dirV2 (partV (mkV "lockar")"in"); -- status=guess
lin explanation_N = mkN "förklaring" ; -- SaldoWN
lin appoint_V3 = mkV3 "utse" "utsåg" "utsett" ; -- SaldoWN
lin appoint_V2V = mkV2V "utse" "utsåg" "utsett" ; -- SaldoWN
lin appoint_V2 = mkV2 "utse" "utsåg" "utsett" ; -- SaldoWN
lin note_VS = mkVS (mkV "märker");
lin note_V2 = mkV2 "notera" | mkV2 "märker" ; -- status=guess
lin note_V = mkV "notera" | mkV "märker" ; -- status=guess
lin chief_A = mkA "viktig" ; -- comment=3
lin total_N = mkN "slutsumma" ; -- status=guess
lin lovely_A = mkA "förtjusande" ; -- comment=4
lin official_A = mkA "officiell" ; -- status=guess
lin date_V2 = mkV2 (mkV "åldras"); -- status=guess, src=wikt
lin date_V = mkV "daterar" ; -- comment=3
lin demonstrate_VS = mkVS (mkV "demonstrerar"); -- status=guess, src=wikt
lin demonstrate_V2 = dirV2 (partV (mkV "visar")"in"); -- status=guess
lin demonstrate_V = mkV "demonstrerar" ; -- comment=8
lin construction_N = mkN "konstruktion" "konstruktioner" ; -- status=guess
lin middle_N = mkN "mitt" ; -- SaldoWN
lin yard_N = mkN "yard" "yarden" "yard" "yarden" ; -- SaldoWN
lin unable_A = mkA "oduglig" ; -- comment=3
lin acquire_V2 = mkV2 "skaffa" ;
lin surely_Adv = mkAdv "säkert" ; -- status=guess
lin crisis_N = mkN "kris" ; -- SaldoWN = mkN "kris" "kriser" ;
lin propose_VV = mkVV (mkV "friar"); -- status=guess, src=wikt
lin propose_VS = mkVS (mkV "friar"); -- status=guess, src=wikt
lin propose_V2 = mkV2 (mkV "föreslå" "föreslog" "föreslagit");
lin propose_V = mkV "ämnar" ; -- comment=4
lin west_N = mkN "väster" | mkN "väst" ; -- status=guess
lin impose_V2 = mkV2 "påtvinga" ; -- status=guess
lin impose_V = mkV "påtvinga" ; -- status=guess
lin market_V2 = mkV2 "marknadsföra" "marknadsförde" "marknadsfört" ; -- SaldoWN
lin market_V = mkV "marknadsföra" "marknadsförde" "marknadsfört" | mkV "handlar" ; -- SaldoWN -- comment=6
lin care_V = mkV "bryr" ; -- status=guess
lin god_N = mkN "gud" ; -- SaldoWN
lin favour_N = mkN "tjänst" "tjänster" | mkN "ynnest" ; -- SaldoWN = mkN "tjänst" "tjänster" ; -- comment=15
lin before_Adv = mkAdv "innan" ; -- comment=9
lin name_V3 = mkV3 (mkV "utnämna"); -- status=guess, src=wikt
lin name_V2 = mkV2 (mkV "utnämna"); -- status=guess, src=wikt
lin equal_A = mkA "lika" ; -- comment=6
lin capacity_N = mkN "kapacitet" "kapaciteter" | mkN "förmåga" ; -- status=guess
lin flat_N = mkN "punktering" | mkN "ren" "renen" "renar" "renarna" ; -- SaldoWN -- comment=17
lin selection_N = mkN "utdrag" neutrum | mkN "val" ; -- SaldoWN -- comment=6
lin alone_Adv = mkAdv "ensamt" ; -- status=guess
lin football_N = mkN "fotboll" ; -- status=guess
lin victory_N = mkN "seger" ; -- status=guess
lin factory_N = L.factory_N ;
lin rural_A = mkA "lantlig" ; -- SaldoWN
lin twice_Adv = mkAdv "två gånger" ; -- status=guess
lin sing_V2 = mkV2 "sjunga" "sjöng" "sjungit" | mkV2 (mkV "sjunga" "sjöng" "sjungit") ; -- SaldoWN
lin sing_V = L.sing_V ;
lin whereas_Subj = M.mkSubj "medan" ; -- status=guess
lin own_V2 = mkV2 "äger" ;
lin head_V2 = mkV2 (mkV "åker") (mkPrep "till") ; -- status=guess
lin head_V = mkV "falla" "föll" "fallit" ; -- comment=14
lin examination_N = mkN "prov" neutrum | mkN "tentamen" "tentamen" "tentamina" "tentamina" ; -- SaldoWN = mkN "prov" neutrum ; -- comment=13
lin deliver_V2 = mkV2 "undsätta" "undsätter" "undsätt" "undsatte" "undsatt" "undsatt" | dirV2 (partV (mkV "riktar")"till") ; -- SaldoWN -- comment=2
lin deliver_V = mkV "undsätta" "undsätter" "undsätt" "undsatte" "undsatt" "undsatt" | mkV "räddar" ; -- SaldoWN -- comment=13
lin nobody_NP = S.nobody_NP;
lin substantial_A = mkA "fullgod" ; -- comment=31
lin invite_V2V = mkV2V I.bjuda_V ; -- status=guess
lin invite_V2 = mkV2 I.bjuda_V | mkV2 (mkV "inbjuda" "inbjöd" "inbjudit") ; -- status=guess
lin intention_N = mkN "avsikt" "avsikter" ; -- SaldoWN
lin egg_N = L.egg_N ;
lin reasonable_A = mkA "rimlig" | mkA "överkomlig" ; -- SaldoWN -- comment=10
lin onto_Prep = mkPrep "på" ; -- status=guess
lin retain_V2 = mkV2 (mkV "behålla" "behöll" "behållit") | mkV2 (mkV "bevarar") ; -- status=guess
lin aircraft_N = mkN "flygplan" neutrum ; -- status=guess
lin decade_N = mkN "årtionde" | mkN "decennium" "decenniet" "decennier" "decennierna" ; -- SaldoWN -- comment=3
lin cheap_A = mkA "billig" ; -- SaldoWN
lin quiet_A = mkA "tyst" "tyst" ; -- SaldoWN
lin bright_A = mkA "lycklig" ; -- comment=15
lin contribute_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=3
lin contribute_V = mkV "bidra" "bidrar" "bidra" "bidrog" "bidragit" "bidragen" ; -- comment=4
lin row_N = mkN "ro" | mkN "väsen" neutrum ; -- SaldoWN = mkN "ro" neutrum ; = mkN "ro" "ron" "ron" "rona" ; -- comment=24
lin search_N = mkN "undersökning" | mkN "sök" neutrum ; -- SaldoWN
lin limit_N = mkN "måtta" | mkN "gräns" "gränser" ; -- SaldoWN -- comment=5
lin definition_N = mkN "definition" "definitioner" | mkN "skärpa" ; -- SaldoWN -- comment=9
lin unemployment_N = mkN "arbetslöshet" "arbetslösheter" ; -- SaldoWN
lin spread_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- comment=4
lin spread_V = mkV "sprida" "spred" "spritt" ; -- comment=6
lin mark_N = mkN "ärr" neutrum | mkN "betyg" neutrum ; -- SaldoWN -- comment=22
lin flight_N = mkN "flyg" "flyg" ; -- status=guess
lin account_V2 = mkV2 (mkV "beräkna"); -- status=guess, src=wikt
lin account_V = mkV "nyttar" ; -- comment=5
lin output_N = mkN "resultat" neutrum | mkN "produktion" "produktioner" ; -- SaldoWN -- comment=8
lin last_V = mkV "bestå" "bestod" "bestått" | mkV "hålla" "höll" "hållit" ; -- status=guess
lin tour_N = mkN "turné" "turnéer" ; -- status=guess
lin address_N = mkN "adress" "adresser" ; -- SaldoWN
lin immediate_A = mkA "omedelbar" ; -- comment=6
lin reduction_N = mkN "minskning" | mkN "reduktion" "reduktioner" ; -- SaldoWN -- comment=15
lin interview_N = mkN "intervju" "intervjun" "intervjuer" "intervjuerna" ; -- status=guess
lin assess_V2 = mkV2 "bedömmer" | mkV2 "utvärdera" ; -- status=guess
lin promote_V2 = mkV2 (mkV "befordrar"); -- status=guess, src=wikt
lin promote_V = mkV "lanserar" ; -- comment=8
lin everybody_NP = S.everybody_NP;
lin suitable_A = mkA "passande" ; -- comment=4
lin growing_A = mkA "växande" ; -- status=guess
lin nod_V = mkV "nickar" ; -- status=guess
lin reject_V2 = mkV2 (mkV "avslå" "avslog" "avslagit") | mkV2 "underkänner" | mkV2 (mkV "avvisar") ; -- status=guess
lin while_N = mkN "stund" "stunder" ; -- comment=2
lin high_Adv = mkAdv "högt" ; -- status=guess
lin dream_N = mkN "dröm" "drömmen" "drömmar" "drömmarna" ; -- SaldoWN
lin vote_VV = mkVV (mkV "rösta"); -- status=guess, src=wikt
lin vote_V3 = mkV3 (mkV "rösta"); -- status=guess
lin vote_V2 = dirV2 (partV (mkV "röstar")"ut"); -- comment=2
lin vote_V = mkV "röstar" ; -- comment=2
lin divide_V2 = dirV2 (partV (mkV "delar")"ut"); -- comment=6
lin divide_V = mkV "delar" ; -- comment=17
lin declare_VS = mkVS (mkV "deklarerar"); -- status=guess, src=wikt
lin declare_V2 = mkV2 (mkV "deklarerar"); -- status=guess, src=wikt
lin declare_V = mkV "förklarar" ; -- comment=9
lin handle_V2 = mkV2 (mkV (mkV "handskas") "med"); -- status=guess, src=wikt
lin handle_V = mkV "handla" ; -- status=guess
lin detailed_A = mkA "detaljerad" "detaljerat" ; -- status=guess
lin challenge_N = mkN "utmaning" ; -- SaldoWN
lin notice_N = mkN "varsel" neutrum | mkN "uppsägning" ; -- SaldoWN -- comment=12
lin rain_N = L.rain_N ;
lin destroy_V2 = mkV2 (mkV "förstöra"); -- status=guess, src=wikt
lin mountain_N = L.mountain_N ;
lin concentration_N = mkN "koncentration" "koncentrationer" ; -- SaldoWN
lin limited_A = mkA "begränsad" ; -- status=guess
lin finance_N = mkN "finans" "finanser" ; -- status=guess
lin pension_N = mkN "pension" "pensioner" | mkN "pensionat" neutrum ; -- SaldoWN -- comment=2
lin influence_V2 = mkV2 (mkV "påverka"); -- status=guess, src=wikt
lin afraid_A = mkA "rädd" ; -- SaldoWN
lin murder_N = mkN "mord" neutrum ; -- status=guess
lin neck_N = L.neck_N ;
lin weapon_N = mkN "vapen" "vapnet" "vapen" "vapnen" ; -- SaldoWN
lin hide_V2 = mkV2 "dölja" "dolde" "dolt" | mkV2 (mkV (mkV "gömma") "sig") ; -- SaldoWN -- status=guess, src=wikt
lin hide_V = mkV "dölja" "dolde" "dolt" | mkV "gömmer" ; -- SaldoWN -- comment=4
lin offence_N = mkN "offensiv" "offensiver" | mkN "förseelse" "förseelser" ; -- SaldoWN -- comment=9
lin absence_N = mkN "frånvaro" ; -- SaldoWN
lin error_N = mkN "missuppfattning" | mkN "fel" neutrum ; -- SaldoWN -- comment=3
lin representativeMasc_N = mkN "representant" "representanter" | mkN "ledamot" "ledamöter" ; -- status=guess
lin enterprise_N = mkN "företag" "företag" ; -- status=guess
lin criticism_N = mkN "kritik" "kritiker" ; -- SaldoWN
lin average_A = mkA "genomsnittlig" ; -- status=guess
lin quick_A = mkA "snabb" ; --"kvick" ; -- comment=12
lin sufficient_A = mkA "tillräcklig" ; -- SaldoWN
lin appointment_N = mkN "förordnande" | mkN "utnämning" ; -- SaldoWN -- comment=2
lin match_V2 = mkV2 (mkV "matchar") | mkV2 (mkV (mkV "vara") "lika") | mkV2 (mkV (mkV "passa") "ihop"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin transfer_V = mkV "överföra" "överförde" "överfört" | mkV "överlåta" "överlät" "överlåtit" ; -- SaldoWN -- comment=4
lin acid_N = mkN "syra" ; -- SaldoWN
lin spring_N = mkN "vår" ; -- SaldoWN
lin birth_N = mkN "födsel" ; -- status=guess
lin ear_N = L.ear_N ;
lin recognize_VS = mkVS (mkV "erkänner") ;
lin recognize_4_V2 = mkV2 (mkV (mkV "känna" "kände" "känt") "igen") ;
lin recognize_1_V2 = mkV2 (mkV (mkV "känna" "kände" "känt") "igen") ;
lin recommend_V2V = mkV2V (mkV "rekommenderar"); -- status=guess, src=wikt
lin recommend_V2 = mkV2 (mkV "rekommenderar"); -- status=guess, src=wikt
lin module_N = mkN "modul" "moduler" ; -- SaldoWN
lin instruction_N = mkN "undervisning" ; -- SaldoWN
lin democratic_A = mkA "demokratisk" ; -- SaldoWN
lin park_N = mkN "park" "parker" | mkN "plan" "planer" ; -- status=guess
lin weather_N = mkN "väder" neutrum | mkN "väder" neutrum ; -- SaldoWN
lin bottle_N = mkN "flaska" ; -- SaldoWN
lin address_V2 = dirV2 (partV (mkV "riktar")"till"); -- comment=2
lin bedroom_N = mkN "sovrum" "sovrummet" "sovrum" "sovrummen" | mkN "sängkammare" "sängkammaren" "sängkamrar" "sängkamrarna" ; -- SaldoWN -- comment=2
lin kid_N = mkN "killing" ; -- SaldoWN
lin pleasure_N = mkN "nöje" | mkN "gottfinnande" ; -- SaldoWN -- comment=9
lin realize_VS = mkVS (mkV "inse" "insåg" "insett") ;
lin realize_V2 = mkV2 (mkV "inse" "insåg" "insett") ;
lin assembly_N = mkN "tillverkning" | mkN "sammanträde" ; -- SaldoWN -- comment=10
lin expensive_A = mkA "dyr" | mkA "dyrbar" ; -- SaldoWN -- comment=5
lin select_VV = mkVV (mkV "välja" "valde" "valt") ; -- status=guess
lin select_V2V = mkV2V (mkV "välja" "valde" "valt") ; -- status=guess
lin select_V2 = mkV2 (mkV "välja" "valde" "valt") ; -- status=guess
lin select_V = mkV "utvälja" "utvalde" "utvalt" ; -- status=guess
lin teaching_N = mkN "undervisning" ; -- status=guess
lin desire_N = mkN "begär" neutrum | mkN "önskning" ; -- SaldoWN -- comment=5
lin whilst_Subj = M.mkSubj "medan" ; -- status=guess
lin contact_V2 = mkV2 (mkV "kontaktar"); -- status=guess, src=wikt
lin implication_N = mkN "implikation" "implikationer" | mkN "innebörd" "innebörder" ; -- SaldoWN -- comment=8
lin combine_VV = mkVV (mkV "kombinerar") ; -- comment=2
lin combine_V2 = mkV2 "kombinerar" ; -- comment=2
lin combine_V = mkV "kombinerar" ; -- comment=2
lin temperature_N = mkN "temperatur" "temperaturer" ; -- SaldoWN
lin wave_N = mkN "våg" "vågor" | mkN "våg" ; -- SaldoWN = mkN "våg" ; -- comment=6
lin magazine_N = mkN "magasin" neutrum ; -- status=guess
lin totally_Adv = mkAdv "totalt" | mkAdv "helt" ; -- status=guess
lin mental_A = mkA "psykisk" | mkA "själslig" ; -- SaldoWN -- comment=3
lin used_A = mkA "begagnad" "begagnat" ; -- status=guess
lin store_N = mkN "lager" "lager" ; -- status=guess
lin scientific_A = mkA "vetenskaplig" ; -- status=guess
lin frequently_Adv = mkAdv "ofta" ; -- status=guess
lin thanks_N = mkN "tack" "tack" ; -- status=guess
lin beside_Prep = mkPrep "bredvid" ; -- status=guess
lin settlement_N = mkN "förlikning" | mkN "settlement" neutrum ; -- SaldoWN -- comment=23
lin absolutely_Adv = mkAdv "absolut" ; -- status=guess
lin critical_A = mkA "kritisk" | mkA "livsviktig" ; -- SaldoWN -- comment=5
lin critical_2_A = mkA "livsviktig" ; -- status=guess
lin critical_1_A = mkA "kritisk" ; -- status=guess
lin recognition_N = mkN "erkännande" ; -- SaldoWN
lin touch_N = mkN "röra" | mkN "stämpel" ; -- SaldoWN = mkN "röra" ; -- comment=32
lin consist_V = (mkV "varar") | mkV "bestå" "bestod" "bestått" ; -- status=guess
lin below_Prep = mkPrep "nedanför" ;
lin silence_N = mkN "tystnad" "tystnader" ; -- SaldoWN
lin expenditure_N = mkN "utlägg" neutrum | mkN "utgift" "utgifter" ; -- SaldoWN -- comment=3
lin institute_N = mkN "institut" neutrum; -- status=guess
lin dress_V2 = dirV2 (partV (mkV "rensar")"ut"); -- comment=11
lin dress_V = mkV "tillreda" "tillredde" "tillrett" ; -- comment=24
lin dangerous_A = mkA "farlig" ; -- SaldoWN
lin familiar_A = mkA "familjär" | mkA "otvungen" "otvunget" ; -- SaldoWN -- comment=13
lin asset_N = mkN "tillgång" ; -- SaldoWN
lin educational_A = mkA "pedagogisk" ; -- SaldoWN
lin sum_N = mkN "summa" ; -- SaldoWN
lin publication_N = mkN "publikation" "publikationer" ; -- SaldoWN
lin partly_Adv = mkAdv "delvis" ; -- comment=3
lin block_N = mkN "kvarter" "kvarteret" "kvarter" "kvarteren" | mkN "stötta" ; -- SaldoWN -- comment=31
lin seriously_Adv = mkAdv "seriöst" | mkAdv "på allvar" ; -- status=guess
lin youth_N = mkN "ungdom" | mkN "yngling" ; -- SaldoWN -- comment=3
lin tape_N = mkN "tejp" ; -- SaldoWN
lin elsewhere_Adv = mkAdv "annorstädes" ; -- comment=2
lin cover_N = mkN "täcke" | mkN "täckning" ; -- SaldoWN -- comment=17
lin fee_N = mkN "avgift" "avgifter" ; -- SaldoWN
lin program_N = mkN "program" "programmet" "program" "programmen" ; -- status=guess
lin treaty_N = mkN "fördrag" neutrum | mkN "fördrag" neutrum ; -- SaldoWN -- comment=5
lin necessarily_Adv = mkAdv "nödvändigtvis" ; -- status=guess
lin unlikely_A = mkA "osannolik" ; -- SaldoWN
lin properly_Adv = mkAdv "rätt" | mkAdv "på riktigt" ; -- status=guess
lin guest_N = mkN "gäst" "gäster" ; -- SaldoWN
lin code_N = mkN "kod" "koder" ; -- status=guess
lin hill_N = L.hill_N ;
lin screen_N = mkN "såll" neutrum | mkN "visa" ; -- SaldoWN -- comment=20
lin household_N = mkN "hushåll" neutrum ; -- status=guess
lin sequence_N = mkN "följd" "följder" | mkN "serie" "serier" ; -- SaldoWN -- comment=9
lin correct_A = L.correct_A;
lin female_A = mkA "kvinnlig" ; -- status=guess
lin phase_N = mkN "fas" "faser" ; -- comment=4
lin crowd_N = mkN "hop" | mkN "åskådare" utrum ; -- SaldoWN -- comment=15
lin welcome_V2 = mkV2 (mkV "välkomna"); -- status=guess, src=wikt
lin metal_N = mkN "metall" "metaller" ; -- status=guess
lin human_N = mkN "människa" ; -- status=guess
lin widely_Adv = mkAdv "allmänt" ; -- status=guess
lin undertake_V2 = mkV2 "företa" "företar" "företa" "företog" "företagit" "företagen" ; -- SaldoWN
lin cut_N = mkN "sår" neutrum | mkN "andel" "andelen" "andelar" "andelarna" ; -- SaldoWN -- comment=23
lin sky_N = L.sky_N ;
lin brain_N = mkN "hjärna" ; -- SaldoWN
lin expert_N = mkN "expert" "experter" ; -- SaldoWN
lin experiment_N = mkN "experiment" neutrum | mkN "försöksverksamhet" "försöksverksamheter" ; -- SaldoWN -- comment=7
lin tiny_A = mkA "jätteliten" ; -- status=guess
lin perfect_A = mkA "perfekt" "perfekt" | mkA "utmärkt" "utmärkt" ; -- SaldoWN -- comment=9
lin disappear_V = mkV "försvinna" "försvann" "försvunnit" ; -- SaldoWN
lin initiative_N = mkN "initiativ" neutrum | mkN "initiativkraft" ; -- SaldoWN -- comment=4
lin assumption_N = mkN "antagande" | mkN "övertagande" ; -- SaldoWN -- comment=2
lin photograph_N = mkN "fotografi" "fotografit" "fotografier" "fotografierna" ; -- SaldoWN
lin ministry_N = mkN "departement" neutrum | mkN "departement" neutrum ; -- SaldoWN -- comment=5
lin congress_N = mkN "kongress" "kongresser" | mkN "samlag" neutrum ; -- SaldoWN -- comment=2
lin transfer_N = mkN "transfer" | mkN "överlåtelse" "överlåtelser" ; -- SaldoWN -- comment=2
lin reading_N = mkN "uppläsning" ; -- comment=6
lin scientist_N = mkN "forskare" utrum | mkN "vetenskapsman" "vetenskapsmannen" "vetenskapsmän" "vetenskapsmännen" ; -- SaldoWN -- comment=3
lin fast_Adv = mkAdv "fort" ; -- comment=2
lin fast_A = mkA "snabb" | mkA "vidlyftig" ; -- SaldoWN -- comment=12
lin closely_Adv = mkAdv "på nära håll" ; -- status=guess
lin thin_A = L.thin_A ;
lin solicitorMasc_N = mkN "domare" "domare" ; ---- sense
lin secure_V2 = mkV2 "säkerställer" ; -- status=guess
lin plate_N = mkN "tallrik" ; -- SaldoWN
lin pool_N = mkN "pöl" | mkN "pool" "pooler" ; -- SaldoWN -- comment=11
lin gold_N = L.gold_N ;
lin emphasis_N = mkN "emfas" | mkN "betoning" ; -- SaldoWN -- comment=5
lin recall_VS = mkVS (mkV "återkalla"); -- status=guess, src=wikt
lin recall_V2 = mkV2 (mkV "återkalla"); -- status=guess, src=wikt
lin shout_V2 = dirV2 (partV (mkV "ropar")"till"); -- status=guess
lin shout_V = mkV "ropar" ; -- comment=4
lin generate_V2 = mkV2 (mkV "skapar"); -- status=guess, src=wikt
lin location_N = mkN "belägenhet" "belägenheter" | mkN "plats" "platser" ; -- status=guess
lin display_VS = mkVS (mkV "visa") ; -- status=guess
lin display_V2 = mkV2 "visa" ; -- status=guess
lin heat_N = mkN "värme" | mkN "värma" ; -- SaldoWN = mkN "värme" utrum ; -- comment=18
lin gun_N = mkN "vapen" "vapnet" "vapen" "vapnen" ; -- status=guess
lin shut_V2 = mkV2 (mkV "stänga"); -- status=guess, src=wikt
lin journey_N = mkN "resa" ; -- comment=2
lin imply_VS = mkVS (mkV "antyda" "antydde" "antytt") | mkVS (mkV "insinuerar"); -- status=guess, src=wikt status=guess, src=wikt
lin imply_V2 = mkV2 (mkV "antyda" "antydde" "antytt") | mkV2 (mkV "insinuerar"); -- status=guess, src=wikt status=guess, src=wikt
lin imply_V = mkV "betyda" "betydde" "betytt" ; -- comment=6
lin violence_N = mkN "våldsamhet" "våldsamheter" ; -- comment=4
lin dry_A = L.dry_A ;
lin historical_A = mkA "historisk" ; -- status=guess
lin step_V2 = mkV2 "träda" "trädde" "trätt" | dirV2 (partV (mkV "trampar")"ut") ; -- SaldoWN = mkV "träda" "träder" "träd" "trädade" "trädat" "trädd" ; -- comment=17
lin step_V = mkV "träda" "trädde" "trätt" | mkV "trampar" ; -- SaldoWN = mkV "träda" "träder" "träd" "trädade" "trädat" "trädd" ; -- comment=6
lin curriculum_N = mkN "läroplan" "läroplaner" ; -- SaldoWN
lin noise_N = mkN "oljud" neutrum | mkN "ljud" neutrum ; -- SaldoWN
lin lunch_N = mkN "lunch" "luncher" ; -- SaldoWN
lin fear_VS = L.fear_VS;
lin fear_V2 = L.fear_V2;
lin fear_V = mkV "fruktar" ; -- comment=4
lin succeed_V2 = mkV2 (mkV "lyckas"); -- status=guess, src=wikt
lin succeed_V = mkV "följa" "följde" "följt" ; -- comment=3
lin fall_N = mkN "skymning" | mkN "höst" ; -- SaldoWN -- comment=7
lin fall_2_N = mkN "höst" ; -- status=guess
lin fall_1_N = mkN "fall" "fall" ; -- status=guess
lin bottom_N = mkN "handelsfartyg" neutrum | mkN "sänka" ; -- SaldoWN -- comment=15
lin initial_A = mkA "initial" ; -- status=guess
lin theme_N = mkN "tema" "temat" "teman" "temana" ; -- status=guess
lin characteristic_N = mkN "särdrag" neutrum | mkN "kännetecken" "kännetecknet" "kännetecken" "kännetecknen" ; -- SaldoWN -- comment=10
lin pretty_Adv = mkAdv "tämligen" ; -- status=guess
lin empty_A = L.empty_A ;
lin display_N = mkN "uppvisning" | mkN "utställning" ; -- SaldoWN -- comment=8
lin combination_N = mkN "kombination" "kombinationer" | mkN "sammanställning" ; -- SaldoWN -- comment=6
lin interpretation_N = mkN "tolkning" ; -- comment=3
lin rely_V2 = mkV2 "lita" (mkPrep "på") ; -- status=guess
lin rely_V = mkV (mkV "lita") "på" ; -- status=guess, src=wikt
lin escape_VS = mkVS (mkV "undflyr"); -- status=guess, src=wikt
lin escape_V2 = mkV2 (mkV "undflyr"); -- status=guess, src=wikt
lin escape_V = mkV "undgå" "undgick" "undgått" ; -- comment=7
lin score_V2 = mkV2 (mkV (mkV "göra") "mål"); -- status=guess, src=wikt
lin score_V = mkV "vinna" "vann" "vunnit" ; -- comment=6
lin justice_N = mkN "rättvisa" | mkN "domare" utrum ; -- SaldoWN -- comment=10
lin upper_A = mkA "övre" ; -- status=guess
lin tooth_N = L.tooth_N ;
lin organize_V2V = mkV2V (mkV "organiserar"); -- status=guess, src=wikt
lin organize_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin cat_N = L.cat_N ;
lin tool_N = mkN "verktyg" neutrum | mkN "verktyg" neutrum ; -- SaldoWN -- comment=6
lin spot_N = mkN "fläck" | mkN "slurk" ; -- SaldoWN -- comment=3
lin bridge_N = mkN "bro" ; -- status=guess
lin double_A = mkA "dubbel" ; -- SaldoWN
lin direct_V2 = dirV2 (partV (mkV "visar")"in"); -- comment=9
lin direct_V = mkV "visar" ; -- comment=22
lin conclude_VS = mkVS (mkV "konkludera"); -- status=guess
lin conclude_V2 = mkV2 "konkluderar" ; -- comment=9
lin conclude_V = mkV "konkluderar" ; -- comment=9
lin relative_A = mkA "relativ" ; -- SaldoWN
lin soldier_N = mkN "soldat" "soldater" ; -- SaldoWN
lin climb_V2 = mkV2 (mkV "klättra"); -- status=guess, src=wikt
lin climb_V = mkV "stiga" "steg" "stigit" ; -- comment=6
lin breath_N = mkN "suck" ; -- comment=9
lin afford_V2V = mkV2V (mkV "bekosta") ; -- status=guess
lin afford_V2 = mkV2 "bekosta" | mkV2 (mkV (mkV "ha" "har" "ha" "hade" "haft" "havd") "råd") (mkPrep "med") ; -- status=guess
lin urban_A = mkA "urban" | mkA "stadsmässig" ; -- status=guess
lin nurse_N = mkN "sjuksköterska" ; -- SaldoWN
lin narrow_A = L.narrow_A ;
lin liberal_A = mkA "vidsynt" "vidsynt" ; -- comment=8
lin coal_N = mkN "kol" neutrum ; -- SaldoWN -- comment=4
lin priority_N = mkN "prioritet" "prioriteter" ; -- SaldoWN
lin wild_A = mkA "vild" "vilt" ; -- SaldoWN
lin revenue_N = mkN "intäkt" "intäkter" ; -- status=guess
lin membership_N = mkN "medlemskap" neutrum | mkN "medlemskap" neutrum ; -- SaldoWN -- comment=3
lin grant_N = mkN "anslag" neutrum | mkN "stipendium" "stipendiet" "stipendier" "stipendierna" ; -- SaldoWN -- comment=8
lin approve_V2 = mkV2 "godkänna" "godkände" "godkänt" | mkV2 "godkänner" ; -- SaldoWN
lin approve_V = mkV "godkänna" "godkände" "godkänt" | mkV "tillstyrker" ; -- SaldoWN -- comment=8
lin tall_A = mkA "lång" "längre" "längst" ; -- SaldoWN
lin apparent_A = mkA "skenbar" ; -- comment=4
lin faith_N = mkN "tro" | mkN "trohet" "troheter" ; -- SaldoWN -- comment=9
lin under_Adv = mkAdv "under" ; -- status=guess
lin fix_V2 = dirV2 (partV (mkV "riktar")"till"); -- comment=4
lin fix_V = mkV "arrangerar" ; -- comment=28
lin slow_A = mkA "långsam" "långsamt" "långsamma" "långsamma" "långsammare" "långsammast" "långsammaste" | mkA "sen" ; -- SaldoWN -- comment=14
lin troop_N = mkN "trupp" "trupper" ; -- SaldoWN
lin motion_N = mkN "rörelse" "rörelser" ; -- comment=9
lin leading_A = mkA "ledande" ; -- status=guess
lin component_N = mkN "komponent" "komponenter" ; -- comment=6
lin bloody_A = mkA "blodig" ; -- SaldoWN
lin literature_N = mkN "litteratur" "litteraturer" ; -- status=guess
lin conservative_A = mkA "konservativ" ; -- SaldoWN
lin variation_N = mkN "variation" "variationer" ; -- SaldoWN
lin remind_V2 = mkV2 "påminna" "påminde" "påmint" ; -- status=guess
lin inform_V2 = mkV2 "informera" | mkV2 "upplyser" ; -- comment=11
lin inform_V = mkV "informera" | mkV "upplyser" ; -- comment=11
lin alternative_N = mkN "alternativ" neutrum ; -- SaldoWN -- comment=2
lin neither_Adv = mkAdv "varken" ; -- comment=2
lin outside_Adv = mkAdv "utomhus" ; -- comment=5
lin mass_N = mkN "massa" | mkN "mässa" ; -- SaldoWN = mkN "massa" ; -- comment=5
lin busy_A = mkA "upptagen" "upptaget" ; -- SaldoWN
lin chemical_N = mkN "kemikalie" "kemikalier" ; -- status=guess
lin careful_A = mkA "försiktig" | mkA "grundlig" | mkA "noga" ; -- SaldoWN -- comment=10
lin investigate_V2 = mkV2 "undersöker" ; -- comment=3
lin investigate_V = mkV "undersöker" ; -- comment=3
lin roll_V2 = mkV2 "omsätta" "omsätter" "omsätt" "omsatte" "omsatt" "omsatt" | dirV2 (partV (mkV "rullar")"ut") ; -- SaldoWN -- comment=4
lin roll_V = mkV "omsätta" "omsätter" "omsätt" "omsatte" "omsatt" "omsatt" | mkV "vinglar" ; -- SaldoWN -- comment=10
lin instrument_N = mkN "instrument" neutrum | mkN "verktyg" neutrum ; -- SaldoWN -- comment=5
lin guide_N = mkN "guide" "guider" | mkN "vägvisare" utrum ; -- SaldoWN -- comment=6
lin criterion_N = mkN "kriterium" "kriteriet" "kriterier" "kriterierna" ; -- comment=3
lin pocket_N = mkN "ficka" | mkN "grupp" "grupper" ; -- SaldoWN -- comment=6
lin suggestion_N = mkN "förslag" neutrum | mkN "uppslag" neutrum ; -- SaldoWN = mkN "förslag" neutrum ; -- comment=19
lin aye_Interj = mkInterj "aj" ; ----
lin entitle_VS = mkVS (mkV "berättiga") ; -- status=guess
lin entitle_V2V = mkV2V (mkV "berättiga") ; -- status=guess
lin tone_N = mkN "röstläge" | mkN "ton" "tonnet" "ton" "tonnen" ; -- SaldoWN -- comment=4
lin attractive_A = mkA "tilldragande" | mkA "attraktiv" ; -- SaldoWN -- comment=7
lin wing_N = L.wing_N ;
lin surprise_N = mkN "överraskning" ; -- SaldoWN
lin male_N = mkN "mansperson" "manspersoner" ; -- comment=4
lin ring_N = mkN "ring" neutrum | mkN "slå" ; -- SaldoWN = mkN "ring" ; -- comment=16
lin pub_N = mkN "pub" ; -- SaldoWN
lin fruit_N = L.fruit_N ;
lin passage_N = mkN "passus" | mkN "öppning" ; -- SaldoWN -- comment=10
lin illustrate_VS = mkVS (mkV "illustrerar") ; -- comment=4
lin illustrate_V2 = mkV2 "illustrerar" ; -- comment=4
lin illustrate_V = mkV "illustrerar" ; -- comment=4
lin pay_N = mkN "visa" ; -- comment=7
lin ride_V2 = mkV2 (mkV "åker"); -- status=guess, src=wikt
lin ride_V = mkV "rida" "red" "ridit" ; -- status=guess
lin foundation_N = mkN "stiftelse" "stiftelser" ; -- SaldoWN
lin restaurant_N = L.restaurant_N ;
lin vital_A = mkA "vital" ; -- comment=4
lin alternative_A = mkA "alternativ" ; -- SaldoWN
lin burn_V2 = mkV2 "brinna" "brann" "brunnit" ; -- status=guess
lin burn_V = L.burn_V ;
lin map_N = mkN "karta" ; -- SaldoWN
lin united_A = mkA "förenad" "förenat" ; -- status=guess
lin device_N = mkN "apparat" "apparater" ; -- status=guess
lin jump_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin jump_V = L.jump_V;
lin estimate_VS = mkVS (mkV "uppskatta") ; -- status=guess
lin estimate_V2V = mkV2V (mkV "uppskatta") ; -- status=guess
lin estimate_V2 = mkV2 "uppskatta" ; -- status=guess
lin estimate_V = mkV "uppskattar" ; -- status=guess
lin conduct_V2 = mkV2 (mkV "leder"); -- status=guess, src=wikt
lin conduct_V = mkV "sköter" ; -- comment=8
lin derive_V2 = mkV2 (mkV "avleda" "avledde" "avlett") | mkV2 (mkV "uppnå"); -- status=guess, src=wikt status=guess, src=wikt
lin derive_V = (mkV "avleda" "avledde" "avlett") | mkV "uppnå" ; -- status=guess, src=wikt status=guess, src=wikt
lin comment_VS = mkVS (mkV "kommenterar"); -- status=guess, src=wikt
lin comment_V2 = mkV2 (mkV "kommenterar"); -- status=guess, src=wikt
lin comment_V = mkV "kommenterar" ; -- comment=2
lin east_N = mkN "öster" | mkN "öst" ; -- SaldoWN -- comment=4
lin advise_VS = mkVS (mkV "råda"); -- status=guess, src=wikt
lin advise_V2 = mkV2 (mkV "råda"); -- status=guess, src=wikt
lin advise_V = mkV "underrättar" ; -- comment=7
lin advance_N = mkN "förskott" neutrum | mkN "tillmötesgående" ; -- SaldoWN -- comment=21
lin motor_N = mkN "motor" "motorer" ; -- comment=4
lin satisfy_V2 = mkV2 (mkV "tillfredsställer") ; -- status=guess
lin hell_N = mkN "helvete" ; -- SaldoWN
lin winner_N = mkN "vinnare" utrum | mkN "segrare" utrum ; -- status=guess
lin effectively_Adv = mkAdv "effektivt" ; ---- sense
lin mistake_N = mkN "misstag" neutrum; -- comment=6
lin incident_N = mkN "händelse" "händelser" | mkN "olyckshändelse" "olyckshändelser" ; -- SaldoWN -- comment=7
lin focus_V2 = mkV2 (mkV "fokuserar") | mkV2 (mkV (mkV "koncentrera") "sig"); -- status=guess, src=wikt status=guess, src=wikt
lin focus_V = mkV "fokuserar" ; -- comment=4
lin exercise_VV = mkVV (mkV "öva") | mkVV (mkV "träna") | mkVV (mkV "praktiserar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exercise_V2 = mkV2 (mkV "öva") | mkV2 (mkV "träna") | mkV2 (mkV "praktiserar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exercise_V = mkV "utövar" ; -- comment=5
lin representation_N = mkN "föreställning" ; -- comment=10
lin release_N = mkN "överlåtelse" "överlåtelser" | mkN "utsläpp" neutrum ; -- status=guess
lin leaf_N = L.leaf_N ;
lin border_N = mkN "gräns" "gränser" | mkN "kant" "kanter" ; -- status=guess
lin wash_V2 = L.wash_V2;
lin wash_V = mkV "tvättar" ; -- comment=6
lin prospect_N = mkN "utsikt" "utsikter" | mkN "möjlighet" "möjligheter" ; -- SaldoWN -- comment=6
lin blow_V2 = dirV2 (partV (mkV "blåser")"av"); -- comment=6
lin blow_V = L.blow_V;
lin trip_N = mkN "tripp" neutrum; -- comment=11
lin observation_N = mkN "iakttagelse" "iakttagelser" | mkN "yttrande" ; -- SaldoWN -- comment=9
lin gather_V2 = dirV2 (partV (mkV "plockar")"ut"); -- comment=4
lin gather_V = mkV "utläser" ; -- comment=12
lin ancient_A = mkA "uråldrig" ; -- status=guess
lin brief_A = mkA "kort" "kort" ; -- comment=4
lin gate_N = mkN "grind" | mkN "port" ; -- SaldoWN -- comment=6
lin elderly_A = mkA "gammal" "gammalt" "gamla" "äldre" "äldst" ; -- status=guess
lin persuade_V2V = mkV2V (mkV "övertyga"); -- status=guess, src=wikt
lin persuade_V2 = mkV2 (mkV "övertyga"); -- status=guess, src=wikt
lin overall_A = mkA "övergripande" ; -- status=guess
lin rare_A = mkA "sällsynt" "sällsynt" | mkA "tunn" "tunt" ; -- SaldoWN -- comment=6
lin index_N = mkN "pekfinger" | mkN "register" neutrum ; -- SaldoWN -- comment=3
lin hand_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=3
lin circle_N = mkN "cirkel" | mkN "kretsgång" ; -- SaldoWN -- comment=10
lin creation_N = mkN "skapande" | mkN "utnämning" ; -- status=guess
lin drawing_N = mkN "teckning" ; -- SaldoWN
lin anybody_NP = S.mkNP (mkPN "vem som helst" utrum) | S.mkNP (mkPN "någon" utrum) ; --- split pos/neg
lin flow_N = mkN "stigande" ; -- comment=8
lin matter_V = mkV "innehålla" "innehöll" "innehållit" ; -- comment=4
lin external_A = mkA "extern" | mkA "utvärtes" ; -- status=guess
lin capable_A = mkA "duglig" | mkA "kapabel" ; -- SaldoWN -- comment=4
lin recover_V = reflV (mkV "återhämta") ; -- status=guess
lin shot_N = mkN "skott" neutrum | mkN "skytt" ; -- SaldoWN -- comment=4
lin request_N = mkN "anhållan" "anhållan" "anhållanden" "anhållandena" ; -- comment=5
lin impression_N = mkN "tryckning" ; -- comment=10
lin neighbour_N = mkN "granne" utrum | mkN "grannland" "grannlandet" "grannländer" "grannländerna" ; -- SaldoWN -- comment=4
lin theatre_N = mkN "teater" ; -- SaldoWN
lin beneath_Prep = mkPrep "nedanför" ; -- status=guess
lin hurt_V2 = mkV2 (mkV (mkV "göra") "ont"); -- status=guess, src=wikt
lin hurt_V = mkV "sårar" ; -- comment=3
lin mechanism_N = mkN "mekanism" "mekanismer" ; -- SaldoWN
lin potential_N = mkN "potential" "potentialer" ; -- SaldoWN
lin lean_V2 = dirV2 (partV (mkV "lutar")"av"); -- status=guess
lin lean_V = mkV "lutar" ; -- comment=3
lin defendant_N = mkN "svarande" ; -- SaldoWN = mkN "svarande" "svaranden" "svarande" "svarandena" ;
lin atmosphere_N = mkN "stämning" | mkN "luft" "lufter" ; -- SaldoWN -- comment=6
lin slip_V2 = mkV2 (mkV "halkar"); -- status=guess, src=wikt
lin slip_V = mkV "undgå" "undgick" "undgått" ; -- comment=12
lin chain_N = mkN "kedja" ; -- SaldoWN
lin accompany_V2 = mkV2 "åtfölja" "åtföljde" "åtföljt" | mkV2 (mkV (mkV "göra") "sällskap med") ; -- status=guess
lin wonderful_A = mkA "underbar" ; -- comment=4
lin earn_V2 = mkV2 (mkV "tjäna") ; -- status=guess
lin earn_V = mkV "förtjänar" ; -- comment=5
lin enemy_N = L.enemy_N ;
lin desk_N = mkN "skolbänk" ; -- SaldoWN
lin engineering_N = mkN "teknik" "tekniker" ; -- status=guess
lin panel_N = mkN "panel" "paneler" ; -- SaldoWN
lin distinction_N = mkN "åtskillnad" "åtskillnader" ; -- comment=7
lin deputy_N = mkN "ställföreträdare" utrum ; -- SaldoWN -- comment=6
lin discipline_N = mkN "bestraffning" | mkN "övning" ; -- SaldoWN -- comment=12
lin strike_N = mkN "strejk" ; -- status=guess
lin strike_2_N = mkN "anfall" "anfall" ; ---- sense
lin strike_1_N = mkN "strejk" ; -- status=guess
lin married_A = mkA "gift" "gift" ; -- status=guess
lin plenty_NP = S.mkNP (mkPN "mycket") ;
lin establishment_N = mkN "upprättande" ; -- comment=26
lin fashion_N = mkN "mode" | mkN "sätt" neutrum ; -- SaldoWN -- comment=7
lin roof_N = L.roof_N ;
lin milk_N = L.milk_N ;
lin entire_A = mkA "hel" ; -- status=guess
lin tear_N = mkN "tår" ; -- SaldoWN
lin secondary_A = mkA "sekundär" ; -- SaldoWN
lin finding_N = mkN "fynd" "fynd" | mkN "upptäckt" "upptäckter" ; -- status=guess
lin welfare_N = mkN "välstånd" neutrum | mkN "välfärd" ; -- SaldoWN -- comment=6
lin increased_A = mkA "ökad" ; -- status=guess
lin attach_V2 = mkV2 (mkV "fäster") ; -- status=guess
lin attach_V = mkV "fästa" "fäster" "fäst" "fäste" "fäst" "fäst" ; -- comment=5
lin typical_A = mkA "typisk" ; -- status=guess
lin typical_3_A = mkA "typisk" ; -- comment=2
lin typical_2_A = mkA "typisk" ; -- comment=2
lin typical_1_A = mkA "typisk" ; -- comment=2
lin meanwhile_Adv = mkAdv "samtidigt" ;
lin leadership_N = mkN "ledarskap" neutrum | mkN "ledning" ; -- SaldoWN -- comment=2
lin walk_N = mkN "promenad" "promenader" ; -- status=guess
lin negotiation_N = mkN "förhandling" ; -- SaldoWN
lin clean_A = L.clean_A ;
lin religion_N = L.religion_N;
lin count_V2 = L.count_V2;
lin count_V = mkV "skattar" ; -- comment=7
lin grey_A = mkA "livlös" ; -- comment=5
lin hence_Adv = mkAdv "därför" ; -- status=guess
lin alright_Adv = mkAdv "okej" ; -- status=guess
lin first_A = mkA "först" ; -- status=guess
lin fuel_N = mkN "bränsle" ; -- SaldoWN
lin mine_N = mkN "mina" | mkN "min" "miner" ; -- SaldoWN -- comment=6
lin appeal_V2 = dirV2 (partV (mkV "lockar")"in"); -- status=guess
lin appeal_V = mkV "överklagar" ; -- comment=7
lin servantMasc_N = mkN "betjänt" "betjänter" ; -- status=guess
lin liability_N = mkN "ansvar" neutrum | mkN "mottaglighet" ; -- SaldoWN -- comment=12
lin constant_A = mkA "ständig" ; -- SaldoWN
lin hate_VV = mkVV (mkV "hatar"); -- status=guess, src=wikt
lin hate_V2 = L.hate_V2;
lin shoe_N = L.shoe_N ;
lin expense_N = mkN "utgift" "utgifter" ; -- comment=7
lin vast_A = mkA "ofantlig" ; -- comment=3
lin soil_N = mkN "jordmån" | mkN "jord" ; -- SaldoWN -- comment=5
lin writing_N = mkN "skrivande" ; -- comment=7
lin nose_N = L.nose_N ;
lin origin_N = mkN "ursprung" neutrum ; -- status=guess
lin lord_N = mkN "herre" utrum; -- comment=4
lin rest_V2 = dirV2 (partV (mkV "vilar")"ut"); -- comment=2
lin drive_N = mkN "åktur" "åkturer" | mkN "timmerflotte" utrum ; -- SaldoWN -- comment=34
lin ticket_N = mkN "biljett" "biljetter" | mkN "parkeringsbot" "parkeringsböter" ; -- SaldoWN -- comment=12
lin editor_N = mkN "redaktör" "redaktörer" ; -- status=guess
lin switch_V2 = dirV2 (partV (mkV "kopplar")"ur"); -- comment=4
lin switch_V = mkV "kopplar" ; -- comment=3
lin provided_Subj = M.mkSubj "förutsatt" ; -- status=guess
lin northern_A = mkA "nordlig" ; -- status=guess
lin significance_N = mkN "betydelse" "betydelser" ; -- comment=5
lin channel_N = mkN "kanal" "kanaler" ; -- status=guess
lin convention_N = mkN "konvention" "konventioner" ; -- SaldoWN
lin damage_V2 = mkV2 (mkV "skadar"); -- status=guess, src=wikt
lin funny_A = mkA "rolig" | mkA "knäpp" ; -- SaldoWN -- comment=6
lin bone_N = L.bone_N ;
lin severe_A = mkA "sträng" ; -- comment=13
lin search_V2 = mkV2 (mkV "leta") | mkV2 (mkV "söker") ; -- status=guess
lin search_V = mkV "söker" | mkV "leta" ; -- comment=4
lin iron_N = L.iron_N ;
lin vision_N = mkN "vision" "visioner" | mkN "syn" ; -- SaldoWN -- comment=10
lin via_Prep = mkPrep "via" ;
lin somewhat_Adv = mkAdv "lite" ; -- status=guess
lin inside_Adv = mkAdv "inuti" ; -- comment=5
lin trend_N = mkN "trend" "trender" ; -- SaldoWN
lin revolution_N = mkN "rotation" "rotationer" | mkN "varv" neutrum ; -- SaldoWN -- comment=5
lin terrible_A = mkA "hemsk" ; -- comment=9
lin knee_N = L.knee_N ;
lin dress_N = mkN "krydda" ; -- comment=9
lin unfortunately_Adv = mkAdv "olyckligtvis" ; -- status=guess
lin steal_V2 = mkV2 (mkV "stjäla"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin steal_V = mkV "stjäla" "stjäl" "stjäl" "stal" "stulit" "stulen" ; -- comment=6
lin criminal_A = mkA "brottslig" ; -- comment=4
lin signal_N = mkN "signal" "signaler" ; -- comment=2
lin notion_N = mkN "begrepp" neutrum | mkN "uppfattning" ; -- SaldoWN -- comment=9
lin comparison_N = mkN "jämförelse" "jämförelser" | mkN "komparering" ; -- SaldoWN -- comment=4
lin academic_A = mkA "akademisk" ; -- SaldoWN
lin outcome_N = mkN "utfall" neutrum; -- comment=2
lin lawyer_N = mkN "advokat" "advokater" ; -- SaldoWN
lin strongly_Adv = mkAdv "starkt" ; -- status=guess
lin surround_V2 = mkV2 (mkV "omge" "omger" "omge" "omgav" "omgett" "omgiven"); -- status=guess, src=wikt
lin explore_VS = mkVS (mkV "utforska") ; -- status=guess
lin explore_V2 = mkV2 "utforska" ; -- status=guess
lin achievement_N = mkN "prestation" "prestationer" | mkN "verkställande" ; -- SaldoWN -- comment=10
lin odd_A = mkA "udda" | mkA "underlig" ; -- SaldoWN -- comment=22
lin expectation_N = mkN "sannolikhet" "sannolikheter" ; -- comment=3
lin corporate_A = mkA "korporativ" ; -- SaldoWN
lin prisoner_N = mkN "fånge" utrum | mkN "fånge" utrum ; -- SaldoWN -- comment=3
lin question_V2 = mkV2 "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" | dirV2 (partV (mkV "frågar")"ut") ; -- SaldoWN
lin rapidly_Adv = mkAdv "snabbt" | mkAdv "fort" ; -- status=guess
lin deep_Adv = mkAdv "långt" ; -- status=guess
lin southern_A = mkA "södra" ; -- status=guess
lin amongst_Prep = mkPrep "bland" ; -- status=guess
lin withdraw_V2 = mkV2 (mkV (mkV "ställer") "in"); -- status=guess
lin withdraw_V = mkV "utträda" "utträdde" "utträtt" ; -- comment=8
lin afterwards_Adv = mkAdv "därefter" ; -- comment=4
lin paint_V2 = dirV2 (partV (mkV "målar")"om"); -- comment=4
lin paint_V = mkV "sminkar" ; -- comment=9
lin judge_VS = mkVS (mkV "bedömer") ; -- status=guess
lin judge_V2 = dirV2 (partV (mkV "dömer")"ut"); -- status=guess
lin judge_V = mkV "anse" "ansåg" "ansett" ; -- comment=6
lin citizenMasc_N = mkN "medborgare" "medborgare" ; -- status=guess
lin permanent_A = mkA "permanent" "permanent" ; -- SaldoWN
lin weak_A = mkA "svag" | mkA "klen" ; -- SaldoWN -- comment=15
lin separate_V2 = mkV2 "skilja" "skilde" "skilt" | dirV2 (partV (mkV "skilja")"av") ; -- SaldoWN -- comment=3
lin separate_V = mkV "skilja" "skilde" "skilt" ; -- SaldoWN
lin plastic_N = L.plastic_N ;
lin connect_V2 = dirV2 (partV (mkV "kopplar") "ur"); -- comment=4
lin connect_V = mkV "kopplar" ; -- comment=7
lin fundamental_A = mkA "grund" ; -- comment=2
lin plane_N = mkN "flygplan" neutrum | mkN "yta" ; -- SaldoWN -- comment=8
lin height_N = mkN "höjd" "höjder" | mkN "topp" ; -- status=guess
lin opening_N = mkN "öppning" ; -- comment=8
lin lesson_N = mkN "lektion" "lektioner" | mkN "undervisningstimme" utrum ; -- SaldoWN -- comment=4
lin similarly_Adv = mkAdv "på samma sätt" ; -- status=guess
lin shock_N = mkN "stöt" | mkN "våg" ; -- SaldoWN -- comment=10
lin rail_N = mkN "skena" ; -- comment=5
lin tenant_N = mkN "hyresgäst" "hyresgäster" ; -- SaldoWN
lin owe_V2 = mkV2 (mkV (mkV "vara") "skyldig"); -- status=guess, src=wikt
lin owe_V = mkV (mkV "vara") "skyldig" ; -- status=guess, src=wikt
lin originally_Adv = mkAdv "ursprungligen" ; -- status=guess
lin middle_A = mkA "mellerst" ; -- status=guess
lin somehow_Adv = mkAdv "på något sätt" | mkAdv "på ett eller annat sätt" ; -- status=guess status=guess
lin minor_A = mkA "mindre" "mindre" "mindre" "mindre" "mindre" "minst" "minsta" ; -- status=guess
lin negative_A = mkA "negativ" ; -- SaldoWN
lin knock_V2 = dirV2 (partV (mkV "smälla" "small" "smäll")"av"); -- comment=17
lin knock_V = mkV "smälla" "small" "smäll" ; -- comment=14
lin root_N = L.root_N ;
lin pursue_V2 = dirV2 (partV (mkV "jagar")"ut"); -- status=guess
lin pursue_V = mkV "jagar" ; -- comment=9
lin inner_A = mkA "invändig" ; -- status=guess
lin crucial_A = mkA "kritisk" ; -- comment=3
lin occupy_V2 = mkV2 (mkV "ockuperar") | mkV2 (mkV "annekterar"); -- status=guess, src=wikt status=guess, src=wikt
lin occupy_V = mkV "uppta" "upptar" "uppta" "upptog" "upptagit" "upptagen" ; -- comment=10
lin that_AdA = lin AdA (ss "så") ; -- status=guess
lin independence_N = mkN "självständighet" "självständigheter" ; -- comment=4
lin column_N = mkN "pelare" utrum | mkN "spalt" "spalter" ; -- SaldoWN -- comment=5
lin proceeding_N = mkN "framsteg" "framsteg" ; ---- sense
lin female_N = mkN "kvinna" ; -- comment=3
lin beauty_N = mkN "skönhet" ; -- comment=6
lin perfectly_Adv = mkAdv "perfekt" ; -- status=guess
lin struggle_N = mkN "kamp" ; -- SaldoWN = mkN "kamp" "kamper" ;
lin gap_N = mkN "glipa" | mkN "hål" neutrum ; -- SaldoWN -- comment=4
lin house_V2 = mkV2 "inkvartera" ; -- status=guess
lin database_N = mkN "databas" "databaser" ; -- status=guess
lin stretch_V2 = mkV2 (mkV "sträcker"); -- status=guess, src=wikt
lin stretch_V = mkV "sträcker" ; -- comment=4
lin stress_N = mkN "belastning" | mkN "vikt" "vikter" ; -- SaldoWN -- comment=8
lin passenger_N = mkN "passagerare" utrum | mkN "passagerare" utrum ; -- SaldoWN -- comment=2
lin boundary_N = mkN "avgränsning" ; -- comment=3
lin easy_Adv = mkAdv "lätt" ; -- status=guess
lin view_V2 = dirV2 (partV (mkV "se" "såg" "sett")"ut"); -- comment=4
lin manufacturer_N = mkN "producent" "producenter" | mkN "tillverkare" utrum ; -- SaldoWN -- comment=3
lin sharp_A = L.sharp_A ;
lin formation_N = mkN "formation" "formationer" | mkN "formering" ; -- SaldoWN -- comment=2
lin queen_N = L.queen_N ;
lin waste_N = mkN "slöseri" neutrum | mkN "ödemark" "ödemarker" ; -- SaldoWN -- comment=22
lin virtually_Adv = mkAdv "virtuellt" ; -- status=guess
lin expand_V2 = dirV2 (partV (mkV "växa" "växer" "växa" "växte" "vuxit" "vuxen")"ur"); -- comment=5
lin expand_V = mkV "utvidgar" ; -- comment=6
lin contemporary_A = mkA "samtida" ; -- comment=4
lin politician_N = mkN "politiker" "politikern" "politiker" "politikerna" | mkN "statsman" "statsmannen" "statsmän" "statsmännen" ; -- status=guess
lin back_V = mkV "backar" ; -- comment=10
lin territory_N = mkN "territorium" "territoriet" "territorier" "territorierna" ; -- status=guess
lin championship_N = mkN "titel" ; -- comment=4
lin exception_N = mkN "undantag" neutrum ; -- SaldoWN -- comment=2
lin thick_A = L.thick_A ;
lin inquiry_N = mkN "förhör" neutrum; -- comment=6
lin topic_N = mkN "ämne" ; -- comment=4
lin resident_N = mkN "ockupant" "ockupanter" | mkN "invånare" utrum ; -- SaldoWN -- comment=2
lin transaction_N = mkN "transaktion" "transaktioner" ; -- SaldoWN
lin parish_N = mkN "socken" ; -- comment=4
lin supporter_N = mkN "stöd" neutrum; -- comment=10
lin massive_A = mkA "massiv" ; -- comment=2
lin light_V2 = dirV2 (partV (mkV "tänder")"på"); -- comment=2
lin light_V = mkV "yra" "yrde" "yrt" ; -- comment=9
lin unique_A = mkA "unik" ; -- status=guess
lin challenge_V2 = mkV2 "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" ; -- SaldoWN
lin challenge_V = mkV "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" | mkV "utmanar" ; -- SaldoWN -- comment=6
lin inflation_N = mkN "inflation" "inflationer" ; -- SaldoWN
lin assistance_N = mkN "assist" "assister" ; -- comment=4
lin list_V2V = mkV2V (mkV "lista") ; -- status=guess
lin list_V2 = mkV2 "lista" ; -- status=guess
lin list_V = mkV "lista" ; -- comment=4
lin identity_N = mkN "identitet" "identiteter" ; -- SaldoWN
lin suit_V2 = dirV2 (partV (mkV "passar")"på"); -- comment=5
lin suit_V = mkV "tillfredsställer" ; -- comment=7
lin parliamentary_A = mkA "parlamentarisk" ; -- status=guess
lin unknown_A = mkA "okänd" "okänt" ; -- status=guess
lin preparation_N = mkN "beredskap" "beredskaper" | mkN "preparat" neutrum ; -- SaldoWN -- comment=12
lin elect_V3 = mkV3 (mkV "välja" "valde" "valt") ; -- SaldoWN -- status=guess, src=wikt
lin elect_V2V = mkV2V (mkV "välja" "valde" "valt") ; -- SaldoWN -- status=guess, src=wikt
lin elect_V2 = mkV2 "välja" "valde" "valt" ; -- status=guess
lin elect_V = mkV "välja" "valde" "valt" | mkV "utvälja" "utvalde" "utvalt" ; -- SaldoWN -- comment=2
lin badly_Adv = mkAdv "dåligt" | mkAdv "ont" ; --- split
lin moreover_Adv = mkAdv "dessutom" ; -- comment=2
lin tie_V2 = L.tie_V2 ;
lin tie_V = mkV "knyta" "knöt" "knutit" ; -- SaldoWN
lin cancer_N = mkN "cancer" ; -- SaldoWN
lin champion_N = mkN "mästare" utrum ; -- SaldoWN -- comment=6
lin exclude_V2 = mkV2 "utesluta" "uteslöt" "uteslutit" | mkV2 (mkV "utelämna") | mkV2 (mkV "exkluderar") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin review_V2 = dirV2 (partV (mkV "mönstrar")"på"); -- comment=2
lin review_V = mkV "överblickar" ; -- comment=10
lin licence_N = mkN "licens" "licenser" | mkN "tygellöshet" ; -- SaldoWN -- comment=20
lin breakfast_N = mkN "frukost" ; -- SaldoWN
lin minority_N = mkN "fåtal" neutrum | mkN "minoritet" "minoriteter" ; -- SaldoWN
lin appreciate_V2 = mkV2 "värdesätta" "värdesätter" "värdesätt" "värdesatte" "värdesatt" "värdesatt" ; -- status=guess
lin appreciate_V = mkV "värdesätta" "värdesätter" "värdesätt" "värdesatte" "värdesatt" "värdesatt" | mkV "uppfattar" ; -- SaldoWN -- comment=5
lin fan_N = variants{} ; -- 
lin fan_3_N = mkN "solfjäder" ; ---- sense
lin fan_2_N = mkN "fan" "fans" ; ---- sense ; inflection
lin fan_1_N = mkN "fläkt" ; ---- sense
lin chief_N = mkN "chef" "chefer" | mkN "boss" neutrum ; -- SaldoWN -- comment=5
lin accommodation_N = mkN "utrymme" ; -- comment=10
lin subsequent_A = mkA "påföljande" ; -- SaldoWN
lin democracy_N = mkN "demokrati" "demokratier" ; -- SaldoWN
lin brown_A = L.brown_A ;
lin taste_N = mkN "smak" "smaker" | mkN "smakprov" neutrum ; -- SaldoWN -- comment=5
lin crown_N = mkN "krona" | mkN "trädkrona" ; -- SaldoWN -- comment=12
lin permit_V2V = mkV2V (mkV "tillåta"); -- status=guess, src=wikt
lin permit_V2 = mkV2 (mkV "tillåta"); -- status=guess, src=wikt
lin permit_V = mkV "tillåta" "tillät" "tillåtit" ; -- comment=2
lin buyerMasc_N = mkN "köpare" "köpare" ; -- status=guess
lin gift_N = mkN "gåva" ; -- SaldoWN
lin resolution_N = mkN "beslut" neutrum | mkN "lösning" ; -- SaldoWN -- comment=11
lin angry_A = mkA "arg" | mkA "elak" ; -- SaldoWN -- comment=9
lin metre_N = mkN "meter" ; -- comment=5
lin wheel_N = mkN "hjul" neutrum | mkN "rulla" ; -- SaldoWN -- comment=3
lin clause_N = mkN "sats" "satser" ; -- comment=3
lin break_N = mkN "brott" neutrum | mkN "utbrytning" ; -- SaldoWN = mkN "brott" neutrum ; -- comment=29
lin tank_N = mkN "stridsvagn" ; -- SaldoWN
lin benefit_V2 = mkV2 (mkV "understöda" "understödde" "understött") ; -- status=guess
lin benefit_V = mkV "understöda" "understödde" "understött" ; -- comment=4
lin engage_V2 = mkV2 "engagera" ; -- status=guess
lin engage_V = reflV (mkV "engagera") ; -- status=guess
lin alive_A = mkA "levande" ; -- SaldoWN
lin complaint_N = mkN "klagomål" "klagomål" ; -- status=guess
lin inch_N = mkN "tum" "tummen" "tum" "tummen" ; -- SaldoWN
lin firm_A = mkA "beslutsam" "beslutsamt" "beslutsamma" "beslutsamma" "beslutsammare" "beslutsammast" "beslutsammaste" ; -- comment=7
lin abandon_V2 = mkV2 "överge" "överger" "överge" "övergav" "övergett" "övergiven" | dirV2 (partV (mkV "lämnar")"över") ; -- SaldoWN -- comment=3
lin blame_V2 = dirV2 (partV (mkV "lastar")"ur"); -- comment=4
lin blame_V = mkV "klandrar" ; -- comment=6
lin clean_V2 = dirV2 (partV (mkV "tvättar")"av"); -- comment=5
lin clean_V = mkV "tömmer" ; -- comment=9
lin quote_V2 = mkV2 (mkV (mkV "ge") "anbud") | mkV2 (mkV "offererar"); -- status=guess, src=wikt status=guess, src=wikt
lin quote_V = mkV "åberopar" ; -- comment=6
lin quantity_N = mkN "kvantitet" "kvantiteter" ; -- SaldoWN
lin rule_VS = mkVS (mkV "styra" "styrde" "styrt") | mkVS (mkV "regerar"); -- status=guess, src=wikt status=guess, src=wikt
lin rule_V2 = mkV2 (mkV "styra" "styrde" "styrt") | mkV2 (mkV "regerar"); -- status=guess, src=wikt status=guess, src=wikt
lin rule_V = mkV "avgöra" "avgjorde" "avgjort" ; -- comment=7
lin guilty_A = mkA "skyldig" ; -- comment=2
lin prior_A = mkA "föregående" ; -- status=guess
lin round_A = L.round_A ;
lin eastern_A = mkA "ostlig" ; -- status=guess
lin coat_N = L.coat_N ;
lin involvement_N = mkN "inblandning" ; -- comment=6
lin tension_N = mkN "spänning" | mkN "ångtryck" neutrum ; -- SaldoWN = mkN "spänning" ; -- comment=6
lin diet_N = mkN "diet" "dieter" ; -- SaldoWN
lin enormous_A = mkA "enorm" ; -- comment=5
lin score_N = mkN "ställning" | mkN "tjog" neutrum ; -- SaldoWN -- comment=12
lin rarely_Adv = mkAdv "sällan" ; -- status=guess
lin prize_N = mkN "pris" neutrum | mkN "vinst" "vinster" ; -- SaldoWN = mkN "pris" ; = mkN "pris" "priser" ; = mkN "pris" neutrum ; -- comment=13
lin remaining_A = mkA "återstående" ; -- status=guess
lin significantly_Adv = mkAdv "signifikant" | mkAdv "markant" ; -- status=guess
lin glance_V2 = dirV2 (partV (mkV "tittar")"till"); -- comment=4
lin glance_V = mkV "tittar" ; -- comment=6
lin dominate_V2 = mkV2 "dominerar" ; -- comment=4
lin dominate_V = mkV "dominerar" ; -- comment=4
lin trust_VS = mkVS (mkV (mkV "lita") "på") ; -- status=guess
lin trust_V2 = mkV2 (mkV "lita") (mkPrep "på") ; -- status=guess
lin naturally_Adv = mkAdv "naturligtvis" ; -- status=guess
lin interpret_V2 = mkV2 "tolka" ; -- status=guess
lin interpret_V = mkV "tolka" ; -- status=guess
lin land_V2 = mkV2 (mkV "landsätta" "landsätter" "landsätt" "landsatte" "landsatt" "landsatt") ; -- status=guess
lin land_V = mkV "landa" ; -- status=guess
lin frame_N = mkN "ram" ; -- status=guess
lin extension_N = mkN "utvidgning" | mkN "utbyggnad" "utbyggnader" ; -- SaldoWN
lin mix_V2 = mkV2 "blanda" ; -- status=guess
lin mix_V = mkV "blanda" ; -- status=guess
lin spokesman_N = mkN "förespråkare" utrum | mkN "talesman" "talesmannen" "talesmän" "talesmännen" ; -- SaldoWN -- comment=3
lin friendly_A = mkA "vänlig" | mkA "vänskaplig" ; -- SaldoWN -- comment=6
lin acknowledge_VS = mkVS (mkV "erkänna" "erkände" "erkänt") ; -- comment=5
lin acknowledge_V2 = mkV2 (mkV "erkänna" "erkände" "erkänt") ; -- comment=5
lin register_V2 = dirV2 (partV (mkV "listar")"ut"); -- comment=2
lin register_V = mkV "uttrycker" ; -- comment=12
lin regime_N = mkN "regim" "regimer" ; ---- already split
lin regime_2_N = mkN "regim" "regimer" ; -- status=guess
lin regime_1_N = mkN "regim" "regimer" ; -- status=guess
lin fault_N = mkN "fel" neutrum | mkN "skuld" "skulder" ; -- SaldoWN = mkN "fel" neutrum ; -- comment=10
lin dispute_N = mkN "dispyt" "dispyter" ; -- comment=8
lin grass_N = L.grass_N ;
lin quietly_Adv = mkAdv "tyst" ; -- status=guess
lin decline_N = mkN "sluttning" ; -- comment=10
lin dismiss_V2 = mkV2 (mkV "avskedar") | mkV2 (mkV "sparkar") | mkV2 (mkV "entledigar") | mkV2 (mkV "upplöser"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin delivery_N = mkN "förlossning" | mkN "uppgivande" ; -- SaldoWN -- comment=7
lin complain_VS = mkVS (mkV "klagar"); -- status=guess, src=wikt
lin complain_V = mkV "klagar" ; -- comment=2
lin conservative_N = mkN "skydd" neutrum; -- comment=5
lin shift_V2 = dirV2 (partV (mkV "flyttar")"ut"); -- comment=2
lin shift_V = mkV "flyttar" ; -- comment=5
lin port_N = mkN "portvin" "portvinet" "portviner" "portvinerna" ; -- comment=6
lin beach_N = mkN "strand" "stränder" ; -- SaldoWN
lin string_N = mkN "snöre" | mkN "tråd" ; -- SaldoWN -- comment=9
lin depth_N = mkN "djup" neutrum; -- comment=4
lin unusual_A = mkA "ovanlig" ; -- comment=4
lin travel_N = mkN "resa" ; -- comment=13
lin pilot_N = mkN "pilot" "piloter" ; -- SaldoWN
lin obligation_N = mkN "förpliktelse" "förpliktelser" | mkN "skyldighet" "skyldigheter" ; -- SaldoWN -- comment=4
lin gene_N = mkN "gen" "gener" ; -- SaldoWN
lin yellow_A = L.yellow_A;
lin republic_N = mkN "republik" "republiker" ; -- SaldoWN
lin shadow_N = mkN "skugga" ; -- SaldoWN
lin dear_A = mkA "kär" ; -- comment=6
lin analyse_V2 = variants{} ; -- 
lin anywhere_Adv = mkAdv "var som helst" | mkAdv "någonstans" ; --- split pos/neg
lin average_N = mkN "medeltal" neutrum | mkN "genomsnitt" neutrum ; -- SaldoWN -- comment=2
lin phrase_N = mkN "uttryckssätt" neutrum; -- comment=5
lin long_term_A = mkA "långsiktig" ;
lin crew_N = mkN "besättning" ; -- status=guess
lin lucky_A = mkA "lyckosam" "lyckosamt" "lyckosamma" "lyckosamma" "lyckosammare" "lyckosammast" "lyckosammaste" | mkA "lycklig" ; -- SaldoWN -- comment=2
lin restore_V2 = variants{} ; -- 
lin convince_V2V = mkV2V (mkV "övertyga"); -- status=guess, src=wikt
lin convince_V2 = mkV2 (mkV "övertyga"); -- status=guess, src=wikt
lin coast_N = mkN "kust" "kuster" ; -- status=guess
lin engineer_N = mkN "ingenjör" "ingenjörer" | mkN "maskinist" "maskinister" ; -- SaldoWN -- comment=7
lin heavily_Adv = variants{} ; -- 
lin extensive_A = mkA "vidsträckt" "vidsträckt" ; -- status=guess
lin glad_A = mkA "glad" | mkA "villig" ; -- SaldoWN -- comment=2
lin charity_N = mkN "välgörenhet" "välgörenheter" | mkN "människokärlek" ; -- SaldoWN -- comment=7
lin oppose_V2 = mkV2 (mkV "opponerar"); -- status=guess, src=wikt
lin oppose_V = mkV "motarbetar" ; -- comment=4
lin defend_V2 = mkV2 "försvara" ; -- status=guess
lin alter_V2 = dirV2 (partV (mkV "skiftar")"ut"); -- status=guess
lin alter_V = mkV "ändrar" ; -- comment=6
lin warning_N = mkN "varning" | mkN "varsel" neutrum ; -- SaldoWN -- comment=4
lin arrest_V2 = mkV2 "anhålla" "anhöll" "anhållit" | dirV2 (partV (mkV "stoppar") "till") ; -- SaldoWN -- comment=3
lin framework_N = mkN "konstruktion" "konstruktioner" ; -- comment=7
lin approval_N = mkN "välsignelse" "välsignelser" | mkN "godkännande" ; -- SaldoWN -- comment=6
lin bother_VV = variants{}; -- mkV "bråkar" ; -- comment=7
lin bother_V2V = variants{}; -- mkV "bråkar" ; -- comment=7
lin bother_V2 = variants{}; -- mkV "bråkar" ; -- comment=7
lin bother_V = mkV "bråkar" ; -- comment=7
lin novel_N = mkN "roman" "romaner" ; -- status=guess
lin accuse_V2 = mkV2 (mkV "anklagar"); -- status=guess, src=wikt
lin surprised_A = variants{} ; -- 
lin currency_N = mkN "valuta" ; -- SaldoWN
lin restrict_V2 = mkV2 (mkV "inskränka") | mkV2 (mkV "begränsa"); -- status=guess, src=wikt status=guess, src=wikt
lin restrict_V = mkV "begränsar" ; -- comment=2
lin possess_V2 = mkV2 (mkV "äga"); -- status=guess, src=wikt
lin moral_A = mkA "sedelärande" ; -- comment=3
lin protein_N = mkN "protein" "proteinet" "proteiner" "proteinerna" ; -- SaldoWN
lin distinguish_V2 = dirV2 (partV (mkV "skiljer" "skilde" "skilt")"av"); -- comment=2
lin distinguish_V = mkV "kännetecknar" ; -- comment=6
lin gently_Adv = mkAdv "sakta" ; -- comment=2
lin reckon_VS = variants{}; -- dirV2 (partV (mkV "räknar")"ut"); -- comment=5
lin incorporate_V2 = mkV2 (mkV "uppta" "upptar" "uppta" "upptog" "upptagit" "upptagen"); -- status=guess, src=wikt
lin proceed_V = mkV "fortsätta" "fortsätter" "fortsätt" "fortsatte" "fortsatt" "fortsatt" ; -- comment=9
lin assist_V2 = mkV2 (mkV "assisterar") | mkV2 (mkV "hjälper") | mkV2 (mkV "bistå" "bistod" "bistått") ; -- status=guess
lin assist_V = mkV "assisterar" | mkV "hjälper" ; -- status=guess
lin sure_Adv = mkAdv "absolut" ; -- status=guess
lin stress_VS = variants{} ; -- 
lin stress_V2 = variants{} ; -- 
lin justify_VV = mkVV (mkV "berättiga") ; -- status=guess
lin justify_V2 = mkV2 "berättiga" ; -- status=guess
lin behalf_N = variants{} ; -- 
lin councillor_N = variants{} ; -- 
lin setting_N = mkN "sättning" ; -- status=guess
lin command_N = mkN "kontroll" | mkN "herravälde" ; -- SaldoWN = mkN "kontroll" "kontroller" ; -- comment=16
lin command_2_N = mkN "kontroll" "kontroller" ; -- status=guess
lin command_1_N = mkN "kommando" "kommandon" ; -- status=guess
lin maintenance_N = mkN "underhåll" neutrum | mkN "livsuppehälle" ; -- SaldoWN -- comment=10
lin stair_N = mkN "trappa" ; -- status=guess
lin poem_N = mkN "dikt" "dikter" ; -- SaldoWN
lin chest_N = mkN "sekretär" "sekretärer" | mkN "kista" ; -- SaldoWN -- comment=5
lin like_Adv = mkAdv "som" ; -- comment=2
lin secret_N = mkN "hemlighet" "hemligheter" ; -- SaldoWN
lin restriction_N = mkN "begränsning" | mkN "förbehåll" neutrum ; -- SaldoWN -- comment=4
lin efficient_A = mkA "effektiv" ; -- SaldoWN
lin suspect_VS = mkVS (mkV "misstänka"); -- status=guess, src=wikt
lin suspect_V2 = mkV2 (mkV "misstänka"); -- status=guess, src=wikt
lin hat_N = L.hat_N ;
lin tough_A = mkA "hård" "hårt" | mkA "kämpig" ; -- SaldoWN -- comment=13
lin firmly_Adv = variants{} ; -- 
lin willing_A = mkA "villig" ; -- comment=3
lin healthy_A = mkA "sund" ; -- comment=6
lin focus_N = mkN "inriktning" ; -- comment=8
lin construct_V2 = mkV2 (mkV "konstruerar"); -- status=guess, src=wikt
lin occasionally_Adv = variants{} ; -- 
lin mode_N = variants{} ; -- 
lin saving_N = mkN "besparing" ; -- comment=2
lin comfortable_A = mkA "bekväm" | mkA "trygg" ; -- SaldoWN -- comment=10
lin camp_N = mkN "läger" neutrum ; -- status=guess
lin trade_V2 = variants{}; -- mkV "byter" ;
lin trade_V = mkV "byter" ; -- status=guess
lin export_N = mkN "export" "exporter" | mkN "exportartikel" ; -- SaldoWN -- comment=3
lin wake_V2 = mkV2 (mkV "väcker") ; -- status=guess
lin wake_V = mkV "vaknar" ; -- comment=2
lin partnership_N = mkN "partnerskap" neutrum | mkN "kompanjonskap" ; -- SaldoWN -- comment=3
lin daily_A = mkA "daglig" ; -- status=guess
lin abroad_Adv = mkAdv "utomlands" ; -- comment=5
lin profession_N = mkN "yrke" ; -- SaldoWN
lin load_N = mkN "börda" | mkN "fylla" ; -- SaldoWN -- comment=6
lin countryside_N = mkN "landsbygd" | mkN "bygd" "bygder" ; -- SaldoWN -- comment=2
lin boot_N = L.boot_N ;
lin mostly_Adv = mkAdv "mestadels" ; -- status=guess
lin sudden_A = mkA "plötslig" ; -- SaldoWN
lin implement_V2 = mkV2 (mkV "implementera"); -- status=guess, src=wikt
lin reputation_N = mkN "anseende" | mkN "rykte" ; -- SaldoWN -- comment=4
lin print_V2 = dirV2 (partV (mkV "präntar")"i"); -- status=guess
lin print_V = mkV "trycker" ; -- comment=4
lin calculate_VS = mkVS (mkV "räkna") | mkVS (mkV "beräkna") | mkVS (mkV (mkV "räkna") "ut"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin calculate_V2 = dirV2 (partV (mkV "räknar")"ut"); -- comment=5
lin calculate_V = mkV "räknar" ; -- comment=3
lin keen_A = mkA "skarp" ; -- comment=21
lin guess_VS = mkVS (mkV "gissar"); -- status=guess, src=wikt
lin guess_V2 = mkV2 (mkV "gissar"); -- status=guess, src=wikt
lin guess_V = mkV "anta" "antar" "anta" "antog" "antagit" "antagen" ; -- comment=4
lin recommendation_N = mkN "rekommendation" "rekommendationer" | mkN "vitsord" neutrum ; -- SaldoWN -- comment=3
lin autumn_N = mkN "höst" ; -- SaldoWN
lin conventional_A = mkA "konventionell" ; -- SaldoWN
lin cope_V = variants{} ; -- 
lin constitute_V2 = mkV2 (mkV "utgöra"); -- status=guess, src=wikt
lin poll_N = mkN "enkät" "enkäter" | mkN "val" ; -- SaldoWN -- comment=10
lin voluntary_A = mkA "frivillig" ; -- SaldoWN
lin valuable_A = mkA "värdefull" ; -- SaldoWN
lin recovery_N = mkN "återhämtning" | mkN "återvinnande" ; -- SaldoWN -- comment=6
lin cast_V2 = mkV2 "rollbesätta" "rollbesätter" "rollbesätt" "rollbesatte" "rollbesatt" "rollbesatt" | dirV2 (partV (mkV "ordnar")"om") ; -- status=guess
lin cast_V = mkV "rollbesätta" "rollbesätter" "rollbesätt" "rollbesatte" "rollbesatt" "rollbesatt" | mkV "ordnar" ; -- status=guess
lin premise_N = mkN "premiss" "premisser" ; -- SaldoWN
lin resolve_V2 = dirV2 (partV (mkV "löser")"ut"); -- status=guess
lin resolve_V = mkV "sönderdelar" ; -- comment=7
lin regularly_Adv = variants{} ; -- 
lin solve_V2 = dirV2 (partV (mkV "löser")"ut"); -- status=guess
lin plaintiff_N = mkN "kärande" ; -- SaldoWN = mkN "kärande" "käranden" "kärande" "kärandena" ;
lin critic_N = mkN "kritiker" "kritikern" "kritiker" "kritikerna" ; -- SaldoWN
lin agriculture_N = mkN "jordbruk" neutrum | mkN "jordbruk" neutrum ; -- SaldoWN -- comment=4
lin ice_N = L.ice_N ;
lin constitution_N = mkN "konstitution" "konstitutioner" | mkN "utseende" ; -- SaldoWN -- comment=14
lin communist_N = mkN "kommunist" "kommunister" ; -- status=guess
lin layer_N = mkN "lager" ; -- SaldoWN = mkN "lager" ; = mkN "lager" neutrum ;
lin recession_N = mkN "recession" "recessioner" ; -- SaldoWN
lin slight_A = mkA "späd" ; -- comment=6
lin dramatic_A = mkA "dramatisk" ; -- SaldoWN
lin golden_A = mkA "gyllene" ; -- comment=3
lin temporary_A = mkA "temporär" | mkA "tillfällig" ; -- SaldoWN -- comment=3
lin suit_N = mkN "uppvaktning" | mkN "omgång" ; -- SaldoWN -- comment=10
lin shortly_Adv = mkAdv "snart" ; -- status=guess
lin initially_Adv = mkAdv "inledningsvis" ; -- status=guess
lin arrival_N = mkN "uppnående" ; -- comment=3
lin protest_N = mkN "protest" "protester" ; -- SaldoWN
lin resistance_N = mkN "motstånd" neutrum; -- comment=6
lin silent_A = mkA "tystgående" ; -- comment=2
lin presentation_N = mkN "presentation" "presentationer" ; -- SaldoWN
lin soul_N = mkN "själ" ; -- SaldoWN
lin self_N = mkN "jag" neutrum | mkN "jag" neutrum ; -- SaldoWN -- comment=2
lin judgment_N = mkN "omdöme" ; -- SaldoWN
lin feed_V2 = mkV2 (mkV "matar"); -- status=guess
lin feed_V = mkV "fodrar" ; -- comment=5
lin muscle_N = mkN "muskel" "muskeln" "muskler" "musklerna" ; -- SaldoWN
lin shareholder_N = mkN "aktieägare" utrum | mkN "aktieägare" utrum ; -- SaldoWN
lin opposite_A = mkA "motsatt" ; -- SaldoWN
lin pollution_N = mkN "förorening" | mkN "nedsmutsning" ; -- SaldoWN -- comment=2
lin wealth_N = mkN "rikedom" ; -- SaldoWN
lin video_taped_A = variants{} ; -- 
lin kingdom_N = mkN "kungarike" ; -- SaldoWN
lin bread_N = L.bread_N ;
lin perspective_N = mkN "utsikt" "utsikter" ; -- comment=3
lin camera_N = L.camera_N ;
lin prince_N = mkN "prins" ; -- SaldoWN
lin illness_N = mkN "sjukdom" ; -- SaldoWN
lin cake_N = mkN "kaka" | mkN "tårta" ; -- SaldoWN
lin meat_N = L.meat_N ;
lin submit_V2 = mkV2 (mkV "inlämna"); -- status=guess, src=wikt
lin submit_V = mkV "avge" "avger" "avge" "avgav" "avgett" "avgiven" ; -- comment=17
lin ideal_A = mkA "ideal" | mkA "orealistisk" ; -- SaldoWN -- comment=7
lin relax_V2 = dirV2 (partV (mkV "slappnar")"av"); -- comment=2
lin relax_V = mkV "mildrar" ; -- comment=8
lin penalty_N = mkN "straff" | mkN "bestraffning" ; -- SaldoWN = mkN "straff" neutrum ; -- comment=9
lin purchase_V2 = mkV2 "köper" ;
lin tired_A = mkA "trött" "trött" ; -- status=guess
lin beer_N = L.beer_N ;
lin specify_VS = variants{}; -- mkV2 "specificera" ;
lin specify_V2 = mkV2 "specificera" ; -- status=guess
lin specify_V = mkV "specificerar" ; -- comment=2
lin short_Adv = mkAdv "kort" ; -- comment=2
lin monitor_V2 = mkV2 (mkV "övervaka") | mkV2 (mkV "kontrollerar"); -- status=guess, src=wikt status=guess, src=wikt
lin monitor_V = mkV "övervakar" ; -- comment=4
lin electricity_N = mkN "elektricitet" "elektriciteter" ; -- SaldoWN
lin specifically_Adv = variants{} ; -- 
lin bond_N = mkN "förbindelse" "förbindelser" | mkN "obligation" "obligationer" ; -- SaldoWN -- comment=8
lin statutory_A = compoundA (regA "lagstadgad"); -- status=guess
lin laboratory_N = mkN "laboratorium" "laboratoriet" "laboratorier" "laboratorierna" ; -- SaldoWN
lin federal_A = mkA "federal" ; -- status=guess
lin captain_N = mkN "kapten" "kaptener" | mkN "leda" ; -- SaldoWN -- comment=6
lin deeply_Adv = variants{} ; -- 
lin pour_V2 = dirV2 (partV (mkV "strömmar")"över"); -- comment=18
lin pour_V = mkV "strömmar" ; -- comment=10
lin boss_N = L.boss_N;
lin creature_N = mkN "varelse" "varelser" ; -- comment=8
lin urge_VS = mkVS (mkV "uppmanar"); -- status=guess, src=wikt
lin urge_V2V = mkV2V (mkV "uppmanar"); -- status=guess, src=wikt
lin urge_V2 = mkV2 (mkV "uppmanar"); -- status=guess, src=wikt
lin locate_V2 = mkV2 (mkV "placerar"); -- status=guess, src=wikt
lin locate_V = mkV "placerar" ; -- comment=4
lin being_N = mkN "väsen" neutrum; -- comment=6
lin struggle_VV = variants{}; -- mkV "kämpar" ; -- comment=5
lin struggle_V = mkV "kämpar" ; -- comment=5
lin lifespan_N = variants{} ; -- 
lin flat_A = mkA "platt" | mkA "uttrycklig" ; -- SaldoWN -- comment=41
lin valley_N = mkN "dal" ; -- SaldoWN
lin like_A = mkA "typisk" ; -- comment=7
lin guard_N = mkN "vakt" "vakter" ; -- SaldoWN
lin emergency_N = mkN "nödfall" neutrum | mkN "nödsituation" "nödsituationer" ; -- SaldoWN -- comment=4
lin dark_N = mkN "mörker" neutrum | mkN "okunnighet" "okunnigheter" ; -- SaldoWN -- comment=4
lin bomb_N = mkN "bomb" "bomber" ; -- SaldoWN
lin dollar_N = mkN "dollar" "dollarn" "dollar" "dollarna" ; -- SaldoWN
lin efficiency_N = mkN "effektivitet" "effektiviteter" ; -- comment=5
lin mood_N = mkN "humör" neutrum | mkN "sinnesstämning" ; -- SaldoWN -- comment=4
lin convert_V2 = mkV2 (mkV "omvänder"); -- status=guess, src=wikt
lin convert_V = mkV "omvänder" ; -- comment=7
lin possession_N = mkN "innehav" neutrum | mkN "ägodel" "ägodelen" "ägodelar" "ägodelarna" ; -- SaldoWN -- comment=6
lin marketing_N = mkN "marknadsföring" ; -- SaldoWN
lin please_VV = mkVV (mkV "behagar") | mkVV (mkV "glädja" "gladde" "glatt") | mkVV (mkV "tillfredsställer") ; -- status=guess
lin please_V2V = mkV2V (mkV "behagar") | mkV2V (mkV "glädja" "gladde" "glatt") | mkV2V (mkV "tillfredsställer") ; -- status=guess
lin please_V2 = mkV2 (mkV "behagar") | mkV2 (mkV "glädja" "gladde" "glatt") | mkV2 (mkV "tillfredsställer") ; -- status=guess
lin please_V = mkV "behagar" ; -- comment=6
lin habit_N = mkN "vana" ; -- SaldoWN
lin subsequently_Adv = mkAdv "därefter" ; -- status=guess
lin round_N = mkN "runda" ; -- status=guess
lin purchase_N = mkN "tag" neutrum; -- comment=10
lin sort_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin sort_V = mkV "sorterar" ; -- comment=2
lin outside_A = mkA "utvändig" ; -- comment=3
lin gradually_Adv = mkAdv "gradvis" ; -- status=guess
lin expansion_N = mkN "expansion" "expansioner" ; -- SaldoWN
lin competitive_A = mkA "tävlingsmässig" | mkA "konkurrenskraftig" ; -- SaldoWN
lin cooperation_N = mkN "samarbete" | mkN "kooperation" "kooperationer" ; -- SaldoWN -- comment=2
lin acceptable_A = mkA "acceptabel" | mkA "välkommen" "välkommet" "välkomna" "välkomna" "välkomnare" "välkomnast" "välkomnaste" ; -- SaldoWN -- comment=4
lin angle_N = mkN "vinkel" ; -- SaldoWN
lin cook_V2 = dirV2 (partV (mkV "kokar")"över"); -- comment=2
lin cook_V = mkV "kokar" ; -- comment=10
lin net_A = mkA "netto" ;
lin sensitive_A = mkA "känslig" ; -- SaldoWN
lin ratio_N = mkN "förhållande" ; -- SaldoWN
lin kiss_V2 = mkV2 (mkV "kyssas") | mkV2 (mkV "pussas"); -- status=guess, src=wikt status=guess, src=wikt
lin amount_V = mkV "mänger" ; -- comment=2
lin sleep_N = mkN "sömn" ; -- SaldoWN
lin finance_V2 = mkV2 (mkV "finansierar"); -- status=guess, src=wikt
lin essentially_Adv = variants{} ; -- 
lin fund_V2 = mkV2 (mkV "finansierar"); -- status=guess, src=wikt
lin preserve_V2 = mkV2 (mkV "bevarar"); -- status=guess, src=wikt
lin wedding_N = mkN "bröllop" neutrum | mkN "bröllop" neutrum ; -- SaldoWN -- comment=2
lin personality_N = mkN "personlighet" ; -- SaldoWN = mkN "personlighet" "personligheter" ;
lin bishop_N = mkN "biskop" ; -- SaldoWN
lin dependent_A = mkA "tillvand" | mkA "beroende" ; -- SaldoWN -- comment=4
lin landscape_N = mkN "landskap" neutrum ; -- SaldoWN -- comment=3
lin pure_A = mkA "ren" | mkA "äkta" ; -- SaldoWN -- comment=6
lin mirror_N = mkN "spegel" ; -- SaldoWN
lin lock_V2 = dirV2 (partV (mkV "låser")"in"); -- comment=3
lin lock_V = mkV "omfamnar" ; -- comment=5
lin symptom_N = mkN "symtom" neutrum | mkN "symptom" neutrum ; -- SaldoWN
lin promotion_N = mkN "reklam" "reklamer" | mkN "marknadsföring" ; -- SaldoWN -- comment=7
lin global_A = mkA "hel" ; -- comment=2
lin aside_Adv = mkAdv "avsides" ; -- comment=3
lin tendency_N = mkN "tendens" "tendenser" ; -- SaldoWN
lin conservation_N = mkN "bevarande" ; -- SaldoWN
lin reply_N = mkN "svar" neutrum; -- comment=3
lin estimate_N = mkN "värdering" | mkN "uppskattning" ; -- SaldoWN -- comment=10
lin qualification_N = mkN "förbehåll" neutrum | mkN "merit" "meriter" ; -- SaldoWN -- comment=11
lin pack_V2 = dirV2 (partV (mkV "packar")"ur"); -- comment=5
lin pack_V = mkV "tätar" ; -- comment=11
lin governor_N = mkN "guvernör" "guvernörer" ; -- SaldoWN
lin expected_A = variants{} ; -- 
lin invest_V2 = mkV2 (mkV "investerar"); -- status=guess, src=wikt
lin invest_V = mkV "investerar" ; -- comment=2
lin cycle_N = mkN "cykel" ; -- SaldoWN = mkN "cykel" ;
lin alright_A = variants{} ; -- 
lin philosophy_N = mkN "filosofi" "filosofin" "filosofier" "filosofierna" ; -- status=guess
lin gallery_N = mkN "galleri" "gallerit" "gallerier" "gallerierna" | mkN "publik" "publiker" ; -- SaldoWN -- comment=7
lin sad_A = mkA "ledsen" "ledset" ; -- SaldoWN
lin intervention_N = mkN "ingripande" ; -- SaldoWN
lin emotional_A = mkA "känslomässig" | mkA "känslosam" "känslosamt" "känslosamma" "känslosamma" "känslosammare" "känslosammast" "känslosammaste" ; -- SaldoWN -- comment=5
lin advertising_N = mkN "reklam" "reklamer" ; -- SaldoWN
lin regard_N = mkN "blick" | mkN "hänsyn" "hänsynen" "hänsyn" "hänsynen" ; -- SaldoWN -- comment=7
lin dance_V2 = mkV2 (mkV "dansar"); -- status=guess, src=wikt
lin dance_V = mkV "gungar" ; -- comment=4
lin cigarette_N = mkN "cigarett" "cigaretter" ; -- SaldoWN
lin predict_VS = mkVS (mkV "förutsäga"); -- status=guess, src=wikt
lin predict_V2 = mkV2 (mkV "förutsäga"); -- status=guess, src=wikt
lin adequate_A = mkA "fullvärdig" | mkA "tillräcklig" ; -- SaldoWN -- comment=7
lin variable_N = mkN "variabel" "variabeln" "variabler" "variablerna" ; -- SaldoWN
lin net_N = mkN "nät" neutrum | mkN "nät" neutrum ; -- SaldoWN -- comment=5
lin retire_V2 = dirV2 (partV (mkV "vilar")"ut"); -- status=guess
lin retire_V = mkV "retirerar" ; -- comment=6
lin sugar_N = mkN "socker" neutrum | mkN "socker" neutrum ; -- SaldoWN -- comment=2
lin pale_A = mkA "blek" ; -- comment=7
lin frequency_N = mkN "frekvens" "frekvenser" | mkN "täthet" ; -- SaldoWN -- comment=4
lin guy_N = mkN "fågelskrämma" ; -- comment=10
lin feature_V2 = dirV2 (partV (mkV "visar")"in"); -- status=guess
lin furniture_N = mkN "möblemang" neutrum | mkN "möbel" "möbeln" "möbler" "möblerna" ; -- SaldoWN -- comment=3
lin administrative_A = mkA "administrativ" ; -- SaldoWN
lin wooden_A = mkA "träig" ; -- comment=7
lin input_N = variants{} ; -- 
lin phenomenon_N = mkN "fenomen" neutrum | mkN "fenomen" neutrum ; -- SaldoWN -- comment=2
lin surprising_A = mkA "överraskande" ; -- SaldoWN
lin jacket_N = mkN "jacka" ; -- SaldoWN
lin actor_N = mkN "aktör" "aktörer" ; -- comment=3
lin actor_2_N = mkN "aktör" "aktörer" ; -- status=guess
lin actor_1_N = mkN "skådespelare" "skådespelare" ; -- status=guess
lin kick_V2 = dirV2 (partV (mkV "sparkar")"ut"); -- comment=2
lin kick_V = mkV "protesterar" ; -- comment=10
lin producer_N = mkN "producent" "producenter" ; -- status=guess
lin hearing_N = mkN "utfrågning" ; -- comment=6
lin chip_N = mkN "flisa" ; -- SaldoWN
lin equation_N = mkN "ekvation" "ekvationer" ; -- SaldoWN
lin certificate_N = mkN "attest" "attester" | mkN "bevis" neutrum ; -- SaldoWN -- comment=8
lin hello_Interj = mkInterj "hej" | mkInterj "hallå" ; -- status=guess
lin remarkable_A = mkA "anmärkningsvärd" "anmärkningsvärt" ; -- comment=8
lin alliance_N = mkN "förbund" neutrum; -- comment=5
lin smoke_V2 = mkV2 (mkV "ryker"); -- status=guess, src=wikt
lin smoke_V = mkV "röker" ; -- comment=4
lin awareness_N = mkN "kännedom" ; -- comment=5
lin throat_N = mkN "strupe" utrum | mkN "strupe" utrum ; -- SaldoWN -- comment=2
lin discovery_N = mkN "upptäckt" "upptäckter" ; -- SaldoWN
lin festival_N = mkN "festival" "festivaler" | mkN "högtid" "högtider" ; -- SaldoWN -- comment=3
lin dance_N = mkN "dans" "danser" ; -- status=guess
lin promise_N = mkN "löfte" ; -- SaldoWN
lin rose_N = mkN "ros" neutrum | mkN "ros" "rosor" ; -- SaldoWN = mkN "ros" "rosor" ;
lin principal_A = mkA "kapital" ; -- comment=2
lin brilliant_A = mkA "glänsande" ; -- comment=9
lin proposed_A = variants{} ; -- 
lin coach_N = mkN "tränare" utrum | mkN "vagn" ; -- SaldoWN -- comment=13
lin coach_3_N = mkN "buss" ; -- status=guess
lin coach_2_N = mkN "vagn" ; -- status=guess
lin coach_1_N = mkN "tränare" utrum ; -- status=guess
lin absolute_A = mkA "absolut" "absolut" ; -- SaldoWN
lin drama_N = mkN "drama" "dramat" "draman" "dramana" | mkN "dramatik" ; -- SaldoWN -- comment=3
lin recording_N = mkN "inspelning" ; -- SaldoWN
lin precisely_Adv = variants{} ; -- 
lin bath_N = mkN "badrum" "badrummet" "badrum" "badrummen" | mkN "bad" neutrum ; -- SaldoWN -- comment=7
lin celebrate_V2 = variants{} ; -- 
lin substance_N = mkN "substans" "substanser" ; -- comment=7
lin swing_V2 = mkV2 (mkV "gungar") | mkV2 (mkV "svingar"); -- status=guess, src=wikt status=guess, src=wikt
lin swing_V = mkV "svänger" ; -- comment=8
lin for_Adv = variants{}; -- S.for_Prep;
lin rapid_A = mkA "snabb" ; -- comment=3
lin rough_A = mkA "skrovlig" | mkA "ungefärlig" ; -- SaldoWN -- comment=22
lin investor_N = mkN "aktieägare" utrum; -- comment=2
lin fire_V2 = dirV2 (partV (mkV "torkar")"ut"); -- comment=6
lin fire_V = mkV "steker" ; -- comment=22
lin rank_N = mkN "status" | mkN "stinkande" ; -- SaldoWN -- comment=13
lin compete_V = mkV "konkurrerar" ; -- comment=3
lin sweet_A = mkA "söt" ; -- SaldoWN
lin decline_VV = mkVV (mkV (mkV "avstå" "avstod" "avstått") "från");
lin decline_V2 = dirV2 (partV (mkV "lutar")"av"); -- status=guess
lin decline_V = mkV "lutar" ; -- comment=14
lin rent_N = mkN "hyra" | mkN "spricka" ; -- SaldoWN -- comment=7
lin dealer_N = mkN "återförsäljare" utrum | mkN "handlande" ; -- SaldoWN -- comment=6
lin bend_V2 = mkV2 "böja" "böjde" "böjt" | dirV2 (partV (mkV "riktar")"till") ; -- SaldoWN -- comment=4
lin bend_V = mkV "böja" "böjde" "böjt" | mkV "vänder" ; -- SaldoWN -- comment=18
lin solid_A = mkA "solid" | mkA "obruten" "obrutet" ; -- SaldoWN -- comment=18
lin cloud_N = L.cloud_N ;
lin across_Adv = mkAdv "över" ; -- comment=5
lin level_A = mkA "plan" ; -- comment=6
lin enquiry_N = mkN "förhör" neutrum; -- comment=6
lin fight_N = mkN "strid" "strider" | mkN "kamp" ; -- status=guess
lin abuse_N = mkN "skällsord" neutrum ; -- SaldoWN -- comment=7
lin golf_N = mkN "golf" "golfer" ; -- status=guess
lin guitar_N = mkN "gitarr" "gitarrer" ; -- status=guess
lin electronic_A = mkA "elektronisk" ; -- SaldoWN
lin cottage_N = mkN "stuga" ; -- SaldoWN
lin scope_N = mkN "räckvidd" ; -- status=guess
lin pause_VS = mkVS (mkV "pausar"); -- status=guess, src=wikt
lin pause_V2V = mkV2V (mkV "pausar"); -- status=guess, src=wikt
lin pause_V = mkV "uppehålla" "uppehöll" "uppehållit" ; -- comment=4
lin mixture_N = mkN "blandning" | mkN "inblandning" ; -- SaldoWN -- comment=10
lin emotion_N = mkN "affekt" "affekter" | mkN "sinnesrörelse" "sinnesrörelser" ; -- SaldoWN -- comment=4
lin comprehensive_A = mkA "heltäckande" | mkA "omfattande" ; -- SaldoWN -- comment=6
lin shirt_N = L.shirt_N ;
lin allowance_N = mkN "anslag" neutrum | mkN "underhåll" neutrum ; -- SaldoWN -- comment=17
lin retirement_N = mkN "avgång" | mkN "tillbakadragenhet" ; -- SaldoWN -- comment=3
lin breach_N = mkN "bräsch" "bräscher" ; -- comment=8
lin infection_N = mkN "smitta" ; -- SaldoWN
lin resist_VV = mkVV (mkV "motstå" "motstod" "mostsått") | mkVV (mkV (mkV "stå" "stod" "stått") "emot") ; -- status=guess
lin resist_V2 = mkV2 (mkV "motstå" "motstod" "mostsått") | mkV2 (mkV (mkV "stå" "stod" "stått") "emot") ; -- status=guess
lin resist_V = mkV "motstå" "motstod" "motstått" ; -- comment=3
lin qualify_V2 = variants{}; -- mkV "modifierar" ; -- comment=11
lin qualify_V = mkV "modifierar" ; -- comment=11
lin paragraph_N = mkN "paragraf" "paragrafer" | mkN "tidningsnotis" "tidningsnotiser" ; -- SaldoWN -- comment=3
lin sick_A = mkA "sjuk" ; -- SaldoWN
lin near_A = L.near_A;
lin researcherMasc_N = variants{} ; -- 
lin consent_N = mkN "bifall" neutrum; -- comment=4
lin written_A = variants{} ; -- 
lin literary_A = mkA "litterär" ; -- SaldoWN
lin ill_A = mkA "sjuk" ; -- comment=5
lin wet_A = L.wet_A ;
lin lake_N = L.lake_N ;
lin entrance_N = mkN "inträde" ; -- comment=10
lin peak_N = mkN "topp" | mkN "spets" ; -- SaldoWN -- comment=7
lin successfully_Adv = variants{} ; -- 
lin sand_N = L.sand_N ;
lin breathe_V2 = mkV2 (mkV (mkV "andas") "in"); -- status=guess, src=wikt
lin breathe_V = L.breathe_V;
lin cold_N = mkN "kyla" ; -- SaldoWN
lin cheek_N = mkN "kind" "kinder" ; -- SaldoWN
lin platform_N = mkN "plattform" ; -- SaldoWN
lin interaction_N = mkN "interaktion" "interaktioner" ; -- SaldoWN
lin watch_N = mkN "utkik" | mkN "valla" ; -- SaldoWN -- comment=15
lin borrow_VV = variants{}; -- mkV "lånar" ; -- comment=2
lin borrow_V2 = dirV2 (partV (mkV "lånar")"ut"); -- status=guess
lin borrow_V = mkV "lånar" ; -- comment=2
lin birthday_N = mkN "födelsedag" ; -- SaldoWN
lin knife_N = mkN "kniv" ; -- SaldoWN
lin extreme_A = mkA "utomordentlig" ; -- comment=3
lin core_N = mkN "kärna" | mkN "kärnhus" neutrum ; -- SaldoWN -- comment=4
lin peasantMasc_N = variants{} ; -- 
lin armed_A = variants{} ; -- 
lin permission_N = mkN "tillåtelse" utrum | mkN "tillstånd" neutrum ; -- SaldoWN -- comment=7
lin supreme_A = mkA "ojämförlig" ; -- comment=6
lin overcome_V2 = mkV2 (mkV "övervinna" "övervann" "övervunnit") | mkV2 (mkV "överkomma" "överkom" "överkommit") ; -- status=guess
lin overcome_V = mkV "övervinna" "övervann" "övervunnit" ; -- comment=7
lin greatly_Adv = variants{} ; -- 
lin visual_A = mkA "visuell" ; -- SaldoWN
lin lad_N = mkN "pojke" utrum; -- comment=3
lin genuine_A = mkA "autentisk" | mkA "äkta" ; -- SaldoWN -- comment=11
lin personnel_N = mkN "personalavdelning" ; -- comment=3
lin judgement_N = mkN "bedömning" ; -- comment=8
lin exciting_A = mkA "spännande" ; -- SaldoWN
lin stream_N = mkN "vattendrag" neutrum | mkN "ström" "strömmen" "strömmar" "strömmarna" ; -- SaldoWN -- comment=4
lin perception_N = mkN "perception" "perceptioner" | mkN "uppfattningsförmåga" ; -- SaldoWN -- comment=8
lin guarantee_VS = mkVS (mkV "garanterar"); -- status=guess, src=wikt
lin guarantee_V2 = mkV2 (mkV "garanterar"); -- status=guess, src=wikt
lin guarantee_V = mkV "garanterar" ; -- comment=8
lin disaster_N = mkN "katastrof" "katastrofer" ; -- SaldoWN
lin darkness_N = mkN "mörker" neutrum; -- status=guess
lin bid_N = mkN "hälsa" ; -- comment=6
lin sake_N = variants{} ; -- 
lin sake_2_N = variants{} ; -- 
lin sake_1_N = variants{} ; -- 
lin organize_V2V = mkV2V (mkV "organiserar"); -- status=guess, src=wikt
lin organize_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin tourist_N = mkN "turist" "turister" ; -- SaldoWN
lin policeman_N = L.policeman_N;
lin castle_N = mkN "slott" neutrum | mkN "borg" ; -- SaldoWN -- comment=6
lin figure_VS = variants{}; -- mkV "tänker" ; -- comment=2
lin figure_V = mkV "tänker" ; -- comment=2
lin race_VV = variants{}; -- mkV "tävla" ;
lin race_V2V = variants{}; -- mkV "tävla" ;
lin race_V2 = variants{}; -- mkV "tävla" ;
lin race_V = mkV "tävla" ; -- status=guess
lin demonstration_N = mkN "demonstration" "demonstrationer" | mkN "uppvisande" ; -- SaldoWN -- comment=7
lin anger_N = mkN "ilska" ; -- SaldoWN
lin briefly_Adv = variants{} ; -- 
lin presumably_Adv = variants{} ; -- 
lin clock_N = mkN "klocka" ; -- SaldoWN
lin hero_N = mkN "hjälte" utrum ; -- status=guess
lin expose_V2 = dirV2 (partV (mkV "visar")"in"); -- status=guess
lin expose_V = mkV "yppar" ; -- comment=14
lin custom_N = mkN "bruk" neutrum; -- comment=13
lin maximum_A = mkA "maximal" ; -- SaldoWN
lin wish_N = mkN "önskning" ; -- status=guess
lin earning_N = variants{} ; -- 
lin priest_N = L.priest_N;
lin resign_V2 = mkV2 "avgå" "avgår" "avgå" "avgick" "avgått" "avgången" ; -- status=guess
lin resign_V = mkV "avgå" "avgår" "avgå" "avgick" "avgått" "avgången" | mkV "resignerar" ; -- SaldoWN -- comment=8
lin store_V2 = mkV2 (mkV "lagrar") | mkV2 (mkV "sparar"); -- status=guess, src=wikt status=guess, src=wikt
lin widespread_A = mkA "vidsträckt" "vidsträckt" ; -- comment=2
lin comprise_V2 = dirV2 (partV (mkV "gå" "går" "gå" "gick" "gått" "gången") "ut"); -- comment=15
lin chamber_N = mkN "kammare" "kammaren" "kamrar" "kamrarna" ; -- comment=4
lin acquisition_N = mkN "förvärv" neutrum | mkN "förvärvande" ; -- SaldoWN -- comment=2
lin involved_A = variants{} ; -- 
lin confident_A = mkA "trosviss" | mkA "tillitsfull" ; -- SaldoWN -- comment=4
lin circuit_N = mkN "varv" neutrum; -- comment=11
lin radical_A = mkA "radikal" ; -- SaldoWN
lin detect_V2 = dirV2 (partV (mkV "spårar")"ur"); -- status=guess
lin stupid_A = L.stupid_A ;
lin grand_A = mkA "grandios" ; -- comment=10
lin consumption_N = mkN "konsumtion" "konsumtioner" ; -- SaldoWN
lin hold_N = mkN "arrest" "arrester" | mkN "äga" ; -- SaldoWN -- comment=12
lin zone_N = mkN "zon" "zoner" ; -- SaldoWN
lin mean_A = mkA "elak" ; -- status=guess
lin altogether_Adv = mkAdv "alldeles" ; -- status=guess
lin rush_VV = variants{}; -- mkV "störtar" ; -- comment=13
lin rush_V2 = dirV2 (partV (mkV "störtar")"in"); -- comment=3
lin rush_V = mkV "störtar" ; -- comment=13
lin numerous_A = mkA "talrik" ; -- status=guess
lin sink_V2 = mkV2 (mkV "sänka"); -- status=guess, src=wikt
lin sink_V = mkV "sänker" ; -- comment=13
lin everywhere_Adv = S.everywhere_Adv;
lin classical_A = mkA "klassisk" ; -- status=guess
lin respectively_Adv = variants{} ; -- 
lin distinct_A = mkA "distinkt" "distinkt" | mkA "tydlig" ; -- SaldoWN -- comment=11
lin mad_A = mkA "vansinnig" ; -- comment=12
lin honour_N = mkN "ära" ; -- SaldoWN
lin statistics_N = mkN "statistik" "statistiker" ; -- SaldoWN
lin false_A = mkA "falsk" ; -- SaldoWN
lin square_N = mkN "torg" neutrum | mkN "vinkelhake" utrum ; -- SaldoWN -- comment=9
lin differ_V = mkV "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" | mkV "avvika" "avvek" "avvikit" ; -- SaldoWN
lin disk_N = mkN "skiva" | mkN "disk" ; -- SaldoWN -- comment=6
lin truly_Adv = variants{} ; -- 
lin survival_N = mkN "överlevnad" "överlevnader" ; -- SaldoWN
lin proud_A = mkA "stolt" "stolt" ; -- SaldoWN
lin tower_N = mkN "torn" ; -- SaldoWN = mkN "torn" neutrum ;
lin deposit_N = mkN "insättning" | mkN "lager" ; -- SaldoWN -- comment=14
lin pace_N = mkN "tempo" "tempot" "tempon" "tempona" ; -- SaldoWN
lin compensation_N = mkN "kompensation" "kompensationer" | mkN "utjämning" ; -- SaldoWN -- comment=5
lin adviserMasc_N = variants{} ; -- 
lin consultant_N = mkN "konsult" "konsulter" ; -- SaldoWN
lin drag_V2 = dirV2 (partV (mkV "släpar")"ut"); -- comment=9
lin drag_V = mkV "släpar" ; -- comment=4
lin advanced_A = variants{} ; -- 
lin landlord_N = mkN "hyresvärd" | mkN "värdshusvärd" ; -- SaldoWN -- comment=5
lin whenever_Adv = mkAdv "närsom" | mkAdv "när som helst" | mkAdv "närhelst" ; -- status=guess status=guess status=guess
lin delay_N = mkN "fördröjning" | mkN "dröjsmål" neutrum ; -- SaldoWN -- comment=4
lin green_N = mkN "grönska" | mkN "bana" ; -- SaldoWN -- comment=2
lin car_V = variants{} ; -- 
lin holder_N = mkN "behållare" utrum; -- comment=3
lin secret_A = mkA "hemlig" ; -- status=guess
lin edition_N = mkN "utgåva" | mkN "upplaga" ; -- status=guess
lin occupation_N = mkN "ockupation" "ockupationer" | mkN "besittningstagande" ; -- SaldoWN -- comment=12
lin agricultural_A = mkA "agrikulturell" ; -- SaldoWN
lin intelligence_N = variants{} ; -- 
lin intelligence_2_N = mkN "underrättelse" "underrättelser" ; -- status=guess
lin intelligence_1_N = mkN "förstånd" neutrum; -- status=guess
lin empire_N = mkN "imperium" "imperiet" "imperier" "imperierna" | mkN "kejsardöme" ; -- status=guess
lin definitely_Adv = variants{} ; -- 
lin negotiate_VV = mkVV (mkV "förhandla") | mkVV (mkV "underhandlar"); -- status=guess, src=wikt status=guess, src=wikt
lin negotiate_V2 = mkV2 (mkV "förhandla") | mkV2 (mkV "underhandlar"); -- status=guess, src=wikt status=guess, src=wikt
lin negotiate_V = mkV "sälja" "sålde" "sålt" ; -- comment=6
lin host_N = mkN "värd" ; -- status=guess
lin relative_N = mkN "släkting" ; -- comment=3
lin mass_A = variants{} ; -- 
lin helpful_A = mkA "hjälpsam" "hjälpsamt" "hjälpsamma" "hjälpsamma" "hjälpsammare" "hjälpsammast" "hjälpsammaste" ; -- SaldoWN
lin fellow_N = mkN "pojkvän" "pojkvännen" "pojkvänner" "pojkvännerna" ; -- comment=11
lin sweep_V2 = dirV2 (partV (mkV "sopar")"ut"); -- comment=3
lin sweep_V = mkV "susar" ; -- comment=9
lin poet_N = mkN "poet" "poeter" ; -- status=guess
lin journalist_N = mkN "journalist" "journalister" ; -- comment=2
lin defeat_N = mkN "frustration" "frustrationer" | mkN "omintetgörande" ; -- SaldoWN -- comment=4
lin unlike_Prep = mkPrep "olikt" ; -- status=guess
lin primarily_Adv = mkAdv "primärt" ; -- status=guess
lin tight_A = mkA "snäv" | mkA "tät" ; -- SaldoWN -- comment=12
lin indication_N = mkN "indikation" "indikationer" | mkN "tecken" "tecknet" "tecken" "tecknen" ; -- SaldoWN -- comment=7
lin dry_V2 = dirV2 (partV (mkV "torkar")"ut"); -- comment=3
lin dry_V = mkV "torkar" ; -- comment=3
lin cricket_N = mkN "syrsa" | mkN "kricket" ; -- SaldoWN -- comment=3
lin whisper_V2 = mkV2 (mkV "viskar"); -- status=guess, src=wikt
lin whisper_V = mkV "viskar" ; -- comment=6
lin routine_N = mkN "rutin" "rutiner" ; -- SaldoWN
lin print_N = mkN "tryck" neutrum | mkN "tryck" neutrum ; -- SaldoWN -- comment=3
lin anxiety_N = mkN "ångest" | mkN "iver" ; -- SaldoWN -- comment=7
lin witness_N = mkN "åskådare" utrum | mkN "vittne" ; -- SaldoWN
lin concerning_Prep = mkPrep "gällande" ; -- status=guess
lin mill_N = mkN "kvarn" | mkN "pepparkvarn" ; -- SaldoWN -- comment=12
lin gentle_A = mkA "mjuk" ; -- comment=7
lin curtain_N = mkN "gardin" "gardiner" | mkN "slöja" ; -- SaldoWN -- comment=5
lin mission_N = mkN "uppdrag" "uppdrag" | mkN "mission" "missioner" ; -- status=guess
lin supplier_N = mkN "leverantör" "leverantörer" ; -- SaldoWN
lin basically_Adv = mkAdv "egentligen" ; -- status=guess
lin assure_V2S = variants{}; -- mkV2 (mkV "försäkra");
lin assure_V2 = mkV2 (mkV "försäkra"); -- status=guess
lin poverty_N = mkN "fattigdom" ; -- status=guess
lin snow_N = L.snow_N ;
lin prayer_N = mkN "bön" "böner" ; -- SaldoWN
lin pipe_N = mkN "rör" neutrum | mkN "rör" neutrum ; -- SaldoWN -- comment=4
lin deserve_VV = mkVV (mkV "förtjäna"); -- status=guess, src=wikt
lin deserve_V2 = dirV2 (partV (mkV "tjänar")"ut"); -- comment=2
lin deserve_V = mkV "förtjänar" ; -- comment=2
lin shift_N = mkN "skifte" ; -- status=guess
lin split_V2 = L.split_V2;
lin split_V = mkV "spricka" "sprack" "spruckit" ; -- comment=12
lin near_Adv = mkAdv "nästan" ; -- comment=3
lin consistent_A = mkA "förenlig" | mkA "konsekvent" "konsekvent" ; -- SaldoWN -- comment=6
lin carpet_N = L.carpet_N ;
lin ownership_N = mkN "ägande" ; -- SaldoWN
lin joke_N = mkN "skämt" neutrum ; -- SaldoWN -- comment=6
lin fewer_Det = variants{} ; -- 
lin workshop_N = mkN "verkstad" "verkstäder" ; -- SaldoWN
lin salt_N = L.salt_N ;
lin aged_Prep = mkPrep "i åldern" ; ---- prep ??
lin symbol_N = mkN "symbol" "symboler" ; -- SaldoWN
lin slide_V2 = mkV2 "glida" "gled" "glidit" | mkV2 (mkV "glidtackla") ; -- SaldoWN -- status=guess, src=wikt
lin slide_V = mkV "glida" "gled" "glidit" | mkV "sticka" "stack" "stuckit" ; -- SaldoWN -- comment=10
lin cross_N = mkN "korsning" | mkN "mot" neutrum ; -- SaldoWN -- comment=15
lin anxious_A = mkA "ängslig" ; -- comment=8
lin tale_N = mkN "lögn" "lögner" ; -- comment=4
lin preference_N = mkN "förkärlek" | mkN "preferens" "preferenser" ; -- SaldoWN -- comment=3
lin inevitably_Adv = variants{} ; -- 
lin mere_A = mkA "bar" ; -- comment=4
lin behave_V = mkV "uppträda" "uppträdde" "uppträtt" | mkV "handlar" ; -- SaldoWN -- comment=3
lin gain_N = mkN "ökning" ; -- comment=2
lin nervous_A = mkA "nervös" ; -- SaldoWN
lin guide_V2 = variants{} ; -- 
lin remark_N = mkN "anmärkning" ; -- SaldoWN
lin pleased_A = mkA "nöjd" "nöjt" ; -- status=guess
lin province_N = mkN "provins" "provinser" ; -- status=guess
lin steel_N = L.steel_N ;
lin practise_V2 = variants{}; -- mkV "övar" ; -- comment=8
lin practise_V = mkV "övar" ; -- comment=8
lin flow_V = L.flow_V;
lin holy_A = mkA "helig" ; -- SaldoWN
lin dose_N = mkN "dos" "doser" ; -- SaldoWN
lin alcohol_N = mkN "alkohol" "alkoholer" ; -- SaldoWN
lin guidance_N = mkN "ledning" ; -- comment=4
lin constantly_Adv = variants{} ; -- 
lin climate_N = mkN "klimat" neutrum ; -- SaldoWN -- comment=2
lin enhance_V2 = mkV2 "förhöja" "förhöjde" "förhöjt" | mkV2 (mkV "förbättra") ; -- SaldoWN -- status=guess, src=wikt
lin reasonably_Adv = variants{} ; -- 
lin waste_V2 = mkV2 "slösa" ; -- status=guess
lin waste_V = mkV "slösa" ; -- status=guess
lin smooth_A = L.smooth_A ;
lin dominant_A = mkA "dominant" "dominant" ; -- SaldoWN
lin conscious_A = mkA "medveten" "medvetet" ; -- SaldoWN
lin formula_N = mkN "formel" "formeln" "formler" "formlerna" ; -- SaldoWN
lin tail_N = L.tail_N ;
lin ha_Interj = variants{} ; -- 
lin electric_A = mkA "elektrisk" ; -- status=guess
lin sheep_N = L.sheep_N ;
lin medicine_N = mkN "medicin" "mediciner" ; -- SaldoWN
lin strategic_A = mkA "strategisk" ; -- SaldoWN
lin disabled_A = variants{} ; -- 
lin smell_N = mkN "lukt" "lukter" | mkN "luktsinne" ; -- SaldoWN -- comment=7
lin operator_N = mkN "operatör" "operatörer" ; -- comment=6
lin mount_V2 = dirV2 (partV (mkV "växa" "växer" "växa" "växte" "vuxit" "vuxen")"ur"); -- comment=7
lin mount_V = mkV "stiga" "steg" "stigit" ; -- comment=10
lin advance_V2 = mkV2 "fortskrida" "fortskred" "fortskridit" | mkV2 (mkV "förskottera") ; -- SaldoWN -- status=guess, src=wikt
lin advance_V = mkV "fortskrida" "fortskred" "fortskridit" | mkV "framställer" ; -- SaldoWN -- comment=18
lin remote_A = mkA "otillgänglig" ; -- comment=5
lin measurement_N = mkN "mätning" ; -- comment=3
lin favour_VS = variants{} ; -- 
lin favour_V2 = variants{} ; -- 
lin favour_V = variants{} ; -- 
lin neither_Det = M.mkDet "ingendera" | M.mkDet "ingen av" ; -- status=guess status=guess
lin architecture_N = mkN "arkitektur" "arkitekturer" | mkN "byggnad" "byggnader" ; -- SaldoWN -- comment=6
lin worth_N = mkN "värde" ; -- SaldoWN
lin tie_N = mkN "slips" ; -- SaldoWN
lin barrier_N = mkN "hinder" neutrum | mkN "barriär" "barriärer" ; -- SaldoWN -- comment=9
lin practitioner_N = mkN "utövare" "utövare" ; -- status=guess
lin outstanding_A = mkA "innestående" ; -- comment=10
lin enthusiasm_N = mkN "entusiasm" ; -- SaldoWN
lin theoretical_A = mkA "teoretisk" ; -- status=guess
lin implementation_N = mkN "implementering" ; -- status=guess
lin worried_A = variants{} ; -- 
lin pitch_N = mkN "tonhöjd" "tonhöjder" | mkN "resa" ; -- SaldoWN -- comment=21
lin drop_N = mkN "stup" neutrum | mkN "sänka" ; -- SaldoWN -- comment=16
lin phone_V2 = mkV2 (mkV "ringar") | mkV2 (mkV "telefonerar"); -- status=guess, src=wikt status=guess, src=wikt
lin phone_V = mkV "telefonerar" ; -- comment=3
lin shape_VV = mkVV (mkV "formar"); -- status=guess, src=wikt
lin shape_V2 = dirV2 (partV (mkV "formar")"till"); -- status=guess
lin shape_V = mkV "skapar" ; -- comment=5
lin clinical_A = variants{} ; -- 
lin lane_N = mkN "fil" | mkN "stig" ; -- SaldoWN = mkN "fil" ; = mkN "fil" "filer" ; -- comment=8
lin apple_N = L.apple_N ;
lin catalogue_N = mkN "katalog" "kataloger" ; -- SaldoWN
lin tip_N = mkN "ände" utrum | mkN "ända" ; -- SaldoWN -- comment=16
lin publisher_N = mkN "utgivare" utrum | mkN "bokförläggare" utrum ; -- SaldoWN -- comment=3
lin opponentMasc_N = variants{} ; -- 
lin live_A = mkA "live" | mkA "levande" ; -- status=guess
lin burden_N = mkN "huvudtema" "huvudtemat" "huvudteman" "huvudtemana" ; -- comment=5
lin tackle_V2 = dirV2 (partV (mkV "tacklar")"av"); -- status=guess
lin tackle_V = mkV "klämmer" ; -- comment=3
lin historian_N = mkN "historiker" "historikern" "historiker" "historikerna" ; -- SaldoWN
lin bury_V2 = mkV2 (mkV "begraver") | mkV2 (mkV "gömma"); -- status=guess, src=wikt status=guess, src=wikt
lin bury_V = mkV "begraver" ; -- comment=4
lin stomach_N = mkN "mage" utrum | mkN "smälta" ; -- SaldoWN -- comment=7
lin percentage_N = mkN "procent" "procenten" "procent" "procenten" ; -- comment=4
lin evaluation_N = mkN "utvärdering" ; -- status=guess
lin outline_V2 = variants{} ; -- 
lin talent_N = mkN "talang" "talanger" ; -- comment=4
lin lend_V2 = dirV2 (partV (mkV "lånar")"ut"); -- status=guess
lin lend_V = mkV "utlånar" ; -- comment=2
lin silver_N = L.silver_N ;
lin pack_N = mkN "flock" neutrum | mkN "packis" ; -- SaldoWN = mkN "flock" ; -- comment=29
lin fun_N = mkN "skoj" neutrum | mkN "lekfullhet" "lekfullheter" ; -- SaldoWN -- comment=5
lin democrat_N = mkN "demokrat" "demokrater" ; -- SaldoWN
lin fortune_N = mkN "öde" ; -- SaldoWN
lin storage_N = mkN "lager" | mkN "förvar" neutrum ; -- SaldoWN = mkN "lager" ; = mkN "lager" neutrum ; -- comment=7
lin professional_N = mkN "fackman" "fackmannen" "fackmän" "fackmännen" | (mkN "proffs" neutrum) | (mkN "expert" "experter") ; -- SaldoWN -- status=guess status=guess
lin reserve_N = mkN "reserv" "reserver" | mkN "reservspelare" utrum ; -- SaldoWN -- comment=6
lin interval_N = mkN "intervall" neutrum; -- status=guess
lin dimension_N = mkN "dimension" "dimensioner" ; -- SaldoWN
lin honest_A = mkA "ärlig" ; -- SaldoWN
lin awful_A = mkA "hemsk" | mkA "gräslig" ; -- SaldoWN -- comment=9
lin manufacture_V2 = mkV2 (mkV "tillverkar"); -- status=guess, src=wikt
lin confusion_N = mkN "förväxling" | mkN "sammanblandning" ; -- SaldoWN -- comment=8
lin pink_A = mkA "rosa" ; -- comment=2
lin impressive_A = mkA "imponerande" ; -- SaldoWN
lin satisfaction_N = mkN "tillfredsställelse" utrum | mkN "belåtenhet" "belåtenheter" ; -- SaldoWN -- comment=2
lin visible_A = mkA "synlig" | mkA "tydlig" ; -- SaldoWN -- comment=5
lin vessel_N = mkN "fartyg" neutrum | mkN "fartyg" neutrum ; -- SaldoWN -- comment=6
lin stand_N = mkN "ståndpunkt" "ståndpunkter" | mkN "stånd" neutrum ; -- SaldoWN -- comment=10
lin curve_N = mkN "kurva" ; -- SaldoWN
lin pot_N = mkN "kruka" | mkN "potta" ; -- SaldoWN -- comment=24
lin replacement_N = mkN "ersättare" utrum | mkN "ersättning" ; -- SaldoWN -- comment=5
lin accurate_A = mkA "korrekt" "korrekt" | mkA "exakt" "exakt" ; -- SaldoWN -- comment=5
lin mortgage_N = mkN "belåning" ; -- SaldoWN
lin salary_N = mkN "lön" "löner" ; -- comment=3
lin impress_V2 = variants{}; -- mkV "imponerar" ;
lin impress_V = mkV "imponerar" ; -- status=guess
lin constitutional_A = mkA "konstitutionell" ; -- status=guess
lin emphasize_VS = mkVS (mkV "understryka" "underströk" "understrukit"); -- status=guess
lin emphasize_V2 = mkV2 (mkV "understryka" "underströk" "understrukit"); -- status=guess
lin developing_A = variants{} ; -- 
lin proof_N = mkN "bevis" neutrum | mkN "prov" neutrum ; -- SaldoWN -- comment=10
lin furthermore_Adv = mkAdv "dessutom" ; -- comment=2
lin dish_N = mkN "parabolantenn" "parabolantenner" | mkN "urholkning" ; -- SaldoWN -- comment=15
lin interview_V2 = variants{} ; -- 
lin considerably_Adv = variants{} ; -- 
lin distant_A = mkA "avlägsen" "avlägset" | compoundA (regA "reserverad") ; -- SaldoWN -- comment=9
lin lower_V2 = mkV2 (mkV "sänka"); -- status=guess
lin lower_V = mkV "nedsänker" ; -- comment=4
lin favouriteMasc_N = variants{} ; -- 
lin tear_V2 = dirV2 (partV (mkV "rusar")"ut"); -- comment=2
lin tear_V = mkV "splittrar" ; -- comment=9
lin fixed_A = variants{} ; -- 
lin by_Adv = mkAdv "av" ; -- comment=16
lin luck_N = mkN "lycka" ; -- comment=6
lin count_N = mkN "räkning" ; -- comment=4
lin precise_A = mkA "precis" | mkA "exakt" "exakt" ; -- SaldoWN
lin determination_N = mkN "bestämning" ; -- comment=7
lin bite_V2 = L.bite_V2 ;
lin bite_V = mkV "bita" "bet" "bitit" | mkV "be" "bad" "bett" ; -- SaldoWN -- comment=14
lin dear_Interj = variants{} ; -- 
lin consultation_N = mkN "samråd" neutrum | mkN "rådplägning" ; -- SaldoWN -- comment=7
lin range_V = mkV "kedjar" ; -- comment=6
lin residential_A = mkA "bostadsmässig" ; -- SaldoWN
lin conduct_N = mkN "uppträdande" ; -- comment=6
lin capture_V2 = dirV2 (partV (mkV "ta" "tar" "ta" "tog" "tagit" "tagen")"ut"); -- comment=4
lin ultimately_Adv = variants{} ; -- 
lin cheque_N = mkN "check" ; -- SaldoWN
lin economics_N = mkN "ekonomi" "ekonomier" | mkN "nationalekonomi" ; -- SaldoWN -- comment=2
lin sustain_V2 = variants{} ; -- 
lin secondly_Adv = variants{} ; -- 
lin silly_A = mkA "dum" "dumt" "dumma" "dumma" "dummare" "dummast" "dummaste" ; -- comment=8
lin merchant_N = mkN "köpman" "köpmannen" "köpmän" "köpmännen" ; -- SaldoWN
lin lecture_N = mkN "föredrag" neutrum | mkN "tillrättavisning" ; -- SaldoWN -- comment=4
lin musical_A = mkA "musikalisk" ; -- status=guess
lin leisure_N = mkN "fritid" ; -- SaldoWN
lin check_N = mkN "schack" neutrum | mkN "stopp" ; -- SaldoWN -- comment=27
lin cheese_N = L.cheese_N ;
lin lift_N = mkN "skjuts" | mkN "stigning" ; -- SaldoWN -- comment=11
lin participate_V2 = mkV2 (mkV "delta" "deltar" "delta" "deltog" "deltagit" "deltagen") (mkPrep "i") ; -- status=guess
lin participate_V = mkV "delta" "deltar" "delta" "deltog" "deltagit" "deltagen" ; -- SaldoWN
lin fabric_N = mkN "tyg" neutrum; -- comment=8
lin distribute_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- status=guess
lin lover_N = mkN "älskare" utrum | mkN "älskare" utrum ; -- SaldoWN -- comment=2
lin childhood_N = mkN "barndom" ; -- SaldoWN
lin cool_A = mkA "sval" | compoundA (regA "ointresserad") ; -- SaldoWN -- comment=18
lin ban_V2 = mkV2 (mkV "bannar"); -- status=guess, src=wikt
lin supposed_A = mkA "förment" "förment" ; -- status=guess
lin mouse_N = mkN "mus" ; -- SaldoWN = mkN "mus" "musen" "möss" "mössen" ;
lin strain_N = mkN "ätt" "ätter" ; -- comment=33
lin specialist_A = variants{} ; -- 
lin consult_V2 = variants{}; -- mkV "överlägga" "överlade" "överlagt" ; -- comment=6
lin consult_V = mkV "överlägga" "överlade" "överlagt" ; -- comment=6
lin minimum_A = mkA "minimal" ; -- SaldoWN
lin approximately_Adv = mkAdv "ungefär" ; -- status=guess
lin participant_N = mkN "deltagare" utrum | mkN "deltagare" utrum ; -- SaldoWN -- comment=2
lin monetary_A = mkA "monetär" ; -- status=guess
lin confuse_V2 = mkV2 (mkV "blandar"); -- status=guess, src=wikt
lin dare_VV = mkVV (mkV "riskerar"); -- status=guess, src=wikt
lin dare_V2 = mkV2 (mkV "riskerar"); -- status=guess, src=wikt
lin smoke_N = L.smoke_N ;
lin movie_N = mkN "film" "filmer" ; -- status=guess
lin seed_N = L.seed_N ;
lin cease_V2 = mkV2 (mkV "upphöra" "upphörde" "upphört") ; -- status=guess, src=wikt
lin cease_V = mkV "uppehålla" "uppehöll" "uppehållit" ; -- comment=5
lin open_Adv = variants{} ; -- 
lin journal_N = mkN "journal" "journaler" ; -- SaldoWN
lin shopping_N = mkN "shopping" | mkN "vara" ; -- SaldoWN -- comment=3
lin equivalent_N = mkN "motsvarighet" "motsvarigheter" ; -- comment=2
lin palace_N = mkN "palats" neutrum | mkN "slott" neutrum ; -- SaldoWN -- comment=3
lin exceed_V2 = variants{} ; -- 
lin isolated_A = variants{} ; -- 
lin poetry_N = mkN "poesi" "poesier" ; -- SaldoWN
lin perceive_VS = mkVS (mkV "begripa" "begrep" "begripit"); -- status=guess, src=wikt
lin perceive_V2V = mkV2V (mkV "begripa" "begrep" "begripit"); -- status=guess, src=wikt
lin perceive_V2 = dirV2 (partV (mkV "se" "såg" "sett")"ut"); -- comment=4
lin lack_V2 = mkV2 (mkV "saknar") | mkV2 (mkV "fattas"); -- status=guess, src=wikt status=guess, src=wikt
lin lack_V = mkV "saknar" ; -- comment=4
lin strengthen_V2 = variants{}; -- mkV "stärker" ; -- comment=4
lin snap_V2 = mkV2 "brista" "brast" "brustit" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=2
lin snap_V = mkV "brista" "brast" "brustit" | mkV "nafsar" ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=14
lin readily_Adv = variants{} ; -- 
lin spite_N = mkN "elakhet" "elakheter" | mkN "ondska" ; -- SaldoWN -- comment=4
lin conviction_N = mkN "övertygelse" "övertygelser" ; -- SaldoWN
lin corridor_N = mkN "korridor" "korridoren" "korridorer" "korridorerna" ; -- SaldoWN
lin behind_Adv = mkAdv "bakom" ; -- comment=8
lin ward_N = mkN "skyddsling" | mkN "förmynderskap" neutrum ; -- SaldoWN -- comment=6
lin profile_N = mkN "profil" "profiler" ; -- status=guess
lin fat_A = mkA "fet" | mkA "tjock" ; -- SaldoWN -- comment=8
lin comfort_N = mkN "tröst" ; -- SaldoWN = mkN "tröst" ;
lin bathroom_N = mkN "toalett" "toaletter" ; -- status=guess
lin shell_N = mkN "snäcka" | mkN "skala" ; -- SaldoWN -- comment=23
lin reward_N = mkN "belöning" ; -- SaldoWN
lin deliberately_Adv = variants{} ; -- 
lin automatically_Adv = mkAdv "automatiskt" | mkAdv "per automatik" ; -- status=guess status=guess
lin vegetable_N = mkN "grönsak" "grönsaker" | mkN "grönsak" ; -- SaldoWN -- status=guess
lin imagination_N = mkN "inbillning" ; -- SaldoWN
lin junior_A = mkA "junior" | compoundA (regA "underordnad") ; -- SaldoWN -- comment=3
lin unemployed_A = mkA "arbetslös" ; -- SaldoWN
lin mystery_N = mkN "mysterium" "mysteriet" "mysterier" "mysterierna" ; -- comment=3
lin pose_V2 = mkV2 (mkV "poserar"); -- status=guess, src=wikt
lin pose_V = mkV "ställer" ; -- comment=4
lin violent_A = mkA "våldsam" "våldsamt" "våldsamma" "våldsamma" "våldsammare" "våldsammast" "våldsammaste" ; -- SaldoWN
lin march_N = mkN "marsch" "marscher" | mkN "mars" ; -- SaldoWN
lin found_V2 = mkV2 "grunda" | mkV2 (mkV "grundlägga" "grundlade" "grundlagt") ; -- status=guess
lin dig_V2 = mkV2 (mkV "diggar"); -- status=guess, src=wikt
lin dig_V = L.dig_V;
lin dirty_A = L.dirty_A ;
lin straight_A = L.straight_A ;
lin psychological_A = mkA "psykologisk" ; -- status=guess
lin grab_V2 = mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV (mkV "ta") "tag i"); -- status=guess, src=wikt status=guess, src=wikt
lin grab_V = mkV "intresserar" ; -- comment=4
lin pleasant_A = mkA "angenäm" ; -- SaldoWN
lin surgery_N = mkN "kirurgi" | mkN "mottagningsrum" "mottagningsrummet" "mottagningsrum" "mottagningsrummen" ; -- SaldoWN -- comment=4
lin inevitable_A = mkA "ofrånkomlig" ; -- SaldoWN
lin transform_V2 = variants{} ; -- 
lin bell_N = mkN "ringklocka" | mkN "klocka" ; -- SaldoWN -- comment=4
lin announcement_N = mkN "bud" neutrum | mkN "tillkännagivande" ; -- SaldoWN -- comment=10
lin draft_N = mkN "värnplikt" | mkN "skiss" "skisser" ; -- SaldoWN -- comment=19
lin unity_N = mkN "integritet" "integriteter" | mkN "sammanhållning" ; -- SaldoWN -- comment=8
lin airport_N = mkN "flygplats" "flygplatser" ; -- SaldoWN
lin upset_V2 = mkV2 "uppröra" "upprörde" "upprört" ; -- SaldoWN
lin upset_V = mkV "uppröra" "upprörde" "upprört" | mkV "kullkastar" ; -- SaldoWN -- comment=7
lin pretend_VS = mkVS (mkV "låtsas"); -- status=guess, src=wikt
lin pretend_V2 = mkV2 (mkV "låtsas"); -- status=guess, src=wikt
lin pretend_V = mkV "påstå" "påstod" "påstådd" ; -- comment=8
lin plant_V2 = dirV2 (partV (mkV "planterar")"om"); -- status=guess
lin till_Prep = mkPrep "till" ; -- status=guess
lin known_A = variants{} ; -- 
lin admission_N = mkN "inträdesavgift" "inträdesavgifter" | mkN "intagning" ; -- SaldoWN -- comment=9
lin tissue_N = mkN "vävnad" "vävnader" | mkN "väv" ; -- SaldoWN -- comment=4
lin magistrate_N = variants{} ; -- 
lin joy_N = mkN "glädje" utrum ; -- SaldoWN -- comment=2
lin free_V2V = mkV2V (mkV "befriar") ; -- status=guess
lin free_V2 = mkV2 (mkV "frigöra" "frigjorde" "frigjort") | mkV2 (mkV "befriar") | mkV2 (mkV "frita" "fritar" "frita" "fritog" "fritagit" "fritagen") ; -- status=guess
lin pretty_A = mkA "snygg" ; -- comment=3
lin operating_N = variants{} ; -- 
lin headquarters_N = variants{} ; -- 
lin grateful_A = mkA "tacksam" "tacksamt" "tacksamma" "tacksamma" "tacksammare" "tacksammast" "tacksammaste" | mkA "välgörande" ; -- SaldoWN -- comment=3
lin classroom_N = mkN "klassrum" "klassrummet" "klassrum" "klassrummen" ; -- SaldoWN
lin turnover_N = mkN "omsättning" ; -- status=guess
lin project_VS = mkVS (mkV (mkV "sträcker") "ut"); -- status=guess, src=wikt
lin project_V2V = mkV2V (mkV (mkV "sträcker") "ut"); -- status=guess, src=wikt
lin project_V2 = mkV2 "projicera" | dirV2 (partV (mkV "riktar")"till"); -- comment=5
lin project_V = mkV "riktar" ; -- comment=7
lin shrug_V2 = mkV2 (mkV (mkV "rycka") "på axlarna"); -- status=guess, src=wikt
lin sensible_A = mkA "klok" ; -- comment=10
lin limitation_N = mkN "begränsning" | mkN "inskränkning" ; -- SaldoWN -- comment=5
lin specialist_N = mkN "fackman" "fackmannen" "fackmän" "fackmännen" | mkN "specialist" "specialister" ; -- SaldoWN
lin newly_Adv = variants{} ; -- 
lin tongue_N = L.tongue_N ;
lin refugee_N = mkN "flykting" ; -- SaldoWN
lin delay_V2 = mkV2 "fördröja" "fördröjde" "fördröjt" | mkV2 (mkV (mkV "skjuta") "upp") ; -- SaldoWN -- status=guess, src=wikt
lin delay_V = mkV "fördröja" "fördröjde" "fördröjt" ; -- SaldoWN
lin dream_V2 = mkV2 (mkV "drömma"); -- status=guess, src=wikt
lin dream_V = mkV "drömmer" ; -- status=guess
lin composition_N = mkN "uppläggning" ; -- comment=18
lin alongside_Prep = mkPrep "bredvid" ; -- status=guess
lin ceiling_N = L.ceiling_N ;
lin highlight_V2 = variants{} ; -- 
lin stick_N = L.stick_N ;
lin favourite_A = variants{} ; -- 
lin tap_V2 = dirV2 (partV (mkV "knackar")"av"); -- status=guess
lin tap_V = mkV "utnyttjar" ; -- comment=7
lin universe_N = mkN "universum" neutrum; -- comment=2
lin request_VS = mkV "be" "bad" "bett" | mkVS (mkV "anmodar") | mkVS (mkV "begär") ; -- status=guess
lin request_V2 = mkV2 "be" "bad" "bett" | mkV2 (mkV "begär") ; -- status=guess
lin label_N = mkN "etikett" "etiketter" ; -- status=guess
lin confine_V2 = mkV2 (mkV "begränsa") | mkV2 (mkV "inskränka"); -- status=guess, src=wikt status=guess, src=wikt
lin scream_VS = mkV "skrika" "skrek" "skrikit" | mkVS (mkV "skrika" "skrek" "skrikit") ; -- SaldoWN -- status=guess, src=wikt
lin scream_V2 = mkV2 "skrika" "skrek" "skrikit" | mkV2 (mkV "skrika" "skrek" "skrikit") ; -- SaldoWN -- status=guess, src=wikt
lin scream_V = mkV "skrika" "skrek" "skrikit" ; -- SaldoWN
lin rid_V2 = dirV2 (partV (mkV "rensar")"ut"); -- comment=2
lin acceptance_N = mkN "accepterande" | mkN "erkännande" ; -- SaldoWN -- comment=4
lin detective_N = mkN "detektiv" "detektiver" ; -- SaldoWN
lin sail_V = mkV "seglar" ; -- status=guess
lin adjust_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin adjust_V = mkV "reglerar" ; -- comment=11
lin designer_N = mkN "formgivare" utrum | mkN "ränksmidare" utrum ; -- SaldoWN -- comment=4
lin running_A = variants{} ; -- 
lin summit_N = mkN "toppmöte" ; -- SaldoWN
lin participation_N = mkN "deltagande" ; -- comment=7
lin weakness_N = mkN "svaghet" "svagheter" ; -- SaldoWN
lin block_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=8
lin socalled_A = variants{} ; -- 
lin adapt_V2 = variants{}; -- mkV "bearbetar" ; -- comment=8
lin adapt_V = mkV "bearbetar" ; -- comment=8
lin absorb_V2 = mkV2 (mkV "absorberar") | mkV2 (mkV "bestrida" "bestred" "bestritt") | mkV2 (mkV (mkV "påtaga") "sig"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin encounter_V2 = mkV2 (mkV (mkV "stöta") "på") | mkV2 (mkV "anträffa") | mkV2 (mkV "möta"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin defeat_V2 = dirV2 (partV (mkV "slå" "slog" "slagit")"ut"); -- comment=14
lin excitement_N = mkN "tumult" neutrum | mkN "upphetsning" ; -- SaldoWN -- comment=5
lin brick_N = mkN "tegel" neutrum | mkN "tegelsten" "tegelstenen" "tegelstenar" "tegelstenarna" ; -- SaldoWN -- comment=3
lin blind_A = mkA "blind" | mkA "dold" "dolt" ; -- SaldoWN -- comment=4
lin wire_N = mkN "ledning" | mkN "telegram" "telegrammet" "telegram" "telegrammen" ; -- SaldoWN -- comment=6
lin crop_N = mkN "skörd" | mkN "snagg" ; -- SaldoWN -- comment=7
lin square_A = mkA "fyrkantig" | mkA "vinkelrät" ; -- SaldoWN = mkA "fyrkantig" ; -- comment=24
lin transition_N = mkN "övergång" ; -- SaldoWN
lin thereby_Adv = mkAdv "därav" ; -- comment=3
lin protest_V2 = mkV2 (mkV (mkV "protestera") "mot"); -- status=guess, src=wikt
lin protest_V = mkV "protesterar" ; -- comment=2
lin roll_N = mkN "trumvirvel" | mkN "vals" "valser" ; -- SaldoWN -- comment=22
lin stop_N = mkN "uppehåll" neutrum | mkN "bländare" utrum ; -- SaldoWN -- comment=18
lin assistant_N = mkN "assistent" "assistenter" ; -- status=guess
lin deaf_A = mkA "döv" ; -- SaldoWN
lin constituency_N = mkN "valkrets" ; -- SaldoWN
lin continuous_A = mkA "oavbruten" "oavbrutet" | mkA "kontinuerlig" ; -- SaldoWN -- comment=4
lin concert_N = mkN "konsert" "konserter" | mkN "överenskommelse" "överenskommelser" ; -- SaldoWN -- comment=6
lin breast_N = L.breast_N ;
lin extraordinary_A = mkA "enastående" | mkA "märkvärdig" ; -- SaldoWN -- comment=6
lin squad_N = mkN "trupp" "trupper" ; -- SaldoWN
lin wonder_N = mkN "underverk" neutrum | mkN "underverk" neutrum ; -- SaldoWN -- comment=4
lin cream_N = mkN "kräm" ; -- SaldoWN = mkN "kräm" "krämer" ;
lin tennis_N = mkN "tennis" ; -- SaldoWN
lin personally_Adv = variants{} ; -- 
lin communicate_V2 = mkV2 (mkV "kommunicerar"); -- status=guess, src=wikt
lin communicate_V = mkV "överföra" "överförde" "överfört" ; -- comment=6
lin pride_N = mkN "stolthet" "stoltheter" ; -- SaldoWN
lin bowl_N = mkN "stadion" neutrum | mkN "skål" ; -- SaldoWN -- comment=10
lin file_V2 = dirV2 (partV (mkV "filar")"av"); -- status=guess
lin file_V = mkV "lida" "led" "lidit" ; -- comment=6
lin expertise_N = mkN "expertis" | mkN "sakkunskap" ; -- SaldoWN -- comment=4
lin govern_V2 = mkV2 (mkV "regerar") | mkV2 (mkV "härska"); -- status=guess, src=wikt status=guess, src=wikt
lin govern_V = mkV "styra" "styrde" "styrt" ; -- comment=6
lin leather_N = L.leather_N ;
lin observer_N = mkN "observatör" "observatörer" ; -- SaldoWN
lin margin_N = mkN "marginal" "marginaler" ; -- SaldoWN
lin uncertainty_N = mkN "ovisshet" "ovissheter" | mkN "osäkerhet" "osäkerheter" ; -- SaldoWN -- comment=5
lin reinforce_V2 = mkV2 (mkV "förstärker") | mkV2 (mkV "armerar"); -- status=guess, src=wikt status=guess, src=wikt
lin ideal_N = mkN "ideal" neutrum | mkN "mönster" neutrum ; -- SaldoWN -- comment=5
lin injure_V2 = mkV2 (mkV "skadar"); -- status=guess, src=wikt
lin holding_N = mkN "innehav" neutrum; -- status=guess
lin universal_A = mkA "allmän" "allmänt" "allmänna" "allmänna" "allmännare" "allmännast" "allmännaste" ; -- comment=6
lin evident_A = mkA "uppenbar" ; -- comment=3
lin dust_N = L.dust_N ;
lin overseas_A = mkA "utrikes" ; -- comment=2
lin desperate_A = mkA "desperat" "desperat" ; -- comment=3
lin swim_V2 = mkV2 "flyta" "flöt" "flutit" | mkV2 (mkV "simmar") ; -- SaldoWN -- status=guess, src=wikt
lin swim_V = L.swim_V ;
lin occasional_A = mkA "tillfällig" ; -- comment=3
lin trouser_N = variants{} ; -- 
lin surprisingly_Adv = variants{} ; -- 
lin register_N = mkN "register" neutrum | mkN "register" neutrum ; -- SaldoWN -- comment=12
lin album_N = mkN "album" neutrum ; -- status=guess
lin guideline_N = mkN "riktlinje" "riktlinjer" ; -- SaldoWN
lin disturb_V2 = mkV2 (mkV "störa"); -- status=guess, src=wikt
lin amendment_N = mkN "tillägg" neutrum | mkN "rättelse" "rättelser" ; -- SaldoWN
lin architectMasc_N = variants{} ; -- 
lin objection_N = mkN "invändning" ; -- SaldoWN
lin chart_N = mkN "tablå" "tablåer" | mkN "tabell" "tabeller" ; -- SaldoWN -- comment=7
lin cattle_N = mkN "boskap" | mkN "kreatur" neutrum ; -- SaldoWN -- comment=5
lin doubt_VS = mkVS (mkV "tvivlar"); -- status=guess, src=wikt
lin doubt_V2 = mkV2 (mkV "tvivlar"); -- status=guess, src=wikt
lin react_V = mkV "reagerar" ; -- status=guess
lin consciousness_N = mkN "medvetande" ; -- SaldoWN
lin right_Interj = variants{} ; -- 
lin purely_Adv = variants{} ; -- 
lin tin_N = mkN "tenn" neutrum | mkN "tenn" neutrum ; -- SaldoWN -- comment=10
lin tube_N = mkN "tunnelbana" | mkN "tub" "tuber" ; -- SaldoWN -- comment=5
lin fulfil_V2 = variants{} ; -- 
lin commonly_Adv = mkAdv "vanligen" ; -- status=guess
lin sufficiently_Adv = variants{} ; -- 
lin coin_N = mkN "mynt" neutrum ; -- status=guess
lin frighten_V2 = mkV2 (mkV "skrämma"); -- status=guess, src=wikt
lin grammar_N = L.grammar_N ;
lin diary_N = mkN "dagbok" "dagböcker" ; -- comment=4
lin flesh_N = mkN "kött" neutrum | mkN "skrapa" ; -- SaldoWN -- comment=3
lin summary_N = mkN "sammandrag" neutrum | mkN "koncentrat" neutrum ; -- SaldoWN -- comment=7
lin infant_N = mkN "spädbarn" neutrum; -- comment=3
lin stir_V2 = mkV2 "röra" "rörde" "rört" | dirV2 (partV (mkV "tänder")"på") ; -- SaldoWN
lin stir_V = mkV "röra" "rörde" "rört" | mkV "vispar" ; -- SaldoWN -- comment=6
lin storm_N = mkN "storm" ; -- SaldoWN
lin mail_N = mkN "post" | mkN "postverk" neutrum ; -- SaldoWN = mkN "post" "poster" ; -- comment=9
lin rugby_N = variants{} ; -- 
lin virtue_N = mkN "dygd" "dygder" | mkN "kraft" "krafter" ; -- SaldoWN -- comment=6
lin specimen_N = mkN "specimen" neutrum | mkN "prov" neutrum ; -- SaldoWN -- comment=6
lin psychology_N = mkN "psykologi" ; -- SaldoWN
lin paint_N = mkN "färg" "färger" | mkN "smink" "sminket" "sminker" "sminkerna" ; -- SaldoWN -- comment=3
lin constraint_N = mkN "begränsning" | mkN "tvång" neutrum ; -- SaldoWN -- comment=3
lin trace_V2 = mkV2 "spår" | dirV2 (partV (mkV "spårar")"ur") ; -- SaldoWN
lin trace_V = mkV "spår" | mkV "spårar" ; -- SaldoWN -- comment=9
lin privilege_N = mkN "privilegium" "privilegiet" "privilegier" "privilegierna" ; -- SaldoWN
lin completion_N = mkN "slutförande" ; -- comment=6
lin progress_V2 = dirV2 (partV (mkV "gå" "går" "gå" "gick" "gått" "gången")"ut"); -- comment=15
lin progress_V = mkV "utvecklar" ; -- comment=3
lin grade_N = mkN "lutning" | mkN "grad" "grader" ; -- SaldoWN -- comment=15
lin exploit_V2 = mkV2 (mkV "exploaterar"); -- status=guess, src=wikt
lin import_N = mkN "import" "importer" | mkN "vikt" "vikter" ; -- SaldoWN -- comment=6
lin potato_N = mkN "potatis" ; -- SaldoWN
lin repair_N = mkN "tillhåll" neutrum; -- comment=8
lin passion_N = mkN "passion" "passioner" ; -- SaldoWN
lin seize_V2 = mkV2 "gripa" "grep" "gripit" | mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV "fånga") | mkV2 (mkV "tillskansa") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin seize_V = mkV "gripa" "grep" "gripit" ; -- SaldoWN
lin low_Adv = variants{} ; -- 
lin underlying_A = mkA "underliggande" ; -- status=guess
lin heaven_N = mkN "himmel" ; -- SaldoWN
lin nerve_N = mkN "nerv" "nerver" | mkN "mod" neutrum ; -- SaldoWN -- comment=3
lin park_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=3
lin park_V = mkV "placerar" ; -- comment=4
lin collapse_V2 = variants{}; -- mkV "spricka" "sprack" "spruckit" ; -- comment=7
lin collapse_V = mkV "spricka" "sprack" "spruckit" ; -- comment=7
lin win_N = mkN "seger" ; -- SaldoWN
lin printer_N = mkN "skrivare" utrum | mkN "skrivare" utrum ; -- SaldoWN -- comment=2
lin coalition_N = mkN "koalition" "koalitioner" ; -- SaldoWN
lin button_N = mkN "knapp" ; -- SaldoWN
lin pray_V2 = mkV2 "be" "bad" "bett" ; -- status=guess
lin pray_V = mkV "be" "bad" "bett" ; -- SaldoWN
lin ultimate_A = mkA "slutlig" | mkA "slutgiltig" ; -- SaldoWN -- comment=3
lin venture_N = mkN "satsning" | mkN "vågspel" "vågspelet" "vågspel" "vågspelen" ; -- SaldoWN -- comment=5
lin timber_N = mkN "timmer" neutrum | mkN "virke" ; -- SaldoWN
lin companion_N = mkN "sällskapsdam" "sällskapsdamer" ; -- comment=9
lin horror_N = mkN "skräck" ; -- SaldoWN
lin gesture_N = mkN "gest" "gester" ; -- SaldoWN
lin moon_N = L.moon_N ;
lin remark_VS = variants{}; -- mkV "iaktta" "iakttar" "iaktta" "iakttog" "iakttagit" "iakttagen" ; -- comment=3
lin remark_V = mkV "iaktta" "iakttar" "iaktta" "iakttog" "iakttagit" "iakttagen" ; -- comment=3
lin clever_A = L.clever_A;
lin van_N = mkN "skåpbil" ; -- status=guess
lin consequently_Adv = variants{} ; -- 
lin raw_A = mkA "rå" "rått" ; -- SaldoWN
lin glance_N = mkN "ögonkast" neutrum | mkN "blick" ; -- SaldoWN -- comment=2
lin broken_A = variants{} ; -- 
lin jury_N = mkN "jury" "juryer" | mkN "tävlingsjury" "tävlingsjuryer" ; -- SaldoWN -- comment=2
lin gaze_V = mkV "stirrar" ; -- comment=3
lin burst_V2 = mkV2 "brista" "brast" "brustit" | dirV2 (partV (mkV "störtar")"in") ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=3
lin burst_V = mkV "brista" "brast" "brustit" | mkV "störtar" ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=14
lin charter_N = mkN "stadga" ; -- SaldoWN = mkN "stadga" ;
lin feministMasc_N = variants{} ; -- 
lin discourse_N = mkN "tal" neutrum; -- comment=5
lin reflection_N = mkN "spegelbild" "spegelbilder" | mkN "återkastning" ; -- SaldoWN -- comment=11
lin carbon_N = mkN "kol" neutrum ; -- status=guess
lin sophisticated_A = compoundA (regA "avancerad"); -- comment=6
lin ban_N = mkN "förbud" neutrum ; -- status=guess
lin taxation_N = mkN "skatt" "skatter" ; -- comment=4
lin prosecution_N = mkN "åtal" neutrum | mkN "åtal" neutrum ; -- SaldoWN -- comment=5
lin softly_Adv = variants{} ; -- 
lin asleep_A = variants{} ; -- 
lin aids_N = mkN "aids" ; -- SaldoWN
lin publicity_N = mkN "publicitet" "publiciteter" | mkN "reklam" "reklamer" ; -- SaldoWN -- comment=4
lin departure_N = mkN "avresa" ; -- SaldoWN
lin welcome_A = mkA "välkommen" "välkommet" "välkomna" "välkomna" "välkomnare" "välkomnast" "välkomnaste" ; -- SaldoWN
lin sharply_Adv = variants{} ; -- 
lin reception_N = mkN "mottagning" | mkN "reception" "receptioner" ; -- SaldoWN -- comment=5
lin cousin_N = L.cousin_N ;
lin relieve_V2 = mkV2 "undsätta" "undsätter" "undsätt" "undsatte" "undsatt" "undsatt" ; -- SaldoWN
lin linguistic_A = mkA "lingvistisk" ; -- comment=2
lin vat_N = mkN "kar" neutrum ; -- SaldoWN
lin forward_A = mkA "framfusig" | mkA "försigkommen" "försigkommet" "försigkomna" "försigkomna" "försigkomnare" "försigkomnast" "försigkomnaste" ; -- SaldoWN -- comment=10
lin blue_N = mkN "blåhet" ; -- status=guess
lin multiple_A = mkA "multipel" | mkA "mångfaldig" ; -- status=guess
lin pass_N = mkN "passersedel" | mkN "räcka" ; -- SaldoWN -- comment=14
lin outer_A = mkA "utvändig" ; -- status=guess
lin vulnerable_A = mkA "sårbar" ; -- SaldoWN
lin patient_A = mkA "tålmodig" ; -- SaldoWN
lin evolution_N = mkN "evolution" "evolutioner" ; -- SaldoWN
lin allocate_V2 = mkV2 (mkV "avsätta" "avsatte" "avsatt"); -- status=guess, src=wikt
lin allocate_V = mkV "tilldelar" ; -- comment=8
lin creative_A = mkA "kreativ" ; -- SaldoWN
lin potentially_Adv = variants{} ; -- 
lin just_A = mkA "rättvis" ; -- SaldoWN
lin out_Prep = mkPrep "ute" | mkPrep "ut" ; ---- split
lin judicial_A = mkA "rättslig" ; -- SaldoWN
lin risk_VV = mkVV (mkV "riskerar") | mkVV (mkV (mkV "ta") "en risk"); -- status=guess, src=wikt status=guess, src=wikt
lin risk_V2 = mkV2 (mkV "riskerar") | mkV2 (mkV (mkV "ta") "en risk"); -- status=guess, src=wikt status=guess, src=wikt
lin ideology_N = mkN "ideologi" "ideologier" ; -- SaldoWN
lin smell_VA = mkVA (mkV (mkV "ana") "ugglor i mossen"); -- status=guess, src=wikt
lin smell_V2 = mkV2 (mkV (mkV "ana") "ugglor i mossen"); -- status=guess, src=wikt
lin smell_V = L.smell_V;
lin agenda_N = mkN "dagordning" ; -- SaldoWN
lin transport_V2 = dirV2 (partV (mkV "forslar")"in"); -- comment=2
lin illegal_A = mkA "olaglig" ; -- SaldoWN
lin chicken_N = mkN "lipsill" | mkN "kyckling" ; -- SaldoWN -- comment=6
lin plain_A = mkA "redig" | mkA "uppriktig" ; -- SaldoWN -- comment=17
lin innovation_N = mkN "innovation" "innovationer" ; -- SaldoWN
lin opera_N = mkN "opera" ; -- SaldoWN
lin lock_N = mkN "lås" | mkN "spärr" ; -- SaldoWN -- comment=9
lin grin_V = mkV "grinar" ; -- comment=2
lin shelf_N = mkN "hylla" | mkN "sandbank" ; -- SaldoWN -- comment=5
lin pole_N = mkN "stång" "stänger" | mkN "polack" "polacker" ; -- SaldoWN
lin punishment_N = mkN "straff" ; -- comment=5
lin strict_A = mkA "strikt" "strikt" ; -- SaldoWN
lin wave_V2 = mkV2 (mkV "vankar") | mkV2 (mkV (mkV "vanka") "av och an"); -- status=guess, src=wikt status=guess, src=wikt
lin wave_V = mkV "fladdrar" ; -- comment=5
lin inside_N = mkN "insida" ; -- SaldoWN
lin carriage_N = mkN "hållning" | mkN "vagn" ; -- SaldoWN -- comment=8
lin fit_A = mkA "lämplig" ; -- comment=12
lin conversion_N = mkN "omvändning" ; -- comment=7
lin hurry_V = mkV "brådskar" ; -- comment=5
lin essay_N = mkN "essä" "essän" "essäer" "essäerna" | mkN "försök" neutrum ; -- SaldoWN -- comment=4
lin integration_N = mkN "integration" "integrationer" ; -- SaldoWN
lin resignation_N = mkN "underkastelse" utrum | mkN "resignation" "resignationer" ; -- SaldoWN -- comment=9
lin treasury_N = mkN "skattkammare" "skattkammaren" "skattkamrar" "skattkamrarna" ; -- comment=2
lin traveller_N = mkN "resenär" "resenärer" ; -- comment=8
lin chocolate_N = mkN "choklad" neutrum ; -- status=guess
lin assault_N = mkN "överfall" neutrum | mkN "anfall" neutrum ; -- SaldoWN -- comment=6
lin schedule_N = mkN "schema" "schemat" "scheman" "schemana" | mkN "tidsplan" neutrum ; -- SaldoWN -- comment=7
lin undoubtedly_Adv = variants{} ; -- 
lin twin_N = mkN "tvilling" ; -- SaldoWN
lin format_N = mkN "format" neutrum ; -- status=guess
lin murder_V2 = mkV2 (mkV "mörda"); -- status=guess, src=wikt
lin sigh_VS = mkVS (mkV "suckar"); -- status=guess, src=wikt
lin sigh_V2 = mkV2 (mkV "suckar"); -- status=guess, src=wikt
lin sigh_V = mkV "susar" ; -- comment=5
lin sellerMasc_N = variants{} ; -- 
lin lease_N = mkN "leasing" | mkN "hyra" ; -- SaldoWN -- comment=6
lin bitter_A = mkA "bitter" | mkA "hård" "hårt" ; -- SaldoWN -- comment=9
lin double_V2 = mkV2 (mkV "dubblar"); -- status=guess, src=wikt
lin double_V = mkV "fördubblar" ; -- comment=4
lin ally_N = mkN "bundsförvant" "bundsförvanter" | mkN "före" ; -- SaldoWN -- comment=2
lin stake_N = mkN "insats" "insatser" | mkN "stötta" ; -- SaldoWN -- comment=8
lin processing_N = mkN "bearbetning" ; -- comment=2
lin informal_A = mkA "informell" | mkA "inofficiell" ; -- SaldoWN -- comment=2
lin flexible_A = mkA "böjlig" | mkA "flexibel" ; -- SaldoWN -- comment=7
lin cap_N = L.cap_N ;
lin stable_A = mkA "stabil" | mkA "stadig" ; -- SaldoWN -- comment=3
lin till_Subj = variants{} ; -- 
lin sympathy_N = mkN "sympati" "sympatier" ; -- comment=8
lin tunnel_N = mkN "tunnel" ; -- SaldoWN
lin pen_N = L.pen_N ;
lin instal_V = variants{} ; -- 
lin suspend_V2 = variants{}; -- mkV "suspenderar" ; -- comment=10
lin suspend_V = mkV "suspenderar" ; -- comment=10
lin blow_N = mkN "motgång" | mkN "stöt" ; -- SaldoWN -- comment=19
lin wander_V = mkV "avvika" "avvek" "avvikit" | mkV "yra" "yrde" "yrt" ; -- SaldoWN -- comment=6
lin notably_Adv = mkAdv "märkbart" ; -- status=guess
lin disappoint_V2 = mkV2 "svika" "svek" "svikit" | dirV2 (partV (mkV "lurar") "till") ; -- SaldoWN -- comment=2
lin wipe_V2 = L.wipe_V2 ;
lin wipe_V = mkV "förbigå" "förbigår" "förbigå" "förbigick" "förbigått" "förbigången" | mkV "raderar" ; -- SaldoWN -- status=guess, src=wikt
lin folk_N = mkN "folkmusik" | mkN "folk" neutrum ; -- SaldoWN
lin attraction_N = mkN "dragning" | mkN "nummer" neutrum ; -- SaldoWN -- comment=7
lin disc_N = mkN "platta" ; -- comment=7
lin inspire_V2V = mkV2V (mkV "inspirerar"); -- status=guess, src=wikt
lin inspire_V2 = mkV2 (mkV "inspirerar"); -- status=guess, src=wikt
lin machinery_N = mkN "maskineri" "maskinerit" "maskinerier" "maskinerierna" ; -- SaldoWN
lin undergo_V2 = mkV2 (mkV "genomgå"); -- status=guess, src=wikt
lin nowhere_Adv = mkAdv "ingenstans" ; -- status=guess
lin inspector_N = mkN "inspektör" "inspektörer" | mkN "kontrollant" "kontrollanter" ; -- SaldoWN -- comment=4
lin wise_A = mkA "klok" ; -- SaldoWN
lin balance_V2 = mkV2 (mkV "balanserar") | mkV2 (mkV (mkV "jämna") "ut sig") | mkV2 (mkV (mkV "stå") "och väga") | mkV2 (mkV (mkV "vara") "i jämvikt"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin balance_V = mkV "balanserar" ; -- comment=15
lin purchaser_N = mkN "köpare" utrum; -- comment=2
lin resort_N = mkN "hotell" neutrum ; -- SaldoWN
lin pop_N = mkN "smälla" | mkN "pop" "poper" ; -- SaldoWN -- comment=3
lin organ_N = mkN "orgel" ; -- SaldoWN
lin ease_V2 = variants{}; -- mkV "lindrar" ; -- comment=2
lin ease_V = mkV "lindrar" ; -- comment=2
lin friendship_N = mkN "vänskap" | mkN "kamratskap" neutrum ; -- SaldoWN -- comment=5
lin deficit_N = mkN "underskott" neutrum ; -- SaldoWN -- comment=4
lin dear_N = mkN "raring" ; -- comment=2
lin convey_V2 = dirV2 (partV (mkV "forslar")"in"); -- comment=2
lin reserve_V2 = dirV2 (partV (mkV "sparar")"in"); -- status=guess
lin reserve_V = mkV "sparar" ; -- comment=8
lin planet_N = L.planet_N ;
lin frequent_A = mkA "frekvent" "frekvent" | mkA "tät" ; -- SaldoWN -- comment=3
lin loose_A = mkA "lös" | mkA "lösaktig" ; -- SaldoWN = mkA "lös" ; -- comment=7
lin intense_A = mkA "intensiv" | mkA "lidelsefull" ; -- SaldoWN -- comment=4
lin retail_A = variants{} ; -- 
lin wind_V = mkV "virar" ; -- comment=10
lin lost_A = variants{} ; -- 
lin grain_N = mkN "säd" ; -- SaldoWN
lin particle_N = mkN "partikel" ; -- SaldoWN
lin destruction_N = mkN "förstörelse" "förstörelser" ; -- SaldoWN
lin witness_V2 = mkV2 (mkV (mkV "vittna") "om"); -- status=guess, src=wikt
lin witness_V = mkV "bevittnar" ; -- comment=2
lin pit_N = mkN "schakt" neutrum | mkN "säng" ; -- SaldoWN -- comment=11
lin registration_N = mkN "inskrivning" | mkN "registrering" ; -- SaldoWN -- comment=7
lin conception_N = mkN "befruktning" | mkN "tanke" utrum ; -- SaldoWN -- comment=11
lin steady_A = mkA "stadig" ; -- SaldoWN
lin rival_N = mkN "rivaliserande" ; -- comment=4
lin steam_N = mkN "ånga" ; -- SaldoWN
lin back_A = variants{} ; -- 
lin chancellor_N = mkN "kansler" "kanslerer" ; -- status=guess
lin crash_V = mkV "kvaddar" ; -- comment=14
lin belt_N = mkN "skärp" neutrum | mkN "bälte" ; -- SaldoWN -- comment=10
lin logic_N = mkN "logik" ; -- SaldoWN
lin premium_N = mkN "försäkringspremie" "försäkringspremier" | mkN "premie" "premier" ; -- SaldoWN -- comment=3
lin confront_V2 = variants{} ; -- 
lin precede_V2 = mkV2 "föregå" "föregår" "föregå" "föregick" "föregått" "föregången" ; -- SaldoWN
lin experimental_A = mkA "experimentell" ; -- SaldoWN
lin alarm_N = mkN "larm" neutrum | mkN "väckarklocka" ; -- SaldoWN -- comment=10
lin rational_A = mkA "rationell" ; -- SaldoWN
lin incentive_N = mkN "incitament" neutrum ; -- SaldoWN
lin roughly_Adv = variants{}; -- mkAdV "ungefär" ;
lin bench_N = mkN "bänk" | mkN "domare" utrum ; -- SaldoWN -- comment=9
lin wrap_V2 = mkV2 (mkV (mkV "slå" "slog" "slagit") "in") | mkV2 (mkV "paketerar") | mkV2 (mkV "emballerar") | mkV2 (mkV (mkV "linda") "in") | mkV2 (mkV (mkV "klä") "in"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wrap_V = mkV "förpackar" ; -- comment=4
lin regarding_Prep = mkPrep "med hänsyn till" ; -- status=guess
lin inadequate_A = mkA "otillräcklig" | mkA "inadekvat" "inadekvat" ; -- SaldoWN -- comment=6
lin ambition_N = mkN "ärelystnad" "ärelystnader" ; -- comment=5
lin since_Adv = mkAdv "sedan" ; -- comment=5
lin fate_N = mkN "öde" ; -- comment=5
lin vendor_N = mkN "säljare" utrum; -- status=guess
lin stranger_N = mkN "främling" ; -- status=guess
lin spiritual_A = compoundA (regA "förandligad"); -- comment=5
lin increasing_A = variants{} ; -- 
lin anticipate_VV = variants{}; -- mkV "förutse" "förutsåg" "förutsett" ; -- comment=4
lin anticipate_VS = variants{}; -- mkV "förutse" "förutsåg" "förutsett" ; -- comment=4
lin anticipate_V2 = variants{}; -- mkV "förutse" "förutsåg" "förutsett" ; -- comment=4
lin anticipate_V = mkV "förutse" "förutsåg" "förutsett" ; -- comment=4
lin logical_A = mkA "logisk" ; -- SaldoWN
lin fibre_N = mkN "fiber" "fibern" "fibrer" "fibrerna" ; -- SaldoWN
lin attribute_V2 = mkV2 (mkV "tilldela"); -- status=guess
lin sense_VS = variants{} ; -- 
lin sense_V2 = variants{} ; -- 
lin black_N = mkN "mörker" neutrum | mkN "svärta" ; -- SaldoWN -- comment=3
lin petrol_N = mkN "bensin" ; -- SaldoWN
lin maker_N = mkN "tillverkare" utrum; -- comment=4
lin generous_A = mkA "frikostig" | mkA "storsint" "storsint" ; -- SaldoWN -- comment=9
lin allocation_N = mkN "tilldelning" ; -- SaldoWN
lin depression_N = mkN "sänka" ; -- SaldoWN
lin declaration_N = mkN "deklaration" "deklarationer" | mkN "förklaring" ; -- SaldoWN -- comment=6
lin spot_VS = mkVS (mkV (mkV "märker") "ut"); -- status=guess, src=wikt
lin spot_V2 = mkV2 (mkV (mkV "märker") "ut"); -- status=guess, src=wikt
lin spot_V = mkV (mkV "märker") "ut" ; -- status=guess, src=wikt
lin modest_A = mkA "sedesam" "sedesamt" "sedesamma" "sedesamma" "sedesammare" "sedesammast" "sedesammaste" | mkA "anständig" ; -- SaldoWN -- comment=8
lin bottom_A = mkA "botten" | mkA "grund" ; -- SaldoWN -- comment=5
lin dividend_N = mkN "utdelning" ; -- SaldoWN
lin devote_V2 = mkV2 (mkV "devote"); -- status=guess
lin condemn_V2 = dirV2 (partV (mkV "dömer") "ut"); -- comment=2
lin integrate_V2 = mkV2 (mkV "integrerar"); -- status=guess, src=wikt
lin integrate_V = mkV "integrerar" ; -- status=guess
lin pile_N = mkN "hög" | mkN "påle" utrum ; -- SaldoWN -- comment=10
lin identification_N = mkN "legitimation" "legitimationer" | mkN "identifikation" "identifikationer" ; -- SaldoWN -- comment=2
lin acute_A = mkA "akut" "akut" | mkA "spetsig" ; -- SaldoWN -- comment=14
lin barely_Adv = variants{} ; -- 
lin providing_Subj = variants{} ; -- 
lin directive_N = mkN "direktiv" neutrum; -- comment=6
lin bet_VS = mkVS (mkV "satsar"); -- status=guess, src=wikt
lin bet_V2 = mkV2 (mkV "satsar"); -- status=guess, src=wikt
lin bet_V = mkV "förutsäga" "förutsade" "förutsagt" ; -- status=guess
lin modify_V2 = variants{} ; -- 
lin bare_A = mkA "bar" | mkA "naken" "naket" ; -- SaldoWN -- comment=7
lin swear_VV = mkVV (mkV "svära" "svor" "svurit") ; -- status=guess
lin swear_V2 = mkV2 "svära" "svor" "svurit" ; -- status=guess
lin swear_V = mkV "svära" "svor" "svurit" ; -- status=guess
lin final_N = mkN "final" "finaler" | mkN "sista" ; -- SaldoWN -- comment=3
lin accordingly_Adv = mkAdv "därmed" ; -- comment=6
lin valid_A = mkA "giltig" | mkA "lagenlig" ; -- SaldoWN -- comment=3
lin wherever_Adv = variants{} ; -- 
lin mortality_N = mkN "dödlighet" ; -- comment=4
lin medium_N = mkN "medium" neutrum | mkN "medelväg" ; -- SaldoWN = mkN "medium" "mediet" "medier" "medierna" ; -- comment=7
lin silk_N = mkN "siden" neutrum | mkN "silke" ; -- SaldoWN -- comment=2
lin funeral_N = mkN "begravning" | mkN "begravningståg" neutrum ; -- SaldoWN -- comment=3
lin depending_A = variants{} ; -- 
lin cow_N = L.cow_N ;
lin correspond_V2 = mkV2 (mkV "motsvarar") ; -- status=guess
lin correspond_V = mkV "brevväxlar" ; -- comment=2
lin cite_V2 = dirV2 (partV (mkV "kallar")"ut"); -- status=guess
lin classic_A = mkA "klassisk" ; -- comment=3
lin inspection_N = mkN "översyn" "översyner" ; -- comment=14
lin calculation_N = mkN "beräkning" ; -- SaldoWN
lin rubbish_N = mkN "avfall" neutrum | mkN "struntprat" neutrum ; -- SaldoWN -- comment=13
lin minimum_N = mkN "minimum" neutrum | mkN "minimum" neutrum ; -- SaldoWN
lin hypothesis_N = mkN "hypotes" "hypoteser" ; -- SaldoWN
lin youngster_N = mkN "barnunge" utrum; -- comment=2
lin slope_N = mkN "luta" ; -- comment=8
lin patch_N = mkN "lapp" | mkN "täppa" ; -- SaldoWN -- comment=7
lin invitation_N = mkN "lockelse" "lockelser" ; -- comment=7
lin ethnic_A = mkA "etnisk" ; -- SaldoWN
lin federation_N = mkN "federation" "federationer" ; -- SaldoWN
lin duke_N = mkN "hertig" ; -- SaldoWN
lin wholly_Adv = variants{} ; -- 
lin closure_N = mkN "stängning" ; -- comment=7
lin dictionary_N = mkN "ordbok" "ordböcker" | mkN "uppslagsbok" "uppslagsböcker" ; -- SaldoWN -- comment=3
lin withdrawal_N = mkN "reservation" "reservationer" | mkN "utträde" ; -- SaldoWN -- comment=6
lin automatic_A = mkA "automatisk" | mkA "mekanisk" ; -- SaldoWN -- comment=4
lin liable_A = mkA "mottaglig" ; -- comment=7
lin cry_N = mkN "skrika" ; -- comment=7
lin slow_V2 = dirV2 (partV (mkV "saktar")"av"); -- status=guess
lin slow_V = mkV "saktar" ; -- status=guess
lin borough_N = mkN "stad" "städer" ; -- status=guess
lin well_A = mkA "frisk" | mkA "bra" ; -- SaldoWN -- comment=6
lin suspicion_N = mkN "misstanke" utrum | mkN "misstanke" utrum ; -- SaldoWN -- comment=7
lin portrait_N = mkN "porträtt" neutrum | mkN "porträtt" neutrum ; -- SaldoWN -- comment=6
lin local_N = mkN "lokal" "lokaler" ; -- status=guess
lin jew_N = mkN "jude" utrum; -- status=guess
lin fragment_N = mkN "fragment" neutrum | mkN "splittra" ; -- SaldoWN -- comment=11
lin revolutionary_A = mkA "revolutionär" | mkA "omstörtande" ; -- SaldoWN -- comment=3
lin evaluate_V2 = mkV2 "utvärdera" ; -- status=guess
lin evaluate_V = mkV "utvärderar" ; -- status=guess
lin competitor_N = mkN "konkurrent" "konkurrenter" ; -- comment=4
lin sole_A = mkA "botten" ; -- comment=7
lin reliable_A = mkA "pålitlig" | mkA "vederhäftig" ; -- SaldoWN -- comment=6
lin weigh_V2 = mkV2 (mkV "väga"); -- status=guess, src=wikt
lin weigh_V = mkV "väger" ; -- comment=7
lin medieval_A = mkA "medeltida" ; -- SaldoWN
lin clinic_N = mkN "klinik" "kliniker" ; -- SaldoWN
lin shine_V2 = mkV2 "skina" "sken" "skinit" | dirV2 (partV (mkV "skimrar")"igenom") ; -- SaldoWN
lin shine_V = mkV "skina" "sken" "skinit" | mkV "strålar" ; -- SaldoWN -- comment=7
lin knit_V2 = mkV2 "sticka" "stack" "stuckit" | mkV2 (mkV "stickar") ; -- SaldoWN = mkV "sticka" "stack" "stuckit" ; -- status=guess, src=wikt
lin knit_V = mkV "sticka" "stack" "stuckit" ; -- SaldoWN = mkV "sticka" "stack" "stuckit" ;
lin complexity_N = (mkN "komplikation" "komplikationer") | mkN "krånglighet" ; -- status=guess status=guess
lin remedy_N = mkN "botemedel" neutrum | mkN "botemedel" neutrum ; -- SaldoWN -- comment=9
lin fence_N = mkN "stängsel" neutrum ; -- SaldoWN -- comment=6
lin bike_N = L.bike_N ;
lin freeze_V2 = mkV2 (mkV "frysa"); -- status=guess, src=wikt
lin freeze_V = L.freeze_V;
lin eliminate_V2 = dirV2 (partV (mkV "gallrar")"ut"); -- status=guess
lin interior_N = mkN "interiör" "interiörer" ; -- comment=4
lin intellectual_A = mkA "intellektuell" ; -- comment=3
lin established_A = variants{} ; -- 
lin voter_N = mkN "väljare" utrum | mkN "väljare" utrum ; -- SaldoWN
lin garage_N = mkN "garage" "garaget" "garage" "garagen" ; -- SaldoWN
lin era_N = mkN "tideräkning" ; -- status=guess
lin pregnant_A = mkA "gravid" | mkA "ödesdiger" ; -- SaldoWN -- comment=10
lin plot_N = mkN "sammansvärjning" ; -- status=guess
lin greet_V2 = dirV2 (partV (mkV "hälsar")"på"); -- status=guess
lin electrical_A = mkA "elektrisk" ; -- status=guess
lin lie_N = mkN "lögn" "lögner" ; -- SaldoWN
lin disorder_N = mkN "oordning" | mkN "orolighet" "oroligheter" ; -- SaldoWN -- comment=9
lin formally_Adv = variants{} ; -- 
lin excuse_N = mkN "undanflykt" "undanflykter" | mkN "ursäkt" "ursäkter" ; -- SaldoWN -- comment=8
lin socialist_A = mkA "socialistisk" ; -- SaldoWN
lin cancel_V2 = dirV2 (partV (mkV "stämplar")"ut"); -- comment=2
lin cancel_V = mkV "stämplar" ; -- comment=16
lin harm_N = mkN "skada" ; -- SaldoWN
lin excess_N = mkN "överflöd" neutrum | mkN "överskridande" ; -- SaldoWN -- comment=5
lin exact_A = mkA "precis" | mkA "noggrann" "noggrant" ; -- SaldoWN -- comment=6
lin oblige_V2V = variants{} ; -- 
lin oblige_V2 = variants{} ; -- 
lin accountant_N = mkN "kamrer" "kamrerer" ; -- SaldoWN
lin mutual_A = mkA "ömsesidig" ; -- SaldoWN
lin fat_N = L.fat_N ;
lin volunteerMasc_N = variants{} ; -- 
lin laughter_N = mkN "skratt" neutrum; -- comment=2
lin trick_N = mkN "trick" neutrum | mkN "knep" neutrum ; -- SaldoWN = mkN "trick" ; -- comment=17
lin load_V2 = dirV2 (partV (mkV "lastar")"ur"); -- comment=8
lin load_V = mkV "lastar" ; -- comment=5
lin disposal_N = mkN "bortskaffande" ; -- comment=10
lin taxi_N = mkN "taxi" "taxin" "taxi" "taxina" ; -- SaldoWN
lin murmur_V2 = mkV2 (mkV "mumlar"); -- status=guess, src=wikt
lin murmur_V = mkV "sorlar" ; -- comment=10
lin tonne_N = mkN "ton" "tonnet" "ton" "tonnen" ; -- comment=2
lin spell_V2 = mkV2 (mkV "stavar"); -- status=guess, src=wikt
lin spell_V = mkV "stavar" ; -- comment=6
lin clerk_N = mkN "kontorist" "kontorister" ; -- SaldoWN
lin curious_A = mkA "nyfiken" "nyfiket" ; -- SaldoWN
lin satisfactory_A = mkA "tillfredsställande" ; -- SaldoWN
lin identical_A = mkA "identisk" ; -- SaldoWN
lin applicant_N = mkN "sökande" ; -- SaldoWN = mkN "sökande" "sökanden" "sökande" "sökandena" ;
lin removal_N = mkN "flyttning" ; -- comment=11
lin processor_N = variants{} ; -- 
lin cotton_N = mkN "bomull" ; -- SaldoWN
lin reverse_V2 = dirV2 (partV (mkV "backar")"ur"); -- status=guess
lin reverse_V = mkV "ändrar" ; -- comment=10
lin hesitate_VV = mkVV (mkV "tvekar") | mkVV (mkV "dröja"); -- status=guess, src=wikt status=guess, src=wikt
lin hesitate_V = mkV "tvekar" ; -- comment=3
lin professor_N = mkN "professor" "professorer" ; -- status=guess
lin admire_V2 = variants{} ; -- 
lin namely_Adv = variants{} ; -- 
lin electoral_A = mkA "val" | mkA "valmanna" | mkA "valmans" | mkA "elektors" | mkA "kurfurstlig" ; -- status=guess status=guess status=guess status=guess status=guess
lin delight_N = mkN "glädje" utrum; -- comment=6
lin urgent_A = mkA "enträgen" "enträget" ; -- comment=9
lin prompt_V2V = variants{}; -- dirV2 (partV (mkV "komma" "kom" "kommit")"vid"); -- comment=5
lin prompt_V2 = dirV2 (partV (mkV "komma" "kom" "kommit")"vid"); -- comment=5
lin mate_N = mkN "kompis" ; -- comment=8
lin mate_2_N = variants{} ; -- 
lin mate_1_N = mkN "kompis" ; -- comment=8
lin exposure_N = mkN "utsatthet" | mkN "exponering" ; -- SaldoWN -- comment=2
lin server_N = mkN "servitör" "servitörer" | mkN "server" ; -- SaldoWN
lin distinctive_A = mkA "utmärkande" ; -- comment=7
lin marginal_A = mkA "marginell" ; -- status=guess
lin structural_A = mkA "strukturell" ; -- SaldoWN
lin rope_N = L.rope_N ;
lin miner_N = mkN "gruvarbetare" utrum | mkN "gruvarbetare" utrum ; -- SaldoWN
lin entertainment_N = mkN "underhållning" ; -- SaldoWN
lin acre_N = mkN "tunnland" neutrum ; -- SaldoWN
lin pig_N = mkN "svin" neutrum | mkN "gris" ; -- SaldoWN -- comment=4
lin encouraging_A = mkA "hoppfull" ; -- SaldoWN
lin guarantee_N = mkN "garanti" "garantier" | mkN "säkerhet" "säkerheter" ; -- SaldoWN -- comment=4
lin gear_N = mkN "styrning" | mkN "seldon" neutrum ; -- SaldoWN -- comment=24
lin anniversary_N = mkN "jubileum" "jubileet" "jubileer" "jubileerna" | mkN "årsdag" ; -- SaldoWN -- comment=2
lin past_Adv = mkAdv "över" ; -- comment=6
lin ceremony_N = mkN "ceremoni" "ceremonier" ; -- SaldoWN
lin rub_V2 = L.rub_V2;
lin rub_V = mkV "stryka" "strök" "strukit" ; -- comment=8
lin monopoly_N = mkN "monopol" neutrum | mkN "monopol" neutrum ; -- SaldoWN = mkN "monopol" neutrum ; -- comment=2
lin left_N = mkN "vänster" ; -- SaldoWN = mkN "vänster" ;
lin flee_V2 = mkV2 (mkV "flyr"); -- status=guess, src=wikt
lin flee_V = mkV "undvika" "undvek" "undvikit" ; -- comment=5
lin yield_V2 = mkV2 "producera" ;
lin discount_N = mkN "rabatt" "rabatter" ; -- SaldoWN
lin above_A = mkA "ovanstående" ; -- comment=2
lin uncle_N = mkN "morbror" "morbröder" | mkN "farbror" "farbröder" ; -- SaldoWN -- comment=2
lin audit_N = mkN "revision" "revisioner" ; -- status=guess
lin advertisement_N = mkN "annons" "annonser" ; -- comment=5
lin explosion_N = mkN "explosion" "explosioner" ; -- SaldoWN
lin contrary_A = mkA "motsatt" ; -- comment=5
lin tribunal_N = mkN "tribunal" "tribunaler" ; -- comment=5
lin swallow_V2 = mkV2 "svälja" "svalde" "svalt" ; -- status=guess
lin swallow_V = mkV "svälja" "svalde" "svalt" ; -- SaldoWN
lin typically_Adv = mkAdv "typiskt" ; -- status=guess
lin fun_A = variants{} ; -- 
lin rat_N = mkN "strejkbrytare" utrum | mkN "smita" ; -- SaldoWN -- comment=4
lin cloth_N = mkN "tyg" neutrum; -- comment=5
lin cable_N = mkN "kabel" ; -- SaldoWN
lin interrupt_V2 = mkV2 "avbryta" "avbröt" "avbrutit" | mkV2 (mkV "avbryta" "avbröt" "avbrutit") ; -- SaldoWN -- status=guess, src=wikt
lin interrupt_V = mkV "avbryta" "avbröt" "avbrutit" ; -- SaldoWN
lin crash_N = mkN "olycka" | mkN "spricka" ; -- SaldoWN -- comment=16
lin flame_N = mkN "låga" ; -- comment=5
lin controversy_N = mkN "kontrovers" "kontroverser" ; -- comment=5
lin rabbit_N = mkN "kanin" "kaniner" ; -- SaldoWN
lin everyday_A = mkA "daglig" ; -- comment=4
lin allegation_N = mkN "anklagelse" "anklagelser" ; -- status=guess
lin strip_N = mkN "strippa" | mkN "serie" "serier" ; -- SaldoWN -- comment=8
lin stability_N = mkN "stabilitet" "stabiliteter" ; -- comment=4
lin tide_N = mkN "tidvatten" "tidvattnet" "tidvatten" "tidvattnen" ; -- SaldoWN
lin illustration_N = mkN "illustration" "illustrationer" ; -- SaldoWN
lin insect_N = mkN "insekt" "insekter" | mkN "kryp" neutrum ; -- SaldoWN -- comment=2
lin correspondent_N = mkN "kund" "kunder" ; -- comment=5
lin devise_V2 = variants{} ; -- 
lin determined_A = variants{} ; -- 
lin brush_V2 = dirV2 (partV (mkV "borstar")"av"); -- comment=4
lin brush_V = mkV "vidröra" "vidrörde" "vidrört" ; -- comment=6
lin adjustment_N = mkN "ordnande" ; -- comment=12
lin controversial_A = mkA "omstridd" | mkA "kontroversiell" ; -- SaldoWN -- comment=4
lin organic_A = mkA "organisk" | mkA "strukturell" ; -- SaldoWN -- comment=6
lin escape_N = mkN "rymning" ; -- comment=5
lin thoroughly_Adv = variants{} ; -- 
lin interface_N = mkN "gränssnitt" neutrum ; -- SaldoWN
lin historic_A = mkA "historisk" ; -- status=guess
lin collapse_N = mkN "sammanstörtande" ; -- comment=12
lin temple_N = mkN "tinning" ; -- SaldoWN
lin shade_N = mkN "nyans" "nyanser" | mkN "skugga" ; -- SaldoWN -- comment=11
lin craft_N = mkN "hantverk" neutrum | mkN "skrå" "skråt" "skrån" "skråen" ; -- SaldoWN -- comment=6
lin nursery_N = mkN "plantskola" ; -- SaldoWN
lin piano_N = mkN "piano" "pianot" "pianon" "pianona" ; -- status=guess
lin desirable_A = mkA "begärlig" | mkA "önskvärd" "önskvärt" ; -- SaldoWN -- comment=4
lin assurance_N = mkN "försäkran" "försäkran" "försäkringar" "försäkringarna" | mkN "visshet" "vissheter" ; -- SaldoWN -- comment=10
lin jurisdiction_N = mkN "jurisdiktion" "jurisdiktioner" ; -- SaldoWN
lin advertise_V2 = mkV2 (mkV (mkV "göra" "gjorde" "gjort") "reklam") (mkPrep "för"); -- status=guess
lin advertise_V = mkV "annonserar" ; -- comment=3
lin bay_N = mkN "bukt" "bukter" | mkN "ylande" ; -- SaldoWN -- comment=10
lin specification_N = mkN "specifikation" "specifikationer" ; -- status=guess
lin disability_N = mkN "handikapp" neutrum | mkN "oduglighet" ; -- SaldoWN -- comment=6
lin presidential_A = mkA "presidentmässig" ; -- SaldoWN
lin arrest_N = mkN "avbrott" neutrum; -- comment=8
lin unexpected_A = compoundA (regA "oväntad"); -- comment=2
lin switch_N = mkN "strömbrytare" utrum | mkN "ändring" ; -- SaldoWN -- comment=7
lin penny_N = mkN "öre" | mkN "ettöring" ; -- SaldoWN
lin respect_V2 = mkV2 (mkV (mkV "att") "respektera"); -- status=guess, src=wikt
lin celebration_N = mkN "firande" ; -- SaldoWN
lin gross_A = mkA "total" ; -- comment=11
lin aid_V2 = variants{}; -- mkV "underlättar" ; -- comment=4
lin aid_V = mkV "underlättar" ; -- comment=4
lin superb_A = mkA "superb" ; -- comment=2
lin process_V2 = variants{}; -- mkV "framkallar" ; -- comment=6
lin process_V = mkV "framkallar" ; -- comment=6
lin innocent_A = mkA "oskyldig" | mkA "troskyldig" ; -- SaldoWN -- comment=4
lin leap_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin leap_V = mkV "hoppar" ; -- status=guess
lin colony_N = mkN "koloni" "kolonier" ; -- SaldoWN
lin wound_N = mkN "sår" neutrum | mkN "skada" ; -- SaldoWN -- comment=4
lin hardware_N = mkN "hårdvara" | mkN "datorutrustning" ; -- SaldoWN -- comment=3
lin satellite_N = mkN "satellit" "satelliter" ; -- SaldoWN
lin float_V = L.float_V;
lin bible_N = mkN "bibel" ; -- SaldoWN
lin statistical_A = mkA "statistisk" ; -- SaldoWN
lin marked_A = compoundA (regA "markerad"); -- comment=3
lin hire_V2V = mkV2V (mkV "anställer") ; -- status=guess
lin hire_V2 = mkV2 (mkV "anställer") ; -- status=guess
lin cathedral_N = mkN "katedral" "katedraler" | mkN "domkyrka" ; -- SaldoWN -- comment=4
lin motive_N = mkN "skäl" neutrum; -- comment=6
lin correct_VS = mkVS (mkV "rätta") | mkVS (mkV "korrigerar"); -- status=guess, src=wikt status=guess, src=wikt
lin correct_V2 = dirV2 (partV (mkV "rättar")"till"); -- status=guess
lin correct_V = mkV "tillrättavisar" ; -- comment=8
lin gastric_A = mkA "gastrisk" ; -- status=guess
lin raid_N = mkN "räd" "räder" ; -- SaldoWN
lin comply_V2 = variants{}; -- mkV "lyda" "lydde" "lytt" ;
lin comply_V = mkV "lyda" "lydde" "lytt" ; -- status=guess
lin accommodate_V2 = mkV2 (mkV "förse" "försåg" "försett") | mkV2 (mkV "tillgodose" "tillgodosåg" "tillgodosett"); -- status=guess, src=wikt status=guess, src=wikt
lin accommodate_V = mkV "rymmer" ; -- comment=5
lin mutter_V2 = variants{}; -- mkV "muttrar" ; -- comment=3
lin mutter_V = mkV "muttrar" ; -- comment=3
lin induce_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till"); -- status=guess
lin trap_V2 = dirV2 (partV (mkV "lurar")"till"); -- comment=2
lin trap_V = mkV "snärja" "snärjde" "snärjt" ; -- comment=5
lin invasion_N = mkN "invasion" "invasioner" ; -- SaldoWN
lin humour_N = mkN "humör" neutrum; -- comment=3
lin bulk_N = mkN "omfång" neutrum; -- comment=4
lin traditionally_Adv = variants{} ; -- 
lin commission_V2V = variants{} ; -- 
lin commission_V2 = variants{} ; -- 
lin upstairs_Adv = variants{} ; -- 
lin translate_V2 = mkV2 (mkV "översätta" "översätter" "översätt" "översatte" "översatt" "översatt") ; -- status=guess
lin translate_V = mkV "översätta" "översätter" "översätt" "översatte" "översatt" "översatt" ; -- status=guess
lin rhythm_N = mkN "rytm" "rytmer" ; -- SaldoWN
lin emission_N = mkN "utgivning" ; -- comment=3
lin collective_A = mkA "kollektiv" ; -- comment=3
lin transformation_N = mkN "omvandling" ; -- comment=3
lin battery_N = mkN "misshandel" | mkN "batteri" "batterit" "batterier" "batterierna" ; -- SaldoWN -- comment=9
lin stimulus_N = mkN "stimulans" "stimulanser" ; -- comment=4
lin naked_A = mkA "naken" "naket" ; -- comment=5
lin white_N = mkN "vita" ; -- SaldoWN
lin menu_N = mkN "meny" "menyer" ; -- SaldoWN
lin toilet_N = mkN "toalett" "toaletter" ; -- comment=2
lin butter_N = L.butter_N ;
lin surprise_V2V = mkV2V (mkV "överraska"); -- status=guess, src=wikt
lin surprise_V2 = mkV2 (mkV "överraska"); -- status=guess, src=wikt
lin needle_N = mkN "nål" | mkN "sticka" ; -- SaldoWN -- comment=11
lin effectiveness_N = mkN "effektivitet" "effektiviteter" ; -- comment=2
lin accordance_N = mkN "enlighet" | mkN "överensstämmelse" ; -- status=guess status=guess
lin molecule_N = mkN "molekyl" "molekyler" ; -- SaldoWN
lin fiction_N = mkN "skönlitteratur" "skönlitteraturer" ; -- status=guess
lin learning_N = mkN "lärdom" ; -- comment=2
lin statute_N = variants{} ; -- 
lin reluctant_A = mkA "motvillig" ; -- comment=2
lin overlook_V2 = mkV2 "förbise" "förbisåg" "förbisett" | mkV2 (mkV (mkV "ha") "överseende med") ; -- SaldoWN -- status=guess, src=wikt
lin junction_N = mkN "järnvägsknut" | mkN "knutpunkt" "knutpunkter" ; -- SaldoWN -- comment=2
lin necessity_N = mkN "nödvändighet" "nödvändigheter" ; -- comment=3
lin nearby_A = mkA "närbelägen" "närbeläget" ; -- status=guess
lin experienced_A = mkA "erfaren" "erfaret" ; -- SaldoWN
lin lorry_N = mkN "lastbil" ; -- comment=2
lin exclusive_A = mkA "exklusiv" | compoundA (regA "odelad") ; -- SaldoWN -- comment=10
lin graphics_N = mkN "grafik" ; -- SaldoWN
lin stimulate_V2 = mkV2 "stimulera" | mkV2 (mkV (mkV "pigga") "upp") ; -- status=guess
lin warmth_N = mkN "värme" ; -- comment=2
lin therapy_N = mkN "terapi" "terapier" ; -- SaldoWN
lin convenient_A = mkA "bekväm" | mkA "lätthanterlig" ; -- SaldoWN -- comment=7
lin cinema_N = mkN "biograf" "biografer" ; -- SaldoWN
lin domain_N = mkN "domän" "domäner" ; -- comment=6
lin tournament_N = mkN "turnering" ; -- SaldoWN
lin doctrine_N = mkN "doktrin" "doktriner" ; -- status=guess
lin sheer_A = variants{} ; -- 
lin proposition_N = mkN "sats" "satser" | mkN "förslag" neutrum ; -- SaldoWN -- comment=2
lin grip_N = mkN "väggrepp" neutrum | mkN "scenarbetare" utrum ; -- SaldoWN -- comment=8
lin widow_N = mkN "änka" ; -- SaldoWN
lin discrimination_N = mkN "diskriminering" | mkN "omdöme" ; -- SaldoWN -- comment=3
lin bloody_Adv = mkAdv "jävligt" ; -- comment=2
lin ruling_A = variants{} ; -- 
lin fit_N = mkN "konvulsion" "konvulsioner" | mkN "passform" ; -- SaldoWN -- comment=8
lin nonetheless_Adv = variants{} ; -- 
lin myth_N = mkN "myt" "myter" | mkN "mytologi" "mytologier" ; -- SaldoWN -- comment=6
lin episode_N = mkN "avsnitt" neutrum | mkN "episod" "episoder" ; -- status=guess
lin drift_V2 = mkV2 "driva" "drev" "drivit" ; -- SaldoWN
lin drift_V = mkV "driva" "drev" "drivit" ; -- SaldoWN
lin assert_VS = variants{}; -- mkV "kräver" ; -- comment=5
lin assert_V2 = variants{}; -- mkV "kräver" ; -- comment=5
lin assert_V = mkV "kräver" ; -- comment=5
lin terrace_N = mkN "altan" "altaner" | mkN "terrass" "terrasser" ; -- SaldoWN -- comment=4
lin uncertain_A = mkA "oviss" ; -- comment=2
lin twist_V2 = mkV2 "vrida" "vred" "vridit" | dirV2 (partV (mkV "skruvar")"till") ; -- SaldoWN -- comment=6
lin insight_N = mkN "insikt" "insikter" ; -- SaldoWN
lin undermine_V2 = mkV2 (mkV "underminerar"); -- status=guess, src=wikt
lin tragedy_N = mkN "tragedi" "tragedier" | mkN "tragik" ; -- SaldoWN -- comment=2
lin enforce_V2 = variants{} ; -- 
lin criticize_V2 = variants{}; -- mkV "kritiserar" ; -- comment=6
lin criticize_V = mkV "kritiserar" ; -- comment=6
lin march_V2 = dirV2 (partV (mkV "marscherar")"ut"); -- comment=7
lin march_V = mkV "marscherar" ; -- comment=6
lin leaflet_N = mkN "broschyr" "broschyrer" | mkN "flygblad" neutrum ; -- SaldoWN -- comment=4
lin fellow_A = variants{} ; -- 
lin object_V2 = mkV2 (mkV "invänder") | mkV2 (reflV (mkV "motsätta" "motsatte" "motsatt")) | mkV2 (mkV "protesterar") ; -- status=guess
lin object_V = mkV "protesterar" ; -- status=guess
lin pond_N = mkN "damm" neutrum; -- comment=4
lin adventure_N = mkN "vågspel" "vågspelet" "vågspel" "vågspelen" | mkN "äventyr" neutrum ; -- SaldoWN -- comment=5
lin diplomatic_A = mkA "diplomatisk" ; -- SaldoWN = mkA "diplomatisk" ;
lin mixed_A = variants{} ; -- 
lin rebel_N = mkN "rebell" "rebeller" | mkN "tredska" ; -- SaldoWN -- comment=3
lin equity_N = mkN "stamaktie" "stamaktier" ; -- comment=3
lin literally_Adv = variants{} ; -- 
lin magnificent_A = mkA "pampig" ; -- comment=8
lin loyalty_N = mkN "lojalitet" "lojaliteter" ; -- SaldoWN
lin tremendous_A = mkA "kolossal" ; -- comment=3
lin airline_N = mkN "flyg" neutrum | mkN "flygbolag" neutrum ; -- SaldoWN = mkN "flyg" neutrum ;
lin shore_N = mkN "kust" "kuster" ; -- comment=5
lin restoration_N = mkN "restaurering" ; -- SaldoWN
lin physically_Adv = variants{} ; -- 
lin render_V2 = variants{} ; -- 
lin institutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (mkV "understryka" "underströk" "understrukit"); -- status=guess
lin emphasize_V2 = mkV2 (mkV "understryka" "underströk" "understrukit"); -- status=guess
lin mess_N = mkN "sörja" ; -- comment=14
lin commander_N = mkN "kommendörkapten" "kommendörkaptener" ; -- comment=4
lin straightforward_A = mkA "rättfram" "rättframt" "rättframma" "rättframma" "rättframmare" "rättframmast" "rättframmaste" ; -- status=guess
lin singer_N = mkN "sångare" utrum | mkN "sångare" utrum ; -- status=guess
lin squeeze_V2 = L.squeeze_V2;
lin squeeze_V = mkV "pressar" ; -- comment=8
lin full_time_A = variants{} ; -- 
lin breed_V2 = mkV2 (mkV "avlar"); -- status=guess, src=wikt
lin breed_V = mkV "uppstå" "uppstår" "uppstå" "uppstod" "uppstått" "uppstånden" ; -- comment=15
lin successor_N = mkN "efterträdare" utrum; -- comment=2
lin triumph_N = mkN "triumf" "triumfer" ; -- comment=2
lin heading_N = mkN "rubrik" "rubriker" ; -- comment=9
lin mathematics_N = mkN "matematik" ; -- SaldoWN
lin laugh_N = mkN "skämt" neutrum; -- comment=4
lin clue_N = mkN "ledtråd" ; -- SaldoWN
lin still_A = mkA "stilla" ; -- SaldoWN
lin ease_N = mkN "lätthet" ; -- comment=4
lin specially_Adv = variants{} ; -- 
lin biological_A = mkA "biologisk" ; -- status=guess
lin forgive_V2 = mkV2 (mkV "förlåta"); -- status=guess, src=wikt
lin forgive_V = mkV "förlåta" "förlät" "förlåtit" ; -- status=guess
lin trustee_N = mkN "förvaltare" utrum | mkN "förmyndare" utrum ; -- SaldoWN -- comment=3
lin photo_N = mkN "foto" "fotot" "foton" "fotona" ; -- comment=3
lin fraction_N = mkN "bråkdel" "bråkdelen" "bråkdelar" "bråkdelarna" | mkN "bråk" neutrum ; -- SaldoWN -- comment=7
lin chase_V2 = dirV2 (partV (mkV "rusar")"ut"); -- comment=3
lin chase_V = mkV "söker" ; -- comment=6
lin whereby_Adv = mkAdv "varmed" ; -- status=guess
lin mud_N = mkN "gyttja" ; -- SaldoWN
lin pensioner_N = mkN "pensionär" "pensionärer" ; -- SaldoWN
lin functional_A = mkA "funktionell" ; -- SaldoWN
lin copy_V2 = mkV2 (mkV "härma"); -- status=guess, src=wikt
lin copy_V = mkV "kopierar" ; -- comment=7
lin strictly_Adv = variants{} ; -- 
lin desperately_Adv = variants{} ; -- 
lin await_V2 = dirV2 (partV (mkV "väntar")"ut"); -- status=guess
lin coverage_N = mkN "försäkringsskydd" neutrum | mkN "täckning" ; -- SaldoWN -- comment=5
lin wildlife_N = mkN "djurliv" neutrum | (mkN "vilt" neutrum) | (mkN "natur") | (mkN "fauna") | (mkN "flora") ; -- SaldoWN -- status=guess status=guess status=guess status=guess
lin indicator_N = mkN "mätare" utrum; -- comment=2
lin lightly_Adv = variants{} ; -- 
lin hierarchy_N = mkN "hierarki" "hierarkier" ; -- SaldoWN
lin evolve_V2 = variants{}; -- mkV "utvecklar" ;
lin evolve_V = mkV "utvecklar" ; -- status=guess
lin mechanical_A = mkA "mekanisk" ; -- SaldoWN
lin expert_A = mkA "sakkunnig" ; -- comment=4
lin creditor_N = mkN "borgenär" "borgenärer" ; -- SaldoWN
lin capitalist_N = mkN "kapitalist" "kapitalister" ; -- status=guess
lin essence_N = mkN "parfym" "parfymer" | mkN "väsen" neutrum ; -- SaldoWN -- comment=10
lin compose_V2 = dirV2 (partV (mkV "ordnar") "om"); -- status=guess
lin compose_V = mkV "utgöra" "utgjorde" "utgjort" ; -- comment=10
lin mentally_Adv = variants{} ; -- 
lin gaze_N = mkN "blick" ; -- SaldoWN
lin seminar_N = mkN "seminarium" "seminariumet" "seminarier" "seminarierna" ; -- SaldoWN
lin target_V2V = variants{} ; -- 
lin target_V2 = variants{} ; -- 
lin label_V3 = mkV3 (mkV "betecknar") | mkV3 (mkV "etiketterar"); -- status=guess, src=wikt status=guess, src=wikt
lin label_V2 = mkV2 (mkV "betecknar") | mkV2 (mkV "etiketterar"); -- status=guess, src=wikt status=guess, src=wikt
lin label_V = mkV "etiketterar" ; -- comment=3
lin fig_N = mkN "fikon" neutrum | mkN "fikon" neutrum ; -- SaldoWN
lin continent_N = mkN "kontinent" "kontinenter" ; -- comment=3
lin chap_N = mkN "skreva" | mkN "spricka" ; -- SaldoWN -- comment=5
lin flexibility_N = mkN "flexibilitet" ; -- comment=3
lin verse_N = mkN "vers" ; -- comment=2
lin minute_A = mkA "minimal" ; -- comment=2
lin whisky_N = variants{} ; -- 
lin equivalent_A = mkA "motsvarande" ; -- comment=3
lin recruit_V2 = variants{}; -- mkV "värvar" ; -- comment=2
lin recruit_V = mkV "värvar" ; -- comment=2
lin echo_V2 = mkV2 (mkV "ekar"); -- status=guess, src=wikt
lin echo_V = mkV "upprepar" ; -- comment=6
lin unfair_A = mkA "ojust" "ojust" | mkA "orättvis" ; -- SaldoWN -- comment=2
lin launch_N = mkN "motorbåt" ; -- comment=3
lin cupboard_N = mkN "skåp" neutrum ; -- SaldoWN -- comment=3
lin bush_N = mkN "buske" utrum | mkN "rävsvans" ; -- SaldoWN -- comment=7
lin shortage_N = mkN "svält" | mkN "brist" "brister" ; -- SaldoWN -- comment=3
lin prominent_A = mkA "prominent" "prominent" ; -- status=guess
lin merger_N = mkN "fusion" ; -- comment=4
lin command_V2 = variants{}; -- mkV "behärskar" ; -- comment=15
lin command_V = mkV "behärskar" ; -- comment=15
lin subtle_A = mkA "vaken" "vaket" ; -- comment=9
lin capital_A = mkA "ypperlig" ; -- comment=6
lin gang_N = mkN "gäng" neutrum; -- comment=4
lin fish_V2 = mkV2 (mkV "fiskar"); -- status=guess, src=wikt
lin fish_V = mkV "fiskar" ; -- comment=2
lin unhappy_A = mkA "olycklig" ; -- comment=5
lin lifetime_N = mkN "livstid" ; -- SaldoWN
lin elite_N = mkN "elit" "eliter" ; -- SaldoWN
lin refusal_N = mkN "avslag" neutrum; -- comment=2
lin finish_N = mkN "slut" neutrum; -- comment=15
lin aggressive_A = mkA "aggressiv" | mkA "energisk" ; -- SaldoWN -- comment=6
lin superior_A = mkA "överlägsen" "överlägset" ; -- SaldoWN
lin landing_N = mkN "avsats" "avsatser" ; -- comment=3
lin exchange_V2 = dirV2 (partV (mkV "växlar")"in"); -- comment=2
lin debate_V2 = dirV2 (partV (mkV "funderar")"ut"); -- status=guess
lin debate_V = mkV "funderar" ; -- comment=8
lin educate_V2 = mkV2 (mkV "utbildar"); -- status=guess, src=wikt
lin separation_N = mkN "separation" "separationer" | mkN "skilsmässa" ; -- SaldoWN -- comment=2
lin productivity_N = mkN "produktivitet" "produktiviteter" ; -- status=guess
lin initiate_V2 = mkV2 (mkV "initierar"); -- status=guess, src=wikt
lin probability_N = mkN "sannolikhet" "sannolikheter" | mkN "trolighet" ; -- SaldoWN
lin virus_N = mkN "virus" neutrum | mkN "virus" neutrum ; -- SaldoWN
lin reporterMasc_N = variants{} ; -- 
lin fool_N = mkN "narr" ; -- SaldoWN
lin pop_V2 = mkV2 "smälla" "small" "smäll" ; -- SaldoWN
lin capitalism_N = mkN "kapitalism" "kapitalismer" ; -- SaldoWN
lin painful_A = mkA "plågsam" "plågsamt" "plågsamma" "plågsamma" "plågsammare" "plågsammast" "plågsammaste" | mkA "smärtsam" "smärtsamt" "smärtsamma" "smärtsamma" "smärtsammare" "smärtsammast" "smärtsammaste" ; -- SaldoWN -- comment=5
lin correctly_Adv = variants{} ; -- 
lin complex_N = mkN "komplex" neutrum; -- comment=3
lin rumour_N = mkN "rykte" ; -- SaldoWN
lin imperial_A = mkA "kejserlig" ; -- SaldoWN
lin justification_N = mkN "berättigande" ; -- SaldoWN
lin availability_N = mkN "tillgänglighet" ; -- comment=3
lin spectacular_A = mkA "spektakulär" ; -- comment=4
lin remain_N = variants{} ; -- 
lin ocean_N = mkN "ocean" "oceaner" | mkN "världshav" neutrum ; -- SaldoWN -- comment=3
lin cliff_N = mkN "klippa" | mkN "berg" neutrum ; -- SaldoWN -- comment=5
lin sociology_N = mkN "sociologi" ; -- SaldoWN
lin sadly_Adv = variants{} ; -- 
lin missile_N = mkN "projektil" "projektiler" ; -- SaldoWN
lin situate_V2 = variants{} ; -- 
lin artificial_A = mkA "artificiell" | mkA "konstgjord" "konstgjort" ; -- SaldoWN -- comment=5
lin apartment_N = L.apartment_N;
lin provoke_V2 = mkV2 (mkV "provocerar"); -- status=guess, src=wikt
lin oral_A = mkA "muntlig" ; -- SaldoWN
lin maximum_N = mkN "maximum" neutrum | mkN "maximum" neutrum ; -- SaldoWN
lin angel_N = mkN "ängel" ; -- SaldoWN
lin spare_A = mkA "ledig" ; -- status=guess
lin shame_N = mkN "vanära" | mkN "skamsenhet" ; -- SaldoWN -- comment=2
lin intelligent_A = mkA "intelligent" "intelligent" ; -- SaldoWN
lin discretion_N = mkN "handlingsfrihet" "handlingsfriheter" ; -- comment=8
lin businessman_N = mkN "affärsman" "affärsmannen" "affärsmän" "affärsmännen" ; -- SaldoWN
lin explicit_A = mkA "explicit" "explicit" | mkA "tydlig" ; -- SaldoWN -- comment=10
lin book_V2 = mkV2 (mkV "bokar"); -- status=guess, src=wikt
lin uniform_N = mkN "uniform" "uniformer" ; -- SaldoWN
lin push_N = mkN "leda" ; -- comment=16
lin counter_N = mkN "disk" | mkN "räknare" utrum ; -- SaldoWN -- comment=5
lin subject_A = mkA "underlydande" ; -- comment=3
lin objective_A = mkA "saklig" ; -- SaldoWN
lin hungry_A = mkA "hungrig" ; -- SaldoWN
lin clothing_N = mkN "klädsel" ; -- comment=3
lin ride_N = mkN "ritt" "ritter" ; -- comment=2
lin romantic_A = mkA "romantisk" ; -- SaldoWN
lin attendance_N = mkN "närvaro" ; -- comment=9
lin part_time_A = variants{} ; -- 
lin trace_N = mkN "spår" neutrum | mkN "spår" neutrum ; -- SaldoWN -- comment=10
lin backing_N = mkN "baksida" ; -- comment=9
lin sensation_N = mkN "sensation" "sensationer" ; -- SaldoWN
lin carrier_N = mkN "brevbärare" utrum | mkN "väska" ; -- SaldoWN -- comment=9
lin interest_V2 = mkV2 (mkV "intresserar"); -- status=guess, src=wikt
lin interest_V = mkV "intresserar" ; -- comment=3
lin classification_N = mkN "klassificering" ; -- comment=2
lin classic_N = mkN "ren" "renen" "renar" "renarna" ; -- comment=4
lin beg_V2 = mkV2 (mkV "tigger"); -- status=guess, src=wikt
lin beg_V = mkV "tigger" ; -- comment=3
lin appendix_N = mkN "blindtarm" | mkN "bilaga" ; -- SaldoWN -- comment=4
lin doorway_N = mkN "dörröppning" ; -- comment=2
lin density_N = mkN "densitet" "densiteter" | mkN "täthet" ; -- status=guess
lin working_class_A = variants{} ; -- 
lin legislative_A = mkA "legislativ" ; -- SaldoWN
lin hint_N = mkN "vink" ; -- comment=6
lin shower_N = mkN "skur" | mkN "dusch" ; -- SaldoWN
lin current_N = mkN "ström" "strömmen" "strömmar" "strömmarna" | mkN "rådande" ; -- SaldoWN -- comment=10
lin succession_N = mkN "tronföljd" "tronföljder" ; -- comment=6
lin nasty_A = mkA "svår" ; -- comment=19
lin duration_N = mkN "varaktighet" "varaktigheter" ; -- SaldoWN
lin desert_N = mkN "öken" ; -- SaldoWN
lin receipt_N = mkN "kvitto" "kvittot" "kvitton" "kvittona" | mkN "mottagande" ; -- SaldoWN -- comment=6
lin native_A = mkA "infödd" ; -- status=guess
lin chapel_N = mkN "kapell" neutrum; -- comment=5
lin amazing_A = mkA "fantastisk" ; -- status=guess
lin hopefully_Adv = variants{} ; -- 
lin fleet_N = mkN "flotta" ; -- SaldoWN
lin comparable_A = mkA "jämförbar" | mkA "likvärdig" ; -- SaldoWN -- comment=3
lin oxygen_N = mkN "syre" ; -- SaldoWN
lin installation_N = mkN "installation" "installationer" ; -- status=guess
lin developer_N = mkN "exploatör" "exploatörer" ; -- status=guess
lin disadvantage_N = mkN "nackdel" "nackdelen" "nackdelar" "nackdelarna" ; -- SaldoWN
lin recipe_N = mkN "recept" neutrum; -- status=guess
lin crystal_N = mkN "kristall" "kristaller" ; -- SaldoWN
lin modification_N = mkN "modifiering" ; -- comment=2
lin schedule_V2V = mkV2V (mkV "inplanera"); -- status=guess, src=wikt
lin schedule_V2 = dirV2 (partV (mkV "listar")"ut"); -- status=guess
lin schedule_V = mkV "listar" ; -- comment=2
lin midnight_N = mkN "midnatt" ; -- SaldoWN
lin successive_A = mkA "successiv" ; -- status=guess
lin formerly_Adv = mkAdv "förr" ; -- status=guess
lin loud_A = mkA "högljudd" | mkA "hög" "högre" "högst" ; -- SaldoWN -- comment=7
lin value_V2 = mkV2 (mkV "värdera"); -- status=guess, src=wikt
lin value_V = mkV "värderar" ; -- comment=3
lin physics_N = mkN "fysik" ; -- SaldoWN
lin truck_N = mkN "truck" ; -- SaldoWN
lin stroke_N = mkN "stroke" "stroket" "stroke" "stroken" | mkN "årtag" neutrum ; -- SaldoWN = mkN "stroke" "stroken" "strokes" "strokesen" ; -- comment=35
lin kiss_N = mkN "kyss" ; -- comment=2
lin envelope_N = mkN "kuvert" neutrum ; -- SaldoWN -- comment=5
lin speculation_N = mkN "spekulation" "spekulationer" ; -- status=guess
lin canal_N = mkN "kanal" "kanaler" ; -- status=guess
lin unionist_N = variants{} ; -- 
lin directory_N = mkN "register" neutrum ; -- SaldoWN -- comment=3
lin receiver_N = mkN "mottagare" utrum; -- comment=2
lin isolation_N = mkN "isolering" ; -- SaldoWN
lin fade_V2 = dirV2 (partV (mkV "tynar")"av"); -- status=guess
lin fade_V = mkV "bleknar" ; -- comment=6
lin chemistry_N = mkN "kemi" ; -- SaldoWN
lin unnecessary_A = mkA "onödig" ; -- SaldoWN
lin hit_N = mkN "slå" | mkN "mord" neutrum ; -- SaldoWN -- comment=13
lin defenderMasc_N = variants{} ; -- 
lin stance_N = mkN "hållning" ; -- status=guess
lin sin_N = mkN "synd" "synder" ; -- SaldoWN
lin realistic_A = mkA "realistisk" ; -- SaldoWN
lin socialist_N = mkN "socialist" "socialister" ; -- SaldoWN
lin subsidy_N = mkN "subvention" "subventioner" ; -- comment=4
lin content_A = mkA "nöjd" "nöjt" ; -- SaldoWN
lin toy_N = mkN "leksak" "leksaker" ; -- SaldoWN
lin darling_N = mkN "älskling" ; -- comment=2
lin decent_A = mkA "anständig" ; -- comment=13
lin liberty_N = mkN "frihet" "friheter" ; -- SaldoWN
lin forever_Adv = mkAdv "alltid" ; -- status=guess
lin skirt_N = mkN "kjol" | mkN "skört" neutrum ; -- SaldoWN -- comment=5
lin coordinate_V2 = mkV2 (mkV "koordinerar"); -- status=guess, src=wikt
lin coordinate_V = mkV "koordinerar" ; -- comment=2
lin tactic_N = mkN "taktik" "taktiker" ; -- SaldoWN
lin influential_A = mkA "inflytelserik" ; -- SaldoWN
lin import_V2 = mkV2 (mkV "importerar") ; -- status=guess
lin accent_N = mkN "accent" "accenter" | mkN "tonvikt" ; -- SaldoWN -- comment=8
lin compound_N = mkN "förening" | mkN "sammansättning" ; -- SaldoWN -- comment=3
lin bastard_N = mkN "bastard" "bastarder" ; -- comment=8
lin ingredient_N = mkN "ingrediens" "ingredienser" ; -- SaldoWN
lin dull_A = L.dull_A ;
lin cater_V = variants{} ; -- 
lin scholar_N = mkN "vetenskapsman" "vetenskapsmannen" "vetenskapsmän" "vetenskapsmännen" ; -- SaldoWN
lin faint_A = mkA "svag" ; -- comment=7
lin ghost_N = mkN "spökskrivare" utrum ; -- SaldoWN -- comment=6
lin sculpture_N = mkN "skulptur" "skulpturer" ; -- SaldoWN
lin ridiculous_A = mkA "absurd" "absurt" ; -- comment=4
lin diagnosis_N = mkN "diagnos" "diagnoser" ; -- SaldoWN
lin delegate_N = mkN "delegat" "delegater" ; -- SaldoWN
lin neat_A = mkA "fyndig" ; -- comment=21
lin kit_N = mkN "utrustning" | mkN "ämbar" neutrum ; -- SaldoWN -- comment=21
lin lion_N = mkN "lejon" neutrum | mkN "lejon" neutrum ; -- SaldoWN
lin dialogue_N = mkN "dialog" "dialoger" ; -- SaldoWN
lin repair_V2 = mkV2 (mkV "reparerar"); -- status=guess, src=wikt
lin repair_V = mkV "tillhålla" "tillhöll" "tillhållit" ; -- comment=8
lin tray_N = mkN "bricka" ; -- SaldoWN
lin fantasy_N = mkN "fantasi" "fantasier" | mkN "fantasibild" "fantasibilder" ; -- SaldoWN -- comment=2
lin leave_N = mkN "permission" "permissioner" | mkN "resa" ; -- SaldoWN -- comment=15
lin export_V2 = mkV2 (mkV "exporterar"); -- status=guess, src=wikt
lin export_V = mkV "exporterar" ; -- status=guess
lin forth_Adv = mkAdv "framåt" ; -- comment=4
lin lamp_N = L.lamp_N ;
lin allege_VS = mkV "förege" "föreger" "förege" "föregav" "föregett" "föregiven" | mkVS (mkV "påstå" "påstod" "påstått") ; -- status=guess
lin allege_V2 = mkV2 "förege" "föreger" "förege" "föregav" "föregett" "föregiven" | mkV2 (mkV "påstå" "påstod" "påstått") ; -- status=guess
lin pavement_N = mkN "trottoar" "trottoarer" ; -- SaldoWN
lin brand_N = mkN "märke" | mkN "svärd" neutrum ; -- SaldoWN -- comment=7
lin constable_N = mkN "ståthållare" utrum; -- comment=4
lin compromise_N = mkN "kompromiss" "kompromisser" | mkN "äventyrande" ; -- SaldoWN -- comment=3
lin flag_N = mkN "flagga" | mkN "stenhäll" ; -- SaldoWN -- comment=8
lin filter_N = mkN "filter" neutrum | mkN "sil" ; -- SaldoWN -- comment=2
lin reign_N = mkN "styre" | mkN "regering" ; -- SaldoWN = mkN "styre" ; -- status=guess
lin execute_V2 = dirV2 (partV (mkV "spelar")"in"); -- status=guess
lin pity_N = mkN "medlidande" | mkN "skada" ; -- SaldoWN -- comment=4
lin merit_N = mkN "förtjänst" "förtjänster" ; -- SaldoWN
lin diagram_N = mkN "diagram" "diagrammet" "diagram" "diagrammen" ; -- SaldoWN
lin wool_N = mkN "ylle" | mkN "ull" ; -- SaldoWN -- comment=3
lin organism_N = mkN "organism" "organismer" ; -- status=guess
lin elegant_A = mkA "elegant" "elegant" | mkA "fyndig" ; -- status=guess
lin red_N = mkN "rodnad" "rodnader" | mkN "röd" | mkN "rött" ; -- SaldoWN -- status=guess status=guess
lin undertaking_N = mkN "åtagande" ; -- comment=8
lin lesser_A = variants{} ; -- 
lin reach_N = mkN "sträcka" ; -- comment=13
lin marvellous_A = mkA "underbar" ; -- status=guess
lin improved_A = variants{} ; -- 
lin locally_Adv = variants{} ; -- 
lin entity_N = variants{} ; -- 
lin rape_N = mkN "våldtäkt" "våldtäkter" ; -- comment=5
lin secure_A = mkA "trygg" ; -- comment=4
lin descend_V2 = variants{}; -- mkV "nedstiga" "nedsteg" "nedstigit" ; -- comment=4
lin descend_V = mkV "nedstiga" "nedsteg" "nedstigit" ; -- comment=4
lin backwards_Adv = mkAdv "baklänges" ; -- comment=5
lin peer_V = mkV "kisar" ; -- comment=3
lin excuse_V2 = mkV2 (mkV "ursäkta") | mkV2 (mkV "urskuldra"); -- status=guess, src=wikt status=guess, src=wikt
lin genetic_A = mkA "genetisk" ; -- SaldoWN
lin fold_V2 = mkV2 "vika" "vek" "vikit" | mkV2 (mkV "vika" "vek" "vikit") ; -- SaldoWN -- status=guess, src=wikt
lin fold_V = mkV "vika" "vek" "vikit" ; -- SaldoWN
lin portfolio_N = mkN "portfölj" "portföljer" ; -- comment=4
lin consensus_N = mkN "consensus" | mkN "enighet" "enigheter" ; -- SaldoWN -- comment=2
lin thesis_N = mkN "avhandling" ; -- SaldoWN
lin shop_V = mkV "handlar" ; -- comment=3
lin nest_N = mkN "bo" "bot" "bon" "boen" | mkN "sats" "satser" ; -- SaldoWN -- comment=6
lin frown_V = mkV (mkV "rynka") "pannan" ; -- status=guess, src=wikt
lin builder_N = mkN "byggare" utrum; -- comment=2
lin administer_V2 = mkV2 (mkV "administrerar"); -- status=guess, src=wikt
lin administer_V = mkV "sköter" ; -- comment=10
lin tip_V2 = mkV2 (mkV "tippar"); -- status=guess, src=wikt
lin tip_V = mkV "ändar" ; -- comment=9
lin lung_N = mkN "lunga" ; -- SaldoWN
lin delegation_N = mkN "delegering" ; -- comment=7
lin outside_N = mkN "utsida" | mkN "yttre" ; -- SaldoWN -- comment=4
lin heating_N = mkN "upphettning" ; -- comment=5
lin like_Subj = variants{} ; -- 
lin instinct_N = mkN "instinkt" "instinkter" ; -- SaldoWN
lin teenager_N = mkN "tonåring" ; -- SaldoWN
lin lonely_A = mkA "ensam" "ensamt" "ensamma" "ensamma" "ensammare" "ensammast" "ensammaste" | mkA "övergiven" "övergivet" ; -- SaldoWN -- comment=6
lin residence_N = mkN "residens" neutrum | mkN "uppehåll" neutrum ; -- SaldoWN -- comment=4
lin radiation_N = mkN "strålning" ; -- SaldoWN
lin extract_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin concession_N = mkN "eftergift" "eftergifter" | mkN "förmån" "förmåner" ; -- SaldoWN -- comment=5
lin autonomy_N = mkN "självständighet" "självständigheter" | mkN "autonomi" ; -- SaldoWN -- comment=2
lin norm_N = mkN "norm" "normer" ; -- SaldoWN
lin musicianMasc_N = mkN "musiker" "musikern" "musiker" "musikerna" ; -- status=guess
lin graduate_N = mkN "alumn" "alumner" | mkN "akademiker" "akademikern" "akademiker" "akademikerna" ; -- SaldoWN -- comment=2
lin glory_N = mkN "ära" ; -- SaldoWN
lin bear_N = mkN "björn" | mkN "vila" ; -- SaldoWN -- comment=6
lin persist_V = mkV "framhärdar" ; -- comment=4
lin rescue_V2 = mkV2 (mkV "rädda"); -- status=guess, src=wikt
lin equip_V2 = mkV2 (mkV "utrustar"); -- status=guess, src=wikt
lin partial_A = mkA "partisk" ; -- status=guess
lin officially_Adv = mkAdv "officiellt" ; -- status=guess
lin capability_N = mkN "kompetens" "kompetenser" ; -- comment=3
lin worry_N = mkN "bekymmer" "bekymmer" ; -- comment=5
lin liberation_N = mkN "befrielse" "befrielser" ; -- comment=4
lin hunt_V2 = L.hunt_V2;
lin hunt_V = mkV "jagar" ; -- status=guess
lin daily_Adv = mkAdv "dagligen" ; -- status=guess
lin heel_N = mkN "häl" | mkN "slut" neutrum ; -- SaldoWN -- comment=7
lin contract_V2V = mkV2V (mkV (mkV "smittas") "av"); -- status=guess, src=wikt
lin contract_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till"); -- status=guess
lin contract_V = mkV "inskränker" ; -- comment=9
lin update_V2 = mkV2 (mkV "uppdaterar"); -- status=guess, src=wikt
lin assign_V2V = variants{} ; -- 
lin assign_V2 = variants{} ; -- 
lin spring_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin spring_V = mkV "hoppar" ; -- comment=3
lin single_N = mkN "singel" ; -- comment=2
lin commons_N = variants{} ; -- 
lin weekly_A = mkA "veckovis" ; -- status=guess
lin stretch_N = mkN "sträcka" ; -- status=guess
lin pregnancy_N = mkN "graviditet" "graviditeter" ; -- comment=3
lin happily_Adv = variants{} ; -- 
lin spectrum_N = mkN "spektrum" neutrum | mkN "spektrum" neutrum ; -- SaldoWN -- comment=2
lin interfere_V = mkV "inskrida" "inskred" "inskridit" ; -- comment=2
lin suicide_N = mkN "självmord" neutrum | mkN "självmord" neutrum ; -- SaldoWN
lin panic_N = mkN "panik" ; -- SaldoWN
lin invent_V2 = variants{}; -- mkV "uppfinna" "uppfann" "uppfunnit" ;
lin invent_V = mkV "uppfinna" "uppfann" "uppfunnit" ; -- status=guess
lin intensive_A = mkA "intensiv" ; -- status=guess
lin damp_A = mkA "fuktig" ; -- status=guess
lin simultaneously_Adv = variants{} ; -- 
lin giant_N = mkN "jätte" utrum ; -- SaldoWN -- comment=5
lin casual_A = mkA "tillfällig" ; -- comment=8
lin sphere_N = mkN "sfär" "sfärer" ; -- SaldoWN
lin precious_A = mkA "värdefull" ; -- comment=2
lin sword_N = mkN "svärd" neutrum | mkN "svärd" neutrum ; -- SaldoWN
lin envisage_V2 = variants{} ; -- 
lin bean_N = mkN "böna" ; -- SaldoWN
lin time_V2 = mkV2 (mkV "tajma") | mkV2 "tidsinställer" ; -- status=guess
lin crazy_A = mkA "galen" "galet" ; -- comment=8
lin changing_A = variants{} ; -- 
lin primary_N = (mkN "grundskola") | mkN "lågstadie" ; -- status=guess status=guess
lin concede_VS = mkV "medge" "medger" "medge" "medgav" "medgett" "medgiven" | mkVS (mkV "erkänna") ; -- status=guess
lin concede_V2 = mkV2 "medge" "medger" "medge" "medgav" "medgett" "medgiven" ; -- status=guess
lin concede_V = mkV "medge" "medger" "medge" "medgav" "medgett" "medgiven" ; -- SaldoWN
lin besides_Adv = mkAdv "förresten" ; -- comment=4
lin unite_V2 = dirV2 (partV (mkV "blandar")"ut"); -- comment=4
lin unite_V = mkV "förenar" ; -- comment=6
lin severely_Adv = variants{} ; -- 
lin separately_Adv = variants{} ; -- 
lin instruct_V2 = variants{} ; -- 
lin insert_V2 = variants{} ; -- 
lin go_N = mkN "tur" ; -- comment=12
lin exhibit_V2 = variants{} ; -- 
lin brave_A = mkA "modig" | mkA "utmärkt" "utmärkt" ; -- SaldoWN -- comment=7
lin tutor_N = mkN "handledare" utrum | mkN "privatlärare" utrum ; -- SaldoWN -- comment=3
lin tune_N = mkN "låt" | mkN "stämma" ; -- SaldoWN = mkN "låt" ; -- comment=7
lin debut_N = mkN "debut" "debuter" ; -- status=guess
lin debut_2_N = variants{} ; -- 
lin debut_1_N = mkN "debut" "debuter" ; -- status=guess
lin continued_A = variants{} ; -- 
lin bid_V2 = dirV2 (partV (mkV "hälsar")"på"); -- status=guess
lin bid_V = mkV "säga" "sade" "sagt" ; -- comment=5
lin incidence_N = mkN "förekomst" "förekomster" ; -- status=guess
lin downstairs_Adv = variants{} ; -- 
lin cafe_N = mkN "kafé" "kafét" "kaféer" "kaféerna" | mkN "café" "cafét" "caféer" "caféerna" ; -- SaldoWN -- comment=7
lin regret_VS = mkVS (mkV "beklagar") | mkVS (mkV "ångra"); -- status=guess, src=wikt status=guess, src=wikt
lin regret_V2 = mkV2 (mkV "beklagar") | mkV2 (mkV "ångra"); -- status=guess, src=wikt status=guess, src=wikt
lin killer_N = mkN "baneman" "banemannen" "banemän" "banemännen" | mkN "mördare" utrum ; -- SaldoWN -- comment=3
lin delicate_A = mkA "ömtålig" ; -- SaldoWN
lin subsidiary_N = mkN "dotterbolag" neutrum; -- comment=4
lin gender_N = mkN "genus" neutrum; -- comment=3
lin entertain_V2 = mkV2 (mkV "underhålla"); -- status=guess, src=wikt
lin cling_V = mkV "klibbar" ; -- status=guess
lin vertical_A = mkA "vertikal" ; -- SaldoWN
lin fetch_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin strip_V2 = mkV2 (mkV "strippar"); -- status=guess, src=wikt
lin strip_V = mkV "tömmer" ; -- comment=6
lin plead_VS = variants{}; -- dirV2 (partV (mkV "talar")"om");
lin plead_V2 = dirV2 (partV (mkV "talar")"om"); -- status=guess
lin plead_V = mkV "be" "bad" "bett" ; -- comment=9
lin duck_N = mkN "anka" | mkN "segelduk" ; -- SaldoWN -- comment=11
lin breed_N = mkN "sort" "sorter" ; -- comment=10
lin assistant_A = mkA "assisterande" | mkA "biträdande" ; -- status=guess
lin pint_N = mkN "öl" neutrum; -- comment=2
lin abolish_V2 = mkV2 (mkV "överge") | mkV2 (mkV "förkasta"); -- status=guess, src=wikt status=guess, src=wikt
lin translation_N = mkN "översättning" ; -- status=guess
lin princess_N = mkN "prinsessa" ; -- SaldoWN
lin line_V2 = dirV2 (partV (mkV "kantar")"av"); -- status=guess
lin line_V = mkV "kantar" ; -- comment=15
lin excessive_A = mkA "överdriven" "överdrivet" ; -- comment=5
lin digital_A = mkA "digital" | mkA "numerisk" ; -- status=guess
lin steep_A = mkA "brant" "brant" | mkA "orimlig" ; -- SaldoWN -- comment=9
lin jet_N = mkN "sprut" neutrum | mkN "stråle" utrum ; -- SaldoWN -- comment=8
lin hey_Interj = mkInterj "hej" | mkInterj "hallå" ; -- status=guess
lin grave_N = mkN "grav" ; -- SaldoWN
lin exceptional_A = mkA "exceptionell" ; -- comment=5
lin boost_V2 = dirV2 (partV (mkV "ökar")"till"); -- comment=2
lin random_A = mkA "planlös" | compoundA (regA "slumpartad") ; -- SaldoWN -- comment=2
lin correlation_N = mkN "korrelation" "korrelationer" ; -- SaldoWN
lin outline_N = mkN "skiss" "skisser" | mkN "utkast" neutrum ; -- SaldoWN -- comment=7
lin intervene_V2V = variants{}; -- mkV "ingripa" "ingrep" "ingripit" ; -- comment=3
lin intervene_V = mkV "ingripa" "ingrep" "ingripit" ; -- comment=3
lin packet_N = mkN "paket" neutrum | mkN "paket" neutrum ; -- SaldoWN -- comment=3
lin motivation_N = mkN "motivation" "motivationer" | mkN "motivering" ; -- SaldoWN -- comment=2
lin safely_Adv = variants{} ; -- 
lin harsh_A = mkA "skrovlig" | mkA "hård" "hårt" ; -- SaldoWN -- comment=17
lin spell_N = mkN "trollformel" "trollformeln" "trollformler" "trollformlerna" | mkN "tid" "tider" ; -- SaldoWN -- comment=4
lin spread_N = mkN "ranch" "rancher" | mkN "utbredning" ; -- SaldoWN -- comment=6
lin draw_N = mkN "skocka" ; -- comment=19
lin concrete_A = mkA "konkret" "konkret" ; -- SaldoWN
lin complicated_A = variants{} ; -- 
lin alleged_A = variants{} ; -- 
lin redundancy_N = mkN "redundans" ; -- SaldoWN
lin progressive_A = mkA "progressiv" ; -- SaldoWN
lin intensity_N = mkN "styrka" ; -- comment=2
lin crack_N = mkN "spricka" | mkN "spydighet" "spydigheter" ; -- SaldoWN -- comment=17
lin fly_N = mkN "fluga" | mkN "flagga" ; -- SaldoWN -- comment=6
lin fancy_V2 = variants{} ; -- 
lin alternatively_Adv = variants{} ; -- 
lin waiting_A = variants{} ; -- 
lin scandal_N = mkN "skandal" "skandaler" ; -- SaldoWN
lin resemble_V2 = mkV2 (mkV "liknar"); -- status=guess, src=wikt
lin parameter_N = mkN "parameter" ; -- SaldoWN
lin fierce_A = mkA "vild" "vilt" ; -- comment=10
lin tropical_A = mkA "tropisk" ; -- SaldoWN
lin colour_V2A = variants{}; -- mkV "färglägga" "färglade" "färglagt" ; -- comment=2
lin colour_V2 = variants{}; -- mkV "färglägga" "färglade" "färglagt" ; -- comment=2
lin colour_V = mkV "färglägga" "färglade" "färglagt" ; -- comment=2
lin engagement_N = mkN "förlovning" | mkN "överenskommelse" "överenskommelser" ; -- SaldoWN -- comment=12
lin contest_N = mkN "tävling" ; -- comment=5
lin edit_V2 = dirV2 (partV (mkV "redigerar")"om"); -- status=guess
lin courage_N = mkN "mod" neutrum | mkN "kurage" ; -- SaldoWN -- comment=2
lin hip_N = mkN "höft" "höfter" | mkN "nypon" neutrum ; -- SaldoWN -- comment=2
lin delighted_A = variants{} ; -- 
lin sponsor_V2 = mkV2 (mkV "sponsa") | mkV2 (mkV "sponsrar"); -- status=guess, src=wikt status=guess, src=wikt
lin carer_N = variants{} ; -- 
lin crack_V2 = mkV2 "spricka" "sprack" "spruckit" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN
lin substantially_Adv = variants{} ; -- 
lin occupational_A = mkA "sysselsättningsmässig" ; -- SaldoWN
lin trainer_N = mkN "tränare" utrum | mkN "tränare" utrum ; -- SaldoWN -- comment=3
lin remainder_N = mkN "rest" "rester" ; -- comment=2
lin related_A = variants{} ; -- 
lin inherit_V2 = mkV2 (mkV "ärva"); -- status=guess, src=wikt
lin inherit_V = mkV "ärver" ; -- status=guess
lin resume_V2 = mkV2 (mkV "återuppta" "återupptar" "återuppta" "återupptog" "återupptagit" "återupptagen") ; -- status=guess
lin resume_V = mkV "återuppta" "återupptar" "återuppta" "återupptog" "återupptagit" "återupptagen" ; -- status=guess
lin assignment_N = mkN "uppgift" "uppgifter" | mkN "tilldelning" ; -- SaldoWN -- comment=2
lin conceal_V2 = mkV2 (mkV "dölja" "dolde" "dolt"); -- status=guess, src=wikt
lin disclose_VS = variants{}; -- dirV2 (partV (mkV "visar")"in");
lin disclose_V2 = dirV2 (partV (mkV "visar")"in"); -- status=guess
lin disclose_V = mkV "visar" ; -- comment=6
lin exclusively_Adv = variants{} ; -- 
lin working_N = mkN "uträkning" ; -- comment=23
lin mild_A = mkA "mild" "milt" ; -- SaldoWN
lin chronic_A = mkA "kronisk" ; -- SaldoWN
lin splendid_A = mkA "finfin" ; -- comment=9
lin function_V = mkV "fungerar" ; -- status=guess
lin riderMasc_N = variants{} ; -- 
lin clay_N = mkN "lik" neutrum | mkN "lera" ; -- SaldoWN
lin firstly_Adv = variants{} ; -- 
lin conceive_V2 = variants{}; -- mkV "uppfattar" ; -- comment=4
lin conceive_V = mkV "uppfattar" ; -- comment=4
lin politically_Adv = variants{} ; -- 
lin terminal_N = mkN "terminal" "terminaler" ; -- SaldoWN
lin accuracy_N = mkN "exakthet" "exaktheter" ; -- status=guess
lin coup_N = mkN "kupp" "kupper" ; -- SaldoWN
lin ambulance_N = mkN "ambulans" "ambulanser" ; -- SaldoWN
lin living_N = mkN "livsuppehälle" ; -- comment=4
lin offenderMasc_N = variants{} ; -- 
lin similarity_N = mkN "likhet" "likheter" ; -- SaldoWN
lin orchestra_N = mkN "orkester" | mkN "orkestra" ; -- SaldoWN -- comment=3
lin brush_N = mkN "borste" utrum | mkN "sammandrabbning" ; -- SaldoWN -- comment=6
lin systematic_A = mkA "systematisk" ; -- SaldoWN
lin striker_N = mkN "strejkande" ; -- comment=4
lin guard_V2 = mkV2 (mkV "vaktar") | mkV2 (mkV "bevakar"); -- status=guess, src=wikt status=guess, src=wikt
lin guard_V = mkV "bevakar" ; -- comment=10
lin casualty_N = mkN "offer" neutrum | mkN "olycksfall" neutrum ; -- SaldoWN -- comment=2
lin steadily_Adv = variants{} ; -- 
lin painter_N = mkN "målare" utrum | mkN "målare" utrum ; -- SaldoWN
lin opt_VV = mkVV (mkV "välja" "valde" "valt"); -- status=guess, src=wikt
lin opt_V = mkV "välja" "valde" "valt" ; -- status=guess
lin handsome_A = mkA "ståtlig" ; -- comment=7
lin banking_N = mkN "bankrörelse" "bankrörelser" ; -- comment=4
lin sensitivity_N = mkN "sensitivitet" "sensitiviteter" | mkN "känslighet" "känsligheter" ; -- SaldoWN -- comment=2
lin navy_N = mkN "marin" "mariner" | mkN "flotta" ; -- SaldoWN -- comment=2
lin fascinating_A = variants{} ; -- 
lin disappointment_N = mkN "besvikelse" "besvikelser" ; -- SaldoWN
lin auditor_N = mkN "revisor" "revisorer" | mkN "åhörare" utrum ; -- SaldoWN -- comment=2
lin hostility_N = mkN "motsättning" | mkN "fientlighet" "fientligheter" ; -- SaldoWN -- status=guess
lin spending_N = mkN "utgift" "utgifter" ; -- status=guess
lin scarcely_Adv = variants{} ; -- 
lin compulsory_A = mkA "obligatorisk" ; -- comment=2
lin photographer_N = mkN "fotograf" "fotografer" ; -- SaldoWN
lin ok_Interj = mkInterj "okej" ; -- status=guess
lin neighbourhood_N = mkN "omgivning" | mkN "närhet" "närheter" ; -- SaldoWN -- comment=5
lin ideological_A = mkA "ideologisk" ; -- SaldoWN
lin wide_Adv = mkAdv "vid" ; -- comment=2
lin pardon_N = mkN "benådning" | mkN "förlåtelse" utrum ; -- SaldoWN -- comment=5
lin double_N = mkN "dubbelgångare" utrum | mkN "stand-in" "stand-iner" ; -- SaldoWN -- comment=8
lin criticize_V2 = variants{}; -- mkV "kritiserar" ; -- comment=6
lin criticize_V = mkV "kritiserar" ; -- comment=6
lin supervision_N = mkN "handledning" ; -- comment=9
lin guilt_N = mkN "skuld" "skulder" ; -- SaldoWN
lin deck_N = mkN "kortlek" | mkN "däck" neutrum ; -- SaldoWN -- comment=9
lin payable_A = mkA "betalbar" ; -- comment=5
lin execution_N = mkN "avrättning" | mkN "teknik" "tekniker" ; -- SaldoWN -- comment=9
lin suite_N = mkN "svit" "sviter" | mkN "uppsättning" ; -- SaldoWN -- comment=9
lin elected_A = variants{} ; -- 
lin solely_Adv = variants{} ; -- 
lin moral_N = mkN "sensmoral" "sensmoraler" ; -- SaldoWN
lin collector_N = mkN "samlare" utrum; -- status=guess
lin questionnaire_N = mkN "enkät" "enkäter" ; -- SaldoWN
lin flavour_N = mkN "smak" "smaker" | mkN "krydda" ; -- SaldoWN -- comment=8
lin couple_V2 = dirV2 (partV (mkV "kopplar")"ur"); -- comment=4
lin couple_V = mkV "parar" ; -- comment=4
lin faculty_N = mkN "fakultet" "fakulteter" ; -- comment=5
lin tour_V2 = variants{}; -- mkV "turistar" ; -- comment=3
lin tour_V = mkV "turistar" ; -- comment=3
lin basket_N = mkN "korg" ; -- SaldoWN
lin mention_N = mkN "omnämnande" ; -- status=guess
lin kick_N = mkN "kick" | mkN "bråka" ; -- SaldoWN -- comment=12
lin horizon_N = mkN "horisont" "horisonter" ; -- SaldoWN
lin drain_V2 = mkV2 "torrlägga" "torrlade" "torrlagt" | dirV2 (partV (mkV "filtrerar")"av") ; -- SaldoWN -- comment=6
lin drain_V = mkV "torrlägga" "torrlade" "torrlagt" | mkV "tömmer" ; -- SaldoWN -- comment=18
lin happiness_N = mkN "lycka" ; -- comment=3
lin fighter_N = mkN "kämpe" utrum; -- comment=5
lin estimated_A = variants{} ; -- 
lin copper_N = mkN "koppar" ; -- SaldoWN
lin legend_N = mkN "legend" "legender" | mkN "teckenförklaring" ; -- SaldoWN -- comment=5
lin relevance_N = mkN "relevans" ; -- SaldoWN
lin decorate_V2 = dirV2 (partV (mkV "pyntar")"till"); -- comment=5
lin continental_A = mkA "kontinental" ; -- SaldoWN
lin ship_V2 = mkV2 (mkV "skeppar") | mkV2 (mkV "fraktar"); -- status=guess, src=wikt status=guess, src=wikt
lin ship_V = mkV "skeppar" ; -- comment=2
lin operational_A = mkA "operationell" | mkA "funktionsduglig" ; -- SaldoWN -- comment=2
lin incur_V2 = mkV2 (mkV (mkV "utsätta" "utsatte" "utsatt") "sig för"); -- status=guess, src=wikt
lin parallel_A = mkA "parallell" ; -- SaldoWN
lin divorce_N = mkN "skilsmässa" ; -- SaldoWN
lin opposed_A = variants{} ; -- 
lin equilibrium_N = mkN "jämvikt" ; -- SaldoWN
lin trader_N = mkN "handlare" utrum; -- comment=3
lin ton_N = mkN "ton" "toner" | mkN "ton" "tonnet" "ton" "tonnen" ; -- SaldoWN = mkN "ton" "tonnet" "ton" "tonnen" ; -- comment=2
lin can_N = mkN "dunk" ; -- status=guess
lin juice_N = mkN "juice" "juicer" | mkN "saft" "safter" ; -- SaldoWN
lin forum_N = mkN "forum" neutrum ; -- SaldoWN
lin spin_V2 = mkV2 "vrida" "vred" "vridit" | dirV2 (partV (mkV "skruvar")"till") ; -- SaldoWN -- comment=6
lin spin_V = mkV "vrida" "vred" "vridit" | mkV "spinna" "spann" "spunnit" ; -- SaldoWN -- comment=3
lin research_V2 = dirV2 (partV (mkV "forskar")"igenom"); -- status=guess
lin research_V = mkV "forskar" ; -- status=guess
lin hostile_A = mkA "fientlig" | mkA "människofientlig" ; -- SaldoWN -- comment=2
lin consistently_Adv = variants{} ; -- 
lin technological_A = mkA "teknologisk" ; -- status=guess
lin nightmare_N = mkN "mardröm" "mardrömmen" "mardrömmar" "mardrömmarna" ; -- SaldoWN
lin medal_N = mkN "medalj" "medaljer" ; -- status=guess
lin diamond_N = mkN "diamant" "diamanter" | mkN "romb" "romber" ; -- SaldoWN -- comment=3
lin speed_V2 = mkV2 (mkV (mkV "kör") "för fort"); -- status=guess, src=wikt
lin speed_V = mkV "sprätta" "sprätter" "sprätt" "sprätte" "sprätt" "sprätt" ; -- comment=3
lin peaceful_A = mkA "fridfull" | mkA "fredlig" ; -- SaldoWN -- comment=3
lin accounting_A = variants{} ; -- 
lin scatter_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- status=guess
lin scatter_V = mkV "sprida" "spred" "spritt" ; -- comment=5
lin monster_N = mkN "monster" neutrum | mkN "odjur" neutrum ; -- SaldoWN -- comment=4
lin horrible_A = mkA "gräslig" ; -- comment=11
lin nonsense_N = mkN "nonsens" ; -- SaldoWN
lin chaos_N = mkN "kaos" neutrum ; -- SaldoWN
lin accessible_A = mkA "tillgänglig" ; -- SaldoWN
lin humanity_N = mkN "mänsklighet" "mänskligheter" ; -- SaldoWN
lin frustration_N = mkN "frustration" "frustrationer" ; -- SaldoWN
lin chin_N = mkN "haka" ; -- SaldoWN
lin bureau_N = mkN "ämbetsverk" neutrum; -- comment=5
lin advocate_VS = mkVS (mkV "plädera"); -- status=guess, src=wikt
lin advocate_V2 = mkV2 (mkV "plädera"); -- status=guess, src=wikt
lin polytechnic_N = variants{} ; -- 
lin inhabitant_N = mkN "invånare" utrum ; -- SaldoWN -- comment=3
lin evil_A = mkA "skadlig" ; -- comment=13
lin slave_N = mkN "slav" | mkN "slav" "slaver" ; -- SaldoWN = mkN "slav" "slaver" ; -- comment=2
lin reservation_N = mkN "reservation" "reservationer" ; -- comment=2
lin slam_V2 = mkV2 "smälla" "small" "smäll" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN
lin slam_V = mkV "smälla" "small" "smäll" ; -- SaldoWN
lin handle_N = mkN "vred" neutrum; -- comment=6
lin provincial_A = mkA "provinsiell" ; -- SaldoWN
lin fishing_N = mkN "fiske" ; -- status=guess
lin facilitate_V2 = mkV2 (mkV "underlätta") | mkV2 (mkV "förenkla"); -- status=guess, src=wikt status=guess, src=wikt
lin yield_N = mkN "avkastning" ; -- comment=7
lin elbow_N = mkN "armbåge" utrum | mkN "böj" ; -- SaldoWN -- comment=4
lin bye_Interj = mkInterj "hej då" | mkInterj "adjö" | mkInterj "farväl" ; -- status=guess
lin warm_V2 = dirV2 (partV (mkV "värmer")"på"); -- status=guess
lin warm_V = mkV "värmer" ; -- status=guess
lin sleeve_N = mkN "ärm" ; -- SaldoWN
lin exploration_N = mkN "expedition" "expeditioner" | mkN "utforskande" ; -- SaldoWN -- comment=2
lin creep_V = mkV "krypa" "kröp" "krupit" | mkV "krypköra" "krypkörde" "krypkört" ; -- SaldoWN -- comment=7
lin adjacent_A = mkA "angränsande" ; -- comment=2
lin theft_N = mkN "stöld" "stölder" ; -- SaldoWN
lin round_V2 = dirV2 (partV (mkV "rundar")"till"); -- comment=62
lin round_V = mkV "rundar" ; -- comment=5
lin grace_N = mkN "välvilja" | mkN "ynnest" ; -- SaldoWN -- comment=12
lin predecessor_N = mkN "företrädare" utrum | mkN "företrädare" utrum ; -- SaldoWN -- comment=2
lin supermarket_N = mkN "snabbköp" neutrum | mkN "snabbköpsbutik" "snabbköpsbutiker" ; -- SaldoWN
lin smart_A = mkA "smart" "smart" | mkA "snygg" ; -- SaldoWN -- comment=14
lin sergeant_N = mkN "sergeant" "sergeanter" ; -- status=guess
lin regulate_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin clash_N = mkN "sammandrabbning" | mkN "skramla" ; -- SaldoWN -- comment=8
lin assemble_V2 = mkV2 (mkV "assemblera"); -- status=guess, src=wikt
lin assemble_V = mkV "samlar" ; -- comment=6
lin arrow_N = mkN "pil" ; -- SaldoWN
lin nowadays_Adv = mkAdv "nuförtiden" ; -- status=guess
lin giant_A = variants{} ; -- 
lin waiting_N = variants{} ; -- 
lin tap_N = mkN "kran" | mkN "plugg" ; -- SaldoWN -- comment=8
lin shit_N = mkN "skit" ; -- status=guess
lin sandwich_N = mkN "sandwich" ; -- comment=2
lin vanish_V = mkV "försvinna" "försvann" "försvunnit" ; -- comment=2
lin commerce_N = mkN "handel" | mkN "umgänge" ; -- SaldoWN = mkN "handel" ; -- comment=4
lin pursuit_N = mkN "hobby" "hobbier" | mkN "jakt" "jakter" ; -- SaldoWN -- comment=5
lin post_war_A = variants{} ; -- 
lin will_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till"); -- status=guess
lin will_V = mkV "brukar" ; -- comment=5
lin waste_A = mkA "öde" ; -- comment=5
lin collar_N = mkN "krage" utrum ; -- SaldoWN -- comment=5
lin socialism_N = mkN "socialism" "socialismer" ; -- status=guess
lin skill_V = variants{} ; -- 
lin rice_N = mkN "ris" neutrum | mkN "ris" neutrum ; -- SaldoWN = mkN "ris" neutrum ; -- comment=3
lin exclusion_N = mkN "uteslutning" ; -- comment=2
lin upwards_Adv = mkAdv "uppåt" ; -- status=guess
lin transmission_N = mkN "växel" | mkN "överlämnande" ; -- SaldoWN -- comment=9
lin instantly_Adv = variants{} ; -- 
lin forthcoming_A = variants{} ; -- 
lin appointed_A = variants{} ; -- 
lin geographical_A = mkA "geografisk" ; -- status=guess
lin fist_N = mkN "knytnäve" utrum | mkN "knytnäve" utrum ; -- SaldoWN -- comment=3
lin abstract_A = mkA "abstrakt" "abstrakt" ; -- SaldoWN
lin embrace_V2 = dirV2 (partV (mkV "kramar")"ut"); -- comment=6
lin embrace_V = mkV "omsluta" "omslöt" "omslutit" ; -- comment=16
lin dynamic_A = mkA "dynamisk" ; -- SaldoWN
lin drawer_N = mkN "byrålåda" | mkN "tecknare" utrum ; -- SaldoWN -- comment=4
lin dismissal_N = mkN "avsked" neutrum | mkN "hemförlovning" ; -- SaldoWN -- comment=13
lin magic_N = mkN "trolleri" "trollerit" "trollerier" "trollerierna" ; -- comment=5
lin endless_A = mkA "ändlös" ; -- comment=3
lin definite_A = mkA "bestämd" "bestämt" | mkA "avgjord" "avgjort" ; -- SaldoWN -- comment=5
lin broadly_Adv = variants{} ; -- 
lin affection_N = mkN "ömhet" ; -- comment=8
lin dawn_N = mkN "gryning" ; -- comment=4
lin principal_N = mkN "uppdragsgivare" utrum; -- comment=7
lin bloke_N = mkN "kille" utrum; -- comment=4
lin trap_N = mkN "fälla" | mkN "vattenlås" neutrum ; -- SaldoWN -- comment=9
lin communist_A = mkA "kommunistiskt" ; -- status=guess
lin competence_N = mkN "kompetens" "kompetenser" ; -- SaldoWN
lin complicate_V2 = variants{} ; -- 
lin neutral_A = mkA "neutral" | mkA "opartisk" ; -- SaldoWN -- comment=3
lin fortunately_Adv = variants{} ; -- 
lin commonwealth_N = variants{} ; -- 
lin breakdown_N = mkN "sammanbrott" neutrum | mkN "upphörande" ; -- SaldoWN -- comment=9
lin combined_A = variants{} ; -- 
lin candle_N = mkN "ljus" neutrum | mkN "stearinljus" neutrum ; -- SaldoWN
lin venue_N = mkN "arena" ; -- status=guess
lin supper_N = mkN "kvällsmat" ; -- comment=6
lin analyst_N = mkN "psykoanalytiker" "psykoanalytikern" "psykoanalytiker" "psykoanalytikerna" | mkN "analytiker" "analytikern" "analytiker" "analytikerna" ; -- SaldoWN
lin vague_A = mkA "vag" ; -- SaldoWN
lin publicly_Adv = variants{} ; -- 
lin marine_A = mkA "marin" ; -- SaldoWN
lin fair_Adv = mkAdv "just" ; -- status=guess
lin pause_N = mkN "paus" "pauser" ; -- SaldoWN
lin notable_A = mkA "framstående" ; -- status=guess
lin freely_Adv = variants{} ; -- 
lin counterpart_N = mkN "motsvarighet" "motsvarigheter" ; -- comment=2
lin lively_A = mkA "livlig" ; -- SaldoWN
lin script_N = mkN "skriftsystem" neutrum | mkN "skrivtecken" "skrivtecknet" "skrivtecken" "skrivtecknen" ; -- SaldoWN -- comment=6
lin sue_V2V = variants{} ; -- 
lin sue_V2 = variants{} ; -- 
lin sue_V = variants{} ; -- 
lin legitimate_A = mkA "egentlig" ; -- comment=13
lin geography_N = mkN "geografi" ; -- status=guess
lin reproduce_V2 = dirV2 (partV (mkV "bli" "blev" "blivit")"utan"); -- comment=6
lin reproduce_V = mkV "upprepar" ; -- comment=7
lin moving_A = variants{} ; -- 
lin lamb_N = mkN "lamm" neutrum ; -- status=guess
lin gay_A = mkA "likgiltig" ; -- comment=7
lin contemplate_VS = variants{}; -- dirV2 (partV (mkV "funderar")"ut");
lin contemplate_V2 = dirV2 (partV (mkV "funderar")"ut"); -- status=guess
lin contemplate_V = mkV "grubblar" ; -- comment=7
lin terror_N = mkN "skräck" ; -- comment=2
lin stable_N = mkN "stall" ; -- SaldoWN = mkN "stall" neutrum ; = mkN "stall" neutrum ;
lin founder_N = mkN "grundare" utrum ; -- status=guess
lin utility_N = mkN "nytta" ; -- comment=3
lin signal_VS = variants{}; -- mkV "signalerar" ; -- comment=3
lin signal_V2 = variants{}; -- mkV "signalerar" ; -- comment=3
lin shelter_N = mkN "härbärge" | mkN "skydd" neutrum ; -- SaldoWN -- comment=11
lin poster_N = mkN "avsändare" utrum; -- comment=6
lin hitherto_Adv = mkAdv "hittills" ; -- status=guess
lin mature_A = mkA "mogen" "moget" ; -- SaldoWN
lin cooking_N = mkN "matlagning" | mkN "lagning" ; -- SaldoWN
lin head_A = variants{} ; -- 
lin wealthy_A = mkA "rik" ; -- comment=4
lin fucking_A = mkA "jävla" ; -- status=guess
lin confess_VS = mkVS (mkV "erkänna" "erkände" "erkänt") ; -- status=guess
lin confess_V2 = mkV2 (mkV "erkänna" "erkände" "erkänt") ; -- status=guess
lin confess_V = mkV "erkänna" "erkände" "erkänt" ; -- comment=4
lin age_V = mkV "åldras" ; -- status=guess, src=wikt
lin miracle_N = mkN "under" neutrum | mkN "under" neutrum ; -- SaldoWN -- comment=3
lin magic_A = mkA "underbar" ; -- comment=3
lin jaw_N = mkN "käke" utrum | mkN "käft" ; -- SaldoWN -- comment=7
lin pan_N = mkN "schimpans" "schimpanser" | mkN "vågskål" ; -- SaldoWN -- comment=7
lin coloured_A = variants{} ; -- 
lin tent_N = mkN "tält" neutrum | mkN "tält" neutrum ; -- SaldoWN
lin telephone_V2 = mkV2 (mkV "ringar"); -- status=guess, src=wikt
lin telephone_V = mkV "telefonerar" ; -- comment=3
lin reduced_A = variants{} ; -- 
lin tumour_N = mkN "tumör" "tumörer" ; -- SaldoWN
lin super_A = mkA "toppen" "toppet" ; -- comment=2
lin funding_N = variants{} ; -- 
lin dump_V2 = dirV2 (partV (mkV "slänger") "ut"); -- status=guess
lin dump_V = mkV "dumpar" ; -- comment=6
lin stitch_N = mkN "stygn" neutrum | mkN "stygn" neutrum ; -- SaldoWN -- comment=3
lin shared_A = variants{} ; -- 
lin ladder_N = mkN "stege" utrum ; -- SaldoWN -- comment=4
lin keeper_N = mkN "väktare" utrum; -- comment=6
lin endorse_V2 = mkV2 (mkV "stödjer") | mkV2 (mkV (mkV "ställer") "sig bakom") | mkV2 (mkV (mkV "stå") "bakom"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin invariably_Adv = variants{} ; -- 
lin smash_V2 = dirV2 (partV (mkV "smälla" "small" "smäll")"av"); -- comment=15
lin smash_V = mkV "smälla" "small" "smäll" ; -- comment=9
lin shield_N = mkN "sköld" | mkN "vapensköld" ; -- SaldoWN -- comment=9
lin heat_V2 = dirV2 (partV (mkV "värmer")"på"); -- status=guess
lin heat_V = mkV "upphettar" ; -- comment=6
lin surgeon_N = mkN "kirurg" "kirurger" ; -- SaldoWN
lin centre_V2 = variants{}; -- mkV "centrerar" ;
lin centre_V = mkV "centrerar" ; -- status=guess
lin orange_N = variants{} ; -- 
lin orange_2_N = mkN "orange" "oranger" ; -- comment=3
lin orange_1_N = mkN "orange" "oranger" ; -- comment=3
lin explode_V = mkV "spränger" ; -- comment=5
lin comedy_N = mkN "komedi" "komedier" | mkN "komik" ; -- SaldoWN -- comment=2
lin classify_V2 = mkV2 (mkV "klassificerar"); -- status=guess, src=wikt
lin artistic_A = mkA "konstnärlig" ; -- SaldoWN
lin ruler_N = mkN "makthavare" utrum; -- comment=2
lin biscuit_N = mkN "kaka" | mkN "kex" neutrum ; -- SaldoWN -- comment=5
lin workstation_N = variants{} ; -- 
lin prey_N = mkN "byte" | mkN "byte" "byten" "byte" "bytena" ; -- SaldoWN = mkN "byte" "byten" "byte" "bytena" ; -- comment=5
lin manual_N = mkN "manual" "manualer" ; -- SaldoWN
lin cure_N = variants{} ; -- 
lin cure_2_N = variants{} ; -- 
lin cure_1_N = mkN "vulkanisering" ; -- comment=14
lin overall_N = mkN "overall" "overaller" | mkN "rock" ; -- SaldoWN -- comment=5
lin tighten_V2 = variants{}; -- mkV "skärper" ; -- comment=5
lin tighten_V = mkV "skärper" ; -- comment=5
lin tax_V2 = mkV2 (mkV "beskattar"); -- status=guess, src=wikt
lin pope_N = mkN "påve" ; -- status=guess
lin manufacturing_A = variants{} ; -- 
lin adult_A = mkA "vuxen" "vuxet" | mkA "mogen" "moget" ; -- SaldoWN -- comment=3
lin rush_N = mkN "hast" | mkN "driva" ; -- SaldoWN -- comment=11
lin blanket_N = mkN "filt" ; -- status=guess
lin republican_N = mkN "republikan" "republikaner" ; -- status=guess
lin referendum_N = mkN "folkomröstning" ; -- SaldoWN
lin palm_N = mkN "palm" "palmer" | mkN "handflata" ; -- SaldoWN -- comment=2
lin nearby_Adv = mkAdv "i närheten" ; -- status=guess
lin mix_N = mkN "före" ; -- comment=5
lin devil_N = mkN "djävul" "djävulen" "djävlar" "djävlarna" ; -- comment=4
lin adoption_N = mkN "adoption" "adoptioner" | mkN "godkännande" ; -- SaldoWN -- comment=4
lin workforce_N = variants{} ; -- 
lin segment_N = mkN "sektion" "sektioner" ; -- comment=3
lin regardless_Adv = variants{} ; -- 
lin contractor_N = mkN "entreprenör" "entreprenörer" ; -- status=guess
lin portion_N = mkN "portion" "portioner" ; -- status=guess
lin differently_Adv = variants{} ; -- 
lin deposit_V2 = mkV2 (mkV "deponerar"); -- status=guess, src=wikt
lin cook_N = mkN "kock" ; -- SaldoWN = mkN "kock" "kocker" ; -- comment=6
lin prediction_N = mkN "förutsägelse" "förutsägelser" ; -- comment=4
lin oven_N = mkN "ugn" ; -- SaldoWN
lin matrix_N = mkN "matris" "matriser" ; -- SaldoWN
lin liver_N = L.liver_N ;
lin fraud_N = mkN "bedrägeri" "bedrägerit" "bedrägerier" "bedrägerierna" ; -- SaldoWN
lin beam_N = mkN "strimma" | mkN "varpbom" "varpbommen" "varpbommar" "varpbommarna" ; -- SaldoWN -- comment=10
lin signature_N = mkN "underskrift" "underskrifter" ; -- SaldoWN
lin limb_N = mkN "lem" "lemmen" "lemmar" "lemmarna" ; -- SaldoWN
lin verdict_N = mkN "dom" | mkN "dom" "domer" ; -- SaldoWN = mkN "dom" "domer" ; -- comment=7
lin dramatically_Adv = mkAdv "dramatiskt" ; -- status=guess
lin container_N = mkN "kärl" neutrum; -- comment=5
lin aunt_N = mkN "faster" | mkN "tant" "tanter" ; -- SaldoWN -- comment=3
lin dock_N = mkN "kaj" "kajer" ; -- comment=10
lin submission_N = mkN "underkastelse" utrum; -- status=guess
lin arm_V2 = mkV2 (mkV "rustar") | mkV2 (mkV "beväpna"); -- status=guess, src=wikt status=guess, src=wikt
lin arm_V = mkV "beväpnar" ; -- comment=7
lin odd_N = variants{} ; -- 
lin certainty_N = mkN "säkerhet" "säkerheter" ; -- comment=2
lin boring_A = mkA "långtråkig" ; -- comment=2
lin electron_N = mkN "elektron" neutrum ; -- status=guess
lin drum_N = mkN "trumma" | mkN "trummande" ; -- SaldoWN -- comment=5
lin wisdom_N = mkN "levnadsvett" neutrum; -- comment=4
lin antibody_N = mkN "antikropp" ; -- SaldoWN
lin unlike_A = mkA "olik" ; -- SaldoWN
lin terrorist_N = mkN "terrorist" "terrorister" ; -- SaldoWN
lin post_V2 = mkV2 "anslå" "anslog" "anslagit" | dirV2 (partV (mkV "skickar")"ut") ; -- SaldoWN -- comment=5
lin post_V = mkV "anslå" "anslog" "anslagit" | mkV "postar" ; -- SaldoWN -- comment=13
lin circulation_N = mkN "cirkulation" "cirkulationer" | mkN "spridning" ; -- SaldoWN -- comment=7
lin alteration_N = mkN "förändring" ; -- comment=4
lin fluid_N = mkN "vätska" ; -- SaldoWN
lin ambitious_A = mkA "ambitiös" | mkA "ärelysten" "ärelystet" ; -- SaldoWN -- comment=5
lin socially_Adv = variants{} ; -- 
lin riot_N = mkN "upplopp" neutrum | mkN "upplopp" neutrum ; -- SaldoWN -- comment=3
lin petition_N = mkN "skrivelse" "skrivelser" ; -- comment=6
lin fox_N = mkN "räv" ; -- SaldoWN
lin recruitment_N = mkN "återhämtning" ; -- comment=3
lin well_known_A = variants{} ; -- 
lin top_V2 = dirV2 (partV (mkV "kapar")"av"); -- status=guess
lin service_V2 = mkV2 "serva" ; -- status=guess
lin flood_V2 = mkV2 (mkV (mkV "svämma") "över") | mkV2 (mkV "översvämma"); -- status=guess, src=wikt status=guess, src=wikt
lin flood_V = mkV "översvämmar" ; -- comment=2
lin taste_V2 = mkV2 (mkV "smakar"); -- status=guess, src=wikt
lin taste_V = mkV "smakar" ; -- comment=3
lin memorial_N = mkN "minnesmärke" | mkN "minneshögtid" | mkN "minnesgudstjänst" ; -- SaldoWN -- status=guess status=guess
lin helicopter_N = mkN "helikopter" ; -- SaldoWN
lin correspondence_N = mkN "korrespondens" "korrespondenser" | mkN "överensstämmelse" "överensstämmelser" ; -- SaldoWN -- comment=4
lin beef_N = mkN "biff" | mkN "nötkött" neutrum ; -- SaldoWN -- comment=8
lin overall_Adv = variants{} ; -- 
lin lighting_N = mkN "lyse" ; -- comment=4
lin harbour_N = L.harbour_N ;
lin empirical_A = mkA "empirisk" ; -- SaldoWN
lin shallow_A = mkA "grund" | mkA "ytlig" ; -- SaldoWN -- comment=3
lin seal_V2 = variants{}; -- mkV "försluta" "förslöt" "förslutit" ; -- comment=4
lin seal_V = mkV "försluta" "förslöt" "förslutit" ; -- comment=4
lin decrease_V2 = mkV2 (mkV "minskar"); -- status=guess, src=wikt
lin decrease_V = mkV "avta" "avtar" "avta" "avtog" "avtagit" "avtagen" ; -- comment=2
lin constituent_N = mkN "väljande" ; -- comment=5
lin exam_N = mkN "tenta" | mkN "examen" "examen" "examina" "examina" ; -- SaldoWN -- comment=2
lin toe_N = mkN "tå" "tån" "tår" "tårna" ; -- SaldoWN
lin reward_V2 = mkV2 (mkV "belöna"); -- status=guess, src=wikt
lin thrust_V2 = dirV2 (partV (mkV "stoppar")"till"); -- comment=3
lin thrust_V = mkV "stöter" ; -- comment=2
lin bureaucracy_N = mkN "byråkrati" "byråkratier" ; -- SaldoWN
lin wrist_N = mkN "handled" "handleder" | mkN "manschett" "manschetter" ; -- SaldoWN -- comment=3
lin nut_N = mkN "tok" | mkN "nöt" neutrum ; -- SaldoWN -- comment=8
lin plain_N = mkN "ful" ; -- comment=3
lin magnetic_A = mkA "magnetisk" ; -- SaldoWN
lin evil_N = mkN "ont" neutrum; -- comment=9
lin widen_V2 = mkV2 (mkV "vidgar"); -- status=guess, src=wikt
lin hazard_N = mkN "slump" ; -- comment=5
lin dispose_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin dispose_V = mkV "ordnar" ; -- comment=5
lin dealing_N = variants{} ; -- 
lin absent_A = mkA "frånvarande" | mkA "tankspridd" ; -- SaldoWN -- comment=3
lin reassure_V2S = variants{} ; -- 
lin reassure_V2 = variants{} ; -- 
lin model_V2 = dirV2 (partV (mkV "visar")"in"); -- comment=2
lin model_V = mkV "visar" ; -- comment=4
lin inn_N = mkN "värdshus" neutrum ; -- SaldoWN -- comment=2
lin initial_N = mkN "initial" "initialer" | mkN "signatur" "signaturer" ; -- SaldoWN -- comment=7
lin suspension_N = mkN "upphävande" ; -- comment=10
lin respondent_N = mkN "svarande" ; -- comment=2
lin over_N = mkN "under" neutrum; -- comment=4
lin naval_A = mkA "örlogs-" | mkA "sjö-" | mkA "flott-" ; -- status=guess status=guess status=guess
lin monthly_A = mkA "månatlig" | mkA "månadsvis" ; -- SaldoWN -- comment=2
lin log_N = mkN "stock" ; -- SaldoWN
lin advisory_A = mkA "rådgivande" ; -- status=guess
lin fitness_N = mkN "form" | mkN "kondition" "konditioner" ; -- SaldoWN = mkN "form" ; = mkN "form" "former" ;
lin blank_A = mkA "tom" "tomt" "tomma" "tomma" "tommare" "tommast" "tommaste" | mkA "uttryckslös" ; -- SaldoWN -- comment=7
lin indirect_A = mkA "indirekt" "indirekt" ; -- SaldoWN
lin tile_N = mkN "kakel" neutrum | mkN "kakelplatta" ; -- SaldoWN -- comment=5
lin rally_N = mkN "rally" "rallyt" "rallyn" "rallyna" ; -- SaldoWN
lin economist_N = mkN "ekonom" "ekonomer" ; -- SaldoWN
lin vein_N = mkN "ven" "vener" | mkN "åder" "ådern" "ådror" "ådrorna" ; -- SaldoWN -- comment=3
lin strand_N = mkN "slinga" ; -- status=guess
lin disturbance_N = mkN "orolighet" "oroligheter" | mkN "störande" ; -- SaldoWN -- comment=14
lin stuff_V2 = dirV2 (partV (mkV "stoppar")"till"); -- comment=3
lin seldom_Adv = mkAdv "sällan" ; -- status=guess
lin coming_A = variants{} ; -- 
lin cab_N = mkN "taxi" "taxin" "taxi" "taxina" ; -- comment=4
lin grandfather_N = mkN "morfar" "morfadern" "morfäder" "morfäderna" ; -- SaldoWN
lin flash_V = mkV "anfalla" "anföll" "anfallit" ; -- comment=14
lin destination_N = mkN "bestämmelseort" "bestämmelseorter" ; -- comment=4
lin actively_Adv = variants{} ; -- 
lin regiment_N = mkN "regemente" ; -- status=guess
lin closed_A = mkA "stängd" "stängt" ; -- status=guess
lin boom_N = mkN "boom" | mkN "uppsving" neutrum ; -- SaldoWN -- comment=11
lin handful_N = mkN "näve" utrum; -- comment=2
lin remarkably_Adv = variants{} ; -- 
lin encouragement_N = mkN "uppmuntran" "uppmuntran" "uppmuntringar" "uppmuntringarna" ; -- comment=5
lin awkward_A = mkA "avig" | mkA "svårhanterlig" ; -- SaldoWN -- comment=23
lin required_A = variants{} ; -- 
lin flood_N = mkN "översvämning" ; -- SaldoWN
lin defect_N = mkN "defekt" "defekter" ; -- comment=5
lin surplus_N = mkN "överskott" neutrum | mkN "överskott" neutrum ; -- SaldoWN
lin champagne_N = mkN "champagne" "champagner" ; -- SaldoWN
lin liquid_N = mkN "spad" neutrum | mkN "spad" neutrum ; -- SaldoWN -- comment=5
lin shed_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- status=guess
lin welcome_N = mkN "mottagning" | mkN "välkomnande" ; -- SaldoWN -- comment=2
lin rejection_N = mkN "avslag" neutrum | mkN "förkastande" ; -- SaldoWN -- comment=8
lin discipline_V2 = variants{} ; -- 
lin halt_V2 = mkV2 (mkV "haltar"); -- status=guess, src=wikt
lin halt_V = mkV "haltar" ; -- comment=5
lin electronics_N = mkN "elektronik" ; -- SaldoWN
lin administratorMasc_N = variants{} ; -- 
lin sentence_V2 = dirV2 (partV (mkV "dömer")"ut"); -- status=guess
lin sentence_V = mkV "dömer" ; -- status=guess
lin ill_Adv = mkAdv "illa" ; -- status=guess
lin contradiction_N = mkN "motsägelse" "motsägelser" ; -- SaldoWN
lin nail_N = mkN "spik" ; -- SaldoWN
lin senior_N = mkN "senior" ; -- SaldoWN = mkN "senior" "senioren" "seniorer" "seniorerna" ;
lin lacking_A = variants{} ; -- 
lin colonial_A = mkA "kolonial" ; -- status=guess
lin primitive_A = mkA "primitiv" ; -- status=guess
lin whoever_NP = variants{} ; -- 
lin lap_N = mkN "knä" "knäet" "knän" "knäna" | mkN "överlappning" ; -- SaldoWN -- comment=12
lin commodity_N = mkN "artikel" ; -- comment=3
lin planned_A = variants{} ; -- 
lin intellectual_N = mkN "djup" neutrum; -- status=guess
lin imprisonment_N = mkN "inspärrande" ; -- comment=4
lin coincide_V = mkV "sammanfalla" "sammanföll" "sammanfallit" | mkV "sammanträffar" ; -- SaldoWN -- comment=2
lin sympathetic_A = mkA "sympatisk" ; -- SaldoWN
lin atom_N = mkN "atom" "atomer" | mkN "uns" neutrum ; -- SaldoWN -- comment=2
lin tempt_V2V = variants{} ; -- 
lin tempt_V2 = variants{} ; -- 
lin sanction_N = mkN "sanktion" "sanktioner" ; -- comment=6
lin praise_V2 = mkV2 (mkV "lovar"); -- status=guess, src=wikt
lin favourable_A = mkA "välvillig" ; -- comment=4
lin dissolve_V2 = dirV2 (partV (mkV "löser")"ut"); -- status=guess
lin dissolve_V = mkV "upplöser" ; -- comment=5
lin tightly_Adv = variants{} ; -- 
lin surrounding_N = variants{} ; -- 
lin soup_N = mkN "soppa" ; -- SaldoWN = mkN "soppa" ;
lin encounter_N = mkN "möte" ; -- comment=6
lin abortion_N = mkN "abort" "aborter" ; -- status=guess
lin grasp_V2 = mkV2 (mkV "fattar") | mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV "greppar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grasp_V = mkV "greppar" ; -- comment=7
lin custody_N = mkN "arrest" "arrester" | mkN "förmynderskap" neutrum ; -- SaldoWN -- comment=8
lin composer_N = mkN "kompositör" "kompositörer" ; -- status=guess
lin charm_N = mkN "amulett" "amuletter" | mkN "trollformel" "trollformeln" "trollformler" "trollformlerna" ; -- SaldoWN -- comment=10
lin short_term_A = variants{} ; -- 
lin metropolitan_A = variants{} ; -- 
lin waist_N = mkN "midja" ; -- SaldoWN
lin equality_N = mkN "jämlikhet" "jämlikheter" ; -- comment=2
lin tribute_N = mkN "tribut" "tributer" | mkN "hylla" ; -- SaldoWN -- comment=2
lin bearing_N = mkN "sköldemärke" ; -- comment=19
lin auction_N = mkN "auktion" "auktioner" ; -- SaldoWN
lin standing_N = mkN "varaktighet" "varaktigheter" ; -- comment=10
lin manufacture_N = mkN "tillverkning" ; -- SaldoWN
lin horn_N = L.horn_N ;
lin barn_N = mkN "loge" "loger" ; -- comment=4
lin mayor_N = mkN "borgmästare" utrum | mkN "borgmästare" utrum ; -- SaldoWN
lin emperor_N = mkN "kejsare" utrum; -- status=guess
lin rescue_N = mkN "undsättning" | mkN "räddning" ; -- SaldoWN -- comment=6
lin integrated_A = variants{} ; -- 
lin conscience_N = mkN "samvete" ; -- SaldoWN
lin commence_V2 = dirV2 (partV (mkV "börjar")"om"); -- status=guess
lin commence_V = mkV "börjar" ; -- comment=3
lin grandmother_N = mkN "mormoder" "mormodern" "mormödrar" "mormödrarna" ; -- status=guess
lin discharge_V2 = dirV2 (partV (mkV "löser")"ut"); -- status=guess
lin discharge_V = mkV "tömmer" ; -- comment=23
lin profound_A = mkA "djupsinnig" | mkA "outgrundlig" ; -- SaldoWN -- comment=11
lin takeover_N = mkN "övertagande" ; -- comment=2
lin nationalist_N = mkN "nationalist" "nationalister" ; -- SaldoWN
lin effect_V2 = mkV2 (mkV (mkV "sätta" "satte" "satt") "i verket") | mkV2 (mkV "effektuerar") | mkV2 (mkV (mkV "sätta" "satte" "satt") "igång") | mkV2 (mkV "verkställer") | mkV2 (mkV "utverkar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dolphin_N = mkN "delfin" "delfiner" ; -- SaldoWN
lin fortnight_N = variants{} ; -- 
lin elephant_N = mkN "elefant" "elefanter" ; -- SaldoWN
lin seal_N = mkN "säl" ; -- SaldoWN
lin spoil_V2 = dirV2 (partV (mkV "skämmer")"ut"); -- status=guess
lin spoil_V = mkV "skämmer" ; -- comment=7
lin plea_N = mkN "ursäkt" "ursäkter" ; -- comment=9
lin forwards_Adv = mkAdv "framlänges" ; -- status=guess
lin breeze_N = mkN "bris" ; -- SaldoWN
lin prevention_N = mkN "förebyggande" ; -- status=guess
lin mineral_N = mkN "mineral" "mineralet" "mineraler" "mineralerna" ; -- SaldoWN
lin runner_N = mkN "löpare" utrum | mkN "utlöpare" utrum ; -- SaldoWN -- comment=8
lin pin_V2 = variants{} ; -- 
lin integrity_N = mkN "integritet" "integriteter" ; -- SaldoWN
lin thereafter_Adv = mkAdv "därefter" ; -- status=guess
lin quid_N = mkN "pund" neutrum; -- status=guess
lin owl_N = mkN "uggla" ; -- SaldoWN
lin rigid_A = mkA "stel" ; -- SaldoWN
lin orange_A = mkA "orange" "orange" ; -- status=guess
lin draft_V2 = mkV2 (mkV "värva") | mkV2 (mkV "rekryterar") | mkV2 (mkV "kommenderar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reportedly_Adv = variants{} ; -- 
lin hedge_N = mkN "häck" | mkN "skydd" neutrum ; -- SaldoWN -- comment=3
lin formulate_V2 = variants{} ; -- 
lin associated_A = variants{} ; -- 
lin position_V2 = mkV2 (mkV "placerar") | mkV2 (mkV (mkV "placera") "ut"); -- status=guess, src=wikt status=guess, src=wikt
lin thief_N = mkN "tjuv" ; -- SaldoWN
lin tomato_N = mkN "tomat" "tomater" ; -- SaldoWN
lin exhaust_V2 = variants{} ; -- 
lin evidently_Adv = variants{} ; -- 
lin eagle_N = mkN "örn" ; -- SaldoWN
lin specified_A = variants{} ; -- 
lin resulting_A = variants{} ; -- 
lin blade_N = mkN "blad" neutrum ; -- SaldoWN -- comment=5
lin peculiar_A = mkA "karakteristisk" ; -- comment=10
lin killing_N = mkN "dödande" ; -- comment=4
lin desktop_N = mkN "PC" ; -- status=guess
lin bowel_N = mkN "tarm" ; -- SaldoWN
lin long_V = mkV "längtar" ; -- status=guess
lin ugly_A = L.ugly_A ;
lin expedition_N = mkN "expedition" "expeditioner" | mkN "skyndsamhet" ; -- SaldoWN -- comment=10
lin saint_N = mkN "helgon" neutrum; -- status=guess
lin variable_A = mkA "variabel" ; -- SaldoWN
lin supplement_V2 = dirV2 (partV (mkV "ökar")"till"); -- comment=2
lin stamp_N = mkN "frimärke" | mkN "stämpel" ; -- SaldoWN -- comment=16
lin slide_N = mkN "rutschbana" | mkN "sticka" ; -- SaldoWN -- comment=13
lin faction_N = mkN "gräl" neutrum; -- comment=6
lin enthusiastic_A = mkA "entusiastisk" ; -- SaldoWN
lin enquire_V2 = dirV2 (partV (mkV "frågar")"ut"); -- status=guess
lin enquire_V = mkV "frågar" ; -- status=guess
lin brass_N = mkN "mässing" ; -- comment=3
lin inequality_N = mkN "olikhet" "olikheter" ; -- comment=2
lin eager_A = mkA "ivrig" | mkA "angelägen" "angeläget" ; -- SaldoWN -- comment=4
lin bold_A = mkA "djärv" | mkA "framfusig" ; -- SaldoWN -- comment=10
lin neglect_V2 = mkV2 (mkV "försumma"); -- status=guess, src=wikt
lin saying_N = mkN "ordspråk" | mkN "ordstäv" ; -- status=guess status=guess
lin ridge_N = mkN "ås" | mkN "kam" "kammen" "kammar" "kammarna" ; -- SaldoWN -- comment=6
lin earl_N = mkN "jarl" ; -- status=guess
lin yacht_N = mkN "jakt" "jakter" ; -- SaldoWN
lin suck_V2 = L.suck_V2;
lin suck_V = mkV "suga" "sög" "sugit" ; -- comment=3
lin missing_A = variants{} ; -- 
lin extended_A = variants{} ; -- 
lin valuation_N = mkN "värdering" ; -- status=guess
lin delight_V2 = mkV2 (mkV "glädja" "gladde" "glatt"); -- status=guess, src=wikt
lin delight_V = mkV "fröjdar" ; -- comment=2
lin beat_N = mkN "takt" | mkN "trampa" ; -- SaldoWN = mkN "takt" "takter" ; -- comment=18
lin worship_N = mkN "ära" ; -- comment=4
lin fossil_N = mkN "fossil" neutrum | mkN "stofil" "stofiler" ; -- SaldoWN -- comment=3
lin diminish_V2 = mkV2 (mkV "minskar"); -- status=guess, src=wikt
lin diminish_V = mkV "förminskar" ; -- comment=5
lin taxpayer_N = mkN "skattebetalare" utrum | mkN "skattebetalare" utrum ; -- SaldoWN
lin corruption_N = mkN "korruption" "korruptioner" ; -- SaldoWN
lin accurately_Adv = variants{} ; -- 
lin honour_V2 = mkV2 (mkV "hedrar"); -- status=guess, src=wikt
lin depict_V2 = mkV2 (mkV "framställer") | mkV2 (mkV "skildrar"); -- status=guess, src=wikt status=guess, src=wikt
lin pencil_N = mkN "penna" | mkN "strålknippe" ; -- SaldoWN -- comment=3
lin drown_V2 = mkV2 (mkV (mkV "dränka") "sina sorger"); -- status=guess, src=wikt
lin drown_V = mkV "dränker" ; -- comment=4
lin stem_N = mkN "stjälk" | mkN "stämma" ; -- SaldoWN -- comment=7
lin lump_N = mkN "klump" | mkN "klimp" ; -- SaldoWN -- comment=16
lin applicable_A = mkA "tillämplig" ; -- comment=3
lin rate_V2 = dirV2 (partV (mkV "räknar")"ut"); -- comment=5
lin rate_V = mkV "mår" ; -- comment=9
lin mobility_N = mkN "rörlighet" "rörligheter" ; -- comment=2
lin immense_A = mkA "enorm" ; -- comment=7
lin goodness_N = mkN "vänlighet" ; -- comment=6
lin price_V2V = mkV2V (mkV "värdera") | mkV2V (mkV "prissätta" "prissatte" "prissatt") ; -- status=guess
lin price_V2 = mkV2 (mkV "värdera") | mkV2 (mkV "prissätta" "prissatte" "prissatt") ; -- status=guess
lin price_V = mkV "prissätta" "prissatte" "prissatt" ;
lin preliminary_A = mkA "preliminär" ; -- status=guess
lin graph_N = mkN "graf" "grafer" | mkN "diagram" "diagrammet" "diagram" "diagrammen" ; -- SaldoWN -- comment=3
lin referee_N = mkN "domare" utrum | mkN "skiljedomare" utrum ; -- SaldoWN -- comment=3
lin calm_A = mkA "lugn" ; -- comment=2
lin onwards_Adv = variants{} ; -- 
lin omit_V2 = variants{} ; -- 
lin genuinely_Adv = variants{} ; -- 
lin excite_V2 = variants{} ; -- 
lin dreadful_A = mkA "fruktansvärd" "fruktansvärt" ; -- comment=6
lin cave_N = mkN "grotta" ; -- SaldoWN
lin revelation_N = mkN "uppenbarelse" "uppenbarelser" ; -- status=guess
lin grief_N = mkN "sorg" "sorger" ; -- SaldoWN
lin erect_V2 = variants{} ; -- 
lin tuck_V2 = variants{} ; -- 
lin tuck_V = variants{} ; -- 
lin meantime_N = variants{} ; -- 
lin barrel_N = mkN "tunna" ; -- SaldoWN
lin lawn_N = mkN "gräsmatta" ; -- SaldoWN
lin hut_N = mkN "hydda" ; -- SaldoWN
lin swing_N = mkN "gunga" | mkN "svängning" ; -- SaldoWN -- comment=12
lin subject_V2 = variants{} ; -- 
lin ruin_V2 = mkV2 (mkV "ruinerar") | mkV2 (mkV "ödelägga" "ödelade" "ödelagt") ; -- status=guess
lin slice_N = mkN "skiva" | mkN "skära" ; -- SaldoWN -- comment=2
lin transmit_V2 = dirV2 (partV (mkV "sänder")"efter"); -- comment=2
lin thigh_N = mkN "lår" ; -- SaldoWN = mkN "lår" neutrum ;
lin practically_Adv = variants{} ; -- 
lin dedicate_V2 = variants{} ; -- 
lin mistake_V2 = mkV2 (mkV "missta" "misstar" "missta" "misstog" "misstagit" "misstagen") | mkV2 (mkV (mkV "begå") "ett misstag"); -- status=guess, src=wikt status=guess, src=wikt
lin mistake_V = (mkV "missta" "misstar" "missta" "misstog" "misstagit" "misstagen") | mkV (mkV "begå") "ett misstag" ; -- status=guess, src=wikt status=guess, src=wikt
lin corresponding_A = variants{} ; -- 
lin albeit_Subj = variants{} ; -- 
lin sound_A = mkA "sund" | mkA "säker" ; -- SaldoWN -- comment=13
lin nurse_V2 = dirV2 (partV (mkV "sparar")"in"); -- status=guess
lin discharge_N = mkN "uttömning" ; -- comment=29
lin comparative_A = mkA "komparativ" ; -- comment=3
lin cluster_N = mkN "kluster" neutrum | mkN "klase" utrum ; -- SaldoWN -- comment=8
lin propose_VV = mkVV (mkV "friar"); -- status=guess, src=wikt
lin propose_VS = mkVS (mkV "friar"); -- status=guess, src=wikt
lin propose_V2 = mkV2 (mkV "föreslå" "föreslog" "föreslagit");
lin propose_V = mkV "ämnar" ; -- comment=4
lin obstacle_N = mkN "hinder" neutrum | mkN "hinder" neutrum ; -- SaldoWN -- comment=2
lin motorway_N = mkN "motorväg" ; -- SaldoWN
lin heritage_N = mkN "kulturarv" neutrum; -- comment=5
lin counselling_N = variants{} ; -- 
lin breeding_N = mkN "hyfs" ; -- comment=11
lin characteristic_A = mkA "karakteristisk" ; -- SaldoWN
lin bucket_N = mkN "hink" | mkN "kolv" ; -- SaldoWN -- comment=5
lin migration_N = mkN "migration" "migrationer" ; -- SaldoWN
lin campaign_V = mkV "kampanj" ; -- status=guess, src=wikt
lin ritual_N = mkN "ritual" neutrum | mkN "ritual" neutrum ; -- SaldoWN
lin originate_V2 = variants{}; -- mkV "bottnar" ;
lin originate_V = mkV "bottnar" ; -- status=guess
lin hunting_N = mkN "jakt" "jakter" ; -- SaldoWN
lin crude_A = mkA "primitiv" | mkA "rå" "rått" ; -- SaldoWN -- comment=6
lin protocol_N = mkN "protokoll" neutrum; -- comment=2
lin prejudice_N = mkN "fördom" | mkN "skada" ; -- SaldoWN -- comment=2
lin inspiration_N = mkN "inspiration" "inspirationer" ; -- SaldoWN
lin dioxide_N = variants{} ; -- 
lin chemical_A = mkA "kemisk" ; -- status=guess
lin uncomfortable_A = mkA "obekväm" ; -- SaldoWN
lin worthy_A = mkA "värdig" ; -- SaldoWN
lin inspect_V2 = mkV2 (mkV "inspekterar"); -- status=guess, src=wikt
lin summon_V2 = dirV2 (partV (mkV "kallar")"ut"); -- status=guess
lin parallel_N = mkN "parallell" "paralleller" | mkN "motsvarande" ; -- SaldoWN -- comment=5
lin outlet_N = mkN "kontakt" "kontakter" | mkN "utlopp" neutrum ; -- SaldoWN -- comment=8
lin okay_A = mkA "okej" ; -- comment=4
lin collaboration_N = mkN "samarbete" ; -- comment=2
lin booking_N = mkN "varning" ; -- comment=4
lin salad_N = mkN "sallad" "sallader" ; -- SaldoWN
lin productive_A = mkA "produktiv" ; -- SaldoWN
lin charming_A = variants{} ; -- 
lin polish_A = variants{} ; -- 
lin oak_N = mkN "ek" ; -- SaldoWN
lin access_V2 = mkV2 (mkV (mkV "ha") "åtkomst"); -- status=guess, src=wikt
lin tourism_N = mkN "turism" "turismer" ; -- SaldoWN
lin independently_Adv = variants{} ; -- 
lin cruel_A = mkA "grym" "grymt" "grymma" "grymma" "grymmare" "grymmast" "grymmaste" | mkA "svår" ; -- SaldoWN -- comment=5
lin diversity_N = mkN "mångfald" "mångfalder" ; -- status=guess
lin accused_A = variants{} ; -- 
lin supplement_N = mkN "bilaga" ; -- comment=4
lin fucking_Adv = mkAdv "in i helvete" ; -----
lin forecast_N = mkN "prognos" "prognoser" ; -- status=guess
lin amend_V2V = mkV2V (mkV "korrigerar") | mkV2V (mkV "redigerar") | mkV2V (mkV "ändra"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin amend_V2 = mkV2 (mkV "korrigerar") | mkV2 (mkV "redigerar") | mkV2 (mkV "ändra"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin amend_V = mkV "ändrar" ; -- comment=2
lin soap_N = mkN "tvål" ; -- SaldoWN
lin ruling_N = mkN "avgörande" ; -- comment=3
lin interference_N = mkN "störning" | mkN "kollision" "kollisioner" ; -- SaldoWN -- comment=8
lin executive_A = mkA "verkställande" ; -- SaldoWN
lin mining_N = mkN "gruvdrift" "gruvdrifter" ; -- comment=3
lin minimal_A = mkA "minimal" ; -- SaldoWN
lin clarify_V2 = mkV2 (mkV "förtydliga") | mkV2 (mkV "klargöra" "klargjorde" "klargjort") ; -- status=guess
lin clarify_V = mkV "klarnar" ; -- comment=5
lin strain_V2 = mkV2 "spänna" "spände" "spänt" | dirV2 (partV (mkV "silar")"ifrån") ; -- SaldoWN -- comment=4
lin novel_A = mkA "ny" "nytt" ; -- comment=2
lin try_N = mkN "försök" neutrum; -- status=guess
lin coastal_A = variants{} ; -- 
lin rising_A = variants{} ; -- 
lin quota_N = mkN "kvot" "kvoter" ; -- SaldoWN
lin minus_Prep = mkPrep "minus" ; -- status=guess
lin kilometre_N = mkN "kilometer" ; -- SaldoWN
lin characterize_V2 = variants{} ; -- 
lin suspicious_A = mkA "misstänkt" "misstänkt" ; -- comment=3
lin pet_N = mkN "husdjur" neutrum | mkN "sällskapsdjur" neutrum ; -- SaldoWN -- comment=8
lin beneficial_A = mkA "välgörande" ; -- comment=2
lin fling_V2 = dirV2 (partV (mkV "rusar")"ut"); -- comment=22
lin fling_V = mkV "slänger" ; -- comment=10
lin deprive_V2 = mkV2 (mkV "beröva") | mkV2 (mkV "förvägra"); -- status=guess, src=wikt status=guess, src=wikt
lin covenant_N = mkN "överenskommelse" "överenskommelser" ; -- comment=2
lin bias_N = mkN "fördom" ; -- status=guess
lin trophy_N = mkN "trofé" "troféer" ; -- comment=2
lin verb_N = mkN "verb" neutrum; -- status=guess
lin honestly_Adv = variants{} ; -- 
lin extract_N = mkN "utdrag" neutrum; -- comment=3
lin straw_N = mkN "sugrör" neutrum | mkN "strå" "strået" "strån" "stråna" ; -- SaldoWN -- comment=2
lin stem_V2 = dirV2 (partV (mkV "stoppar")"till"); -- comment=3
lin stem_V = mkV "stämmer" ; -- comment=5
lin eyebrow_N = mkN "ögonbryn" neutrum ; -- SaldoWN
lin noble_A = mkA "ädel" "ädelt" "ädla" "ädla" "ädlare" "ädlast" "ädlaste" ; -- SaldoWN
lin mask_N = mkN "mask" | mkN "mask" "masker" ; -- SaldoWN = mkN "mask" "masker" ; -- comment=6
lin lecturer_N = mkN "universitetslektor" "universitetslektorer" ; -- comment=5
lin girlfriend_N = mkN "väninna" | mkN "tjejkompis" ; -- status=guess status=guess
lin forehead_N = mkN "panna" ; -- SaldoWN
lin timetable_N = mkN "tidtabell" "tidtabeller" | mkN "schema" "schemat" "scheman" "schemana" ; -- SaldoWN
lin symbolic_A = mkA "symbolisk" ; -- comment=2
lin farming_N = mkN "lantbruk" neutrum; -- comment=3
lin lid_N = mkN "ögonlock" neutrum | mkN "lock" neutrum ; -- SaldoWN -- comment=2
lin librarian_N = mkN "bibliotekarie" "bibliotekarier" ; -- SaldoWN
lin injection_N = mkN "injektion" "injektioner" ; -- SaldoWN
lin sexuality_N = mkN "sexualitet" "sexualiteter" ; -- SaldoWN
lin irrelevant_A = mkA "ovidkommande" ; -- SaldoWN
lin bonus_N = mkN "bonus" ; -- comment=3
lin abuse_V2 = mkV2 (mkV "misshandlar"); -- status=guess, src=wikt
lin thumb_N = mkN "tumme" utrum | mkN "tumme" utrum ; -- SaldoWN
lin survey_V2 = dirV2 (partV (mkV "mönstrar")"på"); -- comment=2
lin ankle_N = mkN "vrist" "vrister" | mkN "ankel" ; -- SaldoWN -- comment=4
lin psychologist_N = mkN "psykolog" "psykologer" ; -- SaldoWN
lin occurrence_N = mkN "tilldragelse" "tilldragelser" ; -- comment=4
lin profitable_A = mkA "nyttig" ; -- comment=9
lin deliberate_A = mkA "överlagd" "överlagt" ; -- comment=8
lin bow_V2 = dirV2 (partV (mkV "bockar")"för"); -- comment=10
lin bow_V = mkV "böja" "böjde" "böjt" ; -- comment=6
lin tribe_N = mkN "stam" "stammen" "stammar" "stammarna" ; -- SaldoWN
lin rightly_Adv = variants{} ; -- 
lin representative_A = mkA "representativ" ; -- SaldoWN
lin code_V2 = dirV2 (partV (mkV "kodar")"av"); -- status=guess
lin validity_N = mkN "värde" ; -- comment=3
lin marble_N = mkN "tigerkaka" ; -- status=guess
lin bow_N = mkN "rosett" "rosetter" | mkN "stråke" utrum ; -- SaldoWN -- comment=14
lin plunge_V2 = dirV2 (partV (mkV "slungar")"in"); -- comment=4
lin plunge_V = mkV "stampar" ; -- comment=5
lin maturity_N = variants{} ; -- 
lin maturity_3_N = mkN "mognad" "mognader" ; -- status=guess
lin maturity_2_N = mkN "mognad" "mognader" ; -- status=guess
lin maturity_1_N = mkN "mognad" "mognader" ; -- status=guess
lin hidden_A = variants{} ; -- 
lin contrast_V2 = variants{}; -- mkV "kontrasterar" ; -- comment=2
lin contrast_V = mkV "kontrasterar" ; -- comment=2
lin tobacco_N = mkN "tobak" ; -- status=guess
lin middle_class_A = variants{} ; -- 
lin grip_V2 = mkV2 (mkV "gripa" "grep" "gripit"); -- status=guess, src=wikt
lin clergy_N = mkN "prästerskap" neutrum; -- comment=2
lin trading_A = variants{} ; -- 
lin passive_A = mkA "passiv" ; -- SaldoWN
lin decoration_N = mkN "prydnad" "prydnader" | mkN "dekorering" ; -- SaldoWN -- comment=9
lin racial_A = mkA "rasmässig" ; -- status=guess
lin well_N = mkN "brunn" | mkN "väl" ; -- SaldoWN -- comment=8
lin embarrassment_N = mkN "bryderi" "bryderit" "bryderier" "bryderierna" | mkN "förlägenhet" "förlägenheter" ; -- SaldoWN -- comment=6
lin sauce_N = mkN "sås" "såser" ; -- SaldoWN
lin fatal_A = mkA "ödesdiger" ; -- comment=8
lin banker_N = mkN "bankir" "bankirer" ; -- comment=2
lin compensate_V2 = variants{}; -- mkV "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" ; -- comment=3
lin compensate_V = mkV "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" ; -- comment=3
lin make_up_N = variants{} ; -- 
lin popularity_N = mkN "popularitet" "populariteter" ; -- SaldoWN
lin interior_A = mkA "invändig" ; -- status=guess
lin eligible_A = mkA "valbar" | mkA "behörig" ; -- SaldoWN -- comment=5
lin continuity_N = variants{} ; -- 
lin bunch_N = mkN "knippa" ; -- comment=11
lin hook_N = mkN "lockbete" | mkN "krok" ; -- SaldoWN -- comment=6
lin wicket_N = mkN "spelomgång" ; -- comment=5
lin pronounce_V2 = mkV2 (mkV "uttalar"); -- status=guess, src=wikt
lin pronounce_V = mkV "uttalar" ; -- comment=6
lin ballet_N = mkN "balett" "baletter" ; -- SaldoWN
lin heir_N = mkN "arvinge" utrum ; -- SaldoWN -- comment=2
lin positively_Adv = variants{} ; -- 
lin insufficient_A = mkA "otillräcklig" ; -- SaldoWN
lin substitute_V2 = mkV2 "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" | mkV2 (mkV "substituerar") ; -- status=guess
lin substitute_V = mkV "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" ; -- SaldoWN
lin mysterious_A = mkA "mystisk" ; -- status=guess
lin dancer_N = mkN "dansare" utrum; -- comment=3
lin trail_N = mkN "väg" ; -- comment=7
lin caution_N = variants{} ; -- 
lin donation_N = mkN "donation" "donationer" ; -- comment=5
lin added_A = variants{} ; -- 
lin weaken_V2 = variants{}; -- mkV "försvagar" ; -- comment=2
lin weaken_V = mkV "försvagar" ; -- comment=2
lin tyre_N = mkN "däck" neutrum | mkN "ring" neutrum ; -- SaldoWN = mkN "däck" neutrum ; -- comment=5
lin sufferer_N = variants{} ; -- 
lin managerial_A = variants{} ; -- 
lin elaborate_A = compoundA (regA "detaljerad"); -- status=guess
lin restraint_N = mkN "behärskning" | mkN "hinder" neutrum ; -- SaldoWN -- comment=10
lin renew_V2 = mkV2 (mkV "förnya"); -- status=guess, src=wikt
lin gardenerMasc_N = variants{} ; -- 
lin dilemma_N = mkN "dilemma" "dilemmat" "dilemman" "dilemmana" ; -- SaldoWN
lin configuration_N = mkN "gestaltning" ; -- comment=2
lin rear_A = variants{} ; -- 
lin embark_V2 = variants{} ; -- 
lin embark_V = variants{} ; -- 
lin misery_N = mkN "elände" ; -- SaldoWN
lin importantly_Adv = variants{} ; -- 
lin continually_Adv = variants{} ; -- 
lin appreciation_N = mkN "värdestegring" ; -- comment=7
lin radical_N = mkN "radikal" "radikaler" ; -- SaldoWN
lin diverse_A = mkA "olik" ; -- comment=2
lin revive_V2 = mkV2 (mkV "återuppliva"); -- status=guess, src=wikt
lin revive_V = mkV "återupplivar" ; -- comment=3
lin trip_V = mkV "utlöser" ; -- comment=8
lin lounge_N = mkN "soffa" | mkN "slöande" ; -- SaldoWN -- comment=4
lin dwelling_N = mkN "boning" ; -- comment=2
lin parental_A = mkA "förälderlig" ; --- should be föräldra-
lin loyal_A = mkA "lojal" ; -- SaldoWN
lin privatisation_N = variants{} ; -- 
lin outsider_N = mkN "outsider" "outsidern" "outsider" "outsiderna" ; -- status=guess
lin forbid_V2 = mkV2 "förbjuda" "förbjöd" "förbjudit" ; -- status=guess
lin yep_Interj = variants{} ; -- 
lin prospective_A = mkA "presumtiv" ; -- comment=2
lin manuscript_N = mkN "manuskript" neutrum | mkN "manuskript" neutrum ; -- SaldoWN -- comment=2
lin inherent_A = mkA "inneboende" ; -- comment=4
lin deem_V2V = variants{} ; -- 
lin deem_V2A = variants{} ; -- 
lin deem_V2 = variants{} ; -- 
lin telecommunication_N = variants{} ; -- 
lin intermediate_A = mkA "mellanliggande" | mkA "intermediär" ; -- SaldoWN
lin worthwhile_A = variants{} ; -- 
lin calendar_N = mkN "kalender" | mkN "register" neutrum ; -- SaldoWN -- comment=7
lin basin_N = mkN "handfat" neutrum | mkN "bassäng" "bassänger" ; -- SaldoWN -- comment=11
lin utterly_Adv = variants{} ; -- 
lin rebuild_V2 = variants{} ; -- 
lin pulse_N = mkN "slå" ; -- comment=6
lin suppress_V2 = mkV2 (mkV "undertrycker"); -- status=guess, src=wikt
lin predator_N = mkN "rovdjur" neutrum | (mkN "rovdjur" neutrum) | (mkN "predator" "predatorer") ; -- SaldoWN -- status=guess status=guess
lin width_N = mkN "bredd" "bredder" | mkN "våd" "våder" ; -- SaldoWN -- comment=3
lin stiff_A = mkA "styv" ; -- comment=25
lin spine_N = mkN "tagg" ; -- SaldoWN
lin betray_V2 = mkV2 "bedra" "bedrar" "bedra" "bedrog" "bedragit" "bedragen" | mkV2 (mkV "förråder") ; -- SaldoWN -- status=guess, src=wikt
lin punish_V2 = mkV2 (mkV "straffar"); -- status=guess, src=wikt
lin stall_N = mkN "bås" neutrum | mkN "motorstopp" neutrum ; -- SaldoWN -- comment=7
lin lifestyle_N = variants{} ; -- 
lin compile_V2 = mkV2 (mkV "sammanställer") ; -- status=guess, src=wikt
lin arouse_V2V = variants{}; -- dirV2 (partV (mkV "komma" "kom" "kommit")"vid"); -- comment=5
lin arouse_V2 = dirV2 (partV (mkV "komma" "kom" "kommit")"vid"); -- comment=5
lin partially_Adv = variants{} ; -- 
lin headline_N = mkN "rubrik" "rubriker" ; -- SaldoWN
lin divine_A = mkA "gudomlig" ; -- comment=3
lin unpleasant_A = mkA "obehaglig" | mkA "otrevlig" ; -- SaldoWN -- comment=3
lin sacred_A = mkA "sakral" ; -- SaldoWN
lin useless_A = mkA "värdelös" | mkA "onyttig" ; -- SaldoWN -- comment=9
lin cool_V2 = mkV2 (mkV "svalnar"); -- status=guess, src=wikt
lin cool_V = mkV "svalnar" ; -- comment=7
lin tremble_V = mkV "ängslar" ; -- comment=8
lin statue_N = mkN "staty" "statyer" ; -- SaldoWN
lin obey_V2 = mkV2 "lyda" "lydde" "lytt" | mkV2 (mkV "lyda" "lydde" "lytt") ; -- SaldoWN -- status=guess, src=wikt
lin obey_V = mkV "lyda" "lydde" "lytt" ; -- SaldoWN
lin drunk_A = compoundA (regA "berusad"); -- comment=6
lin tender_A = mkA "öm" "ömt" "ömma" "ömma" "ömmare" "ömmast" "ömmaste" ; -- SaldoWN
lin molecular_A = mkA "molekylär" ; -- SaldoWN
lin circulate_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- status=guess
lin circulate_V = mkV "sprida" "spred" "spritt" ; -- comment=2
lin exploitation_N = mkN "exploatering" ; -- comment=3
lin explicitly_Adv = variants{} ; -- 
lin utterance_N = variants{} ; -- 
lin linear_A = mkA "linjär" ; -- SaldoWN
lin chat_V = mkV "pratar" ; -- comment=4
lin revision_N = variants{} ; -- 
lin distress_N = mkN "svårighet" "svårigheter" ; -- comment=11
lin spill_V2 = mkV2 (mkV "spiller"); -- status=guess, src=wikt
lin spill_V = mkV "spiller" ; -- comment=2
lin steward_N = mkN "steward" ; -- SaldoWN
lin knight_N = mkN "riddare" utrum; -- comment=3
lin sum_V2 = mkV2 (mkV "adderar") | mkV2 (mkV "summerar"); -- status=guess, src=wikt status=guess, src=wikt
lin sum_V = mkV "summar" ; -- status=guess
lin semantic_A = mkA "semantisk" ; -- SaldoWN
lin selective_A = mkA "selektiv" ; -- status=guess
lin learner_N = variants{} ; -- 
lin dignity_N = mkN "värdighet" "värdigheter" | mkN "ädelhet" ; -- SaldoWN -- comment=2
lin senate_N = mkN "senat" "senater" ; -- SaldoWN
lin grid_N = mkN "gitter" neutrum; -- comment=5
lin fiscal_A = mkA "skattemässig" ; -- status=guess
lin activate_V2 = mkV2 (mkV "aktiverar"); -- status=guess, src=wikt
lin rival_A = variants{} ; -- 
lin fortunate_A = mkA "gynnsam" "gynnsamt" "gynnsamma" "gynnsamma" "gynnsammare" "gynnsammast" "gynnsammaste" ; -- comment=2
lin jeans_N = variants{} ; -- 
lin select_A = mkA "utvald" "utvalt" ; -- comment=2
lin fitting_N = mkN "passande" ; -- comment=2
lin commentator_N = mkN "kommentator" "kommentatorer" ; -- status=guess
lin weep_V2 = mkV2 "gråta" "grät" "gråtit" ; -- status=guess
lin weep_V = mkV "gråta" "grät" "gråtit" ; -- SaldoWN
lin handicap_N = mkN "handikapp" neutrum; -- status=guess
lin crush_V2 = mkV2 (mkV "krossar"); -- status=guess, src=wikt
lin crush_V = mkV "krossar" ; -- comment=10
lin towel_N = mkN "handduk" ; -- SaldoWN
lin stay_N = mkN "vistelse" "vistelser" ; -- comment=5
lin skilled_A = mkA "skicklig" ; -- SaldoWN
lin repeatedly_Adv = mkAdv "stundligen" ; -- status=guess
lin defensive_A = mkA "defensiv" ; -- SaldoWN
lin calm_V2 = mkV2 (mkV (mkV "lugna") "sig"); -- status=guess, src=wikt
lin calm_V = mkV "lugnar" ; -- comment=5
lin temporarily_Adv = variants{} ; -- 
lin rain_V2 = mkV2 (mkV "ösregna") | mkV2 (mkV "spöregna") | mkV2 (mkV (mkV "stå") "som spön i backen"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rain_V = mkV "regnar" ; -- status=guess
lin pin_N = mkN "PIN-kod" "PIN-koder" | mkN "skruv" ; -- SaldoWN -- comment=13
lin villa_N = mkN "lyxvilla" ; -- SaldoWN
lin rod_N = mkN "stav" "stäver" ; -- comment=7
lin frontier_N = mkN "gränsområde" ; -- comment=5
lin enforcement_N = mkN "kronofogde" utrum | mkN "genomdrivande" ; -- SaldoWN -- comment=4
lin protective_A = variants{} ; -- 
lin philosophical_A = mkA "filosofisk" | mkA "lugn" ; -- SaldoWN -- comment=2
lin lordship_N = variants{} ; -- 
lin disagree_VS = variants{}; -- mkV "ogillar" ;
lin disagree_V2 = variants{}; -- mkV "ogillar" ;
lin disagree_V = mkV "ogillar" ; -- status=guess
lin boyfriend_N = mkN "pojkvän" "pojkvännen" "pojkvänner" "pojkvännerna" ; -- SaldoWN
lin activistMasc_N = variants{} ; -- 
lin viewer_N = mkN "betraktare" utrum; -- comment=4
lin slim_A = mkA "slank" ; -- comment=9
lin textile_N = mkN "textil" "textiler" ; -- SaldoWN
lin mist_N = mkN "dimma" ; -- SaldoWN
lin harmony_N = mkN "harmoni" "harmonier" ; -- SaldoWN
lin deed_N = mkN "gärning" ; -- comment=4
lin merge_V2 = mkV2 (mkV "sammansmälter") | mkV2 (mkV (mkV "gå" "gick" "gått") "ihop") | mkV2 (mkV "fusionerar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin merge_V = mkV "sammanfogar" ; -- status=guess
lin invention_N = mkN "uppfinning" ; -- comment=4
lin commissioner_N = mkN "utredare" utrum; -- comment=7
lin caravan_N = mkN "karavan" "karavaner" ; -- comment=2
lin bolt_N = mkN "bult" | mkN "tygrulle" utrum ; -- SaldoWN -- comment=11
lin ending_N = mkN "slut" neutrum; -- comment=3
lin publishing_N = variants{} ; -- 
lin gut_N = L.guts_N;
lin stamp_V2 = dirV2 (partV (mkV "stämplar")"ut"); -- comment=4
lin stamp_V = mkV "utrotar" ; -- comment=11
lin map_V2 = mkV2 (mkV "kartlägga" "kartlade" "kartlagt") ; -- status=guess
lin loud_Adv = variants{} ; -- 
lin stroke_V2 = mkV2 (mkV "slå" "slog" "slagit"); -- status=guess, src=wikt
lin shock_V2 = variants{} ; -- 
lin rug_N = mkN "tupé" "tupéer" ; -- comment=2
lin picture_V2 = dirV2 (partV (mkV "målar")"om"); -- comment=3
lin slip_N = mkN "halka" | mkN "underkjol" ; -- SaldoWN -- comment=13
lin praise_N = mkN "pris" ; -- comment=15
lin fine_N = mkN "fint" "finter" ; -- comment=12
lin monument_N = mkN "minnesmärke" ; -- comment=6
lin material_A = mkA "textil" | mkA "väsentlig" ; -- SaldoWN -- comment=5
lin garment_N = mkN "plagg" neutrum | mkN "klädesplagg" neutrum ; -- SaldoWN -- comment=3
lin toward_Prep = mkPrep "mot" ;
lin realm_N = mkN "sfär" ; -- status=guess
lin melt_V2 = mkV2 (mkV "smälter"); -- status=guess, src=wikt
lin melt_V = mkV "veknar" ; -- comment=5
lin reproduction_N = mkN "reproduktion" "reproduktioner" ; -- SaldoWN
lin reactor_N = mkN "reaktor" "reaktorer" ; -- SaldoWN
lin furious_A = mkA "våldsam" "våldsamt" "våldsamma" "våldsamma" "våldsammare" "våldsammast" "våldsammaste" ; -- comment=4
lin distinguished_A = variants{} ; -- 
lin characterize_V2 = variants{} ; -- 
lin alike_Adv = variants{} ; -- 
lin pump_N = mkN "pumpa" ; -- SaldoWN
lin probe_N = mkN "undersökning" ; -- comment=2
lin feedback_N = mkN "återkoppling" ; -- SaldoWN
lin aspiration_N = mkN "sträva" ; -- comment=2
lin suspect_N = mkN "misstro" ; -- comment=2
lin solar_A = mkA "solar" ; -- SaldoWN
lin fare_N = mkN "avgift" "avgifter" | mkN "körning" ; -- SaldoWN -- comment=5
lin carve_V2 = mkV2 "skära" "skar" "skurit" ; -- SaldoWN
lin carve_V = mkV "skära" "skar" "skurit" | mkV "snidar" ; -- SaldoWN -- comment=13
lin qualified_A = variants{} ; -- 
lin membrane_N = mkN "membran" neutrum; -- comment=2
lin dependence_N = mkN "beroende" ; -- SaldoWN = mkN "beroende" ;
lin convict_V2 = variants{} ; -- 
lin bacteria_N = mkN "bakterie" "bakterier" ; -- status=guess
lin trading_N = variants{} ; -- 
lin ambassador_N = mkN "ambassadör" "ambassadörer" ; -- comment=2
lin wound_V2 = mkV2 "sår" | mkV2 (mkV "såra") ; -- SaldoWN -- status=guess, src=wikt
lin drug_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin conjunction_N = mkN "förbindelse" "förbindelser" ; -- comment=5
lin cabin_N = mkN "stuga" | mkN "hytt" "hytter" ; -- SaldoWN -- comment=9
lin trail_V2 = dirV2 (partV (mkV "släpar")"ut"); -- comment=4
lin trail_V = mkV "väger" ; -- comment=7
lin shaft_N = mkN "skaft" neutrum | mkN "skaft" neutrum ; -- SaldoWN -- comment=2
lin treasure_N = mkN "skatt" "skatter" | mkN "klenod" "klenoder" ; -- SaldoWN = mkN "skatt" "skatter" ; -- comment=5
lin inappropriate_A = compoundA (regA "malplacerad"); -- status=guess
lin half_Adv = variants{} ; -- 
lin attribute_N = mkN "attribut" neutrum; -- comment=5
lin liquid_A = mkA "likvid" ; -- SaldoWN
lin embassy_N = mkN "ambassad" "ambassader" ; -- SaldoWN
lin terribly_Adv = variants{} ; -- 
lin exemption_N = mkN "immunitet" "immuniteter" | mkN "dispens" "dispenser" ; -- SaldoWN -- comment=4
lin array_N = mkN "stass" ; -- comment=3
lin tablet_N = mkN "tablett" "tabletter" | mkN "skrivtavla" ; -- SaldoWN -- comment=9
lin sack_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till"); -- comment=3
lin erosion_N = mkN "erosion" "erosioner" | mkN "erodering" ; -- SaldoWN
lin bull_N = mkN "tjur" ; -- comment=6
lin warehouse_N = mkN "lagerlokal" "lagerlokaler" ; -- status=guess
lin unfortunate_A = mkA "olycklig" ; -- SaldoWN
lin promoter_N = mkN "promotor" "promotorer" ; -- comment=5
lin compel_VV = variants{} ; -- 
lin compel_V2V = variants{} ; -- 
lin compel_V2 = variants{} ; -- 
lin motivate_V2V = mkV2V (mkV "motiverar"); -- status=guess, src=wikt
lin motivate_V2 = mkV2 (mkV "motiverar"); -- status=guess, src=wikt
lin burning_A = variants{} ; -- 
lin vitamin_N = mkN "vitamin" "vitaminer" ; -- SaldoWN
lin sail_N = mkN "kryssning" | mkN "segel" neutrum ; -- SaldoWN
lin lemon_N = mkN "citron" "citroner" ; -- SaldoWN
lin foreigner_N = mkN "utlänning" ; -- SaldoWN
lin powder_N = mkN "pulver" neutrum | mkN "stoft" neutrum ; -- SaldoWN -- comment=3
lin persistent_A = mkA "ihärdig" ; -- SaldoWN
lin bat_N = mkN "fladdermus" "fladdermusen" "fladdermöss" "fladdermössen" | mkN "piska" ; -- SaldoWN -- comment=9
lin ancestor_N = mkN "anfader" "anfadern" "anfäder" "anfäderna" ; -- comment=2
lin predominantly_Adv = variants{} ; -- 
lin mathematical_A = mkA "matematisk" ; -- SaldoWN
lin compliance_N = mkN "tillmötesgående" ; -- SaldoWN
lin arch_N = mkN "valv" neutrum | mkN "hålfot" "hålfötter" ; -- SaldoWN -- comment=7
lin woodland_N = mkN "skogsland" neutrum; -- comment=3
lin serum_N = mkN "serum" neutrum | mkN "serum" neutrum ; -- SaldoWN
lin overnight_Adv = variants{} ; -- 
lin doubtful_A = mkA "tvivelaktig" ; -- comment=5
lin doing_N = variants{} ; -- 
lin coach_V2 = mkV2 (mkV "träna") | mkV2 (mkV "coacha"); -- status=guess, src=wikt status=guess, src=wikt
lin coach_V = mkV "tränar" ; -- status=guess
lin binding_A = variants{} ; -- 
lin surrounding_A = mkA "kringliggande" ; -- status=guess
lin peer_N = mkN "pär" "pärer" ; -- comment=5
lin ozone_N = mkN "ozon" ; -- SaldoWN
lin mid_A = variants{} ; -- 
lin invisible_A = mkA "osynlig" ; -- SaldoWN
lin depart_V = mkV "avvika" "avvek" "avvikit" | mkV "avreser" ; -- SaldoWN -- comment=4
lin brigade_N = mkN "brigad" "brigader" | mkN "grupp" "grupper" ; -- SaldoWN -- comment=3
lin manipulate_V2 = mkV2 (mkV "manipulerar"); -- status=guess, src=wikt
lin consume_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin consume_V = mkV "förtära" "förtärde" "förtärt" ; -- comment=7
lin temptation_N = mkN "frestelse" "frestelser" | mkN "lockelse" "lockelser" ; -- SaldoWN -- comment=2
lin intact_A = mkA "intakt" "intakt" ; -- status=guess
lin glove_N = L.glove_N ;
lin aggression_N = mkN "aggression" "aggressioner" ; -- comment=3
lin emergence_N = mkN "uppkomst" ; -- comment=3
lin stag_V = variants{} ; -- 
lin coffin_N = mkN "kista" | mkN "likkista" ; -- SaldoWN
lin beautifully_Adv = variants{} ; -- 
lin clutch_V2 = variants{}; -- mkV "gripa" "grep" "gripit" ; -- comment=4
lin clutch_V = mkV "gripa" "grep" "gripit" ; -- comment=4
lin wit_N = mkN "slagfärdighet" ; -- comment=5
lin underline_V2 = mkV2 "understryka" "underströk" "understrukit" | mkV2 (mkV (mkV "stryka") "under") ; -- SaldoWN -- status=guess, src=wikt
lin trainee_N = mkN "praktikant" "praktikanter" ; -- comment=5
lin scrutiny_N = mkN "granskning" ; -- status=guess
lin neatly_Adv = variants{} ; -- 
lin follower_N = mkN "anhängare" utrum; -- comment=5
lin sterling_A = mkA "fullödig" ; -- comment=3
lin tariff_N = mkN "tariff" "tariffer" | mkN "taxa" ; -- SaldoWN -- comment=3
lin bee_N = mkN "bi" "bit" "bin" "bien" ; -- SaldoWN
lin relaxation_N = mkN "avkoppling" | mkN "avslappning" ; -- SaldoWN -- comment=10
lin negligence_N = mkN "försummelse" "försummelser" | mkN "vårdslöshet" "vårdslösheter" ; -- SaldoWN -- comment=6
lin sunlight_N = mkN "solljus" neutrum; -- status=guess
lin penetrate_V2 = mkV2 (mkV "genomtränger") | mkV2 (mkV "penetrerar"); -- status=guess, src=wikt status=guess, src=wikt
lin penetrate_V = mkV "penetrerar" ; -- comment=5
lin knot_N = mkN "knut" | mkN "föreningspunkt" "föreningspunkter" ; -- SaldoWN -- comment=12
lin temper_N = mkN "humör" neutrum; -- status=guess
lin skull_N = mkN "dödskalle" utrum | mkN "kranium" "kraniet" "kranier" "kranierna" ; -- SaldoWN -- comment=3
lin openly_Adv = variants{} ; -- 
lin grind_V2 = dirV2 (partV (mkV "skrapar")"ut"); -- comment=3
lin grind_V = mkV "slipar" ; -- comment=14
lin whale_N = mkN "val" ; -- SaldoWN = mkN "val" neutrum ;
lin throne_N = mkN "tron" "troner" | mkN "biskopsstol" ; -- SaldoWN -- comment=3
lin supervise_V2 = variants{}; -- mkV "övervakar" ; -- comment=7
lin supervise_V = mkV "övervakar" ; -- comment=7
lin sickness_N = mkN "sjukdom" ; -- SaldoWN
lin package_V2 = mkV2 (mkV "packar"); -- status=guess, src=wikt
lin intake_N = mkN "intagning" ; -- comment=3
lin within_Adv = variants{}; -- mkPrep "inom" ;
lin inland_A = variants{} ; -- 
lin beast_N = mkN "best" ; -- comment=8
lin rear_N = mkN "baksida" ; -- comment=4
lin morality_N = mkN "moral" "moraler" ; -- status=guess
lin competent_A = mkA "kompetent" "kompetent" | mkA "tillräcklig" ; -- SaldoWN -- comment=10
lin sink_N = mkN "vask" neutrum | mkN "vask" neutrum ; -- SaldoWN = mkN "vask" ; -- comment=8
lin uniform_A = mkA "uniform" ; -- SaldoWN
lin reminder_N = mkN "påminnelse" "påminnelser" ; -- comment=4
lin permanently_Adv = variants{} ; -- 
lin optimistic_A = mkA "optimistisk" ; -- SaldoWN
lin bargain_N = mkN "affärsuppgörelse" "affärsuppgörelser" ; -- comment=3
lin seemingly_Adv = variants{} ; -- 
lin respective_A = mkA "respektive" ; -- status=guess
lin horizontal_A = mkA "vågrät" | mkA "horisontal" ; -- SaldoWN -- comment=3
lin decisive_A = mkA "avgörande" | mkA "fast" "fast" ; -- SaldoWN -- comment=5
lin bless_V2 = mkV2 (mkV "välsigna"); -- status=guess, src=wikt
lin bile_N = mkN "galla" ; -- comment=3
lin spatial_A = mkA "spatial" ; -- SaldoWN
lin bullet_N = mkN "kula" ; -- SaldoWN
lin respectable_A = mkA "anständig" | mkA "respektabel" ; -- SaldoWN -- comment=3
lin overseas_Adv = mkAdv "utomlands" ; -- comment=2
lin convincing_A = mkA "övertygande" ; -- comment=3
lin unacceptable_A = mkA "oacceptabel" ; -- status=guess
lin confrontation_N = mkN "konfrontation" "konfrontationer" ; -- SaldoWN
lin swiftly_Adv = variants{} ; -- 
lin paid_A = variants{} ; -- 
lin joke_V = mkV "skämtar" ; -- comment=4
lin instant_A = mkA "omedelbar" ; -- comment=2
lin illusion_N = mkN "illusion" "illusioner" | mkN "synvilla" ; -- SaldoWN -- comment=5
lin cheer_V2 = mkV2 (mkV "hurrar") | mkV2 (mkV "hejar"); -- status=guess, src=wikt status=guess, src=wikt
lin cheer_V = mkV "jublar" ; -- comment=3
lin congregation_N = variants{} ; -- 
lin worldwide_Adv = variants{} ; -- 
lin winning_A = variants{} ; -- 
lin wake_N = mkN "likvaka" | mkN "väcka" ; -- SaldoWN -- comment=3
lin toss_V2 = dirV2 (partV (mkV "kastar")"ut"); -- comment=8
lin toss_V = mkV "kastar" ; -- comment=5
lin medium_A = mkA "medel" ; -- status=guess
lin jewellery_N = mkN "juvel" "juveler" ; -- comment=2
lin fond_A = mkA "meningslös" ; -- comment=6
lin alarm_V2 = variants{} ; -- 
lin guerrilla_N = mkN "gerilla" ; -- SaldoWN
lin dive_V = mkV "dyker" ; -- comment=2
lin desire_V2 = mkV2 (mkV "begära") | mkV2 (mkV "åtrå"); -- status=guess, src=wikt status=guess, src=wikt
lin cooperation_N = mkN "samarbete" | mkN "kooperation" "kooperationer" ; -- SaldoWN -- comment=2
lin thread_N = mkN "tråd" | mkN "trä" "träet" "trän" "träna" ; -- SaldoWN -- comment=7
lin prescribe_V2 = mkV2 (mkV (mkV "skriva") "ut"); -- status=guess, src=wikt
lin prescribe_V = mkV "bestämmer" ; -- comment=7
lin calcium_N = mkN "kalcium" neutrum; -- status=guess
lin redundant_A = mkA "redundant" "redundant" ; -- status=guess
lin marker_N = mkN "märkpenna" ; -- comment=5
lin chemistMasc_N = variants{} ; -- 
lin mammal_N = mkN "däggdjur" neutrum | mkN "däggdjur" neutrum ; -- SaldoWN
lin legacy_N = mkN "legat" neutrum; -- comment=3
lin debtor_N = mkN "gäldenär" "gäldenärer" ; -- SaldoWN
lin testament_N = variants{} ; -- 
lin tragic_A = mkA "tragisk" ; -- SaldoWN
lin silver_A = mkA "silvergrå" "silvergrått" ; -- comment=2
lin grin_N = mkN "grin" neutrum; -- comment=3
lin spectacle_N = mkN "syn" ; -- comment=4
lin inheritance_N = mkN "arv" neutrum; -- comment=3
lin heal_V2 = variants{}; -- mkV "läker" ; -- comment=7
lin heal_V = mkV "läker" ; -- comment=7
lin sovereignty_N = mkN "självständighet" | mkN "oavhängighet" | mkN "suveränitet" ; -- status=guess status=guess status=guess
lin enzyme_N = mkN "enzym" neutrum ; -- SaldoWN
lin host_V2 = variants{} ; -- 
lin neighbouring_A = variants{} ; -- 
lin corn_N = mkN "majs" | mkN "vete" ; -- SaldoWN -- comment=10
lin layout_N = mkN "layout" "layouter" ; -- SaldoWN
lin dictate_VS = variants{}; -- mkV "dikterar" ; -- comment=4
lin dictate_V2 = variants{}; -- mkV "dikterar" ; -- comment=4
lin dictate_V = mkV "dikterar" ; -- comment=4
lin rip_V2 = variants{}; -- mkV "revar" ; -- comment=2
lin rip_V = mkV "revar" ; -- comment=2
lin regain_V2 = variants{} ; -- 
lin probable_A = mkA "trolig" ; -- comment=5
lin inclusion_N = mkN "inbegripande" ; -- status=guess
lin booklet_N = mkN "häfte" ; -- comment=3
lin bar_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=7
lin privately_Adv = variants{} ; -- 
lin laser_N = mkN "laser" ; -- SaldoWN
lin fame_N = mkN "berömmelse" utrum | mkN "berömmelse" utrum ; -- SaldoWN -- comment=4
lin bronze_N = mkN "brons" "bronser" | mkN "brons" neutrum ; -- SaldoWN = mkN "brons" neutrum ; -- comment=4
lin mobile_A = mkA "rörlig" | mkA "mobil" ; -- SaldoWN -- comment=6
lin metaphor_N = mkN "metafor" "metaforen" "metaforer" "metaforerna" ; -- SaldoWN
lin complication_N = mkN "komplikation" "komplikationer" ; -- SaldoWN
lin narrow_V2 = variants{}; -- mkV "begränsar" ; -- comment=2
lin narrow_V = mkV "begränsar" ; -- comment=2
lin old_fashioned_A = variants{} ; -- 
lin chop_V2 = dirV2 (partV (mkV "hackar")"av"); -- status=guess
lin chop_V = mkV "hugga" "högg" "huggit" ; -- comment=4
lin synthesis_N = mkN "syntes" "synteser" ; -- comment=2
lin diameter_N = mkN "diameter" ; -- SaldoWN
lin bomb_V2 = mkV2 (mkV "bombardera" | mkV "bombar") ; -- status=guess
lin bomb_V = mkV "bombar" ; -- comment=3
lin silently_Adv = variants{} ; -- 
lin shed_N = mkN "fälla" ; -- comment=3
lin fusion_N = mkN "sammansmältning" ; -- comment=5
lin trigger_V2 = dirV2 (partV (mkV "startar")"om"); -- status=guess
lin printing_N = variants{} ; -- 
lin onion_N = mkN "lök" ; -- SaldoWN
lin dislike_V2 = mkV2 (mkV (mkV "tycker") "illa") (mkPrep "om"); -- status=guess
lin embody_V2 = mkV2 (mkV "förkroppsliga"); -- status=guess, src=wikt
lin curl_V = mkV "ringer" ; -- comment=7
lin sunshine_N = mkN "solsken" neutrum | mkN "solsken" neutrum ; -- SaldoWN
lin sponsorship_N = variants{} ; -- 
lin rage_N = mkN "ilska" | mkN "ursinne" ; -- SaldoWN -- comment=2
lin loop_N = mkN "slinga" | mkN "ögla" ; -- SaldoWN -- comment=6
lin halt_N = mkN "anhalt" "anhalter" | mkN "stopp" ; -- SaldoWN -- comment=10
lin cop_V2 = variants{}; -- mkV "haffar" ; -- comment=2
lin bang_V2 = dirV2 (partV (mkV "smälla" "small" "smäll")"av"); -- comment=16
lin bang_V = mkV "smälla" "small" "smäll" ; -- comment=10
lin toxic_A = mkA "giftig" ; -- SaldoWN
lin thinking_A = variants{} ; -- 
lin orientation_N = mkN "riktning" | mkN "orientering" ; -- SaldoWN -- comment=2
lin likelihood_N = mkN "sannolikhet" "sannolikheter" ; -- status=guess
lin wee_A = mkA "liten" "litet" "lilla" "små" "mindre" "minst" "minsta" ; -- status=guess
lin up_to_date_A = variants{} ; -- 
lin polite_A = mkA "artig" | compoundA (regA "bildad") ; -- SaldoWN -- comment=7
lin apology_N = mkN "avbön" "avböner" | mkN "ursäkt" "ursäkter" ; -- SaldoWN -- comment=4
lin exile_N = mkN "utvisning" | mkN "landsflykting" ; -- SaldoWN -- comment=4
lin brow_N = mkN "ögonbryn" neutrum; -- comment=6
lin miserable_A = mkA "olycklig" ; -- comment=10
lin outbreak_N = mkN "utbrott" neutrum; -- status=guess
lin comparatively_Adv = variants{} ; -- 
lin pump_V2 = dirV2 (partV (mkV "pumpar")"in"); -- status=guess
lin pump_V = mkV "öser" ; -- comment=2
lin fuck_V2 = dirV2 (mkV "knullar") ; -- status=guess
lin fuck_V = mkV "knullar" ; -- status=guess
lin forecast_VS = mkVS (mkV "förutsäga" "förutsade" "förutsagt") | mkVS (mkV "förutse" "förutsåg" "förutsett") ; -- status=guess
lin forecast_V2 = mkV2 (mkV "förutsäga" "förutsade" "förutsagt") | mkV2 (mkV "förutse" "förutsåg" "förutsett") ; -- status=guess
lin forecast_V = mkV "förutsäga" "förutsade" "förutsagt" ; -- comment=3
lin timing_N = mkN "kamrem" ; -- status=guess
lin headmaster_N = mkN "rektor" "rektorer" ; -- comment=2
lin terrify_V2 = variants{} ; -- 
lin sigh_N = mkN "suck" ; -- comment=2
lin premier_A = mkA "förnäm" "förnämare" "förnämst" ; -- status=guess
lin joint_N = mkN "led" "leder" | mkN "hak" neutrum ; -- SaldoWN = mkN "led" neutrum ; = mkN "led" neutrum ; -- comment=11
lin incredible_A = mkA "otrolig" ; -- SaldoWN
lin gravity_N = mkN "gravitation" "gravitationer" ; -- SaldoWN
lin regulatory_A = variants{} ; -- 
lin cylinder_N = mkN "cylinder" ; -- SaldoWN
lin curiosity_N = mkN "nyfikenhet" "nyfikenheter" ; -- comment=6
lin resident_A = mkA "bosatt" | mkA "bofast" "bofast" ; -- SaldoWN -- comment=2
lin narrative_N = mkN "berättelse" "berättelser" | mkN "berättande" ; -- SaldoWN -- comment=3
lin cognitive_A = mkA "kognitiv" ; -- status=guess
lin lengthy_A = mkA "omständlig" ; -- comment=2
lin gothic_A = mkA "gotisk" ; -- status=guess
lin dip_V2 = dirV2 (partV (mkV "tvättar")"av"); -- status=guess
lin dip_V = mkV "sänker" ; -- comment=11
lin adverse_A = variants{} ; -- 
lin accountability_N = mkN "tillräknelighet" ; -- status=guess
lin hydrogen_N = mkN "väte" ; -- comment=2
lin gravel_N = mkN "grus" neutrum ; -- SaldoWN
lin willingness_N = variants{} ; -- 
lin inhibit_V2 = mkV2 (mkV "hämma") | mkV2 (mkV (mkV "att") "avstyra") | mkV2 (mkV (mkV "att") "förhindra"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin attain_V2 = variants{}; -- mkV "förvärvar" ;
lin attain_V = mkV "förvärvar" ; -- status=guess
lin specialize_V2 = variants{} ; -- 
lin specialize_V = variants{} ; -- 
lin steer_V2 = mkV2 (mkV "styra" "styrde" "styrt"); -- status=guess, src=wikt
lin steer_V = mkV "styra" "styrde" "styrt" ; -- status=guess
lin selected_A = mkA "utvald" "utvalt" ; -- status=guess
lin like_N = mkN "liknande" ; -- comment=2
lin confer_V = mkV "tilldelar" ; -- comment=5
lin usage_N = mkN "språkbruk" neutrum; -- comment=10
lin portray_V2 = variants{} ; -- 
lin planner_N = variants{} ; -- 
lin manual_A = mkA "manuell" ; -- SaldoWN
lin boast_VS = mkVS (mkV "skryta" "skröt" "skrutit") | mkVS (mkV "skrävla"); -- status=guess, src=wikt status=guess, src=wikt
lin boast_V2 = mkV2 (mkV "skryta" "skröt" "skrutit") | mkV2 (mkV "skrävla"); -- status=guess, src=wikt status=guess, src=wikt
lin boast_V = mkV "skryta" "skröt" "skrutit" ; -- comment=2
lin unconscious_A = mkA "medvetslös" ; -- comment=4
lin jail_N = mkN "arrest" "arrester" ; -- comment=3
lin fertility_N = mkN "fruktsamhet" ; -- comment=5
lin documentation_N = mkN "dokumentation" "dokumentationer" ; -- comment=2
lin wolf_N = mkN "varg" ; -- SaldoWN
lin patent_N = mkN "patent" neutrum | mkN "patent" neutrum ; -- SaldoWN
lin exit_N = mkN "utgång" ; -- SaldoWN
lin corps_N = mkN "kår" "kårer" ; -- status=guess
lin proclaim_VS = mkVS (mkV "förkunna"); -- status=guess, src=wikt
lin proclaim_V2 = dirV2 (partV (mkV "visar")"in"); -- status=guess
lin multiply_V2 = mkV2 (mkV "multiplicerar"); -- status=guess, src=wikt
lin multiply_V = mkV "förökar" ; -- comment=3
lin brochure_N = mkN "broschyr" "broschyrer" ; -- SaldoWN
lin screen_V2 = dirV2 (partV (mkV "visar")"in"); -- comment=3
lin screen_V = mkV "visar" ; -- comment=21
lin orthodox_A = mkA "ortodox" | mkA "vedertagen" "vedertaget" ; -- SaldoWN -- comment=5
lin locomotive_N = mkN "lok" neutrum | mkN "lok" neutrum ; -- SaldoWN
lin considering_Prep = mkPrep "med hänsyn till" ; -- status=guess
lin unaware_A = mkA "omedveten" "omedvetet" ; -- SaldoWN
lin syndrome_N = mkN "syndrom" neutrum | mkN "syndrom" neutrum ; -- SaldoWN
lin reform_V2 = mkV2 (mkV "reformerar"); -- status=guess, src=wikt
lin reform_V = mkV "reformerar" ; -- status=guess
lin confirmation_N = mkN "styrkande" ; -- comment=6
lin printed_A = variants{} ; -- 
lin curve_V2 = mkV2 (mkV "böjer") | mkV2 (mkV "kröka"); -- status=guess, src=wikt status=guess, src=wikt
lin curve_V = mkV "böja" "böjde" "böjt" ; -- comment=6
lin costly_A = mkA "kostsam" "kostsamt" "kostsamma" "kostsamma" "kostsammare" "kostsammast" "kostsammaste" ; -- comment=4
lin underground_A = mkA "underjordisk" ; -- status=guess
lin territorial_A = mkA "territoriell" ; -- status=guess
lin designate_VS = variants{}; -- mkV2 (mkV "utse" "utsåg" "utsett");
lin designate_V2V = variants{}; -- mkV2 (mkV "utse" "utsåg" "utsett");
lin designate_V2 = mkV2 (mkV "utse" "utsåg" "utsett"); -- status=guess
lin designate_V = mkV "utse" "utsåg" "utsett" ; -- comment=8
lin comfort_V2 = variants{} ; -- 
lin plot_V2 = dirV2 (partV (mkV "ritar")"ut"); -- comment=3
lin plot_V = mkV "planerar" ; -- comment=7
lin misleading_A = variants{} ; -- 
lin weave_V2 = mkV2 (mkV "väva"); -- status=guess, src=wikt
lin weave_V = mkV "väver" ; -- status=guess
lin scratch_V2 = L.scratch_V2;
lin scratch_V = mkV "stryka" "strök" "strukit" ; -- comment=15
lin echo_N = mkN "eko" "ekot" "ekon" "ekona" ; -- SaldoWN
lin ideally_Adv = variants{} ; -- 
lin endure_V2 = variants{}; -- mkV "bestå" "bestod" "bestått" ; -- comment=6
lin endure_V = mkV "bestå" "bestod" "bestått" ; -- comment=6
lin verbal_A = mkA "muntlig" | mkA "verbal" ; -- SaldoWN -- comment=2
lin stride_V = mkV "kliva" "klev" "klivit" | mkV "skriva" "skrev" "skrivit" ; -- SaldoWN -- comment=5
lin nursing_N = mkN "vård" ; -- comment=6
lin exert_V2 = variants{} ; -- 
lin compatible_A = mkA "förenlig" ; -- SaldoWN
lin causal_A = variants{} ; -- 
lin mosaic_N = mkN "mosaik" "mosaiker" ; -- SaldoWN
lin manor_N = mkN "polisdistrikt" neutrum; -- comment=4
lin implicit_A = mkA "implicit" "implicit" | mkA "underförstådd" ; -- SaldoWN -- comment=7
lin following_Prep = mkPrep "efter" ; -- status=guess
lin fashionable_A = mkA "fashionabel" | mkA "moderiktig" ; -- SaldoWN -- comment=3
lin valve_N = mkN "klaff" ; -- comment=6
lin proceed_N = variants{} ; -- 
lin sofa_N = mkN "soffa" ; -- status=guess
lin snatch_V2 = variants{}; -- mkV "hugga" "högg" "huggit" ; -- comment=4
lin snatch_V = mkV "hugga" "högg" "huggit" ; -- comment=4
lin jazz_N = mkN "jazz" ; -- SaldoWN
lin patron_N = mkN "beskyddare" utrum; -- comment=5
lin provider_N = mkN "familjeförsörjare" utrum; -- status=guess
lin interim_A = mkA "provisorisk" ; -- status=guess
lin intent_N = mkN "uppsåt" neutrum; -- comment=3
lin chosen_A = variants{} ; -- 
lin applied_A = variants{} ; -- 
lin shiver_V = mkV "darrar" ; -- comment=5
lin pie_N = mkN "paj" "pajer" ; -- SaldoWN
lin fury_N = mkN "raseri" neutrum; -- comment=2
lin abolition_N = mkN "avskaffande" ; -- comment=4
lin soccer_N = mkN "fotboll" ; -- SaldoWN = mkN "fotboll" ;
lin corpse_N = mkN "lik" neutrum; -- status=guess
lin accusation_N = mkN "anklagelse" "anklagelser" ; -- comment=2
lin kind_A = mkA "snäll" | mkA "vänlig" ; -- SaldoWN -- comment=7
lin dead_Adv = mkAdv "absolut" ; -- comment=6
lin nursing_A = variants{} ; -- 
lin contempt_N = mkN "förakt" neutrum ; -- SaldoWN
lin prevail_V = mkV "segrar" ; -- comment=4
lin murderer_N = mkN "mördare" utrum | mkN "mördare" utrum ; -- SaldoWN
lin liberal_N = mkN "liberal" "liberaler" ; -- status=guess
lin gathering_N = mkN "sammankomst" "sammankomster" ; -- comment=3
lin adequately_Adv = variants{} ; -- 
lin subjective_A = mkA "subjektiv" ; -- SaldoWN
lin disagreement_N = mkN "oenighet" "oenigheter" | mkN "tvist" "tvister" ; -- SaldoWN -- comment=5
lin cleaner_N = mkN "städare" utrum; -- comment=2
lin boil_V2 = dirV2 (partV (mkV "kokar")"över"); -- comment=2
lin boil_V = mkV "kokar" ; -- comment=3
lin static_A = mkA "statisk" ; -- SaldoWN
lin scent_N = mkN "väderkorn" neutrum; -- comment=8
lin civilian_N = mkN "civilist" "civilister" ; -- SaldoWN
lin monk_N = mkN "munk" ; -- SaldoWN
lin abruptly_Adv = variants{} ; -- 
lin keyboard_N = mkN "tangentbord" neutrum; -- status=guess
lin hammer_N = mkN "hammare" "hammaren" "hamrar" "hamrarna" | mkN "hane" utrum ; -- SaldoWN -- comment=3
lin despair_N = mkN "sorgebarn" neutrum; -- status=guess
lin controller_N = mkN "ledare" utrum; -- comment=6
lin yell_V2 = variants{}; -- mkV "skrika" "skrek" "skrikit" ; -- comment=6
lin yell_V = mkV "skrika" "skrek" "skrikit" ; -- comment=6
lin entail_V2 = variants{} ; -- 
lin cheerful_A = mkA "gladlynt" "gladlynt" | mkA "villig" ; -- SaldoWN -- comment=8
lin reconstruction_N = mkN "rekonstruktion" "rekonstruktioner" ; -- comment=3
lin patience_N = mkN "tålamod" neutrum | mkN "uthållighet" "uthålligheter" ; -- SaldoWN -- comment=3
lin legally_Adv = variants{} ; -- 
lin habitat_N = mkN "boning" | mkN "livsmiljö" "livsmiljön" "livsmiljöer" "livsmiljöerna" ; -- SaldoWN
lin queue_N = mkN "kö" "kön" "köer" "köerna" ; -- SaldoWN
lin spectatorMasc_N = variants{} ; -- 
lin given_A = variants{} ; -- 
lin purple_A = variants{} ; -- 
lin outlook_N = mkN "åskådning" ; -- SaldoWN
lin genius_N = mkN "briljans" | mkN "väsen" neutrum ; -- SaldoWN -- comment=10
lin dual_A = variants{} ; -- 
lin canvas_N = mkN "smärting" | mkN "tält" neutrum ; -- SaldoWN -- comment=12
lin grave_A = mkA "grav" ; -- SaldoWN
lin pepper_N = mkN "paprika" ; -- status=guess
lin conform_V2 = variants{}; -- mkV "överensstämmer" ;
lin conform_V = mkV "överensstämmer" ; -- status=guess
lin cautious_A = mkA "aktsam" "aktsamt" "aktsamma" "aktsamma" "aktsammare" "aktsammast" "aktsammaste" | mkA "försiktig" ; -- SaldoWN -- comment=4
lin dot_N = mkN "punkt" "punkter" ; -- comment=3
lin conspiracy_N = mkN "komplott" "komplotter" ; -- SaldoWN
lin butterfly_N = mkN "fjäril" ; -- SaldoWN
lin sponsor_N = mkN "sponsor" "sponsorer" ; -- comment=4
lin sincerely_Adv = variants{} ; -- 
lin rating_N = mkN "värdering" ; -- comment=5
lin weird_A = mkA "kuslig" ; -- comment=6
lin teenage_A = mkA "tonårig" ; -- status=guess
lin salmon_N = mkN "lax" ; -- SaldoWN
lin recorder_N = mkN "blockflöjt" ; -- status=guess
lin postpone_V2 = mkV2 "senarelägga" "senarelade" "senarelagt" | mkV2 (mkV "uppskjuta" "uppsköt" "uppskjutit") ; -- status=guess
lin maid_N = mkN "piga" | mkN "ungmö" "ungmön" "ungmör" "ungmörna" ; -- SaldoWN -- comment=6
lin furnish_V2 = mkV2 (mkV "inreda" "inredde" "inrett") | mkV2 (mkV "möblera"); -- status=guess, src=wikt status=guess, src=wikt
lin ethical_A = mkA "etisk" ; -- SaldoWN
lin bicycle_N = mkN "cykel" ; -- comment=2
lin sick_N = mkN "illamående" ; -- comment=2
lin sack_N = mkN "cape" "caper" ; -- comment=11
lin renaissance_N = mkN "renässans" "renässanser" ; -- status=guess
lin luxury_N = mkN "lyx" ; -- comment=3
lin gasp_V2 = mkV2 (mkV "flämta") | mkV2 (mkV "kippar"); -- status=guess, src=wikt status=guess, src=wikt
lin gasp_V = mkV "flämtar" ; -- comment=2
lin wardrobe_N = mkN "garderob" "garderober" ; -- SaldoWN
lin native_N = mkN "inföding" ; -- status=guess
lin fringe_N = mkN "ytterkant" "ytterkanter" ; -- comment=6
lin adaptation_N = mkN "anpassning" ; -- comment=6
lin quotation_N = mkN "notering" | mkN "citerande" ; -- SaldoWN -- comment=12
lin hunger_N = mkN "hunger" ; -- status=guess
lin enclose_V2 = dirV2 (partV (mkV "sänder")"efter"); -- status=guess
lin disastrous_A = mkA "katastrofal" ; -- comment=3
lin choir_N = mkN "kor" neutrum; -- comment=2
lin overwhelming_A = variants{} ; -- 
lin glimpse_N = mkN "skymt" ; -- SaldoWN
lin divorce_V2 = dirV2 (partV (mkV "skiljer" "skilde" "skilt") "av"); -- comment=2
lin circular_A = mkA "cirkulär" ; -- comment=3
lin locality_N = mkN "lokalitet" "lokaliteter" ; -- comment=3
lin ferry_N = mkN "färja" ; -- SaldoWN
lin balcony_N = mkN "balkong" "balkonger" ; -- SaldoWN
lin sailor_N = mkN "sjöman" "sjömannen" "sjömän" "sjömännen" | mkN "seglare" utrum ; -- SaldoWN
lin precision_N = mkN "precision" "precisioner" ; -- SaldoWN
lin desert_V2 = variants{}; -- mkV "överge" "överger" "överge" "övergav" "övergett" "övergiven" ; -- comment=4
lin desert_V = mkV "överge" "överger" "överge" "övergav" "övergett" "övergiven" ; -- comment=4
lin dancing_N = mkN "dans" "danser" ; -- status=guess
lin alert_V2 = variants{} ; -- 
lin surrender_V2 = mkV2 (mkV (mkV "ge") "sig"); -- status=guess, src=wikt
lin surrender_V = mkV "överlämnar" ; -- comment=4
lin archive_N = mkN "arkiv" neutrum | mkN "förråd" neutrum ; -- SaldoWN -- comment=2
lin jump_N = mkN "hopp" neutrum | mkN "smita" ; -- SaldoWN -- comment=6
lin philosopher_N = mkN "filosof" "filosofer" ; -- SaldoWN
lin revival_N = mkN "återupplivande" ; -- SaldoWN
lin presume_VS = mkVS (mkV "förmoda") | mkVS (mkV "förutsätta" "förutsatte" "förutsatt") ; -- status=guess
lin presume_V2 = mkV2 (mkV "förmoda") | mkV2 (mkV "förutsätta" "förutsatte" "förutsatt") ; -- status=guess
lin presume_V = mkV "anta" "antar" "anta" "antog" "antagit" "antagen" ; -- comment=3
lin node_N = mkN "nod" "noder" ; -- SaldoWN
lin fantastic_A = mkA "fantastisk" ; -- comment=4
lin herb_N = mkN "ört" "örter" ; -- SaldoWN
lin assertion_N = mkN "påstående" ; -- SaldoWN
lin thorough_A = mkA "grundlig" ; -- comment=3
lin quit_V2 = mkV2 "lämna" | mkV2 (mkV "slutar") ; -- status=guess
lin quit_V = mkV "avgå" "avgick" "avgått" | mkV "slutar" | mkV "upphöra" "upphörde" "upphört" ; -- status=guess
lin grim_A = mkA "sträng" ; -- comment=11
lin fair_N = mkN "karneval" "karnevaler" | mkN "lovande" ; -- SaldoWN -- comment=3
lin broadcast_V2 = dirV2 (partV (mkV "talar")"om"); -- comment=4
lin broadcast_V = mkV "uppträda" "uppträdde" "uppträtt" ; -- comment=5
lin annoy_V2 = variants{} ; -- 
lin divert_V = mkV "roar" ; -- comment=10
lin accelerate_V2 = mkV2 (mkV "accelererar") | mkV2 (mkV (mkV "ge") "mer gas") | mkV2 (mkV "gasar") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accelerate_V = mkV "accelererar" ; -- comment=4
lin polymer_N = mkN "polymer" "polymerer" ; -- status=guess
lin sweat_N = mkN "svett" | mkN "vånda" ; -- SaldoWN -- comment=3
lin survivor_N = mkN "överlevande" ; -- SaldoWN
lin subscription_N = mkN "undertecknande" ; -- comment=5
lin repayment_N = mkN "återbetalning" ; -- comment=5
lin anonymous_A = mkA "anonym" ; -- SaldoWN
lin summarize_V2 = mkV2 (mkV "sammanfattar"); -- status=guess, src=wikt
lin punch_N = mkN "slå" | mkN "stans" ; -- SaldoWN -- comment=8
lin lodge_V2 = variants{}; -- mkV "sätta" "sätter" "sätt" "satte" "satt" "satt" ; -- comment=11
lin lodge_V = mkV "sätta" "sätter" "sätt" "satte" "satt" "satt" ; -- comment=11
lin landowner_N = mkN "markägare" utrum ; -- SaldoWN
lin ignorance_N = mkN "okunnighet" "okunnigheter" ; -- SaldoWN
lin discourage_V2 = mkV2 (mkV "discourage"); -- status=guess, src=wikt
lin bride_N = mkN "brud" ; -- SaldoWN
lin likewise_Adv = mkAdv "likväl" ; -- comment=2
lin depressed_A = variants{} ; -- 
lin abbey_N = mkN "kloster" neutrum ; -- SaldoWN
lin quarry_N = mkN "villebråd" neutrum; -- comment=8
lin archbishop_N = mkN "ärkebiskop" ; -- status=guess
lin sock_N = L.sock_N ;
lin large_scale_A = variants{} ; -- 
lin glare_V2 = variants{}; -- mkV "glor" ; -- comment=3
lin glare_V = mkV "glor" ; -- comment=3
lin descent_N = mkN "börd" | mkN "överfall" neutrum ; -- SaldoWN -- comment=15
lin stumble_V = mkV "stapplar" ; -- comment=3
lin mistress_N = mkN "älskarinna" ; -- comment=7
lin empty_V2 = dirV2 (partV (mkV "vattnar")"ur"); -- comment=16
lin empty_V = mkV "tömmer" ; -- comment=2
lin prosperity_N = mkN "välstånd" neutrum | mkN "lycka" ; -- SaldoWN -- comment=7
lin harm_V2 = variants{} ; -- 
lin formulation_N = mkN "formulering" ; -- comment=2
lin atomic_A = mkA "atomär" ; -- status=guess
lin agreed_A = variants{} ; -- 
lin wicked_A = mkA "stygg" ; -- comment=13
lin threshold_N = mkN "tröskel" | mkN "tröskelvärde" ; -- SaldoWN -- comment=2
lin lobby_N = mkN "lobby" "lobbyer" | mkN "hall" ; -- SaldoWN -- comment=4
lin repay_V2 = variants{}; -- mkV "återgäldar" ; -- comment=3
lin repay_V = mkV "återgäldar" ; -- comment=3
lin varying_A = variants{} ; -- 
lin track_V2 = mkV2 "spår" | dirV2 (partV (mkV "spårar")"ur") ; -- SaldoWN
lin track_V = mkV "spår" ; -- SaldoWN
lin crawl_V = mkV "krypa" "kröp" "krupit" ; -- comment=9
lin tolerate_V2 = mkV2 (mkV "tolererar"); -- status=guess, src=wikt
lin salvation_N = mkN "räddning" ; -- SaldoWN
lin pudding_N = mkN "pudding" ; -- SaldoWN
lin counter_VS = mkVS (mkV (mkV "gå") "till motanfallmotattack") ; -- status=guess, src=wikt status=guess, src=wikt
lin counter_V = mkV "motarbetar" ; -- comment=2
lin propaganda_N = mkN "propaganda" ; -- SaldoWN
lin cage_N = mkN "bur" | mkN "hiss" ; -- SaldoWN -- comment=3
lin broker_N = mkN "mäklare" utrum ; -- SaldoWN -- comment=3
lin ashamed_A = mkA "skamsen" "skamset" ; -- SaldoWN
lin scan_V2 = dirV2 (partV (mkV "skummar")"av"); -- status=guess
lin scan_V = mkV "scannar" ; -- comment=5
lin document_V2 = variants{} ; -- 
lin apparatus_N = mkN "apparat" "apparater" ; -- SaldoWN
lin theology_N = mkN "teologi" ; -- SaldoWN
lin analogy_N = mkN "analogi" "analogier" ; -- SaldoWN
lin efficiently_Adv = variants{} ; -- 
lin bitterly_Adv = variants{} ; -- 
lin performer_N = mkN "artist" "artister" | mkN "uppträdande" ; -- SaldoWN
lin individually_Adv = mkAdv "individuellt" ; -- status=guess
lin amid_Prep = mkPrep "bland" ; -- status=guess
lin squadron_N = mkN "skvadron" "skvadroner" ; -- comment=3
lin sentiment_N = mkN "sentiment" neutrum | mkN "uppfattning" ; -- SaldoWN -- comment=5
lin making_N = mkN "tillverkning" ; -- comment=5
lin exotic_A = mkA "exotisk" ; -- SaldoWN
lin dominance_N = mkN "herravälde" ; -- comment=4
lin coherent_A = mkA "följdriktig" ; -- status=guess
lin placement_N = mkN "placering" ; -- status=guess
lin flick_V2 = mkV2 (mkV (mkV "peka") "finger") | mkV2 (mkV (mkV "ge") "fingret"); -- status=guess, src=wikt status=guess, src=wikt
lin colourful_A = mkA "färgstark" | mkA "färgrik" ; -- SaldoWN
lin mercy_N = mkN "förskoning" | mkN "tur" ; -- SaldoWN -- comment=12
lin angrily_Adv = variants{} ; -- 
lin amuse_V2 = variants{} ; -- 
lin mainstream_N = variants{} ; -- 
lin appraisal_N = mkN "värdering" ; -- comment=5
lin annually_Adv = variants{} ; -- 
lin torch_N = mkN "fackla" | mkN "bloss" neutrum ; -- SaldoWN -- comment=3
lin intimate_A = mkA "väsentlig" ; -- comment=9
lin gold_A = variants{} ; -- 
lin arbitrary_A = mkA "godtycklig" | mkA "slumpmässig" ; -- SaldoWN -- comment=9
lin venture_VS = variants{}; -- mkV "vågar" ; -- comment=3
lin venture_V2 = variants{}; -- mkV "vågar" ; -- comment=3
lin venture_V = mkV "vågar" ; -- comment=3
lin preservation_N = mkN "bevarande" | mkN "vård" ; -- SaldoWN -- comment=10
lin shy_A = mkA "osäker" | mkA "tveksam" "tveksamt" "tveksamma" "tveksamma" "tveksammare" "tveksammast" "tveksammaste" ; -- SaldoWN -- comment=8
lin disclosure_N = mkN "yppande" ; -- comment=3
lin lace_N = mkN "spets" | mkN "trä" "träet" "trän" "träna" ; -- SaldoWN -- comment=5
lin inability_N = mkN "oförmåga" ; -- status=guess
lin motif_N = mkN "motiv" neutrum | mkN "motiv" neutrum ; -- SaldoWN -- comment=3
lin listenerMasc_N = variants{} ; -- 
lin hunt_N = mkN "jakt" "jakter" ; -- status=guess
lin delicious_A = mkA "utsökt" "utsökt" ; -- comment=2
lin term_VS = variants{}; -- dirV2 (partV (mkV "kallar")"ut");
lin term_V2 = dirV2 (partV (mkV "kallar")"ut"); -- status=guess
lin substitute_N = mkN "ersättning" ; -- comment=10
lin highway_N = mkN "kungsväg" ; -- comment=3
lin haul_V2 = dirV2 (partV (mkV "forslar")"in"); -- comment=17
lin haul_V = mkV "transporterar" ; -- comment=9
lin dragon_N = mkN "drake" utrum ; -- SaldoWN -- comment=2
lin chair_V2 = variants{} ; -- 
lin accumulate_V2 = mkV2 (mkV "ackumulerar"); -- status=guess, src=wikt
lin accumulate_V = mkV "samlar" ; -- comment=5
lin unchanged_A = compoundA (regA "oförändrad"); -- status=guess
lin sediment_N = mkN "sediment" neutrum | mkN "sediment" neutrum ; -- SaldoWN
lin sample_V2 = variants{} ; -- 
lin exclaim_V2 = dirV2 (partV (mkV "ropar")"till"); -- status=guess
lin fan_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- status=guess
lin fan_V = mkV "underblåser" ; -- comment=4
lin volunteer_V2 = variants{} ; -- 
lin volunteer_V = variants{} ; -- 
lin root_V2 = mkV2 (mkV "rotar") | mkV2 (mkV "böka"); -- status=guess, src=wikt status=guess, src=wikt
lin root_V = mkV "rotar" ; -- comment=2
lin parcel_N = mkN "paket" neutrum; -- comment=2
lin psychiatric_A = mkA "psykiatrisk" ; -- SaldoWN
lin delightful_A = mkA "behaglig" ; -- comment=7
lin confidential_A = mkA "konfidentiell" ; -- comment=2
lin calorie_N = mkN "kalori" "kalorier" ; -- SaldoWN
lin flash_N = mkN "ögonblick" neutrum | mkN "utbrott" neutrum ; -- SaldoWN -- comment=16
lin crowd_V2 = dirV2 (partV (mkV "knuffar")"ut"); -- status=guess
lin crowd_V = mkV "överhopar" ; -- comment=7
lin aggregate_A = mkA "sammanlagd" "sammanlagt" ; -- comment=2
lin scholarship_N = mkN "stipendium" "stipendiet" "stipendier" "stipendierna" ; -- SaldoWN
lin monitor_N = mkN "övervakare" utrum; -- comment=9
lin disciplinary_A = mkA "disciplinär" ; -- status=guess
lin rock_V2 = dirV2 (partV (mkV "skakar")"om"); -- comment=2
lin rock_V = mkV "vaggar" ; -- comment=9
lin hatred_N = mkN "hat" neutrum; -- status=guess
lin pill_N = mkN "p-piller" neutrum | mkN "p-piller" neutrum ; -- SaldoWN -- comment=3
lin noisy_A = mkA "bullrig" ; -- SaldoWN
lin feather_N = L.feather_N ;
lin lexical_A = variants{} ; -- 
lin staircase_N = mkN "trappa" ; -- SaldoWN
lin autonomous_A = mkA "autonom" ; -- comment=3
lin viewpoint_N = mkN "utsiktspunkt" "utsiktspunkter" ; -- comment=4
lin projection_N = mkN "projektion" "projektioner" | mkN "utslungande" ; -- SaldoWN -- comment=6
lin offensive_A = mkA "offensiv" ; -- SaldoWN
lin controlled_A = variants{} ; -- 
lin flush_V2 = dirV2 (partV (mkV "spolar")"över"); -- comment=2
lin flush_V = mkV "spolar" ; -- comment=2
lin racism_N = mkN "rasism" "rasismer" ; -- SaldoWN
lin flourish_V = mkV "svänger" ; -- comment=9
lin resentment_N = mkN "harm" ; -- SaldoWN
lin pillow_N = mkN "kudde" utrum | mkN "huvudkudde" utrum ; -- SaldoWN -- comment=3
lin courtesy_N = mkN "artighet" "artigheter" | mkN "hövlighet" "hövligheter" ; -- SaldoWN -- comment=2
lin photography_N = mkN "fotografering" | mkN "fotografi" "fotografit" "fotografier" "fotografierna" ; -- SaldoWN
lin monkey_N = mkN "apa" ; -- SaldoWN
lin glorious_A = mkA "ärofull" | mkA "ärorik" ; -- SaldoWN -- comment=5
lin evolutionary_A = variants{} ; -- 
lin gradual_A = mkA "successiv" | mkA "gradvis" ; -- SaldoWN -- comment=2
lin bankruptcy_N = mkN "konkurs" "konkurser" ; -- SaldoWN
lin sacrifice_N = mkN "offer" neutrum | mkN "offer" neutrum ; -- SaldoWN -- comment=3
lin uphold_V2 = mkV2 (mkV "upprätthålla"); -- status=guess, src=wikt
lin sketch_N = mkN "skämtteckning" | mkN "skiss" "skisser" ; -- SaldoWN -- comment=4
lin presidency_N = mkN "presidentskap" neutrum | mkN "presidentskap" neutrum ; -- SaldoWN
lin formidable_A = mkA "formidabel" ; -- status=guess
lin differentiate_V2 = dirV2 (partV (mkV "skilja" "skilde" "skilt") "av"); -- comment=2
lin differentiate_V = mkV "skilja" "skilde" "skilt" ; -- comment=3
lin continuing_A = variants{} ; -- 
lin cart_N = mkN "kärra" ; -- SaldoWN
lin stadium_N = mkN "stadion" neutrum | mkN "stadion" neutrum ; -- SaldoWN -- comment=2
lin dense_A = mkA "tät" ; -- comment=6
lin catch_N = mkN "aber" neutrum | mkN "lyra" ; -- SaldoWN -- comment=6
lin beyond_Adv = mkAdv "efter" ; -- comment=3
lin immigration_N = mkN "invandring" | mkN "immigration" "immigrationer" ; -- SaldoWN -- comment=2
lin clarity_N = mkN "klarhet" "klarheter" ; -- comment=5
lin worm_N = L.worm_N ;
lin slot_N = mkN "springa" | mkN "spår" neutrum ; -- SaldoWN -- comment=10
lin rifle_N = mkN "gevär" neutrum | mkN "gevär" neutrum ; -- SaldoWN -- comment=2
lin screw_V2 = dirV2 (partV (mkV "skruvar")"till"); -- comment=6
lin screw_V = mkV "skruvar" ; -- status=guess
lin harvest_N = mkN "skörd" ; -- SaldoWN
lin foster_V2 = variants{} ; -- 
lin academic_N = mkN "akademiker" "akademikern" "akademiker" "akademikerna" ; -- comment=2
lin impulse_N = mkN "ingivelse" "ingivelser" ; -- SaldoWN
lin guardian_N = mkN "väktare" utrum; -- comment=3
lin ambiguity_N = mkN "tvetydighet" "tvetydigheter" ; -- SaldoWN
lin triangle_N = mkN "triangel" ; -- SaldoWN
lin terminate_V2 = variants{}; -- mkV "sluta" "slöt" "slutit" ; -- comment=8
lin terminate_V = mkV "sluta" "slöt" "slutit" ; -- comment=8
lin retreat_V = mkV "retirerar" ; -- status=guess
lin pony_N = mkN "ponny" "ponnier" ; -- SaldoWN
lin outdoor_A = variants{} ; -- 
lin deficiency_N = mkN "brist" "brister" ; -- SaldoWN
lin decree_N = mkN "dekret" neutrum; -- comment=10
lin apologize_V = variants{} ; -- 
lin yarn_N = mkN "garn" neutrum; -- status=guess
lin staff_V2 = variants{} ; -- 
lin renewal_N = mkN "förnyelse" "förnyelser" ; -- status=guess
lin rebellion_N = mkN "uppror" neutrum | mkN "uppror" neutrum ; -- SaldoWN -- status=guess
lin incidentally_Adv = variants{} ; -- 
lin flour_N = mkN "mjöl" "mjölet" "mjöler" "mjölerna" ; -- SaldoWN
lin developed_A = variants{} ; -- 
lin chorus_N = mkN "kör" "körer" | mkN "refräng" "refränger" ; -- SaldoWN -- comment=6
lin ballot_N = mkN "röstsedel" | mkN "valsedel" ; -- SaldoWN -- comment=2
lin appetite_N = mkN "aptit" | mkN "lust" ; -- SaldoWN -- comment=7
lin stain_V2 = variants{}; -- mkV "färgar" ; -- comment=7
lin stain_V = mkV "färgar" ; -- comment=7
lin notebook_N = mkN "laptop" | mkN "anteckningsbok" "anteckningsböcker" ; -- SaldoWN
lin loudly_Adv = variants{} ; -- 
lin homeless_A = mkA "hemlös" ; -- comment=2
lin census_N = mkN "census" | mkN "folkräkning" ; -- status=guess
lin bizarre_A = mkA "bisarr" ; -- status=guess
lin striking_A = mkA "slående" ; -- comment=10
lin greenhouse_N = mkN "växthus" neutrum; -- comment=2
lin part_V2 = dirV2 (partV (mkV "skilja" "skilde" "skilt") "av"); -- comment=3
lin part_V = mkV "skingrar" ; -- comment=12
lin burial_N = mkN "begravning" ; -- SaldoWN
lin embarrassed_A = variants{} ; -- 
lin ash_N = mkN "aska" ; -- SaldoWN
lin actress_N = mkN "aktris" "aktriser" ; -- status=guess
lin cassette_N = mkN "kassett" "kassetter" ; -- SaldoWN
lin privacy_N = mkN "privatliv" neutrum | mkN "privatliv" neutrum ; -- SaldoWN -- comment=4
lin fridge_N = L.fridge_N ;
lin feed_N = mkN "djurfoder" neutrum; -- comment=3
lin excess_A = variants{} ; -- 
lin calf_N = mkN "kalv" | mkN "vad" ; -- SaldoWN -- comment=8
lin associate_N = mkN "före" ; -- comment=8
lin ruin_N = mkN "ruin" "ruiner" | mkN "undergång" ; -- SaldoWN -- comment=2
lin jointly_Adv = variants{} ; -- 
lin drill_V2 = mkV2 (mkV "drillar"); -- status=guess, src=wikt
lin drill_V = mkV "övar" ; -- comment=6
lin photograph_V2 = mkV2 (mkV "fotograferar"); -- status=guess, src=wikt
lin devoted_A = variants{} ; -- 
lin indirectly_Adv = variants{} ; -- 
lin driving_A = variants{} ; -- 
lin memorandum_N = mkN "promemoria" ; -- SaldoWN
lin default_N = mkN "uteblivande" | (mkN "standard" "standarder") | mkN "standardval" ; -- SaldoWN -- status=guess status=guess
lin costume_N = mkN "dräkt" "dräkter" ; -- SaldoWN
lin variant_N = mkN "variant" "varianter" ; -- SaldoWN
lin shatter_V2 = mkV2 (mkV "krossar") | mkV2 (mkV "kraschar") | mkV2 (mkV "krasar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shatter_V = mkV "uppröra" "upprörde" "upprört" ; -- comment=5
lin methodology_N = mkN "metodologi" "metodologier" | mkN "metodik" ; -- SaldoWN
lin frame_V2 = mkV2 (mkV "ramar") | mkV2 (mkV (mkV "rama") "in"); -- status=guess, src=wikt status=guess, src=wikt
lin frame_V = mkV "uttrycker" ; -- comment=5
lin allegedly_Adv = variants{} ; -- 
lin swell_V2 = dirV2 (partV (mkV "svallar")"över"); -- status=guess
lin swell_V = L.swell_V;
lin investigator_N = mkN "utredare" utrum ; -- SaldoWN
lin imaginative_A = mkA "fantasifull" ; -- comment=2
lin bored_A = variants{} ; -- 
lin bin_N = mkN "tunna" | mkN "låda" ; -- SaldoWN -- comment=9
lin awake_A = mkA "vaken" "vaket" | mkA "väck" ; -- SaldoWN -- comment=2
lin recycle_V2 = mkV2 "återvinna" "återvann" "återvunnit" | mkV2 (mkV "återanvänder") ; -- status=guess
lin group_V2 = mkV2 (mkV "grupperar"); -- status=guess, src=wikt
lin group_V = mkV "grupperar" ; -- status=guess
lin enjoyment_N = mkN "åtnjutande" ; -- comment=7
lin contemporary_N = mkN "samtid" | mkN "moder" "modern" "mödrar" "mödrarna" ; -- SaldoWN -- comment=2
lin texture_N = mkN "struktur" "strukturer" ; -- SaldoWN
lin donor_N = mkN "donator" "donatorer" | mkN "givare" utrum ; -- SaldoWN
lin bacon_N = mkN "bacon" ; -- SaldoWN
lin sunny_A = mkA "solig" ; -- status=guess
lin stool_N = mkN "pall" ; -- SaldoWN = mkN "pall" ; = mkN "pall" neutrum ;
lin prosecute_V2 = variants{} ; -- 
lin commentary_N = mkN "kommentar" "kommentarer" | mkN "referat" neutrum ; -- SaldoWN -- comment=6
lin bass_N = mkN "basgitarr" "basgitarrer" ; -- status=guess
lin sniff_V2 = variants{}; -- mkV "sniffar" ; -- comment=2
lin sniff_V = mkV "sniffar" ; -- comment=2
lin repetition_N = mkN "upprepning" | mkN "återupprepning" ; -- SaldoWN -- comment=3
lin eventual_A = mkA "slutgiltig" ; -- status=guess
lin credit_V2 = mkV2 (mkV "krediterar"); -- status=guess, src=wikt
lin suburb_N = mkN "förort" "förorter" ; -- SaldoWN
lin newcomer_N = mkN "nykomling" ; -- SaldoWN
lin romance_N = mkN "romantik" ; -- comment=3
lin film_V2 = mkV2 "hinna" "hann" "hunnit" | mkV2 (mkV "filmar") ; -- SaldoWN -- status=guess, src=wikt
lin film_V = mkV "hinna" "hann" "hunnit" ; -- SaldoWN
lin experiment_V2 = mkV2 (mkV "experimenterar"); -- status=guess, src=wikt
lin experiment_V = mkV "experimenterar" ; -- comment=2
lin daylight_N = mkN "dagsljus" neutrum ; -- status=guess
lin warrant_N = mkN "fullmakt" "fullmakter" ; -- SaldoWN
lin fur_N = mkN "päls" ; -- SaldoWN
lin parking_N = mkN "parkering" | mkN "parkeringsplats" "parkeringsplatser" ; -- SaldoWN -- comment=3
lin nuisance_N = mkN "otyg" neutrum; -- comment=4
lin civilian_A = mkA "civil" ; -- SaldoWN
lin foolish_A = mkA "enfaldig" | mkA "dåraktig" ; -- SaldoWN -- comment=6
lin bulb_N = mkN "lök" ; -- SaldoWN
lin balloon_N = mkN "ballong" "ballonger" | mkN "pratbubbla" ; -- SaldoWN -- comment=2
lin vivid_A = mkA "livlig" ; -- comment=9
lin surveyor_N = mkN "lantmätare" utrum; -- comment=4
lin spontaneous_A = mkA "spontan" ; -- SaldoWN
lin biology_N = mkN "biologi" ; -- SaldoWN
lin injunction_N = mkN "föreläggande" ; -- comment=4
lin appalling_A = mkA "skrämmande" ; -- comment=4
lin amusement_N = mkN "underhållning" ; -- comment=3
lin aesthetic_A = mkA "estetisk" ; -- SaldoWN
lin vegetation_N = mkN "växtlighet" "växtligheter" ; -- SaldoWN
lin stab_V2 = L.stab_V2 ;
lin stab_V = mkV "knivskära" "knivskar" "knivskurit" | mkV "stöter" ; -- SaldoWN
lin rude_A = mkA "plump" | mkA "ohövlig" ; -- SaldoWN -- comment=4
lin offset_V2 = variants{} ; -- 
lin thinking_N = mkN "tänkande" ; -- comment=3
lin mainframe_N = mkN "stordator" "stordatorer" ; -- status=guess
lin flock_N = mkN "flock" neutrum | mkN "skara" ; -- SaldoWN = mkN "flock" ; -- comment=8
lin amateur_A = variants{} ; -- 
lin academy_N = mkN "akademi" "akademier" ; -- SaldoWN
lin shilling_N = variants{} ; -- 
lin reluctance_N = mkN "betänklighet" "betänkligheter" | mkN "motvillighet" ; -- SaldoWN
lin velocity_N = mkN "hastighet" "hastigheter" ; -- SaldoWN
lin spare_V2 = variants{}; -- mkV "undvarar" ; -- comment=5
lin spare_V = mkV "undvarar" ; -- comment=5
lin wartime_N = variants{} ; -- 
lin soak_V2 = mkV2 "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin soak_V = mkV "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" | mkV "blöter" ; -- SaldoWN -- comment=4
lin rib_N = mkN "revben" neutrum | mkN "revben" neutrum ; -- SaldoWN -- comment=2
lin mighty_A = mkA "stark" ; -- comment=3
lin shocked_A = variants{} ; -- 
lin vocational_A = mkA "yrkesmässig" | compoundA (regA "yrkesinriktad") ; -- SaldoWN -- comment=3
lin spit_V2 = mkV2 (mkV "spottar"); -- status=guess, src=wikt
lin spit_V = L.spit_V;
lin gall_N = mkN "skavsår" neutrum; -- comment=5
lin bowl_V2 = dirV2 (partV (mkV "kastar")"ut"); -- comment=3
lin bowl_V = mkV "bowlar" ; -- comment=2
lin prescription_N = mkN "recept" neutrum | mkN "åläggande" ; -- SaldoWN -- comment=8
lin fever_N = mkN "feber" ; -- SaldoWN
lin axis_N = mkN "axel" ; -- SaldoWN
lin reservoir_N = mkN "reservoar" "reservoarer" ; -- SaldoWN
lin magnitude_N = mkN "storhet" "storheter" | mkN "omfattning" ; -- SaldoWN -- comment=3
lin rape_V2 = mkV2 "våldta" "våldtar" "våldta" "våldtog" "våldtagit" "våldtagen" ; -- status=guess
lin cutting_N = mkN "urklipp" neutrum ; -- SaldoWN -- comment=12
lin bracket_N = mkN "parentes" "parenteser" | mkN "vinkeljärn" neutrum ; -- SaldoWN -- comment=4
lin agony_N = mkN "vånda" ; -- SaldoWN
lin strive_VV = variants{}; -- mkV "strävar" ;
lin strive_V = mkV "strävar" ; -- status=guess
lin strangely_Adv = variants{} ; -- 
lin pledge_VS = mkV "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin pledge_V2V = mkV2V "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin pledge_V2 = mkV2 "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin recipient_N = mkN "mottagare" utrum; -- status=guess
lin moor_N = mkN "hed" ; -- status=guess
lin invade_V2 = mkV2 (mkV "invaderar"); -- status=guess, src=wikt
lin dairy_N = mkN "mejeri" "mejerit" "mejerier" "mejerierna" | mkN "dagbok" "dagböcker" ; -- SaldoWN -- comment=2
lin chord_N = mkN "ackord" neutrum | mkN "sträng" ; -- SaldoWN = mkN "ackord" neutrum ; -- comment=4
lin shrink_V2 = mkV2 (mkV "krymper"); -- status=guess, src=wikt
lin shrink_V = mkV "krymper" ; -- comment=2
lin poison_N = mkN "gift" "giftet" "gifter" "gifterna" ; -- SaldoWN
lin pillar_N = mkN "stolpe" utrum; -- comment=3
lin washing_N = mkN "tvagning" ; -- status=guess
lin warrior_N = mkN "krigare" utrum | mkN "krigare" utrum ; -- SaldoWN -- comment=5
lin supervisor_N = mkN "handledare" utrum | mkN "handledare" utrum ; -- SaldoWN -- comment=8
lin outfit_N = mkN "utstyrsel" | mkN "utrustning" ; -- SaldoWN -- comment=11
lin innovative_A = mkA "innovativ" ; -- status=guess
lin dressing_N = mkN "förband" neutrum | mkN "dressing" ; -- SaldoWN = mkN "förband" neutrum ; -- comment=10
lin dispute_V2 = variants{}; -- mkV "diskuterar" ; -- comment=6
lin dispute_V = mkV "diskuterar" ; -- comment=6
lin jungle_N = mkN "djungel" "djungeln" "djungler" "djunglerna" ; -- SaldoWN
lin brewery_N = mkN "bryggeri" "bryggerit" "bryggerier" "bryggerierna" ; -- SaldoWN
lin adjective_N = mkN "adjektiv" neutrum; -- status=guess
lin straighten_V2 = dirV2 (partV (mkV "rätar")"ut"); -- status=guess
lin straighten_V = mkV "rätar" ; -- status=guess
lin restrain_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=3
lin monarchy_N = mkN "monarki" "monarkier" ; -- SaldoWN
lin trunk_N = mkN "koffert" ; -- SaldoWN
lin herd_N = mkN "hjord" | mkN "flock" neutrum ; -- SaldoWN -- comment=4
lin deadline_N = mkN "deadline" utrum ; -- status=guess
lin tiger_N = mkN "tiger" ; -- SaldoWN
lin supporting_A = variants{} ; -- 
lin moderate_A = mkA "måttlig" ; -- comment=15
lin kneel_V = mkV "knäböja" "knäböjde" "knäböjt" ; -- SaldoWN
lin ego_N = mkN "egoism" "egoismer" ; -- comment=3
lin sexually_Adv = variants{} ; -- 
lin ministerial_A = variants{} ; -- 
lin bitch_N = mkN "tik" | mkN "satkäring" ; -- SaldoWN -- comment=6
lin wheat_N = mkN "vete" | mkN "durumvete" ; -- SaldoWN -- comment=3
lin stagger_V = mkV "stapplar" ; -- comment=2
lin snake_N = L.snake_N ;
lin ribbon_N = mkN "band" neutrum | mkN "remsa" ; -- SaldoWN -- comment=9
lin mainland_N = mkN "fastland" neutrum | mkN "fastland" neutrum ; -- SaldoWN -- status=guess
lin fisherman_N = mkN "fiskare" utrum | mkN "fiskare" utrum ; -- SaldoWN
lin economically_Adv = variants{} ; -- 
lin unwilling_A = mkA "motvillig" ; -- comment=3
lin nationalism_N = mkN "nationalism" "nationalismer" ; -- SaldoWN
lin knitting_N = mkN "stickning" ; -- status=guess
lin irony_N = mkN "ironi" "ironier" ; -- SaldoWN
lin handling_N = mkN "hantering" ; -- comment=2
lin desired_A = variants{} ; -- 
lin bomber_N = mkN "bombplan" neutrum ; -- SaldoWN
lin voltage_N = mkN "spänning" ; -- comment=2
lin unusually_Adv = variants{} ; -- 
lin toast_N = mkN "toast" | mkN "värma" ; -- SaldoWN -- comment=2
lin feel_N = mkN "känsla" ; -- comment=3
lin suffering_N = mkN "lidande" | mkN "smärta" ; -- SaldoWN -- comment=3
lin polish_V2 = dirV2 (partV (mkV "skurar")"av"); -- comment=5
lin polish_V = mkV "slipar" ; -- comment=8
lin technically_Adv = variants{} ; -- 
lin meaningful_A = mkA "meningsfull" ; -- SaldoWN
lin aloud_Adv = mkAdv "högt" ; -- status=guess
lin waiter_N = mkN "kypare" utrum; -- comment=4
lin tease_V2 = dirV2 (partV (mkV "tråkar")"ut"); -- status=guess
lin opposite_Adv = variants{} ; -- 
lin goat_N = mkN "get" "getter" | mkN "åsna" ; -- SaldoWN -- comment=3
lin conceptual_A = mkA "begreppsmässig" ; -- status=guess
lin ant_N = mkN "myra" | mkN "svartmyra" ; -- SaldoWN -- comment=2
lin inflict_V2 = variants{} ; -- 
lin bowler_N = mkN "bowlare" utrum; -- comment=3
lin roar_V2 = mkV2 (mkV "ryta" "röt" "rutit"); -- status=guess, src=wikt
lin roar_V = mkV "tjuta" "tjöt" "tjutit" ; -- comment=11
lin drain_N = mkN "avlopp" neutrum | mkN "dräneringsrör" neutrum ; -- SaldoWN -- comment=18
lin wrong_N = mkN "orätt" "orätter" ; -- SaldoWN
lin galaxy_N = mkN "galax" "galaxer" ; -- SaldoWN
lin aluminium_N = mkN "aluminium" neutrum ; -- SaldoWN
lin receptor_N = variants{} ; -- 
lin preach_V2 = mkV2 (mkV "predikar"); -- status=guess, src=wikt
lin preach_V = mkV "predikar" ; -- comment=4
lin parade_N = mkN "parad" "parader" | mkN "stoltserande" ; -- SaldoWN -- comment=4
lin opposite_N = mkN "motsats" "motsatser" | mkN "motstående" ; -- SaldoWN -- comment=3
lin critique_N = mkN "kritik" "kritiker" ; -- status=guess
lin query_N = variants{} ; -- 
lin outset_N = variants{} ; -- 
lin integral_A = (mkA "hel") | (mkA "enhetlig"); -- status=guess status=guess
lin grammatical_A = mkA "grammatisk" ; -- status=guess
lin testing_N = mkN "prövande" ; -- status=guess
lin patrol_N = mkN "patrull" "patruller" | mkN "patrullering" ; -- SaldoWN -- comment=2
lin pad_N = mkN "stoppning" ; -- comment=21
lin unreasonable_A = mkA "ovettig" ; -- comment=5
lin sausage_N = mkN "korv" ; -- SaldoWN
lin criminal_N = mkN "brottsling" ; -- SaldoWN
lin constructive_A = mkA "konstruktiv" ; -- SaldoWN
lin worldwide_A = variants{} ; -- 
lin highlight_N = mkN "höjdpunkt" "höjdpunkter" ; -- SaldoWN
lin doll_N = mkN "docka" ; -- SaldoWN
lin frightened_A = variants{} ; -- 
lin biography_N = mkN "biografi" "biografier" ; -- status=guess
lin vocabulary_N = mkN "ordförråd" neutrum; -- comment=2
lin offend_V2 = mkV2 (mkV "såra"); -- status=guess, src=wikt
lin offend_V = mkV "förolämpar" ; -- comment=4
lin accumulation_N = mkN "ansamling" | mkN "kapitalisering" ; -- SaldoWN -- comment=8
lin linen_N = mkN "linne" ; -- SaldoWN = mkN "linne" ;
lin fairy_N = mkN "älva" | mkN "fikus" ; -- SaldoWN -- comment=3
lin disco_N = mkN "diskotek" neutrum | mkN "diskomusik" ; -- SaldoWN -- comment=4
lin hint_VS = variants{}; -- mkV "antyda" "antydde" "antytt" ; -- comment=4
lin hint_V2 = variants{}; -- mkV "antyda" "antydde" "antytt" ; -- comment=4
lin hint_V = mkV "antyda" "antydde" "antytt" ; -- comment=4
lin versus_Prep = mkPrep "versus" ; -- status=guess
lin ray_N = mkN "stråle" utrum; -- comment=5
lin pottery_N = mkN "lergods" neutrum | mkN "krukmakeri" "krukmakerit" "krukmakerier" "krukmakerierna" ; -- SaldoWN
lin immune_A = mkA "immun" ; -- SaldoWN
lin retreat_N = mkN "fristad" "fristäder" | mkN "återtåg" neutrum ; -- SaldoWN -- comment=3
lin master_V2 = variants{} ; -- 
lin injured_A = variants{} ; -- 
lin holly_N = mkN "järnek" ; -- status=guess
lin battle_V2 = mkV2 (mkV "strida" "stridde" "stritt"); -- status=guess, src=wikt
lin battle_V = mkV "kämpar" ; -- comment=2
lin solidarity_N = mkN "solidaritet" "solidariteter" ; -- SaldoWN
lin embarrassing_A = mkA "genant" "genant" ; -- comment=4
lin cargo_N = mkN "last" "laster" ; -- comment=3
lin theorist_N = mkN "teoretiker" "teoretikern" "teoretiker" "teoretikerna" ; -- SaldoWN
lin reluctantly_Adv = variants{} ; -- 
lin preferred_A = variants{} ; -- 
lin dash_V = mkV "slå" "slog" "slagit" ; -- comment=15
lin total_V2 = mkV2 I.göra_V ; ----
lin total_V = mkV "sammanlägga" "sammanlade" "sammanlagt" ; -- comment=4
lin reconcile_V2 = variants{} ; -- 
lin drill_N = mkN "exercis" "exerciser" | mkN "trä" "träet" "trän" "träna" ; -- SaldoWN -- comment=9
lin credibility_N = mkN "trovärdighet" ; -- SaldoWN
lin copyright_N = mkN "upphovsrätt" | mkN "copyright" ; -- SaldoWN -- comment=3
lin beard_N = mkN "skägg" neutrum ; -- SaldoWN
lin bang_N = mkN "knall" | mkN "vip" ; -- SaldoWN -- comment=15
lin vigorous_A = mkA "vital" | mkA "kraftfull" ; -- SaldoWN -- comment=3
lin vaguely_Adv = variants{} ; -- 
lin punch_V2 = mkV2 "slå" "slog" "slagit" | dirV2 (partV (mkV "stansar")"ut") ; -- SaldoWN -- comment=2
lin prevalence_N = mkN "överväldigande" ; -- SaldoWN
lin uneasy_A = mkA "orolig" ; -- SaldoWN
lin boost_N = mkN "ökning" ; -- comment=5
lin scrap_N = mkN "bit" | mkN "skrot" ; -- SaldoWN = mkN "bit" ; -- comment=11
lin ironically_Adv = variants{} ; -- 
lin fog_N = L.fog_N ;
lin faithful_A = mkA "trogen" "troget" ; -- SaldoWN
lin bounce_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin bounce_V = mkV "studsar" ; -- comment=3
lin batch_N = mkN "hop" ; -- comment=9
lin smooth_V2 = dirV2 (partV (mkV "slätar")"till"); -- comment=4
lin smooth_V = mkV "stillar" ; -- comment=5
lin sleeping_A = variants{} ; -- 
lin poorly_Adv = variants{} ; -- 
lin accord_V = mkV "ge" "ger" "ge" "gav" "gett" "given" ; -- comment=3
lin vice_president_N = mkN "vicepresident" "vicepresidenter" ; -- status=guess
lin duly_Adv = variants{} ; -- 
lin blast_N = mkN "explosion" "explosioner" | mkN "tryckvåg" "tryckvågor" ; -- SaldoWN -- comment=8
lin square_V2 = dirV2 (partV (mkV "rättar")"till"); -- status=guess
lin square_V = mkV "reglerar" ; -- comment=10
lin prohibit_V2 = mkV2 (mkV "förbjuda" "förbjöd" "förbjudit") ; -- status=guess
lin prohibit_V = mkV "förhindrar" ; -- comment=4
lin brake_N = mkN "broms" | mkN "busksnår" neutrum ; -- SaldoWN -- comment=3
lin asylum_N = mkN "asyl" "asyler" | mkN "vårdanstalt" "vårdanstalter" ; -- SaldoWN -- comment=3
lin obscure_V2 = variants{} ; -- 
lin nun_N = mkN "nunna" ; -- SaldoWN
lin heap_N = mkN "massa" ; -- comment=6
lin smoothly_Adv = variants{} ; -- 
lin rhetoric_N = mkN "retorik" | mkN "vältalighet" "vältaligheter" ; -- SaldoWN -- comment=3
lin privileged_A = compoundA (regA "privilegierad"); -- status=guess
lin liaison_N = variants{} ; -- 
lin jockey_N = mkN "jockey" ; -- SaldoWN
lin concrete_N = mkN "betong" "betonger" ; -- SaldoWN
lin allied_A = variants{} ; -- 
lin rob_V2 = mkV2 (mkV "röva") | mkV2 (mkV "råna"); -- status=guess, src=wikt status=guess, src=wikt
lin indulge_V2 = variants{}; -- mkV "tillfredsställer" ;
lin indulge_V = mkV "tillfredsställer" ; -- status=guess
lin except_Prep = S.except_Prep;
lin distort_V2 = mkV2 (mkV "förvränga"); -- status=guess, src=wikt
lin whatsoever_Adv = variants{} ; -- 
lin viable_A = mkA "genomförbar" | mkA "livsduglig" ; -- SaldoWN -- comment=7
lin nucleus_N = mkN "kärna" ; -- comment=3
lin exaggerate_V2 = mkV2 "överdriva" "överdrev" "överdrivit" ; -- SaldoWN -- status=guess, src=wikt
lin exaggerate_V = mkV "överdriva" "överdrev" "överdrivit" ; -- SaldoWN
lin compact_N = mkN "minibil" | mkN "tät" "täter" ; -- SaldoWN
lin nationality_N = mkN "nationalitet" "nationaliteter" ; -- SaldoWN
lin direct_Adv = mkAdv "direkt" ; -- comment=2
lin cast_N = mkN "rollbesättning" | mkN "rollfördelning" | mkN "rollsättning" | mkN "casting" ; -- status=guess
lin altar_N = mkN "altare" "altaret" "altaren" "altarna" ; -- SaldoWN
lin refuge_N = mkN "tillflyktsort" "tillflyktsorter" ; -- comment=4
lin presently_Adv = variants{} ; -- 
lin mandatory_A = mkA "obligatorisk" ; -- status=guess
lin authorize_V2V = variants{} ; -- 
lin authorize_V2 = variants{} ; -- 
lin accomplish_V2 = mkV2 (mkV "åstadkomma" "åstadkom" "åstadkommit") | mkV2 (mkV "uträtta"); -- status=guess, src=wikt status=guess, src=wikt
lin startle_V2 = variants{} ; -- 
lin indigenous_A = mkA "inhemsk" | mkA "naturlig" ; -- SaldoWN -- comment=3
lin worse_Adv = variants{} ; -- 
lin retailer_N = mkN "återförsäljare" utrum | mkN "återförsäljare" utrum ; -- SaldoWN -- comment=2
lin compound_V2 = dirV2 (partV (mkV "blandar") "ut"); -- comment=4
lin compound_V = mkV "sammansätta" "sammansätter" "sammansätt" "sammansatte" "sammansatt" "sammansatt" ; -- comment=3
lin admiration_N = mkN "beundran" ; -- status=guess
lin absurd_A = mkA "orimlig" ; -- comment=6
lin coincidence_N = mkN "tillfällighet" "tillfälligheter" | mkN "överensstämmelse" "överensstämmelser" ; -- SaldoWN -- comment=6
lin principally_Adv = variants{} ; -- 
lin passport_N = mkN "pass" neutrum | mkN "passersedel" ; -- SaldoWN -- comment=4
lin depot_N = mkN "depå" "depåer" ; -- comment=7
lin soften_V2 = mkV2 (mkV "mjuknar"); -- status=guess, src=wikt
lin soften_V = mkV "uppmjukar" ; -- comment=2
lin secretion_N = mkN "sekret" neutrum | mkN "undangömmande" ; -- SaldoWN -- comment=5
lin invoke_V2 = variants{} ; -- 
lin dirt_N = mkN "smuts" ; -- comment=6
lin scared_A = variants{} ; -- 
lin mug_N = mkN "mugg" | mkN "tryne" ; -- SaldoWN = mkN "mugg" ; -- comment=7
lin convenience_N = mkN "bekvämlighet" "bekvämligheter" | mkN "lämplighet" "lämpligheter" ; -- SaldoWN -- comment=5
lin calm_N = mkN "lugn" neutrum; -- comment=6
lin optional_A = mkA "valfri" "valfritt" ; -- SaldoWN
lin unsuccessful_A = compoundA (regA "misslyckad"); -- status=guess
lin consistency_N = mkN "konsistens" "konsistenser" ; -- comment=8
lin umbrella_N = mkN "paraply" "paraplyer" ; -- SaldoWN
lin solo_N = mkN "solo" "solot" "solon" "solona" ; -- SaldoWN
lin hemisphere_N = mkN "hjärnhalva" | mkN "hemisfär" "hemisfärer" ; -- SaldoWN
lin extreme_N = mkN "ytterlighet" "ytterligheter" ; -- SaldoWN
lin brandy_N = variants{} ; -- 
lin belly_N = L.belly_N ;
lin attachment_N = mkN "tillgivenhet" "tillgivenheter" | mkN "hängivenhet" ; -- SaldoWN -- comment=16
lin wash_N = mkN "tvätt" ; -- comment=4
lin uncover_V2 = variants{} ; -- 
lin treat_N = mkN "njutning" | mkN "nöje" ; -- SaldoWN -- comment=8
lin repeated_A = variants{} ; -- 
lin pine_N = mkN "tall" ; -- comment=6
lin offspring_N = mkN "avkomma" | mkN "ättling" ; -- SaldoWN -- comment=8
lin communism_N = mkN "kommunism" "kommunismer" ; -- status=guess
lin nominate_V2 = variants{} ; -- 
lin soar_V2 = mkV2 "flyga" "flög" "flugit" ; -- SaldoWN
lin soar_V = mkV "flyga" "flög" "flugit" ; -- SaldoWN
lin geological_A = mkA "geologisk" ; -- SaldoWN
lin frog_N = mkN "groda" ; -- SaldoWN
lin donate_V2 = mkV2 (mkV "skänka") | mkV2 (mkV "donerar"); -- status=guess, src=wikt status=guess, src=wikt
lin donate_V = mkV "skänker" ; -- comment=3
lin cooperative_A = mkA "medgörlig" | mkA "samarbetsvillig" ; -- SaldoWN -- comment=3
lin nicely_Adv = variants{} ; -- 
lin innocence_N = mkN "oskuld" "oskulder" ; -- comment=4
lin housewife_N = mkN "hemmafru" ; -- SaldoWN
lin disguise_V2 = variants{} ; -- 
lin demolish_V2 = mkV2 "förstöra" "förstörde" "förstört" ; -- SaldoWN
lin counsel_N = mkN "överläggning" ; -- comment=10
lin cord_N = mkN "snöre" | mkN "sträng" ; -- SaldoWN -- comment=2
lin semi_final_N = variants{} ; -- 
lin reasoning_N = mkN "resonemang" neutrum; -- comment=5
lin litre_N = mkN "liter" ; -- status=guess
lin inclined_A = variants{} ; -- 
lin evoke_V2 = mkV2 (mkV "frammanar"); -- status=guess, src=wikt
lin courtyard_N = mkN "borggård" ; -- comment=3
lin arena_N = mkN "arena" ; -- SaldoWN
lin simplicity_N = mkN "enkelhet" "enkelheter" ; -- SaldoWN
lin inhibition_N = mkN "hämning" ; -- SaldoWN
lin frozen_A = variants{} ; -- 
lin vacuum_N = mkN "vakuum" neutrum | mkN "vakuum" neutrum ; -- SaldoWN -- comment=2
lin immigrant_N = mkN "invandrare" utrum ; -- SaldoWN -- comment=2
lin bet_N = mkN "vad" ; -- SaldoWN = mkN "vad" neutrum ; = mkN "vad" "vader" ;
lin revenge_N = mkN "hämnd" | mkN "vedergällning" ; -- SaldoWN -- comment=3
lin jail_V2 = variants{} ; -- 
lin helmet_N = mkN "hjälm" ; -- SaldoWN
lin unclear_A = mkA "otydlig" ; -- status=guess
lin jerk_V2 = dirV2 (partV (mkV "slänger") "ut"); -- comment=4
lin jerk_V = mkV "stöter" ; -- comment=8
lin disruption_N = mkN "upplösning" ; -- comment=3
lin attainment_N = mkN "uppnående" ; -- comment=3
lin sip_V2 = variants{}; -- mkV "smuttar" ; -- comment=2
lin sip_V = mkV "smuttar" ; -- comment=2
lin program_V2V = mkV2V (mkV "programmerar") | mkV2V (mkV "mjukvaruutveckla") | mkV2V (mkV (mkV "utveckla") "mjukvara"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin program_V2 = dirV2 (partV (mkV "programmerar")"in"); -- status=guess
lin lunchtime_N = mkN "lunchtid" "lunchtider" ; -- status=guess
lin cult_N = mkN "sekt" ; -- comment=4
lin chat_N = mkN "prata" ; -- comment=8
lin accord_N = mkN "överensstämmelse" "överensstämmelser" ; -- comment=5
lin supposedly_Adv = variants{} ; -- 
lin offering_N = mkN "utbud" neutrum; -- comment=3
lin broadcast_N = mkN "sändning" | mkN "TV-sändning" ; -- SaldoWN -- comment=3
lin secular_A = mkA "sekulär" ; -- SaldoWN
lin overwhelm_V2 = mkV2 (mkV "överväldiga"); -- status=guess, src=wikt
lin momentum_N = mkN "rörelsemängd" "rörelsemängder" | mkN "rörelsemängd" ; -- SaldoWN -- status=guess
lin infinite_A = mkA "oändlig" ; -- SaldoWN
lin manipulation_N = mkN "manipulation" "manipulationer" ; -- comment=2
lin inquest_N = variants{} ; -- 
lin decrease_N = mkN "nedgång" | mkN "minskning" ; -- SaldoWN -- comment=4
lin cellar_N = mkN "källare" utrum ; -- SaldoWN -- comment=2
lin counsellor_N = mkN "konsulent" "konsulenter" ; -- comment=3
lin avenue_N = mkN "aveny" "avenyer" | mkN "allé" "alléer" ; -- SaldoWN -- comment=3
lin rubber_A = variants{} ; -- 
lin labourer_N = mkN "arbetare" utrum ; -- SaldoWN
lin lab_N = mkN "maka" ; -- comment=3
lin damn_V2 = dirV2 (partV (mkV "dömer")"ut"); -- status=guess
lin comfortably_Adv = variants{} ; -- 
lin tense_A = mkA "spänd" | mkA "spännande" ; -- SaldoWN -- comment=4
lin socket_N = mkN "hållare" utrum; -- comment=8
lin par_N = variants{} ; -- 
lin thrust_N = mkN "slunga" | mkN "stöt" ; -- SaldoWN -- comment=2
lin scenario_N = mkN "scenario" "scenariot" "scenarion" "scenariona" ; -- SaldoWN
lin frankly_Adv = variants{} ; -- 
lin slap_V2 = mkV2 "slå" "slog" "slagit" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN -- comment=15
lin recreation_N = mkN "rekreation" "rekreationer" ; -- SaldoWN
lin rank_V2 = dirV2 (partV (mkV "ordnar")"om"); -- status=guess
lin rank_V = mkV "rankar" ; -- comment=7
lin spy_N = mkN "spion" "spioner" ; -- SaldoWN
lin filter_V2 = dirV2 (partV (mkV "filtrerar")"av"); -- status=guess
lin filter_V = mkV "filtrerar" ; -- status=guess
lin clearance_N = mkN "klarsignal" "klarsignaler" | mkN "tillstånd" neutrum ; -- SaldoWN -- comment=8
lin blessing_N = mkN "välsignelse" "välsignelser" ; -- comment=6
lin embryo_N = mkN "embryo" "embryot" "embryon" "embryona" ; -- SaldoWN
lin varied_A = variants{} ; -- 
lin predictable_A = mkA "förutsägbar" ; -- SaldoWN
lin mutation_N = mkN "mutation" "mutationer" ; -- SaldoWN
lin equal_V2 = mkV2 (mkV (mkV "vara") "lika med"); -- status=guess, src=wikt
lin can_1_VV = S.can_VV ;
lin can_2_VV = S.can8know_VV ;
lin can_V2 = dirV2 (mkV "konserverar"); -- status=guess
lin burst_N = mkN "salva" ; -- comment=8
lin retrieve_V2 = mkV2 (mkV "minnas"); -- status=guess, src=wikt
lin retrieve_V = mkV "minnas" ; -- status=guess, src=wikt
lin elder_N = mkN "tejp" ; -- comment=2
lin rehearsal_N = mkN "repetition" "repetitioner" ; -- SaldoWN
lin optical_A = mkA "optisk" ; -- status=guess
lin hurry_N = mkN "jäkt" neutrum; -- comment=4
lin conflict_V = mkV "kämpar" ; -- status=guess
lin combat_V2 = variants{}; -- mkV "strida" "stridde" "stritt" ; -- comment=3
lin combat_V = mkV "strida" "stridde" "stritt" ; -- comment=3
lin absorption_N = mkN "assimilation" "assimilationer" | mkN "absorbering" ; -- SaldoWN -- comment=3
lin ion_N = mkN "jon" "joner" ; -- status=guess
lin wrong_Adv = mkAdv "vilse" ; -- status=guess
lin heroin_N = mkN "heroin" "heroiner" ; -- SaldoWN
lin bake_V2 = dirV2 (partV (mkV "hårdnar")"till"); -- status=guess
lin bake_V = mkV "bakar" ; -- comment=7
lin x_ray_N = variants{} ; -- 
lin vector_N = mkN "vektor" "vektorer" ; -- SaldoWN
lin stolen_A = variants{} ; -- 
lin sacrifice_V2 = mkV2 (mkV "offrar"); -- status=guess, src=wikt
lin sacrifice_V = mkV "offrar" ; -- comment=2
lin robbery_N = mkN "rån" neutrum | mkN "röveri" "röverit" "röverier" "röverierna" ; -- SaldoWN -- comment=5
lin probe_V2 = variants{}; -- mkV "utforskar" ; -- comment=2
lin probe_V = mkV "utforskar" ; -- comment=2
lin organizational_A = mkA "organisatorisk" ; -- status=guess
lin chalk_N = mkN "krita" ; -- SaldoWN = mkN "krita" ;
lin bourgeois_A = mkA "borgerlig" ; -- status=guess
lin villager_N = mkN "bybo" ; -- status=guess
lin morale_N = mkN "moral" "moraler" ; -- SaldoWN
lin express_A = mkA "uttrycklig" ; -- comment=6
lin climb_N = mkN "klättring" ; -- comment=2
lin notify_V2 = mkV2 (mkV "meddelar"); -- status=guess, src=wikt
lin jam_N = mkN "sylt" "sylter" | mkN "tur" ; -- SaldoWN -- comment=18
lin bureaucratic_A = mkA "byråkratisk" ; -- SaldoWN
lin literacy_N = mkN "läskunnighet" "läskunnigheter" | mkN "skrivkunnighet" ; -- SaldoWN
lin frustrate_V2 = variants{} ; -- 
lin freight_N = mkN "frakt" "frakter" ; -- SaldoWN
lin clearing_N = mkN "röjning" ; -- comment=6
lin aviation_N = mkN "flyg" neutrum ; -- SaldoWN = mkN "flyg" neutrum ; -- comment=2
lin legislature_N = mkN "legislatur" "legislaturer" ; -- SaldoWN
lin curiously_Adv = variants{} ; -- 
lin banana_N = mkN "banan" "bananer" ; -- SaldoWN
lin deploy_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- status=guess
lin deploy_V = mkV "utplacerar" ; -- comment=3
lin passionate_A = variants{} ; -- 
lin monastery_N = mkN "kloster" neutrum | mkN "kloster" neutrum ; -- SaldoWN
lin kettle_N = mkN "kittel" | mkN "vattenkokare" utrum ; -- SaldoWN
lin enjoyable_A = mkA "trevlig" | mkA "njutbar" ; -- SaldoWN -- comment=5
lin diagnose_V2 = mkV2 (mkV "diagnostiserar"); -- status=guess, src=wikt
lin quantitative_A = mkA "kvantitativ" ; -- SaldoWN
lin distortion_N = mkN "förvrängning" ; -- SaldoWN
lin monarch_N = mkN "monark" "monarker" ; -- SaldoWN
lin kindly_Adv = variants{} ; -- 
lin glow_V = mkV "glöda" "glödde" "glött" ; -- SaldoWN
lin acquaintance_N = mkN "bekantskap" "bekantskaper" | mkN "bekant" "bekanter" ; -- SaldoWN -- comment=4
lin unexpectedly_Adv = variants{} ; -- 
lin handy_A = mkA "behändig" ; -- SaldoWN
lin deprivation_N = mkN "misär" "misärer" | mkN "förlust" "förluster" ; -- SaldoWN -- comment=2
lin attacker_N = mkN "angripare" utrum; -- status=guess
lin assault_V2 = variants{} ; -- 
lin screening_N = mkN "kontroll" "kontroller" ; -- comment=2
lin retired_A = variants{} ; -- 
lin quick_Adv = mkAdv "fort" ; -- status=guess
lin portable_A = mkA "portabel" | mkA "bärbar" ; -- SaldoWN -- comment=4
lin hostage_N = mkN "gisslan" ; -- SaldoWN
lin underneath_Prep = mkPrep "nedanför" ; -- status=guess
lin jealous_A = mkA "avundsjuk" | mkA "svartsjuk" ; -- SaldoWN -- comment=5
lin proportional_A = mkA "proportionell" ; -- status=guess
lin gown_N = mkN "dräkt" "dräkter" | mkN "klänning" ; -- SaldoWN -- comment=5
lin chimney_N = mkN "skorsten" "skorstenen" "skorstenar" "skorstenarna" ; -- SaldoWN
lin bleak_A = mkA "dyster" ; -- status=guess
lin seasonal_A = mkA "säsongsmässig" ; -- SaldoWN
lin plasma_N = mkN "blodplasma" ; -- status=guess
lin stunning_A = mkA "fantastisk" ; -- SaldoWN
lin spray_N = mkN "sprej" "sprejer" | mkN "yra" ; -- SaldoWN -- comment=14
lin referral_N = mkN "remiss" "remisser" | mkN "remittering" ; -- SaldoWN -- comment=3
lin promptly_Adv = variants{} ; -- 
lin fluctuation_N = mkN "fluktuation" "fluktuationer" | mkN "skiftning" ; -- SaldoWN -- comment=3
lin decorative_A = mkA "dekorativ" ; -- comment=3
lin unrest_N = mkN "orolighet" "oroligheter" ; -- SaldoWN
lin resent_VS = variants{} ; -- 
lin resent_V2 = variants{} ; -- 
lin plaster_N = mkN "plåster" neutrum | mkN "plåster" neutrum ; -- SaldoWN -- comment=9
lin chew_V2 = dirV2 (partV (mkV "tuggar")"om"); -- status=guess
lin chew_V = mkV "tuggar" ; -- comment=4
lin grouping_N = variants{} ; -- 
lin gospel_N = mkN "gospel" "gospeln" "gospel" "gospelna" ; -- comment=3
lin distributor_N = mkN "distributör" "distributörer" ; -- SaldoWN
lin differentiation_N = mkN "differentiering" ; -- status=guess
lin blonde_A = mkA "blond" ; -- SaldoWN
lin aquarium_N = mkN "akvarium" "akvariet" "akvarier" "akvarierna" ; -- SaldoWN
lin witch_N = mkN "häxa" ; -- SaldoWN
lin renewed_A = variants{} ; -- 
lin jar_N = mkN "burk" ; -- SaldoWN
lin approved_A = variants{} ; -- 
lin advocateMasc_N = variants{} ; -- 
lin worrying_A = variants{} ; -- 
lin minimize_V2 = mkV2 (mkV "minimerar") ; -- status=guess
lin footstep_N = variants{} ; -- 
lin delete_V2 = variants{} ; -- 
lin underneath_Adv = mkAdv "under" ; -- comment=3
lin lone_A = mkA "ensam" "ensamt" "ensamma" "ensamma" "ensammare" "ensammast" "ensammaste" ; -- status=guess
lin level_V2 = dirV2 (partV (mkV "jämnar")"ut"); -- comment=2
lin level_V = mkV "raserar" ; -- comment=2
lin exceptionally_Adv = variants{} ; -- 
lin drift_N = mkN "driva" ; -- SaldoWN
lin spider_N = mkN "spindel" ; -- SaldoWN
lin hectare_N = mkN "hektar" neutrum ; -- SaldoWN
lin colonel_N = mkN "överste" utrum ; -- status=guess
lin swimming_N = mkN "simning" ; -- status=guess
lin realism_N = mkN "realism" "realismer" ; -- SaldoWN
lin insider_N = mkN "insider" ; -- SaldoWN
lin hobby_N = mkN "hobby" "hobbier" ; -- status=guess
lin computing_N = variants{} ; -- 
lin infrastructure_N = mkN "infrastruktur" "infrastrukturer" ; -- SaldoWN
lin cooperate_V = mkV "samarbetar" ; -- comment=2
lin burn_N = mkN "solbränna" | mkN "brännskada" ; -- SaldoWN -- comment=4
lin cereal_N = mkN "sädesslag" neutrum ; -- SaldoWN
lin fold_N = mkN "veck" neutrum | mkN "vindling" ; -- SaldoWN -- comment=8
lin compromise_V2 = mkV2 (mkV "kompromissar") ; -- status=guess
lin compromise_V = mkV "äventyrar" ; -- comment=4
lin boxing_N = mkN "boxning" ; -- status=guess
lin rear_V2 = variants{}; -- mkV "lyfta" "lyfter" "lyft" "lyfte" "lyft" "lyft" ;
lin rear_V = mkV "lyfta" "lyfter" "lyft" "lyfte" "lyft" "lyft" ; -- status=guess
lin lick_V2 = dirV2 (partV (mkV "slickar")"av"); -- comment=15
lin constrain_V2 = mkV2 (mkV "begränsa"); -- status=guess, src=wikt
lin clerical_A = variants{} ; -- 
lin hire_N = mkN "hyra" ; -- comment=5
lin contend_VS = mkVS (mkV "kämpa"); -- status=guess, src=wikt
lin contend_V = mkV "kämpa" ; -- status=guess, src=wikt
lin amateurMasc_N = variants{} ; -- 
lin instrumental_A = mkA "bidragande" ; -- status=guess
lin terminal_A = mkA "terminal" | mkA "obotlig" ; -- SaldoWN -- comment=2
lin electorate_N = mkN "väljarkår" "väljarkårer" | mkN "kurfurstendöme" ; -- SaldoWN -- status=guess
lin congratulate_V2 = mkV2 (mkV "gratulerar") | mkV2 (mkV "lyckönska") | mkV2 (mkV "grattar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin balanced_A = variants{} ; -- 
lin manufacturing_N = variants{} ; -- 
lin split_N = mkN "schism" "schismer" | mkN "spricka" ; -- SaldoWN -- comment=11
lin domination_N = mkN "herravälde" ; -- SaldoWN
lin blink_V2 = mkV2 (mkV "blinkar"); -- status=guess, src=wikt
lin blink_V = mkV "blinkar" ; -- comment=3
lin bleed_VS = mkVS (mkV "blöda" "blödde" "blött") ; -- status=guess
lin bleed_V2 = mkV2 "blöda" "blödde" "blött" | dirV2 (partV (mkV "plockar")"ut") ; -- SaldoWN -- comment=17
lin bleed_V = mkV "blöda" "blödde" "blött" ; -- SaldoWN
lin unlawful_A = mkA "olaglig" | mkA "olovlig" ; -- SaldoWN -- comment=3
lin precedent_N = mkN "prejudikat" neutrum | mkN "prejudikat" neutrum ; -- SaldoWN -- comment=2
lin notorious_A = mkA "ökänd" ; -- comment=4
lin indoor_A = variants{} ; -- 
lin upgrade_V2 = mkV2 (mkV "befordrar") | mkV2 (mkV "uppvärdera") | mkV2 (mkV "uppdaterar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin trench_N = mkN "dike" ; -- SaldoWN
lin therapist_N = mkN "terapeut" "terapeuter" ; -- SaldoWN
lin illuminate_V2 = variants{} ; -- 
lin bargain_V2 = mkV2 (mkV "förhandla") | mkV2 (mkV "köpslå" "köpslog" "köpslagit") ; -- status=guess
lin bargain_V = mkV "förhandlar" ; -- comment=4
lin warranty_N = mkN "garanti" "garantier" ; -- SaldoWN
lin scar_V2 = variants{} ; -- 
lin scar_V = variants{} ; -- 
lin consortium_N = mkN "konsortium" "konsortiet" "konsortier" "konsortierna" ; -- status=guess
lin anger_V2 = mkV2 (mkV "förarga") | mkV2 (mkV "förilska"); -- status=guess, src=wikt status=guess, src=wikt
lin insure_VS = variants{}; -- mkV "försäkrar" ; -- comment=2
lin insure_V2 = variants{}; -- mkV "försäkrar" ; -- comment=2
lin insure_V = mkV "försäkrar" ; -- comment=2
lin extensively_Adv = variants{} ; -- 
lin appropriately_Adv = variants{} ; -- 
lin spoon_N = mkN "sked" ; -- SaldoWN
lin sideways_Adv = mkAdv "sidledes" ; -- status=guess
lin enhanced_A = variants{} ; -- 
lin disrupt_V2 = variants{}; -- mkV "splittrar" ; -- comment=4
lin disrupt_V = mkV "splittrar" ; -- comment=4
lin satisfied_A = mkA "nöjd" "nöjt" ; -- SaldoWN
lin precaution_N = mkN "försiktighetsåtgärd" "försiktighetsåtgärder" ; -- status=guess
lin kite_N = mkN "drake" utrum ; -- SaldoWN -- comment=2
lin instant_N = mkN "ögonblick" neutrum; -- status=guess
lin gig_N = (mkN "ljuster" neutrum) | (mkN "harpun" "harpuner"); -- status=guess status=guess
lin continuously_Adv = variants{} ; -- 
lin consolidate_V2 = mkV2 (mkV "konsoliderar"); -- status=guess, src=wikt
lin consolidate_V = mkV "sammanföra" "sammanförde" "sammanfört" ; -- comment=6
lin fountain_N = mkN "fontän" "fontäner" ; -- SaldoWN
lin graduate_V2 = variants{}; -- mkV "examinerar" ; -- comment=3
lin graduate_V = mkV "examinerar" ; -- comment=3
lin gloom_N = mkN "svårmod" neutrum | mkN "mörker" neutrum ; -- SaldoWN -- comment=3
lin bite_N = mkN "snacks" neutrum | mkN "bett" neutrum ; -- SaldoWN -- comment=21
lin structure_V2 = variants{} ; -- 
lin noun_N = mkN "substantiv" neutrum | mkN "substantiv" neutrum ; -- SaldoWN
lin nomination_N = mkN "nominering" ; -- SaldoWN
lin armchair_N = mkN "fåtölj" "fåtöljer" ; -- SaldoWN
lin virtual_A = mkA "virtuell" ; -- status=guess
lin unprecedented_A = mkA "exempellös" ; -- SaldoWN
lin tumble_V2 = variants{}; -- mkV "tumlar" ; -- comment=4
lin tumble_V = mkV "tumlar" ; -- comment=4
lin ski_N = mkN "skida" ; -- SaldoWN
lin architectural_A = variants{} ; -- 
lin violation_N = mkN "intrång" neutrum | mkN "våldtäkt" "våldtäkter" ; -- SaldoWN -- comment=3
lin rocket_N = mkN "raket" "raketer" ; -- SaldoWN
lin inject_V2 = variants{} ; -- 
lin departmental_A = variants{} ; -- 
lin row_V2 = mkV2 (mkV "gräla") | mkV2 (mkV "bråka"); -- status=guess, src=wikt status=guess, src=wikt
lin row_V = mkV "ror" ; -- comment=8
lin luxury_A = variants{} ; -- 
lin fax_N = variants{} ; -- 
lin deer_N = mkN "hjort" ; -- SaldoWN
lin climber_N = mkN "streber" ; -- comment=2
lin photographic_A = mkA "fotografisk" ; -- status=guess
lin haunt_V2 = dirV2 (partV (mkV "spökar")"ut"); -- status=guess
lin fiercely_Adv = variants{} ; -- 
lin dining_N = variants{} ; -- 
lin sodium_N = mkN "natrium" neutrum | mkN "natrium" neutrum ; -- SaldoWN -- status=guess
lin gossip_N = mkN "skvallerbytta" ; -- comment=3
lin bundle_N = mkN "knippe" | mkN "packe" utrum ; -- SaldoWN -- comment=9
lin bend_N = mkN "vända" ; -- comment=13
lin recruit_N = mkN "rekryt" "rekryter" ; -- status=guess
lin hen_N = mkN "höna" ; -- SaldoWN
lin fragile_A = mkA "bräcklig" ; -- comment=6
lin deteriorate_V2 = mkV2 (mkV "försämras"); -- status=guess, src=wikt
lin deteriorate_V = mkV "försämrar" ; -- comment=2
lin dependency_N = variants{} ; -- 
lin swift_A = mkA "strid" ; -- comment=2
lin scramble_V2 = variants{} ; -- 
lin scramble_V = variants{} ; -- 
lin overview_N = mkN "överblick" | mkN "översikt" "översikter" ; -- SaldoWN
lin imprison_V2 = mkV2 (mkV "fängsla"); -- status=guess, src=wikt
lin trolley_N = mkN "spårvagn" | mkN "kärra" ; -- SaldoWN -- comment=2
lin rotation_N = mkN "rotation" "rotationer" ; -- SaldoWN
lin denial_N = mkN "förnekande" ; -- SaldoWN
lin boiler_N = mkN "ångpanna" ; -- comment=4
lin amp_N = variants{} ; -- 
lin trivial_A = mkA "trivial" ; -- status=guess
lin shout_N = mkN "skälla" | mkN "skrika" ; -- SaldoWN -- comment=3
lin overtake_V2 = mkV2 (mkV (mkV "kör") "om"); -- status=guess, src=wikt
lin make_N = mkN "vara" ; -- comment=8
lin hunter_N = mkN "jägare" utrum ; -- SaldoWN
lin guess_N = mkN "gissning" ; -- comment=2
lin doubtless_Adv = mkAdv "säkerligen" ; -- status=guess
lin syllable_N = mkN "stavelse" "stavelser" ; -- SaldoWN
lin obscure_A = mkA "obskyr" | mkA "otydlig" ; -- SaldoWN -- comment=12
lin mould_N = mkN "mögel" neutrum | mkN "mögel" neutrum ; -- SaldoWN -- comment=17
lin limestone_N = mkN "kalksten" ; -- status=guess
lin leak_V2 = mkV2 (mkV "läcka"); -- status=guess, src=wikt
lin leak_V = mkV "läcker" ; -- status=guess
lin beneficiary_N = mkN "förmånstagare" utrum ; -- SaldoWN
lin veteran_N = mkN "veteran" "veteraner" ; -- SaldoWN
lin surplus_A = variants{} ; -- 
lin manifestation_N = mkN "utslag" neutrum; -- comment=7
lin vicar_N = mkN "kyrkoherde" utrum; -- comment=2
lin textbook_N = mkN "lärobok" "läroböcker" ; -- SaldoWN
lin novelist_N = variants{} ; -- 
lin halfway_Adv = mkAdv "halvvägs" ; -- status=guess
lin contractual_A = mkA "avtalsenlig" ; -- SaldoWN
lin swap_V2 = variants{}; -- mkV "byter" ;
lin swap_V = mkV "byter" ; -- status=guess
lin guild_N = mkN "skrå" "skråt" "skrån" "skråen" ; -- SaldoWN
lin ulcer_N = mkN "sår" neutrum | mkN "sår" neutrum ; -- SaldoWN -- comment=2
lin slab_N = mkN "häll" ; -- SaldoWN
lin detector_N = mkN "sensor" "sensorer" | mkN "detektor" "detektorer" ; -- SaldoWN
lin detection_N = variants{} ; -- 
lin cough_V = mkV "hostar" ; -- comment=3
lin whichever_Quant = variants{} ; -- 
lin spelling_N = mkN "stavning" ; -- status=guess
lin lender_N = mkN "långivare" utrum; -- status=guess
lin glow_N = mkN "glöd" "glöder" ; -- SaldoWN
lin raised_A = variants{} ; -- 
lin prolonged_A = variants{} ; -- 
lin voucher_N = mkN "kupong" "kuponger" | mkN "kvitto" "kvittot" "kvitton" "kvittona" ; -- SaldoWN -- comment=8
lin t_shirt_N = variants{} ; -- 
lin linger_V = mkV "sölar" ; -- comment=2
lin humble_A = mkA "ödmjuk" ; -- comment=8
lin honey_N = mkN "honung" ; -- SaldoWN
lin scream_N = mkN "skrika" ; -- SaldoWN
lin postcard_N = mkN "vykort" neutrum | (mkN "vykort" neutrum) | (mkN "brevkort" neutrum) ; -- SaldoWN -- status=guess status=guess
lin managing_A = variants{} ; -- 
lin alien_A = mkA "utländsk" ; -- comment=5
lin trouble_V2 = variants{}; -- mkV "besvärar" ;
lin reverse_N = mkN "backa" | mkN "vända" ; -- SaldoWN -- comment=16
lin odour_N = mkN "odör" "odörer" ; -- comment=4
lin fundamentally_Adv = variants{} ; -- 
lin discount_V2 = variants{}; -- mkV "diskonterar" ; -- comment=3
lin discount_V = mkV "diskonterar" ; -- comment=3
lin blast_V2 = variants{}; -- mkV "spränger" ; -- comment=6
lin blast_V = mkV "spränger" ; -- comment=6
lin syntactic_A = variants{} ; -- 
lin scrape_V2 = dirV2 (partV (mkV "sparar")"in"); -- comment=5
lin scrape_V = mkV "sparar" ; -- comment=10
lin residue_N = mkN "rest" "rester" ; -- comment=3
lin procession_N = mkN "tåg" neutrum; -- comment=2
lin pioneer_N = mkN "pionjär" "pionjärer" ; -- SaldoWN
lin intercourse_N = mkN "samlag" neutrum; -- comment=3
lin deter_V2 = mkV2 (mkV "förhindra"); -- status=guess, src=wikt
lin deadly_A = mkA "dödlig" | mkA "fullständig" ; -- SaldoWN -- comment=4
lin complement_V2 = variants{} ; -- 
lin restrictive_A = mkA "restriktiv" ; -- SaldoWN
lin nitrogen_N = mkN "kväve" ; -- status=guess
lin citizenship_N = mkN "medborgarskap" neutrum; -- status=guess
lin pedestrian_N = mkN "fotgängare" utrum | mkN "fotgängare" utrum ; -- SaldoWN -- comment=2
lin detention_N = mkN "kvarsittning" ; -- comment=7
lin wagon_N = mkN "piket" "piketer" | (mkN "vagn") | mkN "kärra" ; -- SaldoWN -- status=guess status=guess
lin microphone_N = mkN "mikrofon" "mikrofoner" ; -- SaldoWN
lin hastily_Adv = variants{} ; -- 
lin fixture_N = mkN "inventarium" "inventariet" "inventarier" "inventarierna" ; -- comment=3
lin choke_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=3
lin choke_V = mkV "stryper" ; -- comment=7
lin wet_V2 = mkV2 (mkV "vätas"); -- status=guess, src=wikt
lin weed_N = mkN "ogräs" neutrum | mkN "ogräs" neutrum ; -- SaldoWN
lin programming_N = mkN "programmering" ; -- status=guess
lin power_V2 = variants{} ; -- 
lin nationally_Adv = variants{} ; -- 
lin dozen_N = mkN "dussin" neutrum ; -- status=guess
lin carrot_N = mkN "morot" "morötter" ; -- SaldoWN
lin bulletin_N = mkN "bulletin" "bulletiner" ; -- SaldoWN
lin wording_N = mkN "formulering" | mkN "lydelse" "lydelser" ; -- SaldoWN
lin vicious_A = mkA "giftig" | mkA "illvillig" ; -- SaldoWN -- comment=4
lin urgency_N = mkN "brådska" ; -- SaldoWN
lin spoken_A = variants{} ; -- 
lin skeleton_N = mkN "skelett" neutrum; -- status=guess
lin motorist_N = mkN "bilist" "bilister" ; -- SaldoWN
lin interactive_A = mkA "interaktiv" ; -- SaldoWN
lin compute_V2 = dirV2 (partV (mkV "räknar")"ut"); -- comment=5
lin compute_V = mkV "räknar" ; -- comment=4
lin whip_N = mkN "piska" ; -- SaldoWN
lin urgently_Adv = variants{} ; -- 
lin telly_N = variants{} ; -- 
lin shrub_N = mkN "buske" utrum; -- status=guess
lin porter_N = mkN "bärare" utrum | mkN "bärare" utrum ; -- SaldoWN -- comment=3
lin ethics_N = mkN "etik" ; -- SaldoWN
lin banner_N = mkN "baner" "baneret" "baner" "baneren" | mkN "banderoll" "banderoller" ; -- SaldoWN -- comment=5
lin velvet_N = mkN "sammet" ; -- SaldoWN
lin omission_N = mkN "förbiseende" | mkN "utelämnande" ; -- SaldoWN -- comment=3
lin hook_V2 = mkV2 (mkV "krokar") | mkV2 (mkV "hakar"); -- status=guess, src=wikt status=guess, src=wikt
lin hook_V = mkV "knäpper" ; -- comment=5
lin gallon_N = mkN "gallon" "gallonen" "gallon" "gallonen" ; -- SaldoWN
lin financially_Adv = variants{} ; -- 
lin superintendent_N = mkN "kommissarie" "kommissarier" | mkN "ledare" utrum ; -- SaldoWN -- comment=6
lin plug_V2 = dirV2 (partV (mkV "smockar")"till"); -- comment=2
lin plug_V = mkV "tamponerar" ; -- comment=5
lin continuation_N = mkN "förlängning" ; -- SaldoWN
lin reliance_N = mkN "tillit" ; -- SaldoWN
lin justified_A = variants{} ; -- 
lin fool_V2 = dirV2 (partV (mkV "lurar")"till"); -- comment=2
lin detain_V2 = mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV "internerar"); -- status=guess, src=wikt status=guess, src=wikt
lin damaging_A = variants{} ; -- 
lin orbit_N = mkN "omloppsbana" ; -- SaldoWN
lin mains_N = variants{} ; -- 
lin discard_V2 = dirV2 (partV (mkV "kastar")"ut"); -- comment=4
lin dine_V = mkV "dinerar" ; -- status=guess
lin compartment_N = mkN "fack" neutrum | mkN "kupé" "kupéer" ; -- SaldoWN -- comment=2
lin revised_A = variants{} ; -- 
lin privatization_N = mkN "privatisering" ; -- status=guess
lin memorable_A = mkA "minnesvärd" "minnesvärt" ; -- comment=2
lin lately_Adv = variants{} ; -- 
lin distributed_A = variants{} ; -- 
lin disperse_V2 = variants{}; -- mkV "upplöser" ; -- comment=3
lin disperse_V = mkV "upplöser" ; -- comment=3
lin blame_N = mkN "skuld" "skulder" ; -- comment=3
lin basement_N = mkN "källare" utrum; -- comment=2
lin slump_V2 = variants{}; -- mkV "rasar" ; -- comment=2
lin slump_V = mkV "rasar" ; -- comment=2
lin puzzle_V2 = variants{} ; -- 
lin monitoring_N = variants{} ; -- 
lin talented_A = mkA "talangfull" ; -- comment=2
lin nominal_A = mkA "nominell" ; -- comment=3
lin mushroom_N = mkN "champinjon" "champinjoner" ; -- SaldoWN
lin instructor_N = mkN "högskoleadjunkt" "högskoleadjunkter" ; -- comment=3
lin fork_N = variants{} ; -- 
lin fork_4_N = variants{} ; -- 
lin fork_3_N = mkN "vägskäl" neutrum ; -- status=guess
lin fork_1_N = mkN "gaffel" ; -- status=guess
lin board_V2 = dirV2 (partV (mkV "plattar")"ut"); -- comment=2
lin want_N = mkN "vilja" | mkN "behov" neutrum ; -- SaldoWN -- comment=8
lin disposition_N = mkN "sinnelag" neutrum | mkN "lynne" ; -- SaldoWN -- comment=14
lin cemetery_N = mkN "kyrkogård" ; -- SaldoWN
lin attempted_A = variants{} ; -- 
lin nephew_N = mkN "brorson" "brorsöner" ; -- SaldoWN
lin magical_A = mkA "magisk" ; -- status=guess
lin ivory_N = mkN "elfenben" neutrum ; -- SaldoWN
lin hospitality_N = mkN "gästfrihet" | mkN "gästvänlighet" ; -- SaldoWN
lin besides_Prep = mkPrep "jämte" ; -- status=guess
lin astonishing_A = mkA "överraskande" ; -- status=guess
lin tract_N = mkN "broschyr" "broschyrer" | mkN "traktat" "traktater" ; -- SaldoWN -- status=guess
lin proprietor_N = mkN "ägare" utrum; -- comment=2
lin license_V2 = mkV2 (mkV "licensierar") | mkV2 (mkV (mkV "ge") "tillstånd) "); -- status=guess, src=wikt status=guess, src=wikt
lin differential_A = mkA "differentiell" ; -- status=guess
lin affinity_N = mkN "släktskap" | mkN "frändskap" "frändskaper" ; -- SaldoWN -- comment=4
lin talking_N = variants{} ; -- 
lin royalty_N = mkN "royalty" "royaltyn" "royalties" "royalties" ; -- SaldoWN
lin neglect_N = mkN "försummelse" "försummelser" | mkN "slarva" ; -- SaldoWN -- comment=2
lin irrespective_A = mkA "oberoende" ; -- status=guess
lin whip_V2 = dirV2 (partV (mkV "slå" "slog" "slagit")"ut"); -- comment=18
lin whip_V = mkV "vispar" ; -- comment=8
lin sticky_A = mkA "tryckande" | mkA "omedgörlig" ; -- SaldoWN -- comment=11
lin regret_N = mkN "ånger" | mkN "saknad" "saknader" ; -- SaldoWN -- comment=6
lin incapable_A = mkA "oförmögen" "oförmöget" ; -- SaldoWN
lin franchise_N = mkN "koncession" "koncessioner" | mkN "rösträtt" ; -- SaldoWN -- comment=6
lin dentist_N = mkN "tandläkare" utrum ; -- SaldoWN -- comment=2
lin contrary_N = mkN "motsats" "motsatser" | mkN "stridande" ; -- SaldoWN -- comment=2
lin profitability_N = variants{} ; -- 
lin enthusiast_N = mkN "entusiast" "entusiaster" ; -- comment=2
lin crop_V2 = mkV2 "beta" "betar" "beta" "betog" "betagit" "betagen" | mkV2 (mkV "beskära" "beskar" "beskurit") ; -- SaldoWN -- status=guess, src=wikt
lin crop_V = mkV "beta" "betar" "beta" "betog" "betagit" "betagen" | mkV "skördar" ; -- SaldoWN -- comment=5
lin utter_V2 = mkV2 (mkV (mkV "ge") "till"); -- status=guess, src=wikt
lin pile_V2 = dirV2 (partV (mkV "lastar")"ur"); -- comment=6
lin pile_V = mkV "samlar" ; -- comment=7
lin pier_N = mkN "pir" | mkN "väggfält" neutrum ; -- SaldoWN -- comment=5
lin dome_N = mkN "kupol" "kupoler" ; -- SaldoWN
lin bubble_N = mkN "bubbla" | mkN "pratbubbla" ; -- SaldoWN -- comment=5
lin treasurer_N = mkN "kassör" "kassörer" ; -- SaldoWN
lin stocking_N = mkN "strumpa" ; -- status=guess
lin sanctuary_N = mkN "helgedom" ; -- SaldoWN
lin ascertain_V2 = variants{} ; -- 
lin arc_N = mkN "kurva" | mkN "båge" ; -- status=guess status=guess
lin quest_N = (mkN "resa") | (mkN "uppdrag" neutrum) | mkN "mål" | mkN "strävan" ; -- status=guess status=guess status=guess status=guess
lin mole_N = mkN "mullvad" ; -- SaldoWN
lin marathon_N = mkN "maraton" neutrum | mkN "maratonlopp" neutrum ; -- SaldoWN -- comment=2
lin feast_N = mkN "bankett" "banketter" | mkN "högtid" "högtider" ; -- SaldoWN -- comment=3
lin crouch_V = variants{} ; -- 
lin storm_V2 = variants{}; -- mkV "stormar" ;
lin storm_V = mkV "stormar" ; -- status=guess
lin hardship_N = mkN "vedermöda" ; -- SaldoWN
lin entitlement_N = mkN "rättighet" "rättigheter" | mkN "berättigande" ; -- SaldoWN -- comment=2
lin circular_N = mkN "roterande" ; -- comment=6
lin walking_A = variants{} ; -- 
lin strap_N = mkN "band" neutrum | mkN "stropp" ; -- SaldoWN -- comment=4
lin sore_A = mkA "öm" "ömt" "ömma" "ömma" "ömmare" "ömmast" "ömmaste" ; -- comment=6
lin complementary_A = variants{} ; -- 
lin understandable_A = mkA "förståelig" ; -- comment=4
lin noticeable_A = mkA "påtaglig" ; -- comment=9
lin mankind_N = variants{} ; -- 
lin majesty_N = mkN "majestät" neutrum; -- comment=2
lin pigeon_N = mkN "duva" ; -- SaldoWN
lin goalkeeper_N = mkN "målvakt" "målvakter" ; -- SaldoWN
lin ambiguous_A = mkA "tvetydig" ; -- SaldoWN
lin walker_N = mkN "fotgängare" utrum; -- comment=2
lin virgin_N = mkN "oskuld" "oskulder" ; -- SaldoWN
lin prestige_N = mkN "prestige" utrum | mkN "prestige" utrum ; -- SaldoWN
lin preoccupation_N = mkN "upptagenhet" "upptagenheter" ; -- SaldoWN
lin upset_A = variants{} ; -- 
lin municipal_A = mkA "kommunal" ; -- SaldoWN
lin groan_V2 = mkV2 (mkV "stöna"); -- status=guess, src=wikt
lin groan_V = mkV "stönar" ; -- status=guess
lin craftsman_N = mkN "hantverkare" utrum ; -- SaldoWN
lin anticipation_N = mkN "förutseende" ; -- status=guess
lin revise_V2 = mkV2 "revidera" ; -- status=guess
lin revise_V = mkV "revidera" ; -- status=guess
lin knock_N = mkN "slag" neutrum; -- comment=13
lin infect_V2 = mkV2 (mkV "smittar"); -- status=guess, src=wikt
lin infect_V = mkV "smittar" ; -- comment=3
lin denounce_V2 = mkV2 (mkV (mkV "säga") "upp"); -- status=guess, src=wikt
lin confession_N = mkN "erkännande" | mkN "trosbekännelse" "trosbekännelser" ; -- SaldoWN -- comment=8
lin turkey_N = mkN "kalkon" "kalkoner" ; -- SaldoWN
lin toll_N = mkN "tull" | mkN "slå" ; -- SaldoWN -- comment=8
lin pal_N = mkN "vän" "vännen" "vänner" "vännerna" ; -- comment=3
lin transcription_N = mkN "överföring" ; -- comment=11
lin sulphur_N = mkN "svavel" neutrum | mkN "svavel" neutrum ; -- SaldoWN -- comment=2
lin provisional_A = mkA "provisorisk" ; -- comment=3
lin hug_V2 = dirV2 (partV (mkV "kramar")"ut"); -- comment=2
lin particular_N = variants{} ; -- 
lin intent_A = variants{} ; -- 
lin fascinate_V2 = variants{} ; -- 
lin conductor_N = mkN "ledare" utrum | mkN "konduktör" "konduktörer" ; -- SaldoWN -- comment=4
lin feasible_A = mkA "genomförbar" ; -- status=guess
lin vacant_A = mkA "vakant" "vakant" ; -- SaldoWN
lin trait_N = mkN "drag" neutrum | mkN "drag" neutrum ; -- SaldoWN = mkN "drag" neutrum ; -- comment=4
lin meadow_N = mkN "äng" ; -- SaldoWN
lin creed_N = mkN "tro" | mkN "trosartikel" ; -- SaldoWN -- comment=6
lin unfamiliar_A = variants{} ; -- 
lin optimism_N = mkN "optimism" "optimismer" ; -- SaldoWN
lin wary_A = mkA "rädd" ; -- status=guess
lin twist_N = mkN "skiftnyckel" | mkN "vändning" ; -- SaldoWN -- comment=6
lin sweet_N = mkN "efterrätt" "efterrätter" | mkN "karamell" "karameller" ; -- SaldoWN -- comment=5
lin substantive_A = mkA "verklig" ; -- comment=5
lin excavation_N = mkN "utgrävning" | mkN "utgrävningsplats" "utgrävningsplatser" ; -- SaldoWN -- comment=2
lin destiny_N = mkN "öde" ; -- comment=3
lin thick_Adv = mkAdv "tjockt" ; -- status=guess
lin pasture_N = mkN "bete" utrum | mkN "betesmark" "betesmarker" ; -- SaldoWN = mkN "bete" ; -- comment=6
lin archaeological_A = mkA "arkeologisk" ; -- SaldoWN
lin tick_V2 = variants{}; -- mkV "tickar" ;
lin tick_V = mkV "tickar" ; -- status=guess
lin profit_V2 = variants{}; -- mkV "gagnar" ; -- comment=2
lin profit_V = mkV "gagnar" ; -- comment=2
lin pat_V2 = mkV2 (mkV "klappar"); -- status=guess, src=wikt
lin pat_V = mkV "klappar" ; -- comment=3
lin papal_A = mkA "påvlig" ; -- status=guess
lin cultivate_V2 = mkV2 (mkV "odlar"); -- status=guess, src=wikt
lin awake_V = mkV "väcker" ; -- comment=2
lin trained_A = variants{} ; -- 
lin civic_A = mkA "medborgerlig" ; -- SaldoWN
lin voyage_N = mkN "resa" ; -- SaldoWN
lin siege_N = mkN "belägring" ; -- SaldoWN
lin enormously_Adv = variants{} ; -- 
lin distract_V2 = variants{}; -- mkV "avleda" "avledde" "avlett" ; -- comment=3
lin distract_V = mkV "avleda" "avledde" "avlett" ; -- comment=3
lin stroll_V = mkV "strövar" ; -- comment=5
lin jewel_N = mkN "juvel" "juveler" | mkN "sten" "stenen" "stenar" "stenarna" ; -- SaldoWN -- comment=6
lin honourable_A = mkA "rättskaffens" ; -- comment=5
lin helpless_A = mkA "hjälplös" ; -- SaldoWN
lin hay_N = mkN "hö" neutrum ; -- SaldoWN
lin expel_V2 = variants{} ; -- 
lin eternal_A = mkA "evig" ; -- SaldoWN
lin demonstrator_N = mkN "demonstrant" "demonstranter" | mkN "demonstratör" "demonstratörer" ; -- SaldoWN -- comment=3
lin correction_N = mkN "korrigering" | mkN "tillrättavisning" ; -- SaldoWN -- comment=9
lin civilization_N = mkN "civilisation" "civilisationer" | mkN "civilisering" ; -- SaldoWN -- comment=4
lin ample_A = mkA "dryg" | mkA "tillräcklig" ; -- SaldoWN -- comment=7
lin retention_N = variants{} ; -- 
lin rehabilitation_N = mkN "upprättelse" "upprättelser" | mkN "restauration" "restaurationer" ; -- SaldoWN -- comment=3
lin premature_A = compoundA (regA "förhastad"); -- comment=4
lin encompass_V2 = mkV2 (mkV "inringar"); -- status=guess, src=wikt
lin distinctly_Adv = variants{} ; -- 
lin diplomat_N = mkN "diplomat" "diplomater" ; -- SaldoWN
lin articulate_V2 = dirV2 (partV (mkV "talar")"om"); -- status=guess
lin articulate_V = mkV "artikulerar" ; -- comment=5
lin restricted_A = variants{} ; -- 
lin prop_V2 = dirV2 (partV (mkV "lutar")"av"); -- status=guess
lin intensify_V2 = mkV2 (mkV "intensifieras"); -- status=guess, src=wikt
lin intensify_V = mkV "skärper" ; -- comment=4
lin deviation_N = mkN "avvikelse" "avvikelser" | mkN "avsteg" neutrum ; -- SaldoWN -- comment=5
lin contest_V2 = mkV2 "bestrida" "bestred" "bestritt" ; -- SaldoWN
lin contest_V = mkV "bestrida" "bestred" "bestritt" | mkV "strida" "stridde" "stritt" ; -- SaldoWN -- comment=4
lin workplace_N = mkN "arbetsplats" "arbetsplatser" ; -- SaldoWN
lin lazy_A = mkA "lat" ; -- SaldoWN
lin kidney_N = mkN "njure" utrum ; -- SaldoWN
lin insistence_N = mkN "insisterande" | mkN "envishet" ; -- SaldoWN -- comment=5
lin whisper_N = mkN "viska" | mkN "viskning" ; -- SaldoWN -- comment=5
lin multimedia_N = mkN "multimedia" ; -- status=guess
lin forestry_N = mkN "skogsbruk" neutrum | mkN "skogsvård" ; -- SaldoWN
lin excited_A = variants{} ; -- 
lin decay_N = mkN "sönderfall" neutrum | mkN "förfall" neutrum ; -- SaldoWN
lin screw_N = mkN "skruv" ; -- SaldoWN
lin rally_V2V = variants{}; -- mkV "samlar" ; -- comment=2
lin rally_V2 = variants{}; -- mkV "samlar" ; -- comment=2
lin rally_V = mkV "samlar" ; -- comment=2
lin pest_N = mkN "bråkmakare" utrum | mkN "skadedjur" neutrum ; -- SaldoWN -- comment=3
lin invaluable_A = mkA "ovärderlig" ; -- comment=2
lin homework_N = mkN "läxa" ; -- status=guess
lin harmful_A = mkA "skadlig" ; -- comment=3
lin bump_V2 = dirV2 (partV (mkV "törnar")"in"); -- status=guess
lin bump_V = mkV "stöter" ; -- comment=9
lin bodily_A = mkA "fysisk" ; -- comment=2
lin grasp_N = mkN "våld" neutrum; -- comment=7
lin finished_A = variants{} ; -- 
lin facade_N = mkN "fasad" "fasader" | mkN "utanverk" neutrum ; -- SaldoWN -- comment=2
lin cushion_N = mkN "dyna" | mkN "vall" ; -- SaldoWN -- comment=6
lin conversely_Adv = variants{} ; -- 
lin urge_N = mkN "mana" | mkN "kräva" ; -- SaldoWN -- comment=9
lin tune_V2 = dirV2 (partV (mkV "visar")"in"); -- status=guess
lin tune_V = mkV "trimmar" ; -- comment=5
lin solvent_N = mkN "lösningsmedel" ; -- status=guess
lin slogan_N = mkN "slagord" neutrum | mkN "slogan" "slogan" "slogans" "slogansen" ; -- SaldoWN -- comment=2
lin petty_A = mkA "småaktig" | mkA "småsint" "småsint" ; -- SaldoWN -- comment=11
lin perceived_A = variants{} ; -- 
lin install_V2 = mkV2 (mkV "installerar"); -- status=guess, src=wikt
lin install_V = mkV "monterar" ; -- comment=3
lin fuss_N = mkN "ståhej" neutrum | mkN "bråka" ; -- SaldoWN -- comment=8
lin rack_N = mkN "ställ" neutrum | mkN "ställ" neutrum ; -- SaldoWN -- comment=4
lin imminent_A = mkA "överhängande" ; -- comment=2
lin short_N = mkN "kortslutning" | mkN "knapp" ; -- SaldoWN -- comment=9
lin revert_V = variants{} ; -- 
lin ram_N = mkN "slå" ; -- comment=10
lin contraction_N = mkN "kontraktion" "kontraktioner" | mkN "sammandragning" ; -- SaldoWN
lin tread_V2 = dirV2 (partV (mkV "trampar")"ut"); -- comment=17
lin tread_V = mkV "sular" ; -- comment=7
lin supplementary_A = mkA "extra" ; -- status=guess
lin ham_N = mkN "skinka" ; -- SaldoWN
lin defy_V2V = variants{} ; -- 
lin defy_V2 = variants{} ; -- 
lin athlete_N = mkN "atlet" "atleter" | mkN "idrottare" utrum ; -- SaldoWN
lin sociological_A = mkA "sociologisk" ; -- status=guess
lin physician_N = mkN "läkare" utrum; -- comment=2
lin crossing_N = mkN "övergångsställe" | mkN "korsning" ; -- SaldoWN -- comment=3
lin bail_N = mkN "borgen" ; -- status=guess
lin unwanted_A = compoundA (regA "oönskad"); -- status=guess
lin tight_Adv = mkAdv "fast" ; -- status=guess
lin plausible_A = mkA "rimlig" ; -- comment=5
lin midfield_N = mkN "mittfält" neutrum; -- status=guess
lin alert_A = mkA "alert" "alert" | mkA "vaken" "vaket" ; -- SaldoWN -- comment=6
lin feminine_A = mkA "kvinnlig" ; -- SaldoWN
lin drainage_N = mkN "dränering" ; -- status=guess
lin cruelty_N = mkN "grymhet" ; -- SaldoWN = mkN "grymhet" "grymheter" ;
lin abnormal_A = mkA "abnorm" ; -- SaldoWN
lin relate_N = variants{} ; -- 
lin poison_V2 = mkV2 (mkV "förgifta"); -- status=guess, src=wikt
lin symmetry_N = mkN "symmetri" "symmetrier" ; -- SaldoWN
lin stake_V2 = variants{} ; -- 
lin rotten_A = L.rotten_A ;
lin prone_A = compoundA (regA "framåtlutad"); -- comment=3
lin marsh_N = mkN "sumpmark" "sumpmarker" | mkN "kärr" neutrum ; -- SaldoWN -- comment=7
lin litigation_N = mkN "rättstvist" "rättstvister" | mkN "process" "processer" ; -- SaldoWN -- comment=2
lin curl_N = mkN "ring" neutrum; -- comment=12
lin urine_N = mkN "urin" ; -- SaldoWN
lin latin_A = mkA "latinsk" ; -- status=guess
lin hover_V = mkV "sväva" ; -- status=guess, src=wikt
lin greeting_N = mkN "hälsning" | mkN "lyckönskning" ; -- SaldoWN -- comment=4
lin chase_N = mkN "springa" ; -- comment=2
lin spouseMasc_N = variants{} ; -- 
lin produce_N = mkN "avkastning" | mkN "produktion" "produktioner" ; -- SaldoWN -- comment=6
lin forge_V2 = mkV2 (mkV "förfalska"); -- status=guess, src=wikt
lin forge_V = mkV "förfalskar" ; -- status=guess
lin salon_N = mkN "salong" "salonger" ; -- SaldoWN
lin handicapped_A = variants{} ; -- 
lin sway_V2 = variants{}; -- mkV "svänger" ; -- comment=8
lin sway_V = mkV "svänger" ; -- comment=8
lin homosexual_A = mkA "homosexuell" ; -- status=guess
lin handicap_V2 = variants{} ; -- 
lin colon_N = mkN "kolon" ; -- status=guess
lin upstairs_N = variants{} ; -- 
lin stimulation_N = mkN "stimulans" "stimulanser" | mkN "stimulering" ; -- SaldoWN -- comment=2
lin spray_V2 = dirV2 (partV (mkV "sprutar")"in"); -- status=guess
lin original_N = mkN "nyskapande" ; -- comment=6
lin lay_A = mkA "täck" ; -- comment=4
lin garlic_N = mkN "vitlök" ; -- SaldoWN
lin suitcase_N = mkN "resväska" ; -- status=guess
lin skipper_N = mkN "skeppare" utrum; -- status=guess
lin moan_VS = variants{}; -- mkV "gnäller" ; -- comment=4
lin moan_V = mkV "gnäller" ; -- comment=4
lin manpower_N = mkN "arbetskraft" ; -- comment=3
lin manifest_V2 = variants{} ; -- 
lin incredibly_Adv = variants{} ; -- 
lin historically_Adv = variants{} ; -- 
lin decision_making_N = variants{} ; -- 
lin wildly_Adv = variants{} ; -- 
lin reformer_N = mkN "reformator" "reformatorer" ; -- status=guess
lin quantum_N = mkN "kvantum" neutrum; -- status=guess
lin considering_Subj = variants{} ; -- 
}
