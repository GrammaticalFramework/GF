--# -path=.:alltenses:prelude

resource CombinatorsHin = Combinators with 
  (Cat = CatHin),
  (Structural = StructuralHin),
  (Constructors = ConstructorsHin) ;
