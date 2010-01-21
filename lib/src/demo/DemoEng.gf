--# -path=.:alltenses

concrete DemoEng of Demo = LangEng ** 
  open LangEng in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
