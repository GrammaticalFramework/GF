--# -path=.:alltenses

concrete DemoDan of Demo = LangDan ** 
  open LangDan in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
