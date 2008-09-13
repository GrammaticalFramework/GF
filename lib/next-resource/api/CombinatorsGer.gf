--# -path=.:alltenses:prelude

resource CombinatorsGer = Combinators with 
  (Cat = CatGer),
  (Structural = StructuralGer),
  (Constructors = ConstructorsGer) ;
