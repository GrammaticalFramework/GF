----------------------------------------------------------------------
-- |
-- Module      : Greek
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:37 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Text.Greek (mkGreek) where

mkGreek :: String -> String
mkGreek = unwords . (map mkGreekWord) . mkGravis . words

--- TODO : optimize character formation by factorizing the case expressions

type GreekChar = Char

mkGreekWord :: String -> [GreekChar]
mkGreekWord = map (toEnum . mkGreekChar) . mkGreekSpec

mkGravis :: [String] -> [String]
mkGravis [] = []
mkGravis [w] = [w]
mkGravis (w1:w2:ws)
 | stressed w2 = mkG w1 : mkGravis (w2:ws)
 | otherwise = w1 : w2 : mkGravis ws
  where
    stressed w = any (`elem`  "'~`") w
    mkG :: String -> String
    mkG w = let (w1,w2) = span (/='\'') w in
               case w2 of
                 '\'':v:cs | not (any isVowel cs) -> w1 ++ "`" ++ [v] ++ cs
                 '\'':'!':v:cs | not (any isVowel cs) -> w1 ++ "`!" ++ [v] ++ cs
                 _ -> w
    isVowel c = elem c "aehiouw"

mkGreekSpec :: String -> [(Char,Int)]
mkGreekSpec str = case str of
  [] -> []
  '(' :'\'': '!' : c : cs -> (c,25)  : mkGreekSpec cs
  '(' :'~' : '!' : c : cs -> (c,27)  : mkGreekSpec cs
  '(' :'`' : '!' : c : cs -> (c,23)  : mkGreekSpec cs
  '(' :      '!' : c : cs -> (c,21)  : mkGreekSpec cs
  ')' :'\'': '!' : c : cs -> (c,24)  : mkGreekSpec cs
  ')' :'~' : '!' : c : cs -> (c,26)  : mkGreekSpec cs
  ')' :'`' : '!' : c : cs -> (c,22)  : mkGreekSpec cs
  ')' :      '!' : c : cs -> (c,20)  : mkGreekSpec cs
  '\'':      '!' : c : cs -> (c,30)  : mkGreekSpec cs
  '~' :      '!' : c : cs -> (c,31)  : mkGreekSpec cs
  '`' :      '!' : c : cs -> (c,32)  : mkGreekSpec cs
  '!' :            c : cs -> (c,33)  : mkGreekSpec cs
  '(' :'\'': c : cs -> (c,5)  : mkGreekSpec cs
  '(' :'~' : c : cs -> (c,7)  : mkGreekSpec cs
  '(' :'`' : c : cs -> (c,3)  : mkGreekSpec cs
  '(' :      c : cs -> (c,1)  : mkGreekSpec cs
  ')' :'\'': c : cs -> (c,4)  : mkGreekSpec cs
  ')' :'~' : c : cs -> (c,6)  : mkGreekSpec cs
  ')' :'`' : c : cs -> (c,2)  : mkGreekSpec cs
  ')' :      c : cs -> (c,0)  : mkGreekSpec cs
  '\'':      c : cs -> (c,10) : mkGreekSpec cs
  '~' :      c : cs -> (c,11) : mkGreekSpec cs
  '`' :      c : cs -> (c,12) : mkGreekSpec cs
  c   :          cs -> (c,-1) : mkGreekSpec cs

mkGreekChar (c,-1) = case lookup c cc of Just c' -> c' ; _ -> fromEnum c 
 where 
   cc = zip "abgdezhqiklmnxoprjstyfcuw" allGreekMin
mkGreekChar (c,n) = case (c,n) of
  ('a',10)        -> 0x03ac 
  ('a',11)        -> 0x1fb6
  ('a',12)        -> 0x1f70
  ('a',30)        -> 0x1fb4
  ('a',31)        -> 0x1fb7
  ('a',32)        -> 0x1fb2
  ('a',33)        -> 0x1fb3
  ('a',n) | n >19 -> 0x1f80 + n - 20
  ('a',n)         -> 0x1f00 + n
  ('e',10)        -> 0x03ad    -- ' 
--  ('e',11)        -> 0x1fb6    -- ~ can't happen
  ('e',12)        -> 0x1f72    -- `
  ('e',n)         -> 0x1f10 + n
  ('h',10)        -> 0x03ae    -- ' 
  ('h',11)        -> 0x1fc6    -- ~
  ('h',12)        -> 0x1f74    -- `

  ('h',30)        -> 0x1fc4
  ('h',31)        -> 0x1fc7
  ('h',32)        -> 0x1fc2
  ('h',33)        -> 0x1fc3
  ('h',n) | n >19 -> 0x1f90 + n - 20

  ('h',n)         -> 0x1f20 + n
  ('i',10)        -> 0x03af    -- ' 
  ('i',11)        -> 0x1fd6    -- ~
  ('i',12)        -> 0x1f76    -- `
  ('i',n)         -> 0x1f30 + n
  ('o',10)        -> 0x03cc    -- ' 
--  ('o',11)        -> 0x1fb6    -- ~ can't happen
  ('o',12)        -> 0x1f78    -- `
  ('o',n)         -> 0x1f40 + n
  ('y',10)        -> 0x03cd    -- ' 
  ('y',11)        -> 0x1fe6    -- ~
  ('y',12)        -> 0x1f7a    -- `
  ('y',n)         -> 0x1f50 + n
  ('w',10)        -> 0x03ce    -- ' 
  ('w',11)        -> 0x1ff6    -- ~
  ('w',12)        -> 0x1f7c    -- `

  ('w',30)        -> 0x1ff4
  ('w',31)        -> 0x1ff7
  ('w',32)        -> 0x1ff2
  ('w',33)        -> 0x1ff3
  ('w',n) | n >19 -> 0x1fa0 + n - 20

  ('w',n)         -> 0x1f60 + n
  ('r',1)         -> 0x1fe5
  _               -> mkGreekChar (c,-1) --- should not happen

allGreekMin :: [Int]
allGreekMin = [0x03b1 .. 0x03c9]


{-
encoding of Greek writing. Those hard to guess are marked with ---

               maj   min
A a Alpha     0391  03b1  
B b Beta      0392  03b2
G g Gamma     0393  03b3
D d Delta     0394  03b4
E e Epsilon   0395  03b5
Z z Zeta      0396  03b6
H h Eta ---   0397  03b7
Q q Theta --- 0398  03b8
I i Iota      0399  03b9
K k Kappa     039a  03ba
L l Lambda    039b  03bb
M m My        039c  03bc
N n Ny        039d  03bd
X x Xi        039e  03be
O o Omikron   039f  03bf
P p Pi        03a0  03c0
R r Rho       03a1  03c1
  j Sigma ---       03c2
S s Sigma     03a3  03c3
T t Tau       03a4  03c4
Y y Ypsilon   03a5  03c5
F f Phi       03a6  03c6
C c Khi ---   03a7  03c7
U u Psi       03a8  03c8
W w Omega --- 03a9  03c9

( spiritus asper
) spiritus lenis
! iota subscriptum

' acutus
~ circumflexus
` gravis

-}





