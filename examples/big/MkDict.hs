infile = "mywordlist1"

main = do
  s <- readFile infile
  mapM_ (putStrLn . mkOne) $ lines s

mkOne s = case words s of
  "--":_ -> ""
  ('(':_):w:cat:ws -> 
    let 
      (c,f) = mkCatf (nopar cat) (more ws)
    in unwords $ [c, f, w]
  _ -> "-- " ++ s
 where
  more ws = case ws of
    _ | elem "(REG" ws -> "irreg"
    _ -> "reg"
  nopar = filter (flip notElem "()")
  mkCatf c r = case c of
    "Noun" -> ("N","regN")
    "Adject" -> ("A","regA")
    "Adject_LONG" -> ("A","longA")
    "Verb" -> ("V","regV")
    "PNoun" -> ("PN","regPN")
    _ -> (c,"mk" ++ c)

