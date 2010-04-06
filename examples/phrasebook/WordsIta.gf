-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete WordsIta of Words = SentencesIta ** open
  SyntaxIta,
  BeschIta,
  (E = ExtraIta),
  (L = LexiconIta),
  (P = ParadigmsIta), 
  ParadigmsIta in {

lin

Wine = mkCN (mkN "vino") ;
    Beer = mkCN (mkN "birra") ;
    Water = mkCN (mkN "acqua") ;
    Coffee = mkCN (mkN "caffè") ;
   Tea = mkCN (mkN "tè") ;

Cheese = mkCN (mkN "formaggio") ;
Fish = mkCN (mkN "pesce") ;
Pizza = mkCN (mkN "pizza") ;

Fresh = mkA "fresco" ;
Warm = mkA "caldo" ;
Expensive = mkA "caro" ;
Delicious = mkA "delizioso" ;
Boring = mkA "noioso" ;
Good = prefixA (mkA "buono" "buona" "buoni" "buone" "bene") ;

    Restaurant = mkPlace (mkN "ristorante") P.in_Prep ;
    Bar = mkPlace (mkN "bar") P.in_Prep ;
    Toilet = mkPlace (mkN "bagno") P.in_Prep ;
    Museum = mkPlace (mkN "museo") P.in_Prep ;
    Airport = mkPlace (mkN "aeroporto") dative ;
    Station = mkPlace (mkN "stazione" feminine) dative ;
    Hospital = mkPlace (mkN "ospedale") P.in_Prep ;
    Church = mkPlace (mkN "chiesa") P.in_Prep ;

    Euro = mkCN (mkN "euro" "euro" masculine) ;
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "lei") ; ---- ?

    English = mkNat "inglese" "Inghilterra" ;
    Finnish = mkNat "finlandese" "Finlandia" ;
    French = mkNat "francese" "Francia" ; 
    Italian = mkNat "italiano" "Italia" ;
    Romanian = mkNat "rumeno" "Romania" ;
    Swedish = mkNat "svedese" "Svezia" ;

    Belgian = mkA "belgo" ;
    Flemish = mkNP (mkPN "fiammingo") ;
    Belgium = mkNP (mkPN "Belgio") ;

    Monday = mkDay "lunedì" ;
    Tuesday = mkDay "martedì" ;
    Wednesday = mkDay "mercoledì" ;
    Thursday = mkDay "giovedì" ;
    Friday = mkDay "venerdì" ;
    Saturday = mkDay "sabato" ;
    Sunday = mkDay "domenica" ;

    AWant p obj = mkCl p.name (mkV2 (mkV (volere_96 "volere"))) obj ;
    ALike p item = mkCl item (mkV2 (mkV (piacere_64 "piacere")) dative) p.name ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "parlare")) lang ;
    ALove p q = mkCl p.name (mkV2 (mkV "amare")) q.name ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "fame" feminine))) ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
    ATired p = mkCl p.name (mkA "stanco") ;
    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;
    AIll p = mkCl p.name (mkA "malato") ;
    AUnderstand p = mkCl p.name (mkV "capire") ;
    AKnow p = mkCl p.name (mkV (sapere_78 "sapere")) ;
    AWantGo p place = 
      mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;
    AHasName p name = mkCl p.name (mkV2 (reflV (mkV "chiamare"))) name ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (mkV "abitare")) 
        (SyntaxIta.mkAdv P.in_Prep co)) ;

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "chiamare")))) ;

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "costare"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "costare")) price ;

  oper
    mkNat : Str -> Str -> {lang : NP ; prop : A ; country : NP} = \nat,co -> 
      {lang = mkNP (mkPN nat) ; prop = mkA nat ; country = mkNP (mkPN co)} ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      {name = day ; 
       point, -- = ParadigmsIta.mkAdv d ; 
       habitual = ParadigmsIta.mkAdv ("il" ++ d) ; ---- ?
      } ;

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN p ;
      at = i ;
      to = dative
      } ;

    open_A = mkA "aperto" ;
    closed_A = mkA "chiuso" ;


}
