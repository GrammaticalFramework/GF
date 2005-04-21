----------------------------------------------------------------------
-- |
-- Module      : Glue
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:02 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- AR 8-11-2003, using Markus Forsberg's implementation of Huet's @unglue@
-----------------------------------------------------------------------------

module GF.Data.Glue (decomposeSimple) where

import GF.Data.Trie2
import GF.Data.Operations
import Data.List

decomposeSimple :: Trie Char a -> [Char] -> Err [[Char]]
decomposeSimple t s = do
  let ss = map (decompose t) $ words s
  if any null ss
    then Bad "unknown word in input"
    else return $ concat [intersperse "&+" ws | ws <- ss]

exTrie = tcompile (zip ws ws) where 
  ws = words "ett två tre tjugo trettio hundra tusen"

