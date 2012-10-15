src = "Eng"
langs = [
  "Afr","Bul","Cat","Chi","Dan","Dut",
  "Fin","Fre","Ger","Hin","Ita",
  "Jpn","Lav","Nep","Nor","Pes",
  "Pol","Pnb","Ron","Rus","Snd",
  "Spa","Swe","Tha","Urd"
  ]

file lng = "ResourceDemo" ++ lng ++ ".gf"

main = do
  s <- readFile (file src)
  mapM_ (mkMiniFile s) langs

mkMiniFile s lng =
  writeFile (file lng) (mkMini lng s)

mkMini lng s = case s of
  'E':'n':'g':cs -> lng ++ mkMini lng cs
  c:cs -> c : mkMini lng cs
  _ -> s

