--# -path=.:../abstract:../scandinavian:../../prelude

concrete MultimodalSwe of Multimodal = 
  RulesSwe, StructuralSwe, BasicSwe, TimeSwe, DemonstrativeSwe ** MultimodalI with 
    (Resource = ResourceSwe),
    (Basic  = BasicSwe),
    (Lang   = LangSwe),
    (DemRes = DemResSwe) ;
