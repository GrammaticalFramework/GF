--# -path=.:present

concrete WordsLav of Words = SentencesLav **
open
	SyntaxLav, 
	ParadigmsLav, 
	(P = ParadigmsLav), 
	(L = LexiconLav), 
	ExtraLav, 
	ResLav,
	Prelude 
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
		
		CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restorāns")) in_Prep to8uz_Prep ;
		
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
		Bulgarian = mkNat (mkA "bulgāru") (mkPN "Bulgārija") ;
		Catalan = mkNat (mkA "kataloniešu") (mkPN "Katalonija") ;
		Danish = mkNat (mkA "dāņu") (mkPN "Dānija") ;
		Dutch =  mkNat (mkA "holandiešu") (mkPN "Nīderlande") ;
		English = mkNat (mkA "angļu") (mkPN "Anglija") ;
		Finnish = mkNat (mkA "somu") (mkPN "Somija") ;
		Flemish = mkLang (mkA "flāmu") ;
		French = mkNat (mkA "franču") (mkPN "Francija") ;
		German = mkNat (mkA "vācu") (mkPN "Vācija") ;
		Italian = mkNat (mkA "itāļu") (mkPN "Itālija") ;
		Norwegian = mkNat (mkA "norvēģu") (mkPN "Norvēģija") ;
		Polish = mkNat (mkA "poļu") (mkPN "Polija") ;
		Romanian = mkNat (mkA "rumāņu") (mkPN "Rumānija") ;
		Russian = mkNat (mkA "krievu") (mkPN "Krievija") ;
		Spanish = mkNat (mkA "spāņu") (mkPN "Spānija") ;
		Swedish = mkNat (mkA "zviedru") (mkPN "Zviedrija") ;
		
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
		
		-- FIXME: p.name[Dat] have_V2 num+year[Nom] (word order)
		AHasAge p num = mkCl (mkNP num L.year_N) (mkV2 (mkV "būt") dat_Prep) p.name ;

		-- FIXME: p.name[Dat] have_V2 num+child[Nom] (word order)
		AHasChildren p num = mkCl (mkNP num L.child_N) (mkV2 (mkV "būt") dat_Prep) p.name ;
		
		-- FIXME: p.name[Dat] have_V3 room[Nom] num+person[Dat] (word order)
		AHasRoom p num = mkCl (mkNP a_Det (mkN "istaba")) (mkV3 (mkV "būt") dat_Prep dat_Prep) p.name (mkNP num (mkN "persona")) ;
		
		-- FIXME: p.name[Dat] have_V3 table[Nom] num+person[Dat] (word order)
		AHasTable p num = mkCl (mkNP a_Det (mkN "galdiņš")) (mkV3 (mkV "būt") dat_Prep dat_Prep) p.name (mkNP num (mkN "persona")) ;
		
		-- FIXME: p[Acc] V2("saukt") name[Nom] - a more common phrase (+ word order)
		AHasName p name = mkCl (nameOf p) name ;

		AHungry p = mkCl p.name (mkA (mkV "izsalkt" "izsalkstu" "izsalku")) ;
		AIll p = mkCl p.name (mkA "slims") ;
		AKnow p = mkCl p.name (mkV "zināt" third_conjugation) ;
		
		-- FIXME: p.name[Dat] V2 item[Nom] (word order)
		ALike p item = mkCl item (mkV2 (mkV "garšot" second_conjugation) dat_Prep) p.name ;
		
		ALive p co = mkCl p.name (mkVP (mkVP (mkV "dzīvot" second_conjugation)) (SyntaxLav.mkAdv in_Prep co)) ;
		ALove p q = mkCl p.name L.love_V2 q.name ;
		AMarried p = mkCl p.name (mkA (mkV "precēties" third_conjugation)) ;
		AReady p = mkCl p.name (mkA "gatavs") ;
		AScared p = mkCl p.name (mkA (mkV "nobīties" "nobīstos" "nobijos")) ;
		ASpeak p lang = mkCl p.name (mkV2 (mkV "runāt" second_conjugation) loc_Prep) lang ;
		AThirsty p = mkCl p.name (mkA (mkV "izslāpt" "izslāpstu" "izslāpu")) ;
		ATired p = mkCl p.name (mkA (mkV "nogurt" "nogurstu" "noguru")) ;
		AUnderstand p = mkCl p.name (mkV "saprast" "saprotu" "sapratu") ;
		AWant p obj = mkCl p.name (mkV2 (mkV "vēlēties" third_conjugation) acc_Prep) obj ;
		AWantGo p place = mkCl p.name (mkV "vēlēties" third_conjugation) (mkVP (mkVP (mkV "doties" "dodos" "devos")) place.to) ;
		
		-- Miscellaneous
		
		QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
		QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name);
		HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "maksāt" second_conjugation))) ;
		ItCost item price = mkCl item (mkV2 (mkV "maksāt" second_conjugation) nom_Prep) price ;
		
		PropOpen p = mkCl p.name open_A ;
		PropClosed p = mkCl p.name closed_A ;
		PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ;
		PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ;
		PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ;
		PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ;
		
		-- Building phrases from strings is complicated: the solution is to use
		-- mkText : Text -> Text -> Text ;
		PSeeYouDate d = mkText (lin Text (ss ("uz tikšanos"))) (mkPhrase (mkUtt d)) ;
		PSeeYouPlace p = mkText (lin Text (ss ("uz tikšanos"))) (mkPhrase (mkUtt p.at)) ;
		PSeeYouPlaceDate p d = mkText (lin Text (ss ("uz tikšanos"))) (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;
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
		mkLang : A -> NP = \la -> 
			mkNP (mkCN la (mkN "valoda")) ;

		mkNat : A -> PN -> NPNationality = \la,co -> 
			mkNPNationality (mkLang la) (mkNP co) la ;
		
		mkDay : Str -> NPDay = \d -> 
			let day : NP = mkNP (mkPN d) in
				mkNPDay day
						(SyntaxLav.mkAdv in_Prep day) 
						(SyntaxLav.mkAdv in_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;

		--mkCompoundPlace : Str -> Str -> Prep -> {
		--	name : CN ;
		--	at : Prep ;
		--	to : Prep ;
		--	isPl : Bool
		--} = \comp,p,i -> mkCNPlace (mkCN (P.mkN comp (mkN p))) i to_Prep ;
		
		mkPlace : Str -> Prep -> {name : CN ; at : Prep ; to : Prep ; isPl : Bool} = \p,i -> 
		  mkCNPlace (mkCN (mkN p)) i to8uz_Prep ;
		
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
		
		far_IAdv = ExtraLav.IAdvAdv (ss "tālu") ;
		
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
