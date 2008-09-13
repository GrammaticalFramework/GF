--# -path=.:alltenses:prelude

resource CombinatorsIna = Combinators with 
  (Cat = CatIna),
  (Structural = StructuralIna),
  (Constructors = ConstructorsIna) ;
