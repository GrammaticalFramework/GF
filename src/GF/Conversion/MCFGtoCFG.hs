----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/12 10:49:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Converting MCFG grammars to (possibly overgenerating) CFG
-----------------------------------------------------------------------------


module GF.Conversion.MCFGtoCFG
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import Monad
import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.CFG
import GF.Conversion.Types

convertGrammar :: MGrammar -> CGrammar
convertGrammar gram = tracePrt "#context-free rules" (prt.length) $
		      concatMap convertRule gram

convertRule :: MRule -> [CRule]
convertRule (Rule (Abs cat args (Name fun mprofile)) (Cnc _ _ record)) 
    = [ CFRule (CCat cat lbl) rhs (Name fun profile) |
	Lin lbl lin <- record,
	let rhs = map (mapSymbol convertArg id) lin,
	let cprofile = map (Unify . argPlaces lin) [0 .. length args-1],
	let profile = mprofile `composeProfiles` cprofile
      ]

convertArg :: (MCat, MLabel, Int) -> CCat
convertArg (cat, lbl, _) = CCat cat lbl

argPlaces :: [Symbol (cat, lbl, Int) tok] -> Int -> [Int]
argPlaces lin nr  = [ place | (nr', place) <- zip linArgs [0..], nr == nr' ]
    where linArgs = [ nr' | (_, _, nr') <- filterCats lin ]




