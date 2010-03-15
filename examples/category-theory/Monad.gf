abstract Monad = Adjoints ** {

cat Monad ({c} : Category) (m : Functor c c) ;

data monad :  ({c} : Category)
           -> (m : Functor c c)
           -> NT (compF m m) m
           -> NT (idF c) m
           -> Monad m ;

fun adjoints2monad :  ({c,d} : Category)
                   -> (f : Functor c d)
                   -> (g : Functor d c)
                   -> Adjoints f g
                   -> Monad (compF g f) ;
-- def adjoints2monad = ...

{-
fun kleisliCat :  ({c} : Category)
               -> ({m} : Functor c c)
               -> Monad m
               -> Category ;

fun monad2adjoints :  ({c} : Category)
                   -> ({m} : Functor c c)
                   -> Monad m
                   -> Adjoints {c} {kleisliCat m} f g
-}

}