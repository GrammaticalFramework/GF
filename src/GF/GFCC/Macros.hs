module GF.GFCC.Macros where

import GF.GFCC.AbsGFCC
import GF.GFCC.DataGFCC
import GF.GFCC.PrintGFCC
import Data.Map
import Data.List

-- operations for manipulating GFCC grammars and objects

lookLin :: GFCC -> CId -> CId -> Term
lookLin gfcc lang fun = 
  lookMap TM fun $ lins $ lookMap (error "no lang") lang $ concretes gfcc

lookOper :: GFCC -> CId -> CId -> Term
lookOper gfcc lang fun = 
  lookMap TM fun $ opers $ lookMap (error "no lang") lang $ concretes gfcc

lookLincat :: GFCC -> CId -> CId -> Term
lookLincat gfcc lang fun = 
  lookMap TM fun $ lincats $ lookMap (error "no lang") lang $ concretes gfcc

lookType :: GFCC -> CId -> Type
lookType gfcc f = 
  fst $ lookMap (error $ "lookType " ++ show f) f (funs (abstract gfcc))

functionsToCat :: GFCC -> CId -> [(CId,Type)]
functionsToCat gfcc cat =
  [(f,ty) | f <- fs, Just (ty,_) <- [Data.Map.lookup f $ funs $ abstract gfcc]]
 where 
   fs = lookMap [] cat $ catfuns $ abstract gfcc

depth :: Exp -> Int
depth tr = case tr of
  DTr _ _ [] -> 1
  DTr _ _ ts -> maximum (lmap depth ts) + 1

tree :: Atom -> [Exp] -> Exp
tree = DTr []

cftype :: [CId] -> CId -> Type
cftype args val = DTyp [Hyp wildCId (cftype [] arg) | arg <- args] val []

catSkeleton :: Type -> ([CId],CId)
catSkeleton ty = case ty of
  DTyp hyps val _ -> ([valCat ty | Hyp _ ty <- hyps],val)

valCat :: Type -> CId
valCat ty = case ty of
  DTyp _ val _ -> val

wildCId :: CId
wildCId = CId "_"

exp0 :: Exp
exp0 = tree (AM 0) []

primNotion :: Exp
primNotion = EEq []

term0 :: CId -> Term
term0 _ = TM

kks :: String -> Term
kks = K . KS

prt :: Print a => a -> String
prt = printTree

-- lookup with default value
lookMap :: (Show i, Ord i) => a -> i -> Map i a -> a 
lookMap d c m = maybe d id $ Data.Map.lookup c m

--- from Operations
combinations :: [[a]] -> [[a]]
combinations t = case t of 
  []    -> [[]]
  aa:uu -> [a:u | a <- aa, u <- combinations uu]


