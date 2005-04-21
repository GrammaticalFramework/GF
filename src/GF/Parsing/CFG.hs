----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:05 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.4 $
--
-- CFG parsing
-----------------------------------------------------------------------------

module GF.Parsing.CFG
    (parseCF, module GF.Parsing.CFG.PInfo) where

import GF.Data.Operations (Err(..))

import GF.Formalism.Utilities
import GF.Formalism.CFG
import GF.Parsing.CFG.PInfo

import qualified GF.Parsing.CFG.Incremental as Inc
import qualified GF.Parsing.CFG.General as Gen

----------------------------------------------------------------------
-- parsing

parseCF :: (Ord n, Ord c, Ord t) => String -> Err (CFParser c n t) 
parseCF "gb"    = Ok $ Gen.parse bottomup
parseCF "gt"    = Ok $ Gen.parse topdown
parseCF "ib"    = Ok $ Inc.parse (bottomup, noFilter)
parseCF "it"    = Ok $ Inc.parse (topdown, noFilter)
parseCF "ibFT"  = Ok $ Inc.parse (bottomup, topdown)
parseCF "ibFB"  = Ok $ Inc.parse (bottomup, bottomup)
parseCF "ibFTB" = Ok $ Inc.parse (bottomup, bothFilters)
parseCF "itF"   = Ok $ Inc.parse (topdown, bottomup)
-- default parser:
parseCF "" = parseCF "gb"
-- error parser:
parseCF prs = Bad $ "Parser not defined: " ++ prs

bottomup = (True, False)
topdown = (False, True)
noFilter = (False, False)
bothFilters = (True, True)


