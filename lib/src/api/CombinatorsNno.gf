--# -path=.:alltenses:prelude

resource CombinatorsNno = Combinators with 
  (Cat = CatNno),
  (Structural = StructuralNno),
  (Constructors = ConstructorsNno) ;
