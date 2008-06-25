
--# -path=.:present:prelude

concrete EditorEng of Editor = EditorI with

	(Syntax		= SyntaxEng),
	(LexEditor	= LexEditorEng) ;
