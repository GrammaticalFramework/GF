{-# LANGUAGE BangPatterns #-}
module PGF.Optimize
             ( optimizePGF
             , updateProductionIndices
             ) where

import PGF.CId
import PGF.Data
import PGF.Macros
import Data.Maybe
import Data.List (mapAccumL, nub)
import Data.Array.IArray
import Data.Array.MArray
import Data.Array.ST
import Data.Array.Unboxed
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntSet as IntSet
import qualified Data.IntMap as IntMap
import qualified Data.List as List
import Control.Monad.ST
import GF.Data.Utilities(sortNub)

optimizePGF :: PGF -> PGF
optimizePGF pgf = pgf{concretes=fmap (updateConcrete (abstract pgf) . 
                                      topDownFilter (lookStartCat pgf) .
                                      bottomUpFilter                    ) (concretes pgf)}

updateProductionIndices :: PGF -> PGF
updateProductionIndices pgf = pgf{concretes = fmap (updateConcrete (abstract pgf)) (concretes pgf)}

topDownFilter :: CId -> Concr -> Concr
topDownFilter startCat cnc =
  let env0         = (Map.empty,Map.empty)
      (env1,defs)  = IntMap.mapAccumWithKey (\env fid funids -> mapAccumL (optimizeFun fid [PArg [] fidVar]) env funids) 
                                            env0
                                            (lindefs cnc)
      (env2,prods) = IntMap.mapAccumWithKey (\env fid set  -> mapAccumLSet (optimizeProd fid) env set)
                                            env1
                                            (productions cnc)
      cats = Map.mapWithKey filterCatLabels (cnccats cnc)
      (seqs,funs) = env2
  in cnc{ sequences   = mkSetArray seqs
        , cncfuns     = mkSetArray funs
        , productions = prods
        , cnccats     = cats
        , lindefs     = defs
        }
  where
    fid2cat fid =
      case IntMap.lookup fid fid2catMap of
        Just cat -> cat
        Nothing  -> case [fid | Just set <- [IntMap.lookup fid (productions cnc)], PCoerce fid <- Set.toList set] of
                      (fid:_) -> fid2cat fid
                      _       -> error "unknown forest id"
      where
        fid2catMap = IntMap.fromList ((fidVar,cidVar) :  [(fid,cat) | (cat,CncCat start end lbls) <- Map.toList (cnccats cnc),
                                                                      fid <- [start..end]])

    starts =
      case Map.lookup startCat (cnccats cnc) of
        Just (CncCat _ _ lbls) -> [(startCat,lbl) | lbl <- indices lbls]
        Nothing                -> []

    allRelations =
      Map.unionsWith Set.union
                     [rel fid prod | (fid,set) <- IntMap.toList (productions cnc),
                                     prod <- Set.toList set]
      where
        rel fid (PApply funid args) = Map.fromList [((fid2cat fid,lbl),deps args seqid) | (lbl,seqid) <- assocs lin]
          where
            CncFun _ lin = cncfuns cnc ! funid
        rel fid _                   = Map.empty

        deps args seqid = Set.fromList [let PArg _ fid = args !! r in (fid2cat fid,d) | SymCat r d <- elems seq]
          where
            seq = sequences cnc ! seqid

    -- here we create a mapping from a category to an array of indices.
    -- An element of the array is equal to -1 if the corresponding index
    -- is not going to be used in the optimized grammar, or the new index
    -- if it will be used
    closure :: Map.Map CId (UArray LIndex LIndex)
    closure = runST $ do 
      set <- initSet
      addLitCat cidString set
      addLitCat cidInt    set
      addLitCat cidFloat  set
      addLitCat cidVar    set
      closureSet set starts
      doneSet set
      where
        initSet :: ST s (Map.Map CId (STUArray s LIndex LIndex))
        initSet =
          fmap Map.fromAscList $ sequence
                        [fmap ((,) cat) (newArray (bounds lbls) (-1))
                                             | (cat,CncCat _ _ lbls) <- Map.toAscList (cnccats cnc)]

        addLitCat cat set =
          case Map.lookup cat set of
            Just indices -> writeArray indices 0 0
            Nothing      -> return ()

        closureSet set []                 = return ()
        closureSet set (x@(cat,index):xs) =
          case Map.lookup cat set of
            Just indices -> do v <- readArray indices index
                               writeArray indices index 0
                               if v < 0
                                 then case Map.lookup x allRelations of
                                        Just ys -> closureSet set (Set.toList ys++xs)
                                        Nothing -> closureSet set xs
                                 else closureSet set xs
            Nothing      -> error "unknown cat"

        doneSet set =
          fmap Map.fromAscList $ mapM done (Map.toAscList set)
          where
            done (cat,indices) = do
              (s,e) <- getBounds indices
              reindex indices s e 0
              indices <- unsafeFreeze indices
              return (cat,indices)
              
            reindex indices i j k
              | i <= j    = do v <- readArray indices i
                               if v < 0
                                 then reindex indices (i+1) j k
                                 else writeArray indices i k >>
                                      reindex indices (i+1) j (k+1)
              | otherwise = return ()

    optimizeProd res env (PApply funid args) =
      let (env',funid') = optimizeFun res args env funid
      in (env', PApply funid' args)
    optimizeProd res env prod = (env,prod)
    
    optimizeFun res args (seqs,funs) funid =
      let (seqs',lin') = mapAccumL addUnique seqs [amap updateSymbol (sequences cnc ! seqid) | 
                                                          (lbl,seqid) <- assocs lin, indicesOf res ! lbl >= 0]
          (funs',funid') = addUnique funs (CncFun fun (mkArray lin'))
      in ((seqs',funs'), funid')
      where
        CncFun fun lin = cncfuns cnc ! funid

        indicesOf fid =
          case Map.lookup (fid2cat fid) closure of
            Just indices -> indices
            Nothing      -> error "unknown category"

        addUnique seqs seq =
          case Map.lookup seq seqs of
            Just seqid -> (seqs,seqid)
            Nothing    -> let seqid = Map.size seqs
                          in (Map.insert seq seqid seqs, seqid)

        updateSymbol (SymCat r d) = let PArg _ fid = args !! r in SymCat r (indicesOf fid ! d)
        updateSymbol s            = s

    filterCatLabels cat (CncCat start end lbls) =
      case Map.lookup cat closure of
        Just indices -> let lbls' = mkArray [lbl | (i,lbl) <- assocs lbls, indices ! i >= 0]
                        in CncCat start end lbls'
        Nothing      -> error "unknown category"

    mkSetArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]
    mkArray lst = listArray (0,length lst-1) lst
    
    mapAccumLSet f b set = let (b',lst) = mapAccumL f b (Set.toList set)
                           in (b',Set.fromList lst)


bottomUpFilter :: Concr -> Concr
bottomUpFilter cnc = cnc{productions=filterProductions IntMap.empty IntSet.empty (productions cnc)}

filterProductions prods0 hoc0 prods
  | prods0 == prods1 = prods0
  | otherwise        = filterProductions prods1 hoc1 prods
  where
    (prods1,hoc1) = IntMap.foldWithKey foldProdSet (IntMap.empty,IntSet.empty) prods

    foldProdSet fid set (!prods,!hoc)
      | Set.null set1 = (prods,hoc)
      | otherwise     = (IntMap.insert fid set1 prods,hoc1)
      where
        set1 = Set.filter filterRule set
        hoc1 = Set.fold accumHOC hoc set1

    filterRule (PApply funid args) = all (\(PArg _ fid) -> isLive fid) args
    filterRule (PCoerce fid)       = isLive fid
    filterRule _                   = True

    isLive fid = isPredefFId fid || IntMap.member fid prods0 || IntSet.member fid hoc0

    accumHOC (PApply funid args) hoc = List.foldl' (\hoc (PArg hypos _) -> List.foldl' (\hoc (_,fid) -> IntSet.insert fid hoc) hoc hypos) hoc args
    accumHOC _                   hoc = hoc

updateConcrete abs cnc = 
  let p_prods   = filterProductions IntMap.empty IntSet.empty (productions cnc)
      l_prods   = linIndex cnc p_prods
  in cnc{pproductions = p_prods, lproductions = l_prods}
  where
    linIndex cnc productions = 
      Map.fromListWith (IntMap.unionWith Set.union)
                       [(fun,IntMap.singleton res (Set.singleton prod)) | (res,prods) <- IntMap.toList productions
                                                                        , prod <- Set.toList prods
                                                                        , fun <- getFunctions prod]
      where
        getFunctions (PApply funid args) = let CncFun fun _ = cncfuns cnc ! funid in [fun]
        getFunctions (PCoerce fid)       = case IntMap.lookup fid productions of
                                             Nothing    -> []
                                             Just prods -> [fun | prod <- Set.toList prods, fun <- getFunctions prod]
