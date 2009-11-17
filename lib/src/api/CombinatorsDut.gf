--# -path=.:alltenses:prelude

resource CombinatorsDut = Combinators with 
  (Cat = CatDut),
  (Structural = StructuralDut),
  (Constructors = ConstructorsDut) ;
