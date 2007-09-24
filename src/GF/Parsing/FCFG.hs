----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- FCFG parsing
-----------------------------------------------------------------------------

module GF.Parsing.FCFG
    (parseFCF, module GF.Parsing.FCFG.PInfo) where

import GF.Data.Operations (Err(..))

import GF.Formalism.Utilities
import GF.Parsing.FCFG.PInfo

import qualified GF.Parsing.FCFG.Active as Active
import GF.Infra.PrintClass

----------------------------------------------------------------------
-- parsing

parseFCF :: String -> Err (FCFParser)
parseFCF prs | prs `elem` strategies = Ok $ parseFCF' prs
	     | otherwise = Bad $ "FCFG parsing strategy not defined: " ++ prs 

strategies = words "bottomup topdown"

parseFCF' :: String -> FCFParser
parseFCF' "bottomup" pinfo starts toks = Active.parse "b" pinfo starts toks 
parseFCF' "topdown"  pinfo starts toks = Active.parse "t" pinfo starts toks 
