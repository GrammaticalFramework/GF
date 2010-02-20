abstract InitialAndTerminal = Morphisms ** {

cat  Initial  (c : Category) ;
data initial  : ({c} : Category)
              -> (x : El c)
              -> ((y : El c) -> Arrow x y)
              -> Initial c ;

fun initEl : ({c} : Category)
              -> Initial c
              -> El c ;
def initEl {c} (initial {c} x f) = x ;

fun initials2iso :  ({c} : Category)
                 -> ({x,y} : Initial c)
                 -> Iso (initEl x) (initEl y) ;
-- def initials2iso = .. ;

cat  Terminal (c : Category) ;
data terminal : ({c} : Category)
              -> (y : El c)
              -> ((x : El c) -> Arrow x y)
              -> Terminal c ;

fun termEl : ({c} : Category)
             -> Terminal c
             -> El c ;
def termEl {c} (terminal {c} x f) = x ;

fun terminals2iso :  ({c} : Category)
                  -> ({x,y} : Terminal c)
                  -> Iso (termEl x) (termEl y) ;
-- def terminals2iso = .. ;

}