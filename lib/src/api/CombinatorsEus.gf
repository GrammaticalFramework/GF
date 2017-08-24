--# -path=.:alltenses:prelude:../basque

resource CombinatorsEus = Combinators with 
  (Cat = CatEus),
  (Structural = StructuralEus),
  (Noun = NounEus),
  (Constructors = ConstructorsEus) ** {} ;
