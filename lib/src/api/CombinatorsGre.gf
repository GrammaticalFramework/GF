--# -path=.:alltenses:prelude

resource CombinatorsGre = Combinators with 
  (Cat = CatGre),
  (Structural = StructuralGre),
  (Constructors = ConstructorsGre) ;
