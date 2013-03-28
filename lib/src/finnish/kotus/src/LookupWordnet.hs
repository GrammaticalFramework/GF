-- looking up a word from Princeton dict/index files

-- e.g. look for senses of DictEngAbs:
--  runghc LookupWordnet.hs <~/GF/lib/src/dictEngFuns.txt

import Data.List
import Data.Char
import qualified Data.Map as M

main = do
  indw <- readFile "index.word"
  let poss  = buildPoss (lines indw)
  mapM_ print $ take 20 $ drop 1000 $ M.toList poss
  inds <- readFile "index.sense"
  let index = buildIndex poss (lines inds)
  mapM_ print $ take 20 $ drop 1000 $ M.toList index

-- interactive search of synsets for words, sorted by category and descending frequency
---  interact (unlines . map (look index) . lines)
-- example:
-- tailor
-- n%1%10689564 v%2%00301662 v%2%01666327 v%2%01666717

--  look up the most frequent senses of a GF abstract syntax with entries like
--  zoomorphism_N : N ;
  interact (unlines . map (lookGF index) . lines)


type Index = M.Map String [String] -- word form to synset id's

look :: Index -> String -> String
look index str = maybe "NOTFOUND" (unwords . nub . sort) $ M.lookup str index

-- index.sense
-- academic%1:18:00:: 09759069 1 2
-- academic%3:01:00:: 02599939 1 18

buildIndex :: Index -> [String] -> Index
buildIndex poss = M.fromListWith (++) . map mkOne where
  mkOne s = case words s of 
    w:i:_ -> let 
               (word,rank) = span (/='%') w 
               c = look poss i
             in (word, [c ++ take 2 rank ++ "%" ++ i])
    _ -> (s,[])


buildPoss :: [String] -> Index
buildPoss = M.fromListWith (++) . concatMap mkOne where
  mkOne s = case words s of 
    w:c:rest -> [(i,[c]) | i <- dropWhile ((<8) . length) rest]
    _ -> []



lookGF :: Index -> String -> String
lookGF index str = case words str of
  fun:_:cat:_ -> fun ++ " " ++ case look index (init (takeWhile (not . isUpper) fun)) of
    is -> case lookup (trunc cat) (map entry (words is)) of
      Just i -> i
      _ -> is ++ ":" ++ trunc cat
  _ -> "-- " ++ str
 where
  trunc cat = case cat of 
    "Adv" ->  "r"
    _ -> map toLower (take 1 cat)  -- "a", "n", "v"
  entry cfi = let c = take 1 cfi in (c, c ++ drop 4 cfi)
    

{-
-- from index.word
-- aboriginal a 3 3 & \ + 3 0 02599509 01037148 00813589

buildIndex :: [String] -> Index
buildIndex = M.fromListWith (++) . map mkOne where
  mkOne s = case words s of 
    w:c:rest -> (w,[ c++i | i <- dropWhile ((<8) . length) rest])
    _ -> (s,[])
-}

