-- (c) 2009 Aarne Ranta under LGPL

concrete WordsSwe of Words = SentencesSwe ** 
    open SyntaxSwe, ParadigmsSwe, IrregSwe, Prelude in {
  lin
    Wine = mkCN (mkN "vin" "vinet" "viner" "vinerna") ;
    Beer = mkCN (mkN "öl" neutrum) ;
    Water = mkCN (mkN "vatten" "vattnet" "vatten" "vattnen") ;
    Coffee = mkCN (mkN "kaffe" neutrum) ;
    Tea = mkCN (mkN "te" neutrum) ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "ost") ;
    Fish = mkCN (mkN "fisk") ;
    Fresh = mkA "färsk" ;
    Warm = mkA "varm" ;
    Expensive = mkA "dyr" ;
    Delicious = mkA "läcker" ;
    Boring = mkA "tråkig" ;
    Good = mkA "god" "gott" "goda" "bättre" "bäst" ;

    Restaurant = mkPlace (mkN "restaurang" "restauranger") "på" ;
    Bar = mkPlace (mkN "bar" "barer") "i" ;
    Toilet = mkPlace (mkN "toalett" "toaletter") "på" ;
    Museum = mkPlace (mkN "museum" "museet" "museer" "museerna") "på" ;
    Airport = mkPlace (mkN "flygplats" "flygplatser") "på" ;
    Station = mkPlace (mkN "station" "stationer") "på" ;
    Hospital = mkPlace (mkN "sjukhus" "sjukhus") "på" ;
    Church = mkPlace (mkN "kyrka") "i" ;

    Euro = mkCN (mkN "euro" "euro") ;
    Dollar = mkCN (mkN "dollar" "dollar") ;
    Lei = mkCN (mkN "lei" "lei") ;

    English = mkNat "engelsk" "England" ;
    Finnish = mkNat "finsk" "Finland" ;
    French = mkNat "fransk" "Frankrike" ; 
    Italian = mkNat "italiensk" "Italien" ;
    Romanian = mkNat "rumänsk" "Rumänien" ;
    Swedish = mkNat "svensk" "Sverige" ;

    Belgian = mkA "belgisk" ;
    Flemish = mkNP (mkPN "flamländska") ;
    Belgium = mkNP (mkPN "Belgien") ;

    Monday = mkDay "måndag" ;
    Tuesday = mkDay "tisdag" ;
    Wednesday = mkDay "onsdag" ;
    Thursday = mkDay "torsdag" ;
    Friday = mkDay "fredag" ;
    Saturday = mkDay "lördag" ;
    Sunday = mkDay "söndag" ;

    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ;
    ALike p item = mkCl p.name (mkV2 (mkV "tycker") (mkPrep "om")) item ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "tala")) lang ;
    ALove p q = mkCl p.name (mkV2 (mkV "älska")) q.name ;
    AHungry p = mkCl p.name (mkA "hungrig") ;
    AThirsty p = mkCl p.name (mkA "törstig") ;
    ATired p = mkCl p.name (mkA "trött") ;
    AScared p = mkCl p.name (mkA "rädd") ;
    AIll p = mkCl p.name (mkA "sjuk") ;
    AUnderstand p = mkCl p.name (mkV "förstå" "förstod" "förstått") ;
    AKnow p = mkCl p.name (mkV "veta" "vet" "vet" "visste" "vetat" "visst") ; 
                          ---- IrregSwe.veta_V gives "missing"
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP IrregSwe.gå_V) place.to) ;
    AHasName p name = mkCl (nameOf p) name ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (mkV "bo")) (SyntaxSwe.mkAdv in_Prep co)) ;

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

  oper
    mkNat : Str -> Str -> {lang : NP ; prop : A ; country : NP} = \nat,co -> 
      {lang = mkNP (mkPN (nat + "a")) ; 
       prop = mkA nat ; country = mkNP (mkPN co)} ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      {name = day ; 
       point = SyntaxSwe.mkAdv on_Prep day ; 
       habitual = SyntaxSwe.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))
      } ;

    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN p ;
      at = mkPrep i ;
      to = to_Prep
      } ;

    open_A = mkA "öppen" "öppet" ;
    closed_A = mkA "stängd" "stängt" ;

    nameOf : {name : NP ; isPron : Bool ; poss : Det} -> NP = \p -> 
      case p.isPron of {
        True => mkNP p.poss (mkN "namn" "namn") ;
        _    => mkNP (mkNP the_Det (mkN "namn" "namn")) 
                       (SyntaxSwe.mkAdv possess_Prep p.name)
        } ;
}
