module STM where

import Control.Monad

-- state monad 


-- the Error monad

-- | like @Maybe@ type with error msgs
data Err a = Ok a | Bad String
  deriving (Read, Show, Eq)

instance Monad Err where
  return      = Ok
  fail        = Bad
  Ok a  >>= f = f a
  Bad s >>= f = Bad s

-- | analogue of @maybe@
err :: (String -> b) -> (a -> b) -> Err a -> b 
err d f e = case e of
  Ok a -> f a
  Bad s -> d s

-- state monad with error; from Agda 6/11/2001

newtype STM s a = STM (s -> Err (a,s)) 

appSTM :: STM s a -> s -> Err (a,s)
appSTM (STM f) s = f s

stm :: (s -> Err (a,s)) -> STM s a
stm = STM

stmr :: (s -> (a,s)) -> STM s a
stmr f = stm (\s -> return (f s))

instance  Monad (STM s) where
  return a    = STM (\s -> return (a,s))
  STM c >>= f = STM (\s -> do 
                        (x,s') <- c s
                        let STM f' = f x
                        f' s')

readSTM :: STM s s
readSTM = stmr (\s -> (s,s))

updateSTM :: (s -> s) -> STM s () 
updateSTM f = stmr (\s -> ((),f s))

writeSTM :: s -> STM s ()
writeSTM s = stmr (const ((),s))

done :: Monad m => m ()
done = return ()

class Monad m => ErrorMonad m where
  raise   :: String -> m a
  handle  :: m a -> (String -> m a) -> m a
  handle_ :: m a -> m a -> m a
  handle_ a b =  a `handle` (\_ -> b)

instance ErrorMonad Err where
  raise  = Bad
  handle a@(Ok _) _ = a
  handle (Bad i) f  = f i

instance ErrorMonad (STM s) where
  raise msg = STM (\s -> raise msg)
  handle (STM f) g = STM (\s -> (f s) 
                                `handle` (\e -> let STM g' = (g e) in
                                                    g' s))

-- | if the first check fails try another one
checkAgain :: ErrorMonad m => m a -> m a -> m a
checkAgain c1 c2 = handle_ c1 c2

checks :: ErrorMonad m => [m a] -> m a
checks [] = raise "no chance to pass"
checks cs = foldr1 checkAgain cs

allChecks :: ErrorMonad m => [m a] -> m [a]
allChecks ms = case ms of
  (m: ms) -> let rs = allChecks ms in handle_ (liftM2 (:) m rs) rs
  _ -> return []

doUntil :: ErrorMonad m => (a -> Bool) -> [m a] -> m a
doUntil cond ms = case ms of
  a:as -> do
    v <- a
    if cond v then return v else doUntil cond as
  _ -> raise "no result"

