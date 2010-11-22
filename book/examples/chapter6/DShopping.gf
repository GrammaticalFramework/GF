abstract DShopping = {
  flags startcat = Comment ;
  cat
    Comment ; 
    Dom ;
    Item Dom ; 
    Kind Dom ; 
    Quality Dom ;
  fun
    DFood, DCloth : Dom ;

    Pred : (d : Dom) -> Item d -> Quality d -> Comment ;
    This, That : (d : Dom) -> Kind d -> Item d ;
    Mod : (d : Dom) -> Quality d -> Kind d -> Kind d ;
    Wine, Cheese, Fish : Kind DFood ;
    Very : (d : Dom) -> Quality d -> Quality d ;
    Fresh, Warm, Delicious, Boring : Quality DFood ;

    Shirt, Jacket : Kind DCloth ;
    Comfortable : Quality DCloth ;

    Italian, Expensive, Elegant : (d : Dom) -> Quality d ;

}
