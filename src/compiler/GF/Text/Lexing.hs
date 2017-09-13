-- | Lexers and unlexers - they work on space-separated word strings
module GF.Text.Lexing (stringOp,opInEnv) where

import GF.Text.Transliterations

import Data.Char (isSpace,toUpper,toLower)
import Data.List (intersperse)

stringOp :: (String -> Bool) -> String -> Maybe (String -> String)
stringOp good name = case name of
  "chars"      -> Just $ appLexer (filter (not . all isSpace) . map return)
  "lextext"    -> Just $ appLexer (lexText good)
  "lexcode"    -> Just $ appLexer lexCode
  "lexmixed"   -> Just $ appLexer (lexMixed good)
  "lexgreek"   -> Just $ appLexer lexAGreek
  "lexgreek2"  -> Just $ appLexer lexAGreek2
  "words"      -> Just $ appLexer words
  "bind"       -> Just $ appUnlexer (unwords . bindTok)
  "unchars"    -> Just $ appUnlexer concat
  "unlextext"  -> Just $ appUnlexer (unlexText . unquote . bindTok)
  "unlexcode"  -> Just $ appUnlexer unlexCode
  "unlexmixed" -> Just $ appUnlexer (unlexMixed good . unquote . bindTok)
  "unlexgreek" -> Just $ appUnlexer unlexAGreek
  "unlexnone"  -> Just id
  "unlexid"    -> Just id
  "unwords"    -> Just $ appUnlexer unwords
  "to_html"    -> Just wrapHTML
  _            -> transliterate name

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


-- * Text lexing
-- | Text lexing with standard word capitalization of the first word of every sentence
lexText :: (String -> Bool) -> String -> [String]
lexText good = lexText' (uncapitInit good)

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
  

-- * Ancient Greek lexing

lexTextAGreek :: String -> [String]
lexTextAGreek s = lext s where
  lext s = case s of
    c:cs | isAGreekPunct c -> [c] : (lext cs)
    c:cs | isSpace c -> lext cs
    _:_ -> let (w,cs) = break (\x -> isSpace x || isAGreekPunct x) s 
           in w : lext cs
    [] -> []

-- Philological greek text may use vowel length indicators. Then '.' is not a sentence 
-- separator, nor is 'v. ' for vowel v. Sentence ends at 'v..' or 'c. ' with non-vowel c.

lexTextAGreek2 :: String -> [String]
lexTextAGreek2 s = lext s where
  lext s = case s of
    c:cs | isAGreekPunct c -> [c] : (lext cs)
    c:cs | isSpace c -> lext cs
    _:_ -> let (w,cs) = break (\x -> isSpace x || isAGreekPunct x) s 
           in case cs of 
                '.':'.':d:ds | isSpace d 
                  -> (w++['.']) : lext ('.':d:ds)
                '.':d:ds | isAGreekPunct d || isSpace d 
                  -> (w++['.']) : lext (d:ds)
                '.':d:ds | not (isSpace d) 
                  -> case lext (d:ds) of
                       e:es -> (w++['.']++e) : es
                       es -> (w++['.']) : es 
                '.':[] -> (w++['.']) : []
                _ -> w : lext cs      
    [] -> []

unlexTextAGreek :: [String] -> String
unlexTextAGreek = unlext where
  unlext s = case s of
    w:[] -> w
    w:[c]:[] | isAGreekPunct c -> w ++ [c]
    w:[c]:cs | isAGreekPunct c -> w ++ [c] ++ " " ++ unlext cs
    w:ws -> w ++ " " ++ unlext ws
    [] -> []

isAGreekPunct = flip elem ".,;··"  -- colon: first version · not in charset,
                                   -- second version · = 00B7 standard code point

-- * Text lexing and unlexing for Ancient Greek: 
--   1. no capitalization of initial word, 
--   2. grave/acute accent switch on final syllables of words not followed by punctuation, 
--   3. accent move from/to support word to/from following clitic words (iterated).

lexAGreek :: String -> [String]
lexAGreek = fromAGreek . lexTextAGreek

lexAGreek2 :: String -> [String]
lexAGreek2 = fromAGreek . lexTextAGreek2

unlexAGreek :: [String] -> String
unlexAGreek = unlexTextAGreek . toAGreek

-- Note: unlexAGreek does not glue punctuation with the previous word, so that short
-- vowel indication (like a.) differs from sentence end (a .). 

-- | normalize = change grave accent on sentence internal words to acute, 
-- and shift inherited acutes to the following enclitic (where they are
-- visible only as shown in the list of enclitics above)

normalize :: String -> String
normalize = (unlexTextAGreek . fromAGreek . lexTextAGreek) 

fromAGreek :: [String] -> [String]
fromAGreek s = case s of
  w:[]:vs -> w:[]:(fromAGreek vs)
  w:(v:vs) | isAGreekPunct (head v) -> w:v:(fromAGreek vs)
  w:v:vs | wasEnclitic v && wasEnclitic w ->
    getEnclitic w : fromAGreek (v:vs)
  w:v:vs | wasEnclitic v && wasProclitic w ->  -- "ei)' tines*"
    getProclitic w : getEnclitic v : fromAGreek vs
  w:v:vs | wasEnclitic v && (hasEndCircum w || 
    (hasEndAcute w && hasSingleAccent w)) ->  
    w : getEnclitic v : fromAGreek vs        -- ok "sofoi' tines*"
  w:v:vs | wasEnclitic v && hasPrefinalAcute w ->
    w : getEnclitic v : fromAGreek vs
  w:v:vs | wasEnclitic v && hasEndAcute w ->  -- ok "a)'nvrwpoi' tines*"
    dropLastAccent w : getEnclitic v : fromAGreek vs
  w:v:vs | wasEnclitic w ->
    getEnclitic w : fromAGreek (v:vs)
  w:ws -> (toAcute w) : (fromAGreek ws)
  ws -> ws 

-- | de-normalize = change acute accent of end syllables in sentence internal 
--  (non-enclitic) words to grave accent, and move accents of enclitics to the 
--  previous word to produce ordinary ancient greek

denormalize :: String -> String
denormalize = (unlexTextAGreek . toAGreek . lexTextAGreek) 

toAGreek :: [String] -> [String]
toAGreek s = case s of
  w:[]:vs -> w:[]:(toAGreek vs)
  w:v:vs | isAGreekPunct (head v) -> w:[]:v:(toAGreek vs)  -- w:[] for following -to_ancientgreek
  w:v:vs | isEnclitic v && isEnclitic w -> 
    addAcute w : toAGreek (dropAccent v:vs)    -- BR 11 Anm.2
  w:v:vs | isEnclitic v && isProclitic w ->    -- BR 11 a.beta
    addAcute w: (toAGreek (dropAccent v:vs))
  w:v:vs | isEnclitic v && (hasEndCircum w || hasEndAcute w) -> 
    w:(toAGreek (dropAccent v:vs))             -- BR 11 a.alpha,beta
  w:v:vs | isEnclitic v && hasPrefinalAcute w -> 
    w:v: toAGreek vs   -- bisyllabic v keeps its accent  BR 11 b.
  w:v:vs | isEnclitic v -> 
    (addAcute w):(toAGreek (dropAccent v:vs))  -- BR 11 a.gamma
  w:v:vs | isEnclitic w -> w:(toAGreek (v:vs))
  w:ws -> (toGrave w) : (toAGreek ws)
  ws -> ws 

-- | Change accent on the final syllable of a word

toGrave :: String -> String 
toGrave = reverse . grave . reverse where
  grave s = case s of
    '\'':cs -> '`':cs 
    c:cs | isAGreekVowel c -> c:cs 
    c:cs -> c: grave cs
    _ -> s

toAcute :: String -> String 
toAcute = reverse . acute . reverse where
  acute s = case s of
    '`':cs -> '\'':cs
    c:cs | isAGreekVowel c -> c:cs 
    c:cs -> c: acute cs
    _ -> s

isAGreekVowel = flip elem "aeioyhw"

-- | Accent moves for enclitics and proclitics (atona)

enclitics = [
  "moy","moi","me",     -- personal pronouns
  "soy","soi","se",
  "oy(","oi(","e(",
  "tis*","ti","tina'",  -- indefinite pronoun 
  "tino's*","tini'",
  "tine's*","tina's*",
  "tinw~n","tisi'","tisi'n",
  "poy","poi",          -- indefinite adverbs
  "pove'n","pws*",
  "ph|","pote'",
  "ge","te","toi",      -- particles
  "nyn","per","pw" 
   -- suffix -"de"
   -- praes.indik. of fhmi', ei)mi' (except fh's*, ei)~)
  ] -- and more, BR 11

proclitics = [
  "o(","h(","oi(","ai(",     -- articles
  "e)n","ei)s*","e)x","e)k", -- prepositions
  "ei)","w(s*",              -- conjunctions
  "oy)","oy)k","oy)c"        -- negation
  ]

isEnclitic = flip elem enclitics
isProclitic = flip elem proclitics

-- Check if a word is an enclitic or accented enclitic and extract the enclitic

wasEnclitic = let unaccented = (filter (not . hasAccent) enclitics) 
                    ++ (map dropAccent (filter hasAccent enclitics))
                  accented = (filter hasAccent enclitics) 
                    ++ map addAcute (filter (not . hasAccent) enclitics) 
              in flip elem (accented ++ unaccented)

wasProclitic = flip elem (map addAcute proclitics)

getEnclitic = 
  let pairs = zip (enclitics ++ (map dropAccent (filter hasAccent enclitics))
                   ++ (map addAcute (filter (not . hasAccent) enclitics)))
                  (enclitics ++ (filter hasAccent enclitics)
                   ++ (filter (not . hasAccent) enclitics))
      find = \v -> lookup v pairs
  in \v -> case (find v) of 
    Just x -> x 
    _ -> v
getProclitic = 
  let pairs = zip (map addAcute proclitics) proclitics 
      find = \v -> lookup v pairs
  in \v -> case (find v) of 
    Just x -> x 
    _ -> v

-- | Accent manipulation

dropAccent = reverse . drop . reverse where 
  drop s = case s of
    [] -> []
    '\'':cs -> cs
    '`':cs -> cs
    '~':cs -> cs
    c:cs -> c:drop cs

dropLastAccent = reverse . drop . reverse where 
  drop s = case s of
    [] -> []
    '\'':cs -> cs
    '`':cs -> cs
    '~':cs -> cs
    c:cs -> c:drop cs

addAcute :: String -> String
addAcute = reverse . acu . reverse where
  acu w = case w of 
    c:cs | c == '\'' -> c:cs
    c:cs | c == '(' -> '\'':c:cs
    c:cs | c == ')' -> '\'':c:cs
    c:cs | isAGreekVowel c -> '\'':c:cs
    c:cs -> c : acu cs
    _ -> w

-- | Accent checking on end syllables

hasEndAcute = find . reverse where
  find s = case s of
    [] -> False
    '\'':cs -> True
    '`':cs -> False
    '~':cs -> False
    c:cs | isAGreekVowel c -> False
    _:cs -> find cs

hasEndCircum = find . reverse where
  find s = case s of
    [] -> False
    '\'':cs -> False
    '`':cs -> False
    '~':cs -> True
    c:cs | isAGreekVowel c -> False
    _:cs -> find cs

hasPrefinalAcute = find . reverse where
  find s = case s of
    [] -> False
    '\'':cs -> False  -- final acute
    '`':cs -> False
    '~':cs -> False
    c:d:cs | isAGreekVowel c && isAGreekVowel d -> findNext cs
    c:cs | isAGreekVowel c -> findNext cs
    _:cs -> find cs where
  findNext s = case s of 
    [] -> False
    '\'':cs -> True  -- prefinal acute
    '`':cs -> False
    '~':cs -> False
    c:cs | isAGreekVowel c -> False
    _:cs -> findNext cs where
    
hasSingleAccent v = 
  hasAccent v && not (hasAccent (dropLastAccent v))

hasAccent v = case v of 
  [] -> False
  c:cs -> elem c ['\'','`','~'] || hasAccent cs

{- Tests: 

-- denormalization. Examples in BR 11 work: 
-}
enclitics_expls = -- normalized
  "sofw~n tis*":"sofw~n tine's*":"sof~n tinw~n":  -- a.alpha
  "sofo's tis*":"sofoi' tine's*":                 -- a.beta
  "ei) tis*":"ei) tine's*":
  "a)'nvrwpos* tis*":"a)'nvrwpoi tine's*":        -- a.gamma
  "doy~los* tis*":"doy~loi tine's*":
  "lo'gos* tis*":"lo'goi tine's*":"lo'gwn tinw~n":  -- b.
  "ei) poy tis* tina' i)'doi":                    -- Anm. 2.
  [] 


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
lexMixed :: (String -> Bool) -> String -> [String]
lexMixed good = concat . alternate False [] where
  alternate env t s = case s of
    '$':cs -> lex env (reverse t) : ["$"] : alternate (not env) [] cs
    '\\':c:cs | elem c "()[]" -> lex env (reverse t) : [['\\',c]] : alternate (not env) [] cs
    c:cs -> alternate env (c:t) cs
    _ -> [lex env (reverse t)]
  lex env = if env then lexLatexCode else lexText good

unlexMixed :: (String -> Bool) -> [String] -> String
unlexMixed good = capitInit . concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (flip elem ["$","\\[","\\]","\\(","\\)"]) s of
      (t,[])  -> unlex env t : []
      (t,c:m) -> unlex env t : sep env c m : alternate (not env) m
    _ -> []
  unlex env = if env then unlexCode else (uncapitInit good . unlexText)
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
uncapitInit good s = 
  case s of
    c:cs | not (good s) -> toLower c : cs
    _                   -> s

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
