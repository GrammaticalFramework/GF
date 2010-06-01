abstract Categories = {

  cat Category ;
      El Category ;
      Arrow ({c} : Category) (El c) (El c) ;
      EqAr ({c} : Category) ({x,y} : El c) (f,g : Arrow x y) ;

  fun dom : ({c} : Category) -> ({x,y} : El c) -> Arrow x y -> El c ;
  def dom   {_} {x} {y} _ = x ;

  fun codom : ({c} : Category) -> ({x,y} : El c) -> Arrow x y -> El c ;
  def codom {_} {x} {y} _ = y ;

  fun id   : ({c} : Category) -> (x : El c) -> Arrow x x ;

  fun comp : ({c} : Category) -> ({x,y,z} : El c) -> Arrow z y -> Arrow x z -> Arrow x y ;

  data eqRefl :  ({c} : Category)
              -> ({x,y} : El c)
              -> (a : Arrow x y)
              -> EqAr a a ;
  fun  eqSym  : ({c} : Category)
              -> ({x,y} : El c)
              -> ({a,b} : Arrow x y)
              -> EqAr a b
              -> EqAr b a ;
  def  eqSym (eqRefl a) = eqRefl a ;

  fun eqTran :  ({c} : Category)
             -> ({x,y} : El c)
             -> ({f,g,h} : Arrow x y)
             -> EqAr f g
             -> EqAr f h
             -> EqAr g h ;
  def eqTran (eqRefl a) eq = eq ;

  fun eqCompL :  ({c} : Category)
              -> ({x,y,z} : El c)
              -> ({g,h} : Arrow x z)
              -> (f : Arrow z y)
              -> EqAr g h
              -> EqAr (comp f g) (comp f h) ;
  def eqCompL f (eqRefl g) = eqRefl (comp f g) ;

  fun eqCompR :  ({c} : Category)
              -> ({x,y,z} : El c)
              -> ({g,h} : Arrow z y)
              -> EqAr g h
              -> (f : Arrow x z)
              -> EqAr (comp g f) (comp h f) ;
  def eqCompR (eqRefl g) f = eqRefl (comp g f) ;

  fun eqIdL  : ({c} : Category)
             -> ({x,y} : El c)
             -> (a : Arrow x y)
             -> EqAr (comp a (id x)) a ;
      eqIdR  :  ({c} : Category)
             -> ({x,y} : El c)
             -> (a : Arrow x y)
             -> EqAr (comp (id y) a) a ;

  fun eqAssoc :  ({c} : Category)
              -> ({w,x,y,z} : El c)
              -> (f : Arrow w y)
              -> (g : Arrow z w)
              -> (h : Arrow x z)
              -> EqAr (comp f (comp g h)) (comp (comp f g) h) ;

  data Op   :  (c : Category)
            -> Category ;
       opEl :  ({c} : Category)
            -> (x : El c)
            -> El (Op c) ;
       opAr :  ({c} : Category)
            -> ({x,y} : El c)
            -> (a : Arrow x y)
            -> Arrow {Op c} (opEl y) (opEl x) ;
  def  id (opEl x) = opAr (id x) ;
  def  comp (opAr f) (opAr g) = opAr (comp g f) ;

  fun eqOp :  ({c} : Category)
           -> ({x,y} : El c)
           -> ({f} : Arrow x y)
           -> ({g} : Arrow x y)
           -> EqAr f g
           -> EqAr (opAr f) (opAr g) ;
  def eqOp (eqRefl f) = eqRefl (opAr f) ;

  data Slash     :  (c : Category)
                 -> (x : El c)
                 -> Category ;
       slashEl   :  ({c} : Category)
                 -> (x,{y} : El c)
                 -> Arrow y x
                 -> El (Slash c x) ;
       slashAr   :  ({c} : Category)
                 -> (x,{y,z} : El c)
                 -> ({ay} : Arrow y x)
                 -> ({az} : Arrow z x)
                 -> Arrow y z
                 -> Arrow (slashEl x ay) (slashEl x az) ;
  def  id (slashEl x {y} a) = slashAr x (id y) ;
  def  comp (slashAr t azy) (slashAr ~t axz) = slashAr t (comp azy axz) ;

  data CoSlash   :  (c : Category)
                 -> (x : El c)
                 -> Category ;
       coslashEl :  ({c} : Category)
                 -> (x,{y} : El c)
                 -> Arrow x y
                 -> El (CoSlash c x) ;
       coslashAr :  ({c} : Category)
                 -> (x,{y,z} : El c)
                 -> ({ay} : Arrow x y)
                 -> ({az} : Arrow x z)
                 -> Arrow z y
                 -> Arrow (coslashEl x ay) (coslashEl x az) ;
  def  id (coslashEl x {y} a) = coslashAr x (id y) ;
  def  comp (coslashAr t ayz) (coslashAr ~t azx) = coslashAr t (comp azx ayz) ;

  data Prod   :  (c1,c2 : Category)
              -> Category ;
       prodEl :  ({c1,c2} : Category)
              -> El c1
              -> El c2
              -> El (Prod c1 c2) ;
       prodAr :  ({c1,c2} : Category)
              -> ({x1,y1} : El c1)
              -> ({x2,y2} : El c2)
              -> Arrow x1 y1
              -> Arrow x2 y2
              -> Arrow (prodEl x1 x2) (prodEl y1 y2) ;
  def id (prodEl x1 x2) = prodAr (id x1) (id x2) ;
  def comp (prodAr f1 f2) (prodAr g1 g2) = prodAr (comp f1 g1) (comp f2 g2) ;

  fun fst : ({c1,c2} : Category) -> El (Prod c1 c2) -> El c1 ;
  def fst (prodEl x1 _) = x1 ;

  fun snd : ({c1,c2} : Category) -> El (Prod c1 c2) -> El c2 ;
  def snd (prodEl _ x2) = x2 ;
  
  data Sum    :  (c1,c2 : Category)
              -> Category ;
       sumLEl :  ({c1,c2} : Category)
              -> El c1
              -> El (Sum c1 c2) ;
       sumREl :  ({c1,c2} : Category)
              -> El c2
              -> El (Sum c1 c2) ;
       sumLAr :  ({c1,c2} : Category)
              -> ({x,y} : El c1)
              -> Arrow x y
              -> Arrow {Sum c1 c2} (sumLEl x) (sumLEl y) ;
       sumRAr :  ({c1,c2} : Category)
              -> ({x,y} : El c2)
              -> Arrow x y
              -> Arrow {Sum c1 c2} (sumREl x) (sumREl y) ;

  def  id (sumLEl x) = sumLAr (id x) ;
       id (sumREl x) = sumRAr (id x) ;

       comp (sumRAr f) (sumRAr g) = sumRAr (comp f g) ;
       comp (sumLAr f) (sumLAr g) = sumLAr (comp f g) ;

}
