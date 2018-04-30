-- (c) 2010 Aarne Ranta under LGPL
-- Estonian port by Kaarel Kaljurand

concrete WordsEst of Words = SentencesEst **
  open
    SyntaxEst, ParadigmsEst, (L = LexiconEst), (R = ResEst),
    Prelude, (E = ExtraEst) in {

  flags optimize = noexpand ;

  lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "juust" "juustu" "juustu" "juustu" "juustude" "juuste") ;
    Chicken = mkCN (mkN "kana") ;
    Coffee = mkCN (mkN "kohv" "kohvi" "kohvi" "kohvi" "kohvide" "kohve") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "liha") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pitsa" "pitsa" "pitsat" "pitsasse" "pitsade" "pitsasid") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "tee") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- qualities

    Bad = L.bad_A ;
    Boring = mkA "igav" ;
    Cheap = mkA "odav" ;
    Cold = L.cold_A ;
    Delicious = mkA "maitsev" ;
    Expensive = mkA (mkN "kallis" "kalli" "kallist" "kallisse" "kallite" "kalleid");
    Fresh = mkA "toores" ;
    Good = L.good_A ;
    Suspect = mkA "kahtlane" ;
    Warm = L.warm_A ;

-- places

    Restaurant = mkPlace (mkN "restoran") ssa ;
    Bank = mkPlace (mkN "pank") ssa ;
    PostOffice = mkPlace (mkN "post" (mkN "kontor")) ssa ;
    Bar = mkPlace (mkN "baar") ssa ;
    Toilet = mkPlace (mkN "tualett") ssa ;
    Museum = mkPlace (mkN "muuseum") ssa ;
    Airport = mkPlace (mkN "lennu" (mkN "jaam" "jaama" "jaama" "jaama" "jaamade" "jaamu")) ssa ; -- different in Fin
    Station = mkPlace (mkN "jaam" "jaama" "jaama" "jaama" "jaamade" "jaamu") ssa ; -- different in Fin
    Hospital = mkPlace (mkN "haigla") ssa ;
    Church = mkPlace (mkN "kirik") ssa ;
    Cinema = mkPlace (mkN "kino") ssa ;
    Theatre = mkPlace (mkN "teater") ssa ;
    Shop = mkPlace (mkN "pood" "poe" "poodi" "poodi" "poodide" "poode") ssa ;
    Park = mkPlace (mkN "park") ssa ;
    Hotel = mkPlace (mkN "hotell" "hotelli" "hotelli" "hotelli" "hotellide" "hotelle") ssa ;
    University = mkPlace (mkN "üli" (mkN "kool")) ssa ; -- different in Fin
    School = mkPlace (mkN "kool") ssa ; -- different in Fin

    CitRestaurant cit = {
      name = mkCN cit.prop (mkN "restoran") ;
      at = casePrep inessive ;
      to = casePrep illative;
      from = casePrep elative ;
      isPl = False
      } ;

    Parking = mkPlace (mkN "parkla") ssa ; -- different in Fin
    Supermarket = mkPlace (mkN "super" (mkN "market")) ssa ;
    Pharmacy = mkPlace (mkN "apteek") ssa ;
    Center = mkPlace (mkN "keskus") ssa ;
    Cafeteria = mkPlace (mkN "kohvik") ssa ;
    Disco = mkPlace (mkN "diskoteek") ssa ;
    Pub = mkPlace (mkN "kõrts") ssa ;
    AmusementPark = mkPlace (mkN "lõbustus" (mkN "park")) ssa ;
    Zoo = mkPlace (mkN "looma" (mkN "aed" "aia" "aeda" "aeda" "aedade" "aedu")) ssa ;

-- currencies

    DanishCrown = mkCN (kroon2 "taani") ;
    Dollar = mkCN (mkN "dollar") ;
    Euro = mkCN (mkN "euro") ;
    Lei = mkCN (mkN "leu") ;
    Leva = mkCN (mkN "leev") ;
    NorwegianCrown = mkCN (kroon2 "norra") ;
    Pound = mkCN (mkN "nael" "naela") ;
    Rouble = mkCN (mkN "rubla") ;
    Rupee = mkCN (mkN "ruupia") ;
    SwedishCrown = mkCN (kroon2 "rootsi") ;
    Zloty = mkCN (mkN "zlott") ;
    Yuan = mkCN (mkN "jüään") ;

-- Citizenship
    Belgian = { prop = invA "belgia" ; nat = mkA "belglane" } ;
    Indian = { prop = invA "india" ; nat = mkA "indialane" } ;

-- Country
    Belgium = mkNP (mkPN "Belgia") ;
    India = mkNP (mkPN "India") ;

-- Nationality
    Bulgarian = mkNat "bulgaaria" "bulgaarlane" (mkPN "Bulgaaria") ;
    Catalan = mkNat "katalaani" "kataloonlane" (mkPN "Kataloonia") ;
    Chinese = mkNat "hiina" "hiinlane" (mkPN "Hiina") ;
    Danish = mkNat "taani" "taanlane" (mkPN "Taani") ;
    Dutch = mkNat "hollandi" "hollandlane" (mkPN "Holland") ;
    English = mkNat "inglise" "inglane" (mkPN "Inglismaa") ;
    Finnish = mkNat "soome" "soomlane" (mkPN "Soome") ;
    Flemish = mkNP (mkPN "flaami keel") ; -- Language
    Hindi = mkNP (mkPN "hindi keel") ; -- Language
    French = mkNat "prantsuse" "prantslane" (mkPN "Prantsusmaa") ;
    German = mkNat "saksa" "sakslane" (mkPN "Saksamaa") ;
    Italian = mkNat "itaalia" "itaallane" (mkPN "Itaalia") ;
    Norwegian = mkNat "norra" "norralane" (mkPN "Norra") ;
    Polish = mkNat "poola" "poolapärane" (mkPN "Poola") ; -- Is there a -lane adjective for poola? Didn't find one at EKSS /IL2018
    Romanian = mkNat "rumeenia" "rumeenlane" (mkPN "Rumeenia") ;
    Russian = mkNat "vene" "venelane" (mkPN "Venemaa") ;
    Spanish = mkNat "hispaania" "hispaanlane" (mkPN "Hispaania") ;
    Swedish = mkNat "rootsi" "rootslane" (mkPN "Rootsi") ;

    ---- it would be nice to have a capitalization Predef function

-- means of transportation

    Bike = mkTransport L.bike_N ;
    Bus = mkTransport (mkN "buss" "bussi" "bussi" "bussi" "busside" "busse") ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN "praam") ;
    Plane = mkTransport L.airplane_N ;
    Subway = mkTransport (mkN "metroo") ;
    Taxi = mkTransport (mkN "takso") ;
    Train = mkTransport L.train_N ;
    Tram = mkTransport (mkN "tramm") ;

    ByFoot = ParadigmsEst.mkAdv "jalgsi" ;


-- actions

    AHasAge p num = mkCl p.name (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHasRoom p = haveForPerson p.name (mkCN (mkN "tuba")) ;
    AHasTable p = haveForPerson p.name (mkCN (mkN "laud")) ;
    AHungry p = E.AdvExistNP (SyntaxEst.mkAdv on_Prep p.name) (mkNP (mkN "nälg")) ;
    AIll p = mkCl p.name (mkA "haige") ;
    --AKnow p = mkCl p.name (mkV "teadma") ;
    AKnow p = mkCl p.name L.know_VS ;
    ALike p item = mkCl p.name L.like_V2 item ;
    ALive p co = mkCl p.name (mkVP (mkVP L.live_V) (SyntaxEst.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name L.love_V2 q.name ;
    AMarried p = mkCl p.name (ParadigmsEst.mkAdv "abielus") ;
    AReady p = mkCl p.name (ParadigmsEst.invA "valmis" ) ;
    -- Eng: I am scared
    -- Fin: Minua pelottaa (partitive)
    -- Est: Mina kardan (nominative)
    -- Est: Mul on hirm (nominative)
    -- AScared p = mkCl p.name (caseV nominative (mkV "kartma")) ;
    AScared p = E.AdvExistNP (SyntaxEst.mkAdv on_Prep p.name) (mkNP (mkN "hirm")) ;
    -- Fin: puhua: Puhun hollantia (partitive)
    -- Est: Mina räägin hollandi keelt (partitive)
    ASpeak p lang = mkCl p.name L.speak_V2 lang ;
    AThirsty p = E.AdvExistNP (SyntaxEst.mkAdv on_Prep p.name) (mkNP (mkN "janu")) ;
    -- Eng: I am tired
    -- Fin: Minua väsyttää. (partitive)
    -- Ger: Ich bin müde.
    -- Est: Mina olen väsinud.
    -- ATired p = mkCl p.name (caseV partitive (mkV "väsitada")) ;
    ATired p = mkCl p.name (ParadigmsEst.mkA "väsinud") ;
    AUnderstand p = mkCl p.name (mkV "aru" (mkV "saama")) ;
    AWant p obj = mkCl p.name (mkV2 "tahtma") obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
    QWhatAge p = mkQS (mkQCl (E.ICompAP (mkAP L.old_A)) p.name) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item maksma_V)) ;
    ItCost item price = mkCl item (mkV2 maksma_V) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ;
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ;
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ;
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ;


-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("kohtumiseni"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("kohtumiseni"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d =
      mkText (lin Text (ss ("kohtumiseni")))
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN "naine") ;
    Husband = xOf sing L.man_N ;
    Son = xOf sing (mkN "poeg" "poja" "poega" "poegadesse" "poegade" "poegi") ;
    Daughter = xOf sing (mkN "tütar" "tütre" "tütart" "tütresse" "tütarde" "tütreid") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDayPaev "esmas" ;
    Tuesday = mkDayPaev "teisi" ;
    Wednesday = mkDayPaev "kolma" ;
    Thursday = mkDayPaev "nelja" ;
    Friday = mkDay (mkPN (mkN "reede" "reede")) ("reedeti") ;
    Saturday = mkDayPaev "lau" ;
    Sunday = mkDayPaev "püha" ;

    Tomorrow = ParadigmsEst.mkAdv "homme" ;

-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y =
      mkQS (mkQCl far_IAdv (mkCl y.name x.from)) ;
    HowFarFromBy x y t =
      mkQS (mkQCl far_IAdv (mkCl y.name
        (mkVP (mkVP x.from) t))) ;
    HowFarBy place t =
      mkQS (mkQCl far_IAdv (mkCl place.name t)) ;
      -- mkQS (mkQCl (mkIAdv far_IAdv t) y.name) ;

    WhichTranspPlace trans place =
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkVP (mkVP (mkVP (mkV "saama")) trans.by) place.to))) ;
      -- pääseekö keskustaan bussilla
      -- mkQS (mkQCl (E.AdvPredNP place.to L.go_V (E.PartCN (trans.name)))) ;
      -- meneekö keskustaan bussia

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl (mkA (mkN "lähedal asuv") "lähem" "lähim") ;
    TheCheapest = mkSuperl (mkA "odav") ;
    TheMostExpensive = mkSuperl (mkA (mkN "kallis" "kalli" "kallist" "kallisse" "kallite" "kalleid")) ;
    TheMostPopular = mkSuperl (mkA "populaarne") ;
    TheWorst = mkSuperl (L.bad_A) ;

    SuperlPlace sup p = placeNP sup p ;

  oper
    kroon : N = mkN "kroon" "krooni" "krooni" "krooni" "kroonide" "kroone" ;
    kroon2 : Str -> N = \taani -> mkN (taani + " ") kroon ;
    maksma_V : V = mkV "maksma" "maksta" "maksab" ;

    mkNat : Str -> Str -> PN -> NPNationality
       = \attr,pred,co ->
        {lang = mkNP (mkCN (mkN (attr + " ") (mkN "keel" "keele" "keelt" "keelde" "keelte" "keeli")));
         prop = invA attr ;
         nat = mkA pred ;
         country = mkNP co
        } ;

    ---- using overloaded paradigms slows down compilation dramatically
    -- Eng: See you on Monday!
    -- Est: Kohtumiseni esmaspäeval! (adessive)
    -- Fin: Nähdään maanantaina! (essive)
    -- TODO: use StructuralEst.gf: on_Prep = casePrep adessive
    mkDay : PN -> Str -> {name : NP ; point : Adv ; habitual : Adv} = \d,s ->
      let day = mkNP d in
      {name = day ;
       point = SyntaxEst.mkAdv (casePrep adessive) day ;
       habitual = ParadigmsEst.mkAdv s
      } ;

    mkDayPaev : Str -> {name : NP ; point : Adv ; habitual : Adv} = \s ->
        mkDay (mkPN (mkN (s + "päev") (s + "päeva"))) (s + "päeviti") ;

    mkPlace : N -> Bool -> {name : CN ; at : Prep ; to : Prep; from : Prep ; isPl : Bool} = \p,e -> {
      name = mkCN p ;
      at = casePrep (if_then_else Case e adessive inessive) ;  -- True: external
      to = casePrep (if_then_else Case e allative illative) ;
      from = casePrep (if_then_else Case e ablative elative) ;
      isPl = False
   } ;

    ssa = False ;
    lla = True ;

    -- Ger-grammar uses this xOf (mis on nimi minu naise)
    -- xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ;

    -- (mis on minu naise nimi)
    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p ->
      relativePerson n (mkCN x) (\a,b,c -> mkNP (E.GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf sing L.name_N p).name ;

  oper
    -- do you have a table for five persons
    haveForPerson : NP -> CN -> Card -> Cl = \p,a,n ->
      mkCl p have_V2
----      (mkNP (E.PartCN a)  ---- partitive works in questions )
        (mkNP (mkNP a_Det a)
           (SyntaxEst.mkAdv for_Prep (mkNP n L.person_N))) ;
----       (SyntaxEst.mkAdv for_Prep (mkNP (mkDet n)))) ; -- 60s faster compile 25/10/2010

    open_Adv = ParadigmsEst.mkAdv "avatud" ;
    closed_Adv = ParadigmsEst.mkAdv "suletud" ;

    -- Fin: casePrep adessive
    -- Est: casePrep comitative
    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ;
      by = SyntaxEst.mkAdv (casePrep comitative) (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> mkDet the_Quant (mkOrd a) ;

    far_IAdv = E.IAdvAdv L.far_Adv ;

--------------------------------------------------
-- New 30/11/2011 AR
--------------------------------------------------

  lin
    Thai = mkNat ("tai") "tailane" (mkPN "Tai") ;
    Baht = mkCN (mkN "baht") ;

    Rice = mkCN (mkN "riis") ;
    Pork = mkCN (mkN "siga") ;
    Beef = mkCN (mkN "veis") ;
    Egg = mkCN L.egg_N ;
    Noodles = mkCN (mkN "nuudel") ;
    Shrimps = mkCN (mkN "krevet") ;
    Chili = mkCN (mkN "tšilli") ;
    Garlic = mkCN (mkN "küüs" (mkN "lauk")) ;
    Durian = mkCN (mkN "duurian") ;
    Mango = mkCN (mkN "mango") ;
    Pineapple = mkCN (mkN "ananass") ;
    Coke = mkCN (mkN "coca-cola") ;
    IceCream = mkCN (mkN "jäätis") ;
    Salad = mkCN (mkN "salat") ;
    OrangeJuice = mkCN (mkN "apelsiini" (mkN "mahl")) ;
    Lemonade = mkCN (mkN "limonaad") ;

    Beach = mkPlace (mkN "supel" (mkN "rand")) ssa ;

    ItsRaining = mkCl (mkVP L.rain_V0) ;
    ItsCold = mkCl (mkVP L.cold_A) ;
    ItsWarm = mkCl (mkVP L.warm_A) ;
    ItsWindy = mkCl (mkNP the_Det L.wind_N) (mkVP (mkV "puhuma")) ;
    SunShine = mkCl (mkNP the_Det L.sun_N) (mkVP (mkV "paistma")) ;

    Smoke = mkVP (mkV "suitsetama") ;

    ADoctor = mkProfession (mkN "arst") ;
    AProfessor = mkProfession (mkN "professor") ;
    ALawyer = mkProfession (mkN "jurist") ;
    AEngineer =  mkProfession (mkN "insener") ;
    ATeacher = mkProfession (mkN "õpetaja") ;
    ACook = mkProfession (mkN "kokk") ;
    AStudent = mkProfession (mkN "õpilane") ;
    ABusinessman = mkProfession (mkN "äri" L.man_N) ;

  oper
    mkProfession : N -> NPPerson -> Cl = \n,p -> mkCl p.name n ;
}
