
--# -path=.:alltenses:prelude

incomplete concrete RestaurantI of Restaurant = open Syntax, Grammar, LexRestaurant in {

	flags coding = utf8 ;

	lincat
		Paragraph		= Text ;
		Phrase			= Phr ;
		Item			= NP ;
		Quality			= AP ;
		ListQual		= ListAP ;
		Adverb			= AdV ;
		STense			= Tense ;

	lin
-- Paragraphs
		Sentence phrase phrases				= mkText phrase phrases ;
		Empty_Sentence						= emptyText ;

-- Sentences

		The_Item_Is item quality		= mkPhr (mkS positivePol (mkCl item quality)) ;
		The_Item_Is_Not item quality	= mkPhr (mkS negativePol (mkCl item quality)) ;
		I_Recommend adv item			=
			variants {mkPhr (mkS presentTense positivePol (mkCl (mkNP i_Pron) (mkVP adv (mkVP recommend_V2 item)))) ;
					  mkPhr (mkS conditionalTense positivePol (mkCl (mkNP i_Pron) (mkVP adv (mkVP recommend_V2 item))))} ;
		I_Do_Not_Recommend adv item		=
			variants {mkPhr (mkS presentTense negativePol (mkCl (mkNP i_Pron) (mkVP adv (mkVP recommend_V2 item)))) ;
					  mkPhr (mkS conditionalTense negativePol (mkCl (mkNP i_Pron) (mkVP adv (mkVP recommend_V2 item))))} ;

-- Common Nouns
		The_Restaurant				= variants {mkNP defSgDet restaurant_N; mkNP this_QuantSg restaurant_N} ;
		The_Food					= mkNP defSgDet food_N ;
		The_Staff					= mkNP defSgDet staff_N ;
		The_Wine					= mkNP defSgDet wine_N ;
		The_Wines					= mkNP defPlDet wine_N ;
		The_Cheese					= mkNP defSgDet cheese_N ;
		The_Cheeses					= mkNP defPlDet cheese_N ;
		The_Fish					= mkNP defSgDet fish_N ;
		The_Pizza					= mkNP defSgDet pizza_N ;
		The_Dishes					= mkNP defPlDet dish_N ;
		The_Drinks					= mkNP defPlDet drink_N ;
		The_Desserts				= mkNP defPlDet dessert_N ;

-- Adjectival Phrases
		Adjective_And_Adjective qualA qualB		= mkListAP qualA qualB ;
		Adj_Comma_List_Of_Adjs qualA qualB		= mkListAP qualA qualB ;
		A_List_Of_Adjectives qual				= mkAP and_Conj qual ;
		Very_Adjective quality					= mkAP very_AdA quality ;

-- Adjectives
--	Restaurant
		Chinese								= mkAP chinese_A ;
		French								= mkAP french_A ;
		Italian								= mkAP italian_A ;
		Japanese							= mkAP japanese_A ;
		Mexican								= mkAP mexican_A ;
		Thai								= mkAP thai_A ;

		Expensive							= mkAP expensive_A ;
		Cheap								= mkAP cheap_A ;
		Nice								= mkAP nice_A ;
		Clean								= mkAP clean_A ;
		Dirty								= mkAP dirty_A ;

--	Food
		Fresh								= mkAP fresh_A ;
		Delicious							= mkAP delicious_A ;
		Fatty								= mkAP fatty_A ;
		Tasteless							= mkAP tasteless_A;
		Authentic							= mkAP authentic_A ;

--	Service
		Efficient							= mkAP efficient_A ;
		Courteous							= mkAP courteous_A ;
		Helpful								= mkAP helpful_A ;
		Friendly							= mkAP friendly_A ;
		Personal							= mkAP personal_A ;
		Warm								= mkAP warm_A ;
		Prompt								= mkAP prompt_A ;
		Attentive							= mkAP attentive_A ;
		Inefficient							= mkAP inefficient_A ;
		Rude								= mkAP rude_A ;
		Impersonal							= mkAP impersonal_A ;
		Slow								= mkAP slow_A ;
		UnAttentive							= mkAP unattentive_A ;

--	Generic
		Good								= mkAP good_A ;
		Great								= mkAP great_A ;
		Excellent							= mkAP excellent_A ;
		Bad									= mkAP bad_A ;
		Awful								= mkAP awful_A ;
		Horrible							= mkAP horrible_A ;
		Disgusting							= mkAP disgusting_A ;
		Boring								= mkAP boring_A ;

-- Generic Plural
		Diverse								= mkAP diverse_A ;

-- Adverbs
		NoAdverb							= noAdv_AdV ;
		Strongly							= strongly_AdV ;
		Completely							= completely_AdV ;
		Certainly							= certainly_AdV ;
		Honestly							= honestly_AdV ;
		Really								= really_AdV ;
		Reluctantly							= reluctantly_AdV ;
		Hardly								= hardly_AdV ;

-- Tenses
		Present_Tense						= presentTense ;
		Conditional_Tense					= conditionalTense ;

}
