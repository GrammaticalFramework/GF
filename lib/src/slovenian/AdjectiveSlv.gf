concrete AdjectiveSlv of Adjective = CatSlv ** open ResSlv in {

  lin
    PositA a = {
      s = \\spec,g,c,n => 
        case <spec,g,n,c> of {
          <Def,Masc,Sg,Nom> => a.s ! APositDefNom ;
          <Def,Masc,Sg,Acc> => a.s ! APositDefAcc ;
          _                 => a.s ! APosit g n c
        }
      } ;
    UseComparA a = {
      s = \\spec,g,c,n => 
        case <spec,g,n,c> of {
          <Def,Masc,Sg,Acc> => a.s ! AComparDefAcc ;
          _                 => a.s ! ACompar g n c
        }
      } ;

    AdAP ada ap = {
      s = \\spec,g,c,n => ada.s ++ ap.s ! spec ! g ! c ! n
      } ;

    AdvAP ap adv = {s = \\spec,g,c,n => ap.s ! spec ! g ! c ! n ++ adv.s} ;
}
