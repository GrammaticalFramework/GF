--# -path=.:alltenses:prelude

resource CombinatorsFin = Combinators with 
  (Cat = CatFin),
  (Structural = StructuralFin),
  (Constructors = ConstructorsFin) ;
