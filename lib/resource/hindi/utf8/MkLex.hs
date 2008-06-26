main = interact (concat . map mkOne . zip [10001..] . lines)

mkOne (i,line) = case line of
  '<':cs -> case pos line of
    "nuon" -> entry (show i) (word line) "N"
    "brev" -> entry (show i) (word line) "V"
    "evitcejda" -> entry (show i) (word line) "A"
    _ -> ""
  _ -> ""

pos line = case reverse line of
  '>':cs -> takeWhile (/='<') cs
  _ -> ""

word line = takeWhile (/='>') line

entry i w c = 
  "fun w" ++ i ++ "_" ++ c ++ " : " ++ c ++ " ;\n" ++
  "lin w" ++ i ++ "_" ++ c ++ " = mk" ++ c ++ " \"" ++ w ++ "\" ;\n"
