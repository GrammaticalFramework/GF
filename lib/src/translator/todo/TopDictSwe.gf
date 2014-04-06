concrete TopDictSwe of TopDict = CatSwe ** open ParadigmsSwe, (I = IrregSwe), (C = CommonScand), (R = ResSwe), (L = LexiconSwe), (M = MakeStructuralSwe), (S = SyntaxSwe) in {

---- AR checked till element_N: you can start from there

lin of_Prep = mkPrep "av" ;
lin and_Conj = S.and_Conj ;
lin in_Prep = S.in_Prep ;
lin have_VV = auxVV (mkV "böra" "borde" "bort") ;
lin have_VS = mkVS (mkV "tänker") ;
lin have_V2V = mkV2V I.göra_V ;
lin have_V2 = S.have_V2;
lin have_V = lin V S.have_V2 ;
lin it_Pron = S.it_Pron;
lin to_Prep = S.to_Prep;
lin for_Prep = S.for_Prep;
lin i_Pron = S.i_Pron;
lin that_Subj = S.that_Subj;
lin he_Pron = S.he_Pron;
lin on_Prep = S.on_Prep;
lin with_Prep = S.with_Prep;
lin do_V2 = mkV2 I.göra_V ;
lin do_V = I.göra_V ;
lin at_Prep = mkPrep "vid" ;
lin by_Prep = mkPrep "genom" ; ---
lin but_Conj = M.mkConj "men" ;
lin from_Prep = S.from_Prep;
lin they_Pron = S.they_Pron;
lin she_Pron = S.she_Pron;
lin or_Conj = S.or_Conj;
lin as_Subj = M.mkSubj "när" ;
lin we_Pron = S.we_Pron;
lin say_VV = mkVV (mkV "säga" "sade" "sagt") ;
lin say_VS = L.say_VS ;
lin say_VA = mkV "säga" "sade" "sagt" ;
lin say_V2 = mkV2 "säga" "sade" "sagt" ;
lin say_V = mkV "säga" "sade" "sagt" ;
lin if_Subj = S.if_Subj;
lin go_VV = mkVV L.go_V ;
lin go_VS = mkVS L.go_V ;
lin go_VA = mkVA I.bliva_V ;
lin go_V2 = mkV2 L.go_V ;
lin go_V = L.go_V ;
lin get_VV = mkVV I.få_V ;
lin get_VS = mkVS I.få_V ;
lin get_VA = mkVA I.få_V ;
lin get_V2V = mkV2V I.få_V ;
lin get_V2 = mkV2 I.få_V ;
lin get_V = I.få_V ;
lin make_VV = mkVV I.göra_V ;
lin make_VS = mkVS (mkV "göra" "gjorde" "gjort");
lin make_VA = mkVA I.göra_V ;
lin make_V3 = mkV3 I.göra_V (mkPrep "till") ;
lin make_V2V = mkV2V I.göra_V ;
lin make_V2A = mkV2A I.göra_V ;
lin make_V2 = mkV2 I.göra_V ;
lin make_V = I.göra_V ;
lin as_Prep = mkPrep "som" ;
lin out_Adv = mkAdv "ute" ;
lin up_Adv = mkAdv "upp" ;
lin see_VS = mkVS (mkV "se" "såg" "sett") ;
lin see_VQ = mkV "se" "såg" "sett" ;
lin see_VA = mkVA (mkV (mkV "vinka") "av") ;
lin see_V2V = mkV2V "se" "såg" "sett" ;
lin see_V2 = L.see_V2 ;
lin see_V = mkV "se" "såg" "sett" ;
lin know_VS = L.know_VS ;
lin know_VQ = L.know_VQ ;
lin know_V2V = mkV2V "känna" "känne" "känt" ;
lin know_V2 = L.know_V2 ;
lin know_V = L.know_VS ;
lin time_N = mkN "tid" "tider" ;
lin time_2_N = mkN "gång" "gånger" ;
lin time_1_N = mkN "tid" "tider" ;
lin take_VA = mkVA I.taga_V ;
lin take_V2V = mkV2V I.taga_V ;
lin take_V2A = mkV2A I.taga_V ;
lin take_V2 = mkV2 I.taga_V ;
lin take_V = I.taga_V ;
lin so_Adv = mkAdv "så" ;
lin year_N = L.year_N ;
lin into_Prep = mkPrep "in i" ;
lin then_Adv = mkAdv "då" ;
lin think_VS = mkVS (mkV "tänker") ;
lin think_V2A = mkV2A (mkV "tänker") (mkPrep "som") ;
lin think_V2 = mkV2 "tänker" ;
lin think_V = L.think_V;
lin come_VV = mkVV L.come_V ;
lin come_VS = mkVS (mkV "inträffa") ;
lin come_VA = mkVA (mkV "bli" "blev" "blivit") ;
lin come_V2 = dirV2 (partV (mkV "komma" "kom" "kommit")"vid");
lin come_V = L.come_V;
lin than_Subj = M.mkSubj "än" ;
lin more_Adv = mkAdv "mer" ;
lin about_Prep = mkPrep "om" ;
lin now_Adv = L.now_Adv;
lin last_A = mkA "sista" | mkA "förra" | mkA "sistliden" "sistlidet" ; -- SaldoWN -- comment=4
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
lin look_VV = mkVV (partV I.se_V "ut") ;
lin look_VA = mkVA (partV I.se_V "ut") ;
lin look_V2V = mkV2V (mkV "tittar");
lin look_V2 = mkV2 (mkV "titta") (mkPrep "på") ;
lin look_V = mkV "titta" ;
lin like_Prep = mkPrep "likt" ;
lin use_VV = mkVV (mkV "bruka") ;
lin use_V2V = mkV2V (mkV "använder");
lin use_V2 = dirV2 (mkV "använder") ;
lin use_V = mkV "använder" ;
lin because_Subj = S.because_Subj;
lin good_A = mkA "god" "gott" "goda" "goda" "bättre" "bäst" "bästa" | mkA "bra" "bra" "bra" "goda" "bättre" "bäst" "bästa" ;
lin find_VS = mkVS (mkV "anse" "ansåg" "ansett");
lin find_V2V = mkV2V (mkV "finna" "fann" "funnit") ;
lin find_V2A = mkV2A (mkV "finna" "fann" "funnit") ;
lin find_V2 = L.find_V2;
lin find_V = mkV "hitta" ;
lin man_N = L.man_N ;
lin want_VV = S.want_VV;
lin want_VS = mkVS I.vilja_V ;
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
lin tell_VV = mkVV (mkV "berätta") ;
lin tell_VS = mkVS (mkV "berätta") ;
lin tell_V3 = mkV3 (mkV "skvallrar"); -- status=guess, src=wikt
lin tell_1_V3 = mkV3 (mkV "berätta") (mkPrep "för") ;
lin tell_2_V3 = mkV3 (mkV "skilja") (mkPrep "från") ;
lin tell_V2V = mkV2V (mkV "berätta") (mkPrep []) (mkPrep "för") ;
lin tell_V2S = mkV2S (mkV "berätta") (mkPrep "för") ;
lin tell_V2Q = mkV2Q (mkV "berätta") (mkPrep "för") ;
lin tell_V2 = mkV2 "berätta" ;
lin tell_V = mkV "avgöra" "avgjorde" "avgjort" ;
lin through_Prep = S.through_Prep;
lin back_Adv = mkAdv "tillbaka" ;
lin still_Adv = mkAdv "fortfarande" ;
lin child_N = L.child_N ;
lin here_Adv = mkAdv "här" ;
lin over_Prep = mkPrep "över" ;
lin too_Adv = mkAdv "alltför" ;
lin put_VS = mkVS I.sätta_V ;
lin put_V2V = mkV2V I.sätta_V ;
lin put_V2 = L.put_V2;
lin put_V = mkV "sätta" "sätter" "sätt" "satte" "satt" "satt" ;
lin on_Adv = mkAdv "på" ;
lin no_Interj = mkInterj "nej" ;
lin work_VV = mkVV (mkV "fungerar") ;
lin work_V2 = dirV2 (partV (mkV "ordnar")"om");
lin work_V = mkV "arbetar" ;
lin work_2_V = mkV "fungera" | mkV "funka" ;
lin work_1_V = mkV "arbetar" | mkV "jobbar" ;
lin become_VS = mkVS (mkV "bli" "blev" "blivit") ;
lin become_VA = L.become_VA ;
lin become_V2 = mkV2 "bli" "blev" "blivit" ;
lin become_V = mkV "bli" "blev" "blivit" ;
lin old_A = L.old_A ;
lin government_N = mkN "regering" ;
lin mean_VV = mkVV (mkV "mena") ;
lin mean_VS = mkVS (mkV "betyda" "betydde" "betytt") | mkVS (mkV "mena") ;
lin mean_VA = mkVA (mkV "mena") | mkVA (mkV "betyda" "betydde" "betytt") ;
lin mean_V2V = mkV2V (mkV "betyda" "betydde" "betytt") | mkV2V (mkV "mena") ;
lin mean_V2 = mkV2 "betyda" "betydde" "betytt" | mkV2 "mena"| mkV2 (mkV "innebär" "innebar" "inneburit") ;
lin mean_V = mkV "betyda" "betydde" "betytt" | mkV "avse" "avsåg" "avsett" ;
lin part_N = mkN "del" ;
lin leave_VV = mkVV (mkV "lämna");
lin leave_VS = mkVS (mkV "lämna");
lin leave_V2V = mkV2V (mkV "lämna");
lin leave_V2 = L.leave_V2;
lin leave_V = mkV "avgå" "avgick" "avgått" ;
lin life_N = mkN "liv" neutrum ;
lin great_A = mkA "stor" "större" "störst" ;
lin case_N = mkN "fall" neutrum ;
lin woman_N = L.woman_N ;
lin over_Adv = mkAdv "förbi" ;
lin seem_VV = auxVV (mkV "verka") ;
lin seem_VS = mkVS (mkV "förefalla") | mkVS (mkV "verkar") | mkVS (mkV "tyckas") | mkVS (mkV "synas") ;
lin seem_VA = mkVA (mkV "förefalla") | mkVA (mkV "verkar") | mkVA (mkV "tyckas") | mkVA (mkV "synas") ;
lin seem_V2 = mkV2 (mkV "förefalla") | mkV2 (mkV "verkar") | mkV2 (mkV "tyckas") | mkV2 (mkV "synas");
lin seem_V = partV I.se_V "ut" ;
lin work_N = mkN "jobb" neutrum | mkN "arbete" "arbeten" ;
lin need_VV = mkVV (mkV "behöver") ;
lin need_VV = mkVV (mkV "behöver") ;
lin need_VS = mkVS (mkV "behöver") ;
lin need_V2V = mkV2V (mkV "behöver") ;
lin need_V2 = mkV2 "behöver" ;
lin need_V = mkV "behöver" ;
lin feel_VS = mkV "känna" "kände" "känt" ;
lin feel_VA = mkVA (reflV (mkV "känna" "känne" "känt")) ;
lin feel_V2 = mkV2 "känna" "kände" "känt" ;
lin feel_V = mkV "känna" "kände" "känt" ;
lin system_N = mkN "system" neutrum ;
lin each_Det = M.mkDet "varje" singular ;
lin may_2_VV = auxVV (mkV "få" "fick" "fått") ;
lin may_1_VV = S.can_VV ;
lin much_Adv = mkAdv "mycket" ;
lin ask_VV = mkVV I.bedja_V ;
lin ask_VS = mkVS I.bedja_V ;
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
lin show_V2V = mkV2V (mkV "visa") ;
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
lin try_V2V = mkV2V (mkV "pröva") ;
lin try_V2 = mkV2 "försöker" ;
lin try_V = mkV "försöker" ;
lin call_V3 = mkV3 "kalla" ;
lin call_V2V = mkV2V (mkV "kalla") ;
lin call_V2A = mkV2A (mkV "kallar") ;
lin call_V2 = mkV2 "kalla" | mkV2 "anropa" ;
lin call_V = mkV "kalla" | mkV "anropa" ;
lin hand_N = L.hand_N ;
lin party_N = mkN "parti" "partit" "partier" "partierna" | mkN "grupp" "grupper" ; ---
lin party_2_N = mkN "parti" "partiet" "partier" "partierna" ;
lin party_1_N = mkN "kalas" "kalas" ;
lin high_A = mkA "hög" "högre" "högst" ;
lin about_Adv = mkAdv "omkring" ;
lin something_NP = S.something_NP;
lin school_N = L.school_N ;
lin in_Adv = mkAdv "av" ; -- comment=14
lin in_1_Adv = mkAdv "inne" ;
lin in_2_Adv = mkAdv "in" ;
lin small_A = L.small_A ;
lin place_N = mkN "plats" "platser" ;
lin before_Prep = S.before_Prep;
lin while_Subj = M.mkSubj "medan" ;
lin away_Adv = mkAdv "undan" ; -- comment=4
lin away_2_Adv = mkAdv "bort" ;
lin away_1_Adv = mkAdv "borta" ;
lin keep_VV = mkVV (partV (mkV "hålla" "höll" "hållit") "på") ;
lin keep_VS = mkVS (mkV "hålla" "höll" "hållit") ;
lin keep_VA = mkVA (mkV "hålla" "höll" "hållit") ;
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
lin provide_VS = mkV "förse" "försåg" "försett" | mkVS (mkV "förse") ;
lin provide_V2 = mkV2 "förse" "försåg" "försett" | mkV2 (mkV "erbjuda" "erbjöd" "erbjudit") ;
lin provide_V = mkV "förse" "försåg" "försett" | mkV "tillhandahålla" "tillhandahöll" "tillhandahållit" ;
lin week_N = mkN "vecka" ;
lin hold_VS = mkVS I.hålla_V ;
lin hold_V3 = mkV3 I.hålla_V ;
lin hold_V2V = mkV2V I.hålla_V ;
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
lin turn_V2A = mkV2A (mkV "göra" "gjorde" "gjort") ;
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
lin bring_V2V = mkV2V (mkV "bringer") ;
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
lin like_V2V = mkV2V (mkV (mkV "tycker") "om") | mkV2V (mkV "gillar") ;
lin like_V2 = L.like_V2;
lin social_A = mkA "social" ;
lin write_VV = mkVV (mkV "skriva" "skrev" "skrivit") ;
lin write_VS = mkV "skriva" "skrev" "skrivit" ;
lin write_V2 = L.write_V2 ;
lin write_V = mkV "skriva" "skrev" "skrivit" ;
lin state_N = mkN "tillstånd" neutrum | mkN "stat" "stater" ; -- SaldoWN -- comment=16
lin state_2_N = mkN "tillstånd" neutrum ;
lin state_1_N = mkN "stat" "stater" ;
lin percent_N = mkN "procent" "procenten" "procent" "procenten" ;
lin quite_Adv = S.quite_Adv;
lin both_Det = M.mkDet "båda" plural ;
lin start_V2 = mkV2 "starta" ;
lin start_V = partV I.sätta_V "igång" ;
lin run_VS = mkVS I.driva_V ;
lin run_V2 = mkV2 I.driva_V ;
lin run_V = L.run_V ;
lin long_A = L.long_A ;
lin right_Adv = mkAdv "rätt" | mkAdv "just" ; --- sense
lin right_2_Adv = mkAdv "till höger" ;
lin right_1_Adv = mkAdv "rätt" ;
lin set_VV = mkVV I.sätta_V ;
lin set_VS = mkVS I.sätta_V ;
lin set_V2 = mkV2 I.sätta_V ;
lin set_V = mkV "sätta" "sätter" "sätt" "satte" "satt" "satt" ;
lin help_VV = mkVV (mkV "hjälper") ;
lin help_VS = mkVS (mkV "hjälper") ;
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
lin play_VV = mkVV (mkV "spela") ;
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
lin move_VV = mkVV (reflV (mkV "rör")) ;
lin move_V2V = mkV2V (mkV "rör") ;
lin move_V2A = mkV2A (mkV "rör") ;
lin move_V2 = mkV2 "beröra" "berörde" "berört" | mkV2 "flytta" ;
lin move_V = mkV "beröra" "berörde" "berört" | mkV "flyttar" ; -- SaldoWN -- comment=24
lin move_2_V = mkV "flyttar" ;
lin move_1_V = reflV (mkV "rör") ;
lin interest_N = mkN "ränta" ; -- SaldoWN
lin interest_4_N = mkN "intresse" ; ---
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
lin yet_Adv = mkAdv "dock" ; -- comment=8
lin yet_2_Adv = mkAdv "dock" ;
lin yet_1_Adv = mkAdv "ännu" ;
lin perhaps_Adv = mkAdv "kanske" ;
lin meet_V2V = mkV2V (mkV "möter") ;
lin meet_V2 = mkV2 "möter" ;
lin meet_V = mkV "träffas" ;
lin level_N = mkN "våning" | mkN "plan" "planer" ; -- SaldoWN -- comment=8
lin level_2_N = mkN "plan" "plan" ;
lin level_1_N = mkN "nivå" "nivåer" ;
lin until_Subj = M.mkSubj "tills" ;
lin though_Subj = lin Subj {s = "fast"} ;
lin policy_N = mkN "policy" "policier" | mkN "politik" ;
lin include_VV = mkVV (mkV "innehålla" "innehöll" "innehållit") | mkVV (mkV "inkluderar") | mkVV (mkV "innefattar") ;
lin include_V2 = mkV2 "innehålla" "innehöll" "innehållit" ;
lin include_V = mkV "innehålla" "innehöll" "innehållit" | mkV "inkluderar" ;
lin believe_VS = mkVS (mkV "tro") ;
lin believe_V2V = mkV2V (mkV "tror") ;
lin believe_V2 = mkV2 (mkV "tror") ;
lin believe_V = mkV "tror" ;
lin council_N = mkN "råd" neutrum ;
lin already_Adv = L.already_Adv ;
lin possible_A = mkA "möjlig" ;
lin nothing_NP = S.nothing_NP ;
lin line_N = mkN "rad" "rader" ;
lin allow_VS = mkV "tillåta" "tillät" "tillåtit" ;
lin allow_V2V = mkV2V "tillåta" "tillät" "tillåtit" ;
lin allow_V2 = mkV2 "tillåta" "tillät" "tillåtit" ;
lin allow_V = mkV "tillåta" "tillät" "tillåtit" ;
lin need_N = mkN "behov" neutrum ;
lin effect_N = mkN "effekt" "effekter" ;
lin big_A = L.big_A;
lin use_N = mkN "användning" ;
lin lead_VS = mkV "leda" "ledde" "lett" | mkVS (mkV "leder") ;
lin lead_V2V = mkV2V "leda" "ledde" "lett" | mkV2V (mkV "leder") ;
lin lead_V2 = mkV2 "leda" "ledde" "lett" | mkV2 (mkV "leder") ;
lin lead_V = mkV "leda" "ledde" "lett" | mkV "leder" ;
lin stand_VV = mkVV (mkV "stå" "stod" "stått") ;
lin stand_VS = mkVS (mkV "stå" "stod" "stått") ;
lin stand_V2 = dirV2 (partV (mkV "stå" "stod" "stått")"ut") ;
lin stand_V = L.stand_V ;
lin idea_N = mkN "idé" "idéer" ;
lin study_N = mkN "studie" "studiet" "studier" "studierna" ;
lin lot_N = mkN "mängd" "mängder" | mkN "allt" neutrum ;
lin live_VV = mkVV (mkV "lever");
lin live_V2 = mkV2 "lever" ;
lin live_V = L.live_V;
lin job_N = mkN "jobb" neutrum | mkN "arbete" ;
lin since_Subj = M.mkSubj "sedan" ;
lin name_N = L.name_N ;
lin result_N = mkN "resultat" neutrum ;
lin body_N = mkN "kropp" ;
lin happen_VV = mkVV (mkV "händer") | mkVV (mkV "ske" "skedde" "skett") | mkVV (mkV "inträffa") ;
lin happen_V2 = mkV2 (mkV "händer") | mkV2 (mkV "ske" "skedde" "skett") | mkV2 (mkV "inträffa") ;
lin happen_V = mkV "händer" ;
lin friend_N = L.friend_N ;
lin right_N = mkN "rättighet" "rättigheter" ;
lin least_Adv = mkAdv "minst" ;
lin right_A = mkA "rätt" | mkA "riktig" ; -- SaldoWN
lin right_2_A = mkA "höger" ;
lin right_1_A = mkA "rätt" ;
lin almost_Adv = mkAdv "nästan" ;
lin much_Det = S.much_Det;
lin carry_V2 = mkV2 I.bära_V ;
lin carry_V = I.bära_V ;
lin authority_N = mkN "auktoritet" "auktoriteter" | mkN "myndighet" "myndigheter" ; -- SaldoWN -- comment=29
lin authority_2_N = mkN "myndighet" "myndigheter" ;
lin authority_1_N = mkN "auktoritet" "auktoriteter" ;
lin long_Adv = mkAdv "länge" ;
lin early_A = mkA "tidig" ;
lin view_N = mkN "åsikt" "åsikter" | mkN "fotografi" "fotografit" "fotografier" "fotografierna" ; -- SaldoWN -- comment=20
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
lin sit_VA = mkV "sitta" "satt" "suttit" ;
lin sit_V2 = mkV2 "sitta" "satt" "suttit" ;
lin sit_V = L.sit_V ;
lin market_N = mkN "marknad" "marknader" ;
lin market_1_N = mkN "torg" "torg" ;
lin market_2_N = mkN "marknad" "marknader" ;
lin appear_VV = mkVV (mkV "verka") ;
lin appear_VS = mkVS (mkV "verka") ;
lin appear_VA = mkVA (mkV "verka") ;
lin appear_V2 = dirV2 (partV (mkV "komma" "kom" "kommit")"vid") ;
lin appear_V = partV I.dyka_V "upp" ;
lin continue_VV = mkVV (mkV "fortsätta" "fortsatte" "fortsatt") ;
lin continue_VS = mkVS (mkV "fortsätta" "fortsatte" "fortsatt") ;
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
lin court_N = mkN "hov" | mkN "domstol" ; -- SaldoWN = mkN "hov" neutrum ; -- comment=10
lin court_2_N = mkN "domstol" ;
lin court_1_N = mkN "hov" "hov" ;
lin office_N = mkN "kontor" neutrum ;
lin let_VS = mkVS (mkV "låta" "lät" "låtit");
lin let_V2V = mkV2V (mkV "låta" "lät" "låtit");
lin let_V2 = mkV2 (mkV "låta");
lin let_V = mkV "låta" "lät" "låtit" ;
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
lin require_VV = mkVV (mkV "kräver");
lin require_VS = mkVS (mkV "kräver");
lin require_V2V = mkV2V (mkV "kräver");
lin require_V2 = mkV2 "kräver" ;
lin require_V = mkV "kräver" ;
lin suggest_VS = mkV "föreslå" "föreslog" "föreslagit" ;
lin suggest_V2 = mkV2 "föreslå" "föreslog" "föreslagit" ;
lin suggest_V = mkV "föreslå" "föreslog" "föreslagit" ;
lin far_A = mkA "avlägsen" "avlägset" | mkA "fjärran" ;
lin towards_Prep = mkPrep "mot" ;
lin anything_NP = S.mkNP (mkPN "något" neutrum) ;
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
lin read_VA = mkVA (mkV "läser") ;
lin read_V2 = L.read_V2;
lin read_V = mkV "läser" ;
lin change_V2 = mkV2 "byter" ;
lin change_V = mkV "förändras" ;
lin society_N = mkN "samhälle" ;
lin process_N = mkN "process" "processer" ;
lin mother_N = mkN "mor" "modern" "mödrar" "mödrarna" | mkN "mamma" ;
lin offer_VV = mkVV (mkV "erbjuda" "erbjöd" "erbjudit") ;
lin offer_VS = mkVS (mkV "erbjuda" "erbjöd" "erbjudit") ;
lin offer_V3 = mkV3 "erbjuda" "erbjöd" "erbjudit" ;
lin offer_V2V = mkV2V "erbjuda" "erbjöd" "erbjudit" ;
lin offer_V2 = mkV2 "erbjuda" "erbjöd" "erbjudit" ;
lin offer_V = mkV "erbjuda" "erbjöd" "erbjudit" ;
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
lin remember_VS = mkVS (mkV (mkV "komma") "ihåg") | mkVS (depV (mkV "minner")) ;
lin remember_V2 = mkV2 (mkV (mkV "komma") "ihåg") | mkV2 (depV (mkV "minner")) ;
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
lin remain_VS = mkVS (mkV "kvarstå" "kvarstod" "kvarstått") ;
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
lin fall_VA = mkV "falla" "föll" "fallit" ;
lin fall_V2 = mkV2 "falla" "föll" "fallit" ;
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
lin send_VS = mkVS (mkV "skickar") | mkVS (mkV "sändar") ;
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
lin understand_V2V = mkV2V (mkV "förstå" "föstod" "förstått") | mkV2V (mkV "begripa" "begrep" "begripit") ;
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
lin return_V2V = mkV2V "återföra" "återförde" "återfört" | mkV2V (mkV "returnerar") ;
lin return_V2 = mkV2 "återföra" "återförde" "återfört" | mkV2 (mkV "returnerar") ;
lin return_V = mkV "återvänder" ;
lin build_V2 = mkV2 "bygger" ;
lin build_V = mkV "bygger" ;
lin spend_V2 = mkV2 (mkV "tillbringa") ;
lin spend_V = mkV "spendera" ;
lin force_N = mkN "kraft" "krafter" ;
lin condition_N = mkN "villkor" neutrum | mkN "tillstånd" neutrum ; -- SaldoWN -- comment=15
lin condition_1_N = mkN "villkor" neutrum ;
lin condition_2_N = mkN "tillstånd" neutrum ;
lin paper_N = L.paper_N ;
lin off_Prep = mkPrep "av" ;
lin major_A = mkA "stor" "större" "störst" | mkA "tung" "tyngre" "tyngst" ;
lin describe_VS = mkVS (mkV "beskriva" "beskrev" "beskrivit") ;
lin describe_V2 = mkV2 "beskriva" "beskrev" "beskrivit" ;
lin describe_V = mkV "beskriva" "beskrev" "beskrivit" ;
lin agree_VV = mkVV (mkV (mkV "komma" "kom" "kommit") "överens om") ;
lin agree_VS = mkVS (mkV I.hålla_V "med") ;
lin agree_V2 = mkV2 (mkV (mkV "komma" "kom" "kommit") "överens") (mkPrep "om") ;
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
lin reach_VA = mkVA (mkV "uppnå") ;
lin reach_V2V = mkV2V (mkV "uppnå") ;
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
lin student_N = mkN "student" "studenter" ;
lin half_Predet = M.mkPredet "halva" "halva" "halva" ;
lin half_Predet = M.mkPredet "halva" "halva" "halva" ;
lin around_Prep = mkPrep "kring" ;
lin language_N = L.language_N ;
lin walk_V2 = mkV2 (mkV I.gå_V "ut") (mkPrep "med") ;
lin walk_V = L.walk_V;
lin die_V2 = mkV2 "dö" "dog" "dött" ;
lin die_V = L.die_V ;
lin special_A = mkA "speciell" ;
lin difficult_A = mkA "svår" ;
lin international_A = mkA "internationell" ;
lin particularly_Adv = mkAdv "i synnerhet" ;
lin department_N = mkN "avdelning" | mkN "institution" "institutioner" ;
lin management_N = mkN "ledning" ;
lin morning_N = mkN "morgon" "morgonen" "morgnar" "morgnarna" ;
lin draw_V2V = mkV2V "dra" "drar" "dra" "drog" "dragit" "dragen" ;
lin draw_V2 = mkV2 "dra" "drar" "dra" "drog" "dragit" "dragen" | dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut") ; -- SaldoWN -- comment=38
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
lin letter_N = variants{} ;
lin letter_2_N = mkN "bokstav" "bokstäver" ;
lin letter_1_N = mkN "brev" "brev" ;
lin create_VV = mkVV (mkV "skapar");
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
lin sell_VS = mkV "sälja" "sålde" "sålt" ;
lin sell_VA = mkV "sälja" "sålde" "sålt" ;
lin sell_V2 = mkV2 "sälja" "sålde" "sålt" ;
lin sell_V = mkV "sälja" "sålde" "sålt" ;
lin event_N = mkN "händelse" "händelser" ;
lin building_N = mkN "byggnad" "byggnader" ;
lin range_N = mkN "urval" neutrum ;
lin behind_Prep = S.behind_Prep;
lin sure_A = mkA "säker" ;
lin report_VS = mkVS (mkV "rapportera") ;
lin report_V2V = mkV2V (mkV "rapporterar") ;
lin report_V2 = mkV2 "rapportera" ;
lin report_V = mkV "rapportera" ;
lin pass_V2 = mkV2 "överlåta" "överlät" "överlåtit" ;
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
lin cause_VS = mkVS (mkV "orsakar") | mkVS (mkV "förorsaka") ;
lin cause_V2V = mkV2V (mkV "orsakar") | mkV2V (mkV "förorsaka") ;
lin cause_V2 = mkV2 "förorsaka" ;
lin arm_N = mkN "arm" | mkN "vapen" "vapnet" "vapen" "vapnen" ; -- SaldoWN -- comment=11
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
lin teacher_N = mkN "lärare" "lärare" ;
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
lin support_VV = mkVV (mkV "stödjer");
lin support_V2 = mkV2 "stödjer" | mkV2 "stöttar" ;
lin window_N = L.window_N ;
lin account_N = mkN "redogörelse" "redogörelser" ;
lin explain_VS = mkVS (mkV "förklara") ;
lin explain_V2 = mkV2 (mkV "förklara") ;
lin stay_VS = mkVS (mkV "stannar") ;
lin stay_VA = mkVA (mkV "förbli" "förblev" "förblivit") ;
lin stay_V2 = mkV2 "stanna" ;
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
lin cover_VS = mkVS (mkV "täcker") ;
lin cover_V2 = mkV2 "täcker" ;
lin apply_VV = mkVV (mkV "ansöker") ;
lin apply_V2V = mkV2V (mkV "tillämper") ;
lin apply_V2 = dirV2 (partV (mkV "passar")"på");
lin apply_1_V2 = mkV2 "tillämpa" ;
lin apply_2_V2 = mkV2 (mkV "ansöka") (mkPrep "om") ;
lin apply_V = mkV "passar" ;
lin project_N = mkN "projekt" neutrum ;
lin raise_V2V = mkV2V (mkV "lyfter") ;
lin raise_V2 = mkV2 "lyfter" ;
lin sale_N = mkN "rea" ;
lin relationship_N = mkN "förhållande" "förhållandena" ;
lin indeed_Adv = mkAdv "verkligen" ;
lin light_N = mkN "ljus" "ljus" ;
lin claim_VV = mkVV (reflV (mkV "hävda")) ;
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
lin cut_V2A = mkV2A (mkV "klipper") ;
lin cut_V2 = L.cut_V2 ;
lin cut_V = mkV "klipper" | I.skära_V ;
lin grow_VS = mkVS (mkV "växer") ;
lin grow_VA = mkVA (mkV "växer") ;
lin grow_V2V = mkV2V (mkV "växer") ;
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
lin choose_VS = mkVS (mkV "välja" "valde" "valt") ;
lin choose_V2V = mkV2V (mkV "välja" "valde" "valt") ;
lin choose_V2 = mkV2 (mkV "välja" "valde" "valt") ;
lin choose_V = mkV "välja" "valde" "valt" ;
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
lin drive_VS = mkVS (mkV "driva" "drev" "drivit") ;
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
lin fail_V2V = mkV2V (mkV "underkänner") ;
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
lin serve_VV = mkVV (mkV "tjäna") ;
lin serve_VS = mkVS (mkV "tjäna") ;
lin serve_V2 = mkV2 "tjäna" ;
lin serve_V = mkV "tjäna" ;
lin according_to_Prep = mkPrep "enligt" ;
lin end_VA = mkVA (mkV "sluta") ;
lin end_V2 = mkV2 "avsluta" ;
lin end_V = mkV "sluta" ;
lin contract_N = mkN "avtal" neutrum | mkN "kontrakt" neutrum ;
lin wide_A = L.wide_A ;
lin occur_V = mkV "förekomma" "förekom" "förekommit" ;
lin agreement_N = mkN "överenskommelse" "överenskommelser" | mkN "avtal" neutrum ;
lin better_Adv = mkAdv "bättre" ;
lin kill_V2 = L.kill_V2;
lin kill_V = mkV "döda" ;
lin act_VA = mkVA (mkV "agerar") | mkVA (mkV "handlar");
lin act_V2V = mkV2V (mkV "agerar") | mkV2V (mkV "handlar");
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
lin close_VS = mkV "stänger" ;
lin close_VA = mkV "stänger" ;
lin close_V2V = mkV2V (mkV "stänger") ;
lin close_V2 = L.close_V2 ;
lin close_V = mkV "stänger" ;
lin represent_V2 = mkV2 "representera" | mkV2 "företräda" "företrädde" "företrätt" ;
lin represent_V = mkV "representera" ;
lin love_VV = mkVV (mkV "älska") ;
lin love_V2V = mkV2V (mkV "älska") ;
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
lin rise_VA = mkV "stiga" "steg" "stigit" ;
lin rise_V2 = mkV2 "stiga" "steg" "stigit" ;
lin rise_V = mkV "stiga" "steg" "stigit" ;
lin date_N = variants{} ;
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
lin prepare_VS = mkVS (reflV (mkV "förbereder")) ;
lin prepare_V2V = mkV2V (mkV "förbereder") ;
lin prepare_V2 = mkV2 (mkV "förbereder") ;
lin prepare_V = reflV (mkV "förbereder") ;
lin factor_N = mkN "faktor" "faktorer" ;
lin other_A = compoundA (mkA "annan" "annat" "andra" "andra" "andra") | mkA "övrig" | mkA "ytterligare" ;
lin anyone_NP = S.mkNP (mkPN "någon" utrum) ;
lin pattern_N = mkN "mönster" "mönster" ;
lin manage_VV = mkVV (mkV "lyckas") ;
lin manage_V2 = mkV2 "leda" "ledde" "lett" ;
lin manage_V = mkV "klarar" ;
lin piece_N = mkN "stycke" ;
lin discuss_VS = mkVS (mkV "diskuterar") ;
lin discuss_V2 = mkV2 (mkV "diskuterar") ;
lin prove_VS = mkVS (mkV "visar") | mkVS (mkV "bevisar");
lin prove_VA = mkVA (reflV (mkV "visar")) ;
lin prove_V2V = mkV2V (mkV "bevisar") ;
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
lin catch_VS = mkVS (mkV "begripa" "begrep" "begripit") ;
lin catch_V2 = mkV2 "fånga" ;
lin catch_V = mkV "fånga" ;
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
lin suppose_V2V = mkV2V "anta" "antar" "anta" "antog" "antagit" "antagen" ;
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
lin future_N = variants{} ;
lin future_3_N = mkN "framtid" "framtider" ;
lin future_1_N = mkN "framtid" "framtider" ;
lin introduce_V2 = mkV2 "införa" "införde" "infört" | mkV2 "introducera" ;
lin analysis_N = mkN "analys" "analyser" ;
lin enter_V2 = mkV2 "inträda" "inträdde" "inträtt" | mkV2 "inför" ; --- split
lin enter_V = mkV "inträda" "inträdde" "inträtt" ;
lin space_N = mkN "rymd" "rymder" ;
lin arrive_V2 = mkV2 (mkV "ankomma" "ankom" "ankommit") ;
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
lin control_V = mkV "kontrollerar" | mkV "kolla" ;
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
lin compare_V2 = mkV2 "jämföra" "jämförde" "jämfört" ;
lin compare_V = mkV "jämföra" "jämförde" "jämfört" ;
lin suffer_V2 = mkV2 "lida" "led" "lidit" ;
lin suffer_V = mkV "lida" "led" "lidit" ;
lin individual_A = mkA "individuell" ;
lin forward_Adv = mkAdv "framåt" ;
lin announce_VS = mkVS (mkV "annonserar") ;
lin announce_V2 = mkV2 "utlyser" ;
lin user_N = mkN "användare" "användare" ;
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
lin indicate_V = mkV "indikera" ;
lin forget_VS = mkVS (mkV "glömmer") ;
lin forget_V2 = L.forget_V2;
lin forget_V = mkV "glömmer" ;
lin station_N = mkN "station" "stationer" ;
lin glass_N = mkN "spegel" ;
lin cup_N = mkN "kopp" | mkN "bål" neutrum ;
lin previous_A = mkA "föregående" ;
lin husband_N = L.husband_N ;
lin recently_Adv = mkAdv "nyligen" ;
lin publish_V2 = mkV2 "publicera" ;
lin publish_V = mkV "publicerar" ;
lin serious_A = mkA "allvarlig" | mkA "seriös" ;
lin anyway_Adv = mkAdv "i alla fall" ;
lin visit_V2V = mkV2V (mkV "besöker") ;
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
lin argument_N = mkN "argumentat" "argument" ;
lin listen_V = mkV "lyssnar" ; -- comment=2
lin show_N = mkN "show" "shower" ;
lin responsibility_N = mkN "ansvar" neutrum | mkN "tillräknelighet" ; -- SaldoWN -- comment=7
lin significant_A = mkA "signifikant" "signifikant" ;
lin deal_N = mkN "affär" "affärer" ;
lin prime_A = mkA "primär" ; -- comment=8
lin economy_N = mkN "sparsamhet" | mkN "besparing" ; -- SaldoWN -- comment=6
lin economy_2_N = mkN "sparsamhet" | mkN "besparing" ;
lin economy_1_N = mkN "ekonomi" "ekonomin" "ekonomier" "ekonomierna" ; ---- END edits by AR
lin element_N = mkN "grundämne" | mkN "element" neutrum ; -- SaldoWN -- comment=8
lin finish_VA = mkVA (mkV "fullfölja") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin finish_V2 = dirV2 (partV (mkV "putsar")"av"); -- comment=3
lin finish_V = mkV "upphöra" "upphörde" "upphört" ; -- comment=17
lin duty_N = mkN "tull" | mkN "plikt" "plikter" ; -- SaldoWN
lin fight_V2V = mkV2V (mkV "strida" "stridde" "stritt") | mkV2V (mkV "slåss") | mkV2V (mkV "kämpa"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fight_V2 = L.fight_V2;
lin fight_V = mkV "strida" "stridde" "stritt" ; -- comment=8
lin train_V2V = mkV2V (mkV "träna"); -- status=guess, src=wikt
lin train_V2 = mkV2 (mkV "träna"); -- status=guess, src=wikt
lin train_V = mkV "räcker" ; -- comment=11
lin maintain_VS = mkVS (mkV "upphålla"); -- status=guess, src=wikt
lin maintain_V2 = mkV2 (mkV "upphålla"); -- status=guess, src=wikt
lin maintain_V = mkV "underhålla" "underhöll" "underhållit" ; -- comment=13
lin attempt_N = mkN "försök" neutrum;
lin leg_N = L.leg_N ;
lin investment_N = mkN "investering" ; -- SaldoWN
lin save_V2 = dirV2 (partV (mkV "sparar")"in");
lin save_V = mkV "sparar" ; -- comment=8
lin throughout_Prep = variants {} ;
lin design_V2V = variants {} ;
lin design_V2 = dirV2 (partV (mkV "ritar")"ut"); -- comment=3
lin design_V = mkV "avse" "avsåg" "avsett" ; -- comment=13
lin suddenly_Adv = variants{} ;
lin brother_N = mkN "bror" "brodern" "bröder" "bröderna" | mkN "broder" "brodern" "bröder" "bröderna" ;
lin improve_V2 = mkV2 "förbättra" ; --
lin improve_V = mkV "förbättrar" ; -- comment=2
lin avoid_VV = mkVV (mkV "undvika" "undvek" "undvikit") ; -- SaldoWN
lin avoid_V2 = mkV2 "undvika" "undvek" "undvikit" ; -- SaldoWN
lin wonder_VQ = L.wonder_VQ;
lin wonder_V2 = dirV2 (partV (mkV "gå" "gick" "gått")"under"); -- comment=2
lin wonder_V = mkV "undrar" ; -- comment=2
lin tend_VV = variants {} ;
lin tend_V2 = dirV2 (partV (mkV "passar")"på"); -- comment=2
lin tend_V = mkV "vårdar" ; -- comment=8
lin title_N = mkN "titel" ;
lin hotel_N = mkN "hotell" neutrum ; -- SaldoWN
lin aspect_N = mkN "aspekt" "aspekter" | mkN "utseende" ; -- SaldoWN -- comment=13
lin increase_N = mkN "ökning" ; -- SaldoWN
lin help_N = mkN "hjälpreda" | mkN "hjälp" ; -- SaldoWN -- comment=4
lin industrial_A = mkA "industriell" ;
lin express_V2 = dirV2 (partV (mkV "formar")"till");
lin summer_N = mkN "sommar" "sommarn" "somrar" "somrarna" ;
lin determine_VV = mkVV (mkV "avgöra") | mkVV (mkV "bestämma"); -- status=guess, src=wikt status=guess, src=wikt
lin determine_VS = mkVS (mkV "avgöra") | mkVS (mkV "bestämma"); -- status=guess, src=wikt status=guess, src=wikt
lin determine_V2V = mkV2V (mkV "avgöra") | mkV2V (mkV "bestämma"); -- status=guess, src=wikt status=guess, src=wikt
lin determine_V2 = mkV2 (mkV "avgöra") | mkV2 (mkV "bestämma"); -- status=guess, src=wikt status=guess, src=wikt
lin determine_V = mkV "förmår" ; -- comment=8
lin generally_Adv = mkAdv "generellt" ;
lin daughter_N = mkN "dotter" "dottern" "döttrar" "döttrarna" ;
lin exist_V2V = mkV2V (mkV "existerar"); -- status=guess, src=wikt
lin exist_V = mkV "lever" ; -- comment=5
lin share_V2 = dirV2 (partV (mkV "delar")"ut");
lin share_V = mkV "delar" ; -- comment=2
lin baby_N = L.baby_N ;
lin nearly_Adv = mkAdv "nästan" ;
lin smile_V2 = mkV2 "le" "log" "lett" | mkV2 (mkV "le" "log" "lett") ; -- SaldoWN -- status=guess, src=wikt
lin smile_V = mkV "le" "log" "lett" ; -- SaldoWN
lin sorry_A = mkA "ledsen" "ledset" ; -- comment=4
lin sea_N = L.sea_N ;
lin skill_N = mkN "färdighet" "färdigheter" ; -- SaldoWN
lin claim_N = mkN "påstående" | mkN "rätt" "rätter" ; -- SaldoWN -- comment=12
lin treat_V2 = dirV2 (partV (mkV "ta" "tar" "ta" "tog" "tagit" "tagen")"ut"); -- comment=4
lin treat_V = mkV "underhandlar" ; -- comment=11
lin remove_V2 = dirV2 (partV (mkV "flyttar")"ut");
lin remove_V = mkV "flyttar" ; -- comment=11
lin concern_N = mkN "omsorg" "omsorger" | mkN "oro" ; -- SaldoWN -- comment=25
lin university_N = L.university_N ;
lin left_A = compoundA (regA "vänster");
lin dead_A = mkA "död" "dött" ;
lin discussion_N = mkN "diskussion" "diskussioner" ; -- comment=6
lin specific_A = mkA "specifik" | mkA "särskild" ;
lin customer_N = variants{} ;
lin box_N = mkN "box" neutrum | mkN "ruta" ; -- SaldoWN = mkN "box" ; -- comment=26
lin outside_Prep = variants {} ;
lin state_VS = mkVS (mkV "förklara"); -- status=guess, src=wikt
lin state_V2 = mkV2 (mkV "förklara"); -- status=guess, src=wikt
lin conference_N = mkN "konferens" "konferenser" ; -- SaldoWN
lin whole_N = mkN "helhet" "helheter" ;
lin total_A = mkA "total" ;
lin profit_N = mkN "vinst" "vinster" ; -- SaldoWN
lin division_N = mkN "division" "divisioner" | mkN "skiljevägg" ; -- SaldoWN -- comment=23
lin division_3_N = mkN "division" "divisioner" ;
lin division_2_N = mkN "division" "divisioner" ;
lin division_1_N = mkN "avdelning" ;
lin throw_V2 = L.throw_V2;
lin throw_V = mkV "ställer" ; -- comment=14
lin procedure_N = mkN "tillvägagångssätt" neutrum | mkN "procedur" "procedurer" ; -- SaldoWN -- comment=2
lin fill_V2 = dirV2 (partV (mkV "stoppar")"till"); -- comment=3
lin fill_V = mkV "tillfredsställer" ; -- comment=14
lin king_N = L.king_N ;
lin assume_VS = mkVS (mkV "anta" "antar" "anta" "antog" "antagit" "antagen"); -- status=guess, src=wikt
lin assume_V2 = mkV2 (mkV "anta" "antar" "anta" "antog" "antagit" "antagen"); -- status=guess, src=wikt
lin assume_V = mkV "tillträda" "tillträdde" "tillträtt" ; -- comment=8
lin image_N = mkN "bild" "bilder" ;
lin oil_N = L.oil_N ;
lin obviously_Adv = variants{} ;
lin unless_Subj = variants {} ;
lin appropriate_A = mkA "lämplig" ; -- SaldoWN
lin circumstance_N = mkN "förhållande" | mkN "omständighet" "omständigheter" ; -- SaldoWN -- comment=7
lin military_A = mkA "militär" ;
lin proposal_N = mkN "förslag" neutrum | mkN "förslag" neutrum ; -- SaldoWN = mkN "förslag" neutrum ; -- comment=4
lin mention_VS = mkVS (mkV "nämna") | mkVS (mkV "omnämna"); -- status=guess, src=wikt status=guess, src=wikt
lin mention_V2 = mkV2 (mkV "nämna") | mkV2 (mkV "omnämna"); -- status=guess, src=wikt status=guess, src=wikt
lin mention_V = mkV "omnämner" ; -- comment=3
lin client_N = mkN "klient" "klienter" ; -- comment=4
lin sector_N = mkN "sektor" "sektorer" ; -- SaldoWN
lin direction_N = mkN "riktning" ;
lin admit_VS = mkV "erkänna" "erkände" "erkänt" | mkVS (mkV "tillåta") ; -- SaldoWN -- status=guess, src=wikt
lin admit_V2 = mkV2 "erkänna" "erkände" "erkänt" | mkV2 (mkV "tillåta") ; -- SaldoWN -- status=guess, src=wikt
lin admit_V = mkV "erkänna" "erkände" "erkänt" | mkV "uppta" "upptar" "uppta" "upptog" "upptagit" "upptagen" ; -- SaldoWN -- comment=9
lin though_Adv = mkAdv "ändå" ;
lin replace_VV = mkVV (mkV "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt") ;
lin replace_V2 = mkV2 "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" | mkV2 (mkV "ersätta") | mkV2 (mkV (mkV "byta") "ut") | mkV2 (mkV "byter") | mkV2 (mkV (mkV "byta") "mot") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin basic_A = mkA "fundamental" ;
lin hard_Adv = variants {} ;
lin instance_N = mkN "belägg" neutrum; -- comment=3
lin sign_N = mkN "tecken" "tecknet" "tecken" "tecknen" ; -- SaldoWN
lin original_A = mkA "ursprunglig" ;
lin successful_A = mkA "framgångsrik" ;
lin okay_Adv = mkAdv "bra" ;
lin reflect_V2 = dirV2 (partV (mkV "funderar")"ut");
lin reflect_V = mkV "reflekterar" ; -- comment=9
lin aware_A = mkA "medveten" "medvetet" ; -- SaldoWN
lin measure_N = mkN "mått" neutrum | mkN "åtgärd" "åtgärder" ; -- SaldoWN -- comment=2
lin attitude_N = mkN "inställning" | mkN "ställning" ; -- SaldoWN -- comment=8
lin disease_N = mkN "sjukdom" ;
lin exactly_Adv = variants{} ;
lin above_Adv = mkAdv "över" ; -- comment=5
lin commission_N = mkN "provision" "provisioner" | mkN "order" ; -- SaldoWN -- comment=17
lin intend_VV = variants {} ;
lin intend_V2V = variants {} ;
lin intend_V2 = variants {} ;
lin intend_V = mkV "ämnar" ; -- comment=6
lin beyond_Prep = mkPrep "bortom" ;
lin seat_N = mkN "stol" ;
lin president_N = mkN "president" "presidenter" ;
lin encourage_V2V = mkV2V (mkV "uppmuntrar"); -- status=guess, src=wikt
lin encourage_V2 = mkV2 (mkV "uppmuntrar"); -- status=guess, src=wikt
lin addition_N = mkN "tillägg" neutrum | mkN "tillökning" ; -- SaldoWN -- comment=10
lin goal_N = mkN "mål" neutrum ;
lin round_Prep = variants {} ;
lin miss_V2 = dirV2 (partV (mkV "bommar")"till"); -- comment=2
lin miss_V = mkV "undgå" "undgick" "undgått" ; -- comment=8
lin popular_A = mkA "populär" ;
lin affair_N = mkN "affär" "affärer" | mkN "händelse" "händelser" ; -- SaldoWN -- comment=7
lin technique_N = mkN "teknik" "tekniker" ; -- SaldoWN
lin respect_N = mkN "respekt" ; -- comment=7
lin drop_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=5
lin drop_V = mkV "överge" "överger" "överge" "övergav" "övergett" "övergiven" ; -- comment=28
lin professional_A = mkA "professionell" | mkA "proffsig" ;
lin less_Det = M.mkDet "mindre" singular; --
lin once_Subj = variants {} ;
lin item_N = mkN "sak" "saker" | mkN "artikel" ; -- SaldoWN -- comment=7
lin fly_VS = mkV "flyga" "flög" "flugit" | mkVS (mkV "flyga" "flög" "flugit") ; -- SaldoWN -- status=guess, src=wikt
lin fly_V2 = mkV2 "flyga" "flög" "flugit" | dirV2 (partV (mkV "rusar")"ut") ; -- SaldoWN -- comment=3
lin fly_V = L.fly_V ;
lin reveal_VS = mkVS (mkV "uppenbarar"); -- status=guess, src=wikt
lin reveal_V2 = dirV2 (partV (mkV "visar")"in");
lin version_N = mkN "version" "versioner" ;
lin maybe_Adv = mkAdv "kanske" ; -- comment=4
lin ability_N = mkN "förmåga" ;
lin operate_V2 = dirV2 (partV (mkV "arbetar")"av");
lin operate_V = mkV "sköter" ; -- comment=11
lin good_N = mkN "nytta" | mkN "tilltalande" ; -- SaldoWN -- comment=9
lin campaign_N = mkN "kampanj" "kampanjer" ;
lin heavy_A = L.heavy_A ;
lin advice_N = mkN "råd" neutrum ;
lin institution_N = mkN "institution" "institutioner" ;
lin discover_VS = mkVS (mkV "avslöja") | mkVS (mkV "upptäcka"); -- status=guess, src=wikt status=guess, src=wikt
lin discover_V2V = mkV2V (mkV "avslöja") | mkV2V (mkV "upptäcka"); -- status=guess, src=wikt status=guess, src=wikt
lin discover_V2 = mkV2 (mkV "avslöja") | mkV2 (mkV "upptäcka"); -- status=guess, src=wikt status=guess, src=wikt
lin discover_V = mkV "upptäcker" ; -- comment=3
lin surface_N = mkN "yta" ;
lin library_N = mkN "bibliotek" neutrum | mkN "bibliotek" neutrum ; -- SaldoWN -- comment=2
lin pupil_N = mkN "pupill" "pupiller" | mkN "elev" "elever" ; -- SaldoWN -- comment=4
lin record_V2 = dirV2 (partV (mkV "visar")"in");
lin refuse_VV = mkVV (mkV "avböja" "avböjde" "avböjt") | mkVV (mkV "vägra") ; -- SaldoWN
lin refuse_V2 = mkV2 "avböja" "avböjde" "avböjt" | mkV2 (mkV "vägra") ; -- SaldoWN = mkV "avböja" "avböjde" "avböjt" ; -- status=guess, src=wikt
lin refuse_V = mkV "avböja" "avböjde" "avböjt" | mkV "vägrar" ; -- SaldoWN = mkV "avböja" "avböjde" "avböjt" ; -- comment=10
lin prevent_V2 = mkV2 (mkV "förhindra");
lin advantage_N = mkN "fördel" "fördelen" "fördelar" "fördelarna" ; -- SaldoWN
lin dark_A = mkA "mörk" | mkA "dunkel" ;
lin teach_V2V = mkV2V (mkV "lära") | mkV2V (mkV (mkV "lära") "ut"); -- status=guess, src=wikt status=guess, src=wikt
lin teach_V2 = L.teach_V2;
lin teach_V = mkV "undervisar" ; -- comment=4
lin memory_N = mkN "minne" ;
lin culture_N = mkN "kultur" "kulturer" ;
lin blood_N = L.blood_N ;
lin cost_V2 = dirV2 (partV (mkV "kostar")"på");
lin cost_V = mkV "kostar" ;
lin majority_N = mkN "majoritet" "majoriteter" ;
lin answer_V2 = mkV2 (mkV "svarar"); -- status=guess, src=wikt
lin answer_V = mkV "uppfyller" ; -- comment=7
lin variety_N = mkN "omväxling" | mkN "sort" "sorter" ; -- SaldoWN -- comment=14
lin variety_2_N = mkN "sort" "sorter" ;
lin variety_1_N = mkN "omväxling" ;
lin press_N = mkN "press" ;
lin depend_V = mkV "litar" ; -- comment=3
lin bill_N = mkN "utskick" neutrum | mkN "räkning" ; -- SaldoWN -- comment=15
lin competition_N = mkN "tävling" ;
lin ready_A = mkA "färdig" | mkA "rask" ; -- SaldoWN -- comment=14
lin general_N = mkN "general" "generaler" | mkN "genomgående" ; -- SaldoWN -- comment=4
lin access_N = mkN "tillgång" | mkN "tillträde" ;
lin hit_V2 = L.hit_V2 ;
lin hit_V = mkV "slå" "slog" "slagit" | mkV "träffar" ; -- SaldoWN -- comment=9
lin stone_N = L.stone_N ;
lin useful_A = mkA "nyttig" ; -- SaldoWN
lin extent_N = mkN "omfattning" | mkN "yta" ; -- SaldoWN -- comment=7
lin employment_N = mkN "arbete" | mkN "användning" ; -- SaldoWN -- comment=9
lin regard_V2 = variants {} ;
lin regard_V = mkV "betraktar" ; -- comment=7
lin apart_Adv = mkAdv "avsides" ; -- comment=3
lin present_N = mkN "present" "presenter" | mkN "gåva" ;
lin appeal_N = mkN "attraktion" "attraktioner" | mkN "bön" "böner" ; -- SaldoWN -- comment=13
lin text_N = mkN "text" "texter" ;
lin parliament_N = mkN "parlament" neutrum | mkN "parlament" neutrum ; -- SaldoWN -- comment=2
lin cause_N = mkN "anledning" | mkN "sak" "saker" ; -- SaldoWN -- comment=8
lin terms_N = variants{} ;
lin bar_N = mkN "stång" "stänger" | mkN "tvärslå" | mkN "bar" "barer" ; -- SaldoWN -- comment=33
lin bar_2_N = mkN "stång" "stänger" ;
lin bar_1_N = mkN "bar" "barer" ;
lin attack_N = mkN "anfall" neutrum ;
lin effective_A = mkA "effektiv" | mkA "faktisk" ; -- SaldoWN -- comment=7
lin mouth_N = L.mouth_N ;
lin down_Prep = mkPrep "nerför" ; --
lin result_V = mkV "utfalla" "utföll" "utfallit" ; -- comment=3
lin fish_N = L.fish_N ;
lin future_A = mkA "framtida" ;
lin visit_N = mkN "besök" neutrum | mkN "besök" neutrum ; -- SaldoWN -- comment=7
lin little_Adv = variants{} ;
lin easily_Adv = mkAdv "lätt" ;
lin attempt_VV = mkVV (mkV "försöka"); -- status=guess, src=wikt
lin attempt_V2 = mkV2 (mkV "försöka"); -- status=guess, src=wikt
lin enable_VS = mkVS (mkV "möjliggöra") | mkVS (mkV "ursäkta"); -- status=guess, src=wikt status=guess, src=wikt
lin enable_V2V = mkV2V (mkV "möjliggöra") | mkV2V (mkV "ursäkta"); -- status=guess, src=wikt status=guess, src=wikt
lin enable_V2 = mkV2 (mkV "möjliggöra") | mkV2 (mkV "ursäkta"); -- status=guess, src=wikt status=guess, src=wikt
lin trouble_N = mkN "problem" neutrum | mkN "bekymmer" neutrum ; -- SaldoWN -- comment=7
lin traditional_A = mkA "traditionell" ;
lin payment_N = mkN "betalning" ; -- SaldoWN
lin best_Adv = mkAdv "bäst" ; -- status=guess
lin post_N = mkN "post" "poster" ;
lin county_N = mkN "län" neutrum;
lin lady_N = mkN "dam" "damer" ; -- SaldoWN
lin holiday_N = mkN "semester" ; -- SaldoWN
lin realize_VS = mkVS (mkV "inse" "insåg" "insett"); -- status=guess, src=wikt
lin realize_V2 = mkV2 (mkV "inse" "insåg" "insett"); -- status=guess, src=wikt
lin importance_N = mkN "vikt" "vikter" ; -- SaldoWN
lin chair_N = L.chair_N ;
lin facility_N = mkN "facilitet" "faciliteter" | mkN "tillfälle" ; -- SaldoWN -- comment=5
lin complete_V2 = mkV2 "komplettera" ; --
lin complete_V = mkV "kompletterar" ; -- comment=8
lin article_N = mkN "artikel" "artiklar" ;
lin object_N = mkN "sak" "saker" | mkN "objekt" neutrum ; -- SaldoWN -- comment=5
lin context_N = mkN "sammanhang" neutrum ; -- SaldoWN -- comment=4
lin survey_N = mkN "översikt" "översikter" ; -- SaldoWN
lin notice_VS = mkVS (mkV "noterar") | mkVS (mkV "observerar") | mkVS (mkV "uppfattar") | mkVS (mkV "förnimma") | mkVS (mkV "märka"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin notice_V2 = dirV2 (partV (mkV "se" "såg" "sett")"ut"); -- comment=4
lin notice_V = mkV "nämner" ; -- comment=14
lin complete_A = mkA "fullständig" | mkA "komplett" ;
lin turn_N = mkN "vända" | mkN "vändning" ; -- SaldoWN -- comment=35
lin direct_A = mkA "direkt" "direkt" ;
lin immediately_Adv = mkAdv "omedelbart" ;
lin collection_N = mkN "samling" ;
lin reference_N = mkN "referens" "referenser" | mkN "hänvisning" ;
lin card_N = mkN "kort" neutrum ;
lin interesting_A = mkA "intressant" "intressant" ; -- SaldoWN
lin considerable_A = mkA "avsevärd" "avsevärt" | mkA "ansenlig" ; -- SaldoWN -- comment=7
lin television_N = L.television_N;
lin extend_V2 = mkV2 "utvidga" ;
lin extend_V = mkV "räcker" ; -- comment=9
lin communication_N = mkN "kommunikation" "kommunikationer" | mkN "överförande" ;
lin agency_N = mkN "förmedling" | mkN "verksamhet" "verksamheter" ; -- SaldoWN -- comment=14
lin physical_A = mkA "fysisk" ;
lin except_Conj = variants{} ;
lin check_V2 = dirV2 (partV (mkV "stoppar")"till"); -- comment=3
lin check_V = mkV "kontrollerar" ; -- comment=15
lin sun_N = L.sun_N ;
lin species_N = mkN "art" "arter" | mkN "slag" neutrum ; -- SaldoWN -- comment=6
lin possibility_N = mkN "möjlighet" "möjligheter" | mkN "utsikt" "utsikter" ; -- SaldoWN -- comment=4
lin official_N = mkN "myndighet" "myndigheter" ;
lin chairman_N = mkN "ordförande" "ordföranden" "ordförande" "ordförandena" ; -- comment=2
lin speaker_N = mkN "talare" utrum | mkN "talman" "talmannen" "talmän" "talmännen" ; -- SaldoWN -- comment=3
lin second_N = mkN "tvåa" | mkN "näst" neutrum ; -- SaldoWN -- comment=7
lin career_N = mkN "karriär" "karriärer" ;
lin laugh_VS = mkVS (mkV "skrattar"); -- status=guess, src=wikt
lin laugh_V2 = dirV2 (partV (mkV "skämmer")"ut"); -- comment=2
lin laugh_V = L.laugh_V;
lin weight_N = mkN "vikt" "vikter" ; -- SaldoWN
lin sound_VS = mkVS (mkV "ljudar") | mkVS (mkV "låta"); -- status=guess, src=wikt status=guess, src=wikt
lin sound_VA = mkVA (mkV "ljudar") | mkVA (mkV "låta"); -- status=guess, src=wikt status=guess, src=wikt
lin sound_V2 = dirV2 (partV (mkV "spelar")"in");
lin sound_V = mkV "sonderar" ; -- comment=11
lin responsible_A = mkA "ansvarig" | mkA "vederhäftig" ;
lin base_N = mkN "grund" "grunder" ;
lin document_N = mkN "dokument" neutrum ;
lin solution_N = mkN "lösning" ; -- SaldoWN
lin return_N = mkN "återkomst" "återkomster" | mkN "retur" "returer" ;
lin medical_A = mkA "medicinsk" ;
lin hot_A = L.hot_A ;
lin recognize_VS = mkVS (mkV "erkänna"); -- status=guess, src=wikt
lin recognize_4_V2 = variants {} ;
lin recognize_1_V2 = variants {} ;
lin talk_N = mkN "samtal" neutrum | mkN "snack" neutrum ; -- SaldoWN -- comment=8
lin budget_N = mkN "budget" ; -- SaldoWN
lin river_N = L.river_N ;
lin fit_V2 = dirV2 (mkV "passar");
lin fit_V = mkV "utrustar" ; -- comment=17
lin organization_N = mkN "organisation" "organisationer" ;
lin existing_A = variants{} ;
lin start_N = mkN "start" "starter" ;
lin push_VS = mkVS (mkV (mkV "skjuta") "på"); -- status=guess, src=wikt
lin push_V2V = mkV2V (mkV (mkV "skjuta") "på"); -- status=guess, src=wikt
lin push_V2 = L.push_V2;
lin push_V = mkV "tränger" ; -- comment=20
lin tomorrow_Adv = mkAdv "imorgon" ;
lin requirement_N = mkN "krav" neutrum | mkN "krav" neutrum ; -- SaldoWN -- comment=4
lin cold_A = L.cold_A ;
lin edge_N = mkN "kant" "kanter" | mkN "skärpa" ; -- SaldoWN -- comment=18
lin opposition_N = mkN "opposition" "oppositioner" ; -- SaldoWN
lin opinion_N = mkN "åsikt" "åsikter" ; -- SaldoWN
lin drug_N = mkN "drog" "droger" ; -- SaldoWN
lin quarter_N = mkN "stadsdel" "stadsdelen" "stadsdelar" "stadsdelarna" | mkN "kvarter" "kvarteret" "kvarter" "kvarteren" | mkN "kvart" "kvarter" ; -- SaldoWN -- comment=17
lin option_N = mkN "option" "optioner" | mkN "val" ; -- SaldoWN -- comment=5
lin sign_V2V = mkV2V (mkV (mkV "skriva") "på"); -- status=guess, src=wikt
lin sign_V2 = mkV2 (mkV (mkV "skriva") "på"); -- status=guess, src=wikt
lin sign_V = mkV "tecknar" ; -- comment=8
lin worth_Prep = variants {} ;
lin call_N = mkN "telefonsamtal" neutrum | mkN "rop" neutrum ; -- SaldoWN -- comment=14
lin define_V2 = variants {} ;
lin define_V = mkV "definierar" ; -- comment=5
lin stock_N = mkN "lager" | mkN "stock" ; -- SaldoWN = mkN "lager" ; = mkN "lager" neutrum ; -- comment=22
lin influence_N = mkN "inflytande" ;
lin occasion_N = mkN "tillfälle" | mkN "evenemang" neutrum ; -- SaldoWN -- comment=8
lin eventually_Adv = mkAdv "till slutet" ;
lin software_N = mkN "mjukvara" | mkN "programvara" ;
lin highly_Adv = mkAdv "i högsta grad" ;
lin exchange_N = mkN "utbyte" ; -- SaldoWN
lin lack_N = mkN "brist" "brister" ;
lin shake_V2 = dirV2 (partV (mkV "skakar")"om"); -- comment=2
lin shake_V = mkV "uppröra" "upprörde" "upprört" ; -- comment=8
lin study_V2 = mkV2 "studera" ; -- CHECKED
lin study_V = mkV "studerar" ; -- comment=4
lin concept_N = mkN "begrepp" neutrum ;
lin blue_A = L.blue_A;
lin star_N = L.star_N ;
lin radio_N = L.radio_N ;
lin arrangement_N = mkN "arrangemang" neutrum | mkN "åtgärd" "åtgärder" ; -- SaldoWN -- comment=16
lin examine_V2 = mkV2 (mkV "undersöka"); -- status=guess, src=wikt
lin bird_N = L.bird_N ;
lin green_A = L.green_A ;
lin band_N = mkN "band" "band" ;
lin sex_N = mkN "kön" neutrum | mkN "sex" neutrum ; -- SaldoWN -- comment=6
lin finger_N = mkN "finger" ; -- SaldoWN
lin past_N = mkN "slut" neutrum; -- comment=3
lin independent_A = mkA "självständig" | mkA "särskild" "särskilt" ; -- SaldoWN -- comment=6
lin independent_2_A = mkA "självständig" ;
lin independent_1_A = mkA "oberoende" ;
lin equipment_N = mkN "utrustning" ;
lin north_N = mkN "norr" | mkN "nord" ;
lin mind_VS = mkVS (mkV (mkV "bekymra") "sig om") | mkVS (mkV (mkV "bry") "sig om") | mkVS (mkV (mkV "fästa") "sig vid") | mkVS (mkV (mkV "ha") "något emot") | mkVS (mkV "tänka"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mind_V2 = mkV2 (mkV (mkV "bekymra") "sig om") | mkV2 (mkV (mkV "bry") "sig om") | mkV2 (mkV (mkV "fästa") "sig vid") | mkV2 (mkV (mkV "ha") "något emot") | mkV2 (mkV "tänka"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mind_V = mkV (mkV "bekymra") "sig om" | mkV (mkV "bry") "sig om" | mkV (mkV "fästa") "sig vid" | mkV (mkV "ha") "något emot" | mkV "tänka" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin move_N = mkN "drag" "drag" ;
lin message_N = mkN "meddelande" ; -- SaldoWN
lin fear_N = mkN "rädsla" ; -- SaldoWN
lin afternoon_N = mkN "eftermiddag" ; -- SaldoWN
lin drink_V2 = L.drink_V2 ;
lin drink_V = mkV "dricka" "drack" "druckit" | mkV "supa" "söp" "supit" ; -- SaldoWN -- comment=4
lin fully_Adv = mkAdv "fullt ut" ;
lin race_N = mkN "ras" "raser" | mkN "tävling" ; -- SaldoWN = mkN "ras" neutrum ;
lin race_2_N = mkN "ras" "ras" ;
lin race_1_N = mkN "tävling" ;
lin gain_V2 = mkV2 "vinna" "vann" "vunnit" | dirV2 (partV (mkV "ökar")"till") ; -- SaldoWN -- comment=2
lin gain_V = mkV "vinna" "vann" "vunnit" | mkV "ökar" ; -- SaldoWN -- comment=4
lin strategy_N = mkN "taktik" "taktiker" ; -- comment=3
lin extra_A = mkA "extra" ; -- comment=4
lin scene_N = mkN "scen" "scener" ;
lin slightly_Adv = mkAdv "något" ;
lin kitchen_N = mkN "kök" neutrum ; -- SaldoWN
lin speech_N = mkN "tal" neutrum | mkN "tal" neutrum ; -- SaldoWN = mkN "tal" neutrum ; -- comment=9
lin arise_VS = mkVS (mkV "uppstå"); -- status=guess, src=wikt
lin arise_V = mkV "utvecklar" ; -- comment=3
lin network_N = mkN "nätverk" neutrum | mkN "nätverk" neutrum ;
lin tea_N = mkN "te" "tet" "teer" "teerna" ; -- SaldoWN = mkN "te" "te" ;
lin peace_N = L.peace_N ;
lin failure_N = mkN "odugling" | mkN "misslyckande" ; -- SaldoWN -- comment=9
lin employee_N = mkN "tjänsteman" "tjänstemannen" "tjänstemän" "tjänstemännen" | mkN "arbetstagare" utrum ; -- SaldoWN -- comment=3
lin ahead_Adv = mkAdv "före" ; -- comment=3
lin scale_N = mkN "våg" "vågor" | mkN "skala" ; -- SaldoWN = mkN "våg" ; -- comment=3
lin hardly_Adv = variants{} ;
lin attend_V2 = mkV2 (mkV "närvara") | mkV2 (mkV "delta" "deltar" "delta" "deltog" "deltagit" "deltagen"); -- status=guess, src=wikt status=guess, src=wikt
lin attend_V = mkV "lyssnar" ; -- comment=13
lin shoulder_N = mkN "vägkant" "vägkanter" ; -- SaldoWN
lin otherwise_Adv = mkAdv "alias" ; -- comment=5
lin railway_N = mkN "järnväg" ;
lin directly_Adv = mkAdv "direkt" ;
lin supply_N = mkN "tillgång" | mkN "tillhandahållande" ; -- SaldoWN -- comment=8
lin expression_N = mkN "uttryck" neutrum | mkN "yttrande" ; -- SaldoWN -- comment=9
lin owner_N = mkN "ägare" utrum ;
lin associate_V2 = variants {} ;
lin associate_V = mkV "uppta" "upptar" "uppta" "upptog" "upptagit" "upptagen" ; -- comment=5
lin corner_N = mkN "vrå" "vrån" "vrår" "vrårna" | mkN "hörna" ; -- SaldoWN -- comment=6
lin past_A = mkA "förfluten" "förflutet" ;
lin match_N = mkN "tändsticka" ; -- SaldoWN
lin match_3_N = mkN "överenskommelse" "överenskommelser" ;
lin match_2_N = mkN "tändsticka" ;
lin match_1_N = mkN "match" "matcher" ;
lin sport_N = mkN "sport" "sporter" ; -- SaldoWN
lin status_N = mkN "status" | mkN "ställning" ;
lin beautiful_A = L.beautiful_A ;
lin offer_N = mkN "erbjudande" ; -- SaldoWN
lin marriage_N = mkN "äktenskap" neutrum | mkN "giftermål" neutrum ;
lin hang_V2 = mkV2 (mkV "hängflyga"); -- status=guess, src=wikt
lin hang_V = mkV "hänger" ; -- comment=3
lin civil_A = mkA "medborgerlig" ;
lin perform_V2 = mkV2 "framträda" "framträdde" "framträtt" ; -- SaldoWN
lin perform_V = mkV "framträda" "framträdde" "framträtt" | mkV "verkställer" ; -- SaldoWN -- comment=12
lin sentence_N = mkN "mening" ; -- SaldoWN
lin crime_N = mkN "brott" neutrum | mkN "brottslighet" "brottsligheter" ; -- SaldoWN = mkN "brott" neutrum ; -- comment=7
lin ball_N = mkN "boll" | mkN "klot" "klot" ;
lin marry_V2 = mkV2 (mkV "gifter") ;
lin marry_V = depV (mkV "gifter") ;
lin wind_N = L.wind_N ;
lin truth_N = mkN "sanning" ; -- SaldoWN
lin protect_V2 = mkV2 (mkV "skyddar"); -- status=guess, src=wikt
lin protect_V = mkV "skyddar" ; -- comment=8
lin safety_N = mkN "säkerhet" "säkerheter" ; -- SaldoWN
lin partner_N = mkN "partner" "partnern" "partner" "partnerna" ; -- SaldoWN
lin completely_Adv = mkAdv "fullständigt" ;
lin copy_N = mkN "kopia" | mkN "reproduktion" "reproduktioner" ; -- SaldoWN -- comment=13
lin balance_N = mkN "saldo" "saldot" "saldon" "saldona" ; -- SaldoWN
lin sister_N = L.sister_N ;
lin reader_N = mkN "läsare" utrum | mkN "läsare" utrum ; -- SaldoWN -- comment=4
lin below_Adv = mkAdv "nedanför" ; -- comment=3
lin trial_N = mkN "prövning" | mkN "rättegång" ; -- SaldoWN -- comment=6
lin rock_N = L.rock_N ;
lin damage_N = mkN "skada" ;
lin adopt_V2 = mkV2 "anta" "antar" "anta" "antog" "antagit" "antagen" | mkV2 (mkV "adopterar") ; -- SaldoWN -- status=guess, src=wikt
lin newspaper_N = L.newspaper_N;
lin meaning_N = mkN "innebörd" "innebörder" | mkN "betydelse" "betydelser" ; -- SaldoWN -- comment=4
lin light_A = mkA "lätt" ;
lin essential_A = mkA "grundläggande" | mkA "väsentlig" ; -- SaldoWN -- comment=5
lin obvious_A = mkA "uppenbar" | mkA "klar" ; -- SaldoWN -- comment=7
lin nation_N = mkN "nation" "nationer" ;
lin confirm_VS = mkVS (mkV "konfirmerar") | mkVS (mkV "försäkra") | mkVS (mkV "bekräfta"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin confirm_V2 = mkV2 (mkV "konfirmerar") | mkV2 (mkV "försäkra") | mkV2 (mkV "bekräfta"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin south_N = mkN "söder" ;
lin length_N = mkN "längd" "längder" ;
lin branch_N = mkN "gren" "grenen" "grenar" "grenarna" ;
lin deep_A = mkA "djup" ;
lin none_NP = variants{} ;
lin planning_N = mkN "planering" ; -- comment=4
lin trust_N = mkN "tillit" | mkN "förvaltning" ; -- SaldoWN -- comment=4
lin working_A = variants{} ;
lin pain_N = mkN "smärta" ; -- SaldoWN
lin studio_N = mkN "studio" "studior" | mkN "ateljé" "ateljéer" ;
lin positive_A = mkA "positiv" ; -- SaldoWN
lin spirit_N = mkN "humör" neutrum | mkN "kraft" "krafter" ; -- SaldoWN -- comment=16
lin college_N = mkN "college" "colleget" "college" "collegen" ;
lin accident_N = mkN "olycka" | mkN "händelse" "händelser" ; -- SaldoWN -- comment=5
lin star_V2 = dirV2 (partV (mkV "agerar")"ut");
lin star_V = mkV "agerar" ; -- comment=3
lin hope_N = mkN "förhoppning" ; -- SaldoWN
lin mark_V3 = mkV3 (mkV "rätta"); -- status=guess, src=wikt
lin mark_V2 = dirV2 (partV (mkV "rättar")"till");
lin works_N = mkN "mekanism" "mekanismer" ; -- comment=11
lin league_N = mkN "serie" "serier" ; -- comment=3
lin league_2_N = mkN "serie" "serier" ;
lin league_1_N = mkN "liga" ;
lin clear_V2V = mkV2V "frikänna" "frikände" "frikänt" | mkV2V (mkV "harklar") ; -- SaldoWN -- status=guess, src=wikt
lin clear_V2 = mkV2 "frikänna" "frikände" "frikänt" | dirV2 (partV (mkV "rensar") "ut") ; -- SaldoWN -- comment=10
lin clear_V = mkV "frikänna" "frikände" "frikänt" | mkV "rensar" ; -- SaldoWN -- comment=25
lin imagine_VS = mkVS (mkV (mkV "föreställa") "sig"); -- status=guess, src=wikt
lin imagine_V2 = mkV2 (mkV (mkV "föreställa") "sig"); -- status=guess, src=wikt
lin imagine_V = mkV "gissar" ; -- comment=7
lin through_Adv = mkAdv "igenom" ; -- comment=4
lin cash_N = mkN "peng" ; -- comment=3
lin normally_Adv = variants{} ;
lin play_N = mkN "pjäs" "pjäser" ;
lin strength_N = mkN "styrka" ;
lin train_N = L.train_N ;
lin travel_V2 = mkV2 (mkV "reser") | mkV2 (mkV "färdas"); -- status=guess, src=wikt status=guess, src=wikt
lin travel_V = L.travel_V;
lin target_N = mkN "mål" neutrum | mkN "mål" neutrum ; -- SaldoWN -- comment=3
lin very_A = variants{} ;
lin pair_N = mkN "par" neutrum | mkN "spann" neutrum ; -- SaldoWN -- comment=4
lin male_A = mkA "manlig" ;
lin gas_N = mkN "gas" "gaser" ;
lin issue_V2 = mkV2 (mkV (mkV "släpper") "ut"); --
lin issue_V = mkV "utfärdar" ;
lin contribution_N = mkN "donation" "donationer" | mkN "bidrag" neutrum ; -- SaldoWN -- comment=3
lin complex_A = mkA "komplex" ;
lin supply_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=3
lin beat_V2 = mkV2 "slå" "slog" "slagit" | dirV2 (partV (mkV "trampar") "ut") ; -- SaldoWN -- comment=18
lin beat_V = mkV "slå" "slog" "slagit" | mkV "vispar" ; -- SaldoWN -- comment=20
lin artist_N = mkN "konstnär" "konstnärer" | mkN "artist" "artister" ;
lin agent_N = variants{} ;
lin presence_N = mkN "närvaro" ;
lin along_Adv = mkAdv "med" ; -- comment=5
lin environmental_A = mkA "miljömässig" ; -- SaldoWN
lin strike_V2 = mkV2 "stryka" "strök" "strukit" | dirV2 (partV (mkV "träffar")"på") ; -- SaldoWN = mkV "stryka" "strök" "strukit" ; -- comment=35
lin strike_V = mkV "stryka" "strök" "strukit" | mkV "träffar" ; -- SaldoWN = mkV "stryka" "strök" "strukit" ; -- comment=47
lin contact_N = mkN "kontaktperson" "kontaktpersoner" | mkN "kontakt" "kontakter" ; -- SaldoWN -- comment=3
lin protection_N = mkN "skydd" neutrum | mkN "skydd" neutrum ; -- SaldoWN = mkN "skydd" neutrum ; -- comment=4
lin beginning_N = mkN "begynnelse" "begynnelser" | mkN "början" "början" "början" "början" ;
lin demand_VS = mkVS (mkV "kräva"); -- status=guess, src=wikt
lin demand_V2 = mkV2 (mkV "kräva"); -- status=guess, src=wikt
lin media_N = mkN "medievetenskap" ; -- status=guess
lin relevant_A = mkA "relevant" "relevant" ; -- SaldoWN
lin employ_V2 = mkV2 (mkV "anställa"); -- status=guess, src=wikt
lin shoot_V2 = mkV2 "skjuta" "sköt" "skjutit" | dirV2 (partV (mkV "störtar")"in") ; -- SaldoWN -- comment=9
lin shoot_V = mkV "skjuta" "sköt" "skjutit" | mkV "vräker" ; -- SaldoWN -- comment=22
lin executive_N = mkN "verkställande" ; -- SaldoWN
lin slowly_Adv = variants{} ;
lin relatively_Adv = mkAdv "relativt" ;
lin aid_N = mkN "bistånd" neutrum ; -- SaldoWN -- comment=2
lin huge_A = mkA "väldig" ; -- SaldoWN
lin late_Adv = mkAdv "sen" ; -- comment=2
lin speed_N = mkN "hastighet" "hastigheter" ;
lin review_N = mkN "tidskrift" "tidskrifter" | mkN "översyn" "översyner" ; -- SaldoWN -- comment=20
lin test_V2 = mkV2 (mkV "utmanar") | mkV2 (mkV "testar"); -- status=guess, src=wikt status=guess, src=wikt
lin order_VV = mkVV (mkV (mkV "ge") "order"); -- status=guess, src=wikt
lin order_VS = mkVS (mkV (mkV "ge") "order"); -- status=guess, src=wikt
lin order_V2V = mkV2V (mkV (mkV "ge") "order"); -- status=guess, src=wikt
lin order_V2 = mkV2 (mkV (mkV "ge") "order"); -- status=guess, src=wikt
lin order_V = mkV "reda" "redde" "rett" ; -- comment=20
lin route_N = mkN "rutt" "rutter" ;
lin consequence_N = mkN "konsekvens" "konsekvenser" ; -- comment=7
lin telephone_N = mkN "telefon" "telefoner" ; -- SaldoWN
lin release_V2 = dirV2 (partV (mkV "löser")"ut"); -- comment=3
lin proportion_N = mkN "proportion" "proportioner" ; -- SaldoWN
lin primary_A = mkA "primär" ;
lin consideration_N = mkN "övervägande" ; -- SaldoWN
lin reform_N = mkN "reform" "reformer" ; -- SaldoWN
lin driver_N = mkN "förare" utrum ;
lin annual_A = mkA "årlig" ;
lin nuclear_A = mkA "nukleär" ;
lin latter_A = mkA "sista" ; -- comment=3
lin practical_A = mkA "praktisk" ; -- SaldoWN
lin commercial_A = mkA "kommersiell" ;
lin rich_A = mkA "rik" ; -- SaldoWN
lin emerge_VS = variants {} ;
lin emerge_V2V = variants {} ;
lin emerge_V2 = variants {} ;
lin emerge_V = mkV "framträda" "framträdde" "framträtt" ; -- comment=2
lin apparently_Adv = mkAdv "tydligen" ;
lin ring_V = mkV "slå" "slog" "slagit" ; -- comment=9
lin ring_6_V2 = variants {} ;
lin ring_4_V2 = dirV2 (partV (mkV "slå" "slog" "slagit") "ut"); -- comment=14
lin distance_N = mkN "distans" "distanser" | mkN "avstånd" neutrum ;
lin exercise_N = mkN "motion" "motioner" | mkN "övning" ; -- SaldoWN -- comment=5
lin key_A = variants {} ;
lin close_Adv = mkAdv "nära" ; -- comment=3
lin skin_N = L.skin_N ;
lin island_N = mkN "ö" ;
lin separate_A = mkA "separat" "separat" | mkA "skild" "skilt" ;
lin aim_VV = mkVV (mkV "siktar"); -- status=guess, src=wikt
lin aim_V2 = dirV2 (partV (mkV "riktar")"till"); -- comment=2
lin aim_V = mkV "strävar" ; -- comment=6
lin danger_N = mkN "fara" ; -- SaldoWN
lin credit_N = mkN "poäng" "poänger" | mkN "tilltro" ; -- SaldoWN = mkN "poäng" neutrum ; -- comment=14
lin usual_A = mkA "sedvanlig" | mkA "vanlig" ; -- SaldoWN -- comment=2
lin link_V2 = mkV2 "förbinda" "förband" "förbundit" | mkV2 (mkV "länka") ; -- SaldoWN -- status=guess, src=wikt
lin link_V = mkV "förbinda" "förband" "förbundit" | mkV "förenar" ; -- SaldoWN -- comment=6
lin candidate_N = mkN "kandidat" "kandidater" ;
lin track_N = mkN "spår" neutrum | mkN "bana" ;
lin safe_A = mkA "säker" | mkA "välbehållen" "välbehållet" ; -- SaldoWN -- comment=8
lin interested_A = mkA "partisk" ; -- comment=3
lin assessment_N = mkN "bedömning" | mkN "värdering" ; -- SaldoWN -- comment=9
lin path_N = mkN "färdväg" | mkN "bana" ; -- SaldoWN -- comment=8
lin merely_Adv = variants{} ;
lin plus_Prep = variants{} ;
lin district_N = mkN "distrikt" neutrum ;
lin regular_A = mkA "regelbunden" "regelbundet" | mkA "reguljär" ;
lin reaction_N = mkN "reaktion" "reaktioner" ; -- SaldoWN
lin impact_N = mkN "kollision" "kollisioner" | mkN "stöt" ; -- SaldoWN -- comment=4
lin collect_V2 = mkV2 (mkV "samlar"); -- status=guess, src=wikt
lin collect_V = mkV "samlar" ; -- comment=6
lin debate_N = mkN "debatt" "debatter" ; -- SaldoWN
lin lay_VS = mkV "lägga" "lade" "lagt" | mkVS (mkV "avskedar") | mkVS (mkV (mkV "säga") "upp") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin lay_V2 = mkV2 "lägga" "lade" "lagt" | dirV2 (partV (mkV "visar")"in") ; -- SaldoWN
lin lay_V = mkV "lägga" "lade" "lagt" | mkV "värper" ; -- SaldoWN -- comment=10
lin rise_N = mkN "uppgång" | mkN "ökning" ; -- SaldoWN -- comment=9
lin belief_N = mkN "tro" ; -- SaldoWN
lin conclusion_N = mkN "avslutning" | mkN "slutledning" ; -- SaldoWN -- comment=11
lin shape_N = mkN "utformning" ; -- comment=12
lin vote_N = mkN "rösträtt" | mkN "väljarkår" "väljarkårer" ; -- SaldoWN -- comment=6
lin aim_N = mkN "syfte" ; -- comment=8
lin politics_N = mkN "politik" ; -- SaldoWN
lin reply_VS = mkVS (mkV "svarar"); -- status=guess, src=wikt
lin reply_V2 = mkV2 (mkV "svarar"); -- status=guess, src=wikt
lin reply_V = mkV "svarar" ; -- comment=2
lin press_V2V = mkV2V (mkV "trycker"); -- status=guess, src=wikt
lin press_V2 = dirV2 (partV (mkV "trugar")"på"); -- comment=3
lin press_V = mkV "ansätta" "ansätter" "ansätt" "ansatte" "ansatt" "ansatt" ; -- comment=12
lin approach_V2 = mkV2 (mkV "stundar"); -- status=guess, src=wikt
lin approach_V = mkV "sätta" "sätter" "sätt" "satte" "satt" "satt" ; -- comment=2
lin file_N = mkN "rad" "rader" | mkN "register" neutrum ; -- SaldoWN = mkN "rad" "raden" "rad" "raden" ; -- comment=14
lin western_A = mkA "västlig" ;
lin earth_N = L.earth_N;
lin public_N = mkN "allmänhet" "allmänheter" | mkN "publik" "publiker" ; -- SaldoWN -- comment=2
lin survive_V2 = mkV2 (mkV "överleva"); -- status=guess, src=wikt
lin survive_V = mkV "överlever" ;
lin estate_N = mkN "egendom" | mkN "tillstånd" neutrum ; -- SaldoWN -- comment=9
lin boat_N = L.boat_N ;
lin prison_N = mkN "fängelse" "fängelset" "fängelser" "fängelserna" ;
lin additional_A = mkA "ytterligare" ;
lin settle_VA = mkV "sjunka" "sjönk" "sjunkit" ; -- SaldoWN
lin settle_V2 = mkV2 "sjunka" "sjönk" "sjunkit" | dirV2 (partV (mkV "ordnar")"om") ; -- SaldoWN -- comment=4
lin settle_V = mkV "sjunka" "sjönk" "sjunkit" | mkV "sätta" "sätter" "sätt" "satte" "satt" "satt" ; -- SaldoWN -- comment=25
lin largely_Adv = mkAdv "i stort" ;
lin wine_N = L.wine_N ;
lin observe_VS = mkVS (mkV "iaktta" "iakttar" "iaktta" "iakttog" "iakttagit" "iakttagen"); -- status=guess, src=wikt
lin observe_V2 = dirV2 (partV (mkV "se" "såg" "sett")"ut"); -- comment=4
lin observe_V = mkV "observerar" ; -- comment=13
lin limit_V2V = mkV2V (mkV "begränsa"); -- status=guess, src=wikt
lin limit_V2 = mkV2 "begränsa" ; --
lin deny_VS = mkVS (mkV "förneka"); -- status=guess, src=wikt
lin deny_V3 = mkV3 (mkV "förneka"); -- status=guess, src=wikt
lin deny_V2 = mkV2 (mkV "förneka"); -- status=guess, src=wikt
lin for_PConj = variants{} ;
lin straight_Adv = mkAdv "direkt" ;
lin somebody_NP = S.somebody_NP;
lin writer_N = mkN "författare" utrum ;
lin weekend_N = mkN "veckoslut" neutrum | mkN "veckoslut" neutrum ; -- SaldoWN -- comment=2
lin clothes_N = variants{} ;
lin active_A = mkA "aktiv" ;
lin sight_N = mkN "syn" | mkN "åsyn" | mkN "sevärdhet" ; -- SaldoWN = mkN "syn" "syner" ; -- comment=16
lin video_N = mkN "video" "videor" ;
lin reality_N = mkN "verklighet" "verkligheter" ; -- SaldoWN
lin hall_N = mkN "sal" | mkN "studenthem" "studenthemmet" "studenthem" "studenthemmen" ; -- SaldoWN -- comment=7
lin nevertheless_Adv = mkAdv "likväl" ; -- comment=3
lin regional_A = mkA "regional" ;
lin vehicle_N = mkN "fordon" neutrum | mkN "fordon" neutrum ; -- SaldoWN -- comment=8
lin worry_VS = mkVS (mkV (mkV "oroa") "sig"); -- status=guess, src=wikt
lin worry_V2 = mkV2 (mkV "oroa") ; -- status=guess, src=wikt
lin worry_V = mkV (mkV "oroa") "sig" ; -- comment=8
lin powerful_A = mkA "mäktig" ;
lin possibly_Adv = mkAdv "möjligen" ;
lin cross_V2 = dirV2 (partV (mkV "korsar")"över");
lin cross_V = mkV "passerar" ; -- comment=7
lin colleague_N = mkN "kollega" ; -- SaldoWN
lin charge_VS = mkVS (mkV "laddar") | mkVS (mkV (mkV "ladda") "upp"); -- status=guess, src=wikt status=guess, src=wikt
lin charge_V2 = dirV2 (partV (mkV "laddar")"ur"); -- comment=2
lin charge_V = mkV "noterar" ; -- comment=16
lin lead_N = mkN "ledarskap" neutrum | mkN "sänke" ;
lin farm_N = mkN "lantgård" | mkN "lantbruk" neutrum ; -- SaldoWN -- comment=4
lin respond_VS = variants {} ;
lin respond_V2 = variants {} ;
lin respond_V = mkV "svarar" ;
lin employer_N = mkN "arbetsgivare" utrum ; -- SaldoWN -- comment=4
lin carefully_Adv = variants{} ;
lin understanding_N = mkN "förståelse" utrum | mkN "förståelse" "förståelser" ; -- SaldoWN
lin connection_N = mkN "koppling" | mkN "släktskap" ; -- SaldoWN -- comment=26
lin comment_N = mkN "skvaller" neutrum | mkN "kritiserande" ; -- SaldoWN -- comment=9
lin grant_V3 = variants {} ;
lin grant_V2 = mkV2 "bevilja" ;
lin concentrate_V2 = variants {} ;
lin concentrate_V = mkV "koncentrerar" ; -- comment=6
lin ignore_V2 = mkV2 (mkV "ignorerar"); -- status=guess, src=wikt
lin ignore_V = mkV "ignorerar" ; -- comment=4
lin phone_N = mkN "telefon" "telefoner" ;
lin hole_N = mkN "röra" | mkN "knipa" ; -- SaldoWN = mkN "röra" ; -- comment=9
lin insurance_N = mkN "försäkring" ; -- SaldoWN
lin content_N = mkN "innehåll" neutrum ;
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
lin front_A = variants{} ;
lin mainly_Adv = mkAdv "huvudsakligen" ;
lin battle_N = mkN "kamp" | mkN "slag" neutrum ;
lin generation_N = mkN "generation" "generationer" | mkN "årsmodell" "årsmodeller" ; -- SaldoWN -- comment=7
lin currently_Adv = mkAdv "nuförtiden" ;
lin winter_N = mkN "vinter" ; -- SaldoWN
lin inside_Prep = variants {} ;
lin impossible_A = mkA "omöjlig" ; -- SaldoWN
lin somewhere_Adv = S.somewhere_Adv;
lin arrange_V2 = dirV2 (partV (mkV "ordnar")"om");
lin arrange_V = mkV "planerar" ; -- comment=12
lin will_N = mkN "vilja" | mkN "kan" "kaner" ; -- SaldoWN -- comment=3
lin sleep_V2 = dirV2 (partV (mkV "sova" "sov" "sovit")"ut"); -- comment=2
lin sleep_V = L.sleep_V;
lin progress_N = mkN "framsteg" neutrum | mkN "framsteg" neutrum ; -- SaldoWN -- comment=4
lin volume_N = mkN "volym" "volymer" ;
lin ship_N = L.ship_N;
lin legislation_N = mkN "lagstiftning" ; -- SaldoWN
lin commitment_N = mkN "lojalitet" "lojaliteter" | mkN "åtagande" ; -- SaldoWN -- comment=12
lin enough_Predet = variants{} ;
lin conflict_N = mkN "konflikt" "konflikter" ;
lin bag_N = mkN "handväska" | mkN "väska" ; -- SaldoWN -- comment=12
lin fresh_A = mkA "färsk" | mkA "uppfriskande" ; -- SaldoWN -- comment=13
lin entry_N = mkN "ingång" | mkN "uppslagsord" neutrum ; -- SaldoWN -- comment=14
lin entry_2_N = mkN "uppslagsord" neutrum ;
lin entry_1_N = mkN "ingång" ;
lin smile_N = mkN "leende" ; -- SaldoWN
lin fair_A = mkA "rättvis" ; -- comment=13
lin promise_VV = mkVV (mkV "lovar"); -- status=guess, src=wikt
lin promise_VS = mkVS (mkV "lovar"); -- status=guess, src=wikt
lin promise_V2 = mkV2 (mkV "lovar"); -- status=guess, src=wikt
lin promise_V = mkV "lovar" ; -- comment=4
lin introduction_N = mkN "introduktion" "introduktioner" | mkN "introducering" ;
lin senior_A = mkA "senior" | mkA "äldre" ;
lin manner_N = mkN "manér" neutrum | mkN "uppträdande" ; -- SaldoWN -- comment=14
lin background_N = mkN "bakgrund" "bakgrunder" ;
lin key_N = mkN "tonart" "tonarter" ; -- SaldoWN
lin key_2_N = mkN "tonart" "tonarter" ;
lin key_1_N = mkN "nyckel" ;
lin touch_V2 = mkV2 "röra" "rörde" "rört" | dirV2 (partV (mkV "stämplar")"ut") ; -- SaldoWN -- comment=6
lin touch_V = mkV "röra" "rörde" "rört" | mkV "skisserar" ; -- SaldoWN -- comment=17
lin vary_V2 = dirV2 (partV (mkV "växlar")"in"); -- comment=2
lin vary_V = mkV "varierar" ; -- comment=4
lin sexual_A = mkA "sexuell" ; -- SaldoWN
lin ordinary_A = mkA "vanlig" ; -- SaldoWN
lin cabinet_N = mkN "skåp" neutrum ; -- SaldoWN -- comment=9
lin painting_N = mkN "tavla" ; -- comment=5
lin entirely_Adv = variants{} ;
lin engine_N = mkN "motor" "motorer" ;
lin previously_Adv = mkAdv "förr" ;
lin administration_N = mkN "förvaltning" ;
lin tonight_Adv = mkAdv "ikväll" | mkAdv "inatt" ;
lin adult_N = mkN "vuxen" ; -- status=guess
lin prefer_VV = mkVV (mkV "föredra" "föredrar" "föredra" "föredrog" "föredragit" "föredragen") ; -- SaldoWN
lin prefer_VS = mkVS (mkV "föredra" "föredrar" "föredra" "föredrog" "föredragit" "föredragen") ; -- SaldoWN
lin prefer_V2V = mkV2V (mkV "föredra" "föredrar" "föredra" "föredrog" "föredragit" "föredragen") ; -- SaldoWN
lin prefer_V2 = mkV2 "föredra" "föredrar" "föredra" "föredrog" "föredragit" "föredragen" ; -- SaldoWN
lin author_N = mkN "upphovsman" "upphovsmannen" "upphovsmän" "upphovsmännen" ;
lin actual_A = mkA "faktisk" ;
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
lin extremely_Adv = mkAdv "extremt" ;
lin wage_N = mkN "lön" "löner" | mkN "driva" ; -- SaldoWN -- comment=4
lin domestic_A = mkA "inhemsk" | mkA "inrikes" ; -- SaldoWN -- comment=4
lin commit_V2V = mkV2V (mkV (mkV "begå") "självmord") | mkV2V (mkV (mkV "ta") "livet av sig") | mkV2V (mkV (mkV "ta") "sitt liv"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin commit_V2 = dirV2 (partV (mkV "skickar")"ut"); -- comment=5
lin threat_N = mkN "hot" ; -- SaldoWN = mkN "hot" neutrum ;
lin bus_N = mkN "buss" ;
lin warm_A = L.warm_A ;
lin sir_N = mkN "magister" ;
lin regulation_N = mkN "bestämmelse" "bestämmelser" | mkN "reglerande" ; -- SaldoWN -- comment=7
lin drink_N = mkN "fylleri" neutrum | mkN "spritdryck" "spritdrycker" ; -- SaldoWN -- comment=15
lin relief_N = mkN "lättnad" "lättnader" | mkN "undsättning" ; -- SaldoWN -- comment=14
lin internal_A = mkA "invärtes" ; -- comment=2
lin strange_A = mkA "säregen" "säreget" | mkA "obekant" "obekant" ; -- SaldoWN -- comment=10
lin excellent_A = mkA "utmärkt" "utmärkt" ; -- comment=12
lin run_N = mkN "springa" | mkN "sats" "satser" ; -- SaldoWN -- comment=37
lin fairly_Adv = variants{} ;
lin technical_A = mkA "teknisk" ; -- SaldoWN
lin tradition_N = mkN "tradition" "traditioner" ;
lin measure_V2 = mkV2 (mkV "mäta"); -- status=guess, src=wikt
lin measure_V = mkV "mäter" ; -- comment=4
lin insist_VS = variants {} ;
lin insist_V2 = variants {} ;
lin insist_V = mkV "vidhålla" "vidhöll" "vidhållit" ; -- comment=4
lin farmer_N = mkN "bonde" "bönder" | mkN "lantbrukare" utrum ; -- SaldoWN -- comment=2
lin until_Prep = mkPrep "ända till" ; --
lin traffic_N = mkN "trafik" "trafiker" ;
lin dinner_N = mkN "middag" ; -- SaldoWN
lin consumer_N = mkN "konsument" "konsumenter" ; -- SaldoWN
lin meal_N = mkN "måltid" "måltider" ; -- SaldoWN
lin warn_VS = mkVS (mkV "varnar"); -- status=guess, src=wikt
lin warn_V2V = mkV2V (mkV "varnar"); -- status=guess, src=wikt
lin warn_V2 = mkV2 (mkV "varnar"); -- status=guess, src=wikt
lin warn_V = mkV "varnar" ; -- comment=2
lin living_A = mkA "bosatt" | mkA "levande" ; -- SaldoWN
lin package_N = mkN "paket" neutrum | mkN "emballerande" ; -- SaldoWN -- comment=8
lin half_N = mkN "halva" ;
lin increasingly_Adv = mkAdv "alltmer" ;
lin description_N = mkN "slag" neutrum; -- comment=7
lin soft_A = mkA "mjuk" ; -- SaldoWN
lin stuff_N = mkN "material" neutrum; -- comment=5
lin award_V3 = variants {} ;
lin award_V2 = mkV2 (mkV "bevilja");
lin existence_N = mkN "existens" "existenser" ;
lin improvement_N = mkN "förbättring" ; -- SaldoWN
lin coffee_N = mkN "kaffe" "kaffet" "kaffe" "kaffen" ;
lin appearance_N = mkN "utseende" ;
lin standard_A = mkA "standard" "standart" ;
lin attack_V2 = mkV2 "anfalla" "anföll" "anfallit" | mkV2 (mkV "attackerar") | mkV2 (mkV "angripa" "angrep" "angripit") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin sheet_N = mkN "segel" neutrum | mkN "tidning" ; -- SaldoWN -- comment=17
lin category_N = mkN "kategori" "kategorier" | mkN "klass" "klasser" ; -- SaldoWN -- comment=3
lin distribution_N = mkN "spridning" ;
lin equally_Adv = variants{} ;
lin session_N = mkN "session" "sessioner" | mkN "termin" "terminer" ; -- SaldoWN -- comment=4
lin cultural_A = mkA "kulturell" ;
lin loan_N = mkN "lån" neutrum | mkN "utlåning" ; -- SaldoWN -- comment=2
lin bind_V2 = mkV2 "binda" "band" "bundit" | dirV2 (partV (mkV "kantar")"av") ; -- SaldoWN
lin bind_V = mkV "binda" "band" "bundit" | mkV "kantar" ; -- SaldoWN -- comment=12
lin museum_N = mkN "museum" "museet" "museer" "museerna" ; -- SaldoWN
lin conversation_N = mkN "samtal" neutrum | mkN "samtalsämne" ; -- SaldoWN -- comment=5
lin threaten_VV = mkVV (mkV "hotar"); -- status=guess, src=wikt
lin threaten_VS = mkVS (mkV "hotar"); -- status=guess, src=wikt
lin threaten_V2 = mkV2 (mkV "hotar"); -- status=guess, src=wikt
lin threaten_V = mkV "hotar" ;
lin link_N = mkN "länk" | mkN "före" ;
lin launch_V2 = mkV2 (mkV "sjösätta"); -- status=guess, src=wikt
lin launch_V = mkV "färjar" ; -- comment=3
lin proper_A = mkA "passande" | mkA "rätt" ; -- SaldoWN -- comment=18
lin victim_N = mkN "offer" neutrum | mkN "slaktoffer" neutrum ; -- SaldoWN -- comment=2
lin audience_N = mkN "publik" "publiker" ; -- SaldoWN
lin famous_A = mkA "berömd" "berömt" ;
lin master_N = mkN "mästare" utrum | mkN "styresman" "styresmannen" "styresmän" "styresmännen" ; -- SaldoWN -- comment=21
lin master_2_N = mkN "magister" ;
lin master_1_N = mkN "mästare" utrum ;
lin lip_N = mkN "läpp" | mkN "oförskämdhet" "oförskämdheter" ; -- SaldoWN -- comment=4
lin religious_A = mkA "religiös" ;
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
lin past_Prep = mkPrep "förbi" ;
lin concern_VS = variants {} ;
lin concern_V2 = variants {} ;
lin concern_V = mkV "oroar" ; -- comment=9
lin freedom_N = mkN "frihet" "friheter" ; -- SaldoWN
lin gentleman_N = mkN "gentleman" "gentlemannen" "gentlemän" "gentlemännen" | mkN "man" ; -- SaldoWN -- comment=4
lin attract_V2 = dirV2 (partV (mkV "lockar")"in");
lin explanation_N = mkN "förklaring" ; -- SaldoWN
lin appoint_VS = mkV "utse" "utsåg" "utsett" ; -- SaldoWN
lin appoint_V3 = mkV3 "utse" "utsåg" "utsett" ; -- SaldoWN
lin appoint_V2V = mkV2V "utse" "utsåg" "utsett" ; -- SaldoWN
lin appoint_V2 = mkV2 "utse" "utsåg" "utsett" ; -- SaldoWN
lin note_VS = mkVS (mkV "märker"); --
lin note_V2 = variants {} ;
lin note_V = mkV "märker" ; -- comment=9
lin chief_A = mkA "viktig" ; -- comment=3
lin total_N = mkN "slutsumma" ;
lin lovely_A = mkA "förtjusande" ; -- comment=4
lin official_A = mkA "officiell" ;
lin date_V2 = mkV2 (mkV "åldras"); -- status=guess, src=wikt
lin date_V = mkV "daterar" ; -- comment=3
lin demonstrate_VS = mkVS (mkV "demonstrerar"); -- status=guess, src=wikt
lin demonstrate_V2 = dirV2 (partV (mkV "visar")"in");
lin demonstrate_V = mkV "demonstrerar" ; -- comment=8
lin construction_N = mkN "konstruktion" "konstruktioner" ;
lin middle_N = mkN "mitt" ; -- SaldoWN
lin yard_N = mkN "yard" "yarden" "yard" "yarden" ; -- SaldoWN
lin unable_A = mkA "oduglig" ; -- comment=3
lin acquire_V2 = mkV2 "skaffa" ; --
lin surely_Adv = variants{} ;
lin crisis_N = mkN "kris" ; -- SaldoWN = mkN "kris" "kriser" ;
lin propose_VV = mkVV (mkV "friar"); -- status=guess, src=wikt
lin propose_VS = mkVS (mkV "friar"); -- status=guess, src=wikt
lin propose_V2 = mkV2 (mkV "föreslå" "föreslog" "föreslagit"); --
lin propose_V = mkV "ämnar" ; -- comment=4
lin west_N = mkN "väster" | mkN "väst" ;
lin impose_V2 = variants {} ;
lin impose_V = mkV "utnyttjar" ; -- comment=6
lin market_V2 = mkV2 "marknadsföra" "marknadsförde" "marknadsfört" ; -- SaldoWN
lin market_V = mkV "marknadsföra" "marknadsförde" "marknadsfört" | mkV "handlar" ; -- SaldoWN -- comment=6
lin care_V = mkV "bryr" ;
lin god_N = mkN "gud" ; -- SaldoWN
lin favour_N = mkN "tjänst" "tjänster" | mkN "ynnest" ; -- SaldoWN = mkN "tjänst" "tjänster" ; -- comment=15
lin before_Adv = mkAdv "innan" ; -- comment=9
lin name_V3 = mkV3 (mkV "utnämna"); -- status=guess, src=wikt
lin name_V2V = mkV2V (mkV "utnämna"); -- status=guess, src=wikt
lin name_V2 = mkV2 (mkV "utnämna"); -- status=guess, src=wikt
lin equal_A = mkA "lika" ; -- comment=6
lin capacity_N = mkN "kapacitet" "kapaciteter" | mkN "förmåga" ;
lin flat_N = mkN "punktering" | mkN "ren" "renen" "renar" "renarna" ; -- SaldoWN -- comment=17
lin selection_N = mkN "utdrag" neutrum | mkN "val" ; -- SaldoWN -- comment=6
lin alone_Adv = mkAdv "ensamt" ;
lin football_N = mkN "fotboll" ;
lin victory_N = mkN "seger" ;
lin factory_N = L.factory_N ;
lin rural_A = mkA "lantlig" ; -- SaldoWN
lin twice_Adv = mkAdv "två gånger" ;
lin sing_V2 = mkV2 "sjunga" "sjöng" "sjungit" | mkV2 (mkV "sjunga" "sjöng" "sjungit") ; -- SaldoWN
lin sing_V = L.sing_V ;
lin whereas_Subj = variants{} ;
lin own_V2 = mkV2 "äger" ; --
lin own_V = mkV "äger" ; -- comment=4
lin head_V2 = mkV2 (mkV "åka"); -- status=guess, src=wikt
lin head_V = mkV "falla" "föll" "fallit" ; -- comment=14
lin examination_N = mkN "prov" neutrum | mkN "tentamen" "tentamen" "tentamina" "tentamina" ; -- SaldoWN = mkN "prov" neutrum ; -- comment=13
lin deliver_V2 = mkV2 "undsätta" "undsätter" "undsätt" "undsatte" "undsatt" "undsatt" | dirV2 (partV (mkV "riktar")"till") ; -- SaldoWN -- comment=2
lin deliver_V = mkV "undsätta" "undsätter" "undsätt" "undsatte" "undsatt" "undsatt" | mkV "räddar" ; -- SaldoWN -- comment=13
lin nobody_NP = S.nobody_NP;
lin substantial_A = mkA "fullgod" ; -- comment=31
lin invite_V2V = variants {} ;
lin invite_V2 = variants {} ;
lin intention_N = mkN "avsikt" "avsikter" ; -- SaldoWN
lin egg_N = L.egg_N ;
lin reasonable_A = mkA "rimlig" | mkA "överkomlig" ; -- SaldoWN -- comment=10
lin onto_Prep = mkPrep "på" ;
lin retain_V2V = mkV2V (mkV "få") | mkV2V (mkV "bevarar"); -- status=guess, src=wikt status=guess, src=wikt
lin retain_V2 = mkV2 (mkV "få") | mkV2 (mkV "bevarar"); -- status=guess, src=wikt status=guess, src=wikt
lin aircraft_N = mkN "flygplan" neutrum ;
lin decade_N = mkN "årtionde" | mkN "decennium" "decenniet" "decennier" "decennierna" ; -- SaldoWN -- comment=3
lin cheap_A = mkA "billig" ; -- SaldoWN
lin quiet_A = mkA "tyst" "tyst" ; -- SaldoWN
lin bright_A = mkA "lycklig" ; -- comment=15
lin contribute_V2V = mkV2V (mkV "bidra" "bidrar" "bidra" "bidrog" "bidragit" "bidragen") | mkV2V (mkV "bidraga"); -- status=guess, src=wikt status=guess, src=wikt
lin contribute_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=3
lin contribute_V = mkV "bidra" "bidrar" "bidra" "bidrog" "bidragit" "bidragen" ; -- comment=4
lin row_N = mkN "ro" | mkN "väsen" neutrum ; -- SaldoWN = mkN "ro" neutrum ; = mkN "ro" "ron" "ron" "rona" ; -- comment=24
lin search_N = mkN "undersökning" | mkN "sök" neutrum ; -- SaldoWN
lin limit_N = mkN "måtta" | mkN "gräns" "gränser" ; -- SaldoWN -- comment=5
lin definition_N = mkN "definition" "definitioner" | mkN "skärpa" ; -- SaldoWN -- comment=9
lin unemployment_N = mkN "arbetslöshet" "arbetslösheter" ; -- SaldoWN
lin spread_VS = mkVS (mkV (mkV "sprida") "sig som en präriebrand"); -- status=guess, src=wikt
lin spread_V2V = mkV2V (mkV (mkV "sprida") "sig som en präriebrand"); -- status=guess, src=wikt
lin spread_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut"); -- comment=4
lin spread_V = mkV "sprida" "spred" "spritt" ; -- comment=6
lin mark_N = mkN "ärr" neutrum | mkN "betyg" neutrum ; -- SaldoWN -- comment=22
lin flight_N = mkN "flyg" "flyg" ;
lin account_V2 = mkV2 (mkV "beräkna"); -- status=guess, src=wikt
lin account_V = mkV "nyttar" ; -- comment=5
lin output_N = mkN "resultat" neutrum | mkN "produktion" "produktioner" ; -- SaldoWN -- comment=8
lin last_V2 = mkV2 "bestå" "bestod" "bestått" ;
lin last_V = mkV "bestå" "bestod" "bestått" | mkV "hålla" "höll" "hållit" ;
lin tour_N = mkN "turné" "turnéer" ;
lin address_N = mkN "adress" "adresser" ; -- SaldoWN
lin immediate_A = mkA "omedelbar" ; -- comment=6
lin reduction_N = mkN "minskning" | mkN "reduktion" "reduktioner" ; -- SaldoWN -- comment=15
lin interview_N = mkN "intervju" "intervjun" "intervjuer" "intervjuerna" ;
lin assess_V2 = variants {} ;
lin promote_V2 = mkV2 (mkV "befordrar"); -- status=guess, src=wikt
lin promote_V = mkV "lanserar" ; -- comment=8
lin everybody_NP = S.everybody_NP;
lin suitable_A = mkA "passande" ; -- comment=4
lin growing_A = variants{} ;
lin nod_V2 = variants {} ;
lin nod_V = mkV "nickar" ; -- comment=2
lin reject_V2 = mkV2 (mkV "avslå") | mkV2 (mkV "avvisar"); -- status=guess, src=wikt status=guess, src=wikt
lin while_N = mkN "stund" "stunder" ; -- comment=2
lin high_Adv = variants {} ;
lin dream_N = mkN "dröm" "drömmen" "drömmar" "drömmarna" ; -- SaldoWN
lin vote_VV = mkVV (mkV "rösta"); -- status=guess, src=wikt
lin vote_V3 = mkV3 (mkV "rösta");
lin vote_V2 = dirV2 (partV (mkV "röstar")"ut"); -- comment=2
lin vote_V = mkV "röstar" ; -- comment=2
lin divide_V2 = dirV2 (partV (mkV "delar")"ut"); -- comment=6
lin divide_V = mkV "delar" ; -- comment=17
lin declare_VS = mkVS (mkV "deklarerar"); -- status=guess, src=wikt
lin declare_V2V = mkV2V (mkV "deklarerar"); -- status=guess, src=wikt
lin declare_V2 = mkV2 (mkV "deklarerar"); -- status=guess, src=wikt
lin declare_V = mkV "förklarar" ; -- comment=9
lin handle_V2 = mkV2 (mkV (mkV "handskas") "med"); -- status=guess, src=wikt
lin handle_V = mkV "handla" ;
lin detailed_A = variants{} ;
lin challenge_N = mkN "utmaning" ; -- SaldoWN
lin notice_N = mkN "varsel" neutrum | mkN "uppsägning" ; -- SaldoWN -- comment=12
lin rain_N = L.rain_N ;
lin destroy_V2 = mkV2 (mkV "förstöra"); -- status=guess, src=wikt
lin mountain_N = L.mountain_N ;
lin concentration_N = mkN "koncentration" "koncentrationer" ; -- SaldoWN
lin limited_A = mkA "begränsad" ;
lin finance_N = variants {} ;
lin pension_N = mkN "pension" "pensioner" | mkN "pensionat" neutrum ; -- SaldoWN -- comment=2
lin influence_V2 = mkV2 (mkV "påverka"); -- status=guess, src=wikt
lin afraid_A = mkA "rädd" ; -- SaldoWN
lin murder_N = mkN "mord" neutrum ;
lin neck_N = L.neck_N ;
lin weapon_N = mkN "vapen" "vapnet" "vapen" "vapnen" ; -- SaldoWN
lin hide_V2 = mkV2 "dölja" "dolde" "dolt" | mkV2 (mkV (mkV "gömma") "sig") ; -- SaldoWN -- status=guess, src=wikt
lin hide_V = mkV "dölja" "dolde" "dolt" | mkV "gömmer" ; -- SaldoWN -- comment=4
lin offence_N = mkN "offensiv" "offensiver" | mkN "förseelse" "förseelser" ; -- SaldoWN -- comment=9
lin absence_N = mkN "frånvaro" ; -- SaldoWN
lin error_N = mkN "missuppfattning" | mkN "fel" neutrum ; -- SaldoWN -- comment=3
lin representative_N = variants{} ;
lin enterprise_N = mkN "företag" "företag" ;
lin criticism_N = mkN "kritik" "kritiker" ; -- SaldoWN
lin average_A = mkA "genomsnittlig" ;
lin quick_A = mkA "snabb" ; --"kvick" ; -- comment=12
lin sufficient_A = mkA "tillräcklig" ; -- SaldoWN
lin appointment_N = mkN "förordnande" | mkN "utnämning" ; -- SaldoWN -- comment=2
lin match_V2 = mkV2 (mkV "matchar") | mkV2 (mkV (mkV "vara") "lika") | mkV2 (mkV (mkV "passa") "ihop"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin match_V = mkV "matchar" ; -- comment=2
lin transfer_V2 = mkV2 "överföra" "överförde" "överfört" | mkV2 (mkV "överföra") ; -- SaldoWN -- status=guess, src=wikt
lin transfer_V = mkV "överföra" "överförde" "överfört" | mkV "överlåta" "överlät" "överlåtit" ; -- SaldoWN -- comment=4
lin acid_N = mkN "syra" ; -- SaldoWN
lin spring_N = mkN "vår" ; -- SaldoWN
lin birth_N = mkN "födsel" ;
lin ear_N = L.ear_N ;
lin recognize_VS = mkVS (mkV "erkänna"); -- status=guess, src=wikt
lin recognize_4_V2 = variants {} ;
lin recognize_1_V2 = variants {} ;
lin recommend_V2V = mkV2V (mkV "rekommenderar"); -- status=guess, src=wikt
lin recommend_V2 = mkV2 (mkV "rekommenderar"); -- status=guess, src=wikt
lin module_N = mkN "modul" "moduler" ; -- SaldoWN
lin instruction_N = mkN "undervisning" ; -- SaldoWN
lin democratic_A = mkA "demokratisk" ; -- SaldoWN
lin park_N = mkN "park" "parker" | mkN "plan" "planer" ;
lin weather_N = mkN "väder" neutrum | mkN "väder" neutrum ; -- SaldoWN
lin bottle_N = mkN "flaska" ; -- SaldoWN
lin address_V2 = dirV2 (partV (mkV "riktar")"till"); -- comment=2
lin bedroom_N = mkN "sovrum" "sovrummet" "sovrum" "sovrummen" | mkN "sängkammare" "sängkammaren" "sängkamrar" "sängkamrarna" ; -- SaldoWN -- comment=2
lin kid_N = mkN "killing" ; -- SaldoWN
lin pleasure_N = mkN "nöje" | mkN "gottfinnande" ; -- SaldoWN -- comment=9
lin realize_VS = mkVS (mkV "inse" "insåg" "insett"); -- status=guess, src=wikt
lin realize_V2 = mkV2 (mkV "inse" "insåg" "insett"); -- status=guess, src=wikt
lin assembly_N = mkN "tillverkning" | mkN "sammanträde" ; -- SaldoWN -- comment=10
lin expensive_A = mkA "dyr" | mkA "dyrbar" ; -- SaldoWN -- comment=5
lin select_VV = mkVV (mkV "välja") | mkVV (mkV (mkV "välja") "ut") | mkVV (mkV "utvälja"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin select_V2V = mkV2V (mkV "välja") | mkV2V (mkV (mkV "välja") "ut") | mkV2V (mkV "utvälja"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin select_V2 = mkV2 (mkV "välja") | mkV2 (mkV (mkV "välja") "ut") | mkV2 (mkV "utvälja"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin select_V = mkV "utvälja" "utvalde" "utvalt" ;
lin teaching_N = mkN "undervisning" ;
lin desire_N = mkN "begär" neutrum | mkN "önskning" ; -- SaldoWN -- comment=5
lin whilst_Subj = variants {} ;
lin contact_V2 = mkV2 (mkV "kontaktar"); -- status=guess, src=wikt
lin implication_N = mkN "implikation" "implikationer" | mkN "innebörd" "innebörder" ; -- SaldoWN -- comment=8
lin combine_VV = variants {} ;
lin combine_V2V = variants {} ;
lin combine_V2 = variants {} ;
lin combine_V = mkV "kombinerar" ; -- comment=2
lin temperature_N = mkN "temperatur" "temperaturer" ; -- SaldoWN
lin wave_N = mkN "våg" "vågor" | mkN "våg" ; -- SaldoWN = mkN "våg" ; -- comment=6
lin magazine_N = mkN "magasin" neutrum ;
lin totally_Adv = variants{} ;
lin mental_A = mkA "psykisk" | mkA "själslig" ; -- SaldoWN -- comment=3
lin used_A = variants{} ;
lin store_N = mkN "lager" "lager" ;
lin scientific_A = mkA "vetenskaplig" ;
lin frequently_Adv = mkAdv "ofta" ;
lin thanks_N = variants{} ;
lin beside_Prep = variants {} ;
lin settlement_N = mkN "förlikning" | mkN "settlement" neutrum ; -- SaldoWN -- comment=23
lin absolutely_Adv = variants{} ;
lin critical_A = mkA "kritisk" | mkA "livsviktig" ; -- SaldoWN -- comment=5
lin critical_2_A = mkA "livsviktig" ;
lin critical_1_A = mkA "kritisk" ;
lin recognition_N = mkN "erkännande" ; -- SaldoWN
lin touch_N = mkN "röra" | mkN "stämpel" ; -- SaldoWN = mkN "röra" ; -- comment=32
lin consist_V = (mkV "varar") | mkV (mkV "bestå") "av" | mkV "bestå" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin below_Prep = mkPrep "nedanför" ; --
lin silence_N = mkN "tystnad" "tystnader" ; -- SaldoWN
lin expenditure_N = mkN "utlägg" neutrum | mkN "utgift" "utgifter" ; -- SaldoWN -- comment=3
lin institute_N = mkN "institut" neutrum;
lin dress_V2 = dirV2 (partV (mkV "rensar")"ut"); -- comment=11
lin dress_V = mkV "tillreda" "tillredde" "tillrett" ; -- comment=24
lin dangerous_A = mkA "farlig" ; -- SaldoWN
lin familiar_A = mkA "familjär" | mkA "otvungen" "otvunget" ; -- SaldoWN -- comment=13
lin asset_N = mkN "tillgång" ; -- SaldoWN
lin belong_V = mkV "tillhöra" "tillhörde" "tillhört" ; -- SaldoWN
lin educational_A = mkA "pedagogisk" ; -- SaldoWN
lin sum_N = mkN "summa" ; -- SaldoWN
lin publication_N = mkN "publikation" "publikationer" ; -- SaldoWN
lin partly_Adv = mkAdv "delvis" ; -- comment=3
lin block_N = mkN "kvarter" "kvarteret" "kvarter" "kvarteren" | mkN "stötta" ; -- SaldoWN -- comment=31
lin seriously_Adv = variants{} ;
lin youth_N = mkN "ungdom" | mkN "yngling" ; -- SaldoWN -- comment=3
lin tape_N = mkN "tejp" ; -- SaldoWN
lin elsewhere_Adv = mkAdv "annorstädes" ; -- comment=2
lin cover_N = mkN "täcke" | mkN "täckning" ; -- SaldoWN -- comment=17
lin fee_N = mkN "avgift" "avgifter" ; -- SaldoWN
lin program_N = mkN "program" "programmet" "program" "programmen" ;
lin treaty_N = mkN "fördrag" neutrum | mkN "fördrag" neutrum ; -- SaldoWN -- comment=5
lin necessarily_Adv = variants{} ;
lin unlikely_A = mkA "osannolik" ; -- SaldoWN
lin properly_Adv = variants{} ;
lin guest_N = mkN "gäst" "gäster" ; -- SaldoWN
lin code_N = mkN "kod" "koder" ;
lin hill_N = L.hill_N ;
lin screen_N = mkN "såll" neutrum | mkN "visa" ; -- SaldoWN -- comment=20
lin household_N = mkN "hushåll" neutrum ;
lin sequence_N = mkN "följd" "följder" | mkN "serie" "serier" ; -- SaldoWN -- comment=9
lin correct_A = L.correct_A;
lin female_A = mkA "kvinnlig" ;
lin phase_N = mkN "fas" "faser" ; -- comment=4
lin crowd_N = mkN "hop" | mkN "åskådare" utrum ; -- SaldoWN -- comment=15
lin welcome_V2 = mkV2 (mkV "välkomna"); -- status=guess, src=wikt
lin metal_N = mkN "metall" "metaller" ;
lin human_N = mkN "människa" ; -- status=guess
lin widely_Adv = mkAdv "allmänt" ;
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
lin closely_Adv = variants{} ;
lin thin_A = L.thin_A ;
lin solicitor_N = variants{} ;
lin secure_V2 = mkV2 "fästa" "fäster" "fäst" "fäste" "fäst" "fäst" | dirV2 (partV (mkV "låser")"in") ; -- SaldoWN
lin plate_N = mkN "tallrik" ; -- SaldoWN
lin pool_N = mkN "pöl" | mkN "pool" "pooler" ; -- SaldoWN -- comment=11
lin gold_N = L.gold_N ;
lin emphasis_N = mkN "emfas" | mkN "betoning" ; -- SaldoWN -- comment=5
lin recall_VS = mkVS (mkV "återkalla"); -- status=guess, src=wikt
lin recall_V2 = mkV2 (mkV "återkalla"); -- status=guess, src=wikt
lin shout_V2 = dirV2 (partV (mkV "ropar")"till");
lin shout_V = mkV "ropar" ; -- comment=4
lin generate_V2 = mkV2 (mkV "skapar"); -- status=guess, src=wikt
lin location_N = mkN "belägenhet" "belägenheter" | mkN "plats" "platser" ;
lin display_VS = variants {} ;
lin display_V2 = variants {} ;
lin heat_N = mkN "värme" | mkN "värma" ; -- SaldoWN = mkN "värme" utrum ; -- comment=18
lin gun_N = mkN "vapen" "vapnet" "vapen" "vapnen" ;
lin shut_V2 = mkV2 (mkV "stänga"); -- status=guess, src=wikt
lin shut_V = mkV "stänger" ; -- comment=4
lin journey_N = mkN "resa" ; -- comment=2
lin imply_VS = mkVS (mkV "antyda" "antydde" "antytt") | mkVS (mkV "insinuerar"); -- status=guess, src=wikt status=guess, src=wikt
lin imply_V2 = mkV2 (mkV "antyda" "antydde" "antytt") | mkV2 (mkV "insinuerar"); -- status=guess, src=wikt status=guess, src=wikt
lin imply_V = mkV "betyda" "betydde" "betytt" ; -- comment=6
lin violence_N = mkN "våldsamhet" "våldsamheter" ; -- comment=4
lin dry_A = L.dry_A ;
lin historical_A = mkA "historisk" ;
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
lin fall_2_N = mkN "höst" ;
lin fall_1_N = mkN "fall" "fall" ;
lin bottom_N = mkN "handelsfartyg" neutrum | mkN "sänka" ; -- SaldoWN -- comment=15
lin initial_A = mkA "initial" ;
lin theme_N = mkN "tema" "temat" "teman" "temana" ;
lin characteristic_N = mkN "särdrag" neutrum | mkN "kännetecken" "kännetecknet" "kännetecken" "kännetecknen" ; -- SaldoWN -- comment=10
lin pretty_Adv = variants{} ;
lin empty_A = L.empty_A ;
lin display_N = mkN "uppvisning" | mkN "utställning" ; -- SaldoWN -- comment=8
lin combination_N = mkN "kombination" "kombinationer" | mkN "sammanställning" ; -- SaldoWN -- comment=6
lin interpretation_N = mkN "tolkning" ; -- comment=3
lin rely_V2 = mkV2 "lita" (mkPrep "på") ;
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
lin organize_V2 = dirV2 (partV (mkV "ordnar")"om");
lin cat_N = L.cat_N ;
lin tool_N = mkN "verktyg" neutrum | mkN "verktyg" neutrum ; -- SaldoWN -- comment=6
lin spot_N = mkN "fläck" | mkN "slurk" ; -- SaldoWN -- comment=3
lin bridge_N = mkN "bro" ;
lin double_A = mkA "dubbel" ; -- SaldoWN
lin direct_VS = mkVS (mkV "riktar"); -- status=guess, src=wikt
lin direct_V2 = dirV2 (partV (mkV "visar")"in"); -- comment=9
lin direct_V = mkV "visar" ; -- comment=22
lin conclude_VS = mkVS (mkV "konkludera");
lin conclude_V2 = variants {} ;
lin conclude_V = mkV "konkluderar" ; -- comment=9
lin relative_A = mkA "relativ" ; -- SaldoWN
lin soldier_N = mkN "soldat" "soldater" ; -- SaldoWN
lin climb_V2 = mkV2 (mkV "klättra"); -- status=guess, src=wikt
lin climb_V = mkV "stiga" "steg" "stigit" ; -- comment=6
lin breath_N = mkN "suck" ; -- comment=9
lin afford_V2V = variants {} ;
lin afford_V2 = variants {} ;
lin urban_A = mkA "urban" | mkA "stadsmässig" ;
lin nurse_N = mkN "sjuksköterska" ; -- SaldoWN
lin narrow_A = L.narrow_A ;
lin liberal_A = mkA "vidsynt" "vidsynt" ; -- comment=8
lin coal_N = mkN "kol" neutrum ; -- SaldoWN -- comment=4
lin priority_N = mkN "prioritet" "prioriteter" ; -- SaldoWN
lin wild_A = mkA "vild" "vilt" ; -- SaldoWN
lin revenue_N = mkN "intäkt" "intäkter" ;
lin membership_N = mkN "medlemskap" neutrum | mkN "medlemskap" neutrum ; -- SaldoWN -- comment=3
lin grant_N = mkN "anslag" neutrum | mkN "stipendium" "stipendiet" "stipendier" "stipendierna" ; -- SaldoWN -- comment=8
lin approve_V2 = mkV2 "godkänna" "godkände" "godkänt" | mkV2 "godkänner" ; -- SaldoWN --
lin approve_V = mkV "godkänna" "godkände" "godkänt" | mkV "tillstyrker" ; -- SaldoWN -- comment=8
lin tall_A = mkA "lång" "längre" "längst" ; -- SaldoWN
lin apparent_A = mkA "skenbar" ; -- comment=4
lin faith_N = mkN "tro" | mkN "trohet" "troheter" ; -- SaldoWN -- comment=9
lin under_Adv = mkAdv "under" ;
lin fix_V2 = dirV2 (partV (mkV "riktar")"till"); -- comment=4
lin fix_V = mkV "arrangerar" ; -- comment=28
lin slow_A = mkA "långsam" "långsamt" "långsamma" "långsamma" "långsammare" "långsammast" "långsammaste" | mkA "sen" ; -- SaldoWN -- comment=14
lin troop_N = mkN "trupp" "trupper" ; -- SaldoWN
lin motion_N = mkN "rörelse" "rörelser" ; -- comment=9
lin leading_A = variants{} ;
lin component_N = mkN "komponent" "komponenter" ; -- comment=6
lin bloody_A = mkA "blodig" ; -- SaldoWN
lin literature_N = mkN "litteratur" "litteraturer" ;
lin conservative_A = mkA "konservativ" ; -- SaldoWN
lin variation_N = mkN "variation" "variationer" ; -- SaldoWN
lin remind_V2 = mkV2 "påminna" "påminde" "påmint" | mkV2 (mkV "påminna") ; -- SaldoWN -- status=guess, src=wikt
lin inform_V2 = variants {} ;
lin inform_V = mkV "upplyser" ; -- comment=11
lin alternative_N = mkN "alternativ" neutrum ; -- SaldoWN -- comment=2
lin neither_Adv = mkAdv "varken" ; -- comment=2
lin outside_Adv = mkAdv "utomhus" ; -- comment=5
lin mass_N = mkN "massa" | mkN "mässa" ; -- SaldoWN = mkN "massa" ; -- comment=5
lin busy_A = mkA "upptagen" "upptaget" ; -- SaldoWN
lin chemical_N = mkN "kemikalie" "kemikalier" ;
lin careful_A = mkA "försiktig" | mkA "grundlig" | mkA "noga" ; -- SaldoWN -- comment=10
lin investigate_V2 = variants {} ;
lin investigate_V = mkV "undersöker" ; -- comment=3
lin roll_V2 = mkV2 "omsätta" "omsätter" "omsätt" "omsatte" "omsatt" "omsatt" | dirV2 (partV (mkV "rullar")"ut") ; -- SaldoWN -- comment=4
lin roll_V = mkV "omsätta" "omsätter" "omsätt" "omsatte" "omsatt" "omsatt" | mkV "vinglar" ; -- SaldoWN -- comment=10
lin instrument_N = mkN "instrument" neutrum | mkN "verktyg" neutrum ; -- SaldoWN -- comment=5
lin guide_N = mkN "guide" "guider" | mkN "vägvisare" utrum ; -- SaldoWN -- comment=6
lin criterion_N = mkN "kriterium" "kriteriet" "kriterier" "kriterierna" ; -- comment=3
lin pocket_N = mkN "ficka" | mkN "grupp" "grupper" ; -- SaldoWN -- comment=6
lin suggestion_N = mkN "förslag" neutrum | mkN "uppslag" neutrum ; -- SaldoWN = mkN "förslag" neutrum ; -- comment=19
lin aye_Interj = variants{} ;
lin entitle_VS = variants {} ;
lin entitle_V2V = variants {} ;
lin entitle_V2 = mkV2 "berättiga" ;
lin tone_N = mkN "röstläge" | mkN "ton" "tonnet" "ton" "tonnen" ; -- SaldoWN -- comment=4
lin attractive_A = mkA "tilldragande" | mkA "attraktiv" ; -- SaldoWN -- comment=7
lin wing_N = L.wing_N ;
lin surprise_N = mkN "överraskning" ; -- SaldoWN
lin male_N = mkN "mansperson" "manspersoner" ; -- comment=4
lin ring_N = mkN "ring" neutrum | mkN "slå" ; -- SaldoWN = mkN "ring" ; -- comment=16
lin pub_N = mkN "pub" ; -- SaldoWN
lin fruit_N = L.fruit_N ;
lin passage_N = mkN "passus" | mkN "öppning" ; -- SaldoWN -- comment=10
lin illustrate_VS = variants {} ;
lin illustrate_V2 = variants {} ;
lin illustrate_V = mkV "illustrerar" ; -- comment=4
lin pay_N = mkN "visa" ; -- comment=7
lin ride_V2 = mkV2 (mkV "åka"); -- status=guess, src=wikt
lin ride_V = mkV "rida" "red" "ridit" ;
lin foundation_N = mkN "stiftelse" "stiftelser" ; -- SaldoWN
lin restaurant_N = L.restaurant_N ;
lin vital_A = mkA "vital" ; -- comment=4
lin alternative_A = mkA "alternativ" ; -- SaldoWN
lin burn_V2 = mkV2 "brinna" "brann" "brunnit" ;
lin burn_V = L.burn_V ;
lin map_N = mkN "karta" ; -- SaldoWN
lin united_A = variants{} ;
lin device_N = mkN "apparat" "apparater" ;
lin jump_VV = mkVV (mkV "hoppar"); -- status=guess, src=wikt
lin jump_V2V = mkV2V (mkV "hoppar"); -- status=guess, src=wikt
lin jump_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin jump_V = L.jump_V;
lin estimate_VS = variants {} ;
lin estimate_V2V = variants {} ;
lin estimate_V2 = dirV2 (partV (mkV "dömer")"ut");
lin estimate_V = mkV "kalkylerar" ; -- comment=11
lin conduct_V2 = mkV2 (mkV "ledar"); -- status=guess, src=wikt
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
lin satisfy_V2 = mkV2 (mkV "tillfredsställa"); -- status=guess, src=wikt
lin satisfy_V = mkV "uppfyller" ; -- comment=6
lin hell_N = mkN "helvete" ; -- SaldoWN
lin winner_N = mkN "vinnare" utrum | mkN "segrare" utrum ;
lin effectively_Adv = variants{} ;
lin mistake_N = mkN "misstag" neutrum; -- comment=6
lin incident_N = mkN "händelse" "händelser" | mkN "olyckshändelse" "olyckshändelser" ; -- SaldoWN -- comment=7
lin focus_V2 = mkV2 (mkV "fokuserar") | mkV2 (mkV (mkV "koncentrera") "sig"); -- status=guess, src=wikt status=guess, src=wikt
lin focus_V = mkV "fokuserar" ; -- comment=4
lin exercise_VV = mkVV (mkV "öva") | mkVV (mkV "träna") | mkVV (mkV "praktiserar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exercise_V2 = mkV2 (mkV "öva") | mkV2 (mkV "träna") | mkV2 (mkV "praktiserar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exercise_V = mkV "utövar" ; -- comment=5
lin representation_N = mkN "föreställning" ; -- comment=10
lin release_N = mkN "överlåtelse" "överlåtelser" | mkN "utsläpp" neutrum ;
lin leaf_N = L.leaf_N ;
lin border_N = mkN "gräns" "gränser" | mkN "kant" "kanter" ;
lin wash_V2 = L.wash_V2;
lin wash_V = mkV "tvättar" ; -- comment=6
lin prospect_N = mkN "utsikt" "utsikter" | mkN "möjlighet" "möjligheter" ; -- SaldoWN -- comment=6
lin blow_V2 = dirV2 (partV (mkV "blåser")"av"); -- comment=6
lin blow_V = L.blow_V;
lin trip_N = mkN "tripp" neutrum; -- comment=11
lin observation_N = mkN "iakttagelse" "iakttagelser" | mkN "yttrande" ; -- SaldoWN -- comment=9
lin gather_V2 = dirV2 (partV (mkV "plockar")"ut"); -- comment=4
lin gather_V = mkV "utläser" ; -- comment=12
lin ancient_A = mkA "uråldrig" ;
lin brief_A = mkA "kort" "kort" ; -- comment=4
lin gate_N = mkN "grind" | mkN "port" ; -- SaldoWN -- comment=6
lin elderly_A = mkA "gammal" "gammalt" "gamla" "äldre" "äldst" ;
lin persuade_V2V = mkV2V (mkV "övertyga"); -- status=guess, src=wikt
lin persuade_V2 = mkV2 (mkV "övertyga"); -- status=guess, src=wikt
lin overall_A = mkA "övergripande" ;
lin rare_A = mkA "sällsynt" "sällsynt" | mkA "tunn" "tunt" ; -- SaldoWN -- comment=6
lin index_N = mkN "pekfinger" | mkN "register" neutrum ; -- SaldoWN -- comment=3
lin hand_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=3
lin circle_N = mkN "cirkel" | mkN "kretsgång" ; -- SaldoWN -- comment=10
lin creation_N = mkN "skapande" | mkN "utnämning" ;
lin drawing_N = mkN "teckning" ; -- SaldoWN
lin anybody_NP = S.mkNP (mkPN "någon" utrum) ;
lin flow_N = mkN "stigande" ; -- comment=8
lin matter_V = mkV "innehålla" "innehöll" "innehållit" ; -- comment=4
lin external_A = mkA "extern" | mkA "utvärtes" ;
lin capable_A = mkA "duglig" | mkA "kapabel" ; -- SaldoWN -- comment=4
lin recover_V2V = variants {} ;
lin recover_V2 = variants {} ;
lin recover_V = mkV "återvinna" "återvann" "återvunnit" ; -- comment=5
lin shot_N = mkN "skott" neutrum | mkN "skytt" ; -- SaldoWN -- comment=4
lin request_N = mkN "anhållan" "anhållan" "anhållanden" "anhållandena" ; -- comment=5
lin impression_N = mkN "tryckning" ; -- comment=10
lin neighbour_N = mkN "granne" utrum | mkN "grannland" "grannlandet" "grannländer" "grannländerna" ; -- SaldoWN -- comment=4
lin theatre_N = mkN "teater" ; -- SaldoWN
lin beneath_Prep = variants {} ;
lin hurt_VS = mkVS (mkV (mkV "göra") "ont"); -- status=guess, src=wikt
lin hurt_V2 = mkV2 (mkV (mkV "göra") "ont"); -- status=guess, src=wikt
lin hurt_V = mkV "sårar" ; -- comment=3
lin mechanism_N = mkN "mekanism" "mekanismer" ; -- SaldoWN
lin potential_N = mkN "potential" "potentialer" ; -- SaldoWN
lin lean_V2 = dirV2 (partV (mkV "lutar")"av");
lin lean_V = mkV "lutar" ; -- comment=3
lin defendant_N = mkN "svarande" ; -- SaldoWN = mkN "svarande" "svaranden" "svarande" "svarandena" ;
lin atmosphere_N = mkN "stämning" | mkN "luft" "lufter" ; -- SaldoWN -- comment=6
lin slip_V2 = mkV2 (mkV "halkar"); -- status=guess, src=wikt
lin slip_V = mkV "undgå" "undgick" "undgått" ; -- comment=12
lin chain_N = mkN "kedja" ; -- SaldoWN
lin accompany_V2 = mkV2 "åtfölja" "åtföljde" "åtföljt" | mkV2 (mkV (mkV "göra") "sällskap med") | mkV2 (mkV (mkV "slå") "följe med") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin wonderful_A = mkA "underbar" ; -- comment=4
lin earn_VA = variants {} ;
lin earn_V2 = dirV2 (partV (mkV "tjänar")"ut"); -- comment=2
lin earn_V = mkV "förtjänar" ; -- comment=5
lin enemy_N = L.enemy_N ;
lin desk_N = mkN "skolbänk" ; -- SaldoWN
lin engineering_N = variants {} ;
lin panel_N = mkN "panel" "paneler" ; -- SaldoWN
lin distinction_N = mkN "åtskillnad" "åtskillnader" ; -- comment=7
lin deputy_N = mkN "ställföreträdare" utrum ; -- SaldoWN -- comment=6
lin discipline_N = mkN "bestraffning" | mkN "övning" ; -- SaldoWN -- comment=12
lin strike_N = variants{} ;
lin strike_2_N = mkN "sticka" ;
lin strike_1_N = mkN "sticka" ;
lin married_A = mkA "gift" "gift" ;
lin plenty_NP = variants{} ;
lin establishment_N = mkN "upprättande" ; -- comment=26
lin fashion_N = mkN "mode" | mkN "sätt" neutrum ; -- SaldoWN -- comment=7
lin roof_N = L.roof_N ;
lin milk_N = L.milk_N ;
lin entire_A = mkA "hel" ;
lin tear_N = mkN "tår" ; -- SaldoWN
lin secondary_A = mkA "sekundär" ; -- SaldoWN
lin finding_N = variants {} ;
lin welfare_N = mkN "välstånd" neutrum | mkN "välfärd" ; -- SaldoWN -- comment=6
lin increased_A = variants{} ;
lin attach_V2 = mkV2 (mkV "fästa") | mkV2 (mkV (mkV "sätta") "fast") | mkV2 (mkV "bifogar") | mkV2 (mkV "vidfogar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin attach_V = mkV "fästa" "fäster" "fäst" "fäste" "fäst" "fäst" ; -- comment=5
lin typical_A = variants{} ;
lin typical_3_A = mkA "typisk" ; -- comment=2
lin typical_2_A = mkA "typisk" ; -- comment=2
lin typical_1_A = mkA "typisk" ; -- comment=2
lin meanwhile_Adv = mkAdv "samtidigt" ; --
lin leadership_N = mkN "ledarskap" neutrum | mkN "ledning" ; -- SaldoWN -- comment=2
lin walk_N = mkN "promenad" "promenader" ;
lin negotiation_N = mkN "förhandling" ; -- SaldoWN
lin clean_A = L.clean_A ;
lin religion_N = L.religion_N;
lin count_V2 = L.count_V2;
lin count_V = mkV "skattar" ; -- comment=7
lin grey_A = mkA "livlös" ; -- comment=5
lin hence_Adv = mkAdv "därför" ;
lin alright_Adv = variants {} ;
lin first_A = variants{} ;
lin fuel_N = mkN "bränsle" ; -- SaldoWN
lin mine_N = mkN "mina" | mkN "min" "miner" ; -- SaldoWN -- comment=6
lin appeal_V2V = mkV2V (mkV "överklaga"); -- status=guess, src=wikt
lin appeal_V2 = dirV2 (partV (mkV "lockar")"in");
lin appeal_V = mkV "överklagar" ; -- comment=7
lin servant_N = variants{} ;
lin liability_N = mkN "ansvar" neutrum | mkN "mottaglighet" ; -- SaldoWN -- comment=12
lin constant_A = mkA "ständig" ; -- SaldoWN
lin hate_VV = mkVV (mkV "hatar"); -- status=guess, src=wikt
lin hate_V2V = mkV2V (mkV "hatar"); -- status=guess, src=wikt
lin hate_V2 = L.hate_V2;
lin shoe_N = L.shoe_N ;
lin expense_N = mkN "utgift" "utgifter" ; -- comment=7
lin vast_A = mkA "ofantlig" ; -- comment=3
lin soil_N = mkN "jordmån" | mkN "jord" ; -- SaldoWN -- comment=5
lin writing_N = mkN "skrivande" ; -- comment=7
lin nose_N = L.nose_N ;
lin origin_N = mkN "ursprung" neutrum ;
lin lord_N = mkN "herre" utrum; -- comment=4
lin rest_VA = mkVA (mkV "vilar") | mkVA (mkV (mkV "låta") "vila"); -- status=guess, src=wikt status=guess, src=wikt
lin rest_V2 = dirV2 (partV (mkV "vilar")"ut"); -- comment=2
lin rest_V = mkV "vilar" ; -- comment=4
lin drive_N = mkN "åktur" "åkturer" | mkN "timmerflotte" utrum ; -- SaldoWN -- comment=34
lin ticket_N = mkN "biljett" "biljetter" | mkN "parkeringsbot" "parkeringsböter" ; -- SaldoWN -- comment=12
lin editor_N = mkN "redaktör" "redaktörer" ;
lin switch_V2 = dirV2 (partV (mkV "kopplar")"ur"); -- comment=4
lin switch_V = mkV "kopplar" ; -- comment=3
lin provided_Subj = variants{} ;
lin northern_A = mkA "nordlig" ;
lin significance_N = mkN "betydelse" "betydelser" ; -- comment=5
lin channel_N = mkN "kanal" "kanaler" ;
lin convention_N = mkN "konvention" "konventioner" ; -- SaldoWN
lin damage_V2 = mkV2 (mkV "skadar"); -- status=guess, src=wikt
lin funny_A = mkA "rolig" | mkA "knäpp" ; -- SaldoWN -- comment=6
lin bone_N = L.bone_N ;
lin severe_A = mkA "sträng" ; -- comment=13
lin search_V2 = mkV2 (mkV "leta") | mkV2 (mkV "söker") ;
lin search_V = mkV "söker" | mkV "leta" ; -- comment=4
lin iron_N = L.iron_N ;
lin vision_N = mkN "vision" "visioner" | mkN "syn" ; -- SaldoWN -- comment=10
lin via_Prep = mkPrep "via" ; --
lin somewhat_Adv = mkAdv "lite" ;
lin inside_Adv = mkAdv "inuti" ; -- comment=5
lin trend_N = mkN "trend" "trender" ; -- SaldoWN
lin revolution_N = mkN "rotation" "rotationer" | mkN "varv" neutrum ; -- SaldoWN -- comment=5
lin terrible_A = mkA "hemsk" ; -- comment=9
lin knee_N = L.knee_N ;
lin dress_N = mkN "krydda" ; -- comment=9
lin unfortunately_Adv = variants{} ;
lin steal_V2 = mkV2 (mkV "stjäla"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin steal_V = mkV "stjäla" "stjäl" "stjäl" "stal" "stulit" "stulen" ; -- comment=6
lin criminal_A = mkA "brottslig" ; -- comment=4
lin signal_N = mkN "signal" "signaler" ; -- comment=2
lin notion_N = mkN "begrepp" neutrum | mkN "uppfattning" ; -- SaldoWN -- comment=9
lin comparison_N = mkN "jämförelse" "jämförelser" | mkN "komparering" ; -- SaldoWN -- comment=4
lin academic_A = mkA "akademisk" ; -- SaldoWN
lin outcome_N = mkN "utfall" neutrum; -- comment=2
lin lawyer_N = mkN "advokat" "advokater" ; -- SaldoWN
lin strongly_Adv = variants{} ;
lin surround_V2 = mkV2 (mkV "omge" "omger" "omge" "omgav" "omgett" "omgiven"); -- status=guess, src=wikt
lin explore_VS = variants {} ;
lin explore_V2 = variants {} ;
lin achievement_N = mkN "prestation" "prestationer" | mkN "verkställande" ; -- SaldoWN -- comment=10
lin odd_A = mkA "udda" | mkA "underlig" ; -- SaldoWN -- comment=22
lin expectation_N = mkN "sannolikhet" "sannolikheter" ; -- comment=3
lin corporate_A = mkA "korporativ" ; -- SaldoWN
lin prisoner_N = mkN "fånge" utrum | mkN "fånge" utrum ; -- SaldoWN -- comment=3
lin question_V2 = mkV2 "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" | dirV2 (partV (mkV "frågar")"ut") ; -- SaldoWN
lin rapidly_Adv = variants{} ;
lin deep_Adv = mkAdv "långt" ;
lin southern_A = mkA "södra" ;
lin amongst_Prep = variants {} ;
lin withdraw_V2 = mkV2 (mkV (mkV "ställer") "in");
lin withdraw_V = mkV "utträda" "utträdde" "utträtt" ; -- comment=8
lin afterwards_Adv = mkAdv "därefter" ; -- comment=4
lin paint_V2 = dirV2 (partV (mkV "målar")"om"); -- comment=4
lin paint_V = mkV "sminkar" ; -- comment=9
lin judge_VS = mkVS (mkV "bedöma") | mkVS (mkV "avgöra"); -- status=guess, src=wikt status=guess, src=wikt
lin judge_V2V = mkV2V (mkV "bedöma") | mkV2V (mkV "avgöra"); -- status=guess, src=wikt status=guess, src=wikt
lin judge_V2 = dirV2 (partV (mkV "dömer")"ut");
lin judge_V = mkV "anse" "ansåg" "ansett" ; -- comment=6
lin citizen_N = variants{} ;
lin permanent_A = mkA "permanent" "permanent" ; -- SaldoWN
lin weak_A = mkA "svag" | mkA "klen" ; -- SaldoWN -- comment=15
lin separate_V2 = mkV2 "skilja" "skilde" "skilt" | dirV2 (partV (mkV "skilja")"av") ; -- SaldoWN -- comment=3
lin separate_V = mkV "skilja" "skilde" "skilt" ; -- SaldoWN
lin plastic_N = L.plastic_N ;
lin connect_V2 = dirV2 (partV (mkV "kopplar") "ur"); -- comment=4
lin connect_V = mkV "kopplar" ; -- comment=7
lin fundamental_A = mkA "grund" ; -- comment=2
lin plane_N = mkN "flygplan" neutrum | mkN "yta" ; -- SaldoWN -- comment=8
lin height_N = mkN "höjd" "höjder" | mkN "topp" ;
lin opening_N = mkN "öppning" ; -- comment=8
lin lesson_N = mkN "lektion" "lektioner" | mkN "undervisningstimme" utrum ; -- SaldoWN -- comment=4
lin similarly_Adv = variants{} ;
lin shock_N = mkN "stöt" | mkN "våg" ; -- SaldoWN -- comment=10
lin rail_N = mkN "skena" ; -- comment=5
lin tenant_N = mkN "hyresgäst" "hyresgäster" ; -- SaldoWN
lin owe_V2 = mkV2 (mkV (mkV "vara") "skyldig"); -- status=guess, src=wikt
lin owe_V = mkV (mkV "vara") "skyldig" ; -- status=guess, src=wikt
lin originally_Adv = mkAdv "ursprungligen" ;
lin middle_A = mkA "mellerst" ; -- status=guess
lin somehow_Adv = mkAdv "på något sätt" | mkAdv "på ett eller annat sätt" ; -- status=guess status=guess
lin minor_A = mkA "mindre" "mindre" "mindre" "mindre" "mindre" "minst" "minsta" ;
lin negative_A = mkA "negativ" ; -- SaldoWN
lin knock_V2 = dirV2 (partV (mkV "smälla" "small" "smäll")"av"); -- comment=17
lin knock_V = mkV "smälla" "small" "smäll" ; -- comment=14
lin root_N = L.root_N ;
lin pursue_V2 = dirV2 (partV (mkV "jagar")"ut");
lin pursue_V = mkV "jagar" ; -- comment=9
lin inner_A = mkA "invändig" ;
lin crucial_A = mkA "kritisk" ; -- comment=3
lin occupy_V2 = mkV2 (mkV "ockuperar") | mkV2 (mkV "annekterar"); -- status=guess, src=wikt status=guess, src=wikt
lin occupy_V = mkV "uppta" "upptar" "uppta" "upptog" "upptagit" "upptagen" ; -- comment=10
lin that_AdA = variants{} ;
lin independence_N = mkN "självständighet" "självständigheter" ; -- comment=4
lin column_N = mkN "pelare" utrum | mkN "spalt" "spalter" ; -- SaldoWN -- comment=5
lin proceeding_N = variants {} ;
lin female_N = mkN "kvinna" ; -- comment=3
lin beauty_N = mkN "skönhet" ; -- comment=6
lin perfectly_Adv = variants{} ;
lin struggle_N = mkN "kamp" ; -- SaldoWN = mkN "kamp" "kamper" ;
lin gap_N = mkN "glipa" | mkN "hål" neutrum ; -- SaldoWN -- comment=4
lin house_V2 = variants {} ;
lin database_N = mkN "databas" "databaser" ;
lin stretch_V2 = mkV2 (mkV "sträcka"); -- status=guess, src=wikt
lin stretch_V = mkV "sträcker" ; -- comment=4
lin stress_N = mkN "belastning" | mkN "vikt" "vikter" ; -- SaldoWN -- comment=8
lin passenger_N = mkN "passagerare" utrum | mkN "passagerare" utrum ; -- SaldoWN -- comment=2
lin boundary_N = mkN "avgränsning" ; -- comment=3
lin easy_Adv = variants {} ;
lin view_V2 = dirV2 (partV (mkV "se" "såg" "sett")"ut"); -- comment=4
lin manufacturer_N = mkN "producent" "producenter" | mkN "tillverkare" utrum ; -- SaldoWN -- comment=3
lin sharp_A = L.sharp_A ;
lin formation_N = mkN "formation" "formationer" | mkN "formering" ; -- SaldoWN -- comment=2
lin queen_N = L.queen_N ;
lin waste_N = mkN "slöseri" neutrum | mkN "ödemark" "ödemarker" ; -- SaldoWN -- comment=22
lin virtually_Adv = variants{} ;
lin expand_V2V = mkV2V (mkV "faktoriseras"); -- status=guess, src=wikt
lin expand_V2 = dirV2 (partV (mkV "växa" "växer" "växa" "växte" "vuxit" "vuxen")"ur"); -- comment=5
lin expand_V = mkV "utvidgar" ; -- comment=6
lin contemporary_A = mkA "samtida" ; -- comment=4
lin politician_N = mkN "politiker" "politikern" "politiker" "politikerna" | mkN "statsman" "statsmannen" "statsmän" "statsmännen" ;
lin back_V2 = dirV2 (partV (mkV "backar")"ur"); -- comment=15
lin back_V = mkV "backar" ; -- comment=10
lin territory_N = mkN "territorium" "territoriet" "territorier" "territorierna" ;
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
lin unique_A = mkA "unik" ;
lin challenge_V2 = mkV2 "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" ; -- SaldoWN
lin challenge_V = mkV "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" | mkV "utmanar" ; -- SaldoWN -- comment=6
lin inflation_N = mkN "inflation" "inflationer" ; -- SaldoWN
lin assistance_N = mkN "assist" "assister" ; -- comment=4
lin list_V2V = variants {} ;
lin list_V2 = dirV2 (partV (mkV "listar")"ut");
lin list_V = mkV "önskar" ; -- comment=4
lin identity_N = mkN "identitet" "identiteter" ; -- SaldoWN
lin suit_V2 = dirV2 (partV (mkV "passar")"på"); -- comment=5
lin suit_V = mkV "tillfredsställer" ; -- comment=7
lin parliamentary_A = mkA "parlamentarisk" ;
lin unknown_A = mkA "okänd" "okänt" ;
lin preparation_N = mkN "beredskap" "beredskaper" | mkN "preparat" neutrum ; -- SaldoWN -- comment=12
lin elect_V3 = mkV3 (mkV "välja" "valde" "valt") ; -- SaldoWN -- status=guess, src=wikt
lin elect_V2V = mkV2V (mkV "välja" "valde" "valt") ; -- SaldoWN -- status=guess, src=wikt
lin elect_V2 = mkV2 "välja" "valde" "valt" ;
lin elect_V = mkV "välja" "valde" "valt" | mkV "utvälja" "utvalde" "utvalt" ; -- SaldoWN -- comment=2
lin badly_Adv = variants{} ;
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
lin appreciate_V2 = mkV2 "värdesätta" "värdesätter" "värdesätt" "värdesatte" "värdesatt" "värdesatt" | mkV2 (mkV "förstå") | mkV2 (mkV (mkV "vara") "medveten om") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin appreciate_V = mkV "värdesätta" "värdesätter" "värdesätt" "värdesatte" "värdesatt" "värdesatt" | mkV "uppfattar" ; -- SaldoWN -- comment=5
lin fan_N = variants{} ;
lin fan_3_N = mkN "solfjäder" ;
lin fan_2_N = mkN "fan" ;
lin fan_1_N = mkN "fläkt" ;
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
lin buyer_N = variants{} ;
lin gift_N = mkN "gåva" ; -- SaldoWN
lin resolution_N = mkN "beslut" neutrum | mkN "lösning" ; -- SaldoWN -- comment=11
lin angry_A = mkA "arg" | mkA "elak" ; -- SaldoWN -- comment=9
lin metre_N = mkN "meter" ; -- comment=5
lin wheel_N = mkN "hjul" neutrum | mkN "rulla" ; -- SaldoWN -- comment=3
lin clause_N = mkN "sats" "satser" ; -- comment=3
lin break_N = mkN "brott" neutrum | mkN "utbrytning" ; -- SaldoWN = mkN "brott" neutrum ; -- comment=29
lin tank_N = mkN "stridsvagn" ; -- SaldoWN
lin benefit_V2 = variants {} ;
lin benefit_V = mkV "understöda" "understödde" "understött" ; -- comment=4
lin engage_V2 = variants {} ;
lin engage_V = mkV "uppta" "upptar" "uppta" "upptog" "upptagit" "upptagen" ; -- comment=20
lin alive_A = mkA "levande" ; -- SaldoWN
lin complaint_N = mkN "åkomma" ; -- comment=4
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
lin prior_A = mkA "föregående" ;
lin round_A = L.round_A ;
lin eastern_A = mkA "ostlig" ;
lin coat_N = L.coat_N ;
lin involvement_N = mkN "inblandning" ; -- comment=6
lin tension_N = mkN "spänning" | mkN "ångtryck" neutrum ; -- SaldoWN = mkN "spänning" ; -- comment=6
lin diet_N = mkN "diet" "dieter" ; -- SaldoWN
lin enormous_A = mkA "enorm" ; -- comment=5
lin score_N = mkN "ställning" | mkN "tjog" neutrum ; -- SaldoWN -- comment=12
lin rarely_Adv = variants{} ;
lin prize_N = mkN "pris" neutrum | mkN "vinst" "vinster" ; -- SaldoWN = mkN "pris" ; = mkN "pris" "priser" ; = mkN "pris" neutrum ; -- comment=13
lin remaining_A = variants{} ;
lin significantly_Adv = variants{} ;
lin glance_V2 = dirV2 (partV (mkV "tittar")"till"); -- comment=4
lin glance_V = mkV "tittar" ; -- comment=6
lin dominate_V2 = variants {} ;
lin dominate_V = mkV "dominerar" ; -- comment=4
lin trust_VS = mkVS (mkV "förtrösta") | mkVS (mkV (mkV "känna") "förtröstan") | mkVS (mkV (mkV "känna") "tilltro"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin trust_V2V = mkV2V (mkV "förtrösta") | mkV2V (mkV (mkV "känna") "förtröstan") | mkV2V (mkV (mkV "känna") "tilltro"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin trust_V2 = mkV2 (mkV "förtrösta") | mkV2 (mkV (mkV "känna") "förtröstan") | mkV2 (mkV (mkV "känna") "tilltro"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin trust_V = mkV "förtrösta" | mkV (mkV "känna") "förtröstan" | mkV (mkV "känna") "tilltro" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin naturally_Adv = variants{} ;
lin interpret_V2 = mkV2 "översätta" "översätter" "översätt" "översatte" "översatt" "översatt" | mkV2 (mkV "tolka") ; -- SaldoWN
lin interpret_V = mkV "översätta" "översätter" "översätt" "översatte" "översatt" "översatt" | mkV "tolkar" ; -- SaldoWN -- comment=2
lin land_V2 = mkV2 (mkV "landar"); -- status=guess, src=wikt
lin land_V = mkV "landsätta" "landsätter" "landsätt" "landsatte" "landsatt" "landsatt" ; -- comment=6
lin frame_N = mkN "skelett" neutrum | mkN "stomme" utrum ; -- SaldoWN -- comment=12
lin extension_N = mkN "utbyggnad" "utbyggnader" ; -- SaldoWN
lin mix_V2 = dirV2 (partV (mkV "blandar")"ut"); -- comment=4
lin mix_V = mkV "förenar" ; -- comment=3
lin spokesman_N = mkN "förespråkare" utrum | mkN "talesman" "talesmannen" "talesmän" "talesmännen" ; -- SaldoWN -- comment=3
lin friendly_A = mkA "vänlig" | mkA "vänskaplig" ; -- SaldoWN -- comment=6
lin acknowledge_VS = variants {} ;
lin acknowledge_V2 = variants {} ;
lin acknowledge_V = mkV "erkänna" "erkände" "erkänt" ; -- comment=5
lin register_V2 = dirV2 (partV (mkV "listar")"ut"); -- comment=2
lin register_V = mkV "uttrycker" ; -- comment=12
lin regime_N = variants{} ;
lin regime_2_N = variants {} ;
lin regime_1_N = mkN "regim" "regimer" ;
lin fault_N = mkN "fel" neutrum | mkN "skuld" "skulder" ; -- SaldoWN = mkN "fel" neutrum ; -- comment=10
lin dispute_N = mkN "dispyt" "dispyter" ; -- comment=8
lin grass_N = L.grass_N ;
lin quietly_Adv = variants{} ;
lin decline_N = mkN "sluttning" ; -- comment=10
lin dismiss_V2 = mkV2 (mkV "avskedar") | mkV2 (mkV "sparkar") | mkV2 (mkV "entledigar") | mkV2 (mkV "upplösa"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
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
lin analyse_V2 = variants {} ;
lin anywhere_Adv = mkAdv "någonstans" ; -- comment=2
lin average_N = mkN "medeltal" neutrum | mkN "genomsnitt" neutrum ; -- SaldoWN -- comment=2
lin phrase_N = mkN "uttryckssätt" neutrum; -- comment=5
lin long_term_A = mkA "långsiktig" ; --
lin crew_N = mkN "besättning" ;
lin lucky_A = mkA "lyckosam" "lyckosamt" "lyckosamma" "lyckosamma" "lyckosammare" "lyckosammast" "lyckosammaste" | mkA "lycklig" ; -- SaldoWN -- comment=2
lin restore_V2 = variants {} ;
lin convince_V2V = mkV2V (mkV "övertyga"); -- status=guess, src=wikt
lin convince_V2 = mkV2 (mkV "övertyga"); -- status=guess, src=wikt
lin coast_N = mkN "kust" "kuster" ;
lin engineer_N = mkN "ingenjör" "ingenjörer" | mkN "maskinist" "maskinister" ; -- SaldoWN -- comment=7
lin heavily_Adv = variants{} ;
lin extensive_A = mkA "vidsträckt" "vidsträckt" ;
lin glad_A = mkA "glad" | mkA "villig" ; -- SaldoWN -- comment=2
lin charity_N = mkN "välgörenhet" "välgörenheter" | mkN "människokärlek" ; -- SaldoWN -- comment=7
lin oppose_VS = mkVS (mkV "opponerar"); -- status=guess, src=wikt
lin oppose_V2 = mkV2 (mkV "opponerar"); -- status=guess, src=wikt
lin oppose_V = mkV "motarbetar" ; -- comment=4
lin defend_V2 = mkV2 "försvara" ;
lin defend_V = mkV "skyddar" ; -- comment=5
lin alter_V2 = dirV2 (partV (mkV "skiftar")"ut");
lin alter_V = mkV "ändrar" ; -- comment=6
lin warning_N = mkN "varning" | mkN "varsel" neutrum ; -- SaldoWN -- comment=4
lin arrest_V2 = mkV2 "anhålla" "anhöll" "anhållit" | dirV2 (partV (mkV "stoppar") "till") ; -- SaldoWN -- comment=3
lin framework_N = mkN "konstruktion" "konstruktioner" ; -- comment=7
lin approval_N = mkN "välsignelse" "välsignelser" | mkN "godkännande" ; -- SaldoWN -- comment=6
lin bother_VV = variants {} ;
lin bother_V2V = variants {} ;
lin bother_V2 = variants {} ;
lin bother_V = mkV "bråkar" ; -- comment=7
lin novel_N = mkN "roman" "romaner" ;
lin accuse_V2 = mkV2 (mkV "anklagar"); -- status=guess, src=wikt
lin surprised_A = variants{} ;
lin currency_N = mkN "valuta" ; -- SaldoWN
lin restrict_V2 = mkV2 (mkV "inskränka") | mkV2 (mkV "begränsa"); -- status=guess, src=wikt status=guess, src=wikt
lin restrict_V = mkV "begränsar" ; -- comment=2
lin possess_V2 = mkV2 (mkV "äga"); -- status=guess, src=wikt
lin moral_A = mkA "sedelärande" ; -- comment=3
lin protein_N = mkN "protein" "proteinet" "proteiner" "proteinerna" ; -- SaldoWN
lin distinguish_V2 = dirV2 (partV (mkV "skilja")"av"); -- comment=2
lin distinguish_V = mkV "kännetecknar" ; -- comment=6
lin gently_Adv = mkAdv "sakta" ; -- comment=2
lin reckon_VS = variants {} ;
lin reckon_V2 = dirV2 (partV (mkV "räknar")"ut"); -- comment=5
lin reckon_V = mkV "beräknar" ; -- comment=5
lin incorporate_V2 = mkV2 (mkV "uppta" "upptar" "uppta" "upptog" "upptagit" "upptagen"); -- status=guess, src=wikt
lin incorporate_V = mkV "inkorporerar" ; -- comment=4
lin proceed_VV = variants {} ;
lin proceed_V2 = dirV2 (partV (mkV "börjar")"om");
lin proceed_V = mkV "fortsätta" "fortsätter" "fortsätt" "fortsatte" "fortsatt" "fortsatt" ; -- comment=9
lin assist_V2 = mkV2 (mkV "assisterar") | mkV2 (mkV "hjälpa") | mkV2 (mkV "bistå") | mkV2 (mkV "stödja"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin assist_V = mkV "hjälper" ; -- comment=5
lin sure_Adv = mkAdv "absolut" ;
lin stress_VS = variants {} ;
lin stress_V2 = variants {} ;
lin justify_VV = mkVV (mkV "berättiga") ;
lin justify_V2 = mkV2 "berättiga" ;
lin behalf_N = variants {} ;
lin councillor_N = variants {} ;
lin setting_N = mkN "sättning" ;
lin command_N = mkN "kontroll" | mkN "herravälde" ; -- SaldoWN = mkN "kontroll" "kontroller" ; -- comment=16
lin command_2_N = mkN "kontroll" "kontroller" ;
lin command_1_N = mkN "kommando" "kommandon" ;
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
lin firmly_Adv = variants{} ;
lin willing_A = mkA "villig" ; -- comment=3
lin healthy_A = mkA "sund" ; -- comment=6
lin focus_N = mkN "inriktning" ; -- comment=8
lin construct_V2 = mkV2 (mkV "konstruerar"); -- status=guess, src=wikt
lin occasionally_Adv = variants{} ;
lin mode_N = variants {} ;
lin saving_N = mkN "besparing" ; -- comment=2
lin comfortable_A = mkA "bekväm" | mkA "trygg" ; -- SaldoWN -- comment=10
lin camp_N = mkN "läger" neutrum ;
lin trade_V2 = variants {} ;
lin trade_V = mkV "byter" ;
lin export_N = mkN "export" "exporter" | mkN "exportartikel" ; -- SaldoWN -- comment=3
lin wake_V2 = mkV2 (mkV "väcka"); -- status=guess, src=wikt
lin wake_V = mkV "vaknar" ; -- comment=2
lin partnership_N = mkN "partnerskap" neutrum | mkN "kompanjonskap" ; -- SaldoWN -- comment=3
lin daily_A = mkA "daglig" ;
lin abroad_Adv = mkAdv "utomlands" ; -- comment=5
lin profession_N = mkN "yrke" ; -- SaldoWN
lin load_N = mkN "börda" | mkN "fylla" ; -- SaldoWN -- comment=6
lin countryside_N = mkN "landsbygd" | mkN "bygd" "bygder" ; -- SaldoWN -- comment=2
lin boot_N = L.boot_N ;
lin mostly_Adv = mkAdv "mestadels" ;
lin sudden_A = mkA "plötslig" ; -- SaldoWN
lin implement_V2 = mkV2 (mkV "implementera"); -- status=guess, src=wikt
lin reputation_N = mkN "anseende" | mkN "rykte" ; -- SaldoWN -- comment=4
lin print_V2 = dirV2 (partV (mkV "präntar")"i");
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
lin cope_V = variants {} ;
lin constitute_V2 = mkV2 (mkV "utgöra"); -- status=guess, src=wikt
lin poll_N = mkN "enkät" "enkäter" | mkN "val" ; -- SaldoWN -- comment=10
lin voluntary_A = mkA "frivillig" ; -- SaldoWN
lin valuable_A = mkA "värdefull" ; -- SaldoWN
lin recovery_N = mkN "återhämtning" | mkN "återvinnande" ; -- SaldoWN -- comment=6
lin cast_V2 = mkV2 "rollbesätta" "rollbesätter" "rollbesätt" "rollbesatte" "rollbesatt" "rollbesatt" | dirV2 (partV (mkV "ordnar")"om") ;
lin cast_V = mkV "rollbesätta" "rollbesätter" "rollbesätt" "rollbesatte" "rollbesatt" "rollbesatt" | mkV "ordnar" ;
lin premise_N = mkN "premiss" "premisser" ; -- SaldoWN
lin resolve_VV = mkVV (mkV "lösa"); -- status=guess, src=wikt
lin resolve_V2 = dirV2 (partV (mkV "löser")"ut");
lin resolve_V = mkV "sönderdelar" ; -- comment=7
lin regularly_Adv = variants{} ;
lin solve_V2 = dirV2 (partV (mkV "löser")"ut");
lin plaintiff_N = mkN "kärande" ; -- SaldoWN = mkN "kärande" "käranden" "kärande" "kärandena" ;
lin critic_N = mkN "kritiker" "kritikern" "kritiker" "kritikerna" ; -- SaldoWN
lin agriculture_N = mkN "jordbruk" neutrum | mkN "jordbruk" neutrum ; -- SaldoWN -- comment=4
lin ice_N = L.ice_N ;
lin constitution_N = mkN "konstitution" "konstitutioner" | mkN "utseende" ; -- SaldoWN -- comment=14
lin communist_N = mkN "kommunist" "kommunister" ;
lin layer_N = mkN "lager" ; -- SaldoWN = mkN "lager" ; = mkN "lager" neutrum ;
lin recession_N = mkN "recession" "recessioner" ; -- SaldoWN
lin slight_A = mkA "späd" ; -- comment=6
lin dramatic_A = mkA "dramatisk" ; -- SaldoWN
lin golden_A = mkA "gyllene" ; -- comment=3
lin temporary_A = mkA "temporär" | mkA "tillfällig" ; -- SaldoWN -- comment=3
lin suit_N = mkN "uppvaktning" | mkN "omgång" ; -- SaldoWN -- comment=10
lin shortly_Adv = mkAdv "snart" ;
lin initially_Adv = mkAdv "inledningsvis" ;
lin arrival_N = mkN "uppnående" ; -- comment=3
lin protest_N = mkN "protest" "protester" ; -- SaldoWN
lin resistance_N = mkN "motstånd" neutrum; -- comment=6
lin silent_A = mkA "tystgående" ; -- comment=2
lin presentation_N = mkN "presentation" "presentationer" ; -- SaldoWN
lin soul_N = mkN "själ" ; -- SaldoWN
lin self_N = mkN "jag" neutrum | mkN "jag" neutrum ; -- SaldoWN -- comment=2
lin judgment_N = mkN "omdöme" ; -- SaldoWN
lin feed_V2 = mkV2 (mkV "matar");
lin feed_V = mkV "fodrar" ; -- comment=5
lin muscle_N = mkN "muskel" "muskeln" "muskler" "musklerna" ; -- SaldoWN
lin shareholder_N = mkN "aktieägare" utrum | mkN "aktieägare" utrum ; -- SaldoWN
lin opposite_A = mkA "motsatt" ; -- SaldoWN
lin pollution_N = mkN "förorening" | mkN "nedsmutsning" ; -- SaldoWN -- comment=2
lin wealth_N = mkN "rikedom" ; -- SaldoWN
lin video_taped_A = variants{} ;
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
lin purchase_V2 = mkV2 "köper" ; --
lin tired_A = mkA "trött" "trött" ;
lin beer_N = L.beer_N ;
lin specify_VS = variants {} ;
lin specify_V2 = mkV2 "specificera" ;
lin specify_V = mkV "specificerar" ; -- comment=2
lin short_Adv = mkAdv "kort" ; -- comment=2
lin monitor_V2 = mkV2 (mkV "övervaka") | mkV2 (mkV "kontrollerar"); -- status=guess, src=wikt status=guess, src=wikt
lin monitor_V = mkV "övervakar" ; -- comment=4
lin electricity_N = mkN "elektricitet" "elektriciteter" ; -- SaldoWN
lin specifically_Adv = variants{} ;
lin bond_N = mkN "förbindelse" "förbindelser" | mkN "obligation" "obligationer" ; -- SaldoWN -- comment=8
lin statutory_A = compoundA (regA "lagstadgad");
lin laboratory_N = mkN "laboratorium" "laboratoriet" "laboratorier" "laboratorierna" ; -- SaldoWN
lin federal_A = mkA "federal" ;
lin captain_N = mkN "kapten" "kaptener" | mkN "leda" ; -- SaldoWN -- comment=6
lin deeply_Adv = variants{} ;
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
lin struggle_VV = variants {} ;
lin struggle_VS = variants {} ;
lin struggle_V = mkV "kämpar" ; -- comment=5
lin lifespan_N = variants{} ;
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
lin convert_V2 = mkV2 (mkV "omvända"); -- status=guess, src=wikt
lin convert_V = mkV "omvänder" ; -- comment=7
lin possession_N = mkN "innehav" neutrum | mkN "ägodel" "ägodelen" "ägodelar" "ägodelarna" ; -- SaldoWN -- comment=6
lin marketing_N = mkN "marknadsföring" ; -- SaldoWN
lin please_VV = mkVV (mkV "behagar") | mkVV (mkV "glädja") | mkVV (mkV "tillfredsställa") | mkVV (mkV (mkV "ställa") "till freds") | mkVV (mkV (mkV "ställa") "till frids"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin please_V2V = mkV2V (mkV "behagar") | mkV2V (mkV "glädja") | mkV2V (mkV "tillfredsställa") | mkV2V (mkV (mkV "ställa") "till freds") | mkV2V (mkV (mkV "ställa") "till frids"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin please_V2 = mkV2 (mkV "behagar") | mkV2 (mkV "glädja") | mkV2 (mkV "tillfredsställa") | mkV2 (mkV (mkV "ställa") "till freds") | mkV2 (mkV (mkV "ställa") "till frids"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin please_V = mkV "behagar" ; -- comment=6
lin habit_N = mkN "vana" ; -- SaldoWN
lin subsequently_Adv = mkAdv "därefter" ;
lin round_N = mkN "runda" ;
lin purchase_N = mkN "tag" neutrum; -- comment=10
lin sort_V2 = dirV2 (partV (mkV "ordnar")"om");
lin sort_V = mkV "sorterar" ; -- comment=2
lin outside_A = mkA "utvändig" ; -- comment=3
lin gradually_Adv = variants{} ;
lin expansion_N = mkN "expansion" "expansioner" ; -- SaldoWN
lin competitive_A = mkA "tävlingsmässig" | mkA "konkurrenskraftig" ; -- SaldoWN
lin cooperation_N = mkN "samarbete" | mkN "kooperation" "kooperationer" ; -- SaldoWN -- comment=2
lin acceptable_A = mkA "acceptabel" | mkA "välkommen" "välkommet" "välkomna" "välkomna" "välkomnare" "välkomnast" "välkomnaste" ; -- SaldoWN -- comment=4
lin angle_N = mkN "vinkel" ; -- SaldoWN
lin cook_V2 = dirV2 (partV (mkV "kokar")"över"); -- comment=2
lin cook_V = mkV "kokar" ; -- comment=10
lin net_A = mkA "netto" ; --
lin sensitive_A = mkA "känslig" ; -- SaldoWN
lin ratio_N = mkN "förhållande" ; -- SaldoWN
lin kiss_V2 = mkV2 (mkV "kyssas") | mkV2 (mkV "pussas"); -- status=guess, src=wikt status=guess, src=wikt
lin kiss_V = mkV "kysser" ; -- comment=2
lin amount_V = mkV "mänger" ; -- comment=2
lin sleep_N = mkN "sömn" ; -- SaldoWN
lin finance_V2 = mkV2 (mkV "finansierar"); -- status=guess, src=wikt
lin essentially_Adv = variants{} ;
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
lin expected_A = variants{} ;
lin invest_V2 = mkV2 (mkV "investerar"); -- status=guess, src=wikt
lin invest_V = mkV "investerar" ; -- comment=2
lin cycle_N = mkN "cykel" ; -- SaldoWN = mkN "cykel" ;
lin alright_A = variants {} ;
lin philosophy_N = mkN "filosofi" "filosofin" "filosofier" "filosofierna" ;
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
lin retire_V2 = dirV2 (partV (mkV "vilar")"ut");
lin retire_V = mkV "retirerar" ; -- comment=6
lin sugar_N = mkN "socker" neutrum | mkN "socker" neutrum ; -- SaldoWN -- comment=2
lin pale_A = mkA "blek" ; -- comment=7
lin frequency_N = mkN "frekvens" "frekvenser" | mkN "täthet" ; -- SaldoWN -- comment=4
lin guy_N = mkN "fågelskrämma" ; -- comment=10
lin feature_V2 = dirV2 (partV (mkV "visar")"in");
lin furniture_N = mkN "möblemang" neutrum | mkN "möbel" "möbeln" "möbler" "möblerna" ; -- SaldoWN -- comment=3
lin administrative_A = mkA "administrativ" ; -- SaldoWN
lin wooden_A = mkA "träig" ; -- comment=7
lin input_N = variants {} ;
lin phenomenon_N = mkN "fenomen" neutrum | mkN "fenomen" neutrum ; -- SaldoWN -- comment=2
lin surprising_A = mkA "överraskande" ; -- SaldoWN
lin jacket_N = mkN "jacka" ; -- SaldoWN
lin actor_N = mkN "aktör" "aktörer" ; -- comment=3
lin actor_2_N = mkN "aktör" "aktörer" ;
lin actor_1_N = mkN "skådespelare" "skådespelare" ;
lin kick_V2 = dirV2 (partV (mkV "sparkar")"ut"); -- comment=2
lin kick_V = mkV "protesterar" ; -- comment=10
lin producer_N = mkN "producent" "producenter" ;
lin hearing_N = mkN "utfrågning" ; -- comment=6
lin chip_N = mkN "flisa" ; -- SaldoWN
lin equation_N = mkN "ekvation" "ekvationer" ; -- SaldoWN
lin certificate_N = mkN "attest" "attester" | mkN "bevis" neutrum ; -- SaldoWN -- comment=8
lin hello_Interj = mkInterj "hej" | mkInterj "hallå" ;
lin remarkable_A = mkA "anmärkningsvärd" "anmärkningsvärt" ; -- comment=8
lin alliance_N = mkN "förbund" neutrum; -- comment=5
lin smoke_V2 = mkV2 (mkV "ryker"); -- status=guess, src=wikt
lin smoke_V = mkV "röker" ; -- comment=4
lin awareness_N = mkN "kännedom" ; -- comment=5
lin throat_N = mkN "strupe" utrum | mkN "strupe" utrum ; -- SaldoWN -- comment=2
lin discovery_N = mkN "upptäckt" "upptäckter" ; -- SaldoWN
lin festival_N = mkN "festival" "festivaler" | mkN "högtid" "högtider" ; -- SaldoWN -- comment=3
lin dance_N = mkN "dans" "danser" ;
lin promise_N = mkN "löfte" ; -- SaldoWN
lin rose_N = mkN "ros" neutrum | mkN "ros" "rosor" ; -- SaldoWN = mkN "ros" "rosor" ;
lin principal_A = mkA "kapital" ; -- comment=2
lin brilliant_A = mkA "glänsande" ; -- comment=9
lin proposed_A = variants{} ;
lin coach_N = mkN "tränare" utrum | mkN "vagn" ; -- SaldoWN -- comment=13
lin coach_3_N = mkN "buss" ;
lin coach_2_N = mkN "vagn" ;
lin coach_1_N = mkN "tränare" utrum ;
lin absolute_A = mkA "absolut" "absolut" ; -- SaldoWN
lin drama_N = mkN "drama" "dramat" "draman" "dramana" | mkN "dramatik" ; -- SaldoWN -- comment=3
lin recording_N = mkN "inspelning" ; -- SaldoWN
lin precisely_Adv = variants{} ;
lin bath_N = mkN "badrum" "badrummet" "badrum" "badrummen" | mkN "bad" neutrum ; -- SaldoWN -- comment=7
lin celebrate_V2 = variants {} ;
lin substance_N = mkN "substans" "substanser" ; -- comment=7
lin swing_V2 = mkV2 (mkV "gungar") | mkV2 (mkV "svingar"); -- status=guess, src=wikt status=guess, src=wikt
lin swing_V = mkV "svänger" ; -- comment=8
lin for_Adv = variants{} ;
lin rapid_A = mkA "snabb" ; -- comment=3
lin rough_A = mkA "skrovlig" | mkA "ungefärlig" ; -- SaldoWN -- comment=22
lin investor_N = mkN "aktieägare" utrum; -- comment=2
lin fire_V2 = dirV2 (partV (mkV "torkar")"ut"); -- comment=6
lin fire_V = mkV "steker" ; -- comment=22
lin rank_N = mkN "status" | mkN "stinkande" ; -- SaldoWN -- comment=13
lin compete_V = mkV "konkurrerar" ; -- comment=3
lin sweet_A = mkA "söt" ; -- SaldoWN
lin decline_VV = mkVV (mkV (mkV "avstå" "avstod" "avstått") "från"); --
lin decline_VS = variants {} ;
lin decline_V2 = dirV2 (partV (mkV "lutar")"av");
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
lin fight_N = mkN "strid" "strider" | mkN "kamp" ;
lin abuse_N = mkN "skällsord" neutrum ; -- SaldoWN -- comment=7
lin golf_N = mkN "golf" "golfer" ;
lin guitar_N = mkN "gitarr" "gitarrer" ;
lin electronic_A = mkA "elektronisk" ; -- SaldoWN
lin cottage_N = mkN "stuga" ; -- SaldoWN
lin scope_N = mkN "räckvidd" ;
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
lin resist_VV = mkVV (mkV "motstå") | mkVV (mkV (mkV "stå") "emot"); -- status=guess, src=wikt status=guess, src=wikt
lin resist_V2 = mkV2 (mkV "motstå") | mkV2 (mkV (mkV "stå") "emot"); -- status=guess, src=wikt status=guess, src=wikt
lin resist_V = mkV "motstå" "motstod" "motstått" ; -- comment=3
lin qualify_V2 = variants {} ;
lin qualify_V = mkV "modifierar" ; -- comment=11
lin paragraph_N = mkN "paragraf" "paragrafer" | mkN "tidningsnotis" "tidningsnotiser" ; -- SaldoWN -- comment=3
lin sick_A = mkA "sjuk" ; -- SaldoWN
lin near_A = L.near_A;
lin researcher_N = variants{} ;
lin consent_N = mkN "bifall" neutrum; -- comment=4
lin written_A = variants{} ;
lin literary_A = mkA "litterär" ; -- SaldoWN
lin ill_A = mkA "sjuk" ; -- comment=5
lin wet_A = L.wet_A ;
lin lake_N = L.lake_N ;
lin entrance_N = mkN "inträde" ; -- comment=10
lin peak_N = mkN "topp" | mkN "spets" ; -- SaldoWN -- comment=7
lin successfully_Adv = variants{} ;
lin sand_N = L.sand_N ;
lin breathe_V2 = mkV2 (mkV (mkV "andas") "in"); -- status=guess, src=wikt
lin breathe_V = L.breathe_V;
lin cold_N = mkN "kyla" ; -- SaldoWN
lin cheek_N = mkN "kind" "kinder" ; -- SaldoWN
lin platform_N = mkN "plattform" ; -- SaldoWN
lin interaction_N = mkN "interaktion" "interaktioner" ; -- SaldoWN
lin watch_N = mkN "utkik" | mkN "valla" ; -- SaldoWN -- comment=15
lin borrow_VV = variants {} ;
lin borrow_V2 = dirV2 (partV (mkV "lånar")"ut");
lin borrow_V = mkV "lånar" ; -- comment=2
lin birthday_N = mkN "födelsedag" ; -- SaldoWN
lin knife_N = mkN "kniv" ; -- SaldoWN
lin extreme_A = mkA "utomordentlig" ; -- comment=3
lin core_N = mkN "kärna" | mkN "kärnhus" neutrum ; -- SaldoWN -- comment=4
lin peasant_N = variants{} ;
lin armed_A = variants{} ;
lin permission_N = mkN "tillåtelse" utrum | mkN "tillstånd" neutrum ; -- SaldoWN -- comment=7
lin supreme_A = mkA "ojämförlig" ; -- comment=6
lin overcome_V2 = mkV2 (mkV "övervinna") | mkV2 (mkV "överkomma"); -- status=guess, src=wikt status=guess, src=wikt
lin overcome_V = mkV "övervinna" "övervann" "övervunnit" ; -- comment=7
lin greatly_Adv = variants{} ;
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
lin darkness_N = mkN "mörker" neutrum;
lin bid_N = mkN "hälsa" ; -- comment=6
lin sake_N = variants {} ;
lin sake_2_N = variants {} ;
lin sake_1_N = variants {} ;
lin organize_V2V = mkV2V (mkV "organiserar"); -- status=guess, src=wikt
lin organize_V2 = dirV2 (partV (mkV "ordnar")"om");
lin tourist_N = mkN "turist" "turister" ; -- SaldoWN
lin policeman_N = L.policeman_N;
lin castle_N = mkN "slott" neutrum | mkN "borg" ; -- SaldoWN -- comment=6
lin figure_VS = variants {} ;
lin figure_V2V = variants {} ;
lin figure_V2 = variants {} ;
lin figure_V = mkV "tänker" ; -- comment=2
lin race_VV = variants {} ;
lin race_V2V = variants {} ;
lin race_V2 = variants {} ;
lin race_V = mkV "tävla" ;
lin demonstration_N = mkN "demonstration" "demonstrationer" | mkN "uppvisande" ; -- SaldoWN -- comment=7
lin anger_N = mkN "ilska" ; -- SaldoWN
lin briefly_Adv = variants{} ;
lin presumably_Adv = variants{} ;
lin clock_N = mkN "klocka" ; -- SaldoWN
lin hero_N = mkN "hjälte" utrum ;
lin expose_V2 = dirV2 (partV (mkV "visar")"in");
lin expose_V = mkV "yppar" ; -- comment=14
lin custom_N = mkN "bruk" neutrum; -- comment=13
lin maximum_A = mkA "maximal" ; -- SaldoWN
lin wish_N = mkN "önskning" ;
lin earning_N = variants{} ;
lin priest_N = L.priest_N;
lin resign_VV = mkVV (mkV "avgå" "avgår" "avgå" "avgick" "avgått" "avgången") ; -- SaldoWN ---
lin resign_VS = mkV "avgå" "avgår" "avgå" "avgick" "avgått" "avgången" | mkVS (mkV "avgå") ; -- SaldoWN -- status=guess, src=wikt
lin resign_V2V = mkV2V "avgå" "avgår" "avgå" "avgick" "avgått" "avgången" | mkV2V (mkV "avgå") ; -- SaldoWN -- status=guess, src=wikt
lin resign_V2 = mkV2 "avgå" "avgår" "avgå" "avgick" "avgått" "avgången" | mkV2 (mkV "avgå") ; -- SaldoWN -- status=guess, src=wikt
lin resign_V = mkV "avgå" "avgår" "avgå" "avgick" "avgått" "avgången" | mkV "resignerar" ; -- SaldoWN -- comment=8
lin store_V2 = mkV2 (mkV "lagrar") | mkV2 (mkV "sparar"); -- status=guess, src=wikt status=guess, src=wikt
lin widespread_A = mkA "vidsträckt" "vidsträckt" ; -- comment=2
lin comprise_V2 = dirV2 (partV (mkV "gå" "går" "gå" "gick" "gått" "gången") "ut"); -- comment=15
lin chamber_N = mkN "kammare" "kammaren" "kamrar" "kamrarna" ; -- comment=4
lin acquisition_N = mkN "förvärv" neutrum | mkN "förvärvande" ; -- SaldoWN -- comment=2
lin involved_A = variants{} ;
lin confident_A = mkA "trosviss" | mkA "tillitsfull" ; -- SaldoWN -- comment=4
lin circuit_N = mkN "varv" neutrum; -- comment=11
lin radical_A = mkA "radikal" ; -- SaldoWN
lin detect_V2 = dirV2 (partV (mkV "spårar")"ur");
lin stupid_A = L.stupid_A ;
lin grand_A = mkA "grandios" ; -- comment=10
lin consumption_N = mkN "konsumtion" "konsumtioner" ; -- SaldoWN
lin hold_N = mkN "arrest" "arrester" | mkN "äga" ; -- SaldoWN -- comment=12
lin zone_N = mkN "zon" "zoner" ; -- SaldoWN
lin mean_A = mkA "elak" ;
lin altogether_Adv = mkAdv "alldeles" ;
lin rush_VV = variants {} ;
lin rush_V2V = variants {} ;
lin rush_V2 = dirV2 (partV (mkV "störtar")"in"); -- comment=3
lin rush_V = mkV "störtar" ; -- comment=13
lin numerous_A = mkA "talrik" ;
lin sink_V2 = mkV2 (mkV "sänka"); -- status=guess, src=wikt
lin sink_V = mkV "sänker" ; -- comment=13
lin everywhere_Adv = S.everywhere_Adv;
lin classical_A = mkA "klassisk" ;
lin respectively_Adv = variants{} ;
lin distinct_A = mkA "distinkt" "distinkt" | mkA "tydlig" ; -- SaldoWN -- comment=11
lin mad_A = mkA "vansinnig" ; -- comment=12
lin honour_N = mkN "ära" ; -- SaldoWN
lin statistics_N = mkN "statistik" "statistiker" ; -- SaldoWN
lin false_A = mkA "falsk" ; -- SaldoWN
lin square_N = mkN "torg" neutrum | mkN "vinkelhake" utrum ; -- SaldoWN -- comment=9
lin differ_V = mkV "ifrågasätta" "ifrågasätter" "ifrågasätt" "ifrågasatte" "ifrågasatt" "ifrågasatt" | mkV "avvika" "avvek" "avvikit" ; -- SaldoWN
lin disk_N = mkN "skiva" | mkN "disk" ; -- SaldoWN -- comment=6
lin truly_Adv = variants{} ;
lin survival_N = mkN "överlevnad" "överlevnader" ; -- SaldoWN
lin proud_A = mkA "stolt" "stolt" ; -- SaldoWN
lin tower_N = mkN "torn" ; -- SaldoWN = mkN "torn" neutrum ;
lin deposit_N = mkN "insättning" | mkN "lager" ; -- SaldoWN -- comment=14
lin pace_N = mkN "tempo" "tempot" "tempon" "tempona" ; -- SaldoWN
lin compensation_N = mkN "kompensation" "kompensationer" | mkN "utjämning" ; -- SaldoWN -- comment=5
lin adviser_N = variants{} ;
lin consultant_N = mkN "konsult" "konsulter" ; -- SaldoWN
lin drag_V2 = dirV2 (partV (mkV "släpar")"ut"); -- comment=9
lin drag_V = mkV "släpar" ; -- comment=4
lin advanced_A = variants{} ;
lin landlord_N = mkN "hyresvärd" | mkN "värdshusvärd" ; -- SaldoWN -- comment=5
lin whenever_Adv = mkAdv "närsom" | mkAdv "när som helst" | mkAdv "närhelst" ; -- status=guess status=guess status=guess
lin delay_N = mkN "fördröjning" | mkN "dröjsmål" neutrum ; -- SaldoWN -- comment=4
lin green_N = mkN "grönska" | mkN "bana" ; -- SaldoWN -- comment=2
lin car_V = variants{} ;
lin holder_N = mkN "behållare" utrum; -- comment=3
lin secret_A = mkA "hemlig" ;
lin edition_N = mkN "utgåva" | mkN "upplaga" ;
lin occupation_N = mkN "ockupation" "ockupationer" | mkN "besittningstagande" ; -- SaldoWN -- comment=12
lin agricultural_A = mkA "agrikulturell" ; -- SaldoWN
lin intelligence_N = variants{} ;
lin intelligence_2_N = mkN "underrättelse" "underrättelser" ;
lin intelligence_1_N = mkN "förstånd" neutrum;
lin empire_N = mkN "imperium" "imperiet" "imperier" "imperierna" | mkN "kejsardöme" ;
lin definitely_Adv = variants{} ;
lin negotiate_VV = mkVV (mkV "förhandla") | mkVV (mkV "underhandlar"); -- status=guess, src=wikt status=guess, src=wikt
lin negotiate_V2 = mkV2 (mkV "förhandla") | mkV2 (mkV "underhandlar"); -- status=guess, src=wikt status=guess, src=wikt
lin negotiate_V = mkV "sälja" "sålde" "sålt" ; -- comment=6
lin host_N = mkN "värd" ;
lin relative_N = mkN "släkting" ; -- comment=3
lin mass_A = variants{} ;
lin helpful_A = mkA "hjälpsam" "hjälpsamt" "hjälpsamma" "hjälpsamma" "hjälpsammare" "hjälpsammast" "hjälpsammaste" ; -- SaldoWN
lin fellow_N = mkN "pojkvän" "pojkvännen" "pojkvänner" "pojkvännerna" ; -- comment=11
lin sweep_V2 = dirV2 (partV (mkV "sopar")"ut"); -- comment=3
lin sweep_V = mkV "susar" ; -- comment=9
lin poet_N = mkN "poet" "poeter" ;
lin journalist_N = mkN "journalist" "journalister" ; -- comment=2
lin defeat_N = mkN "frustration" "frustrationer" | mkN "omintetgörande" ; -- SaldoWN -- comment=4
lin unlike_Prep = variants {} ;
lin primarily_Adv = mkAdv "primärt" ;
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
lin concerning_Prep = variants{} ;
lin mill_N = mkN "kvarn" | mkN "pepparkvarn" ; -- SaldoWN -- comment=12
lin gentle_A = mkA "mjuk" ; -- comment=7
lin curtain_N = mkN "gardin" "gardiner" | mkN "slöja" ; -- SaldoWN -- comment=5
lin mission_N = mkN "uppdrag" "uppdrag" | mkN "mission" "missioner" ;
lin supplier_N = mkN "leverantör" "leverantörer" ; -- SaldoWN
lin basically_Adv = mkAdv "egentligen" ;
lin assure_V2S = variants {} ;
lin assure_V2 = mkV2 (mkV "försäkra");
lin poverty_N = mkN "fattigdom" ;
lin snow_N = L.snow_N ;
lin prayer_N = mkN "bön" "böner" ; -- SaldoWN
lin pipe_N = mkN "rör" neutrum | mkN "rör" neutrum ; -- SaldoWN -- comment=4
lin deserve_VV = mkVV (mkV "förtjäna"); -- status=guess, src=wikt
lin deserve_V2 = dirV2 (partV (mkV "tjänar")"ut"); -- comment=2
lin deserve_V = mkV "förtjänar" ; -- comment=2
lin shift_N = mkN "skifte" ;
lin split_V2 = L.split_V2;
lin split_V = mkV "spricka" "sprack" "spruckit" ; -- comment=12
lin near_Adv = mkAdv "nästan" ; -- comment=3
lin consistent_A = mkA "förenlig" | mkA "konsekvent" "konsekvent" ; -- SaldoWN -- comment=6
lin carpet_N = L.carpet_N ;
lin ownership_N = mkN "ägande" ; -- SaldoWN
lin joke_N = mkN "skämt" neutrum ; -- SaldoWN -- comment=6
lin fewer_Det = variants{} ;
lin workshop_N = mkN "verkstad" "verkstäder" ; -- SaldoWN
lin salt_N = L.salt_N ;
lin aged_Prep = variants{} ;
lin symbol_N = mkN "symbol" "symboler" ; -- SaldoWN
lin slide_V2 = mkV2 "glida" "gled" "glidit" | mkV2 (mkV "glidtackla") ; -- SaldoWN -- status=guess, src=wikt
lin slide_V = mkV "glida" "gled" "glidit" | mkV "sticka" "stack" "stuckit" ; -- SaldoWN -- comment=10
lin cross_N = mkN "korsning" | mkN "mot" neutrum ; -- SaldoWN -- comment=15
lin anxious_A = mkA "ängslig" ; -- comment=8
lin tale_N = mkN "lögn" "lögner" ; -- comment=4
lin preference_N = mkN "förkärlek" | mkN "preferens" "preferenser" ; -- SaldoWN -- comment=3
lin inevitably_Adv = variants{} ;
lin mere_A = mkA "bar" ; -- comment=4
lin behave_V = mkV "uppträda" "uppträdde" "uppträtt" | mkV "handlar" ; -- SaldoWN -- comment=3
lin gain_N = mkN "ökning" ; -- comment=2
lin nervous_A = mkA "nervös" ; -- SaldoWN
lin guide_V2 = variants {} ;
lin remark_N = mkN "anmärkning" ; -- SaldoWN
lin pleased_A = variants{} ;
lin province_N = mkN "provins" "provinser" ;
lin steel_N = L.steel_N ;
lin practise_V2 = variants {} ;
lin practise_V = mkV "övar" ; -- comment=8
lin flow_V = L.flow_V;
lin holy_A = mkA "helig" ; -- SaldoWN
lin dose_N = mkN "dos" "doser" ; -- SaldoWN
lin alcohol_N = mkN "alkohol" "alkoholer" ; -- SaldoWN
lin guidance_N = mkN "ledning" ; -- comment=4
lin constantly_Adv = variants{} ;
lin climate_N = mkN "klimat" neutrum ; -- SaldoWN -- comment=2
lin enhance_V2 = mkV2 "förhöja" "förhöjde" "förhöjt" | mkV2 (mkV "förbättra") ; -- SaldoWN -- status=guess, src=wikt
lin reasonably_Adv = variants{} ;
lin waste_V2 = dirV2 (partV (mkV "sinar")"ut");
lin waste_V = mkV "ödelägga" "ödelade" "ödelagt" ; -- comment=27
lin smooth_A = L.smooth_A ;
lin dominant_A = mkA "dominant" "dominant" ; -- SaldoWN
lin conscious_A = mkA "medveten" "medvetet" ; -- SaldoWN
lin formula_N = mkN "formel" "formeln" "formler" "formlerna" ; -- SaldoWN
lin tail_N = L.tail_N ;
lin ha_Interj = variants{} ;
lin electric_A = mkA "elektrisk" ;
lin sheep_N = L.sheep_N ;
lin medicine_N = mkN "medicin" "mediciner" ; -- SaldoWN
lin strategic_A = mkA "strategisk" ; -- SaldoWN
lin disabled_A = variants{} ;
lin smell_N = mkN "lukt" "lukter" | mkN "luktsinne" ; -- SaldoWN -- comment=7
lin operator_N = mkN "operatör" "operatörer" ; -- comment=6
lin mount_VS = mkVS (mkV "monterar"); -- status=guess, src=wikt
lin mount_V2 = dirV2 (partV (mkV "växa" "växer" "växa" "växte" "vuxit" "vuxen")"ur"); -- comment=7
lin mount_V = mkV "stiga" "steg" "stigit" ; -- comment=10
lin advance_V2 = mkV2 "fortskrida" "fortskred" "fortskridit" | mkV2 (mkV "förskottera") ; -- SaldoWN -- status=guess, src=wikt
lin advance_V = mkV "fortskrida" "fortskred" "fortskridit" | mkV "framställer" ; -- SaldoWN -- comment=18
lin remote_A = mkA "otillgänglig" ; -- comment=5
lin measurement_N = mkN "mätning" ; -- comment=3
lin favour_VS = variants {} ;
lin favour_V2 = variants {} ;
lin favour_V = variants {} ;
lin neither_Det = M.mkDet "ingendera" | M.mkDet "ingen av" ; -- status=guess status=guess
lin architecture_N = mkN "arkitektur" "arkitekturer" | mkN "byggnad" "byggnader" ; -- SaldoWN -- comment=6
lin worth_N = mkN "värde" ; -- SaldoWN
lin tie_N = mkN "slips" ; -- SaldoWN
lin barrier_N = mkN "hinder" neutrum | mkN "barriär" "barriärer" ; -- SaldoWN -- comment=9
lin practitioner_N = mkN "utövare" "utövare" ;
lin outstanding_A = mkA "innestående" ; -- comment=10
lin enthusiasm_N = mkN "entusiasm" ; -- SaldoWN
lin theoretical_A = mkA "teoretisk" ;
lin implementation_N = mkN "implementering" ; -- status=guess
lin worried_A = variants{} ;
lin pitch_N = mkN "tonhöjd" "tonhöjder" | mkN "resa" ; -- SaldoWN -- comment=21
lin drop_N = mkN "stup" neutrum | mkN "sänka" ; -- SaldoWN -- comment=16
lin phone_V2 = mkV2 (mkV "ringar") | mkV2 (mkV "telefonerar"); -- status=guess, src=wikt status=guess, src=wikt
lin phone_V = mkV "telefonerar" ; -- comment=3
lin shape_VV = mkVV (mkV "formar"); -- status=guess, src=wikt
lin shape_V2 = dirV2 (partV (mkV "formar")"till");
lin shape_V = mkV "skapar" ; -- comment=5
lin clinical_A = variants {} ;
lin lane_N = mkN "fil" | mkN "stig" ; -- SaldoWN = mkN "fil" ; = mkN "fil" "filer" ; -- comment=8
lin apple_N = L.apple_N ;
lin catalogue_N = mkN "katalog" "kataloger" ; -- SaldoWN
lin tip_N = mkN "ände" utrum | mkN "ända" ; -- SaldoWN -- comment=16
lin publisher_N = mkN "utgivare" utrum | mkN "bokförläggare" utrum ; -- SaldoWN -- comment=3
lin opponent_N = variants{} ;
lin live_A = mkA "live" | mkA "levande" ;
lin burden_N = mkN "huvudtema" "huvudtemat" "huvudteman" "huvudtemana" ; -- comment=5
lin tackle_V2 = dirV2 (partV (mkV "tacklar")"av");
lin tackle_V = mkV "klämmer" ; -- comment=3
lin historian_N = mkN "historiker" "historikern" "historiker" "historikerna" ; -- SaldoWN
lin bury_V2 = mkV2 (mkV "begraver") | mkV2 (mkV "gömma"); -- status=guess, src=wikt status=guess, src=wikt
lin bury_V = mkV "begraver" ; -- comment=4
lin stomach_N = mkN "mage" utrum | mkN "smälta" ; -- SaldoWN -- comment=7
lin percentage_N = mkN "procent" "procenten" "procent" "procenten" ; -- comment=4
lin evaluation_N = mkN "utvärdering" ;
lin outline_V2 = variants {} ;
lin talent_N = mkN "talang" "talanger" ; -- comment=4
lin lend_V2 = dirV2 (partV (mkV "lånar")"ut");
lin lend_V = mkV "utlånar" ; -- comment=2
lin silver_N = L.silver_N ;
lin pack_N = mkN "flock" neutrum | mkN "packis" ; -- SaldoWN = mkN "flock" ; -- comment=29
lin fun_N = mkN "skoj" neutrum | mkN "lekfullhet" "lekfullheter" ; -- SaldoWN -- comment=5
lin democrat_N = mkN "demokrat" "demokrater" ; -- SaldoWN
lin fortune_N = mkN "öde" ; -- SaldoWN
lin storage_N = mkN "lager" | mkN "förvar" neutrum ; -- SaldoWN = mkN "lager" ; = mkN "lager" neutrum ; -- comment=7
lin professional_N = mkN "fackman" "fackmannen" "fackmän" "fackmännen" | (mkN "proffs" neutrum) | (mkN "expert" "experter") ; -- SaldoWN -- status=guess status=guess
lin reserve_N = mkN "reserv" "reserver" | mkN "reservspelare" utrum ; -- SaldoWN -- comment=6
lin interval_N = mkN "intervall" neutrum;
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
lin impress_V2 = variants {} ;
lin impress_V = mkV "imponerar" ;
lin constitutional_A = mkA "konstitutionell" ;
lin emphasize_VS = mkVS (mkV "understryka" "underströk" "understrukit");
lin emphasize_V2 = mkV2 (mkV "understryka" "underströk" "understrukit");
lin developing_A = variants{} ;
lin proof_N = mkN "bevis" neutrum | mkN "prov" neutrum ; -- SaldoWN -- comment=10
lin furthermore_Adv = mkAdv "dessutom" ; -- comment=2
lin dish_N = mkN "parabolantenn" "parabolantenner" | mkN "urholkning" ; -- SaldoWN -- comment=15
lin interview_V2 = variants {} ;
lin considerably_Adv = variants{} ;
lin distant_A = mkA "avlägsen" "avlägset" | compoundA (regA "reserverad") ; -- SaldoWN -- comment=9
lin lower_V2 = mkV2 (mkV "sänka");
lin lower_V = mkV "nedsänker" ; -- comment=4
lin favourite_N = variants{} ;
lin tear_V2 = dirV2 (partV (mkV "rusar")"ut"); -- comment=2
lin tear_V = mkV "splittrar" ; -- comment=9
lin fixed_A = variants{} ;
lin by_Adv = mkAdv "av" ; -- comment=16
lin luck_N = mkN "lycka" ; -- comment=6
lin count_N = mkN "räkning" ; -- comment=4
lin precise_A = mkA "precis" | mkA "exakt" "exakt" ; -- SaldoWN
lin determination_N = mkN "bestämning" ; -- comment=7
lin bite_V2 = L.bite_V2 ;
lin bite_V = mkV "bita" "bet" "bitit" | mkV "be" "bad" "bett" ; -- SaldoWN -- comment=14
lin dear_Interj = variants{} ;
lin consultation_N = mkN "samråd" neutrum | mkN "rådplägning" ; -- SaldoWN -- comment=7
lin range_V2 = dirV2 (partV (mkV "skalar")"av");
lin range_V = mkV "kedjar" ; -- comment=6
lin residential_A = mkA "bostadsmässig" ; -- SaldoWN
lin conduct_N = mkN "uppträdande" ; -- comment=6
lin capture_V2 = dirV2 (partV (mkV "ta" "tar" "ta" "tog" "tagit" "tagen")"ut"); -- comment=4
lin ultimately_Adv = variants{} ;
lin cheque_N = mkN "check" ; -- SaldoWN
lin economics_N = mkN "ekonomi" "ekonomier" | mkN "nationalekonomi" ; -- SaldoWN -- comment=2
lin sustain_V2 = variants {} ;
lin secondly_Adv = variants{} ;
lin silly_A = mkA "dum" "dumt" "dumma" "dumma" "dummare" "dummast" "dummaste" ; -- comment=8
lin merchant_N = mkN "köpman" "köpmannen" "köpmän" "köpmännen" ; -- SaldoWN
lin lecture_N = mkN "föredrag" neutrum | mkN "tillrättavisning" ; -- SaldoWN -- comment=4
lin musical_A = mkA "musikalisk" ;
lin leisure_N = mkN "fritid" ; -- SaldoWN
lin check_N = mkN "schack" neutrum | mkN "stopp" ; -- SaldoWN -- comment=27
lin cheese_N = L.cheese_N ;
lin lift_N = mkN "skjuts" | mkN "stigning" ; -- SaldoWN -- comment=11
lin participate_V2 = mkV2 "delta" "deltar" "delta" "deltog" "deltagit" "deltagen" | mkV2 (mkV "delta" "deltar" "delta" "deltog" "deltagit" "deltagen") | mkV2 (mkV "deltaga") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin participate_V = mkV "delta" "deltar" "delta" "deltog" "deltagit" "deltagen" ; -- SaldoWN
lin fabric_N = mkN "tyg" neutrum; -- comment=8
lin distribute_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut");
lin lover_N = mkN "älskare" utrum | mkN "älskare" utrum ; -- SaldoWN -- comment=2
lin childhood_N = mkN "barndom" ; -- SaldoWN
lin cool_A = mkA "sval" | compoundA (regA "ointresserad") ; -- SaldoWN -- comment=18
lin ban_V2 = mkV2 (mkV "bannar"); -- status=guess, src=wikt
lin supposed_A = mkA "förment" "förment" ;
lin mouse_N = mkN "mus" ; -- SaldoWN = mkN "mus" "musen" "möss" "mössen" ;
lin strain_N = mkN "ätt" "ätter" ; -- comment=33
lin specialist_A = variants{} ;
lin consult_V2 = variants {} ;
lin consult_V = mkV "överlägga" "överlade" "överlagt" ; -- comment=6
lin minimum_A = mkA "minimal" ; -- SaldoWN
lin approximately_Adv = mkAdv "ungefär" ;
lin participant_N = mkN "deltagare" utrum | mkN "deltagare" utrum ; -- SaldoWN -- comment=2
lin monetary_A = mkA "monetär" ;
lin confuse_V2 = mkV2 (mkV "blandar"); -- status=guess, src=wikt
lin dare_VV = mkVV (mkV "riskerar"); -- status=guess, src=wikt
lin dare_V2 = mkV2 (mkV "riskerar"); -- status=guess, src=wikt
lin dare_V = mkV "vågar" ; -- comment=3
lin smoke_N = L.smoke_N ;
lin movie_N = mkN "film" "filmer" ;
lin seed_N = L.seed_N ;
lin cease_V2V = mkV2V (mkV "upphöra"); -- status=guess, src=wikt
lin cease_V2 = mkV2 (mkV "upphöra"); -- status=guess, src=wikt
lin cease_V = mkV "uppehålla" "uppehöll" "uppehållit" ; -- comment=5
lin open_Adv = variants{} ;
lin journal_N = mkN "journal" "journaler" ; -- SaldoWN
lin shopping_N = mkN "shopping" | mkN "vara" ; -- SaldoWN -- comment=3
lin equivalent_N = mkN "motsvarighet" "motsvarigheter" ; -- comment=2
lin palace_N = mkN "palats" neutrum | mkN "slott" neutrum ; -- SaldoWN -- comment=3
lin exceed_V2 = variants {} ;
lin isolated_A = variants{} ;
lin poetry_N = mkN "poesi" "poesier" ; -- SaldoWN
lin perceive_VS = mkVS (mkV "begripa" "begrep" "begripit"); -- status=guess, src=wikt
lin perceive_V2V = mkV2V (mkV "begripa" "begrep" "begripit"); -- status=guess, src=wikt
lin perceive_V2 = dirV2 (partV (mkV "se" "såg" "sett")"ut"); -- comment=4
lin lack_V2 = mkV2 (mkV "saknar") | mkV2 (mkV "fattas"); -- status=guess, src=wikt status=guess, src=wikt
lin lack_V = mkV "saknar" ; -- comment=4
lin strengthen_V2 = variants {} ;
lin strengthen_V = mkV "stärker" ; -- comment=4
lin snap_VS = mkV "brista" "brast" "brustit" | mkVS (mkV "snäppa") ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- status=guess, src=wikt
lin snap_V2 = mkV2 "brista" "brast" "brustit" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=2
lin snap_V = mkV "brista" "brast" "brustit" | mkV "nafsar" ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=14
lin readily_Adv = variants{} ;
lin spite_N = mkN "elakhet" "elakheter" | mkN "ondska" ; -- SaldoWN -- comment=4
lin conviction_N = mkN "övertygelse" "övertygelser" ; -- SaldoWN
lin corridor_N = mkN "korridor" "korridoren" "korridorer" "korridorerna" ; -- SaldoWN
lin behind_Adv = mkAdv "bakom" ; -- comment=8
lin ward_N = mkN "skyddsling" | mkN "förmynderskap" neutrum ; -- SaldoWN -- comment=6
lin profile_N = mkN "profil" "profiler" ;
lin fat_A = mkA "fet" | mkA "tjock" ; -- SaldoWN -- comment=8
lin comfort_N = mkN "tröst" ; -- SaldoWN = mkN "tröst" ;
lin bathroom_N = mkN "toalett" "toaletter" ;
lin shell_N = mkN "snäcka" | mkN "skala" ; -- SaldoWN -- comment=23
lin reward_N = mkN "belöning" ; -- SaldoWN
lin deliberately_Adv = variants{} ;
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
lin found_V2 = mkV2 (mkV "grundlägga"); -- status=guess, src=wikt
lin dig_V2 = mkV2 (mkV "diggar"); -- status=guess, src=wikt
lin dig_V = L.dig_V;
lin dirty_A = L.dirty_A ;
lin straight_A = L.straight_A ;
lin psychological_A = mkA "psykologisk" ;
lin grab_V2 = mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV (mkV "ta") "tag i"); -- status=guess, src=wikt status=guess, src=wikt
lin grab_V = mkV "intresserar" ; -- comment=4
lin pleasant_A = mkA "angenäm" ; -- SaldoWN
lin surgery_N = mkN "kirurgi" | mkN "mottagningsrum" "mottagningsrummet" "mottagningsrum" "mottagningsrummen" ; -- SaldoWN -- comment=4
lin inevitable_A = mkA "ofrånkomlig" ; -- SaldoWN
lin transform_V2 = variants {} ;
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
lin plant_V2 = dirV2 (partV (mkV "planterar")"om");
lin till_Prep = variants {} ;
lin known_A = variants{} ;
lin admission_N = mkN "inträdesavgift" "inträdesavgifter" | mkN "intagning" ; -- SaldoWN -- comment=9
lin tissue_N = mkN "vävnad" "vävnader" | mkN "väv" ; -- SaldoWN -- comment=4
lin magistrate_N = variants {} ;
lin joy_N = mkN "glädje" utrum ; -- SaldoWN -- comment=2
lin free_V2V = mkV2V "undanta" "undantar" "undanta" "undantog" "undantagit" "undantagen" | mkV2V (mkV "frigöra") | mkV2V (mkV "befriar") | mkV2V (mkV "frita" "fritar" "frita" "fritog" "fritagit" "fritagen") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin free_V2 = mkV2 "undanta" "undantar" "undanta" "undantog" "undantagit" "undantagen" | mkV2 (mkV "frigöra") | mkV2 (mkV "befriar") | mkV2 (mkV "frita" "fritar" "frita" "fritog" "fritagit" "fritagen") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pretty_A = mkA "snygg" ; -- comment=3
lin operating_N = variants{} ;
lin headquarters_N = variants{} ;
lin grateful_A = mkA "tacksam" "tacksamt" "tacksamma" "tacksamma" "tacksammare" "tacksammast" "tacksammaste" | mkA "välgörande" ; -- SaldoWN -- comment=3
lin classroom_N = mkN "klassrum" "klassrummet" "klassrum" "klassrummen" ; -- SaldoWN
lin turnover_N = mkN "omsättning" ;
lin project_VS = mkVS (mkV (mkV "sträcka") "ut"); -- status=guess, src=wikt
lin project_V2V = mkV2V (mkV (mkV "sträcka") "ut"); -- status=guess, src=wikt
lin project_V2 = dirV2 (partV (mkV "riktar")"till"); -- comment=5
lin project_V = mkV "riktar" ; -- comment=7
lin shrug_VS = mkVS (mkV (mkV "rycka") "på axlarna"); -- status=guess, src=wikt
lin shrug_V2 = mkV2 (mkV (mkV "rycka") "på axlarna"); -- status=guess, src=wikt
lin sensible_A = mkA "klok" ; -- comment=10
lin limitation_N = mkN "begränsning" | mkN "inskränkning" ; -- SaldoWN -- comment=5
lin specialist_N = mkN "fackman" "fackmannen" "fackmän" "fackmännen" | mkN "specialist" "specialister" ; -- SaldoWN
lin newly_Adv = variants{} ;
lin tongue_N = L.tongue_N ;
lin refugee_N = mkN "flykting" ; -- SaldoWN
lin delay_V2 = mkV2 "fördröja" "fördröjde" "fördröjt" | mkV2 (mkV (mkV "skjuta") "upp") ; -- SaldoWN -- status=guess, src=wikt
lin delay_V = mkV "fördröja" "fördröjde" "fördröjt" ; -- SaldoWN
lin dream_V2 = mkV2 (mkV "drömma"); -- status=guess, src=wikt
lin dream_V = mkV "drömmer" ;
lin composition_N = mkN "uppläggning" ; -- comment=18
lin alongside_Prep = variants {} ;
lin ceiling_N = L.ceiling_N ;
lin highlight_V2 = variants {} ;
lin stick_N = L.stick_N ;
lin favourite_A = variants {} ;
lin tap_V2 = dirV2 (partV (mkV "knackar")"av");
lin tap_V = mkV "utnyttjar" ; -- comment=7
lin universe_N = mkN "universum" neutrum; -- comment=2
lin request_VS = mkV "be" "bad" "bett" | mkVS (mkV "anmodar") | mkVS (mkV "begära") | mkVS (mkV "uppmanar") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin request_V2 = mkV2 "be" "bad" "bett" | mkV2 (mkV "anmodar") | mkV2 (mkV "begära") | mkV2 (mkV "uppmanar") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin label_N = mkN "etikett" "etiketter" ;
lin confine_V2 = mkV2 (mkV "begränsa") | mkV2 (mkV "inskränka"); -- status=guess, src=wikt status=guess, src=wikt
lin scream_VS = mkV "skrika" "skrek" "skrikit" | mkVS (mkV "skrika" "skrek" "skrikit") ; -- SaldoWN -- status=guess, src=wikt
lin scream_V2 = mkV2 "skrika" "skrek" "skrikit" | mkV2 (mkV "skrika" "skrek" "skrikit") ; -- SaldoWN -- status=guess, src=wikt
lin scream_V = mkV "skrika" "skrek" "skrikit" ; -- SaldoWN
lin rid_V2 = dirV2 (partV (mkV "rensar")"ut"); -- comment=2
lin rid_V = mkV "befriar" ; -- comment=2
lin acceptance_N = mkN "accepterande" | mkN "erkännande" ; -- SaldoWN -- comment=4
lin detective_N = mkN "detektiv" "detektiver" ; -- SaldoWN
lin sail_V2 = dirV2 (partV (mkV "seglar")"ut"); -- comment=4
lin sail_V = mkV "seglar" ;
lin adjust_V2V = variants {} ;
lin adjust_V2 = dirV2 (partV (mkV "ordnar")"om");
lin adjust_V = mkV "reglerar" ; -- comment=11
lin designer_N = mkN "formgivare" utrum | mkN "ränksmidare" utrum ; -- SaldoWN -- comment=4
lin running_A = variants{} ;
lin summit_N = mkN "toppmöte" ; -- SaldoWN
lin participation_N = mkN "deltagande" ; -- comment=7
lin weakness_N = mkN "svaghet" "svagheter" ; -- SaldoWN
lin block_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=8
lin socalled_A = variants{} ;
lin adapt_V2 = variants {} ;
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
lin assistant_N = mkN "biträdande" ; -- comment=7
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
lin personally_Adv = variants{} ;
lin communicate_V2 = mkV2 (mkV "kommunicerar"); -- status=guess, src=wikt
lin communicate_V = mkV "överföra" "överförde" "överfört" ; -- comment=6
lin pride_N = mkN "stolthet" "stoltheter" ; -- SaldoWN
lin bowl_N = mkN "stadion" neutrum | mkN "skål" ; -- SaldoWN -- comment=10
lin file_V2 = dirV2 (partV (mkV "filar")"av");
lin file_V = mkV "lida" "led" "lidit" ; -- comment=6
lin expertise_N = mkN "expertis" | mkN "sakkunskap" ; -- SaldoWN -- comment=4
lin govern_V2 = mkV2 (mkV "regerar") | mkV2 (mkV "härska"); -- status=guess, src=wikt status=guess, src=wikt
lin govern_V = mkV "styra" "styrde" "styrt" ; -- comment=6
lin leather_N = L.leather_N ;
lin observer_N = mkN "observatör" "observatörer" ; -- SaldoWN
lin margin_N = mkN "marginal" "marginaler" ; -- SaldoWN
lin uncertainty_N = mkN "ovisshet" "ovissheter" | mkN "osäkerhet" "osäkerheter" ; -- SaldoWN -- comment=5
lin reinforce_V2 = mkV2 (mkV "förstärka") | mkV2 (mkV "armerar"); -- status=guess, src=wikt status=guess, src=wikt
lin ideal_N = mkN "ideal" neutrum | mkN "mönster" neutrum ; -- SaldoWN -- comment=5
lin injure_V2 = mkV2 (mkV "skadar"); -- status=guess, src=wikt
lin holding_N = mkN "innehav" neutrum;
lin universal_A = mkA "allmän" "allmänt" "allmänna" "allmänna" "allmännare" "allmännast" "allmännaste" ; -- comment=6
lin evident_A = mkA "uppenbar" ; -- comment=3
lin dust_N = L.dust_N ;
lin overseas_A = mkA "utrikes" ; -- comment=2
lin desperate_A = mkA "desperat" "desperat" ; -- comment=3
lin swim_V2 = mkV2 "flyta" "flöt" "flutit" | mkV2 (mkV "simmar") ; -- SaldoWN -- status=guess, src=wikt
lin swim_V = L.swim_V ;
lin occasional_A = mkA "tillfällig" ; -- comment=3
lin trouser_N = variants {} ;
lin surprisingly_Adv = variants{} ;
lin register_N = mkN "register" neutrum | mkN "register" neutrum ; -- SaldoWN -- comment=12
lin album_N = mkN "album" neutrum ;
lin guideline_N = mkN "riktlinje" "riktlinjer" ; -- SaldoWN
lin disturb_V2 = mkV2 (mkV "störa"); -- status=guess, src=wikt
lin amendment_N = mkN "tillägg" neutrum | mkN "rättelse" "rättelser" ; -- SaldoWN
lin architect_N = variants{} ;
lin objection_N = mkN "invändning" ; -- SaldoWN
lin chart_N = mkN "tablå" "tablåer" | mkN "tabell" "tabeller" ; -- SaldoWN -- comment=7
lin cattle_N = mkN "boskap" | mkN "kreatur" neutrum ; -- SaldoWN -- comment=5
lin doubt_VS = mkVS (mkV "tvivlar"); -- status=guess, src=wikt
lin doubt_V2 = mkV2 (mkV "tvivlar"); -- status=guess, src=wikt
lin react_V = mkV "reagerar" ;
lin consciousness_N = mkN "medvetande" ; -- SaldoWN
lin right_Interj = variants{} ;
lin purely_Adv = variants{} ;
lin tin_N = mkN "tenn" neutrum | mkN "tenn" neutrum ; -- SaldoWN -- comment=10
lin tube_N = mkN "tunnelbana" | mkN "tub" "tuber" ; -- SaldoWN -- comment=5
lin fulfil_V2 = variants {} ;
lin commonly_Adv = mkAdv "vanligen" ;
lin sufficiently_Adv = variants{} ;
lin coin_N = mkN "mynt" neutrum ;
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
lin rugby_N = variants {} ;
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
lin low_Adv = variants {} ;
lin underlying_A = mkA "underliggande" ;
lin heaven_N = mkN "himmel" ; -- SaldoWN
lin nerve_N = mkN "nerv" "nerver" | mkN "mod" neutrum ; -- SaldoWN -- comment=3
lin park_V2 = dirV2 (partV (mkV "lämnar")"över"); -- comment=3
lin park_V = mkV "placerar" ; -- comment=4
lin collapse_V2 = variants {} ;
lin collapse_V = mkV "spricka" "sprack" "spruckit" ; -- comment=7
lin win_N = mkN "seger" ; -- SaldoWN
lin printer_N = mkN "skrivare" utrum | mkN "skrivare" utrum ; -- SaldoWN -- comment=2
lin coalition_N = mkN "koalition" "koalitioner" ; -- SaldoWN
lin button_N = mkN "knapp" ; -- SaldoWN
lin pray_V2 = mkV2 "be" "bad" "bett" | mkV2 (mkV "bönfalla") | mkV2 (mkV "be" "bad" "bett") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin pray_V = mkV "be" "bad" "bett" ; -- SaldoWN
lin ultimate_A = mkA "slutlig" | mkA "slutgiltig" ; -- SaldoWN -- comment=3
lin venture_N = mkN "satsning" | mkN "vågspel" "vågspelet" "vågspel" "vågspelen" ; -- SaldoWN -- comment=5
lin timber_N = mkN "timmer" neutrum | mkN "virke" ; -- SaldoWN
lin companion_N = mkN "sällskapsdam" "sällskapsdamer" ; -- comment=9
lin horror_N = mkN "skräck" ; -- SaldoWN
lin gesture_N = mkN "gest" "gester" ; -- SaldoWN
lin moon_N = L.moon_N ;
lin remark_VS = variants {} ;
lin remark_V2 = variants {} ;
lin remark_V = mkV "iaktta" "iakttar" "iaktta" "iakttog" "iakttagit" "iakttagen" ; -- comment=3
lin clever_A = L.clever_A;
lin van_N = mkN "skåpbil" ;
lin consequently_Adv = variants{} ;
lin raw_A = mkA "rå" "rått" ; -- SaldoWN
lin glance_N = mkN "ögonkast" neutrum | mkN "blick" ; -- SaldoWN -- comment=2
lin broken_A = variants{} ;
lin jury_N = mkN "jury" "juryer" | mkN "tävlingsjury" "tävlingsjuryer" ; -- SaldoWN -- comment=2
lin gaze_V = mkV "stirrar" ; -- comment=3
lin burst_V2 = mkV2 "brista" "brast" "brustit" | dirV2 (partV (mkV "störtar")"in") ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=3
lin burst_V = mkV "brista" "brast" "brustit" | mkV "störtar" ; -- SaldoWN = mkV "brista" "brast" "brustit" ; -- comment=14
lin charter_N = mkN "stadga" ; -- SaldoWN = mkN "stadga" ;
lin feminist_N = variants{} ;
lin discourse_N = mkN "tal" neutrum; -- comment=5
lin reflection_N = mkN "spegelbild" "spegelbilder" | mkN "återkastning" ; -- SaldoWN -- comment=11
lin carbon_N = mkN "kol" neutrum ;
lin sophisticated_A = compoundA (regA "avancerad"); -- comment=6
lin ban_N = mkN "förbud" neutrum ;
lin taxation_N = mkN "skatt" "skatter" ; -- comment=4
lin prosecution_N = mkN "åtal" neutrum | mkN "åtal" neutrum ; -- SaldoWN -- comment=5
lin softly_Adv = variants{} ;
lin asleep_A = variants {} ;
lin aids_N = mkN "aids" ; -- SaldoWN
lin publicity_N = mkN "publicitet" "publiciteter" | mkN "reklam" "reklamer" ; -- SaldoWN -- comment=4
lin departure_N = mkN "avresa" ; -- SaldoWN
lin welcome_A = mkA "välkommen" "välkommet" "välkomna" "välkomna" "välkomnare" "välkomnast" "välkomnaste" ; -- SaldoWN
lin sharply_Adv = variants{} ;
lin reception_N = mkN "mottagning" | mkN "reception" "receptioner" ; -- SaldoWN -- comment=5
lin cousin_N = L.cousin_N ;
lin relieve_V2 = mkV2 "undsätta" "undsätter" "undsätt" "undsatte" "undsatt" "undsatt" ; -- SaldoWN
lin linguistic_A = mkA "lingvistisk" ; -- comment=2
lin vat_N = mkN "kar" neutrum ; -- SaldoWN
lin forward_A = mkA "framfusig" | mkA "försigkommen" "försigkommet" "försigkomna" "försigkomna" "försigkomnare" "försigkomnast" "försigkomnaste" ; -- SaldoWN -- comment=10
lin blue_N = mkN "blåhet" ;
lin multiple_A = mkA "multipel" | mkA "mångfaldig" ;
lin pass_N = mkN "passersedel" | mkN "räcka" ; -- SaldoWN -- comment=14
lin outer_A = mkA "utvändig" ;
lin vulnerable_A = mkA "sårbar" ; -- SaldoWN
lin patient_A = mkA "tålmodig" ; -- SaldoWN
lin evolution_N = mkN "evolution" "evolutioner" ; -- SaldoWN
lin allocate_V2 = mkV2 (mkV "avsätta"); -- status=guess, src=wikt
lin allocate_V = mkV "tilldelar" ; -- comment=8
lin creative_A = mkA "kreativ" ; -- SaldoWN
lin potentially_Adv = variants{} ;
lin just_A = mkA "rättvis" ; -- SaldoWN
lin out_Prep = variants {} ;
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
lin grin_V2 = mkV2 (mkV "flinar"); -- status=guess, src=wikt
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
lin hurry_V2V = mkV2V (mkV (mkV "skynda") "sig"); -- status=guess, src=wikt
lin hurry_V2 = dirV2 (partV (mkV "kilar")"in"); -- comment=3
lin hurry_V = mkV "brådskar" ; -- comment=5
lin essay_N = mkN "essä" "essän" "essäer" "essäerna" | mkN "försök" neutrum ; -- SaldoWN -- comment=4
lin integration_N = mkN "integration" "integrationer" ; -- SaldoWN
lin resignation_N = mkN "underkastelse" utrum | mkN "resignation" "resignationer" ; -- SaldoWN -- comment=9
lin treasury_N = mkN "skattkammare" "skattkammaren" "skattkamrar" "skattkamrarna" ; -- comment=2
lin traveller_N = mkN "resenär" "resenärer" ; -- comment=8
lin chocolate_N = mkN "choklad" neutrum ;
lin assault_N = mkN "överfall" neutrum | mkN "anfall" neutrum ; -- SaldoWN -- comment=6
lin schedule_N = mkN "schema" "schemat" "scheman" "schemana" | mkN "tidsplan" neutrum ; -- SaldoWN -- comment=7
lin undoubtedly_Adv = variants{} ;
lin twin_N = mkN "tvilling" ; -- SaldoWN
lin format_N = mkN "format" neutrum ;
lin murder_V2 = mkV2 (mkV "mörda"); -- status=guess, src=wikt
lin sigh_VS = mkVS (mkV "suckar"); -- status=guess, src=wikt
lin sigh_V2 = mkV2 (mkV "suckar"); -- status=guess, src=wikt
lin sigh_V = mkV "susar" ; -- comment=5
lin seller_N = variants{} ;
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
lin till_Subj = variants{} ;
lin sympathy_N = mkN "sympati" "sympatier" ; -- comment=8
lin tunnel_N = mkN "tunnel" ; -- SaldoWN
lin pen_N = L.pen_N ;
lin instal_V = variants{} ;
lin suspend_V2 = variants {} ;
lin suspend_V = mkV "suspenderar" ; -- comment=10
lin blow_N = mkN "motgång" | mkN "stöt" ; -- SaldoWN -- comment=19
lin wander_V2 = mkV2 "avvika" "avvek" "avvikit" | dirV2 (partV (mkV "strövar")"igenom") ; -- SaldoWN -- comment=2
lin wander_V = mkV "avvika" "avvek" "avvikit" | mkV "yra" "yrde" "yrt" ; -- SaldoWN -- comment=6
lin notably_Adv = mkAdv "märkbart" ;
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
lin nowhere_Adv = mkAdv "ingenstans" ;
lin inspector_N = mkN "inspektör" "inspektörer" | mkN "kontrollant" "kontrollanter" ; -- SaldoWN -- comment=4
lin wise_A = mkA "klok" ; -- SaldoWN
lin balance_V2 = mkV2 (mkV "balanserar") | mkV2 (mkV (mkV "jämna") "ut sig") | mkV2 (mkV (mkV "stå") "och väga") | mkV2 (mkV (mkV "vara") "i jämvikt"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin balance_V = mkV "balanserar" ; -- comment=15
lin purchaser_N = mkN "köpare" utrum; -- comment=2
lin resort_N = mkN "hotell" neutrum ; -- SaldoWN
lin pop_N = mkN "smälla" | mkN "pop" "poper" ; -- SaldoWN -- comment=3
lin organ_N = mkN "orgel" ; -- SaldoWN
lin ease_V2 = variants {} ;
lin ease_V = mkV "lindrar" ; -- comment=2
lin friendship_N = mkN "vänskap" | mkN "kamratskap" neutrum ; -- SaldoWN -- comment=5
lin deficit_N = mkN "underskott" neutrum ; -- SaldoWN -- comment=4
lin dear_N = mkN "raring" ; -- comment=2
lin convey_V2 = dirV2 (partV (mkV "forslar")"in"); -- comment=2
lin reserve_V2 = dirV2 (partV (mkV "sparar")"in");
lin reserve_V = mkV "sparar" ; -- comment=8
lin planet_N = L.planet_N ;
lin frequent_A = mkA "frekvent" "frekvent" | mkA "tät" ; -- SaldoWN -- comment=3
lin loose_A = mkA "lös" | mkA "lösaktig" ; -- SaldoWN = mkA "lös" ; -- comment=7
lin intense_A = mkA "intensiv" | mkA "lidelsefull" ; -- SaldoWN -- comment=4
lin retail_A = variants{} ;
lin wind_V2 = dirV2 (partV (mkV "virar")"om"); -- comment=8
lin wind_V = mkV "virar" ; -- comment=10
lin lost_A = variants{} ;
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
lin back_A = variants{} ;
lin chancellor_N = mkN "kansler" "kanslerer" ;
lin crash_V2 = dirV2 (partV (mkV "störtar")"in");
lin crash_V = mkV "kvaddar" ; -- comment=14
lin belt_N = mkN "skärp" neutrum | mkN "bälte" ; -- SaldoWN -- comment=10
lin logic_N = mkN "logik" ; -- SaldoWN
lin premium_N = mkN "försäkringspremie" "försäkringspremier" | mkN "premie" "premier" ; -- SaldoWN -- comment=3
lin confront_V2 = variants {} ;
lin precede_V2 = mkV2 "föregå" "föregår" "föregå" "föregick" "föregått" "föregången" ; -- SaldoWN
lin precede_V = mkV "föregå" "föregår" "föregå" "föregick" "föregått" "föregången" | mkV "inleda" "inledde" "inlett" ; -- SaldoWN -- comment=2
lin experimental_A = mkA "experimentell" ; -- SaldoWN
lin alarm_N = mkN "larm" neutrum | mkN "väckarklocka" ; -- SaldoWN -- comment=10
lin rational_A = mkA "rationell" ; -- SaldoWN
lin incentive_N = mkN "incitament" neutrum ; -- SaldoWN
lin roughly_Adv = variants{} ;
lin bench_N = mkN "bänk" | mkN "domare" utrum ; -- SaldoWN -- comment=9
lin wrap_V2 = mkV2 (mkV (mkV "slå") "in") | mkV2 (mkV "paketerar") | mkV2 (mkV "emballerar") | mkV2 (mkV (mkV "linda") "in") | mkV2 (mkV (mkV "klä") "in"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wrap_V = mkV "förpackar" ; -- comment=4
lin regarding_Prep = variants{} ;
lin inadequate_A = mkA "otillräcklig" | mkA "inadekvat" "inadekvat" ; -- SaldoWN -- comment=6
lin ambition_N = mkN "ärelystnad" "ärelystnader" ; -- comment=5
lin since_Adv = mkAdv "sedan" ; -- comment=5
lin fate_N = mkN "öde" ; -- comment=5
lin vendor_N = mkN "säljare" utrum;
lin stranger_N = mkN "främling" ;
lin spiritual_A = compoundA (regA "förandligad"); -- comment=5
lin increasing_A = variants{} ;
lin anticipate_VV = variants {} ;
lin anticipate_VS = variants {} ;
lin anticipate_V2 = variants {} ;
lin anticipate_V = mkV "förutse" "förutsåg" "förutsett" ; -- comment=4
lin logical_A = mkA "logisk" ; -- SaldoWN
lin fibre_N = mkN "fiber" "fibern" "fibrer" "fibrerna" ; -- SaldoWN
lin attribute_V2 = mkV2 (mkV "tilldela");
lin sense_VS = variants {} ;
lin sense_V2 = variants {} ;
lin black_N = mkN "mörker" neutrum | mkN "svärta" ; -- SaldoWN -- comment=3
lin petrol_N = mkN "bensin" ; -- SaldoWN
lin maker_N = mkN "tillverkare" utrum; -- comment=4
lin generous_A = mkA "frikostig" | mkA "storsint" "storsint" ; -- SaldoWN -- comment=9
lin allocation_N = mkN "tilldelning" ; -- SaldoWN
lin depression_N = mkN "sänka" ; -- SaldoWN
lin declaration_N = mkN "deklaration" "deklarationer" | mkN "förklaring" ; -- SaldoWN -- comment=6
lin spot_VS = mkVS (mkV (mkV "märka") "ut"); -- status=guess, src=wikt
lin spot_V2 = mkV2 (mkV (mkV "märka") "ut"); -- status=guess, src=wikt
lin spot_V = mkV (mkV "märka") "ut" ; -- status=guess, src=wikt
lin modest_A = mkA "sedesam" "sedesamt" "sedesamma" "sedesamma" "sedesammare" "sedesammast" "sedesammaste" | mkA "anständig" ; -- SaldoWN -- comment=8
lin bottom_A = mkA "botten" | mkA "grund" ; -- SaldoWN -- comment=5
lin dividend_N = mkN "utdelning" ; -- SaldoWN
lin devote_V2 = mkV2 (mkV "devote");
lin condemn_V2 = dirV2 (partV (mkV "dömer") "ut"); -- comment=2
lin integrate_V2 = mkV2 (mkV "integrerar"); -- status=guess, src=wikt
lin integrate_V = mkV "integrerar" ;
lin pile_N = mkN "hög" | mkN "påle" utrum ; -- SaldoWN -- comment=10
lin identification_N = mkN "legitimation" "legitimationer" | mkN "identifikation" "identifikationer" ; -- SaldoWN -- comment=2
lin acute_A = mkA "akut" "akut" | mkA "spetsig" ; -- SaldoWN -- comment=14
lin barely_Adv = variants{} ;
lin providing_Subj = variants{} ;
lin directive_N = mkN "direktiv" neutrum; -- comment=6
lin bet_VS = mkVS (mkV "satsar"); -- status=guess, src=wikt
lin bet_V2 = mkV2 (mkV "satsar"); -- status=guess, src=wikt
lin bet_V = mkV "förutsäga" "förutsade" "förutsagt" ;
lin modify_V2 = variants {} ;
lin bare_A = mkA "bar" | mkA "naken" "naket" ; -- SaldoWN -- comment=7
lin swear_VV = mkVV (mkV "svära" "svor" "svurit") | mkVV (mkV "svära") ; -- SaldoWN -- status=guess, src=wikt
lin swear_V2V = mkV2V "svära" "svor" "svurit" | mkV2V (mkV "svära") ; -- SaldoWN -- status=guess, src=wikt
lin swear_V2 = mkV2 "svära" "svor" "svurit" | mkV2 (mkV "svära") ; -- SaldoWN -- status=guess, src=wikt
lin swear_V = mkV "svära" "svor" "svurit" | mkV "bedyrar" ; -- SaldoWN
lin final_N = mkN "final" "finaler" | mkN "sista" ; -- SaldoWN -- comment=3
lin accordingly_Adv = mkAdv "därmed" ; -- comment=6
lin valid_A = mkA "giltig" | mkA "lagenlig" ; -- SaldoWN -- comment=3
lin wherever_Adv = variants {} ;
lin mortality_N = mkN "dödlighet" ; -- comment=4
lin medium_N = mkN "medium" neutrum | mkN "medelväg" ; -- SaldoWN = mkN "medium" "mediet" "medier" "medierna" ; -- comment=7
lin silk_N = mkN "siden" neutrum | mkN "silke" ; -- SaldoWN -- comment=2
lin funeral_N = mkN "begravning" | mkN "begravningståg" neutrum ; -- SaldoWN -- comment=3
lin depending_A = variants{} ;
lin cow_N = L.cow_N ;
lin correspond_V2 = mkV2 (mkV "motsvarar") ;
lin correspond_V = mkV "brevväxlar" ; -- comment=2
lin cite_V2 = dirV2 (partV (mkV "kallar")"ut");
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
lin wholly_Adv = variants {} ;
lin closure_N = mkN "stängning" ; -- comment=7
lin dictionary_N = mkN "ordbok" "ordböcker" | mkN "uppslagsbok" "uppslagsböcker" ; -- SaldoWN -- comment=3
lin withdrawal_N = mkN "reservation" "reservationer" | mkN "utträde" ; -- SaldoWN -- comment=6
lin automatic_A = mkA "automatisk" | mkA "mekanisk" ; -- SaldoWN -- comment=4
lin liable_A = mkA "mottaglig" ; -- comment=7
lin cry_N = mkN "skrika" ; -- comment=7
lin slow_V2 = dirV2 (partV (mkV "saktar")"av");
lin slow_V = mkV "saktar" ;
lin borough_N = mkN "stad" "städer" ;
lin well_A = mkA "frisk" | mkA "bra" ; -- SaldoWN -- comment=6
lin suspicion_N = mkN "misstanke" utrum | mkN "misstanke" utrum ; -- SaldoWN -- comment=7
lin portrait_N = mkN "porträtt" neutrum | mkN "porträtt" neutrum ; -- SaldoWN -- comment=6
lin local_N = mkN "lokal" "lokaler" ;
lin jew_N = mkN "jude" utrum;
lin fragment_N = mkN "fragment" neutrum | mkN "splittra" ; -- SaldoWN -- comment=11
lin revolutionary_A = mkA "revolutionär" | mkA "omstörtande" ; -- SaldoWN -- comment=3
lin evaluate_V2 = mkV2 "utvärdera" ;
lin evaluate_V = mkV "utvärderar" ;
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
lin eliminate_V2 = dirV2 (partV (mkV "gallrar")"ut");
lin interior_N = mkN "interiör" "interiörer" ; -- comment=4
lin intellectual_A = mkA "intellektuell" ; -- comment=3
lin established_A = variants{} ;
lin voter_N = mkN "väljare" utrum | mkN "väljare" utrum ; -- SaldoWN
lin garage_N = mkN "garage" "garaget" "garage" "garagen" ; -- SaldoWN
lin era_N = mkN "tideräkning" ;
lin pregnant_A = mkA "gravid" | mkA "ödesdiger" ; -- SaldoWN -- comment=10
lin plot_N = mkN "sammansvärjning" ;
lin greet_V2 = dirV2 (partV (mkV "hälsar")"på");
lin electrical_A = mkA "elektrisk" ;
lin lie_N = mkN "lögn" "lögner" ; -- SaldoWN
lin disorder_N = mkN "oordning" | mkN "orolighet" "oroligheter" ; -- SaldoWN -- comment=9
lin formally_Adv = variants{} ;
lin excuse_N = mkN "undanflykt" "undanflykter" | mkN "ursäkt" "ursäkter" ; -- SaldoWN -- comment=8
lin socialist_A = mkA "socialistisk" ; -- SaldoWN
lin cancel_V2 = dirV2 (partV (mkV "stämplar")"ut"); -- comment=2
lin cancel_V = mkV "stämplar" ; -- comment=16
lin harm_N = mkN "skada" ; -- SaldoWN
lin excess_N = mkN "överflöd" neutrum | mkN "överskridande" ; -- SaldoWN -- comment=5
lin exact_A = mkA "precis" | mkA "noggrann" "noggrant" ; -- SaldoWN -- comment=6
lin oblige_V2V = variants {} ;
lin oblige_V2 = variants {} ;
lin accountant_N = mkN "kamrer" "kamrerer" ; -- SaldoWN
lin mutual_A = mkA "ömsesidig" ; -- SaldoWN
lin fat_N = L.fat_N ;
lin volunteer_N = variants{} ;
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
lin processor_N = variants {} ;
lin cotton_N = mkN "bomull" ; -- SaldoWN
lin reverse_V2 = dirV2 (partV (mkV "backar")"ur");
lin reverse_V = mkV "ändrar" ; -- comment=10
lin hesitate_VV = mkVV (mkV "tvekar") | mkVV (mkV "dröja"); -- status=guess, src=wikt status=guess, src=wikt
lin hesitate_V = mkV "tvekar" ; -- comment=3
lin professor_N = mkN "professor" "professorer" ;
lin admire_V2 = variants {} ;
lin namely_Adv = variants {} ;
lin electoral_A = mkA "val" | mkA "valmanna" | mkA "valmans" | mkA "elektors" | mkA "kurfurstlig" ; -- status=guess status=guess status=guess status=guess status=guess
lin delight_N = mkN "glädje" utrum; -- comment=6
lin urgent_A = mkA "enträgen" "enträget" ; -- comment=9
lin prompt_V2V = variants {} ;
lin prompt_V2 = dirV2 (partV (mkV "komma" "kom" "kommit")"vid"); -- comment=5
lin mate_N = mkN "kompis" ; -- comment=8
lin mate_2_N = variants {} ;
lin mate_1_N = mkN "kompis" ; -- comment=8
lin exposure_N = mkN "utsatthet" | mkN "exponering" ; -- SaldoWN -- comment=2
lin server_N = mkN "servitör" "servitörer" | mkN "server" ; -- SaldoWN
lin distinctive_A = mkA "utmärkande" ; -- comment=7
lin marginal_A = mkA "marginell" ;
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
lin yield_V2 = mkV2 "producera" ; --
lin yield_V = mkV "överlämnar" ; -- comment=16
lin discount_N = mkN "rabatt" "rabatter" ; -- SaldoWN
lin above_A = mkA "ovanstående" ; -- comment=2
lin uncle_N = mkN "morbror" "morbröder" | mkN "farbror" "farbröder" ; -- SaldoWN -- comment=2
lin audit_N = mkN "revision" "revisioner" ;
lin advertisement_N = mkN "annons" "annonser" ; -- comment=5
lin explosion_N = mkN "explosion" "explosioner" ; -- SaldoWN
lin contrary_A = mkA "motsatt" ; -- comment=5
lin tribunal_N = mkN "tribunal" "tribunaler" ; -- comment=5
lin swallow_V2 = mkV2 "svälja" "svalde" "svalt" | mkV2 (mkV "svälja") ; -- SaldoWN -- status=guess, src=wikt
lin swallow_V = mkV "svälja" "svalde" "svalt" ; -- SaldoWN
lin typically_Adv = mkAdv "typiskt" ;
lin fun_A = variants{} ;
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
lin devise_V2 = variants {} ;
lin determined_A = variants{} ;
lin brush_V2 = dirV2 (partV (mkV "borstar")"av"); -- comment=4
lin brush_V = mkV "vidröra" "vidrörde" "vidrört" ; -- comment=6
lin adjustment_N = mkN "ordnande" ; -- comment=12
lin controversial_A = mkA "omstridd" | mkA "kontroversiell" ; -- SaldoWN -- comment=4
lin organic_A = mkA "organisk" | mkA "strukturell" ; -- SaldoWN -- comment=6
lin escape_N = mkN "rymning" ; -- comment=5
lin thoroughly_Adv = variants{} ;
lin interface_N = mkN "gränssnitt" neutrum ; -- SaldoWN
lin historic_A = mkA "historisk" ;
lin collapse_N = mkN "sammanstörtande" ; -- comment=12
lin temple_N = mkN "tinning" ; -- SaldoWN
lin shade_N = mkN "nyans" "nyanser" | mkN "skugga" ; -- SaldoWN -- comment=11
lin craft_N = mkN "hantverk" neutrum | mkN "skrå" "skråt" "skrån" "skråen" ; -- SaldoWN -- comment=6
lin nursery_N = mkN "plantskola" ; -- SaldoWN
lin piano_N = mkN "piano" "pianot" "pianon" "pianona" ;
lin desirable_A = mkA "begärlig" | mkA "önskvärd" "önskvärt" ; -- SaldoWN -- comment=4
lin assurance_N = mkN "försäkran" "försäkran" "försäkringar" "försäkringarna" | mkN "visshet" "vissheter" ; -- SaldoWN -- comment=10
lin jurisdiction_N = mkN "jurisdiktion" "jurisdiktioner" ; -- SaldoWN
lin advertise_V2 = mkV2 (mkV (mkV "göra" "gjorde" "gjort") "reklam") (mkPrep "för");
lin advertise_V = mkV "annonserar" ; -- comment=3
lin bay_N = mkN "bukt" "bukter" | mkN "ylande" ; -- SaldoWN -- comment=10
lin specification_N = mkN "specifikation" "specifikationer" ;
lin disability_N = mkN "handikapp" neutrum | mkN "oduglighet" ; -- SaldoWN -- comment=6
lin presidential_A = mkA "presidentmässig" ; -- SaldoWN
lin arrest_N = mkN "avbrott" neutrum; -- comment=8
lin unexpected_A = compoundA (regA "oväntad"); -- comment=2
lin switch_N = mkN "strömbrytare" utrum | mkN "ändring" ; -- SaldoWN -- comment=7
lin penny_N = mkN "öre" | mkN "ettöring" ; -- SaldoWN
lin respect_V2 = mkV2 (mkV (mkV "att") "respektera"); -- status=guess, src=wikt
lin celebration_N = mkN "firande" ; -- SaldoWN
lin gross_A = mkA "total" ; -- comment=11
lin aid_V2 = variants {} ;
lin aid_V = mkV "underlättar" ; -- comment=4
lin superb_A = mkA "superb" ; -- comment=2
lin process_V2 = variants {} ;
lin process_V = mkV "framkallar" ; -- comment=6
lin innocent_A = mkA "oskyldig" | mkA "troskyldig" ; -- SaldoWN -- comment=4
lin leap_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin leap_V = mkV "hoppar" ;
lin colony_N = mkN "koloni" "kolonier" ; -- SaldoWN
lin wound_N = mkN "sår" neutrum | mkN "skada" ; -- SaldoWN -- comment=4
lin hardware_N = mkN "hårdvara" | mkN "datorutrustning" ; -- SaldoWN -- comment=3
lin satellite_N = mkN "satellit" "satelliter" ; -- SaldoWN
lin float_VA = mkVA (mkV "flyta" "flöt" "flutit"); -- status=guess, src=wikt
lin float_V2 = dirV2 (partV (mkV "svävar")"ut");
lin float_V = L.float_V;
lin bible_N = mkN "bibel" ; -- SaldoWN
lin statistical_A = mkA "statistisk" ; -- SaldoWN
lin marked_A = compoundA (regA "markerad"); -- comment=3
lin hire_VS = mkVS (mkV "anställa"); -- status=guess, src=wikt
lin hire_V2V = mkV2V (mkV "anställa"); -- status=guess, src=wikt
lin hire_V2 = mkV2 (mkV "anställa"); -- status=guess, src=wikt
lin hire_V = mkV "hyra" "hyrde" "hyrt" ; -- comment=7
lin cathedral_N = mkN "katedral" "katedraler" | mkN "domkyrka" ; -- SaldoWN -- comment=4
lin motive_N = mkN "skäl" neutrum; -- comment=6
lin correct_VS = mkVS (mkV "rätta") | mkVS (mkV "korrigerar"); -- status=guess, src=wikt status=guess, src=wikt
lin correct_V2 = dirV2 (partV (mkV "rättar")"till");
lin correct_V = mkV "tillrättavisar" ; -- comment=8
lin gastric_A = mkA "gastrisk" ;
lin raid_N = mkN "räd" "räder" ; -- SaldoWN
lin comply_V2 = variants {} ;
lin comply_V = mkV "lyda" "lydde" "lytt" ;
lin accommodate_V2 = mkV2 (mkV "förse") | mkV2 (mkV "tillgodose" "tillgodosåg" "tillgodosett"); -- status=guess, src=wikt status=guess, src=wikt
lin accommodate_V = mkV "rymmer" ; -- comment=5
lin mutter_V2 = variants {} ;
lin mutter_V = mkV "muttrar" ; -- comment=3
lin induce_V2V = variants {} ;
lin induce_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till");
lin trap_V2 = dirV2 (partV (mkV "lurar")"till"); -- comment=2
lin trap_V = mkV "snärja" "snärjde" "snärjt" ; -- comment=5
lin invasion_N = mkN "invasion" "invasioner" ; -- SaldoWN
lin humour_N = mkN "humör" neutrum; -- comment=3
lin bulk_N = mkN "omfång" neutrum; -- comment=4
lin traditionally_Adv = variants{} ;
lin commission_V2V = variants {} ;
lin commission_V2 = variants {} ;
lin upstairs_Adv = variants {} ;
lin translate_V2 = mkV2 (mkV "översätta" "översätter" "översätt" "översatte" "översatt" "översatt") ;
lin translate_V = mkV "översätta" "översätter" "översätt" "översatte" "översatt" "översatt" ;
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
lin fiction_N = mkN "skönlitteratur" "skönlitteraturer" ;
lin learning_N = mkN "lärdom" ; -- comment=2
lin statute_N = variants {} ;
lin reluctant_A = mkA "motvillig" ; -- comment=2
lin overlook_V2 = mkV2 "förbise" "förbisåg" "förbisett" | mkV2 (mkV (mkV "ha") "överseende med") ; -- SaldoWN -- status=guess, src=wikt
lin junction_N = mkN "järnvägsknut" | mkN "knutpunkt" "knutpunkter" ; -- SaldoWN -- comment=2
lin necessity_N = mkN "nödvändighet" "nödvändigheter" ; -- comment=3
lin nearby_A = mkA "närbelägen" "närbeläget" ;
lin experienced_A = mkA "erfaren" "erfaret" ; -- SaldoWN
lin lorry_N = mkN "lastbil" ; -- comment=2
lin exclusive_A = mkA "exklusiv" | compoundA (regA "odelad") ; -- SaldoWN -- comment=10
lin graphics_N = mkN "grafik" ; -- SaldoWN
lin stimulate_V2 = mkV2 (mkV (mkV "ge") "näring åt") | mkV2 (mkV (mkV "pigga") "upp") | mkV2 (mkV "stimulerar") | mkV2 (mkV "väcka"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin warmth_N = mkN "värme" ; -- comment=2
lin therapy_N = mkN "terapi" "terapier" ; -- SaldoWN
lin convenient_A = mkA "bekväm" | mkA "lätthanterlig" ; -- SaldoWN -- comment=7
lin cinema_N = mkN "biograf" "biografer" ; -- SaldoWN
lin domain_N = mkN "domän" "domäner" ; -- comment=6
lin tournament_N = mkN "turnering" ; -- SaldoWN
lin doctrine_N = mkN "doktrin" "doktriner" ;
lin sheer_A = variants {} ;
lin proposition_N = mkN "sats" "satser" | mkN "förslag" neutrum ; -- SaldoWN -- comment=2
lin grip_N = mkN "väggrepp" neutrum | mkN "scenarbetare" utrum ; -- SaldoWN -- comment=8
lin widow_N = mkN "änka" ; -- SaldoWN
lin discrimination_N = mkN "diskriminering" | mkN "omdöme" ; -- SaldoWN -- comment=3
lin bloody_Adv = mkAdv "jävligt" ; -- comment=2
lin ruling_A = variants{} ;
lin fit_N = mkN "konvulsion" "konvulsioner" | mkN "passform" ; -- SaldoWN -- comment=8
lin nonetheless_Adv = variants{} ;
lin myth_N = mkN "myt" "myter" | mkN "mytologi" "mytologier" ; -- SaldoWN -- comment=6
lin episode_N = mkN "avsnitt" neutrum | mkN "episod" "episoder" ;
lin drift_V2 = mkV2 "driva" "drev" "drivit" ; -- SaldoWN
lin drift_V = mkV "driva" "drev" "drivit" ; -- SaldoWN
lin assert_VS = variants {} ;
lin assert_V2 = variants {} ;
lin assert_V = mkV "kräver" ; -- comment=5
lin terrace_N = mkN "altan" "altaner" | mkN "terrass" "terrasser" ; -- SaldoWN -- comment=4
lin uncertain_A = mkA "oviss" ; -- comment=2
lin twist_V2 = mkV2 "vrida" "vred" "vridit" | dirV2 (partV (mkV "skruvar")"till") ; -- SaldoWN -- comment=6
lin twist_V = mkV "vrida" "vred" "vridit" | mkV "kröker" ; -- SaldoWN -- comment=7
lin insight_N = mkN "insikt" "insikter" ; -- SaldoWN
lin undermine_V2 = mkV2 (mkV "underminerar"); -- status=guess, src=wikt
lin tragedy_N = mkN "tragedi" "tragedier" | mkN "tragik" ; -- SaldoWN -- comment=2
lin enforce_V2 = variants {} ;
lin criticize_V2 = variants {} ;
lin criticize_V = mkV "kritiserar" ; -- comment=6
lin march_V2 = dirV2 (partV (mkV "marscherar")"ut"); -- comment=7
lin march_V = mkV "marscherar" ; -- comment=6
lin leaflet_N = mkN "broschyr" "broschyrer" | mkN "flygblad" neutrum ; -- SaldoWN -- comment=4
lin fellow_A = variants{} ;
lin object_V2 = mkV2 (mkV "invända") | mkV2 (mkV (mkV "motsätta") "sig") | mkV2 (mkV "protesterar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin object_V = mkV "protesterar" ; -- comment=3
lin pond_N = mkN "damm" neutrum; -- comment=4
lin adventure_N = mkN "vågspel" "vågspelet" "vågspel" "vågspelen" | mkN "äventyr" neutrum ; -- SaldoWN -- comment=5
lin diplomatic_A = mkA "diplomatisk" ; -- SaldoWN = mkA "diplomatisk" ;
lin mixed_A = variants{} ;
lin rebel_N = mkN "rebell" "rebeller" | mkN "tredska" ; -- SaldoWN -- comment=3
lin equity_N = mkN "stamaktie" "stamaktier" ; -- comment=3
lin literally_Adv = variants{} ;
lin magnificent_A = mkA "pampig" ; -- comment=8
lin loyalty_N = mkN "lojalitet" "lojaliteter" ; -- SaldoWN
lin tremendous_A = mkA "kolossal" ; -- comment=3
lin airline_N = mkN "flyg" neutrum | mkN "flygbolag" neutrum ; -- SaldoWN = mkN "flyg" neutrum ;
lin shore_N = mkN "kust" "kuster" ; -- comment=5
lin restoration_N = mkN "restaurering" ; -- SaldoWN
lin physically_Adv = variants{} ;
lin render_V2 = variants {} ;
lin institutional_A = variants {} ;
lin emphasize_VS = mkVS (mkV "understryka" "underströk" "understrukit");
lin emphasize_V2 = mkV2 (mkV "understryka" "underströk" "understrukit");
lin mess_N = mkN "sörja" ; -- comment=14
lin commander_N = mkN "kommendörkapten" "kommendörkaptener" ; -- comment=4
lin straightforward_A = mkA "rättfram" "rättframt" "rättframma" "rättframma" "rättframmare" "rättframmast" "rättframmaste" ;
lin singer_N = mkN "sångare" utrum | mkN "sångare" utrum ;
lin squeeze_V2 = L.squeeze_V2;
lin squeeze_V = mkV "pressar" ; -- comment=8
lin full_time_A = variants {} ;
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
lin specially_Adv = variants{} ;
lin biological_A = mkA "biologisk" ;
lin forgive_V2 = mkV2 (mkV "förlåta"); -- status=guess, src=wikt
lin forgive_V = mkV "förlåta" "förlät" "förlåtit" ;
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
lin strictly_Adv = variants{} ;
lin desperately_Adv = variants{} ;
lin await_V2 = dirV2 (partV (mkV "väntar")"ut");
lin coverage_N = mkN "försäkringsskydd" neutrum | mkN "täckning" ; -- SaldoWN -- comment=5
lin wildlife_N = mkN "djurliv" neutrum | (mkN "vilt" neutrum) | (mkN "natur") | (mkN "fauna") | (mkN "flora") ; -- SaldoWN -- status=guess status=guess status=guess status=guess
lin indicator_N = mkN "mätare" utrum; -- comment=2
lin lightly_Adv = variants{} ;
lin hierarchy_N = mkN "hierarki" "hierarkier" ; -- SaldoWN
lin evolve_V2 = variants {} ;
lin evolve_V = mkV "utvecklar" ;
lin mechanical_A = mkA "mekanisk" ; -- SaldoWN
lin expert_A = mkA "sakkunnig" ; -- comment=4
lin creditor_N = mkN "borgenär" "borgenärer" ; -- SaldoWN
lin capitalist_N = mkN "kapitalist" "kapitalister" ;
lin essence_N = mkN "parfym" "parfymer" | mkN "väsen" neutrum ; -- SaldoWN -- comment=10
lin compose_V2 = dirV2 (partV (mkV "ordnar") "om");
lin compose_V = mkV "utgöra" "utgjorde" "utgjort" ; -- comment=10
lin mentally_Adv = variants{} ;
lin gaze_N = mkN "blick" ; -- SaldoWN
lin seminar_N = mkN "seminarium" "seminariumet" "seminarier" "seminarierna" ; -- SaldoWN
lin target_V2V = variants {} ;
lin target_V2 = variants {} ;
lin label_V3 = mkV3 (mkV "betecknar") | mkV3 (mkV "etiketterar"); -- status=guess, src=wikt status=guess, src=wikt
lin label_V2A = mkV2A (mkV "betecknar") | mkV2A (mkV "etiketterar"); -- status=guess, src=wikt status=guess, src=wikt
lin label_V2 = mkV2 (mkV "betecknar") | mkV2 (mkV "etiketterar"); -- status=guess, src=wikt status=guess, src=wikt
lin label_V = mkV "etiketterar" ; -- comment=3
lin fig_N = mkN "fikon" neutrum | mkN "fikon" neutrum ; -- SaldoWN
lin continent_N = mkN "kontinent" "kontinenter" ; -- comment=3
lin chap_N = mkN "skreva" | mkN "spricka" ; -- SaldoWN -- comment=5
lin flexibility_N = mkN "flexibilitet" ; -- comment=3
lin verse_N = mkN "vers" ; -- comment=2
lin minute_A = mkA "minimal" ; -- comment=2
lin whisky_N = variants {} ;
lin equivalent_A = mkA "motsvarande" ; -- comment=3
lin recruit_V2 = variants {} ;
lin recruit_V = mkV "värvar" ; -- comment=2
lin echo_V2 = mkV2 (mkV "ekar"); -- status=guess, src=wikt
lin echo_V = mkV "upprepar" ; -- comment=6
lin unfair_A = mkA "ojust" "ojust" | mkA "orättvis" ; -- SaldoWN -- comment=2
lin launch_N = mkN "motorbåt" ; -- comment=3
lin cupboard_N = mkN "skåp" neutrum ; -- SaldoWN -- comment=3
lin bush_N = mkN "buske" utrum | mkN "rävsvans" ; -- SaldoWN -- comment=7
lin shortage_N = mkN "svält" | mkN "brist" "brister" ; -- SaldoWN -- comment=3
lin prominent_A = mkA "prominent" "prominent" ;
lin merger_N = mkN "fusion" ; -- comment=4
lin command_V2 = variants {} ;
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
lin debate_V2 = dirV2 (partV (mkV "funderar")"ut");
lin debate_V = mkV "funderar" ; -- comment=8
lin educate_V2 = mkV2 (mkV "utbildar"); -- status=guess, src=wikt
lin separation_N = mkN "separation" "separationer" | mkN "skilsmässa" ; -- SaldoWN -- comment=2
lin productivity_N = mkN "produktivitet" "produktiviteter" ;
lin initiate_V2 = mkV2 (mkV "initierar"); -- status=guess, src=wikt
lin probability_N = mkN "sannolikhet" "sannolikheter" | mkN "trolighet" ; -- SaldoWN
lin virus_N = mkN "virus" neutrum | mkN "virus" neutrum ; -- SaldoWN
lin reporter_N = variants{} ;
lin fool_N = mkN "narr" ; -- SaldoWN
lin pop_V2 = mkV2 "smälla" "small" "smäll" ; -- SaldoWN
lin pop_V = mkV "smälla" "small" "smäll" ; -- SaldoWN
lin capitalism_N = mkN "kapitalism" "kapitalismer" ; -- SaldoWN
lin painful_A = mkA "plågsam" "plågsamt" "plågsamma" "plågsamma" "plågsammare" "plågsammast" "plågsammaste" | mkA "smärtsam" "smärtsamt" "smärtsamma" "smärtsamma" "smärtsammare" "smärtsammast" "smärtsammaste" ; -- SaldoWN -- comment=5
lin correctly_Adv = variants{} ;
lin complex_N = mkN "komplex" neutrum; -- comment=3
lin rumour_N = mkN "rykte" ; -- SaldoWN
lin imperial_A = mkA "kejserlig" ; -- SaldoWN
lin justification_N = mkN "berättigande" ; -- SaldoWN
lin availability_N = mkN "tillgänglighet" ; -- comment=3
lin spectacular_A = mkA "spektakulär" ; -- comment=4
lin remain_N = variants{} ;
lin ocean_N = mkN "ocean" "oceaner" | mkN "världshav" neutrum ; -- SaldoWN -- comment=3
lin cliff_N = mkN "klippa" | mkN "berg" neutrum ; -- SaldoWN -- comment=5
lin sociology_N = mkN "sociologi" ; -- SaldoWN
lin sadly_Adv = variants{} ;
lin missile_N = mkN "projektil" "projektiler" ; -- SaldoWN
lin situate_V2 = variants {} ;
lin artificial_A = mkA "artificiell" | mkA "konstgjord" "konstgjort" ; -- SaldoWN -- comment=5
lin apartment_N = L.apartment_N;
lin provoke_V2 = mkV2 (mkV "provocerar"); -- status=guess, src=wikt
lin oral_A = mkA "muntlig" ; -- SaldoWN
lin maximum_N = mkN "maximum" neutrum | mkN "maximum" neutrum ; -- SaldoWN
lin angel_N = mkN "ängel" ; -- SaldoWN
lin spare_A = mkA "ledig" ;
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
lin part_time_A = variants {} ;
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
lin density_N = mkN "densitet" "densiteter" | mkN "täthet" ;
lin working_class_A = variants {} ;
lin legislative_A = mkA "legislativ" ; -- SaldoWN
lin hint_N = mkN "vink" ; -- comment=6
lin shower_N = mkN "skur" | mkN "dusch" ; -- SaldoWN
lin current_N = mkN "ström" "strömmen" "strömmar" "strömmarna" | mkN "rådande" ; -- SaldoWN -- comment=10
lin succession_N = mkN "tronföljd" "tronföljder" ; -- comment=6
lin nasty_A = mkA "svår" ; -- comment=19
lin duration_N = mkN "varaktighet" "varaktigheter" ; -- SaldoWN
lin desert_N = mkN "öken" ; -- SaldoWN
lin receipt_N = mkN "kvitto" "kvittot" "kvitton" "kvittona" | mkN "mottagande" ; -- SaldoWN -- comment=6
lin native_A = mkA "infödd" ;
lin chapel_N = mkN "kapell" neutrum; -- comment=5
lin amazing_A = mkA "fantastisk" ;
lin hopefully_Adv = variants{} ;
lin fleet_N = mkN "flotta" ; -- SaldoWN
lin comparable_A = mkA "jämförbar" | mkA "likvärdig" ; -- SaldoWN -- comment=3
lin oxygen_N = mkN "syre" ; -- SaldoWN
lin installation_N = mkN "installation" "installationer" ;
lin developer_N = mkN "exploatör" "exploatörer" ;
lin disadvantage_N = mkN "nackdel" "nackdelen" "nackdelar" "nackdelarna" ; -- SaldoWN
lin recipe_N = mkN "recept" neutrum;
lin crystal_N = mkN "kristall" "kristaller" ; -- SaldoWN
lin modification_N = mkN "modifiering" ; -- comment=2
lin schedule_V2V = mkV2V (mkV "inplanera"); -- status=guess, src=wikt
lin schedule_V2 = dirV2 (partV (mkV "listar")"ut");
lin schedule_V = mkV "listar" ; -- comment=2
lin midnight_N = mkN "midnatt" ; -- SaldoWN
lin successive_A = mkA "successiv" ;
lin formerly_Adv = mkAdv "förr" ;
lin loud_A = mkA "högljudd" | mkA "hög" "högre" "högst" ; -- SaldoWN -- comment=7
lin value_V2 = mkV2 (mkV "värdera"); -- status=guess, src=wikt
lin value_V = mkV "värderar" ; -- comment=3
lin physics_N = mkN "fysik" ; -- SaldoWN
lin truck_N = mkN "truck" ; -- SaldoWN
lin stroke_N = mkN "stroke" "stroket" "stroke" "stroken" | mkN "årtag" neutrum ; -- SaldoWN = mkN "stroke" "stroken" "strokes" "strokesen" ; -- comment=35
lin kiss_N = mkN "kyss" ; -- comment=2
lin envelope_N = mkN "kuvert" neutrum ; -- SaldoWN -- comment=5
lin speculation_N = mkN "spekulation" "spekulationer" ;
lin canal_N = mkN "kanal" "kanaler" ;
lin unionist_N = variants {} ;
lin directory_N = mkN "register" neutrum ; -- SaldoWN -- comment=3
lin receiver_N = mkN "mottagare" utrum; -- comment=2
lin isolation_N = mkN "isolering" ; -- SaldoWN
lin fade_V2 = dirV2 (partV (mkV "tynar")"av");
lin fade_V = mkV "bleknar" ; -- comment=6
lin chemistry_N = mkN "kemi" ; -- SaldoWN
lin unnecessary_A = mkA "onödig" ; -- SaldoWN
lin hit_N = mkN "slå" | mkN "mord" neutrum ; -- SaldoWN -- comment=13
lin defender_N = variants{} ;
lin stance_N = mkN "hållning" ;
lin sin_N = mkN "synd" "synder" ; -- SaldoWN
lin realistic_A = mkA "realistisk" ; -- SaldoWN
lin socialist_N = mkN "socialist" "socialister" ; -- SaldoWN
lin subsidy_N = mkN "subvention" "subventioner" ; -- comment=4
lin content_A = mkA "nöjd" "nöjt" ; -- SaldoWN
lin toy_N = mkN "leksak" "leksaker" ; -- SaldoWN
lin darling_N = mkN "älskling" ; -- comment=2
lin decent_A = mkA "anständig" ; -- comment=13
lin liberty_N = mkN "frihet" "friheter" ; -- SaldoWN
lin forever_Adv = mkAdv "alltid" ;
lin skirt_N = mkN "kjol" | mkN "skört" neutrum ; -- SaldoWN -- comment=5
lin coordinate_V2 = mkV2 (mkV "koordinerar"); -- status=guess, src=wikt
lin coordinate_V = mkV "koordinerar" ; -- comment=2
lin tactic_N = mkN "taktik" "taktiker" ; -- SaldoWN
lin influential_A = mkA "inflytelserik" ; -- SaldoWN
lin import_V2 = mkV2 (mkV "importerar") | mkV2 (mkV (mkV "föra") "in"); -- status=guess, src=wikt status=guess, src=wikt
lin accent_N = mkN "accent" "accenter" | mkN "tonvikt" ; -- SaldoWN -- comment=8
lin compound_N = mkN "förening" | mkN "sammansättning" ; -- SaldoWN -- comment=3
lin bastard_N = mkN "bastard" "bastarder" ; -- comment=8
lin ingredient_N = mkN "ingrediens" "ingredienser" ; -- SaldoWN
lin dull_A = L.dull_A ;
lin cater_V = variants {} ;
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
lin export_V = mkV "exporterar" ;
lin forth_Adv = mkAdv "framåt" ; -- comment=4
lin lamp_N = L.lamp_N ;
lin allege_VS = mkV "förege" "föreger" "förege" "föregav" "föregett" "föregiven" | mkVS (mkV "påstå") ; -- SaldoWN -- status=guess, src=wikt
lin allege_V2V = mkV2V "förege" "föreger" "förege" "föregav" "föregett" "föregiven" | mkV2V (mkV "påstå") ; -- SaldoWN -- status=guess, src=wikt
lin allege_V2 = mkV2 "förege" "föreger" "förege" "föregav" "föregett" "föregiven" | mkV2 (mkV "påstå") ; -- SaldoWN -- status=guess, src=wikt
lin pavement_N = mkN "trottoar" "trottoarer" ; -- SaldoWN
lin brand_N = mkN "märke" | mkN "svärd" neutrum ; -- SaldoWN -- comment=7
lin constable_N = mkN "ståthållare" utrum; -- comment=4
lin compromise_N = mkN "kompromiss" "kompromisser" | mkN "äventyrande" ; -- SaldoWN -- comment=3
lin flag_N = mkN "flagga" | mkN "stenhäll" ; -- SaldoWN -- comment=8
lin filter_N = mkN "filter" neutrum | mkN "sil" ; -- SaldoWN -- comment=2
lin reign_N = mkN "styre" | mkN "regering" ; -- SaldoWN = mkN "styre" ; -- status=guess
lin execute_V2 = dirV2 (partV (mkV "spelar")"in");
lin pity_N = mkN "medlidande" | mkN "skada" ; -- SaldoWN -- comment=4
lin merit_N = mkN "förtjänst" "förtjänster" ; -- SaldoWN
lin diagram_N = mkN "diagram" "diagrammet" "diagram" "diagrammen" ; -- SaldoWN
lin wool_N = mkN "ylle" | mkN "ull" ; -- SaldoWN -- comment=3
lin organism_N = mkN "organism" "organismer" ;
lin elegant_A = mkA "elegant" "elegant" | mkA "fyndig" ;
lin red_N = mkN "rodnad" "rodnader" | mkN "röd" | mkN "rött" ; -- SaldoWN -- status=guess status=guess
lin undertaking_N = mkN "åtagande" ; -- comment=8
lin lesser_A = variants {} ;
lin reach_N = mkN "sträcka" ; -- comment=13
lin marvellous_A = mkA "underbar" ;
lin improved_A = variants{} ;
lin locally_Adv = variants{} ;
lin entity_N = variants {} ;
lin rape_N = mkN "våldtäkt" "våldtäkter" ; -- comment=5
lin secure_A = mkA "trygg" ; -- comment=4
lin descend_V2 = variants {} ;
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
lin like_Subj = variants{} ;
lin instinct_N = mkN "instinkt" "instinkter" ; -- SaldoWN
lin teenager_N = mkN "tonåring" ; -- SaldoWN
lin lonely_A = mkA "ensam" "ensamt" "ensamma" "ensamma" "ensammare" "ensammast" "ensammaste" | mkA "övergiven" "övergivet" ; -- SaldoWN -- comment=6
lin residence_N = mkN "residens" neutrum | mkN "uppehåll" neutrum ; -- SaldoWN -- comment=4
lin radiation_N = mkN "strålning" ; -- SaldoWN
lin extract_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin concession_N = mkN "eftergift" "eftergifter" | mkN "förmån" "förmåner" ; -- SaldoWN -- comment=5
lin autonomy_N = mkN "självständighet" "självständigheter" | mkN "autonomi" ; -- SaldoWN -- comment=2
lin norm_N = mkN "norm" "normer" ; -- SaldoWN
lin musician_N = mkN "musiker" "musikern" "musiker" "musikerna" ;
lin graduate_N = mkN "alumn" "alumner" | mkN "akademiker" "akademikern" "akademiker" "akademikerna" ; -- SaldoWN -- comment=2
lin glory_N = mkN "ära" ; -- SaldoWN
lin bear_N = mkN "björn" | mkN "vila" ; -- SaldoWN -- comment=6
lin persist_V = mkV "framhärdar" ; -- comment=4
lin rescue_V2 = mkV2 (mkV "rädda"); -- status=guess, src=wikt
lin equip_V2 = mkV2 (mkV "utrustar"); -- status=guess, src=wikt
lin partial_A = mkA "partisk" ;
lin officially_Adv = mkAdv "officiellt" ;
lin capability_N = mkN "kompetens" "kompetenser" ; -- comment=3
lin worry_N = mkN "bekymmer" "bekymmer" ; -- comment=5
lin liberation_N = mkN "befrielse" "befrielser" ; -- comment=4
lin hunt_V2 = L.hunt_V2;
lin hunt_V = mkV "jagar" ;
lin daily_Adv = mkAdv "dagligen" ;
lin heel_N = mkN "häl" | mkN "slut" neutrum ; -- SaldoWN -- comment=7
lin contract_V2V = mkV2V (mkV (mkV "smittas") "av"); -- status=guess, src=wikt
lin contract_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till");
lin contract_V = mkV "inskränker" ; -- comment=9
lin update_V2 = mkV2 (mkV "uppdaterar"); -- status=guess, src=wikt
lin assign_V2V = variants {} ;
lin assign_V2 = variants {} ;
lin spring_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin spring_V = mkV "hoppar" ; -- comment=3
lin single_N = mkN "singel" ; -- comment=2
lin commons_N = variants {} ;
lin weekly_A = mkA "veckovis" ;
lin stretch_N = mkN "sträcka" ;
lin pregnancy_N = mkN "graviditet" "graviditeter" ; -- comment=3
lin happily_Adv = variants{} ;
lin spectrum_N = mkN "spektrum" neutrum | mkN "spektrum" neutrum ; -- SaldoWN -- comment=2
lin interfere_V = mkV "inskrida" "inskred" "inskridit" ; -- comment=2
lin suicide_N = mkN "självmord" neutrum | mkN "självmord" neutrum ; -- SaldoWN
lin panic_N = mkN "panik" ; -- SaldoWN
lin invent_V2 = variants {} ;
lin invent_V = mkV "uppfinna" "uppfann" "uppfunnit" ;
lin intensive_A = mkA "intensiv" ;
lin damp_A = mkA "fuktig" ;
lin simultaneously_Adv = variants{} ;
lin giant_N = mkN "jätte" utrum ; -- SaldoWN -- comment=5
lin casual_A = mkA "tillfällig" ; -- comment=8
lin sphere_N = mkN "sfär" "sfärer" ; -- SaldoWN
lin precious_A = mkA "värdefull" ; -- comment=2
lin sword_N = mkN "svärd" neutrum | mkN "svärd" neutrum ; -- SaldoWN
lin envisage_V2 = variants {} ;
lin bean_N = mkN "böna" ; -- SaldoWN
lin time_V2 = mkV2 (mkV "tajma" | mkV "tidsinställa"); -- status=guess, src=wikt status=guess, src=wikt
lin crazy_A = mkA "galen" "galet" ; -- comment=8
lin changing_A = variants{} ;
lin primary_N = (mkN "grundskola") | mkN "lågstadie" ; -- status=guess status=guess
lin concede_VS = mkV "medge" "medger" "medge" "medgav" "medgett" "medgiven" | mkVS (mkV "erkänna") | mkVS (mkV "tillstå") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin concede_V2 = mkV2 "medge" "medger" "medge" "medgav" "medgett" "medgiven" | mkV2 (mkV "erkänna") | mkV2 (mkV "tillstå") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin concede_V = mkV "medge" "medger" "medge" "medgav" "medgett" "medgiven" ; -- SaldoWN
lin besides_Adv = mkAdv "förresten" ; -- comment=4
lin unite_V2 = dirV2 (partV (mkV "blandar")"ut"); -- comment=4
lin unite_V = mkV "förenar" ; -- comment=6
lin severely_Adv = variants{} ;
lin separately_Adv = variants{} ;
lin instruct_V2 = variants {} ;
lin insert_V2 = variants {} ;
lin go_N = mkN "tur" ; -- comment=12
lin exhibit_V2 = variants {} ;
lin brave_A = mkA "modig" | mkA "utmärkt" "utmärkt" ; -- SaldoWN -- comment=7
lin tutor_N = mkN "handledare" utrum | mkN "privatlärare" utrum ; -- SaldoWN -- comment=3
lin tune_N = mkN "låt" | mkN "stämma" ; -- SaldoWN = mkN "låt" ; -- comment=7
lin debut_N = mkN "debut" "debuter" ;
lin debut_2_N = variants {} ;
lin debut_1_N = mkN "debut" "debuter" ;
lin continued_A = variants{} ;
lin bid_V2 = dirV2 (partV (mkV "hälsar")"på");
lin bid_V = mkV "säga" "sade" "sagt" ; -- comment=5
lin incidence_N = mkN "förekomst" "förekomster" ;
lin downstairs_Adv = variants {} ;
lin cafe_N = mkN "kafé" "kafét" "kaféer" "kaféerna" | mkN "café" "cafét" "caféer" "caféerna" ; -- SaldoWN -- comment=7
lin regret_VS = mkVS (mkV "beklagar") | mkVS (mkV "ångra"); -- status=guess, src=wikt status=guess, src=wikt
lin regret_V2 = mkV2 (mkV "beklagar") | mkV2 (mkV "ångra"); -- status=guess, src=wikt status=guess, src=wikt
lin killer_N = mkN "baneman" "banemannen" "banemän" "banemännen" | mkN "mördare" utrum ; -- SaldoWN -- comment=3
lin delicate_A = mkA "ömtålig" ; -- SaldoWN
lin subsidiary_N = mkN "dotterbolag" neutrum; -- comment=4
lin gender_N = mkN "genus" neutrum; -- comment=3
lin entertain_V2 = mkV2 (mkV "underhålla"); -- status=guess, src=wikt
lin cling_V = mkV "klibbar" ;
lin vertical_A = mkA "vertikal" ; -- SaldoWN
lin fetch_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin fetch_V = mkV "utdelar" ; -- comment=18
lin strip_V2 = mkV2 (mkV "strippar"); -- status=guess, src=wikt
lin strip_V = mkV "tömmer" ; -- comment=6
lin plead_VS = variants {} ;
lin plead_VA = variants {} ;
lin plead_V2 = dirV2 (partV (mkV "talar")"om");
lin plead_V = mkV "be" "bad" "bett" ; -- comment=9
lin duck_N = mkN "anka" | mkN "segelduk" ; -- SaldoWN -- comment=11
lin breed_N = mkN "sort" "sorter" ; -- comment=10
lin assistant_A = variants{} ;
lin pint_N = mkN "öl" neutrum; -- comment=2
lin abolish_V2 = mkV2 (mkV "överge") | mkV2 (mkV "förkasta"); -- status=guess, src=wikt status=guess, src=wikt
lin translation_N = mkN "översättning" ;
lin princess_N = mkN "prinsessa" ; -- SaldoWN
lin line_V2 = dirV2 (partV (mkV "kantar")"av");
lin line_V = mkV "kantar" ; -- comment=15
lin excessive_A = mkA "överdriven" "överdrivet" ; -- comment=5
lin digital_A = mkA "digital" | mkA "numerisk" ;
lin steep_A = mkA "brant" "brant" | mkA "orimlig" ; -- SaldoWN -- comment=9
lin jet_N = mkN "sprut" neutrum | mkN "stråle" utrum ; -- SaldoWN -- comment=8
lin hey_Interj = mkInterj "hej" | mkInterj "hallå" ;
lin grave_N = mkN "grav" ; -- SaldoWN
lin exceptional_A = mkA "exceptionell" ; -- comment=5
lin boost_V2 = dirV2 (partV (mkV "ökar")"till"); -- comment=2
lin random_A = mkA "planlös" | compoundA (regA "slumpartad") ; -- SaldoWN -- comment=2
lin correlation_N = mkN "korrelation" "korrelationer" ; -- SaldoWN
lin outline_N = mkN "skiss" "skisser" | mkN "utkast" neutrum ; -- SaldoWN -- comment=7
lin intervene_V2V = variants {} ;
lin intervene_V = mkV "ingripa" "ingrep" "ingripit" ; -- comment=3
lin packet_N = mkN "paket" neutrum | mkN "paket" neutrum ; -- SaldoWN -- comment=3
lin motivation_N = mkN "motivation" "motivationer" | mkN "motivering" ; -- SaldoWN -- comment=2
lin safely_Adv = variants{} ;
lin harsh_A = mkA "skrovlig" | mkA "hård" "hårt" ; -- SaldoWN -- comment=17
lin spell_N = mkN "trollformel" "trollformeln" "trollformler" "trollformlerna" | mkN "tid" "tider" ; -- SaldoWN -- comment=4
lin spread_N = mkN "ranch" "rancher" | mkN "utbredning" ; -- SaldoWN -- comment=6
lin draw_N = mkN "skocka" ; -- comment=19
lin concrete_A = mkA "konkret" "konkret" ; -- SaldoWN
lin complicated_A = variants{} ;
lin alleged_A = variants{} ;
lin redundancy_N = mkN "redundans" ; -- SaldoWN
lin progressive_A = mkA "progressiv" ; -- SaldoWN
lin intensity_N = mkN "styrka" ; -- comment=2
lin crack_N = mkN "spricka" | mkN "spydighet" "spydigheter" ; -- SaldoWN -- comment=17
lin fly_N = mkN "fluga" | mkN "flagga" ; -- SaldoWN -- comment=6
lin fancy_V3 = variants {} ;
lin fancy_V2 = variants {} ;
lin alternatively_Adv = variants{} ;
lin waiting_A = variants{} ;
lin scandal_N = mkN "skandal" "skandaler" ; -- SaldoWN
lin resemble_V2 = mkV2 (mkV "liknar"); -- status=guess, src=wikt
lin parameter_N = mkN "parameter" ; -- SaldoWN
lin fierce_A = mkA "vild" "vilt" ; -- comment=10
lin tropical_A = mkA "tropisk" ; -- SaldoWN
lin colour_V2A = variants {} ;
lin colour_V2 = variants {} ;
lin colour_V = mkV "färglägga" "färglade" "färglagt" ; -- comment=2
lin engagement_N = mkN "förlovning" | mkN "överenskommelse" "överenskommelser" ; -- SaldoWN -- comment=12
lin contest_N = mkN "tävling" ; -- comment=5
lin edit_V2 = dirV2 (partV (mkV "redigerar")"om");
lin courage_N = mkN "mod" neutrum | mkN "kurage" ; -- SaldoWN -- comment=2
lin hip_N = mkN "höft" "höfter" | mkN "nypon" neutrum ; -- SaldoWN -- comment=2
lin delighted_A = variants{} ;
lin sponsor_V2 = mkV2 (mkV "sponsa") | mkV2 (mkV "sponsrar"); -- status=guess, src=wikt status=guess, src=wikt
lin carer_N = variants{} ;
lin crack_V2 = mkV2 "spricka" "sprack" "spruckit" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN
lin crack_V = mkV "spricka" "sprack" "spruckit" | mkV "spränger" ; -- SaldoWN -- comment=23
lin substantially_Adv = variants{} ;
lin occupational_A = mkA "sysselsättningsmässig" ; -- SaldoWN
lin trainer_N = mkN "tränare" utrum | mkN "tränare" utrum ; -- SaldoWN -- comment=3
lin remainder_N = mkN "rest" "rester" ; -- comment=2
lin related_A = variants{} ;
lin inherit_V2 = mkV2 (mkV "ärva"); -- status=guess, src=wikt
lin inherit_V = mkV "ärver" ;
lin resume_VS = mkVS (mkV "fortsätta") | mkVS (mkV "återuppta"); -- status=guess, src=wikt status=guess, src=wikt
lin resume_V2 = mkV2 (mkV "fortsätta") | mkV2 (mkV "återuppta"); -- status=guess, src=wikt status=guess, src=wikt
lin resume_V = mkV "återuppta" "återupptar" "återuppta" "återupptog" "återupptagit" "återupptagen" ;
lin assignment_N = mkN "uppgift" "uppgifter" | mkN "tilldelning" ; -- SaldoWN -- comment=2
lin conceal_V2 = mkV2 (mkV "dölja"); -- status=guess, src=wikt
lin disclose_VS = variants {} ;
lin disclose_V2 = dirV2 (partV (mkV "visar")"in");
lin disclose_V = mkV "visar" ; -- comment=6
lin exclusively_Adv = variants{} ;
lin working_N = mkN "uträkning" ; -- comment=23
lin mild_A = mkA "mild" "milt" ; -- SaldoWN
lin chronic_A = mkA "kronisk" ; -- SaldoWN
lin splendid_A = mkA "finfin" ; -- comment=9
lin function_V = mkV "fungerar" ;
lin rider_N = variants{} ;
lin clay_N = mkN "lik" neutrum | mkN "lera" ; -- SaldoWN
lin firstly_Adv = variants{} ;
lin conceive_V2 = variants {} ;
lin conceive_V = mkV "uppfattar" ; -- comment=4
lin politically_Adv = variants{} ;
lin terminal_N = mkN "terminal" "terminaler" ; -- SaldoWN
lin accuracy_N = mkN "exakthet" "exaktheter" ;
lin coup_N = mkN "kupp" "kupper" ; -- SaldoWN
lin ambulance_N = mkN "ambulans" "ambulanser" ; -- SaldoWN
lin living_N = mkN "livsuppehälle" ; -- comment=4
lin offender_N = variants{} ;
lin similarity_N = mkN "likhet" "likheter" ; -- SaldoWN
lin orchestra_N = mkN "orkester" | mkN "orkestra" ; -- SaldoWN -- comment=3
lin brush_N = mkN "borste" utrum | mkN "sammandrabbning" ; -- SaldoWN -- comment=6
lin systematic_A = mkA "systematisk" ; -- SaldoWN
lin striker_N = mkN "strejkande" ; -- comment=4
lin guard_V2 = mkV2 (mkV "vaktar") | mkV2 (mkV "bevakar"); -- status=guess, src=wikt status=guess, src=wikt
lin guard_V = mkV "bevakar" ; -- comment=10
lin casualty_N = mkN "offer" neutrum | mkN "olycksfall" neutrum ; -- SaldoWN -- comment=2
lin steadily_Adv = variants{} ;
lin painter_N = mkN "målare" utrum | mkN "målare" utrum ; -- SaldoWN
lin opt_VV = mkVV (mkV "välja"); -- status=guess, src=wikt
lin opt_V2V = mkV2V (mkV "välja"); -- status=guess, src=wikt
lin opt_V = mkV "välja" "valde" "valt" ;
lin handsome_A = mkA "ståtlig" ; -- comment=7
lin banking_N = mkN "bankrörelse" "bankrörelser" ; -- comment=4
lin sensitivity_N = mkN "sensitivitet" "sensitiviteter" | mkN "känslighet" "känsligheter" ; -- SaldoWN -- comment=2
lin navy_N = mkN "marin" "mariner" | mkN "flotta" ; -- SaldoWN -- comment=2
lin fascinating_A = variants {} ;
lin disappointment_N = mkN "besvikelse" "besvikelser" ; -- SaldoWN
lin auditor_N = mkN "revisor" "revisorer" | mkN "åhörare" utrum ; -- SaldoWN -- comment=2
lin hostility_N = mkN "motsättning" | mkN "fientlighet" "fientligheter" ; -- SaldoWN -- status=guess
lin spending_N = mkN "utgift" "utgifter" ;
lin scarcely_Adv = variants{} ;
lin compulsory_A = mkA "obligatorisk" ; -- comment=2
lin photographer_N = mkN "fotograf" "fotografer" ; -- SaldoWN
lin ok_Interj = mkInterj "okej" ;
lin neighbourhood_N = mkN "omgivning" | mkN "närhet" "närheter" ; -- SaldoWN -- comment=5
lin ideological_A = mkA "ideologisk" ; -- SaldoWN
lin wide_Adv = mkAdv "vid" ; -- comment=2
lin pardon_N = mkN "benådning" | mkN "förlåtelse" utrum ; -- SaldoWN -- comment=5
lin double_N = mkN "dubbelgångare" utrum | mkN "stand-in" "stand-iner" ; -- SaldoWN -- comment=8
lin criticize_V2 = variants {} ;
lin criticize_V = mkV "kritiserar" ; -- comment=6
lin supervision_N = mkN "handledning" ; -- comment=9
lin guilt_N = mkN "skuld" "skulder" ; -- SaldoWN
lin deck_N = mkN "kortlek" | mkN "däck" neutrum ; -- SaldoWN -- comment=9
lin payable_A = mkA "betalbar" ; -- comment=5
lin execution_N = mkN "avrättning" | mkN "teknik" "tekniker" ; -- SaldoWN -- comment=9
lin suite_N = mkN "svit" "sviter" | mkN "uppsättning" ; -- SaldoWN -- comment=9
lin elected_A = variants{} ;
lin solely_Adv = variants{} ;
lin moral_N = mkN "sensmoral" "sensmoraler" ; -- SaldoWN
lin collector_N = mkN "samlare" utrum;
lin questionnaire_N = mkN "enkät" "enkäter" ; -- SaldoWN
lin flavour_N = mkN "smak" "smaker" | mkN "krydda" ; -- SaldoWN -- comment=8
lin couple_V2 = dirV2 (partV (mkV "kopplar")"ur"); -- comment=4
lin couple_V = mkV "parar" ; -- comment=4
lin faculty_N = mkN "fakultet" "fakulteter" ; -- comment=5
lin tour_V2 = variants {} ;
lin tour_V = mkV "turistar" ; -- comment=3
lin basket_N = mkN "korg" ; -- SaldoWN
lin mention_N = mkN "omnämnande" ;
lin kick_N = mkN "kick" | mkN "bråka" ; -- SaldoWN -- comment=12
lin horizon_N = mkN "horisont" "horisonter" ; -- SaldoWN
lin drain_V2 = mkV2 "torrlägga" "torrlade" "torrlagt" | dirV2 (partV (mkV "filtrerar")"av") ; -- SaldoWN -- comment=6
lin drain_V = mkV "torrlägga" "torrlade" "torrlagt" | mkV "tömmer" ; -- SaldoWN -- comment=18
lin happiness_N = mkN "lycka" ; -- comment=3
lin fighter_N = mkN "kämpe" utrum; -- comment=5
lin estimated_A = variants{} ;
lin copper_N = mkN "koppar" ; -- SaldoWN
lin legend_N = mkN "legend" "legender" | mkN "teckenförklaring" ; -- SaldoWN -- comment=5
lin relevance_N = mkN "relevans" ; -- SaldoWN
lin decorate_V2 = dirV2 (partV (mkV "pyntar")"till"); -- comment=5
lin continental_A = mkA "kontinental" ; -- SaldoWN
lin ship_V2 = mkV2 (mkV "skeppar") | mkV2 (mkV "fraktar"); -- status=guess, src=wikt status=guess, src=wikt
lin ship_V = mkV "skeppar" ; -- comment=2
lin operational_A = mkA "operationell" | mkA "funktionsduglig" ; -- SaldoWN -- comment=2
lin incur_V2 = mkV2 (mkV (mkV "utsätta") "sig för"); -- status=guess, src=wikt
lin parallel_A = mkA "parallell" ; -- SaldoWN
lin divorce_N = mkN "skilsmässa" ; -- SaldoWN
lin opposed_A = variants{} ;
lin equilibrium_N = mkN "jämvikt" ; -- SaldoWN
lin trader_N = mkN "handlare" utrum; -- comment=3
lin ton_N = mkN "ton" "toner" | mkN "ton" "tonnet" "ton" "tonnen" ; -- SaldoWN = mkN "ton" "tonnet" "ton" "tonnen" ; -- comment=2
lin can_N = mkN "dunk" ;
lin juice_N = mkN "juice" "juicer" | mkN "saft" "safter" ; -- SaldoWN
lin forum_N = mkN "forum" neutrum ; -- SaldoWN
lin spin_V2 = mkV2 "vrida" "vred" "vridit" | dirV2 (partV (mkV "skruvar")"till") ; -- SaldoWN -- comment=6
lin spin_V = mkV "vrida" "vred" "vridit" | mkV "spinna" "spann" "spunnit" ; -- SaldoWN -- comment=3
lin research_V2 = dirV2 (partV (mkV "forskar")"igenom");
lin research_V = mkV "forskar" ;
lin hostile_A = mkA "fientlig" | mkA "människofientlig" ; -- SaldoWN -- comment=2
lin consistently_Adv = variants{} ;
lin technological_A = mkA "teknologisk" ;
lin nightmare_N = mkN "mardröm" "mardrömmen" "mardrömmar" "mardrömmarna" ; -- SaldoWN
lin medal_N = mkN "medalj" "medaljer" ;
lin diamond_N = mkN "diamant" "diamanter" | mkN "romb" "romber" ; -- SaldoWN -- comment=3
lin speed_V2 = mkV2 (mkV (mkV "köra") "för fort"); -- status=guess, src=wikt
lin speed_V = mkV "sprätta" "sprätter" "sprätt" "sprätte" "sprätt" "sprätt" ; -- comment=3
lin peaceful_A = mkA "fridfull" | mkA "fredlig" ; -- SaldoWN -- comment=3
lin accounting_A = variants{} ;
lin scatter_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut");
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
lin polytechnic_N = variants {} ;
lin inhabitant_N = mkN "invånare" utrum ; -- SaldoWN -- comment=3
lin evil_A = mkA "skadlig" ; -- comment=13
lin slave_N = mkN "slav" | mkN "slav" "slaver" ; -- SaldoWN = mkN "slav" "slaver" ; -- comment=2
lin reservation_N = mkN "reservation" "reservationer" ; -- comment=2
lin slam_V2 = mkV2 "smälla" "small" "smäll" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN
lin slam_V = mkV "smälla" "small" "smäll" ; -- SaldoWN
lin handle_N = mkN "vred" neutrum; -- comment=6
lin provincial_A = mkA "provinsiell" ; -- SaldoWN
lin fishing_N = mkN "fiske" ;
lin facilitate_V2 = mkV2 (mkV "underlätta") | mkV2 (mkV "förenkla"); -- status=guess, src=wikt status=guess, src=wikt
lin yield_N = mkN "avkastning" ; -- comment=7
lin elbow_N = mkN "armbåge" utrum | mkN "böj" ; -- SaldoWN -- comment=4
lin bye_Interj = mkInterj "hej då" | mkInterj "adjö" | mkInterj "farväl" ;
lin warm_V2 = dirV2 (partV (mkV "värmer")"på");
lin warm_V = mkV "värmer" ;
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
lin sergeant_N = mkN "sergeant" "sergeanter" ;
lin regulate_V2 = dirV2 (partV (mkV "ordnar")"om");
lin clash_N = mkN "sammandrabbning" | mkN "skramla" ; -- SaldoWN -- comment=8
lin assemble_V2 = mkV2 (mkV "assemblera"); -- status=guess, src=wikt
lin assemble_V = mkV "samlar" ; -- comment=6
lin arrow_N = mkN "pil" ; -- SaldoWN
lin nowadays_Adv = mkAdv "nuförtiden" ;
lin giant_A = variants{} ;
lin waiting_N = variants{} ;
lin tap_N = mkN "kran" | mkN "plugg" ; -- SaldoWN -- comment=8
lin shit_N = mkN "skit" ;
lin sandwich_N = mkN "sandwich" ; -- comment=2
lin vanish_V = mkV "försvinna" "försvann" "försvunnit" ; -- comment=2
lin commerce_N = mkN "handel" | mkN "umgänge" ; -- SaldoWN = mkN "handel" ; -- comment=4
lin pursuit_N = mkN "hobby" "hobbier" | mkN "jakt" "jakter" ; -- SaldoWN -- comment=5
lin post_war_A = variants{} ;
lin will_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till");
lin will_V = mkV "brukar" ; -- comment=5
lin waste_A = mkA "öde" ; -- comment=5
lin collar_N = mkN "krage" utrum ; -- SaldoWN -- comment=5
lin socialism_N = mkN "socialism" "socialismer" ;
lin skill_V = variants{} ;
lin rice_N = mkN "ris" neutrum | mkN "ris" neutrum ; -- SaldoWN = mkN "ris" neutrum ; -- comment=3
lin exclusion_N = mkN "uteslutning" ; -- comment=2
lin upwards_Adv = mkAdv "uppåt" ;
lin transmission_N = mkN "växel" | mkN "överlämnande" ; -- SaldoWN -- comment=9
lin instantly_Adv = variants{} ;
lin forthcoming_A = variants {} ;
lin appointed_A = variants{} ;
lin geographical_A = mkA "geografisk" ;
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
lin broadly_Adv = variants{} ;
lin affection_N = mkN "ömhet" ; -- comment=8
lin dawn_N = mkN "gryning" ; -- comment=4
lin principal_N = mkN "uppdragsgivare" utrum; -- comment=7
lin bloke_N = mkN "kille" utrum; -- comment=4
lin trap_N = mkN "fälla" | mkN "vattenlås" neutrum ; -- SaldoWN -- comment=9
lin communist_A = mkA "kommunistiskt" ;
lin competence_N = mkN "kompetens" "kompetenser" ; -- SaldoWN
lin complicate_V2 = variants {} ;
lin neutral_A = mkA "neutral" | mkA "opartisk" ; -- SaldoWN -- comment=3
lin fortunately_Adv = variants{} ;
lin commonwealth_N = variants {} ;
lin breakdown_N = mkN "sammanbrott" neutrum | mkN "upphörande" ; -- SaldoWN -- comment=9
lin combined_A = variants{} ;
lin candle_N = mkN "ljus" neutrum | mkN "stearinljus" neutrum ; -- SaldoWN
lin venue_N = mkN "arena" ;
lin supper_N = mkN "kvällsmat" ; -- comment=6
lin analyst_N = mkN "psykoanalytiker" "psykoanalytikern" "psykoanalytiker" "psykoanalytikerna" | mkN "analytiker" "analytikern" "analytiker" "analytikerna" ; -- SaldoWN
lin vague_A = mkA "vag" ; -- SaldoWN
lin publicly_Adv = variants{} ;
lin marine_A = mkA "marin" ; -- SaldoWN
lin fair_Adv = mkAdv "just" ;
lin pause_N = mkN "paus" "pauser" ; -- SaldoWN
lin notable_A = mkA "framstående" ;
lin freely_Adv = variants{} ;
lin counterpart_N = mkN "motsvarighet" "motsvarigheter" ; -- comment=2
lin lively_A = mkA "livlig" ; -- SaldoWN
lin script_N = mkN "skriftsystem" neutrum | mkN "skrivtecken" "skrivtecknet" "skrivtecken" "skrivtecknen" ; -- SaldoWN -- comment=6
lin sue_V2V = variants {} ;
lin sue_V2 = variants {} ;
lin sue_V = variants {} ;
lin legitimate_A = mkA "egentlig" ; -- comment=13
lin geography_N = mkN "geografi" ;
lin reproduce_V2 = dirV2 (partV (mkV "bli" "blev" "blivit")"utan"); -- comment=6
lin reproduce_V = mkV "upprepar" ; -- comment=7
lin moving_A = variants{} ;
lin lamb_N = mkN "lamm" neutrum ;
lin gay_A = mkA "likgiltig" ; -- comment=7
lin contemplate_VS = variants {} ;
lin contemplate_V2 = dirV2 (partV (mkV "funderar")"ut");
lin contemplate_V = mkV "grubblar" ; -- comment=7
lin terror_N = mkN "skräck" ; -- comment=2
lin stable_N = mkN "stall" ; -- SaldoWN = mkN "stall" neutrum ; = mkN "stall" neutrum ;
lin founder_N = mkN "grundare" utrum ;
lin utility_N = mkN "nytta" ; -- comment=3
lin signal_VS = variants {} ;
lin signal_V2 = variants {} ;
lin signal_V = mkV "signalerar" ; -- comment=3
lin shelter_N = mkN "härbärge" | mkN "skydd" neutrum ; -- SaldoWN -- comment=11
lin poster_N = mkN "avsändare" utrum; -- comment=6
lin hitherto_Adv = mkAdv "hittills" ;
lin mature_A = mkA "mogen" "moget" ; -- SaldoWN
lin cooking_N = mkN "matlagning" | mkN "lagning" ; -- SaldoWN
lin head_A = variants{} ;
lin wealthy_A = mkA "rik" ; -- comment=4
lin fucking_A = variants{} ;
lin confess_VS = variants {} ;
lin confess_V2 = variants {} ;
lin confess_V = mkV "erkänna" "erkände" "erkänt" ; -- comment=4
lin age_V2 = mkV2 (mkV "åldras"); -- status=guess, src=wikt
lin age_V = mkV "åldras" ; -- status=guess, src=wikt
lin miracle_N = mkN "under" neutrum | mkN "under" neutrum ; -- SaldoWN -- comment=3
lin magic_A = mkA "underbar" ; -- comment=3
lin jaw_N = mkN "käke" utrum | mkN "käft" ; -- SaldoWN -- comment=7
lin pan_N = mkN "schimpans" "schimpanser" | mkN "vågskål" ; -- SaldoWN -- comment=7
lin coloured_A = variants{} ;
lin tent_N = mkN "tält" neutrum | mkN "tält" neutrum ; -- SaldoWN
lin telephone_V2 = mkV2 (mkV "ringar"); -- status=guess, src=wikt
lin telephone_V = mkV "telefonerar" ; -- comment=3
lin reduced_A = variants{} ;
lin tumour_N = mkN "tumör" "tumörer" ; -- SaldoWN
lin super_A = mkA "toppen" "toppet" ; -- comment=2
lin funding_N = variants{} ;
lin dump_V2 = dirV2 (partV (mkV "slänga")"ut");
lin dump_V = mkV "dumpar" ; -- comment=6
lin stitch_N = mkN "stygn" neutrum | mkN "stygn" neutrum ; -- SaldoWN -- comment=3
lin shared_A = variants{} ;
lin ladder_N = mkN "stege" utrum ; -- SaldoWN -- comment=4
lin keeper_N = mkN "väktare" utrum; -- comment=6
lin endorse_V2 = mkV2 (mkV "stödja") | mkV2 (mkV (mkV "ställa") "sig bakom") | mkV2 (mkV (mkV "stå") "bakom"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin invariably_Adv = variants{} ;
lin smash_V2 = dirV2 (partV (mkV "smälla" "small" "smäll")"av"); -- comment=15
lin smash_V = mkV "smälla" "small" "smäll" ; -- comment=9
lin shield_N = mkN "sköld" | mkN "vapensköld" ; -- SaldoWN -- comment=9
lin heat_V2 = dirV2 (partV (mkV "värmer")"på");
lin heat_V = mkV "upphettar" ; -- comment=6
lin surgeon_N = mkN "kirurg" "kirurger" ; -- SaldoWN
lin centre_V2 = variants {} ;
lin centre_V = mkV "centrerar" ;
lin orange_N = variants{} ;
lin orange_2_N = mkN "orange" "oranger" ; -- comment=3
lin orange_1_N = mkN "orange" "oranger" ; -- comment=3
lin explode_V2 = mkV2 (mkV "exploderar") | mkV2 (mkV "spränga"); -- status=guess, src=wikt status=guess, src=wikt
lin explode_V = mkV "spränger" ; -- comment=5
lin comedy_N = mkN "komedi" "komedier" | mkN "komik" ; -- SaldoWN -- comment=2
lin classify_V2 = mkV2 (mkV "klassificerar"); -- status=guess, src=wikt
lin artistic_A = mkA "konstnärlig" ; -- SaldoWN
lin ruler_N = mkN "makthavare" utrum; -- comment=2
lin biscuit_N = mkN "kaka" | mkN "kex" neutrum ; -- SaldoWN -- comment=5
lin workstation_N = variants {} ;
lin prey_N = mkN "byte" | mkN "byte" "byten" "byte" "bytena" ; -- SaldoWN = mkN "byte" "byten" "byte" "bytena" ; -- comment=5
lin manual_N = mkN "manual" "manualer" ; -- SaldoWN
lin cure_N = variants{} ;
lin cure_2_N = variants {} ;
lin cure_1_N = mkN "vulkanisering" ; -- comment=14
lin overall_N = mkN "overall" "overaller" | mkN "rock" ; -- SaldoWN -- comment=5
lin tighten_V2 = variants {} ;
lin tighten_V = mkV "skärper" ; -- comment=5
lin tax_V2 = mkV2 (mkV "beskattar"); -- status=guess, src=wikt
lin pope_N = mkN "påve" ; -- status=guess
lin manufacturing_A = variants{} ;
lin adult_A = mkA "vuxen" "vuxet" | mkA "mogen" "moget" ; -- SaldoWN -- comment=3
lin rush_N = mkN "hast" | mkN "driva" ; -- SaldoWN -- comment=11
lin blanket_N = mkN "filt" ;
lin republican_N = mkN "republikan" "republikaner" ;
lin referendum_N = mkN "folkomröstning" ; -- SaldoWN
lin palm_N = mkN "palm" "palmer" | mkN "handflata" ; -- SaldoWN -- comment=2
lin nearby_Adv = mkAdv "i närheten" ; -- status=guess
lin mix_N = mkN "före" ; -- comment=5
lin devil_N = mkN "djävul" "djävulen" "djävlar" "djävlarna" ; -- comment=4
lin adoption_N = mkN "adoption" "adoptioner" | mkN "godkännande" ; -- SaldoWN -- comment=4
lin workforce_N = variants{} ;
lin segment_N = mkN "sektion" "sektioner" ; -- comment=3
lin regardless_Adv = variants {} ;
lin contractor_N = mkN "entreprenör" "entreprenörer" ;
lin portion_N = mkN "portion" "portioner" ;
lin differently_Adv = variants{} ;
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
lin submission_N = mkN "underkastelse" utrum;
lin arm_V2 = mkV2 (mkV "rustar") | mkV2 (mkV "beväpna"); -- status=guess, src=wikt status=guess, src=wikt
lin arm_V = mkV "beväpnar" ; -- comment=7
lin odd_N = variants{} ;
lin certainty_N = mkN "säkerhet" "säkerheter" ; -- comment=2
lin boring_A = mkA "långtråkig" ; -- comment=2
lin electron_N = mkN "elektron" neutrum ;
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
lin socially_Adv = variants{} ;
lin riot_N = mkN "upplopp" neutrum | mkN "upplopp" neutrum ; -- SaldoWN -- comment=3
lin petition_N = mkN "skrivelse" "skrivelser" ; -- comment=6
lin fox_N = mkN "räv" ; -- SaldoWN
lin recruitment_N = mkN "återhämtning" ; -- comment=3
lin well_known_A = variants {} ;
lin top_V2 = dirV2 (partV (mkV "kapar")"av");
lin service_V2 = mkV2 "serva" ;
lin flood_V2 = mkV2 (mkV (mkV "svämma") "över") | mkV2 (mkV "översvämma"); -- status=guess, src=wikt status=guess, src=wikt
lin flood_V = mkV "översvämmar" ; -- comment=2
lin taste_V2 = mkV2 (mkV "smakar"); -- status=guess, src=wikt
lin taste_V = mkV "smakar" ; -- comment=3
lin memorial_N = mkN "minnesmärke" | mkN "minneshögtid" | mkN "minnesgudstjänst" ; -- SaldoWN -- status=guess status=guess
lin helicopter_N = mkN "helikopter" ; -- SaldoWN
lin correspondence_N = mkN "korrespondens" "korrespondenser" | mkN "överensstämmelse" "överensstämmelser" ; -- SaldoWN -- comment=4
lin beef_N = mkN "biff" | mkN "nötkött" neutrum ; -- SaldoWN -- comment=8
lin overall_Adv = variants{} ;
lin lighting_N = mkN "lyse" ; -- comment=4
lin harbour_N = L.harbour_N ;
lin empirical_A = mkA "empirisk" ; -- SaldoWN
lin shallow_A = mkA "grund" | mkA "ytlig" ; -- SaldoWN -- comment=3
lin seal_V2A = variants {} ;
lin seal_V2 = variants {} ;
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
lin widen_V = mkV "breddar" ; -- comment=4
lin hazard_N = mkN "slump" ; -- comment=5
lin dispose_V2 = dirV2 (partV (mkV "ordnar")"om");
lin dispose_V = mkV "ordnar" ; -- comment=5
lin dealing_N = variants {} ;
lin absent_A = mkA "frånvarande" | mkA "tankspridd" ; -- SaldoWN -- comment=3
lin reassure_V2S = variants {} ;
lin reassure_V2 = variants {} ;
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
lin advisory_A = mkA "rådgivande" ;
lin fitness_N = mkN "form" | mkN "kondition" "konditioner" ; -- SaldoWN = mkN "form" ; = mkN "form" "former" ;
lin blank_A = mkA "tom" "tomt" "tomma" "tomma" "tommare" "tommast" "tommaste" | mkA "uttryckslös" ; -- SaldoWN -- comment=7
lin indirect_A = mkA "indirekt" "indirekt" ; -- SaldoWN
lin tile_N = mkN "kakel" neutrum | mkN "kakelplatta" ; -- SaldoWN -- comment=5
lin rally_N = mkN "rally" "rallyt" "rallyn" "rallyna" ; -- SaldoWN
lin economist_N = mkN "ekonom" "ekonomer" ; -- SaldoWN
lin vein_N = mkN "ven" "vener" | mkN "åder" "ådern" "ådror" "ådrorna" ; -- SaldoWN -- comment=3
lin strand_N = mkN "slinga" ;
lin disturbance_N = mkN "orolighet" "oroligheter" | mkN "störande" ; -- SaldoWN -- comment=14
lin stuff_V2 = dirV2 (partV (mkV "stoppar")"till"); -- comment=3
lin seldom_Adv = mkAdv "sällan" ;
lin coming_A = variants{} ;
lin cab_N = mkN "taxi" "taxin" "taxi" "taxina" ; -- comment=4
lin grandfather_N = mkN "morfar" "morfadern" "morfäder" "morfäderna" ; -- SaldoWN
lin flash_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut");
lin flash_V = mkV "anfalla" "anföll" "anfallit" ; -- comment=14
lin destination_N = mkN "bestämmelseort" "bestämmelseorter" ; -- comment=4
lin actively_Adv = variants{} ;
lin regiment_N = mkN "regemente" ;
lin closed_A = mkA "stängd" "stängt" ;
lin boom_N = mkN "boom" | mkN "uppsving" neutrum ; -- SaldoWN -- comment=11
lin handful_N = mkN "näve" utrum; -- comment=2
lin remarkably_Adv = variants{} ;
lin encouragement_N = mkN "uppmuntran" "uppmuntran" "uppmuntringar" "uppmuntringarna" ; -- comment=5
lin awkward_A = mkA "avig" | mkA "svårhanterlig" ; -- SaldoWN -- comment=23
lin required_A = variants{} ;
lin flood_N = mkN "översvämning" ; -- SaldoWN
lin defect_N = mkN "defekt" "defekter" ; -- comment=5
lin surplus_N = mkN "överskott" neutrum | mkN "överskott" neutrum ; -- SaldoWN
lin champagne_N = mkN "champagne" "champagner" ; -- SaldoWN
lin liquid_N = mkN "spad" neutrum | mkN "spad" neutrum ; -- SaldoWN -- comment=5
lin shed_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut");
lin welcome_N = mkN "mottagning" | mkN "välkomnande" ; -- SaldoWN -- comment=2
lin rejection_N = mkN "avslag" neutrum | mkN "förkastande" ; -- SaldoWN -- comment=8
lin discipline_V2 = variants {} ;
lin halt_V2 = mkV2 (mkV "haltar"); -- status=guess, src=wikt
lin halt_V = mkV "haltar" ; -- comment=5
lin electronics_N = mkN "elektronik" ; -- SaldoWN
lin administrator_N = variants{} ;
lin sentence_V2 = dirV2 (partV (mkV "dömer")"ut");
lin sentence_V = mkV "dömer" ;
lin ill_Adv = mkAdv "illa" ;
lin contradiction_N = mkN "motsägelse" "motsägelser" ; -- SaldoWN
lin nail_N = mkN "spik" ; -- SaldoWN
lin senior_N = mkN "senior" ; -- SaldoWN = mkN "senior" "senioren" "seniorer" "seniorerna" ;
lin lacking_A = variants{} ;
lin colonial_A = mkA "kolonial" ;
lin primitive_A = mkA "primitiv" ;
lin whoever_NP = variants{} ;
lin lap_N = mkN "knä" "knäet" "knän" "knäna" | mkN "överlappning" ; -- SaldoWN -- comment=12
lin commodity_N = mkN "artikel" ; -- comment=3
lin planned_A = variants{} ;
lin intellectual_N = mkN "djup" neutrum;
lin imprisonment_N = mkN "inspärrande" ; -- comment=4
lin coincide_V = mkV "sammanfalla" "sammanföll" "sammanfallit" | mkV "sammanträffar" ; -- SaldoWN -- comment=2
lin sympathetic_A = mkA "sympatisk" ; -- SaldoWN
lin atom_N = mkN "atom" "atomer" | mkN "uns" neutrum ; -- SaldoWN -- comment=2
lin tempt_V2V = variants {} ;
lin tempt_V2 = variants {} ;
lin sanction_N = mkN "sanktion" "sanktioner" ; -- comment=6
lin praise_V2 = mkV2 (mkV "lovar"); -- status=guess, src=wikt
lin favourable_A = mkA "välvillig" ; -- comment=4
lin dissolve_V2 = dirV2 (partV (mkV "löser")"ut");
lin dissolve_V = mkV "upplöser" ; -- comment=5
lin tightly_Adv = variants{} ;
lin surrounding_N = variants{} ;
lin soup_N = mkN "soppa" ; -- SaldoWN = mkN "soppa" ;
lin encounter_N = mkN "möte" ; -- comment=6
lin abortion_N = mkN "abort" "aborter" ; -- SaldoWN
lin grasp_V2 = mkV2 (mkV "fattar") | mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV "greppar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grasp_V = mkV "greppar" ; -- comment=7
lin custody_N = mkN "arrest" "arrester" | mkN "förmynderskap" neutrum ; -- SaldoWN -- comment=8
lin composer_N = mkN "kompositör" "kompositörer" ;
lin charm_N = mkN "amulett" "amuletter" | mkN "trollformel" "trollformeln" "trollformler" "trollformlerna" ; -- SaldoWN -- comment=10
lin short_term_A = variants {} ;
lin metropolitan_A = variants {} ;
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
lin emperor_N = mkN "kejsare" utrum;
lin rescue_N = mkN "undsättning" | mkN "räddning" ; -- SaldoWN -- comment=6
lin integrated_A = variants{} ;
lin conscience_N = mkN "samvete" ; -- SaldoWN
lin commence_V2 = dirV2 (partV (mkV "börjar")"om");
lin commence_V = mkV "börjar" ; -- comment=3
lin grandmother_N = mkN "mormoder" "mormodern" "mormödrar" "mormödrarna" ;
lin discharge_V2 = dirV2 (partV (mkV "löser")"ut");
lin discharge_V = mkV "tömmer" ; -- comment=23
lin profound_A = mkA "djupsinnig" | mkA "outgrundlig" ; -- SaldoWN -- comment=11
lin takeover_N = mkN "övertagande" ; -- comment=2
lin nationalist_N = mkN "nationalist" "nationalister" ; -- SaldoWN
lin effect_V2 = mkV2 (mkV (mkV "sätta") "i verket") | mkV2 (mkV "effektuerar") | mkV2 (mkV (mkV "sätta") "igång") | mkV2 (mkV "verkställa") | mkV2 (mkV "utverkar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dolphin_N = mkN "delfin" "delfiner" ; -- SaldoWN
lin fortnight_N = variants {} ;
lin elephant_N = mkN "elefant" "elefanter" ; -- SaldoWN
lin seal_N = mkN "säl" ; -- SaldoWN
lin spoil_V2 = dirV2 (partV (mkV "skämmer")"ut");
lin spoil_V = mkV "skämmer" ; -- comment=7
lin plea_N = mkN "ursäkt" "ursäkter" ; -- comment=9
lin forwards_Adv = mkAdv "framlänges" ;
lin breeze_N = mkN "bris" ; -- SaldoWN
lin prevention_N = mkN "förebyggande" ;
lin mineral_N = mkN "mineral" "mineralet" "mineraler" "mineralerna" ; -- SaldoWN
lin runner_N = mkN "löpare" utrum | mkN "utlöpare" utrum ; -- SaldoWN -- comment=8
lin pin_V2 = variants {} ;
lin integrity_N = mkN "integritet" "integriteter" ; -- SaldoWN
lin thereafter_Adv = mkAdv "därefter" ;
lin quid_N = mkN "pund" neutrum;
lin owl_N = mkN "uggla" ; -- SaldoWN
lin rigid_A = mkA "stel" ; -- SaldoWN
lin orange_A = mkA "orange" "orange" ;
lin draft_V2 = mkV2 (mkV "värva") | mkV2 (mkV "rekryterar") | mkV2 (mkV "kommenderar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reportedly_Adv = variants {} ;
lin hedge_N = mkN "häck" | mkN "skydd" neutrum ; -- SaldoWN -- comment=3
lin formulate_V2 = variants {} ;
lin associated_A = variants{} ;
lin position_V2V = mkV2V (mkV "placerar") | mkV2V (mkV (mkV "placera") "ut"); -- status=guess, src=wikt status=guess, src=wikt
lin position_V2 = mkV2 (mkV "placerar") | mkV2 (mkV (mkV "placera") "ut"); -- status=guess, src=wikt status=guess, src=wikt
lin thief_N = mkN "tjuv" ; -- SaldoWN
lin tomato_N = mkN "tomat" "tomater" ; -- SaldoWN
lin exhaust_V2 = variants {} ;
lin evidently_Adv = variants{} ;
lin eagle_N = mkN "örn" ; -- SaldoWN
lin specified_A = variants{} ;
lin resulting_A = variants{} ;
lin blade_N = mkN "blad" neutrum ; -- SaldoWN -- comment=5
lin peculiar_A = mkA "karakteristisk" ; -- comment=10
lin killing_N = mkN "dödande" ; -- comment=4
lin desktop_N = mkN "PC" ;
lin bowel_N = mkN "tarm" ; -- SaldoWN
lin long_V = mkV "längtar" ;
lin ugly_A = L.ugly_A ;
lin expedition_N = mkN "expedition" "expeditioner" | mkN "skyndsamhet" ; -- SaldoWN -- comment=10
lin saint_N = mkN "helgon" neutrum;
lin variable_A = mkA "variabel" ; -- SaldoWN
lin supplement_V2 = dirV2 (partV (mkV "ökar")"till"); -- comment=2
lin stamp_N = mkN "frimärke" | mkN "stämpel" ; -- SaldoWN -- comment=16
lin slide_N = mkN "rutschbana" | mkN "sticka" ; -- SaldoWN -- comment=13
lin faction_N = mkN "gräl" neutrum; -- comment=6
lin enthusiastic_A = mkA "entusiastisk" ; -- SaldoWN
lin enquire_V2 = dirV2 (partV (mkV "frågar")"ut");
lin enquire_V = mkV "frågar" ;
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
lin missing_A = variants{} ;
lin extended_A = variants{} ;
lin valuation_N = mkN "värdering" ;
lin delight_VS = mkVS (mkV "glädja"); -- status=guess, src=wikt
lin delight_V2 = mkV2 (mkV "glädja"); -- status=guess, src=wikt
lin delight_V = mkV "fröjdar" ; -- comment=2
lin beat_N = mkN "takt" | mkN "trampa" ; -- SaldoWN = mkN "takt" "takter" ; -- comment=18
lin worship_N = mkN "ära" ; -- comment=4
lin fossil_N = mkN "fossil" neutrum | mkN "stofil" "stofiler" ; -- SaldoWN -- comment=3
lin diminish_V2 = mkV2 (mkV "minskar"); -- status=guess, src=wikt
lin diminish_V = mkV "förminskar" ; -- comment=5
lin taxpayer_N = mkN "skattebetalare" utrum | mkN "skattebetalare" utrum ; -- SaldoWN
lin corruption_N = mkN "korruption" "korruptioner" ; -- SaldoWN
lin accurately_Adv = variants{} ;
lin honour_V2 = mkV2 (mkV "hedrar"); -- status=guess, src=wikt
lin depict_V2 = mkV2 (mkV "framställa") | mkV2 (mkV "skildrar"); -- status=guess, src=wikt status=guess, src=wikt
lin pencil_N = mkN "penna" | mkN "strålknippe" ; -- SaldoWN -- comment=3
lin drown_V2 = mkV2 (mkV (mkV "dränka") "sina sorger"); -- status=guess, src=wikt
lin drown_V = mkV "dränker" ; -- comment=4
lin stem_N = mkN "stjälk" | mkN "stämma" ; -- SaldoWN -- comment=7
lin lump_N = mkN "klump" | mkN "klimp" ; -- SaldoWN -- comment=16
lin applicable_A = mkA "tillämplig" ; -- comment=3
lin rate_VS = variants {} ;
lin rate_VA = variants {} ;
lin rate_V2 = dirV2 (partV (mkV "räknar")"ut"); -- comment=5
lin rate_V = mkV "mår" ; -- comment=9
lin mobility_N = mkN "rörlighet" "rörligheter" ; -- comment=2
lin immense_A = mkA "enorm" ; -- comment=7
lin goodness_N = mkN "vänlighet" ; -- comment=6
lin price_V2V = mkV2V (mkV "värdera") | mkV2V (mkV "prissätta"); -- status=guess, src=wikt status=guess, src=wikt
lin price_V2 = mkV2 (mkV "värdera") | mkV2 (mkV "prissätta"); -- status=guess, src=wikt status=guess, src=wikt
lin price_V = mkV "prissätta" "prissatte" "prissatt" ; --
lin preliminary_A = mkA "preliminär" ;
lin graph_N = mkN "graf" "grafer" | mkN "diagram" "diagrammet" "diagram" "diagrammen" ; -- SaldoWN -- comment=3
lin referee_N = mkN "domare" utrum | mkN "skiljedomare" utrum ; -- SaldoWN -- comment=3
lin calm_A = mkA "lugn" ; -- comment=2
lin onwards_Adv = variants {} ;
lin omit_V2 = variants {} ;
lin genuinely_Adv = variants{} ;
lin excite_V2 = variants {} ;
lin dreadful_A = mkA "fruktansvärd" "fruktansvärt" ; -- comment=6
lin cave_N = mkN "grotta" ; -- SaldoWN
lin revelation_N = mkN "uppenbarelse" "uppenbarelser" ;
lin grief_N = mkN "sorg" "sorger" ; -- SaldoWN
lin erect_V2 = variants {} ;
lin tuck_V2 = variants {} ;
lin tuck_V = variants {} ;
lin meantime_N = variants {} ;
lin barrel_N = mkN "tunna" ; -- SaldoWN
lin lawn_N = mkN "gräsmatta" ; -- SaldoWN
lin hut_N = mkN "hydda" ; -- SaldoWN
lin swing_N = mkN "gunga" | mkN "svängning" ; -- SaldoWN -- comment=12
lin subject_V2 = variants {} ;
lin ruin_V2 = mkV2 (mkV "ödelägga") | mkV2 (mkV "ruinerar"); -- status=guess, src=wikt status=guess, src=wikt
lin slice_N = mkN "skiva" | mkN "skära" ; -- SaldoWN -- comment=2
lin transmit_V2 = dirV2 (partV (mkV "sänder")"efter"); -- comment=2
lin thigh_N = mkN "lår" ; -- SaldoWN = mkN "lår" neutrum ;
lin practically_Adv = variants{} ;
lin dedicate_V2 = variants {} ;
lin mistake_V2 = mkV2 (mkV "missta" "misstar" "missta" "misstog" "misstagit" "misstagen") | mkV2 (mkV (mkV "begå") "ett misstag"); -- status=guess, src=wikt status=guess, src=wikt
lin mistake_V = (mkV "missta" "misstar" "missta" "misstog" "misstagit" "misstagen") | mkV (mkV "begå") "ett misstag" ; -- status=guess, src=wikt status=guess, src=wikt
lin corresponding_A = variants{} ;
lin albeit_Subj = variants {} ;
lin sound_A = mkA "sund" | mkA "säker" ; -- SaldoWN -- comment=13
lin nurse_V2 = dirV2 (partV (mkV "sparar")"in");
lin discharge_N = mkN "uttömning" ; -- comment=29
lin comparative_A = mkA "komparativ" ; -- comment=3
lin cluster_N = mkN "kluster" neutrum | mkN "klase" utrum ; -- SaldoWN -- comment=8
lin propose_VV = mkVV (mkV "friar"); -- status=guess, src=wikt
lin propose_VS = mkVS (mkV "friar"); -- status=guess, src=wikt
lin propose_V2 = mkV2 (mkV "föreslå" "föreslog" "föreslagit"); --
lin propose_V = mkV "ämnar" ; -- comment=4
lin obstacle_N = mkN "hinder" neutrum | mkN "hinder" neutrum ; -- SaldoWN -- comment=2
lin motorway_N = mkN "motorväg" ; -- SaldoWN
lin heritage_N = mkN "kulturarv" neutrum; -- comment=5
lin counselling_N = variants{} ;
lin breeding_N = mkN "hyfs" ; -- comment=11
lin characteristic_A = mkA "karakteristisk" ; -- SaldoWN
lin bucket_N = mkN "hink" | mkN "kolv" ; -- SaldoWN -- comment=5
lin migration_N = mkN "migration" "migrationer" ; -- SaldoWN
lin campaign_V = mkV "kampanj" ; -- status=guess, src=wikt
lin ritual_N = mkN "ritual" neutrum | mkN "ritual" neutrum ; -- SaldoWN
lin originate_V2 = variants {} ;
lin originate_V = mkV "bottnar" ;
lin hunting_N = mkN "jakt" "jakter" ; -- SaldoWN
lin crude_A = mkA "primitiv" | mkA "rå" "rått" ; -- SaldoWN -- comment=6
lin protocol_N = mkN "protokoll" neutrum; -- comment=2
lin prejudice_N = mkN "fördom" | mkN "skada" ; -- SaldoWN -- comment=2
lin inspiration_N = mkN "inspiration" "inspirationer" ; -- SaldoWN
lin dioxide_N = variants {} ;
lin chemical_A = mkA "kemisk" ;
lin uncomfortable_A = mkA "obekväm" ; -- SaldoWN
lin worthy_A = mkA "värdig" ; -- SaldoWN
lin inspect_V2 = mkV2 (mkV "inspekterar"); -- status=guess, src=wikt
lin summon_V2 = dirV2 (partV (mkV "kallar")"ut");
lin parallel_N = mkN "parallell" "paralleller" | mkN "motsvarande" ; -- SaldoWN -- comment=5
lin outlet_N = mkN "kontakt" "kontakter" | mkN "utlopp" neutrum ; -- SaldoWN -- comment=8
lin okay_A = mkA "okej" ; -- comment=4
lin collaboration_N = mkN "samarbete" ; -- comment=2
lin booking_N = mkN "varning" ; -- comment=4
lin salad_N = mkN "sallad" "sallader" ; -- SaldoWN
lin productive_A = mkA "produktiv" ; -- SaldoWN
lin charming_A = variants{} ;
lin polish_A = variants {} ;
lin oak_N = mkN "ek" ; -- SaldoWN
lin access_V2 = mkV2 (mkV (mkV "ha") "åtkomst"); -- status=guess, src=wikt
lin tourism_N = mkN "turism" "turismer" ; -- SaldoWN
lin independently_Adv = variants{} ;
lin cruel_A = mkA "grym" "grymt" "grymma" "grymma" "grymmare" "grymmast" "grymmaste" | mkA "svår" ; -- SaldoWN -- comment=5
lin diversity_N = mkN "mångfald" "mångfalder" ;
lin accused_A = variants{} ;
lin supplement_N = mkN "bilaga" ; -- comment=4
lin fucking_Adv = variants {} ;
lin forecast_N = mkN "prognos" "prognoser" ;
lin amend_V2V = mkV2V (mkV "korrigerar") | mkV2V (mkV "redigerar") | mkV2V (mkV "ändra"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin amend_V2 = mkV2 (mkV "korrigerar") | mkV2 (mkV "redigerar") | mkV2 (mkV "ändra"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin amend_V = mkV "ändrar" ; -- comment=2
lin soap_N = mkN "tvål" ; -- SaldoWN
lin ruling_N = mkN "avgörande" ; -- comment=3
lin interference_N = mkN "störning" | mkN "kollision" "kollisioner" ; -- SaldoWN -- comment=8
lin executive_A = mkA "verkställande" ; -- SaldoWN
lin mining_N = mkN "gruvdrift" "gruvdrifter" ; -- comment=3
lin minimal_A = mkA "minimal" ; -- SaldoWN
lin clarify_V2 = mkV2 (mkV "förtydliga") | mkV2 (mkV "klargöra"); -- status=guess, src=wikt status=guess, src=wikt
lin clarify_V = mkV "klarnar" ; -- comment=5
lin strain_V2 = mkV2 "spänna" "spände" "spänt" | dirV2 (partV (mkV "silar")"ifrån") ; -- SaldoWN -- comment=4
lin strain_V = mkV "spänna" "spände" "spänt" | mkV "trycker" ; -- SaldoWN -- comment=19
lin novel_A = mkA "ny" "nytt" ; -- comment=2
lin try_N = mkN "försök" neutrum;
lin coastal_A = variants {} ;
lin rising_A = variants{} ;
lin quota_N = mkN "kvot" "kvoter" ; -- SaldoWN
lin minus_Prep = variants {} ;
lin kilometre_N = mkN "kilometer" ; -- SaldoWN
lin characterize_V2 = variants {} ;
lin suspicious_A = mkA "misstänkt" "misstänkt" ; -- comment=3
lin pet_N = mkN "husdjur" neutrum | mkN "sällskapsdjur" neutrum ; -- SaldoWN -- comment=8
lin beneficial_A = mkA "välgörande" ; -- comment=2
lin fling_V2 = dirV2 (partV (mkV "rusar")"ut"); -- comment=22
lin fling_V = mkV "slänger" ; -- comment=10
lin deprive_V2 = mkV2 (mkV "beröva") | mkV2 (mkV "förvägra"); -- status=guess, src=wikt status=guess, src=wikt
lin covenant_N = mkN "överenskommelse" "överenskommelser" ; -- comment=2
lin bias_N = mkN "fördom" ;
lin trophy_N = mkN "trofé" "troféer" ; -- comment=2
lin verb_N = mkN "verb" neutrum;
lin honestly_Adv = variants{} ;
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
lin rightly_Adv = variants{} ;
lin representative_A = mkA "representativ" ; -- SaldoWN
lin code_V2 = dirV2 (partV (mkV "kodar")"av");
lin validity_N = mkN "värde" ; -- comment=3
lin marble_N = mkN "tigerkaka" ; -- status=guess
lin bow_N = mkN "rosett" "rosetter" | mkN "stråke" utrum ; -- SaldoWN -- comment=14
lin plunge_V2 = dirV2 (partV (mkV "slungar")"in"); -- comment=4
lin plunge_V = mkV "stampar" ; -- comment=5
lin maturity_N = variants{} ;
lin maturity_3_N = mkN "mognad" "mognader" ;
lin maturity_2_N = mkN "mognad" "mognader" ;
lin maturity_1_N = mkN "mognad" "mognader" ;
lin hidden_A = variants{} ;
lin contrast_V2 = variants {} ;
lin contrast_V = mkV "kontrasterar" ; -- comment=2
lin tobacco_N = mkN "tobak" ;
lin middle_class_A = variants {} ;
lin grip_V2 = mkV2 (mkV "gripa" "grep" "gripit"); -- status=guess, src=wikt
lin grip_V = mkV "gripa" "grep" "gripit" ; -- comment=3
lin clergy_N = mkN "prästerskap" neutrum; -- comment=2
lin trading_A = variants{} ;
lin passive_A = mkA "passiv" ; -- SaldoWN
lin decoration_N = mkN "prydnad" "prydnader" | mkN "dekorering" ; -- SaldoWN -- comment=9
lin racial_A = mkA "rasmässig" ;
lin well_N = mkN "brunn" | mkN "väl" ; -- SaldoWN -- comment=8
lin embarrassment_N = mkN "bryderi" "bryderit" "bryderier" "bryderierna" | mkN "förlägenhet" "förlägenheter" ; -- SaldoWN -- comment=6
lin sauce_N = mkN "sås" "såser" ; -- SaldoWN
lin fatal_A = mkA "ödesdiger" ; -- comment=8
lin banker_N = mkN "bankir" "bankirer" ; -- comment=2
lin compensate_V2 = variants {} ;
lin compensate_V = mkV "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" ; -- comment=3
lin make_up_N = variants {} ;
lin seat_V2 = variants {} ;
lin popularity_N = mkN "popularitet" "populariteter" ; -- SaldoWN
lin interior_A = mkA "invändig" ;
lin eligible_A = mkA "valbar" | mkA "behörig" ; -- SaldoWN -- comment=5
lin continuity_N = variants {} ;
lin bunch_N = mkN "knippa" ; -- comment=11
lin hook_N = mkN "lockbete" | mkN "krok" ; -- SaldoWN -- comment=6
lin wicket_N = mkN "spelomgång" ; -- comment=5
lin pronounce_VS = mkVS (mkV "uttalar"); -- status=guess, src=wikt
lin pronounce_V2 = mkV2 (mkV "uttalar"); -- status=guess, src=wikt
lin pronounce_V = mkV "uttalar" ; -- comment=6
lin ballet_N = mkN "balett" "baletter" ; -- SaldoWN
lin heir_N = mkN "arvinge" utrum ; -- SaldoWN -- comment=2
lin positively_Adv = variants{} ;
lin insufficient_A = mkA "otillräcklig" ; -- SaldoWN
lin substitute_V2 = mkV2 "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" | mkV2 (mkV "ersätta") | mkV2 (mkV "substituerar") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin substitute_V = mkV "ersätta" "ersätter" "ersätt" "ersatte" "ersatt" "ersatt" ; -- SaldoWN
lin mysterious_A = mkA "mystisk" ;
lin dancer_N = mkN "dansare" utrum; -- comment=3
lin trail_N = mkN "väg" ; -- comment=7
lin caution_N = variants {} ;
lin donation_N = mkN "donation" "donationer" ; -- comment=5
lin added_A = variants{} ;
lin weaken_V2 = variants {} ;
lin weaken_V = mkV "försvagar" ; -- comment=2
lin tyre_N = mkN "däck" neutrum | mkN "ring" neutrum ; -- SaldoWN = mkN "däck" neutrum ; -- comment=5
lin sufferer_N = variants {} ;
lin managerial_A = variants {} ;
lin elaborate_A = compoundA (regA "detaljerad"); -- status=guess
lin restraint_N = mkN "behärskning" | mkN "hinder" neutrum ; -- SaldoWN -- comment=10
lin renew_V2 = mkV2 (mkV "förnya"); -- status=guess, src=wikt
lin gardener_N = variants{} ;
lin dilemma_N = mkN "dilemma" "dilemmat" "dilemman" "dilemmana" ; -- SaldoWN
lin configuration_N = mkN "gestaltning" ; -- comment=2
lin rear_A = variants{} ;
lin embark_V2 = variants {} ;
lin embark_V = variants {} ;
lin misery_N = mkN "elände" ; -- SaldoWN
lin importantly_Adv = variants{} ;
lin continually_Adv = variants{} ;
lin appreciation_N = mkN "värdestegring" ; -- comment=7
lin radical_N = mkN "radikal" "radikaler" ; -- SaldoWN
lin diverse_A = mkA "olik" ; -- comment=2
lin revive_V2 = mkV2 (mkV "återuppliva"); -- status=guess, src=wikt
lin revive_V = mkV "återupplivar" ; -- comment=3
lin trip_V2 = mkV2 (mkV (mkV "göra") "en resa"); -- status=guess, src=wikt
lin trip_V = mkV "utlöser" ; -- comment=8
lin lounge_N = mkN "soffa" | mkN "slöande" ; -- SaldoWN -- comment=4
lin dwelling_N = mkN "boning" ; -- comment=2
lin parental_A = mkA "förälderlig" ; --- should be föräldra-
lin loyal_A = mkA "lojal" ; -- SaldoWN
lin privatisation_N = variants{} ;
lin outsider_N = mkN "outsider" "outsidern" "outsider" "outsiderna" ;
lin forbid_V2 = mkV2 "förbjuda" "förbjöd" "förbjudit" | mkV2 (mkV "förbjuda") ; -- SaldoWN -- status=guess, src=wikt
lin yep_Interj = variants{} ;
lin prospective_A = mkA "presumtiv" ; -- comment=2
lin manuscript_N = mkN "manuskript" neutrum | mkN "manuskript" neutrum ; -- SaldoWN -- comment=2
lin inherent_A = mkA "inneboende" ; -- comment=4
lin deem_V2V = variants {} ;
lin deem_V2A = variants {} ;
lin deem_V2 = variants {} ;
lin telecommunication_N = variants {} ;
lin intermediate_A = mkA "mellanliggande" | mkA "intermediär" ; -- SaldoWN
lin worthwhile_A = variants {} ;
lin calendar_N = mkN "kalender" | mkN "register" neutrum ; -- SaldoWN -- comment=7
lin basin_N = mkN "handfat" neutrum | mkN "bassäng" "bassänger" ; -- SaldoWN -- comment=11
lin utterly_Adv = variants{} ;
lin rebuild_V2 = variants {} ;
lin pulse_N = mkN "slå" ; -- comment=6
lin suppress_V2 = mkV2 (mkV "undertrycker"); -- status=guess, src=wikt
lin predator_N = mkN "rovdjur" neutrum | (mkN "rovdjur" neutrum) | (mkN "predator" "predatorer") ; -- SaldoWN -- status=guess status=guess
lin width_N = mkN "bredd" "bredder" | mkN "våd" "våder" ; -- SaldoWN -- comment=3
lin stiff_A = mkA "styv" ; -- comment=25
lin spine_N = mkN "tagg" ; -- SaldoWN
lin betray_V2 = mkV2 "bedra" "bedrar" "bedra" "bedrog" "bedragit" "bedragen" | mkV2 (mkV "förråda") ; -- SaldoWN -- status=guess, src=wikt
lin punish_V2 = mkV2 (mkV "straffar"); -- status=guess, src=wikt
lin stall_N = mkN "bås" neutrum | mkN "motorstopp" neutrum ; -- SaldoWN -- comment=7
lin lifestyle_N = variants{} ;
lin compile_V2 = mkV2 (mkV "sammanställa"); -- status=guess, src=wikt
lin arouse_V2V = variants {} ;
lin arouse_V2 = dirV2 (partV (mkV "komma" "kom" "kommit")"vid"); -- comment=5
lin partially_Adv = variants{} ;
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
lin circulate_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut");
lin circulate_V = mkV "sprida" "spred" "spritt" ; -- comment=2
lin exploitation_N = mkN "exploatering" ; -- comment=3
lin explicitly_Adv = variants{} ;
lin utterance_N = variants {} ;
lin linear_A = mkA "linjär" ; -- SaldoWN
lin chat_V2 = mkV2 (mkV "småprata") | mkV2 (mkV "konverserar") | mkV2 (mkV "tjatta") | mkV2 (mkV "snackar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin chat_V = mkV "pratar" ; -- comment=4
lin revision_N = variants {} ;
lin distress_N = mkN "svårighet" "svårigheter" ; -- comment=11
lin spill_V2 = mkV2 (mkV "spiller"); -- status=guess, src=wikt
lin spill_V = mkV "spiller" ; -- comment=2
lin steward_N = mkN "steward" ; -- SaldoWN
lin knight_N = mkN "riddare" utrum; -- comment=3
lin sum_V2 = mkV2 (mkV "adderar") | mkV2 (mkV "summerar"); -- status=guess, src=wikt status=guess, src=wikt
lin sum_V = mkV "summar" ;
lin semantic_A = mkA "semantisk" ; -- SaldoWN
lin selective_A = mkA "selektiv" ;
lin learner_N = variants {} ;
lin dignity_N = mkN "värdighet" "värdigheter" | mkN "ädelhet" ; -- SaldoWN -- comment=2
lin senate_N = mkN "senat" "senater" ; -- SaldoWN
lin grid_N = mkN "gitter" neutrum; -- comment=5
lin fiscal_A = mkA "skattemässig" ;
lin activate_V2 = mkV2 (mkV "aktiverar"); -- status=guess, src=wikt
lin rival_A = variants{} ;
lin fortunate_A = mkA "gynnsam" "gynnsamt" "gynnsamma" "gynnsamma" "gynnsammare" "gynnsammast" "gynnsammaste" ; -- comment=2
lin jeans_N = variants{} ;
lin select_A = mkA "utvald" "utvalt" ; -- comment=2
lin fitting_N = mkN "passande" ; -- comment=2
lin commentator_N = mkN "kommentator" "kommentatorer" ;
lin weep_V2 = mkV2 "gråta" "grät" "gråtit" | mkV2 (mkV "gråta") | mkV2 (mkV "grinar") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin weep_V = mkV "gråta" "grät" "gråtit" ; -- SaldoWN
lin handicap_N = mkN "handikapp" neutrum;
lin crush_V2 = mkV2 (mkV "krossar"); -- status=guess, src=wikt
lin crush_V = mkV "krossar" ; -- comment=10
lin towel_N = mkN "handduk" ; -- SaldoWN
lin stay_N = mkN "vistelse" "vistelser" ; -- comment=5
lin skilled_A = mkA "skicklig" ; -- SaldoWN
lin repeatedly_Adv = mkAdv "stundligen" ;
lin defensive_A = mkA "defensiv" ; -- SaldoWN
lin calm_V2 = mkV2 (mkV (mkV "lugna") "sig"); -- status=guess, src=wikt
lin calm_V = mkV "lugnar" ; -- comment=5
lin temporarily_Adv = variants{} ;
lin rain_V2 = mkV2 (mkV "ösregna") | mkV2 (mkV "spöregna") | mkV2 (mkV (mkV "stå") "som spön i backen"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rain_V = mkV "regnar" ;
lin pin_N = mkN "PIN-kod" "PIN-koder" | mkN "skruv" ; -- SaldoWN -- comment=13
lin villa_N = mkN "lyxvilla" ; -- SaldoWN
lin rod_N = mkN "stav" "stäver" ; -- comment=7
lin frontier_N = mkN "gränsområde" ; -- comment=5
lin enforcement_N = mkN "kronofogde" utrum | mkN "genomdrivande" ; -- SaldoWN -- comment=4
lin protective_A = variants {} ;
lin philosophical_A = mkA "filosofisk" | mkA "lugn" ; -- SaldoWN -- comment=2
lin lordship_N = variants {} ;
lin disagree_VS = variants {} ;
lin disagree_V2 = variants {} ;
lin disagree_V = mkV "ogillar" ;
lin boyfriend_N = mkN "pojkvän" "pojkvännen" "pojkvänner" "pojkvännerna" ; -- SaldoWN
lin activist_N = variants{} ;
lin viewer_N = mkN "betraktare" utrum; -- comment=4
lin slim_A = mkA "slank" ; -- comment=9
lin textile_N = mkN "textil" "textiler" ; -- SaldoWN
lin mist_N = mkN "dimma" ; -- SaldoWN
lin harmony_N = mkN "harmoni" "harmonier" ; -- SaldoWN
lin deed_N = mkN "gärning" ; -- comment=4
lin merge_V2 = mkV2 (mkV "sammansmälta") | mkV2 (mkV (mkV "gå") "ihop") | mkV2 (mkV "fusionerar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin merge_V = mkV "sammanfogar" ;
lin invention_N = mkN "uppfinning" ; -- comment=4
lin commissioner_N = mkN "utredare" utrum; -- comment=7
lin caravan_N = mkN "karavan" "karavaner" ; -- comment=2
lin bolt_N = mkN "bult" | mkN "tygrulle" utrum ; -- SaldoWN -- comment=11
lin ending_N = mkN "slut" neutrum; -- comment=3
lin publishing_N = variants{} ;
lin gut_N = L.guts_N;
lin stamp_V2 = dirV2 (partV (mkV "stämplar")"ut"); -- comment=4
lin stamp_V = mkV "utrotar" ; -- comment=11
lin map_V2 = mkV2 (mkV "kartlägga"); -- status=guess, src=wikt
lin loud_Adv = variants {} ;
lin stroke_V2 = mkV2 (mkV "slå"); -- status=guess, src=wikt
lin shock_V2 = variants {} ;
lin rug_N = mkN "tupé" "tupéer" ; -- comment=2
lin picture_V2 = dirV2 (partV (mkV "målar")"om"); -- comment=3
lin slip_N = mkN "halka" | mkN "underkjol" ; -- SaldoWN -- comment=13
lin praise_N = mkN "pris" ; -- comment=15
lin fine_N = mkN "fint" "finter" ; -- comment=12
lin monument_N = mkN "minnesmärke" ; -- comment=6
lin material_A = mkA "textil" | mkA "väsentlig" ; -- SaldoWN -- comment=5
lin garment_N = mkN "plagg" neutrum | mkN "klädesplagg" neutrum ; -- SaldoWN -- comment=3
lin toward_Prep = mkPrep "mot" ; --
lin realm_N = mkN "sfär" ; -- status=guess
lin melt_V2 = mkV2 (mkV "smälta"); -- status=guess, src=wikt
lin melt_V = mkV "veknar" ; -- comment=5
lin reproduction_N = mkN "reproduktion" "reproduktioner" ; -- SaldoWN
lin reactor_N = mkN "reaktor" "reaktorer" ; -- SaldoWN
lin furious_A = mkA "våldsam" "våldsamt" "våldsamma" "våldsamma" "våldsammare" "våldsammast" "våldsammaste" ; -- comment=4
lin distinguished_A = variants{} ;
lin characterize_V2 = variants {} ;
lin alike_Adv = variants {} ;
lin pump_N = mkN "pumpa" ; -- SaldoWN
lin probe_N = mkN "undersökning" ; -- comment=2
lin feedback_N = mkN "återkoppling" ; -- SaldoWN
lin aspiration_N = mkN "sträva" ; -- comment=2
lin suspect_N = mkN "misstro" ; -- comment=2
lin solar_A = mkA "solar" ; -- SaldoWN
lin fare_N = mkN "avgift" "avgifter" | mkN "körning" ; -- SaldoWN -- comment=5
lin carve_V2 = mkV2 "skära" "skar" "skurit" ; -- SaldoWN
lin carve_V = mkV "skära" "skar" "skurit" | mkV "snidar" ; -- SaldoWN -- comment=13
lin qualified_A = variants{} ;
lin membrane_N = mkN "membran" neutrum; -- comment=2
lin dependence_N = mkN "beroende" ; -- SaldoWN = mkN "beroende" ;
lin convict_V2 = variants {} ;
lin bacteria_N = mkN "bakterie" "bakterier" ;
lin trading_N = variants {} ;
lin ambassador_N = mkN "ambassadör" "ambassadörer" ; -- comment=2
lin wound_V2 = mkV2 "sår" | mkV2 (mkV "såra") ; -- SaldoWN -- status=guess, src=wikt
lin drug_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin conjunction_N = mkN "förbindelse" "förbindelser" ; -- comment=5
lin cabin_N = mkN "stuga" | mkN "hytt" "hytter" ; -- SaldoWN -- comment=9
lin trail_V2 = dirV2 (partV (mkV "släpar")"ut"); -- comment=4
lin trail_V = mkV "väger" ; -- comment=7
lin shaft_N = mkN "skaft" neutrum | mkN "skaft" neutrum ; -- SaldoWN -- comment=2
lin treasure_N = mkN "skatt" "skatter" | mkN "klenod" "klenoder" ; -- SaldoWN = mkN "skatt" "skatter" ; -- comment=5
lin inappropriate_A = compoundA (regA "malplacerad");
lin half_Adv = variants {} ;
lin attribute_N = mkN "attribut" neutrum; -- comment=5
lin liquid_A = mkA "likvid" ; -- SaldoWN
lin embassy_N = mkN "ambassad" "ambassader" ; -- SaldoWN
lin terribly_Adv = variants{} ;
lin exemption_N = mkN "immunitet" "immuniteter" | mkN "dispens" "dispenser" ; -- SaldoWN -- comment=4
lin array_N = mkN "stass" ; -- comment=3
lin tablet_N = mkN "tablett" "tabletter" | mkN "skrivtavla" ; -- SaldoWN -- comment=9
lin sack_V2 = dirV2 (partV (mkV "få" "fick" "fått")"till"); -- comment=3
lin erosion_N = mkN "erosion" "erosioner" | mkN "erodering" ; -- SaldoWN
lin bull_N = mkN "tjur" ; -- comment=6
lin warehouse_N = mkN "lagerlokal" "lagerlokaler" ;
lin unfortunate_A = mkA "olycklig" ; -- SaldoWN
lin promoter_N = mkN "promotor" "promotorer" ; -- comment=5
lin compel_VV = variants {} ;
lin compel_V2V = variants {} ;
lin compel_V2 = variants {} ;
lin motivate_V2V = mkV2V (mkV "motiverar"); -- status=guess, src=wikt
lin motivate_V2 = mkV2 (mkV "motiverar"); -- status=guess, src=wikt
lin burning_A = variants{} ;
lin vitamin_N = mkN "vitamin" "vitaminer" ; -- SaldoWN
lin sail_N = mkN "kryssning" | mkN "segel" neutrum ; -- SaldoWN
lin lemon_N = mkN "citron" "citroner" ; -- SaldoWN
lin foreigner_N = mkN "utlänning" ; -- SaldoWN
lin powder_N = mkN "pulver" neutrum | mkN "stoft" neutrum ; -- SaldoWN -- comment=3
lin persistent_A = mkA "ihärdig" ; -- SaldoWN
lin bat_N = mkN "fladdermus" "fladdermusen" "fladdermöss" "fladdermössen" | mkN "piska" ; -- SaldoWN -- comment=9
lin ancestor_N = mkN "anfader" "anfadern" "anfäder" "anfäderna" ; -- comment=2
lin predominantly_Adv = variants{} ;
lin mathematical_A = mkA "matematisk" ; -- SaldoWN
lin compliance_N = mkN "tillmötesgående" ; -- SaldoWN
lin arch_N = mkN "valv" neutrum | mkN "hålfot" "hålfötter" ; -- SaldoWN -- comment=7
lin woodland_N = mkN "skogsland" neutrum; -- comment=3
lin serum_N = mkN "serum" neutrum | mkN "serum" neutrum ; -- SaldoWN
lin overnight_Adv = variants {} ;
lin doubtful_A = mkA "tvivelaktig" ; -- comment=5
lin doing_N = variants{} ;
lin coach_V2 = mkV2 (mkV "träna") | mkV2 (mkV "coacha"); -- status=guess, src=wikt status=guess, src=wikt
lin coach_V = mkV "tränar" ;
lin binding_A = variants{} ;
lin surrounding_A = mkA "kringliggande" ;
lin peer_N = mkN "pär" "pärer" ; -- comment=5
lin ozone_N = mkN "ozon" ; -- SaldoWN
lin mid_A = variants {} ;
lin invisible_A = mkA "osynlig" ; -- SaldoWN
lin depart_V = mkV "avvika" "avvek" "avvikit" | mkV "avreser" ; -- SaldoWN -- comment=4
lin brigade_N = mkN "brigad" "brigader" | mkN "grupp" "grupper" ; -- SaldoWN -- comment=3
lin manipulate_V2 = mkV2 (mkV "manipulerar"); -- status=guess, src=wikt
lin consume_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
lin consume_V = mkV "förtära" "förtärde" "förtärt" ; -- comment=7
lin temptation_N = mkN "frestelse" "frestelser" | mkN "lockelse" "lockelser" ; -- SaldoWN -- comment=2
lin intact_A = mkA "intakt" "intakt" ;
lin glove_N = L.glove_N ;
lin aggression_N = mkN "aggression" "aggressioner" ; -- comment=3
lin emergence_N = mkN "uppkomst" ; -- comment=3
lin stag_V = variants{} ;
lin coffin_N = mkN "kista" | mkN "likkista" ; -- SaldoWN
lin beautifully_Adv = variants{} ;
lin clutch_V2 = variants {} ;
lin clutch_V = mkV "gripa" "grep" "gripit" ; -- comment=4
lin wit_N = mkN "slagfärdighet" ; -- comment=5
lin underline_V2 = mkV2 "understryka" "underströk" "understrukit" | mkV2 (mkV (mkV "stryka") "under") ; -- SaldoWN -- status=guess, src=wikt
lin trainee_N = mkN "praktikant" "praktikanter" ; -- comment=5
lin scrutiny_N = mkN "granskning" ;
lin neatly_Adv = variants{} ;
lin follower_N = mkN "anhängare" utrum; -- comment=5
lin sterling_A = mkA "fullödig" ; -- comment=3
lin tariff_N = mkN "tariff" "tariffer" | mkN "taxa" ; -- SaldoWN -- comment=3
lin bee_N = mkN "bi" "bit" "bin" "bien" ; -- SaldoWN
lin relaxation_N = mkN "avkoppling" | mkN "avslappning" ; -- SaldoWN -- comment=10
lin negligence_N = mkN "försummelse" "försummelser" | mkN "vårdslöshet" "vårdslösheter" ; -- SaldoWN -- comment=6
lin sunlight_N = mkN "solljus" neutrum;
lin penetrate_V2 = mkV2 (mkV "genomtränga") | mkV2 (mkV "penetrerar"); -- status=guess, src=wikt status=guess, src=wikt
lin penetrate_V = mkV "penetrerar" ; -- comment=5
lin knot_N = mkN "knut" | mkN "föreningspunkt" "föreningspunkter" ; -- SaldoWN -- comment=12
lin temper_N = mkN "humör" neutrum;
lin skull_N = mkN "dödskalle" utrum | mkN "kranium" "kraniet" "kranier" "kranierna" ; -- SaldoWN -- comment=3
lin openly_Adv = variants{} ;
lin grind_V2 = dirV2 (partV (mkV "skrapar")"ut"); -- comment=3
lin grind_V = mkV "slipar" ; -- comment=14
lin whale_N = mkN "val" ; -- SaldoWN = mkN "val" neutrum ;
lin throne_N = mkN "tron" "troner" | mkN "biskopsstol" ; -- SaldoWN -- comment=3
lin supervise_V2 = variants {} ;
lin supervise_V = mkV "övervakar" ; -- comment=7
lin sickness_N = mkN "sjukdom" ; -- SaldoWN
lin package_V2 = mkV2 (mkV "packar"); -- status=guess, src=wikt
lin intake_N = mkN "intagning" ; -- comment=3
lin within_Adv = variants{} ;
lin inland_A = variants {} ;
lin beast_N = mkN "best" ; -- comment=8
lin rear_N = mkN "baksida" ; -- comment=4
lin morality_N = mkN "moral" "moraler" ;
lin competent_A = mkA "kompetent" "kompetent" | mkA "tillräcklig" ; -- SaldoWN -- comment=10
lin sink_N = mkN "vask" neutrum | mkN "vask" neutrum ; -- SaldoWN = mkN "vask" ; -- comment=8
lin uniform_A = mkA "uniform" ; -- SaldoWN
lin reminder_N = mkN "påminnelse" "påminnelser" ; -- comment=4
lin permanently_Adv = variants{} ;
lin optimistic_A = mkA "optimistisk" ; -- SaldoWN
lin bargain_N = mkN "affärsuppgörelse" "affärsuppgörelser" ; -- comment=3
lin seemingly_Adv = variants{} ;
lin respective_A = mkA "respektive" ;
lin horizontal_A = mkA "vågrät" | mkA "horisontal" ; -- SaldoWN -- comment=3
lin decisive_A = mkA "avgörande" | mkA "fast" "fast" ; -- SaldoWN -- comment=5
lin bless_V2 = mkV2 (mkV "välsigna"); -- status=guess, src=wikt
lin bile_N = mkN "galla" ; -- comment=3
lin spatial_A = mkA "spatial" ; -- SaldoWN
lin bullet_N = mkN "kula" ; -- SaldoWN
lin respectable_A = mkA "anständig" | mkA "respektabel" ; -- SaldoWN -- comment=3
lin overseas_Adv = mkAdv "utomlands" ; -- comment=2
lin convincing_A = mkA "övertygande" ; -- comment=3
lin unacceptable_A = mkA "oacceptabel" ;
lin confrontation_N = mkN "konfrontation" "konfrontationer" ; -- SaldoWN
lin swiftly_Adv = variants{} ;
lin paid_A = variants{} ;
lin joke_VS = mkVS (mkV "skämta") | mkVS (mkV "skojar"); -- status=guess, src=wikt status=guess, src=wikt
lin joke_V = mkV "skämtar" ; -- comment=4
lin instant_A = mkA "omedelbar" ; -- comment=2
lin illusion_N = mkN "illusion" "illusioner" | mkN "synvilla" ; -- SaldoWN -- comment=5
lin cheer_V2 = mkV2 (mkV "hurrar") | mkV2 (mkV "hejar"); -- status=guess, src=wikt status=guess, src=wikt
lin cheer_V = mkV "jublar" ; -- comment=3
lin congregation_N = variants {} ;
lin worldwide_Adv = variants{} ;
lin winning_A = variants{} ;
lin wake_N = mkN "likvaka" | mkN "väcka" ; -- SaldoWN -- comment=3
lin toss_V2 = dirV2 (partV (mkV "kastar")"ut"); -- comment=8
lin toss_V = mkV "kastar" ; -- comment=5
lin medium_A = mkA "medel" ;
lin jewellery_N = mkN "juvel" "juveler" ; -- comment=2
lin fond_A = mkA "meningslös" ; -- comment=6
lin alarm_V2 = variants {} ;
lin guerrilla_N = mkN "gerilla" ; -- SaldoWN
lin dive_V = mkV "dyker" ; -- comment=2
lin desire_V2 = mkV2 (mkV "begära") | mkV2 (mkV "åtrå"); -- status=guess, src=wikt status=guess, src=wikt
lin cooperation_N = mkN "samarbete" | mkN "kooperation" "kooperationer" ; -- SaldoWN -- comment=2
lin thread_N = mkN "tråd" | mkN "trä" "träet" "trän" "träna" ; -- SaldoWN -- comment=7
lin prescribe_V2 = mkV2 (mkV (mkV "skriva") "ut"); -- status=guess, src=wikt
lin prescribe_V = mkV "bestämmer" ; -- comment=7
lin calcium_N = mkN "kalcium" neutrum;
lin redundant_A = mkA "redundant" "redundant" ;
lin marker_N = mkN "märkpenna" ; -- comment=5
lin chemist_N = variants{} ;
lin mammal_N = mkN "däggdjur" neutrum | mkN "däggdjur" neutrum ; -- SaldoWN
lin legacy_N = mkN "legat" neutrum; -- comment=3
lin debtor_N = mkN "gäldenär" "gäldenärer" ; -- SaldoWN
lin testament_N = variants {} ;
lin tragic_A = mkA "tragisk" ; -- SaldoWN
lin silver_A = mkA "silvergrå" "silvergrått" ; -- comment=2
lin grin_N = mkN "grin" neutrum; -- comment=3
lin spectacle_N = mkN "syn" ; -- comment=4
lin inheritance_N = mkN "arv" neutrum; -- comment=3
lin heal_V2 = variants {} ;
lin heal_V = mkV "läker" ; -- comment=7
lin sovereignty_N = mkN "självständighet" | mkN "oavhängighet" | mkN "suveränitet" ; -- status=guess status=guess status=guess
lin enzyme_N = mkN "enzym" neutrum ; -- SaldoWN
lin host_V2 = variants {} ;
lin neighbouring_A = variants{} ;
lin corn_N = mkN "majs" | mkN "vete" ; -- SaldoWN -- comment=10
lin layout_N = mkN "layout" "layouter" ; -- SaldoWN
lin dictate_VS = variants {} ;
lin dictate_V2 = variants {} ;
lin dictate_V = mkV "dikterar" ; -- comment=4
lin rip_V2 = variants {} ;
lin rip_V = mkV "revar" ; -- comment=2
lin regain_V2 = variants {} ;
lin probable_A = mkA "trolig" ; -- comment=5
lin inclusion_N = mkN "inbegripande" ;
lin booklet_N = mkN "häfte" ; -- comment=3
lin bar_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=7
lin privately_Adv = variants{} ;
lin laser_N = mkN "laser" ; -- SaldoWN
lin fame_N = mkN "berömmelse" utrum | mkN "berömmelse" utrum ; -- SaldoWN -- comment=4
lin bronze_N = mkN "brons" "bronser" | mkN "brons" neutrum ; -- SaldoWN = mkN "brons" neutrum ; -- comment=4
lin mobile_A = mkA "rörlig" | mkA "mobil" ; -- SaldoWN -- comment=6
lin metaphor_N = mkN "metafor" "metaforen" "metaforer" "metaforerna" ; -- SaldoWN
lin complication_N = mkN "komplikation" "komplikationer" ; -- SaldoWN
lin narrow_V2 = variants {} ;
lin narrow_V = mkV "begränsar" ; -- comment=2
lin old_fashioned_A = variants {} ;
lin chop_V2 = dirV2 (partV (mkV "hackar")"av");
lin chop_V = mkV "hugga" "högg" "huggit" ; -- comment=4
lin synthesis_N = mkN "syntes" "synteser" ; -- comment=2
lin diameter_N = mkN "diameter" ; -- SaldoWN
lin bomb_V2 = mkV2 (mkV "bombardera" | mkV "bombar") ;
lin bomb_V = mkV "bombar" ; -- comment=3
lin silently_Adv = variants{} ;
lin shed_N = mkN "fälla" ; -- comment=3
lin fusion_N = mkN "sammansmältning" ; -- comment=5
lin trigger_V2 = dirV2 (partV (mkV "startar")"om");
lin printing_N = variants {} ;
lin onion_N = mkN "lök" ; -- SaldoWN
lin dislike_V2 = mkV2 (mkV (mkV "tycker") "illa") (mkPrep "om");
lin embody_V2 = mkV2 (mkV "förkroppsliga"); -- status=guess, src=wikt
lin curl_V2 = dirV2 (partV (mkV "lockar")"in");
lin curl_V = mkV "ringer" ; -- comment=7
lin sunshine_N = mkN "solsken" neutrum | mkN "solsken" neutrum ; -- SaldoWN
lin sponsorship_N = variants {} ;
lin rage_N = mkN "ilska" | mkN "ursinne" ; -- SaldoWN -- comment=2
lin loop_N = mkN "slinga" | mkN "ögla" ; -- SaldoWN -- comment=6
lin halt_N = mkN "anhalt" "anhalter" | mkN "stopp" ; -- SaldoWN -- comment=10
lin cop_V2 = variants {} ;
lin cop_V = mkV "haffar" ; -- comment=2
lin bang_V2 = dirV2 (partV (mkV "smälla" "small" "smäll")"av"); -- comment=16
lin bang_V = mkV "smälla" "small" "smäll" ; -- comment=10
lin toxic_A = mkA "giftig" ; -- SaldoWN
lin thinking_A = variants{} ;
lin orientation_N = mkN "riktning" | mkN "orientering" ; -- SaldoWN -- comment=2
lin likelihood_N = mkN "sannolikhet" "sannolikheter" ;
lin wee_A = mkA "liten" "litet" "lilla" "små" "mindre" "minst" "minsta" ; -- status=guess
lin up_to_date_A = variants {} ;
lin polite_A = mkA "artig" | compoundA (regA "bildad") ; -- SaldoWN -- comment=7
lin apology_N = mkN "avbön" "avböner" | mkN "ursäkt" "ursäkter" ; -- SaldoWN -- comment=4
lin exile_N = mkN "utvisning" | mkN "landsflykting" ; -- SaldoWN -- comment=4
lin brow_N = mkN "ögonbryn" neutrum; -- comment=6
lin miserable_A = mkA "olycklig" ; -- comment=10
lin outbreak_N = mkN "utbrott" neutrum;
lin comparatively_Adv = variants{} ;
lin pump_V2 = dirV2 (partV (mkV "pumpar")"in");
lin pump_V = mkV "öser" ; -- comment=2
lin fuck_V2 = dirV2 (partV (mkV "knullar")"runt");
lin fuck_V = mkV "knullar" ;
lin forecast_VS = mkVS (mkV "förutsäga") | mkVS (mkV "förutse"); -- status=guess, src=wikt status=guess, src=wikt
lin forecast_V2 = mkV2 (mkV "förutsäga") | mkV2 (mkV "förutse"); -- status=guess, src=wikt status=guess, src=wikt
lin forecast_V = mkV "förutsäga" "förutsade" "förutsagt" ; -- comment=3
lin timing_N = mkN "kamrem" ; -- status=guess
lin headmaster_N = mkN "rektor" "rektorer" ; -- comment=2
lin terrify_V2 = variants {} ;
lin sigh_N = mkN "suck" ; -- comment=2
lin premier_A = mkA "förnäm" "förnämare" "förnämst" ;
lin joint_N = mkN "led" "leder" | mkN "hak" neutrum ; -- SaldoWN = mkN "led" neutrum ; = mkN "led" neutrum ; -- comment=11
lin incredible_A = mkA "otrolig" ; -- SaldoWN
lin gravity_N = mkN "gravitation" "gravitationer" ; -- SaldoWN
lin regulatory_A = variants{} ;
lin cylinder_N = mkN "cylinder" ; -- SaldoWN
lin curiosity_N = mkN "nyfikenhet" "nyfikenheter" ; -- comment=6
lin resident_A = mkA "bosatt" | mkA "bofast" "bofast" ; -- SaldoWN -- comment=2
lin narrative_N = mkN "berättelse" "berättelser" | mkN "berättande" ; -- SaldoWN -- comment=3
lin cognitive_A = mkA "kognitiv" ;
lin lengthy_A = mkA "omständlig" ; -- comment=2
lin gothic_A = mkA "gotisk" ;
lin dip_V2 = dirV2 (partV (mkV "tvättar")"av");
lin dip_V = mkV "sänker" ; -- comment=11
lin adverse_A = variants {} ;
lin accountability_N = mkN "tillräknelighet" ;
lin hydrogen_N = mkN "väte" ; -- comment=2
lin gravel_N = mkN "grus" neutrum ; -- SaldoWN
lin willingness_N = variants {} ;
lin inhibit_V2 = mkV2 (mkV "hämma") | mkV2 (mkV (mkV "att") "avstyra") | mkV2 (mkV (mkV "att") "förhindra"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin attain_V2 = variants {} ;
lin attain_V = mkV "förvärvar" ;
lin specialize_V2 = variants {} ;
lin specialize_V = variants {} ;
lin steer_V2 = mkV2 (mkV "styra" "styrde" "styrt"); -- status=guess, src=wikt
lin steer_V = mkV "styra" "styrde" "styrt" ;
lin selected_A = variants{} ;
lin like_N = mkN "liknande" ; -- comment=2
lin confer_V2 = mkV2 (mkV "tilldelar"); -- status=guess, src=wikt
lin confer_V = mkV "tilldelar" ; -- comment=5
lin usage_N = mkN "språkbruk" neutrum; -- comment=10
lin portray_V2 = variants {} ;
lin planner_N = variants {} ;
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
lin corps_N = mkN "kår" "kårer" ;
lin proclaim_VS = mkVS (mkV "förkunna"); -- status=guess, src=wikt
lin proclaim_V2 = dirV2 (partV (mkV "visar")"in");
lin multiply_V2 = mkV2 (mkV "multiplicerar"); -- status=guess, src=wikt
lin multiply_V = mkV "förökar" ; -- comment=3
lin brochure_N = mkN "broschyr" "broschyrer" ; -- SaldoWN
lin screen_V2 = dirV2 (partV (mkV "visar")"in"); -- comment=3
lin screen_V = mkV "visar" ; -- comment=21
lin orthodox_A = mkA "ortodox" | mkA "vedertagen" "vedertaget" ; -- SaldoWN -- comment=5
lin locomotive_N = mkN "lok" neutrum | mkN "lok" neutrum ; -- SaldoWN
lin considering_Prep = variants{} ;
lin unaware_A = mkA "omedveten" "omedvetet" ; -- SaldoWN
lin syndrome_N = mkN "syndrom" neutrum | mkN "syndrom" neutrum ; -- SaldoWN
lin reform_V2 = mkV2 (mkV "reformerar"); -- status=guess, src=wikt
lin reform_V = mkV "reformerar" ;
lin confirmation_N = mkN "styrkande" ; -- comment=6
lin printed_A = variants{} ;
lin curve_V2 = mkV2 (mkV "böja") | mkV2 (mkV "kröka"); -- status=guess, src=wikt status=guess, src=wikt
lin curve_V = mkV "böja" "böjde" "böjt" ; -- comment=6
lin costly_A = mkA "kostsam" "kostsamt" "kostsamma" "kostsamma" "kostsammare" "kostsammast" "kostsammaste" ; -- comment=4
lin underground_A = mkA "underjordisk" ;
lin territorial_A = mkA "territoriell" ;
lin designate_VS = variants {} ;
lin designate_V2V = variants {} ;
lin designate_V2 = mkV2 (mkV "utse" "utsåg" "utsett");
lin designate_V = mkV "utse" "utsåg" "utsett" ; -- comment=8
lin comfort_V2 = variants {} ;
lin plot_V2 = dirV2 (partV (mkV "ritar")"ut"); -- comment=3
lin plot_V = mkV "planerar" ; -- comment=7
lin misleading_A = variants{} ;
lin weave_V2 = mkV2 (mkV "väva"); -- status=guess, src=wikt
lin weave_V = mkV "väver" ;
lin scratch_V2 = L.scratch_V2;
lin scratch_V = mkV "stryka" "strök" "strukit" ; -- comment=15
lin echo_N = mkN "eko" "ekot" "ekon" "ekona" ; -- SaldoWN
lin ideally_Adv = variants{} ;
lin endure_V2 = variants {} ;
lin endure_V = mkV "bestå" "bestod" "bestådd" ; -- comment=6
lin verbal_A = mkA "muntlig" | mkA "verbal" ; -- SaldoWN -- comment=2
lin stride_V2 = mkV2 "kliva" "klev" "klivit" ; -- SaldoWN
lin stride_V = mkV "kliva" "klev" "klivit" | mkV "skriva" "skrev" "skrivit" ; -- SaldoWN -- comment=5
lin nursing_N = mkN "vård" ; -- comment=6
lin exert_V2 = variants {} ;
lin compatible_A = mkA "förenlig" ; -- SaldoWN
lin causal_A = variants {} ;
lin mosaic_N = mkN "mosaik" "mosaiker" ; -- SaldoWN
lin manor_N = mkN "polisdistrikt" neutrum; -- comment=4
lin implicit_A = mkA "implicit" "implicit" | mkA "underförstådd" ; -- SaldoWN -- comment=7
lin following_Prep = variants{} ;
lin fashionable_A = mkA "fashionabel" | mkA "moderiktig" ; -- SaldoWN -- comment=3
lin valve_N = mkN "klaff" ; -- comment=6
lin proceed_N = variants{} ;
lin sofa_N = mkN "soffa" ; -- status=guess
lin snatch_V2 = variants {} ;
lin snatch_V = mkV "hugga" "högg" "huggit" ; -- comment=4
lin jazz_N = mkN "jazz" ; -- SaldoWN
lin patron_N = mkN "beskyddare" utrum; -- comment=5
lin provider_N = mkN "familjeförsörjare" utrum;
lin interim_A = mkA "provisorisk" ;
lin intent_N = mkN "uppsåt" neutrum; -- comment=3
lin chosen_A = variants{} ;
lin applied_A = variants{} ;
lin shiver_V2 = dirV2 (partV (mkV "skakar")"om"); -- comment=2
lin shiver_V = mkV "darrar" ; -- comment=5
lin pie_N = mkN "paj" "pajer" ; -- SaldoWN
lin fury_N = mkN "raseri" neutrum; -- comment=2
lin abolition_N = mkN "avskaffande" ; -- comment=4
lin soccer_N = mkN "fotboll" ; -- SaldoWN = mkN "fotboll" ;
lin corpse_N = mkN "lik" neutrum;
lin accusation_N = mkN "anklagelse" "anklagelser" ; -- comment=2
lin kind_A = mkA "snäll" | mkA "vänlig" ; -- SaldoWN -- comment=7
lin dead_Adv = mkAdv "absolut" ; -- comment=6
lin nursing_A = variants{} ;
lin contempt_N = mkN "förakt" neutrum ; -- SaldoWN
lin prevail_V2 = mkV2 (mkV "förhärska"); -- status=guess, src=wikt
lin prevail_V = mkV "segrar" ; -- comment=4
lin murderer_N = mkN "mördare" utrum | mkN "mördare" utrum ; -- SaldoWN
lin liberal_N = mkN "liberal" "liberaler" ;
lin gathering_N = mkN "sammankomst" "sammankomster" ; -- comment=3
lin adequately_Adv = variants{} ;
lin subjective_A = mkA "subjektiv" ; -- SaldoWN
lin disagreement_N = mkN "oenighet" "oenigheter" | mkN "tvist" "tvister" ; -- SaldoWN -- comment=5
lin cleaner_N = mkN "städare" utrum; -- comment=2
lin boil_V2 = dirV2 (partV (mkV "kokar")"över"); -- comment=2
lin boil_V = mkV "kokar" ; -- comment=3
lin static_A = mkA "statisk" ; -- SaldoWN
lin scent_N = mkN "väderkorn" neutrum; -- comment=8
lin civilian_N = mkN "civilist" "civilister" ; -- SaldoWN
lin monk_N = mkN "munk" ; -- SaldoWN
lin abruptly_Adv = variants{} ;
lin keyboard_N = mkN "tangentbord" neutrum;
lin hammer_N = mkN "hammare" "hammaren" "hamrar" "hamrarna" | mkN "hane" utrum ; -- SaldoWN -- comment=3
lin despair_N = mkN "sorgebarn" neutrum;
lin controller_N = mkN "ledare" utrum; -- comment=6
lin yell_V2 = variants {} ;
lin yell_V = mkV "skrika" "skrek" "skrikit" ; -- comment=6
lin entail_V2 = variants {} ;
lin cheerful_A = mkA "gladlynt" "gladlynt" | mkA "villig" ; -- SaldoWN -- comment=8
lin reconstruction_N = mkN "rekonstruktion" "rekonstruktioner" ; -- comment=3
lin patience_N = mkN "tålamod" neutrum | mkN "uthållighet" "uthålligheter" ; -- SaldoWN -- comment=3
lin legally_Adv = variants{} ;
lin habitat_N = mkN "boning" | mkN "livsmiljö" "livsmiljön" "livsmiljöer" "livsmiljöerna" ; -- SaldoWN
lin queue_N = mkN "kö" "kön" "köer" "köerna" ; -- SaldoWN
lin spectator_N = variants{} ;
lin given_A = variants{} ;
lin purple_A = variants {} ;
lin outlook_N = mkN "åskådning" ; -- SaldoWN
lin genius_N = mkN "briljans" | mkN "väsen" neutrum ; -- SaldoWN -- comment=10
lin dual_A = variants {} ;
lin canvas_N = mkN "smärting" | mkN "tält" neutrum ; -- SaldoWN -- comment=12
lin grave_A = mkA "grav" ; -- SaldoWN
lin pepper_N = mkN "paprika" ;
lin conform_V2 = variants {} ;
lin conform_V = mkV "överensstämmer" ;
lin cautious_A = mkA "aktsam" "aktsamt" "aktsamma" "aktsamma" "aktsammare" "aktsammast" "aktsammaste" | mkA "försiktig" ; -- SaldoWN -- comment=4
lin dot_N = mkN "punkt" "punkter" ; -- comment=3
lin conspiracy_N = mkN "komplott" "komplotter" ; -- SaldoWN
lin butterfly_N = mkN "fjäril" ; -- SaldoWN
lin sponsor_N = mkN "sponsor" "sponsorer" ; -- comment=4
lin sincerely_Adv = variants{} ;
lin rating_N = mkN "värdering" ; -- comment=5
lin weird_A = mkA "kuslig" ; -- comment=6
lin teenage_A = mkA "tonårig" ;
lin salmon_N = mkN "lax" ; -- SaldoWN
lin recorder_N = mkN "blockflöjt" ; -- status=guess
lin postpone_V2 = mkV2 "senarelägga" "senarelade" "senarelagt" | mkV2 (mkV "uppskjuta" "uppsköt" "uppskjutit") | mkV2 (mkV "senarelägga") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin maid_N = mkN "piga" | mkN "ungmö" "ungmön" "ungmör" "ungmörna" ; -- SaldoWN -- comment=6
lin furnish_V2 = mkV2 (mkV "inreda" "inredde" "inrett") | mkV2 (mkV "möblera"); -- status=guess, src=wikt status=guess, src=wikt
lin ethical_A = mkA "etisk" ; -- SaldoWN
lin bicycle_N = mkN "cykel" ; -- comment=2
lin sick_N = mkN "illamående" ; -- comment=2
lin sack_N = mkN "cape" "caper" ; -- comment=11
lin renaissance_N = mkN "renässans" "renässanser" ;
lin luxury_N = mkN "lyx" ; -- comment=3
lin gasp_V2 = mkV2 (mkV "flämta") | mkV2 (mkV "kippar"); -- status=guess, src=wikt status=guess, src=wikt
lin gasp_V = mkV "flämtar" ; -- comment=2
lin wardrobe_N = mkN "garderob" "garderober" ; -- SaldoWN
lin native_N = mkN "inföding" ;
lin fringe_N = mkN "ytterkant" "ytterkanter" ; -- comment=6
lin adaptation_N = mkN "anpassning" ; -- comment=6
lin quotation_N = mkN "notering" | mkN "citerande" ; -- SaldoWN -- comment=12
lin hunger_N = mkN "hunger" ;
lin enclose_V2 = dirV2 (partV (mkV "sänder")"efter");
lin disastrous_A = mkA "katastrofal" ; -- comment=3
lin choir_N = mkN "kor" neutrum; -- comment=2
lin overwhelming_A = variants{} ;
lin glimpse_N = mkN "skymt" ; -- SaldoWN
lin divorce_V2 = dirV2 (partV (mkV "skilja")"av"); -- comment=2
lin circular_A = mkA "cirkulär" ; -- comment=3
lin locality_N = mkN "lokalitet" "lokaliteter" ; -- comment=3
lin ferry_N = mkN "färja" ; -- SaldoWN
lin balcony_N = mkN "balkong" "balkonger" ; -- SaldoWN
lin sailor_N = mkN "sjöman" "sjömannen" "sjömän" "sjömännen" | mkN "seglare" utrum ; -- SaldoWN
lin precision_N = mkN "precision" "precisioner" ; -- SaldoWN
lin desert_V2 = variants {} ;
lin desert_V = mkV "överge" "överger" "överge" "övergav" "övergett" "övergiven" ; -- comment=4
lin dancing_N = mkN "dans" "danser" ;
lin alert_V2 = variants {} ;
lin surrender_V2 = mkV2 (mkV (mkV "ge") "sig"); -- status=guess, src=wikt
lin surrender_V = mkV "överlämnar" ; -- comment=4
lin archive_N = mkN "arkiv" neutrum | mkN "förråd" neutrum ; -- SaldoWN -- comment=2
lin jump_N = mkN "hopp" neutrum | mkN "smita" ; -- SaldoWN -- comment=6
lin philosopher_N = mkN "filosof" "filosofer" ; -- SaldoWN
lin revival_N = mkN "återupplivande" ; -- SaldoWN
lin presume_VV = mkVV (mkV "förmoda") | mkVV (mkV "förutsätta"); -- status=guess, src=wikt status=guess, src=wikt
lin presume_VS = mkVS (mkV "förmoda") | mkVS (mkV "förutsätta"); -- status=guess, src=wikt status=guess, src=wikt
lin presume_V2 = mkV2 (mkV "förmoda") | mkV2 (mkV "förutsätta"); -- status=guess, src=wikt status=guess, src=wikt
lin presume_V = mkV "anta" "antar" "anta" "antog" "antagit" "antagen" ; -- comment=3
lin node_N = mkN "nod" "noder" ; -- SaldoWN
lin fantastic_A = mkA "fantastisk" ; -- comment=4
lin herb_N = mkN "ört" "örter" ; -- SaldoWN
lin assertion_N = mkN "påstående" ; -- SaldoWN
lin thorough_A = mkA "grundlig" ; -- comment=3
lin quit_V2 = mkV2 (mkV "slutar") | mkV2 (mkV (mkV "sluta") "upp") | mkV2 (mkV "upphöra") | mkV2 (mkV (mkV "höra") "upp"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin quit_V = (mkV "slutar") | mkV (mkV "sluta") "upp" | mkV "upphöra" | mkV (mkV "höra") "upp" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grim_A = mkA "sträng" ; -- comment=11
lin fair_N = mkN "karneval" "karnevaler" | mkN "lovande" ; -- SaldoWN -- comment=3
lin broadcast_V2 = dirV2 (partV (mkV "talar")"om"); -- comment=4
lin broadcast_V = mkV "uppträda" "uppträdde" "uppträtt" ; -- comment=5
lin annoy_V2 = variants {} ;
lin divert_V2 = dirV2 (partV (mkV "dra" "drar" "dra" "drog" "dragit" "dragen")"ut"); -- comment=6
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
lin lodge_V2 = variants {} ;
lin lodge_V = mkV "sätta" "sätter" "sätt" "satte" "satt" "satt" ; -- comment=11
lin landowner_N = mkN "markägare" utrum ; -- SaldoWN
lin ignorance_N = mkN "okunnighet" "okunnigheter" ; -- SaldoWN
lin discourage_V2 = mkV2 (mkV "discourage"); -- status=guess, src=wikt
lin bride_N = mkN "brud" ; -- SaldoWN
lin likewise_Adv = mkAdv "likväl" ; -- comment=2
lin depressed_A = variants{} ;
lin abbey_N = mkN "kloster" neutrum ; -- SaldoWN
lin quarry_N = mkN "villebråd" neutrum; -- comment=8
lin archbishop_N = mkN "ärkebiskop" ;
lin sock_N = L.sock_N ;
lin large_scale_A = variants {} ;
lin glare_V2 = variants {} ;
lin glare_V = mkV "glor" ; -- comment=3
lin descent_N = mkN "börd" | mkN "överfall" neutrum ; -- SaldoWN -- comment=15
lin stumble_V = mkV "stapplar" ; -- comment=3
lin mistress_N = mkN "älskarinna" ; -- comment=7
lin empty_V2 = dirV2 (partV (mkV "vattnar")"ur"); -- comment=16
lin empty_V = mkV "tömmer" ; -- comment=2
lin prosperity_N = mkN "välstånd" neutrum | mkN "lycka" ; -- SaldoWN -- comment=7
lin harm_V2 = variants {} ;
lin formulation_N = mkN "formulering" ; -- comment=2
lin atomic_A = mkA "atomär" ;
lin agreed_A = variants{} ;
lin wicked_A = mkA "stygg" ; -- comment=13
lin threshold_N = mkN "tröskel" | mkN "tröskelvärde" ; -- SaldoWN -- comment=2
lin lobby_N = mkN "lobby" "lobbyer" | mkN "hall" ; -- SaldoWN -- comment=4
lin repay_V2 = variants {} ;
lin repay_V = mkV "återgäldar" ; -- comment=3
lin varying_A = variants{} ;
lin track_V2 = mkV2 "spår" | dirV2 (partV (mkV "spårar")"ur") ; -- SaldoWN
lin track_V = mkV "spår" ; -- SaldoWN
lin crawl_V = mkV "krypa" "kröp" "krupit" ; -- comment=9
lin tolerate_V2 = mkV2 (mkV "tolererar"); -- status=guess, src=wikt
lin salvation_N = mkN "räddning" ; -- SaldoWN
lin pudding_N = mkN "pudding" ; -- SaldoWN
lin counter_VS = mkVS (mkV (mkV "gå") "till motanfallmotattack") ; -- status=guess, src=wikt status=guess, src=wikt
lin counter_V2 = mkV2 (mkV (mkV "gå") "till motanfallmotattack") ; -- status=guess, src=wikt status=guess, src=wikt
lin counter_V = mkV "motarbetar" ; -- comment=2
lin propaganda_N = mkN "propaganda" ; -- SaldoWN
lin cage_N = mkN "bur" | mkN "hiss" ; -- SaldoWN -- comment=3
lin broker_N = mkN "mäklare" utrum ; -- SaldoWN -- comment=3
lin ashamed_A = mkA "skamsen" "skamset" ; -- SaldoWN
lin scan_V2 = dirV2 (partV (mkV "skummar")"av");
lin scan_V = mkV "scannar" ; -- comment=5
lin document_V2 = variants {} ;
lin apparatus_N = mkN "apparat" "apparater" ; -- SaldoWN
lin theology_N = mkN "teologi" ; -- SaldoWN
lin analogy_N = mkN "analogi" "analogier" ; -- SaldoWN
lin efficiently_Adv = variants{} ;
lin bitterly_Adv = variants{} ;
lin performer_N = mkN "artist" "artister" | mkN "uppträdande" ; -- SaldoWN
lin individually_Adv = variants{} ;
lin amid_Prep = variants {} ;
lin squadron_N = mkN "skvadron" "skvadroner" ; -- comment=3
lin sentiment_N = mkN "sentiment" neutrum | mkN "uppfattning" ; -- SaldoWN -- comment=5
lin making_N = mkN "tillverkning" ; -- comment=5
lin exotic_A = mkA "exotisk" ; -- SaldoWN
lin dominance_N = mkN "herravälde" ; -- comment=4
lin coherent_A = mkA "följdriktig" ;
lin placement_N = mkN "placering" ;
lin flick_V2 = mkV2 (mkV (mkV "peka") "finger") | mkV2 (mkV (mkV "ge") "fingret"); -- status=guess, src=wikt status=guess, src=wikt
lin colourful_A = mkA "färgstark" | mkA "färgrik" ; -- SaldoWN
lin mercy_N = mkN "förskoning" | mkN "tur" ; -- SaldoWN -- comment=12
lin angrily_Adv = variants{} ;
lin amuse_V2 = variants {} ;
lin mainstream_N = variants {} ;
lin appraisal_N = mkN "värdering" ; -- comment=5
lin annually_Adv = variants{} ;
lin torch_N = mkN "fackla" | mkN "bloss" neutrum ; -- SaldoWN -- comment=3
lin intimate_A = mkA "väsentlig" ; -- comment=9
lin gold_A = variants {} ;
lin arbitrary_A = mkA "godtycklig" | mkA "slumpmässig" ; -- SaldoWN -- comment=9
lin venture_VS = variants {} ;
lin venture_V2 = variants {} ;
lin venture_V = mkV "vågar" ; -- comment=3
lin preservation_N = mkN "bevarande" | mkN "vård" ; -- SaldoWN -- comment=10
lin shy_A = mkA "osäker" | mkA "tveksam" "tveksamt" "tveksamma" "tveksamma" "tveksammare" "tveksammast" "tveksammaste" ; -- SaldoWN -- comment=8
lin disclosure_N = mkN "yppande" ; -- comment=3
lin lace_N = mkN "spets" | mkN "trä" "träet" "trän" "träna" ; -- SaldoWN -- comment=5
lin inability_N = mkN "oförmåga" ;
lin motif_N = mkN "motiv" neutrum | mkN "motiv" neutrum ; -- SaldoWN -- comment=3
lin listener_N = variants{} ;
lin hunt_N = mkN "jakt" "jakter" ;
lin delicious_A = mkA "utsökt" "utsökt" ; -- comment=2
lin term_VS = variants {} ;
lin term_V2 = dirV2 (partV (mkV "kallar")"ut");
lin substitute_N = mkN "ersättning" ; -- comment=10
lin highway_N = mkN "kungsväg" ; -- comment=3
lin haul_V2 = dirV2 (partV (mkV "forslar")"in"); -- comment=17
lin haul_V = mkV "transporterar" ; -- comment=9
lin dragon_N = mkN "drake" utrum ; -- SaldoWN -- comment=2
lin chair_V2 = variants {} ;
lin accumulate_V2 = mkV2 (mkV "ackumulerar"); -- status=guess, src=wikt
lin accumulate_V = mkV "samlar" ; -- comment=5
lin unchanged_A = compoundA (regA "oförändrad");
lin sediment_N = mkN "sediment" neutrum | mkN "sediment" neutrum ; -- SaldoWN
lin sample_V2 = variants {} ;
lin exclaim_VQ = mkVQ (mkV "utbrista" "utbrast" "utbrustit"); -- status=guess, src=wikt
lin exclaim_V2 = dirV2 (partV (mkV "ropar")"till");
lin exclaim_V = mkV "utropar" ; -- comment=4
lin fan_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut");
lin fan_V = mkV "underblåser" ; -- comment=4
lin volunteer_VS = variants {} ;
lin volunteer_V2V = variants {} ;
lin volunteer_V2 = variants {} ;
lin volunteer_V = variants {} ;
lin root_V2 = mkV2 (mkV "rotar") | mkV2 (mkV "böka"); -- status=guess, src=wikt status=guess, src=wikt
lin root_V = mkV "rotar" ; -- comment=2
lin parcel_N = mkN "paket" neutrum; -- comment=2
lin psychiatric_A = mkA "psykiatrisk" ; -- SaldoWN
lin delightful_A = mkA "behaglig" ; -- comment=7
lin confidential_A = mkA "konfidentiell" ; -- comment=2
lin calorie_N = mkN "kalori" "kalorier" ; -- SaldoWN
lin flash_N = mkN "ögonblick" neutrum | mkN "utbrott" neutrum ; -- SaldoWN -- comment=16
lin crowd_V2 = dirV2 (partV (mkV "knuffar")"ut");
lin crowd_V = mkV "överhopar" ; -- comment=7
lin aggregate_A = mkA "sammanlagd" "sammanlagt" ; -- comment=2
lin scholarship_N = mkN "stipendium" "stipendiet" "stipendier" "stipendierna" ; -- SaldoWN
lin monitor_N = mkN "övervakare" utrum; -- comment=9
lin disciplinary_A = mkA "disciplinär" ;
lin rock_V2 = dirV2 (partV (mkV "skakar")"om"); -- comment=2
lin rock_V = mkV "vaggar" ; -- comment=9
lin hatred_N = mkN "hat" neutrum; -- status=guess
lin pill_N = mkN "p-piller" neutrum | mkN "p-piller" neutrum ; -- SaldoWN -- comment=3
lin noisy_A = mkA "bullrig" ; -- SaldoWN
lin feather_N = L.feather_N ;
lin lexical_A = variants {} ;
lin staircase_N = mkN "trappa" ; -- SaldoWN
lin autonomous_A = mkA "autonom" ; -- comment=3
lin viewpoint_N = mkN "utsiktspunkt" "utsiktspunkter" ; -- comment=4
lin projection_N = mkN "projektion" "projektioner" | mkN "utslungande" ; -- SaldoWN -- comment=6
lin offensive_A = mkA "offensiv" ; -- SaldoWN
lin controlled_A = variants{} ;
lin flush_V2 = dirV2 (partV (mkV "spolar")"över"); -- comment=2
lin flush_V = mkV "spolar" ; -- comment=2
lin racism_N = mkN "rasism" "rasismer" ; -- SaldoWN
lin flourish_V2 = mkV2 (mkV "blomstrar") | mkV2 (mkV "frodas"); -- status=guess, src=wikt status=guess, src=wikt
lin flourish_V = mkV "svänger" ; -- comment=9
lin resentment_N = mkN "harm" ; -- SaldoWN
lin pillow_N = mkN "kudde" utrum | mkN "huvudkudde" utrum ; -- SaldoWN -- comment=3
lin courtesy_N = mkN "artighet" "artigheter" | mkN "hövlighet" "hövligheter" ; -- SaldoWN -- comment=2
lin photography_N = mkN "fotografering" | mkN "fotografi" "fotografit" "fotografier" "fotografierna" ; -- SaldoWN
lin monkey_N = mkN "apa" ; -- SaldoWN
lin glorious_A = mkA "ärofull" | mkA "ärorik" ; -- SaldoWN -- comment=5
lin evolutionary_A = variants {} ;
lin gradual_A = mkA "successiv" | mkA "gradvis" ; -- SaldoWN -- comment=2
lin bankruptcy_N = mkN "konkurs" "konkurser" ; -- SaldoWN
lin sacrifice_N = mkN "offer" neutrum | mkN "offer" neutrum ; -- SaldoWN -- comment=3
lin uphold_V2 = mkV2 (mkV "upprätthålla"); -- status=guess, src=wikt
lin sketch_N = mkN "skämtteckning" | mkN "skiss" "skisser" ; -- SaldoWN -- comment=4
lin presidency_N = mkN "presidentskap" neutrum | mkN "presidentskap" neutrum ; -- SaldoWN
lin formidable_A = mkA "formidabel" ;
lin differentiate_V2 = dirV2 (partV (mkV "skilja")"av"); -- comment=2
lin differentiate_V = mkV "skilja" "skilde" "skilt" ; -- comment=3
lin continuing_A = variants{} ;
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
lin screw_V = mkV "skruvar" ;
lin harvest_N = mkN "skörd" ; -- SaldoWN
lin foster_V2 = variants {} ;
lin academic_N = mkN "akademiker" "akademikern" "akademiker" "akademikerna" ; -- comment=2
lin impulse_N = mkN "ingivelse" "ingivelser" ; -- SaldoWN
lin guardian_N = mkN "väktare" utrum; -- comment=3
lin ambiguity_N = mkN "tvetydighet" "tvetydigheter" ; -- SaldoWN
lin triangle_N = mkN "triangel" ; -- SaldoWN
lin terminate_V2 = variants {} ;
lin terminate_V = mkV "sluta" "slöt" "slutit" ; -- comment=8
lin retreat_V2 = mkV2 (mkV "retirerar"); -- status=guess, src=wikt
lin retreat_V = mkV "retirerar" ;
lin pony_N = mkN "ponny" "ponnier" ; -- SaldoWN
lin outdoor_A = variants {} ;
lin deficiency_N = mkN "brist" "brister" ; -- SaldoWN
lin decree_N = mkN "dekret" neutrum; -- comment=10
lin apologize_V = variants {} ;
lin yarn_N = mkN "garn" neutrum;
lin staff_V2 = variants {} ;
lin renewal_N = mkN "förnyelse" "förnyelser" ;
lin rebellion_N = mkN "uppror" neutrum | mkN "uppror" neutrum ; -- SaldoWN -- status=guess
lin incidentally_Adv = variants{} ;
lin flour_N = mkN "mjöl" "mjölet" "mjöler" "mjölerna" ; -- SaldoWN
lin developed_A = variants{} ;
lin chorus_N = mkN "kör" "körer" | mkN "refräng" "refränger" ; -- SaldoWN -- comment=6
lin ballot_N = mkN "röstsedel" | mkN "valsedel" ; -- SaldoWN -- comment=2
lin appetite_N = mkN "aptit" | mkN "lust" ; -- SaldoWN -- comment=7
lin stain_V2 = variants {} ;
lin stain_V = mkV "färgar" ; -- comment=7
lin notebook_N = mkN "laptop" | mkN "anteckningsbok" "anteckningsböcker" ; -- SaldoWN
lin loudly_Adv = variants{} ;
lin homeless_A = mkA "hemlös" ; -- comment=2
lin census_N = mkN "census" | mkN "folkräkning" ;
lin bizarre_A = mkA "bisarr" ;
lin striking_A = mkA "slående" ; -- comment=10
lin greenhouse_N = mkN "växthus" neutrum; -- comment=2
lin part_V2 = dirV2 (partV (mkV "skilja")"av"); -- comment=3
lin part_V = mkV "skingrar" ; -- comment=12
lin burial_N = mkN "begravning" ; -- SaldoWN
lin embarrassed_A = variants{} ;
lin ash_N = mkN "aska" ; -- SaldoWN
lin actress_N = mkN "aktris" "aktriser" ;
lin cassette_N = mkN "kassett" "kassetter" ; -- SaldoWN
lin privacy_N = mkN "privatliv" neutrum | mkN "privatliv" neutrum ; -- SaldoWN -- comment=4
lin fridge_N = L.fridge_N ;
lin feed_N = mkN "djurfoder" neutrum; -- comment=3
lin excess_A = variants {} ;
lin calf_N = mkN "kalv" | mkN "vad" ; -- SaldoWN -- comment=8
lin associate_N = mkN "före" ; -- comment=8
lin ruin_N = mkN "ruin" "ruiner" | mkN "undergång" ; -- SaldoWN -- comment=2
lin jointly_Adv = variants{} ;
lin drill_V2 = mkV2 (mkV "drillar"); -- status=guess, src=wikt
lin drill_V = mkV "övar" ; -- comment=6
lin photograph_V2 = mkV2 (mkV "fotograferar"); -- status=guess, src=wikt
lin devoted_A = variants{} ;
lin indirectly_Adv = variants{} ;
lin driving_A = variants{} ;
lin memorandum_N = mkN "promemoria" ; -- SaldoWN
lin default_N = mkN "uteblivande" | (mkN "standard" "standarder") | mkN "standardval" ; -- SaldoWN -- status=guess status=guess
lin costume_N = mkN "dräkt" "dräkter" ; -- SaldoWN
lin variant_N = mkN "variant" "varianter" ; -- SaldoWN
lin shatter_V2 = mkV2 (mkV "krossar") | mkV2 (mkV "kraschar") | mkV2 (mkV "krasar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shatter_V = mkV "uppröra" "upprörde" "upprört" ; -- comment=5
lin methodology_N = mkN "metodologi" "metodologier" | mkN "metodik" ; -- SaldoWN
lin frame_V2 = mkV2 (mkV "ramar") | mkV2 (mkV (mkV "rama") "in"); -- status=guess, src=wikt status=guess, src=wikt
lin frame_V = mkV "uttrycker" ; -- comment=5
lin allegedly_Adv = variants{} ;
lin swell_V2 = dirV2 (partV (mkV "svallar")"över");
lin swell_V = L.swell_V;
lin investigator_N = mkN "utredare" utrum ; -- SaldoWN
lin imaginative_A = mkA "fantasifull" ; -- comment=2
lin bored_A = variants{} ;
lin bin_N = mkN "tunna" | mkN "låda" ; -- SaldoWN -- comment=9
lin awake_A = mkA "vaken" "vaket" | mkA "väck" ; -- SaldoWN -- comment=2
lin recycle_V2 = mkV2 "återvinna" "återvann" "återvunnit" | mkV2 (mkV "återvinna") | mkV2 (mkV "återanvända") ; -- SaldoWN -- status=guess, src=wikt status=guess, src=wikt
lin group_V2 = mkV2 (mkV "grupperar"); -- status=guess, src=wikt
lin group_V = mkV "grupperar" ;
lin enjoyment_N = mkN "åtnjutande" ; -- comment=7
lin contemporary_N = mkN "samtid" | mkN "moder" "modern" "mödrar" "mödrarna" ; -- SaldoWN -- comment=2
lin texture_N = mkN "struktur" "strukturer" ; -- SaldoWN
lin donor_N = mkN "donator" "donatorer" | mkN "givare" utrum ; -- SaldoWN
lin bacon_N = mkN "bacon" ; -- SaldoWN
lin sunny_A = mkA "solig" ;
lin stool_N = mkN "pall" ; -- SaldoWN = mkN "pall" ; = mkN "pall" neutrum ;
lin prosecute_V2 = variants {} ;
lin commentary_N = mkN "kommentar" "kommentarer" | mkN "referat" neutrum ; -- SaldoWN -- comment=6
lin bass_N = mkN "basgitarr" "basgitarrer" ;
lin sniff_VS = variants {} ;
lin sniff_V2 = variants {} ;
lin sniff_V = mkV "sniffar" ; -- comment=2
lin repetition_N = mkN "upprepning" | mkN "återupprepning" ; -- SaldoWN -- comment=3
lin eventual_A = mkA "slutgiltig" ;
lin credit_V2 = mkV2 (mkV "krediterar"); -- status=guess, src=wikt
lin suburb_N = mkN "förort" "förorter" ; -- SaldoWN
lin newcomer_N = mkN "nykomling" ; -- SaldoWN
lin romance_N = mkN "romantik" ; -- comment=3
lin film_V2 = mkV2 "hinna" "hann" "hunnit" | mkV2 (mkV "filmar") ; -- SaldoWN -- status=guess, src=wikt
lin film_V = mkV "hinna" "hann" "hunnit" ; -- SaldoWN
lin experiment_V2 = mkV2 (mkV "experimenterar"); -- status=guess, src=wikt
lin experiment_V = mkV "experimenterar" ; -- comment=2
lin daylight_N = mkN "dagsljus" neutrum ;
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
lin offset_V2 = variants {} ;
lin thinking_N = mkN "tänkande" ; -- comment=3
lin mainframe_N = mkN "stordator" "stordatorer" ;
lin flock_N = mkN "flock" neutrum | mkN "skara" ; -- SaldoWN = mkN "flock" ; -- comment=8
lin amateur_A = variants {} ;
lin academy_N = mkN "akademi" "akademier" ; -- SaldoWN
lin shilling_N = variants {} ;
lin reluctance_N = mkN "betänklighet" "betänkligheter" | mkN "motvillighet" ; -- SaldoWN
lin velocity_N = mkN "hastighet" "hastigheter" ; -- SaldoWN
lin spare_V2 = variants {} ;
lin spare_V = mkV "undvarar" ; -- comment=5
lin wartime_N = variants {} ;
lin soak_V2 = mkV2 "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin soak_V = mkV "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" | mkV "blöter" ; -- SaldoWN -- comment=4
lin rib_N = mkN "revben" neutrum | mkN "revben" neutrum ; -- SaldoWN -- comment=2
lin mighty_A = mkA "stark" ; -- comment=3
lin shocked_A = variants{} ;
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
lin rape_V2 = mkV2 "våldta" "våldtar" "våldta" "våldtog" "våldtagit" "våldtagen" | mkV2 (mkV "våldta") ; -- SaldoWN -- status=guess, src=wikt
lin cutting_N = mkN "urklipp" neutrum ; -- SaldoWN -- comment=12
lin bracket_N = mkN "parentes" "parenteser" | mkN "vinkeljärn" neutrum ; -- SaldoWN -- comment=4
lin agony_N = mkN "vånda" ; -- SaldoWN
lin strive_VV = variants {} ;
lin strive_V = mkV "strävar" ;
lin strangely_Adv = variants{} ;
lin pledge_VS = mkV "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin pledge_V2V = mkV2V "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin pledge_V2 = mkV2 "pantsätta" "pantsätter" "pantsätt" "pantsatte" "pantsatt" "pantsatt" ; -- SaldoWN
lin recipient_N = mkN "mottagare" utrum;
lin moor_N = mkN "hed" ;
lin invade_V2 = mkV2 (mkV "invaderar"); -- status=guess, src=wikt
lin dairy_N = mkN "mejeri" "mejerit" "mejerier" "mejerierna" | mkN "dagbok" "dagböcker" ; -- SaldoWN -- comment=2
lin chord_N = mkN "ackord" neutrum | mkN "sträng" ; -- SaldoWN = mkN "ackord" neutrum ; -- comment=4
lin shrink_V2 = mkV2 (mkV "krymper"); -- status=guess, src=wikt
lin shrink_V = mkV "krymper" ; -- comment=2
lin poison_N = mkN "gift" "giftet" "gifter" "gifterna" ; -- SaldoWN
lin pillar_N = mkN "stolpe" utrum; -- comment=3
lin washing_N = mkN "tvagning" ;
lin warrior_N = mkN "krigare" utrum | mkN "krigare" utrum ; -- SaldoWN -- comment=5
lin supervisor_N = mkN "handledare" utrum | mkN "handledare" utrum ; -- SaldoWN -- comment=8
lin outfit_N = mkN "utstyrsel" | mkN "utrustning" ; -- SaldoWN -- comment=11
lin innovative_A = mkA "innovativ" ;
lin dressing_N = mkN "förband" neutrum | mkN "dressing" ; -- SaldoWN = mkN "förband" neutrum ; -- comment=10
lin dispute_V2 = variants {} ;
lin dispute_V = mkV "diskuterar" ; -- comment=6
lin jungle_N = mkN "djungel" "djungeln" "djungler" "djunglerna" ; -- SaldoWN
lin brewery_N = mkN "bryggeri" "bryggerit" "bryggerier" "bryggerierna" ; -- SaldoWN
lin adjective_N = mkN "adjektiv" neutrum;
lin straighten_V2 = dirV2 (partV (mkV "rätar")"ut");
lin straighten_V = mkV "rätar" ;
lin restrain_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=3
lin monarchy_N = mkN "monarki" "monarkier" ; -- SaldoWN
lin trunk_N = mkN "koffert" ; -- SaldoWN
lin herd_N = mkN "hjord" | mkN "flock" neutrum ; -- SaldoWN -- comment=4
lin deadline_N = mkN "deadline" utrum ;
lin tiger_N = mkN "tiger" ; -- SaldoWN
lin supporting_A = variants{} ;
lin moderate_A = mkA "måttlig" ; -- comment=15
lin kneel_V = mkV "knäböja" "knäböjde" "knäböjt" ; -- SaldoWN
lin ego_N = mkN "egoism" "egoismer" ; -- comment=3
lin sexually_Adv = variants{} ;
lin ministerial_A = variants {} ;
lin bitch_N = mkN "tik" | mkN "satkäring" ; -- SaldoWN -- comment=6
lin wheat_N = mkN "vete" | mkN "durumvete" ; -- SaldoWN -- comment=3
lin stagger_V2 = mkV2 (mkV "vacklar"); -- status=guess, src=wikt
lin stagger_V = mkV "stapplar" ; -- comment=2
lin snake_N = L.snake_N ;
lin ribbon_N = mkN "band" neutrum | mkN "remsa" ; -- SaldoWN -- comment=9
lin mainland_N = mkN "fastland" neutrum | mkN "fastland" neutrum ; -- SaldoWN -- status=guess
lin fisherman_N = mkN "fiskare" utrum | mkN "fiskare" utrum ; -- SaldoWN
lin economically_Adv = variants{} ;
lin unwilling_A = mkA "motvillig" ; -- comment=3
lin nationalism_N = mkN "nationalism" "nationalismer" ; -- SaldoWN
lin knitting_N = mkN "stickning" ;
lin irony_N = mkN "ironi" "ironier" ; -- SaldoWN
lin handling_N = mkN "hantering" ; -- comment=2
lin desired_A = variants{} ;
lin bomber_N = mkN "bombplan" neutrum ; -- SaldoWN
lin voltage_N = mkN "spänning" ; -- comment=2
lin unusually_Adv = variants{} ;
lin toast_N = mkN "toast" | mkN "värma" ; -- SaldoWN -- comment=2
lin feel_N = mkN "känsla" ; -- comment=3
lin suffering_N = mkN "lidande" | mkN "smärta" ; -- SaldoWN -- comment=3
lin polish_V2 = dirV2 (partV (mkV "skurar")"av"); -- comment=5
lin polish_V = mkV "slipar" ; -- comment=8
lin technically_Adv = variants{} ;
lin meaningful_A = mkA "meningsfull" ; -- SaldoWN
lin aloud_Adv = mkAdv "högt" ; -- status=guess
lin waiter_N = mkN "kypare" utrum; -- comment=4
lin tease_V2 = dirV2 (partV (mkV "tråkar")"ut");
lin opposite_Adv = variants{} ;
lin goat_N = mkN "get" "getter" | mkN "åsna" ; -- SaldoWN -- comment=3
lin conceptual_A = mkA "begreppsmässig" ;
lin ant_N = mkN "myra" | mkN "svartmyra" ; -- SaldoWN -- comment=2
lin inflict_V2 = variants {} ;
lin bowler_N = mkN "bowlare" utrum; -- comment=3
lin roar_V2 = mkV2 (mkV "ryta" "röt" "rutit"); -- status=guess, src=wikt
lin roar_V = mkV "tjuta" "tjöt" "tjutit" ; -- comment=11
lin drain_N = mkN "avlopp" neutrum | mkN "dräneringsrör" neutrum ; -- SaldoWN -- comment=18
lin wrong_N = mkN "orätt" "orätter" ; -- SaldoWN
lin galaxy_N = mkN "galax" "galaxer" ; -- SaldoWN
lin aluminium_N = mkN "aluminium" neutrum ; -- SaldoWN
lin receptor_N = variants {} ;
lin preach_V2 = mkV2 (mkV "predikar"); -- status=guess, src=wikt
lin preach_V = mkV "predikar" ; -- comment=4
lin parade_N = mkN "parad" "parader" | mkN "stoltserande" ; -- SaldoWN -- comment=4
lin opposite_N = mkN "motsats" "motsatser" | mkN "motstående" ; -- SaldoWN -- comment=3
lin critique_N = mkN "kritik" "kritiker" ;
lin query_N = variants {} ;
lin outset_N = variants {} ;
lin integral_A = (mkA "hel") | (mkA "enhetlig"); -- status=guess status=guess
lin grammatical_A = mkA "grammatisk" ;
lin testing_N = mkN "prövande" ;
lin patrol_N = mkN "patrull" "patruller" | mkN "patrullering" ; -- SaldoWN -- comment=2
lin pad_N = mkN "stoppning" ; -- comment=21
lin unreasonable_A = mkA "ovettig" ; -- comment=5
lin sausage_N = mkN "korv" ; -- SaldoWN
lin criminal_N = mkN "brottsling" ; -- SaldoWN
lin constructive_A = mkA "konstruktiv" ; -- SaldoWN
lin worldwide_A = variants {} ;
lin highlight_N = mkN "höjdpunkt" "höjdpunkter" ; -- SaldoWN
lin doll_N = mkN "docka" ; -- SaldoWN
lin frightened_A = variants{} ;
lin biography_N = mkN "biografi" "biografier" ;
lin vocabulary_N = mkN "ordförråd" neutrum; -- comment=2
lin offend_V2 = mkV2 (mkV "såra"); -- status=guess, src=wikt
lin offend_V = mkV "förolämpar" ; -- comment=4
lin accumulation_N = mkN "ansamling" | mkN "kapitalisering" ; -- SaldoWN -- comment=8
lin linen_N = mkN "linne" ; -- SaldoWN = mkN "linne" ;
lin fairy_N = mkN "älva" | mkN "fikus" ; -- SaldoWN -- comment=3
lin disco_N = mkN "diskotek" neutrum | mkN "diskomusik" ; -- SaldoWN -- comment=4
lin hint_VS = variants {} ;
lin hint_V2 = variants {} ;
lin hint_V = mkV "antyda" "antydde" "antytt" ; -- comment=4
lin versus_Prep = variants {} ;
lin ray_N = mkN "stråle" utrum; -- comment=5
lin pottery_N = mkN "lergods" neutrum | mkN "krukmakeri" "krukmakerit" "krukmakerier" "krukmakerierna" ; -- SaldoWN
lin immune_A = mkA "immun" ; -- SaldoWN
lin retreat_N = mkN "fristad" "fristäder" | mkN "återtåg" neutrum ; -- SaldoWN -- comment=3
lin master_V2 = variants {} ;
lin injured_A = variants{} ;
lin holly_N = mkN "järnek" ; -- status=guess
lin battle_V2 = mkV2 (mkV "strida" "stridde" "stritt"); -- status=guess, src=wikt
lin battle_V = mkV "kämpar" ; -- comment=2
lin solidarity_N = mkN "solidaritet" "solidariteter" ; -- SaldoWN
lin embarrassing_A = mkA "genant" "genant" ; -- comment=4
lin cargo_N = mkN "last" "laster" ; -- comment=3
lin theorist_N = mkN "teoretiker" "teoretikern" "teoretiker" "teoretikerna" ; -- SaldoWN
lin reluctantly_Adv = variants{} ;
lin preferred_A = variants{} ;
lin dash_V2 = dirV2 (partV (mkV "slå" "slog" "slagit")"ut"); -- comment=22
lin dash_V = mkV "slå" "slog" "slagit" ; -- comment=15
lin total_V2 = variants {} ;
lin total_V = mkV "sammanlägga" "sammanlade" "sammanlagt" ; -- comment=4
lin reconcile_V2 = variants {} ;
lin drill_N = mkN "exercis" "exerciser" | mkN "trä" "träet" "trän" "träna" ; -- SaldoWN -- comment=9
lin credibility_N = mkN "trovärdighet" ; -- SaldoWN
lin copyright_N = mkN "upphovsrätt" | mkN "copyright" ; -- SaldoWN -- comment=3
lin beard_N = mkN "skägg" neutrum ; -- SaldoWN
lin bang_N = mkN "knall" | mkN "vip" ; -- SaldoWN -- comment=15
lin vigorous_A = mkA "vital" | mkA "kraftfull" ; -- SaldoWN -- comment=3
lin vaguely_Adv = variants{} ;
lin punch_V2 = mkV2 "slå" "slog" "slagit" | dirV2 (partV (mkV "stansar")"ut") ; -- SaldoWN -- comment=2
lin prevalence_N = mkN "överväldigande" ; -- SaldoWN
lin uneasy_A = mkA "orolig" ; -- SaldoWN
lin boost_N = mkN "ökning" ; -- comment=5
lin scrap_N = mkN "bit" | mkN "skrot" ; -- SaldoWN = mkN "bit" ; -- comment=11
lin ironically_Adv = variants{} ;
lin fog_N = L.fog_N ;
lin faithful_A = mkA "trogen" "troget" ; -- SaldoWN
lin bounce_V2 = dirV2 (partV (mkV "hoppar")"över"); -- comment=2
lin bounce_V = mkV "studsar" ; -- comment=3
lin batch_N = mkN "hop" ; -- comment=9
lin smooth_V2 = dirV2 (partV (mkV "slätar")"till"); -- comment=4
lin smooth_V = mkV "stillar" ; -- comment=5
lin sleeping_A = variants{} ;
lin poorly_Adv = variants{} ;
lin accord_V2 = variants {} ;
lin accord_V = mkV "ge" "ger" "ge" "gav" "gett" "given" ; -- comment=3
lin vice_president_N = mkN "vicepresident" "vicepresidenter" ;
lin duly_Adv = variants{} ;
lin blast_N = mkN "explosion" "explosioner" | mkN "tryckvåg" "tryckvågor" ; -- SaldoWN -- comment=8
lin square_V2 = dirV2 (partV (mkV "rättar")"till");
lin square_V = mkV "reglerar" ; -- comment=10
lin prohibit_V2 = mkV2 (mkV "förbjuda"); -- status=guess, src=wikt
lin prohibit_V = mkV "förhindrar" ; -- comment=4
lin brake_N = mkN "broms" | mkN "busksnår" neutrum ; -- SaldoWN -- comment=3
lin asylum_N = mkN "asyl" "asyler" | mkN "vårdanstalt" "vårdanstalter" ; -- SaldoWN -- comment=3
lin obscure_VA = variants {} ;
lin obscure_V2 = variants {} ;
lin nun_N = mkN "nunna" ; -- SaldoWN
lin heap_N = mkN "massa" ; -- comment=6
lin smoothly_Adv = variants{} ;
lin rhetoric_N = mkN "retorik" | mkN "vältalighet" "vältaligheter" ; -- SaldoWN -- comment=3
lin privileged_A = compoundA (regA "privilegierad");
lin liaison_N = variants {} ;
lin jockey_N = mkN "jockey" ; -- SaldoWN
lin concrete_N = mkN "betong" "betonger" ; -- SaldoWN
lin allied_A = variants{} ;
lin rob_V2 = mkV2 (mkV "röva") | mkV2 (mkV "råna"); -- status=guess, src=wikt status=guess, src=wikt
lin indulge_V2 = variants {} ;
lin indulge_V = mkV "tillfredsställer" ;
lin except_Prep = S.except_Prep;
lin distort_V2 = mkV2 (mkV "förvränga"); -- status=guess, src=wikt
lin whatsoever_Adv = variants{} ;
lin viable_A = mkA "genomförbar" | mkA "livsduglig" ; -- SaldoWN -- comment=7
lin nucleus_N = mkN "kärna" ; -- comment=3
lin exaggerate_V2 = mkV2 "överdriva" "överdrev" "överdrivit" ; -- SaldoWN -- status=guess, src=wikt
lin exaggerate_V = mkV "överdriva" "överdrev" "överdrivit" ; -- SaldoWN
lin compact_N = mkN "minibil" | mkN "tät" "täter" ; -- SaldoWN
lin nationality_N = mkN "nationalitet" "nationaliteter" ; -- SaldoWN
lin direct_Adv = mkAdv "direkt" ; -- comment=2
lin cast_N = mkN "rollbesättning" | mkN "rollfördelning" | mkN "rollsättning" | mkN "casting" ;
lin altar_N = mkN "altare" "altaret" "altaren" "altarna" ; -- SaldoWN
lin refuge_N = mkN "tillflyktsort" "tillflyktsorter" ; -- comment=4
lin presently_Adv = variants{} ;
lin mandatory_A = mkA "obligatorisk" ; -- status=guess
lin authorize_V2V = variants {} ;
lin authorize_V2 = variants {} ;
lin accomplish_V2 = mkV2 (mkV "åstadkomma") | mkV2 (mkV "uträtta"); -- status=guess, src=wikt status=guess, src=wikt
lin startle_V2 = variants {} ;
lin indigenous_A = mkA "inhemsk" | mkA "naturlig" ; -- SaldoWN -- comment=3
lin worse_Adv = variants {} ;
lin retailer_N = mkN "återförsäljare" utrum | mkN "återförsäljare" utrum ; -- SaldoWN -- comment=2
lin compound_V2 = dirV2 (partV (mkV "blandar") "ut"); -- comment=4
lin compound_V = mkV "sammansätta" "sammansätter" "sammansätt" "sammansatte" "sammansatt" "sammansatt" ; -- comment=3
lin admiration_N = mkN "beundran" ; -- status=guess
lin absurd_A = mkA "orimlig" ; -- comment=6
lin coincidence_N = mkN "tillfällighet" "tillfälligheter" | mkN "överensstämmelse" "överensstämmelser" ; -- SaldoWN -- comment=6
lin principally_Adv = variants{} ;
lin passport_N = mkN "pass" neutrum | mkN "passersedel" ; -- SaldoWN -- comment=4
lin depot_N = mkN "depå" "depåer" ; -- comment=7
lin soften_V2 = mkV2 (mkV "mjuknar"); -- status=guess, src=wikt
lin soften_V = mkV "uppmjukar" ; -- comment=2
lin secretion_N = mkN "sekret" neutrum | mkN "undangömmande" ; -- SaldoWN -- comment=5
lin invoke_V2 = variants {} ;
lin dirt_N = mkN "smuts" ; -- comment=6
lin scared_A = variants{} ;
lin mug_N = mkN "mugg" | mkN "tryne" ; -- SaldoWN = mkN "mugg" ; -- comment=7
lin convenience_N = mkN "bekvämlighet" "bekvämligheter" | mkN "lämplighet" "lämpligheter" ; -- SaldoWN -- comment=5
lin calm_N = mkN "lugn" neutrum; -- comment=6
lin optional_A = mkA "valfri" "valfritt" ; -- SaldoWN
lin unsuccessful_A = compoundA (regA "misslyckad");
lin consistency_N = mkN "konsistens" "konsistenser" ; -- comment=8
lin umbrella_N = mkN "paraply" "paraplyer" ; -- SaldoWN
lin solo_N = mkN "solo" "solot" "solon" "solona" ; -- SaldoWN
lin hemisphere_N = mkN "hjärnhalva" | mkN "hemisfär" "hemisfärer" ; -- SaldoWN
lin extreme_N = mkN "ytterlighet" "ytterligheter" ; -- SaldoWN
lin brandy_N = variants {} ;
lin belly_N = L.belly_N ;
lin attachment_N = mkN "tillgivenhet" "tillgivenheter" | mkN "hängivenhet" ; -- SaldoWN -- comment=16
lin wash_N = mkN "tvätt" ; -- comment=4
lin uncover_V2 = variants {} ;
lin treat_N = mkN "njutning" | mkN "nöje" ; -- SaldoWN -- comment=8
lin repeated_A = variants{} ;
lin pine_N = mkN "tall" ; -- comment=6
lin offspring_N = mkN "avkomma" | mkN "ättling" ; -- SaldoWN -- comment=8
lin communism_N = mkN "kommunism" "kommunismer" ;
lin nominate_V2 = variants {} ;
lin soar_V2 = mkV2 "flyga" "flög" "flugit" ; -- SaldoWN
lin soar_V = mkV "flyga" "flög" "flugit" ; -- SaldoWN
lin geological_A = mkA "geologisk" ; -- SaldoWN
lin frog_N = mkN "groda" ; -- SaldoWN
lin donate_V2 = mkV2 (mkV "skänka") | mkV2 (mkV "donerar"); -- status=guess, src=wikt status=guess, src=wikt
lin donate_V = mkV "skänker" ; -- comment=3
lin cooperative_A = mkA "medgörlig" | mkA "samarbetsvillig" ; -- SaldoWN -- comment=3
lin nicely_Adv = variants{} ;
lin innocence_N = mkN "oskuld" "oskulder" ; -- comment=4
lin housewife_N = mkN "hemmafru" ; -- SaldoWN
lin disguise_V2 = variants {} ;
lin demolish_V2 = mkV2 "förstöra" "förstörde" "förstört" ; -- SaldoWN
lin counsel_N = mkN "överläggning" ; -- comment=10
lin cord_N = mkN "snöre" | mkN "sträng" ; -- SaldoWN -- comment=2
lin semi_final_N = variants{} ;
lin reasoning_N = mkN "resonemang" neutrum; -- comment=5
lin litre_N = mkN "liter" ;
lin inclined_A = variants{} ;
lin evoke_V2 = mkV2 (mkV "frammanar"); -- status=guess, src=wikt
lin courtyard_N = mkN "borggård" ; -- comment=3
lin arena_N = mkN "arena" ; -- SaldoWN
lin simplicity_N = mkN "enkelhet" "enkelheter" ; -- SaldoWN
lin inhibition_N = mkN "hämning" ; -- SaldoWN
lin frozen_A = variants{} ;
lin vacuum_N = mkN "vakuum" neutrum | mkN "vakuum" neutrum ; -- SaldoWN -- comment=2
lin immigrant_N = mkN "invandrare" utrum ; -- SaldoWN -- comment=2
lin bet_N = mkN "vad" ; -- SaldoWN = mkN "vad" neutrum ; = mkN "vad" "vader" ;
lin revenge_N = mkN "hämnd" | mkN "vedergällning" ; -- SaldoWN -- comment=3
lin jail_V2 = variants {} ;
lin helmet_N = mkN "hjälm" ; -- SaldoWN
lin unclear_A = mkA "otydlig" ;
lin jerk_V2 = dirV2 (partV (mkV "slänga")"ut"); -- comment=4
lin jerk_V = mkV "stöter" ; -- comment=8
lin disruption_N = mkN "upplösning" ; -- comment=3
lin attainment_N = mkN "uppnående" ; -- comment=3
lin sip_V2 = variants {} ;
lin sip_V = mkV "smuttar" ; -- comment=2
lin program_V2V = mkV2V (mkV "programmerar") | mkV2V (mkV "mjukvaruutveckla") | mkV2V (mkV (mkV "utveckla") "mjukvara"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin program_V2 = dirV2 (partV (mkV "programmerar")"in");
lin lunchtime_N = mkN "lunchtid" "lunchtider" ;
lin cult_N = mkN "sekt" ; -- comment=4
lin chat_N = mkN "prata" ; -- comment=8
lin accord_N = mkN "överensstämmelse" "överensstämmelser" ; -- comment=5
lin supposedly_Adv = variants{} ;
lin offering_N = mkN "utbud" neutrum; -- comment=3
lin broadcast_N = mkN "sändning" | mkN "TV-sändning" ; -- SaldoWN -- comment=3
lin secular_A = mkA "sekulär" ; -- SaldoWN
lin overwhelm_V2 = mkV2 (mkV "överväldiga"); -- status=guess, src=wikt
lin momentum_N = mkN "rörelsemängd" "rörelsemängder" | mkN "rörelsemängd" ; -- SaldoWN -- status=guess
lin infinite_A = mkA "oändlig" ; -- SaldoWN
lin manipulation_N = mkN "manipulation" "manipulationer" ; -- comment=2
lin inquest_N = variants {} ;
lin decrease_N = mkN "nedgång" | mkN "minskning" ; -- SaldoWN -- comment=4
lin cellar_N = mkN "källare" utrum ; -- SaldoWN -- comment=2
lin counsellor_N = mkN "konsulent" "konsulenter" ; -- comment=3
lin avenue_N = mkN "aveny" "avenyer" | mkN "allé" "alléer" ; -- SaldoWN -- comment=3
lin rubber_A = variants {} ;
lin labourer_N = mkN "arbetare" utrum ; -- SaldoWN
lin lab_N = mkN "maka" ; -- comment=3
lin damn_V2 = dirV2 (partV (mkV "dömer")"ut");
lin comfortably_Adv = variants{} ;
lin tense_A = mkA "spänd" | mkA "spännande" ; -- SaldoWN -- comment=4
lin socket_N = mkN "hållare" utrum; -- comment=8
lin par_N = variants {} ;
lin thrust_N = mkN "slunga" | mkN "stöt" ; -- SaldoWN -- comment=2
lin scenario_N = mkN "scenario" "scenariot" "scenarion" "scenariona" ; -- SaldoWN
lin frankly_Adv = variants{} ;
lin slap_V2 = mkV2 "slå" "slog" "slagit" | dirV2 (partV (mkV "smälla" "small" "smäll")"av") ; -- SaldoWN -- comment=15
lin recreation_N = mkN "rekreation" "rekreationer" ; -- SaldoWN
lin rank_VS = mkVS (mkV "graderar") | mkVS (mkV "klassificerar") | mkVS (mkV "klassar") | mkVS (mkV "placerar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rank_V2 = dirV2 (partV (mkV "ordnar")"om");
lin rank_V = mkV "rankar" ; -- comment=7
lin spy_N = mkN "spion" "spioner" ; -- SaldoWN
lin filter_V2 = dirV2 (partV (mkV "filtrerar")"av");
lin filter_V = mkV "filtrerar" ;
lin clearance_N = mkN "klarsignal" "klarsignaler" | mkN "tillstånd" neutrum ; -- SaldoWN -- comment=8
lin blessing_N = mkN "välsignelse" "välsignelser" ; -- comment=6
lin embryo_N = mkN "embryo" "embryot" "embryon" "embryona" ; -- SaldoWN
lin varied_A = variants{} ;
lin predictable_A = mkA "förutsägbar" ; -- SaldoWN
lin mutation_N = mkN "mutation" "mutationer" ; -- SaldoWN
lin equal_V2 = mkV2 (mkV (mkV "vara") "lika med"); -- status=guess, src=wikt
lin can_1_VV = S.can_VV ;
lin can_2_VV = S.can8know_VV ;
lin can_V2 = dirV2 (mkV "konserverar");
lin burst_N = mkN "salva" ; -- comment=8
lin retrieve_V2 = mkV2 (mkV "minnas"); -- status=guess, src=wikt
lin retrieve_V = mkV "minnas" ; -- status=guess, src=wikt
lin elder_N = mkN "tejp" ; -- comment=2
lin rehearsal_N = mkN "repetition" "repetitioner" ; -- SaldoWN
lin optical_A = mkA "optisk" ;
lin hurry_N = mkN "jäkt" neutrum; -- comment=4
lin conflict_V = mkV "kämpar" ;
lin combat_V2 = variants {} ;
lin combat_V = mkV "strida" "stridde" "stritt" ; -- comment=3
lin absorption_N = mkN "assimilation" "assimilationer" | mkN "absorbering" ; -- SaldoWN -- comment=3
lin ion_N = mkN "jon" "joner" ; -- status=guess
lin wrong_Adv = mkAdv "vilse" ;
lin heroin_N = mkN "heroin" "heroiner" ; -- SaldoWN
lin bake_V2 = dirV2 (partV (mkV "hårdnar")"till");
lin bake_V = mkV "bakar" ; -- comment=7
lin x_ray_N = variants {} ;
lin vector_N = mkN "vektor" "vektorer" ; -- SaldoWN
lin stolen_A = variants{} ;
lin sacrifice_V2 = mkV2 (mkV "offrar"); -- status=guess, src=wikt
lin sacrifice_V = mkV "offrar" ; -- comment=2
lin robbery_N = mkN "rån" neutrum | mkN "röveri" "röverit" "röverier" "röverierna" ; -- SaldoWN -- comment=5
lin probe_V2 = variants {} ;
lin probe_V = mkV "utforskar" ; -- comment=2
lin organizational_A = mkA "organisatorisk" ; -- status=guess
lin chalk_N = mkN "krita" ; -- SaldoWN = mkN "krita" ;
lin bourgeois_A = mkA "borgerlig" ;
lin villager_N = mkN "bybo" ; -- status=guess
lin morale_N = mkN "moral" "moraler" ; -- SaldoWN
lin express_A = mkA "uttrycklig" ; -- comment=6
lin climb_N = mkN "klättring" ; -- comment=2
lin notify_V2 = mkV2 (mkV "meddelar"); -- status=guess, src=wikt
lin jam_N = mkN "sylt" "sylter" | mkN "tur" ; -- SaldoWN -- comment=18
lin bureaucratic_A = mkA "byråkratisk" ; -- SaldoWN
lin literacy_N = mkN "läskunnighet" "läskunnigheter" | mkN "skrivkunnighet" ; -- SaldoWN
lin frustrate_V2 = variants {} ;
lin freight_N = mkN "frakt" "frakter" ; -- SaldoWN
lin clearing_N = mkN "röjning" ; -- comment=6
lin aviation_N = mkN "flyg" neutrum ; -- SaldoWN = mkN "flyg" neutrum ; -- comment=2
lin legislature_N = mkN "legislatur" "legislaturer" ; -- SaldoWN
lin curiously_Adv = variants{} ;
lin banana_N = mkN "banan" "bananer" ; -- SaldoWN
lin deploy_V2 = dirV2 (partV (mkV "sprida" "spred" "spritt")"ut");
lin deploy_V = mkV "utplacerar" ; -- comment=3
lin passionate_A = variants {} ;
lin monastery_N = mkN "kloster" neutrum | mkN "kloster" neutrum ; -- SaldoWN
lin kettle_N = mkN "kittel" | mkN "vattenkokare" utrum ; -- SaldoWN
lin enjoyable_A = mkA "trevlig" | mkA "njutbar" ; -- SaldoWN -- comment=5
lin diagnose_V2 = mkV2 (mkV "diagnostiserar"); -- status=guess, src=wikt
lin quantitative_A = mkA "kvantitativ" ; -- SaldoWN
lin distortion_N = mkN "förvrängning" ; -- SaldoWN
lin monarch_N = mkN "monark" "monarker" ; -- SaldoWN
lin kindly_Adv = variants{} ;
lin glow_V = mkV "glöda" "glödde" "glött" ; -- SaldoWN
lin acquaintance_N = mkN "bekantskap" "bekantskaper" | mkN "bekant" "bekanter" ; -- SaldoWN -- comment=4
lin unexpectedly_Adv = variants{} ;
lin handy_A = mkA "behändig" ; -- SaldoWN
lin deprivation_N = mkN "misär" "misärer" | mkN "förlust" "förluster" ; -- SaldoWN -- comment=2
lin attacker_N = mkN "angripare" utrum;
lin assault_V2 = variants {} ;
lin screening_N = mkN "kontroll" "kontroller" ; -- comment=2
lin retired_A = variants{} ;
lin quick_Adv = mkAdv "fort" ;
lin portable_A = mkA "portabel" | mkA "bärbar" ; -- SaldoWN -- comment=4
lin hostage_N = mkN "gisslan" ; -- SaldoWN
lin underneath_Prep = variants {} ;
lin jealous_A = mkA "avundsjuk" | mkA "svartsjuk" ; -- SaldoWN -- comment=5
lin proportional_A = mkA "proportionell" ;
lin gown_N = mkN "dräkt" "dräkter" | mkN "klänning" ; -- SaldoWN -- comment=5
lin chimney_N = mkN "skorsten" "skorstenen" "skorstenar" "skorstenarna" ; -- SaldoWN
lin bleak_A = mkA "dyster" ; -- status=guess
lin seasonal_A = mkA "säsongsmässig" ; -- SaldoWN
lin plasma_N = mkN "blodplasma" ;
lin stunning_A = mkA "fantastisk" ; -- SaldoWN
lin spray_N = mkN "sprej" "sprejer" | mkN "yra" ; -- SaldoWN -- comment=14
lin referral_N = mkN "remiss" "remisser" | mkN "remittering" ; -- SaldoWN -- comment=3
lin promptly_Adv = variants{} ;
lin fluctuation_N = mkN "fluktuation" "fluktuationer" | mkN "skiftning" ; -- SaldoWN -- comment=3
lin decorative_A = mkA "dekorativ" ; -- comment=3
lin unrest_N = mkN "orolighet" "oroligheter" ; -- SaldoWN
lin resent_VS = variants {} ;
lin resent_V2 = variants {} ;
lin plaster_N = mkN "plåster" neutrum | mkN "plåster" neutrum ; -- SaldoWN -- comment=9
lin chew_V2 = dirV2 (partV (mkV "tuggar")"om");
lin chew_V = mkV "tuggar" ; -- comment=4
lin grouping_N = variants {} ;
lin gospel_N = mkN "gospel" "gospeln" "gospel" "gospelna" ; -- comment=3
lin distributor_N = mkN "distributör" "distributörer" ; -- SaldoWN
lin differentiation_N = mkN "differentiering" ;
lin blonde_A = mkA "blond" ; -- SaldoWN
lin aquarium_N = mkN "akvarium" "akvariet" "akvarier" "akvarierna" ; -- SaldoWN
lin witch_N = mkN "häxa" ; -- SaldoWN
lin renewed_A = variants{} ;
lin jar_N = mkN "burk" ; -- SaldoWN
lin approved_A = variants{} ;
lin advocate_N = variants{} ;
lin worrying_A = variants{} ;
lin minimize_V2 = mkV2 (mkV "dölja") | mkV2 (mkV "minimerar"); -- status=guess, src=wikt status=guess, src=wikt
lin footstep_N = variants {} ;
lin delete_V2 = variants {} ;
lin underneath_Adv = mkAdv "under" ; -- comment=3
lin lone_A = mkA "ensam" "ensamt" "ensamma" "ensamma" "ensammare" "ensammast" "ensammaste" ; -- status=guess
lin level_V2 = dirV2 (partV (mkV "jämnar")"ut"); -- comment=2
lin level_V = mkV "raserar" ; -- comment=2
lin exceptionally_Adv = variants{} ;
lin drift_N = mkN "driva" ; -- SaldoWN
lin spider_N = mkN "spindel" ; -- SaldoWN
lin hectare_N = mkN "hektar" neutrum ; -- SaldoWN
lin colonel_N = mkN "överste" utrum ;
lin swimming_N = mkN "simning" ;
lin realism_N = mkN "realism" "realismer" ; -- SaldoWN
lin insider_N = mkN "insider" ; -- SaldoWN
lin hobby_N = mkN "hobby" "hobbier" ;
lin computing_N = variants{} ;
lin infrastructure_N = mkN "infrastruktur" "infrastrukturer" ; -- SaldoWN
lin cooperate_V = mkV "samarbetar" ; -- comment=2
lin burn_N = mkN "solbränna" | mkN "brännskada" ; -- SaldoWN -- comment=4
lin cereal_N = mkN "sädesslag" neutrum ; -- SaldoWN
lin fold_N = mkN "veck" neutrum | mkN "vindling" ; -- SaldoWN -- comment=8
lin compromise_V2 = mkV2 (mkV "kompromissar") | mkV2 (mkV (mkV "komma") "överens"); -- status=guess, src=wikt status=guess, src=wikt
lin compromise_V = mkV "äventyrar" ; -- comment=4
lin boxing_N = mkN "boxning" ;
lin rear_V2 = variants {} ;
lin rear_V = mkV "lyfta" "lyfter" "lyft" "lyfte" "lyft" "lyft" ;
lin lick_V2 = dirV2 (partV (mkV "slickar")"av"); -- comment=15
lin lick_V = mkV "slickar" ; -- comment=8
lin constrain_V2 = mkV2 (mkV "begränsa"); -- status=guess, src=wikt
lin clerical_A = variants {} ;
lin hire_N = mkN "hyra" ; -- comment=5
lin contend_VS = mkVS (mkV "kämpa"); -- status=guess, src=wikt
lin contend_V = mkV "kämpa" ; -- status=guess, src=wikt
lin amateur_N = variants{} ;
lin instrumental_A = mkA "bidragande" ;
lin terminal_A = mkA "terminal" | mkA "obotlig" ; -- SaldoWN -- comment=2
lin electorate_N = mkN "väljarkår" "väljarkårer" | mkN "kurfurstendöme" ; -- SaldoWN -- status=guess
lin congratulate_V2 = mkV2 (mkV "gratulerar") | mkV2 (mkV "lyckönska") | mkV2 (mkV "grattar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin balanced_A = variants{} ;
lin manufacturing_N = variants{} ;
lin split_N = mkN "schism" "schismer" | mkN "spricka" ; -- SaldoWN -- comment=11
lin domination_N = mkN "herravälde" ; -- SaldoWN
lin blink_V2 = mkV2 (mkV "blinkar"); -- status=guess, src=wikt
lin blink_V = mkV "blinkar" ; -- comment=3
lin bleed_VS = mkVS (mkV "blöda" "blödde" "blött") ;
lin bleed_V2 = mkV2 "blöda" "blödde" "blött" | dirV2 (partV (mkV "plockar")"ut") ; -- SaldoWN -- comment=17
lin bleed_V = mkV "blöda" "blödde" "blött" ; -- SaldoWN
lin unlawful_A = mkA "olaglig" | mkA "olovlig" ; -- SaldoWN -- comment=3
lin precedent_N = mkN "prejudikat" neutrum | mkN "prejudikat" neutrum ; -- SaldoWN -- comment=2
lin notorious_A = mkA "ökänd" ; -- comment=4
lin indoor_A = variants {} ;
lin upgrade_V2 = mkV2 (mkV "befordrar") | mkV2 (mkV "uppvärdera") | mkV2 (mkV "uppdaterar"); -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin trench_N = mkN "dike" ; -- SaldoWN
lin therapist_N = mkN "terapeut" "terapeuter" ; -- SaldoWN
lin illuminate_V2 = variants {} ;
lin bargain_V2 = mkV2 (mkV "förhandla") | mkV2 (mkV "köpslå"); -- status=guess, src=wikt status=guess, src=wikt
lin bargain_V = mkV "förhandlar" ; -- comment=4
lin warranty_N = mkN "garanti" "garantier" ; -- SaldoWN
lin scar_V2 = variants {} ;
lin scar_V = variants {} ;
lin consortium_N = mkN "konsortium" "konsortiet" "konsortier" "konsortierna" ;
lin anger_V2 = mkV2 (mkV "förarga") | mkV2 (mkV "förilska"); -- status=guess, src=wikt status=guess, src=wikt
lin insure_VS = variants {} ;
lin insure_V2 = variants {} ;
lin insure_V = mkV "försäkrar" ; -- comment=2
lin extensively_Adv = variants{} ;
lin appropriately_Adv = variants{} ;
lin spoon_N = mkN "sked" ; -- SaldoWN
lin sideways_Adv = mkAdv "sidledes" ;
lin enhanced_A = variants{} ;
lin disrupt_V2 = variants {} ;
lin disrupt_V = mkV "splittrar" ; -- comment=4
lin satisfied_A = mkA "nöjd" "nöjt" ; -- SaldoWN
lin precaution_N = mkN "försiktighetsåtgärd" "försiktighetsåtgärder" ;
lin kite_N = mkN "drake" utrum ; -- SaldoWN -- comment=2
lin instant_N = mkN "ögonblick" neutrum;
lin gig_N = (mkN "ljuster" neutrum) | (mkN "harpun" "harpuner"); -- status=guess status=guess
lin continuously_Adv = variants{} ;
lin consolidate_V2 = mkV2 (mkV "konsoliderar"); -- status=guess, src=wikt
lin consolidate_V = mkV "sammanföra" "sammanförde" "sammanfört" ; -- comment=6
lin fountain_N = mkN "fontän" "fontäner" ; -- SaldoWN
lin graduate_V2 = variants {} ;
lin graduate_V = mkV "examinerar" ; -- comment=3
lin gloom_N = mkN "svårmod" neutrum | mkN "mörker" neutrum ; -- SaldoWN -- comment=3
lin bite_N = mkN "snacks" neutrum | mkN "bett" neutrum ; -- SaldoWN -- comment=21
lin structure_V2 = variants {} ;
lin noun_N = mkN "substantiv" neutrum | mkN "substantiv" neutrum ; -- SaldoWN
lin nomination_N = mkN "nominering" ; -- SaldoWN
lin armchair_N = mkN "fåtölj" "fåtöljer" ; -- SaldoWN
lin virtual_A = mkA "virtuell" ;
lin unprecedented_A = mkA "exempellös" ; -- SaldoWN
lin tumble_V2 = variants {} ;
lin tumble_V = mkV "tumlar" ; -- comment=4
lin ski_N = mkN "skida" ; -- SaldoWN
lin architectural_A = variants {} ;
lin violation_N = mkN "intrång" neutrum | mkN "våldtäkt" "våldtäkter" ; -- SaldoWN -- comment=3
lin rocket_N = mkN "raket" "raketer" ; -- SaldoWN
lin inject_V2 = variants {} ;
lin departmental_A = variants {} ;
lin row_V2 = mkV2 (mkV "gräla") | mkV2 (mkV "bråka"); -- status=guess, src=wikt status=guess, src=wikt
lin row_V = mkV "ror" ; -- comment=8
lin luxury_A = variants{} ;
lin fax_N = variants{} ;
lin deer_N = mkN "hjort" ; -- SaldoWN
lin climber_N = mkN "streber" ; -- comment=2
lin photographic_A = mkA "fotografisk" ;
lin haunt_V2 = dirV2 (partV (mkV "spökar")"ut");
lin fiercely_Adv = variants{} ;
lin dining_N = variants {} ;
lin sodium_N = mkN "natrium" neutrum | mkN "natrium" neutrum ; -- SaldoWN -- status=guess
lin gossip_N = mkN "skvallerbytta" ; -- comment=3
lin bundle_N = mkN "knippe" | mkN "packe" utrum ; -- SaldoWN -- comment=9
lin bend_N = mkN "vända" ; -- comment=13
lin recruit_N = mkN "rekryt" "rekryter" ;
lin hen_N = mkN "höna" ; -- SaldoWN
lin fragile_A = mkA "bräcklig" ; -- comment=6
lin deteriorate_V2 = mkV2 (mkV "försämras"); -- status=guess, src=wikt
lin deteriorate_V = mkV "försämrar" ; -- comment=2
lin dependency_N = variants {} ;
lin swift_A = mkA "strid" ; -- comment=2
lin scramble_VV = variants {} ;
lin scramble_V2V = variants {} ;
lin scramble_V2 = variants {} ;
lin scramble_V = variants {} ;
lin overview_N = mkN "överblick" | mkN "översikt" "översikter" ; -- SaldoWN
lin imprison_V2 = mkV2 (mkV "fängsla"); -- status=guess, src=wikt
lin trolley_N = mkN "spårvagn" | mkN "kärra" ; -- SaldoWN -- comment=2
lin rotation_N = mkN "rotation" "rotationer" ; -- SaldoWN
lin denial_N = mkN "förnekande" ; -- SaldoWN
lin boiler_N = mkN "ångpanna" ; -- comment=4
lin amp_N = variants {} ;
lin trivial_A = mkA "trivial" ;
lin shout_N = mkN "skälla" | mkN "skrika" ; -- SaldoWN -- comment=3
lin overtake_V2 = mkV2 (mkV (mkV "köra") "om"); -- status=guess, src=wikt
lin make_N = mkN "vara" ; -- comment=8
lin hunter_N = mkN "jägare" utrum ; -- SaldoWN
lin guess_N = mkN "gissning" ; -- comment=2
lin doubtless_Adv = mkAdv "säkerligen" ;
lin syllable_N = mkN "stavelse" "stavelser" ; -- SaldoWN
lin obscure_A = mkA "obskyr" | mkA "otydlig" ; -- SaldoWN -- comment=12
lin mould_N = mkN "mögel" neutrum | mkN "mögel" neutrum ; -- SaldoWN -- comment=17
lin limestone_N = mkN "kalksten" ; -- status=guess
lin leak_V2 = mkV2 (mkV "läcka"); -- status=guess, src=wikt
lin leak_V = mkV "läcker" ;
lin beneficiary_N = mkN "förmånstagare" utrum ; -- SaldoWN
lin veteran_N = mkN "veteran" "veteraner" ; -- SaldoWN
lin surplus_A = variants{} ;
lin manifestation_N = mkN "utslag" neutrum; -- comment=7
lin vicar_N = mkN "kyrkoherde" utrum; -- comment=2
lin textbook_N = mkN "lärobok" "läroböcker" ; -- SaldoWN
lin novelist_N = variants {} ;
lin halfway_Adv = mkAdv "halvvägs" ; -- status=guess
lin contractual_A = mkA "avtalsenlig" ; -- SaldoWN
lin swap_V2 = variants {} ;
lin swap_V = mkV "byter" ;
lin guild_N = mkN "skrå" "skråt" "skrån" "skråen" ; -- SaldoWN
lin ulcer_N = mkN "sår" neutrum | mkN "sår" neutrum ; -- SaldoWN -- comment=2
lin slab_N = mkN "häll" ; -- SaldoWN
lin detector_N = mkN "sensor" "sensorer" | mkN "detektor" "detektorer" ; -- SaldoWN
lin detection_N = variants {} ;
lin cough_V2 = dirV2 (partV (mkV "hackar")"av");
lin cough_V = mkV "hostar" ; -- comment=3
lin whichever_Quant = variants{} ;
lin spelling_N = mkN "stavning" ;
lin lender_N = mkN "långivare" utrum;
lin glow_N = mkN "glöd" "glöder" ; -- SaldoWN
lin raised_A = variants{} ;
lin prolonged_A = variants{} ;
lin voucher_N = mkN "kupong" "kuponger" | mkN "kvitto" "kvittot" "kvitton" "kvittona" ; -- SaldoWN -- comment=8
lin t_shirt_N = variants {} ;
lin linger_V = mkV "sölar" ; -- comment=2
lin humble_A = mkA "ödmjuk" ; -- comment=8
lin honey_N = mkN "honung" ; -- SaldoWN
lin scream_N = mkN "skrika" ; -- SaldoWN
lin postcard_N = mkN "vykort" neutrum | (mkN "vykort" neutrum) | (mkN "brevkort" neutrum) ; -- SaldoWN -- status=guess status=guess
lin managing_A = variants{} ;
lin alien_A = mkA "utländsk" ; -- comment=5
lin trouble_V2 = variants {} ;
lin trouble_V = mkV "besvärar" ;
lin reverse_N = mkN "backa" | mkN "vända" ; -- SaldoWN -- comment=16
lin odour_N = mkN "odör" "odörer" ; -- comment=4
lin fundamentally_Adv = variants{} ;
lin discount_V2 = variants {} ;
lin discount_V = mkV "diskonterar" ; -- comment=3
lin blast_V2 = variants {} ;
lin blast_V = mkV "spränger" ; -- comment=6
lin syntactic_A = variants {} ;
lin scrape_V2 = dirV2 (partV (mkV "sparar")"in"); -- comment=5
lin scrape_V = mkV "sparar" ; -- comment=10
lin residue_N = mkN "rest" "rester" ; -- comment=3
lin procession_N = mkN "tåg" neutrum; -- comment=2
lin pioneer_N = mkN "pionjär" "pionjärer" ; -- SaldoWN
lin intercourse_N = mkN "samlag" neutrum; -- comment=3
lin deter_V2 = mkV2 (mkV "förhindra"); -- status=guess, src=wikt
lin deadly_A = mkA "dödlig" | mkA "fullständig" ; -- SaldoWN -- comment=4
lin complement_V2 = variants {} ;
lin restrictive_A = mkA "restriktiv" ; -- SaldoWN
lin nitrogen_N = mkN "kväve" ;
lin citizenship_N = mkN "medborgarskap" neutrum;
lin pedestrian_N = mkN "fotgängare" utrum | mkN "fotgängare" utrum ; -- SaldoWN -- comment=2
lin detention_N = mkN "kvarsittning" ; -- comment=7
lin wagon_N = mkN "piket" "piketer" | (mkN "vagn") | mkN "kärra" ; -- SaldoWN -- status=guess status=guess
lin microphone_N = mkN "mikrofon" "mikrofoner" ; -- SaldoWN
lin hastily_Adv = variants{} ;
lin fixture_N = mkN "inventarium" "inventariet" "inventarier" "inventarierna" ; -- comment=3
lin choke_V2 = dirV2 (partV (mkV "spärrar")"ut"); -- comment=3
lin choke_V = mkV "stryper" ; -- comment=7
lin wet_V2 = mkV2 (mkV "vätas"); -- status=guess, src=wikt
lin weed_N = mkN "ogräs" neutrum | mkN "ogräs" neutrum ; -- SaldoWN
lin programming_N = mkN "programmering" ;
lin power_V2 = variants {} ;
lin nationally_Adv = variants{} ;
lin dozen_N = mkN "dussin" neutrum ;
lin carrot_N = mkN "morot" "morötter" ; -- SaldoWN
lin bulletin_N = mkN "bulletin" "bulletiner" ; -- SaldoWN
lin wording_N = mkN "formulering" | mkN "lydelse" "lydelser" ; -- SaldoWN
lin vicious_A = mkA "giftig" | mkA "illvillig" ; -- SaldoWN -- comment=4
lin urgency_N = mkN "brådska" ; -- SaldoWN
lin spoken_A = variants{} ;
lin skeleton_N = mkN "skelett" neutrum;
lin motorist_N = mkN "bilist" "bilister" ; -- SaldoWN
lin interactive_A = mkA "interaktiv" ; -- SaldoWN
lin compute_V2 = dirV2 (partV (mkV "räknar")"ut"); -- comment=5
lin compute_V = mkV "räknar" ; -- comment=4
lin whip_N = mkN "piska" ; -- SaldoWN
lin urgently_Adv = variants{} ;
lin telly_N = variants {} ;
lin shrub_N = mkN "buske" utrum;
lin porter_N = mkN "bärare" utrum | mkN "bärare" utrum ; -- SaldoWN -- comment=3
lin ethics_N = mkN "etik" ; -- SaldoWN
lin banner_N = mkN "baner" "baneret" "baner" "baneren" | mkN "banderoll" "banderoller" ; -- SaldoWN -- comment=5
lin velvet_N = mkN "sammet" ; -- SaldoWN
lin omission_N = mkN "förbiseende" | mkN "utelämnande" ; -- SaldoWN -- comment=3
lin hook_V2 = mkV2 (mkV "krokar") | mkV2 (mkV "hakar"); -- status=guess, src=wikt status=guess, src=wikt
lin hook_V = mkV "knäpper" ; -- comment=5
lin gallon_N = mkN "gallon" "gallonen" "gallon" "gallonen" ; -- SaldoWN
lin financially_Adv = variants{} ;
lin superintendent_N = mkN "kommissarie" "kommissarier" | mkN "ledare" utrum ; -- SaldoWN -- comment=6
lin plug_V2 = dirV2 (partV (mkV "smockar")"till"); -- comment=2
lin plug_V = mkV "tamponerar" ; -- comment=5
lin continuation_N = mkN "förlängning" ; -- SaldoWN
lin reliance_N = mkN "tillit" ; -- SaldoWN
lin justified_A = variants{} ;
lin fool_V2 = dirV2 (partV (mkV "lurar")"till"); -- comment=2
lin fool_V = mkV "skämtar" ; -- comment=5
lin detain_V2 = mkV2 (mkV "gripa" "grep" "gripit") | mkV2 (mkV "internerar"); -- status=guess, src=wikt status=guess, src=wikt
lin damaging_A = variants {} ;
lin orbit_N = mkN "omloppsbana" ; -- SaldoWN
lin mains_N = variants{} ;
lin discard_V2 = dirV2 (partV (mkV "kastar")"ut"); -- comment=4
lin dine_V2 = variants {} ;
lin dine_V = mkV "dinerar" ;
lin compartment_N = mkN "fack" neutrum | mkN "kupé" "kupéer" ; -- SaldoWN -- comment=2
lin revised_A = variants{} ;
lin privatization_N = mkN "privatisering" ; -- status=guess
lin memorable_A = mkA "minnesvärd" "minnesvärt" ; -- comment=2
lin lately_Adv = variants{} ;
lin distributed_A = variants{} ;
lin disperse_V2 = variants {} ;
lin disperse_V = mkV "upplöser" ; -- comment=3
lin blame_N = mkN "skuld" "skulder" ; -- comment=3
lin basement_N = mkN "källare" utrum; -- comment=2
lin slump_V2 = variants {} ;
lin slump_V = mkV "rasar" ; -- comment=2
lin puzzle_V2 = variants {} ;
lin puzzle_V = variants {} ;
lin monitoring_N = variants {} ;
lin talented_A = mkA "talangfull" ; -- comment=2
lin nominal_A = mkA "nominell" ; -- comment=3
lin mushroom_N = mkN "champinjon" "champinjoner" ; -- SaldoWN
lin instructor_N = mkN "högskoleadjunkt" "högskoleadjunkter" ; -- comment=3
lin fork_N = variants{} ;
lin fork_4_N = variants{} ;
lin fork_3_N = mkN "vägskäl" neutrum ;
lin fork_1_N = mkN "gaffel" ;
lin board_V2 = dirV2 (partV (mkV "plattar")"ut"); -- comment=2
lin board_V = mkV "råda" "rådde" "rått" ; -- comment=10
lin want_N = mkN "vilja" | mkN "behov" neutrum ; -- SaldoWN -- comment=8
lin disposition_N = mkN "sinnelag" neutrum | mkN "lynne" ; -- SaldoWN -- comment=14
lin cemetery_N = mkN "kyrkogård" ; -- SaldoWN
lin attempted_A = variants{} ;
lin nephew_N = mkN "brorson" "brorsöner" ; -- SaldoWN
lin magical_A = mkA "magisk" ;
lin ivory_N = mkN "elfenben" neutrum ; -- SaldoWN
lin hospitality_N = mkN "gästfrihet" | mkN "gästvänlighet" ; -- SaldoWN
lin besides_Prep = variants {} ;
lin astonishing_A = variants {} ;
lin tract_N = mkN "broschyr" "broschyrer" | mkN "traktat" "traktater" ; -- SaldoWN -- status=guess
lin proprietor_N = mkN "ägare" utrum; -- comment=2
lin license_V2 = mkV2 (mkV "licensierar") | mkV2 (mkV (mkV "ge") "tillstånd) "); -- status=guess, src=wikt status=guess, src=wikt
lin differential_A = mkA "differentiell" ;
lin affinity_N = mkN "släktskap" | mkN "frändskap" "frändskaper" ; -- SaldoWN -- comment=4
lin talking_N = variants{} ;
lin royalty_N = mkN "royalty" "royaltyn" "royalties" "royalties" ; -- SaldoWN
lin neglect_N = mkN "försummelse" "försummelser" | mkN "slarva" ; -- SaldoWN -- comment=2
lin irrespective_A = mkA "oberoende" ;
lin whip_V2 = dirV2 (partV (mkV "slå" "slog" "slagit")"ut"); -- comment=18
lin whip_V = mkV "vispar" ; -- comment=8
lin sticky_A = mkA "tryckande" | mkA "omedgörlig" ; -- SaldoWN -- comment=11
lin regret_N = mkN "ånger" | mkN "saknad" "saknader" ; -- SaldoWN -- comment=6
lin incapable_A = mkA "oförmögen" "oförmöget" ; -- SaldoWN
lin franchise_N = mkN "koncession" "koncessioner" | mkN "rösträtt" ; -- SaldoWN -- comment=6
lin dentist_N = mkN "tandläkare" utrum ; -- SaldoWN -- comment=2
lin contrary_N = mkN "motsats" "motsatser" | mkN "stridande" ; -- SaldoWN -- comment=2
lin profitability_N = variants{} ;
lin enthusiast_N = mkN "entusiast" "entusiaster" ; -- comment=2
lin crop_V2 = mkV2 "beta" "betar" "beta" "betog" "betagit" "betagen" | mkV2 (mkV "beskära") ; -- SaldoWN -- status=guess, src=wikt
lin crop_V = mkV "beta" "betar" "beta" "betog" "betagit" "betagen" | mkV "skördar" ; -- SaldoWN -- comment=5
lin utter_V2 = mkV2 (mkV (mkV "ge") "till"); -- status=guess, src=wikt
lin pile_V2 = dirV2 (partV (mkV "lastar")"ur"); -- comment=6
lin pile_V = mkV "samlar" ; -- comment=7
lin pier_N = mkN "pir" | mkN "väggfält" neutrum ; -- SaldoWN -- comment=5
lin dome_N = mkN "kupol" "kupoler" ; -- SaldoWN
lin bubble_N = mkN "bubbla" | mkN "pratbubbla" ; -- SaldoWN -- comment=5
lin treasurer_N = mkN "kassör" "kassörer" ; -- SaldoWN
lin stocking_N = mkN "strumpa" ;
lin sanctuary_N = mkN "helgedom" ; -- SaldoWN
lin ascertain_V2 = variants {} ;
lin arc_N = mkN "kurva" | mkN "båge" ; -- status=guess status=guess
lin quest_N = (mkN "resa") | (mkN "uppdrag" neutrum) | mkN "mål" | mkN "strävan" ; -- status=guess status=guess status=guess status=guess
lin mole_N = mkN "mullvad" ; -- SaldoWN
lin marathon_N = mkN "maraton" neutrum | mkN "maratonlopp" neutrum ; -- SaldoWN -- comment=2
lin feast_N = mkN "bankett" "banketter" | mkN "högtid" "högtider" ; -- SaldoWN -- comment=3
lin crouch_V2 = variants {} ;
lin crouch_V = variants {} ;
lin storm_V2 = variants {} ;
lin storm_V = mkV "stormar" ;
lin hardship_N = mkN "vedermöda" ; -- SaldoWN
lin entitlement_N = mkN "rättighet" "rättigheter" | mkN "berättigande" ; -- SaldoWN -- comment=2
lin circular_N = mkN "roterande" ; -- comment=6
lin walking_A = variants{} ;
lin strap_N = mkN "band" neutrum | mkN "stropp" ; -- SaldoWN -- comment=4
lin sore_A = mkA "öm" "ömt" "ömma" "ömma" "ömmare" "ömmast" "ömmaste" ; -- comment=6
lin complementary_A = variants {} ;
lin understandable_A = mkA "förståelig" ; -- comment=4
lin noticeable_A = mkA "påtaglig" ; -- comment=9
lin mankind_N = variants {} ;
lin majesty_N = mkN "majestät" neutrum; -- comment=2
lin pigeon_N = mkN "duva" ; -- SaldoWN
lin goalkeeper_N = mkN "målvakt" "målvakter" ; -- SaldoWN
lin ambiguous_A = mkA "tvetydig" ; -- SaldoWN
lin walker_N = mkN "fotgängare" utrum; -- comment=2
lin virgin_N = mkN "oskuld" "oskulder" ; -- SaldoWN
lin prestige_N = mkN "prestige" utrum | mkN "prestige" utrum ; -- SaldoWN
lin preoccupation_N = mkN "upptagenhet" "upptagenheter" ; -- SaldoWN
lin upset_A = variants{} ;
lin municipal_A = mkA "kommunal" ; -- SaldoWN
lin groan_V2 = mkV2 (mkV "stöna"); -- status=guess, src=wikt
lin groan_V = mkV "stönar" ;
lin craftsman_N = mkN "hantverkare" utrum ; -- SaldoWN
lin anticipation_N = mkN "förutseende" ;
lin revise_V2 = mkV2 "revidera" ;
lin revise_V = mkV "revidera" ;
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
lin particular_N = variants {} ;
lin intent_A = variants {} ;
lin fascinate_V2 = variants {} ;
lin conductor_N = mkN "ledare" utrum | mkN "konduktör" "konduktörer" ; -- SaldoWN -- comment=4
lin feasible_A = mkA "genomförbar" ;
lin vacant_A = mkA "vakant" "vakant" ; -- SaldoWN
lin trait_N = mkN "drag" neutrum | mkN "drag" neutrum ; -- SaldoWN = mkN "drag" neutrum ; -- comment=4
lin meadow_N = mkN "äng" ; -- SaldoWN
lin creed_N = mkN "tro" | mkN "trosartikel" ; -- SaldoWN -- comment=6
lin unfamiliar_A = variants {} ;
lin optimism_N = mkN "optimism" "optimismer" ; -- SaldoWN
lin wary_A = mkA "rädd" ;
lin twist_N = mkN "skiftnyckel" | mkN "vändning" ; -- SaldoWN -- comment=6
lin sweet_N = mkN "efterrätt" "efterrätter" | mkN "karamell" "karameller" ; -- SaldoWN -- comment=5
lin substantive_A = mkA "verklig" ; -- comment=5
lin excavation_N = mkN "utgrävning" | mkN "utgrävningsplats" "utgrävningsplatser" ; -- SaldoWN -- comment=2
lin destiny_N = mkN "öde" ; -- comment=3
lin thick_Adv = mkAdv "tjockt" ; -- status=guess
lin pasture_N = mkN "bete" utrum | mkN "betesmark" "betesmarker" ; -- SaldoWN = mkN "bete" ; -- comment=6
lin archaeological_A = mkA "arkeologisk" ; -- SaldoWN
lin tick_V2 = variants {} ;
lin tick_V = mkV "tickar" ;
lin profit_V2 = variants {} ;
lin profit_V = mkV "gagnar" ; -- comment=2
lin pat_V2 = mkV2 (mkV "klappar"); -- status=guess, src=wikt
lin pat_V = mkV "klappar" ; -- comment=3
lin papal_A = mkA "påvlig" ;
lin cultivate_V2 = mkV2 (mkV "odlar"); -- status=guess, src=wikt
lin awake_V = mkV "väcker" ; -- comment=2
lin trained_A = variants{} ;
lin civic_A = mkA "medborgerlig" ; -- SaldoWN
lin voyage_N = mkN "resa" ; -- SaldoWN
lin siege_N = mkN "belägring" ; -- SaldoWN
lin enormously_Adv = variants{} ;
lin distract_V2 = variants {} ;
lin distract_V = mkV "avleda" "avledde" "avlett" ; -- comment=3
lin stroll_V = mkV "strövar" ; -- comment=5
lin jewel_N = mkN "juvel" "juveler" | mkN "sten" "stenen" "stenar" "stenarna" ; -- SaldoWN -- comment=6
lin honourable_A = mkA "rättskaffens" ; -- comment=5
lin helpless_A = mkA "hjälplös" ; -- SaldoWN
lin hay_N = mkN "hö" neutrum ; -- SaldoWN
lin expel_V2 = variants {} ;
lin eternal_A = mkA "evig" ; -- SaldoWN
lin demonstrator_N = mkN "demonstrant" "demonstranter" | mkN "demonstratör" "demonstratörer" ; -- SaldoWN -- comment=3
lin correction_N = mkN "korrigering" | mkN "tillrättavisning" ; -- SaldoWN -- comment=9
lin civilization_N = mkN "civilisation" "civilisationer" | mkN "civilisering" ; -- SaldoWN -- comment=4
lin ample_A = mkA "dryg" | mkA "tillräcklig" ; -- SaldoWN -- comment=7
lin retention_N = variants {} ;
lin rehabilitation_N = mkN "upprättelse" "upprättelser" | mkN "restauration" "restaurationer" ; -- SaldoWN -- comment=3
lin premature_A = compoundA (regA "förhastad"); -- comment=4
lin encompass_V2 = mkV2 (mkV "inringar"); -- status=guess, src=wikt
lin distinctly_Adv = variants{} ;
lin diplomat_N = mkN "diplomat" "diplomater" ; -- SaldoWN
lin articulate_V2 = dirV2 (partV (mkV "talar")"om");
lin articulate_V = mkV "artikulerar" ; -- comment=5
lin restricted_A = variants{} ;
lin prop_V2 = dirV2 (partV (mkV "lutar")"av");
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
lin excited_A = variants{} ;
lin decay_N = mkN "sönderfall" neutrum | mkN "förfall" neutrum ; -- SaldoWN
lin screw_N = mkN "skruv" ; -- SaldoWN
lin rally_V2V = variants {} ;
lin rally_V2 = variants {} ;
lin rally_V = mkV "samlar" ; -- comment=2
lin pest_N = mkN "bråkmakare" utrum | mkN "skadedjur" neutrum ; -- SaldoWN -- comment=3
lin invaluable_A = mkA "ovärderlig" ; -- comment=2
lin homework_N = mkN "läxa" ;
lin harmful_A = mkA "skadlig" ; -- comment=3
lin bump_V2 = dirV2 (partV (mkV "törnar")"in");
lin bump_V = mkV "stöter" ; -- comment=9
lin bodily_A = mkA "fysisk" ; -- comment=2
lin grasp_N = mkN "våld" neutrum; -- comment=7
lin finished_A = variants{} ;
lin facade_N = mkN "fasad" "fasader" | mkN "utanverk" neutrum ; -- SaldoWN -- comment=2
lin cushion_N = mkN "dyna" | mkN "vall" ; -- SaldoWN -- comment=6
lin conversely_Adv = variants{} ;
lin urge_N = mkN "mana" | mkN "kräva" ; -- SaldoWN -- comment=9
lin tune_V2 = dirV2 (partV (mkV "visar")"in");
lin tune_V = mkV "trimmar" ; -- comment=5
lin solvent_N = mkN "lösningsmedel" ; -- status=guess
lin slogan_N = mkN "slagord" neutrum | mkN "slogan" "slogan" "slogans" "slogansen" ; -- SaldoWN -- comment=2
lin petty_A = mkA "småaktig" | mkA "småsint" "småsint" ; -- SaldoWN -- comment=11
lin perceived_A = variants{} ;
lin install_V2 = mkV2 (mkV "installerar"); -- status=guess, src=wikt
lin install_V = mkV "monterar" ; -- comment=3
lin fuss_N = mkN "ståhej" neutrum | mkN "bråka" ; -- SaldoWN -- comment=8
lin rack_N = mkN "ställ" neutrum | mkN "ställ" neutrum ; -- SaldoWN -- comment=4
lin imminent_A = mkA "överhängande" ; -- comment=2
lin short_N = mkN "kortslutning" | mkN "knapp" ; -- SaldoWN -- comment=9
lin revert_V = variants {} ;
lin ram_N = mkN "slå" ; -- comment=10
lin contraction_N = mkN "kontraktion" "kontraktioner" | mkN "sammandragning" ; -- SaldoWN
lin tread_V2 = dirV2 (partV (mkV "trampar")"ut"); -- comment=17
lin tread_V = mkV "sular" ; -- comment=7
lin supplementary_A = mkA "extra" ;
lin ham_N = mkN "skinka" ; -- SaldoWN
lin defy_V2V = variants {} ;
lin defy_V2 = variants {} ;
lin athlete_N = mkN "atlet" "atleter" | mkN "idrottare" utrum ; -- SaldoWN
lin sociological_A = mkA "sociologisk" ; -- status=guess
lin physician_N = mkN "läkare" utrum; -- comment=2
lin crossing_N = mkN "övergångsställe" | mkN "korsning" ; -- SaldoWN -- comment=3
lin bail_N = mkN "borgen" ; -- status=guess
lin unwanted_A = compoundA (regA "oönskad");
lin tight_Adv = mkAdv "fast" ;
lin plausible_A = mkA "rimlig" ; -- comment=5
lin midfield_N = mkN "mittfält" neutrum;
lin alert_A = mkA "alert" "alert" | mkA "vaken" "vaket" ; -- SaldoWN -- comment=6
lin feminine_A = mkA "kvinnlig" ; -- SaldoWN
lin drainage_N = mkN "dränering" ;
lin cruelty_N = mkN "grymhet" ; -- SaldoWN = mkN "grymhet" "grymheter" ;
lin abnormal_A = mkA "abnorm" ; -- SaldoWN
lin relate_N = variants{} ;
lin poison_V2 = mkV2 (mkV "förgifta"); -- status=guess, src=wikt
lin symmetry_N = mkN "symmetri" "symmetrier" ; -- SaldoWN
lin stake_V2 = variants {} ;
lin rotten_A = L.rotten_A ;
lin prone_A = compoundA (regA "framåtlutad"); -- comment=3
lin marsh_N = mkN "sumpmark" "sumpmarker" | mkN "kärr" neutrum ; -- SaldoWN -- comment=7
lin litigation_N = mkN "rättstvist" "rättstvister" | mkN "process" "processer" ; -- SaldoWN -- comment=2
lin curl_N = mkN "ring" neutrum; -- comment=12
lin urine_N = mkN "urin" ; -- SaldoWN
lin latin_A = mkA "latinsk" ;
lin hover_V = mkV "sväva" ; -- status=guess, src=wikt
lin greeting_N = mkN "hälsning" | mkN "lyckönskning" ; -- SaldoWN -- comment=4
lin chase_N = mkN "springa" ; -- comment=2
lin spouse_N = variants{} ;
lin produce_N = mkN "avkastning" | mkN "produktion" "produktioner" ; -- SaldoWN -- comment=6
lin forge_V2 = mkV2 (mkV "förfalska"); -- status=guess, src=wikt
lin forge_V = mkV "förfalskar" ;
lin salon_N = mkN "salong" "salonger" ; -- SaldoWN
lin handicapped_A = variants{} ;
lin sway_V2 = variants {} ;
lin sway_V = mkV "svänger" ; -- comment=8
lin homosexual_A = mkA "homosexuell" ;
lin handicap_V2 = variants {} ;
lin colon_N = mkN "kolon" ;
lin upstairs_N = variants {} ;
lin stimulation_N = mkN "stimulans" "stimulanser" | mkN "stimulering" ; -- SaldoWN -- comment=2
lin spray_V2 = dirV2 (partV (mkV "sprutar")"in");
lin original_N = mkN "nyskapande" ; -- comment=6
lin lay_A = mkA "täck" ; -- comment=4
lin garlic_N = mkN "vitlök" ; -- SaldoWN
lin suitcase_N = mkN "resväska" ;
lin skipper_N = mkN "skeppare" utrum;
lin moan_VS = variants {} ;
lin moan_V2 = variants {} ;
lin moan_V = mkV "gnäller" ; -- comment=4
lin manpower_N = mkN "arbetskraft" ; -- comment=3
lin manifest_V2 = variants {} ;
lin incredibly_Adv = variants{} ;
lin historically_Adv = variants{} ;
lin decision_making_N = variants{} ;
lin wildly_Adv = variants{} ;
lin reformer_N = mkN "reformator" "reformatorer" ; -- status=guess
lin quantum_N = mkN "kvantum" neutrum;
lin considering_Subj = variants{} ;
}