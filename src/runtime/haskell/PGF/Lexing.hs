module PGF.Lexing where
import Data.Char(isSpace,toLower,toUpper)

-- * Text lexing
lexText :: String -> [String]
lexText = uncap . lext where
  lext s = case s of
    c:cs | isMajorPunct c -> [c] : uncap (lext cs)
    c:cs | isMinorPunct c -> [c] : lext cs
    c:cs | isSpace c ->       lext cs
    _:_ -> let (w,cs) = break (\x -> isSpace x || isPunct x) s in w : lext cs
    _ -> [s]
  uncap s = case s of
    (c:cs):ws -> (toLower c : cs):ws
    _ -> s

unlexText :: [String] -> String
unlexText = unlext where
  unlext s = case s of
    w:[] -> w
    w:[c]:[] | isPunct c -> w ++ [c]
    w:[c]:cs | isMajorPunct c -> w ++ [c] ++ " " ++ capitInit (unlext cs)
    w:[c]:cs | isMinorPunct c -> w ++ [c] ++ " " ++ unlext cs
    w:ws -> w ++ " " ++ unlext ws
    _ -> []

-- | Bind tokens separated by Prelude.BIND, i.e. &+
bindTok :: [String] -> String
bindTok ws = case ws of
    w:"&+":ws2 -> w ++ bindTok ws2
    w:[]       -> w
    w:ws2      -> w ++ " " ++ bindTok ws2
    []         -> ""

-- * Code lexing

-- | Haskell lexer, usable for much code
lexCode :: String -> [String]
lexCode ss = case lex ss of
  [(w@(_:_),ws)] -> w : lexCode ws
  _ -> []

unlexCode :: [String] -> String
unlexCode s = case s of
  w:[] -> w
  [c]:cs | isParen c -> [c] ++ unlexCode cs
  w:cs@([c]:_) | isClosing c -> w ++ unlexCode cs
  w:ws -> w ++ " " ++ unlexCode ws
  _ -> []


-- * Mixed lexing

-- | LaTeX style lexer, with "math" environment using Code between $...$
lexMixed :: String -> [String]
lexMixed = concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (=='$') s of
      (t,[])  -> lex env t : []
      (t,c:m) -> lex env t : [[c]] : alternate (not env) m
    _ -> []
  lex env = if env then lexCode else lexText

unlexMixed :: [String] -> String
unlexMixed = concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (=="$") s of
      (t,[])  -> unlex env t : []
      (t,c:m) -> unlex env t : sep env c : alternate (not env) m
    _ -> []
  unlex env = if env then unlexCode else unlexText
  sep env c = if env then c ++ " " else " " ++ c

-- * Additional lexing uitilties

-- | Capitalize first letter
capitInit s = case s of
  c:cs -> toUpper c : cs
  _ -> s

-- | Unquote each string wrapped in double quotes
unquote = map unq where 
  unq s = case s of
    '"':cs@(_:_) | last cs == '"' -> init cs
    _ -> s

isPunct = flip elem ".?!,:;"
isMajorPunct = flip elem ".?!"
isMinorPunct = flip elem ",:;"
isParen = flip elem "()[]{}"
isClosing = flip elem ")]}"
