abstract Morphisms = Categories ** {

cat Iso ({c} : Category) (x,y : El c) ;

data iso :  ({c} : Category)
         -> ({x,y} : El c)
         -> (f : Arrow x y)
         -> (g : Arrow y x)
         -> (EqAr (comp f g) (id y))
         -> (EqAr (comp g f) (id x))
         -> Iso x y ;

fun iso2mono :  ({c} : Category)
             -> ({x,y} : El c)
             -> (Iso x y -> Mono x y) ;
-- def iso2mono (iso f g eq_fg eq_gf) = (mono f (\h m eq_fh_fm -> ...))

-- eqIdR (eqTran eq_gf (eqComp g f h)) : EqAr (comp g (comp f h)) h
-- comp g (comp f m)

fun iso2epi  :  ({c} : Category)
             -> ({x,y} : El c)
             -> (Iso x y -> Epi x y) ;
-- def iso2epi (iso f g eq_fg eq_gf) = (epi f (\h m eq_hf_mf -> ...))


cat Mono ({c} : Category) (x,y : El c) ;

data mono :  ({c} : Category)
          -> ({x,y} : El c)
          -> (f : Arrow x y)
          -> (({z} : El c) -> (h,m : Arrow z x) -> EqAr (comp f h) (comp f m) -> EqAr h m)
          -> Mono x y ;


cat Epi ({c} : Category) (x,y : El c) ;

data epi  :  ({c} : Category)
          -> ({x,y} : El c)
          -> (f : Arrow x y)
          -> (({z} : El c) -> (h,m : Arrow y z) -> EqAr (comp h f) (comp m f) -> EqAr h m)
          -> Epi x y ;

}