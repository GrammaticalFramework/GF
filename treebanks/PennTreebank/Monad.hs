module Monad ( Rule(..), Grammar, grammar
             , P, parse
             , cat, word, lemma, inside, transform
             , many, many1, opt
             ) where

import Data.Tree
import Data.Char
import qualified Data.Map as Map
import Control.Monad
import PGF hiding (Tree,parse)

infix 1 :->


data Rule    t e = t :-> P t e e
type Grammar t e = t -> PGF -> Morpho -> [Tree t] -> e

grammar :: (Ord t,Show t) => ([e] -> e) -> [Rule t e] -> Grammar t e
grammar def rules = gr
  where
    gr = \tag ->
      case Map.lookup tag pmap of
        Just f  -> \pgf m ts -> case unP f gr pgf m ts of
                                  Just (e,[]) -> e
                                  _           -> case ts of
                                                   [Node w []] -> def []
                                                   ts          -> def [gr tag pgf m ts | Node tag ts <- ts]
        Nothing -> \pgf m ts -> case ts of
                                  [Node w []] -> def []
                                  ts          -> def [gr tag pgf m ts | Node tag ts <- ts]

    pmap = Map.fromListWith mplus (map (\(t :-> r) -> (t,r)) rules)


newtype P t e a = P {unP :: Grammar t e -> PGF -> Morpho -> [Tree t] -> Maybe (a,[Tree t])}

instance Monad (P t e) where
  return x = P (\gr pgf m ts -> Just (x,ts))
  f >>= g  = P (\gr pgf m ts -> case unP f gr pgf m ts of
                                  Just (x,ts) -> unP (g x) gr pgf m ts
                                  Nothing     -> Nothing)

instance MonadPlus (P t e) where
  mzero     = P (\gr pgf m ts -> Nothing)
  mplus f g = P (\gr pgf m ts -> unP f gr pgf m ts `mplus` unP g gr pgf m ts)


parse :: Grammar t e -> PGF -> Morpho -> Tree t -> e
parse gr pgf morpho (Node tag ts) = gr tag pgf morpho ts

cat :: Eq t => t -> P t e e
cat tag = P (\gr pgf morpho ts -> 
  case ts of
    (Node tag1 ts1 : ts) | tag == tag1 -> Just (gr tag1 pgf morpho ts1,ts)
    _                                  -> Nothing)

word :: P t e t
word = P (\gr pgf morpho ts -> 
  case ts of
    (Node w [] : ts) -> Just (w,ts)
    _                -> Nothing)

inside :: Eq t => t -> P t e a -> P t e a
inside tag f = P (\gr pgf morpho ts ->
  case ts of
    (Node tag1 ts1 : ts) | tag == tag1 -> case unP f gr pgf morpho ts1 of
                                            Just (x,[]) -> Just (x,ts)
                                            _           -> Nothing
    _                                  -> Nothing)

lemma :: String -> String -> P String e CId
lemma cat0 an0 = P (\gr pgf morpho ts -> 
  case ts of
    (Node w [] : ts) -> case [lemma | (lemma, an1) <- lookupMorpho morpho (map toLower w)
                                    , let cat1 = maybe "" (showType []) (functionType pgf lemma)
                                    , cat0 == cat1 && an0 == an1] of
                          (id:_) -> Just (id,ts)
                          _      -> Nothing
    _                -> Nothing)

transform :: ([Tree t] -> [Tree t]) -> P t e ()
transform f = P (\gr pgf morpho ts -> Just ((),f ts))

many :: P t e a -> P t e [a]
many f = do x  <- f
            xs <- many f
            return (x:xs)
         `mplus`
         do return []

many1 :: P t e a -> P t e [a]
many1 f = do x  <- f
             xs <- many f
             return (x:xs)

opt :: P t e a -> a -> P t e a
opt f x = mplus f (return x)
