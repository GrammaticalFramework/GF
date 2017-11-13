{-# LANGUAGE ImplicitParams, BangPatterns, FlexibleContexts #-}
module GF.Compile.GrammarToPGF (grammar2PGF) where

import GF.Compile.GeneratePMCFG
import GF.Compile.GenerateBC
import GF.Compile.OptimizePGF

import PGF(CId,mkCId,Type,Hypo,Expr)
import PGF.Internal
import GF.Grammar.Predef
import GF.Grammar.Grammar hiding (Production)
import qualified GF.Grammar.Lookup as Look
import qualified GF.Grammar as A
import qualified GF.Grammar.Macros as GM

import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.UseIO (IOE)
import GF.Data.Operations

import Data.List
import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Array.IArray
import Data.Maybe(fromMaybe)

grammar2PGF :: Options -> SourceGrammar -> ModuleName -> Map.Map CId Double -> IO PGF
grammar2PGF opts gr am probs = do
  cnc_infos <- getConcreteInfos gr am
  return $
    build (let gflags   = if flag optSplitPGF opts 
                            then [(mkCId "split", LStr "true")]
                            else []
               (an,abs) = mkAbstr am probs
               cncs     = map (mkConcr opts abs) cnc_infos
           in newPGF gflags an abs cncs)
  where
    cenv = resourceValues opts gr
    aflags = err (const noOptions) mflags (lookupModule gr am)

    mkAbstr :: (?builder :: Builder s) => ModuleName -> Map.Map CId Double -> (CId, B s AbstrInfo)
    mkAbstr am probs = (mi2i am, newAbstr flags cats funs)
      where
        adefs =
            [((cPredefAbs,c), AbsCat (Just (L NoLoc []))) | c <- [cFloat,cInt,cString]] ++ 
            Look.allOrigInfos gr am

        flags = [(mkCId f,x) | (f,x) <- optionsPGF aflags]

        toLogProb = realToFrac . negate . log

        cats = [(c', snd (mkContext [] cont), toLogProb (fromMaybe 0 (Map.lookup c' probs))) |
                                   ((m,c),AbsCat (Just (L _ cont))) <- adefs, let c' = i2i c]

        funs = [(f', mkType [] ty, arity, {-mkDef gr arity mdef,-} toLogProb (fromMaybe 0 (Map.lookup f' funs_probs))) |
                                   ((m,f),AbsFun (Just (L _ ty)) ma mdef _) <- adefs,
                                   let arity = mkArity ma mdef ty,
                                   let f' = i2i f]
                                   
        funs_probs = (Map.fromList . concat . Map.elems . fmap pad . Map.fromListWith (++))
                        [(i2i cat,[(i2i f,Map.lookup f' probs)]) | ((m,f),AbsFun (Just (L _ ty)) _ _ _) <- adefs,
                                                                   let (_,(_,cat),_) = GM.typeForm ty,
                                                                   let f' = i2i f]
          where
            pad :: [(a,Maybe Double)] -> [(a,Double)]
            pad pfs = [(f,fromMaybe deflt mb_p) | (f,mb_p) <- pfs]
              where
                deflt = case length [f | (f,Nothing) <- pfs] of
                          0 -> 0
                          n -> max 0 ((1 - sum [d | (f,Just d) <- pfs]) / fromIntegral n)

    mkConcr opts abs (cm,ex_seqs,cdefs) =
      let cflags = err (const noOptions) mflags (lookupModule gr cm)
          flags  = [(mkCId f,x) | (f,x) <- optionsPGF cflags]

          seqs = (mkSetArray . Set.fromList . concat) $
                       (elems (ex_seqs :: Array SeqId [Symbol]) : [maybe [] elems (mseqs mi) | (m,mi) <- allExtends gr cm])

          !(!fid_cnt1,!cnccats) = genCncCats gr am cm cdefs
          cnccat_ranges = Map.fromList (map (\(cid,s,e,_) -> (cid,(s,e))) cnccats)
          !(!fid_cnt2,!productions,!lindefs,!linrefs,!cncfuns)
                                = genCncFuns gr am cm ex_seqs seqs cdefs fid_cnt1 cnccat_ranges

          printnames = genPrintNames cdefs

          startCat = mkCId (fromMaybe "S" (flag optStartCat aflags))

          (lindefs',linrefs',productions',cncfuns',sequences',cnccats') =
               (if flag optOptimizePGF opts then optimizePGF startCat else id)
                    (lindefs,linrefs,productions,cncfuns,elems seqs,cnccats)

      in (mi2i cm, newConcr abs
                            flags
                            printnames
                            lindefs'
                            linrefs'
                            productions'
                            cncfuns'
                            sequences'
                            cnccats'
                            fid_cnt2)

    getConcreteInfos gr am = mapM flatten (allConcretes gr am)
      where
        flatten cm = do
          (seqs,infos) <- addMissingPMCFGs cm Map.empty
                                           (lit_infos ++ Look.allOrigInfos gr cm)
          return (cm,mkMapArray seqs :: Array SeqId [Symbol],infos)

        lit_infos = [((cPredefAbs,c), CncCat (Just (L NoLoc GM.defLinType)) Nothing Nothing Nothing Nothing) | c <- [cInt,cFloat,cString]]

        -- if some module was compiled with -no-pmcfg, then
        -- we have to create the PMCFG code just before linking
        addMissingPMCFGs cm seqs []                  = return (seqs,[])
        addMissingPMCFGs cm seqs (((m,id), info):is) = do
          (seqs,info)  <- addPMCFG opts gr cenv Nothing am cm seqs id info
          (seqs,infos) <- addMissingPMCFGs cm seqs is
          return (seqs, ((m,id), info) : infos)

mkSetArray set = listArray (0,Set.size set-1) (Set.toList set)
mkMapArray map = array (0,Map.size map-1) [(k,v) | (v,k) <- Map.toList map]

i2i :: Ident -> CId
i2i = mkCId . showIdent

mi2i :: ModuleName -> CId
mi2i (MN i) = i2i i

mkType :: (?builder :: Builder s) => [Ident] -> A.Type -> B s PGF.Type
mkType scope t =
  case GM.typeForm t of
    (hyps,(_,cat),args) -> let (scope',hyps') = mkContext scope hyps
                           in dTyp hyps' (i2i cat) (map (mkExp scope') args)

mkExp :: (?builder :: Builder s) => [Ident] -> A.Term -> B s Expr
mkExp scope t =
  case t of
    Q (_,c)  -> eFun (i2i c)
    QC (_,c) -> eFun (i2i c)
    Vr x     -> case lookup x (zip scope [0..]) of
                  Just i  -> eVar  i
                  Nothing -> eMeta 0
    Abs b x t-> eAbs b (i2i x) (mkExp (x:scope) t)
    App t1 t2-> eApp (mkExp scope t1) (mkExp scope t2)
    EInt i   -> eLit (LInt (fromIntegral i))
    EFloat f -> eLit (LFlt f)
    K s      -> eLit (LStr s)
    Meta i   -> eMeta i
    _        -> eMeta 0
{-
mkPatt scope p = 
  case p of
    A.PP (_,c) ps->let (scope',ps') = mapAccumL mkPatt scope ps
                   in (scope',C.PApp (i2i c) ps')
    A.PV x      -> (x:scope,C.PVar (i2i x))
    A.PAs x p   -> let (scope',p') = mkPatt scope p
                   in (x:scope',C.PAs (i2i x) p')
    A.PW        -> (  scope,C.PWild)
    A.PInt i    -> (  scope,C.PLit (C.LInt (fromIntegral i)))
    A.PFloat f  -> (  scope,C.PLit (C.LFlt f))
    A.PString s -> (  scope,C.PLit (C.LStr s))
    A.PImplArg p-> let (scope',p') = mkPatt scope p
                   in (scope',C.PImplArg p')
    A.PTilde t  -> (  scope,C.PTilde (mkExp scope t))
-}
mkContext :: (?builder :: Builder s) => [Ident] -> A.Context -> ([Ident],[B s PGF.Hypo])
mkContext scope hyps = mapAccumL (\scope (bt,x,ty) -> let ty' = mkType scope ty
                                                      in if x == identW
                                                           then (  scope,hypo bt (i2i x) ty')
                                                           else (x:scope,hypo bt (i2i x) ty')) scope hyps 
{-
mkDef gr arity (Just eqs) = Just ([C.Equ ps' (mkExp scope' e) | L _ (ps,e) <- eqs, let (scope',ps') = mapAccumL mkPatt [] ps]
                                 ,generateByteCode gr arity eqs
                                 )
mkDef gr arity Nothing    = Nothing
-}
mkArity (Just a) _        ty = a   -- known arity, i.e. defined function
mkArity Nothing  (Just _) ty = 0   -- defined function with no arity - must be an axiom
mkArity Nothing  _        ty = let (ctxt, _, _) = GM.typeForm ty  -- constructor
                               in length ctxt

genCncCats gr am cm cdefs = mkCncCats 0 cdefs
  where
    mkCncCats index []                                                = (index,[])
    mkCncCats index (((m,id),CncCat (Just (L _ lincat)) _ _ _ _):cdefs) 
      | id == cInt    = 
            let cc            = pgfCncCat gr (i2i id) lincat fidInt
                (index',cats) = mkCncCats index cdefs
            in (index', cc : cats)
      | id == cFloat  = 
            let cc            = pgfCncCat gr (i2i id) lincat fidFloat
                (index',cats) = mkCncCats index cdefs
            in (index', cc : cats)
      | id == cString = 
            let cc            = pgfCncCat gr (i2i id) lincat fidString
                (index',cats) = mkCncCats index cdefs
            in (index', cc : cats)
      | otherwise     =
            let cc@(_, _s, e, _) = pgfCncCat gr (i2i id) lincat index
                (index',cats)    = mkCncCats (e+1) cdefs
            in (index', cc : cats)
    mkCncCats index (_                                          :cdefs) = mkCncCats index cdefs

genCncFuns :: Grammar
           -> ModuleName
           -> ModuleName
           -> Array SeqId [Symbol]
           -> Array SeqId [Symbol]
           -> [(QIdent, Info)]
           -> FId
           -> Map.Map CId (Int,Int)
           -> (FId,
               [(FId, [Production])],
               [(FId, [FunId])],
               [(FId, [FunId])],
               [(CId,[SeqId])])
genCncFuns gr am cm ex_seqs seqs cdefs fid_cnt cnccat_ranges =
  let (fid_cnt1,funs_cnt1,funs1,lindefs,linrefs) = mkCncCats cdefs fid_cnt  0 [] IntMap.empty IntMap.empty
      (fid_cnt2,funs_cnt2,funs2,prods0)          = mkCncFuns cdefs fid_cnt1 funs_cnt1 funs1 lindefs Map.empty IntMap.empty
      prods                                      = [(fid,Set.toList prodSet) | (fid,prodSet) <- IntMap.toList prods0]
  in (fid_cnt2,prods,IntMap.toList lindefs,IntMap.toList linrefs,reverse funs2)
  where
    mkCncCats []                                                          fid_cnt funs_cnt funs lindefs linrefs =
      (fid_cnt,funs_cnt,funs,lindefs,linrefs)
    mkCncCats (((m,id),CncCat _ _ _ _ (Just (PMCFG prods0 funs0))):cdefs) fid_cnt funs_cnt funs lindefs linrefs =
      let !funs_cnt' = let (s_funid, e_funid) = bounds funs0
                       in funs_cnt+(e_funid-s_funid+1)
          lindefs'   = foldl' (toLinDef (am,id) funs_cnt) lindefs prods0
          linrefs'   = foldl' (toLinRef (am,id) funs_cnt) linrefs prods0
          funs'      = foldl' (toCncFun funs_cnt (m,mkLinDefId id)) funs (assocs funs0)
      in mkCncCats cdefs fid_cnt funs_cnt' funs' lindefs' linrefs'
    mkCncCats (_                                                  :cdefs) fid_cnt funs_cnt funs lindefs linrefs =
      mkCncCats cdefs fid_cnt funs_cnt funs lindefs linrefs

    mkCncFuns []                                                        fid_cnt funs_cnt funs lindefs crc prods =
      (fid_cnt,funs_cnt,funs,prods)
    mkCncFuns (((m,id),CncFun _ _ _ (Just (PMCFG prods0 funs0))):cdefs) fid_cnt funs_cnt funs lindefs crc prods =
      let ty_C           = err error (\x -> x) $ fmap GM.typeForm (Look.lookupFunType gr am id)
          !funs_cnt'     = let (s_funid, e_funid) = bounds funs0
                           in funs_cnt+(e_funid-s_funid+1)
          !(fid_cnt',crc',prods')
                         = foldl' (toProd lindefs ty_C funs_cnt)
                                  (fid_cnt,crc,prods) prods0
          funs'          = foldl' (toCncFun funs_cnt (m,id)) funs (assocs funs0)
      in mkCncFuns cdefs fid_cnt' funs_cnt' funs' lindefs crc' prods'
    mkCncFuns (_                                                :cdefs) fid_cnt funs_cnt funs lindefs crc prods = 
      mkCncFuns cdefs fid_cnt funs_cnt funs lindefs crc prods

    toProd lindefs (ctxt_C,res_C,_) offs st (A.Production fid0 funid0 args0) =
      let !((fid_cnt,crc,prods),args) = mapAccumL mkArg st (zip ctxt_C args0)
          set0    = Set.fromList (map (PApply (offs+funid0)) (sequence args))
          fid     = mkFId res_C fid0
          !prods' = case IntMap.lookup fid prods of
                     Just set -> IntMap.insert fid (Set.union set0 set) prods
                     Nothing  -> IntMap.insert fid set0 prods
      in (fid_cnt,crc,prods')
      where
        mkArg st@(fid_cnt,crc,prods) ((_,_,ty),fid0s) =
          case fid0s of
            [fid0] -> (st,map (flip PArg (mkFId arg_C fid0)) ctxt)
            fid0s  -> case Map.lookup fids crc of
                        Just fid -> (st,map (flip PArg fid) ctxt)
                        Nothing  -> let !crc'   = Map.insert fids fid_cnt crc
                                        !prods' = IntMap.insert fid_cnt (Set.fromList (map PCoerce fids)) prods
                                    in ((fid_cnt+1,crc',prods'),map (flip PArg fid_cnt) ctxt)
          where
            (hargs_C,arg_C) = GM.catSkeleton ty
            ctxt = mapM (mkCtxt lindefs) hargs_C
            fids = map (mkFId arg_C) fid0s

    mkLinDefId id = prefixIdent "lindef " id

    toLinDef res offs lindefs (A.Production fid0 funid0 args) =
      if args == [[fidVar]]
        then IntMap.insertWith (++) fid [offs+funid0] lindefs
        else lindefs
      where
        fid = mkFId res fid0

    toLinRef res offs linrefs (A.Production fid0 funid0 [fargs]) =
      if fid0 == fidVar
        then foldr (\fid -> IntMap.insertWith (++) fid [offs+funid0]) linrefs fids
        else linrefs
      where
        fids = map (mkFId res) fargs

    mkFId (_,cat) fid0 =
      case Map.lookup (i2i cat) cnccat_ranges of
        Just (s,e) -> s+fid0
        Nothing    -> error ("GrammarToPGF.mkFId: missing category "++showIdent cat)

    mkCtxt lindefs (_,cat) =
      case Map.lookup (i2i cat) cnccat_ranges of
        Just (s,e) -> [(fid,fid) | fid <- [s..e], Just _ <- [IntMap.lookup fid lindefs]]
        Nothing    -> error "GrammarToPGF.mkCtxt failed"

    toCncFun offs (m,id) funs (funid0,lins0) =
      let mseqs = case lookupModule gr m of
                    Ok (ModInfo{mseqs=Just mseqs}) -> mseqs
                    _                              -> ex_seqs
      in (i2i id, map (newIndex mseqs) (elems lins0)):funs
      where
        newIndex mseqs i = binSearch (mseqs ! i) seqs (bounds seqs)

        binSearch v arr (i,j)
          | i <= j    = case compare v (arr ! k) of
                          LT -> binSearch v arr (i,k-1)
                          EQ -> k
                          GT -> binSearch v arr (k+1,j)
          | otherwise = error "binSearch"
          where
            k = (i+j) `div` 2


genPrintNames cdefs =
  [(i2i id, name) | ((m,id),info) <- cdefs, name <- prn info]
  where
    prn (CncFun _ _   (Just (L _ tr)) _) = [flatten tr]
    prn (CncCat _ _ _ (Just (L _ tr)) _) = [flatten tr]
    prn _                                = []

    flatten (K s)      = s
    flatten (Alts x _) = flatten x
    flatten (C x y)    = flatten x +++ flatten y
