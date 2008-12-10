module PGF.Editor (
  State,       -- datatype  -- type-annotated possibly open tree with a focus
  Dict,        -- datatype  -- abstract syntax information optimized for editing
  Position,    -- datatype  -- path from top to focus 
  new,         -- :: Type  -> State                    -- create new State
  refine,      -- :: Dict  -> CId -> State -> State    -- refine focus with CId
  replace,     -- :: Dict  -> Tree -> State -> State   -- replace focus with Tree
  delete,      -- :: State -> State                    -- replace focus with ?
  goNextMeta,  -- :: State -> State                    -- move focus to next ? node
  goNext,      -- :: State -> State                    -- move to next node
  goTop,       -- :: State -> State                    -- move focus to the top (=root)
  goPosition,  -- :: Position -> State -> State        -- move focus to given position
  mkPosition,  -- :: [Int] -> Position                 -- list of choices (top = [])
  showPosition,-- :: Position -> [Int]                 -- readable position 
  focusType,   -- :: State -> Type                     -- get the type of focus
  stateTree,   -- :: State -> Tree                     -- get the current tree
  isMetaFocus, -- :: State -> Bool                     -- whether focus is ?
  allMetas,    -- :: State -> [(Position,Type)]        -- all ?s and their positions
  prState,     -- :: State -> String                   -- print state, focus marked *
  refineMenu,  -- :: Dict  -> State -> [CId]           -- get refinement menu
  pgf2dict     -- :: PGF   -> Dict                     -- create editing Dict from PGF
  ) where

import PGF.Data
import PGF.CId
import qualified Data.Map as M
import Debug.Trace ----

-- API

new :: Type -> State
new (DTyp _ t _) = etree2state (uETree t)

refine :: Dict -> CId -> State -> State
refine dict f = replaceInState (mkRefinement dict f)

replace :: Dict -> Tree -> State -> State
replace dict t = replaceInState (tree2etree dict t)

delete :: State -> State
delete s = replaceInState (uETree (typ (tree s))) s

goNextMeta :: State -> State
goNextMeta s = 
  if isComplete s then s
  else let s1 = goNext s in if isMetaFocus s1 
    then s1 else goNextMeta s1

isComplete :: State -> Bool
isComplete s = isc (tree s) where
  isc t = case atom t of
    AMeta _ -> False
    ACon  _ -> all isc (children t)

goTop :: State -> State
goTop = navigate (const top)

goPosition :: [Int] -> State -> State
goPosition p s = s{position = p}

mkPosition :: [Int] -> Position
mkPosition = id

refineMenu :: Dict -> State -> [CId]
refineMenu dict s = maybe [] (map fst) $ M.lookup (focusBType s) (refines dict)

focusType :: State -> Type
focusType s = btype2type (focusBType s)

stateTree :: State -> Tree
stateTree = etree2tree . tree

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

tree2etree :: Dict -> Tree -> ETree
tree2etree dict t = case t of
  Fun f _ -> annot (look f) t
 where
  annot (tys,ty) tr = case tr of 
    Fun f trs -> ETree (ACon f)  ty [annt t tr | (t,tr) <- zip tys trs]
    Meta i    -> ETree (AMeta i) ty []
  annt ty tr = case tr of
    Fun _ _ -> tree2etree dict tr
    Meta _  -> annot ([],ty) tr
  look f = maybe undefined id $ M.lookup f (functs dict)

prState :: State -> String
prState s = unlines [replicate i ' ' ++ f | (i,f) <- pr [] (tree s)] where
  pr i t = 
    (ind i,prAtom i (atom t)) : concat [pr (sub j i) c | (j,c) <- zip [0..] (children t)]
  prAtom i a = prFocus i ++ case a of
    ACon f -> prCId f
    AMeta i -> "?" ++ show i
  prFocus i = if i == position s then "*" else ""
  ind i = 2 * length i
  sub j i = i ++ [j]

showPosition :: Position -> [Int]
showPosition = id

allMetas :: State -> [(Position,Type)]
allMetas s = [(reverse p, btype2type ty) | (p,ty) <- metas [] (tree s)] where
  metas p t = 
    (if isMetaAtom (atom t) then [(p,typ t)] else []) ++ 
      concat [metas (i:p) u | (i,u) <- zip [0..] (children t)]

---- Trees and navigation

data ETree = ETree {
  atom  :: Atom,
  typ   :: BType,
  children :: [ETree]
  }
  deriving Show

data Atom =
    ACon CId
  | AMeta Int
  deriving Show

btype2type :: BType -> Type
btype2type t = DTyp [] t []

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
up p = case p of
  _:_ -> init p
  _ -> p

down :: Position -> Position
down = (++[0])

left :: Position -> Position
left p = case p of
  _:_ | last p > 0 -> init p ++ [last p - 1]
  _ -> top

right :: Position -> Position
right p = case p of
  _:_ -> init p ++ [last p + 1]
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

focusBType :: State -> BType
focusBType s = typ (focus s)

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
  _ -> findSister s
 where
  findSister s = case s of
    s' | null (position s') -> s'
    s' | hasYoungerSisters s' -> navigate right s'
    s' -> findSister (navigate up s')
  hasYoungerSisters s = case position s of
    p@(_:_) -> length (children (focus (navigate up s))) > last p + 1
    _ -> False

isMetaFocus :: State -> Bool
isMetaFocus s = isMetaAtom (atom (focus s))

isMetaAtom :: Atom -> Bool
isMetaAtom a = case a of
  AMeta _ -> True
  _ -> False

replaceInState :: ETree -> State -> State
replaceInState t = doInState (const t)


-------

type BType = CId ----dep types
type FType = ([BType],BType) ----dep types

data Dict = Dict {
  functs  :: M.Map CId FType,
  refines :: M.Map BType [(CId,FType)]
  }

mkRefinement :: Dict -> CId -> ETree
mkRefinement dict f = ETree (ACon f) val (map uETree args) where
  (args,val) = maybe undefined id $ M.lookup f (functs dict)

