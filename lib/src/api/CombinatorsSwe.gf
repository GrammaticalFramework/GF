--# -path=.:alltenses:prelude

resource CombinatorsSwe = Combinators with 
  (Cat = CatSwe),
  (Structural = StructuralSwe),
  (Constructors = ConstructorsSwe) ;
