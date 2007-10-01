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

inferTerm :: [Tpe] -> Term -> Maybe Tpe
inferTerm args trm = case trm of
  K _ -> return str
  C i -> return $ ints i
  V i -> if i < length args 
           then (return $ args !! i) 
           else error ("index " ++ show i)
  S ts -> do
    tys <- mapM infer ts
    if all (==str) tys 
      then return str 
      else error ("only strings expected in: " ++ printTree trm
                  ++ " instead of " ++ unwords (map printTree tys)
                 )
  R ts -> do
    tys <- mapM infer ts
    return $ tuple tys
  P t u -> do
    R tys <- infer t
    case u of
      R [v] -> infer $ P t v
      R (v:vs) -> infer $ P (head tys) (R vs) -----
        
      C i -> if (i < length tys) 
             then (return $ tys !! i) -- record: index must be known
             else error ("too few fields in " ++ printTree (R tys))
      _ -> if all (==head tys) tys    -- table: must be same
             then return (head tys) 
             else error ("projection " ++ printTree trm)
  FV ts -> return $ head ts ---- empty variants; check equality 
  W s r -> infer r
  _ -> error ("no type inference for " ++ printTree trm)
 where
   infer = inferTerm args

checkTerm :: LinType -> Term -> IO Bool
checkTerm (args,val) trm = case inferTerm args trm of
  Just ty -> if eqType ty val then return True else do
    putStrLn $ "term: " ++ printTree trm ++ 
               "\nexpected type: " ++ printTree val ++
               "\ninferred type: " ++ printTree ty
    return False
  _ -> do
    putStrLn $ "cannot infer type of " ++ printTree trm
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
  R  ts -> liftM R $ mapM comp ts
  S  ts -> liftM S $ mapM comp ts
  FV ts -> liftM FV $ mapM comp ts
  P t u -> liftM2 P (comp t) (comp u)
  W s t -> liftM (W s) $ comp t
  _ -> return trm
 where
   comp = composOp f

composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp f = maybe undefined id . composOp (return . f)
