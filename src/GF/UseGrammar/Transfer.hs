module Transfer where

import Grammar
import Values
import AbsCompute
import qualified GFC
import LookAbs
import MMacros
import TypeCheck

import Ident
import Operations

import Monad

-- linearize, parse, etc, by transfer. AR 9/10/2003

doTransfer :: GFC.CanonGrammar -> Ident -> Tree -> Err Tree
doTransfer gr tra t = do
  cat <- liftM snd $ val2cat $ valTree t
  f   <- lookupTransfer gr tra cat
  e   <- compute gr $ App f $ tree2exp t
  annotate gr e

useByTransfer :: (Tree -> Err a) -> GFC.CanonGrammar -> Ident -> (Tree -> Err a)
useByTransfer lin gr tra t = doTransfer gr tra t >>= lin

mkByTransfer :: (a -> Err [Tree]) -> GFC.CanonGrammar -> Ident -> (a -> Err [Tree])
mkByTransfer parse gr tra s = parse s >>= mapM (doTransfer gr tra)
