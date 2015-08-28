{-# LANGUAGE BangPatterns, FlexibleContexts #-}
module GF.Compile.GrammarToPGF (mkCanon2pgf) where

--import GF.Compile.Export
import GF.Compile.GeneratePMCFG
import GF.Compile.GenerateBC

import PGF(CId,mkCId,utf8CId)
import PGF.Internal(fidInt,fidFloat,fidString,fidVar)
import PGF.Internal(updateProductionIndices)
--import qualified PGF.Macros as CM
import qualified PGF.Internal as C
import qualified PGF.Internal as D
import GF.Grammar.Predef
--import GF.Grammar.Printer
import GF.Grammar.Grammar
import qualified GF.Grammar.Lookup as Look
import qualified GF.Grammar as A
import qualified GF.Grammar.Macros as GM
--import GF.Compile.GeneratePMCFG

import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.UseIO (IOE)
import GF.Data.Operations

import Data.List
import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Array.IArray

mkCanon2pgf :: Options -> SourceGrammar -> ModuleName -> IOE D.PGF
mkCanon2pgf opts gr am = do
  (an,abs) <- mkAbstr am
  cncs     <- mapM mkConcr (allConcretes gr am)
  return $ updateProductionIndices (D.PGF Map.empty an abs (Map.fromList cncs))
  where
    cenv = resourceValues opts gr

    mkAbstr am = return (mi2i am, D.Abstr flags funs cats)
      where
        aflags = err (const noOptions) mflags (lookupModule gr am)

        adefs =
            [((cPredefAbs,c), AbsCat (Just (L NoLoc []))) | c <- [cFloat,cInt,cString]] ++ 
            Look.allOrigInfos gr am

        flags = Map.fromList [(mkCId f,x) | (f,x) <- optionsPGF aflags]

        funs = Map.fromList [(i2i f, (mkType [] ty, arity, mkDef gr arity mdef, 0)) | 
                                   ((m,f),AbsFun (Just (L _ ty)) ma mdef _) <- adefs,
                                   let arity = mkArity ma mdef ty]

        cats = Map.fromList [(i2i c, (snd (mkContext [] cont),catfuns c, 0)) |
                                   ((m,c),AbsCat (Just (L _ cont))) <- adefs]

        catfuns cat =
              [(0,i2i f) | ((m,f),AbsFun (Just (L _ ty)) _ _ (Just True)) <- adefs, snd (GM.valCat ty) == cat]

    mkConcr cm = do
      let cflags  = err (const noOptions) mflags (lookupModule gr cm)

      (ex_seqs,cdefs) <- addMissingPMCFGs
                            Map.empty 
                            ([((cPredefAbs,c), CncCat (Just (L NoLoc GM.defLinType)) Nothing Nothing Nothing Nothing) | c <- [cInt,cFloat,cString]] ++
                             Look.allOrigInfos gr cm)

      let flags = Map.fromList [(mkCId f,x) | (f,x) <- optionsPGF cflags]

          seqs = (mkSetArray . Set.fromList . concat) $
                     (Map.keys ex_seqs : [maybe [] elems (mseqs mi) | (m,mi) <- allExtends gr cm])

          ex_seqs_arr = mkMapArray ex_seqs :: Array SeqId Sequence

          !(!fid_cnt1,!cnccats) = genCncCats gr am cm cdefs
          !(!fid_cnt2,!productions,!lindefs,!linrefs,!cncfuns)
                                = genCncFuns gr am cm ex_seqs_arr seqs cdefs fid_cnt1 cnccats
        
          printnames = genPrintNames cdefs
      return (mi2i cm, D.Concr flags
                              printnames
                              cncfuns
                              lindefs
                              linrefs
                              seqs
                              productions
                              IntMap.empty
                              Map.empty
                              cnccats
                              IntMap.empty
                              fid_cnt2)
      where
        -- if some module was compiled with -no-pmcfg, then
        -- we have to create the PMCFG code just before linking
        addMissingPMCFGs seqs []                  = return (seqs,[])
        addMissingPMCFGs seqs (((m,id), info):is) = do
          (seqs,info) <- addPMCFG opts gr cenv Nothing am cm seqs id info
          (seqs,is  ) <- addMissingPMCFGs seqs is
          return (seqs, ((m,id), info) : is)

i2i :: Ident -> CId
i2i = utf8CId . ident2utf8

mi2i :: ModuleName -> CId
mi2i (MN i) = i2i i

mkType :: [Ident] -> A.Type -> C.Type
mkType scope t =
  case GM.typeForm t of
    (hyps,(_,cat),args) -> let (scope',hyps') = mkContext scope hyps
                           in C.DTyp hyps' (i2i cat) (map (mkExp scope') args)

mkExp :: [Ident] -> A.Term -> C.Expr
mkExp scope t = 
  case t of
    Q (_,c)  -> C.EFun (i2i c)
    QC (_,c) -> C.EFun (i2i c)
    Vr x     -> case lookup x (zip scope [0..]) of
                  Just i  -> C.EVar  i
                  Nothing -> C.EMeta 0
    Abs b x t-> C.EAbs b (i2i x) (mkExp (x:scope) t)
    App t1 t2-> C.EApp (mkExp scope t1) (mkExp scope t2)
    EInt i   -> C.ELit (C.LInt (fromIntegral i))
    EFloat f -> C.ELit (C.LFlt f)
    K s      -> C.ELit (C.LStr s)
    Meta i   -> C.EMeta i
    _        -> C.EMeta 0

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

mkContext :: [Ident] -> A.Context -> ([Ident],[C.Hypo])
mkContext scope hyps = mapAccumL (\scope (bt,x,ty) -> let ty' = mkType scope ty
                                                      in if x == identW
                                                           then (  scope,(bt,i2i x,ty'))
                                                           else (x:scope,(bt,i2i x,ty'))) scope hyps 

mkDef gr arity (Just eqs) = Just ([C.Equ ps' (mkExp scope' e) | L _ (ps,e) <- eqs, let (scope',ps') = mapAccumL mkPatt [] ps]
                                 ,generateByteCode gr arity eqs
                                 )
mkDef gr arity Nothing    = Nothing

mkArity (Just a) _        ty = a   -- known arity, i.e. defined function
mkArity Nothing  (Just _) ty = 0   -- defined function with no arity - must be an axiom
mkArity Nothing  _        ty = let (ctxt, _, _) = GM.typeForm ty  -- constructor
                               in length ctxt

genCncCats gr am cm cdefs =
  let (index,cats) = mkCncCats 0 cdefs
  in (index, Map.fromList cats)
  where
    mkCncCats index []                                                = (index,[])
    mkCncCats index (((m,id),CncCat (Just (L _ lincat)) _ _ _ _):cdefs) 
      | id == cInt    = 
            let cc            = pgfCncCat gr lincat fidInt
                (index',cats) = mkCncCats index cdefs
            in (index', (i2i id,cc) : cats)
      | id == cFloat  = 
            let cc            = pgfCncCat gr lincat fidFloat
                (index',cats) = mkCncCats index cdefs
            in (index', (i2i id,cc) : cats)
      | id == cString = 
            let cc            = pgfCncCat gr lincat fidString
                (index',cats) = mkCncCats index cdefs
            in (index', (i2i id,cc) : cats)
      | otherwise     =
            let cc@(C.CncCat _s e _) = pgfCncCat gr lincat index
                (index',cats)        = mkCncCats (e+1) cdefs
            in (index', (i2i id,cc) : cats)
    mkCncCats index (_                      :cdefs) = mkCncCats index cdefs

genCncFuns :: Grammar
           -> ModuleName
           -> ModuleName
           -> Array SeqId Sequence
           -> Array SeqId Sequence
           -> [(QIdent, Info)]
           -> FId
           -> Map.Map CId D.CncCat
           -> (FId,
               IntMap.IntMap (Set.Set D.Production),
               IntMap.IntMap [FunId],
               IntMap.IntMap [FunId],
               Array FunId D.CncFun)
genCncFuns gr am cm ex_seqs seqs cdefs fid_cnt cnccats =
  let (fid_cnt1,funs_cnt1,funs1,lindefs,linrefs) = mkCncCats cdefs fid_cnt  0 [] IntMap.empty IntMap.empty
      (fid_cnt2,funs_cnt2,funs2,prods)           = mkCncFuns cdefs fid_cnt1 funs_cnt1 funs1 lindefs Map.empty IntMap.empty
  in (fid_cnt2,prods,lindefs,linrefs,array (0,funs_cnt2-1) funs2)
  where
    mkCncCats []                                                        fid_cnt funs_cnt funs lindefs linrefs =
      (fid_cnt,funs_cnt,funs,lindefs,linrefs)
    mkCncCats (((m,id),CncCat _ _ _ _ (Just (PMCFG prods0 funs0))):cdefs) fid_cnt funs_cnt funs lindefs linrefs =
      let !funs_cnt' = let (s_funid, e_funid) = bounds funs0
                       in funs_cnt+(e_funid-s_funid+1)
          lindefs'   = foldl' (toLinDef (am,id) funs_cnt) lindefs prods0
          linrefs'   = foldl' (toLinRef (am,id) funs_cnt) linrefs prods0
          funs'      = foldl' (toCncFun funs_cnt (m,mkLinDefId id)) funs (assocs funs0)
      in mkCncCats cdefs fid_cnt funs_cnt' funs' lindefs' linrefs'
    mkCncCats (_                                                :cdefs) fid_cnt funs_cnt funs lindefs linrefs =
      mkCncCats cdefs fid_cnt funs_cnt funs lindefs linrefs

    mkCncFuns []                                                        fid_cnt funs_cnt funs lindefs crc prods =
      (fid_cnt,funs_cnt,funs,prods)
    mkCncFuns (((m,id),CncFun _ _ _ (Just (PMCFG prods0 funs0))):cdefs) fid_cnt funs_cnt funs lindefs crc prods =
      let ---Ok ty_C        = fmap GM.typeForm (Look.lookupFunType gr am id)
          ty_C           = err error (\x -> x) $ fmap GM.typeForm (Look.lookupFunType gr am id)
          !funs_cnt'     = let (s_funid, e_funid) = bounds funs0
                           in funs_cnt+(e_funid-s_funid+1)
          !(fid_cnt',crc',prods') 
                         = foldl' (toProd lindefs ty_C funs_cnt)
                                  (fid_cnt,crc,prods) prods0
          funs'          = foldl' (toCncFun funs_cnt (m,id)) funs (assocs funs0)
      in mkCncFuns cdefs fid_cnt' funs_cnt' funs' lindefs crc' prods'
    mkCncFuns (_                                                :cdefs) fid_cnt funs_cnt funs lindefs crc prods = 
      mkCncFuns cdefs fid_cnt funs_cnt funs lindefs crc prods

    toProd lindefs (ctxt_C,res_C,_) offs st (Production fid0 funid0 args0) =
      let !((fid_cnt,crc,prods),args) = mapAccumL mkArg st (zip ctxt_C args0) 
          set0    = Set.fromList (map (C.PApply (offs+funid0)) (sequence args))
          fid     = mkFId res_C fid0
          !prods' = case IntMap.lookup fid prods of
                     Just set -> IntMap.insert fid (Set.union set0 set) prods
                     Nothing  -> IntMap.insert fid set0 prods
      in (fid_cnt,crc,prods')
      where
        mkArg st@(fid_cnt,crc,prods) ((_,_,ty),fid0s ) =
          case fid0s of
            [fid0] -> (st,map (flip C.PArg (mkFId arg_C fid0)) ctxt)
            fid0s  -> case Map.lookup fids crc of
                        Just fid -> (st,map (flip C.PArg fid) ctxt)
                        Nothing  -> let !crc'   = Map.insert fids fid_cnt crc
                                        !prods' = IntMap.insert fid_cnt (Set.fromList (map C.PCoerce fids)) prods
                                    in ((fid_cnt+1,crc',prods'),map (flip C.PArg fid_cnt) ctxt)
          where
            (hargs_C,arg_C) = GM.catSkeleton ty
            ctxt = mapM (mkCtxt lindefs) hargs_C
            fids = map (mkFId arg_C) fid0s

    mkLinDefId id = prefixIdent "lindef " id

    toLinDef res offs lindefs (Production fid0 funid0 args) =
      if args == [[fidVar]]
        then IntMap.insertWith (++) fid [offs+funid0] lindefs
        else lindefs
      where
        fid = mkFId res fid0

    toLinRef res offs linrefs (Production fid0 funid0 [fargs]) =
      if fid0 == fidVar
        then foldr (\fid -> IntMap.insertWith (++) fid [offs+funid0]) linrefs fids
        else linrefs
      where
        fids = map (mkFId res) fargs

    mkFId (_,cat) fid0 =
      case Map.lookup (i2i cat) cnccats of
        Just (C.CncCat s e _) -> s+fid0
        Nothing               -> error ("GrammarToPGF.mkFId: missing category "++showIdent cat)

    mkCtxt lindefs (_,cat) =
      case Map.lookup (i2i cat) cnccats of
        Just (C.CncCat s e _) -> [(C.fidVar,fid) | fid <- [s..e], Just _ <- [IntMap.lookup fid lindefs]]
        Nothing               -> error "GrammarToPGF.mkCtxt failed"

    toCncFun offs (m,id) funs (funid0,lins0) =
      let mseqs = case lookupModule gr m of
                    Ok (ModInfo{mseqs=Just mseqs}) -> mseqs
                    _                              -> ex_seqs
      in (offs+funid0,C.CncFun (i2i id) (amap (newIndex mseqs) lins0)):funs                                          
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
  Map.fromAscList [(i2i id, name) | ((m,id),info) <- cdefs, name <- prn info]
  where
    prn (CncFun _ _   (Just (L _ tr)) _) = [flatten tr]
    prn (CncCat _ _ _ (Just (L _ tr)) _) = [flatten tr]
    prn _                                = []

    flatten (K s)      = s
    flatten (Alts x _) = flatten x
    flatten (C x y)    = flatten x +++ flatten y

--mkArray    lst = listArray (0,length lst-1) lst
mkMapArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]
mkSetArray set = listArray (0,Set.size set-1) [v | v <- Set.toList set]
