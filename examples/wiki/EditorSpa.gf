
--# -path=.:present:prelude

concrete EditorSpa of Editor = EditorI with

	(Syntax		= SyntaxSpa),
	(LexEditor	= LexEditorSpa) ;
