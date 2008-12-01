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
		   Err(..), err, maybeErr, testErr, errVal, errIn, 
		   lookupErr,
		   mapPairListM, mapPairsM, pairM,
		   (!?), singleton, mapsErr, mapsErrTree,
		   
		   -- ** checking
		   checkUnique,

		   -- * a three-valued maybe type to express indirections
		   Perhaps(..), yes, may, nope,
		   mapP,
		   unifPerhaps, updatePerhaps, updatePerhapsHard,

		   -- * binary search trees; now with FiniteMap
		   BinTree, emptyBinTree, isInBinTree, justLookupTree,
		   lookupTree, lookupTreeMany, lookupTreeManyAll, updateTree,
		   buildTree, filterBinTree,
		   sorted2tree, mapTree, mapMTree, tree2list,
 

		   -- * printing
		   indent, (+++), (++-), (++++), (+++++),
		   prUpper, prReplicate, prTList, prQuotedString, prParenth, prCurly, 
		   prBracket, prArgList, prSemicList, prCurlyList, restoreEscapes,
		   numberedParagraphs, prConjList, prIfEmpty, wrapLines,

		   -- * extra
		   combinations,

		   -- * topological sorting with test of cyclicity
		   topoTest, 

		   -- * the generic fix point iterator
		   iterFix,

		   -- * chop into separator-separated parts
		   chunks, readIntArg, 

		   -- * state monad with error; from Agda 6\/11\/2001
		   STM(..), appSTM, stm, stmr, readSTM, updateSTM, writeSTM, done,

		   -- * error monad class
		   ErrorMonad(..), checkAgain, checks, allChecks, doUntil
                
		  ) where

import Data.Char (isSpace, toUpper, isSpace, isDigit)
import Data.List (nub, sortBy, sort, deleteBy, nubBy)
import qualified Data.Map as Map
import Data.Map (Map)
import Control.Monad (liftM,liftM2, MonadPlus, mzero, mplus)

import GF.Data.ErrM
import GF.Data.Relation

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

lookupErr :: (Eq a,Show a) => a -> [(a,b)] -> Err b
lookupErr a abs = maybeErr ("Unknown" +++ show a) (lookup a abs)

mapPairListM :: Monad m => ((a,b) -> m c) -> [(a,b)] -> m [(a,c)]
mapPairListM f xys = mapM (\ p@(x,_) -> liftM ((,) x) (f p)) xys

mapPairsM :: Monad m => (b -> m c) -> [(a,b)] -> m [(a,c)]
mapPairsM f xys = mapM (\ (x,y) -> liftM ((,) x) (f y)) xys

pairM :: Monad a => (b -> a c) -> (b,b) -> a (c,c)
pairM op (t1,t2) = liftM2 (,) (op t1) (op t2)

-- @!!@ with the error monad
(!?) :: [a] -> Int -> Err a
xs !? i = foldr (const . return) (Bad "too few elements in list") $ drop i xs

singleton :: a -> [a]
singleton = (:[])

-- checking

checkUnique :: (Show a, Eq a) => [a] -> [String]
checkUnique ss = ["overloaded" +++ show s | s <- nub overloads] where
  overloads = filter overloaded ss
  overloaded s = length (filter (==s) ss) > 1

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

type BinTree a b = Map a b

emptyBinTree :: BinTree a b
emptyBinTree = Map.empty

isInBinTree :: (Ord a) => a -> BinTree a b -> Bool
isInBinTree = Map.member

justLookupTree :: (Monad m,Ord a) => a -> BinTree a b -> m b
justLookupTree = lookupTree (const [])

lookupTree :: (Monad m,Ord a) => (a -> String) -> a -> BinTree a b -> m b
lookupTree pr x tree = case Map.lookup x tree of
  Just y -> return y
  _ -> fail ("no occurrence of element" +++ pr x)

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

updateTree :: (Ord a) => (a,b) -> BinTree a b -> BinTree a b
updateTree (a,b) = Map.insert a b

buildTree :: (Ord a) => [(a,b)] -> BinTree a b
buildTree = Map.fromList

sorted2tree :: Ord a => [(a,b)] -> BinTree a b
sorted2tree = Map.fromAscList

mapTree :: ((a,b) -> c) -> BinTree a b -> BinTree a c
mapTree f = Map.mapWithKey (\k v -> f (k,v))

mapMTree :: (Ord a,Monad m) => ((a,b) -> m c) -> BinTree a b -> m (BinTree a c)
mapMTree f t = liftM Map.fromList $ sequence [liftM ((,) k) (f (k,x)) | (k,x) <- Map.toList t]

filterBinTree :: Ord a => (a -> b -> Bool) -> BinTree a b -> BinTree a b
filterBinTree = Map.filterWithKey

tree2list :: BinTree a b -> [(a,b)] -- inorder
tree2list = Map.toList

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

-- | 'combinations' is the same as @sequence@!!!
-- peb 30\/5-04
combinations :: [[a]] -> [[a]]
combinations t = case t of 
  []    -> [[]]
  aa:uu -> [a:u | a <- aa, u <- combinations uu]

-- | topological sorting with test of cyclicity
topoTest :: Ord a => [(a,[a])] -> Either [a] [[a]]
topoTest = topologicalSort . mkRel'

-- | the generic fix point iterator
iterFix :: Eq a => ([a] -> [a]) -> [a] -> [a]
iterFix more start = iter start start 
  where
    iter old new = if (null new')
                      then old
                      else iter (new' ++ old) new'
      where
        new' = filter (`notElem` old) (more new)

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
