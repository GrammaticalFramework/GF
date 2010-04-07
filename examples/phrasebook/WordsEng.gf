-- (c) 2009 Aarne Ranta under LGPL

concrete WordsEng of Words = SentencesEng ** 
    open 
      SyntaxEng, ParadigmsEng, (L = LexiconEng), (P = ParadigmsEng), 
      IrregEng, Prelude in {
  lin
    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Milk = mkCN L.milk_N ;
    Salt = mkCN L.salt_N ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;
    Coffee = mkCN (mkN "coffee") ;
    Tea = mkCN (mkN "tea") ;
    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "cheese") ;
    Chicken = mkCN (mkN "chicken") ;
    Meat = mkCN (mkN "meat") ;
    Fish = mkCN L.fish_N ;

    Fresh = mkA "fresh" ;
    Warm = L.warm_A ;
    Expensive = mkA "expensive" ;
    Delicious = mkA "delicious" ;
    Boring = mkA "boring" ;
    Good = L.good_A ;
    Bad = L.bad_A ;
    Cold = L.cold_A ;
    Cheap = mkA "cheap" ;
    Suspect = mkA "suspect" ;

    Fresh = mkA "fresh" ;
    Warm = L.warm_A ;
    Expensive = mkA "expensive" ;
    Delicious = mkA "delicious" ;
    Boring = mkA "boring" ;
    Good = L.good_A ;
    Bad = L.bad_A ;
    Cold = L.cold_A ;
    Cheap = mkA "cheap" ;
    Suspect = mkA "suspect" ;

    Airport = mkPlace "airport" "at" ;
    Bar = mkPlace "bar" "in" ;
    Church = mkPlace "church" "in" ;
    Cinema = mkPlace "cinema" "at" ;
    Hospital = mkPlace "hospital" "in" ;
    Hotel = mkPlace "hotel" "in" ;
    Museum = mkPlace "museum" "in" ;
    Park = mkPlace "park" "in" ;
    Restaurant = mkPlace "restaurant" "in" ;
    School = mkPlace "school" "at" ;
    Shop = mkPlace "shop" "in" ;
    Station = mkPlace "station" "at" ;
    Theatre = mkPlace "theatre" "at" ;
    Toilet = mkPlace "toilet" "in" ;
    University = mkPlace "university" "at" ;

    DanishCrown = mkCN (mkA "Danish") (mkN "crown") ;
    Dollar = mkCN (mkN "dollar") ;
    Euro = mkCN (mkN "euro" "euros") ; -- to prevent euroes
    Lei = mkCN (mkN "leu" "lei") ;
    SwedishCrown = mkCN (mkA "Swedish") (mkN "crown") ;

    Belgian = mkA "Belgian" ;
    Belgium = mkNP (mkPN "Belgium") ;
    English = mkNat "English" "England" ;
    Finnish = mkNat "Finnish" "Finland" ;
    Flemish = mkNP (mkPN "Flemish") ;
    French = mkNat "French" "France" ; 
    Italian = mkNat "Italian" "Italy" ;
    Romanian = mkNat "Romanian" "Romania" ;
    Swedish = mkNat "Swedish" "Sweden" ;

    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA "hungry") ;
    AIll p = mkCl p.name (mkA "ill") ;
    AKnow p = mkCl p.name IrregEng.know_V ;
    ALike p item = mkCl p.name (mkV2 (mkV "like")) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "live")) (SyntaxEng.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "love")) q.name ;
    AScared p = mkCl p.name (mkA "scared") ;
    ASpeak p lang = mkCl p.name  (mkV2 IrregEng.speak_V) lang ;
    AThirsty p = mkCl p.name (mkA "thirsty") ;
    ATired p = mkCl p.name (mkA "tired") ;
    AUnderstand p = mkCl p.name IrregEng.understand_V ;
    AWant p obj = mkCl p.name (mkV2 (mkV "want")) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP IrregEng.go_V) place.to) ;

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregEng.cost_V)) ; 
    ItCost item price = mkCl item (mkV2 IrregEng.cost_V) price ;

    Monday = mkDay "Monday" ;
    Tuesday = mkDay "Tuesday" ;
    Wednesday = mkDay "Wednesday" ;
    Thursday = mkDay "Thursday" ;
    Friday = mkDay "Friday" ;
    Saturday = mkDay "Saturday" ;
    Sunday = mkDay "Sunday" ;
 
  oper
    mkNat : Str -> Str -> {lang : NP ; prop : A ; country : NP} = \nat,co -> 
      {lang = mkNP (mkPN nat) ; prop = mkA nat ; country = mkNP (mkPN co)} ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      {name = day ; 
       point = SyntaxEng.mkAdv on_Prep day ; 
       habitual = SyntaxEng.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))
      } ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN (mkN p) ;
      at = P.mkPrep i ;
      to = to_Prep
      } ;

    open_Adv = P.mkAdv "open" ;
    closed_Adv = P.mkAdv "closed" ;

    nameOf : {name : NP ; isPron : Bool ; poss : Det} -> NP = \p -> 
      case p.isPron of {
        True => mkNP p.poss (mkN "name") ;
        _    => mkNP (mkNP the_Det (mkN "name")) 
                       (SyntaxEng.mkAdv possess_Prep p.name)
        } ;

}
