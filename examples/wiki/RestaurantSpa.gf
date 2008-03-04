
--# -path=.:alltenses:prelude

concrete RestaurantSpa of Restaurant = RestaurantI with

	(Syntax			= SyntaxSpa),
	(Grammar		= GrammarSpa),
	(LexRestaurant	= LexRestaurantSpa) ;
