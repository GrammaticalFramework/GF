--# -path=.:alltenses:prelude

resource CombinatorsUrd = Combinators with 
  (Cat = CatUrd),
  (Structural = StructuralUrd),
  (Constructors = ConstructorsUrd) ;
