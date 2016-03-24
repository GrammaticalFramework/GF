concrete AdjectiveSlv of Adjective = CatSlv ** open ResSlv in {

  lin
    PositA a = {
      s = \\spec,g,c,n => 
        case <spec,c> of {
          <Def,Nom> => a.s ! APositDefNom ;
          <Def,Acc> => a.s ! APositDefAcc ;
          _         => a.s ! APosit g n c
        }
      } ;

}
