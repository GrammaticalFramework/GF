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

      eq     : ({c} : Category)
             -> ({x,y} : El c)
             -> (a : Arrow x y)
             -> EqAr a a ;
      eqRefl : ({c} : Category)
             -> ({x,y} : El c)
             -> ({a,b} : Arrow x y)
             -> EqAr a b
             -> EqAr b a ;
      eqIdL  : ({c} : Category)
             -> ({x,y} : El c)
             -> (a : Arrow x y)
             -> EqAr a (comp a (id x)) ;
      eqIdR  : ({c} : Category)
             -> ({x,y} : El c)
             -> (a : Arrow x y)
             -> EqAr a (comp (id y) a) ;
      eqComp :  ({c} : Category) 
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
                 -> ({az} : Arrow x y)
                 -> Arrow z y
                 -> Arrow (coslashEl x ay) (coslashEl x az) ;
  def  id (coslashEl x {y} a) = coslashAr x (id y) ;

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
  def  id (prodEl x1 x2) = prodAr (id x1) (id x2) ;
  
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
              -> Arrow (sumLEl x) (sumLEl y) ;
       sumRAr :  ({c1,c2} : Category)
              -> ({x,y} : El c2)
              -> Arrow x y
              -> Arrow (sumREl x) (sumREl y) ;
  def  id (sumLEl x) = sumLAr (id x) ;
       id (sumREl x) = sumRAr (id x) ;

}