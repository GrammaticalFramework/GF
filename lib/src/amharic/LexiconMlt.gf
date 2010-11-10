--# -path=alltenses

concrete LexiconMlt of Lexicon = open ResMlt, Prelude in {
 
--CatMlt **
--open ParadigmsMlt, ResMlt, Prelude in { 

	flags optimize=values ; coding=utf8 ;
	
	lin
		{- ===== VERBS ===== -}
		
	--	cut_V2 = mkVerb "qata'" "aqta'" "aqtgħu" ;
	--	write_V2 = mkVerb "kiteb" ;
	--	break_V2 = mkVerb "kiser" ;
--		find_V2 = mkVerb "ħareġ" ;
	--	throw_V2 = mkVerb "tefa'" ;
	--	hear_V2 = mkVerb "sama'" "isma'" "isimgħu" ;
	--	fear_V2 = mkVerb "beża'" ;
--		fear_V2 = mkVerb "ħareġ" ;
--		pray_V = mkVerb "talab" "itlob" "itolbu"
	--	understand_V2 = mkVerb "fehem" ;
	--	pull_V2 = mkVerb "ġibed" ;
		--walk_V = mkVerb "mexa'" ;
		
		die_V = mkVerb "qarmeċ" ;
		
		
		{- ===== NOUNS ===== -}
		
		airplane_N = mkNoun "ajruplan" Masc ;
		apple_N = mkNoun "tuffieħa" Fem ;
  
--	oper
		-- Define different possible patterns
		{-
		pattern_AA : Pattern = { v1 = "a" ; v2 = "a" } ; -- eg QASAM
		pattern_AE : Pattern = { v1 = "a" ; v2 = "e" } ; -- eg QABEŻ
		pattern_EE : Pattern = { v1 = "e" ; v2 = "e" } ; -- eg QERED
		pattern_EA : Pattern = { v1 = "e" ; v2 = "a" } ; -- eg SERAQ
		pattern_IE : Pattern = { v1 = "i" ; v2 = "e" } ; -- eg KITEB
		pattern_OO : Pattern = { v1 = "o" ; v2 = "o" } ; -- eg QOROB
		pattern_OA : Pattern = { v1 = "o" ; v2 = "o" } ; -- GĦOLA, GĦOXA, ĦOLA (only!)
		-}
		
		--Define some roots
		{-
		root_HTF : Root = { K = "ħ" ; T = "t" ; B = "f" ; L=[] } ; -- pattern: AA
		root_HRG : Root = { K = "ħ" ; T = "r" ; B = "ġ" ; L=[] } ; -- pattern: AE
		root_QRD : Root = { K = "q" ; T = "r" ; B = "d" ; L=[] } ; -- pattern: EE
		root_SRQ : Root = { K = "s" ; T = "r" ; B = "q" ; L=[] } ; -- pattern: EA
		root_KTB : Root = { K = "k" ; T = "t" ; B = "b" ; L=[] } ; -- pattern: IE
		root_QRB : Root = { K = "q" ; T = "r" ; B = "b" ; L=[] } ; -- pattern: oo
		root_GMGM : Root = { K = "g" ; T = "m" ; B = "g" ; L = "m" } ;
		root_MQDR : Root = { K = "m" ; T = "q" ; B = "d" ; L = "r" } ;
		-}
} ;
