--# -path=.:../newresource/abstract:../newresource/swedish:../prelude

concrete RestaurantSwe of Restaurant = 
  DatabaseSwe ** open Prelude, ResourceSwe, ParadigmsSwe in {

lin 
  Restaurant = UseN (nRisk "restaurang") ;
  Bar = UseN (nRisk "bar") ;
  French = AdjP1 (adjReg "fransk") ;
  Italian = AdjP1 (adjReg "italiensk") ;
  Indian = AdjP1 (adjReg "indisk") ;
  Japanese = AdjP1 (adjReg "japansk") ;

  address = funAv (nRisk "adress") ;
  phone = 
    funTill (mkN "telefonnummer" "telefonnumret" "telefonnummer"
                 "telefonnumren" neutrum nonmasculine) ;
  priceLevel = funPaa (nRisk "prisnivå") ;

  Cheap = aReg "billig" ;
  Expensive = aReg "dyr" ;

  WhoRecommend rest = 
    ss2 ["vem rekommenderade"] (rest.s ! nominative) ** {lock_Phr = <>} ;
  WhoHellRecommend rest = 
    ss2 ["vem fan rekommenderade"] (rest.s ! nominative) ** {lock_Phr = <>} ;

  LucasCarton = pnReg ["Lucas-Carton"] neutrum nonmasculine ; --- -
  LaCoupole  = pnReg ["La-Coupole"] neutrum nonmasculine ;
  BurgerKing = pnS (variants {["Burger King"] ; "BK"}) neutrum nonmasculine ;

}
