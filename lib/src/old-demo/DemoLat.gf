--# -path=.:alltenses

concrete DemoLat of Demo = LangLat ** 
  open LangLat in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
