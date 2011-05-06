--# -path=.:alltenses:prelude

resource CombinatorsAfr = Combinators with 
  (Cat = CatAfr),
  (Structural = StructuralAfr),
  (Constructors = ConstructorsAfr) ;
