module GF.Devel.PrintGFCC where

import GF.GFCC.DataGFCC (GFCC)
import GF.GFCC.Raw.ConvertGFCC (fromGFCC)
import GF.GFCC.Raw.PrintGFCCRaw (printTree)
import GF.Devel.GFCCtoHaskell
import GF.Devel.GFCCtoJS

-- top-level access to code generation

prGFCC :: String -> GFCC -> String
prGFCC printer gr = case printer of
  "haskell" -> grammar2haskell gr
  "haskell_gadt" -> grammar2haskellGADT gr
  "js" -> gfcc2js gr
  "jsref" -> gfcc2grammarRef gr
  _ -> printGFCC gr

printGFCC :: GFCC -> String
printGFCC = printTree . fromGFCC

