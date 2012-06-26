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
          (Check, CheckResult, Message, runCheck,
	   checkError, checkCond, checkWarn, checkWarnings, checkAccumError,
	   checkErr, checkIn, checkMap, checkMapRecover,
           parallelCheck, accumulateError, commitCheck,
	  ) where

import GF.Data.Operations
import GF.Infra.Ident
--import GF.Grammar.Grammar(Context)
import GF.Grammar.Printer

import qualified Data.Map as Map
import Text.PrettyPrint
import Control.Parallel.Strategies(parList,rseq,using)
import Control.Monad(liftM)

type Message = Doc
type Error   = Message
type Warning = Message
--data Severity = Warning | Error
--type NonFatal = ([Severity,Message]) -- preserves order
type NonFatal = ([Error],[Warning])
type Accumulate acc ans = acc -> (acc,ans)
data CheckResult a = Fail Error | Success a
newtype Check a
  = Check {unCheck :: {-Context ->-} Accumulate NonFatal (CheckResult a)}

instance Functor Check where fmap = liftM

instance Monad Check where
  return x = Check $ \{-ctxt-} ws -> (ws,Success x)
  f >>= g  = Check $ \{-ctxt-} ws ->
               case unCheck f {-ctxt-} ws of
                 (ws,Success x) -> unCheck (g x) {-ctxt-} ws
                 (ws,Fail msg)  -> (ws,Fail msg)

instance ErrorMonad Check where
  raise s = checkError (text s)
  handle f h = handle' f (h . render)

handle' f h = Check (\{-ctxt-} msgs -> case unCheck f {-ctxt-} msgs of
                                      (ws,Success x) -> (ws,Success x)
                                      (ws,Fail msg)  -> unCheck (h msg) {-ctxt-} ws)

-- | Report a fatal error
checkError :: Message -> Check a
checkError msg = Check (\{-ctxt-} ws -> (ws,Fail msg))

checkCond :: Message -> Bool -> Check ()
checkCond s b = if b then return () else checkError s

-- | warnings should be reversed in the end
checkWarn :: Message -> Check ()
checkWarn msg = Check $ \{-ctxt-} (es,ws) -> ((es,(text "Warning:" <+> msg) : ws),Success ())

checkWarnings = mapM_ checkWarn

-- | Report a nonfatal (accumulated) error
checkAccumError :: Message -> Check ()
checkAccumError msg = Check $ \{-ctxt-} (es,ws) -> ((msg:es,ws),Success ())

-- | Turn a fatal error into a nonfatal (accumulated) error
accumulateError :: (a -> Check a) -> a -> Check a
accumulateError chk a =
    handle' (chk a) $ \ msg -> do checkAccumError msg; return a

-- |  Turn accumulated errors into a fatal error
commitCheck :: Check a -> Check a
commitCheck c =
    Check $ \ {-ctxt-} msgs0@(es0,ws0) ->
    case unCheck c {-ctxt-} ([],[]) of
      (([],ws),Success v) -> ((es0,ws++ws0),Success v)
      (msgs   ,Success _) -> bad msgs0 msgs
      ((es,ws),Fail    e) -> bad msgs0 ((e:es),ws)
  where
    bad (es0,ws0) (es,ws) = ((es0,ws++ws0),Fail (list es))
    list = vcat . reverse

-- | Run an error check, report errors and warnings
runCheck :: Check a -> Err (a,String)
runCheck c =
    case unCheck c {-[]-} ([],[]) of
      (([],ws),Success v) -> Ok (v,render (list ws))
      (msgs   ,Success v) -> bad msgs
      ((es,ws),Fail    e) -> bad ((e:es),ws)
  where
    bad (es,ws) = Bad (render $ list ws $$ list es)
    list = vcat . reverse

parallelCheck :: [Check a] -> Check [a]
parallelCheck cs =
  Check $ \ {-ctxt-} (es0,ws0) ->
  let os = [unCheck c {-[]-} ([],[])|c<-cs] `using` parList rseq
      (msgs1,crs) = unzip os
      (ess,wss) = unzip msgs1
      rs = [r | Success r<-crs]
      fs = [f | Fail f<-crs]
      msgs = (concat ess++es0,concat wss++ws0)
  in if null fs
     then (msgs,Success rs)
     else (msgs,Fail (vcat $ reverse fs))

checkMap :: (Ord a) => (a -> b -> Check b) -> Map.Map a b -> Check (Map.Map a b)
checkMap f map = do xs <- mapM (\(k,v) -> do v <- f k v
                                             return (k,v)) (Map.toList map)
                    return (Map.fromAscList xs)

checkMapRecover :: (Ord a) => (a -> b -> Check b) -> Map.Map a b -> Check (Map.Map a b)
checkMapRecover f = fmap Map.fromList . parallelCheck . map f' . Map.toList
  where f' (k,v) = fmap ((,)k) (f k v)

{-
checkMapRecover f mp = do 
  let xs = map (\ (k,v) -> (k,runCheck (f k v))) (Map.toList mp)
  case [s | (_,Bad s) <- xs] of
    ss@(_:_) -> checkError (text (unlines ss)) 
    _   -> do
      let (kx,ss) = unzip [((k,x),s) | (k, Ok (x,s)) <- xs]
      if not (all null ss) then checkWarn (text (unlines ss)) else return ()
      return (Map.fromAscList kx)
-}

checkErr :: Err a -> Check a
checkErr (Ok x)    = return x
checkErr (Bad err) = checkError (text err)

checkIn :: Doc -> Check a -> Check a
checkIn msg c = Check $ \{-ctxt-} msgs0 ->
    case unCheck c {-ctxt-} ([],[]) of
      (msgs,Fail msg)  -> (augment msgs0 msgs,Fail (augment1 msg))
      (msgs,Success v) -> (augment msgs0 msgs,Success v)
  where
    augment (es0,ws0) (es,ws) = (augment' es0 es,augment' ws0 ws)
    augment' msgs0 []    = msgs0
    augment' msgs0 msgs' = (msg $$ nest 3 (vcat (reverse msgs'))):msgs0

    augment1 msg' = msg $$ nest 3 msg'
