module Operations where

import Char  (isSpace, toUpper, isSpace, isDigit)
import List  (nub, sortBy, sort, deleteBy, nubBy)
import Monad (liftM2)

infixr 5 +++
infixr 5 ++-
infixr 5 ++++
infixr 5 +++++
infixl 9 !?

-- some auxiliary GF operations. AR 19/6/1998 -- 6/2/2001
-- Copyright (c) Aarne Ranta 1998-2000, under GNU General Public License (see GPL)

ifNull :: b -> ([a] -> b) -> [a] -> b
ifNull b f xs = if null xs then b else f xs
  
-- the Error monad

data Err a = Ok a | Bad String   -- like Maybe type with error msgs
  deriving (Read, Show, Eq)

instance Monad Err where
  return      = Ok
  Ok a  >>= f = f a
  Bad s >>= f = Bad s

instance Functor Err where   -- added 2/10/2003 by PEB
  fmap f (Ok a) = Ok (f a)
  fmap f (Bad s) = Bad s

-- analogue of maybe
err :: (String -> b) -> (a -> b) -> Err a -> b 
err d f e = case e of
  Ok a -> f a
  Bad s -> d s

-- add msg s to Maybe failures
maybeErr :: String -> Maybe a -> Err a
maybeErr s = maybe (Bad s) Ok

testErr :: Bool -> String -> Err ()
testErr cond msg = if cond then return () else Bad msg

errVal :: a -> Err a -> a
errVal a = err (const a) id

errIn :: String -> Err a -> Err a
errIn msg = err (\s -> Bad (s ++++ "OCCURRED IN" ++++ msg)) return

-- used for extra error reports when developing GF
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
mapPairListM f xys =
  do yy' <- mapM f xys
     return (zip (map fst xys) yy')

mapPairsM :: Monad m => (b -> m c) -> [(a,b)] -> m [(a,c)]
mapPairsM f xys =
  do let (xx,yy) = unzip xys
     yy' <- mapM f yy
     return (zip xx yy')

pairM :: Monad a => (b -> a c) -> (b,b) -> a (c,c)
pairM op (t1,t2) = liftM2 (,) (op t1) (op t2)

-- like mapM, but continue instead of halting with Err
mapErr :: (a -> Err b) -> [a] -> Err ([b], String) 
mapErr f xs = Ok (ys, unlines ss) 
  where
    (ys,ss) = ([y | Ok y <- fxs], [s | Bad s <- fxs])
    fxs = map f xs

-- alternative variant, peb 9/6-04
mapErrN :: Int -> (a -> Err b) -> [a] -> Err ([b], String)
mapErrN maxN f xs = Ok (ys, unlines (errHdr : ss2)) 
  where
    (ys, ss) = ([y | Ok y <- fxs], [s | Bad s <- fxs])
    errHdr = show nss ++ " errors occured" ++ 
	     if nss > maxN then ", showing the first " ++ show maxN else ""
    ss2 = map ("* "++) $ take maxN ss 
    nss = length ss
    fxs = map f xs

-- !! with the error monad
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

-- a three-valued maybe type to express indirections

data Perhaps a b = Yes a | May b | Nope deriving (Show,Read,Eq,Ord)

yes = Yes
may = May
nope = Nope

mapP :: (a -> c) -> Perhaps a b -> Perhaps c b
mapP f p = case p of
  Yes a -> Yes (f a)
  May b -> May b
  Nope  -> Nope

-- this is what happens when matching two values in the same module
unifPerhaps :: (Eq a, Eq b) => Perhaps a b -> Perhaps a b -> Err (Perhaps a b)
unifPerhaps p1 p2 = case (p1,p2) of
  (Nope, _)  -> return p2
  (_, Nope)  -> return p1
  _ -> if p1==p2 then return p1 else Bad "update conflict"

-- this is what happens when updating a module extension
updatePerhaps :: (Eq a,Eq b) => b -> Perhaps a b -> Perhaps a b -> Err (Perhaps a b)
updatePerhaps old p1 p2 = case (p1,p2) of
  (Yes a,    Nope)  -> return $ may old
  (May older,Nope)  -> return $ may older
  (_, May a)        -> Bad "strange indirection"
  _ -> unifPerhaps p1 p2

-- here the value is copied instead of referred to; used for oper types
updatePerhapsHard :: (Eq a, Eq b) => b -> 
                     Perhaps a b -> Perhaps a b -> Err (Perhaps a b)
updatePerhapsHard old p1 p2 = case (p1,p2) of
  (Yes a,    Nope)  -> return $ yes a
  (May older,Nope)  -> return $ may older
  (_, May a)        -> Bad "strange indirection"
  _ -> unifPerhaps p1 p2

-- binary search trees

data BinTree a = NT | BT a !(BinTree a) !(BinTree a) deriving (Show,Read)

isInBinTree :: (Ord a) => a -> BinTree a -> Bool
isInBinTree x tree = case tree of
 NT -> False
 BT a left right 
   | x < a  -> isInBinTree x left
   | x > a  -> isInBinTree x right
   | x == a -> True

-- quick method to see if two trees have common elements
-- the complexity is O(log |old|, |new|) so the heuristic is that new is smaller

commonsInTree :: (Ord a) => BinTree (a,b) -> BinTree (a,b) -> [(a,(b,b))]
commonsInTree old new = foldr inOld [] new' where
  new' = tree2list new
  inOld (x,v) xs = case justLookupTree x old of
    Ok v' -> (x,(v',v)) : xs
    _ -> xs

justLookupTree :: (Ord a) => a -> BinTree (a,b) -> Err b
justLookupTree = lookupTree (const [])

lookupTree :: (Ord a) => (a -> String) -> a -> BinTree (a,b) -> Err b
lookupTree pr x tree = case tree of
 NT -> Bad ("no occurrence of element" +++ pr x)
 BT (a,b) left right 
   | x < a  -> lookupTree pr x left
   | x > a  -> lookupTree pr x right
   | x == a -> return b

lookupTreeEq :: (Ord a) => 
     (a -> String) -> (a -> a -> Bool) -> a -> BinTree (a,b) -> Err b
lookupTreeEq pr eq x tree = case tree of
 NT -> Bad ("no occurrence of element equal to" +++ pr x)
 BT (a,b) left right 
   | eq x a -> return b     -- a weaker equality relation than ==
   | x < a  -> lookupTreeEq pr eq x left
   | x > a  -> lookupTreeEq pr eq x right

lookupTreeMany :: Ord a => (a -> String) -> [BinTree (a,b)] -> a -> Err b
lookupTreeMany pr (t:ts) x = case lookupTree pr x t of
  Ok v -> return v
  _ -> lookupTreeMany pr ts x
lookupTreeMany pr [] x = Bad $ "failed to find" +++ pr x

-- destructive update

updateTree :: (Ord a) => (a,b) -> BinTree (a,b) -> BinTree (a,b)
updateTree = updateTreeGen True

-- destructive or not

updateTreeGen :: (Ord a) => Bool -> (a,b) -> BinTree (a,b) -> BinTree (a,b)
updateTreeGen destr z@(x,y) tree = case tree of
 NT -> BT z NT NT
 BT c@(a,b) left right 
   | x < a  -> let left' = updateTree z left in   BT c left' right 
   | x > a  -> let right' = updateTree z right in BT c left right' 
   | otherwise -> if destr
                    then BT z left right -- removing the old value of a
                    else tree            -- retaining the old value if one exists

updateTreeEq :: 
  (Ord a) => (a -> a -> Bool) -> (a,b) -> BinTree (a,b) -> BinTree (a,b)
updateTreeEq eq z@(x,y) tree = case tree of
 NT -> BT z NT NT
 BT c@(a,b) left right
   | eq x a -> BT (a,y) left right -- removing the old value of a 
   | x < a  -> let left' = updateTree z left in   BT c left' right 
   | x > a  -> let right' = updateTree z right in BT c left right' 

updatesTree :: (Ord a) => [(a,b)] -> BinTree (a,b) -> BinTree (a,b)
updatesTree (z:zs) tr = updateTree z t where t = updatesTree zs tr
updatesTree [] tr = tr

updatesTreeNondestr :: (Ord a) => [(a,b)] -> BinTree (a,b) -> BinTree (a,b)
updatesTreeNondestr xs tr = case xs of
  (z:zs) -> updateTreeGen False z t where t = updatesTreeNondestr zs tr
  _ -> tr

buildTree :: (Ord a) => [(a,b)] -> BinTree (a,b)
buildTree = sorted2tree . sortBy fs where
  fs (x,_) (y,_) 
    | x < y = LT
    | x > y = GT
    | True  = EQ 
-- buildTree zz = updatesTree zz NT

sorted2tree :: [(a,b)] -> BinTree (a,b)
sorted2tree [] = NT
sorted2tree xs = BT x (sorted2tree t1) (sorted2tree t2) where
  (t1,(x:t2)) = splitAt (length xs `div` 2) xs

mapTree :: (a -> b) -> BinTree a -> BinTree b
mapTree f NT = NT
mapTree f (BT a left right) = BT (f a) (mapTree f left) (mapTree f right)

mapMTree :: Monad m => (a -> m b) -> BinTree a -> m (BinTree b)
mapMTree f NT = return NT
mapMTree f (BT a left right) = do
 a'     <- f a
 left'  <- mapMTree f left 
 right' <- mapMTree f right
 return $ BT a' left' right'

tree2list :: BinTree a -> [a] -- inorder
tree2list NT = []
tree2list (BT z left right) = tree2list left ++ [z] ++ tree2list right

depthTree :: BinTree a -> Int
depthTree NT = 0
depthTree (BT _ left right) = 1 + max (depthTree left) (depthTree right)

mergeTrees :: Ord a => BinTree (a,b) -> BinTree (a,b) -> BinTree (a,[b])
mergeTrees old new = foldr upd new' (tree2list old) where
  upd xy@(x,y) tree = case tree of
    NT -> BT (x,[y]) NT NT
    BT (a,bs) left right 
      | x < a  -> let left'  = upd xy left  in BT (a,bs) left' right 
      | x > a  -> let right' = upd xy right in BT (a,bs) left  right' 
      | otherwise -> BT (a, y:bs) left right -- adding the new value
  new' = mapTree (\ (i,d) -> (i,[d])) new


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

prReplicate n s = concat (replicate n s)

prTList t ss = case ss of
  []   -> ""
  [s]  -> s
  s:ss -> s ++ t ++ prTList t ss

prQuotedString x = "\"" ++ restoreEscapes x ++ "\""

prParenth s = if s == "" then "" else "(" ++ s ++ ")"

prCurly   s = "{" ++ s ++ "}"
prBracket s = "[" ++ s ++ "]"

prArgList xx = prParenth (prTList "," xx)

prSemicList = prTList " ; "

prCurlyList = prCurly . prSemicList

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

-- Thomas Hallgren's wrap lines
--- optWrapLines = if argFlag "wraplines" True then wrapLines 0 else id
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

-- LaTeX code producing functions

dollar s = '$' : s ++ "$"
mbox s   = "\\mbox{" ++ s ++ "}"
ital s   = "{\\em" +++ s ++ "}"
boldf s  = "{\\bf" +++ s ++ "}"
verbat s = "\\verbat!" ++ s ++ "!"

mkLatexFile s = begindocument +++++ s +++++ enddocument

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

-- "combinations" is the same as "sequence"!!!
-- peb 30/5-04
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

-- topological sorting with test of cyclicity

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

-- the generic fix point iterator

iterFix :: Eq a => ([a] -> [a]) -> [a] -> [a]
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

-- chop into separator-separated parts

chunks :: String -> [String] -> [[String]]
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
-- if the first check fails try another one
checkAgain :: ErrorMonad m => m a -> m a -> m a
checkAgain c1 c2 = handle_ c1 c2

checks :: ErrorMonad m => [m a] -> m a
checks [] = raise "no chance to pass"
checks cs = foldr1 checkAgain cs

allChecks :: ErrorMonad m => [m a] -> m [a]
allChecks ms = case ms of
  (m: ms) -> let rs = allChecks ms in handle_ (liftM2 (:) m rs) rs
  _ -> return []

