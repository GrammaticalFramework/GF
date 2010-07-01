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

module GF.Compile.CheckGrammar(checkModule) where

import GF.Infra.Ident
import GF.Infra.Modules

import GF.Compile.TypeCheck.Abstract
import GF.Compile.TypeCheck.Concrete

import GF.Grammar
import GF.Grammar.Lexer
import GF.Grammar.Lookup
import GF.Grammar.Predef
import GF.Grammar.PatternMatch

import GF.Data.Operations
import GF.Infra.CheckM

import Data.List
import qualified Data.Set as Set
import Control.Monad
import Text.PrettyPrint

-- | checking is performed in the dependency order of modules
checkModule :: [SourceModule] -> SourceModule -> Check SourceModule
checkModule ms m@(name,mo) = checkIn (text "checking module" <+> ppIdent name) $ do
  checkRestrictedInheritance ms m
  m <- case mtype mo of
         MTConcrete a -> do let gr = MGrammar (m:ms)
                            abs <- checkErr $ lookupModule gr a
                            checkCompleteGrammar gr (a,abs) m
         _            -> return m
  infos <- checkErr $ topoSortJments m
  foldM updateCheckInfo m infos
  where
    updateCheckInfo (name,mo) (i,info) = do
      info <- checkInfo ms (name,mo) i info
      return (name,updateModule mo i info)

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

checkCompleteGrammar :: SourceGrammar -> SourceModule -> SourceModule -> Check SourceModule
checkCompleteGrammar gr (am,abs) (cm,cnc) = do
  let jsa = jments abs
  let jsc = jments cnc

  -- check that all concrete constants are in abstract; build types for all lin
  jsc <- foldM checkCnc emptyBinTree (tree2list jsc)

  -- check that all abstract constants are in concrete; build default lin and lincats
  jsc <- foldM checkAbs jsc (tree2list jsa)
  
  return (cm,replaceJudgements cnc jsc)
  where
   checkAbs js i@(c,info) =
     case info of
       AbsFun (Just (L loc ty)) _ _ 
                            -> do let mb_def = do
                                        let (cxt,(_,i),_) = typeForm ty
                                        info <- lookupIdent i js
                                        info <- case info of
                                                  (AnyInd _ m) -> do (m,info) <- lookupOrigInfo gr (m,i)
                                                                     return info
                                                  _            -> return info
                                        case info of
                                          CncCat (Just (L loc (RecType []))) _ _ -> return (foldr (\_ -> Abs Explicit identW) (R []) cxt)
                                          _                                      -> Bad "no def lin"
                                             
                                  case lookupIdent c js of
                                    Ok (AnyInd _ _) -> return js
                                    Ok (CncFun ty (Just def) pn) -> 
                                                  return $ updateTree (c,CncFun ty (Just def) pn) js
                                    Ok (CncFun ty Nothing    pn) ->
                                      case mb_def of
                                        Ok def -> return $ updateTree (c,CncFun ty (Just (L (0,0) def)) pn) js
                                        Bad _  -> do checkWarn $ text "no linearization of" <+> ppIdent c
                                                     return js
                                    _ -> do
                                      case mb_def of
                                        Ok def -> do (cont,val) <- linTypeOfType gr cm ty
                                                     let linty = (snd (valCat ty),cont,val)
                                                     return $ updateTree (c,CncFun (Just linty) (Just (L (0,0) def)) Nothing) js
                                        Bad _  -> do checkWarn $ text "no linearization of" <+> ppIdent c
                                                     return js
       AbsCat (Just _) -> case lookupIdent c js of
         Ok (AnyInd _ _) -> return js
         Ok (CncCat (Just _) _ _) -> return js
         Ok (CncCat _ mt mp) -> do
           checkWarn $ 
             text "no linearization type for" <+> ppIdent c <> text ", inserting default {s : Str}"
           return $ updateTree (c,CncCat (Just (L (0,0) defLinType)) mt mp) js
         _ -> do
           checkWarn $ 
             text "no linearization type for" <+> ppIdent c <> text ", inserting default {s : Str}"
           return $ updateTree (c,CncCat (Just (L (0,0) defLinType)) Nothing Nothing) js
       _ -> return js
     
   checkCnc js i@(c,info) =
     case info of
       CncFun _ d pn -> case lookupOrigInfo gr (am,c) of
                          Ok (_,AbsFun (Just (L _ ty)) _ _) -> 
                                     do (cont,val) <- linTypeOfType gr cm ty
                                        let linty = (snd (valCat ty),cont,val)
                                        return $ updateTree (c,CncFun (Just linty) d pn) js
                          _       -> do checkWarn $ text "function" <+> ppIdent c <+> text "is not in abstract"
                                        return js
       CncCat _ _ _  -> case lookupOrigInfo gr (am,c) of
                          Ok _ -> return $ updateTree i js
                          _    -> do checkWarn $ text "category" <+> ppIdent c <+> text "is not in abstract"
                                     return js
       _             -> return $ updateTree i js


-- | General Principle: only Just-values are checked. 
-- A May-value has always been checked in its origin module.
checkInfo :: [SourceModule] -> SourceModule -> Ident -> Info -> Check Info
checkInfo ms (m,mo) c info = do
  checkReservedId c
  case info of
    AbsCat (Just (L loc cont)) -> 
      mkCheck loc "category" $ 
        checkContext gr cont

    AbsFun (Just (L loc typ0)) ma md -> do
      typ <- compAbsTyp [] typ0   -- to calculate let definitions
      mkCheck loc "type of function" $
        checkTyp gr typ
      case md of
        Just eqs -> mapM_ (\(L loc eq) -> mkCheck loc "definition of function" $
	                                        checkDef gr (m,c) typ eq) eqs
        Nothing  -> return ()
      return (AbsFun (Just (L loc typ)) ma md)

    CncFun linty@(Just (cat,cont,val)) (Just (L loc trm)) mpr -> chIn loc "linearization of" $ do
      (trm',_) <- checkLType gr [] trm (mkFunType (map (\(_,_,ty) -> ty) cont) val)  -- erases arg vars
      mpr <- checkPrintname gr mpr
      return (CncFun linty (Just (L loc trm')) mpr)

    CncCat (Just (L loc typ)) mdef mpr -> chIn loc "linearization type of" $ do
      (typ,_) <- checkLType gr [] typ typeType
      typ  <- computeLType gr [] typ
      mdef <- case mdef of
        Just (L loc def) -> do
          (def,_) <- checkLType gr [] def (mkFunType [typeStr] typ)
          return $ Just (L loc def)
        _ -> return mdef
      mpr <- checkPrintname gr mpr
      return (CncCat (Just (L loc typ)) mdef mpr)

    ResOper pty pde -> do
      (pty', pde') <- case (pty,pde) of
         (Just (L loct ty), Just (L locd de)) -> do
           ty'     <- chIn loct "operation" $
                         checkLType gr [] ty typeType >>= computeLType gr [] . fst
           (de',_) <- chIn locd "operation" $
                         checkLType gr [] de ty'
           return (Just (L loct ty'), Just (L locd de'))
         (Nothing         , Just (L locd de)) -> do
           (de',ty') <- chIn locd "operation" $
                          inferLType gr [] de
           return (Just (L locd ty'), Just (L locd de'))
         (Just (L loct ty), Nothing) -> do
           chIn loct "operation" $
             checkError (text "No definition given to the operation")
      return (ResOper pty' pde')

    ResOverload os tysts -> chIn (0,0) "overloading" $ do
      tysts' <- mapM (uncurry $ flip (\(L loc1 t) (L loc2 ty) -> checkLType gr [] t ty >>= \(t,ty) -> return (L loc1 t, L loc2 ty))) tysts  -- return explicit ones
      tysts0 <- checkErr $ lookupOverload gr (m,c)  -- check against inherited ones too
      tysts1 <- mapM (uncurry $ flip (checkLType gr [])) 
                  [(mkFunType args val,tr) | (args,(val,tr)) <- tysts0]
      --- this can only be a partial guarantee, since matching
      --- with value type is only possible if expected type is given
      checkUniq $ 
        sort [let (xs,t) = typeFormCnc x in t : map (\(b,x,t) -> t) xs | (_,x) <- tysts1]
      return (ResOverload os [(y,x) | (x,y) <- tysts'])

    ResParam (Just pcs) _ -> do
      ts <- liftM concat $ mapM mkPar pcs
      return (ResParam (Just pcs) (Just ts))

    _ ->  return info
 where
   gr = MGrammar ((m,mo) : ms)
   chIn loc cat = checkIn (text "Happened in" <+> text cat <+> ppIdent c <+> ppPosition m loc <> colon)

   mkPar (L loc (f,co)) = 
     chIn loc "parameter type" $ do
       vs <- checkErr $ liftM combinations $ mapM (\(_,_,ty) -> allParamValues gr ty) co
       return $ map (mkApp (QC (m,f))) vs

   checkUniq xss = case xss of
     x:y:xs 
      | x == y    -> checkError $ text "ambiguous for type" <+>
                                  ppType (mkFunType (tail x) (head x))  
      | otherwise -> checkUniq $ y:xs
     _ -> return ()

   mkCheck loc cat ss = case ss of
     [] -> return info
     _  -> checkError (vcat ss $$ text "in" <+> text cat <+> ppIdent c <+> ppPosition m loc)

   compAbsTyp g t = case t of
     Vr x -> maybe (checkError (text "no value given to variable" <+> ppIdent x)) return $ lookup x g
     Let (x,(_,a)) b -> do
       a' <- compAbsTyp g a
       compAbsTyp ((x, a'):g) b
     Prod b x a t -> do
       a' <- compAbsTyp g a
       t' <- compAbsTyp ((x,Vr x):g) t
       return $ Prod b x a' t'
     Abs _ _ _ -> return t
     _ -> composOp (compAbsTyp g) t  


checkPrintname :: SourceGrammar -> Maybe (L Term) -> Check (Maybe (L Term))
checkPrintname gr (Just (L loc t)) = do (t,_) <- checkLType gr [] t typeStr
                                        return (Just (L loc t))
checkPrintname gr Nothing          = return Nothing

-- | for grammars obtained otherwise than by parsing ---- update!!
checkReservedId :: Ident -> Check ()
checkReservedId x
  | isReservedWord (ident2bs x) = checkWarn (text "reserved word used as identifier:" <+> ppIdent x)
  | otherwise                   = return ()

-- auxiliaries

-- | linearization types and defaults
linTypeOfType :: SourceGrammar -> Ident -> Type -> Check (Context,Type)
linTypeOfType cnc m typ = do
  let (cont,cat) = typeSkeleton typ
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
     return (Explicit,symb,rec)
   lookLin (_,c) = checks [ --- rather: update with defLinType ?
      checkErr (lookupLincat cnc m c) >>= computeLType cnc []
     ,return defLinType
     ]
