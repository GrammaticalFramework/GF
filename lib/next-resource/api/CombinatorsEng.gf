--# -path=.:alltenses:prelude

resource CombinatorsEng = Combinators with 
  (Cat = CatEng),
  (Structural = StructuralEng),
  (Constructors = ConstructorsEng) ;
