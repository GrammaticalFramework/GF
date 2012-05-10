--# -path=.:alltenses

concrete DemoPol of Demo = LangPol ** 
  open LangPol in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
