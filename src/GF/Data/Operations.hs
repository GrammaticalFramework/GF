----------------------------------------------------------------------
-- |
-- Module      : Operations
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/11 16:12:41 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.22 $
--
-- some auxiliary GF operations. AR 19\/6\/1998 -- 6\/2\/2001
--
-- Copyright (c) Aarne Ranta 1998-2000, under GNU General Public License (see GPL)
-----------------------------------------------------------------------------

module GF.Data.Operations (-- * misc functions
		   ifNull, onSnd,

		   -- * the Error monad
		   Err(..), err, maybeErr, testErr, errVal, errIn, derrIn,
		   performOps, repeatUntilErr, repeatUntil, okError, isNotError,
		   showBad, lookupErr, lookupErrMsg, lookupDefault, updateLookupList,
		   mapPairListM, mapPairsM, pairM, mapErr, mapErrN, foldErr,
		   (!?), errList, singleton, mapsErr, mapsErrTree,
		   
		   -- ** checking
		   checkUnique, titleIfNeeded, errMsg, errAndMsg,

		   -- * a three-valued maybe type to express indirections
		   Perhaps(..), yes, may, nope,
		   mapP,
		   unifPerhaps, updatePerhaps, updatePerhapsHard,

		   -- * binary search trees; now with FiniteMap
		   BinTree, emptyBinTree, isInBinTree, justLookupTree,
		   lookupTree, lookupTreeMany, lookupTreeManyAll, updateTree,
		   buildTree, filterBinTree,
		   sorted2tree, mapTree, mapMTree, tree2list,
 

		   -- * parsing
		   WParser, wParseResults, paragraphs,

		   -- * printing
		   indent, (+++), (++-), (++++), (+++++),
		   prUpper, prReplicate, prTList, prQuotedString, prParenth, prCurly, 
		   prBracket, prArgList, prSemicList, prCurlyList, restoreEscapes,
		   numberedParagraphs, prConjList, prIfEmpty, wrapLines,

		   -- ** LaTeX code producing functions
		   dollar, mbox, ital, boldf, verbat, mkLatexFile, 
		   begindocument, enddocument,

		   -- * extra
		   sortByLongest, combinations, mkTextFile, initFilePath,

		   -- * topological sorting with test of cyclicity
		   topoTest, topoSort, cyclesIn,

		   -- * the generic fix point iterator
		   iterFix,

		   -- * association lists
		   updateAssoc, removeAssoc,

		   -- * chop into separator-separated parts
		   chunks, readIntArg, subSequences,

		   -- * state monad with error; from Agda 6\/11\/2001
		   STM(..), appSTM, stm, stmr, readSTM, updateSTM, writeSTM, done,

		   -- * error monad class
		   ErrorMonad(..), checkAgain, checks, allChecks, doUntil
                
		  ) where

import Data.Char (isSpace, toUpper, isSpace, isDigit)
import Data.List (nub, sortBy, sort, deleteBy, nubBy)
--import Data.FiniteMap
import Control.Monad (liftM,liftM2, MonadPlus, mzero, mplus)

import GF.Data.ErrM

infixr 5 +++
infixr 5 ++-
infixr 5 ++++
infixr 5 +++++
infixl 9 !?

ifNull :: b -> ([a] -> b) -> [a] -> b
ifNull b f xs = if null xs then b else f xs

onSnd :: (a -> b) -> (c,a) -> (c,b)
onSnd f (x, y) = (x, f y)

-- the Error monad

-- | analogue of @maybe@
err :: (String -> b) -> (a -> b) -> Err a -> b 
err d f e = case e of
  Ok a -> f a
  Bad s -> d s

-- | add msg s to @Maybe@ failures
maybeErr :: String -> Maybe a -> Err a
maybeErr s = maybe (Bad s) Ok

testErr :: Bool -> String -> Err ()
testErr cond msg = if cond then return () else Bad msg

errVal :: a -> Err a -> a
errVal a = err (const a) id

errIn :: String -> Err a -> Err a
errIn msg = err (\s -> Bad (s ++++ "OCCURRED IN" ++++ msg)) return

-- | used for extra error reports when developing GF
derrIn :: String -> Err a -> Err a
derrIn m = errIn m -- id

performOps :: [a -> Err a] -> a -> Err a
performOps ops a = case ops of
  f:fs -> f a >>= performOps fs
  [] -> return a

repeatUntilErr :: (a -> Bool) -> (a -> Err a) -> a -> Err a
repeatUntilErr cond f a = if cond a then return a else f a >>= repeatUntilErr cond f

repeatUntil :: (a -> Bool) -> (a -> a) -> a -> a
repeatUntil cond f a = if cond a then a else repeatUntil cond f (f a)

okError :: Err a -> a
-- okError = err (error "no result Ok") id
okError = err (error . ("Bad result occurred" ++++)) id

isNotError :: Err a -> Bool
isNotError = err (const False) (const True)

showBad :: Show a => String -> a -> Err b
showBad s a = Bad (s +++ show a)

lookupErr :: (Eq a,Show a) => a -> [(a,b)] -> Err b
lookupErr a abs = maybeErr ("Unknown" +++ show a) (lookup a abs)

lookupErrMsg :: (Eq a,Show a) => String -> a -> [(a,b)] -> Err b
lookupErrMsg m a abs = maybeErr (m +++ "gave unknown" +++ show a) (lookup a abs)

lookupDefault :: Eq a => b -> a -> [(a,b)] -> b
lookupDefault d x l = maybe d id $  lookup x l 

updateLookupList ::  Eq a => (a,b) -> [(a,b)] -> [(a,b)]
updateLookupList ab abs = insert ab [] abs where
 insert c cc [] = cc ++ [c]
 insert (a,b) cc ((a',b'):cc') = if   a == a' 
                                 then cc ++ [(a,b)] ++ cc'
                                 else insert (a,b) (cc ++ [(a',b')]) cc'

mapPairListM :: Monad m => ((a,b) -> m c) -> [(a,b)] -> m [(a,c)]
mapPairListM f xys = mapM (\ p@(x,_) -> liftM ((,) x) (f p)) xys

mapPairsM :: Monad m => (b -> m c) -> [(a,b)] -> m [(a,c)]
mapPairsM f xys = mapM (\ (x,y) -> liftM ((,) x) (f y)) xys

pairM :: Monad a => (b -> a c) -> (b,b) -> a (c,c)
pairM op (t1,t2) = liftM2 (,) (op t1) (op t2)

-- | like @mapM@, but continue instead of halting with 'Err'
mapErr :: (a -> Err b) -> [a] -> Err ([b], String) 
mapErr f xs = Ok (ys, unlines ss) 
  where
    (ys,ss) = ([y | Ok y <- fxs], [s | Bad s <- fxs])
    fxs = map f xs

-- | alternative variant, peb 9\/6-04
mapErrN :: Int -> (a -> Err b) -> [a] -> Err ([b], String)
mapErrN maxN f xs = Ok (ys, unlines (errHdr : ss2)) 
  where
    (ys, ss) = ([y | Ok y <- fxs], [s | Bad s <- fxs])
    errHdr = show nss ++ " errors occured" ++ 
	     if nss > maxN then ", showing the first " ++ show maxN else ""
    ss2 = map ("* "++) $ take maxN ss 
    nss = length ss
    fxs = map f xs


-- | like @foldM@, but also return the latest value if fails
foldErr :: (a -> b -> Err a) -> a -> [b] -> Err (a, Maybe String)
foldErr f s xs = case xs of
  [] -> return (s,Nothing)
  x:xx -> case f s x of
    Ok v  -> foldErr f v xx
    Bad m -> return $ (s, Just m)

-- @!!@ with the error monad
(!?) :: [a] -> Int -> Err a
xs !? i = foldr (const . return) (Bad "too few elements in list") $ drop i xs

errList :: Err [a] -> [a]
errList = errVal []

singleton :: a -> [a]
singleton = (:[])

-- checking

checkUnique :: (Show a, Eq a) => [a] -> [String]
checkUnique ss = ["overloaded" +++ show s | s <- nub overloads] where
  overloads = filter overloaded ss
  overloaded s = length (filter (==s) ss) > 1

titleIfNeeded :: a -> [a] -> [a]
titleIfNeeded a [] = []
titleIfNeeded a as = a:as

errMsg :: Err a -> [String]
errMsg (Bad m) = [m]
errMsg _ = []

errAndMsg :: Err a -> Err (a,[String])
errAndMsg (Bad m) = Bad m
errAndMsg (Ok a) = return (a,[])

-- | a three-valued maybe type to express indirections
data Perhaps a b = Yes a | May b | Nope deriving (Show,Read,Eq,Ord)

yes :: a -> Perhaps a b
yes = Yes

may :: b -> Perhaps a b
may = May

nope :: Perhaps a b
nope = Nope

mapP :: (a -> c) -> Perhaps a b -> Perhaps c b
mapP f p = case p of
  Yes a -> Yes (f a)
  May b -> May b
  Nope  -> Nope

-- | this is what happens when matching two values in the same module
unifPerhaps :: (Eq a, Eq b, Show a, Show b) => 
               Perhaps a b -> Perhaps a b -> Err (Perhaps a b)
unifPerhaps p1 p2 = case (p1,p2) of
  (Nope, _)  -> return p2
  (_, Nope)  -> return p1
  _ -> if p1==p2 then return p1 
                 else Bad ("update conflict between" ++++ show p1 ++++ show p2)

-- | this is what happens when updating a module extension
updatePerhaps :: (Eq a,Eq b, Show a, Show b) => 
                 b -> Perhaps a b -> Perhaps a b -> Err (Perhaps a b)
updatePerhaps old p1 p2 = case (p1,p2) of
  (Yes a,    Nope)  -> return $ may old
  (May older,Nope)  -> return $ may older
  (_, May a)        -> Bad "strange indirection"
  _ -> unifPerhaps p1 p2

-- | here the value is copied instead of referred to; used for oper types
updatePerhapsHard :: (Eq a, Eq b, Show a, Show b) => b -> 
                     Perhaps a b -> Perhaps a b -> Err (Perhaps a b)
updatePerhapsHard old p1 p2 = case (p1,p2) of
  (Yes a,    Nope)  -> return $ yes a
  (May older,Nope)  -> return $ may older
  (_, May a)        -> Bad "strange indirection"
  _ -> unifPerhaps p1 p2

-- binary search trees
--- FiniteMap implementation is slower in crucial tests

data BinTree a b = NT | BT (a,b) !(BinTree a b) !(BinTree a b) deriving (Show)
-- type BinTree a b = FiniteMap a b

emptyBinTree :: BinTree a b
emptyBinTree = NT
-- emptyBinTree = emptyFM

isInBinTree :: (Ord a) => a -> BinTree a b -> Bool
isInBinTree x = err (const False) (const True) .  justLookupTree x
-- isInBinTree = elemFM

justLookupTree :: (Monad m,Ord a) => a -> BinTree a b -> m b
justLookupTree = lookupTree (const [])

lookupTree :: (Monad m,Ord a) => (a -> String) -> a -> BinTree a b -> m b
lookupTree pr x tree = case tree of
 NT -> fail ("no occurrence of element" +++ pr x)
 BT (a,b) left right 
   | x < a  -> lookupTree pr x left
   | x > a  -> lookupTree pr x right
   | x == a -> return b
--lookupTree pr x tree = case lookupFM tree x of
--  Just y -> return y
--  _ -> fail ("no occurrence of element" +++ pr x)

lookupTreeMany :: Ord a => (a -> String) -> [BinTree a b] -> a -> Err b
lookupTreeMany pr (t:ts) x = case lookupTree pr x t of
  Ok v -> return v
  _ -> lookupTreeMany pr ts x
lookupTreeMany pr [] x = Bad $ "failed to find" +++ pr x

lookupTreeManyAll :: Ord a => (a -> String) -> [BinTree a b] -> a -> [b]
lookupTreeManyAll pr (t:ts) x = case lookupTree pr x t of
  Ok v -> v : lookupTreeManyAll pr ts x
  _ -> lookupTreeManyAll pr ts x
lookupTreeManyAll pr [] x = []

-- | destructive update
updateTree :: (Ord a) => (a,b) -> BinTree a b -> BinTree a b
-- updateTree (a,b) tr = addToFM tr a b
updateTree = updateTreeGen True

-- | destructive or not
updateTreeGen :: (Ord a) => Bool -> (a,b) -> BinTree a b -> BinTree a b
updateTreeGen destr z@(x,y) tree = case tree of
 NT -> BT z NT NT
 BT c@(a,b) left right 
   | x < a  -> let left' = updateTree z left in   BT c left' right 
   | x > a  -> let right' = updateTree z right in BT c left right' 
   | otherwise -> if destr
                    then BT z left right -- removing the old value of a
                    else tree            -- retaining the old value if one exists

buildTree :: (Ord a) => [(a,b)] -> BinTree a b
buildTree = sorted2tree . sortBy fs where
  fs (x,_) (y,_) 
    | x < y = LT
    | x > y = GT
    | True  = EQ 
-- buildTree = listToFM

sorted2tree :: Ord a => [(a,b)] -> BinTree a b
sorted2tree [] = NT
sorted2tree xs = BT x (sorted2tree t1) (sorted2tree t2) where
  (t1,(x:t2)) = splitAt (length xs `div` 2) xs
--sorted2tree = listToFM

--- dm less general than orig
mapTree :: ((a,b) -> (a,c)) -> BinTree a b -> BinTree a c
mapTree f NT = NT
mapTree f (BT a left right) = BT (f a) (mapTree f left) (mapTree f right)
--mapTree f = mapFM (\k v -> snd (f (k,v)))

--- fm less efficient than orig?
mapMTree :: (Ord a,Monad m) => ((a,b) -> m (a,c)) -> BinTree a b -> m (BinTree a c)
mapMTree f NT = return NT
mapMTree f (BT a left right) = do
  a'     <- f a
  left'  <- mapMTree f left 
  right' <- mapMTree f right
  return $ BT a' left' right'
--mapMTree f t = liftM listToFM $ mapM f $ fmToList t

filterBinTree :: Ord a => (a -> b -> Bool) -> BinTree a b -> BinTree a b
-- filterFM f t
filterBinTree f = sorted2tree . filter (uncurry f) . tree2list

tree2list :: BinTree a b -> [(a,b)] -- inorder
tree2list NT = []
tree2list (BT z left right) = tree2list left ++ [z] ++ tree2list right
--tree2list = fmToList

-- parsing

type WParser a b = [a] -> [(b,[a])] -- old Wadler style parser

wParseResults :: WParser a b -> [a] -> [b]
wParseResults p aa = [b | (b,[]) <- p aa]

paragraphs :: String -> [String]
paragraphs = map unlines . chop . lines where
  chop [] = []
  chop ss = let (ps,rest) = break empty ss in ps : chop (dropWhile empty rest)
  empty = all isSpace

-- printing

indent :: Int -> String -> String
indent i s = replicate i ' ' ++ s

(+++), (++-), (++++), (+++++) :: String -> String -> String
a +++ b   = a ++ " "    ++ b
a ++- ""  = a 
a ++- b   = a +++ b
a ++++ b  = a ++ "\n"   ++ b
a +++++ b = a ++ "\n\n" ++ b

prUpper :: String -> String
prUpper s = s1 ++ s2' where
 (s1,s2) = span isSpace s
 s2' = case s2 of
   c:t -> toUpper c : t
   _ -> s2

prReplicate :: Int -> String -> String
prReplicate n s = concat (replicate n s)

prTList :: String -> [String] -> String
prTList t ss = case ss of
  []   -> ""
  [s]  -> s
  s:ss -> s ++ t ++ prTList t ss

prQuotedString :: String -> String
prQuotedString x = "\"" ++ restoreEscapes x ++ "\""

prParenth :: String -> String
prParenth s = if s == "" then "" else "(" ++ s ++ ")"

prCurly, prBracket :: String -> String
prCurly   s = "{" ++ s ++ "}"
prBracket s = "[" ++ s ++ "]"

prArgList, prSemicList, prCurlyList :: [String] -> String
prArgList   = prParenth . prTList "," 
prSemicList = prTList " ; "
prCurlyList = prCurly . prSemicList

restoreEscapes :: String -> String
restoreEscapes s = 
  case s of 
    []       -> []
    '"' : t  -> '\\' : '"'  : restoreEscapes t
    '\\': t  -> '\\' : '\\' : restoreEscapes t
    c   : t  -> c : restoreEscapes t

numberedParagraphs :: [[String]] -> [String]
numberedParagraphs t = case t of 
  []   -> []
  p:[] -> p
  _    -> concat [(show n ++ ".") : s | (n,s) <- zip [1..] t]

prConjList :: String -> [String] -> String
prConjList c []     = ""
prConjList c [s]    = s
prConjList c [s,t]  = s +++ c +++ t
prConjList c (s:tt) = s ++ "," +++ prConjList c tt

prIfEmpty :: String -> String -> String -> String -> String
prIfEmpty em _    _    [] = em
prIfEmpty em nem1 nem2 s  = nem1 ++ s ++ nem2

-- | Thomas Hallgren's wrap lines
wrapLines :: Int -> String -> String
wrapLines n "" = ""
wrapLines n s@(c:cs) =
      if isSpace c
      then c:wrapLines (n+1) cs
      else case lex s of
            [(w,rest)] -> if n'>=76
                          then '\n':w++wrapLines l rest
                          else w++wrapLines n' rest
               where n' = n+l
                     l = length w
            _ -> s -- give up!!

--- optWrapLines = if argFlag "wraplines" True then wrapLines 0 else id

-- LaTeX code producing functions
dollar, mbox, ital, boldf, verbat :: String -> String
dollar s = '$' : s ++ "$"
mbox s   = "\\mbox{" ++ s ++ "}"
ital s   = "{\\em" +++ s ++ "}"
boldf s  = "{\\bf" +++ s ++ "}"
verbat s = "\\verbat!" ++ s ++ "!"

mkLatexFile :: String -> String
mkLatexFile s = begindocument +++++ s +++++ enddocument

begindocument, enddocument :: String
begindocument =
 "\\documentclass[a4paper,11pt]{article}" ++++ -- M.F. 25/01-02
 "\\setlength{\\parskip}{2mm}" ++++
 "\\setlength{\\parindent}{0mm}" ++++
 "\\setlength{\\oddsidemargin}{0mm}" ++++
 ("\\setlength{\\evensidemargin}{"++"-2mm}") ++++ -- peb 27/5-04: to prevent hugs-mode 
 ("\\setlength{\\topmargin}{"++"-8mm}") ++++      -- from treating the rest as comments
 "\\setlength{\\textheight}{240mm}" ++++
 "\\setlength{\\textwidth}{158mm}" ++++
 "\\begin{document}\n"
enddocument =
 "\n\\end{document}\n"


sortByLongest :: [[a]] -> [[a]]
sortByLongest = sortBy longer where
 longer x y 
  | x' > y' = LT
  | x' < y' = GT
  | True    = EQ
  where
   x' = length x
   y' = length y

-- | 'combinations' is the same as @sequence@!!!
-- peb 30\/5-04
combinations :: [[a]] -> [[a]]
combinations t = case t of 
  []    -> [[]]
  aa:uu -> [a:u | a <- aa, u <- combinations uu]


mkTextFile :: String -> IO ()
mkTextFile name = do
  s <- readFile name
  let s' = prelude name ++ "\n\n" ++ heading name  ++ "\n" ++ object s
  writeFile (name ++ ".hs") s'
 where
   prelude name = "module " ++ name ++ " where" 
   heading name = "txt" ++ name ++ " ="
   object s = mk s ++ " \"\""
   mk s = unlines ["  \"" ++ escs line ++ "\" ++ \"\\n\" ++" | line <- lines s]
   escs s = case s of
     c:cs | elem c "\"\\" -> '\\' : c : escs cs
     c:cs -> c : escs cs
     _ -> s

initFilePath :: FilePath -> FilePath
initFilePath f = reverse (dropWhile (/='/') (reverse f))

-- | topological sorting with test of cyclicity
topoTest :: Eq a => [(a,[a])] -> Either [a] [[a]]
topoTest g = if length g' == length g then Left g' else Right (cyclesIn g ++[[]]) 
  where
    g' = topoSort g
  
cyclesIn :: Eq a => [(a,[a])] -> [[a]]
cyclesIn deps = nubb $ clean $ filt $ iterFix findDep immediate where
  immediate = [[y,x] | (x,xs) <- deps, y <- xs] 
  findDep chains = [y:x:chain | 
                      x:chain <- chains, (x',xs) <- deps, x' == x, y <- xs, 
                      notElem y (init chain)]

  clean = map remdup
  nubb = nubBy (\x y -> y == reverse x) 
  filt = filter (\xs -> last xs == head xs)
  remdup (x:xs) = x : remdup xs' where xs' = dropWhile (==x) xs
  remdup [] = []


-- | topological sorting 
topoSort :: Eq a => [(a,[a])] -> [a]
topoSort g = reverse $ tsort 0 [ffs | ffs@(f,_) <- g, inDeg f == 0] [] where
  tsort _ []     r = r
  tsort k (ffs@(f,fs) : cs) r
    | elem f r  = tsort k cs r
    | k > lx    = r  
    | otherwise = tsort (k+1) cs (f : tsort (k+1) (info fs) r)
  info hs = [(f,fs) | (f,fs) <- g, elem f hs]
  inDeg f = length [t | (h,hs) <- g, t <- hs, t == f]
  lx = length g

-- | the generic fix point iterator
iterFix :: Eq a => ([a] -> [a]) -> [a] -> [a]
iterFix more start = iter start start 
  where
    iter old new = if (null new')
                      then old
                      else iter (new' ++ old) new'
      where
        new' = filter (`notElem` old) (more new)

-- association lists

updateAssoc :: Eq a => (a,b) -> [(a,b)] -> [(a,b)]
updateAssoc ab@(a,b) as = case as of
  (x,y): xs | x == a -> (a,b):xs
  xy   : xs          -> xy : updateAssoc ab xs
  []                 -> [ab]

removeAssoc :: Eq a => a -> [(a,b)] -> [(a,b)]
removeAssoc a = filter ((/=a) . fst)

-- | chop into separator-separated parts
chunks :: Eq a => a -> [a] -> [[a]]
chunks sep ws = case span (/= sep) ws of
  (a,_:b) -> a : bs where bs = chunks sep b
  (a, []) -> if null a then [] else [a]

readIntArg :: String -> Int
readIntArg n = if (not (null n) && all isDigit n) then read n else 0


-- state monad with error; from Agda 6/11/2001

newtype STM s a = STM (s -> Err (a,s)) 

appSTM :: STM s a -> s -> Err (a,s)
appSTM (STM f) s = f s

stm :: (s -> Err (a,s)) -> STM s a
stm = STM

stmr :: (s -> (a,s)) -> STM s a
stmr f = stm (\s -> return (f s))

instance  Monad (STM s) where
  return a    = STM (\s -> return (a,s))
  STM c >>= f = STM (\s -> do 
                        (x,s') <- c s
                        let STM f' = f x
                        f' s')

readSTM :: STM s s
readSTM = stmr (\s -> (s,s))

updateSTM :: (s -> s) -> STM s () 
updateSTM f = stmr (\s -> ((),f s))

writeSTM :: s -> STM s ()
writeSTM s = stmr (const ((),s))

done :: Monad m => m ()
done = return ()

class Monad m => ErrorMonad m where
  raise   :: String -> m a
  handle  :: m a -> (String -> m a) -> m a
  handle_ :: m a -> m a -> m a
  handle_ a b =  a `handle` (\_ -> b)

instance ErrorMonad Err where
  raise  = Bad
  handle a@(Ok _) _ = a
  handle (Bad i) f  = f i

instance ErrorMonad (STM s) where
  raise msg = STM (\s -> raise msg)
  handle (STM f) g = STM (\s -> (f s) 
                                `handle` (\e -> let STM g' = (g e) in
                                                    g' s))

-- error recovery with multiple reporting AR 30/5/2008
mapsErr :: (a -> Err b) -> [a] -> Err [b]

mapsErr f = seqs . map f where
  seqs es = case es of
    Ok v : ms -> case seqs ms of
      Ok vs -> return (v : vs)
      b     -> b
    Bad s : ms -> case seqs ms of
      Ok vs  -> Bad s
      Bad ss -> Bad (s +++++ ss)
    [] -> return []

mapsErrTree :: (Ord a) => ((a,b) -> Err (a,c)) -> BinTree a b -> Err (BinTree a c)
mapsErrTree f t =  mapsErr f (tree2list t) >>= return . sorted2tree


-- | if the first check fails try another one
checkAgain :: ErrorMonad m => m a -> m a -> m a
checkAgain c1 c2 = handle_ c1 c2

checks :: ErrorMonad m => [m a] -> m a
checks [] = raise "no chance to pass"
checks cs = foldr1 checkAgain cs

allChecks :: ErrorMonad m => [m a] -> m [a]
allChecks ms = case ms of
  (m: ms) -> let rs = allChecks ms in handle_ (liftM2 (:) m rs) rs
  _ -> return []

doUntil :: ErrorMonad m => (a -> Bool) -> [m a] -> m a
doUntil cond ms = case ms of
  a:as -> do
    v <- a
    if cond v then return v else doUntil cond as
  _ -> raise "no result"

-- subsequences sorted from longest to shortest ; their number is 2^n
subSequences :: [a] -> [[a]]
subSequences = sortBy (\x y -> compare (length y) (length x)) . subs where
  subs xs = case xs of
    [] -> [[]]
    x:xs -> let xss = subs xs in [x:y | y <- xss] ++ xss
