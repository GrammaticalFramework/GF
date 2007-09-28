module GF.Canon.GFCC.CheckGFCC where

import GF.Canon.GFCC.DataGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Canon.GFCC.PrintGFCC

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
  labelBoolIO (printTree lang) $ andMapM (checkLin gfcc lang) $ linRules cnc

checkLin :: GFCC -> CId -> (CId,Term) -> IO Bool
checkLin gfcc lang (f,t) = 
  labelBoolIO (printTree f) $ checkTerm (lintype gfcc lang f) $ inline gfcc lang t

checkTerm :: LinType -> Term -> IO Bool
checkTerm (args,val) trm = case (val,trm) of
  (R tys, R trs) -> do
    let (ntys,ntrs) = (length tys,length trs)
    b <- checkCond 
      ("number of fields in " ++ prtrm ++ " does not match " ++ prval) (ntys == ntrs)
    bs <- andMapM (uncurry check) (zip tys trs)
    return $ b && bs
  (R _, W _ r) -> check val r
  _ -> return True
 where
   checkCond msg cond = if cond then return True else (putStrLn msg >> return False)
   check ty tr = checkTerm (args,ty) tr
   prtrm = printTree trm
   prval = printTree val

-- should be in a generic module, but not in the run-time DataGFCC

type LinType = ([Term],Term)

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
