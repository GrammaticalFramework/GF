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
lookLin mcfg lang fun = 
  lookMap (term0 fun) fun $ lookMap undefined lang $ concretes mcfg

linearize :: GFCC -> CId -> Exp -> String
linearize mcfg lang = realize . linExp mcfg lang

realize :: Term -> String
realize trm = case trm of
  R ts     -> realize (ts !! 0)
  S ss     -> unwords $ Prelude.map realize ss
  K t -> case t of
    KS s -> s
    KP s _ -> unwords s ---- prefix choice TODO
  W s t    -> s ++ realize t
  FV ts    -> realize (ts !! 0)  ---- other variants TODO
  RP _ r   -> realize r
  TM       -> "?"
  _ -> "ERROR " ++ show trm ---- debug

linExp :: GFCC -> CId -> Exp -> Term
linExp mcfg lang tree@(Tr at trees) = 
  case at of
    AC fun -> comp (Prelude.map lin trees) $ look fun
    AS s   -> R [kks (show s)] -- quoted
    AI i   -> R [kks (show i)]
    AF d   -> R [kks (show d)]
    AM     -> TM
 where
   lin  = linExp mcfg lang
   comp = compute mcfg lang
   look = lookLin mcfg lang

exp0 :: Exp
exp0 = Tr (AS "NO_PARSE") []

term0 :: CId -> Term
term0 (CId s) = R [kks ("#" ++ s ++ "#")]

kks :: String -> Term
kks = K . KS

compute :: GFCC -> CId -> [Term] -> Term -> Term
compute mcfg lang args = comp where
  comp trm = case trm of
    P r p  -> proj (comp r) (comp p) 
    RP i t -> RP (comp i) (comp t)
    W s t  -> W s (comp t)
    R ts   -> R $ Prelude.map comp ts
    V i    -> idx args (fromInteger i)    -- already computed
    F c    -> comp $ look c               -- not computed (if contains argvar)
    FV ts  -> FV $ Prelude.map comp ts
    S ts   -> S $ Prelude.filter (/= S []) $ Prelude.map comp ts
    _ -> trm

  look = lookLin mcfg lang

  idx xs i = xs !! i 

  proj r p = case (r,p) of
    (_,     FV ts) -> FV $ Prelude.map (proj r) ts
    (W s t, _)     -> kks (s ++ getString (proj t p))      
    _              -> comp $ getField r (getIndex p)

  getString t = case t of
    K (KS s) -> s
    _ -> trace ("ERROR in grammar compiler: string from "++ show t) "ERR"

  getIndex t =  case t of
    C i    -> fromInteger i
    RP p _ -> getIndex p
    TM     -> 0  -- default value for parameter
    _ -> trace ("ERROR in grammar compiler: index from " ++ show t) 0

  getField t i = case t of
    R rs   -> idx rs i
    RP _ r -> getField r i
    TM     -> TM
    _ -> trace ("ERROR in grammar compiler: field from " ++ show t) t

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


