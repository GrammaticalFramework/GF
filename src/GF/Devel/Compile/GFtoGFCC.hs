module GF.Devel.GFtoGFCC (prGrammar2gfcc,mkCanon2gfcc) where

import GF.Devel.Compile.Factorize (unshareModule)

import GF.Devel.Grammar.Grammar
import GF.Devel.Grammar.Construct
import qualified GF.Devel.Grammar.Lookup as Look

import qualified GF.Devel.Grammar.Grammar as A ----
import qualified GF.Devel.Grammar.Grammar as M ----
import qualified GF.Devel.Grammar.Macros as GM
--import qualified GF.Grammar.Compute as Compute

import GF.Devel.Grammar.PrGF
--import GF.Devel.ModDeps
import GF.Infra.Ident

import qualified GF.GFCC.Macros as CM
import qualified GF.GFCC.AbsGFCC as C
import qualified GF.GFCC.DataGFCC as D

import GF.Infra.Option ----
import GF.Data.Operations
import GF.Text.UTF8

import Data.List
import Data.Char (isDigit,isSpace)
import qualified Data.Map as Map
import Debug.Trace ----

-- the main function: generate GFCC from GF.

prGrammar2gfcc :: Options -> String -> GF -> (String,String)
prGrammar2gfcc opts cnc gr = (abs, D.printGFCC gc) where
  (abs,gc) = mkCanon2gfcc opts cnc gr 

mkCanon2gfcc :: Options -> String -> GF -> (String,D.GFCC)
mkCanon2gfcc opts cnc gr = 
  (prIdent abs, (canon2gfcc opts pars . reorder abs . canon2canon abs) gr)
  where
    abs = err error id $ Look.abstractOfConcrete gr (identC cnc)
    pars = mkParamLincat gr

-- Generate GFCC from GFCM.
-- this assumes a grammar translated by canon2canon

canon2gfcc :: Options -> (Ident -> Ident -> C.Term) -> GF -> D.GFCC
canon2gfcc opts pars cgr =  
  (if (oElem (iOpt "show_canon") opts) then trace (prt cgr) else id) $
     D.GFCC an cns gflags abs cncs 
 where
  -- recognize abstract and concretes
  ([(a,abm)],cms) = 
    partition ((== MTAbstract) . mtype . snd) (Map.toList (gfmodules cgr))

  -- abstract
  an  = (i2i a)
  cns = map (i2i . fst) cms
  abs = D.Abstr aflags funs cats catfuns
  gflags = Map.fromList [(C.CId fg,x) | Just x <- [getOptVal opts (aOpt fg)]] 
                                          where fg = "firstlang"
  aflags = Map.fromList [(C.CId f,x) | (IC f,x) <- Map.toList (M.mflags abm)]
  mkDef pty = case pty of
    Meta _ -> CM.primNotion
    t -> mkExp t

  funs = Map.fromAscList lfuns
  cats = Map.fromAscList lcats

  lfuns = [(i2i f, (mkType (jtype ju), mkDef (jdef ju))) | 
                      (f,ju) <- listJudgements abm, jform ju == JFun]
  lcats = [(i2i c, mkContext (GM.contextOfType (jtype ju))) |
                      (c,ju) <- listJudgements abm, jform ju == JCat]
  catfuns = Map.fromList 
    [(cat,[f | (f, (C.DTyp _ c _,_)) <- lfuns, c==cat]) | (cat,_) <- lcats]

  -- concretes
  cncs  = Map.fromList [mkConcr lang (i2i lang) mo | (lang,mo) <- cms]
  mkConcr lang0 lang mo = 
      (lang,D.Concr flags lins opers lincats lindefs printnames params)
    where
      js = listJudgements mo
      flags = Map.fromList [(C.CId f,x) | (IC f,x) <- Map.toList (M.mflags mo)]
      opers = Map.fromAscList [] -- opers will be created as optimization
      utf   = if elem (IC "coding","utf8") (Map.assocs (M.mflags mo)) ---- 
                  then D.convertStringsInTerm decodeUTF8 else id
      lins    = Map.fromAscList 
        [(i2i f, utf (mkTerm (jdef ju))) | (f,ju) <- js, jform ju == JLin]
      lincats = Map.fromAscList 
        [(i2i c, utf (mkTerm (jtype ju))) | (c,ju) <- js, jform ju == JLincat]
      lindefs = Map.fromAscList 
        [(i2i c, utf (mkTerm (jdef ju))) | (c,ju) <- js, jform ju == JLincat]
      printnames = Map.fromAscList 
        [(i2i c, utf (mkTerm (jprintname ju))) | 
                     (c,ju) <- js, elem (jform ju) [JLincat,JLin]]
      params = Map.fromAscList 
        [(i2i c, pars lang0 c) | (c,ju) <- js, jform ju == JLincat] ---- c ??

i2i :: Ident -> C.CId
i2i = C.CId . prIdent

mkType :: A.Type -> C.Type
mkType t = case GM.typeForm t of
  (hyps,(Q _ cat),args) -> C.DTyp (mkContext hyps) (i2i cat) (map mkExp args)

mkExp :: A.Term -> C.Exp
mkExp t = case t of
  A.Eqs eqs -> C.EEq [C.Equ (map mkPatt ps) (mkExp e) | (ps,e) <- eqs]
  _ -> case GM.termForm t of
    (xx,c,args) -> C.DTr [i2i x | x <- xx] (mkAt c) (map mkExp args) 
 where
  mkAt c = case c of 
    Q _ c  -> C.AC $ i2i c
    QC _ c -> C.AC $ i2i c
    Vr x   -> C.AV $ i2i x
    EInt i -> C.AI i
    EFloat f -> C.AF f
    K s    -> C.AS s
    Meta i -> C.AM $ toInteger i
    _ -> C.AM 0
  mkPatt p = uncurry CM.tree $ case p of
    A.PP _ c ps -> (C.AC (i2i c), map mkPatt ps)
    A.PV x      -> (C.AV (i2i x), [])
    A.PW        -> (C.AV CM.wildCId, [])
    A.PInt i    -> (C.AI i, [])

mkContext :: A.Context -> [C.Hypo]
mkContext hyps = [C.Hyp (i2i x) (mkType ty) | (x,ty) <- hyps]

mkTerm :: Term -> C.Term
mkTerm tr = case tr of
  Vr (IA (_,i)) -> C.V i
  Vr (IC s) | isDigit (last s) -> 
    C.V (read (reverse (takeWhile (/='_') (reverse s)))) 
    ---- from gf parser of gfc
  EInt i      -> C.C $ fromInteger i
  R rs     -> C.R [mkTerm t | (_, (_,t)) <- rs]
  P t l    -> C.P (mkTerm t) (C.C (mkLab l))
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
  _ -> prtTrace tr $ C.S [C.K (C.KS (prt tr +++ "66662"))] ---- for debugging
 where
   mkLab (LIdent l) = case l of
     '_':ds -> (read ds) :: Int
     _ -> prtTrace tr $ 66663
   strings t = case t of
     K s -> [s]
     C u v -> strings u ++ strings v
     FV ss -> concatMap strings ss
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
  Sort "Str"        -> C.S [] --- Str only
  App (Q (IC "Predef") (IC "Ints")) (EInt i) -> C.C $ fromInteger i
  _ -> error  $ "mkCType " ++ show t

-- encoding showable lincats (as in source gf) as terms
mkParamLincat :: GF -> Ident -> Ident -> C.Term
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
    Sort "Str" -> return $ C.S []
    _ -> return $ 
      C.FV $ map (kks . filter showable . prt_) $ 
             errVal [] $ Look.allParamValues sgr typ
  showable c = not (isSpace c) ---- || (c == ' ')  -- to eliminate \n in records
  kks = C.K . C.KS

-- return just one module per language

reorder :: Ident -> GF -> GF
reorder abs cg = emptyGF {
  gfabsname = Just abs,
  gfcncnames = (map fst cncs),
  gfmodules = Map.fromList ((abs,absm) : map mkCnc cncs)
  } 
 where
    absm = emptyModule {
      mtype = MTAbstract,
      mflags = aflags,
      mjments = adefs
      }
    mkCnc (c,cnc) = (c,emptyModule {
      mtype = MTConcrete abs,
      mflags = fst cnc,
      mjments = snd cnc
      })
       
    mos = Map.toList $ gfmodules cg
       
    adefs = Map.fromAscList $ sortIds $
                 predefADefs ++ Look.allOrigJudgements cg abs
    predefADefs = 
      [(IC c, absCat []) | c <- ["Float","Int","String"]]
    aflags = Map.fromList $ nubByFst $ concat 
      [Map.toList (M.mflags mo) | (_,mo) <- mos, mtype mo == MTAbstract] ----toom

    cncs = sortIds [(lang, concr lang) | lang <- Look.allConcretes cg abs]
    concr la = (
      Map.fromList (nubByFst flags), 
      Map.fromList (sortIds (predefCDefs ++ jments))
      ) where 
        jments = Look.allOrigJudgements cg la
        flags  = Look.lookupFlags cg la
                  ----concat [M.mflags mo | 
                  ----  (i,mo) <- mos, M.isModCnc mo, 
                  ----  Just r <- [lookup i (M.allExtendSpecs cg la)]]

    predefCDefs = [(IC c, cncCat GM.defLinType) | 
                       ---- lindef,printname 
                         c <- ["Float","Int","String"]]

    sortIds = sortBy (\ (f,_) (g,_) -> compare f g) 
    
nubByFst = nubBy (\ (f,_) (g,_) -> f == g)


-- one grammar per language - needed for symtab generation
repartition :: Ident -> GF -> [GF]
repartition abs cg = [Look.partOfGrammar cg (lang,mo) | 
  let mos = gfmodules cg,
  lang   <- Look.allConcretes cg abs,
  let mo = errVal 
       (error ("no module found for " ++ prt lang)) $ Look.lookupModule cg lang
  ]
 

-- translate tables and records to arrays, parameters and labels to indices

canon2canon :: Ident -> GF -> GF
canon2canon abs gf = errVal gf $ GM.termOpGF t2t gf where
  t2t = return . term2term gf pv
  ty2ty = type2type gf pv
  pv@(labels,untyps,typs) = paramValues gf
  ---- should be done lang for lang
  ---- ty2ty should be used for types, t2t only in concrete

{- ----
  gfModules . nubModules . map cl2cl . repartition abs . purgeGrammar abs  
 where    
  nubModules = Map.fromList . nubByFst . concatMap (Map.toList . gfmodules)

  cl2cl gf = errVal gf $ GM.moduleOpGF (js2js . map (GM.judgementOpModule p2p)) gf
    
  js2js ms = map (GM.judgementOpModule (j2j (gfModules ms))) ms

  j2j cg (f,j) = case jform j of
    JLin -> (f, j{jdef = t2t (jdef j)})
    JLincat -> (f, j{jdef = t2t (jdef j), jtype = ty2ty (jtype j)})
    _ -> (f,j)
   where
      t2t = term2term cg pv
      ty2ty = type2type cg pv
      pv@(labels,untyps,typs) = paramValues cg ---trs $ paramValues cg

    -- flatten record arguments of param constructors
  p2p (f,j) = case jform j of
    ---- JParam ->
      ----ResParam (Yes (ps,v)) -> 
      ----(f,ResParam (Yes ([(c,concatMap unRec cont) | (c,cont) <- ps],Nothing)))
    _ -> (f,j)
  unRec (x,ty) = case ty of
      RecType fs -> [ity | (_,typ) <- fs, ity <- unRec (identW,typ)] 
      _ -> [(x,ty)]

----
  trs v = trace (tr v) v

  tr (labels,untyps,typs) =
     ("labels:" ++++
       unlines [prt c ++ "." ++ unwords (map prt l) +++ "=" +++ show i  | 
       ((c,l),i) <- Map.toList labels]) ++
     ("untyps:" ++++ unlines [prt t +++ "=" +++ show i  | 
       (t,i) <- Map.toList untyps]) ++
     ("typs:" ++++ unlines [prt t | 
       (t,_) <- Map.toList typs])
----
-}

purgeGrammar :: Ident -> GF -> GF
purgeGrammar abstr gr = gr {
  gfmodules = treat gr
  }
 where
  treat = 
    Map.fromList . map unopt . filter complete . purge . Map.toList . gfmodules
  purge = nubBy (\x y -> fst x == fst y) . filter (flip elem needed . fst)
  needed = 
     nub $ concatMap (Look.allDepsModule gr) $ 
           ---- (requiredCanModules True gr) $
           [mo | m <- abstr : Look.allConcretes gr abstr, 
                 Ok mo <- [Look.lookupModule gr m]]

  complete (i,mo) = isCompleteModule mo
  unopt = unshareModule gr -- subexp elim undone when compiled

type ParamEnv =
  (Map.Map (Ident,[Label]) (Type,Integer), -- numbered labels
   Map.Map Term Integer,                   -- untyped terms to values
   Map.Map Type (Map.Map Term Integer))    -- types to their terms to values

--- gathers those param types that are actually used in lincats and lin terms
paramValues :: GF -> ParamEnv
paramValues cgr = (labels,untyps,typs) where

  jments = [(m,j) | 
    (m,mo) <- Map.toList (gfmodules cgr), 
    j <- Map.toList (mjments mo)]

  partyps = nub $ [ty | 
    (_,(_,ju)) <- jments,
    jform ju == JLincat,
    RecType ls <- [jtype ju],
    ty0 <- [ty | (_, ty) <- unlockTyp ls],
    ty  <- typsFrom ty0
   ] ++ [Q m ty | 
    (m,(ty,ju)) <- jments,
    jform ju == JParam
   ] ++ [ty | 
    (_,(_,ju)) <- jments,
    jform ju == JLin,
    ty  <- err (const []) snd $ appSTM (typsFromTrm (jdef ju)) []
   ]
  params = [(ty, errVal [] $ Look.allParamValues cgr ty) | ty <- partyps]
  typsFrom ty = case ty of
    Table p t  -> typsFrom p ++ typsFrom t
    RecType ls -> RecType (sort (unlockTyp ls)) : concat [typsFrom t | (_, t) <- ls]
    _ -> [ty]
 
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

  typs = 
    Map.fromList [(ci,Map.fromList (zip vs [0..])) | (ci,vs) <- params]
  untyps = 
    Map.fromList $ concatMap Map.toList [typ | (_,typ) <- Map.toList typs]
  lincats = 
    [(IC cat,[(LIdent "s",typeStr)]) | cat <- ["Int", "Float", "String"]] ++
    reverse ---- TODO: really those lincats that are reached
            ---- reverse is enough to expel overshadowed ones... 
      [(cat,(unlockTyp ls)) |
        (_,(cat,ju)) <- jments,
        jform ju == JLincat,
        RecType ls <- [jtype ju]
       ] 
  labels = Map.fromList $ concat 
    [((cat,[lab]),(typ,i)): 
      [((cat,[lab,lab2]),(ty,j)) | 
        rs <- getRec typ, ((lab2, ty),j) <- zip rs [0..]] 
      | 
        (cat,ls) <- lincats, ((lab, typ),i) <- zip ls [0..]]
    -- go to tables recursively
    ---- TODO: even go to deeper records
   where
     getRec typ = case typ of
       RecType rs -> [rs]
       Table _ t  -> getRec t
       _ -> []

type2type :: GF -> ParamEnv -> Type -> Type
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

term2term :: GF -> ParamEnv -> Term -> Term
term2term cgr env@(labels,untyps,typs) tr = case tr of
  App _ _ -> mkValCase (unrec tr)
  QC  _ _ -> mkValCase tr 
  R rs    -> R [(mkLab i, (Nothing, t2t t)) | 
                 (i,(l,(_,t))) <- zip [0..] (sort (unlock rs))]
  P  t l   -> r2r tr
  PI t l i -> EInt $ toInteger i
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
   ---- was: errVal t $ Compute.computeConcreteRec cgr t
   comp t = case t of
     T (TComp typ) ts  -> comp $ V typ (map (comp . snd) ts)  ---- should...
     T (TTyped typ) ts -> comp $ V typ (map (comp . snd) ts)  ---- should
     V typ ts -> V typ (map comp ts)
     S (V typ ts) v0 -> err error id $ do
       let v = comp v0 
       return $ maybe t (comp . (ts !!) . fromInteger) $ Map.lookup v untyps
     R r -> R [(l,(ty,comp t)) | (l,(ty,t)) <- r]
     P (R r) l -> maybe t (comp . snd) $ lookup l r
     _ -> GM.composSafeOp comp t

   doVar :: Term -> STM [((Type,[Term]),(Term,Term))] Term
   doVar tr = case getLab tr of
     Ok (cat, lab) -> do
       k <- readSTM >>= return . length
       let tr' = Vr $ identC $ show k -----

       let tyvs = case Map.lookup (cat,lab) labels of
             Just (ty,_) -> case Map.lookup ty typs of
               Just vs -> (ty,[t | 
                            (t,_) <- sortBy (\x y -> compare (snd x) (snd y)) 
                                            (Map.assocs vs)])
               _ -> error $ prt ty
             _ -> error $ prt tr
       updateSTM ((tyvs, (tr', tr)):) 
       return tr'
     _ -> GM.composOp doVar tr

   r2r tr@(P (S (V ty ts) v) l) = t2t $ S (V ty [comp (P t l) | t <- ts]) v

   r2r tr@(P p _) = case getLab tr of
     Ok (cat,labs) -> P (t2t p) . mkLab $ maybe (prtTrace tr $ 66664) snd $ 
          Map.lookup (cat,labs) labels
     _ -> K ((prt tr +++ prtTrace tr "66665"))

   -- this goes recursively into tables (ignored) and records (accumulated)
   getLab tr = case tr of
     Vr (IA (cat, _)) -> return (identC cat,[])
     Vr (IC s) -> return (identC cat,[]) where
       cat = init (reverse (dropWhile (/='_') (reverse s))) ---- from gf parser
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
        [tr] -> trace (unwords (map prt (Map.keys typs))) $ 
                  prtTrace tr $ K "66667"
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


mkLab k = LIdent (("_" ++ show k))

-- remove lock fields; in fact, any empty records and record types
unlock = filter notlock where
  notlock (l,(_, t)) = case t of --- need not look at l
     R [] -> False
     _ -> True
unlockTyp = filter notlock where
  notlock (l, t) = case t of --- need not look at l
     RecType [] -> False
     _ -> True

prtTrace tr n = 
  trace ("-- INTERNAL COMPILER ERROR" +++ prt tr ++++ show n) n
prTrace  tr n = trace ("-- OBSERVE" +++ prt tr +++ show n +++ show tr) n

