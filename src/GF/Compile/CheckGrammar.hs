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

module GF.Compile.CheckGrammar (
  showCheckModule, justCheckLTerm, allOperDependencies, topoSortOpers) where

import GF.Infra.Ident
import GF.Infra.Modules

import GF.Compile.TypeCheck

import GF.Compile.Refresh
import GF.Grammar.Lexer
import GF.Grammar.Grammar
import GF.Grammar.Printer
import GF.Grammar.Lookup
import GF.Grammar.Predef
import GF.Grammar.Macros
import GF.Grammar.PatternMatch
import GF.Grammar.AppPredefined
import GF.Grammar.Lockfield (isLockLabel, lockRecType, unlockRecord)

import GF.Data.Operations
import GF.Infra.CheckM

import Data.List
import qualified Data.Set as Set
import Control.Monad
import Text.PrettyPrint

showCheckModule :: [SourceModule] -> SourceModule -> Err ([SourceModule],String)
showCheckModule mos m =
  case runCheck (checkModule mos m) of
    Left        msgs  -> Bad (   render (vcat (reverse msgs)))
    Right (st,_,msgs) -> Ok (st, render (vcat (reverse msgs)))

-- | checking is performed in the dependency order of modules
checkModule :: [SourceModule] -> SourceModule -> Check [SourceModule]
checkModule ms (name,mo) = checkIn (text "checking module" <+> ppIdent name) $ do
    let js = jments mo
    checkRestrictedInheritance ms (name, mo)
    js' <- case mtype mo of
      MTAbstract -> checkMap (checkAbsInfo gr name mo) js

      MTTransfer a b -> checkMap (checkAbsInfo gr name mo) js

      MTResource -> checkMap (checkResInfo gr name mo) js

      MTConcrete a -> do
        checkErr $ topoSortOpers $ allOperDependencies name js
        abs <- checkErr $ lookupModule gr a
        js1 <- checkCompleteGrammar gr abs mo
        checkMap (checkCncInfo gr name mo (a,abs)) js1

      MTInterface -> checkMap (checkResInfo gr name mo) js

      MTInstance a -> do
        checkMap (checkResInfo gr name mo) js

    return $ (name, replaceJudgements mo js') : ms
 where
   gr  = MGrammar $ (name,mo):ms

-- check if restricted inheritance modules are still coherent
-- i.e. that the defs of remaining names don't depend on omitted names
checkRestrictedInheritance :: [SourceModule] -> SourceModule -> Check ()
checkRestrictedInheritance mos (name,mo) = do
  let irs = [ii | ii@(_,mi) <- extend mo, mi /= MIAll]  -- names with restr. inh.
  let mrs = [((i,m),mi) | (i,m) <- mos, Just mi <- [lookup i irs]] 
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
       cs -> checkError (text "In inherited module" <+> ppIdent i <> text ", dependence of excluded constants:" $$
                         nest 2 (vcat [ppIdent f <+> text "on" <+> fsep (map ppIdent is) | (f,is) <- cs]))
   allDeps = concatMap (allDependencies (const True) . jments . snd) mos

-- | check if a term is typable
justCheckLTerm :: SourceGrammar -> Term -> Err Term
justCheckLTerm src t =
  case runCheck (inferLType src t) of
    Left msgs          -> Bad (   render (vcat (reverse msgs)))
    Right ((t',_),_,_) -> Ok t'

checkAbsInfo :: 
  SourceGrammar -> Ident -> SourceModInfo -> Ident -> Info -> Check Info
checkAbsInfo st m mo c info = do
 checkReservedId c
 case info of
   AbsCat (Just cont) _ -> mkCheck "category" $ 
     checkContext st cont ---- also cstrs
   AbsFun (Just typ0) ma md -> do
     typ <- compAbsTyp [] typ0   -- to calculate let definitions
     mkCheck "type of function" $
       checkTyp st typ
     case md of
       Just eqs -> mkCheck "definition of function" $
	             checkDef st (m,c) typ eqs
       Nothing  -> return info
     return $ (AbsFun (Just typ) ma md)
   _ -> return info
 where
   mkCheck cat ss = case ss of
     [] -> return info
     _  -> checkError (vcat (map text ss) $$ text "in" <+> text cat <+> ppIdent c <+> ppPosition mo c)

   compAbsTyp g t = case t of
     Vr x -> maybe (checkError (text "no value given to variable" <+> ppIdent x)) return $ lookup x g
     Let (x,(_,a)) b -> do
       a' <- compAbsTyp g a
       compAbsTyp ((x, a'):g) b
     Prod x a b -> do
       a' <- compAbsTyp g a
       b' <- compAbsTyp ((x,Vr x):g) b
       return $ Prod x a' b'
     Abs _ _ -> return t
     _ -> composOp (compAbsTyp g) t

checkCompleteGrammar :: SourceGrammar -> SourceModInfo -> SourceModInfo -> Check (BinTree Ident Info)
checkCompleteGrammar gr abs cnc = do
  let jsa = jments abs
  let fsa = tree2list jsa
  let jsc = jments cnc
  let fsc = map fst $ filter (isCnc . snd) $ tree2list jsc

  -- remove those lincat and lin in concrete that are not in abstract
  let unkn = filter (not . flip isInBinTree jsa) fsc
  jsc1 <- if (null unkn) then return jsc else do
    checkWarn $ text "ignoring constants not in abstract:" <+> fsep (map ppIdent unkn)
    return $ filterBinTree (\f _ -> notElem f unkn) jsc 

  -- check that all abstract constants are in concrete; build default lincats
  foldM checkOne jsc1 fsa
 where
   isCnc j = case j of
     CncFun _ _ _ -> True
     CncCat _ _ _ -> True
     _ -> False
   checkOne js i@(c,info) = case info of
     AbsFun (Just ty) _ _ -> do let mb_def = do
                                      (cxt,(_,i),_) <- typeForm ty
                                      info <- lookupIdent i js
                                      info <- case info of
                                                (AnyInd _ m) -> do (m,info) <- lookupOrigInfo gr m i
                                                                   return info
                                                _            -> return info
                                      case info of
                                        CncCat (Just (RecType [])) _ _ -> return (foldr (\_ -> Abs identW) (R []) cxt)
                                        _                              -> Bad "no def lin"
                                case lookupIdent c js of
                                  Ok (CncFun _   (Just _) _ ) -> return js
                                  Ok (CncFun cty Nothing  pn) ->
                                    case mb_def of
                                      Ok def -> return $ updateTree (c,CncFun cty (Just def) pn) js
                                      Bad _  -> do checkWarn $ text "no linearization of" <+> ppIdent c
                                                   return js
                                  _ -> do
                                    case mb_def of
                                      Ok def -> return $ updateTree (c,CncFun Nothing (Just def) Nothing) js
                                      Bad _  -> do checkWarn $ text "no linearization of" <+> ppIdent c
                                                   return js
     AbsCat (Just _) _ -> case lookupIdent c js of
       Ok (AnyInd _ _) -> return js
       Ok (CncCat (Just _) _ _) -> return js
       Ok (CncCat _ mt mp) -> do
         checkWarn $ 
           text "no linearization type for" <+> ppIdent c <> text ", inserting default {s : Str}"
         return $ updateTree (c,CncCat (Just defLinType) mt mp) js
       _ -> do
         checkWarn $ 
           text "no linearization type for" <+> ppIdent c <> text ", inserting default {s : Str}"
         return $ updateTree (c,CncCat (Just defLinType) Nothing Nothing) js
     _ -> return js

-- | General Principle: only Just-values are checked. 
-- A May-value has always been checked in its origin module.
checkResInfo :: SourceGrammar -> Ident -> SourceModInfo -> Ident -> Info -> Check Info
checkResInfo gr mo mm c info = do
  checkReservedId c
  case info of
    ResOper pty pde -> chIn "operation" $ do
      (pty', pde') <- case (pty,pde) of
         (Just ty, Just de) -> do
           ty'     <- check ty typeType >>= comp . fst
           (de',_) <- check de ty'
           return (Just ty', Just de')
         (_      , Just de) -> do
           (de',ty') <- infer de
           return (Just ty', Just de')
         (_      , Nothing) -> do
           checkError (text "No definition given to the operation")
      return (ResOper pty' pde')

    ResOverload os tysts -> chIn "overloading" $ do
      tysts' <- mapM (uncurry $ flip check) tysts  -- return explicit ones
      tysts0 <- checkErr $ lookupOverload gr mo c  -- check against inherited ones too
      tysts1 <- mapM (uncurry $ flip check) 
                  [(mkFunType args val,tr) | (args,(val,tr)) <- tysts0]
      --- this can only be a partial guarantee, since matching
      --- with value type is only possible if expected type is given
      checkUniq $ 
        sort [t : map snd xs | (_,x) <- tysts1, Ok (xs,t) <- [typeFormCnc x]]
      return (ResOverload os [(y,x) | (x,y) <- tysts'])

    ResParam (Just (pcs,_)) -> chIn "parameter type" $ do
      ts <- checkErr $ lookupParamValues gr mo c
      return (ResParam (Just (pcs, Just ts)))

    _ ->  return info
 where
   infer = inferLType gr
   check = checkLType gr
   chIn cat = checkIn (text "Happened in" <+> text cat <+> ppIdent c <+> ppPosition mm c <+> colon)
   comp = computeLType gr

   checkUniq xss = case xss of
     x:y:xs 
      | x == y    -> checkError $ text "ambiguous for type" <+>
                                  ppType gr (mkFunType (tail x) (head x))  
      | otherwise -> checkUniq $ y:xs
     _ -> return ()


checkCncInfo :: SourceGrammar -> Ident -> SourceModInfo -> 
                (Ident,SourceModInfo) -> 
                Ident -> Info -> Check Info
checkCncInfo gr m mo (a,abs) c info = do
  checkReservedId c
  case info of

    CncFun _ (Just trm) mpr -> chIn "linearization of" $ do
      typ        <- checkErr $ lookupFunType gr a c
      cat0       <- checkErr $ valCat typ
      (cont,val) <- linTypeOfType gr m typ         -- creates arg vars
      (trm',_)   <- check trm (mkFunType (map snd cont) val)  -- erases arg vars
      checkPrintname gr mpr
      cat        <- return $ snd cat0
      return (CncFun (Just (cat,(cont,val))) (Just trm') mpr)
                                                   -- cat for cf, typ for pe

    CncCat (Just typ) mdef mpr -> chIn "linearization type of" $ do
      checkErr $ lookupCatContext gr a c
      typ'  <- computeLType gr typ
      mdef' <- case mdef of
        Just def -> do
          (def',_) <- checkLType gr def (mkFunType [typeStr] typ)
          return $ Just def'
        _ -> return mdef
      checkPrintname gr mpr
      return (CncCat (Just typ') mdef' mpr)

    _ -> checkResInfo gr m mo c info

 where
   env = gr
   infer = inferLType gr
   comp = computeLType gr 
   check = checkLType gr
   chIn cat = checkIn (text "Happened in" <+> text cat <+> ppIdent c <+> ppPosition mo c <> colon)

computeLType :: SourceGrammar -> Type -> Check Type
computeLType gr t = do
  g0 <- checkGetContext
  let g = [(x, Vr x) | (x,_) <- g0]
  checkInContext g $ comp t
 where
  comp ty = case ty of
    _ | Just _ <- isTypeInts ty -> return ty ---- shouldn't be needed
      | isPredefConstant ty     -> return ty ---- shouldn't be needed

    Q m ident -> checkIn (text "module" <+> ppIdent m) $ do
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
      let fs' = sortRec fs
      liftM RecType $ mapPairsM comp fs'

    ELincat c t -> do
      t' <- comp t
      checkErr $ lockRecType c t' ---- locking to be removed AR 20/6/2009

    _ | ty == typeTok -> return typeStr
    _ | isPredefConstant ty -> return ty

    _ -> composOp comp ty

checkPrintname :: SourceGrammar -> Maybe Term -> Check ()
checkPrintname st (Just t) = checkLType st t typeStr >> return ()
checkPrintname _  _        = return ()

-- | for grammars obtained otherwise than by parsing ---- update!!
checkReservedId :: Ident -> Check ()
checkReservedId x
  | isReservedWord (ident2bs x) = checkWarn (text "reserved word used as identifier:" <+> ppIdent x)
  | otherwise                   = return ()

-- the underlying algorithms

inferLType :: SourceGrammar -> Term -> Check (Term, Type)
inferLType gr trm = case trm of

   Q m ident | isPredef m -> termWith trm $ checkErr (typPredefined ident)

   Q m ident -> checks [
     termWith trm $ checkErr (lookupResType gr m ident) >>= comp
     ,
     checkErr (lookupResDef gr m ident) >>= infer
     ,
     checkError (text "cannot infer type of constant" <+> ppTerm Unqualified 0 trm)
     ]

   QC m ident | isPredef m -> termWith trm $ checkErr (typPredefined ident)

   QC m ident -> checks [
       termWith trm $ checkErr (lookupResType gr m ident) >>= comp
       ,
       checkErr (lookupResDef gr m ident) >>= infer
       ,
       checkError (text "cannot infer type of canonical constant" <+> ppTerm Unqualified 0 trm)
       ]

   Val _ ty i -> termWith trm $ return ty

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
           _ -> checkError (text "A function type is expected for" <+> ppTerm Unqualified 0 f <+> text "instead of type" <+> ppType env fty)

   S f x -> do
     (f', fty) <- infer f
     case fty of
       Table arg val -> do
         x'<- justCheck x arg
         return (S f' x', val)
       _ -> checkError (text "table lintype expected for the table in" $$ nest 2 (ppTerm Unqualified 0 trm))

   P t i -> do
     (t',ty) <- infer t   --- ??
     ty' <- comp ty
     let tr2 = P t' i
     termWith tr2 $ case ty' of
       RecType ts -> case lookup i ts of
                       Nothing -> checkError (text "unknown label" <+> ppLabel i <+> text "in" $$ nest 2 (ppTerm Unqualified 0 ty'))
                       Just x  -> return x
       _          -> checkError (text "record type expected for:" <+> ppTerm Unqualified 0 t $$
                                 text " instead of the inferred:" <+> ppTerm Unqualified 0 ty')
   PI t i _ -> infer $ P t i

   R r -> do
     let (ls,fs) = unzip r
     fsts <- mapM inferM fs
     let ts = [ty | (Just ty,_) <- fsts]
     checkCond (text "cannot infer type of record" $$ nest 2 (ppTerm Unqualified 0 trm)) (length ts == length fsts)
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
       [] -> checkError (text "cannot infer table type of" <+> ppTerm Unqualified 0 trm)
----       PInt k : _ -> return $ Ints $ max [i | PInt i <- pts'] 
       _  -> do 
         (arg,val) <- checks $ map (inferCase Nothing) pts'
         check trm (Table arg val)
   V arg pts -> do
     (_,val) <- checks $ map infer pts
     return (trm, Table arg val)

   K s  -> do
     if elem ' ' s
        then do
          let ss = foldr C Empty (map K (words s))  
          ----- removed irritating warning AR 24/5/2008
          ----- checkWarn ("token \"" ++ s ++ 
          -----              "\" converted to token list" ++ prt ss)
          return (ss, typeStr)
        else return (trm, typeStr)

   EInt i -> return (trm, typeInt)

   EFloat i -> return (trm, typeFloat)

   Empty -> return (trm, typeStr)

   C s1 s2 -> 
     check2 (flip justCheck typeStr) C s1 s2 typeStr

   Glue s1 s2 -> 
     check2 (flip justCheck typeStr) Glue s1 s2 typeStr ---- typeTok

---- hack from Rename.identRenameTerm, to live with files with naming conflicts 18/6/2007
   Strs (Cn c : ts) | c == cConflict -> do
     checkWarn (text "unresolved constant, could be any of" <+> hcat (map (ppTerm Unqualified 0) ts))
     infer (head ts)

   Strs ts -> do
     ts' <- mapM (\t -> justCheck t typeStr) ts 
     return (Strs ts', typeStrs)

   Alts (t,aa) -> do
     t'  <- justCheck t typeStr
     aa' <- flip mapM aa (\ (c,v) -> do
        c' <- justCheck c typeStr 
        v' <- checks $ map (justCheck v) [typeStrs, EPattType typeStr]
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
       _ -> checkError (text "records or record types expected in" <+> ppTerm Unqualified 0 trm)

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
     return (EPattType ty',typeType)
   EPatt p -> do
     ty <- inferPatt p
     return (trm, EPattType ty)

   ELin c trm -> do
     (trm',ty) <- infer trm
     ty' <- checkErr $ lockRecType c ty ---- lookup c; remove lock AR 20/6/2009
     return $ (ELin c trm', ty') 

   _ -> checkError (text "cannot infer lintype of" <+> ppTerm Unqualified 0 trm)

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
getOverload env@gr mt ot = case appForm ot of
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
     let matches = [vf | vf@((v,_),_) <- vfs, matchVal mt v]

     case ([vf | (vf,True) <- matches],[vf | (vf,False) <- matches]) of
       ([(val,fun)],_) -> return (mkApp fun tts, val)
       ([],[(val,fun)]) -> do
         checkWarn (text "ignoring lock fields in resolving" <+> ppTerm Unqualified 0 ot) 
         return (mkApp fun tts, val)
       ([],[]) -> do
         ---- let prtType _ = prt  -- to debug grammars
         let showTypes ty = vcat (map (ppType env) ty)
         checkError $ text "no overload instance of" <+> ppTerm Unqualified 0 f $$
                      text "for" $$
                      nest 2 (showTypes tys) $$
                      text "among" $$
                      nest 2 (vcat [showTypes ty | (ty,_) <- typs]) $$
                      maybe empty (\x -> text "with value type" <+> ppType env x) mt

       (vfs1,vfs2) -> case (noProds vfs1,noProds vfs2) of
         ([(val,fun)],_) -> do
           return (mkApp fun tts, val)
         ([],[(val,fun)]) -> do
           checkWarn (text "ignoring lock fields in resolving" <+> ppTerm Unqualified 0 ot) 
           return (mkApp fun tts, val)

----- unsafely exclude irritating warning AR 24/5/2008
-----           checkWarn $ "overloading of" +++ prt f +++ 
-----             "resolved by excluding partial applications:" ++++
-----             unlines [prtType env ty | (ty,_) <- vfs', not (noProd ty)]


         _ -> checkError $ text "ambiguous overloading of" <+> ppTerm Unqualified 0 f <+>
                           text "for" <+> hsep (map (ppType env) tys) $$ 
                           text "with alternatives" $$
                           nest 2 (vcat [ppType env ty | (ty,_) <- if null vfs1 then vfs2 else vfs2])

   matchVal mt v = elem mt [Nothing,Just v,Just (unlocked v)]

   unlocked v = case v of
     RecType fs -> RecType $ filter (not . isLockLabel . fst) fs
     _ -> v
   ---- TODO: accept subtypes
   ---- TODO: use a trie
   lookupOverloadInstance tys typs = 
     [((mkFunType rest val, t),isExact) | 
       let lt = length tys,
       (ty,(val,t)) <- typs, length ty >= lt,
       let (pre,rest) = splitAt lt ty, 
       let isExact = pre == tys,
       isExact || map unlocked pre == map unlocked tys
     ]

   noProds vfs = [(v,f) | (v,f) <- vfs, noProd v]

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
                          b' <- checkIn (text "abs") $ substituteLType [(z,Vr x)] b
                          check c b'
          checkReset
          return $ (Abs x c', Prod x a b')
        _ -> checkError $ text "function type expected instead of" <+> ppType env typ

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
      checkError (text "found empty table in type" <+> ppTerm Unqualified 0 typ)
    T _ cs -> case typ of 
      Table arg val -> do 
        case allParamValues env arg of
          Ok vs -> do
            let ps0 = map fst cs
            ps <- checkErr $ testOvershadow ps0 vs
            if null ps 
              then return () 
              else checkWarn (text "patterns never reached:" $$
                              nest 2 (vcat (map (ppPatt Unqualified 0) ps)))
          _ -> return () -- happens with variable types
        cs' <- mapM (checkCase arg val) cs
        return (T (TTyped arg) cs', typ)
      _ -> checkError $ text "table type expected for table instead of" $$ nest 2 (ppType env typ)

    R r -> case typ of --- why needed? because inference may be too difficult
       RecType rr -> do
         let (ls,_) = unzip rr        -- labels of expected type
         fsts <- mapM (checkM r) rr   -- check that they are found in the record
         return $ (R fsts, typ)       -- normalize record

       _ -> checkError (text "record type expected in type checking instead of" $$ nest 2 (ppTerm Unqualified 0 typ))

    ExtR r s -> case typ of
       _ | typ == typeType -> do
         trm' <- comp trm
         case trm' of
           RecType _ -> termWith trm $ return typeType
           ExtR (Vr _) (RecType _) -> termWith trm $ return typeType 
                                      -- ext t = t ** ...
           _ -> checkError (text "invalid record type extension" <+> nest 2 (ppTerm Unqualified 0 trm))
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
           _ -> checkError (text "record type expected in extension of" <+> ppTerm Unqualified 0 r $$
                            text "but found" <+> ppTerm Unqualified 0 ty)

       ExtR ty ex -> do
         r' <- justCheck r ty
         s' <- justCheck s ex
         return $ (ExtR r' s', typ) --- is this all?

       _ -> checkError (text "record extension not meaningful for" <+> ppTerm Unqualified 0 typ)

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
        _ -> checkError (text "table type expected for applied table instead of" <+> ppType env ty')
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

    ELin c tr -> do
      tr1 <- checkErr $ unlockRecord c tr
      check tr1 typ

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
     _ -> checkError $ 
            if isLockLabel l 
              then let cat = drop 5 (showIdent (label2ident l))
                   in ppTerm Unqualified 0 (R rms) <+> text "is not in the lincat of" <+> text cat <> 
                      text "; try wrapping it with lin" <+> text cat
              else text "cannot find value for label" <+> ppLabel l <+> text "in" <+> ppTerm Unqualified 0 (R rms)

   checkCase arg val (p,t) = do
     cont <- pattContext env arg p
     i    <- checkUpdates cont
     t'   <- justCheck t val
     checkResets i
     return (p,t')

pattContext :: LTEnv -> Type -> Patt -> Check Context
pattContext env typ p = case p of
  PV x -> return [(x,typ)]
  PP q c ps | q /= cPredef -> do ---- why this /=? AR 6/1/2006
    t <- checkErr $ lookupResType cnc q c
    (cont,v) <- checkErr $ typeFormCnc t
    checkCond (text "wrong number of arguments for constructor in" <+> ppPatt Unqualified 0 p) 
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
      _ -> checkError (text "record type expected for pattern instead of" <+> ppTerm Unqualified 0 typ')
  PT t p' -> do
    checkEqLType env typ t (patt2term p')
    pattContext env typ p'

  PAs x p -> do
    g <- pattContext env typ p
    return $ (x,typ):g

  PAlt p' q -> do
    g1 <- pattContext env typ p'
    g2 <- pattContext env typ q
    let pts = nub ([fst pt | pt <- g1, notElem pt g2] ++ [fst pt | pt <- g2, notElem pt g1])
    checkCond 
      (text "incompatible bindings of" <+>
       fsep (map ppIdent pts) <+> 
       text "in pattern alterantives" <+> ppPatt Unqualified 0 p) (null pts) 
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
      then checkWarn (text "no variable bound inside pattern" <+> ppPatt Unqualified 0 p) 
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
    False -> checkError $ text s <+> text "type of" <+> ppTerm Unqualified 0 trm $$
                          text "expected:" <+> ppType env t $$
                          text "inferred:" <+> ppType env u

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
        checkWarn $ text "missing lock field" <+> fsep (map ppLabel lo)
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
           | t == typeInt,           Just _ <- isTypeInts u -> True ---- why this ???? AR 11/12/2005

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
         _:_ -> Bad $ render (text "missing record fields:" <+> fsep (punctuate comma (map ppLabel others)))
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
ppType :: LTEnv -> Type -> Doc
ppType env ty =
  case ty of
    RecType fs -> case filter isLockLabel $ map fst fs of
                    [lock] -> text (drop 5 (showIdent (label2ident lock)))
                    _      -> ppTerm Unqualified 0 ty
    Prod x a b -> ppType env a <+> text "->" <+> ppType env b
    _          -> ppTerm Unqualified 0 ty

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
            checkErr $ errIn (render (text "extending" $$
                                      nest 2 (ppTerm Unqualified 0 vars) $$
                                      text "with" $$
                                      nest 2 (ppTerm Unqualified 0 val))) $
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
    opty (Just ty) = opersIn ty
    opty _ = []
    pts i = case i of
      ResOper pty pt -> [pty,pt]
      ResParam (Just (ps,_)) -> [Just t | (_,cont) <- ps, (_,t) <- cont]
      CncCat pty _ _ -> [pty]
      CncFun _   pt _ -> [pt]  ---- (Maybe (Ident,(Context,Type))
      AbsFun pty _ ptr -> [pty] --- ptr is def, which can be mutual
      AbsCat (Just co) _ -> [Just ty | (_,ty) <- co]
      _              -> []

topoSortOpers :: [(Ident,[Ident])] -> Err [Ident]
topoSortOpers st = do
  let eops = topoTest st
  either 
    return 
    (\ops -> Bad (render (text "circular definitions:" <+> fsep (map ppIdent (head ops)))))
    eops
