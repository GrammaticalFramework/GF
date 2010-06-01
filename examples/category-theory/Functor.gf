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
           functor (\x -> f032 (f013 x)) (\x -> f132 (f113 x)) (\x -> mapEqAr f132 eqid13) ? ;

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

  fun mapEqAr :  ({c} : Category)
              -> ({x,y} : Obj c)
              -> ({f,g} : Arrow x y)
              -> (func : Arrow x y -> Arrow x y)
              -> EqAr f g
              -> EqAr (func f) (func g) ;
  def mapEqAr func (eqRefl f) = eqRefl (func f) ;

}
