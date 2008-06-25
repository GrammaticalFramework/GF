
instance LexEditorEng of LexEditor = open SyntaxEng, ParadigmsEng in {

	flags coding = utf8 ;

	oper
-- Sentences
		singleWordCommand_Utt verb			= mkUtt politeImpForm positivePol (mkImp verb) ;
		command_Utt verb det adj noun		= mkUtt politeImpForm positivePol (mkImp (mkVP (mkV2 verb) (mkNP det (mkCN adj noun)))) ;
		randomlyCommand_Utt verb det noun	= mkUtt politeImpForm positivePol (mkImp (mkVP (mkAdV "Randomly") (mkVP (mkV2 verb) (mkNP det noun)))) ;
		label_Utt noun						= mkUtt (mkNP (mkPN noun)) ;
		errorMessage_Utt adj noun			= mkUtt (mkS negativePol (mkCl (mkNP indefPlDet (mkCN adj noun)))) ;

-- Verbs
		undo_V			= mkV "Undo" ;
		redo_V			= mkV "Redo" ;
		cut_V			= mkV "Cut" ;
		copy_V			= mkV "Copy" ;
		paste_V			= mkV "Paste" ;
		delete_V		= mkV "Delete" ;
		refine_V		= mkV "Refine" ;
		replace_V		= mkV "Replace" ;
		wrap_V			= mkV "Wrap" ;
		select_V		= mkV "Select" ;
		enter_V			= mkV "Enter" ;
		show_V			= mkV "Show" ;

-- Nouns
		language_N		= mkN "language" ;
		node_N			= mkN "node" ;
		tree_N			= mkN "tree" ;
		refinement_N	= mkN "refinement" ;
		wrapper_N		= mkN "wrapper" ;
		string_N		= mkN "string" ;
		page_N			= mkN "page" ;
		danish_N		= mkN "Danish"  "Danish" ;
		english_N		= mkN "English" "English" ;
		finnish_N		= mkN "Finnish" "Finnish" ;
		french_N		= mkN "French" "French" ;
		german_N		= mkN "German" "German" ;
		italian_N		= mkN "Italian" "Italian" ;
		norwegian_N		= mkN "Norwegian" "Norwegian" ;
		russian_N		= mkN "Russian" "Russian" ;
		spanish_N		= mkN "Spanish" "Spanish" ;
		swedish_N		= mkN "Swedish" "Swedish" ;

-- Adjectives
		noAdj_A			= mkA "" ;
		available_A		= mkA "available" ;
		next_A			= mkA "next" ;
		previous_A		= mkA "previous" ;

-- Determiners
		defSg_Det		= defSgDet ;
		defPl_Det		= defPlDet ;
		indefSg_Det		= indefSgDet ;
		indefPl_Det		= indefPlDet ;
		this_Det		= mkDet this_QuantSg ;

}
