module MkUnion (makeUnion) where

import Grammar
import Ident
import Modules
import Macros
import PrGrammar

import Operations

import Monad

-- building union of modules
-- AR 21/8/2002 -- 22/6/2003 for GF with modules

makeUnion :: SourceGrammar -> Ident -> ModuleType Ident -> [(Ident,[Ident])] ->
             Err SourceModule
makeUnion gr m ty imps = do
  Bad "Sorry: unions not yet implemented"
