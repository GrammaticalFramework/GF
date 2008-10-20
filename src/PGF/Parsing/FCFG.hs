----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- FCFG parsing
-----------------------------------------------------------------------------

module PGF.Parsing.FCFG
    (ParserInfo,parseFCFG) where

import GF.Data.ErrM
import GF.Data.Assoc
import GF.Data.SortedList 

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.Parsing.FCFG.Utilities
import qualified PGF.Parsing.FCFG.Active      as Active
import qualified PGF.Parsing.FCFG.Incremental as Incremental

import qualified Data.Map as Map

----------------------------------------------------------------------
-- parsing

-- main parsing function

parseFCFG :: String           -- ^ parsing strategy
         -> ParserInfo        -- ^ compiled grammar (fcfg) 
         -> Type              -- ^ start type
         -> [String]          -- ^ input tokens
         -> Err [Tree]        -- ^ resulting GF terms
parseFCFG "bottomup"    pinfo typ toks = return $ Active.parse "b"  pinfo typ toks 
parseFCFG "topdown"     pinfo typ toks = return $ Active.parse "t"  pinfo typ toks 
parseFCFG "incremental" pinfo typ toks = return $ Incremental.parse pinfo typ toks 
parseFCFG strat         pinfo typ toks = fail   $ "FCFG parsing strategy not defined: " ++ strat
