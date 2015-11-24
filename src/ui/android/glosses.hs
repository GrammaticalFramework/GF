import SG
import Data.Char
import Data.List

main = do
  ls <- fmap lines $ readFile "../../../lib/src/translator/Dictionary.gf"
  writeFile "assets/glosses.txt" (unlines [x | Just (fn,gloss) <- map gloss ls, x <- glossTriples fn gloss])

gloss l = 
  case words l of
    ("fun":fn:_) -> case dropWhile (/='\t') l of
                      '\t':l -> Just (fn,l)
                      _      -> Nothing
    _            -> Nothing

glossTriples fn s =
  (if null gs then [] else ["<"++fn++",gloss,"++show (merge gs)++">"])++
  (if null es then [] else ["<"++fn++",example,"++show (merge (map (init . tail) es))++">"])
  where
    (es,gs) = partition isExample (splitGloss s)

splitGloss s =
  let (xs,s') = break (==';') s
  in trim xs : case s' of
                 ';':s -> splitGloss s
                 _     -> []
  where
    trim = reverse . dropWhile isSpace . reverse . dropWhile isSpace

merge = intercalate "; "

isExample s = not (null s) && head s == '"' && last s == '"'
