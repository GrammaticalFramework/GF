module PGF.Editor where

import qualified Data.Map as M

-- API

replace :: Tree -> State -> State
replace t = doInState (const t)

delete :: State -> State
delete s = replace (uTree (typ (tree s))) s

new :: Type -> State
new t = tree2state (uTree t)

refineMenu :: Dict -> State -> [(Id,FType)]
refineMenu dict s = maybe [] id $ M.lookup (focusType s) (refines dict)


----

data Tree = Tree {
  atom :: Atom,
  typ  :: Type,
  children :: [Tree]
  }
  deriving Show

data Atom =
    ACon Id
  | AMeta Int
  deriving Show

uTree :: Type -> Tree
uTree ty = Tree (AMeta 0) ty []

data State = State {
  position :: Position,
  tree :: Tree
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

tree2state :: Tree -> State
tree2state = State top

doInState :: (Tree -> Tree) -> State -> State
doInState f s = s{tree = change (position s) (tree s)} where
  change p t = case p of
    [] -> f t
    n:ns -> let (ts1,t0:ts2) = splitAt n (children t) in 
              t{children = ts1 ++ [change ns t0] ++ ts2}

subtree :: Position -> Tree -> Tree
subtree p t = case p of
  [] -> t
  n:ns -> subtree ns (children t !! n) 

focus :: State -> Tree
focus s = subtree (position s) (tree s)

focusType :: State -> Type
focusType s = typ (focus s)

navigate :: (Position -> Position) -> State -> State
navigate p s = s{position = p (position s)}

-------

type Id = String ----
type Type = Id ----
type FType = ([Id],Id) ----

data Dict = Dict {
  funs    :: M.Map Id FType,
  refines :: M.Map Type [(Id,FType)]
  }
