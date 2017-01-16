--# -path=.:alltenses:prelude

resource CombinatorsIce = Combinators - [ appCN, appCNc ] with 
  (Cat = CatIce),
  (Structural = StructuralIce),
  (Noun = NounIce),
  (Constructors = ConstructorsIce) ** 
  {}
