--# -path=.:alltenses:prelude

resource CombinatorsPnb = Combinators with 
  (Cat = CatPnb),
  (Structural = StructuralPnb),
  (Constructors = ConstructorsPnb) ;
