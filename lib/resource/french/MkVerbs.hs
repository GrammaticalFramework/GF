main :: IO ()
main = do
  
  s <- readFile "verbs"
  mapM_ putRule $ combine $ map words $ lines s -- to create fun/lin
--  mapM_ putConjug [1..100] -- to create oper

putRule = appendFile "verbs.gf" . mkRule

mkRule s = case s of
  n:v:cs -> 
    "fun " ++ v ++ cat ++ " : " ++ cat ++ " ;\n" ++ 
    "lin " ++ v ++ cat ++ 
      " = v_nancy" ++ n ++ " \"" ++ v ++ "\"" ++ ext ++ " ;\n"
      where
   (cat,ext) = case cs of
     "I":"T":_  -> ("VN2", " ** {aux = VHabere ; c = Acc}")
     "T":_      -> ("VN2", " ** {aux = VHabere ; c = Acc}")
     "a":au     -> ("VN2", " ** {aux = " ++ aux au ++ " ; c = Dat}")
     "de":au    -> ("VN2", " ** {aux = " ++ aux au ++ " ; c = Gen}")
     au         -> ("VN",  " ** {aux = " ++ aux au ++ "}")
   aux au = case au of
     "etre":_ -> "VEsse"
     _        -> "VHabere"

combine ls = case ls of
  l@(n:v:_:c:_):vs -> 
    let (vv,rest) = span ((==v) . (!!1)) vs in
      ([n,v,c] ++ map (!!3) vs) : combine rest
  _ -> ls
 

---

putConjug = appendFile "nancy_conjugs.gf" . mkConjug

mkConjug :: Integer -> String
mkConjug i = "oper v_nancy" ++ show i ++ 
             " : Str -> V = \\s -> conj v ++ {lock_V = <>} ;\n"
