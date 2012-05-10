--# -path=.:alltenses

concrete DemoRon of Demo = LangRon - [SlashVP] ** 
  open LangRon in {

  lin 
    AdjN ap n = AdjCN ap (UseN n) ;
    AdAdj ad a = AdAP ad (PositA a) ;

}
