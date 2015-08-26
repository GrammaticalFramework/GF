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

module GF.Data.Operations (
		   -- ** The Error monad
		   Err(..), err, maybeErr, testErr, fromErr, errIn, 
		   lookupErr,

		   -- ** Error monad class
		   ErrorMonad(..), checks, --doUntil, allChecks, checkAgain,
                   liftErr,
		   
		   -- ** Checking
		   checkUnique, unifyMaybeBy, unifyMaybe,

                   -- ** Monadic operations on lists and pairs
		   mapPairListM, mapPairsM, pairM,

		   -- ** Binary search trees; now with FiniteMap
		   BinTree, emptyBinTree, isInBinTree, --justLookupTree,
		   lookupTree, --lookupTreeMany,
                   lookupTreeManyAll, updateTree,
		   buildTree, filterBinTree,
                   mapTree, --mapMTree,
                   tree2list,
 
		   -- ** Printing
		   indent, (+++), (++-), (++++), (+++-), (+++++),
		   prUpper, prReplicate, prTList, prQuotedString, prParenth, prCurly, 
		   prBracket, prArgList, prSemicList, prCurlyList, restoreEscapes,
		   numberedParagraphs, prConjList, prIfEmpty, wrapLines,

		   -- ** Topological sorting
		   topoTest, topoTest2,

		   -- ** Misc
		   ifNull,
		   combinations, done, readIntArg, --singleton,
		   iterFix,  chunks,
{-
		   -- ** State monad with error; from Agda 6\/11\/2001
		   STM(..), appSTM, stm, stmr, readSTM, updateSTM, writeSTM,
-}
                
		  ) where

import Data.Char (isSpace, toUpper, isSpace, isDigit)
import Data.List (nub, partition, (\\))
import qualified Data.Map as Map
import Data.Map (Map)
--import Control.Applicative(Applicative(..))
import Control.Monad (liftM,liftM2) --,ap

import GF.Data.ErrM
import GF.Data.Relation

infixr 5 +++
infixr 5 ++-
infixr 5 ++++
infixr 5 +++++

ifNull :: b -> ([a] -> b) -> [a] -> b
ifNull b f xs = if null xs then b else f xs

-- the Error monad

-- | Add msg s to 'Maybe' failures
maybeErr :: ErrorMonad m => String -> Maybe a -> m a
maybeErr s = maybe (raise s) return

testErr :: ErrorMonad m => Bool -> String -> m ()
testErr cond msg = if cond then done else raise msg

errIn :: ErrorMonad m => String -> m a -> m a
errIn msg m = handle m (\s -> raise (s ++++ "OCCURRED IN" ++++ msg))

lookupErr :: (ErrorMonad m,Eq a,Show a) => a -> [(a,b)] -> m b
lookupErr a abs = maybeErr ("Unknown" +++ show a) (lookup a abs)

mapPairListM :: Monad m => ((a,b) -> m c) -> [(a,b)] -> m [(a,c)]
mapPairListM f xys = mapM (\ p@(x,_) -> liftM ((,) x) (f p)) xys

mapPairsM :: Monad m => (b -> m c) -> [(a,b)] -> m [(a,c)]
mapPairsM f xys = mapM (\ (x,y) -> liftM ((,) x) (f y)) xys

pairM :: Monad m => (b -> m c) -> (b,b) -> m (c,c)
pairM op (t1,t2) = liftM2 (,) (op t1) (op t2)

-- checking

checkUnique :: (Show a, Eq a) => [a] -> [String]
checkUnique ss = ["overloaded" +++ show s | s <- nub overloads] where
  overloads = filter overloaded ss
  overloaded s = length (filter (==s) ss) > 1

-- | this is what happens when matching two values in the same module
unifyMaybe :: (Eq a, Monad m) => Maybe a -> Maybe a -> m (Maybe a)
unifyMaybe = unifyMaybeBy id

unifyMaybeBy :: (Eq b, Monad m) => (a->b) -> Maybe a -> Maybe a -> m (Maybe a)
unifyMaybeBy f (Just p1) (Just p2)
  | f p1==f p2                     = return (Just p1)
  | otherwise                      = fail ""
unifyMaybeBy _ Nothing   mp2       = return mp2
unifyMaybeBy _ mp1       _         = return mp1

-- binary search trees

type BinTree a b = Map a b

emptyBinTree :: BinTree a b
emptyBinTree = Map.empty

isInBinTree :: (Ord a) => a -> BinTree a b -> Bool
isInBinTree = Map.member
{-
justLookupTree :: (ErrorMonad m,Ord a) => a -> BinTree a b -> m b
justLookupTree = lookupTree (const [])
-}
lookupTree :: (ErrorMonad m,Ord a) => (a -> String) -> a -> BinTree a b -> m b
lookupTree pr x = maybeErr no . Map.lookup x
  where no = "no occurrence of element" +++ pr x

lookupTreeManyAll :: Ord a => (a -> String) -> [BinTree a b] -> a -> [b]
lookupTreeManyAll pr (t:ts) x = case lookupTree pr x t of
  Ok v -> v : lookupTreeManyAll pr ts x
  _ -> lookupTreeManyAll pr ts x
lookupTreeManyAll pr [] x = []

updateTree :: (Ord a) => (a,b) -> BinTree a b -> BinTree a b
updateTree (a,b) = Map.insert a b

buildTree :: (Ord a) => [(a,b)] -> BinTree a b
buildTree = Map.fromList

mapTree :: ((a,b) -> c) -> BinTree a b -> BinTree a c
mapTree f = Map.mapWithKey (\k v -> f (k,v))

filterBinTree :: Ord a => (a -> b -> Bool) -> BinTree a b -> BinTree a b
filterBinTree = Map.filterWithKey

tree2list :: BinTree a b -> [(a,b)] -- inorder
tree2list = Map.toList

-- printing

indent :: Int -> String -> String
indent i s = replicate i ' ' ++ s

(+++), (++-), (++++), (+++-), (+++++) :: String -> String -> String
a +++ b   = a ++ " "    ++ b

a ++- ""  = a 
a ++- b   = a +++ b

a ++++ b  = a ++ "\n"   ++ b

a +++- "" = a
a +++- b  = a ++++ b

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

-- | 'combinations' is the same as 'sequence'!!!
-- peb 30\/5-04
combinations :: [[a]] -> [[a]]
combinations t = case t of 
  []    -> [[]]
  aa:uu -> [a:u | a <- aa, u <- combinations uu]

{-
-- | 'singleton' is the same as 'return'!!!
singleton :: a -> [a]
singleton = (:[])
-}

-- | Topological sorting with test of cyclicity
topoTest :: Ord a => [(a,[a])] -> Either [a] [[a]]
topoTest = topologicalSort . mkRel'

-- | Topological sorting with test of cyclicity, new version /TH 2012-06-26
topoTest2 :: Ord a => [(a,[a])] -> Either [[a]] [[a]]
topoTest2 g0 = maybe (Right cycles) Left (tsort g)
  where
    g = g0++[(n,[])|n<-nub (concatMap snd g0)\\map fst g0]

    cycles = findCycles (mkRel' g)

    tsort nes =
      case partition (null.snd) nes of
        ([],[]) -> Just []
        ([],_) -> Nothing
        (ns,rest) -> (leaves:) `fmap` tsort [(n,es \\ leaves) | (n,es)<-rest]
	  where leaves = map fst ns


-- | Fix point iterator (for computing e.g. transitive closures or reachability)
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

{-
-- state monad with error; from Agda 6/11/2001

newtype STM s a = STM (s -> Err (a,s)) 

appSTM :: STM s a -> s -> Err (a,s)
appSTM (STM f) s = f s

stm :: (s -> Err (a,s)) -> STM s a
stm = STM

stmr :: (s -> (a,s)) -> STM s a
stmr f = stm (\s -> return (f s))

instance Functor (STM s) where fmap = liftM

instance Applicative (STM s) where
  pure = return
  (<*>) = ap

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
-}
-- | @return ()@
done :: Monad m => m ()
done = return ()

class (Functor m,Monad m) => ErrorMonad m where
  raise   :: String -> m a
  handle  :: m a -> (String -> m a) -> m a
  handle_ :: m a -> m a -> m a
  handle_ a b =  a `handle` (\_ -> b)

instance ErrorMonad Err where
  raise  = Bad
  handle a@(Ok _) _ = a
  handle (Bad i) f  = f i

liftErr e = err raise return e
{-
instance ErrorMonad (STM s) where
  raise msg = STM (\s -> raise msg)
  handle (STM f) g = STM (\s -> (f s) 
                                `handle` (\e -> let STM g' = (g e) in
                                                    g' s))

-}

-- | if the first check fails try another one
checkAgain :: ErrorMonad m => m a -> m a -> m a
checkAgain c1 c2 = handle_ c1 c2

checks :: ErrorMonad m => [m a] -> m a
checks [] = raise "no chance to pass"
checks cs = foldr1 checkAgain cs
{-
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
-}