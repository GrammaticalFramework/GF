--# -path=.:alltenses:prelude

resource CombinatorsJpn = Combinators with 
  (Cat = CatJpn),
  (Structural = StructuralJpn),
  (Constructors = ConstructorsJpn) ;
