module CMacros where

import AbsGFC
import GFC
import qualified Ident as A ---- no need to qualif? 21/9
import PrGrammar
import Str

import Operations

import Char
import Monad

-- macros for concrete syntax in GFC that do not need lookup in a grammar

markFocus :: Term -> Term
markFocus = markSubterm "[*" "*]"

markSubterm :: String -> String -> Term -> Term
markSubterm beg end t = case t of
  R rs -> R $ map markField rs 
  T ty cs -> T ty [Cas p (mark v) | Cas p v <- cs]
  _    -> foldr1 C [tK beg, t, tK end]  -- t : Str guaranteed?
 where
   mark = markSubterm beg end
   markField lt@(Ass l t) = if isLinLabel l then (Ass l (mark t)) else lt
   isLinLabel (L (A.IC s)) = case s of ----
      's':cs -> all isDigit cs
      _ -> False

tK :: String -> Term
tK = K . KS

term2patt :: Term -> Err Patt
term2patt trm = case trm of
  Con c aa -> do
    aa' <- mapM term2patt aa
    return (PC c aa')
  R r -> do
    let (ll,aa) = unzip [(l,a) | Ass l a <- r]
    aa' <- mapM term2patt aa
    return (PR (map (uncurry PAss) (zip ll aa')))
  LI x -> return $ PV x
  _ -> prtBad "no pattern corresponds to term" trm

patt2term :: Patt -> Term
patt2term p = case p of
  PC x ps -> Con x (map patt2term ps)
  PV x    -> LI x
  PW      -> anyTerm ----
  PR pas  -> R [ Ass lbl (patt2term q) | PAss lbl q <- pas ]

anyTerm :: Term
anyTerm  = LI (A.identC "_") --- should not happen

matchPatt cs0 trm = term2patt trm >>= match cs0 where
  match cs t = 
    case cs of
      Cas ps b  :_ | elem t ps -> return b 
      _:cs'                    -> match cs' t
      []                       -> Bad $ "pattern not found for" +++ prt t 
              +++ "among" ++++ unlines (map prt cs0)  ---- debug 

defLinType :: CType
defLinType = RecType [Lbg (L (A.identC "s")) TStr]

defLindef :: Term
defLindef = R [Ass (L (A.identC "s")) (Arg (A (A.identC "str") 0))]

strsFromTerm :: Term -> Err [Str]
strsFromTerm t = case t of
  K (KS s) -> return [str s]
  K (KP d vs) -> return $ [Str [TN d [(s,v) | Var s v <- vs]]]
  C s t -> do
    s' <- strsFromTerm s
    t' <- strsFromTerm t
    return [plusStr x y | x <- s', y <- t']
  FV ts -> liftM concat $ mapM strsFromTerm ts
  E -> return [str []]
  _ -> return [str ("BUG[" ++ prt t ++ "]")] ---- debug
----  _ -> prtBad "cannot get Str from term " t

-- recursively collect all branches in a table
allInTable :: Term -> [Term]
allInTable t =  case t of
  T _ ts -> concatMap (\ (Cas _ v) -> allInTable v) ts --- expand ?
  _    -> [t]

-- to gather s-fields; assumes term in normal form, preserves label
allLinFields :: Term -> Err [[(Label,Term)]]
allLinFields trm = case trm of
----  R rs  -> return [[(l,t) | (l,(Just ty,t)) <- rs, isStrType ty]] -- good
  R rs  -> return [[(l,t) | Ass l t <- rs, isLinLabel l]] ---- bad
  FV ts -> do
    lts <- mapM allLinFields ts
    return $ concat lts
  _ -> prtBad "fields can only be sought in a record not in" trm

---- deprecated
isLinLabel l = case l of
     L (A.IC ('s':cs)) | all isDigit cs -> True
     _ -> False

-- to gather ultimate cases in a table; preserves pattern list
allCaseValues :: Term -> [([Patt],Term)]
allCaseValues trm = case trm of
  T _ cs -> [(p:ps, t) | Cas pp t0 <- cs, p <- pp, (ps,t) <- allCaseValues t0]
  _      -> [([],trm)]

-- to gather all linearizations; assumes normal form, preserves label and args
allLinValues :: Term -> Err [[(Label,[([Patt],Term)])]]
allLinValues trm = do
  lts <- allLinFields trm
  mapM (mapPairsM (return . allCaseValues)) lts

redirectIdent n f@(CIQ _ c) = CIQ n c


{- ---- to be removed 21/9
-- to analyse types and terms into eta normal form

typeForm :: Exp -> Err (Context, Exp, [Exp])
typeForm e = do
  (cont,val) <- getContext e
  (cat,args) <- getArgs val
  return (cont,cat,args)

getContext :: Exp -> Err (Context, Exp)
getContext e = case e of
  EProd x a b -> do
    (g,b') <- getContext b
    return ((x,a):g,b')
  _ -> return ([],e)

valAtom :: Exp -> Err Atom
valAtom e = do
  (_,val,_) <- typeForm e
  case val of
    EAtom a -> return a
    _ -> prtBad "atom expected instead of" val
 
valCat :: Exp -> Err CIdent
valCat e = do
  a <- valAtom e
  case a of
    AC c -> return c
    _ -> prtBad "cat expected instead of" a

termForm :: Exp -> Err ([A.Ident], Exp, [Exp])
termForm e = do
  (cont,val) <- getBinds e
  (cat,args) <- getArgs val
  return (cont,cat,args)

getBinds :: Exp -> Err ([A.Ident], Exp)
getBinds e = case e of
  EAbs x b -> do
    (g,b') <- getBinds b
    return (x:g,b')
  _ -> return ([],e)

getArgs :: Exp -> Err (Exp,[Exp])
getArgs = get [] where
  get xs e = case e of
    EApp f a -> get (a:xs) f
    _ -> return (e, reverse xs)

-- the inverses of these

mkProd :: Context -> Exp -> Exp
mkProd c e = foldr (uncurry EProd) e c

mkApp :: Exp -> [Exp] -> Exp
mkApp = foldl EApp

mkAppAtom :: Atom -> [Exp] -> Exp
mkAppAtom a = mkApp (EAtom a)

mkAppCons :: CIdent -> [Exp] -> Exp
mkAppCons c = mkAppAtom $ AC c

mkType :: Context -> Exp -> [Exp] -> Exp
mkType c e xs = mkProd c $ mkApp e xs

mkAbs :: Context -> Exp -> Exp
mkAbs c e = foldr EAbs e $ map fst c

mkTerm :: Context -> Exp -> [Exp] -> Exp
mkTerm c e xs = mkAbs c $ mkApp e xs

mkAbsR :: [A.Ident] -> Exp -> Exp
mkAbsR c e = foldr EAbs e c

mkTermR :: [A.Ident] -> Exp -> [Exp] -> Exp
mkTermR c e xs = mkAbsR c $ mkApp e xs

-- this is used to create heuristic menus
eqCatId :: Cat -> Atom -> Bool
eqCatId (CIQ _ c) b = case b of
  AC (CIQ _ d) -> c == d
  AD (CIQ _ d) -> c == d
  _ -> False

-- a very weak notion of "compatible value category"
compatCat :: Cat -> Type -> Bool
compatCat c t = case t of
  EAtom b  -> eqCatId c b
  EApp f _  -> compatCat c f
  _ -> False

-- this is the way an atomic category looks as a type

cat2type :: Cat -> Type
cat2type = EAtom . AC

compatType :: Type -> Type -> Bool
compatType t = case t of
  EAtom (AC c) -> compatCat c
  _ -> (t ==)

type Fun = CIdent
type Cat = CIdent
type Type = Exp

mkFun, mkCat :: String -> String -> Fun
mkFun m f = CIQ (A.identC m) (A.identC f)
mkCat = mkFun

mkFunC, mkCatC :: String -> Fun
mkFunC s = let (m,f) = span (/= '.') s in mkFun m (drop 1 f)
mkCatC = mkFunC

-}

