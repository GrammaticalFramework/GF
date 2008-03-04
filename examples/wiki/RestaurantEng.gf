
--# -path=.:alltenses:prelude

concrete RestaurantEng of Restaurant = RestaurantI with

	(Syntax			= SyntaxEng),
	(Grammar		= GrammarEng),
	(LexRestaurant	= LexRestaurantEng) ;
