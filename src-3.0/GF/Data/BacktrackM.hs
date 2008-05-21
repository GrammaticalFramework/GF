----------------------------------------------------------------------
-- |
-- Module      : BacktrackM
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:00 $
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.4 $
--
-- Backtracking state monad, with r\/o environment
-----------------------------------------------------------------------------

{-# OPTIONS_GHC -fglasgow-exts #-}
module GF.Data.BacktrackM ( -- * the backtracking state monad
		    BacktrackM,
		    -- * controlling the monad
		    failure,
		    (|||),
		    -- * handling the state & environment
		    readState,
		    writeState,
		    -- * monad specific utilities
		    member,
		    -- * running the monad
		    foldBM,          runBM,
		    foldSolutions,   solutions,
		    foldFinalStates, finalStates
		  ) where

import Data.List
import Control.Monad

----------------------------------------------------------------------
-- Combining endomorphisms and continuations
-- a la Ralf Hinze

-- BacktrackM = state monad transformer over the backtracking monad

newtype BacktrackM s a = BM (forall b . (a -> s -> b -> b) -> s -> b -> b)

-- * running the monad

runBM :: BacktrackM s a -> s -> [(s,a)]
runBM (BM m) s = m (\x s xs -> (s,x) : xs) s []

foldBM :: (a -> s -> b -> b) -> b -> BacktrackM s a -> s -> b
foldBM f b (BM m) s = m f s b

foldSolutions   :: (a -> b -> b) -> b -> BacktrackM s a -> s -> b
foldSolutions f b (BM m) s = m (\x s b -> f x b) s b

solutions   :: BacktrackM s a  -> s -> [a]
solutions = foldSolutions (:) []

foldFinalStates :: (s -> b -> b) -> b -> BacktrackM s () -> s -> b
foldFinalStates f b (BM m) s = m (\x s b -> f s b) s b

finalStates :: BacktrackM s () -> s -> [s]
finalStates bm = map fst . runBM bm


-- * handling the state & environment

readState :: BacktrackM s s
readState    = BM (\c s b -> c s s b)

writeState :: s -> BacktrackM s ()
writeState s = BM (\c _ b -> c () s b)

instance Monad (BacktrackM s) where
    return a   = BM (\c s b -> c a s b)
    BM m >>= k = BM (\c s b -> m (\a s b -> unBM (k a) c s b) s b)
	where unBM (BM m) = m
    fail _ = failure

-- * controlling the monad

failure :: BacktrackM s a
failure = BM (\c s b -> b)

(|||) :: BacktrackM s a -> BacktrackM s a -> BacktrackM s a
(BM f) ||| (BM g) = BM (\c s b -> g c s $! f c s b)

instance MonadPlus (BacktrackM s) where
    mzero = failure
    mplus = (|||)

-- * specific functions on the backtracking monad

member :: [a] -> BacktrackM s a
member xs = BM (\c s b -> foldl' (\b x -> c x s b) b xs)
