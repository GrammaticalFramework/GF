----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:07 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.3 $
--
-- MCFG parsing
-----------------------------------------------------------------------------

module GF.Parsing.MCFG
    (parseMCF, module GF.Parsing.MCFG.PInfo) where

import GF.Data.Operations (Err(..))

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Parsing.MCFG.PInfo

import qualified GF.Parsing.MCFG.Naive as Naive
import qualified GF.Parsing.MCFG.Active as Active
import qualified GF.Parsing.MCFG.Range as Range (makeRange)

----------------------------------------------------------------------
-- parsing

parseMCF :: (Ord c, Ord n, Ord l, Ord t) => String -> Err (MCFParser c n l t)
parseMCF "n" = Ok $ Naive.parse 
parseMCF "an" = Ok $ Active.parse "n"
parseMCF "ab" = Ok $ Active.parse "b"
parseMCF "at" = Ok $ Active.parse "t"
-- default parsers:
parseMCF "a"   = parseMCF "an"
-- error parser:
parseMCF prs = Bad $ "Parser not defined: " ++ prs



