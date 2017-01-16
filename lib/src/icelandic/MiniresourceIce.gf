concrete MiniresourceIce of Miniresource = open Prelude in {

	-- module GrammarIce

	lincat
		S = {s : Str};
		Tense = {s : Str ; t : TTense};
		Pol = {s : Str ; b : Bool};
		Cl = {s : TTense => Bool => Str};
		VP = VerbPhrase;
		V = Verb;
		V2 = Verb ** {c : Case};
		NP = NounPhrase;
		Det = {s : Gender => Case => Str ; n : Number ; b : Bool ; d : Declension};
		CN = CommonNoun;
		N = Noun;
		AP = Adj;
		A = Adj;
		AdA = {s : Str};
		Conj = {s : Str ; n : Number};
	lin 
		--Build a sentence from a tense, a polarity and a clause:
		--Tense -> Pol -> Cl -> S
		UseCl t p cl = {
			s = cl.s ! t.t ! p.b ++ t.s ++ p.s
		};

		--Build a new sentence by connecting two existing sentences with a conjunction:
		--Conj -> S  -> S  -> S
		ConjS co sx sy = { 
			s = sx.s ++ co.s ++ sy.s
		};

		--Two prefabricated tenses:
		Pres = {s = [] ; t = TPres};
		Perf = {s = [] ; t = TPerf};

		--Two prefabricated polarities:
		Pos = {s = [] ; b = True};
		Neg = {s = [] ; b = False};

		--Build a clause from a noun phrase (= the subject) and a verb phrase:
		--NP -> VP -> Cl
		PredVP np vp = {
			s = \\t,p => 
				let
					-- 1	The Nominative case is the 'unmarked' case for the subject
					-- 	in Icelandic - therefore it is hardcoded atm.
					subj = np.s ! Nom;
					verb = agrV vp.s np.a t p;
					obj = vp.obj ! np.a
				in case <t,p> of {
					-- In case of TPerf, the negation goes between the auxilary verb
					-- and the main verb - done in agrV.
					<TPres, False>	=> subj ++ verb ++ "ekki" ++ obj;
					_		=> subj ++ verb ++ obj
				};
		};
	
		--Build a verb phrase by elevating a verb:
		--V -> VP
		UseV v = {
			s = v;
			obj = \\_ => []
		};
			
	
		--Build a verb phrase from a two-place verb and a noun phrase (= the object):
		--V2 -> NP -> VP
		ComplV2 v2 np = {
			s = v2;
			obj = \\_ => np.s ! v2.c
		};
	
		--Build a verb phrase from an adjective phrase, using the verb 'að vera' ("stór" --> "er stór"):
		--AP -> VP
		CompAP ap = { 
			s = mkVerb "vera" "er" "ert" "er" "erum" "eruð" "eru" "var" "varst" "var" "vorum" "voruð" "voru" "verið";
			-- As far as I know, the verb "að vera" ("to be") always inflects the object into the Nominative case.
			-- And the Srong being the 'unmarked' declension is dominant here.
			obj = \\a => case a of {
				Ag g n _ => ap.s ! n ! g ! Nom ! Strong
			}
		};


		--Build a noun phrase from a determiner and a common noun:
		--Det -> CN -> NP
		DetCN det cn = {
			s = \\c => case det.b of {
				False => det.s ! cn.g ! c ++ cn.adj ! det.n ! c ! det.d ++ cn.noun ! det.n ! c ! det.b;
				True => cn.adj ! det.n ! c ! det.d ++ cn.noun ! det.n ! c ! det.b
			};
			a = Ag cn.g det.n Per3
		};

		--Build a new noun phrase by connecting two existing noun phrases with a conjunction:
		--Conj -> NP -> NP -> NP
		ConjNP co nx ny = { 
			s = \\c => nx.s ! c ++ co.s ++ ny.s ! c;
      			a = conjAgr co.n nx.a ny.a
		};

		--Build a common noun by elevating a noun:
		--N -> CN
		UseN n = {
			noun = n.s;
			adj = \\_,_,_ => [];
			g = n.g;
			isPre = True
		};
		
		--Build a new common noun by adding an adjective phrase to an existing common noun:
		--AP -> CN -> CN
		ModCN ap cn = { 
			noun = \\n,c,b => cn.noun ! n ! c ! b;
			adj = \\n,c,d => ap.s ! n ! cn.g ! c ! d;
			g = cn.g;
			isPre = ap.isPre
		};

		--Build an adjective phrase by elevating an adjective:
		--A -> AP
		UseA a = a;
		
		--Build a new adjective phrase by adding an ad-adjective to an existing adjective phrase:
		--AdA -> AP -> AP
		AdAP ad ap = { 
			s = \\n,g,d,c => ad.s ++ ap.s ! n ! g ! d ! c;
			isPre = ap.isPre
		};

		--A prefabricated ad-adjective:
		very_AdA = {s = "mjög"};

		--Some prefabricated noun phrases:
		-- not sure how to treat some of the pronouns gender vice - so I put Masc as the 'unmarked' gender 
		i_NP = pronNP "ég" "mig" "mér" "mín" Masc Sg Per1 ;
		youSg_NP = pronNP "þú" "þig" "þér" "þín" Masc Sg Per2 ;
		he_NP = pronNP "hann" "hann" "honum" "hans" Masc Sg Per3 ;
		she_NP = pronNP "hún" "hana" "henni" "hennar" Fem Sg Per3 ;
		-- the 3rd person neuter pronoun seems not to be included in the miniature resource
		--it_NP = pronNP "það" "það" "því" "þess" Neut Sg Per3 ;
		we_NP = pronNP "við" "okkur" "okkur" "okkar" Masc Pl Per1 ;
		youPl_NP = pronNP "þið" "ykkur" "ykkur" "ykkar" Masc Pl Per2 ;
		-- only have the masculine form of the plural 3rd person pronouns
		they_NP = pronNP "þeir" "þá" "þeim" "þeirra" Masc Pl Per3 ;

		--Some prefabricated determiners:
		a_Det = mkDet [] [] [] [] [] [] [] [] [] [] [] [] Sg False Strong;
		-- The definate article is usually used as a suffix (for all genders) e.g. 
		-- X-inn in Masculinn Nominative (I think its always -inn).
		-- As a matter of fact, the free standing version of the definate article can only be 
		-- followed by and adjective, i.e. det ++ adj ++ noun, and is rare. I am not quite sure
		-- how to implement this functionality, i.e. having both options with the same meaning.
		-- Therefore, the suffixed version is always used for the time being.
		the_Det = mkDet "hinn" "hinn" "hinum" "hins" "hin" "hina" "hinni" "hinnar" "hið" "hið" "hinu" "hins" Sg True Weak; 
		-- For the Neuter, both "sérhvert" or "sérhvað" is used in the Nominative and Accusative cases.
		every_Det = mkDet "sérhver" "sérhvern" "sérhverjum" "sérhvers" "sérhver" "sérhverja" "sérhverri" "sérhverrar" "sérhvert" "sérhvert" "sérhverju" "sérhvers" Sg False Weak;
		-- To my knowledge there is no special difference when reffering to a specific known object (or person) 
		-- that is far away or close (emotionally or physically) in Icelandic - without specifiying the distance further, 
		-- e.g., with an adverb "þessi hlutur hérna" = "this object here" and "þessi hlutur þarna" = "that object there".
		-- But one could argue that "þessi/sá" =~ "this/that". There is also another demonstrative determiner in 
		-- Icelandic, "hinn" = "the other one". For the sake of simplisity and clarity I use the "þessi/sá" = "this/that".
		this_Det = mkDet "þessi" "þennan" "þessum" "þessa" "þessi" "þessa" "þessari" "þessarar" "þetta" "þetta" "þessu" "þessa" Sg False Weak;
		these_Det = mkDet "þessir" "þessa" "þessum" "þessara" "þessar" "þessar" "þessum" "þessara" "þessi" "þessi" "þessum" "þessara" Pl False Weak;
		that_Det = mkDet "sá" "þann" "þeim" "þess" "sú" "þá" "þeirri" "þeirrar" "það" "það" "því" "þess" Sg False Weak;
		those_Det = mkDet "þeir" "þá" "þeim" "þeirra" "þær" "þær" "þeim" "þeirra" "þau" "þau" "þeim" "þeirra" Pl False Weak;

		--Two prefabricated conjunctions:
		and_Conj = {s = "og" ; n = Pl};
		or_Conj = {s = "eða" ; n = Sg};

	-- moduel TestIce

		--Some prefabricated verbs:
		walk_V = mkVerb "ganga" "geng" "gengur" "gengur" "göngum" "gangið" "ganga" "gekk" "gekkst" "gekk" "gengum" "genguð" "gengu" "gengið";
		arrive_V = mkVerb "koma" "kem" "kemur" "kemur" "komum" "komið" "koma" "kom" "komst" "kom" "komum" "komuð" "komu" "komið";

		--Some prefabricated two-place verbs (the acc is taken, as far as I know that is the "unmarked" case that verbs inlfect? on the subject):
		love_V2 = mkV2 "elska" "elska" "elskar" "elskar" "elskum" "elskið" "elska" "elskaði" "elskaðir" "elskaði" "elskuðum" "elskuðuð" "elskuðu" "elskað" Acc;
		please_V2 = mkV2 "gleðja" "gleð" "gleður" "gleður" "gleðjum" "gleðjið" "gleðja" "gladdi" "gladdir" "gladdi" "glöddum" "glödduð" "glöddu" "glatt" Acc;
	
		--Some prefabricated nouns:
		man_N = mkNoun "maður" "mann" "manni" "manns" "menn" "menn" "mönnum" "manna" Masc;
		woman_N = mkNoun "kona" "konu" "konu" "konu" "konur" "konur" "konum" "kvenna" Fem;
		house_N = mkNoun "hús" "hús" "húsi" "húss" "hús" "hús" "húsum" "húsa" Neut;
		tree_N = mkNoun "tré" "tré" "tré" "trés" "tré" "tré" "trjáum" "trjáa" Neut;
	
		--Some prefabricated adjectives:
		big_A = mkAdj "stór" "stóran" "stórum" "stórs" "stór" "stóra" "stórri" "stórrar" "stórt" "stórt" "stóru" "stórs" "stórir" "stóra" "stórum" "stórra" "stórar" "stórar" "stórum" "stórra" "stór" "stór" "stórum" "stórra" "stóri" "stóra" "stóra" "stóru" "stóra" "stóru" True;
		small_A = mkAdj "lítill" "lítinn" "litlum" "lítils" "lítil" "litla" "lítilli" "lítillar" "lítið" "lítið" "litlu" "lítils" "litlir" "litla" "litlum" "lítilla" "litlar" "litlar" "litlum" "lítilla" "lítil" "lítil" "litlum" "lítilla" "litli" "litla" "litla" "litlu" "litla" "litlu" True;
		green_A = mkAdj "grænn" "grænan" "grænum" "grænans" "græn" "græna" "grænni" "grænnar" "grænt" "grænt" "grænu" "græns" "grænir" "græna" "grænum" "grænna" "grænar" "grænar" "grænum" "grænna" "græn" "græn" "grænum" "grænna" "græni" "græna" "græna" "grænu" "græna" "grænu" True; 
	
	-- module ResIce

	param
		Number = Sg | Pl;
		Case = Nom | Acc | Dat | Gen;
		Gender = Masc | Fem | Neut;
		Agr = Ag Gender Number Person;
		Person = Per1 | Per2 | Per3;
		TTense = TPres | TPerf;
		VForm = VInf | VPres Number Person | VPast Number Person | V1Part;
		Declension = Weak | Strong;
	oper
		-- NOUN PHRASE
		NounPhrase = {
			s : Case => Str;
			a : Agr
		};
		
		-- COMMON NOUN
		CommonNoun = {
			noun : Number => Case => Bool => Str;
			adj :  Number => Case => Declension => Str;
			g : Gender;
			isPre : Bool
		};

		-- NOUNS
		Noun : Type = { s : Number => Case => Bool => Str ; g : Gender};

		-- A worst-case function for Noun
		mkNoun : (_, _, _, _, _, _, _, _ :  Str) -> Gender -> Noun =
			\hestur,hest,hesti,hests,hestar,hestaAcc,hestum,hestaGen,g -> {
				s = table {
					Sg => table {
						Nom => table {
							False => hestur; 
							True => case <hestur,g> of {
								<base + noIVowel,Masc> => hestur + "nn";
								<base + noIVowel,Fem> => hestur + "n";
								<base + noIVowel,Neut> => hestur + "ð";
								<_,Masc> => hestur + "inn";
								-- I think this only applies to feminine and neuter nouns
								-- ending with "-ur" - but in all cases.
								<base + "ur",Fem>  => base + "rin";
								<_,Fem> => hestur + "in";
								<base + "ur",Neut> => base + "rið";
								<_,Neut> => hestur + "ið"
								}
							};
						Acc => table {
							False => hest; 
							True => case <hest,g> of {
								<base + noIVowel,Masc> => hest + "nn";
								<base + vowel,Fem> => hest + "na";
								<base + noIVowel,Neut> => hest + "ð";
								<_,Masc> => hest + "inn";
								<base + "ur",Fem> => base + "rina";
								<_,Fem> => hest + "ina";
								<base + "ur",Neut> => base + "rið";
								<_,Neut> => hest + "ið"
								}
							};
						Dat => table {
							False => hesti;
							True => case <hesti,g> of {
								<_,Masc> => hesti + "num";
								<base + vowel,Fem> => hesti + "nni";
								<base + "ur",Fem> => base + "rinni";
								<_,Fem> => hesti + "inni";
								<base + "ur",Neut> => base + "rinu";
								<_,Neut> => hesti + "nu"
								}
							};
						Gen => table {
							False => hests;
							True => case <hests,g> of {
								<base + vowel,Fem> => hests + "nnar";
								<base + "ur",Fem> => base + "rinnar";
								<_,Fem> => hests + "innar";
								<base + "ur", Neut> => base + "rins";
								<base + noIVowel, _> => hests + "ns";
								_ => hests + "ins"
								}
							}
					} ;
					Pl => table {
						Nom => table {
							False => hestar;
							True => case <hestar,g> of {
								<_,Masc> => hestar + "nir";
								<base + "ur",Fem> => base + "rinar";
								<_,Fem> => hestar + "nar";
								<base + "ur",Neut> => base + "rin";
								<base + noIVowel,Neut> => hestar + "n";
								<_,Neut> => hestar + "in"
								}
							};
						Acc => table {
							False => hestaAcc;
							True => case <hestaAcc,g> of {
								<_,Masc> => hestaAcc + "na";
								<base + "ur",Fem> => base + "rinar";
								<_,Fem> => hestaAcc + "nar";
								<base + "ur",Neut> => base + "rin";
								<base + noIVowel,Neut> => hestaAcc + "n";
								<_,Neut> => hestaAcc + "in"
								}
							};
						Dat => table {
							False => hestum;
							True => case <hestum,g> of {
								<base + "ur",Fem> => base + "rinum";
								<base + "ur",Neut> => base + "rinum";
								<base + "m",_> => base + "num"
								}
							};
						Gen => table {
							False => hestaGen;
							-- I think its like this for all genders
							True => case <hestaGen,g> of {
								<base + "áa",Fem> => base + "ánna"; 
								<base + "óa",Fem> => base + "ónna";
								<base + "úa",Fem> => base + "únna";
								_ => hestaGen + "nna"
								}
							}
					}
				} ;
				g = g
		} ;

		-- ADJECTIVES
		Adj : Type = { s : Number => Gender => Case => Declension => Str ; isPre : Bool}; 

		--	The strong declension is used when the adjective modifies indefinite nouns,
		--	or when the adjective is predictive. The weak declension is used when the 
		--	adjective modifies a noun that is defined or determined in some way.
		mkAdj : (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Bool -> Adj =
			-- variable names turned into a soup, so for this particular function variable names will be :
			-- sgMascNom - the singular masculine Nominative, etc.
			\sgMascNom,sgMascAcc,sgMascDat,sgMascGen,sgFemNom,sgFemAcc,sgFemDat,sgFemGen,sgNeutNom,sgNeutAcc,sgNeutDat,sgNeutGen,plMascNom,plMascAcc,plMascDat,plMascGen,plFemNom,plFemAcc,plFemDat,plFemGen,plNeutNom,plNeutAcc,plNeutDat,plNeutGen,weakSgMascNom,weakSgMascAccDatGen,weakSgFemNom,weakSgFemAccDatGen,weakSgNeut,weakPl,b -> {
				s = table {
					Sg => table {
						Masc => table {
							Nom => table {Strong => sgMascNom ; Weak => weakSgMascNom};
 							Acc => table {Strong => sgMascAcc ; Weak => weakSgMascAccDatGen};
							Dat => table {Strong => sgMascDat ; Weak => weakSgMascAccDatGen};
							Gen => table {Strong => sgMascGen ; Weak => weakSgMascAccDatGen}
							};
						Fem => table {
							Nom => table {Strong => sgFemNom ; Weak => weakSgFemNom};
							Acc => table {Strong => sgFemAcc ; Weak => weakSgFemAccDatGen};
							Dat => table {Strong => sgFemGen ; Weak => weakSgFemAccDatGen}; 
							Gen => table {Strong => sgFemGen ; Weak => weakSgFemAccDatGen}
							};
						Neut => table {
							Nom => table {Strong => sgNeutNom ; Weak => weakSgNeut};
							Acc => table {Strong => sgNeutAcc ; Weak => weakSgNeut};
							Dat => table {Strong => sgNeutDat ; Weak => weakSgNeut};
							Gen => table {Strong => sgNeutGen ; Weak => weakSgNeut}
							}
					};
					Pl => table {
						Masc => table {
							Nom => table {Strong => plMascNom ; Weak => weakPl};
							Acc => table {Strong => plMascAcc ; Weak => weakPl};
							Dat => table {Strong => plMascDat ; Weak => weakPl};
							Gen => table {Strong => plMascGen ; Weak => weakPl}
							};
						Fem => table {
							Nom => table {Strong => plFemNom ; Weak => weakPl};
							Acc => table {Strong => plFemAcc ; Weak => weakPl};
							Dat => table {Strong => plFemDat ; Weak => weakPl};
							Gen => table {Strong => plFemGen ; Weak => weakPl}
							};
						Neut => table {
							Nom => table {Strong => plNeutNom ; Weak => weakPl};
							Acc => table {Strong => plNeutAcc ; Weak => weakPl};
							Dat => table {Strong => plNeutDat ; Weak => weakPl};
							Gen => table {Strong => plNeutGen ; Weak => weakPl}
							}
					}
				};
				isPre = b
		};

		-- DET

		mkDet :  (_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Number -> Bool -> Declension -> {s : Gender => Case => Str ; n : Number ; b : Bool ; d : Declension} =
			\hinnNom,hinnAcc,hinum,hins,hin,hina,hinni,hinnar,hiðNom,hiðAcc,hinu,hins,n,b,d -> {
				s = table {
					Masc => table {Nom => hinnNom ; Acc => hinnAcc ; Dat => hinum ; Gen => hins} ;
					Fem => table {Nom => hin ; Acc => hina ; Dat => hinni ; Gen => hinnar} ;
					Neut => table {Nom => hiðNom ; Acc => hiðAcc ; Dat => hinu ; Gen => hins}
				};
				n = n;
				b = b;
				d = d
		};


		-- PRONOUNS

		pronNP : (n,a,d,g : Str) -> Gender -> Number -> Person -> NounPhrase = 
			\ég,mig,mér,mín,g,n,p -> {
			s = table {
				Nom => ég ;
				Acc => mig ;
				Dat => mér ;
				Gen => mín
				} ;
			a = Ag g n p ;
		} ;


		-- VERBS
		
		Verb : Type = {s : VForm => Str};

		-- A worst-case function for mkVerb
		mkVerb : (_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb =
			\vera,er1,ert,er3,erum,eruð,eru,var1,varst,var3,vorum,voruð,voru,verið -> {
				s = table {
					VInf 		=> vera ;
					VPres Sg Per1	=> er1 ;
					VPres Sg Per2	=> ert ;
					VPres Sg Per3	=> er3 ;
					VPres Pl Per1	=> erum ; 
					VPres Pl Per2	=> eruð ;
					VPres Pl Per3	=> eru ;
					VPast Sg Per1	=> var1 ;
					VPast Sg Per2	=> varst ;
					VPast Sg Per3	=> var3 ;
					VPast Pl Per1	=> vorum ;
					VPast Pl Per2	=> voruð ; 
					VPast Pl Per3	=> voru;
					V1Part		=> verið
				} ;
		} ;	
		
		VerbPhrase = {
			s : Verb;
			obj : Agr => Str; 
		};
		
		-- For Predication
		agrV : Verb -> Agr -> TTense -> Bool -> Str = \v,a,t,neg -> 
			-- 1	In these scenarios, the only auxilary verb used (as far as I know)
			--	 is 'að hafa' ('to have') - therefore it is hardcoded atm.
			-- 2	'hef' and 'hefur' are dominant in modern Icelandic - but 'hefi' and
			--	'hefir' are rather common in written texts.
			let 
				aux = mkVerb "hafa" "hef" "hefur" "hefur" "höfum" "hafið" "hafa" "hafði" "hafðir" "hafði" "höfðum" "höfðuð" "höfðu" "haft"
			in case <t,a,neg> of {
				<TPres,Ag _ n p,_> => v.s ! VPres n p ;
				<TPerf,Ag _ n p,True> => aux.s ! VPres n p ++ v.s ! V1Part;
				<TPerf,Ag _ n p,False> => aux.s ! VPres n p ++ "ekki" ++  v.s ! V1Part
		};

		-- Coordination

		conjAgr : Number -> Agr -> Agr -> Agr = \n,xa,ya -> 
			let
				x = agrFeatures xa ; y = agrFeatures ya
			in Ag
				(conjGender x.g y.g)
				(conjNumber (conjNumber x.n y.n) n)
				(conjPerson x.p y.p) ;

		agrFeatures : Agr -> {g : Gender ; n : Number ; p : Person} = \a ->
			case a of {Ag g n p => {g = g ; n = n ; p = p}} ;

		conjGender : Gender -> Gender -> Gender = \g,h -> case <g,h> of {
				<Masc,Masc>	=> Masc;
				<Fem,Fem>	=> Fem;
				_		=> Neut
		};

		conjNumber : Number -> Number -> Number = \m,n ->
			case m of {Pl => Pl ; _ => n} ;

		conjPerson : Person -> Person -> Person = \p,q ->
			case <p,q> of {
				<Per1,_> | <_,Per1> => Per1 ;
				<Per2,_> | <_,Per2> => Per2 ;
				_                   => Per3
		} ;

		-- For pattern matching nouns to suffix the definate article.
		-- The suffix , "-inn","-in","-ið", loses the "-i-" when the noun ends with
		-- "-a", "-i", "-u", and most cases of "-é".
		noIVowel : pattern Str = #("a" | "i" | "u" | "é") ;
	
		vowel : pattern Str = #("a" | "á" | "e" | "é" | "i" | "í" | "o" | "ó" | "u" | "ú" | "y" | "ý" | "æ" | "ö");
	
	-- module ParadigmsEng

	oper
		mkV2 = overload {
			mkV2 : (_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Case -> V2
				= \vera,er1,ert,er3,erum,eruð,eru,var1,varst,var3,vorum,voruð,voru,verið,c -> 
					lin V2 (mkVerb vera er1 ert er3 erum eruð eru var1 varst var3 vorum voruð voru verið ** {c = c});
		};
}
