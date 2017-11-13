{-# LANGUAGE BangPatterns #-}
module GF.Compile.OptimizePGF(optimizePGF) where

import PGF(mkCId)
import PGF.Internal
import Data.Array.ST
import Data.Array.Unboxed
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntSet as IntSet
import qualified Data.IntMap as IntMap
import qualified Data.List as List
import Control.Monad.ST

type ConcrData = ([(FId,[FunId])],          -- ^ Lindefs
                  [(FId,[FunId])],          -- ^ Linrefs
                  [(FId,[Production])],     -- ^ Productions
                  [(CId,[SeqId])],          -- ^ Concrete functions   (must be sorted by Fun)
                  [[Symbol]],               -- ^ Sequences            (must be sorted)
                  [(CId,FId,FId,[String])]) -- ^ Concrete categories

optimizePGF :: CId -> ConcrData -> ConcrData
optimizePGF startCat = topDownFilter startCat . bottomUpFilter

cidString = mkCId "String"
cidInt    = mkCId "Int"
cidFloat  = mkCId "Float"
cidVar    = mkCId "__gfVar"
                         
topDownFilter :: CId -> ConcrData -> ConcrData
topDownFilter startCat (lindefs,linrefs,prods,cncfuns,sequences,cnccats) =
  let env0             = (Map.empty,Map.empty)
      (env1,lindefs')  = List.mapAccumL (\env (fid,funids) -> let (env',funids') = List.mapAccumL (optimizeFun fid [PArg [] fidVar]) env funids in (env',(fid,funids')))
                                        env0
                                        lindefs
      (env2,linrefs')  = List.mapAccumL (\env (fid,funids) -> let (env',funids') = List.mapAccumL (optimizeFun fidVar [PArg [] fid]) env funids in (env',(fid,funids')))
                                        env1
                                        linrefs
      (env3,prods')    = List.mapAccumL (\env (fid,set)    -> let (env',set') = List.mapAccumL (optimizeProd fid) env set in (env',(fid,set')))
                                        env2
                                        prods
      cnccats' = map filterCatLabels cnccats
      (sequences',cncfuns') = env3
  in (lindefs',linrefs',prods',mkSetArray cncfuns',mkSetArray  sequences',cnccats')
  where
    cncfuns_array   = listArray (0,length cncfuns-1)   cncfuns   :: Array FunId (CId, [SeqId])
    sequences_array = listArray (0,length sequences-1) sequences :: Array SeqId [Symbol]
    prods_map  = IntMap.fromList prods
    fid2catMap = IntMap.fromList ((fidVar,cidVar) :  [(fid,cat) | (cat,start,end,lbls) <- cnccats,
                                                                  fid <- [start..end]])

    fid2cat fid =
      case IntMap.lookup fid fid2catMap of
        Just cat -> cat
        Nothing  -> case [fid | Just set <- [IntMap.lookup fid prods_map], PCoerce fid <- set] of
                      (fid:_) -> fid2cat fid
                      _       -> error "unknown forest id"

    starts =
      [(startCat,lbl) | (cat,_,_,lbls) <- cnccats, cat==startCat, lbl <- [0..length lbls-1]]

    allRelations =
      Map.unionsWith Set.union
                     [rel fid prod | (fid,set) <- prods, prod <- set]
      where
        rel fid (PApply funid args) = Map.fromList [((fid2cat fid,lbl),deps args seqid) | (lbl,seqid) <- zip [0..] lin]
          where
            (_,lin) = cncfuns_array ! funid
        rel fid _                   = Map.empty

        deps args seqid = Set.fromList [let PArg _ fid = args !! r in (fid2cat fid,d) | SymCat r d <- seq]
          where
            seq = sequences_array ! seqid

    -- here we create a mapping from a category to an array of indices.
    -- An element of the array is equal to -1 if the corresponding index
    -- is not going to be used in the optimized grammar, or the new index
    -- if it will be used
    closure :: Map.Map CId [LIndex]
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
          fmap Map.fromList $ sequence
                        [fmap ((,) cat) (newArray (0,length lbls-1) (-1))
                                             | (cat,_,_,lbls) <- cnccats]

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

        doneSet :: Map.Map CId (STUArray s LIndex LIndex) -> ST s (Map.Map CId [LIndex])
        doneSet set =
          fmap Map.fromAscList $ mapM done (Map.toAscList set)
          where
            done (cat,indices) = do
              indices <- fmap (reindex 0) (getElems indices)
              return (cat,indices)

            reindex k []     = []
            reindex k (v:vs)
              | v < 0        = v : reindex k     vs
              | otherwise    = k : reindex (k+1) vs

    optimizeProd res env (PApply funid args) =
      let (env',funid') = optimizeFun res args env funid
      in (env', PApply funid' args)
    optimizeProd res env prod = (env,prod)

    optimizeFun res args (seqs,funs) funid =
      let (seqs',lin')   = List.mapAccumL addUnique seqs [map updateSymbol (sequences_array ! seqid) | 
                                                                   (idx,seqid) <- zip (indicesOf res) lin, idx >= 0]
          (funs',funid') = addUnique funs (fun, lin')
      in ((seqs',funs'), funid')
      where
        (fun,lin) = cncfuns_array ! funid

        indicesOf fid
          | fid < 0   = [0]
          | otherwise =
              case Map.lookup (fid2cat fid) closure of
                Just indices -> indices
                Nothing      -> error "unknown category"

        addUnique seqs seq =
          case Map.lookup seq seqs of
            Just seqid -> (seqs,seqid)
            Nothing    -> let seqid = Map.size seqs
                          in (Map.insert seq seqid seqs, seqid)

        updateSymbol (SymCat r d) = let PArg _ fid = args !! r in SymCat r (indicesOf fid !! d)
        updateSymbol s            = s

    filterCatLabels (cat,start,end,lbls) =
      case Map.lookup cat closure of
        Just indices -> let lbls' = [lbl | (idx,lbl) <- zip indices lbls, idx >= 0]
                        in (cat,start,end,lbls')
        Nothing      -> error ("unknown category")

    mkSetArray map = sortSnd (Map.toList map)
      where
        sortSnd = List.map fst . List.sortBy (\(_,i) (_,j) -> compare i j)


bottomUpFilter :: ConcrData -> ConcrData
bottomUpFilter (lindefs,linrefs,prods,cncfuns,sequences,cnccats) =
  (lindefs,linrefs,filterProductions IntMap.empty IntSet.empty prods,cncfuns,sequences,cnccats)

filterProductions prods0 hoc0 prods
  | prods0 == prods1 = IntMap.toList prods0
  | otherwise        = filterProductions prods1 hoc1 prods
  where
    (prods1,hoc1) = foldl foldProdSet (IntMap.empty,IntSet.empty) prods

    foldProdSet (!prods,!hoc) (fid,set)
      | null set1 = (prods,hoc)
      | otherwise = (IntMap.insert fid set1 prods,hoc1)
      where
        set1 = filter filterRule set
        hoc1 = foldl accumHOC hoc set1

    filterRule (PApply funid args) = all (\(PArg _ fid) -> isLive fid) args
    filterRule (PCoerce fid)       = isLive fid
    filterRule _                   = True

    isLive fid = isPredefFId fid || IntMap.member fid prods0 || IntSet.member fid hoc0

    accumHOC hoc (PApply funid args) = List.foldl' (\hoc (PArg hypos _) -> List.foldl' (\hoc fid -> IntSet.insert fid hoc) hoc (map snd hypos)) hoc args
    accumHOC hoc _                   = hoc
