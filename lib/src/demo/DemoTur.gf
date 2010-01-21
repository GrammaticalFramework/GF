--# -path=.:alltenses

concrete DemoTur of Demo = LangTur ** 
  open LangTur in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
