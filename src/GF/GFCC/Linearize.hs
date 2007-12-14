module GF.GFCC.Linearize where

import GF.GFCC.Macros
import GF.GFCC.DataGFCC
import GF.GFCC.CId
import Data.Map
import Data.List

import Debug.Trace

-- linearization and computation of concrete GFCC Terms

linearize :: GFCC -> CId -> Exp -> String
linearize mcfg lang = realize . linExp mcfg lang

realize :: Term -> String
realize trm = case trm of
  R ts     -> realize (ts !! 0)
  S ss     -> unwords $ lmap realize ss
  K t -> case t of
    KS s -> s
    KP s _ -> unwords s ---- prefix choice TODO
  W s t    -> s ++ realize t
  FV ts    -> realize (ts !! 0)  ---- other variants TODO
  RP _ r   -> realize r ---- DEPREC
  TM       -> "?"
  _ -> "ERROR " ++ show trm ---- debug

linExp :: GFCC -> CId -> Exp -> Term
linExp mcfg lang tree@(DTr _ at trees) =  ---- bindings TODO
  case at of
    AC fun -> comp (lmap lin trees) $ look fun
    AS s   -> R [kks (show s)] -- quoted
    AI i   -> R [kks (show i)]
    AF d   -> R [kks (show d)]
    AM _   -> TM
 where
   lin  = linExp mcfg lang
   comp = compute mcfg lang
   look = lookLin mcfg lang

compute :: GFCC -> CId -> [Term] -> Term -> Term
compute mcfg lang args = comp where
  comp trm = case trm of
    P r p  -> proj (comp r) (comp p) 
    RP i t -> RP (comp i) (comp t)  ---- DEPREC
    W s t  -> W s (comp t)
    R ts   -> R $ lmap comp ts
    V i    -> idx args i          -- already computed
    F c    -> comp $ look c       -- not computed (if contains argvar)
    FV ts  -> FV $ lmap comp ts
    S ts   -> S $ lfilter (/= S []) $ lmap comp ts
    _ -> trm

  look = lookOper mcfg lang

  idx xs i = if i > length xs - 1 
    then trace 
         ("too large " ++ show i ++ " for\n" ++ unlines (lmap show xs) ++ "\n") TM 
    else xs !! i 

  proj r p = case (r,p) of
    (_,     FV ts) -> FV $ lmap (proj r) ts
    (FV ts, _    ) -> FV $ lmap (\t -> proj t p) ts
    (W s t, _)     -> kks (s ++ getString (proj t p))
    _              -> comp $ getField r (getIndex p)

  getString t = case t of
    K (KS s) -> s
    _ -> error ("ERROR in grammar compiler: string from "++ show t) "ERR"

  getIndex t =  case t of
    C i    -> i
    RP p _ -> getIndex p ---- DEPREC
    TM     -> 0  -- default value for parameter
    _ -> trace ("ERROR in grammar compiler: index from " ++ show t) 666

  getField t i = case t of
    R rs   -> idx rs i
    RP _ r -> getField r i ---- DEPREC
    TM     -> TM
    _ -> error ("ERROR in grammar compiler: field from " ++ show t) t

