abstract NaturalTransform = Functor ** {

  ----------------------------------------------------------
  -- Natural transformation - a pair of functors which 
  -- differ up to an arrow

  cat NT ({c1,c2} : Category) (f,g : Functor c1 c2) ;

  data nt :  ({c1,c2} : Category)
          -> (f,g : Functor c1 c2)
          -> (n : (x : Obj c1) -> Arrow (mapObj f x) (mapObj g x))
          -> (  ({x,y} : Obj c1)
             -> (ar : Arrow x y)
             -> EqAr (comp (n y) (mapAr f ar))
                     (comp (mapAr g ar) (n x))
             )
          -> NT f g ;

}
