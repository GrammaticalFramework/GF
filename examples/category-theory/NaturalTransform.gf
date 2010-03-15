abstract NaturalTransform = Functor ** {

cat NT ({c1,c2} : Category) (f,g : Functor c1 c2) ;

data nt :  ({c1,c2} : Category)
        -> (f,g : Functor c1 c2)
        -> ((x : El c1) -> Arrow (mapEl f x) (mapEl g x))
        -> NT f g ;

}