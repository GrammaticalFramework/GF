lang1 = "Eng"
lang2 = "Chi"

-- to write a comparison for two languages

main = do
  ss1 <- readFile (exx lang1) >>= return . lines
  ss2 <- readFile (exx lang2) >>= return . lines
  mkExx (ss1, ss2)

exx lang = "api-examples-" ++ lang ++ ".txt"

mkExx sss = case sss of
  (s1:ss1,s2:ss2) | isMsg s1 -> mkExx (ss1,s2:ss2)
  (s1:ss1,s2:ss2) | isMsg s2 -> mkExx (s1:ss1,ss2)
  (s1:ss1,s2:ss2) | s1 /= s2 -> 
     putStrLn (drops s1) >> putStrLn (drops s2) >> putStrLn [] >> mkExx (ss1,ss2) -- show strings
  (s1:ss1,s2:ss2) | s1 == s2 && not (isJunk s1) -> 
     putStrLn (drops s1) >> mkExx (ss1,ss2) -- show the term
  (s1:ss1,s2:ss2) | s1 == s2 -> mkExx (ss1,ss2)
  _ -> return ()

isMsg s = case s of
  '>':_ -> False
  _ -> True

drops = drop 4

isJunk s = any (flip elem s) "*-"



