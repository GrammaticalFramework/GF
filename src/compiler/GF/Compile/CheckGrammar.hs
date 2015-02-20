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
import GF.Infra.Option

import GF.Compile.TypeCheck.Abstract
import GF.Compile.TypeCheck.RConcrete
import qualified GF.Compile.TypeCheck.ConcreteNew as CN
import qualified GF.Compile.Compute.ConcreteNew as CN

import GF.Grammar
import GF.Grammar.Lexer
import GF.Grammar.Lookup
--import GF.Grammar.Predef
--import GF.Grammar.PatternMatch

import GF.Data.Operations
import GF.Infra.CheckM

import Data.List
import qualified Data.Set as Set
import Control.Monad
import GF.Text.Pretty

-- | checking is performed in the dependency order of modules
checkModule :: Options -> FilePath -> SourceGrammar -> SourceModule -> Check SourceModule
checkModule opts cwd sgr mo@(m,mi) = do
  checkRestrictedInheritance cwd sgr mo
  mo <- case mtype mi of
          MTConcrete a -> do let gr = prependModule sgr mo
                             abs <- lookupModule gr a
                             checkCompleteGrammar opts cwd gr (a,abs) mo
          _            -> return mo
  infoss <- checkInModule cwd mi NoLoc empty $ topoSortJments2 mo
  foldM updateCheckInfos mo infoss
  where
    updateCheckInfos mo = fmap (foldl update mo) . parallelCheck . map check
      where check (i,info) = fmap ((,) i) (checkInfo opts cwd sgr mo i info)
    update mo@(m,mi) (i,info) = (m,mi{jments=updateTree (i,info) (jments mi)})

-- check if restricted inheritance modules are still coherent
-- i.e. that the defs of remaining names don't depend on omitted names
checkRestrictedInheritance :: FilePath -> SourceGrammar -> SourceModule -> Check ()
checkRestrictedInheritance cwd sgr (name,mo) = checkInModule cwd mo NoLoc empty $ do
  let irs = [ii | ii@(_,mi) <- mextend mo, mi /= MIAll]  -- names with restr. inh.
  let mrs = [((i,m),mi) | (i,m) <- mos, Just mi <- [lookup i irs]]
                             -- the restr. modules themself, with restr. infos
  mapM_ checkRem mrs
 where
   mos = modules sgr
   checkRem ((i,m),mi) = do
     let (incl,excl) = partition (isInherited mi) (map fst (tree2list (jments m)))
     let incld c   = Set.member c (Set.fromList incl)
     let illegal c = Set.member c (Set.fromList excl)
     let illegals = [(f,is) | 
           (f,cs) <- allDeps, incld f, let is = filter illegal cs, not (null is)]
     case illegals of 
       [] -> return ()
       cs -> checkWarn ("In inherited module" <+> i <> ", dependence of excluded constants:" $$
                         nest 2 (vcat [f <+> "on" <+> fsep is | (f,is) <- cs]))
   allDeps = concatMap (allDependencies (const True) . jments . snd) mos

checkCompleteGrammar :: Options -> FilePath -> Grammar -> Module -> Module -> Check Module
checkCompleteGrammar opts cwd gr (am,abs) (cm,cnc) = checkInModule cwd cnc NoLoc empty $ do
  let jsa = jments abs
  let jsc = jments cnc

  -- check that all concrete constants are in abstract; build types for all lin
  jsc <- foldM checkCnc emptyBinTree (tree2list jsc)

  -- check that all abstract constants are in concrete; build default lin and lincats
  jsc <- foldM checkAbs jsc (tree2list jsa)
  
  return (cm,cnc{jments=jsc})
  where
   checkAbs js i@(c,info) =
     case info of
       AbsFun (Just (L loc ty)) _ _ _ 
           -> do let mb_def = do
                       let (cxt,(_,i),_) = typeForm ty
                       info <- lookupIdent i js
                       info <- case info of
                                 (AnyInd _ m) -> do (m,info) <- lookupOrigInfo gr (m,i)
                                                    return info
                                 _            -> return info
                       case info of
                         CncCat (Just (L loc (RecType []))) _ _ _ _ -> return (foldr (\_ -> Abs Explicit identW) (R []) cxt)
                         _                                          -> Bad "no def lin"

                 case lookupIdent c js of
                   Ok (AnyInd _ _) -> return js
                   Ok (CncFun ty (Just def) mn mf) ->
                                 return $ updateTree (c,CncFun ty (Just def) mn mf) js
                   Ok (CncFun ty Nothing    mn mf) ->
                     case mb_def of
                       Ok def -> return $ updateTree (c,CncFun ty (Just (L NoLoc def)) mn mf) js
                       Bad _  -> do noLinOf c
                                    return js
                   _ -> do
                     case mb_def of
                       Ok def -> do (cont,val) <- linTypeOfType gr cm ty
                                    let linty = (snd (valCat ty),cont,val)
                                    return $ updateTree (c,CncFun (Just linty) (Just (L NoLoc def)) Nothing Nothing) js
                       Bad _  -> do noLinOf c
                                    return js
         where noLinOf c = checkWarn ("no linearization of" <+> c)
       AbsCat (Just _) -> case lookupIdent c js of
         Ok (AnyInd _ _) -> return js
         Ok (CncCat (Just _) _ _ _ _) -> return js
         Ok (CncCat Nothing md mr mp mpmcfg) -> do
           checkWarn ("no linearization type for" <+> c <> ", inserting default {s : Str}")
           return $ updateTree (c,CncCat (Just (L NoLoc defLinType)) md mr mp mpmcfg) js
         _ -> do
           checkWarn ("no linearization type for" <+> c <> ", inserting default {s : Str}")
           return $ updateTree (c,CncCat (Just (L NoLoc defLinType)) Nothing Nothing Nothing Nothing) js
       _ -> return js
     
   checkCnc js i@(c,info) =
     case info of
       CncFun _ d mn mf -> case lookupOrigInfo gr (am,c) of
                             Ok (_,AbsFun (Just (L _ ty)) _ _ _) -> 
                                        do (cont,val) <- linTypeOfType gr cm ty
                                           let linty = (snd (valCat ty),cont,val)
                                           return $ updateTree (c,CncFun (Just linty) d mn mf) js
                             _       -> do checkWarn ("function" <+> c <+> "is not in abstract")
                                           return js
       CncCat _ _ _ _ _ -> case lookupOrigInfo gr (am,c) of
                             Ok _ -> return $ updateTree i js
                             _    -> do checkWarn ("category" <+> c <+> "is not in abstract")
                                        return js
       _                -> return $ updateTree i js


-- | General Principle: only Just-values are checked. 
-- A May-value has always been checked in its origin module.
checkInfo :: Options -> FilePath -> SourceGrammar -> SourceModule -> Ident -> Info -> Check Info
checkInfo opts cwd sgr (m,mo) c info = checkInModule cwd mo NoLoc empty $ do
  checkReservedId c
  case info of
    AbsCat (Just (L loc cont)) -> 
      mkCheck loc "the category" $ 
        checkContext gr cont

    AbsFun (Just (L loc typ0)) ma md moper -> do
      typ <- compAbsTyp [] typ0   -- to calculate let definitions
      mkCheck loc "the type of function" $
        checkTyp gr typ
      case md of
        Just eqs -> mapM_ (\(L loc eq) -> mkCheck loc "the definition of function" $
	                                        checkDef gr (m,c) typ eq) eqs
        Nothing  -> return ()
      return (AbsFun (Just (L loc typ)) ma md moper)

    CncCat mty mdef mref mpr mpmcfg -> do
      mty  <- case mty of
                Just (L loc typ) -> chIn loc "linearization type of" $ 
                                     (if False --flag optNewComp opts
                                        then do (typ,_) <- CN.checkLType gr typ typeType
                                                typ  <- computeLType gr [] typ
                                                return (Just (L loc typ))
                                        else do (typ,_) <- checkLType gr [] typ typeType
                                                typ  <- computeLType gr [] typ
                                                return (Just (L loc typ)))
                Nothing          -> return Nothing
      mdef <- case (mty,mdef) of
                (Just (L _ typ),Just (L loc def)) -> 
                    chIn loc "default linearization of" $ do
                       (def,_) <- checkLType gr [] def (mkFunType [typeStr] typ)
                       return (Just (L loc def))
                _ -> return Nothing
      mref <- case (mty,mref) of
                (Just (L _ typ),Just (L loc ref)) -> 
                    chIn loc "reference linearization of" $ do
                       (ref,_) <- checkLType gr [] ref (mkFunType [typ] typeStr)
                       return (Just (L loc ref))
                _ -> return Nothing
      mpr  <- case mpr of
                (Just (L loc t)) -> 
                    chIn loc "print name of" $ do
                       (t,_) <- checkLType gr [] t typeStr
                       return (Just (L loc t))
                _ -> return Nothing
      return (CncCat mty mdef mref mpr mpmcfg)

    CncFun mty mt mpr mpmcfg -> do
      mt <- case (mty,mt) of
              (Just (cat,cont,val),Just (L loc trm)) -> 
                  chIn loc "linearization of" $ do
                     (trm,_) <- checkLType gr [] trm (mkFunType (map (\(_,_,ty) -> ty) cont) val)  -- erases arg vars
                     return (Just (L loc trm))
              _ -> return mt
      mpr  <- case mpr of
                (Just (L loc t)) -> 
                    chIn loc "print name of" $ do
                       (t,_) <- checkLType gr [] t typeStr
                       return (Just (L loc t))
                _ -> return Nothing
      return (CncFun mty mt mpr mpmcfg)

    ResOper pty pde -> do
      (pty', pde') <- case (pty,pde) of
         (Just (L loct ty), Just (L locd de)) -> do
           ty'     <- chIn loct "operation" $
                         (if False --flag optNewComp opts
                            then CN.checkLType gr ty typeType >>= return . CN.normalForm (CN.resourceValues opts gr) (L loct c) . fst -- !!
                            else checkLType gr [] ty typeType >>= computeLType gr [] . fst)
           (de',_) <- chIn locd "operation" $
                         (if False -- flag optNewComp opts
                            then CN.checkLType gr de ty'
                            else checkLType gr [] de ty')
           return (Just (L loct ty'), Just (L locd de'))
         (Nothing         , Just (L locd de)) -> do
           (de',ty') <- chIn locd "operation" $
                          (if False -- flag optNewComp opts
                            then CN.inferLType gr de
                            else inferLType gr [] de)
           return (Just (L locd ty'), Just (L locd de'))
         (Just (L loct ty), Nothing) -> do
           chIn loct "operation" $
             checkError (pp "No definition given to the operation")
      return (ResOper pty' pde')

    ResOverload os tysts -> chIn NoLoc "overloading" $ do
      tysts' <- mapM (uncurry $ flip (\(L loc1 t) (L loc2 ty) -> checkLType gr [] t ty >>= \(t,ty) -> return (L loc1 t, L loc2 ty))) tysts  -- return explicit ones
      tysts0 <- lookupOverload gr (m,c)  -- check against inherited ones too
      tysts1 <- mapM (uncurry $ flip (checkLType gr [])) 
                  [(mkFunType args val,tr) | (args,(val,tr)) <- tysts0]
      --- this can only be a partial guarantee, since matching
      --- with value type is only possible if expected type is given
      checkUniq $ 
        sort [let (xs,t) = typeFormCnc x in t : map (\(b,x,t) -> t) xs | (_,x) <- tysts1]
      return (ResOverload os [(y,x) | (x,y) <- tysts'])

    ResParam (Just (L loc pcs)) _ -> do
      ts <- chIn loc "parameter type" $ 
              liftM concat $ mapM mkPar pcs
      return (ResParam (Just (L loc pcs)) (Just ts))

    _ ->  return info
 where
   gr = prependModule sgr (m,mo)
   chIn loc cat = checkInModule cwd mo loc ("Happened in" <+> cat <+> c)

   mkPar (f,co) = do
       vs <- liftM combinations $ mapM (\(_,_,ty) -> allParamValues gr ty) co
       return $ map (mkApp (QC (m,f))) vs

   checkUniq xss = case xss of
     x:y:xs 
      | x == y    -> checkError $ "ambiguous for type" <+>
                                  ppType (mkFunType (tail x) (head x))  
      | otherwise -> checkUniq $ y:xs
     _ -> return ()

   mkCheck loc cat ss = case ss of
     [] -> return info
     _ -> chIn loc cat $ checkError (vcat ss)

   compAbsTyp g t = case t of
     Vr x -> maybe (checkError ("no value given to variable" <+> x)) return $ lookup x g
     Let (x,(_,a)) b -> do
       a' <- compAbsTyp g a
       compAbsTyp ((x, a'):g) b
     Prod b x a t -> do
       a' <- compAbsTyp g a
       t' <- compAbsTyp ((x,Vr x):g) t
       return $ Prod b x a' t'
     Abs _ _ _ -> return t
     _ -> composOp (compAbsTyp g) t  


-- | for grammars obtained otherwise than by parsing ---- update!!
checkReservedId :: Ident -> Check ()
checkReservedId x =
  when (isReservedWord x) $
       checkWarn ("reserved word used as identifier:" <+> x)

-- auxiliaries

-- | linearization types and defaults
linTypeOfType :: Grammar -> ModuleName -> Type -> Check (Context,Type)
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
                       errIn (render ("extending" $$
                                      nest 2 vars $$
                                      "with" $$
                                      nest 2 val)) $
                             plusRecType vars val
     return (Explicit,symb,rec)
   lookLin (_,c) = checks [ --- rather: update with defLinType ?
      lookupLincat cnc m c >>= computeLType cnc []
     ,return defLinType
     ]
