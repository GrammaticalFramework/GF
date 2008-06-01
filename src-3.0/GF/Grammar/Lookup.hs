{-# LANGUAGE PatternGuards #-}
----------------------------------------------------------------------
-- |
-- Module      : Lookup
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/27 13:21:53 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.15 $
--
-- Lookup in source (concrete and resource) when compiling.
--
-- lookup in resource and concrete in compiling; for abstract, use 'Look'
-----------------------------------------------------------------------------

module GF.Grammar.Lookup (
               lookupResDef,
               lookupResDefKind,
	       lookupResType, 
               lookupOverload,
	       lookupParams, 
	       lookupParamValues, 
	       lookupFirstTag, 
               lookupValueIndex,
               lookupIndexValue,
               allOrigInfos,
	       allParamValues, 
	       lookupAbsDef, 
	       lookupLincat, 
	       opersForType
	      ) where

import GF.Data.Operations
import GF.Grammar.Abstract
import GF.Infra.Modules
import GF.Grammar.Predef
import GF.Grammar.Lockfield

import Data.List (nub,sortBy)
import Control.Monad

-- whether lock fields are added in reuse
lock c = lockRecType c -- return
unlock c = unlockRecord c -- return

lookupResDef :: SourceGrammar -> Ident -> Ident -> Err Term
lookupResDef gr m c = liftM fst $ lookupResDefKind gr m c

-- 0 = oper, 1 = lin, 2 = canonical. v > 0 means: no need to be recomputed
lookupResDefKind :: SourceGrammar -> Ident -> Ident -> Err (Term,Int)
lookupResDefKind gr m c = look True m c where 
  look isTop m c = do
    mi   <- lookupModule gr m
    case mi of
      ModMod mo -> do
        info <- lookupIdentInfo mo c
        case info of
          ResOper _ (Yes t) -> return (qualifAnnot m t, 0) 
          ResOper _ Nope    -> return (Q m c, 0) ---- if isTop then lookExt m c 
                                 ---- else prtBad "cannot find in exts" c 

          CncCat (Yes ty) _ _ -> liftM (flip (,) 1) $ lock c ty
          CncCat _ _ _        -> liftM (flip (,) 1) $ lock c defLinType
          CncFun (Just (cat,_)) (Yes tr) _ -> liftM (flip (,) 1) $ unlock cat tr

          CncFun _ (Yes tr) _ -> liftM (flip (,) 1) $ unlock c tr

          AnyInd _ n        -> look False n c
          ResParam _        -> return (QC m c,2)
          ResValue _        -> return (QC m c,2)
          _   -> Bad $ prt c +++ "is not defined in resource" +++ prt m
      _ -> Bad $ prt m +++ "is not a resource"
  lookExt m c =
    checks ([look False n c | n <- allExtensions gr m] ++ [return (Q m c,3)])

lookupResType :: SourceGrammar -> Ident -> Ident -> Err Type
lookupResType gr m c = do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupIdentInfo mo c
      case info of
        ResOper (Yes t) _ -> return $ qualifAnnot m t
        ResOper (May n) _ -> lookupResType gr n c

        -- used in reused concrete
        CncCat _ _ _ -> return typeType
        CncFun (Just (cat,(cont@(_:_),val))) _ _ -> do
          val' <- lock cat val 
          return $ mkProd (cont, val', [])
        CncFun _ _ _      -> lookFunType m m c
        AnyInd _ n        -> lookupResType gr n c
        ResParam _        -> return $ typePType
        ResValue (Yes (t,_))  -> return $ qualifAnnotPar m t
        _   -> Bad $ prt c +++ "has no type defined in resource" +++ prt m
    _ -> Bad $ prt m +++ "is not a resource"
  where
    lookFunType e m c = do
          a  <- abstractOfConcrete gr m
          lookFun e m c a
    lookFun e m c a = do
          mu <- lookupModMod gr a
          info <- lookupIdentInfo mu c
          case info of
            AbsFun (Yes ty) _ -> return $ redirectTerm e ty 
            AbsCat _ _ -> return typeType
            AnyInd _ n -> lookFun e m c n
            _ -> prtBad "cannot find type of reused function" c

lookupOverload :: SourceGrammar -> Ident -> Ident -> Err [([Type],(Type,Term))]
lookupOverload gr m c = do
    mi   <- lookupModule gr m
    case mi of
      ModMod mo -> do
        info <- lookupIdentInfo mo c
        case info of
          ResOverload os tysts -> 
            return [(map snd args,(val,tr)) | 
                      (ty,tr) <- tysts, Ok (args,val) <- [typeFormCnc ty]]

          AnyInd _ n  -> lookupOverload gr n c
          _   -> Bad $ prt c +++ "is not an overloaded operation"
      _ -> Bad $ prt m +++ "is not a resource"

lookupOrigInfo :: SourceGrammar -> Ident -> Ident -> Err Info
lookupOrigInfo gr m c = do
    mi   <- lookupModule gr m
    case mi of
      ModMod mo -> do
        info <- lookupIdentInfo mo c
        case info of
          AnyInd _ n  -> lookupOrigInfo gr n c
          i   -> return i
      _ -> Bad $ prt m +++ "is not run-time module"

lookupParams :: SourceGrammar -> Ident -> Ident -> Err ([Param],Maybe PValues)
lookupParams gr = look True where 
  look isTop m c = do
    mi   <- lookupModule gr m
    case mi of
      ModMod mo -> do
        info <- lookupIdentInfo mo c
        case info of
          ResParam (Yes psm) -> return psm
          AnyInd _ n        -> look False n c
          _   -> Bad $ prt c +++ "has no parameters defined in resource" +++ prt m
      _ -> Bad $ prt m +++ "is not a resource"
  lookExt m c =
    checks [look False n c | n <- allExtensions gr m]

lookupParamValues :: SourceGrammar -> Ident -> Ident -> Err [Term]
lookupParamValues gr m c = do
  (ps,mpv) <- lookupParams gr m c
  case mpv of
    Just ts -> return ts
    _ -> liftM concat $ mapM mkPar ps
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

lookupValueIndex :: SourceGrammar -> Type -> Term -> Err Term
lookupValueIndex gr ty tr = do
  ts <- allParamValues gr ty
  case lookup tr $ zip ts [0..] of
    Just i -> return $ Val ty i
    _ -> Bad $ "no index for" +++ prt tr +++ "in" +++ prt ty

lookupIndexValue :: SourceGrammar -> Type -> Int -> Err Term
lookupIndexValue gr ty i = do
  ts <- allParamValues gr ty
  if i < length ts
    then return $ ts !! i
    else Bad $ "no value for index" +++ show i +++ "in" +++ prt ty

allOrigInfos :: SourceGrammar -> Ident -> [(Ident,Info)]
allOrigInfos gr m = errVal [] $ do
  mi <- lookupModule gr m
  case mi of
    ModMod mo -> return [(c,i) | (c,_) <- tree2list (jments mo), Ok i <- [look c]]
 where
   look = lookupOrigInfo gr m

allParamValues :: SourceGrammar -> Type -> Err [Term]
allParamValues cnc ptyp = case ptyp of
     _ | Just n <- isTypeInts ptyp -> return [EInt i | i <- [0..n]]
     QC p c -> lookupParamValues cnc p c
     Q  p c -> lookupResDef cnc p c >>= allParamValues cnc
     RecType r -> do
       let (ls,tys) = unzip $ sortByFst r
       tss <- mapM allPV tys
       return [R (zipAssign ls ts) | ts <- combinations tss]
     _ -> prtBad "cannot find parameter values for" ptyp
  where
    allPV = allParamValues cnc
    -- to normalize records and record types
    sortByFst = sortBy (\ x y -> compare (fst x) (fst y))

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

lookupAbsDef :: SourceGrammar -> Ident -> Ident -> Err (Maybe Term)
lookupAbsDef gr m c = errIn ("looking up absdef of" +++ prt c) $ do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupIdentInfo mo c
      case info of
        AbsFun _ (Yes t)  -> return $ return t
        AnyInd _ n  -> lookupAbsDef gr n c
        _ -> return Nothing
    _ -> Bad $ prt m +++ "is not an abstract module"

lookupLincat :: SourceGrammar -> Ident -> Ident -> Err Type
lookupLincat gr m c | isPredefCat c = return defLinType --- ad hoc; not needed?
lookupLincat gr m c = do
  mi <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupIdentInfo mo c
      case info of
        CncCat (Yes t) _ _ -> return t
        AnyInd _ n         -> lookupLincat gr n c
        _   -> Bad $ prt c +++ "has no linearization type in" +++ prt m
    _ -> Bad $ prt m +++ "is not concrete"


-- The first type argument is uncomputed, usually a category symbol.
-- This is a hack to find implicit (= reused) opers.

opersForType :: SourceGrammar -> Type -> Type -> [(QIdent,Term)]
opersForType gr orig val = 
  [((i,f),ty) | (i,m) <- allModMod gr, (f,ty) <- opers i m val] where
    opers i m val = 
      [(f,ty) |
        (f,ResOper (Yes ty) _) <- tree2list $ jments m,
        Ok valt <- [valTypeCnc ty],
        elem valt [val,orig]
        ] ++
      let cat = err error snd (valCat orig) in --- ignore module
      [(f,ty) |
        Ok a <- [abstractOfConcrete gr i >>= lookupModMod gr],
        (f, AbsFun (Yes ty0) _) <- tree2list $ jments a,
        let ty = redirectTerm i ty0,
        Ok valt  <- [valCat ty],
        cat == snd valt ---
        ]
