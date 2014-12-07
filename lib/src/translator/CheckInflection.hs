-- elementary soundness check of a dictionary, e.g. if all verbs have verb-like endings
-- usage: checkSoundness <Filename> <Lang>
-- comment out bad lines in tmp/file with --UNSOUND

checkSoundness file lang = do
  dict <- readFile file >>= return . lines
  let wrongs = [(if has then ("--UNSOUND " ++ d) else d,has) | d <- dict, let has = hasError lang (words d)]
  putStrLn $ unlines $ [p | (p,h) <- wrongs, h]
  writeFile ("tmp/" ++ file) $ unlines $ map fst wrongs

hasError lang ws = case ws of
  u:v:ww | isError lang u v -> True
  _:v:ww -> hasError lang (v:ww)
  _ -> False

isError lang u v = case lang of
  "Spa" -> case bareOp u of
     "mkV"  | head v == '"' -> notElem (dp 2 (stringOf v)) ["ar","er","ir","se"] || elem '_' v
     "mkV2" | head v == '"' -> notElem (dp 2 (stringOf v)) ["ar","er","ir","se"] || elem '_' v 
     "mkA" -> elem '_' (stringOf v)
     _ -> False
  "Ita" -> case take 3 (bareOp u) of
     "mkV"  | head v == '"' -> notElem (dp 3 (stringOf v)) ["are","ere","ire","rsi"] || elem '_' v 
     "mkA" -> elem '_' (stringOf v)
     _ -> False
  "Fre" -> case take 3 (bareOp u) of
     "mkV"  | head v == '"' -> notElem (dp 2 (stringOf v)) ["er","ir","re"] || elem '_' v
     "mkv"  | head v == '"' -> notElem (dp 2 (stringOf v)) ["er","ir","re"] || elem '_' v
     _ | bareOp u == "mkA" -> elem '_' (stringOf v)
     _ -> False
  "Ger" -> case bareOp u of
     "mkV"  | head v == '"' -> notElem (dp 2 (stringOf v)) ["en","rn","ln"]
     _ -> False

dp :: Int -> String -> String
dp i s = drop (length s - i) s

stringOf s = takeWhile (/='"') (tail s)

bareOp = filter (flip notElem "()")

lexs s = case lex s of [(t,cs@(_:_))] -> t:lexs cs ; [(t,[])] -> [t] ; _ -> []
