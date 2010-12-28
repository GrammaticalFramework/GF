main = interact (unlines . map mkOne . lines)

mkOne line = case words line of
  _:_:_:w:c0:_ -> let c = cat c0 in unwords [mkId w ++ "_" ++ c, ":", c]
  _ -> []

cat c = case c of
  "(adjektiivi)" -> "A"
  "(adverbi)" -> "Adv"
  "(erisnimi)" -> "PN"
  "(interjektio)" -> "Interj"
  "(konjunktio)" -> "Conj"
  "(lukusana)" -> "Numeral"
  "(lyhenne)"  -> "Abbr"
  "(prepositio)" -> "Prep"
  "(pronomini)" -> "Pron"
  "(substantiivi)" -> "N"
  "(verbi)" -> "V"
  _ -> "Junk"


mkId = concatMap trim where
  trim c = case fromEnum c of
    32 -> "_" -- space
    45 -> "_" -- -
    224 -> "a''" -- à
    228 -> "a'" -- ä
    246 -> "o'" -- ö
    252 -> "u'" -- ü
    x | x < 65 || (x > 90 && x < 97) || x > 122 -> "_"
    _   -> [c]
