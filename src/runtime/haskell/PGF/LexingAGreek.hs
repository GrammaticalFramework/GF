module PGF.LexingAGreek where                      -- HL 2a1.2.2016
import Data.Char(isSpace)

-- * Text lexing without word capitalization of the first word of every sentence.
-- Greek sentences in (transliterated) texts don't start with capital character. 

-- Ordinary greek text does not have vowel length indicators. We then use '.' as
-- a sentence separator.

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
{-
test = map denormalize enclitics_expls

*PGF.LexingAGreek> test
  ["sofw~n tis*","sofw~n tines*","sof~n tinwn",
  "sofo's tis*","sofoi' tines*",
  "ei)' tis*","ei)' tines*",
  "a)'nvrwpo's* tis*","a)'nvrwpoi' tines*",
  "doy~lo's* tis*","doy~loi' tines*",
  "lo'gos* tis* ","lo'goi tine's*","lo'gwn tinw~n ",
  "ei)' poy' ti's* tina i)'doi"]

-- normalization:

*PGF.LexingAGreek> map normalize test
  ["sofw~n tis*","sofw~n tine's*","sof~n tinw~n",
  "sofo's tis*","sofoi' tine's*",
  "ei) tis*","ei) tine's*",
  "a)'nvrwpos* tis*","a)'nvrwpoi tine's*",
  "doy~los* tis*","doy~loi tine's*",
  "lo'gos* tis*","lo'goi tine's*","lo'gwn tinw~n",
  "ei) poy tis* tina' i)'doi"]

*PGF.LexingAGreek> map (normalize . denormalize) enclitics_expls == enclitics_expls
True
*PGF.LexingAGreek> map (denormalize . normalize) test == test
True

-}
