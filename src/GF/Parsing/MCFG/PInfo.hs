---------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/19 10:46:08 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- MCFG parsing, parser information
-----------------------------------------------------------------------------

module GF.NewParsing.MCFG.PInfo
    (MCFParser, MCFPInfo(..), buildMCFPInfo) where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Data.SortedList
import GF.Data.Assoc

----------------------------------------------------------------------
-- type declarations

-- | the list of categories = possible starting categories
type MCFParser c n l t = MCFPInfo c n l t 
		       -> [c]
		       -> Input t
		       -> MCFChart c n l

type MCFChart  c n l   = [(n, (c, RangeRec l), [(c, RangeRec l)])]

type MCFPInfo  c n l t = MCFGrammar c n l t

buildCFPInfo :: (Ord n, Ord c, Ord l, Ord t) => MCFGrammar c n l t -> MCFPInfo c n l t
buildCFPInfo = id

