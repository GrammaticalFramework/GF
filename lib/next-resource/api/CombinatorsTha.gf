--# -path=.:alltenses:prelude

resource CombinatorsTha = Combinators with 
  (Cat = CatTha),
  (Structural = StructuralTha),
  (Constructors = ConstructorsTha) ;
