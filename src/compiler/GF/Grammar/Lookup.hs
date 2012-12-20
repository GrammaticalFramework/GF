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
import Control.Monad
import Text.PrettyPrint
import qualified Data.Map as Map

-- whether lock fields are added in reuse
lock c = lockRecType c -- return
unlock c = unlockRecord c -- return

-- to look up a constant etc in a search tree --- why here? AR 29/5/2008
lookupIdent :: Ident -> BinTree Ident b -> Err b
lookupIdent c t =
  case lookupTree showIdent c t of
    Ok v  -> return v
    Bad _ -> Bad ("unknown identifier" +++ showIdent c)

lookupIdentInfo :: SourceModInfo -> Ident -> Err Info
lookupIdentInfo mo i = lookupIdent i (jments mo)

lookupQIdentInfo :: SourceGrammar -> QIdent -> Err Info
lookupQIdentInfo gr (m,c) = flip lookupIdentInfo c =<< lookupModule gr m

lookupResDef :: SourceGrammar -> QIdent -> Err Term
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
        CncCat (Just (L l ty)) _ _ _ -> fmap (L l) (lock c ty)
        CncCat _ _ _ _         -> fmap noLoc (lock c defLinType)
      
        CncFun (Just (cat,_,_)) (Just (L l tr)) _ _ -> fmap (L l) (unlock cat tr)
        CncFun _                (Just ltr) _ _ -> return ltr

        AnyInd _ n        -> look n c
        ResParam _ _      -> return (noLoc (QC (m,c)))
        ResValue _        -> return (noLoc (QC (m,c)))
        _   -> Bad $ render (ppIdent c <+> text "is not defined in resource" <+> ppIdent m)

lookupResType :: SourceGrammar -> QIdent -> Err Type
lookupResType gr (m,c) = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    ResOper (Just (L _ t)) _ -> return t

    -- used in reused concrete
    CncCat _ _ _ _ -> return typeType
    CncFun (Just (cat,cont,val)) _ _ _ -> do
          val' <- lock cat val 
          return $ mkProd cont val' []
    AnyInd _ n        -> lookupResType gr (n,c)
    ResParam _ _      -> return typePType
    ResValue (L _ t)  -> return t
    _   -> Bad $ render (ppIdent c <+> text "has no type defined in resource" <+> ppIdent m)

lookupOverload :: SourceGrammar -> QIdent -> Err [([Type],(Type,Term))]
lookupOverload gr (m,c) = do
    info <- lookupQIdentInfo gr (m,c)
    case info of
      ResOverload os tysts -> do
            tss <- mapM (\x -> lookupOverload gr (x,c)) os
            return $ [let (args,val) = typeFormCnc ty in (map (\(b,x,t) -> t) args,(val,tr)) | 
                      (L _ ty,L _ tr) <- tysts] ++ 
                     concat tss

      AnyInd _ n  -> lookupOverload gr (n,c)
      _   -> Bad $ render (ppIdent c <+> text "is not an overloaded operation")

-- | returns the original 'Info' and the module where it was found
lookupOrigInfo :: SourceGrammar -> QIdent -> Err (Ident,Info)
lookupOrigInfo gr (m,c) = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AnyInd _ n  -> lookupOrigInfo gr (n,c)
    i           -> return (m,i)

allOrigInfos :: SourceGrammar -> Ident -> [(QIdent,Info)]
allOrigInfos gr m = errVal [] $ do
  mo <- lookupModule gr m
  return [((m,c),i) | (c,_) <- tree2list (jments mo), Ok (m,i) <- [lookupOrigInfo gr (m,c)]]

lookupParamValues :: SourceGrammar -> QIdent -> Err [Term]
lookupParamValues gr c = do
  (_,info) <- lookupOrigInfo gr c
  case info of
    ResParam _ (Just pvs) -> return pvs
    _                     -> Bad $ render (ppQIdent Qualified c <+> text "has no parameter values defined")

allParamValues :: SourceGrammar -> Type -> Err [Term]
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
    _ -> Bad (render (text "cannot find parameter values for" <+> ppTerm Unqualified 0 ptyp))
  where
    -- to normalize records and record types
    sortByFst = sortBy (\ x y -> compare (fst x) (fst y))

lookupAbsDef :: SourceGrammar -> Ident -> Ident -> Err (Maybe Int,Maybe [Equation])
lookupAbsDef gr m c = errIn (render (text "looking up absdef of" <+> ppIdent c)) $ do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AbsFun _ a d _ -> return (a,fmap (map unLoc) d)
    AnyInd _ n     -> lookupAbsDef gr n c
    _              -> return (Nothing,Nothing)

lookupLincat :: SourceGrammar -> Ident -> Ident -> Err Type
lookupLincat gr m c | isPredefCat c = return defLinType --- ad hoc; not needed?
lookupLincat gr m c = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    CncCat (Just (L _ t)) _ _ _ -> return t
    AnyInd _ n                  -> lookupLincat gr n c
    _                           -> Bad (render (ppIdent c <+> text "has no linearization type in" <+> ppIdent m))

-- | this is needed at compile time
lookupFunType :: SourceGrammar -> Ident -> Ident -> Err Type
lookupFunType gr m c = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AbsFun (Just (L _ t)) _ _ _ -> return t
    AnyInd _ n                  -> lookupFunType gr n c
    _                           -> Bad (render (text "cannot find type of" <+> ppIdent c))

-- | this is needed at compile time
lookupCatContext :: SourceGrammar -> Ident -> Ident -> Err Context
lookupCatContext gr m c = do
  info <- lookupQIdentInfo gr (m,c)
  case info of
    AbsCat (Just (L _ co)) -> return co
    AnyInd _ n             -> lookupCatContext gr n c
    _                      -> Bad (render (text "unknown category" <+> ppIdent c))


-- this gives all opers and param constructors, also overloaded opers and funs, and the types, and locations
-- notice that it only gives the modules that are reachable and the opers that are included

allOpers :: SourceGrammar -> [((Ident,Ident),Type,Location)]
allOpers gr = 
  [((mo,op),typ,loc) | 
      (mo,minc)  <- reachable,
      Ok minfo   <- [lookupModule gr mo],
      (op,info)  <- Map.toList $ jments minfo,
      isInherited minc op, 
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

  reachable = case greatestResource gr of
    Just r -> allExtendSpecs gr r
    _ -> []

--- not for dependent types
allOpersTo :: SourceGrammar -> Type -> [((Ident,Ident),Type,Location)]
allOpersTo gr ty = [op | op@(_,typ,_) <- allOpers gr, isProdTo ty typ] where
  isProdTo t typ = eqProd typ t || case typ of
    Prod _ _ a b -> isProdTo t b
    _ -> False
  eqProd f g = case (f,g) of
    (Prod _ _ a1 b1, Prod _ _ a2 b2) -> eqProd a1 a2 && eqProd b1 b2
    _ -> f == g
