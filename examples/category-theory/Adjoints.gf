abstract Adjoints = NaturalTransform ** {

cat Adjoints ({c1,c2} : Category) (Functor c1 c2) (Functor c2 c1) ;

data adjoints : ({c1,c2} : Category)
              -> (f : Functor c1 c2)
              -> (g : Functor c2 c1)
              -> NT (idF c1) (compF g f)
              -> Adjoints f g ;

}