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
def iso2mono {c} {x} {y} (iso {c} {x} {y} f g id_fg id_gf) = 
        mono f (\h,m,eq_fh_fm -> 
                      eqSym (eqTran (eqIdR m)                                                                      --           h = m
                                    (eqTran (eqCompR id_gf m)                                                      --      id . m = h
                                            (eqTran (eqAssoc g f m)                                                -- (g . f) . m = h
                                                    (eqSym (eqTran (eqIdR h)                                       -- g . (f . m) = h
                                                                   (eqTran (eqCompR id_gf h)                       --      id . h = g . (f . m)
                                                                           (eqTran (eqAssoc g f h)                 -- (g . f) . h = g . (f . m)
                                                                                   (eqCompL g eq_fh_fm))))))))) ;  -- g . (f . h) = g . (f . m)
                                                                                                                   --      f . h  = f . m

fun iso2epi  :  ({c} : Category)
             -> ({x,y} : El c)
             -> (Iso x y -> Epi x y) ;
def iso2epi {c} {x} {y} (iso {c} {x} {y} f g id_fg id_gf) =
        epi {c} {x} {y} f (\{z},h,m,eq_hf_mf -> 
                      eqSym (eqTran (eqIdL m)                                                                     --           h = m
                                    (eqTran (eqCompL m id_fg)                                                     --      m . id = h
                                            (eqTran (eqSym (eqAssoc m f g))                                       -- m . (f . g) = h
                                                    (eqSym (eqTran (eqIdL h)                                      -- (m . f) . g = h
                                                                   (eqTran (eqCompL h id_fg)                      --      h . id = (m . f) . g
                                                                           (eqTran (eqSym (eqAssoc h f g))        -- h . (f . g) = (m . f) . g
                                                                                   (eqCompR eq_hf_mf g))))))))) ; -- (h . f) . g = (m . f) . g
                                                                                                                  --  h . f      =  m . f

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