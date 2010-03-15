abstract Functor = Categories ** {

cat Functor (c1, c2 : Category) ;

data functor :  ({c1, c2} : Category) 
             -> (f0 : El c1 -> El c2)
             -> (f1 : ({x,y} : El c1) -> Arrow x y -> Arrow (f0 x) (f0 y))
             -> ((x : El c1) -> EqAr (f1 (id x)) (id (f0 x)))
             -> (({x,y,z} : El c1) -> (f : Arrow x z) -> (g : Arrow z y) -> EqAr (f1 (comp g f)) (comp (f1 g) (f1 f)))
             -> Functor c1 c2 ;
{-
fun compF : ({c1,c2,c3} : Category) -> Functor c3 c2 -> Functor c1 c3 -> Functor c1 c2 ;
def compF {c1} {c2} {c3} (functor {c3} {c2} f032 f132 eqid32 eqcmp32) (functor {c1} {c3} f013 f113 eqid13 eqcmp13) =
        functor (\x -> f032 (f013 x)) (\x -> f132 (f113 x)) (\x -> mapEqAr (f132 {?} {?}) eqid13) ? ;
-}

fun mapEl :  ({c1, c2} : Category)
          -> Functor c1 c2
          -> El c1
          -> El c2 ;
def mapEl {c1} {c2} (functor {c1} {c2} f0 f1 _ _) = f0 ;
{-
fun mapAr :  ({c1, c2} : Category)
          -> ({x,y} : El c1)
          -> (f : Functor c1 c2)
          -> Arrow x y
          -> Arrow (mapEl f x) (mapEl f y) ;
def mapAr {c1} {c2} {x} {y} (functor {c1} {c2} f0 f1 _ _) = f1 {x} {y} ;
-}
{-
fun mapEqAr :  ({c} : Category)
            -> ({x,y} : El c)
            -> ({f,g} : Arrow x y)
            -> (func : Arrow x y -> Arrow x y)
            -> EqAr f g
            -> EqAr (func f) (func g) ;
def mapEqAr {c} {x} {y} {f} {f} func (eqRefl {c} {x} {y} f) = eqRefl (func f) ;
-}
}