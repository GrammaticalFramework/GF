module Update where

import Ident
import Grammar
import PrGrammar
import Modules

import Operations

import List
import Monad

-- update a resource module by adding a new or changing an old definition

updateRes :: SourceGrammar -> Ident -> Ident -> Info -> SourceGrammar
updateRes gr@(MGrammar ms) m i info = MGrammar $ map upd ms where
  upd (n,mod) 
    | n /= m = (n,mod)
    | n == m = case mod of
       ModMod r -> (m,ModMod $ updateModule r i info)
       _ -> (n,mod) --- no error msg

-- combine a list of definitions into a balanced binary search tree

buildAnyTree :: [(Ident,Info)] -> Err (BinTree (Ident, Info))
buildAnyTree ias = do
  ias' <- combineAnyInfos ias
  return $ buildTree ias'


-- unifying information for abstract, resource, and concrete

combineAnyInfos :: [(Ident,Info)] -> Err [(Ident,Info)]
combineAnyInfos = combineInfos unifyAnyInfo

unifyAnyInfo :: Ident -> Info -> Info -> Err Info
unifyAnyInfo c i j = errIn ("combining information for" +++ prt c) $ case (i,j) of
  (AbsCat mc1 mf1, AbsCat mc2 mf2) -> 
    liftM2 AbsCat (unifPerhaps mc1 mc2) (unifConstrs mf1 mf2) -- adding constrs
  (AbsFun mt1 md1, AbsFun mt2 md2) -> 
    liftM2 AbsFun (unifPerhaps mt1 mt2) (unifAbsDefs md1 md2) -- adding defs

  (ResParam mt1, ResParam mt2) -> liftM ResParam $ unifPerhaps mt1 mt2
  (ResOper mt1 m1, ResOper mt2 m2) -> 
    liftM2 ResOper (unifPerhaps mt1 mt2) (unifPerhaps m1 m2)

  (CncCat mc1 mf1 mp1, CncCat mc2 mf2 mp2) -> 
    liftM3 CncCat (unifPerhaps mc1 mc2) (unifPerhaps mf1 mf2) (unifPerhaps mp1 mp2)
  (CncFun m mt1 md1, CncFun _ mt2 md2) -> 
    liftM2 (CncFun m) (unifPerhaps mt1 mt2) (unifPerhaps md1 md2) ---- adding defs

  _ -> Bad $ "cannot unify information for" +++ show i

--- these auxiliaries should be somewhere else since they don't use the info types

groupInfos :: Eq a => [(a,b)] -> [[(a,b)]]
groupInfos = groupBy (\i j -> fst i == fst j)

sortInfos :: Ord a => [(a,b)] -> [(a,b)]
sortInfos = sortBy (\i j -> compare (fst i) (fst j))

combineInfos :: Ord a => (a -> b -> b -> Err b) -> [(a,b)] -> Err [(a,b)]
combineInfos f ris = do
  let riss = groupInfos $ sortInfos ris
  mapM (unifyInfos f) riss

unifyInfos :: (a -> b -> b -> Err b) -> [(a,b)] -> Err (a,b)
unifyInfos _ [] = Bad "empty info list"
unifyInfos unif ris = do
  let c = fst $ head ris
  let infos = map snd ris
  let ([i],is) = splitAt 1 infos 
  info <- foldM (unif c) i is
  return (c,info)

tryInsert :: Ord a => (b -> b -> Err b) -> (b -> b) ->
             BinTree (a,b) -> (a,b) -> Err (BinTree (a,b))
tryInsert unif indir tree z@(x, info) = case tree of
 NT -> return $ BT (x, indir info) NT NT
 BT c@(a,info0) left right 
   | x < a  -> do
       left' <- tryInsert unif indir left z    
       return $ BT c left' right 
   | x > a  -> do
       right' <- tryInsert unif indir right z    
       return $ BT c left right' 
   | x == a -> do
       info' <- unif info info0
       return $ BT (x,info') left right

--- addToMaybeList m c = maybe (return c) (\old -> return (c ++ old)) m

unifAbsDefs :: Perh Term -> Perh Term -> Err (Perh Term)
unifAbsDefs p1 p2 = case (p1,p2) of
  (Nope, _)  -> return p2
  (_, Nope)  -> return p1
  (Yes (Eqs bs), Yes (Eqs ds)) -> return $ yes $ Eqs $ bs ++ ds --- order!
  _ -> Bad "update conflict for definitions"

unifConstrs :: Perh [Term] -> Perh [Term] -> Err (Perh [Term])
unifConstrs p1 p2 = case (p1,p2) of
  (Nope, _)  -> return p2
  (_, Nope)  -> return p1
  (Yes bs, Yes ds) -> return $ yes $ bs ++ ds
  _ -> Bad "update conflict for constructors"
