-- (c) 2009 Aarne Ranta under LGPL

concrete WordsFin of Words = SentencesFin ** 
    open SyntaxFin, ParadigmsFin, DiffPhrasebookFin in {
  lin
    Wine = mkCN (mkN "viini") ;
    Beer = mkCN (mkN "olut" "oluita") ;
    Water = mkCN (mkN "vesi" "veden" "vesiä") ;
    Coffee = mkCN (mkN "kahvi") ;
    Tea = mkCN (mkN "tee") ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "juusto") ;
    Fish = mkCN (mkN "kala") ;
    Fresh = mkAP (mkA "tuore") ;
    Warm = mkAP (mkA 
    (mkN "lämmin" "lämpimän" "lämmintä" "lämpimänä" "lämpimään" 
         "lämpiminä" "lämpimiä" "lämpimien" "lämpimissä" "lämpimiin"
	 ) 
    "lämpimämpi" "lämpimin") ;
    Italian = mkAP (mkA "italialainen") ;
    Expensive = mkAP (mkA "kallis") ;
    Delicious = mkAP (mkA "herkullinen") ;
    Boring = mkAP (mkA "tylsä") ;

    Restaurant = mkCN (mkN "ravintola") ;
    Bar = mkCN (mkN "baari") ;
    Toilet = mkCN (mkN "vessa") ;

    Euro = mkCN (mkN "euro") ;
    Dollar = mkCN (mkN "dollari") ;
    Lei = mkCN (mkN "lei") ;

    English = mkNP (mkPN "englanti") ;
    Finnish = mkNP (mkPN (mkN "suomi" "suomia")) ;
    French = mkNP (mkPN "ranska") ; 
    Romanian = mkNP (mkPN "romania") ;
    Swedish = mkNP (mkPN "ruotsi") ;

    AWant p obj = {s = \\r => mkCl (p.s ! r) want_V2 obj} ;
    ALike p item = {s = \\r => mkCl (p.s ! r) like_V2 item} ;
    AHave p kind = {s = \\r => mkCl (p.s ! r) have_V2 (mkNP kind)} ;
    ASpeak p lang = {s = \\r => mkCl (p.s ! r) (mkV2 (mkV "puhua") partitive) lang} ;
    ALove p q = {s = \\r => mkCl (p.s ! r) (mkV2 (mkV "rakastaa") partitive) (q.s ! r)} ;

}
