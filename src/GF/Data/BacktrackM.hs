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
		    runBM,
		    solutions,
		    finalStates
		  ) where

import Control.Monad

------------------------------------------------------------
-- type declarations

-- * controlling the monad

failure :: BacktrackM s a
(|||)   :: BacktrackM s a -> BacktrackM s a -> BacktrackM s a

instance MonadPlus (BacktrackM s) where
    mzero = failure
    mplus = (|||)

-- * handling the state & environment

readState  :: BacktrackM s s
writeState :: s -> BacktrackM s ()

-- * specific functions on the backtracking monad

member :: [a] -> BacktrackM s a
member = msum . map return 

-- * running the monad

runBM       :: BacktrackM s a  -> s -> [(s, a)]

solutions   :: BacktrackM s a  -> s -> [a]
solutions   bm = map snd . runBM bm 

finalStates :: BacktrackM s () -> s -> [s]
finalStates bm = map fst . runBM bm


{-
----------------------------------------------------------------------
-- implementation as lists of successes

newtype BacktrackM s a = BM (s -> [(s, a)])

runBM       (BM m) = m

readState    = BM (\s -> [(s, s)])
writeState s = BM (\_ -> [(s, ())])

failure       = BM (\s -> [])
BM m ||| BM n = BM (\s -> m s ++ n s)

instance Monad (BacktrackM s) where
    return a   = BM (\s -> [(s, a)])
    BM m >>= k = BM (\s -> concat [ n s' | (s', a) <- m s, let BM n = k a ])
    fail _     = failure
-}

----------------------------------------------------------------------
-- Combining endomorphisms and continuations
-- a la Ralf Hinze

newtype Backtr a = B (forall b . (a -> b -> b) -> b -> b)

instance Monad Backtr where
    return a  = B (\c f -> c a f)
    B m >>= k = B (\c f -> m (\a -> unBacktr (k a) c) f)
        where unBacktr (B m) = m

failureB     = B (\c f -> f)
B m |||| B n = B (\c f -> m c (n c f))

runB (B m) = m (:) []

-- BacktrackM = state monad transformer over the backtracking monad

newtype BacktrackM s a = BM (s -> Backtr (s, a))

runBM (BM m) s = runB (m s)

readState    = BM (\s -> return (s, s))
writeState s = BM (\_ -> return (s, ()))

failure = BM (\s -> failureB)
BM m ||| BM n = BM (\s -> m s |||| n s)

instance Monad (BacktrackM s) where
    return a   = BM (\s -> return (s, a))
    BM m >>= k = BM (\s -> do (s', a) <- m s ; unBM (k a) s')
	where unBM (BM m) = m
