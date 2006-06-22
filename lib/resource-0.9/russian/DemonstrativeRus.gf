--# -path=.:../abstract:../../prelude

concrete DemonstrativeRus of Demonstrative = 
  CategoriesRus ** DemonstrativeI with 
    (Resource = ResourceRus),
    (Basic  = BasicRus),
    (DemRes = DemResRus) ;
