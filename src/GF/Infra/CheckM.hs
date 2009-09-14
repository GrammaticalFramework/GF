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

module GF.Infra.CheckM
          (Check, Message, runCheck,
	       checkError, checkCond, checkWarn, checkUpdate, checkInContext,
	       checkUpdates, checkReset, checkResets, checkGetContext, 
	       checkLookup, checkErr, checkIn, checkMap
	      ) where

import GF.Data.Operations
import GF.Infra.Ident
import GF.Grammar.Grammar
import GF.Grammar.Printer

import qualified Data.Map as Map
import Text.PrettyPrint

type Message = Doc
data CheckResult a
  = Fail              [Message]
  | Success a Context [Message]
newtype Check a = Check {unCheck :: Context -> [Message] -> CheckResult a}

instance Monad Check where
  return x = Check (\ctxt msgs -> Success x ctxt msgs)
  f >>= g  = Check (\ctxt msgs -> case unCheck f ctxt msgs of
                                    Success x ctxt msgs -> unCheck (g x) ctxt msgs
                                    Fail msgs           -> Fail msgs)

instance ErrorMonad Check where
  raise s = checkError (text s)
  handle f h = Check (\ctxt msgs -> case unCheck f ctxt msgs of
                                      Success x ctxt msgs -> Success x ctxt msgs
                                      Fail (msg:msgs)     -> unCheck (h (render msg)) ctxt msgs)

checkError :: Message -> Check a
checkError msg = Check (\ctxt msgs -> Fail (msg : msgs))

checkCond :: Message -> Bool -> Check ()
checkCond s b = if b then return () else checkError s

-- | warnings should be reversed in the end
checkWarn :: Message -> Check ()
checkWarn msg = Check (\ctxt msgs -> Success () ctxt ((text "Warning:" <+> msg) : msgs))

checkUpdate :: Decl -> Check ()
checkUpdate d = Check (\ctxt msgs -> Success () (d:ctxt) msgs)

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
checkResets i = Check (\ctxt msgs -> Success () (drop i ctxt) msgs)

checkGetContext :: Check Context
checkGetContext = Check (\ctxt msgs -> Success ctxt ctxt msgs)

checkLookup :: Ident -> Check Type
checkLookup x = do
  co <- checkGetContext
  case lookup x co of
    Nothing -> checkError (text "unknown variable" <+> ppIdent x)
    Just ty -> return ty

runCheck :: Check a -> Either [Message] (a,Context,[Message])
runCheck c =
  case unCheck c [] [] of
    Fail msgs           -> Left          msgs
    Success v ctxt msgs -> Right (v,ctxt,msgs)

checkMap :: (Ord a) => (a -> b -> Check b) -> Map.Map a b -> Check (Map.Map a b)
checkMap f map = do xs <- mapM (\(k,v) -> do v <- f k v
                                             return (k,v)) (Map.toList map)
                    return (Map.fromAscList xs)

checkErr :: Err a -> Check a
checkErr (Ok x)    = return x
checkErr (Bad err) = checkError (text err)

checkIn :: Doc -> Check a -> Check a
checkIn msg c = Check $ \ctxt msgs ->
  case unCheck c ctxt [] of
    Fail            msgs' -> Fail ((msg $$ nest 3 (vcat (reverse msgs'))) : msgs)
    Success v ctxt' msgs' | null msgs' -> Success v ctxt' msgs
                          | otherwise  -> Success v ctxt' ((msg $$ nest 3 (vcat (reverse msgs'))) : msgs)
