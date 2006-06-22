--# -path=.:../abstract:../romance:../../prelude

concrete MultimodalFre of Multimodal = 
  RulesFre, StructuralFre, BasicFre, TimeFre, DemonstrativeFre ** MultimodalI with 
    (Resource = ResourceFre),
    (Basic  = BasicFre),
    (Lang   = LangFre),
    (DemRes = DemResFre) ;
