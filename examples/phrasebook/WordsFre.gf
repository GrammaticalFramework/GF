-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete WordsFre of Words = SentencesFre ** open
  SyntaxFre,
  IrregFre,
  (E = ExtraFre),
  ParadigmsFre,
  (P = ParadigmsFre) in {

lin

Wine = mkCN (mkN "vin") ;
    Beer = mkCN (mkN "bière") ;
    Water = mkCN (mkN "eau" feminine) ;
    Coffee = mkCN (mkN "café") ;
    Tea = mkCN (mkN "thé") ;

Cheese = mkCN (mkN "fromage" masculine) ;
Fish = mkCN (mkN "poisson" masculine) ;
Pizza = mkCN (mkN "pizza" feminine) ;

Fresh = mkA "frais" "fraîche" "frais" "fraîchement" ;
Warm = mkA "chaud" ;
Expensive = mkA "cher" ;
Delicious = mkA "délicieux" ;
Boring = mkA "ennuyeux" ;
Good = prefixA (mkA "bon" "bonne" "bons" "bien") ;

    Restaurant = mkPlace (mkN "restaurant") in_Prep ;
    Bar = mkPlace (mkN "bar") in_Prep ;
    Toilet = mkPlace (mkN "toilette") in_Prep ;
    Museum = mkPlace (mkN "musée" masculine) in_Prep ;
    Airport = mkPlace (mkN "aéroport") dative ;
    Station = mkPlace (mkN "gare") dative ;
    Hospital = mkPlace (mkN "hôpital") dative ;
    Church = mkPlace (mkN "église") in_Prep ;

    Euro = mkCN (mkN "euro") ;
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "leu" "lei" masculine) ;

    English = mkNat "anglais" "Angleterre" ;
    Finnish = mkNat "finlandais" "Finlande" ;
    French = mkNat "français" "France" ; 
    Italian = mkNat "italien" "Italie" ;
    Romanian = mkNat "roumain" "Roumanie" ;
    Swedish = mkNat "suédois" "Suède" ;

    Belgian = mkA "belge" ;
    Flemish = mkNP (mkPN "flamand") ;
    Belgium = mkNP (mkPN "Belgique") ;

    Monday = mkDay "lundi" ;
    Tuesday = mkDay "mardi" ;
    Wednesday = mkDay "mercredi" ;
    Thursday = mkDay "jeudi" ;
    Friday = mkDay "vendredi" ;
    Saturday = mkDay "samedi" ;
    Sunday = mkDay "dimanche" ;

    AWant p obj = mkCl p.name vouloir_V2 obj ;
    ALike p item = mkCl item plaire_V2 p.name ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "parler")) lang ;
    ALove p q = mkCl p.name (mkV2 (mkV "aimer")) q.name ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "faim" feminine))) ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "soif" feminine))) ;
    ATired p = mkCl p.name (mkA "fatigué") ;
    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "peur" feminine))) ;
    AIll p = mkCl p.name (mkA "malade") ;
    AUnderstand p = mkCl p.name (mkV IrregFre.comprendre_V2) ;
    AKnow p = mkCl p.name (mkV IrregFre.savoir_V2) ;
    AWantGo p place = 
      mkCl p.name want_VV (mkVP (mkVP IrregFre.aller_V) place.to) ;
    AHasName p name = mkCl p.name (mkV2 (reflV (mkV "appeler"))) name ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (mkV "habiter")) 
        (SyntaxFre.mkAdv (mkPrep "en") co)) ;

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "appeler")))) ;

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "coûter"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "coûter")) price ;

  oper
    mkNat : Str -> Str -> {lang : NP ; prop : A ; country : NP} = \nat,co -> 
      {lang = mkNP (mkPN nat) ; prop = mkA nat ; country = mkNP (mkPN co)} ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      {name = day ; 
       point = P.mkAdv d ; 
       habitual = P.mkAdv ("le" ++ d) ;
      } ;

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN p ;
      at = i ;
      to = dative
      } ;

    open_A = P.mkA "ouvert" ;
    closed_A = P.mkA "fermé" ;

}
