--# -path=.:alltenses

concrete DemoIna of Demo = LangIna ** 
  open LangIna in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
