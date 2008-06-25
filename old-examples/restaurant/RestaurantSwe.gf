--# -path=.:present:prelude

concrete RestaurantSwe of Restaurant = RestaurantI with
  (Syntax = SyntaxSwe), 
  (LexRestaurant = LexRestaurantSwe) ;
