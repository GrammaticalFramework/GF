module GF.Compile.Export where

import PGF.Data (PGF)
import PGF.Raw.Print (printTree)
import PGF.Raw.Convert (fromPGF)
import GF.Compile.GFCCtoHaskell
import GF.Compile.GFCCtoJS
import GF.Infra.Option
import GF.Text.UTF8

-- top-level access to code generation

prPGF :: OutputFormat -> PGF -> String
prPGF fmt gr = case fmt of
  FmtPGF         -> printPGF gr
  FmtJavaScript  -> pgf2js gr
  FmtHaskell     -> grammar2haskell gr
  FmtHaskellGADT -> grammar2haskellGADT gr

printPGF :: PGF -> String
printPGF = encodeUTF8 . printTree . fromPGF

