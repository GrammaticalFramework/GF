module MkLexicon where

import Char
import qualified Data.Set as S

-- apply function o to each line in file f

allLines o f = do
  s <- readFile f
  mapM_ (putStrLn . o) (filter noComm (lines s))


-- take each line in file k as a key, and choose those lines in file f
-- that match any of the keys (i.e. whose first word matches it)
chooseKeys k f = do
  keys <- readFile k >>= return . (S.fromList . lines)
  let choose line = case words line of
        w:_ -> S.member w keys
        _ -> False
  old  <- readFile f >>= return . lines
  mapM_ (putStrLn . drop 2) $ filter choose old -- to remove extra indent


-- discard comments and empty lines

noComm s = case s of
  '-':'-':_ -> False
  "" -> False
  _ -> True

-- remove tailing comments

remTail s = case s of
  '-':'-':_ -> []
  c:cs -> c : remTail cs
  _ -> s

-- postfix with category

postfix p s = takeWhile (not . isSpace) s ++ "_" ++ p

-- make fun rule

mkFun s = 
  let (w,p) = span (/='_') s in 
  "  " ++ s ++ " : " ++ tail p ++ " ;"

-- make reused lin rule

mkRLin s = 
  let w = head (words s) in 
  "  " ++ w ++ " = " ++ w ++ " ;"

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

-- massage French verbs 9/2/2005

freVerb s = case words s of
  v:_ -> "  " ++ v ++ " : " ++ cat v ++ " ;"
  _ -> []
 where
   cat v = dropWhile (not . isUpper) v

-- Swedish verbs 17/2

sweVerb s = case words s of
  ('v':a:u:[]):verb:_ -> "fun " ++ verb ++ " : V ;\n" ++ 
                         "lin " ++ verb ++ " = " ++ infl a u verb ++ " ;"
  _ -> []
 where
   infl a u verb = 
     let
       (dne,geb) = span isConsonant $ tail $ reverse verb 
       (beg,voc,end) = (reverse (tail geb), head geb, reverse dne)
       (pret,sup) = (beg++ [toLower a] ++end, beg++ [toLower u] ++ end ++"it")
     in
     unwords ["irregV", prQuot verb, prQuot pret, prQuot sup] 

prQuot s = "\"" ++ s ++ "\""

isConsonant = not . isVowel

isVowel = flip elem "aeiouyäöå"

-- Norwegian 13/3

groupLines :: [String] -> [String]
groupLines ss = [unwords [a, b, c] | [a,_,b,c,_] <- grps ss] where
  grps ls = let (g,rest) = splitAt 5 ls in g:grps rest

lin2fun s = case words s of
  _:fun:_:_ -> "  fun " ++ fun ++ " : " ++ cat fun ++ " ;"
  _ -> s 
 where
   cat fun = reverse (takeWhile (/='_') (reverse fun))

-- filter from a given file those lines whose first word is in a sought-set

allThose :: [String] -> [String] -> [String]
allThose soughts givens = concatMap seek soughts where
  seek w = let s = [line | line <- givens, w':_ <- [words line], w == w']
           in if null s then ["-- " ++ w] else s

-- do this with files
-- example: getAllThose "abstract/Mtmp" "english/BasicEng.gf"

getAllThose :: FilePath -> FilePath -> IO ()
getAllThose sought given = do
  s  <- readFile sought
  gi <- readFile given
  let so = [w | l <- lines s, w:_ <- [words l]] 
  mapM_ putStrLn $ allThose so $ lines gi


-- Swadesh 7/3/2006: replace string defs with f = f ;

reuseLex line = case words line of
  w : "=" : _ | elem '"' line -> "   " ++ w ++ " = " ++ w ++ " ;"
  _ -> line
