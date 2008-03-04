
instance LexEditorFin of LexEditor = open SyntaxFin, ParadigmsFin in {

--	flags coding = utf8 ;

        oper mkAdV : Str -> AdV = \s -> {s = s ; lock_AdV = <>} ;

	oper
-- Sentences
		singleWordCommand_Utt verb			= mkUtt politeImpForm positivePol (mkImp verb) ;
		command_Utt verb det adj noun		= mkUtt politeImpForm positivePol (mkImp (mkVP (mkV2 verb) (mkNP det (mkCN adj noun)))) ;
		randomlyCommand_Utt verb det noun	= mkUtt politeImpForm positivePol (mkImp (mkVP (mkAdV "satunnaisesti") (mkVP (mkV2 verb) (mkNP det noun)))) ;
		label_Utt noun						= mkUtt (mkNP (mkPN noun)) ;
		errorMessage_Utt adj noun			= mkUtt (mkS negativePol (mkCl (mkNP indefPlDet (mkCN adj noun)))) ;

-- Verbs
		undo_V			= mkV "perua" ;
		redo_V			= mkV "toistaa" ;
		cut_V			= mkV "leikata" ;
		copy_V			= mkV "kopioida" ;
		paste_V			= mkV "liimata" ;
		delete_V		= mkV "poistaa" ;
		refine_V		= mkV "hienontaa" ;
		replace_V		= mkV "korvata" ;
		wrap_V			= mkV "k‰‰ri‰" ;
		select_V		= mkV "valita" ;
		enter_V			= mkV "lis‰t‰" ;
		show_V			= mkV "n‰ytt‰‰" ;

-- Nouns
		language_N		= mkN "kieli" "kieli‰" ;
		node_N			= mkN "solmu" ;
		tree_N			= mkN "puu" ;
		refinement_N	= mkN "hienonnus" ;
		wrapper_N		= mkN "k‰‰re" ;
		string_N		= mkN "merkkijono" ;
		page_N			= mkN "sivu" ;
		danish_N		= mkN "tanska" ;
		english_N		= mkN "englanti" ;
		finnish_N		= mkN "suomi" "suomia" ;
		french_N		= mkN "ranska" ;
		german_N		= mkN "saksa" ;
		italian_N		= mkN "italia" ;
		norwegian_N		= mkN "norja" ;
		russian_N		= mkN "ven‰j‰" ;
		spanish_N		= mkN "espanja" ;
		swedish_N		= mkN "ruotsi" ;

-- Adjectives
		noAdj_A			= mkA "" ;
		available_A		= mkA "saatavillaoleva" ;
		next_A			= mkA "seuraava" ;
		previous_A		= mkA "edellinen" ;

-- Determiners
		defSg_Det		= defSgDet ;
		defPl_Det		= defPlDet ;
		indefSg_Det		= indefSgDet ;
		indefPl_Det		= indefPlDet ;
		this_Det		= mkDet this_QuantSg ;

}
