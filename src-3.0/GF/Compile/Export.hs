module GF.Compile.Export where

import PGF.Data (PGF)
import PGF.Raw.Print (printTree)
import PGF.Raw.Convert (fromPGF)
import GF.Compile.GFCCtoHaskell
import GF.Compile.GFCCtoJS
import GF.Infra.Option
import GF.Text.UTF8

-- top-level access to code generation

prPGF :: OutputFormat 
      -> PGF 
      -> String -- ^ Output name, for example used for generated Haskell
                -- module name.
      -> String
prPGF fmt gr name = case fmt of
  FmtPGF         -> printPGF gr
  FmtJavaScript  -> pgf2js gr
  FmtHaskell     -> grammar2haskell gr name
  FmtHaskellGADT -> grammar2haskellGADT gr name

printPGF :: PGF -> String
printPGF = encodeUTF8 . printTree . fromPGF
