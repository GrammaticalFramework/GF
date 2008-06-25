
abstract Editor = {

	flags startcat = Sentence ;
		  coding   = utf8 ;

    cat
		Sentence ;
		Verb ;
		Noun ;
		Adjective ;
		Determiner ;

    fun
-- Sentences
		SingleWordCommand	: Verb -> Sentence ;
		Command				: Verb -> Determiner -> Adjective -> Noun -> Sentence ;
		RandomlyCommand		: Verb -> Determiner -> Noun -> Sentence ;
		Label				: Noun -> Sentence ;
		ErrorMessage		: Adjective -> Noun -> Sentence ;

-- Verbs
		Undo				: Verb ;
		Redo				: Verb ;
		Cut					: Verb ;
		Copy				: Verb ;
		Paste				: Verb ;
		Delete				: Verb ;
		Refine				: Verb ;
		Replace				: Verb ;
		Wrap				: Verb ;
		Select				: Verb ;
		Enter				: Verb ;
		Show				: Verb ;

-- Nouns
		Language			: Noun ;
		Node				: Noun ;
		Tree				: Noun ;
		Refinement			: Noun ;
		Wrapper				: Noun ;
		String				: Noun ;
		Page				: Noun ;
		Danish				: Noun ;
		English				: Noun ;
		Finnish				: Noun ;
		French				: Noun ;
		German				: Noun ;
		Italian				: Noun ;
		Norwegian			: Noun ;
		Russian				: Noun ;
		Spanish				: Noun ;
		Swedish				: Noun ;

-- Adjectives
		NoAdj				: Adjective ;
		Available			: Adjective ;
		Next				: Adjective ;
		Previous			: Adjective ;

-- Determiners
		DefSgDet			: Determiner ;
		DefPlDet			: Determiner ;
		IndefSgDet			: Determiner ;
		IndefPlDet			: Determiner ;
		This				: Determiner ;

}
