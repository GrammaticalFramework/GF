--# -path=.:alltenses

concrete DemoSwe of Demo = LangSwe ** 
  open LangSwe in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
