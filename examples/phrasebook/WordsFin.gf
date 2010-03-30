-- (c) 2009 Aarne Ranta under LGPL

concrete WordsFin of Words = SentencesFin ** 
    open SyntaxFin, ParadigmsFin, DiffPhrasebookFin in {
  lin
    Wine = mkCN (mkN "viini") ;
    Beer = mkCN (mkN "olut" "oluita") ;
    Water = mkCN (mkN "vesi" "veden" "vesi‰") ;
    Coffee = mkCN (mkN "kahvi") ;
    Tea = mkCN (mkN "tee") ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "juusto") ;
    Fish = mkCN (mkN "kala") ;
    Fresh = mkAP (mkA "tuore") ;
    Warm = mkAP (mkA 
    (mkN "l‰mmin" "l‰mpim‰n" "l‰mmint‰" "l‰mpim‰n‰" "l‰mpim‰‰n" 
         "l‰mpimin‰" "l‰mpimi‰" "l‰mpimien" "l‰mpimiss‰" "l‰mpimiin"
	 ) 
    "l‰mpim‰mpi" "l‰mpimin") ;
    Italian = mkAP (mkA "italialainen") ;
    Expensive = mkAP (mkA "kallis") ;
    Delicious = mkAP (mkA "herkullinen") ;
    Boring = mkAP (mkA "tyls‰") ;

    Restaurant = mkCN (mkN "ravintola") ;
    Bar = mkCN (mkN "baari") ;
    Toilet = mkCN (mkN "vessa") ;

    Euro = mkCN (mkN "euro") ;
    Dollar = mkCN (mkN "dollari") ;
    Lei = mkCN (mkN "lei") ;

    AWant p obj = mkCl p want_V2 obj ;
    ALike p item = mkCl p like_V2 item ;
    AHave p kind = mkCl p have_V2 (mkNP kind) ;
    ASpeak p lang = mkCl p  (mkV2 (mkV "puhua") partitive) lang ;
    ALove p q = mkCl p (mkV2 (mkV "rakastaa") partitive) q ;

    English = mkNP (mkPN "englanti") ;
    Finnish = mkNP (mkPN (mkN "suomi" "suomia")) ;
    French = mkNP (mkPN "ranska") ; 
    Romanian = mkNP (mkPN "romania") ;
    Swedish = mkNP (mkPN "ruotsi") ;

    AHungry p = mkCl p have_V2 (mkNP (mkN "n‰lk‰")) ;
    AThirsty p = mkCl p have_V2 (mkNP (mkN "jano")) ;
    ATired p = mkCl p (caseV partitive (mkV "v‰sytt‰‰")) ;
    AScared p = mkCl p (caseV partitive (mkV "pelottaa")) ;
    AUnderstand p = mkCl p (mkV "ymm‰rt‰‰") ;

}
