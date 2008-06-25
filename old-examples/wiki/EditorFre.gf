
--# -path=.:present:prelude

concrete EditorFre of Editor = EditorI with

	(Syntax		= SyntaxFre),
	(LexEditor	= LexEditorFre) ;
