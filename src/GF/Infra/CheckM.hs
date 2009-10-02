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
	       checkError, checkCond, checkWarn, 
	       checkErr, checkIn, checkMap
	      ) where

import GF.Data.Operations
import GF.Infra.Ident
import GF.Grammar.Grammar
import GF.Grammar.Printer

import qualified Data.Map as Map
import Text.PrettyPrint

type Message = Doc
data CheckResult a
  = Fail      [Message]
  | Success a [Message]
newtype Check a = Check {unCheck :: Context -> [Message] -> CheckResult a}

instance Monad Check where
  return x = Check (\ctxt msgs -> Success x msgs)
  f >>= g  = Check (\ctxt msgs -> case unCheck f ctxt msgs of
                                    Success x msgs -> unCheck (g x) ctxt msgs
                                    Fail msgs      -> Fail msgs)

instance ErrorMonad Check where
  raise s = checkError (text s)
  handle f h = Check (\ctxt msgs -> case unCheck f ctxt msgs of
                                      Success x msgs  -> Success x msgs
                                      Fail (msg:msgs) -> unCheck (h (render msg)) ctxt msgs)

checkError :: Message -> Check a
checkError msg = Check (\ctxt msgs -> Fail (msg : msgs))

checkCond :: Message -> Bool -> Check ()
checkCond s b = if b then return () else checkError s

-- | warnings should be reversed in the end
checkWarn :: Message -> Check ()
checkWarn msg = Check (\ctxt msgs -> Success () ((text "Warning:" <+> msg) : msgs))

runCheck :: Check a -> Err (a,String)
runCheck c =
  case unCheck c [] [] of
    Fail msgs      -> Bad (   render (vcat (reverse msgs)))
    Success v msgs -> Ok  (v, render (vcat (reverse msgs)))

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
    Fail      msgs' -> Fail ((msg $$ nest 3 (vcat (reverse msgs'))) : msgs)
    Success v msgs' | null msgs' -> Success v msgs
                    | otherwise  -> Success v ((msg $$ nest 3 (vcat (reverse msgs'))) : msgs)
