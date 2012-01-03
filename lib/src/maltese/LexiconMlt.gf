-- LexiconMlt.gf: test lexicon of 300 content words
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2011
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

concrete LexiconMlt of Lexicon = CatMlt **
	--open ParadigmsMlt, ResMlt, Prelude in {
	open ParadigmsMlt, IrregMlt, ResMlt in {

	flags optimize=values ; coding=utf8 ;

	lin

		{- ===== My Verbs ===== -}

		{-
		cut_V2 = mkVerb "qata'" "aqta'" "aqtgħu" ;
		write_V2 = mkVerb "kiteb" ;
		break_V2 = mkVerb "kiser" ;
		find_V2 = mkVerb "sab" ;
		throw_V2 = mkVerb "tefa'" ;
		hear_V2 = mkVerb "sama'" "isma'" "isimgħu" ;
		fear_V2 = mkVerb "beża'" ;
		pray_V = mkVerb "talab" "itlob" "itolbu" ;
		understand_V2 = mkVerb "fehem" ;
		pull_V2 = mkVerb "ġibed" ;
		walk_V = mkVerb "mexa'" ;
		-}
		-- die_V = mkVerb "miet" ;
		die_V = mkVerb "qarmeċ" ;


		{- ===== My Nouns ===== -}

		--airplane_N = mkNoun "ajruplan" Masc ;
		airplane_N = mkNoun "ajruplan" ;
		--apple_N = mkNoun "tuffieħa" Fem ;
		apple_N = mkNounColl "tuffieħ" ;

		bench_N = mkNoun "bank" "bankijiet" ;



		{- ===== Required by RGL ===== -}


--		add_V3
--		alas_Interj
--		already_Adv
		animal_N = mkNoun "annimal" ;
--		answer_V2S
		apartment_N = mkNoun "appartament" ;
		art_N = mkNounNoPlural "arti" Fem ;
--		ashes_N = mkNoun "rmied" ;
--		ask_V2Q
		baby_N = mkNoun "tarbija" "trabi" ;
		back_N = mkNoun "dahar" "dhur" ;
--		bad_A
		bank_N = mkNoun "bank" "bankijiet" ; -- BANEK is for lotto booths!
		bark_N = mkNoun "qoxra" "qoxriet" ;
--		beautiful_A
--		become_VA
		beer_N = mkNoun "birra" "birer" ;
--		beg_V2V
		belly_N = mkNoun "żaqq" "żquq" ;
--		big_A
		bike_N = mkNoun "rota" ;
		bird_N = mkNoun "għasfur" "għasafar" ; -- what about GĦASFURA?
--		bite_V2
--		black_A
		blood_N = mkNoun [] "demm" [] "dmija" [] ;
--		blow_V
--		blue_A
		boat_N = mkNoun "dgħajsa" "dgħajjes" ;
		bone_N = mkNounColl "għadam" ;
		book_N = mkNoun "ktieb" "kotba" ;
		boot_N = mkNoun "żarbun" "żraben" ; -- what about ŻARBUNA?
		boss_N = mkNoun "mgħallem" "mgħallmin" ;
		boy_N = mkNoun "tifel" "tfal" ;
		bread_N = mkNounColl "ħobż" ;
--		break_V2
		breast_N = mkNoun "sider" "sdur" ; -- also ISDRA
--		breathe_V
--		broad_A
		brother_N2 = mkNoun "ħu" "aħwa" ;
--		brown_A
--		burn_V
		butter_N = mkNoun [] "butir" [] "butirijiet" [] ;
--		buy_V2
		camera_N = mkNoun "kamera" "kameras" ;
		cap_N = mkNoun "beritta" ;
		car_N = mkNoun "karozza" ;
		carpet_N = mkNoun "tapit" ; -- TAPITI or TWAPET ?
		cat_N = mkNoun "qattus" "qtates" ; -- what about QATTUSA ?
		ceiling_N = mkNoun "saqaf" "soqfa";
		chair_N = mkNoun "siġġu" "siġġijiet" ;
		cheese_N = mkNounColl "ġobon" ;
--		child_N = mkNoun "tfajjel" ; -- Not an easy one...
		church_N = mkNoun "knisja" "knejjes" ;
		city_N = mkNoun "belt" "bliet" Fem ;
--		clean_A
--		clever_A
--		close_V2
		cloud_N = mkNounColl "sħab" ;
		coat_N = mkNoun "kowt" "kowtijiet" ;
--		cold_A
--		come_V
		computer_N = mkNoun "kompjuter" "kompjuters" ;
--		correct_A
--		count_V2
		country_N = mkNoun "pajjiż" ;
		cousin_N = mkNoun "kuġin" ;
		cow_N = mkNoun "baqra" "baqar" "baqartejn" [] [] ;
--		cut_V2
		day_N = mkNoun "ġurnata" "ġranet" ;
--		dig_V
--		dirty_A
		distance_N3 = mkNoun "distanza" ;
--		do_V2
		doctor_N = mkNoun "tabib" "tobba" ; -- what about TABIBA ?
		dog_N = mkNoun "kelb" "klieb" ;
		door_N = mkNoun "bieb" "bibien" ; -- what about BIEBA ?
--		drink_V2
--		dry_A
--		dull_A
		dust_N = mkNounColl "trab" ; -- not sure but sounds right
		ear_N = mkNounDual "widna" ;
		earth_N = mkNoun "art" "artijiet" Fem ;
--		easy_A2V
--		eat_V2
		egg_N = mkNounColl "bajd" ;
--		empty_A
		enemy_N = mkNoun "għadu" "għedewwa" ;
		eye_N = mkNounWorst "għajn" [] "għajnejn" "għajnejn" "għejun" Fem ;
		factory_N = mkNoun "fabbrika" ;
--		fall_V
--		far_Adv
		fat_N = mkNounColl "xaħam" ;
		father_N2 = mkNoun "missier" "missierijiet" ;
--		fear_V2
--		fear_VS
		feather_N = mkNounColl "rix" ;
--		fight_V2
--		find_V2
		fingernail_N = mkNoun "difer" [] "difrejn" "dwiefer" [] ;
		fire_N = mkNoun "nar" "nirien" ;
		fish_N = mkNounColl "ħut" ;
--		float_V
		earth_N = mkNoun "art" "artijiet" Fem ;
--		flow_V
		flower_N = mkNoun "fjura" ;
--		fly_V
		fog_N = mkNoun [] "ċpar" [] [] [] ;
		foot_N = mkNounWorst "sieq" [] "saqajn" "saqajn" [] Fem ;
		forest_N = mkNoun "foresta" ; -- also MASĠAR
--		forget_V2
--		freeze_V
		fridge_N = mkNoun "friġġ" "friġġijiet" ;
		friend_N = mkNoun "ħabib" "ħbieb" ;
		fruit_N = mkNounColl "frott" ;
--		full_A
--		fun_AV
		garden_N = mkNoun "ġnien" "ġonna" ;
		girl_N = mkNoun "tifla" "tfal" ;
--		give_V3
		glove_N = mkNoun "ingwanta" ;
--		go_V
		gold_N = mkNoun [] "deheb" [] "dehbijiet" [] ;
--		good_A
		grammar_N = mkNoun "grammatika" ;
		grass_N = mkNounWorst "ħaxixa" "ħaxix" [] [] "ħxejjex" Masc ; -- Dict says ĦAXIX = n.koll.m.s., f. -a, pl.ind. ĦXEJJEX
--		green_A
		guts_N = mkNoun "musrana" [] [] "musraniet" "msaren" ;
		hair_N = mkNoun "xagħar" [] [] "xagħariet" "xgħur" ;
		hand_N = mkNounWorst "id" [] "idejn" "idejn" [] Fem ;
		harbour_N = mkNoun "port" "portijiet" ;
		hat_N = mkNoun "kappell" "kpiepel" ;
--		hate_V2
		head_N = mkNoun "ras" "rjus" Fem ;
--		hear_V2
		heart_N = mkNoun "qalb" "qlub" Fem ;
--		heavy_A
		hill_N = mkNoun "għolja" "għoljiet" ;
--		hit_V2
--		hold_V2
--		hope_VS
		horn_N = mkNoun "ħorn" "ħornijiet" ;
		horse_N = mkNoun "żiemel" "żwiemel" ;
--		hot_A
		house_N = mkNoun "dar" "djar" Fem ;
--		hunt_V2
		husband_N = mkNoun "raġel" "rġiel" ;
		ice_N = mkNoun "silġ" "silġiet" ;
--		important_A
		industry_N = mkNoun "industrija" ;
		iron_N = mkNounWorst "ħadida" "ħadid" [] "ħadidiet" "ħdejjed" Masc ;
--		john_PN
--		jump_V
--		kill_V2
		king_N = mkNoun "re" "rejjiet" ;
		knee_N = mkNoun "rkoppa" [] "rkopptejn" "rkoppiet" [] ; -- TODO use mkNounDual
--		know_V2
--		know_VQ
--		know_VS
		lake_N = mkNoun "għadira" "għadajjar" ;
		lamp_N = mkNoun "lampa" ;
		language_N = mkNoun "lingwa" ; -- lsien?
--		laugh_V
		leaf_N = mkNoun "werqa" "weraq" "werqtejn" "werqiet" [] ;
--		learn_V2
		leather_N = mkNoun "ġilda" "ġild" [] "ġildiet" "ġlud" ; -- mkNounColl "ġild" ;
--		leave_V2
--		left_Ord
		leg_N = mkNoun "riġel" [] "riġlejn" [] [] ; -- sieq?
--		lie_V
--		like_V2
--		listen_V2
--		live_V
		liver_N = mkNoun "fwied" [] [] [] "ifdwa" ;
--		long_A
--		lose_V2
		louse_N = mkNoun "qamla" "qamliet" ;
		love_N = mkNoun "mħabba" "mħabbiet" ; -- hmmm
--		love_V2
		man_N = mkNoun "raġel" "rġiel" ;
--		married_A2
		meat_N = mkNoun "laħam" [] [] "laħmiet" "laħmijiet" ;
		milk_N = mkNoun [] "ħalib" [] "ħalibijiet" "ħlejjeb" ;
		moon_N = mkNoun "qamar" "oqmra" ; -- qmura?
		mother_N2 = mkNoun "omm" "ommijiet" Fem ;
		mountain_N = mkNoun "muntanja" ;
		mouth_N = mkNoun "ħalq" "ħluq" ;
		music_N = mkNoun "musika" ; -- plural?
		name_N = mkNoun "isem" "ismijiet" ;
--		narrow_A
--		near_A
		neck_N = mkNoun "għonq" "għenuq" ;
--		new_A
		newspaper_N = mkNoun "gazzetta" ;
		night_N = mkNoun "lejl" "ljieli" ;
		nose_N = mkNoun "mnieħer" "mniħrijiet" ;
--		now_Adv
		number_N = mkNoun "numru" ;
		oil_N = mkNoun "żejt" "żjut" ;
--		old_A
--		open_V2
--		paint_V2A
		paper_N = mkNoun "karta" ;
--		paris_PN
		peace_N = mkNoun "paċi" "paċijiet" Fem ;
		pen_N = mkNoun "pinna" "pinen" ;
		person_N = mkNounWorst [] "persuna" [] "persuni" [] Masc ;
		planet_N = mkNoun "pjaneta" ;
		plastic_N = mkNounNoPlural "plastik" ;
--		play_V
--		play_V2
		policeman_N = mkNounNoPlural "pulizija" ;
		priest_N = mkNoun "qassis" "qassisin" ;
--		probable_AS
--		pull_V2
--		push_V2
--		put_V2
		queen_N = mkNoun "reġina" "rġejjen" ;
		question_N = mkNoun "mistoqsija" "mistoqsijiet" ; -- domanda?
		radio_N = mkNoun "radju" "radjijiet" ;
		rain_N = mkNounNoPlural "xita" ;
--		rain_V0
--		read_V2
--		ready_A
		reason_N = mkNoun "raġun" "raġunijiet" ;
--		red_A
		religion_N = mkNoun "reliġjon" "reliġjonijiet" ;
		restaurant_N = mkNoun "restorant" ;
--		right_Ord
		river_N = mkNoun "xmara" "xmajjar" ;
		road_N = mkNounWorst "triq" [] [] "triqat" "toroq" Fem ;
		rock_N = mkNoun "blata" "blat" [] "blatiet" "blajjiet" ; -- in dictionary BLAT and BLATA are separate!
		roof_N = mkNoun "saqaf" "soqfa" ;
		root_N = mkNoun "qħerq" "qħeruq" ;
		rope_N = mkNoun "ħabel" "ħbula" ;
--		rotten_A
--		round_A
--		rub_V2
		rubber_N = mkNoun "gomma" "gomom" ;
		rule_N = mkNoun "regola" ;
--		run_V
		salt_N = mkNoun "melħ" "melħiet" ;
		sand_N = mkNoun "ramla" "ramel" [] "ramliet" "rmiel" ;
--		say_VS
		school_N = mkNoun "skola" "skejjel" ;
		science_N = mkNoun "xjenza" ;
--		scratch_V2
		sea_N = mkNoun "baħar" [] "baħrejn" "ibħra" [] ;
--		see_V2
		seed_N = mkNoun "żerriegħa" "żerrigħat" ;
--		seek_V2
--		sell_V3
--		send_V3
--		sew_V
--		sharp_A
		sheep_N = mkNoun "nagħġa" "nagħaġ" [] "nagħġiet" [] ;
		ship_N = mkNoun "vapur" ;
		shirt_N = mkNoun "qmis" "qomos" Fem ;
		shoe_N = mkNoun "żarbun" "żraben" ;
		shop_N = mkNoun "ħanut" "ħwienet" ;
--		short_A
		silver_N = mkNoun "fidda" "fided" ;
--		sing_V
		sister_N = mkNoun "oħt" "aħwa" Fem ;
--		sit_V
		skin_N = mkNoun "ġilda" "ġildiet" ;
		sky_N = mkNoun "sema" "smewwiet" Masc ;
--		sleep_V
--		small_A
--		smell_V
		smoke_N = mkNoun "duħħan" "dħaħen" ;
--		smooth_A
		snake_N = mkNoun "serp" "sriep" ;
		snow_N = mkNoun [] "borra" [] [] [] ;
		sock_N = mkNoun "kalzetta" ;
		song_N = mkNoun "kanzunetta" ;
--		speak_V2
--		spit_V
--		split_V2
--		squeeze_V2
--		stab_V2
--		stand_V
		star_N = mkNoun "stilla" "stilel" ;
		steel_N = mkNounNoPlural "azzar" ;
		stick_N = mkNoun "lasta" ;
		stone_N = mkNoun "ġebla" "ġebel" [] "ġebliet" "ġbiel" ;
--		stop_V
		stove_N = mkNoun "kuker" "kukers" ; -- fuklar?
--		straight_A
		student_N = mkNoun "student" ;
--		stupid_A
--		suck_V2
		sun_N = mkNoun "xemx" "xmux" Fem ;
--		swell_V
--		swim_V
--		switch8off_V2
--		switch8on_V2
		table_N = mkNoun "mejda" "mwejjed" ;
		tail_N = mkNoun "denb" "dnieb" ;
--		talk_V3
--		teach_V2
		teacher_N = mkNoun "għalliem" "għalliema" ; -- għalliema ?
		television_N = mkNoun "televixin" "televixins" ;
--		thick_A
--		thin_A
--		think_V
--		throw_V2
--		tie_V2
--		today_Adv
		tongue_N = mkNoun "lsien" "ilsna" ;
		tooth_N = mkNoun "sinna" [] [] "sinniet" "snien" ; -- darsa?
		train_N = mkNoun "ferrovija" ;
--		travel_V
		tree_N = mkNoun "siġra" "siġar" [] "siġriet" [] ;
--		turn_V
--		ugly_A
--		uncertain_A
--		understand_V2
		university_N = mkNoun "università" "universitàjiet" ;
		village_N = mkNoun "raħal" "rħula" ; -- villaġġ ?
--		vomit_V
--		wait_V2
--		walk_V
		war_N = mkNoun "gwerra" "gwerrer" ;
--		warm_A
--		wash_V2
--		watch_V2
		water_N = mkNoun "ilma" "ilmijiet" Masc ;
--		wet_A
--		white_A
--		wide_A
		wife_N = mkNoun "mara" "nisa" ;
--		win_V2
		wind_N = mkNoun "riħ" [] [] "rjieħ" "rjiħat" ;
		window_N = mkNoun "tieqa" "twieqi" ;
		wine_N = mkNoun [] "nbid" [] [] "nbejjed" ;
		wing_N = mkNoun "ġewnaħ" "ġwienaħ" ;
--		wipe_V2
		woman_N = mkNoun "mara" "nisa" ;
--		wonder_VQ
		wood_N = mkNoun "injam" "injamiet" ;
		worm_N = mkNoun "dudu" "dud" [] "dudiet" "dwied" ; -- duda
--		write_V2
		year_N = mkNoun "sena" [] "sentejn" "snin" [] ;
--		yellow_A
--		young_A

} ;
