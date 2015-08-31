----------------------------------------------------------------------
-- |
-- Module      : Macros
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/11 16:38:00 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.24 $
--
-- Macros for constructing and analysing source code terms.
--
-- operations on terms and types not involving lookup in or reference to grammars
--
-- AR 7\/12\/1999 - 9\/5\/2000 -- 4\/6\/2001
-----------------------------------------------------------------------------

module GF.Grammar.Macros where

import GF.Data.Operations
import GF.Data.Str
import GF.Infra.Ident
import GF.Grammar.Grammar
--import GF.Grammar.Values
import GF.Grammar.Predef
import GF.Grammar.Printer

import Control.Monad.Identity(Identity(..))
import qualified Data.Traversable as T(mapM)
import Control.Monad (liftM, liftM2, liftM3)
--import Data.Char (isDigit)
import Data.List (sortBy,nub)
import Data.Monoid
import GF.Text.Pretty(render,(<+>),hsep,fsep)

-- ** Functions for constructing and analysing source code terms.

typeForm :: Type -> (Context, Cat, [Term])
typeForm t =
  case t of
    Prod b x a t  ->
      let (x', cat, args) = typeForm t
      in ((b,x,a):x', cat, args)
    App c a ->
      let (_,  cat, args) = typeForm c
      in ([],cat,args ++ [a])
    Q  c -> ([],c,[])
    QC c -> ([],c,[])
    Sort c -> ([],(MN identW, c),[])
    _      -> error (render ("no normal form of type" <+> ppTerm Unqualified 0 t))

typeFormCnc :: Type -> (Context, Type)
typeFormCnc t = 
  case t of
    Prod b x a t -> let (x', v) = typeFormCnc t
                    in ((b,x,a):x',v)
    _            -> ([],t)

valCat :: Type -> Cat
valCat typ = 
  let (_,cat,_) = typeForm typ
  in cat

valType :: Type -> Type
valType typ =
  let (_,cat,xx) = typeForm typ --- not optimal to do in this way
  in mkApp (Q cat) xx

valTypeCnc :: Type -> Type
valTypeCnc typ = snd (typeFormCnc typ)

typeSkeleton :: Type -> ([(Int,Cat)],Cat)
typeSkeleton typ =
  let (ctxt,cat,_) = typeForm typ
  in ([(length c, v) | (b,x,t) <- ctxt, let (c,v) = typeSkeleton t], cat)

catSkeleton :: Type -> ([Cat],Cat)
catSkeleton typ =
  let (args,val) = typeSkeleton typ
  in (map snd args, val)

funsToAndFrom :: Type -> (Cat, [(Cat,[Int])])
funsToAndFrom t =
  let (cs,v) = catSkeleton t
      cis = zip cs [0..]
  in (v, [(c,[i | (c',i) <- cis, c' == c]) | c <- cs])

isRecursiveType :: Type -> Bool
isRecursiveType t =
  let (cc,c) = catSkeleton t -- thus recursivity on Cat level
  in any (== c) cc

isHigherOrderType :: Type -> Bool
isHigherOrderType t = fromErr True $ do  -- pessimistic choice
  co <- contextOfType t
  return $ not $ null [x | (_,x,Prod _ _ _ _) <- co]

contextOfType :: Monad m => Type -> m Context
contextOfType typ = case typ of
  Prod b x a t -> liftM ((b,x,a):) $ contextOfType t
  _            -> return [] 

termForm :: Monad m => Term -> m ([(BindType,Ident)], Term, [Term])
termForm t = case t of
   Abs b x t  ->
     do (x', fun, args) <- termForm t
        return ((b,x):x', fun, args)
   App c a ->
     do (_,fun, args) <- termForm c
        return ([],fun,args ++ [a]) 
   _       -> 
     return ([],t,[])

termFormCnc :: Term -> ([(BindType,Ident)], Term)
termFormCnc t = case t of
   Abs b x t  -> ((b,x):xs, t') where (xs,t') = termFormCnc t
   _          -> ([],t)

appForm :: Term -> (Term, [Term])
appForm t = case t of
  App c a   -> (fun, args ++ [a]) where (fun, args) = appForm c
  Typed t _ -> appForm t
  _         -> (t,[])

mkProdSimple :: Context -> Term -> Term
mkProdSimple c t = mkProd c t []

mkProd :: Context -> Term -> [Term] -> Term
mkProd []           typ args = mkApp typ args
mkProd ((b,x,a):dd) typ args = Prod b x a (mkProd dd typ args)

mkTerm :: ([(BindType,Ident)], Term, [Term]) -> Term
mkTerm (xx,t,aa) = mkAbs xx (mkApp t aa)

mkApp :: Term -> [Term] -> Term
mkApp = foldl App

mkAbs :: [(BindType,Ident)] -> Term -> Term
mkAbs xx t = foldr (uncurry Abs) t xx

appCons :: Ident -> [Term] -> Term
appCons = mkApp . Cn

mkLet :: [LocalDef] -> Term -> Term
mkLet defs t = foldr Let t defs

mkLetUntyped :: Context -> Term -> Term
mkLetUntyped defs = mkLet [(x,(Nothing,t)) | (_,x,t) <- defs]

isVariable :: Term -> Bool
isVariable (Vr _ ) = True
isVariable _ = False

--eqIdent :: Ident -> Ident -> Bool
--eqIdent = (==)

uType :: Type
uType = Cn cUndefinedType

-- *** Assignment

assign :: Label -> Term -> Assign
assign l t = (l,(Nothing,t))

assignT :: Label -> Type -> Term -> Assign
assignT l a t = (l,(Just a,t))

unzipR :: [Assign] -> ([Label],[Term])
unzipR r = (ls, map snd ts) where (ls,ts) = unzip r

mkAssign :: [(Label,Term)] -> [Assign]
mkAssign lts = [assign l t | (l,t) <- lts]

projectRec :: Label -> [Assign] -> Term
projectRec l rs =
  case lookup l rs of
    Just (_,t) -> t
    Nothing    -> error (render ("no value for label" <+> l))

zipAssign :: [Label] -> [Term] -> [Assign]
zipAssign ls ts = [assign l t | (l,t) <- zip ls ts]

mapAssignM :: Monad m => (Term -> m c) -> [Assign] -> m [(Label,(Maybe c,c))]
mapAssignM f = mapM (\ (ls,tv) -> liftM ((,) ls) (g tv))
  where g (t,v) = liftM2 (,) (maybe (return Nothing) (liftM Just . f) t) (f v)

-- *** Records

mkRecordN :: Int -> (Int -> Label) -> [Term] -> Term
mkRecordN int lab typs = R [ assign (lab i) t | (i,t) <- zip [int..] typs]

mkRecord :: (Int -> Label) -> [Term] -> Term
mkRecord = mkRecordN 0

mkRecTypeN :: Int -> (Int -> Label) -> [Type] -> Type
mkRecTypeN int lab typs = RecType [ (lab i, t) | (i,t) <- zip [int..] typs]

mkRecType :: (Int -> Label) -> [Type] -> Type
mkRecType = mkRecTypeN 0

record2subst :: Term -> Err Substitution
record2subst t = case t of
  R fs -> return [(identC x, t) | (LIdent x,(_,t)) <- fs]
  _    -> Bad (render ("record expected, found" <+> ppTerm Unqualified 0 t))


-- *** Types

typeType, typePType, typeStr, typeTok, typeStrs :: Type

typeType  = Sort cType
typePType = Sort cPType
typeStr   = Sort cStr
typeTok   = Sort cTok
typeStrs  = Sort cStrs

typeString, typeFloat, typeInt :: Type
typeInts :: Int -> Type
typePBool :: Type
typeError :: Type

typeString = cnPredef cString
typeInt = cnPredef cInt
typeFloat = cnPredef cFloat
typeInts i = App (cnPredef cInts) (EInt i)
typePBool = cnPredef cPBool
typeError = cnPredef cErrorType

isTypeInts :: Type -> Maybe Int
isTypeInts (App c (EInt i)) | c == cnPredef cInts = Just i
isTypeInts _                                      = Nothing

-- *** Terms

isPredefConstant :: Term -> Bool
isPredefConstant t = case t of
  Q (mod,_) | mod == cPredef || mod == cPredefAbs -> True
  _                                               -> False

checkPredefError :: Monad m => Term -> m Term
checkPredefError t =
    case t of
      Error s -> fail ("Error: "++s)
      _ -> return t

cnPredef :: Ident -> Term
cnPredef f = Q (cPredef,f)

mkSelects :: Term -> [Term] -> Term
mkSelects t tt = foldl S t tt

mkTable :: [Term] -> Term -> Term
mkTable tt t = foldr Table t tt

mkCTable :: [(BindType,Ident)] -> Term -> Term
mkCTable ids v = foldr ccase v ids where 
  ccase (_,x) t = T TRaw [(PV x,t)]

mkHypo :: Term -> Hypo
mkHypo typ = (Explicit,identW, typ)

eqStrIdent :: Ident -> Ident -> Bool
eqStrIdent = (==)

tuple2record :: [Term] -> [Assign]
tuple2record ts = [assign (tupleLabel i) t | (i,t) <- zip [1..] ts]

tuple2recordType :: [Term] -> [Labelling]
tuple2recordType ts = [(tupleLabel i, t) | (i,t) <- zip [1..] ts]

tuple2recordPatt :: [Patt] -> [(Label,Patt)]
tuple2recordPatt ts = [(tupleLabel i, t) | (i,t) <- zip [1..] ts]

mkCases :: Ident -> Term -> Term
mkCases x t = T TRaw [(PV x, t)]

mkWildCases :: Term -> Term
mkWildCases = mkCases identW

mkFunType :: [Type] -> Type -> Type
mkFunType tt t = mkProd [(Explicit,identW, ty) | ty <- tt] t [] -- nondep prod

--plusRecType :: Type -> Type -> Err Type
plusRecType t1 t2 = case (t1, t2) of
  (RecType r1, RecType r2) -> case
    filter (`elem` (map fst r1)) (map fst r2) of
      [] -> return (RecType (r1 ++ r2))
      ls -> raise $ render ("clashing labels" <+> hsep ls)
  _ -> raise $ render ("cannot add record types" <+> ppTerm Unqualified 0 t1 <+> "and" <+> ppTerm Unqualified 0 t2) 

--plusRecord :: Term -> Term -> Err Term
plusRecord t1 t2 =
 case (t1,t2) of
   (R r1, R r2 ) -> return (R ([(l,v) | -- overshadowing of old fields
                              (l,v) <- r1, not (elem l (map fst r2)) ] ++ r2))
   (_,    FV rs) -> mapM (plusRecord t1) rs >>= return . FV
   (FV rs,_    ) -> mapM (`plusRecord` t2) rs >>= return . FV
   _ -> raise $ render ("cannot add records" <+> ppTerm Unqualified 0 t1 <+> "and" <+> ppTerm Unqualified 0 t2)

-- | default linearization type
defLinType :: Type
defLinType = RecType [(theLinLabel,  typeStr)]

-- | refreshing variables
mkFreshVar :: [Ident] -> Ident
mkFreshVar olds = varX (maxVarIndex olds + 1) 

-- | trying to preserve a given symbol
mkFreshVarX :: [Ident] -> Ident -> Ident
mkFreshVarX olds x = if (elem x olds) then (varX (maxVarIndex olds + 1)) else x

maxVarIndex :: [Ident] -> Int
maxVarIndex = maximum . ((-1):) . map varIndex

mkFreshVars :: Int -> [Ident] -> [Ident] 
mkFreshVars n olds = [varX (maxVarIndex olds + i) | i <- [1..n]]

-- | quick hack for refining with var in editor
freshAsTerm :: String -> Term
freshAsTerm s = Vr (varX (readIntArg s))

-- | create a terminal for concrete syntax
string2term :: String -> Term
string2term = K

int2term :: Int -> Term
int2term = EInt

float2term :: Double -> Term
float2term = EFloat

-- | create a terminal from identifier
ident2terminal :: Ident -> Term
ident2terminal = K . showIdent

symbolOfIdent :: Ident -> String
symbolOfIdent = showIdent

symid :: Ident -> String
symid = symbolOfIdent

justIdentOf :: Term -> Maybe Ident
justIdentOf (Vr x) = Just x
justIdentOf (Cn x) = Just x
justIdentOf _ = Nothing

linTypeStr :: Type
linTypeStr = mkRecType linLabel [typeStr] -- default lintype {s :: Str}

linAsStr :: String -> Term
linAsStr s = mkRecord linLabel [K s] -- default linearization {s = s}

-- *** Term and pattern conversion

term2patt :: Term -> Err Patt
term2patt trm = case termForm trm of
  Ok ([], Vr x, []) | x == identW -> return PW
                    | otherwise   -> return (PV x)
  Ok ([], Con c, aa) -> do
    aa' <- mapM term2patt aa
    return (PC c aa')
  Ok ([], QC  c, aa) -> do
    aa' <- mapM term2patt aa
    return (PP c aa')

  Ok ([], Q c, []) -> do
    return (PM c)

  Ok ([], R r, []) -> do
    let (ll,aa) = unzipR r
    aa' <- mapM term2patt aa
    return (PR (zip ll aa'))
  Ok ([],EInt i,[]) -> return $ PInt i
  Ok ([],EFloat i,[]) -> return $ PFloat i
  Ok ([],K s,   []) -> return $ PString s

--- encodings due to excessive use of term-patt convs. AR 7/1/2005
  Ok ([], Cn id, [Vr a,b]) | id == cAs -> do
    b' <- term2patt b
    return (PAs a b')
  Ok ([], Cn id, [a]) | id == cNeg  -> do
    a' <- term2patt a
    return (PNeg a')
  Ok ([], Cn id, [a]) | id == cRep -> do
    a' <- term2patt a
    return (PRep a')
  Ok ([], Cn id, []) | id == cRep -> do
    return PChar
  Ok ([], Cn id,[K s]) | id == cChars  -> do
    return $ PChars s
  Ok ([], Cn id, [a,b]) | id == cSeq -> do
    a' <- term2patt a
    b' <- term2patt b
    return (PSeq a' b')
  Ok ([], Cn id, [a,b]) | id == cAlt -> do
    a' <- term2patt a
    b' <- term2patt b
    return (PAlt a' b')

  Ok ([], Cn c, []) -> do
    return (PMacro c)

  _ -> Bad $ render ("no pattern corresponds to term" <+> ppTerm Unqualified 0 trm)

patt2term :: Patt -> Term
patt2term pt = case pt of
  PV x      -> Vr x
  PW        -> Vr identW             --- not parsable, should not occur
  PMacro c  -> Cn c
  PM c      -> Q c

  PC c pp   -> mkApp (Con c) (map patt2term pp)
  PP c pp   -> mkApp (QC  c) (map patt2term pp)

  PR r      -> R [assign l (patt2term p) | (l,p) <- r] 
  PT _ p    -> patt2term p
  PInt i    -> EInt i
  PFloat i  -> EFloat i
  PString s -> K s 

  PAs x p   -> appCons cAs    [Vr x, patt2term p]            --- an encoding
  PChar     -> appCons cChar  []                             --- an encoding
  PChars s  -> appCons cChars [K s]                          --- an encoding
  PSeq a b  -> appCons cSeq   [(patt2term a), (patt2term b)] --- an encoding
  PAlt a b  -> appCons cAlt   [(patt2term a), (patt2term b)] --- an encoding
  PRep a    -> appCons cRep   [(patt2term a)]                --- an encoding
  PNeg a    -> appCons cNeg   [(patt2term a)]                --- an encoding


-- *** Almost compositional

-- | to define compositional term functions
composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp op = runIdentity . composOp (return . op)

-- | to define compositional term functions
composOp :: Monad m => (Term -> m Term) -> Term -> m Term
composOp co trm = 
 case trm of
   App c a          -> liftM2 App (co c) (co a)
   Abs b x t        -> liftM (Abs b x) (co t)
   Prod b x a t     -> liftM2 (Prod b x) (co a) (co t)
   S c a            -> liftM2 S (co c) (co a)
   Table a c        -> liftM2 Table (co a) (co c)
   R r              -> liftM R (mapAssignM co r)
   RecType r        -> liftM RecType (mapPairsM co r)
   P t i            -> liftM2 P (co t) (return i)
   ExtR a c         -> liftM2 ExtR (co a) (co c)
   T i cc           -> liftM2 (flip T) (mapPairsM co cc) (changeTableType co i)
   V ty vs          -> liftM2 V (co ty) (mapM co vs)
   Let (x,(mt,a)) b -> liftM3 let' (co a) (T.mapM co mt) (co b)
     where let' a' mt' b' = Let (x,(mt',a')) b'
   C s1 s2          -> liftM2 C (co s1) (co s2)
   Glue s1 s2       -> liftM2 Glue (co s1) (co s2)
   Alts t aa        -> liftM2 Alts (co t) (mapM (pairM co) aa)
   FV ts            -> liftM FV (mapM co ts)
   Strs tt          -> liftM Strs (mapM co tt)
   EPattType ty     -> liftM EPattType (co ty)
   ELincat c ty     -> liftM (ELincat c) (co ty)
   ELin c ty        -> liftM (ELin c) (co ty)
   ImplArg t        -> liftM ImplArg (co t)
   _ -> return trm -- covers K, Vr, Cn, Sort, EPatt

composSafePattOp op = runIdentity . composPattOp (return . op)

composPattOp :: Monad m => (Patt -> m Patt) -> Patt -> m Patt
composPattOp op patt =
  case patt of
    PC c ps         -> liftM  (PC c) (mapM op ps)
    PP qc ps        -> liftM  (PP qc) (mapM op ps)
    PR as           -> liftM  PR (mapPairsM op as)
    PT ty p         -> liftM  (PT ty) (op p)
    PAs x p         -> liftM  (PAs x) (op p)
    PImplArg p      -> liftM  PImplArg (op p)
    PNeg p          -> liftM  PNeg (op p)
    PAlt p1 p2      -> liftM2 PAlt (op p1) (op p2)
    PSeq p1 p2      -> liftM2 PSeq (op p1) (op p2)
    PMSeq (_,p1) (_,p2) -> liftM2 PSeq (op p1) (op p2) -- information loss
    PRep p          -> liftM  PRep (op p)
    _               -> return patt -- covers cases without subpatterns

collectOp :: Monoid m => (Term -> m) -> Term -> m
collectOp co trm = case trm of
  App c a      -> co c <> co a
  Abs _ _ b    -> co b
  Prod _ _ a b -> co a <> co b
  S c a        -> co c <> co a
  Table a c    -> co a <> co c
  ExtR a c     -> co a <> co c
  R r          -> mconcatMap (\ (_,(mt,a)) -> maybe mempty co mt <> co a) r
  RecType r    -> mconcatMap (co . snd) r
  P t i        -> co t
  T _ cc       -> mconcatMap (co . snd) cc -- not from patterns --- nor from type annot
  V _ cc       -> mconcatMap co         cc --- nor from type annot
  Let (x,(mt,a)) b -> maybe mempty co mt <> co a <> co b
  C s1 s2      -> co s1 <> co s2
  Glue s1 s2   -> co s1 <> co s2
  Alts t aa    -> let (x,y) = unzip aa in co t <> mconcatMap co (x <> y)
  FV ts        -> mconcatMap co ts
  Strs tt      -> mconcatMap co tt
  _            -> mempty -- covers K, Vr, Cn, Sort

mconcatMap f = mconcat . map f

collectPattOp :: (Patt -> [a]) -> Patt -> [a]
collectPattOp op patt =
  case patt of
    PC c ps         -> concatMap op ps
    PP qc ps        -> concatMap op ps
    PR as           -> concatMap (op.snd) as
    PT ty p         -> op p
    PAs x p         -> op p
    PImplArg p      -> op p
    PNeg p          -> op p
    PAlt p1 p2      -> op p1++op p2
    PSeq p1 p2      -> op p1++op p2
    PMSeq (_,p1) (_,p2) -> op p1++op p2
    PRep p          -> op p
    _               -> []     -- covers cases without subpatterns


-- *** Misc

redirectTerm :: ModuleName -> Term -> Term
redirectTerm n t = case t of
  QC (_,f) -> QC (n,f)
  Q  (_,f) -> Q  (n,f)
  _ -> composSafeOp (redirectTerm n) t

-- | to gather ultimate cases in a table; preserves pattern list
allCaseValues :: Term -> [([Patt],Term)]
allCaseValues trm = case trm of
  T _ cs -> [(p:ps, t) | (p,t0) <- cs, (ps,t) <- allCaseValues t0]
  _      -> [([],trm)]

-- | to get a string from a term that represents a sequence of terminals
strsFromTerm :: Term -> Err [Str]
strsFromTerm t = case t of
  K s   -> return [str s]
  Empty -> return [str []]
  C s t -> do
    s' <- strsFromTerm s
    t' <- strsFromTerm t
    return [plusStr x y | x <- s', y <- t']
  Glue s t -> do
    s' <- strsFromTerm s
    t' <- strsFromTerm t
    return [glueStr x y | x <- s', y <- t']
  Alts d vs -> do
    d0 <- strsFromTerm d
    v0 <- mapM (strsFromTerm . fst) vs
    c0 <- mapM (strsFromTerm . snd) vs
  --let vs' = zip v0 c0
    return [strTok (str2strings def) vars | 
              def  <- d0,
              vars <- [[(str2strings v, map sstr c) | (v,c) <- zip vv c0] | 
                                                          vv <- combinations v0]
           ]
  FV ts -> mapM strsFromTerm ts >>= return . concat
  Strs ts -> mapM strsFromTerm ts >>= return . concat  
  _ -> raise (render ("cannot get Str from term" <+> ppTerm Unqualified 0 t))

-- | to print an Str-denoting term as a string; if the term is of wrong type, the error msg
stringFromTerm :: Term -> String
stringFromTerm = err id (ifNull "" (sstr . head)) . strsFromTerm

getTableType :: TInfo -> Err Type
getTableType i = case i of
  TTyped ty -> return ty
  TComp ty  -> return ty
  TWild ty  -> return ty
  _ -> Bad "the table is untyped"

changeTableType :: Monad m => (Type -> m Type) -> TInfo -> m TInfo
changeTableType co i = case i of
    TTyped ty -> co ty >>= return . TTyped
    TComp ty  -> co ty >>= return . TComp
    TWild ty  -> co ty >>= return . TWild
    _ -> return i

-- | to find the word items in a term
wordsInTerm :: Term -> [String]
wordsInTerm trm = filter (not . null) $ case trm of
   K s     -> [s]
   S c _   -> wo c
   Alts t aa -> wo t ++ concatMap (wo . fst) aa
   _       -> collectOp wo trm
 where wo = wordsInTerm

noExist :: Term
noExist = FV []

defaultLinType :: Type
defaultLinType = mkRecType linLabel [typeStr]

-- normalize records and record types; put s first

sortRec :: [(Label,a)] -> [(Label,a)]
sortRec = sortBy ordLabel where
  ordLabel (r1,_) (r2,_) = 
    case (showIdent (label2ident r1), showIdent (label2ident r2)) of
      ("s",_) -> LT
      (_,"s") -> GT
      (s1,s2) -> compare s1 s2

-- *** Dependencies

-- | dependency check, detecting circularities and returning topo-sorted list

allDependencies :: (ModuleName -> Bool) -> BinTree Ident Info -> [(Ident,[Ident])]
allDependencies ism b = 
  [(f, nub (concatMap opty (pts i))) | (f,i) <- tree2list b]
  where
    opersIn t = case t of
      Q  (n,c) | ism n -> [c]
      QC (n,c) | ism n -> [c]
      _ -> collectOp opersIn t
    opty (Just (L _ ty)) = opersIn ty
    opty _ = []
    pts i = case i of
      ResOper pty pt -> [pty,pt]
      ResOverload _ tyts -> concat [[Just ty, Just tr] | (ty,tr) <- tyts]
      ResParam (Just (L loc ps)) _ -> [Just (L loc t) | (_,cont) <- ps, (_,_,t) <- cont]
      CncCat pty _ _ _ _ -> [pty]
      CncFun _   pt _ _ -> [pt]  ---- (Maybe (Ident,(Context,Type))
      AbsFun pty _ ptr _ -> [pty] --- ptr is def, which can be mutual
      AbsCat (Just (L loc co)) -> [Just (L loc ty) | (_,_,ty) <- co]
      _              -> []

topoSortJments :: ErrorMonad m => SourceModule -> m [(Ident,Info)]
topoSortJments (m,mi) = do
  is <- either
          return
          (\cyc -> raise (render ("circular definitions:" <+> fsep (head cyc))))
          (topoTest (allDependencies (==m) (jments mi)))
  return (reverse [(i,info) | i <- is, Ok info <- [lookupTree showIdent i (jments mi)]])

topoSortJments2 :: ErrorMonad m => SourceModule -> m [[(Ident,Info)]]
topoSortJments2 (m,mi) = do
  iss <- either
           return
           (\cyc -> raise (render ("circular definitions:"
                                   <+> fsep (head cyc))))
           (topoTest2 (allDependencies (==m) (jments mi)))
  return
    [[(i,info) | i<-is,Ok info<-[lookupTree showIdent i (jments mi)]] | is<-iss]
