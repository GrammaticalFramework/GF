
instance LexEditorSpa of LexEditor = open SyntaxSpa, IrregSpa, ParadigmsSpa in {

	flags coding = utf8 ;

	oper
-- Sentences														
		singleWordCommand_Utt verb			= mkUtt (mkVP verb) ;
		command_Utt verb det adj noun		= mkUtt (mkVP (mkV2 verb) (mkNP det (mkCN adj noun))) ;
		randomlyCommand_Utt verb det noun	= mkUtt (mkVP (mkAdV "aleatoriamente") (mkVP (mkV2 verb) (mkNP det noun))) ;
		label_Utt noun						= mkUtt (mkNP (myMkPN noun)) ;
		errorMessage_Utt adj noun			= mkUtt (mkS negativePol (mkCl (mkNP indefPlDet (mkCN adj noun)))) ;
														
-- Verbs							
--		undo_V			= deshacer_V ;
--		redo_V			= rehacer_V ;
		undo_V			= mkV "Deshacer" ;
		redo_V			= mkV "Rehacer" ;
		cut_V			= mkV "Cortar" ;				
		copy_V			= mkV "Copiar" ;
		paste_V			= mkV "Pegar" ;
		delete_V		= mkV "Borrar" ;
		refine_V		= mkV "Refinar" ;
		replace_V		= mkV "Reemplazar" ;
--		wrap_V			= envolver_V ;
		wrap_V			= mkV "Envolver" ;
		select_V		= mkV "Seleccionar" ;
		enter_V			= mkV "Introducir" ;
		show_V			= mkV "Mostrar" ;
														
-- Nouns														
		language_N		= mkN "lenguaje" ;	
		node_N			= mkN "nodo" ;
		tree_N			= mkN "árbol" ;
		refinement_N	= mkN "refinamiento" ;
		wrapper_N		= mkN "envoltura" ;
		string_N		= compN (mkN "cadena") ("de" ++ "caracteres") ;
		page_N			= mkN "página" ;
		danish_N		= mkN "Danés" ;
		english_N		= mkN "Inglés" ;
		finnish_N		= mkN "Finlandés" ;
		french_N		= mkN "Francés" ;
		german_N		= mkN "Alemán" ;
		italian_N		= mkN "Italiano" ;
		norwegian_N		= mkN "Noruego" ;
		russian_N		= mkN "Ruso" ;
		spanish_N		= mkN "Español" ;
		swedish_N		= mkN "Sueco" ;

-- Adjectives
		noAdj_A			= mkA "" ;
		available_A		= mkA "disponible" ;
		next_A			= mkA "siguiente" ;
		previous_A		= mkA "anterior" ;

-- Determiners														
		defSg_Det		= defSgDet ;
		defPl_Det		= defPlDet ;
		indefSg_Det		= indefSgDet ;
		indefPl_Det		= indefPlDet ;
		this_Det		= mkDet this_QuantSg ;

-- Functions
		myMkPN : N -> PN =
			\n -> {s = n.s ! singular ; g = n.g ; lock_PN = <>} ;

}
