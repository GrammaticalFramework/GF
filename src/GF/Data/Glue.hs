module Glue where

import Trie
import Operations
import List

-------- AR 8/11/2003, using Markus Forsberg's implementation of Huet's unglue

tcompileSimple :: [String] -> Trie
tcompileSimple ss = tcompile [(s,[(atWP,s)]) | s <- ss]

decomposeSimple :: Trie -> String -> Err [String]
decomposeSimple t s = do
  let ss = map (decompose t) $ words s
  if any null ss
    then Bad "unknown word in input"
    else return $ concat [intersperse "&+" ws | ws <- ss]

exTrie = tcompileSimple $ words "ett två tre tjugo trettio hundra tusen"
