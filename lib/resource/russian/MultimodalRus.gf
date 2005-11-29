--# -path=.:../abstract:../scandinavian:../../prelude

concrete MultimodalRus of Multimodal = 
  RulesRus, StructuralRus, BasicRus, TimeRus, DemonstrativeRus ** MultimodalI with 
    (Resource = ResourceRus),
    (Basic  = BasicRus),
    (Lang   = LangRus),
    (DemRes = DemResRus) ;
