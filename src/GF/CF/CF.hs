module CF where

import Operations
import Str
import AbsGFC
import GFC
import CFIdent
import List (nub,nubBy)
import Char (isUpper, isLower, toUpper, toLower)

-- context-free grammars. AR 15/12/1999 -- 30/3/2000 -- 2/6/2001 -- 3/12/2001

-- CF grammar data types

-- abstract type CF. 
-- Invariant: each category has all its rules grouped with it 
--      also: the list is never empty (the category is just missing then)
newtype CF  = CF ([(CFCat,[CFRule])], CFPredef) 
type CFRule = (CFFun, (CFCat, [CFItem]))

-- CFPredef is a hack for variable symbols and literals; normally = const []
data CFItem = CFTerm RegExp | CFNonterm CFCat deriving (Eq, Ord,Show)

newtype CFTree = CFTree (CFFun,(CFCat, [CFTree])) deriving (Eq, Show)

type CFPredef  = CFTok -> [(CFCat, CFFun)] -- recognize literals, variables, etc

-- Wadler style + return information
type CFParser = [CFTok] -> ([(CFTree,[CFTok])],String)

cfParseResults :: ([(CFTree,[CFTok])],String) -> [CFTree]
cfParseResults rs = [b | (b,[]) <- fst rs]

-- terminals are regular expressions on words; to be completed to full regexp
data RegExp = 
    RegAlts [CFWord]         -- list of alternative words
  | RegSpec CFTok            -- special token
  deriving (Eq, Ord, Show)

type CFWord = String

-- the above types should be kept abstract, and the following functions used

-- to construct CF grammars

emptyCF :: CF
emptyCF = CF ([], emptyCFPredef)

emptyCFPredef :: CFPredef
emptyCFPredef = const []

rules2CF :: [CFRule] -> CF
rules2CF rs = CF (groupCFRules rs, emptyCFPredef)

groupCFRules :: [CFRule] -> [(CFCat,[CFRule])]
groupCFRules = foldr ins [] where
  ins rule crs = case crs of
    (c,r) : rs | compatCF c cat -> (c,rule:r) : rs
    cr    : rs            -> cr         : ins rule rs
    _                     -> [(cat,[rule])]
   where
     cat = valCatCF rule

-- to construct rules

-- make a rule from a single token without constituents
atomCFRule :: CFCat -> CFFun -> CFTok -> CFRule
atomCFRule c f s = (f, (c, [atomCFTerm s]))

-- usual terminal
atomCFTerm :: CFTok -> CFItem 
atomCFTerm = CFTerm . atomRegExp

atomRegExp :: CFTok -> RegExp
atomRegExp t = case t of
  TS s -> RegAlts [s] 
  _    -> RegSpec t

-- terminal consisting of alternatives
altsCFTerm :: [String] -> CFItem 
altsCFTerm = CFTerm . RegAlts


-- to construct trees

-- make a tree without constituents
atomCFTree :: CFCat -> CFFun -> CFTree
atomCFTree c f = buildCFTree c f []

-- make a tree with constituents. 
buildCFTree :: CFCat -> CFFun -> [CFTree] -> CFTree
buildCFTree c f trees = CFTree (f,(c,trees))

{- ----
cfMeta0 :: CFTree
cfMeta0 = atomCFTree uCFCat metaCFFun

-- used in happy
litCFTree :: String -> CFTree --- Maybe CFTree
litCFTree s = maybe cfMeta0 id $ do
  (c,f) <- getCFLiteral s
  return $ buildCFTree c f []
-}

-- to decide whether a token matches a terminal item

matchCFTerm :: CFItem -> CFTok -> Bool
matchCFTerm (CFTerm t) s = satRegExp t s
matchCFTerm _ _ = False

satRegExp :: RegExp -> CFTok -> Bool
satRegExp r t = case (r,t) of 
  (RegAlts tt, TS s) -> elem s tt
  (RegAlts tt, TC s) -> or [elem s' tt | s' <- caseUpperOrLower s]
  (RegSpec x,  _)    -> t == x ---
  _ -> False
 where
   caseUpperOrLower s = case s of
     c:cs | isUpper c -> [s, toLower c : cs]
     c:cs | isLower c -> [s, toUpper c : cs]
     _ -> [s]

-- to analyse a CF grammar

catsOfCF :: CF -> [CFCat]
catsOfCF (CF (rr,_)) = map fst rr 

rulesOfCF :: CF -> [CFRule]
rulesOfCF (CF (rr,_)) = concatMap snd rr

ruleGroupsOfCF :: CF -> [(CFCat,[CFRule])]
ruleGroupsOfCF (CF (rr,_)) = rr

rulesForCFCat :: CF -> CFCat -> [CFRule]
rulesForCFCat (CF (rr,_)) cat = maybe [] id $ lookup cat rr

valCatCF :: CFRule -> CFCat
valCatCF (_,(c,_)) = c

valItemsCF :: CFRule -> [CFItem]
valItemsCF (_,(_,i)) = i

valFunCF :: CFRule -> CFFun
valFunCF  (f,(_,_)) = f

startCat :: CF -> CFCat
startCat (CF (rr,_)) = fst (head rr) --- hardly useful

predefOfCF :: CF -> CFPredef
predefOfCF (CF (_,f)) = f

appCFPredef :: CF -> CFTok -> [(CFCat, CFFun)]
appCFPredef = ($) . predefOfCF

valCFItem :: CFItem -> Either RegExp CFCat
valCFItem (CFTerm r)     = Left r
valCFItem (CFNonterm nt) = Right nt

cfTokens :: CF -> [CFWord]
cfTokens cf = nub $ concat $ [ wordsOfRegExp i | r <- rulesOfCF cf, 
                                                 CFTerm i <- valItemsCF r]

wordsOfRegExp :: RegExp -> [CFWord]
wordsOfRegExp (RegAlts tt) = tt
wordsOfRegExp _ = []

forCFItem :: CFTok -> CFRule -> Bool
forCFItem a (_,(_, CFTerm r : _)) = satRegExp r a
forCFItem _ _ = False

isCircularCF :: CFRule -> Bool
isCircularCF (_,(c', CFNonterm c:[])) = compatCF c' c
isCircularCF _ = False
--- we should make a test of circular chains, too

-- coercion to the older predef cf type

predefRules :: CFPredef -> CFTok -> [CFRule]
predefRules pre s = [atomCFRule c f s | (c,f) <- pre s]

