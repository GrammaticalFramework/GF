module GF.Text.Lexing (stringOp) where

import GF.Text.Transliterations
import GF.Text.UTF8

import Data.Char

-- lexers and unlexers - they work on space-separated word strings

stringOp :: String -> Maybe (String -> String)
stringOp name = case name of
  "chars"      -> Just $ appLexer (filter (not . all isSpace) . map return)
  "lextext"    -> Just $ appLexer lexText
  "lexcode"    -> Just $ appLexer lexText
  "lexmixed"   -> Just $ appLexer lexMixed
  "words"      -> Just $ appLexer words
  "bind"       -> Just $ appUnlexer bindTok
  "uncars"     -> Just $ appUnlexer concat
  "unlextext"  -> Just $ appUnlexer unlexText
  "unlexcode"  -> Just $ appUnlexer unlexCode
  "unlexmixed" -> Just $ appUnlexer unlexMixed
  "unwords"    -> Just $ appUnlexer unwords
  "to_utf8"    -> Just encodeUTF8
  "from_utf8"  -> Just decodeUTF8
  _ -> transliterate name

appLexer :: (String -> [String]) -> String -> String
appLexer f = unwords . filter (not . null) . f

appUnlexer :: ([String] -> String) -> String -> String
appUnlexer f = unlines . map (f . words) . lines

lexText :: String -> [String]
lexText s = case s of
  c:cs | isPunct c -> [c] : lexText cs
  c:cs | isSpace c ->       lexText cs
  _:_ -> let (w,cs) = break (\x -> isSpace x || isPunct x) s in w : lexText cs
  _ -> [s]

-- | Haskell lexer, usable for much code
lexCode :: String -> [String]
lexCode ss = case lex ss of
  [(w@(_:_),ws)] -> w : lexCode ws
  _ -> []

-- | LaTeX style lexer, with "math" environment using Code between $...$
lexMixed :: String -> [String]
lexMixed = concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (=='$') s of
      (t,[])  -> lex env t : []
      (t,c:m) -> lex env t : [[c]] : alternate (not env) m
    _ -> []
  lex env = if env then lexCode else lexText

bindTok :: [String] -> String
bindTok ws = case ws of
    w:"&+":ws2 -> w ++ bindTok ws2
    w:[]       -> w
    w:ws2      -> w ++ " " ++ bindTok ws2
    []         -> ""

unlexText :: [String] -> String
unlexText s = case s of
  w:[] -> w
  w:[c]:[] | isPunct c -> w ++ [c]
  w:[c]:cs | isPunct c -> w ++ [c] ++ " " ++ unlexText cs
  w:ws -> w ++ " " ++ unlexText ws
  _ -> []

unlexCode :: [String] -> String
unlexCode s = case s of
  w:[] -> w
  [c]:cs | isParen c -> [c] ++ unlexCode cs
  w:cs@([c]:_) | isClosing c -> w ++ unlexCode cs
  w:ws -> w ++ " " ++ unlexCode ws
  _ -> []


unlexMixed :: [String] -> String
unlexMixed = concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (=="$") s of
      (t,[])  -> unlex env t : []
      (t,c:m) -> unlex env t : sep env c : alternate (not env) m
    _ -> []
  unlex env = if env then unlexCode else unlexText
  sep env c = if env then c ++ " " else " " ++ c

isPunct = flip elem ".?!,:;"
isParen = flip elem "()[]{}"
isClosing = flip elem ")]}"
 
