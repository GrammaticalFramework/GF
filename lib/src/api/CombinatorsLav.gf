--# -path=.:alltenses:prelude:../latvian

resource CombinatorsLav = Combinators with
  (Cat = CatLav),
  (Structural = StructuralLav),
  (Constructors = ConstructorsLav) ;
