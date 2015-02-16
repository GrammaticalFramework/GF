{-# LANGUAGE FlexibleContexts #-}
module GF.Compile.CFGtoPGF (cf2pgf) where

import GF.Grammar.CFG
import GF.Infra.UseIO

import PGF
import PGF.Internal

import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Array.IArray
import Data.List

--------------------------
-- the compiler ----------
--------------------------

cf2pgf :: FilePath -> CFG -> PGF
cf2pgf fpath cf = 
 let pgf = PGF Map.empty aname (cf2abstr cf) (Map.singleton cname (cf2concr cf))
 in updateProductionIndices pgf
 where
   name = justModuleName fpath
   aname = mkCId (name ++ "Abs")
   cname = mkCId name

cf2abstr :: CFG -> Abstr
cf2abstr cfg = Abstr aflags afuns acats
  where
    aflags = Map.singleton (mkCId "startcat") (LStr (cfgStartCat cfg))
    acats = Map.fromList [(mkCId cat, ([], [(0,mkRuleName rule) 
                                              | rule <- Set.toList rules], 0))
                            | (cat,rules) <- Map.toList (cfgRules cfg)]
    afuns = Map.fromList [(mkRuleName rule, (cftype [mkCId c | NonTerminal c <- ruleRhs rule] (mkCId cat), 0, Nothing, 0))
                            | (cat,rules) <- Map.toList (cfgRules cfg)
                            , rule <- Set.toList rules]

cf2concr :: CFG -> Concr
cf2concr cfg = Concr Map.empty Map.empty
                     cncfuns lindefsrefs lindefsrefs
                     sequences productions
                     IntMap.empty Map.empty
                     cnccats
                     IntMap.empty
                     totalCats
  where
    sequences0 = Set.fromList (listArray (0,0) [SymCat 0 0] : 
                               [mkSequence rule | rules <- Map.elems (cfgRules cfg), rule <- Set.toList rules])
    sequences  = listArray (0,Set.size sequences0-1) (Set.toList sequences0)

    idFun = CncFun wildCId (listArray (0,0) [seqid])
      where
        seq   = listArray (0,0) [SymCat 0 0]
        seqid = binSearch seq sequences (bounds sequences)
    ((fun_cnt,cncfuns0),productions0) = mapAccumL convertRules (1,[idFun]) (Map.toList (cfgRules cfg))
    productions = IntMap.fromList productions0
    cncfuns = listArray (0,fun_cnt-1) (reverse cncfuns0)

    lbls = listArray (0,0) ["s"]
    (totalCats,cnccats0) = mapAccumL mkCncCat 0 (Map.toList (cfgRules cfg))
    cnccats = Map.fromList cnccats0

    lindefsrefs = 
       IntMap.fromList (map mkLinDefRef (Map.keys (cfgRules cfg)))

    convertRules st (cat,rules) =
      let (st',prods) = mapAccumL convertRule st (Set.toList rules)
      in (st',(cat2fid cat,Set.fromList prods))

    convertRule (funid,funs) rule = 
      let args   = [PArg [] (cat2fid c) | NonTerminal c <- ruleRhs rule]
          prod   = PApply funid args
          seqid  = binSearch (mkSequence rule) sequences (bounds sequences)
          fun    = CncFun (mkRuleName rule) (listArray (0,0) [seqid])
          funid' = funid+1
      in funid' `seq` ((funid',fun:funs),prod)

    mkSequence rule = listArray (0,length syms-1) syms
      where
        syms   = snd $ mapAccumL convertSymbol 0 (ruleRhs rule)

        convertSymbol d (NonTerminal _) = (d+1,SymCat d 0)
        convertSymbol d (Terminal t)    = (d,  SymKS t)

    mkCncCat fid (cat,_) = (fid+1, (mkCId cat,CncCat fid fid lbls))

    mkLinDefRef cat =
      (cat2fid cat,[0])

    binSearch v arr (i,j)
      | i <= j    = case compare v (arr ! k) of
                      LT -> binSearch v arr (i,k-1)
                      EQ -> k
                      GT -> binSearch v arr (k+1,j)
      | otherwise = error "binSearch"
      where
        k = (i+j) `div` 2

    cat2fid cat = 
      case Map.lookup (mkCId cat) cnccats of
        Just (CncCat fid _ _) -> fid
        _                     -> error "cat2fid"

mkRuleName rule =
  case ruleName rule of
	CFObj n _ -> n
	_         -> wildCId
