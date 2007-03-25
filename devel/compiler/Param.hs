type Param  = (Id,[Constr])
type Constr = (Id,[Id])
type Source = [Param] 
type Id     = String

type Target = [(Id,((Int,Int),[Id]))]

compile :: Source -> Target
compile src = ctyps ++ incss where
  ctyps = map compT src
  (typs,cons) = unzip src
  compT (ty,cs) = 
    (ty,((sum [product [size t | t <- ts] | (_,ts) <- cs],length cs),[]))
  size ty = maybe undefined (fst . fst) $ lookup ty ctyps
  incss = concat $ map (incs 0) cons
  incs k cs = case cs of
    (c,ts):cs2 -> 
      let s = product (map size ts) in (c,((s,k),ts)) : incs (k+s) cs2
    _ -> []

newtype Value = V (Id,[Value])

value :: Target -> Value -> Int
value tg (V (f,xs)) = maybe undefined (snd . fst) (lookup f tg) + posit xs where
  posit xs = 
    sum [value tg x * product [size p | (_,p) <- xs2] | 
                                i         <- [0..length xs -1], 
                                let (x,_):xs2 = drop i (zip xs args)
        ]
  args = maybe undefined snd $ lookup f tg
  size p = maybe undefined (fst . fst) $ lookup p tg

ex1 :: Source
ex1 = [
  ("B",[("T",[]),("F",[])]),
  ("G",[("M",[]),("Fe",[]),("N",[])]),
  ("Q",[("Q1",["B"]),("Q2",["B","B"]),("Q3",["B","B","B"])])
  ]
