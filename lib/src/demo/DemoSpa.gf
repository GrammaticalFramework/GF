--# -path=.:alltenses

concrete DemoSpa of Demo = LangSpa ** 
  open LangSpa in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
