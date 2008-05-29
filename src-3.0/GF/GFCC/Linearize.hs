module GF.GFCC.Linearize where

import GF.GFCC.Macros
import GF.GFCC.DataGFCC
import GF.GFCC.CId
import qualified Data.Map as Map
import Data.List

import Debug.Trace

-- linearization and computation of concrete GFCC Terms

linearize :: GFCC -> CId -> Exp -> String
linearize mcfg lang = realize . linExp mcfg lang

realize :: Term -> String
realize trm = case trm of
  R ts     -> realize (ts !! 0)
  S ss     -> unwords $ map realize ss
  K t -> case t of
    KS s -> s
    KP s _ -> unwords s ---- prefix choice TODO
  W s t    -> s ++ realize t
  FV ts    -> realize (ts !! 0)  ---- other variants TODO
  TM s     -> s
  _ -> "ERROR " ++ show trm ---- debug

linExp :: GFCC -> CId -> Exp -> Term
linExp mcfg lang tree@(DTr xs at trees) =
  addB $ case at of
    AC fun -> comp (map lin trees) $ look fun
    AS s   -> R [kks (show s)] -- quoted
    AI i   -> R [kks (show i)] 
                --- [C lst, kks (show i), C size] where 
                --- lst = mod (fromInteger i) 10 ; size = if i < 10 then 0 else 1
    AF d   -> R [kks (show d)]
    AV x   -> TM (prCId x)
    AM i   -> TM (show i)
 where
   lin  = linExp mcfg lang
   comp = compute mcfg lang
   look = lookLin mcfg lang
   addB t 
     | Data.List.null xs = t
     | otherwise = case t of
         R ts -> R $ ts ++ (Data.List.map (kks . prCId) xs)
         TM s -> R $ t  :  (Data.List.map (kks . prCId) xs)

compute :: GFCC -> CId -> [Term] -> Term -> Term
compute mcfg lang args = comp where
  comp trm = case trm of
    P r p  -> proj (comp r) (comp p) 
    W s t  -> W s (comp t)
    R ts   -> R $ map comp ts
    V i    -> idx args i          -- already computed
    F c    -> comp $ look c       -- not computed (if contains argvar)
    FV ts  -> FV $ map comp ts
    S ts   -> S $ filter (/= S []) $ map comp ts
    _ -> trm

  look = lookOper mcfg lang

  idx xs i = if i > length xs - 1 
    then trace 
         ("too large " ++ show i ++ " for\n" ++ unlines (map show xs) ++ "\n") tm0 
    else xs !! i 

  proj r p = case (r,p) of
    (_,     FV ts) -> FV $ map (proj r) ts
    (FV ts, _    ) -> FV $ map (\t -> proj t p) ts
    (W s t, _)     -> kks (s ++ getString (proj t p))
    _              -> comp $ getField r (getIndex p)

  getString t = case t of
    K (KS s) -> s
    _ -> error ("ERROR in grammar compiler: string from "++ show t) "ERR"

  getIndex t =  case t of
    C i    -> i
    TM _   -> 0  -- default value for parameter
    _ -> trace ("ERROR in grammar compiler: index from " ++ show t) 666

  getField t i = case t of
    R rs   -> idx rs i
    TM s   -> TM s
    _ -> error ("ERROR in grammar compiler: field from " ++ show t) t

