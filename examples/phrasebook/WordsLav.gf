--# -path=.:present

concrete WordsLav of Words = SentencesLav **
open
	SyntaxLav, 
	ParadigmsLav, 
	(P = ParadigmsLav), 
	(L = LexiconLav), 
	ExtraLav, 
	ResLav,
	Prelude,
	Predef 
in {
	
	flags
		coding = utf8 ;

	lin
		-- Kinds
		
		Apple = mkCN L.apple_N ;
		Beer = mkCN L.beer_N ;
		Bread = mkCN L.bread_N ;
		Cheese = mkCN L.cheese_N ;
		Chicken = mkCN (mkN "vista") ;
		Coffee = mkCN (mkN "kafija") ;
		Fish = mkCN L.fish_N ;
		Meat = mkCN L.meat_N ;
		Milk = mkCN L.milk_N ;
		Pizza = mkCN (mkN "pica") ;
		Salt = mkCN L.salt_N ;
		Tea = mkCN (mkN "tēja") ;
		Water = mkCN L.water_N ;
		Wine = mkCN L.wine_N ;
		
		-- Properties
		
		Bad = L.bad_A ;
		Boring = mkA "garlaicīgs" ;
		Cheap = mkA "lēts" ;
		Cold = L.cold_A ;
		Delicious = mkA "garšīgs" ;
		Expensive = mkA "dārgs" ;
		Fresh = mkA "svaigs" ;
		Good = L.good_A ;
		Suspect = mkA "aizdomīgs" ;
		Warm = L.warm_A ;
		
		-- Places
		
		Airport = mkPlace "lidosta" in_Prep ;
		AmusementPark = mkPlace "atrakciju parks" in_Prep ;
		Bank = mkPlace "banka" in_Prep ;
		Bar = mkPlace "bārs" in_Prep ;
		Cafeteria = mkPlace "kafejnīca" in_Prep ;
		Center = mkPlace "centrs" in_Prep ;
		Cinema = mkPlace "kino" in_Prep ;
		Church = mkPlace "baznīca" in_Prep ;
		Disco = mkPlace "diskotēka" in_Prep ;
		Hospital = mkPlace "slimnīca" in_Prep ;
		Hotel = mkPlace "viesnīca" in_Prep ;
		Museum = mkPlace "muzejs" in_Prep ;
		Park = mkPlace "parks" in_Prep ;
		Parking = mkPlace "autostāvvieta" in_Prep ;
		Pharmacy = mkPlace "aptieka" in_Prep ;
		PostOffice = mkPlace "pasts" in_Prep ;
		Pub = mkPlace "krogs" in_Prep ;
		Restaurant = mkPlace "restorāns" in_Prep ;
		School = mkPlace "skola" in_Prep ;
		Shop = mkPlace "veikals" in_Prep ;
		Station = mkPlace "stacija" in_Prep ;
		Supermarket = mkPlace "lielveikals" in_Prep ;
		Theatre = mkPlace "teātris" in_Prep ;
		Toilet = mkPlace "tualete" in_Prep ;
		University = mkPlace "universitāte" in_Prep ;
		Zoo = mkPlace "zoodārzs" in_Prep ;
		
		CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restorāns")) in_Prep to_Prep ;
		
		-- Currencies
		
		DanishCrown = mkCN (mkA "dāņu") (mkN "krona") | mkCN (mkN "krona") ;
		Dollar = mkCN (mkN "dolārs") ;
		Euro = mkCN (mkN "eiro") ;
		Lei = mkCN (mkN "leja") ;
		Leva = mkCN (mkN "leva") ;
		NorwegianCrown = mkCN (mkA "norvēģu") (mkN "krona") | mkCN (mkN "krona") ;
		Pound = mkCN (mkN "mārciņa") ;
		Rouble = mkCN (mkN "rublis") ;
		SwedishCrown = mkCN (mkA "zviedru") (mkN "krona") | mkCN (mkN "krona") ;
		Zloty = mkCN (mkN "zlots") ;
		
		-- Nationalities
		
		Belgian = mkA "beļģu" ;
		Belgium = mkNP (mkPN "Beļģija") ;
		Bulgarian = mkNat (mkA "bulgāru") (P.mkAdv "bulgāriski") (mkPN "Bulgārija") ;
		Catalan = mkNat (mkA "kataloniešu") (P.mkAdv "kataloniski") (mkPN "Katalonija") ;
		Danish = mkNat (mkA "dāņu") (P.mkAdv "dāniski") (mkPN "Dānija") ;
		Dutch =  mkNat (mkA "holandiešu") (P.mkAdv "holandiski") (mkPN "Nīderlande") ;
		English = mkNat (mkA "angļu") (P.mkAdv "angliski") (mkPN "Anglija") ;
		Finnish = mkNat (mkA "somu") (P.mkAdv "somiski") (mkPN "Somija") ;
		Flemish = mkLang (mkA "flāmu") (P.mkAdv "flāmiski") ;
		French = mkNat (mkA "franču") (P.mkAdv "franciski") (mkPN "Francija") ;
		German = mkNat (mkA "vācu") (P.mkAdv "vāciski") (mkPN "Vācija") ;
		Italian = mkNat (mkA "itāļu") (P.mkAdv "itāliski") (mkPN "Itālija") ;
		Norwegian = mkNat (mkA "norvēģu") (P.mkAdv "norvēģiski") (mkPN "Norvēģija") ;
		Polish = mkNat (mkA "poļu") (P.mkAdv "poliski") (mkPN "Polija") ;
		Romanian = mkNat (mkA "rumāņu") (P.mkAdv "rumāniski") (mkPN "Rumānija") ;
		Russian = mkNat (mkA "krievu") (P.mkAdv "krieviski") (mkPN "Krievija") ;
		Spanish = mkNat (mkA "spāņu") (P.mkAdv "spāniski") (mkPN "Spānija") ;
		Swedish = mkNat (mkA "zviedru") (P.mkAdv "zviedriski") (mkPN "Zviedrija") ;
		
		-- Means of transportation
		
		Bike = mkTransport L.bike_N ;
		Bus = mkTransport (mkN "autobuss") ;
		Car = mkTransport L.car_N ;
		Ferry = mkTransport (mkN "prāmis") ;
		Plane = mkTransport L.airplane_N ;
		Subway = mkTransport (mkN "metro") ;
		Taxi = mkTransport (mkN "taksometrs") ;
		Train = mkTransport (mkN "vilciens") ;
		Tram = mkTransport (mkN "tramvajs") ;
		ByFoot = P.mkAdv "kājām" ;
		
		-- Actions
		
		AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
  		AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
		AHasRoom p num = mkCl p.name have_V3 (mkNP a_Det (mkN "istaba")) (mkNP num (mkN "persona")) ;
		AHasTable p num = mkCl p.name have_V3 (mkNP a_Det (mkN "galdiņš")) (mkNP num (mkN "persona")) ;
		
		AHasName p name = 
			mkCl p.name (mkV2 (mkV "saukt" "saucu" "saucu" Acc) nom_Prep) name |
			mkCl (nameOf p) name ;
		
		AHungry p = mkCl p.name (mkA (mkV "izsalkt" "izsalkstu" "izsalku") active_voice) ;
		AIll p = mkCl p.name (mkA "slims") ;
		AKnow p = mkCl p.name (mkV "zināt" third_conjugation) ;
		ALike p item = mkCl p.name (mkV2 (mkV "garšot" second_conjugation Dat) nom_Prep) item ;
		ALive p co = mkCl p.name (mkVP (mkVP (mkV "dzīvot" second_conjugation)) (SyntaxLav.mkAdv in_Prep co)) ;
		ALove p q = mkCl p.name L.love_V2 q.name ;
		AMarried p = mkCl p.name (mkA (mkV "precēties" third_conjugation) active_voice) ;
		AReady p = mkCl p.name (mkA "gatavs") ;
		
		AScared p = 
			mkCl p.name (mkV "baidīties" third_conjugation) | 
			mkCl p.name (mkA (mkV "nobīties" "nobīstos" "nobijos") active_voice) ;
		
		ASpeak p lang = 
			mkCl p.name (mkVP (mkVP (mkV "runāt" second_conjugation)) lang.modif) | 
			mkCl p.name (mkV2 (mkV "runāt" second_conjugation) loc_Prep) lang.lang ;
		
		AThirsty p = mkCl p.name (mkA (mkV "izslāpt" "izslāpstu" "izslāpu") active_voice) ;
		ATired p = mkCl p.name (mkA (mkV "nogurt" "nogurstu" "noguru") active_voice) ;
		AUnderstand p = mkCl p.name (mkV "saprast" "saprotu" "sapratu") ;
		AWant p obj = mkCl p.name (mkV2 (mkV "vēlēties" third_conjugation)) obj ;

		-- TODO: IrregLav.doties_V
		AWantGo p place = mkCl p.name (mkVV (mkV "vēlēties" third_conjugation)) (mkVP (mkVP (mkV "doties" "dodos" "devos")) place.to) ;
		---- mkVV by AR 28/8/2012
		
		-- Quick & dirty, or ok?
		QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (mkV2 (mkV "saukt" "saucu" "saucu" Acc) nom_Prep) (mkNP (mkN [])))) ;
		
		-- Quick & dirty
		-- TODO: how8much_IAdv >>> how8many_IDet (but the word order!) or how8many_IAdv
		--       mkNP a_Quant pluralNum L.year_N >>> mkNP pluralNum L.year_N
		-- Cannot use have_V2 because of a different valence
		QWhatAge p = mkQS (mkQCl how8much_IAdv (mkCl p.name (mkV2 (mkV "būt" Dat) gen_Prep) (mkNP the_Quant pluralNum L.year_N))) ;

		-- Quick & dirty
		-- TODO: item is the subject >>> use NP -> V -> Cl (changing the default word order)
		HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl (mkVP (mkV2 (mkV "maksāt" second_conjugation) nom_Prep) item))) ;

		ItCost item price = mkCl item (mkV2 (mkV "maksāt" second_conjugation) acc_Prep) price ;
		
		PropOpen p = mkCl p.name open_A ;
		PropClosed p = mkCl p.name closed_A ;
		PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ;
		PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ;
		PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ;
		PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ;
		
		-- Building phrases from strings is complicated: the solution is to use
		-- mkText : Text -> Text -> Text ;
		PSeeYouDate d = mkText (lin Text (ss ("tiksimies"))) (mkPhrase (mkUtt d)) ;
		PSeeYouPlace p = mkText (lin Text (ss ("tiksimies"))) (mkPhrase (mkUtt p.at)) ;
		PSeeYouPlaceDate p d = mkText (lin Text (ss ("tiksimies"))) (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ;
		
		-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
		-- below. Languages without productive genitives must use an equivalent of
		-- "the wife of my son" for non-pronouns.
		Wife = xOf sing (mkN "sieva") ;
		Husband = xOf sing (mkN "vīrs") ;
		Son = xOf sing (mkN "dēls") ;
		Daughter = xOf sing (mkN "meita") ;
		Children = xOf plur L.child_N ;
		
		-- week days
		
		Monday = mkDay "pirmdiena" ;
		Tuesday = mkDay "otrdiena" ;
		Wednesday = mkDay "trešdiena" ;
		Thursday = mkDay "ceturtdiena" ;
		Friday = mkDay "piektdiena" ;
		Saturday = mkDay "sestdiena" ;
		Sunday = mkDay "svētdiena" ;
		
		Tomorrow = P.mkAdv "rīt" ;
		
		-- modifiers of places
		TheBest = mkSuperl L.good_A ;
		TheClosest = mkSuperl L.near_A ;
		TheCheapest = mkSuperl (mkA "lēts") ;
		TheMostExpensive = mkSuperl (mkA "dārgs") ;
		TheMostPopular = mkSuperl (mkA "populārs") ;
		TheWorst = mkSuperl L.bad_A ;
		SuperlPlace sup p = placeNP sup p ;
		
		-- transports
		HowFar place = mkQS (mkQCl far_IAdv place.name) ;
		HowFarFrom x y = mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxLav.mkAdv from_Prep x.name))) ;
		HowFarFromBy x y t = mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxLav.mkAdv from_Prep (mkNP x.name t)))) ;
		HowFarBy y t = mkQS (mkQCl far_IAdv (mkCl y.name t)) ;
		WhichTranspPlace trans place = mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;
		IsTranspPlace trans place = mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;
		
	oper
		mkLang : A -> Adv -> NPLanguage = \la,mo -> {
			lang = mkNP (mkCN la (mkN "valoda")) ;
			modif = mo
		} ;

		mkNat : A -> Adv -> PN -> NPNationality = \la,mo,co -> 
			mkNPNationality (mkLang la mo) (mkNP co) la ;
		
		mkDay : Str -> NPDay = \d -> 
			mkNPDay (mkNP (mkPN d))
					(P.mkAdv (Predef.tk 1 d)) 
					(SyntaxLav.mkAdv in_Prep (mkNP the_Quant plNum (mkCN (mkN d)))) ;

		--mkCompoundPlace : Str -> Str -> Prep -> {
		--	name : CN ;
		--	at : Prep ;
		--	to : Prep ;
		--	isPl : Bool
		--} = \comp,p,i -> mkCNPlace (mkCN (P.mkN comp (mkN p))) i to_Prep ;

		mkPlace : Str -> Prep -> {name : CN ; at : SyntaxLav.Prep ; to : SyntaxLav.Prep ; isPl : Bool} = \p,i -> 
		 	mkCNPlace (mkCN (mkN p)) i to_Prep ;  ---- SyntaxLav.Prep by AR 28/8/2012

		open_A = P.mkA "atvērts" ;
		
		closed_A = P.mkA "slēgts" ;
		
		xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
			relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;
		
		nameOf : NPPerson -> NP = \p -> 
			(xOf sing (mkN "vārds") p).name ;
		
		mkTransport : N -> {
			name : CN ;
			by : Adv
		} = \n -> {
			name = mkCN n ;
			by = SyntaxLav.mkAdv by8means_Prep (mkNP n)
		} ;
		
		mkSuperl : A -> Det = \a -> 
			SyntaxLav.mkDet the_Art (SyntaxLav.mkOrd a) ;
		
		far_IAdv = ExtraLav.IAdvAdv (mkAdv "tālu") ;
		
--------------------------------------------------
-- New 30/11/2011 AR
--------------------------------------------------

	lin
		Thai = mkNat (mkA "taizemiešu") (mkPN "Taizeme") ;
		Baht = mkCN (mkN "bats") ;
		Rice = mkCN (mkN "rīss") ;
		Pork = mkCN (mkN "cūkgaļa") ;
		Beef = mkCN (mkN "liellops") ;
		Egg = mkCN L.egg_N ;
		Noodles = mkCN (mkN "nūdele") ;
		Shrimps = mkCN (mkN "garnele") ;
		Chili = mkCN (mkN "čili") ;
		Garlic = mkCN (mkN "ķiploks") ;
		Durian = mkCN (mkN "durians") ;
		Mango = mkCN (mkN "mango") ;
		Pineapple = mkCN (mkN "ananass") ;
		Coke = mkCN (mkN "kola") ;
		IceCream = mkCN (mkN "saldējums") ;
		Salad = mkCN (mkN "salāts") ;
		OrangeJuice = mkCN (mkA "apelsīnu") (mkN "sula") ;
		Lemonade = mkCN (mkN "limonāde") ;
		Beach = mkPlace "pludmale" in_Prep ;
		ItsRaining = mkCl (progressiveVP (mkVP L.rain_V0)) ;
		ItsCold = mkCl (mkVP L.cold_A) ;
		ItsWarm = mkCl (mkVP L.warm_A) ;
		ItsWindy = mkCl (mkVP (P.mkA "vējains")) ;
		SunShine = mkCl (mkNP the_Det L.sun_N) (progressiveVP (mkVP (mkV "spīdēt" third_conjugation))) ;
		Smoke = mkVP (P.mkV "smēķēt" second_conjugation) ;
		ADoctor = mkProfession (mkN "ārsts") ;
		AProfessor = mkProfession (mkN "profesors") ;
		ALawyer = mkProfession (mkN "jurists") ;
		AEngineer = mkProfession (mkN "inženieris") ;
		ATeacher = mkProfession (mkN "skolotājs") ;
		ACook = mkProfession (mkN "pavārs") ;
		AStudent = mkProfession (mkN "students") ;
		ABusinessman = mkProfession (mkN "uzņēmējs") ;

	oper
		mkProfession : N -> NPPerson -> Cl = \n,p -> mkCl p.name n ;

}
