--# -path=.:../romance:../abstract:../common:../prelude

concrete SymbolCat of Symbol = CatCat ** SymbolRomance with
  (ResRomance = ResCat) ;
