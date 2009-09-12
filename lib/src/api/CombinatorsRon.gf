--# -path=.:alltenses:prelude

resource CombinatorsRon = Combinators with 
  (Cat = CatRon),
  (Structural = StructuralRon),
  (Constructors = ConstructorsRon) ;
