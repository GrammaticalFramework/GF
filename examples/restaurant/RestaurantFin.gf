--# -path=.:present:prelude

concrete RestaurantFin of Restaurant = RestaurantI with
  (Syntax = SyntaxFin), 
  (LexRestaurant = LexRestaurantFin) ;
