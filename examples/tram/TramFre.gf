--# -path=.:compiled:prelude

-- --# -path=.:resource-1.0/abstract:resource-1.0/french:resource-1.0/common:resource-1.0/multimodal:resource-1.0/romance:prelude:resource-1.0/mathematical

concrete TramFre of Tram = TramI with 
  (Multimodal = MultimodalFre), 
  (Symbol = SymbolFre) ;
