module Logic where

data Prop =
    Pred Ident [Exp] 
  | And Prop Prop
  | Or  Prop Prop
  | If  Prop Prop
  | Not Prop
  | All   Prop
  | Exist Prop
 deriving Show

data Exp = 
    App Ident [Exp]
  | Var Int -- de Bruijn index
 deriving Show

type Ident = String

data Model a = Model {
  app  :: Ident -> [a] -> a,
  prd  :: Ident -> [a] -> Bool,
  dom  :: [a]
  }

type Assignment a = [a]

update :: a -> Assignment a -> Assignment a
update x assign = x : assign

look :: Int -> Assignment a -> a
look i assign = assign !! i

valExp :: Model a -> Assignment a -> Exp -> a
valExp model assign exp = case exp of
  App f xs -> app model f (map (valExp model assign) xs)
  Var i    -> look i assign

valProp :: Model a -> Assignment a -> Prop -> Bool
valProp model assign prop = case prop of
  Pred f xs -> prd model f (map (valExp model assign) xs)
  And  a b  -> v a && v b
  Or   a b  -> v a || v b
  If   a b  -> if v a then v b else True
  Not  a    -> not (v a)
  All   p   -> all (\x -> valProp model (update x assign) p) (dom model)
  Exist p   -> any (\x -> valProp model (update x assign) p) (dom model)
 where
   v = valProp model assign

liftProp :: Int -> Prop -> Prop
liftProp i p = case p of
  Pred f xs -> Pred f (map liftExp xs)
  And a b   -> And (lift a) (lift b)
  Or  a b   -> Or (lift a) (lift b)
  If  a b   -> If (lift a) (lift b)
  Not a     -> Not (lift a)
  All p     -> All (liftProp (i+1) p)
  Exist p   -> Exist (liftProp (i+1) p)
 where
   lift = liftProp i
   liftExp e = case e of
     App f xs -> App f (map liftExp xs)
     Var j    -> Var (j + i)
     _ -> e


-- example: initial segments of integers

intModel :: Int -> Model Int
intModel mx = Model {
  app = \f xs -> case (f,xs) of
    ("+",_) -> sum xs
    (_,[])  -> read f,
  prd = \f xs -> case (f,xs) of
    ("E",[x])   -> even x
    ("<",[x,y]) -> x < y
    ("=",[x,y]) -> x == y
    _ -> error "undefined val",
  dom = [0 .. mx]
  }

exModel = intModel 100

ev x   = Pred "E" [x]
lt x y = Pred "<" [x,y]
eq x y = Pred "=" [x,y]
int i = App (show i) []

ex1 :: Prop
ex1 = Exist (ev (Var 0))

ex2 :: Prop
ex2 = All (Exist (lt (Var 1) (Var 0)))

ex3 :: Prop
ex3 = All (If (lt (Var 0) (int 100)) (Exist (lt (Var 1) (Var 0))))

ex4 :: Prop
ex4 = All (All (If (lt (Var 1) (Var 0)) (Not (lt (Var 0) (Var 1)))))

