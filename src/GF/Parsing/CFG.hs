----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/20 12:49:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- CFG parsing
-----------------------------------------------------------------------------

module GF.NewParsing.CFG 
    (parseCF, module GF.NewParsing.CFG.PInfo) where

import Operations (Err(..))

import GF.Formalism.Utilities
import GF.Formalism.CFG
import GF.NewParsing.CFG.PInfo

import qualified GF.NewParsing.CFG.Incremental as Inc
import qualified GF.NewParsing.CFG.General     as Gen

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


