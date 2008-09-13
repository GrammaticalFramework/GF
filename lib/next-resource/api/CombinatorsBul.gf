--# -path=.:alltenses:prelude

resource CombinatorsBul = Combinators with 
  (Cat = CatBul),
  (Structural = StructuralBul),
  (Constructors = ConstructorsBul) ;
