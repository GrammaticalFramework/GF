
--# -path=.:present:prelude

concrete EditorFin of Editor = EditorI with

	(Syntax		= SyntaxFin),
	(LexEditor	= LexEditorFin) ;
