module GF.Compile.Export where

import PGF.Data (GFCC)
import PGF.Raw.Print (printTree)
import PGF.Raw.Convert (fromGFCC)
import GF.Compile.GFCCtoHaskell
import GF.Compile.GFCCtoJS
import GF.Infra.Option
import GF.Text.UTF8

-- top-level access to code generation

prGFCC :: OutputFormat -> GFCC -> String
prGFCC fmt gr = case fmt of
  FmtGFCC        -> printGFCC gr
  FmtJavaScript  -> gfcc2js gr
  FmtHaskell     -> grammar2haskell gr
  FmtHaskellGADT -> grammar2haskellGADT gr

printGFCC :: GFCC -> String
printGFCC = encodeUTF8 . printTree . fromGFCC

