module PGF.Macros where

import PGF.CId
import PGF.Data
import Control.Monad
import qualified Data.Map   as Map
import qualified Data.Array as Array
import Data.Maybe
import Data.List

-- operations for manipulating PGF grammars and objects

mapConcretes :: (Concr -> Concr) -> PGF -> PGF
mapConcretes f pgf = pgf { concretes = Map.map f (concretes pgf) }

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
  case lookMap (error $ "lookType " ++ show f) f (funs (abstract pgf)) of
    (ty,_,_) -> ty

lookDef :: PGF -> CId -> [Equation]
lookDef pgf f = 
  case lookMap (error $ "lookDef " ++ show f) f (funs (abstract pgf)) of
    (_,a,eqs) -> eqs

isData :: PGF -> CId -> Bool
isData pgf f =
  case Map.lookup f (funs (abstract pgf)) of
    Just (_,_,[]) -> True             -- the encoding of data constrs
    _             -> False

lookValCat :: PGF -> CId -> CId
lookValCat pgf = valCat . lookType pgf

lookParser :: PGF -> CId -> Maybe ParserInfo
lookParser pgf lang = Map.lookup lang (concretes pgf) >>= parser

lookStartCat :: PGF -> CId
lookStartCat pgf = mkCId $ fromMaybe "S" $ msum $ Data.List.map (Map.lookup (mkCId "startcat"))
                                                        [gflags pgf, aflags (abstract pgf)]

lookGlobalFlag :: PGF -> CId -> String
lookGlobalFlag pgf f = 
  lookMap "?" f (gflags pgf)

lookAbsFlag :: PGF -> CId -> String
lookAbsFlag pgf f = 
  lookMap "?" f (aflags (abstract pgf))

lookConcr :: PGF -> CId -> Concr
lookConcr pgf cnc = 
    lookMap (error $ "Missing concrete syntax: " ++ showCId cnc) cnc $ concretes pgf

lookConcrFlag :: PGF -> CId -> CId -> Maybe String
lookConcrFlag pgf lang f = Map.lookup f $ cflags $ lookConcr pgf lang

functionsToCat :: PGF -> CId -> [(CId,Type)]
functionsToCat pgf cat =
  [(f,ty) | f <- fs, Just (ty,_,_) <- [Map.lookup f $ funs $ abstract pgf]]
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

depth :: Expr -> Int
depth (EAbs _ _ t) = depth t
depth (EApp e1 e2) = max (depth e1) (depth e2) + 1
depth _            = 1

cftype :: [CId] -> CId -> Type
cftype args val = DTyp [(Explicit,wildCId,cftype [] arg) | arg <- args] val []

typeOfHypo :: Hypo -> Type
typeOfHypo (_,_,ty) = ty

catSkeleton :: Type -> ([CId],CId)
catSkeleton ty = case ty of
  DTyp hyps val _ -> ([valCat (typeOfHypo h) | h <- hyps],val)

typeSkeleton :: Type -> ([(Int,CId)],CId)
typeSkeleton ty = case ty of
  DTyp hyps val _ -> ([(contextLength ty, valCat ty) | h <- hyps, let ty = typeOfHypo h],val)

valCat :: Type -> CId
valCat ty = case ty of
  DTyp _ val _ -> val

contextLength :: Type -> Int
contextLength ty = case ty of
  DTyp hyps _ _ -> length hyps

term0 :: CId -> Term
term0 = TM . showCId

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
isLiteralCat = (`elem` [cidString, cidFloat, cidInt, cidVar])

cidString = mkCId "String"
cidInt    = mkCId "Int"
cidFloat  = mkCId "Float"
cidVar    = mkCId "__gfVar"
