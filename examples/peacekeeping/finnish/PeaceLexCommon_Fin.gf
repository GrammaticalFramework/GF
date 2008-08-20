--# -path=.:present:prelude

concrete PeaceLexCommon_Fin of PeaceLexCommon = 
  PeaceCat_Fin ** PeaceLexCommonI with 
  (Lang = LangFin), (Constructors = ConstructorsFin) ;

