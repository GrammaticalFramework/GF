module PGF.Macros where

import PGF.CId
import PGF.Data
import Control.Monad
import qualified Data.Map   as Map
import qualified Data.Array as Array
import Data.Maybe
import Data.List

-- operations for manipulating GFCC grammars and objects

lookLin :: GFCC -> CId -> CId -> Term
lookLin gfcc lang fun = 
  lookMap tm0 fun $ lins $ lookMap (error "no lang") lang $ concretes gfcc

lookOper :: GFCC -> CId -> CId -> Term
lookOper gfcc lang fun = 
  lookMap tm0 fun $ opers $ lookMap (error "no lang") lang $ concretes gfcc

lookLincat :: GFCC -> CId -> CId -> Term
lookLincat gfcc lang fun = 
  lookMap tm0 fun $ lincats $ lookMap (error "no lang") lang $ concretes gfcc

lookParamLincat :: GFCC -> CId -> CId -> Term
lookParamLincat gfcc lang fun = 
  lookMap tm0 fun $ paramlincats $ lookMap (error "no lang") lang $ concretes gfcc

lookType :: GFCC -> CId -> Type
lookType gfcc f = 
  fst $ lookMap (error $ "lookType " ++ show f) f (funs (abstract gfcc))

lookParser :: GFCC -> CId -> Maybe ParserInfo
lookParser gfcc lang = parser $ lookMap (error "no lang") lang $ concretes gfcc

lookFCFG :: GFCC -> CId -> Maybe FGrammar
lookFCFG gfcc lang = fmap toFGrammar $ lookParser gfcc lang
  where
    toFGrammar :: ParserInfo -> FGrammar
    toFGrammar pinfo = (Array.elems (allRules pinfo), startupCats pinfo)

lookStartCat :: GFCC -> String
lookStartCat gfcc = fromMaybe "S" $ msum $ Data.List.map (Map.lookup (mkCId "startcat"))
                                              [gflags gfcc, aflags (abstract gfcc)]

lookGlobalFlag :: GFCC -> CId -> String
lookGlobalFlag gfcc f = 
  lookMap "?" f (gflags gfcc)

lookAbsFlag :: GFCC -> CId -> String
lookAbsFlag gfcc f = 
  lookMap "?" f (aflags (abstract gfcc))

lookCncFlag :: GFCC -> CId -> CId -> String
lookCncFlag gfcc lang f = 
  lookMap "?" f $ cflags $ lookMap (error "no lang") lang $ concretes gfcc

functionsToCat :: GFCC -> CId -> [(CId,Type)]
functionsToCat gfcc cat =
  [(f,ty) | f <- fs, Just (ty,_) <- [Map.lookup f $ funs $ abstract gfcc]]
 where 
   fs = lookMap [] cat $ catfuns $ abstract gfcc

depth :: Exp -> Int
depth (EAbs _  t) = depth t
depth (EApp _ ts) = maximum (0:map depth ts) + 1
depth _           = 1

cftype :: [CId] -> CId -> Type
cftype args val = DTyp [Hyp wildCId (cftype [] arg) | arg <- args] val []

catSkeleton :: Type -> ([CId],CId)
catSkeleton ty = case ty of
  DTyp hyps val _ -> ([valCat ty | Hyp _ ty <- hyps],val)

typeSkeleton :: Type -> ([(Int,CId)],CId)
typeSkeleton ty = case ty of
  DTyp hyps val _ -> ([(contextLength ty, valCat ty) | Hyp _ ty <- hyps],val)

valCat :: Type -> CId
valCat ty = case ty of
  DTyp _ val _ -> val

contextLength :: Type -> Int
contextLength ty = case ty of
  DTyp hyps _ _ -> length hyps

primNotion :: Exp
primNotion = EEq []

term0 :: CId -> Term
term0 = TM . prCId

tm0 :: Term
tm0 = TM "?"

kks :: String -> Term
kks = K . KS

-- lookup with default value
lookMap :: (Show i, Ord i) => a -> i -> Map.Map i a -> a 
lookMap d c m = maybe d id $ Map.lookup c m

--- from Operations
combinations :: [[a]] -> [[a]]
combinations t = case t of 
  []    -> [[]]
  aa:uu -> [a:u | a <- aa, u <- combinations uu]


