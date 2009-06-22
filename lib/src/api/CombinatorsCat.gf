--# -path=.:alltenses

resource CombinatorsCat = Combinators with 
  (Cat = CatCat),
  (Structural = StructuralCat),
  (Constructors = ConstructorsCat) ;
