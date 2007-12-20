module GF.GFCC.CheckGFCC (checkGFCC, checkGFCCio, checkGFCCmaybe) where

import GF.GFCC.CId
import GF.GFCC.Macros
import GF.GFCC.DataGFCC
import GF.Data.ErrM

import qualified Data.Map as Map
import Control.Monad
import Debug.Trace

checkGFCCio :: GFCC -> IO GFCC
checkGFCCio gfcc = case checkGFCC gfcc of
  Ok (gc,b) -> do 
    putStrLn $ if b then "OK" else "Corrupted GFCC"
    return gc
  Bad s -> do
    putStrLn s
    error "building GFCC failed"

---- needed in old Custom
checkGFCCmaybe :: GFCC -> Maybe GFCC
checkGFCCmaybe gfcc = case checkGFCC gfcc of
  Ok (gc,b) -> return gc 
  Bad s -> Nothing

checkGFCC :: GFCC -> Err (GFCC,Bool)
checkGFCC gfcc = do
  (cs,bs) <- mapM (checkConcrete gfcc) 
               (Map.assocs (concretes gfcc)) >>= return . unzip
  return (gfcc {concretes = Map.fromAscList cs}, and bs)


-- errors are non-fatal; replace with 'fail' to change this
msg s = trace s (return ())

andMapM :: Monad m => (a -> m Bool) -> [a] -> m Bool
andMapM f xs = mapM f xs >>= return . and

labelBoolErr :: String -> Err (x,Bool) -> Err (x,Bool)
labelBoolErr ms iob = do
  (x,b) <- iob
  if b then return (x,b) else (msg ms >> return (x,b))


checkConcrete :: GFCC -> (CId,Concr) -> Err ((CId,Concr),Bool)
checkConcrete gfcc (lang,cnc) = 
  labelBoolErr ("happened in language " ++ printCId lang) $ do
    (rs,bs) <- mapM checkl (Map.assocs (lins cnc)) >>= return . unzip
    return ((lang,cnc{lins = Map.fromAscList rs}),and bs)
 where
   checkl = checkLin gfcc lang

checkLin :: GFCC -> CId -> (CId,Term) -> Err ((CId,Term),Bool)
checkLin gfcc lang (f,t) = 
  labelBoolErr ("happened in function " ++ printCId f) $ do
    (t',b) <- checkTerm (lintype gfcc lang f) t --- $ inline gfcc lang t
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
  FV [] -> returnt TM ----
  FV (t:ts) -> do
    (t',ty) <- infer t
    (ts',tys) <- mapM infer ts >>= return . unzip
    testErr (all (eqType ty) tys) ("different types in variants " ++ show trm)
    return (FV (t':ts'),ty)
  W s r -> infer r
  _ -> Bad ("no type inference for " ++ show trm)
 where
   returnt ty = return (trm,ty)
   infer = inferTerm args

checkTerm :: LinType -> Term -> Err (Term,Bool)
checkTerm (args,val) trm = case inferTerm args trm of
  Ok (t,ty) -> if eqType ty val 
             then return (t,True) 
             else do
    msg ("term: " ++ show trm ++ 
               "\nexpected type: " ++ show val ++
               "\ninferred type: " ++ show ty)
    return (t,False)
  Bad s -> do
    msg s
    return (trm,False)

eqType :: CType -> CType -> Bool
eqType inf exp = case (inf,exp) of
  (C k, C n)  -> k <= n -- only run-time corr.
  (R rs,R ts) -> length rs == length ts && and [eqType r t | (r,t) <- zip rs ts]
  (TM,  _)    -> True ---- for variants [] ; not safe
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

lintype :: GFCC -> CId -> CId -> LinType
lintype gfcc lang fun = case catSkeleton (lookType gfcc fun) of
  (cs,c) -> (map linc cs, linc c) ---- HOAS
 where 
   linc = lookLincat gfcc lang

inline :: GFCC -> CId -> Term -> Term
inline gfcc lang t = case t of
  F c -> inl $ look c
  _ -> composSafeOp inl t
 where
  inl  = inline gfcc lang
  look = lookLin gfcc lang

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
