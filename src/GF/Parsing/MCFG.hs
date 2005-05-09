----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:45 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
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
import qualified GF.Parsing.MCFG.Active2 as Active2
import qualified GF.Parsing.MCFG.Incremental as Incremental
import qualified GF.Parsing.MCFG.Incremental2 as Incremental2

----------------------------------------------------------------------
-- parsing

-- parseMCF :: (Ord c, Ord n, Ord l, Ord t) => String -> Err (MCFParser c n l t)

parseMCF "n"  pinfo starts toks = Ok $ Naive.parse pinfo starts toks 
parseMCF "an" pinfo starts toks = Ok $ Active.parse "n" pinfo starts toks 
parseMCF "ab" pinfo starts toks = Ok $ Active.parse "b" pinfo starts toks 
parseMCF "at" pinfo starts toks = Ok $ Active.parse "t" pinfo starts toks 
parseMCF "i"  pinfo starts toks = Ok $ Incremental.parse pinfo starts toks 

parseMCF "an2" pinfo starts toks = Ok $ Active2.parse "n" pinfo starts toks 
parseMCF "ab2" pinfo starts toks = Ok $ Active2.parse "b" pinfo starts toks 
parseMCF "at2" pinfo starts toks = Ok $ Active2.parse "t" pinfo starts toks 
parseMCF "i2"  pinfo starts toks = Ok $ Incremental2.parse pinfo starts toks

parseMCF "rn"  pinfo starts toks = Ok $ Naive.parseR (rrP pinfo toks) starts 
parseMCF "ran" pinfo starts toks = Ok $ Active.parseR "n" (rrP pinfo toks) starts 
parseMCF "rab" pinfo starts toks = Ok $ Active.parseR "b" (rrP pinfo toks) starts 
parseMCF "rat" pinfo starts toks = Ok $ Active.parseR "t" (rrP pinfo toks) starts 
parseMCF "ri"  pinfo starts toks = Ok $ Incremental.parseR (rrP pinfo toks) starts ntoks
    where ntoks = snd (inputBounds toks)

-- default parsers:
parseMCF ""  pinfo starts toks = parseMCF "n"  pinfo starts toks 
-- error parser:
parseMCF prs pinfo starts toks  = Bad $ "Parser not defined: " ++ prs 


rrP pi = rangeRestrictPInfo pi
