
--# -path=.:present:prelude

concrete WikiEng of Wiki = WikiI with

	(Syntax		= SyntaxEng),
	(LexWiki	= LexWikiEng) ;
