import PGF
import Data.Maybe

main = do
  ls <- fmap (filterExprs . lines) $ readFile "log4.txt"
  let (c,m1,m2) = foldl counts (0,0,0) (map (\l -> fromMaybe (error l) (readExpr (f l))) ls)
  print (length ls)
  print ((c / (c+m1+m2))*100)
  print (((c+m2) / (c+m1+m2))*100)
  meta_dist [length [l | l <- ls, length [c | c <- l, c == '?'] == n] | n <- [0..27]]
  meta_dist [length [l | l <- ls, length [x | x <- (zip l (tail l)), x == ('(','?')] == n] | n <- [0..27]]
  cs <- fmap (map (length . words) . lines) $ readFile "wsj.eng"
  print (average [fromIntegral c / fromIntegral (max n 1) | (c,l) <- zip cs ls, let n = length [c | c <- l, c == '?']])
  print (average [fromIntegral c / fromIntegral (max n 1) | (c,l) <- zip cs ls, let n = length [x | x <- (zip l (tail l)), x == ('(','?')]])

average xs = sum xs / fromIntegral (length xs)

filterExprs []          = []
filterExprs (l:ls)
  | null l              = filterExprs ls
  | elem (head l) "+#*" = drop 2 l : filterExprs ls
  | otherwise           = filterExprs ls

f []       = []
f ('[':cs) = let (xs,']':ys) = break (==']') cs
             in f ('?' : ys)
f ('?':cs) = 'Q' : f cs
f (c:cs)   = c   : f cs

counts (c,m1,m2) e = c `seq` m1 `seq` m2 `seq`
  case unApp e of
    Just (f,es) | f == mkCId "Q" -> if null es
                                      then foldl counts (c,m1,m2+1) es
                                      else foldl counts (c,m1+1,m2) es
                | otherwise      -> foldl counts (c+1,m1,m2) es
    Nothing   -> case unStr e of
                   Just _        -> (c+1,m1,m2)
                   Nothing       -> error ("counts ("++show e++")")

meta_dist cs = do
  print cs
  let cnt = fromIntegral (sum cs)
      avg = fromIntegral (sum [n*c | (n,c) <- zip [0..] cs]) / cnt
      dev = sqrt (sum [((fromIntegral n-avg) ^ 2)*fromIntegral c | (n,c) <- zip [0..] cs] / cnt)
  print (avg,dev)
