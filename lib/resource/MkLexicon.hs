module MkLexicon where

import Char

allLines o f = do
  s <- readFile f
  mapM_ (putStrLn . o) (filter noComm (lines s))


-- discard comments and empty lines

noComm s = case s of
  '-':'-':_ -> False
  "" -> False
  _ -> True

-- postfix with category

postfix p s = takeWhile (not . isSpace) s ++ "_" ++ p

-- make fun rule

mkFun s = 
  let (w,p) = span (/='_') s in 
  "  " ++ s ++ " : " ++ tail p ++ " ;"

-- make regular lin rule

mkLin s = 
  let (w,p) = span (/='_') s in 
  "  " ++ s ++ " = " ++ lin (tail p) w ++ " ;"
 where
  lin cat w = case cat of
    "V2"  -> "dirV2 (regV" ++ " \"" ++ w ++ "\")" 
    'V':_ -> "mk" ++ cat ++ " (regV" ++ " \"" ++ w ++ "\")" 
    _     -> "reg" ++ cat ++ " \"" ++ w ++ "\"" 

-- normalize identifiers in Structural

mkIdent s = case words s of
  w:ws -> if obsolete w then "" 
          else "  " ++ (unwords $ mkId (update w) : ws) 
  _ -> s
 where
   mkId name@(c:cs) = 
     let 
       (x,y) = span isCat cs 
     in 
     toLower c : clean x ++ "_" ++ new y
   isCat = flip notElem "PDNVCAIS"
   clean x = case span isLower x of
     (_,[]) -> x
     (u,v)  -> u ++ "8" ++ map toLower v
   new y = case y of
     "NumDet" -> "NDet"
     _ -> y
   obsolete w = elem w $ words "TheseNumNP ThoseNumNP NobodyNP NeitherNor NoDet AnyDet"
   update w = case w of
     "EitherOr" -> "EitherOrConjD"
     "BothAnd"  -> "BothAndConjD"
     "PhrYes"   -> "YesPhr"
     "PhrNo"    -> "NoPhr"
     "WeNumNP"    -> "WeNP"
     "YeNumNP"    -> "YeNP"
     "HowManyDet" -> "HowManyIDet"
     "MostsDet" -> "MostManyDet"
     "WhichDet" -> "WhichOneIDet"
     "WhichNDet" -> "WhichManyIDet"
     "EverywhereNP" -> "EverywhereAdv"
     "SomewhereNP" -> "SomewhereAdv"
     "AgentPrep" -> "By8agentPrep"
     _ -> w
