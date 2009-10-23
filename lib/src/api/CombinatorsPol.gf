--# -path=.:alltenses:prelude

resource CombinatorsPol = Combinators with 
  (Cat = CatPol),
  (Structural = StructuralPol),
  (Constructors = ConstructorsPol) ;
