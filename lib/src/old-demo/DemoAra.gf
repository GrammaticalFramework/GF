--# -path=.:alltenses

concrete DemoAra of Demo = LangAra ** 
  open LangAra in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
