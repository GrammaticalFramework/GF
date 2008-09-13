--# -path=.:alltenses:prelude

resource CombinatorsNor = Combinators with 
  (Cat = CatNor),
  (Structural = StructuralNor),
  (Constructors = ConstructorsNor) ;
