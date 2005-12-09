--# -path=.:resource/abstract:resource/english:prelude

concrete TramEng of Tram = TramI with 
  (Multimodal = MultimodalEng), 
  (Math = MathEng) ;
