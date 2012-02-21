--# -path=.:alltenses:prelude

resource CombinatorsSnd = Combinators with 
  (Cat = CatSnd),
  (Structural = StructuralSnd),
  (Constructors = ConstructorsSnd) ;
