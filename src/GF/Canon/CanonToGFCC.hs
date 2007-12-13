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

module GF.Canon.CanonToGFCC (
  prCanon2gfcc, mkCanon2gfcc, mkCanon2gfccNoUTF8) where

import GF.Canon.AbsGFC
import qualified GF.Canon.GFC as GFC
import qualified GF.Canon.Look as Look
import qualified GF.Canon.Subexpressions as Sub

import qualified GF.GFCC.Macros as CM
import GF.GFCC.Raw.AbsGFCCRaw (CId (..))
import qualified GF.GFCC.DataGFCC as C
import qualified GF.GFCC.DataGFCC as D
import GF.Devel.PrintGFCC
import GF.GFCC.OptimizeGFCC

import GF.Canon.GFC
import GF.Canon.Share
import qualified GF.Grammar.Abstract as A
import qualified GF.Grammar.Macros as GM
import GF.Canon.MkGFC
import GF.Canon.CMacros
import qualified GF.Infra.Modules as M
import qualified GF.Infra.Option as O
import GF.UseGrammar.Linear (expandLinTables, unoptimizeCanon)

import GF.Infra.Ident
import GF.Data.Operations
import GF.Text.UTF8

import Data.List
import qualified Data.Map as Map
import Debug.Trace ----

-- the main function: generate GFCC from GFCM.

prCanon2gfcc :: CanonGrammar -> String
prCanon2gfcc = printGFCC . mkCanon2gfcc

-- this variant makes utf8 conversion; used in back ends
mkCanon2gfcc :: CanonGrammar -> D.GFCC
mkCanon2gfcc = 
-- canon2gfcc . reorder abs . utf8Conv . canon2canon abs
  optGFCC . canon2gfcc . reorder . utf8Conv . canon2canon . normalize

-- this variant makes no utf8 conversion; used in ShellState
mkCanon2gfccNoUTF8 :: CanonGrammar -> D.GFCC
mkCanon2gfccNoUTF8 = optGFCC . canon2gfcc . reorder . canon2canon . normalize

-- This is needed to reorganize the grammar. 
-- GFCC has its own back-end optimization.
-- But we need to have the canonical order in tables, created by valOpt
normalize :: CanonGrammar -> CanonGrammar
normalize = share . unoptimizeCanon . Sub.unSubelimCanon where
  share = M.MGrammar . map (shareModule valOpt) . M.modules --- allOpt

-- Generate GFCC from GFCM.
-- this assumes a grammar normalized and transformed by canon2canon

canon2gfcc :: CanonGrammar -> D.GFCC
canon2gfcc cgr@(M.MGrammar ((a,M.ModMod abm):cms)) = 
     D.GFCC an cns Map.empty abs cncs 
 where
  an  = (i2i a)
  cns = map (i2i . fst) cms
  abs = D.Abstr aflags funs cats catfuns
  aflags = Map.fromAscList [] ---- flags
  lfuns = [(f', (mkType ty,CM.primNotion)) | ---- defs 
             (f,GFC.AbsFun ty _) <- tree2list (M.jments abm), let f' = i2i f]
  funs = Map.fromAscList lfuns
  lcats = [(i2i c,[]) | ---- context
            (c,GFC.AbsCat _ _) <- tree2list (M.jments abm)]
  cats = Map.fromAscList lcats
  catfuns = Map.fromAscList 
    [(cat,[f | (f, (C.DTyp _ c _,_)) <- lfuns, c==cat]) | (cat,_) <- lcats]

  cncs  = Map.fromList [mkConcr (i2i lang) mo | (lang,M.ModMod mo) <- cms]
  mkConcr lang mo = (lang,D.Concr flags lins opers lincats lindefs printnames params)
    where
      flags   = Map.fromAscList [] ---- flags
      opers   = Map.fromAscList [] -- opers will be created as optimization
      lins    = Map.fromAscList 
        [(i2i f, mkTerm tr) | (f,GFC.CncFun _ _ tr _) <- tree2list (M.jments mo)]
      lincats = Map.fromAscList 
        [(i2i c, mkCType ty) | (c,GFC.CncCat ty _ _) <- tree2list (M.jments mo)]
      lindefs = Map.fromAscList 
        [(i2i c, mkTerm tr) | (c,GFC.CncCat _ tr _) <- tree2list (M.jments mo)]
      printnames = Map.fromAscList [] ---- printnames
      params = Map.fromAscList [] ---- params

i2i :: Ident -> CId
i2i (IC c) = CId c

mkType :: A.Type -> C.Type
mkType t = case GM.catSkeleton t of
  Ok (cs,c) -> CM.cftype (map (i2i . snd) cs) (i2i $ snd c)

mkCType :: CType -> C.Term
mkCType t = case t of
  TInts i      -> C.C $ fromInteger i
  -- record parameter alias - created in gfc preprocessing
  RecType [Lbg (L (IC "_")) i, Lbg (L (IC "__")) t] -> C.RP (mkCType i) (mkCType t)
  RecType rs  -> C.R [mkCType t | Lbg _ t <- rs]
  Table pt vt -> C.R $ replicate (getI (mkCType pt)) $ mkCType vt
  TStr     -> C.S []
 where
  getI pt = case pt of
    C.C i -> i + 1
    C.RP i _ -> getI i

mkTerm :: Term -> C.Term
mkTerm tr = case tr of
  Arg (A _ i) -> C.V $ fromInteger i
  EInt i      -> C.C $ fromInteger i
  -- record parameter alias - created in gfc preprocessing
  R [Ass (L (IC "_")) i, Ass (L (IC "__")) t] -> C.RP (mkTerm i) (mkTerm t)
  -- ordinary record
  R rs     -> C.R [mkTerm t | Ass _ t <- rs]
  P t l    -> C.P (mkTerm t) (C.C (mkLab l))

  T _ cs   -> error $ "improper optimization for gfcc in" +++ A.prt tr
  V _ cs   -> C.R [mkTerm t | t <- cs]
  S t p    -> C.P (mkTerm t) (mkTerm p)
  C s t    -> C.S [mkTerm x | x <- [s,t]]
  FV ts    -> C.FV [mkTerm t | t <- ts]
  K (KS s) -> C.K (C.KS s)
  K (KP ss _) -> C.K (C.KP ss []) ---- TODO: prefix variants
  E        -> C.S []
  Par _ _  -> prtTrace tr $ C.C 66661          ---- for debugging
  _ -> C.S [C.K (C.KS (A.prt tr +++ "66662"))] ---- for debugging
 where
   mkLab (L (IC l)) = case l of
     '_':ds -> (read ds) :: Int
     _ -> prtTrace tr $ 66663

-- return just one module per language

reorder :: CanonGrammar -> CanonGrammar
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
repartition :: CanonGrammar -> [CanonGrammar]
repartition cg = [M.partOfGrammar cg (lang,mo) | 
  let abs = maybe (error "no abstract") id $ M.greatestAbstract cg,
  let mos = M.allModMod cg,
  lang <- M.allConcretes cg abs,
  let mo = errVal 
       (error ("no module found for " ++ A.prt lang)) $ M.lookupModule cg lang
  ]

-- convert to UTF8 if not yet converted
utf8Conv :: CanonGrammar -> CanonGrammar
utf8Conv = M.MGrammar . map toUTF8 . M.modules where
  toUTF8 mo = case mo of
    (i, M.ModMod m) 
      | hasFlagCanon (flagCanon "coding" "utf8") mo -> mo
      | otherwise -> (i, M.ModMod $
          m{ M.jments = 
              mapTree (onSnd (mapInfoTerms (onTokens encodeUTF8))) (M.jments m),
	     M.flags = setFlag "coding" "utf8" (M.flags m) }
          )
    _ -> mo
 

-- translate tables and records to arrays, parameters and labels to indices

canon2canon :: CanonGrammar -> CanonGrammar
canon2canon = recollect . map cl2cl . repartition where
  recollect = 
    M.MGrammar . nubBy (\ (i,_) (j,_) -> i==j) . concatMap M.modules
  cl2cl cg = {-tr $-} M.MGrammar $ map c2c $ M.modules cg where
    c2c (c,m) = case m of
      M.ModMod mo@(M.Module _ _ _ _ _ js) ->
        (c, M.ModMod $ M.replaceJudgements mo $ mapTree j2j js)
      _ -> (c,m)
    j2j (f,j) = case j of
      GFC.CncFun x y tr z -> (f,GFC.CncFun x y (t2t tr) z)
      GFC.CncCat ty x y   -> (f,GFC.CncCat (ty2ty ty) (t2t x) y)
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
  (Map.Map (Ident,[Label]) (CType,Integer), -- numbered labels
   Map.Map Term Integer,                    -- untyped terms to values
   Map.Map CType (Map.Map Term Integer))    -- types to their terms to values

--- gathers those param types that are actually used in lincats and in lin terms
paramValues :: CanonGrammar -> ParamEnv
paramValues cgr = (labels,untyps,typs) where
  params = [(ty, errVal [] $ Look.allParamValues cgr ty) | ty <- partyps]
  partyps = nub $ [ty | 
              (_,(_,CncCat (RecType ls) _ _)) <- jments,
              ty0 <- [ty | Lbg _ ty <- unlockTyp ls],
              ty  <- typsFrom ty0
            ] ++ [
             Cn (CIQ m ty) | 
              (m,(ty,ResPar _)) <- jments
            ] ++ [ty | 
              (_,(_,CncFun _ _ tr _)) <- jments,
              ty  <- err (const []) snd $ appSTM (typsFromTrm tr) []
            ]
  typsFrom ty = case ty of
    Table p t  -> typsFrom p ++ typsFrom t
    RecType ls -> RecType (unlockTyp ls) : concat [typsFrom t | Lbg _ t <- ls]
    _ -> [ty]
 
  typsFromTrm :: Term -> STM [CType] Term
  typsFromTrm tr = case tr of
    V ty ts -> updateSTM (ty:) >> mapM_ typsFromTrm ts >> return tr
    T ty cs -> updateSTM (ty:) >> mapM_ typsFromTrm [t | Cas _ t <- cs] >> return tr
    _ -> composOp typsFromTrm tr


  jments = [(m,j) | (m,mo) <- M.allModMod cgr, j <- tree2list $ M.jments mo]
  typs = Map.fromList [(ci,Map.fromList (zip vs [0..])) | (ci,vs) <- params]
  untyps = Map.fromList $ concatMap Map.toList [typ | (_,typ) <- Map.toList typs]
  lincats = 
    [(IC cat,[Lbg (L (IC "s")) TStr]) | cat <- ["Int", "Float", "String"]] ++
    [(cat,(unlockTyp ls)) | (_,(cat,CncCat (RecType ls) _ _)) <- jments]
  labels = Map.fromList $ concat 
    [((cat,[lab]),(typ,i)): 
      [((cat,[lab,lab2]),(ty,j)) | 
        rs <- getRec typ, (Lbg lab2 ty,j) <- zip rs [0..]] 
      | 
        (cat,ls) <- lincats, (Lbg lab typ,i) <- zip ls [0..]]
    -- go to tables recursively
    ---- TODO: even go to deeper records
   where
     getRec typ = case typ of
       RecType rs -> [rs]
       Table _ t  -> getRec t
       _ -> []

type2type :: CanonGrammar -> ParamEnv -> CType -> CType
type2type cgr env@(labels,untyps,typs) ty = case ty of
  RecType rs ->
    let
      rs' = [Lbg (mkLab i) (t2t t) | 
               (i,Lbg l t) <- zip [0..] (unlockTyp rs)]
    in if (any isStrType [t | Lbg _ t <- rs])
      then RecType rs'
      else RecType [Lbg (L (IC "_")) (look ty), Lbg (L (IC "__")) (RecType rs')]

  Table pt vt -> Table (t2t pt) (t2t vt)
  Cn _ -> look ty
  _ -> ty
 where
   t2t = type2type cgr env
   look ty = TInts $ (+ (-1)) $ toInteger $ case Map.lookup ty typs of
     Just vs -> length $ Map.assocs vs
     _ -> trace ("unknown partype " ++ show ty) 1 ---- 66669

term2term :: CanonGrammar -> ParamEnv -> Term -> Term
term2term cgr env@(labels,untyps,typs) tr = case tr of
  Par _ _ -> mkValCase tr 
  R rs ->
    let
      rs' = [Ass (mkLab i) (t2t t) | 
               (i,Ass l t) <- zip [0..] (unlock rs)]
    in if (any (isStr . trmAss) rs)
      then R rs'
      else R [Ass (L (IC "_")) (mkValCase tr), Ass (L (IC "__")) (R rs')]
  P t l    -> r2r tr

  T ti [Cas ps@[PV _] t] -> T ti [Cas ps (t2t t)]

  T _ cs0  -> case expandLinTables cgr tr of  -- normalize order of cases
    Ok (T ty cs) -> checkCases cs $ V ty [t2t t | Cas _ t <- cs]
    _ -> K (KS (A.prt tr +++ prtTrace tr "66668"))
  V ty ts  -> V ty [t2t t | t <- ts]
  S t p    -> S (t2t t) (t2t p)
  _ -> composSafeOp t2t tr
 where
   t2t = term2term cgr env

   checkCases cs a = 
     if null [() | Cas (_:_:_) _ <- cs] -- no share option active
       then a
       else error $ "Share optimization illegal for gfcc in" +++ A.prt tr ++++
         "Recompile with -optimize=(values | none | subs | all_subs)."

   r2r tr@(P (S (V ty ts) v) l) = t2t $ S (V ty [comp (P t l) | t <- ts]) v

   r2r tr@(P p _) = case getLab tr of
     Ok (cat,labs) -> P (t2t p) . mkLab $ maybe (prtTrace tr $ 66664) snd $ 
          Map.lookup (cat,labs) labels
     _ -> K (KS (A.prt tr +++ prtTrace tr "66665"))

   -- this goes recursively into tables (ignored) and records (accumulated)
   getLab tr = case tr of
     Arg (A cat _) -> return (cat,[])
     P p lab2 -> do
       (cat,labs) <- getLab p
       return (cat,labs++[lab2]) 
     S p _ -> getLab p
     _ -> Bad "getLab"

   doVar :: Term -> STM [((CType,[Term]),(Term,Term))] Term
   doVar tr = case getLab tr of
     Ok (cat, lab) -> do
       k <- readSTM >>= return . length
       let tr' = LI $ identC $ show k

       let tyvs = case Map.lookup (cat,lab) labels of
             Just (ty,_) -> case Map.lookup ty typs of
               Just vs -> (ty,[t | 
                            (t,_) <- sortBy (\x y -> compare (snd x) (snd y)) 
                                            (Map.assocs vs)])
               _ -> error $ A.prt ty
             _ -> error $ A.prt tr
       updateSTM ((tyvs, (tr', tr)):) 
       return tr'
     _ -> composOp doVar tr

   mkValCase tr = case appSTM (doVar tr) [] of
     Ok (tr', st@(_:_)) -> t2t $ comp $ foldr mkCase tr' st
     _ -> valNum tr

   mkCase ((ty,vs),(x,p)) tr = 
     S (V ty [mkBranch x v tr | v <- vs]) p
   mkBranch x t tr = case tr of
     _ | tr == x -> t
     _ -> composSafeOp (mkBranch x t) tr     

   valNum tr = maybe (tryPerm tr) EInt $ Map.lookup tr untyps
    where
      tryPerm tr = case tr of
        R rs -> case Map.lookup (R rs) untyps of
	  Just v -> EInt v
          _ -> valNumFV $ tryVar tr
        _ -> valNumFV $ tryVar tr
      tryVar tr = case tr of
        Par c ts -> [Par c ts' | ts' <- combinations (map tryVar ts)]
        FV ts -> ts
        _ -> [tr]
      valNumFV ts = case ts of
        [tr] -> EInt 66667 ----K (KS (A.prt tr +++ prtTrace tr "66667"))
        _ -> FV $ map valNum ts
   isStr tr = case tr of
     Par _ _ -> False
     EInt _  -> False
     R rs    -> any (isStr . trmAss) rs
     FV ts   -> any isStr ts
     S t _   -> isStr t
     E       -> True
     T _ cs  -> any isStr [v | Cas _ v <- cs]
     V _ ts  -> any isStr ts
     P t r   -> case getLab tr of
       Ok (cat,labs) -> case 
          Map.lookup (cat,labs) labels of
            Just (ty,_) -> isStrType ty 
            _ -> True ---- TODO?
       _ -> True
     _ -> True ----
   trmAss (Ass _ t) = t

   --- this is mainly needed for parameter record projections
   comp t = errVal t $ Look.ccompute cgr [] t

isStrType ty = case ty of
     TStr -> True
     RecType ts -> any isStrType [t | Lbg _ t <- ts]
     Table _ t -> isStrType t
     _ -> False

mkLab k = L (IC ("_" ++ show k))

-- remove lock fields; in fact, any empty records and record types
unlock = filter notlock where
  notlock (Ass l t) = case t of --- need not look at l
     R [] -> False
     _ -> True
unlockTyp = filter notlock where
  notlock (Lbg l t) = case t of --- need not look at l
     RecType [] -> False
     _ -> True


prtTrace tr n = n ----trace ("-- ERROR" +++ A.prt tr +++ show n +++ show tr) n
prTrace  tr n = trace ("-- OBSERVE" +++ A.prt tr +++ show n +++ show tr) n

