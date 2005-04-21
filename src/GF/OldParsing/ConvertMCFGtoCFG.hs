----------------------------------------------------------------------
-- |
-- Module      : ConvertMCFGtoCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:46 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Converting MCFG grammars to (possibly overgenerating) CFG
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertMCFGtoCFG
    (convertGrammar) where

import GF.System.Tracing
import GF.Printing.PrintParser

import Control.Monad
import GF.OldParsing.Utilities
import qualified GF.OldParsing.MCFGrammar as MCFG
import qualified GF.OldParsing.CFGrammar as CFG
import GF.OldParsing.GrammarTypes

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







