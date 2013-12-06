module Parser where

import Data.Char
import Control.Monad

import PGF(PGF,Morpho,lookupMorpho,functionType,unType)
import SusanneFormat

newtype P a = P {runP :: PGF -> Morpho -> [ParseTree] -> Maybe ([ParseTree], a)}

instance Monad P where
  return x = P (\pgf morpho ts -> Just (ts, x))
  f >>= g  = P (\pgf morpho ts -> case runP f pgf morpho ts of
                                    Nothing     -> Nothing
                                    Just (ts,x) -> runP (g x) pgf morpho ts)

instance MonadPlus P where
  mzero = P (\pgf morpho ts -> Nothing)
  mplus f g = P (\pgf morpho ts -> mplus (runP f pgf morpho ts) (runP g pgf morpho ts))

match tag_spec = P (\pgf morpho ts ->
  case ts of
    (t@(Phrase tag1 mods1 fn1 _ _):ts)
      | tag == tag1 &&
        all (flip elem mods1) mods &&
        (null fn || fn == fn1)  -> Just (ts,t)
    (t@(Word _ tag1 _ _):ts)
      | tag == tag1             -> Just (ts,t)
    _                           -> Nothing)
  where
    (f,_) = readTag (Word "<match>" undefined undefined undefined) tag_spec
    Phrase tag mods fn _ _ = f []

many1 f = do
  x  <- f
  xs <- many f
  return (x:xs)

many f = 
  do x  <- f
     xs <- many f
     return (x:xs)
  `mplus`
  do return []

inside tag_spec p = P (\pgf morpho ts ->
  case ts of
    (t@(Phrase tag1 mods1 fn1 _ ts'):ts)
      | tag == tag1 &&
        all (flip elem mods1) mods &&
        (null fn || fn == fn1)  -> case runP p pgf morpho ts' of
                                     Just ([],x) -> Just (ts,x)
                                     _           -> Nothing
    _                           -> Nothing)
  where
    (f,_) = readTag (Word "<match>" undefined undefined undefined) tag_spec
    Phrase tag mods fn _ _ = f []

insideOpt tag_spec p = P (\pgf morpho ts ->
  case ts of
    (t@(Phrase tag1 mods1 fn1 _ ts'):ts)
      | tag == tag1 &&
        all (flip elem mods1) mods &&
        (null fn || fn == fn1)  -> case runP p pgf morpho ts' of
                                     Just ([],x) -> Just (ts,x)
                                     _           -> Just (ts,t)
    _                           -> Nothing)
  where
    (f,_) = readTag (Word "<match>" undefined undefined undefined) tag_spec
    Phrase tag mods fn _ _ = f []

lemma tag cat an0 = P (\pgf morpho ts ->
  case ts of
    (t@(Word _ tag1 form _):ts) | tag == tag1 ->
       case [f | (f,an) <- lookupMorpho morpho (map toLower form), hasCat pgf f cat, an == an0] of
         [f] -> Just (ts,App f [])
         _   -> Just (ts,t)
    _        -> Nothing)
  where
    hasCat pgf f cat =
      case functionType pgf f of
        Just ty -> case unType ty of
                     (_,cat1,_) -> cat1 == cat
        Nothing -> False

opt f =
  do x <- f
     return (Just x)
  `mplus`
  do return Nothing
