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

}
