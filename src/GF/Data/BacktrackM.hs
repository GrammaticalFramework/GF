----------------------------------------------------------------------
-- |
-- Module      : BacktrackM
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/29 11:17:54 $
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Backtracking state monad, with r\/o environment
-----------------------------------------------------------------------------


module GF.Data.BacktrackM ( -- * the backtracking state monad
		    BacktrackM,
		    -- * controlling the monad
		    failure,
		    (|||),
		    -- * handling the state & environment
		    readEnv,
		    readState,
		    writeState,
		    -- * monad specific utilities
		    member,
		    -- * running the monad
		    runBM,
		    solutions,
		    finalStates
		  ) where

import Monad

------------------------------------------------------------
-- type declarations

-- * controlling the monad

failure :: BacktrackM e s a
(|||)   :: BacktrackM e s a -> BacktrackM e s a -> BacktrackM e s a

instance MonadPlus (BacktrackM e s) where
    mzero = failure
    mplus = (|||)

-- * handling the state & environment

readEnv    :: BacktrackM e s e
readState  :: BacktrackM e s s
writeState :: s -> BacktrackM e s ()

-- * monad specific utilities

member :: [a] -> BacktrackM e s a
member = msum . map return 

-- * running the monad

runBM       :: BacktrackM e s a  -> e -> s -> [(s, a)]

solutions   :: BacktrackM e s a  -> e -> s -> [a]
solutions   bm e s = map snd $ runBM bm e s 

finalStates :: BacktrackM e s () -> e -> s -> [s]
finalStates bm e s = map fst $ runBM bm e s


{-
----------------------------------------------------------------------
-- implementation as lists of successes

newtype BacktrackM e s a = BM (e -> s -> [(s, a)])

runBM       (BM m) = m

readEnv      = BM (\e s -> [(s, e)])
readState    = BM (\e s -> [(s, s)])
writeState s = BM (\e _ -> [(s, ())])

failure       = BM (\e s -> [])
BM m ||| BM n = BM (\e s -> m e s ++ n e s)

instance Monad (BacktrackM e s) where
    return a   = BM (\e s -> [(s, a)])
    BM m >>= k = BM (\e s -> concat [ n e s' | (s', a) <- m e s, let BM n = k a ])
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

newtype BacktrackM e s a = BM (e -> s -> Backtr (s, a))

runBM (BM m) e s = runB (m e s)

readEnv      = BM (\e s -> return (s, e))
readState    = BM (\e s -> return (s, s))
writeState s = BM (\e _ -> return (s, ()))

failure = BM (\e s -> failureB)
BM m ||| BM n = BM (\e s -> m e s |||| n e s)

instance Monad (BacktrackM e s) where
    return a   = BM (\e s -> return (s, a))
    BM m >>= k = BM (\e s -> do (s', a) <- m e s 
		                unBM (k a) e s')
	where unBM (BM m) = m
