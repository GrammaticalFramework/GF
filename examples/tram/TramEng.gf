--# -path=.:resource-1.0/abstract:resource-1.0/common:resource-1.0/multimodal:resource-1.0/english:prelude

concrete TramEng of Tram = TramI with 
  (Multimodal = MultimodalEng),
  (Math = MathEng) ;
