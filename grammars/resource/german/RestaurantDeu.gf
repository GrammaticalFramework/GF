--# -path=.:../abstract:../../prelude

concrete RestaurantDeu of Restaurant = 
  DatabaseDeu ** open Prelude,Paradigms,Deutsch,DatabaseRes in {

lin 
  Restaurant = UseN (nAuto "Restaurant") ;
  Bar = UseN (nAuto "Bar") ; --- ??
  French = apReg "Französisch" ;
  Italian = apReg "Italienisch" ;
  Indian = apReg "Indisch" ;
  Japanese = apReg "Japanisch" ;

  address = funVon (nFrau "Adresse") ;
  phone = funVon (nFrau "Rufnummer") ; ---
  priceLevel = funVon (nFrau "Preisstufe") ;

  Cheap = aReg "billig" ;
  Expensive = aDeg3 "teuer" "teurer" "teurest" ;

  WhoRecommend rest = mkSentSame (ss2 ["wer empfiehlt"] (rest.s ! accusative)) ;
  WhoHellRecommend rest = 
    mkSentSame (ss2 ["wer zum Teufel empfiehlt"] (rest.s ! accusative)) ;

  LucasCarton = mkPN ["Lucas Carton"] ["Lucas Cartons"] ;
} ;
