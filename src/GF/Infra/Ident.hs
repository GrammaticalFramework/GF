----------------------------------------------------------------------
-- |
-- Module      : Ident
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/15 11:18:07 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.6 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Ident (-- * Identifiers
	      Ident(..), prIdent,
	      identC, identV, identA, identAV, identW,
	      argIdent, strVar, wildIdent, isWildIdent,
	      newIdent, mkIdent, varIndex,
	      -- * refreshing identifiers
	      IdState, initIdStateN, initIdState,
	      lookVar, refVar, refVarPlus
	     ) where

import Operations
-- import Monad


-- | the constructors labelled /INTERNAL/ are
-- internal representation never returned by the parser
data Ident = 
   IC String            -- ^ raw identifier after parsing, resolved in Rename
 | IW                   -- ^ wildcard
--
-- below this constructor: internal representation never returned by the parser
 | IV (Int,String)      -- ^ /INTERNAL/ variable
 | IA (String,Int)      -- ^ /INTERNAL/ argument of cat at position
 | IAV (String,Int,Int) -- ^ /INTERNAL/ argument of cat with bindings at position
-- 

  deriving (Eq, Ord, Show, Read)

prIdent :: Ident -> String
prIdent i = case i of
  IC s -> s
  IV (n,s) -> s ++ "_" ++ show n
  IA (s,j) -> s ++ "_" ++ show j
  IAV (s,b,j) -> s ++ "_" ++ show b ++ "_" ++ show j
  IW -> "_"

identC :: String -> Ident
identV :: (Int, String) -> Ident
identA :: (String, Int) -> Ident
identAV:: (String, Int, Int) -> Ident
identW :: Ident
(identC, identV, identA, identAV, identW) = 
    (IC,     IV,     IA,     IAV,     IW)

-- normal identifier
-- ident s = IC s

-- | to mark argument variables
argIdent :: Int -> Ident -> Int -> Ident
argIdent 0 (IC c) i = identA  (c,i)
argIdent b (IC c) i = identAV (c,b,i)

-- | used in lin defaults
strVar :: Ident
strVar = identA ("str",0)

-- | wild card
wildIdent :: Ident
wildIdent = identW

isWildIdent :: Ident -> Bool
isWildIdent = (== wildIdent)

newIdent :: Ident
newIdent = identC "#h"

mkIdent :: String -> Int -> Ident
mkIdent s i = identV (i,s)

varIndex :: Ident -> Int
varIndex (IV (n,_)) = n
varIndex _ = -1 --- other than IV should not count

-- refreshing identifiers

type IdState = ([(Ident,Ident)],Int) 

initIdStateN :: Int -> IdState
initIdStateN i = ([],i)

initIdState :: IdState
initIdState = initIdStateN 0

lookVar :: Ident -> STM IdState Ident
lookVar a@(IA _) = return a
lookVar x = do
  (sys,_) <- readSTM
  stm (\s -> maybe (Bad ("cannot find" +++ show x +++ prParenth (show sys))) 
                   return $ 
             lookup x sys >>= (\y -> return (y,s)))

refVar :: Ident -> STM IdState Ident
----refVar IW = return IW --- no update of wildcard
refVar x = do
  (_,m) <- readSTM
  let x' = IV (m, prIdent x)
  updateSTM (\ (sys,mx) -> ((x, x'):sys, mx + 1))
  return x'

refVarPlus :: Ident -> STM IdState Ident
----refVarPlus IW = refVar (identC "h")
refVarPlus x = refVar x


{-
------------------------------
-- to test

refreshExp :: Exp -> Err Exp
refreshExp e = err Bad (return . fst) (appSTM (refresh e) initState)

refresh :: Exp -> STM State Exp
refresh e = case e of
  Atom x  -> lookVar x >>= return . Atom
  App f a -> liftM2 App (refresh f) (refresh a)
  Abs x b -> liftM2 Abs (refVar x)  (refresh b)
  Fun xs a b -> do
    a'  <- refresh a
    xs' <- mapM refVar xs
    b'  <- refresh b
    return $ Fun xs' a' b'

data Exp =
   Atom Ident
 | App Exp Exp
 | Abs Ident Exp
 | Fun [Ident] Exp Exp
  deriving Show

exp1 = Abs (IC "y") (Atom (IC "y"))
exp2 = Abs (IC "y") (App (Atom (IC "y")) (Atom (IC "y")))
exp3 = Abs (IC "y") (Abs (IC "z") (App (Atom (IC "y")) (Atom (IC "z"))))
exp4 = Abs (IC "y") (Abs (IC "y") (App (Atom (IC "y")) (Atom (IC "z"))))
exp5 = Abs (IC "y") (Abs (IC "y") (App (Atom (IC "y")) (Atom (IC "y"))))
exp6 = Abs (IC "y") (Fun [IC "x", IC "y"] (Atom (IC "y")) (Atom (IC "y")))
exp7 = Abs (IL "8") (Atom (IC "y"))

-}
