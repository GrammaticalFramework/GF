abstract Equalizer = Morphisms ** {

cat Equalizer ({c} : Category) ({x,y,z} : El c) (f,g : Arrow x y) (e : Arrow z x) ;

data equalizer :  ({c} : Category)
               -> ({x,y,z} : El c)
               -> (f,g : Arrow x y)
               -> (e : Arrow z x)
               -> EqAr (comp f e) (comp g e)
               -> Equalizer f g e ;

fun idEqualizer : ({c} : Category)
               -> ({x,y} : El c)
               -> (f : Arrow x y)
               -> Equalizer f f (id x) ;
def idEqualizer {c} {x} {y} f = equalizer f f (id x) (eqCompL f (eqRefl (id x))) ;

fun equalizer2mono :  ({c} : Category)
                   -> ({x,y,z} : El c)
                   -> (f,g : Arrow x y)
                   -> (e : Arrow z x)
                   -> Equalizer f g e
                   -> Mono e ;
-- def equalizer2mono = ...

cat CoEqualizer ({c} : Category) ({x,y,z} : El c) (e : Arrow y z) (f,g : Arrow x y) ;

data coequalizer :  ({c} : Category)
                 -> ({x,y,z} : El c)
                 -> (e : Arrow y z)
                 -> (f,g : Arrow x y)
                 -> EqAr (comp e f) (comp e g)
                 -> CoEqualizer e f g ;

fun idCoEqualizer : ({c} : Category)
                 -> ({x,y} : El c)
                 -> (f : Arrow x y)
                 -> CoEqualizer (id y) f f ;
def idCoEqualizer {c} {x} {y} f = coequalizer (id y) f f (eqCompR (eqRefl (id y)) f) ;

fun coequalizer2epi :  ({c} : Category)
                    -> ({x,y,z} : El c)
                    -> ({e} : Arrow y z)
                    -> ({f,g} : Arrow x y)
                    -> CoEqualizer e f g
                    -> Epi e ;
-- def coequalizer2epi = ...

}