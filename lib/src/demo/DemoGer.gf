--# -path=.:alltenses

concrete DemoGer of Demo = LangGer ** 
  open LangGer in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
