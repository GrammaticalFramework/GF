main = interact (unlines . map (mkTerm . words) . lines)

mkTerm ws = case ws of
  "==":cat:"-":expl -> unlines [
    mkFun "Cat" cat, 
    mkLin "Cat" "mkN" cat (unwords (takeWhile (/= "==") expl))
   ]

mkFun pref s = unwords ["fun", pref ++ s, ":", pref, ";"]
---mkLin pref p s e = unwords ["lin", pref ++ s, "=", p, quoted e, ";"]
mkLin pref p s e = unwords ["lin", pref ++ s, "=", quoted s, ";"]

quoted s = "\"" ++ s ++ "\""
