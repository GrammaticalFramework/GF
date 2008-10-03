module PGF.Linearize (linearizes,realize,realizes,linTree) where

import PGF.CId
import PGF.Data
import PGF.Macros

import Control.Monad
import qualified Data.Map as Map
import Data.List

import Debug.Trace

-- linearization and computation of concrete PGF Terms

linearizes :: PGF -> CId -> Tree -> [String]
linearizes pgf lang = realizes . linTree pgf lang

realize :: Term -> String
realize = concat . take 1 . realizes

realizes :: Term -> [String]
realizes = map (unwords . untokn) . realizest

realizest :: Term -> [[Tokn]]
realizest trm = case trm of
  R ts     -> realizest (ts !! 0)
  S ss     -> map concat $ combinations $ map realizest ss
  K t      -> [[t]]
  W s t    -> [[KS (s ++ r)] | [KS r] <- realizest t]
  FV ts    -> concatMap realizest ts
  TM s     -> [[KS s]]
  _ -> [[KS $ "REALIZE_ERROR " ++ show trm]] ---- debug

untokn :: [Tokn] -> [String]
untokn ts = case ts of
  KP d _  : [] -> d
  KP d vs : ws -> let ss@(s:_) = untokn ws in sel d vs s ++ ss
  KS s    : ws -> s : untokn ws
  []           -> []
 where
   sel d vs w = case [v | Alt v cs <- vs, any (\c -> isPrefixOf c w) cs] of
     v:_ -> v
     _   -> d

-- Lifts all variants to the top level (except those in macros).
liftVariants :: Term -> [Term]
liftVariants = f
  where
    f (R ts)    = liftM R $ mapM f ts
    f (P t1 t2) = liftM2 P (f t1) (f t2)
    f (S ts)    = liftM S $ mapM f ts
    f (FV ts)   = ts >>= f
    f (W s t)   = liftM (W s) $ f t
    f t         = return t

linTree :: PGF -> CId -> Tree -> Term
linTree pgf lang = lin
  where
    lin (Abs xs  e )   = case lin e of
                             R ts -> R $ ts     ++ (Data.List.map (kks . prCId) xs)
                             TM s -> R $ (TM s)  : (Data.List.map (kks . prCId) xs)
    lin (Fun fun es)   = let argVariants = mapM (liftVariants . lin) es
                          in variants [compute pgf lang args $ look fun | args <- argVariants]
    lin (Lit (LStr s)) = R [kks (show s)] -- quoted
    lin (Lit (LInt i)) = R [kks (show i)] 
    lin (Lit (LFlt d)) = R [kks (show d)]
    lin (Var x)        = TM (prCId x)
    lin (Meta i)       = TM (show i)
 
    look = lookLin pgf lang

variants :: [Term] -> Term
variants ts = case ts of
  [t] -> t
  _   -> FV ts

unvariants :: Term -> [Term]
unvariants t = case t of
  FV ts -> ts
  _     -> [t]

compute :: PGF -> CId -> [Term] -> Term -> Term
compute pgf lang args = comp where
  comp trm = case trm of
    P r p  -> proj (comp r) (comp p) 
    W s t  -> W s (comp t)
    R ts   -> R $ map comp ts
    V i    -> idx args i          -- already computed
    F c    -> comp $ look c       -- not computed (if contains argvar)
    FV ts  -> FV $ map comp ts
    S ts   -> S $ filter (/= S []) $ map comp ts
    _ -> trm

  look = lookOper pgf lang

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

