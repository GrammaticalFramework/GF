module GF.Devel.Grammar.Macros where

import GF.Devel.Grammar.Terms
import GF.Devel.Grammar.Judgements
import GF.Devel.Grammar.Modules
import GF.Infra.Ident

import GF.Data.Str
import GF.Data.Operations

import qualified Data.Map as Map
import Control.Monad (liftM,liftM2)


-- analyse types and terms

contextOfType :: Type -> Context
contextOfType ty = co where (co,_,_) = typeForm ty

typeForm :: Type -> (Context,Term,[Term])
typeForm t = (co,f,a) where
  (co,t2) = prodForm t
  (f,a) = appForm t2

termForm :: Term -> ([Ident],Term,[Term])
termForm t = (co,f,a) where
  (co,t2) = absForm t
  (f,a) = appForm t2

prodForm :: Type -> (Context,Term)
prodForm t = case t of
  Prod x ty val -> ((x,ty):co,t2) where (co,t2) = prodForm val
  _ -> ([],t)

absForm :: Term -> ([Ident],Term)
absForm t = case t of
  Abs x val -> (x:co,t2) where (co,t2) = absForm val
  _ -> ([],t)


appForm :: Term -> (Term,[Term])
appForm tr = (f,reverse xs) where 
  (f,xs) = apps tr
  apps t = case t of
    App f a -> (f2,a:a2) where (f2,a2) = appForm f
    _ -> (t,[])

valCat :: Type -> Err (Ident,Ident)
valCat typ = case typeForm typ of
  (_,Q m c,_) -> return (m,c)

typeRawSkeleton :: Type -> Err ([(Int,Type)],Type)
typeRawSkeleton typ = do
  let (cont,typ) = prodForm typ
  args <- mapM (typeRawSkeleton . snd) cont
  return ([(length c, v) | (c,v) <- args], typ)

type MCat = (Ident,Ident)

sortMCat :: String -> MCat
sortMCat s = (identC "_", identC s)

--- hack for Editing.actCat in empty state
errorCat :: MCat
errorCat = (identC "?", identC "?")

getMCat :: Term -> Err MCat
getMCat t = case t of
  Q  m c -> return (m,c)
  QC m c -> return (m,c)
  Sort s -> return $ sortMCat s
  App f _ -> getMCat f
  _ -> error $ "no qualified constant" +++ show t

typeSkeleton :: Type -> Err ([(Int,MCat)],MCat)
typeSkeleton typ = do
  (cont,val) <- typeRawSkeleton typ
  cont' <- mapPairsM getMCat cont
  val'  <- getMCat val
  return (cont',val')

-- construct types and terms

mkProd :: Context -> Type -> Type
mkProd = flip (foldr (uncurry Prod))

mkFunType :: [Type] -> Type -> Type
mkFunType tt t = mkProd ([(wildIdent, ty) | ty <- tt]) t -- nondep prod

mkApp :: Term -> [Term] -> Term
mkApp = foldl App

mkAbs :: [Ident] -> Term -> Term
mkAbs xs t = foldr Abs t xs

mkCTable :: [Ident] -> Term -> Term
mkCTable ids v = foldr ccase v ids where 
  ccase x t = T TRaw [(PV x,t)]

appCons :: Ident -> [Term] -> Term
appCons = mkApp . Con

appc :: String -> [Term] -> Term
appc = appCons . identC

tuple2record :: [Term] -> [Assign]
tuple2record ts = [assign (tupleLabel i) t | (i,t) <- zip [1..] ts]

tuple2recordType :: [Term] -> [Labelling]
tuple2recordType ts = [(tupleLabel i, t) | (i,t) <- zip [1..] ts]

tuple2recordPatt :: [Patt] -> [(Label,Patt)]
tuple2recordPatt ts = [(tupleLabel i, t) | (i,t) <- zip [1..] ts]

tupleLabel :: Int -> Label
tupleLabel i = LIdent $ "p" ++ show i

assign :: Label -> Term -> Assign
assign l t = (l,(Nothing,t))

assignT :: Label -> Type -> Term -> Assign
assignT l a t = (l,(Just a,t))

unzipR :: [Assign] -> ([Label],[Term])
unzipR r = (ls, map snd ts) where (ls,ts) = unzip r

mkDecl :: Term -> Decl
mkDecl typ = (wildIdent, typ)

mkLet :: [LocalDef] -> Term -> Term
mkLet defs t = foldr Let t defs

mkRecTypeN :: Int -> (Int -> Label) -> [Type] -> Type
mkRecTypeN int lab typs = RecType [ (lab i, t) | (i,t) <- zip [int..] typs]

mkRecType :: (Int -> Label) -> [Type] -> Type
mkRecType = mkRecTypeN 0

plusRecType :: Type -> Type -> Err Type
plusRecType t1 t2 = case (t1, t2) of
  (RecType r1, RecType r2) -> case
    filter (`elem` (map fst r1)) (map fst r2) of
      [] -> return (RecType (r1 ++ r2))
      ls -> Bad $ "clashing labels" +++ unwords (map show ls)
  _ -> Bad ("cannot add record types" +++ show t1 +++ "and" +++ show t2) 

plusRecord :: Term -> Term -> Err Term
plusRecord t1 t2 =
 case (t1,t2) of
   (R r1, R r2 ) -> return (R ([(l,v) | -- overshadowing of old fields
                              (l,v) <- r1, not (elem l (map fst r2)) ] ++ r2))
   (_,    FV rs) -> mapM (plusRecord t1) rs >>= return . FV
   (FV rs,_    ) -> mapM (`plusRecord` t2) rs >>= return . FV
   _ -> Bad ("cannot add records" +++ show t1 +++ "and" +++ show t2)

zipAssign :: [Label] -> [Term] -> [Assign]
zipAssign ls ts = [assign l t | (l,t) <- zip ls ts]

-- type constants

typeType :: Type
typeType = Sort "Type"

typePType :: Type
typePType = Sort "PType"

typeStr :: Type
typeStr = Sort "Str"

typeTok :: Type      ---- deprecated
typeTok = Sort "Tok"  

cPredef :: Ident
cPredef = identC "Predef"

cPredefAbs :: Ident
cPredefAbs = identC "PredefAbs"

typeString, typeFloat, typeInt :: Term
typeInts :: Integer -> Term

typeString = constPredefRes "String"
typeInt = constPredefRes "Int"
typeFloat = constPredefRes "Float"
typeInts i = App (constPredefRes "Ints") (EInt i)

isTypeInts :: Term -> Bool
isTypeInts ty = case ty of
  App c _ -> c == constPredefRes "Ints"
  _ -> False

cnPredef = constPredefRes

constPredefRes :: String -> Term
constPredefRes s = Q (IC "Predef") (identC s)

isPredefConstant :: Term -> Bool
isPredefConstant t = case t of
  Q (IC "Predef") _ -> True
  Q (IC "PredefAbs") _ -> True
  _ -> False

defLinType :: Type
defLinType = RecType [(LIdent "s",  typeStr)]

meta0 :: Term
meta0 = Meta 0

ident2label :: Ident -> Label
ident2label c = LIdent (prIdent c)

label2ident :: Label -> Ident
label2ident (LIdent c) = identC c

----label2ident :: Label -> Ident
----label2ident = identC . prLabel

-- to apply a term operation to every term in a judgement, module, grammar

termOpGF :: Monad m => (Term -> m Term) -> GF -> m GF
termOpGF f g = do 
  ms <- mapMapM fm (gfmodules g)
  return g {gfmodules = ms}
 where
   fm = termOpModule f

termOpModule :: Monad m => (Term -> m Term) -> Module -> m Module
termOpModule f = judgementOpModule fj where
  fj = termOpJudgement f
   
judgementOpModule :: Monad m => (Judgement -> m Judgement) -> Module -> m Module
judgementOpModule f m = do 
  mjs <- mapMapM fj (mjments m)
  return m {mjments = mjs}
 where
  fj = either (liftM Left . f) (return . Right)

entryOpModule :: Monad m => 
                 (Ident -> Judgement -> m Judgement) -> Module -> m Module
entryOpModule f m = do 
  mjs <- liftM Map.fromAscList $ mapm $ Map.assocs $ mjments m
  return $ m {mjments = mjs}
 where
  mapm = mapM (\ (i,j) -> liftM ((,) i) (fe i j)) 
  fe i j = either (liftM Left . f i) (return . Right) j
   
termOpJudgement :: Monad m => (Term -> m Term) -> Judgement -> m Judgement
termOpJudgement f j = do 
  jtyp <- f (jtype j)
  jde <- f (jdef j)
  jpri <- f (jprintname j)
  return $ j {
    jtype = jtyp,
    jdef = jde,
    jprintname = jpri
    }

-- | to define compositional term functions
composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp op trm = case composOp (mkMonadic op) trm of
  Ok t -> t
  _ -> error "the operation is safe isn't it ?"
 where
 mkMonadic f = return . f

-- | to define compositional monadic term functions
composOp :: Monad m => (Term -> m Term) -> Term -> m Term
composOp co trm = case trm of
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
   Eqs cc -> 
     do cc' <- mapPairListM (co . snd) cc
        return (Eqs cc')
   V ty vs ->
     do ty' <- co ty
        vs' <- mapM co vs
        return (V ty' vs')
   Let (x,(mt,a)) b -> 
     do a'  <- co a
        mt' <- case mt of
                 Just t -> co t >>= (return . Just) 
                 _ -> return mt
        b'  <- co b
        return (Let (x,(mt',a')) b')
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
   Overload tts -> do
     tts' <- mapM (pairM co) tts
     return $ Overload tts'

   _ -> return trm -- covers K, Vr, Cn, Sort


---- should redefine using composOp
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
  V _ cc     -> concatMap co         cc --- nor from type annot
  Let (x,(mt,a)) b -> maybe [] co mt ++ co a ++ co b
  C s1 s2    -> co s1 ++ co s2 
  Glue s1 s2 -> co s1 ++ co s2 
  Alts (t,aa) -> let (x,y) = unzip aa in co t ++ concatMap co (x ++ y)
  FV ts      -> concatMap co ts
  _ -> [] -- covers K, Vr, Cn, Sort, Ready

--- just aux to composOp?

mapAssignM :: Monad m => (Term -> m c) -> [Assign] -> m [(Label,(Maybe c,c))]
mapAssignM f = mapM (\ (ls,tv) -> liftM ((,) ls) (g tv))
  where g (t,v) = liftM2 (,) (maybe (return Nothing) (liftM Just . f) t) (f v)

changeTableType :: Monad m => (Type -> m Type) -> TInfo -> m TInfo
changeTableType co i = case i of
    TTyped ty -> co ty >>= return . TTyped
    TComp ty  -> co ty >>= return . TComp
    TWild ty  -> co ty >>= return . TWild
    _ -> return i


patt2term :: Patt -> Term
patt2term pt = case pt of
  PV x      -> Vr x
  PW        -> Vr wildIdent             --- not parsable, should not occur
  PC c pp   -> mkApp (Con c) (map patt2term pp)
  PP p c pp -> mkApp (QC p c) (map patt2term pp)
  PR r      -> R [assign l (patt2term p) | (l,p) <- r] 
  PT _ p    -> patt2term p
  PInt i    -> EInt i
  PFloat i  -> EFloat i
  PString s -> K s 

  PAs x p   -> appc "@" [Vr x, patt2term p]            --- an encoding
  PSeq a b  -> appc "+" [(patt2term a), (patt2term b)] --- an encoding
  PAlt a b  -> appc "|" [(patt2term a), (patt2term b)] --- an encoding
  PRep a    -> appc "*" [(patt2term a)]                --- an encoding
  PNeg a    -> appc "-" [(patt2term a)]                --- an encoding


term2patt :: Term -> Err Patt
term2patt trm = case Ok (termForm trm) of
  Ok ([], Vr x, []) -> return (PV x)
  Ok ([], QC p c, aa) -> do
    aa' <- mapM term2patt aa
    return (PP p c aa')
  Ok ([], R r, []) -> do
    let (ll,aa) = unzipR r
    aa' <- mapM term2patt aa
    return (PR (zip ll aa'))
  Ok ([],EInt i,[]) -> return $ PInt i
  Ok ([],EFloat i,[]) -> return $ PFloat i
  Ok ([],K s,   []) -> return $ PString s

--- encodings due to excessive use of term-patt convs. AR 7/1/2005
  Ok ([], Con (IC "@"), [Vr a,b]) -> do
    b' <- term2patt b
    return (PAs a b')
  Ok ([], Con (IC "-"), [a]) -> do
    a' <- term2patt a
    return (PNeg a')
  Ok ([], Con (IC "*"), [a]) -> do
    a' <- term2patt a
    return (PRep a')
  Ok ([], Con (IC "+"), [a,b]) -> do
    a' <- term2patt a
    b' <- term2patt b
    return (PSeq a' b')
  Ok ([], Con (IC "|"), [a,b]) -> do
    a' <- term2patt a
    b' <- term2patt b
    return (PAlt a' b')

  Ok ([], Con c, aa) -> do
    aa' <- mapM term2patt aa
    return (PC c aa')

  _ -> Bad $ "no pattern corresponds to term" +++ show trm

getTableType :: TInfo -> Err Type
getTableType i = case i of
  TTyped ty -> return ty
  TComp ty  -> return ty
  TWild ty  -> return ty
  _ -> Bad "the table is untyped"

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
  _ -> Bad $ "cannot get Str from term" +++ show t



---- given in lib?

mapMapM :: (Monad m, Ord k) => (v -> m v) -> Map.Map k v -> m (Map.Map k v)
mapMapM f = 
  liftM Map.fromAscList . mapM (\ (x,y) -> liftM ((,) x) $ f y) . Map.assocs 

