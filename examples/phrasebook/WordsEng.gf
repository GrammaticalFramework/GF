-- (c) 2009 Aarne Ranta under LGPL

concrete WordsEng of Words = SentencesEng ** 
    open 
      SyntaxEng, ParadigmsEng, (P = ParadigmsEng), 
      IrregEng, Prelude in {
  lin
    Wine = mkCN (mkN "wine") ;
    Beer = mkCN (mkN "beer") ;
    Water = mkCN (mkN "water") ;
    Coffee = mkCN (mkN "coffee") ;
    Tea = mkCN (mkN "tea") ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "cheese") ;
    Fish = mkCN (mkN "fish" "fish") ;
    Fresh = mkA "fresh" ;
    Warm = mkA "warm" ;
    Expensive = mkA "expensive" ;
    Delicious = mkA "delicious" ;
    Boring = mkA "boring" ;
    Good = mkA "good" "better" "best" "well" ;

    Restaurant = mkPlace "restaurant" "in" ;
    Bar = mkPlace "bar" "in" ;
    Toilet = mkPlace "toilet" "in" ;
    Museum = mkPlace "museum" "in" ;
    Airport = mkPlace "airport" "at" ;
    Station = mkPlace "station" "at" ;
    Hospital = mkPlace "hospital" "in" ;
    Church = mkPlace "church" "in" ;

    Euro = mkCN (mkN "euro" "euros") ; -- to prevent euroes
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "leu" "lei") ;

    English = mkNat "English" "England" ;
    Finnish = mkNat "Finnish" "Finland" ;
    French = mkNat "French" "France" ; 
    Italian = mkNat "Italian" "Italy" ;
    Romanian = mkNat "Romanian" "Romania" ;
    Swedish = mkNat "Swedish" "Sweden" ;

    Belgian = mkA "Belgian" ;
    Flemish = mkNP (mkPN "Flemish") ;
    Belgium = mkNP (mkPN "Belgium") ;

    Monday = mkDay "Monday" ;
    Tuesday = mkDay "Tuesday" ;
    Wednesday = mkDay "Wednesday" ;
    Thursday = mkDay "Thursday" ;
    Friday = mkDay "Friday" ;
    Saturday = mkDay "Saturday" ;
    Sunday = mkDay "Sunday" ;

    AWant p obj = mkCl p.name (mkV2 (mkV "want")) obj ;
    ALike p item = mkCl p.name (mkV2 (mkV "like")) item ;
    ASpeak p lang = mkCl p.name  (mkV2 IrregEng.speak_V) lang ;
    ALove p q = mkCl p.name (mkV2 (mkV "love")) q.name ;
    AHungry p = mkCl p.name (mkA "hungry") ;
    AThirsty p = mkCl p.name (mkA "thirsty") ;
    ATired p = mkCl p.name (mkA "tired") ;
    AScared p = mkCl p.name (mkA "scared") ;
    AIll p = mkCl p.name (mkA "ill") ;
    AUnderstand p = mkCl p.name IrregEng.understand_V ;
    AKnow p = mkCl p.name IrregEng.know_V ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP IrregEng.go_V) place.to) ;
    AHasName p name = mkCl (nameOf p) name ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (mkV "live")) (SyntaxEng.mkAdv in_Prep co)) ;

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregEng.cost_V)) ; 
    ItCost item price = mkCl item (mkV2 IrregEng.cost_V) price ;
 
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
