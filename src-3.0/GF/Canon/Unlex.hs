----------------------------------------------------------------------
-- |
-- Module      : Unlex
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:32 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- elementary text postprocessing. AR 21/11/2001
-----------------------------------------------------------------------------

module GF.Canon.Unlex (formatAsText, unlex, performBinds) where

import GF.Data.Operations
import GF.Data.Str

import Data.Char
import Data.List (isPrefixOf)

formatAsText :: String -> String
formatAsText = unwords . format . cap . words where
  format ws = case ws of
    w : c : ww | major c -> (w ++ c)      : format (cap ww)
    w : c : ww | minor c -> (w ++ c)      : format ww
    c     : ww | para  c -> "\n\n"        : format ww
    w     : ww           -> w             : format ww
    [] -> []
  cap (p:(c:cs):ww) | para p = p : (toUpper c : cs) : ww
  cap ((c:cs):ww) = (toUpper c : cs) : ww
  cap [] = []
  major = flip elem (map (:[]) ".!?") 
  minor = flip elem (map (:[]) ",:;")
  para  = (=="&-") 

unlex :: [Str] -> String
unlex = formatAsText . performBinds . concat . map sstr . take 1 ----

-- | modified from GF/src/Text by adding hyphen
performBinds :: String -> String
performBinds = unwords . format . words where
  format ws = case ws of
    w : "-"  : u : ws -> format ((w ++ "-" ++ u) : ws)
    w : "&+" : u : ws -> format ((w ++ u) : ws)
    w : ws            -> w : format ws
    []                -> []

