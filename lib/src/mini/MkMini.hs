src = "Eng"
langs = [
  "Afr", "Bul", "Cat","Dan","Dut",
  "Fin","Fre","Ger","Ita", -- "Lav",
  "Nep","Nor","Pes","Pol","Pnb",
  "Ron",
  "Rus","Spa","Swe","Tha",
  "Urd"
  ]

file lng = "MiniGrammar" ++ lng ++ ".gf"

main = do
  s <- readFile (file src)
  mapM_ (mkMiniFile s) langs

mkMiniFile s lng =
  writeFile (file lng) (mkMini lng s)

mkMini lng s = case s of
  'E':'n':'g':cs -> lng ++ mkMini lng cs
  c:cs -> c : mkMini lng cs
  _ -> s

