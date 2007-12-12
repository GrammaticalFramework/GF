import List

main = do
  s <- readFile "constrs"
  mapM_ (putStrLn . mkOne) $ lines s

mkOne [] = []  
mkOne s = 
  "      mk" ++ cons ++ " " ++ rest ++ 
  "\n                                         =" ++ fun ++ " ;"
 where
   (fun,rest) = span (/=':') s
   cons = last $ takeWhile (/="--") $ words rest

