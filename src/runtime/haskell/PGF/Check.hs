module PGF.Check (checkPGF,checkLin) where

import PGF.CId
import PGF.Data
import PGF.Macros
import GF.Data.ErrM

import qualified Data.Map as Map
import Control.Monad
import Data.Maybe(fromMaybe)
import Debug.Trace

checkPGF :: PGF -> Err (PGF,Bool)
checkPGF pgf = return (pgf,True) {- do
  (cs,bs) <- mapM (checkConcrete pgf) 
               (Map.assocs (concretes pgf)) >>= return . unzip
  return (pgf {concretes = Map.fromAscList cs}, and bs)
-}

-- errors are non-fatal; replace with 'fail' to change this
msg s = trace s (return ())

andMapM :: Monad m => (a -> m Bool) -> [a] -> m Bool
andMapM f xs = mapM f xs >>= return . and

labelBoolErr :: String -> Err (x,Bool) -> Err (x,Bool)
labelBoolErr ms iob = do
  (x,b) <- iob
  if b then return (x,b) else (msg ms >> return (x,b))

{-
checkConcrete :: PGF -> (CId,Concr) -> Err ((CId,Concr),Bool)
checkConcrete pgf (lang,cnc) = 
  labelBoolErr ("happened in language " ++ showCId lang) $ do
    (rs,bs) <- mapM checkl (Map.assocs (lins cnc)) >>= return . unzip
    return ((lang,cnc{lins = Map.fromAscList rs}),and bs)
 where
   checkl = checkLin pgf lang
-}

type PGFSig = (Map.Map CId (Type,Int,Maybe [Equation]),Map.Map CId Term,Map.Map CId Term)

checkLin :: PGFSig -> CId -> (CId,Term) -> Err ((CId,Term),Bool)
checkLin pgf lang (f,t) = 
  labelBoolErr ("happened in function " ++ showCId f) $ do
    (t',b) <- checkTerm (lintype pgf lang f) t --- $ inline pgf lang t
    return ((f,t'),b)

inferTerm :: [CType] -> Term -> Err (Term,CType)
inferTerm args trm = case trm of
  K _ -> returnt str
  C i -> returnt $ ints i
  V i -> do
    testErr (i < length args) ("too large index " ++ show i) 
    returnt $ args !! i
  S ts -> do
    (ts',tys) <- mapM infer ts >>= return . unzip
    let tys' = filter (/=str) tys
    testErr (null tys')
      ("expected Str in " ++ show trm ++ " not " ++ unwords (map show tys')) 
    return (S ts',str)
  R ts -> do
    (ts',tys) <- mapM infer ts >>= return . unzip
    return $ (R ts',tuple tys)
  P t u -> do
    (t',tt) <- infer t
    (u',tu) <- infer u
    case tt of
      R tys -> case tu of
        R vs -> infer $ foldl P t' [P u' (C i) | i <- [0 .. length vs - 1]]
        --- R [v] -> infer $ P t v
        --- R (v:vs) -> infer $ P (head tys) (R vs)
        
        C i -> do
          testErr (i < length tys) 
            ("required more than " ++ show i ++ " fields in " ++ show (R tys)) 
          return (P t' u', tys !! i) -- record: index must be known
        _ -> do
          let typ = head tys
          testErr (all (==typ) tys) ("different types in table " ++ show trm) 
          return (P t' u', typ)      -- table: types must be same
      _ -> Bad $ "projection from " ++ show t ++ " : " ++ show tt
  FV [] -> returnt tm0 ----
  FV (t:ts) -> do
    (t',ty) <- infer t
    (ts',tys) <- mapM infer ts >>= return . unzip
    testErr (all (eqType True ty) tys) ("different types in variants " ++ show trm)
    return (FV (t':ts'),ty)
  W s r -> infer r
  _ -> Bad ("no type inference for " ++ show trm)
 where
   returnt ty = return (trm,ty)
   infer = inferTerm args

checkTerm :: LinType -> Term -> Err (Term,Bool)
checkTerm (args,val) trm = case inferTerm args trm of
  Ok (t,ty) -> if eqType False ty val 
             then return (t,True) 
             else do
    msg ("term: " ++ show trm ++ 
               "\nexpected type: " ++ show val ++
               "\ninferred type: " ++ show ty)
    return (t,False)
  Bad s -> do
    msg s
    return (trm,False)

-- symmetry in (Ints m == Ints n) is all we can use in variants

eqType :: Bool -> CType -> CType -> Bool
eqType symm inf exp = case (inf,exp) of
  (C k, C n)  -> if symm then True else k <= n -- only run-time corr.
  (R rs,R ts) -> length rs == length ts && and [eqType symm r t | (r,t) <- zip rs ts]
  (TM _,  _)  -> True ---- for variants [] ; not safe
  _ -> inf == exp

-- should be in a generic module, but not in the run-time DataGFCC

type CType = Term
type LinType = ([CType],CType)

tuple :: [CType] -> CType
tuple = R

ints :: Int -> CType
ints = C

str :: CType
str = S []

lintype :: PGFSig -> CId -> CId -> LinType
lintype pgf lang fun = case typeSkeleton (lookFun pgf fun) of
  (cs,c) -> (map vlinc cs, linc c) ---- HOAS
 where 
   linc = lookLincat pgf lang
   vlinc (0,c) = linc c
   vlinc (i,c) = case linc c of
     R ts -> R (ts ++ replicate i str)

composOp :: Monad m => (Term -> m Term) -> Term -> m Term
composOp f trm = case trm of
  R  ts -> liftM R $ mapM f ts
  S  ts -> liftM S $ mapM f ts
  FV ts -> liftM FV $ mapM f ts
  P t u -> liftM2 P (f t) (f u)
  W s t -> liftM (W s) $ f t
  _ -> return trm

composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp f = maybe undefined id . composOp (return . f)

-- from GF.Data.Oper

maybeErr :: String -> Maybe a -> Err a
maybeErr s = maybe (Bad s) Ok

testErr :: Bool -> String -> Err ()
testErr cond msg = if cond then return () else Bad msg

errVal :: a -> Err a -> a
errVal a = err (const a) id

errIn :: String -> Err a -> Err a
errIn msg = err (\s -> Bad (s ++ "\nOCCURRED IN\n" ++ msg)) return

err :: (String -> b) -> (a -> b) -> Err a -> b 
err d f e = case e of
  Ok a -> f a
  Bad s -> d s

lookFun    (abs,lin,lincats)   f = (\(a,b,c) -> a) $ fromMaybe (error "No abs") (Map.lookup f abs)
lookLincat (abs,lin,lincats) _ c = fromMaybe (error "No lincat") (Map.lookup c lincats)
lookLin    (abs,lin,lincats) _ f = fromMaybe (error "No lin") (Map.lookup f lin)
