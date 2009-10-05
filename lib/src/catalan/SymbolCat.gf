--# -path=.:../romance:../abstract:../common

concrete SymbolCat of Symbol = CatCat ** SymbolRomance with
  (ResRomance = ResCat) ;
