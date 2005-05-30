----------------------------------------------------------------------
-- |
-- Module      : GrammarToCanon
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 21:08:14 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.20 $
--
-- Code generator from optimized GF source code to GFC.
-----------------------------------------------------------------------------

module GF.Compile.GrammarToCanon (showGFC,
		       redModInfo, redQIdent
		      ) where

import GF.Data.Operations
import GF.Data.Zipper
import GF.Infra.Option
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.PrGrammar
import GF.Infra.Modules
import GF.Grammar.Macros
import qualified GF.Canon.AbsGFC as G
import qualified GF.Canon.GFC as C
import GF.Canon.MkGFC
---- import Alias
import qualified GF.Canon.PrintGFC as P

import Control.Monad

-- compilation of optimized grammars to canonical GF. AR 5/10/2001 -- 12/5/2003

-- | This is the top-level function printing a gfc file
showGFC :: SourceGrammar -> String
showGFC = err id id . liftM (P.printTree . grammar2canon) . redGrammar

-- | any grammar, first trying without dependent types
-- abstract syntax without dependent types
redGrammar :: SourceGrammar -> Err C.CanonGrammar
redGrammar (MGrammar gr) = liftM MGrammar $ mapM redModInfo $ filter active gr where
  active (_,m) = case typeOfModule m of
    MTInterface -> False
    _ -> True

redModInfo :: (Ident, SourceModInfo) -> Err (Ident, C.CanonModInfo)
redModInfo (c,info) = do
  c'    <- redIdent c
  info' <- case info of
    ModMod m -> do
      let isIncompl = not $ isCompleteModule m
      (e,os) <- if isIncompl then return ([],[]) else redExtOpen m ----
      flags <- mapM redFlag $ flags m 
      (a,mt0) <- case mtype m of
         MTConcrete a -> do
           a' <- redIdent a
           return (a', MTConcrete a') 
         MTAbstract -> return (c',MTAbstract) --- c' not needed
         MTResource -> return (c',MTResource) --- c' not needed
         MTInterface -> return (c',MTResource) ---- not needed
         MTInstance _ -> return (c',MTResource) --- c' not needed
         MTTransfer x y -> return (c',MTTransfer (om x) (om y)) --- c' not needed

      --- this generates empty GFC reosurce for interface and incomplete
      let js = if isIncompl then emptyBinTree else jments m
          mt = mt0 ---- if isIncompl then MTResource else mt0

      defss <- mapM (redInfo a) $ tree2list $ js
      let defs0 = concat defss
      let lgh = length defs0
      defs  <- return $ sorted2tree $ defs0  -- sorted, but reduced
      let flags' = G.Flg (identC "modulesize") (identC ("n"++show lgh)) : flags
      return $ ModMod $ Module mt MSComplete flags' e os defs
  return (c',info')
 where
   redExtOpen m = do
     e' <- case extends m of
       es -> mapM (liftM inheritAll . redIdent) es
     os' <- mapM (\o -> case o of 
              OQualif q _ i -> liftM (OSimple q) (redIdent i)
              _ -> prtBad "cannot translate unqualified open in" c) $ opens m
     return (e',os')
   om = oSimple . openedModule --- normalizing away qualif

redInfo :: Ident -> (Ident,Info) -> Err [(Ident,C.Info)]
redInfo am (c,info) = errIn ("translating definition of" +++ prt c) $ do
  c' <- redIdent c 
  case info of
    AbsCat (Yes cont) pfs -> do
      let fs = case pfs of
                 Yes ts -> [(m,c) | Q m c <- ts]
                 _ -> []
      returns c' $ C.AbsCat cont fs
    AbsFun (Yes typ) pdf -> do
      let df = case pdf of
                 Yes t -> t  -- definition or "data"
                 _ -> Eqs [] -- primitive notion
      returns c' $ C.AbsFun typ df
    AbsTrans t -> 
      returns c' $ C.AbsTrans t

    ResParam (Yes ps) -> do
      ps' <- mapM redParam ps
      returns c' $ C.ResPar ps'

    CncCat pty ptr ppr -> case (pty,ptr,ppr) of
      (Yes ty, Yes (Abs _ t), Yes pr) -> do
        ty'  <- redCType ty
        trm' <- redCTerm t
        pr'  <- redCTerm pr 
        return [(c', C.CncCat ty' trm' pr')]
      _ -> prtBad "cannot reduce rule for" c
      
    CncFun mt ptr ppr -> case (mt,ptr,ppr) of
      (Just (cat,_), Yes trm, Yes pr) -> do
        cat' <- redIdent cat
        (xx,body,_) <- termForm trm
        xx'   <- mapM redArgvar xx
        body' <- errIn (prt body) $ redCTerm body ---- debug
        pr'   <- redCTerm pr 
        return [(c',C.CncFun (G.CIQ am cat') xx' body' pr')]
      _ -> prtBad ("cannot reduce rule" +++ show info +++ "for") c ---- debug

    AnyInd s b -> do
      b' <- redIdent b
      returns c' $ C.AnyInd s b'

    _ -> return [] --- retain some operations
 where
   returns f i = return [(f,i)]

redQIdent :: QIdent -> Err G.CIdent
redQIdent (m,c) = return $ G.CIQ m c

redIdent :: Ident -> Err Ident
redIdent x 
  | isWildIdent x = return $ identC "h_" --- needed in declarations
  | otherwise = return $ identC $ prt x ---

redFlag :: Option -> Err G.Flag
redFlag (Opt (f,[x])) = return $ G.Flg (identC f) (identC x)
redFlag o = Bad $ "cannot reduce option" +++ prOpt o

redDecl :: Decl -> Err G.Decl
redDecl (x,a) = liftM2 G.Decl (redIdent x) (redType a)

redType :: Type -> Err G.Exp
redType = redTerm

redTerm :: Type -> Err G.Exp
redTerm t = return $ rtExp t

-- resource

redParam :: Param -> Err G.ParDef
redParam (c,cont) = do
  c'    <- redIdent c
  cont' <- mapM (redCType . snd) cont
  return $ G.ParD c' cont'

redArgvar :: Ident -> Err G.ArgVar
redArgvar x = case x of
  IA (x,i)     -> return $ G.A  (identC x) (toInteger i)
  IAV (x,b,i) -> return $ G.AB (identC x) (toInteger b) (toInteger i)
  _ -> Bad $ "cannot reduce" +++ show x +++ "as argument variable"

redLindef :: Term -> Err G.Term
redLindef t = case t of
  Abs x b -> redCTerm b ---
  _ -> redCTerm t

redCType :: Type -> Err G.CType
redCType t = case t of
  RecType lbs -> do
    let (ls,ts) = unzip lbs
        ls' = map redLabel ls
    ts' <- mapM redCType ts
    return $ G.RecType $ map (uncurry G.Lbg) $ zip ls' ts'
  Table p v  -> liftM2 G.Table (redCType p) (redCType v)
  Q m c    -> liftM G.Cn $ redQIdent (m,c)
  QC m c   -> liftM G.Cn $ redQIdent (m,c)

  App (Q (IC "Predef") (IC "Ints")) (EInt n) -> return $ G.TInts (toInteger n)

  Sort "Str" -> return $ G.TStr
  _ -> prtBad "cannot reduce to canonical the type" t

redCTerm :: Term -> Err G.Term
redCTerm t = case t of
  Vr x -> checkAgain 
            (liftM G.Arg $ redArgvar x) 
            (liftM G.LI  $ redIdent x) --- for parametrize optimization
  App _ _ -> do  -- only constructor applications can remain
    (_,c,xx) <- termForm t
    xx' <- mapM redCTerm xx
    case c of
      QC p c -> liftM2 G.Con (redQIdent (p,c)) (return xx')
      _ -> prtBad "expected constructor head instead of" c
  Q p c  -> liftM G.I (redQIdent (p,c))
  QC p c -> liftM2 G.Con (redQIdent (p,c)) (return [])
  R rs     -> do
    let (ls,tts) = unzip rs
        ls' = map redLabel ls
    ts <- mapM (redCTerm . snd) tts
    return $ G.R $ map (uncurry G.Ass) $ zip ls' ts
  RecType [] -> return $ G.R [] --- comes out in parsing
  P tr l -> do
    tr' <- redCTerm tr
    return $ G.P tr' (redLabel l)
  T i cs     -> do
    ty  <- getTableType i
    ty' <- redCType ty
    let (ps,ts) = unzip cs
    ps' <- mapM redPatt ps
    ts' <- mapM redCTerm ts
    return $ G.T ty' $ map (uncurry G.Cas) $ zip (map singleton ps') ts'
  TSh i cs -> do
    ty  <- getTableType i
    ty' <- redCType ty
    let (pss,ts) = unzip cs
    pss' <- mapM (mapM redPatt) pss
    ts' <- mapM redCTerm ts
    return $ G.T ty' $ map (uncurry G.Cas) $ zip pss' ts'
  V ty ts     -> do
    ty' <- redCType ty
    ts' <- mapM redCTerm ts
    return $ G.V ty' ts'
  S u v -> liftM2 G.S (redCTerm u) (redCTerm v)
  K s   -> return $ G.K (G.KS s)
  EInt i -> return $ G.EInt $ toInteger i
  C u v -> liftM2 G.C (redCTerm u) (redCTerm v)
  FV ts -> liftM G.FV $ mapM redCTerm ts
---  Ready ss -> return $ G.Ready [redStr ss] --- obsolete

  Alts (d,vs) -> do ---
    d'  <- redCTermTok d
    vs' <- mapM redVariant vs
    return $ G.K $ G.KP d' vs'

  Empty -> return $ G.E

---  Strs ss -> return $ G.Strs [s | K s <- ss] ---

---- Glue obsolete in canon, should not occur here
  Glue x y -> redCTerm (C x y)

  _ -> Bad ("cannot reduce term" +++ prt t)

redPatt :: Patt -> Err G.Patt
redPatt p = case p of
  PP m c ps -> liftM2 G.PC (redQIdent (m,c)) (mapM redPatt ps) 
  PR rs -> do
    let (ls,tts) = unzip rs
        ls' = map redLabel ls
    ts <- mapM redPatt tts
    return $ G.PR $  map (uncurry G.PAss) $ zip ls' ts
  PT _ q -> redPatt q
  PInt i -> return $ G.PI (toInteger i)
  PV x -> liftM G.PV $ redIdent x --- for parametrize optimization
  _ -> prtBad "cannot reduce pattern" p

redLabel :: Label -> G.Label
redLabel (LIdent s) = G.L $ identC s
redLabel (LVar i)   = G.LV $ toInteger i

redVariant :: (Term, Term) -> Err G.Variant
redVariant (v,c) = do
  v' <- redCTermTok v
  c' <- redCTermTok c
  return $ G.Var v' c'

redCTermTok :: Term -> Err [String]
redCTermTok t = case t of
  K s   -> return [s]
  Empty -> return []
  C a b -> liftM2 (++) (redCTermTok a) (redCTermTok b)
  Strs ss -> return [s | K s <- ss] ---
  _ -> prtBad "cannot get strings from term" t

