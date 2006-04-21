module Main where

import GSyntax
import GF.Embed.EmbedAPI

import GF.Infra.UseIO

-- to compile: make

main :: IO ()
main = do
  gr <- file2grammar "database.gfcm"
  loop gr

loop :: MultiGrammar -> IO ()
loop gr = do
  putStrFlush "> "
  s <- getLine
  let ts = parse gr "DatabaseEng" "Query" s
  case ts of
    [t] -> case fg t of
      GQuit -> putStrLnFlush (linearize gr "DatabaseEng" (gf GBye)) >> return ()
      t'    -> case reply t' of
         Left r   -> (putStrLnFlush $ linearize gr "DatabaseEng" $ gf r) >> loop gr
         Right xs -> print xs >> loop gr 
    []  -> putStrLnFlush "no parse" >> loop gr
    _   -> do 
      putStrLnFlush "ambiguous parse:" 
----      mapM_ (putStrLn . prGFTree) ts
      loop gr

-- the question-answer relation

reply :: GQuery -> Either GAnswer [Ent]
reply (GQueryS s) = Left $ if (iS s) then GYes else GNo 
reply (GQueryQ q) = case iQ q of
  [] -> Left GNone
  xs -> Right xs
{- much less efficient:
  xs -> GList $ list xs
 where
   list [x] = GOne (GInt (show x))
   list (x:xs) = GCons (GInt (show x)) (list xs)
-}

-- denotational semantics

type Ent = Integer
type Prop = Bool

domain :: [Ent]
domain = [0..10000] ---

primes = sieve (drop 2 domain) where
  sieve (p:x) = p : sieve [ n | n <- x, n `mod` p > 0 ]
  sieve [] = []

iS :: GS -> Prop
iS (GPredA1 np ap) = iNP np (iA1 ap)

iQ :: GQ -> [Ent]
iQ (GWhichA1 cn a) = [e | e <- iCN cn, iA1 a e]
iQ (GWhichA2 cn np a) = [e | e <- iCN cn, iNP np (\x -> iA2 a x e)]

iA1 :: GA1 -> Ent -> Prop
iA1 (GComplA2 f q) = iNP q . iA2 f
iA1 GEven = even
iA1 GOdd = odd
iA1 GPrime = flip elem primes

iA2 :: GA2 -> Ent -> Ent -> Prop
iA2 GEqual = (==)
iA2 GGreater = (>)
iA2 GSmaller = (<)
iA2 GDivisible = \x y -> y /= 0 && mod x y == 0


iCN :: GCN -> [Ent]
iCN GNumber = domain

iNP :: GNP -> (Ent -> Prop) -> Prop
iNP (GEvery cn) p = all p (iCN cn)
iNP (GSome cn) p = any p (iCN cn)
iNP (GUseInt (GInt n)) p = p n

