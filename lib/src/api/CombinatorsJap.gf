--# -path=.:alltenses:prelude

resource CombinatorsJap = Combinators with 
  (Cat = CatJap),
  (Structural = StructuralJap),
  (Constructors = ConstructorsJap) ;
