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
           lookupIdentInfo,
           lookupOrigInfo,
           allOrigInfos,
           lookupResDef,
	       lookupResType, 
           lookupOverload,
	       lookupParamValues, 
	       allParamValues,
	       lookupAbsDef, 
	       lookupLincat, 
	       lookupFunType,
	       lookupCatContext
	      ) where

import GF.Data.Operations
import GF.Infra.Ident
import GF.Infra.Modules
import GF.Grammar.Macros
import GF.Grammar.Grammar
import GF.Grammar.Printer
import GF.Grammar.Predef
import GF.Grammar.Lockfield

import Data.List (nub,sortBy)
import Control.Monad
import Text.PrettyPrint

-- whether lock fields are added in reuse
lock c = lockRecType c -- return
unlock c = unlockRecord c -- return

-- to look up a constant etc in a search tree --- why here? AR 29/5/2008
lookupIdent :: Ident -> BinTree Ident b -> Err b
lookupIdent c t =
  case lookupTree showIdent c t of
    Ok v  -> return v
    Bad _ -> Bad ("unknown identifier" +++ showIdent c)

lookupIdentInfo :: ModInfo Ident a -> Ident -> Err a
lookupIdentInfo mo i = lookupIdent i (jments mo)

lookupResDef :: SourceGrammar -> Ident -> Ident -> Err Term
lookupResDef gr m c
  | isPredefCat c = lock c defLinType 
  | otherwise     = look m c
  where 
    look m c = do
      mo <- lookupModule gr m
      info <- lookupIdentInfo mo c
      case info of
        ResOper _ (Just t) -> return t
        ResOper _ Nothing  -> return (Q m c)
        CncCat (Just ty) _ _ -> lock c ty
        CncCat _ _ _         -> lock c defLinType
      
        CncFun (Just (cat,_,_)) (Just tr) _ -> unlock cat tr
        CncFun _                (Just tr) _ -> return tr

        AnyInd _ n        -> look n c
        ResParam _ _      -> return (QC m c)
        ResValue _        -> return (QC m c)
        _   -> Bad $ render (ppIdent c <+> text "is not defined in resource" <+> ppIdent m)

lookupResType :: SourceGrammar -> Ident -> Ident -> Err Type
lookupResType gr m c = do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    ResOper (Just t) _ -> return t

    -- used in reused concrete
    CncCat _ _ _ -> return typeType
    CncFun (Just (cat,cont@(_:_),val)) _ _ -> do
          val' <- lock cat val 
          return $ mkProd cont val' []
    CncFun _ _ _      -> lookFunType m m c
    AnyInd _ n        -> lookupResType gr n c
    ResParam _ _      -> return typePType
    ResValue t        -> return t
    _   -> Bad $ render (ppIdent c <+> text "has no type defined in resource" <+> ppIdent m)
  where
    lookFunType e m c = do
          a  <- abstractOfConcrete gr m
          lookFun e m c a
    lookFun e m c a = do
          mu <- lookupModule gr a
          info <- lookupIdentInfo mu c
          case info of
            AbsFun (Just ty) _ _ -> return $ redirectTerm e ty 
            AbsCat _ _ -> return typeType
            AnyInd _ n -> lookFun e m c n
            _ -> Bad (render (text "cannot find type of reused function" <+> ppIdent c))

lookupOverload :: SourceGrammar -> Ident -> Ident -> Err [([Type],(Type,Term))]
lookupOverload gr m c = do
    mo <- lookupModule gr m
    info <- lookupIdentInfo mo c
    case info of
      ResOverload os tysts -> do
            tss <- mapM (\x -> lookupOverload gr x c) os
            return $ [let (args,val) = typeFormCnc ty in (map (\(b,x,t) -> t) args,(val,tr)) | 
                      (ty,tr) <- tysts] ++ 
                     concat tss

      AnyInd _ n  -> lookupOverload gr n c
      _   -> Bad $ render (ppIdent c <+> text "is not an overloaded operation")

-- | returns the original 'Info' and the module where it was found
lookupOrigInfo :: SourceGrammar -> Ident -> Ident -> Err (Ident,Info)
lookupOrigInfo gr m c = do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    AnyInd _ n  -> lookupOrigInfo gr n c
    i           -> return (m,i)

allOrigInfos :: SourceGrammar -> Ident -> [(Ident,Info)]
allOrigInfos gr m = errVal [] $ do
  mo <- lookupModule gr m
  return [(c,i) | (c,_) <- tree2list (jments mo), Ok (_,i) <- [look c]]
  where
    look = lookupOrigInfo gr m

lookupParams :: SourceGrammar -> Ident -> Ident -> Err ([Param],Maybe [Term])
lookupParams gr = look True where 
  look isTop m c = do
    mo <- lookupModule gr m
    info <- lookupIdentInfo mo c
    case info of
      ResParam (Just psm) m -> return (psm,m)
      AnyInd _ n            -> look False n c
      _                     -> Bad $ render (ppIdent c <+> text "has no parameters defined in resource" <+> ppIdent m)
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
     vs <- liftM combinations $ mapM (\(_,_,ty) -> allParamValues gr ty) co
     return $ map (mkApp (QC m f)) vs

allParamValues :: SourceGrammar -> Type -> Err [Term]
allParamValues cnc ptyp = case ptyp of
     _ | Just n <- isTypeInts ptyp -> return [EInt i | i <- [0..n]]
     QC p c -> lookupParamValues cnc p c
     Q  p c -> lookupResDef cnc p c >>= allParamValues cnc
     RecType r -> do
       let (ls,tys) = unzip $ sortByFst r
       tss <- mapM (allParamValues cnc) tys
       return [R (zipAssign ls ts) | ts <- combinations tss]
     _ -> Bad (render (text "cannot find parameter values for" <+> ppTerm Unqualified 0 ptyp))
  where
    -- to normalize records and record types
    sortByFst = sortBy (\ x y -> compare (fst x) (fst y))

lookupAbsDef :: SourceGrammar -> Ident -> Ident -> Err (Maybe Int,Maybe [Equation])
lookupAbsDef gr m c = errIn (render (text "looking up absdef of" <+> ppIdent c)) $ do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    AbsFun _ a d -> return (a,d)
    AnyInd _ n   -> lookupAbsDef gr n c
    _            -> return (Nothing,Nothing)

lookupLincat :: SourceGrammar -> Ident -> Ident -> Err Type
lookupLincat gr m c | isPredefCat c = return defLinType --- ad hoc; not needed?
lookupLincat gr m c = do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    CncCat (Just t) _ _ -> return t
    AnyInd _ n          -> lookupLincat gr n c
    _                   -> Bad (render (ppIdent c <+> text "has no linearization type in" <+> ppIdent m))

-- | this is needed at compile time
lookupFunType :: SourceGrammar -> Ident -> Ident -> Err Type
lookupFunType gr m c = do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    AbsFun (Just t) _ _  -> return t
    AnyInd _ n           -> lookupFunType gr n c
    _                    -> Bad (render (text "cannot find type of" <+> ppIdent c))

-- | this is needed at compile time
lookupCatContext :: SourceGrammar -> Ident -> Ident -> Err Context
lookupCatContext gr m c = do
  mo <- lookupModule gr m
  info <- lookupIdentInfo mo c
  case info of
    AbsCat (Just co) _ -> return co
    AnyInd _ n         -> lookupCatContext gr n c
    _                  -> Bad (render (text "unknown category" <+> ppIdent c))
