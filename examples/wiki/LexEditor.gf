
interface LexEditor = open Syntax in {

	oper
-- Sentences
		singleWordCommand_Utt	: V -> Utt ;
		command_Utt 			: V -> Det -> A -> N -> Utt ;
		randomlyCommand_Utt		: V -> Det -> N -> Utt ;
		label_Utt				: N -> Utt ;
		errorMessage_Utt		: A -> N -> Utt ;

-- Verbs
		undo_V				: V ;
		redo_V				: V ;
		cut_V				: V ;
		copy_V				: V ;
		paste_V				: V ;
		delete_V			: V ;
		refine_V			: V ;
		replace_V			: V ;
		wrap_V				: V ;
		select_V			: V ;
		enter_V				: V ;
		show_V				: V ;

-- Nouns
		language_N			: N ;
		node_N				: N ;
		tree_N				: N ;
		refinement_N		: N ;
		wrapper_N			: N ;
		string_N			: N ;
		page_N				: N ;
		danish_N 			: N ;
		english_N			: N ;
		finnish_N			: N ;
		french_N			: N ;
		german_N			: N ;
		italian_N			: N ;
		norwegian_N			: N ;
		russian_N			: N ;
		spanish_N			: N ;
		swedish_N			: N ;

-- Adjectives
		noAdj_A				: A ;
		available_A			: A ;
		next_A				: A ;
		previous_A			: A ;

-- Determiners
		defSg_Det		: Det ;
		defPl_Det		: Det ;
		indefSg_Det		: Det ;
		indefPl_Det		: Det ;
		this_Det		: Det ;

}
