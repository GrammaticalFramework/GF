resource DemRes = open Prelude in {

  oper

    Point : Type = 
      {point : Str} ;

    point : Point -> Str = \p ->
      p.point ;
 
    mkPoint : Str -> Point = \s -> 
      {point = s} ;

    noPoint : Point = 
      mkPoint [] ;

    concatPoint : (x,y : Point) -> Point = \x,y -> 
      mkPoint (point x ++ point y) ;

-- A type is made demonstrative by adding $Point$.

    Dem : Type -> Type = \t -> t ** Point ;

    mkDem : (t : Type) -> t -> Point -> Dem t = \_,x,s ->
      x ** s ;

    nonDem : (t : Type) -> t -> Dem t = \t,x ->
      mkDem t x noPoint ;


}
