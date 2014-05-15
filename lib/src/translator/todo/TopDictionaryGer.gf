---- edited by AR till way_N and some structural words below

concrete TopDictionaryGer of TopDictionary = CatGer ** 
  open 
    ParadigmsGer, (S = SyntaxGer), (L = LexiconGer),
    TopDictGer, (R = ResGer), (M = MorphoGer), (I = IrregGer), Prelude in {

flags
  coding=utf8 ;

oper mkReflV : Str -> V = \s -> reflV (mkV s) accusative ;
oper junkV : V -> Str -> V = \_,_ -> variants {} ; ---- to match Wiktionary-extracted non-verbs

lin of_Prep = von_Prep ;
lin and_Conj = S.and_Conj ;
lin in_Prep = S.in_Prep ;
lin have_VV = S.must_VV ;
lin have_V2 = S.have_V2 ;
lin have_V = irregV "bekommen" "bekommt" "bekam" "bekäme" "bekommen" ;
lin it_Pron = S.it_Pron | let s = Predef.BIND ++ "'s" in M.mkPronPers s s "ihm" "seiner" "sein" R.Neutr R.Sg R.P3 ;
lin to_Prep = zu_Prep | mkPrep "nach" dative ;
lin for_Prep = S.for_Prep ;
lin i_Pron = S.i_Pron ;
lin iFem_Pron = S.i_Pron ;
lin that_Subj = S.that_Subj ;
lin he_Pron = S.he_Pron ;
lin on_Prep = S.on_Prep ;
lin with_Prep = S.with_Prep ;
lin do_V2 = dirV2 (irregV "tun" "tut" "tat" "täte" "getan") ;
lin at_Prep = anDat_Prep ;
lin by_Prep = mkPrep "durch" accusative ;
lin but_Conj = {s1 = [] ; s2 = "aber" ; n = R.Pl} ;
lin from_Prep = von_Prep | mkPrep "aus" dative ;
lin they_Pron = S.they_Pron ;
lin theyFem_Pron = S.they_Pron ;
lin she_Pron = S.she_Pron ;
lin or_Conj = S.or_Conj ;
lin as_Subj = ss "wie" ;
lin we_Pron = S.we_Pron ;
lin weFem_Pron = S.we_Pron ;
lin say_VS = L.say_VS ;
lin say_V2 = dirV2 (regV "sagen") ;
lin say_V = regV "sagen" ;
lin if_Subj = S.if_Subj | ss "falls" ;
lin go_VV = mkVV L.go_V ;
lin go_VA = mkVA (seinV werden_V) ;
lin go_V = seinV I.gehen_V | seinV I.fahren_V ; -- comment=split
lin get_VV = mkVV I.dürfen_V ;
lin get_V2V = mkV2V (mkV "machen") accPrep ; -- comment=?
lin make_V2V = mkV2V (mkV "machen") accPrep ;
lin make_V2A = mkV2A (mkV "machen") accPrep ;
lin make_V2 = dirV2 (regV "machen") ;
lin make_V = regV "machen" ;
lin as_Prep = mkPrep "wie" nominative ;
lin out_Adv = mkAdv "draussen" ;
lin up_Adv = mkAdv "auf" ;
lin see_VS = mkVS I.sehen_V ;
lin see_VQ = mkVQ I.sehen_V ;
lin see_V2V = mkV2V I.sehen_V accPrep ;
lin see_V2 = L.see_V2 ;
lin see_V = I.sehen_V ;
lin know_VS = L.know_VS ;
lin know_VQ = mkVQ I.wissen_V ;
lin know_V2 = mkV2 I.kennen_V ;
lin know_V = I.wissen_V ;
lin time_N = reg2N "Mal" "Male" neuter ;
lin time_2_N = reg2N "Mal" "Male" neuter ;
lin time_1_N = mkN "Zeit" "Zeiten" feminine ;
lin take_V2 = mkV2 nehmen_V ;
lin so_Adv = mkAdv "so" ;
lin year_N = L.year_N ;
lin into_Prep = inAcc_Prep ;
lin then_Adv = mkAdv "dann" ;
lin think_VS = mkVS I.denken_V ;
lin think_V2 = mkV2 I.denken_V ;
lin think_V = L.think_V ;
lin come_V = L.come_V ;
lin than_Subj = ss "als" ;
lin more_Adv = mkAdv "mehr" ;
lin about_Prep = S.on_Prep ;
lin now_Adv = mkAdv "jetzt" | mkAdv "nun" ;
lin last_A = mkA "letzt" ;
lin last_1_A = mkA "letzt" ;
lin last_2_A = mkA "letzt" ;
lin other_A = mkA "ander" ;
lin give_V3 = L.give_V3 ;
lin give_V2 = dirV2 I.geben_V ;
lin give_V = I.geben_V ;
lin just_Adv = mkAdv "genau" | mkAdv "nur" ; -- comment=split
lin people_N = mkN "Volk" "Völker" neuter ;
lin also_Adv = mkAdv "auch" ;
lin well_Adv = mkAdv "gut" ;
lin only_Adv = mkAdv "nur" ;
lin new_A = L.new_A ;
lin when_Subj = ss "wenn" | ss "als" ; -- comment=split in German ; could be parametric
lin way_N = mkN "Weg" ;
lin way_2_N = mkN "Weise" ;
lin way_1_N = mkN "Weg" ;
lin look_VA = mkVA (mkV "aus" I.sehen_V) ;
lin look_V2 = dirV2 (regV "gucken") ;
lin look_V = regV "blicken" ;
lin like_Prep = mkPrep "wie"nominative ;
lin use_VV = mkVV (mkV "pflegen") ;
lin use_V2 = dirV2 (irregV "verwenden" "verwendet" "verwendete" "verwendete" "verwendet") ;
lin use_V = no_geV (mkV "benützen") ;
lin because_Subj = S.because_Subj ;
lin good_A = mk3A "gut" "besser" "beste" ;
lin find_VS = mkVS I.finden_V ;
lin find_V2A = mkV2A I.finden_V ;
lin find_V2 = L.find_V2 ;
lin find_V = I.finden_V ;
lin man_N = L.man_N ;
lin want_VV = S.want_VV ;
lin want_V2V = mkV2V I.wollen_V ;
lin want_V2 = mkV2 I.wollen_V ;
lin want_V = I.wollen_V ;
lin day_N = L.day_N ;
lin between_Prep = S.between_Prep ;
lin even_Adv = mkAdv "sogar" ;
lin there_Adv = ss "da" | ss "dort" ;
lin many_Det = S.many_Det ;
lin after_Prep = S.after_Prep ;
lin down_Adv = mkAdv "unter" ;
lin yeah_Interj = ss "jawohl" ;
lin so_Subj = ss "so dass" ;
lin thing_N = mkN "Sache" | mkN "Ding" "Dinge" neuter ;
lin tell_VS = mkVS (no_geV (mkV "erzählen")) ;
lin tell_V3 = mkV3 (no_geV (mkV "erzählen")) ;
lin tell_1_V3 = variants{} ; -- 
lin tell_2_V3 = variants{} ; -- 
lin tell_V2V = mkV2V (no_geV (mkV "erzählen")) ;
lin tell_V2S = mkV2S (no_geV (mkV "erzählen")) ;
lin tell_V2 = mkV2 (no_geV (mkV "erzählen")) ;
lin tell_V = no_geV (mkV "erzählen") ;
lin through_Prep = S.through_Prep ;
lin back_Adv = mkAdv "zurück" ;
lin still_Adv = mkAdv "immer noch" ;
lin child_N = L.child_N ;
lin here_Adv = ss "hier" ;
lin over_Prep = mkPrep "über" accusative ; -- comment=split dative
lin too_Adv = mkAdv "zu" ;
lin put_V2 = mkV2 (mkV "setzen") | mkV2 (mkV "stellen") | mkV2 (mkV "legen") ;
lin on_Adv = mkAdv "auf" ;
lin no_Interj = mkInterj "nein" ;
lin work_V2 = mkV2 (no_geV (mkV "bearbeiten")) ;
lin work_V = mkV "arbeiten" ;
lin work_2_V = mkV "funktionieren" ;
lin work_1_V = mkV "arbeiten" ;
lin become_VA = L.become_VA ;
lin become_V2 = mkV2 (seinV werden_V) ; -- comment=subcat : VN
lin become_V = seinV werden_V ;
lin old_A = L.old_A ;
lin government_N = mkN "Regierung" ;
lin mean_VV = mkVV (mkV "meinen") ;
lin mean_VS = mkVS (mkV "meinen") | mkVS (no_geV (mkV "bedeuten")) ;
lin mean_V2V = mkV2V (mkV "meinen") ; -- comment=subcat
lin mean_V2 = mkV2 "meinen" ;
lin part_N = reg2N "Rolle" "Rollen" feminine ;
lin leave_V2V = mkV2V I.lassen_V ;
lin leave_V2 = L.leave_V2 ;
lin leave_V = seinV (mkV "ab" I.fahren_V) ;
lin life_N = reg2N "Leben" "Leben" neuter ;
lin great_A = mkA "grossartig" | mk3A "fein" "feiner" "feinste" ;
lin case_N = mkN "Fall" "Fälle" masculine | reg2N "Behälter" "Behälter" masculine ; -- comment=split
lin woman_N = L.woman_N ;
lin over_Adv = mkAdv "vorbei" ; -- comment=split
lin seem_VV = mkVV (mkV "aus" I.sehen_V) ;
lin seem_VS = mkVS (mkV "aus" I.sehen_V) ;
lin seem_VA = mkVA (mkV "aus" I.sehen_V) ;
lin work_N = reg2N "Arbeit" "Arbeiten" feminine ;
lin need_VV = mkVV (mkV "brauchen") ;
lin need_VV = mkVV (mkV "brauchen") ;
lin need_V2 = mkV2 (mkV "brauchen") ;
lin need_V = mkV "brauchen" ;
lin feel_VS = variants{}; -- dirV2 (irregV "denken" "denkt" "dachte" "dächte" "gedacht" ) ;
lin feel_VA = variants{}; -- irregV "denken" "denkt" "dachte" "dächte" "gedacht" ;
lin feel_V2 = dirV2 (irregV "denken" "denkt" "dachte" "dächte" "gedacht" ) ;
lin feel_V = irregV "denken" "denkt" "dachte" "dächte" "gedacht" ;
lin system_N = reg2N "System" "Systeme" neuter ;
lin each_Det = S.every_Det ;
lin may_2_VV = mkVV I.dürfen_V ;
lin may_1_VV = mkVV I.können_V ;
lin much_Adv = mkAdv "viel" ;
lin ask_VQ = mkVQ (mkV "fragen") ;
lin ask_V2V = mkV2V I.bitten_V ;
lin ask_V2 = mkV2 I.bitten_V ;
lin ask_V = I.bitten_V ;
lin group_N = reg2N "Gruppe" "Gruppen" feminine ;
lin number_N = L.number_N ;
lin number_3_N = variants{} ; -- 
lin number_2_N = mkN "Anzahl" "Anzahlen" feminine ;
lin number_1_N = mkN "Zahl" "Zahlen" feminine ;
lin yes_Interj = ss "ja" ;
lin however_Adv = mkAdv "aber" ;
lin another_Det = M.detLikeAdj False M.Sg "ander" ;
lin again_Adv = mkAdv "wieder" ;
lin world_N = reg2N "Welt" "Welten" feminine ;
lin area_N = reg2N "Gebiet" "Gebiete" neuter ;
lin area_6_N = variants{} ; -- 
lin area_5_N = variants{} ; -- 
lin area_4_N = variants{} ; -- 
lin area_3_N = variants{} ; -- 
lin area_2_N = variants{} ; -- 
lin area_1_N = reg2N "Gebiet" "Gebiete" neuter ;
lin show_VS = mkVS (regV "zeigen") ;
lin show_VQ = mkVQ (regV "zeigen") ;
lin show_V2 = mkV2 (regV "zeigen") ;
lin show_V = regV "zeigen" ;
lin course_N = reg2N "Bahn" "Bahnen" feminine ;
lin company_2_N = variants{} ; -- 
lin company_1_N = reg2N "Firma" "Firmen" feminine ;
lin under_Prep = S.under_Prep ;
lin problem_N = reg2N "Problem" "Probleme" neuter ;
lin against_Prep = mkPrep "gegen" accusative ;
lin never_Adv = mkAdv "nie" ;
lin most_Adv = mkAdv "meistens" ; -- comment=cat
lin service_N = service_N ; -- status=guess
lin try_VV = mkVV (mkV "anprobieren") ; -- status=guess, src=wikt
lin try_V2 = mkV2 (mkV "anprobieren") ; -- status=guess, src=wikt
lin try_V = mkV "anprobieren" ; -- status=guess, src=wikt
lin call_V2 = mkV2 (junkV (mkV "das") "Kind beim Namen nennen") ; -- status=guess, src=wikt
lin call_V = junkV (mkV "das") "Kind beim Namen nennen" ; -- status=guess, src=wikt
lin hand_N = L.hand_N ;
lin party_N = mkN "Partylöwe" masculine | mkN "Partymaus" feminine | mkN "Tanzmaus" feminine | mkN "Partyjunge" masculine | mkN "Partymädchen" neuter | mkN "Partygirl" neuter | mkN "Partygänger" masculine | mkN "Partygängerin" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin party_2_N = variants{} ; -- 
lin party_1_N = variants{} ; -- 
lin high_A = hell_A ; -- status=guess
lin about_Adv = mkAdv "ungefähr" ; -- status=guess
lin something_NP = S.something_NP ;
lin school_N = L.school_N ;
lin in_Adv = herein_Adv | hinein_Adv ; -- status=guess status=guess
lin in_1_Adv = variants{} ; -- 
lin in_2_Adv = variants{} ; -- 
lin small_A = L.small_A ;
lin place_N = bude_N ; -- status=guess
lin before_Prep = S.before_Prep ;
lin while_Subj = variants{} ; -- 
lin away_Adv = fort_Adv | weg_Adv ; -- status=guess status=guess
lin away_2_Adv = variants{} ; -- 
lin away_1_Adv = variants{} ; -- 
lin keep_VV = mkVV (junkV (mkV "im") "Auge behalten") | mkVV (aufpassen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin keep_V2A = mkV2A (junkV (mkV "im") "Auge behalten") | mkV2A (aufpassen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin keep_V2 = mkV2 (junkV (mkV "im") "Auge behalten") | mkV2 (aufpassen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin keep_V = junkV (mkV "im") "Auge behalten" | aufpassen_0_V ; -- status=guess, src=wikt status=guess, src=wikt
lin point_N = mkN "Komma" masculine ; -- status=guess
lin point_2_N = variants{} ; -- 
lin point_1_N = variants{} ; -- 
lin house_N = L.house_N ;
lin different_A = verschieden_A ; -- status=guess
lin country_N = L.country_N ;
lin really_Adv = mkAdv "wirklich" ; -- status=guess
lin provide_V2 = mkV2 (versehen_V) ; -- status=guess, src=wikt
lin provide_V = versehen_V ; -- status=guess, src=wikt
lin week_N = woche_N ; -- status=guess
lin hold_VS = mkVS (halten_5_V) | mkVS (mkReflV "halten in") ; -- status=guess, src=wikt status=guess, src=wikt
lin hold_V2 = L.hold_V2 ;
lin hold_V = halten_5_V | mkReflV "halten in" ; -- status=guess, src=wikt status=guess, src=wikt
lin large_A = mkA "groß" | weit_A ; -- status=guess status=guess
lin member_N = glied_N ; -- status=guess
lin off_Adv = weg_Adv | davon_Adv ; -- status=guess status=guess
lin always_Adv = immer_Adv | stets_Adv ; -- status=guess status=guess
lin follow_VS = mkVS (junkV (mkV "Farbe") "bekennen") ; -- status=guess, src=wikt
lin follow_V2 = mkV2 (junkV (mkV "Farbe") "bekennen") ; -- status=guess, src=wikt
lin follow_V = junkV (mkV "Farbe") "bekennen" ; -- status=guess, src=wikt
lin without_Prep = S.without_Prep ;
lin turn_VA = mkVA (junkV (mkV "ein") "Auge zudrücken") ; -- status=guess, src=wikt
lin turn_V2 = mkV2 (junkV (mkV "ein") "Auge zudrücken") ; -- status=guess, src=wikt
lin turn_V = L.turn_V ;
lin end_N = tod_N | ende_N ; -- status=guess status=guess
lin end_2_N = variants{} ; -- 
lin end_1_N = variants{} ; -- 
lin within_Prep = variants{} ; -- 
lin local_A = lokal_A | mkA "örtlich" ; -- status=guess status=guess
lin where_Subj = variants{} ; -- 
lin during_Prep = S.during_Prep ;
lin bring_V3 = mkV3 (junkV (mkV "zustande") "bringen") | mkV3 (bewerkstelligen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin bring_V2 = mkV2 (junkV (mkV "zustande") "bringen") | mkV2 (bewerkstelligen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin most_Det = M.detLikeAdj False M.Pl "meist" ;
lin word_N = mkN "Wort" "Wörter" neuter | mkN "Wort" "Worte" neuter ; ---- split
lin begin_V2 = mkV2 (anfangen_6_V) | mkV2 (beginnen_V) | mkV2 (starten_9_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin begin_V = anfangen_6_V | beginnen_V | starten_9_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin although_Subj = S.although_Subj ;
lin example_N = exempel_N ; -- status=guess
lin next_Adv = mkAdv "als nächstes" ; -- status=guess
lin family_N = mkN "Familienunternehmen" neuter ; -- status=guess
lin rather_Adv = eher_Adv | lieber_Adv ; -- status=guess status=guess
lin fact_N = tatsache_N | mkN "Fakt" masculine ; -- status=guess status=guess
lin like_VV = mkVV (mkV "mögen") | mkVV (junkV (mkV "gern") "haben") | mkVV (gefallen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin like_VS = mkVS (mkV "mögen") | mkVS (junkV (mkV "gern") "haben") | mkVS (gefallen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin like_V2 = L.like_V2 ;
lin social_A = mkA "kontaktfreudig" ; -- status=guess
lin write_VS = mkVS (abschreiben_V) ; -- status=guess, src=wikt
lin write_V2 = L.write_V2 ;
lin write_V = abschreiben_V ; -- status=guess, src=wikt
lin state_N = zustand_N ; -- status=guess
lin state_2_N = variants{} ; -- 
lin state_1_N = variants{} ; -- 
lin percent_N = prozent_N ; -- status=guess
lin quite_Adv = S.quite_Adv ;
lin both_Det = M.detLikeAdj False M.Pl "beid" ;
lin start_V2 = mkV2 (beginnen_V) ; -- status=guess, src=wikt
lin start_V = beginnen_V ; -- status=guess, src=wikt
lin run_V2 = mkV2 (junkV (mkV "auf") "Grund laufen") | mkV2 (junkV (mkV "auf") "Grund setzen") | mkV2 (junkV (mkV "auf") "Grund laufen lassen") | mkV2 (mkV "auflaufen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin run_V = L.run_V ;
lin long_A = L.long_A ;
lin right_Adv = mkAdv "ganz" ; -- status=guess
lin right_2_Adv = variants{} ; -- 
lin right_1_Adv = variants{} ; -- 
lin set_V2 = mkV2 (ausziehen_4_V) ; -- status=guess, src=wikt
lin help_V2V = mkV2V (helfen_V) ; -- status=guess, src=wikt
lin help_V2 = mkV2 (helfen_V) ; -- status=guess, src=wikt
lin help_V = helfen_V ; -- status=guess, src=wikt
lin every_Det = S.every_Det ;
lin home_N = mkN "Zuhause" neuter | mkN "Elternhaus" neuter | nest_N ; -- status=guess status=guess status=guess
lin month_N = monat_N ; -- status=guess
lin side_N = seite_N ; -- status=guess
lin night_N = L.night_N ;
lin important_A = L.important_A ;
lin eye_N = L.eye_N ;
lin head_N = L.head_N ;
lin information_N = information_N | auskunft_N ; -- status=guess status=guess
lin question_N = L.question_N ;
lin business_N = mkN "Business Analyst" masculine ; -- status=guess
lin play_V2 = L.play_V2 ;
lin play_V = L.play_V ;
lin play_3_V2 = variants{} ; -- 
lin play_3_V = variants{} ; -- 
lin play_2_V2 = variants{} ; -- 
lin play_2_V = variants{} ; -- 
lin play_1_V2 = variants{} ; -- 
lin play_1_V = variants{} ; -- 
lin power_N = stromausfall_N ; -- status=guess
lin money_N = mkN "Bargeld" neuter ; -- status=guess
lin change_N = mkN "Veränderungsmanagement" neuter ; -- status=guess
lin move_V2 = mkV2 (ausziehen_4_V) ; -- status=guess, src=wikt
lin move_V = ausziehen_4_V ; -- status=guess, src=wikt
lin move_2_V = variants{} ; -- 
lin move_1_V = variants{} ; -- 
lin interest_N = interesse_N ; -- status=guess
lin interest_4_N = variants{} ; -- 
lin interest_2_N = variants{} ; -- 
lin interest_1_N = variants{} ; -- 
lin order_N = ordnungszahl_N ; -- status=guess
lin book_N = L.book_N ;
lin often_Adv = mkAdv "häufig" | oft_Adv ; -- status=guess status=guess
lin development_N = entwicklung_N ; -- status=guess
lin young_A = L.young_A ;
lin national_A = national_A | mkA "Staats-" ; -- status=guess status=guess
lin pay_V3 = mkV3 (beachten_V) | mkV3 (achten_V) | mkV3 (mkV "achtgeben") | mkV3 (aufpassen_0_V) | mkV3 (junkV (mkV "Aufmerksamkeit") "schenken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pay_V2V = mkV2V (beachten_V) | mkV2V (achten_V) | mkV2V (mkV "achtgeben") | mkV2V (aufpassen_0_V) | mkV2V (junkV (mkV "Aufmerksamkeit") "schenken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pay_V2 = mkV2 (beachten_V) | mkV2 (achten_V) | mkV2 (mkV "achtgeben") | mkV2 (aufpassen_0_V) | mkV2 (junkV (mkV "Aufmerksamkeit") "schenken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pay_V = beachten_V | achten_V | mkV "achtgeben" | aufpassen_0_V | junkV (mkV "Aufmerksamkeit") "schenken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hear_VS = mkVS (mkV "hören") ; -- status=guess, src=wikt
lin hear_V2V = mkV2V (mkV "hören") ; -- status=guess, src=wikt
lin hear_V2 = L.hear_V2 ;
lin hear_V = mkV "hören" ; -- status=guess, src=wikt
lin room_N = raum_N | zimmer_N ; -- status=guess status=guess
lin room_1_N = variants{} ; -- 
lin room_2_N = variants{} ; -- 
lin whether_Subj = variants{} ; -- 
lin water_N = L.water_N ;
lin form_N = formular_N ; -- status=guess
lin car_N = L.car_N ;
lin other_N = mkN "andere" ; -- status=guess
lin yet_Adv = noch_mal_Adv ; -- status=guess
lin yet_2_Adv = variants{} ; -- 
lin yet_1_Adv = variants{} ; -- 
lin perhaps_Adv = vielleicht_Adv | wohl_Adv ; -- status=guess status=guess
lin meet_V2 = mkV2 (entsprechen_V) | mkV2 (mkV "gerechtwerden") | mkV2 (mkV "nachkommen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin meet_V = entsprechen_V | mkV "gerechtwerden" | mkV "nachkommen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin level_N = stufe_N ; -- status=guess
lin level_2_N = variants{} ; -- 
lin level_1_N = variants{} ; -- 
lin until_Subj = variants{} ; -- 
lin though_Subj = variants{} ; -- 
lin policy_N = mkN "Entscheidungsträger" ; -- status=guess
lin include_V2 = mkV2 (mkV "einfügen") | mkV2 (mkV "inkludieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin include_V = mkV "einfügen" | mkV "inkludieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin believe_VS = mkVS (glauben_V) ; -- status=guess, src=wikt
lin believe_V2 = mkV2 (glauben_V) ; -- status=guess, src=wikt
lin believe_V = glauben_V ; -- status=guess, src=wikt
lin council_N = rat_N ; -- status=guess
lin already_Adv = L.already_Adv ;
lin possible_A = mkA "möglich" ; -- status=guess
lin nothing_NP = S.nothing_NP ;
lin line_N = mkN "Leitungscode" masculine ; -- status=guess
lin allow_V2V = mkV2V (akzeptieren_V) ; -- status=guess, src=wikt
lin allow_V2 = mkV2 (akzeptieren_V) ; -- status=guess, src=wikt
lin need_N = notwendigkeit_N | bedarf_N | mkN "Bedürfnis" neuter ; -- status=guess status=guess status=guess
lin effect_N = auswirkung_N | wirkung_N ; -- status=guess status=guess
lin big_A = L.big_A ;
lin use_N = benutzung_N | anwendung_N | gebrauch_N ; -- status=guess status=guess status=guess
lin lead_V2V = mkV2V (mkV "irreführen") ; -- status=guess, src=wikt
lin lead_V2 = mkV2 (mkV "irreführen") ; -- status=guess, src=wikt
lin lead_V = mkV "irreführen" ; -- status=guess, src=wikt
lin stand_V2 = mkV2 (mkV "zurückbleiben") ; -- status=guess, src=wikt
lin stand_V = L.stand_V ;
lin idea_N = idee_N | ahnung_N ; -- status=guess status=guess
lin study_N = studie_N ; -- status=guess
lin lot_N = los_N ; -- status=guess
lin live_V = L.live_V ;
lin job_N = arbeitsamt_N | jobcenter__N | mkN "Arbeitsmarktservice" masculine ; -- status=guess status=guess status=guess
lin since_Subj = variants{} ; -- 
lin name_N = L.name_N ;
lin result_N = ergebnis_N | resultat_N ; -- status=guess status=guess
lin body_N = mkN "Körper" masculine ; -- status=guess
lin happen_VV = mkVV (geschehen_V) | mkVV (passieren_V) | mkVV (stattfinden_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin happen_V = geschehen_V | passieren_V | stattfinden_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin friend_N = L.friend_N ;
lin right_N = mkN "rechter Winkel" masculine ; -- status=guess
lin least_Adv = variants{} ; -- 
lin right_A = rechtwinklig_A ; -- status=guess
lin right_2_A = variants{} ; -- 
lin right_1_A = variants{} ; -- 
lin almost_Adv = fast_Adv | beinahe_Adv | so_lala_Adv ; -- status=guess status=guess status=guess
lin much_Det = S.much_Det ;
lin carry_V2 = mkV2 (junkV (mkV "Eulen") "nach Athen tragen") ; -- status=guess, src=wikt
lin carry_V = junkV (mkV "Eulen") "nach Athen tragen" ; -- status=guess, src=wikt
lin authority_N = mkN "Autorität" feminine ; -- status=guess
lin authority_2_N = variants{} ; -- 
lin authority_1_N = variants{} ; -- 
lin long_Adv = mkAdv "vor alter Zeit" | mkAdv "längst" ; -- status=guess status=guess
lin early_A = mkA "früh" | mkA "verfrüht" ; -- status=guess status=guess
lin view_N = sicht_N | mkN "View" feminine ; -- status=guess status=guess
lin view_2_N = variants{} ; -- 
lin view_1_N = variants{} ; -- 
lin public_A = mkA "öffentlich" ; -- status=guess
lin together_Adv = zusammen_Adv ; -- status=guess
lin talk_V2 = mkV2 (reden_9_V) | mkV2 (sprechen_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin talk_V = reden_9_V | sprechen_8_V ; -- status=guess, src=wikt status=guess, src=wikt
lin report_N = bericht_N | reportage_N | mitteilung_N | meldung_N ; -- status=guess status=guess status=guess status=guess
lin after_Subj = variants{} ; -- 
lin only_Predet = S.only_Predet ;
lin before_Subj = variants{} ; -- 
lin bit_N = bit_N ; -- status=guess
lin face_N = mkN "Gesicht" neuter | mkN "Gesichtsausdruck" masculine ; -- status=guess status=guess
lin sit_V2 = mkV2 (mkReflV "setzen") ; -- status=guess, src=wikt
lin sit_V = L.sit_V ;
lin market_N = warenkorb_N ; -- status=guess
lin market_1_N = variants{} ; -- 
lin market_2_N = variants{} ; -- 
lin appear_VV = mkVV (erscheinen_V) | mkVV (einleuchten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin appear_VS = mkVS (erscheinen_V) | mkVS (einleuchten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin appear_VA = mkVA (erscheinen_V) | mkVA (einleuchten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin appear_V = erscheinen_V | einleuchten_V ; -- status=guess, src=wikt status=guess, src=wikt
lin continue_VV = mkVV (mkV "weitermachen") | mkVV (fortfahren_5_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin continue_V2 = mkV2 (mkV "weitermachen") | mkV2 (fortfahren_5_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin continue_V = mkV "weitermachen" | fortfahren_5_V ; -- status=guess, src=wikt status=guess, src=wikt
lin able_A = kompetent_A ; -- status=guess
lin political_A = politisch_A ; -- status=guess
lin later_Adv = mkAdv "später" | nachher_Adv ; -- status=guess status=guess
lin hour_N = stundenzeiger_N ; -- status=guess
lin rate_N = mkN "Verhältnis" neuter ; -- status=guess
lin law_N = mkN "öffentliche Ordnung" feminine ; -- status=guess
lin law_2_N = variants{} ; -- 
lin law_1_N = variants{} ; -- 
lin door_N = L.door_N ;
lin court_N = hof_N | mkN "Hofstaat" masculine ; -- status=guess status=guess
lin court_2_N = variants{} ; -- 
lin court_1_N = variants{} ; -- 
lin office_N = amt_N ; -- status=guess
lin let_V2V = mkV2V (junkV (mkV "in") "Ruhe lassen") ; -- status=guess, src=wikt
lin war_N = L.war_N ;
lin produce_V2 = mkV2 (vorlegen_8_V) ; -- status=guess, src=wikt
lin produce_V = vorlegen_8_V ; -- status=guess, src=wikt
lin reason_N = L.reason_N ;
lin less_Adv = mkAdv "weniger" ; -- status=guess
lin minister_N = minister_N | ministerin_N ; -- status=guess status=guess
lin minister_2_N = variants{} ; -- 
lin minister_1_N = variants{} ; -- 
lin subject_N = untertan_N | mkN "Untertanin" feminine ; -- status=guess status=guess
lin subject_2_N = variants{} ; -- 
lin subject_1_N = variants{} ; -- 
lin person_N = L.person_N ;
lin term_N = klausel_N ; -- status=guess
lin particular_A = eigen_A | kleinlich_A ; -- status=guess status=guess
lin full_A = L.full_A ;
lin involve_VS = variants{} ; -- 
lin involve_V2 = variants{} ; -- 
lin involve_V = variants{} ; -- 
lin sort_N = mkN "sortieren v" ; -- status=guess
lin require_VS = mkVS (erfordern_V) ; -- status=guess, src=wikt
lin require_V2V = mkV2V (erfordern_V) ; -- status=guess, src=wikt
lin require_V2 = mkV2 (erfordern_V) ; -- status=guess, src=wikt
lin require_V = erfordern_V ; -- status=guess, src=wikt
lin suggest_VS = mkVS (vorschlagen_8_V) ; -- status=guess, src=wikt
lin suggest_V2 = mkV2 (vorschlagen_8_V) ; -- status=guess, src=wikt
lin suggest_V = vorschlagen_8_V ; -- status=guess, src=wikt
lin far_A = fern_A | weit_A | weit_A ; -- status=guess status=guess status=guess
lin towards_Prep = variants{} ; -- 
lin anything_NP = S.mkNP (mkPN "irgendwas") ;
lin period_N = epoche_N | zeitraum_N ; -- status=guess status=guess
lin period_3_N = variants{} ; -- 
lin period_2_N = variants{} ; -- 
lin period_1_N = variants{} ; -- 
lin consider_VV = mkVV (mkV "überlegen") ; -- status=guess, src=wikt
lin consider_VS = mkVS (mkV "überlegen") ; -- status=guess, src=wikt
lin consider_V3 = mkV3 (mkV "überlegen") ; -- status=guess, src=wikt
lin consider_V2V = mkV2V (mkV "überlegen") ; -- status=guess, src=wikt
lin consider_V2A = mkV2A (mkV "überlegen") ; -- status=guess, src=wikt
lin consider_V2 = mkV2 (mkV "überlegen") ; -- status=guess, src=wikt
lin consider_V = mkV "überlegen" ; -- status=guess, src=wikt
lin read_VS = mkVS (verstehen_V) ; -- status=guess, src=wikt
lin read_V2 = L.read_V2 ;
lin read_V = verstehen_V ; -- status=guess, src=wikt
lin change_V2 = mkV2 (junkV (mkV "seine") "Meinung ändern") | mkV2 (mkReflV "umentscheiden") ; -- status=guess, src=wikt status=guess, src=wikt
lin change_V = junkV (mkV "seine") "Meinung ändern" | mkReflV "umentscheiden" ; -- status=guess, src=wikt status=guess, src=wikt
lin society_N = gesellschaft_N ; -- status=guess
lin process_N = prozess_N ; -- status=guess
lin mother_N = mutter_N ; -- status=guess
lin offer_VV = mkVV (anbieten_V) ; -- status=guess, src=wikt
lin offer_V2 = mkV2 (anbieten_V) ; -- status=guess, src=wikt
lin late_A = mkA "spät" ; -- status=guess
lin voice_N = diathese_N | genus_verbi_N ; -- status=guess status=guess
lin both_Adv = variants{} ; -- 
lin once_Adv = noch_mal_Adv | wieder_Adv | nochmals_Adv | wiederum_Adv ; -- status=guess status=guess status=guess status=guess
lin police_N = polizei_N ; -- status=guess
lin kind_N = art_N ; -- status=guess
lin lose_V2 = L.lose_V2 ;
lin lose_V = verlieren_V ; -- status=guess, src=wikt
lin add_VS = mkVS (junkV (mkV "Öl") "ins Feuer gießen") ; -- status=guess, src=wikt
lin add_V2 = mkV2 (junkV (mkV "Öl") "ins Feuer gießen") ; -- status=guess, src=wikt
lin add_V = junkV (mkV "Öl") "ins Feuer gießen" ; -- status=guess, src=wikt
lin probably_Adv = mkAdv "wahrscheinlich" ; -- status=guess
lin expect_VV = mkVV (erwarten_V) ; -- status=guess, src=wikt
lin expect_VS = mkVS (erwarten_V) ; -- status=guess, src=wikt
lin expect_V2V = mkV2V (erwarten_V) ; -- status=guess, src=wikt
lin expect_V2 = mkV2 (erwarten_V) ; -- status=guess, src=wikt
lin expect_V = erwarten_V ; -- status=guess, src=wikt
lin ever_Adv = immer_Adv | stets_Adv ; -- status=guess status=guess
lin available_A = mkA "verfügbar" | disponibel_A ; -- status=guess status=guess
lin price_N = preis_N ; -- status=guess
lin little_A = wenig_A ; -- status=guess
lin action_N = mkN "Action" feminine ; -- status=guess
lin issue_N = variants{} ; -- 
lin issue_2_N = variants{} ; -- 
lin issue_1_N = variants{} ; -- 
lin far_Adv = L.far_Adv ;
lin remember_VS = mkVS (mkReflV "merken") ; -- status=guess, src=wikt
lin remember_V2 = mkV2 (mkReflV "merken") ; -- status=guess, src=wikt
lin remember_V = mkReflV "merken" ; -- status=guess, src=wikt
lin position_N = stellung_N | position_N ; -- status=guess status=guess
lin low_A = niedrig_A ; -- status=guess
lin cost_N = mkN "Kosten {p}" ; -- status=guess
lin little_Det = M.detLikeAdj False M.Sg "wenig" ;
lin matter_N = materie_N ; -- status=guess
lin matter_1_N = variants{} ; -- 
lin matter_2_N = variants{} ; -- 
lin community_N = gemeinschaft_N ; -- status=guess
lin remain_VV = mkVV (bleiben_6_V) ; -- status=guess, src=wikt
lin remain_VA = mkVA (bleiben_6_V) ; -- status=guess, src=wikt
lin remain_V2 = mkV2 (bleiben_6_V) ; -- status=guess, src=wikt
lin remain_V = bleiben_6_V ; -- status=guess, src=wikt
lin figure_N = abbildung_N ; -- status=guess
lin figure_2_N = variants{} ; -- 
lin figure_1_N = variants{} ; -- 
lin type_N = mkN "Typus" masculine ; -- status=guess
lin research_N = forschung_N ; -- status=guess
lin actually_Adv = mkAdv "eigentlich" ; -- status=guess
lin education_N = bildung_N | mkN "Schulung" feminine | mkN "Aufklärung" feminine ; -- status=guess status=guess status=guess
lin fall_V = mkV "zusammenbrechen" ; -- status=guess, src=wikt
lin speak_V2 = L.speak_V2 ;
lin speak_V = junkV (mkV "für") "sich selbst sprechen" ; -- status=guess, src=wikt
lin few_N = variants{} ; -- 
lin today_Adv = L.today_Adv ;
lin enough_Adv = genug_Adv ; -- status=guess
lin open_V2 = L.open_V2 ;
lin open_V = junkV (mkV "öffnete") "sich" ; -- status=guess, src=wikt
lin bad_A = L.bad_A ;
lin buy_V2 = L.buy_V2 ;
lin buy_V = abkaufen_V ; -- status=guess, src=wikt
lin programme_N = variants{} ; -- 
lin minute_N = minutenzeiger_N ; -- status=guess
lin moment_N = moment_N ; -- status=guess
lin girl_N = L.girl_N ;
lin age_N = generation_N ; -- status=guess
lin centre_N = variants{} ; -- 
lin stop_VV = mkVV (anhalten_3_V) | mkVV (stoppen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin stop_V2 = mkV2 (anhalten_3_V) | mkV2 (stoppen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin stop_V = L.stop_V ;
lin control_N = mkN "Querlenker" masculine ; -- status=guess
lin value_N = mehrwertsteuer_N ; -- status=guess
lin send_V2V = mkV2V (senden_1_V) | mkV2V (schicken_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin send_V2 = mkV2 (senden_1_V) | mkV2 (schicken_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin send_V = senden_1_V | schicken_0_V ; -- status=guess, src=wikt status=guess, src=wikt
lin health_N = mkN "Gesundheitsfürsorge" feminine | mkN "Gesundheitswesen" neuter | mkN "medizinische Versorgung" feminine ; -- status=guess status=guess status=guess
lin decide_VV = mkVV (entscheiden_V) | mkVV (mkV "beschließen") | mkVV (festsetzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin decide_VS = mkVS (entscheiden_V) | mkVS (mkV "beschließen") | mkVS (festsetzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin decide_V2 = mkV2 (entscheiden_V) | mkV2 (mkV "beschließen") | mkV2 (festsetzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin decide_V = entscheiden_V | mkV "beschließen" | festsetzen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin main_A = mkA "Haupt-" | mkA "hauptsächlich" ; -- status=guess status=guess
lin win_V2 = L.win_V2 ;
lin win_V = siegen_V | gewinnen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin understand_VS = mkVS (verstehen_V) | mkVS (begreifen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin understand_V2 = L.understand_V2 ;
lin understand_V = verstehen_V | begreifen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin decision_N = entscheidung_N | beschluss_N ; -- status=guess status=guess
lin develop_V2 = mkV2 (entwickeln_V) ; -- status=guess, src=wikt
lin develop_V = entwickeln_V ; -- status=guess, src=wikt
lin class_N = mkN "Sammelklage" feminine ; -- status=guess
lin industry_N = L.industry_N ;
lin receive_V2 = mkV2 (bekommen_8_V) | mkV2 (erhalten_V) | mkV2 (empfangen_V) | mkV2 (kriegen_6_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin receive_V = bekommen_8_V | erhalten_V | empfangen_V | kriegen_6_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin back_N = L.back_N ;
lin several_Det = M.detLikeAdj False M.Pl "mehrer" ;
lin return_V2 = mkV2 (mkV "zurückkehren") | mkV2 (mkV "zurückkommen") ; -- status=guess, src=wikt status=guess, src=wikt
lin return_V = mkV "zurückkehren" | mkV "zurückkommen" ; -- status=guess, src=wikt status=guess, src=wikt
lin build_V2 = mkV2 (bauen_0_V) ; -- status=guess, src=wikt
lin build_V = bauen_0_V ; -- status=guess, src=wikt
lin spend_V2 = mkV2 (verbringen_V) ; -- status=guess, src=wikt
lin spend_V = verbringen_V ; -- status=guess, src=wikt
lin force_N = kraft_N ; -- status=guess
lin condition_N = verfassung_N | kondition_N | mkN "Befinden" neuter | zustand_N ; -- status=guess status=guess status=guess status=guess
lin condition_1_N = variants{} ; -- 
lin condition_2_N = variants{} ; -- 
lin paper_N = L.paper_N ;
lin off_Prep = variants{} ; -- 
lin major_A = mkA "dur" ; -- status=guess
lin describe_VS = mkVS (beschreiben_V) ; -- status=guess, src=wikt
lin describe_V2 = mkV2 (beschreiben_V) ; -- status=guess, src=wikt
lin agree_VV = mkVV (mkV "kongruieren") ; -- status=guess, src=wikt
lin agree_VS = mkVS (mkV "kongruieren") ; -- status=guess, src=wikt
lin agree_V = mkV "kongruieren" ; -- status=guess, src=wikt
lin economic_A = mkA "ökonomisch" ; -- status=guess
lin increase_V2 = mkV2 (mkV "-wachsen") | mkV2 (mkReflV "vergrößern") | mkV2 (steigern_V) | mkV2 (mkV "erhöhen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin increase_V = mkV "-wachsen" | mkReflV "vergrößern" | steigern_V | mkV "erhöhen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin upon_Prep = variants{} ; -- 
lin learn_VV = mkVV (lernen_4_V) ; -- status=guess, src=wikt
lin learn_VS = mkVS (lernen_4_V) ; -- status=guess, src=wikt
lin learn_V2 = L.learn_V2 ;
lin learn_V = lernen_4_V ; -- status=guess, src=wikt
lin general_A = allgemein_A | generell_A ; -- status=guess status=guess
lin century_N = mkN "Zenturie" feminine ; -- status=guess
lin therefore_Adv = deswegen_Adv | deshalb_Adv | darum_Adv ; -- status=guess status=guess status=guess
lin father_N = vater_N ; -- status=guess
lin section_N = abschnitt_N | teil_N | mkN "Stück" neuter ; -- status=guess status=guess status=guess
lin patient_N = patient_N ; -- status=guess
lin around_Adv = mkAdv "rund um die Uhr" ; -- status=guess
lin activity_N = mkN "Aktivität" feminine | mkN "Tätigkeit" feminine ; -- status=guess status=guess
lin road_N = L.road_N ;
lin table_N = L.table_N ;
lin including_Prep = variants{} ; -- 
lin church_N = L.church_N ;
lin reach_V2 = mkV2 (erreichen_V) ; -- status=guess, src=wikt
lin reach_V = erreichen_V ; -- status=guess, src=wikt
lin real_A = mkA "Immobilien-" ; -- status=guess
lin lie_VS = mkVS (liegen_3_V) ; -- status=guess, src=wikt
lin lie_2_V = variants{} ; -- 
lin lie_1_V = variants{} ; -- 
lin mind_N = mkN "Verstand" masculine | mkN "Geist" masculine ; -- status=guess status=guess
lin likely_A = wahrscheinlich_A | glaubhaft_A | plausibel_A ; -- status=guess status=guess status=guess
lin among_Prep = variants{} ; -- 
lin team_N = mannschaft_N | team_N ; -- status=guess status=guess
lin experience_N = praxis_N | erlebnis_N | erfahrung_N ; -- status=guess status=guess status=guess
lin death_N = der_nbspdamenfluegel_N ; -- status=guess
lin soon_Adv = bald_Adv ; -- status=guess
lin act_N = handlung_N | tat_N | akt_N ; -- status=guess status=guess status=guess
lin sense_N = mkN "Gefühl" neuter | sinn_N ; -- status=guess status=guess
lin staff_N = belegschaft_N | personal_computer_N | stab_N ; -- status=guess status=guess status=guess
lin staff_2_N = variants{} ; -- 
lin staff_1_N = variants{} ; -- 
lin certain_A = sicher_A ; -- status=guess
lin certain_2_A = variants{} ; -- 
lin certain_1_A = variants{} ; -- 
lin studentMasc_N = L.student_N ;
lin half_Predet = variants{} ; -- 
lin half_Predet = variants{} ; -- 
lin around_Prep = variants{} ; -- 
lin language_N = L.language_N ;
lin walk_V2 = mkV2 (mkV "wegkommen") ; -- status=guess, src=wikt
lin walk_V = L.walk_V ;
lin die_V = L.die_V ;
lin special_A = speziell_A | mkA "Spezial-" | mkA "ungewöhnlich" | mkA "Sonder-" | mkA "besondere" ; -- status=guess status=guess status=guess status=guess status=guess
lin difficult_A = schwer_A | schwierig_A ; -- status=guess status=guess
lin international_A = international_A ; -- status=guess
lin particularly_Adv = variants{} ; -- 
lin department_N = abteilung_N ; -- status=guess
lin management_N = verwaltung_N | mkN "Führung" feminine | mkN "Handhabung" feminine | leitung_N | regie_N | management_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin morning_N = morgengabe_N ; -- status=guess
lin draw_V2 = mkV2 (junkV (mkV "Aufmerksamkeit") "anziehen") ; -- status=guess, src=wikt
lin draw_1_V2 = variants{} ; -- 
lin draw_2_V2 = variants{} ; -- 
lin draw_V = junkV (mkV "Aufmerksamkeit") "anziehen" ; -- status=guess, src=wikt
lin hope_VV = mkVV (hoffen_V) ; -- status=guess, src=wikt
lin hope_VS = L.hope_VS ;
lin hope_V = hoffen_V ; -- status=guess, src=wikt
lin across_Prep = variants{} ; -- 
lin plan_N = plan_N ; -- status=guess
lin product_N = produkt_N ; -- status=guess
lin city_N = L.city_N ;
lin early_Adv = mkAdv "früh" ; -- status=guess
lin committee_N = komitee_N | mkN "Ausschuß" masculine ; -- status=guess status=guess
lin ground_N = hintergrund_N ; -- status=guess
lin ground_2_N = variants{} ; -- 
lin ground_1_N = variants{} ; -- 
lin letter_N = briefbombe_N ; -- status=guess
lin letter_2_N = variants{} ; -- 
lin letter_1_N = variants{} ; -- 
lin create_V2 = mkV2 (entwerfen_V) ; -- status=guess, src=wikt
lin create_V = entwerfen_V ; -- status=guess, src=wikt
lin evidence_N = mkN "Beweismittel" feminine | indiz_N ; -- status=guess status=guess
lin evidence_2_N = variants{} ; -- 
lin evidence_1_N = variants{} ; -- 
lin foot_N = L.foot_N ;
lin clear_A = klar_A | hell_A ; -- status=guess status=guess
lin boy_N = L.boy_N ;
lin game_N = spiel_N ; -- status=guess
lin game_3_N = variants{} ; -- 
lin game_2_N = variants{} ; -- 
lin game_1_N = variants{} ; -- 
lin food_N = nahrung_N | essen_N | lebensmittel_N ; -- status=guess status=guess status=guess
lin role_N = rolle_N ; -- status=guess
lin role_2_N = variants{} ; -- 
lin role_1_N = variants{} ; -- 
lin practice_N = praxis_N ; -- status=guess
lin bank_N = L.bank_N ;
lin else_Adv = mkAdv "else" | sonst_Adv ; -- status=guess status=guess
lin support_N = mkN "Unterstützung" feminine ; -- status=guess
lin sell_V2 = mkV2 (verkaufen_V) ; -- status=guess, src=wikt
lin sell_V = verkaufen_V ; -- status=guess, src=wikt
lin event_N = ereignis_N ; -- status=guess
lin building_N = mkN "Bau" masculine | mkN "Bauen" neuter ; -- status=guess status=guess
lin range_N = reichweite_N ; -- status=guess
lin behind_Prep = S.behind_Prep ;
lin sure_A = sicher_A ; -- status=guess
lin report_VS = mkVS (mkReflV "melden") ; -- status=guess, src=wikt
lin report_V2 = mkV2 (mkReflV "melden") ; -- status=guess, src=wikt
lin report_V = mkReflV "melden" ; -- status=guess, src=wikt
lin pass_V = sterben_2_V ; -- status=guess, src=wikt
lin black_A = L.black_A ;
lin stage_N = postkutsche_N ; -- status=guess
lin meeting_N = treffen_N ; -- status=guess
lin meeting_N = treffen_N ; -- status=guess
lin sometimes_Adv = manchmal_Adv ; -- status=guess
lin thus_Adv = also_Adv | mkAdv "demnach" ; -- status=guess status=guess
lin accept_VS = mkVS (akzeptieren_V) | mkVS (annehmen_4_V) | mkVS (zusagen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accept_V2 = mkV2 (akzeptieren_V) | mkV2 (annehmen_4_V) | mkV2 (zusagen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accept_V = akzeptieren_V | annehmen_4_V | zusagen_9_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin town_N = stadt_N | ort_N | mkN "Städtchen" neuter | gemeinde_N ; -- status=guess status=guess status=guess status=guess
lin art_N = L.art_N ;
lin further_Adv = mkAdv "weitere" | mkAdv "des Weiteren" | ferner_Adv ; -- status=guess status=guess status=guess
lin club_N = klub_N | verein_N ; -- status=guess status=guess
lin club_2_N = variants{} ; -- 
lin club_1_N = variants{} ; -- 
lin cause_V2V = mkV2V (verursachen_V) | mkV2V (mkV "auslösen") ; -- status=guess, src=wikt status=guess, src=wikt
lin cause_V2 = mkV2 (verursachen_V) | mkV2 (mkV "auslösen") ; -- status=guess, src=wikt status=guess, src=wikt
lin arm_N = ein_euro_job_N | kopf_N ; -- status=guess status=guess
lin arm_1_N = variants{} ; -- 
lin arm_2_N = variants{} ; -- 
lin history_N = geschichte_N ; -- status=guess
lin parent_N = mkN "Stammhaus" neuter | mkN "Mutterfirma" feminine ; -- status=guess status=guess
lin land_N = mkN "Land" neuter | mkN "Länder {p}" ; -- status=guess status=guess
lin trade_N = mkN "Handel" masculine | mkN "Kommerz" feminine ; -- status=guess status=guess
lin watch_VS = mkVS (aufpassen_0_V) ; -- status=guess, src=wikt
lin watch_V2V = mkV2V (aufpassen_0_V) ; -- status=guess, src=wikt
lin watch_V2 = L.watch_V2 ;
lin watch_1_V2 = variants{} ; -- 
lin watch_2_V2 = variants{} ; -- 
lin watch_V = aufpassen_0_V ; -- status=guess, src=wikt
lin white_A = L.white_A ;
lin situation_N = mkN "Situationskomik" feminine ; -- status=guess
lin ago_Adv = mkAdv "vor" ; -- status=guess
lin teacherMasc_N = L.teacher_N ;
lin record_N = mkN "Hitparade" ; -- status=guess
lin record_3_N = variants{} ; -- 
lin record_2_N = variants{} ; -- 
lin record_1_N = variants{} ; -- 
lin manager_N = direktor_N | manager_N ; -- status=guess status=guess
lin relation_N = relation_N ; -- status=guess
lin common_A = mkA "häufig" | mkA "nicht ungewöhnlich" | mkA "gewöhnlich" ; -- status=guess status=guess status=guess
lin common_2_A = variants{} ; -- 
lin common_1_A = variants{} ; -- 
lin strong_A = stark_A ; -- status=guess
lin whole_A = ganz_A ; -- status=guess
lin field_N = feld_N | gebiet_N | bereich_N ; -- status=guess status=guess status=guess
lin field_4_N = variants{} ; -- 
lin field_3_N = variants{} ; -- 
lin field_2_N = variants{} ; -- 
lin field_1_N = variants{} ; -- 
lin free_A = frei_A | ungebunden_A ; -- status=guess status=guess
lin break_V2 = L.break_V2 ;
lin break_V = junkV (mkV "ein") "Gesetz brechen" ; -- status=guess, src=wikt
lin yesterday_Adv = gestern_Adv ; -- status=guess
lin support_V2 = mkV2 (mkV "unterstützen") ; -- status=guess, src=wikt
lin window_N = L.window_N ;
lin account_N = konto_N ; -- status=guess
lin explain_VS = mkVS (mkV "erklären") ; -- status=guess, src=wikt
lin explain_V2 = mkV2 (mkV "erklären") ; -- status=guess, src=wikt
lin stay_VA = mkVA (bleiben_6_V) ; -- status=guess, src=wikt
lin stay_V = bleiben_6_V ; -- status=guess, src=wikt
lin few_Det = S.few_Det ;
lin wait_VV = mkVV (warten_8_V) ; -- status=guess, src=wikt
lin wait_V2 = L.wait_V2 ;
lin wait_V = warten_8_V ; -- status=guess, src=wikt
lin usually_Adv = mkAdv "gewöhnlich" ; -- status=guess
lin difference_N = differenz_N ; -- status=guess
lin material_N = stoff_N ; -- status=guess
lin air_N = mkN "Sanitätsflugzeug" neuter ; -- status=guess
lin wife_N = L.wife_N ;
lin cover_V2 = mkV2 (decken_2_V) | mkV2 (mkV "bespringen") | mkV2 (besteigen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin apply_VV = mkVV (anwenden_V) | mkVV (verwenden_V) | mkVV (benutzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin apply_V2V = mkV2V (anwenden_V) | mkV2V (verwenden_V) | mkV2V (benutzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin apply_V2 = mkV2 (anwenden_V) | mkV2 (verwenden_V) | mkV2 (benutzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin apply_1_V2 = variants{} ; -- 
lin apply_2_V2 = variants{} ; -- 
lin apply_V = anwenden_V | verwenden_V | benutzen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin project_N = projekt_N ; -- status=guess
lin raise_V2 = mkV2 (heben_5_V) ; -- status=guess, src=wikt
lin sale_N = auktion_N ; -- status=guess
lin relationship_N = beziehung_N | verwandtschaft_N ; -- status=guess status=guess
lin indeed_Adv = in_petto_Adv ; -- status=guess
lin light_N = mkN "Glühbirne" feminine | mkN "Glühlampe" feminine ; -- status=guess status=guess
lin claim_VS = mkVS (beanspruchen_V) ; -- status=guess, src=wikt
lin claim_V2 = mkV2 (beanspruchen_V) ; -- status=guess, src=wikt
lin claim_V = beanspruchen_V ; -- status=guess, src=wikt
lin form_V2 = mkV2 (formen_8_V) | mkV2 (bilden_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin form_V = formen_8_V | bilden_6_V ; -- status=guess, src=wikt status=guess, src=wikt
lin base_V2 = mkV2 (basieren_V) ; -- status=guess, src=wikt
lin base_V = basieren_V ; -- status=guess, src=wikt
lin care_N = sorge_N ; -- status=guess
lin someone_NP = S.somebody_NP ;
lin everything_NP = S.everything_NP ;
lin certainly_Adv = mkAdv "sicher" | mkAdv "natürlich" ; -- status=guess status=guess
lin rule_N = L.rule_N ;
lin home_Adv = daheim_Adv | zu_viel_Adv | zuhause_Adv ; -- status=guess status=guess status=guess
lin cut_V2 = L.cut_V2 ;
lin cut_V = junkV (mkV "ausschneiden") "und einfügen" ; -- status=guess, src=wikt
lin grow_VA = mkVA (erwachsen_V) | mkVA (aufwachsen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin grow_V2 = mkV2 (erwachsen_V) | mkV2 (aufwachsen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin grow_V = erwachsen_V | aufwachsen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin similar_A = mkA "ähnlich" | vergleichbar_A ; -- status=guess status=guess
lin story_N = mkN "Erzählung" feminine | geschichte_N ; -- status=guess status=guess
lin quality_N = mkN "Qualität" feminine | eigenschaft_N ; -- status=guess status=guess
lin tax_N = steuer_N ; -- status=guess
lin worker_N = arbeiterin_N ; -- status=guess
lin nature_N = natur_N ; -- status=guess
lin structure_N = struktur_N ; -- status=guess
lin data_N = mkN "Rechenzentrum" neuter ; -- status=guess
lin necessary_A = mkA "nötig" | notwendig_A ; -- status=guess status=guess
lin pound_N = verwahrstelle_N ; -- status=guess
lin method_N = art_N | methode_N ; -- status=guess status=guess
lin unit_N = einheit_N ; -- status=guess
lin unit_6_N = variants{} ; -- 
lin unit_5_N = variants{} ; -- 
lin unit_4_N = variants{} ; -- 
lin unit_3_N = variants{} ; -- 
lin unit_2_N = variants{} ; -- 
lin unit_1_N = variants{} ; -- 
lin central_A = zentral_A | mkA "mittig" ; -- status=guess status=guess
lin bed_N = bank_N ; -- status=guess
lin union_N = vereinigung_N | vereinigungsmenge_N ; -- status=guess status=guess
lin movement_N = bewegung_N ; -- status=guess
lin board_N = mkN "Kost und Logis" ; -- status=guess
lin board_2_N = variants{} ; -- 
lin board_1_N = variants{} ; -- 
lin true_A = wahr_A ; -- status=guess
lin well_Interj = mkInterj "gut gemacht" ; -- status=guess
lin simply_Adv = mkAdv "einfach" ; -- status=guess
lin contain_V2 = mkV2 (enthalten_V) ; -- status=guess, src=wikt
lin especially_Adv = besonders_Adv ; -- status=guess
lin open_A = mkA "offenkettig" ; -- status=guess
lin short_A = L.short_A ;
lin personal_A = mkA "persönlich" ; -- status=guess
lin detail_N = detail_N ; -- status=guess
lin model_N = model_N | modell_N ; -- status=guess status=guess
lin bear_V2 = mkV2 (tragen_7_V) ; -- status=guess, src=wikt
lin bear_V = tragen_7_V ; -- status=guess, src=wikt
lin single_A = einkettig_A ; -- status=guess
lin single_2_A = variants{} ; -- 
lin single_1_A = variants{} ; -- 
lin join_V2 = mkV2 (beitreten_2_V) ; -- status=guess, src=wikt
lin join_V = beitreten_2_V ; -- status=guess, src=wikt
lin reduce_V2 = mkV2 (reduzieren_V) | mkV2 (herabsetzen_1_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin reduce_V = reduzieren_V | herabsetzen_1_V ; -- status=guess, src=wikt status=guess, src=wikt
lin establish_V2 = mkV2 (einsetzen_V) ; -- status=guess, src=wikt
lin wall_N = mkN "Mauerfuchs" masculine ; -- status=guess
lin face_V2 = mkV2 (stellen_4_V) ; -- status=guess, src=wikt
lin face_V = stellen_4_V ; -- status=guess, src=wikt
lin easy_A = leicht_A | einfach_A ; -- status=guess status=guess
lin private_A = privat_A ; -- status=guess
lin computer_N = L.computer_N ;
lin hospital_N = krankenhaus_N ; -- status=guess
lin chapter_N = verband_N | mkN "Ortsverband" masculine | sektion_N ; -- status=guess status=guess status=guess
lin scheme_N = schema_modell_N ; -- status=guess
lin theory_N = theorie_N ; -- status=guess
lin choose_VV = mkVV (entscheiden_V) ; -- status=guess, src=wikt
lin choose_V2 = mkV2 (entscheiden_V) ; -- status=guess, src=wikt
lin wish_VV = mkVV (mkV "wünschen") ; -- status=guess, src=wikt
lin wish_VS = mkVS (mkV "wünschen") ; -- status=guess, src=wikt
lin wish_V2V = mkV2V (mkV "wünschen") ; -- status=guess, src=wikt
lin wish_V2 = mkV2 (mkV "wünschen") ; -- status=guess, src=wikt
lin wish_V = mkV "wünschen" ; -- status=guess, src=wikt
lin property_N = eigenschaft_N ; -- status=guess
lin property_2_N = variants{} ; -- 
lin property_1_N = variants{} ; -- 
lin achieve_V2 = mkV2 (erreichen_V) | mkV2 (realisieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin financial_A = finanziell_A ; -- status=guess
lin poor_A = arm_A ; -- status=guess
lin poor_3_A = variants{} ; -- 
lin poor_2_A = variants{} ; -- 
lin poor_1_A = variants{} ; -- 
lin officer_N = offizier_N ; -- status=guess
lin officer_3_N = variants{} ; -- 
lin officer_2_N = variants{} ; -- 
lin officer_1_N = variants{} ; -- 
lin up_Prep = variants{} ; -- 
lin charge_N = entgelt_N ; -- status=guess
lin charge_2_N = variants{} ; -- 
lin charge_1_N = variants{} ; -- 
lin director_N = direktor_N | mkN "Direktorin" feminine | regisseur_N | mkN "Regisseurin" feminine ; -- status=guess status=guess status=guess status=guess
lin drive_V2V = mkV2V (wegfahren_1_V) ; -- status=guess, src=wikt
lin drive_V2 = mkV2 (wegfahren_1_V) ; -- status=guess, src=wikt
lin drive_V = wegfahren_1_V ; -- status=guess, src=wikt
lin deal_V2 = mkV2 (mkV "austeilen") | mkV2 (erteilen_V) | mkV2 (mkV "zuteilen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin deal_V = mkV "austeilen" | erteilen_V | mkV "zuteilen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin place_V2 = mkV2 (stellen_4_V) | mkV2 (plazieren_V) | mkV2 (einordnen_8_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin approach_N = mkN "Annäherung" ; -- status=guess
lin chance_N = gelegenheit_N | mkN "Möglichkeit" feminine | chance_N ; -- status=guess status=guess status=guess
lin application_N = anwendung_N ; -- status=guess
lin seek_VV = mkVV (suchen_V) ; -- status=guess, src=wikt
lin seek_V2 = L.seek_V2 ;
lin foreign_A = fremd_A ; -- status=guess
lin foreign_2_A = variants{} ; -- 
lin foreign_1_A = variants{} ; -- 
lin along_Prep = variants{} ; -- 
lin top_N = kreisel__N ; -- status=guess
lin amount_N = menge_N ; -- status=guess
lin son_N = sohn_N ; -- status=guess
lin operation_N = betrieb_N ; -- status=guess
lin fail_VV = mkVV (scheitern_V) ; -- status=guess, src=wikt
lin fail_V2 = mkV2 (scheitern_V) ; -- status=guess, src=wikt
lin fail_V = scheitern_V ; -- status=guess, src=wikt
lin human_A = menschlich_A ; -- status=guess
lin opportunity_N = gelegenheit_N ; -- status=guess
lin simple_A = einfach_A ; -- status=guess
lin leader_N = mkN "Leittier" neuter ; -- status=guess
lin look_N = blick_N ; -- status=guess
lin share_N = aktie_N ; -- status=guess
lin production_N = produktion_N ; -- status=guess
lin recent_A = mkA "jüngst" | neu_A ; -- status=guess status=guess
lin firm_N = firma_N ; -- status=guess
lin picture_N = bilderbuch_N ; -- status=guess
lin source_N = quelltext_N | mkN "Kode" masculine | quellcode_N ; -- status=guess status=guess status=guess
lin security_N = sicherheit_N ; -- status=guess
lin serve_V2 = mkV2 (junkV (mkV "jemandem") "recht geschehen") ; -- status=guess, src=wikt
lin serve_V = junkV (mkV "jemandem") "recht geschehen" ; -- status=guess, src=wikt
lin according_to_Prep = variants{} ; -- 
lin end_V2 = mkV2 (enden_V) ; -- status=guess, src=wikt
lin end_V = enden_V ; -- status=guess, src=wikt
lin contract_N = vertrag_N ; -- status=guess
lin wide_A = L.wide_A ;
lin occur_V = einfallen_5_V | junkV (mkV "in") "den Sinn kommen" ; -- status=guess, src=wikt status=guess, src=wikt
lin agreement_N = vereinbarung_N | zustimmung_N ; -- status=guess status=guess
lin better_Adv = mkAdv "besser spät als nie" ; -- status=guess
lin kill_V2 = L.kill_V2 ;
lin kill_V = mkV "töten" | umbringen_0_V | ermorden_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin act_V2 = mkV2 (mkReflV "seinem Alter entsprechend benehmen") ; -- status=guess, src=wikt
lin act_V = mkReflV "seinem Alter entsprechend benehmen" ; -- status=guess, src=wikt
lin site_N = webseite_N | website_N | mkN "Webpräsenz" feminine ; -- status=guess status=guess status=guess
lin either_Adv = auch_Adv ; -- status=guess
lin labour_N = arbeitskraft_N ; -- status=guess
lin plan_VV = mkVV (planen_V) ; -- status=guess, src=wikt
lin plan_VS = mkVS (planen_V) ; -- status=guess, src=wikt
lin plan_V2V = mkV2V (planen_V) ; -- status=guess, src=wikt
lin plan_V2 = mkV2 (planen_V) ; -- status=guess, src=wikt
lin plan_V = planen_V ; -- status=guess, src=wikt
lin various_A = mkA "verschiedene" ; -- status=guess
lin since_Prep = variants{} ; -- 
lin test_N = mkN "Examen" neuter | mkN "Prüfung" feminine ; -- status=guess status=guess
lin eat_V2 = L.eat_V2 ;
lin eat_V = essen_4_V | fressen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin loss_N = verlust_N ; -- status=guess
lin close_V2 = L.close_V2 ;
lin close_V = mkV "schließen" | zumachen_0_V ; -- status=guess, src=wikt status=guess, src=wikt
lin represent_V2 = mkV2 (darstellen_V) | mkV2 (mkV "repräsentieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin represent_V = darstellen_V | mkV "repräsentieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin love_VV = mkVV (lieben_V) ; -- status=guess, src=wikt
lin love_V2 = L.love_V2 ;
lin colour_N = farbstabilisator_N ; -- status=guess
lin clearly_Adv = variants{} ; -- 
lin shop_N = L.shop_N ;
lin benefit_N = vorteil_N ; -- status=guess
lin animal_N = L.animal_N ;
lin heart_N = L.heart_N ;
lin election_N = wahl_N ; -- status=guess
lin purpose_N = intention_N | absicht_N ; -- status=guess status=guess
lin standard_N = banner_N | standarte_N ; -- status=guess status=guess
lin due_A = mkA "fällig" ; -- status=guess
lin secretary_N = mkN "Sekretär" masculine ; -- status=guess
lin rise_V2 = mkV2 (steigen_1_V) | mkV2 (aufsteigen_3_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin rise_V = steigen_1_V | aufsteigen_3_V ; -- status=guess, src=wikt status=guess, src=wikt
lin date_N = ende_N ; -- status=guess
lin date_7_N = variants{} ; -- 
lin date_3_N = variants{} ; -- 
lin date_3_N = variants{} ; -- 
lin date_1_N = variants{} ; -- 
lin hard_A = mkA "hartgekocht" ; -- status=guess
lin hard_2_A = variants{} ; -- 
lin hard_1_A = variants{} ; -- 
lin music_N = L.music_N ;
lin hair_N = L.hair_N ;
lin prepare_VV = mkVV (vorbereiten_7_V) ; -- status=guess, src=wikt
lin prepare_V2V = mkV2V (vorbereiten_7_V) ; -- status=guess, src=wikt
lin prepare_V2 = mkV2 (vorbereiten_7_V) ; -- status=guess, src=wikt
lin prepare_V = vorbereiten_7_V ; -- status=guess, src=wikt
lin factor_N = faktor_N ; -- status=guess
lin other_A = mkA "ander" ;
lin anyone_NP = variants{} ; -- 
lin pattern_N = mkN "Mustersprache" feminine ; -- status=guess
lin manage_VV = mkVV (schaffen_5_V) ; -- status=guess, src=wikt
lin manage_V2 = mkV2 (schaffen_5_V) ; -- status=guess, src=wikt
lin manage_V = schaffen_5_V ; -- status=guess, src=wikt
lin piece_N = kinderspiel_N ; -- status=guess
lin discuss_VS = mkVS (diskutieren_V) | mkVS (besprechen_V) | mkVS (mkV "erörtern") | mkVS (debattieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin discuss_V2 = mkV2 (diskutieren_V) | mkV2 (besprechen_V) | mkV2 (mkV "erörtern") | mkV2 (debattieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prove_VS = mkVS (beweisen_V) | mkVS (mkV "prüfen") ; -- status=guess, src=wikt status=guess, src=wikt
lin prove_VA = mkVA (beweisen_V) | mkVA (mkV "prüfen") ; -- status=guess, src=wikt status=guess, src=wikt
lin prove_V2 = mkV2 (beweisen_V) | mkV2 (mkV "prüfen") ; -- status=guess, src=wikt status=guess, src=wikt
lin prove_V = beweisen_V | mkV "prüfen" ; -- status=guess, src=wikt status=guess, src=wikt
lin front_N = front_N ; -- status=guess
lin evening_N = abend_N ; -- status=guess
lin royal_A = mkA "königlich" ; -- status=guess
lin tree_N = L.tree_N ;
lin population_N = mkN "Bevölkerung" feminine ; -- status=guess
lin fine_A = gut_A | mkA "akzeptable" | passabel_A | mkA "genügend" ; -- status=guess status=guess status=guess status=guess
lin plant_N = pflanze_N ; -- status=guess
lin pressure_N = dampfkochtopf_N | schnellkochtopf_N ; -- status=guess status=guess
lin response_N = antwort_N ; -- status=guess
lin catch_V2 = mkV2 (mkV "antrinken") | mkV2 (mkV "ansaufen") ; -- status=guess, src=wikt status=guess, src=wikt
lin street_N = mkN "Straße" feminine ; -- status=guess
lin pick_V2 = mkV2 (mkV "pflücken") ; -- status=guess, src=wikt
lin pick_V = mkV "pflücken" ; -- status=guess, src=wikt
lin performance_N = leistung_N | mkN "Arbeitsleistung" feminine ; -- status=guess status=guess
lin performance_2_N = variants{} ; -- 
lin performance_1_N = variants{} ; -- 
lin knowledge_N = mkN "Wissen" neuter | kenntnis_N ; -- status=guess status=guess
lin despite_Prep = variants{} ; -- 
lin design_N = entwurf_N ; -- status=guess
lin page_N = seite_N ; -- status=guess
lin enjoy_VV = mkVV (mkV "genießen") ; -- status=guess, src=wikt
lin enjoy_V2 = mkV2 (mkV "genießen") ; -- status=guess, src=wikt
lin individual_N = individuum_N ; -- status=guess
lin suppose_VS = mkVS (annehmen_4_V) ; -- status=guess, src=wikt
lin suppose_V2 = mkV2 (annehmen_4_V) ; -- status=guess, src=wikt
lin rest_N = mkN "Autobahnraststätte" feminine | rasthof_N ; -- status=guess status=guess
lin instead_Adv = mkAdv "anstatt" | statt_Adv ; -- status=guess status=guess
lin wear_V2 = mkV2 (mkV "verschleißen") ; -- status=guess, src=wikt
lin wear_V = mkV "verschleißen" ; -- status=guess, src=wikt
lin basis_N = basis_N ; -- status=guess
lin size_N = mkN "Größe" feminine | mkN "Kleidergröße" feminine | mkN "Konfektionsgröße" feminine ; -- status=guess status=guess status=guess
lin environment_N = umgebung_N | umwelt_N ; -- status=guess status=guess
lin per_Prep = variants{} ; -- 
lin fire_N = L.fire_N ;
lin fire_2_N = L.fire_N ;
lin fire_1_N = L.fire_N ;
lin series_N = serie_N ; -- status=guess
lin success_N = erfolg_N ; -- status=guess
lin natural_A = mkA "naturfarben" | mkA "naturfarbig" ; -- status=guess status=guess
lin wrong_A = schlecht_A | mkA "unrecht" | ungerecht_A | mkA "unfair" ; -- status=guess status=guess status=guess status=guess
lin near_Prep = variants{} ; -- 
lin round_Adv = variants{} ; -- 
lin thought_N = gedanke_N ; -- status=guess
lin list_N = liste_N ; -- status=guess
lin argue_VS = mkVS (diskutieren_V) ; -- status=guess, src=wikt
lin argue_V2 = mkV2 (diskutieren_V) ; -- status=guess, src=wikt
lin argue_V = diskutieren_V ; -- status=guess, src=wikt
lin final_A = mkA "endgültig" | mkA "End-" | mkA "Schluss-" ; -- status=guess status=guess status=guess
lin future_N = futur_N | zukunft_N ; -- status=guess status=guess
lin future_3_N = variants{} ; -- 
lin future_1_N = variants{} ; -- 
lin introduce_V2 = mkV2 (vorstellen_V) ; -- status=guess, src=wikt
lin analysis_N = analyse_N ; -- status=guess
lin enter_V2 = mkV2 (mkV "hereingehen") | mkV2 (eintreten_V) | mkV2 (betreten_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin enter_V = mkV "hereingehen" | eintreten_V | betreten_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin space_N = mkN "Weltraumzeitalter" neuter ; -- status=guess
lin arrive_V = ankommen_2_V | mkV "einlangen" | einlaufen_9_V | eintreffen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin ensure_VS = mkVS (sicherstellen_V) | mkVS (mkV "gewährleisten") ; -- status=guess, src=wikt status=guess, src=wikt
lin ensure_V2 = mkV2 (sicherstellen_V) | mkV2 (mkV "gewährleisten") ; -- status=guess, src=wikt status=guess, src=wikt
lin ensure_V = sicherstellen_V | mkV "gewährleisten" ; -- status=guess, src=wikt status=guess, src=wikt
lin demand_N = nachfrage_N ; -- status=guess
lin statement_N = anweisung_N ; -- status=guess
lin to_Adv = zu_viel_Adv ; -- status=guess
lin attention_N = aufmerksamkeit_N | mkN "Beachtung" ; -- status=guess status=guess
lin love_N = L.love_N ;
lin principle_N = mkN "Prinzip" neuter ; -- status=guess
lin pull_V2 = L.pull_V2 ;
lin pull_V = junkV (mkV "jemanden") "reinlegen" | junkV (mkV "jemanden") "über den Löffel barbieren" | junkV (mkV "jemanden") "übers Ohr hauen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin set_N = mkN "Set" masculine ; -- status=guess
lin set_2_N = variants{} ; -- 
lin set_1_N = variants{} ; -- 
lin doctor_N = L.doctor_N ;
lin choice_N = auswahl_N ; -- status=guess
lin refer_V2 = mkV2 (mkReflV "auf etwas beziehen") ; -- status=guess, src=wikt
lin refer_V = mkReflV "auf etwas beziehen" ; -- status=guess, src=wikt
lin feature_N = besonderheit_N | merkmal_N | eigenschaft_N | funktion_N | funktion_N ; -- status=guess status=guess status=guess status=guess status=guess
lin couple_N = mkN "einige" | ein_euro_job_N ; -- status=guess status=guess
lin step_N = mkN "Stufenleiter" feminine | mkN "Stehleiter" feminine | mkN "Trittleiter" feminine | mkN "Leitertritt" masculine | tritt_N ; -- status=guess status=guess status=guess status=guess status=guess
lin following_A = folgend_A | mkA "anschließend" | nachstehend_A ; -- status=guess status=guess status=guess
lin thank_V2 = mkV2 (danken_3_V) | mkV2 (mkReflV "bedanken") ; -- status=guess, src=wikt status=guess, src=wikt
lin machine_N = maschine_N ; -- status=guess
lin income_N = einkommen_N ; -- status=guess
lin training_N = ausbildung_N | training_N ; -- status=guess status=guess
lin present_V2 = mkV2 (mkV "präsentieren") | mkV2 (vorlegen_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin association_N = mkN "Fußball" ; -- status=guess
lin film_N = mkN "Filmregisseur" masculine | mkN "Filmregisseurin" feminine | regisseur_N | mkN "Regisseurin" feminine ; -- status=guess status=guess status=guess status=guess
lin film_2_N = variants{} ; -- 
lin film_1_N = variants{} ; -- 
lin region_N = gegend_N | region_N | raum_N ; -- status=guess status=guess status=guess
lin effort_N = anstrengung_N | aufwand_N ; -- status=guess status=guess
lin player_N = spieler_N ; -- status=guess
lin everyone_NP = variants{} ; -- 
lin present_A = anwesend_A ; -- status=guess
lin award_N = preis_N ; -- status=guess
lin village_N = L.village_N ;
lin control_V2 = mkV2 (steuern_1_V) | mkV2 (kontrollieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin organisation_N = variants{} ; -- 
lin whatever_Det = variants{} ; -- 
lin news_N = nachrichtenagentur_N | presseagentur_N ; -- status=guess status=guess
lin nice_A = mkA "schön" | mkA "hübsch" | nett_A ; -- status=guess status=guess status=guess
lin difficulty_N = schwierigkeit_N ; -- status=guess
lin modern_A = mkA "modern" ; -- status=guess
lin cell_N = zelle_N ; -- status=guess
lin close_A = nah_A ; -- status=guess
lin current_A = mkA "gegenwärtig" ; -- status=guess
lin legal_A = legal_A ; -- status=guess
lin energy_N = energie__N ; -- status=guess
lin finally_Adv = mkAdv "definitiv" ; -- status=guess
lin degree_N = grad_N ; -- status=guess
lin degree_3_N = variants{} ; -- 
lin degree_2_N = variants{} ; -- 
lin degree_1_N = variants{} ; -- 
lin mile_N = meile_N ; -- status=guess
lin means_N = mittel_N ; -- status=guess
lin growth_N = mkN "Wachstum" neuter ; -- status=guess
lin treatment_N = behandlung_N ; -- status=guess
lin sound_N = sonde_N ; -- status=guess
lin above_Prep = S.above_Prep ;
lin task_N = aufgabe_N ; -- status=guess
lin provision_N = provision_N ; -- status=guess
lin affect_V2 = mkV2 (beeinflussen_V) ; -- status=guess, src=wikt
lin please_Adv = bitte_Adv | gerne_Adv ; -- status=guess status=guess
lin red_A = L.red_A ;
lin happy_A = mkA "mit einverstanden sein" ; -- status=guess
lin behaviour_N = verhalten_N | mkN "Betragen" neuter | mkN "Benehmen" neuter | verhaltensweise_N | mkN "Führung" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin concerned_A = variants{} ; -- 
lin point_V2 = mkV2 (zeigen_7_V) ; -- status=guess, src=wikt
lin point_V = zeigen_7_V ; -- status=guess, src=wikt
lin function_N = funktion_N | zweck_N ; -- status=guess status=guess
lin identify_V2 = mkV2 (mkReflV "identifizieren mit") ; -- status=guess, src=wikt
lin identify_V = mkReflV "identifizieren mit" ; -- status=guess, src=wikt
lin resource_N = ressource_N | mittel_N ; -- status=guess status=guess
lin defence_N = verteidigung_N ; -- status=guess
lin garden_N = L.garden_N ;
lin floor_N = L.floor_N ;
lin technology_N = technologie_N | technik_N ; -- status=guess status=guess
lin style_N = stil_N ; -- status=guess
lin feeling_N = mkN "Gefühl" neuter | emotion_N ; -- status=guess status=guess
lin science_N = L.science_N ;
lin relate_V2 = variants{} ; -- 
lin relate_V = variants{} ; -- 
lin doubt_N = zweifel_N ; -- status=guess
lin horse_N = L.horse_N ;
lin force_VS = mkVS (mkV "erzwingen") ; -- status=guess, src=wikt
lin force_V2V = mkV2V (mkV "erzwingen") ; -- status=guess, src=wikt
lin force_V2 = mkV2 (mkV "erzwingen") ; -- status=guess, src=wikt
lin force_V = mkV "erzwingen" ; -- status=guess, src=wikt
lin answer_N = antwort_N ; -- status=guess
lin compare_V = vergleichen_V ; -- status=guess, src=wikt
lin suffer_V2 = mkV2 (erleiden_V) ; -- status=guess, src=wikt
lin suffer_V = erleiden_V ; -- status=guess, src=wikt
lin individual_A = individuell_A ; -- status=guess
lin forward_Adv = mkAdv "vorwärts" ; -- status=guess
lin announce_VS = mkVS (mkV "ankündigen") | mkVS (mkV "verkünden") | mkVS (mkV "bekanntgeben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin announce_V2 = mkV2 (mkV "ankündigen") | mkV2 (mkV "verkünden") | mkV2 (mkV "bekanntgeben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin userMasc_N = mkN "Benutzerfreundlichkeit" feminine ; -- status=guess
lin fund_N = mkN "Kapital" neuter | fonds_N ; -- status=guess status=guess
lin character_2_N = variants{} ; -- 
lin character_1_N = variants{} ; -- 
lin risk_N = mkN "Risiko" neuter ; -- status=guess
lin normal_A = normal_A ; -- status=guess
lin nor_Conj = {s1 = "weder" ; s2 = "noch" ; n = R.Pl} ;
lin dog_N = L.dog_N ;
lin obtain_V2 = mkV2 (bestehen_V) ; -- status=guess, src=wikt
lin obtain_V = bestehen_V ; -- status=guess, src=wikt
lin quickly_Adv = mkAdv "schnell" | mkAdv "rasch" | mkAdv "geschwind" ; -- status=guess status=guess status=guess
lin army_N = mkN "Legionärsameise" ; -- status=guess
lin indicate_VS = mkVS (anzeigen_V) | mkVS (anweisen_5_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin indicate_V2 = mkV2 (anzeigen_V) | mkV2 (anweisen_5_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin forget_VS = mkVS (junkV (mkV "schwamm") "drüber") | mkVS (junkV (mkV "schon") "gut") | mkVS (junkV (mkV "macht") "nichts") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin forget_V2 = L.forget_V2 ;
lin forget_V = junkV (mkV "schwamm") "drüber" | junkV (mkV "schon") "gut" | junkV (mkV "macht") "nichts" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin station_N = bahnhof_N | station_N ; -- status=guess status=guess
lin glass_N = mkN "Glas" neuter ; -- status=guess
lin cup_N = pokal_N | mkN "Cup" masculine | preis_N ; -- status=guess status=guess status=guess
lin previous_A = vorhergehend_A ; -- status=guess
lin husband_N = L.husband_N ;
lin recently_Adv = neulich_Adv | mkAdv "kürzlich" | mkAdv "letztens" | mkAdv "unlängst" | mkAdv "vor kurzem" ; -- status=guess status=guess status=guess status=guess status=guess
lin publish_V2 = mkV2 (mkV "veröffentlichen") ; -- status=guess, src=wikt
lin publish_V = mkV "veröffentlichen" ; -- status=guess, src=wikt
lin serious_A = ernst_A | ernsthaft_A ; -- status=guess status=guess
lin anyway_Adv = wie_Adv ; -- status=guess
lin visit_V2 = mkV2 (besuchen_V) ; -- status=guess, src=wikt
lin visit_V = besuchen_V ; -- status=guess, src=wikt
lin capital_N = hauptstadt_N ; -- status=guess
lin capital_3_N = variants{} ; -- 
lin capital_2_N = variants{} ; -- 
lin capital_1_N = variants{} ; -- 
lin either_Det = variants{} ; -- 
lin note_N = note_N ; -- status=guess
lin note_3_N = variants{} ; -- 
lin note_2_N = variants{} ; -- 
lin note_1_N = variants{} ; -- 
lin season_N = mkN "Staffel" feminine ; -- status=guess
lin argument_N = argument_N ; -- status=guess
lin listen_V = mkV "zuhören" ; -- status=guess, src=wikt
lin show_N = demonstration_N ; -- status=guess
lin responsibility_N = verantwortung_N ; -- status=guess
lin significant_A = signifikant_A | bedeutend_A ; -- status=guess status=guess
lin deal_N = pakt_N | abkommen_N | abmachung_N | abschluss_N ; -- status=guess status=guess status=guess status=guess
lin prime_A = mkA "erste" ; -- status=guess
lin economy_N = wirtschaft_N | mkN "Ökonomie" feminine ; -- status=guess status=guess
lin economy_2_N = variants{} ; -- 
lin economy_1_N = variants{} ; -- 
lin element_N = element_N ; -- status=guess
lin finish_V2 = mkV2 (mkV "fertigstellen") ; -- status=guess, src=wikt
lin finish_V = mkV "fertigstellen" ; -- status=guess, src=wikt
lin duty_N = schicht_N | arbeitszeit_N ; -- status=guess status=guess
lin fight_V2 = L.fight_V2 ;
lin fight_V = mkV "kämpfen" | fechten_5_V | streiten_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin train_V2V = mkV2V (mkV "trainieren") ; -- status=guess, src=wikt
lin train_V2 = mkV2 (mkV "trainieren") ; -- status=guess, src=wikt
lin train_V = mkV "trainieren" ; -- status=guess, src=wikt
lin maintain_VS = mkVS (unterhalten_V) | mkVS (warten_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin maintain_V2 = mkV2 (unterhalten_V) | mkV2 (warten_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin maintain_V = unterhalten_V | warten_8_V ; -- status=guess, src=wikt status=guess, src=wikt
lin attempt_N = anschlag_N | attentat_N ; -- status=guess status=guess
lin leg_N = L.leg_N ;
lin investment_N = investition_N ; -- status=guess
lin save_V2 = mkV2 (sparen_4_V) ; -- status=guess, src=wikt
lin save_V = sparen_4_V ; -- status=guess, src=wikt
lin throughout_Prep = variants{} ; -- 
lin design_V2 = variants{} ; -- 
lin design_V = variants{} ; -- 
lin suddenly_Adv = mkAdv "plötzlich" ; -- status=guess
lin brother_N = mkN "Waffenbruder" masculine ; -- status=guess
lin improve_V2 = mkV2 (mkReflV "verbessern") ; -- status=guess, src=wikt
lin improve_V = mkReflV "verbessern" ; -- status=guess, src=wikt
lin avoid_VV = mkVV (vermeiden_V) | mkVV (meiden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin avoid_V2 = mkV2 (vermeiden_V) | mkV2 (meiden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin wonder_VQ = L.wonder_VQ ;
lin wonder_V = mkReflV "wundern" ; -- status=guess, src=wikt
lin tend_VV = mkVV (tendieren_V) ; -- status=guess, src=wikt
lin tend_V2 = mkV2 (tendieren_V) ; -- status=guess, src=wikt
lin title_N = titel_N | mkN "Eigentumsnachweis" masculine ; -- status=guess status=guess
lin hotel_N = hotel_N ; -- status=guess
lin aspect_N = mkN "aspektorientierte Programmierung" feminine ; -- status=guess
lin increase_N = mkN "Ansteigen" neuter | anstieg_N | mkN "Anwachsen" neuter | mkN "Erhöhung" feminine | mkN "Steigen" neuter | mkN "Steigern" neuter | mkN "Vergrößern" neuter | mkN "Wachsen" neuter | zunahme_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin help_N = hilfe_N ; -- status=guess
lin industrial_A = industriell_A | mkA "Industrie-" ; -- status=guess status=guess
lin express_V2 = mkV2 (mkV "ausdrücken") | mkV2 (mkV "äußern") ; -- status=guess, src=wikt status=guess, src=wikt
lin summer_N = sommer_N ; -- status=guess
lin determine_VV = mkVV (festlegen_8_V) ; -- status=guess, src=wikt
lin determine_VS = mkVS (festlegen_8_V) ; -- status=guess, src=wikt
lin determine_V2V = mkV2V (festlegen_8_V) ; -- status=guess, src=wikt
lin determine_V2 = mkV2 (festlegen_8_V) ; -- status=guess, src=wikt
lin determine_V = festlegen_8_V ; -- status=guess, src=wikt
lin generally_Adv = mkAdv "hauptsächlich" | mkAdv "überhaupt" | mkAdv "üblicherweise" ; -- status=guess status=guess status=guess
lin daughter_N = tochter_N ; -- status=guess
lin exist_V = bestehen_V | existieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin share_V2 = mkV2 (teilen_9_V) ; -- status=guess, src=wikt
lin share_V = teilen_9_V ; -- status=guess, src=wikt
lin baby_N = L.baby_N ;
lin nearly_Adv = beinahe_Adv | fast_Adv ; -- status=guess status=guess
lin smile_V = mkV "lächeln" ; -- status=guess, src=wikt
lin sorry_A = mkA "beklagenswert" | armselig_A | traurig_A ; -- status=guess status=guess status=guess
lin sea_N = L.sea_N ;
lin skill_N = geschicklichkeit_N | mkN "Fähigkeit" feminine | kunst_N | talent_N | fertigkeit_N ; -- status=guess status=guess status=guess status=guess status=guess
lin claim_N = anspruch_N ; -- status=guess
lin treat_V2 = mkV2 (bewirten_V) ; -- status=guess, src=wikt
lin treat_V = bewirten_V ; -- status=guess, src=wikt
lin remove_V2 = mkV2 (umziehen_V) ; -- status=guess, src=wikt
lin remove_V = umziehen_V ; -- status=guess, src=wikt
lin concern_N = betroffenheit_N | sorge_N | mkN "Besorgnis" feminine ; -- status=guess status=guess status=guess
lin university_N = L.university_N ;
lin left_A = mkA "linkshändig" ; -- status=guess
lin dead_A = mausetot_A ; -- status=guess
lin discussion_N = diskussion_N ; -- status=guess
lin specific_A = spezifisch_A ; -- status=guess
lin customerMasc_N = kunde_N | abnehmer_N | mkN "Käufer" masculine ; -- status=guess status=guess status=guess
lin box_N = mkN "Boxhieb" masculine | mkN "Boxschlag" masculine ; -- status=guess status=guess
lin outside_Prep = variants{} ; -- 
lin state_VS = mkVS (mkV "erklären") ; -- status=guess, src=wikt
lin state_V2 = mkV2 (mkV "erklären") ; -- status=guess, src=wikt
lin conference_N = konferenz_N ; -- status=guess
lin whole_N = mkN "Ganze" neuter ; -- status=guess
lin total_A = komplett_A | total_A ; -- status=guess status=guess
lin profit_N = gewinn_und_verlust_rechnung_N | profit_N ; -- status=guess status=guess
lin division_N = teilung_N ; -- status=guess
lin division_3_N = variants{} ; -- 
lin division_2_N = variants{} ; -- 
lin division_1_N = variants{} ; -- 
lin throw_V2 = L.throw_V2 ;
lin throw_V = mkV "fortwerfen" | mkV "wegwerfen" ; -- status=guess, src=wikt status=guess, src=wikt
lin procedure_N = mkN "Unterprogramm" neuter ; -- status=guess
lin fill_V2 = mkV2 (mkV "füllen") | mkV2 (mkV "ausfüllen") ; -- status=guess, src=wikt status=guess, src=wikt
lin fill_V = mkV "füllen" | mkV "ausfüllen" ; -- status=guess, src=wikt status=guess, src=wikt
lin king_N = L.king_N ;
lin assume_VS = mkVS (annehmen_4_V) ; -- status=guess, src=wikt
lin assume_V2 = mkV2 (annehmen_4_V) ; -- status=guess, src=wikt
lin image_N = image_N | erscheinungsbild_N ; -- status=guess status=guess
lin oil_N = L.oil_N ;
lin obviously_Adv = variants{} ; -- 
lin unless_Subj = variants{} ; -- 
lin appropriate_A = mkA "zugewiesen" ; -- status=guess
lin circumstance_N = umstand_N ; -- status=guess
lin military_A = mkA "militärisch" ; -- status=guess
lin proposal_N = vorschlag_N ; -- status=guess
lin mention_VS = mkVS (mkV "erwähnen") ; -- status=guess, src=wikt
lin mention_V2 = mkV2 (mkV "erwähnen") ; -- status=guess, src=wikt
lin mention_V = mkV "erwähnen" ; -- status=guess, src=wikt
lin client_N = kunde_N ; -- status=guess
lin sector_N = variants{} ; -- 
lin direction_N = richtung_N ; -- status=guess
lin admit_VS = mkVS (einlassen_1_V) | mkVS (zulassen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin admit_V2 = mkV2 (einlassen_1_V) | mkV2 (zulassen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin admit_V = einlassen_1_V | zulassen_7_V ; -- status=guess, src=wikt status=guess, src=wikt
lin though_Adv = trotzdem_Adv | mkAdv "doch" | allerdings_Adv ; -- status=guess status=guess status=guess
lin replace_V2 = mkV2 (ersetzen_V) ; -- status=guess, src=wikt
lin basic_A = basisch_A ; -- status=guess
lin hard_Adv = variants{} ; -- 
lin instance_N = instanz_N ; -- status=guess
lin sign_N = zeichen_N | sonderzeichen_N ; -- status=guess status=guess
lin original_A = original_A ; -- status=guess
lin successful_A = erfolgreich_A ; -- status=guess
lin okay_Adv = variants{} ; -- 
lin reflect_V2 = mkV2 (reflektieren_V) | mkV2 (mkV "zurückspiegeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin reflect_V = reflektieren_V | mkV "zurückspiegeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin aware_A = bewusst_A ; -- status=guess
lin measure_N = messung_N ; -- status=guess
lin attitude_N = einstellung_N ; -- status=guess
lin disease_N = krankheit_N | infektionskrankheit_N ; -- status=guess status=guess
lin exactly_Adv = mkAdv "genau" ; -- status=guess
lin above_Adv = mkAdv "vor allem" | mkAdv "hauptsächlich" | mkAdv "vor allem anderen" ; -- status=guess status=guess status=guess
lin commission_N = kommission_N ; -- status=guess
lin intend_VV = mkVV (beabsichtigen_V) | mkVV (vorhaben_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin beyond_Prep = variants{} ; -- 
lin seat_N = sicherheitsgurt_N ; -- status=guess
lin presidentMasc_N = mkN "Präsident" masculine ; -- status=guess
lin encourage_V2V = mkV2V (ermutigen_V) ; -- status=guess, src=wikt
lin encourage_V2 = mkV2 (ermutigen_V) ; -- status=guess, src=wikt
lin addition_N = mkN "Zufügung" feminine | mkN "Hinzufügung" feminine ; -- status=guess status=guess
lin goal_N = tor_N ; -- status=guess
lin round_Prep = variants{} ; -- 
lin miss_V2 = mkV2 (verpassen_V) | mkV2 (verfehlen_V) | mkV2 (auslassen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin miss_V = verpassen_V | verfehlen_V | auslassen_9_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin popular_A = beliebt_A | mkA "populär" ; -- status=guess status=guess
lin affair_N = mkN "Scharmützel" neuter ; -- status=guess
lin technique_N = technik_N ; -- status=guess
lin respect_N = mkN "Achtung" feminine | mkN "Respekt" masculine ; -- status=guess status=guess
lin drop_V2 = mkV2 (fallen_6_V) ; -- status=guess, src=wikt
lin drop_V = fallen_6_V ; -- status=guess, src=wikt
lin professional_A = professionell_A ; -- status=guess
lin less_Det = variants{} ; -- 
lin once_Subj = variants{} ; -- 
lin item_N = mkN "Stück" neuter | artikel_N | element_N | mkN "Ding" neuter ; -- status=guess status=guess status=guess status=guess
lin fly_V2 = mkV2 (fahren_7_V) | mkV2 (mkV "baloon)") | mkV2 (fliegen_2_V) | mkV2 (fliegen_2_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fly_V = L.fly_V ;
lin reveal_VS = mkVS (mkV "enthüllen") ; -- status=guess, src=wikt
lin reveal_V2 = mkV2 (mkV "enthüllen") ; -- status=guess, src=wikt
lin version_N = version_N ; -- status=guess
lin maybe_Adv = vielleicht_Adv | mkAdv "mag sein" ; -- status=guess status=guess
lin ability_N = mkN "Fähigkeit" feminine ; -- status=guess
lin operate_V2 = mkV2 (operieren_V) ; -- status=guess, src=wikt
lin operate_V = operieren_V ; -- status=guess, src=wikt
lin good_N = das_nbsplarsen_system_N ; -- status=guess
lin campaign_N = kampagne_N | feldzug_N | mkN "Heereszug" masculine ; -- status=guess status=guess status=guess
lin heavy_A = L.heavy_A ;
lin advice_N = rat_N ; -- status=guess
lin institution_N = institution_N ; -- status=guess
lin discover_VS = mkVS (entdecken_V) ; -- status=guess, src=wikt
lin discover_V2 = mkV2 (entdecken_V) ; -- status=guess, src=wikt
lin discover_V = entdecken_V ; -- status=guess, src=wikt
lin surface_N = mkN "Oberfläche" feminine ; -- status=guess
lin library_N = bibliothek_N ; -- status=guess
lin pupil_N = mkN "Schüler" masculine | mkN "Schülerin" feminine | mkN "Schulkind" neuter ; -- status=guess status=guess status=guess
lin record_V2 = mkV2 (eintragen_2_V) | mkV2 (mkV "protokollieren") | mkV2 (mkV "aufzeichnen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin refuse_VV = mkVV (mkReflV "weigern") ; -- status=guess, src=wikt
lin refuse_V2 = mkV2 (mkReflV "weigern") ; -- status=guess, src=wikt
lin refuse_V = mkReflV "weigern" ; -- status=guess, src=wikt
lin prevent_V2 = mkV2 (verhindern_V) | mkV2 (vorbeugen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin advantage_N = vorteil_N ; -- status=guess
lin dark_A = dunkel_A | finster_A ; -- status=guess status=guess
lin teach_V2V = mkV2V (lehren_V) | mkV2V (beibringen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin teach_V2 = L.teach_V2 ;
lin teach_V = lehren_V | beibringen_7_V ; -- status=guess, src=wikt status=guess, src=wikt
lin memory_N = speicher_N ; -- status=guess
lin culture_N = kultur_N ; -- status=guess
lin blood_N = L.blood_N ;
lin cost_V2 = mkV2 (kosten_V) ; -- status=guess, src=wikt
lin cost_V = kosten_V ; -- status=guess, src=wikt
lin majority_N = mkN "Erwachsenenalter" neuter ; -- status=guess
lin answer_V2 = mkV2 (antworten_V) ; -- status=guess, src=wikt
lin answer_V = antworten_V ; -- status=guess, src=wikt
lin variety_N = mkN "Vielfältigkeit" feminine ; -- status=guess
lin variety_2_N = variants{} ; -- 
lin variety_1_N = variants{} ; -- 
lin press_N = pressekonferenz_N ; -- status=guess
lin depend_V = mkV "abhängen" ; -- status=guess, src=wikt
lin bill_N = mkN "Landzunge" feminine ; -- status=guess
lin competition_N = konkurrenz_N ; -- status=guess
lin ready_A = bereit_A ; -- status=guess
lin general_N = mkN "General" masculine ; -- status=guess
lin access_N = zugang_N ; -- status=guess
lin hit_V2 = L.hit_V2 ;
lin hit_V = anmachen_V ; -- status=guess, src=wikt
lin stone_N = L.stone_N ;
lin useful_A = mkA "nützlich" ; -- status=guess
lin extent_N = umfang_N | mkN "Ausmaß" neuter | mkN "Größe" feminine ; -- status=guess status=guess status=guess
lin employment_N = mkN "Jobbörse" feminine ; -- status=guess
lin regard_V2 = variants{} ; -- 
lin regard_V = variants{} ; -- 
lin apart_Adv = beiseite_Adv ; -- status=guess
lin present_N = mkN "Gegenwart" feminine | mkN "Jetzt" neuter ; -- status=guess status=guess
lin appeal_N = berufung_N ; -- status=guess
lin text_N = text_N ; -- status=guess
lin parliament_N = mkN "Eulenschwarm" masculine ; -- status=guess
lin cause_N = sache_N ; -- status=guess
lin terms_N = variants{} ; -- 
lin bar_N = mkN "Rechtsanwaltskammer" ; -- status=guess
lin bar_2_N = variants{} ; -- 
lin bar_1_N = variants{} ; -- 
lin attack_N = attacke_N | angriff_N ; -- status=guess status=guess
lin effective_A = wirksam_A | in_A ; -- status=guess status=guess
lin mouth_N = L.mouth_N ;
lin down_Prep = variants{} ; -- 
lin result_V = variants{} ; -- 
lin fish_N = L.fish_N ;
lin future_A = mkA "zukünftig" ; -- status=guess
lin visit_N = besuch_N ; -- status=guess
lin little_Adv = mkAdv "wenig" ; -- status=guess
lin easily_Adv = variants{} ; -- 
lin attempt_VV = mkVV (versuchen_V) ; -- status=guess, src=wikt
lin attempt_V2 = mkV2 (versuchen_V) ; -- status=guess, src=wikt
lin enable_VS = mkVS (anordnen_V) ; -- status=guess, src=wikt
lin enable_V2V = mkV2V (anordnen_V) ; -- status=guess, src=wikt
lin enable_V2 = mkV2 (anordnen_V) ; -- status=guess, src=wikt
lin trouble_N = mkN "Ärger" masculine ; -- status=guess
lin traditional_A = traditionell_A ; -- status=guess
lin payment_N = zahlung_N ; -- status=guess
lin best_Adv = mkAdv "beste" | mkAdv "am besten" ; -- status=guess status=guess
lin post_N = stelle_N | posten_N ; -- status=guess status=guess
lin county_N = landkreis_N | grafschaft_N | bezirk_N | mkN "County" neuter ; -- status=guess status=guess status=guess status=guess
lin lady_N = mkN "Puffmutter" ; -- status=guess
lin holiday_N = mkN "gesetzlicher Feiertag" masculine ; -- status=guess
lin realize_VS = mkVS (erkennen_2_V) | mkVS (realisieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin realize_V2 = mkV2 (erkennen_2_V) | mkV2 (realisieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin importance_N = wichtigkeit_N | belang_N ; -- status=guess status=guess
lin chair_N = L.chair_N ;
lin facility_N = mkN "Leichtigkeit" feminine ; -- status=guess
lin complete_V2 = mkV2 (beenden_V) | mkV2 (mkV "fertigstellen") | mkV2 (fertigmachen_3_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin complete_V = beenden_V | mkV "fertigstellen" | fertigmachen_3_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin article_N = artikel_N ; -- status=guess
lin object_N = objekt_N ; -- status=guess
lin context_N = kontext_N | zusammenhang_N ; -- status=guess status=guess
lin survey_N = umfrage_N ; -- status=guess
lin notice_VS = mkVS (bemerken_V) | mkVS (feststellen_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin notice_V2 = mkV2 (bemerken_V) | mkV2 (feststellen_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin complete_A = abgeschlossen_A | mkA "beendet" ; -- status=guess status=guess
lin turn_N = mkN "paraphrased: take turns = sich abwechseln" | mkN "an der Reihe sein" | mkN "dran sein" ; -- status=guess status=guess status=guess
lin direct_A = direkt_A | unmittelbar_A ; -- status=guess status=guess
lin immediately_Adv = sofort_Adv ; -- status=guess
lin collection_N = mkN "Sammeln" neuter | sammlung_N | mkN "Abholung" feminine | mkN "Einsammlung" feminine ; -- status=guess status=guess status=guess status=guess
lin reference_N = quelle_N ; -- status=guess
lin card_N = karte_N ; -- status=guess
lin interesting_A = interessant_A ; -- status=guess
lin considerable_A = erheblich_A | mkA "beträchtlich" | beachtlich_A ; -- status=guess status=guess status=guess
lin television_N = L.television_N ;
lin extend_V2 = mkV2 (ausdehnen_V) | mkV2 (erweitern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin extend_V = ausdehnen_V | erweitern_V ; -- status=guess, src=wikt status=guess, src=wikt
lin communication_N = kommunikation_N ; -- status=guess
lin agency_N = wille_N | mkN "Agency" | mkN "Handlungsfähigkeit" feminine ; -- status=guess status=guess status=guess
lin physical_A = physikalisch_A ; -- status=guess
lin except_Conj = variants{} ; -- 
lin check_V2 = mkV2 (mkV "einchecken") ; -- status=guess, src=wikt
lin check_V = mkV "einchecken" ; -- status=guess, src=wikt
lin sun_N = L.sun_N ;
lin species_N = art_N ; -- status=guess
lin possibility_N = mkN "Möglichkeit" feminine ; -- status=guess
lin officialMasc_N = mkN "Beamte" masculine ; -- status=guess
lin chairman_N = mkN "Vorsitzender" masculine | vorsitzende_N ; -- status=guess status=guess
lin speaker_N = lautsprecher_N ; -- status=guess
lin second_N = sekunde_N ; -- status=guess
lin career_N = karriere_N ; -- status=guess
lin laugh_VS = mkVS (lachen_9_V) ; -- status=guess, src=wikt
lin laugh_V2 = mkV2 (lachen_9_V) ; -- status=guess, src=wikt
lin laugh_V = L.laugh_V ;
lin weight_N = gewicht_N ; -- status=guess
lin sound_VS = mkVS (sondieren_V) ; -- status=guess, src=wikt
lin sound_VA = mkVA (sondieren_V) ; -- status=guess, src=wikt
lin sound_V2 = mkV2 (sondieren_V) ; -- status=guess, src=wikt
lin sound_V = sondieren_V ; -- status=guess, src=wikt
lin responsible_A = mkA "vernünftig" ; -- status=guess
lin base_N = base_N ; -- status=guess
lin document_N = mkN "Unterlagen {p}" | dokument_N | mkN "Aktenstück" neuter ; -- status=guess status=guess status=guess
lin solution_N = mkN "Lösung" feminine ; -- status=guess
lin return_N = mkN "Rückkehr" feminine ; -- status=guess
lin medical_A = medizinisch_A ; -- status=guess
lin hot_A = L.hot_A ;
lin recognize_VS = mkVS (erkennen_2_V) | mkVS (wiedererkennen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin talk_N = mkN "Gespräch" neuter ; -- status=guess
lin budget_N = budget_N | etat_N | haushalt_N ; -- status=guess status=guess status=guess
lin river_N = L.river_N ;
lin fit_V2 = mkV2 (mkV "amenagieren") ; -- status=guess, src=wikt
lin fit_V = mkV "amenagieren" ; -- status=guess, src=wikt
lin organization_N = organisation_N ; -- status=guess
lin existing_A = bestehend_A | mkA "existierend" ; -- status=guess status=guess
lin start_N = beginn_N | anfang_N ; -- status=guess status=guess
lin push_VS = mkVS (mkV "drängen") ; -- status=guess, src=wikt
lin push_V2V = mkV2V (mkV "drängen") ; -- status=guess, src=wikt
lin push_V2 = L.push_V2 ;
lin push_V = mkV "drängen" ; -- status=guess, src=wikt
lin tomorrow_Adv = morgen_Adv ; -- status=guess
lin requirement_N = anforderung_N ; -- status=guess
lin cold_A = L.cold_A ;
lin edge_N = vorsprung_N ; -- status=guess
lin opposition_N = opposition_N ; -- status=guess
lin opinion_N = meinung_N | ansicht_N | anschauung_N ; -- status=guess status=guess status=guess
lin drug_N = droge_N | rauschgift_N | rauschmittel_N | mkN "Betäubungsmittel" neuter ; -- status=guess status=guess status=guess status=guess
lin quarter_N = mkN "Vierteldollar" masculine ; -- status=guess
lin option_N = option_N ; -- status=guess
lin sign_V2 = mkV2 (mkV "gebärden") ; -- status=guess, src=wikt
lin sign_V = mkV "gebärden" ; -- status=guess, src=wikt
lin worth_Prep = variants{} ; -- 
lin call_N = ruf_N | mkN "Lockruf" masculine ; -- status=guess status=guess
lin define_V2 = mkV2 (bestimmen_V) ; -- status=guess, src=wikt
lin define_V = bestimmen_V ; -- status=guess, src=wikt
lin stock_N = mkN "Brühe" feminine ; -- status=guess
lin influence_N = einfluss_N ; -- status=guess
lin occasion_N = gelegenheit_N ; -- status=guess
lin eventually_Adv = mkAdv "schließlich" | letztendlich_Adv ; -- status=guess status=guess
lin software_N = software_entwicklerin_N ; -- status=guess
lin highly_Adv = variants{} ; -- 
lin exchange_N = austausch_N | tausch_N ; -- status=guess status=guess
lin lack_N = mangel_N ; -- status=guess
lin shake_V2 = mkV2 (junkV (mkV "Hände") "schütteln") ; -- status=guess, src=wikt
lin shake_V = junkV (mkV "Hände") "schütteln" ; -- status=guess, src=wikt
lin study_V2 = mkV2 (studieren_V) ; -- status=guess, src=wikt
lin study_V = studieren_V ; -- status=guess, src=wikt
lin concept_N = begriff_N | konzept_N ; -- status=guess status=guess
lin blue_A = L.blue_A ;
lin star_N = L.star_N ;
lin radio_N = L.radio_N ;
lin arrangement_N = anordnung_N ; -- status=guess
lin examine_V2 = mkV2 (untersuchen_V) ; -- status=guess, src=wikt
lin bird_N = L.bird_N ;
lin green_A = L.green_A ;
lin band_N = pflaster_N | mkN "Heftpflaster" neuter ; -- status=guess status=guess
lin sex_N = wein_N | mkN "Weib und Gesang" ; -- status=guess status=guess
lin finger_N = finger_N ; -- status=guess
lin past_N = partizip_N ; -- status=guess
lin independent_A = mkA "unabhängig" ; -- status=guess
lin independent_2_A = variants{} ; -- 
lin independent_1_A = variants{} ; -- 
lin equipment_N = mkN "Ausrüstung" feminine ; -- status=guess
lin north_N = mkN "Norden" masculine | mkN "Nord" masculine ; -- status=guess status=guess
lin mind_VS = mkVS (junkV (mkV "dagegen") "haben") ; -- status=guess, src=wikt
lin mind_V2 = mkV2 (junkV (mkV "dagegen") "haben") ; -- status=guess, src=wikt
lin mind_V = junkV (mkV "dagegen") "haben" ; -- status=guess, src=wikt
lin move_N = bewegung_N ; -- status=guess
lin message_N = nachricht_N | botschaft_N | mitteilung_N ; -- status=guess status=guess status=guess
lin fear_N = angst_N | mkN "Furcht" feminine | phobie_N ; -- status=guess status=guess status=guess
lin afternoon_N = nachmittag_N ; -- status=guess
lin drink_V2 = L.drink_V2 ;
lin drink_V = saufen_V ; -- status=guess, src=wikt
lin fully_Adv = mkAdv "völlig" ; -- status=guess
lin race_N = rasse_N ; -- status=guess
lin race_2_N = variants{} ; -- 
lin race_1_N = variants{} ; -- 
lin gain_V2 = mkV2 (gewinnen_V) ; -- status=guess, src=wikt
lin gain_V = gewinnen_V ; -- status=guess, src=wikt
lin strategy_N = strategie_N ; -- status=guess
lin extra_A = variants{} ; -- 
lin scene_N = szene_N ; -- status=guess
lin slightly_Adv = ein_Adv ; -- status=guess
lin kitchen_N = mkN "Küche" feminine ; -- status=guess
lin speech_N = sprechakt_N ; -- status=guess
lin arise_V = entstehen_V ; -- status=guess, src=wikt
lin network_N = netzwerk_N ; -- status=guess
lin tea_N = mkN "Teezeremonie" feminine ; -- status=guess
lin peace_N = L.peace_N ;
lin failure_N = versager_N | mkN "Versagerin" feminine ; -- status=guess status=guess
lin employee_N = arbeitnehmer_N | mkN "Angestellter" masculine | mkN "Angestellte" feminine ; -- status=guess status=guess status=guess
lin ahead_Adv = variants{} ; -- 
lin scale_N = mkN "Skala" feminine ; -- status=guess
lin hardly_Adv = kaum_Adv ; -- status=guess
lin attend_V2 = mkV2 (teilnehmen_V) | mkV2 (besuchen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin attend_V = teilnehmen_V | besuchen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin shoulder_N = mkN "Schulterblatt" neuter ; -- status=guess
lin otherwise_Adv = anders_Adv ; -- status=guess
lin railway_N = bahnhof_N | mkN "Eisenbahnhof" masculine ; -- status=guess status=guess
lin directly_Adv = mkAdv "direkt" | mkAdv "gerade" ; -- status=guess status=guess
lin supply_N = angebot_N | mkN "Versorgen" neuter ; -- status=guess status=guess
lin expression_N = redensart_N ; -- status=guess
lin owner_N = besitzer_N | mkN "Eigentümer" masculine ; -- status=guess status=guess
lin associate_V2 = variants{} ; -- 
lin associate_V = variants{} ; -- 
lin corner_N = ecke_N | winkel_N ; -- status=guess status=guess
lin past_A = mkA "vergangen" ; -- status=guess
lin match_N = mkN "ebenbürtig" ; -- status=guess
lin match_3_N = variants{} ; -- 
lin match_2_N = variants{} ; -- 
lin match_1_N = variants{} ; -- 
lin sport_N = sport_N ; -- status=guess
lin status_N = status_N ; -- status=guess
lin beautiful_A = L.beautiful_A ;
lin offer_N = angebot_N | antrag_N | offerte_N ; -- status=guess status=guess status=guess
lin marriage_N = mkN "Heiratagentur" feminine | mkN "Heiratsbüro" neuter ; -- status=guess status=guess
lin hang_V2 = mkV2 (mkV "abhängen") | mkV2 (mkV "herumhängen") | mkV2 (mkV "rumhängen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hang_V = mkV "abhängen" | mkV "herumhängen" | mkV "rumhängen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin civil_A = zivil_A | mkA "bürgerlich" ; -- status=guess status=guess
lin perform_V2 = mkV2 (mkV "durchführen") | mkV2 (mkV "ausführen") ; -- status=guess, src=wikt status=guess, src=wikt
lin perform_V = mkV "durchführen" | mkV "ausführen" ; -- status=guess, src=wikt status=guess, src=wikt
lin sentence_N = urteil_N ; -- status=guess
lin crime_N = verbrechen_N ; -- status=guess
lin ball_N = mkN "Fußballen" masculine ; -- status=guess
lin marry_V2 = mkV2 (heiraten_V) ; -- status=guess, src=wikt
lin marry_V = heiraten_V ; -- status=guess, src=wikt
lin wind_N = L.wind_N ;
lin truth_N = wahrheit_N ; -- status=guess
lin protect_V2 = mkV2 (mkV "schützen") ; -- status=guess, src=wikt
lin protect_V = mkV "schützen" ; -- status=guess, src=wikt
lin safety_N = sicherheit_N ; -- status=guess
lin partner_N = partner_N ; -- status=guess
lin completely_Adv = mkAdv "vollständig" | mkAdv "völlig" | mkAdv "ganz" ; -- status=guess status=guess status=guess
lin copy_N = mkN "Kopierschutz" masculine ; -- status=guess
lin balance_N = balance_N | gleichgewicht_N ; -- status=guess status=guess
lin sister_N = L.sister_N ;
lin reader_N = leser_N | leserin_N ; -- status=guess status=guess
lin below_Adv = unten_Adv | darunter_Adv | mkAdv "unterhalb" ; -- status=guess status=guess status=guess
lin trial_N = trial_N | versuch_N ; -- status=guess status=guess
lin rock_N = L.rock_N ;
lin damage_N = schaden_N ; -- status=guess
lin adopt_V2 = mkV2 (adoptieren_V) ; -- status=guess, src=wikt
lin newspaper_N = L.newspaper_N ;
lin meaning_N = bedeutung_N ; -- status=guess
lin light_A = mkA "erleuchtet" | hell_A ; -- status=guess status=guess
lin essential_A = essenziell_A | notwendig_A ; -- status=guess status=guess
lin obvious_A = offensichtlich_A ; -- status=guess
lin nation_N = nation_N ; -- status=guess
lin confirm_VS = mkVS (mkV "bestätigen") | mkVS (mkV "bekräftigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin confirm_V2 = mkV2 (mkV "bestätigen") | mkV2 (mkV "bekräftigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin south_N = mkN "Süden" masculine ; -- status=guess
lin length_N = mkN "Pferdelänge" feminine ; -- status=guess
lin branch_N = branche_N ; -- status=guess
lin deep_A = tief_A ; -- status=guess
lin none_NP = variants{} ; -- 
lin planning_N = planung_N ; -- status=guess
lin trust_N = mkN "Vertrauen" neuter ; -- status=guess
lin working_A = variants{} ; -- 
lin pain_N = schmerz_N ; -- status=guess
lin studio_N = atelier_N | studio_N ; -- status=guess status=guess
lin positive_A = positiv_A ; -- status=guess
lin spirit_N = schnaps_N | sprit_N | alkohol_N ; -- status=guess status=guess status=guess
lin college_N = mkN "Berufskolleg" neuter | fachschule_N ; -- status=guess status=guess
lin accident_N = unfall_N ; -- status=guess
lin star_V2 = variants{} ; -- 
lin hope_N = hoffnung_N ; -- status=guess
lin mark_V3 = mkV3 (korrigieren_V) ; -- status=guess, src=wikt
lin mark_V2 = mkV2 (korrigieren_V) ; -- status=guess, src=wikt
lin works_N = mkN "Arbeiten" ; -- status=guess
lin league_N = liga_N | bund_N ; -- status=guess status=guess
lin league_2_N = variants{} ; -- 
lin league_1_N = variants{} ; -- 
lin clear_V2 = mkV2 (mkV "räuspern") ; -- status=guess, src=wikt
lin clear_V = mkV "räuspern" ; -- status=guess, src=wikt
lin imagine_VS = mkVS (mkReflV "vorstellen") | mkVS (vorstellen_V) | mkVS (mkV "einbilden") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin imagine_V2 = mkV2 (mkReflV "vorstellen") | mkV2 (vorstellen_V) | mkV2 (mkV "einbilden") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin imagine_V = mkReflV "vorstellen" | vorstellen_V | mkV "einbilden" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin through_Adv = variants{}; -- S.through_Prep ;
lin cash_N = mkN "Melkkuh" feminine ; -- status=guess
lin normally_Adv = normalerweise_Adv ; -- status=guess
lin play_N = spiel_N ; -- status=guess
lin strength_N = kraft_N | mkN "Stärke" feminine ; -- status=guess status=guess
lin train_N = L.train_N ;
lin travel_V2 = mkV2 (reisen_3_V) ; -- status=guess, src=wikt
lin travel_V = L.travel_V ;
lin target_N = zielscheibe_N ; -- status=guess
lin very_A = mkA "derselbe" ; -- status=guess
lin pair_N = zirkel_N ; -- status=guess
lin male_A = mkA "männlich" ; -- status=guess
lin gas_N = mkN "Gaszentrifuge" feminine ; -- status=guess
lin issue_V2 = variants{} ; -- 
lin issue_V = variants{} ; -- 
lin contribution_N = beitrag_N | mkN "finanzieller Beitrag" masculine ; -- status=guess status=guess
lin complex_A = kompliziert_A ; -- status=guess
lin supply_V2 = mkV2 (vertreten_V) ; -- status=guess, src=wikt
lin beat_V2 = mkV2 (junkV (mkV "um") "den heißen Brei reden") ; -- status=guess, src=wikt
lin beat_V = junkV (mkV "um") "den heißen Brei reden" ; -- status=guess, src=wikt
lin artist_N = mkN "Künstler" masculine | mkN "Künstlerin" feminine ; -- status=guess status=guess
lin agentMasc_N = mkN "Agens" neuter ; -- status=guess
lin presence_N = mkN "Anwesenheit" feminine ; -- status=guess
lin along_Adv = variants{} ; -- 
lin environmental_A = variants{} ; -- 
lin strike_V2 = mkV2 (streichen_1_V) ; -- status=guess, src=wikt
lin strike_V = streichen_1_V ; -- status=guess, src=wikt
lin contact_N = kontakt_N | mkN "Berührung" feminine ; -- status=guess status=guess
lin protection_N = schutz_N ; -- status=guess
lin beginning_N = anfang_N | beginn_N ; -- status=guess status=guess
lin demand_VS = mkVS (verlangen_V) | mkVS (bestehen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin demand_V2 = mkV2 (verlangen_V) | mkV2 (bestehen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin media_N = mkN "Medien {n} {p}" ; -- status=guess
lin relevant_A = relevant_A ; -- status=guess
lin employ_V2 = mkV2 (einstellen_V) | mkV2 (anstellen_0_V) | mkV2 (mkV "anwerben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shoot_V2 = mkV2 (aufschneiden_9_V) ; -- status=guess, src=wikt
lin shoot_V = aufschneiden_9_V ; -- status=guess, src=wikt
lin executive_N = exekutive_N ; -- status=guess
lin slowly_Adv = mkAdv "langsam" ; -- status=guess
lin relatively_Adv = mkAdv "relativ" | mkAdv "verhältnismäßig" ; -- status=guess status=guess
lin aid_N = helfer_N ; -- status=guess
lin huge_A = riesig_A ; -- status=guess
lin late_Adv = mkAdv "spät" ; -- status=guess
lin speed_N = mkN "Bodenschwelle" feminine | mkN "Bremsschwelle" feminine | mkN "Fahrbahnschwelle" feminine ; -- status=guess status=guess status=guess
lin review_N = rezension_N | kritik_N ; -- status=guess status=guess
lin test_V2 = mkV2 (testen_V) ; -- status=guess, src=wikt
lin order_VS = mkVS (befehlen_3_V) | mkVS (anordnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin order_V2V = mkV2V (befehlen_3_V) | mkV2V (anordnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin order_V2 = mkV2 (befehlen_3_V) | mkV2 (anordnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin order_V = befehlen_3_V | anordnen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin route_N = mkN "Route" feminine | weg_N | pfad_N ; -- status=guess status=guess status=guess
lin consequence_N = konsequenz_N | folge_N ; -- status=guess status=guess
lin telephone_N = telefon__N | telephon_N | fernsprecher_N ; -- status=guess status=guess status=guess
lin release_V2 = mkV2 (freisetzen_V) ; -- status=guess, src=wikt
lin proportion_N = proportion_N ; -- status=guess
lin primary_A = mkA "primär" ; -- status=guess
lin consideration_N = mkN "Vergütung" ; -- status=guess
lin reform_N = reform_N ; -- status=guess
lin driverMasc_N = fahrer_N | fahrerin_N ; -- status=guess status=guess
lin annual_A = mkA "jährlich" ; -- status=guess
lin nuclear_A = nuklear_A | mkA "Kern-" ; -- status=guess status=guess
lin latter_A = mkA "letzter" ; -- status=guess
lin practical_A = praktisch_A ; -- status=guess
lin commercial_A = kommerziell_A ; -- status=guess
lin rich_A = reich_A ; -- status=guess
lin emerge_V = entstehen_V | auftauchen_0_V ; -- status=guess, src=wikt status=guess, src=wikt
lin apparently_Adv = mkAdv "angeblich" | mkAdv "vorgeblich" | anscheinend_Adv ; -- status=guess status=guess status=guess
lin ring_V = junkV (mkV "einem") "bekannt vorkommen" ; -- status=guess, src=wikt
lin ring_6_V2 = variants{} ; -- 
lin ring_4_V2 = variants{} ; -- 
lin distance_N = distanz_N | entfernung_N | abstand_N ; -- status=guess status=guess status=guess
lin exercise_N = mkN "Übung" feminine ; -- status=guess
lin key_A = variants{} ; -- 
lin close_Adv = variants{} ; -- 
lin skin_N = L.skin_N ;
lin island_N = insel_N | eiland_N ; -- status=guess status=guess
lin separate_A = einzeln_A | getrennt_A | separat_A ; -- status=guess status=guess status=guess
lin aim_VV = mkVV (zielen_6_V) ; -- status=guess, src=wikt
lin aim_V2 = mkV2 (zielen_6_V) ; -- status=guess, src=wikt
lin aim_V = zielen_6_V ; -- status=guess, src=wikt
lin danger_N = gefahr_N | mkN "Risiko" neuter ; -- status=guess status=guess
lin credit_N = kreditkarte_N ; -- status=guess
lin usual_A = mkA "gewöhnlich" ; -- status=guess
lin link_V2 = mkV2 (verbinden_V) | mkV2 (mkV "verknüpfen") ; -- status=guess, src=wikt status=guess, src=wikt
lin link_V = verbinden_V | mkV "verknüpfen" ; -- status=guess, src=wikt status=guess, src=wikt
lin candidateMasc_N = kandidat_N | kandidatin_N ; -- status=guess status=guess
lin track_N = mkN "Fußspur" feminine ; -- status=guess
lin safe_A = wohlbehalten_A | ganz_A ; -- status=guess status=guess
lin interested_A = interessiert_A ; -- status=guess
lin assessment_N = bewertung_N | mkN "Schätzung" feminine ; -- status=guess status=guess
lin path_N = weg_N ; -- status=guess
lin merely_Adv = mkAdv "bloß" | lediglich_Adv | mkAdv "nur" | mkAdv "schier" ; -- status=guess status=guess status=guess status=guess
lin plus_Prep = variants{} ; -- 
lin district_N = bezirk_N ; -- status=guess
lin regular_A = mkA "regelmäßig" ; -- status=guess
lin reaction_N = reaktion_N ; -- status=guess
lin impact_N = belastung_N | mkN "Stoß" masculine | mkN "Druck" masculine ; -- status=guess status=guess status=guess
lin collect_V2 = mkV2 (sammeln_V) | mkV2 (mkV "anhäufen") ; -- status=guess, src=wikt status=guess, src=wikt
lin collect_V = sammeln_V | mkV "anhäufen" ; -- status=guess, src=wikt status=guess, src=wikt
lin debate_N = debatte_N ; -- status=guess
lin lay_V2 = mkV2 (mkV "offenlegen") ; -- status=guess, src=wikt
lin lay_V = mkV "offenlegen" ; -- status=guess, src=wikt
lin rise_N = mkN "aufstehen" ; -- status=guess
lin belief_N = mkN "Glauben" masculine ; -- status=guess
lin conclusion_N = mkN "Schlussfolgerung" feminine ; -- status=guess
lin shape_N = form_N ; -- status=guess
lin vote_N = stimme_N | votum_N ; -- status=guess status=guess
lin aim_N = ziel_N ; -- status=guess
lin politics_N = politik_N ; -- status=guess
lin reply_VS = mkVS (antworten_V) | mkVS (erwidern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin reply_V = antworten_V | erwidern_V ; -- status=guess, src=wikt status=guess, src=wikt
lin press_V2V = mkV2V (mkV "drücken") ; -- status=guess, src=wikt
lin press_V2 = mkV2 (mkV "drücken") ; -- status=guess, src=wikt
lin press_V = mkV "drücken" ; -- status=guess, src=wikt
lin approach_V2 = mkV2 (mkReflV "nähern") ; -- status=guess, src=wikt
lin approach_V = mkReflV "nähern" ; -- status=guess, src=wikt
lin file_N = kartei_N | datei_N | akte_N ; -- status=guess status=guess status=guess
lin western_A = westlich_A | mkA "West-" ; -- status=guess status=guess
lin earth_N = L.earth_N ;
lin public_N = mkN "Publikum" neuter | mkN "Öffentlichkeit" feminine ; -- status=guess status=guess
lin survive_V2 = mkV2 (mkV "überleben") ; -- status=guess, src=wikt
lin survive_V = mkV "überleben" ; -- status=guess, src=wikt
lin estate_N = gut_N | landgut_N ; -- status=guess status=guess
lin boat_N = L.boat_N ;
lin prison_N = mkN "Haft" feminine | gefangenschaft_N ; -- status=guess status=guess
lin additional_A = mkA "zusätzlich" ; -- status=guess
lin settle_V2 = mkV2 (mkV "siedeln") ; -- status=guess, src=wikt
lin settle_V = mkV "siedeln" ; -- status=guess, src=wikt
lin largely_Adv = variants{} ; -- 
lin wine_N = L.wine_N ;
lin observe_VS = mkVS (bemerken_V) ; -- status=guess, src=wikt
lin observe_V2 = mkV2 (bemerken_V) ; -- status=guess, src=wikt
lin limit_V2V = mkV2V (befristen_V) | mkV2V (begrenzen_V) | mkV2V (mkV "beschränken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin limit_V2 = mkV2 (befristen_V) | mkV2 (begrenzen_V) | mkV2 (mkV "beschränken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin deny_V3 = mkV3 (leugnen_V) | mkV3 (mkV "bestreiten") | mkV3 (dementieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin deny_V2 = mkV2 (leugnen_V) | mkV2 (mkV "bestreiten") | mkV2 (dementieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin for_PConj = variants{} ; -- 
lin straight_Adv = geradeaus_Adv ; -- status=guess
lin somebody_NP = S.somebody_NP ;
lin writer_N = schriftsteller_N | schriftstellerin_N | autor_N | autorin_N | schreiber_N | mkN "Schreiberin" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin weekend_N = wochenende_N ; -- status=guess
lin clothes_N = kleidung_N | mkN "Klamotten {f} {p}" ; -- status=guess status=guess
lin active_A = mkA "rührig" ; -- status=guess
lin sight_N = mkN "Sehvermögen" | mkN "Sehen" neuter ; -- status=guess status=guess
lin video_N = video_N ; -- status=guess
lin reality_N = mkN "Realität" feminine ; -- status=guess
lin hall_N = studentenwohnheim_N ; -- status=guess
lin nevertheless_Adv = mkAdv "nichtsdestoweniger" | trotzdem_Adv ; -- status=guess status=guess
lin regional_A = regional_A ; -- status=guess
lin vehicle_N = fahrzeug_N | mkN "Gefährt" neuter ; -- status=guess status=guess
lin worry_VS = variants{} ; -- 
lin worry_V2 = variants{} ; -- 
lin worry_V = variants{} ; -- 
lin powerful_A = variants{} ; -- 
lin possibly_Adv = variants{} ; -- 
lin cross_V2 = mkV2 (kreuzen_5_V) ; -- status=guess, src=wikt
lin cross_V = kreuzen_5_V ; -- status=guess, src=wikt
lin colleague_N = kollege_N | mkN "Kollegin" feminine | mitarbeiter_N | mitarbeiterin_N ; -- status=guess status=guess status=guess status=guess
lin charge_V2 = variants{} ; -- 
lin charge_V = variants{} ; -- 
lin lead_N = mkN "Führung" feminine ; -- status=guess
lin farm_N = bauernhof_N | farm_N ; -- status=guess status=guess
lin respond_VS = variants{} ; -- 
lin respond_V = variants{} ; -- 
lin employer_N = arbeitgeber_N | mkN "Arbeitgeberin" feminine ; -- status=guess status=guess
lin carefully_Adv = mkAdv "vorsichtig" ; -- status=guess
lin understanding_N = vereinbarung_N ; -- status=guess
lin connection_N = verbindung_N ; -- status=guess
lin comment_N = kommentar_N ; -- status=guess
lin grant_V3 = mkV3 (mkV "bewilligen") ; -- status=guess, src=wikt
lin grant_V2 = mkV2 (mkV "bewilligen") ; -- status=guess, src=wikt
lin concentrate_V2 = mkV2 (mkReflV "konzentrieren") ; -- status=guess, src=wikt
lin concentrate_V = mkReflV "konzentrieren" ; -- status=guess, src=wikt
lin ignore_V2 = mkV2 (ignorieren_V) | mkV2 (missachten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin ignore_V = ignorieren_V | missachten_V ; -- status=guess, src=wikt status=guess, src=wikt
lin phone_N = telefon__N | telephon_N | fernsprecher_N ; -- status=guess status=guess status=guess
lin hole_N = loch_N ; -- status=guess
lin insurance_N = versicherung_N ; -- status=guess
lin content_N = inhalt_N ; -- status=guess
lin confidence_N = zuversicht_N ; -- status=guess
lin sample_N = probe_N | muster_N ; -- status=guess status=guess
lin transport_N = mkN "Beförderung" feminine ; -- status=guess
lin objective_N = ziel_N ; -- status=guess
lin alone_A = variants{} ; -- 
lin flower_N = L.flower_N ;
lin injury_N = verletzung_N | wunde_N | verwundung_N ; -- status=guess status=guess status=guess
lin lift_V2 = mkV2 (junkV (mkV "Finger") "krumm machen") ; -- status=guess, src=wikt
lin lift_V = junkV (mkV "Finger") "krumm machen" ; -- status=guess, src=wikt
lin stick_V2 = mkV2 (auffallen_0_V) ; -- status=guess, src=wikt
lin stick_V = auffallen_0_V ; -- status=guess, src=wikt
lin front_A = variants{} ; -- 
lin mainly_Adv = mkAdv "hauptsächlich" ; -- status=guess
lin battle_N = streitaxt_N ; -- status=guess
lin generation_N = generation_N ; -- status=guess
lin currently_Adv = mkAdv "momentan" | mkAdv "zur Zeit" | zurzeit_Adv ; -- status=guess status=guess status=guess
lin winter_N = winter_N ; -- status=guess
lin inside_Prep = variants{} ; -- 
lin impossible_A = mkA "unmöglich" ; -- status=guess
lin somewhere_Adv = S.somewhere_Adv ;
lin arrange_V2 = mkV2 (einrichten_4_V) ; -- status=guess, src=wikt
lin arrange_V = einrichten_4_V ; -- status=guess, src=wikt
lin will_N = wille_N ; -- status=guess
lin sleep_V = L.sleep_V ;
lin progress_N = fortschritt_N ; -- status=guess
lin volume_N = jahrgang_N ; -- status=guess
lin ship_N = L.ship_N ;
lin legislation_N = gesetz_N ; -- status=guess
lin commitment_N = mkN "Einweisung" feminine ; -- status=guess
lin enough_Predet = variants{} ; -- 
lin conflict_N = konflikt_N | streit_N ; -- status=guess status=guess
lin bag_N = beutel_N | tasche_N | mkN "Tüte" feminine | sack_N ; -- status=guess status=guess status=guess status=guess
lin fresh_A = frisch_A ; -- status=guess
lin entry_N = eintritt_N ; -- status=guess
lin entry_2_N = variants{} ; -- 
lin entry_1_N = variants{} ; -- 
lin smile_N = mkN "Lächeln" neuter ; -- status=guess
lin fair_A = mkA "den Umständen entsprechend" | angebracht_A | mkA "erträglich" | ganz_A ; -- status=guess status=guess status=guess status=guess
lin promise_VV = mkVV (versprechen_V) ; -- status=guess, src=wikt
lin promise_VS = mkVS (versprechen_V) ; -- status=guess, src=wikt
lin promise_V2 = mkV2 (versprechen_V) ; -- status=guess, src=wikt
lin promise_V = versprechen_V ; -- status=guess, src=wikt
lin introduction_N = mkN "Einführung" feminine ; -- status=guess
lin senior_A = mkA "älter" ; -- status=guess
lin manner_N = manier_N ; -- status=guess
lin background_N = mkN "Schreibtischhintergrund" masculine ; -- status=guess
lin key_N = taste_N ; -- status=guess
lin key_2_N = variants{} ; -- 
lin key_1_N = variants{} ; -- 
lin touch_V2 = mkV2 (mkV "berühren") ; -- status=guess, src=wikt
lin touch_V = mkV "berühren" ; -- status=guess, src=wikt
lin vary_V2 = mkV2 (mkReflV "ändern") | mkV2 (variieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin vary_V = mkReflV "ändern" | variieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin sexual_A = sexuell_A ; -- status=guess
lin ordinary_A = mkA "gewöhnlich" | mkA "ordinär" ; -- status=guess status=guess
lin cabinet_N = kabinett_N ; -- status=guess
lin painting_N = mkN "Gemälde" neuter ; -- status=guess
lin entirely_Adv = variants{} ; -- 
lin engine_N = mkN "Motorblock" masculine ; -- status=guess
lin previously_Adv = zuvor_Adv | vorher_Adv | mkAdv "früher" | ehemals_Adv ; -- status=guess status=guess status=guess status=guess
lin administration_N = verabreichung_N ; -- status=guess
lin tonight_Adv = heute_Adv ; -- status=guess
lin adult_N = mkN "Erwachsener" masculine | erwachsene_N ; -- status=guess status=guess
lin prefer_VV = mkVV (vorziehen_6_V) | mkVV (bevorzugen_V) | mkVV (mkV "präferieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prefer_V2 = mkV2 (vorziehen_6_V) | mkV2 (bevorzugen_V) | mkV2 (mkV "präferieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin author_N = autor_N | autorin_N ; -- status=guess status=guess
lin actual_A = mkA "tatsächlich" ; -- status=guess
lin song_N = L.song_N ;
lin investigation_N = untersuchung_N ; -- status=guess
lin debt_N = schuld_N | mkN "Verbindlichkeit" feminine | verpflichtung_N ; -- status=guess status=guess status=guess
lin visitor_N = besucher_N | mkN "Besucherin" feminine | gast_N | mkN "Gästin" feminine ; -- status=guess status=guess status=guess status=guess
lin forest_N = wald_N | forst_N | mkN "Gehölz" neuter | hain_N ; -- status=guess status=guess status=guess status=guess
lin repeat_VS = mkVS (wiederholen_V) ; -- status=guess, src=wikt
lin repeat_V2 = mkV2 (wiederholen_V) ; -- status=guess, src=wikt
lin repeat_V = wiederholen_V ; -- status=guess, src=wikt
lin wood_N = L.wood_N ;
lin contrast_N = kontrast_N ; -- status=guess
lin extremely_Adv = mkAdv "extrem" | mkAdv "äußerst" | mkAdv "krass" ; -- status=guess status=guess status=guess
lin wage_N = lohn_N ; -- status=guess
lin domestic_A = variants{} ; -- 
lin commit_V2 = mkV2 (begehen_V) ; -- status=guess, src=wikt
lin threat_N = drohung_N ; -- status=guess
lin bus_N = bus_N ; -- status=guess
lin warm_A = L.warm_A ;
lin sir_N = herr_N | mkN "mein Herr" masculine ; -- status=guess status=guess
lin regulation_N = mkN "Regeln" neuter ; -- status=guess
lin drink_N = mkN "trinken" ; -- status=guess
lin relief_N = mkN "Relief" neuter ; -- status=guess
lin internal_A = intern_A | mkA "innerlich" | mkA "inländisch" ; -- status=guess status=guess status=guess
lin strange_A = seltsam_A ; -- status=guess
lin excellent_A = ausgezeichnet_A | hervorragend_A | mkA "großartig" ; -- status=guess status=guess status=guess
lin run_N = lauf_N ; -- status=guess
lin fairly_Adv = mkAdv "gerecht" ; -- status=guess
lin technical_A = technisch_A | fachlich_A ; -- status=guess status=guess
lin tradition_N = tradition_N | mkN "Überlieferung" feminine | mkN "" | mkN "early] Urüberlieferung" feminine ; -- status=guess status=guess status=guess status=guess
lin measure_V2 = mkV2 (messen_4_V) ; -- status=guess, src=wikt
lin measure_V = messen_4_V ; -- status=guess, src=wikt
lin insist_VS = mkVS (junkV (mkV "]") "etwas] bestehen") ; -- status=guess, src=wikt
lin insist_V2 = mkV2 (junkV (mkV "]") "etwas] bestehen") ; -- status=guess, src=wikt
lin insist_V = junkV (mkV "]") "etwas] bestehen" ; -- status=guess, src=wikt
lin farmer_N = landwirt_N | mkN "Landwirtin" feminine | bauer_N | mkN "Bäuerin" feminine | mkN "Farmer" masculine | mkN "Farmerin" feminine | mkN "" | mkN "plants] Züchter" masculine | mkN "Züchterin" feminine | mkN "Landmann" masculine | mkN "Landfrau" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin until_Prep = variants{} ; -- 
lin traffic_N = mkN "Verkehrsberuhigung" feminine ; -- status=guess
lin dinner_N = mkN "Futter" neuter ; -- status=guess
lin consumer_N = konsument_N | verbraucher_N ; -- status=guess status=guess
lin meal_N = mehl_N ; -- status=guess
lin warn_VS = mkVS (warnen_V) | mkVS (mkV "verständigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin warn_V2V = mkV2V (warnen_V) | mkV2V (mkV "verständigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin warn_V2 = mkV2 (warnen_V) | mkV2 (mkV "verständigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin warn_V = warnen_V | mkV "verständigen" ; -- status=guess, src=wikt status=guess, src=wikt
lin living_A = lebend_A ; -- status=guess
lin package_N = paket_N ; -- status=guess
lin half_N = mkN "Hälfte" feminine ; -- status=guess
lin increasingly_Adv = mkAdv "zunehmend" ; -- status=guess
lin description_N = beschreibung_N ; -- status=guess
lin soft_A = sanft_A ; -- status=guess
lin stuff_N = mkN "Sachen {p}" | mkN "Kram" masculine ; -- status=guess status=guess
lin award_V3 = variants{} ; -- 
lin award_V2 = variants{} ; -- 
lin existence_N = existenz_N | mkN "Sein" neuter ; -- status=guess status=guess
lin improvement_N = verbesserung_N ; -- status=guess
lin coffee_N = kaffeebohne_N ; -- status=guess
lin appearance_N = mkN "Aussehen" neuter ; -- status=guess
lin standard_A = variants{} ; -- 
lin attack_V2 = mkV2 (angreifen_V) | mkV2 (attackieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin sheet_N = schicht_N ; -- status=guess
lin category_N = kategorie_N ; -- status=guess
lin distribution_N = distribution_N | verbreitung_N | mkN "Austeilung" feminine ; -- status=guess status=guess status=guess
lin equally_Adv = mkAdv "gleichermaßen" | mkAdv "gleich" | mkAdv "gleichmäßig" ; -- status=guess status=guess status=guess
lin session_N = sitzung_N ; -- status=guess
lin cultural_A = kulturell_A ; -- status=guess
lin loan_N = anleihe_N | darlehen_N ; -- status=guess status=guess
lin bind_V2 = mkV2 (verbinden_V) | mkV2 (mkV "konnektieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin bind_V = verbinden_V | mkV "konnektieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin museum_N = museum_N ; -- status=guess
lin conversation_N = konversation_N | unterhaltung_N | mkN "Gespräch" neuter ; -- status=guess status=guess status=guess
lin threaten_VV = mkVV (drohen_V) | mkVV (bedrohen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin threaten_VS = mkVS (drohen_V) | mkVS (bedrohen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin threaten_V2 = mkV2 (drohen_V) | mkV2 (bedrohen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin threaten_V = drohen_V | bedrohen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin link_N = link_N | mkN "Hyperlink" masculine ; -- status=guess status=guess
lin launch_V2 = mkV2 (mkV "abschießen") | mkV2 (lancieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin launch_V = mkV "abschießen" | lancieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin proper_A = eigen_A ; -- status=guess
lin victim_N = opfer_N ; -- status=guess
lin audience_N = audienz_N ; -- status=guess
lin famous_A = mkA "berühmt" ; -- status=guess
lin master_N = meister_N ; -- status=guess
lin master_2_N = variants{} ; -- 
lin master_1_N = variants{} ; -- 
lin lip_N = mkN "Lippenbalsam" masculine | mkN "Lippencreme" feminine ; -- status=guess status=guess
lin religious_A = mkA "religiös" | mkA "gläubig" ; -- status=guess status=guess
lin joint_A = mkA "gemeinsamer" ; -- status=guess
lin cry_V2 = mkV2 (schreien_V) ; -- status=guess, src=wikt
lin cry_V = schreien_V ; -- status=guess, src=wikt
lin potential_A = mkA "möglich" | potenziell_A | potentiell_A ; -- status=guess status=guess status=guess
lin broad_A = L.broad_A ;
lin exhibition_N = ausstellung_N ; -- status=guess
lin experience_V2 = mkV2 (erfahren_V) | mkV2 (erleben_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin judge_N = richter_N | richterin_N ; -- status=guess status=guess
lin formal_A = formal_A | formell_A ; -- status=guess status=guess
lin housing_N = variants{} ; -- 
lin past_Prep = variants{} ; -- 
lin concern_V2 = variants{} ; -- 
lin freedom_N = freiheit_N ; -- status=guess
lin gentleman_N = herr_N ; -- status=guess
lin attract_V2 = mkV2 (anziehen_0_V) ; -- status=guess, src=wikt
lin explanation_N = mkN "Erklärung" feminine ; -- status=guess
lin appoint_V3 = variants{} ; -- 
lin appoint_V2V = variants{} ; -- 
lin appoint_V2 = variants{} ; -- 
lin note_VS = variants{} ; -- 
lin note_V2 = variants{} ; -- 
lin note_V = variants{} ; -- 
lin chief_A = mkA "hauptsächlich" | mkA "primär" ; -- status=guess status=guess
lin total_N = mkN "Gesamtbetrag" masculine | mkN "Gesamtsumme" feminine ; -- status=guess status=guess
lin lovely_A = lieblich_A ; -- status=guess
lin official_A = offiziell_A | amtlich_A | mkA "dienstlich" ; -- status=guess status=guess status=guess
lin date_V2 = mkV2 (mkV "datieren") ; -- status=guess, src=wikt
lin date_V = mkV "datieren" ; -- status=guess, src=wikt
lin demonstrate_VS = mkVS (demonstrieren_V) ; -- status=guess, src=wikt
lin demonstrate_V2 = mkV2 (demonstrieren_V) ; -- status=guess, src=wikt
lin demonstrate_V = demonstrieren_V ; -- status=guess, src=wikt
lin construction_N = konstruktion_N ; -- status=guess
lin middle_N = mittelpunkt_N ; -- status=guess
lin yard_N = hof_N ; -- status=guess
lin unable_A = mkA "unfähig" ; -- status=guess
lin acquire_V2 = mkV2 (erwerben_V) | mkV2 (akquirieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin surely_Adv = sicherlich_Adv ; -- status=guess
lin crisis_N = krise_N ; -- status=guess
lin propose_VV = mkVV (einen_V) ; -- status=guess, src=wikt
lin propose_VS = mkVS (einen_V) ; -- status=guess, src=wikt
lin propose_V2 = mkV2 (einen_V) ; -- status=guess, src=wikt
lin propose_V = einen_V ; -- status=guess, src=wikt
lin west_N = mkN "West" masculine | mkN "Westen" masculine ; -- status=guess status=guess
lin impose_V2 = mkV2 (mkV "auferlegen") ; -- status=guess, src=wikt
lin impose_V = mkV "auferlegen" ; -- status=guess, src=wikt
lin market_V2 = mkV2 (mkV "vermarkten") ; -- status=guess, src=wikt
lin market_V = mkV "vermarkten" ; -- status=guess, src=wikt
lin care_V = sorgen_V | mkReflV "sorgen" | mkReflV "kümmern" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin god_N = gott_N | mkN "Göttin" feminine | gottheit_N | mkN "Götter {p}" ; -- status=guess status=guess status=guess status=guess
lin favour_N = variants{} ; -- 
lin before_Adv = zuvor_Adv ; -- status=guess
lin name_V3 = mkV3 (ernennen_V) ; -- status=guess, src=wikt
lin name_V2 = mkV2 (ernennen_V) ; -- status=guess, src=wikt
lin equal_A = gleich_A ; -- status=guess
lin capacity_N = mkN "Kapazität" feminine ; -- status=guess
lin flat_N = mkN "Schiebermütze" feminine ; -- status=guess
lin selection_N = mkN "Anwahl" feminine | auswahl_N | wahl_N | aufruf_N | mkN "Aussonderung" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin alone_Adv = mkAdv "allein" | mkAdv "einsam" ; -- status=guess status=guess
lin football_N = mkN "Fußball" masculine | fussball_N ; -- status=guess status=guess
lin victory_N = sieg_N ; -- status=guess
lin factory_N = L.factory_N ;
lin rural_A = mkA "ländlich" | mkA "dörflich" ; -- status=guess status=guess
lin twice_Adv = zweimal_Adv ; -- status=guess
lin sing_V2 = mkV2 (singen_V) ; -- status=guess, src=wikt
lin sing_V = L.sing_V ;
lin whereas_Subj = variants{} ; -- 
lin own_V2 = mkV2 (eingestehen_V) | mkV2 (zugeben_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin head_V2 = mkV2 (mkV "ansteuern") | mkV2 (junkV (mkV "in") "eine Richtung gehen") | mkV2 (junkV (mkV "auf") "etwas zusteuern") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin head_V = mkV "ansteuern" | junkV (mkV "in") "eine Richtung gehen" | junkV (mkV "auf") "etwas zusteuern" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin examination_N = mkN "Prüfung" feminine | mkN "Test" masculine | mkN "Überprüfung" feminine | erprobung_N | versuch_N | mkN "Examen" neuter ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin deliver_V2 = mkV2 (liefern_4_V) | mkV2 (mkV "abliefern") ; -- status=guess, src=wikt status=guess, src=wikt
lin deliver_V = liefern_4_V | mkV "abliefern" ; -- status=guess, src=wikt status=guess, src=wikt
lin nobody_NP = S.nobody_NP ;
lin substantial_A = wesentlich_A ; -- status=guess
lin invite_V2V = mkV2V (einladen_5_V) ; -- status=guess, src=wikt
lin invite_V2 = mkV2 (einladen_5_V) ; -- status=guess, src=wikt
lin intention_N = absicht_N ; -- status=guess
lin egg_N = L.egg_N ;
lin reasonable_A = mkA "vernünftig" | mkA "anständig" ; -- status=guess status=guess
lin onto_Prep = variants{} ; -- 
lin retain_V2 = mkV2 (festhalten_1_V) ; -- status=guess, src=wikt
lin aircraft_N = luftfahrzeug_N ; -- status=guess
lin decade_N = jahrzehnt_N | dekade_N ; -- status=guess status=guess
lin cheap_A = billig_A | preiswert_A | mkA "preisgünstig" ; -- status=guess status=guess status=guess
lin quiet_A = still_A ; -- status=guess
lin bright_A = heiter_A ; -- status=guess
lin contribute_V2 = mkV2 (beisteuern_V) | mkV2 (beitragen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin contribute_V = beisteuern_V | beitragen_7_V ; -- status=guess, src=wikt status=guess, src=wikt
lin row_N = aufruhr_N | mkN "Donnerwetter" neuter | mkN "Klamauk" masculine | krach__N | mkN "Krakeel" masculine | krawall_N | mkN "Lärm" masculine | mkN "Rabatz" masculine | radau_N | spektakel_N | mkN "Tumult" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin search_N = suche_N ; -- status=guess
lin limit_N = grenze_N | mkN "Begrenzer" masculine ; -- status=guess status=guess
lin definition_N = mkN "Begriffserklärung" feminine | mkN "Definierung" feminine ; -- status=guess status=guess
lin unemployment_N = mkN "Arbeitslosigkeit" feminine ; -- status=guess
lin spread_V2 = mkV2 (mkReflV "wie ein Lauffeuer verbreiten") ; -- status=guess, src=wikt
lin spread_V = mkReflV "wie ein Lauffeuer verbreiten" ; -- status=guess, src=wikt
lin mark_N = note_N ; -- status=guess
lin flight_N = flucht_N ; -- status=guess
lin account_V2 = variants{} ; -- 
lin account_V = variants{} ; -- 
lin output_N = variants{} ; -- 
lin last_V = dauern_7_V | aushalten_3_V ; -- status=guess, src=wikt status=guess, src=wikt
lin tour_N = mkN "Meisterstück" ; -- status=guess
lin address_N = mkN "verbaler Antrag" masculine ; -- status=guess
lin immediate_A = unmittelbar_A | mkA "immediat" ; -- status=guess status=guess
lin reduction_N = reduktion_N | mkN "Reduzierung" feminine ; -- status=guess status=guess
lin interview_N = mkN "Vorstellungsgespräch" neuter | interview_N ; -- status=guess status=guess
lin assess_V2 = variants{} ; -- 
lin promote_V2 = mkV2 (mkV "befördern") | mkV2 (promovieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin promote_V = mkV "befördern" | promovieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin everybody_NP = S.everybody_NP ;
lin suitable_A = geeignet_A ; -- status=guess
lin growing_A = variants{} ; -- 
lin nod_V = mkV "einnicken" ; -- status=guess, src=wikt
lin reject_V2 = mkV2 (verwerfen_V) | mkV2 (ablehnen_V) | mkV2 (mkV "zurückweisen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin while_N = mkN "Weile" feminine | mkN "Weilchen {n} diminutive" | zeitspanne_N ; -- status=guess status=guess status=guess
lin high_Adv = variants{} ; -- 
lin dream_N = traum_N | wunsch_N ; -- status=guess status=guess
lin vote_VV = mkVV (mkV "wählen") | mkVV (stimmen_3_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin vote_V3 = variants{}; -- mkV2 (mkV "wählen") | mkV2 (stimmen_3_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin vote_V2 = mkV2 (mkV "wählen") | mkV2 (stimmen_3_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin vote_V = mkV "wählen" | stimmen_3_V ; -- status=guess, src=wikt status=guess, src=wikt
lin divide_V2 = mkV2 (junkV (mkV "teile") "und herrsche") ; -- status=guess, src=wikt
lin divide_V = junkV (mkV "teile") "und herrsche" ; -- status=guess, src=wikt
lin declare_VS = mkVS (mkV "verzollen") ; -- status=guess, src=wikt
lin declare_V2 = mkV2 (mkV "verzollen") ; -- status=guess, src=wikt
lin declare_V = mkV "verzollen" ; -- status=guess, src=wikt
lin handle_V2 = mkV2 (junkV (mkV "mit") "Samthandschuhen anfassen") ; -- status=guess, src=wikt
lin handle_V = junkV (mkV "mit") "Samthandschuhen anfassen" ; -- status=guess, src=wikt
lin detailed_A = detailliert_A ; -- status=guess
lin challenge_N = herausforderung_N ; -- status=guess
lin notice_N = benachrichtigung_N | mitteilung_N ; -- status=guess status=guess
lin rain_N = L.rain_N ;
lin destroy_V2 = mkV2 (mkV "zerstören") | mkV2 (vernichten_V) | mkV2 (kaputtmachen_5_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mountain_N = L.mountain_N ;
lin concentration_N = konzentration_N ; -- status=guess
lin limited_A = begrenzt_A ; -- status=guess
lin finance_N = finanz_N | mkN "Finanzen {f} {p}" | mkN "Geldwesen" neuter ; -- status=guess status=guess status=guess
lin pension_N = pension_N ; -- status=guess
lin influence_V2 = mkV2 (beeinflussen_V) ; -- status=guess, src=wikt
lin afraid_A = mkA "ängstlich" ; -- status=guess
lin murder_N = mord_N ; -- status=guess
lin neck_N = L.neck_N ;
lin weapon_N = waffe_N ; -- status=guess
lin hide_V2 = mkV2 (junkV (mkV "sein") "Licht unter den Scheffel stellen") ; -- status=guess, src=wikt
lin hide_V = junkV (mkV "sein") "Licht unter den Scheffel stellen" ; -- status=guess, src=wikt
lin offence_N = variants{} ; -- 
lin absence_N = abwesenheit_N ; -- status=guess
lin error_N = mkN "Fehlerbalken" masculine ; -- status=guess
lin representativeMasc_N = mkN "Repräsentant" masculine ; -- status=guess
lin enterprise_N = mkN "Unternehmensanwendungsintegration" feminine ; -- status=guess
lin criticism_N = kritik_N ; -- status=guess
lin average_A = durchschnittlich_A ; -- status=guess
lin quick_A = quicklebendig_A ; -- status=guess
lin sufficient_A = ausreichend_A | mkA "genügend" | hinreichend_A ; -- status=guess status=guess status=guess
lin appointment_N = mkN "Ernennung" feminine | berufung_N ; -- status=guess status=guess
lin match_V2 = mkV2 (mkV "übereinstimmen") | mkV2 (passen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin transfer_V = mkV "übertragen" ; -- status=guess, src=wikt
lin acid_N = mkN "Lysergsäure-diethylamid" ; -- status=guess
lin spring_N = mkN "Frühjahrsputz" ; -- status=guess
lin birth_N = geburt_N ; -- status=guess
lin ear_N = L.ear_N ;
lin recognize_VS = mkVS (erkennen_2_V) | mkVS (wiedererkennen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin recommend_V2V = mkV2V (empfehlen_V) ; -- status=guess, src=wikt
lin recommend_V2 = mkV2 (empfehlen_V) ; -- status=guess, src=wikt
lin module_N = modul_N ; -- status=guess
lin instruction_N = mkN "Unterricht" masculine ; -- status=guess
lin democratic_A = demokratisch_A ; -- status=guess
lin park_N = mkN "Park" masculine ; -- status=guess
lin weather_N = wetter_N ; -- status=guess
lin bottle_N = flasche_N ; -- status=guess
lin address_V2 = mkV2 (mkReflV "vorbereiten") ; -- status=guess, src=wikt
lin bedroom_N = schlafzimmer_N ; -- status=guess
lin kid_N = kind_N ; -- status=guess
lin pleasure_N = mkN "Vergnügen" neuter ; -- status=guess
lin realize_VS = mkVS (erkennen_2_V) | mkVS (realisieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin realize_V2 = mkV2 (erkennen_2_V) | mkV2 (realisieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin assembly_N = versammlung_N ; -- status=guess
lin expensive_A = teuer_A ; -- status=guess
lin select_VV = mkVV (mkV "auswählen") ; -- status=guess, src=wikt
lin select_V2V = mkV2V (mkV "auswählen") ; -- status=guess, src=wikt
lin select_V2 = mkV2 (mkV "auswählen") ; -- status=guess, src=wikt
lin select_V = mkV "auswählen" ; -- status=guess, src=wikt
lin teaching_N = lehre_N ; -- status=guess
lin desire_N = begehren_N ; -- status=guess
lin whilst_Subj = variants{} ; -- 
lin contact_V2 = mkV2 (kontaktieren_V) ; -- status=guess, src=wikt
lin implication_N = folge_N | mkN "Schlussfolgerung" feminine ; -- status=guess status=guess
lin combine_VV = mkVV (kombinieren_V) | mkVV (verbinden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin combine_V2 = mkV2 (kombinieren_V) | mkV2 (verbinden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin combine_V = kombinieren_V | verbinden_V ; -- status=guess, src=wikt status=guess, src=wikt
lin temperature_N = temperatur_N ; -- status=guess
lin wave_N = welle_N | wirbel_N ; -- status=guess status=guess
lin magazine_N = magazin_N ; -- status=guess
lin totally_Adv = variants{} ; -- 
lin mental_A = geistig_A | mental_A | psychisch_A | seelisch_A ; -- status=guess status=guess status=guess status=guess
lin used_A = mkA "gewöhnt" ; -- status=guess
lin store_N = mkN "Lager" neuter | speicher_N ; -- status=guess status=guess
lin scientific_A = wissenschaftlich_A ; -- status=guess
lin frequently_Adv = mkAdv "häufig" ; -- status=guess
lin thanks_N = mkN "Dank" masculine | mkN "Danksagung" feminine ; -- status=guess status=guess
lin beside_Prep = variants{} ; -- 
lin settlement_N = ansiedlung_N | siedlung_N | mkN "Niederlassung" feminine | kolonie_N ; -- status=guess status=guess status=guess status=guess
lin absolutely_Adv = variants{} ; -- 
lin critical_A = kritisch_A ; -- status=guess
lin critical_2_A = variants{} ; -- 
lin critical_1_A = variants{} ; -- 
lin recognition_N = anerkennung_N ; -- status=guess
lin touch_N = mkN "Berührung" feminine ; -- status=guess
lin consist_V = bestehen_V ; -- status=guess, src=wikt
lin below_Prep = variants{} ; -- 
lin silence_N = mkN "Schweigen" neuter ; -- status=guess
lin expenditure_N = aufwand_N ; -- status=guess
lin institute_N = institut_N ; -- status=guess
lin dress_V2 = mkV2 (mkV "kleiden") | mkV2 (mkV "ankleiden") | mkV2 (anziehen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dress_V = mkV "kleiden" | mkV "ankleiden" | anziehen_0_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dangerous_A = mkA "gefährlich" ; -- status=guess
lin familiar_A = bekannt_A ; -- status=guess
lin asset_N = mkN "Aktiva {n} {p}" | mkN "Vermögenswert" feminine ; -- status=guess status=guess
lin educational_A = variants{} ; -- 
lin sum_N = summe_N ; -- status=guess
lin publication_N = mkN "Veröffentlichung" feminine ; -- status=guess
lin partly_Adv = teilweise_Adv ; -- status=guess
lin block_N = mkN "Block" masculine | klotz_N ; -- status=guess status=guess
lin seriously_Adv = mkAdv "ernst" | mkAdv "ernsthaft" ; -- status=guess status=guess
lin youth_N = jugendherberge_N ; -- status=guess
lin tape_N = mkN "Klebeband" neuter ; -- status=guess
lin elsewhere_Adv = woanders_Adv | anderswo_Adv ; -- status=guess status=guess
lin cover_N = mkN "Einband" masculine | umschlag_N ; -- status=guess status=guess
lin fee_N = mkN "Gebühr" feminine ; -- status=guess
lin program_N = programm_N ; -- status=guess
lin treaty_N = vertrag_N | mkN "Bündnis" neuter ; -- status=guess status=guess
lin necessarily_Adv = notwendigerweise_Adv | mkAdv "very rare: nötig" ; -- status=guess status=guess
lin unlikely_A = unwahrscheinlich_A ; -- status=guess
lin properly_Adv = mkAdv "ordnungsgemäß" | mkAdv "ordentlich" | mkAdv "richtig" ; -- status=guess status=guess status=guess
lin guest_N = gast_N ; -- status=guess
lin code_N = gesetzbuch_N ; -- status=guess
lin hill_N = L.hill_N ;
lin screen_N = schirm_N ; -- status=guess
lin household_N = haushalt_N ; -- status=guess
lin sequence_N = folge_N ; -- status=guess
lin correct_A = L.correct_A ;
lin female_A = weiblich_A ; -- status=guess
lin phase_N = mkN "Phasendiagramm" neuter ; -- status=guess
lin crowd_N = mkN "Gedränge" neuter ; -- status=guess
lin welcome_V2 = mkV2 (junkV (mkV "willkommen") "heißen") | mkV2 (mkV "begrüßen") ; -- status=guess, src=wikt status=guess, src=wikt
lin metal_N = metall_N ; -- status=guess
lin human_N = mensch_N ; -- status=guess
lin widely_Adv = mkAdv "breit" ; -- status=guess
lin undertake_V2 = mkV2 (mkReflV "verpflichten") ; -- status=guess, src=wikt
lin cut_N = mkN "schneiden" masculine ; -- status=guess
lin sky_N = L.sky_N ;
lin brain_N = mkN "Verstand" masculine | mkN "Köpfchen" neuter | mkN "Grips" masculine | hirn_N ; -- status=guess status=guess status=guess status=guess
lin expert_N = experte_N ; -- status=guess
lin experiment_N = experiment_N | versuch_N ; -- status=guess status=guess
lin tiny_A = winzig_A ; -- status=guess
lin perfect_A = perfekt_A | vollkommen_A ; -- status=guess status=guess
lin disappear_V = junkV (mkV "zum") "Verschwinden bringen" | verschwinden_V ; -- status=guess, src=wikt status=guess, src=wikt
lin initiative_N = initiative_N ; -- status=guess
lin assumption_N = himmelfahrt_N | auffahrt_N ; -- status=guess status=guess
lin photograph_N = fotografie_N | mkN "Fotographie" feminine | foto_N | mkN "Lichtbild" neuter ; -- status=guess status=guess status=guess status=guess
lin ministry_N = ministerium_N ; -- status=guess
lin congress_N = kongress_N ; -- status=guess
lin transfer_N = mkN "Übertragung" feminine | versetzung_N | mkN "Überweisung" feminine ; -- status=guess status=guess status=guess
lin reading_N = mkN "Lesen" neuter ; -- status=guess
lin scientist_N = wissenschaftler_N | wissenschaftlerin_N ; -- status=guess status=guess
lin fast_Adv = mkAdv "fest" ; -- status=guess
lin fast_A = schnell_A | geschwind_A | pfeilschnell_A | mkA "pfeilgeschwind" ; -- status=guess status=guess status=guess status=guess
lin closely_Adv = mkAdv "dicht" | mkAdv "eng" ; -- status=guess status=guess
lin thin_A = L.thin_A ;
lin solicitorMasc_N = mkN "Solicitor" masculine | rechtsanwalt_N | der_nbspdamenfluegel_N ; -- status=guess status=guess status=guess
lin secure_V2 = mkV2 (sichern_1_V) | mkV2 (absichern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin plate_N = gang_N ; -- status=guess
lin pool_N = becken_N ; -- status=guess
lin gold_N = L.gold_N ;
lin emphasis_N = betonung_N | mkN "Gewichtung" feminine ; -- status=guess status=guess
lin recall_VS = mkVS (mkV "zurückrufen") ; -- status=guess, src=wikt
lin recall_V2 = mkV2 (mkV "zurückrufen") ; -- status=guess, src=wikt
lin shout_V2 = mkV2 (spendieren_V) | mkV2 (mkV "schmeißen") ; -- status=guess, src=wikt status=guess, src=wikt
lin shout_V = spendieren_V | mkV "schmeißen" ; -- status=guess, src=wikt status=guess, src=wikt
lin generate_V2 = mkV2 (erzeugen_V) ; -- status=guess, src=wikt
lin location_N = ort_N | platz_N ; -- status=guess status=guess
lin display_VS = mkVS (anzeigen_V) ; -- status=guess, src=wikt
lin display_V2 = mkV2 (anzeigen_V) ; -- status=guess, src=wikt
lin heat_N = mkN "Schärfe" feminine ; -- status=guess
lin gun_N = gewehr_N ; -- status=guess
lin shut_V2 = mkV2 (mkV "schließen") | mkV2 (zumachen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin journey_N = reise_N | tour_N ; -- status=guess status=guess
lin imply_VS = mkVS (bedeuten_V) | mkVS (implizieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin imply_V2 = mkV2 (bedeuten_V) | mkV2 (implizieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin imply_V = bedeuten_V | implizieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin violence_N = gewalt_N | mkN "Gewalttaten {f} {p}" ; -- status=guess status=guess
lin dry_A = L.dry_A ;
lin historical_A = mkA "geschichtlich" | historisch_A ; -- status=guess status=guess
lin step_V2 = mkV2 (treten_7_V) | mkV2 (mkV "schreiten") ; -- status=guess, src=wikt status=guess, src=wikt
lin step_V = treten_7_V | mkV "schreiten" ; -- status=guess, src=wikt status=guess, src=wikt
lin curriculum_N = lebenslauf_N ; -- status=guess
lin noise_N = mkN "Lärmbelastung" feminine ; -- status=guess
lin lunch_N = mittagessen_N | mkN "Lunch" masculine ; -- status=guess status=guess
lin fear_VS = L.fear_VS ;
lin fear_V2 = L.fear_V2 ;
lin fear_V = mkV "fürchten" | junkV (mkV "Angst") "haben" ; -- status=guess, src=wikt status=guess, src=wikt
lin succeed_V2 = mkV2 (nachfolgen_V) ; -- status=guess, src=wikt
lin succeed_V = nachfolgen_V ; -- status=guess, src=wikt
lin fall_N = fall_N | absturz_N ; -- status=guess status=guess
lin fall_2_N = variants{} ; -- 
lin fall_1_N = variants{} ; -- 
lin bottom_N = boden_N | grund_N | mkN "Unterseite" feminine ; -- status=guess status=guess status=guess
lin initial_A = mkA "anfänglich" | mkA "ursprünglich" ; -- status=guess status=guess
lin theme_N = mkN "Themenpark" masculine ; -- status=guess
lin characteristic_N = merkmal_N | eigenschaft_N | charakteristik_N | eigenart_N ; -- status=guess status=guess status=guess status=guess
lin pretty_Adv = mkAdv "ziemlich" | mkAdv "einigermaßen" ; -- status=guess status=guess
lin empty_A = L.empty_A ;
lin display_N = display_N | mkN "Monitor" masculine | bildschirm_N | anzeige_N ; -- status=guess status=guess status=guess status=guess
lin combination_N = kombination_N ; -- status=guess
lin interpretation_N = interpretation_N ; -- status=guess
lin rely_V2 = variants{}; -- mkReflV "verlassen auf" ; -- status=guess, src=wikt
lin rely_V = mkReflV "verlassen auf" ; -- status=guess, src=wikt
lin escape_VS = mkVS (mkV "davonkommen") ; -- status=guess, src=wikt
lin escape_V2 = mkV2 (mkV "davonkommen") ; -- status=guess, src=wikt
lin escape_V = mkV "davonkommen" ; -- status=guess, src=wikt
lin score_V2 = mkV2 (treffen_9_V) | mkV2 (mkV "punkten") ; -- status=guess, src=wikt status=guess, src=wikt
lin score_V = treffen_9_V | mkV "punkten" ; -- status=guess, src=wikt status=guess, src=wikt
lin justice_N = gerechtigkeit_N ; -- status=guess
lin upper_A = mkA "obere" ; -- status=guess
lin tooth_N = L.tooth_N ;
lin organize_V2V = mkV2V (organisieren_V) ; -- status=guess, src=wikt
lin organize_V2 = mkV2 (organisieren_V) ; -- status=guess, src=wikt
lin cat_N = L.cat_N ;
lin tool_N = mkN "Tool" neuter ; -- status=guess
lin spot_N = mkN "Werbespot" masculine ; -- status=guess
lin bridge_N = mkN "Bridge" neuter ; -- status=guess
lin double_A = mkA "doppel-" ; -- status=guess
lin direct_V2 = variants{} ; -- 
lin direct_V = variants{} ; -- 
lin conclude_VS = mkVS (beenden_V) | mkVS (folgern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin conclude_V2 = mkV2 (beenden_V) | mkV2 (folgern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin conclude_V = beenden_V | folgern_V ; -- status=guess, src=wikt status=guess, src=wikt
lin relative_A = mkA "vergleichsweise" | relativ_A ; -- status=guess status=guess
lin soldier_N = soldat_N | soldatin_N ; -- status=guess status=guess
lin climb_V2 = mkV2 (klettern_V) | mkV2 (steigen_1_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin climb_V = klettern_V | steigen_1_V ; -- status=guess, src=wikt status=guess, src=wikt
lin breath_N = atempause_N ; -- status=guess
lin afford_V2V = mkV2V (mkReflV "leisten") | mkV2V (junkV (mkV "imstande") "sein") ; -- status=guess, src=wikt status=guess, src=wikt
lin afford_V2 = mkV2 (mkReflV "leisten") | mkV2 (junkV (mkV "imstande") "sein") ; -- status=guess, src=wikt status=guess, src=wikt
lin urban_A = mkA "städtisch" | urban_A | mkA "Stadt-" ; -- status=guess status=guess status=guess
lin nurse_N = schwester_N | krankenschwester_N | mkN "Pflegerin" feminine | krankenpflegerin_N | mkN "Pfleger" masculine | krankenpfleger_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin narrow_A = L.narrow_A ;
lin liberal_A = variants{} ; -- 
lin coal_N = kohle_N ; -- status=guess
lin priority_N = mkN "Priorität" feminine ; -- status=guess
lin wild_A = wild_A ; -- status=guess
lin revenue_N = mkN "Einnahmen {f} {p}" ; -- status=guess
lin membership_N = mitgliedschaft_N ; -- status=guess
lin grant_N = variants{} ; -- 
lin approve_V2 = mkV2 (mkV "bewilligen") ; -- status=guess, src=wikt
lin approve_V = mkV "bewilligen" ; -- status=guess, src=wikt
lin tall_A = hoch_A ; -- status=guess
lin apparent_A = offensichtlich_A ; -- status=guess
lin faith_N = mkN "Glaube" masculine ; -- status=guess
lin under_Adv = mkAdv "unter keinen Umständen" | auf_Adv | auf_Adv ; -- status=guess status=guess status=guess
lin fix_V2 = mkV2 (reparieren_V) ; -- status=guess, src=wikt
lin fix_V = reparieren_V ; -- status=guess, src=wikt
lin slow_A = langsam_A ; -- status=guess
lin troop_N = variants{} ; -- 
lin motion_N = bewegung_N ; -- status=guess
lin leading_A = variants{} ; -- 
lin component_N = komponente_N ; -- status=guess
lin bloody_A = blutig_A ; -- status=guess
lin literature_N = literatur_N ; -- status=guess
lin conservative_A = konservativ_A ; -- status=guess
lin variation_N = variation_N ; -- status=guess
lin remind_V2 = mkV2 (erinnern_V) ; -- status=guess, src=wikt
lin inform_V2 = mkV2 (denunzieren_V) ; -- status=guess, src=wikt
lin inform_V = denunzieren_V ; -- status=guess, src=wikt
lin alternative_N = alternative_N ; -- status=guess
lin neither_Adv = variants{} ; -- 
lin outside_Adv = mkAdv "außerhalb" | mkAdv "draußen" ; -- status=guess status=guess
lin mass_N = mkN "Massendefekt" masculine ; -- status=guess
lin busy_A = mkA "beschäftigt" ; -- status=guess
lin chemical_N = chemikalie_N ; -- status=guess
lin careful_A = vorsichtig_A | behutsam_A ; -- status=guess status=guess
lin investigate_V2 = mkV2 (untersuchen_V) ; -- status=guess, src=wikt
lin investigate_V = untersuchen_V ; -- status=guess, src=wikt
lin roll_V2 = mkV2 (laufen_9_V) ; -- status=guess, src=wikt
lin roll_V = laufen_9_V ; -- status=guess, src=wikt
lin instrument_N = dokument_N | urkunde_N ; -- status=guess status=guess
lin guide_N = mkN "Reiseleiter" masculine | mkN "Reiseleiterin" feminine | mkN "Fremdenführer" masculine | mkN "Fremdenführerin" feminine ; -- status=guess status=guess status=guess status=guess
lin criterion_N = kriterium_N ; -- status=guess
lin pocket_N = tasche_N ; -- status=guess
lin suggestion_N = vorschlag_N ; -- status=guess
lin aye_Interj = mkInterj "jawohl" ; -- status=guess
lin entitle_VS = mkVS (mkV "berechtigen") ; -- status=guess, src=wikt
lin entitle_V2V = mkV2V (mkV "berechtigen") ; -- status=guess, src=wikt
lin tone_N = tonarm_N ; -- status=guess
lin attractive_A = attraktiv_A ; -- status=guess
lin wing_N = L.wing_N ;
lin surprise_N = mkN "Überraschungs- e. g. Überraschungsangriff" ; -- status=guess
lin male_N = mkN "Männchen" neuter ; -- status=guess
lin ring_N = ring_N ; -- status=guess
lin pub_N = kneipe_N | bar_N | lokal_N ; -- status=guess status=guess status=guess
lin fruit_N = L.fruit_N ;
lin passage_N = passage_N ; -- status=guess
lin illustrate_VS = mkVS (illustrieren_V) ; -- status=guess, src=wikt
lin illustrate_V2 = mkV2 (illustrieren_V) ; -- status=guess, src=wikt
lin illustrate_V = illustrieren_V ; -- status=guess, src=wikt
lin pay_N = mkN "Pay-TV" neuter | mkN "Bezahlfernsehen" neuter ; -- status=guess status=guess
lin ride_V2 = mkV2 (fahren_7_V) ; -- status=guess, src=wikt
lin ride_V = fahren_7_V ; -- status=guess, src=wikt
lin foundation_N = mkN "Gründung" feminine ; -- status=guess
lin restaurant_N = L.restaurant_N ;
lin vital_A = mkA "lebenswichtig" ; -- status=guess
lin alternative_A = alternativ_A ; -- status=guess
lin burn_V2 = mkV2 (brennen_5_V) ; -- status=guess, src=wikt
lin burn_V = L.burn_V ;
lin map_N = stadtplan_N ; -- status=guess
lin united_A = vereint_A ; -- status=guess
lin device_N = mkN "Motto" neuter | mkN "Emblem" neuter | devise_N ; -- status=guess status=guess status=guess
lin jump_V2 = mkV2 (springen_7_V) ; -- status=guess, src=wikt
lin jump_V = L.jump_V ;
lin estimate_VS = mkVS (mkV "abschätzen") | mkVS (mkV "schätzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin estimate_V2V = mkV2V (mkV "abschätzen") | mkV2V (mkV "schätzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin estimate_V2 = mkV2 (mkV "abschätzen") | mkV2 (mkV "schätzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin estimate_V = mkV "abschätzen" | mkV "schätzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin conduct_V2 = mkV2 (leiten_4_V) ; -- status=guess, src=wikt
lin conduct_V = leiten_4_V ; -- status=guess, src=wikt
lin derive_V2 = mkV2 (ableiten_V) ; -- status=guess, src=wikt
lin derive_V = ableiten_V ; -- status=guess, src=wikt
lin comment_VS = mkVS (auskommentieren_V) ; -- status=guess, src=wikt
lin comment_V2 = mkV2 (auskommentieren_V) ; -- status=guess, src=wikt
lin comment_V = auskommentieren_V ; -- status=guess, src=wikt
lin east_N = mkN "Osten" masculine | mkN "Ost" masculine ; -- status=guess status=guess
lin advise_VS = mkVS (raten_V) | mkVS (beraten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin advise_V2 = mkV2 (raten_V) | mkV2 (beraten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin advise_V = raten_V | beraten_V ; -- status=guess, src=wikt status=guess, src=wikt
lin advance_N = vorschuss_N | anzahlung_N | vorschuss_N ; -- status=guess status=guess status=guess
lin motor_N = mkN "Motor" masculine | triebwerk_N | antrieb_N ; -- status=guess status=guess status=guess
lin satisfy_V2 = mkV2 (befriedigen_V) | mkV2 (zufriedenstellen_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin hell_N = mkN "Hölle" feminine ; -- status=guess
lin winner_N = gewinner_N | mkN "Gewinnerin" feminine | sieger_N | siegerin_N ; -- status=guess status=guess status=guess status=guess
lin effectively_Adv = variants{} ; -- 
lin mistake_N = fehler_N ; -- status=guess
lin incident_N = vorfall_N | mkN "Störfall" masculine | ereignis_N ; -- status=guess status=guess status=guess
lin focus_V2 = mkV2 (fokussieren_V) ; -- status=guess, src=wikt
lin focus_V = fokussieren_V ; -- status=guess, src=wikt
lin exercise_VV = mkVV (mkV "üben") | mkVV (mkV "trainieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin exercise_V2 = mkV2 (mkV "üben") | mkV2 (mkV "trainieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin exercise_V = mkV "üben" | mkV "trainieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin representation_N = mkN "Repräsentation" feminine | darstellung_N ; -- status=guess status=guess
lin release_N = mkN "Veröffentlichung" feminine ; -- status=guess
lin leaf_N = L.leaf_N ;
lin border_N = rand_N ; -- status=guess
lin wash_V2 = L.wash_V2 ;
lin wash_V = mkReflV "waschen" ; -- status=guess, src=wikt
lin prospect_N = variants{} ; -- 
lin blow_V2 = mkV2 (ablassen_V) ; -- status=guess, src=wikt
lin blow_V = L.blow_V ;
lin trip_N = reise_N ; -- status=guess
lin observation_N = beobachtung_N ; -- status=guess
lin gather_V2 = mkV2 (sammeln_V) | mkV2 (versammeln_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin gather_V = sammeln_V | versammeln_V ; -- status=guess, src=wikt status=guess, src=wikt
lin ancient_A = uralt_A | antik_A ; -- status=guess status=guess
lin brief_A = mkA "prägnant" ; -- status=guess
lin gate_N = tor_N ; -- status=guess
lin elderly_A = mkA "älter" | mkA "ältlich" | bejahrt_A ; -- status=guess status=guess status=guess
lin persuade_V2V = mkV2V (mkV "überreden") | mkV2V (gewinnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin persuade_V2 = mkV2 (mkV "überreden") | mkV2 (gewinnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin overall_A = variants{} ; -- 
lin rare_A = blutig_A ; -- status=guess
lin index_N = mkN "Index" masculine | verzeichnis_N ; -- status=guess status=guess
lin hand_V2 = mkV2 (mkV "überliefern") ; -- status=guess, src=wikt
lin circle_N = kreis_N ; -- status=guess
lin creation_N = mkN "Kreation" feminine | mkN "Schöpfung" feminine | mkN "Erstellung" feminine | mkN "Schaffung" feminine ; -- status=guess status=guess status=guess status=guess
lin drawing_N = mkN "Auslosung" feminine | ziehung_N ; -- status=guess status=guess
lin anybody_NP = variants{} ; -- 
lin flow_N = mkN "Tätigkeitsrausch" ; -- status=guess
lin matter_V = junkV (mkV "wichtig") "sein" | junkV (mkV "etwas") "ausmachen" ; -- status=guess, src=wikt status=guess, src=wikt
lin external_A = mkA "Außen-" | extern_A ; -- status=guess status=guess
lin capable_A = mkA "fähig" ; -- status=guess
lin recover_V = genesen_V ; -- status=guess, src=wikt
lin shot_N = wurf_N ; -- status=guess
lin request_N = bitte_N | nachfrage_N ; -- status=guess status=guess
lin impression_N = eindruck_N ; -- status=guess
lin neighbour_N = mkN "Nachbar" masculine | nachbarin_N ; -- status=guess status=guess
lin theatre_N = variants{} ; -- 
lin beneath_Prep = variants{} ; -- 
lin hurt_V2 = mkV2 (junkV (mkV "weh") "tun") | mkV2 (schmerzen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin hurt_V = junkV (mkV "weh") "tun" | schmerzen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin mechanism_N = mechanismus_N ; -- status=guess
lin potential_N = potential_N ; -- status=guess
lin lean_V2 = mkV2 (lehnen_6_V) ; -- status=guess, src=wikt
lin lean_V = lehnen_6_V ; -- status=guess, src=wikt
lin defendant_N = mkN "Angeklagter" masculine | mkN "Angeklagte" feminine ; -- status=guess status=guess
lin atmosphere_N = mkN "Atmosphäre" ; -- status=guess
lin slip_V2 = mkV2 (irren_V) | mkV2 (mkReflV "irren") | mkV2 (junkV (mkV "Fehler") "machen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin slip_V = irren_V | mkReflV "irren" | junkV (mkV "Fehler") "machen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin chain_N = mkN "Kettenschutz" masculine ; -- status=guess
lin accompany_V2 = mkV2 (begleiten_V) ; -- status=guess, src=wikt
lin wonderful_A = wunderbar_A | wundervoll_A ; -- status=guess status=guess
lin earn_V2 = mkV2 (verdienen_V) ; -- status=guess, src=wikt
lin earn_V = verdienen_V ; -- status=guess, src=wikt
lin enemy_N = L.enemy_N ;
lin desk_N = schreibtisch_N ; -- status=guess
lin engineering_N = ingenieurwissenschaft_N | mkN "Ingenieurwesen" neuter ; -- status=guess status=guess
lin panel_N = mkN "Diskussionsrunde" feminine ; -- status=guess
lin distinction_N = auszeichnung_N ; -- status=guess
lin deputy_N = mkN "Deputierter" masculine | mkN "Deputierte {m}" feminine | mkN "Abgeordneter" masculine | mkN "Abgeordnete {m}" feminine ; -- status=guess status=guess status=guess status=guess
lin discipline_N = disziplin_N ; -- status=guess
lin strike_N = mkN "Strike" masculine ; -- status=guess
lin strike_2_N = variants{} ; -- 
lin strike_1_N = variants{} ; -- 
lin married_A = verheiratet_A ; -- status=guess
lin plenty_NP = variants{} ; -- 
lin establishment_N = variants{} ; -- 
lin fashion_N = mode_N ; -- status=guess
lin roof_N = L.roof_N ;
lin milk_N = L.milk_N ;
lin entire_A = ganz_A ; -- status=guess
lin tear_N = mkN "Träne" feminine ; -- status=guess
lin secondary_A = mkA "sekundär" ; -- status=guess
lin finding_N = variants{} ; -- 
lin welfare_N = mkN "Sozialhilfe" feminine | mkN "Wohlfahrt" feminine ; -- status=guess status=guess
lin increased_A = variants{} ; -- 
lin attach_V2 = variants{} ; -- 
lin attach_V = variants{} ; -- 
lin typical_A = typisch_A ; -- status=guess
lin typical_3_A = variants{} ; -- 
lin typical_2_A = variants{} ; -- 
lin typical_1_A = variants{} ; -- 
lin meanwhile_Adv = unterdessen_Adv ; -- status=guess
lin leadership_N = mkN "Führung" feminine | leitung_N ; -- status=guess status=guess
lin walk_N = weg_N ; -- status=guess
lin negotiation_N = verhandlung_N ; -- status=guess
lin clean_A = L.clean_A ;
lin religion_N = L.religion_N ;
lin count_V2 = L.count_V2 ;
lin count_V = mkV "jemanden" ; -- status=guess, src=wikt
lin grey_A = variants{} ; -- 
lin hence_Adv = daher_Adv | deshalb_Adv ; -- status=guess status=guess
lin alright_Adv = variants{} ; -- 
lin first_A = mkA "erst" ;
lin fuel_N = brennstoff_N | treibstoff_N ; -- status=guess status=guess
lin mine_N = mine_N ; -- status=guess
lin appeal_V2 = mkV2 (junkV (mkV "in") "Berufung gehen") ; -- status=guess, src=wikt
lin appeal_V = junkV (mkV "in") "Berufung gehen" ; -- status=guess, src=wikt
lin servantMasc_N = diener_N | mkN "Dienerin" feminine ; -- status=guess status=guess
lin liability_N = verantwortung_N | schuld_N | verpflichtung_N ; -- status=guess status=guess status=guess
lin constant_A = mkA "regelmäßig" | mkA "ständig" | stetig_A ; -- status=guess status=guess status=guess
lin hate_VV = mkVV (hassen_V) ; -- status=guess, src=wikt
lin hate_V2 = L.hate_V2 ;
lin shoe_N = L.shoe_N ;
lin expense_N = verlust_N ; -- status=guess
lin vast_A = mkA "beträchtlich" | weit_A ; -- status=guess status=guess
lin soil_N = boden_N ; -- status=guess
lin writing_N = schrift_N | arbeit_N | werk_N ; -- status=guess status=guess status=guess
lin nose_N = L.nose_N ;
lin origin_N = herkunft_N ; -- status=guess
lin lord_N = herr_N ; -- status=guess
lin rest_V2 = mkV2 (ruhen_V) ; -- status=guess, src=wikt
lin drive_N = fahrt_N ; -- status=guess
lin ticket_N = ticket_N | karte_N | eintrittskarte_N | schein_N ; -- status=guess status=guess status=guess status=guess
lin editor_N = chefredakteur_N ; -- status=guess
lin switch_V2 = mkV2 (schalten_3_V) ; -- status=guess, src=wikt
lin switch_V = schalten_3_V ; -- status=guess, src=wikt
lin provided_Subj = variants{} ; -- 
lin northern_A = variants{} ; -- 
lin significance_N = bedeutung_N | mkN "Signifikanz" feminine ; -- status=guess status=guess
lin channel_N = kanal_N ; -- status=guess
lin convention_N = abkommen_N | vereinbarung_N ; -- status=guess status=guess
lin damage_V2 = mkV2 (mkV "beschädigen") ; -- status=guess, src=wikt
lin funny_A = komisch_A | lustig_A | mkA "spaßig" ; -- status=guess status=guess status=guess
lin bone_N = L.bone_N ;
lin severe_A = streng_A ; -- status=guess
lin search_V2 = mkV2 (suchen_V) ; -- status=guess, src=wikt
lin search_V = suchen_V ; -- status=guess, src=wikt
lin iron_N = L.iron_N ;
lin vision_N = vision_N ; -- status=guess
lin via_Prep = variants{} ; -- 
lin somewhat_Adv = mkAdv "etwas" | mkAdv "einigermaßen" ; -- status=guess status=guess
lin inside_Adv = nach_rechts_Adv | herein_Adv | drinnen_Adv | mkAdv "innerhalb" | mkAdv "im innern" | mkAdv "im inneren" | mkAdv "innerhalb" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin trend_N = trend_N ; -- status=guess
lin revolution_N = revolution_N ; -- status=guess
lin terrible_A = schrecklich_A ; -- status=guess
lin knee_N = L.knee_N ;
lin dress_N = kleidung_N ; -- status=guess
lin unfortunately_Adv = leider_Adv | mkAdv "unglücklicherweise" ; -- status=guess status=guess
lin steal_V2 = mkV2 (stehlen_V) | mkV2 (rauben_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin steal_V = stehlen_V | rauben_V ; -- status=guess, src=wikt status=guess, src=wikt
lin criminal_A = kriminell_A ; -- status=guess
lin signal_N = signal_N ; -- status=guess
lin notion_N = neigung_N | absicht_N | lust_N ; -- status=guess status=guess status=guess
lin comparison_N = vergleich_N | komparation_N ; -- status=guess status=guess
lin academic_A = mkA "akademisch" ; -- status=guess
lin outcome_N = ergebnis_N | ausgang_N ; -- status=guess status=guess
lin lawyer_N = rechtsanwalt_N ; -- status=guess
lin strongly_Adv = variants{} ; -- 
lin surround_V2 = mkV2 (umgeben_V) | mkV2 (mkV "umringen") ; -- status=guess, src=wikt status=guess, src=wikt
lin explore_VS = mkVS (mkV "erforschen") ; -- status=guess, src=wikt
lin explore_V2 = mkV2 (mkV "erforschen") ; -- status=guess, src=wikt
lin achievement_N = mkN "Errungenschaft" feminine | mkN "Vollendung" feminine ; -- status=guess status=guess
lin odd_A = ungerade_A ; -- status=guess
lin expectation_N = erwartung_N ; -- status=guess
lin corporate_A = variants{} ; -- 
lin prisoner_N = mkN "Gefangener" masculine | mkN "Gefangene" feminine ; -- status=guess status=guess
lin question_V2 = mkV2 (fragen_7_V) | mkV2 (hinterfragen_V) | mkV2 (befragen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rapidly_Adv = mkAdv "schnell" ; -- status=guess
lin deep_Adv = variants{} ; -- 
lin southern_A = mkA "südlich" | mkA "südländisch" ; -- status=guess status=guess
lin amongst_Prep = variants{} ; -- 
lin withdraw_V2 = mkV2 (abheben_V) ; -- status=guess, src=wikt
lin withdraw_V = abheben_V ; -- status=guess, src=wikt
lin afterwards_Adv = mkAdv "später" | nachher_Adv | danach_Adv | hinterher_Adv ; -- status=guess status=guess status=guess status=guess
lin paint_V2 = mkV2 (streichen_1_V) ; -- status=guess, src=wikt
lin paint_V = streichen_1_V ; -- status=guess, src=wikt
lin judge_VS = mkVS (junkV (mkV "Schiedsrichter") "sein") ; -- status=guess, src=wikt
lin judge_V2 = mkV2 (junkV (mkV "Schiedsrichter") "sein") ; -- status=guess, src=wikt
lin judge_V = junkV (mkV "Schiedsrichter") "sein" ; -- status=guess, src=wikt
lin citizenMasc_N = zivilist_N ; -- status=guess
lin permanent_A = mkA "ständig" | permanent_A ; -- status=guess status=guess
lin weak_A = schwach_A ; -- status=guess
lin separate_V2 = mkV2 (separieren_V) | mkV2 (unterscheiden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin separate_V = separieren_V | unterscheiden_V ; -- status=guess, src=wikt status=guess, src=wikt
lin plastic_N = L.plastic_N ;
lin connect_V2 = mkV2 (mkV "anschließen") | mkV2 (verbinden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin connect_V = mkV "anschließen" | verbinden_V ; -- status=guess, src=wikt status=guess, src=wikt
lin fundamental_A = grundlegend_A | fundamental_A ; -- status=guess status=guess
lin plane_N = hobel_N ; -- status=guess
lin height_N = mkN "Höhe" feminine ; -- status=guess
lin opening_N = mkN "Eröffnung" feminine ; -- status=guess
lin lesson_N = mkN "Lehrstunde" feminine | stunde_N | lektion_N | mkN "Unterricht" masculine ; -- status=guess status=guess status=guess status=guess
lin similarly_Adv = mkAdv "ähnlich" ; -- status=guess
lin shock_N = mkN "Stoßdämpfer" masculine ; -- status=guess
lin rail_N = mkN "Geländer" neuter | mkN "Reling" feminine ; -- status=guess status=guess
lin tenant_N = mkN "Eigentümer" masculine | besitzer_N ; -- status=guess status=guess
lin owe_V2 = mkV2 (mkV "schulden") | mkV2 (junkV (mkV "schuldig") "sein") ; -- status=guess, src=wikt status=guess, src=wikt
lin owe_V = mkV "schulden" | junkV (mkV "schuldig") "sein" ; -- status=guess, src=wikt status=guess, src=wikt
lin originally_Adv = variants{} ; -- 
lin middle_A = mkA "Mittel-" | mkA "mittlere" ; -- status=guess status=guess
lin somehow_Adv = irgendwie_Adv ; -- status=guess
lin minor_A = mkA "moll" ; -- status=guess
lin negative_A = schlecht_A | negativ_A ; -- status=guess status=guess
lin knock_V2 = mkV2 (umwerfen_5_V) ; -- status=guess, src=wikt
lin knock_V = umwerfen_5_V ; -- status=guess, src=wikt
lin root_N = L.root_N ;
lin pursue_V2 = mkV2 (verfolgen_V) ; -- status=guess, src=wikt
lin pursue_V = verfolgen_V ; -- status=guess, src=wikt
lin inner_A = inner_A ; -- status=guess
lin crucial_A = mkA "kreuzförmig" ; -- status=guess
lin occupy_V2 = mkV2 (besetzen_V) ; -- status=guess, src=wikt
lin occupy_V = besetzen_V ; -- status=guess, src=wikt
lin that_AdA = variants{} ; -- 
lin independence_N = mkN "Unabhängigkeit" feminine ; -- status=guess
lin column_N = kolonne_N ; -- status=guess
lin proceeding_N = variants{} ; -- 
lin female_N = mkN "Weib" neuter | weibchen_N ; -- status=guess status=guess
lin beauty_N = mkN "Schönheit" feminine | mkN "Schöne" feminine ; -- status=guess status=guess
lin perfectly_Adv = variants{} ; -- 
lin struggle_N = kampf_N ; -- status=guess
lin gap_N = spalt_N ; -- status=guess
lin house_V2 = mkV2 (mkV "unterbringen") | mkV2 (beherbergen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin database_N = mkN "Datenbankadministrator" masculine ; -- status=guess
lin stretch_V2 = mkV2 (strecken_6_V) ; -- status=guess, src=wikt
lin stretch_V = strecken_6_V ; -- status=guess, src=wikt
lin stress_N = stress_N ; -- status=guess
lin passenger_N = passagier_N | fahrgast_N ; -- status=guess status=guess
lin boundary_N = grenze_N ; -- status=guess
lin easy_Adv = variants{} ; -- 
lin view_V2 = mkV2 (sehen_3_V) | mkV2 (anschauen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin manufacturer_N = hersteller_N ; -- status=guess
lin sharp_A = L.sharp_A ;
lin formation_N = variants{} ; -- 
lin queen_N = L.queen_N ;
lin waste_N = mkN "Verfall" masculine ; -- status=guess
lin virtually_Adv = mkAdv "praktisch" ; -- status=guess
lin expand_V2 = variants{} ; -- 
lin expand_V = variants{} ; -- 
lin contemporary_A = mkA "zeitgenössisch" ; -- status=guess
lin politician_N = politiker_N | politikerin_N ; -- status=guess status=guess
lin back_V = mkV "zurücksetzen" ; -- status=guess, src=wikt
lin territory_N = territorium_N ; -- status=guess
lin championship_N = meisterschaft__N ; -- status=guess
lin exception_N = ausnahme_N ; -- status=guess
lin thick_A = L.thick_A ;
lin inquiry_N = anfrage_N | mkN "Erkundigung" feminine ; -- status=guess status=guess
lin topic_N = thema_rhema_progression__N ; -- status=guess
lin resident_N = mkN "Assistentarzt" masculine ; -- status=guess
lin transaction_N = transaktion_N ; -- status=guess
lin parish_N = gemeinde_N ; -- status=guess
lin supporter_N = mkN "Unterstützer" masculine | mkN "Anhänger" masculine ; -- status=guess status=guess
lin massive_A = massiv_A ; -- status=guess
lin light_V2 = mkV2 (beleuchten_V) | mkV2 (mkV "anstrahlen") ; -- status=guess, src=wikt status=guess, src=wikt
lin light_V = beleuchten_V | mkV "anstrahlen" ; -- status=guess, src=wikt status=guess, src=wikt
lin unique_A = einzigartig_A | mkA "unikal" ; -- status=guess status=guess
lin challenge_V2 = mkV2 (mkV "herausfordern") ; -- status=guess, src=wikt
lin challenge_V = mkV "herausfordern" ; -- status=guess, src=wikt
lin inflation_N = mkN "Aufblasen" neuter | mkN "Aufblähung" feminine | inflation_N ; -- status=guess status=guess status=guess
lin assistance_N = hilfe_N ; -- status=guess
lin list_V2V = mkV2V (mkV "aufzählen") ; -- status=guess, src=wikt
lin list_V2 = mkV2 (mkV "aufzählen") ; -- status=guess, src=wikt
lin list_V = mkV "aufzählen" ; -- status=guess, src=wikt
lin identity_N = mkN "Identität" feminine ; -- status=guess
lin suit_V2 = mkV2 (passen_7_V) ; -- status=guess, src=wikt
lin suit_V = passen_7_V ; -- status=guess, src=wikt
lin parliamentary_A = mkA "parlamentarisch" ; -- status=guess
lin unknown_A = unbekannt_A ; -- status=guess
lin preparation_N = vorbereitung_N ; -- status=guess
lin elect_V3 = mkV3 (mkV "wählen") ; -- status=guess, src=wikt
lin elect_V2V = mkV2V (mkV "wählen") ; -- status=guess, src=wikt
lin elect_V2 = mkV2 (mkV "wählen") ; -- status=guess, src=wikt
lin elect_V = mkV "wählen" ; -- status=guess, src=wikt
lin badly_Adv = variants{} ; -- 
lin moreover_Adv = mkAdv "außerdem" | mkAdv "überdies" ; -- status=guess status=guess
lin tie_V2 = L.tie_V2 ;
lin tie_V = binden_8_V ; -- status=guess, src=wikt
lin cancer_N = krebs_N ; -- status=guess
lin champion_N = sieger_N | gewinner_N | meister_N ; -- status=guess status=guess status=guess
lin exclude_V2 = variants{} ; -- 
lin review_V2 = variants{} ; -- 
lin review_V = variants{} ; -- 
lin licence_N = variants{} ; -- 
lin breakfast_N = mkN "Frühstück" neuter | mkN "Zmorge" feminine | mkN "Morgenessen" neuter ; -- status=guess status=guess status=guess
lin minority_N = minderheitsregierung_N ; -- status=guess
lin appreciate_V2 = mkV2 (verstehen_V) ; -- status=guess, src=wikt
lin appreciate_V = verstehen_V ; -- status=guess, src=wikt
lin fan_N = fan_N | liebhaber_N ; -- status=guess status=guess
lin fan_3_N = variants{} ; -- 
lin fan_2_N = variants{} ; -- 
lin fan_1_N = variants{} ; -- 
lin chief_N = chef_N | boss_N ; -- status=guess status=guess
lin accommodation_N = unterkunft_N ; -- status=guess
lin subsequent_A = folgend_A ; -- status=guess
lin democracy_N = demokratie_N ; -- status=guess
lin brown_A = L.brown_A ;
lin taste_N = mkN "Geschmack" masculine ; -- status=guess
lin crown_N = krone_N ; -- status=guess
lin permit_V2V = mkV2V (erlauben_V) | mkV2V (genehmigen_V) | mkV2V (zulassen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin permit_V2 = mkV2 (erlauben_V) | mkV2 (genehmigen_V) | mkV2 (zulassen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin permit_V = erlauben_V | genehmigen_V | zulassen_7_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin buyerMasc_N = mkN "Käufer" masculine | mkN "Einkäufer" masculine ; -- status=guess status=guess
lin gift_N = begabung_N | talent_N ; -- status=guess status=guess
lin resolution_N = mkN "Auflösung" feminine ; -- status=guess
lin angry_A = mkA "böse" | mkA "verärgert" | zornig_A ; -- status=guess status=guess status=guess
lin metre_N = mkN "Meter" masculine ; -- status=guess
lin wheel_N = rad_N ; -- status=guess
lin clause_N = nebensatz_N ; -- status=guess
lin break_N = mkN "Break" neuter ; -- status=guess
lin tank_N = mkN "Tank" masculine | mkN "Behälter" masculine ; -- status=guess status=guess
lin benefit_V2 = mkV2 (junkV (mkV "von") "Vorteil sein") | mkV2 (profitieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin benefit_V = junkV (mkV "von") "Vorteil sein" | profitieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin engage_V2 = variants{} ; -- 
lin engage_V = variants{} ; -- 
lin alive_A = lebendig_A ; -- status=guess
lin complaint_N = beschwerde_N | leiden_N | krankheit_N ; -- status=guess status=guess status=guess
lin inch_N = zoll_N ; -- status=guess
lin firm_A = fest_A ; -- status=guess
lin abandon_V2 = mkV2 (aufgeben_4_V) | mkV2 (verlassen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin blame_V2 = mkV2 (mkV "beschuldigen") | mkV2 (junkV (mkV "verantwortlich") "machen") ; -- status=guess, src=wikt status=guess, src=wikt
lin blame_V = mkV "beschuldigen" | junkV (mkV "verantwortlich") "machen" ; -- status=guess, src=wikt status=guess, src=wikt
lin clean_V2 = mkV2 (reinigen_V) | mkV2 (mkV "säubern") | mkV2 (putzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin clean_V = reinigen_V | mkV "säubern" | putzen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin quote_V2 = mkV2 (junkV (mkV "Preisangebot") "machen") ; -- status=guess, src=wikt
lin quote_V = junkV (mkV "Preisangebot") "machen" ; -- status=guess, src=wikt
lin quantity_N = mkN "Quantität" feminine | menge_N ; -- status=guess status=guess
lin rule_VS = mkVS (regieren_7_V) | mkVS (beherrschen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin rule_V2 = mkV2 (regieren_7_V) | mkV2 (beherrschen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin rule_V = regieren_7_V | beherrschen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin guilty_A = schuldig_A | mkA "tadelnswert" | mkA "tadelnswürdig" ; -- status=guess status=guess status=guess
lin prior_A = variants{} ; -- 
lin round_A = L.round_A ;
lin eastern_A = mkA "östlich" ; -- status=guess
lin coat_N = L.coat_N ;
lin involvement_N = variants{} ; -- 
lin tension_N = spannung_N ; -- status=guess
lin diet_N = mkN "Diät" feminine ; -- status=guess
lin enormous_A = variants{} ; -- 
lin score_N = mkN "Partitur" feminine ; -- status=guess
lin rarely_Adv = mkAdv "selten" ; -- status=guess
lin prize_N = preis_N ; -- status=guess
lin remaining_A = variants{} ; -- 
lin significantly_Adv = mkAdv "wesentlich" | mkAdv "beträchtlich" ; -- status=guess status=guess
lin glance_V2 = mkV2 (blicken_V) ; -- status=guess, src=wikt
lin glance_V = blicken_V ; -- status=guess, src=wikt
lin dominate_V2 = variants{} ; -- 
lin dominate_V = variants{} ; -- 
lin trust_VS = mkVS (vertrauen_9_V) ; -- status=guess, src=wikt
lin trust_V2 = mkV2 (vertrauen_9_V) ; -- status=guess, src=wikt
lin naturally_Adv = mkAdv "natürlich" ; -- status=guess
lin interpret_V2 = mkV2 (dolmetschen_V) | mkV2 (mkV "übersetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin interpret_V = dolmetschen_V | mkV "übersetzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin land_V2 = mkV2 (landen_V) ; -- status=guess, src=wikt
lin land_V = landen_V ; -- status=guess, src=wikt
lin frame_N = mkN "Frame" masculine | rahmen_N ; -- status=guess status=guess
lin extension_N = ausdehnung_N | erweiterung_N ; -- status=guess status=guess
lin mix_V2 = mkV2 (mischen_5_V) | mkV2 (mkV "abmischen") | mkV2 (mixen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mix_V = mischen_5_V | mkV "abmischen" | mixen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin spokesman_N = variants{} ; -- 
lin friendly_A = freundlich_A ; -- status=guess
lin acknowledge_VS = mkVS (anerkennen_8_V) ; -- status=guess, src=wikt
lin acknowledge_V2 = mkV2 (anerkennen_8_V) ; -- status=guess, src=wikt
lin register_V2 = mkV2 (registrieren_V) ; -- status=guess, src=wikt
lin register_V = registrieren_V ; -- status=guess, src=wikt
lin regime_N = mkN "Regimeänderung" feminine ; -- status=guess
lin regime_2_N = variants{} ; -- 
lin regime_1_N = variants{} ; -- 
lin fault_N = fehler_N ; -- status=guess
lin dispute_N = streit_N | disput_N ; -- status=guess status=guess
lin grass_N = L.grass_N ;
lin quietly_Adv = mkAdv "ruhig" | mkAdv "leise" ; -- status=guess status=guess
lin decline_N = mkN "Sinken" neuter | fall_N ; -- status=guess status=guess
lin dismiss_V2 = mkV2 (entlassen_V) ; -- status=guess, src=wikt
lin delivery_N = lieferung_N ; -- status=guess
lin complain_VS = mkVS (mkReflV "beschweren") | mkVS (klagen_1_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin complain_V = mkReflV "beschweren" | klagen_1_V ; -- status=guess, src=wikt status=guess, src=wikt
lin conservative_N = mkN "Konservativer" masculine ; -- status=guess
lin shift_V2 = mkV2 (mkV "umschalten") ; -- status=guess, src=wikt
lin shift_V = mkV "umschalten" ; -- status=guess, src=wikt
lin port_N = mkN "Port" masculine ; -- status=guess
lin beach_N = strand_N ; -- status=guess
lin string_N = zeichenkette_N | string_N ; -- status=guess status=guess
lin depth_N = tiefe_N ; -- status=guess
lin unusual_A = mkA "ungewöhnlich" ; -- status=guess
lin travel_N = reise_N ; -- status=guess
lin pilot_N = pilot_N | mkN "Flugzeugführer" masculine ; -- status=guess status=guess
lin obligation_N = verpflichtung_N | pflicht_N ; -- status=guess status=guess
lin gene_N = gen_N ; -- status=guess
lin yellow_A = L.yellow_A ;
lin republic_N = republik_N ; -- status=guess
lin shadow_N = schatten_N ; -- status=guess
lin dear_A = mkA "Sehr Geehrter" ; -- status=guess
lin analyse_V2 = variants{} ; -- 
lin anywhere_Adv = mkAdv "überall" | irgendwo_Adv ; -- status=guess status=guess
lin average_N = durchschnitt_N | mkN "arithmetisches Mittel" neuter ; -- status=guess status=guess
lin phrase_N = mkN "Sprachführer" masculine ; -- status=guess
lin long_term_A = variants{} ; -- 
lin crew_N = haufen_N ; -- status=guess
lin lucky_A = mkA "glücklich" ; -- status=guess
lin restore_V2 = mkV2 (mkV "wiederherstellen") | mkV2 (mkV "restaurieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin convince_V2V = mkV2V (mkV "überzeugen") ; -- status=guess, src=wikt
lin convince_V2 = mkV2 (mkV "überzeugen") ; -- status=guess, src=wikt
lin coast_N = mkN "Küste" | mkN "Küstenland" | strand_N | ufer_wolfstrapp_N ; -- status=guess status=guess status=guess status=guess
lin engineer_N = mkN "Maschinist" masculine | mkN "Maschinistin" feminine ; -- status=guess status=guess
lin heavily_Adv = variants{} ; -- 
lin extensive_A = umfangreich_A ; -- status=guess
lin glad_A = froh_A | mkA "fröhlich" ; -- status=guess status=guess
lin charity_N = mkN "Nächstenliebe" feminine ; -- status=guess
lin oppose_V2 = mkV2 (ablehnen_V) ; -- status=guess, src=wikt
lin oppose_V = ablehnen_V ; -- status=guess, src=wikt
lin defend_V2 = mkV2 (verteidigen_V) ; -- status=guess, src=wikt
lin alter_V2 = mkV2 (mkV "abändern") ; -- status=guess, src=wikt
lin alter_V = mkV "abändern" ; -- status=guess, src=wikt
lin warning_N = warnung_N ; -- status=guess
lin arrest_V2 = mkV2 (mkV "arretieren") ; -- status=guess, src=wikt
lin framework_N = mkN "Bezugssystem" neuter | mkN "Gefüge" neuter | mkN "Programmiergerüst" neuter | mkN "Rahmenkonzept" neuter | mkN "Rahmenwerk" neuter ; -- status=guess status=guess status=guess status=guess status=guess
lin approval_N = zustimmung_N ; -- status=guess
lin bother_VV = mkVV (mkV "belästigen") ; -- status=guess, src=wikt
lin bother_V2V = mkV2V (mkV "belästigen") ; -- status=guess, src=wikt
lin bother_V2 = mkV2 (mkV "belästigen") ; -- status=guess, src=wikt
lin bother_V = mkV "belästigen" ; -- status=guess, src=wikt
lin novel_N = roman_N ; -- status=guess
lin accuse_V2 = mkV2 (mkV "beschuldigen") ; -- status=guess, src=wikt
lin surprised_A = mkA "überrascht" ; -- status=guess
lin currency_N = mkN "Währung" feminine ; -- status=guess
lin restrict_V2 = mkV2 (mkV "beschränken") ; -- status=guess, src=wikt
lin restrict_V = mkV "beschränken" ; -- status=guess, src=wikt
lin possess_V2 = mkV2 (besitzen_V) ; -- status=guess, src=wikt
lin moral_A = moralisch_A ; -- status=guess
lin protein_N = protein_N ; -- status=guess
lin distinguish_V2 = mkV2 (mkReflV "auszeichnen") ; -- status=guess, src=wikt
lin distinguish_V = mkReflV "auszeichnen" ; -- status=guess, src=wikt
lin gently_Adv = variants{} ; -- 
lin reckon_VS = mkVS (mkV "schätzen") | mkVS (vermuten_V) | mkVS (mkV "mutmaßen") | mkVS (rechnen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin incorporate_V2 = mkV2 (mkV "gründen") | mkV2 (einverleiben_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin proceed_V = vorgehen_0_V ; -- status=guess, src=wikt
lin assist_V2 = mkV2 (mkV "assistieren") | mkV2 (helfen_V) | mkV2 (beistehen_5_V) | mkV2 (mkV "unterstützen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin assist_V = mkV "assistieren" | helfen_V | beistehen_5_V | mkV "unterstützen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sure_Adv = variants{} ; -- 
lin stress_VS = mkVS (mkV "stressen") ; -- status=guess, src=wikt
lin stress_V2 = mkV2 (mkV "stressen") ; -- status=guess, src=wikt
lin justify_VV = mkVV (ausrichten_3_V) | mkVV (justieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin justify_V2 = mkV2 (ausrichten_3_V) | mkV2 (justieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin behalf_N = variants{} ; -- 
lin councillor_N = variants{} ; -- 
lin setting_N = einstellung_N ; -- status=guess
lin command_N = befehl_N | kommando_N ; -- status=guess status=guess
lin command_2_N = variants{} ; -- 
lin command_1_N = variants{} ; -- 
lin maintenance_N = mkN "Instandhaltung" feminine | wartung_N ; -- status=guess status=guess
lin stair_N = treppe_N ; -- status=guess
lin poem_N = gedicht_N ; -- status=guess
lin chest_N = mkN "Kommode" feminine ; -- status=guess
lin like_Adv = wie_Adv ; -- status=guess
lin secret_N = geheimnis_N ; -- status=guess
lin restriction_N = mkN "Beschränkung" feminine | verbot_N ; -- status=guess status=guess
lin efficient_A = effizient_A ; -- status=guess
lin suspect_VS = mkVS (mkV "verdächtigen") ; -- status=guess, src=wikt
lin suspect_V2 = mkV2 (mkV "verdächtigen") ; -- status=guess, src=wikt
lin hat_N = L.hat_N ;
lin tough_A = mkA "zäh" ; -- status=guess
lin firmly_Adv = mkAdv "sicher" | mkAdv "fest" ; -- status=guess status=guess
lin willing_A = mkA "willens" | gewillt_A | willig_A ; -- status=guess status=guess status=guess
lin healthy_A = gesund_A ; -- status=guess
lin focus_N = konzentration_N ; -- status=guess
lin construct_V2 = mkV2 (bauen_0_V) | mkV2 (konstruieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin occasionally_Adv = mkAdv "gelegentlich" ; -- status=guess
lin mode_N = modus_vivendi_N ; -- status=guess
lin saving_N = variants{} ; -- 
lin comfortable_A = mkA "gemütlich" ; -- status=guess
lin camp_N = mkN "Lager" neuter ; -- status=guess
lin trade_V2 = mkV2 (junkV (mkV "in") "Zahlung geben") ; -- status=guess, src=wikt
lin trade_V = junkV (mkV "in") "Zahlung geben" ; -- status=guess, src=wikt
lin export_N = mkN "Exportgut" neuter | mkN "Exportware" feminine ; -- status=guess status=guess
lin wake_V2 = mkV2 (aufwecken_V) | mkV2 (wecken_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin wake_V = aufwecken_V | wecken_6_V ; -- status=guess, src=wikt status=guess, src=wikt
lin partnership_N = partnerschaft_N ; -- status=guess
lin daily_A = mkA "täglich" ; -- status=guess
lin abroad_Adv = mkAdv "im Ausland" ; -- status=guess
lin profession_N = beruf_N ; -- status=guess
lin load_N = ein_euro_job_N ; -- status=guess
lin countryside_N = mkN "Land" neuter ; -- status=guess
lin boot_N = L.boot_N ;
lin mostly_Adv = meistens_Adv ; -- status=guess
lin sudden_A = mkA "plötzlich" | mkA "jäh" ; -- status=guess status=guess
lin implement_V2 = mkV2 (vollziehen_2_V) | mkV2 (mkV "durchführen") | mkV2 (mkV "erfüllen") | mkV2 (implementieren_V) | mkV2 (mkV "ausführen") | mkV2 (umsetzen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reputation_N = ansehen_N | ruf_N ; -- status=guess status=guess
lin print_V2 = mkV2 (drucken_2_V) ; -- status=guess, src=wikt
lin print_V = drucken_2_V ; -- status=guess, src=wikt
lin calculate_VS = mkVS (rechnen_9_V) ; -- status=guess, src=wikt
lin calculate_V2 = mkV2 (rechnen_9_V) ; -- status=guess, src=wikt
lin calculate_V = rechnen_9_V ; -- status=guess, src=wikt
lin keen_A = mkA "begeistert" | eifrig_A | heftig_A | mkA "kühn" | scharf_A ; -- status=guess status=guess status=guess status=guess status=guess
lin guess_VS = mkVS (mkV "schätzen") | mkVS (raten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin guess_V2 = mkV2 (mkV "schätzen") | mkV2 (raten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin guess_V = mkV "schätzen" | raten_V ; -- status=guess, src=wikt status=guess, src=wikt
lin recommendation_N = empfehlung_N ; -- status=guess
lin autumn_N = herbst_N ; -- status=guess
lin conventional_A = konventionell_A | mkA "herkömmlich" ; -- status=guess status=guess
lin cope_V = schaffen_5_V | zurechtkommen_0_V ; -- status=guess, src=wikt status=guess, src=wikt
lin constitute_V2 = mkV2 (ernennen_V) | mkV2 (konstituieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin poll_N = umfrage_N ; -- status=guess
lin voluntary_A = freiwillig_A ; -- status=guess
lin valuable_A = wertvoll_A ; -- status=guess
lin recovery_N = mkN "Wiedererlangung" feminine ; -- status=guess
lin cast_V2 = mkV2 (junkV (mkV "Neunerprobe") "{f}") ; -- status=guess, src=wikt
lin cast_V = junkV (mkV "Neunerprobe") "{f}" ; -- status=guess, src=wikt
lin premise_N = mkN "Prämisse" feminine ; -- status=guess
lin resolve_V2 = mkV2 (mkV "lösen") | mkV2 (mkV "auflösen") ; -- status=guess, src=wikt status=guess, src=wikt
lin resolve_V = mkV "lösen" | mkV "auflösen" ; -- status=guess, src=wikt status=guess, src=wikt
lin regularly_Adv = variants{} ; -- 
lin solve_V2 = mkV2 (mkV "lösen") ; -- status=guess, src=wikt
lin plaintiff_N = mkN "Kläger" masculine ; -- status=guess
lin critic_N = kritiker_N ; -- status=guess
lin agriculture_N = landwirtschaft_N | mkN "Ackerbau" masculine ; -- status=guess status=guess
lin ice_N = L.ice_N ;
lin constitution_N = mkN "Verfassen" neuter | verfassung_N ; -- status=guess status=guess
lin communist_N = kommunist_N | kommunistin_N ; -- status=guess status=guess
lin layer_N = schicht_N ; -- status=guess
lin recession_N = rezession_N ; -- status=guess
lin slight_A = mkA "geringfügig" | leicht_A ; -- status=guess status=guess
lin dramatic_A = dramatisch_A ; -- status=guess
lin golden_A = golden_A ; -- status=guess
lin temporary_A = zeitweilig_A | mkA "temporär" | mkA "vorübergehend" ; -- status=guess status=guess status=guess
lin suit_N = farbe_N ; -- status=guess
lin shortly_Adv = variants{} ; -- 
lin initially_Adv = mkAdv "zunächst" | anfangs_Adv ; -- status=guess status=guess
lin arrival_N = ankunft_N ; -- status=guess
lin protest_N = demonstration_N ; -- status=guess
lin resistance_N = mkN "Widerstand" masculine ; -- status=guess
lin silent_A = still_A | mkA "schweigen" ; -- status=guess status=guess
lin presentation_N = vortrag_N | mkN "Präsentation" feminine | vorstellung_N ; -- status=guess status=guess status=guess
lin soul_N = mkN "Soul Patch" ; -- status=guess
lin self_N = mkN "Selbst" neuter ; -- status=guess
lin judgment_N = urteil_N ; -- status=guess
lin feed_V2 = mkV2 (fressen_V) ; -- status=guess, src=wikt
lin feed_V = fressen_V ; -- status=guess, src=wikt
lin muscle_N = muskel_N ; -- status=guess
lin shareholder_N = mkN "Aktionär" masculine ; -- status=guess
lin opposite_A = entgegengesetzt_A ; -- status=guess
lin pollution_N = verunreinigung_N | verschmutzung_N | umweltverschmutzung_N | mkN "Pollution" feminine ; -- status=guess status=guess status=guess status=guess
lin wealth_N = mkN "Fülle" feminine ; -- status=guess
lin video_taped_A = variants{} ; -- 
lin kingdom_N = reich_N ; -- status=guess
lin bread_N = L.bread_N ;
lin perspective_N = perspektive_N ; -- status=guess
lin camera_N = L.camera_N ;
lin prince_N = mkN "König" masculine ; -- status=guess
lin illness_N = krankheit_N ; -- status=guess
lin cake_N = kuchen_N ; -- status=guess
lin meat_N = L.meat_N ;
lin submit_V2 = mkV2 (vorlegen_8_V) | mkV2 (einreichen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin submit_V = vorlegen_8_V | einreichen_9_V ; -- status=guess, src=wikt status=guess, src=wikt
lin ideal_A = ideal_A ; -- status=guess
lin relax_V2 = mkV2 (entspannen_V) | mkV2 (junkV (mkV "locker") "werden") ; -- status=guess, src=wikt status=guess, src=wikt
lin relax_V = entspannen_V | junkV (mkV "locker") "werden" ; -- status=guess, src=wikt status=guess, src=wikt
lin penalty_N = strafraum_N ; -- status=guess
lin purchase_V2 = mkV2 (kaufen_7_V) | mkV2 (anschaffen_4_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin tired_A = mkA "müde" ; -- status=guess
lin beer_N = L.beer_N ;
lin specify_VS = mkVS (spezifizieren_V) ; -- status=guess, src=wikt
lin specify_V2 = mkV2 (spezifizieren_V) ; -- status=guess, src=wikt
lin specify_V = spezifizieren_V ; -- status=guess, src=wikt
lin short_Adv = variants{} ; -- 
lin monitor_V2 = mkV2 (mkV "überwachen") | mkV2 (mkV "abhören") | mkV2 (mkV "überprüfen") | mkV2 (aufpassen_0_V) | mkV2 (kontrollieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin monitor_V = mkV "überwachen" | mkV "abhören" | mkV "überprüfen" | aufpassen_0_V | kontrollieren_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin electricity_N = mkN "Elektrizität" feminine ; -- status=guess
lin specifically_Adv = variants{} ; -- 
lin bond_N = mkN "Bindungswinkel" masculine ; -- status=guess
lin statutory_A = mkA "satzungsmäßig" | mkA "satzungsgemäß" | statutarisch_A | mkA "statutar" ; -- status=guess status=guess status=guess status=guess
lin laboratory_N = mkN "Labor" neuter | laboratorium_N ; -- status=guess status=guess
lin federal_A = variants{} ; -- 
lin captain_N = mkN "Kapitän zur See" masculine ; -- status=guess
lin deeply_Adv = variants{} ; -- 
lin pour_V2 = mkV2 (mkV "ausgießen") ; -- status=guess, src=wikt
lin pour_V = mkV "ausgießen" ; -- status=guess, src=wikt
lin boss_N = L.boss_N ;
lin creature_N = mkN "Geschöpf" neuter | mkN "Kreatur" feminine ; -- status=guess status=guess
lin urge_VS = mkVS (mkV "drängen") | mkVS (mahnen_7_V) | mkVS (treiben_4_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin urge_V2V = mkV2V (mkV "drängen") | mkV2V (mahnen_7_V) | mkV2V (treiben_4_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin urge_V2 = mkV2 (mkV "drängen") | mkV2 (mahnen_7_V) | mkV2 (treiben_4_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin locate_V2 = variants{} ; -- 
lin locate_V = variants{} ; -- 
lin being_N = wesen_N | mkN "Geschöpf" neuter ; -- status=guess status=guess
lin struggle_VV = mkVV (mkReflV "durchbeißen") | mkVV (mkReflV "schwer tun") ; -- status=guess, src=wikt status=guess, src=wikt
lin struggle_V = mkReflV "durchbeißen" | mkReflV "schwer tun" ; -- status=guess, src=wikt status=guess, src=wikt
lin lifespan_N = mkN "Lebenserwartung" feminine | lebensdauer_N ; -- status=guess status=guess
lin flat_A = flach_A ; -- status=guess
lin valley_N = senke_N | tal_N ; -- status=guess status=guess
lin like_A = gleich_A ; -- status=guess
lin guard_N = mkN "Wachhund" masculine ; -- status=guess
lin emergency_N = notfall_N | notlage_N | notstand_N ; -- status=guess status=guess status=guess
lin dark_N = dunkelheit_N | mkN "Dunkel" neuter ; -- status=guess status=guess
lin bomb_N = bombe_N ; -- status=guess
lin dollar_N = mkN "Dollar" masculine ; -- status=guess
lin efficiency_N = effizienz_N ; -- status=guess
lin mood_N = mkN "schlechte Laune" feminine | mkN "üble Laune" feminine | mkN "Missmut" masculine | mkN "schlechte Stimmung" feminine ; -- status=guess status=guess status=guess status=guess
lin convert_V2 = mkV2 (konvertieren_V) | mkV2 (umwandeln_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin convert_V = konvertieren_V | umwandeln_V ; -- status=guess, src=wikt status=guess, src=wikt
lin possession_N = variants{} ; -- 
lin marketing_N = mkN "Marketing" neuter ; -- status=guess
lin please_VV = mkVV (gefallen_V) | mkVV (mkV "rechtmachen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2V = mkV2V (gefallen_V) | mkV2V (mkV "rechtmachen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2 = mkV2 (gefallen_V) | mkV2 (mkV "rechtmachen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V = gefallen_V | mkV "rechtmachen" ; -- status=guess, src=wikt status=guess, src=wikt
lin habit_N = gewohnheit_N | habitus_N ; -- status=guess status=guess
lin subsequently_Adv = mkAdv "anschließend" | danach_Adv | mkAdv "darauffolgend" | daraufhin_Adv | hierauf_Adv | nachher_Adv | mkAdv "nachträglich" | darauf_Adv | mkAdv "im Anschluss" | in_petto_Adv | in_petto_Adv ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin round_N = mkN "Vollwinkel" masculine ; -- status=guess
lin purchase_N = kauf_N | anschaffung_N ; -- status=guess status=guess
lin sort_V2 = mkV2 (sortieren_7_V) ; -- status=guess, src=wikt
lin sort_V = sortieren_7_V ; -- status=guess, src=wikt
lin outside_A = variants{} ; -- 
lin gradually_Adv = nach_rechts_Adv | mkAdv "allmählich" ; -- status=guess status=guess
lin expansion_N = expansion_N ; -- status=guess
lin competitive_A = mkA "wettbewerbsfähig" ; -- status=guess
lin cooperation_N = mkN "Zusammenarbeit" feminine | kooperation_N | mkN "Mitarbeit" feminine ; -- status=guess status=guess status=guess
lin acceptable_A = annehmbar_A ; -- status=guess
lin angle_N = ecke_N ; -- status=guess
lin cook_V2 = mkV2 (kochen_6_V) | mkV2 (garen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin cook_V = kochen_6_V | garen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin net_A = mkA "netto" | mkA "Netto-" ; -- status=guess status=guess
lin sensitive_A = empfindlich_A | sensibel_A ; -- status=guess status=guess
lin ratio_N = variants{} ; -- 
lin kiss_V2 = mkV2 (junkV (mkV "in") "den Arsch kriechen") ; -- status=guess, src=wikt
lin amount_V = mkV "beträgt" ; -- status=guess, src=wikt
lin sleep_N = mkN "Schlafentzug" masculine ; -- status=guess
lin finance_V2 = mkV2 (finanzieren_V) ; -- status=guess, src=wikt
lin essentially_Adv = variants{} ; -- 
lin fund_V2 = mkV2 (finanzieren_V) ; -- status=guess, src=wikt
lin preserve_V2 = mkV2 (bewahren_5_V) | mkV2 (aufrechterhalten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin wedding_N = hochzeitstorte_N ; -- status=guess
lin personality_N = mkN "Persönlichkeit" feminine ; -- status=guess
lin bishop_N = mkN "Läufer" masculine ; -- status=guess
lin dependent_A = mkA "abhängig" ; -- status=guess
lin landscape_N = mkN "Querformat" neuter ; -- status=guess
lin pure_A = pur_A | rein_A ; -- status=guess status=guess
lin mirror_N = kopie_N ; -- status=guess
lin lock_V2 = mkV2 (mkV "aussperren") ; -- status=guess, src=wikt
lin lock_V = mkV "aussperren" ; -- status=guess, src=wikt
lin symptom_N = symptom_N ; -- status=guess
lin promotion_N = mkN "Beförderung" feminine ; -- status=guess
lin global_A = global_A ; -- status=guess
lin aside_Adv = beiseite_Adv ; -- status=guess
lin tendency_N = tendenz_N | one_way_flug_N ; -- status=guess status=guess
lin conservation_N = schutz_N ; -- status=guess
lin reply_N = antwort_N ; -- status=guess
lin estimate_N = mkN "Schätzung" feminine | mkN "Abschätzung" feminine ; -- status=guess status=guess
lin qualification_N = qualifikation_N ; -- status=guess
lin pack_V2 = variants{} ; -- 
lin pack_V = variants{} ; -- 
lin governor_N = regler_N ; -- status=guess
lin expected_A = mkA "erwartet" ; -- status=guess
lin invest_V2 = mkV2 (investieren_V) ; -- status=guess, src=wikt
lin invest_V = investieren_V ; -- status=guess, src=wikt
lin cycle_N = zyklus_N ; -- status=guess
lin alright_A = variants{} ; -- 
lin philosophy_N = philosophie_N ; -- status=guess
lin gallery_N = galerie_N ; -- status=guess
lin sad_A = traurig_A ; -- status=guess
lin intervention_N = intervention_N ; -- status=guess
lin emotional_A = emotional_A ; -- status=guess
lin advertising_N = werbung_N ; -- status=guess
lin regard_N = variants{} ; -- 
lin dance_V2 = mkV2 (tanzen_V) ; -- status=guess, src=wikt
lin dance_V = tanzen_V ; -- status=guess, src=wikt
lin cigarette_N = zigarette_N ; -- status=guess
lin predict_VS = mkVS (prophezeien_V) ; -- status=guess, src=wikt
lin predict_V2 = mkV2 (prophezeien_V) ; -- status=guess, src=wikt
lin adequate_A = angemessen_A | mkA "adäquat" ; -- status=guess status=guess
lin variable_N = mkN "Südlicher Tropfenameisenwürger" masculine ; -- status=guess
lin net_N = mkN "Netto" neuter ; -- status=guess
lin retire_V2 = mkV2 (junkV (mkV "in") "Pension gehen") | mkV2 (junkV (mkV "in") "Rente gehen") | mkV2 (junkV (mkV "in") "den Ruhestand gehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin retire_V = junkV (mkV "in") "Pension gehen" | junkV (mkV "in") "Rente gehen" | junkV (mkV "in") "den Ruhestand gehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sugar_N = zucker_N ; -- status=guess
lin pale_A = hell_A | blass_A ; -- status=guess status=guess
lin frequency_N = frequenzmodulation_N ; -- status=guess
lin guy_N = mkN "Typen {p}" | mkN "Kerle {p}" | mkN "Leute {p}" ; -- status=guess status=guess status=guess
lin feature_V2 = mkV2 (bieten_2_V) | mkV2 (aufweisen_V) | mkV2 (mkV "darbieten") | mkV2 (junkV (mkV "besonders") "herausstellen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin furniture_N = mkN "Möbel {n} {p}" | mkN "Möbelstück" neuter ; -- status=guess status=guess
lin administrative_A = administrativ_A ; -- status=guess
lin wooden_A = mkA "hölzern" ; -- status=guess
lin input_N = eingabe_N ; -- status=guess
lin phenomenon_N = mkN "Phänomen" neuter ; -- status=guess
lin surprising_A = mkA "überraschend" | mkA "verwunderlich" ; -- status=guess status=guess
lin jacket_N = jackett_N ; -- status=guess
lin actor_N = mkN "Handelnde {m}" feminine ; -- status=guess
lin actor_2_N = variants{} ; -- 
lin actor_1_N = variants{} ; -- 
lin kick_V2 = mkV2 (mkV "schießen") ; -- status=guess, src=wikt
lin kick_V = mkV "schießen" ; -- status=guess, src=wikt
lin producer_N = produzent_N ; -- status=guess
lin hearing_N = mkN "Hörgerät" neuter ; -- status=guess
lin chip_N = chip_N ; -- status=guess
lin equation_N = gleichung_N ; -- status=guess
lin certificate_N = zertifikat_N ; -- status=guess
lin hello_Interj = mkInterj "hallo" ; -- status=guess
lin remarkable_A = bemerkenswert_A | mkA "verwunderlich" ; -- status=guess status=guess
lin alliance_N = allianz_N ; -- status=guess
lin smoke_V2 = mkV2 (rauchen_V) ; -- status=guess, src=wikt
lin smoke_V = rauchen_V ; -- status=guess, src=wikt
lin awareness_N = mkN "Bewusstsein" neuter ; -- status=guess
lin throat_N = kehle_N ; -- status=guess
lin discovery_N = entdeckung_N ; -- status=guess
lin festival_N = festival_N ; -- status=guess
lin dance_N = tanz_N ; -- status=guess
lin promise_N = versprechen_N ; -- status=guess
lin rose_N = mkN "Rosengewächs" neuter | mkN "Rosengewächse {n} {p}" | mkN "rosenblütige Pflanze" feminine | mkN "rosenblütige Pflanzen {f} {p}" ; -- status=guess status=guess status=guess status=guess
lin principal_A = mkA "hauptsächlich" ; -- status=guess
lin brilliant_A = genial_A | brillant_A ; -- status=guess status=guess
lin proposed_A = variants{} ; -- 
lin coach_N = mkN "Reisebus" masculine | mkN "Überlandbus" masculine | bus_N ; -- status=guess status=guess status=guess
lin coach_3_N = variants{} ; -- 
lin coach_2_N = variants{} ; -- 
lin coach_1_N = variants{} ; -- 
lin absolute_A = absolut_A ; -- status=guess
lin drama_N = drama_N | schauspiel_N ; -- status=guess status=guess
lin recording_N = aufnahme_N ; -- status=guess
lin precisely_Adv = mkAdv "präzise" ; -- status=guess
lin bath_N = bad_N | baden_wuerttembergerin_N ; -- status=guess status=guess
lin celebrate_V2 = mkV2 (feiern_7_V) | mkV2 (zelebrieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin substance_N = mkN "Drogenmissbrauch" masculine ; -- status=guess
lin swing_V2 = mkV2 (mkV "vorbeischauen") ; -- status=guess, src=wikt
lin swing_V = mkV "vorbeischauen" ; -- status=guess, src=wikt
lin for_Adv = mkAdv "dafür" ;
lin rapid_A = schnell_A ; -- status=guess
lin rough_A = rau_A | grob_A ; -- status=guess status=guess
lin investor_N = investor_N | anleger_N ; -- status=guess status=guess
lin fire_V2 = mkV2 (feuern_3_V) | mkV2 (mkV "schießen") ; -- status=guess, src=wikt status=guess, src=wikt
lin fire_V = feuern_3_V | mkV "schießen" ; -- status=guess, src=wikt status=guess, src=wikt
lin rank_N = reihe_N ; -- status=guess
lin compete_V = mkV "wettkämpfen" | streiten_V | mkV "konkurieren" | messen_4_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sweet_A = mkA "süßsauer" ; -- status=guess
lin decline_VV = mkVV (deklinieren_V) ; -- status=guess, src=wikt
lin decline_V2 = mkV2 (deklinieren_V) ; -- status=guess, src=wikt
lin decline_V = deklinieren_V ; -- status=guess, src=wikt
lin rent_N = callboy_N | mkN "Gigolo" masculine | stricher_N ; -- status=guess status=guess status=guess
lin dealer_N = mkN "Händler" masculine ; -- status=guess
lin bend_V2 = mkV2 (mkReflV "bücken") ; -- status=guess, src=wikt
lin bend_V = mkReflV "bücken" ; -- status=guess, src=wikt
lin solid_A = mkA "deftig" ; -- status=guess
lin cloud_N = L.cloud_N ;
lin across_Adv = variants{} ; -- 
lin level_A = mkA "auf gleicher Höhe" | mkA "auf gleichem Niveau" | mkA "auf gleicher Stufe" ; -- status=guess status=guess status=guess
lin enquiry_N = anfrage_N ; -- status=guess
lin fight_N = kampf_N | schlacht_N ; -- status=guess status=guess
lin abuse_N = missbrauch_N | mkN "Mißbrauch" masculine ; -- status=guess status=guess
lin golf_N = golf_N ; -- status=guess
lin guitar_N = gitarre_N ; -- status=guess
lin electronic_A = elektronisch_A ; -- status=guess
lin cottage_N = mkN "Cottage" neuter | mkN "Häuschen" neuter | mkN "Kotten" masculine ; -- status=guess status=guess status=guess
lin scope_N = umfang_N ; -- status=guess
lin pause_VS = mkVS (mkV "pausieren") | mkVS (innehalten_2_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin pause_V2V = mkV2V (mkV "pausieren") | mkV2V (innehalten_2_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin pause_V = mkV "pausieren" | innehalten_2_V ; -- status=guess, src=wikt status=guess, src=wikt
lin mixture_N = mischung_N ; -- status=guess
lin emotion_N = mkN "Gefühl" neuter | empfindung_N ; -- status=guess status=guess
lin comprehensive_A = umfassend_A ; -- status=guess
lin shirt_N = L.shirt_N ;
lin allowance_N = erlaubnis_N ; -- status=guess
lin retirement_N = rente_N | mkN "Ruhestand" masculine ; -- status=guess status=guess
lin breach_N = mkN "Verstoß" masculine ; -- status=guess
lin infection_N = ansteckung_N | infektion_N ; -- status=guess status=guess
lin resist_VV = mkVV (widerstehen_V) ; -- status=guess, src=wikt
lin resist_V2 = mkV2 (widerstehen_V) ; -- status=guess, src=wikt
lin resist_V = widerstehen_V ; -- status=guess, src=wikt
lin qualify_V2 = mkV2 (qualifizieren_V) ; -- status=guess, src=wikt
lin qualify_V = qualifizieren_V ; -- status=guess, src=wikt
lin paragraph_N = absatz_N ; -- status=guess
lin sick_A = krank_A ; -- status=guess
lin near_A = L.near_A ;
lin researcherMasc_N = forscher_N ; -- status=guess
lin consent_N = zustimmung_N | konsens_N ; -- status=guess status=guess
lin written_A = mkA "geschrieben" | schriftlich_A ; -- status=guess status=guess
lin literary_A = literarisch_A ; -- status=guess
lin ill_A = schlecht_A | mkA "übel" ; -- status=guess status=guess
lin wet_A = L.wet_A ;
lin lake_N = L.lake_N ;
lin entrance_N = eingang_N | einfahrt_N ; -- status=guess status=guess
lin peak_N = gipfel_N ; -- status=guess
lin successfully_Adv = mkAdv "erfolgreich" ; -- status=guess
lin sand_N = L.sand_N ;
lin breathe_V2 = mkV2 (einatmen_7_V) ; -- status=guess, src=wikt
lin breathe_V = L.breathe_V ;
lin cold_N = mkN "Kaltumformen" feminine ; -- status=guess
lin cheek_N = backe_N ; -- status=guess
lin platform_N = plattform_N | mkN "Podest" neuter ; -- status=guess status=guess
lin interaction_N = interaktion_N ; -- status=guess
lin watch_N = wache_N ; -- status=guess
lin borrow_VV = mkVV (borgen_V) | mkVV (mkV "ausleihen") ; -- status=guess, src=wikt status=guess, src=wikt
lin borrow_V2 = mkV2 (borgen_V) | mkV2 (mkV "ausleihen") ; -- status=guess, src=wikt status=guess, src=wikt
lin borrow_V = borgen_V | mkV "ausleihen" ; -- status=guess, src=wikt status=guess, src=wikt
lin birthday_N = geburtstag_N ; -- status=guess
lin knife_N = messer_N ; -- status=guess
lin extreme_A = extrem_A ; -- status=guess
lin core_N = kern_N ; -- status=guess
lin peasantMasc_N = bauer_N | mkN "Bäuerin" feminine ; -- status=guess status=guess
lin armed_A = bewaffnet_A ; -- status=guess
lin permission_N = erlaubnis_N ; -- status=guess
lin supreme_A = mkA "höchster" | mkA "oberster" ; -- status=guess status=guess
lin overcome_V2 = mkV2 (mkV "überwinden") ; -- status=guess, src=wikt
lin overcome_V = mkV "überwinden" ; -- status=guess, src=wikt
lin greatly_Adv = variants{} ; -- 
lin visual_A = visuell_A ; -- status=guess
lin lad_N = mkN "Junge" masculine | knabe_N ; -- status=guess status=guess
lin genuine_A = echt_A | original_A | genuin_A ; -- status=guess status=guess status=guess
lin personnel_N = personal_computer_N ; -- status=guess
lin judgement_N = tag_und_nacht_gleiche_N ; -- status=guess
lin exciting_A = mkA "aufregend" ; -- status=guess
lin stream_N = strom_N ; -- status=guess
lin perception_N = wahrnehmung_N ; -- status=guess
lin guarantee_VS = mkVS (garantieren_V) | mkVS (versichern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin guarantee_V2 = mkV2 (garantieren_V) | mkV2 (versichern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin guarantee_V = garantieren_V | versichern_V ; -- status=guess, src=wikt status=guess, src=wikt
lin disaster_N = desaster_N ; -- status=guess
lin darkness_N = dunkelheit_N | finsternis_N ; -- status=guess status=guess
lin bid_N = gebot_N ; -- status=guess
lin sake_N = mkN "Sake" masculine ; -- status=guess
lin sake_2_N = variants{} ; -- 
lin sake_1_N = variants{} ; -- 
lin organize_V2V = mkV2V (organisieren_V) ; -- status=guess, src=wikt
lin organize_V2 = mkV2 (organisieren_V) ; -- status=guess, src=wikt
lin tourist_N = tourist_N | mkN "Vergnügungsreisender" masculine | mkN "Reisender" masculine ; -- status=guess status=guess status=guess
lin policeman_N = L.policeman_N ;
lin castle_N = mkN "Burg" feminine | festung_N | mkN "Schloss" neuter ; -- status=guess status=guess status=guess
lin figure_VS = variants{} ; -- 
lin figure_V = variants{} ; -- 
lin race_VV = mkVV (rasen_V) ; -- status=guess, src=wikt
lin race_V2V = mkV2V (rasen_V) ; -- status=guess, src=wikt
lin race_V2 = mkV2 (rasen_V) ; -- status=guess, src=wikt
lin race_V = rasen_V ; -- status=guess, src=wikt
lin demonstration_N = demonstration_N ; -- status=guess
lin anger_N = mkN "Ärger" | mkN "Zorn" masculine | mkN "Wut" masculine | mkN "Groll" masculine | mkN "Ingrimm" masculine | mkN "Grimm" masculine | mkN "Furor" masculine | mkN "Jähzorn" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin briefly_Adv = mkAdv "kurz" ; -- status=guess
lin presumably_Adv = vermutlich_Adv | mkAdv "voraussichtlich" ; -- status=guess status=guess
lin clock_N = mkN "Taktsignal" neuter ; -- status=guess
lin hero_N = held_N | mkN "Hauptfigur" feminine ; -- status=guess status=guess
lin expose_V2 = mkV2 (aufdecken_0_V) | mkV2 (offenbaren_V) | mkV2 (mkV "entblößen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin expose_V = aufdecken_0_V | offenbaren_V | mkV "entblößen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin custom_N = zoll_N ; -- status=guess
lin maximum_A = maximal_A ; -- status=guess
lin wish_N = wunsch_N ; -- status=guess
lin earning_N = variants{} ; -- 
lin priest_N = L.priest_N ;
lin resign_V2 = mkV2 (mkV "zurücktreten") | mkV2 (mkV "kündigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin resign_V = mkV "zurücktreten" | mkV "kündigen" ; -- status=guess, src=wikt status=guess, src=wikt
lin store_V2 = mkV2 (speichern_8_V) ; -- status=guess, src=wikt
lin widespread_A = mkA "weitverbreitet" ; -- status=guess
lin comprise_V2 = mkV2 (bestehen_V) ; -- status=guess, src=wikt
lin chamber_N = raum_N | schlafzimmer_N | zimmer_N | kammer_N | mkN ": Gemach" neuter | mkN "Schlafgemach" neuter ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin acquisition_N = erwerb_N | mkN "Aneignung" feminine ; -- status=guess status=guess
lin involved_A = variants{} ; -- 
lin confident_A = zuversichtlich_A | sicher_A ; -- status=guess status=guess
lin circuit_N = mkN "Leiterplatte" feminine ; -- status=guess
lin radical_A = radikal_A ; -- status=guess
lin detect_V2 = mkV2 (entdecken_V) ; -- status=guess, src=wikt
lin stupid_A = L.stupid_A ;
lin grand_A = variants{} ; -- 
lin consumption_N = mkN "Konsum" masculine | mkN "Verzehr" masculine ; -- status=guess status=guess
lin hold_N = mkN "Schiffsraum" masculine ; -- status=guess
lin zone_N = bereich_N | distrikt_N | mkN "Eingabefeld" neuter | feld_N | gebiet_N | mkN "Gürtel" masculine | landstrich_N | zone_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin mean_A = gemein_A | mkA "böse" ; -- status=guess status=guess
lin altogether_Adv = alle_Adv ; -- status=guess
lin rush_VV = mkVV (mkV "überfallen") ; -- status=guess, src=wikt
lin rush_V2 = mkV2 (mkV "überfallen") ; -- status=guess, src=wikt
lin rush_V = mkV "überfallen" ; -- status=guess, src=wikt
lin numerous_A = zahlreich_A | mkA "vielzählig" ; -- status=guess status=guess
lin sink_V2 = mkV2 (sinken_V) ; -- status=guess, src=wikt
lin sink_V = sinken_V ; -- status=guess, src=wikt
lin everywhere_Adv = S.everywhere_Adv ;
lin classical_A = klassisch_A ; -- status=guess
lin respectively_Adv = mkAdv "beziehungsweise" ; -- status=guess
lin distinct_A = deutlich_A ; -- status=guess
lin mad_A = sauer_A | mkA "böse" ; -- status=guess status=guess
lin honour_N = ehre_N ; -- status=guess
lin statistics_N = statistik_N ; -- status=guess
lin false_A = falsch_A | mkA "unecht" ; -- status=guess status=guess
lin square_N = feld_N | mkN "Schachfeld" neuter ; -- status=guess status=guess
lin differ_V = mkReflV "unterscheiden" | abweichen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin disk_N = scheibe_N ; -- status=guess
lin truly_Adv = mkAdv "ehrlich" | mkAdv "wirklich" ; -- status=guess status=guess
lin survival_N = mkN "Überleben" neuter ; -- status=guess
lin proud_A = stolz_A | mkA "prahlerisch" ; -- status=guess status=guess
lin tower_N = der_nbspdamenfluegel_N ; -- status=guess
lin deposit_N = anzahlung_N ; -- status=guess
lin pace_N = mkN "Tempo" neuter | geschwindigkeit_N ; -- status=guess status=guess
lin compensation_N = abfindung_N | kompensation_N ; -- status=guess status=guess
lin adviserMasc_N = ratgeber_N | mkN "Ratgeberin" feminine ; -- status=guess status=guess
lin consultant_N = berater_N | mkN "Beraterin" feminine ; -- status=guess status=guess
lin drag_V2 = mkV2 (mkReflV "ziehen") | mkV2 (mkReflV "dahinziehen") ; -- status=guess, src=wikt status=guess, src=wikt
lin drag_V = mkReflV "ziehen" | mkReflV "dahinziehen" ; -- status=guess, src=wikt status=guess, src=wikt
lin advanced_A = fortgeschritten_A ; -- status=guess
lin landlord_N = vermieter_N | hauswirt_N ; -- status=guess status=guess
lin whenever_Adv = mkAdv "wenn" | wann_Adv | wann_Adv ; -- status=guess status=guess status=guess
lin delay_N = mkN "Verzögerung" feminine ; -- status=guess
lin green_N = mkN "Chile-Kolibri" masculine ; -- status=guess
lin car_V = variants{} ; -- 
lin holder_N = variants{} ; -- 
lin secret_A = geheim_A ; -- status=guess
lin edition_N = ausgabe_N | aufgabe_N ; -- status=guess status=guess
lin occupation_N = mkN "Beschäftigung" feminine | beruf_N ; -- status=guess status=guess
lin agricultural_A = landwirtschaftlich_A ;
lin intelligence_N = geheimdienst_N | nachrichtendienst_N | mkN "Sicherheitsdienst" masculine ; -- status=guess status=guess status=guess
lin intelligence_2_N = variants{} ; -- 
lin intelligence_1_N = variants{} ; -- 
lin empire_N = weltreich_N | imperium_N ; -- status=guess status=guess
lin definitely_Adv = mkAdv "definitiv" | mkAdv "bestimmt" | mkAdv "sicher" ; -- status=guess status=guess status=guess
lin negotiate_VV = mkVV (aushandeln_9_V) ; -- status=guess, src=wikt
lin negotiate_V2 = mkV2 (aushandeln_9_V) ; -- status=guess, src=wikt
lin negotiate_V = aushandeln_9_V ; -- status=guess, src=wikt
lin host_N = wirt_N ; -- status=guess
lin relative_N = mkN "Verwandter" masculine | mkN "Verwandte" feminine ; -- status=guess status=guess
lin mass_A = variants{} ; -- 
lin helpful_A = hilfreich_A ; -- status=guess
lin fellow_N = kollege_N | partner_N ; -- status=guess status=guess
lin sweep_V2 = mkV2 (fegen_7_V) | mkV2 (kehren_4_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin sweep_V = fegen_7_V | kehren_4_V ; -- status=guess, src=wikt status=guess, src=wikt
lin poet_N = poet_N | dichter_N | dichterin_N ; -- status=guess status=guess status=guess
lin journalist_N = journalist_N | mkN "Journalistin" feminine ; -- status=guess status=guess
lin defeat_N = niederlage_N ; -- status=guess
lin unlike_Prep = variants{} ; -- 
lin primarily_Adv = variants{} ; -- 
lin tight_A = mkA "tight" ; -- status=guess
lin indication_N = variants{} ; -- 
lin dry_V2 = mkV2 (trocknen_V) ; -- status=guess, src=wikt
lin dry_V = trocknen_V ; -- status=guess, src=wikt
lin cricket_N = mkN "Cricket" neuter | mkN "Kricket" neuter ; -- status=guess status=guess
lin whisper_V2 = mkV2 (mkV "flüstern") | mkV2 (wispern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin whisper_V = mkV "flüstern" | wispern_V ; -- status=guess, src=wikt status=guess, src=wikt
lin routine_N = mkN "Routine" feminine ; -- status=guess
lin print_N = variants{} ; -- 
lin anxiety_N = mkN "Besorgnis" feminine | angst_N ; -- status=guess status=guess
lin witness_N = zeuge_N | zeugin_N ; -- status=guess status=guess
lin concerning_Prep = variants{} ; -- 
lin mill_N = fabrik_N | werk_N | mkN "Papiermühle" feminine ; -- status=guess status=guess status=guess
lin gentle_A = mkA "einfühlsam" ; -- status=guess
lin curtain_N = vorhang_N | gardine_N ; -- status=guess status=guess
lin mission_N = mission_N ; -- status=guess
lin supplier_N = lieferant_N ; -- status=guess
lin basically_Adv = mkAdv "im Prinzip" ; -- status=guess
lin assure_V2S = variants{} ; -- 
lin assure_V2 = variants{} ; -- 
lin poverty_N = mkN "Armut" feminine ; -- status=guess
lin snow_N = L.snow_N ;
lin prayer_N = gebetsteppich_N ; -- status=guess
lin pipe_N = mkN "Rohrbombe" feminine ; -- status=guess
lin deserve_VV = mkVV (verdienen_V) ; -- status=guess, src=wikt
lin deserve_V2 = mkV2 (verdienen_V) ; -- status=guess, src=wikt
lin deserve_V = verdienen_V ; -- status=guess, src=wikt
lin shift_N = verschiebung_N | mkN "Verlagerung" feminine | mkN "Verstellung" feminine ; -- status=guess status=guess status=guess
lin split_V2 = L.split_V2 ;
lin split_V = spalten_V ; -- status=guess, src=wikt
lin near_Adv = mkAdv "nah" ; -- status=guess
lin consistent_A = mkA "widerspruchsfrei" | konsistent_A ; -- status=guess status=guess
lin carpet_N = L.carpet_N ;
lin ownership_N = mkN "Besitz" masculine ; -- status=guess
lin joke_N = witz_N ; -- status=guess
lin fewer_Det = M.detLikeAdj False M.Pl "weniger" ;
lin workshop_N = mkN "Workshop" masculine ; -- status=guess
lin salt_N = L.salt_N ;
lin aged_Prep = variants{} ; -- 
lin symbol_N = symbol_N | zeichen_N ; -- status=guess status=guess
lin slide_V2 = mkV2 (gleiten_V) ; -- status=guess, src=wikt
lin slide_V = gleiten_V ; -- status=guess, src=wikt
lin cross_N = kreuzung_N ; -- status=guess
lin anxious_A = mkA "ängstlich" | besorgt_A ; -- status=guess status=guess
lin tale_N = mkN "Märchen" neuter | sage_N | geschichte_N | mkN "Erzählung" feminine ; -- status=guess status=guess status=guess status=guess
lin preference_N = variants{} ; -- 
lin inevitably_Adv = mkAdv "zwangsläufig" ; -- status=guess
lin mere_A = variants{} ; -- 
lin behave_V = mkReflV "benehmen" ; -- status=guess, src=wikt
lin gain_N = gewinn_und_verlust_rechnung_N ; -- status=guess
lin nervous_A = mkA "nervös" ; -- status=guess
lin guide_V2 = variants{} ; -- 
lin remark_N = bemerkung_N ; -- status=guess
lin pleased_A = froh_A | zufrieden_A ; -- status=guess status=guess
lin province_N = provinz_N | mkN "Land" neuter ; -- status=guess status=guess
lin steel_N = L.steel_N ;
lin practise_V2 = variants{} ; -- 
lin practise_V = variants{} ; -- 
lin flow_V = L.flow_V ;
lin holy_A = heilig_A ; -- status=guess
lin dose_N = dosis_N ; -- status=guess
lin alcohol_N = alkohol_N | mkN "Weingeist" | branntwein_N ; -- status=guess status=guess status=guess
lin guidance_N = anleitung_N | mkN "Richtungsweisung" feminine | mkN "Handlungsempfehlung" feminine | mkN "Orientierungshilfe" feminine ; -- status=guess status=guess status=guess status=guess
lin constantly_Adv = variants{} ; -- 
lin climate_N = mkN "Klimaveränderung" feminine | klimawandel_N ; -- status=guess status=guess
lin enhance_V2 = mkV2 (mkV "erhöhen") | mkV2 (mkV "vergrößern") ; -- status=guess, src=wikt status=guess, src=wikt
lin reasonably_Adv = mkAdv "einigermaßen" ; -- status=guess
lin waste_V2 = mkV2 (junkV (mkV "Zeit") "vergeuden") ; -- status=guess, src=wikt
lin waste_V = junkV (mkV "Zeit") "vergeuden" ; -- status=guess, src=wikt
lin smooth_A = L.smooth_A ;
lin dominant_A = dominant_A ; -- status=guess
lin conscious_A = mkA "bei Bewusstsein" | wach_A | aufmerksam_A ; -- status=guess status=guess status=guess
lin formula_N = formel_N ; -- status=guess
lin tail_N = L.tail_N ;
lin ha_Interj = variants{} ; -- 
lin electric_A = elektrisch_A ; -- status=guess
lin sheep_N = L.sheep_N ;
lin medicine_N = medizin_N ; -- status=guess
lin strategic_A = strategisch_A ; -- status=guess
lin disabled_A = behindert_A ; -- status=guess
lin smell_N = geruch_N ; -- status=guess
lin operator_N = operator_N | mkN "Rechenzeichen" neuter ; -- status=guess status=guess
lin mount_V2 = mkV2 (befestigen_V) | mkV2 (anbringen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin mount_V = befestigen_V | anbringen_9_V ; -- status=guess, src=wikt status=guess, src=wikt
lin advance_V2 = mkV2 (mkV "vorrücken") ; -- status=guess, src=wikt
lin advance_V = mkV "vorrücken" ; -- status=guess, src=wikt
lin remote_A = fern_A | entfernt_A | mkA "abgelegen" | mkA "fernbetrieb" ; -- status=guess status=guess status=guess status=guess
lin measurement_N = messung_N ; -- status=guess
lin favour_VS = variants{} ; -- 
lin favour_V2 = variants{} ; -- 
lin favour_V = variants{} ; -- 
lin neither_Det = variants{} ; -- 
lin architecture_N = architektur_N ; -- status=guess
lin worth_N = wert_N ; -- status=guess
lin tie_N = mkN "Unentschieden" neuter | mkN "Remis" neuter ; -- status=guess status=guess
lin barrier_N = grenze_N ; -- status=guess
lin practitioner_N = variants{} ; -- 
lin outstanding_A = hervorragend_A ; -- status=guess
lin enthusiasm_N = begeisterung_N | mkN "Enthusiasmus" masculine | mkN "Schwärmerei" feminine ; -- status=guess status=guess status=guess
lin theoretical_A = theoretisch_A ; -- status=guess
lin implementation_N = implementierung_N ; -- status=guess
lin worried_A = besorgt_A ; -- status=guess
lin pitch_N = pech_N ; -- status=guess
lin drop_N = fall_N | sturz_N ; -- status=guess status=guess
lin phone_V2 = mkV2 (anrufen_7_V) | mkV2 (telefonieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin phone_V = anrufen_7_V | telefonieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin shape_VV = mkVV (formen_8_V) ; -- status=guess, src=wikt
lin shape_V2 = mkV2 (formen_8_V) ; -- status=guess, src=wikt
lin shape_V = formen_8_V ; -- status=guess, src=wikt
lin clinical_A = klinisch_A ; -- status=guess
lin lane_N = spur_N | mkN "Route" feminine ; -- status=guess status=guess
lin apple_N = L.apple_N ;
lin catalogue_N = katalog_N | liste_N | verzeichnis_N ; -- status=guess status=guess status=guess
lin tip_N = spitze_N ; -- status=guess
lin publisher_N = herausgeber_N | mkN "Herausgeberin" feminine | verlag_N ; -- status=guess status=guess status=guess
lin opponentMasc_N = gegner_N | gegenspieler_N ; -- status=guess status=guess
lin live_A = scharf_A ; -- status=guess
lin burden_N = sorge_N | mkN "Bürde" feminine ; -- status=guess status=guess
lin tackle_V2 = mkV2 (junkV (mkV "in") "Angriff nehmen") ; -- status=guess, src=wikt
lin tackle_V = junkV (mkV "in") "Angriff nehmen" ; -- status=guess, src=wikt
lin historian_N = historiker_N | historikerin_N ; -- status=guess status=guess
lin bury_V2 = mkV2 (vergraben_V) ; -- status=guess, src=wikt
lin bury_V = vergraben_V ; -- status=guess, src=wikt
lin stomach_N = bauch_N ; -- status=guess
lin percentage_N = mkN "Prozentsatz" masculine ; -- status=guess
lin evaluation_N = beurteilung_N ; -- status=guess
lin outline_V2 = variants{} ; -- 
lin talent_N = talent_N | begabung_N ; -- status=guess status=guess
lin lend_V2 = mkV2 (leihen_V) | mkV2 (verleihen_V) | mkV2 (borgen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lend_V = leihen_V | verleihen_V | borgen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin silver_N = L.silver_N ;
lin pack_N = kartenspiel__N | mkN "Kartenstapel" masculine ; -- status=guess status=guess
lin fun_N = mkN "Spaß" masculine | mkN "Vergnügen" neuter | mkN "Amüsement" neuter ; -- status=guess status=guess status=guess
lin democrat_N = demokrat_N | mkN "Demokratin" feminine ; -- status=guess status=guess
lin fortune_N = mkN "Glück" neuter ; -- status=guess
lin storage_N = speicher_N ; -- status=guess
lin professional_N = profi_N ; -- status=guess
lin reserve_N = mkN "Schutzgebiet" neuter ; -- status=guess
lin interval_N = abstand_N | mkN "Zwischenraum" masculine ; -- status=guess status=guess
lin dimension_N = dimension_N ; -- status=guess
lin honest_A = ehrlich_A | aufrichtig_A ; -- status=guess status=guess
lin awful_A = schrecklich_A | furchtbar_A ; -- status=guess status=guess
lin manufacture_V2 = mkV2 (herstellen_V) ; -- status=guess, src=wikt
lin confusion_N = verwirrung_N ; -- status=guess
lin pink_A = variants{} ; -- 
lin impressive_A = mkA "beeindruckend" | eindrucksvoll_A | mkA "imposant" ; -- status=guess status=guess status=guess
lin satisfaction_N = mkN "Befriedigung" feminine ; -- status=guess
lin visible_A = sichtbar_A ; -- status=guess
lin vessel_N = mkN "Gefäß" neuter | mkN "Behälter" masculine | mkN "Behältnis" neuter ; -- status=guess status=guess status=guess
lin stand_N = mkN "Ständer" masculine | stativ_N ; -- status=guess status=guess
lin curve_N = kurve_N ; -- status=guess
lin pot_N = schlagloch_N ; -- status=guess
lin replacement_N = ersatz_N | mkN "Ersatzspieler" masculine ; -- status=guess status=guess
lin accurate_A = genau_A | mkA "präzise" | exakt_A ; -- status=guess status=guess status=guess
lin mortgage_N = hypothek_N ; -- status=guess
lin salary_N = gehalt_N ; -- status=guess
lin impress_V2 = variants{} ; -- 
lin impress_V = variants{} ; -- 
lin constitutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (betonen_V) ; -- status=guess, src=wikt
lin emphasize_V2 = mkV2 (betonen_V) ; -- status=guess, src=wikt
lin developing_A = mkA "entwickelnd" | mkA "Entwicklungs-" ; -- status=guess status=guess
lin proof_N = beweis_N ; -- status=guess
lin furthermore_Adv = weiterhin_Adv | mkAdv "darüber hinaus" ; -- status=guess status=guess
lin dish_N = gericht_N ; -- status=guess
lin interview_V2 = mkV2 (interviewen_V) ; -- status=guess, src=wikt
lin considerably_Adv = mkAdv "wesentlich" | mkAdv "beträchtlich" | mkAdv "beachtlich" ; -- status=guess status=guess status=guess
lin distant_A = fern_A | entfernt_A | mkA "distanziert" | mkA "abstehend" ; -- status=guess status=guess status=guess status=guess
lin lower_V2 = mkV2 (mkV "herunterlassen") ; -- status=guess, src=wikt
lin lower_V = mkV "herunterlassen" ; -- status=guess, src=wikt
lin favouriteMasc_N = liebling_N ; -- status=guess
lin tear_V2 = mkV2 (mkV "tränen") ; -- status=guess, src=wikt
lin tear_V = mkV "tränen" ; -- status=guess, src=wikt
lin fixed_A = fixiert_A | fix_A ; -- status=guess status=guess
lin by_Adv = mkAdv "längs" ; -- status=guess
lin luck_N = mkN "Glück" neuter ; -- status=guess
lin count_N = mkN "zählbares Nomen" neuter ; -- status=guess
lin precise_A = mkA "präzise" | genau_A ; -- status=guess status=guess
lin determination_N = determination_N ; -- status=guess
lin bite_V2 = L.bite_V2 ;
lin bite_V = junkV (mkV "in") "den sauren Apfel beissen" ; -- status=guess, src=wikt
lin dear_Interj = variants{} ; -- 
lin consultation_N = variants{} ; -- 
lin range_V = variants{} ; -- 
lin residential_A = mkA "wohn-" | mkA "Wohn-" ; -- status=guess status=guess
lin conduct_N = variants{} ; -- 
lin capture_V2 = mkV2 (fangen_8_V) | mkV2 (einfangen_1_V) | mkV2 (junkV (mkV "gefangen") "nehmen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin ultimately_Adv = mkAdv "schließlich" ; -- status=guess
lin cheque_N = scheck_N ; -- status=guess
lin economics_N = mkN "Ökonomie" feminine | wirtschaftswissenschaft_N ; -- status=guess status=guess
lin sustain_V2 = variants{} ; -- 
lin secondly_Adv = zweitens_Adv ; -- status=guess
lin silly_A = doof_A ; -- status=guess
lin merchant_N = kaufmann_N | mkN "Kauffrau" feminine ; -- status=guess status=guess
lin lecture_N = vorlesung_N | vortrag_N ; -- status=guess status=guess
lin musical_A = musikalisch_A ; -- status=guess
lin leisure_N = mkN "Muße" feminine ; -- status=guess
lin check_N = rechnung_N ; -- status=guess
lin cheese_N = L.cheese_N ;
lin lift_N = auftrieb_N ; -- status=guess
lin participate_V2 = mkV2 (teilnehmen_V) ; -- status=guess, src=wikt
lin participate_V = teilnehmen_V ; -- status=guess, src=wikt
lin fabric_N = mkN "Bau" masculine | rohbau_N | struktur_N ; -- status=guess status=guess status=guess
lin distribute_V2 = mkV2 (verteilen_V) ; -- status=guess, src=wikt
lin lover_N = mkN "Geliebter" masculine | mkN "Geliebte" feminine ; -- status=guess status=guess
lin childhood_N = mkN "Kindheit" feminine ; -- status=guess
lin cool_A = in_A | ganz_A | mkA "alles klar" | akzeptabel_A ; -- status=guess status=guess status=guess status=guess
lin ban_V2 = mkV2 (verbieten_V) ; -- status=guess, src=wikt
lin supposed_A = vermeintlich_A ; -- status=guess
lin mouse_N = mkN "Braunflügel-Ameisenwürger" masculine ; -- status=guess
lin strain_N = stamm_N ; -- status=guess
lin specialist_A = variants{} ; -- 
lin consult_V2 = variants{} ; -- 
lin consult_V = variants{} ; -- 
lin minimum_A = minimal_A ; -- status=guess
lin approximately_Adv = mkAdv "ungefähr" | etwa_Adv ; -- status=guess status=guess
lin participant_N = teilnehmer_N | mkN "Teilnehmerin" feminine ; -- status=guess status=guess
lin monetary_A = mkA "monetär" | mkA "Geld-" ; -- status=guess status=guess
lin confuse_V2 = mkV2 (junkV (mkV "jemanden") "in Verlegenheit {f} bringen") ; -- status=guess, src=wikt
lin dare_VV = mkVV (riskieren_V) ; -- status=guess, src=wikt
lin dare_V2 = mkV2 (riskieren_V) ; -- status=guess, src=wikt
lin smoke_N = L.smoke_N ;
lin movie_N = film_N | spielfilm_N ; -- status=guess status=guess
lin seed_N = L.seed_N ;
lin cease_V2 = mkV2 (junkV (mkV "hören") "Sie auf und verzichten Sie") ; -- status=guess, src=wikt
lin cease_V = junkV (mkV "hören") "Sie auf und verzichten Sie" ; -- status=guess, src=wikt
lin open_Adv = variants{} ; -- 
lin journal_N = tagebuch_N | logbuch_N ; -- status=guess status=guess
lin shopping_N = mkN "Einkaufen" neuter | mkN "Einkäufe {m} {p}" ; -- status=guess status=guess
lin equivalent_N = mkN "Entsprechung" feminine | mkN "Äquivalent" neuter ; -- status=guess status=guess
lin palace_N = palast__N | mkN "Schloss" neuter ; -- status=guess status=guess
lin exceed_V2 = variants{} ; -- 
lin isolated_A = variants{} ; -- 
lin poetry_N = poesie_N | mkN "Dichtkunst" feminine ; -- status=guess status=guess
lin perceive_VS = mkVS (wahrnehmen_5_V) ; -- status=guess, src=wikt
lin perceive_V2V = mkV2V (wahrnehmen_5_V) ; -- status=guess, src=wikt
lin perceive_V2 = mkV2 (wahrnehmen_5_V) ; -- status=guess, src=wikt
lin lack_V2 = mkV2 (mangeln_V) | mkV2 (fehlen_V) ;
lin lack_V = mangeln_V | fehlen_V ;
lin strengthen_V2 = mkV2 (mkV "bestärken") | mkV2 (mkV "stärken") ; -- status=guess, src=wikt status=guess, src=wikt
lin snap_V2 = mkV2 (mkV "zurückpassen") ; -- status=guess, src=wikt
lin snap_V = mkV "zurückpassen" ; -- status=guess, src=wikt
lin readily_Adv = mkAdv "bereitwillig" ; -- status=guess
lin spite_N = mkN "Boshaftigkeit" feminine | mkN "Gehässigkeit" feminine ; -- status=guess status=guess
lin conviction_N = mkN "Überzeugung" feminine ; -- status=guess
lin corridor_N = korridor_N ; -- status=guess
lin behind_Adv = variants{}; -- S.behind_Prep ;
lin ward_N = wache_N ; -- status=guess
lin profile_N = variants{} ; -- 
lin fat_A = dick_A | fett_A ; -- status=guess status=guess
lin comfort_N = mkN "Trost" masculine | mkN "Tröstung" feminine ; -- status=guess status=guess
lin bathroom_N = badezimmer_N | bad_N ; -- status=guess status=guess
lin shell_N = mkN "Schalentier" neuter | muschel_N ; -- status=guess status=guess
lin reward_N = belohnung_N ; -- status=guess
lin deliberately_Adv = mkAdv "mit Absicht" | mkAdv "absichtlich" ; -- status=guess status=guess
lin automatically_Adv = variants{} ; -- 
lin vegetable_N = mkN "Dahinvegetierende {m}" feminine ; -- status=guess
lin imagination_N = vorstellung_N ; -- status=guess
lin junior_A = mkA "jünger" ; -- status=guess
lin unemployed_A = arbeitslos_A ; -- status=guess
lin mystery_N = mkN "Rätsel" neuter ; -- status=guess
lin pose_V2 = mkV2 (stellen_4_V) ; -- status=guess, src=wikt
lin pose_V = stellen_4_V ; -- status=guess, src=wikt
lin violent_A = grell_A ; -- status=guess
lin march_N = marsch_N ; -- status=guess
lin found_V2 = mkV2 (errichten_V) ; -- status=guess, src=wikt
lin dig_V2 = mkV2 (graben_0_V) ; -- status=guess, src=wikt
lin dig_V = L.dig_V ;
lin dirty_A = L.dirty_A ;
lin straight_A = L.straight_A ;
lin psychological_A = mkA "psychologisch" ; -- status=guess
lin grab_V2 = mkV2 (greifen_8_V) ; -- status=guess, src=wikt
lin grab_V = greifen_8_V ; -- status=guess, src=wikt
lin pleasant_A = angenehm_A ; -- status=guess
lin surgery_N = praxis_N ; -- status=guess
lin inevitable_A = mkA "unvermeidlich" | mkA "unabwendbar" ; -- status=guess status=guess
lin transform_V2 = mkV2 (umwandeln_V) ; -- status=guess, src=wikt
lin bell_N = mkN "Schlaghose" feminine ; -- status=guess
lin announcement_N = mkN "Ankündigung" feminine ; -- status=guess
lin draft_N = mkN "Musterung" feminine ; -- status=guess
lin unity_N = einheit_N ; -- status=guess
lin airport_N = flughafen_N | flugplatz_N ; -- status=guess status=guess
lin upset_V2 = mkV2 (mkV "umstoßen") | mkV2 (mkV "stürzen") | mkV2 (umwerfen_5_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin upset_V = mkV "umstoßen" | mkV "stürzen" | umwerfen_5_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pretend_VS = mkVS (vorgeben_0_V) ; -- status=guess, src=wikt
lin pretend_V2 = mkV2 (vorgeben_0_V) ; -- status=guess, src=wikt
lin pretend_V = vorgeben_0_V ; -- status=guess, src=wikt
lin plant_V2 = mkV2 (pflanzen_9_V) ; -- status=guess, src=wikt
lin till_Prep = variants{} ; -- 
lin known_A = bekannt_A ; -- status=guess
lin admission_N = variants{} ; -- 
lin tissue_N = gewebe_N ; -- status=guess
lin magistrate_N = variants{} ; -- 
lin joy_N = freude_N ; -- status=guess
lin free_V2V = mkV2V (befreien_V) | mkV2V (freisetzen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin free_V2 = mkV2 (befreien_V) | mkV2 (freisetzen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin pretty_A = mkA "hübsch" | mkA "schön" ; -- status=guess status=guess
lin operating_N = operationssaal_N ; -- status=guess
lin headquarters_N = zentrale_N ; -- status=guess
lin grateful_A = mkA "wohltuend" | zufrieden_A ; -- status=guess status=guess
lin classroom_N = klassenzimmer_N ; -- status=guess
lin turnover_N = fluktuation_N ; -- status=guess
lin project_VS = mkVS (mkV "ragen") | mkVS (mkV "hervorragen") | mkVS (mkV "herausragen") | mkVS (mkV "vorspringen") | mkVS (mkV "vorstehen") | mkVS (mkV "überstehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin project_V2V = mkV2V (mkV "ragen") | mkV2V (mkV "hervorragen") | mkV2V (mkV "herausragen") | mkV2V (mkV "vorspringen") | mkV2V (mkV "vorstehen") | mkV2V (mkV "überstehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin project_V2 = mkV2 (mkV "ragen") | mkV2 (mkV "hervorragen") | mkV2 (mkV "herausragen") | mkV2 (mkV "vorspringen") | mkV2 (mkV "vorstehen") | mkV2 (mkV "überstehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin project_V = mkV "ragen" | mkV "hervorragen" | mkV "herausragen" | mkV "vorspringen" | mkV "vorstehen" | mkV "überstehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shrug_V2 = mkV2 (junkV (mkV "mit") "den Schultern zucken") | mkV2 (junkV (mkV "mit") "den Achseln zucken") ; -- status=guess, src=wikt status=guess, src=wikt
lin sensible_A = mkA "vernünftig" ; -- status=guess
lin limitation_N = mkN "Begrenzung" ; -- status=guess
lin specialist_N = spezialist_N | mkN "Fachmann" masculine | experte_N ; -- status=guess status=guess status=guess
lin newly_Adv = mkAdv "neu" ; -- status=guess
lin tongue_N = L.tongue_N ;
lin refugee_N = mkN "Flüchtlingslager" neuter ; -- status=guess
lin delay_V2 = mkV2 (mkV "verspäten") | mkV2 (verschieben_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin delay_V = mkV "verspäten" | verschieben_V ; -- status=guess, src=wikt status=guess, src=wikt
lin dream_V2 = mkV2 (mkV "träumen") ; -- status=guess, src=wikt
lin dream_V = mkV "träumen" ; -- status=guess, src=wikt
lin composition_N = zusammenstellung_N ; -- status=guess
lin alongside_Prep = variants{} ; -- 
lin ceiling_N = L.ceiling_N ;
lin highlight_V2 = mkV2 (hervorheben_8_V) | mkV2 (beleuchten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin stick_N = L.stick_N ;
lin favourite_A = variants{} ; -- 
lin tap_V2 = mkV2 (mkV "anzapfen") ; -- status=guess, src=wikt
lin tap_V = mkV "anzapfen" ; -- status=guess, src=wikt
lin universe_N = universum_N ; -- status=guess
lin request_VS = mkVS (mkV "erbitten") ; -- status=guess, src=wikt
lin request_V2 = mkV2 (mkV "erbitten") ; -- status=guess, src=wikt
lin label_N = mkN "Etikett" neuter | mkN "Beschriftung" feminine ; -- status=guess status=guess
lin confine_V2 = mkV2 (mkV "beschränken") ; -- status=guess, src=wikt
lin scream_VS = mkVS (schreien_V) ; -- status=guess, src=wikt
lin scream_V2 = mkV2 (schreien_V) ; -- status=guess, src=wikt
lin scream_V = schreien_V ; -- status=guess, src=wikt
lin rid_V2 = variants{} ; -- 
lin acceptance_N = mkN "Akzeptanz" feminine ; -- status=guess
lin detective_N = detektiv_N | mkN "Privatdetektiv" masculine | mkN "Privatermittler" masculine | mkN "Schnüffler" masculine | mkN "pejorative]" ; -- status=guess status=guess status=guess status=guess status=guess
lin sail_V = segeln_8_V ; -- status=guess, src=wikt
lin adjust_V2 = mkV2 (berichtigen_V) ; -- status=guess, src=wikt
lin adjust_V = berichtigen_V ; -- status=guess, src=wikt
lin designer_N = designer_N ; -- status=guess
lin running_A = variants{} ; -- 
lin summit_N = gipfeltreffen_N | gipfel_N ; -- status=guess status=guess
lin participation_N = partizipation_N | beteiligung_N | teilnahme_N ; -- status=guess status=guess status=guess
lin weakness_N = mkN "Schwäche" feminine ; -- status=guess
lin block_V2 = mkV2 (abblocken_V) ; -- status=guess, src=wikt
lin socalled_A = variants{} ; -- 
lin adapt_V2 = mkV2 (anpassen_V) ; -- status=guess, src=wikt
lin adapt_V = anpassen_V ; -- status=guess, src=wikt
lin absorb_V2 = mkV2 (absorbieren_V) ; -- status=guess, src=wikt
lin encounter_V2 = mkV2 (treffen_9_V) | mkV2 (begegnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin defeat_V2 = mkV2 (schlagen_5_V) | mkV2 (besiegen_V) | mkV2 (mkV "niederringen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin excitement_N = aufregung_N ; -- status=guess
lin brick_N = ziegel_N ; -- status=guess
lin blind_A = blind_A ; -- status=guess
lin wire_N = mkN "Seitenschneider" masculine ; -- status=guess
lin crop_N = kornkreis_N ; -- status=guess
lin square_A = rechtwinklig_A ; -- status=guess
lin transition_N = mkN "Übergang" masculine ; -- status=guess
lin thereby_Adv = dadurch_Adv | damit_Adv ; -- status=guess status=guess
lin protest_V2 = mkV2 (junkV (mkV "Einspruch") "erheben") | mkV2 (junkV (mkV "Einwände") "äußern") ; -- status=guess, src=wikt status=guess, src=wikt
lin protest_V = junkV (mkV "Einspruch") "erheben" | junkV (mkV "Einwände") "äußern" ; -- status=guess, src=wikt status=guess, src=wikt
lin roll_N = das_nbsplarsen_system_N | das_nbsplarsen_system_N ; -- status=guess status=guess
lin stop_N = stopper_N ; -- status=guess
lin assistant_N = assistent_N | mitarbeiter_N | helfer_N ; -- status=guess status=guess status=guess
lin deaf_A = taub_A | mkA "gehörlos" ; -- status=guess status=guess
lin constituency_N = mkN "Wahlkreis" masculine ; -- status=guess
lin continuous_A = kontinuierlich_A | stetig_A ; -- status=guess status=guess
lin concert_N = konzert_N ; -- status=guess
lin breast_N = L.breast_N ;
lin extraordinary_A = mkA "außerordentlich" | mkA "außergewöhnlich" ; -- status=guess status=guess
lin squad_N = gruppe_N ; -- status=guess
lin wonder_N = wunder_N | mirakel_N ; -- status=guess status=guess
lin cream_N = mkN "Frischkäse" masculine ; -- status=guess
lin tennis_N = mkN "Tennis" neuter ; -- status=guess
lin personally_Adv = variants{} ; -- 
lin communicate_V2 = mkV2 (kommunizieren_V) ; -- status=guess, src=wikt
lin communicate_V = kommunizieren_V ; -- status=guess, src=wikt
lin pride_N = rudel_N ; -- status=guess
lin bowl_N = schale_N | mkN "Schüssel" feminine ; -- status=guess status=guess
lin file_V2 = mkV2 (feilen_V) ; -- status=guess, src=wikt
lin file_V = feilen_V ; -- status=guess, src=wikt
lin expertise_N = expertise_N ; -- status=guess
lin govern_V2 = mkV2 (regulieren_V) ; -- status=guess, src=wikt
lin govern_V = regulieren_V ; -- status=guess, src=wikt
lin leather_N = L.leather_N ;
lin observer_N = beobachter_N | beobachterin_N ; -- status=guess status=guess
lin margin_N = mkN "Seitenrand" masculine ; -- status=guess
lin uncertainty_N = unsicherheit__N ; -- status=guess
lin reinforce_V2 = mkV2 (mkV "verstärken") ; -- status=guess, src=wikt
lin ideal_N = ideal_N ; -- status=guess
lin injure_V2 = mkV2 (verletzen_V) ; -- status=guess, src=wikt
lin holding_N = mkN "Holding-Gesellschaft" feminine ; -- status=guess
lin universal_A = allgemein_A | mkA "Universal-" | universell_A ; -- status=guess status=guess status=guess
lin evident_A = variants{} ; -- 
lin dust_N = L.dust_N ;
lin overseas_A = mkA "ausländisch" ;
lin desperate_A = mkA "verzweifelt" ; -- status=guess
lin swim_V2 = mkV2 (schwimmen_V) ; -- status=guess, src=wikt
lin swim_V = L.swim_V ;
lin occasional_A = gelegentlich_A | okkasionell_A ; -- status=guess status=guess
lin trouser_N = variants{} ; -- 
lin surprisingly_Adv = mkAdv "überraschend" ; -- status=guess
lin register_N = register_N ; -- status=guess
lin album_N = album_N ; -- status=guess
lin guideline_N = richtlinie_N ; -- status=guess
lin disturb_V2 = mkV2 (mkV "stören") ; -- status=guess, src=wikt
lin amendment_N = mkN "Änderung" feminine | mkN "Gesetzesänderung" feminine ; -- status=guess status=guess
lin architectMasc_N = architekt_N | architektin_N ; -- status=guess status=guess
lin objection_N = mkN "Beanstandung" feminine ; -- status=guess
lin chart_N = karte_N ; -- status=guess
lin cattle_N = mkN "Vieh" neuter ; -- status=guess
lin doubt_VS = mkVS (mkV "bezweifeln") | mkVS (zweifeln_2_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin doubt_V2 = mkV2 (mkV "bezweifeln") | mkV2 (zweifeln_2_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin react_V = reagieren_V ; -- status=guess, src=wikt
lin consciousness_N = mkN "Bewusstsein" neuter ; -- status=guess
lin right_Interj = mkInterj "nicht wahr?" | mkInterj "oder?" ; -- status=guess status=guess
lin purely_Adv = variants{} ; -- 
lin tin_N = mkN "Büchse" feminine | mkN "Konservenbüchse" feminine | mkN "Blechbüchse" feminine | dose_N | konservendose_N ; -- status=guess status=guess status=guess status=guess status=guess
lin tube_N = rohr_N | mkN "Röhre" feminine ; -- status=guess status=guess
lin fulfil_V2 = mkV2 (mkV "erfüllen") ; -- status=guess, src=wikt
lin commonly_Adv = mkAdv "häufig" ; -- status=guess
lin sufficiently_Adv = variants{} ; -- 
lin coin_N = chip_N ; -- status=guess
lin frighten_V2 = mkV2 (junkV (mkV "Angst") "machen") | mkV2 (erschrecken_V) | mkV2 (schrecken_4_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grammar_N = L.grammar_N ;
lin diary_N = tagebuch_N ; -- status=guess
lin flesh_N = mkN "Fleisch" neuter ; -- status=guess
lin summary_N = zusammenfassung_N ; -- status=guess
lin infant_N = mkN "Säugling" masculine | baby_N ; -- status=guess status=guess
lin stir_V2 = mkV2 (mkV "pfannenrühren") ; -- status=guess, src=wikt
lin stir_V = mkV "pfannenrühren" ; -- status=guess, src=wikt
lin storm_N = sturm_und_drang_zeit_N ; -- status=guess
lin mail_N = mkN "Kettenpanzer" | kettenhemd_N ; -- status=guess status=guess
lin rugby_N = mkN "Rugby" masculine ; -- status=guess
lin virtue_N = tugend_N ; -- status=guess
lin specimen_N = exemplar_N | muster_N ; -- status=guess status=guess
lin psychology_N = mkN "Psychologie" feminine | mkN "Seelenkunde" feminine ; -- status=guess status=guess
lin paint_N = farbe_N | lack_N ; -- status=guess status=guess
lin constraint_N = mkN "Einschränkung" feminine | mkN "Beschränkung" feminine ; -- status=guess status=guess
lin trace_V2 = variants{} ; -- 
lin trace_V = variants{} ; -- 
lin privilege_N = mkN "Privileg" neuter ; -- status=guess
lin completion_N = mkN "Vervollständigung" feminine ; -- status=guess
lin progress_V2 = variants{} ; -- 
lin progress_V = variants{} ; -- 
lin grade_N = grad_N | sorte_N ; -- status=guess status=guess
lin exploit_V2 = mkV2 (ausnutzen_7_V) | mkV2 (mkV "ausbeuten") ; -- status=guess, src=wikt status=guess, src=wikt
lin import_N = import_N | einfuhr_N ; -- status=guess status=guess
lin potato_N = kartoffel_N | mkN "" | mkN "Switzerland" | mkN "Austria] Erdapfel" masculine ; -- status=guess status=guess status=guess status=guess
lin repair_N = reparatur_N ; -- status=guess
lin passion_N = leidenschaft_N | passion_N ; -- status=guess status=guess
lin seize_V2 = mkV2 (ergreifen_V) | mkV2 (fassen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin seize_V = ergreifen_V | fassen_0_V ; -- status=guess, src=wikt status=guess, src=wikt
lin low_Adv = mkAdv "tief" ; -- status=guess
lin underlying_A = implizit_A ; -- status=guess
lin heaven_N = himmel__N ; -- status=guess
lin nerve_N = nerv_N ; -- status=guess
lin park_V2 = mkV2 (parken_V) ; -- status=guess, src=wikt
lin park_V = parken_V ; -- status=guess, src=wikt
lin collapse_V2 = mkV2 (mkV "zusammenbrechen") | mkV2 (kollabieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin collapse_V = mkV "zusammenbrechen" | kollabieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin win_N = variants{} ; -- 
lin printer_N = drucker_N ; -- status=guess
lin coalition_N = koalition_N ; -- status=guess
lin button_N = taste_N ; -- status=guess
lin pray_V2 = mkV2 (bitten_0_V) | mkV2 (mkV "erbitten") ; -- status=guess, src=wikt status=guess, src=wikt
lin pray_V = bitten_0_V | mkV "erbitten" ; -- status=guess, src=wikt status=guess, src=wikt
lin ultimate_A = ultimativ_A ; -- status=guess
lin venture_N = mkN "Risikokapitalgeber" masculine ; -- status=guess
lin timber_N = holz_N ; -- status=guess
lin companion_N = mkN "Gefährte" masculine | mkN "Gefährtin" feminine | mkN "Kompagnon" masculine ; -- status=guess status=guess status=guess
lin horror_N = mkN "Horror" masculine | mkN "Grauen" neuter ; -- status=guess status=guess
lin gesture_N = geste_N ; -- status=guess
lin moon_N = L.moon_N ;
lin remark_VS = variants{} ; -- 
lin remark_V = variants{} ; -- 
lin clever_A = L.clever_A ;
lin van_N = transporter_N | lieferwagen_N ; -- status=guess status=guess
lin consequently_Adv = variants{} ; -- 
lin raw_A = roh_A ; -- status=guess
lin glance_N = blick_N | mkN "Streifblick" masculine ; -- status=guess status=guess
lin broken_A = gebrochen_A | mkA "zerstört" ; -- status=guess status=guess
lin jury_N = jury_N ; -- status=guess
lin gaze_V = anstarren_V ; -- status=guess, src=wikt
lin burst_V2 = mkV2 (platzen_V) | mkV2 (zerplatzen_V) | mkV2 (bersten_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin burst_V = platzen_V | zerplatzen_V | bersten_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin charter_N = charta_N ; -- status=guess
lin feministMasc_N = mkN "Feminist" masculine | mkN "Feministin" feminine ; -- status=guess status=guess
lin discourse_N = diskurs_N ; -- status=guess
lin reflection_N = reflexion_N | abbild_N ; -- status=guess status=guess
lin carbon_N = kohlenstoff_N ; -- status=guess
lin sophisticated_A = raffiniert_A ; -- status=guess
lin ban_N = verbot_N ; -- status=guess
lin taxation_N = mkN "Besteuerung" feminine ; -- status=guess
lin prosecution_N = variants{} ; -- 
lin softly_Adv = variants{} ; -- 
lin asleep_A = mkA "use a form of the verb schlafen" | mkA "schlafend" ; -- status=guess status=guess
lin aids_N = variants{} ; -- 
lin publicity_N = werbung_N ; -- status=guess
lin departure_N = abfahrt_N | abreise_N | abflug_N ; -- status=guess status=guess status=guess
lin welcome_A = willkommen_A ; -- status=guess
lin sharply_Adv = variants{} ; -- 
lin reception_N = rezeption_N | empfang_N ; -- status=guess status=guess
lin cousin_N = L.cousin_N ;
lin relieve_V2 = variants{} ; -- 
lin linguistic_A = sprachlich_A | linguistisch_A ; -- status=guess status=guess
lin vat_N = bottich_N | trog_N | wanne_N ; -- status=guess status=guess status=guess
lin forward_A = vorder_A ; -- status=guess
lin blue_N = blau_N ; -- status=guess
lin multiple_A = mkA "mehrere" ; -- status=guess
lin pass_N = variants{} ; -- 
lin outer_A = mkA "äußer" ; -- status=guess
lin vulnerable_A = mkA "verletzlich" ; -- status=guess
lin patient_A = geduldig_A ; -- status=guess
lin evolution_N = evolution_N ; -- status=guess
lin allocate_V2 = variants{} ; -- 
lin allocate_V = variants{} ; -- 
lin creative_A = kreativ_A ; -- status=guess
lin potentially_Adv = variants{} ; -- 
lin just_A = gerecht_A | berechtigt_A ; -- status=guess status=guess
lin out_Prep = variants{} ; -- 
lin judicial_A = gerichtlich_A | mkA "Justiz-" ; -- status=guess status=guess
lin risk_VV = mkVV (riskieren_V) | mkVV (wagen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin risk_V2 = mkV2 (riskieren_V) | mkV2 (wagen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin ideology_N = ideologie_N ; -- status=guess
lin smell_VA = mkVA (riechen_V) | mkVA (stinken_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin smell_V2 = mkV2 (riechen_V) | mkV2 (stinken_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin smell_V = L.smell_V ;
lin agenda_N = tagesordnung_N ; -- status=guess
lin transport_V2 = mkV2 (transportieren_2_V) | mkV2 (mkV "befördern") ; -- status=guess, src=wikt status=guess, src=wikt
lin illegal_A = illegal_A | mkA "rechtswidrig" ; -- status=guess status=guess
lin chicken_N = huhn_N | mkN "Hähnchen" neuter | mkN "Hühnchen" neuter | mkN "Küchlein" neuter ; -- status=guess status=guess status=guess status=guess
lin plain_A = schlicht_A ; -- status=guess
lin innovation_N = innovation_N ; -- status=guess
lin opera_N = oper_N | opernhaus_N ; -- status=guess status=guess
lin lock_N = mkN "Lock" masculine ; -- status=guess
lin grin_V = grinsen_V ; -- status=guess, src=wikt
lin shelf_N = mkN "Lagerfähigkeit" feminine | mkN "Lagerbeständigkeit" feminine | mkN "Haltbarkeit" feminine ; -- status=guess status=guess status=guess
lin pole_N = mkN "Poledance" masculine | mkN "Stangentanz" masculine ; -- status=guess status=guess
lin punishment_N = bestrafung_N ; -- status=guess
lin strict_A = streng_A ; -- status=guess
lin wave_V2 = mkV2 (wedeln_V) ; -- status=guess, src=wikt
lin wave_V = wedeln_V ; -- status=guess, src=wikt
lin inside_N = innenseite_N | mkN "Inneres" neuter ; -- status=guess status=guess
lin carriage_N = mkN "Remise" feminine ; -- status=guess
lin fit_A = sexy_A | scharf_A | mkA "heiß" ; -- status=guess status=guess status=guess
lin conversion_N = umwandlung_N ; -- status=guess
lin hurry_V = mkReflV "beeilen" | eilen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin essay_N = versuch_N ; -- status=guess
lin integration_N = integration_N ; -- status=guess
lin resignation_N = mkN "Rücktritt" masculine ; -- status=guess
lin treasury_N = schatzkammer__N ; -- status=guess
lin traveller_N = mkN "Reisender" masculine | mkN "Reisende" feminine ; -- status=guess status=guess
lin chocolate_N = schokoriegel_N ; -- status=guess
lin assault_N = anschlag_N ; -- status=guess
lin schedule_N = termin_N | programm_N | mkN "Zeitplan" masculine ; -- status=guess status=guess status=guess
lin undoubtedly_Adv = mkAdv "zweifellos" ; -- status=guess
lin twin_N = zwilling_N ; -- status=guess
lin format_N = format_N ; -- status=guess
lin murder_V2 = mkV2 (ermorden_V) ; -- status=guess, src=wikt
lin sigh_VS = mkVS (seufzen_V) ; -- status=guess, src=wikt
lin sigh_V2 = mkV2 (seufzen_V) ; -- status=guess, src=wikt
lin sigh_V = seufzen_V ; -- status=guess, src=wikt
lin sellerMasc_N = mkN "Verkäufer" masculine | mkN "Verkäuferin" feminine ; -- status=guess status=guess
lin lease_N = pacht__N ; -- status=guess
lin bitter_A = mkA "verbittert" ; -- status=guess
lin double_V2 = mkV2 (mkV "kontrieren") ; -- status=guess, src=wikt
lin double_V = mkV "kontrieren" ; -- status=guess, src=wikt
lin ally_N = mkN "Alliierter" masculine | mkN "Alliierte" feminine ; -- status=guess status=guess
lin stake_N = pfahl_N | pflock_N ; -- status=guess status=guess
lin processing_N = mkN "Verarbeitung" feminine ; -- status=guess
lin informal_A = informell_A ; -- status=guess
lin flexible_A = flexibel_A | mkA "dehnbar" | weich_A ; -- status=guess status=guess status=guess
lin cap_N = L.cap_N ;
lin stable_A = stabil_A ; -- status=guess
lin till_Subj = variants{} ; -- 
lin sympathy_N = sympathie_N ; -- status=guess
lin tunnel_N = mkN "Tunnel" masculine | stollen_N ; -- status=guess status=guess
lin pen_N = L.pen_N ;
lin instal_V = variants{} ; -- 
lin suspend_V2 = mkV2 (aufheben_V) | mkV2 (aussetzen_V) | mkV2 (mkV "aufschieben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin suspend_V = aufheben_V | aussetzen_V | mkV "aufschieben" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin blow_N = schlag_N ; -- status=guess
lin wander_V = mkV "abschweifen" ; -- status=guess, src=wikt
lin notably_Adv = variants{} ; -- 
lin disappoint_V2 = mkV2 (mkV "enttäuschen") ; -- status=guess, src=wikt
lin wipe_V2 = L.wipe_V2 ;
lin wipe_V = mkV "löschen" ; -- status=guess, src=wikt
lin folk_N = volk_N ; -- status=guess
lin attraction_N = attraktion_N ; -- status=guess
lin disc_N = scheibe_N ; -- status=guess
lin inspire_V2V = mkV2V (mkV "einhauchen") | mkV2V (mkV "einflößen") | mkV2V (begeistern_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin inspire_V2 = mkV2 (mkV "einhauchen") | mkV2 (mkV "einflößen") | mkV2 (begeistern_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin machinery_N = maschinerie_N ; -- status=guess
lin undergo_V2 = variants{} ; -- 
lin nowhere_Adv = nirgendwo_Adv | nirgends_Adv ; -- status=guess status=guess
lin inspector_N = variants{} ; -- 
lin wise_A = weise_A | klug_A ; -- status=guess status=guess
lin balance_V2 = mkV2 (balancieren_V) | mkV2 (junkV (mkV "im") "Gleichgewicht halten") ; -- status=guess, src=wikt status=guess, src=wikt
lin balance_V = balancieren_V | junkV (mkV "im") "Gleichgewicht halten" ; -- status=guess, src=wikt status=guess, src=wikt
lin purchaser_N = variants{} ; -- 
lin resort_N = mkN "Kurort" masculine | resort_N ; -- status=guess status=guess
lin pop_N = mkN "Pop-Gruppe" feminine ; -- status=guess
lin organ_N = organspender_N | organspenderin_N ; -- status=guess status=guess
lin ease_V2 = mkV2 (mkV "lindern") ; -- status=guess, src=wikt
lin ease_V = mkV "lindern" ; -- status=guess, src=wikt
lin friendship_N = freundschaft_N ; -- status=guess
lin deficit_N = defizit_N ; -- status=guess
lin dear_N = liebchen__N | mkN "Liebste" feminine | mkN "Liebster" masculine | mkN "Teuerste" feminine | mkN "Teuerster" masculine ; -- status=guess status=guess status=guess status=guess status=guess
lin convey_V2 = mkV2 (mkV "befördern") ; -- status=guess, src=wikt
lin reserve_V2 = mkV2 (reservieren_V) | mkV2 (buchen_8_V) | mkV2 (mkV "vormerken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reserve_V = reservieren_V | buchen_8_V | mkV "vormerken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin planet_N = L.planet_N ;
lin frequent_A = mkA "häufig" ; -- status=guess
lin loose_A = indiskret_A | lose_A ; -- status=guess status=guess
lin intense_A = intensiv_A ; -- status=guess
lin retail_A = variants{} ; -- 
lin wind_V = mkV "zurückspulen" | mkV "rückspulen" ; -- status=guess, src=wikt status=guess, src=wikt
lin lost_A = mkA "verirrt" ; -- status=guess
lin grain_N = korn_N ; -- status=guess
lin particle_N = teilchenbeschleuniger_N ; -- status=guess
lin destruction_N = mkN "Zerstörung" feminine | vernichtung_N ; -- status=guess status=guess
lin witness_V2 = mkV2 (mkV "bezeugen") ; -- status=guess, src=wikt
lin witness_V = mkV "bezeugen" ; -- status=guess, src=wikt
lin pit_N = box_N ; -- status=guess
lin registration_N = registrierung_N | anmeldung_N ; -- status=guess status=guess
lin conception_N = mkN "Empfängnis" neuter ; -- status=guess
lin steady_A = stetig_A ; -- status=guess
lin rival_N = gegner_N | rivale_N | konkurrent_N ; -- status=guess status=guess status=guess
lin steam_N = mkN "Dampfkessel" masculine ; -- status=guess
lin back_A = mkA "abgelegen" ; -- status=guess
lin chancellor_N = kanzler_N ; -- status=guess
lin crash_V = mkV "abstürzen" ; -- status=guess, src=wikt
lin belt_N = gurt_N ; -- status=guess
lin logic_N = logik_N ; -- status=guess
lin premium_N = variants{} ; -- 
lin confront_V2 = mkV2 (konfrontieren_V) | mkV2 (begegnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin precede_V2 = variants{} ; -- 
lin experimental_A = experimentell_A ; -- status=guess
lin alarm_N = wecker_N ; -- status=guess
lin rational_A = rational_A ; -- status=guess
lin incentive_N = mkN "Bonus" masculine ; -- status=guess
lin roughly_Adv = variants{} ; -- 
lin bench_N = bank_N ; -- status=guess
lin wrap_V2 = mkV2 (wickeln_7_V) | mkV2 (einwickeln_3_V) | mkV2 (einpacken_3_V) | mkV2 (mkV "hüllen") | mkV2 (mkV "umhüllen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wrap_V = wickeln_7_V | einwickeln_3_V | einpacken_3_V | mkV "hüllen" | mkV "umhüllen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin regarding_Prep = variants{} ; -- 
lin inadequate_A = unangemessen_A | mkA "unzulänglich" ; -- status=guess status=guess
lin ambition_N = mkN "Ehrgeiz" masculine | ambition_N ; -- status=guess status=guess
lin since_Adv = mkAdv "seit wann" ; -- status=guess
lin fate_N = schicksal_N ; -- status=guess
lin vendor_N = mkN "Verkäufer" masculine | mkN "Verkäuferin" feminine ; -- status=guess status=guess
lin stranger_N = mkN "Fremder" masculine | mkN "Ausländer" masculine ; -- status=guess status=guess
lin spiritual_A = geistig_A ; -- status=guess
lin increasing_A = variants{} ; -- 
lin anticipate_VV = mkVV (mkV "voraussehen") | mkVV (mkV "vorausahnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin anticipate_VS = mkVS (mkV "voraussehen") | mkVS (mkV "vorausahnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin anticipate_V2 = mkV2 (mkV "voraussehen") | mkV2 (mkV "vorausahnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin anticipate_V = mkV "voraussehen" | mkV "vorausahnen" ; -- status=guess, src=wikt status=guess, src=wikt
lin logical_A = logisch_A ; -- status=guess
lin fibre_N = faser_N ; -- status=guess
lin attribute_V2 = mkV2 (zuschreiben_9_V) ; -- status=guess, src=wikt
lin sense_VS = mkVS (wahrnehmen_5_V) ; -- status=guess, src=wikt
lin sense_V2 = mkV2 (wahrnehmen_5_V) ; -- status=guess, src=wikt
lin black_N = amerikaner_N ; -- status=guess
lin petrol_N = variants{} ; -- 
lin maker_N = mkN "Macher" masculine | hersteller_N | fabrikant_N ; -- status=guess status=guess status=guess
lin generous_A = mkA "großzügig" | mkA "generös" ; -- status=guess status=guess
lin allocation_N = mkN "Zuteilung" feminine | mkN "Zuweisung" feminine ; -- status=guess status=guess
lin depression_N = depression_N ; -- status=guess
lin declaration_N = mkN "Erklärung" feminine | deklaration_N ; -- status=guess status=guess
lin spot_VS = variants{} ; -- 
lin spot_V2 = variants{} ; -- 
lin spot_V = variants{} ; -- 
lin modest_A = bescheiden_A ; -- status=guess
lin bottom_A = variants{} ; -- 
lin dividend_N = dividend_N ; -- status=guess
lin devote_V2 = mkV2 (widmen_V) ; -- status=guess, src=wikt
lin condemn_V2 = mkV2 (mkV "verdammen") | mkV2 (mkV "verurteilen") ; -- status=guess, src=wikt status=guess, src=wikt
lin integrate_V2 = mkV2 (integrieren_V) ; -- status=guess, src=wikt
lin integrate_V = integrieren_V ; -- status=guess, src=wikt
lin pile_N = haufen_N | mkN "Stoß" masculine | stapel_N | mkN "" | mkN "Swiss] Beige" feminine | halde_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin identification_N = bezeichnung_N ; -- status=guess
lin acute_A = spitz_A ; -- status=guess
lin barely_Adv = kaum_Adv ; -- status=guess
lin providing_Subj = variants{} ; -- 
lin directive_N = anweisung_N | anordnung_N | befehl_N | direktive_N ; -- status=guess status=guess status=guess status=guess
lin bet_VS = mkVS (wetten_V) ; -- status=guess, src=wikt
lin bet_V2 = mkV2 (wetten_V) ; -- status=guess, src=wikt
lin bet_V = wetten_V ; -- status=guess, src=wikt
lin modify_V2 = mkV2 (mkV "ändern") | mkV2 (mkV "abändern") | mkV2 (modifizieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin bare_A = bar_A | nackt_A ; -- status=guess status=guess
lin swear_VV = mkVV (schimpfen_V) | mkVV (fluchen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin swear_V2 = mkV2 (schimpfen_V) | mkV2 (fluchen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin swear_V = schimpfen_V | fluchen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin final_N = mkN "finale Klasse" feminine ; -- status=guess
lin accordingly_Adv = mkAdv "dementsprechend" ; -- status=guess
lin valid_A = mkA "gültig" ; -- status=guess
lin wherever_Adv = variants{} ; -- 
lin mortality_N = sterblichkeit_N ; -- status=guess
lin medium_N = medium_N ; -- status=guess
lin silk_N = seide_N ; -- status=guess
lin funeral_N = bestattung_N | beerdigung_N | mkN "Begräbnis" neuter ; -- status=guess status=guess status=guess
lin depending_A = variants{} ; -- 
lin cow_N = L.cow_N ;
lin correspond_V2 = variants{}; -- entsprechen_V | korrespondieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin correspond_V = entsprechen_V | korrespondieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin cite_V2 = variants{} ; -- 
lin classic_A = klassisch_A ; -- status=guess
lin inspection_N = inspektion_N | mkN "Prüfung" feminine ; -- status=guess status=guess
lin calculation_N = variants{} ; -- 
lin rubbish_N = abfall_N | mkN "Müll" masculine ; -- status=guess status=guess
lin minimum_N = minimum_N ; -- status=guess
lin hypothesis_N = hypothese_N ; -- status=guess
lin youngster_N = variants{} ; -- 
lin slope_N = steigung_N | hang_N ; -- status=guess status=guess
lin patch_N = mkN "Patch" masculine ; -- status=guess
lin invitation_N = einladung_N | mkN "Einladen" neuter ; -- status=guess status=guess
lin ethnic_A = ethnisch_A ; -- status=guess
lin federation_N = mkN "Föderation" feminine | bund_N ; -- status=guess status=guess
lin duke_N = mkN "Großherzog" masculine ; -- status=guess
lin wholly_Adv = variants{} ; -- 
lin closure_N = mkN "Closure" | mkN "Funktionsabschluss" masculine ; -- status=guess status=guess
lin dictionary_N = mkN "assoziatives Datenfeld" neuter ; -- status=guess
lin withdrawal_N = mkN "Entzug" masculine ; -- status=guess
lin automatic_A = automatisch_A ; -- status=guess
lin liable_A = mkA "neigend" | mkA "unterworfen" ; -- status=guess status=guess
lin cry_N = mkN "Weinen" neuter ; -- status=guess
lin slow_V2 = mkV2 (verlangsamen_V) ; -- status=guess, src=wikt
lin slow_V = verlangsamen_V ; -- status=guess, src=wikt
lin borough_N = bezirk_N | gemeinde_N ; -- status=guess status=guess
lin well_A = gesund_A ; -- status=guess
lin suspicion_N = mkN "Verdacht" masculine | mkN "Argwohn" masculine ; -- status=guess status=guess
lin portrait_N = mkN "Portrait" neuter | mkN "Porträt" neuter ; -- status=guess status=guess
lin local_N = lokal_N ; -- status=guess
lin jew_N = variants{} ; -- 
lin fragment_N = satzfragment_N ; -- status=guess
lin revolutionary_A = mkA "revolutionär" ; -- status=guess
lin evaluate_V2 = mkV2 (evaluieren_V) ; -- status=guess, src=wikt
lin evaluate_V = evaluieren_V ; -- status=guess, src=wikt
lin competitor_N = mkN "Wettbewerbsteilnehmer" masculine ; -- status=guess
lin sole_A = einzig_A ; -- status=guess
lin reliable_A = mkA "verlässlich" | mkA "zuverlässig" ; -- status=guess status=guess
lin weigh_V2 = mkV2 (mkV "abwägen") ; -- status=guess, src=wikt
lin weigh_V = mkV "abwägen" ; -- status=guess, src=wikt
lin medieval_A = mittelalterlich_A ; -- status=guess
lin clinic_N = klinik_N ; -- status=guess
lin shine_V2 = mkV2 (leuchten_7_V) | mkV2 (scheinen_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin shine_V = leuchten_7_V | scheinen_6_V ; -- status=guess, src=wikt status=guess, src=wikt
lin knit_V2 = mkV2 (junkV (mkV "die") "Stirn runzeln") ; -- status=guess, src=wikt
lin knit_V = junkV (mkV "die") "Stirn runzeln" ; -- status=guess, src=wikt
lin complexity_N = mkN "Komplexität" feminine | schwierigkeit_N ; -- status=guess status=guess
lin remedy_N = heilmittel_N ; -- status=guess
lin fence_N = zaun_N | hag_N | mkN "Fence" masculine | mkN "" | mkN "South Africa ] Fenz" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin bike_N = L.bike_N ;
lin freeze_V2 = mkV2 (erstarren_V) ; -- status=guess, src=wikt
lin freeze_V = L.freeze_V ;
lin eliminate_V2 = mkV2 (eliminieren_V) | mkV2 (mkV "zerstören") ; -- status=guess, src=wikt status=guess, src=wikt
lin interior_N = mkN "Innenwinkel" masculine ; -- status=guess
lin intellectual_A = intellektuell_A ; -- status=guess
lin established_A = variants{} ; -- 
lin voter_N = mkN "Wähler" masculine | mkN "Wählerin" feminine ; -- status=guess status=guess
lin garage_N = garage_N ; -- status=guess
lin era_N = mkN "Ära" feminine | epoche_N ; -- status=guess status=guess
lin pregnant_A = schwanger_A | mkA "trächtig" ; -- status=guess status=guess
lin plot_N = handlung_N ; -- status=guess
lin greet_V2 = mkV2 (mkV "begrüßen") | mkV2 (mkV "grüßen") ; -- status=guess, src=wikt status=guess, src=wikt
lin electrical_A = variants{} ; -- 
lin lie_N = mkN "Lügendetektor" masculine ; -- status=guess
lin disorder_N = mkN "Unordnung" feminine ; -- status=guess
lin formally_Adv = variants{} ; -- 
lin excuse_N = ausrede_N ; -- status=guess
lin socialist_A = sozialistisch_A ; -- status=guess
lin cancel_V2 = mkV2 (mkV "ausstreichen") ; -- status=guess, src=wikt
lin cancel_V = mkV "ausstreichen" ; -- status=guess, src=wikt
lin harm_N = schaden_N ; -- status=guess
lin excess_N = mkN "Überschuss" masculine | mkN "Übermaß" neuter ; -- status=guess status=guess
lin exact_A = exakt_A | genau_A ; -- status=guess status=guess
lin oblige_V2V = mkV2V (verpflichten_V) ; -- status=guess, src=wikt
lin oblige_V2 = mkV2 (verpflichten_V) ; -- status=guess, src=wikt
lin accountant_N = mkN "Buchhalter" masculine | mkN "Buchhalterin" feminine ; -- status=guess status=guess
lin mutual_A = wechselseitig_A | gegenseitig_A | mkA "beiderseitig" ; -- status=guess status=guess status=guess
lin fat_N = L.fat_N ;
lin volunteerMasc_N = mkN "Freiwillige {m}" feminine ; -- status=guess
lin laughter_N = mkN "Gelächter" neuter | mkN "Lachen" neuter ; -- status=guess status=guess
lin trick_N = trick_N | mkN "Kunststück" neuter ; -- status=guess status=guess
lin load_V2 = mkV2 (laden_7_V) ; -- status=guess, src=wikt
lin load_V = laden_7_V ; -- status=guess, src=wikt
lin disposal_N = mkN "Beseitigung" feminine | entsorgung_N | mkN "especially toxic or nuclear]" ; -- status=guess status=guess status=guess
lin taxi_N = taxi_N | taxe_N ; -- status=guess status=guess
lin murmur_V2 = mkV2 (murmeln_V) ; -- status=guess, src=wikt
lin murmur_V = murmeln_V ; -- status=guess, src=wikt
lin tonne_N = tonne_N ; -- status=guess
lin spell_V2 = mkV2 (mkV "klarmachen") ; -- status=guess, src=wikt
lin spell_V = mkV "klarmachen" ; -- status=guess, src=wikt
lin clerk_N = mkN "Büroangestellte" masculine | mkN "Angestellte" masculine | mkN "Buchhalter" masculine | mkN "Bürokaufmann" masculine | mkN "Bürokauffrau" feminine | mkN "Gerichtsschreiber" masculine | schreiber_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin curious_A = neugierig_A ; -- status=guess
lin satisfactory_A = befriedigend_A ; -- status=guess
lin identical_A = identisch_A ; -- status=guess
lin applicant_N = bewerber_N | mkN "Bewerberin" feminine ; -- status=guess status=guess
lin removal_N = entlassung_N ; -- status=guess
lin processor_N = prozessor_N ; -- status=guess
lin cotton_N = baumwolle_N ; -- status=guess
lin reverse_V2 = variants{} ; -- 
lin reverse_V = variants{} ; -- 
lin hesitate_VV = mkVV (mkV "zögern") | mkVV (stammeln_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin hesitate_V = mkV "zögern" | stammeln_V ; -- status=guess, src=wikt status=guess, src=wikt
lin professor_N = professor_N | mkN "Professorin" feminine ; -- status=guess status=guess
lin admire_V2 = mkV2 (bewundern_V) | mkV2 (verehren_V) | mkV2 (mkV "hochschätzen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin namely_Adv = mkAdv "und zwar" | mkAdv "nämlich" ; -- status=guess status=guess
lin electoral_A = variants{} ; -- 
lin delight_N = freude_N | mkN "Entzückung" feminine | mkN "Wohlgefallen" neuter ; -- status=guess status=guess status=guess
lin urgent_A = dringend_A | mkA "dringlich" ; -- status=guess status=guess
lin prompt_V2V = variants{} ; -- 
lin prompt_V2 = variants{} ; -- 
lin mate_N = mkN "Kumpel" masculine ; -- status=guess
lin mate_2_N = variants{} ; -- 
lin mate_1_N = variants{} ; -- 
lin exposure_N = kontakt_N | einwirkung_N ; -- status=guess status=guess
lin server_N = server_N ; -- status=guess
lin distinctive_A = variants{} ; -- 
lin marginal_A = variants{} ; -- 
lin structural_A = variants{} ; -- 
lin rope_N = L.rope_N ;
lin miner_N = mkN "Bergmann" masculine | bergarbeiter_N ; -- status=guess status=guess
lin entertainment_N = unterhaltung_N ; -- status=guess
lin acre_N = morgen_N | acker_N | joch_N | joch_N | mkN "Juchart {m}" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin pig_N = bulle_N ; -- status=guess
lin encouraging_A = variants{} ; -- 
lin guarantee_N = garantie_N ; -- status=guess
lin gear_N = gang_N ; -- status=guess
lin anniversary_N = jahrestag_N ; -- status=guess
lin past_Adv = variants{} ; -- 
lin ceremony_N = zeremonie_N ; -- status=guess
lin rub_V2 = L.rub_V2 ;
lin rub_V = reiben_4_V ; -- status=guess, src=wikt
lin monopoly_N = monopol_N ; -- status=guess
lin left_N = mkN "Linkshändigkeit" feminine | mkN "Sinistralität" feminine ; -- status=guess status=guess
lin flee_V2 = mkV2 (fliehen_V) | mkV2 (mkV "entfliehen") | mkV2 (mkV "flüchten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin flee_V = fliehen_V | mkV "entfliehen" | mkV "flüchten" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin yield_V2 = mkV2 (aufgeben_4_V) | mkV2 (abwerfen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin discount_N = rabatt_N | mkN "Preisnachlass" masculine ; -- status=guess status=guess
lin above_A = mkA "überdurchschnittlich" ; -- status=guess
lin uncle_N = onkel_N | oheim_N ; -- status=guess status=guess
lin audit_N = mkN "Überprüfung" feminine ; -- status=guess
lin advertisement_N = anzeige_N | werbung_N | annonce_N | mkN "Reklameanzeige" feminine ; -- status=guess status=guess status=guess status=guess
lin explosion_N = explosion_N ; -- status=guess
lin contrary_A = variants{} ; -- 
lin tribunal_N = tribunal_N ; -- status=guess
lin swallow_V2 = mkV2 (schlucken_V) ; -- status=guess, src=wikt
lin swallow_V = schlucken_V ; -- status=guess, src=wikt
lin typically_Adv = variants{} ; -- 
lin fun_A = lustig_A | mkA "spaßig" | mkA "to be fun: Spaß machen" ; -- status=guess status=guess status=guess
lin rat_N = ratte_N ; -- status=guess
lin cloth_N = mkN "Kleidungsstück" neuter ; -- status=guess
lin cable_N = kabel_N | leitung_N ; -- status=guess status=guess
lin interrupt_V2 = mkV2 (unterbrechen_V) ; -- status=guess, src=wikt
lin interrupt_V = unterbrechen_V ; -- status=guess, src=wikt
lin crash_N = absturz_N ; -- status=guess
lin flame_N = mkN "Flammenphotometrie" feminine ; -- status=guess
lin controversy_N = kontroverse_N ; -- status=guess
lin rabbit_N = kaninchen_N | karnickel_N | mkN "Schlappohr" neuter ; -- status=guess status=guess status=guess
lin everyday_A = mkA "Alltags-" ; -- status=guess
lin allegation_N = behauptung_N ; -- status=guess
lin strip_N = mkN "Gogo-Bar" feminine | mkN "Strip-Club" masculine ; -- status=guess status=guess
lin stability_N = mkN "Stabilität" feminine ; -- status=guess
lin tide_N = mkN "Gezeiten {p}" | tide_N ; -- status=guess status=guess
lin illustration_N = illustration_N ; -- status=guess
lin insect_N = insekt_N | mkN "Kerbtier" neuter | kerf_N ; -- status=guess status=guess status=guess
lin correspondent_N = variants{} ; -- 
lin devise_V2 = mkV2 (junkV (mkV "letztwillig") "vermachen") | mkV2 (junkV (mkV "durch") "Testament verfügen") ; -- status=guess, src=wikt status=guess, src=wikt
lin determined_A = entschlossen_A | resolut_A | beherzt_A | bestimmt_A | entschieden_A ; -- status=guess status=guess status=guess status=guess status=guess
lin brush_V2 = mkV2 (pinseln_V) | mkV2 (auftragen_4_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin brush_V = pinseln_V | auftragen_4_V ; -- status=guess, src=wikt status=guess, src=wikt
lin adjustment_N = anpassung_N | mkN "Regulierung" feminine ; -- status=guess status=guess
lin controversial_A = umstritten_A | kontrovers_A ; -- status=guess status=guess
lin organic_A = organisch_A ; -- status=guess
lin escape_N = flucht_N ; -- status=guess
lin thoroughly_Adv = mkAdv "gründlich" ; -- status=guess
lin interface_N = schnittstelle_N ; -- status=guess
lin historic_A = historisch_A ; -- status=guess
lin collapse_N = kollaps_N ; -- status=guess
lin temple_N = mkN "Schläfe" feminine ; -- status=guess
lin shade_N = schatten_N ; -- status=guess
lin craft_N = handwerker_N ; -- status=guess
lin nursery_N = mkN "erziehen" ; -- status=guess
lin piano_N = klavier_N | piano_N ; -- status=guess status=guess
lin desirable_A = mkA "erwünscht" ; -- status=guess
lin assurance_N = variants{} ; -- 
lin jurisdiction_N = jurisdiktion_N ; -- status=guess
lin advertise_V2 = mkV2 (mkV "inserieren") | mkV2 (werben_2_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin advertise_V = mkV "inserieren" | werben_2_V ; -- status=guess, src=wikt status=guess, src=wikt
lin bay_N = golf_N | bucht_N | mkN "Meerbusen" masculine ; -- status=guess status=guess status=guess
lin specification_N = spezifikation__N ; -- status=guess
lin disability_N = behinderung_N ; -- status=guess
lin presidential_A = variants{} ; -- 
lin arrest_N = verhaftung_N | festnahme_N ; -- status=guess status=guess
lin unexpected_A = unerwartet_A ; -- status=guess
lin switch_N = schalter_N ; -- status=guess
lin penny_N = mkN "Hochrad" neuter ; -- status=guess
lin respect_V2 = mkV2 (respektieren_V) ; -- status=guess, src=wikt
lin celebration_N = feier_N ; -- status=guess
lin gross_A = dick_A ; -- status=guess
lin aid_V2 = mkV2 (helfen_V) ; -- status=guess, src=wikt
lin aid_V = helfen_V ; -- status=guess, src=wikt
lin superb_A = mkA "großartig" ;
lin process_V2 = mkV2 (verarbeiten_V) ; -- status=guess, src=wikt
lin process_V = verarbeiten_V ; -- status=guess, src=wikt
lin innocent_A = mkA "unschuldig" ; -- status=guess
lin leap_V2 = mkV2 (springen_7_V) | mkV2 (einen_V) | mkV2 (mkV "hüpfen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin leap_V = springen_7_V | einen_V | mkV "hüpfen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin colony_N = kolonie_N ; -- status=guess
lin wound_N = wunde_N | verletzung_N ; -- status=guess status=guess
lin hardware_N = mkN "Eisenwaren {f} {p}" ; -- status=guess
lin satellite_N = satellit_N ; -- status=guess
lin float_V = L.float_V ;
lin bible_N = bibel_N ; -- status=guess
lin statistical_A = statistisch_A ; -- status=guess
lin marked_A = variants{} ; -- 
lin hire_V2V = mkV2V (mkV "anwerben") | mkV2V (anstellen_0_V) | mkV2V (einstellen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hire_V2 = mkV2 (mkV "anwerben") | mkV2 (anstellen_0_V) | mkV2 (einstellen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cathedral_N = kathedrale_N | dom_N ; -- status=guess status=guess
lin motive_N = motiv_N | mkN "Beweggrund" masculine ; -- status=guess status=guess
lin correct_VS = mkVS (ausbessern_V) | mkVS (korrigieren_V) | mkVS (mkV "richtigstellen") | mkVS (berichtigen_V) | mkVS (junkV (mkV "nachregeln") "Tech.") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin correct_V2 = mkV2 (ausbessern_V) | mkV2 (korrigieren_V) | mkV2 (mkV "richtigstellen") | mkV2 (berichtigen_V) | mkV2 (junkV (mkV "nachregeln") "Tech.") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin correct_V = ausbessern_V | korrigieren_V | mkV "richtigstellen" | berichtigen_V | junkV (mkV "nachregeln") "Tech." ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin gastric_A = gastrisch_A ; -- status=guess
lin raid_N = razzia_N | mkN "Überfall" masculine ; -- status=guess status=guess
lin comply_V2 = mkV2 (einwilligen_V) ; -- status=guess, src=wikt
lin comply_V = einwilligen_V ; -- status=guess, src=wikt
lin accommodate_V2 = mkV2 (anpassen_V) ; -- status=guess, src=wikt
lin accommodate_V = anpassen_V ; -- status=guess, src=wikt
lin mutter_V2 = mkV2 (murmeln_V) ; -- status=guess, src=wikt
lin mutter_V = murmeln_V ; -- status=guess, src=wikt
lin induce_V2 = variants{} ; -- 
lin trap_V2 = mkV2 (fangen_8_V) ; -- status=guess, src=wikt
lin trap_V = fangen_8_V ; -- status=guess, src=wikt
lin invasion_N = invasion_N | mkN "Überfall" masculine ; -- status=guess status=guess
lin humour_N = laune_N | humor_N | stimmung_N ; -- status=guess status=guess status=guess
lin bulk_N = mkN "Großteil" masculine ; -- status=guess
lin traditionally_Adv = variants{} ; -- 
lin commission_V2V = mkV2V (junkV (mkV "in") "Auftrag geben") ; -- status=guess, src=wikt
lin commission_V2 = mkV2 (junkV (mkV "in") "Auftrag geben") ; -- status=guess, src=wikt
lin upstairs_Adv = treppauf_Adv | oben_Adv | nach_rechts_Adv | mkAdv "herauf" ; -- status=guess status=guess status=guess status=guess
lin translate_V2 = mkV2 (mkV "übertragen") ; -- status=guess, src=wikt
lin translate_V = mkV "übertragen" ; -- status=guess, src=wikt
lin rhythm_N = mkN "Rhythm and Blues" neuter ; -- status=guess
lin emission_N = mkN "Ausstoß" | emission_N ; -- status=guess status=guess
lin collective_A = variants{} ; -- 
lin transformation_N = transformation_N ; -- status=guess
lin battery_N = batterie_N ; -- status=guess
lin stimulus_N = mkN "Auslöseimpuls" masculine ; -- status=guess
lin naked_A = nackt_A ; -- status=guess
lin white_N = mkN "Weiße {m}" feminine | mkN "Weißer" masculine ; -- status=guess status=guess
lin menu_N = mkN "Menüleiste" feminine ; -- status=guess
lin toilet_N = klo_N | toilette_N ; -- status=guess status=guess
lin butter_N = L.butter_N ;
lin surprise_V2V = mkV2V (mkV "überraschen") ; -- status=guess, src=wikt
lin surprise_V2 = mkV2 (mkV "überraschen") ; -- status=guess, src=wikt
lin needle_N = mkN "Nadellager" neuter ; -- status=guess
lin effectiveness_N = mkN "Wirksamkeit" feminine ; -- status=guess
lin accordance_N = mkN "Übereinstimmung" feminine ; -- status=guess
lin molecule_N = mkN "Molekül" neuter ; -- status=guess
lin fiction_N = fiktion_N ; -- status=guess
lin learning_N = mkN "Gelehrsamkeit" feminine | kenntnis_N ; -- status=guess status=guess
lin statute_N = mkN "Gesetzesrecht" neuter ; -- status=guess
lin reluctant_A = mkA "zögernd" ; -- status=guess
lin overlook_V2 = mkV2 (mkV "überblicken") ; -- status=guess, src=wikt
lin junction_N = kreuzung_N | knotenpunkt_N ; -- status=guess status=guess
lin necessity_N = notwendigkeit_N | mkN "Nezessität" feminine ; -- status=guess status=guess
lin nearby_A = in_A ; -- status=guess
lin experienced_A = mkA "erfahren" ; -- status=guess
lin lorry_N = variants{} ; -- 
lin exclusive_A = mkA "ausschließlich" ; -- status=guess
lin graphics_N = grafikkarte_N ; -- status=guess
lin stimulate_V2 = mkV2 (stimulieren_V) ; -- status=guess, src=wikt
lin warmth_N = mkN "Wärme" feminine ; -- status=guess
lin therapy_N = therapie_N ; -- status=guess
lin convenient_A = bequem_A | einfach_A | gelegen_A | mkA "genehm" | mkA "günstig" | passend_A | praktisch_A ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin cinema_N = film_N ; -- status=guess
lin domain_N = domain_N | mkN "Domäne" feminine ; -- status=guess status=guess
lin tournament_N = turnier_N ; -- status=guess
lin doctrine_N = doktrin_N ; -- status=guess
lin sheer_A = mkA "bloß" | schier_A ; -- status=guess status=guess
lin proposition_N = satz_N ; -- status=guess
lin grip_N = griff_N ; -- status=guess
lin widow_N = hurenkind_N ; -- status=guess
lin discrimination_N = diskriminierung_N | mkN "Schlechterstellung" feminine ; -- status=guess status=guess
lin bloody_Adv = variants{} ; -- 
lin ruling_A = variants{} ; -- 
lin fit_N = mkN "Paßform" feminine ; -- status=guess
lin nonetheless_Adv = mkAdv "nichtsdestoweniger" | mkAdv "nichtsdestotrotz" ; -- status=guess status=guess
lin myth_N = mythos_N ; -- status=guess
lin episode_N = episode_N ; -- status=guess
lin drift_V2 = mkV2 (driften_8_V) ; -- status=guess, src=wikt
lin drift_V = driften_8_V ; -- status=guess, src=wikt
lin assert_VS = mkVS (versichern_V) | mkVS (mkV "zusichern") ; -- status=guess, src=wikt status=guess, src=wikt
lin assert_V2 = mkV2 (versichern_V) | mkV2 (mkV "zusichern") ; -- status=guess, src=wikt status=guess, src=wikt
lin assert_V = versichern_V | mkV "zusichern" ; -- status=guess, src=wikt status=guess, src=wikt
lin terrace_N = terrasse_N ; -- status=guess
lin uncertain_A = mkA "unbeständig" ; -- status=guess
lin twist_V2 = mkV2 (mkV "verdrehen") ; -- status=guess, src=wikt
lin insight_N = einsicht_N ; -- status=guess
lin undermine_V2 = mkV2 (unterminieren_V) ; -- status=guess, src=wikt
lin tragedy_N = mkN "Tragödie" feminine ; -- status=guess
lin enforce_V2 = mkV2 (durchsetzen_7_V) ; -- status=guess, src=wikt
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin march_V2 = mkV2 (junkV (mkV "in") "den Krieg ziehen") ; -- status=guess, src=wikt
lin march_V = junkV (mkV "in") "den Krieg ziehen" ; -- status=guess, src=wikt
lin leaflet_N = faltblatt_N | mkN "Broschüre" feminine | mkN "Faltprospekt" neuter | flugblatt_N ; -- status=guess status=guess status=guess status=guess
lin fellow_A = variants{} ; -- 
lin object_V2 = mkV2 (junkV (mkV "dagegen") "sein") | mkV2 (junkV (mkV "Einwände") "haben") | mkV2 (einwenden_8_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin object_V = junkV (mkV "dagegen") "sein" | junkV (mkV "Einwände") "haben" | einwenden_8_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pond_N = der_nbspdamenfluegel_N ; -- status=guess
lin adventure_N = abenteuer_N | wagnis_N ; -- status=guess status=guess
lin diplomatic_A = diplomatisch_A ; -- status=guess
lin mixed_A = gemischt_A ; -- status=guess
lin rebel_N = rebell_N | mkN "Aufrührer" masculine ; -- status=guess status=guess
lin equity_N = gerechtigkeit_N ; -- status=guess
lin literally_Adv = mkAdv "wörtlich" | mkAdv "buchstäblich" ; -- status=guess status=guess
lin magnificent_A = ausgezeichnet_A ; -- status=guess
lin loyalty_N = mkN "Treue" feminine | mkN "Loyalität" feminine ; -- status=guess status=guess
lin tremendous_A = mkA "beträchtlich" | mkA "außerordentlich" ; -- status=guess status=guess
lin airline_N = fluggesellschaft_N ; -- status=guess
lin shore_N = ufer_wolfstrapp_N ; -- status=guess
lin restoration_N = restaurierung_N | mkN "Wiederherstellung" feminine | restauration_N ; -- status=guess status=guess status=guess
lin physically_Adv = mkAdv "physisch" ; -- status=guess
lin render_V2 = mkV2 (mkV "rendern") ; -- status=guess, src=wikt
lin institutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (betonen_V) ; -- status=guess, src=wikt
lin emphasize_V2 = mkV2 (betonen_V) ; -- status=guess, src=wikt
lin mess_N = messe_N ; -- status=guess
lin commander_N = befehlshaber_N | mkN "Kommandeur" masculine ; -- status=guess status=guess
lin straightforward_A = aufrichtig_A | einfach_A | offen_A ; -- status=guess status=guess status=guess
lin singer_N = mkN "Sänger" masculine | mkN "Sängerin" feminine ; -- status=guess status=guess
lin squeeze_V2 = L.squeeze_V2 ;
lin squeeze_V = mkV "ausdrücken" | mkV "ausquetschen" ; -- status=guess, src=wikt status=guess, src=wikt
lin full_time_A = variants{} ; -- 
lin breed_V2 = mkV2 (mkV "brüten") ; -- status=guess, src=wikt
lin breed_V = mkV "brüten" ; -- status=guess, src=wikt
lin successor_N = nachfolger_N | mkN "Nachfolgerin" feminine ; -- status=guess status=guess
lin triumph_N = triumph_N ; -- status=guess
lin heading_N = kurs__N ; -- status=guess
lin mathematics_N = mkN "Mathematik" feminine ; -- status=guess
lin laugh_N = mkN "Lachen" neuter ; -- status=guess
lin clue_N = anhaltspunkt_N | hinweis_N ; -- status=guess status=guess
lin still_A = still_A ; -- status=guess
lin ease_N = bequemlichkeit_N ; -- status=guess
lin specially_Adv = variants{} ; -- 
lin biological_A = mkA "leiblich" | biologisch_A ; -- status=guess status=guess
lin forgive_V2 = mkV2 (vergeben_V) ; -- status=guess, src=wikt
lin forgive_V = vergeben_V ; -- status=guess, src=wikt
lin trustee_N = mkN "Treuhänder" masculine | mkN "Treuhänderin" feminine ; -- status=guess status=guess
lin photo_N = foto_N | bild_N ; -- status=guess status=guess
lin fraction_N = bruch_N ; -- status=guess
lin chase_V2 = mkV2 (jagen_V) | mkV2 (verfolgen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin chase_V = jagen_V | verfolgen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin whereby_Adv = wodurch_Adv ; -- status=guess
lin mud_N = schlamm_N | mkN "Kot" masculine ; -- status=guess status=guess
lin pensioner_N = rentner_N | rentnerin_N ; -- status=guess status=guess
lin functional_A = funktional_A | mkA "funktions-" | funktionell_A ; -- status=guess status=guess status=guess
lin copy_V2 = mkV2 (kopieren_V) ; -- status=guess, src=wikt
lin copy_V = kopieren_V ; -- status=guess, src=wikt
lin strictly_Adv = variants{} ; -- 
lin desperately_Adv = mkAdv "verzweifelt" ; -- status=guess
lin await_V2 = mkV2 (erwarten_V) | mkV2 (harren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin coverage_N = variants{} ; -- 
lin wildlife_N = tierwelt_N | fauna_N ; -- status=guess status=guess
lin indicator_N = zeiger_N ; -- status=guess
lin lightly_Adv = mkAdv "leicht" ; -- status=guess
lin hierarchy_N = hierarchie_N ; -- status=guess
lin evolve_V2 = variants{} ; -- 
lin evolve_V = variants{} ; -- 
lin mechanical_A = mechanisch_A ; -- status=guess
lin expert_A = variants{} ; -- 
lin creditor_N = mkN "Gläubiger" masculine ; -- status=guess
lin capitalist_N = kapitalist_N ; -- status=guess
lin essence_N = wesen_N ; -- status=guess
lin compose_V2 = mkV2 (mkV "zusammenstellen") | mkV2 (bilden_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin compose_V = mkV "zusammenstellen" | bilden_6_V ; -- status=guess, src=wikt status=guess, src=wikt
lin mentally_Adv = mkAdv "geistig" | mkAdv "psychisch" | mkAdv "mental" ; -- status=guess status=guess status=guess
lin gaze_N = variants{} ; -- 
lin seminar_N = seminar_N ; -- status=guess
lin target_V2V = variants{} ; -- 
lin target_V2 = variants{} ; -- 
lin label_V3 = mkV3 (mkV "etikettieren") ; -- status=guess, src=wikt
lin label_V2 = mkV2 (mkV "etikettieren") ; -- status=guess, src=wikt
lin label_V = mkV "etikettieren" ; -- status=guess, src=wikt
lin fig_N = feige_N ; -- status=guess
lin continent_N = kontinent_N | erdteil_N ; -- status=guess status=guess
lin chap_N = kerl_N | typ_N ; -- status=guess status=guess
lin flexibility_N = mkN "Flexibilität" feminine ; -- status=guess
lin verse_N = strophe_N | vers_N ; -- status=guess status=guess
lin minute_A = winzig_A ; -- status=guess
lin whisky_N = variants{} ; -- 
lin equivalent_A = mkA "äquivalent" ; -- status=guess
lin recruit_V2 = mkV2 (rekrutieren_V) ; -- status=guess, src=wikt
lin recruit_V = rekrutieren_V ; -- status=guess, src=wikt
lin echo_V2 = mkV2 (mkV "widerhallen") | mkV2 (wiederholen_V) | mkV2 (mkV "zurückwerfen") | mkV2 (hallen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin echo_V = mkV "widerhallen" | wiederholen_V | mkV "zurückwerfen" | hallen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin unfair_A = mkA "unfair" ; -- status=guess
lin launch_N = start_N ; -- status=guess
lin cupboard_N = schrank_N ; -- status=guess
lin bush_N = busch_N ; -- status=guess
lin shortage_N = variants{} ; -- 
lin prominent_A = prominent_A ; -- status=guess
lin merger_N = fusion_N | mkN "Firmenzusammenschluss" masculine | zusammenschluss_N ; -- status=guess status=guess status=guess
lin command_V2 = mkV2 (beherrschen_V) ; -- status=guess, src=wikt
lin command_V = beherrschen_V ; -- status=guess, src=wikt
lin subtle_A = mkA "scharfsinnig" | mkA "ausgetüftelt" | schlau_A ; -- status=guess status=guess status=guess
lin capital_A = mkA "großartig" ; -- status=guess
lin gang_N = bande_N | rotte_N ; -- status=guess status=guess
lin fish_V2 = mkV2 (fischen_V) | mkV2 (angeln_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin fish_V = fischen_V | angeln_V ; -- status=guess, src=wikt status=guess, src=wikt
lin unhappy_A = mkA "unglücklich" ; -- status=guess
lin lifetime_N = leben_N | lebensdauer_N | lebenszeit_N ; -- status=guess status=guess status=guess
lin elite_N = elite_N | auslese_N | oberschicht_N | mkN "Führungsschicht" feminine | mkN "Spitzengruppe" feminine | spitze_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin refusal_N = ablehnung_N | mkN "Weigerung" feminine | verweigerung_N ; -- status=guess status=guess status=guess
lin finish_N = ende_N ; -- status=guess
lin aggressive_A = aggressiv_A | mkA "angriffslustig" ; -- status=guess status=guess
lin superior_A = mkA "höher" | mkA "höherstehend" ; -- status=guess status=guess
lin landing_N = mkN "Anlegeplatz" masculine ; -- status=guess
lin exchange_V2 = mkV2 (mkV "umtauschen") ; -- status=guess, src=wikt
lin debate_V2 = mkV2 (debattieren_V) ; -- status=guess, src=wikt
lin debate_V = debattieren_V ; -- status=guess, src=wikt
lin educate_V2 = variants{} ; -- 
lin separation_N = trennung_N ; -- status=guess
lin productivity_N = mkN "Produktivität" feminine | mkN "Leistungsfähigkeit" feminine ; -- status=guess status=guess
lin initiate_V2 = mkV2 (beginnen_V) | mkV2 (mkV "anstoßen") | mkV2 (mkV "einführen") | mkV2 (initiieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin probability_N = wahrscheinlichkeit_N ; -- status=guess
lin virus_N = variants{} ; -- 
lin reporterMasc_N = reporter_N | mkN "Reporterin" feminine ; -- status=guess status=guess
lin fool_N = der_nbspdamenfluegel_N ; -- status=guess
lin pop_V2 = mkV2 (auftauchen_0_V) | mkV2 (aufkreuzen_1_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin capitalism_N = mkN "Kapitalismus" masculine ; -- status=guess
lin painful_A = schmerzhaft_A ; -- status=guess
lin correctly_Adv = variants{} ; -- 
lin complex_N = komplex_N ; -- status=guess
lin rumour_N = variants{} ; -- 
lin imperial_A = kaiserlich_A ; -- status=guess
lin justification_N = rechtfertigung_N | mkN "Begründung" feminine ; -- status=guess status=guess
lin availability_N = mkN "Vorhandensein" neuter | mkN "Verfügbarkeit" feminine ; -- status=guess status=guess
lin spectacular_A = mkA "spektakulär" ; -- status=guess
lin remain_N = mkN "Überrest" masculine | mkN "Überreste {m} sterbliche Überreste" masculine ; -- status=guess status=guess
lin ocean_N = ozean_N ; -- status=guess
lin cliff_N = klippe_N | felsen_N ; -- status=guess status=guess
lin sociology_N = mkN "Soziologie" feminine | mkN "Gesellschaftskunde" feminine ; -- status=guess status=guess
lin sadly_Adv = mkAdv "traurig" | mkAdv "traurigerweise" ; -- status=guess status=guess
lin missile_N = mkN "Flugkörper" masculine ; -- status=guess
lin situate_V2 = variants{} ; -- 
lin artificial_A = mkA "künstlich" ; -- status=guess
lin apartment_N = L.apartment_N ;
lin provoke_V2 = mkV2 (provozieren_V) ; -- status=guess, src=wikt
lin oral_A = oral_A ; -- status=guess
lin maximum_N = maximum_N ; -- status=guess
lin angel_N = engel_N ; -- status=guess
lin spare_A = schlank_A ; -- status=guess
lin shame_N = mkN "Schande" feminine ; -- status=guess
lin intelligent_A = intelligent_A ; -- status=guess
lin discretion_N = variants{} ; -- 
lin businessman_N = mkN "Geschäftsmann" masculine | unternehmer_N ; -- status=guess status=guess
lin explicit_A = eindeutig_A | mkA "ausdrücklich" | deutlich_A | explizit_A ; -- status=guess status=guess status=guess status=guess
lin book_V2 = mkV2 (bestrafen_V) ; -- status=guess, src=wikt
lin uniform_N = uniform_N ; -- status=guess
lin push_N = schubs_N | mkN "Stoß" masculine ; -- status=guess status=guess
lin counter_N = gegenangriff_N ; -- status=guess
lin subject_A = variants{} ; -- 
lin objective_A = objektiv_A ; -- status=guess
lin hungry_A = hungrig_A ; -- status=guess
lin clothing_N = kleidung_N ; -- status=guess
lin ride_N = variants{} ; -- 
lin romantic_A = romantisch_A ; -- status=guess
lin attendance_N = mkN "Anwesenheit" feminine ; -- status=guess
lin part_time_A = variants{} ; -- 
lin trace_N = mkN "aufzeichnen" | mkN "aufspüren" | mkN "nachspüren" | mkN "nachziehen" | mkN "verfolgen" ; -- status=guess status=guess status=guess status=guess status=guess
lin backing_N = variants{} ; -- 
lin sensation_N = mkN "Gefühl" neuter ; -- status=guess
lin carrier_N = mkN "Carriertaube" feminine | mkN "Karriertaube" feminine | carrier_N | mkN "Karrier" masculine ; -- status=guess status=guess status=guess status=guess
lin interest_V2 = mkV2 (interessieren_V) ; -- status=guess, src=wikt
lin interest_V = interessieren_V ; -- status=guess, src=wikt
lin classification_N = klassifikation_N ; -- status=guess
lin classic_N = klassiker_N ; -- status=guess
lin beg_V2 = mkV2 (mkV "betteln") ; -- status=guess, src=wikt
lin beg_V = mkV "betteln" ; -- status=guess, src=wikt
lin appendix_N = anhang_N ; -- status=guess
lin doorway_N = mkN "Türöffnung" feminine ; -- status=guess
lin density_N = dichte_N ; -- status=guess
lin working_class_A = variants{} ; -- 
lin legislative_A = variants{} ; -- 
lin hint_N = hinweis_N ; -- status=guess
lin shower_N = schauer_N ; -- status=guess
lin current_N = mkN "Girokonto" neuter ; -- status=guess
lin succession_N = mkN "Thronfolge" ; -- status=guess
lin nasty_A = variants{} ; -- 
lin duration_N = dauer_N ; -- status=guess
lin desert_N = mkN "Wüste" feminine ; -- status=guess
lin receipt_N = empfang_N ; -- status=guess
lin native_A = mkA "gebürtig" ; -- status=guess
lin chapel_N = kapelle_N ; -- status=guess
lin amazing_A = mkA "erstaunlich" | unglaublich_A | mkA "verwunderlich" ; -- status=guess status=guess status=guess
lin hopefully_Adv = mkAdv "hoffnungsvoll" ; -- status=guess
lin fleet_N = flotte_N ; -- status=guess
lin comparable_A = vergleichbar_A ; -- status=guess
lin oxygen_N = sauerstoffatom_N ; -- status=guess
lin installation_N = mkN "Installation" feminine ; -- status=guess
lin developer_N = entwickler_N ; -- status=guess
lin disadvantage_N = nachteil_N ; -- status=guess
lin recipe_N = rezept_N | kochrezept_N ; -- status=guess status=guess
lin crystal_N = kristall_N ; -- status=guess
lin modification_N = modifikation_N ; -- status=guess
lin schedule_V2V = mkV2V (planen_V) ; -- status=guess, src=wikt
lin schedule_V2 = mkV2 (planen_V) ; -- status=guess, src=wikt
lin schedule_V = planen_V ; -- status=guess, src=wikt
lin midnight_N = mitternacht_N ; -- status=guess
lin successive_A = variants{} ; -- 
lin formerly_Adv = mkAdv "früher" | ehemals_Adv ; -- status=guess status=guess
lin loud_A = laut_A ; -- status=guess
lin value_V2 = mkV2 (mkV "schätzen") ; -- status=guess, src=wikt
lin value_V = mkV "schätzen" ; -- status=guess, src=wikt
lin physics_N = mkN "Physik" feminine ; -- status=guess
lin truck_N = mkN "Lastauto" neuter | laster_N | lastkraftwagen_N | mkN "LKW" masculine | lastwagen_N | lieferwagen_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin stroke_N = streich_N ; -- status=guess
lin kiss_N = kuss_N | mkN "Busserl" neuter ; -- status=guess status=guess
lin envelope_N = mkN "Hülle" feminine ; -- status=guess
lin speculation_N = spekulation_N ; -- status=guess
lin canal_N = kanal_N ; -- status=guess
lin unionist_N = gewerkschaftler_N ; -- status=guess
lin directory_N = verzeichnis_N ; -- status=guess
lin receiver_N = mkN "Empfangsgerät" neuter | mkN "Empfänger" masculine ; -- status=guess status=guess
lin isolation_N = isolierung_N ; -- status=guess
lin fade_V2 = mkV2 (mkV "verwelken") ; -- status=guess, src=wikt
lin fade_V = mkV "verwelken" ; -- status=guess, src=wikt
lin chemistry_N = chemie_N ; -- status=guess
lin unnecessary_A = mkA "nicht notwendig" | mkA "unnötig" ; -- status=guess status=guess
lin hit_N = mkN "Fahrerflucht" feminine ; -- status=guess
lin defenderMasc_N = verteidiger_N ; -- status=guess
lin stance_N = einstellung_N | mkN "Positur" feminine ; -- status=guess status=guess
lin sin_N = mkN "Sünde" feminine ; -- status=guess
lin realistic_A = realistisch_A ; -- status=guess
lin socialist_N = sozialist_N | sozialistin_N ; -- status=guess status=guess
lin subsidy_N = subvention_N | mkN "Unterstützung" feminine | mkN "Subsidium" neuter ; -- status=guess status=guess status=guess
lin content_A = zufrieden_A ; -- status=guess
lin toy_N = spielzeug_N ; -- status=guess
lin darling_N = liebling_N | schatz_N ; -- status=guess status=guess
lin decent_A = ganz_A | mkA "anständig" ; -- status=guess status=guess
lin liberty_N = freiheit_N ; -- status=guess
lin forever_Adv = mkAdv "für immer" | mkAdv "ewig" | mkAdv "unaufhörlich" | auf_Adv | mkAdv "für eger" ; -- status=guess status=guess status=guess status=guess status=guess
lin skirt_N = saum_N ; -- status=guess
lin coordinate_V2 = mkV2 (koordinieren_V) ; -- status=guess, src=wikt
lin coordinate_V = koordinieren_V ; -- status=guess, src=wikt
lin tactic_N = taktik_N ; -- status=guess
lin influential_A = variants{} ; -- 
lin import_V2 = mkV2 (importieren_V) | mkV2 (mkV "einführen") ; -- status=guess, src=wikt status=guess, src=wikt
lin accent_N = akzent_N ; -- status=guess
lin compound_N = mischung_N ; -- status=guess
lin bastard_N = bastard_N | mkN "Mistkerl" masculine | arsch_N ; -- status=guess status=guess status=guess
lin ingredient_N = bestandteil_N | ingredienz_N | inhaltsstoff_N | zutat_N ; -- status=guess status=guess status=guess status=guess
lin dull_A = L.dull_A ;
lin cater_V = variants{} ; -- 
lin scholar_N = mkN "Gelehrte" masculine ; -- status=guess
lin faint_A = kraftlos_A | schwach_A ; -- status=guess status=guess
lin ghost_N = gespenst__N | mkN "Geist" neuter | phantom_N | mkN "Spuk" masculine | erscheinung_N ; -- status=guess status=guess status=guess status=guess status=guess
lin sculpture_N = mkN "Bildhauerkunst" feminine | skulptur_N ; -- status=guess status=guess
lin ridiculous_A = mkA "lächerlich" ; -- status=guess
lin diagnosis_N = diagnose_N ; -- status=guess
lin delegate_N = mkN "Delegierter" masculine | mkN "Abgeordneter" masculine | vertreter_N ; -- status=guess status=guess status=guess
lin neat_A = nett_A | adrett_A | sauber_A ; -- status=guess status=guess status=guess
lin kit_N = mkN "Ausrüstung" feminine | satz_N ; -- status=guess status=guess
lin lion_N = mkN "Löwe" masculine | mkN "Löwenmännchen" neuter | mkN "Löwin" feminine | mkN "Löwenweibchen" neuter | leu_N | mkN "Löwenjunges" neuter | mkN "Löwenbaby" neuter | mkN "" | mkN "diminutive ♂♀] Löwchen" neuter | mkN "Löwlein" neuter ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin dialogue_N = dialogfenster_N | dialog_N ; -- status=guess status=guess
lin repair_V2 = mkV2 (reparieren_V) ; -- status=guess, src=wikt
lin repair_V = reparieren_V ; -- status=guess, src=wikt
lin tray_N = tablett_N ; -- status=guess
lin fantasy_N = fantasie_N ; -- status=guess
lin leave_N = mkN "Beurlaubung" feminine | mkN "Freistellung" feminine | urlaub_N ; -- status=guess status=guess status=guess
lin export_V2 = mkV2 (exportieren_V) ; -- status=guess, src=wikt
lin export_V = exportieren_V ; -- status=guess, src=wikt
lin forth_Adv = variants{} ; -- 
lin lamp_N = L.lamp_N ;
lin allege_VS = mkVS (behaupten_V) ; -- status=guess, src=wikt
lin allege_V2 = mkV2 (behaupten_V) ; -- status=guess, src=wikt
lin pavement_N = mkN "Bürgersteig" masculine | gehweg_N | gehsteig_N ; -- status=guess status=guess status=guess
lin brand_N = marke_N ; -- status=guess
lin constable_N = variants{} ; -- 
lin compromise_N = mkN "Kompromiss" masculine | ausgleich_N ; -- status=guess status=guess
lin flag_N = mkN "Flag" neuter | markierung_N | kennzeichen_N ; -- status=guess status=guess status=guess
lin filter_N = filter_N ; -- status=guess
lin reign_N = herrschaft_N | mkN "Regentschaft" feminine ; -- status=guess status=guess
lin execute_V2 = mkV2 (hinrichten_3_V) ; -- status=guess, src=wikt
lin pity_N = mkN "Mitleid" neuter ; -- status=guess
lin merit_N = verdienst_N ; -- status=guess
lin diagram_N = diagramm_N ; -- status=guess
lin wool_N = wolle_N ; -- status=guess
lin organism_N = organismus_N ; -- status=guess
lin elegant_A = elegant_A ; -- status=guess
lin red_N = mkN "Rotrückenbussard" masculine ; -- status=guess
lin undertaking_N = unternehmen_N ; -- status=guess
lin lesser_A = mkA "weniger" | mkA "kleiner" | mkA "geringere" ; -- status=guess status=guess status=guess
lin reach_N = variants{} ; -- 
lin marvellous_A = variants{} ; -- 
lin improved_A = variants{} ; -- 
lin locally_Adv = variants{} ; -- 
lin entity_N = wesen_N ; -- status=guess
lin rape_N = vergewaltigung_N ; -- status=guess
lin secure_A = mkA "zuverlässig" ; -- status=guess
lin descend_V2 = variants{} ; -- 
lin descend_V = variants{} ; -- 
lin backwards_Adv = mkAdv "rückwärts" ; -- status=guess
lin peer_V = mkV "spähen" ; -- status=guess, src=wikt
lin excuse_V2 = mkV2 (mkReflV "entschuldigen") ; -- status=guess, src=wikt
lin genetic_A = genetisch_A ; -- status=guess
lin fold_V2 = mkV2 (falten_V) ; -- status=guess, src=wikt
lin fold_V = falten_V ; -- status=guess, src=wikt
lin portfolio_N = mappe_N ; -- status=guess
lin consensus_N = konsens_N | mkN "Einvernehmen" neuter ; -- status=guess status=guess
lin thesis_N = these_N ; -- status=guess
lin shop_V = einkaufen_8_V ; -- status=guess, src=wikt
lin nest_N = vogelnest_N | nest_N ; -- status=guess status=guess
lin frown_V = junkV (mkV "die") "Stirn runzeln" | mkV "runzeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin builder_N = mkN "Baumeister" masculine | mkN "Erbauer" ; -- status=guess status=guess
lin administer_V2 = mkV2 (mkV "darreichen") | mkV2 (verabreichen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin administer_V = mkV "darreichen" | verabreichen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin tip_V2 = mkV2 (junkV (mkV "ein") "Trinkgeld geben") ; -- status=guess, src=wikt
lin tip_V = junkV (mkV "ein") "Trinkgeld geben" ; -- status=guess, src=wikt
lin lung_N = lunge_N ; -- status=guess
lin delegation_N = delegation_N ; -- status=guess
lin outside_N = mkN "Außenseite" feminine ; -- status=guess
lin heating_N = heizung_N ; -- status=guess
lin like_Subj = variants{} ; -- 
lin instinct_N = instinkt_N ; -- status=guess
lin teenager_N = mkN "Jugendlicher" masculine | mkN "Jugendliche" feminine ; -- status=guess status=guess
lin lonely_A = einsam_A ; -- status=guess
lin residence_N = mkN "Aufenthaltserlaubnis" neuter | mkN "Niederlassungserlaubnis" neuter ; -- status=guess status=guess
lin radiation_N = strahlung_N | radiation_N ; -- status=guess status=guess
lin extract_V2 = mkV2 (entziehen_V) ; -- status=guess, src=wikt
lin concession_N = mkN "Gewerbeerlaubnis" feminine ; -- status=guess
lin autonomy_N = autonomie__N ; -- status=guess
lin norm_N = norm_N ; -- status=guess
lin musicianMasc_N = musikant_N | musiker_N | musikerin_N ; -- status=guess status=guess status=guess
lin graduate_N = absolvent_N | absolventin_N ; -- status=guess status=guess
lin glory_N = mkN "Ruhm" masculine ; -- status=guess
lin bear_N = mkN "Bär" masculine ; -- status=guess
lin persist_V = mkV "beharren" ; -- status=guess, src=wikt
lin rescue_V2 = mkV2 (retten_V) ; -- status=guess, src=wikt
lin equip_V2 = mkV2 (mkV "ausrüsten") ; -- status=guess, src=wikt
lin partial_A = parteiisch_A ; -- status=guess
lin officially_Adv = variants{} ; -- 
lin capability_N = variants{} ; -- 
lin worry_N = sorge_N ; -- status=guess
lin liberation_N = befreiung_N ; -- status=guess
lin hunt_V2 = L.hunt_V2 ;
lin hunt_V = jagen_V ; -- status=guess, src=wikt
lin daily_Adv = mkAdv "täglich" ; -- status=guess
lin heel_N = kanten_N | mkN "Knapp" masculine | mkN "Knust" masculine | mkN "Ranft" masculine | mkN "Scherzl" neuter | mkN "technical terms in bakery trade: Anschnitt" masculine | abschnitt_N ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin contract_V2V = mkV2V (mkV "zusammenziehen") | mkV2V (kontrahieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin contract_V2 = mkV2 (mkV "zusammenziehen") | mkV2 (kontrahieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin contract_V = mkV "zusammenziehen" | kontrahieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin update_V2 = mkV2 (aktualisieren_V) ; -- status=guess, src=wikt
lin assign_V2V = variants{} ; -- 
lin assign_V2 = variants{} ; -- 
lin spring_V2 = mkV2 (springen_7_V) ; -- status=guess, src=wikt
lin spring_V = springen_7_V ; -- status=guess, src=wikt
lin single_N = einer_N ; -- status=guess
lin commons_N = allmende_N ; -- status=guess
lin weekly_A = mkA "wöchentlich" ; -- status=guess
lin stretch_N = mkN "Strecken" neuter ; -- status=guess
lin pregnancy_N = schwangerschaft_N ; -- status=guess
lin happily_Adv = mkAdv "und wenn sie nicht gestorben sind" | dann_Adv ; -- status=guess status=guess
lin spectrum_N = spektrum_N ; -- status=guess
lin interfere_V = mkV "stören" ; -- status=guess, src=wikt
lin suicide_N = mkN "Selbstmordattentäter" masculine ; -- status=guess
lin panic_N = panik_N ; -- status=guess
lin invent_V2 = mkV2 (ausdenken_V) | mkV2 (erfinden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin invent_V = ausdenken_V | erfinden_V ; -- status=guess, src=wikt status=guess, src=wikt
lin intensive_A = intensiv_A ; -- status=guess
lin damp_A = feucht_A ; -- status=guess
lin simultaneously_Adv = mkAdv "gleichzeitig" ; -- status=guess
lin giant_N = mkN "Großer Ameisenbär" masculine ; -- status=guess
lin casual_A = mkA "gleichgültig" ; -- status=guess
lin sphere_N = kugel_N ; -- status=guess
lin precious_A = mkA "kostbar" | wertvoll_A ; -- status=guess status=guess
lin sword_N = schwert_N ; -- status=guess
lin envisage_V2 = mkV2 (vorstellen_V) ; -- status=guess, src=wikt
lin bean_N = bohne_N ; -- status=guess
lin time_V2 = mkV2 (timen_V) | mkV2 (junkV (mkV "Zeitpunkt") "wählen") ; -- status=guess, src=wikt status=guess, src=wikt
lin crazy_A = mkA "verrückt" ; -- status=guess
lin changing_A = variants{} ; -- 
lin primary_N = mkN "Handschwinge" feminine ; -- status=guess
lin concede_VS = mkVS (mkV "einräumen") | mkVS (mkV "zugestehen") ; -- status=guess, src=wikt status=guess, src=wikt
lin concede_V2 = mkV2 (mkV "einräumen") | mkV2 (mkV "zugestehen") ; -- status=guess, src=wikt status=guess, src=wikt
lin concede_V = mkV "einräumen" | mkV "zugestehen" ; -- status=guess, src=wikt status=guess, src=wikt
lin besides_Adv = mkAdv "außerdem" | weiterhin_Adv | mkAdv "darüber hinaus" ; -- status=guess status=guess status=guess
lin unite_V2 = mkV2 (mkV "vereinen") ; -- status=guess, src=wikt
lin unite_V = mkV "vereinen" ; -- status=guess, src=wikt
lin severely_Adv = mkAdv "streng" ; -- status=guess
lin separately_Adv = mkAdv "getrennt" ; -- status=guess
lin instruct_V2 = variants{} ; -- 
lin insert_V2 = mkV2 (mkV "einfügen") ; -- status=guess, src=wikt
lin go_N = mkN "Grauer Lärmvogel" masculine ; -- status=guess
lin exhibit_V2 = mkV2 (zeigen_7_V) | mkV2 (junkV (mkV "an") "den Tag legen") ; -- status=guess, src=wikt status=guess, src=wikt
lin brave_A = tapfer_A | mutig_A ; -- status=guess status=guess
lin tutor_N = variants{} ; -- 
lin tune_N = melodie_N ; -- status=guess
lin debut_N = mkN "Debüt" neuter ; -- status=guess
lin debut_2_N = variants{} ; -- 
lin debut_1_N = variants{} ; -- 
lin continued_A = variants{} ; -- 
lin bid_V2 = mkV2 (melden_1_V) | mkV2 (reizen_5_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin bid_V = melden_1_V | reizen_5_V ; -- status=guess, src=wikt status=guess, src=wikt
lin incidence_N = variants{} ; -- 
lin downstairs_Adv = unten_Adv | treppab_Adv | mkAdv "treppabwärts" | nach_rechts_Adv ; -- status=guess status=guess status=guess status=guess
lin cafe_N = variants{} ; -- 
lin regret_VS = mkVS (bedauern_V) | mkVS (bereuen_V) | mkVS (junkV (mkV "Leid") "tun") | mkVS (leidtun_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin regret_V2 = mkV2 (bedauern_V) | mkV2 (bereuen_V) | mkV2 (junkV (mkV "Leid") "tun") | mkV2 (leidtun_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin killer_N = mkN "Killer-Anwendung" feminine | mkN "Killer-Applikation" feminine ; -- status=guess status=guess
lin delicate_A = empfindlich_A ; -- status=guess
lin subsidiary_N = tochterunternehmen_N | mkN "Tochtergesellschaft" feminine ; -- status=guess status=guess
lin gender_N = geschlecht_N ; -- status=guess
lin entertain_V2 = mkV2 (unterhalten_V) ; -- status=guess, src=wikt
lin cling_V = haften_V | klammern_2_V ; -- status=guess, src=wikt status=guess, src=wikt
lin vertical_A = vertikal_A | senkrecht_A ; -- status=guess status=guess
lin fetch_V2 = mkV2 (holen_4_V) ; -- status=guess, src=wikt
lin strip_V2 = variants{} ; -- 
lin strip_V = variants{} ; -- 
lin plead_VS = mkVS (bitten_0_V) | mkVS (anflehen_V) | mkVS (mkV "beschwören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plead_V2 = mkV2 (bitten_0_V) | mkV2 (anflehen_V) | mkV2 (mkV "beschwören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plead_V = bitten_0_V | anflehen_V | mkV "beschwören" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin duck_N = ente_N ; -- status=guess
lin breed_N = rasse_N ; -- status=guess
lin assistant_A = mkA "helfend" | hilfreich_A ; -- status=guess status=guess
lin pint_N = mkN "Pint" neuter ; -- status=guess
lin abolish_V2 = mkV2 (vernichten_V) ; -- status=guess, src=wikt
lin translation_N = mkN "Übersetzung" feminine | mkN "Übersetzen" neuter ; -- status=guess status=guess
lin princess_N = prinzessin_N ; -- status=guess
lin line_V2 = mkV2 (mkReflV "eingliedern") | mkV2 (mkReflV "aufreihen") ; -- status=guess, src=wikt status=guess, src=wikt
lin line_V = mkReflV "eingliedern" | mkReflV "aufreihen" ; -- status=guess, src=wikt status=guess, src=wikt
lin excessive_A = mkA "übermäßig" | exzessiv_A ; -- status=guess status=guess
lin digital_A = mkA "Finger-" | digital_A ; -- status=guess status=guess
lin steep_A = steil_A ; -- status=guess
lin jet_N = jet_N | mkN "Düsenjet" masculine | mkN "Strahlflugzeug" neuter | mkN "Düsenflugzeug" neuter ; -- status=guess status=guess status=guess status=guess
lin hey_Interj = mkInterj "Hallo" ; -- status=guess
lin grave_N = grab_N ; -- status=guess
lin exceptional_A = mkA "außergewöhnlich" ; -- status=guess
lin boost_V2 = variants{} ; -- 
lin random_A = mkA "zufällig" ; -- status=guess
lin correlation_N = korrelation_N ; -- status=guess
lin outline_N = umriss_N | kontur_N ; -- status=guess status=guess
lin intervene_V2V = mkV2V (eingreifen_V) | mkV2V (intervenieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin intervene_V = eingreifen_V | intervenieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin packet_N = variants{} ; -- 
lin motivation_N = motivation_N ; -- status=guess
lin safely_Adv = variants{} ; -- 
lin harsh_A = rau_A | harsch_A ; -- status=guess status=guess
lin spell_N = mkN "Rechtschreibprüfung" feminine ; -- status=guess
lin spread_N = aufstrich_N ; -- status=guess
lin draw_N = ziehung_N ; -- status=guess
lin concrete_A = mkA "aus Beton" | mkA "Beton-" ; -- status=guess status=guess
lin complicated_A = kompliziert_A ; -- status=guess
lin alleged_A = mkA "mutmaßlich" ; -- status=guess
lin redundancy_N = redundanz_N ; -- status=guess
lin progressive_A = mkA "fortschrittlich" ; -- status=guess
lin intensity_N = mkN "Intensität" feminine ; -- status=guess
lin crack_N = knall_N | mkN "Knacks" masculine | mkN "Krachen" neuter ; -- status=guess status=guess status=guess
lin fly_N = fliegenpilz_N ; -- status=guess
lin fancy_V2 = mkV2 (junkV (mkV "auf") "stehen") ; -- status=guess, src=wikt
lin alternatively_Adv = mkAdv "alternativ" | mkAdv "andernfalls" | andererseits_Adv | mkAdv "beziehungsweise" | mkAdv "ersatzweise" | mkAdv "hilfsweise" | mkAdv "oder aber" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin waiting_A = variants{} ; -- 
lin scandal_N = skandal_N ; -- status=guess
lin resemble_V2 = mkV2 (mkV "ähneln") | mkV2 (gleichen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin parameter_N = parameter_N ; -- status=guess
lin fierce_A = wild_A ; -- status=guess
lin tropical_A = tropisch_A ; -- status=guess
lin colour_V2A = variants{} ; -- 
lin colour_V2 = variants{} ; -- 
lin colour_V = variants{} ; -- 
lin engagement_N = gefecht_N ; -- status=guess
lin contest_N = wettkampf_N | wettbewerb_N | wettstreit_N ; -- status=guess status=guess status=guess
lin edit_V2 = mkV2 (bearbeiten_V) | mkV2 (redigieren_V) | mkV2 (edieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin courage_N = mut_a_ehe_N ; -- status=guess
lin hip_N = mkN "Hüftknochen" masculine ; -- status=guess
lin delighted_A = mkA "erfreut" | mkA "hocherfreut" ; -- status=guess status=guess
lin sponsor_V2 = mkV2 (sponsern_V) ; -- status=guess, src=wikt
lin carer_N = betreuer_N | mkN "Betreuerin" feminine ; -- status=guess status=guess
lin crack_V2 = mkV2 (junkV (mkV "scharf") "vorgehen") ; -- status=guess, src=wikt
lin substantially_Adv = mkAdv "beträchtlich" | mkAdv "erheblich" | mkAdv "substanziell" | mkAdv "wesentlich" ; -- status=guess status=guess status=guess status=guess
lin occupational_A = variants{} ; -- 
lin trainer_N = trainer_N ; -- status=guess
lin remainder_N = restposten_N ; -- status=guess
lin related_A = verwandt_A ; -- status=guess
lin inherit_V2 = mkV2 (erben_V) ; -- status=guess, src=wikt
lin inherit_V = erben_V ; -- status=guess, src=wikt
lin resume_V2 = mkV2 (mkV "wiederaufnehmen") | mkV2 (fortsetzen_4_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin resume_V = mkV "wiederaufnehmen" | fortsetzen_4_V ; -- status=guess, src=wikt status=guess, src=wikt
lin assignment_N = variants{} ; -- 
lin conceal_V2 = mkV2 (verbergen_V) | mkV2 (mkV "verheimlichen") | mkV2 (verschleiern_V) | mkV2 (verschweigen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_VS = mkVS (mkV "veröffentlichen") | mkVS (mkV "bekanntgeben") | mkVS (mkV "bekanntmachen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V2 = mkV2 (mkV "veröffentlichen") | mkV2 (mkV "bekanntgeben") | mkV2 (mkV "bekanntmachen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V = mkV "veröffentlichen" | mkV "bekanntgeben" | mkV "bekanntmachen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exclusively_Adv = mkAdv "ausschließlich" | mkAdv "exklusiv" ; -- status=guess status=guess
lin working_N = ansatz_N ; -- status=guess
lin mild_A = mild_A ; -- status=guess
lin chronic_A = chronisch_A ; -- status=guess
lin splendid_A = hervorragend_A ; -- status=guess
lin function_V = funktionieren_V | arbeiten_1_V | wirken_4_V | funzen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin riderMasc_N = reiter_N | reiterin_N | mitfahrer_N | mkN "Mitfahrerin" ; -- status=guess status=guess status=guess status=guess
lin clay_N = lehm_N | mkN "Ton" masculine ; -- status=guess status=guess
lin firstly_Adv = erstens_Adv | an_Adv ; -- status=guess status=guess
lin conceive_V2 = mkV2 (empfangen_V) | mkV2 (junkV (mkV "schwanger") "werden") ; -- status=guess, src=wikt status=guess, src=wikt
lin conceive_V = empfangen_V | junkV (mkV "schwanger") "werden" ; -- status=guess, src=wikt status=guess, src=wikt
lin politically_Adv = variants{} ; -- 
lin terminal_N = mkN "Terminal" masculine neuter ; -- status=guess
lin accuracy_N = mkN "Genauigkeit" feminine | mkN "Präzision" feminine ; -- status=guess status=guess
lin coup_N = mkN "Coup" masculine ; -- status=guess
lin ambulance_N = rettungswagen_N | krankenwagen_N ; -- status=guess status=guess
lin living_N = mkN "Lebensunterhalt" masculine ; -- status=guess
lin offenderMasc_N = mkN "Täter" masculine ; -- status=guess
lin similarity_N = mkN "Ähnlichkeit" feminine ; -- status=guess
lin orchestra_N = orchester_N ; -- status=guess
lin brush_N = mkN "Bürste" feminine ; -- status=guess
lin systematic_A = systematisch_A ; -- status=guess
lin striker_N = variants{} ; -- 
lin guard_V2 = mkV2 (mkV "schützen") ; -- status=guess, src=wikt
lin guard_V = mkV "schützen" ; -- status=guess, src=wikt
lin casualty_N = opfer_N ; -- status=guess
lin steadily_Adv = variants{} ; -- 
lin painter_N = maler_N | mkN "Malerin" feminine | mkN "Kunstmaler" masculine | mkN "Kunstmalerin" feminine | mkN "Freizeitmaler" masculine | mkN "Freizeitmalerin" feminine | mkN "Hobbymaler" masculine | mkN "Hobbymalerin" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin opt_VV = mkVV (optieren_V) ; -- status=guess, src=wikt
lin opt_V = optieren_V ; -- status=guess, src=wikt
lin handsome_A = mkA "hübsch" | stattlich_A ; -- status=guess status=guess
lin banking_N = variants{} ; -- 
lin sensitivity_N = variants{} ; -- 
lin navy_N = mkN "Marineamt" neuter ; -- status=guess
lin fascinating_A = variants{} ; -- 
lin disappointment_N = mkN "Enttäuschung" feminine ; -- status=guess
lin auditor_N = mkN "Wirtschaftsprüfer" masculine | mkN "Wirtschaftsprüfer" feminine ; -- status=guess status=guess
lin hostility_N = mkN "Feindseligkeit" feminine ; -- status=guess
lin spending_N = mkN "Kaufrausch" masculine ; -- status=guess
lin scarcely_Adv = variants{} ; -- 
lin compulsory_A = mkA "zwangsweise" | mkA "verpflichtend" ; -- status=guess status=guess
lin photographer_N = fotograf_N | photograph_N ; -- status=guess status=guess
lin ok_Interj = variants{} ; -- 
lin neighbourhood_N = nachbarschaft_N | umgebung_N ; -- status=guess status=guess
lin ideological_A = ideologisch_A ; -- status=guess
lin wide_Adv = variants{} ; -- 
lin pardon_N = vergebung_N | mkN "Verzeihung" feminine ; -- status=guess status=guess
lin double_N = mkN "Kauderwelsch" neuter ; -- status=guess
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin supervision_N = aufsicht_N | mkN "Beaufsichtigung" feminine ; -- status=guess status=guess
lin guilt_N = mkN "Schuldgefühl" neuter ; -- status=guess
lin deck_N = mkN "Deckstuhl" masculine | mkN "Badeliege" feminine | mkN "Faltstuhl" masculine | liegestuhl_N | mkN "Poolliege" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin payable_A = variants{} ; -- 
lin execution_N = mkN "Ausführung" feminine ; -- status=guess
lin suite_N = mkN "Suite" feminine ; -- status=guess
lin elected_A = variants{} ; -- 
lin solely_Adv = mkAdv "nur" | mkAdv "einzig und allein" | mkAdv "ausschließlich" ; -- status=guess status=guess status=guess
lin moral_N = mkN "Moralkodex" masculine ; -- status=guess
lin collector_N = mkN "Kollektor" masculine ; -- status=guess
lin questionnaire_N = mkN "Fragebogen" masculine ; -- status=guess
lin flavour_N = mkN "Geschmacksstoff" masculine | mkN "Geschmacksverstärker" masculine ; -- status=guess status=guess
lin couple_V2 = variants{} ; -- 
lin couple_V = variants{} ; -- 
lin faculty_N = mkN "Vermögen" neuter | mkN "Fähigkeit" feminine | begabung_N ; -- status=guess status=guess status=guess
lin tour_V2 = variants{} ; -- 
lin tour_V = variants{} ; -- 
lin basket_N = korb_N ; -- status=guess
lin mention_N = mkN "Erwähnung" feminine ; -- status=guess
lin kick_N = ein_euro_job_N ; -- status=guess
lin horizon_N = horizont_N ; -- status=guess
lin drain_V2 = variants{} ; -- 
lin drain_V = variants{} ; -- 
lin happiness_N = mkN "Glück" neuter | mkN "Glücklichkeit" feminine ; -- status=guess status=guess
lin fighter_N = mkN "Jäger" masculine ; -- status=guess
lin estimated_A = variants{} ; -- 
lin copper_N = kupfer_N ; -- status=guess
lin legend_N = legende_N ; -- status=guess
lin relevance_N = mkN "Relevanz" feminine | mkN "Aktualität" feminine | belang_N ; -- status=guess status=guess status=guess
lin decorate_V2 = mkV2 (mkV "ausschmücken") | mkV2 (mkV "dekorieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin continental_A = mkA "kontinental" ; -- status=guess
lin ship_V2 = mkV2 (mkV "verschicken") | mkV2 (versenden_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin ship_V = mkV "verschicken" | versenden_V ; -- status=guess, src=wikt status=guess, src=wikt
lin operational_A = variants{} ; -- 
lin incur_V2 = variants{} ; -- 
lin parallel_A = parallel_A ; -- status=guess
lin divorce_N = scheidung_N | mkN "Ehescheidung" feminine ; -- status=guess status=guess
lin opposed_A = variants{} ; -- 
lin equilibrium_N = gleichgewicht_N ; -- status=guess
lin trader_N = mkN "Händler" masculine ; -- status=guess
lin ton_N = tonne_N ; -- status=guess
lin can_N = mkN "Gießkanne" feminine ; -- status=guess
lin juice_N = saft_N ; -- status=guess
lin forum_N = mkN "Forum" neuter ; -- status=guess
lin spin_V2 = mkV2 (spinnen_7_V) ; -- status=guess, src=wikt
lin spin_V = spinnen_7_V ; -- status=guess, src=wikt
lin research_V2 = mkV2 (recherchieren_V) | mkV2 (mkV "erforschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin research_V = recherchieren_V | mkV "erforschen" ; -- status=guess, src=wikt status=guess, src=wikt
lin hostile_A = feindlich_A ; -- status=guess
lin consistently_Adv = variants{} ; -- 
lin technological_A = mkA "technologisch" ; -- status=guess
lin nightmare_N = albtraum_N | alptraum_N ; -- status=guess status=guess
lin medal_N = medaille_N ; -- status=guess
lin diamond_N = mkN "Diamantstempelzelle" feminine ; -- status=guess
lin speed_V2 = mkV2 (rasen_V) ; -- status=guess, src=wikt
lin speed_V = rasen_V ; -- status=guess, src=wikt
lin peaceful_A = friedfertig_A ; -- status=guess
lin accounting_A = variants{} ; -- 
lin scatter_V2 = mkV2 (zerstreuen_V) ; -- status=guess, src=wikt
lin scatter_V = zerstreuen_V ; -- status=guess, src=wikt
lin monster_N = monster_N | ungeheuer_N ; -- status=guess status=guess
lin horrible_A = schrecklich_A ; -- status=guess
lin nonsense_N = mkN "Blödsinn" masculine | mkN "Nonsens" masculine | mkN "Quatsch" masculine | mkN "Unsinn" masculine ; -- status=guess status=guess status=guess status=guess
lin chaos_N = mkN "Unordnung" feminine | mkN "Chaos" neuter ; -- status=guess status=guess
lin accessible_A = variants{} ; -- 
lin humanity_N = mkN "Menschheit" feminine ; -- status=guess
lin frustration_N = frustration_N ; -- status=guess
lin chin_N = kinn_N ; -- status=guess
lin bureau_N = mkN "Kommode" feminine ; -- status=guess
lin advocate_VS = mkVS (verteidigen_V) | mkVS (mkV "plädieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin advocate_V2 = mkV2 (verteidigen_V) | mkV2 (mkV "plädieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin polytechnic_N = variants{} ; -- 
lin inhabitant_N = einwohner_N | einwohnerin_N | bewohner_N | bewohnerin_N ; -- status=guess status=guess status=guess status=guess
lin evil_A = mkA "böse" | mkA "übel" ; -- status=guess status=guess
lin slave_N = mkN "Slave" masculine | mkN "Folgegerät" neuter ; -- status=guess status=guess
lin reservation_N = mkN "Reservierung" feminine ; -- status=guess
lin slam_V2 = mkV2 (mkV "zuschlagen") | mkV2 (mkV "zuknallen") ; -- status=guess, src=wikt status=guess, src=wikt
lin slam_V = mkV "zuschlagen" | mkV "zuknallen" ; -- status=guess, src=wikt status=guess, src=wikt
lin handle_N = griff_N ; -- status=guess
lin provincial_A = mkA "provinziell" | mkA "provinzial" ; -- status=guess status=guess
lin fishing_N = fischerboot_N ; -- status=guess
lin facilitate_V2 = mkV2 (erleichtern_V) | mkV2 (mkV "fördern") ; -- status=guess, src=wikt status=guess, src=wikt
lin yield_N = ertrag_N | ausbeute_N ; -- status=guess status=guess
lin elbow_N = ellbogen_N ; -- status=guess
lin bye_Interj = mkInterj "tschüss" ; -- status=guess
lin warm_V2 = mkV2 (mkV "wärmen") ; -- status=guess, src=wikt
lin warm_V = mkV "wärmen" ; -- status=guess, src=wikt
lin sleeve_N = mkN "Ärmel" masculine ; -- status=guess
lin exploration_N = mkN "Erkundung" feminine ; -- status=guess
lin creep_V = schleichen_V ; -- status=guess, src=wikt
lin adjacent_A = umliegend_A | nachfolgend_A | darauffolgend_A ; -- status=guess status=guess status=guess
lin theft_N = diebstahl_N ; -- status=guess
lin round_V2 = mkV2 (runden_1_V) ; -- status=guess, src=wikt
lin round_V = runden_1_V ; -- status=guess, src=wikt
lin grace_N = gnade_N | mkN "Gunst" feminine ; -- status=guess status=guess
lin predecessor_N = mkN "Vorgänger" masculine | mkN "Vorgängerin" feminine ; -- status=guess status=guess
lin supermarket_N = supermarkt_N ; -- status=guess
lin smart_A = klug_A | intelligent_A | gescheit_A ; -- status=guess status=guess status=guess
lin sergeant_N = feldwebel_N ; -- status=guess
lin regulate_V2 = mkV2 (regeln_V) ; -- status=guess, src=wikt
lin clash_N = mkN "Zusammenstoß" masculine | auseinandersetzung_N ; -- status=guess status=guess
lin assemble_V2 = mkV2 (mkReflV "versammeln") | mkV2 (mkV "zusammenkommen") ; -- status=guess, src=wikt status=guess, src=wikt
lin assemble_V = mkReflV "versammeln" | mkV "zusammenkommen" ; -- status=guess, src=wikt status=guess, src=wikt
lin arrow_N = mkN "Pfeiltaste" feminine ; -- status=guess
lin nowadays_Adv = mkAdv "gegenwärtig" | mkAdv "zur Zeit" | mkAdv "derzeitig" | jetzt_Adv | zurzeit_Adv | mkAdv "momentan" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin giant_A = riesig_A | gigantisch_A ; -- status=guess status=guess
lin waiting_N = mkN "Warteliste" feminine ; -- status=guess
lin tap_N = gewindeschneider_N ; -- status=guess
lin shit_N = durchfall_N ; -- status=guess
lin sandwich_N = mkN "belegtes Brot" neuter | mkN "Sandwich" neuter | mkN "{m}" ; -- status=guess status=guess status=guess
lin vanish_V = verschwinden_V | vergehen_V | mkReflV "verflüchtigen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin commerce_N = mkN "Handel" masculine | mkN "Kommerz" feminine ; -- status=guess status=guess
lin pursuit_N = verfolgung_N ; -- status=guess
lin post_war_A = variants{} ; -- 
lin will_V2 = mkV2 (werden_V) | mkV2 (junkV (mkV "present") "tense form is often used") ; -- status=guess, src=wikt status=guess, src=wikt
lin will_V = werden_V | junkV (mkV "present") "tense form is often used" ; -- status=guess, src=wikt status=guess, src=wikt
lin waste_A = mkA "wüst" | mkA "öde" ; -- status=guess status=guess
lin collar_N = ring_N ; -- status=guess
lin socialism_N = mkN "Sozialismus" masculine ; -- status=guess
lin skill_V = variants{} ; -- 
lin rice_N = mkN "Reiskuchen" masculine ; -- status=guess
lin exclusion_N = variants{} ; -- 
lin upwards_Adv = mkAdv "aufwärts" ; -- status=guess
lin transmission_N = mkN "Übertragung" feminine ; -- status=guess
lin instantly_Adv = mkAdv "unmittelbar" ; -- status=guess
lin forthcoming_A = mkA "bevorstehend" | entgegenkommend_A ; -- status=guess status=guess
lin appointed_A = variants{} ; -- 
lin geographical_A = variants{} ; -- 
lin fist_N = faust_N ; -- status=guess
lin abstract_A = abstrakt_A ; -- status=guess
lin embrace_V2 = mkV2 (umarmen_V) ; -- status=guess, src=wikt
lin embrace_V = umarmen_V ; -- status=guess, src=wikt
lin dynamic_A = dynamisch_A ; -- status=guess
lin drawer_N = zeichner_N | zeichnerin_N ; -- status=guess status=guess
lin dismissal_N = entlassung_N ; -- status=guess
lin magic_N = zauberei_N ; -- status=guess
lin endless_A = endlos_A | mkA "unbegrenzt" ; -- status=guess status=guess
lin definite_A = definitiv_A ; -- status=guess
lin broadly_Adv = variants{} ; -- 
lin affection_N = zuneigung_N ; -- status=guess
lin dawn_N = mkN "Dämmerung" feminine ; -- status=guess
lin principal_N = mkN "Schulvorsteher" masculine | mkN "Schuldirektor" masculine ; -- status=guess status=guess
lin bloke_N = kerl_N ; -- status=guess
lin trap_N = siphon_N ; -- status=guess
lin communist_A = kommunistisch_A ; -- status=guess
lin competence_N = kompetenz_N | mkN "Befähigung" feminine | mkN "Zuständigkeit" feminine ; -- status=guess status=guess status=guess
lin complicate_V2 = mkV2 (komplizieren_V) ; -- status=guess, src=wikt
lin neutral_A = neutral_A ; -- status=guess
lin fortunately_Adv = mkAdv "glücklicherweise" | mkAdv "zum Glück" ; -- status=guess status=guess
lin commonwealth_N = mkN "Staatenbund" masculine ; -- status=guess
lin breakdown_N = mkN "Betriebsstörung" feminine | panne_N ; -- status=guess status=guess
lin combined_A = variants{} ; -- 
lin candle_N = kerze_N ; -- status=guess
lin venue_N = mkN "Schauplatz" masculine | mkN "Örtlichkeit" feminine | mkN "Stätte" feminine | austragungsort_N ; -- status=guess status=guess status=guess status=guess
lin supper_N = abendessen_N ; -- status=guess
lin analyst_N = analytiker_N ; -- status=guess
lin vague_A = nebelhaft_A | schwach_A | unklar_A | undeutlich_A | mkA "ungenau" | ungewiss_A | vage_A | mkA "verschwommen" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin publicly_Adv = variants{} ; -- 
lin marine_A = variants{} ; -- 
lin fair_Adv = variants{} ; -- 
lin pause_N = pause_N ; -- status=guess
lin notable_A = bemerkenswert_A ; -- status=guess
lin freely_Adv = mkAdv "frei" ; -- status=guess
lin counterpart_N = mkN "Gegenstück" neuter | pendant_N ; -- status=guess status=guess
lin lively_A = lebhaft_A ; -- status=guess
lin script_N = schrift_N ; -- status=guess
lin sue_V2V = mkV2V (mkV "verklagen") ; -- status=guess, src=wikt
lin sue_V2 = mkV2 (mkV "verklagen") ; -- status=guess, src=wikt
lin sue_V = mkV "verklagen" ; -- status=guess, src=wikt
lin legitimate_A = mkA "gültig" ; -- status=guess
lin geography_N = geografie_N | geographie_N ; -- status=guess status=guess
lin reproduce_V2 = mkV2 (mkReflV "vermehren") ; -- status=guess, src=wikt
lin reproduce_V = mkReflV "vermehren" ; -- status=guess, src=wikt
lin moving_A = mkA "rührend" ; -- status=guess
lin lamb_N = lamm_N | mkN "Lammfleisch" neuter ; -- status=guess status=guess
lin gay_A = bunt_A ; -- status=guess
lin contemplate_VS = mkVS (mkV "nachsinnen") ; -- status=guess, src=wikt
lin contemplate_V2 = mkV2 (mkV "nachsinnen") ; -- status=guess, src=wikt
lin contemplate_V = mkV "nachsinnen" ; -- status=guess, src=wikt
lin terror_N = schrecken_N ; -- status=guess
lin stable_N = mkN "Stalljunge" masculine | mkN "Stallknecht" masculine ; -- status=guess status=guess
lin founder_N = mkN "Gründer" masculine | mkN "Gründerin" feminine ; -- status=guess status=guess
lin utility_N = mkN "nützlich" ; -- status=guess
lin signal_VS = mkVS (signalisieren_V) ; -- status=guess, src=wikt
lin signal_V2 = mkV2 (signalisieren_V) ; -- status=guess, src=wikt
lin shelter_N = mkN "Zuflucht" feminine | mkN "Obdach" neuter | zufluchtsort_N ; -- status=guess status=guess status=guess
lin poster_N = plakat_N | anschlag_N ; -- status=guess status=guess
lin hitherto_Adv = mkAdv "bis dahin" | mkAdv "bis dato" | bislang_Adv | bisher_Adv ; -- status=guess status=guess status=guess status=guess
lin mature_A = reif_A | mkA "gereift" ; -- status=guess status=guess
lin cooking_N = mkN "Kochen" neuter ; -- status=guess
lin head_A = mkA "Haupt-" ; -- status=guess
lin wealthy_A = wohlhabend_A | reich_A ; -- status=guess status=guess
lin fucking_A = mkA "Scheiß-" ; -- status=guess
lin confess_VS = mkVS (mkV "gestehen") | mkVS (beichten_V) | mkVS (bekennen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin confess_V2 = mkV2 (mkV "gestehen") | mkV2 (beichten_V) | mkV2 (bekennen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin confess_V = mkV "gestehen" | beichten_V | bekennen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin age_V = altern_V | vergreisen_V | reifen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin miracle_N = wunder_N ; -- status=guess
lin magic_A = magisch_A ; -- status=guess
lin jaw_N = kiefer_N | unterkiefer_N | mkN "Oberkiefer" masculine | mkN "Kinnbacke" feminine ; -- status=guess status=guess status=guess status=guess
lin pan_N = mkN "Panarabismus" masculine ; -- status=guess
lin coloured_A = variants{} ; -- 
lin tent_N = zelt_N ; -- status=guess
lin telephone_V2 = mkV2 (telefonieren_V) | mkV2 (anrufen_7_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin telephone_V = telefonieren_V | anrufen_7_V ; -- status=guess, src=wikt status=guess, src=wikt
lin reduced_A = variants{} ; -- 
lin tumour_N = variants{} ; -- 
lin super_A = mkA "super" ; -- status=guess
lin funding_N = finanzierung_N ; -- status=guess
lin dump_V2 = variants{} ; -- 
lin dump_V = variants{} ; -- 
lin stitch_N = mkN "Seitenstechen" neuter ; -- status=guess
lin shared_A = gemeinsam_A | geteilt_A | verteilt_A ; -- status=guess status=guess status=guess
lin ladder_N = leiter_N ; -- status=guess
lin keeper_N = variants{} ; -- 
lin endorse_V2 = mkV2 (empfehlen_V) | mkV2 (mkV "bestätigen") | mkV2 (mkV "unterstützen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin invariably_Adv = variants{} ; -- 
lin smash_V2 = mkV2 (mkV "zusammenschlagen") | mkV2 (schmettern_6_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin smash_V = mkV "zusammenschlagen" | schmettern_6_V ; -- status=guess, src=wikt status=guess, src=wikt
lin shield_N = schutz_N ; -- status=guess
lin heat_V2 = mkV2 (junkV (mkV "heiß") "machen") ; -- status=guess, src=wikt
lin heat_V = junkV (mkV "heiß") "machen" ; -- status=guess, src=wikt
lin surgeon_N = chirurg_N | mkN "Chirurgin" feminine ; -- status=guess status=guess
lin centre_V2 = variants{} ; -- 
lin centre_V = variants{} ; -- 
lin orange_N = mkN "Orangenblüte" feminine ; -- status=guess
lin orange_2_N = variants{} ; -- 
lin orange_1_N = variants{} ; -- 
lin explode_V = sprengen_V | explodieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin comedy_N = mkN "Komödie" feminine ; -- status=guess
lin classify_V2 = mkV2 (mkV "einordenen") | mkV2 (mkV "einstufen") | mkV2 (unterteilen_V) | mkV2 (klassifizieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin artistic_A = mkA "kunstvoll" ; -- status=guess
lin ruler_N = lineal_N ; -- status=guess
lin biscuit_N = mkN "Keks" ; -- status=guess
lin workstation_N = arbeitsplatz_N ; -- status=guess
lin prey_N = mkN "Beute" feminine ; -- status=guess
lin manual_N = handbuch_N ; -- status=guess
lin cure_N = heilung_N ; -- status=guess
lin cure_2_N = variants{} ; -- 
lin cure_1_N = variants{} ; -- 
lin overall_N = mkN "Overall" masculine ; -- status=guess
lin tighten_V2 = variants{} ; -- 
lin tighten_V = variants{} ; -- 
lin tax_V2 = mkV2 (mkV "besteuern") ; -- status=guess, src=wikt
lin pope_N = papst_N | mkN "" | mkN "legendary] Päpstin" feminine ; -- status=guess status=guess status=guess
lin manufacturing_A = variants{} ; -- 
lin adult_A = mkA "erwachsen" ; -- status=guess
lin rush_N = mkN "Eile" feminine | mkN "Hast" feminine ; -- status=guess status=guess
lin blanket_N = decke_N ; -- status=guess
lin republican_N = variants{} ; -- 
lin referendum_N = referendum_N | volksabstimmung_N ; -- status=guess status=guess
lin palm_N = mkN "Handfläche" feminine ; -- status=guess
lin nearby_Adv = mkAdv "nebenan" | in_petto_Adv | mkAdv "nah" ; -- status=guess status=guess status=guess
lin mix_N = mischung_N ; -- status=guess
lin devil_N = teufel_N ; -- status=guess
lin adoption_N = adoption_N ; -- status=guess
lin workforce_N = belegschaft_N | mkN "Arbeitskräfte {f} {p}" ; -- status=guess status=guess
lin segment_N = segment_N ; -- status=guess
lin regardless_Adv = variants{} ; -- 
lin contractor_N = mkN "Ausführer" ; -- status=guess
lin portion_N = teil_N ; -- status=guess
lin differently_Adv = anders_Adv ; -- status=guess
lin deposit_V2 = mkV2 (einzahlen_V) ; -- status=guess, src=wikt
lin cook_N = koch_N | mkN "Köchin" feminine ; -- status=guess status=guess
lin prediction_N = voraussage_N | vorhersage_N | prophezeiung_N ; -- status=guess status=guess status=guess
lin oven_N = ofen_N ; -- status=guess
lin matrix_N = matrix_N ; -- status=guess
lin liver_N = L.liver_N ;
lin fraud_N = betrug_N ; -- status=guess
lin beam_N = balken_N ; -- status=guess
lin signature_N = unterschrift_N ; -- status=guess
lin limb_N = glied_N | mkN "Gliedmaßen {f} {p}" | mkN "Extremitäten {f} {p}" ; -- status=guess status=guess status=guess
lin verdict_N = mkN "Gerichtsurteil" neuter ; -- status=guess
lin dramatically_Adv = variants{} ; -- 
lin container_N = container_N ; -- status=guess
lin aunt_N = tante_N ; -- status=guess
lin dock_N = variants{} ; -- 
lin submission_N = variants{} ; -- 
lin arm_V2 = mkV2 (mkV "rüsten") | mkV2 (bewaffnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin arm_V = mkV "rüsten" | bewaffnen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin odd_N = mkN "ungerade Funktion" feminine ; -- status=guess
lin certainty_N = sicherheit_N ; -- status=guess
lin boring_A = langweilig_A ; -- status=guess
lin electron_N = elektron_N ; -- status=guess
lin drum_N = fass_N ; -- status=guess
lin wisdom_N = weisheit_N ; -- status=guess
lin antibody_N = mkN "Antikörper" masculine ; -- status=guess
lin unlike_A = variants{} ; -- 
lin terrorist_N = terrorist_N | mkN "Terroristin" feminine ; -- status=guess status=guess
lin post_V2 = mkV2 (schicken_0_V) ; -- status=guess, src=wikt
lin post_V = schicken_0_V ; -- status=guess, src=wikt
lin circulation_N = blutkreislauf_N ; -- status=guess
lin alteration_N = variants{} ; -- 
lin fluid_N = fluid_N | mkN "Flüssigkeit" feminine ; -- status=guess status=guess
lin ambitious_A = ehrgeizig_A | ambitioniert_A ; -- status=guess status=guess
lin socially_Adv = variants{} ; -- 
lin riot_N = aufruhr_N | mkN "Tumult" masculine | krawall_N | mkN "Randale {f} {p}" ; -- status=guess status=guess status=guess status=guess
lin petition_N = petition_N | eingabe_N ; -- status=guess status=guess
lin fox_N = fuchs_N | mkN "Middle Low German: vos" | mkN "vohe" | mkN "vō)" ; -- status=guess status=guess status=guess status=guess
lin recruitment_N = mkN "Rekrutierung" feminine ; -- status=guess
lin well_known_A = variants{} ; -- 
lin top_V2 = variants{} ; -- 
lin service_V2 = mkV2 (warten_8_V) ; -- status=guess, src=wikt
lin flood_V2 = mkV2 (mkV "überschwemmen") | mkV2 (mkV "überfluten") ; -- status=guess, src=wikt status=guess, src=wikt
lin flood_V = mkV "überschwemmen" | mkV "überfluten" ; -- status=guess, src=wikt status=guess, src=wikt
lin taste_V2 = mkV2 (schmecken_2_V) ; -- status=guess, src=wikt
lin taste_V = schmecken_2_V ; -- status=guess, src=wikt
lin memorial_N = mkN "Gedenkgottesdienst" masculine ; -- status=guess
lin helicopter_N = helikopter__N | hubschrauber_N ; -- status=guess status=guess
lin correspondence_N = korrespondenz_N ; -- status=guess
lin beef_N = mkN "Rindfleisch" neuter | mkN "Ochsenfleisch" ; -- status=guess status=guess
lin overall_Adv = insgesamt_Adv ; -- status=guess
lin lighting_N = variants{} ; -- 
lin harbour_N = L.harbour_N ;
lin empirical_A = empirisch_A ; -- status=guess
lin shallow_A = mkA "oberflächlich" ; -- status=guess
lin seal_V2 = variants{} ; -- 
lin seal_V = variants{} ; -- 
lin decrease_V2 = mkV2 (abnehmen_V) ; -- status=guess, src=wikt
lin decrease_V = abnehmen_V ; -- status=guess, src=wikt
lin constituent_N = mkN "Wähler" masculine ; -- status=guess
lin exam_N = variants{} ; -- 
lin toe_N = zeh_N | zehe_N ; -- status=guess status=guess
lin reward_V2 = mkV2 (belohnen_V) ; -- status=guess, src=wikt
lin thrust_V2 = mkV2 (schieben_4_V) | mkV2 (mkV "stoßen") ; -- status=guess, src=wikt status=guess, src=wikt
lin thrust_V = schieben_4_V | mkV "stoßen" ; -- status=guess, src=wikt status=guess, src=wikt
lin bureaucracy_N = mkN "Bürokratie" feminine ; -- status=guess
lin wrist_N = handgelenk_N ; -- status=guess
lin nut_N = nuss_N ; -- status=guess
lin plain_N = ebene_N ; -- status=guess
lin magnetic_A = magnetisch_A ; -- status=guess
lin evil_N = mkN "Böse" neuter | mkN "Übel" neuter ; -- status=guess status=guess
lin widen_V2 = mkV2 (mkReflV "weiten") ; -- status=guess, src=wikt
lin hazard_N = zufall_N ; -- status=guess
lin dispose_V2 = mkV2 (beseitigen_V) | mkV2 (entsorgen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin dispose_V = beseitigen_V | entsorgen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin dealing_N = variants{} ; -- 
lin absent_A = abwesend_A ; -- status=guess
lin reassure_V2S = variants{} ; -- 
lin reassure_V2 = variants{} ; -- 
lin model_V2 = mkV2 (mkV "modellieren") ; -- status=guess, src=wikt
lin model_V = mkV "modellieren" ; -- status=guess, src=wikt
lin inn_N = herberge_N ; -- status=guess
lin initial_N = initiale_N | mkN "Initial" neuter ; -- status=guess status=guess
lin suspension_N = mkN "Aussetzung" feminine ; -- status=guess
lin respondent_N = variants{} ; -- 
lin over_N = variants{} ; -- 
lin naval_A = variants{} ; -- 
lin monthly_A = monatlich_A ; -- status=guess
lin log_N = blockhaus_N | mkN "Blockbau" masculine ; -- status=guess status=guess
lin advisory_A = mkA "beratend" | mkA "Beratungs-" ; -- status=guess status=guess
lin fitness_N = mkN "Tauglichkeit" feminine | mkN "Zweckmäßigkeit" feminine ; -- status=guess status=guess
lin blank_A = mkA "unbeschrieben" | mkA "unausgefüllt" ; -- status=guess status=guess
lin indirect_A = variants{} ; -- 
lin tile_N = mkN "Kachel" feminine | fliese_N | dachziegel_N ; -- status=guess status=guess status=guess
lin rally_N = kundgebung_N ; -- status=guess
lin economist_N = mkN "Wirtschaftswissenschaftler" masculine | mkN "Ökonom" masculine ; -- status=guess status=guess
lin vein_N = vene_N ; -- status=guess
lin strand_N = strand_N ; -- status=guess
lin disturbance_N = mkN "Störung" feminine ; -- status=guess
lin stuff_V2 = mkV2 (ausstopfen_V) ; -- status=guess, src=wikt
lin seldom_Adv = mkAdv "selten" ; -- status=guess
lin coming_A = variants{} ; -- 
lin cab_N = mkN "Führerhaus" neuter | mkN "Fahrerhaus" neuter | mkN "Führerkabine" feminine | mkN "Fahrerkabine" feminine ; -- status=guess status=guess status=guess status=guess
lin grandfather_N = mkN "Großvater" masculine | opa_N | mkN "Opi" masculine | mkN "Großvater väterlicherseits" masculine | mkN "Großvater mütterlicherseits" masculine ; -- status=guess status=guess status=guess status=guess status=guess
lin flash_V = blinken_V ; -- status=guess, src=wikt
lin destination_N = reiseziel_N | bestimmungsort_N ; -- status=guess status=guess
lin actively_Adv = variants{} ; -- 
lin regiment_N = regiment_N ; -- status=guess
lin closed_A = geschlossen_A ; -- status=guess
lin boom_N = mkN "Dröhnen" masculine ; -- status=guess
lin handful_N = variants{} ; -- 
lin remarkably_Adv = variants{} ; -- 
lin encouragement_N = mkN "Ermutigung" feminine ; -- status=guess
lin awkward_A = ungeschickt_A | mkA "unbeholfen" | mkA "tölpelhaft" | mkA "patschert" ; -- status=guess status=guess status=guess status=guess
lin required_A = variants{} ; -- 
lin flood_N = flut_N ; -- status=guess
lin defect_N = fehler_N | defekt_N ; -- status=guess status=guess
lin surplus_N = mkN "Überschuss" masculine ; -- status=guess
lin champagne_N = champagner_N ; -- status=guess
lin liquid_N = mkN "Flüssigkeit" feminine ; -- status=guess
lin shed_V2 = mkV2 (mkV "vergießen") ; -- status=guess, src=wikt
lin welcome_N = mkN "Begrüßung" feminine | empfang_N ; -- status=guess status=guess
lin rejection_N = variants{} ; -- 
lin discipline_V2 = mkV2 (disziplinieren_V) ; -- status=guess, src=wikt
lin halt_V2 = mkV2 (anhalten_3_V) | mkV2 (stoppen_V) | mkV2 (stocken_8_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin halt_V = anhalten_3_V | stoppen_V | stocken_8_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin electronics_N = mkN "Elektronik" feminine ; -- status=guess
lin administratorMasc_N = mkN "Nachlassverwalter" masculine ; -- status=guess
lin sentence_V2 = mkV2 (mkV "verurteilen") ; -- status=guess, src=wikt
lin sentence_V = mkV "verurteilen" ; -- status=guess, src=wikt
lin ill_Adv = variants{} ; -- 
lin contradiction_N = widerspruch_N ; -- status=guess
lin nail_N = mkN "Nagelbombe" feminine ; -- status=guess
lin senior_N = stabshauptmann_N ; -- status=guess
lin lacking_A = variants{} ; -- 
lin colonial_A = variants{} ; -- 
lin primitive_A = primitiv_A ; -- status=guess
lin whoever_NP = variants{} ; -- 
lin lap_N = mkN "Schoß" masculine ; -- status=guess
lin commodity_N = ware_N ; -- status=guess
lin planned_A = variants{} ; -- 
lin intellectual_N = mkN "Intellektueller" masculine | mkN "Intellektuelle" feminine ; -- status=guess status=guess
lin imprisonment_N = gefangenschaft_N | mkN "Haft" feminine ; -- status=guess status=guess
lin coincide_V = mkV "übereinstimmen" ; -- status=guess, src=wikt
lin sympathetic_A = mkA "mitfühlend" ; -- status=guess
lin atom_N = atom_N ; -- status=guess
lin tempt_V2V = mkV2V (locken_4_V) ; -- status=guess, src=wikt
lin tempt_V2 = mkV2 (locken_4_V) ; -- status=guess, src=wikt
lin sanction_N = mkN "Billigung" feminine | mkN "Billigung" feminine | mkN "Sanktionierung" feminine ; -- status=guess status=guess status=guess
lin praise_V2 = mkV2 (loben_5_V) ; -- status=guess, src=wikt
lin favourable_A = mkA "günstig" ; -- status=guess
lin dissolve_V2 = mkV2 (mkReflV "auflösen") ; -- status=guess, src=wikt
lin dissolve_V = mkReflV "auflösen" ; -- status=guess, src=wikt
lin tightly_Adv = variants{} ; -- 
lin surrounding_N = variants{} ; -- 
lin soup_N = suppe_N ; -- status=guess
lin encounter_N = begegnung_N | treffen_N ; -- status=guess status=guess
lin abortion_N = abtreibung_N ; -- status=guess
lin grasp_V2 = mkV2 (greifen_8_V) | mkV2 (erfassen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin grasp_V = greifen_8_V | erfassen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin custody_N = sorgerecht_N | mkN "Obhut" feminine ; -- status=guess status=guess
lin composer_N = komponist_N | mkN "Komponistin" feminine ; -- status=guess status=guess
lin charm_N = mkN "Charme" masculine ; -- status=guess
lin short_term_A = variants{} ; -- 
lin metropolitan_A = variants{} ; -- 
lin waist_N = taille_N ; -- status=guess
lin equality_N = mkN "Gleichberechtigung" feminine ; -- status=guess
lin tribute_N = tribut_N ; -- status=guess
lin bearing_N = mkN "Lager" neuter ; -- status=guess
lin auction_N = mkN "Versteigerung" feminine | auktion_N ; -- status=guess status=guess
lin standing_N = mkN "stehende Ovation" feminine | mkN "Stehapplaus" masculine | mkN "Stehbeifall" masculine ; -- status=guess status=guess status=guess
lin manufacture_N = produktion_N ; -- status=guess
lin horn_N = L.horn_N ;
lin barn_N = scheune_N | stall_N | schuppen_N ; -- status=guess status=guess status=guess
lin mayor_N = mkN "Bürgermeister" masculine | mkN "Bürgermeisterin" feminine ; -- status=guess status=guess
lin emperor_N = kaiser_N | mkN "Imperator" masculine ; -- status=guess status=guess
lin rescue_N = rettung_N ; -- status=guess
lin integrated_A = integriert_A ; -- status=guess
lin conscience_N = gewissen_N ; -- status=guess
lin commence_V2 = mkV2 (anfangen_6_V) | mkV2 (beginnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin commence_V = anfangen_6_V | beginnen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin grandmother_N = mkN "Großmutter" feminine | omi_N | oma_N ; -- status=guess status=guess status=guess
lin discharge_V2 = mkV2 (mkV "entladen") ; -- status=guess, src=wikt
lin discharge_V = mkV "entladen" ; -- status=guess, src=wikt
lin profound_A = tief_A | profund_A ; -- status=guess status=guess
lin takeover_N = mkN "Geschäftsübernahme" feminine | mkN "Übernahme" feminine ; -- status=guess status=guess
lin nationalist_N = mkN "Nationalist" masculine | mkN "Nationalistin" feminine ; -- status=guess status=guess
lin effect_V2 = mkV2 (bewirken_V) ; -- status=guess, src=wikt
lin dolphin_N = delphin_N | delfin_N ; -- status=guess status=guess
lin fortnight_N = variants{} ; -- 
lin elephant_N = elefant_N | mkN "Elefantenbulle" masculine | mkN "Elefantin" feminine | mkN "Elefantenkuh" feminine | mkN "Elefantenkalb" neuter ; -- status=guess status=guess status=guess status=guess status=guess
lin seal_N = siegel_N | petschaft_N ; -- status=guess status=guess
lin spoil_V2 = mkV2 (verderben_V) ; -- status=guess, src=wikt
lin spoil_V = verderben_V ; -- status=guess, src=wikt
lin plea_N = mkN "Ersuchen" neuter | mkN "Flehen" neuter | bitte_N | appell_N ; -- status=guess status=guess status=guess status=guess
lin forwards_Adv = variants{} ; -- 
lin breeze_N = kinderspiel_N ; -- status=guess
lin prevention_N = mkN "Prävention" feminine ; -- status=guess
lin mineral_N = mkN "Mineral" neuter ; -- status=guess
lin runner_N = mkN "Läufer" ; -- status=guess
lin pin_V2 = variants{} ; -- 
lin integrity_N = mkN "Integrität" feminine ; -- status=guess
lin thereafter_Adv = variants{} ; -- 
lin quid_N = variants{} ; -- 
lin owl_N = eule_N | uhu_N ; -- status=guess status=guess
lin rigid_A = steif_A ; -- status=guess
lin orange_A = orange_A ; -- status=guess
lin draft_V2 = mkV2 (mkV "abkommandieren") ; -- status=guess, src=wikt
lin reportedly_Adv = variants{} ; -- 
lin hedge_N = hecke_N ; -- status=guess
lin formulate_V2 = mkV2 (formulieren_V) | mkV2 (darlegen_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin associated_A = variants{} ; -- 
lin position_V2 = mkV2 (mkV "positionieren") ; -- status=guess, src=wikt
lin thief_N = dieb_N ; -- status=guess
lin tomato_N = tomate_N | paradeiser_N ; -- status=guess status=guess
lin exhaust_V2 = mkV2 (mkV "erschöpfen") | mkV2 (dezimieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin evidently_Adv = variants{} ; -- 
lin eagle_N = mkN "Zehn-Dollar-Note" feminine ; -- status=guess
lin specified_A = variants{} ; -- 
lin resulting_A = variants{} ; -- 
lin blade_N = klinge_N ; -- status=guess
lin peculiar_A = variants{} ; -- 
lin killing_N = mkN "Töten" neuter | mkN "Erlegen" neuter ; -- status=guess status=guess
lin desktop_N = mkN "Desktop-Computer" masculine ; -- status=guess
lin bowel_N = mkN "Inneres" neuter | eingeweide_N | bauch_N ; -- status=guess status=guess status=guess
lin long_V = mkV "sehnen" ; -- status=guess, src=wikt
lin ugly_A = L.ugly_A ;
lin expedition_N = expedition_N ; -- status=guess
lin saint_N = mkN "Heiliger" masculine | mkN "Heilige" feminine ; -- status=guess status=guess
lin variable_A = variabel_A ; -- status=guess
lin supplement_V2 = variants{} ; -- 
lin stamp_N = stempel_N ; -- status=guess
lin slide_N = rutsche_N ; -- status=guess
lin faction_N = fraktion_N ; -- status=guess
lin enthusiastic_A = enthusiastisch_A | mkA "begeistert" ; -- status=guess status=guess
lin enquire_V2 = variants{} ; -- 
lin enquire_V = variants{} ; -- 
lin brass_N = mkN "Messing" neuter ; -- status=guess
lin inequality_N = ungleichung_N ; -- status=guess
lin eager_A = begierig_A | mkA "gierig" ; -- status=guess status=guess
lin bold_A = mutig_A | mkA "wagemutig" | tapfer_A | mkA "kühn" ; -- status=guess status=guess status=guess status=guess
lin neglect_V2 = mkV2 (missachten_V) ; -- status=guess, src=wikt
lin saying_N = sprichwort_N | ausspruch_N ; -- status=guess status=guess
lin ridge_N = grat_N ; -- status=guess
lin earl_N = graf_N ; -- status=guess
lin yacht_N = yacht_N | jacht_N ; -- status=guess status=guess
lin suck_V2 = L.suck_V2 ;
lin suck_V = junkV (mkV "mies") "sein" | junkV (mkV "zum") "Kotzen sein" | junkV (mkV "Scheiße") "sein" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin missing_A = fehlend_A ; -- status=guess
lin extended_A = variants{} ; -- 
lin valuation_N = variants{} ; -- 
lin delight_V2 = variants{} ; -- 
lin delight_V = variants{} ; -- 
lin beat_N = variants{} ; -- 
lin worship_N = mkN "Verehrung" feminine | anbetung_N ; -- status=guess status=guess
lin fossil_N = fossil_N ; -- status=guess
lin diminish_V2 = mkV2 (schrumpfen_V) ; -- status=guess, src=wikt
lin diminish_V = schrumpfen_V ; -- status=guess, src=wikt
lin taxpayer_N = steuerzahler_N | mkN "Steuerzahlerin" feminine ; -- status=guess status=guess
lin corruption_N = korruption_N ; -- status=guess
lin accurately_Adv = mkAdv "genau" | mkAdv "akkurat" | mkAdv "präzise" ; -- status=guess status=guess status=guess
lin honour_V2 = mkV2 (ehren_V) ; -- status=guess, src=wikt
lin depict_V2 = mkV2 (darstellen_V) ; -- status=guess, src=wikt
lin pencil_N = mkN "Federkasten" masculine | mkN "Federmäppchen" neuter ; -- status=guess status=guess
lin drown_V2 = mkV2 (ertrinken_V) ; -- status=guess, src=wikt
lin drown_V = ertrinken_V ; -- status=guess, src=wikt
lin stem_N = stamm_N ; -- status=guess
lin lump_N = mkN "Kloß" masculine ; -- status=guess
lin applicable_A = anwendbar_A ; -- status=guess
lin rate_V2 = variants{} ; -- 
lin rate_V = variants{} ; -- 
lin mobility_N = mkN "Mobilität" feminine ; -- status=guess
lin immense_A = immens_A ; -- status=guess
lin goodness_N = mkN "Güte" feminine | mkN "Gütigkeit" feminine | mkN "Herzensgüte" feminine | tugend_N | mkN "Integrität" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin price_V2V = mkV2V (mkV "schätzen") | mkV2V (junkV (mkV "den") "Preis festsetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V2 = mkV2 (mkV "schätzen") | mkV2 (junkV (mkV "den") "Preis festsetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V = mkV "schätzen" | junkV (mkV "den") "Preis festsetzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin preliminary_A = mkA "vorläufig" | mkA "vorbereitend" ; -- status=guess status=guess
lin graph_N = graph_N ; -- status=guess
lin referee_N = rezensent_N | lektor_N ; -- status=guess status=guess
lin calm_A = ruhig_A ; -- status=guess
lin onwards_Adv = variants{} ; -- 
lin omit_V2 = mkV2 (weglassen_9_V) | mkV2 (auslassen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin genuinely_Adv = variants{} ; -- 
lin excite_V2 = mkV2 (erregen_V) | mkV2 (anregen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin dreadful_A = furchtbar_A | schrecklich_A ; -- status=guess status=guess
lin cave_N = mkN "Höhle" feminine ; -- status=guess
lin revelation_N = offenbarung_N ; -- status=guess
lin grief_N = mkN "Kummer" masculine ; -- status=guess
lin erect_V2 = variants{} ; -- 
lin tuck_V2 = mkV2 (junkV (mkV "1.") "stecken") ; -- status=guess, src=wikt
lin tuck_V = junkV (mkV "1.") "stecken" ; -- status=guess, src=wikt
lin meantime_N = variants{} ; -- 
lin barrel_N = lauf_N ; -- status=guess
lin lawn_N = rasen_N | wiese_N ; -- status=guess status=guess
lin hut_N = mkN "Hütte" feminine ; -- status=guess
lin swing_N = schaukel_N | mkN "" | mkN "Austrian] Hutsche" feminine ; -- status=guess status=guess status=guess
lin subject_V2 = mkV2 (mkV "unterwerfen") ; -- status=guess, src=wikt
lin ruin_V2 = mkV2 (ruinieren_V) ; -- status=guess, src=wikt
lin slice_N = mkN "Brotscheibe" feminine | scheibe_N | anteil_N | teil_N | mkN "Stück" neuter ; -- status=guess status=guess status=guess status=guess status=guess
lin transmit_V2 = mkV2 (mkV "übermitteln") ; -- status=guess, src=wikt
lin thigh_N = oberschenkel_N ; -- status=guess
lin practically_Adv = mkAdv "praktisch" ; -- status=guess
lin dedicate_V2 = mkV2 (widmen_V) ; -- status=guess, src=wikt
lin mistake_V2 = mkV2 (verwechseln_V) ; -- status=guess, src=wikt
lin mistake_V = verwechseln_V ; -- status=guess, src=wikt
lin corresponding_A = korrespondierend_A ; -- status=guess
lin albeit_Subj = variants{} ; -- 
lin sound_A = gesund_A ; -- status=guess
lin nurse_V2 = mkV2 (stillen_1_V) | mkV2 (junkV (mkV "dated:") "nähren") ; -- status=guess, src=wikt status=guess, src=wikt
lin discharge_N = entlassung_N ; -- status=guess
lin comparative_A = mkA "vergleichend" ; -- status=guess
lin cluster_N = mkN "Streubombe" feminine ; -- status=guess
lin propose_VV = mkVV (einen_V) ; -- status=guess, src=wikt
lin propose_VS = mkVS (einen_V) ; -- status=guess, src=wikt
lin propose_V2 = mkV2 (einen_V) ; -- status=guess, src=wikt
lin propose_V = einen_V ; -- status=guess, src=wikt
lin obstacle_N = hindernis_N ; -- status=guess
lin motorway_N = autobahn_N ; -- status=guess
lin heritage_N = mkN "Geburtsrecht" neuter | mkN "Erbe" neuter ; -- status=guess status=guess
lin counselling_N = variants{} ; -- 
lin breeding_N = variants{} ; -- 
lin characteristic_A = charakteristisch_A | mkA "bezeichnend" | kennzeichnend_A | typisch_A ; -- status=guess status=guess status=guess status=guess
lin bucket_N = ein_euro_job_N ; -- status=guess
lin migration_N = migration_N ; -- status=guess
lin campaign_V = mkReflV "einsetzen" ; -- status=guess, src=wikt
lin ritual_N = mkN "Ritual" neuter ; -- status=guess
lin originate_V2 = mkV2 (entwickeln_V) | mkV2 (erzeugen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin originate_V = entwickeln_V | erzeugen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin hunting_N = jagd_N ; -- status=guess
lin crude_A = roh_A ; -- status=guess
lin protocol_N = variants{} ; -- 
lin prejudice_N = vorurteil_N | mkN "Voreingenommenheit" feminine ; -- status=guess status=guess
lin inspiration_N = mkN "Einatmung" feminine | mkN "Einatmen" neuter ; -- status=guess status=guess
lin dioxide_N = dioxid_N ; -- status=guess
lin chemical_A = chemisch_A ; -- status=guess
lin uncomfortable_A = unbehaglich_A ; -- status=guess
lin worthy_A = mkA "würdig" ; -- status=guess
lin inspect_V2 = mkV2 (mkV "begutachten") | mkV2 (untersuchen_V) | mkV2 (mkV "inspizieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin summon_V2 = mkV2 (vorladen_2_V) ; -- status=guess, src=wikt
lin parallel_N = barren_N ; -- status=guess
lin outlet_N = mkN "Direktverkauf" masculine ; -- status=guess
lin okay_A = variants{} ; -- 
lin collaboration_N = mkN "Kollektivarbeit" feminine | mkN "Zusammenarbeit" feminine | mkN "Kollaboration" feminine ; -- status=guess status=guess status=guess
lin booking_N = buchung_N | mkN "Reservierung" feminine ; -- status=guess status=guess
lin salad_N = salat_N ; -- status=guess
lin productive_A = produktiv_A ; -- status=guess
lin charming_A = charmant_A ; -- status=guess
lin polish_A = variants{} ; -- 
lin oak_N = eiche_N ; -- status=guess
lin access_V2 = mkV2 (junkV (mkV "Zugang") "haben") ; -- status=guess, src=wikt
lin tourism_N = mkN "Tourismus" masculine ; -- status=guess
lin independently_Adv = mkAdv "unabhängig" | mkAdv "selbstständig" ; -- status=guess status=guess
lin cruel_A = grausam_A ; -- status=guess
lin diversity_N = mkN "Vielfältigkeit" feminine | mannigfaltigkeit_N | mkN "Vielfalt" feminine | mkN "Diversität" feminine ; -- status=guess status=guess status=guess status=guess
lin accused_A = mkA "angeklagt" ; -- status=guess
lin supplement_N = mkN "Ergänzung" feminine | nachtrag_N ; -- status=guess status=guess
lin fucking_Adv = variants{} ; -- 
lin forecast_N = mkN "Schätzung" feminine ; -- status=guess
lin amend_V2V = mkV2V (verbessern_V) ; -- status=guess, src=wikt
lin amend_V2 = mkV2 (verbessern_V) ; -- status=guess, src=wikt
lin amend_V = verbessern_V ; -- status=guess, src=wikt
lin soap_N = seife_N ; -- status=guess
lin ruling_N = mkN "Reißfeder" feminine ; -- status=guess
lin interference_N = mkN "Störung" feminine ; -- status=guess
lin executive_A = mkA "exekutiv" ; -- status=guess
lin mining_N = mkN "Bergbau" masculine ; -- status=guess
lin minimal_A = minimal_A ; -- status=guess
lin clarify_V2 = variants{} ; -- 
lin clarify_V = variants{} ; -- 
lin strain_V2 = variants{} ; -- 
lin novel_A = neuartig_A | neu_A ; -- status=guess status=guess
lin try_N = versuch_N ; -- status=guess
lin coastal_A = mkA "Küsten-" ; -- status=guess
lin rising_A = mkA "steigend" | mkA "aufgehend" ; -- status=guess status=guess
lin quota_N = quote_N ; -- status=guess
lin minus_Prep = variants{} ; -- 
lin kilometre_N = kilometer_N ; -- status=guess
lin characterize_V2 = mkV2 (charakterisieren_V) ; -- status=guess, src=wikt
lin suspicious_A = mkA "verdächtig" ; -- status=guess
lin pet_N = haustier_N | heimtier_N ; -- status=guess status=guess
lin beneficial_A = mkA "nützlich" | vorteilhaft_A ; -- status=guess status=guess
lin fling_V2 = mkV2 (schleudern_V) ; -- status=guess, src=wikt
lin fling_V = schleudern_V ; -- status=guess, src=wikt
lin deprive_V2 = mkV2 (aberkennen_V) | mkV2 (wegnehmen_8_V) | mkV2 (mkV "berauben") | mkV2 (verweigern_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin covenant_N = zusage_N ; -- status=guess
lin bias_N = mkN "Voreingenommenheit" feminine ; -- status=guess
lin trophy_N = mkN "Trophäe" feminine ; -- status=guess
lin verb_N = verb_N | verbum_N | zeitwort_N ; -- status=guess status=guess status=guess
lin honestly_Adv = mkAdv "ehrlich" ; -- status=guess
lin extract_N = variants{} ; -- 
lin straw_N = halm_N | strohhalm_N ; -- status=guess status=guess
lin stem_V2 = mkV2 (kommen_7_V) | mkV2 (junkV (mkV "herrühren") "von") ; -- status=guess, src=wikt status=guess, src=wikt
lin stem_V = kommen_7_V | junkV (mkV "herrühren") "von" ; -- status=guess, src=wikt status=guess, src=wikt
lin eyebrow_N = augenbraue_N ; -- status=guess
lin noble_A = nobel_A | mkA "adel" | edel_A ; -- status=guess status=guess status=guess
lin mask_N = maske_N ; -- status=guess
lin lecturer_N = lektor_N ; -- status=guess
lin girlfriend_N = freundin_N ; -- status=guess
lin forehead_N = stirn_N ; -- status=guess
lin timetable_N = mkN "Zeitplan" masculine | fahrplan_N | stundenplan_N | mkN "etc.)" ; -- status=guess status=guess status=guess status=guess
lin symbolic_A = symbolisch_A ; -- status=guess
lin farming_N = variants{} ; -- 
lin lid_N = deckel_N ; -- status=guess
lin librarian_N = bibliothekar_N | bibliothekarin_N ; -- status=guess status=guess
lin injection_N = injektion_N ; -- status=guess
lin sexuality_N = mkN "Sexualität" feminine ; -- status=guess
lin irrelevant_A = irrelevant_A ; -- status=guess
lin bonus_N = mkN "Bonus" masculine | mkN "Prämie" feminine ; -- status=guess status=guess
lin abuse_V2 = mkV2 (mkV "missbrauchen") ; -- status=guess, src=wikt
lin thumb_N = daumen_N ; -- status=guess
lin survey_V2 = variants{} ; -- 
lin ankle_N = mkN "Knöchel" masculine | mkN "Fußknöchel" masculine | enkel_N ; -- status=guess status=guess status=guess
lin psychologist_N = psychologe_N | mkN "Psychologin" feminine ; -- status=guess status=guess
lin occurrence_N = vorfall_N ; -- status=guess
lin profitable_A = mkA "gewinnbringend" | profitabel_A | lukrativ_A ; -- status=guess status=guess status=guess
lin deliberate_A = mkA "wohlerwogen" | mkA "wohlüberlegt" | mkA "überlegt" ; -- status=guess status=guess status=guess
lin bow_V2 = mkV2 (mkReflV "biegen") | mkV2 (mkReflV "verbiegen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bow_V = mkReflV "biegen" | mkReflV "verbiegen" ; -- status=guess, src=wikt status=guess, src=wikt
lin tribe_N = stamm_N | volksstamm_N | sippe_N | volk_N | mkN "Völkchen" neuter | mkN "Völklein" neuter | mkN "Sippschaft" feminine | tribus_N | mkN "Völkerschaft" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin rightly_Adv = variants{} ; -- 
lin representative_A = mkA "repräsentativ" ; -- status=guess
lin code_V2 = variants{} ; -- 
lin validity_N = variants{} ; -- 
lin marble_N = marmor_N ; -- status=guess
lin bow_N = pfeil_N ; -- status=guess
lin plunge_V2 = variants{} ; -- 
lin plunge_V = variants{} ; -- 
lin maturity_N = mkN "Reife" feminine ; -- status=guess
lin maturity_3_N = variants{} ; -- 
lin maturity_2_N = variants{} ; -- 
lin maturity_1_N = variants{} ; -- 
lin hidden_A = mkA "versteckt" | mkA "verborgen" ; -- status=guess status=guess
lin contrast_V2 = mkV2 (mkV "gegenüberstellen") | mkV2 (kontrastieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin contrast_V = mkV "gegenüberstellen" | kontrastieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin tobacco_N = mkN "Tabakpflanze" feminine ; -- status=guess
lin middle_class_A = variants{} ; -- 
lin grip_V2 = mkV2 (festhalten_1_V) | mkV2 (greifen_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin clergy_N = mkN "Geistlichkeit" feminine | mkN "Klerus" masculine ; -- status=guess status=guess
lin trading_A = variants{} ; -- 
lin passive_A = passiv_A | mkA "passivisch" ; -- status=guess status=guess
lin decoration_N = mkN "Dekorieren" neuter | mkN "Verschönern" neuter ; -- status=guess status=guess
lin racial_A = mkA "rassisch" | mkA "Rassen-" ; -- status=guess status=guess
lin well_N = brunnen_N ; -- status=guess
lin embarrassment_N = variants{} ; -- 
lin sauce_N = mkN "Soße" feminine | sauce_N ; -- status=guess status=guess
lin fatal_A = mkA "verhängnisvoll" | fatal_A ; -- status=guess status=guess
lin banker_N = bankier_N ; -- status=guess
lin compensate_V2 = mkV2 (kompensieren_V) ; -- status=guess, src=wikt
lin compensate_V = kompensieren_V ; -- status=guess, src=wikt
lin make_up_N = variants{} ; -- 
lin popularity_N = mkN "Popularität" feminine ; -- status=guess
lin interior_A = variants{} ; -- 
lin eligible_A = mkA "erwünscht" ; -- status=guess
lin continuity_N = mkN "Kontinuität" feminine ; -- status=guess
lin bunch_N = mkN "" | mkN "fruit etc.] Bund" masculine | mkN "Strauß" masculine ; -- status=guess status=guess status=guess
lin hook_N = haken_N | angelhaken_N ; -- status=guess status=guess
lin wicket_N = variants{} ; -- 
lin pronounce_V2 = mkV2 (mkV "verkünden") ; -- status=guess, src=wikt
lin pronounce_V = mkV "verkünden" ; -- status=guess, src=wikt
lin ballet_N = ballett_N ; -- status=guess
lin heir_N = mkN "Thronerbe" masculine ; -- status=guess
lin positively_Adv = mkAdv "definitiv" | mkAdv "bestimmt" | mkAdv "entschieden" | mkAdv "eindeutig" ; -- status=guess status=guess status=guess status=guess
lin insufficient_A = unzureichend_A | mkA "ungenügend" ; -- status=guess status=guess
lin substitute_V2 = mkV2 (ersetzen_V) ; -- status=guess, src=wikt
lin substitute_V = ersetzen_V ; -- status=guess, src=wikt
lin mysterious_A = mkA "rätselhaft" ; -- status=guess
lin dancer_N = mkN "Tänzerin" feminine | mkN "Tänzer" masculine ; -- status=guess status=guess
lin trail_N = spur_N ; -- status=guess
lin caution_N = mkN "Vorsicht" feminine | achtsamkeit_N | mkN "Behutsamkeit" feminine ; -- status=guess status=guess status=guess
lin donation_N = abgabe_N | spende_N ; -- status=guess status=guess
lin added_A = variants{} ; -- 
lin weaken_V2 = mkV2 (mkV "schwächen") ; -- status=guess, src=wikt
lin weaken_V = mkV "schwächen" ; -- status=guess, src=wikt
lin tyre_N = reifen_N ; -- status=guess
lin sufferer_N = variants{} ; -- 
lin managerial_A = variants{} ; -- 
lin elaborate_A = mkA "ausführlich" | mkA "durchdacht" ; -- status=guess status=guess
lin restraint_N = mkN "Zurückhaltung" feminine ; -- status=guess
lin renew_V2 = mkV2 (erneuern_V) ; -- status=guess, src=wikt
lin gardenerMasc_N = mkN "Gärtner" masculine | mkN "Gärtnerin" feminine ; -- status=guess status=guess
lin dilemma_N = mkN "Dilemma" neuter ; -- status=guess
lin configuration_N = konfiguration_N ; -- status=guess
lin rear_A = variants{} ; -- 
lin embark_V2 = mkV2 (mkV "einschiffen") ; -- status=guess, src=wikt
lin embark_V = mkV "einschiffen" ; -- status=guess, src=wikt
lin misery_N = misere_N | mkN "Elend" neuter ; -- status=guess status=guess
lin importantly_Adv = variants{} ; -- 
lin continually_Adv = variants{} ; -- 
lin appreciation_N = anerkennung_N | mkN "Würdigung" feminine | dankbarkeit_N | mkN "Wertschätzung" feminine ; -- status=guess status=guess status=guess status=guess
lin radical_N = radikal_N ; -- status=guess
lin diverse_A = verschieden_A | unterschiedlich_A ; -- status=guess status=guess
lin revive_V2 = mkV2 (wiederbeleben_1_V) ; -- status=guess, src=wikt
lin revive_V = wiederbeleben_1_V ; -- status=guess, src=wikt
lin trip_V = stolpern_V ; -- status=guess, src=wikt
lin lounge_N = lounge_N ; -- status=guess
lin dwelling_N = wohnsitz_N | wohnung_N ; -- status=guess status=guess
lin parental_A = elterlich_A ; -- status=guess
lin loyal_A = loyal_A | treu_A ; -- status=guess status=guess
lin privatisation_N = variants{} ; -- 
lin outsider_N = mkN "Außenseiter" masculine | mkN "Außenseiterin" feminine ; -- status=guess status=guess
lin forbid_V2 = mkV2 (verbieten_V) | mkV2 (untersagen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin yep_Interj = variants{} ; -- 
lin prospective_A = voraussichtlich_A ; -- status=guess
lin manuscript_N = manuskript_N | handschrift_N | mkN "Kodex" masculine ; -- status=guess status=guess status=guess
lin inherent_A = innewohnend_A | mkA "inhärent" ; -- status=guess status=guess
lin deem_V2V = mkV2V (halten_5_V) | mkV2V (mkV "erachten") ; -- status=guess, src=wikt status=guess, src=wikt
lin deem_V2A = mkV2A (halten_5_V) | mkV2A (mkV "erachten") ; -- status=guess, src=wikt status=guess, src=wikt
lin deem_V2 = mkV2 (halten_5_V) | mkV2 (mkV "erachten") ; -- status=guess, src=wikt status=guess, src=wikt
lin telecommunication_N = variants{} ; -- 
lin intermediate_A = variants{} ; -- 
lin worthwhile_A = mkA "lohnend" | wertvoll_A ; -- status=guess status=guess
lin calendar_N = kalender_N ; -- status=guess
lin basin_N = becken_N | waschbecken_N ; -- status=guess status=guess
lin utterly_Adv = variants{} ; -- 
lin rebuild_V2 = mkV2 (mkV "wiederaufbauen") | mkV2 (mkV "umbauen") ; -- status=guess, src=wikt status=guess, src=wikt
lin pulse_N = puls_N ; -- status=guess
lin suppress_V2 = mkV2 (mkV "unterdrücken") ; -- status=guess, src=wikt
lin predator_N = raubtier_N ; -- status=guess
lin width_N = breite_N | weite_N ; -- status=guess status=guess
lin stiff_A = steif_A | starr_A ; -- status=guess status=guess
lin spine_N = mkN "Rückgrat" neuter | mkN "Wirbelsäule" feminine ; -- status=guess status=guess
lin betray_V2 = mkV2 (verraten_V) ; -- status=guess, src=wikt
lin punish_V2 = mkV2 (bestrafen_V) | mkV2 (strafen_3_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin stall_N = stall_N ; -- status=guess
lin lifestyle_N = lebensstil_N | lebensweise_N ; -- status=guess status=guess
lin compile_V2 = mkV2 (mkV "zusammenstellen") ; -- status=guess, src=wikt
lin arouse_V2V = mkV2V (erregen_V) ; -- status=guess, src=wikt
lin arouse_V2 = mkV2 (erregen_V) ; -- status=guess, src=wikt
lin partially_Adv = teilweise_Adv | teils_Adv ; -- status=guess status=guess
lin headline_N = schlagzeile_N ; -- status=guess
lin divine_A = mkA "göttlich" ; -- status=guess
lin unpleasant_A = unangenehm_A ; -- status=guess
lin sacred_A = heilig_A ; -- status=guess
lin useless_A = nutzlos_A | mkA "unnützlich" ; -- status=guess status=guess
lin cool_V2 = mkV2 (mkV "abkühlen") ; -- status=guess, src=wikt
lin cool_V = mkV "abkühlen" ; -- status=guess, src=wikt
lin tremble_V = zittern_V ; -- status=guess, src=wikt
lin statue_N = statue_N | mkN "Standbild" neuter ; -- status=guess status=guess
lin obey_V2 = mkV2 (gehorchen_V) ; -- status=guess, src=wikt
lin obey_V = gehorchen_V ; -- status=guess, src=wikt
lin drunk_A = betrunken_A | besoffen_A ; -- status=guess status=guess
lin tender_A = zart_A | mkA "zärtlich" | lieb_A | liebevoll_A ; -- status=guess status=guess status=guess status=guess
lin molecular_A = molekular_A ; -- status=guess
lin circulate_V2 = variants{} ; -- 
lin circulate_V = variants{} ; -- 
lin exploitation_N = variants{} ; -- 
lin explicitly_Adv = variants{} ; -- 
lin utterance_N = mkN "Sprechfähigkeit" feminine | mkN "Sprachvermögen" neuter ; -- status=guess status=guess
lin linear_A = linear_A ; -- status=guess
lin chat_V = mkReflV "unterhalten" | plaudern_V | schwatzen_V | mkV "klönen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin revision_N = wiederholung_N | mkN "Überarbeitung" feminine ; -- status=guess status=guess
lin distress_N = not_N | notlage_N | mkN "Seenot" feminine ; -- status=guess status=guess status=guess
lin spill_V2 = mkV2 (mkReflV "ergießen") ; -- status=guess, src=wikt
lin spill_V = mkReflV "ergießen" ; -- status=guess, src=wikt
lin steward_N = mkN "Verwalter" masculine ; -- status=guess
lin knight_N = springer_N ; -- status=guess
lin sum_V2 = mkV2 (summieren_V) ; -- status=guess, src=wikt
lin sum_V = summieren_V ; -- status=guess, src=wikt
lin semantic_A = semantisch_A ; -- status=guess
lin selective_A = mkA "wählerisch" ; -- status=guess
lin learner_N = lerner_N | mkN "Lernender" ; -- status=guess status=guess
lin dignity_N = mkN "Würde" feminine ; -- status=guess
lin senate_N = senat_N ; -- status=guess
lin grid_N = gitter_N ; -- status=guess
lin fiscal_A = variants{} ; -- 
lin activate_V2 = mkV2 (aktivieren_V) ; -- status=guess, src=wikt
lin rival_A = variants{} ; -- 
lin fortunate_A = variants{} ; -- 
lin jeans_N = jeans_N | jeanshose_N ; -- status=guess status=guess
lin select_A = variants{} ; -- 
lin fitting_N = variants{} ; -- 
lin commentator_N = mkN "Kommentator" masculine ; -- status=guess
lin weep_V2 = mkV2 (weinen_V) ; -- status=guess, src=wikt
lin weep_V = weinen_V ; -- status=guess, src=wikt
lin handicap_N = vorsprung_N ; -- status=guess
lin crush_V2 = variants{} ; -- 
lin crush_V = variants{} ; -- 
lin towel_N = handtuch_N ; -- status=guess
lin stay_N = variants{} ; -- 
lin skilled_A = mkA "erfahren" ; -- status=guess
lin repeatedly_Adv = mkAdv "wiederholt" ; -- status=guess
lin defensive_A = defensiv_A ; -- status=guess
lin calm_V2 = mkV2 (beruhigen_V) | mkV2 (junkV (mkV "ruhig") "stellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin calm_V = beruhigen_V | junkV (mkV "ruhig") "stellen" ; -- status=guess, src=wikt status=guess, src=wikt
lin temporarily_Adv = mkAdv "vorübergehend" ; -- status=guess
lin rain_V2 = mkV2 (junkV (mkV "Bindfäden") "regnen") | mkV2 (junkV (mkV "in") "Strömen regnen") | mkV2 (junkV (mkV "aus") "allen Kannen gießen") | mkV2 (junkV (mkV "aus") "allen Kannen schütten") | mkV2 (junkV (mkV "wie") "aus Eimern schütten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rain_V = junkV (mkV "Bindfäden") "regnen" | junkV (mkV "in") "Strömen regnen" | junkV (mkV "aus") "allen Kannen gießen" | junkV (mkV "aus") "allen Kannen schütten" | junkV (mkV "wie") "aus Eimern schütten" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pin_N = mkN "Anstecker" masculine ; -- status=guess
lin villa_N = villa_N ; -- status=guess
lin rod_N = mkN "Stäbchen" neuter ; -- status=guess
lin frontier_N = grenze_N ; -- status=guess
lin enforcement_N = variants{} ; -- 
lin protective_A = mkA "Schutz-" ; -- status=guess
lin philosophical_A = philosophisch_A ; -- status=guess
lin lordship_N = der_nbspdamenfluegel_N ; -- status=guess
lin disagree_VS = variants{} ; -- 
lin disagree_V2 = variants{} ; -- 
lin disagree_V = variants{} ; -- 
lin boyfriend_N = freund_N ; -- status=guess
lin activistMasc_N = aktivist_N | mkN "Aktivistin" feminine ; -- status=guess status=guess
lin viewer_N = zuschauer_N | zuschauerin_N ; -- status=guess status=guess
lin slim_A = schlank_A ; -- status=guess
lin textile_N = mkN "Textilie" feminine ; -- status=guess
lin mist_N = nebel_N | dunst_N ; -- status=guess status=guess
lin harmony_N = harmonie_N ; -- status=guess
lin deed_N = tat_N | akt_N ; -- status=guess status=guess
lin merge_V2 = mkV2 (mkV "verschmelzen") ; -- status=guess, src=wikt
lin merge_V = mkV "verschmelzen" ; -- status=guess, src=wikt
lin invention_N = mkN "Erfinden" neuter ; -- status=guess
lin commissioner_N = mkN "Kommissionsmitglied" neuter | kommissar_N ; -- status=guess status=guess
lin caravan_N = karawane_N ; -- status=guess
lin bolt_N = riegel_N ; -- status=guess
lin ending_N = endung_N ; -- status=guess
lin publishing_N = mkN "Verlagswesen" neuter ; -- status=guess
lin gut_N = bauch_N | ranzen_N ; -- status=guess status=guess
lin stamp_V2 = mkV2 (freimachen_8_V) ; -- status=guess, src=wikt
lin stamp_V = freimachen_8_V ; -- status=guess, src=wikt
lin map_V2 = mkV2 (abbilden_V) ; -- status=guess, src=wikt
lin loud_Adv = variants{} ; -- 
lin stroke_V2 = mkV2 (streicheln_V) | mkV2 (streichen_1_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin shock_V2 = mkV2 (schockieren_V) ; -- status=guess, src=wikt
lin rug_N = teppich_N | mkN "Brücke" feminine ; -- status=guess status=guess
lin picture_V2 = mkV2 (junkV (mkV "etwas") "vorstellen") ; -- status=guess, src=wikt
lin slip_N = ausrutscher_N ; -- status=guess
lin praise_N = lob_N ; -- status=guess
lin fine_N = mkN "Bußgeld" neuter | mkN "Geldbuße" feminine | geldstrafe_N ; -- status=guess status=guess status=guess
lin monument_N = mkN "Denkmal" neuter | mkN "Monument" neuter ; -- status=guess status=guess
lin material_A = materiell_A ; -- status=guess
lin garment_N = mkN "Kleidungsstück" neuter ; -- status=guess
lin toward_Prep = variants{} ; -- 
lin realm_N = reich_N | mkN "Königreich" neuter ; -- status=guess status=guess
lin melt_V2 = mkV2 (schmelzen_V) ; -- status=guess, src=wikt
lin melt_V = schmelzen_V ; -- status=guess, src=wikt
lin reproduction_N = mkN "Fortpflanzung" feminine | mkN "Reproduktion" feminine ; -- status=guess status=guess
lin reactor_N = reagenz_N ; -- status=guess
lin furious_A = variants{} ; -- 
lin distinguished_A = variants{} ; -- 
lin characterize_V2 = mkV2 (charakterisieren_V) ; -- status=guess, src=wikt
lin alike_Adv = variants{} ; -- 
lin pump_N = pumpe_N ; -- status=guess
lin probe_N = variants{} ; -- 
lin feedback_N = mkN "Rückmeldung" feminine ; -- status=guess
lin aspiration_N = aspiration_N ; -- status=guess
lin suspect_N = mkN "Verdächtiger" masculine | mkN "Verdächtige" feminine ; -- status=guess status=guess
lin solar_A = solar_A ; -- status=guess
lin fare_N = schwarzfahrer_N | mkN "blinder Passagier" masculine ; -- status=guess status=guess
lin carve_V2 = mkV2 (schneiden_6_V) ; -- status=guess, src=wikt
lin carve_V = schneiden_6_V ; -- status=guess, src=wikt
lin qualified_A = mkA "qualifiziert" ; -- status=guess
lin membrane_N = mkN "Membran" feminine | membrane_N ; -- status=guess status=guess
lin dependence_N = mkN "Abhängigkeit" feminine ; -- status=guess
lin convict_V2 = mkV2 (mkV "verurteilen") ; -- status=guess, src=wikt
lin bacteria_N = mkN "Bakterien" ; -- status=guess
lin trading_N = mkN "Handelspartner" masculine ; -- status=guess
lin ambassador_N = botschafter_N ; -- status=guess
lin wound_V2 = mkV2 (verletzen_V) ; -- status=guess, src=wikt
lin drug_V2 = variants{} ; -- 
lin conjunction_N = konjunktion_N ; -- status=guess
lin cabin_N = kabine_N | mkN "Kajüte" feminine ; -- status=guess status=guess
lin trail_V2 = mkV2 (mkV "Spur") ; -- status=guess, src=wikt
lin trail_V = mkV "Spur" ; -- status=guess, src=wikt
lin shaft_N = mkN "Schachtofen" masculine ; -- status=guess
lin treasure_N = mkN "Schatzkiste" feminine ; -- status=guess
lin inappropriate_A = unangebracht_A | unangemessen_A ; -- status=guess status=guess
lin half_Adv = mkAdv "halb" ; -- status=guess
lin attribute_N = attribut_N ; -- status=guess
lin liquid_A = mkA "flüssig" ; -- status=guess
lin embassy_N = botschaft_N ; -- status=guess
lin terribly_Adv = variants{} ; -- 
lin exemption_N = befreiung_N | mkN "Freistellung" feminine ; -- status=guess status=guess
lin array_N = feld_N | mkN "general)" | mkN "" | matrix_N | tabelle_N | mkN "specific)" | mkN "" | reihe_N | zeile_N | spalte_N | mkN "contextual" | mkN "specific)" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin tablet_N = mkN "Tablet-Computer" masculine | mkN "Tafel-Computer" masculine | mkN "Tafel-PC" masculine ; -- status=guess status=guess status=guess
lin sack_V2 = variants{} ; -- 
lin erosion_N = erosion_N ; -- status=guess
lin bull_N = bulle_N | stier_N | mkN "Bummal" ; -- status=guess status=guess status=guess
lin warehouse_N = mkN "Lager" neuter ; -- status=guess
lin unfortunate_A = mkA "unglücklich" | mkA "unglückselig" ; -- status=guess status=guess
lin promoter_N = variants{} ; -- 
lin compel_VV = mkVV (zwingen_V) ; -- status=guess, src=wikt
lin compel_V2V = mkV2V (zwingen_V) ; -- status=guess, src=wikt
lin compel_V2 = mkV2 (zwingen_V) ; -- status=guess, src=wikt
lin motivate_V2V = mkV2V (motivieren_V) ; -- status=guess, src=wikt
lin motivate_V2 = mkV2 (motivieren_V) ; -- status=guess, src=wikt
lin burning_A = mkA "brennend" ; -- status=guess
lin vitamin_N = vitamin_N ; -- status=guess
lin sail_N = segel_N ; -- status=guess
lin lemon_N = zitrone_N ; -- status=guess
lin foreigner_N = mkN "Ausländer" masculine | mkN "Ausländerin" feminine ; -- status=guess status=guess
lin powder_N = puder_N | pulver_N ; -- status=guess status=guess
lin persistent_A = mkA "ständig" | anhaltend_A ; -- status=guess status=guess
lin bat_N = mkN "Schläger" masculine | keule_N ; -- status=guess status=guess
lin ancestor_N = mkN "Vorfahr" masculine | ahne_N | mkN "Ahnin" feminine ; -- status=guess status=guess status=guess
lin predominantly_Adv = vorwiegend_Adv | mkAdv "überwiegend" ; -- status=guess status=guess
lin mathematical_A = mathematisch_A ; -- status=guess
lin compliance_N = einwilligung_N | mkN "Fügsamkeit" feminine ; -- status=guess status=guess
lin arch_N = mkN "Bogen" ; -- status=guess
lin woodland_N = wald_N | forst_N | mkN "Waldung" feminine | mkN "Waldland" neuter ; -- status=guess status=guess status=guess status=guess
lin serum_N = serum_N ; -- status=guess
lin overnight_Adv = mkAdv "über Nacht" ; -- status=guess
lin doubtful_A = mkA "zweifelnd" ; -- status=guess
lin doing_N = tun_N ; -- status=guess
lin coach_V2 = mkV2 (ausbilden_V) ; -- status=guess, src=wikt
lin coach_V = ausbilden_V ; -- status=guess, src=wikt
lin binding_A = verbindlich_A ; -- status=guess
lin surrounding_A = variants{} ; -- 
lin peer_N = mkN "Adeliger" masculine | mkN "Adelige" feminine | edelmann_N | edelfrau_N ; -- status=guess status=guess status=guess status=guess
lin ozone_N = mkN "Ozon" neuter ; -- status=guess
lin mid_A = variants{} ; -- 
lin invisible_A = unsichtbar_A ; -- status=guess
lin depart_V = abweichen_V ; -- status=guess, src=wikt
lin brigade_N = brigade_N ; -- status=guess
lin manipulate_V2 = mkV2 (manipulieren_V) ; -- status=guess, src=wikt
lin consume_V2 = mkV2 (verbrauchen_V) ; -- status=guess, src=wikt
lin consume_V = verbrauchen_V ; -- status=guess, src=wikt
lin temptation_N = versuchung_N | mkN "Verführung" feminine ; -- status=guess status=guess
lin intact_A = variants{} ; -- 
lin glove_N = L.glove_N ;
lin aggression_N = aggression_N | angriff_N ; -- status=guess status=guess
lin emergence_N = emergenz_N ; -- status=guess
lin stag_V = variants{} ; -- 
lin coffin_N = sarg_N ; -- status=guess
lin beautifully_Adv = mkAdv "schön" ; -- status=guess
lin clutch_V2 = mkV2 (schnappen_V) | mkV2 (packen_3_V) | mkV2 (ergreifen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin clutch_V = schnappen_V | packen_3_V | ergreifen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wit_N = witzbold_N ; -- status=guess
lin underline_V2 = mkV2 (unterstreichen_V) ; -- status=guess, src=wikt
lin trainee_N = praktikant_N | mkN "Praktikantin" feminine | mkN "Trainee {m}" feminine ; -- status=guess status=guess status=guess
lin scrutiny_N = mkN "genaue Untersuchung" | mkN "prüfender od. forschender Blick" ; -- status=guess status=guess
lin neatly_Adv = variants{} ; -- 
lin follower_N = variants{} ; -- 
lin sterling_A = variants{} ; -- 
lin tariff_N = variants{} ; -- 
lin bee_N = biene_N | imme_N | mkN "Styrian: Beivogl" ; -- status=guess status=guess status=guess
lin relaxation_N = variants{} ; -- 
lin negligence_N = mkN "Fahrlässigkeit" feminine ; -- status=guess
lin sunlight_N = mkN "Sonnenlicht" neuter ; -- status=guess
lin penetrate_V2 = mkV2 (penetrieren_V) ; -- status=guess, src=wikt
lin penetrate_V = penetrieren_V ; -- status=guess, src=wikt
lin knot_N = beule_N ; -- status=guess
lin temper_N = mkN "Anlassen" neuter | mkN "Ausheizen" neuter ; -- status=guess status=guess
lin skull_N = totenkopf_N ; -- status=guess
lin openly_Adv = mkAdv "offen" | mkAdv "öffentlich" ; -- status=guess status=guess
lin grind_V2 = mkV2 (mahlen_V) | mkV2 (mkV "zermahlen") ; -- status=guess, src=wikt status=guess, src=wikt
lin grind_V = mahlen_V | mkV "zermahlen" ; -- status=guess, src=wikt status=guess, src=wikt
lin whale_N = wal_N ; -- status=guess
lin throne_N = thron_N ; -- status=guess
lin supervise_V2 = mkV2 (mkV "beaufsichtigen") ; -- status=guess, src=wikt
lin supervise_V = mkV "beaufsichtigen" ; -- status=guess, src=wikt
lin sickness_N = mkN "Übelkeit" feminine ; -- status=guess
lin package_V2 = mkV2 (packen_3_V) | mkV2 (einpacken_3_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin intake_N = variants{} ; -- 
lin within_Adv = variants{} ; -- 
lin inland_A = variants{} ; -- 
lin beast_N = tier_N | bestie_N ; -- status=guess status=guess
lin rear_N = nachhut_N ; -- status=guess
lin morality_N = moral_N ; -- status=guess
lin competent_A = kompetent_A ; -- status=guess
lin sink_N = waschbecken_N ; -- status=guess
lin uniform_A = einheitlich_A ; -- status=guess
lin reminder_N = mkN "Gedächtnisstütze" feminine ; -- status=guess
lin permanently_Adv = variants{} ; -- 
lin optimistic_A = optimistisch_A ; -- status=guess
lin bargain_N = variants{} ; -- 
lin seemingly_Adv = variants{} ; -- 
lin respective_A = jeweilig_A ; -- status=guess
lin horizontal_A = horizontal_A | waagrecht_A | waagerecht_A ; -- status=guess status=guess status=guess
lin decisive_A = entscheidend_A | ausschlaggebend_A ; -- status=guess status=guess
lin bless_V2 = mkV2 (mkV "segnen") | mkV2 (benedeien_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin bile_N = galle_N ; -- status=guess
lin spatial_A = mkA "räumlich" | mkA "Raum-" ; -- status=guess status=guess
lin bullet_N = kugel_N ; -- status=guess
lin respectable_A = angesehen_A | mkA "geachtet" ; -- status=guess status=guess
lin overseas_Adv = mkAdv "im Ausland" ; -- status=guess
lin convincing_A = variants{} ; -- 
lin unacceptable_A = mkA "inakzeptabel" ; -- status=guess
lin confrontation_N = konfrontation_N ; -- status=guess
lin swiftly_Adv = variants{} ; -- 
lin paid_A = variants{} ; -- 
lin joke_V = scherzen_V | junkV (mkV "Witze") "machen" | junkV (mkV "Spaß") "machen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin instant_A = augenblicklich_A ; -- status=guess
lin illusion_N = illusion_N | wahnvorstellung_N | mkN "Sinnestäuschung" feminine ; -- status=guess status=guess status=guess
lin cheer_V2 = mkV2 (jubeln_V) | mkV2 (mkV "aufmuntern") | mkV2 (mkV "aufheitern") | mkV2 (applaudieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cheer_V = jubeln_V | mkV "aufmuntern" | mkV "aufheitern" | applaudieren_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin congregation_N = versammlung_N ; -- status=guess
lin worldwide_Adv = mkAdv "weltweit" ; -- status=guess
lin winning_A = variants{} ; -- 
lin wake_N = mkN "Kielwasser" neuter ; -- status=guess
lin toss_V2 = variants{} ; -- 
lin toss_V = variants{} ; -- 
lin medium_A = mkA "mittelgroß" ; -- status=guess
lin jewellery_N = schmuck_N | mkN "Juwelen {n} {p}" ; -- status=guess status=guess
lin fond_A = mkA "gern haben" | mkA "hängen an" | mkA "mögen" | mkA "lieben" ; -- status=guess status=guess status=guess status=guess
lin alarm_V2 = mkV2 (junkV (mkV "Alarm") "schlagen") | mkV2 (alarmieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin guerrilla_N = mkN "Partisan" masculine ; -- status=guess
lin dive_V = junkV (mkV "eine") "Schwalbe vortäuschen" ; -- status=guess, src=wikt
lin desire_V2 = mkV2 (begehren_0_V) ; -- status=guess, src=wikt
lin cooperation_N = mkN "Zusammenarbeit" feminine | kooperation_N | mkN "Mitarbeit" feminine ; -- status=guess status=guess status=guess
lin thread_N = thema_rhema_progression__N | mkN "roter Faden" masculine ; -- status=guess status=guess
lin prescribe_V2 = mkV2 (verschreiben_V) | mkV2 (verordnen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin prescribe_V = verschreiben_V | verordnen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin calcium_N = kalzium_N | calcium_N ; -- status=guess status=guess
lin redundant_A = redundant_A ; -- status=guess
lin marker_N = mkN "Markierungsschnittstelle" feminine ; -- status=guess
lin chemistMasc_N = chemiker_N | chemikerin_N ; -- status=guess status=guess
lin mammal_N = mkN "Säugetier" neuter ; -- status=guess
lin legacy_N = mkN "Wirken" neuter | mkN "Erbe" neuter ; -- status=guess status=guess
lin debtor_N = schuldner__N ; -- status=guess
lin testament_N = testament_N ; -- status=guess
lin tragic_A = tragisch_A ; -- status=guess
lin silver_A = variants{} ; -- 
lin grin_N = mkN "Grinsen" neuter ; -- status=guess
lin spectacle_N = spektakel_N | schauspiel_N ; -- status=guess status=guess
lin inheritance_N = mkN "Erbschaftsteuer" feminine | mkN "Erbschaftssteuer" feminine ; -- status=guess status=guess
lin heal_V2 = mkV2 (mkV "verheilen") | mkV2 (heilen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin heal_V = mkV "verheilen" | heilen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin sovereignty_N = mkN "Souveränität" feminine ; -- status=guess
lin enzyme_N = enzym_N ; -- status=guess
lin host_V2 = variants{} ; -- 
lin neighbouring_A = benachbart_A ; -- status=guess
lin corn_N = mkN "Grauammer" feminine ; -- status=guess
lin layout_N = einteilung_N ; -- status=guess
lin dictate_VS = mkVS (mkV "diktieren") | mkVS (bestimmen_V) | mkVS (vorschreiben_3_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dictate_V2 = mkV2 (mkV "diktieren") | mkV2 (bestimmen_V) | mkV2 (vorschreiben_3_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dictate_V = mkV "diktieren" | bestimmen_V | vorschreiben_3_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rip_V2 = mkV2 (rippen_V) ; -- status=guess, src=wikt
lin rip_V = rippen_V ; -- status=guess, src=wikt
lin regain_V2 = mkV2 (mkV "wiedergewinnen") ; -- status=guess, src=wikt
lin probable_A = glaubhaft_A | wahrscheinlich_A ; -- status=guess status=guess
lin inclusion_N = mkN "Einschluss" masculine ; -- status=guess
lin booklet_N = heft_N | mkN "Broschüre" feminine ; -- status=guess status=guess
lin bar_V2 = mkV2 (mkV "versperren") ; -- status=guess, src=wikt
lin privately_Adv = variants{} ; -- 
lin laser_N = laser_N ; -- status=guess
lin fame_N = mkN "Ruhm" masculine ; -- status=guess
lin bronze_N = bronze_N ; -- status=guess
lin mobile_A = beweglich_A | mobil_A ; -- status=guess status=guess
lin metaphor_N = metapher_N ; -- status=guess
lin complication_N = komplikation_N ; -- status=guess
lin narrow_V2 = mkV2 (mkV "eng") | mkV2 (mkV "schlank") | mkV2 (mkV "schmal") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin narrow_V = mkV "eng" | mkV "schlank" | mkV "schmal" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin old_fashioned_A = variants{} ; -- 
lin chop_V2 = mkV2 (hacken_3_V) | mkV2 (mkV "zerhacken") | mkV2 (abhacken_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin chop_V = hacken_3_V | mkV "zerhacken" | abhacken_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin synthesis_N = synthese_N ; -- status=guess
lin diameter_N = durchmesser_N ; -- status=guess
lin bomb_V2 = mkV2 (mkV "bombardieren") ; -- status=guess, src=wikt
lin bomb_V = mkV "bombardieren" ; -- status=guess, src=wikt
lin silently_Adv = variants{} ; -- 
lin shed_N = schuppen_N | schuppen_N ; -- status=guess status=guess
lin fusion_N = mkN "Schmelzen" neuter ; -- status=guess
lin trigger_V2 = mkV2 (mkV "auslösen") ; -- status=guess, src=wikt
lin printing_N = druckerei_N | typographie_N ; -- status=guess status=guess
lin onion_N = zwiebel_N ; -- status=guess
lin dislike_V2 = mkV2 (ablehnen_V) ; -- status=guess, src=wikt
lin embody_V2 = mkV2 (mkV "verkörpern") ; -- status=guess, src=wikt
lin curl_V = variants{} ; -- 
lin sunshine_N = mkN "Sonnenschein" masculine ; -- status=guess
lin sponsorship_N = variants{} ; -- 
lin rage_N = mkN "Wut" feminine | mkN "Zorn" masculine | raserei_N | mkN "Rage" feminine ; -- status=guess status=guess status=guess status=guess
lin loop_N = schleife_N ; -- status=guess
lin halt_N = halt_N | mkN "Blockierung" feminine | pause_N ; -- status=guess status=guess status=guess
lin cop_V2 = variants{} ; -- 
lin bang_V2 = mkV2 (bumsen_V) ; -- status=guess, src=wikt
lin bang_V = bumsen_V ; -- status=guess, src=wikt
lin toxic_A = giftig_A | toxisch_A ; -- status=guess status=guess
lin thinking_A = variants{} ; -- 
lin orientation_N = mkN "Orientierungsvermögen" neuter ; -- status=guess
lin likelihood_N = wahrscheinlichkeit_N ; -- status=guess
lin wee_A = winzig_A | klein_A ; -- status=guess status=guess
lin up_to_date_A = variants{} ; -- 
lin polite_A = mkA "höflich" ; -- status=guess
lin apology_N = entschuldigung_N ; -- status=guess
lin exile_N = mkN "Exilant" masculine ; -- status=guess
lin brow_N = stirn_N ; -- status=guess
lin miserable_A = mkA "erbärmlich" | mkA "jämmerlich" | miserabel_A ; -- status=guess status=guess status=guess
lin outbreak_N = ausbruch_N ; -- status=guess
lin comparatively_Adv = variants{} ; -- 
lin pump_V2 = mkV2 (mkV "aufpumpen") ; -- status=guess, src=wikt
lin pump_V = mkV "aufpumpen" ; -- status=guess, src=wikt
lin fuck_V2 = mkV2 (verarschen_V) ; -- status=guess, src=wikt
lin fuck_V = verarschen_V ; -- status=guess, src=wikt
lin forecast_VS = mkVS (mkV "vorhersagen") | mkVS (prognostizieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin forecast_V2 = mkV2 (mkV "vorhersagen") | mkV2 (prognostizieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin forecast_V = mkV "vorhersagen" | prognostizieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin timing_N = mkN "Steuerkette" feminine | mkN "Zahnriemen" masculine | mkN "Synchronriemen" masculine | mkN "Steuerriemen" masculine ; -- status=guess status=guess status=guess status=guess
lin headmaster_N = variants{} ; -- 
lin terrify_V2 = variants{} ; -- 
lin sigh_N = mkN "Seufzen" neuter | mkN "Seufzer" masculine ; -- status=guess status=guess
lin premier_A = variants{} ; -- 
lin joint_N = mkN "gemeinsame Rechnung" feminine ; -- status=guess
lin incredible_A = unglaublich_A ; -- status=guess
lin gravity_N = mkN "Gravitationsmanöver" neuter | mkN "Schwerkraftumlenkung" feminine | mkN "Swing-by" masculine | mkN "Vorbeischwungmanöver" neuter ; -- status=guess status=guess status=guess status=guess
lin regulatory_A = mkA "regulativ" | regulatorisch_A ; -- status=guess status=guess
lin cylinder_N = zylinder_N ; -- status=guess
lin curiosity_N = mkN "Neugier" feminine | mkN "Neugierde" feminine ; -- status=guess status=guess
lin resident_A = variants{} ; -- 
lin narrative_N = darstellung_N ; -- status=guess
lin cognitive_A = kognitiv_A ; -- status=guess
lin lengthy_A = variants{} ; -- 
lin gothic_A = variants{} ; -- 
lin dip_V2 = mkV2 (eintauchen_6_V) | mkV2 (eintunken_V) | mkV2 (stippen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dip_V = eintauchen_6_V | eintunken_V | stippen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin adverse_A = mkA "gegnerisch" ; -- status=guess
lin accountability_N = mkN "Verantwortlichkeit" feminine ; -- status=guess
lin hydrogen_N = wasserstoffatom_N ; -- status=guess
lin gravel_N = kies_N | schotter_N ; -- status=guess status=guess
lin willingness_N = mkN "Willigkeit" feminine | bereitschaft_N ; -- status=guess status=guess
lin inhibit_V2 = mkV2 (hemmen_V) | mkV2 (hindern_V) | mkV2 (sperren_3_V) | mkV2 (verhindern_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin attain_V2 = mkV2 (erreichen_V) | mkV2 (erlangen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin attain_V = erreichen_V | erlangen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin specialize_V2 = variants{} ; -- 
lin specialize_V = variants{} ; -- 
lin steer_V2 = mkV2 (steuern_1_V) ; -- status=guess, src=wikt
lin steer_V = steuern_1_V ; -- status=guess, src=wikt
lin selected_A = variants{} ; -- 
lin like_N = mkN "seinesgleichen" ; -- status=guess
lin confer_V = variants{} ; -- 
lin usage_N = brauch_N ; -- status=guess
lin portray_V2 = mkV2 (mkV "porträtieren") ; -- status=guess, src=wikt
lin planner_N = variants{} ; -- 
lin manual_A = manuell_A ; -- status=guess
lin boast_VS = mkVS (angeben_2_V) | mkVS (prahlen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin boast_V2 = mkV2 (angeben_2_V) | mkV2 (prahlen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin boast_V = angeben_2_V | prahlen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin unconscious_A = bewusstlos_A ; -- status=guess
lin jail_N = variants{} ; -- 
lin fertility_N = mkN "Fruchtbarkeit" feminine ; -- status=guess
lin documentation_N = dokumentation_N ; -- status=guess
lin wolf_N = wolf_N ; -- status=guess
lin patent_N = patent_N ; -- status=guess
lin exit_N = abtritt_N | austritt_N | mkN "Ausstieg" masculine | abwanderung_N ; -- status=guess status=guess status=guess status=guess
lin corps_N = korps_N ; -- status=guess
lin proclaim_VS = variants{} ; -- 
lin proclaim_V2 = variants{} ; -- 
lin multiply_V2 = mkV2 (multiplizieren_V) ; -- status=guess, src=wikt
lin multiply_V = multiplizieren_V ; -- status=guess, src=wikt
lin brochure_N = mkN "Broschüre" feminine ; -- status=guess
lin screen_V2 = variants{} ; -- 
lin screen_V = variants{} ; -- 
lin orthodox_A = orthodox_A ; -- status=guess
lin locomotive_N = lokomotive_N ; -- status=guess
lin considering_Prep = variants{} ; -- 
lin unaware_A = mkA "unwissend" ; -- status=guess
lin syndrome_N = syndrom_N ; -- status=guess
lin reform_V2 = mkV2 (reformieren_V) ; -- status=guess, src=wikt
lin reform_V = reformieren_V ; -- status=guess, src=wikt
lin confirmation_N = mkN "Bestätigung" feminine ; -- status=guess
lin printed_A = variants{} ; -- 
lin curve_V2 = variants{} ; -- 
lin curve_V = variants{} ; -- 
lin costly_A = teuer_A | mkA "kostspielig" ; -- status=guess status=guess
lin underground_A = unterirdisch_A | mkA "Untegrund-" ; -- status=guess status=guess
lin territorial_A = variants{} ; -- 
lin designate_VS = mkVS (designieren_V) | mkVS (nominieren_V) | mkVS (nennen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin designate_V2V = mkV2V (designieren_V) | mkV2V (nominieren_V) | mkV2V (nennen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin designate_V2 = mkV2 (designieren_V) | mkV2 (nominieren_V) | mkV2 (nennen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin designate_V = designieren_V | nominieren_V | nennen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin comfort_V2 = mkV2 (mkV "trösten") | mkV2 (ermutigen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin plot_V2 = mkV2 (mkV "plotten") ; -- status=guess, src=wikt
lin plot_V = mkV "plotten" ; -- status=guess, src=wikt
lin misleading_A = mkA "irreführend" ; -- status=guess
lin weave_V2 = mkV2 (weben_V) ; -- status=guess, src=wikt
lin weave_V = weben_V ; -- status=guess, src=wikt
lin scratch_V2 = L.scratch_V2 ;
lin scratch_V = mkV "zerkratzen" | mkV "verkratzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin echo_N = mkN "Tastaturecho" neuter | mkN "Bildschirmecho" neuter ; -- status=guess status=guess
lin ideally_Adv = idealerweise_Adv ; -- status=guess
lin endure_V2 = mkV2 (ertragen_V) | mkV2 (aushalten_3_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin endure_V = ertragen_V | aushalten_3_V ; -- status=guess, src=wikt status=guess, src=wikt
lin verbal_A = verbal_A ; -- status=guess
lin stride_V = mkV "schreiten" ; -- status=guess, src=wikt
lin nursing_N = mkN "Still-BH" masculine | mkN "Schwangerschafts-BH" | mkN "Umstands-BH" masculine ; -- status=guess status=guess status=guess
lin exert_V2 = mkV2 (mkV "ausüben") ; -- status=guess, src=wikt
lin compatible_A = kompatibel_A | mkA "verträglich" ; -- status=guess status=guess
lin causal_A = variants{} ; -- 
lin mosaic_N = mkN "Mosaik" neuter ; -- status=guess
lin manor_N = mkN "Lehen" neuter ; -- status=guess
lin implicit_A = implizit_A ; -- status=guess
lin following_Prep = variants{} ; -- 
lin fashionable_A = mkA "modisch" ; -- status=guess
lin valve_N = ventil_N ; -- status=guess
lin proceed_N = variants{} ; -- 
lin sofa_N = sofa_N ; -- status=guess
lin snatch_V2 = mkV2 (klauen_V) | mkV2 (stehlen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin snatch_V = klauen_V | stehlen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin jazz_N = mkN "Jazz" masculine ; -- status=guess
lin patron_N = mkN "Schirmherr" masculine ; -- status=guess
lin provider_N = mkN "Versorger" masculine ; -- status=guess
lin interim_A = mkA "zwischenzeitlich" ; -- status=guess
lin intent_N = absicht_N ; -- status=guess
lin chosen_A = variants{} ; -- 
lin applied_A = mkA "angewandt" ; -- status=guess
lin shiver_V = zittern_V ; -- status=guess, src=wikt
lin pie_N = torte_N ; -- status=guess
lin fury_N = furie_N ; -- status=guess
lin abolition_N = abschaffung_N ; -- status=guess
lin soccer_N = mkN "Fußball" masculine ; -- status=guess
lin corpse_N = leiche_N | leichnam_N ; -- status=guess status=guess
lin accusation_N = anklage_N | beschuldigung_N ; -- status=guess status=guess
lin kind_A = freundlich_A | mkA "gütig" | lieb_A | mkA "liebenswürdig" | nett_A | aufmerksam_A ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin dead_Adv = mkAdv "genau" ; -- status=guess
lin nursing_A = variants{} ; -- 
lin contempt_N = mkN "Schande" feminine | blamage_N ; -- status=guess status=guess
lin prevail_V = vorherrschen_6_V ; -- status=guess, src=wikt
lin murderer_N = mkN "Mörder" masculine | mkN "Mörderin" feminine ; -- status=guess status=guess
lin liberal_N = variants{} ; -- 
lin gathering_N = variants{} ; -- 
lin adequately_Adv = variants{} ; -- 
lin subjective_A = variants{} ; -- 
lin disagreement_N = streit_N ; -- status=guess
lin cleaner_N = mkN "Reiniger" masculine ; -- status=guess
lin boil_V2 = mkV2 (kochen_6_V) ; -- status=guess, src=wikt
lin boil_V = kochen_6_V ; -- status=guess, src=wikt
lin static_A = variants{} ; -- 
lin scent_N = geruch_N | duft_N ; -- status=guess status=guess
lin civilian_N = zivilist_N | mkN "Zivilistin" feminine ; -- status=guess status=guess
lin monk_N = mkN "Mönch" masculine ; -- status=guess
lin abruptly_Adv = mkAdv "abrupt" | mkAdv "plötzlich" | mkAdv "unerwartet" ; -- status=guess status=guess status=guess
lin keyboard_N = tastatur_N | klaviatur_N | manual_N ; -- status=guess status=guess status=guess
lin hammer_N = hammer_N ; -- status=guess
lin despair_N = verzweiflung_N ; -- status=guess
lin controller_N = mkN "Controller" masculine | steuerung_N ; -- status=guess status=guess
lin yell_V2 = mkV2 (schreien_V) ; -- status=guess, src=wikt
lin yell_V = schreien_V ; -- status=guess, src=wikt
lin entail_V2 = mkV2 (bedingen_1_V) | mkV2 (junkV (mkV "mit") "sich bringen") | mkV2 (junkV (mkV "nach") "sich ziehen") | mkV2 (verursachen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cheerful_A = freundlich_A ; -- status=guess
lin reconstruction_N = rekonstruktion_N | mkN "Wiederaufbau" masculine ; -- status=guess status=guess
lin patience_N = mkN "Geduld" feminine ; -- status=guess
lin legally_Adv = mkAdv "legal" ; -- status=guess
lin habitat_N = habitat_N ; -- status=guess
lin queue_N = warteschlange_N | schlange_N | reihe_N ; -- status=guess status=guess status=guess
lin spectatorMasc_N = zuschauer_N | zuschauerin_N ; -- status=guess status=guess
lin given_A = variants{} ; -- 
lin purple_A = violett_A | lila_A | mkA "purpurrot" ; -- status=guess status=guess status=guess
lin outlook_N = einstellung_N | mkN "Ansichten" feminine ; -- status=guess status=guess
lin genius_N = mkN "Genialität" feminine ; -- status=guess
lin dual_A = dual_A ; -- status=guess
lin canvas_N = leinwand_N ; -- status=guess
lin grave_A = variants{} ; -- 
lin pepper_N = chili_N | mkN "Paprika" ; -- status=guess status=guess
lin conform_V2 = variants{} ; -- 
lin conform_V = variants{} ; -- 
lin cautious_A = vorsichtig_A | zaghaft_A | behutsam_A ; -- status=guess status=guess status=guess
lin dot_N = punkt_N ; -- status=guess
lin conspiracy_N = mkN "Verschwörung" feminine | mkN "Konspiration" feminine ; -- status=guess status=guess
lin butterfly_N = schmetterling_N | falter_N | tagfalter_N | mkN "Summervogl" ; -- status=guess status=guess status=guess status=guess
lin sponsor_N = mkN "Sponsor" masculine ; -- status=guess
lin sincerely_Adv = variants{} ; -- 
lin rating_N = variants{} ; -- 
lin weird_A = eigenartig_A | mkA "merkwürdig" | sonderbar_A | seltsam_A | bizarr_A ; -- status=guess status=guess status=guess status=guess status=guess
lin teenage_A = variants{} ; -- 
lin salmon_N = mkN "lachsfarben" | mkN "lachsfarbig" | mkN "lachsrot" | mkN "lachsrosa" ; -- status=guess status=guess status=guess status=guess
lin recorder_N = mkN "Blockflöte" feminine ; -- status=guess
lin postpone_V2 = mkV2 (verschieben_V) | mkV2 (mkV "aufschieben") ; -- status=guess, src=wikt status=guess, src=wikt
lin maid_N = mkN "Dienstmädchen" neuter ; -- status=guess
lin furnish_V2 = mkV2 (mkV "möblieren") | mkV2 (einrichten_4_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin ethical_A = ethisch_A ; -- status=guess
lin bicycle_N = fahrrad_N | velo_N | mkN "colloquial: Drahtesel" masculine ; -- status=guess status=guess status=guess
lin sick_N = mkN "Arbeitsunfähigkeit" feminine | mkN "Krankenstand" masculine ; -- status=guess status=guess
lin sack_N = sack_N | mkN "Sackvoll" masculine ; -- status=guess status=guess
lin renaissance_N = variants{} ; -- 
lin luxury_N = mkN "Luxus" masculine ; -- status=guess
lin gasp_V2 = mkV2 (japsen_V) ; -- status=guess, src=wikt
lin gasp_V = japsen_V ; -- status=guess, src=wikt
lin wardrobe_N = garderobe_N | kleiderschrank_N ; -- status=guess status=guess
lin native_N = ureinwohner_N | mkN "Ureinwohnerin" feminine | mkN "Eingeborener" masculine | mkN "Eingeborene" feminine ; -- status=guess status=guess status=guess status=guess
lin fringe_N = mkN "Sachbezug" masculine ; -- status=guess
lin adaptation_N = anpassung_N ; -- status=guess
lin quotation_N = angebot_N | mkN "Preisangebot" neuter ; -- status=guess status=guess
lin hunger_N = mkN "Hunger" masculine ; -- status=guess
lin enclose_V2 = variants{} ; -- 
lin disastrous_A = mkA "verhängnisvoll" ; -- status=guess
lin choir_N = mkN "Engelschor" masculine ; -- status=guess
lin overwhelming_A = mkA "überwältigend" ; -- status=guess
lin glimpse_N = variants{} ; -- 
lin divorce_V2 = mkV2 (mkReflV "scheiden lassen") ; -- status=guess, src=wikt
lin circular_A = rund_A ; -- status=guess
lin locality_N = variants{} ; -- 
lin ferry_N = mkN "Fähre" feminine ; -- status=guess
lin balcony_N = mkN "Balkon" masculine ; -- status=guess
lin sailor_N = matrose_N | seemann_N ; -- status=guess status=guess
lin precision_N = mkN "Präzision" feminine | mkN "Genauigkeit" feminine ; -- status=guess status=guess
lin desert_V2 = mkV2 (verlassen_V) | mkV2 (junkV (mkV "im") "Stich lassen") ; -- status=guess, src=wikt status=guess, src=wikt
lin desert_V = verlassen_V | junkV (mkV "im") "Stich lassen" ; -- status=guess, src=wikt status=guess, src=wikt
lin dancing_N = variants{} ; -- 
lin alert_V2 = mkV2 (mkV "verständigen") ; -- status=guess, src=wikt
lin surrender_V2 = mkV2 (kapitulieren_V) | mkV2 (mkReflV "ergeben") ; -- status=guess, src=wikt status=guess, src=wikt
lin surrender_V = kapitulieren_V | mkReflV "ergeben" ; -- status=guess, src=wikt status=guess, src=wikt
lin archive_N = archiv_N ; -- status=guess
lin jump_N = sprung_N ; -- status=guess
lin philosopher_N = philosoph_N | philosophin_N ; -- status=guess status=guess
lin revival_N = wiederbelebung_N ; -- status=guess
lin presume_VS = mkVS (annehmen_4_V) | mkVS (mkV "mutmaßen") | mkVS (vermuten_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin presume_V2 = mkV2 (annehmen_4_V) | mkV2 (mkV "mutmaßen") | mkV2 (vermuten_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin presume_V = annehmen_4_V | mkV "mutmaßen" | vermuten_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin node_N = knoten_N | ecke_N ; -- status=guess status=guess
lin fantastic_A = fantastisch_A ; -- status=guess
lin herb_N = mkN "Heilkraut" neuter ; -- status=guess
lin assertion_N = versicherung_N | mkN "Zusicherung" ; -- status=guess status=guess
lin thorough_A = mkA "gründlich" ; -- status=guess
lin quit_V2 = mkV2 (mkV "aufhören") | mkV2 (aufgeben_4_V) | mkV2 (junkV (mkV "sein") "lassen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin quit_V = mkV "aufhören" | aufgeben_4_V | junkV (mkV "sein") "lassen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grim_A = mkA "grimm" ; -- status=guess
lin fair_N = jahrmarkt_N | mkN "Kirchtag" masculine | mkN "Kirchweih" feminine | kirmes_N ; -- status=guess status=guess status=guess status=guess
lin broadcast_V2 = mkV2 (senden_1_V) | mkV2 (verbreiten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin broadcast_V = senden_1_V | verbreiten_V ; -- status=guess, src=wikt status=guess, src=wikt
lin annoy_V2 = mkV2 (mkV "stören") | mkV2 (mkV "ärgern") | mkV2 (mkV "belästigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin divert_V = ablenken_V ; -- status=guess, src=wikt
lin accelerate_V2 = mkV2 (junkV (mkV "schneller") "werden") | mkV2 (beschleunigen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin accelerate_V = junkV (mkV "schneller") "werden" | beschleunigen_V ; -- status=guess, src=wikt status=guess, src=wikt
lin polymer_N = polymer_N ; -- status=guess
lin sweat_N = mkN "Schweiß" masculine | mkN "Schwitze" feminine ; -- status=guess status=guess
lin survivor_N = mkN "Überlebender" masculine | mkN "Überlebende" feminine ; -- status=guess status=guess
lin subscription_N = abonnement_N ; -- status=guess
lin repayment_N = variants{} ; -- 
lin anonymous_A = anonym_A ; -- status=guess
lin summarize_V2 = mkV2 (zusammenfassen_9_V) ; -- status=guess, src=wikt
lin punch_N = mkN "Punsch" masculine | bowle_N ; -- status=guess status=guess
lin lodge_V2 = mkV2 (mkV "feststecken") | mkV2 (beherbergen_V) | mkV2 (mkV "unterbringen") | mkV2 (hinterlegen_V) | mkV2 (deponieren_V) | mkV2 (mkV "einlegen") | mkV2 (einreichen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lodge_V = mkV "feststecken" | beherbergen_V | mkV "unterbringen" | hinterlegen_V | deponieren_V | mkV "einlegen" | einreichen_9_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin landowner_N = mkN "Grundbesitzer" masculine | mkN "Grundbesitzerin" feminine ; -- status=guess status=guess
lin ignorance_N = mkN "Ignoranz" feminine | mkN "Unwissenheit" feminine ; -- status=guess status=guess
lin discourage_V2 = mkV2 (entmutigen_V) ; -- status=guess, src=wikt
lin bride_N = braut_N ; -- status=guess
lin likewise_Adv = ebenfalls_Adv | gleichfalls_Adv | ebenso_Adv ; -- status=guess status=guess status=guess
lin depressed_A = variants{} ; -- 
lin abbey_N = kloster_N ; -- status=guess
lin quarry_N = mkN "Beute" feminine ; -- status=guess
lin archbishop_N = erzbischof_N ; -- status=guess
lin sock_N = L.sock_N ;
lin large_scale_A = variants{} ; -- 
lin glare_V2 = variants{} ; -- 
lin glare_V = variants{} ; -- 
lin descent_N = herkunft_N ; -- status=guess
lin stumble_V = stolpern_V ; -- status=guess, src=wikt
lin mistress_N = mkN "Domina" feminine ; -- status=guess
lin empty_V2 = mkV2 (leeren_V) | mkV2 (entleeren_V) | mkV2 (mkV "ausleeren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin empty_V = leeren_V | entleeren_V | mkV "ausleeren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prosperity_N = mkN "Prosperität" feminine | mkN "Wohlstand" masculine ; -- status=guess status=guess
lin harm_V2 = mkV2 (schaden_V) ; -- status=guess, src=wikt
lin formulation_N = variants{} ; -- 
lin atomic_A = mkA "Atom" | atomar_A ; -- status=guess status=guess
lin agreed_A = variants{} ; -- 
lin wicked_A = mkA "böse" ; -- status=guess
lin threshold_N = schwelle_N ; -- status=guess
lin lobby_N = lobby_N | foyer_N | vorraum_N | mkN "Vorhalle" feminine ; -- status=guess status=guess status=guess status=guess
lin repay_V2 = mkV2 (mkV "zurückzahlen") ; -- status=guess, src=wikt
lin repay_V = mkV "zurückzahlen" ; -- status=guess, src=wikt
lin varying_A = variants{} ; -- 
lin track_V2 = variants{} ; -- 
lin track_V = variants{} ; -- 
lin crawl_V = krabbeln_V ; -- status=guess, src=wikt
lin tolerate_V2 = mkV2 (tolerieren_V) | mkV2 (dulden_V) | mkV2 (mkV "vertragen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin salvation_N = mkN "Erlösung" feminine | rettung_N ; -- status=guess status=guess
lin pudding_N = mkN "Pudding" masculine ; -- status=guess
lin counter_VS = mkVS (mkV "entgegnen") | mkVS (widersprechen_V) | mkVS (mkV "entgegensetzen") | mkVS (reagieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin counter_V = mkV "entgegnen" | widersprechen_V | mkV "entgegensetzen" | reagieren_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin propaganda_N = mkN "Propaganda" feminine ; -- status=guess
lin cage_N = mkN "Käfig" masculine ; -- status=guess
lin broker_N = mkN "Börsenmakler" masculine | mkN "Börsenmaklerin" feminine ; -- status=guess status=guess
lin ashamed_A = mkA "beschämt" ; -- status=guess
lin scan_V2 = mkV2 (mkV "abtasten") | mkV2 (mkV "einscannen") ; -- status=guess, src=wikt status=guess, src=wikt
lin scan_V = mkV "abtasten" | mkV "einscannen" ; -- status=guess, src=wikt status=guess, src=wikt
lin document_V2 = mkV2 (dokumentieren_V) ; -- status=guess, src=wikt
lin apparatus_N = apparat_N ; -- status=guess
lin theology_N = theologie_N ; -- status=guess
lin analogy_N = analogie_N ; -- status=guess
lin efficiently_Adv = mkAdv "effizient" ; -- status=guess
lin bitterly_Adv = variants{} ; -- 
lin performer_N = mkN "Künstler" masculine | mkN "Künstlerin" feminine ; -- status=guess status=guess
lin individually_Adv = mkAdv "individuell" | mkAdv "einzeln" ; -- status=guess status=guess
lin amid_Prep = variants{} ; -- 
lin squadron_N = variants{} ; -- 
lin sentiment_N = variants{} ; -- 
lin making_N = mkN "Anfertigen" neuter | anfertigung_N | fabrikation_N | herstellung_N ; -- status=guess status=guess status=guess status=guess
lin exotic_A = exotisch_A ; -- status=guess
lin dominance_N = herrschaft_N ; -- status=guess
lin coherent_A = mkA "kohärent" ; -- status=guess
lin placement_N = mkN "Platzierung" feminine ; -- status=guess
lin flick_V2 = mkV2 (junkV (mkV "den") "Stinkefinger zeigen") ; -- status=guess, src=wikt
lin colourful_A = variants{} ; -- 
lin mercy_N = gnade_N ; -- status=guess
lin angrily_Adv = variants{} ; -- 
lin amuse_V2 = mkV2 (belustigen_V) | mkV2 (mkV "erheitern") ; -- status=guess, src=wikt status=guess, src=wikt
lin mainstream_N = mkN "Hauptrichtung" feminine | mkN "Mainstream" masculine ; -- status=guess status=guess
lin appraisal_N = mkN "Einschätzung" feminine | mkN "Taxierung" feminine ; -- status=guess status=guess
lin annually_Adv = mkAdv "jährlich" ; -- status=guess
lin torch_N = taschenlampe_N ; -- status=guess
lin intimate_A = vertraut_A | innig_A ; -- status=guess status=guess
lin gold_A = variants{} ; -- 
lin arbitrary_A = mkA "willkürlich" ; -- status=guess
lin venture_VS = variants{} ; -- 
lin venture_V2 = variants{} ; -- 
lin venture_V = variants{} ; -- 
lin preservation_N = mkN "Erhaltung" feminine ; -- status=guess
lin shy_A = mkA "schüchtern" | scheu_A ; -- status=guess status=guess
lin disclosure_N = variants{} ; -- 
lin lace_N = mkN "Schnürband" neuter | mkN "Schnürsenkel" masculine | mkN "Schuhband" neuter ; -- status=guess status=guess status=guess
lin inability_N = mkN "Unfähigkeit" feminine ; -- status=guess
lin motif_N = motiv_N ; -- status=guess
lin listenerMasc_N = mkN "Zuhörer" masculine | mkN "Zuhörerin" feminine ; -- status=guess status=guess
lin hunt_N = jagd_N ; -- status=guess
lin delicious_A = mkA "köstlich" | lecker_A | mkA "geschmackvoll" ; -- status=guess status=guess status=guess
lin term_VS = variants{} ; -- 
lin term_V2 = variants{} ; -- 
lin substitute_N = mkN "Ersatzspieler" masculine ; -- status=guess
lin highway_N = mkN "Hauptstraße" feminine ; -- status=guess
lin haul_V2 = mkV2 (ziehen_7_V) | mkV2 (schleppen_0_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin haul_V = ziehen_7_V | schleppen_0_V ; -- status=guess, src=wikt status=guess, src=wikt
lin dragon_N = mkN "Drachenboot" neuter ; -- status=guess
lin chair_V2 = mkV2 (junkV (mkV "Vorsitz") "{m} führen") ; -- status=guess, src=wikt
lin accumulate_V2 = mkV2 (mkReflV "vermehren") ; -- status=guess, src=wikt
lin accumulate_V = mkReflV "vermehren" ; -- status=guess, src=wikt
lin unchanged_A = variants{} ; -- 
lin sediment_N = sediment_N | satz_N ; -- status=guess status=guess
lin sample_V2 = mkV2 (probieren_V) | mkV2 (kosten_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin exclaim_V2 = mkV2 (mkV "ausrufen") ; -- status=guess, src=wikt
lin fan_V2 = mkV2 (mkV "ventilieren") | mkV2 (mkV "belüften") | mkV2 (mkV "anfachen") | mkV2 (mkV "embers)") | mkV2 (mkV "anwehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fan_V = mkV "ventilieren" | mkV "belüften" | mkV "anfachen" | mkV "embers)" | mkV "anwehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin volunteer_V2 = mkV2 (anbieten_V) | mkV2 (mkReflV "anbieten") ; -- status=guess, src=wikt status=guess, src=wikt
lin volunteer_V = anbieten_V | mkReflV "anbieten" ; -- status=guess, src=wikt status=guess, src=wikt
lin root_V2 = variants{} ; -- 
lin root_V = variants{} ; -- 
lin parcel_N = mkN "Paketbombe" feminine ; -- status=guess
lin psychiatric_A = mkA "psychiatrisch" ; -- status=guess
lin delightful_A = mkA "reizvoll" | mkA "entzückend" | angenehm_A ; -- status=guess status=guess status=guess
lin confidential_A = vertraulich_A ; -- status=guess
lin calorie_N = kalorie_N ; -- status=guess
lin flash_N = blitz_N ; -- status=guess
lin crowd_V2 = variants{} ; -- 
lin crowd_V = variants{} ; -- 
lin aggregate_A = variants{} ; -- 
lin scholarship_N = mkN "Gelehrsamkeit" feminine ; -- status=guess
lin monitor_N = bildschirm_N | mkN "Monitor" masculine ; -- status=guess status=guess
lin disciplinary_A = mkA "disziplinarisch" ; -- status=guess
lin rock_V2 = mkV2 (mkV "auwühlen") | mkV2 (schockieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin rock_V = mkV "auwühlen" | schockieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin hatred_N = mkN "Hass" masculine ; -- status=guess
lin pill_N = tablette_N | pille_N ; -- status=guess status=guess
lin noisy_A = laut_A | mkA "geräuschvoll" ; -- status=guess status=guess
lin feather_N = L.feather_N ;
lin lexical_A = lexikalisch_A ; -- status=guess
lin staircase_N = treppe_N ; -- status=guess
lin autonomous_A = autonom_A ; -- status=guess
lin viewpoint_N = variants{} ; -- 
lin projection_N = projektion_N ; -- status=guess
lin offensive_A = mkA "beleidigend" ; -- status=guess
lin controlled_A = variants{} ; -- 
lin flush_V2 = variants{} ; -- 
lin flush_V = variants{} ; -- 
lin racism_N = mkN "Rassismus" masculine ; -- status=guess
lin flourish_V = mkV "aufblühen" | junkV (mkV "eine") "Blütezeit haben" ; -- status=guess, src=wikt status=guess, src=wikt
lin resentment_N = ressentiment_N | abneigung_N | mkN "Missgunst" feminine ; -- status=guess status=guess status=guess
lin pillow_N = kopfkissen_N | kissen_N | mkN "Ruhekissen" neuter ; -- status=guess status=guess status=guess
lin courtesy_N = mkN "Höflichkeit" feminine ; -- status=guess
lin photography_N = fotografie_N ; -- status=guess
lin monkey_N = affe_N ; -- status=guess
lin glorious_A = mkA "ruhmvoll" ; -- status=guess
lin evolutionary_A = mkA "evolutionär" ; -- status=guess
lin gradual_A = graduell_A ; -- status=guess
lin bankruptcy_N = bankrott_N ; -- status=guess
lin sacrifice_N = opfer_N ; -- status=guess
lin uphold_V2 = variants{} ; -- 
lin sketch_N = skizze_N ; -- status=guess
lin presidency_N = mkN "Präsidentschaft" feminine ; -- status=guess
lin formidable_A = variants{} ; -- 
lin differentiate_V2 = mkV2 (differenzieren_V) | mkV2 (unterscheiden_V) | mkV2 (diskriminieren_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin differentiate_V = differenzieren_V | unterscheiden_V | diskriminieren_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin continuing_A = variants{} ; -- 
lin cart_N = mkN "Wagen" masculine | karren_N ; -- status=guess status=guess
lin stadium_N = stadion_N ; -- status=guess
lin dense_A = dicht_A ; -- status=guess
lin catch_N = haken_N ; -- status=guess
lin beyond_Adv = variants{} ; -- 
lin immigration_N = einwanderung_N | immigration_N ; -- status=guess status=guess
lin clarity_N = klarheit_N ; -- status=guess
lin worm_N = L.worm_N ;
lin slot_N = mkN "Münzautomat" masculine ; -- status=guess
lin rifle_N = gewehr_N ; -- status=guess
lin screw_V2 = mkV2 (ficken_0_V) ; -- status=guess, src=wikt
lin screw_V = ficken_0_V ; -- status=guess, src=wikt
lin harvest_N = herbstgrasmilbe_N ; -- status=guess
lin foster_V2 = mkV2 (pflegen_8_V) ; -- status=guess, src=wikt
lin academic_N = variants{} ; -- 
lin impulse_N = impuls_N | mkN "Triebkraft" feminine ; -- status=guess status=guess
lin guardian_N = schutzengel_N ; -- status=guess
lin ambiguity_N = mkN "Ambiguität" feminine | mehrdeutigkeit_N | mkN "Doppeldeutigkeit" feminine ; -- status=guess status=guess status=guess
lin triangle_N = mkN "Dreiecksungleichung" feminine ; -- status=guess
lin terminate_V2 = mkV2 (terminieren_V) | mkV2 (mkV "abschließen") ; -- status=guess, src=wikt status=guess, src=wikt
lin terminate_V = terminieren_V | mkV "abschließen" ; -- status=guess, src=wikt status=guess, src=wikt
lin retreat_V = mkReflV "zurückziehen" ; -- status=guess, src=wikt
lin pony_N = pony_N ; -- status=guess
lin outdoor_A = mkA "im Freien" ; -- status=guess
lin deficiency_N = variants{} ; -- 
lin decree_N = mkN "Erlass" masculine | mkN "Verfügung" feminine | verordnung_N | dekret_N ; -- status=guess status=guess status=guess status=guess
lin apologize_V = mkReflV "entschuldigen" ; -- status=guess, src=wikt
lin yarn_N = garn_N ; -- status=guess
lin staff_V2 = variants{} ; -- 
lin renewal_N = erneuerung_N ; -- status=guess
lin rebellion_N = mkN "Rebellion" feminine | aufstand_N ; -- status=guess status=guess
lin incidentally_Adv = apropos_Adv | nebenbei_Adv | mkAdv "übrigens" ; -- status=guess status=guess status=guess
lin flour_N = mehl_N ; -- status=guess
lin developed_A = entwickelt_A ; -- status=guess
lin chorus_N = mkN "Chor" masculine ; -- status=guess
lin ballot_N = stimmzettel_ergebnis_N ; -- status=guess
lin appetite_N = begierde_N | lust_N ; -- status=guess status=guess
lin stain_V2 = variants{} ; -- 
lin stain_V = variants{} ; -- 
lin notebook_N = notizbuch_N ; -- status=guess
lin loudly_Adv = mkAdv "laut" ; -- status=guess
lin homeless_A = obdachlos_A ; -- status=guess
lin census_N = zensus_N | mkN "Volkszählung" feminine | befragung_N | mkN "Bevölkerungszählung" feminine | mkN "Zählung" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin bizarre_A = bizarr_A | komisch_A | seltsam_A ; -- status=guess status=guess status=guess
lin striking_A = mkA "auffällig" ; -- status=guess
lin greenhouse_N = mkN "Gewächshaus" neuter | treibhaus_N ; -- status=guess status=guess
lin part_V2 = mkV2 (mkV "scheiteln") ; -- status=guess, src=wikt
lin part_V = mkV "scheiteln" ; -- status=guess, src=wikt
lin burial_N = mkN "Begräbnis" neuter ; -- status=guess
lin embarrassed_A = mkA "verlegen" ; -- status=guess
lin ash_N = mkN "Aschblonder" masculine | mkN "Aschblondin" masculine | mkN "Aschblondling" masculine | mkN "Aschblondhaariger" masculine | mkN "Aschblonde" feminine | mkN "Aschblondine" feminine | mkN "Aschblondhaarige" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin actress_N = schauspielerin_N ; -- status=guess
lin cassette_N = kassette_N ; -- status=guess
lin privacy_N = mkN "Zurückgezogenheit" feminine | mkN "Privatsphäre" feminine ; -- status=guess status=guess
lin fridge_N = L.fridge_N ;
lin feed_N = mkN "Futtern" neuter | mkN "Fütterung" feminine ; -- status=guess status=guess
lin excess_A = variants{} ; -- 
lin calf_N = wade_N ; -- status=guess
lin associate_N = variants{} ; -- 
lin ruin_N = ruine_N ; -- status=guess
lin jointly_Adv = variants{} ; -- 
lin drill_V2 = mkV2 (bohren_V) ; -- status=guess, src=wikt
lin drill_V = bohren_V ; -- status=guess, src=wikt
lin photograph_V2 = mkV2 (fotografieren_3_V) ; -- status=guess, src=wikt
lin devoted_A = variants{} ; -- 
lin indirectly_Adv = mkAdv "indirekt" ; -- status=guess
lin driving_A = variants{} ; -- 
lin memorandum_N = memorandum_N ; -- status=guess
lin default_N = mkN "Grundzustand" masculine | standard_N ; -- status=guess status=guess
lin costume_N = mkN "Kostüm" neuter ; -- status=guess
lin variant_N = variante_N ; -- status=guess
lin shatter_V2 = variants{} ; -- 
lin shatter_V = variants{} ; -- 
lin methodology_N = methodologie__N | methodik_N ; -- status=guess status=guess
lin frame_V2 = mkV2 (mkV "einfassen") | mkV2 (mkV "einrahmen") ; -- status=guess, src=wikt status=guess, src=wikt
lin frame_V = mkV "einfassen" | mkV "einrahmen" ; -- status=guess, src=wikt status=guess, src=wikt
lin allegedly_Adv = mkAdv "angeblich" | mkAdv "vermeintlich" ; -- status=guess status=guess
lin swell_V2 = mkV2 (schwellen_V) ; -- status=guess, src=wikt
lin swell_V = L.swell_V ;
lin investigator_N = ermittler_N | mkN "Ermittlerin" feminine ; -- status=guess status=guess
lin imaginative_A = variants{} ; -- 
lin bored_A = variants{} ; -- 
lin bin_N = mkN "Mülltonne" ; -- status=guess
lin awake_A = wach_A ; -- status=guess
lin recycle_V2 = mkV2 (mkV "wiederverwerten") | mkV2 (mkV "recyceln") | mkV2 (mkV "recyclen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin group_V2 = mkV2 (gruppieren_V) ; -- status=guess, src=wikt
lin group_V = gruppieren_V ; -- status=guess, src=wikt
lin enjoyment_N = variants{} ; -- 
lin contemporary_N = zeitgenosse_N | mkN "Zeitgenossin" feminine ; -- status=guess status=guess
lin texture_N = textur_N ; -- status=guess
lin donor_N = spender_N ; -- status=guess
lin bacon_N = speck_N ; -- status=guess
lin sunny_A = sonnig_A ; -- status=guess
lin stool_N = hocker_N ; -- status=guess
lin prosecute_V2 = mkV2 (junkV (mkV "strafrechtlich") "verfolgen") | mkV2 (belangen_V) | mkV2 (bestrafen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin commentary_N = kommentar_N ; -- status=guess
lin bass_N = mkN "Bassklarinette" feminine ; -- status=guess
lin sniff_V2 = mkV2 (mkV "schnüffeln") ; -- status=guess, src=wikt
lin sniff_V = mkV "schnüffeln" ; -- status=guess, src=wikt
lin repetition_N = wiederholung_N | mkN "Repetition" feminine ; -- status=guess status=guess
lin eventual_A = variants{} ; -- 
lin credit_V2 = variants{} ; -- 
lin suburb_N = mkN "Vorstadt" feminine | mkN "Vorort" masculine ; -- status=guess status=guess
lin newcomer_N = neuling_N ; -- status=guess
lin romance_N = mkN "Romanze" feminine ; -- status=guess
lin film_V2 = mkV2 (filmen_V) | mkV2 (drehen_5_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin film_V = filmen_V | drehen_5_V ; -- status=guess, src=wikt status=guess, src=wikt
lin experiment_V2 = mkV2 (experimentieren_V) ; -- status=guess, src=wikt
lin experiment_V = experimentieren_V ; -- status=guess, src=wikt
lin daylight_N = mkN "Tageslicht" neuter ; -- status=guess
lin warrant_N = variants{} ; -- 
lin fur_N = pelz_N | mkN "Pelzmantel" masculine ; -- status=guess status=guess
lin parking_N = mkN "Parken" neuter | mkN "Parkieren" neuter ; -- status=guess status=guess
lin nuisance_N = mkN "Belästigung" feminine ; -- status=guess
lin civilian_A = variants{} ; -- 
lin foolish_A = dumm_A | mkA "närrisch" | mkA "töricht" ; -- status=guess status=guess status=guess
lin bulb_N = zwiebel_N ; -- status=guess
lin balloon_N = mkN "Ballon" masculine | mkN "Luftballon" masculine ; -- status=guess status=guess
lin vivid_A = lebendig_A | lebhaft_A ; -- status=guess status=guess
lin surveyor_N = mkN "Vermesser" ; -- status=guess
lin spontaneous_A = spontan_A ; -- status=guess
lin biology_N = mkN "Biologie" feminine ; -- status=guess
lin injunction_N = mkN "Verfügung" feminine ; -- status=guess
lin appalling_A = erschreckend_A ; -- status=guess
lin amusement_N = mkN "Amüsement" neuter | mkN "Entertainment" neuter | unterhaltung_N | mkN "Vergnügen" neuter ; -- status=guess status=guess status=guess status=guess
lin aesthetic_A = mkA "ästhetisch" ; -- status=guess
lin vegetation_N = mkN "Vegetation" feminine ; -- status=guess
lin stab_V2 = L.stab_V2 ;
lin stab_V = stechen_V | erstechen_V | mkV "niederstechen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rude_A = grob_A | mkA "unhöflich" | frech_A | mkA "unverschämt" ; -- status=guess status=guess status=guess status=guess
lin offset_V2 = variants{} ; -- 
lin thinking_N = variants{} ; -- 
lin mainframe_N = mkN "Großrechner" masculine ; -- status=guess
lin flock_N = schwarm_N | schar_N ; -- status=guess status=guess
lin amateur_A = mkA "amateurhaft" ; -- status=guess
lin academy_N = mkN "akademische Einrichtung" feminine ; -- status=guess
lin shilling_N = mkN "Schilling" masculine ; -- status=guess
lin reluctance_N = mkN "Widerstreben" neuter ; -- status=guess
lin velocity_N = geschwindigkeit_N ; -- status=guess
lin spare_V2 = variants{} ; -- 
lin spare_V = variants{} ; -- 
lin wartime_N = variants{} ; -- 
lin soak_V2 = mkV2 (mkV "durchnässen") ; -- status=guess, src=wikt
lin soak_V = mkV "durchnässen" ; -- status=guess, src=wikt
lin rib_N = brustkorb_N ; -- status=guess
lin mighty_A = gewaltig_A | mkA "mächtig" ; -- status=guess status=guess
lin shocked_A = mkA "schockiert" ; -- status=guess
lin vocational_A = variants{} ; -- 
lin spit_V2 = mkV2 (spucken_6_V) ; -- status=guess, src=wikt
lin spit_V = L.spit_V ;
lin gall_N = galle_N ; -- status=guess
lin bowl_V2 = variants{} ; -- 
lin bowl_V = variants{} ; -- 
lin prescription_N = rezept_N | mkN "Verschreibung" feminine ; -- status=guess status=guess
lin fever_N = fieber_N ; -- status=guess
lin axis_N = achse_N ; -- status=guess
lin reservoir_N = stausee_N ; -- status=guess
lin magnitude_N = variants{} ; -- 
lin rape_V2 = mkV2 (vergewaltigen_V) | mkV2 (mkV "schänden") ; -- status=guess, src=wikt status=guess, src=wikt
lin cutting_N = mkN "Steckling" masculine | ableger_N | mkN "Senkreis" neuter ; -- status=guess status=guess status=guess
lin bracket_N = klammer_N ; -- status=guess
lin agony_N = agonie_N | qual_N | mkN "Pein" feminine ; -- status=guess status=guess status=guess
lin strive_VV = mkVV (streben_6_V) ; -- status=guess, src=wikt
lin strive_V = streben_6_V ; -- status=guess, src=wikt
lin strangely_Adv = variants{} ; -- 
lin pledge_VS = mkVS (mkV "verpfänden") ; -- status=guess, src=wikt
lin pledge_V2V = mkV2V (mkV "verpfänden") ; -- status=guess, src=wikt
lin pledge_V2 = mkV2 (mkV "verpfänden") ; -- status=guess, src=wikt
lin recipient_N = mkN "Empfänger" masculine ; -- status=guess
lin moor_N = moor_N ; -- status=guess
lin invade_V2 = mkV2 (mkV "überfallen") | mkV2 (mkV "einmarschieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin dairy_N = molkerei_N ; -- status=guess
lin chord_N = akkord_N ; -- status=guess
lin shrink_V2 = mkV2 (mkReflV "drücken") ; -- status=guess, src=wikt
lin shrink_V = mkReflV "drücken" ; -- status=guess, src=wikt
lin poison_N = gift_N | mkN "Giftstoff" masculine ; -- status=guess status=guess
lin pillar_N = pfeiler_N | mkN "Säule" feminine ; -- status=guess status=guess
lin washing_N = mkN "Waschen" neuter ; -- status=guess
lin warrior_N = krieger_N ; -- status=guess
lin supervisor_N = aufseher_N | mkN "Vorgesetzter" masculine ; -- status=guess status=guess
lin outfit_N = outfit_N ; -- status=guess
lin innovative_A = innovativ_A ; -- status=guess
lin dressing_N = dressing_N ; -- status=guess
lin dispute_V2 = variants{} ; -- 
lin dispute_V = variants{} ; -- 
lin jungle_N = urwald_N | mkN "Dschungel {m}" feminine neuter ; -- status=guess status=guess
lin brewery_N = brauerei_N | mkN "Brauhaus" neuter | mkN "Bierbrauerei" ; -- status=guess status=guess status=guess
lin adjective_N = adjektiv_N | eigenschaftswort_N ; -- status=guess status=guess
lin straighten_V2 = variants{} ; -- 
lin straighten_V = variants{} ; -- 
lin restrain_V2 = mkV2 (mkV "zügeln") ; -- status=guess, src=wikt
lin monarchy_N = monarchie_N ; -- status=guess
lin trunk_N = mkN "Rüssel" masculine ; -- status=guess
lin herd_N = herde_N ; -- status=guess
lin deadline_N = mkN "Stichtag" masculine | frist_N | termin_N ; -- status=guess status=guess status=guess
lin tiger_N = tiger_N ; -- status=guess
lin supporting_A = variants{} ; -- 
lin moderate_A = moderat_A ; -- status=guess
lin kneel_V = knien_V ; -- status=guess, src=wikt
lin ego_N = ich_laut_N | ego_shooter_N ; -- status=guess status=guess
lin sexually_Adv = variants{} ; -- 
lin ministerial_A = mkA "ministeriell" ; -- status=guess
lin bitch_N = zicke_N ; -- status=guess
lin wheat_N = weizen_N ; -- status=guess
lin stagger_V = zweifeln_2_V | wanken_V ; -- status=guess, src=wikt status=guess, src=wikt
lin snake_N = L.snake_N ;
lin ribbon_N = mkN "Band" neuter ; -- status=guess
lin mainland_N = festland_N | kontinent_N ; -- status=guess status=guess
lin fisherman_N = fischer_N | mkN "Fischerin" feminine ; -- status=guess status=guess
lin economically_Adv = variants{} ; -- 
lin unwilling_A = variants{} ; -- 
lin nationalism_N = mkN "Nationalismus" masculine ; -- status=guess
lin knitting_N = mkN "Stricken" neuter ; -- status=guess
lin irony_N = ironie_N ; -- status=guess
lin handling_N = hehlerei_N ; -- status=guess
lin desired_A = variants{} ; -- 
lin bomber_N = bomber_N ; -- status=guess
lin voltage_N = spannung_N ; -- status=guess
lin unusually_Adv = variants{} ; -- 
lin toast_N = trinkspruch_N | mkN "Toast" masculine | mkN "Tischrede" feminine ; -- status=guess status=guess status=guess
lin feel_N = variants{} ; -- 
lin suffering_N = leiden_N ; -- status=guess
lin polish_V2 = mkV2 (polieren_V) ; -- status=guess, src=wikt
lin polish_V = polieren_V ; -- status=guess, src=wikt
lin technically_Adv = mkAdv "eigentlich" ; -- status=guess
lin meaningful_A = bedeutend_A | bedeutungsvoll_A ; -- status=guess status=guess
lin aloud_Adv = mkAdv "laut" | mkAdv "vorlesen" ; -- status=guess status=guess
lin waiter_N = ober__N | kellner_N ; -- status=guess status=guess
lin tease_V2 = mkV2 (necken_V) | mkV2 (mkV "hänseln") ; -- status=guess, src=wikt status=guess, src=wikt
lin opposite_Adv = mkAdv "gegenüber" ; -- status=guess
lin goat_N = ziege_N | mkN "Geiß" feminine ; -- status=guess status=guess
lin conceptual_A = variants{} ; -- 
lin ant_N = ameise_N ; -- status=guess
lin inflict_V2 = mkV2 (mkV "verhängen") | mkV2 (mkV "zufügen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bowler_N = melone_N | mkN "Melonenhut" masculine ; -- status=guess status=guess
lin roar_V2 = mkV2 (mkV "brüllen") ; -- status=guess, src=wikt
lin roar_V = mkV "brüllen" ; -- status=guess, src=wikt
lin drain_N = abfluss_N ; -- status=guess
lin wrong_N = variants{} ; -- 
lin galaxy_N = galaxie_N | mkN "Galaxis" feminine | mkN "Welteninsel" feminine ; -- status=guess status=guess status=guess
lin aluminium_N = aluminium_N ; -- status=guess
lin receptor_N = variants{} ; -- 
lin preach_V2 = mkV2 (predigen_V) ; -- status=guess, src=wikt
lin preach_V = predigen_V ; -- status=guess, src=wikt
lin parade_N = folge_N | abfolge_N ; -- status=guess status=guess
lin opposite_N = gegenteil_N ; -- status=guess
lin critique_N = kritik_N ; -- status=guess
lin query_N = abfrage_N ; -- status=guess
lin outset_N = anfang_N | beginn_N ; -- status=guess status=guess
lin integral_A = mkA "integral" ; -- status=guess
lin grammatical_A = grammatisch_A | grammatikalisch_A ; -- status=guess status=guess
lin testing_N = variants{} ; -- 
lin patrol_N = patrouille_N ; -- status=guess
lin pad_N = unterlage_N | mkN "Polster" neuter ; -- status=guess status=guess
lin unreasonable_A = mkA "unvernünftig" ; -- status=guess
lin sausage_N = wurst_N ; -- status=guess
lin criminal_N = mkN "Kriminelle" feminine | mkN "Krimineller" masculine | verbrecher_N ; -- status=guess status=guess status=guess
lin constructive_A = konstruktiv_A ; -- status=guess
lin worldwide_A = weltweit_A ; -- status=guess
lin highlight_N = mkN "Highlight" neuter ; -- status=guess
lin doll_N = puppe_N ; -- status=guess
lin frightened_A = variants{} ; -- 
lin biography_N = biografie_N | biographie_N ; -- status=guess status=guess
lin vocabulary_N = mkN "Vokabeln {f} {p}" | wortschatz_N ; -- status=guess status=guess
lin offend_V2 = mkV2 (beleidigen_V) ; -- status=guess, src=wikt
lin offend_V = beleidigen_V ; -- status=guess, src=wikt
lin accumulation_N = mkN "Anhäufung" feminine ; -- status=guess
lin linen_N = leinen_N ; -- status=guess
lin fairy_N = fee_N | elfe_N ; -- status=guess status=guess
lin disco_N = diskothek_N ; -- status=guess
lin hint_VS = variants{} ; -- 
lin hint_V2 = variants{} ; -- 
lin hint_V = variants{} ; -- 
lin versus_Prep = variants{} ; -- 
lin ray_N = strahl_N ; -- status=guess
lin pottery_N = mkN "Töpferware" feminine ; -- status=guess
lin immune_A = immun_A ; -- status=guess
lin retreat_N = mkN "Rückzug" ; -- status=guess
lin master_V2 = mkV2 (mkV "meistern") ; -- status=guess, src=wikt
lin injured_A = variants{} ; -- 
lin holly_N = stechpalme_N | mkN "Hülse" feminine ; -- status=guess status=guess
lin battle_V2 = mkV2 (mkV "kämpfen") ; -- status=guess, src=wikt
lin battle_V = mkV "kämpfen" ; -- status=guess, src=wikt
lin solidarity_N = mkN "Solidarität" feminine | mkN "Unterstützung" feminine ; -- status=guess status=guess
lin embarrassing_A = peinlich_A ; -- status=guess
lin cargo_N = fracht_N ; -- status=guess
lin theorist_N = theoretiker_N ; -- status=guess
lin reluctantly_Adv = ungern_Adv ; -- status=guess
lin preferred_A = variants{} ; -- 
lin dash_V = variants{} ; -- 
lin total_V2 = mkV2 (mkV "aufaddieren") | mkV2 (mkV "zusammenaddieren") | mkV2 (mkV "zusammennehmen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin total_V = mkV "aufaddieren" | mkV "zusammenaddieren" | mkV "zusammennehmen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reconcile_V2 = mkV2 (junkV (mkV "1.") "schlichten") | mkV2 (junkV (mkV "versöhnen") "2.") ; -- status=guess, src=wikt status=guess, src=wikt
lin drill_N = mkN "Bohreisen" neuter ; -- status=guess
lin credibility_N = mkN "Glaubwürdigkeit" feminine ; -- status=guess
lin copyright_N = urheberrecht_N ; -- status=guess
lin beard_N = bart_N ; -- status=guess
lin bang_N = schlag_N | hieb_N ; -- status=guess status=guess
lin vigorous_A = variants{} ; -- 
lin vaguely_Adv = variants{} ; -- 
lin punch_V2 = mkV2 (mkV "lochen") ; -- status=guess, src=wikt
lin prevalence_N = variants{} ; -- 
lin uneasy_A = variants{} ; -- 
lin boost_N = variants{} ; -- 
lin scrap_N = mkN "Altmaterial" neuter | altmetall_N | schrott_N | abfall_N ; -- status=guess status=guess status=guess status=guess
lin ironically_Adv = variants{} ; -- 
lin fog_N = L.fog_N ;
lin faithful_A = treu_A ; -- status=guess
lin bounce_V2 = mkV2 (mkV "abprallen") ; -- status=guess, src=wikt
lin bounce_V = mkV "abprallen" ; -- status=guess, src=wikt
lin batch_N = partie_N ; -- status=guess
lin smooth_V2 = variants{} ; -- 
lin smooth_V = variants{} ; -- 
lin sleeping_A = mkA "Schlaf-" ; -- status=guess
lin poorly_Adv = variants{} ; -- 
lin accord_V = variants{} ; -- 
lin vice_president_N = variants{} ; -- 
lin duly_Adv = mkAdv "gebührend" | mkAdv "ordnungsgemäß" ; -- status=guess status=guess
lin blast_N = mkN "Windstoß" masculine ; -- status=guess
lin square_V2 = mkV2 (quadrieren_V) ; -- status=guess, src=wikt
lin square_V = quadrieren_V ; -- status=guess, src=wikt
lin prohibit_V2 = mkV2 (verbieten_V) ; -- status=guess, src=wikt
lin prohibit_V = verbieten_V ; -- status=guess, src=wikt
lin brake_N = bremse_N ; -- status=guess
lin asylum_N = mkN "psychiatrische Anstalt" feminine ; -- status=guess
lin obscure_V2 = mkV2 (mkV "verdunkeln") | mkV2 (mkV "vernebeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin nun_N = nonne_N | mkN "Ordensschwester" feminine | mkN "Klosterschwester" feminine | schwester_N ; -- status=guess status=guess status=guess status=guess
lin heap_N = mkN "Heap" masculine ; -- status=guess
lin smoothly_Adv = variants{} ; -- 
lin rhetoric_N = rhetorik_N ; -- status=guess
lin privileged_A = mkA "privilegiert" ; -- status=guess
lin liaison_N = variants{} ; -- 
lin jockey_N = jockey_N ; -- status=guess
lin concrete_N = mkN "Beton" masculine ; -- status=guess
lin allied_A = variants{} ; -- 
lin rob_V2 = mkV2 (rauben_V) ; -- status=guess, src=wikt
lin indulge_V2 = mkV2 (mkV "frönen") | mkV2 (mkV "hätscheln") | mkV2 (mkV "verwöhnen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin indulge_V = mkV "frönen" | mkV "hätscheln" | mkV "verwöhnen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin except_Prep = S.except_Prep ;
lin distort_V2 = mkV2 (mkV "verzerren") ; -- status=guess, src=wikt
lin whatsoever_Adv = variants{} ; -- 
lin viable_A = mkA "selbständig" ; -- status=guess
lin nucleus_N = mkN "Zellkern" masculine | nukleus_N ; -- status=guess status=guess
lin exaggerate_V2 = mkV2 (mkV "übertreiben") ; -- status=guess, src=wikt
lin exaggerate_V = mkV "übertreiben" ; -- status=guess, src=wikt
lin compact_N = pakt_N | mkN "Kontrakt" masculine ; -- status=guess status=guess
lin nationality_N = mkN "Nationalität" ; -- status=guess
lin direct_Adv = variants{} ; -- 
lin cast_N = mkN "Cast" masculine | besetzung_N | ensemble_N ; -- status=guess status=guess status=guess
lin altar_N = altar_N ; -- status=guess
lin refuge_N = herberge_N | mkN "Zuflucht" feminine ; -- status=guess status=guess
lin presently_Adv = sogleich_Adv ; -- status=guess
lin mandatory_A = mkA "zwingend notwendig" | obligatorisch_A ; -- status=guess status=guess
lin authorize_V2V = mkV2V (autorisieren_V) | mkV2V (mkV "befugen") | mkV2V (mkV "ermächtigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin authorize_V2 = mkV2 (autorisieren_V) | mkV2 (mkV "befugen") | mkV2 (mkV "ermächtigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accomplish_V2 = mkV2 (mkV "vollenden") ; -- status=guess, src=wikt
lin startle_V2 = variants{} ; -- 
lin indigenous_A = indigen_A ; -- status=guess
lin worse_Adv = variants{} ; -- 
lin retailer_N = mkN "Einzelhändler" masculine ; -- status=guess
lin compound_V2 = variants{} ; -- 
lin compound_V = variants{} ; -- 
lin admiration_N = bewunderung_N ; -- status=guess
lin absurd_A = absurd_A ; -- status=guess
lin coincidence_N = mkN "zufälliges Zusammentreffen" masculine | koinzidenz_N ; -- status=guess status=guess
lin principally_Adv = variants{} ; -- 
lin passport_N = reisepass_N | pass_N ; -- status=guess status=guess
lin depot_N = depot_N ; -- status=guess
lin soften_V2 = variants{} ; -- 
lin soften_V = variants{} ; -- 
lin secretion_N = mkN "Sekretion" feminine ; -- status=guess
lin invoke_V2 = mkV2 (aufrufen_4_V) ; -- status=guess, src=wikt
lin dirt_N = mkN "Schmutz" masculine ; -- status=guess
lin scared_A = mkA "sich fürchten" | mkA "sich furchten" ; -- status=guess status=guess
lin mug_N = becher_N ; -- status=guess
lin convenience_N = annehmlichkeit_N | bequemlichkeit_N ; -- status=guess status=guess
lin calm_N = mkN "Ruhe vor dem Sturm" feminine ; -- status=guess
lin optional_A = freiwillig_A | optional_A | wahlfrei_A ; -- status=guess status=guess status=guess
lin unsuccessful_A = mkA "erfolglos" ; -- status=guess
lin consistency_N = konsistenz_N ; -- status=guess
lin umbrella_N = schirm_N ; -- status=guess
lin solo_N = mkN "Solo" neuter ; -- status=guess
lin hemisphere_N = mkN "Hemisphäre" feminine | halbkugel_N ;
lin extreme_N = extrem_N ; -- status=guess
lin brandy_N = mkN "Kurzer" masculine ; -- status=guess
lin belly_N = L.belly_N ;
lin attachment_N = anlage_N | anhang_N ; -- status=guess status=guess
lin wash_N = mkN "Lavierung" ; -- status=guess
lin uncover_V2 = variants{} ; -- 
lin treat_N = variants{} ; -- 
lin repeated_A = variants{} ; -- 
lin pine_N = mkN "Föhre" feminine | kiefer_N ; -- status=guess status=guess
lin offspring_N = hinterlassenschaft_N ; -- status=guess
lin communism_N = mkN "Kommunismus" masculine ; -- status=guess
lin nominate_V2 = mkV2 (nominieren_V) ; -- status=guess, src=wikt
lin soar_V2 = mkV2 (schweben_V) ; -- status=guess, src=wikt
lin soar_V = schweben_V ; -- status=guess, src=wikt
lin geological_A = variants{} ; -- 
lin frog_N = frosch_N ; -- status=guess
lin donate_V2 = mkV2 (spenden_V) | mkV2 (stiften_V) | mkV2 (schenken_1_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin donate_V = spenden_V | stiften_V | schenken_1_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cooperative_A = kooperativ_A ; -- status=guess
lin nicely_Adv = variants{} ; -- 
lin innocence_N = mkN "Unschuld" feminine ; -- status=guess
lin housewife_N = hausfrau_N ; -- status=guess
lin disguise_V2 = mkV2 (verstellen_V) ; -- status=guess, src=wikt
lin demolish_V2 = mkV2 (mkV "abreißen") | mkV2 (mkV "niederreißen") ; -- status=guess, src=wikt status=guess, src=wikt
lin counsel_N = rat_N | ratschlag_N ; -- status=guess status=guess
lin cord_N = schnur_N | mkN "Kordel" feminine ; -- status=guess status=guess
lin semi_final_N = variants{} ; -- 
lin reasoning_N = argumentation_N ; -- status=guess
lin litre_N = mkN "Liter" masculine ; -- status=guess
lin inclined_A = geneigt_A ; -- status=guess
lin evoke_V2 = mkV2 (hervorrufen_V) ; -- status=guess, src=wikt
lin courtyard_N = hof_N ; -- status=guess
lin arena_N = arena_N ; -- status=guess
lin simplicity_N = mkN "Einfachheit" feminine ; -- status=guess
lin inhibition_N = mkN "Unterdrückung" feminine ; -- status=guess
lin frozen_A = gefroren_A ; -- status=guess
lin vacuum_N = mkN "Vakuum" neuter ; -- status=guess
lin immigrant_N = einwanderer_N | mkN "Einwanderin" feminine | immigrant_N | mkN "Immigrantin" feminine ; -- status=guess status=guess status=guess status=guess
lin bet_N = mkN "Bestimmtheit" feminine ; -- status=guess
lin revenge_N = mkN "Rache" feminine ; -- status=guess
lin jail_V2 = variants{} ; -- 
lin helmet_N = helm_N ; -- status=guess
lin unclear_A = unklar_A ; -- status=guess
lin jerk_V2 = mkV2 (zucken_V) ; -- status=guess, src=wikt
lin jerk_V = zucken_V ; -- status=guess, src=wikt
lin disruption_N = durcheinander_N | mkN "Unordnung" feminine ; -- status=guess status=guess
lin attainment_N = variants{} ; -- 
lin sip_V2 = variants{} ; -- 
lin sip_V = variants{} ; -- 
lin program_V2V = mkV2V (mkV "programmieren") ; -- status=guess, src=wikt
lin program_V2 = mkV2 (mkV "programmieren") ; -- status=guess, src=wikt
lin lunchtime_N = variants{} ; -- 
lin cult_N = sekte_N ; -- status=guess
lin chat_N = mkN "Schmätzer" feminine ; -- status=guess
lin accord_N = mkN "Übereinstimmung" feminine ; -- status=guess
lin supposedly_Adv = mkAdv "angeblich" ; -- status=guess
lin offering_N = variants{} ; -- 
lin broadcast_N = sendung_N | mkN "Übertragung" feminine | mkN "Ausstrahlung" feminine | mkN "Rundfunk" masculine ; -- status=guess status=guess status=guess status=guess
lin secular_A = mkA "säkular" | weltlich_A ; -- status=guess status=guess
lin overwhelm_V2 = mkV2 (mkV "überwältigen") ; -- status=guess, src=wikt
lin momentum_N = schwung_N ; -- status=guess
lin infinite_A = unendlich_A ; -- status=guess
lin manipulation_N = mkN "Manipulierung" feminine | mkN "Manipulieren" neuter | manipulation_N ; -- status=guess status=guess status=guess
lin inquest_N = variants{} ; -- 
lin decrease_N = verringerung_N ; -- status=guess
lin cellar_N = keller_N ; -- status=guess
lin counsellor_N = variants{} ; -- 
lin avenue_N = allee_N ; -- status=guess
lin rubber_A = variants{} ; -- 
lin labourer_N = variants{} ; -- 
lin lab_N = variants{} ; -- 
lin damn_V2 = mkV2 (mkV "verdammen") ; -- status=guess, src=wikt
lin comfortably_Adv = variants{} ; -- 
lin tense_A = gespannt_A ; -- status=guess
lin socket_N = steckdose_N | fassung_N ; -- status=guess status=guess
lin par_N = variants{} ; -- 
lin thrust_N = variants{} ; -- 
lin scenario_N = mkN "Szenario" neuter | mkN "Szenarium" neuter | drehbuch_N ; -- status=guess status=guess status=guess
lin frankly_Adv = variants{} ; -- 
lin slap_V2 = mkV2 (klatschen_0_V) | mkV2 (schlagen_5_V) | mkV2 (mkV "patschen") | mkV2 (ohrfeigen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin recreation_N = mkN "Erholung" feminine | unterhaltung_N ; -- status=guess status=guess
lin rank_V2 = mkV2 (junkV (mkV "an") "einer Stelle stehen") ; -- status=guess, src=wikt
lin rank_V = junkV (mkV "an") "einer Stelle stehen" ; -- status=guess, src=wikt
lin spy_N = spion_N ; -- status=guess
lin filter_V2 = mkV2 (filtrieren_V) | mkV2 (passieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin filter_V = filtrieren_V | passieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin clearance_N = mkN "Ausverkauf" masculine ; -- status=guess
lin blessing_N = mkN "Segnen" neuter | mkN "Segnung" feminine ; -- status=guess status=guess
lin embryo_N = embryo_N ; -- status=guess
lin varied_A = variants{} ; -- 
lin predictable_A = mkA "vorhersagbar" | mkA "prädiktabel" ; -- status=guess status=guess
lin mutation_N = mutation_N ; -- status=guess
lin equal_V2 = mkV2 (gleichen_V) ; -- status=guess, src=wikt
lin can_1_VV = S.can_VV ;
lin can_2_VV = S.can8know_VV ;
lin can_V2 = variants{} ; -- 
lin burst_N = mkN "Bersten" neuter | mkN "Zerbrechen" neuter | mkN "Platzen" neuter ; -- status=guess status=guess status=guess
lin retrieve_V2 = mkV2 (mkV "zurückholen") ; -- status=guess, src=wikt
lin retrieve_V = mkV "zurückholen" ; -- status=guess, src=wikt
lin elder_N = holunder_N ; -- status=guess
lin rehearsal_N = probe_N ; -- status=guess
lin optical_A = optisch_A ; -- status=guess
lin hurry_N = mkN "Eile" feminine ; -- status=guess
lin conflict_V = variants{} ; -- 
lin combat_V2 = variants{} ; -- 
lin combat_V = variants{} ; -- 
lin absorption_N = absorption_N ; -- status=guess
lin ion_N = ion_N ; -- status=guess
lin wrong_Adv = variants{} ; -- 
lin heroin_N = mkN "Heroin" neuter ; -- status=guess
lin bake_V2 = mkV2 (backen_3_V) ; -- status=guess, src=wikt
lin bake_V = backen_3_V ; -- status=guess, src=wikt
lin x_ray_N = variants{} ; -- 
lin vector_N = vektor_N ; -- status=guess
lin stolen_A = variants{} ; -- 
lin sacrifice_V2 = mkV2 (opfern_V) ; -- status=guess, src=wikt
lin sacrifice_V = opfern_V ; -- status=guess, src=wikt
lin robbery_N = raub_N ; -- status=guess
lin probe_V2 = variants{} ; -- 
lin probe_V = variants{} ; -- 
lin organizational_A = variants{} ; -- 
lin chalk_N = kreide_N ; -- status=guess
lin bourgeois_A = mkA "spießig" ; -- status=guess
lin villager_N = dorfbewohner_N | mkN "Dorfbewohnerin" feminine | mkN "Dörfler" masculine | mkN "Dörflerin" feminine ; -- status=guess status=guess status=guess status=guess
lin morale_N = moral_N ; -- status=guess
lin express_A = mkA "ausdrücklich" ; -- status=guess
lin climb_N = variants{} ; -- 
lin notify_V2 = mkV2 (mitteilen_4_V) | mkV2 (benachrichtigen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin jam_N = mkN "Stau" masculine ; -- status=guess
lin bureaucratic_A = mkA "bürokratisch" ; -- status=guess
lin literacy_N = mkN "Lese- und Schreibfähigkeit" feminine ; -- status=guess
lin frustrate_V2 = mkV2 (mkV "frustrieren") ; -- status=guess, src=wikt
lin freight_N = fracht_N ; -- status=guess
lin clearing_N = mkN "Klärung" feminine | mkN "Aufklärung" feminine ; -- status=guess status=guess
lin aviation_N = mkN "Luftfahrt" feminine ; -- status=guess
lin legislature_N = legislative_N | mkN "gesetzgebende Gewalt" feminine ; -- status=guess status=guess
lin curiously_Adv = variants{} ; -- 
lin banana_N = banane_N ; -- status=guess
lin deploy_V2 = variants{} ; -- 
lin deploy_V = variants{} ; -- 
lin passionate_A = leidenschaftlich_A ; -- status=guess
lin monastery_N = kloster_N ; -- status=guess
lin kettle_N = kessel_N | kochtopf_N ; -- status=guess status=guess
lin enjoyable_A = variants{} ; -- 
lin diagnose_V2 = mkV2 (diagnostizieren_V) ; -- status=guess, src=wikt
lin quantitative_A = quantitativ_A ; -- status=guess
lin distortion_N = mkN "Verzerrung" feminine | mkN "Verformung" feminine | mkN "Verwindung" feminine ; -- status=guess status=guess status=guess
lin monarch_N = monarch_N | mkN "Monarchin" feminine | mkN "Fürst" masculine ; -- status=guess status=guess status=guess
lin kindly_Adv = mkAdv "freundlicherweise" | mkAdv "liebenswürdig" ; -- status=guess status=guess
lin glow_V = mkV "glühen" ; -- status=guess, src=wikt
lin acquaintance_N = mkN "Bekannter" masculine | mkN "Bekannte" feminine ; -- status=guess status=guess
lin unexpectedly_Adv = mkAdv "unerwartet" ; -- status=guess
lin handy_A = anstellig_A | handlich_A | praktisch_A ; -- status=guess status=guess status=guess
lin deprivation_N = variants{} ; -- 
lin attacker_N = angreifer_N | mkN "Angreiferin" feminine ; -- status=guess status=guess
lin assault_V2 = mkV2 (mkV "überfallen") | mkV2 (angreifen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin screening_N = variants{} ; -- 
lin retired_A = variants{} ; -- 
lin quick_Adv = variants{} ; -- 
lin portable_A = portabel_A | tragbar_A ; -- status=guess status=guess
lin hostage_N = geisel_N ; -- status=guess
lin underneath_Prep = variants{} ; -- 
lin jealous_A = mkA "eifersüchtig" ; -- status=guess
lin proportional_A = proportional_A ; -- status=guess
lin gown_N = variants{} ; -- 
lin chimney_N = mkN "Schlot" masculine ; -- status=guess
lin bleak_A = freudlos_A ; -- status=guess
lin seasonal_A = saisonal_A ; -- status=guess
lin plasma_N = mkN "Kielfeld-Beschleuniger" masculine ; -- status=guess
lin stunning_A = variants{} ; -- 
lin spray_N = spray_N ; -- status=guess
lin referral_N = variants{} ; -- 
lin promptly_Adv = variants{} ; -- 
lin fluctuation_N = schwankung_N ; -- status=guess
lin decorative_A = mkA "dekorativ" ; -- status=guess
lin unrest_N = mkN "Unruhen {f} {p}" ; -- status=guess
lin resent_VS = mkVS (mkReflV "ärgern") | mkVS (junkV (mkV "empört") "sein") | mkVS (mkReflV "empören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin resent_V2 = mkV2 (mkReflV "ärgern") | mkV2 (junkV (mkV "empört") "sein") | mkV2 (mkReflV "empören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plaster_N = gips_N | gipsverband_N ; -- status=guess status=guess
lin chew_V2 = mkV2 (kauen_V) ; -- status=guess, src=wikt
lin chew_V = kauen_V ; -- status=guess, src=wikt
lin grouping_N = variants{} ; -- 
lin gospel_N = evangelium_N ; -- status=guess
lin distributor_N = mkN "Verteiler" masculine ; -- status=guess
lin differentiation_N = unterscheidung_N ; -- status=guess
lin blonde_A = variants{} ; -- 
lin aquarium_N = aquarium_N ; -- status=guess
lin witch_N = hexe_N ; -- status=guess
lin renewed_A = variants{} ; -- 
lin jar_N = mkN "Glas" neuter | mkN "Gefäß" neuter ; -- status=guess status=guess
lin approved_A = variants{} ; -- 
lin advocateMasc_N = rechtsanwalt_N | mkN "Rechtsanwältin" feminine ; -- status=guess status=guess
lin worrying_A = variants{} ; -- 
lin minimize_V2 = mkV2 (minimieren_V) ; -- status=guess, src=wikt
lin footstep_N = schritt_N ; -- status=guess
lin delete_V2 = mkV2 (streichen_1_V) | mkV2 (mkV "löschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin underneath_Adv = variants{} ; -- 
lin lone_A = einzeln_A ; -- status=guess
lin level_V2 = mkV2 (ebnen_V) ; -- status=guess, src=wikt
lin level_V = ebnen_V ; -- status=guess, src=wikt
lin exceptionally_Adv = variants{} ; -- 
lin drift_N = mkN "Drift" feminine ; -- status=guess
lin spider_N = spinne_N ; -- status=guess
lin hectare_N = hektar_N ; -- status=guess
lin colonel_N = mkN "Oberst" masculine ; -- status=guess
lin swimming_N = mkN "Schwimmen" neuter ; -- status=guess
lin realism_N = realismus_N ; -- status=guess
lin insider_N = insider_N ; -- status=guess
lin hobby_N = hobby_N | steckenpferd_N ; -- status=guess status=guess
lin computing_N = variants{} ; -- 
lin infrastructure_N = infrastruktur_N ; -- status=guess
lin cooperate_V = zusammenarbeiten_5_V | kooperieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin burn_N = brandwunde_N | verbrennung_N ; -- status=guess status=guess
lin cereal_N = getreide_N ; -- status=guess
lin fold_N = mkN "Faltung" feminine | mkN "Falzung" feminine | mkN "Falten" neuter ; -- status=guess status=guess status=guess
lin compromise_V2 = mkV2 (einen_V) ; -- status=guess, src=wikt
lin compromise_V = einen_V ; -- status=guess, src=wikt
lin boxing_N = mkN "Boxen" neuter ; -- status=guess
lin rear_V2 = mkV2 (aufziehen_2_V) | mkV2 (erziehen_V) | mkV2 (mkV "großziehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rear_V = aufziehen_2_V | erziehen_V | mkV "großziehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lick_V2 = mkV2 (mkV "auslecken") ; -- status=guess, src=wikt
lin constrain_V2 = mkV2 (behindern_V) | mkV2 (mkV "einschränken") | mkV2 (mkV "limitieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin clerical_A = klerikal_A | geistlich_A | mkA "priesterlich" ; -- status=guess status=guess status=guess
lin hire_N = variants{} ; -- 
lin contend_VS = variants{} ; -- 
lin contend_V = variants{} ; -- 
lin amateurMasc_N = amateur_N | mkN "Amateurin" feminine ; -- status=guess status=guess
lin instrumental_A = mkA "instrumental" ; -- status=guess
lin terminal_A = variants{} ; -- 
lin electorate_N = mkN "Kurfürstentum" neuter ; -- status=guess
lin congratulate_V2 = mkV2 (gratulieren_V) | mkV2 (mkV "beglückwünschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin balanced_A = variants{} ; -- 
lin manufacturing_N = variants{} ; -- 
lin split_N = spagat_N | to_do_liste_N ; -- status=guess status=guess
lin domination_N = variants{} ; -- 
lin blink_V2 = mkV2 (zwinkern_V) | mkV2 (junkV (mkV "mit") "den Augen zwinkern") ; -- status=guess, src=wikt status=guess, src=wikt
lin blink_V = zwinkern_V | junkV (mkV "mit") "den Augen zwinkern" ; -- status=guess, src=wikt status=guess, src=wikt
lin bleed_VS = mkVS (junkV (mkV "ausbluten") "lassen") ; -- status=guess, src=wikt
lin bleed_V2 = mkV2 (junkV (mkV "ausbluten") "lassen") ; -- status=guess, src=wikt
lin bleed_V = junkV (mkV "ausbluten") "lassen" ; -- status=guess, src=wikt
lin unlawful_A = gesetzeswidrig_A | gesetzwidrig_A ; -- status=guess status=guess
lin precedent_N = mkN "Präzedens" neuter ; -- status=guess
lin notorious_A = mkA "berüchtigt" ; -- status=guess
lin indoor_A = mkA "Innen-" | mkA "Haus-" ; -- status=guess status=guess
lin upgrade_V2 = variants{} ; -- 
lin trench_N = graben_N ; -- status=guess
lin therapist_N = mkN "Therapeut" masculine ; -- status=guess
lin illuminate_V2 = mkV2 (illuminieren_V) ; -- status=guess, src=wikt
lin bargain_V2 = variants{} ; -- 
lin bargain_V = variants{} ; -- 
lin warranty_N = garantie_N ; -- status=guess
lin scar_V2 = variants{} ; -- 
lin scar_V = variants{} ; -- 
lin consortium_N = konsortium_N ; -- status=guess
lin anger_V2 = mkV2 (mkV "ärgern") ; -- status=guess, src=wikt
lin insure_VS = mkVS (versichern_V) ; -- status=guess, src=wikt
lin insure_V2 = mkV2 (versichern_V) ; -- status=guess, src=wikt
lin insure_V = versichern_V ; -- status=guess, src=wikt
lin extensively_Adv = mkAdv "umfassend" ; -- status=guess
lin appropriately_Adv = variants{} ; -- 
lin spoon_N = mkN "Löffel" masculine ; -- status=guess
lin sideways_Adv = mkAdv "seitlich" ; -- status=guess
lin enhanced_A = mkA "verstärkt" ; -- status=guess
lin disrupt_V2 = mkV2 (junkV (mkV "durcheinander") "bringen") ; -- status=guess, src=wikt
lin disrupt_V = junkV (mkV "durcheinander") "bringen" ; -- status=guess, src=wikt
lin satisfied_A = zufrieden_A | mkA "befriedigt" ; -- status=guess status=guess
lin precaution_N = mkN "Vorsichtsmaßnahme" feminine ; -- status=guess
lin kite_N = milan_N ; -- status=guess
lin instant_N = mkN "löslicher Kaffee" masculine ; -- status=guess
lin gig_N = auftritt_N ; -- status=guess
lin continuously_Adv = mkAdv "ständig" | mkAdv "ununterbrochen" | mkAdv "andauernd" ; -- status=guess status=guess status=guess
lin consolidate_V2 = mkV2 (vereinigen_V) | mkV2 (mkV "zusammenlegen") | mkV2 (mkV "zusammenführen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin consolidate_V = vereinigen_V | mkV "zusammenlegen" | mkV "zusammenführen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fountain_N = springbrunnen_N ; -- status=guess
lin graduate_V2 = mkV2 (absolvieren_V) ; -- status=guess, src=wikt
lin graduate_V = absolvieren_V ; -- status=guess, src=wikt
lin gloom_N = variants{} ; -- 
lin bite_N = biss_N ; -- status=guess
lin structure_V2 = mkV2 (mkV "strukturieren") ; -- status=guess, src=wikt
lin noun_N = substantiv_N | nomen_proprium_N | dingwort_N | gegenstandswort_N ; -- status=guess status=guess status=guess status=guess
lin nomination_N = mkN "Nominierung" feminine ; -- status=guess
lin armchair_N = mkN "Armsessel" masculine | fauteuil_N | mkN "Polstersessel" masculine | mkN "Polsterstuhl" masculine | sessel_N | mkN "Lehnstuhl" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin virtual_A = eigentlich_A | virtuell_A ; -- status=guess status=guess
lin unprecedented_A = beispiellos_A ; -- status=guess
lin tumble_V2 = mkV2 (stolpern_V) ; -- status=guess, src=wikt
lin tumble_V = stolpern_V ; -- status=guess, src=wikt
lin ski_N = mkN "Ski" masculine | mkN "Schi" masculine ; -- status=guess status=guess
lin architectural_A = mkA "architektonisch" ; -- status=guess
lin violation_N = verletzung_N ; -- status=guess
lin rocket_N = rakete_N ; -- status=guess
lin inject_V2 = mkV2 (injizieren_V) | mkV2 (spritzen_9_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin departmental_A = variants{} ; -- 
lin row_V2 = variants{} ; -- 
lin row_V = variants{} ; -- 
lin luxury_A = variants{} ; -- 
lin fax_N = fax_N ; -- status=guess
lin deer_N = mkN "Hirsch" masculine ; -- status=guess
lin climber_N = bergsteiger_N | bergsteigerin_N | mkN "Kletterer" masculine ; -- status=guess status=guess status=guess
lin photographic_A = variants{} ; -- 
lin haunt_V2 = variants{} ; -- 
lin fiercely_Adv = variants{} ; -- 
lin dining_N = mkN "Speisewagen" masculine ; -- status=guess
lin sodium_N = mkN "Natrium" neuter ; -- status=guess
lin gossip_N = klatsch_N | tratsch_N ; -- status=guess status=guess
lin bundle_N = mkN "Bündel" neuter ; -- status=guess
lin bend_N = kurve_N ; -- status=guess
lin recruit_N = rekrut_N ; -- status=guess
lin hen_N = weibchen_N ; -- status=guess
lin fragile_A = fragil_A | mkA "zerbrechlich" ; -- status=guess status=guess
lin deteriorate_V2 = mkV2 (verschlechtern_V) | mkV2 (mkReflV "verschlechtern") ; -- status=guess, src=wikt status=guess, src=wikt
lin deteriorate_V = verschlechtern_V | mkReflV "verschlechtern" ; -- status=guess, src=wikt status=guess, src=wikt
lin dependency_N = kolonie_N | mkN "Schutzgebiet" neuter ; -- status=guess status=guess
lin swift_A = schnell_A ; -- status=guess
lin scramble_V2 = mkV2 (klettern_V) | mkV2 (kraxeln_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin scramble_V = klettern_V | kraxeln_V ; -- status=guess, src=wikt status=guess, src=wikt
lin overview_N = mkN "Übersicht" feminine | mkN "Überblick" masculine ; -- status=guess status=guess
lin imprison_V2 = mkV2 (einsperren_V) | mkV2 (einkerkern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin trolley_N = karren_N | einkaufswagen_N ; -- status=guess status=guess
lin rotation_N = mkN "Umdrehung" feminine ; -- status=guess
lin denial_N = leugnung_N | dementi_N ; -- status=guess status=guess
lin boiler_N = kessel_N | boiler_N ; -- status=guess status=guess
lin amp_N = variants{} ; -- 
lin trivial_A = trivial_A ; -- status=guess
lin shout_N = schrei_N ; -- status=guess
lin overtake_V2 = mkV2 (mkV "überholen") ; -- status=guess, src=wikt
lin make_N = fabrikat_N | marke_N ; -- status=guess status=guess
lin hunter_N = mkN "Jäger" masculine ; -- status=guess
lin guess_N = vermutung_N ; -- status=guess
lin doubtless_Adv = variants{} ; -- 
lin syllable_N = silbe_N ; -- status=guess
lin obscure_A = obskur_A | mkA "düster" | undeutlich_A ; -- status=guess status=guess status=guess
lin mould_N = variants{} ; -- 
lin limestone_N = kalkstein_N ; -- status=guess
lin leak_V2 = mkV2 (mkV "") | mkV2 (junkV (mkV "pipe]") "lecken") | mkV2 (tropfen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin leak_V = mkV "" | junkV (mkV "pipe]") "lecken" | tropfen_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin beneficiary_N = mkN "Nutznießer" masculine ; -- status=guess
lin veteran_N = veteran_N ; -- status=guess
lin surplus_A = variants{} ; -- 
lin manifestation_N = manifestation_N | erscheinung_N ; -- status=guess status=guess
lin vicar_N = vikar_N ; -- status=guess
lin textbook_N = lehrbuch_N ; -- status=guess
lin novelist_N = mkN "Novellist" masculine | mkN "Romancier" masculine ; -- status=guess status=guess
lin halfway_Adv = halbwegs_Adv ; -- status=guess
lin contractual_A = variants{} ; -- 
lin swap_V2 = mkV2 (tauschen_2_V) | mkV2 (austauschen_2_V) | mkV2 (mkV "vertauschen") | mkV2 (wechseln_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin swap_V = tauschen_2_V | austauschen_2_V | mkV "vertauschen" | wechseln_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin guild_N = gilde_N | zunft_N ; -- status=guess status=guess
lin ulcer_N = mkN "Geschwür" neuter | mkN "Ulcus" neuter ; -- status=guess status=guess
lin slab_N = scheibe_N | platte_N ; -- status=guess status=guess
lin detector_N = detektor_N ; -- status=guess
lin detection_N = variants{} ; -- 
lin cough_V = husten_V ; -- status=guess, src=wikt
lin whichever_Quant = variants{} ; -- 
lin spelling_N = orthografie_N | orthographie_N | rechtschreibung_N ; -- status=guess status=guess status=guess
lin lender_N = mkN "Darlehensgeber" masculine | mkN "Verleiher" masculine ; -- status=guess status=guess
lin glow_N = mkN "Glühen" neuter ; -- status=guess
lin raised_A = variants{} ; -- 
lin prolonged_A = variants{} ; -- 
lin voucher_N = gutschein_N ; -- status=guess
lin t_shirt_N = variants{} ; -- 
lin linger_V = mkV "herumlungern" | mkV "verzögern" | junkV (mkV "Zeit") "brauchen" | verweilen_V | bleiben_6_V ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin humble_A = einfach_A | bescheiden_A ; -- status=guess status=guess
lin honey_N = mkN "Honigdachs" masculine ; -- status=guess
lin scream_N = aufschrei_N | mkN "{n}" ; -- status=guess status=guess
lin postcard_N = postkarte_N ; -- status=guess
lin managing_A = variants{} ; -- 
lin alien_A = fremd_A | mkA "fremdartig" ; -- status=guess status=guess
lin trouble_V2 = mkV2 (beunruhigen_V) | mkV2 (mkV "belästigen") | mkV2 (mkV "bekümmern") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reverse_N = mkN "Rückwärtsgang" masculine ; -- status=guess
lin odour_N = geruch_N ; -- status=guess
lin fundamentally_Adv = variants{} ; -- 
lin discount_V2 = variants{} ; -- 
lin discount_V = variants{} ; -- 
lin blast_V2 = variants{} ; -- 
lin blast_V = variants{} ; -- 
lin syntactic_A = variants{} ; -- 
lin scrape_V2 = mkV2 (abkratzen_V) | mkV2 (kratzen_6_V) | mkV2 (schaben_V) | mkV2 (scharren_V) | mkV2 (mkV "schrammen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin scrape_V = abkratzen_V | kratzen_6_V | schaben_V | scharren_V | mkV "schrammen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin residue_N = variants{} ; -- 
lin procession_N = prozession_N | umzug_N ; -- status=guess status=guess
lin pioneer_N = pionier_N ; -- status=guess
lin intercourse_N = mkN "Beziehungen {f} {p}" | umgang_N | verkehr_N ; -- status=guess status=guess status=guess
lin deter_V2 = mkV2 (abhalten_V) | mkV2 (verhindern_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin deadly_A = mkA "tödlich" ; -- status=guess
lin complement_V2 = mkV2 (mkV "ergänzen") ; -- status=guess, src=wikt
lin restrictive_A = mkA "einschränkend" | restriktiv_A ; -- status=guess status=guess
lin nitrogen_N = mkN "Stickstoff" masculine ; -- status=guess
lin citizenship_N = mkN "Staatsbürgerschaft" feminine | mkN "Staatsangehörigkeit" feminine ; -- status=guess status=guess
lin pedestrian_N = mkN "Fußgänger" masculine | mkN "Fußgängerin" feminine | mkN "Fußgeher" masculine | mkN "Fußgeherin" feminine | passant_N | mkN "Passantin" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin detention_N = mkN "Nachsitzen" neuter ; -- status=guess
lin wagon_N = mkN "Wagen" ; -- status=guess
lin microphone_N = mikrofon_N ; -- status=guess
lin hastily_Adv = mkAdv "hastig" ; -- status=guess
lin fixture_N = fassung_N ; -- status=guess
lin choke_V2 = mkV2 (ersticken_V) ; -- status=guess, src=wikt
lin choke_V = ersticken_V ; -- status=guess, src=wikt
lin wet_V2 = mkV2 (junkV (mkV "nass") "werden") ; -- status=guess, src=wikt
lin weed_N = mkN "Glimmstängel" masculine | kippe_N ; -- status=guess status=guess
lin programming_N = mkN "Programmierung" feminine | mkN "Programmieren" neuter ; -- status=guess status=guess
lin power_V2 = variants{} ; -- 
lin nationally_Adv = variants{} ; -- 
lin dozen_N = mkN "Dutzende" ; -- status=guess
lin carrot_N = mkN "Möhre" feminine | mkN "Mohrrübe" feminine | karotte_N ; -- status=guess status=guess status=guess
lin bulletin_N = mkN "Mitteilungsblatt" neuter | bulletin_N ; -- status=guess status=guess
lin wording_N = formulierung_N ; -- status=guess
lin vicious_A = mkA "unmoralisch" ; -- status=guess
lin urgency_N = mkN "Dringlichkeit" feminine ; -- status=guess
lin spoken_A = variants{} ; -- 
lin skeleton_N = rohbau_N ; -- status=guess
lin motorist_N = variants{} ; -- 
lin interactive_A = interaktiv_A ; -- status=guess
lin compute_V2 = mkV2 (berechnen_V) ; -- status=guess, src=wikt
lin compute_V = berechnen_V ; -- status=guess, src=wikt
lin whip_N = peitsche_N ; -- status=guess
lin urgently_Adv = variants{} ; -- 
lin telly_N = glotze_N | fernseher_N ; -- status=guess status=guess
lin shrub_N = busch_N | strauch_N ; -- status=guess status=guess
lin porter_N = mkN "Gepäckträger" masculine ; -- status=guess
lin ethics_N = mkN "Verhaltenskodex" masculine | ethik_N ; -- status=guess status=guess
lin banner_N = banner_N ; -- status=guess
lin velvet_N = samt_N ; -- status=guess
lin omission_N = mkN "Unterlassung" feminine ; -- status=guess
lin hook_V2 = mkV2 (haken_1_V) ; -- status=guess, src=wikt
lin hook_V = haken_1_V ; -- status=guess, src=wikt
lin gallon_N = mkN "Gallone" feminine ; -- status=guess
lin financially_Adv = variants{} ; -- 
lin superintendent_N = leiter_N ; -- status=guess
lin plug_V2 = variants{} ; -- 
lin plug_V = variants{} ; -- 
lin continuation_N = fortsetzung_N ; -- status=guess
lin reliance_N = variants{} ; -- 
lin justified_A = mkA "gerechtfertigt" ; -- status=guess
lin fool_V2 = mkV2 (mkV "täuschen") | mkV2 (schwindeln_V) | mkV2 (mkV "betrügen") | mkV2 (verarschen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin detain_V2 = mkV2 (verhaften_V) ; -- status=guess, src=wikt
lin damaging_A = variants{} ; -- 
lin orbit_N = mkN "Umlaufbahn" feminine | orbit_N ; -- status=guess status=guess
lin mains_N = mkN "Stromnetz" neuter ; -- status=guess
lin discard_V2 = mkV2 (verwerfen_V) ; -- status=guess, src=wikt
lin dine_V = speisen_7_V ; -- status=guess, src=wikt
lin compartment_N = abteil_N ; -- status=guess
lin revised_A = variants{} ; -- 
lin privatization_N = privatisierung_N ; -- status=guess
lin memorable_A = variants{} ; -- 
lin lately_Adv = variants{} ; -- 
lin distributed_A = variants{} ; -- 
lin disperse_V2 = variants{} ; -- 
lin disperse_V = variants{} ; -- 
lin blame_N = schuld_N ; -- status=guess
lin basement_N = keller_N | untergeschoss_N ; -- status=guess status=guess
lin slump_V2 = variants{} ; -- 
lin slump_V = variants{} ; -- 
lin puzzle_V2 = variants{} ; -- 
lin monitoring_N = mkN "Überwachung" feminine ; -- status=guess
lin talented_A = begabt_A | talentiert_A ; -- status=guess status=guess
lin nominal_A = variants{} ; -- 
lin mushroom_N = mkN "Atompilz" masculine | pilzwolke_N | rauchpilz_N ; -- status=guess status=guess status=guess
lin instructor_N = ausbilder_N | lehrer_schwa_N ; -- status=guess status=guess
lin fork_N = gabel_N ; -- status=guess
lin fork_4_N = variants{} ; -- 
lin fork_3_N = variants{} ; -- 
lin fork_1_N = variants{} ; -- 
lin board_V2 = mkV2 (entern_V) ; -- status=guess, src=wikt
lin want_N = not_N ; -- status=guess
lin disposition_N = einteilung_N | gliederung_N | anordnung_N ; -- status=guess status=guess status=guess
lin cemetery_N = variants{} ; -- 
lin attempted_A = variants{} ; -- 
lin nephew_N = neffe_N ; -- status=guess
lin magical_A = variants{} ; -- 
lin ivory_N = mkN "Elfenbein" neuter ; -- status=guess
lin hospitality_N = mkN "Gastfreundlichkeit" feminine | gastfreundschaft__N | mkN "Gastlichkeit" feminine ; -- status=guess status=guess status=guess
lin besides_Prep = variants{} ; -- 
lin astonishing_A = mkA "verwunderlich" ; -- status=guess
lin tract_N = mkN "Traktat" neuter ; -- status=guess
lin proprietor_N = besitzer_N | inhaber_N ; -- status=guess status=guess
lin license_V2 = mkV2 (lizenzieren_V) ; -- status=guess, src=wikt
lin differential_A = variants{} ; -- 
lin affinity_N = variants{} ; -- 
lin talking_N = variants{} ; -- 
lin royalty_N = mkN "Nutzungsgebühr" feminine ; -- status=guess
lin neglect_N = mkN "Vernachlässigung" feminine ; -- status=guess
lin irrespective_A = mkA "ungeachtet" | mkA "ohne Berücksichtigung" | mkA "unabhängig von" ; -- status=guess status=guess status=guess
lin whip_V2 = mkV2 (mkV "peitschen") ; -- status=guess, src=wikt
lin whip_V = mkV "peitschen" ; -- status=guess, src=wikt
lin sticky_A = variants{} ; -- 
lin regret_N = mkN "Reue" feminine ; -- status=guess
lin incapable_A = variants{} ; -- 
lin franchise_N = mkN "Franchise" ; -- status=guess
lin dentist_N = zahnarzt_N | mkN "Zahnärztin" feminine ; -- status=guess status=guess
lin contrary_N = variants{} ; -- 
lin profitability_N = variants{} ; -- 
lin enthusiast_N = variants{} ; -- 
lin crop_V2 = mkV2 (mkV "ausschneiden") ; -- status=guess, src=wikt
lin crop_V = mkV "ausschneiden" ; -- status=guess, src=wikt
lin utter_V2 = mkV2 (mkV "ausstoßen") ; -- status=guess, src=wikt
lin pile_V2 = mkV2 (stapeln_V) | mkV2 (mkV "aufstapeln") | mkV2 (mkV "anhäufen") | mkV2 (mkV "schichten") | mkV2 (mkV "") | mkV2 (junkV (mkV "Swiss]") "beigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pile_V = stapeln_V | mkV "aufstapeln" | mkV "anhäufen" | mkV "schichten" | mkV "" | junkV (mkV "Swiss]") "beigen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pier_N = pier_N | mkN "Anlegestelle" feminine ; -- status=guess status=guess
lin dome_N = kuppel_N | schild_N ; -- status=guess status=guess
lin bubble_N = blase_N ; -- status=guess
lin treasurer_N = finanzminister_N ; -- status=guess
lin stocking_N = strumpf_N ; -- status=guess
lin sanctuary_N = variants{} ; -- 
lin ascertain_V2 = mkV2 (feststellen_6_V) ; -- status=guess, src=wikt
lin arc_N = mkN "Bogen" masculine | kurve_N ; -- status=guess status=guess
lin quest_N = suche_N | mkN "Queste" feminine ; -- status=guess status=guess
lin mole_N = maulwurf_N ; -- status=guess
lin marathon_N = marathon_N ; -- status=guess
lin feast_N = festmahl_N ; -- status=guess
lin crouch_V = kauern_V ; -- status=guess, src=wikt
lin storm_V2 = mkV2 (mkV "stürmen") ; -- status=guess, src=wikt
lin storm_V = mkV "stürmen" ; -- status=guess, src=wikt
lin hardship_N = mkN "Härte" feminine | not_N ; -- status=guess status=guess
lin entitlement_N = anspruch_N ; -- status=guess
lin circular_N = mkN "Kreisbogen" masculine ; -- status=guess
lin walking_A = variants{} ; -- 
lin strap_N = mkN "Achselklappe" feminine ; -- status=guess
lin sore_A = wund_A | mkA "weh" | schlimm_A | mkA "entzündet" ; -- status=guess status=guess status=guess status=guess
lin complementary_A = variants{} ; -- 
lin understandable_A = mkA "verständlich" ; -- status=guess
lin noticeable_A = mkA "wahrnehmbar" ; -- status=guess
lin mankind_N = mkN "Menschheit" feminine ; -- status=guess
lin majesty_N = mkN "Majestät" feminine ; -- status=guess
lin pigeon_N = taube_N | mkN "" | tauber_N | mkN "Täuber" masculine | mkN "Tauberich" masculine | mkN "Täuberich" masculine | mkN "Täubin" feminine | mkN "Täubchen" neuter | mkN "Täublein" neuter | mkN "Kolumbide" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin goalkeeper_N = torwart_N | mkN "Torwartin" feminine | mkN "Torhüter" masculine | mkN "Torhüterin" feminine | tormann_N ; -- status=guess status=guess status=guess status=guess status=guess
lin ambiguous_A = mehrdeutig_A | mkA "doppeldeutig" ; -- status=guess status=guess
lin walker_N = variants{} ; -- 
lin virgin_N = jungfrau_N ; -- status=guess
lin prestige_N = mkN "Prestige" neuter ; -- status=guess
lin preoccupation_N = variants{} ; -- 
lin upset_A = variants{} ; -- 
lin municipal_A = munizipal_A ; -- status=guess
lin groan_V2 = mkV2 (mkV "ächzen") | mkV2 (mkV "stöhnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin groan_V = mkV "ächzen" | mkV "stöhnen" ; -- status=guess, src=wikt status=guess, src=wikt
lin craftsman_N = handwerker_N ; -- status=guess
lin anticipation_N = variants{} ; -- 
lin revise_V2 = mkV2 (wiederholen_V) ; -- status=guess, src=wikt
lin revise_V = wiederholen_V ; -- status=guess, src=wikt
lin knock_N = mkN "Klopfen" neuter ; -- status=guess
lin infect_V2 = mkV2 (anstecken_3_V) | mkV2 (infizieren_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin infect_V = anstecken_3_V | infizieren_V ; -- status=guess, src=wikt status=guess, src=wikt
lin denounce_V2 = mkV2 (mkV "kündigen") ; -- status=guess, src=wikt
lin confession_N = beichte_N ; -- status=guess
lin turkey_N = truthahn_N | mkN "Truthenne" feminine | mkN "Puter" masculine | pute_N ; -- status=guess status=guess status=guess status=guess
lin toll_N = abgabe_N | maut_N | mkN "tunnels" | mkN "etc.]" ; -- status=guess status=guess status=guess status=guess
lin pal_N = variants{} ; -- 
lin transcription_N = transkription_N ; -- status=guess
lin sulphur_N = variants{} ; -- 
lin provisional_A = provisorisch_A ; -- status=guess
lin hug_V2 = mkV2 (mkReflV "umarmen") ; -- status=guess, src=wikt
lin particular_N = variants{} ; -- 
lin intent_A = variants{} ; -- 
lin fascinate_V2 = mkV2 (faszinieren_V) | mkV2 (mkV "bezaubern") ; -- status=guess, src=wikt status=guess, src=wikt
lin conductor_N = dirigent_N ; -- status=guess
lin feasible_A = mkA "durchführbar" | machbar_A ; -- status=guess status=guess
lin vacant_A = frei_A | vakant_A ; -- status=guess status=guess
lin trait_N = eigenschaft_N ; -- status=guess
lin meadow_N = wiese_N | weide_N ; -- status=guess status=guess
lin creed_N = glaubensbekenntnis_N ; -- status=guess
lin unfamiliar_A = unbekannt_A | mkA "unvertraut" ; -- status=guess status=guess
lin optimism_N = mkN "Optimismus" masculine | zuversicht_N ; -- status=guess status=guess
lin wary_A = achtsam_A | mkA "umsichtig" | vorsichtig_A | wachsam_A ; -- status=guess status=guess status=guess status=guess
lin twist_N = bohrer_N ; -- status=guess
lin sweet_N = mkN "Süßigkeit" feminine ; -- status=guess
lin substantive_A = variants{} ; -- 
lin excavation_N = mkN "Grabung" feminine | ausgrabung_N ; -- status=guess status=guess
lin destiny_N = schicksal_N | los_N ; -- status=guess status=guess
lin thick_Adv = variants{} ; -- 
lin pasture_N = weide_N ; -- status=guess
lin archaeological_A = mkA "archäologisch" ; -- status=guess
lin tick_V2 = mkV2 (ticken_V) ; -- status=guess, src=wikt
lin tick_V = ticken_V ; -- status=guess, src=wikt
lin profit_V2 = mkV2 (profitieren_V) ; -- status=guess, src=wikt
lin profit_V = profitieren_V ; -- status=guess, src=wikt
lin pat_V2 = mkV2 (mkV "tätscheln") ; -- status=guess, src=wikt
lin pat_V = mkV "tätscheln" ; -- status=guess, src=wikt
lin papal_A = mkA "päpstlich" ; -- status=guess
lin cultivate_V2 = mkV2 (kultivieren_V) | mkV2 (anbauen_8_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin awake_V = aufwecken_V ; -- status=guess, src=wikt
lin trained_A = variants{} ; -- 
lin civic_A = mkA "bürgerlich" ; -- status=guess
lin voyage_N = reise_N ; -- status=guess
lin siege_N = belagerung_N ; -- status=guess
lin enormously_Adv = variants{} ; -- 
lin distract_V2 = mkV2 (ablenken_V) ; -- status=guess, src=wikt
lin distract_V = ablenken_V ; -- status=guess, src=wikt
lin stroll_V = spazieren_V | bummeln_8_V ; -- status=guess, src=wikt status=guess, src=wikt
lin jewel_N = mkN "Juwel {n}" masculine | mkN "Kleinod" neuter ; -- status=guess status=guess
lin honourable_A = variants{} ; -- 
lin helpless_A = mkA "hilflos" ; -- status=guess
lin hay_N = mkN "Heu" neuter ; -- status=guess
lin expel_V2 = mkV2 (abschieben_V) | mkV2 (deportieren_V) | mkV2 (verbannen_V) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin eternal_A = ewig_A ; -- status=guess
lin demonstrator_N = demonstrant_N | mkN "Demonstrantin" feminine ; -- status=guess status=guess
lin correction_N = korrektur_N | berichtigung_N | verbesserung_N ; -- status=guess status=guess status=guess
lin civilization_N = mkN "zivilisiert adj." ; -- status=guess
lin ample_A = mkA "üppig" ; -- status=guess
lin retention_N = mkN "Behalten" neuter ; -- status=guess
lin rehabilitation_N = rehabilitation_N ; -- status=guess
lin premature_A = variants{} ; -- 
lin encompass_V2 = mkV2 (umfassen_V) ; -- status=guess, src=wikt
lin distinctly_Adv = mkAdv "deutlich" ; -- status=guess
lin diplomat_N = diplomat_N ; -- status=guess
lin articulate_V2 = mkV2 (betonen_V) ; -- status=guess, src=wikt
lin articulate_V = betonen_V ; -- status=guess, src=wikt
lin restricted_A = begrenzt_A ; -- status=guess
lin prop_V2 = variants{} ; -- 
lin intensify_V2 = variants{} ; -- 
lin intensify_V = variants{} ; -- 
lin deviation_N = abweichung_N ; -- status=guess
lin contest_V2 = variants{} ; -- 
lin contest_V = variants{} ; -- 
lin workplace_N = arbeitsplatz_N ; -- status=guess
lin lazy_A = faul_A ; -- status=guess
lin kidney_N = niere_N ; -- status=guess
lin insistence_N = variants{} ; -- 
lin whisper_N = mkN "Geflüster" neuter | mkN "Flüstern" neuter | mkN "Wispern" neuter ; -- status=guess status=guess status=guess
lin multimedia_N = multimedia_card_N ; -- status=guess
lin forestry_N = mkN "Forstwirtschaft" feminine ; -- status=guess
lin excited_A = aufgeregt_A ; -- status=guess
lin decay_N = mkN "Verfall" masculine | mkN "Verwesung" feminine ; -- status=guess status=guess
lin screw_N = mkN "Schraubverschluss" masculine | mkN "Schraubdeckel" masculine ; -- status=guess status=guess
lin rally_V2V = variants{} ; -- 
lin rally_V2 = variants{} ; -- 
lin rally_V = variants{} ; -- 
lin pest_N = variants{} ; -- 
lin invaluable_A = variants{} ; -- 
lin homework_N = mkN "Hausaufgaben {p}" ; -- status=guess
lin harmful_A = mkA "schädlich" ; -- status=guess
lin bump_V2 = variants{} ; -- 
lin bump_V = variants{} ; -- 
lin bodily_A = variants{} ; -- 
lin grasp_N = griff_N ; -- status=guess
lin finished_A = variants{} ; -- 
lin facade_N = fassade_N ; -- status=guess
lin cushion_N = puffer_N | mkN "Polster" neuter ; -- status=guess status=guess
lin conversely_Adv = variants{} ; -- 
lin urge_N = drang_N ; -- status=guess
lin tune_V2 = mkV2 (stimmen_3_V) ; -- status=guess, src=wikt
lin tune_V = stimmen_3_V ; -- status=guess, src=wikt
lin solvent_N = mkN "Lösemittel" | mkN "Lösungsmittel" neuter ; -- status=guess status=guess
lin slogan_N = slogan_N | mkN "Motto" neuter | spruch_N | losung_N ; -- status=guess status=guess status=guess status=guess
lin petty_A = klein_A | gering_A | unbedeutend_A ; -- status=guess status=guess status=guess
lin perceived_A = variants{} ; -- 
lin install_V2 = mkV2 (installieren_V) ; -- status=guess, src=wikt
lin install_V = installieren_V ; -- status=guess, src=wikt
lin fuss_N = mkN "Lärm" masculine | wirbel_N | aufstand_N ; -- status=guess status=guess status=guess
lin rack_N = mkN "Regal" neuter ; -- status=guess
lin imminent_A = mkA "bevorstehend" ; -- status=guess
lin short_N = kurzschluss_N ; -- status=guess
lin revert_V = variants{} ; -- 
lin ram_N = mkN "Schmetterlingsbuntbarsch" masculine ; -- status=guess
lin contraction_N = verkleinerung_N | kontraktion_N ; -- status=guess status=guess
lin tread_V2 = mkV2 (betreten_V) | mkV2 (treten_7_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin tread_V = betreten_V | treten_7_V ; -- status=guess, src=wikt status=guess, src=wikt
lin supplementary_A = mkA "zusätzlich" ; -- status=guess
lin ham_N = schinken_N ; -- status=guess
lin defy_V2V = mkV2V (mkV "herausfordern") ; -- status=guess, src=wikt
lin defy_V2 = mkV2 (mkV "herausfordern") ; -- status=guess, src=wikt
lin athlete_N = mkN "Athlet{f}" ; -- status=guess
lin sociological_A = mkA "soziologisch" ; -- status=guess
lin physician_N = arzt_N | mkN "Ärztin" feminine ; -- status=guess status=guess
lin crossing_N = kreuzung_N ; -- status=guess
lin bail_N = kaution_N ; -- status=guess
lin unwanted_A = mkA "unerwünscht" | mkA "ungewollt" ; -- status=guess status=guess
lin tight_Adv = variants{} ; -- 
lin plausible_A = variants{} ; -- 
lin midfield_N = variants{} ; -- 
lin alert_A = aufmerksam_A | wachsam_A ; -- status=guess status=guess
lin feminine_A = feminin_A | weiblich_A ; -- status=guess status=guess
lin drainage_N = mkN "Drainage" feminine ; -- status=guess
lin cruelty_N = grausamkeit_N | mkN "Quälerei" feminine ; -- status=guess status=guess
lin abnormal_A = mkA "unnormal" | mkA "ungewöhnlich" ; -- status=guess status=guess
lin relate_N = variants{} ; -- 
lin poison_V2 = mkV2 (vergiften_V) ; -- status=guess, src=wikt
lin symmetry_N = symmetrie_N ; -- status=guess
lin stake_V2 = mkV2 (mkV "anpflocken") | mkV2 (anbinden_V) | mkV2 (mkV "hochbinden") | mkV2 (mkV "pfählen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rotten_A = L.rotten_A ;
lin prone_A = mkA "schräg" ; -- status=guess
lin marsh_N = moor_N | sumpf_N | marsch_N ; -- status=guess status=guess status=guess
lin litigation_N = rechtsstreit_N ; -- status=guess
lin curl_N = locke_N ; -- status=guess
lin urine_N = urin_N | harn_N ; -- status=guess status=guess
lin latin_A = variants{} ; -- 
lin hover_V = schweben_V ; -- status=guess, src=wikt
lin greeting_N = mkN "Gruß" masculine | mkN "Begrüßung" feminine ; -- status=guess status=guess
lin chase_N = verfolgung_N | jagd_N ; -- status=guess status=guess
lin spouseMasc_N = gatte_N | gattin_N | ehepartner_N | ehepartnerin_N ; -- status=guess status=guess status=guess status=guess
lin produce_N = mkN "Obst und Gemüse" ; -- status=guess
lin forge_V2 = mkV2 (mkV "fälschen") ; -- status=guess, src=wikt
lin forge_V = mkV "fälschen" ; -- status=guess, src=wikt
lin salon_N = salon__N ; -- status=guess
lin handicapped_A = behindert_A ; -- status=guess
lin sway_V2 = mkV2 (beeinflussen_V) ; -- status=guess, src=wikt
lin sway_V = beeinflussen_V ; -- status=guess, src=wikt
lin homosexual_A = homosexuell_A ; -- status=guess
lin handicap_V2 = variants{} ; -- 
lin colon_N = mkN "Kolon" neuter | grimmdarm_N ; -- status=guess status=guess
lin upstairs_N = variants{} ; -- 
lin stimulation_N = stimulation_N | anregung_N ; -- status=guess status=guess
lin spray_V2 = mkV2 (mkV "versprühen") | mkV2 (mkV "zerstäuben") ; -- status=guess, src=wikt status=guess, src=wikt
lin original_N = original_N | mkN "Urschrift" feminine ; -- status=guess status=guess
lin lay_A = mkA "Laien-" | laikal_A ; -- status=guess status=guess
lin garlic_N = mkN "Knoblauch" masculine ; -- status=guess
lin suitcase_N = koffer_N ; -- status=guess
lin skipper_N = mkN "Kapitän" masculine | mkN "Teamkapitän" | mkN "Teamchef" masculine ; -- status=guess status=guess status=guess
lin moan_VS = mkVS (mkV "stöhnen") ; -- status=guess, src=wikt
lin moan_V = mkV "stöhnen" ; -- status=guess, src=wikt
lin manpower_N = variants{} ; -- 
lin manifest_V2 = mkV2 (manifestieren_V) ; -- status=guess, src=wikt
lin incredibly_Adv = variants{} ; -- 
lin historically_Adv = variants{} ; -- 
lin decision_making_N = variants{} ; -- 
lin wildly_Adv = variants{} ; -- 
lin reformer_N = reformer_N ; -- status=guess
lin quantum_N = mkN "Quantencomputer" masculine ; -- status=guess
lin considering_Subj = variants{} ; -- 
}
