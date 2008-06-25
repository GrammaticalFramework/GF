--# -path=.:present:prelude

concrete RestaurantGer of Restaurant = RestaurantI with
  (Syntax = SyntaxGer), 
  (LexRestaurant = LexRestaurantGer) ;
