import Char

infile = "mywordlist1"

main = do
  s <- readFile infile
  mapM_ (putStrLn . mkOne) $ lines s

mkOne s = case words s of
  "--":_ -> ""
  ('(':_):w:cat:ws -> unwords $ mkCatf (nopar cat) (more ws) w
  _ -> "-- " ++ s
 where
  more ws = case ws of
    _ | elem "(REG" ws -> "irreg"
    _ -> "reg"
  nopar = filter (flip notElem "()")
  mkCatf c r w = case c of
    "Noun" -> ["N","regN",w]
    "Adject" -> ["A","regA",w]
    "Adject_LONG" -> ["A","longA",w]
    "Verb" | r == "irreg" -> []
    "Verb"  -> ["V","regV",w]
    "V2" | r == "irreg" -> ["V2","irreg", w, "_V"]
    "V2" -> ["V2","regV2", w]
    "PNoun" -> ["PN","regPN",toUpper (head w): tail w]
    'V':'2':'_':prep | r == "irreg" -> 
                  ["V2","mkV2", w, "_V", map toLower prep]
    x:'2':'_':prep -> [[x]++"2","prep" ++[x]++"2", w, map toLower prep]
    _ -> [c,"mk" ++ c, w]

