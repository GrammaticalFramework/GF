module PGF.Macros where

import PGF.CId
import PGF.Data
import Control.Monad
import qualified Data.Map    as Map
import qualified Data.Set    as Set
import qualified Data.IntMap as IntMap
import qualified Data.IntSet as IntSet
import qualified Data.Array  as Array
import Data.Maybe
import Data.List
import GF.Data.Utilities(sortNub)

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

-- | Show the printname of function or category
showPrintName :: PGF -> Language -> CId -> String
showPrintName pgf lang id = lookMap "?" id $ printnames $ lookMap (error "no lang") lang $ concretes pgf

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

_B = mkCId "__gfB"
_V = mkCId "__gfV"

updateProductionIndices :: PGF -> PGF
updateProductionIndices pgf = pgf{concretes = fmap updateConcrete (concretes pgf)}
  where
    updateConcrete cnc = 
      case parser cnc of
        Nothing    -> cnc
        Just pinfo -> let prods0    = filterProductions (productions pinfo)
                          p_prods   = parseIndex pinfo prods0
                          l_prods   = linIndex   pinfo prods0
                      in cnc{parser = Just pinfo{pproductions = p_prods, lproductions = l_prods}}
    
    filterProductions prods0
      | IntMap.size prods == IntMap.size prods0 = prods
      | otherwise                               = filterProductions prods
      where
        prods = IntMap.mapMaybe (filterProdSet prods0) prods0

        filterProdSet prods set0
          | Set.null set = Nothing
          | otherwise    = Just set
          where
            set = Set.filter (filterRule prods) set0

        filterRule prods (FApply funid args) = all (\fcat -> isLiteralFCat fcat || IntMap.member fcat prods) args
        filterRule prods (FCoerce fcat)      = isLiteralFCat fcat || IntMap.member fcat prods
        filterRule prods _                   = True

    parseIndex pinfo = IntMap.mapMaybeWithKey filterProdSet
      where
        filterProdSet fid prods
          | fid `IntSet.member` ho_fids = Just prods
          | otherwise                   = let prods' = Set.filter (not . is_ho_prod) prods
                                          in if Set.null prods'
                                               then Nothing
                                               else Just prods'

        is_ho_prod (FApply _ [fid]) | fid == fcatVar = True
        is_ho_prod _                                 = False

        ho_fids :: IntSet.IntSet
        ho_fids = IntSet.fromList [fid | cat <- ho_cats
                                       , fid <- maybe [] (\(s,e,_) -> [s..e]) (Map.lookup cat (startCats pinfo))]

        ho_cats :: [CId]
        ho_cats = sortNub [c | (ty,_,_) <- Map.elems (funs (abstract pgf))
                             , h <- case ty of {DTyp hyps val _ -> hyps}
                             , let ty = typeOfHypo h
                             , c <- fst (catSkeleton ty)]

    linIndex pinfo productions = 
      Map.fromListWith (IntMap.unionWith Set.union)
                       [(fun,IntMap.singleton res (Set.singleton prod)) | (res,prods) <- IntMap.toList productions
                                                                        , prod <- Set.toList prods
                                                                        , fun <- getFunctions prod]
      where
        getFunctions (FApply funid args) = let FFun fun _ = functions pinfo Array.! funid in [fun]
        getFunctions (FCoerce fid)       = case IntMap.lookup fid productions of
                                             Nothing    -> []
                                             Just prods -> [fun | prod <- Set.toList prods, fun <- getFunctions prod]