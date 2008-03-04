
--# -path=.=present=prelude

incomplete concrete EditorI of Editor = open Syntax, LexEditor in {

	flags coding = utf8 ;
  
    lincat
    	Sentence			= Utt ;
		Verb				= V ;
		Noun				= N ;
		Adjective			= A ;
		Determiner			= Det ;
  
    lin
-- Sentences
		SingleWordCommand verb			= singleWordCommand_Utt verb ;
		Command verb det adj noun		= command_Utt verb det adj noun ;
		RandomlyCommand verb det noun	= randomlyCommand_Utt verb det noun ;
		Label noun						= label_Utt noun ;
		ErrorMessage adj noun			= errorMessage_Utt adj noun ;

-- Verbs
		Undo				= undo_V ;
		Redo				= redo_V ;
		Cut					= cut_V ;
		Copy				= copy_V ;
		Paste				= paste_V ;
		Delete				= delete_V ;
		Refine				= refine_V ;
		Replace				= replace_V ;
		Wrap				= wrap_V ;
		Select				= select_V ;
		Enter				= enter_V ;
		Show				= show_V ;

-- Nouns
		Language			= language_N ;
		Node				= node_N ;
		Tree				= tree_N ;
		Refinement			= refinement_N ;
		Wrapper				= wrapper_N ;
		String				= string_N ;
		Page				= page_N ;
		Danish				= danish_N ;
		English				= english_N ;
		Finnish				= finnish_N ;
		French				= french_N ;
		German				= german_N ;
		Italian				= italian_N ;
		Norwegian			= norwegian_N ;
		Russian				= russian_N ;
		Spanish				= spanish_N ;
		Swedish				= swedish_N ;

-- Adjectives
		NoAdj				= noAdj_A ;
		Available			= available_A ;
		Next				= next_A ;
		Previous			= previous_A ;

-- Determiners
		DefSgDet			= defSg_Det ;
		DefPlDet			= defPl_Det ;
		IndefSgDet			= indefSg_Det ;
		IndefPlDet			= indefPl_Det ;
		This				= this_Det ;

}
