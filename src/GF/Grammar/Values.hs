----------------------------------------------------------------------
-- |
-- Module      : Values
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:13 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.6 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Values (-- * values used in TC type checking
	       Exp, Val(..), Env,
	       -- * annotated tree used in editing
	       Tree, TrNode(..), Atom(..), Binds, Constraints, MetaSubst,
	       -- * for TC
	       valAbsInt, valAbsString, vType,
	       isPredefCat,
	       cType, cPredefAbs, cInt, cString,
	       eType, tree2exp, loc2treeFocus
	      ) where

import Operations
import Zipper

import Grammar
import Ident

-- values used in TC type checking

type Exp = Term

data Val = VGen Int Ident | VApp Val Val | VCn QIdent | VType | VClos Env Exp 
  deriving (Eq,Show)

type Env = [(Ident,Val)]

-- annotated tree used in editing

type Tree = Tr TrNode

newtype TrNode = N (Binds,Atom,Val,(Constraints,MetaSubst),Bool) 
  deriving (Eq,Show)

data Atom = AtC Fun | AtM MetaSymb | AtV Ident | AtL String | AtI Int
  deriving (Eq,Show)

type Binds = [(Ident,Val)]
type Constraints = [(Val,Val)]
type MetaSubst = [(MetaSymb,Val)]

-- for TC

valAbsInt :: Val
valAbsInt = VCn (cPredefAbs, cInt)

valAbsString :: Val
valAbsString = VCn (cPredefAbs, cString)

vType :: Val
vType = VType

cType :: Ident
cType = identC "Type" --- #0

cPredefAbs :: Ident
cPredefAbs = identC "PredefAbs"

cInt :: Ident
cInt = identC "Int"

cString :: Ident
cString = identC "String"

isPredefCat :: Ident -> Bool
isPredefCat c = elem c [cInt,cString]

eType :: Exp
eType = Sort "Type"

tree2exp :: Tree -> Exp
tree2exp (Tr (N (bi,at,_,_,_),ts)) = foldr Abs (foldl App at' ts') bi' where
  at' = case at of
    AtC (m,c) -> Q m c
    AtV i -> Vr i
    AtM m -> Meta m
    AtL s -> K s
    AtI s -> EInt s
  bi' = map fst bi
  ts' = map tree2exp ts

loc2treeFocus :: Loc TrNode -> Tree
loc2treeFocus (Loc (Tr (a,ts),p)) = 
  loc2tree (Loc (Tr (mark a, map (mapTr nomark) ts), mapPath nomark p)) 
 where 
   (mark, nomark) = (\(N (a,b,c,d,_)) -> N(a,b,c,d,True), 
                     \(N (a,b,c,d,_)) -> N(a,b,c,d,False))

