-- | Lexers and unlexers - they work on space-separated word strings
module GF.Text.Lexing (stringOp,opInEnv) where

import GF.Text.Transliterations
import PGF.Lexing
import PGF.LexingAGreek(lexAGreek,unlexAGreek,lexAGreek2) -- HL 20.2.2016

import Data.Char (isSpace)
import Data.List (intersperse)

stringOp :: String -> Maybe (String -> String)
stringOp name = case name of
  "chars"      -> Just $ appLexer (filter (not . all isSpace) . map return)
  "lextext"    -> Just $ appLexer lexText
  "lexcode"    -> Just $ appLexer lexCode
  "lexmixed"   -> Just $ appLexer lexMixed
  "lexgreek"   -> Just $ appLexer lexAGreek
  "lexgreek2"  -> Just $ appLexer lexAGreek2
  "words"      -> Just $ appLexer words
  "bind"       -> Just $ appUnlexer (unwords . bindTok)
  "unchars"    -> Just $ appUnlexer concat
  "unlextext"  -> Just $ appUnlexer (unlexText . unquote)
  "unlexcode"  -> Just $ appUnlexer unlexCode
  "unlexmixed" -> Just $ appUnlexer (unlexMixed . unquote)
  "unlexgreek" -> Just $ appUnlexer unlexAGreek
  "unwords"    -> Just $ appUnlexer unwords
  "to_html"    -> Just wrapHTML
  _ -> transliterate name

-- perform op in environments beg--end, t.ex. between "--"
--- suboptimal implementation
opInEnv :: String -> String -> (String -> String) -> (String -> String)
opInEnv beg end op = concat . altern False . chop (lbeg, beg) [] where
  chop mk@(lg, mark) s0 s = 
    let (tag,rest) = splitAt lg s in
    if tag==mark then (reverse s0) : mark : chop (switch mk) [] rest 
      else case s of
        c:cs -> chop mk (c:s0) cs
        [] -> [reverse s0]
  switch (lg,mark) = if mark==beg then (lend,end) else (lbeg,beg)
  (lbeg,lend) = (length beg, length end)
  altern m ts = case ts of
    t:ws | not m && t==beg -> t : altern True ws
    t:ws | m     && t==end -> t : altern False ws
    t:ws -> (if m then op t else t) : altern m ws
    [] -> []

appLexer :: (String -> [String]) -> String -> String
appLexer f = unwords . filter (not . null) . f

appUnlexer :: ([String] -> String) -> String -> String
----appUnlexer f = unlines . map (f . words) . lines
appUnlexer f = f . words

wrapHTML :: String -> String
wrapHTML = unlines . tag . intersperse "<br>" . lines where
  tag ss = "<html>":"<head>":"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />":"</head>":"<body>" : ss ++ ["</body>","</html>"]
