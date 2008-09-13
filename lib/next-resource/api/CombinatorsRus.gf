--# -path=.:alltenses:prelude

resource CombinatorsRus = Combinators with 
  (Cat = CatRus),
  (Structural = StructuralRus),
  (Constructors = ConstructorsRus) ;
