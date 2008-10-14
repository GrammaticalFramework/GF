---------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- FCFG parsing, parser information
-----------------------------------------------------------------------------

module PGF.BuildParser where

import GF.Data.SortedList
import GF.Data.Assoc
import PGF.CId
import PGF.Data
import PGF.Parsing.FCFG.Utilities

import Data.Array.IArray
import Data.Maybe
import qualified Data.IntMap as IntMap
import qualified Data.Map as Map
import qualified Data.Set as Set
import Debug.Trace


data ParserInfoEx
  = ParserInfoEx { epsilonRules :: [(FunId,[FCat],FCat)]
	         , leftcornerCats   :: Assoc FCat   [(FunId,[FCat],FCat)]
	         , leftcornerTokens :: Assoc String [(FunId,[FCat],FCat)]
	         , grammarToks :: [String]
	         }

------------------------------------------------------------
-- parser information

getLeftCornerTok pinfo (FFun _ _ lins)
  | inRange (bounds syms) 0 = case syms ! 0 of
                                FSymTok (KS tok) -> [tok]
                                _                -> []
  | otherwise               = []
  where
    syms = (sequences pinfo) ! (lins ! 0)

getLeftCornerCat pinfo args (FFun _ _ lins)
  | inRange (bounds syms) 0 = case syms ! 0 of
                                FSymCat d _ -> let cat = args !! d
                                               in case IntMap.lookup cat (productions pinfo) of
                                                    Just set -> cat : [cat' | FCoerce cat' <- Set.toList set]
                                                    Nothing  -> [cat]
                                _           -> []
  | otherwise               = []
  where
    syms = (sequences pinfo) ! (lins ! 0)

buildParserInfo :: ParserInfo -> ParserInfoEx
buildParserInfo pinfo =
    ParserInfoEx { epsilonRules = epsilonrules
	         , leftcornerCats = leftcorncats
	         , leftcornerTokens = leftcorntoks
	         , grammarToks = grammartoks
	         }

    where epsilonrules  = [ (ruleid,args,cat)
                                   | (cat,set) <- IntMap.toList (productions pinfo)
	                           , (FApply ruleid args) <- Set.toList set
	                           , let (FFun _ _ lins) = (functions pinfo) ! ruleid
                                   , not (inRange (bounds ((sequences pinfo) ! (lins ! 0))) 0) ]
	  leftcorncats  = accumAssoc id [ (cat', (ruleid, args, cat))
	                                                | (cat,set) <- IntMap.toList (productions pinfo)
	                                                , (FApply ruleid args) <- Set.toList set
	                                                , cat' <- getLeftCornerCat pinfo args ((functions pinfo) ! ruleid) ]
	  leftcorntoks  = accumAssoc id [ (tok, (ruleid, args, cat))
	                                                | (cat,set) <- IntMap.toList (productions pinfo)
	                                                , (FApply ruleid args) <- Set.toList set
	                                                , tok <- getLeftCornerTok pinfo ((functions pinfo) ! ruleid) ]
	  grammartoks   = nubsort [t | lin <- elems (sequences pinfo), FSymTok (KS t) <- elems lin]
