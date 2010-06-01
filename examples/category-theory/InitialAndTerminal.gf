abstract InitialAndTerminal = Morphisms ** {

cat  Initial  ({c} : Category) (Obj c) ;
data initial  : ({c} : Category)
              -> (x : Obj c)
              -> ((y : Obj c) -> Arrow x y)
              -> Initial x ;
              
fun initAr :  ({c} : Category)
           -> ({x} : Obj c)
           -> Initial x
           -> (y : Obj c)
           -> Arrow x y ;
-- def initAr {~c} {~x} (initial {c} x f) y = f y ;
{-
fun initials2iso :  ({c} : Category)
                 -> ({x,y} : Obj c)
                 -> (ix : Initial x)
                 -> (iy : Initial y)
                 -> Iso (initAr ix y) (initAr iy x) ;
-}
-- def initials2iso = .. ;


cat  Terminal ({c} : Category) (Obj c) ;
data terminal : ({c} : Category)
              -> (y : Obj c)
              -> ((x : Obj c) -> Arrow x y)
              -> Terminal y ;

fun terminalAr :  ({c} : Category)
               -> (x : Obj c)
               -> ({y} : Obj c)
               -> Terminal y
               -> Arrow x y ;
-- def terminalAr {c} x {~y} (terminal {~c} y f) = f x ;
{-
fun terminals2iso :  ({c} : Category)
                  -> ({x,y} : Obj c)
                  -> (tx : Terminal x)
                  -> (ty : Terminal y)
                  -> Iso (terminalAr x ty) (terminalAr y tx) ;
                  -}
-- def terminals2iso = .. ;

}
