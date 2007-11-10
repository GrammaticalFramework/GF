module GF.Devel.PrintGFCC where

import GF.GFCC.DataGFCC (GFCC,printGFCC)
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
