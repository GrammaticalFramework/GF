concrete AdjectiveSlv of Adjective = CatSlv ** open ResSlv in {

  lin
    PositA a = {
      s = \\spec,g,c,n => 
        case <spec,g,n,c> of {
          <Def,AMasc _,    Sg,Nom> => a.s ! APositDefNom ;
          <Def,AMasc _,    Sg,Acc> => a.s ! APositDefNom ;
          <_,AMasc Animate,Sg,Acc> => a.s ! APosit Masc Sg Gen ;
          _                        => a.s ! APosit (agender2gender g) n c
        }
      } ;
    UseComparA a = {
      s = \\spec,g,c,n => 
        case <spec,g,n,c> of {
          <Def,AMasc _,Sg,Acc> => a.s ! AComparDefAcc ;
          _                    => a.s ! ACompar (agender2gender g) n c
        }
      } ;

    AdAP ada ap = {
      s = \\spec,g,c,n => ada.s ++ ap.s ! spec ! g ! c ! n
      } ;

    AdvAP ap adv = {s = \\spec,g,c,n => ap.s ! spec ! g ! c ! n ++ adv.s} ;
}
