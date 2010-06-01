abstract Morphisms = Categories ** {

cat Iso ({c} : Category) ({x,y} : El c) (Arrow x y) (Arrow y x) ;

data iso :  ({c} : Category)
         -> ({x,y} : El c)
         -> (f : Arrow x y)
         -> (g : Arrow y x)
         -> (EqAr (comp f g) (id y))
         -> (EqAr (comp g f) (id x))
         -> Iso f g ;

fun isoOp : ({c} : Category)
         -> ({x,y} : El c)
         -> ({f} : Arrow x y)
         -> ({g} : Arrow y x)
         -> Iso f g
         -> Iso (opAr g) (opAr f) ;
def isoOp (iso f g id_fg id_gf) = iso (opAr g) (opAr f) (eqOp id_fg) (eqOp id_gf) ;

fun iso2mono :  ({c} : Category)
             -> ({x,y} : El c)
             -> ({f} : Arrow x y)
             -> ({g} : Arrow y x)
             -> (Iso f g -> Mono f) ;
def iso2mono (iso f g id_fg id_gf) = 
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
             -> ({f} : Arrow x y)
             -> ({g} : Arrow y x)
             -> (Iso f g -> Epi f) ;

def iso2epi (iso fff g id_fg id_gf) =
        epi f (\h,m,eq_hf_mf -> 
                      eqSym (eqTran (eqIdL m)                                                                     --           h = m
                                    (eqTran (eqCompL m id_fg)                                                     --      m . id = h
                                            (eqTran (eqSym (eqAssoc m f g))                                       -- m . (f . g) = h
                                                    (eqSym (eqTran (eqIdL h)                                      -- (m . f) . g = h
                                                                   (eqTran (eqCompL h id_fg)                      --      h . id = (m . f) . g
                                                                           (eqTran (eqSym (eqAssoc h f g))        -- h . (f . g) = (m . f) . g
                                                                                   (eqCompR eq_hf_mf g))))))))) ; -- (h . f) . g = (m . f) . g
                                                                                                                  --  h . f      =  m . f

cat Mono ({c} : Category) ({x,y} : El c) (Arrow x y) ;

data mono :  ({c} : Category)
          -> ({x,y} : El c)
          -> (f : Arrow x y)
          -> (({z} : El c) -> (h,m : Arrow z x) -> EqAr (comp f h) (comp f m) -> EqAr h m)
          -> Mono f ;

cat Epi ({c} : Category) ({x,y} : El c) (Arrow x y) ;

data epi  :  ({c} : Category)
          -> ({x,y} : El c)
          -> (f : Arrow x y)
          -> (({z} : El c) -> (h,m : Arrow y z) -> EqAr (comp h f) (comp m f) -> EqAr h m)
          -> Epi f ;

}
