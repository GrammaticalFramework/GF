--# -path=.:alltenses

resource CombinatorsSpa = Combinators with 
  (Cat = CatSpa),
  (Structural = StructuralSpa),
  (Constructors = ConstructorsSpa) ;
