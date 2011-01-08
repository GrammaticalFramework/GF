abstract Functor = Categories ** {

  ----------------------------------------------------------
  -- Functor - an arrow (a morphism) between two categories
  --
  -- The functor is defined by two morphisms - one for the
  -- objects and one for the arrows. We also require that
  -- the morphisms preserve the categorial structure.

  cat Functor (c1, c2 : Category) ;

  data functor :  ({c1, c2} : Category) 
               -> (f0 : Obj c1 -> Obj c2)
               -> (f1 : ({x,y} : Obj c1) -> Arrow x y -> Arrow (f0 x) (f0 y))
               -> ((x : Obj c1) -> EqAr (f1 (id x)) (id (f0 x)))
               -> (({x,y,z} : Obj c1) -> (f : Arrow x z) -> (g : Arrow z y) -> EqAr (f1 (comp g f)) (comp (f1 g) (f1 f)))
               -> Functor c1 c2 ;

  -- identity functor
  fun idF : (c : Category) -> Functor c c ;
  def idF c = functor (\x->x) (\f->f) (\x -> eqRefl (id x)) (\f,g -> eqRefl (comp g f)) ;

  -- composition of two functors
  fun compF : ({c1,c2,c3} : Category) -> Functor c3 c2 -> Functor c1 c3 -> Functor c1 c2 ;
  def compF (functor f032 f132 eqid32 eqcmp32) (functor f013 f113 eqid13 eqcmp13) =
           functor (\x -> f032 (f013 x))
                   (\x -> f132 (f113 x))
                   (\x -> eqTran (eqSym (mapEqAr f032 f132 (eqid13 x))) (eqid32 (f013 x)))
                   (\f,g -> eqTran (eqSym (mapEqAr f032 f132 (eqcmp13 f g))) (eqcmp32 (f113 f) (f113 g))) ;

  fun mapObj :  ({c1, c2} : Category)
            -> Functor c1 c2
            -> Obj c1
            -> Obj c2 ;
  def mapObj (functor f0 f1 _ _) = f0 ;

  fun mapAr :  ({c1, c2} : Category)
            -> ({x,y} : Obj c1)
            -> (f : Functor c1 c2)
            -> Arrow x y
            -> Arrow (mapObj f x) (mapObj f y) ;
  def mapAr (functor f0 f1 _ _) = f1 ;

  fun mapEqAr :  ({c1,c2} : Category)
              -> ({x,y} : Obj c1)
              -> ({f,g} : Arrow x y)
              -> (f0 : Obj c1 -> Obj c2)
              -> (f1 : Arrow x y -> Arrow (f0 x) (f0 y))
              -> EqAr f g
              -> EqAr (f1 f) (f1 g) ;
  def mapEqAr f0 f1 (eqRefl f) = eqRefl (f1 f) ;

}
