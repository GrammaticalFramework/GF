--# -path=.:alltenses:prelude

resource CombinatorsMlt = Combinators with 
  (Cat = CatMlt),
  (Structural = StructuralMlt),
  (Constructors = ConstructorsMlt) ;
