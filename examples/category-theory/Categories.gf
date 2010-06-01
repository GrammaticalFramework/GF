abstract Categories = {

  cat Category ;
      Obj Category ;
      Arrow ({c} : Category) (Obj c) (Obj c) ;
      EqAr ({c} : Category) ({x,y} : Obj c) (f,g : Arrow x y) ;

  fun dom : ({c} : Category) -> ({x,y} : Obj c) -> Arrow x y -> Obj c ;
  def dom   {_} {x} {y} _ = x ;

  fun codom : ({c} : Category) -> ({x,y} : Obj c) -> Arrow x y -> Obj c ;
  def codom {_} {x} {y} _ = y ;

  fun id   : ({c} : Category) -> (x : Obj c) -> Arrow x x ;

  fun comp : ({c} : Category) -> ({x,y,z} : Obj c) -> Arrow z y -> Arrow x z -> Arrow x y ;

  data eqRefl :  ({c} : Category)
              -> ({x,y} : Obj c)
              -> (a : Arrow x y)
              -> EqAr a a ;
  fun  eqSym  : ({c} : Category)
              -> ({x,y} : Obj c)
              -> ({a,b} : Arrow x y)
              -> EqAr a b
              -> EqAr b a ;
  def  eqSym (eqRefl a) = eqRefl a ;

  fun eqTran :  ({c} : Category)
             -> ({x,y} : Obj c)
             -> ({f,g,h} : Arrow x y)
             -> EqAr f g
             -> EqAr f h
             -> EqAr g h ;
  def eqTran (eqRefl a) eq = eq ;

  fun eqCompL :  ({c} : Category)
              -> ({x,y,z} : Obj c)
              -> ({g,h} : Arrow x z)
              -> (f : Arrow z y)
              -> EqAr g h
              -> EqAr (comp f g) (comp f h) ;
  def eqCompL f (eqRefl g) = eqRefl (comp f g) ;

  fun eqCompR :  ({c} : Category)
              -> ({x,y,z} : Obj c)
              -> ({g,h} : Arrow z y)
              -> EqAr g h
              -> (f : Arrow x z)
              -> EqAr (comp g f) (comp h f) ;
  def eqCompR (eqRefl g) f = eqRefl (comp g f) ;

  fun eqIdL  : ({c} : Category)
             -> ({x,y} : Obj c)
             -> (a : Arrow x y)
             -> EqAr (comp a (id x)) a ;
      eqIdR  :  ({c} : Category)
             -> ({x,y} : Obj c)
             -> (a : Arrow x y)
             -> EqAr (comp (id y) a) a ;

  fun eqAssoc :  ({c} : Category)
              -> ({w,x,y,z} : Obj c)
              -> (f : Arrow w y)
              -> (g : Arrow z w)
              -> (h : Arrow x z)
              -> EqAr (comp f (comp g h)) (comp (comp f g) h) ;

  data Op   :  (c : Category)
            -> Category ;
       opObj:  ({c} : Category)
            -> (x : Obj c)
            -> Obj (Op c) ;
       opAr :  ({c} : Category)
            -> ({x,y} : Obj c)
            -> (a : Arrow x y)
            -> Arrow {Op c} (opObj y) (opObj x) ;
  def  id (opObj x) = opAr (id x) ;
  def  comp (opAr f) (opAr g) = opAr (comp g f) ;

  fun eqOp :  ({c} : Category)
           -> ({x,y} : Obj c)
           -> ({f} : Arrow x y)
           -> ({g} : Arrow x y)
           -> EqAr f g
           -> EqAr (opAr f) (opAr g) ;
  def eqOp (eqRefl f) = eqRefl (opAr f) ;

  data Slash     :  (c : Category)
                 -> (x : Obj c)
                 -> Category ;
       slashObj  :  ({c} : Category)
                 -> (x,{y} : Obj c)
                 -> Arrow y x
                 -> Obj (Slash c x) ;
       slashAr   :  ({c} : Category)
                 -> (x,{y,z} : Obj c)
                 -> ({ay} : Arrow y x)
                 -> ({az} : Arrow z x)
                 -> Arrow y z
                 -> Arrow (slashObj x ay) (slashObj x az) ;
  def  id (slashObj x {y} a) = slashAr x (id y) ;
  def  comp (slashAr t azy) (slashAr ~t axz) = slashAr t (comp azy axz) ;

  data CoSlash   :  (c : Category)
                 -> (x : Obj c)
                 -> Category ;
       coslashObj:  ({c} : Category)
                 -> (x,{y} : Obj c)
                 -> Arrow x y
                 -> Obj (CoSlash c x) ;
       coslashAr :  ({c} : Category)
                 -> (x,{y,z} : Obj c)
                 -> ({ay} : Arrow x y)
                 -> ({az} : Arrow x z)
                 -> Arrow z y
                 -> Arrow (coslashObj x ay) (coslashObj x az) ;
  def  id (coslashObj x {y} a) = coslashAr x (id y) ;
  def  comp (coslashAr t ayz) (coslashAr ~t azx) = coslashAr t (comp azx ayz) ;

  data Prod   :  (c1,c2 : Category)
              -> Category ;
       prodObj:  ({c1,c2} : Category)
              -> Obj c1
              -> Obj c2
              -> Obj (Prod c1 c2) ;
       prodAr :  ({c1,c2} : Category)
              -> ({x1,y1} : Obj c1)
              -> ({x2,y2} : Obj c2)
              -> Arrow x1 y1
              -> Arrow x2 y2
              -> Arrow (prodObj x1 x2) (prodObj y1 y2) ;
  def id (prodObj x1 x2) = prodAr (id x1) (id x2) ;
  def comp (prodAr f1 f2) (prodAr g1 g2) = prodAr (comp f1 g1) (comp f2 g2) ;

  fun fst : ({c1,c2} : Category) -> Obj (Prod c1 c2) -> Obj c1 ;
  def fst (prodObj x1 _) = x1 ;

  fun snd : ({c1,c2} : Category) -> Obj (Prod c1 c2) -> Obj c2 ;
  def snd (prodObj _ x2) = x2 ;
  
  data Sum    :  (c1,c2 : Category)
              -> Category ;
       sumLObj:  ({c1,c2} : Category)
              -> Obj c1
              -> Obj (Sum c1 c2) ;
       sumRObj:  ({c1,c2} : Category)
              -> Obj c2
              -> Obj (Sum c1 c2) ;
       sumLAr :  ({c1,c2} : Category)
              -> ({x,y} : Obj c1)
              -> Arrow x y
              -> Arrow {Sum c1 c2} (sumLObj x) (sumLObj y) ;
       sumRAr :  ({c1,c2} : Category)
              -> ({x,y} : Obj c2)
              -> Arrow x y
              -> Arrow {Sum c1 c2} (sumRObj x) (sumRObj y) ;

  def  id (sumLObj x) = sumLAr (id x) ;
       id (sumRObj x) = sumRAr (id x) ;

       comp (sumRAr f) (sumRAr g) = sumRAr (comp f g) ;
       comp (sumLAr f) (sumLAr g) = sumLAr (comp f g) ;

}
