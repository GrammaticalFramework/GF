module Parser where

import Control.Monad

import SusanneFormat

newtype P a = P {runP :: [ParseTree] -> Maybe ([ParseTree], a)}

instance Monad P where
  return x = P (\ts -> Just (ts, x))
  f >>= g  = P (\ts -> case runP f ts of
                         Nothing     -> Nothing
                         Just (ts,x) -> runP (g x) ts)

instance MonadPlus P where
  mzero = P (\ts -> Nothing)
  mplus f g = P (\ts -> mplus (runP f ts) (runP g ts))

match tag_spec = P (\ts ->
  case ts of
    (Phrase tag1 mods1 fn1 _ _:ts)
      | tag == tag1 &&
        all (flip elem mods1) mods &&
        (null fn || fn == fn1)  -> Just (ts,())
    (Word _ tag1 _ _:ts)
      | tag == tag1             -> Just (ts,())
    _                           -> Nothing)
  where
    (f,_) = readTag (Word "<match>" undefined undefined undefined) tag_spec
    Phrase tag mods fn _ _ = f []

many f = 
  do x  <- f
     xs <- many f
     return (x:xs)
  `mplus`
  do return []
