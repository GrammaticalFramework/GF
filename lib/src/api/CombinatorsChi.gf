--# -path=.:alltenses:prelude

resource CombinatorsChi = Combinators with 
  (Cat = CatChi),
  (Structural = StructuralChi),
  (Constructors = ConstructorsChi) ;
