-- (c) 2009 Aarne Ranta under LGPL

concrete WordsFin of Words = SentencesFin ** 
  open 
    SyntaxFin, ParadigmsFin, (L = LexiconFin), 
    Prelude, (E = ExtraFin) in {

  lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "juusto") ;
    Chicken = mkCN (mkN "kana") ;
    Coffee = mkCN (mkN "kahvi") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "liha") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "tee") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- qualities

    Bad = L.bad_A ;
    Boring = mkA "tylsä" ;
    Cheap = mkA "halpa" ;
    Cold = L.cold_A ;
    Delicious = mkA "herkullinen" ;
    Expensive = mkA "kallis" ;
    Fresh = mkA "tuore" ;
    Good = L.good_A ;
    Suspect = mkA "epäilyttävä" ;
    Warm = L.warm_A ;

-- places

    Restaurant = mkPlace (mkN "ravintola") ssa ;
    Bar = mkPlace (mkN "baari") ssa ;
    Toilet = mkPlace (mkN "vessa") ssa ;
    Museum = mkPlace (mkN "museo") ssa ;
    Airport = mkPlace (mkN "lento" (mkN "kenttä")) lla ;
    Station = mkPlace (mkN "asema") lla ;
    Hospital = mkPlace (mkN "sairaala") ssa ;
    Church = mkPlace (mkN "kirkko") ssa ;
    Shop = mkPlace (mkN "kauppa") ssa ;
    Park = mkPlace (mkN "puisto") ssa ;
    Hotel = mkPlace (mkN "hotelli") ssa ;
    University = mkPlace (mkN "yliopisto") lla ;
    School = mkPlace (mkN "koulu") lla ;

-- currencies

    Dollar = mkCN (mkN "dollari") ;
    Euro = mkCN (mkN "euro") ;
    Lei = mkCN (mkN "lei") ;

-- nationalities

    Belgian = mkA "belgialainen" ;
    Belgium = mkNP (mkPN "Belgia") ;
    English = mkNat (mkPN "englanti") (mkPN "Englanti") (mkA "englantilainen") ;
    Finnish = 
      mkNat (mkPN (mkN "suomi" "suomia")) (mkPN (mkN "Suomi" "Suomia")) 
            (mkA "suomalainen") ;
    Flemish = mkNP (mkPN "flaami") ;
    French = mkNat (mkPN "ranska") (mkPN "Ranska") (mkA "ranskalainen") ; 
    Italian = mkNat (mkPN "italia") (mkPN "Italia") (mkA "italialainen") ;
    Romanian = mkNat (mkPN "romania") (mkPN "Romania") (mkA "romanialainen") ;
    Swedish = mkNat (mkPN "ruotsi") (mkPN "Ruotsi") (mkA "ruotsalainen") ;

    ---- it would be nice to have a capitalization Predef function

-- actions

    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name have_V2 (mkNP (mkN "nälkä")) ;
    AIll p = mkCl p.name (mkA "sairas") ;
    AKnow p = mkCl p.name (mkV "tietää") ;
    ALike p item = mkCl p.name L.like_V2 item ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "asua")) (SyntaxFin.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "rakastaa") partitive) q.name ;
    AScared p = mkCl p.name (caseV partitive (mkV "pelottaa")) ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "puhua") partitive) lang ;
    AThirsty p = mkCl p.name have_V2 (mkNP (mkN "jano")) ;
    ATired p = mkCl p.name (caseV partitive (mkV "väsyttää")) ;
    AUnderstand p = mkCl p.name (mkV "ymmärtää") ;
    AWant p obj = mkCl p.name (mkV2 "haluta") obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "maksaa"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "maksaa")) price ;

-- week days

    Monday = let d = "maanantai" in mkDay (mkPN d) (d + "sin") ;
    Tuesday = let d = "tiistai" in mkDay (mkPN d) (d + "sin") ;
    Wednesday = let d = "keskiviikko" in mkDay (mkPN d) (d + "isin") ;
    Thursday = let d = "torstai" in mkDay (mkPN d) (d + "sin") ;
    Friday = let d = "perjantai" in mkDay (mkPN d) (d + "sin") ;
    Saturday = let d = "lauantai" in mkDay (mkPN d) (d + "sin") ;
    Sunday = let d = "sunnuntai" in mkDay (mkPN d) (d + "sin") ;

  oper
    mkNat : PN -> PN -> A -> 
      {lang : NP ; prop : A ; country : NP} = \nat,co,pro ->
        {lang = mkNP nat ; 
         prop = pro ;
         country = mkNP co
        } ;

    ---- using overloaded paradigms slows down compilation dramatically
    mkDay : PN -> Str -> {name : NP ; point : Adv ; habitual : Adv} = \d,s ->
      let day = mkNP d in
      {name = day ; 
       point = SyntaxFin.mkAdv (casePrep essive) day ; 
       habitual = ParadigmsFin.mkAdv s
      } ;

    mkPlace : N -> Bool -> {name : CN ; at : Prep ; to : Prep} = \p,e -> {
      name = mkCN p ;
      at = casePrep (if_then_else Case e adessive inessive) ;  -- True: external
      to = casePrep (if_then_else Case e allative illative) ;
      } ;
    ssa = False ;
    lla = True ;

    open_Adv = ParadigmsFin.mkAdv "avoinna" ;
    closed_Adv = ParadigmsFin.mkAdv "kiinni" ;

    nameOf : {name : NP ; isPron : Bool ; poss : Det} -> NP = \p -> 
      let nimi = L.name_N in
      case p.isPron of {
        True => mkNP p.poss nimi ;
        _    => mkNP (E.GenNP p.name) nimi
        } ; 

}
