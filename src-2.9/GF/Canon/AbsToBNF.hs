module GF.Canon.AbsToBNF where

import GF.Grammar.SGrammar
import GF.Data.Operations
import GF.Infra.Option
import GF.Canon.GFC (CanonGrammar)

-- AR 10/5/2007

abstract2bnf :: CanonGrammar -> String
abstract2bnf = sgrammar2bnf . gr2sgr noOptions emptyProbs

sgrammar2bnf :: SGrammar -> String
sgrammar2bnf = unlines . map (prBNFRule . mkBNF) . allRules

prBNFRule :: BNFRule -> String
prBNFRule = id

type BNFRule = String

mkBNF :: SRule -> BNFRule
mkBNF (pfun,(args,cat)) = 
  fun ++ "." +++ gfId cat +++ "::=" +++ rhs +++ ";"
 where
   fun = gfId (snd pfun)
   rhs = case args of
     [] -> prQuotedString (snd pfun)
     _ -> unwords (map gfId args)

-- good for GF
gfId i = i

-- good for BNFC
gfIdd i = case i of
  "Int"    -> "Integer"
  "String" -> i 
  "Float"  -> "Double"
  _   -> "G" ++ i ++ "_"
