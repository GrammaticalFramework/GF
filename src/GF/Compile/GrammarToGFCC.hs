----------------------------------------------------------------------
-- |
-- Module      : CanonToGFCC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/17 14:15:17 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.15 $
--
-- GFC to GFCC compiler. AR Aug-Oct 2006
-----------------------------------------------------------------------------

module GF.Compile.GrammarToGFCC (prGrammar2gfcc) where

import GF.Grammar.Grammar
import qualified GF.Canon.GFC as GFC
import qualified GF.Grammar.Lookup as Look

import qualified GF.Canon.GFCC.AbsGFCC as C
import qualified GF.Canon.GFCC.PrintGFCC as Pr
import qualified GF.Grammar.Abstract as A
import qualified GF.Grammar.Macros as GM
import qualified GF.Infra.Modules as M
import qualified GF.Infra.Option as O

import GF.Infra.Ident
import GF.Data.Operations
import GF.Text.UTF8

import Data.List
import qualified Data.Map as Map
import Debug.Trace ----

-- the main function: generate GFCC from GFCM.

prGrammar2gfcc :: SourceModule -> String
prGrammar2gfcc = Pr.printTree . mkCanon2gfcc

mkCanon2gfcc :: SourceModule -> C.Grammar
mkCanon2gfcc = canon2gfcc . {- reorder . utf8Conv .-} canon2canon

-- This is needed to reorganize the grammar. GFCC has its own back-end optimization.
-- But we need to have the canonical order in tables, created by valOpt

-- Generate GFCC from GFCM.
-- this assumes a grammar translated by canon2canon

canon2gfcc :: SourceModule -> C.Grammar
canon2gfcc cgr@(a,M.ModMod abm) = 
     C.Grm (C.Hdr (i2i a) cs) (C.Abs adefs) cncs where
  cs  = [i2i a] ----
  adefs = [C.Fun f' (mkType ty) (C.Tr (C.AC f') []) | 
            (f,AbsFun (Yes ty) _) <- tree2list (M.jments abm), let f' = i2i f]
  cncs  = [C.Cnc (i2i a) (concr abm)]
  concr mo = cats mo ++ lindefs mo ++ 
               -----optConcrete 
                 [C.Lin (i2i f) (mkTerm tr) | 
                   (f,CncFun _ (Yes tr) _) <- tree2list (M.jments mo)]
  cats mo = [C.Lin (i2ic c) (mkCType ty) | 
                   (c,CncCat (Yes ty) _ _) <- tree2list (M.jments mo)]
  lindefs mo = [C.Lin (i2id c) (mkTerm tr) | 
                   (c,CncCat _ (Yes tr) _) <- tree2list (M.jments mo)]

i2i :: Ident -> C.CId
i2i (IC c) = C.CId c
i2ic (IC c) = C.CId ("__" ++ c) -- for lincat of category symbols
i2id (IC c) = C.CId ("_d" ++ c) -- for lindef of category symbols

mkType :: A.Type -> C.Type
mkType t = case GM.catSkeleton t of
  Ok (cs,c) -> C.Typ (map (i2i . snd) cs) (i2i $ snd c)

mkCType :: Type -> C.Term
mkCType t = case t of
  EInt i      -> C.C $ fromInteger i
  -- record parameter alias - created in gfc preprocessing
  RecType [(LIdent "_", i), (LIdent "__", t)] -> C.RP (mkCType i) (mkCType t)
  RecType rs     -> C.R [mkCType t | (_, t) <- rs]
  Table pt vt -> C.R $ replicate (getI (mkCType pt)) $ mkCType vt
  _    -> C.S [] ----- TStr
 where
  getI pt = case pt of
    C.C i -> i
    C.RP i _ -> getI i
    _ -> 1 -----

mkTerm :: Term -> C.Term
mkTerm tr = case tr of
  Vr (IA (_,i)) -> C.V i
  EInt i      -> C.C $ fromInteger i
  -- record parameter alias - created in gfc preprocessing
  R [(LIdent "_", (_,i)), (LIdent "__", (_,t))] -> C.RP (mkTerm i) (mkTerm t)
  -- ordinary record
  R rs     -> C.R [mkTerm t | (_, (_,t)) <- rs]
  P t l    -> C.P (mkTerm t) (C.C (mkLab l))

-----  LI x     -> C.BV $ i2i x
-----  T _ [(PV x, t)] -> C.L (i2i x) (mkTerm t)

  T _ cs   -> C.R [mkTerm t | (_,t) <- cs] ------
  V _ cs   -> C.R [mkTerm t | t <- cs]
  S t p    -> C.P (mkTerm t) (mkTerm p)
  C s t    -> C.S [mkTerm x | x <- [s,t]]
  FV ts    -> C.FV [mkTerm t | t <- ts]
  K s      -> C.K (C.KS s)
-----  K (KP ss _) -> C.K (C.KP ss []) ---- TODO: prefix variants
  Empty        -> C.S []
  App _ _  -> prtTrace tr $ C.C 66661          ---- for debugging
  Abs _ t -> mkTerm t ---- only on toplevel
  _ -> C.S [C.K (C.KS (A.prt tr +++ "66662"))] ---- for debugging
 where
   mkLab (LIdent l) = case l of
     '_':ds -> (read ds) :: Int
     _ -> prtTrace tr $ 66663

-- return just one module per language

reorder :: SourceGrammar -> SourceGrammar
reorder cg = M.MGrammar $ 
    (abs, M.ModMod $ 
          M.Module M.MTAbstract M.MSComplete [] [] [] adefs):
      [(c, M.ModMod $ 
          M.Module (M.MTConcrete abs) M.MSComplete [] [] [] (sorted2tree js)) 
            | (c,js) <- cncs] 
     where
       abs = maybe (error "no abstract") id $ M.greatestAbstract cg
       mos = M.allModMod cg
       adefs = 
         sorted2tree $ sortBy (\ (f,_) (g,_) -> compare f g) 
            [finfo | 
              (i,mo) <- M.allModMod cg, M.isModAbs mo, 
              finfo <- tree2list (M.jments mo)]
       cncs = sortBy (\ (x,_) (y,_) -> compare x y)
            [(lang, concr lang) | lang <- M.allConcretes cg abs]
       concr la = sortBy (\ (f,_) (g,_) -> compare f g) 
            [finfo | 
              (i,mo) <- mos, M.isModCnc mo, elem i (M.allExtends cg la),
              finfo <- tree2list (M.jments mo)]

-- one grammar per language - needed for symtab generation
repartition :: SourceGrammar -> [SourceGrammar]
repartition cg = [M.partOfGrammar cg (lang,mo) | 
  let abs = maybe (error "no abstract") id $ M.greatestAbstract cg,
  let mos = M.allModMod cg,
  lang <- M.allConcretes cg abs,
  let mo = errVal 
       (error ("no module found for " ++ A.prt lang)) $ M.lookupModule cg lang
  ]

-- convert to UTF8 if not yet converted
utf8Conv :: SourceGrammar -> SourceGrammar
utf8Conv = M.MGrammar . map toUTF8 . M.modules where
  toUTF8 mo = case mo of
    (i, M.ModMod m) 
      ----- | hasFlagCanon (flagCanon "coding" "utf8") mo -> mo
      | otherwise -> (i, M.ModMod $
          m{ M.jments = M.jments m -----
-----            mapTree (onSnd (mapInfoTerms (onTokens encodeUTF8))) (M.jments m),
	   -----  M.flags = setFlag "coding" "utf8" (M.flags m) 
           }
          )
    _ -> mo
 

-- translate tables and records to arrays, parameters and labels to indices

-----canon2canon :: SourceGrammar -> SourceGrammar
canon2canon :: SourceModule -> SourceModule
canon2canon sm = c2c sm where
    cg = M.MGrammar [sm]
-----canon2canon = recollect . map cl2cl . repartition where
-----  recollect = 
-----    M.MGrammar . nubBy (\ (i,_) (j,_) -> i==j) . concatMap M.modules
-----  cl2cl cg = tr $ M.MGrammar $ map c2c $ M.modules cg where
    c2c (c,m) = case m of
      M.ModMod mo@(M.Module _ _ _ _ _ js) ->
        (c, M.ModMod $ M.replaceJudgements mo $ mapTree j2j js)
      _ -> (c,m)
    j2j (f,j) = case j of
      CncFun x (Yes tr) z -> (f,CncFun x (Yes (t2t tr)) z)
      CncCat (Yes ty) (Yes x) y   -> (f,CncCat (Yes (ty2ty ty)) (Yes (t2t x)) y)
      _ -> (f,j)
    t2t = term2term cg pv
    ty2ty = type2type cg pv
    pv@(labels,untyps,typs) = paramValues cg
    tr = trace $
     (unlines [A.prt c ++ "." ++ unwords (map A.prt l) +++ "=" +++ show i  | 
       ((c,l),i) <- Map.toList labels]) ++
     (unlines [A.prt t +++ "=" +++ show i  | 
       (t,i) <- Map.toList untyps]) ++
     (unlines [A.prt t | 
       (t,_) <- Map.toList typs])

type ParamEnv =
  (Map.Map (Ident,[Label]) (Type,Integer), -- numbered labels
   Map.Map Term Integer,                   -- untyped terms to values
   Map.Map Type (Map.Map Term Integer))    -- types to their terms to values

--- gathers those param types that are actually used in lincats and in lin terms
paramValues :: SourceGrammar -> ParamEnv
paramValues cgr = (labels,untyps,typs) where
  params = [(ty, errVal [] $ Look.allParamValues cgr ty) | ty <- partyps]
  partyps = nub $ [ty | 
              (_,(_,CncCat (Yes (RecType ls)) _ _)) <- jments,
              ty0 <- [ty | (_, ty) <- unlockTyp ls],
              ty  <- typsFrom ty0
            ] ++ [
             Q m ty | 
              (m,(ty,ResParam _)) <- jments
            ] ++ [ty | 
              (_,(_,CncFun _ (Yes tr) _)) <- jments,
              ty  <- err (const []) snd $ appSTM (typsFromTrm tr) []
            ]
  typsFrom ty = case ty of
    Table p t  -> typsFrom p ++ typsFrom t
    RecType ls -> RecType (unlockTyp ls) : concat [typsFrom t | (_, t) <- ls]
    _ -> [ty]
 
  typsFromTrm :: Term -> STM [Type] Term
  typsFromTrm tr = case tr of
    V ty ts -> updateSTM (ty:) >> mapM_ typsFromTrm ts >> return tr
    T (TTyped ty) cs -> updateSTM (ty:) >> mapM_ typsFromTrm [t | (_, t) <- cs] >> return tr
    _ -> GM.composOp typsFromTrm tr


  jments = [(m,j) | (m,mo) <- M.allModMod cgr, j <- tree2list $ M.jments mo]
  typs = Map.fromList [(ci,Map.fromList (zip vs [0..])) | (ci,vs) <- params]
  untyps = Map.fromList $ concatMap Map.toList [typ | (_,typ) <- Map.toList typs]
  lincats = 
    [(IC cat,[(LIdent "s",GM.typeStr)]) | cat <- ["Int", "Float", "String"]] ++
    [(cat,(unlockTyp ls)) | (_,(cat,CncCat (Yes (RecType ls)) _ _)) <- jments]
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

type2type :: SourceGrammar -> ParamEnv -> Type -> Type
type2type cgr env@(labels,untyps,typs) ty = case ty of
  RecType rs ->
    let
      rs' = [(mkLab i, t2t t) | 
               (i,(l, t)) <- zip [0..] (unlockTyp rs)]
    in if (any isStrType [t | (_, t) <- rs])
      then RecType rs'
      else RecType [(LIdent "_", look ty), (LIdent "__", RecType rs')]

  Table pt vt -> Table (t2t pt) (t2t vt)
  Cn _ -> look ty
  _ -> ty
 where
   t2t = type2type cgr env
   look ty = EInt $ toInteger $ case Map.lookup ty typs of
     Just vs -> length $ Map.assocs vs
     _ -> trace ("unknown partype " ++ show ty) 1 ---- 66669

term2term :: SourceGrammar -> ParamEnv -> Term -> Term
term2term cgr env@(labels,untyps,typs) tr = case tr of
  App _ _ -> mkValCase tr 
  QC  _ _ -> mkValCase tr 
  R rs ->
    let
      rs' = [(mkLab i, (Nothing, t2t t)) | 
               (i,(l,(_,t))) <- zip [0..] (unlock rs)]
    in if (any (isStr . trmAss) rs)
      then R rs'
      else R [(LIdent "_", (Nothing, mkValCase tr)), (LIdent "__",(Nothing,R rs'))]
  P t l    -> r2r tr
  PI t l i  -> EInt $ toInteger i

-----  T ti [Cas ps@[PV _] t] -> T ti [Cas ps (t2t t)]

  T (TTyped ty) cs  -> V ty [t2t t | (_, t) <- cs]
  ----    _ -> K (KS (A.prt tr +++ prtTrace tr "66668"))
  V ty ts  -> V ty [t2t t | t <- ts]
  S t p    -> S (t2t t) (t2t p)
  _ -> GM.composSafeOp t2t tr
 where
   t2t = term2term cgr env

   r2r tr@(P (S (V ty ts) v) l) = t2t $ S (V ty [comp (P t l) | t <- ts]) v

   r2r tr@(P p _) = case getLab tr of
     Ok (cat,labs) -> P (t2t p) . mkLab $ maybe (prtTrace tr $ 66664) snd $ 
          Map.lookup (cat,labs) labels
     _ -> K ((A.prt tr +++ prtTrace tr "66665"))

   -- this goes recursively into tables (ignored) and records (accumulated)
   getLab tr = case tr of
     Vr (IA (cat, _)) -> return (identC cat,[])
     P p lab2 -> do
       (cat,labs) <- getLab p
       return (cat,labs++[lab2]) 
     S p _ -> getLab p
     _ -> Bad "getLab"

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
               _ -> error $ A.prt ty
             _ -> error $ A.prt tr
       updateSTM ((tyvs, (tr', tr)):) 
       return tr'
     _ -> GM.composOp doVar tr

   mkValCase tr = case appSTM (doVar tr) [] of
     Ok (tr', st@(_:_)) -> t2t $ comp $ foldr mkCase tr' st
     _ -> valNum tr

   mkCase ((ty,vs),(x,p)) tr = 
     S (V ty [mkBranch x v tr | v <- vs]) p
   mkBranch x t tr = case tr of
     _ | tr == x -> t
     _ -> GM.composSafeOp (mkBranch x t) tr     

   valNum tr = maybe (tryPerm tr) EInt $ Map.lookup tr untyps
    where
      tryPerm tr = case tr of
        R rs -> case Map.lookup (R rs) untyps of
	  Just v -> EInt v
          _ -> valNumFV $ tryVar tr
        _ -> valNumFV $ tryVar tr
      tryVar tr = case tr of
-----        Par c ts -> [Par c ts' | ts' <- combinations (map tryVar ts)]
        FV ts -> ts
        _ -> [tr]
      valNumFV ts = case ts of
        [tr] -> EInt 66667 ----K (KS (A.prt tr +++ prtTrace tr "66667"))
        _ -> FV $ map valNum ts
   isStr tr = case tr of
     App _ _ -> False
     EInt _  -> False
     R rs    -> any (isStr . trmAss) rs
     FV ts   -> any isStr ts
     S t _   -> isStr t
     Empty       -> True
     T _ cs  -> any isStr [v | (_, v) <- cs]
     V _ ts  -> any isStr ts
     P t r   -> case getLab tr of
       Ok (cat,labs) -> case 
          Map.lookup (cat,labs) labels of
            Just (ty,_) -> isStrType ty 
            _ -> True ---- TODO?
       _ -> True
     _ -> True ----
   trmAss (_,(_, t)) = t

   --- this is mainly needed for parameter record projections
   comp t = t ----- $ Look.ccompute cgr [] t

isStrType ty = case ty of
     Sort "Str" -> True
     RecType ts -> any isStrType [t | (_, t) <- ts]
     Table _ t -> isStrType t
     _ -> False

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


prtTrace tr n = n ----trace ("-- ERROR" +++ A.prt tr +++ show n +++ show tr) n
prTrace  tr n = trace ("-- OBSERVE" +++ A.prt tr +++ show n +++ show tr) n

-- back-end optimization: 
-- suffix analysis followed by common subexpression elimination

optConcrete :: [C.CncDef] -> [C.CncDef]
optConcrete defs = subex 
  [C.Lin f (optTerm t) | C.Lin f t <- defs]

-- analyse word form lists into prefix + suffixes
-- suffix sets can later be shared by subex elim

optTerm :: C.Term -> C.Term  
optTerm tr = case tr of
    C.R ts@(_:_:_) | all isK ts -> mkSuff $ optToks [s | C.K (C.KS s) <- ts]
    C.R ts  -> C.R $ map optTerm ts
    C.P t v -> C.P (optTerm t) v
    C.L x t -> C.L x (optTerm t)
    _ -> tr
 where
  optToks ss = prf : suffs where
    prf = pref (head ss) (tail ss)
    suffs = map (drop (length prf)) ss
    pref cand ss = case ss of
      s1:ss2 -> if isPrefixOf cand s1 then pref cand ss2 else pref (init cand) ss
      _ -> cand
  isK t = case t of
    C.K (C.KS _) -> True
    _ -> False
  mkSuff ("":ws) = C.R (map (C.K . C.KS) ws)
  mkSuff (p:ws) = C.W p (C.R (map (C.K . C.KS) ws))


-- common subexpression elimination; see ./Subexpression.hs for the idea

subex :: [C.CncDef] -> [C.CncDef]
subex js = errVal js $ do
  (tree,_) <- appSTM (getSubtermsMod js) (Map.empty,0)
  return $ addSubexpConsts tree js

type TermList = Map.Map C.Term (Int,Int) -- number of occs, id
type TermM a = STM (TermList,Int) a

addSubexpConsts :: TermList -> [C.CncDef] -> [C.CncDef]
addSubexpConsts tree lins =
  let opers = sortBy (\ (C.Lin f _) (C.Lin g _) -> compare f g)
                [C.Lin (fid id) trm | (trm,(_,id)) <- list]
  in map mkOne $ opers ++ lins
 where
   mkOne (C.Lin f trm) = (C.Lin f (recomp f trm))
   recomp f t = case Map.lookup t tree of
     Just (_,id) | fid id /= f -> C.F $ fid id -- not to replace oper itself
     _ -> case t of
       C.R ts   -> C.R $ map (recomp f) ts
       C.S ts   -> C.S $ map (recomp f) ts
       C.W s t  -> C.W s (recomp f t)
       C.P t p  -> C.P (recomp f t) (recomp f p)
       C.RP t p -> C.RP (recomp f t) (recomp f p)
       C.L x t  -> C.L x (recomp f t)
       _ -> t
   fid n = C.CId $ "_" ++ show n
   list = Map.toList tree

getSubtermsMod :: [C.CncDef] -> TermM TermList
getSubtermsMod js = do
  mapM (getInfo collectSubterms) js
  (tree0,_) <- readSTM
  return $ Map.filter (\ (nu,_) -> nu > 1) tree0
 where
   getInfo get (C.Lin f trm) = do
     get trm
     return ()

collectSubterms :: C.Term -> TermM ()
collectSubterms t = case t of
  C.R ts -> do
    mapM collectSubterms ts
    add t
  C.RP u v -> do
    collectSubterms v
    add t
  C.S ts -> do
    mapM collectSubterms ts
    add t
  C.W s u -> do
    collectSubterms u
    add t
  C.P p u -> do
    collectSubterms p
    collectSubterms u
    add t
  _ -> return ()
 where
   add t = do
     (ts,i) <- readSTM
     let 
       ((count,id),next) = case Map.lookup t ts of
         Just (nu,id) -> ((nu+1,id), i)
         _ ->            ((1,   i ), i+1)
     writeSTM (Map.insert t (count,id) ts, next)

