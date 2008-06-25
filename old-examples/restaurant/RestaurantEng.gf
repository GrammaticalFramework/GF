--# -path=.:present:prelude

concrete RestaurantEng of Restaurant = RestaurantI with
  (Syntax = SyntaxEng), 
  (LexRestaurant = LexRestaurantEng) ;
