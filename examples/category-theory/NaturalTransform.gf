abstract NaturalTransform = Functor ** {

cat NT ({c1,c2} : Category) (f,g : Functor c1 c2) ;

data nt :  ({c1,c2} : Category)
        -> (f,g : Functor c1 c2)
        -> ((x : Obj c1) -> Arrow (mapObj f x) (mapObj g x))
        -> NT f g ;

}
