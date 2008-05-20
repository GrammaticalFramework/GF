----------------------------------------------------------------------
-- |
-- Module      : Rename
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 18:39:44 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.19 $
--
-- AR 14\/5\/2003
-- The top-level function 'renameGrammar' does several things:
--
--   - extends each module symbol table by indirections to extended module
--
--   - changes unqualified and as-qualified imports to absolutely qualified
--
--   - goes through the definitions and resolves names
--
-----------------------------------------------------------------------------

module GF.Devel.Compile.Rename (
  renameModule
  ) where

import GF.Devel.Grammar.Grammar
import GF.Devel.Grammar.Construct
import GF.Devel.Grammar.Macros
import GF.Devel.Grammar.PrGF
import GF.Infra.Ident
import GF.Devel.Grammar.Lookup
import GF.Data.Operations

import Control.Monad
import qualified Data.Map as Map
import Data.List (nub)
import Debug.Trace (trace)

{-
-- | this gives top-level access to renaming term input in the cc command
renameSourceTerm :: SourceGrammar -> Ident -> Term -> Err Term
renameSourceTerm g m t = do
  mo     <- lookupErr m (modules g)
  status <- buildStatus g m mo
  renameTerm status [] t
-}

renameModule :: GF -> SourceModule -> Err SourceModule
renameModule gf sm@(name,mo) = case mtype mo of
  MTInterface -> return sm
  _ | not (isCompleteModule mo) -> return sm 
  _ -> errIn ("renaming module" +++ prt name) $ do
    let gf1 = gf {gfmodules = Map.insert name mo (gfmodules gf)}
    let rename = renameTerm (gf1,sm) []
    mo1 <- termOpModule rename mo
    let mo2 = mo1 {mopens = nub [(i,i) | (_,i) <- mopens mo1]}
    return (name,mo2)

type RenameEnv = (GF,SourceModule)

renameIdentTerm :: RenameEnv -> Term -> Err Term
renameIdentTerm (gf, (name,mo)) trm = case trm of
  Vr i -> looks i
  Con i -> looks i
  Q  m i -> getQualified m >>= look i
  QC m i -> getQualified m >>= look i
  _ -> return trm
 where
   looks i = do
     let ts = nub [t | m <- pool, Ok t <- [look i m]]
     case ts of
       [t] -> return t 
       [] | elem i [IC "Int",IC "Float",IC "String"] -> ---- do this better
            return (Q (IC "PredefAbs") i)
       [] -> prtBad "identifier not found" i
       t:_ -> 
         trace (unwords $ "WARNING":"identifier":prt i:"ambiguous:" : map prt ts) 
               (return t)
----       _ -> fail $ unwords $ "identifier" : prt i : "ambiguous:" : map prt ts
   look i m = do
     ju <- lookupIdent gf m i
     return $ case jform ju of
       JLink -> if isConstructor ju then QC (jlink ju) i else Q (jlink ju) i
       _     -> if isConstructor ju then QC m i else Q m i
   pool = nub $ name :
                maybe name id (interfaceName mo) : 
                IC "Predef" : 
                map fst (mextends mo) ++ 
                map snd (mopens mo) 
   getQualified m = case Map.lookup m qualifMap of
     Just n -> return n
     _ -> prtBad "unknown qualifier" m
   qualifMap = Map.fromList $ 
     mopens mo ++ 
     concat [ops | (_,ops) <- minstances mo] ++ 
     [(m,m) | m <- pool]
     ---- TODO: check uniqueness of these names

renameTerm :: RenameEnv -> [Ident] -> Term -> Err Term
renameTerm env vars = ren vars where
  ren vs trm = case trm of
    Abs x b    -> liftM  (Abs x) (ren (x:vs) b)
    Prod x a b -> liftM2 (Prod x) (ren vs a) (ren (x:vs) b)
    Typed a b  -> liftM2 Typed (ren vs a) (ren vs b)
    Vr x      
      | elem x vs -> return trm
      | otherwise -> renid trm
    Con _  -> renid trm
    Q _ _  -> renid trm
    QC _ _ -> renid trm
    Eqs eqs -> liftM Eqs $ mapM (renameEquation env vars) eqs
    T i cs -> do
      i' <- case i of
        TTyped ty -> liftM TTyped $ ren vs ty -- the only annotation in source
        _ -> return i
      liftM (T i') $ mapM (renCase vs) cs  

    Let (x,(m,a)) b -> do
      m' <- case m of
        Just ty -> liftM Just $ ren vs ty
        _ -> return m
      a' <- ren vs a
      b' <- ren (x:vs) b
      return $ Let (x,(m',a')) b'

    P t@(Vr r) l                     -- for constant t we know it is projection
      | elem r vs -> return trm                           -- var proj first
      | otherwise -> case renid (Q r (label2ident l)) of  -- qualif   second
          Ok t -> return t
          _ -> case liftM (flip P l) $ renid t of
            Ok t -> return t                              -- const proj last
            _ -> prtBad "unknown qualified constant" trm

    EPatt p -> do
      (p',_) <- renpatt p
      return $ EPatt p'

    _ -> composOp (ren vs) trm

  renid = renameIdentTerm env
  renCase vs (p,t) = do
    (p',vs') <- renpatt p
    t' <- ren (vs' ++ vs) t
    return (p',t')
  renpatt = renamePattern env

-- | vars not needed in env, since patterns always overshadow old vars
renamePattern :: RenameEnv -> Patt -> Err (Patt,[Ident])
renamePattern env patt = case patt of

  PMacro c -> do
    c' <- renid $ Vr c
    case c' of
      Q p d -> renp $ PM p d
      _ -> prtBad "unresolved pattern" patt

  PC c ps -> do
    c' <- renid $ Vr c
    case c' of
      QC p d -> renp $ PP p d ps
      Q  p d -> renp $ PP p d ps
      _ -> prtBad "unresolved pattern" c' ---- (PC c ps', concat vs)

  PP p c ps -> do

    (p', c') <- case renid (QC p c) of
      Ok (QC p' c') -> return (p',c')
      _ -> return (p,c) --- temporarily, for bw compat
    psvss <- mapM renp ps
    let (ps',vs) = unzip psvss
    return (PP p' c' ps', concat vs)

  PV x -> case renid (Vr x) of
    Ok (QC m c) -> return (PP m c [],[])
    _    -> return (patt, [x])

  PR r -> do
    let (ls,ps) = unzip r
    psvss <- mapM renp ps
    let (ps',vs') = unzip psvss
    return (PR (zip ls ps'), concat vs') 

  PAlt p q -> do
    (p',vs) <- renp p
    (q',ws) <- renp q
    return (PAlt p' q', vs ++ ws)

  PSeq p q -> do
    (p',vs) <- renp p
    (q',ws) <- renp q
    return (PSeq p' q', vs ++ ws)

  PRep p -> do
    (p',vs) <- renp p
    return (PRep p', vs)

  PNeg p -> do
    (p',vs) <- renp p
    return (PNeg p', vs)

  PAs x p -> do
    (p',vs) <- renp p
    return (PAs x p', x:vs)

  _ -> return (patt,[])

 where 
   renp  = renamePattern env
   renid = renameIdentTerm env

renameParam :: RenameEnv -> (Ident, Context) -> Err (Ident, Context)
renameParam env (c,co) = do
  co' <- renameContext env co
  return (c,co')

renameContext :: RenameEnv -> Context -> Err Context
renameContext b = renc [] where
  renc vs cont = case cont of
    (x,t) : xts 
      | isWildIdent x -> do
          t'   <- ren vs t
          xts' <- renc vs xts
          return $ (x,t') : xts'
      | otherwise -> do
          t'   <- ren vs t
          let vs' = x:vs
          xts' <- renc vs' xts
          return $ (x,t') : xts'
    _ -> return cont
  ren = renameTerm b

-- | vars not needed in env, since patterns always overshadow old vars
renameEquation :: RenameEnv -> [Ident] -> Equation -> Err Equation
renameEquation b vs (ps,t) = do
  (ps',vs') <- liftM unzip $ mapM (renamePattern b) ps
  t'        <- renameTerm b (concat vs' ++ vs) t
  return (ps',t')

