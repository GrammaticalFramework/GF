--# -path=.:alltenses:prelude

resource CombinatorsFre = Combinators with 
  (Cat = CatFre),
  (Structural = StructuralFre),
  (Constructors = ConstructorsFre) ;
