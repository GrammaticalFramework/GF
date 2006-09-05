module GF.Canon.GFCC.DataGFCM where

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
compute mcfg lang args trm = case trm of
  P r p -> case (comp r, comp p) of 
    (W s (R ss), C i) -> case comp $ ss !! (fromInteger i) of
      K (KS u) -> kks (s ++ u)      -- the only case where W occurs 
    (R rs, C i) -> comp $ rs !! (fromInteger i)
    (r',p') -> P r' p'
  V i   -> args !! (fromInteger i)  -- already computed
  S ts  -> S (Prelude.map comp ts)
  F c   -> comp $ look c  -- global constant: not yet comp'd (if contains argvar)
  FV ts -> FV $ Prelude.map comp ts
  _ -> trm
 where
   comp = compute mcfg lang args
   look = lookLin mcfg lang


mkGFCC :: Grammar -> GFCC
mkGFCC (Grm (Hdr a cs) ab@(Abs funs) ccs) = GFCC {
  absname = a,
  cncnames = cs,
  abstract = fromAscList [(fun,typ)    | Fun fun typ _ <- funs] ,
  concretes = fromAscList [(lang, mkCnc lins) | Cnc lang lins <- ccs]
  }
 where
   mkCnc lins = fromAscList [(fun,lin) | Lin fun lin <- lins]

