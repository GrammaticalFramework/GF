
abstract Restaurant = {

	flags startcat = Paragraph ;
		  coding = utf8 ;

    cat
		Paragraph ;
		Phrase ;
		Item ;
		Quality ;
		ListQual ;
		Adverb ;
		STense ;

    fun

-- Paragraphs
		Sentence					: Phrase -> Paragraph -> Paragraph ;
		Empty_Sentence				: Paragraph ;

-- Sentences

		The_Item_Is					: Item -> Quality -> Phrase ;
		The_Item_Is_Not				: Item -> Quality -> Phrase ;
		I_Recommend					: Adverb -> Item -> Phrase ;
		I_Do_Not_Recommend			: Adverb -> Item -> Phrase ;

-- Noun Phrases
		The_Restaurant				: Item ;
		The_Food					: Item ;
		The_Staff					: Item ;
		The_Wine					: Item ;
		The_Wines					: Item ;
		The_Cheese					: Item ;
		The_Cheeses					: Item ;
		The_Fish					: Item ;
		The_Pizza					: Item ;
		The_Dishes					: Item ;
		The_Drinks					: Item ;
		The_Desserts				: Item ;

-- Adjectival Phrases

		Adjective_And_Adjective		: Quality -> Quality -> ListQual ;
		Adj_Comma_List_Of_Adjs		: Quality -> ListQual -> ListQual ;
		A_List_Of_Adjectives		: ListQual -> Quality ;
		Very_Adjective				: Quality -> Quality ;

-- Adjectives
--	Restaurant
		Chinese						: Quality ;
		French						: Quality ;
		Italian						: Quality ;
		Japanese					: Quality ;
		Mexican						: Quality ;
		Thai						: Quality ;

		Expensive					: Quality ;
		Cheap						: Quality ;
		Nice						: Quality ;
		Clean						: Quality ;
		Dirty						: Quality ;

--	Food

		Fresh						: Quality ;
		Delicious					: Quality ;
		Fatty						: Quality ;
		Tasteless					: Quality ;
		Authentic					: Quality ;

--	Service
		Efficient					: Quality ;
		Courteous					: Quality ;
		Helpful						: Quality ;
		Friendly					: Quality ;
		Personal					: Quality ;
		Warm						: Quality ;
		Prompt						: Quality ;
		Attentive					: Quality ;

		Inefficient					: Quality ;
		Rude						: Quality ;
		Impersonal					: Quality ;
		Slow						: Quality ;
		UnAttentive					: Quality ;

--	General
		Good, Great, Excellent				: Quality ;
		Bad, Awful, Horrible, Disgusting	: Quality ;
		Boring								: Quality ;

-- General Plural
		Diverse						: Quality ;

-- Adverbs
		NoAdverb					: Adverb ;
		Strongly					: Adverb ;
		Completely					: Adverb ;
		Certainly					: Adverb ;
		Honestly					: Adverb ;
		Really						: Adverb ;
		Reluctantly					: Adverb ;
		Hardly						: Adverb ;

-- Tenses
		Present_Tense				: STense ;
		Conditional_Tense			: STense ;

}
