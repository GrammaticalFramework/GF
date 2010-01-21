--# -path=.:alltenses

concrete DemoTha of Demo = LangTha ** 
  open LangTha in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
