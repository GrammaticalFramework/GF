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

