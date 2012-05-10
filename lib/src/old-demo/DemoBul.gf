--# -path=.:alltenses

concrete DemoBul of Demo = LangBul ** 
  open LangBul in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
