----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:51 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- CFG parsing
-----------------------------------------------------------------------------

module GF.NewParsing.CFG 
    (parseCF, module GF.NewParsing.CFG.PInfo) where

import GF.Formalism.Utilities
import GF.Formalism.CFG
import GF.NewParsing.CFG.PInfo

import qualified GF.NewParsing.CFG.Incremental as Inc
import qualified GF.NewParsing.CFG.General     as Gen

----------------------------------------------------------------------
-- parsing

--parseCF :: (Ord n, Ord c, Ord t) => String -> CFParser c n t 
parseCF "gb" = Gen.parse bottomup
parseCF "gt" = Gen.parse topdown
parseCF "ib" = Inc.parse (bottomup, noFilter)
parseCF "it" = Inc.parse (topdown, noFilter)
parseCF "ibFT" = Inc.parse (bottomup, topdown)
parseCF "ibFB" = Inc.parse (bottomup, bottomup)
parseCF "ibFTB" = Inc.parse (bottomup, bothFilters)
parseCF "itF" = Inc.parse (topdown, bottomup)
-- default parser:
parseCF _ = parseCF "gb"

bottomup = (True, False)
topdown = (False, True)
noFilter = (False, False)
bothFilters = (True, True)


