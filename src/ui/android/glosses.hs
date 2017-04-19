import SG
import PGF2
import Data.Char
import Data.List

main = do
  db <- openSG "assets/semantics.db"
  inTransaction db $ do
    ls <- fmap lines $ readFile "../../../lib/src/translator/Dictionary.gf"
    let glosses = [x | Just (fn,gloss) <- map gloss ls, x <- glossTriples fn gloss]
    topics <- fmap (map toTriple . lines) $ readFile "topics.txt"
    sequence_ [insertTriple db s p o | (s,p,o) <- glosses++topics]
  closeSG db

toTriple l =
  case readTriple l of
    Just t  -> t
    Nothing -> error ("topics.txt: "++l)

gloss l = 
  case words l of
    ("fun":fn:_) -> case dropWhile (/='\t') l of
                      '\t':l -> Just (fn,l)
                      _      -> Nothing
    _            -> Nothing

glossTriples fn s =
  (if null gs then [] else [(fn_e,gloss,mkStr (merge gs))])++
  (if null es then [] else [(fn_e,example,mkStr (merge (map (init . tail) es)))])
  where
    fn_e    = mkApp fn []
    gloss   = mkApp "gloss"   []
    example = mkApp "example" []
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
