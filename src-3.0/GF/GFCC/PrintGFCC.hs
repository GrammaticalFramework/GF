module GF.GFCC.PrintGFCC where

import GF.GFCC.DataGFCC (GFCC)
import GF.GFCC.Raw.ConvertGFCC (fromGFCC)
import GF.GFCC.Raw.PrintGFCCRaw (printTree)
import GF.GFCC.GFCCtoHaskell
import GF.GFCC.GFCCtoJS
import GF.Text.UTF8

-- top-level access to code generation

prGFCC :: String -> GFCC -> String
prGFCC printer gr = case printer of
  "haskell" -> grammar2haskell gr
  "haskell_gadt" -> grammar2haskellGADT gr
  "js" -> gfcc2js gr
  _ -> printGFCC gr

printGFCC :: GFCC -> String
printGFCC = encodeUTF8 . printTree . fromGFCC

