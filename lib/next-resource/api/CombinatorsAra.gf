--# -path=.:alltenses:prelude

resource CombinatorsAra = Combinators with 
  (Cat = CatAra),
  (Structural = StructuralAra),
  (Constructors = ConstructorsAra) ;
