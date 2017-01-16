concrete StructuralIce of Structural = CatIce ** 
	open MorphoIce, ResIce, ParadigmsIce, MakeStructuralIce, IrregIce,
	(C = ConstructX), Prelude in {

	lin
		possess_Prep = mkPrep "af" dative ;
		always_AdV = mkAdV "alltaf" ;
		above_Prep = mkPrep "ofan" genitive ;
		after_Prep = mkPrep "eftir" dative ;
		almost_AdA = mkAdA "næstum" ;
		before_Prep = mkPrep "fyrir" dative ;
		behind_Prep = mkPrep "fyrir aftan" dative ;
		between_Prep = mkPrep "á milli" genitive ;
		almost_AdN = mkAdN (lin CAdv ({s = "næstum" ; p = "því" })) ;
		although_Subj = ss "þó" ;
		by8agent_Prep = mkPrep "hjá" dative ;
		by8means_Prep = mkPrep "hjá" dative ;
		during_Prep = mkPrep "á meðan" nominative ;
		every_Det = {
			s = table {
				Masc	=> caseList "sérhver" "sérhvern" "sérhverjum" "sérhvers" ;
				Fem	=> caseList "sérhver" "sérhverja" "sérhverri" "sérhverrar" ;
				Neutr	=> caseList "sérhvert" "sérhvert" "sérhverju" "sérhvers"
			} ;
			pron = \\_,_ => [] ;
			n = Sg ;
			b = Free ;
			d = Strong
		} ;
		everywhere_Adv = mkAdv "alls staðar" ;
		few_Det = {
			s = table {
				Masc	=> caseList "fáeinir" "fáeina" "fáeinum" "fáeinna" ;
				Fem	=> caseList "fáeinar" "fáeinar" "fáeinum" "fáeinna" ;
				Neutr	=> caseList "fáein" "fáein" "fáeinum" "fáeinna"
			} ;
			pron = \\_,_ => [] ;
			n = Pl ;
			b = Free ;
			d = Strong
		} ;
		for_Prep = mkPrep "fyrir" dative ;
		from_Prep = mkPrep "frá" dative ;
		here_Adv = mkAdv "hérna" ;
		here7to_Adv = mkAdv ["hingað"] ;
		here7from_Adv = mkAdv ["héðan"] ;
		in8front_Prep = mkPrep ["fyrir framan"] accusative ;
		in_Prep = mkPrep "í" dative ;
		no_Utt = ss "nei" ;
		part_Prep = mkPrep "af" dative ;
		quite_Adv = mkAdv "alveg" ;
		someSg_Det = {
			s = table {
				Masc	=> caseList "nokkur" "nokkurn" "nokkrum" "nokkurs" ;
				Fem	=> caseList "nokkur" "nokkra" "nokkurri" "nokkurrar" ;
				Neutr	=> caseList "nokkurt" "nokkurt" "nokkru" "nokkurs"
			} ;
			pron = \\_,_ => [] ;
			n = Sg ;
			b = Free ;
			d = Strong
		} ;
		somePl_Det = {
			s = table {
				Masc	=> caseList "nokkrir" "nokkra" "nokkrum" "nokkurra" ;
				Fem	=> caseList "nokkrar" "nokkrar" "nokkrum" "nokkurra" ;
				Neutr	=> caseList "nokkur" "nokkur" "nokkrum" "nokkurra"
			} ;
			pron = \\_,_ => [] ;
			n = Pl ;
			b = Free ;
			d = Strong
		} ;
		through_Prep = mkPrep "gegnum" accusative ;
		too_AdA = mkAdA "líka" ;
		to_Prep = mkPrep "til" genitive ;
		very_AdA = mkAdA "mjög" ;
		without_Prep = mkPrep "án" genitive ;
		yes_Utt = ss "já" ;
		at_least_AdN = mkAdN (lin CAdv ({s = "að minnsta" ; p = "kosti"})) ;
		at_most_AdN = mkAdN (lin CAdv ({s = "í mesta" ; p = "lagi"})) ;
		except_Prep = mkPrep "nema" nominative;

		so_AdA = mkAdA "svo" ;
		somewhere_Adv = mkAdv "einhvers staðar" ;
		there_Adv = mkAdv "þarna" ;
		therefore_PConj = ss "þar af leiðandi" ;

		-- To my knowledge there is no special difference when reffering to a specific known object (or person) 
		-- that is far away or close (emotionally or physically) in Icelandic - without specifiying the distance further, 
		-- e.g., with an adverb "þessi hlutur hérna" = "this object here" and "þessi hlutur þarna" = "that object there".
		-- But one could argue that "þessi/sá" =~ "this/that". There is also another demonstrative determiner in 
		-- Icelandic, "hinn" = "the other one". Atm I use the "þessi/sá" = "this/that". 
		-- Later I will change to "þessi hér" == "this" and "þessi þarna" == "that". But that raises further questions on how
		-- it should then treat some situations e.g. "..þessi guli maður..."/"..this yellow man.." 
		-- to "..þessi hérna guli maður.." ?
		-- or "..þessi guli maður hérna.." ?
		-- I think/feel that "..þessi guli maður.." is the most natural/right one to use.
		this_Quant = {
			s = table {
				Sg	=> table {
						Masc	=> caseList "þessi" "þennan" "þessum" "þessa" ;
						Fem	=> caseList "þessi" "þessa" "þessari" "þessarar" ;
						Neutr	=> caseList "þetta" "þetta" "þessu" "þessa"
				} ;
				Pl	=> table {
						Masc	=> caseList "þessir" "þessa" "þessum" "þessara" ;
						Fem	=> caseList "þessar" "þessar" "þessum" "þessara" ;
						Neutr	=> caseList "þessi" "þessi" "þessum" "þessara"
				}
			} ;
			b = Free ;
			d = Weak ;
			isPron = False
		} ;
		that_Quant =  {
			s = table {
				Sg	=> table {
						Masc	=> caseList "sá" "þann" "þeim" "þess" ;
						Fem	=> caseList "sú" "þá" "þeirri" "þeirrar" ;
						Neutr	=> caseList "það" "það" "því" "þess"
				} ;
				Pl	=> table {
						Masc	=> caseList "þeir" "þá" "þeim" "þeirra" ;
						Fem	=> caseList "þær" "þær" "þeim" "þeirra" ;
						Neutr	=> caseList "þau" "þau" "þeim" "þeirra"
				}
			} ;
			b = Free ;
			d = Weak ;
			isPron = False
		} ;
		and_Conj = mkConj "og" ;
		or_Conj = mkConj "eða" singular ;
		if_then_Conj = mkConj "ef" "þá" singular ;
		either7or_DConj = mkConj "annaðhvort" "eða" singular ;
		otherwise_PConj = ss "annars" ;
		that_Subj = ss "að" ;
		because_Subj = ss "af því að" ;
		both7and_DConj = mkConj "bæði" "og";
		but_PConj = ss "en" ;
		how_IAdv = ss "hvernig" ;
		how8much_IAdv = ss "hversu mikið" ;
		if_Subj = ss "ef" ;
		please_Voc = ss "vinsamlegast" ;
		when_Subj = ss "þegar" ;

		where_IAdv = ss "hvar" ;

		why_IAdv = ss "af hverju" ;
		yes_Phr = ss "já" ;
		i_Pron  = mkPronPers "ég" "mig" "mér" "mín" "minn" "minn" "mínum" "míns" "mín" "mína" "minni" "minnar" "mitt" "mitt" "mínu" "míns" "mínir" "mína" "mínum" "minna" "mínar" "mínar" "mín" "mín" Masc Sg P1 ;
		youSg_Pron = mkPronPers "þú" "þig" "þér" "þín" "þinn" "þinn" "þínum" "þíns" "þín" "þína" "þinni" "þinnar" "þitt" "þitt" "þínu" "þíns" "þínir" "þína" "þínum" "þinna" "þínar" "þínar" "þín" "þín" Masc Sg P2 ;
		-- He, she and it are complicated regarding possessions. Sinn is 
		-- used for thrid persons singular, but only if it is the subject 
		-- of the sentence, otherwise the genitive of the personal pronoun 
		-- (hans) is used.
		-- dont be afraid to be awkward :)

		he_Pron = mkPronPers "hann" "hann" "honum" "hans"
				"sinn" "sinn" "sínum" "síns"
				"sín" "sína" "sinni" "sinnar"
				"sitt" "sitt" "sínu" "síns"
				"sínir" "sína" "sínum" "sinna"
				"sínar" "sínar" "sín" "sín" Masc Sg P3 ;

		she_Pron = mkPronPers "hún" "hana" "henni" "hennar" 
				"sinn" "sinn" "sínum" "síns"
				"sín" "sína" "sinni" "sinnar"
				"sitt" "sitt" "sínu" "síns"
				"sínir" "sína" "sínum" "sinna"
				"sínar" "sínar" "sín" "sín" Fem Sg P3 ;

		it_Pron = mkPronPers "það" "það" "því" "þess"
				"sinn" "sinn" "sínum" "síns"
				"sín" "sína" "sinni" "sinnar"
				"sitt" "sitt" "sínu" "síns"
				"sínir" "sína" "sínum" "sinna"
				"sínar" "sínar" "sín" "sín" Neutr Sg P3 ;

		-- "They" depends on gender,i.e. has 3x4 forms for personal pronouns
		-- the masculine is given here, neuter and feminine are given in Extra
		they_Pron = mkPronPers "þeir" "þá" "þeim" "þeirra"
				"sinn" "sinn" "sínum" "síns"
				"sín" "sína" "sinni" "sinnar"
				"sitt" "sitt" "sínu" "síns"
				"sínir" "sína" "sínum" "sinna"
				"sínar" "sínar" "sín" "sín" Masc Pl P3 ;

		-- the possesive equivalent, vor, is mostly used in elevated style.
		we_Pron = mkPronPers "við" "okkur" "okkur" "okkar" 
				"vor" "vor" "vorum" "vors"
				"vor" "vora" "vorri" "vorrar"
				"vort" "vort" "voru" "vors"
				"vorir" "vora" "vorum" "vorra"
				"vorar" "vorar" "vor" "vor" Neutr Pl P1 ;
		
		-- this is a bit awkward - there is really no possessive term for this
		-- the genative is always used...
		youPl_Pron = mkPronPers "þið" "ykkur" "ykkur" "ykkar"
				"ykkar" "ykkar" "ykkar" "ykkar"
				"ykkar" "ykkar" "ykkar" "ykkar"
				"ykkar" "ykkar" "ykkar" "ykkar"
				"ykkar" "ykkar" "ykkar" "ykkar"
				"ykkar" "ykkar" "ykkar" "ykkar" Neutr Pl P2 ;

		youPol_Pron = mkPronPers "þú" "þig" "þér" "þín" "þinn" "þinn" "þínum" "þíns" "þín" "þína" "þinni" "þinnar" "þitt" "þitt" "þínu" "þíns" "þínir" "þína" "þínum" "þinna" "þínar" "þínar" "þín" "þín" Masc Sg P2 ;

		-- Strictly speaking all these interrigative pronouns correspond to one interrigative pronoun
		-- in Icelandic, "hver". But "hver", like other pronouns, exists in 3 genders and two numbers
		-- hence, hver (masculine) corresponds to who (in a masculine context, also for feminie, but
		-- only in the nominative), and hvert/hvað corresponds to what.
		whatSg_IP = {
			s = \\_ => caseList "hvað" "hvað" "hverju" "hvers" ;
			n = Pl
		} ;

		whatPl_IP = {
			s = \\_ => caseList "hver" "hver" "hverjum" "hverra" ;
			n = Sg
		} ;
				
		--  whoPl_IP = mkIP "who" "whom" "whose" plural ;
		whoPl_IP = {
			s = table {
				Masc	=> caseList "hverjir" "hverja" "hverjum" "hverra" ;
				Fem	=> caseList "hverjar" "hverjar" "hverjum" "hverra" ;
				Neutr	=> caseList "hver" "hver" "hverjum" "hverra"
			} ;
			n = Pl
		} ;

		whoSg_IP = {
			s = table {
				Masc	=> caseList "hver" "hvern" "hverjum" "hvers" ;
				Fem	=> caseList "hver" "hverja" "hverri" "hverjar" ;
				Neutr	=> caseList "hvað" "hvað" "hverju" "hvers"
			} ;
			n = Sg
		} ;

		-- Note this is basically the superlative of the adjective margur (e. many)
		-- a paradigm or make function will be made for Predet's.
		most_Predet = {
			s = table {
				Sg	=> table {
					Masc	=> caseList "flestur" "flestan" "flestum" "flests" ;
					Fem	=> caseList "flest" "flesta" "flestri" "flestrar" ;
					Nautr	=> caseList "flest" "flest" "flestu" "flests"
				} ;
				Pl	=> table {
					Masc	=> caseList "flestir" "flesta" "flestum" "flestra" ;
					Fem	=> caseList "flestar" "flestar" "flestum" "flestra" ;
					Nautr	=> caseList "flest" "flest" "flestum" "flestra"
				}
			};
		};
		all_Predet = {
			s = table {
				Sg	=> table {
					Masc	=> caseList "allur" "allan" "öllum" "alls" ;
					Fem	=> caseList "öll" "alla" "allri" "allrar" ;
					Neutr	=> caseList "allt" "allt" "öllu" "alls"
				} ;
				Pl	=> table {
					Masc	=> caseList "allir" "alla" "öllum" "allra" ;
					Fem	=> caseList "allar" "allar" "öllum" "allra" ;
					Neutr	=> caseList "öll" "öll" "öllum" "allra"
				}
			} ;
		} ;
	
					
		-- not sure atm how this will translate : aðeins is an adverb that does not inflect and eini is a weak form of the adjective einn (e. one)
	 	only_Predet = { s = \\_,_,_ => "aðeins"} ;
		-- Same here : ekki is a sentence adverb that does not inflect
		not_Predet = { s = \\_,_,_ => "ekki"} ;

		less_CAdv = {s = "minna" ; p = "en"} ;
		more_CAdv = {s = "meira" ; p = "en"} ;
		as_CAdv = {s = "eins" ; p = "og"} ;
		on_Prep = mkPrep "á" dative ;
		with_Prep = mkPrep "með" dative ;
		-- when using in the context of two objects "hvor" is used.
		when_IAdv = ss "hvenær" ;
		which_IQuant = {s = \\_,_,_ => "hvaða"} ;
		under_Prep = mkPrep "undir" dative ;
		want_VV = mkV2 IrregIce.vilja_V (mkPrep "" accusative) ;
		must_VV = mkV2 IrregIce.verða_V (mkPrep "að" accusative) ;
		can_VV, can8know_VV = mkV2 IrregIce.kunna_V (mkPrep "að" accusative) ;
		have_V2 = mkV2 (mkV "hafa" "hef" "hafði" "hafður" "haft") (mkPrep "" accusative) ;
}
