--# -path=.:../resource/abstract:../resource/english:../newresource/abstract:../newresource/english:../prelude
--- path names: resource in release, newresource in cvs

concrete RestaurantEng of Restaurant = 
  DatabaseEng ** open Prelude, ParadigmsEng in {

lin 
  Restaurant = cnNonhuman "restaurant" ;
  Bar = cnNonhuman "bar" ;
  French = apReg "French" ;
  Italian = apReg "Italian" ;
  Indian = apReg "Indian" ;
  Japanese = apReg "Japanese" ;

  address = funNonhuman "address" ;
  phone = funNonhuman ["number"] ;  --- phone
  priceLevel = funNonhuman ["level"] ; --- price

  Cheap = aReg "cheap" ;
  Expensive = aRidiculous "expensive" ;

  WhoRecommend rest = 
    ss (["who recommended"] ++ rest.s ! nominative) ** {lock_Phr = <>} ;
  WhoHellRecommend rest = 
    ss (["who the hell recommended"] ++ rest.s ! nominative) ** {lock_Phr = <>} ;

  LucasCarton = pnReg ["Lucas Carton"] ;
  LaCoupole = pnReg ["La Coupole"] ;
  BurgerKing = pnReg ["Burger King"] ;

} ;
