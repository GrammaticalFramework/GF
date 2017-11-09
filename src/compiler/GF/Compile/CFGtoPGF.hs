{-# LANGUAGE FlexibleContexts, ImplicitParams #-}
module GF.Compile.CFGtoPGF (cf2pgf) where

import GF.Grammar.CFG
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Compile.OptimizePGF

import PGF
import PGF.Internal

import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Array.IArray
import Data.List
import Data.Maybe(fromMaybe)

--------------------------
-- the compiler ----------
--------------------------

cf2pgf :: Options -> FilePath -> ParamCFG -> Map.Map CId Double -> PGF
cf2pgf opts fpath cf probs = 
 build (let abstr = cf2abstr cf probs
        in newPGF [] aname abstr [(cname, cf2concr opts abstr cf)])
 where
   name = justModuleName fpath
   aname = mkCId (name ++ "Abs")
   cname = mkCId name

cf2abstr :: (?builder :: Builder s) => ParamCFG -> Map.Map CId Double -> B s AbstrInfo
cf2abstr cfg probs = newAbstr aflags acats afuns
  where
    aflags = [(mkCId "startcat", LStr (fst (cfgStartCat cfg)))]

    acats  = [(c', [], toLogProb (fromMaybe 0 (Map.lookup c' probs))) | cat <- allCats' cfg, let c' = cat2id cat]
    afuns  = [(f', dTyp [hypo Explicit wildCId (dTyp [] (cat2id c) []) | NonTerminal c <- ruleRhs rule] (cat2id (ruleLhs rule)) [], 0, toLogProb (fromMaybe 0 (Map.lookup f' funs_probs)))
                            | rule <- allRules cfg
                            , let f' = mkRuleName rule]

    funs_probs = (Map.fromList . concat . Map.elems . fmap pad . Map.fromListWith (++))
                     [(cat,[(f',Map.lookup f' probs)]) | rule <- allRules cfg,
                                                         let cat = cat2id (ruleLhs rule),
                                                         let f' = mkRuleName rule]
      where
        pad :: [(a,Maybe Double)] -> [(a,Double)]
        pad pfs = [(f,fromMaybe deflt mb_p) | (f,mb_p) <- pfs]
          where
            deflt = case length [f | (f,Nothing) <- pfs] of
                      0 -> 0
                      n -> max 0 ((1 - sum [d | (f,Just d) <- pfs]) / fromIntegral n)

    toLogProb = realToFrac . negate . log

    cat2id = mkCId . fst

cf2concr :: (?builder :: Builder s) => Options -> B s AbstrInfo -> ParamCFG -> B s ConcrInfo
cf2concr opts abstr cfg = 
  let (lindefs',linrefs',productions',cncfuns',sequences',cnccats') =
           (if flag optOptimizePGF opts then optimizePGF (mkCId (fst (cfgStartCat cfg))) else id)
                (lindefsrefs,lindefsrefs,IntMap.toList productions,cncfuns,sequences,cnccats)
  in newConcr abstr [] []
              lindefs' linrefs'
              productions' cncfuns'
              sequences' cnccats' totalCats
  where
    cats  = allCats' cfg
    rules = allRules cfg

    idSeq = [SymCat 0 0]

    sequences0 = Set.fromList (idSeq : 
                               map mkSequence rules)
    sequences  = Set.toList sequences0

    idFun = (wildCId,[Set.findIndex idSeq sequences0])
    ((fun_cnt,cncfuns0),productions0) = mapAccumL (convertRule cs) (1,[idFun]) rules
    productions = foldl addProd IntMap.empty (concat (productions0++coercions))
    cncfuns = reverse cncfuns0

    lbls = ["s"]
    (fid,cnccats) = (mapAccumL mkCncCat 0 . Map.toList . Map.fromListWith max)
                         [(c,p) | (c,ps) <- cats, p <- ps]
    ((totalCats,cs), coercions) = mapAccumL mkCoercions (fid,Map.empty) cats

    lindefsrefs = map mkLinDefRef cats

    convertRule cs (funid,funs) rule =
      let args   = [PArg [] (cat2arg c) | NonTerminal c <- ruleRhs rule]
          prod   = PApply funid args
          seqid  = Set.findIndex (mkSequence rule) sequences0
          fun    = (mkRuleName rule, [seqid])
          funid' = funid+1
      in funid' `seq` ((funid',fun:funs),let (c,ps) = ruleLhs rule in [(cat2fid c p, prod) | p <- ps])

    mkSequence rule = snd $ mapAccumL convertSymbol 0 (ruleRhs rule)
      where
        convertSymbol d (NonTerminal (c,_)) = (d+1,if c `elem` ["Int","Float","String"] then SymLit d 0 else SymCat d 0)
        convertSymbol d (Terminal t)        = (d,  SymKS t)

    mkCncCat fid (cat,n)
      | cat == "Int"    = (fid, (mkCId cat, fidInt,    fidInt,    lbls))
      | cat == "Float"  = (fid, (mkCId cat, fidFloat,  fidFloat,  lbls))
      | cat == "String" = (fid, (mkCId cat, fidString, fidString, lbls))
      | otherwise       = let fid' = fid+n+1
                          in fid' `seq` (fid', (mkCId cat, fid, fid+n, lbls))

    mkCoercions (fid,cs) c@(cat,[p]) = ((fid,cs),[])
    mkCoercions (fid,cs) c@(cat,ps ) =
      let fid' = fid+1
      in fid' `seq` ((fid', Map.insert c fid cs), [(fid,PCoerce (cat2fid cat p)) | p <- ps])

    mkLinDefRef (cat,_) =
      (cat2fid cat 0,[0])

    addProd prods (fid,prod) =
      case IntMap.lookup fid prods of
        Just set -> IntMap.insert fid (prod:set) prods
        Nothing  -> IntMap.insert fid [prod]     prods

    cat2fid cat p =
      case [start | (cat',start,_,_) <- cnccats, mkCId cat == cat'] of
        (start:_) -> fid+p
        _         -> error "cat2fid"

    cat2arg c@(cat,[p]) = cat2fid cat p
    cat2arg c@(cat,ps ) =
      case Map.lookup c cs of
        Just fid -> fid
        Nothing  -> error "cat2arg"

mkRuleName rule =
  case ruleName rule of
	CFObj n _ -> n
	_         -> wildCId

