--# -path=.:alltenses

concrete DemoDut of Demo = LangDut ** 
  open LangDut in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
