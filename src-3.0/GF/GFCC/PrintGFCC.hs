module GF.GFCC.PrintGFCC where

import GF.GFCC.DataGFCC (GFCC)
import GF.GFCC.Raw.ConvertGFCC (fromGFCC)
import GF.GFCC.Raw.PrintGFCCRaw (printTree)
import GF.GFCC.GFCCtoHaskell
import GF.GFCC.GFCCtoJS
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

