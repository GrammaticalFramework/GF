--# -path=.:alltenses

concrete DemoUrd of Demo = LangUrd ** 
  open LangUrd in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
