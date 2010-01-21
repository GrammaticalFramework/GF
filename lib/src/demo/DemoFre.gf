--# -path=.:alltenses

concrete DemoFre of Demo = LangFre ** 
  open LangFre in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
