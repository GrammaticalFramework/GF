----------------------------------------------------------------------
-- |
-- Module      : Randomized
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:51 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- random generation and refinement. AR 22\/8\/2001.
-- implemented as sequence of refinement menu selecsions, encoded as integers
-----------------------------------------------------------------------------

module GF.UseGrammar.Randomized where

import GF.Grammar.Abstract
import GF.UseGrammar.Editing

import GF.Data.Operations
import GF.Data.Zipper

--- import Arch (myStdGen) --- circular for hbc
import System.Random --- (mkStdGen, StdGen, randoms) --- bad import for hbc

-- random generation and refinement. AR 22/8/2001
-- implemented as sequence of refinement menu selecsions, encoded as integers

myStdGen :: Int -> StdGen
myStdGen = mkStdGen ---

-- | build one random tree; use mx to prevent infinite search
mkRandomTree :: StdGen -> Int -> CGrammar -> Either Cat Fun -> Err Tree
mkRandomTree gen mx gr cat = mkTreeFromInts (take mx (randoms gen)) gr cat

refineRandom :: StdGen -> Int -> CGrammar -> Action
refineRandom gen mx = mkStateFromInts $ take mx $ map abs (randoms gen)

-- | build a tree from a list of integers
mkTreeFromInts :: [Int] -> CGrammar -> Either Cat Fun -> Err Tree
mkTreeFromInts ints gr catfun = do
  st0   <- either (\cat -> newCat gr cat initState)
                  (\fun -> newFun gr fun initState)
                  catfun
  state <- mkStateFromInts ints gr st0
  return $ loc2tree state

mkStateFromInts :: [Int] -> CGrammar -> Action
mkStateFromInts ints gr z = mkRandomState ints z >>= reCheckState gr where
  mkRandomState [] state = do
    testErr (isCompleteState state) "not completed"
    return state
  mkRandomState (n:ns) state = do 
    let refs  = refinementsState gr state
        refs0 = map (not . snd . snd) refs
    testErr (not (null refs0)) $ "no nonrecursive refinements available for" +++ 
                                              prt (actVal state)
    (ref,_) <- (refs !? (n `mod` (length refs)))
    state1  <- refineWithAtom False gr ref state
    if isCompleteState state1 
       then return state1
       else do 
         state2  <- goNextMeta state1
	 mkRandomState ns state2

