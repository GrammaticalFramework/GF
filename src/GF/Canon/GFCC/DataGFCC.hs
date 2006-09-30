module GF.Canon.GFCC.DataGFCC where

import GF.Canon.GFCC.AbsGFCC
import Data.Map
import Data.List
import Debug.Trace ----

data GFCC = GFCC {
  absname   :: CId ,
  cncnames  :: [CId] ,
  abstract  :: Abstr ,
  concretes :: Map CId Concr
  }

-- redundant double representation for fast lookup
data Abstr = Abstr {
  funs :: Map CId Type, -- find the type of a fun
  cats :: Map CId [CId] -- find the funs giving a cat
  }

statGFCC :: GFCC -> String
statGFCC gfcc = unlines [
  "Abstract\t" ++ pr (absname gfcc), 
  "Concretes\t" ++ unwords (Prelude.map pr (cncnames gfcc)), 
  "Categories\t" ++ unwords (Prelude.map pr (keys (cats (abstract gfcc)))) 
  ]
 where pr (CId s) = s

type Concr = Map CId Term

lookMap :: (Show i, Ord i) => a -> i -> Map i a -> a 
lookMap d c m = maybe d id $ Data.Map.lookup c m

lookLin :: GFCC -> CId -> CId -> Term
lookLin mcfg lang fun = lookMap term0 fun $ lookMap undefined lang $ concretes mcfg

linearize :: GFCC -> CId -> Exp -> String
linearize mcfg lang = realize . linExp mcfg lang

realize :: Term -> String
realize trm = case trm of
  R (t:_)  -> realize t
  S ss     -> unwords $ Prelude.map realize ss
  K (KS s) -> s
  K (KP s _) -> unwords s ---- prefix choice TODO
  W s t    -> s ++ realize t
  FV (t:_) -> realize t

  RP _ r -> realize r
  _ -> "ERROR " ++ show trm ---- debug

linExp :: GFCC -> CId -> Exp -> Term
linExp mcfg lang tree@(Tr at trees) = 
  case at of
    AC fun -> comp (Prelude.map lin trees) $ look fun
    AS s   -> R [kks (show s)] -- quoted
    AI i   -> R [kks (show i)]
    AF d   -> R [kks (show d)]
    AM     -> R [kks "?"]
 where
   lin  = linExp mcfg lang
   comp = compute mcfg lang
   look = lookLin mcfg lang

exp0 :: Exp
exp0 = Tr (AS "NO_PARSE") []

term0 :: Term
term0 = kks "UNKNOWN_ID"

kks :: String -> Term
kks = K . KS

compute :: GFCC -> CId -> [Term] -> Term -> Term
compute mcfg lang args = comp where
  comp trm = case trm of
    P r (FV ts) -> FV $ Prelude.map (comp . P r) ts

    P r p -> case (comp r, comp p) of 

    -- for the suffix optimization
      (W s t, R (C i : _)) -> comp $ P (W s t) (C i)
      (W s t, C i) -> case comp t of
        R ss -> case comp $ idx ss (fromInteger i) of
          K (KS u) -> kks (s ++ u)      -- the only case where W occurs

      (r', p') -> comp $ idx (getFields r') (getIndex (P r' p') p')

    RP i t -> RP (comp i) (comp t)
    W s t -> W s (comp t)
    R ts  -> R $ Prelude.map comp ts
    V i   -> idx args (fromInteger i)  -- already computed
    S ts  -> S $ Prelude.filter (/= S []) $ Prelude.map comp ts
    F c   -> comp $ look c  -- global const: not comp'd (if contains argvar)
    FV ts -> FV $ Prelude.map comp ts
    _ -> trm
  look = lookLin mcfg lang
  idx xs i = 
      if length xs <= i  ---- debug
      then K (KS ("ERROR" ++ show xs ++ " !! " ++ show i)) else
      xs !! i 

  getIndex t0 t =  case t of
      C i -> fromInteger i
      RP p _ -> getIndex t0 $ p
      _ -> error $ "compiler error: index from " ++ show t
      ---- TODO: this is workaround for a compiler bug
      -- R (u : _) -> trace (show t ++ " IN\n" ++ show t0) $ getIndex t0 u

  getFields t = case t of
      R rs -> rs
      RP _ r -> getFields r
      _ -> error $ "compiler error: fields from " ++ show t

mkGFCC :: Grammar -> GFCC
mkGFCC (Grm (Hdr a cs) ab@(Abs funs) ccs) = GFCC {
  absname = a,
  cncnames = cs,
  abstract = 
    let
      fs = fromAscList [(fun,typ)    | Fun fun typ _ <- funs]
      cats = sort $ nub [c | Fun f (Typ _ c) _ <- funs]
      cs = fromAscList 
             [(cat,[f | Fun f (Typ _ c) _ <- funs, c==cat]) | cat <- cats]
    in Abstr fs cs,
  concretes = fromAscList [(lang, mkCnc lins) | Cnc lang lins <- ccs]
  }
 where
   mkCnc lins = fromList [(fun,lin) | Lin fun lin <- lins] ---- Asc


