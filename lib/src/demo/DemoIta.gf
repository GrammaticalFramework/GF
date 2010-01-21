--# -path=.:alltenses

concrete DemoIta of Demo = LangIta ** 
  open LangIta in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
