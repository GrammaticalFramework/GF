--# -path=.:alltenses

concrete DemoRus of Demo = LangRus ** 
  open LangRus in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
