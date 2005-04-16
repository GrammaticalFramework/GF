----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- Converting MCFG grammars to (possibly overgenerating) CFG
-----------------------------------------------------------------------------


module GF.Conversion.MCFGtoCFG
    (convertGrammar, convertNEGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import Monad
import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.CFG
import GF.Conversion.Types

----------------------------------------------------------------------
-- * converting (possibly erasing) MCFG grammars

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

----------------------------------------------------------------------
-- * converting nonerasing MCFG grammars

convertNEGrammar :: NGrammar -> CGrammar
convertNEGrammar gram = tracePrt "#context-free rules" (prt.length) $
			concatMap convertNERule gram

convertNERule :: NRule -> [CRule]
convertNERule (Rule (Abs ncat args (Name fun mprofile)) (Cnc _ _ record)) 
    = [ CFRule (CCat (ncat2mcat ncat) lbl) rhs (Name fun profile) |
	Lin lbl lin <- record,
	let rhs = map (mapSymbol convertNEArg id) lin,
	let cprofile = map (Unify . argPlaces lin) [0 .. length args-1],
	let profile = mprofile `composeProfiles` cprofile
      ]

convertNEArg :: (NCat, NLabel, Int) -> CCat
convertNEArg (ncat, lbl, _) = CCat (ncat2mcat ncat) lbl

----------------------------------------------------------------------




