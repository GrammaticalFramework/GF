----------------------------------------------------------------------
-- |
-- Module      : TreeSelections
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- choose shallowest trees, and remove an overload resolution prefix
-----------------------------------------------------------------------------

module GF.UseGrammar.TreeSelections (

  getOverloadResults, smallestTrs, sizeTr, depthTr

  ) where

import GF.Grammar.Abstract
import GF.Grammar.Macros

import GF.Data.Operations
import GF.Data.Zipper
import Data.List

-- AR 2/7/2007
-- The top-level function takes a set of trees (typically parses)
-- and returns the list of those trees that have the minimum size.
-- In addition, the overload prefix "ovrld123_", is removed
-- from each constructor in which it appears. This is used for 
-- showing the library API constructors in a parsable grammar.
-- TODO: access the generic functions smallestTrs, sizeTr, depthTr from shell

getOverloadResults :: [Tree] -> [Tree]
getOverloadResults = smallestTrs sizeTr . map (mkOverload "ovrld") 

-- NB: this does not always give the desired result, since
-- some genuine alternatives may be deeper: now we will exclude the 
-- latter of
--
--   mkCl this_NP love_V2 (mkNP that_NP here_Adv)
--   mkCl this_NP (mkVP (mkVP love_V2 that_NP) here_Adv)
--
-- A perfect method would know the definitional equivalences of constructors.
--
-- Notice also that size is a better measure than depth, because:
-- 1. Global depth does not exclude the latter of
--
--   mkCl (mkNP he_Pron) love_V2 that_NP
--   mkCl (mkNP he_Pron) (mkVP love_V2 that_NP)
--
-- 2. Length is needed to exclude the latter of
--
--   mkS (mkCl (mkNP he_Pron) love_V2 that_NP)
--   mkS presentTense (mkCl (mkNP he_Pron) love_V2 that_NP)
--

smallestTrs :: (Tr a -> Int) -> [Tr a] -> [Tr a]
smallestTrs size ts = map fst $ filter ((==mx) . snd) tds where
  tds = [(t, size t) | t <- ts]
  mx = minimum $ map snd tds

depthTr :: Tr a -> Int
depthTr (Tr (_, ts)) = case ts of
  [] -> 1
  _ -> 1 + (maximum $ map depthTr ts)

sizeTr :: Tr a -> Int
sizeTr (Tr (_, ts)) = 1 + sum (map sizeTr ts)

-- remove from each constant a prefix starting with "pref", up to first "_"
-- example format: ovrld123_mkNP

mkOverload :: String -> Tree -> Tree
mkOverload pref = mapTr (changeAtom overAtom) where
  overAtom a = case a of
    AtC (m, IC f) | isPrefixOf pref f ->
      AtC (m, IC (tail (dropWhile (/='_') f)))
    _ -> a
