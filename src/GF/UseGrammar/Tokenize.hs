module Tokenize where

import Operations
---- import UseGrammar (isLiteral,identC)
import CFIdent

import Char

-- lexers = tokenizers, to prepare input for GF grammars. AR 4/1/2002
-- an entry for each is included in Custom.customTokenizer

-- just words

tokWords :: String -> [CFTok]
tokWords = map tS . words

tokLits :: String -> [CFTok]
tokLits = map mkCFTok . words

tokVars :: String -> [CFTok]
tokVars = map mkCFTokVar . words

mkCFTok :: String -> CFTok
mkCFTok s = case s of
  '"' :cs@(_:_) -> tL $ init cs
  '\'':cs@(_:_) -> tL $ init cs --- 's Gravenhage
  _:_ | all isDigit s -> tI s
  _ -> tS s

mkCFTokVar :: String -> CFTok
mkCFTokVar s = case s of
  '?':_:_      -> tM s
  'x':'_':_    -> tV s
  'x':[]       -> tV s
  '$':xs@(_:_) -> if last s == '$' then tV (init xs) else tS s
  _            -> tS s

mkLit :: String -> CFTok
mkLit s = if (all isDigit s) then (tI s) else (tL s)

mkTL :: String -> CFTok
mkTL s = if (all isDigit s) then (tI s) else (tL ("'" ++ s ++ "'"))


-- Haskell lexer, usable for much code

lexHaskell :: String -> [CFTok]
lexHaskell ss = case lex ss of
  [(w@(_:_),ws)] -> tS w : lexHaskell ws
  _ -> []

-- somewhat shaky text lexer

lexText :: String -> [CFTok]
lexText = uncap . lx where

  lx s = case s of
    p : cs | isMPunct p -> tS [p] : uncap (lx cs)
    p : cs | isPunct p  -> tS [p] : lx cs
    s : cs | isSpace s  -> lx cs
    _ : _  -> getWord s
    _ -> []

  getWord s  = tS w : lx ws where (w,ws) = span isNotSpec s
  isMPunct c = elem c ".!?"
  isPunct c  = elem c ",:;()\""
  isNotSpec c = not (isMPunct c || isPunct c || isSpace c)
  uncap (TS (c:cs) : ws) = tC (c:cs) : ws
  uncap s = s

-- lexer for C--, a mini variant of C

lexC2M :: String -> [CFTok]
lexC2M = lexC2M' False

lexC2M' :: Bool -> String -> [CFTok]
lexC2M' isHigherOrder s = case s of
  '#':cs                 -> lexC $ dropWhile (/='\n') cs
  '/':'*':cs             -> lexC $ dropComment cs
  c:cs   | isSpace c     -> lexC cs
  c:cs   | isAlpha c     -> getId s
  c:cs   | isDigit c     -> getLit s
  c:d:cs | isSymb [c,d]  -> tS [c,d] : lexC cs
  c:cs   | isSymb [c]    -> tS [c]   : lexC cs
  _                      -> [] --- covers end of file and unknown characters
 where
  lexC = lexC2M' isHigherOrder
  getId s  = mkT i : lexC cs where (i,cs) = span isIdChar s
  getLit s = tI i  : lexC cs where (i,cs) = span isDigit s
  isIdChar c = isAlpha c || isDigit c || elem c "'_"
  isSymb = reservedAnsiCSymbol 
  dropComment s = case s of
    '*':'/':cs -> cs
    _:cs -> dropComment cs
    _ -> []
  mkT i = if (isRes i) then (tS i) else 
            if isHigherOrder then (tV i) else (tL ("'" ++ i ++ "'"))
  isRes = reservedAnsiC


reservedAnsiCSymbol s = case lookupTree show s ansiCtree of
  Ok True -> True 
  _ -> False

reservedAnsiC s = case lookupTree show s ansiCtree of
  Ok False -> True 
  _ -> False

-- for an efficient lexer: precompile this!
ansiCtree = buildTree $ [(s,True)  | s <- reservedAnsiCSymbols] ++
                        [(s,False) | s <- reservedAnsiCWords]

reservedAnsiCSymbols = words $
    "<<= >>= << >> ++ -- == <= >= *= += -= %= /= &= ^= |= " ++ 
    "^ { } = , ; + * - ( ) < > & % ! ~"

reservedAnsiCWords = words $ 
    "auto break case char const continue default " ++ 
    "do double else enum extern float for goto if int " ++
    "long register return short signed sizeof static struct switch typedef " ++
    "union unsigned void volatile while " ++
    "main printin putchar"  --- these are not ansi-C

-- turn unknown tokens into string literals; not recursively for literals 123, 'foo'

unknown2string :: (String -> Bool) -> [CFTok] -> [CFTok]
unknown2string isKnown = map mkOne where
  mkOne t@(TS s) = if isKnown s then t else mkTL s
  mkOne t@(TC s) = if isKnown s then t else mkTL s
  mkOne t        = t

lexTextLiteral    isKnown = unknown2string isKnown . lexText
lexHaskellLiteral isKnown = unknown2string isKnown . lexHaskell

