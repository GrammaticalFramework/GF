----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/19 10:46:07 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- MCFG parsing
-----------------------------------------------------------------------------

module GF.NewParsing.MCFG where

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG

import qualified GF.NewParsing.MCFG.Naive as Naive
import qualified GF.NewParsing.MCFG.Range as Range (makeRange)

----------------------------------------------------------------------
-- parsing

--parseMCF :: (Ord n, Ord c, Ord t) => String -> CFParser c n t 
parseMCF "n" = Naive.parse 
-- default parser:
parseMCF _   = parseMCF "n"


makeFinalEdge cat lbl bnds = (cat, [(lbl, Range.makeRange bnds)])



