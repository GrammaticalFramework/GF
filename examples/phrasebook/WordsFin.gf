-- (c) 2009 Aarne Ranta under LGPL

concrete WordsFin of Words = SentencesFin ** 
  open 
    SyntaxFin, ParadigmsFin, (L = LangFin), 
    Prelude, (E = ExtraFin) in {
  lin
    Wine = mkCN (mkN "viini") ;
    Beer = mkCN (mkN "olut" "oluita") ;
    Water = mkCN (mkN "vesi" "veden" "vesiä") ;
    Coffee = mkCN (mkN "kahvi") ;
    Tea = mkCN (mkN "tee") ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "juusto") ;
    Fish = mkCN (mkN "kala") ;

    Fresh = mkA "tuore" ;
    Warm = mkA 
    (mkN "lämmin" "lämpimän" "lämmintä" "lämpimänä" "lämpimään" 
         "lämpiminä" "lämpimiä" "lämpimien" "lämpimissä" "lämpimiin"
	 ) 
    "lämpimämpi" "lämpimin" ;
    Expensive = mkA "kallis" ;
    Delicious = mkA "herkullinen" ;
    Boring = mkA "tylsä" ;
    Good = mkA (mkN "hyvä") "parempi" "paras" ; ---- comparisons?

    Restaurant = mkPlace (mkN "ravintola") False ;
    Bar = mkPlace (mkN "baari") False ;
    Toilet = mkPlace (mkN "vessa") False ;
    Museum = mkPlace (mkN "museo") False ;
    Airport = mkPlace (mkN "lento" (mkN "kenttä")) True ;
    Station = mkPlace (mkN "asema") True ;
    Hospital = mkPlace (mkN "sairaala") False ;
    Church = mkPlace (mkN "kirkko") False ;

    Euro = mkCN (mkN "euro") ;
    Dollar = mkCN (mkN "dollari") ;
    Lei = mkCN (mkN "lei") ;

    ---- it would be nice to have a capitalization Predef function
    English = mkNat (mkPN "englanti") (mkPN "Englanti") (mkA "englantilainen") ;
    Finnish = 
      mkNat (mkPN (mkN "suomi" "suomia")) (mkPN (mkN "Suomi" "Suomia")) 
            (mkA "suomalainen") ;
    French = mkNat (mkPN "ranska") (mkPN "Ranska") (mkA "ranskalainen") ; 
    Italian = mkNat (mkPN "italia") (mkPN "Italia") (mkA "italialainen") ;
    Romanian = mkNat (mkPN "romania") (mkPN "Romania") (mkA "romanialainen") ;
    Swedish = mkNat (mkPN "ruotsi") (mkPN "Ruotsi") (mkA "ruotsalainen") ;

    Belgian = mkA "belgialainen" ;
    Flemish = mkNP (mkPN "flaami") ;
    Belgium = mkNP (mkPN "Belgia") ;

    Monday = let d = "maanantai" in mkDay (mkPN d) (d + "sin") ;
    Tuesday = let d = "tiistai" in mkDay (mkPN d) (d + "sin") ;
    Wednesday = let d = "keskiviikko" in mkDay (mkPN d) (d + "isin") ;
    Thursday = let d = "torstai" in mkDay (mkPN d) (d + "sin") ;
    Friday = let d = "perjantai" in mkDay (mkPN d) (d + "sin") ;
    Saturday = let d = "lauantai" in mkDay (mkPN d) (d + "sin") ;
    Sunday = let d = "sunnuntai" in mkDay (mkPN d) (d + "sin") ;

    AWant p obj = mkCl p.name (mkV2 "haluta") obj ;
    ALike p item = mkCl p.name L.like_V2 item ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "puhua") partitive) lang ;
    ALove p q = mkCl p.name (mkV2 (mkV "rakastaa") partitive) q.name ;
    AHungry p = mkCl p.name have_V2 (mkNP (mkN "nälkä")) ;
    AThirsty p = mkCl p.name have_V2 (mkNP (mkN "jano")) ;
    ATired p = mkCl p.name (caseV partitive (mkV "väsyttää")) ;
    AScared p = mkCl p.name (caseV partitive (mkV "pelottaa")) ;
    AIll p = mkCl p.name (mkA "sairas") ;
    AUnderstand p = mkCl p.name (mkV "ymmärtää") ;
    AKnow p = mkCl p.name (mkV "tietää") ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;
    AHasName p name = mkCl (nameOf p) name ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (mkV "asua")) (SyntaxFin.mkAdv in_Prep co)) ;

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "maksaa"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "maksaa")) price ;

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

    open_Adv = ParadigmsFin.mkAdv "avoinna" ;
    closed_Adv = ParadigmsFin.mkAdv "kiinni" ;

    nameOf : {name : NP ; isPron : Bool ; poss : Det} -> NP = \p -> 
      mkNP (E.GenNP p.name) (mkN "nimi" "nimiä") ; 

}
