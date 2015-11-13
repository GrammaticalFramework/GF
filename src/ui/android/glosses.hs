import SG

main = do
  ls <- fmap lines $ readFile "../../../lib/src/translator/Dictionary.gf"
  writeFile "assets/glosses.txt" (unlines ["<"++fn++",gloss,"++show gloss++">" | Just (fn,gloss) <- map gloss ls])

gloss l = 
  case words l of
    ("fun":fn:_) -> case dropWhile (/='\t') l of
                      '\t':l -> Just (fn,l)
                      _      -> Nothing
    _            -> Nothing

test = do
  db <- openSG "semantics.db"
  ls <- fmap lines $ readFile "assets/glosses.txt"
  inTransaction db $
    sequence_ [insertTriple db s p o | Just (s,p,o) <- map readTriple ls]
  closeSG db
