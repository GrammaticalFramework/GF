abstract Functor = Categories ** {

cat Functor (c1, c2 : Category) ;

data functor :  ({c1, c2} : Category) 
             -> (f0 : El c1 -> El c2)
             -> (f1 : ({x,y} : El c1) -> Arrow x y -> Arrow (f0 x) (f0 y))
             -> ((x : El c1) -> EqAr (f1 (id x)) (id (f0 x)))
             -> (({x,y,z} : El c1) -> (f : Arrow x z) -> (g : Arrow z y) -> EqAr (f1 (comp g f)) (comp (f1 g) (f1 f)))
             -> Functor c1 c2 ;

}