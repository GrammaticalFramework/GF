module LookAbs where

import Operations
import qualified GFC as C
import Abstract
import Ident

import Modules

import List (nub)
import Monad

type GFCGrammar = C.CanonGrammar

lookupAbsDef :: GFCGrammar -> Ident -> Ident -> Err (Maybe Term)
lookupAbsDef gr m c = errIn ("looking up absdef of" +++ prt c) $ do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        C.AbsFun _ t  -> return $ return t
        C.AnyInd _ n  -> lookupAbsDef gr n c
        _ -> return Nothing
    _ -> Bad $ prt m +++ "is not an abstract module"

lookupFunType :: GFCGrammar -> Ident -> Ident -> Err Type
lookupFunType gr m c = errIn ("looking up funtype of" +++ prt c) $ do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        C.AbsFun t _  -> return t
        C.AnyInd _ n  -> lookupFunType gr n c
        _ -> prtBad "cannot find type of" c
    _ -> Bad $ prt m +++ "is not an abstract module"

lookupCatContext :: GFCGrammar -> Ident -> Ident -> Err Context
lookupCatContext gr m c = errIn ("looking up context of cat" +++ prt c) $ do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        C.AbsCat co _ -> return co
        C.AnyInd _ n  -> lookupCatContext gr n c
        _ -> prtBad "unknown category" c
    _ -> Bad $ prt m +++ "is not an abstract module"

-- lookup for transfer function: transfer-module-name, category name

lookupTransfer :: GFCGrammar -> Ident -> Ident -> Err Term
lookupTransfer gr m c = errIn ("looking up transfer of cat" +++ prt c) $ do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        C.AbsTrans t -> return t
        C.AnyInd _ n  -> lookupTransfer gr n c
        _ -> prtBad "cannot transfer function for" c
    _ -> Bad $ prt m +++ "is not a transfer module"


---- should be revised (20/9/2003)
isPrimitiveFun :: GFCGrammar -> Fun -> Bool
isPrimitiveFun gr (m,c) = case lookupAbsDef gr m c of
  Ok (Just (Eqs [])) -> True  -- is canonical
  Ok (Just _)        -> False -- has defining clauses
  _                  -> True  -- has no definition


-- looking up refinement terms

lookupRef :: GFCGrammar -> Binds -> Term -> Err Val
lookupRef gr binds at = case at of
  Q m f -> lookupFunType gr m f >>= return . vClos
  Vr i  -> maybeErr ("unknown variable" +++ prt at) $ lookup i binds
  _     -> prtBad "cannot refine with complex term" at ---

refsForType :: (Val -> Type -> Bool) -> GFCGrammar -> Binds -> Val -> [(Term,Val)]
refsForType compat gr binds val = 
  [(vr i, t) | (i,t) <- binds, Ok ty <- [val2exp t], compat val ty] ++
  [(qq f, vClos t) | (f,t) <- funsForType compat gr val]


funRulesOf :: GFCGrammar -> [(Fun,Type)]
funRulesOf gr = 
----  funRulesForLiterals ++
  [((i,f),typ) | (i, ModMod m) <- modules gr,
                 mtype m == MTAbstract,
                 (f, C.AbsFun typ _) <- tree2list (jments m)]

allCatsOf :: GFCGrammar -> [(Cat,Context)]
allCatsOf gr = 
  [((i,c),cont) | (i, ModMod m) <- modules gr,
                    isModAbs m,
                    (c, C.AbsCat cont _) <- tree2list (jments m)]

funsForType :: (Val -> Type -> Bool) -> GFCGrammar -> Val -> [(Fun,Type)]
funsForType compat gr val = [(fun,typ) | (fun,typ) <- funRulesOf gr, 
                                         compat val typ]

funsOnType :: (Val -> Type -> Bool) -> GFCGrammar -> Val -> [((Fun,Int),Type)]
funsOnType compat gr = funsOnTypeFs compat (funRulesOf gr)

funsOnTypeFs :: (Val -> Type -> Bool) -> [(Fun,Type)] -> Val -> [((Fun,Int),Type)]
funsOnTypeFs compat fs val = [((fun,i),typ) | 
                                       (fun,typ) <- fs,
                                        Ok (args,_,_) <- [typeForm typ],
                                        (i,arg) <- zip [0..] (map snd args),
                                        compat val arg]

-- this is needed at compile time

lookupFunTypeSrc :: Grammar -> Ident -> Ident -> Err Type
lookupFunTypeSrc gr m c = do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        AbsFun (Yes t) _  -> return t
        AnyInd _ n  -> lookupFunTypeSrc gr n c
        _ -> prtBad "cannot find type of" c
    _ -> Bad $ prt m +++ "is not an abstract module"

lookupCatContextSrc :: Grammar -> Ident -> Ident -> Err Context
lookupCatContextSrc gr m c = do
  mi   <- lookupModule gr m
  case mi of
    ModMod mo -> do
      info <- lookupInfo mo c
      case info of
        AbsCat (Yes co) _ -> return co
        AnyInd _ n  -> lookupCatContextSrc gr n c
        _ -> prtBad "unknown category" c
    _ -> Bad $ prt m +++ "is not an abstract module"
