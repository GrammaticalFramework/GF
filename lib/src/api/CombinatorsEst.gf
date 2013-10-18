--# -path=.:alltenses:prelude

resource CombinatorsEst = Combinators with 
  (Cat = CatEst),
  (Structural = StructuralEst),
  (Constructors = ConstructorsEst) ;
