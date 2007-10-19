module Logic where

data Prop =
    Atom Ident [Exp] 
  | And Prop Prop
  | Or  Prop Prop
  | If  Prop Prop
  | Not Prop
  | All   Prop
  | Exist Prop
 deriving Show

data Exp = 
    Const Ident
  | Var Int -- de Bruijn index
 deriving Show


type Ident = String

data Model a = Model {
  ind :: Ident -> a,
  val :: Ident -> [a] -> Bool,
  dom :: [a]
  }

type Assignment a = [a]

update :: a -> Assignment a -> Assignment a
update x assign = x : assign

look :: Int -> Assignment a -> a
look i assign = assign !! i

valExp :: Model a -> Assignment a -> Exp -> a
valExp model assign exp = case exp of
  Const c -> ind model c
  Var i   -> look i assign

valProp :: Model a -> Assignment a -> Prop -> Bool
valProp model assign prop = case prop of
  Atom f xs -> val model f (map (valExp model assign) xs)
  And  a b  -> v a && v b
  Or   a b  -> v a || v b
  If   a b  -> if v a then v b else True
  Not  a    -> not (v a)
  All   p   -> all (\x -> valProp model (update x assign) p) (dom model)
  Exist p   -> any (\x -> valProp model (update x assign) p) (dom model)
 where
   v = valProp model assign

intModel :: Int -> Model Int
intModel mx = Model {
  ind = read,
  val = \f xs -> case (f,xs) of
    ("E",[x])   -> even x
    ("<",[x,y]) -> x < y
    _ -> error "undefined val",
  dom = [0 .. mx]
  }

exModel = intModel 100

ev x   = Atom "E" [x]
lt x y = Atom "<" [x,y]

ex1 :: Prop
ex1 = Exist (ev (Var 0))

ex2 :: Prop
ex2 = All (Exist (lt (Var 1) (Var 0)))

ex3 :: Prop
ex3 = All (If (lt (Var 0) (Const "100")) (Exist (lt (Var 1) (Var 0))))

ex4 :: Prop
ex4 = All (All (If (lt (Var 1) (Var 0)) (Not (lt (Var 0) (Var 1)))))

