module Macros where

import Operations
import Str
import Grammar
import Ident
import PrGrammar

import Monad (liftM)
import Char (isDigit)

-- AR 7/12/1999 - 9/5/2000 -- 4/6/2001

-- operations on terms and types not involving lookup in or reference to grammars

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
    prtBad "no normal form of type" t

qq :: QIdent -> Term
qq (m,c) = Q m c

typeForm = qTypeForm ---- no need to dist any more

cPredef :: Ident
cPredef = identC "Predef"

cnPredef :: String -> Term
cnPredef f = Q cPredef (identC f)

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

sortMCat :: String -> MCat
sortMCat s = (zIdent "_", zIdent s)

--- hack for Editing.actCat in empty state
errorCat :: MCat
errorCat = (zIdent "?", zIdent "?")

getMCat :: Term -> Err MCat
getMCat t = case t of
  Q  m c -> return (m,c)
  QC m c -> return (m,c)
  Sort s -> return $ sortMCat s
  App f _ -> getMCat f
  _ -> prtBad "no qualified constant" t

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


contextOfType :: Type -> Err Context
contextOfType typ = case typ of
  Prod x a b -> liftM ((x,a):) $ contextOfType b
  _ -> return [] 

unComputed :: Term -> Term
unComputed t = case t of
  Computed v -> unComputed v
  _ -> t --- composSafeOp unComputed t


{- 
--- defined (better) in compile/PrOld

stripTerm :: Term -> Term
stripTerm t = case t of
  Q _ c  -> Cn c
  QC _ c -> Cn c
  T ti psts -> T ti [(stripPatt p, stripTerm v) | (p,v) <- psts]
  _ -> composSafeOp stripTerm t
 where
   stripPatt p = errVal p $ term2patt $ stripTerm $ patt2term p
-}

computed = Computed

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

appc :: String -> [Term] -> Term
appc = appCons . zIdent

appqc :: String -> String -> [Term] -> Term
appqc q c = mkApp (Q (zIdent q) (zIdent c))

mkLet :: [LocalDef] -> Term -> Term
mkLet defs t = foldr Let t defs

mkLetUntyped :: Context -> Term -> Term
mkLetUntyped defs = mkLet [(x,(Nothing,t)) | (x,t) <- defs]

isVariable (Vr _ ) = True
isVariable _ = False

eqIdent :: Ident -> Ident -> Bool
eqIdent = (==)

zIdent :: String -> Ident
zIdent s = identC s

uType :: Type
uType = Cn (zIdent "UndefinedType")

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

ident2label :: Ident -> Label
ident2label c = LIdent (prIdent c)

label2ident :: Label -> Ident
label2ident = identC . prLabel

prLabel :: Label -> String
prLabel = prt

mapAssignM :: Monad m => (Term -> m c) -> [Assign] -> m [(Label,(Maybe c,c))]
mapAssignM f ltvs = do
  let (ls,tvs) = unzip ltvs
      (ts, vs) = unzip  tvs  
  ts' <- mapM (\t -> case t of
            Nothing -> return Nothing
            Just y  -> f y >>= return . Just) ts
  vs' <- mapM f vs
  return (zip ls (zip ts' vs'))

mkRecordN :: Int -> (Int -> Label) -> [Term] -> Term
mkRecordN int lab typs = R [ assign (lab i) t | (i,t) <- zip [int..] typs]

mkRecord :: (Int -> Label) -> [Term] -> Term
mkRecord = mkRecordN 0

mkRecTypeN :: Int -> (Int -> Label) -> [Type] -> Type
mkRecTypeN int lab typs = RecType [ (lab i, t) | (i,t) <- zip [int..] typs]

mkRecType :: (Int -> Label) -> [Type] -> Type
mkRecType = mkRecTypeN 0

typeType  = srt "Type"
typePType = srt "PType"
typeStr   = srt "Str"
typeTok   = srt "Tok"
typeStrs  = srt "Strs"

typeString = constPredefRes "String"
typeInt = constPredefRes "Int"
typeInts i = App (constPredefRes "Ints") (EInt i)

isTypeInts ty = case ty of
  App c _ -> c == constPredefRes "Ints"
  _ -> False

constPredefRes s = Q (IC "Predef") (zIdent s)

isPredefConstant t = case t of
  Q (IC "Predef") _ -> True
  Q (IC "PredefAbs") _ -> True
  _ -> False

mkSelects :: Term -> [Term] -> Term
mkSelects t tt = foldl S t tt

mkTable :: [Term] -> Term -> Term
mkTable tt t = foldr Table t tt

mkCTable :: [Ident] -> Term -> Term
mkCTable ids v = foldr ccase v ids where 
  ccase x t = T TRaw [(PV x,t)]

mkDecl :: Term -> Decl
mkDecl typ = (wildIdent, typ)

eqStrIdent :: Ident -> Ident -> Bool
eqStrIdent = (==)

tupleLabel i = LIdent $ "p" ++ show i
linLabel i = LIdent $ "s" ++ show i

theLinLabel = LIdent "s"

tuple2record :: [Term] -> [Assign]
tuple2record ts = [assign (tupleLabel i) t | (i,t) <- zip [1..] ts]

tuple2recordType :: [Term] -> [Labelling]
tuple2recordType ts = [(tupleLabel i, t) | (i,t) <- zip [1..] ts]

tuple2recordPatt :: [Patt] -> [(Label,Patt)]
tuple2recordPatt ts = [(tupleLabel i, t) | (i,t) <- zip [1..] ts]

mkCases :: Ident -> Term -> Term
mkCases x t = T TRaw [(PV x, t)]

mkWildCases :: Term -> Term
mkWildCases = mkCases wildIdent

mkFunType :: [Type] -> Type -> Type
mkFunType tt t = mkProd ([(wildIdent, ty) | ty <- tt], t, []) -- nondep prod

plusRecType :: Type -> Type -> Err Type
plusRecType t1 t2 = case (unComputed t1, unComputed t2) of
  (RecType r1, RecType r2) -> return (RecType (r1 ++ r2))
  _ -> Bad ("cannot add record types" +++ prt t1 +++ "and" +++ prt t2) 

plusRecord :: Term -> Term -> Err Term
plusRecord t1 t2 =
 case (t1,t2) of
   (R r1, R r2 ) -> return (R (r1 ++ r2))
   (_,    FV rs) -> mapM (plusRecord t1) rs >>= return . FV
   (FV rs,_    ) -> mapM (`plusRecord` t2) rs >>= return . FV
   _ -> Bad ("cannot add records" +++ prt t1 +++ "and" +++ prt t2)

-- default linearization type

defLinType = RecType [(LIdent "s",  typeStr)]

-- refreshing variables

varX :: Int -> Ident
varX i = identV (i,"x")

mkFreshVar :: [Ident] -> Ident
mkFreshVar olds = varX (maxVarIndex olds + 1) 

-- trying to preserve a given symbol
mkFreshVarX :: [Ident] -> Ident -> Ident
mkFreshVarX olds x = if (elem x olds) then (varX (maxVarIndex olds + 1)) else x

maxVarIndex :: [Ident] -> Int
maxVarIndex = maximum . ((-1):) . map varIndex

mkFreshVars :: Int -> [Ident] -> [Ident] 
mkFreshVars n olds = [varX (maxVarIndex olds + i) | i <- [1..n]]

--- quick hack for refining with var in editor
freshAsTerm :: String -> Term
freshAsTerm s = Vr (varX (readIntArg s))

-- create a terminal for concrete syntax
string2term :: String -> Term
string2term = ccK

ccK = K
ccC = C

-- create a terminal from identifier
ident2terminal :: Ident -> Term
ident2terminal = ccK . prIdent

-- create a constant
string2CnTrm :: String -> Term
string2CnTrm = Cn . zIdent

symbolOfIdent :: Ident -> String
symbolOfIdent = prIdent

symid = symbolOfIdent

vr = Vr
cn = Cn
srt = Sort
meta = Meta
cnIC = cn . IC

justIdentOf (Vr x) = Just x
justIdentOf (Cn x) = Just x
justIdentOf _ = Nothing

isMeta (Meta _) = True
isMeta _ = False
mkMeta = Meta . MetaSymb

nextMeta :: MetaSymb -> MetaSymb
nextMeta = int2meta . succ . metaSymbInt

int2meta = MetaSymb

metaSymbInt :: MetaSymb -> Int
metaSymbInt (MetaSymb k) = k

freshMeta :: [MetaSymb] -> MetaSymb
freshMeta ms = MetaSymb (minimum [n | n <- [0..length ms], 
                                      notElem n (map metaSymbInt ms)])

mkFreshMetasInTrm :: [MetaSymb] -> Trm -> Trm
mkFreshMetasInTrm metas = fst . rms minMeta where
  rms meta trm = case trm of
    Meta m  -> (Meta (MetaSymb meta), meta + 1)
    App f a -> let (f',msf) = rms meta f 
                   (a',msa) = rms msf a
               in (App f' a', msa)
    Prod x a b -> 
               let (a',msa) = rms meta a 
                   (b',msb) = rms msa b
               in (Prod x a' b', msb)
    Abs x b -> let (b',msb) = rms meta b in (Abs x b', msb)
    _       -> (trm,meta)
  minMeta = if null metas then 0 else (maximum (map metaSymbInt metas) + 1)

-- decides that a term has no metavariables
isCompleteTerm :: Term -> Bool
isCompleteTerm t = case t of
  Meta _  -> False
  Abs _ b -> isCompleteTerm b
  App f a -> isCompleteTerm f && isCompleteTerm a
  _       -> True 

linTypeStr :: Type
linTypeStr = mkRecType linLabel [typeStr] -- default lintype {s :: Str}

linAsStr :: String -> Term
linAsStr s = mkRecord linLabel [K s] -- default linearization {s = s}

linDefStr :: Term
linDefStr = Abs s (R [assign (linLabel 0) (Vr s)]) where s = zIdent "s"

term2patt :: Term -> Err Patt
term2patt trm = case termForm trm of
  Ok ([], Vr x, []) -> return (PV x)
  Ok ([], Con c, aa) -> do
    aa' <- mapM term2patt aa
    return (PC c aa')
  Ok ([], QC p c, aa) -> do
    aa' <- mapM term2patt aa
    return (PP p c aa')
  Ok ([], R r, []) -> do
    let (ll,aa) = unzipR r
    aa' <- mapM term2patt aa
    return (PR (zip ll aa'))
  Ok ([],EInt i,[]) -> return $ PInt i
  Ok ([],K s,   []) -> return $ PString s
  _ -> prtBad "no pattern corresponds to term" trm

patt2term :: Patt -> Term
patt2term pt = case pt of
  PV x      -> Vr x
  PW        -> Vr wildIdent                      --- not parsable, should not occur
  PC c pp   -> mkApp (Con c) (map patt2term pp)
  PP p c pp -> mkApp (QC p c) (map patt2term pp)
  PR r      -> R [assign l (patt2term p) | (l,p) <- r] 
  PT _ p    ->  patt2term p
  PInt i    -> EInt i
  PString s -> K s 

-- to gather s-fields; assumes term in normal form, preserves label
allLinFields :: Term -> Err [[(Label,Term)]]
allLinFields trm = case unComputed trm of
----  R rs  -> return [[(l,t) | (l,(Just ty,t)) <- rs, isStrType ty]] -- good
  R rs  -> return [[(l,t) | (l,(_,t)) <- rs, isLinLabel l]] ---- bad
  FV ts -> do
    lts <- mapM allLinFields ts
    return $ concat lts
  _ -> prtBad "fields can only be sought in a record not in" trm

---- deprecated
isLinLabel l = case l of
     LIdent ('s':cs) | all isDigit cs -> True
     _ -> False

-- to gather ultimate cases in a table; preserves pattern list
allCaseValues :: Term -> [([Patt],Term)]
allCaseValues trm = case unComputed trm of
  T _ cs -> [(p:ps, t) | (p,t0) <- cs, (ps,t) <- allCaseValues t0]
  _      -> [([],trm)]

-- to gather all linearizations; assumes normal form, preserves label and args
allLinValues :: Term -> Err [[(Label,[([Patt],Term)])]]
allLinValues trm = do
  lts <- allLinFields trm
  mapM (mapPairsM (return . allCaseValues)) lts

-- to mark str parts of fields in a record f by a function f
markLinFields :: (Term -> Term) -> Term -> Term
markLinFields f t = case t of
    R r -> R $ map mkField r
    _ -> t
 where
  mkField (l,(_,t)) = if (isLinLabel l) then (assign l (mkTbl t)) else (assign l t)
  mkTbl t = case t of
    T i cs -> T i [(p, mkTbl v) | (p,v) <- cs]
    _ -> f t

-- to get a string from a term that represents a sequence of terminals
strsFromTerm :: Term -> Err [Str]
strsFromTerm t = case unComputed t of
  K s   -> return [str s]
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
  Ready ss -> return [ss]
  Alias _ _ d -> strsFromTerm d --- should not be needed...
  _ -> prtBad "cannot get Str from term" t

-- to print an Str-denoting term as a string; if the term is of wrong type, the error msg
stringFromTerm :: Term -> String
stringFromTerm = err id (ifNull "" (sstr . head)) . strsFromTerm


-- to define compositional term functions

composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp op trm = case composOp (mkMonadic op) trm of
  Ok t -> t
  _ -> error "the operation is safe isn't it ?"
 where
 mkMonadic f = return . f

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
   ExtR a c -> 
     do a' <- co a
        c' <- co c
        return (ExtR a' c')

   T i cc -> 
     do cc' <- mapPairListM (co . snd) cc
        i'  <- changeTableType co i
        return (T i' cc')
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
   _ -> return trm -- covers K, Vr, Cn, Sort

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
  Let (x,(mt,a)) b -> maybe [] co mt ++ co a ++ co b
  C s1 s2    -> co s1 ++ co s2 
  Glue s1 s2 -> co s1 ++ co s2 
  Alts (t,aa) -> let (x,y) = unzip aa in co t ++ concatMap co (x ++ y)
  FV ts      -> concatMap co ts
  Strs tt    -> concatMap co tt
  _ -> [] -- covers K, Vr, Cn, Sort, Ready

-- to find the word items in a term

wordsInTerm :: Term -> [String]
wordsInTerm trm = filter (not . null) $ case trm of
   K s     -> [s]
   S c _   -> wo c
   Alts (t,aa) -> wo t ++ concatMap (wo . fst) aa
   Ready s -> allItems s
   _       -> collectOp wo trm
 where wo = wordsInTerm

noExist = FV []

defaultLinType :: Type
defaultLinType = mkRecType linLabel [typeStr]

metaTerms :: [Term]
metaTerms = map (Meta . MetaSymb) [0..]

-- from GF1, 20/9/2003

isInOneType :: Type -> Bool
isInOneType t = case t of
  Prod _ a b -> a == b
  _ -> False

