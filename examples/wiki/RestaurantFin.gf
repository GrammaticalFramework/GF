
--# -path=.:alltenses:prelude

concrete RestaurantFin of Restaurant = RestaurantI with

	(Syntax			= SyntaxFin),
	(Grammar		= GrammarFin),
	(LexRestaurant	= LexRestaurantFin) ;
