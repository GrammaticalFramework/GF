module Zipper where

import Operations

-- Gérard Huet's zipper (JFP 7 (1997)). AR 10/8/2001

newtype Tr a = Tr (a,[Tr a]) deriving (Show,Eq)
    
data Path a = 
    Top 
  | Node ([Tr a], (Path a, a), [Tr a]) 
   deriving Show

leaf a = Tr (a,[])

newtype Loc a = Loc (Tr a, Path a)     deriving Show

goLeft, goRight, goUp, goDown :: Loc a -> Err (Loc a)
goLeft (Loc (t,p)) = case p of
  Top -> Bad "left of top"
  Node (l:left, upv, right) -> return $ Loc (l, Node (left,upv,t:right))
  Node _ -> Bad "left of first"
goRight (Loc (t,p)) = case p of
  Top -> Bad "right of top"
  Node (left, upv, r:right) -> return $ Loc (r, Node (t:left,upv,right))
  Node _ -> Bad "right of first"
goUp (Loc (t,p)) = case p of
  Top -> Bad "up of top"
  Node (left, (up,v), right) -> 
    return $ Loc (Tr (v, reverse left ++ (t:right)), up)
goDown (Loc (t,p)) = case t of
  Tr (v,(t1:trees)) -> return $ Loc (t1,Node ([],(p,v),trees))
  _ -> Bad "down of empty"

changeLoc :: Loc a -> Tr a -> Err (Loc a)
changeLoc (Loc (_,p)) t = return $ Loc (t,p)

changeNode :: (a -> a) -> Loc a -> Loc a
changeNode f (Loc (Tr (n,ts),p)) = Loc (Tr (f n, ts),p)

forgetNode :: Loc a -> Err (Loc a)
forgetNode (Loc (Tr (n,[t]),p)) = return $ Loc (t,p)
forgetNode _ = Bad $ "not a one-branch tree"

-- added sequential representation

-- a successor function
goAhead :: Loc a -> Err (Loc a) 
goAhead s@(Loc (t,p)) = case (t,p) of
  (Tr (_,_:_),Node (_,_,_:_)) -> goDown s
  (Tr (_,[]), _)              -> upsRight s
  (_,         _)              -> goDown s
 where
   upsRight t = case goRight t of
     Ok t' -> return t'
     Bad _ -> goUp t >>= upsRight

-- a predecessor function
goBack :: Loc a -> Err (Loc a) 
goBack s@(Loc (t,p)) = case goLeft s of
  Ok s' -> downRight s'
  _     -> goUp s
 where
   downRight s = case goDown s of
     Ok s' -> case goRight s' of
       Ok s'' -> downRight s''
       _ -> downRight s'       
     _     -> return s

-- n-ary versions

goAheadN :: Int ->  Loc a -> Err (Loc a)
goAheadN i st
  | i < 1     = return st
  | otherwise = goAhead st >>= goAheadN (i-1)

goBackN :: Int ->  Loc a -> Err (Loc a)
goBackN i st
  | i < 1     = return st
  | otherwise = goBack st >>= goBackN (i-1)

-- added mappings between locations and trees

loc2tree (Loc (t,p)) = case p of
  Top -> t
  Node (left,(p',v),right) -> 
    loc2tree (Loc (Tr (v, reverse left ++ (t : right)),p'))

loc2treeMarked :: Loc a -> Tr (a, Bool)
loc2treeMarked (Loc (Tr (a,ts),p)) = 
  loc2tree (Loc (Tr (mark a, map (mapTr nomark) ts), mapPath nomark p)) 
 where 
   (mark, nomark) = (\a -> (a,True), \a -> (a, False))

tree2loc t = Loc (t,Top)

goRoot = tree2loc . loc2tree

goLast :: Loc a -> Err (Loc a)
goLast = rep goAhead where
  rep f s = err (const (return s)) (rep f) (f s)

goPosition :: [Int] -> Loc a -> Err (Loc a)
goPosition p = go p . goRoot where
  go []     s = return s
  go (p:ps) s = goDown s >>= apply p goRight >>= go ps

apply :: Monad m => Int -> (a -> m a) -> a -> m a
apply n f a = case n of
  0 -> return a
  _ -> f a >>= apply (n-1) f

-- added some utilities

traverseCollect :: Path a -> [a]
traverseCollect p = reverse $ case p of
  Top -> []
  Node (_, (p',v), _) -> v : traverseCollect p'

scanTree :: Tr a -> [a]
scanTree (Tr (a,ts)) = a : concatMap scanTree ts

mapTr :: (a -> b) -> Tr a -> Tr b
mapTr f (Tr (x,ts)) = Tr (f x, map (mapTr f) ts)

mapTrM :: Monad m => (a -> m b) -> Tr a -> m (Tr b)
mapTrM f (Tr (x,ts)) = do
  fx  <- f x
  fts <- mapM (mapTrM f) ts
  return $ Tr (fx,fts)

mapPath :: (a -> b) -> Path a -> Path b
mapPath f p = case p of
  Node (ts1, (p,v), ts2) -> 
    Node (map (mapTr f) ts1, (mapPath f p, f v), map (mapTr f) ts2)
  Top -> Top

mapPathM :: Monad m => (a -> m b) -> Path a -> m (Path b)
mapPathM f p = case p of
  Node (ts1, (p,v), ts2) -> do
    ts1' <- mapM (mapTrM f) ts1
    p'   <- mapPathM f p
    v'   <- f v 
    ts2' <- mapM (mapTrM f) ts2
    return $ Node (ts1', (p',v'), ts2')
  Top -> return Top

mapLoc :: (a -> b) -> Loc a -> Loc b
mapLoc f (Loc (t,p)) = Loc (mapTr f t, mapPath f p)

mapLocM :: Monad m => (a -> m b) -> Loc a -> m (Loc b)
mapLocM f (Loc (t,p)) = do
  t' <- mapTrM f t
  p' <- mapPathM f p
  return $ (Loc (t',p'))

foldTr :: (a -> [b] -> b) -> Tr a -> b
foldTr f (Tr (x,ts)) = f x (map (foldTr f) ts)

foldTrM :: Monad m => (a -> [b] -> m b) -> Tr a -> m b
foldTrM f (Tr (x,ts)) = do
  fts <- mapM (foldTrM f) ts
  f x fts

mapSubtrees :: (Tr a -> Tr a) -> Tr a -> Tr a
mapSubtrees f t = let Tr (x,ts) = f t in Tr (x, map (mapSubtrees f) ts)

mapSubtreesM :: Monad m => (Tr a -> m (Tr a)) -> Tr a -> m (Tr a)
mapSubtreesM f t = do
  Tr (x,ts) <- f t
  ts' <- mapM (mapSubtreesM f) ts
  return $ Tr (x, ts')

-- change the root without moving the pointer
changeRoot :: (a -> a) -> Loc a -> Loc a
changeRoot f loc = case loc of
  Loc (Tr (a,ts),Top) -> Loc (Tr (f a,ts),Top)
  Loc (t, Node (left,pv,right)) -> Loc (t, Node (left,chPath pv,right))
 where
   chPath pv = case pv of 
     (Top,a) -> (Top, f a)
     (Node (left,pv,right),v) -> (Node (left, chPath pv,right),v)

nthSubtree :: Int -> Tr a -> Err (Tr a)
nthSubtree n (Tr (a,ts)) = ts !? n

arityTree :: Tr a -> Int
arityTree (Tr (_,ts)) = length ts