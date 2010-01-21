--# -path=.:alltenses

concrete DemoFin of Demo = LangFin ** 
  open LangFin in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
