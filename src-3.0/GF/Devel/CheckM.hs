----------------------------------------------------------------------
-- |
-- Module      : CheckM
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:33 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Devel.CheckM (Check,
	       checkError, checkCond, checkWarn, checkUpdate, checkInContext,
	       checkUpdates, checkReset, checkResets, checkGetContext, 
	       checkLookup, checkStart, checkErr, checkVal, checkIn, 
	       prtFail
	      ) where

import GF.Data.Operations
import GF.Devel.Grammar.Grammar
import GF.Infra.Ident
import GF.Devel.Grammar.PrGF

-- | the strings are non-fatal warnings
type Check a = STM (Context,[String]) a

checkError :: String -> Check a
checkError = raise

checkCond :: String -> Bool -> Check ()
checkCond s b = if b then return () else checkError s

-- | warnings should be reversed in the end
checkWarn :: String -> Check ()
checkWarn s = updateSTM (\ (cont,msg) -> (cont, s:msg))

checkUpdate :: Decl -> Check ()
checkUpdate d = updateSTM (\ (cont,msg) -> (d:cont, msg))

checkInContext :: [Decl] -> Check r -> Check r
checkInContext g ch = do
  i <- checkUpdates g
  r <- ch
  checkResets i
  return r

checkUpdates :: [Decl] -> Check Int
checkUpdates ds = mapM checkUpdate ds >> return (length ds)

checkReset :: Check ()
checkReset = checkResets 1

checkResets :: Int -> Check ()
checkResets i = updateSTM (\ (cont,msg) -> (drop i cont, msg))

checkGetContext :: Check Context
checkGetContext = do
  (co,_) <- readSTM
  return co

checkLookup :: Ident -> Check Type
checkLookup x = do
  co <- checkGetContext
  checkErr $ maybe (prtBad "unknown variable" x) return $ lookup x co

checkStart :: Check a -> Err (a,(Context,[String]))
checkStart c = appSTM c ([],[])

checkErr :: Err a -> Check a
checkErr e = stm (\s -> do
  v <- e
  return (v,s)
  )

checkVal :: a -> Check a
checkVal v = return v

prtFail :: Print a => String -> a -> Check b
prtFail s t = checkErr $ prtBad s t

checkIn :: String -> Check a -> Check a
checkIn msg c = stm $ \s@(g,ws) -> case appSTM c s of
  Bad e -> Bad $ msg ++++ e
  Ok (v,(g',ws')) -> Ok (v,(g',ws2)) where
    new = take (length ws' - length ws) ws'
    ws2 = [msg ++++ w | w <- new] ++ ws
