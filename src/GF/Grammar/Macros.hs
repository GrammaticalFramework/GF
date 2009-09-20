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
import GF.Grammar.Values
import GF.Grammar.Predef
import GF.Grammar.Printer

import Control.Monad (liftM, liftM2)
import Data.Char (isDigit)
import Data.List (sortBy)
import Text.PrettyPrint

firstTypeForm :: Type -> Err (Context, Type)
firstTypeForm t = case t of
  Prod x a b  -> do
    (x', val) <- firstTypeForm b 
    return ((x,a):x',val)
  _ -> return ([],t)

qTypeForm :: Type -> Err (Context, Cat, [Term])
qTypeForm t = case t of
  Prod x a b  -> do
    (x', cat, args) <- qTypeForm b 
    return ((x,a):x', cat, args)
  App c a -> do
    (_,cat, args) <- qTypeForm c
    return ([],cat,args ++ [a])
  Q m c ->
    return ([],(m,c),[]) 
  QC m c ->
    return ([],(m,c),[]) 
  _       -> 
    Bad (render (text "no normal form of type" <+> ppTerm Unqualified 0 t))

qq :: QIdent -> Term
qq (m,c) = Q m c

typeForm :: Type -> Err (Context, Cat, [Term])
typeForm = qTypeForm ---- no need to distinguish any more

typeFormCnc :: Type -> Err (Context, Type)
typeFormCnc t = case t of
  Prod x a b  -> do
    (x', v) <- typeFormCnc b 
    return ((x,a):x',v)
  _ -> return ([],t)

valCat :: Type -> Err Cat
valCat typ = 
  do (_,cat,_) <- typeForm typ
     return cat

valType :: Type -> Err Type
valType typ = 
  do (_,cat,xx) <- typeForm typ --- not optimal to do in this way
     return $ mkApp (qq cat) xx

valTypeCnc :: Type -> Err Type
valTypeCnc typ = 
  do (_,ty) <- typeFormCnc typ
     return ty

typeRawSkeleton :: Type -> Err ([(Int,Type)],Type)
typeRawSkeleton typ =
  do (cont,typ) <- typeFormCnc typ
     args <- mapM (typeRawSkeleton . snd) cont
     return ([(length c, v) | (c,v) <- args], typ)

type MCat = (Ident,Ident)

getMCat :: Term -> Err MCat
getMCat t = case t of
  Q  m c -> return (m,c)
  QC m c -> return (m,c)
  Sort c -> return (identW, c)
  App f _ -> getMCat f
  _ -> Bad (render (text "no qualified constant" <+> ppTerm Unqualified 0 t))

typeSkeleton :: Type -> Err ([(Int,MCat)],MCat)
typeSkeleton typ = do
  (cont,val) <- typeRawSkeleton typ
  cont' <- mapPairsM getMCat cont
  val'  <- getMCat val
  return (cont',val')

catSkeleton :: Type -> Err ([MCat],MCat)
catSkeleton typ =
  do (args,val) <- typeSkeleton typ
     return (map snd args, val)

funsToAndFrom :: Type -> (MCat, [(MCat,[Int])])
funsToAndFrom t = errVal undefined $ do ---
  (cs,v) <- catSkeleton t
  let cis = zip cs [0..]
  return $ (v, [(c,[i | (c',i) <- cis, c' == c]) | c <- cs])

typeFormConcrete :: Type -> Err (Context, Type)
typeFormConcrete t = case t of
  Prod x a b  -> do 
    (x', typ) <- typeFormConcrete b 
    return ((x,a):x', typ)
  _       -> return ([],t)

isRecursiveType :: Type -> Bool
isRecursiveType t = errVal False $ do
  (cc,c) <- catSkeleton t -- thus recursivity on Cat level
  return $ any (== c) cc

isHigherOrderType :: Type -> Bool
isHigherOrderType t = errVal True $ do  -- pessimistic choice
  co <- contextOfType t
  return $ not $ null [x | (x,Prod _ _ _) <- co]

contextOfType :: Type -> Err Context
contextOfType typ = case typ of
  Prod x a b -> liftM ((x,a):) $ contextOfType b
  _ -> return [] 

termForm :: Term -> Err ([(Ident)], Term, [Term])
termForm t = case t of
   Abs x b  ->
     do (x', fun, args) <- termForm b 
        return (x:x', fun, args)
   App c a ->
     do (_,fun, args) <- termForm c
        return ([],fun,args ++ [a]) 
   _       -> 
     return ([],t,[])

termFormCnc :: Term -> ([(Ident)], Term)
termFormCnc t = case t of
   Abs x b  -> (x:xs, t') where (xs,t') = termFormCnc b 
   _        -> ([],t)

appForm :: Term -> (Term, [Term])
appForm t = case t of
  App c a -> (fun, args ++ [a]) where (fun, args) = appForm c
  _       -> (t,[])

varsOfType :: Type -> [Ident]
varsOfType t = case t of
  Prod x _ b -> x : varsOfType b
  _ -> []

mkProdSimple :: Context -> Term -> Term
mkProdSimple c t = mkProd (c,t,[])

mkProd :: (Context, Term, [Term]) -> Term
mkProd ([],typ,args) = mkApp typ args
mkProd ((x,a):dd, typ, args) = Prod x a (mkProd (dd, typ, args))

mkTerm :: ([(Ident)], Term, [Term]) -> Term
mkTerm (xx,t,aa) = mkAbs xx (mkApp t aa)

mkApp :: Term -> [Term] -> Term
mkApp = foldl App

mkAbs :: [Ident] -> Term -> Term
mkAbs xx t = foldr Abs t xx

appCons :: Ident -> [Term] -> Term
appCons = mkApp . Cn

mkLet :: [LocalDef] -> Term -> Term
mkLet defs t = foldr Let t defs

mkLetUntyped :: Context -> Term -> Term
mkLetUntyped defs = mkLet [(x,(Nothing,t)) | (x,t) <- defs]

isVariable :: Term -> Bool
isVariable (Vr _ ) = True
isVariable _ = False

eqIdent :: Ident -> Ident -> Bool
eqIdent = (==)

uType :: Type
uType = Cn cUndefinedType

assign :: Label -> Term -> Assign
assign l t = (l,(Nothing,t))

assignT :: Label -> Type -> Term -> Assign
assignT l a t = (l,(Just a,t))

unzipR :: [Assign] -> ([Label],[Term])
unzipR r = (ls, map snd ts) where (ls,ts) = unzip r

mkAssign :: [(Label,Term)] -> [Assign]
mkAssign lts = [assign l t | (l,t) <- lts]

zipAssign :: [Label] -> [Term] -> [Assign]
zipAssign ls ts = [assign l t | (l,t) <- zip ls ts]

mapAssignM :: Monad m => (Term -> m c) -> [Assign] -> m [(Label,(Maybe c,c))]
mapAssignM f = mapM (\ (ls,tv) -> liftM ((,) ls) (g tv))
  where g (t,v) = liftM2 (,) (maybe (return Nothing) (liftM Just . f) t) (f v)

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
  _    -> Bad (render (text "record expected, found" <+> ppTerm Unqualified 0 t))

typeType, typePType, typeStr, typeTok, typeStrs :: Term

typeType  = Sort cType
typePType = Sort cPType
typeStr   = Sort cStr
typeTok   = Sort cTok
typeStrs  = Sort cStrs

typeString, typeFloat, typeInt :: Term
typeInts :: Integer -> Term
typePBool :: Term
typeError :: Term

typeString = cnPredef cString
typeInt = cnPredef cInt
typeFloat = cnPredef cFloat
typeInts i = App (cnPredef cInts) (EInt i)
typePBool = cnPredef cPBool
typeError = cnPredef cErrorType

isTypeInts :: Term -> Maybe Integer
isTypeInts (App c (EInt i)) | c == cnPredef cInts = Just i
isTypeInts _                                      = Nothing

isPredefConstant :: Term -> Bool
isPredefConstant t = case t of
  Q mod _ | mod == cPredef || mod == cPredefAbs -> True
  _                                             -> False

cnPredef :: Ident -> Term
cnPredef f = Q cPredef f

mkSelects :: Term -> [Term] -> Term
mkSelects t tt = foldl S t tt

mkTable :: [Term] -> Term -> Term
mkTable tt t = foldr Table t tt

mkCTable :: [Ident] -> Term -> Term
mkCTable ids v = foldr ccase v ids where 
  ccase x t = T TRaw [(PV x,t)]

mkHypo :: Term -> Hypo
mkHypo typ = (identW, typ)

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
mkFunType tt t = mkProd ([(identW, ty) | ty <- tt], t, []) -- nondep prod

plusRecType :: Type -> Type -> Err Type
plusRecType t1 t2 = case (t1, t2) of
  (RecType r1, RecType r2) -> case
    filter (`elem` (map fst r1)) (map fst r2) of
      [] -> return (RecType (r1 ++ r2))
      ls -> Bad $ render (text "clashing labels" <+> hsep (map ppLabel ls))
  _ -> Bad $ render (text "cannot add record types" <+> ppTerm Unqualified 0 t1 <+> text "and" <+> ppTerm Unqualified 0 t2) 

plusRecord :: Term -> Term -> Err Term
plusRecord t1 t2 =
 case (t1,t2) of
   (R r1, R r2 ) -> return (R ([(l,v) | -- overshadowing of old fields
                              (l,v) <- r1, not (elem l (map fst r2)) ] ++ r2))
   (_,    FV rs) -> mapM (plusRecord t1) rs >>= return . FV
   (FV rs,_    ) -> mapM (`plusRecord` t2) rs >>= return . FV
   _ -> Bad $ render (text "cannot add records" <+> ppTerm Unqualified 0 t1 <+> text "and" <+> ppTerm Unqualified 0 t2)

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

int2term :: Integer -> Term
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

term2patt :: Term -> Err Patt
term2patt trm = case termForm trm of
  Ok ([], Vr x, []) | x == identW -> return PW
                    | otherwise   -> return (PV x)
  Ok ([], Val te ty x, []) -> do
    te' <- term2patt te
    return (PVal te' ty x)
  Ok ([], Con c, aa) -> do
    aa' <- mapM term2patt aa
    return (PC c aa')
  Ok ([], QC p c, aa) -> do
    aa' <- mapM term2patt aa
    return (PP p c aa')

  Ok ([], Q p c, []) -> do
    return (PM p c)

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

  _ -> Bad $ render (text "no pattern corresponds to term" <+> ppTerm Unqualified 0 trm)

patt2term :: Patt -> Term
patt2term pt = case pt of
  PV x      -> Vr x
  PW        -> Vr identW             --- not parsable, should not occur
  PVal v t i -> Val (patt2term v) t i
  PMacro c  -> Cn c
  PM p c    -> Q p c

  PC c pp   -> mkApp (Con c) (map patt2term pp)
  PP p c pp -> mkApp (QC p c) (map patt2term pp)

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


redirectTerm :: Ident -> Term -> Term
redirectTerm n t = case t of
  QC _ f -> QC n f
  Q _ f  -> Q  n f
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
  Alts (d,vs) -> do
    d0 <- strsFromTerm d
    v0 <- mapM (strsFromTerm . fst) vs
    c0 <- mapM (strsFromTerm . snd) vs
    let vs' = zip v0 c0
    return [strTok (str2strings def) vars | 
              def  <- d0,
              vars <- [[(str2strings v, map sstr c) | (v,c) <- zip vv c0] | 
                                                          vv <- combinations v0]
           ]
  FV ts -> mapM strsFromTerm ts >>= return . concat
  Strs ts -> mapM strsFromTerm ts >>= return . concat  
  Alias _ _ d -> strsFromTerm d --- should not be needed...
  _ -> Bad (render (text "cannot get Str from term" <+> ppTerm Unqualified 0 t))

-- | to print an Str-denoting term as a string; if the term is of wrong type, the error msg
stringFromTerm :: Term -> String
stringFromTerm = err id (ifNull "" (sstr . head)) . strsFromTerm


-- | to define compositional term functions
composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp op trm = case composOp (mkMonadic op) trm of
  Ok t -> t
  _ -> error "the operation is safe isn't it ?"
 where
 mkMonadic f = return . f

-- | to define compositional term functions
composOp :: Monad m => (Term -> m Term) -> Term -> m Term
composOp co trm = 
 case trm of
   App c a -> 
     do c' <- co c
        a' <- co a
        return (App c' a')
   Abs x b ->
     do b' <- co b
        return (Abs x b')
   Prod x a b -> 
     do a' <- co a
        b' <- co b
        return (Prod x a' b')
   S c a -> 
     do c' <- co c
        a' <- co a
        return (S c' a')
   Table a c -> 
     do a' <- co a
        c' <- co c
        return (Table a' c')
   R r -> 
     do r' <- mapAssignM co r
        return (R r')
   RecType r -> 
     do r' <- mapPairListM (co . snd) r
        return (RecType r')
   P t i ->
     do t' <- co t
        return (P t' i)
   PI t i j ->
     do t' <- co t
        return (PI t' i j)
   ExtR a c -> 
     do a' <- co a
        c' <- co c
        return (ExtR a' c')

   T i cc -> 
     do cc' <- mapPairListM (co . snd) cc
        i'  <- changeTableType co i
        return (T i' cc')

   TSh i cc -> 
     do cc' <- mapPairListM (co . snd) cc
        i'  <- changeTableType co i
        return (TSh i' cc')

   V ty vs ->
     do ty' <- co ty
        vs' <- mapM co vs
        return (V ty' vs')

   Val te ty i ->
     do te' <- co te
        ty' <- co ty
        return (Val te' ty' i)

   Let (x,(mt,a)) b -> 
     do a'  <- co a
        mt' <- case mt of
                 Just t -> co t >>= (return . Just) 
                 _ -> return mt
        b'  <- co b
        return (Let (x,(mt',a')) b')
   Alias c ty d -> 
     do v <- co d
        ty' <- co ty
        return $ Alias c ty' v
   C s1 s2 -> 
     do v1 <- co s1 
        v2 <- co s2
        return (C v1 v2)
   Glue s1 s2 -> 
     do v1 <- co s1
        v2 <- co s2
        return (Glue v1 v2)
   Alts (t,aa) ->
     do t' <- co t
        aa' <- mapM (pairM co) aa
        return (Alts (t',aa'))
   FV ts -> mapM co ts >>= return . FV
   Strs tt -> mapM co tt >>= return . Strs

   EPattType ty -> 
     do ty' <- co ty
        return (EPattType ty')

   ELincat c ty -> 
     do ty' <- co ty
        return (ELincat c ty')

   ELin c ty -> 
     do ty' <- co ty
        return (ELin c ty')

   _ -> return trm -- covers K, Vr, Cn, Sort, EPatt

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

collectOp :: (Term -> [a]) -> Term -> [a]
collectOp co trm = case trm of
  App c a    -> co c ++ co a 
  Abs _ b    -> co b
  Prod _ a b -> co a ++ co b 
  S c a      -> co c ++ co a
  Table a c  -> co a ++ co c
  ExtR a c   -> co a ++ co c
  R r        -> concatMap (\ (_,(mt,a)) -> maybe [] co mt ++ co a) r 
  RecType r  -> concatMap (co . snd) r 
  P t i      -> co t
  T _ cc     -> concatMap (co . snd) cc -- not from patterns --- nor from type annot
  TSh _ cc   -> concatMap (co . snd) cc -- not from patterns --- nor from type annot
  V _ cc     -> concatMap co         cc --- nor from type annot
  Let (x,(mt,a)) b -> maybe [] co mt ++ co a ++ co b
  C s1 s2    -> co s1 ++ co s2 
  Glue s1 s2 -> co s1 ++ co s2 
  Alts (t,aa) -> let (x,y) = unzip aa in co t ++ concatMap co (x ++ y)
  FV ts      -> concatMap co ts
  Strs tt    -> concatMap co tt
  _ -> [] -- covers K, Vr, Cn, Sort

-- | to find the word items in a term
wordsInTerm :: Term -> [String]
wordsInTerm trm = filter (not . null) $ case trm of
   K s     -> [s]
   S c _   -> wo c
   Alts (t,aa) -> wo t ++ concatMap (wo . fst) aa
   _       -> collectOp wo trm
 where wo = wordsInTerm

noExist :: Term
noExist = FV []

defaultLinType :: Type
defaultLinType = mkRecType linLabel [typeStr]

-- | from GF1, 20\/9\/2003
isInOneType :: Type -> Bool
isInOneType t = case t of
  Prod _ a b -> a == b
  _ -> False

-- normalize records and record types; put s first

sortRec :: [(Label,a)] -> [(Label,a)]
sortRec = sortBy ordLabel where
  ordLabel (r1,_) (r2,_) = 
    case (showIdent (label2ident r1), showIdent (label2ident r2)) of
      ("s",_) -> LT
      (_,"s") -> GT
      (s1,s2) -> compare s1 s2



