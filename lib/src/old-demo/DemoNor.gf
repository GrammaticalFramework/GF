--# -path=.:alltenses

concrete DemoNor of Demo = LangNor ** 
  open LangNor in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
