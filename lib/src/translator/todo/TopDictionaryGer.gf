--# -path=.:../chunk:alltenses:../german
---- edited by SS till cold_A and some in the 100 underneath

concrete TopDictionaryGer of TopDictionary = CatGer ** 
  open 
    ParadigmsGer, (S = SyntaxGer), (L = LexiconGer),
    (R = ResGer), (M = MorphoGer), (MS = MakeStructuralGer), (I = IrregGer), Prelude in {

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
lin time_N = variants{} ; -- 
lin time_2_N = reg2N "Mal" "Male" neuter ;
lin time_1_N = mkN "Zeit" "Zeiten" feminine ;
lin take_V2 = mkV2 (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen") ;
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
lin last_A = variants{} ; -- 
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
lin way_N = variants{} ; -- 
lin way_2_N = mkN "Weise" ;
lin way_1_N = mkN "Weg" ;
lin look_VA = mkVA (mkV "aus" I.sehen_V) ;
lin look_V2 = mkV2 (prefixV "an" (mkV "schauen")) ;
lin look_V = mkV "schauen" ;
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
lin down_Adv = mkAdv "hinunter" ;
lin yeah_Interj = ss "jawohl" ;
lin so_Subj = ss "so dass" ;
lin thing_N = mkN "Sache" | mkN "Ding" "Dinge" neuter ;
lin tell_VS = mkVS (no_geV (mkV "erzählen")) ;
lin tell_V3 = mkV3 (fixprefixV "er" (mkV "zählen")) ; ---- delete, sense is split!
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
lin work_V = variants{}; -- mkV2 (no_geV (mkV "bearbeiten")) ;
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
lin part_N = reg2N "Rolle" "Rollen" feminine ; -- comment=split: Teil (teil_N)
lin leave_V2V = mkV2V I.lassen_V ;
lin leave_V2 = L.leave_V2 ;
lin leave_V = seinV (mkV "ab" I.fahren_V) | I.gehen_V; -- comment=split: train leaving = abfahren; human leaving = gehen
lin life_N = reg2N "Leben" "Leben" neuter ;
lin great_A = mkA "großartig" | mk3A "groß" "größer" "größte" ; ---- split: great day (großartig) / great king (groß)
lin case_N = mkN "Fall" "Fälle" masculine | reg2N "Behälter" "Behälter" masculine ; -- comment=split
lin woman_N = L.woman_N ;
lin over_Adv = mkAdv "vorbei" ; -- comment=split
lin seem_VV = mkVV I.scheinen_V ;
lin seem_VS = mkVS I.scheinen_V ;
lin seem_VA = mkVA (mkV "aus" I.sehen_V) ;
lin work_N = reg2N "Arbeit" "Arbeiten" feminine ;
lin need_VV = mkVV I.müssen_V ;
lin need_VV = mkVV I.müssen_V ;
lin need_V2 = mkV2 (mkV "brauchen") ;
lin need_V = mkV "brauchen" ; ---- delete
lin feel_VS = mkVS (irregV "denken" "denkt" "dachte" "dächte" "gedacht") ;
lin feel_VA = reflV (mkV "fühlen") accusative ;
lin feel_V2 = mkV2 "fühlen" ;
lin feel_V = mkV "fühlen" ;
lin system_N = reg2N "System" "Systeme" neuter ;
lin each_Det = S.every_Det ;
lin may_2_VV = mkVV I.dürfen_V ;
lin may_1_VV = mkVV I.können_V ; -- comment= no direct translation; e.g. I MAY be able to help you = ich kann dir VIELLEICHT helfen
lin much_Adv = mkAdv "viel" ;
lin ask_VQ = mkVQ (mkV "fragen") ;
lin ask_V2V = mkV2V I.bitten_V ;
lin ask_V2 = mkV2 I.bitten_V ;
lin ask_V = I.bitten_V ;
lin group_N = reg2N "Gruppe" "Gruppen" feminine ;
lin number_N = variants{} ; -- 
lin number_3_N = mkN "Numerus" "Numerus" "Numerus" "Numerus" "Numeri" "Numeri" masculine ;
lin number_2_N = mkN "Anzahl" "Anzahlen" feminine ;
lin number_1_N = mkN "Zahl" "Zahlen" feminine ;
lin yes_Interj = ss "ja" ;
lin however_Adv = mkAdv "wie auch immer" | mkAdv "jedoch" ;
lin another_Det = M.detLikeAdj False M.Sg "ander" ;
lin again_Adv = mkAdv "wieder" ;
lin world_N = reg2N "Welt" "Welten" feminine ;
lin area_N = variants{} ; -- 
lin area_6_N = mkN "Fläche" feminine ;
lin area_5_N = mkN "Bereich" ;
lin area_4_N = mkN "Bereich" ;
lin area_3_N = mkN "Bereich" ;
lin area_2_N = mkN "Bereich" ;
lin area_1_N = mkN "Gebiet" "Gebiet" "Gebiet" "Gebiets" "Gebiete" "Gebieten" neuter | mkN "Gegend" feminine ;
lin show_VS = mkVS (regV "zeigen") ;
lin show_VQ = mkVQ (regV "zeigen") ;
lin show_V2 = dirV2 (regV "zeigen"); -- comment=subcat; V3 in German; I can show you = ich kann ES dir zeigen
lin show_V = regV "zeigen" ;
lin course_N = reg2N "Bahn" "Bahnen" feminine | mkN "Kurs" ; --- split: course of the moon = Bahn; language course = Kurs
lin company_2_N = reg2N "Gesellschaft" "Gesellschaften" feminine;
lin company_1_N = reg2N "Firma" "Firmen" feminine ;
lin under_Prep = mkPrep "unter" dative | mkPrep "unter" accusative ; --- split: ich stehe unter der Brücke (dat) ; ich gehe unter die Brücke (acc)
lin problem_N = reg2N "Problem" "Probleme" neuter ;
lin against_Prep = mkPrep "gegen" accusative ;
lin never_Adv = mkAdv "nie" ;
lin most_Adv = mkAdv "meistens" ; ---- cat am meisten?
lin service_N = reg2N "Dienst" "Dienste" masculine | mkN "Dienstleistung" ;
lin try_VV = mkVV (fixprefixV "ver" (mkV "suchen")) ;
lin try_V2 = mkV2 (mkV "kosten") ;
lin try_V = fixprefixV "ver" (mkV "suchen") ; --cat = V2?: I tried = ich habe ES versucht.
lin call_V2 = mkV2 (prefixV "an" I.rufen_V) | mkV2 I.rufen_V ; --- split: call on the phone; call out a name
lin call_V = prefixV "an" I.rufen_V ;
lin hand_N = L.hand_N ;
lin party_N = variants{} ; -- 
lin party_2_N = mkN "Partei" "Partei" "Partei" "Partei" "Parteien" "Parteien" feminine ;
lin party_1_N = mkN "Fest" "Fest" "Fest" "Festes" "Feste" "Festen" neuter | reg2N "Feier" "Feiern" feminine ;
lin high_A = mkA "hoch" "hoh" "höher" "höchste";
lin about_Adv = mkAdv "ungefähr" ; -- status=guess
lin something_NP = S.something_NP ;
lin school_N = L.school_N ;
lin in_Adv = variants{}; -- S.in_Prep ;
lin in_1_Adv = mkAdv "drinnen" ;
lin in_2_Adv = mkAdv "hinein" ;
lin small_A = L.small_A ;
lin place_N = mkN "Ort" | mkN "Platz" "Platz" "Platz" "Platzes" "Plätze" "Plätzen" masculine ;
lin before_Prep = S.before_Prep ;
lin while_Subj = ss "während" ;
lin away_Adv = variants{} ; -- 
lin away_2_Adv = mkAdv "weg" ;
lin away_1_Adv = mkAdv "weg" ;
lin keep_VV = mkVV (fixprefixV "wieder" (mkV "holen")) ; -- cat: to KEEP doing something = ich mache etwas STÄNDIG
lin keep_V2A = mkV2A I.halten_V ;
lin keep_V2 = mkV2 (irregV "behalten" "behält" "behielt" "behielte" "behalten") ;
lin keep_V = I.halten_V ; --- delete: false extraction
lin point_N = variants{} ; -- 
lin point_2_N = mkN "Punkt" ;
lin point_1_N = mkN "Punkt" ;
lin house_N = L.house_N ;
lin different_A = mkA "verschieden" ;
lin country_N = L.country_N ;
lin really_Adv = mkAdv "wirklich" ; -- status=guess
lin provide_V2 = mkV2 (prefixV "bereit" (mkV "stellen")) ;
lin provide_V = fixprefixV "ver" (mkV "sorgen") ;
lin week_N = mkN "Woche" ;
lin hold_VS = mkVS (mkV "meinen") ;
lin hold_V2 = L.hold_V2 ;
lin hold_V = L.hold_V2 ; --- delete: false extraction
lin large_A = mk3A "groß" "größer" "größte" | mkA "weit" ; --- split: large dog (groß); large area (weit)
lin member_N = mkN "Mitglied" "Mitglied" "Mitglied" "Mitglieds" "Mitglieder" "Mitglieder" neuter ;
lin off_Adv = mkAdv "weg" | mkAdv "davon" ;
lin always_Adv = S.always_AdV ;
lin follow_VS = mkVS (mkV "folgern") ;
lin follow_V2 = mkV2 (mkV "folgen") ;
lin follow_V = mkV "folgen" ;
lin without_Prep = S.without_Prep ;
lin turn_VA = mkVA I.werden_V ;
lin turn_V2 = mkV2 L.turn_V ;
lin turn_V = L.turn_V ;
lin end_N = variants{} ; -- 
lin end_2_N = mkN "Seite" ;
lin end_1_N = mkN "Ende" "Ende" "Ende" "Endes" "Enden" "Enden";
lin within_Prep = mkPrep "innerhalb" genitive ;
lin local_A = mkA "lokal" | mkA "örtlich" ;
lin where_Subj = ss "wo" ;
lin during_Prep = S.during_Prep ;
lin bring_V3 = mkV3 I.bringen_V ;
lin bring_V2 = mkV2 I.bringen_V ;
lin most_Det = M.detLikeAdj False M.Pl "meist" ;
lin word_N = mkN "Wort" "Wörter" neuter | mkN "Wort" "Worte" neuter ; ---- split
lin begin_V2 = mkV2 (prefixV "an" I.fangen_V) | mkV2 I.beginnen_V ;
lin begin_V = prefixV "an" I.fangen_V | I.beginnen_V ;
lin although_Subj = S.although_Subj ;
lin example_N = mkN "Beispiel" "Beispiele" neuter ;
lin next_Adv = mkAdv "als nächstes" ; -- status=guess
lin family_N = mkN "Familie" ;
lin rather_Adv = mkAdv "eher" | mkAdv "lieber" ;
lin fact_N = mkN "Tatsache" ;
lin like_VV = mkVV I.mögen_V ; -- cat: ideal German translation would be with adv, e.g. I LIKE running = ich laufe GERNE
lin like_VS = mkVS (irregV "gefallen" "gefällt" "gefiel" "gefiele" "gefallen") ; -- cat: ideal translation would be with dummy expletive, e.g. I like that... = es gefällt mir, dass ...
lin like_V2 = L.like_V2 ;
lin social_A = mkA "sozial" ;
lin write_VS = mkVS (irregV "schreiben" "schreibt" "schrieb" "schriebe" "geschrieben") ;
lin write_V2 = L.write_V2 ;
lin write_V = irregV "schreiben" "schreibt" "schrieb" "schriebe" "geschrieben" ;
lin state_N = variants{} ; -- 
lin state_2_N = mkN "Stand" "Stand" "Stand" "Standes" "Stände" "Stände" | mkN "Zustand" "Zustand" "Zustand" "Zustandes" "Zustände" "Zustände";
lin state_1_N = mkN "Staat" ;
lin percent_N = mkN "Prozent" ;
lin quite_Adv = S.quite_Adv ;
lin both_Det = M.detLikeAdj False M.Pl "beid" ;
lin start_V2 = mkV2 I.beginnen_V ;
lin start_V = I.beginnen_V ;
lin run_V2 = mkV2 (mkV "leiten") | mkV2 (prefixV "aus" (mkV "führen")) ; ---- split: run a company, run a programme, maybe add: run elections?
lin run_V = L.run_V ;
lin long_A = L.long_A ;
lin right_Adv = variants{} ; -- 
lin right_2_Adv = mkAdv "rechts" ;
lin right_1_Adv = mkAdv "richtig" ;
lin set_V2 = mkV2 (mkV "stellen") | mkV2 (prefixV "fest" (mkV "setzen")) | mkV2 (mkV "decken") ; ---- split: set the clock | set a date| set the table
lin help_V2V = mkV2V I.helfen_V ;
lin help_V2 = mkV2 I.helfen_V ;
lin help_V = I.helfen_V ;
lin every_Det = S.every_Det ;
lin home_N = mkN "Zuhause" "Zuhause" "Zuhause" "Zuhauses" "Zuhause" "Zuhausen" neuter ;
lin month_N = mkN "Monat" "Monat" "Monat" "Monats" "Monate" "Monaten" masculine ;
lin side_N = mkN "Seite" ;
lin night_N = L.night_N ;
lin important_A = L.important_A ;
lin eye_N = L.eye_N ;
lin head_N = L.head_N ;
lin information_N = mkN "Information" ;
lin question_N = L.question_N ;
lin business_N = mkN "Geschäft" "Geschäfte" neuter ;
lin play_V2 = variants{} ; -- 
lin play_V = variants{} ; -- 
lin play_3_V2 = L.play_V2 ;
lin play_3_V = L.play_V ;
lin play_2_V2 = L.play_V2 ;
lin play_2_V = L.play_V ;
lin play_1_V2 = L.play_V2 ;
lin play_1_V = L.play_V ;
lin power_N = mkN "Strom" "Ströme" masculine | mkN "Kraft" "Kräfte" feminine | mkN "Macht" "Mächte" feminine ; --- split: power cut | the exercises take a lot of power | the person in power
lin money_N = mkN "Geld" "Geld" "Geld" "Geldes" "Gelder" "Geldern" neuter ;
lin change_N = mkN "Veränderung" feminine | mkN "Wechselgeld" "Wechselgeld" "Wechselgeld" "Wechselgeldes" "Wechselgelder" "Wechselgeldern"; --- split
lin move_V2 = mkV2 (no_geV (mkV "bewegen")) ;
lin move_V = variants{}; -- mkV2 (no_geV (mkV "bewegen")) ;
lin move_2_V = prefixV "um" I.ziehen_V ;
lin move_1_V = no_geV (mkV "bewegen") ;
lin interest_N = variants{} ; -- 
lin interest_4_N = variants{} ; -- 
lin interest_2_N = mkN "Zins" "Zins" "Zins" "Zinses" "Zinsen" "Zinsen" masculine ;
lin interest_1_N = mkN "Interesse" "Interesse" "Interesse" "Interesses" "Interessen" "Interessen" neuter ;
lin order_N = mkN "Befehl" | mkN "Reihenfolge" | mkN "Ordnung" ; --- split: she gave an order | read it in this order | everything is in order
lin book_N = L.book_N ;
lin often_Adv = mkAdv "häufig" | mkAdv "oft" ;
lin development_N = mkN "Entwicklung" ;
lin young_A = L.young_A ;
lin national_A = mk3A "national" "nationaler" "nationalste" | mkA "Staats-" ; -- status=guess status=guess
lin pay_V3 = mkV3 (prefixV "auf" (mkV "passen")) ; --- delete: false extraction
lin pay_V2V = mkV2V (no_geV (mkV "bezahlen")) ;
lin pay_V2 = mkV2 (no_geV (mkV "bezahlen")) ;
lin pay_V = mkV "zahlen" ;
lin hear_VS = mkVS (mkV "hören") ; -- status=guess, src=wikt
lin hear_V2V = mkV2V (mkV "hören") ; -- status=guess, src=wikt
lin hear_V2 = L.hear_V2 ;
lin hear_V = mkV "hören" ; -- status=guess, src=wikt
lin room_N = variants{} ; -- 
lin room_1_N = mkN "Raum" "Raum" "Raum" "Raumes" "Räume" "Räumen" masculine | mkN "Zimmer" "Zimmer" neuter ;
lin room_2_N = mkN "Platz" "Platz" "Platz" "Platzes" "Plätze" "Plätzen" ;
lin whether_Subj = ss "ob" ;
lin water_N = L.water_N ;
lin form_N = mkN "Form" feminine | mkN "Formular" "Formular" "Formular" "Formulars" "Formulare" "Formularen" neuter ; ---- split: form as shape | you have to fill out the form
lin car_N = L.car_N ;
lin other_N = mkN "Andere" ;
lin yet_Adv = variants{} ; -- 
lin yet_2_Adv = mkAdv "dennoch" ;
lin yet_1_Adv = mkAdv "noch" ;
lin perhaps_Adv = mkAdv "vielleicht" | mkAdv "wohl" ; -- status=guess status=guess
lin meet_V2 = mkV2 I.treffen_V | mkV2 (prefixV "gerecht" I.werden_V) | mkV2 (prefixV "ein" I.halten_V) ; ---- split: meet a friend | meet expectations | meet a deadline
lin meet_V = I.treffen_V ; --- cat: never without N in German: e.g. let's meet = lass uns treffen
lin level_N = variants{} ; -- 
lin level_2_N = mkN "Stock" "Stock" "Stock" "Stocks" "Stöcke" "Stöcken" masculine | mkN "Spiegel" ; ---- split further: level of building / water level
lin level_1_N = mkN "Niveau" "Niveaus" neuter ;
lin until_Subj = ss "bis" ;
lin though_Subj = S.although_Subj ;
lin policy_N = mkN "Verfahrensweise" | mkN "Police" ; --- split: what is your policy on this? / insurance policy
lin include_V2 = mkV2 (prefixV "ein" I.schließen_V) | mkV2 (mkV "inkludieren") ;
lin include_V = mkV "einfügen" | mkV "inkludieren" ; --- delete: false extraction
lin believe_VS = mkVS (regV "glauben") ; -- status=guess, src=wikt
lin believe_V2 = mkV2 (regV "glauben") ; -- status=guess, src=wikt
lin believe_V = regV "glauben" ; -- status=guess, src=wikt
lin council_N = rat_N ; -- status=guess
lin already_Adv = L.already_Adv ;
lin possible_A = mkA "möglich" ; -- status=guess
lin nothing_NP = S.nothing_NP ;
lin line_N = mkN "Linie" | mkN "Leine" ; ---- split can you walk on a line | the dog is on a line
lin allow_V2V = mkV2V I.lassen_V | mkV2V (no_geV (mkV "erlauben")) ; --- note: different case: I let her go = ich lasse sie gehen / ich erlaube ihr zu gehen
lin allow_V2 = mkV2 (no_geV (mkV "erlauben")) ;
lin need_N = mkN "Not" "Nöte" feminine | mkN "Bedarf" | mkN "Bedürfnis" "Bedürfnis" "Bedürfnis" "Bedürfnisses" "Bedürfnisse" "Bedürfnissen" neuter ; --- split: women in need (Not); there is a need for ... (Bedarf; Bedürfnis - not full synonyms but very close)
lin effect_N = mkN "Effekt" | mkN "Auswirkung" | mkN "Wirkung" ;
lin big_A = L.big_A ;
lin use_N = mkN "Benutzung" | mkN "Anwendung" | mkN "Gebrauch" "Gebrauch" "Gebrauch" "Gebrauchs" "Gebräuche" "Gebräuchen" masculine ;
lin lead_V2V = mkV2V (mkV "irreführen") ; ---- delete: false extraction
lin lead_V2 = mkV2 (mkV "führen") ;
lin lead_V = mkV "führen" ;
lin stand_V2 = mkV2 (prefixV "aus" I.halten_V) ;
lin stand_V = L.stand_V ;
lin idea_N = mkN "Idee" | mkN "Ahnung" ; --- split: many creative ideas / no idea how this works
lin study_N = mkN "Studie" | mkN "Studium" "Studium" "Studium" "Studiums" "Studien" "Studien" ; -- split: a study showed / his study of French
lin lot_N = mkN "Grundstück" "Grundstück" "Grundstück" "Grundstücks" "Grundstücke" "Grundstücken"| mkN "Los" "Los" "Los" "Loses" "Lose" "Losen"; --- split: built on a lot / decided by lot
lin live_V = L.live_V ;
lin job_N = mkN "Job" "Jobs" masculine | mkN "Aufgabe" ; --- split: teacher job / your only job today is being friendly
lin since_Subj = ss "seit" ;
lin name_N = L.name_N ;
lin result_N = mkN "Ergebnis" "Ergebnis" "Ergebnis" "Ergebnisses" "Ergebnisse" "Ergebnissen" neuter ;
lin body_N = mkN "Körper" masculine ; -- status=guess
lin happen_VV = mkVV I.geschehen_V ; --- NOTE: better translation = zufällig geschehen
lin happen_V = mkV "passieren" "passiert" "passierte" "passiere" "passiert" | prefixV "statt" I.finden_V ; --- split: an accident happened / an event happened
lin friend_N = L.friend_N ;
lin right_N = mkN "Recht" "Recht" "Recht" "Rechts" "Rechte" "Rechten" neuter ;
lin least_Adv = mkAdv "am wenigsten" ;
lin right_A = variants{} ; -- 
lin right_2_A = mkA "recht" ;
lin right_1_A = mkA "richtig" ;
lin almost_Adv = mkAdv "fast" ;
lin much_Det = S.much_Det ;
lin carry_V2 = mkV2 I.tragen_V ;
lin carry_V = I.tragen_V ; --- delete: false extraction
lin authority_N = variants{} ; -- 
lin authority_2_N = mkN "Autorität" feminine ;
lin authority_1_N = mkN "Kompetenz" feminine ;
lin long_Adv = mkAdv "lange" ; ---cat? can't think of example of use of long as Adv
lin early_A = mkA "früh" | mkA "verfrüht" ; --- split: early in the morning | a report sent in early
lin view_N = variants{} ; -- 
lin view_2_N = mkN "Ansicht" feminine ;
lin view_1_N = mkN "Aussicht" feminine | mkN "Ausblick" ;
lin public_A = mkA "öffentlich" ; -- status=guess
lin together_Adv = mkAdv "zusammen" ;
lin talk_V2 = mkV2 (mkV "reden") ; --- note: construction "talk politics" not possible; need PP: über Politik reden
lin talk_V = mkV "reden" | I.sprechen_V ;
lin report_N = mkN "Bericht" ;
lin after_Subj = ss "nachdem" ;
lin only_Predet = S.only_Predet ;
lin before_Subj = ss "bevor" ;
lin bit_N = mkN "Bit" neuter | mkN "Bisschen" "Bisschen" neuter | mkN "Stück" "Stück" "Stück" "Stückes" "Stücke" "Stücken" neuter | mkN "Stückchen" "Stückchen" neuter ; --- split: computational bit / a bit of luck / one bit of the puzzle (Stück / Stückchen)
lin face_N = mkN "Gesicht" neuter | mkN "Gesichtsausdruck" "Gesichtsausdruck" "Gesichtsausdruck" "Gesichtsausdrucks" "Gesichtsausdrücke" "Gesichtsausdrücken" masculine ; --- split: beautiful face / pull a face
lin sit_V2 = mkV2 I.sitzen_V ;
lin sit_V = L.sit_V ;
lin market_N = variants{} ; -- 
lin market_1_N = mkN "Markt" "Markt" "Markt" "Markts" "Märkte" "Märkten" masculine ;
lin market_2_N = mkN "Markt" "Markt" "Markt" "Markts" "Märkte" "Märkten" masculine ; ---note: stock market better translated to Börse
lin appear_VV = mkVV I.scheinen_V ;
lin appear_VS = mkVS I.scheinen_V ;
lin appear_VA = mkVA I.scheinen_V ;
lin appear_V = mkV "erscheinen" "erscheint" "erschien" "erscheine" "erscheint" ;
lin continue_VV = mkVV (prefixV "weiter" (mkV "machen")) | mkVV (prefixV "fort" I.fahren_V) ;
lin continue_V2 = mkV2 (prefixV "weiter" (mkV "machen")) ;
lin continue_V = prefixV "weiter" (mkV "machen") ;
lin able_A = mkA "kompetent" | mkA "fähig" ; --- split: an able student / she is able to drive
lin political_A = mk3A "politisch" "politischer" "politischste" ; -- status=guess
lin later_Adv = mkAdv "später" ;
lin hour_N = mkN "Stunde" ;
lin rate_N = mkN "Tempo" "Tempo" "Tempo" "Tempos" "Tempi" "Tempi" | mkN "Kurs" | mkN "Verhältnis" "Verhältnis" "Verhältnis" "Verhältnisses" "Verhältnisse" "Verhältnissen" neuter ; --- split: at a fast rate / change rate / rate of two sides to each other
lin law_N = variants{} ; -- 
lin law_2_N = mkN "Jura" "Jura" "Jura" "Juras" "Juras" "Juras" masculine ; --- note: NO plural!!!
lin law_1_N = mkN "Gesetz" "Gesetz" "Gesetz" "Gesetzes" "Gesetze" "Gesetzen" neuter ;
lin door_N = L.door_N ;
lin court_N = variants{} ; -- 
lin court_2_N = mkN "Gerichtshof" "Gerichtshof" "Gerichtshof" "Gerichtshofes" "Gerichtshöfe" "Gerichtshöfen" masculine | mkN "Gericht" "Gericht" "Gericht" "Gerichts" "Gerichte" "Gerichten" ;
lin court_1_N = mkN "Hof" "Hof" "Hof" "Hofes" "Höfe" "Höfen" masculine ;
lin office_N = mkN "Amt" "Amt" "Amt" "Amts" "Ämter" "Ämtern" neuter | mkN "Büro" "Büros" neuter ; --- split: the president in office / the president's office
lin let_V2V = mkV2V I.lassen_V ;
lin war_N = L.war_N ;
lin produce_V2 = mkV2 (mkV "produzieren" "produziert" "produzierte" "produziere" "produziert") | mkV2 (mkV "erzielen" "erzielt" "erzielte" "erziele" "erzielt"); --- split: produce cheese / produce results
lin produce_V = mkV "produzieren" "produziert" "produzierte" "produziere" "produziert" ; --- false extraction
lin reason_N = L.reason_N ;
lin less_Adv = mkAdv "weniger" ; -- status=guess
lin minister_N = variants{} ; -- 
lin minister_2_N = mkN "Pfarrer" "Pfarrer" masculine ;
lin minister_1_N = mkN "Minister" "Minister" masculine ;
lin subject_N = variants{} ; -- 
lin subject_2_N = mkN "Subjekt" "Subjekt" "Subjekt" "Subjekts" "Subjekte" "Subjekten" neuter | mkN "Thema" "Thema" "Thema" "Themas" "Themen" "Themen" neuter | mkN "Fach" "Fach" "Fach" "Fachs" "Fächer" "Fächern" neuter ; --- split further: subject and object / the subject of this talk / maths is my fav subject
lin subject_1_N = mkN "Gegenstand" "Gegenstand" "Gegenstand" "Gegenstands" "Gegenstände" "Gegenständen" masculine ; --- note: "subject matter" is not sufficiently clear for disambiguating meanings; interpreted as physical matter of a subject
lin person_N = L.person_N ;
lin term_N = mkN "Semester" neuter | mkN "Ausdruck" "Ausdruck" "Ausdruck" "Ausdrucks" "Ausdrücke" "Ausdrücken" masculine | mkN "Bedingung" ; --- split: school term(no general term in German; semester/trimester has to be specified) / scientific term / terms and conditions
lin particular_A = mkA "bestimmt" | mkA "eigen" ; --- split: do you need any particular food | she is particular in what she eats
lin full_A = L.full_A ;
lin involve_VS = variants{}; -- mkV2 (prefixV "ein" (mkV "beziehen" "bezieht" "beziehte" "beziehe" "bezogen")) | mkV2 (mkV "bedingen" "bedingt" "bedingte" "bedinge" "bedingt") ; --- split: involve somebody | involve something
lin involve_V2 = mkV2 (prefixV "ein" (mkV "beziehen" "bezieht" "beziehte" "beziehe" "bezogen")) | mkV2 (mkV "bedingen" "bedingt" "bedingte" "bedinge" "bedingt") ; --- split: involve somebody | involve something
lin involve_V = prefixV "ein" (mkV "beziehen" "bezieht" "beziehte" "beziehe" "bezogen") ; --- delete: false extraction
lin sort_N = mkN "Sorte" ;
lin require_VS = mkVS (mkV "erfordern" "erfordert" "erforderte" "erfordere" "erfordert") ;
lin require_V2V = mkV2V (mkV "erfordern" "erfordert" "erforderte" "erfordere" "erfordert") ; --- cat: it requires you to = es erfordert von dir... / es erfordert, dass du
lin require_V2 = mkV2 (mkV "erfordern" "erfordert" "erforderte" "erfordere" "erfordert") | mkV2 (no_geV (mkV "benötigen")) ; --- split: it requires a lot of energy / you require a lot of energy
lin require_V = irregV "erfordern" "erfordert" "erforderte" "erforderte" "erfordert" ; --- delete: false extraction
lin suggest_VS = mkVS (prefixV "vor" I.schlagen_V) ;
lin suggest_V2 = mkV2 (prefixV "vor" I.schlagen_V) ;
lin suggest_V = prefixV "vor" I.schlagen_V ; --- delete: false extraction
lin far_A = mkA "fern" | mkA "weit" ; --- split: near and far / a far distance
lin towards_Prep = mkPrep "auf" accusative "zu" ; -- note: preposition around the noun
lin anything_NP = S.mkNP (mkPN "irgendwas") ;
lin period_N = variants{} ; -- 
lin period_3_N = mkN "Regel" "Regeln" feminine | mkN "Periode" ;
lin period_2_N = mkN "Punkt" ;
lin period_1_N = mkN "Abschnitt" | mkN "Periode" ;
lin consider_VV = mkVV (mkV "überlegen" "überlegt" "überlegte" "überlege" "überlegt") ; --- cat: V2V in German: I'm considering leaving = ich überlege mir zu gehen
lin consider_VS = mkVS (mkV "überlegen") ; --- delete: false extraction
lin consider_V3 = mkV3 I.halten_V ; --- cat: I consider her a wise woman = ich halte sie FÜR eine weise Frau
lin consider_V2V = mkV2V (mkV "überlegen") ; --- delete: false extraction for English
lin consider_V2A = mkV2A (mkV "überlegen") ; --- delete: false extraction
lin consider_V2 = mkV2 (mkV "überlegen" "überlegt" "überlegte" "überlege" "überlegt") ; --- cat: I will consider it = ich überlege es MIR
lin consider_V = mkV "überlegen" ; --- delete: false extraction
lin read_VS = mkVS (I.lesen_V) ;
lin read_V2 = L.read_V2 ;
lin read_V = I.lesen_V ;
lin change_V2 = mkV2 (mkV "ändern") ;
lin change_V = reflV (mkV "ändern") accusative ;
lin society_N = mkN "Gesellschaft" "Gesellschaften" feminine ; -- status=guess
lin process_N = mkN "Prozess" "Prozesse" masculine ; -- status=guess
lin mother_N = mkN "Mutter" "Mütter" feminine ;
lin offer_VV = mkVV (prefixV "an" I.bieten_V) ;
lin offer_V2 = mkV2 I.bieten_V ;
lin late_A = mkA "spät" ; -- status=guess
lin voice_N = mkN "Stimme" ;
lin both_Adv = mkAdv "beide" ;
lin once_Adv = mkAdv "einmal" ;
lin police_N = mkN "Polizei" feminine ;
lin kind_N = mkN "Art" feminine ;
lin lose_V2 = L.lose_V2 ;
lin lose_V = I.verlieren_V ;
lin add_VS = mkVS (prefixV "hinzu" (mkV "fügen")) ;
lin add_V2 = mkV2 (prefixV "hinzu" (mkV "fügen")) | mkV2 (mkV "addieren" "addiert" "addierte" "addiere" "addiert"); --- split: I added her (on FB) / I added two numbers
lin add_V = mkV "addieren" "addiert" "addierte" "addiere" "addiert" ; --- delete: false extraction
lin probably_Adv = mkAdv "wahrscheinlich" ; -- status=guess
lin expect_VV = mkVV (mkV "erwarten" "erwartet" "erwartete" "erwarte" "erwartet") ;
lin expect_VS = mkVS (mkV "erwarten" "erwartet" "erwartete" "erwarte" "erwartet") ;
lin expect_V2V = mkV2V (mkV "erwarten" "erwartet" "erwartete" "erwarte" "erwartet") ; --- cat: I expect her to go = Ich erwarte, dass sie gehen wird
lin expect_V2 = mkV2 (mkV "erwarten" "erwartet" "erwartete" "erwarte" "erwartet") ;
lin expect_V = irregV "erwarten" "erwartet" "erwartete" "erwarte" "erwartet" ; --- delete: false extraction (except for "I am expecting" - ich erwarte ein Kind)
lin ever_Adv = mkAdv "jemals" | mkAdv "je" ;
lin available_A = mkA "verfügbar" ;
lin price_N = mkN "Preis" ;
lin little_A = mkA "wenig" | mkA "klein" ; --- split: a little money (is little a det here?) / a little girl
lin action_N = mkN "Maßnahme" | mkN "Handlung" feminine ; --- split: take action against | acting a certain way
lin issue_N = variants{} ; -- 
lin issue_2_N = mkN "Ausgabe" ;
lin issue_1_N = mkN "Problem" "Probleme" neuter | mkN "Angelegenheit" feminine ; --- split further: this is no issue / the issue of whether ...
lin far_Adv = L.far_Adv ;
lin remember_VS = mkVS (reflV (mkV "erinnern" "erinnert" "erinnerte" "erinnere" "erinnert") accusative) ;
lin remember_V2 = mkV2 (reflV (mkV "erinnern" "erinnert" "erinnerte" "erinnere" "erinnert") accusative) | mkV2 (reflV (mkV "merken") accusative) ; --- split: remember a person (note: in German "ich erinnere mich AN dich") / remember a fact
lin remember_V = reflV (mkV "erinnern" "erinnert" "erinnerte" "erinnere" "erinnert") accusative ;
lin position_N = mkN "Stelle" | mkN "Lage" | mkN "Position" ; --- split: precise position is unknown / I'm in a bad position / a high position
lin low_A = mk3A "niedrig" "niedriger" "niedrigste" ; -- status=guess
lin cost_N = mkN "Kost Kosten" masculine ; --- note: only in plural
lin little_Det = M.detLikeAdj False M.Sg "wenig" ;
lin matter_N = variants{} ; -- 
lin matter_1_N = mkN "Material" "Material" "Material" "Materials" "Materiale" "Materialen" ;
lin matter_2_N = mkN "Angelegenheit" feminine ;
lin community_N = mkN "Gemeinschaft" feminine ;
lin remain_VV = mkVV I.bleiben_V ;
lin remain_VA = mkVA I.bleiben_V ;
lin remain_V2 = mkV2 I.bleiben_V ; --- delete: false extraction
lin remain_V = I.bleiben_V ;
lin figure_N = variants{} ; -- 
lin figure_2_N = mkN "Figur" feminine ;
lin figure_1_N = mkN "Figur" feminine ;
lin type_N = mkN "Typ" "Typ" "Typ" "Typs" "Typen" "Typen" masculine | mkN "Art" feminine ; --- note: compounds such as type face not accounted for
lin research_N = mkN "Forschung" ;
lin actually_Adv = mkAdv "eigentlich" ; -- status=guess
lin education_N = mkN "Bildung" ;
lin fall_V = I.fallen_V | prefixV "hin" I.fallen_V ; --- split: the book fell / the girl fell
lin speak_V2 = L.speak_V2 ;
lin speak_V = I.sprechen_V ;
lin few_N = mkN "Wenig" ; -- note: only in plural
lin today_Adv = L.today_Adv ;
lin enough_Adv = mkAdv "genug" ; -- status=guess
lin open_V2 = L.open_V2 ;
lin open_V = reflV (mkV "öffnen") accusative ;
lin bad_A = L.bad_A ;
lin buy_V2 = L.buy_V2 ;
lin buy_V = mkV "kaufen" ;
lin programme_N = mkN "Programm" "Programm" "Programm" "Programms" "Programme" "Programme" neuter ;
lin minute_N = mkN "Minute" ;
lin moment_N = mkN "Moment" ;
lin girl_N = L.girl_N ;
lin age_N = mkN "Alter" neuter | mkN "Zeitalter" neuter ; --- split: don't talk about age / the age of aquarius
lin centre_N = mkN "Zentrum" "Zentrum" "Zentrum" "Zentrums" "Zentren" "Zentren" neuter ;
lin stop_VV = mkVV (prefixV "auf" (mkV "hören")) ;
lin stop_V2 = mkV2 (prefixV "an" I.halten_V) | mkV2 (mkV "stoppen") ;
lin stop_V = L.stop_V ;
lin control_N = mkN "Kontrolle" ;
lin value_N = mkN "Wert" ;
lin send_V2V = mkV2V (regV "senden" | regV "schicken") ; --- delete: false extraction, why no send_V3?
lin send_V2 = mkV2 (mkV "schicken") ;
lin send_V = regV "senden" | regV "schicken" ; --- delete: false extraction
lin health_N = mkN "Gesundheit" feminine ;
lin decide_VV = mkVV (reflV (mkV "entscheiden entscheidet entschied entscheide entschieden") accusative) | mkVV (mkV "beschließen" "beschließt" "beschloss" "beschlösse" "beschlossen") ;
lin decide_VS = mkVS (mkV "beschließen" "beschließt" "beschloss" "beschlösse" "beschlossen") ;
lin decide_V2 = mkV2 (mkV "entscheiden entscheidet entschied entscheide entschieden") ;
lin decide_V = reflV (mkV "entscheiden entscheidet entschied entscheide entschieden") accusative ;
lin main_A = mkA "Haupt-" ;
lin win_V2 = L.win_V2 ;
lin win_V = I.gewinnen_V ;
lin understand_VS = mkVS (mkV "verstehen" "versteht" "verstand" "verstünde" "verstanden") | mkVS (mkV "begreifen" "begreift" "begriff" "begriffe" "begriffen") ;
lin understand_V2 = L.understand_V2 ;
lin understand_V = mkV "verstehen" "versteht" "verstand" "verstünde" "verstanden" ;
lin decision_N = mkN "Entscheidung" ;
lin develop_V2 = mkV2 (mkV "entwickeln" "entwickelt" "entwickelte" "entwickle" "entwickelt") ;
lin develop_V = reflV (mkV "entwickeln" "entwickelt" "entwickelte" "entwickle" "entwickelt") accusative ;
lin class_N = mkN "Klasse" | mkN "Schicht" feminine | mkN "Gesellschaftsschicht" feminine; --- split: class in school (Klasse) / working class
lin industry_N = L.industry_N ;
lin receive_V2 = mkV2 (mkV "bekommen" "bekommt" "bekam" "bekäme" "bekommen") | mkV2 (mkV "erhalten" "erhaltet" "erhielt" "erhielte" "erhalten") | mkV2 (mkV "kriegen") ;
lin receive_V = mkV "bekommen" "bekommt" "bekam" "bekäme" "bekommen" ; --- delete: false extraction
lin back_N = L.back_N ;
lin several_Det = M.detLikeAdj False M.Pl "mehrer" ;
lin return_V2 = mkV2 (prefixV "zurück" I.bringen_V) ;
lin return_V = prefixV "zurück" I.kommen_V ;
lin build_V2 = mkV2 (mkV "bauen") ;
lin build_V = mkV "bauen" ;
lin spend_V2 = mkV2 (prefixV "aus" I.geben_V) | mkV2 (fixprefixV "ver" I.bringen_V) ; --- split: spend time / money
lin spend_V = irregV "verbringen" "verbringt" "verbrachte" "verbrächte" "verbracht" ; --- delete: false extraction
lin force_N = mkN "Gewalt" feminine | mkN "Streitmacht" "Streitmächte" feminine | mkN "Belastung" ; --- split: open it with force / the armys joined their forces / a lot of force is applying to that metal
lin condition_N = variants{} ; -- 
lin condition_1_N = mkN "Bedingung" ;
lin condition_2_N = mkN "Zustand" "Zustand" "Zustand" "Zustands" "Zustände" "Zuständen" ;
lin paper_N = L.paper_N ;
lin off_Prep = mkPrep "entfernt von" dative ;
lin major_A = mkA "wichtig" ;
lin describe_VS = mkVS (mkV "beschreiben" "beschreibt" "beschrieb" "beschriebe" "beschrieben") ;
lin describe_V2 = mkV2 (mkV "beschreiben" "beschreibt" "beschrieb" "beschriebe" "beschrieben") ;
lin agree_VV = mkVV (reflV (compoundV "einverstanden" (fixprefixV "er" (mkV "klären"))) accusative) ;
lin agree_VS = mkVS (prefixV "zu" (mkV "stimmen")) ;
lin agree_V = prefixV "zu" (mkV "stimmen") ;
lin economic_A = mkA "ökonomisch" | mkA "wirtschaftlich" ;
lin increase_V2 = mkV2 (fixprefixV "er" (mkV "höhen")) ;
lin increase_V = I.steigen_V ;
lin upon_Prep = mkPrep "auf" accusative | mkPrep "bei" dative ; --- note: really very strongly case dependent e.g. upon receipt = bei/nach Erhalt
lin learn_VV = mkVV (mkV "lernen") ;
lin learn_VS = mkVS (mkV "lernen") | fixprefixV "er" I.fahren_V ; --- split: learnt that 1+1 = 2 / learnt that she had been unfaithful (found out!)
lin learn_V2 = L.learn_V2 ;
lin learn_V = mkV "lernen" ; --- delete: false extraction
lin general_A = mkA "allgemein" ;
lin century_N = mkN "Jahrhundert" "Jahrhundert" "Jahrhundert" "Jahrhunderts" "Jahrhunderte" "Jahrhunderten" neuter ;
lin therefore_Adv = mkAdv "deswegen" | mkAdv "deshalb" | mkAdv "darum" ; -- status=guess status=guess status=guess
lin father_N = mkN "Vater" "Väter" masculine ; -- status=guess
lin section_N = mkN "Abschnitt" | mkN "Teil" "Teil" "Teil" "Teils" "Teile" "Teilen" ;
lin patient_N = mkN "Patient" "Patienten" masculine ;
lin around_Adv = mkAdv "herum" ;
lin activity_N = mkN "Aktivität" feminine | mkN "Tätigkeit" feminine ;
lin road_N = L.road_N ;
lin table_N = L.table_N ;
lin including_Prep = mkPrep "eingeschlossen" accusative ; --- note: postposition (mich eingeschlossen)
lin church_N = L.church_N ;
lin reach_V2 = mkV2 (fixprefixV "er" (mkV "reichen")) ;
lin reach_V = mkV "reichen" ;
lin real_A = mkA "echt" ;
lin lie_VS = mkVS (I.lügen_V) ;
lin lie_2_V = I.lügen_V ;
lin lie_1_V = I.liegen_V ;
lin mind_N = mkN "Verstand" masculine | mkN "Geist" masculine ;
lin likely_A = mkA "wahrscheinlich" ;
lin among_Prep = mkPrep "unter" accusative ;
lin team_N = mkN "Mannschaft" feminine | mkN "Team" "Team" "Team" "Teams" "Teams" "Teams" ; --- split: football team / team meeting
lin experience_N = mkN "Erfahrung" | mkN "Erlebnis" "Erlebnis" "Erlebnis" "Erlebnisses" "Erlebnisse" "Erlebnissen" ; --- split: from my experience / exciting experience
lin death_N = mkN "Tod" ;
lin soon_Adv = mkAdv "bald" ;
lin act_N = mkN "Handlung" | mkN "Tat" feminine ;
lin sense_N = mkN "Sinn" | mkN "Gefühl" "Gefühl" "Gefühl" "Gefühls" "Gefühle" "Gefühlen" neuter ; --- split: seventh sense | no sense of personal space
lin staff_N = variants{} ; -- 
lin staff_2_N = mkN "Stock" "Stock" "Stock" "Stocks" "Stöcke" "Stöcken" masculine ;
lin staff_1_N = mkN "Personal" "Personal" "Personal" "Personals" "Personale" "Personalen" neuter ;
lin certain_A = variants{} ; -- 
lin certain_2_A = mkA "bestimmt" ;
lin certain_1_A = mkA "sicher" ;
lin studentMasc_N = reg2N "Student" "Studenten" masculine;
lin half_Predet = MS.mkPredet (mkA "halb") ; --- cat: half a dollar = ein halber Dollar
lin half_Predet = MS.mkPredet (mkA "halb") ; --- cat: half a dollar = ein halber Dollar
lin around_Prep = mkPrep "rund um" accusative | mkPrep "um" accusative "herum" ; --- split: around the clock / around Vienna, note: preposition "um herum" around the noun
lin language_N = L.language_N ;
lin walk_V2 = mkV2 I.gehen_V ; --- cat: I walked the dog = mit dem Hund Gassi gehen
lin walk_V = L.walk_V ;
lin die_V = L.die_V ;
lin special_A = mkA "besondere" ;
lin difficult_A = mkA "schwer" | mkA "schwierig" ;
lin international_A = regA "international" ; -- status=guess
lin particularly_Adv = mkAdv "besonders" ;
lin department_N = mkN "Abteilung" ;
lin management_N = mkN "Leitung" | mkN "Führung" | mkN "Management" "Managements" neuter ;
lin morning_N = mkN "Morgen" ;
lin draw_V2 = variants{}; -- mkV "zeichnen" ;
lin draw_1_V2 = mkV2 I.ziehen_V ;
lin draw_2_V2 = mkV2 (mkV "zeichnen") ;
lin draw_V = mkV "zeichnen" ;
lin hope_VV = mkVV (mkV "hoffen") ;
lin hope_VS = L.hope_VS ;
lin hope_V = mkV "hoffen" ;
lin across_Prep = mkPrep "über" accusative ;
lin plan_N = mkN "Plan" "Plan" "Plan" "Plans" "Pläne" "Plänen" masculine ;
lin product_N = mkN "Produkt" "Produkt" "Produkt" "Produkts" "Produkte" "Produkten" neuter ;
lin city_N = L.city_N ;
lin early_Adv = mkAdv "früh" ; -- status=guess
lin committee_N = mkN "Ausschuss" "Ausschuss" "Ausschuss" "Ausschusses" "Ausschüsse" "Ausschüssen" masculine ;
lin ground_N = variants{} ; -- 
lin ground_2_N = mkN "Grund" "Grund" "Grund" "Grundes" "Gründe" "Gründen" ;
lin ground_1_N = mkN "Ebene" ; --- note: ground zero not sufficiently clear disambiguation
lin letter_N = variants{} ; -- 
lin letter_2_N = mkN "Buchstabe" masculine ;
lin letter_1_N = mkN "Brief" ;
lin create_V2 = mkV2 (fixprefixV "er" I.schaffen_V) ;
lin create_V = irregV "entwerfen" "entwerft" "entwarf" "entwürfe" "entworfen" ; --- delete: false extraction
lin evidence_N = variants{} ; -- 
lin evidence_2_N = variants{} ; -- 
lin evidence_1_N = mkN "Beweis" ;
lin foot_N = L.foot_N ;
lin clear_A = mkA "klar" ; --- split: a clear lake / a clear yes (same in German)
lin boy_N = L.boy_N ;
lin game_N = variants{} ; -- 
lin game_3_N = mkN "Wild" "Wild" "Wild" "Wilds" "Wild" "Wild" neuter ; --- note: no plural
lin game_2_N = mkN "Spiel" "Spiele" neuter ;
lin game_1_N = mkN "Spiel" "Spiele" neuter ;
lin food_N = mkN "Essen" neuter | mkN "Lebensmittel" feminine ; --- split: this was good food / shop food
lin role_N = variants{} ; -- 
lin role_2_N = variants{} ; -- 
lin role_1_N = variants{} ; -- 
lin practice_N = mkN "Methode" | mkN "Übung" ; --- split: best practice examples / my daily practice
lin bank_N = L.bank_N ;
lin else_Adv = mkAdv "sonst" ;
lin support_N = mkN "Unterstützung" feminine ;
lin sell_V2 = mkV2 (fixprefixV "ver" (mkV "kaufen")) ;
lin sell_V = fixprefixV "ver" (mkV "kaufen") ;
lin event_N = mkN "Ereignis" "Ereignis" "Ereignis" "Ereignisses" "Ereignisse" "Ereignissen" | mkN "Event" "Events" neuter ; --- split: most significant event of 21st century / big clubbing event
lin building_N = mkN "Bau" | mkN "Bauen" neuter | mkN "Gebäude" "Gebäude" "Gebäude" "Gebäudes" "Gebäude" "Gebäuden" neuter ; --- split: the building of the new arcade (Bau / Bauen) | this beautiful building
lin range_N = mkN "Reichweite" | mkN "Umfang" "Umfang" "Umfang" "Umfangs" "Umfänge" "Umfängen" ;
lin behind_Prep = S.behind_Prep ;
lin sure_A = mk3A "sicher" "sicherer" "sicherste" ; -- status=guess
lin report_VS = mkVS (fixprefixV "be" (mkV "richten")) ;
lin report_V2 = mkV2 (mkV "melden") ;
lin report_V = fixprefixV "be" (mkV "richten") ;
lin pass_V = prefixV "vorbei" I.gehen_V ;
lin black_A = L.black_A ;
lin stage_N = mkN "Bühne" | mkN "Phase" ; --- split: all the world's a stage | at this stage of the cancer
lin meeting_N = mkN "Meeting" "Meetings" neuter | mkN "Treffen" neuter ; --- split: office meeting / meeting among friends
lin meeting_N = mkN "Meeting" "Meetings" neuter | mkN "Treffen" neuter ; --- split: office meeting / meeting among friends
lin sometimes_Adv = mkAdv "manchmal" ; -- status=guess
lin thus_Adv = mkAdv "also" | mkAdv "demnach" ;
lin accept_VS = mkVS (mkV "akzeptieren" "akzeptiert" "akzeptierte" "akzeptiere" "akzeptierten") ;
lin accept_V2 = mkV2 (prefixV "zu" (mkV "sagen") | prefixV "an" I.nehmen_V | mkV "akzeptieren" "akzeptiert" "akzeptierte" "akzeptiere" "akzeptierten") ; --- split: Cambridge accepted me (mir zusagen/mich annehmen)/ I accept your opionion but I don't agree
lin accept_V = prefixV "zu" (mkV "sagen") | prefixV "an" I.nehmen_V | mkV "akzeptieren" "akzeptiert" "akzeptierte" "akzeptiere" "akzeptierten" ; --- split: cf. above + cat: I accepted = ich habe ES angenommen / akzeptiert
lin town_N = mkN "Stadt" "Städte" feminine ;
lin art_N = L.art_N ;
lin further_Adv = mkAdv "des Weiteren" ;
lin club_N = variants{} ; -- 
lin club_2_N = mkN "Keule" ;
lin club_1_N = mkN "Verein" | mkN "Klub" "Klubs" masculine | mkN "Klub" "Klubs" masculine ; --- split further: member of the club (Verein/Klub) / go partying to a club (Klub/Club)
lin cause_V2V = mkV2V (mkV "veranlassen" "veranlasst" "veranlasste" "veranlasse" "veranlasst") ;
lin cause_V2 = mkV2 (mkV "verursachen" "verursacht" "verursachte" "verursache" "verursacht") ;
lin arm_N = variants{} ; -- 
lin arm_1_N = mkN "Arm" ;
lin arm_2_N = mkN "Waffe" ;
lin history_N = mkN "Geschichte" ;
lin parent_N = mkN "Elternteil" "Elternteil" "Elternteil" "Elternteil" "Eltern" "Eltern" neuter | mkN "Vorgänger" ; --- split: parent of children / the parent model
lin land_N = mkN "Land" "Land" "Land" "Landes" "Länder" "Ländern" neuter ;
lin trade_N = mkN "Handel" | mkN "Gewerbe" "Gewerbe" "Gewerbe" "Gewerbes" "Gewerbe" "Gewerben" neuter ; --- split: domestic trade (only sg in German) / specific to my trade
lin watch_VS = mkVS (prefixV "auf" (mkV "passen")) ;
lin watch_V2V = mkV2V (mkV "beobachten" "beobachtet" "beobachtete" "beobachte" "beobachtet") ;
lin watch_V2 = variants{}; -- mkV2V (mkV "beobachten" "beobachtet" "beobachtete" "beobachte" "beobachtet") ;
lin watch_1_V2 = mkV2 (mkV "schauen") ;
lin watch_2_V2 = mkV2 (mkV "beobachten" "beobachtet" "beobachtete" "beobachte" "beobachtet") ; --- maybe further split: can you watch my things?
lin watch_V = mkV "zu" (mkV "schauen") ;
lin white_A = L.white_A ;
lin situation_N = mkN "Situation" ;
lin ago_Adv = mkAdv "her" ;
lin teacherMasc_N = reg2N "Lehrer" "Lehrer" masculine ;
lin record_N = variants{} ; -- 
lin record_3_N = mkN "Aufzeichnung" ;
lin record_2_N = mkN "Platte" | mkN "Schallplatte" ;
lin record_1_N = mkN "Rekord" ;
lin manager_N = mkN "Direktor" "Direktoren" masculine | mkN "Manager" ;
lin relation_N = mkN "Beziehung" | mkN "Verhältnis" ;
lin common_A = variants{} ; -- 
lin common_2_A = mkA "gemeinsam" ;
lin common_1_A = mkA "üblich" | mkA "gewöhnlich" ; --- split further: very common | the common domestic fowl
lin strong_A = mkA "stark" "stärker" "stärkste" ;
lin whole_A = mkA "ganz" ;
lin field_N = variants{} ; -- 
lin field_4_N = mkN "Feld" neuter ;
lin field_3_N = mkN "Platz" "Plätze" masculine ;
lin field_2_N = mkN "Feld" neuter ;
lin field_1_N = mkN "Feld" neuter ;
lin free_A = mkA "frei" ;
lin break_V2 = L.break_V2 ;
lin break_V = I.brechen_V ;
lin yesterday_Adv = mkAdv "gestern" ;
lin support_V2 = mkV2 (fixprefixV "unter" (mkV "stützen")) ;
lin window_N = L.window_N ;
lin account_N = mkN "Konto" "Konto" "Konto" "Kontos" "Konten" "Konten" | mkN "Bericht" ; --- split: bank account | his account of last night was dramatic
lin explain_VS = mkVS (fixprefixV "er" (mkV "klären")) ;
lin explain_V2 = mkV2 (fixprefixV "er" (mkV "klären")) ;
lin stay_VA = mkVA I.bleiben_V ;
lin stay_V = I.bleiben_V ;
lin few_Det = S.few_Det ;
lin wait_VV = mkVV (irregV "warten" "wartet" "wartete" "warte" "gewartet") ; --- delete: false extraction
lin wait_V2 = L.wait_V2 ;
lin wait_V = mkV "warten" ;
lin usually_Adv = mkAdv "normalerweise" ;
lin difference_N = mkN "Unterschied" ;
lin material_N = mkN "Stoff" | mkN "Material" "Material" "Material" "Materials" "Materiale" "Materialen" ; --- split: material covered in class (sg only) | expensive material
lin air_N = mkN "Luft" "Lüfte" feminine ;
lin wife_N = L.wife_N ;
lin cover_V2 = mkV2 (mkV "decken") ;
lin apply_VV = mkVV (prefixV "an" (regV "wenden") | irregV "verwenden" "verwendet" "verwendete" "verwendete" "verwendet" | regV "benutzen") ; --- delete: false extraction
lin apply_V2V = mkV2V (prefixV "an" (regV "wenden") | irregV "verwenden" "verwendet" "verwendete" "verwendete" "verwendet" | regV "benutzen") ; --- delete: false extraction
lin apply_V2 = mkV2 (prefixV "an" (regV "wenden") | irregV "verwenden" "verwendet" "verwendete" "verwendete" "verwendet" | regV "benutzen") ; --- delete: sense is split
lin apply_1_V2 = variants{} ; -- 
lin apply_2_V2 = variants{} ; -- 
lin apply_V = reflV (mkV "bewerben") accusative ;
lin project_N = mkN "Projekt" "Projekte" neuter ;
lin raise_V2 = mkV2 (fixprefixV "er" (mkV "höhen")) ;
lin sale_N = mkN "Verkauf" "Verkäufe" masculine | mkN "Ausverkauf" "Ausverkäufe" masculine ; --- split: sale of an apartment | end of year sales
lin relationship_N = mkN "Beziehung" ;
lin indeed_Adv = mkAdv "allerdings" ;
lin light_N = mkN "Licht" neuter ;
lin claim_VS = mkVS (fixprefixV "be" (mkV "haupten")) ;
lin claim_V2 = mkV2 (mkV "fordern") ;
lin claim_V = mkV "fordern" ; --- delete: false extraction
lin form_V2 = mkV2 (mkV "formen") | mkV2 (mkV "bilden") ; --- form clay (to a ball) / form a circle
lin form_V = regV "formen" | regV "bilden" ; --- delete: false extraction
lin base_V2 = mkV2 (regV "basieren") ; --- delete: false extraction
lin base_V = mkV "basieren" ;
lin care_N = mkN "Pflege" | mkN "Sorgfalt" ; --- split: old people in care / carefully
lin someone_NP = S.somebody_NP ;
lin everything_NP = S.everything_NP ;
lin certainly_Adv = mkAdv "bestimmt" | mkAdv "sicherlich" ;
lin rule_N = L.rule_N ;
lin home_Adv = mkAdv "heim" | mkAdv "nach Hause" ;
lin cut_V2 = L.cut_V2 ;
lin cut_V = I.schneiden_V ; --- delete: false extraction
lin grow_VA = I.werden_V ;
lin grow_V2 = mkV2 (I.wachsen_V) ;
lin grow_V = I.wachsen_V ;
lin similar_A = mkA "ähnlich" ;
lin story_N = mkN "Geschichte" ;
lin quality_N = mkN "Qualität" feminine | mkN "Eigenschaft" feminine ; --- split: high quality / his best quality
lin tax_N = mkN "Steuer" "Steuern" feminine ;
lin worker_N = mkN "Arbeiter" ;
lin nature_N = mkN "Natur" feminine ;
lin structure_N = mkN "Struktur" feminine ;
lin data_N = mkN "Data Data Data Data Daten Daten" neuter ; --- note: only plural
lin necessary_A = mkA "notwendig" ;
lin pound_N = mkN "Pfund" "Pfunde" neuter ;
lin method_N = mkN "Methode" ;
lin unit_N = variants{} ; -- 
lin unit_6_N = variants{} ; -- 
lin unit_5_N = variants{} ; -- 
lin unit_4_N = variants{} ; -- 
lin unit_3_N = variants{} ; -- 
lin unit_2_N = variants{} ; -- 
lin unit_1_N = variants{} ; -- 
lin central_A = mk3A "zentral" "zentraler" "zentralste" ;
lin bed_N = mkN "Bett" "Bett" "Bett" "Betts" "Betten" "Betten" neuter ;
lin union_N = mkN "Bund" "Bünde" masculine | mkN "Gewerkschaft" feminine ; --- split: sacred union of marriage / worker's union
lin movement_N = mkN "Bewegung" ;
lin board_N = variants{} ; -- 
lin board_2_N = mkN "Kammer" "Kammern" feminine ;
lin board_1_N = mkN "Tafel" "Tafeln" feminine ;
lin true_A = mkA "wahr" ;
lin well_Interj = mkInterj "also" ;
lin simply_Adv = mkAdv "einfach" ; -- status=guess
lin contain_V2 = mkV2 (fixprefixV "ent" I.halten_V) ;
lin especially_Adv = mkAdv "besonders" ; -- status=guess
lin open_A = mkA "offen" ;
lin short_A = L.short_A ;
lin personal_A = mkA "persönlich" | mkA "privat" ; --- split: my personal mission / this is a very personal issue
lin detail_N = mkN "Detail" "Details" neuter ;
lin model_N = mkN "Model" "Models" neuter | mkN "Modell" "Modelle" neuter ; --- fashion model / newest car model
lin bear_V2 = mkV2 I.tragen_V | mkV2 (fixprefixV "er" I.tragen_V) ; --- split: bear a heavy weight / bear pain
lin bear_V = irregV "tragen" "tragt" "trug" "trüge" "getragen" ; --- delete: false extraction
lin single_A = variants{} ; -- 
lin single_2_A = mkA "alleinstehend" ;
lin single_1_A = mkA "einzeln" ;
lin join_V2 = mkV2 (prefixV "bei" I.treten_V) ;
lin join_V = prefixV "bei" I.treten_V ;
lin reduce_V2 = mkV2 (mkV "reduzieren") | mkV2 (fixprefixV "ver" (mkV "ringern")) ;
lin reduce_V = reflV (fixprefixV "ver" (mkV "ringern")) accusative ;
lin establish_V2 = mkV2 (mkV "etablieren") ;
lin wall_N = mkN "Mauer" "Mauern" feminine ;
lin face_V2 = mkV2 (fixprefixV "gegenüber" I.stehen_V) ; --- note: let's face it - worth a separate meaning? very specific English phrase
lin face_V = irregV "stellen" "stellt" "stellte" "stelle" "gestellt" ; --- delete: false extraction
lin easy_A = mk3A "leicht" "leichter" "leichteste" | mk3A "einfach" "einfacher" "einfachste" ; -- status=guess status=guess
lin private_A = mk3A "privat" "privater" "privateste" ; -- status=guess
lin computer_N = L.computer_N ;
lin hospital_N = mkN "Krankenhaus" "Krankenhäuser" neuter ;
lin chapter_N = mkN "Kapitel" neuter ;
lin scheme_N = mkN "Plan" "Pläne" masculine ;
lin theory_N = mkN "Theorie" ; --
lin choose_VV = mkVV (fixprefixV "ent" I.scheiden_V) ;
lin choose_V2 = mkV2 (mkV "wählen") ;
lin wish_VV = mkVV (reflV (mkV "wünschen") dative) ;
lin wish_VS = mkVS (mkV "wünschen") ; -- status=guess, src=wikt
lin wish_V2V = mkV2V (mkV "wünschen") ; --- delete: false extraction
lin wish_V2 = mkV2 (reflV (mkV "wünschen") dative) ;
lin wish_V = mkV "wünschen" ; -- status=guess, src=wikt
lin property_N = variants{} ; -- 
lin property_2_N = mkN "Eigenschaft" feminine ; --
lin property_1_N = mkN "Grundstück" "Grundstücke" neuter | mkN "Besitz" ; --- split further: a large property / this is currently in my property
lin achieve_V2 = mkV2 (fixprefixV "er" (mkV "reichen")) ;
lin financial_A = regA "finanziell" ; -- status=guess
lin poor_A = variants{} ; -- 
lin poor_3_A = mkA "schlecht" ;
lin poor_2_A = mkA "arm" "ärmer" "ärmste" ;
lin poor_1_A = mkA "arm" "ärmer" "ärmste" ;
lin officer_N = variants{} ; -- 
lin officer_3_N = mkN "Beamte" "Beamten" masculine ;
lin officer_2_N = mkN "Offizier" "Offiziere" masculine ;
lin officer_1_N = mkN "Chef" "Chefs" masculine | mkN "Vorstand" "Vorstände" masculine ;
lin up_Prep = mkPrep accusative "hinauf" ;
lin charge_N = variants{} ; -- 
lin charge_2_N = mkN "Anklage" | mkN "Gebühr" feminine ; --- split further: charge against him | high charges of the phone company
lin charge_1_N = mkN "Ladung" ;
lin director_N = mkN "Direktor" "Direktoren" masculine | mkN "Regisseur" ; --- split: director of the company / director of the movie
lin drive_V2V = mkV2V (prefixV "weg" (irregV "fahren" "fahrt" "fuhr" "führe" "gefahren")) ; -- delete: false extraction; what about V2A ? (drive her crazy)
lin drive_V2 = mkV2 I.fahren_V ;
lin drive_V = I.fahren_V ;
lin deal_V2 = mkV2 (prefixV "aus" (mkV "teilen")) ;
lin deal_V = mkV "handeln" ;
lin place_V2 = mkV2 (mkV "stellen") | mkV2 (prefixV "ein" (mkV "ordnen")) ; --- split: place the vase on the table / I can't place you
lin approach_N = mkN "Annäherung" | mkN "Zugang" "Zugänge" masculine ; --- split: the car's sudden approach / this book's approach
lin chance_N = mkN "Zufall" "Zufälle" masculine | mkN "Chance" ; --- split: by chance / great chance (opportunity)
lin application_N = mkN "Bewerbung" | mkN "Anwendung" ; --- split: application to university / application of my knowledge
lin seek_VV = mkVV (prefixV "an" (mkV "streben")) ;
lin seek_V2 = L.seek_V2 ;
lin foreign_A = variants{} ; -- 
lin foreign_2_A = mkA "fremd" ;
lin foreign_1_A = mkA "fremd" ;
lin along_Prep = mkPrep genitive "entlang" ;
lin top_N = mkN "Spitze" ;
lin amount_N = mkN "Menge" | mkN "Summe" ; -- split: large amount of bunnies | total amount
lin son_N = mkN "Sohn" "Söhne" masculine ;
lin operation_N = mkN "Operation" | mkN "Betrieb" ; -- split: knee operation | smooth operation of the factory
lin fail_VV = mkVV (compoundV "nicht" (mkV "schaffen")) ;
lin fail_V2 = mkV2 (compoundV "nicht" (mkV "be" I.stehen_V)) ;
lin fail_V = mkV "scheitern" ;
lin human_A = mk3A "menschlich" "menschlicher" "menschlichste" ;
lin opportunity_N = mkN "Gelegenheit" feminine | mkN "Chance" ; -- split: at this opportunity | great opportunity
lin simple_A = mk3A "einfach" "einfacher" "einfachste" ;
lin leader_N = mkN "Anführer" | mkN "Führer" ;
lin look_N = mkN "Blick" ;
lin share_N = mkN "Anteil" | mkN "Aktie" ; -- split: my share of the money / stock market shares
lin production_N = mkN "Produktion" ;
lin recent_A = mkA "jüngst" | mk3A "neu" "neuer" "neusten, neueste" ;
lin firm_N = mkN "Firma" "Firmen" feminine ;
lin picture_N = mkN "Bild" ;
lin source_N = mkN "Quelle" ;
lin security_N = mkN "Sicherheit" ;
lin serve_V2 = mkV2 (mkV "be" (mkV "dienen")) | mkV2 (mkV "servieren") ; -- split: serve somebody (dative in German) / serve something
lin serve_V = mkV "dienen" ;
lin according_to_Prep = mkPrep "laut" dative ;
lin end_V2 = mkV2 (mkV "be" (mkV "enden")) ;
lin end_V = mkV "enden" ;
lin contract_N = mkN "Vertrag" "Verträge" masculine ;
lin wide_A = L.wide_A ;
lin occur_V = I.geschehen_V ;
lin agreement_N = mkN "Vereinbarung" ;
lin better_Adv = mkAdv "besser" ;
lin kill_V2 = L.kill_V2 ;
lin kill_V = mkV "töten" ;
lin act_V2 = mkV2 (mkV "spielen") ;
lin act_V = mkV "handeln" | reflV (mkV "be" I.nehmen_V) accusative ; -- split: take action | act like a lady
lin site_N = mkN "Grundstück" "Grundstücke" neuter ;
lin either_Adv = mkAdv "auch nicht" ;
lin labour_N = mkN "Arbeit" feminine ;
lin plan_VV = mkVV (mkV "vor" I.haben_V) ;
lin plan_VS = mkVS (mkV "vor" I.haben_V) ;
lin plan_V2V = mkV2V (regV "planen") ; -- delete: false extraction
lin plan_V2 = mkV2 (mkV "planen") ;
lin plan_V = mkV "planen" ;
lin various_A = mkA "verschiedene" ;
lin since_Prep = mkPrep "seit" dative ;
lin test_N = mkN "Test" "Tests" masculine | mkN "Prüfung" ;
lin eat_V2 = L.eat_V2 ;
lin eat_V = I.essen_V | I.fressen_V ; -- split: human eating | animal eating
lin loss_N = mkN "Verlust" ;
lin close_V2 = L.close_V2 ;
lin close_V = I.schließen_V ;
lin represent_V2 = mkV2 (mkV "ver" I.treten_V) | mkV2 (prefixV "dar" (mkV "stellen")) ; -- split: represent Austria at this event | this picture represents a dancing elephant
lin represent_V = prefixV "dar" (regV "stellen") | mkV "repräsentieren" ; --- delete: false extraction
lin love_VV = mkVV (mkV "lieben") ; --- note: I love running / to run = ich liebe ES zu laufen.
lin love_V2 = L.love_V2 ;
lin colour_N = mkN "Farbe" ;
lin clearly_Adv = mkAdv "eindeutig" ;
lin shop_N = L.shop_N ;
lin benefit_N = mkN "Vorteil" ;
lin animal_N = L.animal_N ;
lin heart_N = L.heart_N ;
lin election_N = mkN "Wahl" feminine ;
lin purpose_N = mkN "Zweck" ;
lin standard_N = mkN "Standard" "Standards" masculine ;
lin due_A = mkA "fällig" ;
lin secretary_N = mkN "Sekretär" masculine | mkN "Sekretärin" "Sekretärinnen" feminine ; -- note: consider making a noun category for the standard masculine/feminine on -innen variation
lin rise_V2 = mkV2 (fixprefixV "er" I.heben_V) ;
lin rise_V = prefixV "an" I.steigen_V | reflV (fixprefixV "er" I.heben_V) accusative ; -- split: prices rise / rise from your chair
lin date_N = variants{} ; -- 
lin date_7_N = mkN "Dattel" "Datteln" feminine ;
lin date_3_N = variants{} ; -- 
lin date_3_N = variants{} ; -- 
lin date_1_N = mkN "Datum" "Datum" "Datum" "Datums" "Daten" "Daten" neuter ;
lin hard_A = variants{} ; -- 
lin hard_2_A = mkA "schwer" ;
lin hard_1_A = mkA "hart" "härter" "härteste" ;
lin music_N = L.music_N ;
lin hair_N = L.hair_N ;
lin prepare_VV = mkVV (reflV (fixprefixV "vor" (mkV "bereiten")) accusative) ;
lin prepare_V2V = mkV2V (fixprefixV "vor" (mkV "bereiten")) ;
lin prepare_V2 = mkV2 (fixprefixV "vor" (mkV "bereiten")) ;
lin prepare_V = reflV (fixprefixV "vor" (mkV "bereiten")) accusative ;
lin factor_N = mkN "Faktor" "Faktor" "Faktor" "Faktors" "Faktoren" "Faktoren" ;
lin other_A = mkA "ander" ;
lin anyone_NP = M.nameNounPhrase {s = R.caselist "jeder" "jeden" "jedem" "jedes"} ;
lin pattern_N = mkN "Muster" neuter ;
lin manage_VV = mkVV (mkV "schaffen") ;
lin manage_V2 = mkV2 (mkV "führen") | mkV2 (mkV "schaffen") ; -- split: manage a company / manage a trick
lin manage_V = mkV "schaffen" ;
lin piece_N = mkN "Stück" "Stücke" neuter ;
lin discuss_VS = mkVS (mkV "diskutieren") | mkVS (fixprefixV "be" I.sprechen_V) ;
lin discuss_V2 = mkV2 (fixprefixV "be" I.sprechen_V) ;
lin prove_VS = mkVS (fixprefixV "be" I.weisen_V) ;
lin prove_VA = mkVA (reflV (fixprefixV "er" I.weisen_V) accusative) ; -- status=guess, src=wikt status=guess, src=wikt
lin prove_V2 = mkV2 (fixprefixV "be" I.weisen_V) ; -- status=guess, src=wikt status=guess, src=wikt
lin prove_V = irregV "beweisen" "beweist" "bewies" "bewiese" "bewiesen" | mkV "prüfen" ; -- delete: false extraction
lin front_N = mkN "Vorderseite" | mkN "Front" feminine ; -- split: front of the building / battle front
lin evening_N = mkN "Abend" ;
lin royal_A = mkA "königlich" ;
lin tree_N = L.tree_N ;
lin population_N = mkN "Bevölkerung" ;
lin fine_A = mkA "genau" | mkA "schön" | mkA "fein" | mkA "okay" ; --- split: fine, precise line | what a fine day | fine grained | it's fine (ok; this sense only used as predicate adj?)
lin plant_N = mkN "Pflanze" ;
lin pressure_N = mkN "Druck" "Drücke" masculine ;
lin response_N = mkN "Antwort" feminine ;
lin catch_V2 = mkV2 (I.fangen_V) | mkV2 (prefixV "ein" I.fangen_V);
lin street_N = mkN "Straße" ;
lin pick_V2 = mkV2 (mkV "pflücken") | mkV2 (mkV "wählen") ; --- split: pick berries | pick a team
lin pick_V = mkV "wählen" ;
lin performance_N = variants{} ; -- 
lin performance_2_N = mkN "Vorstellung" ;
lin performance_1_N = mkN "Leistung" ;
lin knowledge_N = mkN "Wissen" neuter ;
lin despite_Prep = mkPrep "trotz" genitive ;
lin design_N = mkN "Entwurf" "Entwürfe" masculine | mkN "Design" "Designs" neuter ; --- split: first design / beautiful design work
lin page_N = mkN "Seite" ;
lin enjoy_VV = mkVV (I.genießen_V) ; -- note: ich genieße ES zu schwimmen (cf. love_VV)
lin enjoy_V2 = mkV2 (I.genießen_V) ;
lin individual_N = mkN "Individuum" "Individuum" "Individuum" "Individuums" "Individuen" "Individuen" neuter ;
lin suppose_VS = mkVS (prefixV "an" I.nehmen_V) ;
lin suppose_V2 = mkV2 (prefixV "an" I.nehmen_V) ;
lin rest_N = mkN "Rest" | mkN "Pause" ; --- split: the rest | have a rest
lin instead_Adv = mkAdv "stattdessen" ;
lin wear_V2 = mkV2 I.tragen_V ;
lin wear_V = mkV "verschleißen" ; --- delete: false extraction
lin basis_N = mkN "Basis" "Basen" feminine | mkN "Grundlage" ;
lin size_N = mkN "Größe" feminine ;
lin environment_N = mkN "Umgebung" | mkN "Umwelt" feminine ; -- split: your direct environment | environmentally friendly
lin per_Prep = mkPrep "per" accusative ;
lin fire_N = variants{} ; -- 
lin fire_2_N = L.fire_N ; -- ?
lin fire_1_N = L.fire_N ; -- ?
lin series_N = mkN "Folge" | mkN "Serie" ; --- split: series of murders | TV series
lin success_N = mkN "Erfolg" ;
lin natural_A = mkA "natürlich" ;
lin wrong_A = mkA "falsch" ;
lin near_Prep = mkPrep "nahe" dative ;
lin round_Adv = mkAdv "herum" ;
lin thought_N = mkN "Gedanke" masculine ;
lin list_N = mkN "Liste" ;
lin argue_VS = mkVS (mkV "argumentieren") ;
lin argue_V2 = mkV2 (mkV "argumentieren") ;
lin argue_V = irregV "diskutieren" "diskutiert" "diskutierte" "diskutierte" "diskutiert" ;
lin final_A = mkA "endgültig" | mkA "letzt" ;
lin future_N = variants{} ; -- 
lin future_3_N = mkN "Zukunft" "Zukünfte" feminine ; -- ??
lin future_1_N = mkN "Zukunft" "Zukünfte" feminine ; -- ??
lin introduce_V2 = mkV2 (prefixV "vor" (mkV "stellen")) ;
lin analysis_N = mkN "Analyse" ;
lin enter_V2 = mkV2 (prefixV "ein" I.treten_V) | mkV2 (prefixV "teil" I.nehmen_V) | mkV2 (fixprefixV "be" I.treten_V) ; --- split: enter the monastery | enter a competition (AN etw. teilnehmen; didn't want to put prep as compound) | enter a room
lin enter_V = prefixV "ein" I.treten_V ;
lin space_N = mkN "Weltall" neuter | mkN "Platz" "Plätze" masculine ; --- split: enough space | outer space
lin arrive_V = prefixV "an" I.kommen_V ;
lin ensure_VS = mkVS (fixprefixV "ver" (mkV "sichern")) ;
lin ensure_V2 = mkV2 (fixprefixV "ver" (mkV "sichern")) ;
lin ensure_V = prefixV "sicher" (irregV "stellen" "stellt" "stellte" "stelle" "gestellt") | mkV "gewährleisten" ; -- delete: false extraction
lin demand_N = mkN "Nachfrage" ;
lin statement_N = mkN "Aussage" ;
lin to_Adv = mkAdv "zu" ; -- note: not sure about usage of this?
lin attention_N = mkN "Aufmerksamkeit" "Aufmerksamkeiten" feminine ;
lin love_N = L.love_N ;
lin principle_N = mkN "Prinzip" "Prinzip" "Prinzip" "Prinzips" "Prinzipien" "Prinzipien" neuter ;
lin pull_V2 = L.pull_V2 ;
lin pull_V = I.ziehen_V ;
lin set_N = variants{} ; -- 
lin set_2_N = mkN "Menge" ;
lin set_1_N = mkN "Set" "Sets" neuter ;
lin doctor_N = L.doctor_N ;
lin choice_N = mkN "Wahl" feminine | mkN "Auswahl" feminine ; -- split: difficult choice | a large choice
lin refer_V2 = mkV2 (fixprefixV "über" I.weisen_V) ; -- note: only: to refer someone TO someone
lin refer_V = reflV (fixprefixV "be" I.ziehen_V) accusative ; -- note only to refer TO something / sich AUF etwas beziehen
lin feature_N = mkN "Eigenschaft" feminine ;
lin couple_N = mkN "Paar" "Paare" neuter ;
lin step_N = mkN "Schritt" | mkN "Stufe" ; -- split: take a step | step of stairs
lin following_A = mkA "folgend" ;
lin thank_V2 = mkV2 (mkV "danken") | mkV2 (reflV (fixprefixV "be" (mkV "danken")) accusative) ; -- note: ich danke dir BUT ich bedanke mich BEI dir
lin machine_N = mkN "Maschine" ;
lin income_N = mkN "Einkommen" neuter ;
lin training_N = mkN "Ausbildung" | mkN "Training" "Trainings" neuter ; -- split: teacher training | gym training
lin present_V2 = mkV2 (mkV "präsentieren") ;
lin association_N = mkN "Assoziation" | mkN "Verein" ; -- split: mental connection | football association
lin film_N = variants{} ; -- 
lin film_2_N = mkN "Belag" "Beläge" masculine ;
lin film_1_N = mkN "Film" ;
lin region_N = mkN "Gegend" feminine | mkN "Region" ;
lin effort_N = mkN "Anstrengung" ;
lin player_N = mkN "Spieler" ;
lin everyone_NP = M.nameNounPhrase {s = R.caselist "jeder" "jeden" "jedem" "jedes"} ;
lin present_A = mkA "gegenwärtig" | mkA "anwesend" ; -- split: current | physically present
lin award_N = mkN "Preis" ;
lin village_N = L.village_N ;
lin control_V2 = mkV2 (mkV "steuern") | mkV2 (mkV "kontrollieren") ;
lin organisation_N = mkN "Organisation" ;
lin whatever_Det = variants{} ; -- 
lin news_N = mkN "Nachricht" feminine | mkN "Neuigkeit" feminine ; -- split: have you read the news today | she told me good news; note: only plural (unlike in English also in agreement)
lin nice_A = mkA "nett" | mkA "schön" ; -- split: he's nice | what a nice house
lin difficulty_N = mkN "Schwierigkeit" feminine ;
lin modern_A = mkA "modern" ;
lin cell_N = mkN "Zelle" ; -- status=guess
lin close_A = mkA "nah" "näher" "nächste" ;
lin current_A = mkA "gegenwärtig" ;
lin legal_A = regA "legal" ;
lin energy_N = mkN "Energie" ;
lin finally_Adv = mkAdv "endlich" ;
lin degree_N = variants{} ; -- 
lin degree_3_N = mkN "Grad" ;
lin degree_2_N = mkN "Abschluss" "Abschlüsse" masculine ;
lin degree_1_N = mkN "Grad" ;
lin mile_N = mkN "Meile" ;
lin means_N = mkN "Mittel" neuter ;
lin growth_N = mkN "Wachstum" neuter ; -- note: no plural
lin treatment_N = mkN "Behandlung" ;
lin sound_N = mkN "Geräusch" "Geräusche" neuter | mkN "Klang" "Klänge" masculine ; -- split I heard a strange sound | guitar sound
lin above_Prep = S.above_Prep ;
lin task_N = mkN "Aufgabe" ;
lin provision_N = mkN "Maßnahme" ;
lin affect_V2 = mkV2 (fixprefixV "be" (mkV "einflussen")) ;
lin please_Adv = mkAdv "bitte" ;
lin red_A = L.red_A ;
lin happy_A = mkA "glücklich" ;
lin behaviour_N = mkN "Verhalten" neuter | mkN "Benehmen" neuter ; -- split: her behaviour around me is strange | bad behaviour
lin concerned_A = mkA "beunruhigt" | mkA "betroffen" ; -- split: worried / affected
lin point_V2 = mkV2 (mkV "zeigen") ;
lin point_V = mkV "zeigen" ;
lin function_N = mkN "Funktion" | mkN "Zweck" ;
lin identify_V2 = mkV2 (mkV "identifizieren") ;
lin identify_V = mkReflV "identifizieren mit" ; -- delete: false extraction
lin resource_N = mkN "Ressource" | mkN "Mittel" neuter ; -- split: limited resources / study resource
lin defence_N = mkN "Verteidigung" ;
lin garden_N = L.garden_N ;
lin floor_N = L.floor_N ;
lin technology_N = mkN "Technologie" ;
lin style_N = mkN "Stil" ;
lin feeling_N = mkN "Gefühl" "Gefühle" neuter ;
lin science_N = L.science_N ;
lin relate_V2 = mkV2 (fixprefixV "be" (mkV "richten")) ;
lin relate_V = reflV (fixprefixV "be" I.ziehen_V) accusative ; -- note: relate to something?
lin doubt_N = mkN "Zweifel" ;
lin horse_N = L.horse_N ;
lin force_VS = mkVS (fixprefixV "er" I.zwingen_V) ;
lin force_V2V = mkV2V I.zwingen_V ;
lin force_V2 = mkV2 I.zwingen_V ;
lin force_V = mkV "erzwingen" ; -- delete: false extraction
lin answer_N = mkN "Antwort" feminine ;
lin compare_V = fixprefixV "ver" I.gleichen_V ; -- note: why no compare_V2 (I compared the two essays)
lin suffer_V2 = mkV2 (fixprefixV "er" I.leiden_V) ;
lin suffer_V = I.leiden_V ;
lin individual_A = mk3A "individuell" "individueller" "individuellste" ;
lin forward_Adv = mkAdv "vorwärts" ;
lin announce_VS = mkVS (prefixV "an" (mkV "kündigen")) | mkVS (fixprefixV "ver" (mkV "künden")) ;
lin announce_V2 = mkV2 (prefixV "an" (mkV "kündigen")) ;
lin userMasc_N = mkN "Benutzer" masculine ;
lin fund_N = mkN "Fonds" "Fonds" "Fonds" "Fonds" "Fonds" "Fonds" ;
lin character_2_N = mkN "Zeichen" neuter | mkN "Buchstabe" masculine ;
lin character_1_N = mkN "Charakter" ;
lin risk_N = mkN "Risiko" "Risiko" "Risiko" "Risikos" "Risiken" "Risiken" neuter ;
lin normal_A = mk3A "normal" "normaler" "normalste" ;
lin nor_Conj = {s1 = "weder" ; s2 = "noch" ; n = R.Pl} ;
lin dog_N = L.dog_N ;
lin obtain_V2 = mkV2 (fixprefixV "er" I.halten_V) ;
lin obtain_V = I.gelten_V ;
lin quickly_Adv = mkAdv "schnell" | mkAdv "rasch" ;
lin army_N = mkN "Armee" ;
lin indicate_VS = mkVS (prefixV "an" (mkV "zeigen")) ;
lin indicate_V2 = mkV2 (prefixV "an" (mkV "zeigen")) | mkV2 (mkV "zeigen") ;
lin forget_VS = mkVS (mkV "vergessen" "vergisst" "vergaß" "vergäße" "vergessen") ;
lin forget_V2 = L.forget_V2 ;
lin forget_V = mkV "vergessen" "vergisst" "vergaß" "vergäße" "vergessen" ;
lin station_N = mkN "Station" ;
lin glass_N = mkN "Glas" "Gläser" neuter ;
lin cup_N = mkN "Tasse" | mkN "Pokal" ; -- split: drink from a cup | football cup
lin previous_A = mkA "vorherig" ;
lin husband_N = L.husband_N ;
lin recently_Adv = mkAdv "neulich" | mkAdv "kürzlich" | mkAdv "unlängst" | mkAdv "vor kurzem" ;
lin publish_V2 = mkV2 (fixprefixV "ver" (mkV "öffentlichen")) ;
lin publish_V = fixprefixV "ver" (mkV "öffentlichen") ;
lin serious_A = mk3A "ernst" "ernster" "ernsteste" | mk3A "ernsthaft" "ernsthafter" "ernsthafteste" ;
lin anyway_Adv = mkAdv "trotzdem" ;
lin visit_V2 = mkV2 (fixprefixV "be" (mkV "suchen")) ;
lin visit_V = fixprefixV "be" (mkV "suchen") ;
lin capital_N = variants{} ; -- 
lin capital_3_N = mkN "Großbuchstabe" masculine ;
lin capital_2_N = mkN "Kapital" "Kapitale" neuter ;
lin capital_1_N = mkN "Hauptstadt" "Hauptstädte" feminine ;
lin either_Det = M.detLikeAdj False M.Sg "beid" ;
lin note_N = variants{} ; -- 
lin note_3_N = mkN "Ton" "Töne" masculine ;
lin note_2_N = mkN "Notiz" feminine ;
lin note_1_N = mkN "Notiz" feminine ; -- disambiguation not clear to me; take notes or take note of something?
lin season_N = mkN "Staffel" "Staffeln" feminine | mkN "Jahreszeit" feminine ; --- split: season of a series | spring, summer, ...
lin argument_N = mkN "Argument" "Argumente" neuter ;
lin listen_V = prefixV "zu" (mkV "hören") ;
lin show_N = mkN "Schau" feminine | mkN "Show" "Shows" feminine ;
lin responsibility_N = mkN "Verantwortung" ;
lin significant_A = mkA "wesentlich" | mkA "erheblich" ; -- split: significant fact / significant difference
lin deal_N = mkN "Abkommen" | mkN "Abmachung" ;
lin prime_A = mkA "erste" | mkA "Premier-" ;
lin economy_N = variants{} ; -- 
lin economy_2_N = mkN "Einsparung" | mkN "Ersparnis" ;
lin economy_1_N = mkN "Ökonomie" | mkN "Wirtschaft" feminine ;
lin element_N = mkN "Element" "Elemente" neuter ;
lin finish_V2 = mkV2 (prefixV "fertig" (mkV "stellen")) | mkV2 (fixprefixV "be" (mkV "enden")) ;
lin finish_V = prefixV "auf" (mkV "hören") | mkV "enden" ;
lin duty_N = mkN "Pflicht" feminine ;
lin fight_V2 = L.fight_V2 ;
lin fight_V = mkV "kämpfen" ;
lin train_V2V = mkV2V (mkV "trainieren") ;
lin train_V2 = mkV2 (mkV "trainieren") ;
lin train_V = mkV "trainieren" ;
lin maintain_VS = mkVS (fixprefixV "be" (mkV "haupten")) ;
lin maintain_V2 = mkV2 (mkV "führen") | mkV2 (fixprefixV "er" I.halten_V) ; -- split: maintain a record / maintain a house
lin maintain_V = irregV "unterhalten" "unterhält" "unterhielt" "unterhielte" "unterhalten" | irregV "warten" "wartet" "wartete" "warte" "gewartet" ; -- delete: false extraction
lin attempt_N = variants{} ; -- 
lin leg_N = L.leg_N ;
lin investment_N = mkN "Investition" ;
lin save_V2 = mkV2 (mkV "sparen") | mkV2 (mkV "retten") ; -- split: save money / save a life
lin save_V = mkV "sparen" ;
lin throughout_Prep = mkPrep "in ganz" accusative | mkPrep "während" genitive ; --- split: local (throughout Europe) / temporal (throughout this year) - NOTE: throughout the year - während des GANZEN Jahres - how should this be implemented?
lin design_V2 = mkV2 (mkV "planen") | mkV2 (fixprefixV "ent" I.werfen_V) | mkV2 (fixprefixV "ent" (mkV "wickeln")) ;
lin design_V = fixprefixV "ent" I.werfen_V ;
lin suddenly_Adv = mkAdv "plötzlich" ;
lin brother_N = mkN "Bruder" masculine ;
lin improve_V2 = mkV2 (fixprefixV "ver" (mkV "bessern")) ;
lin improve_V = reflV (fixprefixV "ver" (mkV "bessern")) accusative ;
lin avoid_VV = mkVV (fixprefixV "ver" I.meiden_V) | mkVV (I.meiden_V) ; -- note: ich vermeide ES zu laufen (cf. love_VV)
lin avoid_V2 = mkV2 (fixprefixV "ver" I.meiden_V) | mkV2 (I.meiden_V) ;
lin wonder_VQ = L.wonder_VQ ;
lin wonder_V = reflV (mkV "wundern") accusative ;
lin tend_VV = mkVV (mkV "tendieren") | mkVV (mkV "neigen") ;
lin tend_V2 = mkV2 (mkV "pflegen") ;
lin title_N = mkN "Titel" ;
lin hotel_N = mkN "Hotel" "Hotels" neuter ;
lin aspect_N = mkN "Ansicht" feminine | mkN "Aspekt" ;
lin increase_N = mkN "Anstieg" | mkN "Wachstum" neuter | mkN "Erhöhung" feminine | mkN "Zunahme" ;
lin help_N = mkN "Hilfe" ;
lin industrial_A = regA "industriell" | mkA "Industrie-" ;
lin express_V2 = mkV2 (prefixV "aus" (mkV "drücken")) | mkV2 (mkV "äußern") ;
lin summer_N = mkN "Sommer" ;
lin determine_VV = mkVV (reflV (fixprefixV "ent" I.scheiden_V) accusative) ;
lin determine_VS = mkVS (fixprefixV "be" I.schließen_V) ; -- status=guess, src=wikt
lin determine_V2V = mkV2V (prefixV "fest" (regV "legen")) ; -- delete: false extraction
lin determine_V2 = mkV2 (prefixV "fest" (mkV "legen")) ;
lin determine_V = prefixV "fest" (regV "legen") ; -- delete: false extraction
lin generally_Adv = mkAdv "im Allgemeinen" ;
lin daughter_N = mkN "Tochter" "Töchter" feminine ;
lin exist_V = fixprefixV "be" I.stehen_V | mkV "existieren" ;
lin share_V2 = mkV2 (mkV "teilen") ;
lin share_V = mkV "teilen" ;
lin baby_N = L.baby_N ;
lin nearly_Adv = mkAdv "beinahe" | fast_Adv ;
lin smile_V = mkV "lächeln" ;
lin sorry_A = mkA "traurig" | mkA "armselig" ; -- note: I am sorry = es tut mir Leid.
lin sea_N = L.sea_N ;
lin skill_N = mkN "Fähigkeit" feminine | mkN "Fertigkeit" feminine ;
lin claim_N = mkN "Anspruch" "Ansprüche" masculine ;
lin treat_V2 = mkV2 (fixprefixV "be" (mkV "wirten")) ;
lin treat_V = reflV (mkV "gönnen") dative ; -- note: only "I treat myself"
lin remove_V2 = mkV2 (fixprefixV "ent" (mkV "fernen")) ;
lin remove_V = irregV "umziehen" "zieht" "zog" "zöge" "umzogen" ; -- delete: false extraction
lin concern_N = mkN "Sorge" ;
lin university_N = L.university_N ;
lin left_A = mkA "link" ;
lin dead_A = mkA "tot" ;
lin discussion_N = mkN "Diskussion" ;
lin specific_A = mk3A "spezifisch" "spezifischer" "spezifischste" ;
lin customerMasc_N = mkN "Kunde" masculine ;
lin box_N = mkN "Box" feminine ;
lin outside_Prep = mkPrep "außerhalb" genitive ;
lin state_VS = mkVS (fixprefixV "be" (mkV "haupten")) | mkVS (prefixV "an" I.geben_V) ;
lin state_V2 = mkV2 (fixprefixV "be" (mkV "haupten")) | mkV2 (prefixV "an" I.geben_V) ;
lin conference_N = mkN "Konferenz" feminine ;
lin whole_N = mkN "Ganze" neuter ; -- note: sg only
lin total_A = regA "komplett" | regA "total" ;
lin profit_N = mkN "Nutzen" | mkN "Profit" ; -- split: gain | financial gain
lin division_N = variants{} ; -- 
lin division_3_N = mkN "Division" ;
lin division_2_N = mkN "Sparte" ;
lin division_1_N = mkN "Abteilung" ;
lin throw_V2 = L.throw_V2 ;
lin throw_V = I.werfen_V ;
lin procedure_N = mkN "Maßnahme" ;
lin fill_V2 = mkV2 (mkV "füllen") | mkV2 (prefixV "aus" (mkV "füllen")) ;
lin fill_V = reflV (mkV "füllen") accusative ;
lin king_N = L.king_N ;
lin assume_VS = mkVS (prefixV "an" I.nehmen_V) ;
lin assume_V2 = mkV2 (prefixV "an" I.nehmen_V) ;
lin image_N = mkN "Image" "Images" neuter | mkN "Bild" neuter ; -- split: he has a bad image / a beautiful image
lin oil_N = L.oil_N ;
lin obviously_Adv = mkAdv "offensichtlich" ;
lin unless_Subj = ss "es sei denn" ;
lin appropriate_A = mkA "angemessen" ;
lin circumstance_N = mkN "Umstand" "Umstände" masculine ;
lin military_A = mkA "militärisch" ;
lin proposal_N = mkN "Angebot" "Angebote" neuter | mkN "Vorschlag" "Vorschläge" masculine | mkN "Heiratsantrag" "Heiratsanträge" masculine ; -- split: proposal (Angebot / Vorschlag) / marriage proposal (Heiratsantrag)
lin mention_VS = mkVS (fixprefixV "er" (mkV "wähnen")) ;
lin mention_V2 = mkV2 (fixprefixV "er" (mkV "wähnen")) ;
lin mention_V = mkV "erwähnen" ; --- delete: false extraction
lin client_N = mkN "Kunde" masculine | mkN "Klient" "Klienten" masculine ;
lin sector_N = mkN "Bereich" | mkN "Abschnitt" ;
lin direction_N = mkN "Richtung" ;
lin admit_VS = mkVS (prefixV "zu" I.geben_V) ;
lin admit_V2 = mkV2 (prefixV "ein" I.lassen_V) | mkV2 (prefixV "zu" I.lassen_V) | mkV2 (prefixV "zu" I.geben_V) ; --- split: admit a person (einlassen / zulassen) / admit the truth
lin admit_V = prefixV "ein" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen") | prefixV "zu" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen") ; -- delete: false extraction
lin though_Adv = mkAdv "aber" | mkAdv "dennoch" | mkAdv "allerdings" ;
lin replace_V2 = mkV2 (fixprefixV "er" (mkV "setzen")) ;
lin basic_A = mk3A "basisch" "basischer" "basischste" | mkA "grundsätzlich" | mkA "einfach" ; -- split: chemical (basisch) / basics
lin hard_Adv = mkAdv "schwer" ;
lin instance_N = mkN "Beispiel" "Beispiele" neuter ;
lin sign_N = mkN "Zeichen" neuter ;
lin original_A = mkA "original" | mkA "originell" ; -- split: original author / original joke
lin successful_A = mk3A "erfolgreich" "erfolgreicher" "erfolgreichste" ;
lin okay_Adv = mkAdv "okay" ;
lin reflect_V2 = mkV2 (mkV "reflektieren") | mkV2 (prefixV "wieder" (mkV "spiegeln")) ;
lin reflect_V = prefixV "nach" I.denken_V ;
lin aware_A = mk3A "bewusst" "bewusster" "bewussteste" ;
lin measure_N = mkN "Maß" "Maße" neuter | mkN "Maßnahme" ; -- split: measurement | action taken
lin attitude_N = mkN "Einstellung" ;
lin disease_N = mkN "Krankheit" feminine ;
lin exactly_Adv = mkAdv "genau" ;
lin above_Adv = mkAdv "darüber" | mkAdv "oben" | mkAdv "oberhalb" ;
lin commission_N = mkN "Kommission" ;
lin intend_VV = mkVV (fixprefixV "be" (mkV "absichtigen")) | mkVV (prefixV "vor" I.haben_V) ;
lin beyond_Prep = mkPrep "jenseits" genitive | mkPrep "über" accusative "hinaus" ;
lin seat_N = mkN "Sitz" ;
lin presidentMasc_N = mkN "Präsident" "Präsidenten" masculine ;
lin encourage_V2V = mkV2V (fixprefixV "er" (mkV "mutigen")) ;
lin encourage_V2 = mkV2 (fixprefixV "unter" (mkV "stützen")) ;
lin addition_N = mkN "Zuschlag" "Zuschläge" masculine | mkN "Ergänzung" ;
lin goal_N = mkN "Tor" "Tore" neuter | mkN "Ziel" "Ziele" neuter ; -- split: football goal / goal in life
lin round_Prep = mkPrep "um" accusative "herum" ;
lin miss_V2 = mkV2 (fixprefixV "ver" (mkV "passen")) | mkV2 (mkV "fehlen") ; -- miss a deadline / miss someone - NOTE: I miss you = du fehlst mir!
lin miss_V = prefixV "daneben" I.schießen_V | prefixV "daneben" I.schlagen_V ;
lin popular_A = mk3A "beliebt" "beliebter" "beliebteste" | mkA "populär" ; -- split: popular person / pop music
lin affair_N = mkN "Affäre" | mkN "Angelegenheit" feminine ; -- split: romantic affair / serious affairs
lin technique_N = mkN "Methode" | mkN "Technik" feminine ;
lin respect_N = mkN "Achtung" | mkN "Respekt" ;
lin drop_V2 = mkV2 (compoundV "fallen" I.lassen_V) ;
lin drop_V = I.fallen_V ;
lin professional_A = mk3A "professionell" "professioneller" "professionellste" ;
lin less_Det = M.detLikeAdj False M.Pl "weniger" ;
lin once_Subj = ss "sobald" ;
lin item_N = mkN "Gegenstand" "Gegenstände" masculine | mkN "Artikel" | mkN "Objekt" "Objekte" neuter ;
lin fly_V2 = mkV2 I.fliegen_V ;
lin fly_V = L.fly_V ;
lin reveal_VS = mkVS (prefixV "auf" (mkV "decken")) | mkVS (mkV "zeigen") ;
lin reveal_V2 = mkV2 (prefixV "auf" (mkV "decken")) | mkV2 (fixprefixV "ent" (mkV "hüllen")) ;
lin version_N = mkN "Version" ;
lin maybe_Adv = mkAdv "vielleicht" ;
lin ability_N = mkN "Fähigkeit" feminine ;
lin operate_V2 = mkV2 (irregV "operieren" "operiert" "operierte" "operierte" "operiert" | fixprefixV "be" (mkV "dienen")) ; -- split: operate someone | operate something
lin operate_V = mkV "arbeiten" ;
lin good_N = mkN "Gute" neuter ;
lin campaign_N = mkN "Kampagne" | mkN "Feldzug" "Feldzüge" masculine ; -- split: marketing campaign / military campaign
lin heavy_A = L.heavy_A ;
lin advice_N = mkN "Rat" "Räte" neuter ;
lin institution_N = mkN "Institution" ;
lin discover_VS = mkVS (fixprefixV "ent" (mkV "decken")) ;
lin discover_V2 = mkV2 (fixprefixV "ent" (mkV "decken")) ;
lin discover_V = fixprefixV "ent" (mkV "decken") ;
lin surface_N = mkN "Oberfläche" feminine ;
lin library_N = mkN "Bibliothek" "Bibliotheken" feminine ;
lin pupil_N = mkN "Schüler" masculine | mkN "Schulkind" neuter ; -- note: Schüler = masc only; Schulkind = neutral
lin record_V2 = mkV2 (prefixV "auf" I.nehmen_V) | mkV2 (prefixV "auf" (mkV "zeichnen")) ; -- split: record a CD / record some info
lin refuse_VV = mkVV (reflV (mkV "weigern") accusative) ;
lin refuse_V2 = mkV2 (prefixV "ab" (mkV "lehnen")) ;
lin refuse_V = prefixV "ab" (mkV "lehnen") ;
lin prevent_V2 = mkV2 (fixprefixV "ver" (mkV "hindern")) ;
lin advantage_N = mkN "Vorteil" "Vorteile" masculine ;
lin dark_A = mkA "dunkel" "dunkl" "dunkler" "dunkelste" | mk3A "finster" "finsterer" "finsterste" ; --- split: dark colour / dark night
lin teach_V2V = mkV2V (mkV "lehren") | mkV2V (prefixV "bei" I.bringen_V) ;
lin teach_V2 = L.teach_V2 ;
lin teach_V = fixprefixV "unter" (mkV "richte") ;
lin memory_N = mkN "Erinnerung" | mkN "Gedächtnis" | mkN "Speicher" ; -- split: nice memory / have good memory / computer memory
lin culture_N = mkN "Kultur" feminine ;
lin blood_N = L.blood_N ;
lin cost_V2 = mkV2 (irregV "kosten" "kostet" "kostete" "kostete" "gekostet") ;
lin cost_V = irregV "kosten" "kostet" "kostete" "kostete" "gekostet" ;
lin majority_N = mkN "Mehrheit" feminine ;
lin answer_V2 = mkV2 (irregV "antworten" "antwortet" "antwortete" "antwortete" "geantwortet" | fixprefixV "be" (mkV "antworten")) ; -- split: answer someone / answer something
lin answer_V = irregV "antworten" "antwortet" "antwortete" "antwortete" "geantwortet" ;
lin variety_N = variants{} ; -- 
lin variety_2_N = mkN "Art" feminine ;
lin variety_1_N = mkN "Auswahl" feminine | mkN "Vielfalt" feminine ;
lin press_N = mkN "Presse" ;
lin depend_V = compoundV "darauf" (prefixV "an" I.kommen_V) ; -- note: only translates: it depends - es kommt darauf an; no other intransitive use of depend?
lin bill_N = mkN "Rechnung" | mkN "Gesetz" "Gesetze" neuter ; -- split: pay the bill / pass a bill (legal)
lin competition_N = mkN "Konkurrenz" neuter | mkN "Wettbewerb" ; -- split: she is no competition / this is a beauty competition
lin ready_A = mk3A "bereit" "bereiter" "bereiteste" ;
lin general_N = mkN "General" ;
lin access_N = mkN "Zugang" "Zugänge" masculine ;
lin hit_V2 = L.hit_V2 ;
lin hit_V = prefixV "an" (regV "machen") ; -- delete: false extraction
lin stone_N = L.stone_N ;
lin useful_A = mkA "nützlich" ;
lin extent_N = mkN "Umfang" "Umfänge" masculine | mkN "Ausmaß" "Außmaße" neuter ;
lin employment_N = mkN "Arbeit" feminine | mkN "Beschäftigung" ;
lin regard_V2 = mkV2 (fixprefixV "be" (mkV "trachten")) | mkV2 (mkV "achten") | mkV2 (mkV "schätzen") ; -- split: look at someone/something / respect someone (achten/schätzen)
lin regard_V = variants{}; -- mkV2 (fixprefixV "be" (mkV "trachten")) | mkV2 (mkV "achten") | mkV2 (mkV "schätzen") ; -- split: look at someone/something / respect someone (achten/schätzen)
lin apart_Adv = mkAdv "auseinander" ;
lin present_N = mkN "Gegenwart" feminine | mkN "Geschenk" "Geschenke" neuter ; -- split: current time / gift
lin appeal_N = mkN "Beschwerde" | mkN "Anreiz" ; -- split: file an appeal / her appeal is her humor
lin text_N = mkN "Text" | mkN "SMS" "SMS" "SMS" "SMS" "SMS" "SMS" feminine ; -- split: print off a text / send a (mobile phone) text
lin parliament_N = mkN "Parlament" "Parlemente" neuter ;
lin cause_N = mkN "Ursache" ;
lin terms_N = mkN "Bedingung" | mkN "Bestimmung" ; -- note: English is plural, hence German nouns should also be applied in pl
lin bar_N = variants{} ; -- 
lin bar_2_N = mkN "Stab" "Stäbe" masculine | mkN "Stange" ;
lin bar_1_N = mkN "Bar" "Bars" feminine ;
lin attack_N = mkN "Angriff" ;
lin effective_A = mk3A "wirksam" "wirksamer" "wirksamste" | mkA "effektiv" ;
lin mouth_N = L.mouth_N ;
lin down_Prep = mkPrep accusative "hinunter" ;
lin result_V = variants{} ; -- 
lin fish_N = L.fish_N ;
lin future_A = mkA "zukünftig" ;
lin visit_N = mkN "Besuch" "Besuche" masculine ;
lin little_Adv = mkAdv "wenig" ;
lin easily_Adv = mkAdv "leicht" | mkAdv "spielend" ;
lin attempt_VV = mkVV (fixprefixV "ver" (mkV "suchen")) ;
lin attempt_V2 = mkV2 (fixprefixV "ver" (mkV "suchen")) ;
lin enable_VS = mkVS (fixprefixV "er" (mkV "möglichen")) ;
lin enable_V2V = mkV2V (fixprefixV "er" (mkV "möglichen")) ;
lin enable_V2 = mkV2 (fixprefixV "er" (mkV "möglichen")) ;
lin trouble_N = mkN "Ärger" masculine | mkN "Problem" "Probleme" neuter ; -- split: make trouble / have troubles
lin traditional_A = mk3A "traditionell" "traditioneller" "traditionellste" ;
lin payment_N = mkN "Zahlung" ;
lin best_Adv = mkAdv "am besten" ;
lin post_N = mkN "Post" feminine | mkN "Stelle" | mkN "Posten" "Posten" masculine | mkN "Post" "Posts" masculine ; -- split: post office / position (Stelle & Posten) / blog post
lin county_N = mkN "Landkreis" | mkN "Bezirk" "Bezirke" masculine ;
lin lady_N = mkN "Dame" ;
lin holiday_N = mkN "Urlaub" | mkN "Feiertag" ;
lin realize_VS = mkVS (fixprefixV "er" I.kennen_V) ;
lin realize_V2 = mkV2 (irregV "realisieren" "realisiert" "realisierte" "realisierte" "realisiert" | prefixV "um" (mkV "setzen")) ;
lin importance_N = mkN "Wichtigkeit" feminine ;
lin chair_N = L.chair_N ;
lin facility_N = mkN "Einrichtung" | mkN "Leichtigkeit" feminine ; -- split: printing facilities / ease
lin complete_V2 = mkV2 (fixprefixV "be" (mkV "enden")) | mkV2 (prefixV "ab" I.schließen_V) ;
lin complete_V = regV "beenden" | mkV "fertigstellen" | prefixV "fertig" (regV "machen") ; -- delete: false extraction
lin article_N = mkN "Artikel" "Artikel" masculine ;
lin object_N = mkN "Objekt" "Objekte" neuter ;
lin context_N = mkN "Kontext" "Kontexte" masculine | mkN "Zusammenhang" "Zusammenhänge" masculine ;
lin survey_N = mkN "Umfrage" "Umfragen" feminine ;
lin notice_VS = mkVS (fixprefixV "be" (mkV "merken")) | mkVS (fixprefixV "an" (mkV "merken")) ;
lin notice_V2 = mkV2 (fixprefixV "be" (mkV "merken")) ;
lin complete_A = mkA "vollständig" | mkA "ganz" | mkA "gesamt" ;
lin turn_N = mkN "Wende" | mkN "Runde" ; -- split: sharp turn / next turn; note: it's my turn = ich bin dran
lin direct_A = mk3A "direkt" "direkter" "direkteste" ;
lin immediately_Adv = mkAdv "sofort" ;
lin collection_N = mkN "Sammlung" | mkN "Einsammlung" ; -- split: butterfly collection / rubbish collection
lin reference_N = mkN "Bezug" "Bezüge" masculine | mkN "Arbeitszeugnis" ; -- split: reference to something / reference from employer
lin card_N = mkN "Karte" "Karten" feminine ;
lin interesting_A = mk3A "interessant" "interessanter" "interessanteste" ;
lin considerable_A = regA "erheblich" | mkA "beträchtlich" | mk3A "beachtlich" "beachtlicher" "beachtlichste" ;
lin television_N = L.television_N ;
lin extend_V2 = mkV2 (fixprefixV "ver" (mkV "längern")) | mkV2 (fixprefixV "er" (mkV "weitern")) ;
lin extend_V = reflV (prefixV "aus" (mkV "dehnen")) accusative ;
lin communication_N = mkN "Kommunikation" ;
lin agency_N = mkN "Agentur" feminine | mkN "Amt" "Ämter" neuter | mkN "Behörde" ;
lin physical_A = mkA "physisch" ;
lin except_Conj = MS.mkConj [] "außer" singular | MS.mkConj [] "ausgenommen" singular ;
lin check_V2 = mkV2 (fixprefixV "über" (mkV "prüfen")) | mkV2 (mkV "prüfen") | mkV2 (mkV "checken") ;
lin check_V = mkV "checken" | fixprefixV "über" (mkV "prüfen") ; -- note: I checked - ich habe ES gecheckt/überprüft
lin sun_N = L.sun_N ;
lin species_N = mkN "Art" feminine ;
lin possibility_N = mkN "Möglichkeit" feminine ;
lin officialMasc_N = mkN "Beamte" masculine ;
lin chairman_N = mkN "Vorsitzende" masculine ;
lin speaker_N = mkN "Sprecher" | mkN "Redner" | mkN "Lautsprecher" | mkN "Box" feminine ; -- split: human speaker (Sprecher / Redner) / amplifying system
lin second_N = mkN "Sekunde" "Sekunden" feminine ;
lin career_N = mkN "Karriere" "Karrieren" feminine ;
lin laugh_VS = mkVS (compoundV "lachend" (mkV "sagen")) ;
lin laugh_V2 = mkV2 (mkV "lachen") ;
lin laugh_V = L.laugh_V ;
lin weight_N = mkN "Gewicht" "Gewichte" neuter ;
lin sound_VS = mkVS (regV "sondieren") ; -- delete: false extraction
lin sound_VA = mkVA I.klingen_V ;
lin sound_V2 = mkV2 (regV "sondieren" | compoundV "erschallen" I.lassen_V) ;
lin sound_V = fixprefixV "er" I.klingen_V | mkV "läuten" ;
lin responsible_A = mkA "verantwortlich" | mkA "verantwortungsvoll" ; -- to be responsible / act responsible
lin base_N = mkN "Grundlage" | mkN "Basis" "Basen" feminine ;
lin document_N = mkN "Dokument" "Dokumente" neuter ;
lin solution_N = mkN "Lösung" feminine ;
lin return_N = mkN "Rückkehr" feminine ;
lin medical_A = regA "medizinisch" | mkA "ärztlich" ;
lin hot_A = L.hot_A ;
lin recognize_VS = mkVS (fixprefixV "er" I.kennen_V) ;
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin talk_N = mkN "Gespräch" "Gespräche" neuter | mkN "Vortrag" "Vorträge" masculine ; -- split: let's have a talk / I went to a talk
lin budget_N = mkN "Budget" "Budgets" neuter ;
lin river_N = L.river_N ;
lin fit_V2 = mkV2 (mkV "passen") ;
lin fit_V = mkV "passen" ;
lin organization_N = organisation_N ;
lin existing_A = regA "bestehend" ;
lin start_N = mkN "Start" "Starts" masculine | mkN "Beginn" "Beginne" masculine | mkN "Anfang" "Anfänge" masculine ;
lin push_VS = mkVS (compoundV "dazu" (mkV "drängen")) ;
lin push_V2V = mkV2V (mkV "drängen") ;
lin push_V2 = L.push_V2 ;
lin push_V = mkV "drücken" ;
lin tomorrow_Adv = mkAdv "morgen" ;
lin requirement_N = mkN "Bedingung" | mkN "Voraussetzung" ;
lin cold_A = L.cold_A ;
lin edge_N = mkN "Vorsprung" ; -- status=guess
lin opposition_N = mkN "Opposition" ; -- status=guess
lin opinion_N = mkN "Meinung" | mkN "Ansicht" feminine ;
lin drug_N = mkN "Medikament" "Medikamente" neuter | mkN "Droge" "Drogen" feminine ; -- split: medicinal / illegal
lin quarter_N = mkN "Viertel" neuter ;
lin option_N = mkN "Option" feminine ;
lin sign_V2 = mkV2 (no_geV (mkV "gebärden")) | mkV2 (fixprefixV "unter" I.schreiben_V) ; -- split: use sign language / sign a piece of paper
lin sign_V = fixprefixV "unter" I.schreiben_V ;
lin worth_Prep = variants{} ; -- 
lin call_N = mkN "Ruf" "Rufe" masculine | mkN "Anruf" ; -- split: call for dinner / phone call
lin define_V2 = mkV2 (regV "bestimmen") ; --
lin define_V = regV "bestimmen" ; --
lin stock_N = mkN "Brühe" feminine ; --
lin influence_N = mkN "Einfluss" "Einflüsse" masculine ;
lin occasion_N = mkN "Gelegenheit" feminine ;
lin eventually_Adv = mkAdv "schließlich" ;
lin software_N = mkN "Software" "Softwares" feminine ;
lin highly_Adv = mkAdv "sehr" ;
lin exchange_N = mkN "Austausch" "Austausche" masculine | mkN "Tausch" "Tausche" masculine ; -- status=guess status=guess
lin lack_N = mkN "Mangel" ;
lin shake_V2 = mkV2 (mkV "schütteln") ;
lin shake_V = mkV "zittern" | mkV "beben" | mkV "wackeln" ; -- split: the crying girl was shaking / the earth was shaking / the plane was shaking
lin study_V2 = mkV2 (regV "studieren") ;
lin study_V = regV "studieren" ;
lin concept_N = mkN "Begriff" "Begriffe" feminine | mkN "Konzept" "Konzepte" neuter ;
lin blue_A = L.blue_A ;
lin star_N = L.star_N ;
lin radio_N = L.radio_N ;
lin arrangement_N = mkN "Anordnung" ; -- status=guess
lin examine_V2 = mkV2 (fixprefixV "unter" (mkV "suchen")) ;
lin bird_N = L.bird_N ;
lin green_A = L.green_A ;
lin band_N = mkN "Pflaster" "Pflaster" neuter | mkN "Heftpflaster" neuter ; -- status=guess status=guess
lin sex_N = mkN "Geschlecht" neuter | mkN "Sex" | mkN "Geschlechtsverkehr" ; -- split: gender / coitus
lin finger_N = mkN "Finger" "Finger" masculine ;
lin past_N = mkN "Vergangenheit" feminine ;
lin independent_A = variants{} ; -- 
lin independent_2_A = mkA "unabhängig" ;
lin independent_1_A = mkA "unabhängig" ;
lin equipment_N = mkN "Ausrüstung" ;
lin north_N = mkN "Norden" masculine ;
lin mind_VS = mkVS (compoundV "dagegen" I.haben_V) ;
lin mind_V2 = mkV2 (reflV (mkV "stören") accusative) ; -- note: don't mind... = LASS dich nicht von ... stören
lin mind_V = compoundV "dagegen" I.haben_V ;
lin move_N = mkN "Bewegung" ; -- status=guess
lin message_N = mkN "Nachricht" feminine | mkN "Botschaft" feminine ;
lin fear_N = mkN "Angst" "Ängste" feminine | mkN "Furcht" feminine ;
lin afternoon_N = mkN "Nachmittag" "Nachmittage" masculine ;
lin drink_V2 = L.drink_V2 ;
lin drink_V = mkV "trinken" ;
lin fully_Adv = mkAdv "völlig" ;
lin race_N = variants{} ; -- 
lin race_2_N = mkN "Rasse" ;
lin race_1_N = mkN "Wettrennen" neuter | mkN "Wettlauf" "Wettläufe" masculine ;
lin gain_V2 = mkV2 (irregV "gewinnen" "gewinnt" "gewann" "gewänne" "gewonnen") ; -- status=guess, src=wikt
lin gain_V = irregV "gewinnen" "gewinnt" "gewann" "gewänne" "gewonnen" ; -- status=guess, src=wikt
lin strategy_N = mkN "Strategie" "Strategien" feminine ;
lin extra_A = variants{} ; -- 
lin scene_N = mkN "Szene" "Szenen" feminine ;
lin slightly_Adv = mkAdv "ein bisschen" ;
lin kitchen_N = mkN "Küche" ;
lin speech_N = mkN "Sprechakt" "Sprechakte" masculine ; -- status=guess
lin arise_V = irregV "entstehen" "entsteht" "entstand" "entstände" "entstanden" ; -- status=guess, src=wikt
lin network_N = mkN "Netzwerk" "Netzwerke" neuter ;
lin tea_N = mkN "Tee" "Tees" masculine ;
lin peace_N = L.peace_N ;
lin failure_N = mkN "Versagen" neuter ;
lin employee_N = mkN "Arbeitnehmer" "Arbeitnehmer" masculine | mkN "Angestellte" masculine ;
lin ahead_Adv = variants{} ; -- 
lin scale_N = mkN "Skala" feminine ; -- status=guess
lin hardly_Adv = mkAdv "kaum" ;
lin attend_V2 = mkV2 (prefixV "teil" I.nehmen_V | regV "besuchen") ; -- status=guess, src=wikt status=guess, src=wikt
lin attend_V = prefixV "teil" I.nehmen_V | regV "besuchen" ; -- status=guess, src=wikt status=guess, src=wikt
lin shoulder_N = mkN "Schulter" feminine ;
lin otherwise_Adv = mkAdv "anders" ; -- status=guess
lin railway_N = mkN "Bahnhof" "Bahnhöfe" masculine | mkN "Eisenbahnhof" masculine ; -- status=guess status=guess
lin directly_Adv = mkAdv "direkt" | mkAdv "gerade" ; -- status=guess status=guess
lin supply_N = mkN "Angebot" "Angebote" neuter | mkN "Versorgen" neuter ; -- status=guess status=guess
lin expression_N = mkN "Redensart" "Redensarten" feminine ; -- status=guess
lin owner_N = mkN "Besitzer" "Besitzer" masculine | mkN "Eigentümer" masculine ;
lin associate_V2 = variants{} ; -- 
lin associate_V = variants{} ; -- 
lin corner_N = mkN "Ecke" "Ecken" feminine | mkN "Winkel" "Winkel" masculine ;
lin past_A = mkA "vergangen" ; -- compile&check
lin match_N = variants{} ; -- 
lin match_3_N = variants{} ; -- 
lin match_2_N = variants{} ; -- 
lin match_1_N = variants{} ; -- 
lin sport_N = mkN "Sport" "Sporte" masculine ; -- status=guess
lin status_N = mkN "Status" "Status" masculine ; -- status=guess
lin beautiful_A = L.beautiful_A ;
lin offer_N = mkN "Angebot" "Angebote" neuter | mkN "Antrag" "Anträge" masculine | mkN "Offerte" "Offerten" feminine ; -- status=guess status=guess status=guess
lin marriage_N = mkN "Heiratagentur" feminine | mkN "Heiratsbüro" neuter ; -- status=guess status=guess
lin hang_V2 = mkV2 (mkV "abhängen") | mkV2 (mkV "herumhängen") | mkV2 (mkV "rumhängen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hang_V = mkV "abhängen" | mkV "herumhängen" | mkV "rumhängen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin civil_A = regA "zivil" | mkA "bürgerlich" ; -- status=guess status=guess
lin perform_V2 = mkV2 (mkV "durchführen") | mkV2 (mkV "ausführen") ; -- status=guess, src=wikt status=guess, src=wikt
lin perform_V = mkV "durchführen" | mkV "ausführen" ; -- status=guess, src=wikt status=guess, src=wikt
lin sentence_N = mkN "Urteil" "Urteile" neuter ; -- status=guess
lin crime_N = mkN "Verbrechen" "Verbrechen" neuter ; -- status=guess
lin ball_N = mkN "Fußballen" masculine ; -- status=guess
lin marry_V2 = mkV2 (irregV "heiraten" "heiratet" "heiratete" "heirate" "geheiratet") ; -- status=guess, src=wikt
lin marry_V = irregV "heiraten" "heiratet" "heiratete" "heirate" "geheiratet" ; -- status=guess, src=wikt
lin wind_N = L.wind_N ;
lin truth_N = mkN "Wahrheit" "Wahrheiten" feminine ; -- status=guess
lin protect_V2 = mkV2 (mkV "schützen") ; -- status=guess, src=wikt
lin protect_V = mkV "schützen" ; -- status=guess, src=wikt
lin safety_N = mkN "Sicherheit" "Sicherheiten" feminine ; -- status=guess
lin partner_N = mkN "Partner" "Partner" masculine ; -- status=guess
lin completely_Adv = mkAdv "vollständig" | mkAdv "völlig" | mkAdv "ganz" ; -- status=guess status=guess status=guess
lin copy_N = mkN "Kopierschutz" masculine ; -- status=guess
lin balance_N = mkN "Balance" "Balancen" feminine | mkN "Gleichgewicht" "Gleichgewichte" neuter ; -- status=guess status=guess
lin sister_N = L.sister_N ;
lin reader_N = mkN "Leser" "Leser" masculine | mkN "Leserin" "Leserinnen" feminine ; -- status=guess status=guess
lin below_Adv = mkAdv "unten" | mkAdv "darunter" | mkAdv "unterhalb" ; -- status=guess status=guess status=guess
lin trial_N = mkN "Trial" "Trials" neuter | mkN "Versuch" "Versuche" masculine ; -- status=guess status=guess
lin rock_N = L.rock_N ;
lin damage_N = mkN "Schaden" "Schäden" masculine ; -- status=guess
lin adopt_V2 = mkV2 (regV "adoptieren") ; -- status=guess, src=wikt
lin newspaper_N = L.newspaper_N ;
lin meaning_N = mkN "Bedeutung" ; -- status=guess
lin light_A = mkA "erleuchtet" | mk3A "hell" "heller" "hellste" ; -- status=guess status=guess
lin essential_A = mk3A "essenziell" "essenzieller" "essenziellste" | mk3A "notwendig" "notwendiger" "notwendigste" ; -- status=guess status=guess
lin obvious_A = mk3A "offensichtlich" "offensichtlicher" "offensichtlichste" ; -- status=guess
lin nation_N = mkN "Nation" ; -- status=guess
lin confirm_VS = mkVS (mkV "bestätigen") | mkVS (mkV "bekräftigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin confirm_V2 = mkV2 (mkV "bestätigen") | mkV2 (mkV "bekräftigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin south_N = mkN "Süden" masculine ; -- status=guess
lin length_N = mkN "Pferdelänge" feminine ; -- status=guess
lin branch_N = mkN "Branche" "Branchen" feminine ; -- status=guess
lin deep_A = mk3A "tief" "tiefer" "tiefste" ; -- status=guess
lin none_NP = variants{} ; -- 
lin planning_N = mkN "Planung" ; -- status=guess
lin trust_N = mkN "Vertrauen" neuter ; -- status=guess
lin working_A = variants{} ; -- 
lin pain_N = mkN "Schmerz" "Schmerzen" masculine ; -- status=guess
lin studio_N = mkN "Atelier" "Ateliers" neuter | mkN "Studio" "Studios" neuter ; -- status=guess status=guess
lin positive_A = mk3A "positiv" "positiver" "positivste" ; -- status=guess
lin spirit_N = mkN "Schnaps" "Schnäpse" masculine | sprit_N | mkN "Alkohol" "Alkohole" masculine ; -- status=guess status=guess status=guess
lin college_N = mkN "Berufskolleg" neuter | mkN "Fachschule" "Fachschulen" feminine ; -- status=guess status=guess
lin accident_N = mkN "Unfall" "Unfälle" masculine ; -- status=guess
lin star_V2 = variants{} ; -- 
lin hope_N = mkN "Hoffnung" ; -- status=guess
lin mark_V3 = mkV3 (irregV "korrigieren" "korrigiert" "korrigierte" "korrigierte" "korrigiert") ; -- status=guess, src=wikt
lin mark_V2 = mkV2 (irregV "korrigieren" "korrigiert" "korrigierte" "korrigierte" "korrigiert") ; -- status=guess, src=wikt
lin works_N = mkN "Arbeiten" ; -- status=guess
lin league_N = variants{} ; -- 
lin league_2_N = variants{} ; -- 
lin league_1_N = variants{} ; -- 
lin clear_V2 = mkV2 (mkV "räuspern") ; -- status=guess, src=wikt
lin clear_V = mkV "räuspern" ; -- status=guess, src=wikt
lin imagine_VS = mkVS (mkReflV "vorstellen" | irregV "vorstellen" "stellt" "stell" "stelle" "vorgestellt" | mkV "einbilden") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin imagine_V2 = mkV2 (mkReflV "vorstellen" | irregV "vorstellen" "stellt" "stell" "stelle" "vorgestellt" | mkV "einbilden") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin imagine_V = mkReflV "vorstellen" | irregV "vorstellen" "stellt" "stell" "stelle" "vorgestellt" | mkV "einbilden" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin through_Adv = mkAdv "durch" ;
lin cash_N = mkN "Melkkuh" feminine ; -- status=guess
lin normally_Adv = mkAdv "normalerweise" ; -- status=guess
lin play_N = spiel_N ; -- status=guess
lin strength_N = kraft_N | mkN "Stärke" feminine ; -- status=guess status=guess
lin train_N = L.train_N ;
lin travel_V2 = mkV2 (irregV "reisen" "reist" "reiste" "reiste" "reist") ; -- status=guess, src=wikt
lin travel_V = L.travel_V ;
lin target_N = mkN "Zielscheibe" "Zielscheiben" feminine ; -- status=guess
lin very_A = mkA "derselbe" ; -- status=guess
lin pair_N = mkN "Zirkel" "Zirkel" masculine ; -- status=guess
lin male_A = mkA "männlich" ; -- status=guess
lin gas_N = mkN "Gaszentrifuge" feminine ; -- status=guess
lin issue_V2 = variants{} ; -- 
lin issue_V = variants{} ; -- 
lin contribution_N = mkN "Beitrag" "Beiträge" masculine | mkN "finanzieller Beitrag" masculine ; -- status=guess status=guess
lin complex_A = mk3A "kompliziert" "komplizierter" "komplizierteste" ; -- status=guess
lin supply_V2 = mkV2 (irregV "vertreten" "vertritt" "vertrat" "verträte" "vertreten") ; -- status=guess, src=wikt
lin beat_V2 = mkV2 (junkV (mkV "um") "den heißen Brei reden") ; -- status=guess, src=wikt
lin beat_V = junkV (mkV "um") "den heißen Brei reden" ; -- status=guess, src=wikt
lin artist_N = mkN "Künstler" masculine | mkN "Künstlerin" feminine ; -- status=guess status=guess
lin agentMasc_N = reg2N "Agent" "Agenten" masculine;
lin presence_N = mkN "Anwesenheit" feminine ; -- status=guess
lin along_Adv = mkAdv "mit" ;
lin environmental_A = variants{} ; -- 
lin strike_V2 = mkV2 (irregV "streichen" "streicht" "strich" "striche" "gestrichen") ; -- status=guess, src=wikt
lin strike_V = irregV "streichen" "streicht" "strich" "striche" "gestrichen" ; -- status=guess, src=wikt
lin contact_N = mkN "Kontakt" "Kontakte" masculine | mkN "Berührung" feminine ; -- status=guess status=guess
lin protection_N = mkN "Schutz" "Schutze" masculine ; -- status=guess
lin beginning_N = mkN "Anfang" "Anfänge" masculine | mkN "Beginn" "Beginne" masculine ; -- status=guess status=guess
lin demand_VS = mkVS (irregV "verlangen" "verlangt" "verlangte" "verlangte" "verlangt" | irregV "bestehen" "besteht" "bestand" "bestände" "bestanden") ; -- compile&check
lin demand_V2 = mkV2 (irregV "verlangen" "verlangt" "verlangte" "verlangte" "verlangt" | irregV "bestehen" "besteht" "bestand" "bestände" "bestanden") ; -- status=guess, src=wikt status=guess, src=wikt
lin media_N = mkN "Media" "Medien" neuter ; ---- {n} {p}" ; -- status=guess
lin relevant_A = mk3A "relevant" "relevanter" "relevanteste" ; -- status=guess
lin employ_V2 = mkV2 (prefixV "ein" (regV "stellen") | prefixV "an" (irregV "stellen" "stellt" "stellte" "stellte" "gestellt") | mkV "anwerben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shoot_V2 = mkV2 (prefixV "auf" (irregV "schneiden" "schneidet" "schnitt" "schnitt" "geschnitten")) ; -- status=guess, src=wikt
lin shoot_V = prefixV "auf" (irregV "schneiden" "schneidet" "schnitt" "schnitt" "geschnitten") ; -- status=guess, src=wikt
lin executive_N = mkN "Exekutive" "Exekutiven" feminine ; -- status=guess
lin slowly_Adv = mkAdv "langsam" ; -- status=guess
lin relatively_Adv = mkAdv "relativ" | mkAdv "verhältnismäßig" ; -- status=guess status=guess
lin aid_N = mkN "Helfer" "Helfer" masculine ; -- status=guess
lin huge_A = mk3A "riesig" "riesiger" "riesigste" ; -- status=guess
lin late_Adv = mkAdv "spät" ; -- status=guess
lin speed_N = mkN "Bodenschwelle" feminine | mkN "Bremsschwelle" feminine | mkN "Fahrbahnschwelle" feminine ; -- status=guess status=guess status=guess
lin review_N = mkN "Rezension" | mkN "Kritik" "Kritiken" feminine ; -- status=guess status=guess
lin test_V2 = mkV2 (irregV "testen" "testet" "testete" "teste" "getestet") ; -- status=guess, src=wikt
lin order_VS = mkVS (irregV "befehlen" "befehlt" "befahl" "befähle" "befohlen" | prefixV "an" (regV "ordnen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin order_V2V = mkV2V (irregV "befehlen" "befehlt" "befahl" "befähle" "befohlen" | prefixV "an" (regV "ordnen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin order_V2 = mkV2 (irregV "befehlen" "befehlt" "befahl" "befähle" "befohlen" | prefixV "an" (regV "ordnen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin order_V = irregV "befehlen" "befehlt" "befahl" "befähle" "befohlen" | prefixV "an" (regV "ordnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin route_N = mkN "Route" feminine | mkN "Weg" "Wege" masculine | mkN "Pfad" "Pfade" masculine ; -- status=guess status=guess status=guess
lin consequence_N = mkN "Konsequenz" "Konsequenzen" feminine | mkN "Folge" "Folgen" feminine ; -- status=guess status=guess
lin telephone_N = mkN "Telefon" "Telefone" neuter | mkN "Telephon" "Telephone" neuter | mkN "Fernsprecher" "Fernsprecher" masculine ; -- status=guess status=guess status=guess
lin release_V2 = mkV2 (regV "freisetzen") ; -- status=guess, src=wikt
lin proportion_N = mkN "Proportion" ; -- status=guess
lin primary_A = mkA "primär" ; -- status=guess
lin consideration_N = mkN "Vergütung" ; -- status=guess
lin reform_N = mkN "Reform" "Reformen" feminine ; -- status=guess
lin driverMasc_N = reg2N "Fahrer" "Fahrer" masculine;
lin annual_A = mkA "jährlich" ; -- status=guess
lin nuclear_A = regA "nuklear" | mkA "Kern-" ; -- status=guess status=guess
lin latter_A = mkA "letzter" ; -- status=guess
lin practical_A = mk3A "praktisch" "praktischer" "praktischste" ; -- status=guess
lin commercial_A = mk3A "kommerziell" "kommerzieller" "kommerziellste" ; -- status=guess
lin rich_A = mk3A "reich" "reicher" "reichste" ; -- status=guess
lin emerge_V = irregV "entstehen" "entsteht" "entstand" "entstände" "entstanden" | prefixV "auf" (regV "tauchen") ; -- status=guess, src=wikt status=guess, src=wikt
lin apparently_Adv = mkAdv "angeblich" | mkAdv "vorgeblich" | mkAdv "anscheinend" ; -- status=guess status=guess status=guess
lin ring_V = junkV (mkV "einem") "bekannt vorkommen" ; -- status=guess, src=wikt
lin ring_6_V2 = variants{} ; -- 
lin ring_4_V2 = variants{} ; -- 
lin distance_N = mkN "Distanz" "Distanzen" feminine | mkN "Entfernung" | mkN "Abstand" "Abstände" masculine ; -- status=guess status=guess status=guess
lin exercise_N = mkN "Übung" feminine ; -- status=guess
lin key_A = variants{} ; -- 
lin close_Adv = variants{} ; -- 
lin skin_N = L.skin_N ;
lin island_N = mkN "Insel" "Inseln" feminine | mkN "Eiland" "Eilande" neuter ; -- status=guess status=guess
lin separate_A = regA "einzeln" | regA "getrennt" | regA "separat" ; -- status=guess status=guess status=guess
lin aim_VV = mkVV (regV "zielen") ; -- status=guess, src=wikt
lin aim_V2 = mkV2 (regV "zielen") ; -- status=guess, src=wikt
lin aim_V = regV "zielen" ; -- status=guess, src=wikt
lin danger_N = mkN "Gefahr" "Gefahren" feminine | mkN "Risiko" neuter ; -- status=guess status=guess
lin credit_N = mkN "Kreditkarte" "Kreditkarten" feminine ; -- status=guess
lin usual_A = mkA "gewöhnlich" ; -- status=guess
lin link_V2 = mkV2 (irregV "verbinden" "verbindet" "verband" "verbände" "verbunden" | mkV "verknüpfen") ; -- status=guess, src=wikt status=guess, src=wikt
lin link_V = irregV "verbinden" "verbindet" "verband" "verbände" "verbunden" | mkV "verknüpfen" ; -- status=guess, src=wikt status=guess, src=wikt
lin candidateMasc_N = reg2N "Kandidat" "Kandidaten" masculine;
lin track_N = mkN "Fußspur" feminine ; -- status=guess
lin safe_A = regA "wohlbehalten" | regA "ganz" ; -- status=guess status=guess
lin interested_A = mk3A "interessiert" "interessierter" "interessierteste" ; -- status=guess
lin assessment_N = mkN "Bewertung" | mkN "Schätzung" feminine ; -- status=guess status=guess
lin path_N = mkN "Weg" "Wege" masculine ; -- status=guess
lin merely_Adv = mkAdv "bloß" | mkAdv "lediglich" | mkAdv "nur" | mkAdv "schier" ; -- status=guess status=guess status=guess status=guess
lin plus_Prep = variants{} ; -- 
lin district_N = mkN "Bezirk" "Bezirke" masculine ; -- status=guess
lin regular_A = mkA "regelmäßig" ; -- status=guess
lin reaction_N = mkN "Reaktion" "Reaktionen" feminine ; -- status=guess
lin impact_N = mkN "Belastung" | mkN "Stoß" masculine | mkN "Druck" masculine ; -- status=guess status=guess status=guess
lin collect_V2 = mkV2 (regV "sammeln" | mkV "anhäufen") ; -- status=guess, src=wikt status=guess, src=wikt
lin collect_V = regV "sammeln" | mkV "anhäufen" ; -- status=guess, src=wikt status=guess, src=wikt
lin debate_N = mkN "Debatte" "Debatten" feminine ; -- status=guess
lin lay_V2 = mkV2 (mkV "offenlegen") ; -- status=guess, src=wikt
lin lay_V = mkV "offenlegen" ; -- status=guess, src=wikt
lin rise_N = mkN "aufstehen" ; -- status=guess
lin belief_N = mkN "Glauben" masculine ; -- status=guess
lin conclusion_N = mkN "Schlussfolgerung" feminine ; -- status=guess
lin shape_N = form_N ; -- status=guess
lin vote_N = mkN "Stimme" "Stimmen" feminine | mkN "Votum" "Vota" neuter ; -- status=guess status=guess
lin aim_N = mkN "Ziel" "Ziele" neuter ; -- status=guess
lin politics_N = mkN "Politik" "Politiken" feminine ; -- status=guess
lin reply_VS = mkVS (irregV "antworten" "antwortet" "antwortete" "antwortete" "geantwortet" | irregV "erwidern" "erwidert" "erwiderte" "erwiderte" "erwidert") ; -- status=guess, src=wikt status=guess, src=wikt
lin reply_V = irregV "antworten" "antwortet" "antwortete" "antwortete" "geantwortet" | irregV "erwidern" "erwidert" "erwiderte" "erwiderte" "erwidert" ; -- status=guess, src=wikt status=guess, src=wikt
lin press_V2V = mkV2V (mkV "drücken") ; -- status=guess, src=wikt
lin press_V2 = mkV2 (mkV "drücken") ; -- status=guess, src=wikt
lin press_V = mkV "drücken" ; -- status=guess, src=wikt
lin approach_V2 = mkV2 (mkReflV "nähern") ; -- status=guess, src=wikt
lin approach_V = mkReflV "nähern" ; -- status=guess, src=wikt
lin file_N = mkN "Kartei" "Karteien" feminine | mkN "Datei" "Dateien" feminine | mkN "Akte" "Akten" feminine ; -- status=guess status=guess status=guess
lin western_A = mk3A "westlich" "westlicher" "westlichste" | mkA "West-" ; -- status=guess status=guess
lin earth_N = L.earth_N ;
lin public_N = mkN "Publikum" neuter | mkN "Öffentlichkeit" feminine ; -- status=guess status=guess
lin survive_V2 = mkV2 (mkV "überleben") ; -- status=guess, src=wikt
lin survive_V = mkV "überleben" ; -- status=guess, src=wikt
lin estate_N = gut_N | mkN "Landgut" "Landgüter" neuter ; -- status=guess status=guess
lin boat_N = L.boat_N ;
lin prison_N = mkN "Haft" feminine | mkN "Gefangenschaft" "Gefangenschaften" feminine ; -- status=guess status=guess
lin additional_A = mkA "zusätzlich" ; -- status=guess
lin settle_V2 = mkV2 (mkV "siedeln") ; -- status=guess, src=wikt
lin settle_V = mkV "siedeln" ; -- status=guess, src=wikt
lin largely_Adv = variants{} ; -- 
lin wine_N = L.wine_N ;
lin observe_VS = mkVS (regV "bemerken") ; -- compile&check
lin observe_V2 = mkV2 (regV "bemerken") ; -- status=guess, src=wikt
lin limit_V2V = mkV2V (irregV "befristen" "befristet" "befristete" "befristete" "befristet" | regV "begrenzen" | mkV "beschränken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin limit_V2 = mkV2 (irregV "befristen" "befristet" "befristete" "befristete" "befristet" | regV "begrenzen" | mkV "beschränken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin deny_V3 = mkV3 (regV "leugnen" | mkV "bestreiten" | irregV "dementieren" "dementiert" "dementierte" "dementierte" "dementiert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin deny_V2 = mkV2 (regV "leugnen" | mkV "bestreiten" | irregV "dementieren" "dementiert" "dementierte" "dementierte" "dementiert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin for_PConj = variants{} ; -- 
lin straight_Adv = mkAdv "geradeaus" ; -- status=guess
lin somebody_NP = S.somebody_NP ;
lin writer_N = mkN "Schriftsteller" "Schriftsteller" masculine | mkN "Schriftstellerin" "Schriftstellerinnen" feminine | mkN "Autor" "Autoren" masculine | mkN "Autorin" "Autorinnen" feminine | mkN "Schreiber" "Schreiber" masculine | mkN "Schreiberin" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin weekend_N = mkN "Wochenende" "Wochenenden" neuter ; -- status=guess
lin clothes_N = mkN "Kleidung" ; ---- | mkN "Klamotten {f} {p}" ; -- status=guess status=guess
lin active_A = mkA "rührig" ; -- status=guess
lin sight_N = mkN "Sehvermögen" | mkN "Sehen" neuter ; -- status=guess status=guess
lin video_N = mkN "Video" "Videos" neuter ; -- status=guess
lin reality_N = mkN "Realität" feminine ; -- status=guess
lin hall_N = mkN "Studentenwohnheim" "Studentenwohnheime" neuter ; -- status=guess
lin nevertheless_Adv = mkAdv "nichtsdestoweniger" | mkAdv "trotzdem" ; -- status=guess status=guess
lin regional_A = regA "regional" ; -- status=guess
lin vehicle_N = mkN "Fahrzeug" "Fahrzeuge" neuter | mkN "Gefährt" neuter ; -- status=guess status=guess
lin worry_VS = variants{} ; -- 
lin worry_V2 = variants{} ; -- 
lin worry_V = variants{} ; -- 
lin powerful_A = variants{} ; -- 
lin possibly_Adv = variants{} ; -- 
lin cross_V2 = mkV2 (regV "kreuzen") ; -- status=guess, src=wikt
lin cross_V = regV "kreuzen" ; -- status=guess, src=wikt
lin colleague_N = mkN "Kollege" "Kollegen" masculine | mkN "Kollegin" feminine | mkN "Mitarbeiter" "Mitarbeiter" masculine | mkN "Mitarbeiterin" "Mitarbeiterinnen" feminine ; -- status=guess status=guess status=guess status=guess
lin charge_V2 = variants{} ; -- 
lin charge_V = variants{} ; -- 
lin lead_N = mkN "Führung" feminine ; -- status=guess
lin farm_N = mkN "Bauernhof" "Bauernhöfe" masculine | mkN "Farm" "Farmen" feminine ; -- status=guess status=guess
lin respond_VS = variants{} ; -- 
lin respond_V = variants{} ; -- 
lin employer_N = mkN "Arbeitgeber" "Arbeitgeber" masculine | mkN "Arbeitgeberin" feminine ; -- status=guess status=guess
lin carefully_Adv = mkAdv "vorsichtig" ; -- status=guess
lin understanding_N = mkN "Vereinbarung" ; -- status=guess
lin connection_N = mkN "Verbindung" ; -- status=guess
lin comment_N = mkN "Kommentar" "Kommentare" masculine ; -- status=guess
lin grant_V3 = mkV3 (mkV "bewilligen") ; -- status=guess, src=wikt
lin grant_V2 = mkV2 (mkV "bewilligen") ; -- status=guess, src=wikt
lin concentrate_V2 = mkV2 (mkReflV "konzentrieren") ; -- status=guess, src=wikt
lin concentrate_V = mkReflV "konzentrieren" ; -- status=guess, src=wikt
lin ignore_V2 = mkV2 (regV "ignorieren" | irregV "missachten" "missachtet" "missachtete" "missachte" "missachtet") ; -- status=guess, src=wikt status=guess, src=wikt
lin ignore_V = regV "ignorieren" | irregV "missachten" "missachtet" "missachtete" "missachte" "missachtet" ; -- status=guess, src=wikt status=guess, src=wikt
lin phone_N = mkN "Telefon" "Telefone" neuter | mkN "Telephon" "Telephone" neuter | mkN "Fernsprecher" "Fernsprecher" masculine ; -- status=guess status=guess status=guess
lin hole_N = loch_N ; -- status=guess
lin insurance_N = mkN "Versicherung" ; -- status=guess
lin content_N = mkN "Inhalt" "Inhalte" masculine ; -- status=guess
lin confidence_N = mkN "Zuversicht" "Zuversichten" feminine ; -- status=guess
lin sample_N = mkN "Probe" "Proben" feminine | mkN "Muster" "Muster" neuter ; -- status=guess status=guess
lin transport_N = mkN "Beförderung" feminine ; -- status=guess
lin objective_N = mkN "Ziel" "Ziele" neuter ; -- status=guess
lin alone_A = variants{} ; -- 
lin flower_N = L.flower_N ;
lin injury_N = mkN "Verletzung" | mkN "Wunde" "Wunden" feminine | mkN "Verwundung" ; -- status=guess status=guess status=guess
lin lift_V2 = mkV2 (junkV (mkV "Finger") "krumm machen") ; -- status=guess, src=wikt
lin lift_V = junkV (mkV "Finger") "krumm machen" ; -- status=guess, src=wikt
lin stick_V2 = mkV2 (prefixV "auf" (irregV "fallen" "fallt" "fiel" "fiele" "gefallen")) ; -- status=guess, src=wikt
lin stick_V = prefixV "auf" (irregV "fallen" "fallt" "fiel" "fiele" "gefallen") ; -- status=guess, src=wikt
lin front_A = variants{} ; -- 
lin mainly_Adv = mkAdv "hauptsächlich" ; -- status=guess
lin battle_N = mkN "Streitaxt" "Streitäxte" feminine ; -- status=guess
lin generation_N = mkN "Erzeugung" "Erzeugungen" feminine ; -- status=guess
lin currently_Adv = mkAdv "momentan" | mkAdv "zur Zeit" | mkAdv "zurzeit" ; -- status=guess status=guess status=guess
lin winter_N = mkN "Winter" "Winter" masculine ; -- status=guess
lin inside_Prep = variants{} ; -- 
lin impossible_A = mkA "unmöglich" ; -- status=guess
lin somewhere_Adv = S.somewhere_Adv ;
lin arrange_V2 = mkV2 (prefixV "ein" (irregV "richten" "richtet" "richtete" "richtete" "gerichtet")) ; -- status=guess, src=wikt
lin arrange_V = prefixV "ein" (irregV "richten" "richtet" "richtete" "richtete" "gerichtet") ; -- status=guess, src=wikt
lin will_N = mkN "Wille" "Willen" masculine ; -- status=guess
lin sleep_V = L.sleep_V ;
lin progress_N = mkN "Fortschritt" "Fortschritte" masculine ; -- status=guess
lin volume_N = mkN "Jahrgang" "Jahrgänge" masculine ; -- status=guess
lin ship_N = L.ship_N ;
lin legislation_N = mkN "Gesetz" "Gesetze" neuter ; -- status=guess
lin commitment_N = mkN "Einweisung" feminine ; -- status=guess
lin enough_Predet = variants{} ; -- 
lin conflict_N = mkN "Konflikt" "Konflikte" masculine | mkN "Streit" "Streite" masculine ; -- status=guess status=guess
lin bag_N = mkN "Beutel" "Beutel" masculine | mkN "Tasche" "Taschen" feminine | mkN "Tüte" feminine | mkN "Sack" "Säcke" masculine ; -- status=guess status=guess status=guess status=guess
lin fresh_A = mk3A "frisch" "frischer" "frischeste" ; -- status=guess
lin entry_N = variants{} ; -- 
lin entry_2_N = variants{} ; -- 
lin entry_1_N = variants{} ; -- 
lin smile_N = mkN "Lächeln" neuter ; -- status=guess
lin fair_A = mkA "den Umständen entsprechend" | regA "angebracht" | mkA "erträglich" | regA "ganz" ; -- status=guess status=guess status=guess status=guess
lin promise_VV = mkVV (irregV "versprechen" "versprecht" "versprach" "verspräche" "versprochen") ; -- status=guess, src=wikt
lin promise_VS = mkVS (irregV "versprechen" "versprecht" "versprach" "verspräche" "versprochen") ; -- status=guess, src=wikt
lin promise_V2 = mkV2 (irregV "versprechen" "versprecht" "versprach" "verspräche" "versprochen") ; -- status=guess, src=wikt
lin promise_V = irregV "versprechen" "versprecht" "versprach" "verspräche" "versprochen" ; -- status=guess, src=wikt
lin introduction_N = mkN "Einführung" feminine ; -- status=guess
lin senior_A = mkA "älter" ; -- status=guess
lin manner_N = mkN "Manier" "Manieren" feminine ; -- status=guess
lin background_N = mkN "Schreibtischhintergrund" masculine ; -- status=guess
lin key_N = variants{} ; -- 
lin key_2_N = variants{} ; -- 
lin key_1_N = variants{} ; -- 
lin touch_V2 = mkV2 (mkV "berühren") ; -- status=guess, src=wikt
lin touch_V = mkV "berühren" ; -- status=guess, src=wikt
lin vary_V2 = mkV2 (mkReflV "ändern" | regV "variieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin vary_V = mkReflV "ändern" | regV "variieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin sexual_A = mk3A "sexuell" "sexueller" "sexuellste" ; -- status=guess
lin ordinary_A = mkA "gewöhnlich" | mkA "ordinär" ; -- status=guess status=guess
lin cabinet_N = mkN "Kabinett" "Kabinette" neuter ; -- status=guess
lin painting_N = mkN "Gemälde" neuter ; -- status=guess
lin entirely_Adv = variants{} ; -- 
lin engine_N = mkN "Motorblock" masculine ; -- status=guess
lin previously_Adv = mkAdv "zuvor" | mkAdv "vorher" | mkAdv "früher" | mkAdv "ehemals" ; -- status=guess status=guess status=guess status=guess
lin administration_N = mkN "Verabreichung" "Verabreichungen" feminine ; -- status=guess
lin tonight_Adv = mkAdv "heute" ; -- status=guess
lin adult_N = mkN "Erwachsener" masculine | mkN "Erwachsene" "Erwachsenen" masculine ; -- status=guess status=guess
lin prefer_VV = mkVV (prefixV "vor" (irregV "ziehen" "zieht" "zog" "zöge" "gezogen") | regV "bevorzugen" | mkV "präferieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prefer_V2 = mkV2 (prefixV "vor" (irregV "ziehen" "zieht" "zog" "zöge" "gezogen") | regV "bevorzugen" | mkV "präferieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin author_N = mkN "Autor" "Autoren" masculine | mkN "Autorin" "Autorinnen" feminine ; -- status=guess status=guess
lin actual_A = mkA "tatsächlich" ; -- status=guess
lin song_N = L.song_N ;
lin investigation_N = mkN "Untersuchung" ; -- status=guess
lin debt_N = mkN "Schuld" "Schulden" feminine | mkN "Verbindlichkeit" feminine | mkN "Verpflichtung" ; -- status=guess status=guess status=guess
lin visitor_N = mkN "Besucher" "Besucher" masculine | mkN "Besucherin" feminine | mkN "Gast" "Gäste" masculine | mkN "Gästin" feminine ; -- status=guess status=guess status=guess status=guess
lin forest_N = mkN "Wald" "Wälder" masculine | mkN "Forst" "Forste" masculine | mkN "Gehölz" neuter | mkN "Hain" "Haine" masculine ; -- status=guess status=guess status=guess status=guess
lin repeat_VS = mkVS (regV "wiederholen") ; -- status=guess, src=wikt
lin repeat_V2 = mkV2 (regV "wiederholen") ; -- status=guess, src=wikt
lin repeat_V = regV "wiederholen" ; -- status=guess, src=wikt
lin wood_N = L.wood_N ;
lin contrast_N = mkN "Kontrast" "Kontraste" masculine ; -- status=guess
lin extremely_Adv = mkAdv "extrem" | mkAdv "äußerst" | mkAdv "krass" ; -- status=guess status=guess status=guess
lin wage_N = mkN "Lohn" "Löhne" masculine ; -- status=guess
lin domestic_A = variants{} ; -- 
lin commit_V2 = mkV2 (irregV "begehen" "begeht" "beging" "beginge" "begangen") ; -- status=guess, src=wikt
lin threat_N = mkN "Drohung" ; -- status=guess
lin bus_N = mkN "Bus" "Busse" masculine ; -- status=guess
lin warm_A = L.warm_A ;
lin sir_N = herr_N | mkN "mein Herr" masculine ; -- status=guess status=guess
lin regulation_N = mkN "Regeln" neuter ; -- status=guess
lin drink_N = mkN "trinken" ; -- status=guess
lin relief_N = mkN "Relief" neuter ; -- status=guess
lin internal_A = regA "intern" | mkA "innerlich" | mkA "inländisch" ; -- status=guess status=guess status=guess
lin strange_A = mk3A "seltsam" "seltsamer" "seltsamste" ; -- status=guess
lin excellent_A = regA "ausgezeichnet" | mk3A "hervorragend" "hervorragender" "hervorragendste" | mkA "großartig" ; -- status=guess status=guess status=guess
lin run_N = mkN "Lauf" "Läufe" masculine ; -- status=guess
lin fairly_Adv = mkAdv "gerecht" ; -- status=guess
lin technical_A = regA "technisch" | mk3A "fachlich" "fachlicher" "fachlichste" ; -- status=guess status=guess
lin tradition_N = mkN "Tradition" | mkN "Überlieferung" feminine ;
lin measure_V2 = mkV2 (irregV "messen" "messt" "maß" "mäße" "gemessen") ; -- status=guess, src=wikt
lin measure_V = irregV "messen" "messt" "maß" "mäße" "gemessen" ; -- status=guess, src=wikt
lin insist_VS = mkVS (fixprefixV "be" I.stehen_V) ;
lin insist_V2 = mkV2 (fixprefixV "be" I.stehen_V) ;
lin insist_V = fixprefixV "be" I.stehen_V ;
lin farmer_N = mkN "Landwirt" "Landwirte" masculine | mkN "Landwirtin" feminine | mkN "Bauer" "Bauern" masculine | mkN "Bäuerin" feminine | mkN "Farmer" masculine | mkN "Farmerin" feminine ;
lin until_Prep = variants{} ; -- 
lin traffic_N = mkN "Verkehrsberuhigung" feminine ; -- status=guess
lin dinner_N = mkN "Futter" neuter ; -- status=guess
lin consumer_N = mkN "Konsument" "Konsumenten" masculine | mkN "Verbraucher" "Verbraucher" masculine ; -- status=guess status=guess
lin meal_N = mkN "Mehl" "Mehle" neuter ; -- status=guess
lin warn_VS = mkVS (regV "warnen" | mkV "verständigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin warn_V2V = mkV2V (regV "warnen" | mkV "verständigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin warn_V2 = mkV2 (regV "warnen" | mkV "verständigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin warn_V = regV "warnen" | mkV "verständigen" ; -- status=guess, src=wikt status=guess, src=wikt
lin living_A = regA "lebend" ; -- status=guess
lin package_N = mkN "Paket" "Pakete" neuter ; -- status=guess
lin half_N = mkN "Hälfte" feminine ; -- status=guess
lin increasingly_Adv = mkAdv "zunehmend" ; -- status=guess
lin description_N = mkN "Beschreibung" ; -- status=guess
lin soft_A = mk3A "sanft" "sanfter" "sanfteste" ; -- status=guess
lin stuff_N = mkN "Kram" masculine ; -- status=guess status=guess
lin award_V3 = variants{} ; -- 
lin award_V2 = variants{} ; -- 
lin existence_N = mkN "Existenz" "Existenzen" feminine | mkN "Sein" neuter ; -- status=guess status=guess
lin improvement_N = mkN "Verbesserung" ; -- status=guess
lin coffee_N = mkN "Kaffeebohne" "Kaffeebohnen" feminine ; -- status=guess
lin appearance_N = mkN "Aussehen" neuter ; -- status=guess
lin standard_A = variants{} ; -- 
lin attack_V2 = mkV2 (prefixV "an" (irregV "greifen" "greift" "griff" "griffe" "gegriffen") | irregV "attackieren" "attackiert" "attackierte" "attackierte" "attackiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin sheet_N = mkN "Schicht" "Schichten" feminine ; -- status=guess
lin category_N = mkN "Kategorie" "Kategorien" feminine ; -- status=guess
lin distribution_N = mkN "Distribution" | mkN "Verbreitung" | mkN "Austeilung" feminine ; -- status=guess status=guess status=guess
lin equally_Adv = mkAdv "gleichermaßen" | mkAdv "gleich" | mkAdv "gleichmäßig" ; -- status=guess status=guess status=guess
lin session_N = mkN "Sitzung" ; -- status=guess
lin cultural_A = mk3A "kulturell" "kultureller" "kulturellste" ; -- status=guess
lin loan_N = mkN "Anleihe" "Anleihen" feminine | mkN "Darlehen" "Darlehen" neuter ; -- status=guess status=guess
lin bind_V2 = mkV2 (irregV "verbinden" "verbindet" "verband" "verbände" "verbunden" | mkV "konnektieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin bind_V = irregV "verbinden" "verbindet" "verband" "verbände" "verbunden" | mkV "konnektieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin museum_N = mkN "Museum" "Museen" neuter ; -- status=guess
lin conversation_N = mkN "Konversation" | mkN "Unterhaltung" | mkN "Gespräch" neuter ; -- status=guess status=guess status=guess
lin threaten_VV = mkVV (regV "drohen" | regV "bedrohen") ; -- status=guess, src=wikt status=guess, src=wikt
lin threaten_VS = mkVS (regV "drohen" | regV "bedrohen") ; -- status=guess, src=wikt status=guess, src=wikt
lin threaten_V2 = mkV2 (regV "drohen" | regV "bedrohen") ; -- status=guess, src=wikt status=guess, src=wikt
lin threaten_V = regV "drohen" | regV "bedrohen" ; -- status=guess, src=wikt status=guess, src=wikt
lin link_N = mkN "Link" "Links" masculine | mkN "Hyperlink" masculine ; -- status=guess status=guess
lin launch_V2 = mkV2 (mkV "abschießen" | regV "lancieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin launch_V = mkV "abschießen" | regV "lancieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin proper_A = mk3A "eigen" "eigener" "eigenste" ; -- status=guess
lin victim_N = mkN "Opfer" "Opfer" neuter ; -- status=guess
lin audience_N = mkN "Audienz" "Audienzen" feminine ; -- status=guess
lin famous_A = mkA "berühmt" ; -- status=guess
lin master_N = variants{} ; -- 
lin master_2_N = variants{} ; -- 
lin master_1_N = variants{} ; -- 
lin lip_N = mkN "Lippenbalsam" masculine | mkN "Lippencreme" feminine ; -- status=guess status=guess
lin religious_A = mkA "religiös" | mkA "gläubig" ; -- status=guess status=guess
lin joint_A = mkA "gemeinsamer" ; -- status=guess
lin cry_V2 = mkV2 (irregV "schreien" "schreit" "schrie" "schriee" "geschrien") ; -- status=guess, src=wikt
lin cry_V = irregV "schreien" "schreit" "schrie" "schriee" "geschrien" ; -- status=guess, src=wikt
lin potential_A = mkA "möglich" | regA "potenziell" | regA "potentiell" ; -- status=guess status=guess status=guess
lin broad_A = L.broad_A ;
lin exhibition_N = mkN "Ausstellung" ; -- status=guess
lin experience_V2 = mkV2 (irregV "erfahren" "erfahrt" "erfuhr" "erführe" "erfahren" | irregV "erleben" "erlebt" "erlebte" "erlebte" "erlebt") ; -- status=guess, src=wikt status=guess, src=wikt
lin judge_N = mkN "Richter" "Richter" masculine | mkN "Richterin" "Richterinnen" feminine ; -- status=guess status=guess
lin formal_A = mk3A "formal" "formaler" "formalste" | mk3A "formell" "formeller" "formellste" ; -- status=guess status=guess
lin housing_N = variants{} ; -- 
lin past_Prep = variants{} ; -- 
lin concern_V2 = variants{} ; -- 
lin freedom_N = mkN "Freiheit" "Freiheiten" feminine ; -- status=guess
lin gentleman_N = herr_N ; -- status=guess
lin attract_V2 = mkV2 (prefixV "an" (irregV "ziehen" "zieht" "zog" "zöge" "gezogen")) ; -- status=guess, src=wikt
lin explanation_N = mkN "Erklärung" feminine ; -- status=guess
lin appoint_V3 = variants{} ; -- 
lin appoint_V2V = variants{} ; -- 
lin appoint_V2 = variants{} ; -- 
lin note_VS = variants{} ; -- 
lin note_V2 = variants{} ; -- 
lin note_V = variants{} ; -- 
lin chief_A = mkA "hauptsächlich" | mkA "primär" ; -- status=guess status=guess
lin total_N = mkN "Gesamtbetrag" masculine | mkN "Gesamtsumme" feminine ; -- status=guess status=guess
lin lovely_A = mk3A "lieblich" "lieblicher" "lieblichste" ; -- status=guess
lin official_A = mk3A "offiziell" "offizieller" "offiziellste" | mk3A "amtlich" "amtlicher" "amtlichste" | mkA "dienstlich" ; -- status=guess status=guess status=guess
lin date_V2 = mkV2 (mkV "datieren") ; -- status=guess, src=wikt
lin date_V = mkV "datieren" ; -- status=guess, src=wikt
lin demonstrate_VS = mkVS (irregV "demonstrieren" "demonstriert" "demonstrierte" "demonstrierte" "demonstriert") ; -- status=guess, src=wikt
lin demonstrate_V2 = mkV2 (irregV "demonstrieren" "demonstriert" "demonstrierte" "demonstrierte" "demonstriert") ; -- status=guess, src=wikt
lin demonstrate_V = irregV "demonstrieren" "demonstriert" "demonstrierte" "demonstrierte" "demonstriert" ; -- status=guess, src=wikt
lin construction_N = mkN "Konstruktion" ; -- status=guess
lin middle_N = mkN "Mittelpunkt" "Mittelpunkte" masculine ; -- status=guess
lin yard_N = mkN "Hof" "Höfe" masculine ; -- status=guess
lin unable_A = mkA "unfähig" ; -- status=guess
lin acquire_V2 = mkV2 (irregV "erwerben" "erwerbt" "erwarb" "erwürbe" "erworben" | regV "akquirieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin surely_Adv = mkAdv "sicherlich" ; -- status=guess
lin crisis_N = mkN "Krise" "Krisen" feminine ; -- status=guess
lin propose_VV = mkVV (irregV "einen" "eint" "einte" "einte" "geeint") ; -- status=guess, src=wikt
lin propose_VS = mkVS (irregV "einen" "eint" "einte" "einte" "geeint") ; -- status=guess, src=wikt
lin propose_V2 = mkV2 (irregV "einen" "eint" "einte" "einte" "geeint") ; -- status=guess, src=wikt
lin propose_V = irregV "einen" "eint" "einte" "einte" "geeint" ; -- status=guess, src=wikt
lin west_N = mkN "West" masculine | mkN "Westen" masculine ; -- status=guess status=guess
lin impose_V2 = mkV2 (mkV "auferlegen") ; -- status=guess, src=wikt
lin impose_V = mkV "auferlegen" ; -- status=guess, src=wikt
lin market_V2 = mkV2 (mkV "vermarkten") ; -- status=guess, src=wikt
lin market_V = mkV "vermarkten" ; -- status=guess, src=wikt
lin care_V = regV "sorgen" | mkReflV "sorgen" | mkReflV "kümmern" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin god_N = mkN "Gott" "Götter" masculine | mkN "Göttin" feminine ;
lin favour_N = variants{} ; -- 
lin before_Adv = mkAdv "zuvor" ; -- status=guess
lin name_V3 = mkV3 (irregV "ernennen" "ernennt" "ernannte" "ernannte" "ernannt") ; -- status=guess, src=wikt
lin name_V2 = mkV2 (irregV "ernennen" "ernennt" "ernannte" "ernannte" "ernannt") ; -- status=guess, src=wikt
lin equal_A = regA "gleich" ; -- status=guess
lin capacity_N = mkN "Kapazität" feminine ; -- status=guess
lin flat_N = mkN "Schiebermütze" feminine ; -- status=guess
lin selection_N = mkN "Anwahl" feminine | mkN "Auswahl" "Auswahlen" feminine | mkN "Wahl" "Wahlen" feminine | mkN "Aufruf" "Aufrufe" masculine | mkN "Aussonderung" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin alone_Adv = mkAdv "allein" | mkAdv "einsam" ; -- status=guess status=guess
lin football_N = mkN "Fußball" masculine | mkN "Fußball" "Fußbälle" masculine ; -- status=guess status=guess
lin victory_N = mkN "Sieg" "Siege" masculine ; -- status=guess
lin factory_N = L.factory_N ;
lin rural_A = mkA "ländlich" | mkA "dörflich" ; -- status=guess status=guess
lin twice_Adv = mkAdv "zweimal" ; -- status=guess
lin sing_V2 = mkV2 (irregV "singen" "singt" "sang" "sänge" "gesungen") ; -- status=guess, src=wikt
lin sing_V = L.sing_V ;
lin whereas_Subj = variants{} ; -- 
lin own_V2 = mkV2 (prefixV "ein" (irregV "gestehen" "gesteht" "gestand" "gestand" "gestanden") | prefixV "zu" (irregV "geben" "gebt" "gab" "gäbe" "gegeben")) ; -- status=guess, src=wikt status=guess, src=wikt
lin head_V2 = mkV2 (mkV "ansteuern") | mkV2 (junkV (mkV "in") "eine Richtung gehen") | mkV2 (junkV (mkV "auf") "etwas zusteuern") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin head_V = mkV "ansteuern" | junkV (mkV "in") "eine Richtung gehen" | junkV (mkV "auf") "etwas zusteuern" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin examination_N = mkN "Prüfung" feminine | mkN "Test" masculine | mkN "Überprüfung" feminine | mkN "Erprobung" | mkN "Versuch" "Versuche" masculine | mkN "Examen" neuter ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin deliver_V2 = mkV2 (regV "liefern" | mkV "abliefern") ; -- status=guess, src=wikt status=guess, src=wikt
lin deliver_V = regV "liefern" | mkV "abliefern" ; -- status=guess, src=wikt status=guess, src=wikt
lin nobody_NP = S.nobody_NP ;
lin substantial_A = mk3A "wesentlich" "wesentlicher" "wesentlichste" ; -- status=guess
lin invite_V2V = mkV2V (prefixV "ein" (irregV "laden" "lädt" "lud" "lüde" "geladen")) ; -- status=guess, src=wikt
lin invite_V2 = mkV2 (prefixV "ein" (irregV "laden" "lädt" "lud" "lüde" "geladen")) ; -- status=guess, src=wikt
lin intention_N = mkN "Absicht" "Absichten" feminine ; -- status=guess
lin egg_N = L.egg_N ;
lin reasonable_A = mkA "vernünftig" | mkA "anständig" ; -- status=guess status=guess
lin onto_Prep = variants{} ; -- 
lin retain_V2 = mkV2 (prefixV "fest" (irregV "halten" "hält" "hielt" "hielte" "gehalten")) ; -- status=guess, src=wikt
lin aircraft_N = mkN "Luftfahrzeug" "Luftfahrzeuge" neuter ; -- status=guess
lin decade_N = mkN "Jahrzehnt" "Jahrzehnte" neuter | mkN "Dekade" "Dekaden" feminine ; -- status=guess status=guess
lin cheap_A = mk3A "billig" "billiger" "billigste" | mk3A "preiswert" "preiswerter" "preiswertesten e" | mkA "preisgünstig" ; -- status=guess status=guess status=guess
lin quiet_A = mk3A "still" "stiller" "stillste" ; -- status=guess
lin bright_A = mk3A "heiter" "heiterer" "heiterste" ; -- status=guess
lin contribute_V2 = mkV2 (prefixV "bei" (irregV "steuern" "steuert" "steue" "steuere" "gesteuert") | prefixV "bei" (irregV "tragen" "tragt" "trug" "trüge" "getragen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin contribute_V = prefixV "bei" (irregV "steuern" "steuert" "steue" "steuere" "gesteuert") | prefixV "bei" (irregV "tragen" "tragt" "trug" "trüge" "getragen") ; -- status=guess, src=wikt status=guess, src=wikt
lin row_N = mkN "Aufruhr" "Aufruhre" masculine | mkN "Donnerwetter" neuter | mkN "Klamauk" masculine | mkN "Krach" "Kräche" masculine | mkN "Krakeel" masculine | mkN "Krawall" "Krawalle" masculine | mkN "Lärm" masculine | mkN "Rabatz" masculine | mkN "Radau" "Radaue" masculine | mkN "Spektakel" "Spektakel" neuter | mkN "Tumult" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin search_N = mkN "Suche" "Suchen" feminine ; -- status=guess
lin limit_N = mkN "Grenze" "Grenzen" feminine | mkN "Begrenzer" masculine ; -- status=guess status=guess
lin definition_N = mkN "Begriffserklärung" feminine | mkN "Definierung" feminine ; -- status=guess status=guess
lin unemployment_N = mkN "Arbeitslosigkeit" feminine ; -- status=guess
lin spread_V2 = mkV2 (mkReflV "wie ein Lauffeuer verbreiten") ; -- status=guess, src=wikt
lin spread_V = mkReflV "wie ein Lauffeuer verbreiten" ; -- status=guess, src=wikt
lin mark_N = mkN "Note" "Noten" feminine ; -- status=guess
lin flight_N = mkN "Flucht" "Fluchten" feminine ; -- status=guess
lin account_V2 = variants{} ; -- 
lin account_V = variants{} ; -- 
lin output_N = variants{} ; -- 
lin last_V = regV "dauern" | prefixV "aus" (irregV "halten" "hält" "hielt" "hielte" "gehalten") ; -- status=guess, src=wikt status=guess, src=wikt
lin tour_N = mkN "Meisterstück" ; -- status=guess
lin address_N = mkN "verbaler Antrag" masculine ; -- status=guess
lin immediate_A = mk3A "unmittelbar" "unmittelbarer" "unmittelbarste" | mkA "immediat" ; -- status=guess status=guess
lin reduction_N = mkN "Reduktion" | mkN "Reduzierung" feminine ; -- status=guess status=guess
lin interview_N = mkN "Vorstellungsgespräch" neuter | mkN "Interview" "Interviews" neuter ; -- status=guess status=guess
lin assess_V2 = variants{} ; -- 
lin promote_V2 = mkV2 (mkV "befördern" | irregV "promovieren" "promoviert" "promovierte" "promovierte" "promoviert") ; -- status=guess, src=wikt status=guess, src=wikt
lin promote_V = mkV "befördern" | irregV "promovieren" "promoviert" "promovierte" "promovierte" "promoviert" ; -- status=guess, src=wikt status=guess, src=wikt
lin everybody_NP = S.everybody_NP ;
lin suitable_A = mk3A "geeignet" "geeigneter" "geeignetste" ; -- status=guess
lin growing_A = variants{} ; -- 
lin nod_V = mkV "einnicken" ; -- status=guess, src=wikt
lin reject_V2 = mkV2 (irregV "verwerfen" "verwerft" "verwarf" "verwürfe" "verworfen" | prefixV "ab" (regV "lehnen") | mkV "zurückweisen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin while_N = mkN "Weile" feminine ; ---- | mkN "Weilchen {n} diminutive" | zeitspanne_N ; -- status=guess status=guess status=guess
lin high_Adv = variants{} ; -- 
lin dream_N = mkN "Traum" "Träume" masculine | mkN "Wunsch" "Wünsche" masculine ; -- status=guess status=guess
lin vote_VV = mkVV (mkV "wählen" | irregV "stimmen" "stimmt" "stimmte" "stimmte" "stimmt") ; -- status=guess, src=wikt status=guess, src=wikt
lin vote_V3 = variants{}; -- mkV2 (mkV "wählen" | irregV "stimmen" "stimmt" "stimmte" "stimmte" "stimmt") ; -- status=guess, src=wikt status=guess, src=wikt
lin vote_V2 = mkV2 (mkV "wählen" | irregV "stimmen" "stimmt" "stimmte" "stimmte" "stimmt") ; -- status=guess, src=wikt status=guess, src=wikt
lin vote_V = mkV "wählen" | irregV "stimmen" "stimmt" "stimmte" "stimmte" "stimmt" ; -- status=guess, src=wikt status=guess, src=wikt
lin divide_V2 = mkV2 (junkV (mkV "teile") "und herrsche") ; -- status=guess, src=wikt
lin divide_V = junkV (mkV "teile") "und herrsche" ; -- status=guess, src=wikt
lin declare_VS = mkVS (mkV "verzollen") ; -- status=guess, src=wikt
lin declare_V2 = mkV2 (mkV "verzollen") ; -- status=guess, src=wikt
lin declare_V = mkV "verzollen" ; -- status=guess, src=wikt
lin handle_V2 = mkV2 (junkV (mkV "mit") "Samthandschuhen anfassen") ; -- status=guess, src=wikt
lin handle_V = junkV (mkV "mit") "Samthandschuhen anfassen" ; -- status=guess, src=wikt
lin detailed_A = mk3A "detailliert" "detaillierter" "detaillierteste" ; -- status=guess
lin challenge_N = mkN "Herausforderung" ; -- status=guess
lin notice_N = mkN "Benachrichtigung" | mkN "Mitteilung" ; -- status=guess status=guess
lin rain_N = L.rain_N ;
lin destroy_V2 = mkV2 (mkV "zerstören" | irregV "vernichten" "vernichtet" "vernichtete" "vernichte" "vernichtet" | prefixV "kaputt" (regV "machen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mountain_N = L.mountain_N ;
lin concentration_N = mkN "Konzentration" ; -- status=guess
lin limited_A = regA "begrenzt" ; -- status=guess
lin finance_N = mkN "Finanz" "Finanzen" feminine ;
lin pension_N = mkN "Pension" ; -- status=guess
lin influence_V2 = mkV2 (regV "beeinflussen") ; -- status=guess, src=wikt
lin afraid_A = mkA "ängstlich" ; -- status=guess
lin murder_N = mkN "Mord" "Morde" masculine ; -- status=guess
lin neck_N = L.neck_N ;
lin weapon_N = mkN "Waffe" "Waffen" feminine ; -- status=guess
lin hide_V2 = mkV2 (junkV (mkV "sein") "Licht unter den Scheffel stellen") ; -- status=guess, src=wikt
lin hide_V = junkV (mkV "sein") "Licht unter den Scheffel stellen" ; -- status=guess, src=wikt
lin offence_N = variants{} ; -- 
lin absence_N = mkN "Abwesenheit" "Abwesenheiten" feminine ; -- status=guess
lin error_N = mkN "Fehlerbalken" masculine ; -- status=guess
lin representativeMasc_N = mkN "Repräsentant" masculine ; -- status=guess
lin enterprise_N = mkN "Unternehmensanwendungsintegration" feminine ; -- status=guess
lin criticism_N = mkN "Kritik" "Kritiken" feminine ; -- status=guess
lin average_A = mk3A "durchschnittlich" "durchschnittlicher" "durchschnittlichste" ; -- status=guess
lin quick_A = regA "quicklebendig" ; -- status=guess
lin sufficient_A = mk3A "ausreichend" "ausreichender" "ausreichendste" | mkA "genügend" | mk3A "hinreichend" "hinreichender" "hinreichendste" ; -- status=guess status=guess status=guess
lin appointment_N = mkN "Ernennung" feminine | mkN "Berufung" ; -- status=guess status=guess
lin match_V2 = mkV2 (mkV "übereinstimmen" | regV "passen") ; -- status=guess, src=wikt status=guess, src=wikt
lin transfer_V = mkV "übertragen" ; -- status=guess, src=wikt
lin acid_N = mkN "Lysergsäure-diethylamid" ; -- status=guess
lin spring_N = mkN "Frühjahrsputz" ; -- status=guess
lin birth_N = mkN "Geburt" "Geburten" feminine ; -- status=guess
lin ear_N = L.ear_N ;
lin recognize_VS = mkVS (fixprefixV "er" I.kennen_V) ;
lin recognize_4_V2 = variants{} ; -- 
lin recognize_1_V2 = variants{} ; -- 
lin recommend_V2V = mkV2V (irregV "empfehlen" "empfehlt" "empfahl" "empfähle" "empfohlen") ; -- status=guess, src=wikt
lin recommend_V2 = mkV2 (irregV "empfehlen" "empfehlt" "empfahl" "empfähle" "empfohlen") ; -- status=guess, src=wikt
lin module_N = mkN "Modul" "Moduln" masculine ; -- status=guess
lin instruction_N = mkN "Unterricht" masculine ; -- status=guess
lin democratic_A = mk3A "demokratisch" "demokratischer" "demokratischste" ; -- status=guess
lin park_N = mkN "Park" masculine ; -- status=guess
lin weather_N = wetter_N ; -- status=guess
lin bottle_N = mkN "Flasche" "Flaschen" feminine ; -- status=guess
lin address_V2 = mkV2 (mkReflV "vorbereiten") ; -- status=guess, src=wikt
lin bedroom_N = mkN "Schlafzimmer" "Schlafzimmer" neuter ; -- status=guess
lin kid_N = kind_N ; -- status=guess
lin pleasure_N = mkN "Vergnügen" neuter ; -- status=guess
lin realize_VS = mkVS (fixprefixV "er" I.kennen_V) ;
lin realize_V2 = mkV2 (irregV "realisieren" "realisiert" "realisierte" "realisierte" "realisiert" | prefixV "um" (mkV "setzen")) ;
lin assembly_N = mkN "Versammlung" ; -- status=guess
lin expensive_A = mk3A "teuer" "teurer" "teuerste" ; -- status=guess
lin select_VV = mkVV (mkV "auswählen") ; -- status=guess, src=wikt
lin select_V2V = mkV2V (mkV "auswählen") ; -- status=guess, src=wikt
lin select_V2 = mkV2 (mkV "auswählen") ; -- status=guess, src=wikt
lin select_V = mkV "auswählen" ; -- status=guess, src=wikt
lin teaching_N = mkN "Lehre" "Lehren" feminine ; -- status=guess
lin desire_N = mkN "Begehren" "Begehren" neuter ; -- status=guess
lin whilst_Subj = variants{} ; -- 
lin contact_V2 = mkV2 (irregV "kontaktieren" "kontaktiert" "kontaktierte" "kontaktierte" "kontaktiert") ; -- status=guess, src=wikt
lin implication_N = mkN "Folge" "Folgen" feminine | mkN "Schlussfolgerung" feminine ; -- status=guess status=guess
lin combine_VV = mkVV (irregV "kombinieren" "kombiniert" "kombinierte" "kombinierte" "kombiniert" | irregV "verbinden" "verbindet" "verband" "verbände" "verbunden") ; -- status=guess, src=wikt status=guess, src=wikt
lin combine_V2 = mkV2 (irregV "kombinieren" "kombiniert" "kombinierte" "kombinierte" "kombiniert" | irregV "verbinden" "verbindet" "verband" "verbände" "verbunden") ; -- status=guess, src=wikt status=guess, src=wikt
lin combine_V = irregV "kombinieren" "kombiniert" "kombinierte" "kombinierte" "kombiniert" | irregV "verbinden" "verbindet" "verband" "verbände" "verbunden" ; -- status=guess, src=wikt status=guess, src=wikt
lin temperature_N = mkN "Temperatur" "Temperaturen" feminine ; -- status=guess
lin wave_N = mkN "Welle" "Wellen" feminine | mkN "Wirbel" "Wirbel" masculine ; -- status=guess status=guess
lin magazine_N = mkN "Magazin" "Magazine" neuter ; -- status=guess
lin totally_Adv = variants{} ; -- 
lin mental_A = regA "geistig" | regA "mental" | regA "psychisch" | regA "seelisch" ; -- status=guess status=guess status=guess status=guess
lin used_A = mkA "gewöhnt" ; -- status=guess
lin store_N = mkN "Lager" neuter | mkN "Speicher" "Speicher" masculine ; -- status=guess status=guess
lin scientific_A = mk3A "wissenschaftlich" "wissenschaftlicher" "wissenschaftlichste" ; -- status=guess
lin frequently_Adv = mkAdv "häufig" ; -- status=guess
lin thanks_N = mkN "Dank" masculine | mkN "Danksagung" feminine ; -- status=guess status=guess
lin beside_Prep = variants{} ; -- 
lin settlement_N = mkN "Ansiedlung" | mkN "Siedlung" | mkN "Niederlassung" feminine | mkN "Kolonie" "Kolonien" feminine ; -- status=guess status=guess status=guess status=guess
lin absolutely_Adv = variants{} ; -- 
lin critical_A = variants{} ; -- 
lin critical_2_A = variants{} ; -- 
lin critical_1_A = variants{} ; -- 
lin recognition_N = mkN "Anerkennung" ; -- status=guess
lin touch_N = mkN "Berührung" feminine ; -- status=guess
lin consist_V = irregV "bestehen" "besteht" "bestand" "bestände" "bestanden" ; -- status=guess, src=wikt
lin below_Prep = variants{} ; -- 
lin silence_N = mkN "Schweigen" neuter ; -- status=guess
lin expenditure_N = mkN "Aufwand" "Aufwände" masculine ; -- status=guess
lin institute_N = mkN "Institut" "Institute" neuter ; -- status=guess
lin dress_V2 = mkV2 (mkV "kleiden" | mkV "ankleiden" | prefixV "an" (irregV "ziehen" "zieht" "zog" "zöge" "gezogen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dress_V = mkV "kleiden" | mkV "ankleiden" | prefixV "an" (irregV "ziehen" "zieht" "zog" "zöge" "gezogen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dangerous_A = mkA "gefährlich" ; -- status=guess
lin familiar_A = mk3A "bekannt" "bekannter" "bekannteste" ; -- status=guess
lin asset_N = mkN "Vermögenswert" feminine ; ---- mkN "Aktiva {n} {p}" status=guess status=guess
lin educational_A = variants{} ; -- 
lin sum_N = mkN "Summe" "Summen" feminine ; -- status=guess
lin publication_N = mkN "Veröffentlichung" feminine ; -- status=guess
lin partly_Adv = mkAdv "teilweise" ; -- status=guess
lin block_N = mkN "Block" masculine | mkN "Klotz" "Klötze" masculine ; -- status=guess status=guess
lin seriously_Adv = mkAdv "ernst" | mkAdv "ernsthaft" ; -- status=guess status=guess
lin youth_N = mkN "Jugendherberge" "Jugendherbergen" feminine ; -- status=guess
lin tape_N = mkN "Klebeband" neuter ; -- status=guess
lin elsewhere_Adv = mkAdv "woanders" | mkAdv "anderswo" ; -- status=guess status=guess
lin cover_N = mkN "Einband" masculine | mkN "Umschlag" "Umschläge" masculine ; -- status=guess status=guess
lin fee_N = mkN "Gebühr" feminine ; -- status=guess
lin program_N = mkN "Programm" "Programme" neuter ; -- status=guess
lin treaty_N = mkN "Vertrag" "Verträge" masculine | mkN "Bündnis" neuter ; -- status=guess status=guess
lin necessarily_Adv = mkAdv "notwendigerweise" | mkAdv "very rare: nötig" ; -- status=guess status=guess
lin unlikely_A = mk3A "unwahrscheinlich" "unwahrscheinlicher" "unwahrscheinlichste" ; -- status=guess
lin properly_Adv = mkAdv "ordnungsgemäß" | mkAdv "ordentlich" | mkAdv "richtig" ; -- status=guess status=guess status=guess
lin guest_N = mkN "Gast" "Gäste" masculine ; -- status=guess
lin code_N = mkN "Gesetzbuch" "Gesetzbücher" neuter ; -- status=guess
lin hill_N = L.hill_N ;
lin screen_N = mkN "Schirm" "Schirme" masculine ; -- status=guess
lin household_N = mkN "Haushalt" "Haushalte" masculine ; -- status=guess
lin sequence_N = mkN "Folge" "Folgen" feminine ; -- status=guess
lin correct_A = L.correct_A ;
lin female_A = mk3A "weiblich" "weiblicher" "weiblichste" ; -- status=guess
lin phase_N = mkN "Phasendiagramm" neuter ; -- status=guess
lin crowd_N = mkN "Gedränge" neuter ; -- status=guess
lin welcome_V2 = mkV2 (junkV (mkV "willkommen") "heißen") | mkV2 (mkV "begrüßen") ; -- status=guess, src=wikt status=guess, src=wikt
lin metal_N = mkN "Metall" "Metalle" neuter ; -- status=guess
lin human_N = mensch_N ; -- status=guess
lin widely_Adv = mkAdv "breit" ; -- status=guess
lin undertake_V2 = mkV2 (mkReflV "verpflichten") ; -- status=guess, src=wikt
lin cut_N = mkN "schneiden" masculine ; -- status=guess
lin sky_N = L.sky_N ;
lin brain_N = mkN "Verstand" masculine | mkN "Köpfchen" neuter | mkN "Grips" masculine | mkN "Hirn" "Hirne" neuter ; -- status=guess status=guess status=guess status=guess
lin expert_N = mkN "Experte" "Experten" masculine ; -- status=guess
lin experiment_N = mkN "Experiment" "Experimente" neuter | mkN "Versuch" "Versuche" masculine ; -- status=guess status=guess
lin tiny_A = mk3A "winzig" "winziger" "winzigste" ; -- status=guess
lin perfect_A = regA "perfekt" | mk3A "vollkommen" "vollkommener" "vollkommenste" ; -- status=guess status=guess
lin disappear_V = junkV (mkV "zum") "Verschwinden bringen" | irregV "verschwinden" "verschwindet" "verschwand" "verschwände" "verschwunden" ; -- status=guess, src=wikt status=guess, src=wikt
lin initiative_N = mkN "Initiative" "Initiativen" feminine ; -- status=guess
lin assumption_N = mkN "Himmelfahrt" "Himmelfahrten" feminine | mkN "Auffahrt" "Auffahrten" feminine ; -- status=guess status=guess
lin photograph_N = mkN "Fotografie" "Fotografien" feminine | mkN "Fotographie" feminine | mkN "Foto" "Fotos" neuter | mkN "Lichtbild" neuter ; -- status=guess status=guess status=guess status=guess
lin ministry_N = mkN "Ministerium" "Ministerien" neuter ; -- status=guess
lin congress_N = mkN "Kongress" "Kongresse" masculine ; -- status=guess
lin transfer_N = mkN "Übertragung" feminine | mkN "Versetzung" | mkN "Überweisung" feminine ; -- status=guess status=guess status=guess
lin reading_N = mkN "Lesen" neuter ; -- status=guess
lin scientist_N = mkN "Wissenschaftler" "Wissenschaftler" masculine | mkN "Wissenschaftlerin" "Wissenschaftlerinnen" feminine ; -- status=guess status=guess
lin fast_Adv = mkAdv "fest" ; -- status=guess
lin fast_A = mk3A "schnell" "schneller" "schnellste" | mk3A "geschwind" "geschwinder" "geschwindeste" | regA "pfeilschnell" | mkA "pfeilgeschwind" ; -- status=guess status=guess status=guess status=guess
lin closely_Adv = mkAdv "dicht" | mkAdv "eng" ; -- status=guess status=guess
lin thin_A = L.thin_A ;
lin solicitorMasc_N = mkN "Solicitor" masculine | mkN "Rechtsanwalt" "Rechtsanwälte" masculine | mkN "der&nbsp;Damenflügel" "die&nbsp;Damenflügel" masculine ; -- status=guess status=guess status=guess
lin secure_V2 = mkV2 (irregV "sichern" "sichert" "sicherte" "sicherte" "sichert" | prefixV "ab" (irregV "sichern" "sichert" "siche" "sichere" "gesichert")) ; -- status=guess, src=wikt status=guess, src=wikt
lin plate_N = gang_N ; -- status=guess
lin pool_N = mkN "Becken" "Becken" neuter ; -- status=guess
lin gold_N = L.gold_N ;
lin emphasis_N = mkN "Betonung" | mkN "Gewichtung" feminine ; -- status=guess status=guess
lin recall_VS = mkVS (mkV "zurückrufen") ; -- status=guess, src=wikt
lin recall_V2 = mkV2 (mkV "zurückrufen") ; -- status=guess, src=wikt
lin shout_V2 = mkV2 (regV "spendieren" | mkV "schmeißen") ; -- status=guess, src=wikt status=guess, src=wikt
lin shout_V = regV "spendieren" | mkV "schmeißen" ; -- status=guess, src=wikt status=guess, src=wikt
lin generate_V2 = mkV2 (irregV "erzeugen" "erzeugt" "erzeugte" "erzeugte" "erzeugt") ; -- status=guess, src=wikt
lin location_N = mkN "Ort" "Orte" masculine | mkN "Platz" "Plätze" masculine ; -- status=guess status=guess
lin display_VS = mkVS (prefixV "an" (regV "zeigen")) ; -- status=guess, src=wikt
lin display_V2 = mkV2 (prefixV "an" (regV "zeigen")) ; -- status=guess, src=wikt
lin heat_N = mkN "Schärfe" feminine ; -- status=guess
lin gun_N = mkN "Gewehr" "Gewehre" neuter ; -- status=guess
lin shut_V2 = mkV2 (mkV "schließen" | prefixV "zu" (regV "machen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin journey_N = mkN "Reise" "Reisen" feminine | tour_N ; -- status=guess status=guess
lin imply_VS = mkVS (irregV "bedeuten" "bedeutet" "bedeutete" "bedeutete" "bedeutet" | irregV "implizieren" "impliziert" "implizierte" "implizierte" "impliziert") ; -- status=guess, src=wikt status=guess, src=wikt
lin imply_V2 = mkV2 (irregV "bedeuten" "bedeutet" "bedeutete" "bedeutete" "bedeutet" | irregV "implizieren" "impliziert" "implizierte" "implizierte" "impliziert") ; -- status=guess, src=wikt status=guess, src=wikt
lin imply_V = irregV "bedeuten" "bedeutet" "bedeutete" "bedeutete" "bedeutet" | irregV "implizieren" "impliziert" "implizierte" "implizierte" "impliziert" ; -- status=guess, src=wikt status=guess, src=wikt
lin violence_N = mkN "Gewalt" "Gewalten" feminine ;
lin dry_A = L.dry_A ;
lin historical_A = mkA "geschichtlich" | mk3A "historisch" "historischer" "historischste" ; -- status=guess status=guess
lin step_V2 = mkV2 (irregV "treten" "tritt" "trat" "träte" "getreten" | mkV "schreiten") ; -- status=guess, src=wikt status=guess, src=wikt
lin step_V = irregV "treten" "tritt" "trat" "träte" "getreten" | mkV "schreiten" ; -- status=guess, src=wikt status=guess, src=wikt
lin curriculum_N = mkN "Lebenslauf" "Lebensläufe" masculine ; -- status=guess
lin noise_N = mkN "Lärmbelastung" feminine ; -- status=guess
lin lunch_N = mkN "Mittagessen" "Mittagessen" neuter | mkN "Lunch" masculine ; -- status=guess status=guess
lin fear_VS = L.fear_VS ;
lin fear_V2 = L.fear_V2 ;
lin fear_V = mkV "fürchten" | junkV (mkV "Angst") "haben" ; -- status=guess, src=wikt status=guess, src=wikt
lin succeed_V2 = mkV2 (prefixV "nach" (regV "folgen")) ; -- status=guess, src=wikt
lin succeed_V = prefixV "nach" (regV "folgen") ; -- status=guess, src=wikt
lin fall_N = variants{} ; -- 
lin fall_2_N = variants{} ; -- 
lin fall_1_N = variants{} ; -- 
lin bottom_N = mkN "Boden" "Böden" masculine | mkN "Grund" "Gründe" masculine | mkN "Unterseite" feminine ; -- status=guess status=guess status=guess
lin initial_A = mkA "anfänglich" | mkA "ursprünglich" ; -- status=guess status=guess
lin theme_N = mkN "Themenpark" masculine ; -- status=guess
lin characteristic_N = mkN "Merkmal" "Merkmale" neuter | mkN "Eigenschaft" "Eigenschaften" feminine | mkN "Charakteristik" "Charakteristiken" feminine | mkN "Eigenart" "Eigenarten" feminine ; -- status=guess status=guess status=guess status=guess
lin pretty_Adv = mkAdv "ziemlich" | mkAdv "einigermaßen" ; -- status=guess status=guess
lin empty_A = L.empty_A ;
lin display_N = mkN "Display" "Displays" neuter | mkN "Monitor" masculine | mkN "Bildschirm" "Bildschirme" masculine | mkN "Anzeige" "Anzeigen" feminine ; -- status=guess status=guess status=guess status=guess
lin combination_N = mkN "Kombination" ; -- status=guess
lin interpretation_N = mkN "Interpretation" ; -- status=guess
lin rely_V2 = variants{}; -- mkReflV "verlassen auf" ; -- status=guess, src=wikt
lin rely_V = mkReflV "verlassen auf" ; -- status=guess, src=wikt
lin escape_VS = mkVS (mkV "davonkommen") ; -- status=guess, src=wikt
lin escape_V2 = mkV2 (mkV "davonkommen") ; -- status=guess, src=wikt
lin escape_V = mkV "davonkommen" ; -- status=guess, src=wikt
lin score_V2 = mkV2 (irregV "treffen" "trefft" "traf" "träfe" "getroffen" | mkV "punkten") ; -- status=guess, src=wikt status=guess, src=wikt
lin score_V = irregV "treffen" "trefft" "traf" "träfe" "getroffen" | mkV "punkten" ; -- status=guess, src=wikt status=guess, src=wikt
lin justice_N = mkN "Gerechtigkeit" "Gerechtigkeiten" feminine ; -- status=guess
lin upper_A = mkA "obere" ; -- status=guess
lin tooth_N = L.tooth_N ;
lin organize_V2V = mkV2V (regV "organisieren") ; -- status=guess, src=wikt
lin organize_V2 = mkV2 (regV "organisieren") ; -- status=guess, src=wikt
lin cat_N = L.cat_N ;
lin tool_N = mkN "Tool" neuter ; -- status=guess
lin spot_N = mkN "Werbespot" masculine ; -- status=guess
lin bridge_N = mkN "Bridge" neuter ; -- status=guess
lin double_A = mkA "doppel-" ; -- status=guess
lin direct_V2 = variants{} ; -- 
lin direct_V = variants{} ; -- 
lin conclude_VS = mkVS (regV "beenden" | regV "folgern") ; -- status=guess, src=wikt status=guess, src=wikt
lin conclude_V2 = mkV2 (regV "beenden" | regV "folgern") ; -- status=guess, src=wikt status=guess, src=wikt
lin conclude_V = regV "beenden" | regV "folgern" ; -- status=guess, src=wikt status=guess, src=wikt
lin relative_A = mkA "vergleichsweise" | mk3A "relativ" "relativer" "relativsten e" ; -- status=guess status=guess
lin soldier_N = mkN "Soldat" "Soldaten" masculine | mkN "Soldatin" "Soldatinnen" feminine ; -- status=guess status=guess
lin climb_V2 = mkV2 (irregV "klettern" "klettert" "kletterte" "klettere" "geklettert" | irregV "steigen" "steigt" "stieg" "stiege" "gestiegen") ; -- status=guess, src=wikt status=guess, src=wikt
lin climb_V = irregV "klettern" "klettert" "kletterte" "klettere" "geklettert" | irregV "steigen" "steigt" "stieg" "stiege" "gestiegen" ; -- status=guess, src=wikt status=guess, src=wikt
lin breath_N = mkN "Atempause" "Atempausen" feminine ; -- status=guess
lin afford_V2V = mkV2V (mkReflV "leisten") | mkV2V (junkV (mkV "imstande") "sein") ; -- status=guess, src=wikt status=guess, src=wikt
lin afford_V2 = mkV2 (mkReflV "leisten") | mkV2 (junkV (mkV "imstande") "sein") ; -- status=guess, src=wikt status=guess, src=wikt
lin urban_A = mkA "städtisch" | mk3A "urban" "urbaner" "urbanste" ; -- status=guess status=guess
lin nurse_N = mkN "Schwester" "Schwestern" feminine | mkN "Krankenschwester" "Krankenschwestern" feminine | mkN "Pflegerin" feminine | mkN "Krankenpflegerin" "Krankenpflegerinnen" feminine | mkN "Pfleger" masculine | mkN "Krankenpfleger" "Krankenpfleger" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin narrow_A = L.narrow_A ;
lin liberal_A = variants{} ; -- 
lin coal_N = mkN "Kohle" "Kohlen" feminine ; -- status=guess
lin priority_N = mkN "Priorität" feminine ; -- status=guess
lin wild_A = mk3A "wild" "wilder" "wildeste" ; -- status=guess
lin revenue_N = mkN "Einnahmen" ; -- status=guess
lin membership_N = mkN "Mitgliedschaft" "Mitgliedschaften" feminine ; -- status=guess
lin grant_N = variants{} ; -- 
lin approve_V2 = mkV2 (mkV "bewilligen") ; -- status=guess, src=wikt
lin approve_V = mkV "bewilligen" ; -- status=guess, src=wikt
lin tall_A = mkA "hoch" "hoh" "höher" "höchste" ; -- status=guess
lin apparent_A = mk3A "offensichtlich" "offensichtlicher" "offensichtlichste" ; -- status=guess
lin faith_N = mkN "Glaube" masculine ; -- status=guess
lin under_Adv = mkAdv "unter keinen Umständen" | mkAdv "auf" | mkAdv "auf" ; -- status=guess status=guess status=guess
lin fix_V2 = mkV2 (irregV "reparieren" "repariert" "reparierte" "reparierte" "repariert") ; -- status=guess, src=wikt
lin fix_V = irregV "reparieren" "repariert" "reparierte" "reparierte" "repariert" ; -- status=guess, src=wikt
lin slow_A = mk3A "langsam" "langsamer" "langsamste" ; -- status=guess
lin troop_N = variants{} ; -- 
lin motion_N = mkN "Bewegung" ; -- status=guess
lin leading_A = variants{} ; -- 
lin component_N = mkN "Komponente" "Komponenten" feminine ; -- status=guess
lin bloody_A = mk3A "blutig" "blutiger" "blutigste" ; -- status=guess
lin literature_N = mkN "Literatur" "Literaturen" feminine ; -- status=guess
lin conservative_A = mk3A "konservativ" "konservativer" "konservativste" ; -- status=guess
lin variation_N = mkN "Variation" "Variationen" feminine ; -- status=guess
lin remind_V2 = mkV2 (irregV "erinnern" "erinnert" "erinnerte" "erinnerte" "erinnert") ; -- status=guess, src=wikt
lin inform_V2 = mkV2 (irregV "denunzieren" "denunziert" "denunzierte" "denunzierte" "denunziert") ; -- status=guess, src=wikt
lin inform_V = irregV "denunzieren" "denunziert" "denunzierte" "denunzierte" "denunziert" ; -- status=guess, src=wikt
lin alternative_N = mkN "Alternative" "Alternativen" feminine ; -- status=guess
lin neither_Adv = variants{} ; -- 
lin outside_Adv = mkAdv "außerhalb" | mkAdv "draußen" ; -- status=guess status=guess
lin mass_N = mkN "Massendefekt" masculine ; -- status=guess
lin busy_A = mkA "beschäftigt" ; -- status=guess
lin chemical_N = mkN "Chemikalie" "Chemikalien" feminine ; -- status=guess
lin careful_A = mk3A "vorsichtig" "vorsichtiger" "vorsichtigste" | mk3A "behutsam" "behutsamer" "behutsamste" ; -- status=guess status=guess
lin investigate_V2 = mkV2 (irregV "untersuchen" "untersucht" "untersuchte" "untersuchte" "untersucht") ; -- status=guess, src=wikt
lin investigate_V = irregV "untersuchen" "untersucht" "untersuchte" "untersuchte" "untersucht" ; -- status=guess, src=wikt
lin roll_V2 = mkV2 (irregV "laufen" "lauft" "lief" "liefe" "gelaufen") ; -- status=guess, src=wikt
lin roll_V = irregV "laufen" "lauft" "lief" "liefe" "gelaufen" ; -- status=guess, src=wikt
lin instrument_N = mkN "Dokument" "Dokumente" neuter | mkN "Urkunde" "Urkunden" feminine ; -- status=guess status=guess
lin guide_N = mkN "Reiseleiter" masculine | mkN "Reiseleiterin" feminine | mkN "Fremdenführer" masculine | mkN "Fremdenführerin" feminine ; -- status=guess status=guess status=guess status=guess
lin criterion_N = mkN "Kriterium" "Kriterien" neuter ; -- status=guess
lin pocket_N = mkN "Tasche" "Taschen" feminine ; -- status=guess
lin suggestion_N = mkN "Vorschlag" "Vorschläge" masculine ; -- status=guess
lin aye_Interj = mkInterj "jawohl" ; -- status=guess
lin entitle_VS = mkVS (mkV "berechtigen") ; -- status=guess, src=wikt
lin entitle_V2V = mkV2V (mkV "berechtigen") ; -- status=guess, src=wikt
lin tone_N = mkN "Tonarm" "Tonarme" masculine ; -- status=guess
lin attractive_A = mk3A "attraktiv" "attraktiver" "attraktivste" ; -- status=guess
lin wing_N = L.wing_N ;
lin surprise_N = mkN "Überraschungs- e. g. Überraschungsangriff" ; -- status=guess
lin male_N = mkN "Männchen" neuter ; -- status=guess
lin ring_N = mkN "Ring" "Ringe" masculine ; -- status=guess
lin pub_N = mkN "Kneipe" "Kneipen" feminine | mkN "Bar" "Bar" neuter | mkN "Lokal" "Lokale" neuter ; -- status=guess status=guess status=guess
lin fruit_N = L.fruit_N ;
lin passage_N = mkN "Passage" "Passagen" feminine ; -- status=guess
lin illustrate_VS = mkVS (regV "illustrieren") ; -- status=guess, src=wikt
lin illustrate_V2 = mkV2 (regV "illustrieren") ; -- status=guess, src=wikt
lin illustrate_V = regV "illustrieren" ; -- status=guess, src=wikt
lin pay_N = mkN "Pay-TV" neuter | mkN "Bezahlfernsehen" neuter ; -- status=guess status=guess
lin ride_V2 = mkV2 (irregV "fahren" "fahrt" "fuhr" "führe" "gefahren") ; -- status=guess, src=wikt
lin ride_V = irregV "fahren" "fahrt" "fuhr" "führe" "gefahren" ; -- status=guess, src=wikt
lin foundation_N = mkN "Gründung" feminine ; -- status=guess
lin restaurant_N = L.restaurant_N ;
lin vital_A = mkA "lebenswichtig" ; -- status=guess
lin alternative_A = mk3A "alternativ" "alternativer" "alternativste" ; -- status=guess
lin burn_V2 = mkV2 (irregV "brennen" "brennt" "brannte" "brennte" "gebrannt") ; -- status=guess, src=wikt
lin burn_V = L.burn_V ;
lin map_N = mkN "Stadtplan" "Stadtpläne" masculine ; -- status=guess
lin united_A = regA "vereint" ; -- status=guess
lin device_N = mkN "Motto" neuter | mkN "Emblem" neuter | devise_N ; -- status=guess status=guess status=guess
lin jump_V2 = mkV2 (irregV "springen" "springt" "sprang" "spränge" "gesprungen") ; -- status=guess, src=wikt
lin jump_V = L.jump_V ;
lin estimate_VS = mkVS (mkV "abschätzen") | mkVS (mkV "schätzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin estimate_V2V = mkV2V (mkV "abschätzen") | mkV2V (mkV "schätzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin estimate_V2 = mkV2 (mkV "abschätzen") | mkV2 (mkV "schätzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin estimate_V = mkV "abschätzen" | mkV "schätzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin conduct_V2 = mkV2 (irregV "leiten" "leitet" "leitete" "leite" "geleitet") ; -- status=guess, src=wikt
lin conduct_V = irregV "leiten" "leitet" "leitete" "leite" "geleitet" ; -- status=guess, src=wikt
lin derive_V2 = mkV2 (prefixV "ab" (regV "leiten")) ; -- status=guess, src=wikt
lin derive_V = prefixV "ab" (regV "leiten") ; -- status=guess, src=wikt
lin comment_VS = mkVS (prefixV "aus" (regV "kommentieren")) ; -- status=guess, src=wikt
lin comment_V2 = mkV2 (prefixV "aus" (regV "kommentieren")) ; -- status=guess, src=wikt
lin comment_V = prefixV "aus" (regV "kommentieren") ; -- status=guess, src=wikt
lin east_N = mkN "Osten" masculine | mkN "Ost" masculine ; -- status=guess status=guess
lin advise_VS = mkVS (irregV "raten" "rät" "riet" "riete" "geraten" | irregV "beraten" "berät" "beriet" "beriete" "beraten") ; -- status=guess, src=wikt status=guess, src=wikt
lin advise_V2 = mkV2 (irregV "raten" "rät" "riet" "riete" "geraten" | irregV "beraten" "berät" "beriet" "beriete" "beraten") ; -- status=guess, src=wikt status=guess, src=wikt
lin advise_V = irregV "raten" "rät" "riet" "riete" "geraten" | irregV "beraten" "berät" "beriet" "beriete" "beraten" ; -- status=guess, src=wikt status=guess, src=wikt
lin advance_N = mkN "Vorschuss" "Vorschüsse" masculine | mkN "Anzahlung" | mkN "Vorschuss" "Vorschüsse" masculine ; -- status=guess status=guess status=guess
lin motor_N = mkN "Motor" masculine | mkN "Triebwerk" "Triebwerke" neuter | mkN "Antrieb" "Antriebe" masculine ; -- status=guess status=guess status=guess
lin satisfy_V2 = mkV2 (regV "befriedigen" | prefixV "zufrieden" (irregV "stellen" "stellt" "stellte" "stellte" "gestellt")) ; -- status=guess, src=wikt status=guess, src=wikt
lin hell_N = mkN "Hölle" feminine ; -- status=guess
lin winner_N = mkN "Gewinner" "Gewinner" masculine | mkN "Gewinnerin" feminine | mkN "Sieger" "Sieger" masculine | mkN "Siegerin" "Siegerinnen" feminine ; -- status=guess status=guess status=guess status=guess
lin effectively_Adv = variants{} ; -- 
lin mistake_N = mkN "Fehler" "Fehler" masculine ; -- status=guess
lin incident_N = mkN "Vorfall" "Vorfälle" masculine | mkN "Störfall" masculine | mkN "Ereignis" "Ereignisse" neuter ; -- status=guess status=guess status=guess
lin focus_V2 = mkV2 (regV "fokussieren") ; -- status=guess, src=wikt
lin focus_V = regV "fokussieren" ; -- status=guess, src=wikt
lin exercise_VV = mkVV (mkV "üben") | mkVV (mkV "trainieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin exercise_V2 = mkV2 (mkV "üben") | mkV2 (mkV "trainieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin exercise_V = mkV "üben" | mkV "trainieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin representation_N = mkN "Repräsentation" feminine | mkN "Darstellung" ; -- status=guess status=guess
lin release_N = mkN "Veröffentlichung" feminine ; -- status=guess
lin leaf_N = L.leaf_N ;
lin border_N = mkN "Rand" "Ränder" masculine ; -- status=guess
lin wash_V2 = L.wash_V2 ;
lin wash_V = mkReflV "waschen" ; -- status=guess, src=wikt
lin prospect_N = variants{} ; -- 
lin blow_V2 = mkV2 (prefixV "ab" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen")) ; -- status=guess, src=wikt
lin blow_V = L.blow_V ;
lin trip_N = mkN "Reise" "Reisen" feminine ; -- status=guess
lin observation_N = mkN "Beobachtung" ; -- status=guess
lin gather_V2 = mkV2 (regV "sammeln" | irregV "versammeln" "versammelt" "versammelte" "versammelte" "versammelt") ; -- status=guess, src=wikt status=guess, src=wikt
lin gather_V = regV "sammeln" | irregV "versammeln" "versammelt" "versammelte" "versammelte" "versammelt" ; -- status=guess, src=wikt status=guess, src=wikt
lin ancient_A = regA "uralt" | regA "antik" ; -- status=guess status=guess
lin brief_A = mkA "prägnant" ; -- status=guess
lin gate_N = tor_N ; -- status=guess
lin elderly_A = mkA "älter" | mkA "ältlich" | mk3A "bejahrt" "bejahrter" "bejahrteste" ; -- status=guess status=guess status=guess
lin persuade_V2V = mkV2V (mkV "überreden" | irregV "gewinnen" "gewinnt" "gewann" "gewänne" "gewonnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin persuade_V2 = mkV2 (mkV "überreden" | irregV "gewinnen" "gewinnt" "gewann" "gewänne" "gewonnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin overall_A = variants{} ; -- 
lin rare_A = mk3A "blutig" "blutiger" "blutigste" ; -- status=guess
lin index_N = mkN "Index" masculine | mkN "Verzeichnis" "Verzeichnisse" neuter ; -- status=guess status=guess
lin hand_V2 = mkV2 (mkV "überliefern") ; -- status=guess, src=wikt
lin circle_N = mkN "Kreis" "Kreise" masculine ; -- status=guess
lin creation_N = mkN "Kreation" feminine | mkN "Schöpfung" feminine | mkN "Erstellung" feminine | mkN "Schaffung" feminine ; -- status=guess status=guess status=guess status=guess
lin drawing_N = mkN "Auslosung" feminine | mkN "Ziehung" ; -- status=guess status=guess
lin anybody_NP = variants{} ; -- 
lin flow_N = mkN "Tätigkeitsrausch" ; -- status=guess
lin matter_V = junkV (mkV "wichtig") "sein" | junkV (mkV "etwas") "ausmachen" ; -- status=guess, src=wikt status=guess, src=wikt
lin external_A = mkA "Außen-" | mk3A "extern" "externer" "externste" ; -- status=guess status=guess
lin capable_A = mkA "fähig" ; -- status=guess
lin recover_V = irregV "genesen" "genest" "genas" "genäse" "genesen" ; -- status=guess, src=wikt
lin shot_N = mkN "Wurf" "Würfe" masculine ; -- status=guess
lin request_N = mkN "Bitte" "Bitten" feminine | mkN "Nachfrage" "Nachfragen" feminine ; -- status=guess status=guess
lin impression_N = mkN "Eindruck" "Eindrücke" masculine ; -- status=guess
lin neighbour_N = mkN "Nachbar" masculine | mkN "Nachbarin" "Nachbarinnen" feminine ; -- status=guess status=guess
lin theatre_N = variants{} ; -- 
lin beneath_Prep = variants{} ; -- 
lin hurt_V2 = mkV2 (junkV (mkV "weh") "tun" | regV "schmerzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin hurt_V = junkV (mkV "weh") "tun" | regV "schmerzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin mechanism_N = mkN "Mechanismus" "Mechanismen" masculine ; -- status=guess
lin potential_N = mkN "Potential" "Potentiale" neuter ; -- status=guess
lin lean_V2 = mkV2 (regV "lehnen") ; -- status=guess, src=wikt
lin lean_V = regV "lehnen" ; -- status=guess, src=wikt
lin defendant_N = mkN "Angeklagter" masculine | mkN "Angeklagte" feminine ; -- status=guess status=guess
lin atmosphere_N = mkN "Atmosphäre" ; -- status=guess
lin slip_V2 = mkV2 (regV "irren" | mkReflV "irren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin slip_V = regV "irren" | mkReflV "irren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin chain_N = mkN "Kettenschutz" masculine ; -- status=guess
lin accompany_V2 = mkV2 (irregV "begleiten" "begleitet" "begleitete" "begleite" "begleitet") ; -- status=guess, src=wikt
lin wonderful_A = mk3A "wunderbar" "wunderbarer" "wunderbarste" | mk3A "wundervoll" "wundervoller" "wundervollste" ; -- status=guess status=guess
lin earn_V2 = mkV2 (irregV "verdienen" "verdient" "verdiente" "verdiente" "verdient") ; -- status=guess, src=wikt
lin earn_V = irregV "verdienen" "verdient" "verdiente" "verdiente" "verdient" ; -- status=guess, src=wikt
lin enemy_N = L.enemy_N ;
lin desk_N = mkN "Schreibtisch" "Schreibtische" masculine ; -- status=guess
lin engineering_N = mkN "Ingenieurwissenschaft" "Ingenieurwissenschaften" feminine | mkN "Ingenieurwesen" neuter ; -- status=guess status=guess
lin panel_N = mkN "Diskussionsrunde" feminine ; -- status=guess
lin distinction_N = mkN "Auszeichnung" ; -- status=guess
lin deputy_N = mkN "Deputierter" masculine | mkN "Deputierte" feminine | mkN "Abgeordneter" masculine | mkN "Abgeordnete" feminine ; -- status=guess status=guess status=guess status=guess
lin discipline_N = mkN "Disziplin" "Disziplinen" feminine ; -- status=guess
lin strike_N = variants{} ; -- 
lin strike_2_N = variants{} ; -- 
lin strike_1_N = variants{} ; -- 
lin married_A = regA "verheiratet" ; -- status=guess
lin plenty_NP = variants{} ; -- 
lin establishment_N = variants{} ; -- 
lin fashion_N = mode_N ; -- status=guess
lin roof_N = L.roof_N ;
lin milk_N = L.milk_N ;
lin entire_A = regA "ganz" ; -- status=guess
lin tear_N = mkN "Träne" feminine ; -- status=guess
lin secondary_A = mkA "sekundär" ; -- status=guess
lin finding_N = variants{} ; -- 
lin welfare_N = mkN "Sozialhilfe" feminine | mkN "Wohlfahrt" feminine ; -- status=guess status=guess
lin increased_A = variants{} ; -- 
lin attach_V2 = variants{} ; -- 
lin attach_V = variants{} ; -- 
lin typical_A = variants{} ; -- 
lin typical_3_A = variants{} ; -- 
lin typical_2_A = variants{} ; -- 
lin typical_1_A = variants{} ; -- 
lin meanwhile_Adv = mkAdv "unterdessen" ; -- status=guess
lin leadership_N = mkN "Führung" feminine | mkN "Leitung" ; -- status=guess status=guess
lin walk_N = mkN "Weg" "Wege" masculine ; -- status=guess
lin negotiation_N = mkN "Verhandlung" ; -- status=guess
lin clean_A = L.clean_A ;
lin religion_N = L.religion_N ;
lin count_V2 = L.count_V2 ;
lin count_V = mkV "jemanden" ; -- status=guess, src=wikt
lin grey_A = variants{} ; -- 
lin hence_Adv = mkAdv "daher" | mkAdv "deshalb" ; -- status=guess status=guess
lin alright_Adv = variants{} ; -- 
lin first_A = variants{} ; -- 
lin fuel_N = mkN "Brennstoff" "Brennstoffe" masculine | mkN "Treibstoff" "Treibstoffe" masculine ; -- status=guess status=guess
lin mine_N = mkN "Mine" "Minen" feminine ; -- status=guess
lin appeal_V2 = mkV2 (junkV (mkV "in") "Berufung gehen") ; -- status=guess, src=wikt
lin appeal_V = compoundV "in Berufung" I.gehen_V ;
lin servantMasc_N = mkN "Diener" "Diener" masculine ; -- status=guess status=guess
lin liability_N = mkN "Verantwortung" | mkN "Schuld" "Schulden" feminine | mkN "Verpflichtung" ; -- status=guess status=guess status=guess
lin constant_A = mkA "regelmäßig" | mkA "ständig" | regA "stetig" ; -- status=guess status=guess status=guess
lin hate_VV = mkVV (regV "hassen") ; -- status=guess, src=wikt
lin hate_V2 = L.hate_V2 ;
lin shoe_N = L.shoe_N ;
lin expense_N = mkN "Verlust" "Verluste" masculine ; -- status=guess
lin vast_A = mkA "beträchtlich" | mk3A "weit" "weiter" "weiteste" ; -- status=guess status=guess
lin soil_N = mkN "Boden" "Böden" masculine ; -- status=guess
lin writing_N = mkN "Schrift" "Schriften" feminine | mkN "Arbeit" "Arbeiten" feminine | mkN "Werk" "Werke" neuter ; -- status=guess status=guess status=guess
lin nose_N = L.nose_N ;
lin origin_N = mkN "Herkunft" "Herkünfte" feminine ; -- status=guess
lin lord_N = herr_N ; -- status=guess
lin rest_V2 = mkV2 (regV "ruhen") ; -- status=guess, src=wikt
lin drive_N = mkN "Fahrt" "Fahrten" feminine ; -- status=guess
lin ticket_N = mkN "Ticket" "Tickets" neuter | mkN "Karte" "Karten" feminine | mkN "Eintrittskarte" "Eintrittskarten" feminine | mkN "Schein" "Scheine" masculine ; -- status=guess status=guess status=guess status=guess
lin editor_N = mkN "Chefredakteur" "Chefredakteure" masculine ; -- status=guess
lin switch_V2 = mkV2 (irregV "schalten" "schaltet" "schaltete" "schaltete" "geschaltet") ; -- status=guess, src=wikt
lin switch_V = irregV "schalten" "schaltet" "schaltete" "schaltete" "geschaltet" ; -- status=guess, src=wikt
lin provided_Subj = variants{} ; -- 
lin northern_A = variants{} ; -- 
lin significance_N = mkN "Bedeutung" | mkN "Signifikanz" feminine ; -- status=guess status=guess
lin channel_N = mkN "Kanal" "Kanäle" masculine ; -- status=guess
lin convention_N = mkN "Abkommen" "Abkommen" neuter | mkN "Vereinbarung" ; -- status=guess status=guess
lin damage_V2 = mkV2 (mkV "beschädigen") ; -- status=guess, src=wikt
lin funny_A = mk3A "komisch" "komischer" "komischste" | mk3A "lustig" "lustiger" "lustigste" | mkA "spaßig" ; -- status=guess status=guess status=guess
lin bone_N = L.bone_N ;
lin severe_A = mk3A "streng" "strenger" "strengste" ; -- status=guess
lin search_V2 = mkV2 (regV "suchen") ; -- status=guess, src=wikt
lin search_V = regV "suchen" ; -- status=guess, src=wikt
lin iron_N = L.iron_N ;
lin vision_N = mkN "Vision" ; -- status=guess
lin via_Prep = variants{} ; -- 
lin somewhat_Adv = mkAdv "etwas" | mkAdv "einigermaßen" ; -- status=guess status=guess
lin inside_Adv = mkAdv "nach rechts" | herein_Adv | mkAdv "drinnen" | mkAdv "innerhalb" | mkAdv "im innern" | mkAdv "im inneren" | mkAdv "innerhalb" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin trend_N = mkN "Trend" "Trends" masculine ; -- status=guess
lin revolution_N = mkN "Revolution" ; -- status=guess
lin terrible_A = mk3A "schrecklich" "schrecklicher" "schrecklichste" ; -- status=guess
lin knee_N = L.knee_N ;
lin dress_N = mkN "Kleidung" ; -- status=guess
lin unfortunately_Adv = mkAdv "leider" | mkAdv "unglücklicherweise" ; -- status=guess status=guess
lin steal_V2 = mkV2 (irregV "stehlen" "stehlt" "stahl" "stähle" "gestohlen" | regV "rauben") ; -- status=guess, src=wikt status=guess, src=wikt
lin steal_V = irregV "stehlen" "stehlt" "stahl" "stähle" "gestohlen" | regV "rauben" ; -- status=guess, src=wikt status=guess, src=wikt
lin criminal_A = mk3A "kriminell" "krimineller" "kriminellste" ; -- status=guess
lin signal_N = mkN "Signal" "Signale" neuter ; -- status=guess
lin notion_N = mkN "Neigung" | mkN "Absicht" "Absichten" feminine | lust_N ; -- status=guess status=guess status=guess
lin comparison_N = mkN "Vergleich" "Vergleiche" masculine | mkN "Komparation" ; -- status=guess status=guess
lin academic_A = mkA "akademisch" ; -- status=guess
lin outcome_N = mkN "Ergebnis" "Ergebnisse" neuter | mkN "Ausgang" "Ausgänge" masculine ; -- status=guess status=guess
lin lawyer_N = mkN "Rechtsanwalt" "Rechtsanwälte" masculine ; -- status=guess
lin strongly_Adv = variants{} ; -- 
lin surround_V2 = mkV2 (irregV "umgeben" "umgebt" "umgab" "umgäbe" "umgeben" | mkV "umringen") ; -- status=guess, src=wikt status=guess, src=wikt
lin explore_VS = mkVS (mkV "erforschen") ; -- status=guess, src=wikt
lin explore_V2 = mkV2 (mkV "erforschen") ; -- status=guess, src=wikt
lin achievement_N = mkN "Errungenschaft" feminine | mkN "Vollendung" feminine ; -- status=guess status=guess
lin odd_A = regA "ungerade" ; -- status=guess
lin expectation_N = mkN "Erwartung" ; -- status=guess
lin corporate_A = variants{} ; -- 
lin prisoner_N = mkN "Gefangener" masculine | mkN "Gefangene" feminine ; -- status=guess status=guess
lin question_V2 = mkV2 (regV "fragen" | irregV "hinterfragen" "hinterfragt" "hinterfragte" "hinterfragte" "hinterfragt" | regV "befragen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rapidly_Adv = mkAdv "schnell" ; -- status=guess
lin deep_Adv = variants{} ; -- 
lin southern_A = mkA "südlich" | mkA "südländisch" ; -- status=guess status=guess
lin amongst_Prep = variants{} ; -- 
lin withdraw_V2 = mkV2 (prefixV "ab" (irregV "heben" "hebt" "hob" "höbe" "gehoben")) ; -- status=guess, src=wikt
lin withdraw_V = prefixV "ab" (irregV "heben" "hebt" "hob" "höbe" "gehoben") ; -- status=guess, src=wikt
lin afterwards_Adv = mkAdv "später" | mkAdv "nachher" | mkAdv "danach" | mkAdv "hinterher" ; -- status=guess status=guess status=guess status=guess
lin paint_V2 = mkV2 (irregV "streichen" "streicht" "strich" "striche" "gestrichen") ; -- status=guess, src=wikt
lin paint_V = irregV "streichen" "streicht" "strich" "striche" "gestrichen" ; -- status=guess, src=wikt
lin judge_VS = mkVS (junkV (mkV "Schiedsrichter") "sein") ; -- status=guess, src=wikt
lin judge_V2 = mkV2 (junkV (mkV "Schiedsrichter") "sein") ; -- status=guess, src=wikt
lin judge_V = junkV (mkV "Schiedsrichter") "sein" ; -- status=guess, src=wikt
lin citizenMasc_N = reg2N "Bürger" "Bürger" masculine;
lin permanent_A = mkA "ständig" | regA "permanent" ; -- status=guess status=guess
lin weak_A = mk3A "schwach" "schwächer" "schwächste" ; -- status=guess
lin separate_V2 = mkV2 (regV "separieren" | irregV "unterscheiden" "unterscheidet" "unterschied" "unterschiede" "unterschieden") ; -- status=guess, src=wikt status=guess, src=wikt
lin separate_V = regV "separieren" | irregV "unterscheiden" "unterscheidet" "unterschied" "unterschiede" "unterschieden" ; -- status=guess, src=wikt status=guess, src=wikt
lin plastic_N = L.plastic_N ;
lin connect_V2 = mkV2 (mkV "anschließen" | irregV "verbinden" "verbindet" "verband" "verbände" "verbunden") ; -- status=guess, src=wikt status=guess, src=wikt
lin connect_V = mkV "anschließen" | irregV "verbinden" "verbindet" "verband" "verbände" "verbunden" ; -- status=guess, src=wikt status=guess, src=wikt
lin fundamental_A = mk3A "grundlegend" "grundlegender" "grundlegendste" | mk3A "fundamental" "fundamentaler" "fundamentalste" ; -- status=guess status=guess
lin plane_N = mkN "Hobel" "Hobel" masculine ; -- status=guess
lin height_N = mkN "Höhe" feminine ; -- status=guess
lin opening_N = mkN "Eröffnung" feminine ; -- status=guess
lin lesson_N = mkN "Lehrstunde" feminine | mkN "Stunde" "Stunden" feminine | mkN "Lektion" | mkN "Unterricht" masculine ; -- status=guess status=guess status=guess status=guess
lin similarly_Adv = mkAdv "ähnlich" ; -- status=guess
lin shock_N = mkN "Stoßdämpfer" masculine ; -- status=guess
lin rail_N = mkN "Geländer" neuter | mkN "Reling" feminine ; -- status=guess status=guess
lin tenant_N = mkN "Eigentümer" masculine | mkN "Besitzer" "Besitzer" masculine ; -- status=guess status=guess
lin owe_V2 = mkV2 (mkV "schulden") | mkV2 (junkV (mkV "schuldig") "sein") ; -- status=guess, src=wikt status=guess, src=wikt
lin owe_V = mkV "schulden" | junkV (mkV "schuldig") "sein" ; -- status=guess, src=wikt status=guess, src=wikt
lin originally_Adv = variants{} ; -- 
lin middle_A = mkA "Mittel-" | mkA "mittlere" ; -- status=guess status=guess
lin somehow_Adv = mkAdv "irgendwie" ; -- status=guess
lin minor_A = mkA "moll" ; -- status=guess
lin negative_A = mk3A "schlecht" "schlechter" "schlechteste" | mk3A "negativ" "negativer" "negativste" ; -- status=guess status=guess
lin knock_V2 = mkV2 (prefixV "um" (irregV "werfen" "wirft" "warf" "warf" "geworfen")) ; -- status=guess, src=wikt
lin knock_V = prefixV "um" (irregV "werfen" "wirft" "warf" "warf" "geworfen") ; -- status=guess, src=wikt
lin root_N = L.root_N ;
lin pursue_V2 = mkV2 (irregV "verfolgen" "verfolgt" "verfolgte" "verfolgte" "verfolgt") ; -- status=guess, src=wikt
lin pursue_V = irregV "verfolgen" "verfolgt" "verfolgte" "verfolgte" "verfolgt" ; -- status=guess, src=wikt
lin inner_A = regA "inner" ; -- status=guess
lin crucial_A = mkA "kreuzförmig" ; -- status=guess
lin occupy_V2 = mkV2 (regV "besetzen") ; -- status=guess, src=wikt
lin occupy_V = regV "besetzen" ; -- status=guess, src=wikt
lin that_AdA = variants{} ; -- 
lin independence_N = mkN "Unabhängigkeit" feminine ; -- status=guess
lin column_N = mkN "Kolonne" "Kolonnen" feminine ; -- status=guess
lin proceeding_N = variants{} ; -- 
lin female_N = mkN "Weib" neuter | mkN "Weibchen" "Weibchen" neuter ; -- status=guess status=guess
lin beauty_N = mkN "Schönheit" feminine | mkN "Schöne" feminine ; -- status=guess status=guess
lin perfectly_Adv = variants{} ; -- 
lin struggle_N = mkN "Kampf" "Kämpfe" masculine ; -- status=guess
lin gap_N = mkN "Spalt" "Spalten" feminine ; -- status=guess
lin house_V2 = mkV2 (mkV "unterbringen" | regV "beherbergen") ; -- status=guess, src=wikt status=guess, src=wikt
lin database_N = mkN "Datenbankadministrator" masculine ; -- status=guess
lin stretch_V2 = mkV2 (regV "strecken") ; -- status=guess, src=wikt
lin stretch_V = regV "strecken" ; -- status=guess, src=wikt
lin stress_N = mkN "Stress" "Stresse" masculine ; -- status=guess
lin passenger_N = mkN "Passagier" "Passagiere" masculine | mkN "Fahrgast" "Fahrgäste" masculine ; -- status=guess status=guess
lin boundary_N = mkN "Grenze" "Grenzen" feminine ; -- status=guess
lin easy_Adv = variants{} ; -- 
lin view_V2 = mkV2 (irregV "sehen" "seht" "sah" "sähe" "gesehen" | prefixV "an" (regV "schauen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin manufacturer_N = mkN "Hersteller" "Hersteller" masculine ; -- status=guess
lin sharp_A = L.sharp_A ;
lin formation_N = variants{} ; -- 
lin queen_N = L.queen_N ;
lin waste_N = mkN "Verfall" masculine ; -- status=guess
lin virtually_Adv = mkAdv "praktisch" ; -- status=guess
lin expand_V2 = variants{} ; -- 
lin expand_V = variants{} ; -- 
lin contemporary_A = mkA "zeitgenössisch" ; -- status=guess
lin politician_N = mkN "Politiker" "Politiker" masculine | mkN "Politikerin" "Politikerinnen" feminine ; -- status=guess status=guess
lin back_V = mkV "zurücksetzen" ; -- status=guess, src=wikt
lin territory_N = mkN "Territorium" "Territorien" neuter ; -- status=guess
lin championship_N = mkN "Meisterschaft" "Meisterschaften" feminine ; -- status=guess
lin exception_N = mkN "Ausnahme" "Ausnahmen" feminine ; -- status=guess
lin thick_A = L.thick_A ;
lin inquiry_N = mkN "Anfrage" "Anfragen" feminine | mkN "Erkundigung" feminine ; -- status=guess status=guess
lin topic_N = mkN "Thema-Rhema-Progression " "Thema-Rhema-Progressionen" feminine ; -- status=guess
lin resident_N = mkN "Assistentarzt" masculine ; -- status=guess
lin transaction_N = mkN "Transaktion" ; -- status=guess
lin parish_N = mkN "Gemeinde" "Gemeinden" feminine ; -- status=guess
lin supporter_N = mkN "Unterstützer" masculine | mkN "Anhänger" masculine ; -- status=guess status=guess
lin massive_A = mk3A "massiv" "massiver" "massivste" ; -- status=guess
lin light_V2 = mkV2 (irregV "beleuchten" "beleuchtet" "beleuchtete" "beleuchtete" "beleuchtet" | mkV "anstrahlen") ; -- status=guess, src=wikt status=guess, src=wikt
lin light_V = irregV "beleuchten" "beleuchtet" "beleuchtete" "beleuchtete" "beleuchtet" | mkV "anstrahlen" ; -- status=guess, src=wikt status=guess, src=wikt
lin unique_A = regA "einzigartig" | mkA "unikal" ; -- status=guess status=guess
lin challenge_V2 = mkV2 (mkV "herausfordern") ; -- status=guess, src=wikt
lin challenge_V = mkV "herausfordern" ; -- status=guess, src=wikt
lin inflation_N = mkN "Aufblasen" neuter | mkN "Aufblähung" feminine | mkN "Inflation" ; -- status=guess status=guess status=guess
lin assistance_N = mkN "Hilfe" "Hilfen" feminine ; -- status=guess
lin list_V2V = mkV2V (mkV "aufzählen") ; -- status=guess, src=wikt
lin list_V2 = mkV2 (mkV "aufzählen") ; -- status=guess, src=wikt
lin list_V = mkV "aufzählen" ; -- status=guess, src=wikt
lin identity_N = mkN "Identität" feminine ; -- status=guess
lin suit_V2 = mkV2 (regV "passen") ; -- status=guess, src=wikt
lin suit_V = regV "passen" ; -- status=guess, src=wikt
lin parliamentary_A = mkA "parlamentarisch" ; -- status=guess
lin unknown_A = mk3A "unbekannt" "unbekannter" "unbekannteste" ; -- status=guess
lin preparation_N = mkN "Vorbereitung" ; -- status=guess
lin elect_V3 = mkV3 (mkV "wählen") ; -- status=guess, src=wikt
lin elect_V2V = mkV2V (mkV "wählen") ; -- status=guess, src=wikt
lin elect_V2 = mkV2 (mkV "wählen") ; -- status=guess, src=wikt
lin elect_V = mkV "wählen" ; -- status=guess, src=wikt
lin badly_Adv = variants{} ; -- 
lin moreover_Adv = mkAdv "außerdem" | mkAdv "überdies" ; -- status=guess status=guess
lin tie_V2 = L.tie_V2 ;
lin tie_V = irregV "binden" "bindet" "band" "bände" "gebunden" ; -- status=guess, src=wikt
lin cancer_N = mkN "Krebs" "Krebse" masculine ; -- status=guess
lin champion_N = mkN "Sieger" "Sieger" masculine | mkN "Gewinner" "Gewinner" masculine | mkN "Meister" "Meister" masculine ; -- status=guess status=guess status=guess
lin exclude_V2 = variants{} ; -- 
lin review_V2 = variants{} ; -- 
lin review_V = variants{} ; -- 
lin licence_N = variants{} ; -- 
lin breakfast_N = mkN "Frühstück" neuter | mkN "Zmorge" feminine | mkN "Morgenessen" neuter ; -- status=guess status=guess status=guess
lin minority_N = mkN "Minderheitsregierung" ; -- status=guess
lin appreciate_V2 = mkV2 (irregV "verstehen" "versteht" "verstand" "verstände" "verstanden") ; -- status=guess, src=wikt
lin appreciate_V = irregV "verstehen" "versteht" "verstand" "verstände" "verstanden" ; -- status=guess, src=wikt
lin fan_N = variants{} ; -- 
lin fan_3_N = variants{} ; -- 
lin fan_2_N = variants{} ; -- 
lin fan_1_N = variants{} ; -- 
lin chief_N = chef_N | boss_N ; -- status=guess status=guess
lin accommodation_N = mkN "Unterkunft" "Unterkünfte" feminine ; -- status=guess
lin subsequent_A = regA "folgend" ; -- status=guess
lin democracy_N = mkN "Demokratie" "Demokratien" feminine ; -- status=guess
lin brown_A = L.brown_A ;
lin taste_N = mkN "Geschmack" masculine ; -- status=guess
lin crown_N = mkN "Krone" "Kronen" feminine ; -- status=guess
lin permit_V2V = mkV2V (irregV "erlauben" "erlaubt" "erlaubte" "erlaubte" "erlaubt" | irregV "genehmigen" "genehmigt" "genehmigte" "genehmigte" "genehmigt" | prefixV "zu" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin permit_V2 = mkV2 (irregV "erlauben" "erlaubt" "erlaubte" "erlaubte" "erlaubt" | irregV "genehmigen" "genehmigt" "genehmigte" "genehmigte" "genehmigt" | prefixV "zu" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin permit_V = irregV "erlauben" "erlaubt" "erlaubte" "erlaubte" "erlaubt" | irregV "genehmigen" "genehmigt" "genehmigte" "genehmigte" "genehmigt" | prefixV "zu" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin buyerMasc_N = reg2N "Käufer" "Käufer" masculine;
lin gift_N = mkN "Begabung" | mkN "Talent" "Talente" neuter ; -- status=guess status=guess
lin resolution_N = mkN "Auflösung" feminine ; -- status=guess
lin angry_A = mkA "böse" | mkA "verärgert" | mk3A "zornig" "zorniger" "zornigste" ; -- status=guess status=guess status=guess
lin metre_N = mkN "Meter" masculine ; -- status=guess
lin wheel_N = rad_N ; -- status=guess
lin clause_N = mkN "Nebensatz" "Nebensätze" masculine ; -- status=guess
lin break_N = mkN "Break" neuter ; -- status=guess
lin tank_N = mkN "Tank" masculine | mkN "Behälter" masculine ; -- status=guess status=guess
lin benefit_V2 = mkV2 (junkV (mkV "von") "Vorteil sein" | irregV "profitieren" "profitiert" "profitierte" "profitierte" "profitiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin benefit_V = junkV (mkV "von") "Vorteil sein" | irregV "profitieren" "profitiert" "profitierte" "profitierte" "profitiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin engage_V2 = variants{} ; -- 
lin engage_V = variants{} ; -- 
lin alive_A = mk3A "lebendig" "lebendiger" "lebendigste" ; -- status=guess
lin complaint_N = mkN "Beschwerde" "Beschwerden" feminine | mkN "Leiden" "Leiden" neuter | mkN "Krankheit" "Krankheiten" feminine ; -- status=guess status=guess status=guess
lin inch_N = mkN "Zoll" "Zölle" masculine ; -- status=guess
lin firm_A = mk3A "fest" "fester" "festeste" ; -- status=guess
lin abandon_V2 = mkV2 (prefixV "auf" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") | irregV "verlassen" "verlasst" "verließ" "verließe" "verlassen") ; -- status=guess, src=wikt status=guess, src=wikt
lin blame_V2 = mkV2 (mkV "beschuldigen") | mkV2 (junkV (mkV "verantwortlich") "machen") ; -- status=guess, src=wikt status=guess, src=wikt
lin blame_V = mkV "beschuldigen" | junkV (mkV "verantwortlich") "machen" ; -- status=guess, src=wikt status=guess, src=wikt
lin clean_V2 = mkV2 (irregV "reinigen" "reinigt" "reinigte" "reinigte" "reinigt" | mkV "säubern" | regV "putzen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin clean_V = irregV "reinigen" "reinigt" "reinigte" "reinigte" "reinigt" | mkV "säubern" | regV "putzen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin quote_V2 = mkV2 (junkV (mkV "Preisangebot") "machen") ; -- status=guess, src=wikt
lin quote_V = junkV (mkV "Preisangebot") "machen" ; -- status=guess, src=wikt
lin quantity_N = mkN "Quantität" feminine | mkN "Menge" "Mengen" feminine ; -- status=guess status=guess
lin rule_VS = mkVS (irregV "regieren" "regiert" "regierte" "regierte" "regiert" | regV "beherrschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin rule_V2 = mkV2 (irregV "regieren" "regiert" "regierte" "regierte" "regiert" | regV "beherrschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin rule_V = irregV "regieren" "regiert" "regierte" "regierte" "regiert" | regV "beherrschen" ; -- status=guess, src=wikt status=guess, src=wikt
lin guilty_A = mk3A "schuldig" "schuldiger" "schuldigste" | mkA "tadelnswert" | mkA "tadelnswürdig" ; -- status=guess status=guess status=guess
lin prior_A = variants{} ; -- 
lin round_A = L.round_A ;
lin eastern_A = mkA "östlich" ; -- status=guess
lin coat_N = L.coat_N ;
lin involvement_N = variants{} ; -- 
lin tension_N = mkN "Spannung" ; -- status=guess
lin diet_N = mkN "Diät" feminine ; -- status=guess
lin enormous_A = variants{} ; -- 
lin score_N = mkN "Partitur" feminine ; -- status=guess
lin rarely_Adv = mkAdv "selten" ; -- status=guess
lin prize_N = mkN "Preis" "Preise" masculine ; -- status=guess
lin remaining_A = variants{} ; -- 
lin significantly_Adv = mkAdv "wesentlich" | mkAdv "beträchtlich" ; -- status=guess status=guess
lin glance_V2 = mkV2 (regV "blicken") ; -- status=guess, src=wikt
lin glance_V = regV "blicken" ; -- status=guess, src=wikt
lin dominate_V2 = variants{} ; -- 
lin dominate_V = variants{} ; -- 
lin trust_VS = mkVS (irregV "vertrauen" "vertraut" "vertraute" "vertraute" "vertraut") ; -- status=guess, src=wikt
lin trust_V2 = mkV2 (irregV "vertrauen" "vertraut" "vertraute" "vertraute" "vertraut") ; -- status=guess, src=wikt
lin naturally_Adv = mkAdv "natürlich" ; -- status=guess
lin interpret_V2 = mkV2 (regV "dolmetschen" | mkV "übersetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin interpret_V = regV "dolmetschen" | mkV "übersetzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin land_V2 = mkV2 (regV "landen") ; -- status=guess, src=wikt
lin land_V = regV "landen" ; -- status=guess, src=wikt
lin frame_N = mkN "Frame" masculine | mkN "Rahmen" "Rahmen" masculine ; -- status=guess status=guess
lin extension_N = mkN "Ausdehnung" | mkN "Erweiterung" ; -- status=guess status=guess
lin mix_V2 = mkV2 (regV "mischen" | mkV "abmischen" | regV "mixen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin mix_V = regV "mischen" | mkV "abmischen" | regV "mixen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin spokesman_N = variants{} ; -- 
lin friendly_A = mk3A "freundlich" "freundlicher" "freundlichste" ; -- status=guess
lin acknowledge_VS = mkVS (prefixV "an" (irregV "erkennen" "erkennt" "erkannte" "erkannte" "erkannt")) ; -- status=guess, src=wikt
lin acknowledge_V2 = mkV2 (prefixV "an" (irregV "erkennen" "erkennt" "erkannte" "erkannte" "erkannt")) ; -- status=guess, src=wikt
lin register_V2 = mkV2 (irregV "registrieren" "registriert" "registrierte" "registrierte" "registriert") ; -- status=guess, src=wikt
lin register_V = irregV "registrieren" "registriert" "registrierte" "registrierte" "registriert" ; -- status=guess, src=wikt
lin regime_N = variants{} ; -- 
lin regime_2_N = variants{} ; -- 
lin regime_1_N = variants{} ; -- 
lin fault_N = mkN "Fehler" "Fehler" masculine ; -- status=guess
lin dispute_N = mkN "Streit" "Streite" masculine | mkN "Disput" "Dispute" masculine ; -- status=guess status=guess
lin grass_N = L.grass_N ;
lin quietly_Adv = mkAdv "ruhig" | mkAdv "leise" ; -- status=guess status=guess
lin decline_N = mkN "Sinken" neuter | mkN "Fall" "Fälle" masculine ; -- status=guess status=guess
lin dismiss_V2 = mkV2 (irregV "entlassen" "entlasst" "entließ" "entließe" "entlassen") ; -- status=guess, src=wikt
lin delivery_N = mkN "Lieferung" ; -- status=guess
lin complain_VS = mkVS (mkReflV "beschweren" | regV "klagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin complain_V = mkReflV "beschweren" | regV "klagen" ; -- status=guess, src=wikt status=guess, src=wikt
lin conservative_N = mkN "Konservativer" masculine ; -- status=guess
lin shift_V2 = mkV2 (mkV "umschalten") ; -- status=guess, src=wikt
lin shift_V = mkV "umschalten" ; -- status=guess, src=wikt
lin port_N = mkN "Port" masculine ; -- status=guess
lin beach_N = mkN "Strand" "Strände" masculine ; -- status=guess
lin string_N = mkN "Zeichenkette" "Zeichenketten" feminine | mkN "String" "Strings" masculine ; -- status=guess status=guess
lin depth_N = mkN "Tiefe" "Tiefen" feminine ; -- status=guess
lin unusual_A = mkA "ungewöhnlich" ; -- status=guess
lin travel_N = mkN "Reise" "Reisen" feminine ; -- status=guess
lin pilot_N = mkN "Pilot" "Piloten" masculine | mkN "Flugzeugführer" masculine ; -- status=guess status=guess
lin obligation_N = mkN "Verpflichtung" | mkN "Pflicht" "Pflichten" feminine ; -- status=guess status=guess
lin gene_N = gen_N ; -- status=guess
lin yellow_A = L.yellow_A ;
lin republic_N = mkN "Republik" "Republiken" feminine ; -- status=guess
lin shadow_N = mkN "Schatten" "Schatten" masculine ; -- status=guess
lin dear_A = mkA "Sehr Geehrter" ; -- status=guess
lin analyse_V2 = variants{} ; -- 
lin anywhere_Adv = mkAdv "überall" | mkAdv "irgendwo" ; -- status=guess status=guess
lin average_N = mkN "Durchschnitt" "Durchschnitte" masculine | mkN "arithmetisches Mittel" neuter ; -- status=guess status=guess
lin phrase_N = mkN "Sprachführer" masculine ; -- status=guess
lin long_term_A = variants{} ; -- 
lin crew_N = mkN "Haufen" "Haufen" masculine ; -- status=guess
lin lucky_A = mkA "glücklich" ; -- status=guess
lin restore_V2 = mkV2 (mkV "wiederherstellen") | mkV2 (mkV "restaurieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin convince_V2V = mkV2V (mkV "überzeugen") ; -- status=guess, src=wikt
lin convince_V2 = mkV2 (mkV "überzeugen") ; -- status=guess, src=wikt
lin coast_N = mkN "Küste" | mkN "Küstenland" | mkN "Strand" "Strände" masculine | mkN "Ufer-Wolfstrapp" "Ufer-Wolfstrappe" masculine ; -- status=guess status=guess status=guess status=guess
lin engineer_N = mkN "Maschinist" masculine | mkN "Maschinistin" feminine ; -- status=guess status=guess
lin heavily_Adv = variants{} ; -- 
lin extensive_A = mk3A "umfangreich" "umfangreicher" "umfangreichste" ; -- status=guess
lin glad_A = mk3A "froh" "froher" "frohsten, froheste" | mkA "fröhlich" ; -- status=guess status=guess
lin charity_N = mkN "Nächstenliebe" feminine ; -- status=guess
lin oppose_V2 = mkV2 (prefixV "ab" (regV "lehnen")) ; -- status=guess, src=wikt
lin oppose_V = prefixV "ab" (regV "lehnen") ; -- status=guess, src=wikt
lin defend_V2 = mkV2 (irregV "verteidigen" "verteidigt" "verteidigte" "verteidige" "verteidigt") ; -- status=guess, src=wikt
lin alter_V2 = mkV2 (mkV "abändern") ; -- status=guess, src=wikt
lin alter_V = mkV "abändern" ; -- status=guess, src=wikt
lin warning_N = mkN "Warnung" ; -- status=guess
lin arrest_V2 = mkV2 (mkV "arretieren") ; -- status=guess, src=wikt
lin framework_N = mkN "Bezugssystem" neuter | mkN "Gefüge" neuter | mkN "Programmiergerüst" neuter | mkN "Rahmenkonzept" neuter | mkN "Rahmenwerk" neuter ; -- status=guess status=guess status=guess status=guess status=guess
lin approval_N = mkN "Zustimmung" ; -- status=guess
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
lin possess_V2 = mkV2 (irregV "besitzen" "besitzt" "besaß" "besäße" "besessen") ; -- status=guess, src=wikt
lin moral_A = mk3A "moralisch" "moralischer" "moralischste" ; -- status=guess
lin protein_N = mkN "Protein" "Proteine" neuter ; -- status=guess
lin distinguish_V2 = mkV2 (mkReflV "auszeichnen") ; -- status=guess, src=wikt
lin distinguish_V = mkReflV "auszeichnen" ; -- status=guess, src=wikt
lin gently_Adv = variants{} ; -- 
lin reckon_VS = mkVS (mkV "schätzen" | irregV "vermuten" "vermutet" "vermutete" "vermutete" "vermutet" | mkV "mutmaßen" | irregV "rechnen" "rechnet" "rechnte" "rechnte" "rechnt") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin incorporate_V2 = mkV2 (mkV "gründen" | prefixV "ein" (regV "verleiben")) ; -- status=guess, src=wikt status=guess, src=wikt
lin proceed_V = prefixV "vor" (irregV "gehen" "geht" "ging" "ginge" "gegangen") ; -- status=guess, src=wikt
lin assist_V2 = mkV2 (mkV "assistieren" | irregV "helfen" "helft" "half" "hälfe" "geholfen" | prefixV "bei" (irregV "stehen" "steht" "stand" "stände" "gestanden") | mkV "unterstützen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin assist_V = mkV "assistieren" | irregV "helfen" "helft" "half" "hälfe" "geholfen" | prefixV "bei" (irregV "stehen" "steht" "stand" "stände" "gestanden") | mkV "unterstützen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sure_Adv = variants{} ; -- 
lin stress_VS = mkVS (mkV "stressen") ; -- status=guess, src=wikt
lin stress_V2 = mkV2 (mkV "stressen") ; -- status=guess, src=wikt
lin justify_VV = mkVV (prefixV "aus" (irregV "richten" "richtet" "richtete" "richtete" "gerichtet") | regV "justieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin justify_V2 = mkV2 (prefixV "aus" (irregV "richten" "richtet" "richtete" "richtete" "gerichtet") | regV "justieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin behalf_N = variants{} ; -- 
lin councillor_N = variants{} ; -- 
lin setting_N = mkN "Einstellung" ; -- status=guess
lin command_N = variants{} ; -- 
lin command_2_N = variants{} ; -- 
lin command_1_N = variants{} ; -- 
lin maintenance_N = mkN "Instandhaltung" feminine | mkN "Wartung" ; -- status=guess status=guess
lin stair_N = mkN "Treppe" "Treppen" feminine ; -- status=guess
lin poem_N = mkN "Gedicht" "Gedichte" neuter ; -- status=guess
lin chest_N = mkN "Kommode" feminine ; -- status=guess
lin like_Adv = mkAdv "wie" ; -- status=guess
lin secret_N = mkN "Geheimnis" "Geheimnisse" neuter ; -- status=guess
lin restriction_N = mkN "Beschränkung" feminine | mkN "Verbot" "Verbote" neuter ; -- status=guess status=guess
lin efficient_A = mk3A "effizient" "effizienter" "effizienteste" ; -- status=guess
lin suspect_VS = mkVS (mkV "verdächtigen") ; -- status=guess, src=wikt
lin suspect_V2 = mkV2 (mkV "verdächtigen") ; -- status=guess, src=wikt
lin hat_N = L.hat_N ;
lin tough_A = mkA "zäh" ; -- status=guess
lin firmly_Adv = mkAdv "sicher" | mkAdv "fest" ; -- status=guess status=guess
lin willing_A = mkA "willens" | regA "gewillt" | mk3A "willig" "williger" "willigste" ; -- status=guess status=guess status=guess
lin healthy_A = mk3A "gesund" "gesünder" "gesündeste" ; -- status=guess
lin focus_N = mkN "Konzentration" ; -- status=guess
lin construct_V2 = mkV2 (regV "bauen" | irregV "konstruieren" "konstruiert" "konstruierte" "konstruierte" "konstruiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin occasionally_Adv = mkAdv "gelegentlich" ; -- status=guess
lin mode_N = modus_vivendi_N ; -- status=guess
lin saving_N = variants{} ; -- 
lin comfortable_A = mkA "gemütlich" ; -- status=guess
lin camp_N = mkN "Lager" neuter ; -- status=guess
lin trade_V2 = mkV2 (junkV (mkV "in") "Zahlung geben") ; -- status=guess, src=wikt
lin trade_V = junkV (mkV "in") "Zahlung geben" ; -- status=guess, src=wikt
lin export_N = mkN "Exportgut" neuter | mkN "Exportware" feminine ; -- status=guess status=guess
lin wake_V2 = mkV2 (prefixV "auf" (regV "wecken") | regV "wecken") ; -- status=guess, src=wikt status=guess, src=wikt
lin wake_V = prefixV "auf" (regV "wecken") | regV "wecken" ; -- status=guess, src=wikt status=guess, src=wikt
lin partnership_N = mkN "Partnerschaft" "Partnerschaften" feminine ; -- status=guess
lin daily_A = mkA "täglich" ; -- status=guess
lin abroad_Adv = mkAdv "im Ausland" ; -- status=guess
lin profession_N = mkN "Beruf" "Berufe" masculine ; -- status=guess
lin load_N = mkN "Ein-Euro-Job" "Ein-Euro-Jobs" masculine ; -- status=guess
lin countryside_N = mkN "Land" neuter ; -- status=guess
lin boot_N = L.boot_N ;
lin mostly_Adv = mkAdv "meistens" ; -- status=guess
lin sudden_A = mkA "plötzlich" | mkA "jäh" ; -- status=guess status=guess
lin implement_V2 = mkV2 (irregV "vollziehen" "vollzieht" "vollzog" "vollzöge" "vollzogen" | mkV "durchführen" | mkV "erfüllen" | irregV "implementieren" "implementiert" "implementierte" "implementierte" "implementiert" | mkV "ausführen" | prefixV "um" (regV "setzen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reputation_N = mkN "Ansehen" "Ansehen" neuter | mkN "Ruf" "Rufe" masculine ; -- status=guess status=guess
lin print_V2 = mkV2 (regV "drucken") ; -- status=guess, src=wikt
lin print_V = regV "drucken" ; -- status=guess, src=wikt
lin calculate_VS = mkVS (irregV "rechnen" "rechnet" "rechnte" "rechnte" "rechnt") ; -- status=guess, src=wikt
lin calculate_V2 = mkV2 (irregV "rechnen" "rechnet" "rechnte" "rechnte" "rechnt") ; -- status=guess, src=wikt
lin calculate_V = irregV "rechnen" "rechnet" "rechnte" "rechnte" "rechnt" ; -- status=guess, src=wikt
lin keen_A = mkA "begeistert" | mk3A "eifrig" "eifriger" "eifrigste" | mk3A "heftig" "heftiger" "heftigste" | mkA "kühn" | mk3A "scharf" "schärfer" "schärfste" ; -- status=guess status=guess status=guess status=guess status=guess
lin guess_VS = mkVS (mkV "schätzen" | irregV "raten" "rät" "riet" "riete" "geraten") ; -- status=guess, src=wikt status=guess, src=wikt
lin guess_V2 = mkV2 (mkV "schätzen" | irregV "raten" "rät" "riet" "riete" "geraten") ; -- status=guess, src=wikt status=guess, src=wikt
lin guess_V = mkV "schätzen" | irregV "raten" "rät" "riet" "riete" "geraten" ; -- status=guess, src=wikt status=guess, src=wikt
lin recommendation_N = mkN "Empfehlung" ; -- status=guess
lin autumn_N = mkN "Herbst" "Herbste" masculine ; -- status=guess
lin conventional_A = mk3A "konventionell" "konventioneller" "konventionellsten e" | mkA "herkömmlich" ; -- status=guess status=guess
lin cope_V = irregV "schaffen" "schafft" "schuf" "schüfe" "geschaffen" | prefixV "zurecht" (irregV "kommen" "kommt" "kam" "kam" "gekommen") ; -- status=guess, src=wikt status=guess, src=wikt
lin constitute_V2 = mkV2 (irregV "ernennen" "ernennt" "ernannte" "ernannte" "ernannt" | irregV "konstituieren" "konstituiert" "konstituierte" "konstituierte" "konstituiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin poll_N = mkN "Umfrage" "Umfragen" feminine ; -- status=guess
lin voluntary_A = mk3A "freiwillig" "freiwilliger" "freiwilligste" ; -- status=guess
lin valuable_A = mk3A "wertvoll" "wertvoller" "wertvollste" ; -- status=guess
lin recovery_N = mkN "Wiedererlangung" feminine ; -- status=guess
lin cast_V2 = mkV2 I.werfen_V ;
lin cast_V = I.werfen_V ;
lin premise_N = mkN "Prämisse" feminine ; -- status=guess
lin resolve_V2 = mkV2 (mkV "lösen") | mkV2 (mkV "auflösen") ; -- status=guess, src=wikt status=guess, src=wikt
lin resolve_V = mkV "lösen" | mkV "auflösen" ; -- status=guess, src=wikt status=guess, src=wikt
lin regularly_Adv = variants{} ; -- 
lin solve_V2 = mkV2 (mkV "lösen") ; -- status=guess, src=wikt
lin plaintiff_N = mkN "Kläger" masculine ; -- status=guess
lin critic_N = mkN "Kritiker" "Kritiker" masculine ; -- status=guess
lin agriculture_N = mkN "Landwirtschaft" "Landwirtschaften" feminine | mkN "Ackerbau" masculine ; -- status=guess status=guess
lin ice_N = L.ice_N ;
lin constitution_N = mkN "Verfassen" neuter | mkN "Verfassung" ; -- status=guess status=guess
lin communist_N = mkN "Kommunist" "Kommunisten" masculine | mkN "Kommunistin" "Kommunistinnen" feminine ; -- status=guess status=guess
lin layer_N = mkN "Schicht" "Schichten" feminine ; -- status=guess
lin recession_N = mkN "Rezession" ; -- status=guess
lin slight_A = mkA "geringfügig" | mk3A "leicht" "leichter" "leichteste" ; -- status=guess status=guess
lin dramatic_A = mk3A "dramatisch" "dramatischer" "dramatischste" ; -- status=guess
lin golden_A = mk3A "golden" "goldener" "goldenste" ; -- status=guess
lin temporary_A = regA "zeitweilig" | mkA "temporär" | mkA "vorübergehend" ; -- status=guess status=guess status=guess
lin suit_N = mkN "Farbe" "Farben" feminine ; -- status=guess
lin shortly_Adv = variants{} ; -- 
lin initially_Adv = mkAdv "zunächst" | mkAdv "anfangs" ; -- status=guess status=guess
lin arrival_N = mkN "Ankunft" "Ankünfte" feminine ; -- status=guess
lin protest_N = mkN "Demonstration" ; -- status=guess
lin resistance_N = mkN "Widerstand" masculine ; -- status=guess
lin silent_A = mk3A "still" "stiller" "stillste" | mkA "schweigen" ; -- status=guess status=guess
lin presentation_N = mkN "Vortrag" "Vorträge" masculine | mkN "Präsentation" feminine | mkN "Vorstellung" ; -- status=guess status=guess status=guess
lin soul_N = mkN "Soul Patch" ; -- status=guess
lin self_N = mkN "Selbst" neuter ; -- status=guess
lin judgment_N = mkN "Urteil" "Urteile" neuter ; -- status=guess
lin feed_V2 = mkV2 (irregV "fressen" "fresst" "fraß" "fräße" "gefressen") ; -- status=guess, src=wikt
lin feed_V = irregV "fressen" "fresst" "fraß" "fräße" "gefressen" ; -- status=guess, src=wikt
lin muscle_N = mkN "Muskel" "Muskeln" masculine ; -- status=guess
lin shareholder_N = mkN "Aktionär" masculine ; -- status=guess
lin opposite_A = regA "entgegengesetzt" ; -- status=guess
lin pollution_N = mkN "Verunreinigung" "Verunreinigungen" feminine | mkN "Verschmutzung" "Verschmutzungen" feminine | mkN "Umweltverschmutzung" | mkN "Pollution" feminine ; -- status=guess status=guess status=guess status=guess
lin wealth_N = mkN "Fülle" feminine ; -- status=guess
lin video_taped_A = variants{} ; -- 
lin kingdom_N = reich_N ; -- status=guess
lin bread_N = L.bread_N ;
lin perspective_N = mkN "Perspektive" "Perspektiven" feminine ; -- status=guess
lin camera_N = L.camera_N ;
lin prince_N = mkN "König" masculine ; -- status=guess
lin illness_N = mkN "Krankheit" "Krankheiten" feminine ; -- status=guess
lin cake_N = mkN "Kuchen" "Kuchen" masculine ; -- status=guess
lin meat_N = L.meat_N ;
lin submit_V2 = mkV2 (prefixV "vor" (regV "legen") | prefixV "ein" (regV "reichen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin submit_V = prefixV "vor" (regV "legen") | prefixV "ein" (regV "reichen") ; -- status=guess, src=wikt status=guess, src=wikt
lin ideal_A = mk3A "ideal" "idealer" "idealste" ; -- status=guess
lin relax_V2 = mkV2 (irregV "entspannen" "entspannt" "entspannte" "entspannte" "entspannt" | junkV (mkV "locker") "werden") ; -- status=guess, src=wikt status=guess, src=wikt
lin relax_V = irregV "entspannen" "entspannt" "entspannte" "entspannte" "entspannt" | junkV (mkV "locker") "werden" ; -- status=guess, src=wikt status=guess, src=wikt
lin penalty_N = mkN "Strafraum" "Strafräume" masculine ; -- status=guess
lin purchase_V2 = mkV2 (regV "kaufen" | prefixV "an" (regV "schaffen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin tired_A = mkA "müde" ; -- status=guess
lin beer_N = L.beer_N ;
lin specify_VS = mkVS (regV "spezifizieren") ; -- status=guess, src=wikt
lin specify_V2 = mkV2 (regV "spezifizieren") ; -- status=guess, src=wikt
lin specify_V = regV "spezifizieren" ; -- status=guess, src=wikt
lin short_Adv = variants{} ; -- 
lin monitor_V2 = mkV2 (mkV "überwachen" | mkV "abhören" | mkV "überprüfen" | prefixV "auf" (regV "passen") | irregV "kontrollieren" "kontrolliert" "kontrollierte" "kontrollierte" "kontrolliert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin monitor_V = mkV "überwachen" | mkV "abhören" | mkV "überprüfen" | prefixV "auf" (regV "passen") | irregV "kontrollieren" "kontrolliert" "kontrollierte" "kontrollierte" "kontrolliert" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin electricity_N = mkN "Elektrizität" feminine ; -- status=guess
lin specifically_Adv = variants{} ; -- 
lin bond_N = mkN "Bindungswinkel" masculine ; -- status=guess
lin statutory_A = mkA "satzungsmäßig" | mkA "satzungsgemäß" | regA "statutarisch" | mkA "statutar" ; -- status=guess status=guess status=guess status=guess
lin laboratory_N = mkN "Labor" neuter | mkN "Laboratorium" "Laboratorien" neuter ; -- status=guess status=guess
lin federal_A = variants{} ; -- 
lin captain_N = mkN "Kapitän zur See" masculine ; -- status=guess
lin deeply_Adv = variants{} ; -- 
lin pour_V2 = mkV2 (mkV "ausgießen") ; -- status=guess, src=wikt
lin pour_V = mkV "ausgießen" ; -- status=guess, src=wikt
lin boss_N = L.boss_N ;
lin creature_N = mkN "Geschöpf" neuter | mkN "Kreatur" feminine ; -- status=guess status=guess
lin urge_VS = mkVS (mkV "drängen" | regV "mahnen" | irregV "treiben" "treibt" "trieb" "triebe" "getrieben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin urge_V2V = mkV2V (mkV "drängen" | regV "mahnen" | irregV "treiben" "treibt" "trieb" "triebe" "getrieben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin urge_V2 = mkV2 (mkV "drängen" | regV "mahnen" | irregV "treiben" "treibt" "trieb" "triebe" "getrieben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin locate_V2 = variants{} ; -- 
lin locate_V = variants{} ; -- 
lin being_N = mkN "Wesen" "Wesen" neuter | mkN "Geschöpf" neuter ; -- status=guess status=guess
lin struggle_VV = mkVV (mkReflV "durchbeißen") | mkVV (mkReflV "schwer tun") ; -- status=guess, src=wikt status=guess, src=wikt
lin struggle_V = mkReflV "durchbeißen" | mkReflV "schwer tun" ; -- status=guess, src=wikt status=guess, src=wikt
lin lifespan_N = mkN "Lebenserwartung" feminine | mkN "Lebensdauer" "Lebensdauern" feminine ; -- status=guess status=guess
lin flat_A = mk3A "flach" "flacher" "flachste" ; -- status=guess
lin valley_N = mkN "Senke" "Senken" feminine | mkN "Tal" "Täler" neuter ; -- status=guess status=guess
lin like_A = regA "gleich" ; -- status=guess
lin guard_N = mkN "Wachhund" masculine ; -- status=guess
lin emergency_N = mkN "Notfall" "Notfälle" masculine | mkN "Notlage" "Notlagen" feminine | mkN "Notstand" "Notstände" masculine ; -- status=guess status=guess status=guess
lin dark_N = mkN "Dunkelheit" "Dunkelheiten" feminine | mkN "Dunkel" neuter ; -- status=guess status=guess
lin bomb_N = mkN "Bombe" "Bomben" feminine ; -- status=guess
lin dollar_N = mkN "Dollar" masculine ; -- status=guess
lin efficiency_N = mkN "Effizienz" "Effizienzen" feminine ; -- status=guess
lin mood_N = mkN "schlechte Laune" feminine | mkN "üble Laune" feminine | mkN "Missmut" masculine | mkN "schlechte Stimmung" feminine ; -- status=guess status=guess status=guess status=guess
lin convert_V2 = mkV2 (irregV "konvertieren" "konvertiert" "konvertierte" "konvertierte" "konvertiert" | regV "umwandeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin convert_V = irregV "konvertieren" "konvertiert" "konvertierte" "konvertierte" "konvertiert" | regV "umwandeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin possession_N = variants{} ; -- 
lin marketing_N = mkN "Marketing" neuter ; -- status=guess
lin please_VV = mkVV (irregV "gefallen" "gefallt" "gefiel" "gefiele" "gefallen" | mkV "rechtmachen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2V = mkV2V (irregV "gefallen" "gefallt" "gefiel" "gefiele" "gefallen" | mkV "rechtmachen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V2 = mkV2 (irregV "gefallen" "gefallt" "gefiel" "gefiele" "gefallen" | mkV "rechtmachen") ; -- status=guess, src=wikt status=guess, src=wikt
lin please_V = irregV "gefallen" "gefallt" "gefiel" "gefiele" "gefallen" | mkV "rechtmachen" ; -- status=guess, src=wikt status=guess, src=wikt
lin habit_N = mkN "Gewohnheit" "Gewohnheiten" feminine | mkN "Habitus" "Habitus" masculine ; -- status=guess status=guess
lin subsequently_Adv = mkAdv "anschließend" | mkAdv "danach" | mkAdv "darauffolgend" | mkAdv "daraufhin" | mkAdv "hierauf" | mkAdv "nachher" | mkAdv "nachträglich" | mkAdv "darauf" | mkAdv "im Anschluss" | mkAdv "in petto" | mkAdv "in petto" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin round_N = mkN "Vollwinkel" masculine ; -- status=guess
lin purchase_N = mkN "Kauf" "Käufe" masculine | mkN "Anschaffung" ; -- status=guess status=guess
lin sort_V2 = mkV2 (regV "sortieren") ; -- status=guess, src=wikt
lin sort_V = regV "sortieren" ; -- status=guess, src=wikt
lin outside_A = variants{} ; -- 
lin gradually_Adv = mkAdv "nach rechts" | mkAdv "allmählich" ; -- status=guess status=guess
lin expansion_N = mkN "Expansion" ; -- status=guess
lin competitive_A = mkA "wettbewerbsfähig" ; -- status=guess
lin cooperation_N = mkN "Zusammenarbeit" feminine | mkN "Kooperation" | mkN "Mitarbeit" feminine ; -- status=guess status=guess status=guess
lin acceptable_A = mk3A "annehmbar" "annehmbarer" "annehmbarste" ; -- status=guess
lin angle_N = mkN "Ecke" "Ecken" feminine ; -- status=guess
lin cook_V2 = mkV2 (irregV "kochen" "kocht" "kochte" "kochte" "kocht" | regV "garen") ; -- status=guess, src=wikt status=guess, src=wikt
lin cook_V = irregV "kochen" "kocht" "kochte" "kochte" "kocht" | regV "garen" ; -- status=guess, src=wikt status=guess, src=wikt
lin net_A = mkA "netto" | mkA "Netto-" ; -- status=guess status=guess
lin sensitive_A = mk3A "empfindlich" "empfindlicher" "empfindlichste" | mk3A "sensibel" "sensibler" "sensibelste" ; -- status=guess status=guess
lin ratio_N = variants{} ; -- 
lin kiss_V2 = mkV2 (junkV (mkV "in") "den Arsch kriechen") ; -- status=guess, src=wikt
lin amount_V = mkV "beträgt" ; -- status=guess, src=wikt
lin sleep_N = mkN "Schlafentzug" masculine ; -- status=guess
lin finance_V2 = mkV2 (regV "finanzieren") ; -- status=guess, src=wikt
lin essentially_Adv = variants{} ; -- 
lin fund_V2 = mkV2 (regV "finanzieren") ; -- status=guess, src=wikt
lin preserve_V2 = mkV2 (regV "bewahren" | prefixV "aufrecht" (regV "erhalten")) ; -- status=guess, src=wikt status=guess, src=wikt
lin wedding_N = mkN "Hochzeitstorte" "Hochzeitstorten" feminine ; -- status=guess
lin personality_N = mkN "Persönlichkeit" feminine ; -- status=guess
lin bishop_N = mkN "Läufer" masculine ; -- status=guess
lin dependent_A = mkA "abhängig" ; -- status=guess
lin landscape_N = mkN "Querformat" neuter ; -- status=guess
lin pure_A = mk3A "pur" "purer" "purste" | mk3A "rein" "reiner" "reinste" ; -- status=guess status=guess
lin mirror_N = mkN "Kopie" "Kopien" feminine ; -- status=guess
lin lock_V2 = mkV2 (mkV "aussperren") ; -- status=guess, src=wikt
lin lock_V = mkV "aussperren" ; -- status=guess, src=wikt
lin symptom_N = mkN "Symptom" "Symptome" neuter ; -- status=guess
lin promotion_N = mkN "Beförderung" feminine ; -- status=guess
lin global_A = regA "global" ; -- status=guess
lin aside_Adv = mkAdv "beiseite" ; -- status=guess
lin tendency_N = mkN "Tendenz" "Tendenzen" feminine | mkN "One-Way-Flug" "One-Way-Flüge" masculine ; -- status=guess status=guess
lin conservation_N = mkN "Schutz" "Schutze" masculine ; -- status=guess
lin reply_N = mkN "Antwort" "Antworten" feminine ; -- status=guess
lin estimate_N = mkN "Schätzung" feminine | mkN "Abschätzung" feminine ; -- status=guess status=guess
lin qualification_N = mkN "Qualifikation" ; -- status=guess
lin pack_V2 = variants{} ; -- 
lin pack_V = variants{} ; -- 
lin governor_N = mkN "Regler" "Regler" masculine ; -- status=guess
lin expected_A = mkA "erwartet" ; -- status=guess
lin invest_V2 = mkV2 (irregV "investieren" "investiert" "investierte" "investierte" "investiert") ; -- status=guess, src=wikt
lin invest_V = irregV "investieren" "investiert" "investierte" "investierte" "investiert" ; -- status=guess, src=wikt
lin cycle_N = mkN "Zyklus" "Zyklen" masculine ; -- status=guess
lin alright_A = variants{} ; -- 
lin philosophy_N = mkN "Philosophie" "Philosophien" feminine ; -- status=guess
lin gallery_N = mkN "Galerie" "Galerien" feminine ; -- status=guess
lin sad_A = mk3A "traurig" "trauriger" "traurigste" ; -- status=guess
lin intervention_N = mkN "Intervention" ; -- status=guess
lin emotional_A = mk3A "emotional" "emotionaler" "emotionalste" ; -- status=guess
lin advertising_N = mkN "Werbung" ; -- status=guess
lin regard_N = variants{} ; -- 
lin dance_V2 = mkV2 (regV "tanzen") ; -- status=guess, src=wikt
lin dance_V = regV "tanzen" ; -- status=guess, src=wikt
lin cigarette_N = mkN "Zigarette" "Zigaretten" feminine ; -- status=guess
lin predict_VS = mkVS (irregV "prophezeien" "prophezeit" "prophezeite" "prophezeite" "prophezeit") ; -- status=guess, src=wikt
lin predict_V2 = mkV2 (irregV "prophezeien" "prophezeit" "prophezeite" "prophezeite" "prophezeit") ; -- status=guess, src=wikt
lin adequate_A = mk3A "angemessen" "angemessener" "angemessenste" | mkA "adäquat" ; -- status=guess status=guess
lin variable_N = mkN "Südlicher Tropfenameisenwürger" masculine ; -- status=guess
lin net_N = mkN "Netto" neuter ; -- status=guess
lin retire_V2 = mkV2 (junkV (mkV "in") "Pension gehen") | mkV2 (junkV (mkV "in") "Rente gehen") | mkV2 (junkV (mkV "in") "den Ruhestand gehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin retire_V = junkV (mkV "in") "Pension gehen" | junkV (mkV "in") "Rente gehen" | junkV (mkV "in") "den Ruhestand gehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sugar_N = mkN "Zucker" "Zucker" masculine ; -- status=guess
lin pale_A = mk3A "hell" "heller" "hellste" | mk3A "blass" "blasser" "blasseste" ; -- status=guess status=guess
lin frequency_N = mkN "Frequenzmodulation" ; -- status=guess
lin guy_N = mkN "Kerl" masculine ;
lin feature_V2 = mkV2 (irregV "bieten" "bietet" "bot" "böte" "geboten" | prefixV "auf" I.weisen_V | mkV "darbieten" | junkV (mkV "besonders") "herausstellen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin furniture_N = mkN "Möbel" "Möbel" neuter | mkN "Möbelstück" neuter ; -- status=guess status=guess
lin administrative_A = regA "administrativ" ; -- status=guess
lin wooden_A = mkA "hölzern" ; -- status=guess
lin input_N = mkN "Eingabe" "Eingaben" feminine ; -- status=guess
lin phenomenon_N = mkN "Phänomen" neuter ; -- status=guess
lin surprising_A = mkA "überraschend" | mkA "verwunderlich" ; -- status=guess status=guess
lin jacket_N = mkN "Jackett" "Jacketts" neuter ; -- status=guess
lin actor_N = variants{} ; -- 
lin actor_2_N = variants{} ; -- 
lin actor_1_N = variants{} ; -- 
lin kick_V2 = mkV2 (mkV "schießen") ; -- status=guess, src=wikt
lin kick_V = mkV "schießen" ; -- status=guess, src=wikt
lin producer_N = mkN "Produzent" "Produzenten" masculine ; -- status=guess
lin hearing_N = mkN "Hörgerät" neuter ; -- status=guess
lin chip_N = mkN "Chip" "Chips" masculine ; -- status=guess
lin equation_N = mkN "Gleichung" ; -- status=guess
lin certificate_N = mkN "Zertifikat" "Zertifikate" neuter ; -- status=guess
lin hello_Interj = mkInterj "hallo" ; -- status=guess
lin remarkable_A = mk3A "bemerkenswert" "bemerkenswerter" "bemerkenswerteste" | mkA "verwunderlich" ; -- status=guess status=guess
lin alliance_N = mkN "Allianz" "Allianzen" feminine ; -- status=guess
lin smoke_V2 = mkV2 (regV "rauchen") ; -- status=guess, src=wikt
lin smoke_V = regV "rauchen" ; -- status=guess, src=wikt
lin awareness_N = mkN "Bewusstsein" neuter ; -- status=guess
lin throat_N = mkN "Kehle" "Kehlen" feminine ; -- status=guess
lin discovery_N = mkN "Entdeckung" ; -- status=guess
lin festival_N = mkN "Festival" "Festivals" neuter ; -- status=guess
lin dance_N = mkN "Tanz" "Tänze" masculine ; -- status=guess
lin promise_N = mkN "Versprechen" "Versprechen" neuter ; -- status=guess
lin rose_N = mkN "Rose" | mkN "Rosengewächs" neuter ;
lin principal_A = mkA "hauptsächlich" ; -- status=guess
lin brilliant_A = genial_A | mk3A "brillant" "brillanter" "brillanteste" ; -- status=guess status=guess
lin proposed_A = variants{} ; -- 
lin coach_N = variants{} ; -- 
lin coach_3_N = variants{} ; -- 
lin coach_2_N = variants{} ; -- 
lin coach_1_N = variants{} ; -- 
lin absolute_A = regA "absolut" ; -- status=guess
lin drama_N = mkN "Drama" "Dramen" neuter | mkN "Schauspiel" "Schauspiele" neuter ; -- status=guess status=guess
lin recording_N = mkN "Aufnahme" "Aufnahmen" feminine ; -- status=guess
lin precisely_Adv = mkAdv "präzise" ; -- status=guess
lin bath_N = bad_N | mkN "Baden-Württembergerin" "Baden-Württembergerinnen" feminine ; -- status=guess status=guess
lin celebrate_V2 = mkV2 (regV "feiern" | regV "zelebrieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin substance_N = mkN "Drogenmissbrauch" masculine ; -- status=guess
lin swing_V2 = mkV2 (mkV "vorbeischauen") ; -- status=guess, src=wikt
lin swing_V = mkV "vorbeischauen" ; -- status=guess, src=wikt
lin for_Adv = mkAdv "dafür" ;
lin rapid_A = mk3A "schnell" "schneller" "schnellste" ; -- status=guess
lin rough_A = mk3A "rau" "rauer" "raueste" | mk3A "grob" "gröber" "gröbste" ; -- status=guess status=guess
lin investor_N = mkN "Investor" "Investoren" masculine | mkN "Anleger" "Anleger" masculine ; -- status=guess status=guess
lin fire_V2 = mkV2 (regV "feuern" | mkV "schießen") ; -- status=guess, src=wikt status=guess, src=wikt
lin fire_V = regV "feuern" | mkV "schießen" ; -- status=guess, src=wikt status=guess, src=wikt
lin rank_N = mkN "Reihe" "Reihen" feminine ; -- status=guess
lin compete_V = mkV "wettkämpfen" | irregV "streiten" "streitet" "stritt" "stritte" "gestritten" | mkV "konkurieren" | irregV "messen" "messt" "maß" "mäße" "gemessen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin sweet_A = mkA "süßsauer" ; -- status=guess
lin decline_VV = mkVV (irregV "deklinieren" "dekliniert" "deklinierte" "deklinierte" "dekliniert") ; -- status=guess, src=wikt
lin decline_V2 = mkV2 (irregV "deklinieren" "dekliniert" "deklinierte" "deklinierte" "dekliniert") ; -- status=guess, src=wikt
lin decline_V = irregV "deklinieren" "dekliniert" "deklinierte" "deklinierte" "dekliniert" ; -- status=guess, src=wikt
lin rent_N = mkN "Callboy" "Callboys" masculine | mkN "Gigolo" masculine | mkN "Stricher" "Stricher" masculine ; -- status=guess status=guess status=guess
lin dealer_N = mkN "Händler" masculine ; -- status=guess
lin bend_V2 = mkV2 (mkReflV "bücken") ; -- status=guess, src=wikt
lin bend_V = mkReflV "bücken" ; -- status=guess, src=wikt
lin solid_A = mkA "deftig" ; -- status=guess
lin cloud_N = L.cloud_N ;
lin across_Adv = variants{}; -- mkPrep "über" accusative ;
lin level_A = mkA "auf gleicher Höhe" | mkA "auf gleichem Niveau" | mkA "auf gleicher Stufe" ; -- status=guess status=guess status=guess
lin enquiry_N = mkN "Anfrage" "Anfragen" feminine ; -- status=guess
lin fight_N = mkN "Kampf" "Kämpfe" masculine | mkN "Schlacht" "Schlachten" feminine ; -- status=guess status=guess
lin abuse_N = mkN "Missbrauch" "Missbräuche" masculine | mkN "Mißbrauch" masculine ; -- status=guess status=guess
lin golf_N = mkN "Golf" "Golfe" masculine ; -- status=guess
lin guitar_N = mkN "Gitarre" "Gitarren" feminine ; -- status=guess
lin electronic_A = regA "elektronisch" ; -- status=guess
lin cottage_N = mkN "Cottage" neuter | mkN "Häuschen" neuter | mkN "Kotten" masculine ; -- status=guess status=guess status=guess
lin scope_N = mkN "Umfang" "Umfänge" masculine ; -- status=guess
lin pause_VS = mkVS (mkV "pausieren" | prefixV "inne" (irregV "halten" "hält" "hielt" "hielte" "gehalten")) ; -- status=guess, src=wikt status=guess, src=wikt
lin pause_V2V = mkV2V (mkV "pausieren" | prefixV "inne" (irregV "halten" "hält" "hielt" "hielte" "gehalten")) ; -- status=guess, src=wikt status=guess, src=wikt
lin pause_V = mkV "pausieren" | prefixV "inne" (irregV "halten" "hält" "hielt" "hielte" "gehalten") ; -- status=guess, src=wikt status=guess, src=wikt
lin mixture_N = mkN "Mischung" ; -- status=guess
lin emotion_N = mkN "Gefühl" neuter | mkN "Empfindung" ; -- status=guess status=guess
lin comprehensive_A = mk3A "umfassend" "umfassender" "umfassendste" ; -- status=guess
lin shirt_N = L.shirt_N ;
lin allowance_N = mkN "Erlaubnis" "Erlaubnisse" feminine ; -- status=guess
lin retirement_N = mkN "Rente" "Renten" feminine | mkN "Ruhestand" masculine ; -- status=guess status=guess
lin breach_N = mkN "Verstoß" masculine ; -- status=guess
lin infection_N = mkN "Ansteckung" | mkN "Infektion" ; -- status=guess status=guess
lin resist_VV = mkVV (irregV "widerstehen" "widersteht" "widerstand" "widerstände" "widerstanden") ; -- status=guess, src=wikt
lin resist_V2 = mkV2 (irregV "widerstehen" "widersteht" "widerstand" "widerstände" "widerstanden") ; -- status=guess, src=wikt
lin resist_V = irregV "widerstehen" "widersteht" "widerstand" "widerstände" "widerstanden" ; -- status=guess, src=wikt
lin qualify_V2 = mkV2 (regV "qualifizieren") ; -- status=guess, src=wikt
lin qualify_V = regV "qualifizieren" ; -- status=guess, src=wikt
lin paragraph_N = mkN "Absatz" "Absätze" masculine ; -- status=guess
lin sick_A = mk3A "krank" "kränker" "kränkste" ; -- status=guess
lin near_A = L.near_A ;
lin researcherMasc_N = mkN "Forscher" "Forscher" masculine ; -- status=guess
lin consent_N = mkN "Zustimmung" | mkN "Konsens" "Konsense" masculine ; -- status=guess status=guess
lin written_A = mkA "geschrieben" | regA "schriftlich" ; -- status=guess status=guess
lin literary_A = mk3A "literarisch" "literarischer" "literarischsten e" ; -- status=guess
lin ill_A = mk3A "schlecht" "schlechter" "schlechteste" | mkA "übel" ; -- status=guess status=guess
lin wet_A = L.wet_A ;
lin lake_N = L.lake_N ;
lin entrance_N = mkN "Eingang" "Eingänge" masculine | mkN "Einfahrt" "Einfahrten" feminine ; -- status=guess status=guess
lin peak_N = mkN "Gipfel" "Gipfel" masculine ; -- status=guess
lin successfully_Adv = mkAdv "erfolgreich" ; -- status=guess
lin sand_N = L.sand_N ;
lin breathe_V2 = mkV2 (prefixV "ein" (regV "atmen")) ; -- status=guess, src=wikt
lin breathe_V = L.breathe_V ;
lin cold_N = mkN "Kaltumformen" feminine ; -- status=guess
lin cheek_N = mkN "Backe" "Backen" feminine ; -- status=guess
lin platform_N = mkN "Plattform" "Plattformen" feminine | mkN "Podest" neuter ; -- status=guess status=guess
lin interaction_N = mkN "Interaktion" ; -- status=guess
lin watch_N = mkN "Wache" "Wachen" feminine ; -- status=guess
lin borrow_VV = mkVV (regV "borgen" | mkV "ausleihen") ; -- status=guess, src=wikt status=guess, src=wikt
lin borrow_V2 = mkV2 (regV "borgen" | mkV "ausleihen") ; -- status=guess, src=wikt status=guess, src=wikt
lin borrow_V = regV "borgen" | mkV "ausleihen" ; -- status=guess, src=wikt status=guess, src=wikt
lin birthday_N = mkN "Geburtstag" "Geburtstage" masculine ; -- status=guess
lin knife_N = mkN "Messer" "Messer" neuter ; -- status=guess
lin extreme_A = mk3A "extrem" "extremer" "extremste" ; -- status=guess
lin core_N = kern_N ; -- status=guess
lin peasantMasc_N = reg2N "Bauer" "Bauern" masculine;
lin armed_A = mk3A "bewaffnet" "bewaffneter" "bewaffnetste" ; -- status=guess
lin permission_N = mkN "Erlaubnis" "Erlaubnisse" feminine ; -- status=guess
lin supreme_A = mkA "höchster" | mkA "oberster" ; -- status=guess status=guess
lin overcome_V2 = mkV2 (mkV "überwinden") ; -- status=guess, src=wikt
lin overcome_V = mkV "überwinden" ; -- status=guess, src=wikt
lin greatly_Adv = variants{} ; -- 
lin visual_A = regA "visuell" ; -- status=guess
lin lad_N = mkN "Junge" masculine | mkN "Knabe" "Knaben" masculine ; -- status=guess status=guess
lin genuine_A = mk3A "echt" "echter" "echteste" | original_A | regA "genuin" ; -- status=guess status=guess status=guess
lin personnel_N = mkN "Personal Computer" "Personal Computer" masculine ; -- status=guess
lin judgement_N = mkN "Tag-und-Nacht-Gleiche" "Tag-und-Nacht-Gleichen" feminine ; -- status=guess
lin exciting_A = mkA "aufregend" ; -- status=guess
lin stream_N = mkN "Strom" "Ströme" masculine ; -- status=guess
lin perception_N = mkN "Wahrnehmung" ; -- status=guess
lin guarantee_VS = mkVS (regV "garantieren" | irregV "versichern" "versichert" "versicherte" "versicherte" "versichert") ; -- status=guess, src=wikt status=guess, src=wikt
lin guarantee_V2 = mkV2 (regV "garantieren" | irregV "versichern" "versichert" "versicherte" "versicherte" "versichert") ; -- status=guess, src=wikt status=guess, src=wikt
lin guarantee_V = regV "garantieren" | irregV "versichern" "versichert" "versicherte" "versicherte" "versichert" ; -- status=guess, src=wikt status=guess, src=wikt
lin disaster_N = mkN "Desaster" "Desaster" neuter ; -- status=guess
lin darkness_N = mkN "Dunkelheit" "Dunkelheiten" feminine | mkN "Finsternis" "Finsternisse" feminine ; -- status=guess status=guess
lin bid_N = mkN "Gebot" "Gebote" neuter ; -- status=guess
lin sake_N = variants{} ; -- 
lin sake_2_N = variants{} ; -- 
lin sake_1_N = variants{} ; -- 
lin organize_V2V = mkV2V (regV "organisieren") ; -- status=guess, src=wikt
lin organize_V2 = mkV2 (regV "organisieren") ; -- status=guess, src=wikt
lin tourist_N = mkN "Tourist" "Touristen" masculine | mkN "Vergnügungsreisender" masculine | mkN "Reisender" masculine ; -- status=guess status=guess status=guess
lin policeman_N = L.policeman_N ;
lin castle_N = mkN "Burg" feminine | mkN "Festung" | mkN "Schloss" neuter ; -- status=guess status=guess status=guess
lin figure_VS = variants{} ; -- 
lin figure_V = variants{} ; -- 
lin race_VV = mkVV (regV "rasen") ; -- status=guess, src=wikt
lin race_V2V = mkV2V (regV "rasen") ; -- status=guess, src=wikt
lin race_V2 = mkV2 (regV "rasen") ; -- status=guess, src=wikt
lin race_V = regV "rasen" ; -- status=guess, src=wikt
lin demonstration_N = mkN "Demonstration" ; -- status=guess
lin anger_N = mkN "Ärger" | mkN "Zorn" masculine | mkN "Wut" masculine | mkN "Groll" masculine | mkN "Ingrimm" masculine | mkN "Grimm" masculine | mkN "Furor" masculine | mkN "Jähzorn" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin briefly_Adv = mkAdv "kurz" ; -- status=guess
lin presumably_Adv = mkAdv "vermutlich" | mkAdv "voraussichtlich" ; -- status=guess status=guess
lin clock_N = mkN "Taktsignal" neuter ; -- status=guess
lin hero_N = mkN "Held" "Helden" masculine | mkN "Hauptfigur" feminine ; -- status=guess status=guess
lin expose_V2 = mkV2 (prefixV "auf" (regV "decken") | irregV "offenbaren" "offenbart" "offenbarte" "offenbarte" "offenbart" | mkV "entblößen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin expose_V = prefixV "auf" (regV "decken") | irregV "offenbaren" "offenbart" "offenbarte" "offenbarte" "offenbart" | mkV "entblößen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin custom_N = mkN "Zoll" "Zölle" masculine ; -- status=guess
lin maximum_A = regA "maximal" ; -- status=guess
lin wish_N = mkN "Wunsch" "Wünsche" masculine ; -- status=guess
lin earning_N = variants{} ; -- 
lin priest_N = L.priest_N ;
lin resign_V2 = mkV2 (mkV "zurücktreten") | mkV2 (mkV "kündigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin resign_V = mkV "zurücktreten" | mkV "kündigen" ; -- status=guess, src=wikt status=guess, src=wikt
lin store_V2 = mkV2 (regV "speichern") ; -- status=guess, src=wikt
lin widespread_A = mkA "weitverbreitet" ; -- status=guess
lin comprise_V2 = mkV2 (irregV "bestehen" "besteht" "bestand" "bestände" "bestanden"); -- status=guess, src=wikt
lin chamber_N = mkN "Raum" "Räume" masculine | mkN "Schlafzimmer" "Schlafzimmer" neuter | mkN "Zimmer" "Zimmer" neuter | mkN "Kammer" "Kammern" feminine | mkN ": Gemach" neuter | mkN "Schlafgemach" neuter ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin acquisition_N = mkN "Erwerb" "Erwerbe" masculine | mkN "Aneignung" feminine ; -- status=guess status=guess
lin involved_A = variants{} ; -- 
lin confident_A = mk3A "zuversichtlich" "zuversichtlicher" "zuversichtlichste" | mk3A "sicher" "sicherer" "sicherste" ; -- status=guess status=guess
lin circuit_N = mkN "Leiterplatte" feminine ; -- status=guess
lin radical_A = mk3A "radikal" "radikaler" "radikalste" ; -- status=guess
lin detect_V2 = mkV2 (irregV "entdecken" "entdeckt" "entdeckte" "entdeckte" "entdeckt") ; -- status=guess, src=wikt
lin stupid_A = L.stupid_A ;
lin grand_A = variants{} ; -- 
lin consumption_N = mkN "Konsum" masculine | mkN "Verzehr" masculine ; -- status=guess status=guess
lin hold_N = mkN "Schiffsraum" masculine ; -- status=guess
lin zone_N = mkN "Bereich" "Bereiche" masculine | mkN "Distrikt" "Distrikte" masculine | mkN "Eingabefeld" neuter | mkN "Feld" "Felder" neuter | mkN "Gebiet" "Gebiete" neuter | mkN "Gürtel" masculine | mkN "Landstrich" "Landstriche" masculine | mkN "Zone" "Zonen" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin mean_A = mk3A "gemein" "gemeiner" "gemeinste" | mkA "böse" ; -- status=guess status=guess
lin altogether_Adv = mkAdv "alle" ; -- status=guess
lin rush_VV = mkVV (mkV "überfallen") ; -- status=guess, src=wikt
lin rush_V2 = mkV2 (mkV "überfallen") ; -- status=guess, src=wikt
lin rush_V = mkV "überfallen" ; -- status=guess, src=wikt
lin numerous_A = mk3A "zahlreich" "zahlreicher" "zahlreichste" | mkA "vielzählig" ; -- status=guess status=guess
lin sink_V2 = mkV2 (irregV "sinken" "sinkt" "sank" "sänke" "gesunken") ; -- status=guess, src=wikt
lin sink_V = irregV "sinken" "sinkt" "sank" "sänke" "gesunken" ; -- status=guess, src=wikt
lin everywhere_Adv = S.everywhere_Adv ;
lin classical_A = mk3A "klassisch" "klassischer" "klassischste" ; -- status=guess
lin respectively_Adv = mkAdv "beziehungsweise" ; -- status=guess
lin distinct_A = mk3A "deutlich" "deutlicher" "deutlichste" ; -- status=guess
lin mad_A = mk3A "sauer" "saurer" "sauerste" | mkA "böse" ; -- status=guess status=guess
lin honour_N = mkN "Ehre" "Ehren" feminine ; -- status=guess
lin statistics_N = mkN "Statistik" "Statistiken" feminine ; -- status=guess
lin false_A = mk3A "falsch" "falscher" "falscheste" | mkA "unecht" ; -- status=guess status=guess
lin square_N = mkN "Feld" "Felder" neuter | mkN "Schachfeld" neuter ; -- status=guess status=guess
lin differ_V = mkReflV "unterscheiden" | prefixV "ab" (regV "weichen") ; -- status=guess, src=wikt status=guess, src=wikt
lin disk_N = mkN "Scheibe" "Scheiben" feminine ; -- status=guess
lin truly_Adv = mkAdv "ehrlich" | mkAdv "wirklich" ; -- status=guess status=guess
lin survival_N = mkN "Überleben" neuter ; -- status=guess
lin proud_A = mk3A "stolz" "stolzer" "stolzeste" | mkA "prahlerisch" ; -- status=guess status=guess
lin tower_N = mkN "der&nbsp;Damenflügel" "die&nbsp;Damenflügel" masculine ; -- status=guess
lin deposit_N = mkN "Anzahlung" ; -- status=guess
lin pace_N = mkN "Tempo" neuter | mkN "Geschwindigkeit" "Geschwindigkeiten" feminine ; -- status=guess status=guess
lin compensation_N = mkN "Abfindung" | mkN "Kompensation" ; -- status=guess status=guess
lin adviserMasc_N = reg2N "Ratgeber" "Ratgeber" masculine;
lin consultant_N = mkN "Berater" "Berater" masculine | mkN "Beraterin" feminine ; -- status=guess status=guess
lin drag_V2 = mkV2 (mkReflV "ziehen") | mkV2 (mkReflV "dahinziehen") ; -- status=guess, src=wikt status=guess, src=wikt
lin drag_V = mkReflV "ziehen" | mkReflV "dahinziehen" ; -- status=guess, src=wikt status=guess, src=wikt
lin advanced_A = regA "fortgeschritten" ; -- status=guess
lin landlord_N = mkN "Vermieter" "Vermieter" masculine | mkN "Hauswirt" "Hauswirte" masculine ; -- status=guess status=guess
lin whenever_Adv = mkAdv "wenn" | mkAdv "wann" | mkAdv "wann" ; -- status=guess status=guess status=guess
lin delay_N = mkN "Verzögerung" feminine ; -- status=guess
lin green_N = mkN "Chile-Kolibri" masculine ; -- status=guess
lin car_V = variants{} ; -- 
lin holder_N = variants{} ; -- 
lin secret_A = mk3A "geheim" "geheimer" "geheimste" ; -- status=guess
lin edition_N = mkN "Ausgabe" "Ausgaben" feminine | mkN "Aufgabe" "Aufgaben" feminine ; -- status=guess status=guess
lin occupation_N = mkN "Beschäftigung" feminine | mkN "Beruf" "Berufe" masculine ; -- status=guess status=guess
lin agricultural_A = regA "landwirtschaftlich" ;
lin intelligence_N = variants{} ; -- 
lin intelligence_2_N = variants{} ; -- 
lin intelligence_1_N = variants{} ; -- 
lin empire_N = mkN "Weltreich" "Weltreiche" neuter | imperium_N ; -- status=guess status=guess
lin definitely_Adv = mkAdv "definitiv" | mkAdv "bestimmt" | mkAdv "sicher" ; -- status=guess status=guess status=guess
lin negotiate_VV = mkVV (prefixV "aus" (irregV "handeln" "handelt" "hande" "handele" "gehandelt")) ; -- status=guess, src=wikt
lin negotiate_V2 = mkV2 (prefixV "aus" (irregV "handeln" "handelt" "hande" "handele" "gehandelt")) ; -- status=guess, src=wikt
lin negotiate_V = prefixV "aus" (irregV "handeln" "handelt" "hande" "handele" "gehandelt") ; -- status=guess, src=wikt
lin host_N = mkN "Wirt" "Wirte" masculine ; -- status=guess
lin relative_N = mkN "Verwandter" masculine | mkN "Verwandte" feminine ; -- status=guess status=guess
lin mass_A = variants{} ; -- 
lin helpful_A = mk3A "hilfreich" "hilfreicher" "hilfreichste" ; -- status=guess
lin fellow_N = mkN "Kollege" "Kollegen" masculine | mkN "Partner" "Partner" masculine ; -- status=guess status=guess
lin sweep_V2 = mkV2 (regV "fegen" | regV "kehren") ; -- status=guess, src=wikt status=guess, src=wikt
lin sweep_V = regV "fegen" | regV "kehren" ; -- status=guess, src=wikt status=guess, src=wikt
lin poet_N = mkN "Poet" "Poeten" masculine | mkN "Dichter" "Dichter" masculine | mkN "Dichterin" "Dichterinnen" feminine ; -- status=guess status=guess status=guess
lin journalist_N = mkN "Journalist" "Journalisten" masculine | mkN "Journalistin" feminine ; -- status=guess status=guess
lin defeat_N = mkN "Niederlage" "Niederlagen" feminine ; -- status=guess
lin unlike_Prep = variants{} ; -- 
lin primarily_Adv = variants{} ; -- 
lin tight_A = mkA "tight" ; -- status=guess
lin indication_N = variants{} ; -- 
lin dry_V2 = mkV2 (regV "trocknen") ; -- status=guess, src=wikt
lin dry_V = regV "trocknen" ; -- status=guess, src=wikt
lin cricket_N = mkN "Cricket" neuter | mkN "Kricket" neuter ; -- status=guess status=guess
lin whisper_V2 = mkV2 (mkV "flüstern" | regV "wispern") ; -- status=guess, src=wikt status=guess, src=wikt
lin whisper_V = mkV "flüstern" | regV "wispern" ; -- status=guess, src=wikt status=guess, src=wikt
lin routine_N = mkN "Routine" feminine ; -- status=guess
lin print_N = variants{} ; -- 
lin anxiety_N = mkN "Besorgnis" feminine | angst_N ; -- status=guess status=guess
lin witness_N = mkN "Zeuge" "Zeugen" masculine | mkN "Zeugin" "Zeuginnen" feminine ; -- status=guess status=guess
lin concerning_Prep = variants{} ; -- 
lin mill_N = mkN "Fabrik" "Fabriken" feminine | mkN "Werk" "Werke" neuter | mkN "Papiermühle" feminine ; -- status=guess status=guess status=guess
lin gentle_A = mkA "einfühlsam" ; -- status=guess
lin curtain_N = mkN "Vorhang" "Vorhänge" masculine | mkN "Gardine" "Gardinen" feminine ; -- status=guess status=guess
lin mission_N = mkN "Mission" ; -- status=guess
lin supplier_N = mkN "Lieferant" "Lieferanten" masculine ; -- status=guess
lin basically_Adv = mkAdv "im Prinzip" ; -- status=guess
lin assure_V2S = variants{} ; -- 
lin assure_V2 = variants{} ; -- 
lin poverty_N = mkN "Armut" feminine ; -- status=guess
lin snow_N = L.snow_N ;
lin prayer_N = mkN "Gebetsteppich" "Gebetsteppiche" masculine ; -- status=guess
lin pipe_N = mkN "Rohrbombe" feminine ; -- status=guess
lin deserve_VV = mkVV (irregV "verdienen" "verdient" "verdiente" "verdiente" "verdient") ; -- status=guess, src=wikt
lin deserve_V2 = mkV2 (irregV "verdienen" "verdient" "verdiente" "verdiente" "verdient") ; -- status=guess, src=wikt
lin deserve_V = irregV "verdienen" "verdient" "verdiente" "verdiente" "verdient" ; -- status=guess, src=wikt
lin shift_N = mkN "Verschiebung" "Verschiebungen" feminine | mkN "Verlagerung" feminine | mkN "Verstellung" feminine ; -- status=guess status=guess status=guess
lin split_V2 = L.split_V2 ;
lin split_V = irregV "spalten" "spaltet" "spaltete" "spaltete" "gespalten" ; -- status=guess, src=wikt
lin near_Adv = mkAdv "nah" ; -- status=guess
lin consistent_A = mkA "widerspruchsfrei" | mk3A "konsistent" "konsistenter" "konsistenteste" ; -- status=guess status=guess
lin carpet_N = L.carpet_N ;
lin ownership_N = mkN "Besitz" masculine ; -- status=guess
lin joke_N = mkN "Witz" "Witze" masculine ; -- status=guess
lin fewer_Det = M.detLikeAdj False M.Pl "weniger" ;
lin workshop_N = mkN "Workshop" masculine ; -- status=guess
lin salt_N = L.salt_N ;
lin aged_Prep = variants{} ; -- 
lin symbol_N = mkN "Symbol" "Symbole" neuter | mkN "Zeichen" "Zeichen" neuter ; -- status=guess status=guess
lin slide_V2 = mkV2 (irregV "gleiten" "gleitet" "glitt" "glitt" "geglitten") ; -- status=guess, src=wikt
lin slide_V = irregV "gleiten" "gleitet" "glitt" "glitt" "geglitten" ; -- status=guess, src=wikt
lin cross_N = mkN "Kreuzung" ; -- status=guess
lin anxious_A = mkA "ängstlich" | mk3A "besorgt" "besorgter" "besorgteste" ; -- status=guess status=guess
lin tale_N = mkN "Märchen" neuter | sage_N | mkN "Geschichte" "Geschichten" feminine | mkN "Erzählung" feminine ; -- status=guess status=guess status=guess status=guess
lin preference_N = variants{} ; -- 
lin inevitably_Adv = mkAdv "zwangsläufig" ; -- status=guess
lin mere_A = variants{} ; -- 
lin behave_V = mkReflV "benehmen" ; -- status=guess, src=wikt
lin gain_N = mkN "Gewinn-und-Verlust-Rechnung" ; -- status=guess
lin nervous_A = mkA "nervös" ; -- status=guess
lin guide_V2 = variants{} ; -- 
lin remark_N = mkN "Bemerkung" ; -- status=guess
lin pleased_A = mk3A "froh" "froher" "frohsten, froheste" | mk3A "zufrieden" "zufriedener" "zufriedenste" ; -- status=guess status=guess
lin province_N = mkN "Provinz" "Provinzen" feminine | mkN "Land" neuter ; -- status=guess status=guess
lin steel_N = L.steel_N ;
lin practise_V2 = variants{} ; -- 
lin practise_V = variants{} ; -- 
lin flow_V = L.flow_V ;
lin holy_A = mk3A "heilig" "heiliger" "heiligste" ; -- status=guess
lin dose_N = mkN "Dosis" "Dosen" feminine ; -- status=guess
lin alcohol_N = mkN "Alkohol" "Alkohole" masculine | mkN "Weingeist" | mkN "Branntwein" "Branntweine" masculine ; -- status=guess status=guess status=guess
lin guidance_N = mkN "Anleitung" | mkN "Richtungsweisung" feminine | mkN "Handlungsempfehlung" feminine | mkN "Orientierungshilfe" feminine ; -- status=guess status=guess status=guess status=guess
lin constantly_Adv = variants{} ; -- 
lin climate_N = mkN "Klimaveränderung" feminine | mkN "Klimawandel" "Klimawandel" masculine ; -- status=guess status=guess
lin enhance_V2 = mkV2 (mkV "erhöhen") | mkV2 (mkV "vergrößern") ; -- status=guess, src=wikt status=guess, src=wikt
lin reasonably_Adv = mkAdv "einigermaßen" ; -- status=guess
lin waste_V2 = mkV2 (junkV (mkV "Zeit") "vergeuden") ; -- status=guess, src=wikt
lin waste_V = junkV (mkV "Zeit") "vergeuden" ; -- status=guess, src=wikt
lin smooth_A = L.smooth_A ;
lin dominant_A = mk3A "dominant" "dominanter" "dominanteste" ; -- status=guess
lin conscious_A = mkA "bei Bewusstsein" | mk3A "wach" "wacher" "wachste" | mk3A "aufmerksam" "aufmerksamer" "aufmerksamste" ; -- status=guess status=guess status=guess
lin formula_N = mkN "Formel" "Formeln" feminine ; -- status=guess
lin tail_N = L.tail_N ;
lin ha_Interj = variants{} ; -- 
lin electric_A = regA "elektrisch" ; -- status=guess
lin sheep_N = L.sheep_N ;
lin medicine_N = mkN "Medizin" "Medizinen" feminine ; -- status=guess
lin strategic_A = mk3A "strategisch" "strategischer" "strategischste" ; -- status=guess
lin disabled_A = mk3A "behindert" "behinderter" "behindertste" ; -- status=guess
lin smell_N = mkN "Geruch" "Gerüche" masculine ; -- status=guess
lin operator_N = mkN "Operator" "Operatoren" masculine | mkN "Rechenzeichen" neuter ; -- status=guess status=guess
lin mount_V2 = mkV2 (regV "befestigen" | prefixV "an" (irregV "bringen" "bringt" "brachte" "brächte" "gebracht")) ; -- status=guess, src=wikt status=guess, src=wikt
lin mount_V = regV "befestigen" | prefixV "an" (irregV "bringen" "bringt" "brachte" "brächte" "gebracht") ; -- status=guess, src=wikt status=guess, src=wikt
lin advance_V2 = mkV2 (mkV "vorrücken") ; -- status=guess, src=wikt
lin advance_V = mkV "vorrücken" ; -- status=guess, src=wikt
lin remote_A = mk3A "fern" "ferner" "fernste" | mk3A "entfernt" "entfernter" "entfernteste" | mkA "abgelegen" | mkA "fernbetrieb" ; -- status=guess status=guess status=guess status=guess
lin measurement_N = mkN "Messung" "Messungen" feminine ; -- status=guess
lin favour_VS = variants{} ; -- 
lin favour_V2 = variants{} ; -- 
lin favour_V = variants{} ; -- 
lin neither_Det = variants{} ; -- 
lin architecture_N = mkN "Architektur" "Architekturen" feminine ; -- status=guess
lin worth_N = mkN "Wert" "Werte" masculine ; -- status=guess
lin tie_N = mkN "Unentschieden" neuter | mkN "Remis" neuter ; -- status=guess status=guess
lin barrier_N = mkN "Grenze" "Grenzen" feminine ; -- status=guess
lin practitioner_N = variants{} ; -- 
lin outstanding_A = mk3A "hervorragend" "hervorragender" "hervorragendste" ; -- status=guess
lin enthusiasm_N = mkN "Begeisterung" | mkN "Enthusiasmus" masculine | mkN "Schwärmerei" feminine ; -- status=guess status=guess status=guess
lin theoretical_A = regA "theoretisch" ; -- status=guess
lin implementation_N = mkN "Implementierung" ; -- status=guess
lin worried_A = mk3A "besorgt" "besorgter" "besorgteste" ; -- status=guess
lin pitch_N = mkN "Pech" "Peche" neuter ; -- status=guess
lin drop_N = mkN "Fall" "Fälle" masculine | mkN "Sturz" "Stürze" masculine ; -- status=guess status=guess
lin phone_V2 = mkV2 (prefixV "an" (irregV "rufen" "ruft" "rief" "riefe" "gerufen") | irregV "telefonieren" "telefoniert" "telefonierte" "telefoniere" "telefoniert") ; -- status=guess, src=wikt status=guess, src=wikt
lin phone_V = prefixV "an" (irregV "rufen" "ruft" "rief" "riefe" "gerufen") | irregV "telefonieren" "telefoniert" "telefonierte" "telefoniere" "telefoniert" ; -- status=guess, src=wikt status=guess, src=wikt
lin shape_VV = mkVV (regV "formen") ; -- status=guess, src=wikt
lin shape_V2 = mkV2 (regV "formen") ; -- status=guess, src=wikt
lin shape_V = regV "formen" ; -- status=guess, src=wikt
lin clinical_A = mk3A "klinisch" "klinischer" "klinischste" ; -- status=guess
lin lane_N = spur_N | mkN "Route" feminine ; -- status=guess status=guess
lin apple_N = L.apple_N ;
lin catalogue_N = mkN "Katalog" "Kataloge" masculine | mkN "Liste" "Listen" feminine | mkN "Verzeichnis" "Verzeichnisse" neuter ; -- status=guess status=guess status=guess
lin tip_N = mkN "Spitze" "Spitzen" feminine ; -- status=guess
lin publisher_N = mkN "Herausgeber" "Herausgeber" masculine | mkN "Herausgeberin" feminine | mkN "Verlag" "Verlage" masculine ; -- status=guess status=guess status=guess
lin opponentMasc_N = reg2N "Gegenspieler" "Gegenspieler" masculine;
lin live_A = mk3A "scharf" "schärfer" "schärfste" ; -- status=guess
lin burden_N = mkN "Sorge" "Sorgen" feminine | mkN "Bürde" feminine ; -- status=guess status=guess
lin tackle_V2 = mkV2 (junkV (mkV "in") "Angriff nehmen") ; -- status=guess, src=wikt
lin tackle_V = junkV (mkV "in") "Angriff nehmen" ; -- status=guess, src=wikt
lin historian_N = mkN "Historiker" "Historiker" masculine | mkN "Historikerin" "Historikerinnen" feminine ; -- status=guess status=guess
lin bury_V2 = mkV2 (irregV "vergraben" "vergräbt" "vergrub" "vergrub" "vergraben") ; -- status=guess, src=wikt
lin bury_V = irregV "vergraben" "vergräbt" "vergrub" "vergrub" "vergraben" ; -- status=guess, src=wikt
lin stomach_N = mkN "Bauch" "Bäuche" masculine ; -- status=guess
lin percentage_N = mkN "Prozentsatz" masculine ; -- status=guess
lin evaluation_N = mkN "Beurteilung" ; -- status=guess
lin outline_V2 = variants{} ; -- 
lin talent_N = mkN "Talent" "Talente" neuter | mkN "Begabung" ; -- status=guess status=guess
lin lend_V2 = mkV2 (irregV "leihen" "leiht" "lieh" "liehe" "geliehen" | irregV "verleihen" "verleiht" "verlieh" "verliehe" "verliehen" | regV "borgen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lend_V = irregV "leihen" "leiht" "lieh" "liehe" "geliehen" | irregV "verleihen" "verleiht" "verlieh" "verliehe" "verliehen" | regV "borgen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin silver_N = L.silver_N ;
lin pack_N = mkN "Kartenspiel" "Kartenspiele" neuter | mkN "Kartenstapel" masculine ; -- status=guess status=guess
lin fun_N = mkN "Spaß" masculine | mkN "Vergnügen" neuter | mkN "Amüsement" neuter ; -- status=guess status=guess status=guess
lin democrat_N = mkN "Demokrat" "Demokraten" masculine | mkN "Demokratin" feminine ; -- status=guess status=guess
lin fortune_N = mkN "Glück" neuter ; -- status=guess
lin storage_N = mkN "Speicher" "Speicher" masculine ; -- status=guess
lin professional_N = mkN "Profi" "Profis" masculine ; -- status=guess
lin reserve_N = mkN "Schutzgebiet" neuter ; -- status=guess
lin interval_N = mkN "Abstand" "Abstände" masculine | mkN "Zwischenraum" masculine ; -- status=guess status=guess
lin dimension_N = mkN "Dimension" ; -- status=guess
lin honest_A = mk3A "ehrlich" "ehrlicher" "ehrlichste" | mk3A "aufrichtig" "aufrichtiger" "aufrichtigste" ; -- status=guess status=guess
lin awful_A = mk3A "schrecklich" "schrecklicher" "schrecklichste" | mk3A "furchtbar" "furchtbarer" "furchtbarste" ; -- status=guess status=guess
lin manufacture_V2 = mkV2 (prefixV "her" (regV "stellen")) ; -- status=guess, src=wikt
lin confusion_N = mkN "Verwirrung" ; -- status=guess
lin pink_A = variants{} ; -- 
lin impressive_A = mkA "beeindruckend" | mk3A "eindrucksvoll" "eindrucksvoller" "eindrucksvollste" | mkA "imposant" ; -- status=guess status=guess status=guess
lin satisfaction_N = mkN "Befriedigung" feminine ; -- status=guess
lin visible_A = mk3A "sichtbar" "sichtbarer" "sichtbarste" ; -- status=guess
lin vessel_N = mkN "Gefäß" neuter | mkN "Behälter" masculine | mkN "Behältnis" neuter ; -- status=guess status=guess status=guess
lin stand_N = mkN "Ständer" masculine | mkN "Stativ" "Stative" neuter ; -- status=guess status=guess
lin curve_N = mkN "Kurve" "Kurven" feminine ; -- status=guess
lin pot_N = mkN "Schlagloch" "Schlaglöcher" neuter ; -- status=guess
lin replacement_N = mkN "Ersatz" "Ersätze" masculine | mkN "Ersatzspieler" masculine ; -- status=guess status=guess
lin accurate_A = mk3A "genau" "genauer" "genausten, genaueste" | mkA "präzise" | mk3A "exakt" "exakter" "exakteste" ; -- status=guess status=guess status=guess
lin mortgage_N = mkN "Hypothek" "Hypotheken" feminine ; -- status=guess
lin salary_N = mkN "Gehalt" "Gehälter" neuter ; -- status=guess
lin impress_V2 = variants{} ; -- 
lin impress_V = variants{} ; -- 
lin constitutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (regV "betonen") ; -- status=guess, src=wikt
lin emphasize_V2 = mkV2 (regV "betonen") ; -- status=guess, src=wikt
lin developing_A = mkA "entwickelnd" | mkA "Entwicklungs-" ; -- status=guess status=guess
lin proof_N = mkN "Beweis" "Beweise" masculine ; -- status=guess
lin furthermore_Adv = mkAdv "weiterhin" | mkAdv "darüber hinaus" ; -- status=guess status=guess
lin dish_N = mkN "Gericht" "Gerichte" neuter ; -- status=guess
lin interview_V2 = mkV2 (irregV "interviewen" "interviewt" "interviewte" "interviewte" "interviewt") ; -- status=guess, src=wikt
lin considerably_Adv = mkAdv "wesentlich" | mkAdv "beträchtlich" | mkAdv "beachtlich" ; -- status=guess status=guess status=guess
lin distant_A = mk3A "fern" "ferner" "fernste" | mk3A "entfernt" "entfernter" "entfernteste" | mkA "distanziert" | mkA "abstehend" ; -- status=guess status=guess status=guess status=guess
lin lower_V2 = mkV2 (mkV "herunterlassen") ; -- status=guess, src=wikt
lin lower_V = mkV "herunterlassen" ; -- status=guess, src=wikt
lin favouriteMasc_N = mkN "Liebling" "Lieblinge" masculine ; -- status=guess
lin tear_V2 = mkV2 (mkV "tränen") ; -- status=guess, src=wikt
lin tear_V = mkV "tränen" ; -- status=guess, src=wikt
lin fixed_A = regA "fixiert" | mk3A "fix" "fixer" "fixeste" ; -- status=guess status=guess
lin by_Adv = mkAdv "längs" ; -- status=guess
lin luck_N = mkN "Glück" neuter ; -- status=guess
lin count_N = mkN "zählbares Nomen" neuter ; -- status=guess
lin precise_A = mkA "präzise" | mk3A "genau" "genauer" "genausten, genaueste" ; -- status=guess status=guess
lin determination_N = mkN "Determination" ; -- status=guess
lin bite_V2 = L.bite_V2 ;
lin bite_V = junkV (mkV "in") "den sauren Apfel beissen" ; -- status=guess, src=wikt
lin dear_Interj = variants{} ; -- 
lin consultation_N = variants{} ; -- 
lin range_V = variants{} ; -- 
lin residential_A = mkA "wohn-" | mkA "Wohn-" ; -- status=guess status=guess
lin conduct_N = variants{} ; -- 
lin capture_V2 = mkV2 (irregV "fangen" "fangt" "fing" "finge" "gefangen" | prefixV "ein" (irregV "fangen" "fängt" "fing" "fing" "gefangen") | junkV (mkV "gefangen") "nehmen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin ultimately_Adv = mkAdv "schließlich" ; -- status=guess
lin cheque_N = mkN "Scheck" "Schecks" masculine ; -- status=guess
lin economics_N = mkN "Ökonomie" feminine | mkN "Wirtschaftswissenschaft" "Wirtschaftswissenschaften" feminine ; -- status=guess status=guess
lin sustain_V2 = variants{} ; -- 
lin secondly_Adv = mkAdv "zweitens" ; -- status=guess
lin silly_A = mk3A "doof" "doofer" "doofste" ; -- status=guess
lin merchant_N = mkN "Kaufmann" "Kaufleute" masculine | mkN "Kauffrau" feminine ; -- status=guess status=guess
lin lecture_N = mkN "Vorlesung" | mkN "Vortrag" "Vorträge" masculine ; -- status=guess status=guess
lin musical_A = mk3A "musikalisch" "musikalischer" "musikalischste" ; -- status=guess
lin leisure_N = mkN "Muße" feminine ; -- status=guess
lin check_N = mkN "Rechnung" ; -- status=guess
lin cheese_N = L.cheese_N ;
lin lift_N = mkN "Auftrieb" "Auftriebe" masculine ; -- status=guess
lin participate_V2 = mkV2 (prefixV "teil" I.nehmen_V) ; -- status=guess, src=wikt
lin participate_V = prefixV "teil" I.nehmen_V ; -- status=guess, src=wikt
lin fabric_N = mkN "Bau" masculine | mkN "Rohbau" "Rohbauten" masculine | mkN "Struktur" "Strukturen" feminine ; -- status=guess status=guess status=guess
lin distribute_V2 = mkV2 (irregV "verteilen" "verteilt" "verteilte" "verteile" "verteilt") ; -- status=guess, src=wikt
lin lover_N = mkN "Geliebter" masculine | mkN "Geliebte" feminine ; -- status=guess status=guess
lin childhood_N = mkN "Kindheit" feminine ; -- status=guess
lin cool_A = regA "in" | regA "ganz" | mkA "alles klar" | mk3A "akzeptabel" "akzeptabler" "akzeptabelste" ; -- status=guess status=guess status=guess status=guess
lin ban_V2 = mkV2 (irregV "verbieten" "verbietet" "verbot" "verböte" "verboten") ; -- status=guess, src=wikt
lin supposed_A = regA "vermeintlich" ; -- status=guess
lin mouse_N = mkN "Braunflügel-Ameisenwürger" masculine ; -- status=guess
lin strain_N = mkN "Stamm" "Stämme" masculine ; -- status=guess
lin specialist_A = variants{} ; -- 
lin consult_V2 = variants{} ; -- 
lin consult_V = variants{} ; -- 
lin minimum_A = regA "minimal" ; -- status=guess
lin approximately_Adv = mkAdv "ungefähr" | mkAdv "etwa" ; -- status=guess status=guess
lin participant_N = mkN "Teilnehmer" "Teilnehmer" masculine | mkN "Teilnehmerin" feminine ; -- status=guess status=guess
lin monetary_A = mkA "monetär" | mkA "Geld-" ; -- status=guess status=guess
lin confuse_V2 = variants{} ; -- 
lin dare_VV = mkVV (irregV "riskieren" "riskiert" "riskierte" "riskierte" "riskiert") ; -- status=guess, src=wikt
lin dare_V2 = mkV2 (irregV "riskieren" "riskiert" "riskierte" "riskierte" "riskiert") ; -- status=guess, src=wikt
lin smoke_N = L.smoke_N ;
lin movie_N = mkN "Film" "Filme" masculine | mkN "Spielfilm" "Spielfilme" masculine ; -- status=guess status=guess
lin seed_N = L.seed_N ;
lin cease_V2 = mkV2 (junkV (mkV "hören") "Sie auf und verzichten Sie") ; -- status=guess, src=wikt
lin cease_V = junkV (mkV "hören") "Sie auf und verzichten Sie" ; -- status=guess, src=wikt
lin open_Adv = variants{} ; -- 
lin journal_N = mkN "Tagebuch" "Tagebücher" neuter | mkN "Logbuch" "Logbücher" neuter ; -- status=guess status=guess
lin shopping_N = mkN "Einkaufen" "Einkaufen" neuter ;
lin equivalent_N = mkN "Entsprechung" feminine | mkN "Äquivalent" neuter ; -- status=guess status=guess
lin palace_N = mkN "Palast" "Paläste" masculine | mkN "Schloss" neuter ; -- status=guess status=guess
lin exceed_V2 = variants{} ; -- 
lin isolated_A = variants{} ; -- 
lin poetry_N = mkN "Poesie" "Poesien" feminine | mkN "Dichtkunst" feminine ; -- status=guess status=guess
lin perceive_VS = mkVS (prefixV "wahr" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen")) ; -- status=guess, src=wikt
lin perceive_V2V = mkV2V (prefixV "wahr" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen")) ; -- status=guess, src=wikt
lin perceive_V2 = mkV2 (prefixV "wahr" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen")) ; -- status=guess, src=wikt
lin lack_V2 = mkV2 (regV "mangeln" | regV "fehlen") ;
lin lack_V = regV "mangeln" | regV "fehlen" ;
lin strengthen_V2 = mkV2 (mkV "bestärken") | mkV2 (mkV "stärken") ; -- status=guess, src=wikt status=guess, src=wikt
lin snap_V2 = mkV2 (mkV "zurückpassen") ; -- status=guess, src=wikt
lin snap_V = mkV "zurückpassen" ; -- status=guess, src=wikt
lin readily_Adv = mkAdv "bereitwillig" ; -- status=guess
lin spite_N = mkN "Boshaftigkeit" feminine | mkN "Gehässigkeit" feminine ; -- status=guess status=guess
lin conviction_N = mkN "Überzeugung" feminine ; -- status=guess
lin corridor_N = mkN "Korridor" "Korridore" masculine ; -- status=guess
lin behind_Adv = mkAdv "hinten" ;
lin ward_N = mkN "Wache" "Wachen" feminine ; -- status=guess
lin profile_N = variants{} ; -- 
lin fat_A = mk3A "dick" "dicker" "dickste" | mk3A "fett" "fetter" "fetteste" ; -- status=guess status=guess
lin comfort_N = mkN "Trost" masculine | mkN "Tröstung" feminine ; -- status=guess status=guess
lin bathroom_N = mkN "Badezimmer" "Badezimmer" neuter | bad_N ; -- status=guess status=guess
lin shell_N = mkN "Schalentier" neuter | mkN "Muschel" "Muscheln" feminine ; -- status=guess status=guess
lin reward_N = mkN "Belohnung" ; -- status=guess
lin deliberately_Adv = mkAdv "mit Absicht" | mkAdv "absichtlich" ; -- status=guess status=guess
lin automatically_Adv = variants{} ; -- 
lin vegetable_N = mkN "Gemüse" ; ----mkN "Dahinvegetierende {m}" feminine ; -- status=guess
lin imagination_N = mkN "Vorstellung" ; -- status=guess
lin junior_A = mkA "jünger" ; -- status=guess
lin unemployed_A = regA "arbeitslos" ; -- status=guess
lin mystery_N = mkN "Rätsel" neuter ; -- status=guess
lin pose_V2 = mkV2 (irregV "stellen" "stellt" "stellte" "stelle" "gestellt") ; -- status=guess, src=wikt
lin pose_V = irregV "stellen" "stellt" "stellte" "stelle" "gestellt" ; -- status=guess, src=wikt
lin violent_A = mk3A "grell" "greller" "grellste" ; -- status=guess
lin march_N = variants{} ; -- 
lin found_V2 = mkV2 (irregV "errichten" "errichtet" "errichtete" "errichte" "errichtet") ; -- status=guess, src=wikt
lin dig_V2 = mkV2 (irregV "graben" "grabt" "grub" "grübe" "gegraben") ; -- status=guess, src=wikt
lin dig_V = L.dig_V ;
lin dirty_A = L.dirty_A ;
lin straight_A = L.straight_A ;
lin psychological_A = mkA "psychologisch" ; -- status=guess
lin grab_V2 = mkV2 (irregV "greifen" "greift" "griff" "griffe" "gegriffen") ; -- status=guess, src=wikt
lin grab_V = irregV "greifen" "greift" "griff" "griffe" "gegriffen" ; -- status=guess, src=wikt
lin pleasant_A = mk3A "angenehm" "angenehmer" "angenehmste" ; -- status=guess
lin surgery_N = mkN "Praxis" "Praxen" feminine ; -- status=guess
lin inevitable_A = mkA "unvermeidlich" | mkA "unabwendbar" ; -- status=guess status=guess
lin transform_V2 = mkV2 (regV "umwandeln") ; -- status=guess, src=wikt
lin bell_N = mkN "Schlaghose" feminine ; -- status=guess
lin announcement_N = mkN "Ankündigung" feminine ; -- status=guess
lin draft_N = mkN "Musterung" feminine ; -- status=guess
lin unity_N = mkN "Einheit" "Einheiten" feminine ; -- status=guess
lin airport_N = mkN "Flughafen" "Flughäfen" masculine | mkN "Flugplatz" "Flugplätze" masculine ; -- status=guess status=guess
lin upset_V2 = mkV2 (mkV "umstoßen" | mkV "stürzen" | prefixV "um" (irregV "werfen" "wirft" "warf" "warf" "geworfen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin upset_V = mkV "umstoßen" | mkV "stürzen" | prefixV "um" (irregV "werfen" "wirft" "warf" "warf" "geworfen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pretend_VS = mkVS (prefixV "vor" (irregV "geben" "gebt" "gab" "gäbe" "gegeben")) ; -- status=guess, src=wikt
lin pretend_V2 = mkV2 (prefixV "vor" (irregV "geben" "gebt" "gab" "gäbe" "gegeben")) ; -- status=guess, src=wikt
lin pretend_V = prefixV "vor" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") ; -- status=guess, src=wikt
lin plant_V2 = mkV2 (regV "pflanzen") ; -- status=guess, src=wikt
lin till_Prep = variants{} ; -- 
lin known_A = mk3A "bekannt" "bekannter" "bekannteste" ; -- status=guess
lin admission_N = variants{} ; -- 
lin tissue_N = mkN "Gewebe" "Gewebe" neuter ; -- status=guess
lin magistrate_N = variants{} ; -- 
lin joy_N = mkN "Freude" "Freuden" feminine ; -- status=guess
lin free_V2V = mkV2V (regV "befreien" | regV "freisetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin free_V2 = mkV2 (regV "befreien" | regV "freisetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin pretty_A = mkA "hübsch" | mkA "schön" ; -- status=guess status=guess
lin operating_N = mkN "Operationssaal" "Operationssäle" masculine ; -- status=guess
lin headquarters_N = mkN "Zentrale" "Zentralen" feminine ; -- status=guess
lin grateful_A = mkA "wohltuend" | mk3A "zufrieden" "zufriedener" "zufriedenste" ; -- status=guess status=guess
lin classroom_N = mkN "Klassenzimmer" "Klassenzimmer" neuter ; -- status=guess
lin turnover_N = mkN "Fluktuation" ; -- status=guess
lin project_VS = mkVS (mkV "ragen") | mkVS (mkV "hervorragen") | mkVS (mkV "herausragen") | mkVS (mkV "vorspringen") | mkVS (mkV "vorstehen") | mkVS (mkV "überstehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin project_V2V = mkV2V (mkV "ragen") | mkV2V (mkV "hervorragen") | mkV2V (mkV "herausragen") | mkV2V (mkV "vorspringen") | mkV2V (mkV "vorstehen") | mkV2V (mkV "überstehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin project_V2 = mkV2 (mkV "ragen") | mkV2 (mkV "hervorragen") | mkV2 (mkV "herausragen") | mkV2 (mkV "vorspringen") | mkV2 (mkV "vorstehen") | mkV2 (mkV "überstehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin project_V = mkV "ragen" | mkV "hervorragen" | mkV "herausragen" | mkV "vorspringen" | mkV "vorstehen" | mkV "überstehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin shrug_V2 = mkV2 (junkV (mkV "mit") "den Schultern zucken") | mkV2 (junkV (mkV "mit") "den Achseln zucken") ; -- status=guess, src=wikt status=guess, src=wikt
lin sensible_A = mkA "vernünftig" ; -- status=guess
lin limitation_N = mkN "Begrenzung" ; -- status=guess
lin specialist_N = mkN "Spezialist" "Spezialisten" masculine | mkN "Fachmann" masculine | mkN "Experte" "Experten" masculine ; -- status=guess status=guess status=guess
lin newly_Adv = mkAdv "neu" ; -- status=guess
lin tongue_N = L.tongue_N ;
lin refugee_N = mkN "Flüchtlingslager" neuter ; -- status=guess
lin delay_V2 = mkV2 (mkV "verspäten" | irregV "verschieben" "verschiebt" "verschob" "verschöbe" "verschoben") ; -- status=guess, src=wikt status=guess, src=wikt
lin delay_V = mkV "verspäten" | irregV "verschieben" "verschiebt" "verschob" "verschöbe" "verschoben" ; -- status=guess, src=wikt status=guess, src=wikt
lin dream_V2 = mkV2 (mkV "träumen") ; -- status=guess, src=wikt
lin dream_V = mkV "träumen" ; -- status=guess, src=wikt
lin composition_N = mkN "Zusammenstellung" ; -- status=guess
lin alongside_Prep = variants{} ; -- 
lin ceiling_N = L.ceiling_N ;
lin highlight_V2 = mkV2 (prefixV "hervor" (irregV "heben" "hebt" "hob" "höbe" "gehoben") | irregV "beleuchten" "beleuchtet" "beleuchtete" "beleuchtete" "beleuchtet") ; -- status=guess, src=wikt status=guess, src=wikt
lin stick_N = L.stick_N ;
lin favourite_A = variants{} ; -- 
lin tap_V2 = mkV2 (mkV "anzapfen") ; -- status=guess, src=wikt
lin tap_V = mkV "anzapfen" ; -- status=guess, src=wikt
lin universe_N = mkN "Universum" "Universen" neuter ; -- status=guess
lin request_VS = mkVS (mkV "erbitten") ; -- status=guess, src=wikt
lin request_V2 = mkV2 (mkV "erbitten") ; -- status=guess, src=wikt
lin label_N = mkN "Etikett" neuter | mkN "Beschriftung" feminine ; -- status=guess status=guess
lin confine_V2 = mkV2 (mkV "beschränken") ; -- status=guess, src=wikt
lin scream_VS = mkVS (irregV "schreien" "schreit" "schrie" "schriee" "geschrien") ; -- status=guess, src=wikt
lin scream_V2 = mkV2 (irregV "schreien" "schreit" "schrie" "schriee" "geschrien") ; -- status=guess, src=wikt
lin scream_V = irregV "schreien" "schreit" "schrie" "schriee" "geschrien" ; -- status=guess, src=wikt
lin rid_V2 = variants{} ; -- 
lin acceptance_N = mkN "Akzeptanz" feminine ; -- status=guess
lin detective_N = mkN "Detektiv" "Detektive" masculine ;
lin sail_V = regV "segeln" ; -- status=guess, src=wikt
lin adjust_V2 = mkV2 (regV "berichtigen") ; -- status=guess, src=wikt
lin adjust_V = regV "berichtigen" ; -- status=guess, src=wikt
lin designer_N = mkN "Designer" "Designer" masculine ; -- status=guess
lin running_A = variants{} ; -- 
lin summit_N = mkN "Gipfeltreffen" "Gipfeltreffen" neuter | mkN "Gipfel" "Gipfel" masculine ; -- status=guess status=guess
lin participation_N = mkN "Partizipation" | mkN "Beteiligung" | mkN "Teilnahme" "Teilnahmen" feminine ; -- status=guess status=guess status=guess
lin weakness_N = mkN "Schwäche" feminine ; -- status=guess
lin block_V2 = mkV2 (prefixV "ab" (regV "blocken")) ; -- status=guess, src=wikt
lin socalled_A = variants{} ; -- 
lin adapt_V2 = mkV2 (prefixV "an" (regV "passen")) ; -- status=guess, src=wikt
lin adapt_V = prefixV "an" (regV "passen") ; -- status=guess, src=wikt
lin absorb_V2 = mkV2 (irregV "absorbieren" "absorbiert" "absorbierte" "absorbierte" "absorbiert") ; -- status=guess, src=wikt
lin encounter_V2 = mkV2 (irregV "treffen" "trefft" "traf" "träfe" "getroffen" | regV "begegnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin defeat_V2 = mkV2 (irregV "schlagen" "schlagt" "schlug" "schlüge" "geschlagen" | regV "besiegen" | mkV "niederringen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin excitement_N = mkN "Aufregung" ; -- status=guess
lin brick_N = mkN "Ziegel" "Ziegel" masculine ; -- status=guess
lin blind_A = mk3A "blind" "blinder" "blindeste" ; -- status=guess
lin wire_N = mkN "Seitenschneider" masculine ; -- status=guess
lin crop_N = mkN "Kornkreis" "Kornkreise" masculine ; -- status=guess
lin square_A = regA "rechtwinklig" ; -- status=guess
lin transition_N = mkN "Übergang" masculine ; -- status=guess
lin thereby_Adv = mkAdv "dadurch" | mkAdv "damit" ; -- status=guess status=guess
lin protest_V2 = mkV2 (junkV (mkV "Einspruch") "erheben") | mkV2 (junkV (mkV "Einwände") "äußern") ; -- status=guess, src=wikt status=guess, src=wikt
lin protest_V = junkV (mkV "Einspruch") "erheben" | junkV (mkV "Einwände") "äußern" ; -- status=guess, src=wikt status=guess, src=wikt
lin roll_N = mkN "das&nbsp;Larsen-System" "die&nbsp;Larsen-Systeme" neuter | mkN "das&nbsp;Larsen-System" "die&nbsp;Larsen-Systeme" neuter ; -- status=guess status=guess
lin stop_N = stopper_N ; -- status=guess
lin assistant_N = variants{} ; -- 
lin deaf_A = mk3A "taub" "tauber" "taubste" | mkA "gehörlos" ; -- status=guess status=guess
lin constituency_N = mkN "Wahlkreis" masculine ; -- status=guess
lin continuous_A = regA "kontinuierlich" | regA "stetig" ; -- status=guess status=guess
lin concert_N = mkN "Konzert" "Konzerte" neuter ; -- status=guess
lin breast_N = L.breast_N ;
lin extraordinary_A = mkA "außerordentlich" | mkA "außergewöhnlich" ; -- status=guess status=guess
lin squad_N = mkN "Gruppe" "Gruppen" feminine ; -- status=guess
lin wonder_N = mkN "Wunder" "Wunder" neuter | mkN "Mirakel" "Mirakel" neuter ; -- status=guess status=guess
lin cream_N = mkN "Frischkäse" masculine ; -- status=guess
lin tennis_N = mkN "Tennis" neuter ; -- status=guess
lin personally_Adv = variants{} ; -- 
lin communicate_V2 = mkV2 (irregV "kommunizieren" "kommuniziert" "kommunizierte" "kommunizierte" "kommuniziert") ; -- status=guess, src=wikt
lin communicate_V = irregV "kommunizieren" "kommuniziert" "kommunizierte" "kommunizierte" "kommuniziert" ; -- status=guess, src=wikt
lin pride_N = mkN "Rudel" "Rudel" neuter ; -- status=guess
lin bowl_N = mkN "Schale" "Schalen" feminine | mkN "Schüssel" feminine ; -- status=guess status=guess
lin file_V2 = mkV2 (regV "feilen") ; -- status=guess, src=wikt
lin file_V = regV "feilen" ; -- status=guess, src=wikt
lin expertise_N = mkN "Expertise" "Expertisen" feminine ; -- status=guess
lin govern_V2 = mkV2 (irregV "regulieren" "reguliert" "regulierte" "regulierte" "reguliert") ; -- status=guess, src=wikt
lin govern_V = irregV "regulieren" "reguliert" "regulierte" "regulierte" "reguliert" ; -- status=guess, src=wikt
lin leather_N = L.leather_N ;
lin observer_N = mkN "Beobachter" "Beobachter" masculine | mkN "Beobachterin" "Beobachterinnen" feminine ; -- status=guess status=guess
lin margin_N = mkN "Seitenrand" masculine ; -- status=guess
lin uncertainty_N = mkN "Unsicherheit" "Unsicherheiten" feminine ; -- status=guess
lin reinforce_V2 = mkV2 (mkV "verstärken") ; -- status=guess, src=wikt
lin ideal_N = mkN "Ideal" "Ideale" neuter ; -- status=guess
lin injure_V2 = mkV2 (irregV "verletzen" "verletzt" "verletzte" "verletzte" "verletzt") ; -- status=guess, src=wikt
lin holding_N = mkN "Holding-Gesellschaft" feminine ; -- status=guess
lin universal_A = mk3A "allgemein" "allgemeiner" "allgemeinste" | mkA "Universal-" | mk3A "universell" "universeller" "universellste" ; -- status=guess status=guess status=guess
lin evident_A = variants{} ; -- 
lin dust_N = L.dust_N ;
lin overseas_A = mkA "ausländisch" ;
lin desperate_A = mkA "verzweifelt" ; -- status=guess
lin swim_V2 = mkV2 (irregV "schwimmen" "schwimmt" "schwamm" "schwämme" "geschwommen") ; -- status=guess, src=wikt
lin swim_V = L.swim_V ;
lin occasional_A = regA "gelegentlich" | mk3A "okkasionell" "okkasioneller" "okkasionellste" ; -- status=guess status=guess
lin trouser_N = variants{} ; -- 
lin surprisingly_Adv = mkAdv "überraschend" ; -- status=guess
lin register_N = mkN "Register" "Register" neuter ; -- status=guess
lin album_N = mkN "Album" "Alben" neuter ; -- status=guess
lin guideline_N = mkN "Richtlinie" "Richtlinien" feminine ; -- status=guess
lin disturb_V2 = mkV2 (mkV "stören") ; -- status=guess, src=wikt
lin amendment_N = mkN "Änderung" feminine | mkN "Gesetzesänderung" feminine ; -- status=guess status=guess
lin architectMasc_N = reg2N "Architekt" "Architekten" masculine;
lin objection_N = mkN "Beanstandung" feminine ; -- status=guess
lin chart_N = mkN "Karte" "Karten" feminine ; -- status=guess
lin cattle_N = mkN "Vieh" neuter ; -- status=guess
lin doubt_VS = mkVS (mkV "bezweifeln" | regV "zweifeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin doubt_V2 = mkV2 (mkV "bezweifeln" | regV "zweifeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin react_V = irregV "reagieren" "reagiert" "reagierte" "reagierte" "reagiert" ; -- status=guess, src=wikt
lin consciousness_N = mkN "Bewusstsein" neuter ; -- status=guess
lin right_Interj = mkInterj "nicht wahr?" | mkInterj "oder?" ; -- status=guess status=guess
lin purely_Adv = variants{} ; -- 
lin tin_N = mkN "Büchse" feminine | mkN "Konservenbüchse" feminine | mkN "Blechbüchse" feminine | dose_N | mkN "Konservendose" "Konservendosen" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin tube_N = mkN "Rohr" "Rohre" neuter | mkN "Röhre" feminine ; -- status=guess status=guess
lin fulfil_V2 = mkV2 (mkV "erfüllen") ; -- status=guess, src=wikt
lin commonly_Adv = mkAdv "häufig" ; -- status=guess
lin sufficiently_Adv = variants{} ; -- 
lin coin_N = mkN "Chip" "Chips" masculine ; -- status=guess
lin frighten_V2 = mkV2 (irregV "erschrecken" "erschreckt" "erschreckte" "erschreckte" "erschreckt" | regV "schrecken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grammar_N = L.grammar_N ;
lin diary_N = mkN "Tagebuch" "Tagebücher" neuter ; -- status=guess
lin flesh_N = mkN "Fleisch" neuter ; -- status=guess
lin summary_N = mkN "Zusammenfassung" ; -- status=guess
lin infant_N = mkN "Säugling" masculine | baby_N ; -- status=guess status=guess
lin stir_V2 = mkV2 (mkV "pfannenrühren") ; -- status=guess, src=wikt
lin stir_V = mkV "pfannenrühren" ; -- status=guess, src=wikt
lin storm_N = mkN "Sturm-und-Drang-Zeit" "Sturm-und-Drang-Zeiten" feminine ; -- status=guess
lin mail_N = mkN "Kettenpanzer" | mkN "Kettenhemd" "Kettenhemden" neuter ; -- status=guess status=guess
lin rugby_N = mkN "Rugby" masculine ; -- status=guess
lin virtue_N = mkN "Tugend" "Tugenden" feminine ; -- status=guess
lin specimen_N = exemplar_N | muster_N ; -- status=guess status=guess
lin psychology_N = mkN "Psychologie" feminine | mkN "Seelenkunde" feminine ; -- status=guess status=guess
lin paint_N = mkN "Farbe" "Farben" feminine | lack_N ; -- status=guess status=guess
lin constraint_N = mkN "Einschränkung" feminine | mkN "Beschränkung" feminine ; -- status=guess status=guess
lin trace_V2 = variants{} ; -- 
lin trace_V = variants{} ; -- 
lin privilege_N = mkN "Privileg" neuter ; -- status=guess
lin completion_N = mkN "Vervollständigung" feminine ; -- status=guess
lin progress_V2 = variants{} ; -- 
lin progress_V = variants{} ; -- 
lin grade_N = grad_N | mkN "Sorte" "Sorten" feminine ; -- status=guess status=guess
lin exploit_V2 = mkV2 (prefixV "aus" (regV "nutzen") | mkV "ausbeuten") ; -- status=guess, src=wikt status=guess, src=wikt
lin import_N = mkN "Import" "Importe" masculine | mkN "Einfuhr" "Einfuhren" feminine ; -- status=guess status=guess
lin potato_N = mkN "Kartoffel" "Kartoffeln" feminine ;
lin repair_N = mkN "Reparatur" "Reparaturen" feminine ; -- status=guess
lin passion_N = mkN "Leidenschaft" "Leidenschaften" feminine | mkN "Passion" ; -- status=guess status=guess
lin seize_V2 = mkV2 (irregV "ergreifen" "ergreift" "ergriff" "ergriffe" "ergriffen" | regV "fassen") ; -- status=guess, src=wikt status=guess, src=wikt
lin seize_V = irregV "ergreifen" "ergreift" "ergriff" "ergriffe" "ergriffen" | regV "fassen" ; -- status=guess, src=wikt status=guess, src=wikt
lin low_Adv = mkAdv "tief" ; -- status=guess
lin underlying_A = regA "implizit" ; -- status=guess
lin heaven_N = mkN "Himmel" "Himmel" masculine ; -- status=guess
lin nerve_N = mkN "Nerv" "Nerven" masculine ; -- status=guess
lin park_V2 = mkV2 (regV "parken") ; -- status=guess, src=wikt
lin park_V = regV "parken" ; -- status=guess, src=wikt
lin collapse_V2 = mkV2 (mkV "zusammenbrechen" | irregV "kollabieren" "kollabiert" "kollabierte" "kollabierte" "kollabiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin collapse_V = mkV "zusammenbrechen" | irregV "kollabieren" "kollabiert" "kollabierte" "kollabierte" "kollabiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin win_N = variants{} ; -- 
lin printer_N = mkN "Drucker" "Drucker" masculine ; -- status=guess
lin coalition_N = mkN "Koalition" ; -- status=guess
lin button_N = taste_N ; -- status=guess
lin pray_V2 = mkV2 (irregV "bitten" "bittet" "bat" "bäte" "gebeten" | mkV "erbitten") ; -- status=guess, src=wikt status=guess, src=wikt
lin pray_V = irregV "bitten" "bittet" "bat" "bäte" "gebeten" | mkV "erbitten" ; -- status=guess, src=wikt status=guess, src=wikt
lin ultimate_A = regA "ultimativ" ; -- status=guess
lin venture_N = mkN "Risikokapitalgeber" masculine ; -- status=guess
lin timber_N = mkN "Holz" "Hölzer" neuter ; -- status=guess
lin companion_N = mkN "Gefährte" masculine | mkN "Gefährtin" feminine | mkN "Kompagnon" masculine ; -- status=guess status=guess status=guess
lin horror_N = mkN "Horror" masculine | mkN "Grauen" neuter ; -- status=guess status=guess
lin gesture_N = mkN "Geste" "Gesten" feminine ; -- status=guess
lin moon_N = L.moon_N ;
lin remark_VS = variants{} ; -- 
lin remark_V = variants{} ; -- 
lin clever_A = L.clever_A ;
lin van_N = transporter_N | mkN "Lieferwagen" "Lieferwagen" masculine ; -- status=guess status=guess
lin consequently_Adv = variants{} ; -- 
lin raw_A = mk3A "roh" "roher" "rohstenroheste" ; -- status=guess
lin glance_N = mkN "Blick" "Blicke" masculine | mkN "Streifblick" masculine ; -- status=guess status=guess
lin broken_A = mk3A "gebrochen" "gebrochener" "gebrochenste" | mkA "zerstört" ; -- status=guess status=guess
lin jury_N = mkN "Jury" "Jurys" feminine ; -- status=guess
lin gaze_V = prefixV "an" (regV "starren") ; -- status=guess, src=wikt
lin burst_V2 = mkV2 (regV "platzen" | regV "zerplatzen" | irregV "bersten" "birst" "barst" "bärste" "geborsten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin burst_V = regV "platzen" | regV "zerplatzen" | irregV "bersten" "birst" "barst" "bärste" "geborsten" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin charter_N = mkN "Charta" "Chartas" feminine ; -- status=guess
lin feministMasc_N = mkN "Feminist" masculine ;
lin discourse_N = mkN "Diskurs" "Diskurse" masculine ; -- status=guess
lin reflection_N = reflexion_N | mkN "Abbild" "Abbilder" neuter ; -- status=guess status=guess
lin carbon_N = mkN "Kohlenstoff" "Kohlenstoffe" masculine ; -- status=guess
lin sophisticated_A = mk3A "raffiniert" "raffinierter" "raffinierteste" ; -- status=guess
lin ban_N = mkN "Verbot" "Verbote" neuter ; -- status=guess
lin taxation_N = mkN "Besteuerung" feminine ; -- status=guess
lin prosecution_N = variants{} ; -- 
lin softly_Adv = variants{} ; -- 
lin asleep_A = mkA "use a form of the verb schlafen" | mkA "schlafend" ; -- status=guess status=guess
lin aids_N = variants{} ; -- 
lin publicity_N = mkN "Werbung" ; -- status=guess
lin departure_N = mkN "Abfahrt" "Abfahrten" feminine | mkN "Abreise" "Abreisen" feminine | mkN "Abflug" "Abflüge" masculine ; -- status=guess status=guess status=guess
lin welcome_A = mk3A "willkommen" "willkommener, willkommner" "willkommenste" ; -- status=guess
lin sharply_Adv = variants{} ; -- 
lin reception_N = mkN "Rezeption" | mkN "Empfang" "Empfänge" masculine ; -- status=guess status=guess
lin cousin_N = L.cousin_N ;
lin relieve_V2 = variants{} ; -- 
lin linguistic_A = regA "sprachlich" | regA "linguistisch" ; -- status=guess status=guess
lin vat_N = mkN "Bottich" "Bottiche" masculine | mkN "Trog" "Tröge" masculine | mkN "Wanne" "Wannen" feminine ; -- status=guess status=guess status=guess
lin forward_A = regA "vorder" ; -- status=guess
lin blue_N = mkN "Blau" "Blaus" neuter ; -- status=guess
lin multiple_A = mkA "mehrere" ; -- status=guess
lin pass_N = variants{} ; -- 
lin outer_A = mkA "äußer" ; -- status=guess
lin vulnerable_A = mkA "verletzlich" ; -- status=guess
lin patient_A = mk3A "geduldig" "geduldiger" "geduldigste" ; -- status=guess
lin evolution_N = mkN "Evolution" ; -- status=guess
lin allocate_V2 = variants{} ; -- 
lin allocate_V = variants{} ; -- 
lin creative_A = mk3A "kreativ" "kreativer" "kreativste" ; -- status=guess
lin potentially_Adv = variants{} ; -- 
lin just_A = mk3A "gerecht" "gerechter" "gerechteste" | regA "berechtigt" ; -- status=guess status=guess
lin out_Prep = variants{} ; -- 
lin judicial_A = regA "gerichtlich" | mkA "Justiz-" ; -- status=guess status=guess
lin risk_VV = mkVV (irregV "riskieren" "riskiert" "riskierte" "riskierte" "riskiert" | regV "wagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin risk_V2 = mkV2 (irregV "riskieren" "riskiert" "riskierte" "riskierte" "riskiert" | regV "wagen") ; -- status=guess, src=wikt status=guess, src=wikt
lin ideology_N = mkN "Ideologie" "Ideologien" feminine ; -- status=guess
lin smell_VA = mkVA (irregV "riechen" "riecht" "roch" "röche" "gerochen" | irregV "stinken" "stinkt" "stank" "stänke" "gestunken") ; -- status=guess, src=wikt status=guess, src=wikt
lin smell_V2 = mkV2 (irregV "riechen" "riecht" "roch" "röche" "gerochen" | irregV "stinken" "stinkt" "stank" "stänke" "gestunken") ; -- status=guess, src=wikt status=guess, src=wikt
lin smell_V = L.smell_V ;
lin agenda_N = mkN "Tagesordnung" ; -- status=guess
lin transport_V2 = mkV2 (regV "transportieren" | mkV "befördern") ; -- status=guess, src=wikt status=guess, src=wikt
lin illegal_A = mk3A "illegal" "illegaler" "illegalste" | mkA "rechtswidrig" ; -- status=guess status=guess
lin chicken_N = mkN "Huhn" "Hühner" neuter | mkN "Hähnchen" neuter | mkN "Hühnchen" neuter | mkN "Küchlein" neuter ; -- status=guess status=guess status=guess status=guess
lin plain_A = mk3A "schlicht" "schlichter" "schlichteste" ; -- status=guess
lin innovation_N = mkN "Innovation" ; -- status=guess
lin opera_N = mkN "Oper" "Opern" feminine | mkN "Opernhaus" "Opernhäuser" neuter ; -- status=guess status=guess
lin lock_N = mkN "Lock" masculine ; -- status=guess
lin grin_V = regV "grinsen" ; -- status=guess, src=wikt
lin shelf_N = mkN "Lagerfähigkeit" feminine | mkN "Lagerbeständigkeit" feminine | mkN "Haltbarkeit" feminine ; -- status=guess status=guess status=guess
lin pole_N = mkN "Poledance" masculine | mkN "Stangentanz" masculine ; -- status=guess status=guess
lin punishment_N = mkN "Bestrafung" ; -- status=guess
lin strict_A = mk3A "streng" "strenger" "strengste" ; -- status=guess
lin wave_V2 = mkV2 (regV "wedeln") ; -- status=guess, src=wikt
lin wave_V = regV "wedeln" ; -- status=guess, src=wikt
lin inside_N = mkN "Innenseite" "Innenseiten" feminine | mkN "Inneres" neuter ; -- status=guess status=guess
lin carriage_N = mkN "Remise" feminine ; -- status=guess
lin fit_A = mk3A "sexy" "sexyer" "sexyste" | mk3A "scharf" "schärfer" "schärfste" | mkA "heiß" ; -- status=guess status=guess status=guess
lin conversion_N = mkN "Umwandlung" "Umwandlungen" feminine ; -- status=guess
lin hurry_V = mkReflV "beeilen" | irregV "eilen" "eilt" "eilte" "eilte" "eilt" ; -- status=guess, src=wikt status=guess, src=wikt
lin essay_N = mkN "Versuch" "Versuche" masculine ; -- status=guess
lin integration_N = mkN "Integration" ; -- status=guess
lin resignation_N = mkN "Rücktritt" masculine ; -- status=guess
lin treasury_N = mkN "Schatzkammer" "Schatzkammern" feminine ; -- status=guess
lin traveller_N = mkN "Reisender" masculine | mkN "Reisende" feminine ; -- status=guess status=guess
lin chocolate_N = mkN "Schokoriegel" "Schokoriegel" masculine ; -- status=guess
lin assault_N = mkN "Anschlag" "Anschläge" masculine ; -- status=guess
lin schedule_N = mkN "Termin" "Termine" masculine | mkN "Programm" "Programme" neuter | mkN "Zeitplan" masculine ; -- status=guess status=guess status=guess
lin undoubtedly_Adv = mkAdv "zweifellos" ; -- status=guess
lin twin_N = mkN "Zwilling" "Zwillinge" masculine ; -- status=guess
lin format_N = mkN "Format" "Formate" neuter ; -- status=guess
lin murder_V2 = mkV2 (irregV "ermorden" "ermordet" "ermordete" "ermordete" "ermordet") ; -- status=guess, src=wikt
lin sigh_VS = mkVS (regV "seufzen") ; -- status=guess, src=wikt
lin sigh_V2 = mkV2 (regV "seufzen") ; -- status=guess, src=wikt
lin sigh_V = regV "seufzen" ; -- status=guess, src=wikt
lin sellerMasc_N = mkN "Verkäufer" masculine; -- status=guess status=guess
lin lease_N = mkN "Pacht" "Pachten" feminine ; -- status=guess
lin bitter_A = mkA "verbittert" ; -- status=guess
lin double_V2 = mkV2 (mkV "kontrieren") ; -- status=guess, src=wikt
lin double_V = mkV "kontrieren" ; -- status=guess, src=wikt
lin ally_N = mkN "Alliierter" masculine | mkN "Alliierte" feminine ; -- status=guess status=guess
lin stake_N = mkN "Pfahl" "Pfähle" masculine | mkN "Pflock" "Pflöcke" masculine ; -- status=guess status=guess
lin processing_N = mkN "Verarbeitung" feminine ; -- status=guess
lin informal_A = mk3A "informell" "informeller" "informellste" ; -- status=guess
lin flexible_A = mk3A "flexibel" "flexibler" "flexibelste" | mkA "dehnbar" | mk3A "weich" "weicher" "weichste" ; -- status=guess status=guess status=guess
lin cap_N = L.cap_N ;
lin stable_A = mk3A "stabil" "stabiler" "stabilste" ; -- status=guess
lin till_Subj = variants{} ; -- 
lin sympathy_N = mkN "Sympathie" "Sympathien" feminine ; -- status=guess
lin tunnel_N = mkN "Tunnel" masculine | mkN "Stollen" "Stollen" masculine ; -- status=guess status=guess
lin pen_N = L.pen_N ;
lin instal_V = variants{} ; -- 
lin suspend_V2 = mkV2 (prefixV "auf" I.heben_V | prefixV "aus" (irregV "setzen" "setzt" "setzte" "setzte" "gesetzt") | mkV "aufschieben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin suspend_V = prefixV "auf" I.heben_V | prefixV "aus" (irregV "setzen" "setzt" "setzte" "setzte" "gesetzt") | mkV "aufschieben" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin blow_N = mkN "Schlag" "Schläge" masculine ; -- status=guess
lin wander_V = mkV "abschweifen" ; -- status=guess, src=wikt
lin notably_Adv = variants{} ; -- 
lin disappoint_V2 = mkV2 (mkV "enttäuschen") ; -- status=guess, src=wikt
lin wipe_V2 = L.wipe_V2 ;
lin wipe_V = mkV "löschen" ; -- status=guess, src=wikt
lin folk_N = mkN "Volk" "Völker" neuter ; -- status=guess
lin attraction_N = mkN "Attraktion" ; -- status=guess
lin disc_N = mkN "Scheibe" "Scheiben" feminine ; -- status=guess
lin inspire_V2V = mkV2V (mkV "einhauchen" | mkV "einflößen" | irregV "begeistern" "begeistert" "begeisterte" "begeisterte" "begeistert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin inspire_V2 = mkV2 (mkV "einhauchen" | mkV "einflößen" | irregV "begeistern" "begeistert" "begeisterte" "begeisterte" "begeistert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin machinery_N = mkN "Maschinerie" "Maschinerien" feminine ; -- status=guess
lin undergo_V2 = variants{} ; -- 
lin nowhere_Adv = mkAdv "nirgendwo" | mkAdv "nirgends" ; -- status=guess status=guess
lin inspector_N = variants{} ; -- 
lin wise_A = mk3A "weise" "weiser" "weiseste" | mk3A "klug" "klüger" "klügste" ; -- status=guess status=guess
lin balance_V2 = mkV2 (regV "balancieren") ; -- status=guess, src=wikt
lin balance_V = regV "balancieren" | junkV (mkV "im") "Gleichgewicht halten" ; -- status=guess, src=wikt status=guess, src=wikt
lin purchaser_N = variants{} ; -- 
lin resort_N = mkN "Kurort" masculine | mkN "Resort" "Resorts" neuter ; -- status=guess status=guess
lin pop_N = mkN "Pop" feminine ;
lin organ_N = mkN "Organspender" "Organspender" masculine | mkN "Organspenderin" "Organspenderinnen" feminine ; -- status=guess status=guess
lin ease_V2 = mkV2 (mkV "lindern") ; -- status=guess, src=wikt
lin ease_V = mkV "lindern" ; -- status=guess, src=wikt
lin friendship_N = mkN "Freundschaft" "Freundschaften" feminine ; -- status=guess
lin deficit_N = mkN "Defizit" "Defizite" neuter ; -- status=guess
lin dear_N = mkN "Liebchen" "Liebchen" neuter | mkN "Liebste" feminine | mkN "Liebster" masculine | mkN "Teuerste" feminine | mkN "Teuerster" masculine ; -- status=guess status=guess status=guess status=guess status=guess
lin convey_V2 = mkV2 (mkV "befördern") ; -- status=guess, src=wikt
lin reserve_V2 = mkV2 (irregV "reservieren" "reserviert" "reservierte" "reservierte" "reserviert" | regV "buchen" | mkV "vormerken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reserve_V = irregV "reservieren" "reserviert" "reservierte" "reservierte" "reserviert" | regV "buchen" | mkV "vormerken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin planet_N = L.planet_N ;
lin frequent_A = mkA "häufig" ; -- status=guess
lin loose_A = mk3A "indiskret" "indiskreter" "indiskreteste" | mk3A "lose" "loser" "loseste" ; -- status=guess status=guess
lin intense_A = mk3A "intensiv" "intensiver" "intensivste" ; -- status=guess
lin retail_A = variants{} ; -- 
lin wind_V = mkV "zurückspulen" | mkV "rückspulen" ; -- status=guess, src=wikt status=guess, src=wikt
lin lost_A = mkA "verirrt" ; -- status=guess
lin grain_N = mkN "Korn" "Körner" neuter ; -- status=guess
lin particle_N = mkN "Teilchenbeschleuniger" "Teilchenbeschleuniger" masculine ; -- status=guess
lin destruction_N = mkN "Zerstörung" feminine | mkN "Vernichtung" ; -- status=guess status=guess
lin witness_V2 = mkV2 (mkV "bezeugen") ; -- status=guess, src=wikt
lin witness_V = mkV "bezeugen" ; -- status=guess, src=wikt
lin pit_N = box_N ; -- status=guess
lin registration_N = mkN "Registrierung" | mkN "Anmeldung" ; -- status=guess status=guess
lin conception_N = mkN "Empfängnis" neuter ; -- status=guess
lin steady_A = regA "stetig" ; -- status=guess
lin rival_N = mkN "Gegner" "Gegner" masculine | mkN "Rivale" "Rivalen" masculine | mkN "Konkurrent" "Konkurrenten" masculine ; -- status=guess status=guess status=guess
lin steam_N = mkN "Dampfkessel" masculine ; -- status=guess
lin back_A = mkA "abgelegen" ; -- status=guess
lin chancellor_N = mkN "Kanzler" "Kanzler" masculine ; -- status=guess
lin crash_V = mkV "abstürzen" ; -- status=guess, src=wikt
lin belt_N = mkN "Gurt" "Gurte" masculine ; -- status=guess
lin logic_N = mkN "Logik" "Logiken" feminine ; -- status=guess
lin premium_N = variants{} ; -- 
lin confront_V2 = mkV2 (irregV "konfrontieren" "konfrontiert" "konfrontierte" "konfrontierte" "konfrontiert" | regV "begegnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin precede_V2 = variants{} ; -- 
lin experimental_A = regA "experimentell" ; -- status=guess
lin alarm_N = mkN "Wecker" "Wecker" masculine ; -- status=guess
lin rational_A = mk3A "rational" "rationaler" "rationalste" ; -- status=guess
lin incentive_N = mkN "Bonus" masculine ; -- status=guess
lin roughly_Adv = variants{} ; -- 
lin bench_N = bank_N ; -- status=guess
lin wrap_V2 = mkV2 (regV "wickeln" | prefixV "ein" (regV "wickeln") | prefixV "ein" (regV "packen") | mkV "hüllen" | mkV "umhüllen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wrap_V = regV "wickeln" | prefixV "ein" (regV "wickeln") | prefixV "ein" (regV "packen") | mkV "hüllen" | mkV "umhüllen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin regarding_Prep = variants{} ; -- 
lin inadequate_A = regA "unangemessen" | mkA "unzulänglich" ; -- status=guess status=guess
lin ambition_N = mkN "Ehrgeiz" masculine | mkN "Ambition"; -- status=guess status=guess
lin since_Adv = mkAdv "seit wann" ; -- status=guess
lin fate_N = mkN "Schicksal" "Schicksale" neuter ; -- status=guess
lin vendor_N = mkN "Verkäufer" masculine | mkN "Verkäuferin" feminine ; -- status=guess status=guess
lin stranger_N = mkN "Fremder" masculine | mkN "Ausländer" masculine ; -- status=guess status=guess
lin spiritual_A = regA "geistig" ; -- status=guess
lin increasing_A = variants{} ; -- 
lin anticipate_VV = mkVV (mkV "voraussehen") | mkVV (mkV "vorausahnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin anticipate_VS = mkVS (mkV "voraussehen") | mkVS (mkV "vorausahnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin anticipate_V2 = mkV2 (mkV "voraussehen") | mkV2 (mkV "vorausahnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin anticipate_V = mkV "voraussehen" | mkV "vorausahnen" ; -- status=guess, src=wikt status=guess, src=wikt
lin logical_A = mk3A "logisch" "logischer" "logischste" ; -- status=guess
lin fibre_N = mkN "Faser" "Fasern" feminine ; -- status=guess
lin attribute_V2 = mkV2 (prefixV "zu" (irregV "schreiben" "schreibt" "schrieb" "schrieb" "geschrieben")) ; -- status=guess, src=wikt
lin sense_VS = mkVS (prefixV "wahr" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen")) ; -- status=guess, src=wikt
lin sense_V2 = mkV2 (prefixV "wahr" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen")) ; -- status=guess, src=wikt
lin black_N = mkN "Amerikaner" "Amerikaner" masculine ; -- status=guess
lin petrol_N = variants{} ; -- 
lin maker_N = mkN "Macher" masculine | mkN "Hersteller" "Hersteller" masculine | mkN "Fabrikant" "Fabrikanten" masculine ; -- status=guess status=guess status=guess
lin generous_A = mkA "großzügig" | mkA "generös" ; -- status=guess status=guess
lin allocation_N = mkN "Zuteilung" feminine | mkN "Zuweisung" feminine ; -- status=guess status=guess
lin depression_N = mkN "Depression" ; -- status=guess
lin declaration_N = mkN "Erklärung" feminine | mkN "Deklaration" ; -- status=guess status=guess
lin spot_VS = variants{} ; -- 
lin spot_V2 = variants{} ; -- 
lin spot_V = variants{} ; -- 
lin modest_A = mk3A "bescheiden" "bescheidener" "bescheidenste" ; -- status=guess
lin bottom_A = variants{} ; -- 
lin dividend_N = mkN "Dividend" "Dividenden" masculine ; -- status=guess
lin devote_V2 = mkV2 (regV "widmen") ; -- status=guess, src=wikt
lin condemn_V2 = mkV2 (mkV "verdammen") | mkV2 (mkV "verurteilen") ; -- status=guess, src=wikt status=guess, src=wikt
lin integrate_V2 = mkV2 (irregV "integrieren" "integriert" "integrierte" "integrierte" "integriert") ; -- status=guess, src=wikt
lin integrate_V = irregV "integrieren" "integriert" "integrierte" "integrierte" "integriert" ; -- status=guess, src=wikt
lin pile_N = mkN "Haufen" "Haufen" masculine | mkN "Stoß" masculine | mkN "Stapel" "Stapel" masculine ;
lin identification_N = mkN "Bezeichnung" ; -- status=guess
lin acute_A = mk3A "spitz" "spitzer" "spitzeste" ; -- status=guess
lin barely_Adv = mkAdv "kaum" ; -- status=guess
lin providing_Subj = variants{} ; -- 
lin directive_N = mkN "Anweisung" | mkN "Anordnung" | mkN "Befehl" "Befehle" masculine | mkN "Direktive" "Direktiven" feminine ; -- status=guess status=guess status=guess status=guess
lin bet_VS = mkVS (irregV "wetten" "wettet" "wettete" "wettete" "gewettet") ; -- status=guess, src=wikt
lin bet_V2 = mkV2 (irregV "wetten" "wettet" "wettete" "wettete" "gewettet") ; -- status=guess, src=wikt
lin bet_V = irregV "wetten" "wettet" "wettete" "wettete" "gewettet" ; -- status=guess, src=wikt
lin modify_V2 = mkV2 (mkV "ändern" | mkV "abändern" | regV "modifizieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin bare_A = regA "bar" | mk3A "nackt" "nackter" "nackteste" ; -- status=guess status=guess
lin swear_VV = mkVV (regV "schimpfen" | regV "fluchen") ; -- status=guess, src=wikt status=guess, src=wikt
lin swear_V2 = mkV2 (regV "schimpfen" | regV "fluchen") ; -- status=guess, src=wikt status=guess, src=wikt
lin swear_V = regV "schimpfen" | regV "fluchen" ; -- status=guess, src=wikt status=guess, src=wikt
lin final_N = mkN "finale Klasse" feminine ; -- status=guess
lin accordingly_Adv = mkAdv "dementsprechend" ; -- status=guess
lin valid_A = mkA "gültig" ; -- status=guess
lin wherever_Adv = variants{} ; -- 
lin mortality_N = mkN "Sterblichkeit" "Sterblichkeiten" feminine ; -- status=guess
lin medium_N = mkN "Medium" "Medien" neuter ; -- status=guess
lin silk_N = mkN "Seide" "Seiden" feminine ; -- status=guess
lin funeral_N = mkN "Bestattung" | mkN "Beerdigung" | mkN "Begräbnis" neuter ; -- status=guess status=guess status=guess
lin depending_A = variants{} ; -- 
lin cow_N = L.cow_N ;
lin correspond_V2 = variants{}; -- irregV "entsprechen" "entsprecht" "entsprach" "entspräche" "entsprochen" | irregV "korrespondieren" "korrespondiert" "korrespondierte" "korrespondierte" "korrespondiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin correspond_V = irregV "entsprechen" "entsprecht" "entsprach" "entspräche" "entsprochen" | irregV "korrespondieren" "korrespondiert" "korrespondierte" "korrespondierte" "korrespondiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin cite_V2 = variants{} ; -- 
lin classic_A = mk3A "klassisch" "klassischer" "klassischste" ; -- status=guess
lin inspection_N = mkN "Inspektion" | mkN "Prüfung" feminine ; -- status=guess status=guess
lin calculation_N = variants{} ; -- 
lin rubbish_N = mkN "Abfall" "Abfälle" masculine | mkN "Müll" masculine ; -- status=guess status=guess
lin minimum_N = mkN "Minimum" "Minima" neuter ; -- status=guess
lin hypothesis_N = mkN "Hypothese" "Hypothesen" feminine ; -- status=guess
lin youngster_N = variants{} ; -- 
lin slope_N = mkN "Steigung" | hang_N ; -- status=guess status=guess
lin patch_N = mkN "Patch" masculine ; -- status=guess
lin invitation_N = mkN "Einladung" | mkN "Einladen" neuter ; -- status=guess status=guess
lin ethnic_A = regA "ethnisch" ; -- status=guess
lin federation_N = mkN "Föderation" feminine | mkN "Bund" "Bünde" masculine ; -- status=guess status=guess
lin duke_N = mkN "Großherzog" masculine ; -- status=guess
lin wholly_Adv = variants{} ; -- 
lin closure_N = mkN "Closure" | mkN "Funktionsabschluss" masculine ; -- status=guess status=guess
lin dictionary_N = mkN "assoziatives Datenfeld" neuter ; -- status=guess
lin withdrawal_N = mkN "Entzug" masculine ; -- status=guess
lin automatic_A = mk3A "automatisch" "automatischer" "automatischste" ; -- status=guess
lin liable_A = mkA "neigend" | mkA "unterworfen" ; -- status=guess status=guess
lin cry_N = mkN "Weinen" neuter ; -- status=guess
lin slow_V2 = mkV2 (irregV "verlangsamen" "verlangsamt" "verlangsamte" "verlangsamte" "verlangsamt") ; -- status=guess, src=wikt
lin slow_V = irregV "verlangsamen" "verlangsamt" "verlangsamte" "verlangsamte" "verlangsamt" ; -- status=guess, src=wikt
lin borough_N = mkN "Bezirk" "Bezirke" masculine | mkN "Gemeinde" "Gemeinden" feminine ; -- status=guess status=guess
lin well_A = mk3A "gesund" "gesünder" "gesündeste" ; -- status=guess
lin suspicion_N = mkN "Verdacht" masculine | mkN "Argwohn" masculine ; -- status=guess status=guess
lin portrait_N = mkN "Portrait" neuter | mkN "Porträt" neuter ; -- status=guess status=guess
lin local_N = mkN "Lokal" "Lokale" neuter ; -- status=guess
lin jew_N = variants{} ; -- 
lin fragment_N = mkN "Satzfragment" "Satzfragmente" neuter ; -- status=guess
lin revolutionary_A = mkA "revolutionär" ; -- status=guess
lin evaluate_V2 = mkV2 (irregV "evaluieren" "evaluiert" "evaluierte" "evaluierte" "evaluiert") ; -- status=guess, src=wikt
lin evaluate_V = irregV "evaluieren" "evaluiert" "evaluierte" "evaluierte" "evaluiert" ; -- status=guess, src=wikt
lin competitor_N = mkN "Wettbewerbsteilnehmer" masculine ; -- status=guess
lin sole_A = regA "einzig" ; -- status=guess
lin reliable_A = mkA "verlässlich" | mkA "zuverlässig" ; -- status=guess status=guess
lin weigh_V2 = mkV2 (mkV "abwägen") ; -- status=guess, src=wikt
lin weigh_V = mkV "abwägen" ; -- status=guess, src=wikt
lin medieval_A = regA "mittelalterlich" ; -- status=guess
lin clinic_N = mkN "Klinik" "Kliniken" feminine ; -- status=guess
lin shine_V2 = mkV2 (irregV "leuchten" "leuchtet" "leuchtete" "leuchtete" "geleuchtet" | irregV "scheinen" "scheint" "schien" "schiene" "geschienen") ; -- status=guess, src=wikt status=guess, src=wikt
lin shine_V = irregV "leuchten" "leuchtet" "leuchtete" "leuchtete" "geleuchtet" | irregV "scheinen" "scheint" "schien" "schiene" "geschienen" ; -- status=guess, src=wikt status=guess, src=wikt
lin knit_V2 = mkV2 (junkV (mkV "die") "Stirn runzeln") ; -- status=guess, src=wikt
lin knit_V = junkV (mkV "die") "Stirn runzeln" ; -- status=guess, src=wikt
lin complexity_N = mkN "Komplexität" feminine | mkN "Schwierigkeit" "Schwierigkeiten" feminine ; -- status=guess status=guess
lin remedy_N = mkN "Heilmittel" "Heilmittel" neuter ; -- status=guess
lin fence_N = mkN "Zaun" "Zäune" masculine | hag_N | mkN "Fence" masculine ;
lin bike_N = L.bike_N ;
lin freeze_V2 = mkV2 (irregV "erstarren" "erstarrt" "erstarrte" "erstarrte" "erstarrt") ; -- status=guess, src=wikt
lin freeze_V = L.freeze_V ;
lin eliminate_V2 = mkV2 (irregV "eliminieren" "eliminiert" "eliminierte" "eliminierte" "eliminiert" | mkV "zerstören") ; -- status=guess, src=wikt status=guess, src=wikt
lin interior_N = mkN "Innenwinkel" masculine ; -- status=guess
lin intellectual_A = mk3A "intellektuell" "intellektueller" "intellektuellste" ; -- status=guess
lin established_A = variants{} ; -- 
lin voter_N = mkN "Wähler" masculine | mkN "Wählerin" feminine ; -- status=guess status=guess
lin garage_N = mkN "Garage" "Garagen" feminine ; -- status=guess
lin era_N = mkN "Ära" feminine | mkN "Epoche" "Epochen" feminine ; -- status=guess status=guess
lin pregnant_A = regA "schwanger" | mkA "trächtig" ; -- status=guess status=guess
lin plot_N = mkN "Handlung" ; -- status=guess
lin greet_V2 = mkV2 (mkV "begrüßen") | mkV2 (mkV "grüßen") ; -- status=guess, src=wikt status=guess, src=wikt
lin electrical_A = variants{} ; -- 
lin lie_N = mkN "Lügendetektor" masculine ; -- status=guess
lin disorder_N = mkN "Unordnung" feminine ; -- status=guess
lin formally_Adv = variants{} ; -- 
lin excuse_N = mkN "Ausrede" "Ausreden" feminine ; -- status=guess
lin socialist_A = regA "sozialistisch" ; -- status=guess
lin cancel_V2 = mkV2 (mkV "ausstreichen") ; -- status=guess, src=wikt
lin cancel_V = mkV "ausstreichen" ; -- status=guess, src=wikt
lin harm_N = mkN "Schaden" "Schäden" masculine ; -- status=guess
lin excess_N = mkN "Überschuss" masculine | mkN "Übermaß" neuter ; -- status=guess status=guess
lin exact_A = mk3A "exakt" "exakter" "exakteste" | mk3A "genau" "genauer" "genausten, genaueste" ; -- status=guess status=guess
lin oblige_V2V = mkV2V (irregV "verpflichten" "verpflichtet" "verpflichtete" "verpflichtete" "verpflichtet") ; -- status=guess, src=wikt
lin oblige_V2 = mkV2 (irregV "verpflichten" "verpflichtet" "verpflichtete" "verpflichtete" "verpflichtet") ; -- status=guess, src=wikt
lin accountant_N = mkN "Buchhalter" masculine | mkN "Buchhalterin" feminine ; -- status=guess status=guess
lin mutual_A = regA "wechselseitig" | regA "gegenseitig" | mkA "beiderseitig" ; -- status=guess status=guess status=guess
lin fat_N = L.fat_N ;
lin volunteerMasc_N = mkN "Freiwillige" feminine ; -- status=guess
lin laughter_N = mkN "Gelächter" neuter | mkN "Lachen" neuter ; -- status=guess status=guess
lin trick_N = mkN "Trick" "Tricks" masculine | mkN "Kunststück" neuter ; -- status=guess status=guess
lin load_V2 = mkV2 (irregV "laden" "lädt" "lud" "lüde" "geladen") ; -- status=guess, src=wikt
lin load_V = irregV "laden" "lädt" "lud" "lüde" "geladen" ; -- status=guess, src=wikt
lin disposal_N = mkN "Beseitigung" feminine | mkN "Entsorgung" ;
lin taxi_N = mkN "Taxi" "Taxis" neuter | mkN "Taxe" "Taxen" feminine ; -- status=guess status=guess
lin murmur_V2 = mkV2 (regV "murmeln") ; -- status=guess, src=wikt
lin murmur_V = regV "murmeln" ; -- status=guess, src=wikt
lin tonne_N = mkN "Tonne" "Tonnen" feminine ; -- status=guess
lin spell_V2 = mkV2 (mkV "klarmachen") ; -- status=guess, src=wikt
lin spell_V = mkV "klarmachen" ; -- status=guess, src=wikt
lin clerk_N = mkN "Büroangestellte" masculine | mkN "Angestellte" masculine | mkN "Buchhalter" masculine | mkN "Bürokaufmann" masculine | mkN "Bürokauffrau" feminine | mkN "Gerichtsschreiber" masculine | mkN "Schreiber" "Schreiber" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin curious_A = mk3A "neugierig" "neugieriger" "neugierigste" ; -- status=guess
lin satisfactory_A = mk3A "befriedigend" "befriedigender" "befriedigendste" ; -- status=guess
lin identical_A = regA "identisch" ; -- status=guess
lin applicant_N = mkN "Bewerber" "Bewerber" masculine | mkN "Bewerberin" feminine ; -- status=guess status=guess
lin removal_N = mkN "Entlassung" ; -- status=guess
lin processor_N = mkN "Prozessor" "Prozessoren" masculine ; -- status=guess
lin cotton_N = mkN "Baumwolle" "Baumwollen" feminine ; -- status=guess
lin reverse_V2 = variants{} ; -- 
lin reverse_V = variants{} ; -- 
lin hesitate_VV = mkVV (mkV "zögern" | regV "stammeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin hesitate_V = mkV "zögern" | regV "stammeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin professor_N = mkN "Professor" "Professoren" masculine | mkN "Professorin" feminine ; -- status=guess status=guess
lin admire_V2 = mkV2 (regV "bewundern" | irregV "verehren" "verehrt" "verehrte" "verehrte" "verehrt" | mkV "hochschätzen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin namely_Adv = mkAdv "und zwar" | mkAdv "nämlich" ; -- status=guess status=guess
lin electoral_A = variants{} ; -- 
lin delight_N = mkN "Freude" "Freuden" feminine | mkN "Entzückung" feminine | mkN "Wohlgefallen" neuter ; -- status=guess status=guess status=guess
lin urgent_A = mk3A "dringend" "dringender" "dringendste" | mkA "dringlich" ; -- status=guess status=guess
lin prompt_V2V = variants{} ; -- 
lin prompt_V2 = variants{} ; -- 
lin mate_N = mkN "Kumpel" masculine ; -- status=guess
lin mate_2_N = variants{} ; -- 
lin mate_1_N = variants{} ; -- 
lin exposure_N = mkN "Kontakt" "Kontakte" masculine | mkN "Einwirkung" "Einwirkungen" feminine ; -- status=guess status=guess
lin server_N = mkN "Server" "Server" masculine ; -- status=guess
lin distinctive_A = variants{} ; -- 
lin marginal_A = variants{} ; -- 
lin structural_A = variants{} ; -- 
lin rope_N = L.rope_N ;
lin miner_N = mkN "Bergmann" masculine | mkN "Bergarbeiter" "Bergarbeiter" masculine ; -- status=guess status=guess
lin entertainment_N = mkN "Unterhaltung" ; -- status=guess
lin acre_N = mkN "Morgen" "Morgen" masculine | mkN "Acker" "Äcker" masculine | mkN "Joch" "Joche" neuter | mkN "Joch" "Joche" neuter | mkN "Juchart" masculine ;
lin pig_N = mkN "Bulle" "Bullen" masculine ; -- status=guess
lin encouraging_A = variants{} ; -- 
lin guarantee_N = mkN "Garantie" "Garantien" feminine ; -- status=guess
lin gear_N = gang_N ; -- status=guess
lin anniversary_N = mkN "Jahrestag" "Jahrestage" masculine ; -- status=guess
lin past_Adv = variants{} ; -- 
lin ceremony_N = mkN "Zeremonie" "Zeremonien" feminine ; -- status=guess
lin rub_V2 = L.rub_V2 ;
lin rub_V = irregV "reiben" "reibt" "rieb" "riebe" "gerieben" ; -- status=guess, src=wikt
lin monopoly_N = mkN "Monopol" "Monopole" neuter ; -- status=guess
lin left_N = mkN "Linkshändigkeit" feminine | mkN "Sinistralität" feminine ; -- status=guess status=guess
lin flee_V2 = mkV2 (irregV "fliehen" "flieht" "floh" "flöhe" "geflohen" | mkV "entfliehen" | mkV "flüchten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin flee_V = irregV "fliehen" "flieht" "floh" "flöhe" "geflohen" | mkV "entfliehen" | mkV "flüchten" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin yield_V2 = mkV2 (prefixV "auf" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") | prefixV "ab" (irregV "werfen" "werft" "warf" "würfe" "geworfen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin discount_N = mkN "Rabatt" "Rabatte" masculine | mkN "Preisnachlass" masculine ; -- status=guess status=guess
lin above_A = mkA "überdurchschnittlich" ; -- status=guess
lin uncle_N = mkN "Onkel" "Onkel" masculine | mkN "Oheim" "Oheime" masculine ; -- status=guess status=guess
lin audit_N = mkN "Überprüfung" feminine ; -- status=guess
lin advertisement_N = mkN "Anzeige" "Anzeigen" feminine | mkN "Werbung" | mkN "Annonce" "Annoncen" feminine | mkN "Reklameanzeige" feminine ; -- status=guess status=guess status=guess status=guess
lin explosion_N = mkN "Explosion" ; -- status=guess
lin contrary_A = variants{} ; -- 
lin tribunal_N = mkN "Tribunal" "Tribunale" neuter ; -- status=guess
lin swallow_V2 = mkV2 (regV "schlucken") ; -- status=guess, src=wikt
lin swallow_V = regV "schlucken" ; -- status=guess, src=wikt
lin typically_Adv = variants{} ; -- 
lin fun_A = mk3A "lustig" "lustiger" "lustigste" | mkA "spaßig" | mkA "to be fun: Spaß machen" ; -- status=guess status=guess status=guess
lin rat_N = mkN "Ratte" "Ratten" feminine ; -- status=guess
lin cloth_N = mkN "Kleidungsstück" neuter ; -- status=guess
lin cable_N = mkN "Kabel" "Kabel" neuter | mkN "Leitung" ; -- status=guess status=guess
lin interrupt_V2 = mkV2 (irregV "unterbrechen" "unterbrecht" "unterbrach" "unterbräche" "unterbrochen") ; -- status=guess, src=wikt
lin interrupt_V = irregV "unterbrechen" "unterbrecht" "unterbrach" "unterbräche" "unterbrochen" ; -- status=guess, src=wikt
lin crash_N = mkN "Absturz" "Abstürze" masculine ; -- status=guess
lin flame_N = mkN "Flammenphotometrie" feminine ; -- status=guess
lin controversy_N = mkN "Kontroverse" "Kontroversen" feminine ; -- status=guess
lin rabbit_N = mkN "Kaninchen" "Kaninchen" neuter | mkN "Karnickel" "Karnickel" neuter | mkN "Schlappohr" neuter ; -- status=guess status=guess status=guess
lin everyday_A = mkA "Alltags-" ; -- status=guess
lin allegation_N = mkN "Behauptung" ; -- status=guess
lin strip_N = mkN "Gogo-Bar" feminine | mkN "Strip-Club" masculine ; -- status=guess status=guess
lin stability_N = mkN "Stabilität" feminine ; -- status=guess
lin tide_N = mkN "Gezeite" ; ----n {p}" | tide_N ; -- status=guess status=guess
lin illustration_N = mkN "Illustration" ; -- status=guess
lin insect_N = mkN "Insekt" "Insekten" neuter | mkN "Kerbtier" neuter | mkN "Kerf" "Kerfe" masculine ; -- status=guess status=guess status=guess
lin correspondent_N = variants{} ; -- 
lin devise_V2 = mkV2 (junkV (mkV "letztwillig") "vermachen") | mkV2 (junkV (mkV "durch") "Testament verfügen") ; -- status=guess, src=wikt status=guess, src=wikt
lin determined_A = mk3A "entschlossen" "entschlossener" "entschlossenste" | mk3A "resolut" "resoluter" "resoluteste" | mk3A "beherzt" "beherzter" "beherzteste" | mk3A "bestimmt" "bestimmter" "bestimmteste" | mk3A "entschieden" "entschiedener" "entschiedenste" ; -- status=guess status=guess status=guess status=guess status=guess
lin brush_V2 = mkV2 (regV "pinseln" | prefixV "auf" (irregV "tragen" "tragt" "trug" "trüge" "getragen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin brush_V = regV "pinseln" | prefixV "auf" (irregV "tragen" "tragt" "trug" "trüge" "getragen") ; -- status=guess, src=wikt status=guess, src=wikt
lin adjustment_N = mkN "Anpassung" | mkN "Regulierung" feminine ; -- status=guess status=guess
lin controversial_A = mk3A "umstritten" "umstrittener" "umstrittenste" | mk3A "kontrovers" "kontroverser" "kontroverseste" ; -- status=guess status=guess
lin organic_A = regA "organisch" ; -- status=guess
lin escape_N = mkN "Flucht" "Fluchten" feminine ; -- status=guess
lin thoroughly_Adv = mkAdv "gründlich" ; -- status=guess
lin interface_N = mkN "Schnittstelle" "Schnittstellen" feminine ; -- status=guess
lin historic_A = mk3A "historisch" "historischer" "historischste" ; -- status=guess
lin collapse_N = mkN "Kollaps" "Kollapse" masculine ; -- status=guess
lin temple_N = mkN "Schläfe" feminine ; -- status=guess
lin shade_N = mkN "Schatten" "Schatten" masculine ; -- status=guess
lin craft_N = mkN "Handwerker" "Handwerker" masculine ; -- status=guess
lin nursery_N = mkN "erziehen" ; -- status=guess
lin piano_N = mkN "Klavier" "Klaviere" neuter | mkN "Piano" "Pianos" neuter ; -- status=guess status=guess
lin desirable_A = mkA "erwünscht" ; -- status=guess
lin assurance_N = variants{} ; -- 
lin jurisdiction_N = mkN "Jurisdiktion" ; -- status=guess
lin advertise_V2 = mkV2 (mkV "inserieren" | irregV "werben" "werbt" "warb" "würbe" "geworben") ; -- status=guess, src=wikt status=guess, src=wikt
lin advertise_V = mkV "inserieren" | irregV "werben" "werbt" "warb" "würbe" "geworben" ; -- status=guess, src=wikt status=guess, src=wikt
lin bay_N = mkN "Golf" "Golfe" masculine | mkN "Bucht" "Buchten" feminine | mkN "Meerbusen" masculine ; -- status=guess status=guess status=guess
lin specification_N = mkN "Spezifikation" "Spezifikationen" feminine ; -- status=guess
lin disability_N = mkN "Behinderung" ; -- status=guess
lin presidential_A = variants{} ; -- 
lin arrest_N = mkN "Verhaftung" | mkN "Festnahme" "Festnahmen" feminine ; -- status=guess status=guess
lin unexpected_A = mk3A "unerwartet" "unerwarteter" "unerwartetste" ; -- status=guess
lin switch_N = mkN "Schalter" "Schalter" masculine ; -- status=guess
lin penny_N = mkN "Hochrad" neuter ; -- status=guess
lin respect_V2 = mkV2 (irregV "respektieren" "respektiert" "respektierte" "respektierte" "respektiert") ; -- status=guess, src=wikt
lin celebration_N = mkN "Feier" "Feiern" feminine ; -- status=guess
lin gross_A = mk3A "dick" "dicker" "dickste" ; -- status=guess
lin aid_V2 = mkV2 (irregV "helfen" "helft" "half" "hälfe" "geholfen") ; -- status=guess, src=wikt
lin aid_V = irregV "helfen" "helft" "half" "hälfe" "geholfen" ; -- status=guess, src=wikt
lin superb_A = mkA "großartig" ;
lin process_V2 = mkV2 (irregV "verarbeiten" "verarbeitet" "verarbeitete" "verarbeite" "verarbeitet") ; -- status=guess, src=wikt
lin process_V = irregV "verarbeiten" "verarbeitet" "verarbeitete" "verarbeite" "verarbeitet" ; -- status=guess, src=wikt
lin innocent_A = mkA "unschuldig" ; -- status=guess
lin leap_V2 = mkV2 (irregV "springen" "springt" "sprang" "spränge" "gesprungen" | irregV "einen" "eint" "einte" "einte" "geeint" | mkV "hüpfen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin leap_V = irregV "springen" "springt" "sprang" "spränge" "gesprungen" | irregV "einen" "eint" "einte" "einte" "geeint" | mkV "hüpfen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin colony_N = mkN "Kolonie" "Kolonien" feminine ; -- status=guess
lin wound_N = mkN "Wunde" "Wunden" feminine | mkN "Verletzung" ; -- status=guess status=guess
lin hardware_N = mkN "Eisenware" ; ---- n {f} {p}" ; -- status=guess
lin satellite_N = mkN "Satellit" "Satelliten" masculine ; -- status=guess
lin float_V = L.float_V ;
lin bible_N = mkN "Bibel" "Bibeln" feminine ; -- status=guess
lin statistical_A = regA "statistisch" ; -- status=guess
lin marked_A = variants{} ; -- 
lin hire_V2V = mkV2V (mkV "anwerben" | prefixV "an" (irregV "stellen" "stellt" "stellte" "stellte" "gestellt") | prefixV "ein" (regV "stellen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin hire_V2 = mkV2 (mkV "anwerben" | prefixV "an" (irregV "stellen" "stellt" "stellte" "stellte" "gestellt") | prefixV "ein" (regV "stellen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cathedral_N = mkN "Kathedrale" "Kathedralen" feminine | mkN "Dom" "Dome" masculine ; -- status=guess status=guess
lin motive_N = mkN "Motiv" "Motive" neuter | mkN "Beweggrund" masculine ; -- status=guess status=guess
lin correct_VS = mkVS (prefixV "aus" (regV "bessern") | irregV "korrigieren" "korrigiert" "korrigierte" "korrigierte" "korrigiert" | mkV "richtigstellen" | regV "berichtigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin correct_V2 = mkV2 (prefixV "aus" (regV "bessern") | irregV "korrigieren" "korrigiert" "korrigierte" "korrigierte" "korrigiert" | mkV "richtigstellen" | regV "berichtigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin correct_V = prefixV "aus" (regV "bessern") | irregV "korrigieren" "korrigiert" "korrigierte" "korrigierte" "korrigiert" | mkV "richtigstellen" | regV "berichtigen" | junkV (mkV "nachregeln") "Tech." ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin gastric_A = regA "gastrisch" ; -- status=guess
lin raid_N = mkN "Razzia" "Razzien" feminine | mkN "Überfall" masculine ; -- status=guess status=guess
lin comply_V2 = mkV2 (prefixV "ein" (regV "willigen")) ; -- status=guess, src=wikt
lin comply_V = prefixV "ein" (regV "willigen") ; -- status=guess, src=wikt
lin accommodate_V2 = mkV2 (prefixV "an" (regV "passen")) ; -- status=guess, src=wikt
lin accommodate_V = prefixV "an" (regV "passen") ; -- status=guess, src=wikt
lin mutter_V2 = mkV2 (regV "murmeln") ; -- status=guess, src=wikt
lin mutter_V = regV "murmeln" ; -- status=guess, src=wikt
lin induce_V2 = variants{} ; -- 
lin trap_V2 = mkV2 (irregV "fangen" "fangt" "fing" "finge" "gefangen") ; -- status=guess, src=wikt
lin trap_V = irregV "fangen" "fangt" "fing" "finge" "gefangen" ; -- status=guess, src=wikt
lin invasion_N = mkN "Invasion" | mkN "Überfall" masculine ; -- status=guess status=guess
lin humour_N = mkN "Laune" "Launen" feminine | humor_N | mkN "Stimmung" ; -- status=guess status=guess status=guess
lin bulk_N = mkN "Großteil" masculine ; -- status=guess
lin traditionally_Adv = variants{} ; -- 
lin commission_V2V = mkV2V (junkV (mkV "in") "Auftrag geben") ; -- status=guess, src=wikt
lin commission_V2 = mkV2 (compoundV "in Auftrag" I.geben_V) ;
lin upstairs_Adv = mkAdv "treppauf" | mkAdv "oben" | mkAdv "nach rechts" | mkAdv "herauf" ; -- status=guess status=guess status=guess status=guess
lin translate_V2 = mkV2 (mkV "übertragen") ; -- status=guess, src=wikt
lin translate_V = mkV "übertragen" ; -- status=guess, src=wikt
lin rhythm_N = mkN "Rhythm and Blues" neuter ; -- status=guess
lin emission_N = mkN "Ausstoß" | mkN "Emission" ; -- status=guess status=guess
lin collective_A = variants{} ; -- 
lin transformation_N = mkN "Transformation" ; -- status=guess
lin battery_N = mkN "Batterie" "Batterien" feminine ; -- status=guess
lin stimulus_N = mkN "Auslöseimpuls" masculine ; -- status=guess
lin naked_A = mk3A "nackt" "nackter" "nackteste" ; -- status=guess
lin white_N = mkN "Weiße" feminine ;
lin menu_N = mkN "Menüleiste" feminine ; -- status=guess
lin toilet_N = mkN "Klo" "Klos" neuter | mkN "Toilette" "Toiletten" feminine ; -- status=guess status=guess
lin butter_N = L.butter_N ;
lin surprise_V2V = mkV2V (mkV "überraschen") ; -- status=guess, src=wikt
lin surprise_V2 = mkV2 (mkV "überraschen") ; -- status=guess, src=wikt
lin needle_N = mkN "Nadellager" neuter ; -- status=guess
lin effectiveness_N = mkN "Wirksamkeit" feminine ; -- status=guess
lin accordance_N = mkN "Übereinstimmung" feminine ; -- status=guess
lin molecule_N = mkN "Molekül" neuter ; -- status=guess
lin fiction_N = mkN "Fiktion" ; -- status=guess
lin learning_N = mkN "Gelehrsamkeit" feminine | mkN "Kenntnis" "Kenntnisse" feminine ; -- status=guess status=guess
lin statute_N = mkN "Gesetzesrecht" neuter ; -- status=guess
lin reluctant_A = mkA "zögernd" ; -- status=guess
lin overlook_V2 = mkV2 (mkV "überblicken") ; -- status=guess, src=wikt
lin junction_N = mkN "Kreuzung" | mkN "Knotenpunkt" "Knotenpunkte" masculine ; -- status=guess status=guess
lin necessity_N = mkN "Notwendigkeit" "Notwendigkeiten" feminine | mkN "Nezessität" feminine ; -- status=guess status=guess
lin nearby_A = regA "in" ; -- status=guess
lin experienced_A = mkA "erfahren" ; -- status=guess
lin lorry_N = variants{} ; -- 
lin exclusive_A = mkA "ausschließlich" ; -- status=guess
lin graphics_N = mkN "Grafikkarte" "Grafikkarten" feminine ; -- status=guess
lin stimulate_V2 = mkV2 (irregV "stimulieren" "stimuliert" "stimulierte" "stimulierte" "stimuliert") ; -- status=guess, src=wikt
lin warmth_N = mkN "Wärme" feminine ; -- status=guess
lin therapy_N = mkN "Therapie" "Therapien" feminine ; -- status=guess
lin convenient_A = mk3A "bequem" "bequemer" "bequemste" | mk3A "einfach" "einfacher" "einfachste" | regA "gelegen" | mkA "genehm" | mkA "günstig" | mk3A "passend" "passender" "passendste" | mk3A "praktisch" "praktischer" "praktischste" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin cinema_N = mkN "Film" "Filme" masculine ; -- status=guess
lin domain_N = mkN "Domain" "Domains" feminine | mkN "Domäne" feminine ; -- status=guess status=guess
lin tournament_N = mkN "Turnier" "Turniere" neuter ; -- status=guess
lin doctrine_N = mkN "Doktrin" "Doktrinen" feminine ; -- status=guess
lin sheer_A = mkA "bloß" | regA "schier" ; -- status=guess status=guess
lin proposition_N = mkN "Satz" "Sätze" masculine ; -- status=guess
lin grip_N = mkN "Griff" "Griffe" masculine ; -- status=guess
lin widow_N = mkN "Hurenkind" "Hurenkinder" neuter ; -- status=guess
lin discrimination_N = mkN "Diskriminierung" | mkN "Schlechterstellung" feminine ; -- status=guess status=guess
lin bloody_Adv = variants{} ; -- 
lin ruling_A = variants{} ; -- 
lin fit_N = mkN "Paßform" feminine ; -- status=guess
lin nonetheless_Adv = mkAdv "nichtsdestoweniger" | mkAdv "nichtsdestotrotz" ; -- status=guess status=guess
lin myth_N = mkN "Mythos" "Mythen" masculine ; -- status=guess
lin episode_N = mkN "Episode" "Episoden" feminine ; -- status=guess
lin drift_V2 = mkV2 (irregV "driften" "driftet" "driftete" "drifte" "gedriftet") ; -- status=guess, src=wikt
lin drift_V = irregV "driften" "driftet" "driftete" "drifte" "gedriftet" ; -- status=guess, src=wikt
lin assert_VS = mkVS (irregV "versichern" "versichert" "versicherte" "versicherte" "versichert" | mkV "zusichern") ; -- status=guess, src=wikt status=guess, src=wikt
lin assert_V2 = mkV2 (irregV "versichern" "versichert" "versicherte" "versicherte" "versichert" | mkV "zusichern") ; -- status=guess, src=wikt status=guess, src=wikt
lin assert_V = irregV "versichern" "versichert" "versicherte" "versicherte" "versichert" | mkV "zusichern" ; -- status=guess, src=wikt status=guess, src=wikt
lin terrace_N = mkN "Terrasse" "Terrassen" feminine ; -- status=guess
lin uncertain_A = mkA "unbeständig" ; -- status=guess
lin twist_V2 = mkV2 (mkV "verdrehen") ; -- status=guess, src=wikt
lin insight_N = mkN "Einsicht" "Einsichten" feminine ; -- status=guess
lin undermine_V2 = mkV2 (irregV "unterminieren" "unterminiert" "unterminierte" "unterminiere" "unterminiert") ; -- status=guess, src=wikt
lin tragedy_N = mkN "Tragödie" feminine ; -- status=guess
lin enforce_V2 = mkV2 (prefixV "durch" (regV "setzen")) ; -- status=guess, src=wikt
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin march_V2 = mkV2 (junkV (mkV "in") "den Krieg ziehen") ; -- status=guess, src=wikt
lin march_V = junkV (mkV "in") "den Krieg ziehen" ; -- status=guess, src=wikt
lin leaflet_N = mkN "Faltblatt" "Faltblätter" neuter | mkN "Broschüre" feminine | mkN "Faltprospekt" neuter | mkN "Flugblatt" "Flugblätter" neuter ; -- status=guess status=guess status=guess status=guess
lin fellow_A = variants{} ; -- 
lin object_V2 = mkV2 (junkV (mkV "dagegen") "sein" | junkV (mkV "Einwände") "haben" | prefixV "ein" (regV "wenden")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin object_V = junkV (mkV "dagegen") "sein" | junkV (mkV "Einwände") "haben" | prefixV "ein" (regV "wenden") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pond_N = mkN "der&nbsp;Damenflügel" "die&nbsp;Damenflügel" masculine ; -- status=guess
lin adventure_N = mkN "Abenteuer" "Abenteuer" neuter | mkN "Wagnis" "Wagnisse" neuter ; -- status=guess status=guess
lin diplomatic_A = mk3A "diplomatisch" "diplomatischer" "diplomatischste" ; -- status=guess
lin mixed_A = regA "gemischt" ; -- status=guess
lin rebel_N = mkN "Rebell" "Rebellen" masculine | mkN "Aufrührer" masculine ; -- status=guess status=guess
lin equity_N = mkN "Gerechtigkeit" "Gerechtigkeiten" feminine ; -- status=guess
lin literally_Adv = mkAdv "wörtlich" | mkAdv "buchstäblich" ; -- status=guess status=guess
lin magnificent_A = regA "ausgezeichnet" ; -- status=guess
lin loyalty_N = mkN "Treue" feminine | mkN "Loyalität" feminine ; -- status=guess status=guess
lin tremendous_A = mkA "beträchtlich" | mkA "außerordentlich" ; -- status=guess status=guess
lin airline_N = mkN "Fluggesellschaft" "Fluggesellschaften" feminine ; -- status=guess
lin shore_N = mkN "Ufer-Wolfstrapp" "Ufer-Wolfstrappe" masculine ; -- status=guess
lin restoration_N = mkN "Restaurierung" | mkN "Wiederherstellung" feminine | mkN "Restauration" ; -- status=guess status=guess status=guess
lin physically_Adv = mkAdv "physisch" ; -- status=guess
lin render_V2 = mkV2 (mkV "rendern") ; -- status=guess, src=wikt
lin institutional_A = variants{} ; -- 
lin emphasize_VS = mkVS (regV "betonen") ; -- status=guess, src=wikt
lin emphasize_V2 = mkV2 (regV "betonen") ; -- status=guess, src=wikt
lin mess_N = mkN "Messe" "Messen" feminine ; -- status=guess
lin commander_N = mkN "Befehlshaber" "Befehlshaber" masculine | mkN "Kommandeur" masculine ; -- status=guess status=guess
lin straightforward_A = mk3A "aufrichtig" "aufrichtiger" "aufrichtigste" | mk3A "einfach" "einfacher" "einfachste" | mk3A "offen" "offener" "offenste" ; -- status=guess status=guess status=guess
lin singer_N = mkN "Sänger" masculine | mkN "Sängerin" feminine ; -- status=guess status=guess
lin squeeze_V2 = L.squeeze_V2 ;
lin squeeze_V = mkV "ausdrücken" | mkV "ausquetschen" ; -- status=guess, src=wikt status=guess, src=wikt
lin full_time_A = variants{} ; -- 
lin breed_V2 = mkV2 (mkV "brüten") ; -- status=guess, src=wikt
lin breed_V = mkV "brüten" ; -- status=guess, src=wikt
lin successor_N = mkN "Nachfolger" "Nachfolger" masculine | mkN "Nachfolgerin" feminine ; -- status=guess status=guess
lin triumph_N = mkN "Triumph" "Triumphe" masculine ; -- status=guess
lin heading_N = mkN "Kurs" "Kurse" masculine ; -- status=guess
lin mathematics_N = mkN "Mathematik" feminine ; -- status=guess
lin laugh_N = mkN "Lachen" neuter ; -- status=guess
lin clue_N = mkN "Anhaltspunkt" "Anhaltspunkte" masculine | mkN "Hinweis" "Hinweise" masculine ; -- status=guess status=guess
lin still_A = mk3A "still" "stiller" "stillste" ; -- status=guess
lin ease_N = mkN "Bequemlichkeit" "Bequemlichkeiten" feminine ; -- status=guess
lin specially_Adv = variants{} ; -- 
lin biological_A = mkA "leiblich" | regA "biologisch" ; -- status=guess status=guess
lin forgive_V2 = mkV2 (irregV "vergeben" "vergebt" "vergab" "vergäbe" "vergeben") ; -- status=guess, src=wikt
lin forgive_V = irregV "vergeben" "vergebt" "vergab" "vergäbe" "vergeben" ; -- status=guess, src=wikt
lin trustee_N = mkN "Treuhänder" masculine | mkN "Treuhänderin" feminine ; -- status=guess status=guess
lin photo_N = mkN "Foto" "Fotos" neuter | mkN "Bild" "Bilder" neuter ; -- status=guess status=guess
lin fraction_N = mkN "Bruch" "Brüche" masculine ; -- status=guess
lin chase_V2 = mkV2 (regV "jagen" | irregV "verfolgen" "verfolgt" "verfolgte" "verfolgte" "verfolgt") ; -- status=guess, src=wikt status=guess, src=wikt
lin chase_V = regV "jagen" | irregV "verfolgen" "verfolgt" "verfolgte" "verfolgte" "verfolgt" ; -- status=guess, src=wikt status=guess, src=wikt
lin whereby_Adv = mkAdv "wodurch" ; -- status=guess
lin mud_N = mkN "Schlamm" "Schlämme" masculine | mkN "Kot" masculine ; -- status=guess status=guess
lin pensioner_N = mkN "Rentner" "Rentner" masculine | mkN "Rentnerin" "Rentnerinnen" feminine ; -- status=guess status=guess
lin functional_A = mk3A "funktional" "funktionaler" "funktionalste" | mkA "funktions-" | regA "funktionell" ; -- status=guess status=guess status=guess
lin copy_V2 = mkV2 (irregV "kopieren" "kopiert" "kopierte" "kopierte" "kopiert") ; -- status=guess, src=wikt
lin copy_V = irregV "kopieren" "kopiert" "kopierte" "kopierte" "kopiert" ; -- status=guess, src=wikt
lin strictly_Adv = variants{} ; -- 
lin desperately_Adv = mkAdv "verzweifelt" ; -- status=guess
lin await_V2 = mkV2 (irregV "erwarten" "erwartet" "erwartete" "erwarte" "erwartet" | regV "harren") ; -- status=guess, src=wikt status=guess, src=wikt
lin coverage_N = variants{} ; -- 
lin wildlife_N = mkN "Tierwelt" "Tierwelten" feminine | mkN "Fauna" "Faunen" feminine ; -- status=guess status=guess
lin indicator_N = mkN "Zeiger" "Zeiger" masculine ; -- status=guess
lin lightly_Adv = mkAdv "leicht" ; -- status=guess
lin hierarchy_N = mkN "Hierarchie" "Hierarchien" feminine ; -- status=guess
lin evolve_V2 = variants{} ; -- 
lin evolve_V = variants{} ; -- 
lin mechanical_A = mk3A "mechanisch" "mechanischer" "mechanischste" ; -- status=guess
lin expert_A = variants{} ; -- 
lin creditor_N = mkN "Gläubiger" masculine ; -- status=guess
lin capitalist_N = mkN "Kapitalist" "Kapitalisten" masculine ; -- status=guess
lin essence_N = mkN "Wesen" "Wesen" neuter ; -- status=guess
lin compose_V2 = mkV2 (mkV "zusammenstellen" | regV "bilden") ; -- status=guess, src=wikt status=guess, src=wikt
lin compose_V = mkV "zusammenstellen" | regV "bilden" ; -- status=guess, src=wikt status=guess, src=wikt
lin mentally_Adv = mkAdv "geistig" | mkAdv "psychisch" | mkAdv "mental" ; -- status=guess status=guess status=guess
lin gaze_N = variants{} ; -- 
lin seminar_N = mkN "Seminar" "Seminare" neuter ; -- status=guess
lin target_V2V = variants{} ; -- 
lin target_V2 = variants{} ; -- 
lin label_V3 = mkV3 (mkV "etikettieren") ; -- status=guess, src=wikt
lin label_V2 = mkV2 (mkV "etikettieren") ; -- status=guess, src=wikt
lin label_V = mkV "etikettieren" ; -- status=guess, src=wikt
lin fig_N = mkN "Feige" "Feigen" feminine ; -- status=guess
lin continent_N = mkN "Kontinent" "Kontinente" masculine | mkN "Erdteil" "Erdteile" masculine ; -- status=guess status=guess
lin chap_N = mkN "Kerl" "Kerle" masculine | mkN "Typ" "Typen" masculine ; -- status=guess status=guess
lin flexibility_N = mkN "Flexibilität" feminine ; -- status=guess
lin verse_N = strophe_N | mkN "Vers" "Verse" masculine ; -- status=guess status=guess
lin minute_A = mk3A "winzig" "winziger" "winzigste" ; -- status=guess
lin whisky_N = variants{} ; -- 
lin equivalent_A = mkA "äquivalent" ; -- status=guess
lin recruit_V2 = mkV2 (irregV "rekrutieren" "rekrutiert" "rekrutierte" "rekrutierte" "rekrutiert") ; -- status=guess, src=wikt
lin recruit_V = irregV "rekrutieren" "rekrutiert" "rekrutierte" "rekrutierte" "rekrutiert" ; -- status=guess, src=wikt
lin echo_V2 = mkV2 (mkV "widerhallen" | regV "wiederholen" | mkV "zurückwerfen" | regV "hallen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin echo_V = mkV "widerhallen" | regV "wiederholen" | mkV "zurückwerfen" | regV "hallen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin unfair_A = mkA "unfair" ; -- status=guess
lin launch_N = start_N ; -- status=guess
lin cupboard_N = mkN "Schrank" "Schränke" masculine ; -- status=guess
lin bush_N = mkN "Busch" "Büsche" masculine ; -- status=guess
lin shortage_N = variants{} ; -- 
lin prominent_A = mk3A "prominent" "prominenter" "prominenteste" ; -- status=guess
lin merger_N = fusion_N | mkN "Firmenzusammenschluss" masculine | mkN "Zusammenschluss" "Zusammenschlüsse" masculine ; -- status=guess status=guess status=guess
lin command_V2 = mkV2 (regV "beherrschen") ; -- status=guess, src=wikt
lin command_V = regV "beherrschen" ; -- status=guess, src=wikt
lin subtle_A = mkA "scharfsinnig" | mkA "ausgetüftelt" | mk3A "schlau" "schlauer" "schlaueste" ; -- status=guess status=guess status=guess
lin capital_A = mkA "großartig" ; -- status=guess
lin gang_N = mkN "Bande" "Banden" feminine | mkN "Rotte" "Rotten" feminine ; -- status=guess status=guess
lin fish_V2 = mkV2 (regV "fischen" | regV "angeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin fish_V = regV "fischen" | regV "angeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin unhappy_A = mkA "unglücklich" ; -- status=guess
lin lifetime_N = mkN "Leben" "Leben" neuter | mkN "Lebensdauer" "Lebensdauern" feminine | mkN "Lebenszeit" "Lebenszeiten" feminine ; -- status=guess status=guess status=guess
lin elite_N = mkN "Elite" "Eliten" feminine | mkN "Auslese" "Auslesen" feminine | mkN "Oberschicht" "Oberschichten" feminine | mkN "Führungsschicht" feminine | mkN "Spitzengruppe" feminine | mkN "Spitze" "Spitzen" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin refusal_N = mkN "Ablehnung" | mkN "Weigerung" feminine | mkN "Verweigerung" ; -- status=guess status=guess status=guess
lin finish_N = mkN "Ende" "Enden" neuter ; -- status=guess
lin aggressive_A = mk3A "aggressiv" "aggressiver" "aggressivste" | mkA "angriffslustig" ; -- status=guess status=guess
lin superior_A = mkA "höher" | mkA "höherstehend" ; -- status=guess status=guess
lin landing_N = mkN "Anlegeplatz" masculine ; -- status=guess
lin exchange_V2 = mkV2 (mkV "umtauschen") ; -- status=guess, src=wikt
lin debate_V2 = mkV2 (irregV "debattieren" "debattiert" "debattierte" "debattierte" "debattiert") ; -- status=guess, src=wikt
lin debate_V = irregV "debattieren" "debattiert" "debattierte" "debattierte" "debattiert" ; -- status=guess, src=wikt
lin educate_V2 = variants{} ; -- 
lin separation_N = mkN "Trennung" ; -- status=guess
lin productivity_N = mkN "Produktivität" feminine | mkN "Leistungsfähigkeit" feminine ; -- status=guess status=guess
lin initiate_V2 = mkV2 (irregV "beginnen" "beginnt" "begann" "begänne" "begonnen" | mkV "anstoßen" | mkV "einführen" | irregV "initiieren" "initiiert" "initiierte" "initiierte" "initiiert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin probability_N = mkN "Wahrscheinlichkeit" "Wahrscheinlichkeiten" feminine ; -- status=guess
lin virus_N = variants{} ; -- 
lin reporterMasc_N = reg2N "Reporter" "Reporter" masculine;
lin fool_N = mkN "der&nbsp;Damenflügel" "die&nbsp;Damenflügel" masculine ; -- status=guess
lin pop_V2 = mkV2 (prefixV "auf" (regV "tauchen") | prefixV "auf" (regV "kreuzen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin capitalism_N = mkN "Kapitalismus" masculine ; -- status=guess
lin painful_A = mk3A "schmerzhaft" "schmerzhafter" "schmerzhafteste" ; -- status=guess
lin correctly_Adv = variants{} ; -- 
lin complex_N = mkN "Komplex" "Komplexe" masculine ; -- status=guess
lin rumour_N = variants{} ; -- 
lin imperial_A = regA "kaiserlich" ; -- status=guess
lin justification_N = mkN "Rechtfertigung" | mkN "Begründung" feminine ; -- status=guess status=guess
lin availability_N = mkN "Vorhandensein" neuter | mkN "Verfügbarkeit" feminine ; -- status=guess status=guess
lin spectacular_A = mkA "spektakulär" ; -- status=guess
lin remain_N = mkN "Überrest" masculine ;
lin ocean_N = mkN "Ozean" "Ozeane" masculine ; -- status=guess
lin cliff_N = mkN "Klippe" "Klippen" feminine | mkN "Felsen" "Felsen" masculine ; -- status=guess status=guess
lin sociology_N = mkN "Soziologie" feminine | mkN "Gesellschaftskunde" feminine ; -- status=guess status=guess
lin sadly_Adv = mkAdv "traurig" | mkAdv "traurigerweise" ; -- status=guess status=guess
lin missile_N = mkN "Flugkörper" masculine ; -- status=guess
lin situate_V2 = variants{} ; -- 
lin artificial_A = mkA "künstlich" ; -- status=guess
lin apartment_N = L.apartment_N ;
lin provoke_V2 = mkV2 (irregV "provozieren" "provoziert" "provozierte" "provozierte" "provoziert") ; -- status=guess, src=wikt
lin oral_A = regA "oral" ; -- status=guess
lin maximum_N = mkN "Maximum" "Maxima" neuter ; -- status=guess
lin angel_N = mkN "Engel" "Engel" masculine ; -- status=guess
lin spare_A = mk3A "schlank" "schlanker" "schlankste" ; -- status=guess
lin shame_N = mkN "Schande" feminine ; -- status=guess
lin intelligent_A = mk3A "intelligent" "intelligenter" "intelligenteste" ; -- status=guess
lin discretion_N = variants{} ; -- 
lin businessman_N = mkN "Geschäftsmann" masculine | mkN "Unternehmer" "Unternehmer" masculine ; -- status=guess status=guess
lin explicit_A = mk3A "eindeutig" "eindeutiger" "eindeutigste" | mkA "ausdrücklich" | mk3A "deutlich" "deutlicher" "deutlichste" | mk3A "explizit" "expliziter" "expliziteste" ; -- status=guess status=guess status=guess status=guess
lin book_V2 = mkV2 (regV "bestrafen") ; -- status=guess, src=wikt
lin uniform_N = mkN "Uniform" "Uniformen" feminine ; -- status=guess
lin push_N = mkN "Schubs" "Schubse" masculine | mkN "Stoß" masculine ; -- status=guess status=guess
lin counter_N = mkN "Gegenangriff" "Gegenangriffe" masculine ; -- status=guess
lin subject_A = variants{} ; -- 
lin objective_A = mk3A "objektiv" "objektiver" "objektivste" ; -- status=guess
lin hungry_A = mk3A "hungrig" "hungriger" "hungrigste" ; -- status=guess
lin clothing_N = mkN "Kleidung" ; -- status=guess
lin ride_N = variants{} ; -- 
lin romantic_A = mk3A "romantisch" "romantischer" "romantischste" ; -- status=guess
lin attendance_N = mkN "Anwesenheit" feminine ; -- status=guess
lin part_time_A = variants{} ; -- 
lin trace_N = mkN "aufzeichnen" | mkN "aufspüren" | mkN "nachspüren" | mkN "nachziehen" | mkN "verfolgen" ; -- status=guess status=guess status=guess status=guess status=guess
lin backing_N = variants{} ; -- 
lin sensation_N = mkN "Gefühl" neuter ; -- status=guess
lin carrier_N = mkN "Carriertaube" feminine | mkN "Karriertaube" feminine | mkN "Carrier" "Carrier" masculine | mkN "Karrier" masculine ; -- status=guess status=guess status=guess status=guess
lin interest_V2 = mkV2 (irregV "interessieren" "interessiert" "interessierte" "interessierte" "interessiert") ; -- status=guess, src=wikt
lin interest_V = irregV "interessieren" "interessiert" "interessierte" "interessierte" "interessiert" ; -- status=guess, src=wikt
lin classification_N = mkN "Klassifikation" ; -- status=guess
lin classic_N = mkN "Klassiker" "Klassiker" masculine ; -- status=guess
lin beg_V2 = mkV2 (mkV "betteln") ; -- status=guess, src=wikt
lin beg_V = mkV "betteln" ; -- status=guess, src=wikt
lin appendix_N = mkN "Anhang" "Anhänge" masculine ; -- status=guess
lin doorway_N = mkN "Türöffnung" feminine ; -- status=guess
lin density_N = mkN "Dichte" "Dichten" feminine ; -- status=guess
lin working_class_A = variants{} ; -- 
lin legislative_A = variants{} ; -- 
lin hint_N = mkN "Hinweis" "Hinweise" masculine ; -- status=guess
lin shower_N = mkN "Schauer" "Schauer" masculine ; -- status=guess
lin current_N = mkN "Girokonto" neuter ; -- status=guess
lin succession_N = mkN "Thronfolge" ; -- status=guess
lin nasty_A = variants{} ; -- 
lin duration_N = mkN "Dauer" "Dauern" feminine ; -- status=guess
lin desert_N = mkN "Wüste" feminine ; -- status=guess
lin receipt_N = mkN "Empfang" "Empfänge" masculine ; -- status=guess
lin native_A = mkA "gebürtig" ; -- status=guess
lin chapel_N = mkN "Kapelle" "Kapellen" feminine ; -- status=guess
lin amazing_A = mkA "erstaunlich" | mk3A "unglaublich" "unglaublicher" "unglaublichste" | mkA "verwunderlich" ; -- status=guess status=guess status=guess
lin hopefully_Adv = mkAdv "hoffnungsvoll" ; -- status=guess
lin fleet_N = mkN "Flotte" "Flotten" feminine ; -- status=guess
lin comparable_A = regA "vergleichbar" ; -- status=guess
lin oxygen_N = mkN "Sauerstoffatom" "Sauerstoffatome" neuter ; -- status=guess
lin installation_N = mkN "Installation" feminine ; -- status=guess
lin developer_N = mkN "Entwickler" "Entwickler" masculine ; -- status=guess
lin disadvantage_N = mkN "Nachteil" "Nachteile" masculine ; -- status=guess
lin recipe_N = mkN "Rezept" "Rezepte" neuter | mkN "Kochrezept" "Kochrezepte" neuter ; -- status=guess status=guess
lin crystal_N = mkN "Kristall" "Kristalle" masculine ; -- status=guess
lin modification_N = mkN "Modifikation" ; -- status=guess
lin schedule_V2V = mkV2V (regV "planen") ; -- status=guess, src=wikt
lin schedule_V2 = mkV2 (regV "planen") ; -- status=guess, src=wikt
lin schedule_V = regV "planen" ; -- status=guess, src=wikt
lin midnight_N = mkN "Mitternacht" "Mitternächte" feminine ; -- status=guess
lin successive_A = variants{} ; -- 
lin formerly_Adv = mkAdv "früher" | mkAdv "ehemals" ; -- status=guess status=guess
lin loud_A = mk3A "laut" "lauter" "lauteste" ; -- status=guess
lin value_V2 = mkV2 (mkV "schätzen") ; -- status=guess, src=wikt
lin value_V = mkV "schätzen" ; -- status=guess, src=wikt
lin physics_N = mkN "Physik" feminine ; -- status=guess
lin truck_N = mkN "Lastauto" neuter | mkN "Laster" "Laster" neuter | mkN "Lastkraftwagen" "Lastkraftwagen" masculine | mkN "LKW" masculine | mkN "Lastwagen" "Lastwagen" masculine | mkN "Lieferwagen" "Lieferwagen" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin stroke_N = mkN "Streich" "Streiche" masculine ; -- status=guess
lin kiss_N = mkN "Kuss" "Küsse" masculine | mkN "Busserl" neuter ; -- status=guess status=guess
lin envelope_N = mkN "Hülle" feminine ; -- status=guess
lin speculation_N = mkN "Spekulation" ; -- status=guess
lin canal_N = mkN "Kanal" "Kanäle" masculine ; -- status=guess
lin unionist_N = mkN "Gewerkschaftler" "Gewerkschaftler" masculine ; -- status=guess
lin directory_N = mkN "Verzeichnis" "Verzeichnisse" neuter ; -- status=guess
lin receiver_N = mkN "Empfangsgerät" neuter | mkN "Empfänger" masculine ; -- status=guess status=guess
lin isolation_N = mkN "Isolierung" ; -- status=guess
lin fade_V2 = mkV2 (mkV "verwelken") ; -- status=guess, src=wikt
lin fade_V = mkV "verwelken" ; -- status=guess, src=wikt
lin chemistry_N = mkN "Chemie" "Chemien" feminine ; -- status=guess
lin unnecessary_A = mkA "nicht notwendig" | mkA "unnötig" ; -- status=guess status=guess
lin hit_N = mkN "Fahrerflucht" feminine ; -- status=guess
lin defenderMasc_N = reg2N "Verteidiger" "Verteidiger" masculine;
lin stance_N = mkN "Einstellung" | mkN "Positur" feminine ; -- status=guess status=guess
lin sin_N = mkN "Sünde" feminine ; -- status=guess
lin realistic_A = mk3A "realistisch" "realistischer" "realistischste" ; -- status=guess
lin socialist_N = mkN "Sozialist" "Sozialisten" masculine | mkN "Sozialistin" "Sozialistinnen" feminine ; -- status=guess status=guess
lin subsidy_N = subvention_N | mkN "Unterstützung" feminine | mkN "Subsidium" neuter ; -- status=guess status=guess status=guess
lin content_A = mk3A "zufrieden" "zufriedener" "zufriedenste" ; -- status=guess
lin toy_N = mkN "Spielzeug" "Spielzeuge" neuter ; -- status=guess
lin darling_N = mkN "Liebling" "Lieblinge" masculine | mkN "Schatz" "Schätze" masculine ; -- status=guess status=guess
lin decent_A = regA "ganz" | mkA "anständig" ; -- status=guess status=guess
lin liberty_N = mkN "Freiheit" "Freiheiten" feminine ; -- status=guess
lin forever_Adv = mkAdv "für immer" | mkAdv "ewig" | mkAdv "unaufhörlich" | mkAdv "auf" | mkAdv "für eger" ; -- status=guess status=guess status=guess status=guess status=guess
lin skirt_N = mkN "Saum" "Säume" masculine ; -- status=guess
lin coordinate_V2 = mkV2 (irregV "koordinieren" "koordiniert" "koordinierte" "koordinierte" "koordiniert") ; -- status=guess, src=wikt
lin coordinate_V = irregV "koordinieren" "koordiniert" "koordinierte" "koordinierte" "koordiniert" ; -- status=guess, src=wikt
lin tactic_N = mkN "Taktik" "Taktiken" feminine ; -- status=guess
lin influential_A = variants{} ; -- 
lin import_V2 = mkV2 (irregV "importieren" "importiert" "importierte" "importierte" "importiert" | mkV "einführen") ; -- status=guess, src=wikt status=guess, src=wikt
lin accent_N = mkN "Akzent" "Akzente" masculine ; -- status=guess
lin compound_N = mkN "Mischung" ; -- status=guess
lin bastard_N = mkN "Bastard" "Bastarde" masculine | mkN "Mistkerl" masculine | mkN "Arsch" "Ärsche" masculine ; -- status=guess status=guess status=guess
lin ingredient_N = mkN "Bestandteil" "Bestandteile" masculine | mkN "Ingredienz" "Ingredienzen" feminine | mkN "Inhaltsstoff" "Inhaltsstoffe" masculine | mkN "Zutat" "Zutaten" feminine ; -- status=guess status=guess status=guess status=guess
lin dull_A = L.dull_A ;
lin cater_V = variants{} ; -- 
lin scholar_N = mkN "Gelehrte" masculine ; -- status=guess
lin faint_A = mk3A "kraftlos" "kraftloser" "kraftloseste" | mk3A "schwach" "schwächer" "schwächste" ; -- status=guess status=guess
lin ghost_N = mkN "Gespenst" "Gespenster" neuter | mkN "Geist" neuter | mkN "Phantom" "Phantome" neuter | mkN "Spuk" masculine | mkN "Erscheinung" ; -- status=guess status=guess status=guess status=guess status=guess
lin sculpture_N = mkN "Bildhauerkunst" feminine | mkN "Skulptur" "Skulpturen" feminine ; -- status=guess status=guess
lin ridiculous_A = mkA "lächerlich" ; -- status=guess
lin diagnosis_N = mkN "Diagnose" "Diagnosen" feminine ; -- status=guess
lin delegate_N = mkN "Delegierter" masculine | mkN "Abgeordneter" masculine | mkN "Vertreter" "Vertreter" masculine ; -- status=guess status=guess status=guess
lin neat_A = nett_A | mk3A "adrett" "adretter" "adretteste" | mk3A "sauber" "sauberer" "sauberste" ; -- status=guess status=guess status=guess
lin kit_N = mkN "Ausrüstung" feminine | mkN "Satz" "Sätze" masculine ; -- status=guess status=guess
lin lion_N = mkN "Löwe" masculine | mkN "Löwin" feminine ;
lin dialogue_N = mkN "Dialogfenster" "Dialogfenster" neuter | mkN "Dialog" "Dialoge" masculine ; -- status=guess status=guess
lin repair_V2 = mkV2 (irregV "reparieren" "repariert" "reparierte" "reparierte" "repariert") ; -- status=guess, src=wikt
lin repair_V = irregV "reparieren" "repariert" "reparierte" "reparierte" "repariert" ; -- status=guess, src=wikt
lin tray_N = mkN "Tablett" "Tabletts" neuter ; -- status=guess
lin fantasy_N = mkN "Fantasie" "Fantasien" feminine ; -- status=guess
lin leave_N = mkN "Beurlaubung" feminine | mkN "Freistellung" feminine | mkN "Urlaub" "Urlaube" masculine ; -- status=guess status=guess status=guess
lin export_V2 = mkV2 (irregV "exportieren" "exportiert" "exportierte" "exportierte" "exportiert") ; -- status=guess, src=wikt
lin export_V = irregV "exportieren" "exportiert" "exportierte" "exportierte" "exportiert" ; -- status=guess, src=wikt
lin forth_Adv = variants{} ; -- 
lin lamp_N = L.lamp_N ;
lin allege_VS = mkVS (irregV "behaupten" "behauptet" "behauptete" "behaupte" "behauptet") ; -- status=guess, src=wikt
lin allege_V2 = mkV2 (irregV "behaupten" "behauptet" "behauptete" "behaupte" "behauptet") ; -- status=guess, src=wikt
lin pavement_N = mkN "Bürgersteig" masculine | mkN "Gehweg" "Gehwege" masculine | mkN "Gehsteig" "Gehsteige" masculine ; -- status=guess status=guess status=guess
lin brand_N = mkN "Marke" "Marken" feminine ; -- status=guess
lin constable_N = variants{} ; -- 
lin compromise_N = mkN "Kompromiss" masculine | mkN "Ausgleich" "Ausgleiche" masculine ; -- status=guess status=guess
lin flag_N = mkN "Flag" neuter | mkN "Markierung" "Markierungen" feminine | mkN "Kennzeichen" "Kennzeichen" neuter ; -- status=guess status=guess status=guess
lin filter_N = mkN "Filter" "Filter" masculine ; -- status=guess
lin reign_N = mkN "Herrschaft" "Herrschaften" feminine | mkN "Regentschaft" feminine ; -- status=guess status=guess
lin execute_V2 = mkV2 (prefixV "hin" (regV "richten")) ; -- status=guess, src=wikt
lin pity_N = mkN "Mitleid" neuter ; -- status=guess
lin merit_N = mkN "Verdienst" "Verdienste" masculine ; -- status=guess
lin diagram_N = mkN "Diagramm" "Diagramme" neuter ; -- status=guess
lin wool_N = mkN "Wolle" "Wollen" feminine ; -- status=guess
lin organism_N = mkN "Organismus" "Organismen" masculine ; -- status=guess
lin elegant_A = mk3A "elegant" "eleganter" "eleganteste" ; -- status=guess
lin red_N = mkN "Rotrückenbussard" masculine ; -- status=guess
lin undertaking_N = mkN "Unternehmen" "Unternehmen" neuter ; -- status=guess
lin lesser_A = mkA "weniger" | mkA "kleiner" | mkA "geringere" ; -- status=guess status=guess status=guess
lin reach_N = variants{} ; -- 
lin marvellous_A = variants{} ; -- 
lin improved_A = variants{} ; -- 
lin locally_Adv = variants{} ; -- 
lin entity_N = mkN "Wesen" "Wesen" neuter ; -- status=guess
lin rape_N = mkN "Vergewaltigung" ; -- status=guess
lin secure_A = mkA "zuverlässig" ; -- status=guess
lin descend_V2 = variants{} ; -- 
lin descend_V = variants{} ; -- 
lin backwards_Adv = mkAdv "rückwärts" ; -- status=guess
lin peer_V = mkV "spähen" ; -- status=guess, src=wikt
lin excuse_V2 = mkV2 (mkReflV "entschuldigen") ; -- status=guess, src=wikt
lin genetic_A = regA "genetisch" ; -- status=guess
lin fold_V2 = mkV2 (irregV "falten" "faltet" "faltete" "faltete" "gefaltet") ; -- status=guess, src=wikt
lin fold_V = irregV "falten" "faltet" "faltete" "faltete" "gefaltet" ; -- status=guess, src=wikt
lin portfolio_N = mkN "Mappe" "Mappen" feminine ; -- status=guess
lin consensus_N = mkN "Konsens" "Konsense" masculine | mkN "Einvernehmen" neuter ; -- status=guess status=guess
lin thesis_N = mkN "These" "Thesen" feminine ; -- status=guess
lin shop_V = prefixV "ein" (regV "kaufen") ; -- status=guess, src=wikt
lin nest_N = mkN "Vogelnest" "Vogelnester" neuter | mkN "Nest" "Nester" neuter ; -- status=guess status=guess
lin frown_V = junkV (mkV "die") "Stirn runzeln" | mkV "runzeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin builder_N = mkN "Baumeister" masculine | mkN "Erbauer" ; -- status=guess status=guess
lin administer_V2 = mkV2 (mkV "darreichen" | irregV "verabreichen" "verabreicht" "verabreichte" "verabreichte" "verabreicht") ; -- status=guess, src=wikt status=guess, src=wikt
lin administer_V = mkV "darreichen" | irregV "verabreichen" "verabreicht" "verabreichte" "verabreichte" "verabreicht" ; -- status=guess, src=wikt status=guess, src=wikt
lin tip_V2 = mkV2 (junkV (mkV "ein") "Trinkgeld geben") ; -- status=guess, src=wikt
lin tip_V = compoundV "Trinkgeld" I.geben_V ;
lin lung_N = lunge_N ; -- status=guess
lin delegation_N = mkN "Delegation" ; -- status=guess
lin outside_N = mkN "Außenseite" feminine ; -- status=guess
lin heating_N = mkN "Heizung" ; -- status=guess
lin like_Subj = variants{} ; -- 
lin instinct_N = mkN "Instinkt" "Instinkte" masculine ; -- status=guess
lin teenager_N = mkN "Jugendlicher" masculine | mkN "Jugendliche" feminine ; -- status=guess status=guess
lin lonely_A = mk3A "einsam" "einsamer" "einsamste" ; -- status=guess
lin residence_N = mkN "Aufenthaltserlaubnis" neuter | mkN "Niederlassungserlaubnis" neuter ; -- status=guess status=guess
lin radiation_N = mkN "Strahlung" | mkN "Radiation" ; -- status=guess status=guess
lin extract_V2 = mkV2 (irregV "entziehen" "entzieht" "entzog" "entzöge" "entzogen") ; -- status=guess, src=wikt
lin concession_N = mkN "Gewerbeerlaubnis" feminine ; -- status=guess
lin autonomy_N = mkN "Autonomie" "Autonomien" feminine ; -- status=guess
lin norm_N = mkN "Norm" "Normen" feminine ; -- status=guess
lin musicianMasc_N = reg2N "Musikant" "Musikanten" masculine;
lin graduate_N = mkN "Absolvent" "Absolventen" masculine | mkN "Absolventin" "Absolventinnen" feminine ; -- status=guess status=guess
lin glory_N = mkN "Ruhm" masculine ; -- status=guess
lin bear_N = mkN "Bär" masculine ; -- status=guess
lin persist_V = mkV "beharren" ; -- status=guess, src=wikt
lin rescue_V2 = mkV2 (irregV "retten" "rettet" "rettete" "rette" "gerettet") ; -- status=guess, src=wikt
lin equip_V2 = mkV2 (mkV "ausrüsten") ; -- status=guess, src=wikt
lin partial_A = mk3A "parteiisch" "parteiischer" "parteiischste" ; -- status=guess
lin officially_Adv = variants{} ; -- 
lin capability_N = variants{} ; -- 
lin worry_N = mkN "Sorge" "Sorgen" feminine ; -- status=guess
lin liberation_N = mkN "Befreiung" ; -- status=guess
lin hunt_V2 = L.hunt_V2 ;
lin hunt_V = regV "jagen" ; -- status=guess, src=wikt
lin daily_Adv = mkAdv "täglich" ; -- status=guess
lin heel_N = mkN "Kanten" "Kanten" masculine | mkN "Knapp" masculine | mkN "Knust" masculine | mkN "Ranft" masculine | mkN "Scherzl" neuter | mkN "technical terms in bakery trade: Anschnitt" masculine | mkN "Abschnitt" "Abschnitte" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin contract_V2V = mkV2V (mkV "zusammenziehen" | irregV "kontrahieren" "kontrahiert" "kontrahierte" "kontrahierte" "kontrahiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin contract_V2 = mkV2 (mkV "zusammenziehen" | irregV "kontrahieren" "kontrahiert" "kontrahierte" "kontrahierte" "kontrahiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin contract_V = mkV "zusammenziehen" | irregV "kontrahieren" "kontrahiert" "kontrahierte" "kontrahierte" "kontrahiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin update_V2 = mkV2 (regV "aktualisieren") ; -- status=guess, src=wikt
lin assign_V2V = variants{} ; -- 
lin assign_V2 = variants{} ; -- 
lin spring_V2 = mkV2 (irregV "springen" "springt" "sprang" "spränge" "gesprungen") ; -- status=guess, src=wikt
lin spring_V = irregV "springen" "springt" "sprang" "spränge" "gesprungen" ; -- status=guess, src=wikt
lin single_N = mkN "Einer" "Einer" masculine ; -- status=guess
lin commons_N = mkN "Allmende" "Allmenden" feminine ; -- status=guess
lin weekly_A = mkA "wöchentlich" ; -- status=guess
lin stretch_N = mkN "Strecken" neuter ; -- status=guess
lin pregnancy_N = mkN "Schwangerschaft" "Schwangerschaften" feminine ; -- status=guess
lin happily_Adv = mkAdv "und wenn sie nicht gestorben sind" | mkAdv "dann" ; -- status=guess status=guess
lin spectrum_N = mkN "Spektrum" "Spektren" neuter ; -- status=guess
lin interfere_V = mkV "stören" ; -- status=guess, src=wikt
lin suicide_N = mkN "Selbstmordattentäter" masculine ; -- status=guess
lin panic_N = mkN "Panik" "Paniken" feminine ; -- status=guess
lin invent_V2 = mkV2 (prefixV "aus" (irregV "denken" "denkt" "dachte" "dächte" "gedacht" | irregV "erfinden" "erfindet" "erfand" "erfände" "erfunden")) ; -- status=guess, src=wikt status=guess, src=wikt
lin invent_V = prefixV "aus" (irregV "denken" "denkt" "dachte" "dächte" "gedacht") | irregV "erfinden" "erfindet" "erfand" "erfände" "erfunden" ; -- status=guess, src=wikt status=guess, src=wikt
lin intensive_A = mk3A "intensiv" "intensiver" "intensivste" ; -- status=guess
lin damp_A = mk3A "feucht" "feuchter" "feuchteste" ; -- status=guess
lin simultaneously_Adv = mkAdv "gleichzeitig" ; -- status=guess
lin giant_N = mkN "Großer Ameisenbär" masculine ; -- status=guess
lin casual_A = mkA "gleichgültig" ; -- status=guess
lin sphere_N = mkN "Kugel" "Kugeln" feminine ; -- status=guess
lin precious_A = mkA "kostbar" | mk3A "wertvoll" "wertvoller" "wertvollste" ; -- status=guess status=guess
lin sword_N = mkN "Schwert" "Schwerter" neuter ; -- status=guess
lin envisage_V2 = mkV2 (irregV "vorstellen" "stellt" "stell" "stelle" "vorgestellt") ; -- status=guess, src=wikt
lin bean_N = mkN "Bohne" "Bohnen" feminine ; -- status=guess
lin time_V2 = mkV2 (regV "timen") ; -- status=guess, src=wikt status=guess, src=wikt
lin crazy_A = mkA "verrückt" ; -- status=guess
lin changing_A = variants{} ; -- 
lin primary_N = mkN "Handschwinge" feminine ; -- status=guess
lin concede_VS = mkVS (mkV "einräumen") | mkVS (mkV "zugestehen") ; -- status=guess, src=wikt status=guess, src=wikt
lin concede_V2 = mkV2 (mkV "einräumen") | mkV2 (mkV "zugestehen") ; -- status=guess, src=wikt status=guess, src=wikt
lin concede_V = mkV "einräumen" | mkV "zugestehen" ; -- status=guess, src=wikt status=guess, src=wikt
lin besides_Adv = mkAdv "außerdem" | mkAdv "weiterhin" | mkAdv "darüber hinaus" ; -- status=guess status=guess status=guess
lin unite_V2 = mkV2 (mkV "vereinen") ; -- status=guess, src=wikt
lin unite_V = mkV "vereinen" ; -- status=guess, src=wikt
lin severely_Adv = mkAdv "streng" ; -- status=guess
lin separately_Adv = mkAdv "getrennt" ; -- status=guess
lin instruct_V2 = variants{} ; -- 
lin insert_V2 = mkV2 (mkV "einfügen") ; -- status=guess, src=wikt
lin go_N = mkN "Grauer Lärmvogel" masculine ; -- status=guess
lin exhibit_V2 = mkV2 (regV "zeigen") ; -- status=guess, src=wikt
lin brave_A = mk3A "tapfer" "tapferer" "tapferste" | mk3A "mutig" "mutiger" "mutigste" ; -- status=guess status=guess
lin tutor_N = variants{} ; -- 
lin tune_N = mkN "Melodie" "Melodien" feminine ; -- status=guess
lin debut_N = variants{} ; -- 
lin debut_2_N = variants{} ; -- 
lin debut_1_N = variants{} ; -- 
lin continued_A = variants{} ; -- 
lin bid_V2 = mkV2 (regV "melden" | irregV "reizen" "reizt" "reizte" "reizte" "reizt") ; -- status=guess, src=wikt status=guess, src=wikt
lin bid_V = regV "melden" | irregV "reizen" "reizt" "reizte" "reizte" "reizt" ; -- status=guess, src=wikt status=guess, src=wikt
lin incidence_N = variants{} ; -- 
lin downstairs_Adv = mkAdv "unten" | mkAdv "treppab" | mkAdv "treppabwärts" | mkAdv "nach rechts" ; -- status=guess status=guess status=guess status=guess
lin cafe_N = variants{} ; -- 
lin regret_VS = mkVS (regV "bedauern" | regV "bereuen" | irregV "leidtun" "tut" "tat" "täte" "getan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin regret_V2 = mkV2 (regV "bedauern" | regV "bereuen" | irregV "leidtun" "tut" "tat" "täte" "getan") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin killer_N = mkN "Killer-Anwendung" feminine | mkN "Killer-Applikation" feminine ; -- status=guess status=guess
lin delicate_A = mk3A "empfindlich" "empfindlicher" "empfindlichste" ; -- status=guess
lin subsidiary_N = mkN "Tochterunternehmen" "Tochterunternehmen" neuter | mkN "Tochtergesellschaft" feminine ; -- status=guess status=guess
lin gender_N = mkN "Geschlecht" "Geschlechter" neuter ; -- status=guess
lin entertain_V2 = mkV2 (irregV "unterhalten" "unterhält" "unterhielt" "unterhielte" "unterhalten") ; -- status=guess, src=wikt
lin cling_V = irregV "haften" "haftet" "haftete" "haftete" "gehaftet" | regV "klammern" ; -- status=guess, src=wikt status=guess, src=wikt
lin vertical_A = regA "vertikal" | mk3A "senkrecht" "senkrechter" "senkrechteste" ; -- status=guess status=guess
lin fetch_V2 = mkV2 (regV "holen") ; -- status=guess, src=wikt
lin strip_V2 = variants{} ; -- 
lin strip_V = variants{} ; -- 
lin plead_VS = mkVS (irregV "bitten" "bittet" "bat" "bäte" "gebeten" | prefixV "an" (regV "flehen") | mkV "beschwören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plead_V2 = mkV2 (irregV "bitten" "bittet" "bat" "bäte" "gebeten" | prefixV "an" (regV "flehen") | mkV "beschwören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plead_V = irregV "bitten" "bittet" "bat" "bäte" "gebeten" | prefixV "an" (regV "flehen") | mkV "beschwören" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin duck_N = mkN "Ente" "Enten" feminine ; -- status=guess
lin breed_N = mkN "Rasse" "Rassen" feminine ; -- status=guess
lin assistant_A = mkA "helfend" | mk3A "hilfreich" "hilfreicher" "hilfreichste" ; -- status=guess status=guess
lin pint_N = mkN "Pint" neuter ; -- status=guess
lin abolish_V2 = mkV2 (irregV "vernichten" "vernichtet" "vernichtete" "vernichte" "vernichtet") ; -- status=guess, src=wikt
lin translation_N = mkN "Übersetzung" feminine | mkN "Übersetzen" neuter ; -- status=guess status=guess
lin princess_N = mkN "Prinzessin" "Prinzessinnen" feminine ; -- status=guess
lin line_V2 = mkV2 (mkReflV "eingliedern") | mkV2 (mkReflV "aufreihen") ; -- status=guess, src=wikt status=guess, src=wikt
lin line_V = mkReflV "eingliedern" | mkReflV "aufreihen" ; -- status=guess, src=wikt status=guess, src=wikt
lin excessive_A = mkA "übermäßig" | mk3A "exzessiv" "exzessiver" "exzessivsten e" ; -- status=guess status=guess
lin digital_A = regA "digital" ; -- status=guess status=guess
lin steep_A = mk3A "steil" "steiler" "steilste" ; -- status=guess
lin jet_N = mkN "Jet" "Jets" masculine | mkN "Düsenjet" masculine | mkN "Strahlflugzeug" neuter | mkN "Düsenflugzeug" neuter ; -- status=guess status=guess status=guess status=guess
lin hey_Interj = mkInterj "Hallo" ; -- status=guess
lin grave_N = grab_N ; -- status=guess
lin exceptional_A = mkA "außergewöhnlich" ; -- status=guess
lin boost_V2 = variants{} ; -- 
lin random_A = mkA "zufällig" ; -- status=guess
lin correlation_N = mkN "Korrelation" ; -- status=guess
lin outline_N = mkN "Umriss" "Umrisse" masculine | mkN "Kontur" "Konturen" feminine ; -- status=guess status=guess
lin intervene_V2V = mkV2V (prefixV "ein" I.greifen_V | irregV "intervenieren" "interveniert" "intervenierte" "intervenierte" "interveniert") ; -- status=guess, src=wikt status=guess, src=wikt
lin intervene_V = prefixV "ein" I.greifen_V | irregV "intervenieren" "interveniert" "intervenierte" "intervenierte" "interveniert" ; -- status=guess, src=wikt status=guess, src=wikt
lin packet_N = variants{} ; -- 
lin motivation_N = mkN "Motivation" ; -- status=guess
lin safely_Adv = variants{} ; -- 
lin harsh_A = mk3A "rau" "rauer" "raueste" | mk3A "harsch" "harscher" "harscheste" ; -- status=guess status=guess
lin spell_N = mkN "Rechtschreibprüfung" feminine ; -- status=guess
lin spread_N = mkN "Aufstrich" "Aufstriche" masculine ; -- status=guess
lin draw_N = mkN "Ziehung" ; -- status=guess
lin concrete_A = mkA "aus Beton" | mkA "Beton-" ; -- status=guess status=guess
lin complicated_A = mk3A "kompliziert" "komplizierter" "komplizierteste" ; -- status=guess
lin alleged_A = mkA "mutmaßlich" ; -- status=guess
lin redundancy_N = mkN "Redundanz" "Redundanzen" feminine ; -- status=guess
lin progressive_A = mkA "fortschrittlich" ; -- status=guess
lin intensity_N = mkN "Intensität" feminine ; -- status=guess
lin crack_N = mkN "Knall" "Knalle" masculine | mkN "Knacks" masculine | mkN "Krachen" neuter ; -- status=guess status=guess status=guess
lin fly_N = mkN "Fliegenpilz" "Fliegenpilze" masculine ; -- status=guess
lin fancy_V2 = mkV2 (junkV (mkV "auf") "stehen") ; -- status=guess, src=wikt
lin alternatively_Adv = mkAdv "alternativ" | mkAdv "andernfalls" | mkAdv "andererseits" | mkAdv "beziehungsweise" | mkAdv "ersatzweise" | mkAdv "hilfsweise" | mkAdv "oder aber" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin waiting_A = variants{} ; -- 
lin scandal_N = mkN "Skandal" "Skandale" masculine ; -- status=guess
lin resemble_V2 = mkV2 (mkV "ähneln" | irregV "gleichen" "gleicht" "glich" "gliche" "geglichen") ; -- status=guess, src=wikt status=guess, src=wikt
lin parameter_N = mkN "Parameter" "Parameter" masculine ; -- status=guess
lin fierce_A = mk3A "wild" "wilder" "wildeste" ; -- status=guess
lin tropical_A = mk3A "tropisch" "tropischer" "tropischste" ; -- status=guess
lin colour_V2A = variants{} ; -- 
lin colour_V2 = variants{} ; -- 
lin colour_V = variants{} ; -- 
lin engagement_N = mkN "Gefecht" "Gefechte" neuter ; -- status=guess
lin contest_N = mkN "Wettkampf" "Wettkämpfe" masculine | mkN "Wettbewerb" "Wettbewerbe" masculine | mkN "Wettstreit" "Wettstreite" masculine ; -- status=guess status=guess status=guess
lin edit_V2 = mkV2 (irregV "bearbeiten" "bearbeitet" "bearbeitete" "bearbeite" "bearbeitet" | irregV "redigieren" "redigiert" "redigierte" "redigierte" "redigiert" | irregV "edieren" "ediert" "edierte" "edierte" "ediert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin courage_N = mkN "Mut'a-Ehe" "Mut'a-Ehen" feminine ; -- status=guess
lin hip_N = mkN "Hüftknochen" masculine ; -- status=guess
lin delighted_A = mkA "erfreut" | mkA "hocherfreut" ; -- status=guess status=guess
lin sponsor_V2 = mkV2 (regV "sponsern") ; -- status=guess, src=wikt
lin carer_N = mkN "Betreuer" "Betreuer" masculine | mkN "Betreuerin" feminine ; -- status=guess status=guess
lin crack_V2 = mkV2 (junkV (mkV "scharf") "vorgehen") ; -- status=guess, src=wikt
lin substantially_Adv = mkAdv "beträchtlich" | mkAdv "erheblich" | mkAdv "substanziell" | mkAdv "wesentlich" ; -- status=guess status=guess status=guess status=guess
lin occupational_A = variants{} ; -- 
lin trainer_N = mkN "Trainer" "Trainer" masculine ; -- status=guess
lin remainder_N = mkN "Restposten" "Restposten" masculine ; -- status=guess
lin related_A = mk3A "verwandt" "verwandter" "verwandteste" ; -- status=guess
lin inherit_V2 = mkV2 (irregV "erben" "erbt" "erbte" "erbte" "geerbt") ; -- status=guess, src=wikt
lin inherit_V = irregV "erben" "erbt" "erbte" "erbte" "geerbt" ; -- status=guess, src=wikt
lin resume_V2 = mkV2 (mkV "wiederaufnehmen" | prefixV "fort" (regV "setzen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin resume_V = mkV "wiederaufnehmen" | prefixV "fort" (regV "setzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin assignment_N = variants{} ; -- 
lin conceal_V2 = mkV2 (irregV "verbergen" "verbergt" "verbarg" "verbärge" "verborgen" | mkV "verheimlichen" | irregV "verschleiern" "verschleiert" "verschleierte" "verschleierte" "verschleiert" | irregV "verschweigen" "verschweigt" "verschwieg" "verschwiege" "verschwiegen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_VS = mkVS (mkV "veröffentlichen") | mkVS (mkV "bekanntgeben") | mkVS (mkV "bekanntmachen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V2 = mkV2 (mkV "veröffentlichen") | mkV2 (mkV "bekanntgeben") | mkV2 (mkV "bekanntmachen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin disclose_V = mkV "veröffentlichen" | mkV "bekanntgeben" | mkV "bekanntmachen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin exclusively_Adv = mkAdv "ausschließlich" | mkAdv "exklusiv" ; -- status=guess status=guess
lin working_N = mkN "Ansatz" "Ansätze" masculine ; -- status=guess
lin mild_A = mk3A "mild" "milder" "mildeste" ; -- status=guess
lin chronic_A = mk3A "chronisch" "chronischer" "chronischste" ; -- status=guess
lin splendid_A = mk3A "hervorragend" "hervorragender" "hervorragendste" ; -- status=guess
lin function_V = regV "funktionieren" | irregV "arbeiten" "arbeitet" "arbeitete" "arbeite" "gearbeitet" | regV "wirken" | regV "funzen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin riderMasc_N = mkN "Reiter" "Reiter" masculine | mkN "Mitfahrer" "Mitfahrer" masculine ; -- status=guess status=guess status=guess status=guess
lin clay_N = mkN "Lehm" "Lehme" masculine | mkN "Ton" masculine ; -- status=guess status=guess
lin firstly_Adv = mkAdv "erstens" | mkAdv "an" ; -- status=guess status=guess
lin conceive_V2 = mkV2 (irregV "empfangen" "empfangt" "empfing" "empfinge" "empfangen" | junkV (mkV "schwanger") "werden") ; -- status=guess, src=wikt status=guess, src=wikt
lin conceive_V = irregV "empfangen" "empfangt" "empfing" "empfinge" "empfangen" | junkV (mkV "schwanger") "werden" ; -- status=guess, src=wikt status=guess, src=wikt
lin politically_Adv = variants{} ; -- 
lin terminal_N = mkN "Terminal" masculine neuter ; -- status=guess
lin accuracy_N = mkN "Genauigkeit" feminine | mkN "Präzision" feminine ; -- status=guess status=guess
lin coup_N = mkN "Coup" masculine ; -- status=guess
lin ambulance_N = mkN "Rettungswagen" "Rettungswagen" masculine | mkN "Krankenwagen" "Krankenwagen" masculine ; -- status=guess status=guess
lin living_N = mkN "Lebensunterhalt" masculine ; -- status=guess
lin offenderMasc_N = mkN "Täter" masculine ; -- status=guess
lin similarity_N = mkN "Ähnlichkeit" feminine ; -- status=guess
lin orchestra_N = mkN "Orchester" "Orchester" neuter ; -- status=guess
lin brush_N = mkN "Bürste" feminine ; -- status=guess
lin systematic_A = mk3A "systematisch" "systematischer" "systematischste" ; -- status=guess
lin striker_N = variants{} ; -- 
lin guard_V2 = mkV2 (mkV "schützen") ; -- status=guess, src=wikt
lin guard_V = mkV "schützen" ; -- status=guess, src=wikt
lin casualty_N = mkN "Opfer" "Opfer" neuter ; -- status=guess
lin steadily_Adv = variants{} ; -- 
lin painter_N = mkN "Maler" "Maler" masculine | mkN "Malerin" feminine | mkN "Kunstmaler" masculine | mkN "Kunstmalerin" feminine | mkN "Freizeitmaler" masculine | mkN "Freizeitmalerin" feminine | mkN "Hobbymaler" masculine | mkN "Hobbymalerin" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin opt_VV = mkVV (irregV "optieren" "optiert" "optierte" "optierte" "optiert") ; -- status=guess, src=wikt
lin opt_V = irregV "optieren" "optiert" "optierte" "optierte" "optiert" ; -- status=guess, src=wikt
lin handsome_A = mkA "hübsch" | mk3A "stattlich" "stattlicher" "stattlichste" ; -- status=guess status=guess
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
lin photographer_N = mkN "Fotograf" "Fotografen" masculine | photograph_N ; -- status=guess status=guess
lin ok_Interj = variants{} ; -- 
lin neighbourhood_N = mkN "Nachbarschaft" "Nachbarschaften" feminine | mkN "Umgebung" ; -- status=guess status=guess
lin ideological_A = mk3A "ideologisch" "ideologischer" "ideologischste" ; -- status=guess
lin wide_Adv = variants{} ; -- 
lin pardon_N = mkN "Vergebung" | mkN "Verzeihung" feminine ; -- status=guess status=guess
lin double_N = mkN "Kauderwelsch" neuter ; -- status=guess
lin criticize_V2 = variants{} ; -- 
lin criticize_V = variants{} ; -- 
lin supervision_N = mkN "Aufsicht" "Aufsichten" feminine | mkN "Beaufsichtigung" feminine ; -- status=guess status=guess
lin guilt_N = mkN "Schuldgefühl" neuter ; -- status=guess
lin deck_N = mkN "Deckstuhl" masculine | mkN "Badeliege" feminine | mkN "Faltstuhl" masculine | mkN "Liegestuhl" "Liegestühle" masculine | mkN "Poolliege" feminine ; -- status=guess status=guess status=guess status=guess status=guess
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
lin faculty_N = mkN "Vermögen" neuter | mkN "Fähigkeit" feminine | mkN "Begabung" ; -- status=guess status=guess status=guess
lin tour_V2 = variants{} ; -- 
lin tour_V = variants{} ; -- 
lin basket_N = mkN "Korb" "Körbe" masculine ; -- status=guess
lin mention_N = mkN "Erwähnung" feminine ; -- status=guess
lin kick_N = mkN "Ein-Euro-Job" "Ein-Euro-Jobs" masculine ; -- status=guess
lin horizon_N = mkN "Horizont" "Horizonte" masculine ; -- status=guess
lin drain_V2 = variants{} ; -- 
lin drain_V = variants{} ; -- 
lin happiness_N = mkN "Glück" neuter | mkN "Glücklichkeit" feminine ; -- status=guess status=guess
lin fighter_N = mkN "Jäger" masculine ; -- status=guess
lin estimated_A = variants{} ; -- 
lin copper_N = mkN "Kupfer" "Kupfer" neuter ; -- status=guess
lin legend_N = mkN "Legende" "Legenden" feminine ; -- status=guess
lin relevance_N = mkN "Relevanz" feminine | mkN "Aktualität" feminine | mkN "Belang" "Belange" masculine ; -- status=guess status=guess status=guess
lin decorate_V2 = mkV2 (mkV "ausschmücken") | mkV2 (mkV "dekorieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin continental_A = mkA "kontinental" ; -- status=guess
lin ship_V2 = mkV2 (mkV "verschicken" | irregV "versenden" "versendet" "versendete" "versendete" "versendet") ; -- status=guess, src=wikt status=guess, src=wikt
lin ship_V = mkV "verschicken" | irregV "versenden" "versendet" "versendete" "versendete" "versendet" ; -- status=guess, src=wikt status=guess, src=wikt
lin operational_A = variants{} ; -- 
lin incur_V2 = variants{} ; -- 
lin parallel_A = regA "parallel" ; -- status=guess
lin divorce_N = mkN "Scheidung" | mkN "Ehescheidung" feminine ; -- status=guess status=guess
lin opposed_A = variants{} ; -- 
lin equilibrium_N = mkN "Gleichgewicht" "Gleichgewichte" neuter ; -- status=guess
lin trader_N = mkN "Händler" masculine ; -- status=guess
lin ton_N = mkN "Tonne" "Tonnen" feminine ; -- status=guess
lin can_N = mkN "Gießkanne" feminine ; -- status=guess
lin juice_N = mkN "Saft" "Säfte" masculine ; -- status=guess
lin forum_N = mkN "Forum" neuter ; -- status=guess
lin spin_V2 = mkV2 (irregV "spinnen" "spinnt" "spann" "spänne" "gesponnen") ; -- status=guess, src=wikt
lin spin_V = irregV "spinnen" "spinnt" "spann" "spänne" "gesponnen" ; -- status=guess, src=wikt
lin research_V2 = mkV2 (irregV "recherchieren" "recherchiert" "recherchiertete" "recherchiertete" "recherchiert" | mkV "erforschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin research_V = irregV "recherchieren" "recherchiert" "recherchiertete" "recherchiertete" "recherchiert" | mkV "erforschen" ; -- status=guess, src=wikt status=guess, src=wikt
lin hostile_A = mk3A "feindlich" "feindlicher" "feindlichste" ; -- status=guess
lin consistently_Adv = variants{} ; -- 
lin technological_A = mkA "technologisch" ; -- status=guess
lin nightmare_N = mkN "Albtraum" "Albträume" masculine | mkN "Alptraum" "Alpträume" masculine ; -- status=guess status=guess
lin medal_N = mkN "Medaille" "Medaillen" feminine ; -- status=guess
lin diamond_N = mkN "Diamantstempelzelle" feminine ; -- status=guess
lin speed_V2 = mkV2 (regV "rasen") ; -- status=guess, src=wikt
lin speed_V = regV "rasen" ; -- status=guess, src=wikt
lin peaceful_A = mk3A "friedfertig" "friedfertiger" "friedfertigste" ; -- status=guess
lin accounting_A = variants{} ; -- 
lin scatter_V2 = mkV2 (regV "zerstreuen") ; -- status=guess, src=wikt
lin scatter_V = regV "zerstreuen" ; -- status=guess, src=wikt
lin monster_N = mkN "Monster" "Monster" neuter | mkN "Ungeheuer" "Ungeheuer" neuter ; -- status=guess status=guess
lin horrible_A = mk3A "schrecklich" "schrecklicher" "schrecklichste" ; -- status=guess
lin nonsense_N = mkN "Blödsinn" masculine | mkN "Nonsens" masculine | mkN "Quatsch" masculine | mkN "Unsinn" masculine ; -- status=guess status=guess status=guess status=guess
lin chaos_N = mkN "Unordnung" feminine | mkN "Chaos" neuter ; -- status=guess status=guess
lin accessible_A = variants{} ; -- 
lin humanity_N = mkN "Menschheit" feminine ; -- status=guess
lin frustration_N = mkN "Frustration" ; -- status=guess
lin chin_N = mkN "Kinn" "Kinne" neuter ; -- status=guess
lin bureau_N = mkN "Kommode" feminine ; -- status=guess
lin advocate_VS = mkVS (irregV "verteidigen" "verteidigt" "verteidigte" "verteidige" "verteidigt" | mkV "plädieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin advocate_V2 = mkV2 (irregV "verteidigen" "verteidigt" "verteidigte" "verteidige" "verteidigt" | mkV "plädieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin polytechnic_N = variants{} ; -- 
lin inhabitant_N = mkN "Einwohner" "Einwohner" masculine | mkN "Einwohnerin" "Einwohnerinnen" feminine | mkN "Bewohner" "Bewohner" masculine | mkN "Bewohnerin" "Bewohnerinnen" feminine ; -- status=guess status=guess status=guess status=guess
lin evil_A = mkA "böse" | mkA "übel" ; -- status=guess status=guess
lin slave_N = mkN "Slave" masculine | mkN "Folgegerät" neuter ; -- status=guess status=guess
lin reservation_N = mkN "Reservierung" feminine ; -- status=guess
lin slam_V2 = mkV2 (mkV "zuschlagen") | mkV2 (mkV "zuknallen") ; -- status=guess, src=wikt status=guess, src=wikt
lin slam_V = mkV "zuschlagen" | mkV "zuknallen" ; -- status=guess, src=wikt status=guess, src=wikt
lin handle_N = mkN "Griff" "Griffe" masculine ; -- status=guess
lin provincial_A = mkA "provinziell" | mkA "provinzial" ; -- status=guess status=guess
lin fishing_N = mkN "Fischerboot" "Fischerboote" neuter ; -- status=guess
lin facilitate_V2 = mkV2 (irregV "erleichtern" "erleichtert" "erleichterte" "erleichtere" "erleichtert" | mkV "fördern") ; -- status=guess, src=wikt status=guess, src=wikt
lin yield_N = mkN "Ertrag" "Erträge" masculine | mkN "Ausbeute" "Ausbeuten" feminine ; -- status=guess status=guess
lin elbow_N = mkN "Ellbogen" "Ellbogen" masculine ; -- status=guess
lin bye_Interj = mkInterj "tschüss" ; -- status=guess
lin warm_V2 = mkV2 (mkV "wärmen") ; -- status=guess, src=wikt
lin warm_V = mkV "wärmen" ; -- status=guess, src=wikt
lin sleeve_N = mkN "Ärmel" masculine ; -- status=guess
lin exploration_N = mkN "Erkundung" feminine ; -- status=guess
lin creep_V = irregV "schleichen" "schleicht" "schlich" "schliche" "geschlichen" ; -- status=guess, src=wikt
lin adjacent_A = regA "umliegend" | regA "nachfolgend" | regA "darauffolgend" ; -- status=guess status=guess status=guess
lin theft_N = mkN "Diebstahl" "Diebstähle" masculine ; -- status=guess
lin round_V2 = mkV2 (regV "runden") ; -- status=guess, src=wikt
lin round_V = regV "runden" ; -- status=guess, src=wikt
lin grace_N = mkN "Gnade" "Gnaden" feminine | mkN "Gunst" feminine ; -- status=guess status=guess
lin predecessor_N = mkN "Vorgänger" masculine | mkN "Vorgängerin" feminine ; -- status=guess status=guess
lin supermarket_N = mkN "Supermarkt" "Supermärkte" masculine ; -- status=guess
lin smart_A = mk3A "klug" "klüger" "klügste" | mk3A "intelligent" "intelligenter" "intelligenteste" | mk3A "gescheit" "gescheiter" "gescheiteste" ; -- status=guess status=guess status=guess
lin sergeant_N = mkN "Feldwebel" "Feldwebel" masculine ; -- status=guess
lin regulate_V2 = mkV2 (irregV "regeln" "regelt" "regelte" "regelte" "regelt") ; -- status=guess, src=wikt
lin clash_N = mkN "Zusammenstoß" masculine | mkN "Auseinandersetzung" ; -- status=guess status=guess
lin assemble_V2 = mkV2 (mkReflV "versammeln") | mkV2 (mkV "zusammenkommen") ; -- status=guess, src=wikt status=guess, src=wikt
lin assemble_V = mkReflV "versammeln" | mkV "zusammenkommen" ; -- status=guess, src=wikt status=guess, src=wikt
lin arrow_N = mkN "Pfeiltaste" feminine ; -- status=guess
lin nowadays_Adv = mkAdv "gegenwärtig" | mkAdv "zur Zeit" | mkAdv "derzeitig" | mkAdv "jetzt" | mkAdv "zurzeit" | mkAdv "momentan" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin giant_A = mk3A "riesig" "riesiger" "riesigste" | mk3A "gigantisch" "gigantischer" "gigantischste" ; -- status=guess status=guess
lin waiting_N = mkN "Warteliste" feminine ; -- status=guess
lin tap_N = mkN "Gewindeschneider" "Gewindeschneider" masculine ; -- status=guess
lin shit_N = mkN "Durchfall" "Durchfälle" masculine ; -- status=guess
lin sandwich_N = mkN "Sandwich" "Sandwiches" neuter ; ----
lin vanish_V = irregV "verschwinden" "verschwindet" "verschwand" "verschwände" "verschwunden" | irregV "vergehen" "vergeht" "verging" "verginge" "vergangen" | mkReflV "verflüchtigen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin commerce_N = mkN "Handel" masculine | mkN "Kommerz" feminine ; -- status=guess status=guess
lin pursuit_N = mkN "Verfolgung" ; -- status=guess
lin post_war_A = variants{} ; -- 
lin will_V2 = mkV2 (werden_V) | mkV2 (junkV (mkV "present") "tense form is often used") ; -- status=guess, src=wikt status=guess, src=wikt
lin will_V = werden_V | junkV (mkV "present") "tense form is often used" ; -- status=guess, src=wikt status=guess, src=wikt
lin waste_A = mkA "wüst" | mkA "öde" ; -- status=guess status=guess
lin collar_N = mkN "Ring" "Ringe" masculine ; -- status=guess
lin socialism_N = mkN "Sozialismus" masculine ; -- status=guess
lin skill_V = variants{} ; -- 
lin rice_N = mkN "Reiskuchen" masculine ; -- status=guess
lin exclusion_N = variants{} ; -- 
lin upwards_Adv = mkAdv "aufwärts" ; -- status=guess
lin transmission_N = mkN "Übertragung" feminine ; -- status=guess
lin instantly_Adv = mkAdv "unmittelbar" ; -- status=guess
lin forthcoming_A = mkA "bevorstehend" | mk3A "entgegenkommend" "entgegenkommender" "entgegenkommendsten e" ; -- status=guess status=guess
lin appointed_A = variants{} ; -- 
lin geographical_A = variants{} ; -- 
lin fist_N = mkN "Faust" "Fäuste" feminine ; -- status=guess
lin abstract_A = mk3A "abstrakt" "abstrakter" "abstrakteste" ; -- status=guess
lin embrace_V2 = mkV2 (regV "umarmen") ; -- status=guess, src=wikt
lin embrace_V = regV "umarmen" ; -- status=guess, src=wikt
lin dynamic_A = mk3A "dynamisch" "dynamischer" "dynamischste" ; -- status=guess
lin drawer_N = mkN "Zeichner" "Zeichner" masculine | mkN "Zeichnerin" "Zeichnerinnen" feminine ; -- status=guess status=guess
lin dismissal_N = mkN "Entlassung" ; -- status=guess
lin magic_N = mkN "Zauberei" "Zaubereien" feminine ; -- status=guess
lin endless_A = mk3A "endlos" "endloser" "endloseste" | mkA "unbegrenzt" ; -- status=guess status=guess
lin definite_A = mk3A "definitiv" "definitiver" "definitivste" ; -- status=guess
lin broadly_Adv = variants{} ; -- 
lin affection_N = mkN "Zuneigung" ; -- status=guess
lin dawn_N = mkN "Dämmerung" feminine ; -- status=guess
lin principal_N = mkN "Schulvorsteher" masculine | mkN "Schuldirektor" masculine ; -- status=guess status=guess
lin bloke_N = mkN "Kerl" "Kerle" masculine ; -- status=guess
lin trap_N = siphon_N ; -- status=guess
lin communist_A = mk3A "kommunistisch" "kommunistischer" "kommunistischste" ; -- status=guess
lin competence_N = mkN "Kompetenz" "Kompetenzen" feminine | mkN "Befähigung" feminine | mkN "Zuständigkeit" feminine ; -- status=guess status=guess status=guess
lin complicate_V2 = mkV2 (irregV "komplizieren" "kompliziert" "komplizierte" "komplizierte" "kompliziert") ; -- status=guess, src=wikt
lin neutral_A = mk3A "neutral" "neutraler" "neutralste" ; -- status=guess
lin fortunately_Adv = mkAdv "glücklicherweise" | mkAdv "zum Glück" ; -- status=guess status=guess
lin commonwealth_N = mkN "Staatenbund" masculine ; -- status=guess
lin breakdown_N = mkN "Betriebsstörung" feminine | mkN "Panne" "Pannen" feminine ; -- status=guess status=guess
lin combined_A = variants{} ; -- 
lin candle_N = mkN "Kerze" "Kerzen" feminine ; -- status=guess
lin venue_N = mkN "Schauplatz" masculine | mkN "Örtlichkeit" feminine | mkN "Stätte" feminine | mkN "Austragungsort" "Austragungsorte" masculine ; -- status=guess status=guess status=guess status=guess
lin supper_N = mkN "Abendessen" "Abendessen" neuter ; -- status=guess
lin analyst_N = mkN "Analytiker" "Analytiker" masculine ; -- status=guess
lin vague_A = mk3A "nebelhaft" "nebelhafter" "nebelhafteste" | mk3A "schwach" "schwächer" "schwächste" | mk3A "unklar" "unklarer" "unklarste" | mk3A "undeutlich" "undeutlicher" "undeutlichste" | mkA "ungenau" | mk3A "ungewiss" "ungewisser" "ungewisseste" | mk3A "vage" "vager" "vagste" | mkA "verschwommen" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin publicly_Adv = variants{} ; -- 
lin marine_A = variants{} ; -- 
lin fair_Adv = variants{} ; -- 
lin pause_N = mkN "Pause" "Pausen" feminine ; -- status=guess
lin notable_A = mk3A "bemerkenswert" "bemerkenswerter" "bemerkenswerteste" ; -- status=guess
lin freely_Adv = mkAdv "frei" ; -- status=guess
lin counterpart_N = mkN "Gegenstück" neuter | pendant_N ; -- status=guess status=guess
lin lively_A = mk3A "lebhaft" "lebhafter" "lebhafteste" ; -- status=guess
lin script_N = mkN "Schrift" "Schriften" feminine ; -- status=guess
lin sue_V2V = mkV2V (mkV "verklagen") ; -- status=guess, src=wikt
lin sue_V2 = mkV2 (mkV "verklagen") ; -- status=guess, src=wikt
lin sue_V = mkV "verklagen" ; -- status=guess, src=wikt
lin legitimate_A = mkA "gültig" ; -- status=guess
lin geography_N = mkN "Geografie" "Geografien" feminine | mkN "Geographie" "Geographien" feminine ; -- status=guess status=guess
lin reproduce_V2 = mkV2 (mkReflV "vermehren") ; -- status=guess, src=wikt
lin reproduce_V = mkReflV "vermehren" ; -- status=guess, src=wikt
lin moving_A = mkA "rührend" ; -- status=guess
lin lamb_N = mkN "Lamm" "Lämmer" neuter | mkN "Lammfleisch" neuter ; -- status=guess status=guess
lin gay_A = mk3A "bunt" "bunter" "bunteste" ; -- status=guess
lin contemplate_VS = mkVS (mkV "nachsinnen") ; -- status=guess, src=wikt
lin contemplate_V2 = mkV2 (mkV "nachsinnen") ; -- status=guess, src=wikt
lin contemplate_V = mkV "nachsinnen" ; -- status=guess, src=wikt
lin terror_N = mkN "Schrecken" "Schrecken" masculine ; -- status=guess
lin stable_N = mkN "Stalljunge" masculine | mkN "Stallknecht" masculine ; -- status=guess status=guess
lin founder_N = mkN "Gründer" masculine | mkN "Gründerin" feminine ; -- status=guess status=guess
lin utility_N = mkN "nützlich" ; -- status=guess
lin signal_VS = mkVS (regV "signalisieren") ; -- status=guess, src=wikt
lin signal_V2 = mkV2 (regV "signalisieren") ; -- status=guess, src=wikt
lin shelter_N = mkN "Zuflucht" feminine | mkN "Obdach" neuter | mkN "Zufluchtsort" "Zufluchtsorte" masculine ; -- status=guess status=guess status=guess
lin poster_N = mkN "Plakat" "Plakate" neuter | mkN "Anschlag" "Anschläge" masculine ; -- status=guess status=guess
lin hitherto_Adv = mkAdv "bis dahin" | mkAdv "bis dato" | mkAdv "bislang" | mkAdv "bisher" ; -- status=guess status=guess status=guess status=guess
lin mature_A = mk3A "reif" "reifer" "reifste" | mkA "gereift" ; -- status=guess status=guess
lin cooking_N = mkN "Kochen" neuter ; -- status=guess
lin head_A = mkA "Haupt-" ; -- status=guess
lin wealthy_A = mk3A "wohlhabend" "wohlhabender" "wohlhabendste" | mk3A "reich" "reicher" "reichste" ; -- status=guess status=guess
lin fucking_A = mkA "Scheiß-" ; -- status=guess
lin confess_VS = mkVS (mkV "gestehen" | irregV "beichten" "beichtet" "beichtete" "beichte" "gebeichtet" | irregV "bekennen" "bekennt" "bekannte" "bekannte" "bekannt") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin confess_V2 = mkV2 (mkV "gestehen" | irregV "beichten" "beichtet" "beichtete" "beichte" "gebeichtet" | irregV "bekennen" "bekennt" "bekannte" "bekannte" "bekannt") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin confess_V = mkV "gestehen" | irregV "beichten" "beichtet" "beichtete" "beichte" "gebeichtet" | irregV "bekennen" "bekennt" "bekannte" "bekannte" "bekannt" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin age_V = irregV "altern" "altert" "alterte" "altere" "gealtert" | irregV "vergreisen" "vergreist" "vergreiste" "vergreiste" "vergreist" | irregV "reifen" "reift" "reifte" "reifte" "reift" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin miracle_N = mkN "Wunder" "Wunder" neuter ; -- status=guess
lin magic_A = mk3A "magisch" "magischer" "magischste" ; -- status=guess
lin jaw_N = mkN "Kiefer" "Kiefern" feminine | mkN "Unterkiefer" "Unterkiefer" masculine | mkN "Oberkiefer" masculine | mkN "Kinnbacke" feminine ; -- status=guess status=guess status=guess status=guess
lin pan_N = mkN "Panarabismus" masculine ; -- status=guess
lin coloured_A = variants{} ; -- 
lin tent_N = mkN "Zelt" "Zelte" neuter ; -- status=guess
lin telephone_V2 = mkV2 (irregV "telefonieren" "telefoniert" "telefonierte" "telefoniere" "telefoniert" | prefixV "an" (irregV "rufen" "ruft" "rief" "riefe" "gerufen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin telephone_V = irregV "telefonieren" "telefoniert" "telefonierte" "telefoniere" "telefoniert" | prefixV "an" (irregV "rufen" "ruft" "rief" "riefe" "gerufen") ; -- status=guess, src=wikt status=guess, src=wikt
lin reduced_A = variants{} ; -- 
lin tumour_N = variants{} ; -- 
lin super_A = mkA "super" ; -- status=guess
lin funding_N = mkN "Finanzierung" ; -- status=guess
lin dump_V2 = variants{} ; -- 
lin dump_V = variants{} ; -- 
lin stitch_N = mkN "Seitenstechen" neuter ; -- status=guess
lin shared_A = regA "gemeinsam" | regA "geteilt" | regA "verteilt" ; -- status=guess status=guess status=guess
lin ladder_N = mkN "Leiter" "Leitern" feminine ; -- status=guess
lin keeper_N = variants{} ; -- 
lin endorse_V2 = mkV2 (irregV "empfehlen" "empfehlt" "empfahl" "empfähle" "empfohlen" | mkV "bestätigen" | mkV "unterstützen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin invariably_Adv = variants{} ; -- 
lin smash_V2 = mkV2 (mkV "zusammenschlagen" | irregV "schmettern" "schmettert" "schmetterte" "schmetterte" "geschmettert") ; -- status=guess, src=wikt status=guess, src=wikt
lin smash_V = mkV "zusammenschlagen" | irregV "schmettern" "schmettert" "schmetterte" "schmetterte" "geschmettert" ; -- status=guess, src=wikt status=guess, src=wikt
lin shield_N = mkN "Schutz" "Schutze" masculine ; -- status=guess
lin heat_V2 = mkV2 (junkV (mkV "heiß") "machen") ; -- status=guess, src=wikt
lin heat_V = junkV (mkV "heiß") "machen" ; -- status=guess, src=wikt
lin surgeon_N = mkN "Chirurg" "Chirurgen" masculine | mkN "Chirurgin" feminine ; -- status=guess status=guess
lin centre_V2 = variants{} ; -- 
lin centre_V = variants{} ; -- 
lin orange_N = variants{} ; -- 
lin orange_2_N = variants{} ; -- 
lin orange_1_N = variants{} ; -- 
lin explode_V = regV "sprengen" | irregV "explodieren" "explodiert" "explodierte" "explodierte" "explodiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin comedy_N = mkN "Komödie" feminine ; -- status=guess
lin classify_V2 = mkV2 (mkV "einordenen") | mkV2 (mkV "einstufen") | mkV2 (irregV "unterteilen" "unterteilt" "unterteilte" "unterteile" "unterteilt") | mkV2 (irregV "klassifizieren" "klassifiziert" "klassifizierte" "klassifizierte" "klassifiziert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin artistic_A = mkA "kunstvoll" ; -- status=guess
lin ruler_N = mkN "Lineal" "Lineale" neuter ; -- status=guess
lin biscuit_N = mkN "Keks" ; -- status=guess
lin workstation_N = mkN "Arbeitsplatz" "Arbeitsplätze" masculine ; -- status=guess
lin prey_N = mkN "Beute" feminine ; -- status=guess
lin manual_N = mkN "Handbuch" "Handbücher" neuter ; -- status=guess
lin cure_N = variants{} ; -- 
lin cure_2_N = variants{} ; -- 
lin cure_1_N = variants{} ; -- 
lin overall_N = mkN "Overall" masculine ; -- status=guess
lin tighten_V2 = variants{} ; -- 
lin tighten_V = variants{} ; -- 
lin tax_V2 = mkV2 (mkV "besteuern") ; -- status=guess, src=wikt
lin pope_N = mkN "Papst" "Päpste" masculine ;
lin manufacturing_A = variants{} ; -- 
lin adult_A = mkA "erwachsen" ; -- status=guess
lin rush_N = mkN "Eile" feminine | mkN "Hast" feminine ; -- status=guess status=guess
lin blanket_N = mkN "Decke" "Decken" feminine ; -- status=guess
lin republican_N = variants{} ; -- 
lin referendum_N = mkN "Referendum" "Referenden" neuter | mkN "Volksabstimmung" ; -- status=guess status=guess
lin palm_N = mkN "Handfläche" feminine ; -- status=guess
lin nearby_Adv = mkAdv "nebenan" | mkAdv "in petto" | mkAdv "nah" ; -- status=guess status=guess status=guess
lin mix_N = mkN "Mischung" ; -- status=guess
lin devil_N = mkN "Teufel" "Teufel" masculine ; -- status=guess
lin adoption_N = mkN "Adoption" ; -- status=guess
lin workforce_N = mkN "Belegschaft" "Belegschaften" feminine | mkN "Arbeitskraft" "Arbeitskräfte" feminine ;
lin segment_N = mkN "Segment" "Segmente" neuter ; -- status=guess
lin regardless_Adv = variants{} ; -- 
lin contractor_N = mkN "Ausführer" ; -- status=guess
lin portion_N = mkN "Teil" "Teile" neuter ; -- status=guess
lin differently_Adv = mkAdv "anders" ; -- status=guess
lin deposit_V2 = mkV2 (prefixV "ein" (regV "zahlen")) ; -- status=guess, src=wikt
lin cook_N = mkN "Koch" "Köche" masculine | mkN "Köchin" feminine ; -- status=guess status=guess
lin prediction_N = mkN "Voraussage" "Voraussagen" feminine | mkN "Vorhersage" "Vorhersagen" feminine | mkN "Prophezeiung" ; -- status=guess status=guess status=guess
lin oven_N = mkN "Ofen" "Öfen" masculine ; -- status=guess
lin matrix_N = mkN "Matrix" "Matrizen" feminine ; -- status=guess
lin liver_N = L.liver_N ;
lin fraud_N = mkN "Betrug" "Betrugsfälle" masculine ; -- status=guess
lin beam_N = mkN "Balken" "Balken" masculine ; -- status=guess
lin signature_N = mkN "Unterschrift" "Unterschriften" feminine ; -- status=guess
lin limb_N = mkN "Glied" "Glieder" neuter | mkN "Gliedmaße" ; ---- n {f} {p}" | mkN "Extremitäten {f} {p}" ; -- status=guess status=guess status=guess
lin verdict_N = mkN "Gerichtsurteil" neuter ; -- status=guess
lin dramatically_Adv = variants{} ; -- 
lin container_N = mkN "Container" "Container" masculine ; -- status=guess
lin aunt_N = mkN "Tante" "Tanten" feminine ; -- status=guess
lin dock_N = variants{} ; -- 
lin submission_N = variants{} ; -- 
lin arm_V2 = mkV2 (mkV "rüsten" | irregV "bewaffnen" "bewaffnet" "bewaffnete" "bewaffnete" "bewaffnet") ; -- status=guess, src=wikt status=guess, src=wikt
lin arm_V = mkV "rüsten" | irregV "bewaffnen" "bewaffnet" "bewaffnete" "bewaffnete" "bewaffnet" ; -- status=guess, src=wikt status=guess, src=wikt
lin odd_N = mkN "ungerade Funktion" feminine ; -- status=guess
lin certainty_N = mkN "Sicherheit" "Sicherheiten" feminine ; -- status=guess
lin boring_A = mk3A "langweilig" "langweiliger" "langweiligste" ; -- status=guess
lin electron_N = mkN "Elektron" "Elektronen" neuter ; -- status=guess
lin drum_N = mkN "Fass" "Fässer" neuter ; -- status=guess
lin wisdom_N = mkN "Weisheit" "Weisheiten" feminine ; -- status=guess
lin antibody_N = mkN "Antikörper" masculine ; -- status=guess
lin unlike_A = variants{} ; -- 
lin terrorist_N = mkN "Terrorist" "Terroristen" masculine | mkN "Terroristin" feminine ; -- status=guess status=guess
lin post_V2 = mkV2 (regV "schicken") ; -- status=guess, src=wikt
lin post_V = regV "schicken" ; -- status=guess, src=wikt
lin circulation_N = mkN "Blutkreislauf" "Blutkreisläufe" masculine ; -- status=guess
lin alteration_N = variants{} ; -- 
lin fluid_N = mkN "Fluid" "Fluide" neuter | mkN "Flüssigkeit" feminine ; -- status=guess status=guess
lin ambitious_A = mk3A "ehrgeizig" "ehrgeiziger" "ehrgeizigste" | mk3A "ambitioniert" "ambitionierter" "ambitionierteste" ; -- status=guess status=guess
lin socially_Adv = variants{} ; -- 
lin riot_N = mkN "Aufruhr" "Aufruhre" masculine | mkN "Tumult" masculine | mkN "Krawall" "Krawalle" masculine | mkN "Randale" ; ---- {f} {p}" ; -- status=guess status=guess status=guess status=guess
lin petition_N = mkN "Petition" | mkN "Eingabe" "Eingaben" feminine ; -- status=guess status=guess
lin fox_N = mkN "Fuchs" "Füchse" masculine | mkN "Middle Low German: vos" | mkN "vohe" | mkN "vō)" ; -- status=guess status=guess status=guess status=guess
lin recruitment_N = mkN "Rekrutierung" feminine ; -- status=guess
lin well_known_A = variants{} ; -- 
lin top_V2 = variants{} ; -- 
lin service_V2 = mkV2 (irregV "warten" "wartet" "wartete" "warte" "gewartet") ; -- status=guess, src=wikt
lin flood_V2 = mkV2 (mkV "überschwemmen") | mkV2 (mkV "überfluten") ; -- status=guess, src=wikt status=guess, src=wikt
lin flood_V = mkV "überschwemmen" | mkV "überfluten" ; -- status=guess, src=wikt status=guess, src=wikt
lin taste_V2 = mkV2 (regV "schmecken") ; -- status=guess, src=wikt
lin taste_V = regV "schmecken" ; -- status=guess, src=wikt
lin memorial_N = mkN "Gedenkgottesdienst" masculine ; -- status=guess
lin helicopter_N = mkN "Helikopter" "Helikopter" masculine | mkN "Hubschrauber" "Hubschrauber" masculine ; -- status=guess status=guess
lin correspondence_N = mkN "Korrespondenz" "Korrespondenzen" feminine ; -- status=guess
lin beef_N = mkN "Rindfleisch" neuter | mkN "Ochsenfleisch" ; -- status=guess status=guess
lin overall_Adv = mkAdv "insgesamt" ; -- status=guess
lin lighting_N = variants{} ; -- 
lin harbour_N = L.harbour_N ;
lin empirical_A = mk3A "empirisch" "empirischer" "empirischste" ; -- status=guess
lin shallow_A = mkA "oberflächlich" ; -- status=guess
lin seal_V2 = variants{} ; -- 
lin seal_V = variants{} ; -- 
lin decrease_V2 = mkV2 (prefixV "ab" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen")) ; -- status=guess, src=wikt
lin decrease_V = prefixV "ab" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen") ; -- status=guess, src=wikt
lin constituent_N = mkN "Wähler" masculine ; -- status=guess
lin exam_N = variants{} ; -- 
lin toe_N = mkN "Zeh" "Zehen" masculine | mkN "Zehe" "Zehen" feminine ; -- status=guess status=guess
lin reward_V2 = mkV2 (regV "belohnen") ; -- status=guess, src=wikt
lin thrust_V2 = mkV2 (irregV "schieben" "schiebt" "schob" "schöbe" "geschoben" | mkV "stoßen") ; -- status=guess, src=wikt status=guess, src=wikt
lin thrust_V = irregV "schieben" "schiebt" "schob" "schöbe" "geschoben" | mkV "stoßen" ; -- status=guess, src=wikt status=guess, src=wikt
lin bureaucracy_N = mkN "Bürokratie" feminine ; -- status=guess
lin wrist_N = mkN "Handgelenk" "Handgelenke" neuter ; -- status=guess
lin nut_N = mkN "Nuss" "Nüsse" feminine ; -- status=guess
lin plain_N = mkN "Ebene" "Ebenen" feminine ; -- status=guess
lin magnetic_A = regA "magnetisch" ; -- status=guess
lin evil_N = mkN "Böse" neuter | mkN "Übel" neuter ; -- status=guess status=guess
lin widen_V2 = mkV2 (mkReflV "weiten") ; -- status=guess, src=wikt
lin hazard_N = mkN "Zufall" "Zufälle" masculine ; -- status=guess
lin dispose_V2 = mkV2 (regV "beseitigen" | irregV "entsorgen" "entsorgt" "entsorgte" "entsorgte" "entsorgt") ; -- status=guess, src=wikt status=guess, src=wikt
lin dispose_V = regV "beseitigen" | irregV "entsorgen" "entsorgt" "entsorgte" "entsorgte" "entsorgt" ; -- status=guess, src=wikt status=guess, src=wikt
lin dealing_N = variants{} ; -- 
lin absent_A = regA "abwesend" ; -- status=guess
lin reassure_V2S = variants{} ; -- 
lin reassure_V2 = variants{} ; -- 
lin model_V2 = mkV2 (mkV "modellieren") ; -- status=guess, src=wikt
lin model_V = mkV "modellieren" ; -- status=guess, src=wikt
lin inn_N = mkN "Herberge" "Herbergen" feminine ; -- status=guess
lin initial_N = mkN "Initiale" "Initialen" feminine | mkN "Initial" neuter ; -- status=guess status=guess
lin suspension_N = mkN "Aussetzung" feminine ; -- status=guess
lin respondent_N = variants{} ; -- 
lin over_N = variants{} ; -- 
lin naval_A = variants{} ; -- 
lin monthly_A = regA "monatlich" ; -- status=guess
lin log_N = mkN "Blockhaus" "Blockhäuser" neuter | mkN "Blockbau" masculine ; -- status=guess status=guess
lin advisory_A = mkA "beratend" | mkA "Beratungs-" ; -- status=guess status=guess
lin fitness_N = mkN "Tauglichkeit" feminine | mkN "Zweckmäßigkeit" feminine ; -- status=guess status=guess
lin blank_A = mkA "unbeschrieben" | mkA "unausgefüllt" ; -- status=guess status=guess
lin indirect_A = variants{} ; -- 
lin tile_N = mkN "Kachel" feminine | mkN "Fliese" "Fliesen" feminine | mkN "Dachziegel" "Dachziegel" masculine ; -- status=guess status=guess status=guess
lin rally_N = mkN "Kundgebung" ; -- status=guess
lin economist_N = mkN "Wirtschaftswissenschaftler" masculine | mkN "Ökonom" masculine ; -- status=guess status=guess
lin vein_N = mkN "Vene" "Venen" feminine ; -- status=guess
lin strand_N = mkN "Strand" "Strände" masculine ; -- status=guess
lin disturbance_N = mkN "Störung" feminine ; -- status=guess
lin stuff_V2 = mkV2 (prefixV "aus" (regV "stopfen")) ; -- status=guess, src=wikt
lin seldom_Adv = mkAdv "selten" ; -- status=guess
lin coming_A = variants{} ; -- 
lin cab_N = mkN "Führerhaus" neuter | mkN "Fahrerhaus" neuter | mkN "Führerkabine" feminine | mkN "Fahrerkabine" feminine ; -- status=guess status=guess status=guess status=guess
lin grandfather_N = mkN "Großvater" masculine | mkN "Opa" "Opas" masculine | mkN "Opi" masculine | mkN "Großvater väterlicherseits" masculine | mkN "Großvater mütterlicherseits" masculine ; -- status=guess status=guess status=guess status=guess status=guess
lin flash_V = regV "blinken" ; -- status=guess, src=wikt
lin destination_N = mkN "Reiseziel" "Reiseziele" neuter | mkN "Bestimmungsort" "Bestimmungsorte" masculine ; -- status=guess status=guess
lin actively_Adv = variants{} ; -- 
lin regiment_N = mkN "Regiment" "Regimenter" neuter ; -- status=guess
lin closed_A = mk3A "geschlossen" "geschlossener" "geschlossenste" ; -- status=guess
lin boom_N = mkN "Dröhnen" masculine ; -- status=guess
lin handful_N = variants{} ; -- 
lin remarkably_Adv = variants{} ; -- 
lin encouragement_N = mkN "Ermutigung" feminine ; -- status=guess
lin awkward_A = mk3A "ungeschickt" "ungeschickter" "ungeschickteste" | mkA "unbeholfen" | mkA "tölpelhaft" | mkA "patschert" ; -- status=guess status=guess status=guess status=guess
lin required_A = variants{} ; -- 
lin flood_N = mkN "Flut" "Fluten" feminine ; -- status=guess
lin defect_N = mkN "Fehler" "Fehler" masculine | mkN "Defekt" "Defekte" masculine ; -- status=guess status=guess
lin surplus_N = mkN "Überschuss" masculine ; -- status=guess
lin champagne_N = mkN "Champagner" "Champagner" masculine ; -- status=guess
lin liquid_N = mkN "Flüssigkeit" feminine ; -- status=guess
lin shed_V2 = mkV2 (mkV "vergießen") ; -- status=guess, src=wikt
lin welcome_N = mkN "Begrüßung" feminine | mkN "Empfang" "Empfänge" masculine ; -- status=guess status=guess
lin rejection_N = variants{} ; -- 
lin discipline_V2 = mkV2 (irregV "disziplinieren" "diszipliniert" "disziplinierte" "disziplinierte" "diszipliniert") ; -- status=guess, src=wikt
lin halt_V2 = mkV2 (prefixV "an" (irregV "halten" "hält" "hielt" "hielte" "gehalten") | regV "stoppen" | regV "stocken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin halt_V = prefixV "an" (irregV "halten" "hält" "hielt" "hielte" "gehalten") | regV "stoppen" | regV "stocken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin electronics_N = mkN "Elektronik" feminine ; -- status=guess
lin administratorMasc_N = reg2N "Administrator" "Administratoren" masculine;
lin sentence_V2 = mkV2 (mkV "verurteilen") ; -- status=guess, src=wikt
lin sentence_V = mkV "verurteilen" ; -- status=guess, src=wikt
lin ill_Adv = variants{} ; -- 
lin contradiction_N = mkN "Widerspruch" "Widersprüche" masculine ; -- status=guess
lin nail_N = mkN "Nagelbombe" feminine ; -- status=guess
lin senior_N = mkN "Stabshauptmann" "Stabshauptmänner" masculine ; -- status=guess
lin lacking_A = variants{} ; -- 
lin colonial_A = variants{} ; -- 
lin primitive_A = mk3A "primitiv" "primitiver" "primitivste" ; -- status=guess
lin whoever_NP = variants{} ; -- 
lin lap_N = mkN "Schoß" masculine ; -- status=guess
lin commodity_N = ware_N ; -- status=guess
lin planned_A = variants{} ; -- 
lin intellectual_N = mkN "Intellektueller" masculine | mkN "Intellektuelle" feminine ; -- status=guess status=guess
lin imprisonment_N = mkN "Gefangenschaft" "Gefangenschaften" feminine | mkN "Haft" feminine ; -- status=guess status=guess
lin coincide_V = mkV "übereinstimmen" ; -- status=guess, src=wikt
lin sympathetic_A = mkA "mitfühlend" ; -- status=guess
lin atom_N = mkN "Atom" "Atome" neuter ; -- status=guess
lin tempt_V2V = mkV2V (regV "locken") ; -- status=guess, src=wikt
lin tempt_V2 = mkV2 (regV "locken") ; -- status=guess, src=wikt
lin sanction_N = mkN "Billigung" feminine | mkN "Billigung" feminine | mkN "Sanktionierung" feminine ; -- status=guess status=guess status=guess
lin praise_V2 = mkV2 (regV "loben") ; -- status=guess, src=wikt
lin favourable_A = mkA "günstig" ; -- status=guess
lin dissolve_V2 = mkV2 (mkReflV "auflösen") ; -- status=guess, src=wikt
lin dissolve_V = mkReflV "auflösen" ; -- status=guess, src=wikt
lin tightly_Adv = variants{} ; -- 
lin surrounding_N = variants{} ; -- 
lin soup_N = mkN "Suppe" "Suppen" feminine ; -- status=guess
lin encounter_N = mkN "Begegnung" | mkN "Treffen" "Treffen" neuter ; -- status=guess status=guess
lin abortion_N = mkN "Abtreibung" ; -- status=guess
lin grasp_V2 = mkV2 (irregV "greifen" "greift" "griff" "griffe" "gegriffen" | irregV "erfassen" "erfasst" "erfasste" "erfasste" "erfasst") ; -- status=guess, src=wikt status=guess, src=wikt
lin grasp_V = irregV "greifen" "greift" "griff" "griffe" "gegriffen" | irregV "erfassen" "erfasst" "erfasste" "erfasste" "erfasst" ; -- status=guess, src=wikt status=guess, src=wikt
lin custody_N = mkN "Sorgerecht" "Sorgerechte" neuter | mkN "Obhut" feminine ; -- status=guess status=guess
lin composer_N = mkN "Komponist" "Komponisten" masculine | mkN "Komponistin" feminine ; -- status=guess status=guess
lin charm_N = mkN "Charme" masculine ; -- status=guess
lin short_term_A = variants{} ; -- 
lin metropolitan_A = variants{} ; -- 
lin waist_N = mkN "Taille" "Taillen" feminine ; -- status=guess
lin equality_N = mkN "Gleichberechtigung" feminine ; -- status=guess
lin tribute_N = mkN "Tribut" "Tribute" masculine ; -- status=guess
lin bearing_N = mkN "Lager" neuter ; -- status=guess
lin auction_N = mkN "Versteigerung" feminine | mkN "Auktion" ; -- status=guess status=guess
lin standing_N = mkN "stehende Ovation" feminine | mkN "Stehapplaus" masculine | mkN "Stehbeifall" masculine ; -- status=guess status=guess status=guess
lin manufacture_N = mkN "Produktion" ; -- status=guess
lin horn_N = L.horn_N ;
lin barn_N = mkN "Scheune" "Scheunen" feminine | mkN "Stall" "Ställe" masculine | mkN "Schuppen" "Schuppen" masculine ; -- status=guess status=guess status=guess
lin mayor_N = mkN "Bürgermeister" masculine | mkN "Bürgermeisterin" feminine ; -- status=guess status=guess
lin emperor_N = mkN "Kaiser" "Kaiser" masculine | mkN "Imperator" masculine ; -- status=guess status=guess
lin rescue_N = mkN "Rettung" ; -- status=guess
lin integrated_A = regA "integriert" ; -- status=guess
lin conscience_N = mkN "Gewissen" "Gewissen" neuter ; -- status=guess
lin commence_V2 = mkV2 (prefixV "an" (irregV "fangen" "fangt" "fing" "finge" "gefangen") | irregV "beginnen" "beginnt" "begann" "begänne" "begonnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin commence_V = prefixV "an" (irregV "fangen" "fangt" "fing" "finge" "gefangen") | irregV "beginnen" "beginnt" "begann" "begänne" "begonnen" ; -- status=guess, src=wikt status=guess, src=wikt
lin grandmother_N = mkN "Großmutter" feminine | mkN "Omi" "Omis" feminine | mkN "Oma" "Omas" feminine ; -- status=guess status=guess status=guess
lin discharge_V2 = mkV2 (mkV "entladen") ; -- status=guess, src=wikt
lin discharge_V = mkV "entladen" ; -- status=guess, src=wikt
lin profound_A = mk3A "tief" "tiefer" "tiefste" | mk3A "profund" "profunder" "profundeste" ; -- status=guess status=guess
lin takeover_N = mkN "Geschäftsübernahme" feminine | mkN "Übernahme" feminine ; -- status=guess status=guess
lin nationalist_N = mkN "Nationalist" masculine | mkN "Nationalistin" feminine ; -- status=guess status=guess
lin effect_V2 = mkV2 (regV "bewirken") ; -- status=guess, src=wikt
lin dolphin_N = mkN "Delphin" "Delphine" masculine | mkN "Delfin" "Delfine" masculine ; -- status=guess status=guess
lin fortnight_N = variants{} ; -- 
lin elephant_N = mkN "Elefant" "Elefanten" masculine | mkN "Elefantenbulle" masculine | mkN "Elefantin" feminine | mkN "Elefantenkuh" feminine | mkN "Elefantenkalb" neuter ; -- status=guess status=guess status=guess status=guess status=guess
lin seal_N = mkN "Siegel" "Siegel" neuter | mkN "Petschaft" "Petschafte" neuter ; -- status=guess status=guess
lin spoil_V2 = mkV2 (irregV "verderben" "verderbt" "verdarb" "verdürbe" "verdorben") ; -- status=guess, src=wikt
lin spoil_V = irregV "verderben" "verderbt" "verdarb" "verdürbe" "verdorben" ; -- status=guess, src=wikt
lin plea_N = mkN "Ersuchen" neuter | mkN "Flehen" neuter | mkN "Bitte" "Bitten" feminine | mkN "Appell" "Appelle" masculine ; -- status=guess status=guess status=guess status=guess
lin forwards_Adv = variants{} ; -- 
lin breeze_N = mkN "Kinderspiel" "Kinderspiele" neuter ; -- status=guess
lin prevention_N = mkN "Prävention" feminine ; -- status=guess
lin mineral_N = mkN "Mineral" neuter ; -- status=guess
lin runner_N = mkN "Läufer" ; -- status=guess
lin pin_V2 = variants{} ; -- 
lin integrity_N = mkN "Integrität" feminine ; -- status=guess
lin thereafter_Adv = variants{} ; -- 
lin quid_N = variants{} ; -- 
lin owl_N = mkN "Eule" "Eulen" feminine | mkN "Uhu" "Uhus" masculine ; -- status=guess status=guess
lin rigid_A = mk3A "steif" "steifer" "steifste" ; -- status=guess
lin orange_A = regA "orange" ; -- status=guess
lin draft_V2 = mkV2 (mkV "abkommandieren") ; -- status=guess, src=wikt
lin reportedly_Adv = variants{} ; -- 
lin hedge_N = mkN "Hecke" "Hecken" feminine ; -- status=guess
lin formulate_V2 = mkV2 (regV "formulieren" | prefixV "dar" (regV "legen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin associated_A = variants{} ; -- 
lin position_V2 = mkV2 (mkV "positionieren") ; -- status=guess, src=wikt
lin thief_N = mkN "Dieb" "Diebe" masculine ; -- status=guess
lin tomato_N = mkN "Tomate" "Tomaten" feminine | mkN "Paradeiser" "Paradeiser" masculine ; -- status=guess status=guess
lin exhaust_V2 = mkV2 (mkV "erschöpfen" | irregV "dezimieren" "dezimiert" "dezimierte" "dezimierte" "dezimiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin evidently_Adv = variants{} ; -- 
lin eagle_N = mkN "Zehn-Dollar-Note" feminine ; -- status=guess
lin specified_A = variants{} ; -- 
lin resulting_A = variants{} ; -- 
lin blade_N = mkN "Klinge" "Klingen" feminine ; -- status=guess
lin peculiar_A = variants{} ; -- 
lin killing_N = mkN "Töten" neuter | mkN "Erlegen" neuter ; -- status=guess status=guess
lin desktop_N = mkN "Desktop-Computer" masculine ; -- status=guess
lin bowel_N = mkN "Inneres" neuter | mkN "Eingeweide" "Eingeweide" neuter | mkN "Bauch" "Bäuche" masculine ; -- status=guess status=guess status=guess
lin long_V = mkV "sehnen" ; -- status=guess, src=wikt
lin ugly_A = L.ugly_A ;
lin expedition_N = mkN "Expedition" ; -- status=guess
lin saint_N = mkN "Heiliger" masculine | mkN "Heilige" feminine ; -- status=guess status=guess
lin variable_A = mk3A "variabel" "variabler" "variabelste" ; -- status=guess
lin supplement_V2 = variants{} ; -- 
lin stamp_N = mkN "Stempel" "Stempel" masculine ; -- status=guess
lin slide_N = mkN "Rutsche" "Rutschen" feminine ; -- status=guess
lin faction_N = mkN "Fraktion" ; -- status=guess
lin enthusiastic_A = mk3A "enthusiastisch" "enthusiastischer" "enthusiastischste" | mkA "begeistert" ; -- status=guess status=guess
lin enquire_V2 = variants{} ; -- 
lin enquire_V = variants{} ; -- 
lin brass_N = mkN "Messing" neuter ; -- status=guess
lin inequality_N = mkN "Ungleichung" ; -- status=guess
lin eager_A = mk3A "begierig" "begieriger" "begierigste" | mkA "gierig" ; -- status=guess status=guess
lin bold_A = mk3A "mutig" "mutiger" "mutigste" | mkA "wagemutig" | mk3A "tapfer" "tapferer" "tapferste" | mkA "kühn" ; -- status=guess status=guess status=guess status=guess
lin neglect_V2 = mkV2 (irregV "missachten" "missachtet" "missachtete" "missachte" "missachtet") ; -- status=guess, src=wikt
lin saying_N = mkN "Sprichwort" "Sprichwörter" neuter | mkN "Ausspruch" "Aussprüche" masculine ; -- status=guess status=guess
lin ridge_N = mkN "Grat" "Grate" masculine ; -- status=guess
lin earl_N = mkN "Graf" "Grafen" masculine ; -- status=guess
lin yacht_N = mkN "Yacht" "Yachten" feminine | mkN "Jacht" "Jachten" feminine ; -- status=guess status=guess
lin suck_V2 = L.suck_V2 ;
lin suck_V = junkV (mkV "mies") "sein" | junkV (mkV "zum") "Kotzen sein" | junkV (mkV "Scheiße") "sein" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin missing_A = regA "fehlend" ; -- status=guess
lin extended_A = variants{} ; -- 
lin valuation_N = variants{} ; -- 
lin delight_V2 = variants{} ; -- 
lin delight_V = variants{} ; -- 
lin beat_N = variants{} ; -- 
lin worship_N = mkN "Verehrung" feminine | mkN "Anbetung" ; -- status=guess status=guess
lin fossil_N = mkN "Fossil" "Fossilien" neuter ; -- status=guess
lin diminish_V2 = mkV2 (regV "schrumpfen") ; -- status=guess, src=wikt
lin diminish_V = regV "schrumpfen" ; -- status=guess, src=wikt
lin taxpayer_N = mkN "Steuerzahler" "Steuerzahler" masculine | mkN "Steuerzahlerin" feminine ; -- status=guess status=guess
lin corruption_N = mkN "Korruption" ; -- status=guess
lin accurately_Adv = mkAdv "genau" | mkAdv "akkurat" | mkAdv "präzise" ; -- status=guess status=guess status=guess
lin honour_V2 = mkV2 (irregV "ehren" "ehrt" "ehrte" "ehrte" "ehrt") ; -- status=guess, src=wikt
lin depict_V2 = mkV2 (prefixV "dar" (regV "stellen")) ; -- status=guess, src=wikt
lin pencil_N = mkN "Federkasten" masculine | mkN "Federmäppchen" neuter ; -- status=guess status=guess
lin drown_V2 = mkV2 (irregV "ertrinken" "ertrinkt" "ertrank" "ertränke" "ertrunken") ; -- status=guess, src=wikt
lin drown_V = irregV "ertrinken" "ertrinkt" "ertrank" "ertränke" "ertrunken" ; -- status=guess, src=wikt
lin stem_N = mkN "Stamm" "Stämme" masculine ; -- status=guess
lin lump_N = mkN "Kloß" masculine ; -- status=guess
lin applicable_A = regA "anwendbar" ; -- status=guess
lin rate_V2 = variants{} ; -- 
lin rate_V = variants{} ; -- 
lin mobility_N = mkN "Mobilität" feminine ; -- status=guess
lin immense_A = mk3A "immens" "immenser" "immenseste" ; -- status=guess
lin goodness_N = mkN "Güte" feminine | mkN "Gütigkeit" feminine | mkN "Herzensgüte" feminine | mkN "Tugend" "Tugenden" feminine | mkN "Integrität" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin price_V2V = mkV2V (mkV "schätzen") | mkV2V (junkV (mkV "den") "Preis festsetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V2 = mkV2 (mkV "schätzen") | mkV2 (junkV (mkV "den") "Preis festsetzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin price_V = mkV "schätzen" | junkV (mkV "den") "Preis festsetzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin preliminary_A = mkA "vorläufig" | mkA "vorbereitend" ; -- status=guess status=guess
lin graph_N = mkN "Graph" "Graphen" masculine ; -- status=guess
lin referee_N = mkN "Rezensent" "Rezensenten" masculine | mkN "Lektor" "Lektoren" masculine ; -- status=guess status=guess
lin calm_A = mk3A "ruhig" "ruhiger" "ruhigste" ; -- status=guess
lin onwards_Adv = variants{} ; -- 
lin omit_V2 = mkV2 (prefixV "weg" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen") | prefixV "aus" (irregV "lassen" "lasst" "ließ" "ließe" "gelassen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin genuinely_Adv = variants{} ; -- 
lin excite_V2 = mkV2 (irregV "erregen" "erregt" "erregte" "erregte" "erregt" | prefixV "an" (regV "regen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin dreadful_A = mk3A "furchtbar" "furchtbarer" "furchtbarste" | mk3A "schrecklich" "schrecklicher" "schrecklichste" ; -- status=guess status=guess
lin cave_N = mkN "Höhle" feminine ; -- status=guess
lin revelation_N = mkN "Offenbarung" ; -- status=guess
lin grief_N = mkN "Kummer" masculine ; -- status=guess
lin erect_V2 = variants{} ; -- 
lin tuck_V2 = mkV2 (junkV (mkV "1.") "stecken") ; -- status=guess, src=wikt
lin tuck_V = junkV (mkV "1.") "stecken" ; -- status=guess, src=wikt
lin meantime_N = variants{} ; -- 
lin barrel_N = mkN "Lauf" "Läufe" masculine ; -- status=guess
lin lawn_N = mkN "Rasen" "Rasen" masculine | mkN "Wiese" "Wiesen" feminine ; -- status=guess status=guess
lin hut_N = mkN "Hütte" feminine ; -- status=guess
lin swing_N = mkN "Schaukel" "Schaukeln" feminine ;
lin subject_V2 = mkV2 (mkV "unterwerfen") ; -- status=guess, src=wikt
lin ruin_V2 = mkV2 (regV "ruinieren") ; -- status=guess, src=wikt
lin slice_N = mkN "Brotscheibe" feminine | mkN "Scheibe" "Scheiben" feminine | mkN "Anteil" "Anteile" masculine | mkN "Teil" "Teile" neuter | mkN "Stück" neuter ; -- status=guess status=guess status=guess status=guess status=guess
lin transmit_V2 = mkV2 (mkV "übermitteln") ; -- status=guess, src=wikt
lin thigh_N = mkN "Oberschenkel" "Oberschenkel" masculine ; -- status=guess
lin practically_Adv = mkAdv "praktisch" ; -- status=guess
lin dedicate_V2 = mkV2 (regV "widmen") ; -- status=guess, src=wikt
lin mistake_V2 = mkV2 (irregV "verwechseln" "verwechselt" "verwechselte" "verwechselte" "verwechselt") ; -- status=guess, src=wikt
lin mistake_V = irregV "verwechseln" "verwechselt" "verwechselte" "verwechselte" "verwechselt" ; -- status=guess, src=wikt
lin corresponding_A = regA "korrespondierend" ; -- status=guess
lin albeit_Subj = variants{} ; -- 
lin sound_A = mk3A "gesund" "gesünder" "gesündeste" ; -- status=guess
lin nurse_V2 = mkV2 (regV "stillen") ; -- status=guess, src=wikt
lin discharge_N = mkN "Entlassung" ; -- status=guess
lin comparative_A = mkA "vergleichend" ; -- status=guess
lin cluster_N = mkN "Streubombe" feminine ; -- status=guess
lin propose_VV = mkVV (irregV "einen" "eint" "einte" "einte" "geeint") ; -- status=guess, src=wikt
lin propose_VS = mkVS (irregV "einen" "eint" "einte" "einte" "geeint") ; -- status=guess, src=wikt
lin propose_V2 = mkV2 (irregV "einen" "eint" "einte" "einte" "geeint") ; -- status=guess, src=wikt
lin propose_V = irregV "einen" "eint" "einte" "einte" "geeint" ; -- status=guess, src=wikt
lin obstacle_N = mkN "Hindernis" "Hindernisse" neuter ; -- status=guess
lin motorway_N = autobahn_N ; -- status=guess
lin heritage_N = mkN "Geburtsrecht" neuter | mkN "Erbe" neuter ; -- status=guess status=guess
lin counselling_N = variants{} ; -- 
lin breeding_N = variants{} ; -- 
lin characteristic_A = mk3A "charakteristisch" "charakteristischer" "charakteristischste" | mkA "bezeichnend" | regA "kennzeichnend" | mk3A "typisch" "typischer" "typischste" ; -- status=guess status=guess status=guess status=guess
lin bucket_N = mkN "Ein-Euro-Job" "Ein-Euro-Jobs" masculine ; -- status=guess
lin migration_N = mkN "Migration" ; -- status=guess
lin campaign_V = mkReflV "einsetzen" ; -- status=guess, src=wikt
lin ritual_N = mkN "Ritual" neuter ; -- status=guess
lin originate_V2 = mkV2 (irregV "entwickeln" "entwickelt" "entwickelte" "entwickelte" "entwickelt" | irregV "erzeugen" "erzeugt" "erzeugte" "erzeugte" "erzeugt") ; -- status=guess, src=wikt status=guess, src=wikt
lin originate_V = irregV "entwickeln" "entwickelt" "entwickelte" "entwickelte" "entwickelt" | irregV "erzeugen" "erzeugt" "erzeugte" "erzeugte" "erzeugt" ; -- status=guess, src=wikt status=guess, src=wikt
lin hunting_N = mkN "Jagd" "Jagden" feminine ; -- status=guess
lin crude_A = mk3A "roh" "roher" "rohstenroheste" ; -- status=guess
lin protocol_N = variants{} ; -- 
lin prejudice_N = mkN "Vorurteil" "Vorurteile" neuter | mkN "Voreingenommenheit" feminine ; -- status=guess status=guess
lin inspiration_N = mkN "Einatmung" feminine | mkN "Einatmen" neuter ; -- status=guess status=guess
lin dioxide_N = mkN "Dioxid" "Dioxide" neuter ; -- status=guess
lin chemical_A = regA "chemisch" ; -- status=guess
lin uncomfortable_A = mk3A "unbehaglich" "unbehaglicher" "unbehaglichste" ; -- status=guess
lin worthy_A = mkA "würdig" ; -- status=guess
lin inspect_V2 = mkV2 (mkV "begutachten" | irregV "untersuchen" "untersucht" "untersuchte" "untersuchte" "untersucht" | mkV "inspizieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin summon_V2 = mkV2 (prefixV "vor" (irregV "laden" "lädt" "lud" "lüde" "geladen")) ; -- status=guess, src=wikt
lin parallel_N = barren_N ; -- status=guess
lin outlet_N = mkN "Direktverkauf" masculine ; -- status=guess
lin okay_A = variants{} ; -- 
lin collaboration_N = mkN "Kollektivarbeit" feminine | mkN "Zusammenarbeit" feminine | mkN "Kollaboration" feminine ; -- status=guess status=guess status=guess
lin booking_N = mkN "Buchung" | mkN "Reservierung" feminine ; -- status=guess status=guess
lin salad_N = salat_N ; -- status=guess
lin productive_A = mk3A "produktiv" "produktiver" "produktivste" ; -- status=guess
lin charming_A = mk3A "charmant" "charmanter" "charmanteste" ; -- status=guess
lin polish_A = variants{} ; -- 
lin oak_N = mkN "Eiche" "Eichen" feminine ; -- status=guess
lin access_V2 = mkV2 (junkV (mkV "Zugang") "haben") ; -- status=guess, src=wikt
lin tourism_N = mkN "Tourismus" masculine ; -- status=guess
lin independently_Adv = mkAdv "unabhängig" | mkAdv "selbstständig" ; -- status=guess status=guess
lin cruel_A = mk3A "grausam" "grausamer" "grausamste" ; -- status=guess
lin diversity_N = mkN "Vielfältigkeit" feminine | mkN "Mannigfaltigkeit" "Mannigfaltigkeiten" feminine | mkN "Vielfalt" feminine | mkN "Diversität" feminine ; -- status=guess status=guess status=guess status=guess
lin accused_A = mkA "angeklagt" ; -- status=guess
lin supplement_N = mkN "Ergänzung" feminine | mkN "Nachtrag" "Nachträge" masculine ; -- status=guess status=guess
lin fucking_Adv = variants{} ; -- 
lin forecast_N = mkN "Schätzung" feminine ; -- status=guess
lin amend_V2V = mkV2V (irregV "verbessern" "verbessert" "verbesserte" "verbesserte" "verbessert") ; -- status=guess, src=wikt
lin amend_V2 = mkV2 (irregV "verbessern" "verbessert" "verbesserte" "verbesserte" "verbessert") ; -- status=guess, src=wikt
lin amend_V = irregV "verbessern" "verbessert" "verbesserte" "verbesserte" "verbessert" ; -- status=guess, src=wikt
lin soap_N = mkN "Seife" "Seifen" feminine ; -- status=guess
lin ruling_N = mkN "Reißfeder" feminine ; -- status=guess
lin interference_N = mkN "Störung" feminine ; -- status=guess
lin executive_A = mkA "exekutiv" ; -- status=guess
lin mining_N = mkN "Bergbau" masculine ; -- status=guess
lin minimal_A = regA "minimal" ; -- status=guess
lin clarify_V2 = variants{} ; -- 
lin clarify_V = variants{} ; -- 
lin strain_V2 = variants{} ; -- 
lin novel_A = regA "neuartig" | mk3A "neu" "neuer" "neusten, neueste" ; -- status=guess status=guess
lin try_N = mkN "Versuch" "Versuche" masculine ; -- status=guess
lin coastal_A = mkA "Küsten-" ; -- status=guess
lin rising_A = mkA "steigend" | mkA "aufgehend" ; -- status=guess status=guess
lin quota_N = quote_N ; -- status=guess
lin minus_Prep = variants{} ; -- 
lin kilometre_N = mkN "Kilometer" "Kilometer" masculine ; -- status=guess
lin characterize_V2 = mkV2 (irregV "charakterisieren" "charakterisiert" "charakterisierte" "charakterisiere" "charakterisiert") ; -- status=guess, src=wikt
lin suspicious_A = mkA "verdächtig" ; -- status=guess
lin pet_N = mkN "Haustier" "Haustiere" neuter | mkN "Heimtier" "Heimtiere" neuter ; -- status=guess status=guess
lin beneficial_A = mkA "nützlich" | mk3A "vorteilhaft" "vorteilhafter" "vorteilhafteste" ; -- status=guess status=guess
lin fling_V2 = mkV2 (regV "schleudern") ; -- status=guess, src=wikt
lin fling_V = regV "schleudern" ; -- status=guess, src=wikt
lin deprive_V2 = mkV2 (prefixV "ab" (irregV "erkennen" "erkennt" "erkannte" "erkannte" "erkannt") | prefixV "weg" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen") | mkV "berauben" | irregV "verweigern" "verweigert" "verweigerte" "verweigerte" "verweigert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin covenant_N = mkN "Zusage" "Zusagen" feminine ; -- status=guess
lin bias_N = mkN "Voreingenommenheit" feminine ; -- status=guess
lin trophy_N = mkN "Trophäe" feminine ; -- status=guess
lin verb_N = mkN "Verb" "Verben" neuter | mkN "Verbum" "Verba" neuter | mkN "Zeitwort" "Zeitwörter" neuter ; -- status=guess status=guess status=guess
lin honestly_Adv = mkAdv "ehrlich" ; -- status=guess
lin extract_N = variants{} ; -- 
lin straw_N = mkN "Halm" "Halme" masculine | mkN "Strohhalm" "Strohhalme" masculine ; -- status=guess status=guess
lin stem_V2 = mkV2 (irregV "kommen" "kommt" "kam" "käme" "gekommen" | junkV (mkV "herrühren") "von") ; -- status=guess, src=wikt status=guess, src=wikt
lin stem_V = irregV "kommen" "kommt" "kam" "käme" "gekommen" | junkV (mkV "herrühren") "von" ; -- status=guess, src=wikt status=guess, src=wikt
lin eyebrow_N = mkN "Augenbraue" "Augenbrauen" feminine ; -- status=guess
lin noble_A = mk3A "nobel" "nobler" "nobelste" | mkA "adel" | mk3A "edel" "edler" "edelste" ; -- status=guess status=guess status=guess
lin mask_N = mkN "Maske" "Masken" feminine ; -- status=guess
lin lecturer_N = mkN "Lektor" "Lektoren" masculine ; -- status=guess
lin girlfriend_N = mkN "Freundin" "Freundinnen" feminine ; -- status=guess
lin forehead_N = mkN "Stirn" "Stirnen" feminine ; -- status=guess
lin timetable_N = mkN "Zeitplan" masculine | mkN "Fahrplan" "Fahrpläne" masculine | mkN "Stundenplan" "Stundenpläne" masculine | mkN "etc.)" ; -- status=guess status=guess status=guess status=guess
lin symbolic_A = regA "symbolisch" ; -- status=guess
lin farming_N = variants{} ; -- 
lin lid_N = mkN "Deckel" "Deckel" masculine ; -- status=guess
lin librarian_N = mkN "Bibliothekar" "Bibliothekare" masculine | mkN "Bibliothekarin" "Bibliothekarinnen" feminine ; -- status=guess status=guess
lin injection_N = mkN "Injektion" ; -- status=guess
lin sexuality_N = mkN "Sexualität" feminine ; -- status=guess
lin irrelevant_A = regA "irrelevant" ; -- status=guess
lin bonus_N = mkN "Bonus" masculine | mkN "Prämie" feminine ; -- status=guess status=guess
lin abuse_V2 = mkV2 (mkV "missbrauchen") ; -- status=guess, src=wikt
lin thumb_N = mkN "Daumen" "Daumen" masculine ; -- status=guess
lin survey_V2 = variants{} ; -- 
lin ankle_N = mkN "Knöchel" masculine | mkN "Fußknöchel" masculine | mkN "Enkel" "Enkel" masculine ; -- status=guess status=guess status=guess
lin psychologist_N = mkN "Psychologe" "Psychologen" masculine | mkN "Psychologin" feminine ; -- status=guess status=guess
lin occurrence_N = mkN "Vorfall" "Vorfälle" masculine ; -- status=guess
lin profitable_A = mkA "gewinnbringend" | mk3A "profitabel" "profitabler" "profitabelste" | mk3A "lukrativ" "lukrativer" "lukrativste" ; -- status=guess status=guess status=guess
lin deliberate_A = mkA "wohlerwogen" | mkA "wohlüberlegt" | mkA "überlegt" ; -- status=guess status=guess status=guess
lin bow_V2 = mkV2 (mkReflV "biegen") | mkV2 (mkReflV "verbiegen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bow_V = mkReflV "biegen" | mkReflV "verbiegen" ; -- status=guess, src=wikt status=guess, src=wikt
lin tribe_N = mkN "Stamm" "Stämme" masculine | mkN "Volksstamm" "Volksstämme" masculine | mkN "Sippe" "Sippen" feminine | mkN "Volk" "Völker" neuter | mkN "Völkchen" neuter | mkN "Völklein" neuter | mkN "Sippschaft" feminine | mkN "Tribus" "Tribus" feminine | mkN "Völkerschaft" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin rightly_Adv = variants{} ; -- 
lin representative_A = mkA "repräsentativ" ; -- status=guess
lin code_V2 = variants{} ; -- 
lin validity_N = variants{} ; -- 
lin marble_N = mkN "Marmor" "Marmore" masculine ; -- status=guess
lin bow_N = mkN "Pfeil" "Pfeile" masculine ; -- status=guess
lin plunge_V2 = variants{} ; -- 
lin plunge_V = variants{} ; -- 
lin maturity_N = variants{} ; -- 
lin maturity_3_N = variants{} ; -- 
lin maturity_2_N = variants{} ; -- 
lin maturity_1_N = variants{} ; -- 
lin hidden_A = mkA "versteckt" | mkA "verborgen" ; -- status=guess status=guess
lin contrast_V2 = mkV2 (mkV "gegenüberstellen" | irregV "kontrastieren" "kontrastiert" "kontrastierte" "kontrastierte" "kontrastiert") ; -- status=guess, src=wikt status=guess, src=wikt
lin contrast_V = mkV "gegenüberstellen" | irregV "kontrastieren" "kontrastiert" "kontrastierte" "kontrastierte" "kontrastiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin tobacco_N = mkN "Tabakpflanze" feminine ; -- status=guess
lin middle_class_A = variants{} ; -- 
lin grip_V2 = mkV2 (prefixV "fest" (irregV "halten" "hält" "hielt" "hielte" "gehalten") | irregV "greifen" "greift" "griff" "griffe" "gegriffen") ; -- status=guess, src=wikt status=guess, src=wikt
lin clergy_N = mkN "Geistlichkeit" feminine | mkN "Klerus" masculine ; -- status=guess status=guess
lin trading_A = variants{} ; -- 
lin passive_A = mk3A "passiv" "passiver" "passivste" | mkA "passivisch" ; -- status=guess status=guess
lin decoration_N = mkN "Dekorieren" neuter | mkN "Verschönern" neuter ; -- status=guess status=guess
lin racial_A = mkA "rassisch" | mkA "Rassen-" ; -- status=guess status=guess
lin well_N = mkN "Brunnen" "Brunnen" masculine ; -- status=guess
lin embarrassment_N = variants{} ; -- 
lin sauce_N = mkN "Soße" feminine | mkN "Sauce" "Saucen" feminine ; -- status=guess status=guess
lin fatal_A = mkA "verhängnisvoll" | mk3A "fatal" "fataler" "fatalste" ; -- status=guess status=guess
lin banker_N = mkN "Bankier" "Bankiers" masculine ; -- status=guess
lin compensate_V2 = mkV2 (irregV "kompensieren" "kompensiert" "kompensierte" "kompensierte" "kompensiert") ; -- status=guess, src=wikt
lin compensate_V = irregV "kompensieren" "kompensiert" "kompensierte" "kompensierte" "kompensiert" ; -- status=guess, src=wikt
lin make_up_N = variants{} ; -- 
lin popularity_N = mkN "Popularität" feminine ; -- status=guess
lin interior_A = variants{} ; -- 
lin eligible_A = mkA "erwünscht" ; -- status=guess
lin continuity_N = mkN "Kontinuität" feminine ; -- status=guess
lin bunch_N = mkN "Bund" masculine | mkN "Strauß" masculine ; -- status=guess status=guess status=guess
lin hook_N = mkN "Haken" "Haken" masculine | mkN "Angelhaken" "Angelhaken" masculine ; -- status=guess status=guess
lin wicket_N = variants{} ; -- 
lin pronounce_V2 = mkV2 (mkV "verkünden") ; -- status=guess, src=wikt
lin pronounce_V = mkV "verkünden" ; -- status=guess, src=wikt
lin ballet_N = mkN "Ballett" "Ballette" neuter ; -- status=guess
lin heir_N = mkN "Thronerbe" masculine ; -- status=guess
lin positively_Adv = mkAdv "definitiv" | mkAdv "bestimmt" | mkAdv "entschieden" | mkAdv "eindeutig" ; -- status=guess status=guess status=guess status=guess
lin insufficient_A = regA "unzureichend" | mkA "ungenügend" ; -- status=guess status=guess
lin substitute_V2 = mkV2 (irregV "ersetzen" "ersetzt" "ersetzte" "ersetzte" "ersetzt") ; -- status=guess, src=wikt
lin substitute_V = irregV "ersetzen" "ersetzt" "ersetzte" "ersetzte" "ersetzt" ; -- status=guess, src=wikt
lin mysterious_A = mkA "rätselhaft" ; -- status=guess
lin dancer_N = mkN "Tänzerin" feminine | mkN "Tänzer" masculine ; -- status=guess status=guess
lin trail_N = spur_N ; -- status=guess
lin caution_N = mkN "Vorsicht" feminine | mkN "Achtsamkeit" "Achtsamkeiten" feminine | mkN "Behutsamkeit" feminine ; -- status=guess status=guess status=guess
lin donation_N = mkN "Abgabe" "Abgaben" feminine | mkN "Spende" "Spenden" feminine ; -- status=guess status=guess
lin added_A = variants{} ; -- 
lin weaken_V2 = mkV2 (mkV "schwächen") ; -- status=guess, src=wikt
lin weaken_V = mkV "schwächen" ; -- status=guess, src=wikt
lin tyre_N = mkN "Reifen" "Reifen" masculine ; -- status=guess
lin sufferer_N = variants{} ; -- 
lin managerial_A = variants{} ; -- 
lin elaborate_A = mkA "ausführlich" | mkA "durchdacht" ; -- status=guess status=guess
lin restraint_N = mkN "Zurückhaltung" feminine ; -- status=guess
lin renew_V2 = mkV2 (irregV "erneuern" "erneuert" "erneuerte" "erneuerte" "erneuert") ; -- status=guess, src=wikt
lin gardenerMasc_N = reg2N "Gärtner" "Gärtner" masculine;
lin dilemma_N = mkN "Dilemma" neuter ; -- status=guess
lin configuration_N = mkN "Konfiguration" ; -- status=guess
lin rear_A = variants{} ; -- 
lin embark_V2 = mkV2 (mkV "einschiffen") ; -- status=guess, src=wikt
lin embark_V = mkV "einschiffen" ; -- status=guess, src=wikt
lin misery_N = mkN "Misere" "Miseren" feminine | mkN "Elend" neuter ; -- status=guess status=guess
lin importantly_Adv = variants{} ; -- 
lin continually_Adv = variants{} ; -- 
lin appreciation_N = mkN "Anerkennung" | mkN "Würdigung" feminine | mkN "Dankbarkeit" "Dankbarkeiten" feminine | mkN "Wertschätzung" feminine ; -- status=guess status=guess status=guess status=guess
lin radical_N = mkN "Radikal" "Radikale" neuter ; -- status=guess
lin diverse_A = mk3A "verschieden" "verschiedner, verschiedener" "verschiedenste" | mk3A "unterschiedlich" "unterschiedlicher" "unterschiedlichste" ; -- status=guess status=guess
lin revive_V2 = mkV2 (prefixV "wieder" (regV "beleben")) ; -- status=guess, src=wikt
lin revive_V = prefixV "wieder" (regV "beleben") ; -- status=guess, src=wikt
lin trip_V = regV "stolpern" ; -- status=guess, src=wikt
lin lounge_N = mkN "Lounge" "Lounges" feminine ; -- status=guess
lin dwelling_N = mkN "Wohnsitz" "Wohnsitze" masculine | mkN "Wohnung" ; -- status=guess status=guess
lin parental_A = regA "elterlich" ; -- status=guess
lin loyal_A = mk3A "loyal" "loyaler" "loyalste" | mk3A "treu" "treuer" "treusten, treueste" ; -- status=guess status=guess
lin privatisation_N = variants{} ; -- 
lin outsider_N = mkN "Außenseiter" masculine | mkN "Außenseiterin" feminine ; -- status=guess status=guess
lin forbid_V2 = mkV2 (irregV "verbieten" "verbietet" "verbot" "verböte" "verboten" | irregV "untersagen" "untersagt" "untersagte" "untersagte" "untersagt") ; -- status=guess, src=wikt status=guess, src=wikt
lin yep_Interj = variants{} ; -- 
lin prospective_A = regA "voraussichtlich" ; -- status=guess
lin manuscript_N = mkN "Manuskript" "Manuskripte" neuter | mkN "Handschrift" "Handschriften" feminine | mkN "Kodex" masculine ; -- status=guess status=guess status=guess
lin inherent_A = regA "innewohnend" | mkA "inhärent" ; -- status=guess status=guess
lin deem_V2V = mkV2V (irregV "halten" "hält" "hielt" "hielte" "gehalten" | mkV "erachten") ; -- status=guess, src=wikt status=guess, src=wikt
lin deem_V2A = mkV2A (irregV "halten" "hält" "hielt" "hielte" "gehalten" | mkV "erachten") ; -- status=guess, src=wikt status=guess, src=wikt
lin deem_V2 = mkV2 (irregV "halten" "hält" "hielt" "hielte" "gehalten" | mkV "erachten") ; -- status=guess, src=wikt status=guess, src=wikt
lin telecommunication_N = variants{} ; -- 
lin intermediate_A = variants{} ; -- 
lin worthwhile_A = mkA "lohnend" | mk3A "wertvoll" "wertvoller" "wertvollste" ; -- status=guess status=guess
lin calendar_N = mkN "Kalender" "Kalender" masculine ; -- status=guess
lin basin_N = mkN "Becken" "Becken" neuter | mkN "Waschbecken" "Waschbecken" neuter ; -- status=guess status=guess
lin utterly_Adv = variants{} ; -- 
lin rebuild_V2 = mkV2 (mkV "wiederaufbauen") | mkV2 (mkV "umbauen") ; -- status=guess, src=wikt status=guess, src=wikt
lin pulse_N = mkN "Puls" "Pulse" masculine ; -- status=guess
lin suppress_V2 = mkV2 (mkV "unterdrücken") ; -- status=guess, src=wikt
lin predator_N = mkN "Raubtier" "Raubtiere" neuter ; -- status=guess
lin width_N = mkN "Breite" "Breiten" feminine | mkN "Weite" "Weiten" feminine ; -- status=guess status=guess
lin stiff_A = mk3A "steif" "steifer" "steifste" | mk3A "starr" "starrer" "starrste" ; -- status=guess status=guess
lin spine_N = mkN "Rückgrat" neuter | mkN "Wirbelsäule" feminine ; -- status=guess status=guess
lin betray_V2 = mkV2 (irregV "verraten" "verrät" "verriet" "verriete" "verraten") ; -- status=guess, src=wikt
lin punish_V2 = mkV2 (regV "bestrafen" | regV "strafen") ; -- status=guess, src=wikt status=guess, src=wikt
lin stall_N = mkN "Stall" "Ställe" masculine ; -- status=guess
lin lifestyle_N = mkN "Lebensstil" "Lebensstile" masculine | mkN "Lebensweise" "Lebensweisen" feminine ; -- status=guess status=guess
lin compile_V2 = mkV2 (mkV "zusammenstellen") ; -- status=guess, src=wikt
lin arouse_V2V = mkV2V (irregV "erregen" "erregt" "erregte" "erregte" "erregt") ; -- status=guess, src=wikt
lin arouse_V2 = mkV2 (irregV "erregen" "erregt" "erregte" "erregte" "erregt") ; -- status=guess, src=wikt
lin partially_Adv = mkAdv "teilweise" | mkAdv "teils" ; -- status=guess status=guess
lin headline_N = mkN "Schlagzeile" "Schlagzeilen" feminine ; -- status=guess
lin divine_A = mkA "göttlich" ; -- status=guess
lin unpleasant_A = mk3A "unangenehm" "unangenehmer" "unangenehmste" ; -- status=guess
lin sacred_A = mk3A "heilig" "heiliger" "heiligste" ; -- status=guess
lin useless_A = mk3A "nutzlos" "nutzloser" "nutzloseste" | mkA "unnützlich" ; -- status=guess status=guess
lin cool_V2 = mkV2 (mkV "abkühlen") ; -- status=guess, src=wikt
lin cool_V = mkV "abkühlen" ; -- status=guess, src=wikt
lin tremble_V = irregV "zittern" "zittert" "zitterte" "zitterte" "gezittert" ; -- status=guess, src=wikt
lin statue_N = mkN "Statue" "Statuen" feminine | mkN "Standbild" neuter ; -- status=guess status=guess
lin obey_V2 = mkV2 (irregV "gehorchen" "gehorcht" "gehorchte" "gehorchte" "gehorcht") ; -- status=guess, src=wikt
lin obey_V = irregV "gehorchen" "gehorcht" "gehorchte" "gehorchte" "gehorcht" ; -- status=guess, src=wikt
lin drunk_A = mk3A "betrunken" "betrunkener" "betrunkenste" | mk3A "besoffen" "besoffener" "besoffenste" ; -- status=guess status=guess
lin tender_A = mk3A "zart" "zarter" "zarteste" | mkA "zärtlich" | mk3A "lieb" "lieber" "liebste" | mk3A "liebevoll" "liebevoller" "liebevollste" ; -- status=guess status=guess status=guess status=guess
lin molecular_A = regA "molekular" ; -- status=guess
lin circulate_V2 = variants{} ; -- 
lin circulate_V = variants{} ; -- 
lin exploitation_N = variants{} ; -- 
lin explicitly_Adv = variants{} ; -- 
lin utterance_N = mkN "Sprechfähigkeit" feminine | mkN "Sprachvermögen" neuter ; -- status=guess status=guess
lin linear_A = mk3A "linear" "linearer" "linearste" ; -- status=guess
lin chat_V = mkReflV "unterhalten" | regV "plaudern" | regV "schwatzen" | mkV "klönen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin revision_N = mkN "Wiederholung" | mkN "Überarbeitung" feminine ; -- status=guess status=guess
lin distress_N = mkN "Not" "Nöte" feminine | mkN "Notlage" "Notlagen" feminine | mkN "Seenot" feminine ; -- status=guess status=guess status=guess
lin spill_V2 = mkV2 (mkReflV "ergießen") ; -- status=guess, src=wikt
lin spill_V = mkReflV "ergießen" ; -- status=guess, src=wikt
lin steward_N = mkN "Verwalter" masculine ; -- status=guess
lin knight_N = springer_N ; -- status=guess
lin sum_V2 = mkV2 (regV "summieren") ; -- status=guess, src=wikt
lin sum_V = regV "summieren" ; -- status=guess, src=wikt
lin semantic_A = regA "semantisch" ; -- status=guess
lin selective_A = mkA "wählerisch" ; -- status=guess
lin learner_N = mkN "Lerner" "Lerner" masculine | mkN "Lernender" ; -- status=guess status=guess
lin dignity_N = mkN "Würde" feminine ; -- status=guess
lin senate_N = mkN "Senat" "Senate" masculine ; -- status=guess
lin grid_N = mkN "Gitter" "Gitter" neuter ; -- status=guess
lin fiscal_A = variants{} ; -- 
lin activate_V2 = mkV2 (regV "aktivieren") ; -- status=guess, src=wikt
lin rival_A = variants{} ; -- 
lin fortunate_A = variants{} ; -- 
lin jeans_N = mkN "Jeans" "Jeans" feminine | mkN "Jeanshose" "Jeanshosen" feminine ; -- status=guess status=guess
lin select_A = variants{} ; -- 
lin fitting_N = variants{} ; -- 
lin commentator_N = mkN "Kommentator" masculine ; -- status=guess
lin weep_V2 = mkV2 (regV "weinen") ; -- status=guess, src=wikt
lin weep_V = regV "weinen" ; -- status=guess, src=wikt
lin handicap_N = mkN "Vorsprung" ; -- status=guess
lin crush_V2 = variants{} ; -- 
lin crush_V = variants{} ; -- 
lin towel_N = mkN "Handtuch" "Handtücher" neuter ; -- status=guess
lin stay_N = variants{} ; -- 
lin skilled_A = mkA "erfahren" ; -- status=guess
lin repeatedly_Adv = mkAdv "wiederholt" ; -- status=guess
lin defensive_A = mk3A "defensiv" "defensiver" "defensivste" ; -- status=guess
lin calm_V2 = mkV2 (regV "beruhigen" | junkV (mkV "ruhig") "stellen") ; -- status=guess, src=wikt status=guess, src=wikt
lin calm_V = regV "beruhigen" | junkV (mkV "ruhig") "stellen" ; -- status=guess, src=wikt status=guess, src=wikt
lin temporarily_Adv = mkAdv "vorübergehend" ; -- status=guess
lin rain_V2 = mkV2 (junkV (mkV "Bindfäden") "regnen") | mkV2 (junkV (mkV "in") "Strömen regnen") | mkV2 (junkV (mkV "aus") "allen Kannen gießen") | mkV2 (junkV (mkV "aus") "allen Kannen schütten") | mkV2 (junkV (mkV "wie") "aus Eimern schütten") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rain_V = junkV (mkV "Bindfäden") "regnen" | junkV (mkV "in") "Strömen regnen" | junkV (mkV "aus") "allen Kannen gießen" | junkV (mkV "aus") "allen Kannen schütten" | junkV (mkV "wie") "aus Eimern schütten" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin pin_N = mkN "Anstecker" masculine ; -- status=guess
lin villa_N = mkN "Villa" "Villen" feminine ; -- status=guess
lin rod_N = mkN "Stäbchen" neuter ; -- status=guess
lin frontier_N = mkN "Grenze" "Grenzen" feminine ; -- status=guess
lin enforcement_N = variants{} ; -- 
lin protective_A = mkA "Schutz-" ; -- status=guess
lin philosophical_A = mk3A "philosophisch" "philosophischer" "philosophischste" ; -- status=guess
lin lordship_N = mkN "der&nbsp;Damenflügel" "die&nbsp;Damenflügel" masculine ; -- status=guess
lin disagree_VS = variants{} ; -- 
lin disagree_V2 = variants{} ; -- 
lin disagree_V = variants{} ; -- 
lin boyfriend_N = mkN "Freund" "Freunde" masculine ; -- status=guess
lin activistMasc_N = reg2N "Aktivist" "Aktivisten" masculine;
lin viewer_N = mkN "Zuschauer" "Zuschauer" masculine | mkN "Zuschauerin" "Zuschauerinnen" feminine ; -- status=guess status=guess
lin slim_A = mk3A "schlank" "schlanker" "schlankste" ; -- status=guess
lin textile_N = mkN "Textilie" feminine ; -- status=guess
lin mist_N = mkN "Nebel" "Nebel" masculine | mkN "Dunst" "Dünste" masculine ; -- status=guess status=guess
lin harmony_N = mkN "Harmonie" "Harmonien" feminine ; -- status=guess
lin deed_N = tat_N | mkN "Akt" "Akte" masculine ; -- status=guess status=guess
lin merge_V2 = mkV2 (mkV "verschmelzen") ; -- status=guess, src=wikt
lin merge_V = mkV "verschmelzen" ; -- status=guess, src=wikt
lin invention_N = mkN "Erfinden" neuter ; -- status=guess
lin commissioner_N = mkN "Kommissionsmitglied" neuter | mkN "Kommissar" "Kommissare" masculine ; -- status=guess status=guess
lin caravan_N = mkN "Karawane" "Karawanen" feminine ; -- status=guess
lin bolt_N = mkN "Riegel" "Riegel" masculine ; -- status=guess
lin ending_N = mkN "Endung" ; -- status=guess
lin publishing_N = mkN "Verlagswesen" neuter ; -- status=guess
lin gut_N = mkN "Bauch" "Bäuche" masculine | mkN "Ranzen" "Ranzen" masculine ; -- status=guess status=guess
lin stamp_V2 = mkV2 (prefixV "frei" (regV "machen")) ; -- status=guess, src=wikt
lin stamp_V = prefixV "frei" (regV "machen") ; -- status=guess, src=wikt
lin map_V2 = mkV2 (prefixV "ab" (regV "bilden")) ; -- status=guess, src=wikt
lin loud_Adv = variants{} ; -- 
lin stroke_V2 = mkV2 (regV "streicheln" | irregV "streichen" "streicht" "strich" "striche" "gestrichen") ; -- status=guess, src=wikt status=guess, src=wikt
lin shock_V2 = mkV2 (regV "schockieren") ; -- status=guess, src=wikt
lin rug_N = mkN "Teppich" "Teppiche" masculine | mkN "Brücke" feminine ; -- status=guess status=guess
lin picture_V2 = mkV2 (junkV (mkV "etwas") "vorstellen") ; -- status=guess, src=wikt
lin slip_N = mkN "Ausrutscher" "Ausrutscher" masculine ; -- status=guess
lin praise_N = lob_N ; -- status=guess
lin fine_N = mkN "Bußgeld" neuter | mkN "Geldbuße" feminine | mkN "Geldstrafe" "Geldstrafen" feminine ; -- status=guess status=guess status=guess
lin monument_N = mkN "Denkmal" neuter | mkN "Monument" neuter ; -- status=guess status=guess
lin material_A = mk3A "materiell" "materieller" "materiellste" ; -- status=guess
lin garment_N = mkN "Kleidungsstück" neuter ; -- status=guess
lin toward_Prep = variants{} ; -- 
lin realm_N = reich_N | mkN "Königreich" neuter ; -- status=guess status=guess
lin melt_V2 = mkV2 (irregV "schmelzen" "schmelzt" "schmolz" "schmölze" "geschmolzen") ; -- status=guess, src=wikt
lin melt_V = irregV "schmelzen" "schmelzt" "schmolz" "schmölze" "geschmolzen" ; -- status=guess, src=wikt
lin reproduction_N = mkN "Fortpflanzung" feminine | mkN "Reproduktion" feminine ; -- status=guess status=guess
lin reactor_N = mkN "Reagenz" "Reagenzien" neuter ; -- status=guess
lin furious_A = variants{} ; -- 
lin distinguished_A = variants{} ; -- 
lin characterize_V2 = mkV2 (irregV "charakterisieren" "charakterisiert" "charakterisierte" "charakterisiere" "charakterisiert") ; -- status=guess, src=wikt
lin alike_Adv = variants{} ; -- 
lin pump_N = mkN "Pumpe" "Pumpen" feminine ; -- status=guess
lin probe_N = variants{} ; -- 
lin feedback_N = mkN "Rückmeldung" feminine ; -- status=guess
lin aspiration_N = mkN "Aspiration" ; -- status=guess
lin suspect_N = mkN "Verdächtiger" masculine | mkN "Verdächtige" feminine ; -- status=guess status=guess
lin solar_A = regA "solar" ; -- status=guess
lin fare_N = mkN "Schwarzfahrer" "Schwarzfahrer" masculine | mkN "blinder Passagier" masculine ; -- status=guess status=guess
lin carve_V2 = mkV2 (irregV "schneiden" "schneidet" "schnitt" "schnitte" "geschnitten") ; -- status=guess, src=wikt
lin carve_V = irregV "schneiden" "schneidet" "schnitt" "schnitte" "geschnitten" ; -- status=guess, src=wikt
lin qualified_A = mkA "qualifiziert" ; -- status=guess
lin membrane_N = mkN "Membran" "Membranen" feminine;
lin dependence_N = mkN "Abhängigkeit" feminine ; -- status=guess
lin convict_V2 = mkV2 (mkV "verurteilen") ; -- status=guess, src=wikt
lin bacteria_N = mkN "Bakterien" ; -- status=guess
lin trading_N = mkN "Handelspartner" masculine ; -- status=guess
lin ambassador_N = mkN "Botschafter" "Botschafter" masculine ; -- status=guess
lin wound_V2 = mkV2 (irregV "verletzen" "verletzt" "verletzte" "verletzte" "verletzt") ; -- status=guess, src=wikt
lin drug_V2 = variants{} ; -- 
lin conjunction_N = mkN "Konjunktion" ; -- status=guess
lin cabin_N = mkN "Kabine" "Kabinen" feminine | mkN "Kajüte" feminine ; -- status=guess status=guess
lin trail_V2 = mkV2 (mkV "Spur") ; -- status=guess, src=wikt
lin trail_V = mkV "Spur" ; -- status=guess, src=wikt
lin shaft_N = mkN "Schachtofen" masculine ; -- status=guess
lin treasure_N = mkN "Schatzkiste" feminine ; -- status=guess
lin inappropriate_A = regA "unangebracht" | regA "unangemessen" ; -- status=guess status=guess
lin half_Adv = mkAdv "halb" ; -- status=guess
lin attribute_N = mkN "Attribut" "Attribute" neuter ; -- status=guess
lin liquid_A = mkA "flüssig" ; -- status=guess
lin embassy_N = mkN "Botschaft" "Botschaften" feminine ; -- status=guess
lin terribly_Adv = variants{} ; -- 
lin exemption_N = mkN "Befreiung" | mkN "Freistellung" feminine ; -- status=guess status=guess
lin array_N = mkN "Feld" "Felder" neuter | mkN "general)" | mkN "Matrix" "Matrizen" feminine | mkN "Tabelle" "Tabellen" feminine | mkN "specific)" | mkN "Reihe" "Reihen" feminine | mkN "Zeile" "Zeilen" feminine | mkN "Spalte" "Spalten" feminine | mkN "contextual" | mkN "specific)" ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin tablet_N = mkN "Tablet-Computer" masculine | mkN "Tafel-Computer" masculine | mkN "Tafel-PC" masculine ; -- status=guess status=guess status=guess
lin sack_V2 = variants{} ; -- 
lin erosion_N = mkN "Erosion" ; -- status=guess
lin bull_N = mkN "Bulle" "Bullen" masculine | mkN "Stier" "Stiere" masculine | mkN "Bummal" ; -- status=guess status=guess status=guess
lin warehouse_N = mkN "Lager" neuter ; -- status=guess
lin unfortunate_A = mkA "unglücklich" | mkA "unglückselig" ; -- status=guess status=guess
lin promoter_N = variants{} ; -- 
lin compel_VV = mkVV (irregV "zwingen" "zwingt" "zwang" "zwänge" "gezwungen") ; -- status=guess, src=wikt
lin compel_V2V = mkV2V (irregV "zwingen" "zwingt" "zwang" "zwänge" "gezwungen") ; -- status=guess, src=wikt
lin compel_V2 = mkV2 (irregV "zwingen" "zwingt" "zwang" "zwänge" "gezwungen") ; -- status=guess, src=wikt
lin motivate_V2V = mkV2V (regV "motivieren") ; -- status=guess, src=wikt
lin motivate_V2 = mkV2 (regV "motivieren") ; -- status=guess, src=wikt
lin burning_A = mkA "brennend" ; -- status=guess
lin vitamin_N = mkN "Vitamin" "Vitamine" neuter ; -- status=guess
lin sail_N = mkN "Segel" "Segel" neuter ; -- status=guess
lin lemon_N = mkN "Zitrone" "Zitronen" feminine ; -- status=guess
lin foreigner_N = mkN "Ausländer" masculine | mkN "Ausländerin" feminine ; -- status=guess status=guess
lin powder_N = mkN "Puder" "Puder" masculine | mkN "Pulver" "Pulver" neuter ; -- status=guess status=guess
lin persistent_A = mkA "ständig" | regA "anhaltend" ; -- status=guess status=guess
lin bat_N = mkN "Schläger" masculine | mkN "Keule" "Keulen" feminine ; -- status=guess status=guess
lin ancestor_N = mkN "Vorfahr" masculine | mkN "Ahne" "Ahnen" masculine | mkN "Ahnin" feminine ; -- status=guess status=guess status=guess
lin predominantly_Adv = mkAdv "vorwiegend" | mkAdv "überwiegend" ; -- status=guess status=guess
lin mathematical_A = mk3A "mathematisch" "mathematischer" "mathematischste" ; -- status=guess
lin compliance_N = mkN "Einwilligung" | mkN "Fügsamkeit" feminine ; -- status=guess status=guess
lin arch_N = mkN "Bogen" ; -- status=guess
lin woodland_N = mkN "Wald" "Wälder" masculine | mkN "Forst" "Forste" masculine | mkN "Waldung" feminine | mkN "Waldland" neuter ; -- status=guess status=guess status=guess status=guess
lin serum_N = mkN "Serum" "Seren" neuter ; -- status=guess
lin overnight_Adv = mkAdv "über Nacht" ; -- status=guess
lin doubtful_A = mkA "zweifelnd" ; -- status=guess
lin doing_N = tun_N ; -- status=guess
lin coach_V2 = mkV2 (prefixV "aus" (irregV "bilden" "bildet" "bildete" "bildete" "gebildet")) ; -- status=guess, src=wikt
lin coach_V = prefixV "aus" (irregV "bilden" "bildet" "bildete" "bildete" "gebildet") ; -- status=guess, src=wikt
lin binding_A = mk3A "verbindlich" "verbindlicher" "verbindlichste" ; -- status=guess
lin surrounding_A = variants{} ; -- 
lin peer_N = mkN "Adeliger" masculine | mkN "Adelige" feminine | mkN "Edelmann" "Edelmänner" masculine | mkN "Edelfrau" "Edelfrauen" feminine ; -- status=guess status=guess status=guess status=guess
lin ozone_N = mkN "Ozon" neuter ; -- status=guess
lin mid_A = variants{} ; -- 
lin invisible_A = regA "unsichtbar" ; -- status=guess
lin depart_V = prefixV "ab" (regV "weichen") ; -- status=guess, src=wikt
lin brigade_N = mkN "Brigade" "Brigaden" feminine ; -- status=guess
lin manipulate_V2 = mkV2 (irregV "manipulieren" "manipuliert" "manipulierte" "manipulierte" "manipuliert") ; -- status=guess, src=wikt
lin consume_V2 = mkV2 (irregV "verbrauchen" "verbraucht" "verbrauchte" "verbrauchte" "verbraucht") ; -- status=guess, src=wikt
lin consume_V = irregV "verbrauchen" "verbraucht" "verbrauchte" "verbrauchte" "verbraucht" ; -- status=guess, src=wikt
lin temptation_N = mkN "Versuchung" | mkN "Verführung" feminine ; -- status=guess status=guess
lin intact_A = variants{} ; -- 
lin glove_N = L.glove_N ;
lin aggression_N = mkN "Aggression" | mkN "Angriff" "Angriffe" masculine ; -- status=guess status=guess
lin emergence_N = mkN "Emergenz" "Emergenzen" feminine ; -- status=guess
lin stag_V = variants{} ; -- 
lin coffin_N = mkN "Sarg" "Särge" masculine ; -- status=guess
lin beautifully_Adv = mkAdv "schön" ; -- status=guess
lin clutch_V2 = mkV2 (regV "schnappen" | regV "packen" | irregV "ergreifen" "ergreift" "ergriff" "ergriffe" "ergriffen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin clutch_V = regV "schnappen" | regV "packen" | irregV "ergreifen" "ergreift" "ergriff" "ergriffe" "ergriffen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin wit_N = mkN "Witzbold" "Witzbolde" masculine ; -- status=guess
lin underline_V2 = mkV2 (irregV "unterstreichen" "unterstreicht" "unterstrich" "unterstrich" "unterstrichen") ; -- status=guess, src=wikt
lin trainee_N = mkN "Praktikant" "Praktikanten" masculine | mkN "Praktikantin" feminine ;
lin scrutiny_N = mkN "genaue Untersuchung" | mkN "prüfender od. forschender Blick" ; -- status=guess status=guess
lin neatly_Adv = variants{} ; -- 
lin follower_N = variants{} ; -- 
lin sterling_A = variants{} ; -- 
lin tariff_N = variants{} ; -- 
lin bee_N = mkN "Biene" "Bienen" feminine | mkN "Imme" "Immen" feminine | mkN "Styrian: Beivogl" ; -- status=guess status=guess status=guess
lin relaxation_N = variants{} ; -- 
lin negligence_N = mkN "Fahrlässigkeit" feminine ; -- status=guess
lin sunlight_N = mkN "Sonnenlicht" neuter ; -- status=guess
lin penetrate_V2 = mkV2 (regV "penetrieren") ; -- status=guess, src=wikt
lin penetrate_V = regV "penetrieren" ; -- status=guess, src=wikt
lin knot_N = mkN "Beule" "Beulen" feminine ; -- status=guess
lin temper_N = mkN "Anlassen" neuter | mkN "Ausheizen" neuter ; -- status=guess status=guess
lin skull_N = mkN "Totenkopf" "Totenköpfe" masculine ; -- status=guess
lin openly_Adv = mkAdv "offen" | mkAdv "öffentlich" ; -- status=guess status=guess
lin grind_V2 = mkV2 (regV "mahlen" | mkV "zermahlen") ; -- status=guess, src=wikt status=guess, src=wikt
lin grind_V = regV "mahlen" | mkV "zermahlen" ; -- status=guess, src=wikt status=guess, src=wikt
lin whale_N = mkN "Wal" "Wale" masculine ; -- status=guess
lin throne_N = mkN "Thron" "Throne" masculine ; -- status=guess
lin supervise_V2 = mkV2 (mkV "beaufsichtigen") ; -- status=guess, src=wikt
lin supervise_V = mkV "beaufsichtigen" ; -- status=guess, src=wikt
lin sickness_N = mkN "Übelkeit" feminine ; -- status=guess
lin package_V2 = mkV2 (regV "packen" | prefixV "ein" (regV "packen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin intake_N = variants{} ; -- 
lin within_Adv = variants{}; -- mkPrep "innerhalb" genitive ;
lin inland_A = variants{} ; -- 
lin beast_N = tier_N | mkN "Bestie" "Bestien" feminine ; -- status=guess status=guess
lin rear_N = mkN "Nachhut" "Nachhuten" feminine ; -- status=guess
lin morality_N = moral_N ; -- status=guess
lin competent_A = mk3A "kompetent" "kompetenter" "kompetenteste" ; -- status=guess
lin sink_N = mkN "Waschbecken" "Waschbecken" neuter ; -- status=guess
lin uniform_A = regA "einheitlich" ; -- status=guess
lin reminder_N = mkN "Gedächtnisstütze" feminine ; -- status=guess
lin permanently_Adv = variants{} ; -- 
lin optimistic_A = mk3A "optimistisch" "optimistischer" "optimistischste" ; -- status=guess
lin bargain_N = variants{} ; -- 
lin seemingly_Adv = variants{} ; -- 
lin respective_A = regA "jeweilig" ; -- status=guess
lin horizontal_A = regA "horizontal" | regA "waagrecht" | regA "waagerecht" ; -- status=guess status=guess status=guess
lin decisive_A = mk3A "entscheidend" "entscheidender" "entscheidenste" | regA "ausschlaggebend" ; -- status=guess status=guess
lin bless_V2 = mkV2 (mkV "segnen" | regV "benedeien") ; -- status=guess, src=wikt status=guess, src=wikt
lin bile_N = mkN "Galle" "Gallen" feminine ; -- status=guess
lin spatial_A = mkA "räumlich" | mkA "Raum-" ; -- status=guess status=guess
lin bullet_N = mkN "Kugel" "Kugeln" feminine ; -- status=guess
lin respectable_A = mk3A "angesehen" "angesehener" "angesehenste" | mkA "geachtet" ; -- status=guess status=guess
lin overseas_Adv = mkAdv "im Ausland" ; -- status=guess
lin convincing_A = variants{} ; -- 
lin unacceptable_A = mkA "inakzeptabel" ; -- status=guess
lin confrontation_N = mkN "Konfrontation" ; -- status=guess
lin swiftly_Adv = variants{} ; -- 
lin paid_A = variants{} ; -- 
lin joke_V = regV "scherzen" | junkV (mkV "Witze") "machen" | junkV (mkV "Spaß") "machen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin instant_A = regA "augenblicklich" ; -- status=guess
lin illusion_N = mkN "Illusion" | mkN "Wahnvorstellung" | mkN "Sinnestäuschung" feminine ; -- status=guess status=guess status=guess
lin cheer_V2 = mkV2 (regV "jubeln" | mkV "aufmuntern" | mkV "aufheitern" | regV "applaudieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cheer_V = regV "jubeln" | mkV "aufmuntern" | mkV "aufheitern" | regV "applaudieren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin congregation_N = mkN "Versammlung" ; -- status=guess
lin worldwide_Adv = mkAdv "weltweit" ; -- status=guess
lin winning_A = variants{} ; -- 
lin wake_N = mkN "Kielwasser" neuter ; -- status=guess
lin toss_V2 = variants{} ; -- 
lin toss_V = variants{} ; -- 
lin medium_A = mkA "mittelgroß" ; -- status=guess
lin jewellery_N = schmuck_N | mkN "Juwelen" ; ---- {n} {p}" ; -- status=guess status=guess
lin fond_A = mkA "gern haben" | mkA "hängen an" | mkA "mögen" | mkA "lieben" ; -- status=guess status=guess status=guess status=guess
lin alarm_V2 = mkV2 (junkV (mkV "Alarm") "schlagen" | regV "alarmieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin guerrilla_N = mkN "Partisan" masculine ; -- status=guess
lin dive_V = junkV (mkV "eine") "Schwalbe vortäuschen" ; -- status=guess, src=wikt
lin desire_V2 = mkV2 (regV "begehren") ; -- status=guess, src=wikt
lin cooperation_N = mkN "Zusammenarbeit" feminine | mkN "Kooperation" | mkN "Mitarbeit" feminine ; -- status=guess status=guess status=guess
lin thread_N = mkN "Thema-Rhema-Progression " "Thema-Rhema-Progressionen" feminine | mkN "roter Faden" masculine ; -- status=guess status=guess
lin prescribe_V2 = mkV2 (irregV "verschreiben" "verschreibt" "verschrieb" "verschriebe" "verschrieben" | irregV "verordnen" "verordnet" "verordnete" "verordnete" "verordnet") ; -- status=guess, src=wikt status=guess, src=wikt
lin prescribe_V = irregV "verschreiben" "verschreibt" "verschrieb" "verschriebe" "verschrieben" | irregV "verordnen" "verordnet" "verordnete" "verordnete" "verordnet" ; -- status=guess, src=wikt status=guess, src=wikt
lin calcium_N = mkN "Kalzium" "Kalzien" neuter | mkN "Calcium" "Calcien" neuter ; -- status=guess status=guess
lin redundant_A = mk3A "redundant" "redundanter" "redundanteste" ; -- status=guess
lin marker_N = mkN "Markierungsschnittstelle" feminine ; -- status=guess
lin chemistMasc_N = reg2N "Chemiker" "Chemiker" masculine;
lin mammal_N = mkN "Säugetier" neuter ; -- status=guess
lin legacy_N = mkN "Wirken" neuter | mkN "Erbe" neuter ; -- status=guess status=guess
lin debtor_N = mkN "Schuldner" "Schuldner" masculine ; -- status=guess
lin testament_N = mkN "Testament" "Testamente" neuter ; -- status=guess
lin tragic_A = mk3A "tragisch" "tragischer" "tragischste" ; -- status=guess
lin silver_A = variants{} ; -- 
lin grin_N = mkN "Grinsen" neuter ; -- status=guess
lin spectacle_N = mkN "Spektakel" "Spektakel" neuter | mkN "Schauspiel" "Schauspiele" neuter ; -- status=guess status=guess
lin inheritance_N = mkN "Erbschaftsteuer" feminine | mkN "Erbschaftssteuer" feminine ; -- status=guess status=guess
lin heal_V2 = mkV2 (mkV "verheilen" | regV "heilen") ; -- status=guess, src=wikt status=guess, src=wikt
lin heal_V = mkV "verheilen" | regV "heilen" ; -- status=guess, src=wikt status=guess, src=wikt
lin sovereignty_N = mkN "Souveränität" feminine ; -- status=guess
lin enzyme_N = mkN "Enzym" "Enzyme" neuter ; -- status=guess
lin host_V2 = variants{} ; -- 
lin neighbouring_A = regA "benachbart" ; -- status=guess
lin corn_N = mkN "Grauammer" feminine ; -- status=guess
lin layout_N = mkN "Einteilung" ; -- status=guess
lin dictate_VS = mkVS (mkV "diktieren" | regV "bestimmen" | prefixV "vor" (irregV "schreiben" "schreibt" "schrieb" "schrieb" "geschrieben")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dictate_V2 = mkV2 (mkV "diktieren" | regV "bestimmen" | prefixV "vor" (irregV "schreiben" "schreibt" "schrieb" "schrieb" "geschrieben")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dictate_V = mkV "diktieren" | regV "bestimmen" | prefixV "vor" (irregV "schreiben" "schreibt" "schrieb" "schrieb" "geschrieben") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rip_V2 = mkV2 (irregV "rippen" "rippt" "rippte" "rippte" "rippt") ; -- status=guess, src=wikt
lin rip_V = irregV "rippen" "rippt" "rippte" "rippte" "rippt" ; -- status=guess, src=wikt
lin regain_V2 = mkV2 (mkV "wiedergewinnen") ; -- status=guess, src=wikt
lin probable_A = mk3A "glaubhaft" "glaubhafter" "glaubhafteste" | mk3A "wahrscheinlich" "wahrscheinlicher" "wahrscheinlichste" ; -- status=guess status=guess
lin inclusion_N = mkN "Einschluss" masculine ; -- status=guess
lin booklet_N = heft_N | mkN "Broschüre" feminine ; -- status=guess status=guess
lin bar_V2 = mkV2 (mkV "versperren") ; -- status=guess, src=wikt
lin privately_Adv = variants{} ; -- 
lin laser_N = mkN "Laser" "Laser" masculine ; -- status=guess
lin fame_N = mkN "Ruhm" masculine ; -- status=guess
lin bronze_N = mkN "Bronze" "Bronzen" feminine ; -- status=guess
lin mobile_A = regA "beweglich" | mk3A "mobil" "mobiler" "mobilste" ; -- status=guess status=guess
lin metaphor_N = mkN "Metapher" "Metaphern" feminine ; -- status=guess
lin complication_N = mkN "Komplikation" "Komplikationen" feminine ; -- status=guess
lin narrow_V2 = mkV2 (mkV "eng") | mkV2 (mkV "schlank") | mkV2 (mkV "schmal") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin narrow_V = mkV "eng" | mkV "schlank" | mkV "schmal" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin old_fashioned_A = variants{} ; -- 
lin chop_V2 = mkV2 (regV "hacken" | mkV "zerhacken" | prefixV "ab" (regV "hacken")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin chop_V = regV "hacken" | mkV "zerhacken" | prefixV "ab" (regV "hacken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin synthesis_N = mkN "Synthese" "Synthesen" feminine ; -- status=guess
lin diameter_N = mkN "Durchmesser" "Durchmesser" masculine ; -- status=guess
lin bomb_V2 = mkV2 (mkV "bombardieren") ; -- status=guess, src=wikt
lin bomb_V = mkV "bombardieren" ; -- status=guess, src=wikt
lin silently_Adv = variants{} ; -- 
lin shed_N = mkN "Schuppen" "Schuppen" masculine | mkN "Schuppen" "Schuppen" masculine ; -- status=guess status=guess
lin fusion_N = mkN "Schmelzen" neuter ; -- status=guess
lin trigger_V2 = mkV2 (mkV "auslösen") ; -- status=guess, src=wikt
lin printing_N = mkN "Druckerei" "Druckereien" feminine | mkN "Typographie" "Typographien" feminine ; -- status=guess status=guess
lin onion_N = mkN "Zwiebel" "Zwiebeln" feminine ; -- status=guess
lin dislike_V2 = mkV2 (prefixV "ab" (regV "lehnen")) ; -- status=guess, src=wikt
lin embody_V2 = mkV2 (mkV "verkörpern") ; -- status=guess, src=wikt
lin curl_V = variants{} ; -- 
lin sunshine_N = mkN "Sonnenschein" masculine ; -- status=guess
lin sponsorship_N = variants{} ; -- 
lin rage_N = mkN "Wut" feminine | mkN "Zorn" masculine | mkN "Raserei" "Rasereien" feminine | mkN "Rage" feminine ; -- status=guess status=guess status=guess status=guess
lin loop_N = mkN "Schleife" "Schleifen" feminine ; -- status=guess
lin halt_N = mkN "Halt" "Halte" masculine | mkN "Blockierung" feminine | mkN "Pause" "Pausen" feminine ; -- status=guess status=guess status=guess
lin cop_V2 = variants{} ; -- 
lin bang_V2 = mkV2 (regV "bumsen") ; -- status=guess, src=wikt
lin bang_V = regV "bumsen" ; -- status=guess, src=wikt
lin toxic_A = mk3A "giftig" "giftiger" "giftigste" | regA "toxisch" ; -- status=guess status=guess
lin thinking_A = variants{} ; -- 
lin orientation_N = mkN "Orientierungsvermögen" neuter ; -- status=guess
lin likelihood_N = mkN "Wahrscheinlichkeit" "Wahrscheinlichkeiten" feminine ; -- status=guess
lin wee_A = mk3A "winzig" "winziger" "winzigste" | mk3A "klein" "kleiner" "kleinste" ; -- status=guess status=guess
lin up_to_date_A = variants{} ; -- 
lin polite_A = mkA "höflich" ; -- status=guess
lin apology_N = mkN "Entschuldigung" ; -- status=guess
lin exile_N = mkN "Exilant" masculine ; -- status=guess
lin brow_N = mkN "Stirn" "Stirnen" feminine ; -- status=guess
lin miserable_A = mkA "erbärmlich" | mkA "jämmerlich" | mk3A "miserabel" "miserabler" "miserabelste" ; -- status=guess status=guess status=guess
lin outbreak_N = mkN "Ausbruch" "Ausbrüche" masculine ; -- status=guess
lin comparatively_Adv = variants{} ; -- 
lin pump_V2 = mkV2 (mkV "aufpumpen") ; -- status=guess, src=wikt
lin pump_V = mkV "aufpumpen" ; -- status=guess, src=wikt
lin fuck_V2 = mkV2 (irregV "verarschen" "verarscht" "verarschte" "verarschte" "verarscht") ; -- status=guess, src=wikt
lin fuck_V = irregV "verarschen" "verarscht" "verarschte" "verarschte" "verarscht" ; -- status=guess, src=wikt
lin forecast_VS = mkVS (mkV "vorhersagen" | irregV "prognostizieren" "prognostiziert" "prognostizierte" "prognostizierte" "prognostiziert") ; -- status=guess, src=wikt status=guess, src=wikt
lin forecast_V2 = mkV2 (mkV "vorhersagen" | irregV "prognostizieren" "prognostiziert" "prognostizierte" "prognostizierte" "prognostiziert") ; -- status=guess, src=wikt status=guess, src=wikt
lin forecast_V = mkV "vorhersagen" | irregV "prognostizieren" "prognostiziert" "prognostizierte" "prognostizierte" "prognostiziert" ; -- status=guess, src=wikt status=guess, src=wikt
lin timing_N = mkN "Steuerkette" feminine | mkN "Zahnriemen" masculine | mkN "Synchronriemen" masculine | mkN "Steuerriemen" masculine ; -- status=guess status=guess status=guess status=guess
lin headmaster_N = variants{} ; -- 
lin terrify_V2 = variants{} ; -- 
lin sigh_N = mkN "Seufzen" neuter | mkN "Seufzer" masculine ; -- status=guess status=guess
lin premier_A = variants{} ; -- 
lin joint_N = mkN "gemeinsame Rechnung" feminine ; -- status=guess
lin incredible_A = mk3A "unglaublich" "unglaublicher" "unglaublichste" ; -- status=guess
lin gravity_N = mkN "Gravitationsmanöver" neuter | mkN "Schwerkraftumlenkung" feminine | mkN "Swing-by" masculine | mkN "Vorbeischwungmanöver" neuter ; -- status=guess status=guess status=guess status=guess
lin regulatory_A = mkA "regulativ" | regA "regulatorisch" ; -- status=guess status=guess
lin cylinder_N = mkN "Zylinder" "Zylinder" masculine ; -- status=guess
lin curiosity_N = mkN "Neugier" feminine | mkN "Neugierde" feminine ; -- status=guess status=guess
lin resident_A = variants{} ; -- 
lin narrative_N = mkN "Darstellung" ; -- status=guess
lin cognitive_A = regA "kognitiv" ; -- status=guess
lin lengthy_A = variants{} ; -- 
lin gothic_A = variants{} ; -- 
lin dip_V2 = mkV2 (prefixV "ein" (regV "tauchen") | prefixV "ein" (regV "tunken") | regV "stippen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin dip_V = prefixV "ein" (regV "tauchen") | prefixV "ein" (regV "tunken") | regV "stippen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin adverse_A = mkA "gegnerisch" ; -- status=guess
lin accountability_N = mkN "Verantwortlichkeit" feminine ; -- status=guess
lin hydrogen_N = mkN "Wasserstoffatom" "Wasserstoffatome" neuter ; -- status=guess
lin gravel_N = mkN "Kies" "Kiese" masculine | mkN "Schotter" "Schotter" masculine ; -- status=guess status=guess
lin willingness_N = mkN "Willigkeit" feminine | mkN "Bereitschaft" "Bereitschaften" feminine ; -- status=guess status=guess
lin inhibit_V2 = mkV2 (regV "hemmen" | regV "hindern" | regV "sperren" | irregV "verhindern" "verhindert" "verhinderte" "verhinderte" "verhindert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin attain_V2 = mkV2 (irregV "erreichen" "erreicht" "erreichte" "erreichte" "erreicht" | irregV "erlangen" "erlangt" "erlangte" "erlangte" "erlangt") ; -- status=guess, src=wikt status=guess, src=wikt
lin attain_V = irregV "erreichen" "erreicht" "erreichte" "erreichte" "erreicht" | irregV "erlangen" "erlangt" "erlangte" "erlangte" "erlangt" ; -- status=guess, src=wikt status=guess, src=wikt
lin specialize_V2 = variants{} ; -- 
lin specialize_V = variants{} ; -- 
lin steer_V2 = mkV2 (irregV "steuern" "steuert" "steuerte" "steuere" "gesteuert") ; -- status=guess, src=wikt
lin steer_V = irregV "steuern" "steuert" "steuerte" "steuere" "gesteuert" ; -- status=guess, src=wikt
lin selected_A = variants{} ; -- 
lin like_N = mkN "seinesgleichen" ; -- status=guess
lin confer_V = variants{} ; -- 
lin usage_N = mkN "Brauch" "Bräuche" masculine ; -- status=guess
lin portray_V2 = mkV2 (mkV "porträtieren") ; -- status=guess, src=wikt
lin planner_N = variants{} ; -- 
lin manual_A = regA "manuell" ; -- status=guess
lin boast_VS = mkVS (prefixV "an" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") | regV "prahlen") ; -- status=guess, src=wikt status=guess, src=wikt
lin boast_V2 = mkV2 (prefixV "an" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") | regV "prahlen") ; -- status=guess, src=wikt status=guess, src=wikt
lin boast_V = prefixV "an" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") | regV "prahlen" ; -- status=guess, src=wikt status=guess, src=wikt
lin unconscious_A = regA "bewusstlos" ; -- status=guess
lin jail_N = variants{} ; -- 
lin fertility_N = mkN "Fruchtbarkeit" feminine ; -- status=guess
lin documentation_N = mkN "Dokumentation" ; -- status=guess
lin wolf_N = mkN "Wolf" "Wölfe" masculine ; -- status=guess
lin patent_N = mkN "Patent" "Patente" neuter ; -- status=guess
lin exit_N = mkN "Abtritt" "Abtritte" masculine | mkN "Austritt" "Austritte" masculine | mkN "Ausstieg" masculine | mkN "Abwanderung" ; -- status=guess status=guess status=guess status=guess
lin corps_N = mkN "Korps" "Korps" neuter ; -- status=guess
lin proclaim_VS = variants{} ; -- 
lin proclaim_V2 = variants{} ; -- 
lin multiply_V2 = mkV2 (regV "multiplizieren") ; -- status=guess, src=wikt
lin multiply_V = regV "multiplizieren" ; -- status=guess, src=wikt
lin brochure_N = mkN "Broschüre" feminine ; -- status=guess
lin screen_V2 = variants{} ; -- 
lin screen_V = variants{} ; -- 
lin orthodox_A = mk3A "orthodox" "orthodoxer" "orthodoxeste" ; -- status=guess
lin locomotive_N = mkN "Lokomotive" "Lokomotiven" feminine ; -- status=guess
lin considering_Prep = variants{} ; -- 
lin unaware_A = mkA "unwissend" ; -- status=guess
lin syndrome_N = mkN "Syndrom" "Syndrome" neuter ; -- status=guess
lin reform_V2 = mkV2 (irregV "reformieren" "reformiert" "reformierte" "reformierte" "reformiert") ; -- status=guess, src=wikt
lin reform_V = irregV "reformieren" "reformiert" "reformierte" "reformierte" "reformiert" ; -- status=guess, src=wikt
lin confirmation_N = mkN "Bestätigung" feminine ; -- status=guess
lin printed_A = variants{} ; -- 
lin curve_V2 = variants{} ; -- 
lin curve_V = variants{} ; -- 
lin costly_A = mk3A "teuer" "teurer" "teuerste" | mkA "kostspielig" ; -- status=guess status=guess
lin underground_A = regA "unterirdisch" | mkA "Untegrund-" ; -- status=guess status=guess
lin territorial_A = variants{} ; -- 
lin designate_VS = mkVS (irregV "designieren" "designiert" "designierte" "designierte" "designiert" | regV "nominieren" | irregV "nennen" "nennt" "nannte" "nennte" "genannt") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin designate_V2V = mkV2V (irregV "designieren" "designiert" "designierte" "designierte" "designiert" | regV "nominieren" | irregV "nennen" "nennt" "nannte" "nennte" "genannt") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin designate_V2 = mkV2 (irregV "designieren" "designiert" "designierte" "designierte" "designiert" | regV "nominieren" | irregV "nennen" "nennt" "nannte" "nennte" "genannt") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin designate_V = irregV "designieren" "designiert" "designierte" "designierte" "designiert" | regV "nominieren" | irregV "nennen" "nennt" "nannte" "nennte" "genannt" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin comfort_V2 = mkV2 (mkV "trösten" | irregV "ermutigen" "ermutigt" "ermutigte" "ermutigte" "ermutigt") ; -- status=guess, src=wikt status=guess, src=wikt
lin plot_V2 = mkV2 (mkV "plotten") ; -- status=guess, src=wikt
lin plot_V = mkV "plotten" ; -- status=guess, src=wikt
lin misleading_A = mkA "irreführend" ; -- status=guess
lin weave_V2 = mkV2 (irregV "weben" "webt" "wob" "wöbe" "gewoben") ; -- status=guess, src=wikt
lin weave_V = irregV "weben" "webt" "wob" "wöbe" "gewoben" ; -- status=guess, src=wikt
lin scratch_V2 = L.scratch_V2 ;
lin scratch_V = mkV "zerkratzen" | mkV "verkratzen" ; -- status=guess, src=wikt status=guess, src=wikt
lin echo_N = mkN "Tastaturecho" neuter | mkN "Bildschirmecho" neuter ; -- status=guess status=guess
lin ideally_Adv = mkAdv "idealerweise" ; -- status=guess
lin endure_V2 = mkV2 (irregV "ertragen" "ertragt" "ertrug" "ertrüge" "ertragen" | prefixV "aus" (irregV "halten" "hält" "hielt" "hielte" "gehalten")) ; -- status=guess, src=wikt status=guess, src=wikt
lin endure_V = irregV "ertragen" "ertragt" "ertrug" "ertrüge" "ertragen" | prefixV "aus" (irregV "halten" "hält" "hielt" "hielte" "gehalten") ; -- status=guess, src=wikt status=guess, src=wikt
lin verbal_A = regA "verbal" ; -- status=guess
lin stride_V = mkV "schreiten" ; -- status=guess, src=wikt
lin nursing_N = mkN "Still-BH" masculine | mkN "Schwangerschafts-BH" | mkN "Umstands-BH" masculine ; -- status=guess status=guess status=guess
lin exert_V2 = mkV2 (mkV "ausüben") ; -- status=guess, src=wikt
lin compatible_A = mk3A "kompatibel" "kompatibler" "kompatibelste" | mkA "verträglich" ; -- status=guess status=guess
lin causal_A = variants{} ; -- 
lin mosaic_N = mkN "Mosaik" neuter ; -- status=guess
lin manor_N = mkN "Lehen" neuter ; -- status=guess
lin implicit_A = regA "implizit" ; -- status=guess
lin following_Prep = variants{} ; -- 
lin fashionable_A = mkA "modisch" ; -- status=guess
lin valve_N = mkN "Ventil" "Ventile" neuter ; -- status=guess
lin proceed_N = variants{} ; -- 
lin sofa_N = mkN "Sofa" "Sofas" neuter ; -- status=guess
lin snatch_V2 = mkV2 (regV "klauen" | irregV "stehlen" "stehlt" "stahl" "stähle" "gestohlen") ; -- status=guess, src=wikt status=guess, src=wikt
lin snatch_V = regV "klauen" | irregV "stehlen" "stehlt" "stahl" "stähle" "gestohlen" ; -- status=guess, src=wikt status=guess, src=wikt
lin jazz_N = mkN "Jazz" masculine ; -- status=guess
lin patron_N = mkN "Schirmherr" masculine ; -- status=guess
lin provider_N = mkN "Versorger" masculine ; -- status=guess
lin interim_A = mkA "zwischenzeitlich" ; -- status=guess
lin intent_N = mkN "Absicht" "Absichten" feminine ; -- status=guess
lin chosen_A = variants{} ; -- 
lin applied_A = mkA "angewandt" ; -- status=guess
lin shiver_V = irregV "zittern" "zittert" "zitterte" "zitterte" "gezittert" ; -- status=guess, src=wikt
lin pie_N = torte_N ; -- status=guess
lin fury_N = mkN "Furie" "Furien" feminine ; -- status=guess
lin abolition_N = mkN "Abschaffung" ; -- status=guess
lin soccer_N = mkN "Fußball" masculine ; -- status=guess
lin corpse_N = mkN "Leiche" "Leichen" feminine | mkN "Leichnam" "Leichname" masculine ; -- status=guess status=guess
lin accusation_N = mkN "Anklage" "Anklagen" feminine | mkN "Beschuldigung" ; -- status=guess status=guess
lin kind_A = mk3A "freundlich" "freundlicher" "freundlichste" | mkA "gütig" | mk3A "lieb" "lieber" "liebste" | mkA "liebenswürdig" | nett_A | mk3A "aufmerksam" "aufmerksamer" "aufmerksamste" ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin dead_Adv = mkAdv "genau" ; -- status=guess
lin nursing_A = variants{} ; -- 
lin contempt_N = mkN "Schande" feminine | mkN "Blamage" "Blamagen" feminine ; -- status=guess status=guess
lin prevail_V = prefixV "vor" (regV "herrschen") ; -- status=guess, src=wikt
lin murderer_N = mkN "Mörder" masculine | mkN "Mörderin" feminine ; -- status=guess status=guess
lin liberal_N = variants{} ; -- 
lin gathering_N = variants{} ; -- 
lin adequately_Adv = variants{} ; -- 
lin subjective_A = variants{} ; -- 
lin disagreement_N = mkN "Streit" "Streite" masculine ; -- status=guess
lin cleaner_N = mkN "Reiniger" masculine ; -- status=guess
lin boil_V2 = mkV2 (irregV "kochen" "kocht" "kochte" "kochte" "kocht") ; -- status=guess, src=wikt
lin boil_V = irregV "kochen" "kocht" "kochte" "kochte" "kocht" ; -- status=guess, src=wikt
lin static_A = variants{} ; -- 
lin scent_N = mkN "Geruch" "Gerüche" masculine | mkN "Duft" "Düfte" masculine ; -- status=guess status=guess
lin civilian_N = mkN "Zivilist" "Zivilisten" masculine | mkN "Zivilistin" feminine ; -- status=guess status=guess
lin monk_N = mkN "Mönch" masculine ; -- status=guess
lin abruptly_Adv = mkAdv "abrupt" | mkAdv "plötzlich" | mkAdv "unerwartet" ; -- status=guess status=guess status=guess
lin keyboard_N = mkN "Tastatur" "Tastaturen" feminine | mkN "Klaviatur" "Klaviaturen" feminine | manual_N ; -- status=guess status=guess status=guess
lin hammer_N = mkN "Hammer" "Hämmer" masculine ; -- status=guess
lin despair_N = mkN "Verzweiflung" ; -- status=guess
lin controller_N = mkN "Controller" masculine | mkN "Steuerung" ; -- status=guess status=guess
lin yell_V2 = mkV2 (irregV "schreien" "schreit" "schrie" "schriee" "geschrien") ; -- status=guess, src=wikt
lin yell_V = irregV "schreien" "schreit" "schrie" "schriee" "geschrien" ; -- status=guess, src=wikt
lin entail_V2 = mkV2 (regV "bedingen" | irregV "verursachen" "verursacht" "verursachte" "verursachte" "verursacht") ; -- status=guess, src=wikt status=guess, src=wikt
lin cheerful_A = mk3A "freundlich" "freundlicher" "freundlichste" ; -- status=guess
lin reconstruction_N = mkN "Rekonstruktion" | mkN "Wiederaufbau" masculine ; -- status=guess status=guess
lin patience_N = mkN "Geduld" feminine ; -- status=guess
lin legally_Adv = mkAdv "legal" ; -- status=guess
lin habitat_N = mkN "Habitat" "Habitate" neuter ; -- status=guess
lin queue_N = mkN "Warteschlange" "Warteschlangen" feminine | mkN "Schlange" "Schlangen" feminine | mkN "Reihe" "Reihen" feminine ; -- status=guess status=guess status=guess
lin spectatorMasc_N = reg2N "Zuschauer" "Zuschauer" masculine;
lin given_A = variants{} ; -- 
lin purple_A = regA "violett" | regA "lila" | mkA "purpurrot" ; -- status=guess status=guess status=guess
lin outlook_N = mkN "Einstellung" | mkN "Ansichten" feminine ; -- status=guess status=guess
lin genius_N = mkN "Genialität" feminine ; -- status=guess
lin dual_A = regA "dual" ; -- status=guess
lin canvas_N = mkN "Leinwand" "Leinwände" feminine ; -- status=guess
lin grave_A = variants{} ; -- 
lin pepper_N = mkN "Chili" "Chilis" masculine | mkN "Paprika" ; -- status=guess status=guess
lin conform_V2 = variants{} ; -- 
lin conform_V = variants{} ; -- 
lin cautious_A = mk3A "vorsichtig" "vorsichtiger" "vorsichtigste" | mk3A "zaghaft" "zaghafter" "zaghafteste" | mk3A "behutsam" "behutsamer" "behutsamste" ; -- status=guess status=guess status=guess
lin dot_N = mkN "Punkt" "Punkte" masculine ; -- status=guess
lin conspiracy_N = mkN "Verschwörung" feminine | mkN "Konspiration" feminine ; -- status=guess status=guess
lin butterfly_N = mkN "Schmetterling" "Schmetterlinge" masculine | mkN "Falter" "Falter" masculine | mkN "Tagfalter" "Tagfalter" masculine | mkN "Summervogl" ; -- status=guess status=guess status=guess status=guess
lin sponsor_N = mkN "Sponsor" masculine ; -- status=guess
lin sincerely_Adv = variants{} ; -- 
lin rating_N = variants{} ; -- 
lin weird_A = mk3A "eigenartig" "eigenartiger" "eigenartigste" | mkA "merkwürdig" | mk3A "sonderbar" "sonderbarer" "sonderbarste" | mk3A "seltsam" "seltsamer" "seltsamste" | mk3A "bizarr" "bizarrer" "bizarrste" ; -- status=guess status=guess status=guess status=guess status=guess
lin teenage_A = variants{} ; -- 
lin salmon_N = mkN "lachsfarben" | mkN "lachsfarbig" | mkN "lachsrot" | mkN "lachsrosa" ; -- status=guess status=guess status=guess status=guess
lin recorder_N = mkN "Blockflöte" feminine ; -- status=guess
lin postpone_V2 = mkV2 (irregV "verschieben" "verschiebt" "verschob" "verschöbe" "verschoben" | mkV "aufschieben") ; -- status=guess, src=wikt status=guess, src=wikt
lin maid_N = mkN "Dienstmädchen" neuter ; -- status=guess
lin furnish_V2 = mkV2 (mkV "möblieren" | prefixV "ein" (irregV "richten" "richtet" "richtete" "richtete" "gerichtet")) ; -- status=guess, src=wikt status=guess, src=wikt
lin ethical_A = mk3A "ethisch" "ethischer" "ethischste" ; -- status=guess
lin bicycle_N = mkN "Fahrrad" "Fahrräder" neuter | mkN "Velo" "Velos" neuter | mkN "colloquial: Drahtesel" masculine ; -- status=guess status=guess status=guess
lin sick_N = mkN "Arbeitsunfähigkeit" feminine | mkN "Krankenstand" masculine ; -- status=guess status=guess
lin sack_N = mkN "Sack" "Säcke" masculine | mkN "Sackvoll" masculine ; -- status=guess status=guess
lin renaissance_N = variants{} ; -- 
lin luxury_N = mkN "Luxus" masculine ; -- status=guess
lin gasp_V2 = mkV2 (regV "japsen") ; -- status=guess, src=wikt
lin gasp_V = regV "japsen" ; -- status=guess, src=wikt
lin wardrobe_N = mkN "Garderobe" "Garderoben" feminine | mkN "Kleiderschrank" "Kleiderschränke" masculine ; -- status=guess status=guess
lin native_N = mkN "Ureinwohner" "Ureinwohner" masculine | mkN "Ureinwohnerin" feminine | mkN "Eingeborener" masculine | mkN "Eingeborene" feminine ; -- status=guess status=guess status=guess status=guess
lin fringe_N = mkN "Sachbezug" masculine ; -- status=guess
lin adaptation_N = mkN "Anpassung" ; -- status=guess
lin quotation_N = mkN "Angebot" "Angebote" neuter | mkN "Preisangebot" neuter ; -- status=guess status=guess
lin hunger_N = mkN "Hunger" masculine ; -- status=guess
lin enclose_V2 = variants{} ; -- 
lin disastrous_A = mkA "verhängnisvoll" ; -- status=guess
lin choir_N = mkN "Engelschor" masculine ; -- status=guess
lin overwhelming_A = mkA "überwältigend" ; -- status=guess
lin glimpse_N = variants{} ; -- 
lin divorce_V2 = mkV2 (mkReflV "scheiden lassen") ; -- status=guess, src=wikt
lin circular_A = mk3A "rund" "runder" "rundeste" ; -- status=guess
lin locality_N = variants{} ; -- 
lin ferry_N = mkN "Fähre" feminine ; -- status=guess
lin balcony_N = mkN "Balkon" masculine ; -- status=guess
lin sailor_N = mkN "Matrose" "Matrosen" masculine | mkN "Seemann" "Seeleute" masculine ; -- status=guess status=guess
lin precision_N = mkN "Präzision" feminine | mkN "Genauigkeit" feminine ; -- status=guess status=guess
lin desert_V2 = mkV2 (irregV "verlassen" "verlasst" "verließ" "verließe" "verlassen") ; -- status=guess, src=wikt
lin desert_V = irregV "verlassen" "verlasst" "verließ" "verließe" "verlassen" | junkV (mkV "im") "Stich lassen" ; -- status=guess, src=wikt status=guess, src=wikt
lin dancing_N = variants{} ; -- 
lin alert_V2 = mkV2 (mkV "verständigen") ; -- status=guess, src=wikt
lin surrender_V2 = mkV2 (irregV "kapitulieren" "kapituliert" "kapitulierte" "kapitulierte" "kapituliert" | mkReflV "ergeben") ; -- status=guess, src=wikt status=guess, src=wikt
lin surrender_V = irregV "kapitulieren" "kapituliert" "kapitulierte" "kapitulierte" "kapituliert" | mkReflV "ergeben" ; -- status=guess, src=wikt status=guess, src=wikt
lin archive_N = mkN "Archiv" "Archive" neuter ; -- status=guess
lin jump_N = mkN "Sprung" ; -- status=guess
lin philosopher_N = mkN "Philosoph" "Philosophen" masculine | mkN "Philosophin" "Philosophinnen" feminine ; -- status=guess status=guess
lin revival_N = mkN "Wiederbelebung" ; -- status=guess
lin presume_VS = mkVS (prefixV "an" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen") | mkV "mutmaßen" | irregV "vermuten" "vermutet" "vermutete" "vermutete" "vermutet") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin presume_V2 = mkV2 (prefixV "an" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen") | mkV "mutmaßen" | irregV "vermuten" "vermutet" "vermutete" "vermutete" "vermutet") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin presume_V = prefixV "an" (irregV "nehmen" "nimmt" "nahm" "nähme" "genommen") | mkV "mutmaßen" | irregV "vermuten" "vermutet" "vermutete" "vermutete" "vermutet" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin node_N = mkN "Knoten" "Knoten" masculine | mkN "Ecke" "Ecken" feminine ; -- status=guess status=guess
lin fantastic_A = mk3A "fantastisch" "fantastischer" "fantastischste" ; -- status=guess
lin herb_N = mkN "Heilkraut" neuter ; -- status=guess
lin assertion_N = mkN "Versicherung" | mkN "Zusicherung" ; -- status=guess status=guess
lin thorough_A = mkA "gründlich" ; -- status=guess
lin quit_V2 = mkV2 (mkV "aufhören" | prefixV "auf" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") | junkV (mkV "sein") "lassen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin quit_V = mkV "aufhören" | prefixV "auf" (irregV "geben" "gebt" "gab" "gäbe" "gegeben") | junkV (mkV "sein") "lassen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin grim_A = mkA "grimm" ; -- status=guess
lin fair_N = mkN "Jahrmarkt" "Jahrmärkte" masculine | mkN "Kirchtag" masculine | mkN "Kirchweih" feminine | mkN "Kirmes" "Kirmessen" feminine ; -- status=guess status=guess status=guess status=guess
lin broadcast_V2 = mkV2 (regV "senden" | irregV "verbreiten" "verbreitet" "verbreitete" "verbreitete" "verbreitet") ; -- status=guess, src=wikt status=guess, src=wikt
lin broadcast_V = regV "senden" | irregV "verbreiten" "verbreitet" "verbreitete" "verbreitete" "verbreitet" ; -- status=guess, src=wikt status=guess, src=wikt
lin annoy_V2 = mkV2 (mkV "stören") | mkV2 (mkV "ärgern") | mkV2 (mkV "belästigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin divert_V = prefixV "ab" (regV "lenken") ; -- status=guess, src=wikt
lin accelerate_V2 = mkV2 (junkV (mkV "schneller") "werden" | regV "beschleunigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin accelerate_V = compoundV "schneller" werden_V | regV "beschleunigen" ; -- status=guess, src=wikt status=guess, src=wikt
lin polymer_N = mkN "Polymer" "Polymere" neuter ; -- status=guess
lin sweat_N = mkN "Schweiß" masculine | mkN "Schwitze" feminine ; -- status=guess status=guess
lin survivor_N = mkN "Überlebender" masculine | mkN "Überlebende" feminine ; -- status=guess status=guess
lin subscription_N = mkN "Abonnement" "Abonnements" neuter ; -- status=guess
lin repayment_N = variants{} ; -- 
lin anonymous_A = mk3A "anonym" "anonymer" "anonymste" ; -- status=guess
lin summarize_V2 = mkV2 (prefixV "zusammen" (regV "fassen")) ; -- status=guess, src=wikt
lin punch_N = mkN "Punsch" masculine | mkN "Bowle" "Bowlen" feminine ; -- status=guess status=guess
lin lodge_V2 = mkV2 (mkV "feststecken" | regV "beherbergen" | mkV "unterbringen" | irregV "hinterlegen" "hinterlegt" "hinterlegte" "hinterlegte" "hinterlegt" | irregV "deponieren" "deponiert" "deponierte" "deponierte" "deponiert" | mkV "einlegen" | prefixV "ein" (regV "reichen")) ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lodge_V = mkV "feststecken" | regV "beherbergen" | mkV "unterbringen" | irregV "hinterlegen" "hinterlegt" "hinterlegte" "hinterlegte" "hinterlegt" | irregV "deponieren" "deponiert" "deponierte" "deponierte" "deponiert" | mkV "einlegen" | prefixV "ein" (regV "reichen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin landowner_N = mkN "Grundbesitzer" masculine | mkN "Grundbesitzerin" feminine ; -- status=guess status=guess
lin ignorance_N = mkN "Ignoranz" feminine | mkN "Unwissenheit" feminine ; -- status=guess status=guess
lin discourage_V2 = mkV2 (irregV "entmutigen" "entmutigt" "entmutigte" "entmutigte" "entmutigt") ; -- status=guess, src=wikt
lin bride_N = mkN "Braut" "Bräute" feminine ; -- status=guess
lin likewise_Adv = mkAdv "ebenfalls" | mkAdv "gleichfalls" | mkAdv "ebenso" ; -- status=guess status=guess status=guess
lin depressed_A = variants{} ; -- 
lin abbey_N = mkN "Kloster" "Klöster" neuter ; -- status=guess
lin quarry_N = mkN "Beute" feminine ; -- status=guess
lin archbishop_N = mkN "Erzbischof" "Erzbischöfe" masculine ; -- status=guess
lin sock_N = L.sock_N ;
lin large_scale_A = variants{} ; -- 
lin glare_V2 = variants{} ; -- 
lin glare_V = variants{} ; -- 
lin descent_N = mkN "Herkunft" "Herkünfte" feminine ; -- status=guess
lin stumble_V = regV "stolpern" ; -- status=guess, src=wikt
lin mistress_N = mkN "Domina" feminine ; -- status=guess
lin empty_V2 = mkV2 (regV "leeren" | irregV "entleeren" "entleert" "entleerte" "entleerte" "entleert" | mkV "ausleeren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin empty_V = regV "leeren" | irregV "entleeren" "entleert" "entleerte" "entleerte" "entleert" | mkV "ausleeren" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin prosperity_N = mkN "Prosperität" feminine | mkN "Wohlstand" masculine ; -- status=guess status=guess
lin harm_V2 = mkV2 (regV "schaden") ; -- status=guess, src=wikt
lin formulation_N = variants{} ; -- 
lin atomic_A = mkA "Atom" | regA "atomar" ; -- status=guess status=guess
lin agreed_A = variants{} ; -- 
lin wicked_A = mkA "böse" ; -- status=guess
lin threshold_N = mkN "Schwelle" "Schwellen" feminine ; -- status=guess
lin lobby_N = mkN "Lobby" "Lobbys" feminine | mkN "Foyer" "Foyers" neuter | mkN "Vorraum" "Vorräume" masculine | mkN "Vorhalle" feminine ; -- status=guess status=guess status=guess status=guess
lin repay_V2 = mkV2 (mkV "zurückzahlen") ; -- status=guess, src=wikt
lin repay_V = mkV "zurückzahlen" ; -- status=guess, src=wikt
lin varying_A = variants{} ; -- 
lin track_V2 = variants{} ; -- 
lin track_V = variants{} ; -- 
lin crawl_V = regV "krabbeln" ; -- status=guess, src=wikt
lin tolerate_V2 = mkV2 (regV "tolerieren" | regV "dulden" | mkV "vertragen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin salvation_N = mkN "Erlösung" feminine | mkN "Rettung" ; -- status=guess status=guess
lin pudding_N = mkN "Pudding" masculine ; -- status=guess
lin counter_VS = mkVS (mkV "entgegnen" | irregV "widersprechen" "widersprecht" "widersprach" "widerspräche" "widersprochen" | mkV "entgegensetzen" | irregV "reagieren" "reagiert" "reagierte" "reagierte" "reagiert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin counter_V = mkV "entgegnen" | irregV "widersprechen" "widersprecht" "widersprach" "widerspräche" "widersprochen" | mkV "entgegensetzen" | irregV "reagieren" "reagiert" "reagierte" "reagierte" "reagiert" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin propaganda_N = mkN "Propaganda" feminine ; -- status=guess
lin cage_N = mkN "Käfig" masculine ; -- status=guess
lin broker_N = mkN "Börsenmakler" masculine | mkN "Börsenmaklerin" feminine ; -- status=guess status=guess
lin ashamed_A = mkA "beschämt" ; -- status=guess
lin scan_V2 = mkV2 (mkV "abtasten") | mkV2 (mkV "einscannen") ; -- status=guess, src=wikt status=guess, src=wikt
lin scan_V = mkV "abtasten" | mkV "einscannen" ; -- status=guess, src=wikt status=guess, src=wikt
lin document_V2 = mkV2 (irregV "dokumentieren" "dokumentiert" "dokumentierte" "dokumentierte" "dokumentiert") ; -- status=guess, src=wikt
lin apparatus_N = mkN "Apparat" "Apparate" masculine ; -- status=guess
lin theology_N = mkN "Theologie" "Theologien" feminine ; -- status=guess
lin analogy_N = mkN "Analogie" "Analogien" feminine ; -- status=guess
lin efficiently_Adv = mkAdv "effizient" ; -- status=guess
lin bitterly_Adv = variants{} ; -- 
lin performer_N = mkN "Künstler" masculine | mkN "Künstlerin" feminine ; -- status=guess status=guess
lin individually_Adv = mkAdv "individuell" | mkAdv "einzeln" ; -- status=guess status=guess
lin amid_Prep = variants{} ; -- 
lin squadron_N = variants{} ; -- 
lin sentiment_N = variants{} ; -- 
lin making_N = mkN "Anfertigen" neuter | mkN "Anfertigung" | mkN "Fabrikation" | mkN "Herstellung" ; -- status=guess status=guess status=guess status=guess
lin exotic_A = mk3A "exotisch" "exotischer" "exotischste" ; -- status=guess
lin dominance_N = mkN "Herrschaft" "Herrschaften" feminine ; -- status=guess
lin coherent_A = mkA "kohärent" ; -- status=guess
lin placement_N = mkN "Platzierung" feminine ; -- status=guess
lin flick_V2 = mkV2 (junkV (mkV "den") "Stinkefinger zeigen") ; -- status=guess, src=wikt
lin colourful_A = variants{} ; -- 
lin mercy_N = mkN "Gnade" "Gnaden" feminine ; -- status=guess
lin angrily_Adv = variants{} ; -- 
lin amuse_V2 = mkV2 (regV "belustigen" | mkV "erheitern") ; -- status=guess, src=wikt status=guess, src=wikt
lin mainstream_N = mkN "Hauptrichtung" feminine | mkN "Mainstream" masculine ; -- status=guess status=guess
lin appraisal_N = mkN "Einschätzung" feminine | mkN "Taxierung" feminine ; -- status=guess status=guess
lin annually_Adv = mkAdv "jährlich" ; -- status=guess
lin torch_N = mkN "Taschenlampe" "Taschenlampen" feminine ; -- status=guess
lin intimate_A = mk3A "vertraut" "vertrauter" "vertrauteste" | mk3A "innig" "inniger" "innigste" ; -- status=guess status=guess
lin gold_A = variants{} ; -- 
lin arbitrary_A = mkA "willkürlich" ; -- status=guess
lin venture_VS = variants{} ; -- 
lin venture_V2 = variants{} ; -- 
lin venture_V = variants{} ; -- 
lin preservation_N = mkN "Erhaltung" feminine ; -- status=guess
lin shy_A = mkA "schüchtern" | mk3A "scheu" "scheuer" "scheusten, scheueste" ; -- status=guess status=guess
lin disclosure_N = variants{} ; -- 
lin lace_N = mkN "Schnürband" neuter | mkN "Schnürsenkel" masculine | mkN "Schuhband" neuter ; -- status=guess status=guess status=guess
lin inability_N = mkN "Unfähigkeit" feminine ; -- status=guess
lin motif_N = mkN "Motiv" "Motive" neuter ; -- status=guess
lin listenerMasc_N = mkN "Zuhörer" masculine ; -- status=guess
lin hunt_N = mkN "Jagd" "Jagden" feminine ; -- status=guess
lin delicious_A = mkA "köstlich" | mk3A "lecker" "leckerer" "leckerste" | mkA "geschmackvoll" ; -- status=guess status=guess status=guess
lin term_VS = variants{} ; -- 
lin term_V2 = variants{} ; -- 
lin substitute_N = mkN "Ersatzspieler" masculine ; -- status=guess
lin highway_N = mkN "Hauptstraße" feminine ; -- status=guess
lin haul_V2 = mkV2 (irregV "ziehen" "zieht" "zog" "zöge" "gezogen" | regV "schleppen") ; -- status=guess, src=wikt status=guess, src=wikt
lin haul_V = irregV "ziehen" "zieht" "zog" "zöge" "gezogen" | regV "schleppen" ; -- status=guess, src=wikt status=guess, src=wikt
lin dragon_N = mkN "Drachenboot" neuter ; -- status=guess
lin chair_V2 = mkV2 (junkV (mkV "Vorsitz") "führen") ; -- status=guess, src=wikt
lin accumulate_V2 = mkV2 (mkReflV "vermehren") ; -- status=guess, src=wikt
lin accumulate_V = mkReflV "vermehren" ; -- status=guess, src=wikt
lin unchanged_A = variants{} ; -- 
lin sediment_N = mkN "Sediment" "Sedimente" neuter | mkN "Satz" "Sätze" masculine ; -- status=guess status=guess
lin sample_V2 = mkV2 (irregV "probieren" "probiert" "probierte" "probierte" "probiert" | irregV "kosten" "kostet" "kostete" "kostete" "gekostet") ; -- status=guess, src=wikt status=guess, src=wikt
lin exclaim_V2 = mkV2 (mkV "ausrufen") ; -- status=guess, src=wikt
lin fan_V2 = mkV2 (mkV "ventilieren") | mkV2 (mkV "belüften") | mkV2 (mkV "anfachen") | mkV2 (mkV "embers)") | mkV2 (mkV "anwehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fan_V = mkV "ventilieren" | mkV "belüften" | mkV "anfachen" | mkV "embers)" | mkV "anwehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin volunteer_V2 = mkV2 (prefixV "an" (irregV "bieten" "bietet" "bot" "böte" "geboten") | mkReflV "anbieten") ; -- status=guess, src=wikt status=guess, src=wikt
lin volunteer_V = prefixV "an" (irregV "bieten" "bietet" "bot" "böte" "geboten") | mkReflV "anbieten" ; -- status=guess, src=wikt status=guess, src=wikt
lin root_V2 = variants{} ; -- 
lin root_V = variants{} ; -- 
lin parcel_N = mkN "Paketbombe" feminine ; -- status=guess
lin psychiatric_A = mkA "psychiatrisch" ; -- status=guess
lin delightful_A = mkA "reizvoll" | mkA "entzückend" | mk3A "angenehm" "angenehmer" "angenehmste" ; -- status=guess status=guess status=guess
lin confidential_A = mk3A "vertraulich" "vertraulicher" "vertraulichste" ; -- status=guess
lin calorie_N = mkN "Kalorie" "Kalorien" feminine ; -- status=guess
lin flash_N = blitz_N ; -- status=guess
lin crowd_V2 = variants{} ; -- 
lin crowd_V = variants{} ; -- 
lin aggregate_A = variants{} ; -- 
lin scholarship_N = mkN "Gelehrsamkeit" feminine ; -- status=guess
lin monitor_N = mkN "Bildschirm" "Bildschirme" masculine | mkN "Monitor" masculine ; -- status=guess status=guess
lin disciplinary_A = mkA "disziplinarisch" ; -- status=guess
lin rock_V2 = mkV2 (mkV "auwühlen" | regV "schockieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin rock_V = mkV "auwühlen" | regV "schockieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin hatred_N = mkN "Hass" masculine ; -- status=guess
lin pill_N = mkN "Tablette" "Tabletten" feminine | mkN "Pille" "Pillen" feminine ; -- status=guess status=guess
lin noisy_A = mk3A "laut" "lauter" "lauteste" | mkA "geräuschvoll" ; -- status=guess status=guess
lin feather_N = L.feather_N ;
lin lexical_A = regA "lexikalisch" ; -- status=guess
lin staircase_N = mkN "Treppe" "Treppen" feminine ; -- status=guess
lin autonomous_A = mk3A "autonom" "autonomer" "autonomste" ; -- status=guess
lin viewpoint_N = variants{} ; -- 
lin projection_N = mkN "Projektion" ; -- status=guess
lin offensive_A = mkA "beleidigend" ; -- status=guess
lin controlled_A = variants{} ; -- 
lin flush_V2 = variants{} ; -- 
lin flush_V = variants{} ; -- 
lin racism_N = mkN "Rassismus" masculine ; -- status=guess
lin flourish_V = mkV "aufblühen" | junkV (mkV "eine") "Blütezeit haben" ; -- status=guess, src=wikt status=guess, src=wikt
lin resentment_N = mkN "Ressentiment" "Ressentiments" neuter | mkN "Abneigung" | mkN "Missgunst" feminine ; -- status=guess status=guess status=guess
lin pillow_N = mkN "Kopfkissen" "Kopfkissen" neuter | mkN "Kissen" "Kissen" neuter | mkN "Ruhekissen" neuter ; -- status=guess status=guess status=guess
lin courtesy_N = mkN "Höflichkeit" feminine ; -- status=guess
lin photography_N = mkN "Fotografie" "Fotografien" feminine ; -- status=guess
lin monkey_N = mkN "Affe" "Affen" masculine ; -- status=guess
lin glorious_A = mkA "ruhmvoll" ; -- status=guess
lin evolutionary_A = mkA "evolutionär" ; -- status=guess
lin gradual_A = regA "graduell" ; -- status=guess
lin bankruptcy_N = mkN "Bankrott" "Bankrotte" masculine ; -- status=guess
lin sacrifice_N = mkN "Opfer" "Opfer" neuter ; -- status=guess
lin uphold_V2 = variants{} ; -- 
lin sketch_N = mkN "Skizze" "Skizzen" feminine ; -- status=guess
lin presidency_N = mkN "Präsidentschaft" feminine ; -- status=guess
lin formidable_A = variants{} ; -- 
lin differentiate_V2 = mkV2 (irregV "differenzieren" "differenziert" "differenzierte" "differenzierte" "differenziert" | irregV "unterscheiden" "unterscheidet" "unterschied" "unterschiede" "unterschieden" | irregV "diskriminieren" "diskriminiert" "diskriminierte" "diskriminierte" "diskriminiert") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin differentiate_V = irregV "differenzieren" "differenziert" "differenzierte" "differenzierte" "differenziert" | irregV "unterscheiden" "unterscheidet" "unterschied" "unterschiede" "unterschieden" | irregV "diskriminieren" "diskriminiert" "diskriminierte" "diskriminierte" "diskriminiert" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin continuing_A = variants{} ; -- 
lin cart_N = mkN "Wagen" masculine | mkN "Karren" "Karren" masculine ; -- status=guess status=guess
lin stadium_N = mkN "Stadion" ; -- status=guess
lin dense_A = mk3A "dicht" "dichter" "dichteste" ; -- status=guess
lin catch_N = mkN "Haken" "Haken" masculine ; -- status=guess
lin beyond_Adv = variants{}; -- mkPrep "jenseits" genitive | mkPrep "über" accusative "hinaus" ;
lin immigration_N = mkN "Einwanderung" | mkN "Immigration" ; -- status=guess status=guess
lin clarity_N = mkN "Klarheit" "Klarheiten" feminine ; -- status=guess
lin worm_N = L.worm_N ;
lin slot_N = mkN "Münzautomat" masculine ; -- status=guess
lin rifle_N = mkN "Gewehr" "Gewehre" neuter ; -- status=guess
lin screw_V2 = mkV2 (regV "ficken") ; -- status=guess, src=wikt
lin screw_V = regV "ficken" ; -- status=guess, src=wikt
lin harvest_N = mkN "Herbstgrasmilbe" "Herbstgrasmilben" feminine ; -- status=guess
lin foster_V2 = mkV2 (regV "pflegen") ; -- status=guess, src=wikt
lin academic_N = variants{} ; -- 
lin impulse_N = mkN "Impuls" "Impulse" masculine | mkN "Triebkraft" feminine ; -- status=guess status=guess
lin guardian_N = mkN "Schutzengel" "Schutzengel" masculine ; -- status=guess
lin ambiguity_N = mkN "Ambiguität" feminine | mkN "Mehrdeutigkeit" "Mehrdeutigkeiten" feminine | mkN "Doppeldeutigkeit" feminine ; -- status=guess status=guess status=guess
lin triangle_N = mkN "Dreiecksungleichung" feminine ; -- status=guess
lin terminate_V2 = mkV2 (irregV "terminieren" "terminiert" "terminierte" "terminiere" "terminiert" | mkV "abschließen") ; -- status=guess, src=wikt status=guess, src=wikt
lin terminate_V = irregV "terminieren" "terminiert" "terminierte" "terminiere" "terminiert" | mkV "abschließen" ; -- status=guess, src=wikt status=guess, src=wikt
lin retreat_V = mkReflV "zurückziehen" ; -- status=guess, src=wikt
lin pony_N = mkN "Pony" "Ponys" neuter ; -- status=guess
lin outdoor_A = mkA "im Freien" ; -- status=guess
lin deficiency_N = variants{} ; -- 
lin decree_N = mkN "Erlass" masculine | mkN "Verfügung" feminine | mkN "Verordnung" | mkN "Dekret" "Dekrete" neuter ; -- status=guess status=guess status=guess status=guess
lin apologize_V = mkReflV "entschuldigen" ; -- status=guess, src=wikt
lin yarn_N = mkN "Garn" "Garne" neuter ; -- status=guess
lin staff_V2 = variants{} ; -- 
lin renewal_N = mkN "Erneuerung" ; -- status=guess
lin rebellion_N = mkN "Rebellion" feminine | mkN "Aufstand" "Aufstände" masculine ; -- status=guess status=guess
lin incidentally_Adv = mkAdv "apropos" | mkAdv "nebenbei" | mkAdv "übrigens" ; -- status=guess status=guess status=guess
lin flour_N = mkN "Mehl" "Mehle" neuter ; -- status=guess
lin developed_A = regA "entwickelt" ; -- status=guess
lin chorus_N = mkN "Chor" masculine ; -- status=guess
lin ballot_N = mkN "Stimmzettel-Ergebnis" "Stimmzettel-Ergebnisse" neuter ; -- status=guess
lin appetite_N = mkN "Begierde" "Begierden" feminine | lust_N ; -- status=guess status=guess
lin stain_V2 = variants{} ; -- 
lin stain_V = variants{} ; -- 
lin notebook_N = mkN "Notizbuch" "Notizbücher" neuter ; -- status=guess
lin loudly_Adv = mkAdv "laut" ; -- status=guess
lin homeless_A = regA "obdachlos" ; -- status=guess
lin census_N = mkN "Zensus" "Zensus" masculine | mkN "Volkszählung" feminine | mkN "Befragung" | mkN "Bevölkerungszählung" feminine | mkN "Zählung" feminine ; -- status=guess status=guess status=guess status=guess status=guess
lin bizarre_A = mk3A "bizarr" "bizarrer" "bizarrste" | mk3A "komisch" "komischer" "komischste" | mk3A "seltsam" "seltsamer" "seltsamste" ; -- status=guess status=guess status=guess
lin striking_A = mkA "auffällig" ; -- status=guess
lin greenhouse_N = mkN "Gewächshaus" neuter | mkN "Treibhaus" "Treibhäuser" neuter ; -- status=guess status=guess
lin part_V2 = mkV2 (mkV "scheiteln") ; -- status=guess, src=wikt
lin part_V = mkV "scheiteln" ; -- status=guess, src=wikt
lin burial_N = mkN "Begräbnis" neuter ; -- status=guess
lin embarrassed_A = mkA "verlegen" ; -- status=guess
lin ash_N = mkN "Aschblonder" masculine | mkN "Aschblondin" masculine | mkN "Aschblondling" masculine | mkN "Aschblondhaariger" masculine | mkN "Aschblonde" feminine | mkN "Aschblondine" feminine | mkN "Aschblondhaarige" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin actress_N = mkN "Schauspielerin" "Schauspielerinnen" feminine ; -- status=guess
lin cassette_N = mkN "Kassette" "Kassetten" feminine ; -- status=guess
lin privacy_N = mkN "Zurückgezogenheit" feminine | mkN "Privatsphäre" feminine ; -- status=guess status=guess
lin fridge_N = L.fridge_N ;
lin feed_N = mkN "Futtern" neuter | mkN "Fütterung" feminine ; -- status=guess status=guess
lin excess_A = variants{} ; -- 
lin calf_N = mkN "Wade" "Waden" feminine ; -- status=guess
lin associate_N = variants{} ; -- 
lin ruin_N = mkN "Ruine" "Ruinen" feminine ; -- status=guess
lin jointly_Adv = variants{} ; -- 
lin drill_V2 = mkV2 (regV "bohren") ; -- status=guess, src=wikt
lin drill_V = regV "bohren" ; -- status=guess, src=wikt
lin photograph_V2 = mkV2 (regV "fotografieren") ; -- status=guess, src=wikt
lin devoted_A = variants{} ; -- 
lin indirectly_Adv = mkAdv "indirekt" ; -- status=guess
lin driving_A = variants{} ; -- 
lin memorandum_N = mkN "Memorandum" "Memoranden" neuter ; -- status=guess
lin default_N = mkN "Grundzustand" masculine | standard_N ; -- status=guess status=guess
lin costume_N = mkN "Kostüm" neuter ; -- status=guess
lin variant_N = mkN "Variante" "Varianten" feminine ; -- status=guess
lin shatter_V2 = variants{} ; -- 
lin shatter_V = variants{} ; -- 
lin methodology_N = mkN "Methodologie" "Methodologien" feminine | mkN "Methodik" "Methodiken" feminine ; -- status=guess status=guess
lin frame_V2 = mkV2 (mkV "einfassen") | mkV2 (mkV "einrahmen") ; -- status=guess, src=wikt status=guess, src=wikt
lin frame_V = mkV "einfassen" | mkV "einrahmen" ; -- status=guess, src=wikt status=guess, src=wikt
lin allegedly_Adv = mkAdv "angeblich" | mkAdv "vermeintlich" ; -- status=guess status=guess
lin swell_V2 = mkV2 (irregV "schwellen" "schwellt" "schwoll" "schwölle" "geschwollen") ; -- status=guess, src=wikt
lin swell_V = L.swell_V ;
lin investigator_N = mkN "Ermittler" "Ermittler" masculine | mkN "Ermittlerin" feminine ; -- status=guess status=guess
lin imaginative_A = variants{} ; -- 
lin bored_A = variants{} ; -- 
lin bin_N = mkN "Mülltonne" ; -- status=guess
lin awake_A = mk3A "wach" "wacher" "wachste" ; -- status=guess
lin recycle_V2 = mkV2 (mkV "wiederverwerten") | mkV2 (mkV "recyceln") | mkV2 (mkV "recyclen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin group_V2 = mkV2 (regV "gruppieren") ; -- status=guess, src=wikt
lin group_V = regV "gruppieren" ; -- status=guess, src=wikt
lin enjoyment_N = variants{} ; -- 
lin contemporary_N = mkN "Zeitgenosse" "Zeitgenossen" masculine | mkN "Zeitgenossin" feminine ; -- status=guess status=guess
lin texture_N = mkN "Textur" "Texturen" feminine ; -- status=guess
lin donor_N = spender_N ; -- status=guess
lin bacon_N = speck_N ; -- status=guess
lin sunny_A = mk3A "sonnig" "sonniger" "sonnigste" ; -- status=guess
lin stool_N = mkN "Hocker" "Hocker" masculine ; -- status=guess
lin prosecute_V2 = mkV2 (junkV (mkV "strafrechtlich") "verfolgen" | regV "belangen" | regV "bestrafen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin commentary_N = mkN "Kommentar" "Kommentare" masculine ; -- status=guess
lin bass_N = mkN "Bassklarinette" feminine ; -- status=guess
lin sniff_V2 = mkV2 (mkV "schnüffeln") ; -- status=guess, src=wikt
lin sniff_V = mkV "schnüffeln" ; -- status=guess, src=wikt
lin repetition_N = mkN "Wiederholung" | mkN "Repetition" feminine ; -- status=guess status=guess
lin eventual_A = variants{} ; -- 
lin credit_V2 = variants{} ; -- 
lin suburb_N = mkN "Vorstadt" feminine | mkN "Vorort" masculine ; -- status=guess status=guess
lin newcomer_N = mkN "Neuling" "Neulinge" masculine ; -- status=guess
lin romance_N = mkN "Romanze" feminine ; -- status=guess
lin film_V2 = mkV2 (regV "filmen" | regV "drehen") ; -- status=guess, src=wikt status=guess, src=wikt
lin film_V = regV "filmen" | regV "drehen" ; -- status=guess, src=wikt status=guess, src=wikt
lin experiment_V2 = mkV2 (irregV "experimentieren" "experimentiert" "experimentierte" "experimentierte" "experimentiert") ; -- status=guess, src=wikt
lin experiment_V = irregV "experimentieren" "experimentiert" "experimentierte" "experimentierte" "experimentiert" ; -- status=guess, src=wikt
lin daylight_N = mkN "Tageslicht" neuter ; -- status=guess
lin warrant_N = variants{} ; -- 
lin fur_N = mkN "Pelz" "Pelze" masculine | mkN "Pelzmantel" masculine ; -- status=guess status=guess
lin parking_N = mkN "Parken" neuter | mkN "Parkieren" neuter ; -- status=guess status=guess
lin nuisance_N = mkN "Belästigung" feminine ; -- status=guess
lin civilian_A = variants{} ; -- 
lin foolish_A = mk3A "dumm" "dümmer" "dümmste" | mkA "närrisch" | mkA "töricht" ; -- status=guess status=guess status=guess
lin bulb_N = mkN "Zwiebel" "Zwiebeln" feminine ; -- status=guess
lin balloon_N = mkN "Ballon" masculine | mkN "Luftballon" masculine ; -- status=guess status=guess
lin vivid_A = mk3A "lebendig" "lebendiger" "lebendigste" | mk3A "lebhaft" "lebhafter" "lebhafteste" ; -- status=guess status=guess
lin surveyor_N = mkN "Vermesser" ; -- status=guess
lin spontaneous_A = mk3A "spontan" "spontaner" "spontanste" ; -- status=guess
lin biology_N = mkN "Biologie" feminine ; -- status=guess
lin injunction_N = mkN "Verfügung" feminine ; -- status=guess
lin appalling_A = mk3A "erschreckend" "erschreckender" "erschreckendste" ; -- status=guess
lin amusement_N = mkN "Amüsement" neuter | mkN "Entertainment" neuter | mkN "Unterhaltung" | mkN "Vergnügen" neuter ; -- status=guess status=guess status=guess status=guess
lin aesthetic_A = mkA "ästhetisch" ; -- status=guess
lin vegetation_N = mkN "Vegetation" feminine ; -- status=guess
lin stab_V2 = L.stab_V2 ;
lin stab_V = irregV "stechen" "stecht" "stach" "stäche" "gestochen" | irregV "erstechen" "erstecht" "erstach" "erstäche" "erstochen" | mkV "niederstechen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rude_A = mk3A "grob" "gröber" "gröbste" | mkA "unhöflich" | mk3A "frech" "frecher" "frechste" | mkA "unverschämt" ; -- status=guess status=guess status=guess status=guess
lin offset_V2 = variants{} ; -- 
lin thinking_N = variants{} ; -- 
lin mainframe_N = mkN "Großrechner" masculine ; -- status=guess
lin flock_N = mkN "Schwarm" "Schwärme" masculine | mkN "Schar" "Scharen" feminine ; -- status=guess status=guess
lin amateur_A = mkA "amateurhaft" ; -- status=guess
lin academy_N = mkN "akademische Einrichtung" feminine ; -- status=guess
lin shilling_N = mkN "Schilling" masculine ; -- status=guess
lin reluctance_N = mkN "Widerstreben" neuter ; -- status=guess
lin velocity_N = mkN "Geschwindigkeit" "Geschwindigkeiten" feminine ; -- status=guess
lin spare_V2 = variants{} ; -- 
lin spare_V = variants{} ; -- 
lin wartime_N = variants{} ; -- 
lin soak_V2 = mkV2 (mkV "durchnässen") ; -- status=guess, src=wikt
lin soak_V = mkV "durchnässen" ; -- status=guess, src=wikt
lin rib_N = mkN "Brustkorb" "Brustkörbe" masculine ; -- status=guess
lin mighty_A = mk3A "gewaltig" "gewaltiger" "gewaltigste" | mkA "mächtig" ; -- status=guess status=guess
lin shocked_A = mkA "schockiert" ; -- status=guess
lin vocational_A = variants{} ; -- 
lin spit_V2 = mkV2 (regV "spucken") ; -- status=guess, src=wikt
lin spit_V = L.spit_V ;
lin gall_N = mkN "Galle" "Gallen" feminine ; -- status=guess
lin bowl_V2 = variants{} ; -- 
lin bowl_V = variants{} ; -- 
lin prescription_N = mkN "Rezept" "Rezepte" neuter | mkN "Verschreibung" feminine ; -- status=guess status=guess
lin fever_N = mkN "Fieber" "Fieber" neuter ; -- status=guess
lin axis_N = mkN "Achse" "Achsen" feminine ; -- status=guess
lin reservoir_N = mkN "Stausee" "Stauseen" masculine ; -- status=guess
lin magnitude_N = variants{} ; -- 
lin rape_V2 = mkV2 (irregV "vergewaltigen" "vergewaltigt" "vergewaltigte" "vergewaltigte" "vergewaltigt" | mkV "schänden") ; -- status=guess, src=wikt status=guess, src=wikt
lin cutting_N = mkN "Steckling" masculine | mkN "Ableger" "Ableger" masculine | mkN "Senkreis" neuter ; -- status=guess status=guess status=guess
lin bracket_N = mkN "Klammer" "Klammern" feminine ; -- status=guess
lin agony_N = mkN "Agonie" "Agonien" feminine | mkN "Qual" "Qualen" feminine | mkN "Pein" feminine ; -- status=guess status=guess status=guess
lin strive_VV = mkVV (regV "streben") ; -- status=guess, src=wikt
lin strive_V = regV "streben" ; -- status=guess, src=wikt
lin strangely_Adv = variants{} ; -- 
lin pledge_VS = mkVS (mkV "verpfänden") ; -- status=guess, src=wikt
lin pledge_V2V = mkV2V (mkV "verpfänden") ; -- status=guess, src=wikt
lin pledge_V2 = mkV2 (mkV "verpfänden") ; -- status=guess, src=wikt
lin recipient_N = mkN "Empfänger" masculine ; -- status=guess
lin moor_N = mkN "Moor" "Moore" neuter ; -- status=guess
lin invade_V2 = mkV2 (mkV "überfallen") | mkV2 (mkV "einmarschieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin dairy_N = mkN "Molkerei" "Molkereien" feminine ; -- status=guess
lin chord_N = mkN "Akkord" "Akkorde" masculine ; -- status=guess
lin shrink_V2 = mkV2 (mkReflV "drücken") ; -- status=guess, src=wikt
lin shrink_V = mkReflV "drücken" ; -- status=guess, src=wikt
lin poison_N = gift_N | mkN "Giftstoff" masculine ; -- status=guess status=guess
lin pillar_N = mkN "Pfeiler" "Pfeiler" masculine | mkN "Säule" feminine ; -- status=guess status=guess
lin washing_N = mkN "Waschen" neuter ; -- status=guess
lin warrior_N = mkN "Krieger" "Krieger" masculine ; -- status=guess
lin supervisor_N = mkN "Aufseher" "Aufseher" masculine | mkN "Vorgesetzter" masculine ; -- status=guess status=guess
lin outfit_N = mkN "Outfit" "Outfits" neuter ; -- status=guess
lin innovative_A = mk3A "innovativ" "innovativer" "innovativste" ; -- status=guess
lin dressing_N = mkN "Dressing" "Dressings" neuter ; -- status=guess
lin dispute_V2 = variants{} ; -- 
lin dispute_V = variants{} ; -- 
lin jungle_N = mkN "Urwald" "Urwälder" masculine | mkN "Dschungel" feminine neuter ; -- status=guess status=guess
lin brewery_N = mkN "Brauerei" "Brauereien" feminine | mkN "Brauhaus" neuter | mkN "Bierbrauerei" ; -- status=guess status=guess status=guess
lin adjective_N = mkN "Adjektiv" "Adjektive" neuter | mkN "Eigenschaftswort" "Eigenschaftswörter" neuter ; -- status=guess status=guess
lin straighten_V2 = variants{} ; -- 
lin straighten_V = variants{} ; -- 
lin restrain_V2 = mkV2 (mkV "zügeln") ; -- status=guess, src=wikt
lin monarchy_N = mkN "Monarchie" "Monarchien" feminine ; -- status=guess
lin trunk_N = mkN "Rüssel" masculine ; -- status=guess
lin herd_N = mkN "Herde" "Herden" feminine ; -- status=guess
lin deadline_N = mkN "Stichtag" masculine | mkN "Frist" "Fristen" feminine | mkN "Termin" "Termine" masculine ; -- status=guess status=guess status=guess
lin tiger_N = mkN "Tiger" "Tiger" masculine ; -- status=guess
lin supporting_A = variants{} ; -- 
lin moderate_A = mk3A "moderat" "moderater" "moderateste" ; -- status=guess
lin kneel_V = regV "knien" ; -- status=guess, src=wikt
lin ego_N = mkN "Ich-Laut" "Ich-Laute" masculine | mkN "Ego-Shooter" "Ego-Shooter" masculine ; -- status=guess status=guess
lin sexually_Adv = variants{} ; -- 
lin ministerial_A = mkA "ministeriell" ; -- status=guess
lin bitch_N = mkN "Zicke" "Zicken" feminine ; -- status=guess
lin wheat_N = mkN "Weizen" "Weizensorten" masculine ; -- status=guess
lin stagger_V = regV "zweifeln" | regV "wanken" ; -- status=guess, src=wikt status=guess, src=wikt
lin snake_N = L.snake_N ;
lin ribbon_N = mkN "Band" neuter ; -- status=guess
lin mainland_N = mkN "Festland" "Festländer" neuter | mkN "Kontinent" "Kontinente" masculine ; -- status=guess status=guess
lin fisherman_N = mkN "Fischer" "Fischer" masculine | mkN "Fischerin" feminine ; -- status=guess status=guess
lin economically_Adv = variants{} ; -- 
lin unwilling_A = variants{} ; -- 
lin nationalism_N = mkN "Nationalismus" masculine ; -- status=guess
lin knitting_N = mkN "Stricken" neuter ; -- status=guess
lin irony_N = mkN "Ironie" "Ironien" feminine ; -- status=guess
lin handling_N = mkN "Hehlerei" "Hehlereien" feminine ; -- status=guess
lin desired_A = variants{} ; -- 
lin bomber_N = mkN "Bomber" "Bomber" masculine ; -- status=guess
lin voltage_N = mkN "Spannung" ; -- status=guess
lin unusually_Adv = variants{} ; -- 
lin toast_N = mkN "Trinkspruch" "Trinksprüche" masculine | mkN "Toast" masculine | mkN "Tischrede" feminine ; -- status=guess status=guess status=guess
lin feel_N = variants{} ; -- 
lin suffering_N = mkN "Leiden" "Leiden" neuter ; -- status=guess
lin polish_V2 = mkV2 (irregV "polieren" "poliert" "polierte" "polierte" "poliert") ; -- status=guess, src=wikt
lin polish_V = irregV "polieren" "poliert" "polierte" "polierte" "poliert" ; -- status=guess, src=wikt
lin technically_Adv = mkAdv "eigentlich" ; -- status=guess
lin meaningful_A = mk3A "bedeutend" "bedeutender" "bedeutendste" | mk3A "bedeutungsvoll" "bedeutungsvoller" "bedeutungsvollste" ; -- status=guess status=guess
lin aloud_Adv = mkAdv "laut" | mkAdv "vorlesen" ; -- status=guess status=guess
lin waiter_N = mkN "Ober" "Ober" masculine | mkN "Kellner" "Kellner" masculine ; -- status=guess status=guess
lin tease_V2 = mkV2 (regV "necken" | mkV "hänseln") ; -- status=guess, src=wikt status=guess, src=wikt
lin opposite_Adv = mkAdv "gegenüber" ; -- status=guess
lin goat_N = mkN "Ziege" "Ziegen" feminine | mkN "Geiß" feminine ; -- status=guess status=guess
lin conceptual_A = variants{} ; -- 
lin ant_N = mkN "Ameise" "Ameisen" feminine ; -- status=guess
lin inflict_V2 = mkV2 (mkV "verhängen") | mkV2 (mkV "zufügen") ; -- status=guess, src=wikt status=guess, src=wikt
lin bowler_N = mkN "Melone" "Melonen" feminine | mkN "Melonenhut" masculine ; -- status=guess status=guess
lin roar_V2 = mkV2 (mkV "brüllen") ; -- status=guess, src=wikt
lin roar_V = mkV "brüllen" ; -- status=guess, src=wikt
lin drain_N = mkN "Abfluss" "Abflüsse" masculine ; -- status=guess
lin wrong_N = variants{} ; -- 
lin galaxy_N = mkN "Galaxie" "Galaxien" feminine | mkN "Galaxis" feminine | mkN "Welteninsel" feminine ; -- status=guess status=guess status=guess
lin aluminium_N = mkN "Aluminium" "Aluminien" neuter ; -- status=guess
lin receptor_N = variants{} ; -- 
lin preach_V2 = mkV2 (regV "predigen") ; -- status=guess, src=wikt
lin preach_V = regV "predigen" ; -- status=guess, src=wikt
lin parade_N = mkN "Folge" "Folgen" feminine | mkN "Abfolge" "Abfolgen" feminine ; -- status=guess status=guess
lin opposite_N = mkN "Gegenteil" "Gegenteile" neuter ; -- status=guess
lin critique_N = mkN "Kritik" "Kritiken" feminine ; -- status=guess
lin query_N = mkN "Abfrage" "Abfragen" feminine ; -- status=guess
lin outset_N = mkN "Anfang" "Anfänge" masculine | mkN "Beginn" "Beginne" masculine ; -- status=guess status=guess
lin integral_A = mkA "integral" ; -- status=guess
lin grammatical_A = regA "grammatisch" | regA "grammatikalisch" ; -- status=guess status=guess
lin testing_N = variants{} ; -- 
lin patrol_N = mkN "Patrouille" "Patrouillen" feminine ; -- status=guess
lin pad_N = mkN "Unterlage" "Unterlagen" feminine | mkN "Polster" neuter ; -- status=guess status=guess
lin unreasonable_A = mkA "unvernünftig" ; -- status=guess
lin sausage_N = mkN "Wurst" "Würste" feminine ; -- status=guess
lin criminal_N = mkN "Kriminelle" feminine | mkN "Krimineller" masculine | mkN "Verbrecher" "Verbrecher" masculine ; -- status=guess status=guess status=guess
lin constructive_A = mk3A "konstruktiv" "konstruktiver" "konstruktivste" ; -- status=guess
lin worldwide_A = regA "weltweit" ; -- status=guess
lin highlight_N = mkN "Highlight" neuter ; -- status=guess
lin doll_N = mkN "Puppe" "Puppen" feminine ; -- status=guess
lin frightened_A = variants{} ; -- 
lin biography_N = mkN "Biografie" "Biografien" feminine | mkN "Biographie" "Biographien" feminine ; -- status=guess status=guess
lin vocabulary_N = mkN "Wortschatz" "Wortschätze" masculine ; -- status=guess status=guess
lin offend_V2 = mkV2 (regV "beleidigen") ; -- status=guess, src=wikt
lin offend_V = regV "beleidigen" ; -- status=guess, src=wikt
lin accumulation_N = mkN "Anhäufung" feminine ; -- status=guess
lin linen_N = mkN "Leinen" "Leinen" neuter ; -- status=guess
lin fairy_N = fee_N | mkN "Elfe" "Elfen" feminine ; -- status=guess status=guess
lin disco_N = mkN "Diskothek" "Diskotheken" feminine ; -- status=guess
lin hint_VS = variants{} ; -- 
lin hint_V2 = variants{} ; -- 
lin hint_V = variants{} ; -- 
lin versus_Prep = variants{} ; -- 
lin ray_N = mkN "Strahl" "Strahlen" masculine ; -- status=guess
lin pottery_N = mkN "Töpferware" feminine ; -- status=guess
lin immune_A = mk3A "immun" "immuner" "immunste" ; -- status=guess
lin retreat_N = mkN "Rückzug" ; -- status=guess
lin master_V2 = mkV2 (mkV "meistern") ; -- status=guess, src=wikt
lin injured_A = variants{} ; -- 
lin holly_N = mkN "Stechpalme" "Stechpalmen" feminine | mkN "Hülse" feminine ; -- status=guess status=guess
lin battle_V2 = mkV2 (mkV "kämpfen") ; -- status=guess, src=wikt
lin battle_V = mkV "kämpfen" ; -- status=guess, src=wikt
lin solidarity_N = mkN "Solidarität" feminine | mkN "Unterstützung" feminine ; -- status=guess status=guess
lin embarrassing_A = mk3A "peinlich" "peinlicher" "peinlichste" ; -- status=guess
lin cargo_N = mkN "Fracht" "Frachten" feminine ; -- status=guess
lin theorist_N = mkN "Theoretiker" "Theoretiker" masculine ; -- status=guess
lin reluctantly_Adv = mkAdv "ungern" ; -- status=guess
lin preferred_A = variants{} ; -- 
lin dash_V = variants{} ; -- 
lin total_V2 = mkV2 (mkV "aufaddieren") | mkV2 (mkV "zusammenaddieren") | mkV2 (mkV "zusammennehmen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin total_V = mkV "aufaddieren" | mkV "zusammenaddieren" | mkV "zusammennehmen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reconcile_V2 = mkV2 (junkV (mkV "1.") "schlichten") | mkV2 (junkV (mkV "versöhnen") "2.") ; -- status=guess, src=wikt status=guess, src=wikt
lin drill_N = mkN "Bohreisen" neuter ; -- status=guess
lin credibility_N = mkN "Glaubwürdigkeit" feminine ; -- status=guess
lin copyright_N = mkN "Urheberrecht" "Urheberrechte" neuter ; -- status=guess
lin beard_N = mkN "Bart" "Bärte" masculine ; -- status=guess
lin bang_N = mkN "Schlag" "Schläge" masculine | mkN "Hieb" "Hiebe" masculine ; -- status=guess status=guess
lin vigorous_A = variants{} ; -- 
lin vaguely_Adv = variants{} ; -- 
lin punch_V2 = mkV2 (mkV "lochen") ; -- status=guess, src=wikt
lin prevalence_N = variants{} ; -- 
lin uneasy_A = variants{} ; -- 
lin boost_N = variants{} ; -- 
lin scrap_N = mkN "Altmaterial" neuter | mkN "Altmetall" "Altmetalle" neuter | mkN "Schrott" "Schrotte" masculine | mkN "Abfall" "Abfälle" masculine ; -- status=guess status=guess status=guess status=guess
lin ironically_Adv = variants{} ; -- 
lin fog_N = L.fog_N ;
lin faithful_A = mk3A "treu" "treuer" "treusten, treueste" ; -- status=guess
lin bounce_V2 = mkV2 (mkV "abprallen") ; -- status=guess, src=wikt
lin bounce_V = mkV "abprallen" ; -- status=guess, src=wikt
lin batch_N = mkN "Partie" "Partien" feminine ; -- status=guess
lin smooth_V2 = variants{} ; -- 
lin smooth_V = variants{} ; -- 
lin sleeping_A = mkA "Schlaf-" ; -- status=guess
lin poorly_Adv = variants{} ; -- 
lin accord_V = variants{} ; -- 
lin vice_president_N = variants{} ; -- 
lin duly_Adv = mkAdv "gebührend" | mkAdv "ordnungsgemäß" ; -- status=guess status=guess
lin blast_N = mkN "Windstoß" masculine ; -- status=guess
lin square_V2 = mkV2 (regV "quadrieren") ; -- status=guess, src=wikt
lin square_V = regV "quadrieren" ; -- status=guess, src=wikt
lin prohibit_V2 = mkV2 (irregV "verbieten" "verbietet" "verbot" "verböte" "verboten") ; -- status=guess, src=wikt
lin prohibit_V = irregV "verbieten" "verbietet" "verbot" "verböte" "verboten" ; -- status=guess, src=wikt
lin brake_N = mkN "Bremse" "Bremsen" feminine ; -- status=guess
lin asylum_N = mkN "psychiatrische Anstalt" feminine ; -- status=guess
lin obscure_V2 = mkV2 (mkV "verdunkeln") | mkV2 (mkV "vernebeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin nun_N = mkN "Nonne" "Nonnen" feminine | mkN "Ordensschwester" feminine | mkN "Klosterschwester" feminine | mkN "Schwester" "Schwestern" feminine ; -- status=guess status=guess status=guess status=guess
lin heap_N = mkN "Heap" masculine ; -- status=guess
lin smoothly_Adv = variants{} ; -- 
lin rhetoric_N = mkN "Rhetorik" "Rhetoriken" feminine ; -- status=guess
lin privileged_A = mkA "privilegiert" ; -- status=guess
lin liaison_N = variants{} ; -- 
lin jockey_N = mkN "Jockey" "Jockeys" masculine ; -- status=guess
lin concrete_N = mkN "Beton" masculine ; -- status=guess
lin allied_A = variants{} ; -- 
lin rob_V2 = mkV2 (regV "rauben") ; -- status=guess, src=wikt
lin indulge_V2 = mkV2 (mkV "frönen") | mkV2 (mkV "hätscheln") | mkV2 (mkV "verwöhnen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin indulge_V = mkV "frönen" | mkV "hätscheln" | mkV "verwöhnen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin except_Prep = S.except_Prep ;
lin distort_V2 = mkV2 (mkV "verzerren") ; -- status=guess, src=wikt
lin whatsoever_Adv = variants{} ; -- 
lin viable_A = mkA "selbständig" ; -- status=guess
lin nucleus_N = mkN "Zellkern" masculine | mkN "Nukleus" "Nuklei" masculine ; -- status=guess status=guess
lin exaggerate_V2 = mkV2 (mkV "übertreiben") ; -- status=guess, src=wikt
lin exaggerate_V = mkV "übertreiben" ; -- status=guess, src=wikt
lin compact_N = mkN "Pakt" "Pakte" masculine | mkN "Kontrakt" masculine ; -- status=guess status=guess
lin nationality_N = mkN "Nationalität" ; -- status=guess
lin direct_Adv = variants{} ; -- 
lin cast_N = mkN "Cast" masculine | mkN "Besetzung" | mkN "Ensemble" "Ensembles" neuter ; -- status=guess status=guess status=guess
lin altar_N = mkN "Altar" "Altäre" masculine ; -- status=guess
lin refuge_N = mkN "Herberge" "Herbergen" feminine | mkN "Zuflucht" feminine ; -- status=guess status=guess
lin presently_Adv = mkAdv "sogleich" ; -- status=guess
lin mandatory_A = mkA "zwingend notwendig" | regA "obligatorisch" ; -- status=guess status=guess
lin authorize_V2V = mkV2V (regV "autorisieren" | mkV "befugen" | mkV "ermächtigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin authorize_V2 = mkV2 (regV "autorisieren" | mkV "befugen" | mkV "ermächtigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin accomplish_V2 = mkV2 (mkV "vollenden") ; -- status=guess, src=wikt
lin startle_V2 = variants{} ; -- 
lin indigenous_A = regA "indigen" ; -- status=guess
lin worse_Adv = variants{} ; -- 
lin retailer_N = mkN "Einzelhändler" masculine ; -- status=guess
lin compound_V2 = variants{} ; -- 
lin compound_V = variants{} ; -- 
lin admiration_N = mkN "Bewunderung" ; -- status=guess
lin absurd_A = mk3A "absurd" "absurder" "absurdeste" ; -- status=guess
lin coincidence_N = mkN "zufälliges Zusammentreffen" masculine | mkN "Koinzidenz" "Koinzidenzen" feminine ; -- status=guess status=guess
lin principally_Adv = variants{} ; -- 
lin passport_N = mkN "Reisepass" "Reisepässe" masculine | pass_N ; -- status=guess status=guess
lin depot_N = mkN "Depot" "Depots" neuter ; -- status=guess
lin soften_V2 = variants{} ; -- 
lin soften_V = variants{} ; -- 
lin secretion_N = mkN "Sekretion" feminine ; -- status=guess
lin invoke_V2 = mkV2 (prefixV "auf" (irregV "rufen" "ruft" "rief" "rief" "gerufen")) ; -- status=guess, src=wikt
lin dirt_N = mkN "Schmutz" masculine ; -- status=guess
lin scared_A = mkA "sich fürchten" | mkA "sich furchten" ; -- status=guess status=guess
lin mug_N = mkN "Becher" "Becher" masculine ; -- status=guess
lin convenience_N = mkN "Annehmlichkeit" "Annehmlichkeiten" feminine | mkN "Bequemlichkeit" "Bequemlichkeiten" feminine ; -- status=guess status=guess
lin calm_N = mkN "Ruhe vor dem Sturm" feminine ; -- status=guess
lin optional_A = mk3A "freiwillig" "freiwilliger" "freiwilligste" | regA "optional" | regA "wahlfrei" ; -- status=guess status=guess status=guess
lin unsuccessful_A = mkA "erfolglos" ; -- status=guess
lin consistency_N = mkN "Konsistenz" "Konsistenzen" feminine ; -- status=guess
lin umbrella_N = mkN "Schirm" "Schirme" masculine ; -- status=guess
lin solo_N = mkN "Solo" neuter ; -- status=guess
lin hemisphere_N = mkN "Hemisphäre" feminine | mkN "Halbkugel" "Halbkugeln" feminine ;
lin extreme_N = mkN "Extrem" "Extreme" neuter ; -- status=guess
lin brandy_N = mkN "Kurzer" masculine ; -- status=guess
lin belly_N = L.belly_N ;
lin attachment_N = mkN "Anlage" "Anlagen" feminine | mkN "Anhang" "Anhänge" masculine ; -- status=guess status=guess
lin wash_N = mkN "Lavierung" ; -- status=guess
lin uncover_V2 = variants{} ; -- 
lin treat_N = variants{} ; -- 
lin repeated_A = variants{} ; -- 
lin pine_N = mkN "Föhre" feminine | mkN "Kiefer" "Kiefern" feminine ; -- status=guess status=guess
lin offspring_N = mkN "Hinterlassenschaft" "Hinterlassenschaften" feminine ; -- status=guess
lin communism_N = mkN "Kommunismus" masculine ; -- status=guess
lin nominate_V2 = mkV2 (regV "nominieren") ; -- status=guess, src=wikt
lin soar_V2 = mkV2 (regV "schweben") ; -- status=guess, src=wikt
lin soar_V = regV "schweben" ; -- status=guess, src=wikt
lin geological_A = variants{} ; -- 
lin frog_N = mkN "Frosch" "Frösche" masculine ; -- status=guess
lin donate_V2 = mkV2 (regV "spenden" | irregV "stiften" "stiftet" "stiftete" "stiftete" "gestiftet" | regV "schenken") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin donate_V = regV "spenden" | irregV "stiften" "stiftet" "stiftete" "stiftete" "gestiftet" | regV "schenken" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin cooperative_A = mk3A "kooperativ" "kooperativer" "kooperativste" ; -- status=guess
lin nicely_Adv = variants{} ; -- 
lin innocence_N = mkN "Unschuld" feminine ; -- status=guess
lin housewife_N = mkN "Hausfrau" "Hausfrauen" feminine ; -- status=guess
lin disguise_V2 = mkV2 (irregV "verstellen" "verstellt" "verstellte" "verstellte" "verstellt") ; -- status=guess, src=wikt
lin demolish_V2 = mkV2 (mkV "abreißen") | mkV2 (mkV "niederreißen") ; -- status=guess, src=wikt status=guess, src=wikt
lin counsel_N = rat_N | mkN "Ratschlag" "Ratschläge" masculine ; -- status=guess status=guess
lin cord_N = mkN "Schnur" "Schnüre" feminine | mkN "Kordel" feminine ; -- status=guess status=guess
lin semi_final_N = variants{} ; -- 
lin reasoning_N = argumentation_N ; -- status=guess
lin litre_N = mkN "Liter" masculine ; -- status=guess
lin inclined_A = mk3A "geneigt" "geneigter" "geneigteste" ; -- status=guess
lin evoke_V2 = mkV2 (prefixV "hervor" I.rufen_V) ; -- status=guess, src=wikt
lin courtyard_N = mkN "Hof" "Höfe" masculine ; -- status=guess
lin arena_N = mkN "Arena" "Arenen" feminine ; -- status=guess
lin simplicity_N = mkN "Einfachheit" feminine ; -- status=guess
lin inhibition_N = mkN "Unterdrückung" feminine ; -- status=guess
lin frozen_A = regA "gefroren" ; -- status=guess
lin vacuum_N = mkN "Vakuum" neuter ; -- status=guess
lin immigrant_N = mkN "Einwanderer" "Einwanderer" masculine | mkN "Einwanderin" feminine | mkN "Immigrant" "Immigranten" masculine | mkN "Immigrantin" feminine ; -- status=guess status=guess status=guess status=guess
lin bet_N = mkN "Bestimmtheit" feminine ; -- status=guess
lin revenge_N = mkN "Rache" feminine ; -- status=guess
lin jail_V2 = variants{} ; -- 
lin helmet_N = helm_N ; -- status=guess
lin unclear_A = mk3A "unklar" "unklarer" "unklarste" ; -- status=guess
lin jerk_V2 = mkV2 (irregV "zucken" "zuckt" "zuckte" "zuckte" "zuckt") ; -- status=guess, src=wikt
lin jerk_V = irregV "zucken" "zuckt" "zuckte" "zuckte" "zuckt" ; -- status=guess, src=wikt
lin disruption_N = mkN "Durcheinander" "Durcheinander" neuter | mkN "Unordnung" feminine ; -- status=guess status=guess
lin attainment_N = variants{} ; -- 
lin sip_V2 = variants{} ; -- 
lin sip_V = variants{} ; -- 
lin program_V2V = mkV2V (mkV "programmieren") ; -- status=guess, src=wikt
lin program_V2 = mkV2 (mkV "programmieren") ; -- status=guess, src=wikt
lin lunchtime_N = variants{} ; -- 
lin cult_N = mkN "Sekte" "Sekten" feminine ; -- status=guess
lin chat_N = mkN "Schmätzer" feminine ; -- status=guess
lin accord_N = mkN "Übereinstimmung" feminine ; -- status=guess
lin supposedly_Adv = mkAdv "angeblich" ; -- status=guess
lin offering_N = variants{} ; -- 
lin broadcast_N = mkN "Sendung" | mkN "Übertragung" feminine | mkN "Ausstrahlung" feminine | mkN "Rundfunk" masculine ; -- status=guess status=guess status=guess status=guess
lin secular_A = mkA "säkular" | mk3A "weltlich" "weltlicher" "weltlichste" ; -- status=guess status=guess
lin overwhelm_V2 = mkV2 (mkV "überwältigen") ; -- status=guess, src=wikt
lin momentum_N = mkN "Schwung" ; -- status=guess
lin infinite_A = regA "unendlich" ; -- status=guess
lin manipulation_N = mkN "Manipulierung" feminine | mkN "Manipulieren" neuter | mkN "Manipulation" ; -- status=guess status=guess status=guess
lin inquest_N = variants{} ; -- 
lin decrease_N = mkN "Verringerung" ; -- status=guess
lin cellar_N = mkN "Keller" "Keller" masculine ; -- status=guess
lin counsellor_N = variants{} ; -- 
lin avenue_N = mkN "Allee" "Alleen" feminine ; -- status=guess
lin rubber_A = variants{} ; -- 
lin labourer_N = variants{} ; -- 
lin lab_N = variants{} ; -- 
lin damn_V2 = mkV2 (mkV "verdammen") ; -- status=guess, src=wikt
lin comfortably_Adv = variants{} ; -- 
lin tense_A = mk3A "gespannt" "gespannter" "gespannteste" ; -- status=guess
lin socket_N = mkN "Steckdose" "Steckdosen" feminine | mkN "Fassung" ; -- status=guess status=guess
lin par_N = variants{} ; -- 
lin thrust_N = variants{} ; -- 
lin scenario_N = mkN "Szenario" neuter | mkN "Szenarium" neuter | mkN "Drehbuch" "Drehbücher" neuter ; -- status=guess status=guess status=guess
lin frankly_Adv = variants{} ; -- 
lin slap_V2 = mkV2 (regV "klatschen" | irregV "schlagen" "schlagt" "schlug" "schlüge" "geschlagen" | mkV "patschen" | regV "ohrfeigen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin recreation_N = mkN "Erholung" feminine | mkN "Unterhaltung" ; -- status=guess status=guess
lin rank_V2 = mkV2 (junkV (mkV "an") "einer Stelle stehen") ; -- status=guess, src=wikt
lin rank_V = junkV (mkV "an") "einer Stelle stehen" ; -- status=guess, src=wikt
lin spy_N = mkN "Spion" ; -- status=guess
lin filter_V2 = mkV2 (regV "filtrieren" | regV "passieren") ; -- status=guess, src=wikt status=guess, src=wikt
lin filter_V = regV "filtrieren" | regV "passieren" ; -- status=guess, src=wikt status=guess, src=wikt
lin clearance_N = mkN "Ausverkauf" masculine ; -- status=guess
lin blessing_N = mkN "Segnen" neuter | mkN "Segnung" feminine ; -- status=guess status=guess
lin embryo_N = mkN "Embryo" "Embryonen" masculine ; -- status=guess
lin varied_A = variants{} ; -- 
lin predictable_A = mkA "vorhersagbar" | mkA "prädiktabel" ; -- status=guess status=guess
lin mutation_N = mkN "Mutation" ; -- status=guess
lin equal_V2 = mkV2 (irregV "gleichen" "gleicht" "glich" "gliche" "geglichen") ; -- status=guess, src=wikt
lin can_1_VV = S.can_VV ;
lin can_2_VV = S.can8know_VV ;
lin can_V2 = variants{} ; -- 
lin burst_N = mkN "Bersten" neuter | mkN "Zerbrechen" neuter | mkN "Platzen" neuter ; -- status=guess status=guess status=guess
lin retrieve_V2 = mkV2 (mkV "zurückholen") ; -- status=guess, src=wikt
lin retrieve_V = mkV "zurückholen" ; -- status=guess, src=wikt
lin elder_N = mkN "Holunder" "Holunder" masculine ; -- status=guess
lin rehearsal_N = probe_N ; -- status=guess
lin optical_A = regA "optisch" ; -- status=guess
lin hurry_N = mkN "Eile" feminine ; -- status=guess
lin conflict_V = variants{} ; -- 
lin combat_V2 = variants{} ; -- 
lin combat_V = variants{} ; -- 
lin absorption_N = mkN "Absorption" ; -- status=guess
lin ion_N = mkN "Ion" "Ionen" neuter ; -- status=guess
lin wrong_Adv = variants{} ; -- 
lin heroin_N = mkN "Heroin" neuter ; -- status=guess
lin bake_V2 = mkV2 (irregV "backen" "backt" "buk" "büke" "gebacken") ; -- status=guess, src=wikt
lin bake_V = irregV "backen" "backt" "buk" "büke" "gebacken" ; -- status=guess, src=wikt
lin x_ray_N = variants{} ; -- 
lin vector_N = mkN "Vektor" "Vektoren" masculine ; -- status=guess
lin stolen_A = variants{} ; -- 
lin sacrifice_V2 = mkV2 (irregV "opfern" "opfert" "opferte" "opferte" "opfert") ; -- status=guess, src=wikt
lin sacrifice_V = irregV "opfern" "opfert" "opferte" "opferte" "opfert" ; -- status=guess, src=wikt
lin robbery_N = mkN "Raub" "Raube" masculine ; -- status=guess
lin probe_V2 = variants{} ; -- 
lin probe_V = variants{} ; -- 
lin organizational_A = variants{} ; -- 
lin chalk_N = mkN "Kreide" "Kreiden" feminine ; -- status=guess
lin bourgeois_A = mkA "spießig" ; -- status=guess
lin villager_N = mkN "Dorfbewohner" "Dorfbewohner" masculine | mkN "Dorfbewohnerin" feminine | mkN "Dörfler" masculine | mkN "Dörflerin" feminine ; -- status=guess status=guess status=guess status=guess
lin morale_N = moral_N ; -- status=guess
lin express_A = mkA "ausdrücklich" ; -- status=guess
lin climb_N = variants{} ; -- 
lin notify_V2 = mkV2 (prefixV "mit" (irregV "teilen" "teilt" "teilte" "teilte" "geteilt") | regV "benachrichtigen") ; -- status=guess, src=wikt status=guess, src=wikt
lin jam_N = mkN "Stau" masculine ; -- status=guess
lin bureaucratic_A = mkA "bürokratisch" ; -- status=guess
lin literacy_N = mkN "Lese- und Schreibfähigkeit" feminine ; -- status=guess
lin frustrate_V2 = mkV2 (mkV "frustrieren") ; -- status=guess, src=wikt
lin freight_N = mkN "Fracht" "Frachten" feminine ; -- status=guess
lin clearing_N = mkN "Klärung" feminine | mkN "Aufklärung" feminine ; -- status=guess status=guess
lin aviation_N = mkN "Luftfahrt" feminine ; -- status=guess
lin legislature_N = mkN "Legislative" "Legislativen" feminine | mkN "gesetzgebende Gewalt" feminine ; -- status=guess status=guess
lin curiously_Adv = variants{} ; -- 
lin banana_N = mkN "Banane" "Bananen" feminine ; -- status=guess
lin deploy_V2 = variants{} ; -- 
lin deploy_V = variants{} ; -- 
lin passionate_A = mk3A "leidenschaftlich" "leidenschaftlicher" "leidenschaftlichste" ; -- status=guess
lin monastery_N = mkN "Kloster" "Klöster" neuter ; -- status=guess
lin kettle_N = mkN "Kessel" "Kessel" masculine | mkN "Kochtopf" "Kochtöpfe" masculine ; -- status=guess status=guess
lin enjoyable_A = variants{} ; -- 
lin diagnose_V2 = mkV2 (irregV "diagnostizieren" "diagnostiziert" "diagnostizierte" "diagnostizierte" "diagnostiziert") ; -- status=guess, src=wikt
lin quantitative_A = regA "quantitativ" ; -- status=guess
lin distortion_N = mkN "Verzerrung" feminine | mkN "Verformung" feminine | mkN "Verwindung" feminine ; -- status=guess status=guess status=guess
lin monarch_N = mkN "Monarch" "Monarchen" masculine | mkN "Monarchin" feminine | mkN "Fürst" masculine ; -- status=guess status=guess status=guess
lin kindly_Adv = mkAdv "freundlicherweise" | mkAdv "liebenswürdig" ; -- status=guess status=guess
lin glow_V = mkV "glühen" ; -- status=guess, src=wikt
lin acquaintance_N = mkN "Bekannter" masculine | mkN "Bekannte" feminine ; -- status=guess status=guess
lin unexpectedly_Adv = mkAdv "unerwartet" ; -- status=guess
lin handy_A = mk3A "anstellig" "anstelliger" "anstelligste" | mk3A "handlich" "handlicher" "handlichste" | mk3A "praktisch" "praktischer" "praktischste" ; -- status=guess status=guess status=guess
lin deprivation_N = variants{} ; -- 
lin attacker_N = mkN "Angreifer" "Angreifer" masculine | mkN "Angreiferin" feminine ; -- status=guess status=guess
lin assault_V2 = mkV2 (mkV "überfallen" | prefixV "an" (irregV "greifen" "greift" "griff" "griffe" "gegriffen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin screening_N = variants{} ; -- 
lin retired_A = variants{} ; -- 
lin quick_Adv = variants{} ; -- 
lin portable_A = mk3A "portabel" "portabler" "portabelste" | regA "tragbar" ; -- status=guess status=guess
lin hostage_N = mkN "Geisel" "Geiseln" feminine ; -- status=guess
lin underneath_Prep = variants{} ; -- 
lin jealous_A = mkA "eifersüchtig" ; -- status=guess
lin proportional_A = mk3A "proportional" "proportionaler" "proportionalste" ; -- status=guess
lin gown_N = variants{} ; -- 
lin chimney_N = mkN "Schlot" masculine ; -- status=guess
lin bleak_A = mk3A "freudlos" "freudloser" "freudloseste" ; -- status=guess
lin seasonal_A = regA "saisonal" ; -- status=guess
lin plasma_N = mkN "Kielfeld-Beschleuniger" masculine ; -- status=guess
lin stunning_A = variants{} ; -- 
lin spray_N = mkN "Spray" "Sprays" neuter ; -- status=guess
lin referral_N = variants{} ; -- 
lin promptly_Adv = variants{} ; -- 
lin fluctuation_N = mkN "Schwankung" ; -- status=guess
lin decorative_A = mkA "dekorativ" ; -- status=guess
lin unrest_N = mkN "Unruhe" ; ----n {f} {p}" ; -- status=guess
lin resent_VS = mkVS (mkReflV "ärgern") | mkVS (junkV (mkV "empört") "sein") | mkVS (mkReflV "empören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin resent_V2 = mkV2 (mkReflV "ärgern") | mkV2 (junkV (mkV "empört") "sein") | mkV2 (mkReflV "empören") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin plaster_N = mkN "Gips" "Gipse" masculine | mkN "Gipsverband" "Gipsverbände" masculine ; -- status=guess status=guess
lin chew_V2 = mkV2 (regV "kauen") ; -- status=guess, src=wikt
lin chew_V = regV "kauen" ; -- status=guess, src=wikt
lin grouping_N = variants{} ; -- 
lin gospel_N = mkN "Evangelium" "Evangelien" neuter ; -- status=guess
lin distributor_N = mkN "Verteiler" masculine ; -- status=guess
lin differentiation_N = mkN "Unterscheidung" ; -- status=guess
lin blonde_A = variants{} ; -- 
lin aquarium_N = mkN "Aquarium" "Aquarien" neuter ; -- status=guess
lin witch_N = mkN "Hexe" "Hexen" feminine ; -- status=guess
lin renewed_A = variants{} ; -- 
lin jar_N = mkN "Glas" neuter | mkN "Gefäß" neuter ; -- status=guess status=guess
lin approved_A = variants{} ; -- 
lin advocateMasc_N = reg2N "Rechtsanwalt" "Rechtsanwälte" masculine;
lin worrying_A = variants{} ; -- 
lin minimize_V2 = mkV2 (regV "minimieren") ; -- status=guess, src=wikt
lin footstep_N = mkN "Schritt" "Schritte" masculine ; -- status=guess
lin delete_V2 = mkV2 (irregV "streichen" "streicht" "strich" "striche" "gestrichen" | mkV "löschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin underneath_Adv = variants{} ; -- 
lin lone_A = regA "einzeln" ; -- status=guess
lin level_V2 = mkV2 (irregV "ebnen" "ebnet" "ebnete" "ebnete" "geebnet") ; -- status=guess, src=wikt
lin level_V = irregV "ebnen" "ebnet" "ebnete" "ebnete" "geebnet" ; -- status=guess, src=wikt
lin exceptionally_Adv = variants{} ; -- 
lin drift_N = mkN "Drift" feminine ; -- status=guess
lin spider_N = mkN "Spinne" "Spinnen" feminine ; -- status=guess
lin hectare_N = mkN "Hektar" "Hektare" neuter ; -- status=guess
lin colonel_N = mkN "Oberst" masculine ; -- status=guess
lin swimming_N = mkN "Schwimmen" neuter ; -- status=guess
lin realism_N = mkN "Realismus" "Realismen" masculine ; -- status=guess
lin insider_N = mkN "Insider" "Insider" masculine ; -- status=guess
lin hobby_N = mkN "Hobby" "Hobbys" neuter | mkN "Steckenpferd" "Steckenpferde" neuter ; -- status=guess status=guess
lin computing_N = variants{} ; -- 
lin infrastructure_N = mkN "Infrastruktur" "Infrastrukturen" feminine ; -- status=guess
lin cooperate_V = prefixV "zusammen" (irregV "arbeiten" "arbeitet" "arbeitete" "arbeitete" "gearbeitet") | irregV "kooperieren" "kooperiert" "kooperierte" "kooperierte" "kooperiert" ; -- status=guess, src=wikt status=guess, src=wikt
lin burn_N = mkN "Brandwunde" "Brandwunden" feminine | mkN "Verbrennung" ; -- status=guess status=guess
lin cereal_N = mkN "Getreide" "Getreide" neuter ; -- status=guess
lin fold_N = mkN "Faltung" feminine | mkN "Falzung" feminine | mkN "Falten" neuter ; -- status=guess status=guess status=guess
lin compromise_V2 = mkV2 (irregV "einen" "eint" "einte" "einte" "geeint"); -- status=guess, src=wikt
lin compromise_V = irregV "einen" "eint" "einte" "einte" "geeint" ; -- status=guess, src=wikt
lin boxing_N = mkN "Boxen" neuter ; -- status=guess
lin rear_V2 = mkV2 (prefixV "auf" (irregV "ziehen" "zieht" "zog" "zöge" "gezogen") | irregV "erziehen" "erzieht" "erzog" "erzöge" "erzogen" | mkV "großziehen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rear_V = prefixV "auf" (irregV "ziehen" "zieht" "zog" "zöge" "gezogen") | irregV "erziehen" "erzieht" "erzog" "erzöge" "erzogen" | mkV "großziehen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin lick_V2 = mkV2 (mkV "auslecken") ; -- status=guess, src=wikt
lin constrain_V2 = mkV2 (regV "behindern" | mkV "einschränken" | mkV "limitieren") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin clerical_A = regA "klerikal" | regA "geistlich" | mkA "priesterlich" ; -- status=guess status=guess status=guess
lin hire_N = variants{} ; -- 
lin contend_VS = variants{} ; -- 
lin contend_V = variants{} ; -- 
lin amateurMasc_N = mkN "Amateur" "Amateure" masculine ; -- status=guess status=guess
lin instrumental_A = mkA "instrumental" ; -- status=guess
lin terminal_A = variants{} ; -- 
lin electorate_N = mkN "Kurfürstentum" neuter ; -- status=guess
lin congratulate_V2 = mkV2 (regV "gratulieren" | mkV "beglückwünschen") ; -- status=guess, src=wikt status=guess, src=wikt
lin balanced_A = variants{} ; -- 
lin manufacturing_N = variants{} ; -- 
lin split_N = mkN "Spagat" "Spagate" masculine | mkN "To-do-Liste" "To-do-Listen" feminine ; -- status=guess status=guess
lin domination_N = variants{} ; -- 
lin blink_V2 = mkV2 (regV "zwinkern") ; -- status=guess, src=wikt status=guess, src=wikt
lin blink_V = regV "zwinkern" | junkV (mkV "mit") "den Augen zwinkern" ; -- status=guess, src=wikt status=guess, src=wikt
lin bleed_VS = mkVS (junkV (mkV "ausbluten") "lassen") ; -- status=guess, src=wikt
lin bleed_V2 = mkV2 (junkV (mkV "ausbluten") "lassen") ; -- status=guess, src=wikt
lin bleed_V = junkV (mkV "ausbluten") "lassen" ; -- status=guess, src=wikt
lin unlawful_A = mk3A "gesetzeswidrig" "gesetzeswidriger" "gesetzeswidrigste" | regA "gesetzwidrig" ; -- status=guess status=guess
lin precedent_N = mkN "Präzedens" neuter ; -- status=guess
lin notorious_A = mkA "berüchtigt" ; -- status=guess
lin indoor_A = mkA "Innen-" | mkA "Haus-" ; -- status=guess status=guess
lin upgrade_V2 = variants{} ; -- 
lin trench_N = mkN "Graben" "Gräben" masculine ; -- status=guess
lin therapist_N = mkN "Therapeut" masculine ; -- status=guess
lin illuminate_V2 = mkV2 (regV "illuminieren") ; -- status=guess, src=wikt
lin bargain_V2 = variants{} ; -- 
lin bargain_V = variants{} ; -- 
lin warranty_N = mkN "Garantie" "Garantien" feminine ; -- status=guess
lin scar_V2 = variants{} ; -- 
lin scar_V = variants{} ; -- 
lin consortium_N = mkN "Konsortium" "Konsortien" neuter ; -- status=guess
lin anger_V2 = mkV2 (mkV "ärgern") ; -- status=guess, src=wikt
lin insure_VS = mkVS (irregV "versichern" "versichert" "versicherte" "versicherte" "versichert") ; -- status=guess, src=wikt
lin insure_V2 = mkV2 (irregV "versichern" "versichert" "versicherte" "versicherte" "versichert") ; -- status=guess, src=wikt
lin insure_V = irregV "versichern" "versichert" "versicherte" "versicherte" "versichert" ; -- status=guess, src=wikt
lin extensively_Adv = mkAdv "umfassend" ; -- status=guess
lin appropriately_Adv = variants{} ; -- 
lin spoon_N = mkN "Löffel" masculine ; -- status=guess
lin sideways_Adv = mkAdv "seitlich" ; -- status=guess
lin enhanced_A = mkA "verstärkt" ; -- status=guess
lin disrupt_V2 = mkV2 (junkV (mkV "durcheinander") "bringen") ; -- status=guess, src=wikt
lin disrupt_V = junkV (mkV "durcheinander") "bringen" ; -- status=guess, src=wikt
lin satisfied_A = mk3A "zufrieden" "zufriedener" "zufriedenste" | mkA "befriedigt" ; -- status=guess status=guess
lin precaution_N = mkN "Vorsichtsmaßnahme" feminine ; -- status=guess
lin kite_N = mkN "Milan" "Milane" masculine ; -- status=guess
lin instant_N = mkN "löslicher Kaffee" masculine ; -- status=guess
lin gig_N = mkN "Auftritt" "Auftritte" masculine ; -- status=guess
lin continuously_Adv = mkAdv "ständig" | mkAdv "ununterbrochen" | mkAdv "andauernd" ; -- status=guess status=guess status=guess
lin consolidate_V2 = mkV2 (irregV "vereinigen" "vereinigt" "vereinigte" "vereinigte" "vereinigt" | mkV "zusammenlegen" | mkV "zusammenführen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin consolidate_V = irregV "vereinigen" "vereinigt" "vereinigte" "vereinigte" "vereinigt" | mkV "zusammenlegen" | mkV "zusammenführen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin fountain_N = mkN "Springbrunnen" "Springbrunnen" masculine ; -- status=guess
lin graduate_V2 = mkV2 (prefixV "ab" (irregV "solvieren" "solviert" "solvierte" "solvierte" "gesolviert")) ; -- status=guess, src=wikt
lin graduate_V = prefixV "ab" (irregV "solvieren" "solviert" "solvierte" "solvierte" "gesolviert") ; -- status=guess, src=wikt
lin gloom_N = variants{} ; -- 
lin bite_N = mkN "Biss" "Bisse" masculine ; -- status=guess
lin structure_V2 = mkV2 (mkV "strukturieren") ; -- status=guess, src=wikt
lin noun_N = mkN "Substantiv" "Substantive" neuter | mkN "Nomen proprium" "Nomina propria" neuter | mkN "Dingwort" "Dingwörter" neuter | mkN "Gegenstandswort" "Gegenstandswörter" neuter ; -- status=guess status=guess status=guess status=guess
lin nomination_N = mkN "Nominierung" feminine ; -- status=guess
lin armchair_N = mkN "Armsessel" masculine | fauteuil_N | mkN "Polstersessel" masculine | mkN "Polsterstuhl" masculine | mkN "Sessel" "Sessel" masculine | mkN "Lehnstuhl" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin virtual_A = regA "eigentlich" | regA "virtuell" ; -- status=guess status=guess
lin unprecedented_A = mk3A "beispiellos" "beispielloser" "beispielloseste" ; -- status=guess
lin tumble_V2 = mkV2 (regV "stolpern") ; -- status=guess, src=wikt
lin tumble_V = regV "stolpern" ; -- status=guess, src=wikt
lin ski_N = mkN "Ski" masculine | mkN "Schi" masculine ; -- status=guess status=guess
lin architectural_A = mkA "architektonisch" ; -- status=guess
lin violation_N = mkN "Verletzung" ; -- status=guess
lin rocket_N = mkN "Rakete" "Raketen" feminine ; -- status=guess
lin inject_V2 = mkV2 (irregV "injizieren" "injiziert" "injizierte" "injizierte" "injiziert" | regV "spritzen") ; -- status=guess, src=wikt status=guess, src=wikt
lin departmental_A = variants{} ; -- 
lin row_V2 = variants{} ; -- 
lin row_V = variants{} ; -- 
lin luxury_A = variants{} ; -- 
lin fax_N = mkN "Fax" "Faxe" neuter ; -- status=guess
lin deer_N = mkN "Hirsch" masculine ; -- status=guess
lin climber_N = mkN "Bergsteiger" "Bergsteiger" masculine | mkN "Bergsteigerin" "Bergsteigerinnen" feminine | mkN "Kletterer" masculine ; -- status=guess status=guess status=guess
lin photographic_A = variants{} ; -- 
lin haunt_V2 = variants{} ; -- 
lin fiercely_Adv = variants{} ; -- 
lin dining_N = mkN "Speisewagen" masculine ; -- status=guess
lin sodium_N = mkN "Natrium" neuter ; -- status=guess
lin gossip_N = mkN "Klatsch" "Klatsche" masculine | mkN "Tratsch" "Tratsch" masculine ; -- status=guess status=guess
lin bundle_N = mkN "Bündel" neuter ; -- status=guess
lin bend_N = mkN "Kurve" "Kurven" feminine ; -- status=guess
lin recruit_N = mkN "Rekrut" "Rekruten" masculine ; -- status=guess
lin hen_N = mkN "Weibchen" "Weibchen" neuter ; -- status=guess
lin fragile_A = mk3A "fragil" "fragiler" "fragilste" | mkA "zerbrechlich" ; -- status=guess status=guess
lin deteriorate_V2 = mkV2 (irregV "verschlechtern" "verschlechtert" "verschlechterte" "verschlechterte" "verschlechtert" | mkReflV "verschlechtern") ; -- status=guess, src=wikt status=guess, src=wikt
lin deteriorate_V = irregV "verschlechtern" "verschlechtert" "verschlechterte" "verschlechterte" "verschlechtert" | mkReflV "verschlechtern" ; -- status=guess, src=wikt status=guess, src=wikt
lin dependency_N = mkN "Kolonie" "Kolonien" feminine | mkN "Schutzgebiet" neuter ; -- status=guess status=guess
lin swift_A = mk3A "schnell" "schneller" "schnellste" ; -- status=guess
lin scramble_V2 = mkV2 (irregV "klettern" "klettert" "kletterte" "klettere" "geklettert" | regV "kraxeln") ; -- status=guess, src=wikt status=guess, src=wikt
lin scramble_V = irregV "klettern" "klettert" "kletterte" "klettere" "geklettert" | regV "kraxeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin overview_N = mkN "Übersicht" feminine | mkN "Überblick" masculine ; -- status=guess status=guess
lin imprison_V2 = mkV2 (prefixV "ein" (regV "sperren") | prefixV "ein" (regV "kerkern")) ; -- status=guess, src=wikt status=guess, src=wikt
lin trolley_N = mkN "Karren" "Karren" masculine | mkN "Einkaufswagen" "Einkaufswagen" masculine ; -- status=guess status=guess
lin rotation_N = mkN "Umdrehung" feminine ; -- status=guess
lin denial_N = mkN "Leugnung" | mkN "Dementi" "Dementis" neuter ; -- status=guess status=guess
lin boiler_N = mkN "Kessel" "Kessel" masculine | mkN "Boiler" "Boiler" masculine ; -- status=guess status=guess
lin amp_N = variants{} ; -- 
lin trivial_A = mk3A "trivial" "trivialer" "trivialste" ; -- status=guess
lin shout_N = mkN "Schrei" "Schreie" masculine ; -- status=guess
lin overtake_V2 = mkV2 (mkV "überholen") ; -- status=guess, src=wikt
lin make_N = mkN "Fabrikat" "Fabrikate" neuter | mkN "Marke" "Marken" feminine ; -- status=guess status=guess
lin hunter_N = mkN "Jäger" masculine ; -- status=guess
lin guess_N = mkN "Vermutung" ; -- status=guess
lin doubtless_Adv = variants{} ; -- 
lin syllable_N = mkN "Silbe" "Silben" feminine ; -- status=guess
lin obscure_A = mk3A "obskur" "obskurer" "obskurste" | mkA "düster" | mk3A "undeutlich" "undeutlicher" "undeutlichste" ; -- status=guess status=guess status=guess
lin mould_N = variants{} ; -- 
lin limestone_N = mkN "Kalkstein" "Kalksteine" masculine ; -- status=guess
lin leak_V2 = mkV2 (mkV "lecken") ;
lin leak_V = mkV "lecken" | regV "tropfen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin beneficiary_N = mkN "Nutznießer" masculine ; -- status=guess
lin veteran_N = mkN "Veteran" "Veteranen" masculine ; -- status=guess
lin surplus_A = variants{} ; -- 
lin manifestation_N = mkN "Manifestation" "Manifestationen" feminine | mkN "Erscheinung" ; -- status=guess status=guess
lin vicar_N = mkN "Vikar" "Vikare" masculine ; -- status=guess
lin textbook_N = mkN "Lehrbuch" "Lehrbücher" neuter ; -- status=guess
lin novelist_N = mkN "Novellist" masculine | mkN "Romancier" masculine ; -- status=guess status=guess
lin halfway_Adv = mkAdv "halbwegs" ; -- status=guess
lin contractual_A = variants{} ; -- 
lin swap_V2 = mkV2 (regV "tauschen" | prefixV "aus" (regV "tauschen") | mkV "vertauschen" | regV "wechseln") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin swap_V = regV "tauschen" | prefixV "aus" (regV "tauschen") | mkV "vertauschen" | regV "wechseln" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin guild_N = mkN "Gilde" "Gilden" feminine | mkN "Zunft" "Zünfte" feminine ; -- status=guess status=guess
lin ulcer_N = mkN "Geschwür" neuter | mkN "Ulcus" neuter ; -- status=guess status=guess
lin slab_N = mkN "Scheibe" "Scheiben" feminine | mkN "Platte" "Platten" feminine ; -- status=guess status=guess
lin detector_N = mkN "Detektor" "Detektoren" masculine ; -- status=guess
lin detection_N = variants{} ; -- 
lin cough_V = irregV "husten" "hustet" "hustete" "huste" "gehustet" ; -- status=guess, src=wikt
lin whichever_Quant = variants{} ; -- 
lin spelling_N = mkN "Orthografie" "Orthografien" feminine | mkN "Orthographie" "Orthographien" feminine | mkN "Rechtschreibung" ; -- status=guess status=guess status=guess
lin lender_N = mkN "Darlehensgeber" masculine | mkN "Verleiher" masculine ; -- status=guess status=guess
lin glow_N = mkN "Glühen" neuter ; -- status=guess
lin raised_A = variants{} ; -- 
lin prolonged_A = variants{} ; -- 
lin voucher_N = mkN "Gutschein" "Gutscheine" masculine ; -- status=guess
lin t_shirt_N = variants{} ; -- 
lin linger_V = mkV "herumlungern" | mkV "verzögern" | junkV (mkV "Zeit") "brauchen" | irregV "verweilen" "verweilt" "verweilte" "verweilte" "verweilt" | irregV "bleiben" "bleibt" "blieb" "blieb" "geblieben" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin humble_A = mk3A "einfach" "einfacher" "einfachste" | mk3A "bescheiden" "bescheidener" "bescheidenste" ; -- status=guess status=guess
lin honey_N = mkN "Honigdachs" masculine ; -- status=guess
lin scream_N = mkN "Aufschrei" "Aufschreie" masculine ;
lin postcard_N = mkN "Postkarte" "Postkarten" feminine ; -- status=guess
lin managing_A = variants{} ; -- 
lin alien_A = mk3A "fremd" "fremder" "fremdeste" | mkA "fremdartig" ; -- status=guess status=guess
lin trouble_V2 = mkV2 (regV "beunruhigen" | mkV "belästigen" | mkV "bekümmern") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin reverse_N = mkN "Rückwärtsgang" masculine ; -- status=guess
lin odour_N = mkN "Geruch" "Gerüche" masculine ; -- status=guess
lin fundamentally_Adv = variants{} ; -- 
lin discount_V2 = variants{} ; -- 
lin discount_V = variants{} ; -- 
lin blast_V2 = variants{} ; -- 
lin blast_V = variants{} ; -- 
lin syntactic_A = variants{} ; -- 
lin scrape_V2 = mkV2 (prefixV "ab" (regV "kratzen") | regV "kratzen" | regV "schaben" | regV "scharren" | mkV "schrammen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin scrape_V = prefixV "ab" (regV "kratzen") | regV "kratzen" | regV "schaben" | regV "scharren" | mkV "schrammen" ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin residue_N = variants{} ; -- 
lin procession_N = mkN "Prozession" | mkN "Umzug" "Umzüge" masculine ; -- status=guess status=guess
lin pioneer_N = mkN "Pionier" "Pioniere" masculine ; -- status=guess
lin intercourse_N = mkN "Umgang" "Umgänge" masculine | mkN "Verkehr" "Verkehre" masculine ; -- status=guess status=guess status=guess
lin deter_V2 = mkV2 (prefixV "ab" (irregV "halten" "hält" "hielt" "hielte" "gehalten") | irregV "verhindern" "verhindert" "verhinderte" "verhinderte" "verhindert") ; -- status=guess, src=wikt status=guess, src=wikt
lin deadly_A = mkA "tödlich" ; -- status=guess
lin complement_V2 = mkV2 (mkV "ergänzen") ; -- status=guess, src=wikt
lin restrictive_A = mkA "einschränkend" | mk3A "restriktiv" "restriktiver" "restriktivste" ; -- status=guess status=guess
lin nitrogen_N = mkN "Stickstoff" masculine ; -- status=guess
lin citizenship_N = mkN "Staatsbürgerschaft" feminine | mkN "Staatsangehörigkeit" feminine ; -- status=guess status=guess
lin pedestrian_N = mkN "Fußgänger" masculine | mkN "Fußgängerin" feminine | mkN "Fußgeher" masculine | mkN "Fußgeherin" feminine | mkN "Passant" "Passanten" masculine | mkN "Passantin" feminine ; -- status=guess status=guess status=guess status=guess status=guess status=guess
lin detention_N = mkN "Nachsitzen" neuter ; -- status=guess
lin wagon_N = mkN "Wagen" ; -- status=guess
lin microphone_N = mkN "Mikrofon" "Mikrofone" neuter ; -- status=guess
lin hastily_Adv = mkAdv "hastig" ; -- status=guess
lin fixture_N = mkN "Fassung" ; -- status=guess
lin choke_V2 = mkV2 (irregV "ersticken" "erstickt" "erstickte" "erstickte" "erstickt") ; -- status=guess, src=wikt
lin choke_V = irregV "ersticken" "erstickt" "erstickte" "erstickte" "erstickt" ; -- status=guess, src=wikt
lin wet_V2 = mkV2 (junkV (mkV "nass") "werden") ; -- status=guess, src=wikt
lin weed_N = mkN "Glimmstängel" masculine | mkN "Kippe" "Kippen" feminine ; -- status=guess status=guess
lin programming_N = mkN "Programmierung" feminine | mkN "Programmieren" neuter ; -- status=guess status=guess
lin power_V2 = variants{} ; -- 
lin nationally_Adv = variants{} ; -- 
lin dozen_N = mkN "Dutzende" ; -- status=guess
lin carrot_N = mkN "Möhre" feminine | mkN "Mohrrübe" feminine | mkN "Karotte" "Karotten" feminine ; -- status=guess status=guess status=guess
lin bulletin_N = mkN "Mitteilungsblatt" neuter | mkN "Bulletin" "Bulletins" neuter ; -- status=guess status=guess
lin wording_N = mkN "Formulierung" ; -- status=guess
lin vicious_A = mkA "unmoralisch" ; -- status=guess
lin urgency_N = mkN "Dringlichkeit" feminine ; -- status=guess
lin spoken_A = variants{} ; -- 
lin skeleton_N = mkN "Rohbau" "Rohbauten" masculine ; -- status=guess
lin motorist_N = variants{} ; -- 
lin interactive_A = mk3A "interaktiv" "interaktiver" "interaktivste" ; -- status=guess
lin compute_V2 = mkV2 (regV "berechnen") ; -- status=guess, src=wikt
lin compute_V = regV "berechnen" ; -- status=guess, src=wikt
lin whip_N = mkN "Peitsche" "Peitschen" feminine ; -- status=guess
lin urgently_Adv = variants{} ; -- 
lin telly_N = mkN "Glotze" "Glotzen" feminine | mkN "Fernseher" "Fernseher" masculine ; -- status=guess status=guess
lin shrub_N = mkN "Busch" "Büsche" masculine | mkN "Strauch" "Sträucher" masculine ; -- status=guess status=guess
lin porter_N = mkN "Gepäckträger" masculine ; -- status=guess
lin ethics_N = mkN "Verhaltenskodex" masculine | mkN "Ethik" "Ethiken" feminine ; -- status=guess status=guess
lin banner_N = mkN "Banner" "Banner" neuter ; -- status=guess
lin velvet_N = mkN "Samt" "Samte" masculine ; -- status=guess
lin omission_N = mkN "Unterlassung" feminine ; -- status=guess
lin hook_V2 = mkV2 (regV "haken") ; -- status=guess, src=wikt
lin hook_V = regV "haken" ; -- status=guess, src=wikt
lin gallon_N = mkN "Gallone" feminine ; -- status=guess
lin financially_Adv = variants{} ; -- 
lin superintendent_N = mkN "Leiter" "Leitern" feminine ; -- status=guess
lin plug_V2 = variants{} ; -- 
lin plug_V = variants{} ; -- 
lin continuation_N = mkN "Fortsetzung" ; -- status=guess
lin reliance_N = variants{} ; -- 
lin justified_A = mkA "gerechtfertigt" ; -- status=guess
lin fool_V2 = mkV2 (mkV "täuschen" | regV "schwindeln" | mkV "betrügen" | irregV "verarschen" "verarscht" "verarschte" "verarschte" "verarscht") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin detain_V2 = mkV2 (irregV "verhaften" "verhaftet" "verhaftete" "verhaftete" "verhaftet") ; -- status=guess, src=wikt
lin damaging_A = variants{} ; -- 
lin orbit_N = mkN "Umlaufbahn" feminine | mkN "Orbit" "Orbits" masculine ; -- status=guess status=guess
lin mains_N = mkN "Stromnetz" neuter ; -- status=guess
lin discard_V2 = mkV2 (irregV "verwerfen" "verwerft" "verwarf" "verwürfe" "verworfen") ; -- status=guess, src=wikt
lin dine_V = regV "speisen" ; -- status=guess, src=wikt
lin compartment_N = mkN "Abteil" "Abteile" neuter ; -- status=guess
lin revised_A = variants{} ; -- 
lin privatization_N = mkN "Privatisierung" ; -- status=guess
lin memorable_A = variants{} ; -- 
lin lately_Adv = variants{} ; -- 
lin distributed_A = variants{} ; -- 
lin disperse_V2 = variants{} ; -- 
lin disperse_V = variants{} ; -- 
lin blame_N = mkN "Schuld" "Schulden" feminine ; -- status=guess
lin basement_N = mkN "Keller" "Keller" masculine | mkN "Untergeschoss" "Untergeschosse" neuter ; -- status=guess status=guess
lin slump_V2 = variants{} ; -- 
lin slump_V = variants{} ; -- 
lin puzzle_V2 = variants{} ; -- 
lin monitoring_N = mkN "Überwachung" feminine ; -- status=guess
lin talented_A = mk3A "begabt" "begabter" "begabteste" | mk3A "talentiert" "talentierter" "talentierteste" ; -- status=guess status=guess
lin nominal_A = variants{} ; -- 
lin mushroom_N = mkN "Atompilz" masculine | mkN "Pilzwolke" "Pilzwolken" feminine | mkN "Rauchpilz" "Rauchpilze" masculine ; -- status=guess status=guess status=guess
lin instructor_N = mkN "Ausbilder" "Ausbilder" masculine | mkN "Lehrer-Schwa" "Lehrer-Schwas" neuter ; -- status=guess status=guess
lin fork_N = variants{} ; -- 
lin fork_4_N = variants{} ; -- 
lin fork_3_N = variants{} ; -- 
lin fork_1_N = variants{} ; -- 
lin board_V2 = mkV2 (irregV "entern" "entert" "enterte" "enterte" "geentert") ; -- status=guess, src=wikt
lin want_N = mkN "Not" "Nöte" feminine ; -- status=guess
lin disposition_N = mkN "Einteilung" | mkN "Gliederung" | mkN "Anordnung" ; -- status=guess status=guess status=guess
lin cemetery_N = variants{} ; -- 
lin attempted_A = variants{} ; -- 
lin nephew_N = mkN "Neffe" "Neffen" masculine ; -- status=guess
lin magical_A = variants{} ; -- 
lin ivory_N = mkN "Elfenbein" neuter ; -- status=guess
lin hospitality_N = mkN "Gastfreundlichkeit" feminine | mkN "Gastfreundschaft" "Gastfreundschaften" feminine | mkN "Gastlichkeit" feminine ; -- status=guess status=guess status=guess
lin besides_Prep = variants{} ; -- 
lin astonishing_A = mkA "verwunderlich" ; -- status=guess
lin tract_N = mkN "Traktat" neuter ; -- status=guess
lin proprietor_N = mkN "Besitzer" "Besitzer" masculine | mkN "Inhaber" "Inhaber" masculine ; -- status=guess status=guess
lin license_V2 = mkV2 (regV "lizenzieren") ; -- status=guess, src=wikt
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
lin dentist_N = mkN "Zahnarzt" "Zahnärzte" masculine | mkN "Zahnärztin" feminine ; -- status=guess status=guess
lin contrary_N = variants{} ; -- 
lin profitability_N = variants{} ; -- 
lin enthusiast_N = variants{} ; -- 
lin crop_V2 = mkV2 (mkV "ausschneiden") ; -- status=guess, src=wikt
lin crop_V = mkV "ausschneiden" ; -- status=guess, src=wikt
lin utter_V2 = mkV2 (mkV "ausstoßen") ; -- status=guess, src=wikt
lin pile_V2 = mkV2 (regV "stapeln" | mkV "aufstapeln" | mkV "anhäufen" | mkV "schichten") ;
lin pile_V = regV "stapeln" | mkV "aufstapeln" | mkV "anhäufen" | mkV "schichten" ;
lin pier_N = mkN "Pier" "Piere" feminine | mkN "Anlegestelle" feminine ; -- status=guess status=guess
lin dome_N = mkN "Kuppel" "Kuppeln" feminine | mkN "Schild" "Schilde" masculine ; -- status=guess status=guess
lin bubble_N = mkN "Blase" "Blasen" feminine ; -- status=guess
lin treasurer_N = mkN "Finanzminister" "Finanzminister" masculine ; -- status=guess
lin stocking_N = mkN "Strumpf" "Strümpfe" masculine ; -- status=guess
lin sanctuary_N = variants{} ; -- 
lin ascertain_V2 = mkV2 (prefixV "fest" (irregV "stellen" "stellt" "stelle" "stelle" "gestellt")) ; -- status=guess, src=wikt
lin arc_N = mkN "Bogen" masculine | mkN "Kurve" "Kurven" feminine ; -- status=guess status=guess
lin quest_N = mkN "Suche" "Suchen" feminine | mkN "Queste" feminine ; -- status=guess status=guess
lin mole_N = mkN "Maulwurf" "Maulwürfe" masculine ; -- status=guess
lin marathon_N = mkN "Marathon" "Marathons" masculine ; -- status=guess
lin feast_N = mkN "Festmahl" "Festmahle" neuter ; -- status=guess
lin crouch_V = regV "kauern" ; -- status=guess, src=wikt
lin storm_V2 = mkV2 (mkV "stürmen") ; -- status=guess, src=wikt
lin storm_V = mkV "stürmen" ; -- status=guess, src=wikt
lin hardship_N = mkN "Härte" feminine | mkN "Not" "Nöte" feminine ; -- status=guess status=guess
lin entitlement_N = mkN "Anspruch" "Ansprüche" masculine ; -- status=guess
lin circular_N = mkN "Kreisbogen" masculine ; -- status=guess
lin walking_A = variants{} ; -- 
lin strap_N = mkN "Achselklappe" feminine ; -- status=guess
lin sore_A = mk3A "wund" "wunder" "wundeste" | mkA "weh" | mk3A "schlimm" "schlimmer" "schlimmste" | mkA "entzündet" ; -- status=guess status=guess status=guess status=guess
lin complementary_A = variants{} ; -- 
lin understandable_A = mkA "verständlich" ; -- status=guess
lin noticeable_A = mkA "wahrnehmbar" ; -- status=guess
lin mankind_N = mkN "Menschheit" feminine ; -- status=guess
lin majesty_N = mkN "Majestät" feminine ; -- status=guess
lin pigeon_N = mkN "Taube" "Tauben" feminine | mkN "Tauber" "Tauber" masculine | mkN "Täuber" masculine | mkN "Tauberich" masculine | mkN "Täuberich" masculine | mkN "Täubin" feminine | mkN "Täubchen" neuter | mkN "Täublein" neuter | mkN "Kolumbide" masculine ; -- status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess status=guess
lin goalkeeper_N = mkN "Torwart" "Torwarte" masculine | mkN "Torwartin" feminine | mkN "Torhüter" masculine | mkN "Torhüterin" feminine | mkN "Tormann" "Torleute" masculine ; -- status=guess status=guess status=guess status=guess status=guess
lin ambiguous_A = regA "mehrdeutig" | mkA "doppeldeutig" ; -- status=guess status=guess
lin walker_N = variants{} ; -- 
lin virgin_N = mkN "Jungfrau" "Jungfrauen" feminine ; -- status=guess
lin prestige_N = mkN "Prestige" neuter ; -- status=guess
lin preoccupation_N = variants{} ; -- 
lin upset_A = variants{} ; -- 
lin municipal_A = regA "munizipal" ; -- status=guess
lin groan_V2 = mkV2 (mkV "ächzen") | mkV2 (mkV "stöhnen") ; -- status=guess, src=wikt status=guess, src=wikt
lin groan_V = mkV "ächzen" | mkV "stöhnen" ; -- status=guess, src=wikt status=guess, src=wikt
lin craftsman_N = mkN "Handwerker" "Handwerker" masculine ; -- status=guess
lin anticipation_N = variants{} ; -- 
lin revise_V2 = mkV2 (regV "wiederholen") ; -- status=guess, src=wikt
lin revise_V = regV "wiederholen" ; -- status=guess, src=wikt
lin knock_N = mkN "Klopfen" neuter ; -- status=guess
lin infect_V2 = mkV2 (prefixV "an" (irregV "stecken" "steckt" "steckte" "steckte" "gesteckt") | irregV "infizieren" "infiziert" "infizierte" "infizierte" "infiziert") ; -- status=guess, src=wikt status=guess, src=wikt
lin infect_V = prefixV "an" (irregV "stecken" "steckt" "steckte" "steckte" "gesteckt") | irregV "infizieren" "infiziert" "infizierte" "infizierte" "infiziert" ; -- status=guess, src=wikt status=guess, src=wikt
lin denounce_V2 = mkV2 (mkV "kündigen") ; -- status=guess, src=wikt
lin confession_N = mkN "Beichte" "Beichten" feminine ; -- status=guess
lin turkey_N = mkN "Truthahn" "Truthähne" masculine | mkN "Truthenne" feminine | mkN "Puter" masculine | mkN "Pute" "Puten" feminine ; -- status=guess status=guess status=guess status=guess
lin toll_N = mkN "Abgabe" "Abgaben" feminine | mkN "Maut" "Mauten" feminine ;
lin pal_N = variants{} ; -- 
lin transcription_N = mkN "Transkription" ; -- status=guess
lin sulphur_N = variants{} ; -- 
lin provisional_A = regA "provisorisch" ; -- status=guess
lin hug_V2 = mkV2 (mkReflV "umarmen") ; -- status=guess, src=wikt
lin particular_N = variants{} ; -- 
lin intent_A = variants{} ; -- 
lin fascinate_V2 = mkV2 (regV "faszinieren" | mkV "bezaubern") ; -- status=guess, src=wikt status=guess, src=wikt
lin conductor_N = mkN "Dirigent" "Dirigenten" masculine ; -- status=guess
lin feasible_A = mkA "durchführbar" | mk3A "machbar" "machbarer" "machbarste" ; -- status=guess status=guess
lin vacant_A = mk3A "frei" "freier" "freisten, freieste" | regA "vakant" ; -- status=guess status=guess
lin trait_N = mkN "Eigenschaft" "Eigenschaften" feminine ; -- status=guess
lin meadow_N = mkN "Wiese" "Wiesen" feminine | mkN "Weide" "Weiden" feminine ; -- status=guess status=guess
lin creed_N = mkN "Glaubensbekenntnis" "Glaubensbekenntnisse" neuter ; -- status=guess
lin unfamiliar_A = mk3A "unbekannt" "unbekannter" "unbekannteste" | mkA "unvertraut" ; -- status=guess status=guess
lin optimism_N = mkN "Optimismus" masculine | mkN "Zuversicht" "Zuversichten" feminine ; -- status=guess status=guess
lin wary_A = mk3A "achtsam" "achtsamer" "achtsamste" | mkA "umsichtig" | mk3A "vorsichtig" "vorsichtiger" "vorsichtigste" | mk3A "wachsam" "wachsamer" "wachsamste" ; -- status=guess status=guess status=guess status=guess
lin twist_N = mkN "Bohrer" "Bohrer" masculine ; -- status=guess
lin sweet_N = mkN "Süßigkeit" feminine ; -- status=guess
lin substantive_A = variants{} ; -- 
lin excavation_N = mkN "Grabung" feminine | mkN "Ausgrabung" ; -- status=guess status=guess
lin destiny_N = mkN "Schicksal" "Schicksale" neuter | mkN "Los" "Lose" neuter ; -- status=guess status=guess
lin thick_Adv = variants{} ; -- 
lin pasture_N = mkN "Weide" "Weiden" feminine ; -- status=guess
lin archaeological_A = mkA "archäologisch" ; -- status=guess
lin tick_V2 = mkV2 (regV "ticken") ; -- status=guess, src=wikt
lin tick_V = regV "ticken" ; -- status=guess, src=wikt
lin profit_V2 = mkV2 (irregV "profitieren" "profitiert" "profitierte" "profitierte" "profitiert") ; -- status=guess, src=wikt
lin profit_V = irregV "profitieren" "profitiert" "profitierte" "profitierte" "profitiert" ; -- status=guess, src=wikt
lin pat_V2 = mkV2 (mkV "tätscheln") ; -- status=guess, src=wikt
lin pat_V = mkV "tätscheln" ; -- status=guess, src=wikt
lin papal_A = mkA "päpstlich" ; -- status=guess
lin cultivate_V2 = mkV2 (regV "kultivieren" | prefixV "an" (regV "bauen")) ; -- status=guess, src=wikt status=guess, src=wikt
lin awake_V = prefixV "auf" (regV "wecken") ; -- status=guess, src=wikt
lin trained_A = variants{} ; -- 
lin civic_A = mkA "bürgerlich" ; -- status=guess
lin voyage_N = mkN "Reise" "Reisen" feminine ; -- status=guess
lin siege_N = mkN "Belagerung" ; -- status=guess
lin enormously_Adv = variants{} ; -- 
lin distract_V2 = mkV2 (prefixV "ab" (regV "lenken")) ; -- status=guess, src=wikt
lin distract_V = prefixV "ab" (regV "lenken") ; -- status=guess, src=wikt
lin stroll_V = regV "spazieren" | regV "bummeln" ; -- status=guess, src=wikt status=guess, src=wikt
lin jewel_N = mkN "Juwel" "Juwel" masculine | mkN "Kleinod" neuter ; -- status=guess status=guess
lin honourable_A = variants{} ; -- 
lin helpless_A = mkA "hilflos" ; -- status=guess
lin hay_N = mkN "Heu" neuter ; -- status=guess
lin expel_V2 = mkV2 (prefixV "ab" (irregV "schieben" "schiebt" "schob" "schöbe" "geschoben") | irregV "deportieren" "deportiert" "deportierte" "deportierte" "deportiert" | irregV "verbannen" "verbannt" "verbannte" "verbannte" "verbannt") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin eternal_A = mk3A "ewig" "ewiger" "ewigste" ; -- status=guess
lin demonstrator_N = mkN "Demonstrant" "Demonstranten" masculine | mkN "Demonstrantin" feminine ; -- status=guess status=guess
lin correction_N = mkN "Korrektur" "Korrekturen" feminine | mkN "Berichtigung" | mkN "Verbesserung" ; -- status=guess status=guess status=guess
lin civilization_N = mkN "zivilisiert adj." ; -- status=guess
lin ample_A = mkA "üppig" ; -- status=guess
lin retention_N = mkN "Behalten" neuter ; -- status=guess
lin rehabilitation_N = mkN "Rehabilitation" ; -- status=guess
lin premature_A = variants{} ; -- 
lin encompass_V2 = mkV2 (regV "umfassen") ; -- status=guess, src=wikt
lin distinctly_Adv = mkAdv "deutlich" ; -- status=guess
lin diplomat_N = mkN "Diplomat" "Diplomaten" masculine ; -- status=guess
lin articulate_V2 = mkV2 (regV "betonen") ; -- status=guess, src=wikt
lin articulate_V = regV "betonen" ; -- status=guess, src=wikt
lin restricted_A = regA "begrenzt" ; -- status=guess
lin prop_V2 = variants{} ; -- 
lin intensify_V2 = variants{} ; -- 
lin intensify_V = variants{} ; -- 
lin deviation_N = mkN "Abweichung" ; -- status=guess
lin contest_V2 = variants{} ; -- 
lin contest_V = variants{} ; -- 
lin workplace_N = mkN "Arbeitsplatz" "Arbeitsplätze" masculine ; -- status=guess
lin lazy_A = mk3A "faul" "fauler" "faulste" ; -- status=guess
lin kidney_N = mkN "Niere" "Nieren" feminine ; -- status=guess
lin insistence_N = variants{} ; -- 
lin whisper_N = mkN "Geflüster" neuter | mkN "Flüstern" neuter | mkN "Wispern" neuter ; -- status=guess status=guess status=guess
lin multimedia_N = mkN "Multimedia Card" "Multimedia Cards" feminine ; -- status=guess
lin forestry_N = mkN "Forstwirtschaft" feminine ; -- status=guess
lin excited_A = mk3A "aufgeregt" "aufgeregter" "aufgeregteste" ; -- status=guess
lin decay_N = mkN "Verfall" masculine | mkN "Verwesung" feminine ; -- status=guess status=guess
lin screw_N = mkN "Schraubverschluss" masculine | mkN "Schraubdeckel" masculine ; -- status=guess status=guess
lin rally_V2V = variants{} ; -- 
lin rally_V2 = variants{} ; -- 
lin rally_V = variants{} ; -- 
lin pest_N = variants{} ; -- 
lin invaluable_A = variants{} ; -- 
lin homework_N = mkN "Hausaufgabe" ; ---- n {p}" ; -- status=guess
lin harmful_A = mkA "schädlich" ; -- status=guess
lin bump_V2 = variants{} ; -- 
lin bump_V = variants{} ; -- 
lin bodily_A = variants{} ; -- 
lin grasp_N = mkN "Griff" "Griffe" masculine ; -- status=guess
lin finished_A = variants{} ; -- 
lin facade_N = mkN "Fassade" "Fassaden" feminine ; -- status=guess
lin cushion_N = puffer_N | mkN "Polster" neuter ; -- status=guess status=guess
lin conversely_Adv = variants{} ; -- 
lin urge_N = mkN "Drang" "Drange" masculine; -- status=guess
lin tune_V2 = mkV2 (irregV "stimmen" "stimmt" "stimmte" "stimmte" "stimmt") ; -- status=guess, src=wikt
lin tune_V = irregV "stimmen" "stimmt" "stimmte" "stimmte" "stimmt" ; -- status=guess, src=wikt
lin solvent_N = mkN "Lösemittel" | mkN "Lösungsmittel" neuter ; -- status=guess status=guess
lin slogan_N = mkN "Slogan" "Slogans" masculine | mkN "Motto" neuter | mkN "Spruch" "Sprüche" masculine | mkN "Losung" ; -- status=guess status=guess status=guess status=guess
lin petty_A = mk3A "klein" "kleiner" "kleinste" | mk3A "gering" "geringer" "geringste" | mk3A "unbedeutend" "unbedeutender" "unbedeutenste" ; -- status=guess status=guess status=guess
lin perceived_A = variants{} ; -- 
lin install_V2 = mkV2 (irregV "installieren" "installiert" "installierte" "installierte" "installiert") ; -- status=guess, src=wikt
lin install_V = irregV "installieren" "installiert" "installierte" "installierte" "installiert" ; -- status=guess, src=wikt
lin fuss_N = mkN "Lärm" masculine | mkN "Wirbel" "Wirbel" masculine | mkN "Aufstand" "Aufstände" masculine ; -- status=guess status=guess status=guess
lin rack_N = mkN "Regal" neuter ; -- status=guess
lin imminent_A = mkA "bevorstehend" ; -- status=guess
lin short_N = mkN "Kurzschluss" "Kurzschlüsse" masculine ; -- status=guess
lin revert_V = variants{} ; -- 
lin ram_N = mkN "Schmetterlingsbuntbarsch" masculine ; -- status=guess
lin contraction_N = mkN "Verkleinerung" | mkN "Kontraktion" ; -- status=guess status=guess
lin tread_V2 = mkV2 (irregV "betreten" "betritt" "betrat" "beträte" "betreten" | irregV "treten" "tritt" "trat" "träte" "getreten") ; -- status=guess, src=wikt status=guess, src=wikt
lin tread_V = irregV "betreten" "betritt" "betrat" "beträte" "betreten" | irregV "treten" "tritt" "trat" "träte" "getreten" ; -- status=guess, src=wikt status=guess, src=wikt
lin supplementary_A = mkA "zusätzlich" ; -- status=guess
lin ham_N = mkN "Schinken" "Schinken" masculine ; -- status=guess
lin defy_V2V = mkV2V (mkV "herausfordern") ; -- status=guess, src=wikt
lin defy_V2 = mkV2 (mkV "herausfordern") ; -- status=guess, src=wikt
lin athlete_N = mkN "Athlet" ; -- status=guess
lin sociological_A = mkA "soziologisch" ; -- status=guess
lin physician_N = mkN "Arzt" "Ärzte" masculine | mkN "Ärztin" feminine ; -- status=guess status=guess
lin crossing_N = mkN "Kreuzung" ; -- status=guess
lin bail_N = mkN "Kaution" ; -- status=guess
lin unwanted_A = mkA "unerwünscht" | mkA "ungewollt" ; -- status=guess status=guess
lin tight_Adv = variants{} ; -- 
lin plausible_A = variants{} ; -- 
lin midfield_N = variants{} ; -- 
lin alert_A = mk3A "aufmerksam" "aufmerksamer" "aufmerksamste" | mk3A "wachsam" "wachsamer" "wachsamste" ; -- status=guess status=guess
lin feminine_A = mk3A "feminin" "femininer" "femininste" | mk3A "weiblich" "weiblicher" "weiblichste" ; -- status=guess status=guess
lin drainage_N = mkN "Drainage" feminine ; -- status=guess
lin cruelty_N = mkN "Grausamkeit" "Grausamkeiten" feminine | mkN "Quälerei" feminine ; -- status=guess status=guess
lin abnormal_A = mkA "unnormal" | mkA "ungewöhnlich" ; -- status=guess status=guess
lin relate_N = variants{} ; -- 
lin poison_V2 = mkV2 (irregV "vergiften" "vergiftet" "vergiftete" "vergiftete" "vergiftet") ; -- status=guess, src=wikt
lin symmetry_N = mkN "Symmetrie" "Symmetrien" feminine ; -- status=guess
lin stake_V2 = mkV2 (mkV "anpflocken" | prefixV "an" (regV "binden") | mkV "hochbinden" | mkV "pfählen") ; -- status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt status=guess, src=wikt
lin rotten_A = L.rotten_A ;
lin prone_A = mkA "schräg" ; -- status=guess
lin marsh_N = mkN "Moor" "Moore" neuter | mkN "Sumpf" "Sümpfe" masculine | mkN "Marsch" "Marschen" feminine ; -- status=guess status=guess status=guess
lin litigation_N = mkN "Rechtsstreit" "Rechtsstreite" masculine ; -- status=guess
lin curl_N = mkN "Locke" "Locken" feminine ; -- status=guess
lin urine_N = mkN "Urin" "Urine" masculine | mkN "Harn" "Harne" masculine ; -- status=guess status=guess
lin latin_A = variants{} ; -- 
lin hover_V = regV "schweben" ; -- status=guess, src=wikt
lin greeting_N = mkN "Gruß" masculine | mkN "Begrüßung" feminine ; -- status=guess status=guess
lin chase_N = mkN "Verfolgung" | mkN "Jagd" "Jagden" feminine ; -- status=guess status=guess
lin spouseMasc_N = reg2N "Ehepartner" "Ehepartner" masculine | mkN "Gatte" "Gatten" masculine; -- status=guess status=guess
lin produce_N = mkN "Obst und Gemüse" ; -- status=guess
lin forge_V2 = mkV2 (mkV "fälschen") ; -- status=guess, src=wikt
lin forge_V = mkV "fälschen" ; -- status=guess, src=wikt
lin salon_N = mkN "Salon" "Salons" masculine ; -- status=guess
lin handicapped_A = mk3A "behindert" "behinderter" "behindertste" ; -- status=guess
lin sway_V2 = mkV2 (regV "beeinflussen") ; -- status=guess, src=wikt
lin sway_V = regV "beeinflussen" ; -- status=guess, src=wikt
lin homosexual_A = regA "homosexuell" ; -- status=guess
lin handicap_V2 = variants{} ; -- 
lin colon_N = mkN "Kolon" neuter | mkN "Grimmdarm" "Grimmdärme" masculine ; -- status=guess status=guess
lin upstairs_N = variants{} ; -- 
lin stimulation_N = mkN "Stimulation" | mkN "Anregung" ; -- status=guess status=guess
lin spray_V2 = mkV2 (mkV "versprühen") | mkV2 (mkV "zerstäuben") ; -- status=guess, src=wikt status=guess, src=wikt
lin original_N = mkN "Original" "Originale" neuter | mkN "Urschrift" feminine ; -- status=guess status=guess
lin lay_A = mkA "Laien-" | regA "laikal" ; -- status=guess status=guess
lin garlic_N = mkN "Knoblauch" masculine ; -- status=guess
lin suitcase_N = mkN "Koffer" "Koffer" masculine ; -- status=guess
lin skipper_N = mkN "Kapitän" masculine | mkN "Teamkapitän" | mkN "Teamchef" masculine ; -- status=guess status=guess status=guess
lin moan_VS = mkVS (mkV "stöhnen") ; -- status=guess, src=wikt
lin moan_V = mkV "stöhnen" ; -- status=guess, src=wikt
lin manpower_N = variants{} ; -- 
lin manifest_V2 = mkV2 (irregV "manifestieren" "manifestiert" "manifestierte" "manifestierte" "manifestiert") ; -- status=guess, src=wikt
lin incredibly_Adv = variants{} ; -- 
lin historically_Adv = variants{} ; -- 
lin decision_making_N = variants{} ; -- 
lin wildly_Adv = variants{} ; -- 
lin reformer_N = mkN "Reformer" "Reformer" masculine ; -- status=guess
lin quantum_N = mkN "Quantencomputer" masculine ; -- status=guess
lin considering_Subj = variants{} ; -- 
}
