--# -path=.:alltenses:prelude

resource CombinatorsDan = Combinators with 
  (Cat = CatDan),
  (Structural = StructuralDan),
  (Constructors = ConstructorsDan) ;
