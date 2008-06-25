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
    "PRT" -> ["Adv","mkAdv",w] ----
    "TITLE" -> ["N","regN",w] ----
    "Adject" -> ["A","regA",w]
    "AdjInf" -> ["A","regA",w] ----
    "AdjInf_LONG" -> ["A","longA",w] ----
    "AdjPrd" -> ["A","regA",w] ----
    "AdjPrd_LONG" -> ["A","longA",w] ----
    "Adject_LONG" -> ["A","longA",w]
    "Verb" | r == "irreg" -> []
    "Verb"  -> ["V","regV",w]
    "V2" | r == "irreg" -> ["V2","irreg", w, "_V"]
    "V2" -> ["V2","regV2", w]
    "PNoun" -> ["PN","regPN",toUpper (head w): tail w]
    'V':'2':'_':prep | r == "irreg" -> 
               let p = map toLower prep in ["V2","mkV2_"++p, w, "_V", p]
    x:'2':'_':prep -> 
               let p = map toLower prep in [[x]++"2","prep" ++[x]++"2"++p, w, p]
    "V3_NP" | r == "irreg" -> ["V3","irreg", w, "_V"]
    "V3_NP" -> ["V3","regV3", w]
    'V':'3':'_':'P':'P':prep | r == "irreg" -> 
               let p = map toLower prep in ["V3","mkV3_"++p, w, "_V", p]
    'V':'3':'_':'P':'P':prep -> 
               let p = map toLower prep in ["V3","mkV3_"++p, w, p]
    'V':'3':'_':'S':_ | r == "irreg" -> ["V2","mkV2_S", w, "_V"] ----
    'V':'3':'_':'S':_ -> ["V2","mkV2_S", w] ----
    'V':'3':'_':_ -> ["V3","mkV3", w] ----

    _ -> [c,"mk" ++ c, w]

