--# -path=.:alltenses

concrete DemoHin of Demo = LangHin ** 
  open LangHin in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
