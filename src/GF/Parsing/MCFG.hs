----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/11 10:28:16 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
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
import qualified GF.Parsing.MCFG.FastActive as FastActive
-- import qualified GF.Parsing.MCFG.Active2 as Active2
import qualified GF.Parsing.MCFG.Incremental as Incremental
-- import qualified GF.Parsing.MCFG.Incremental2 as Incremental2

----------------------------------------------------------------------
-- parsing

parseMCF :: (Ord c, Ord n, Ord l, Ord t) => String -> Err (MCFParser c n l t)
parseMCF prs | prs `elem` strategies = Ok $ parseMCF' prs
	     | otherwise = Bad $ "MCFG parsing strategy not defined: " ++ prs 


strategies = words "bottomup topdown n an ab at i rn ran rab rat ri ft fb"


parseMCF' :: (Ord c, Ord n, Ord l, Ord t) => String -> MCFParser c n l t

parseMCF' "bottomup" pinfo starts toks = parseMCF' "fb" pinfo starts toks 
parseMCF' "topdown"  pinfo starts toks = parseMCF' "ft" pinfo starts toks 

parseMCF' "n"  pinfo starts toks = Naive.parse pinfo starts toks 
parseMCF' "an" pinfo starts toks = Active.parse "n" pinfo starts toks 
parseMCF' "ab" pinfo starts toks = Active.parse "b" pinfo starts toks 
parseMCF' "at" pinfo starts toks = Active.parse "t" pinfo starts toks 
parseMCF' "i"  pinfo starts toks = Incremental.parse pinfo starts toks 

-- parseMCF' "an2" pinfo starts toks = Active2.parse "n" pinfo starts toks 
-- parseMCF' "ab2" pinfo starts toks = Active2.parse "b" pinfo starts toks 
-- parseMCF' "at2" pinfo starts toks = Active2.parse "t" pinfo starts toks 
-- parseMCF' "i2"  pinfo starts toks = Incremental2.parse pinfo starts toks

parseMCF' "rn"  pinfo starts toks = Naive.parseR (rrP pinfo toks) starts 
parseMCF' "ran" pinfo starts toks = Active.parseR "n" (rrP pinfo toks) starts 
parseMCF' "rab" pinfo starts toks = Active.parseR "b" (rrP pinfo toks) starts 
parseMCF' "rat" pinfo starts toks = Active.parseR "t" (rrP pinfo toks) starts 
parseMCF' "ri"  pinfo starts toks = Incremental.parseR (rrP pinfo toks) starts ntoks
    where ntoks = snd (inputBounds toks)

parseMCF' "fb" pinfo starts toks = FastActive.parse "b" (rrP pinfo toks) starts 
parseMCF' "ft" pinfo starts toks = FastActive.parse "t" (rrP pinfo toks) starts 

rrP pi = rangeRestrictPInfo pi
