--# -path=.:alltenses

concrete DemoCat of Demo = LangCat ** 
  open LangCat in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
