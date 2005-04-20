----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/20 12:49:45 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- MCFG parsing
-----------------------------------------------------------------------------

module GF.NewParsing.MCFG
    (parseMCF, module GF.NewParsing.MCFG.PInfo) where

import Operations (Err(..))

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.NewParsing.MCFG.PInfo

import qualified GF.NewParsing.MCFG.Naive as Naive
import qualified GF.NewParsing.MCFG.Active as Active
import qualified GF.NewParsing.MCFG.Range as Range (makeRange)

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



