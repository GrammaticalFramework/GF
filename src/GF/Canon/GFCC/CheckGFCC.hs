module GF.Canon.GFCC.CheckGFCC where

import GF.Canon.GFCC.DataGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Canon.GFCC.PrintGFCC
import GF.Canon.GFCC.ErrM

import qualified Data.Map as Map
import Control.Monad

andMapM :: Monad m => (a -> m Bool) -> [a] -> m Bool
andMapM f xs = mapM f xs >>= return . and

labelBoolIO :: String -> IO Bool -> IO Bool
labelBoolIO msg iob = do
  b <- iob
  if b then return b else (putStrLn msg >> return b)

checkGFCC :: GFCC -> IO Bool
checkGFCC gfcc = andMapM (checkConcrete gfcc) $ Map.assocs $ concretes gfcc

checkConcrete :: GFCC -> (CId,Map.Map CId Term) -> IO Bool
checkConcrete gfcc (lang,cnc) = 
  labelBoolIO ("happened in language " ++ printTree lang) $ 
    andMapM (checkLin gfcc lang) $ linRules cnc

checkLin :: GFCC -> CId -> (CId,Term) -> IO Bool
checkLin gfcc lang (f,t) = 
  labelBoolIO ("happened in function " ++ printTree f) $ 
    checkTerm (lintype gfcc lang f) $ inline gfcc lang t

inferTerm :: [Tpe] -> Term -> Err Tpe
inferTerm args trm = case trm of
  K _ -> return str
  C i -> return $ ints i
  V i -> do
    testErr (i < length args) ("too large index " ++ show i) 
    return $ args !! i
  S ts -> do
    tys <- mapM infer ts
    let tys' = filter (/=str) tys
    testErr (null tys')
      ("expected Str in " ++ prt trm ++ " not " ++ unwords (map prt tys')) 
    return str 
  R ts -> do
    tys <- mapM infer ts
    return $ tuple tys
  P t u -> do
    tt <- infer t
    tu <- infer u
    case tt of
     R tys -> case tu of
      R [v] -> infer $ P t v
      R (v:vs) -> infer $ P (head tys) (R vs) -----
        
      C i -> do
        testErr (i < length tys) 
          ("required more than " ++ show i ++ " fields in " ++ prt (R tys)) 
        (return $ tys !! i)   -- record: index must be known
      _ -> do
        let typ = head tys
        testErr (all (==typ) tys) ("different types in table " ++ prt trm) 
        return typ            -- table: must be same
     _ -> Bad $ "projection from " ++ prt t ++ " : " ++ prt tt
  FV [] -> return str ----
  FV (t:ts) -> do
    ty <- infer t
    tys <- mapM infer ts
    testErr (all (==ty) tys) ("different types in variants " ++ prt trm)
    return ty
  W s r -> infer r
  _ -> Bad ("no type inference for " ++ prt trm)
 where
   infer = inferTerm args
   prt = printTree

checkTerm :: LinType -> Term -> IO Bool
checkTerm (args,val) trm = case inferTerm args trm of
  Ok ty -> if eqType ty val 
             then return True 
             else do
    putStrLn $ "term: " ++ printTree trm ++ 
               "\nexpected type: " ++ printTree val ++
               "\ninferred type: " ++ printTree ty
    return False
  Bad s -> do
    putStrLn s
    return False

eqType :: Tpe -> Tpe -> Bool
eqType inf exp = case (inf,exp) of
  (C k, C n)  -> k <= n -- only run-time corr.
  (R rs,R ts) -> length rs == length ts && and [eqType r t | (r,t) <- zip rs ts]
  _ -> inf == exp

-- should be in a generic module, but not in the run-time DataGFCC

type Tpe = Term
type LinType = ([Tpe],Tpe)

tuple :: [Tpe] -> Tpe
tuple = R

ints :: Int -> Tpe
ints = C

str :: Tpe
str = S []

lintype :: GFCC -> CId -> CId -> LinType
lintype gfcc lang fun = case lookType gfcc fun of
  Typ cs c -> (map linc cs, linc c)
 where 
   linc = lookLincat gfcc lang

lookLincat :: GFCC -> CId -> CId -> Term
lookLincat gfcc lang (CId cat) = lookLin gfcc lang (CId ("__" ++ cat))

linRules :: Map.Map CId Term -> [(CId,Term)]
linRules cnc = [(f,t) | (f@(CId (c:_)),t) <- Map.assocs cnc, c /= '_']  ----

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
