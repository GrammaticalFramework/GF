module PGF.Editor where

import PGF.Data
import PGF.CId
import qualified Data.Map as M

-- API

new :: Type -> State
new (DTyp _ t _) = etree2state (uETree t)

refine :: Dict -> CId -> State -> State
refine dict f = replace (mkRefinement dict f)

replace :: ETree -> State -> State
replace t = doInState (const t)

delete :: State -> State
delete s = replace (uETree (typ (tree s))) s

goNextMeta :: State -> State
goNextMeta = untilPosition isMetaFocus goNext 

goTop :: State -> State
goTop = navigate (const top)

refineMenu :: Dict -> State -> [(CId,FType)]
refineMenu dict s = maybe [] id $ M.lookup (focusType s) (refines dict)

pgf2dict :: PGF -> Dict
pgf2dict pgf = Dict (M.fromAscList fus) refs where
  fus  = [(f,mkFType ty)  | (f,(ty,_)) <- M.toList (funs abs)]
  refs = M.fromAscList [(c, fusTo c) | (c,_) <- M.toList (cats abs)]
  fusTo c = [(f,ty) | (f,ty@(_,k)) <- fus, k==c] ---- quadratic
  mkFType (DTyp hyps c _) = ([k | Hyp _ (DTyp _ k _) <- hyps],c)  ----dep types
  abs  = abstract pgf

etree2tree :: ETree -> Tree
etree2tree t = case atom t of
  ACon f  -> Fun f (map etree2tree (children t))
  AMeta i -> Meta i

--tree2etree :: Tree -> ETree


---- TODO
-- getPosition :: Language -> Int -> ETree -> Position

---- Trees and navigation

data ETree = ETree {
  atom :: Atom,
  typ  :: BType,
  children :: [ETree]
  }
  deriving Show

data Atom =
    ACon CId
  | AMeta Int
  deriving Show

uETree :: BType -> ETree
uETree ty = ETree (AMeta 0) ty []

data State = State {
  position :: Position,
  tree :: ETree
  }
  deriving Show

type Position = [Int]

top :: Position
top = []

up :: Position -> Position
up = tail

down :: Position -> Position
down = (0:)

left :: Position -> Position
left p = case p of
  (n:ns) | n > 0 -> n-1 : ns
  _ -> top

right :: Position -> Position
right p = case p of
  (n:ns) -> n+1 : ns
  _ -> top

etree2state :: ETree -> State
etree2state = State top

doInState :: (ETree -> ETree) -> State -> State
doInState f s = s{tree = change (position s) (tree s)} where
  change p t = case p of
    [] -> f t
    n:ns -> let (ts1,t0:ts2) = splitAt n (children t) in 
              t{children = ts1 ++ [change ns t0] ++ ts2}

subtree :: Position -> ETree -> ETree
subtree p t = case p of
  [] -> t
  n:ns -> subtree ns (children t !! n) 

focus :: State -> ETree
focus s = subtree (position s) (tree s)

focusType :: State -> BType
focusType s = typ (focus s)

navigate :: (Position -> Position) -> State -> State
navigate p s = s{position = p (position s)}

-- p is a fix-point aspect of state change
untilFix :: Eq a => (State -> a) -> (State -> Bool) -> (State -> State) -> State -> State
untilFix p b f s = 
  if b s  
    then s 
    else let fs = f s in if p fs == p s 
      then s 
      else untilFix p b f fs

untilPosition :: (State -> Bool) -> (State -> State) -> State -> State
untilPosition = untilFix position

goNext :: State -> State
goNext s = case focus s of
  st | not (null (children st)) -> navigate down s 
  _ -> navigate right (untilPosition hasYoungerSisters (navigate up) s)
 where
  hasYoungerSisters s = case position s of
    n:ns -> length (children (subtree ns (tree s))) > n + 1

isMetaFocus :: State -> Bool
isMetaFocus s = case atom (focus s) of
  AMeta _ -> True
  _ -> False


-------

type BType = CId ----
type FType = ([BType],BType) ----

data Dict = Dict {
  functs  :: M.Map CId FType,
  refines :: M.Map BType [(CId,FType)]
  }

mkRefinement :: Dict -> CId -> ETree
mkRefinement dict f = ETree (ACon f) val (map uETree args) where
  (args,val) = maybe undefined id $ M.lookup f (functs dict)

