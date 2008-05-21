----------------------------------------------------------------------
-- |
-- Module      : Values
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:32 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Grammar.Values (-- * values used in TC type checking
	       Exp, Val(..), Env,
	       -- * annotated tree used in editing
	       Tree, TrNode(..), Atom(..), Binds, Constraints, MetaSubst,
	       -- * for TC
	       valAbsInt, valAbsFloat, valAbsString, vType,
	       isPredefCat,
	       eType, tree2exp, loc2treeFocus
	      ) where

import GF.Data.Operations
import GF.Data.Zipper

import GF.Infra.Ident
import GF.Grammar.Grammar
import GF.Grammar.Predef

-- values used in TC type checking

type Exp = Term

data Val = VGen Int Ident | VApp Val Val | VCn QIdent | VType | VClos Env Exp 
  deriving (Eq,Show)

type Env = [(Ident,Val)]

-- annotated tree used in editing

type Tree = Tr TrNode

newtype TrNode = N (Binds,Atom,Val,(Constraints,MetaSubst),Bool) 
  deriving (Eq,Show)

data Atom = 
  AtC Fun | AtM MetaSymb | AtV Ident | AtL String | AtI Integer | AtF Double
  deriving (Eq,Show)

type Binds = [(Ident,Val)]
type Constraints = [(Val,Val)]
type MetaSubst = [(MetaSymb,Val)]

-- for TC

valAbsInt :: Val
valAbsInt = VCn (cPredefAbs, cInt)

valAbsFloat :: Val
valAbsFloat = VCn (cPredefAbs, cFloat)

valAbsString :: Val
valAbsString = VCn (cPredefAbs, cString)

vType :: Val
vType = VType

eType :: Exp
eType = Sort cType

tree2exp :: Tree -> Exp
tree2exp (Tr (N (bi,at,_,_,_),ts)) = foldr Abs (foldl App at' ts') bi' where
  at' = case at of
    AtC (m,c) -> Q m c
    AtV i -> Vr i
    AtM m -> Meta m
    AtL s -> K s
    AtI s -> EInt s
    AtF s -> EFloat s
  bi' = map fst bi
  ts' = map tree2exp ts

loc2treeFocus :: Loc TrNode -> Tree
loc2treeFocus (Loc (Tr (a,ts),p)) = 
  loc2tree (Loc (Tr (mark a, map (mapTr nomark) ts), mapPath nomark p)) 
 where 
   (mark, nomark) = (\(N (a,b,c,d,_)) -> N(a,b,c,d,True), 
                     \(N (a,b,c,d,_)) -> N(a,b,c,d,False))

