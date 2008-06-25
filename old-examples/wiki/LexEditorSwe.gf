
instance LexEditorSwe of LexEditor = open SyntaxSwe, IrregSwe, ParadigmsSwe in {

	flags coding = utf8 ;

	oper
-- Sentences														
		singleWordCommand_Utt verb			= mkUtt politeImpForm positivePol (mkImp verb) ;
		command_Utt verb det adj noun		= mkUtt politeImpForm positivePol (mkImp (mkVP (mkV2 verb) (mkNP det (mkCN adj noun)))) ;
		randomlyCommand_Utt verb det noun	= mkUtt politeImpForm positivePol (mkImp (mkVP (mkAdV "slumpmässigt") (mkVP (mkV2 verb) (mkNP det noun)))) ;
		label_Utt noun						= mkUtt (mkNP (nounPN noun)) ;
		errorMessage_Utt adj noun			= mkUtt (mkS negativePol (mkCl (mkNP indefPlDet (mkCN adj noun)))) ;
														
-- Verbs								
		undo_V			= mkV "Ångrar" ;
		redo_V			= mkV "Upprepar" ;
		cut_V			= mkV (mkV "Klipper") "ut" ;
		copy_V			= mkV "Kopierar" ;
		paste_V			= mkV (mkV "Klistrar") "in" ;
		delete_V		= mkV "Raderar" ;
		refine_V		= mkV "Raffinerar" ;									-- FIX!!!
		replace_V		= mkV "Ersätter" ;
		wrap_V			= mkV "Förpackar" ;										-- FIX!!!
		select_V		= mkV "Väljer" ;
		enter_V			= mkV "Skriver" ;
		show_V			= mkV "Visar" ;
														
-- Nouns														
		language_N		= mkN "språk" "språket" "språk" "språken" ;
		node_N			= mkN "nod" ;
		tree_N			= mkN "träd" "trädet" "träd" "träden" ;
		refinement_N	= mkN "raffinemang" ;
		wrapper_N		= mkN "förpackning" ;
		string_N		= mkN "sträng" ;
		page_N			= mkN "sida" ;
		danish_N		= mkN "Danska" ;
		english_N		= mkN "Engelska" ;
		finnish_N		= mkN "Finska" ;
		french_N		= mkN "Franska" ;
		german_N		= mkN "Tyska" ;
		italian_N		= mkN "Italienska" ;
		norwegian_N		= mkN "Norska" ;
		russian_N		= mkN "Ryska" ;
		spanish_N		= mkN "Spanska" ;
		swedish_N		= mkN "Svenska" ;

-- Adjectives
		noAdj_A			= mkA "" ;
		available_A		= mkA "tillgänglig" ;
		next_A			= mkA "näst" ;
		previous_A		= mkA "föregående" ;

-- Determiners														
		defSg_Det		= defSgDet ;
		defPl_Det		= defPlDet ;
		indefSg_Det		= indefSgDet ;
		indefPl_Det		= indefPlDet ;
		this_Det		= mkDet this_QuantSg ;

}
