concrete RestaurantEng of Restaurant = 
  DatabaseEng ** open Prelude,Paradigms,DatabaseRes in {

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

  WhoRecommend rest = mkSentSame (ss (["who recommended"] ++ rest.s ! nominative)) ;
  WhoHellRecommend rest = 
    mkSentSame (ss (["who the hell recommended"] ++ rest.s ! nominative)) ;

  LucasCarton = pnReg ["Lucas Carton"] ;

} ;
