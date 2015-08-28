module GF.Text.Clitics (getClitics,getCliticsText) where

import Data.List

-- AR 6/2/2011
-- Analyse word as stem+clitic whenever 
--   (1) clitic is in clitic list
--   (2) either 
--      (a) stem is in Lexicon
--      (b) stem can be analysed as stem0+clitic0
-- 
-- Examples: 
--   Italian amarmi = amar+mi
--   Finnish autossanikohan = autossa+ni+kohan
--
-- The analysis gives all results, including the case where the whole word is in Lexicon.
-- 
-- The clitics in the list are expected to be reversed.

getClitics :: (String -> Bool) -> [String] -> String -> [[String]]
getClitics isLex rclitics = map (reverse . map reverse) . clits . reverse where
  clits rword = ifLex rword [rclit:more | 
                  rclit <- rclitics, stem <- splits rclit rword, more <- clits stem]
  splits c = maybe [] return . stripPrefix c

  ifLex w ws = if isLex (reverse w) then [w] : ws else ws


getCliticsText :: (String -> Bool) -> [String] -> [String] -> [String]
getCliticsText isLex rclitics = 
  map unwords . sequence . map (map render . getClitics isLex rclitics) 
 where
  render = unwords . intersperse "&+"


-- example

--getClitics1 = getClitics exlex1 exclits1
--exlex1   = flip elem ["auto", "naise", "rahan","maa","maahan","maahankaan"]
--exclits1 = map reverse ["ni","ko","han","pas","nsa","kin","kaan"]
