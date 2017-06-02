module PGF.Lexing where
import Data.Char(isSpace,toLower,toUpper)

-- * Text lexing
-- | Text lexing with standard word capitalization of the first word of every sentence
lexText :: String -> [String]
lexText = lexText' uncapitInit

-- | Text lexing with custom treatment of the first word of every sentence.
lexText' :: (String->String) -> String -> [String]
lexText' uncap1 = uncap . lext where
  lext s = case s of
    c:cs | isMajorPunct c -> [c] : uncap (lext cs)
    c:cs | isMinorPunct c -> [c] : lext cs
    c:cs | isSpace c ->       lext cs
    _:_ -> let (w,cs) = break (\x -> isSpace x || isPunct x) s in w : lext cs
    _ -> [s]
  uncap s = case s of
    w:ws -> uncap1 w:ws
    _ -> s

unlexText :: [String] -> String
unlexText = capitInit . unlext where
  unlext s = case s of
    w:[] -> w
    w:[c]:[] | isPunct c -> w ++ [c]
    w:[c]:cs | isMajorPunct c -> w ++ [c] ++ " " ++ capitInit (unlext cs)
    w:[c]:cs | isMinorPunct c -> w ++ [c] ++ " " ++ unlext cs
    w:ws -> w ++ " " ++ unlext ws
    _ -> []

-- | Bind tokens separated by Prelude.BIND, i.e. &+
bindTok :: [String] -> [String]
bindTok ws = case ws of
               w1:"&+":w2:ws -> bindTok ((w1++w2):ws)
               "&+":ws       -> bindTok ws
               "&|":(c:cs):ws-> bindTok ((toUpper c:cs) : ws)
               "&|":ws       -> bindTok ws
               w:ws          -> w:bindTok ws
               []            -> []

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


-- | LaTeX lexer in the math mode: \ should not be separated from the next word

lexLatexCode :: String -> [String]
lexLatexCode = restoreBackslash . lexCode where --- quick hack: postprocess Haskell's lex
  restoreBackslash ws = case ws of
    "\\":w:ww -> ("\\" ++ w) : restoreBackslash ww
    w:ww -> w:restoreBackslash ww
    _ -> ws

-- * Mixed lexing

-- | LaTeX style lexer, with "math" environment using Code between $...$
lexMixed :: String -> [String]
lexMixed = concat . alternate False [] where
  alternate env t s = case s of
    '$':cs -> lex env (reverse t) : ["$"] : alternate (not env) [] cs
    '\\':c:cs | elem c "()[]" -> lex env (reverse t) : [['\\',c]] : alternate (not env) [] cs
    c:cs -> alternate env (c:t) cs
    _ -> [lex env (reverse t)]
  lex env = if env then lexLatexCode else lexText

unlexMixed :: [String] -> String
unlexMixed = capitInit . concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (flip elem ["$","\\[","\\]","\\(","\\)"]) s of
      (t,[])  -> unlex env t : []
      (t,c:m) -> unlex env t : sep env c m : alternate (not env) m
    _ -> []
  unlex env = if env then unlexCode else (uncapitInit . unlexText)
  sep env c m = case (m,env) of
    ([p]:_,True) | isPunct p -> c   -- closing $ glued to next punct 
    (_,  True) -> c ++ " "   -- closing $ otherwise separated by space from what follows
    _ -> " " ++ c   -- put space before opening $

-- * Additional lexing uitilties

-- | Capitalize first letter
capitInit s = case s of
  c:cs -> toUpper c : cs
  _ -> s

-- | Uncapitalize first letter
uncapitInit s = case s of
  c:cs -> toLower c : cs
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
