abstract Restaurant = Database ** {

fun 
  Restaurant, Bar : Noun ;
  French, Italian, Indian, Japanese : Property ;
  address, phone, priceLevel : Feature ;
  Cheap, Expensive : Comparison ;

  WhoRecommend : Name -> Phras ;
  WhoHellRecommend : Name -> Phras ;

  
-- examples of restaurant names
  LucasCarton : Name ;
} ;
