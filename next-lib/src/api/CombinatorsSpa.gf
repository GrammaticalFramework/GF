--# -path=.:alltenses:prelude

resource CombinatorsSpa = Combinators with 
  (Cat = CatSpa),
  (Structural = StructuralSpa),
  (Constructors = ConstructorsSpa) ;
