--# -path=.:alltenses:prelude

resource CombinatorsNep = Combinators with 
  (Cat = CatNep),
  (Structural = StructuralNep),
  (Constructors = ConstructorsNep) ;
