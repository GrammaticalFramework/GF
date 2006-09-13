module GF.Canon.GFCC.DataGFCC where

import GF.Canon.GFCC.AbsGFCC
import Data.Map

data GFCC = GFCC {
  absname   :: CId ,
  cncnames  :: [CId] ,
  abstract  :: Abstr ,
  concretes :: Map CId Concr
  }

type Abstr = Map CId Type
type Concr = Map CId Term

lookMap :: (Show i, Ord i) => i -> Map i a -> a 
lookMap c m = maybe (error ("cannot find " ++ show c)) id $ Data.Map.lookup c m

lookLin :: GFCC -> CId -> CId -> Term
lookLin mcfg lang fun = lookMap fun $ lookMap lang $ concretes mcfg

linearize :: GFCC -> CId -> Exp -> String
linearize mcfg lang = realize . linExp mcfg lang

realize :: Term -> String
realize trm = case trm of
  R (t:_)  -> realize t
  S ss     -> unwords $ Prelude.map realize ss
  K (KS s) -> s
  K (KP s _) -> unwords s ---- prefix choice TODO
  W s t    -> s ++ " " ++ realize t
  _ -> "ERROR " ++ show trm ---- debug

linExp :: GFCC -> CId -> Exp -> Term
linExp mcfg lang tree@(Tr at trees) = 
  case at of
    AC fun -> comp (Prelude.map lin trees) $ look fun
    AS s   -> R [kks s] ---- quoted
    AI i   -> R [kks (show i)]
 where
   lin  = linExp mcfg lang
   comp = compute mcfg lang
   look = lookLin mcfg lang

kks :: String -> Term
kks = K . KS

compute :: GFCC -> CId -> [Term] -> Term -> Term
compute mcfg lang args = compg [] where
  compg g trm = case trm of

    -- for the abstraction optimization
    P (A x t) p -> compg ((x,comp p):g) t 
    L x   -> maybe (error (show x)) id $ Prelude.lookup x g

    P r p -> case (comp r, comp p) of 

    -- for the suffix optimization
      (W s t, C i) -> case comp t of
        R ss -> case comp $ idx ss (fromInteger i) of
          K (KS u) -> kks (s ++ u)      -- the only case where W occurs
 
      (R rs, C i) -> comp $ idx rs (fromInteger i)
      (r',p') -> P r' p'
    W s t -> W s (comp t)
    R ts  -> R $ Prelude.map comp ts
    V i   -> idx args (fromInteger i)  -- already computed
    S ts  -> S (Prelude.map comp ts)
    F c   -> comp $ look c  -- global const: not yet comp'd (if contains argvar)
    FV ts -> FV $ Prelude.map comp ts
    _ -> trm
   where
    comp = compg g 
    look = lookLin mcfg lang
    idx xs i = 
      if length xs <= i  ---- debug
      then error (show xs ++ " !! " ++ show i) else
      xs !! i 

mkGFCC :: Grammar -> GFCC
mkGFCC (Grm (Hdr a cs) ab@(Abs funs) ccs) = GFCC {
  absname = a,
  cncnames = cs,
  abstract = fromAscList [(fun,typ)    | Fun fun typ _ <- funs] ,
  concretes = fromAscList [(lang, mkCnc lins) | Cnc lang lins <- ccs]
  }
 where
   mkCnc lins = fromList [(fun,lin) | Lin fun lin <- lins] ---- Asc


