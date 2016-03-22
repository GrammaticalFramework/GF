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

cf2pgf :: FilePath -> ParamCFG -> PGF
cf2pgf fpath cf = 
 let pgf = PGF Map.empty aname (cf2abstr cf) (Map.singleton cname (cf2concr cf))
 in updateProductionIndices pgf
 where
   name = justModuleName fpath
   aname = mkCId (name ++ "Abs")
   cname = mkCId name

cf2abstr :: ParamCFG -> Abstr
cf2abstr cfg = Abstr aflags afuns acats
  where
    aflags = Map.singleton (mkCId "startcat") (LStr (fst (cfgStartCat cfg)))

    acats  = Map.fromList [(cat, ([], [(0,mkRuleName rule) | rule <- rules], 0))
                            | (cat,rules) <- (Map.toList . Map.fromListWith (++))
                                                [(cat2id cat, catRules cfg cat) | 
                                                     cat <- allCats' cfg]]
    afuns  = Map.fromList [(mkRuleName rule, (cftype [cat2id c | NonTerminal c <- ruleRhs rule] (cat2id (ruleLhs rule)), 0, Nothing, 0))
                            | rule <- allRules cfg]

    cat2id = mkCId . fst

cf2concr :: ParamCFG -> Concr
cf2concr cfg = Concr Map.empty Map.empty
                     cncfuns lindefsrefs lindefsrefs
                     sequences productions
                     IntMap.empty Map.empty
                     cnccats
                     IntMap.empty
                     totalCats
  where
    cats  = allCats' cfg
    rules = allRules cfg

    sequences0 = Set.fromList (listArray (0,0) [SymCat 0 0] : 
                               map mkSequence rules)
    sequences  = listArray (0,Set.size sequences0-1) (Set.toList sequences0)

    idFun = CncFun wildCId (listArray (0,0) [seqid])
      where
        seq   = listArray (0,0) [SymCat 0 0]
        seqid = binSearch seq sequences (bounds sequences)
    ((fun_cnt,cncfuns0),productions0) = mapAccumL (convertRule cs) (1,[idFun]) rules
    productions = foldl addProd IntMap.empty (concat (productions0++coercions))
    cncfuns = listArray (0,fun_cnt-1) (reverse cncfuns0)

    lbls = listArray (0,0) ["s"]
    (fid,cnccats0) = (mapAccumL mkCncCat 0 . Map.toList . Map.fromListWith max)
                              [(c,p) | (c,ps) <- cats, p <- ps]
    ((totalCats,cs), coercions) = mapAccumL mkCoercions (fid,Map.empty) cats
    cnccats = Map.fromList cnccats0

    lindefsrefs =
       IntMap.fromList (map mkLinDefRef cats)

    convertRule cs (funid,funs) rule =
      let args   = [PArg [] (cat2arg c) | NonTerminal c <- ruleRhs rule]
          prod   = PApply funid args
          seqid  = binSearch (mkSequence rule) sequences (bounds sequences)
          fun    = CncFun (mkRuleName rule) (listArray (0,0) [seqid])
          funid' = funid+1
      in funid' `seq` ((funid',fun:funs),let (c,ps) = ruleLhs rule in [(cat2fid c p, prod) | p <- ps])

    mkSequence rule = listArray (0,length syms-1) syms
      where
        syms   = snd $ mapAccumL convertSymbol 0 (ruleRhs rule)

        convertSymbol d (NonTerminal (c,_)) = (d+1,if c `elem` ["Int","Float","String"] then SymLit d 0 else SymCat d 0)
        convertSymbol d (Terminal t)        = (d,  SymKS t)

    mkCncCat fid (cat,n)
      | cat == "Int"    = (fid, (mkCId cat, CncCat fidInt    fidInt    lbls))
      | cat == "Float"  = (fid, (mkCId cat, CncCat fidFloat  fidFloat  lbls))
      | cat == "String" = (fid, (mkCId cat, CncCat fidString fidString lbls))
      | otherwise       = let fid' = fid+n+1
                          in fid' `seq` (fid', (mkCId cat,CncCat fid (fid+n) lbls))

    mkCoercions (fid,cs) c@(cat,[p]) = ((fid,cs),[])
    mkCoercions (fid,cs) c@(cat,ps ) =
      let fid' = fid+1
      in fid' `seq` ((fid', Map.insert c fid cs), [(fid,PCoerce (cat2fid cat p)) | p <- ps])

    mkLinDefRef (cat,_) =
      (cat2fid cat 0,[0])
      
    addProd prods (fid,prod) =
      case IntMap.lookup fid prods of
        Just set -> IntMap.insert fid (Set.insert prod set) prods
        Nothing  -> IntMap.insert fid (Set.singleton prod)  prods

    binSearch v arr (i,j)
      | i <= j    = case compare v (arr ! k) of
                      LT -> binSearch v arr (i,k-1)
                      EQ -> k
                      GT -> binSearch v arr (k+1,j)
      | otherwise = error "binSearch"
      where
        k = (i+j) `div` 2

    cat2fid cat p =
      case Map.lookup (mkCId cat) cnccats of
        Just (CncCat fid _ _) -> fid+p
        _                     -> error "cat2fid"

    cat2arg c@(cat,[p]) = cat2fid cat p
    cat2arg c@(cat,ps ) =
      case Map.lookup c cs of
        Just fid -> fid
        Nothing  -> error "cat2arg"

mkRuleName rule =
  case ruleName rule of
	CFObj n _ -> n
	_         -> wildCId
