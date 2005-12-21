----------------------------------------------------------------------
-- |
-- Module      : Tokenize
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/29 13:20:08 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.14 $
--
-- lexers = tokenizers, to prepare input for GF grammars. AR 4\/1\/2002.
-- an entry for each is included in 'Custom.customTokenizer'
-----------------------------------------------------------------------------

module GF.UseGrammar.Tokenize ( tokWords,
		  tokLits,
		  tokVars,
		  lexHaskell,
		  lexHaskellLiteral,
		  lexHaskellVar,
		  lexText,
		  lexC2M, lexC2M',
		  lexTextLiteral,
                  lexIgnore,
                  wordsLits
		) where

import GF.Data.Operations
---- import UseGrammar (isLiteral,identC)
import GF.CF.CFIdent

import Data.Char

-- lexers = tokenizers, to prepare input for GF grammars. AR 4/1/2002
-- an entry for each is included in Custom.customTokenizer

-- | just words
tokWords :: String -> [CFTok]
tokWords = map tS . words

tokLits :: String -> [CFTok]
tokLits = map mkCFTok . mergeStr . wordsLits where
  mergeStr ss = case ss of
    w@(c:cs):rest | elem c "\'\"" && c /= last w -> getStr [w] rest
    w      :rest                  -> w : mergeStr rest
    [] -> []
  getStr v ss = case ss of
    w@(_:_):rest | elem (last w) "\'\"" -> (unwords (reverse (w:v))) : mergeStr rest
    w      :rest                 -> getStr (w:v) rest
    [] -> reverse v

tokVars :: String -> [CFTok]
tokVars = map mkCFTokVar . wordsLits

isFloat s = case s of
  c:cs | isDigit c -> isFloat cs
  '.':cs@(_:_)     -> all isDigit cs
  _ -> False


mkCFTok :: String -> CFTok
mkCFTok s = case s of
  '"' :cs@(_:_) | last cs == '"'  -> tL $ init cs
  '\'':cs@(_:_) | last cs == '\'' -> tL $ init cs --- 's Gravenhage
  _:_ | isFloat s -> tF s
  _:_ | all isDigit s -> tI s
  _ -> tS s

mkCFTokVar :: String -> CFTok
mkCFTokVar s = case s of
  '?':_:_      -> tM s --- "?" --- compat with prCF
  'x':'_':_    -> tV s
  'x':[]       -> tV s
  '$':xs@(_:_) -> if last s == '$' then tV (init xs) else tS s
  _            -> tS s

mkTokVars :: (String -> [CFTok]) -> String -> [CFTok]
mkTokVars tok = map tv . tok where
  tv (TS s) = mkCFTokVar s
  tv t = t

mkLit :: String -> CFTok
mkLit s 
  | isFloat s = tF s
  | all isDigit s = tI s
  | otherwise = tL s

mkTL :: String -> CFTok
mkTL s 
  | isFloat s = tF s
  | all isDigit s = tI s
  | otherwise = tL ("'" ++ s ++ "'")


-- | Haskell lexer, usable for much code
lexHaskell :: String -> [CFTok]
lexHaskell ss = case lex ss of
  [(w@(_:_),ws)] -> tS w : lexHaskell ws
  _ -> []

-- | somewhat shaky text lexer
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

-- | lexer for C--, a mini variant of C
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
  getLit s = tI i  : lexC cs where (i,cs) = span isDigit s ---- Float!
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

-- | for an efficient lexer: precompile this!
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

-- | turn unknown tokens into string literals; not recursively for literals 123, 'foo'
unknown2string :: (String -> Bool) -> [CFTok] -> [CFTok]
unknown2string isKnown = map mkOne where
  mkOne t@(TS s) 
    | isKnown s = t
    | isFloat s = tF s
    | all isDigit s = tI s 
    | otherwise = tL s
  mkOne t@(TC s) = if isKnown s then t else mkTL s
  mkOne t        = t

unknown2var :: (String -> Bool) -> [CFTok] -> [CFTok]
unknown2var isKnown = map mkOne where
  mkOne t@(TS "??") = if isKnown "??" then t else tM "??"
  mkOne t@(TS s) 
    | isKnown s = t
    | isFloat s = tF s
    | all isDigit s = tI s 
    | otherwise = tV s
  mkOne t@(TC s) = if isKnown s then t else tV s
  mkOne t        = t

lexTextLiteral, lexHaskellLiteral, lexHaskellVar :: (String -> Bool) -> String -> [CFTok]

lexTextLiteral    isKnown = unknown2string (eitherUpper isKnown) . lexText
lexHaskellLiteral isKnown = unknown2string isKnown . lexHaskell

lexHaskellVar     isKnown = unknown2var isKnown . lexHaskell

eitherUpper isKnown w@(c:cs) = isKnown (toLower c : cs) || isKnown (toUpper c : cs)
eitherUpper isKnown w = isKnown w

-- ignore unknown tokens (e.g. keyword spotting)

lexIgnore :: (String -> Bool) -> [CFTok] -> [CFTok]
lexIgnore isKnown = concatMap mkOne where
  mkOne t@(TS s) 
    | isKnown s = [t]
    | otherwise = []
  mkOne t       = [t]

