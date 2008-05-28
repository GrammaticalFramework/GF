{-# LANGUAGE PatternGuards #-}
module GF.Compile.GrammarToGFCC (prGrammar2gfcc,mkCanon2gfcc,addParsers) where

import GF.Compile.OptimizeGF (unshareModule)

import qualified GF.GFCC.Macros as CM
import qualified GF.GFCC.DataGFCC as C
import qualified GF.GFCC.DataGFCC as D
import GF.GFCC.CId
import GF.GFCC.PrintGFCC
import GF.Grammar.Predef
import GF.Grammar.PrGrammar
import GF.Grammar.Grammar
import qualified GF.Grammar.Lookup as Look
import qualified GF.Grammar.Abstract as A
import qualified GF.Grammar.Macros as GM
import qualified GF.Compile.Compute as Compute ---- 
import qualified GF.Infra.Modules as M
import qualified GF.Infra.Option as O

import GF.Compile.GenerateFCFG (convertConcrete)
import GF.Parsing.FCFG.PInfo (buildFCFPInfo)
import GF.Infra.Ident
import GF.Infra.Option
import GF.Data.Operations
import GF.Text.UTF8

import Data.List
import Data.Char (isDigit,isSpace)
import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS
import Debug.Trace ----

-- when developing, swap commenting

--traceD s t = trace s t 
traceD s t = t 


-- the main function: generate GFCC from GF.

prGrammar2gfcc :: Options -> String -> SourceGrammar -> (String,String)
prGrammar2gfcc opts cnc gr = (abs,printGFCC gc) where
  (abs,gc) = mkCanon2gfcc opts cnc gr 

mkCanon2gfcc :: Options -> String -> SourceGrammar -> (String,D.GFCC)
mkCanon2gfcc opts cnc gr = 
  (prIdent abs, (canon2gfcc opts pars . reorder abs . canon2canon abs) gr)
  where
    abs = err error id $ M.abstractOfConcrete gr (identC (BS.pack cnc))
    pars = mkParamLincat gr

-- Adds parsers for all concretes
addParsers :: D.GFCC -> D.GFCC
addParsers gfcc = gfcc { D.concretes = Map.map conv (D.concretes gfcc) }
  where
    conv cnc = cnc { D.parser = Just (buildFCFPInfo (convertConcrete (D.abstract gfcc) cnc)) }

-- Generate GFCC from GFCM.
-- this assumes a grammar translated by canon2canon

canon2gfcc :: Options -> (Ident -> Ident -> C.Term) -> SourceGrammar -> D.GFCC
canon2gfcc opts pars cgr@(M.MGrammar ((a,M.ModMod abm):cms)) = 
  (if dump opts DumpCanon then trace (prGrammar cgr) else id) $
     D.GFCC an cns gflags abs cncs 
 where
  -- abstract
  an  = (i2i a)
  cns = map (i2i . fst) cms
  abs = D.Abstr aflags funs cats catfuns
  gflags = Map.empty
  aflags = Map.fromList [(mkCId f,x) | (f,x) <- moduleOptionsGFO (M.flags abm)]
  mkDef pty = case pty of
    Yes t -> mkExp t
    _ -> CM.primNotion

  -- concretes
  lfuns = [(f', (mkType ty, mkDef pty)) | 
             (f,AbsFun (Yes ty) pty) <- tree2list (M.jments abm), let f' = i2i f]
  funs = Map.fromAscList lfuns
  lcats = [(i2i c, mkContext cont) |
                (c,AbsCat (Yes cont) _) <- tree2list (M.jments abm)]
  cats = Map.fromAscList lcats
  catfuns = Map.fromList 
    [(cat,[f | (f, (C.DTyp _ c _,_)) <- lfuns, c==cat]) | (cat,_) <- lcats]

  cncs  = Map.fromList [mkConcr lang (i2i lang) mo | (lang,M.ModMod mo) <- cms]
  mkConcr lang0 lang mo = 
      (lang,D.Concr flags lins opers lincats lindefs printnames params fcfg)
    where
      js = tree2list (M.jments mo)
      flags   = Map.fromList [(mkCId f,x) | (f,x) <- moduleOptionsGFO (M.flags mo)]
      opers   = Map.fromAscList [] -- opers will be created as optimization
      utf     = if moduleFlag optEncoding (moduleOptions (M.flags mo)) == UTF_8
                  then D.convertStringsInTerm decodeUTF8 else id
      lins    = Map.fromAscList 
        [(i2i f, utf (mkTerm tr))  | (f,CncFun _ (Yes tr) _) <- js]
      lincats = Map.fromAscList 
        [(i2i c, mkCType ty) | (c,CncCat (Yes ty) _ _) <- js]
      lindefs = Map.fromAscList 
        [(i2i c, mkTerm tr)  | (c,CncCat _ (Yes tr) _) <- js]
      printnames = Map.union 
        (Map.fromAscList [(i2i f, mkTerm tr) | (f,CncFun _ _ (Yes tr)) <- js])
        (Map.fromAscList [(i2i f, mkTerm tr) | (f,CncCat _ _ (Yes tr)) <- js])
      params = Map.fromAscList 
        [(i2i c, pars lang0 c) | (c,CncCat (Yes ty) _ _) <- js]
      fcfg = Nothing

i2i :: Ident -> CId
i2i = CId . ident2bs

mkType :: A.Type -> C.Type
mkType t = case GM.typeForm t of
  Ok (hyps,(_,cat),args) -> C.DTyp (mkContext hyps) (i2i cat) (map mkExp args)

mkExp :: A.Term -> C.Exp
mkExp t = case t of
  A.Eqs eqs -> C.EEq [C.Equ (map mkPatt ps) (mkExp e) | (ps,e) <- eqs]
  _ -> case GM.termForm t of
    Ok (xx,c,args) -> C.DTr [i2i x | x <- xx] (mkAt c) (map mkExp args) 
 where
  mkAt c = case c of 
    Q _ c  -> C.AC $ i2i c
    QC _ c -> C.AC $ i2i c
    Vr x   -> C.AV $ i2i x
    EInt i -> C.AI i
    EFloat f -> C.AF f
    K s    -> C.AS s
    Meta (MetaSymb i) -> C.AM $ toInteger i
    _ -> C.AM 0
  mkPatt p = uncurry CM.tree $ case p of
    A.PP _ c ps -> (C.AC (i2i c), map mkPatt ps)
    A.PV x      -> (C.AV (i2i x), [])
    A.PW        -> (C.AV wildCId, [])
    A.PInt i    -> (C.AI i, [])

mkContext :: A.Context -> [C.Hypo]
mkContext hyps = [C.Hyp (i2i x) (mkType ty) | (x,ty) <- hyps]

mkTerm :: Term -> C.Term
mkTerm tr = case tr of
  Vr (IA _ i) -> C.V i
  Vr (IAV _ _ i) -> C.V i
  Vr (IC s) | isDigit (BS.last s) -> 
    C.V ((read . BS.unpack . snd . BS.spanEnd isDigit) s)
    ---- from gf parser of gfc
  EInt i      -> C.C $ fromInteger i
  R rs     -> C.R [mkTerm t | (_, (_,t)) <- rs]
  P t l    -> C.P (mkTerm t) (C.C (mkLab l))
  TSh _ _    -> error $ show tr
  T _ cs   -> C.R [mkTerm t | (_,t) <- cs] ------
  V _ cs   -> C.R [mkTerm t | t <- cs]
  S t p    -> C.P (mkTerm t) (mkTerm p)
  C s t    -> C.S $ concatMap flats [mkTerm x | x <- [s,t]]
  FV ts    -> C.FV [mkTerm t | t <- ts]
  K s      -> C.K (C.KS s)
-----  K (KP ss _) -> C.K (C.KP ss []) ---- TODO: prefix variants
  Empty    -> C.S []
  App _ _  -> prtTrace tr $ C.C 66661          ---- for debugging
  Abs _ t  -> mkTerm t ---- only on toplevel
  Alts (td,tvs) -> 
    C.K (C.KP (strings td) [C.Var (strings u) (strings v) | (u,v) <- tvs])
  _ -> prtTrace tr $ C.S [C.K (C.KS (A.prt tr +++ "66662"))] ---- for debugging
 where
   mkLab (LIdent l) = case BS.unpack l of
     '_':ds -> (read ds) :: Int
     _ -> prtTrace tr $ 66663
   strings t = case t of
     K s -> [s]
     C u v -> strings u ++ strings v
     Strs ss -> concatMap strings ss
     _ -> prtTrace tr $ ["66660"]
   flats t = case t of
     C.S ts -> concatMap flats ts
     _ -> [t]

-- encoding GFCC-internal lincats as terms
mkCType :: Type -> C.Term
mkCType t = case t of
  EInt i      -> C.C $ fromInteger i
  RecType rs  -> C.R [mkCType t | (_, t) <- rs]
  Table pt vt -> case pt of
    EInt i -> C.R $ replicate (1 + fromInteger i) $ mkCType vt
    RecType rs -> mkCType $ foldr Table vt (map snd rs) 
  Sort s | s == cStr -> C.S [] --- Str only
  _ | Just i <- GM.isTypeInts t -> C.C $ fromInteger i
  _ -> error  $ "mkCType " ++ show t

-- encoding showable lincats (as in source gf) as terms
mkParamLincat :: SourceGrammar -> Ident -> Ident -> C.Term
mkParamLincat sgr lang cat = errVal (C.R [C.S []]) $ do 
  typ <- Look.lookupLincat sgr lang cat
  mkPType typ
 where
  mkPType typ = case typ of
    RecType lts -> do
      ts <- mapM (mkPType . snd) lts
      return $ C.R [ C.P (kks $ prt_ l) t | ((l,_),t) <- zip lts ts]
    Table (RecType lts) v -> do
      ps <- mapM (mkPType . snd) lts
      v' <- mkPType v
      return $ foldr (\p v -> C.S [p,v]) v' ps
    Table p v -> do
      p' <- mkPType p
      v' <- mkPType v
      return $ C.S [p',v']
    Sort s | s == cStr -> return $ C.S []
    _ -> return $ 
      C.FV $ map (kks . filter showable . prt_) $ 
             errVal [] $ Look.allParamValues sgr typ
  showable c = not (isSpace c) ---- || (c == ' ')  -- to eliminate \n in records
  kks = C.K . C.KS

-- return just one module per language

reorder :: Ident -> SourceGrammar -> SourceGrammar
reorder abs cg = M.MGrammar $ 
    (abs, M.ModMod $ 
          M.Module M.MTAbstract M.MSComplete aflags [] [] adefs):
      [(c, M.ModMod $ 
          M.Module (M.MTConcrete abs) M.MSComplete fs [] [] (sorted2tree js)) 
            | (c,(fs,js)) <- cncs] 
     where
       mos = M.allModMod cg
       adefs = sorted2tree $ sortIds $
                 predefADefs ++ Look.allOrigInfos cg abs
       predefADefs = 
         [(c, AbsCat (Yes []) Nope) | c <- [cFloat,cInt,cString]]
       aflags = 
         concatModuleOptions [M.flags mo | (_,mo) <- M.allModMod cg, M.isModAbs mo]

       cncs = sortIds [(lang, concr lang) | lang <- M.allConcretes cg abs]
       concr la = (flags, 
                   sortIds (predefCDefs ++ jments)) where 
         jments = Look.allOrigInfos cg la
         flags  = concatModuleOptions 
                    [M.flags mo | 
                     (i,mo) <- mos, M.isModCnc mo, 
                     Just r <- [lookup i (M.allExtendSpecs cg la)]]

         predefCDefs = 
           [(c, CncCat (Yes GM.defLinType) Nope Nope) | c <- [cInt,cFloat,cString]]

       sortIds = sortBy (\ (f,_) (g,_) -> compare f g) 


-- one grammar per language - needed for symtab generation
repartition :: Ident -> SourceGrammar -> [SourceGrammar]
repartition abs cg = [M.partOfGrammar cg (lang,mo) | 
  let mos = M.allModMod cg,
  lang <- M.allConcretes cg abs,
  let mo = errVal 
       (error ("no module found for " ++ A.prt lang)) $ M.lookupModule cg lang
  ]
 

-- translate tables and records to arrays, parameters and labels to indices

canon2canon :: Ident -> SourceGrammar -> SourceGrammar
canon2canon abs = 
   recollect . map cl2cl . repartition abs . purgeGrammar abs 
 where
  recollect = M.MGrammar . nubBy (\ (i,_) (j,_) -> i==j) . concatMap M.modules
  cl2cl = M.MGrammar . js2js . map (c2c p2p) . M.modules
    
  js2js ms = map (c2c (j2j (M.MGrammar ms))) ms

  c2c f2 (c,m) = case m of
      M.ModMod mo@(M.Module _ _ _ _ _ js) ->
        (c, M.ModMod $ M.replaceJudgements mo $ mapTree f2 js)
      _ -> (c,m)    
  j2j cg (f,j) = case j of
      CncFun x (Yes tr) z -> (f,CncFun x (Yes (trace ("+ " ++ prt f) (t2t tr))) z)
      CncCat (Yes ty) (Yes x) y -> (f,CncCat (Yes (ty2ty ty)) (Yes (t2t x)) y)
      _ -> (f,j)
   where
      t2t = term2term cg pv
      ty2ty = type2type cg pv
      pv@(labels,untyps,typs) = trs $ paramValues cg

    -- flatten record arguments of param constructors
  p2p (f,j) = case j of
      ResParam (Yes (ps,v)) -> 
        (f,ResParam (Yes ([(c,concatMap unRec cont) | (c,cont) <- ps],Nothing)))
      _ -> (f,j)
  unRec (x,ty) = case ty of
      RecType fs -> [ity | (_,typ) <- fs, ity <- unRec (identW,typ)] 
      _ -> [(x,ty)]

----
  trs v = traceD (tr v) v

  tr (labels,untyps,typs) =
     ("LABELS:" ++++
       unlines [A.prt c ++ "." ++ unwords (map A.prt l) +++ "=" +++ show i  | 
       ((c,l),i) <- Map.toList labels]) ++++
     ("UNTYPS:" ++++ unlines [A.prt t +++ "=" +++ show i | 
       (t,i) <- Map.toList untyps]) ++++
     ("TYPS:" ++++ unlines [A.prt t +++ "=" +++ show (Map.assocs i) | 
       (t,i) <- Map.toList typs])
----

purgeGrammar :: Ident -> SourceGrammar -> SourceGrammar
purgeGrammar abstr gr = 
  (M.MGrammar . list . map unopt . filter complete . purge . M.modules) gr 
 where
  list ms = traceD ("MODULES" +++ unwords (map (prt . fst) ms)) ms
  purge = nubBy (\x y -> fst x == fst y) . filter (flip elem needed . fst)
  needed = nub $ concatMap (requiredCanModules isSingle gr) acncs
  acncs = abstr : M.allConcretes gr abstr
  isSingle = True
  complete (i,M.ModMod m) = M.isCompleteModule m --- not . isIncompleteCanon
  unopt = unshareModule gr -- subexp elim undone when compiled

type ParamEnv =
  (Map.Map (Ident,[Label]) (Type,Integer), -- numbered labels
   Map.Map Term Integer,                   -- untyped terms to values
   Map.Map Type (Map.Map Term Integer))    -- types to their terms to values

--- gathers those param types that are actually used in lincats and lin terms
paramValues :: SourceGrammar -> ParamEnv
paramValues cgr = (labels,untyps,typs) where
  partyps = nub $ 
            --- [App (Q (IC "Predef") (IC "Ints")) (EInt i) | i <- [1,9]] ---linTypeInt 
            [ty | 
              (_,(_,CncCat (Yes ty0) _ _)) <- jments,
              ty  <- typsFrom ty0
            ] ++ [
             Q m ty | 
              (m,(ty,ResParam _)) <- jments
            ] ++ [ty | 
              (_,(_,CncFun _ (Yes tr) _)) <- jments,
              ty  <- err (const []) snd $ appSTM (typsFromTrm tr) []
            ]
  params = [(ty, errVal (traceD ("UNKNOWN PARAM TYPE" +++ show ty) []) $ 
                                         Look.allParamValues cgr ty) | ty <- partyps]
  typsFrom ty = unlockTy ty : case ty of
    Table p t  -> typsFrom p ++ typsFrom t
    RecType ls -> concat [typsFrom t | (_, t) <- ls]
    _ -> []
 
  typsFromTrm :: Term -> STM [Type] Term
  typsFromTrm tr = case tr of
    R fs -> mapM_ (typsFromField . snd) fs >> return tr 
      where
        typsFromField (mty, t) = case mty of
          Just x -> updateSTM (x:) >> typsFromTrm t
          _ -> typsFromTrm t
    V ty ts -> updateSTM (ty:) >> mapM_ typsFromTrm ts >> return tr
    T (TTyped ty) cs -> 
      updateSTM (ty:) >> mapM_ typsFromTrm [t | (_, t) <- cs] >> return tr
    T (TComp ty) cs -> 
      updateSTM (ty:) >> mapM_ typsFromTrm [t | (_, t) <- cs] >> return tr
    _ -> GM.composOp typsFromTrm tr

  jments = 
    [(m,j) | (m,mo) <- M.allModMod cgr, j <- tree2list $ M.jments mo]
  typs = 
    Map.fromList [(ci,Map.fromList (zip vs [0..])) | (ci,vs) <- params]
  untyps = 
    Map.fromList $ concatMap Map.toList [typ | (_,typ) <- Map.toList typs]
  lincats = 
    [(cat,[f | let RecType fs = GM.defLinType, f <- fs]) | cat <- [cInt,cFloat, cString]] ++
    reverse ---- TODO: really those lincats that are reached
            ---- reverse is enough to expel overshadowed ones... 
      [(cat,ls) | (_,(cat,CncCat (Yes ty) _ _)) <- jments, 
                  RecType ls <- [unlockTy ty]]
  labels = Map.fromList $ concat 
    [((cat,[lab]),(typ,i)): 
      [((cat,[LVar v]),(typ,toInteger (mx + v))) | v <- [0,1]] ++ ---- 1 or 2 vars 
      [((cat,[lab,lab2]),(ty,j)) | 
        rs <- getRec typ, ((lab2, ty),j) <- zip rs [0..]] 
      | 
        (cat,ls) <- lincats, ((lab, typ),i) <- zip ls [0..], let mx = length ls]
    -- go to tables recursively
    ---- TODO: even go to deeper records
   where
     getRec typ = case typ of
       RecType rs -> [rs] ---- [unlockTyp rs]  -- (sort (unlockTyp ls))
       Table _ t  -> getRec t
       _ -> []

type2type :: SourceGrammar -> ParamEnv -> Type -> Type
type2type cgr env@(labels,untyps,typs) ty = case ty of
  RecType rs ->
    RecType [(mkLab i, t2t t) | (i,(l, t)) <- zip [0..] (unlockTyp rs)]
  Table pt vt -> Table (t2t pt) (t2t vt)
  QC _ _ -> look ty
  _ -> ty
 where
   t2t = type2type cgr env
   look ty = EInt $ (+ (-1)) $ toInteger $ case Map.lookup ty typs of
     Just vs -> length $ Map.assocs vs
     _ -> trace ("unknown partype " ++ show ty) 66669

term2term :: SourceGrammar -> ParamEnv -> Term -> Term
term2term cgr env@(labels,untyps,typs) tr = case tr of
  App _ _ -> mkValCase (unrec tr)
  QC  _ _ -> mkValCase tr 
  R rs    -> R [(mkLab i, (Nothing, t2t t)) | 
                 (i,(l,(_,t))) <- zip [0..] (GM.sortRec (unlock rs))]
  P  t l   -> r2r tr
  PI t l i -> EInt $ toInteger i

  T (TWild _) _ -> error $ "wild" +++ prt tr
  T (TComp  ty) cs  -> t2t $ V ty $ map snd cs ---- should be elim'ed in tc
  T (TTyped ty) cs  -> t2t $ V ty $ map snd cs ---- should be elim'ed in tc
  V ty ts  -> mkCurry $ V ty [t2t t | t <- ts]
  S t p    -> mkCurrySel (t2t t) (t2t p)

  _ -> GM.composSafeOp t2t tr
 where
   t2t = term2term cgr env

   unrec t = case t of
     App f (R fs) -> GM.mkApp (unrec f) [unrec u | (_,(_,u)) <- fs]
     _ -> GM.composSafeOp unrec t

   mkValCase tr = case appSTM (doVar tr) [] of
     Ok (tr', st@(_:_)) -> t2t $ comp $ foldr mkCase tr' st
     _ -> valNum $ comp tr

   --- this is mainly needed for parameter record projections
   ---- was: 
   comp t = errVal t $ Compute.computeConcreteRec cgr t
   compt t = case t of
     T (TComp typ) ts  -> comp $ V typ (map (comp . snd) ts)  ---- should...
     T (TTyped typ) ts -> comp $ V typ (map (comp . snd) ts)  ---- should
     V typ ts -> V typ (map comp ts)
     S tb (FV ts) -> FV $ map (comp . S tb) ts
     S tb@(V typ ts) v0 -> err error id $ do
       let v = comp v0 
       let mv1 = Map.lookup v untyps
       case mv1 of 
         Just v1 -> return $ (comp . (ts !!) . fromInteger) v1 
         _ -> return (S (comp tb) v) 
                  
     R r -> R [(l,(ty,comp t)) | (l,(ty,t)) <- r]
     P (R r) l -> maybe t (comp . snd) $ lookup l r
     _ -> GM.composSafeOp comp t

   doVar :: Term -> STM [((Type,[Term]),(Term,Term))] Term
   doVar tr = case getLab tr of
     Ok (cat, lab) -> do
       k <- readSTM >>= return . length
       let tr' = Vr $ identC $ (BS.pack (show k)) -----

       let tyvs = case Map.lookup (cat,lab) labels of
             Just (ty,_) -> case Map.lookup ty typs of
               Just vs -> (ty,[t | 
                            (t,_) <- sortBy (\x y -> compare (snd x) (snd y)) 
                                            (Map.assocs vs)])
               _ -> error $ "doVar1" +++ A.prt ty
             _ -> error $ "doVar2" +++ A.prt tr +++ show (cat,lab) ---- debug
       updateSTM ((tyvs, (tr', tr)):) 
       return tr'
     _ -> GM.composOp doVar tr

   r2r tr@(P (S (V ty ts) v) l) = t2t $ S (V ty [comp (P t l) | t <- ts]) v

   r2r tr@(P p _) = case getLab tr of
     Ok (cat,labs) -> P (t2t p) . mkLab $ 
          maybe (prtTrace tr $ 66664) snd $ 
            Map.lookup (cat,labs) labels
     _ -> K ((A.prt tr +++ prtTrace tr "66665"))

   -- this goes recursively into tables (ignored) and records (accumulated)
   getLab tr = case tr of
     Vr (IA cat _) -> return (identC cat,[])
     Vr (IAV cat _ _) -> return (identC cat,[])
     Vr (IC s) -> return (identC cat,[]) where
       cat = BS.takeWhile (/='_') s ---- also to match IAVs; no _ in a cat tolerated
             ---- init (reverse (dropWhile (/='_') (reverse s))) ---- from gf parser
----     Vr _ -> error $ "getLab " ++ show tr
     P p lab2 -> do
       (cat,labs) <- getLab p
       return (cat,labs++[lab2]) 
     S p _ -> getLab p
     _ -> Bad "getLab"


   mkCase ((ty,vs),(x,p)) tr = 
     S (V ty [mkBranch x v tr | v <- vs]) p
   mkBranch x t tr = case tr of
     _ | tr == x -> t
     _ -> GM.composSafeOp (mkBranch x t) tr     

   valNum tr = maybe (valNumFV $ tryFV tr) EInt $ Map.lookup tr untyps
    where
      tryFV tr = case GM.appForm tr of
        (c@(QC _ _), ts) -> [GM.mkApp c ts' | ts' <- combinations (map tryFV ts)]
        (FV ts,_) -> ts
        _ -> [tr]
      valNumFV ts = case ts of
        [tr] -> error ("valNum" +++ prt tr) ----- prtTrace tr $ K "66667"
        _ -> FV $ map valNum ts

   mkCurry trm = case trm of
     V (RecType [(_,ty)]) ts -> V ty ts 
     V (RecType ((_,ty):ltys)) ts -> 
       V ty [mkCurry (V (RecType ltys) cs) | 
         cs <- chop (product (map (lengthtyp . snd) ltys)) ts] 
     _ -> trm
   lengthtyp ty = case Map.lookup ty typs of
     Just m -> length (Map.assocs m)
     _ -> error $ "length of type " ++ show ty
   chop i xs = case splitAt i xs of 
     (xs1,[])  -> [xs1]
     (xs1,xs2) -> xs1:chop i xs2


   mkCurrySel t p = S t p -- done properly in CheckGFCC


mkLab k = LIdent (BS.pack ("_" ++ show k))

-- remove lock fields; in fact, any empty records and record types
unlock = filter notlock where
  notlock (l,(_, t)) = case t of --- need not look at l
     R [] -> False
     RecType [] -> False
     _ -> True

unlockTyp = filter notlock
  
notlock (l, t) = case t of --- need not look at l
     RecType [] -> False
     _ -> True

unlockTy ty = case ty of
  RecType ls -> RecType $ GM.sortRec [(l, unlockTy t) | (l,t) <- ls, notlock (l,t)]
  _ -> GM.composSafeOp unlockTy ty


prtTrace tr n = 
  trace ("-- INTERNAL COMPILER ERROR" +++ A.prt tr ++++ show n) n
prTrace  tr n = trace ("-- OBSERVE" +++ A.prt tr +++ show n +++ show tr) n


-- | this function finds out what modules are really needed in the canonical gr.
-- its argument is typically a concrete module name
requiredCanModules :: (Ord i, Show i) => Bool -> M.MGrammar i a -> i -> [i]
requiredCanModules isSingle gr c = nub $ filter notReuse ops ++ exts where
  exts = M.allExtends gr c
  ops  = if isSingle 
         then map fst (M.modules gr) 
         else iterFix (concatMap more) $ exts
  more i = errVal [] $ do
    m <- M.lookupModMod gr i
    return $ M.extends m ++ [o | o <- map M.openedModule (M.opens m)]
  notReuse i = errVal True $ do
    m <- M.lookupModMod gr i
    return $ M.isModRes m -- to exclude reused Cnc and Abs from required
