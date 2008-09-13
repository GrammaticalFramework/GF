--# -path=.:alltenses:prelude

resource CombinatorsCat = Combinators with 
  (Cat = CatCat),
  (Structural = StructuralCat),
  (Constructors = ConstructorsCat) ;
