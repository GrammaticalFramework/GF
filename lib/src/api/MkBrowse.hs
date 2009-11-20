main = interact mkBrowse

mkBrowse = unlines . map mkJment . zip [1..] . jments

jments = chop ';'

mkJment (i,j) = case words j of
  f:":":ws -> toJment f i (break (=="=") ws)
  _ -> []

toJment f0 i (ty,de) = let f = f0 ++ "_" ++ show i in unlines $ map unwords [
  ["fun",f,":",unwords ty,";"],
  ["lin",f,"=",unwords de,";"]
  ]

chop c s = case break (==c) s of
  (j,_:cs) -> j : chop c cs
  (j,_) -> [j]


uncomm = unlines . map unc . lines
unc l = case l of
  '-':'-':_ -> []
  c : cs -> c : unc cs
  _ -> l

