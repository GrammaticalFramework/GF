abstract Restaurant = Database ** {

fun 
  Restaurant, Bar : Category ;
  French, Italian, Indian, Japanese : Property ;
  address, phone, priceLevel : Feature ;
  Cheap, Expensive : Comparison ;

  WhoRecommend : Name -> Query ;
  WhoHellRecommend : Name -> Query ;

-- examples of restaurant names
  LucasCarton : Name ;
  LaCoupole : Name ;
  BurgerKing : Name ;
} ;
