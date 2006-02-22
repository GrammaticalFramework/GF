--# -path=.:compiled:prelude

concrete TramEng of Tram = TramI with 
  (Multimodal = MultimodalEng),
  (Symbol = SymbolEng) ;
