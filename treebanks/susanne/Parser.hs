module Parser where

import Data.Char
import Control.Monad

import PGF2
import SusanneFormat
import Debug.Trace

newtype P a = P {runP :: PGF -> Concr -> [ParseTree] -> Maybe ([ParseTree], a)}

instance Monad P where
  return x = P (\pgf cnc ts -> Just (ts, x))
  f >>= g  = P (\pgf cnc ts -> case runP f pgf cnc ts of
                                    Nothing     -> Nothing
                                    Just (ts,x) -> runP (g x) pgf cnc ts)

instance MonadPlus P where
  mzero = P (\pgf cnc ts -> Nothing)
  mplus f g = P (\pgf cnc ts -> mplus (runP f pgf cnc ts) (runP g pgf cnc ts))

getConcr = P (\pgf cnc ts -> Just (ts,cnc))

match convert tag_spec = P (\pgf cnc ts ->
  case ts of
    (t@(Phrase tag1 mods1 fn1 _ _):ts)
      | tag == tag1 &&
        all (flip elem mods1) mods &&
        (null fn || fn == fn1)  -> Just (ts,convert pgf cnc t)
    (t@(Word _ tag1 _ _):ts)
      | tag == tag1 && null mods-> Just (ts,convert pgf cnc t)
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

inside tag_spec p = P (\pgf cnc ts ->
  case ts of
    (t@(Phrase tag1 mods1 fn1 _ ts'):ts)
      | tag == tag1 &&
        all (flip elem mods1) mods &&
        (null fn || fn == fn1)  -> case runP p pgf cnc ts' of
                                     Just ([],x) -> Just (ts,x)
                                     _           -> Nothing
    _                           -> Nothing)
  where
    (f,_) = readTag (Word "<match>" undefined undefined undefined) tag_spec
    Phrase tag mods fn _ _ = f []

insideOpt convert tag_spec p = P (\pgf cnc ts ->
  case ts of
    (t@(Phrase tag1 mods1 fn1 _ ts'):ts)
      | tag == tag1 &&
        all (flip elem mods1) mods &&
        (null fn || fn == fn1)  -> case runP p pgf cnc ts' of
                                     Just ([],x) -> Just (ts,x)
                                     _           -> Just (ts,convert pgf cnc t)
    _                           -> Nothing)
  where
    (f,_) = readTag (Word "<match>" undefined undefined undefined) tag_spec
    Phrase tag mods fn _ _ = f []

lemma tag cat an0 = P (\pgf cnc ts ->
  case ts of
    (t@(Word _ tag1 form _):ts) | tag == tag1 -> case runP (lookupForm cat an0 form) pgf cnc ts of
                                                   Nothing -> Just (ts,t)
                                                   x       -> x
    _                                         -> Nothing)

lookupForm cat an0 form = P (\pgf cnc ts ->
  case [f | (f,an,_) <- lookupMorpho cnc form, hasCat pgf f cat, an == an0] of
    []  -> case [f | (f,an,_) <- lookupMorpho cnc (map toLower form), hasCat pgf f cat, an == an0] of
             [f] -> Just (ts,App f [])
             _   -> Nothing
    [f] -> Just (ts,App f [])
    _   -> Nothing)
  where
    hasCat pgf f cat =
      case functionType pgf f of
        (DTyp _ cat1 _) -> cat1 == cat

opt f =
  do x <- f
     return (Just x)
  `mplus`
  do return Nothing

word tag = P (\pgf cnc ts ->
  case ts of
    ((Word _ tag1 form _):ts) | tag == tag1 -> Just (ts,form)
    _                                       -> Nothing)
