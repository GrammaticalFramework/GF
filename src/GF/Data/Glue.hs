----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- AR 8-11-2003, using Markus Forsberg's implementation of Huet's @unglue@
-----------------------------------------------------------------------------

module Glue (decomposeSimple, exTrie) where

import Trie2
import Operations
import List

decomposeSimple :: Trie Char a -> [Char] -> Err [[Char]]
decomposeSimple t s = do
  let ss = map (decompose t) $ words s
  if any null ss
    then Bad "unknown word in input"
    else return $ concat [intersperse "&+" ws | ws <- ss]

exTrie = tcompile (zip ws ws) where 
  ws = words "ett två tre tjugo trettio hundra tusen"

