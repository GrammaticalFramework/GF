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
           lookupIdent,
           lookupOrigInfo,
           allOrigInfos,
           lookupResDef, lookupResDefLoc,
           lookupResType, 
           lookupOverload,
           lookupOverloadTypes,
           lookupParamValues, 
           allParamValues,
           lookupAbsDef, 
           lookupLincat, 
           lookupFunType,
           lookupCatContext,
           allOpers, allOpersTo
	      ) where

import GF.Data.Operations
import GF.Infra.Ident
import GF.Grammar.Macros
import GF.Grammar.Grammar
import GF.Grammar.Printer
import GF.Grammar.Predef
import GF.Grammar.Lockfield

import Data.List (sortBy)
--import Data.Maybe (maybe)
--import Control.Monad
import GF.Text.Pretty
import qualified Data.Map as Map

-- whether lock fields are added in reuse
lock c = lockRecType c -- return
unlock c = unlockRecord c -- return

-- to look up a constant etc in a search tree --- why here? AR 29/5/2008
lookupIdent :: ErrorMonad m => Ident -> BinTree Ident b -> m b
lookupIdent c t =
  case lookupTree showIdent c t of
    Ok v  -> return v
    Bad _ -> raise ("unknown identifier" +++ showIdent c)

lookupIdentInfo :: ErrorMonad m => SourceModInfo -> Ident -> m Info
lookupIdentInfo mo i = lookupIdent i (jments mo)

lookupQIdentInfo :: ErrorMonad m => Grammar -> QIdent -> m Info
lookupQIdentInfo gr (m,c) = flip lookupIdentInfo c =<< lookupModule gr m

lookupResDef :: ErrorMonad m => Grammar -> QIdent -> m Term
lookupResDef gr x = fmap unLoc (lookupResDefLoc gr x)

lookupResDefLoc gr (m,c)
  | isPredefCat c = fmap noLoc (lock c defLinType)
  | otherwise     = look m c
  where 
    look m c = do
      info <- lookupQIdentInfo gr (m,c)
      case info of
        ResOper _ (Just lt) -> return lt
        ResOper _ Nothing  -> return (noLoc (Q (m,c)))
        CncCat (Just (L l ty)) _ _ _ _ -> fmap (L l) (lock c ty)
        CncCat _ _ _ _ _         -> fmap noLoc (lock c defLinType)
      
        CncFun (Just (cat,_,_)) (Just (L l tr)) _ _ -> fmap (L l) (unlock cat tr)
        CncFun _                (Just ltr) _ _ -> return ltr

        AnyInd _ n        -> look n c
        ResParam _ _      -> return (noLoc (QC (m,c)))
        ResValue _        -> return (noLoc (QC (m,c)))
        _   -> raise $ render (c <+> "is not defined in resource" <+> m)

lookupResType :: ErrorMonad m => Grammar -> QIdent -> m Type
lookupResType gr (m,c) = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    ResOper (Just (L _ t)) _ -> return t

    -- used in reused concrete
    CncCat _ _ _ _ _ -> return typeType
    CncFun (Just (cat,cont,val)) _ _ _ -> do
          val' <- lock cat val 
          return $ mkProd cont val' []
    AnyInd _ n        -> lookupResType gr (n,c)
    ResParam _ _      -> return typePType
    ResValue (L _ t)  -> return t
    _   -> raise $ render (c <+> "has no type defined in resource" <+> m)

lookupOverloadTypes :: ErrorMonad m => Grammar -> QIdent -> m [(Term,Type)]
lookupOverloadTypes gr id@(m,c) = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    ResOper (Just (L _ ty)) _ -> ret ty

    -- used in reused concrete
    CncCat _ _ _ _ _ -> ret typeType
    CncFun (Just (cat,cont,val)) _ _ _ -> do
          val' <- lock cat val 
          ret $ mkProd cont val' []
    ResParam _ _      -> ret typePType
    ResValue (L _ t)  -> ret t
    ResOverload os tysts -> do
            tss <- mapM (\x -> lookupOverloadTypes gr (x,c)) os
            return $ [(tr,ty) | (L _ ty,L _ tr) <- tysts] ++
                     concat tss
    AnyInd _ n   -> lookupOverloadTypes gr (n,c)
    _            -> raise $ render (c <+> "has no types defined in resource" <+> m)
  where
    ret ty = return [(Q id,ty)]

lookupOverload :: ErrorMonad m => Grammar -> QIdent -> m [([Type],(Type,Term))]
lookupOverload gr (m,c) = do
    info <- lookupQIdentInfo gr (m,c)
    case info of
      ResOverload os tysts -> do
            tss <- mapM (\x -> lookupOverload gr (x,c)) os
            return $ [let (args,val) = typeFormCnc ty in (map (\(b,x,t) -> t) args,(val,tr)) | 
                      (L _ ty,L _ tr) <- tysts] ++ 
                     concat tss

      AnyInd _ n  -> lookupOverload gr (n,c)
      _   -> raise $ render (c <+> "is not an overloaded operation")

-- | returns the original 'Info' and the module where it was found
lookupOrigInfo :: ErrorMonad m => Grammar -> QIdent -> m (ModuleName,Info)
lookupOrigInfo gr (m,c) = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AnyInd _ n  -> lookupOrigInfo gr (n,c)
    i           -> return (m,i)

allOrigInfos :: Grammar -> ModuleName -> [(QIdent,Info)]
allOrigInfos gr m = fromErr [] $ do
  mo <- lookupModule gr m
  return [((m,c),i) | (c,_) <- tree2list (jments mo), Ok (m,i) <- [lookupOrigInfo gr (m,c)]]

lookupParamValues :: ErrorMonad m => Grammar -> QIdent -> m [Term]
lookupParamValues gr c = do
  (_,info) <- lookupOrigInfo gr c
  case info of
    ResParam _ (Just pvs) -> return pvs
    _                     -> raise $ render (ppQIdent Qualified c <+> "has no parameter values defined")

allParamValues :: ErrorMonad m => Grammar -> Type -> m [Term]
allParamValues cnc ptyp =
  case ptyp of
    _ | Just n <- isTypeInts ptyp -> return [EInt i | i <- [0..n]]
    QC c -> lookupParamValues cnc c
    Q  c -> lookupResDef cnc c >>= allParamValues cnc
    RecType r -> do
       let (ls,tys) = unzip $ sortByFst r
       tss <- mapM (allParamValues cnc) tys
       return [R (zipAssign ls ts) | ts <- combinations tss]
    Table pt vt -> do
       pvs <- allParamValues cnc pt
       vvs <- allParamValues cnc vt
       return [V pt ts | ts <- combinations (replicate (length pvs) vvs)]
    _ -> raise (render ("cannot find parameter values for" <+> ptyp))
  where
    -- to normalize records and record types
    sortByFst = sortBy (\ x y -> compare (fst x) (fst y))

lookupAbsDef :: ErrorMonad m => Grammar -> ModuleName -> Ident -> m (Maybe Int,Maybe [Equation])
lookupAbsDef gr m c = errIn (render ("looking up absdef of" <+> c)) $ do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AbsFun _ a d _ -> return (a,fmap (map unLoc) d)
    AnyInd _ n     -> lookupAbsDef gr n c
    _              -> return (Nothing,Nothing)

lookupLincat :: ErrorMonad m => Grammar -> ModuleName -> Ident -> m Type
lookupLincat gr m c | isPredefCat c = return defLinType --- ad hoc; not needed?
lookupLincat gr m c = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    CncCat (Just (L _ t)) _ _ _ _ -> return t
    AnyInd _ n                    -> lookupLincat gr n c
    _                             -> raise (render (c <+> "has no linearization type in" <+> m))

-- | this is needed at compile time
lookupFunType :: ErrorMonad m => Grammar -> ModuleName -> Ident -> m Type
lookupFunType gr m c = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AbsFun (Just (L _ t)) _ _ _ -> return t
    AnyInd _ n                  -> lookupFunType gr n c
    _                           -> raise (render ("cannot find type of" <+> c))

-- | this is needed at compile time
lookupCatContext :: ErrorMonad m => Grammar -> ModuleName -> Ident -> m Context
lookupCatContext gr m c = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AbsCat (Just (L _ co)) -> return co
    AnyInd _ n             -> lookupCatContext gr n c
    _                      -> raise (render ("unknown category" <+> c))


-- this gives all opers and param constructors, also overloaded opers and funs, and the types, and locations
-- notice that it only gives the modules that are reachable and the opers that are included

allOpers :: Grammar -> [(QIdent,Type,Location)]
allOpers gr = 
  [((m,op),typ,loc) |
      (m,mi)  <- maybe [] (allExtends gr) (greatestResource gr),
      (op,info)  <- Map.toList (jments mi),
      L loc typ  <- typesIn info
  ]
  where
    typesIn info = case info of
      AbsFun  (Just ltyp) _ _ _ -> [ltyp]
      ResOper (Just ltyp) _     -> [ltyp]
      ResValue ltyp             -> [ltyp]
      ResOverload _ tytrs       -> [ltyp | (ltyp,_) <- tytrs]
      CncFun  (Just (i,ctx,typ)) _ _ _ ->
                                   [L NoLoc (mkProdSimple ctx (lock' i typ))]
      _                         -> []

    lock' i typ = case lock i typ of
                    Ok t -> t
                    _ -> typ

--- not for dependent types
allOpersTo :: Grammar -> Type -> [(QIdent,Type,Location)]
allOpersTo gr ty = [op | op@(_,typ,_) <- allOpers gr, isProdTo ty typ] where
  isProdTo t typ = eqProd typ t || case typ of
    Prod _ _ a b -> isProdTo t b
    _ -> False
  eqProd f g = case (f,g) of
    (Prod _ _ a1 b1, Prod _ _ a2 b2) -> eqProd a1 a2 && eqProd b1 b2
    _ -> f == g
