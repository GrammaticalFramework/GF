{-# OPTIONS_GHC -fglasgow-exts #-}
module Main where

import PGF
import Foods

-- example of using GADT: turn every occurrence of "boring" to "very boring"

main = do
  pgf <- readPGF "Foods.pgf"
  interact (doVery pgf)

doVery pgf s = case parseAllLang pgf (startCat pgf) s of 
  (l,t:_):_ -> unlines $ return $ linearize pgf l $ gf $ veryC $ fg t

veryC :: GComment -> GComment
veryC = very

very :: forall a. Foods.Tree a -> Foods.Tree a
very t = case t of
  GBoring -> GVery GBoring
  _ -> composOp very t

