module Lookup where

import Operations
import Abstract
import Modules

import List (nub)
import Monad

-- lookup in resource and concrete in compiling; for abstract, use Look

lookupResDef :: SourceGrammar -> Ident -> Ident -> Err Term
lookupResDef gr = look True where 
  look isTop m c = do
    mi   <- lookupModule gr m
    case mi of
      ModMod mo -> do
        info <- lookupInfo mo c
        case info of
          ResOper _ (Yes t) -> return $ qualifAnnot m t 
          ResOper _ Nope    -> return (Q m c) ---- if isTop then lookExt m c 
                                 ---- else prtBad "cannot find in exts" c 
          AnyInd _ n        -> look False n c
          ResParam _        -> return $ QC m c
          ResValue _        -> return $ QC m c
          _   -> Bad $ prt c +++ "is not defined in resource" +++ prt m
      _ -> Bad $ prt m +++ "is not a resource"
  lookExt m c =
    checks ([look False n c | n <- allExtensions gr m] ++ [return (Q m c)])

lookupResType :: SourceGrammar -> Ident -> Ident -> Err Type
lookupResType gr m c = do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        ResOper (Yes t) _ -> return $ qualifAnnot m t
        ResOper (May n) _ -> lookupResType gr n c
        AnyInd _ n        -> lookupResType gr n c
        ResParam _        -> return $ typePType
        ResValue (Yes t)  -> return $ qualifAnnotPar m t
        _   -> Bad $ prt c +++ "has no type defined in resource" +++ prt m
    _ -> Bad $ prt m +++ "is not a resource"

lookupParams :: SourceGrammar -> Ident -> Ident -> Err [Param]
lookupParams gr = look True where 
  look isTop m c = do
    mi   <- lookupModule gr m
    case mi of
      ModMod mo -> do
        info <- lookupInfo mo c
        case info of
          ResParam (Yes ps) -> return ps
          ---- ResParam   Nope   -> if isTop then lookExt m c 
          ----                       else prtBad "cannot find params in exts" c 
          AnyInd _ n        -> look False n c
          _   -> Bad $ prt c +++ "has no parameters defined in resource" +++ prt m
      _ -> Bad $ prt m +++ "is not a resource"
  lookExt m c =
    checks [look False n c | n <- allExtensions gr m]

lookupParamValues :: SourceGrammar -> Ident -> Ident -> Err [Term]
lookupParamValues gr m c = do
  ps <- lookupParams gr m c
  liftM concat $ mapM mkPar ps
 where
   mkPar (f,co) = do
     vs <- liftM combinations $ mapM (\ (_,ty) -> allParamValues gr ty) co
     return $ map (mkApp (QC m f)) vs

lookupFirstTag :: SourceGrammar -> Ident -> Ident -> Err Term
lookupFirstTag gr m c = do
  vs <- lookupParamValues gr m c
  case vs of
    v:_ -> return v
    _ -> prtBad "no parameter values given to type" c

allParamValues :: SourceGrammar -> Type -> Err [Term]
allParamValues cnc ptyp = case ptyp of
     QC p c -> lookupParamValues cnc p c
     RecType r -> do
       let (ls,tys) = unzip r
       tss <- mapM allPV tys
       return [R (zipAssign ls ts) | ts <- combinations tss]
     _ -> prtBad "cannot find parameter values for" ptyp
  where
    allPV = allParamValues cnc

qualifAnnot :: Ident -> Term -> Term
qualifAnnot _ = id
-- Using this we wouldn't have to annotate constants defined in a module itself.
-- But things are simpler if we do (cf. Zinc).
-- Change Rename.self2status to change this behaviour.

-- we need this for lookup in ResVal
qualifAnnotPar m t = case t of
  Cn c  -> Q m c
  Con c -> QC m c
  _ -> composSafeOp (qualifAnnotPar m) t


lookupLincat :: SourceGrammar -> Ident -> Ident -> Err Type
lookupLincat gr m c = do
  mi <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        CncCat (Yes t) _ _ -> return t
        AnyInd _ n         -> lookupLincat gr n c
        _   -> Bad $ prt c +++ "has no linearization type in" +++ prt m
    _ -> Bad $ prt m +++ "is not concrete"



{-
-- the type of oper may have to be inferred at TC, so it may be junk before it

lookupResIdent :: Ident -> [(Ident, SourceRes)] -> Err (Term,Type)
lookupResIdent c ms = case lookupWhich ms c of
  Ok (i,info)  -> case info of
    ResOper (Yes t) _ -> return (Q i c, t)
    ResOper _ _       -> return (Q i c, undefined) ----
    ResParam _        -> return (Q i c, typePType)
    ResValue (Yes t)  -> return (QC i c, t)
  _   -> Bad $ "not found in resource" +++ prt c

-- NB we only have to look up cnc in canonical!

-- you may want to strip the qualification if the module is the current one

stripMod :: Ident -> Term -> Term
stripMod m t = case t of
  Q  n c | n==m -> Cn c
  QC n c | n==m -> Con c
  _ -> t

-- what you want may be a pattern and not a term. Then use Macros.term2patt




-- an auxiliary for making ordered search through a list of modules

lookups :: Ord i => (i -> m -> Err (Perhaps a m)) -> i -> [m] -> Err (Perhaps a m)
lookups look c [] = Bad "not found in any module"
lookups look c (m:ms) = case look c m of
  Ok (Yes v)  -> return $ Yes v
  Ok (May m') -> look c m'
  _   -> lookups look c ms


lookupAbstract :: AbstractST -> Ident -> Err AbsInfo
lookupAbstract g i = errIn ("not found in abstract" +++ prt i) $ lookupTree prt i g

lookupFunsToCat :: AbstractST -> Ident -> Err [Fun]
lookupFunsToCat g c = errIn ("looking up functions to category" +++ prt c) $ do
  info <- lookupAbstract g c
  case info of
    AbsCat _ _ fs _ -> return fs
    _ -> prtBad "not category" c

allFunsWithValCat ab = [(f,c) | (c, AbsCat _ _ fs _) <- abstr2list ab, f <- fs]

allDefs ab = [(f,d) | (f,AbsFun _ (Just d)) <- abstr2list ab]

lookupCatContext :: AbstractST -> Ident -> Err Context
lookupCatContext g c = errIn "context of category" $ do
  info <- lookupAbstract g c
  case info of
    AbsCat c _ _ _ -> return c
    _ -> prtBad "not category" c

lookupFunType :: AbstractST -> Ident -> Err Term
lookupFunType g c = errIn "looking up type of function" $ case c of
  IL s -> lookupLiteral s >>= return . fst
  _ -> do
    info <- lookupAbstract g c
    case info of
      AbsFun t _ -> return t
      AbsType t  -> return typeType
      _ -> prtBad "not function" c

lookupFunArity :: AbstractST -> Ident -> Err Int
lookupFunArity g c = do
  typ <- lookupFunType g c
  ctx <- contextOfType typ
  return $ length ctx

lookupAbsDef :: AbstractST -> Ident -> Err (Maybe Term)
lookupAbsDef g c = errIn "looking up definition in abstract syntax" $ do
  info <- lookupAbstract g c
  case info of
    AbsFun _ t -> return t
    AbsType t  -> return $ Just t
    _ -> return $ Nothing  -- constant found and accepted as primitive


allCats :: AbstractST -> [Ident]
allCats abstr = [c | (c, AbsCat _ _ _ _) <- abstr2list abstr]

allIndepCats :: AbstractST -> [Ident]
allIndepCats abstr = [c | (c, AbsCat [] _ _ _) <- abstr2list abstr]

lookupConcrete :: ConcreteST -> Ident -> Err CncInfo
lookupConcrete g i = errIn ("not found in concrete" +++ prt i) $ lookupTree prt i g

lookupPackage :: ConcreteST -> Ident -> Err ([Ident], ConcreteST)
lookupPackage g p = do
  info <- lookupConcrete g p
  case info of
    CncPackage ps ins -> return (ps,ins)
    _ -> prtBad "not package" p

lookupInPackage :: ConcreteST -> (Ident,Ident) -> Err CncInfo
lookupInPackage = lookupLift (flip (lookupTree prt))

lookupInAll :: [BinTree (Ident,b)] -> Ident -> Err b
lookupInAll = lookInAll (flip (lookupTree prt)) 

lookInAll :: (BinTree (Ident,c)  -> Ident -> Err b) -> 
              [BinTree (Ident,c)] -> Ident -> Err b
lookInAll look ts c = case ts of
  t : ts' -> err (const $ lookInAll look ts' c) return $ look t c
  [] -> prtBad "not found in any package" c

lookupLift :: (ConcreteST -> Ident -> Err b) -> 
              ConcreteST  -> (Ident,Ident) -> Err b
lookupLift look g (p,f) = do
  (ps,ins) <- lookupPackage g p
  ps' <- mapM (lookupPackage g) ps
  lookInAll look (ins : reverse (map snd ps')) f

termFromPackage :: ConcreteST -> Ident -> Term -> Err Term
termFromPackage g p = termFP where
  termFP t = case t of
    Cn c -> return $ if isInPack c
               then Q p c
               else Cn c 
    T (TTyped t) cs -> do
      t' <- termFP t
      liftM (T (TTyped t')) $ mapM branchInPack cs
    T i cs -> liftM (T i) $ mapM branchInPack cs
    _ -> composOp termFP t
  isInPack c = case lookupInPackage g (p,c) of
    Ok _ -> True
    _    -> False
  branchInPack (q,t) = do
    p' <- pattInPack q
    t' <- termFP t
    return (p',t')
  pattInPack q = case q of
    PC c ps -> do
      let pc = if isInPack c
                  then PP p c
                  else PC c
      ps' <- mapM pattInPack ps 
      return $ pc ps'
    _ -> return q

lookupCncDef :: ConcreteST -> Ident -> Err Term
lookupCncDef g t@(IL _) = return $ cn t
lookupCncDef g c = errIn "looking up defining term" $ do
  info <- lookupConcrete g c
  case info of
    CncOper _ t _  -> return t  -- the definition
    CncCat t _ _ _ -> return t  -- the linearization type
    _ -> return $ Cn c -- constant found and accepted

lookupOperDef :: ConcreteST -> Ident -> Err Term
lookupOperDef g c = errIn "looking up defining term of oper" $ do
  info <- lookupConcrete g c
  case info of
    CncOper _ t _ -> return t
    _ -> prtBad "not oper" c

lookupLincat :: ConcreteST -> Ident -> Err Term
lookupLincat g c = return $ errVal defaultLinType $ do
  info <- lookupConcrete g c
  case info of
    CncCat t _ _ _ -> return t
    _ -> prtBad "not category" c

lookupLindef :: ConcreteST -> Ident -> Err Term
lookupLindef g c = return $ errVal linDefStr $ do
  info <- lookupConcrete g c
  case info of
    CncCat _ (Just t) _ _ -> return t
    CncCat _ _ _ _        -> return $ linDefStr --- wrong: this is only sof {s:Str}
    _ -> prtBad "not category" c

lookupLinType :: ConcreteST -> Ident -> Err Type
lookupLinType g c = errIn "looking up type in concrete syntax" $ do
  info <- lookupConcrete g c
  case info of
    CncParType _ _ _ -> return typeType
    CncParam ty _ -> return ty
    CncOper (Just ty) _ _ -> return ty
    _ -> prtBad "no type found for" c

lookupLin :: ConcreteST -> Ident -> Err Term
lookupLin g c = errIn "looking up linearization rule" $ do
  info <- lookupConcrete g c
  case info of
    CncFun t _ -> return t
    _ -> prtBad "not category" c

lookupFirstTag :: ConcreteST -> Ident -> Err Term
lookupFirstTag g c = do
  vs <- lookupParamValues g c
  case vs of
    v:_ -> return v
    _ -> prtBad "empty parameter type" c

lookupPrintname :: ConcreteST -> Ident -> Err String
lookupPrintname g c = case lookupConcrete g c of
  Ok info -> case info of
    CncCat _ _ _ m   -> mpr m
    CncFun _ m       -> mpr m
    CncParType _ _ m -> mpr m
    CncOper _ _ m    -> mpr m
    _ -> Bad "no possible printname"
  Bad s -> Bad s
 where
     mpr = maybe (Bad "no printname") (return . stringFromTerm)

-- this variant succeeds even if there's only abstr syntax
lookupPrintname' g c = case lookupConcrete g c of
  Bad _   -> return $ prt c 
  Ok info -> case info of
    CncCat _ _ _ m   -> mpr m
    CncFun _ m       -> mpr m
    CncParType _ _ m -> mpr m
    CncOper _ _ m    -> mpr m
    _ -> return $ prt c
   where
     mpr = return . maybe (prt c) stringFromTerm

allOperDefs :: ConcreteST -> [(Ident,CncInfo)]
allOperDefs cnc = [d | d@(_, CncOper _ _ _) <- concr2list cnc]

allPackageDefs :: ConcreteST -> [(Ident,CncInfo)]
allPackageDefs cnc = [d | d@(_, CncPackage _ _) <- concr2list cnc]

allOperDependencies :: ConcreteST -> [(Ident,[Ident])]
allOperDependencies cnc = 
  [(f, filter (/= f) $ -- package name may occur in the package itself
       nub (concatMap (opersInCncInfo cnc f . snd) (tree2list ds))) | 
                             (f, CncPackage _ ds) <- allPackageDefs cnc] ++
  [(f, nub (opersInTerm cnc t)) | 
                             (f, CncOper _ t _) <- allOperDefs cnc]

opersInTerm :: ConcreteST -> Term -> [Ident]
opersInTerm cnc t = case t of
     Cn c -> [c | isOper c]
     Q p c -> [p]
     _ -> collectOp ops t
  where
   isOper (IL _) = False 
   isOper c = errVal False $ lookupOperDef cnc c >>= return . const True
   ops = opersInTerm cnc

-- this is used inside packages, to find references to outside the package
opersInCncInfo :: ConcreteST -> Ident -> CncInfo -> [Ident]
opersInCncInfo cnc p i = case i of
   CncOper _ t _-> filter (not . internal) $ opersInTerm cnc t
   _ -> []
  where
    internal c = case lookupInPackage cnc (p,c) of
      Ok _ -> True
      _ -> False
   
opersUsedInLins ::  ConcreteST -> [(Ident,[Ident])] -> [Ident]
opersUsedInLins cnc deps = do
  let ops0 = concat [opersInTerm cnc t | (_, CncFun t _) <- concr2list cnc]
  nub $ closure ops0
 where
   closure ops = case [g | (f,fs) <- deps, elem f ops, g <- fs, notElem g ops] of
     [] -> ops
     ops' -> ops ++ closure ops'
   -- presupposes deps are not circular: check this first!




-- create refinement and wrapping lists


varOrConst :: AbstractST -> Ident -> Err Term
varOrConst abstr c = case lookupFunType abstr c of
  Ok _ -> return $ Cn c   --- bindings cannot overshadow constants
  _ -> case c of
    IL _ -> return $ Cn c
    _ -> return $ Vr c

-- a rename operation for parsing term input; for abstract syntax and parameters
renameTrm :: (Ident -> Err a) -> Term -> Term
renameTrm look = ren [] where
  ren vars t = case t of
    Vr x | notElem x vars && isNotError (look x) -> Cn x
    Abs x b -> Abs x $ ren (x:vars) b
    _ -> composSafeOp (ren vars) t
-}
