module PGF.Macros where

import PGF.CId
import PGF.Data
import Control.Monad
import qualified Data.Map   as Map
import qualified Data.Array as Array
import Data.Maybe
import Data.List

-- operations for manipulating PGF grammars and objects

lookLin :: PGF -> CId -> CId -> Term
lookLin pgf lang fun = 
  lookMap tm0 fun $ lins $ lookMap (error "no lang") lang $ concretes pgf

lookOper :: PGF -> CId -> CId -> Term
lookOper pgf lang fun = 
  lookMap tm0 fun $ opers $ lookMap (error "no lang") lang $ concretes pgf

lookLincat :: PGF -> CId -> CId -> Term
lookLincat pgf lang fun = 
  lookMap tm0 fun $ lincats $ lookMap (error "no lang") lang $ concretes pgf

lookParamLincat :: PGF -> CId -> CId -> Term
lookParamLincat pgf lang fun = 
  lookMap tm0 fun $ paramlincats $ lookMap (error "no lang") lang $ concretes pgf

lookPrintName :: PGF -> CId -> CId -> Term
lookPrintName pgf lang fun = 
  lookMap tm0 fun $ printnames $ lookMap (error "no lang") lang $ concretes pgf

lookType :: PGF -> CId -> Type
lookType pgf f = 
  fst $ lookMap (error $ "lookType " ++ show f) f (funs (abstract pgf))

lookDef :: PGF -> CId -> Expr
lookDef pgf f = 
  snd $ lookMap (error $ "lookDef " ++ show f) f (funs (abstract pgf))

isData :: PGF -> CId -> Bool
isData pgf f = case Map.lookup f (funs (abstract pgf)) of
  Just (_,EMeta 0) -> True ---- the encoding of data constrs
  _ -> False

lookValCat :: PGF -> CId -> CId
lookValCat pgf = valCat . lookType pgf

lookParser :: PGF -> CId -> Maybe ParserInfo
lookParser pgf lang = Map.lookup lang (concretes pgf) >>= parser

lookStartCat :: PGF -> String
lookStartCat pgf = fromMaybe "S" $ msum $ Data.List.map (Map.lookup (mkCId "startcat"))
                                                        [gflags pgf, aflags (abstract pgf)]

lookGlobalFlag :: PGF -> CId -> String
lookGlobalFlag pgf f = 
  lookMap "?" f (gflags pgf)

lookAbsFlag :: PGF -> CId -> String
lookAbsFlag pgf f = 
  lookMap "?" f (aflags (abstract pgf))

lookConcr :: PGF -> CId -> Concr
lookConcr pgf cnc = 
    lookMap (error $ "Missing concrete syntax: " ++ prCId cnc) cnc $ concretes pgf

lookConcrFlag :: PGF -> CId -> CId -> Maybe String
lookConcrFlag pgf lang f = Map.lookup f $ cflags $ lookConcr pgf lang

functionsToCat :: PGF -> CId -> [(CId,Type)]
functionsToCat pgf cat =
  [(f,ty) | f <- fs, Just (ty,_) <- [Map.lookup f $ funs $ abstract pgf]]
 where 
   fs = lookMap [] cat $ catfuns $ abstract pgf

missingLins :: PGF -> CId -> [CId]
missingLins pgf lang = [c | c <- fs, not (hasl c)] where
  fs = Map.keys $ funs $ abstract pgf
  hasl = hasLin pgf lang

hasLin :: PGF -> CId -> CId -> Bool
hasLin pgf lang f = Map.member f $ lins $ lookConcr pgf lang

restrictPGF :: (CId -> Bool) -> PGF -> PGF
restrictPGF cond pgf = pgf {
  abstract = abstr {
    funs = restrict $ funs $ abstr,
    cats = restrict $ cats $ abstr
    }
  }  ---- restrict concrs also, might be needed
 where
  restrict = Map.filterWithKey (\c _ -> cond c)
  abstr = abstract pgf

depth :: Tree -> Int
depth (Abs _  t) = depth t
depth (Fun _ ts) = maximum (0:map depth ts) + 1
depth _          = 1

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

primNotion :: Expr
primNotion = EEq []

term0 :: CId -> Term
term0 = TM . prCId

tm0 :: Term
tm0 = TM "?"

kks :: String -> Term
kks = K . KS

-- lookup with default value
lookMap :: (Show i, Ord i) => a -> i -> Map.Map i a -> a 
lookMap d c m = Map.findWithDefault d c m

--- from Operations
combinations :: [[a]] -> [[a]]
combinations t = case t of 
  []    -> [[]]
  aa:uu -> [a:u | a <- aa, u <- combinations uu]

isLiteralCat :: CId -> Bool
isLiteralCat = (`elem` [cidString, cidFloat, cidInt])

cidString = mkCId "String"
cidInt    = mkCId "Int"
cidFloat  = mkCId "Float"
