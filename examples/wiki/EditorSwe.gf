
--# -path=.:present:prelude

concrete EditorSwe of Editor = EditorI with

	(Syntax		= SyntaxSwe),
	(LexEditor	= LexEditorSwe) ;
