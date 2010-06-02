-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete WordsFre of Words = SentencesFre ** open
  SyntaxFre,
  IrregFre,
  (E = ExtraFre),
  (L = LexiconFre),
  ParadigmsFre,
  (M = MorphoFre),
  (P = ParadigmsFre),
  Prelude in {


lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "fromage" masculine) ;
    Chicken = mkCN (mkN "poulet") ;
    Coffee = mkCN (mkN "café") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "viande") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza" feminine) ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "thé") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Boring = mkA "ennuyeux" ;
    Cheap = let bm = "bon marché" in mkA bm bm bm bm ;
    Cold = L.cold_A ;
    Delicious = mkA "délicieux" ;
    Expensive = mkA "cher" ;
    Fresh = mkA "frais" "fraîche" "frais" "fraîchement" ;
    Good = L.good_A ;
    Suspect = mkA "suspect" ;
    Warm = L.warm_A ;

-- places

    Airport = mkPlace (mkN "aéroport") dative ;
    AmusementPark = mkPlace (compN (mkN "parc") ["d'attractions"]) dative ;
    Bank = mkPlace (mkN "banque") dative ;
    Bar = mkPlace (mkN "bar") dative ;
    Cafeteria = mkPlace (mkN "cafétéria") dative ;
    Center = mkPlace (mkN "centre" "centres" ParadigmsFre.masculine) dative ;
    Church = mkPlace (mkN "église") dative ;
    Cinema = mkPlace (mkN "cinéma" masculine) dative ;
    Disco = mkPlace (mkN "discothèque" feminine) dative ;
    Hospital = mkPlace (mkN "hôpital") dative ;
    Hotel = mkPlace (mkN "hôtel") dative ;
    Museum = mkPlace (mkN "musée" masculine) dative ;
    Park = mkPlace (mkN "parc") dative ;
    Parking = mkPlace (mkN "parking" masculine) dative ;
    Pharmacy = mkPlace (mkN "pharmacie" feminine) dative ;
    PostOffice = mkPlace (mkN "poste" feminine) dative ;
    Pub = mkPlace (mkN "pub" masculine) dative ;
    Restaurant = mkPlace (mkN "restaurant") dative ;
    School = mkPlace (mkN "école") dative ;
    Shop = mkPlace (mkN "magasin") dative ;
    Station = mkPlace (mkN "gare") dative ;
    Supermarket = mkPlace (mkN "supermarché" masculine) dative ;
    Theatre = mkPlace (mkN "théâtre" masculine) dative ;
    Toilet = mkCNPlacePl (mkCN (mkN "toilette")) dative dative; 
    University = mkPlace (mkN "université" feminine) dative ;
    Zoo = mkPlace (mkN "zoo" masculine) dative ;

    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restaurant")) dative to_Prep ;

-- currencies

    DanishCrown = mkCN (mkA "danois") (mkN "couronne") | mkCN (mkN "couronne") ;
    Dollar = mkCN (mkN "dollar") ;
    Euro = mkCN (mkN "euro") ;
    Lei = mkCN (mkN "leu" "lei" masculine) ;
    Leva = mkCN (mkN "lev" "leva" masculine);
    NorwegianCrown = mkCN (mkA "norvégien") (mkN "couronne") | mkCN (mkN "couronne") ;
    Pound = mkCN (compN (mkN "livre") ["sterling"]);
    Rouble = mkCN (mkN "rouble" "rouble" masculine) ;
    SwedishCrown = mkCN (mkA "suédois") (mkN "couronne") | mkCN (mkN "couronne") ;
    Zloty = mkCN (mkN "zloty" "zlotych" masculine) ;
   
-- nationalities

    Belgian = mkA "belge" ;
    Belgium = mkNP (mkPN "Belgique") ;
    Bulgarian = mkNat "bulgare" "Bulgarie" ;
    Catalan = mkNat "catalan" "Catalogne" ;
    Danish = mkNat "danois" "Danemark" ;
    Dutch = mkNat "hollandais" "Holland" ;
    English = mkNat "anglais" "Angleterre" ;
    Finnish = mkNat "finlandais" "Finlande" ;
    Flemish = mkNP (mkPN "flamand") ;
    French = mkNat "français" "France" ; 
    German = mkNat "allemand" "Allemagne" ;
    Italian = mkNat "italien" "Italie" ;
    Norwegian = mkNat "norvégien" "Norvège" ;
    Polish = mkNat "polonais" "Pologne" ;
    Romanian = mkNat "roumain" "Roumanie" ;
    Russian = mkNat "russe" "Russie" ;
    Spanish = mkNat "espagnol" "Espagne" ;
    Swedish = mkNat "suédois" "Suède" ;

-- means of transportation
  
   Bike = mkTransport en_Prep L.bike_N ;
   Bus = mkTransport par_Prep (mkN "bus") ;
   Car = mkTransport en_Prep L.car_N ;
   Ferry = mkTransport en_Prep (mkN "ferry") ;
   Plane = mkTransport par_Prep L.airplane_N ;
   Subway = mkTransport par_Prep (mkN "métro") ;
   Taxi = mkTransport en_Prep (mkN "taxi") ;
   Train = mkTransport par_Prep (mkN "train") ;
   Tram = mkTransport par_Prep (mkN "tram") ;

   ByFoot = P.mkAdv "à pied" ;


-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "chambre")) 
        (SyntaxFre.mkAdv for_Prep (mkNP num (mkN "personne")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "table")) 
        (SyntaxFre.mkAdv for_Prep (mkNP num (mkN "personne")))) ;
    AMarried p = mkCl p.name (mkA "marié") ;
    AWant p obj = mkCl p.name vouloir_V2 obj ;
    ALike p item = mkCl item plaire_V2 p.name ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "parler")) lang ;
    ALove p q = mkCl p.name (mkV2 (mkV "aimer")) q.name ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "faim" feminine))) ;
    AReady p = mkCl p.name (mkA "prêt") ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "soif" feminine))) ;
    ATired p = mkCl p.name (mkA "fatigué") ;
    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "peur" feminine))) ;
    AIll p = mkCl p.name (mkA "malade") ;
    AUnderstand p = mkCl p.name (mkV IrregFre.comprendre_V2) ;
    AKnow p = mkCl p.name (mkV IrregFre.savoir_V2) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;
    AHasName p name = mkCl p.name (mkV2 (reflV (mkV "appeler"))) name ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "habiter")) (SyntaxFre.mkAdv (mkPrep "en") co)) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "appeler")))) ;
    QWhatAge p = mkQS (mkQCl (mkIP whichSg_IDet (mkN "âge" masculine)) p.name have_V2) ; 

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "coûter"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "coûter")) price ;

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;


    PSeeYouPlace d = mkText (lin Text (ss ("on se voit"))) (mkPhrase (mkUtt d.at)) ;
    PSeeYouDate d = mkText (lin Text (ss ("on se voit"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("on se voit"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.


    Wife = xOf sing (mkN "femme") ;
    Husband = xOf sing (mkN "mari") ;
    Son = xOf sing (mkN "fils") ;
    Daughter = xOf sing (mkN "fille") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "lundi" ;
    Tuesday = mkDay "mardi" ;
    Wednesday = mkDay "mercredi" ;
    Thursday = mkDay "jeudi" ;
    Friday = mkDay "vendredi" ;
    Saturday = mkDay "samedi" ;
    Sunday = mkDay "dimanche" ;

    Tomorrow = ParadigmsFre.mkAdv "demain" ;

-- modifiers of places
    TheBest = mkSuperl True L.good_A ;
    TheClosest = mkSuperl False L.near_A ; 
    TheCheapest = mkSuperl False 
      (compADeg {s = \\_ => (M.mkAdj "bon marché" "bon marché" "bon marché" "bon marché").s ; 
       isPre = False ; lock_A = <>}) ; 
    TheMostExpensive = mkSuperl False (mkA "cher") ;
    TheMostPopular = mkSuperl False (mkA "populaire") ;
    TheWorst = mkSuperl True L.bad_A ;

    SuperlPlace sup kind = 
      let 
        det  : Det = mkDet the_Art sup.s ;
        name : NP  = case sup.isPre of {
          True  => mkNP det kind.name ;                      -- le meilleur bar
          False => mkNP the_Art (mkCN kind.name (mkNP det))  -- le bar le plus cher
          } 
      in {
        name = name ;
        at = SyntaxFre.mkAdv kind.at name ;
        to = SyntaxFre.mkAdv kind.to name
      } ;

-- transports

    HowFar place = mkQS (mkQCl what_distance_IAdv place.name) ; 
    HowFarFrom place x = 
      mkQS (mkQCl (E.CompIQuant which_IQuant) 
        (mkNP (mkNP distance_NP (SyntaxFre.mkAdv from_Prep x.name)) place.to)) ; 
    HowFarFromBy place x t = 
      mkQS (mkQCl (E.CompIQuant which_IQuant) 
        (mkNP (mkNP (mkNP distance_NP (SyntaxFre.mkAdv from_Prep x.name)) place.to) t)) ; 
    HowFarBy place t = 
       mkQS (mkQCl what_distance_IAdv (mkNP place.name t)) ; 
     
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      lin QS {s = \\_ => (E.EstcequeS (mkS (mkCl (mkCN trans.name (SyntaxFre.mkAdv for_Prep place.name))))).s} ;
      --      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;

  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      mkNPDay day (P.mkAdv d) (P.mkAdv ("le" ++ d)) ;

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i ->
      mkCNPlace (mkCN p) i dative ;

    open_A = P.mkA "ouvert" ;
    closed_A = P.mkA "fermé" ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

    mkTransport : Prep -> N -> {name : CN ; by : Adv} = \p,n -> {
      name = mkCN n ; 
      by = E.PrepCN p n  -- par train, en vélo
      } ;

    en_Prep = mkPrep "en" ;
    par_Prep = mkPrep "par" ;

  mkSuperl : Bool -> A -> {s : Ord ; isPre : Bool} = \b,a ->
     {s = SyntaxFre.mkOrd a ; isPre = b} ;

    
    what_distance_IAdv = ss "à quelle distance"**{lock_IAdv=<>};
    
    distance_NP : NP = mkNP the_Det (mkN "distance" feminine) ;


}
