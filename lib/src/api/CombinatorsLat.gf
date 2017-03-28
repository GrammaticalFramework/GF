--# -path=.:alltenses:prelude

resource CombinatorsLat = Combinators - [ appCN, appCNc ] with 
  (Cat = CatLat),
  (Structural = StructuralLat),
  (Noun = NounLat),
  (Constructors = ConstructorsLat) ** 
  {}
