----------------------------------------------------------------------
-- |
-- Module      : ConvertMCFGtoCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/29 11:17:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Converting MCFG grammars to (possibly overgenerating) CFG
-----------------------------------------------------------------------------


module GF.Parsing.ConvertMCFGtoCFG
    (convertGrammar) where

import GF.System.Tracing
import GF.Printing.PrintParser

import Monad
import GF.Parsing.Utilities
import qualified GF.Parsing.MCFGrammar as MCFG
import qualified GF.Parsing.CFGrammar as CFG
import GF.Parsing.GrammarTypes

convertGrammar :: MCFGrammar -> CFGrammar
convertGrammar gram = tracePrt "#cf-rules" (prt.length) $
		      concatMap convertRule gram

convertRule :: MCFRule -> [CFRule]
convertRule (MCFG.Rule cat args record name) 
    = [ CFG.Rule (CFCat cat lbl) rhs (CFName name profile) |
	MCFG.Lin lbl lin <- record,
	let rhs = map (mapSymbol convertArg id) lin,
	let profile = map (argPlaces lin) [0 .. length args-1]
      ]

convertArg (cat, lbl, _arg) = CFCat cat lbl

argPlaces lin arg = [ place | ((_cat, _lbl, arg'), place) <- 
		      zip (filterCats lin) [0::Int ..], arg == arg' ]

filterCats syms = [ cat | Cat cat <- syms ]







