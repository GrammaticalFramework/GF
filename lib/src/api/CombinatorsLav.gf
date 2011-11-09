--# -path=.:alltenses:prelude

resource CombinatorsLav = Combinators with 
  (Cat = CatLav),
  (Structural = StructuralLav),
  (Constructors = ConstructorsLav) ;
