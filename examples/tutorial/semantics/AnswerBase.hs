module AnswerBase where

import GSyntax

-- interpretation of Base

type Prop = Bool
type Ent = Int
domain = [0 .. 100]

iS :: GS -> Prop
iS s = case s of
  GPredAP np ap -> iNP np (iAP ap)
  GConjS c s t  -> iConj c (iS s) (iS t)

iNP :: GNP -> (Ent -> Prop) -> Prop
iNP np p = case np of
  GEvery cn -> all (\x -> not (iCN cn x) || p x) domain
  GSome  cn -> any (\x ->      iCN cn x  && p x) domain
  GNone  cn -> not (any (\x -> iCN cn x  && p x) domain)
  GMany pns -> and (map p (iListPN pns))
  GConjNP c np1 np2 -> iConj c (iNP np1 p) (iNP np2 p)
  GUsePN a -> p (iPN a)

iPN :: GPN -> Ent
iPN pn = case pn of  
  GUseInt i -> iInt i
  GSum pns -> sum (iListPN pns)
  GProduct pns -> product (iListPN pns)
  GGCD pns -> foldl1 gcd (iListPN pns)

iAP :: GAP -> Ent -> Prop
iAP ap e = case ap of
  GComplA2 a2 np    -> iNP np (iA2 a2 e)
  GConjAP c ap1 ap2 -> iConj c (iAP ap1 e) (iAP ap2 e)
  GEven  -> even e
  GOdd   -> odd e
  GPrime -> prime e

iCN :: GCN -> Ent -> Prop
iCN cn e = case cn of
  GModCN ap cn0 -> (iCN cn0 e) && (iAP ap e)
  GNumber -> True

iConj :: GConj -> Prop -> Prop -> Prop
iConj c = case c of
  GAnd -> (&&)
  GOr  -> (||)

iA2 :: GA2 -> Ent -> Ent -> Prop
iA2 a2 e1 e2 = case a2 of
  GGreater -> e1 > e2
  GSmaller -> e1 < e2 
  GEqual   -> e1 == e2
  GDivisible -> e2 /= 0 && mod e1 e2 == 0

iListPN :: GListPN -> [Ent]
iListPN gls = case gls of
  GListPN pns -> map iPN pns

iInt :: GInt -> Ent
iInt gi = case gi of
  GInt i -> fromInteger i

-- questions and answers

iQuestion :: GQuestion -> Either Bool [Ent]
iQuestion q = case q of
  GWhatIs pn      -> Right [iPN pn]  -- computes the value
  GWhichAre cn ap -> Right [e | e <- domain, iCN cn e, iAP ap e]
  GQuestS s       -> Left  (iS s)

question2answer :: GQuestion -> GAnswer
question2answer q = case iQuestion q of
  Left True  -> GYes
  Left False -> GNo
  Right []   -> GValue (GNone GNumber)
  Right [v]  -> GValue (GUsePN (ent2pn v))
  Right vs   -> GValue (GMany (GListPN (map ent2pn vs)))

ent2pn :: Ent -> GPN
ent2pn e = GUseInt (GInt (toInteger e))


-- auxiliary

prime :: Int -> Bool
prime x = elem x primes where
  primes = sieve [2 .. x]
  sieve (p:xs) = p : sieve [ n | n <- xs, n `mod` p > 0 ]
  sieve [] = []
