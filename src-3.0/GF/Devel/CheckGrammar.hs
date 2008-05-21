{-# LANGUAGE PatternGuards #-}
----------------------------------------------------------------------
-- |
-- Module      : CheckGrammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/11 23:24:33 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.31 $
--
-- AR 4\/12\/1999 -- 1\/4\/2000 -- 8\/9\/2001 -- 15\/5\/2002 -- 27\/11\/2002 -- 18\/6\/2003
--
-- type checking also does the following modifications:
--
--  - types of operations and local constants are inferred and put in place
--
--  - both these types and linearization types are computed
--
--  - tables are type-annotated
-----------------------------------------------------------------------------

module GF.Devel.CheckGrammar (
  showCheckModule, justCheckLTerm, allOperDependencies, topoSortOpers) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Modules
import GF.Grammar.Refresh ----

import GF.Devel.TypeCheck
import GF.Grammar.Predef (cPredef, cPredefAbs) ---

import GF.Grammar.PrGrammar
import GF.Grammar.Lookup
import GF.Grammar.LookAbs
import GF.Grammar.Predef
import GF.Grammar.Macros
import GF.Grammar.ReservedWords ----
import GF.Grammar.PatternMatch
import GF.Grammar.AppPredefined
import GF.Grammar.Lockfield (isLockLabel)

import GF.Data.Operations
import GF.Infra.CheckM

import Data.List
import qualified Data.Set as Set
import qualified Data.Map as Map
import Control.Monad
import Debug.Trace ---


showCheckModule :: [SourceModule] -> SourceModule -> Err ([SourceModule],String)
showCheckModule mos m = do
  (st,(_,msg)) <- checkStart $ checkModule mos m
  return (st, unlines $ reverse msg)

-- | checking is performed in the dependency order of modules
checkModule :: [SourceModule] -> SourceModule -> Check [SourceModule]
checkModule ms (name,mod) = checkIn ("checking module" +++ prt name) $ case mod of

  ModMod mo@(Module mt st fs me ops js) -> do
    checkRestrictedInheritance ms (name, mo)
    js' <- case mt of
      MTAbstract -> mapMTree (checkAbsInfo gr name) js

      MTTransfer a b -> mapMTree (checkAbsInfo gr name) js

      MTResource -> mapMTree (checkResInfo gr name) js

      MTConcrete a -> do
        checkErr $ topoSortOpers $ allOperDependencies name js
        ModMod abs <- checkErr $ lookupModule gr a
        js1 <- checkCompleteGrammar abs mo
        mapMTree (checkCncInfo gr name (a,abs)) js1

      MTInterface -> mapMTree (checkResInfo gr name) js

      MTInstance a -> do
        ModMod abs <- checkErr $ lookupModule gr a
        -- checkCompleteInstance abs mo -- this is done in Rebuild
        mapMTree (checkResInfo gr name) js

    return $ (name, ModMod (Module mt st fs me ops js')) : ms

  _ -> return $ (name,mod) : ms
 where
   gr  = MGrammar $ (name,mod):ms

-- check if restricted inheritance modules are still coherent
-- i.e. that the defs of remaining names don't depend on omitted names
---checkRestrictedInheritance :: [SourceModule] -> SourceModule -> Check ()
checkRestrictedInheritance mos (name,mo) = do
  let irs = [ii | ii@(_,mi) <- extend mo, mi /= MIAll]  -- names with restr. inh.
  let mrs = [((i,m),mi) | (i,ModMod m) <- mos, Just mi <- [lookup i irs]] 
                             -- the restr. modules themself, with restr. infos
  mapM_ checkRem mrs
 where
   checkRem ((i,m),mi) = do
     let (incl,excl) = partition (isInherited mi) (map fst (tree2list (jments m)))
     let incld c   = Set.member c (Set.fromList incl)
     let illegal c = Set.member c (Set.fromList excl)
     let illegals = [(f,is) | 
           (f,cs) <- allDeps, incld f, let is = filter illegal cs, not (null is)]
     case illegals of 
       [] -> return ()
       cs -> fail $ "In inherited module" +++ prt i ++
               ", dependence of excluded constants:" ++++
               unlines ["  " ++ prt f +++ "on" +++ unwords (map prt is) | 
                              (f,is) <- cs]
   allDeps = ---- transClosure $ Map.fromList $ 
             concatMap (allDependencies (const True)) 
                              [jments m | (_,ModMod m) <- mos]
   transClosure ds = ds ---- TODO: check in deeper modules

-- | check if a term is typable
justCheckLTerm :: SourceGrammar -> Term -> Err Term
justCheckLTerm src t = do
  ((t',_),_) <- checkStart (inferLType src t)
  return t'

checkAbsInfo :: SourceGrammar -> Ident -> (Ident,Info) -> Check (Ident,Info)
checkAbsInfo st m (c,info) = do
---- checkReservedId c
 case info of
   AbsCat (Yes cont) _ -> mkCheck "category" $ 
     checkContext st cont ---- also cstrs
   AbsFun (Yes typ0) md -> do
    typ <- compAbsTyp [] typ0   -- to calculate let definitions
    mkCheck "type of function" $ checkTyp st typ 
    md' <- case md of
       Yes d -> do
         let d' = elimTables d
         mkCheckWarn "definition of function" $ checkEquation st (m,c) d'
         return $ Yes d'
       _ -> return md
    return $ (c,AbsFun (Yes typ) md')
   _ -> return (c,info)
 where
   mkCheck cat ss = case ss of
     [] -> return (c,info)
     ["[]"] -> return (c,info) ----
     _  -> checkErr $ prtBad (unlines ss ++++ "in" +++ cat) c
   ---- temporary solution when tc of defs is incomplete
   mkCheckWarn cat ss = case ss of
     [] -> return (c,info)
     ["[]"] -> return (c,info) ----
     _  -> checkWarn (unlines ss ++++ "in" +++ cat +++ prt c) >> return (c,info)
   compAbsTyp g t = case t of
     Vr x -> maybe (fail ("no value given to variable" +++ prt x)) return $ lookup x g
     Let (x,(_,a)) b -> do
       a' <- compAbsTyp g a
       compAbsTyp ((x, a'):g) b
     Prod x a b -> do
       a' <- compAbsTyp g a
       b' <- compAbsTyp ((x,Vr x):g) b
       return $ Prod x a' b'
     Abs _ _ -> return t
     _ -> composOp (compAbsTyp g) t

   elimTables e = case e of
     S t a  -> elimSel (elimTables t) (elimTables a)
     T _ cs -> Eqs [(elimPatt p, elimTables t) | (p,t) <- cs]
     _ -> composSafeOp elimTables e
   elimPatt p = case p of
     PR lps -> map snd lps
     _ -> [p]
   elimSel t a = case a of
     R fs -> mkApp t (map (snd . snd) fs)
     _ -> mkApp t [a]

checkCompleteGrammar :: SourceAbs -> SourceCnc -> Check (BinTree Ident Info)
checkCompleteGrammar abs cnc = do
  let js = jments cnc
  let fs = tree2list $ jments abs
  foldM checkOne js fs
 where
   checkOne js i@(c,info) = case info of
     AbsFun (Yes _) _ -> case lookupIdent c js of
       Ok _ -> return js
       _ -> do
         checkWarn $ "WARNING: no linearization of" +++ prt c
         return js
     AbsCat (Yes _) _ -> case lookupIdent c js of
       Ok (AnyInd _ _) -> return js
       Ok (CncCat (Yes _) _ _) -> return js
       Ok (CncCat _ mt mp) -> do
         checkWarn $ 
           "Warning: no linearization type for" +++ prt c ++ 
           ", inserting default {s : Str}" 
         return $ updateTree (c,CncCat (Yes defLinType) mt mp) js
       _ -> do
         checkWarn $ 
           "Warning: no linearization type for" +++ prt c ++ 
           ", inserting default {s : Str}" 
         return $ updateTree (c,CncCat (Yes defLinType) nope nope) js
     _ -> return js

-- | General Principle: only Yes-values are checked. 
-- A May-value has always been checked in its origin module.
checkResInfo :: SourceGrammar -> Ident -> (Ident,Info) -> Check (Ident,Info)
checkResInfo gr mo (c,info) = do
  checkReservedId c
  case info of
    ResOper pty pde -> chIn "operation" $ do
      (pty', pde') <- case (pty,pde) of
         (Yes ty, Yes de) -> do
           ty'     <- check ty typeType >>= comp . fst
           (de',_) <- check de ty'
           return (Yes ty', Yes de')
         (_, Yes de) -> do
           (de',ty') <- infer de
           return (Yes ty', Yes de')
         (_,Nope) -> do
           checkWarn "No definition given to oper"
           return (pty,pde)
         _ -> return (pty, pde) --- other cases are uninteresting
      return (c, ResOper pty' pde')

    ResOverload tysts -> chIn "overloading" $ do
      tysts' <- mapM (uncurry $ flip check) tysts
      let tysts2 = [(y,x) | (x,y) <- tysts']
      --- this can only be a partial guarantee, since matching
      --- with value type is only possible if expected type is given
      checkUniq $ 
        sort [t : map snd xs | (x,_) <- tysts2, Ok (xs,t) <- [typeFormCnc x]]
      return (c,ResOverload tysts2)

    ResParam (Yes (pcs,_)) -> chIn "parameter type" $ do
----      mapM ((mapM (computeLType gr . snd)) . snd) pcs
      mapM_ ((mapM_ (checkIfParType gr . snd)) . snd) pcs
      ts <- checkErr $ lookupParamValues gr mo c
      return (c,ResParam (Yes (pcs, Just ts)))

    _ ->  return (c,info)
 where
   infer = inferLType gr
   check = checkLType gr
   chIn cat = checkIn ("Happened in" +++ cat +++ prt c +++ ":")
   comp = computeLType gr

   checkUniq xss = case xss of
     x:y:xs 
      | x == y -> raise $ "ambiguous for argument list" +++ 
                         unwords (map (prtType gr) x)  
      | otherwise -> checkUniq $ y:xs
     _ -> return ()


checkCncInfo :: SourceGrammar -> Ident -> (Ident,SourceAbs) -> 
                (Ident,Info) -> Check (Ident,Info)
checkCncInfo gr m (a,abs) (c,info) = do
  checkReservedId c
  case info of

    CncFun _ (Yes trm) mpr -> chIn "linearization of" $ do
      typ        <- checkErr $ lookupFunTypeSrc gr a c
      cat0       <- checkErr $ valCat typ
      (cont,val) <- linTypeOfType gr m typ         -- creates arg vars
      (trm',_)   <- check trm (mkFunType (map snd cont) val)  -- erases arg vars
      checkPrintname gr mpr
      cat        <- return $ snd cat0
      return (c, CncFun (Just (cat,(cont,val))) (Yes trm') mpr)
                                                   -- cat for cf, typ for pe

    CncCat (Yes typ) mdef mpr -> chIn "linearization type of" $ do
      checkErr $ lookupCatContextSrc gr a c
      typ'  <- checkIfLinType gr typ
      mdef' <- case mdef of
        Yes def -> do
          (def',_) <- checkLType gr def (mkFunType [typeStr] typ)
          return $ Yes def'
        _ -> return mdef
      checkPrintname gr mpr
      return (c,CncCat (Yes typ') mdef' mpr)

    _ -> checkResInfo gr m (c,info)

 where
   env = gr
   infer = inferLType gr
   comp = computeLType gr 
   check = checkLType gr
   chIn cat = checkIn ("Happened in" +++ cat +++ prt c +++ ":")

checkIfParType :: SourceGrammar -> Type -> Check ()
checkIfParType st typ = checkCond ("Not parameter type" +++ prt typ) (isParType typ)
  where
   isParType ty = True ----
{- case ty of
     Cn typ -> case lookupConcrete st typ of
       Ok (CncParType _ _ _) -> True
       Ok (CncOper _ ty' _) -> isParType ty'
       _ -> False
     Q p t -> case lookupInPackage st (p,t) of
       Ok (CncParType _ _ _) -> True
       _ -> False
     RecType r -> all (isParType . snd) r
     _ -> False
-}

checkIfStrType :: SourceGrammar -> Type -> Check ()
checkIfStrType st typ = case typ of
  Table arg val -> do
    checkIfParType st arg 
    checkIfStrType st val
  _ | typ == typeStr -> return ()
  _ -> prtFail "not a string type" typ


checkIfLinType :: SourceGrammar -> Type -> Check Type
checkIfLinType st typ0 = do
  typ <- computeLType st typ0
{- ---- should check that not fun type
  case typ of
    RecType r -> do
      let (lins,ihs) = partition (isLinLabel .fst) r
      --- checkErr $ checkUnique $ map fst r
      mapM_ checkInh ihs
      mapM_ checkLin lins
    _ -> prtFail "a linearization type cannot be" typ
-}
  return typ

 where
   checkInh (label,typ) = checkIfParType st typ
   checkLin (label,typ) = return () ---- checkIfStrType st typ


computeLType :: SourceGrammar -> Type -> Check Type
computeLType gr t = do
  g0 <- checkGetContext
  let g = [(x, Vr x) | (x,_) <- g0]
  checkInContext g $ comp t
 where
  comp ty = case ty of
    _ | Just _ <- isTypeInts ty -> return ty ---- shouldn't be needed
      | ty == typeInt           -> return ty ---- shouldn't be needed
      | ty == typeFloat         -> return ty ---- shouldn't be needed
      | ty == typeError         -> return ty ---- shouldn't be needed

    Q m ident -> checkIn ("module" +++ prt m) $ do
      ty' <- checkErr (lookupResDef gr m ident) 
      if ty' == ty then return ty else comp ty' --- is this necessary to test?

    Vr ident  -> checkLookup ident -- never needed to compute!

    App f a -> do
      f' <- comp f
      a' <- comp a
      case f' of
        Abs x b -> checkInContext [(x,a')] $ comp b
        _ -> return $ App f' a'

    Prod x a b -> do
      a' <- comp a
      b' <- checkInContext [(x,Vr x)] $ comp b
      return $ Prod x a' b'

    Abs x b -> do
      b' <- checkInContext [(x,Vr x)] $ comp b
      return $ Abs x b'

    ExtR r s -> do
      r' <- comp r
      s' <- comp s
      case (r',s') of
        (RecType rs, RecType ss) -> checkErr (plusRecType r' s') >>= comp
        _ -> return $ ExtR r' s'

    RecType fs -> do
      let fs' = sortBy (\x y -> compare (fst x) (fst y)) fs
      liftM RecType $ mapPairsM comp fs'

    _ | ty == typeTok -> return typeStr
    _ | isPredefConstant ty -> return ty

    _ -> composOp comp ty

checkPrintname :: SourceGrammar -> Perh Term -> Check ()
checkPrintname st (Yes t) = checkLType st t typeStr >> return ()
checkPrintname _ _ = return ()

-- | for grammars obtained otherwise than by parsing ---- update!!
checkReservedId :: Ident -> Check ()
checkReservedId x = let c = prt x in
         if isResWord c 
            then checkWarn ("Warning: reserved word used as identifier:" +++ c)
            else return ()

-- to normalize records and record types
labelIndex :: Type -> Label -> Int
labelIndex ty lab = case ty of
  RecType ts -> maybe (error ("label index" +++ prt lab)) id $ lookup lab $ labs ts
  _ -> error $ "label index" +++ prt ty
 where 
  labs ts = zip (map fst (sortBy (\ x y -> compare (fst x) (fst y)) ts)) [0..]

-- the underlying algorithms

inferLType :: SourceGrammar -> Term -> Check (Term, Type)
inferLType gr trm = case trm of

   Q m ident | isPredef m -> termWith trm $ checkErr (typPredefined ident)

   Q m ident -> checks [
     termWith trm $ checkErr (lookupResType gr m ident) >>= comp
     ,
     checkErr (lookupResDef gr m ident) >>= infer
     ,
{-
     do
       over <- getOverload gr Nothing trm
       case over of
         Just trty -> return trty
         _ -> prtFail "not overloaded" trm
     ,
-}
     prtFail "cannot infer type of constant" trm
     ]

   QC m ident | isPredef m -> termWith trm $ checkErr (typPredefined ident)

   QC m ident -> checks [
       termWith trm $ checkErr (lookupResType gr m ident) >>= comp
       ,
       checkErr (lookupResDef gr m ident) >>= infer
       ,
       prtFail "cannot infer type of canonical constant" trm
       ]

   Val ty i -> termWith trm $ return ty

   Vr ident -> termWith trm $ checkLookup ident

   Typed e t -> do
     t' <- comp t
     check e t'
     return (e,t')

   App f a -> do
     over <- getOverload gr Nothing trm
     case over of
       Just trty -> return trty
       _ -> do
         (f',fty) <- infer f
         fty' <- comp fty
         case fty' of
           Prod z arg val -> do 
             a' <- justCheck a arg
             ty <- if isWildIdent z 
                      then return val
                      else substituteLType [(z,a')] val
             return (App f' a',ty) 
           _ -> raise ("function type expected for"+++ 
                      prt f +++"instead of" +++ prtType env fty)

   S f x -> do
     (f', fty) <- infer f
     case fty of
       Table arg val -> do
         x'<- justCheck x arg
         return (S f' x', val)
       _ -> prtFail "table lintype expected for the table in" trm

   P t i -> do
     (t',ty) <- infer t   --- ??
     ty' <- comp ty
-----     let tr2 = PI t' i (labelIndex ty' i)
     let tr2 = P t' i
     termWith tr2 $ checkErr $ case ty' of
       RecType ts -> maybeErr ("unknown label" +++ prt i +++ "in" +++ prt ty') $ 
                     lookup i ts
       _ -> prtBad ("record type expected for" +++ prt t +++ "instead of") ty'
   PI t i _ -> infer $ P t i

   R r -> do
     let (ls,fs) = unzip r
     fsts <- mapM inferM fs
     let ts = [ty | (Just ty,_) <- fsts]
     checkCond ("cannot infer type of record"+++ prt trm) (length ts == length fsts)
     return $ (R (zip ls fsts), RecType (zip ls ts))

   T (TTyped arg) pts -> do
     (_,val) <- checks $ map (inferCase (Just arg)) pts
     check trm (Table arg val)
   T (TComp arg) pts -> do
     (_,val) <- checks $ map (inferCase (Just arg)) pts
     check trm (Table arg val)
   T ti pts -> do  -- tries to guess: good in oper type inference
     let pts' = [pt | pt@(p,_) <- pts, isConstPatt p]
     case pts' of 
       [] -> prtFail "cannot infer table type of" trm
----       PInt k : _ -> return $ Ints $ max [i | PInt i <- pts'] 
       _  -> do 
         (arg,val) <- checks $ map (inferCase Nothing) pts'
         check trm (Table arg val)
   V arg pts -> do
     (_,val) <- checks $ map infer pts
     return (trm, Table arg val)

   K s  -> do
     if elem ' ' s
        then checkWarn ("WARNING: space in token \"" ++ s ++ 
                        "\". Lexical analysis may fail.")
        else return ()
     return (trm, typeStr)

   EInt i -> return (trm, typeInt)

   EFloat i -> return (trm, typeFloat)

   Empty -> return (trm, typeStr)

   C s1 s2 -> 
     check2 (flip justCheck typeStr) C s1 s2 typeStr

   Glue s1 s2 -> 
     check2 (flip justCheck typeStr) Glue s1 s2 typeStr ---- typeTok

---- hack from Rename.identRenameTerm, to live with files with naming conflicts 18/6/2007
   Strs (Cn c : ts) | c == cConflict -> do
     trace ("WARNING: unresolved constant, could be any of" +++ unwords (map prt ts)) (infer $ head ts)
--     checkWarn ("WARNING: unresolved constant, could be any of" +++ unwords (map prt ts))
--     infer $ head ts

   Strs ts -> do
     ts' <- mapM (\t -> justCheck t typeStr) ts 
     return (Strs ts', typeStrs)

   Alts (t,aa) -> do
     t'  <- justCheck t typeStr
     aa' <- flip mapM aa (\ (c,v) -> do
        c' <- justCheck c typeStr 
        v' <- justCheck v typeStrs
        return (c',v'))
     return (Alts (t',aa'), typeStr)

   RecType r -> do
     let (ls,ts) = unzip r
     ts' <- mapM (flip justCheck typeType) ts 
     return (RecType (zip ls ts'), typeType)

   ExtR r s -> do
     (r',rT) <- infer r 
     rT'     <- comp rT
     (s',sT) <- infer s
     sT'     <- comp sT

     let trm' = ExtR r' s'
     ---- trm'    <- checkErr $ plusRecord r' s'
     case (rT', sT') of
       (RecType rs, RecType ss) -> do
         rt <- checkErr $ plusRecType rT' sT'
         check trm' rt ---- return (trm', rt)
       _ | rT' == typeType && sT' == typeType -> return (trm', typeType)
       _ -> prtFail "records or record types expected in" trm

   Sort _     -> 
     termWith trm $ return typeType

   Prod x a b -> do
     a' <- justCheck a typeType
     b' <- checkInContext [(x,a')] $ justCheck b typeType
     return (Prod x a' b', typeType)

   Table p t  -> do
     p' <- justCheck p typeType --- check p partype! 
     t' <- justCheck t typeType
     return $ (Table p' t', typeType)

   FV vs -> do
     (_,ty) <- checks $ map infer vs
---     checkIfComplexVariantType trm ty
     check trm ty

   EPattType ty -> do
     ty' <- justCheck ty typeType
     return (ty',typeType)
   EPatt p -> do
     ty <- inferPatt p
     return (trm, EPattType ty)

   _ -> prtFail "cannot infer lintype of" trm

 where
   env = gr
   infer = inferLType env
   comp = computeLType env 

   check = checkLType env
   
   isPredef m = elem m [cPredef,cPredefAbs]

   justCheck ty te = check ty te >>= return . fst

   -- for record fields, which may be typed
   inferM (mty, t) = do
     (t', ty') <- case mty of
       Just ty -> check ty t
       _ -> infer t
     return (Just ty',t')

   inferCase mty (patt,term) = do
     arg  <- maybe (inferPatt patt) return mty
     cont <- pattContext env arg patt
     i    <- checkUpdates cont
     (_,val) <- infer term
     checkResets i
     return (arg,val)
   isConstPatt p = case p of
     PC _ ps -> True --- all isConstPatt ps
     PP _ _ ps -> True --- all isConstPatt ps
     PR ps -> all (isConstPatt . snd) ps
     PT _ p -> isConstPatt p
     PString _ -> True
     PInt _ -> True
     PFloat _ -> True
     PChar -> True
     PChars _ -> True
     PSeq p q -> isConstPatt p && isConstPatt q
     PAlt p q -> isConstPatt p && isConstPatt q
     PRep p -> isConstPatt p
     PNeg p -> isConstPatt p
     PAs _ p -> isConstPatt p
     _ -> False

   inferPatt p = case p of
     PP q c ps | q /= cPredef -> checkErr $ lookupResType gr q c >>= valTypeCnc
     PAs _ p  -> inferPatt p
     PNeg p   -> inferPatt p
     PAlt p q -> checks [inferPatt p, inferPatt q]
     PSeq _ _ -> return $ typeStr
     PRep _   -> return $ typeStr
     PChar    -> return $ typeStr
     PChars _ -> return $ typeStr
     _ -> infer (patt2term p) >>= return . snd


-- type inference: Nothing, type checking: Just t
-- the latter permits matching with value type
getOverload :: SourceGrammar -> Maybe Type -> Term -> Check (Maybe (Term,Type))
getOverload env@gr mt t = case appForm t of
     (f@(Q m c), ts) -> case lookupOverload gr m c of
       Ok typs -> do
         ttys <- mapM infer ts
         v <- matchOverload f typs ttys
         return $ Just v
       _ -> return Nothing
     _ -> return Nothing
 where
   infer = inferLType env
   matchOverload f typs ttys = do
     let (tts,tys) = unzip ttys
     let vfs = lookupOverloadInstance tys typs

     case [vf | vf@(v,f) <- vfs, matchVal mt v] of
       [(val,fun)] -> return (mkApp fun tts, val)
       [] -> raise $ "no overload instance of" +++ prt f +++ 
         "for" +++ unwords (map (prtType env) tys) +++ "among" ++++ 
         unlines ["  " ++ unwords (map (prtType env) ty) | (ty,_) <- typs] ++
         maybe [] (("with value type" +++) . prtType env) mt

      ----  ++++ "DEBUG" +++ unwords (map show tys) +++ ";" 
      ----  ++++ unlines (map (show . fst) typs) ----

       vfs' -> case [(v,f) | (v,f) <- vfs', noProd v] of
         [(val,fun)] -> do
           checkWarn $ "WARNING: overloading of" +++ prt f +++ 
             "resolved by excluding partial applications:" ++++
             unlines [prtType env ty | (ty,_) <- vfs', not (noProd ty)]
           return (mkApp fun tts, val)

         _ -> raise $ "ambiguous overloading of" +++ prt f +++
           "for" +++ unwords (map (prtType env) tys) ++++ "with alternatives" ++++ 
           unlines [prtType env ty | (ty,_) <- vfs']

   matchVal mt v = elem mt ([Nothing,Just v] ++ unlocked) where
     unlocked = case v of
       RecType fs -> [Just $ RecType $ filter (not . isLockLabel . fst) fs]
       _ -> []
   ---- TODO: accept subtypes
   ---- TODO: use a trie
   lookupOverloadInstance tys typs = 
     [(mkFunType rest val, t) | 
       let lt = length tys,
       (ty,(val,t)) <- typs, length ty >= lt,
       let (pre,rest) = splitAt lt ty, 
       pre == tys
     ]

   noProd ty = case ty of
     Prod _ _ _ -> False
     _ -> True

checkLType :: SourceGrammar -> Term -> Type -> Check (Term, Type)
checkLType env trm typ0 = do

  typ <- comp typ0

  case trm of

    Abs x c -> do
      case typ of
        Prod z a b -> do 
          checkUpdate (x,a)
          (c',b') <- if isWildIdent z
                        then check c b
                        else do
                          b' <- checkIn "abs" $ substituteLType [(z,Vr x)] b
                          check c b'
          checkReset
          return $ (Abs x c', Prod x a b')
        _ -> raise $ "product expected instead of" +++ prtType env typ

    App f a -> do
       over <- getOverload env (Just typ) trm
       case over of
         Just trty -> return trty
         _ -> do
          (trm',ty') <- infer trm
          termWith trm' $ checkEq typ ty' trm'

    Q _ _ -> do
       over <- getOverload env (Just typ) trm
       case over of
         Just trty -> return trty
         _ -> do
          (trm',ty') <- infer trm
          termWith trm' $ checkEq typ ty' trm'

    T _ [] ->
      prtFail "found empty table in type" typ
    T _ cs -> case typ of 
      Table arg val -> do 
        case allParamValues env arg of
          Ok vs -> do
            let ps0 = map fst cs
            ps <- checkErr $ testOvershadow ps0 vs
            if null ps 
              then return () 
              else checkWarn $ "WARNING: patterns never reached:" +++ 
                               concat (intersperse ", " (map prt ps))

          _ -> return () -- happens with variable types
        cs' <- mapM (checkCase arg val) cs
        return (T (TTyped arg) cs', typ)
      _ -> raise $ "table type expected for table instead of" +++ prtType env typ

    R r -> case typ of --- why needed? because inference may be too difficult
       RecType rr -> do
         let (ls,_) = unzip rr        -- labels of expected type
         fsts <- mapM (checkM r) rr   -- check that they are found in the record
         return $ (R fsts, typ)       -- normalize record

       _ -> prtFail "record type expected in type checking instead of" typ

    ExtR r s -> case typ of
       _ | typ == typeType -> do
         trm' <- comp trm
         case trm' of
           RecType _ -> termWith trm $ return typeType
           ExtR (Vr _) (RecType _) -> termWith trm $ return typeType 
                                      -- ext t = t ** ...
           _ -> prtFail "invalid record type extension" trm
       RecType rr -> do
         (r',ty,s') <- checks [
            do (r',ty) <- infer r
               return (r',ty,s)
           ,
            do (s',ty) <- infer s
               return (s',ty,r)
            ]
         case ty of
           RecType rr1 -> do
                let (rr0,rr2) = recParts rr rr1
                r2 <- justCheck r' rr0
                s2 <- justCheck s' rr2
                return $ (ExtR r2 s2, typ) 
           _ -> raise ("record type expected in extension of" +++ prt r +++ 
                       "but found" +++ prt ty)

       ExtR ty ex -> do
         r' <- justCheck r ty
         s' <- justCheck s ex
         return $ (ExtR r' s', typ) --- is this all?

       _ -> prtFail "record extension not meaningful for" typ

    FV vs -> do
      ttys <- mapM (flip check typ) vs
---      checkIfComplexVariantType trm typ
      return (FV (map fst ttys), typ) --- typ' ?

    S tab arg -> checks [ do
      (tab',ty) <- infer tab
      ty'       <- comp ty
      case ty' of
        Table p t -> do
          (arg',val) <- check arg p
          checkEq typ t trm
          return (S tab' arg', t)
        _ -> raise $ "table type expected for applied table instead of" +++ 
                   prtType env ty'
     , do
      (arg',ty) <- infer arg
      ty'       <- comp ty
      (tab',_)  <- check tab (Table ty' typ)
      return (S tab' arg', typ)
      ]
    Let (x,(mty,def)) body -> case mty of
      Just ty -> do
        (def',ty') <- check def ty
        checkUpdate (x,ty')
        body' <- justCheck body typ
        checkReset
        return (Let (x,(Just ty',def')) body', typ)
      _ -> do
        (def',ty) <- infer def  -- tries to infer type of local constant
        check (Let (x,(Just ty,def')) body) typ

    _ -> do
      (trm',ty') <- infer trm
      termWith trm' $ checkEq typ ty' trm'
 where
   cnc = env
   infer = inferLType env
   comp = computeLType env 

   check = checkLType env
   
   justCheck ty te = check ty te >>= return . fst

   checkEq = checkEqLType env

   recParts rr t = (RecType rr1,RecType rr2) where 
     (rr1,rr2) = partition (flip elem (map fst t) . fst) rr 

   checkM rms (l,ty) = case lookup l rms of
     Just (Just ty0,t) -> do
       checkEq ty ty0 t
       (t',ty') <- check t ty
       return (l,(Just ty',t'))
     Just (_,t) -> do
       (t',ty') <- check t ty
       return (l,(Just ty',t'))
     _ -> prtFail "cannot find value for label" l

   checkCase arg val (p,t) = do
     cont <- pattContext env arg p
     i    <- checkUpdates cont
     t'   <- justCheck t val
     checkResets i
     return (p,t')

pattContext :: LTEnv -> Type -> Patt -> Check Context
pattContext env typ p = case p of
  PV x | not (isWildIdent x) -> return [(x,typ)]
  PP q c ps | q /= cPredef -> do ---- why this /=? AR 6/1/2006
    t <- checkErr $ lookupResType cnc q c
    (cont,v) <- checkErr $ typeFormCnc t
    checkCond ("wrong number of arguments for constructor in" +++ prt p) 
              (length cont == length ps)
    checkEqLType env typ v (patt2term p)
    mapM (uncurry (pattContext env)) (zip (map snd cont) ps) >>= return . concat
  PR r -> do
    typ' <- computeLType env typ
    case typ' of
      RecType t -> do
        let pts = [(ty,tr) | (l,tr) <- r, Just ty <- [lookup l t]]
        ----- checkWarn $ prt p ++++ show pts ----- debug
        mapM (uncurry (pattContext env)) pts >>= return . concat
      _ -> prtFail "record type expected for pattern instead of" typ'
  PT t p' -> do
    checkEqLType env typ t (patt2term p')
    pattContext env typ p'

  PAs x p -> do
    g <- pattContext env typ p
    return $ (x,typ):g

  PAlt p' q -> do
    g1 <- pattContext env typ p'
    g2 <- pattContext env typ q
    let pts = [pt | pt <- g1, notElem pt g2] ++ [pt | pt <- g2, notElem pt g1]
    checkCond 
      ("incompatible bindings of" +++ 
       unwords (nub (map (prt . fst) pts))+++ 
       "in pattern alterantives" +++ prt p) (null pts) 
    return g1 -- must be g1 == g2
  PSeq p q -> do
    g1 <- pattContext env typ p
    g2 <- pattContext env typ q
    return $ g1 ++ g2
  PRep p' -> noBind typeStr p'
  PNeg p' -> noBind typ p'

  _ -> return [] ---- check types!
 where 
   cnc = env
   noBind typ p' = do
    co <- pattContext env typ p'
    if not (null co)
      then checkWarn ("no variable bound inside pattern" +++ prt p) 
           >> return []
      else return []

-- auxiliaries

type LTEnv = SourceGrammar

termWith :: Term -> Check Type -> Check (Term, Type)
termWith t ct = do
  ty <- ct
  return (t,ty)

-- | light-weight substitution for dep. types
substituteLType :: Context -> Type -> Check Type
substituteLType g t = case t of
  Vr x -> return $ maybe t id $ lookup x g
  _ -> composOp (substituteLType g) t

-- | compositional check\/infer of binary operations
check2 :: (Term -> Check Term) -> (Term -> Term -> Term) -> 
          Term -> Term -> Type -> Check (Term,Type)
check2 chk con a b t = do
  a' <- chk a
  b' <- chk b
  return (con a' b', t)

checkEqLType :: LTEnv -> Type -> Type -> Term -> Check Type
checkEqLType env t u trm = do
  (b,t',u',s) <- checkIfEqLType env t u trm
  case b of
    True  -> return t'
    False -> raise $ s +++ "type of" +++ prt trm +++ 
                        ": expected:" +++ prtType env t ++++ 
                        "inferred:" +++ prtType env u

checkIfEqLType :: LTEnv -> Type -> Type -> Term -> Check (Bool,Type,Type,String)
checkIfEqLType env t u trm = do
  t' <- comp t 
  u' <- comp u
  case t' == u' || alpha [] t' u' of
    True -> return (True,t',u',[])
    -- forgive missing lock fields by only generating a warning.
    --- better: use a flag to forgive? (AR 31/1/2006)
    _ -> case missingLock [] t' u' of
      Ok lo -> do
        checkWarn $ "WARNING: missing lock field" +++ unwords (map prt lo)
        return (True,t',u',[])
      Bad s -> return (False,t',u',s)

  where

   -- t is a subtype of u 
   --- quick hack version of TC.eqVal
   alpha g t u = case (t,u) of  

     -- error (the empty type!) is subtype of any other type
     (_,u) | u == typeError -> True

     -- contravariance
     (Prod x a b, Prod y c d) -> alpha g c a && alpha ((x,y):g) b d 
                              
     -- record subtyping
     (RecType rs, RecType ts) -> all (\ (l,a) -> 
                                   any (\ (k,b) -> alpha g a b && l == k) ts) rs
     (ExtR r s, ExtR r' s') -> alpha g r r' && alpha g s s'
     (ExtR r s, t) -> alpha g r t || alpha g s t

     -- the following say that Ints n is a subset of Int and of Ints m >= n
     (t,u) | Just m <- isTypeInts t, Just n <- isTypeInts t -> m >= n
           | Just _ <- isTypeInts t, u == typeInt           -> True ---- check size!
           | t == typeInt,           Just _ <- isTypeInts t -> True ---- why this ???? AR 11/12/2005

     ---- this should be made in Rename
     (Q  m a, Q  n b) | a == b -> elem m (allExtendsPlus env n) 
                               || elem n (allExtendsPlus env m)
                               || m == n --- for Predef
     (QC m a, QC n b) | a == b -> elem m (allExtendsPlus env n) 
                               || elem n (allExtendsPlus env m)
     (QC m a, Q  n b) | a == b -> elem m (allExtendsPlus env n) 
                               || elem n (allExtendsPlus env m)
     (Q  m a, QC n b) | a == b -> elem m (allExtendsPlus env n) 
                               || elem n (allExtendsPlus env m)

     (Table a b,  Table c d)  -> alpha g a c && alpha g b d
     (Vr x,       Vr y)       -> x == y || elem (x,y) g || elem (y,x) g
     _                        -> t == u 
     --- the following should be one-way coercions only. AR 4/1/2001
                                  || elem t sTypes && elem u sTypes
                                  || (t == typeType && u == typePType) 
                                  || (u == typeType && t == typePType) 

   missingLock g t u = case (t,u) of  
     (RecType rs, RecType ts) -> 
       let 
         ls = [l | (l,a) <- rs, 
                   not (any (\ (k,b) -> alpha g a b && l == k) ts)]
         (locks,others) = partition isLockLabel ls
       in case others of
         _:_ -> Bad $ "missing record fields" +++ unwords (map prt others)
         _ -> return locks
     -- contravariance
     (Prod x a b, Prod y c d) -> do
        ls1 <- missingLock g c a
        ls2 <- missingLock g b d
        return $ ls1 ++ ls2

     _ -> Bad ""

   sTypes = [typeStr, typeTok, typeString]
   comp = computeLType env

-- printing a type with a lock field lock_C as C
prtType :: LTEnv -> Type -> String
prtType env ty = case ty of
  RecType fs -> case filter isLockLabel $ map fst fs of
    [lock] -> (drop 5 $ prt lock) --- ++++ "Full form" +++ prt ty
    _ -> prtt ty
  Prod x a b -> prtType env a +++ "->" +++ prtType env b
  _ -> prtt ty
 where
   prtt t = prt t
   ---- use computeLType gr to check if really equal to the cat with lock


-- | linearization types and defaults
linTypeOfType :: SourceGrammar -> Ident -> Type -> Check (Context,Type)
linTypeOfType cnc m typ = do
  (cont,cat) <- checkErr $ typeSkeleton typ
  val  <- lookLin cat
  args <- mapM mkLinArg (zip [0..] cont)
  return (args, val)
 where
   mkLinArg (i,(n,mc@(m,cat))) = do
     val  <- lookLin mc
     let vars = mkRecType varLabel $ replicate n typeStr
	 symb = argIdent n cat i
     rec <- if n==0 then return val else
            checkErr $ errIn ("extending" +++ prt vars +++ "with" +++ prt val) $
            plusRecType vars val
     return (symb,rec)
   lookLin (_,c) = checks [ --- rather: update with defLinType ?
      checkErr (lookupLincat cnc m c) >>= computeLType cnc
     ,return defLinType
     ]

-- | dependency check, detecting circularities and returning topo-sorted list

allOperDependencies :: Ident -> BinTree Ident Info -> [(Ident,[Ident])]
allOperDependencies m = allDependencies (==m)

allDependencies :: (Ident -> Bool) -> BinTree Ident Info -> [(Ident,[Ident])]
allDependencies ism b = 
  [(f, nub (concatMap opty (pts i))) | (f,i) <- tree2list b]
  where
    opersIn t = case t of
      Q n c | ism n -> [c]
      QC n c | ism n -> [c]
      _ -> collectOp opersIn t
    opty (Yes ty) = opersIn ty
    opty _ = []
    pts i = case i of
      ResOper pty pt -> [pty,pt]
      ResParam (Yes (ps,_)) -> [Yes t | (_,cont) <- ps, (_,t) <- cont]
      CncCat pty _ _ -> [pty]
      CncFun _   pt _ -> [pt]  ---- (Maybe (Ident,(Context,Type))
      AbsFun pty ptr -> [pty] --- ptr is def, which can be mutual
      AbsCat (Yes co) _ -> [Yes ty | (_,ty) <- co]
      _              -> []

topoSortOpers :: [(Ident,[Ident])] -> Err [Ident]
topoSortOpers st = do
  let eops = topoTest st
  either 
    return 
    (\ops -> Bad ("circular definitions:" +++ unwords (map prt (head ops))))
    eops
