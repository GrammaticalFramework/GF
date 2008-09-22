--# -path=.:alltenses:prelude

resource CombinatorsIta = Combinators with 
  (Cat = CatIta),
  (Structural = StructuralIta),
  (Constructors = ConstructorsIta) ;
