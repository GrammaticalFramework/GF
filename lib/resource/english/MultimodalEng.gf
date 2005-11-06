--# -path=.:../abstract:../../prelude

concrete MultimodalEng of Multimodal = 
  RulesEng, StructuralEng, BasicEng, TimeEng, DemonstrativeEng ** MultimodalI with 
    (Resource = ResourceEng),
    (Basic  = BasicEng),
    (Lang   = LangEng),
    (DemRes = DemResEng) ;
