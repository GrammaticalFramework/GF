--# -path=.:../abstract:../../prelude

concrete DemonstrativeEng of Demonstrative = 
  CategoriesEng ** DemonstrativeI with 
    (Resource = ResourceEng),
    (Basic  = BasicEng),
    (DemRes = DemResEng) ;
