-- (c) 2009 Aarne Ranta under LGPL

concrete FoodFin of Food = SentencesFin ** 
    open SyntaxFin, ParadigmsFin in {
  lin
    Wine = mkCN (mkN "viini") ;
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

-- oper ---- optimization lasts forever
--  mkCNN : Str -> CN = \s -> mkCN (mkN s) ;
--  mkAPA : Str -> AP = \s -> mkAP (mkA s) ;
}
