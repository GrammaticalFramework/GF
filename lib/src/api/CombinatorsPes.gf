--# -path=.:alltenses:prelude

resource CombinatorsPes = Combinators with 
  (Cat = CatPes),
  (Structural = StructuralPes),
  (Constructors = ConstructorsPes) ;
