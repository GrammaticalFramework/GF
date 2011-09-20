module GF.Grammar.Analyse (
        stripSourceGrammar
        ) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option ---
import GF.Infra.Modules

import GF.Data.Operations

import qualified Data.Map as Map


stripSourceGrammar :: SourceGrammar -> SourceGrammar
stripSourceGrammar sgr = mGrammar [(i, m{jments = Map.map stripInfo (jments m)}) | (i,m) <- modules sgr]

stripInfo :: Info -> Info
stripInfo i = case i of
  AbsCat _ -> i
  AbsFun mt mi me mb -> AbsFun mt mi Nothing mb
  ResParam mp mt -> ResParam mp Nothing
  ResValue lt -> i ----
  ResOper mt md -> ResOper mt Nothing
  ResOverload is fs -> ResOverload is [(lty, L loc (EInt 0)) | (lty,L loc _) <- fs]
  CncCat mty mte mtf -> CncCat mty Nothing Nothing
  CncFun mict mte mtf -> CncFun mict Nothing Nothing
  AnyInd b f -> i

