abstract InitialAndTerminal = Morphisms ** {

cat  Initial  ({c} : Category) (El c) ;
data initial  : ({c} : Category)
              -> (x : El c)
              -> ((y : El c) -> Arrow x y)
              -> Initial x ;
              
fun initAr :  ({c} : Category)
           -> ({x} : El c)
           -> Initial x
           -> (y : El c)
           -> Arrow x y ;
def initAr {c} {x} (initial {c} x f) y = f y ;

fun initials2iso :  ({c} : Category)
                 -> ({x,y} : El c)
                 -> (ix : Initial x)
                 -> (iy : Initial y)
                 -> Iso (initAr ix y) (initAr iy x) ;
-- def initials2iso = .. ;


cat  Terminal ({c} : Category) (El c) ;
data terminal : ({c} : Category)
              -> (y : El c)
              -> ((x : El c) -> Arrow x y)
              -> Terminal y ;

fun terminalAr :  ({c} : Category)
               -> (x : El c)
               -> ({y} : El c)
               -> Terminal y
               -> Arrow x y ;
def terminalAr {c} x {y} (terminal {c} y f) = f x ;

fun terminals2iso :  ({c} : Category)
                  -> ({x,y} : El c)
                  -> (tx : Terminal x)
                  -> (ty : Terminal y)
                  -> Iso (terminalAr x ty) (terminalAr y tx) ;
-- def terminals2iso = .. ;

}