module Values where

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

vType :: Val
vType = VType

cType :: Ident
cType = identC "Type" --- #0

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

